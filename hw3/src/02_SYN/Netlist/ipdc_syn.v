/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Tue Dec  7 03:01:16 2021
/////////////////////////////////////////////////////////////


module ipdc ( i_clk, i_rst_n, i_op_valid, i_op_mode, o_op_ready, i_in_valid, 
        i_in_data, o_in_ready, o_out_valid, o_out_data );
  input [3:0] i_op_mode;
  input [23:0] i_in_data;
  output [23:0] o_out_data;
  input i_clk, i_rst_n, i_op_valid, i_in_valid;
  output o_op_ready, o_in_ready, o_out_valid;
  wire   op_valid, op_ready_nxt, N309, N310, N311, cens_start, N446, N447,
         N448, N449, N450, N451, N452, N453, out_valid_nxt, out_valid, N653,
         census_N2, census_N1, census_N0, sorter_sort_B_r_8__0_,
         sorter_sort_B_r_8__1_, sorter_sort_B_r_8__2_, sorter_sort_B_r_8__3_,
         sorter_sort_B_r_8__4_, sorter_sort_B_r_8__5_, sorter_sort_B_r_8__6_,
         sorter_sort_B_r_8__7_, sorter_sort_B_r_7__0_, sorter_sort_B_r_7__1_,
         sorter_sort_B_r_7__2_, sorter_sort_B_r_7__3_, sorter_sort_B_r_7__4_,
         sorter_sort_B_r_7__5_, sorter_sort_B_r_7__6_, sorter_sort_B_r_7__7_,
         sorter_sort_B_r_6__0_, sorter_sort_B_r_6__1_, sorter_sort_B_r_6__2_,
         sorter_sort_B_r_6__3_, sorter_sort_B_r_6__4_, sorter_sort_B_r_6__5_,
         sorter_sort_B_r_6__6_, sorter_sort_B_r_6__7_, sorter_sort_B_r_5__0_,
         sorter_sort_B_r_5__1_, sorter_sort_B_r_5__2_, sorter_sort_B_r_5__3_,
         sorter_sort_B_r_5__4_, sorter_sort_B_r_5__5_, sorter_sort_B_r_5__6_,
         sorter_sort_B_r_5__7_, sorter_sort_G_r_8__0_, sorter_sort_G_r_8__1_,
         sorter_sort_G_r_8__2_, sorter_sort_G_r_8__3_, sorter_sort_G_r_8__4_,
         sorter_sort_G_r_8__5_, sorter_sort_G_r_8__6_, sorter_sort_G_r_8__7_,
         sorter_sort_G_r_7__0_, sorter_sort_G_r_7__1_, sorter_sort_G_r_7__2_,
         sorter_sort_G_r_7__3_, sorter_sort_G_r_7__4_, sorter_sort_G_r_7__5_,
         sorter_sort_G_r_7__6_, sorter_sort_G_r_7__7_, sorter_sort_G_r_6__0_,
         sorter_sort_G_r_6__1_, sorter_sort_G_r_6__2_, sorter_sort_G_r_6__3_,
         sorter_sort_G_r_6__4_, sorter_sort_G_r_6__5_, sorter_sort_G_r_6__6_,
         sorter_sort_G_r_6__7_, sorter_sort_G_r_5__0_, sorter_sort_G_r_5__1_,
         sorter_sort_G_r_5__2_, sorter_sort_G_r_5__3_, sorter_sort_G_r_5__4_,
         sorter_sort_G_r_5__5_, sorter_sort_G_r_5__6_, sorter_sort_G_r_5__7_,
         sorter_sort_R_r_8__0_, sorter_sort_R_r_8__1_, sorter_sort_R_r_8__2_,
         sorter_sort_R_r_8__3_, sorter_sort_R_r_8__4_, sorter_sort_R_r_8__5_,
         sorter_sort_R_r_8__6_, sorter_sort_R_r_8__7_, sorter_sort_R_r_7__0_,
         sorter_sort_R_r_7__1_, sorter_sort_R_r_7__2_, sorter_sort_R_r_7__3_,
         sorter_sort_R_r_7__4_, sorter_sort_R_r_7__5_, sorter_sort_R_r_7__6_,
         sorter_sort_R_r_7__7_, sorter_sort_R_r_6__0_, sorter_sort_R_r_6__1_,
         sorter_sort_R_r_6__2_, sorter_sort_R_r_6__3_, sorter_sort_R_r_6__4_,
         sorter_sort_R_r_6__5_, sorter_sort_R_r_6__6_, sorter_sort_R_r_6__7_,
         sorter_sort_R_r_5__0_, sorter_sort_R_r_5__1_, sorter_sort_R_r_5__2_,
         sorter_sort_R_r_5__3_, sorter_sort_R_r_5__4_, sorter_sort_R_r_5__5_,
         sorter_sort_R_r_5__6_, sorter_sort_R_r_5__7_, n810, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882, n883, n884, n885, n886, n887, n888, n889, n890, n891,
         n892, n893, n894, n895, n896, n897, n898, n899, n900, n901, n902,
         n903, n904, n905, n906, n907, n908, n909, n910, n911, n912, n913,
         n914, n915, n916, n917, n918, n919, n920, n921, n922, n923, n924,
         n925, n926, n927, n928, n929, n930, n931, n932, n933, n934, n935,
         n936, n937, n938, n939, n940, n941, n942, n943, n944, n945, n946,
         n947, n948, n949, n950, n951, n952, n953, n956, n957, n958, n961,
         n962, n963, n964, n965, n966, n967, n968, n969, n970, n971, n972,
         n973, n974, n975, n976, n977, n978, n979, n980, n981, n982, n983,
         n984, n985, n986, n987, n988, n989, n990, n991, n992, n993, n994,
         n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234,
         n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244,
         n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254,
         n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264,
         n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274,
         n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284,
         n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294,
         n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304,
         n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314,
         n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324,
         n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334,
         n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342, n1343, n1344,
         n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352, n1353, n1354,
         n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362, n1363, n1364,
         n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1372, n1373, n1374,
         n1375, n1376, n1377, n1378, n1379, n1380, n1381, n1382, n1383, n1384,
         n1385, n1386, n1387, n1388, n1389, n1390, n1391, n1392, n1393, n1394,
         n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402, n1403, n1404,
         n1405, n1406, n1407, n1408, n1409, n1410, n1411, n1412, n1413, n1414,
         n1415, n1416, n1417, n1418, n1419, n1420, n1421, n1422, n1423, n1424,
         n1425, n1426, n1427, n1428, n1429, n1430, n1431, n1432, n1433, n1434,
         n1435, n1436, n1437, n1439, n1440, n1441, n1442, n1443, n1444, n1445,
         n1446, n1447, n1448, n1449, n1450, n1451, n1452, n1453, n1454, n1455,
         n1456, n1457, n1458, n1459, n1460, n1461, n1462, n1463, n1464, n1465,
         n1466, n1467, n1468, n1469, n1470, n1471, n1472, n1473, n1474, n1475,
         n1476, n1477, n1478, n1479, n1480, n1481, n1482, n1483, n1484, n1485,
         n1486, n1487, n1488, n1489, n1490, n1491, n1492, n1493, n1494, n1495,
         n1496, n1497, n1498, n1499, n1500, n1501, n1502, n1503, n1504, n1505,
         n1506, n1507, n1508, n1509, n1510, n1511, n1512, n1513, n1514, n1515,
         n1516, n1517, n1518, n1519, n1520, n1521, n1522, n1523, n1524, n1525,
         n1526, n1527, n1528, n1529, n1530, n1531, n1532, n1533, n1534, n1535,
         n1536, n1537, n1538, n1539, n1540, n1541, n1542, n1543, n1544, n1545,
         n1546, n1547, n1548, n1549, n1550, n1551, n1552, n1553, n1554, n1555,
         n1556, n1557, n1558, n1559, n1560, n1561, n1562, n1563, n1564, n1565,
         n1566, n1567, n1568, n1569, n1570, n1571, n1572, n1573, n1574, n1575,
         n1576, n1577, n1578, n1579, n1580, n1581, n1582, n1583, n1584, n1585,
         n1586, n1587, n1588, n1589, n1590, n1591, n1592, n1593, n1594, n1595,
         n1596, n1597, n1598, n1599, n1600, n1601, n1602, n1603, n1604, n1605,
         n1606, n1607, n1608, n1609, n1610, n1611, n1612, n1613, n1614, n1615,
         n1616, n1617, n1618, n1619, n1620, n1621, n1622, n1623, n1624, n1625,
         n1626, n1627, n1628, n1629, n1630, n1631, n1632, n1633, n1634, n1635,
         n1636, n1637, n1638, n1639, n1640, n1641, n1642, n1643, n1644, n1645,
         n1646, n1647, n1648, n1649, n1650, n1651, n1652, n1653, n1654, n1655,
         n1656, n1657, n1658, n1659, n1660, n1661, n1662, n1663, n1664, n1665,
         n1666, n1667, n1668, n1669, n1670, n1671, n1672, n1673, n1674, n1675,
         n1676, n1677, n1678, n1679, n1680, n1681, n1682, n1683, n1684, n1685,
         n1686, n1687, n1688, n1689, n1690, n1691, n1692, n1693, n1694, n1695,
         n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703, n1704, n1705,
         n1706, n1707, n1708, n1709, n1710, n1711, n1712, n1713, n1714, n1715,
         n1716, n1717, n1718, n1719, n1720, n1721, n1722, n1723, n1724, n1725,
         n1726, n1727, n1728, n1729, n1730, n1731, n1732, n1733, n1734, n1735,
         n1736, n1737, n1738, n1739, n1740, n1741, n1742, n1743, n1744, n1745,
         n1746, n1747, n1748, n1749, n1750, n1751, n1752, n1753, n1754, n1755,
         n1756, n1757, n1758, n1759, n1760, n1761, n1762, n1763, n1764, n1765,
         n1766, n1767, n1768, n1769, n1770, n1771, n1772, n1773, n1774, n1775,
         n1776, n1777, n1778, n1779, n1780, n1781, n1782, n1783, n1784, n1785,
         n1786, n1787, n1788, n1789, n1790, n1791, n1792, n1793, n1794, n1795,
         n1796, n1797, n1798, n1799, n1800, n1801, n1802, n1803, n1804, n1805,
         n1806, n1807, n1808, n1809, n1810, n1811, n1812, n1813, n1814, n1815,
         n1816, n1817, n1818, n1819, n1820, n1821, n1822, n1823, n1824, n1825,
         n1826, n1827, n1828, n1829, n1830, n1831, n1832, n1833, n1834, n1835,
         n1836, n1837, n1838, n1839, n1840, n1841, n1842, n1843, n1844, n1845,
         n1846, n1847, n1848, n1849, n1850, n1851, n1852, n1853, n1854, n1855,
         n1856, n1857, n1858, n1859, n1860, n1861, n1862, n1863, n1864, n1865,
         n1866, n1867, n1868, n1869, n1870, n1871, n1872, n1873, n1874, n1875,
         n1876, n1877, n1878, n1879, n1880, n1881, n1882, n1883, n1884, n1885,
         n1886, n1887, n1888, n1889, n1890, n1891, n1892, n1893, n1894, n1895,
         n1896, n1897, n1898, n1899, n1900, n1901, n1902, n1903, n1904, n1905,
         n1906, n1907, n1908, n1909, n1910, n1911, n1912, n1913, n1914, n1915,
         n1916, n1917, n1918, n1919, n1920, n1921, n1922, n1923, n1924, n1925,
         n1926, n1927, n1928, n1929, n1930, n1931, n1932, n1933, n1934, n1935,
         n1936, n1937, n1938, n1939, n1940, n1941, n1942, n1943, n1944, n1945,
         n1946, n1947, n1948, n1949, n1950, n1951, n1952, n1953, n1954, n1955,
         n1956, n1957, n1958, n1959, n1960, n1961, n1962, n1963, n1964, n1965,
         n1966, n1967, n1968, n1969, n1970, n1971, n1972, n1973, n1974, n1975,
         n1976, n1977, n1978, n1979, n1980, n1981, n1982, n1983, n1984, n1985,
         n1986, n1987, n1988, n1989, n1990, n1991, n1992, n1993, n1994, n1995,
         n1996, n1997, n1998, n1999, n2000, n2001, n2002, n2003, n2004, n2005,
         n2006, n2007, n2008, n2009, n2010, n2011, n2012, n2013, n2014, n2015,
         n2016, n2017, n2018, n2019, n2020, n2021, n2022, n2023, n2024, n2025,
         n2026, n2027, n2028, n2029, n2030, n2031, n2032, n2033, n2034, n2035,
         n2036, n2037, n2038, n2039, n2040, n2041, n2042, n2043, n2044, n2045,
         n2046, n2047, n2048, n2049, n2050, n2051, n2052, n2053, n2054, n2055,
         n2056, n2057, n2058, n2059, n2060, n2061, n2062, n2063, n2064, n2065,
         n2066, n2067, n2068, n2069, n2070, n2071, n2072, n2073, n2074, n2075,
         n2076, n2077, n2078, n2079, n2080, n2081, n2082, n2083, n2084, n2085,
         n2086, n2087, n2088, n2089, n2090, n2091, n2092, n2093, n2094, n2095,
         n2096, n2097, n2098, n2099, n2100, n2101, n2102, n2103, n2104, n2105,
         n2106, n2107, n2108, n2109, n2110, n2111, n2112, n2113, n2114, n2115,
         n2116, n2117, n2118, n2119, n2120, n2121, n2122, n2123, n2124, n2125,
         n2126, n2127, n2128, n2129, n2130, n2131, n2132, n2133, n2134, n2135,
         n2136, n2137, n2138, n2139, n2140, n2141, n2142, n2143, n2144, n2145,
         n2146, n2147, n2148, n2149, n2150, n2151, n2152, n2153, n2154, n2155,
         n2156, n2157, n2158, n2159, n2160, n2161, n2162, n2163, n2164, n2165,
         n2166, n2167, n2168, n2169, n2170, n2171, n2172, n2173, n2174, n2175,
         n2176, n2177, n2178, n2179, n2180, n2181, n2182, n2183, n2184, n2185,
         n2186, n2187, n2188, n2189, n2190, n2191, n2192, n2193, n2194, n2195,
         n2196, n2197, n2198, n2199, n2200, n2201, n2202, n2203, n2204, n2205,
         n2206, n2207, n2208, n2209, n2210, n2211, n2212, n2213, n2214, n2215,
         n2216, n2217, n2218, n2219, n2220, n2221, n2222, n2223, n2224, n2225,
         n2226, n2227, n2228, n2229, n2230, n2231, n2232, n2233, n2234, n2235,
         n2236, n2237, n2238, n2239, n2240, n2241, n2242, n2243, n2244, n2245,
         n2246, n2247, n2248, n2249, n2250, n2251, n2252, n2253, n2254, n2255,
         n2256, n2257, n2258, n2259, n2260, n2261, n2262, n2263, n2264, n2265,
         n2266, n2267, n2268, n2269, n2270, n2271, n2272, n2273, n2274, n2275,
         n2276, n2277, n2278, n2279, n2280, n2281, n2282, n2283, n2284, n2285,
         n2286, n2287, n2288, n2289, n2290, n2291, n2292, n2293, n2294, n2295,
         n2296, n2297, n2298, n2299, n2300, n2301, n2302, n2303, n2304, n2305,
         n2306, n2307, n2308, n2309, n2310, n2311, n2312, n2313, n2314, n2315,
         n2316, n2317, n2318, n2319, n2320, n2321, n2322, n2323, n2324, n2325,
         n2326, n2327, n2328, n2329, n2330, n2331, n2332, n2333, n2334, n2335,
         n2336, n2337, n2338, n2339, n2340, n2341, n2342, n2343, n2344, n2345,
         n2346, n2347, n2348, n2349, n2350, n2351, n2352, n2353, n2354, n2355,
         n2356, n2357, n2358, n2359, n2360, n2361, n2362, n2363, n2364, n2365,
         n2366, n2367, n2368, n2369, n2370, n2371, n2372, n2373, n2374, n2375,
         n2376, n2377, n2378, n2379, n2380, n2381, n2382, n2383, n2384, n2385,
         n2386, n2387, n2388, n2389, n2390, n2391, n2392, n2393, n2394, n2395,
         n2396, n2397, n2398, n2399, n2400, n2401, n2402, n2403, n2404, n2405,
         n2406, n2407, n2408, n2409, n2410, n2411, n2412, n2413, n2414, n2415,
         n2416, n2417, n2418, n2419, n2420, n2421, n2422, n2423, n2424, n2425,
         n2426, n2427, n2428, n2429, n2431, n2432, n2433, n2434, n2435, n2436,
         n2437, n2438, n2440, n2441, n2442, n2443, n2444, n2445, n2446, n2447,
         n2448, n2449, n2450, n2451, n2452;
  wire   [3:0] op_mode;
  wire   [23:0] in_data;
  wire   [3:0] state;
  wire   [7:0] cnt_255;
  wire   [2:0] dis_size;
  wire   [3:0] cnt_9;
  wire   [3:0] op;
  wire   [7:0] sram_addr;
  wire   [3:0] display_row;
  wire   [3:0] display_col;
  wire   [3:0] filter_row;
  wire   [3:0] filter_col;
  wire   [7:0] q_R;
  wire   [7:0] q_G;
  wire   [7:0] q_B;
  wire   [23:0] out_census;
  wire   [23:0] out_median;
  wire   [3:0] origin_col;
  wire   [3:0] origin_row;
  wire   [3:0] display_col_nxt;
  wire   [3:0] display_row_nxt;
  wire   [23:0] out_data_nxt;
  wire   [23:0] out_data;
  wire   [7:0] census_center_B;
  wire   [7:0] census_center_G;
  wire   [7:0] census_center_R;

  sram_256x8 red ( .Q(q_R), .A(sram_addr), .D(in_data[23:16]), .CLK(i_clk), 
        .CEN(1'b0), .WEN(N653) );
  sram_256x8 green ( .Q(q_G), .A(sram_addr), .D(in_data[15:8]), .CLK(i_clk), 
        .CEN(1'b0), .WEN(N653) );
  sram_256x8 blue ( .Q(q_B), .A(sram_addr), .D(in_data[7:0]), .CLK(i_clk), 
        .CEN(1'b0), .WEN(N653) );
  DFFRX1 op_mode_reg_3_ ( .D(i_op_mode[3]), .CK(i_clk), .RN(i_rst_n), .Q(
        op_mode[3]) );
  DFFRX1 op_mode_reg_2_ ( .D(i_op_mode[2]), .CK(i_clk), .RN(i_rst_n), .Q(
        op_mode[2]) );
  DFFRX1 op_mode_reg_1_ ( .D(i_op_mode[1]), .CK(i_clk), .RN(i_rst_n), .Q(
        op_mode[1]) );
  DFFRX1 op_mode_reg_0_ ( .D(i_op_mode[0]), .CK(i_clk), .RN(i_rst_n), .Q(
        op_mode[0]), .QN(n2426) );
  DFFRX1 in_data_reg_23_ ( .D(i_in_data[23]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[23]) );
  DFFRX1 in_data_reg_22_ ( .D(i_in_data[22]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[22]) );
  DFFRX1 in_data_reg_21_ ( .D(i_in_data[21]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[21]) );
  DFFRX1 in_data_reg_20_ ( .D(i_in_data[20]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[20]) );
  DFFRX1 in_data_reg_19_ ( .D(i_in_data[19]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[19]) );
  DFFRX1 in_data_reg_18_ ( .D(i_in_data[18]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[18]) );
  DFFRX1 in_data_reg_17_ ( .D(i_in_data[17]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[17]) );
  DFFRX1 in_data_reg_16_ ( .D(i_in_data[16]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[16]) );
  DFFRX1 in_data_reg_15_ ( .D(i_in_data[15]), .CK(i_clk), .RN(i_rst_n), .Q(
        in_data[15]) );
  DFFRX1 in_data_reg_14_ ( .D(i_in_data[14]), .CK(i_clk), .RN(n2447), .Q(
        in_data[14]) );
  DFFRX1 in_data_reg_13_ ( .D(i_in_data[13]), .CK(i_clk), .RN(n2447), .Q(
        in_data[13]) );
  DFFRX1 in_data_reg_12_ ( .D(i_in_data[12]), .CK(i_clk), .RN(n2447), .Q(
        in_data[12]) );
  DFFRX1 in_data_reg_11_ ( .D(i_in_data[11]), .CK(i_clk), .RN(n2447), .Q(
        in_data[11]) );
  DFFRX1 in_data_reg_10_ ( .D(i_in_data[10]), .CK(i_clk), .RN(n2447), .Q(
        in_data[10]) );
  DFFRX1 in_data_reg_9_ ( .D(i_in_data[9]), .CK(i_clk), .RN(n2447), .Q(
        in_data[9]) );
  DFFRX1 in_data_reg_8_ ( .D(i_in_data[8]), .CK(i_clk), .RN(n2447), .Q(
        in_data[8]) );
  DFFRX1 in_data_reg_7_ ( .D(i_in_data[7]), .CK(i_clk), .RN(n2447), .Q(
        in_data[7]) );
  DFFRX1 in_data_reg_6_ ( .D(i_in_data[6]), .CK(i_clk), .RN(n2447), .Q(
        in_data[6]) );
  DFFRX1 in_data_reg_5_ ( .D(i_in_data[5]), .CK(i_clk), .RN(n2447), .Q(
        in_data[5]) );
  DFFRX1 in_data_reg_4_ ( .D(i_in_data[4]), .CK(i_clk), .RN(n2447), .Q(
        in_data[4]) );
  DFFRX1 in_data_reg_3_ ( .D(i_in_data[3]), .CK(i_clk), .RN(n2447), .Q(
        in_data[3]) );
  DFFRX1 in_data_reg_2_ ( .D(i_in_data[2]), .CK(i_clk), .RN(n2446), .Q(
        in_data[2]) );
  DFFRX1 in_data_reg_1_ ( .D(i_in_data[1]), .CK(i_clk), .RN(n2446), .Q(
        in_data[1]) );
  DFFRX1 in_data_reg_0_ ( .D(i_in_data[0]), .CK(i_clk), .RN(n2446), .Q(
        in_data[0]) );
  DFFRX1 origin_col_reg_3_ ( .D(n931), .CK(i_clk), .RN(n2446), .Q(
        origin_col[3]), .QN(n2423) );
  DFFRX1 origin_col_reg_1_ ( .D(n933), .CK(i_clk), .RN(n2446), .Q(
        origin_col[1]), .QN(n2402) );
  DFFRX1 origin_row_reg_2_ ( .D(n935), .CK(i_clk), .RN(n2446), .Q(
        origin_row[2]), .QN(n2420) );
  DFFRX1 origin_row_reg_1_ ( .D(n936), .CK(i_clk), .RN(n2446), .Q(
        origin_row[1]), .QN(n2419) );
  DFFRX1 origin_row_reg_3_ ( .D(n953), .CK(i_clk), .RN(n2446), .Q(
        origin_row[3]), .QN(n2421) );
  DFFRX4 dis_size_reg_1_ ( .D(n951), .CK(i_clk), .RN(n2446), .Q(dis_size[1]), 
        .QN(n2395) );
  DFFRX4 dis_size_reg_2_ ( .D(n952), .CK(i_clk), .RN(n2446), .Q(dis_size[2]), 
        .QN(n2397) );
  DFFRX4 cnt_9_reg_1_ ( .D(N309), .CK(i_clk), .RN(n2445), .Q(cnt_9[1]) );
  DFFRX1 cens_start_reg ( .D(n956), .CK(i_clk), .RN(n2445), .Q(cens_start) );
  DFFRX1 cnt_255_reg_0_ ( .D(n948), .CK(i_clk), .RN(n2445), .Q(cnt_255[0]), 
        .QN(n2415) );
  DFFRX1 cnt_255_reg_1_ ( .D(n947), .CK(i_clk), .RN(n2445), .Q(cnt_255[1]) );
  DFFRX1 cnt_255_reg_2_ ( .D(n946), .CK(i_clk), .RN(n2445), .Q(cnt_255[2]) );
  DFFRX1 cnt_255_reg_3_ ( .D(n945), .CK(i_clk), .RN(n2445), .Q(cnt_255[3]), 
        .QN(n2417) );
  DFFRX1 cnt_255_reg_4_ ( .D(n944), .CK(i_clk), .RN(n2445), .Q(cnt_255[4]) );
  DFFRX1 cnt_255_reg_5_ ( .D(n943), .CK(i_clk), .RN(n2444), .Q(cnt_255[5]), 
        .QN(n2418) );
  DFFRX1 cnt_255_reg_6_ ( .D(n942), .CK(i_clk), .RN(n2444), .Q(cnt_255[6]) );
  DFFRX1 origin_row_reg_0_ ( .D(n937), .CK(i_clk), .RN(n2444), .Q(
        origin_row[0]), .QN(n2404) );
  DFFRX1 display_row_reg_0_ ( .D(display_row_nxt[0]), .CK(i_clk), .RN(n2444), 
        .Q(display_row[0]), .QN(n2401) );
  DFFRX1 filter_row_reg_0_ ( .D(N450), .CK(i_clk), .RN(n2444), .Q(
        filter_row[0]) );
  DFFRX1 origin_col_reg_0_ ( .D(n934), .CK(i_clk), .RN(n2444), .Q(
        origin_col[0]), .QN(n2422) );
  DFFRX1 filter_row_reg_1_ ( .D(N451), .CK(i_clk), .RN(n2444), .Q(
        filter_row[1]) );
  DFFRX1 filter_row_reg_3_ ( .D(N453), .CK(i_clk), .RN(n2446), .Q(
        filter_row[3]) );
  DFFRX1 filter_col_reg_0_ ( .D(N446), .CK(i_clk), .RN(i_rst_n), .Q(
        filter_col[0]) );
  DFFRX1 display_col_reg_1_ ( .D(display_col_nxt[1]), .CK(i_clk), .RN(n2445), 
        .Q(display_col[1]) );
  DFFRX1 filter_col_reg_1_ ( .D(N447), .CK(i_clk), .RN(n2447), .Q(
        filter_col[1]) );
  DFFRX1 filter_row_reg_2_ ( .D(N452), .CK(i_clk), .RN(n2444), .Q(
        filter_row[2]) );
  DFFRX1 origin_col_reg_2_ ( .D(n932), .CK(i_clk), .RN(n2444), .Q(
        origin_col[2]), .QN(n2403) );
  DFFRX1 filter_col_reg_3_ ( .D(N449), .CK(i_clk), .RN(n2446), .Q(
        filter_col[3]) );
  DFFRX1 filter_col_reg_2_ ( .D(N448), .CK(i_clk), .RN(n2445), .Q(
        filter_col[2]) );
  EDFFX1 census_center_B_reg_5_ ( .D(n2429), .E(n2443), .CK(i_clk), .Q(
        census_center_B[5]) );
  EDFFX1 census_center_B_reg_6_ ( .D(n2435), .E(n2443), .CK(i_clk), .Q(
        census_center_B[6]) );
  EDFFX1 census_center_R_reg_2_ ( .D(n2448), .E(n2443), .CK(i_clk), .Q(
        census_center_R[2]) );
  EDFFX1 census_center_R_reg_3_ ( .D(n1140), .E(n2443), .CK(i_clk), .Q(
        census_center_R[3]) );
  DFFQX1 out_valid_reg ( .D(out_valid_nxt), .CK(i_clk), .Q(out_valid) );
  DFFQX1 out_data_reg_23_ ( .D(out_data_nxt[23]), .CK(i_clk), .Q(out_data[23])
         );
  DFFQX1 out_data_reg_21_ ( .D(out_data_nxt[21]), .CK(i_clk), .Q(out_data[21])
         );
  DFFQX1 out_data_reg_20_ ( .D(out_data_nxt[20]), .CK(i_clk), .Q(out_data[20])
         );
  DFFQX1 out_data_reg_19_ ( .D(out_data_nxt[19]), .CK(i_clk), .Q(out_data[19])
         );
  DFFQX1 out_data_reg_18_ ( .D(out_data_nxt[18]), .CK(i_clk), .Q(out_data[18])
         );
  DFFQX1 out_data_reg_17_ ( .D(out_data_nxt[17]), .CK(i_clk), .Q(out_data[17])
         );
  DFFQX1 out_data_reg_16_ ( .D(out_data_nxt[16]), .CK(i_clk), .Q(out_data[16])
         );
  DFFQX1 out_data_reg_14_ ( .D(out_data_nxt[14]), .CK(i_clk), .Q(out_data[14])
         );
  DFFQX1 out_data_reg_13_ ( .D(out_data_nxt[13]), .CK(i_clk), .Q(out_data[13])
         );
  DFFQX1 out_data_reg_12_ ( .D(out_data_nxt[12]), .CK(i_clk), .Q(out_data[12])
         );
  DFFQX1 out_data_reg_11_ ( .D(out_data_nxt[11]), .CK(i_clk), .Q(out_data[11])
         );
  DFFQX1 out_data_reg_10_ ( .D(out_data_nxt[10]), .CK(i_clk), .Q(out_data[10])
         );
  DFFQX1 out_data_reg_9_ ( .D(out_data_nxt[9]), .CK(i_clk), .Q(out_data[9]) );
  DFFQX1 out_data_reg_8_ ( .D(out_data_nxt[8]), .CK(i_clk), .Q(out_data[8]) );
  DFFQX1 census_result_B_reg_7_ ( .D(census_N2), .CK(i_clk), .Q(out_census[0])
         );
  DFFQX1 census_result_B_reg_6_ ( .D(out_census[0]), .CK(i_clk), .Q(
        out_census[1]) );
  DFFQX1 census_result_B_reg_5_ ( .D(out_census[1]), .CK(i_clk), .Q(
        out_census[2]) );
  DFFQX1 census_result_B_reg_4_ ( .D(out_census[2]), .CK(i_clk), .Q(
        out_census[3]) );
  DFFQX1 census_result_B_reg_3_ ( .D(out_census[3]), .CK(i_clk), .Q(
        out_census[4]) );
  DFFQX1 census_result_B_reg_2_ ( .D(out_census[4]), .CK(i_clk), .Q(
        out_census[5]) );
  DFFQX1 census_result_B_reg_1_ ( .D(out_census[5]), .CK(i_clk), .Q(
        out_census[6]) );
  DFFQX1 census_result_B_reg_0_ ( .D(out_census[6]), .CK(i_clk), .Q(
        out_census[7]) );
  DFFQX1 census_result_G_reg_7_ ( .D(census_N1), .CK(i_clk), .Q(out_census[8])
         );
  DFFQX1 census_result_G_reg_6_ ( .D(out_census[8]), .CK(i_clk), .Q(
        out_census[9]) );
  DFFQX1 census_result_G_reg_5_ ( .D(out_census[9]), .CK(i_clk), .Q(
        out_census[10]) );
  DFFQX1 census_result_G_reg_4_ ( .D(out_census[10]), .CK(i_clk), .Q(
        out_census[11]) );
  DFFQX1 census_result_G_reg_3_ ( .D(out_census[11]), .CK(i_clk), .Q(
        out_census[12]) );
  DFFQX1 census_result_G_reg_2_ ( .D(out_census[12]), .CK(i_clk), .Q(
        out_census[13]) );
  DFFQX1 census_result_G_reg_1_ ( .D(out_census[13]), .CK(i_clk), .Q(
        out_census[14]) );
  DFFQX1 census_result_G_reg_0_ ( .D(out_census[14]), .CK(i_clk), .Q(
        out_census[15]) );
  DFFQX1 census_result_R_reg_7_ ( .D(census_N0), .CK(i_clk), .Q(out_census[16]) );
  DFFQX1 census_result_R_reg_6_ ( .D(out_census[16]), .CK(i_clk), .Q(
        out_census[17]) );
  DFFQX1 census_result_R_reg_5_ ( .D(out_census[17]), .CK(i_clk), .Q(
        out_census[18]) );
  DFFQX1 census_result_R_reg_4_ ( .D(out_census[18]), .CK(i_clk), .Q(
        out_census[19]) );
  DFFQX1 census_result_R_reg_3_ ( .D(out_census[19]), .CK(i_clk), .Q(
        out_census[20]) );
  DFFQX1 census_result_R_reg_2_ ( .D(out_census[20]), .CK(i_clk), .Q(
        out_census[21]) );
  DFFQX1 census_result_R_reg_1_ ( .D(out_census[21]), .CK(i_clk), .Q(
        out_census[22]) );
  DFFQX1 census_result_R_reg_0_ ( .D(out_census[22]), .CK(i_clk), .Q(
        out_census[23]) );
  DFFQX1 sorter_sort_R_r_reg_8__0_ ( .D(n843), .CK(i_clk), .Q(
        sorter_sort_R_r_8__0_) );
  DFFQX1 sorter_sort_R_r_reg_8__1_ ( .D(n844), .CK(i_clk), .Q(
        sorter_sort_R_r_8__1_) );
  DFFQX1 sorter_sort_R_r_reg_8__2_ ( .D(n845), .CK(i_clk), .Q(
        sorter_sort_R_r_8__2_) );
  DFFQX1 sorter_sort_R_r_reg_8__3_ ( .D(n846), .CK(i_clk), .Q(
        sorter_sort_R_r_8__3_) );
  DFFQX1 sorter_sort_R_r_reg_8__4_ ( .D(n847), .CK(i_clk), .Q(
        sorter_sort_R_r_8__4_) );
  DFFQX1 sorter_sort_R_r_reg_8__5_ ( .D(n848), .CK(i_clk), .Q(
        sorter_sort_R_r_8__5_) );
  DFFQX1 sorter_sort_R_r_reg_8__6_ ( .D(n849), .CK(i_clk), .Q(
        sorter_sort_R_r_8__6_) );
  DFFQX1 sorter_sort_R_r_reg_8__7_ ( .D(n850), .CK(i_clk), .Q(
        sorter_sort_R_r_8__7_) );
  DFFQX1 sorter_sort_R_r_reg_7__0_ ( .D(n835), .CK(i_clk), .Q(
        sorter_sort_R_r_7__0_) );
  DFFQX1 sorter_sort_R_r_reg_7__1_ ( .D(n836), .CK(i_clk), .Q(
        sorter_sort_R_r_7__1_) );
  DFFQX1 sorter_sort_R_r_reg_7__2_ ( .D(n837), .CK(i_clk), .Q(
        sorter_sort_R_r_7__2_) );
  DFFQX1 sorter_sort_R_r_reg_7__3_ ( .D(n838), .CK(i_clk), .Q(
        sorter_sort_R_r_7__3_) );
  DFFQX1 sorter_sort_R_r_reg_7__4_ ( .D(n839), .CK(i_clk), .Q(
        sorter_sort_R_r_7__4_) );
  DFFQX1 sorter_sort_R_r_reg_7__5_ ( .D(n840), .CK(i_clk), .Q(
        sorter_sort_R_r_7__5_) );
  DFFQX1 sorter_sort_R_r_reg_7__6_ ( .D(n841), .CK(i_clk), .Q(
        sorter_sort_R_r_7__6_) );
  DFFQX1 sorter_sort_R_r_reg_7__7_ ( .D(n842), .CK(i_clk), .Q(
        sorter_sort_R_r_7__7_) );
  DFFQX1 sorter_sort_R_r_reg_6__0_ ( .D(n827), .CK(i_clk), .Q(
        sorter_sort_R_r_6__0_) );
  DFFQX1 sorter_sort_R_r_reg_6__1_ ( .D(n828), .CK(i_clk), .Q(
        sorter_sort_R_r_6__1_) );
  DFFQX1 sorter_sort_R_r_reg_6__2_ ( .D(n829), .CK(i_clk), .Q(
        sorter_sort_R_r_6__2_) );
  DFFQX1 sorter_sort_R_r_reg_6__3_ ( .D(n830), .CK(i_clk), .Q(
        sorter_sort_R_r_6__3_) );
  DFFQX1 sorter_sort_R_r_reg_6__4_ ( .D(n831), .CK(i_clk), .Q(
        sorter_sort_R_r_6__4_) );
  DFFQX1 sorter_sort_R_r_reg_6__5_ ( .D(n832), .CK(i_clk), .Q(
        sorter_sort_R_r_6__5_) );
  DFFQX1 sorter_sort_R_r_reg_6__6_ ( .D(n833), .CK(i_clk), .Q(
        sorter_sort_R_r_6__6_) );
  DFFQX1 sorter_sort_R_r_reg_6__7_ ( .D(n834), .CK(i_clk), .Q(
        sorter_sort_R_r_6__7_) );
  DFFQX1 sorter_sort_R_r_reg_5__0_ ( .D(n819), .CK(i_clk), .Q(
        sorter_sort_R_r_5__0_) );
  DFFQX1 sorter_sort_R_r_reg_5__1_ ( .D(n820), .CK(i_clk), .Q(
        sorter_sort_R_r_5__1_) );
  DFFQX1 sorter_sort_R_r_reg_5__2_ ( .D(n821), .CK(i_clk), .Q(
        sorter_sort_R_r_5__2_) );
  DFFQX1 sorter_sort_R_r_reg_5__3_ ( .D(n822), .CK(i_clk), .Q(
        sorter_sort_R_r_5__3_) );
  DFFQX1 sorter_sort_R_r_reg_5__4_ ( .D(n823), .CK(i_clk), .Q(
        sorter_sort_R_r_5__4_) );
  DFFQX1 sorter_sort_R_r_reg_5__5_ ( .D(n824), .CK(i_clk), .Q(
        sorter_sort_R_r_5__5_) );
  DFFQX1 sorter_sort_R_r_reg_5__6_ ( .D(n825), .CK(i_clk), .Q(
        sorter_sort_R_r_5__6_) );
  DFFQX1 sorter_sort_R_r_reg_5__7_ ( .D(n826), .CK(i_clk), .Q(
        sorter_sort_R_r_5__7_) );
  DFFQX1 sorter_sort_R_r_reg_4__0_ ( .D(n810), .CK(i_clk), .Q(out_median[16])
         );
  DFFQX1 sorter_sort_R_r_reg_4__1_ ( .D(n812), .CK(i_clk), .Q(out_median[17])
         );
  DFFQX1 sorter_sort_R_r_reg_4__2_ ( .D(n813), .CK(i_clk), .Q(out_median[18])
         );
  DFFQX1 sorter_sort_R_r_reg_4__3_ ( .D(n814), .CK(i_clk), .Q(out_median[19])
         );
  DFFQX1 sorter_sort_R_r_reg_4__4_ ( .D(n815), .CK(i_clk), .Q(out_median[20])
         );
  DFFQX1 sorter_sort_R_r_reg_4__5_ ( .D(n816), .CK(i_clk), .Q(out_median[21])
         );
  DFFQX1 sorter_sort_R_r_reg_4__6_ ( .D(n817), .CK(i_clk), .Q(out_median[22])
         );
  DFFQX1 sorter_sort_R_r_reg_4__7_ ( .D(n818), .CK(i_clk), .Q(out_median[23])
         );
  DFFQX1 sorter_sort_B_r_reg_8__0_ ( .D(n922), .CK(i_clk), .Q(
        sorter_sort_B_r_8__0_) );
  DFFQX1 sorter_sort_B_r_reg_8__1_ ( .D(n923), .CK(i_clk), .Q(
        sorter_sort_B_r_8__1_) );
  DFFQX1 sorter_sort_B_r_reg_8__2_ ( .D(n924), .CK(i_clk), .Q(
        sorter_sort_B_r_8__2_) );
  DFFQX1 sorter_sort_B_r_reg_8__3_ ( .D(n925), .CK(i_clk), .Q(
        sorter_sort_B_r_8__3_) );
  DFFQX1 sorter_sort_B_r_reg_8__4_ ( .D(n926), .CK(i_clk), .Q(
        sorter_sort_B_r_8__4_) );
  DFFQX1 sorter_sort_B_r_reg_8__5_ ( .D(n927), .CK(i_clk), .Q(
        sorter_sort_B_r_8__5_) );
  DFFQX1 sorter_sort_B_r_reg_8__6_ ( .D(n928), .CK(i_clk), .Q(
        sorter_sort_B_r_8__6_) );
  DFFQX1 sorter_sort_B_r_reg_8__7_ ( .D(n929), .CK(i_clk), .Q(
        sorter_sort_B_r_8__7_) );
  DFFQX1 sorter_sort_B_r_reg_7__0_ ( .D(n914), .CK(i_clk), .Q(
        sorter_sort_B_r_7__0_) );
  DFFQX1 sorter_sort_B_r_reg_7__1_ ( .D(n915), .CK(i_clk), .Q(
        sorter_sort_B_r_7__1_) );
  DFFQX1 sorter_sort_B_r_reg_7__2_ ( .D(n916), .CK(i_clk), .Q(
        sorter_sort_B_r_7__2_) );
  DFFQX1 sorter_sort_B_r_reg_7__3_ ( .D(n917), .CK(i_clk), .Q(
        sorter_sort_B_r_7__3_) );
  DFFQX1 sorter_sort_B_r_reg_7__4_ ( .D(n918), .CK(i_clk), .Q(
        sorter_sort_B_r_7__4_) );
  DFFQX1 sorter_sort_B_r_reg_7__5_ ( .D(n919), .CK(i_clk), .Q(
        sorter_sort_B_r_7__5_) );
  DFFQX1 sorter_sort_B_r_reg_7__6_ ( .D(n920), .CK(i_clk), .Q(
        sorter_sort_B_r_7__6_) );
  DFFQX1 sorter_sort_B_r_reg_7__7_ ( .D(n921), .CK(i_clk), .Q(
        sorter_sort_B_r_7__7_) );
  DFFQX1 sorter_sort_B_r_reg_6__0_ ( .D(n906), .CK(i_clk), .Q(
        sorter_sort_B_r_6__0_) );
  DFFQX1 sorter_sort_B_r_reg_6__1_ ( .D(n907), .CK(i_clk), .Q(
        sorter_sort_B_r_6__1_) );
  DFFQX1 sorter_sort_B_r_reg_6__2_ ( .D(n908), .CK(i_clk), .Q(
        sorter_sort_B_r_6__2_) );
  DFFQX1 sorter_sort_B_r_reg_6__3_ ( .D(n909), .CK(i_clk), .Q(
        sorter_sort_B_r_6__3_) );
  DFFQX1 sorter_sort_B_r_reg_6__4_ ( .D(n910), .CK(i_clk), .Q(
        sorter_sort_B_r_6__4_) );
  DFFQX1 sorter_sort_B_r_reg_6__5_ ( .D(n911), .CK(i_clk), .Q(
        sorter_sort_B_r_6__5_) );
  DFFQX1 sorter_sort_B_r_reg_6__6_ ( .D(n912), .CK(i_clk), .Q(
        sorter_sort_B_r_6__6_) );
  DFFQX1 sorter_sort_B_r_reg_6__7_ ( .D(n913), .CK(i_clk), .Q(
        sorter_sort_B_r_6__7_) );
  DFFQX1 sorter_sort_B_r_reg_5__0_ ( .D(n898), .CK(i_clk), .Q(
        sorter_sort_B_r_5__0_) );
  DFFQX1 sorter_sort_B_r_reg_5__1_ ( .D(n899), .CK(i_clk), .Q(
        sorter_sort_B_r_5__1_) );
  DFFQX1 sorter_sort_B_r_reg_5__2_ ( .D(n900), .CK(i_clk), .Q(
        sorter_sort_B_r_5__2_) );
  DFFQX1 sorter_sort_B_r_reg_5__3_ ( .D(n901), .CK(i_clk), .Q(
        sorter_sort_B_r_5__3_) );
  DFFQX1 sorter_sort_B_r_reg_5__4_ ( .D(n902), .CK(i_clk), .Q(
        sorter_sort_B_r_5__4_) );
  DFFQX1 sorter_sort_B_r_reg_5__5_ ( .D(n903), .CK(i_clk), .Q(
        sorter_sort_B_r_5__5_) );
  DFFQX1 sorter_sort_B_r_reg_5__6_ ( .D(n904), .CK(i_clk), .Q(
        sorter_sort_B_r_5__6_) );
  DFFQX1 sorter_sort_B_r_reg_5__7_ ( .D(n905), .CK(i_clk), .Q(
        sorter_sort_B_r_5__7_) );
  DFFQX1 sorter_sort_B_r_reg_4__0_ ( .D(n890), .CK(i_clk), .Q(out_median[0])
         );
  DFFQX1 sorter_sort_B_r_reg_4__1_ ( .D(n891), .CK(i_clk), .Q(out_median[1])
         );
  DFFQX1 sorter_sort_B_r_reg_4__2_ ( .D(n892), .CK(i_clk), .Q(out_median[2])
         );
  DFFQX1 sorter_sort_B_r_reg_4__3_ ( .D(n893), .CK(i_clk), .Q(out_median[3])
         );
  DFFQX1 sorter_sort_B_r_reg_4__4_ ( .D(n894), .CK(i_clk), .Q(out_median[4])
         );
  DFFQX1 sorter_sort_B_r_reg_4__5_ ( .D(n895), .CK(i_clk), .Q(out_median[5])
         );
  DFFQX1 sorter_sort_B_r_reg_4__6_ ( .D(n896), .CK(i_clk), .Q(out_median[6])
         );
  DFFQX1 sorter_sort_B_r_reg_4__7_ ( .D(n897), .CK(i_clk), .Q(out_median[7])
         );
  DFFQX1 sorter_sort_G_r_reg_8__0_ ( .D(n882), .CK(i_clk), .Q(
        sorter_sort_G_r_8__0_) );
  DFFQX1 sorter_sort_G_r_reg_8__1_ ( .D(n883), .CK(i_clk), .Q(
        sorter_sort_G_r_8__1_) );
  DFFQX1 sorter_sort_G_r_reg_8__2_ ( .D(n884), .CK(i_clk), .Q(
        sorter_sort_G_r_8__2_) );
  DFFQX1 sorter_sort_G_r_reg_8__3_ ( .D(n885), .CK(i_clk), .Q(
        sorter_sort_G_r_8__3_) );
  DFFQX1 sorter_sort_G_r_reg_8__4_ ( .D(n886), .CK(i_clk), .Q(
        sorter_sort_G_r_8__4_) );
  DFFQX1 sorter_sort_G_r_reg_8__5_ ( .D(n887), .CK(i_clk), .Q(
        sorter_sort_G_r_8__5_) );
  DFFQX1 sorter_sort_G_r_reg_8__6_ ( .D(n888), .CK(i_clk), .Q(
        sorter_sort_G_r_8__6_) );
  DFFQX1 sorter_sort_G_r_reg_8__7_ ( .D(n889), .CK(i_clk), .Q(
        sorter_sort_G_r_8__7_) );
  DFFQX1 sorter_sort_G_r_reg_7__0_ ( .D(n874), .CK(i_clk), .Q(
        sorter_sort_G_r_7__0_) );
  DFFQX1 sorter_sort_G_r_reg_7__1_ ( .D(n875), .CK(i_clk), .Q(
        sorter_sort_G_r_7__1_) );
  DFFQX1 sorter_sort_G_r_reg_7__2_ ( .D(n876), .CK(i_clk), .Q(
        sorter_sort_G_r_7__2_) );
  DFFQX1 sorter_sort_G_r_reg_7__3_ ( .D(n877), .CK(i_clk), .Q(
        sorter_sort_G_r_7__3_) );
  DFFQX1 sorter_sort_G_r_reg_7__4_ ( .D(n878), .CK(i_clk), .Q(
        sorter_sort_G_r_7__4_) );
  DFFQX1 sorter_sort_G_r_reg_7__5_ ( .D(n879), .CK(i_clk), .Q(
        sorter_sort_G_r_7__5_) );
  DFFQX1 sorter_sort_G_r_reg_7__7_ ( .D(n881), .CK(i_clk), .Q(
        sorter_sort_G_r_7__7_) );
  DFFQX1 sorter_sort_G_r_reg_6__0_ ( .D(n866), .CK(i_clk), .Q(
        sorter_sort_G_r_6__0_) );
  DFFQX1 sorter_sort_G_r_reg_6__1_ ( .D(n867), .CK(i_clk), .Q(
        sorter_sort_G_r_6__1_) );
  DFFQX1 sorter_sort_G_r_reg_6__2_ ( .D(n868), .CK(i_clk), .Q(
        sorter_sort_G_r_6__2_) );
  DFFQX1 sorter_sort_G_r_reg_6__3_ ( .D(n869), .CK(i_clk), .Q(
        sorter_sort_G_r_6__3_) );
  DFFQX1 sorter_sort_G_r_reg_6__4_ ( .D(n870), .CK(i_clk), .Q(
        sorter_sort_G_r_6__4_) );
  DFFQX1 sorter_sort_G_r_reg_6__5_ ( .D(n871), .CK(i_clk), .Q(
        sorter_sort_G_r_6__5_) );
  DFFQX1 sorter_sort_G_r_reg_6__6_ ( .D(n872), .CK(i_clk), .Q(
        sorter_sort_G_r_6__6_) );
  DFFQX1 sorter_sort_G_r_reg_6__7_ ( .D(n873), .CK(i_clk), .Q(
        sorter_sort_G_r_6__7_) );
  DFFQX1 sorter_sort_G_r_reg_5__0_ ( .D(n858), .CK(i_clk), .Q(
        sorter_sort_G_r_5__0_) );
  DFFQX1 sorter_sort_G_r_reg_5__1_ ( .D(n859), .CK(i_clk), .Q(
        sorter_sort_G_r_5__1_) );
  DFFQX1 sorter_sort_G_r_reg_5__2_ ( .D(n860), .CK(i_clk), .Q(
        sorter_sort_G_r_5__2_) );
  DFFQX1 sorter_sort_G_r_reg_5__3_ ( .D(n861), .CK(i_clk), .Q(
        sorter_sort_G_r_5__3_) );
  DFFQX1 sorter_sort_G_r_reg_5__4_ ( .D(n862), .CK(i_clk), .Q(
        sorter_sort_G_r_5__4_) );
  DFFQX1 sorter_sort_G_r_reg_5__5_ ( .D(n863), .CK(i_clk), .Q(
        sorter_sort_G_r_5__5_) );
  DFFQX1 sorter_sort_G_r_reg_5__6_ ( .D(n864), .CK(i_clk), .Q(
        sorter_sort_G_r_5__6_) );
  DFFQX1 sorter_sort_G_r_reg_5__7_ ( .D(n865), .CK(i_clk), .Q(
        sorter_sort_G_r_5__7_) );
  DFFQX1 sorter_sort_G_r_reg_4__0_ ( .D(n857), .CK(i_clk), .Q(out_median[8])
         );
  DFFQX1 sorter_sort_G_r_reg_4__1_ ( .D(n856), .CK(i_clk), .Q(out_median[9])
         );
  DFFQX1 sorter_sort_G_r_reg_4__2_ ( .D(n855), .CK(i_clk), .Q(out_median[10])
         );
  DFFQX1 sorter_sort_G_r_reg_4__3_ ( .D(n854), .CK(i_clk), .Q(out_median[11])
         );
  DFFQX1 sorter_sort_G_r_reg_4__4_ ( .D(n853), .CK(i_clk), .Q(out_median[12])
         );
  DFFQX1 sorter_sort_G_r_reg_4__5_ ( .D(n852), .CK(i_clk), .Q(out_median[13])
         );
  DFFQX1 sorter_sort_G_r_reg_4__6_ ( .D(n851), .CK(i_clk), .Q(out_median[14])
         );
  DFFQX1 sorter_sort_G_r_reg_4__7_ ( .D(n930), .CK(i_clk), .Q(out_median[15])
         );
  EDFFX1 op_reg_2_ ( .D(op_mode[2]), .E(op_valid), .CK(i_clk), .Q(op[2]), .QN(
        n2425) );
  DFFRX1 state_reg_1_ ( .D(n939), .CK(i_clk), .RN(n2446), .Q(state[1]), .QN(
        n2410) );
  EDFFX1 op_reg_0_ ( .D(op_mode[0]), .E(op_valid), .CK(i_clk), .Q(op[0]), .QN(
        n2408) );
  DFFRX1 cnt_255_reg_7_ ( .D(n941), .CK(i_clk), .RN(n2444), .Q(cnt_255[7]), 
        .QN(n2428) );
  DFFRX1 op_ready_reg ( .D(op_ready_nxt), .CK(i_clk), .RN(n2444), .Q(
        o_op_ready) );
  DFFRX1 out_valid_2_reg ( .D(out_valid), .CK(i_clk), .RN(n2447), .Q(
        o_out_valid) );
  DFFRX1 display_row_reg_1_ ( .D(display_row_nxt[1]), .CK(i_clk), .RN(n2444), 
        .Q(display_row[1]), .QN(n2414) );
  DFFRX1 display_row_reg_3_ ( .D(display_row_nxt[3]), .CK(i_clk), .RN(n2444), 
        .Q(display_row[3]), .QN(n2424) );
  DFFRX2 display_col_reg_2_ ( .D(display_col_nxt[2]), .CK(i_clk), .RN(n2444), 
        .Q(display_col[2]), .QN(n2413) );
  DFFRX1 state_reg_3_ ( .D(n949), .CK(i_clk), .RN(n2445), .Q(state[3]), .QN(
        n2396) );
  DFFRX2 state_reg_0_ ( .D(n938), .CK(i_clk), .RN(n2446), .Q(state[0]), .QN(
        n2407) );
  EDFFX1 op_reg_3_ ( .D(op_mode[3]), .E(op_valid), .CK(i_clk), .Q(op[3]), .QN(
        n2400) );
  DFFSX2 cnt_9_reg_0_ ( .D(n2394), .CK(i_clk), .SN(n2445), .Q(n2398), .QN(
        cnt_9[0]) );
  DFFQX1 out_data_reg_1_ ( .D(out_data_nxt[1]), .CK(i_clk), .Q(out_data[1]) );
  EDFFX2 op_reg_1_ ( .D(op_mode[1]), .E(op_valid), .CK(i_clk), .Q(op[1]), .QN(
        n2411) );
  DFFRX2 op_valid_reg ( .D(i_op_valid), .CK(i_clk), .RN(i_rst_n), .Q(op_valid)
         );
  EDFFXL census_center_B_reg_4_ ( .D(n1177), .E(n2443), .CK(i_clk), .Q(
        census_center_B[4]) );
  EDFFXL census_center_B_reg_3_ ( .D(n2431), .E(n2443), .CK(i_clk), .Q(
        census_center_B[3]) );
  EDFFXL census_center_B_reg_2_ ( .D(n2434), .E(n2443), .CK(i_clk), .Q(
        census_center_B[2]) );
  EDFFXL census_center_B_reg_1_ ( .D(n2432), .E(n2443), .CK(i_clk), .Q(
        census_center_B[1]) );
  EDFFXL census_center_B_reg_0_ ( .D(n2433), .E(n2443), .CK(i_clk), .Q(
        census_center_B[0]) );
  EDFFXL census_center_R_reg_0_ ( .D(n2449), .E(n2443), .CK(i_clk), .Q(
        census_center_R[0]) );
  DFFRX2 display_row_reg_2_ ( .D(display_row_nxt[2]), .CK(i_clk), .RN(n2444), 
        .Q(display_row[2]), .QN(n2412) );
  DFFRX2 cnt_9_reg_3_ ( .D(N311), .CK(i_clk), .RN(n2445), .Q(cnt_9[3]), .QN(
        n2406) );
  DFFRX1 display_col_reg_0_ ( .D(display_col_nxt[0]), .CK(i_clk), .RN(n2447), 
        .Q(display_col[0]), .QN(n2409) );
  EDFFXL census_center_B_reg_7_ ( .D(n2452), .E(n2443), .CK(i_clk), .Q(
        census_center_B[7]) );
  EDFFXL census_center_G_reg_0_ ( .D(n2451), .E(n2443), .CK(i_clk), .Q(
        census_center_G[0]) );
  EDFFXL census_center_G_reg_1_ ( .D(n996), .E(n2443), .CK(i_clk), .Q(
        census_center_G[1]) );
  EDFFXL census_center_G_reg_2_ ( .D(n2450), .E(n2443), .CK(i_clk), .Q(
        census_center_G[2]) );
  EDFFXL census_center_G_reg_3_ ( .D(n998), .E(n2443), .CK(i_clk), .Q(
        census_center_G[3]) );
  EDFFXL census_center_G_reg_4_ ( .D(n999), .E(n2443), .CK(i_clk), .Q(
        census_center_G[4]) );
  EDFFXL census_center_G_reg_5_ ( .D(n1000), .E(n2443), .CK(i_clk), .Q(
        census_center_G[5]) );
  EDFFXL census_center_G_reg_6_ ( .D(n2436), .E(n2443), .CK(i_clk), .Q(
        census_center_G[6]) );
  EDFFXL census_center_G_reg_7_ ( .D(n2437), .E(n2443), .CK(i_clk), .Q(
        census_center_G[7]) );
  EDFFXL census_center_R_reg_1_ ( .D(n2440), .E(n2443), .CK(i_clk), .Q(
        census_center_R[1]) );
  EDFFXL census_center_R_reg_4_ ( .D(n2315), .E(n2443), .CK(i_clk), .Q(
        census_center_R[4]) );
  EDFFXL census_center_R_reg_6_ ( .D(n2441), .E(n2443), .CK(i_clk), .Q(
        census_center_R[6]) );
  EDFFXL census_center_R_reg_7_ ( .D(n2442), .E(n2443), .CK(i_clk), .Q(
        census_center_R[7]) );
  DFFRX1 display_col_reg_3_ ( .D(display_col_nxt[3]), .CK(i_clk), .RN(n2446), 
        .Q(display_col[3]), .QN(n2416) );
  DFFQX1 out_data_reg_6_ ( .D(out_data_nxt[6]), .CK(i_clk), .Q(out_data[6]) );
  DFFRX2 state_reg_2_ ( .D(n940), .CK(i_clk), .RN(n2445), .Q(state[2]), .QN(
        n2399) );
  DFFQX1 sorter_sort_G_r_reg_7__6_ ( .D(n880), .CK(i_clk), .Q(
        sorter_sort_G_r_7__6_) );
  DFFQX1 out_data_reg_0_ ( .D(out_data_nxt[0]), .CK(i_clk), .Q(out_data[0]) );
  DFFSX4 dis_size_reg_0_ ( .D(n950), .CK(i_clk), .SN(i_rst_n), .Q(dis_size[0]), 
        .QN(n2427) );
  EDFFXL census_center_R_reg_5_ ( .D(n2438), .E(n2443), .CK(i_clk), .Q(
        census_center_R[5]) );
  DFFQX1 out_data_reg_2_ ( .D(out_data_nxt[2]), .CK(i_clk), .Q(out_data[2]) );
  DFFRX4 cnt_9_reg_2_ ( .D(N310), .CK(i_clk), .RN(n2445), .Q(cnt_9[2]), .QN(
        n2405) );
  DFFQX1 out_data_reg_7_ ( .D(out_data_nxt[7]), .CK(i_clk), .Q(out_data[7]) );
  DFFQX1 out_data_reg_3_ ( .D(out_data_nxt[3]), .CK(i_clk), .Q(out_data[3]) );
  DFFQX1 out_data_reg_22_ ( .D(out_data_nxt[22]), .CK(i_clk), .Q(out_data[22])
         );
  DFFQX1 out_data_reg_4_ ( .D(out_data_nxt[4]), .CK(i_clk), .Q(out_data[4]) );
  DFFQX1 out_data_reg_5_ ( .D(out_data_nxt[5]), .CK(i_clk), .Q(out_data[5]) );
  DFFQX1 out_data_reg_15_ ( .D(out_data_nxt[15]), .CK(i_clk), .Q(out_data[15])
         );
  OAI21XL U1063 ( .A0(n2065), .A1(n2060), .B0(n2059), .Y(n914) );
  OAI21XL U1064 ( .A0(n2066), .A1(n2065), .B0(n2064), .Y(n916) );
  OAI21XL U1065 ( .A0(n2045), .A1(n2065), .B0(n2044), .Y(n920) );
  OAI21XL U1066 ( .A0(n2054), .A1(n2065), .B0(n2053), .Y(n917) );
  OAI21XL U1067 ( .A0(n2048), .A1(n2065), .B0(n2047), .Y(n919) );
  OAI21XL U1068 ( .A0(n1211), .A1(n2086), .B0(n1210), .Y(n910) );
  OAI21XL U1069 ( .A0(n2162), .A1(n2182), .B0(n2161), .Y(n880) );
  OAI21XL U1070 ( .A0(n2139), .A1(n2104), .B0(n1229), .Y(n902) );
  OAI21XL U1071 ( .A0(n1087), .A1(n2251), .B0(n1086), .Y(n851) );
  OAI21XL U1072 ( .A0(n1084), .A1(n2251), .B0(n1083), .Y(n852) );
  OAI21XL U1073 ( .A0(n1072), .A1(n2251), .B0(n1071), .Y(n856) );
  NAND2X1 U1074 ( .A(n2189), .B(n2214), .Y(n2212) );
  NAND2X1 U1075 ( .A(n2273), .B(n2282), .Y(n2278) );
  NAND2X1 U1076 ( .A(n1733), .B(n957), .Y(n1734) );
  NAND2X1 U1077 ( .A(n1704), .B(n957), .Y(n1724) );
  NOR2X1 U1078 ( .A(n2165), .B(n2164), .Y(n2166) );
  AOI211X1 U1079 ( .A0(sorter_sort_G_r_5__1_), .A1(n964), .B0(n1070), .C0(n956), .Y(n1071) );
  AOI211X1 U1080 ( .A0(sorter_sort_G_r_5__3_), .A1(n964), .B0(n1076), .C0(n956), .Y(n1077) );
  AOI211X1 U1081 ( .A0(sorter_sort_G_r_5__5_), .A1(n964), .B0(n1082), .C0(
        n2174), .Y(n1083) );
  AOI211X1 U1082 ( .A0(sorter_sort_G_r_5__6_), .A1(n964), .B0(n1085), .C0(
        n2174), .Y(n1086) );
  AOI211X1 U1083 ( .A0(sorter_sort_G_r_7__2_), .A1(n2210), .B0(n2209), .C0(
        n956), .Y(n2211) );
  AOI211X1 U1084 ( .A0(sorter_sort_G_r_7__4_), .A1(n2210), .B0(n2196), .C0(
        n956), .Y(n2197) );
  AOI211X1 U1085 ( .A0(sorter_sort_G_r_7__6_), .A1(n2210), .B0(n2190), .C0(
        n956), .Y(n2191) );
  AOI211X1 U1086 ( .A0(sorter_sort_G_r_7__3_), .A1(n2210), .B0(n2199), .C0(
        n956), .Y(n2200) );
  AOI211X1 U1087 ( .A0(sorter_sort_G_r_7__1_), .A1(n2210), .B0(n2202), .C0(
        n956), .Y(n2203) );
  AOI211X1 U1088 ( .A0(sorter_sort_G_r_7__0_), .A1(n2210), .B0(n2205), .C0(
        n956), .Y(n2206) );
  AOI211X1 U1089 ( .A0(sorter_sort_R_r_8__3_), .A1(n2264), .B0(n2255), .C0(
        n956), .Y(n2256) );
  AOI211X1 U1090 ( .A0(sorter_sort_R_r_8__1_), .A1(n2264), .B0(n2258), .C0(
        n956), .Y(n2259) );
  INVX4 U1091 ( .A(n2063), .Y(n2040) );
  NOR2XL U1092 ( .A(n2178), .B(n2219), .Y(n2165) );
  NOR2X1 U1093 ( .A(n2301), .B(n2346), .Y(n2283) );
  OAI21XL U1094 ( .A0(cnt_255[5]), .A1(n1645), .B0(n1523), .Y(n2383) );
  XNOR2X1 U1095 ( .A(n2008), .B(n2007), .Y(n2009) );
  XOR2X1 U1096 ( .A(n2372), .B(n2371), .Y(n2373) );
  INVX3 U1097 ( .A(n2282), .Y(n2303) );
  INVX4 U1098 ( .A(n2042), .Y(n2063) );
  OR2X1 U1099 ( .A(n1803), .B(n2414), .Y(n1861) );
  OAI21X1 U1100 ( .A0(n2359), .A1(n1535), .B0(n1538), .Y(n1240) );
  NAND2X2 U1101 ( .A(n1825), .B(n1824), .Y(n2042) );
  INVX6 U1102 ( .A(n962), .Y(n964) );
  NAND2X1 U1103 ( .A(n1507), .B(cnt_255[4]), .Y(n1521) );
  INVX12 U1104 ( .A(n1331), .Y(n1293) );
  OR2X1 U1105 ( .A(n1094), .B(n1093), .Y(n1505) );
  CLKINVX1 U1106 ( .A(n1130), .Y(n1416) );
  AOI21X2 U1107 ( .A0(n1693), .A1(n1769), .B0(n1692), .Y(n1760) );
  NOR2X4 U1108 ( .A(n1034), .B(n1033), .Y(n2180) );
  OR2X1 U1109 ( .A(n1118), .B(n1117), .Y(n1233) );
  NOR2X1 U1110 ( .A(n1987), .B(n1986), .Y(n1998) );
  NOR2X1 U1111 ( .A(n1920), .B(n1919), .Y(n1953) );
  NOR2X1 U1112 ( .A(n1975), .B(n1974), .Y(n1994) );
  NOR2X1 U1113 ( .A(n1103), .B(n1102), .Y(n1528) );
  AOI21X1 U1114 ( .A0(n1912), .A1(n1899), .B0(n1911), .Y(n1939) );
  OR2X1 U1115 ( .A(n1910), .B(n1909), .Y(n1912) );
  CLKBUFX3 U1116 ( .A(n1135), .Y(n2442) );
  NAND2X2 U1117 ( .A(n1192), .B(n1191), .Y(n1193) );
  NAND2X1 U1118 ( .A(n2038), .B(n1594), .Y(n1563) );
  OAI21XL U1119 ( .A0(n1156), .A1(n1155), .B0(n1154), .Y(n1158) );
  BUFX4 U1120 ( .A(n1142), .Y(n2438) );
  NAND2X4 U1121 ( .A(n1870), .B(n2038), .Y(n1676) );
  OAI21X1 U1122 ( .A0(n1623), .A1(n1622), .B0(n1621), .Y(n1626) );
  AOI211X1 U1123 ( .A0(n2231), .A1(sorter_sort_G_r_7__1_), .B0(
        sorter_sort_G_r_7__0_), .C0(n2245), .Y(n1004) );
  INVX6 U1124 ( .A(n2448), .Y(n2330) );
  NOR2X1 U1125 ( .A(n1694), .B(n1173), .Y(n1142) );
  NOR2XL U1126 ( .A(n1993), .B(n1180), .Y(n1179) );
  INVX3 U1127 ( .A(n2451), .Y(n2245) );
  NOR2XL U1128 ( .A(n2440), .B(n2271), .Y(n1297) );
  AOI22X1 U1129 ( .A0(n2448), .A1(n1320), .B0(n2440), .B1(n2271), .Y(n1295) );
  INVX6 U1130 ( .A(n2450), .Y(n2227) );
  NOR2X6 U1131 ( .A(n1885), .B(n1180), .Y(n1177) );
  NOR2X6 U1132 ( .A(n2367), .B(n1173), .Y(n1140) );
  NOR2X6 U1133 ( .A(n1550), .B(n1173), .Y(n2448) );
  NOR2X1 U1134 ( .A(n2432), .B(n2057), .Y(n1183) );
  NOR2X2 U1135 ( .A(n1880), .B(n1180), .Y(n1178) );
  NOR2X6 U1136 ( .A(n1134), .B(n1173), .Y(n2449) );
  BUFX12 U1137 ( .A(n1174), .Y(n2434) );
  BUFX12 U1138 ( .A(n1139), .Y(n2440) );
  NOR2X4 U1139 ( .A(n1949), .B(n1180), .Y(n1175) );
  AOI2BB1X1 U1140 ( .A0N(n965), .A1N(n1872), .B0(n990), .Y(n991) );
  NAND2X2 U1141 ( .A(n1462), .B(n987), .Y(n1509) );
  NOR2X1 U1142 ( .A(display_col[3]), .B(display_col[2]), .Y(n1842) );
  NAND2BXL U1143 ( .AN(n965), .B(display_row[1]), .Y(n980) );
  AOI2BB1X2 U1144 ( .A0N(n965), .A1N(display_col[1]), .B0(n976), .Y(n977) );
  NAND2X1 U1145 ( .A(cnt_9[0]), .B(cnt_9[2]), .Y(n1253) );
  INVX1 U1146 ( .A(n1566), .Y(n969) );
  NOR2X1 U1147 ( .A(n996), .B(n2234), .Y(n1041) );
  OAI2BB2XL U1148 ( .B0(n1649), .B1(n1648), .A0N(n2432), .A1N(n1647), .Y(n1650) );
  ADDHXL U1149 ( .A(n1949), .B(n1907), .CO(n1905), .S(n1896) );
  OAI21XL U1150 ( .A0(n1297), .A1(n1296), .B0(n1295), .Y(n1299) );
  AOI22XL U1151 ( .A0(n2450), .A1(n2230), .B0(n998), .B1(n2226), .Y(n1044) );
  OAI2BB1X1 U1152 ( .A0N(n1300), .A1N(n1299), .B0(n1298), .Y(n1301) );
  NAND2XL U1153 ( .A(n1920), .B(n1919), .Y(n1954) );
  NOR2XL U1154 ( .A(n2238), .B(sorter_sort_G_r_5__4_), .Y(n1047) );
  CLKINVX1 U1155 ( .A(n962), .Y(n963) );
  NOR2X1 U1156 ( .A(n1636), .B(n1224), .Y(n1226) );
  AOI22XL U1157 ( .A0(n2441), .A1(n1313), .B0(n2438), .B1(n1317), .Y(n1303) );
  NAND2XL U1158 ( .A(n1118), .B(n1117), .Y(n1231) );
  NAND2XL U1159 ( .A(n1125), .B(n1124), .Y(n1397) );
  NOR2X4 U1160 ( .A(n1805), .B(n965), .Y(n978) );
  NAND2XL U1161 ( .A(n2180), .B(sorter_sort_G_r_8__6_), .Y(n2158) );
  NAND2XL U1162 ( .A(n2437), .B(n2186), .Y(n2187) );
  NOR2X1 U1163 ( .A(q_R[1]), .B(q_G[0]), .Y(n1500) );
  NAND2X2 U1164 ( .A(n978), .B(display_row[0]), .Y(n1806) );
  NAND2XL U1165 ( .A(origin_col[3]), .B(origin_col[2]), .Y(n1467) );
  NOR2X1 U1166 ( .A(state[0]), .B(n2396), .Y(n1578) );
  NOR2XL U1167 ( .A(n2246), .B(n2227), .Y(n1073) );
  OAI22X1 U1168 ( .A0(n1009), .A1(n1008), .B0(n2436), .B1(n2162), .Y(n1010) );
  NOR2XL U1169 ( .A(n2178), .B(n2227), .Y(n2179) );
  NOR2XL U1170 ( .A(n2082), .B(n2093), .Y(n2073) );
  NOR2X2 U1171 ( .A(n2282), .B(n1309), .Y(n2275) );
  INVXL U1172 ( .A(n1706), .Y(n1723) );
  INVXL U1173 ( .A(n1861), .Y(n1432) );
  NAND2XL U1174 ( .A(n1440), .B(n1551), .Y(n2025) );
  NOR2XL U1175 ( .A(n1448), .B(n1352), .Y(n1469) );
  CLKINVX2 U1176 ( .A(q_B[3]), .Y(n1965) );
  INVXL U1177 ( .A(n1588), .Y(n1448) );
  INVXL U1178 ( .A(out_median[12]), .Y(n1081) );
  INVXL U1179 ( .A(sorter_sort_G_r_5__5_), .Y(n2222) );
  AOI211X1 U1180 ( .A0(sorter_sort_G_r_7__5_), .A1(n2210), .B0(n2193), .C0(
        n956), .Y(n2194) );
  INVXL U1181 ( .A(out_median[7]), .Y(n2122) );
  INVXL U1182 ( .A(sorter_sort_B_r_8__7_), .Y(n2013) );
  INVXL U1183 ( .A(out_median[20]), .Y(n2341) );
  INVXL U1184 ( .A(sorter_sort_R_r_5__5_), .Y(n2288) );
  INVXL U1185 ( .A(sorter_sort_R_r_6__6_), .Y(n1313) );
  NAND2X1 U1186 ( .A(n961), .B(n2273), .Y(n2266) );
  CLKINVX1 U1187 ( .A(q_R[5]), .Y(n1694) );
  INVXL U1188 ( .A(display_col_nxt[3]), .Y(n1853) );
  NAND2X6 U1189 ( .A(n1035), .B(n973), .Y(n2038) );
  AOI21XL U1190 ( .A0(n1642), .A1(n1521), .B0(n2380), .Y(n1523) );
  OAI211XL U1191 ( .A0(n957), .A1(n2012), .B0(n2011), .C0(n2010), .Y(
        out_data_nxt[7]) );
  OAI21XL U1192 ( .A0(n1038), .A1(n2182), .B0(n1037), .Y(n878) );
  NAND2XL U1193 ( .A(n1822), .B(n958), .Y(n884) );
  OAI21XL U1194 ( .A0(n2127), .A1(n2104), .B0(n2097), .Y(n899) );
  OAI21XL U1195 ( .A0(n2051), .A1(n2065), .B0(n2050), .Y(n918) );
  OAI21XL U1196 ( .A0(n1310), .A1(n2266), .B0(n1169), .Y(n841) );
  NAND2XL U1197 ( .A(n1855), .B(n958), .Y(n849) );
  OAI21XL U1198 ( .A0(n957), .A1(n1141), .B0(n1122), .Y(out_data_nxt[20]) );
  CLKINVX2 U1199 ( .A(q_B[0]), .Y(n1943) );
  CLKINVX1 U1200 ( .A(q_B[7]), .Y(n2012) );
  NAND2X1 U1201 ( .A(n1679), .B(n958), .Y(n885) );
  NAND2X1 U1202 ( .A(n1681), .B(n958), .Y(n882) );
  INVX1 U1203 ( .A(n964), .Y(n1068) );
  NAND2X1 U1204 ( .A(n2163), .B(n958), .Y(n2164) );
  NAND2X4 U1205 ( .A(n2084), .B(n2042), .Y(n2061) );
  NAND2X1 U1206 ( .A(n1856), .B(n958), .Y(n848) );
  NAND2X1 U1207 ( .A(n1857), .B(n958), .Y(n847) );
  NAND2X1 U1208 ( .A(n1860), .B(n958), .Y(n846) );
  NAND2X1 U1209 ( .A(n1854), .B(n958), .Y(n845) );
  NAND2X1 U1210 ( .A(n1858), .B(n958), .Y(n844) );
  NAND2X1 U1211 ( .A(n1836), .B(n958), .Y(n843) );
  INVX8 U1212 ( .A(n2102), .Y(n1227) );
  INVX6 U1213 ( .A(n1309), .Y(n2273) );
  AND2X4 U1214 ( .A(n1585), .B(n1308), .Y(n2282) );
  NAND2X1 U1215 ( .A(n1654), .B(n1653), .Y(n1656) );
  NAND2X1 U1216 ( .A(n1631), .B(n1630), .Y(n1632) );
  NAND2X1 U1217 ( .A(n1065), .B(n1064), .Y(n1066) );
  INVX3 U1218 ( .A(n2438), .Y(n2342) );
  INVX4 U1219 ( .A(n2442), .Y(n2016) );
  INVX6 U1220 ( .A(n2437), .Y(n2185) );
  AOI22X1 U1221 ( .A0(n2441), .A1(n1310), .B0(n2438), .B1(n1314), .Y(n1162) );
  NAND2X1 U1222 ( .A(n1177), .B(n1657), .Y(n1659) );
  NAND2X1 U1223 ( .A(n2435), .B(n1661), .Y(n1664) );
  NAND2X1 U1224 ( .A(n1121), .B(n957), .Y(n1122) );
  NAND2X1 U1225 ( .A(n1241), .B(n957), .Y(n1242) );
  BUFX4 U1226 ( .A(n1001), .Y(n2436) );
  BUFX12 U1227 ( .A(n1175), .Y(n2432) );
  INVX2 U1228 ( .A(n2315), .Y(n2338) );
  OAI211X1 U1229 ( .A0(n1396), .A1(n1395), .B0(n1394), .C0(n1393), .Y(n1402)
         );
  NAND2X1 U1230 ( .A(n1548), .B(n957), .Y(n1549) );
  NAND2X1 U1231 ( .A(n1533), .B(n957), .Y(n1534) );
  NAND2X2 U1232 ( .A(n2009), .B(n957), .Y(n2010) );
  NAND2X2 U1233 ( .A(n1747), .B(n957), .Y(n1748) );
  NAND3XL U1234 ( .A(n1863), .B(n1842), .C(n1395), .Y(n1132) );
  AOI211X1 U1235 ( .A0(n1462), .A1(origin_col[0]), .B0(n1461), .C0(n1468), .Y(
        n1465) );
  INVX1 U1236 ( .A(n1509), .Y(n1468) );
  INVX1 U1237 ( .A(n1726), .Y(n1784) );
  BUFX8 U1238 ( .A(n978), .Y(n1462) );
  INVXL U1239 ( .A(n1564), .Y(n2394) );
  AND2X2 U1240 ( .A(n1972), .B(n1973), .Y(n1873) );
  AND2X2 U1241 ( .A(n1927), .B(n1928), .Y(n1881) );
  NAND2XL U1242 ( .A(n1233), .B(n1231), .Y(n1119) );
  BUFX12 U1243 ( .A(n2174), .Y(n956) );
  NOR2X1 U1244 ( .A(n1542), .B(q_G[7]), .Y(n2368) );
  INVX1 U1245 ( .A(n1531), .Y(n1104) );
  INVX3 U1246 ( .A(display_col[1]), .Y(n1872) );
  INVX4 U1247 ( .A(q_G[7]), .Y(n1883) );
  INVX1 U1248 ( .A(sorter_sort_G_r_5__3_), .Y(n2226) );
  INVX4 U1249 ( .A(q_R[3]), .Y(n2367) );
  INVX4 U1250 ( .A(q_G[2]), .Y(n1789) );
  NAND2X1 U1251 ( .A(n1830), .B(n958), .Y(n924) );
  NAND2X1 U1252 ( .A(n1828), .B(n958), .Y(n927) );
  NAND2X1 U1253 ( .A(n1832), .B(n958), .Y(n928) );
  NAND2X1 U1254 ( .A(n1829), .B(n958), .Y(n926) );
  NAND2X1 U1255 ( .A(n1831), .B(n958), .Y(n925) );
  NAND2X1 U1256 ( .A(n1826), .B(n958), .Y(n922) );
  NAND2X1 U1257 ( .A(n1827), .B(n958), .Y(n923) );
  NAND2X1 U1258 ( .A(n1818), .B(n958), .Y(n886) );
  NAND2X1 U1259 ( .A(n1819), .B(n958), .Y(n887) );
  NOR2X1 U1260 ( .A(n2061), .B(n2107), .Y(n2055) );
  NAND2X1 U1261 ( .A(n1817), .B(n958), .Y(n883) );
  NAND2X1 U1262 ( .A(n1820), .B(n958), .Y(n888) );
  AOI211X1 U1263 ( .A0(sorter_sort_R_r_5__3_), .A1(n2354), .B0(n2335), .C0(
        n956), .Y(n2336) );
  INVX6 U1264 ( .A(n2189), .Y(n2210) );
  OAI2BB1X2 U1265 ( .A0N(sorter_sort_B_r_8__7_), .A1N(n2014), .B0(n1823), .Y(
        n1825) );
  OA21X4 U1266 ( .A0(n2437), .A1(n1011), .B0(n1584), .Y(n2189) );
  NAND2X1 U1267 ( .A(n1656), .B(n1655), .Y(n1660) );
  NAND2X1 U1268 ( .A(n1219), .B(n1218), .Y(n1221) );
  OAI2BB1X1 U1269 ( .A0N(sorter_sort_B_r_8__2_), .A1N(n2108), .B0(n1650), .Y(
        n1654) );
  NAND2X1 U1270 ( .A(n2320), .B(n2319), .Y(n2322) );
  NAND2X1 U1271 ( .A(n1664), .B(n1663), .Y(n1665) );
  NAND2X1 U1272 ( .A(n2429), .B(n1662), .Y(n1663) );
  AOI22X1 U1273 ( .A0(n2435), .A1(n2069), .B0(n2429), .B1(n2072), .Y(n1203) );
  INVX6 U1274 ( .A(n998), .Y(n2223) );
  AOI22X1 U1275 ( .A0(n2435), .A1(n2147), .B0(n2429), .B1(n2143), .Y(n1220) );
  NAND2X1 U1276 ( .A(n1791), .B(n1790), .Y(display_row_nxt[2]) );
  NAND2X1 U1277 ( .A(n1816), .B(n1807), .Y(display_row_nxt[1]) );
  INVX6 U1278 ( .A(n2452), .Y(n2014) );
  INVX1 U1279 ( .A(display_col_nxt[1]), .Y(n1266) );
  NAND2X1 U1280 ( .A(n1582), .B(n1676), .Y(n1598) );
  NAND2X1 U1281 ( .A(n1126), .B(n1676), .Y(n1415) );
  OAI21X1 U1282 ( .A0(n1503), .A1(n1100), .B0(n1501), .Y(n1099) );
  INVX1 U1283 ( .A(n1769), .Y(n1775) );
  INVX8 U1284 ( .A(n1505), .Y(n957) );
  INVX1 U1285 ( .A(n2376), .Y(n1334) );
  INVX1 U1286 ( .A(n1908), .Y(n1899) );
  INVX3 U1287 ( .A(n1243), .Y(n1321) );
  NAND2X1 U1288 ( .A(n1689), .B(n1714), .Y(n1773) );
  NOR2X1 U1289 ( .A(n1091), .B(n1333), .Y(n1094) );
  NOR2X1 U1290 ( .A(n966), .B(cnt_9[0]), .Y(n1564) );
  BUFX12 U1291 ( .A(n2027), .Y(n965) );
  CLKINVX1 U1292 ( .A(n1526), .Y(n1576) );
  NAND2X2 U1293 ( .A(dis_size[0]), .B(n985), .Y(n987) );
  NAND2X1 U1294 ( .A(origin_row[2]), .B(origin_row[3]), .Y(n1451) );
  NOR2X2 U1295 ( .A(n2397), .B(dis_size[1]), .Y(n968) );
  INVX6 U1296 ( .A(q_R[4]), .Y(n1141) );
  INVX6 U1297 ( .A(q_G[1]), .Y(n1907) );
  INVX1 U1298 ( .A(sorter_sort_G_r_6__4_), .Y(n2198) );
  INVX3 U1299 ( .A(q_B[2]), .Y(n1960) );
  INVXL U1300 ( .A(sorter_sort_G_r_7__4_), .Y(n1038) );
  INVX1 U1301 ( .A(out_median[13]), .Y(n1084) );
  INVX1 U1302 ( .A(sorter_sort_B_r_6__4_), .Y(n1211) );
  INVX1 U1303 ( .A(sorter_sort_B_r_6__6_), .Y(n2069) );
  INVX1 U1304 ( .A(sorter_sort_B_r_6__5_), .Y(n2072) );
  INVX1 U1305 ( .A(sorter_sort_R_r_6__3_), .Y(n1341) );
  INVX1 U1306 ( .A(sorter_sort_B_r_7__4_), .Y(n2051) );
  INVX1 U1307 ( .A(sorter_sort_B_r_7__5_), .Y(n2048) );
  INVX1 U1308 ( .A(sorter_sort_R_r_5__4_), .Y(n2291) );
  INVX1 U1309 ( .A(sorter_sort_B_r_8__4_), .Y(n1657) );
  INVX1 U1310 ( .A(sorter_sort_B_r_8__5_), .Y(n1662) );
  INVX1 U1311 ( .A(out_median[21]), .Y(n2345) );
  INVX1 U1312 ( .A(sorter_sort_B_r_7__6_), .Y(n2045) );
  INVX3 U1313 ( .A(q_B[6]), .Y(n1993) );
  INVX3 U1314 ( .A(q_R[6]), .Y(n2375) );
  OAI2BB1X1 U1315 ( .A0N(n2237), .A1N(sorter_sort_G_r_5__0_), .B0(n2236), .Y(
        n858) );
  AOI211X1 U1316 ( .A0(n964), .A1(sorter_sort_G_r_5__0_), .B0(n2247), .C0(n956), .Y(n2249) );
  AOI211X1 U1317 ( .A0(sorter_sort_R_r_8__5_), .A1(n2264), .B0(n1170), .C0(
        n956), .Y(n1171) );
  AOI211X1 U1318 ( .A0(sorter_sort_R_r_8__4_), .A1(n2264), .B0(n2252), .C0(
        n956), .Y(n2253) );
  AOI211X1 U1319 ( .A0(sorter_sort_R_r_8__6_), .A1(n2264), .B0(n1168), .C0(
        n956), .Y(n1169) );
  AOI211X1 U1320 ( .A0(sorter_sort_R_r_5__6_), .A1(n2354), .B0(n2347), .C0(
        n956), .Y(n2348) );
  AOI211X1 U1321 ( .A0(sorter_sort_R_r_5__4_), .A1(n2354), .B0(n2339), .C0(
        n956), .Y(n2340) );
  AOI211X1 U1322 ( .A0(sorter_sort_R_r_5__1_), .A1(n2354), .B0(n2327), .C0(
        n956), .Y(n2328) );
  AOI211X1 U1323 ( .A0(sorter_sort_R_r_5__5_), .A1(n2354), .B0(n2343), .C0(
        n956), .Y(n2344) );
  INVX3 U1324 ( .A(n961), .Y(n2264) );
  NAND2X4 U1325 ( .A(n1669), .B(n1167), .Y(n1309) );
  NAND2X2 U1326 ( .A(n1164), .B(sorter_sort_R_r_7__7_), .Y(n1669) );
  NAND2X2 U1327 ( .A(n1305), .B(sorter_sort_R_r_6__7_), .Y(n1585) );
  OAI2BB1X1 U1328 ( .A0N(n1217), .A1N(n1216), .B0(n1215), .Y(n1219) );
  NAND2X1 U1329 ( .A(n2039), .B(n2024), .Y(display_row_nxt[3]) );
  NAND2X1 U1330 ( .A(n1050), .B(n1049), .Y(n1051) );
  NAND2X1 U1331 ( .A(n2088), .B(sorter_sort_B_r_5__6_), .Y(n1222) );
  NOR2X1 U1332 ( .A(n2442), .B(n2281), .Y(n2279) );
  INVX3 U1333 ( .A(n2441), .Y(n2346) );
  INVX3 U1334 ( .A(n2436), .Y(n2215) );
  INVX3 U1335 ( .A(n2435), .Y(n2088) );
  NOR2X1 U1336 ( .A(n2437), .B(n1635), .Y(n1053) );
  NAND2X1 U1337 ( .A(n2452), .B(n2013), .Y(n1824) );
  BUFX4 U1338 ( .A(n995), .Y(n2437) );
  NAND2X1 U1339 ( .A(n1402), .B(n1401), .Y(n1675) );
  BUFX4 U1340 ( .A(n1179), .Y(n2435) );
  OAI2BB1X1 U1341 ( .A0N(n1419), .A1N(n1430), .B0(n1418), .Y(n1677) );
  NAND2X1 U1342 ( .A(n1431), .B(n1430), .Y(n1862) );
  NOR2X1 U1343 ( .A(n1861), .B(n2412), .Y(n1865) );
  INVX1 U1344 ( .A(n1499), .Y(n1485) );
  INVX1 U1345 ( .A(n1803), .Y(n1804) );
  NOR2X1 U1346 ( .A(cnt_255[0]), .B(n1645), .Y(n2379) );
  AND2X2 U1347 ( .A(n1353), .B(n1469), .Y(n1561) );
  NOR2X1 U1348 ( .A(cnt_255[6]), .B(n1645), .Y(n2382) );
  NAND2X1 U1349 ( .A(n1863), .B(n1428), .Y(n1803) );
  XOR2X1 U1350 ( .A(n2004), .B(n1962), .Y(n1963) );
  NAND2X1 U1351 ( .A(n2391), .B(n2389), .Y(n1353) );
  NAND2X1 U1352 ( .A(n1587), .B(n1586), .Y(n1591) );
  INVX1 U1353 ( .A(n1563), .Y(n1247) );
  OA21X2 U1354 ( .A0(n1468), .A1(n1467), .B0(n1466), .Y(n1493) );
  NOR2X1 U1355 ( .A(n1572), .B(n1571), .Y(n1587) );
  OAI2BB1X2 U1356 ( .A0N(n1503), .A1N(n1100), .B0(n1099), .Y(n1103) );
  NAND2X1 U1357 ( .A(cnt_255[6]), .B(n2381), .Y(n1517) );
  NAND2X2 U1358 ( .A(n1462), .B(n1321), .Y(n992) );
  NAND4X2 U1359 ( .A(n1806), .B(n981), .C(n980), .D(n979), .Y(n982) );
  NAND2X4 U1360 ( .A(n1462), .B(n2409), .Y(n1404) );
  INVX3 U1361 ( .A(n966), .Y(n1594) );
  NAND2X4 U1362 ( .A(n1462), .B(n2401), .Y(n1811) );
  NAND3X2 U1363 ( .A(n970), .B(display_row[3]), .C(display_row[2]), .Y(n971)
         );
  NAND2X1 U1364 ( .A(n1321), .B(display_col[1]), .Y(n1395) );
  INVX1 U1365 ( .A(n1869), .Y(n1835) );
  INVX1 U1366 ( .A(n1507), .Y(n1580) );
  INVX1 U1367 ( .A(n2006), .Y(n2007) );
  INVX6 U1368 ( .A(n2174), .Y(n958) );
  AND2X1 U1369 ( .A(n1917), .B(n1904), .Y(n1895) );
  NOR2X1 U1370 ( .A(n987), .B(display_row[0]), .Y(n1429) );
  OR2X1 U1371 ( .A(n1764), .B(n1763), .Y(n1794) );
  AND2X1 U1372 ( .A(n1984), .B(n1985), .Y(n1876) );
  NOR2X4 U1373 ( .A(state[2]), .B(n1514), .Y(n966) );
  NOR2X1 U1374 ( .A(n2399), .B(n1514), .Y(n1091) );
  AND2X1 U1375 ( .A(n1740), .B(n1741), .Y(n1705) );
  AND2X1 U1376 ( .A(n1708), .B(n1707), .Y(n1709) );
  AND2X1 U1377 ( .A(n1714), .B(n1713), .Y(n1715) );
  AND2X1 U1378 ( .A(n1711), .B(n1710), .Y(n1712) );
  AND2X1 U1379 ( .A(n1796), .B(q_B[7]), .Y(n1716) );
  AND2X1 U1380 ( .A(n1719), .B(n1718), .Y(n1720) );
  INVX2 U1381 ( .A(n1500), .Y(n1100) );
  NOR2X1 U1382 ( .A(n1092), .B(op[1]), .Y(n1463) );
  INVX1 U1383 ( .A(sorter_sort_R_r_8__7_), .Y(n2015) );
  INVX1 U1384 ( .A(sorter_sort_B_r_6__1_), .Y(n2078) );
  INVX1 U1385 ( .A(q_R[1]), .Y(n1717) );
  INVX1 U1386 ( .A(sorter_sort_R_r_6__4_), .Y(n1338) );
  INVX1 U1387 ( .A(sorter_sort_R_r_6__5_), .Y(n1317) );
  INVX1 U1388 ( .A(out_median[14]), .Y(n1087) );
  INVX1 U1389 ( .A(out_median[22]), .Y(n2350) );
  INVX3 U1390 ( .A(q_R[7]), .Y(n1545) );
  INVX1 U1391 ( .A(out_median[23]), .Y(n2321) );
  INVXL U1392 ( .A(out_median[9]), .Y(n1072) );
  INVX1 U1393 ( .A(sorter_sort_G_r_6__1_), .Y(n2204) );
  INVX1 U1394 ( .A(sorter_sort_G_r_6__7_), .Y(n2186) );
  INVX1 U1395 ( .A(sorter_sort_G_r_6__5_), .Y(n2195) );
  INVX1 U1396 ( .A(out_median[6]), .Y(n2150) );
  NOR2X1 U1397 ( .A(n2396), .B(n2410), .Y(n1089) );
  INVX1 U1398 ( .A(sorter_sort_G_r_5__6_), .Y(n2218) );
  INVX1 U1399 ( .A(sorter_sort_B_r_5__6_), .Y(n2147) );
  INVX1 U1400 ( .A(sorter_sort_B_r_5__5_), .Y(n2143) );
  INVX1 U1401 ( .A(sorter_sort_G_r_7__6_), .Y(n2162) );
  INVX1 U1402 ( .A(sorter_sort_G_r_8__7_), .Y(n1471) );
  NOR2X1 U1403 ( .A(n2407), .B(state[2]), .Y(n1088) );
  INVX2 U1404 ( .A(q_G[4]), .Y(n1884) );
  INVX1 U1405 ( .A(sorter_sort_B_r_5__7_), .Y(n1641) );
  INVX4 U1406 ( .A(q_R[1]), .Y(n1138) );
  INVX1 U1407 ( .A(1'b0), .Y(o_in_ready) );
  AOI211X1 U1409 ( .A0(sorter_sort_R_r_8__2_), .A1(n2264), .B0(n2263), .C0(
        n956), .Y(n2265) );
  AOI211X1 U1410 ( .A0(sorter_sort_R_r_8__0_), .A1(n2264), .B0(n2260), .C0(
        n956), .Y(n2261) );
  NOR2X1 U1411 ( .A(n2100), .B(n2106), .Y(n2098) );
  AOI22X1 U1412 ( .A0(sorter_sort_G_r_8__2_), .A1(n2227), .B0(n2223), .B1(
        sorter_sort_G_r_8__3_), .Y(n1022) );
  OAI21X1 U1413 ( .A0(n2004), .A1(n1966), .B0(n1968), .Y(n1933) );
  OAI21X1 U1414 ( .A0(n1183), .A1(n1182), .B0(n1181), .Y(n1185) );
  ADDHX2 U1415 ( .A(n1718), .B(n1719), .CO(n1698), .S(n1695) );
  NOR2X1 U1416 ( .A(n2231), .B(sorter_sort_G_r_5__1_), .Y(n1042) );
  INVX8 U1417 ( .A(n996), .Y(n2231) );
  NOR2X4 U1418 ( .A(n2126), .B(n2125), .Y(n2154) );
  OAI21X1 U1419 ( .A0(n1075), .A1(n2251), .B0(n1074), .Y(n855) );
  OAI21X1 U1420 ( .A0(n1078), .A1(n2251), .B0(n1077), .Y(n854) );
  NOR2X2 U1421 ( .A(n2303), .B(n2354), .Y(n2300) );
  AOI211X1 U1422 ( .A0(sorter_sort_G_r_6__1_), .A1(n2241), .B0(n2232), .C0(
        n956), .Y(n2233) );
  AOI211X1 U1423 ( .A0(sorter_sort_G_r_6__3_), .A1(n2241), .B0(n2224), .C0(
        n956), .Y(n2225) );
  AOI211X1 U1424 ( .A0(sorter_sort_G_r_6__2_), .A1(n2241), .B0(n2228), .C0(
        n956), .Y(n2229) );
  AOI211X1 U1425 ( .A0(sorter_sort_G_r_6__4_), .A1(n2241), .B0(n2240), .C0(
        n956), .Y(n2242) );
  AOI211X1 U1426 ( .A0(sorter_sort_G_r_6__5_), .A1(n2241), .B0(n2220), .C0(
        n956), .Y(n2221) );
  NOR2X2 U1427 ( .A(n2082), .B(n2088), .Y(n2067) );
  ADDHX1 U1428 ( .A(q_R[7]), .B(n2005), .CO(n2006), .S(n1986) );
  OAI2BB1X2 U1429 ( .A0N(sorter_sort_G_r_6__7_), .A1N(n2185), .B0(n2184), .Y(
        n2188) );
  OAI21X1 U1430 ( .A0(n2218), .A1(n2243), .B0(n2217), .Y(n864) );
  NAND2X4 U1431 ( .A(n1676), .B(n1594), .Y(n1417) );
  BUFX12 U1432 ( .A(n1859), .Y(n961) );
  OAI21X2 U1433 ( .A0(sorter_sort_R_r_8__7_), .A1(n2016), .B0(n1153), .Y(n1859) );
  NOR2X1 U1434 ( .A(n2061), .B(n2114), .Y(n2049) );
  NAND2X4 U1435 ( .A(n2041), .B(n2040), .Y(n2065) );
  INVX3 U1436 ( .A(n2356), .Y(n2349) );
  AOI21X1 U1437 ( .A0(n2001), .A1(n2000), .B0(n1999), .Y(n2002) );
  OAI21X2 U1438 ( .A0(n1969), .A1(n1968), .B0(n1967), .Y(n2001) );
  NOR2X1 U1439 ( .A(n2160), .B(n2159), .Y(n2161) );
  OAI21X1 U1440 ( .A0(n1735), .A1(n1141), .B0(n1108), .Y(n1111) );
  INVX12 U1441 ( .A(n2248), .Y(n962) );
  AOI21X4 U1442 ( .A0(n1922), .A1(n1944), .B0(n1921), .Y(n2004) );
  OAI21X2 U1443 ( .A0(n1939), .A1(n1936), .B0(n1937), .Y(n1944) );
  OAI21X1 U1444 ( .A0(n2367), .A1(n1789), .B0(n1106), .Y(n1109) );
  OAI211X1 U1445 ( .A0(n1245), .A1(n1872), .B0(n1261), .C0(n1244), .Y(
        display_col_nxt[1]) );
  ADDHX1 U1446 ( .A(n1985), .B(n1984), .CO(n1987), .S(n1974) );
  OAI21X1 U1447 ( .A0(n1004), .A1(n1003), .B0(n1002), .Y(n1007) );
  AOI22X1 U1448 ( .A0(sorter_sort_G_r_7__2_), .A1(n2227), .B0(n2223), .B1(
        sorter_sort_G_r_7__3_), .Y(n1002) );
  OAI22X1 U1449 ( .A0(sorter_sort_G_r_7__2_), .A1(n2227), .B0(n2231), .B1(
        sorter_sort_G_r_7__1_), .Y(n1003) );
  OAI21X1 U1450 ( .A0(n1688), .A1(n1687), .B0(n1686), .Y(n1769) );
  INVX3 U1451 ( .A(n1642), .Y(n1645) );
  NOR2X2 U1452 ( .A(n1416), .B(n1415), .Y(n1430) );
  AND2X1 U1453 ( .A(n997), .B(n1943), .Y(n1898) );
  NAND2XL U1454 ( .A(n1421), .B(n1249), .Y(n1250) );
  NAND2XL U1455 ( .A(n2442), .B(n2321), .Y(n2320) );
  NOR2X2 U1456 ( .A(n1966), .B(n1969), .Y(n1995) );
  AND4X1 U1457 ( .A(n2005), .B(n1901), .C(n1923), .D(n1900), .Y(n1902) );
  NAND2XL U1458 ( .A(state[0]), .B(n1577), .Y(n1586) );
  AND4X1 U1459 ( .A(n1721), .B(n1716), .C(n1717), .D(n1720), .Y(n1722) );
  CLKINVX1 U1460 ( .A(n1417), .Y(n1414) );
  INVXL U1461 ( .A(n965), .Y(n1839) );
  AOI2BB1X2 U1462 ( .A0N(n1048), .A1N(n1047), .B0(n1046), .Y(n1052) );
  NAND2XL U1463 ( .A(n1000), .B(n2222), .Y(n1049) );
  INVX3 U1464 ( .A(n2180), .Y(n1821) );
  AOI22XL U1465 ( .A0(n2441), .A1(n2285), .B0(n2438), .B1(n2288), .Y(n1616) );
  NAND2XL U1466 ( .A(n2315), .B(n1143), .Y(n1150) );
  NAND2XL U1467 ( .A(n1255), .B(n2378), .Y(n1256) );
  NOR2XL U1468 ( .A(n1420), .B(n1254), .Y(n1255) );
  NOR2XL U1469 ( .A(n1253), .B(cnt_9[1]), .Y(n1254) );
  NAND2XL U1470 ( .A(n1462), .B(display_col[0]), .Y(n1403) );
  NAND2XL U1471 ( .A(n1454), .B(n1594), .Y(n1126) );
  NOR2X2 U1472 ( .A(n1400), .B(n1417), .Y(n1863) );
  NAND2XL U1473 ( .A(n2033), .B(n2032), .Y(n2034) );
  NOR3XL U1474 ( .A(n2031), .B(n2029), .C(n2412), .Y(n2035) );
  INVXL U1475 ( .A(n2030), .Y(n2029) );
  INVXL U1476 ( .A(n2389), .Y(n1559) );
  INVXL U1477 ( .A(n2391), .Y(n1555) );
  NAND2XL U1478 ( .A(n2245), .B(n2231), .Y(n1055) );
  NAND2XL U1479 ( .A(n2227), .B(out_median[10]), .Y(n1054) );
  INVXL U1480 ( .A(sorter_sort_B_r_8__1_), .Y(n1647) );
  NAND2XL U1481 ( .A(n2326), .B(n2351), .Y(n2308) );
  ADDFHX2 U1482 ( .A(q_R[1]), .B(n1965), .CI(n1906), .CO(n1892), .S(n1893) );
  AOI22X1 U1483 ( .A0(n2450), .A1(n2213), .B0(n996), .B1(n2204), .Y(n1621) );
  NOR2X1 U1484 ( .A(n996), .B(n2204), .Y(n1623) );
  AOI22X1 U1485 ( .A0(n2450), .A1(n1014), .B0(n996), .B1(n1013), .Y(n1015) );
  NOR2XL U1486 ( .A(n2440), .B(n2297), .Y(n1610) );
  NAND2XL U1487 ( .A(n1140), .B(n2294), .Y(n1611) );
  OAI22XL U1488 ( .A0(n1510), .A1(n1588), .B0(n1594), .B1(n1509), .Y(n1572) );
  NAND3XL U1489 ( .A(n1592), .B(n1586), .C(n1508), .Y(n1510) );
  NAND2XL U1490 ( .A(n2436), .B(n1087), .Y(n1065) );
  OAI22XL U1491 ( .A0(n1000), .A1(n2195), .B0(n999), .B1(n2198), .Y(n1627) );
  AOI22XL U1492 ( .A0(n999), .A1(n2198), .B0(n998), .B1(n2201), .Y(n1628) );
  NAND2XL U1493 ( .A(n2441), .B(n2350), .Y(n2319) );
  OAI22XL U1494 ( .A0(n2438), .A1(n1314), .B0(n2315), .B1(n2254), .Y(n1161) );
  INVXL U1495 ( .A(sorter_sort_R_r_8__3_), .Y(n1146) );
  AOI21XL U1496 ( .A0(n1684), .A1(n1134), .B0(n1683), .Y(n1687) );
  NAND2XL U1497 ( .A(n1685), .B(q_R[1]), .Y(n1686) );
  NOR2XL U1498 ( .A(n1685), .B(q_R[1]), .Y(n1688) );
  OAI21X1 U1499 ( .A0(n2360), .A1(n2357), .B0(n2361), .Y(n1234) );
  NAND2XL U1500 ( .A(n1805), .B(n2415), .Y(n1125) );
  NAND2XL U1501 ( .A(n1516), .B(n1526), .Y(n1124) );
  NAND2XL U1502 ( .A(n1405), .B(n1872), .Y(n1840) );
  NAND2XL U1503 ( .A(n1404), .B(n1595), .Y(n1405) );
  AOI21XL U1504 ( .A0(n1811), .A1(n1595), .B0(display_row[1]), .Y(n2022) );
  NOR2XL U1505 ( .A(n2028), .B(n965), .Y(n2031) );
  NOR2XL U1506 ( .A(dis_size[1]), .B(origin_row[1]), .Y(n1552) );
  INVXL U1507 ( .A(n1578), .Y(n1352) );
  NOR2XL U1508 ( .A(op[1]), .B(n2400), .Y(n1329) );
  NAND2XL U1509 ( .A(n966), .B(origin_row[2]), .Y(n1790) );
  INVXL U1510 ( .A(n1951), .Y(n1945) );
  INVXL U1511 ( .A(n1953), .Y(n1955) );
  NAND2XL U1512 ( .A(n1916), .B(n1915), .Y(n1937) );
  INVXL U1513 ( .A(n1936), .Y(n1938) );
  AND2X1 U1514 ( .A(n1910), .B(n1909), .Y(n1911) );
  OAI21XL U1515 ( .A0(n2004), .A1(n1971), .B0(n1970), .Y(n1977) );
  INVXL U1516 ( .A(n2001), .Y(n1970) );
  INVXL U1517 ( .A(n1969), .Y(n1931) );
  INVXL U1518 ( .A(n1792), .Y(n1793) );
  NAND2XL U1519 ( .A(n1987), .B(n1986), .Y(n1996) );
  INVXL U1520 ( .A(n1998), .Y(n1988) );
  NAND4X2 U1521 ( .A(n1873), .B(n1876), .C(n1881), .D(n1902), .Y(n2011) );
  NOR4XL U1522 ( .A(n1512), .B(n1511), .C(n2407), .D(n1572), .Y(n1513) );
  INVXL U1523 ( .A(n1676), .Y(n1511) );
  NOR2XL U1524 ( .A(n1507), .B(n1581), .Y(n1512) );
  INVXL U1525 ( .A(n1514), .Y(n1515) );
  NAND3XL U1526 ( .A(state[1]), .B(state[2]), .C(n1573), .Y(n1590) );
  NAND2XL U1527 ( .A(n966), .B(origin_col[2]), .Y(n1674) );
  INVXL U1528 ( .A(n1573), .Y(n1592) );
  INVXL U1529 ( .A(n1581), .Y(n1571) );
  NAND2XL U1530 ( .A(n1516), .B(n966), .Y(n1575) );
  OAI211XL U1531 ( .A0(n1581), .A1(n1580), .B0(n1586), .C0(n1579), .Y(n1582)
         );
  INVXL U1532 ( .A(sorter_sort_G_r_5__4_), .Y(n2244) );
  INVXL U1533 ( .A(sorter_sort_G_r_5__2_), .Y(n2230) );
  INVXL U1534 ( .A(sorter_sort_G_r_5__1_), .Y(n2234) );
  INVXL U1535 ( .A(out_median[5]), .Y(n2146) );
  INVXL U1536 ( .A(out_median[4]), .Y(n2142) );
  INVXL U1537 ( .A(out_median[3]), .Y(n2138) );
  INVXL U1538 ( .A(out_median[2]), .Y(n2134) );
  INVX3 U1539 ( .A(n2126), .Y(n2152) );
  INVXL U1540 ( .A(sorter_sort_B_r_5__3_), .Y(n2135) );
  INVXL U1541 ( .A(sorter_sort_B_r_5__0_), .Y(n2151) );
  INVXL U1542 ( .A(sorter_sort_R_r_6__2_), .Y(n1320) );
  INVXL U1543 ( .A(sorter_sort_R_r_6__0_), .Y(n2277) );
  INVXL U1544 ( .A(sorter_sort_R_r_7__2_), .Y(n2267) );
  INVXL U1545 ( .A(sorter_sort_R_r_7__0_), .Y(n2272) );
  INVXL U1546 ( .A(n1776), .Y(n1778) );
  NAND2XL U1547 ( .A(n1698), .B(n1697), .Y(n1729) );
  NAND2XL U1548 ( .A(n1700), .B(n1699), .Y(n1753) );
  INVXL U1549 ( .A(n1750), .Y(n1701) );
  NAND2XL U1550 ( .A(n1764), .B(n1763), .Y(n1792) );
  NAND4X2 U1551 ( .A(n1705), .B(n1723), .C(n1709), .D(n1722), .Y(n1801) );
  NAND2XL U1552 ( .A(n1463), .B(op[3]), .Y(n1093) );
  INVXL U1553 ( .A(n1528), .Y(n1530) );
  INVXL U1554 ( .A(n2358), .Y(n1546) );
  NAND2XL U1555 ( .A(n1112), .B(n1111), .Y(n2361) );
  INVXL U1556 ( .A(n2360), .Y(n2362) );
  NAND2XL U1557 ( .A(n1237), .B(n1236), .Y(n1536) );
  INVXL U1558 ( .A(n1537), .Y(n1238) );
  AOI21XL U1559 ( .A0(n1403), .A1(n1595), .B0(n1872), .Y(n1837) );
  OAI211XL U1560 ( .A0(n1400), .A1(n1399), .B0(n1398), .C0(n2413), .Y(n1401)
         );
  NAND2XL U1561 ( .A(n1399), .B(n1397), .Y(n1398) );
  AOI22XL U1562 ( .A0(n1479), .A1(n1473), .B0(n2395), .B1(n2402), .Y(n1489) );
  AOI21XL U1563 ( .A0(n1806), .A1(n1595), .B0(n2414), .Y(n2028) );
  NAND2XL U1564 ( .A(n966), .B(origin_row[3]), .Y(n2024) );
  MXI2X1 U1565 ( .A(n1865), .B(n1864), .S0(display_row[3]), .Y(n2039) );
  NAND2XL U1566 ( .A(n1440), .B(n1434), .Y(n1435) );
  INVXL U1567 ( .A(n2025), .Y(n1812) );
  OAI21XL U1568 ( .A0(n1804), .A1(display_row[1]), .B0(n1862), .Y(n1816) );
  NOR2XL U1569 ( .A(n1594), .B(n2404), .Y(n1678) );
  NOR2X1 U1570 ( .A(n1417), .B(op_valid), .Y(n1642) );
  INVXL U1571 ( .A(n1440), .Y(n1567) );
  NAND2XL U1572 ( .A(n1455), .B(op_valid), .Y(n1460) );
  AOI21XL U1573 ( .A0(n1454), .A1(n2426), .B0(n1460), .Y(n2020) );
  NAND2XL U1574 ( .A(dis_size[0]), .B(origin_row[0]), .Y(n1553) );
  NAND3XL U1575 ( .A(n1348), .B(n2420), .C(n2421), .Y(n1351) );
  NAND2XL U1576 ( .A(n1347), .B(n1839), .Y(n1348) );
  NOR2XL U1577 ( .A(n1349), .B(n2408), .Y(n1344) );
  NAND2XL U1578 ( .A(n1509), .B(n1343), .Y(n1345) );
  INVXL U1579 ( .A(n1451), .Y(n1343) );
  NAND2XL U1580 ( .A(dis_size[0]), .B(n2422), .Y(n1481) );
  INVXL U1581 ( .A(n1463), .Y(n1464) );
  OAI211XL U1582 ( .A0(n965), .A1(n2402), .B0(n2423), .C0(n2403), .Y(n1461) );
  AOI211XL U1583 ( .A0(n2275), .A1(n2441), .B0(n956), .C0(n1311), .Y(n1312) );
  NOR2XL U1584 ( .A(n2273), .B(n1310), .Y(n1311) );
  OAI211XL U1585 ( .A0(n2016), .A1(n1673), .B0(n1672), .C0(n958), .Y(n842) );
  OAI2BB1XL U1586 ( .A0N(n2442), .A1N(n1671), .B0(sorter_sort_R_r_8__7_), .Y(
        n1672) );
  AOI211XL U1587 ( .A0(n1264), .A1(n1850), .B0(n1263), .C0(n1262), .Y(n1265)
         );
  AOI211XL U1588 ( .A0(n1327), .A1(display_col[0]), .B0(n1326), .C0(n1570), 
        .Y(n1328) );
  INVXL U1589 ( .A(n1847), .Y(n1327) );
  INVXL U1590 ( .A(sorter_sort_G_r_8__1_), .Y(n1013) );
  INVXL U1591 ( .A(sorter_sort_G_r_8__2_), .Y(n1014) );
  INVXL U1592 ( .A(sorter_sort_G_r_8__0_), .Y(n1012) );
  AOI22XL U1593 ( .A0(n2434), .A1(n2134), .B0(n2431), .B1(n2138), .Y(n2112) );
  NAND2XL U1594 ( .A(n2108), .B(out_median[2]), .Y(n2109) );
  NOR2X1 U1595 ( .A(n2432), .B(n2078), .Y(n1197) );
  NAND2XL U1596 ( .A(n2433), .B(n2081), .Y(n1196) );
  AOI22X1 U1597 ( .A0(n2432), .A1(n2078), .B0(n2434), .B1(n2087), .Y(n1195) );
  NAND2XL U1598 ( .A(n2449), .B(n2272), .Y(n1155) );
  NOR2XL U1599 ( .A(n1887), .B(n1886), .Y(n1888) );
  NAND2XL U1600 ( .A(n2451), .B(n1039), .Y(n1040) );
  NAND2XL U1601 ( .A(n1058), .B(n1057), .Y(n1059) );
  AOI22XL U1602 ( .A0(n2450), .A1(n1075), .B0(n998), .B1(n1078), .Y(n1057) );
  AOI22XL U1603 ( .A0(n999), .A1(n1081), .B0(n1000), .B1(n1084), .Y(n1062) );
  NAND2XL U1604 ( .A(n2437), .B(n1606), .Y(n1064) );
  NAND2XL U1605 ( .A(n2451), .B(n2207), .Y(n1622) );
  INVXL U1606 ( .A(sorter_sort_G_r_8__4_), .Y(n1019) );
  INVXL U1607 ( .A(sorter_sort_G_r_8__3_), .Y(n1018) );
  NAND2X1 U1608 ( .A(n1188), .B(n1187), .Y(n1190) );
  INVXL U1609 ( .A(sorter_sort_B_r_8__3_), .Y(n1651) );
  INVXL U1610 ( .A(sorter_sort_B_r_8__2_), .Y(n1652) );
  NAND2XL U1611 ( .A(n2433), .B(n1646), .Y(n1648) );
  NOR2XL U1612 ( .A(n2432), .B(n1647), .Y(n1649) );
  NAND2XL U1613 ( .A(n2312), .B(n2311), .Y(n2313) );
  AOI22XL U1614 ( .A0(n2448), .A1(n2333), .B0(n1140), .B1(n2337), .Y(n2311) );
  AOI22XL U1615 ( .A0(n2315), .A1(n2341), .B0(n2438), .B1(n2345), .Y(n2317) );
  AOI2BB2X1 U1616 ( .B0(n2330), .B1(sorter_sort_R_r_6__2_), .A0N(n1140), .A1N(
        n1341), .Y(n1300) );
  AOI22XL U1617 ( .A0(n1140), .A1(n1341), .B0(n2315), .B1(n1338), .Y(n1298) );
  OAI22XL U1618 ( .A0(n2438), .A1(n1317), .B0(n2315), .B1(n1338), .Y(n1302) );
  NOR2XL U1619 ( .A(n2326), .B(sorter_sort_R_r_8__1_), .Y(n1144) );
  NAND2XL U1620 ( .A(n2440), .B(n2449), .Y(n2307) );
  NAND2XL U1621 ( .A(n2432), .B(n2433), .Y(n2105) );
  AND2X1 U1622 ( .A(n997), .B(q_R[1]), .Y(n1683) );
  NAND2XL U1623 ( .A(n2398), .B(cnt_9[2]), .Y(n974) );
  NOR4X1 U1624 ( .A(n1035), .B(cnt_9[3]), .C(display_row[3]), .D(
        display_row[2]), .Y(n981) );
  NAND2XL U1625 ( .A(n2436), .B(n2218), .Y(n1050) );
  INVXL U1626 ( .A(sorter_sort_G_r_8__6_), .Y(n1026) );
  INVXL U1627 ( .A(sorter_sort_G_r_8__5_), .Y(n1027) );
  AOI22XL U1628 ( .A0(n2431), .A1(n2135), .B0(n1177), .B1(n2139), .Y(n1215) );
  NAND2X2 U1629 ( .A(n1206), .B(n1205), .Y(n1207) );
  NAND2XL U1630 ( .A(n2093), .B(sorter_sort_B_r_8__3_), .Y(n1655) );
  AOI22XL U1631 ( .A0(n2434), .A1(n1652), .B0(n2431), .B1(n1651), .Y(n1653) );
  INVX3 U1632 ( .A(n2084), .Y(n2041) );
  NAND2XL U1633 ( .A(n1612), .B(n1611), .Y(n1613) );
  INVXL U1634 ( .A(sorter_sort_R_r_8__4_), .Y(n1143) );
  CLKINVX1 U1635 ( .A(q_R[3]), .Y(n1682) );
  NAND2XL U1636 ( .A(n1761), .B(n1762), .Y(n1706) );
  NAND2XL U1637 ( .A(q_R[1]), .B(q_G[0]), .Y(n1095) );
  OAI21XL U1638 ( .A0(n1725), .A1(n1694), .B0(n1116), .Y(n1117) );
  NOR2XL U1639 ( .A(n1878), .B(n1545), .Y(n1542) );
  NOR2XL U1640 ( .A(n1437), .B(cnt_9[2]), .Y(n1420) );
  INVXL U1641 ( .A(n1392), .Y(n1394) );
  INVXL U1642 ( .A(n1863), .Y(n1396) );
  NAND2XL U1643 ( .A(n1248), .B(cnt_9[2]), .Y(n1421) );
  INVXL U1644 ( .A(n1429), .Y(n1428) );
  NAND2XL U1645 ( .A(n1422), .B(n1421), .Y(n1423) );
  INVXL U1646 ( .A(n1420), .Y(n1422) );
  NOR2XL U1647 ( .A(origin_row[2]), .B(n2397), .Y(n2384) );
  NOR2XL U1648 ( .A(n987), .B(origin_row[0]), .Y(n1346) );
  NOR2XL U1649 ( .A(n1439), .B(cnt_9[2]), .Y(n1551) );
  INVXL U1650 ( .A(n1437), .Y(n1439) );
  INVXL U1651 ( .A(n1966), .Y(n1961) );
  OAI21X1 U1652 ( .A0(n2004), .A1(n2003), .B0(n2002), .Y(n2008) );
  NAND2XL U1653 ( .A(n1995), .B(n2000), .Y(n2003) );
  NAND2XL U1654 ( .A(n966), .B(origin_row[1]), .Y(n1807) );
  NAND2XL U1655 ( .A(n966), .B(origin_col[3]), .Y(n1846) );
  OAI211XL U1656 ( .A0(display_col[2]), .A1(n1130), .B0(n1128), .C0(n1127), 
        .Y(n1129) );
  INVXL U1657 ( .A(out_median[15]), .Y(n1606) );
  INVXL U1658 ( .A(out_median[11]), .Y(n1078) );
  INVXL U1659 ( .A(out_median[10]), .Y(n1075) );
  OR2X2 U1660 ( .A(n964), .B(n1069), .Y(n2246) );
  NAND2XL U1661 ( .A(n1000), .B(n2195), .Y(n1630) );
  OAI21X2 U1662 ( .A0(n1010), .A1(n2185), .B0(sorter_sort_G_r_7__7_), .Y(n1584) );
  INVXL U1663 ( .A(sorter_sort_G_r_6__6_), .Y(n2192) );
  INVXL U1664 ( .A(sorter_sort_G_r_6__3_), .Y(n2201) );
  INVXL U1665 ( .A(sorter_sort_G_r_6__2_), .Y(n2213) );
  NAND2XL U1666 ( .A(n2180), .B(sorter_sort_G_r_8__5_), .Y(n2163) );
  INVXL U1667 ( .A(sorter_sort_B_r_6__3_), .Y(n2075) );
  INVXL U1668 ( .A(sorter_sort_B_r_6__2_), .Y(n2087) );
  INVXL U1669 ( .A(sorter_sort_B_r_6__0_), .Y(n2081) );
  INVXL U1670 ( .A(sorter_sort_B_r_7__3_), .Y(n2054) );
  INVXL U1671 ( .A(sorter_sort_B_r_7__2_), .Y(n2066) );
  INVXL U1672 ( .A(out_median[19]), .Y(n2337) );
  INVXL U1673 ( .A(out_median[18]), .Y(n2333) );
  INVXL U1674 ( .A(sorter_sort_R_r_5__2_), .Y(n2306) );
  INVXL U1675 ( .A(sorter_sort_R_r_5__1_), .Y(n2297) );
  INVX3 U1676 ( .A(n2300), .Y(n2305) );
  NAND2X2 U1677 ( .A(n2282), .B(n2354), .Y(n2301) );
  INVX3 U1678 ( .A(n2440), .Y(n2326) );
  NAND2X2 U1679 ( .A(n961), .B(n1309), .Y(n2262) );
  INVXL U1680 ( .A(n1728), .Y(n1730) );
  INVXL U1681 ( .A(n1783), .Y(n1727) );
  NAND2XL U1682 ( .A(n1743), .B(n1742), .Y(n1752) );
  OAI21XL U1683 ( .A0(n1737), .A1(n1750), .B0(n1753), .Y(n1738) );
  NOR2XL U1684 ( .A(n1736), .B(n1750), .Y(n1739) );
  INVXL U1685 ( .A(n1756), .Y(n1737) );
  INVXL U1686 ( .A(n1230), .Y(n1114) );
  NAND2XL U1687 ( .A(n1542), .B(q_G[7]), .Y(n2369) );
  OAI21XL U1688 ( .A0(n1538), .A1(n1537), .B0(n1536), .Y(n1539) );
  NOR2XL U1689 ( .A(n1535), .B(n1537), .Y(n1540) );
  NAND2XL U1690 ( .A(n1035), .B(n2398), .Y(n2378) );
  AOI22XL U1691 ( .A0(n1843), .A1(display_col[3]), .B0(n1842), .B1(n1841), .Y(
        n1845) );
  NAND2XL U1692 ( .A(n1840), .B(n1839), .Y(n1841) );
  NOR2XL U1693 ( .A(n1257), .B(n1844), .Y(n1263) );
  INVXL U1694 ( .A(n1844), .Y(n1324) );
  NAND2XL U1695 ( .A(n1323), .B(display_col[0]), .Y(n1325) );
  NOR2XL U1696 ( .A(n1594), .B(n2422), .Y(n1570) );
  NAND2XL U1697 ( .A(dis_size[0]), .B(n2404), .Y(n1557) );
  AND2X1 U1698 ( .A(n965), .B(n1450), .Y(n2017) );
  INVXL U1699 ( .A(n1495), .Y(n1491) );
  OAI211XL U1700 ( .A0(n957), .A1(n1949), .B0(n2011), .C0(n1948), .Y(
        out_data_nxt[1]) );
  NAND2XL U1701 ( .A(n1947), .B(n957), .Y(n1948) );
  NOR3XL U1702 ( .A(n1563), .B(n1566), .C(n1551), .Y(N310) );
  NAND2XL U1703 ( .A(n1955), .B(n1954), .Y(n1956) );
  OAI211XL U1704 ( .A0(n957), .A1(n1943), .B0(n2011), .C0(n1942), .Y(
        out_data_nxt[0]) );
  NAND2XL U1705 ( .A(n1941), .B(n957), .Y(n1942) );
  NAND2XL U1706 ( .A(n1938), .B(n1937), .Y(n1940) );
  NAND2X2 U1707 ( .A(n1978), .B(n957), .Y(n1979) );
  NAND2XL U1708 ( .A(n1981), .B(n1997), .Y(n1976) );
  NAND2XL U1709 ( .A(n1931), .B(n1967), .Y(n1932) );
  NAND2X2 U1710 ( .A(n1800), .B(n957), .Y(n1802) );
  INVXL U1711 ( .A(n1797), .Y(n1798) );
  NAND2XL U1712 ( .A(n2158), .B(n958), .Y(n2159) );
  NOR2XL U1713 ( .A(n2178), .B(n2215), .Y(n2160) );
  AOI21XL U1714 ( .A0(n1597), .A1(n2399), .B0(n1596), .Y(n1599) );
  INVXL U1715 ( .A(n1591), .Y(n1600) );
  NOR2XL U1716 ( .A(n2410), .B(n1592), .Y(n1597) );
  OAI211XL U1717 ( .A0(n957), .A1(n1993), .B0(n2011), .C0(n1992), .Y(
        out_data_nxt[6]) );
  NAND2XL U1718 ( .A(n1991), .B(n957), .Y(n1992) );
  NAND2XL U1719 ( .A(n1988), .B(n1996), .Y(n1989) );
  NOR2XL U1720 ( .A(n1513), .B(n1578), .Y(n1520) );
  NOR2XL U1721 ( .A(n2428), .B(n1517), .Y(n1518) );
  NAND3XL U1722 ( .A(n1594), .B(n1590), .C(n1589), .Y(n949) );
  OAI211XL U1723 ( .A0(n2413), .A1(n1676), .B0(n1675), .C0(n1674), .Y(
        display_col_nxt[2]) );
  OAI211XL U1724 ( .A0(n1587), .A1(n2410), .B0(n1583), .C0(n1598), .Y(n939) );
  AND2X1 U1725 ( .A(n1575), .B(n1574), .Y(n1583) );
  NAND4XL U1726 ( .A(n1456), .B(op_mode[0]), .C(op_valid), .D(n1455), .Y(n1457) );
  INVXL U1727 ( .A(n2021), .Y(n1458) );
  OAI211XL U1728 ( .A0(n2185), .A1(n1635), .B0(n1634), .C0(n958), .Y(n865) );
  OAI2BB1XL U1729 ( .A0N(n2437), .A1N(n2184), .B0(sorter_sort_G_r_6__7_), .Y(
        n1634) );
  NOR2XL U1730 ( .A(n2239), .B(n2215), .Y(n2216) );
  NOR2XL U1731 ( .A(n2239), .B(n2219), .Y(n2220) );
  NOR2XL U1732 ( .A(n2239), .B(n2238), .Y(n2240) );
  NOR2XL U1733 ( .A(n2239), .B(n2223), .Y(n2224) );
  NOR2XL U1734 ( .A(n2239), .B(n2227), .Y(n2228) );
  NOR2XL U1735 ( .A(n2239), .B(n2231), .Y(n2232) );
  NOR2XL U1736 ( .A(n2239), .B(n2245), .Y(n2235) );
  OAI211XL U1737 ( .A0(n2185), .A1(n2186), .B0(n1584), .C0(n958), .Y(n873) );
  OAI211XL U1738 ( .A0(n2185), .A1(n1603), .B0(n1602), .C0(n958), .Y(n881) );
  OAI211XL U1739 ( .A0(n2014), .A1(n2122), .B0(n1637), .C0(n958), .Y(n897) );
  NOR2XL U1740 ( .A(n2152), .B(n2147), .Y(n2148) );
  NOR2XL U1741 ( .A(n2152), .B(n2143), .Y(n2144) );
  NOR2XL U1742 ( .A(n2152), .B(n2139), .Y(n2140) );
  NOR2XL U1743 ( .A(n2152), .B(n2135), .Y(n2136) );
  NOR2XL U1744 ( .A(n2152), .B(n2131), .Y(n2132) );
  NOR2XL U1745 ( .A(n2152), .B(n2151), .Y(n2153) );
  AOI211XL U1746 ( .A0(sorter_sort_B_r_6__6_), .A1(n2102), .B0(n2089), .C0(
        n956), .Y(n2090) );
  NOR2XL U1747 ( .A(n2100), .B(n2088), .Y(n2089) );
  NOR2XL U1748 ( .A(n2100), .B(n2119), .Y(n2091) );
  AOI211XL U1749 ( .A0(sorter_sort_B_r_6__4_), .A1(n2102), .B0(n1228), .C0(
        n956), .Y(n1229) );
  AOI211XL U1750 ( .A0(sorter_sort_B_r_6__3_), .A1(n2102), .B0(n2094), .C0(
        n956), .Y(n2095) );
  NOR2XL U1751 ( .A(n2100), .B(n2093), .Y(n2094) );
  AOI211XL U1752 ( .A0(sorter_sort_B_r_6__2_), .A1(n2102), .B0(n2101), .C0(
        n956), .Y(n2103) );
  NOR2XL U1753 ( .A(n2100), .B(n2108), .Y(n2101) );
  AOI211XL U1754 ( .A0(sorter_sort_B_r_6__1_), .A1(n2102), .B0(n2096), .C0(
        n956), .Y(n2097) );
  NOR2XL U1755 ( .A(n2100), .B(n2107), .Y(n2096) );
  AOI211XL U1756 ( .A0(sorter_sort_B_r_6__0_), .A1(n2102), .B0(n2098), .C0(
        n956), .Y(n2099) );
  OAI211XL U1757 ( .A0(n2014), .A1(n1639), .B0(n1638), .C0(n958), .Y(n913) );
  OAI2BB1XL U1758 ( .A0N(n2452), .A1N(n1823), .B0(sorter_sort_B_r_8__7_), .Y(
        n1667) );
  OAI211XL U1759 ( .A0(n2016), .A1(n2321), .B0(n1620), .C0(n958), .Y(n818) );
  OAI211XL U1760 ( .A0(n2016), .A1(n2281), .B0(n1585), .C0(n958), .Y(n826) );
  OAI211XL U1761 ( .A0(n2016), .A1(n1670), .B0(n1669), .C0(n958), .Y(n834) );
  AOI211XL U1762 ( .A0(n2275), .A1(n2438), .B0(n956), .C0(n1315), .Y(n1316) );
  NOR2XL U1763 ( .A(n2273), .B(n1314), .Y(n1315) );
  AOI211XL U1764 ( .A0(n2275), .A1(n2315), .B0(n956), .C0(n1336), .Y(n1337) );
  NOR2XL U1765 ( .A(n2273), .B(n2254), .Y(n1336) );
  AOI211XL U1766 ( .A0(n2275), .A1(n1140), .B0(n956), .C0(n1339), .Y(n1340) );
  NOR2XL U1767 ( .A(n2273), .B(n2257), .Y(n1339) );
  AOI211XL U1768 ( .A0(n2275), .A1(n2448), .B0(n956), .C0(n1318), .Y(n1319) );
  NOR2XL U1769 ( .A(n2273), .B(n2267), .Y(n1318) );
  AOI211XL U1770 ( .A0(n2275), .A1(n2440), .B0(n956), .C0(n2269), .Y(n2270) );
  AOI211XL U1771 ( .A0(n2275), .A1(n2449), .B0(n956), .C0(n2274), .Y(n2276) );
  NOR2XL U1772 ( .A(n2273), .B(n2272), .Y(n2274) );
  AOI22XL U1773 ( .A0(census_center_R[5]), .A1(n2342), .B0(n2338), .B1(
        census_center_R[4]), .Y(n1378) );
  AOI21XL U1774 ( .A0(n1369), .A1(n1368), .B0(n1367), .Y(n1371) );
  AOI22XL U1775 ( .A0(census_center_G[5]), .A1(n2219), .B0(n2238), .B1(
        census_center_G[4]), .Y(n1368) );
  AOI21XL U1776 ( .A0(n1389), .A1(n1388), .B0(n1387), .Y(n1391) );
  AOI22XL U1777 ( .A0(census_center_B[5]), .A1(n2119), .B0(n2114), .B1(
        census_center_B[4]), .Y(n1388) );
  NAND2XL U1778 ( .A(n1771), .B(n957), .Y(n1772) );
  NAND2XL U1779 ( .A(n1768), .B(n1773), .Y(n1770) );
  OAI211XL U1780 ( .A0(n957), .A1(n1907), .B0(n1801), .C0(n1782), .Y(
        out_data_nxt[9]) );
  NAND2XL U1781 ( .A(n1781), .B(n957), .Y(n1782) );
  NAND2XL U1782 ( .A(n1778), .B(n1777), .Y(n1779) );
  OAI211XL U1783 ( .A0(n957), .A1(n1789), .B0(n1801), .C0(n1788), .Y(
        out_data_nxt[10]) );
  NAND2XL U1784 ( .A(n1787), .B(n957), .Y(n1788) );
  NAND2XL U1785 ( .A(n1784), .B(n1783), .Y(n1785) );
  OAI211XL U1786 ( .A0(n957), .A1(n1725), .B0(n1724), .C0(n1801), .Y(
        out_data_nxt[12]) );
  OAI211XL U1787 ( .A0(n957), .A1(n1878), .B0(n1801), .C0(n1767), .Y(
        out_data_nxt[14]) );
  NAND2XL U1788 ( .A(n1794), .B(n1792), .Y(n1765) );
  NAND2XL U1789 ( .A(q_R[0]), .B(n1505), .Y(n1504) );
  NAND2XL U1790 ( .A(n1530), .B(n1529), .Y(n1532) );
  NAND2XL U1791 ( .A(n1546), .B(n2357), .Y(n1547) );
  NAND2XL U1792 ( .A(n2362), .B(n2361), .Y(n2363) );
  OAI21XL U1793 ( .A0(n957), .A1(n1694), .B0(n1242), .Y(out_data_nxt[21]) );
  NAND2XL U1794 ( .A(n1238), .B(n1536), .Y(n1239) );
  NOR2X1 U1795 ( .A(n2375), .B(n1173), .Y(n1136) );
  NOR2XL U1796 ( .A(n1883), .B(n1173), .Y(n995) );
  NOR2X1 U1797 ( .A(n1878), .B(n1173), .Y(n1001) );
  NOR2X4 U1798 ( .A(n997), .B(n1173), .Y(n2451) );
  NOR2X2 U1799 ( .A(n2012), .B(n1180), .Y(n2452) );
  AOI211XL U1800 ( .A0(n1410), .A1(n1850), .B0(n1409), .C0(n1408), .Y(n1411)
         );
  NOR2XL U1801 ( .A(n1407), .B(n1844), .Y(n1409) );
  AOI22XL U1802 ( .A0(n1493), .A1(n1477), .B0(n1495), .B1(n1476), .Y(n1478) );
  AOI211XL U1803 ( .A0(n1444), .A1(n2030), .B0(n1443), .C0(n1442), .Y(n1445)
         );
  NOR2XL U1804 ( .A(n1441), .B(n2025), .Y(n1443) );
  OAI211XL U1805 ( .A0(n1863), .A1(n1416), .B0(n1321), .C0(n1872), .Y(n1244)
         );
  AOI211XL U1806 ( .A0(n1863), .A1(n1243), .B0(n1392), .C0(n1415), .Y(n1245)
         );
  OAI211XL U1807 ( .A0(n2039), .A1(n2038), .B0(n2037), .C0(n2036), .Y(N453) );
  OAI211XL U1808 ( .A0(n1816), .A1(n2038), .B0(n1815), .C0(n1814), .Y(N451) );
  NAND2XL U1809 ( .A(n1813), .B(n1812), .Y(n1814) );
  AOI21XL U1810 ( .A0(n1809), .A1(n2030), .B0(n1808), .Y(n1815) );
  AOI211XL U1811 ( .A0(n1426), .A1(display_row[0]), .B0(n1425), .C0(n1678), 
        .Y(n1427) );
  NOR2XL U1812 ( .A(n1811), .B(n1424), .Y(n1425) );
  NOR2XL U1813 ( .A(n1645), .B(n1507), .Y(n1412) );
  NOR2XL U1814 ( .A(n1645), .B(n1576), .Y(n1524) );
  MX2X1 U1815 ( .A(n1565), .B(n1564), .S0(cnt_9[1]), .Y(N309) );
  NAND2XL U1816 ( .A(n2021), .B(dis_size[2]), .Y(n1459) );
  AOI32XL U1817 ( .A0(n1562), .A1(n1561), .A2(n1560), .B0(n2419), .B1(n2393), 
        .Y(n936) );
  NAND2XL U1818 ( .A(n1555), .B(n1554), .Y(n1562) );
  NAND2XL U1819 ( .A(n1559), .B(n1558), .Y(n1560) );
  AOI22XL U1820 ( .A0(n1493), .A1(n1483), .B0(n1495), .B1(n1482), .Y(n1484) );
  CLKINVX1 U1821 ( .A(q_B[5]), .Y(n1880) );
  CLKINVX1 U1822 ( .A(q_R[2]), .Y(n1550) );
  NOR2X1 U1823 ( .A(n1691), .B(n1690), .Y(n1776) );
  NAND2XL U1824 ( .A(n1691), .B(n1690), .Y(n1777) );
  OAI21X2 U1825 ( .A0(n2401), .A1(n2376), .B0(n1867), .Y(sram_addr[4]) );
  AOI22XL U1826 ( .A0(n1870), .A1(filter_row[0]), .B0(cnt_255[4]), .B1(n1869), 
        .Y(n1867) );
  OAI21X2 U1827 ( .A0(n2413), .A1(n2376), .B0(n1868), .Y(sram_addr[2]) );
  AOI22XL U1828 ( .A0(n1870), .A1(filter_col[2]), .B0(cnt_255[2]), .B1(n1869), 
        .Y(n1868) );
  OAI21X2 U1829 ( .A0(n2412), .A1(n2376), .B0(n1866), .Y(sram_addr[6]) );
  BUFX4 U1830 ( .A(cens_start), .Y(n2443) );
  OAI21X2 U1831 ( .A0(n1835), .A1(n2418), .B0(n1833), .Y(sram_addr[5]) );
  OAI21X2 U1832 ( .A0(n1835), .A1(n2417), .B0(n1834), .Y(sram_addr[3]) );
  OAI21X2 U1833 ( .A0(n1872), .A1(n2376), .B0(n1871), .Y(sram_addr[1]) );
  OAI21X2 U1834 ( .A0(n1495), .A1(n1493), .B0(n1469), .Y(n1499) );
  NOR3X2 U1835 ( .A(n1465), .B(op[3]), .C(n1464), .Y(n1495) );
  INVX12 U1836 ( .A(q_G[3]), .Y(n1735) );
  OAI211XL U1837 ( .A0(n957), .A1(n1749), .B0(n1748), .C0(n1801), .Y(
        out_data_nxt[13]) );
  OAI22XL U1838 ( .A0(n2429), .A1(n1662), .B0(n1177), .B1(n1657), .Y(n1658) );
  AOI211X1 U1839 ( .A0(sorter_sort_G_r_8__4_), .A1(n2180), .B0(n1036), .C0(
        n2174), .Y(n1037) );
  AOI211X1 U1840 ( .A0(sorter_sort_G_r_8__0_), .A1(n2180), .B0(n2175), .C0(
        n2174), .Y(n2176) );
  AOI211X1 U1841 ( .A0(sorter_sort_G_r_8__2_), .A1(n2180), .B0(n2179), .C0(
        n956), .Y(n2181) );
  AOI211X1 U1842 ( .A0(sorter_sort_G_r_8__3_), .A1(n2180), .B0(n2168), .C0(
        n956), .Y(n2169) );
  AOI211X1 U1843 ( .A0(sorter_sort_G_r_8__1_), .A1(n2180), .B0(n2171), .C0(
        n956), .Y(n2172) );
  INVX6 U1844 ( .A(n2180), .Y(n1680) );
  AOI211XL U1845 ( .A0(n2241), .A1(sorter_sort_G_r_6__0_), .B0(n2235), .C0(
        n956), .Y(n2236) );
  AOI211XL U1846 ( .A0(sorter_sort_G_r_6__6_), .A1(n2241), .B0(n2216), .C0(
        n956), .Y(n2217) );
  NOR2XL U1847 ( .A(n2082), .B(n2114), .Y(n1209) );
  NOR2XL U1848 ( .A(n1898), .B(n1897), .Y(n1908) );
  INVX3 U1849 ( .A(q_G[0]), .Y(n997) );
  INVX3 U1850 ( .A(q_G[5]), .Y(n1749) );
  INVX3 U1851 ( .A(q_R[0]), .Y(n1134) );
  NAND2XL U1852 ( .A(n1916), .B(n1913), .Y(n1886) );
  INVXL U1853 ( .A(sorter_sort_B_r_8__0_), .Y(n1646) );
  INVXL U1854 ( .A(sorter_sort_G_r_5__0_), .Y(n1039) );
  NAND2XL U1855 ( .A(n2451), .B(n1012), .Y(n1016) );
  INVXL U1856 ( .A(sorter_sort_R_r_5__0_), .Y(n1607) );
  AND2X1 U1857 ( .A(n1896), .B(n997), .Y(n1897) );
  AOI22XL U1858 ( .A0(n999), .A1(n1019), .B0(n998), .B1(n1018), .Y(n1020) );
  INVXL U1859 ( .A(n1914), .Y(n1909) );
  INVXL U1860 ( .A(sorter_sort_B_r_8__6_), .Y(n1661) );
  OR2X2 U1861 ( .A(n1883), .B(q_B[6]), .Y(n1796) );
  INVXL U1862 ( .A(n2368), .Y(n2370) );
  INVXL U1863 ( .A(n1995), .Y(n1971) );
  INVXL U1864 ( .A(n1774), .Y(n1768) );
  INVXL U1865 ( .A(n1754), .Y(n1744) );
  INVXL U1866 ( .A(n1234), .Y(n1113) );
  NAND2XL U1867 ( .A(n1841), .B(n2413), .Y(n1843) );
  NAND2XL U1868 ( .A(n2370), .B(n2369), .Y(n2371) );
  NAND2XL U1869 ( .A(n1945), .B(n1950), .Y(n1946) );
  NOR2XL U1870 ( .A(n1392), .B(n1415), .Y(n1128) );
  AOI22XL U1871 ( .A0(n2435), .A1(n2150), .B0(n2452), .B1(n2122), .Y(n2123) );
  NAND2XL U1872 ( .A(n1701), .B(n1753), .Y(n1702) );
  INVXL U1873 ( .A(n1252), .Y(n1246) );
  INVXL U1874 ( .A(n1452), .Y(n1453) );
  NAND2XL U1875 ( .A(dis_size[0]), .B(origin_col[0]), .Y(n1479) );
  XOR2X1 U1876 ( .A(n1799), .B(n1798), .Y(n1800) );
  NOR2XL U1877 ( .A(n2246), .B(n2238), .Y(n1079) );
  INVX3 U1878 ( .A(n2214), .Y(n2241) );
  NOR2X1 U1879 ( .A(n2178), .B(n2238), .Y(n1036) );
  NOR2XL U1880 ( .A(n2152), .B(n2127), .Y(n2128) );
  NOR2XL U1881 ( .A(n2273), .B(n2268), .Y(n2269) );
  NOR2XL U1882 ( .A(n1845), .B(n1844), .Y(n1849) );
  NOR2X1 U1883 ( .A(n1130), .B(n1399), .Y(n1392) );
  AND2X1 U1884 ( .A(n1805), .B(n1453), .Y(n1456) );
  INVXL U1885 ( .A(n1493), .Y(n1490) );
  NAND2XL U1886 ( .A(n1934), .B(n957), .Y(n1935) );
  NAND3XL U1887 ( .A(n1593), .B(n1590), .C(n1575), .Y(n1519) );
  INVXL U1888 ( .A(sorter_sort_G_r_6__0_), .Y(n2207) );
  AOI211XL U1889 ( .A0(sorter_sort_B_r_6__5_), .A1(n2102), .B0(n2091), .C0(
        n956), .Y(n2092) );
  AOI211XL U1890 ( .A0(sorter_sort_B_r_7__6_), .A1(n2084), .B0(n2067), .C0(
        n956), .Y(n2068) );
  INVXL U1891 ( .A(sorter_sort_B_r_7__0_), .Y(n2060) );
  INVXL U1892 ( .A(sorter_sort_R_r_5__6_), .Y(n2285) );
  INVXL U1893 ( .A(sorter_sort_R_r_6__7_), .Y(n1670) );
  AOI21XL U1894 ( .A0(n1379), .A1(n1378), .B0(n1377), .Y(n1381) );
  CLKINVX1 U1895 ( .A(q_G[4]), .Y(n1725) );
  NAND2XL U1896 ( .A(n966), .B(origin_col[1]), .Y(n1261) );
  OAI211XL U1897 ( .A0(n1600), .A1(n2399), .B0(n1599), .C0(n1598), .Y(n940) );
  OAI211XL U1898 ( .A0(n2185), .A1(n1606), .B0(n1605), .C0(n958), .Y(n930) );
  OAI211XL U1899 ( .A0(n2014), .A1(n1641), .B0(n1640), .C0(n958), .Y(n905) );
  OAI211XL U1900 ( .A0(n2014), .A1(n1668), .B0(n1667), .C0(n958), .Y(n921) );
  OAI21XL U1901 ( .A0(n1314), .A1(n2266), .B0(n1171), .Y(n840) );
  OAI211XL U1902 ( .A0(n957), .A1(n997), .B0(n1801), .C0(n1772), .Y(
        out_data_nxt[8]) );
  NOR2X4 U1903 ( .A(n1789), .B(n1180), .Y(n2450) );
  OAI32XL U1904 ( .A0(cnt_255[3]), .A1(n1645), .A2(n1644), .B0(n1643), .B1(
        n2417), .Y(n945) );
  NAND2X1 U1905 ( .A(state[1]), .B(n1578), .Y(n1514) );
  NOR2X2 U1906 ( .A(n2395), .B(dis_size[2]), .Y(n967) );
  NOR2BX4 U1907 ( .AN(n967), .B(dis_size[0]), .Y(n1805) );
  NOR2BX4 U1908 ( .AN(n968), .B(dis_size[0]), .Y(n2027) );
  NAND2X2 U1909 ( .A(cnt_9[1]), .B(cnt_9[0]), .Y(n1437) );
  NOR2X4 U1910 ( .A(n1437), .B(n2405), .Y(n1566) );
  NOR2X4 U1911 ( .A(cnt_9[1]), .B(cnt_9[2]), .Y(n1035) );
  INVX1 U1912 ( .A(n1035), .Y(n1258) );
  MXI2X2 U1913 ( .A(n969), .B(n1258), .S0(cnt_9[3]), .Y(n970) );
  AOI2BB1X2 U1914 ( .A0N(n965), .A1N(display_row[1]), .B0(n971), .Y(n972) );
  NAND2X4 U1915 ( .A(n1811), .B(n972), .Y(n984) );
  NOR2X2 U1916 ( .A(n2398), .B(n2406), .Y(n973) );
  OAI21X1 U1917 ( .A0(cnt_9[3]), .A1(n974), .B0(n2038), .Y(n975) );
  NAND3X1 U1918 ( .A(n975), .B(display_col[2]), .C(display_col[3]), .Y(n976)
         );
  NAND2X4 U1919 ( .A(n1404), .B(n977), .Y(n983) );
  NOR2X2 U1920 ( .A(cnt_9[1]), .B(cnt_9[0]), .Y(n1248) );
  NOR2X1 U1921 ( .A(n1248), .B(n2405), .Y(n1434) );
  INVX1 U1922 ( .A(n1434), .Y(n979) );
  NAND3X6 U1923 ( .A(n984), .B(n983), .C(n982), .Y(n986) );
  NOR2X2 U1924 ( .A(dis_size[2]), .B(dis_size[1]), .Y(n985) );
  NAND2X6 U1925 ( .A(n986), .B(n1509), .Y(n994) );
  NOR2X2 U1926 ( .A(n987), .B(display_col[0]), .Y(n1243) );
  NOR2X1 U1927 ( .A(cnt_9[0]), .B(cnt_9[2]), .Y(n988) );
  NAND2X1 U1928 ( .A(n988), .B(cnt_9[1]), .Y(n1249) );
  NAND2X1 U1929 ( .A(n1249), .B(n1253), .Y(n989) );
  NAND3X1 U1930 ( .A(n989), .B(n1842), .C(n2406), .Y(n990) );
  NAND2X2 U1931 ( .A(n992), .B(n991), .Y(n993) );
  NAND2X8 U1932 ( .A(n994), .B(n993), .Y(n1137) );
  BUFX20 U1933 ( .A(n1137), .Y(n1173) );
  BUFX20 U1934 ( .A(n1137), .Y(n1180) );
  NOR2X4 U1935 ( .A(n1907), .B(n1180), .Y(n996) );
  NOR2X4 U1936 ( .A(n1735), .B(n1180), .Y(n998) );
  NOR2X4 U1937 ( .A(n1725), .B(n1180), .Y(n999) );
  NOR2X4 U1938 ( .A(n1749), .B(n1180), .Y(n1000) );
  INVX4 U1939 ( .A(n999), .Y(n2238) );
  OA22X1 U1940 ( .A0(n2238), .A1(sorter_sort_G_r_7__4_), .B0(n2223), .B1(
        sorter_sort_G_r_7__3_), .Y(n1006) );
  INVX3 U1941 ( .A(n1000), .Y(n2219) );
  AO22X1 U1942 ( .A0(sorter_sort_G_r_7__5_), .A1(n2219), .B0(n2238), .B1(
        sorter_sort_G_r_7__4_), .Y(n1005) );
  AOI21X2 U1943 ( .A0(n1007), .A1(n1006), .B0(n1005), .Y(n1009) );
  OAI22X1 U1944 ( .A0(sorter_sort_G_r_7__6_), .A1(n2215), .B0(n2219), .B1(
        sorter_sort_G_r_7__5_), .Y(n1008) );
  INVX1 U1945 ( .A(n1010), .Y(n1011) );
  NOR2X1 U1946 ( .A(n996), .B(n1013), .Y(n1017) );
  OAI21X1 U1947 ( .A0(n1017), .A1(n1016), .B0(n1015), .Y(n1021) );
  OAI2BB1X1 U1948 ( .A0N(n1022), .A1N(n1021), .B0(n1020), .Y(n1025) );
  NAND2X1 U1949 ( .A(n2238), .B(sorter_sort_G_r_8__4_), .Y(n1024) );
  NAND2X1 U1950 ( .A(n2219), .B(sorter_sort_G_r_8__5_), .Y(n1023) );
  NAND3X2 U1951 ( .A(n1025), .B(n1024), .C(n1023), .Y(n1029) );
  AOI22X1 U1952 ( .A0(n1000), .A1(n1027), .B0(n2436), .B1(n1026), .Y(n1028) );
  NAND2X1 U1953 ( .A(n1029), .B(n1028), .Y(n1031) );
  NAND2X1 U1954 ( .A(n2215), .B(sorter_sort_G_r_8__6_), .Y(n1030) );
  NAND2X1 U1955 ( .A(n1031), .B(n1030), .Y(n1601) );
  NOR2X1 U1956 ( .A(n2437), .B(n1471), .Y(n1032) );
  NOR2X1 U1957 ( .A(n1601), .B(n1032), .Y(n1034) );
  NOR2X1 U1958 ( .A(n2185), .B(sorter_sort_G_r_8__7_), .Y(n1033) );
  NAND2X2 U1959 ( .A(n2189), .B(n1821), .Y(n2182) );
  NAND2X6 U1960 ( .A(n2210), .B(n1680), .Y(n2178) );
  NOR2X2 U1961 ( .A(n2378), .B(cnt_9[3]), .Y(n2174) );
  CLKINVX1 U1962 ( .A(sorter_sort_G_r_5__7_), .Y(n1635) );
  NOR2X1 U1963 ( .A(n1041), .B(n1040), .Y(n1043) );
  OAI22X1 U1964 ( .A0(n1043), .A1(n1042), .B0(n2450), .B1(n2230), .Y(n1045) );
  AOI2BB2X1 U1965 ( .B0(n1045), .B1(n1044), .A0N(n998), .A1N(n2226), .Y(n1048)
         );
  OAI22XL U1966 ( .A0(n1000), .A1(n2222), .B0(n999), .B1(n2244), .Y(n1046) );
  OAI22X2 U1967 ( .A0(n1052), .A1(n1051), .B0(n2436), .B1(n2218), .Y(n1604) );
  AOI2BB2X4 U1968 ( .B0(n2437), .B1(n1635), .A0N(n1604), .A1N(n1053), .Y(n2248) );
  OAI22XL U1969 ( .A0(n999), .A1(n1081), .B0(n998), .B1(n1078), .Y(n1060) );
  NAND2X1 U1970 ( .A(n2451), .B(n996), .Y(n1361) );
  NAND2X1 U1971 ( .A(n1361), .B(out_median[9]), .Y(n1056) );
  NAND3X1 U1972 ( .A(n1056), .B(n1055), .C(n1054), .Y(n1058) );
  NAND2BX1 U1973 ( .AN(n1060), .B(n1059), .Y(n1063) );
  OAI22XL U1974 ( .A0(n2436), .A1(n1087), .B0(n1000), .B1(n1084), .Y(n1061) );
  AOI21X1 U1975 ( .A0(n1063), .A1(n1062), .B0(n1061), .Y(n1067) );
  AOI2BB2X1 U1976 ( .B0(out_median[15]), .B1(n2185), .A0N(n1067), .A1N(n1066), 
        .Y(n1069) );
  NAND2X2 U1977 ( .A(n1068), .B(n1069), .Y(n2251) );
  NOR2X1 U1978 ( .A(n2246), .B(n2231), .Y(n1070) );
  AOI211X4 U1979 ( .A0(sorter_sort_G_r_5__2_), .A1(n964), .B0(n1073), .C0(n956), .Y(n1074) );
  NOR2X1 U1980 ( .A(n2246), .B(n2223), .Y(n1076) );
  AOI211X4 U1981 ( .A0(sorter_sort_G_r_5__4_), .A1(n964), .B0(n1079), .C0(n956), .Y(n1080) );
  OAI21X2 U1982 ( .A0(n1081), .A1(n2251), .B0(n1080), .Y(n853) );
  NOR2X1 U1983 ( .A(n2246), .B(n2219), .Y(n1082) );
  NOR2X1 U1984 ( .A(n2246), .B(n2215), .Y(n1085) );
  NAND2X1 U1985 ( .A(n1089), .B(n1088), .Y(n1581) );
  NOR2X2 U1986 ( .A(n2399), .B(state[1]), .Y(n1577) );
  NAND2X1 U1987 ( .A(n1577), .B(state[3]), .Y(n1090) );
  NAND2X2 U1988 ( .A(n1581), .B(n1090), .Y(n1333) );
  NAND2XL U1989 ( .A(op[0]), .B(op[2]), .Y(n1092) );
  NAND2X1 U1990 ( .A(n1100), .B(n1095), .Y(n1096) );
  NAND2X1 U1991 ( .A(n1096), .B(q_G[2]), .Y(n1098) );
  NAND2X1 U1992 ( .A(q_R[0]), .B(q_G[1]), .Y(n1097) );
  AOI2BB2X2 U1993 ( .B0(n1098), .B1(n1097), .A0N(n1096), .A1N(q_G[2]), .Y(
        n1501) );
  XOR2X1 U1994 ( .A(q_R[3]), .B(q_G[4]), .Y(n1101) );
  XOR2X1 U1995 ( .A(n1101), .B(q_G[2]), .Y(n1102) );
  ADDFXL U1996 ( .A(q_R[2]), .B(q_G[1]), .CI(q_G[3]), .CO(n1531), .S(n1503) );
  NAND2X1 U1997 ( .A(n1103), .B(n1102), .Y(n1529) );
  OAI21X2 U1998 ( .A0(n1528), .A1(n1104), .B0(n1529), .Y(n1541) );
  INVX3 U1999 ( .A(n1541), .Y(n2359) );
  XOR2X1 U2000 ( .A(q_R[4]), .B(q_G[3]), .Y(n1105) );
  XOR2X1 U2001 ( .A(n1105), .B(q_G[5]), .Y(n1110) );
  OAI21XL U2002 ( .A0(q_R[3]), .A1(q_G[2]), .B0(q_G[4]), .Y(n1106) );
  NOR2X1 U2003 ( .A(n1110), .B(n1109), .Y(n2358) );
  XOR2X1 U2004 ( .A(q_R[5]), .B(q_G[4]), .Y(n1107) );
  XOR2X1 U2005 ( .A(n1107), .B(q_G[6]), .Y(n1112) );
  OAI21XL U2006 ( .A0(q_R[4]), .A1(q_G[3]), .B0(q_G[5]), .Y(n1108) );
  NOR2X1 U2007 ( .A(n1112), .B(n1111), .Y(n2360) );
  NOR2X1 U2008 ( .A(n2358), .B(n2360), .Y(n1230) );
  NAND2X1 U2009 ( .A(n1110), .B(n1109), .Y(n2357) );
  OAI21X1 U2010 ( .A0(n2359), .A1(n1114), .B0(n1113), .Y(n1120) );
  XOR2X1 U2011 ( .A(q_R[6]), .B(q_G[5]), .Y(n1115) );
  XOR2X1 U2012 ( .A(n1115), .B(q_G[7]), .Y(n1118) );
  OAI21XL U2013 ( .A0(q_R[5]), .A1(q_G[4]), .B0(q_G[6]), .Y(n1116) );
  XNOR2X1 U2014 ( .A(n1120), .B(n1119), .Y(n1121) );
  NAND2X2 U2015 ( .A(op[3]), .B(op[2]), .Y(n1123) );
  NOR2X4 U2016 ( .A(n1123), .B(op[0]), .Y(n1331) );
  NAND2X1 U2017 ( .A(n1333), .B(n1331), .Y(n2377) );
  INVX3 U2018 ( .A(n2377), .Y(n1870) );
  CLKINVX1 U2019 ( .A(n987), .Y(n1516) );
  NAND2X1 U2020 ( .A(cnt_255[0]), .B(cnt_255[1]), .Y(n1526) );
  NAND2X2 U2021 ( .A(n1414), .B(n1397), .Y(n1130) );
  CLKINVX1 U2022 ( .A(n1395), .Y(n1399) );
  NOR2X1 U2023 ( .A(n1805), .B(n1516), .Y(n1454) );
  AOI2BB2X1 U2024 ( .B0(n1805), .B1(cnt_255[0]), .A0N(n1526), .A1N(n987), .Y(
        n1400) );
  OAI21XL U2025 ( .A0(display_col[2]), .A1(n1399), .B0(n1863), .Y(n1127) );
  NAND2X1 U2026 ( .A(n1129), .B(display_col[3]), .Y(n1133) );
  NAND4X1 U2027 ( .A(n1416), .B(n1399), .C(display_col[2]), .D(n2416), .Y(
        n1131) );
  NAND4X1 U2028 ( .A(n1133), .B(n1132), .C(n1846), .D(n1131), .Y(
        display_col_nxt[3]) );
  NOR2X1 U2029 ( .A(n1545), .B(n1173), .Y(n1135) );
  BUFX4 U2030 ( .A(n1136), .Y(n2441) );
  NOR2X4 U2031 ( .A(n1138), .B(n1137), .Y(n1139) );
  NOR2X4 U2032 ( .A(n1141), .B(n1173), .Y(n2315) );
  CLKINVX1 U2033 ( .A(sorter_sort_R_r_7__6_), .Y(n1310) );
  INVX3 U2034 ( .A(n2449), .Y(n2351) );
  AOI211X1 U2035 ( .A0(n2326), .A1(sorter_sort_R_r_8__1_), .B0(
        sorter_sort_R_r_8__0_), .C0(n2351), .Y(n1145) );
  AOI2BB2X2 U2036 ( .B0(sorter_sort_R_r_8__2_), .B1(n2330), .A0N(n1145), .A1N(
        n1144), .Y(n1148) );
  INVX3 U2037 ( .A(n1140), .Y(n2334) );
  OAI22X1 U2038 ( .A0(n2330), .A1(sorter_sort_R_r_8__2_), .B0(n2334), .B1(
        sorter_sort_R_r_8__3_), .Y(n1147) );
  OAI22X2 U2039 ( .A0(n1148), .A1(n1147), .B0(n1140), .B1(n1146), .Y(n1149) );
  AOI222X2 U2040 ( .A0(n1150), .A1(n1149), .B0(n2338), .B1(
        sorter_sort_R_r_8__4_), .C0(n2342), .C1(sorter_sort_R_r_8__5_), .Y(
        n1152) );
  OAI22X1 U2041 ( .A0(sorter_sort_R_r_8__6_), .A1(n2346), .B0(n2342), .B1(
        sorter_sort_R_r_8__5_), .Y(n1151) );
  AOI2BB2X1 U2042 ( .B0(sorter_sort_R_r_8__6_), .B1(n2346), .A0N(n1152), .A1N(
        n1151), .Y(n1671) );
  OAI21X2 U2043 ( .A0(n2442), .A1(n2015), .B0(n1671), .Y(n1153) );
  CLKINVX1 U2044 ( .A(sorter_sort_R_r_7__5_), .Y(n1314) );
  CLKINVX1 U2045 ( .A(sorter_sort_R_r_7__4_), .Y(n2254) );
  CLKINVX1 U2046 ( .A(sorter_sort_R_r_7__3_), .Y(n2257) );
  AOI2BB2X1 U2047 ( .B0(n2330), .B1(sorter_sort_R_r_7__2_), .A0N(n1140), .A1N(
        n2257), .Y(n1159) );
  CLKINVX1 U2048 ( .A(sorter_sort_R_r_7__1_), .Y(n2268) );
  NOR2X1 U2049 ( .A(n2440), .B(n2268), .Y(n1156) );
  AOI22X1 U2050 ( .A0(n2448), .A1(n2267), .B0(n2440), .B1(n2268), .Y(n1154) );
  AOI22X1 U2051 ( .A0(n1140), .A1(n2257), .B0(n2315), .B1(n2254), .Y(n1157) );
  OAI2BB1X1 U2052 ( .A0N(n1159), .A1N(n1158), .B0(n1157), .Y(n1160) );
  NAND2BX1 U2053 ( .AN(n1161), .B(n1160), .Y(n1163) );
  AOI2BB2X2 U2054 ( .B0(n1163), .B1(n1162), .A0N(n2441), .A1N(n1310), .Y(n1165) );
  NAND2X1 U2055 ( .A(n1165), .B(n2442), .Y(n1164) );
  INVX1 U2056 ( .A(n1165), .Y(n1166) );
  NAND2X1 U2057 ( .A(n1166), .B(n2016), .Y(n1167) );
  NOR2X1 U2058 ( .A(n2262), .B(n2346), .Y(n1168) );
  NOR2X1 U2059 ( .A(n2262), .B(n2342), .Y(n1170) );
  NOR2X4 U2060 ( .A(n1965), .B(n1180), .Y(n1172) );
  BUFX12 U2061 ( .A(n1172), .Y(n2431) );
  NOR2X4 U2062 ( .A(n1960), .B(n1173), .Y(n1174) );
  INVX3 U2063 ( .A(q_B[1]), .Y(n1949) );
  NOR2X4 U2064 ( .A(n1943), .B(n1180), .Y(n1176) );
  BUFX12 U2065 ( .A(n1176), .Y(n2433) );
  BUFX8 U2066 ( .A(n1178), .Y(n2429) );
  INVX6 U2067 ( .A(n2431), .Y(n2093) );
  AOI2BB2X1 U2068 ( .B0(n2093), .B1(sorter_sort_B_r_7__3_), .A0N(n2434), .A1N(
        n2066), .Y(n1186) );
  CLKINVX1 U2069 ( .A(sorter_sort_B_r_7__1_), .Y(n2057) );
  NAND2X1 U2070 ( .A(n2433), .B(n2060), .Y(n1182) );
  AOI22X2 U2071 ( .A0(n2432), .A1(n2057), .B0(n2434), .B1(n2066), .Y(n1181) );
  AOI22X1 U2072 ( .A0(n2431), .A1(n2054), .B0(n1177), .B1(n2051), .Y(n1184) );
  OAI2BB1X1 U2073 ( .A0N(n1186), .A1N(n1185), .B0(n1184), .Y(n1188) );
  INVX3 U2074 ( .A(n2429), .Y(n2119) );
  AOI2BB2X1 U2075 ( .B0(n2119), .B1(sorter_sort_B_r_7__5_), .A0N(n1177), .A1N(
        n2051), .Y(n1187) );
  AOI22X1 U2076 ( .A0(n2435), .A1(n2045), .B0(n2429), .B1(n2048), .Y(n1189) );
  NAND2X1 U2077 ( .A(n1190), .B(n1189), .Y(n1192) );
  NAND2X1 U2078 ( .A(n2088), .B(sorter_sort_B_r_7__6_), .Y(n1191) );
  OAI21X2 U2079 ( .A0(n1193), .A1(n2014), .B0(sorter_sort_B_r_7__7_), .Y(n1638) );
  NAND2X1 U2080 ( .A(n1193), .B(n2014), .Y(n1194) );
  NAND2X4 U2081 ( .A(n1638), .B(n1194), .Y(n2084) );
  AOI2BB2X1 U2082 ( .B0(sorter_sort_B_r_6__3_), .B1(n2093), .A0N(n2434), .A1N(
        n2087), .Y(n1200) );
  OAI21X1 U2083 ( .A0(n1197), .A1(n1196), .B0(n1195), .Y(n1199) );
  AOI22X1 U2084 ( .A0(n2431), .A1(n2075), .B0(n1177), .B1(n1211), .Y(n1198) );
  OAI2BB1X1 U2085 ( .A0N(n1200), .A1N(n1199), .B0(n1198), .Y(n1202) );
  AOI2BB2X1 U2086 ( .B0(sorter_sort_B_r_6__5_), .B1(n2119), .A0N(n1177), .A1N(
        n1211), .Y(n1201) );
  NAND2X2 U2087 ( .A(n1202), .B(n1201), .Y(n1204) );
  NAND2X1 U2088 ( .A(n1204), .B(n1203), .Y(n1206) );
  NAND2X1 U2089 ( .A(n2088), .B(sorter_sort_B_r_6__6_), .Y(n1205) );
  OAI21X2 U2090 ( .A0(n1207), .A1(n2014), .B0(sorter_sort_B_r_6__7_), .Y(n1640) );
  NAND2X1 U2091 ( .A(n1207), .B(n2014), .Y(n1208) );
  NAND2X4 U2092 ( .A(n1640), .B(n1208), .Y(n2102) );
  NAND2X2 U2093 ( .A(n2041), .B(n1227), .Y(n2086) );
  NAND2X4 U2094 ( .A(n2041), .B(n2102), .Y(n2082) );
  CLKINVX1 U2095 ( .A(n1177), .Y(n2114) );
  AOI211X4 U2096 ( .A0(sorter_sort_B_r_7__4_), .A1(n2084), .B0(n1209), .C0(
        n956), .Y(n1210) );
  CLKINVX1 U2097 ( .A(sorter_sort_B_r_5__4_), .Y(n2139) );
  CLKINVX1 U2098 ( .A(sorter_sort_B_r_5__2_), .Y(n2131) );
  AOI2BB2X1 U2099 ( .B0(sorter_sort_B_r_5__3_), .B1(n2093), .A0N(n2434), .A1N(
        n2131), .Y(n1217) );
  CLKINVX1 U2100 ( .A(sorter_sort_B_r_5__1_), .Y(n2127) );
  NOR2X1 U2101 ( .A(n2432), .B(n2127), .Y(n1214) );
  NAND2X1 U2102 ( .A(n2433), .B(n2151), .Y(n1213) );
  AOI22X1 U2103 ( .A0(n2432), .A1(n2127), .B0(n2434), .B1(n2131), .Y(n1212) );
  OAI21XL U2104 ( .A0(n1214), .A1(n1213), .B0(n1212), .Y(n1216) );
  AOI2BB2X1 U2105 ( .B0(sorter_sort_B_r_5__5_), .B1(n2119), .A0N(n1177), .A1N(
        n2139), .Y(n1218) );
  NAND2X1 U2106 ( .A(n1221), .B(n1220), .Y(n1223) );
  NAND2X2 U2107 ( .A(n1223), .B(n1222), .Y(n1636) );
  NOR2X1 U2108 ( .A(n2452), .B(n1641), .Y(n1224) );
  NOR2X1 U2109 ( .A(n2014), .B(sorter_sort_B_r_5__7_), .Y(n1225) );
  NOR2X4 U2110 ( .A(n1226), .B(n1225), .Y(n2126) );
  NAND2X2 U2111 ( .A(n1227), .B(n2152), .Y(n2104) );
  NAND2X4 U2112 ( .A(n1227), .B(n2126), .Y(n2100) );
  NOR2XL U2113 ( .A(n2100), .B(n2114), .Y(n1228) );
  NAND2X1 U2114 ( .A(n1230), .B(n1233), .Y(n1535) );
  CLKINVX1 U2115 ( .A(n1231), .Y(n1232) );
  AOI21X1 U2116 ( .A0(n1234), .A1(n1233), .B0(n1232), .Y(n1538) );
  OAI21XL U2117 ( .A0(q_R[6]), .A1(q_G[5]), .B0(q_G[7]), .Y(n1235) );
  OAI21XL U2118 ( .A0(n1749), .A1(n2375), .B0(n1235), .Y(n1237) );
  XOR2X1 U2119 ( .A(q_R[7]), .B(q_G[6]), .Y(n1236) );
  NOR2X1 U2120 ( .A(n1237), .B(n1236), .Y(n1537) );
  XNOR2X1 U2121 ( .A(n1240), .B(n1239), .Y(n1241) );
  XOR2X1 U2122 ( .A(n1805), .B(display_col[1]), .Y(n1252) );
  XOR2X1 U2123 ( .A(n1403), .B(n1246), .Y(n1264) );
  NAND2X1 U2124 ( .A(n1247), .B(cnt_9[3]), .Y(n1568) );
  NOR2X2 U2125 ( .A(n966), .B(cnt_9[3]), .Y(n1440) );
  OAI21XL U2126 ( .A0(n1250), .A1(n1566), .B0(n1440), .Y(n1251) );
  NAND2X1 U2127 ( .A(n1568), .B(n1251), .Y(n1850) );
  XOR2X1 U2128 ( .A(n1404), .B(n1252), .Y(n1257) );
  NAND2X1 U2129 ( .A(n1256), .B(n1440), .Y(n1844) );
  NAND2XL U2130 ( .A(cnt_9[1]), .B(cnt_9[2]), .Y(n1259) );
  MXI2X1 U2131 ( .A(n1259), .B(n1258), .S0(cnt_9[0]), .Y(n1260) );
  NAND2X1 U2132 ( .A(n1260), .B(n1440), .Y(n1847) );
  OAI21XL U2133 ( .A0(n1847), .A1(n1872), .B0(n1261), .Y(n1262) );
  OAI21XL U2134 ( .A0(n1266), .A1(n2038), .B0(n1265), .Y(N447) );
  NOR2X8 U2135 ( .A(op[1]), .B(n1293), .Y(n1292) );
  NOR2X2 U2136 ( .A(n1293), .B(n2411), .Y(n1267) );
  BUFX12 U2137 ( .A(n1267), .Y(n1291) );
  AOI222X1 U2138 ( .A0(n1293), .A1(out_data[21]), .B0(out_median[21]), .B1(
        n1292), .C0(n1291), .C1(out_census[21]), .Y(n1268) );
  CLKINVX1 U2139 ( .A(n1268), .Y(o_out_data[21]) );
  AOI222X1 U2140 ( .A0(n1293), .A1(out_data[15]), .B0(out_median[15]), .B1(
        n1292), .C0(n1291), .C1(out_census[15]), .Y(n1269) );
  CLKINVX1 U2141 ( .A(n1269), .Y(o_out_data[15]) );
  AOI222X1 U2142 ( .A0(n1293), .A1(out_data[23]), .B0(out_median[23]), .B1(
        n1292), .C0(n1291), .C1(out_census[23]), .Y(n1270) );
  CLKINVX1 U2143 ( .A(n1270), .Y(o_out_data[23]) );
  AOI222X1 U2144 ( .A0(n1293), .A1(out_data[4]), .B0(out_median[4]), .B1(n1292), .C0(n1291), .C1(out_census[4]), .Y(n1271) );
  CLKINVX1 U2145 ( .A(n1271), .Y(o_out_data[4]) );
  AOI222X1 U2146 ( .A0(n1293), .A1(out_data[10]), .B0(out_median[10]), .B1(
        n1292), .C0(n1291), .C1(out_census[10]), .Y(n1272) );
  CLKINVX1 U2147 ( .A(n1272), .Y(o_out_data[10]) );
  AOI222X1 U2148 ( .A0(n1293), .A1(out_data[14]), .B0(out_median[14]), .B1(
        n1292), .C0(n1291), .C1(out_census[14]), .Y(n1273) );
  CLKINVX1 U2149 ( .A(n1273), .Y(o_out_data[14]) );
  AOI222X1 U2150 ( .A0(n1293), .A1(out_data[3]), .B0(out_median[3]), .B1(n1292), .C0(n1291), .C1(out_census[3]), .Y(n1274) );
  CLKINVX1 U2151 ( .A(n1274), .Y(o_out_data[3]) );
  AOI222X1 U2152 ( .A0(n1293), .A1(out_data[20]), .B0(out_median[20]), .B1(
        n1292), .C0(n1291), .C1(out_census[20]), .Y(n1275) );
  CLKINVX1 U2153 ( .A(n1275), .Y(o_out_data[20]) );
  AOI222X1 U2154 ( .A0(n1293), .A1(out_data[17]), .B0(out_median[17]), .B1(
        n1292), .C0(n1291), .C1(out_census[17]), .Y(n1276) );
  CLKINVX1 U2155 ( .A(n1276), .Y(o_out_data[17]) );
  AOI222X1 U2156 ( .A0(n1293), .A1(out_data[11]), .B0(out_median[11]), .B1(
        n1292), .C0(n1291), .C1(out_census[11]), .Y(n1277) );
  CLKINVX1 U2157 ( .A(n1277), .Y(o_out_data[11]) );
  AOI222X1 U2158 ( .A0(n1293), .A1(out_data[5]), .B0(out_median[5]), .B1(n1292), .C0(n1291), .C1(out_census[5]), .Y(n1278) );
  CLKINVX1 U2159 ( .A(n1278), .Y(o_out_data[5]) );
  AOI222X1 U2160 ( .A0(n1293), .A1(out_data[9]), .B0(out_median[9]), .B1(n1292), .C0(n1291), .C1(out_census[9]), .Y(n1279) );
  CLKINVX1 U2161 ( .A(n1279), .Y(o_out_data[9]) );
  AOI222X1 U2162 ( .A0(n1293), .A1(out_data[8]), .B0(out_median[8]), .B1(n1292), .C0(n1291), .C1(out_census[8]), .Y(n1280) );
  CLKINVX1 U2163 ( .A(n1280), .Y(o_out_data[8]) );
  AOI222X1 U2164 ( .A0(n1293), .A1(out_data[7]), .B0(out_median[7]), .B1(n1292), .C0(n1291), .C1(out_census[7]), .Y(n1281) );
  CLKINVX1 U2165 ( .A(n1281), .Y(o_out_data[7]) );
  AOI222X1 U2166 ( .A0(n1293), .A1(out_data[16]), .B0(out_median[16]), .B1(
        n1292), .C0(n1291), .C1(out_census[16]), .Y(n1282) );
  CLKINVX1 U2167 ( .A(n1282), .Y(o_out_data[16]) );
  AOI222X1 U2168 ( .A0(n1293), .A1(out_data[6]), .B0(out_median[6]), .B1(n1292), .C0(n1291), .C1(out_census[6]), .Y(n1283) );
  CLKINVX1 U2169 ( .A(n1283), .Y(o_out_data[6]) );
  AOI222X1 U2170 ( .A0(n1293), .A1(out_data[22]), .B0(out_median[22]), .B1(
        n1292), .C0(n1291), .C1(out_census[22]), .Y(n1284) );
  CLKINVX1 U2171 ( .A(n1284), .Y(o_out_data[22]) );
  AOI222X1 U2172 ( .A0(n1293), .A1(out_data[1]), .B0(out_median[1]), .B1(n1292), .C0(n1291), .C1(out_census[1]), .Y(n1285) );
  CLKINVX1 U2173 ( .A(n1285), .Y(o_out_data[1]) );
  AOI222X1 U2174 ( .A0(n1293), .A1(out_data[13]), .B0(out_median[13]), .B1(
        n1292), .C0(n1291), .C1(out_census[13]), .Y(n1286) );
  CLKINVX1 U2175 ( .A(n1286), .Y(o_out_data[13]) );
  AOI222X1 U2176 ( .A0(n1293), .A1(out_data[19]), .B0(out_median[19]), .B1(
        n1292), .C0(n1291), .C1(out_census[19]), .Y(n1287) );
  CLKINVX1 U2177 ( .A(n1287), .Y(o_out_data[19]) );
  AOI222X1 U2178 ( .A0(n1293), .A1(out_data[18]), .B0(out_median[18]), .B1(
        n1292), .C0(n1291), .C1(out_census[18]), .Y(n1288) );
  CLKINVX1 U2179 ( .A(n1288), .Y(o_out_data[18]) );
  AOI222X1 U2180 ( .A0(n1293), .A1(out_data[2]), .B0(out_median[2]), .B1(n1292), .C0(n1291), .C1(out_census[2]), .Y(n1289) );
  CLKINVX1 U2181 ( .A(n1289), .Y(o_out_data[2]) );
  AOI222X1 U2182 ( .A0(n1293), .A1(out_data[0]), .B0(out_median[0]), .B1(n1292), .C0(n1291), .C1(out_census[0]), .Y(n1290) );
  CLKINVX1 U2183 ( .A(n1290), .Y(o_out_data[0]) );
  AOI222X1 U2184 ( .A0(n1293), .A1(out_data[12]), .B0(out_median[12]), .B1(
        n1292), .C0(n1291), .C1(out_census[12]), .Y(n1294) );
  CLKINVX1 U2185 ( .A(n1294), .Y(o_out_data[12]) );
  CLKINVX1 U2186 ( .A(sorter_sort_R_r_6__1_), .Y(n2271) );
  NAND2X1 U2187 ( .A(n2449), .B(n2277), .Y(n1296) );
  NAND2BX1 U2188 ( .AN(n1302), .B(n1301), .Y(n1304) );
  AOI2BB2X2 U2189 ( .B0(n1304), .B1(n1303), .A0N(n2441), .A1N(n1313), .Y(n1306) );
  NAND2X1 U2190 ( .A(n1306), .B(n2442), .Y(n1305) );
  INVX1 U2191 ( .A(n1306), .Y(n1307) );
  NAND2X1 U2192 ( .A(n1307), .B(n2016), .Y(n1308) );
  OAI21XL U2193 ( .A0(n1313), .A1(n2278), .B0(n1312), .Y(n833) );
  OAI21XL U2194 ( .A0(n1317), .A1(n2278), .B0(n1316), .Y(n832) );
  OAI21XL U2195 ( .A0(n1320), .A1(n2278), .B0(n1319), .Y(n829) );
  OAI21XL U2196 ( .A0(n966), .A1(n1516), .B0(n1676), .Y(n1322) );
  AOI2BB2X1 U2197 ( .B0(n1322), .B1(display_col[0]), .A0N(n1417), .A1N(n1321), 
        .Y(n1569) );
  INVXL U2198 ( .A(n1462), .Y(n1323) );
  AOI2BB2X1 U2199 ( .B0(n1325), .B1(n1404), .A0N(n1324), .A1N(n1850), .Y(n1326) );
  OAI21XL U2200 ( .A0(n1569), .A1(n2038), .B0(n1328), .Y(N446) );
  OAI22XL U2201 ( .A0(op[2]), .A1(n1329), .B0(n2425), .B1(n2400), .Y(n1330) );
  OAI31X1 U2202 ( .A0(op[1]), .A1(n2408), .A2(n2400), .B0(n1330), .Y(n1332) );
  OAI21X2 U2203 ( .A0(n1331), .A1(n1332), .B0(n1333), .Y(n1869) );
  NAND2X2 U2204 ( .A(n1333), .B(n1332), .Y(n2376) );
  AOI222XL U2205 ( .A0(filter_col[0]), .A1(n1870), .B0(cnt_255[0]), .B1(n1869), 
        .C0(display_col[0]), .C1(n1334), .Y(n1335) );
  CLKINVX1 U2206 ( .A(n1335), .Y(sram_addr[0]) );
  OAI21XL U2207 ( .A0(n1338), .A1(n2278), .B0(n1337), .Y(n831) );
  OAI21XL U2208 ( .A0(n1341), .A1(n2278), .B0(n1340), .Y(n830) );
  AOI2BB2X1 U2209 ( .B0(n1870), .B1(filter_row[3]), .A0N(n2424), .A1N(n2376), 
        .Y(n1342) );
  OAI2BB1X1 U2210 ( .A0N(n1869), .A1N(cnt_255[7]), .B0(n1342), .Y(sram_addr[7]) );
  NAND3BX1 U2211 ( .AN(op[3]), .B(op[1]), .C(op[2]), .Y(n1349) );
  NAND2X1 U2212 ( .A(n1345), .B(n1344), .Y(n2391) );
  OAI21XL U2213 ( .A0(n1805), .A1(n1346), .B0(n2419), .Y(n1347) );
  NOR2XL U2214 ( .A(n1349), .B(op[0]), .Y(n1350) );
  NAND2X1 U2215 ( .A(n1351), .B(n1350), .Y(n2389) );
  NOR2X1 U2216 ( .A(state[1]), .B(state[2]), .Y(n1588) );
  CLKINVX1 U2217 ( .A(n1561), .Y(n2393) );
  NOR2XL U2218 ( .A(dis_size[1]), .B(n2419), .Y(n1354) );
  OAI22XL U2219 ( .A0(n1557), .A1(n1354), .B0(origin_row[1]), .B1(n2395), .Y(
        n2387) );
  OAI22XL U2220 ( .A0(n2387), .A1(n2384), .B0(dis_size[2]), .B1(n2420), .Y(
        n1356) );
  OAI22XL U2221 ( .A0(n1553), .A1(n1552), .B0(n2419), .B1(n2395), .Y(n2385) );
  NOR2XL U2222 ( .A(n2420), .B(n2397), .Y(n1355) );
  OAI22XL U2223 ( .A0(n2385), .A1(n1355), .B0(dis_size[2]), .B1(origin_row[2]), 
        .Y(n1357) );
  OA22X1 U2224 ( .A0(n2389), .A1(n1356), .B0(n2391), .B1(n1357), .Y(n1360) );
  AO22X1 U2225 ( .A0(n1555), .A1(n1357), .B0(n1559), .B1(n1356), .Y(n1358) );
  OAI21XL U2226 ( .A0(n2393), .A1(n1358), .B0(origin_row[3]), .Y(n1359) );
  OAI31XL U2227 ( .A0(n2393), .A1(origin_row[3]), .A2(n1360), .B0(n1359), .Y(
        n953) );
  OAI21XL U2228 ( .A0(n1361), .A1(census_center_G[0]), .B0(census_center_G[1]), 
        .Y(n1363) );
  OAI21XL U2229 ( .A0(n2245), .A1(census_center_G[0]), .B0(n2231), .Y(n1362)
         );
  AOI2BB2X1 U2230 ( .B0(n1363), .B1(n1362), .A0N(census_center_G[2]), .A1N(
        n2227), .Y(n1366) );
  AO22X1 U2231 ( .A0(census_center_G[2]), .A1(n2227), .B0(n2223), .B1(
        census_center_G[3]), .Y(n1365) );
  OA22X1 U2232 ( .A0(census_center_G[4]), .A1(n2238), .B0(n2223), .B1(
        census_center_G[3]), .Y(n1364) );
  OAI21XL U2233 ( .A0(n1366), .A1(n1365), .B0(n1364), .Y(n1369) );
  OAI22XL U2234 ( .A0(census_center_G[5]), .A1(n2219), .B0(n2215), .B1(
        census_center_G[6]), .Y(n1367) );
  AO22X1 U2235 ( .A0(census_center_G[6]), .A1(n2215), .B0(n2185), .B1(
        census_center_G[7]), .Y(n1370) );
  OAI22XL U2236 ( .A0(n1371), .A1(n1370), .B0(census_center_G[7]), .B1(n2185), 
        .Y(census_N1) );
  OAI21XL U2237 ( .A0(n2307), .A1(census_center_R[0]), .B0(census_center_R[1]), 
        .Y(n1373) );
  OAI21XL U2238 ( .A0(n2351), .A1(census_center_R[0]), .B0(n2326), .Y(n1372)
         );
  AOI2BB2X1 U2239 ( .B0(n1373), .B1(n1372), .A0N(census_center_R[2]), .A1N(
        n2330), .Y(n1376) );
  AO22X1 U2240 ( .A0(n2330), .A1(census_center_R[2]), .B0(n2334), .B1(
        census_center_R[3]), .Y(n1375) );
  OA22X1 U2241 ( .A0(census_center_R[3]), .A1(n2334), .B0(n2338), .B1(
        census_center_R[4]), .Y(n1374) );
  OAI21XL U2242 ( .A0(n1376), .A1(n1375), .B0(n1374), .Y(n1379) );
  OAI22XL U2243 ( .A0(census_center_R[5]), .A1(n2342), .B0(n2346), .B1(
        census_center_R[6]), .Y(n1377) );
  AO22X1 U2244 ( .A0(census_center_R[7]), .A1(n2016), .B0(n2346), .B1(
        census_center_R[6]), .Y(n1380) );
  OAI22XL U2245 ( .A0(n1381), .A1(n1380), .B0(census_center_R[7]), .B1(n2016), 
        .Y(census_N0) );
  OAI21XL U2246 ( .A0(n2105), .A1(census_center_B[0]), .B0(census_center_B[1]), 
        .Y(n1383) );
  CLKINVX1 U2247 ( .A(n2433), .Y(n2106) );
  CLKINVX1 U2248 ( .A(n2432), .Y(n2107) );
  OAI21XL U2249 ( .A0(n2106), .A1(census_center_B[0]), .B0(n2107), .Y(n1382)
         );
  INVX3 U2250 ( .A(n2434), .Y(n2108) );
  AOI2BB2X1 U2251 ( .B0(n1383), .B1(n1382), .A0N(census_center_B[2]), .A1N(
        n2108), .Y(n1386) );
  AO22X1 U2252 ( .A0(census_center_B[3]), .A1(n2093), .B0(n2108), .B1(
        census_center_B[2]), .Y(n1385) );
  OA22X1 U2253 ( .A0(census_center_B[3]), .A1(n2093), .B0(n2114), .B1(
        census_center_B[4]), .Y(n1384) );
  OAI21XL U2254 ( .A0(n1386), .A1(n1385), .B0(n1384), .Y(n1389) );
  OAI22XL U2255 ( .A0(census_center_B[6]), .A1(n2088), .B0(n2119), .B1(
        census_center_B[5]), .Y(n1387) );
  AO22X1 U2256 ( .A0(census_center_B[7]), .A1(n2014), .B0(n2088), .B1(
        census_center_B[6]), .Y(n1390) );
  OAI22XL U2257 ( .A0(n1391), .A1(n1390), .B0(census_center_B[7]), .B1(n2014), 
        .Y(census_N2) );
  OAI21XL U2258 ( .A0(n1454), .A1(n2413), .B0(n1414), .Y(n1393) );
  CLKINVX1 U2259 ( .A(n1805), .Y(n1595) );
  XOR2X1 U2260 ( .A(n965), .B(display_col[2]), .Y(n1406) );
  XOR2X1 U2261 ( .A(n1837), .B(n1406), .Y(n1410) );
  XOR2X1 U2262 ( .A(n1840), .B(n1406), .Y(n1407) );
  OAI21XL U2263 ( .A0(n1847), .A1(n2413), .B0(n1674), .Y(n1408) );
  OAI21XL U2264 ( .A0(n1675), .A1(n2038), .B0(n1411), .Y(N448) );
  NAND2X1 U2265 ( .A(n1576), .B(cnt_255[2]), .Y(n1644) );
  NOR2X1 U2266 ( .A(n1644), .B(n2417), .Y(n1507) );
  NOR2X1 U2267 ( .A(n1676), .B(op_valid), .Y(n2380) );
  OAI21XL U2268 ( .A0(n1412), .A1(n2380), .B0(cnt_255[4]), .Y(n1413) );
  OAI31XL U2269 ( .A0(cnt_255[4]), .A1(n1580), .A2(n1645), .B0(n1413), .Y(n944) );
  OAI21XL U2270 ( .A0(n987), .A1(n2401), .B0(n1414), .Y(n1419) );
  OAI31XL U2271 ( .A0(n1417), .A1(n987), .A2(n1526), .B0(n2401), .Y(n1418) );
  NAND2X1 U2272 ( .A(n1423), .B(n1440), .Y(n2032) );
  OAI21XL U2273 ( .A0(n1462), .A1(n1563), .B0(n2032), .Y(n1426) );
  OA21XL U2274 ( .A0(n1567), .A1(n1423), .B0(n1568), .Y(n1424) );
  OAI21XL U2275 ( .A0(n2038), .A1(n1677), .B0(n1427), .Y(N450) );
  OAI21XL U2276 ( .A0(n1429), .A1(n2414), .B0(n1863), .Y(n1431) );
  MXI2X1 U2277 ( .A(n1432), .B(n1862), .S0(display_row[2]), .Y(n1791) );
  XOR2X1 U2278 ( .A(n965), .B(n2412), .Y(n1436) );
  INVXL U2279 ( .A(n1436), .Y(n1433) );
  XOR2X1 U2280 ( .A(n2028), .B(n1433), .Y(n1444) );
  NAND2X1 U2281 ( .A(n1568), .B(n1435), .Y(n2030) );
  XOR2X1 U2282 ( .A(n2022), .B(n1436), .Y(n1441) );
  OAI21XL U2283 ( .A0(n2032), .A1(n2412), .B0(n1790), .Y(n1442) );
  OAI21XL U2284 ( .A0(n1791), .A1(n2038), .B0(n1445), .Y(N452) );
  NOR2X1 U2285 ( .A(n2418), .B(n1521), .Y(n2381) );
  OAI21XL U2286 ( .A0(n2382), .A1(n2383), .B0(cnt_255[7]), .Y(n1446) );
  OAI31XL U2287 ( .A0(cnt_255[7]), .A1(n1645), .A2(n1517), .B0(n1446), .Y(n941) );
  CLKBUFX3 U2288 ( .A(i_rst_n), .Y(n2447) );
  CLKBUFX3 U2289 ( .A(i_rst_n), .Y(n2446) );
  CLKBUFX3 U2290 ( .A(i_rst_n), .Y(n2445) );
  CLKBUFX3 U2291 ( .A(i_rst_n), .Y(n2444) );
  INVXL U2292 ( .A(n1577), .Y(n1449) );
  NOR2X1 U2293 ( .A(state[3]), .B(n2407), .Y(n1573) );
  NAND2XL U2294 ( .A(n2407), .B(n2396), .Y(n1447) );
  OAI22XL U2295 ( .A0(n1449), .A1(n1592), .B0(n1448), .B1(n1447), .Y(
        op_ready_nxt) );
  OA22X1 U2296 ( .A0(n2419), .A1(n1451), .B0(n2402), .B1(n1467), .Y(n1450) );
  OAI33XL U2297 ( .A0(n2404), .A1(origin_row[1]), .A2(n1451), .B0(n1467), .B1(
        origin_col[1]), .B2(n2422), .Y(n1452) );
  NOR3BX1 U2298 ( .AN(op_mode[3]), .B(op_mode[1]), .C(op_mode[2]), .Y(n1455)
         );
  OAI31X1 U2299 ( .A0(n2017), .A1(n1456), .A2(n2426), .B0(n2020), .Y(n2021) );
  OAI21XL U2300 ( .A0(n1458), .A1(n2427), .B0(n1457), .Y(n950) );
  OAI31XL U2301 ( .A0(op_mode[0]), .A1(n1595), .A2(n1460), .B0(n1459), .Y(n952) );
  NOR4XL U2302 ( .A(op[3]), .B(op[1]), .C(op[0]), .D(n2425), .Y(n1466) );
  OAI21XL U2303 ( .A0(n1499), .A1(n2427), .B0(origin_col[0]), .Y(n1470) );
  OAI21XL U2304 ( .A0(n1481), .A1(n1499), .B0(n1470), .Y(n934) );
  OAI21XL U2305 ( .A0(n2185), .A1(n1471), .B0(n958), .Y(n889) );
  OAI21XL U2306 ( .A0(n2393), .A1(n2427), .B0(origin_row[0]), .Y(n1472) );
  OAI21XL U2307 ( .A0(n1557), .A1(n2393), .B0(n1472), .Y(n937) );
  NAND2XL U2308 ( .A(origin_col[1]), .B(dis_size[1]), .Y(n1473) );
  MXI2X1 U2309 ( .A(n2403), .B(origin_col[2]), .S0(dis_size[2]), .Y(n1475) );
  XOR2X1 U2310 ( .A(n1489), .B(n1475), .Y(n1477) );
  NOR2XL U2311 ( .A(n2402), .B(dis_size[1]), .Y(n1474) );
  OAI22XL U2312 ( .A0(n1481), .A1(n1474), .B0(origin_col[1]), .B1(n2395), .Y(
        n1487) );
  XOR2X1 U2313 ( .A(n1487), .B(n1475), .Y(n1476) );
  OAI22XL U2314 ( .A0(n1485), .A1(n2403), .B0(n1499), .B1(n1478), .Y(n932) );
  XNOR2X1 U2315 ( .A(origin_col[1]), .B(dis_size[1]), .Y(n1480) );
  XOR2X1 U2316 ( .A(n1479), .B(n1480), .Y(n1483) );
  XOR2X1 U2317 ( .A(n1481), .B(n1480), .Y(n1482) );
  OAI22XL U2318 ( .A0(n1485), .A1(n2402), .B0(n1499), .B1(n1484), .Y(n933) );
  NOR2XL U2319 ( .A(origin_col[2]), .B(n2397), .Y(n1486) );
  OAI22XL U2320 ( .A0(n1487), .A1(n1486), .B0(dis_size[2]), .B1(n2403), .Y(
        n1494) );
  NAND2XL U2321 ( .A(n2397), .B(n2403), .Y(n1488) );
  AOI2BB2X1 U2322 ( .B0(n1489), .B1(n1488), .A0N(n2403), .A1N(n2397), .Y(n1492) );
  OA22X1 U2323 ( .A0(n1491), .A1(n1494), .B0(n1492), .B1(n1490), .Y(n1498) );
  AO22X1 U2324 ( .A0(n1495), .A1(n1494), .B0(n1493), .B1(n1492), .Y(n1496) );
  OAI21XL U2325 ( .A0(n1499), .A1(n1496), .B0(origin_col[3]), .Y(n1497) );
  OAI31XL U2326 ( .A0(n1499), .A1(origin_col[3]), .A2(n1498), .B0(n1497), .Y(
        n931) );
  XOR2X1 U2327 ( .A(n1501), .B(n1500), .Y(n1502) );
  XOR2X1 U2328 ( .A(n1503), .B(n1502), .Y(n1506) );
  OAI21XL U2329 ( .A0(n1506), .A1(n1505), .B0(n1504), .Y(out_data_nxt[16]) );
  NAND3X1 U2330 ( .A(n1577), .B(n2407), .C(n2396), .Y(N653) );
  OAI211XL U2331 ( .A0(n2399), .A1(n2407), .B0(state[1]), .C0(state[3]), .Y(
        n1508) );
  OAI21XL U2332 ( .A0(n965), .A1(state[2]), .B0(n1515), .Y(n1593) );
  OA22X1 U2333 ( .A0(n1520), .A1(n1519), .B0(n1518), .B1(N653), .Y(n938) );
  NAND2XL U2334 ( .A(n1642), .B(n2418), .Y(n1522) );
  OAI22XL U2335 ( .A0(n1523), .A1(n2418), .B0(n1522), .B1(n1521), .Y(n943) );
  OAI21XL U2336 ( .A0(n1524), .A1(n2380), .B0(cnt_255[2]), .Y(n1525) );
  OAI31XL U2337 ( .A0(cnt_255[2]), .A1(n1645), .A2(n1526), .B0(n1525), .Y(n946) );
  OAI21XL U2338 ( .A0(n2380), .A1(n2379), .B0(cnt_255[1]), .Y(n1527) );
  OAI31XL U2339 ( .A0(cnt_255[1]), .A1(n2415), .A2(n1645), .B0(n1527), .Y(n947) );
  XNOR2X1 U2340 ( .A(n1532), .B(n1531), .Y(n1533) );
  OAI21XL U2341 ( .A0(n957), .A1(n1717), .B0(n1534), .Y(out_data_nxt[17]) );
  AOI21X1 U2342 ( .A0(n1541), .A1(n1540), .B0(n1539), .Y(n2372) );
  OAI21XL U2343 ( .A0(n2372), .A1(n2368), .B0(n2369), .Y(n1543) );
  NAND2X1 U2344 ( .A(n1543), .B(n957), .Y(n1544) );
  OAI21XL U2345 ( .A0(n957), .A1(n1545), .B0(n1544), .Y(out_data_nxt[23]) );
  XOR2X1 U2346 ( .A(n2359), .B(n1547), .Y(n1548) );
  OAI21XL U2347 ( .A0(n957), .A1(n1550), .B0(n1549), .Y(out_data_nxt[18]) );
  AO21X1 U2348 ( .A0(origin_row[1]), .A1(dis_size[1]), .B0(n1552), .Y(n1556)
         );
  XOR2X1 U2349 ( .A(n1553), .B(n1556), .Y(n1554) );
  XOR2X1 U2350 ( .A(n1557), .B(n1556), .Y(n1558) );
  NOR2XL U2351 ( .A(n1563), .B(n2398), .Y(n1565) );
  MXI2X1 U2352 ( .A(n1568), .B(n1567), .S0(n1566), .Y(N311) );
  NAND2BX1 U2353 ( .AN(n1570), .B(n1569), .Y(display_col_nxt[0]) );
  OAI21XL U2354 ( .A0(n1578), .A1(n1573), .B0(n1588), .Y(n1574) );
  NAND3XL U2355 ( .A(n1578), .B(n1577), .C(n1576), .Y(n1579) );
  CLKINVX1 U2356 ( .A(sorter_sort_R_r_5__7_), .Y(n2281) );
  OAI21XL U2357 ( .A0(n1588), .A1(n1591), .B0(state[3]), .Y(n1589) );
  OAI21XL U2358 ( .A0(n1595), .A1(n1594), .B0(n1593), .Y(n1596) );
  INVXL U2359 ( .A(sorter_sort_G_r_7__7_), .Y(n1603) );
  OAI21XL U2360 ( .A0(n1601), .A1(n2185), .B0(sorter_sort_G_r_8__7_), .Y(n1602) );
  OAI21XL U2361 ( .A0(n1604), .A1(n2185), .B0(sorter_sort_G_r_5__7_), .Y(n1605) );
  NAND2X1 U2362 ( .A(n2449), .B(n1607), .Y(n1609) );
  AOI22X1 U2363 ( .A0(n2448), .A1(n2306), .B0(n2440), .B1(n2297), .Y(n1608) );
  OAI21XL U2364 ( .A0(n1610), .A1(n1609), .B0(n1608), .Y(n1615) );
  INVXL U2365 ( .A(sorter_sort_R_r_5__3_), .Y(n2294) );
  AOI2BB2X1 U2366 ( .B0(n2330), .B1(sorter_sort_R_r_5__2_), .A0N(n1140), .A1N(
        n2294), .Y(n1614) );
  NAND2X1 U2367 ( .A(n2315), .B(n2291), .Y(n1612) );
  AOI21X1 U2368 ( .A0(n1615), .A1(n1614), .B0(n1613), .Y(n1618) );
  OAI22XL U2369 ( .A0(n2438), .A1(n2288), .B0(n2315), .B1(n2291), .Y(n1617) );
  OAI21X1 U2370 ( .A0(n1618), .A1(n1617), .B0(n1616), .Y(n1619) );
  OAI2BB1X1 U2371 ( .A0N(sorter_sort_R_r_5__6_), .A1N(n2346), .B0(n1619), .Y(
        n2280) );
  OAI21XL U2372 ( .A0(n2280), .A1(n2016), .B0(sorter_sort_R_r_5__7_), .Y(n1620) );
  NAND2X1 U2373 ( .A(n2227), .B(sorter_sort_G_r_6__2_), .Y(n1625) );
  NAND2X1 U2374 ( .A(n2223), .B(sorter_sort_G_r_6__3_), .Y(n1624) );
  NAND3X1 U2375 ( .A(n1626), .B(n1625), .C(n1624), .Y(n1629) );
  AOI21X1 U2376 ( .A0(n1629), .A1(n1628), .B0(n1627), .Y(n1633) );
  NAND2X1 U2377 ( .A(n2436), .B(n2192), .Y(n1631) );
  AOI2BB2X1 U2378 ( .B0(sorter_sort_G_r_6__6_), .B1(n2215), .A0N(n1633), .A1N(
        n1632), .Y(n2184) );
  OAI21XL U2379 ( .A0(n1636), .A1(n2014), .B0(sorter_sort_B_r_5__7_), .Y(n1637) );
  INVXL U2380 ( .A(sorter_sort_B_r_6__7_), .Y(n1639) );
  AOI21XL U2381 ( .A0(n1642), .A1(n1644), .B0(n2380), .Y(n1643) );
  INVXL U2382 ( .A(sorter_sort_B_r_7__7_), .Y(n1668) );
  AOI21X1 U2383 ( .A0(n1660), .A1(n1659), .B0(n1658), .Y(n1666) );
  AOI2BB2X2 U2384 ( .B0(sorter_sort_B_r_8__6_), .B1(n2088), .A0N(n1666), .A1N(
        n1665), .Y(n1823) );
  INVXL U2385 ( .A(sorter_sort_R_r_7__7_), .Y(n1673) );
  NAND2BX1 U2386 ( .AN(n1678), .B(n1677), .Y(display_row_nxt[0]) );
  MXI2X1 U2387 ( .A(n998), .B(sorter_sort_G_r_8__3_), .S0(n1680), .Y(n1679) );
  MXI2X1 U2388 ( .A(n2451), .B(sorter_sort_G_r_8__0_), .S0(n1680), .Y(n1681)
         );
  INVX3 U2389 ( .A(q_G[2]), .Y(n1906) );
  ADDHX1 U2390 ( .A(n1717), .B(n1713), .CO(n1690), .S(n1689) );
  ADDFX2 U2391 ( .A(q_B[1]), .B(n1682), .CI(n1906), .CO(n1710), .S(n1714) );
  NOR2X1 U2392 ( .A(n1689), .B(n1714), .Y(n1774) );
  NOR2X1 U2393 ( .A(n1776), .B(n1774), .Y(n1693) );
  ADDFX2 U2394 ( .A(q_B[0]), .B(n1550), .CI(n1907), .CO(n1713), .S(n1685) );
  OR2X1 U2395 ( .A(n997), .B(q_R[1]), .Y(n1684) );
  OAI21X1 U2396 ( .A0(n1776), .A1(n1773), .B0(n1777), .Y(n1692) );
  INVX3 U2397 ( .A(n1760), .Y(n1786) );
  ADDHXL U2398 ( .A(n1710), .B(n1711), .CO(n1696), .S(n1691) );
  ADDFX2 U2399 ( .A(q_B[2]), .B(n1141), .CI(n1735), .CO(n1718), .S(n1711) );
  NOR2X1 U2400 ( .A(n1696), .B(n1695), .Y(n1726) );
  ADDFX2 U2401 ( .A(q_B[3]), .B(n1694), .CI(n1884), .CO(n1707), .S(n1719) );
  NOR2X1 U2402 ( .A(n1698), .B(n1697), .Y(n1728) );
  NOR2X1 U2403 ( .A(n1726), .B(n1728), .Y(n1751) );
  NAND2X1 U2404 ( .A(n1696), .B(n1695), .Y(n1783) );
  OAI21X2 U2405 ( .A0(n1728), .A1(n1783), .B0(n1729), .Y(n1756) );
  AOI21X1 U2406 ( .A0(n1786), .A1(n1751), .B0(n1756), .Y(n1703) );
  ADDHX1 U2407 ( .A(n1707), .B(n1708), .CO(n1700), .S(n1697) );
  ADDFX2 U2408 ( .A(q_B[4]), .B(n2375), .CI(n1749), .CO(n1741), .S(n1708) );
  INVX3 U2409 ( .A(q_G[6]), .Y(n1878) );
  NOR2X1 U2410 ( .A(n1700), .B(n1699), .Y(n1750) );
  XOR2X1 U2411 ( .A(n1703), .B(n1702), .Y(n1704) );
  XNOR2X1 U2412 ( .A(n1883), .B(q_B[6]), .Y(n1761) );
  ADDFX2 U2413 ( .A(q_B[5]), .B(n1878), .CI(n1545), .CO(n1762), .S(n1740) );
  AND3X1 U2414 ( .A(n1712), .B(n957), .C(n1715), .Y(n1721) );
  AOI21X1 U2415 ( .A0(n1786), .A1(n1784), .B0(n1727), .Y(n1732) );
  NAND2X1 U2416 ( .A(n1730), .B(n1729), .Y(n1731) );
  XOR2X1 U2417 ( .A(n1732), .B(n1731), .Y(n1733) );
  OAI211X1 U2418 ( .A0(n957), .A1(n1735), .B0(n1734), .C0(n1801), .Y(
        out_data_nxt[11]) );
  CLKINVX1 U2419 ( .A(n1751), .Y(n1736) );
  AOI21X1 U2420 ( .A0(n1786), .A1(n1739), .B0(n1738), .Y(n1746) );
  ADDHX1 U2421 ( .A(n1741), .B(n1740), .CO(n1743), .S(n1699) );
  NOR2X1 U2422 ( .A(n1743), .B(n1742), .Y(n1754) );
  NAND2X1 U2423 ( .A(n1744), .B(n1752), .Y(n1745) );
  XOR2X1 U2424 ( .A(n1746), .B(n1745), .Y(n1747) );
  NOR2X1 U2425 ( .A(n1750), .B(n1754), .Y(n1757) );
  NAND2X1 U2426 ( .A(n1751), .B(n1757), .Y(n1759) );
  OAI21XL U2427 ( .A0(n1754), .A1(n1753), .B0(n1752), .Y(n1755) );
  AOI21X1 U2428 ( .A0(n1757), .A1(n1756), .B0(n1755), .Y(n1758) );
  OAI21X4 U2429 ( .A0(n1760), .A1(n1759), .B0(n1758), .Y(n1795) );
  ADDHXL U2430 ( .A(n1762), .B(n1761), .CO(n1764), .S(n1742) );
  XNOR2X1 U2431 ( .A(n1795), .B(n1765), .Y(n1766) );
  NAND2X1 U2432 ( .A(n1766), .B(n957), .Y(n1767) );
  XOR2X1 U2433 ( .A(n1770), .B(n1775), .Y(n1771) );
  OAI21XL U2434 ( .A0(n1775), .A1(n1774), .B0(n1773), .Y(n1780) );
  XNOR2X1 U2435 ( .A(n1780), .B(n1779), .Y(n1781) );
  XNOR2X1 U2436 ( .A(n1786), .B(n1785), .Y(n1787) );
  AOI21X1 U2437 ( .A0(n1795), .A1(n1794), .B0(n1793), .Y(n1799) );
  ADDHXL U2438 ( .A(q_B[7]), .B(n1796), .CO(n1797), .S(n1763) );
  OAI211X1 U2439 ( .A0(n957), .A1(n1883), .B0(n1802), .C0(n1801), .Y(
        out_data_nxt[15]) );
  XNOR2X1 U2440 ( .A(n1805), .B(display_row[1]), .Y(n1810) );
  XOR2X1 U2441 ( .A(n1806), .B(n1810), .Y(n1809) );
  OAI21XL U2442 ( .A0(n2032), .A1(n2414), .B0(n1807), .Y(n1808) );
  XOR2X1 U2443 ( .A(n1811), .B(n1810), .Y(n1813) );
  MXI2X1 U2444 ( .A(n996), .B(sorter_sort_G_r_8__1_), .S0(n1821), .Y(n1817) );
  MXI2X1 U2445 ( .A(n999), .B(sorter_sort_G_r_8__4_), .S0(n1821), .Y(n1818) );
  MXI2X1 U2446 ( .A(n1000), .B(sorter_sort_G_r_8__5_), .S0(n1821), .Y(n1819)
         );
  MXI2X1 U2447 ( .A(n2436), .B(sorter_sort_G_r_8__6_), .S0(n1821), .Y(n1820)
         );
  MXI2X1 U2448 ( .A(n2450), .B(sorter_sort_G_r_8__2_), .S0(n1821), .Y(n1822)
         );
  MXI2X1 U2449 ( .A(n2433), .B(sorter_sort_B_r_8__0_), .S0(n2040), .Y(n1826)
         );
  MXI2X1 U2450 ( .A(n2432), .B(sorter_sort_B_r_8__1_), .S0(n2040), .Y(n1827)
         );
  MXI2X1 U2451 ( .A(n2429), .B(sorter_sort_B_r_8__5_), .S0(n2040), .Y(n1828)
         );
  MXI2X1 U2452 ( .A(n1177), .B(sorter_sort_B_r_8__4_), .S0(n2040), .Y(n1829)
         );
  MXI2X1 U2453 ( .A(n2434), .B(sorter_sort_B_r_8__2_), .S0(n2040), .Y(n1830)
         );
  MXI2X1 U2454 ( .A(n2431), .B(sorter_sort_B_r_8__3_), .S0(n2040), .Y(n1831)
         );
  MXI2X1 U2455 ( .A(n2435), .B(sorter_sort_B_r_8__6_), .S0(n2040), .Y(n1832)
         );
  AOI2BB2X1 U2456 ( .B0(n1870), .B1(filter_row[1]), .A0N(n2414), .A1N(n2376), 
        .Y(n1833) );
  AOI2BB2X1 U2457 ( .B0(n1870), .B1(filter_col[3]), .A0N(n2416), .A1N(n2376), 
        .Y(n1834) );
  MXI2X1 U2458 ( .A(n2449), .B(sorter_sort_R_r_8__0_), .S0(n961), .Y(n1836) );
  OAI21XL U2459 ( .A0(n1837), .A1(n965), .B0(display_col[2]), .Y(n1838) );
  XOR2X1 U2460 ( .A(n1838), .B(n2416), .Y(n1851) );
  OAI21XL U2461 ( .A0(n1847), .A1(n2416), .B0(n1846), .Y(n1848) );
  AOI211X1 U2462 ( .A0(n1851), .A1(n1850), .B0(n1849), .C0(n1848), .Y(n1852)
         );
  OAI21X1 U2463 ( .A0(n1853), .A1(n2038), .B0(n1852), .Y(N449) );
  MXI2X1 U2464 ( .A(n2448), .B(sorter_sort_R_r_8__2_), .S0(n961), .Y(n1854) );
  MXI2X1 U2465 ( .A(n2441), .B(sorter_sort_R_r_8__6_), .S0(n961), .Y(n1855) );
  MXI2X1 U2466 ( .A(n2438), .B(sorter_sort_R_r_8__5_), .S0(n961), .Y(n1856) );
  MXI2X1 U2467 ( .A(n2315), .B(sorter_sort_R_r_8__4_), .S0(n961), .Y(n1857) );
  MXI2X1 U2468 ( .A(n2440), .B(sorter_sort_R_r_8__1_), .S0(n961), .Y(n1858) );
  MXI2X1 U2469 ( .A(n1140), .B(sorter_sort_R_r_8__3_), .S0(n961), .Y(n1860) );
  AO21X1 U2470 ( .A0(n2412), .A1(n1863), .B0(n1862), .Y(n1864) );
  AOI22XL U2471 ( .A0(n1870), .A1(filter_row[2]), .B0(cnt_255[6]), .B1(n1869), 
        .Y(n1866) );
  AOI22XL U2472 ( .A0(n1870), .A1(filter_col[1]), .B0(cnt_255[1]), .B1(n1869), 
        .Y(n1871) );
  ADDFX2 U2473 ( .A(n1993), .B(q_R[4]), .CI(n1749), .CO(n1875), .S(n1877) );
  ADDFX2 U2474 ( .A(n1878), .B(n1875), .CI(n1874), .CO(n1984), .S(n1972) );
  ADDFX1 U2475 ( .A(q_R[5]), .B(n2012), .CI(n1883), .CO(n1882), .S(n1874) );
  ADDFX2 U2476 ( .A(n1879), .B(n1878), .CI(n1877), .CO(n1973), .S(n1927) );
  INVX3 U2477 ( .A(q_B[4]), .Y(n1885) );
  ADDFX2 U2478 ( .A(n1880), .B(q_R[3]), .CI(n1884), .CO(n1879), .S(n1889) );
  ADDFX2 U2479 ( .A(q_R[6]), .B(n1883), .CI(n1882), .CO(n2005), .S(n1985) );
  ADDFX2 U2480 ( .A(n1885), .B(q_R[2]), .CI(n1884), .CO(n1890), .S(n1891) );
  INVXL U2481 ( .A(n1924), .Y(n1887) );
  OR2X1 U2482 ( .A(n1960), .B(q_R[0]), .Y(n1894) );
  AND2X1 U2483 ( .A(q_R[7]), .B(n1888), .Y(n1901) );
  ADDFX2 U2484 ( .A(n1749), .B(n1890), .CI(n1889), .CO(n1928), .S(n1923) );
  ADDFX2 U2485 ( .A(n1735), .B(n1892), .CI(n1891), .CO(n1924), .S(n1917) );
  ADDFX2 U2486 ( .A(n1894), .B(n1735), .CI(n1893), .CO(n1904), .S(n1916) );
  AND3X1 U2487 ( .A(n1895), .B(n1899), .C(n957), .Y(n1900) );
  XNOR2X1 U2488 ( .A(n1960), .B(q_R[0]), .Y(n1914) );
  ADDHX1 U2489 ( .A(n1904), .B(n1903), .CO(n1919), .S(n1918) );
  NOR2X1 U2490 ( .A(n1918), .B(n1917), .Y(n1951) );
  NOR2X1 U2491 ( .A(n1953), .B(n1951), .Y(n1922) );
  ADDFX2 U2492 ( .A(n1907), .B(n1906), .CI(n1905), .CO(n1913), .S(n1910) );
  ADDHX1 U2493 ( .A(n1914), .B(n1913), .CO(n1903), .S(n1915) );
  NOR2X1 U2494 ( .A(n1916), .B(n1915), .Y(n1936) );
  NAND2X1 U2495 ( .A(n1918), .B(n1917), .Y(n1950) );
  OAI21X1 U2496 ( .A0(n1953), .A1(n1950), .B0(n1954), .Y(n1921) );
  ADDHX1 U2497 ( .A(n1924), .B(n1923), .CO(n1926), .S(n1920) );
  NOR2X1 U2498 ( .A(n1926), .B(n1925), .Y(n1966) );
  NAND2X1 U2499 ( .A(n1926), .B(n1925), .Y(n1968) );
  ADDHX1 U2500 ( .A(n1928), .B(n1927), .CO(n1930), .S(n1925) );
  NOR2X2 U2501 ( .A(n1930), .B(n1929), .Y(n1969) );
  NAND2X1 U2502 ( .A(n1930), .B(n1929), .Y(n1967) );
  XNOR2X1 U2503 ( .A(n1933), .B(n1932), .Y(n1934) );
  OAI211X1 U2504 ( .A0(n957), .A1(n1885), .B0(n2011), .C0(n1935), .Y(
        out_data_nxt[4]) );
  XOR2X1 U2505 ( .A(n1940), .B(n1939), .Y(n1941) );
  CLKINVX1 U2506 ( .A(n1944), .Y(n1952) );
  XOR2X1 U2507 ( .A(n1952), .B(n1946), .Y(n1947) );
  OAI21XL U2508 ( .A0(n1952), .A1(n1951), .B0(n1950), .Y(n1957) );
  XNOR2X1 U2509 ( .A(n1957), .B(n1956), .Y(n1958) );
  NAND2X1 U2510 ( .A(n1958), .B(n957), .Y(n1959) );
  OAI211X1 U2511 ( .A0(n957), .A1(n1960), .B0(n2011), .C0(n1959), .Y(
        out_data_nxt[2]) );
  NAND2X1 U2512 ( .A(n1961), .B(n1968), .Y(n1962) );
  NAND2X1 U2513 ( .A(n1963), .B(n957), .Y(n1964) );
  OAI211X1 U2514 ( .A0(n957), .A1(n1965), .B0(n2011), .C0(n1964), .Y(
        out_data_nxt[3]) );
  ADDHX1 U2515 ( .A(n1973), .B(n1972), .CO(n1975), .S(n1929) );
  CLKINVX1 U2516 ( .A(n1994), .Y(n1981) );
  NAND2X1 U2517 ( .A(n1975), .B(n1974), .Y(n1997) );
  XNOR2X1 U2518 ( .A(n1977), .B(n1976), .Y(n1978) );
  OAI211X1 U2519 ( .A0(n957), .A1(n1880), .B0(n2011), .C0(n1979), .Y(
        out_data_nxt[5]) );
  NAND2X1 U2520 ( .A(n1995), .B(n1981), .Y(n1983) );
  CLKINVX1 U2521 ( .A(n1997), .Y(n1980) );
  AOI21X1 U2522 ( .A0(n2001), .A1(n1981), .B0(n1980), .Y(n1982) );
  OAI21X2 U2523 ( .A0(n2004), .A1(n1983), .B0(n1982), .Y(n1990) );
  XNOR2X1 U2524 ( .A(n1990), .B(n1989), .Y(n1991) );
  NOR2X1 U2525 ( .A(n1994), .B(n1998), .Y(n2000) );
  OAI21XL U2526 ( .A0(n1998), .A1(n1997), .B0(n1996), .Y(n1999) );
  OAI21XL U2527 ( .A0(n2014), .A1(n2013), .B0(n958), .Y(n929) );
  OAI21XL U2528 ( .A0(n2016), .A1(n2015), .B0(n958), .Y(n850) );
  INVXL U2529 ( .A(n2017), .Y(n2018) );
  OAI21XL U2530 ( .A0(op_mode[0]), .A1(n987), .B0(n2018), .Y(n2019) );
  AO22X1 U2531 ( .A0(n2021), .A1(dis_size[1]), .B0(n2020), .B1(n2019), .Y(n951) );
  OAI21XL U2532 ( .A0(n2022), .A1(n965), .B0(n2412), .Y(n2023) );
  XOR2X1 U2533 ( .A(n2023), .B(display_row[3]), .Y(n2026) );
  OA21XL U2534 ( .A0(n2026), .A1(n2025), .B0(n2024), .Y(n2037) );
  OAI21XL U2535 ( .A0(n2031), .A1(n2412), .B0(n2030), .Y(n2033) );
  MXI2X1 U2536 ( .A(n2035), .B(n2034), .S0(display_row[3]), .Y(n2036) );
  NOR2X1 U2537 ( .A(n2061), .B(n2088), .Y(n2043) );
  AOI211X1 U2538 ( .A0(sorter_sort_B_r_8__6_), .A1(n2063), .B0(n2043), .C0(
        n956), .Y(n2044) );
  NOR2X1 U2539 ( .A(n2061), .B(n2119), .Y(n2046) );
  AOI211X1 U2540 ( .A0(sorter_sort_B_r_8__5_), .A1(n2063), .B0(n2046), .C0(
        n956), .Y(n2047) );
  AOI211X1 U2541 ( .A0(sorter_sort_B_r_8__4_), .A1(n2063), .B0(n2049), .C0(
        n956), .Y(n2050) );
  NOR2X1 U2542 ( .A(n2061), .B(n2093), .Y(n2052) );
  AOI211X1 U2543 ( .A0(sorter_sort_B_r_8__3_), .A1(n2063), .B0(n2052), .C0(
        n956), .Y(n2053) );
  AOI211X1 U2544 ( .A0(sorter_sort_B_r_8__1_), .A1(n2063), .B0(n2055), .C0(
        n956), .Y(n2056) );
  OAI21XL U2545 ( .A0(n2057), .A1(n2065), .B0(n2056), .Y(n915) );
  NOR2X1 U2546 ( .A(n2061), .B(n2106), .Y(n2058) );
  AOI211X1 U2547 ( .A0(sorter_sort_B_r_8__0_), .A1(n2063), .B0(n2058), .C0(
        n956), .Y(n2059) );
  NOR2X1 U2548 ( .A(n2061), .B(n2108), .Y(n2062) );
  AOI211X1 U2549 ( .A0(sorter_sort_B_r_8__2_), .A1(n2063), .B0(n2062), .C0(
        n956), .Y(n2064) );
  OAI21XL U2550 ( .A0(n2069), .A1(n2086), .B0(n2068), .Y(n912) );
  NOR2X1 U2551 ( .A(n2082), .B(n2119), .Y(n2070) );
  AOI211X4 U2552 ( .A0(sorter_sort_B_r_7__5_), .A1(n2084), .B0(n2070), .C0(
        n956), .Y(n2071) );
  OAI21XL U2553 ( .A0(n2072), .A1(n2086), .B0(n2071), .Y(n911) );
  AOI211X4 U2554 ( .A0(sorter_sort_B_r_7__3_), .A1(n2084), .B0(n2073), .C0(
        n956), .Y(n2074) );
  OAI21XL U2555 ( .A0(n2075), .A1(n2086), .B0(n2074), .Y(n909) );
  NOR2X1 U2556 ( .A(n2082), .B(n2107), .Y(n2076) );
  AOI211X4 U2557 ( .A0(sorter_sort_B_r_7__1_), .A1(n2084), .B0(n2076), .C0(
        n956), .Y(n2077) );
  OAI21XL U2558 ( .A0(n2078), .A1(n2086), .B0(n2077), .Y(n907) );
  NOR2X1 U2559 ( .A(n2082), .B(n2106), .Y(n2079) );
  AOI211X4 U2560 ( .A0(sorter_sort_B_r_7__0_), .A1(n2084), .B0(n2079), .C0(
        n956), .Y(n2080) );
  OAI21XL U2561 ( .A0(n2086), .A1(n2081), .B0(n2080), .Y(n906) );
  NOR2X1 U2562 ( .A(n2082), .B(n2108), .Y(n2083) );
  AOI211X4 U2563 ( .A0(sorter_sort_B_r_7__2_), .A1(n2084), .B0(n2083), .C0(
        n956), .Y(n2085) );
  OAI21XL U2564 ( .A0(n2087), .A1(n2086), .B0(n2085), .Y(n908) );
  OAI21XL U2565 ( .A0(n2147), .A1(n2104), .B0(n2090), .Y(n904) );
  OAI21XL U2566 ( .A0(n2143), .A1(n2104), .B0(n2092), .Y(n903) );
  OAI21XL U2567 ( .A0(n2135), .A1(n2104), .B0(n2095), .Y(n901) );
  OAI21XL U2568 ( .A0(n2104), .A1(n2151), .B0(n2099), .Y(n898) );
  OAI21XL U2569 ( .A0(n2131), .A1(n2104), .B0(n2103), .Y(n900) );
  INVXL U2570 ( .A(out_median[1]), .Y(n2130) );
  NAND2X1 U2571 ( .A(n2105), .B(out_median[1]), .Y(n2111) );
  NAND2X1 U2572 ( .A(n2107), .B(n2106), .Y(n2110) );
  NAND3X1 U2573 ( .A(n2111), .B(n2110), .C(n2109), .Y(n2113) );
  NAND2X1 U2574 ( .A(n2113), .B(n2112), .Y(n2116) );
  AOI2BB2X1 U2575 ( .B0(out_median[4]), .B1(n2114), .A0N(n2431), .A1N(n2138), 
        .Y(n2115) );
  NAND2X1 U2576 ( .A(n2116), .B(n2115), .Y(n2118) );
  AOI22X1 U2577 ( .A0(n1177), .A1(n2142), .B0(n2429), .B1(n2146), .Y(n2117) );
  NAND2X1 U2578 ( .A(n2118), .B(n2117), .Y(n2121) );
  AOI2BB2X1 U2579 ( .B0(out_median[5]), .B1(n2119), .A0N(n2435), .A1N(n2150), 
        .Y(n2120) );
  NAND2X1 U2580 ( .A(n2121), .B(n2120), .Y(n2124) );
  AOI2BB2X1 U2581 ( .B0(n2124), .B1(n2123), .A0N(n2452), .A1N(n2122), .Y(n2125) );
  NAND2X2 U2582 ( .A(n2152), .B(n2125), .Y(n2157) );
  AOI211X1 U2583 ( .A0(n2154), .A1(n2432), .B0(n2128), .C0(n956), .Y(n2129) );
  OAI21XL U2584 ( .A0(n2130), .A1(n2157), .B0(n2129), .Y(n891) );
  AOI211X1 U2585 ( .A0(n2154), .A1(n2434), .B0(n2132), .C0(n956), .Y(n2133) );
  OAI21XL U2586 ( .A0(n2134), .A1(n2157), .B0(n2133), .Y(n892) );
  AOI211X1 U2587 ( .A0(n2154), .A1(n2431), .B0(n2136), .C0(n956), .Y(n2137) );
  OAI21XL U2588 ( .A0(n2138), .A1(n2157), .B0(n2137), .Y(n893) );
  AOI211X1 U2589 ( .A0(n2154), .A1(n1177), .B0(n2140), .C0(n956), .Y(n2141) );
  OAI21XL U2590 ( .A0(n2142), .A1(n2157), .B0(n2141), .Y(n894) );
  AOI211X1 U2591 ( .A0(n2154), .A1(n2429), .B0(n2144), .C0(n956), .Y(n2145) );
  OAI21XL U2592 ( .A0(n2146), .A1(n2157), .B0(n2145), .Y(n895) );
  AOI211X1 U2593 ( .A0(n2154), .A1(n2435), .B0(n2148), .C0(n956), .Y(n2149) );
  OAI21XL U2594 ( .A0(n2150), .A1(n2157), .B0(n2149), .Y(n896) );
  INVXL U2595 ( .A(out_median[0]), .Y(n2156) );
  AOI211X1 U2596 ( .A0(n2154), .A1(n2433), .B0(n2153), .C0(n956), .Y(n2155) );
  OAI21XL U2597 ( .A0(n2157), .A1(n2156), .B0(n2155), .Y(n890) );
  INVXL U2598 ( .A(sorter_sort_G_r_7__5_), .Y(n2167) );
  OAI21XL U2599 ( .A0(n2167), .A1(n2182), .B0(n2166), .Y(n879) );
  INVXL U2600 ( .A(sorter_sort_G_r_7__3_), .Y(n2170) );
  NOR2X1 U2601 ( .A(n2178), .B(n2223), .Y(n2168) );
  OAI21XL U2602 ( .A0(n2170), .A1(n2182), .B0(n2169), .Y(n877) );
  INVXL U2603 ( .A(sorter_sort_G_r_7__1_), .Y(n2173) );
  NOR2X1 U2604 ( .A(n2178), .B(n2231), .Y(n2171) );
  OAI21XL U2605 ( .A0(n2173), .A1(n2182), .B0(n2172), .Y(n875) );
  INVXL U2606 ( .A(sorter_sort_G_r_7__0_), .Y(n2177) );
  NOR2X1 U2607 ( .A(n2178), .B(n2245), .Y(n2175) );
  OAI21XL U2608 ( .A0(n2182), .A1(n2177), .B0(n2176), .Y(n874) );
  INVXL U2609 ( .A(sorter_sort_G_r_7__2_), .Y(n2183) );
  OAI21XL U2610 ( .A0(n2183), .A1(n2182), .B0(n2181), .Y(n876) );
  NAND2X2 U2611 ( .A(n2188), .B(n2187), .Y(n2214) );
  NAND2X4 U2612 ( .A(n2189), .B(n2241), .Y(n2208) );
  NOR2X1 U2613 ( .A(n2208), .B(n2215), .Y(n2190) );
  OAI21XL U2614 ( .A0(n2192), .A1(n2212), .B0(n2191), .Y(n872) );
  NOR2X1 U2615 ( .A(n2208), .B(n2219), .Y(n2193) );
  OAI21XL U2616 ( .A0(n2195), .A1(n2212), .B0(n2194), .Y(n871) );
  NOR2X1 U2617 ( .A(n2208), .B(n2238), .Y(n2196) );
  OAI21XL U2618 ( .A0(n2198), .A1(n2212), .B0(n2197), .Y(n870) );
  NOR2X1 U2619 ( .A(n2208), .B(n2223), .Y(n2199) );
  OAI21XL U2620 ( .A0(n2201), .A1(n2212), .B0(n2200), .Y(n869) );
  NOR2X1 U2621 ( .A(n2208), .B(n2231), .Y(n2202) );
  OAI21XL U2622 ( .A0(n2204), .A1(n2212), .B0(n2203), .Y(n867) );
  NOR2X1 U2623 ( .A(n2208), .B(n2245), .Y(n2205) );
  OAI21XL U2624 ( .A0(n2207), .A1(n2212), .B0(n2206), .Y(n866) );
  NOR2X1 U2625 ( .A(n2208), .B(n2227), .Y(n2209) );
  OAI21XL U2626 ( .A0(n2213), .A1(n2212), .B0(n2211), .Y(n868) );
  NOR2X1 U2627 ( .A(n964), .B(n2241), .Y(n2237) );
  INVX4 U2628 ( .A(n2237), .Y(n2243) );
  NAND2X4 U2629 ( .A(n963), .B(n2214), .Y(n2239) );
  OAI21XL U2630 ( .A0(n2222), .A1(n2243), .B0(n2221), .Y(n863) );
  OAI21XL U2631 ( .A0(n2226), .A1(n2243), .B0(n2225), .Y(n861) );
  OAI21XL U2632 ( .A0(n2230), .A1(n2243), .B0(n2229), .Y(n860) );
  OAI21XL U2633 ( .A0(n2234), .A1(n2243), .B0(n2233), .Y(n859) );
  OAI21XL U2634 ( .A0(n2244), .A1(n2243), .B0(n2242), .Y(n862) );
  INVXL U2635 ( .A(out_median[8]), .Y(n2250) );
  NOR2X1 U2636 ( .A(n2246), .B(n2245), .Y(n2247) );
  OAI21XL U2637 ( .A0(n2251), .A1(n2250), .B0(n2249), .Y(n857) );
  NOR2X1 U2638 ( .A(n2262), .B(n2338), .Y(n2252) );
  OAI21XL U2639 ( .A0(n2254), .A1(n2266), .B0(n2253), .Y(n839) );
  NOR2X1 U2640 ( .A(n2262), .B(n2334), .Y(n2255) );
  OAI21XL U2641 ( .A0(n2257), .A1(n2266), .B0(n2256), .Y(n838) );
  NOR2X1 U2642 ( .A(n2262), .B(n2326), .Y(n2258) );
  OAI21XL U2643 ( .A0(n2268), .A1(n2266), .B0(n2259), .Y(n836) );
  NOR2X1 U2644 ( .A(n2262), .B(n2351), .Y(n2260) );
  OAI21XL U2645 ( .A0(n2266), .A1(n2272), .B0(n2261), .Y(n835) );
  NOR2X1 U2646 ( .A(n2262), .B(n2330), .Y(n2263) );
  OAI21XL U2647 ( .A0(n2267), .A1(n2266), .B0(n2265), .Y(n837) );
  OAI21XL U2648 ( .A0(n2271), .A1(n2278), .B0(n2270), .Y(n828) );
  OAI21XL U2649 ( .A0(n2278), .A1(n2277), .B0(n2276), .Y(n827) );
  AOI2BB2X4 U2650 ( .B0(n2442), .B1(n2281), .A0N(n2280), .A1N(n2279), .Y(n2354) );
  AOI211X1 U2651 ( .A0(sorter_sort_R_r_6__6_), .A1(n2303), .B0(n2283), .C0(
        n956), .Y(n2284) );
  OAI21XL U2652 ( .A0(n2285), .A1(n2305), .B0(n2284), .Y(n825) );
  NOR2X1 U2653 ( .A(n2301), .B(n2342), .Y(n2286) );
  AOI211X1 U2654 ( .A0(sorter_sort_R_r_6__5_), .A1(n2303), .B0(n2286), .C0(
        n956), .Y(n2287) );
  OAI21XL U2655 ( .A0(n2288), .A1(n2305), .B0(n2287), .Y(n824) );
  NOR2X1 U2656 ( .A(n2301), .B(n2338), .Y(n2289) );
  AOI211X1 U2657 ( .A0(sorter_sort_R_r_6__4_), .A1(n2303), .B0(n2289), .C0(
        n956), .Y(n2290) );
  OAI21XL U2658 ( .A0(n2291), .A1(n2305), .B0(n2290), .Y(n823) );
  NOR2X1 U2659 ( .A(n2301), .B(n2334), .Y(n2292) );
  AOI211X1 U2660 ( .A0(sorter_sort_R_r_6__3_), .A1(n2303), .B0(n2292), .C0(
        n956), .Y(n2293) );
  OAI21XL U2661 ( .A0(n2294), .A1(n2305), .B0(n2293), .Y(n822) );
  NOR2X1 U2662 ( .A(n2301), .B(n2326), .Y(n2295) );
  AOI211X1 U2663 ( .A0(sorter_sort_R_r_6__1_), .A1(n2303), .B0(n2295), .C0(
        n956), .Y(n2296) );
  OAI21XL U2664 ( .A0(n2297), .A1(n2305), .B0(n2296), .Y(n820) );
  NOR2X1 U2665 ( .A(n2301), .B(n2351), .Y(n2298) );
  AOI211X1 U2666 ( .A0(sorter_sort_R_r_6__0_), .A1(n2303), .B0(n2298), .C0(
        n956), .Y(n2299) );
  OAI2BB1X1 U2667 ( .A0N(n2300), .A1N(sorter_sort_R_r_5__0_), .B0(n2299), .Y(
        n819) );
  NOR2X1 U2668 ( .A(n2301), .B(n2330), .Y(n2302) );
  AOI211X1 U2669 ( .A0(sorter_sort_R_r_6__2_), .A1(n2303), .B0(n2302), .C0(
        n2174), .Y(n2304) );
  OAI21XL U2670 ( .A0(n2306), .A1(n2305), .B0(n2304), .Y(n821) );
  INVXL U2671 ( .A(out_median[17]), .Y(n2329) );
  OAI22XL U2672 ( .A0(n2315), .A1(n2341), .B0(n1140), .B1(n2337), .Y(n2314) );
  NAND2X1 U2673 ( .A(n2330), .B(out_median[18]), .Y(n2310) );
  NAND2X1 U2674 ( .A(n2307), .B(out_median[17]), .Y(n2309) );
  NAND3X1 U2675 ( .A(n2310), .B(n2309), .C(n2308), .Y(n2312) );
  NAND2BX1 U2676 ( .AN(n2314), .B(n2313), .Y(n2318) );
  OAI22XL U2677 ( .A0(n2438), .A1(n2345), .B0(n2441), .B1(n2350), .Y(n2316) );
  AOI21X1 U2678 ( .A0(n2318), .A1(n2317), .B0(n2316), .Y(n2323) );
  OAI22X1 U2679 ( .A0(n2323), .A1(n2322), .B0(n2442), .B1(n2321), .Y(n2324) );
  NOR2X1 U2680 ( .A(n2354), .B(n2324), .Y(n2356) );
  INVX1 U2681 ( .A(n2354), .Y(n2325) );
  NAND2X4 U2682 ( .A(n2325), .B(n2324), .Y(n2352) );
  NOR2X1 U2683 ( .A(n2352), .B(n2326), .Y(n2327) );
  OAI21XL U2684 ( .A0(n2329), .A1(n2349), .B0(n2328), .Y(n812) );
  NOR2X1 U2685 ( .A(n2352), .B(n2330), .Y(n2331) );
  AOI211X4 U2686 ( .A0(sorter_sort_R_r_5__2_), .A1(n2354), .B0(n2331), .C0(
        n956), .Y(n2332) );
  OAI21XL U2687 ( .A0(n2333), .A1(n2349), .B0(n2332), .Y(n813) );
  NOR2X1 U2688 ( .A(n2352), .B(n2334), .Y(n2335) );
  OAI21XL U2689 ( .A0(n2337), .A1(n2349), .B0(n2336), .Y(n814) );
  NOR2X1 U2690 ( .A(n2352), .B(n2338), .Y(n2339) );
  OAI21XL U2691 ( .A0(n2341), .A1(n2349), .B0(n2340), .Y(n815) );
  NOR2X1 U2692 ( .A(n2352), .B(n2342), .Y(n2343) );
  OAI21XL U2693 ( .A0(n2345), .A1(n2349), .B0(n2344), .Y(n816) );
  NOR2X1 U2694 ( .A(n2352), .B(n2346), .Y(n2347) );
  OAI21XL U2695 ( .A0(n2350), .A1(n2349), .B0(n2348), .Y(n817) );
  NOR2X1 U2696 ( .A(n2352), .B(n2351), .Y(n2353) );
  AOI211X1 U2697 ( .A0(n2354), .A1(sorter_sort_R_r_5__0_), .B0(n2353), .C0(
        n956), .Y(n2355) );
  OAI2BB1X1 U2698 ( .A0N(n2356), .A1N(out_median[16]), .B0(n2355), .Y(n810) );
  OAI21X1 U2699 ( .A0(n2359), .A1(n2358), .B0(n2357), .Y(n2364) );
  XNOR2X1 U2700 ( .A(n2364), .B(n2363), .Y(n2365) );
  NAND2X1 U2701 ( .A(n2365), .B(n957), .Y(n2366) );
  OAI21XL U2702 ( .A0(n957), .A1(n2367), .B0(n2366), .Y(out_data_nxt[19]) );
  NAND2X1 U2703 ( .A(n2373), .B(n957), .Y(n2374) );
  OAI21XL U2704 ( .A0(n957), .A1(n2375), .B0(n2374), .Y(out_data_nxt[22]) );
  OAI31XL U2705 ( .A0(n2378), .A1(n2406), .A2(n2377), .B0(n2376), .Y(
        out_valid_nxt) );
  AO21X1 U2707 ( .A0(n2380), .A1(cnt_255[0]), .B0(n2379), .Y(n948) );
  AO22X1 U2708 ( .A0(cnt_255[6]), .A1(n2383), .B0(n2382), .B1(n2381), .Y(n942)
         );
  AOI2BB1X1 U2709 ( .A0N(dis_size[2]), .A1N(n2420), .B0(n2384), .Y(n2386) );
  XOR2X1 U2710 ( .A(n2385), .B(n2386), .Y(n2390) );
  XOR2X1 U2711 ( .A(n2387), .B(n2386), .Y(n2388) );
  OAI22XL U2712 ( .A0(n2391), .A1(n2390), .B0(n2389), .B1(n2388), .Y(n2392) );
  AOI2BB2X1 U2713 ( .B0(n2393), .B1(n2420), .A0N(n2393), .A1N(n2392), .Y(n935)
         );
endmodule

