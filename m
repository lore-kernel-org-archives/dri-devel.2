Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB3C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971B310E8E3;
	Tue, 28 Jul 2026 13:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SYbWFBWl";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="d/Ha47mr";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008AB10E571
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:53:47 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SCRvuf3668853
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FSEAfRKuG/hnocoMI5wKiJzTyiYyBzVRwff0YPHzu
 3I=; b=SYbWFBWl+10akGn7Y5+SPra78tvxoemJcWu16ENltMqTxM3f+x3RCwcJn
 keZVEBF3uYOO4EUvMA8VBg/uy2MgHVin84BY8kwldb12AwKjDuB6W0Um9rsZZYfk
 aNAzRfdp8ersOrlWC34DHg2LwqiMBr7ZmVUmGiUCRWfSeLGv9yFRjV2VKItYR3mT
 6d4V4e8HJ3UaIBgDcridbquztMcW84qBtae0QMjOuSFsaFOxrp49vMZNj87zswo3
 44Yv0pTtwOeFS3N2/gERwuBSArK2hV1pZ1lWLByyF9QWcbw+ulXqX822FE07rZjv
 XQuBq5RJoeg4gbfW62kRDXpYdAy5w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpvexg447-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdlzVuFzGzQVO7Bq09M6BEWY60PIhuh5ViYXxSVj/HfFaz2/Z6WsSvCTZ4MENmIxgyFS3gU5QMOls1bYC3GbkhU3AOIhSZqHnrMeEeyCIhptBdPUS80NqQWLfGpmYb79gC82Tl97HnNo+XQ//zdHA/N2j+sEOiUnOdPwiYGrq1AhKShO+jOndoW2PYq87qmLEkaGf/mGDHXcGxP64h5VsbzKQNMSVeyHZ/oxw7FV/0QMu3MK5wTb7aZhul9GVbWBpMd9F9lm6EAAebCq1mAA2uFvLCtAdif8qxLVbU6STvz0F/axSXpjDwobLPVkycb3D24eakZPqC7/2+/OJduuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSEAfRKuG/hnocoMI5wKiJzTyiYyBzVRwff0YPHzu3I=;
 b=UtHcHYKDzYix86UW5MK/UGesIyQcvfzOlMI9eduF4VAiFEpXtYnRKhScpGKmie24I4eG6GrfZTGSjEWU2iSA28ftO9uqea1uajLtHCDQx8UxS+XwvuraIC6lkdNMFx+dbwjyC231XOxlyrqaHd7g7GZh9CBma3Y1JyNFrSS+tRoMT2ol5Bn4Ozo5rDdL+LadXvsgijifd+yrVm1ByOyyqL2vAi3593nRYfLi1okE08CD9CQ/RNFNyT1haqgHI2ZZFhbrdy3Sp51ZlicP/j5yz6Bo0Zn5XzhFmU/DTibL+Lk+oiru6j9asc+xWuqopHPajyuNOevZbOnW/Kzysp3zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSEAfRKuG/hnocoMI5wKiJzTyiYyBzVRwff0YPHzu3I=;
 b=d/Ha47mrdYHwc4Iimeb7uTbfm2bFSfsWPD3xBuaML0WWoSy1ZaaWjum6rTPWNDzo8khFI1eEBDJ3ibyB3FbyUgkimsXYsuD/XjOS8ZFCUNiC0VS46zYjoQWmp1Jx+RspDsRvdQR5f4zQtYpxk0YeBzmo2O4JX6x25ZrnFK0sMIg=
Received: from CH2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:610:50::16)
 by IA3PR10MB8019.namprd10.prod.outlook.com (2603:10b6:208:513::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 12:53:43 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::69) by CH2PR16CA0006.outlook.office365.com
 (2603:10b6:610:50::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 12:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 12:53:42 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:42 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 07:53:41 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SCrdf82709466
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:41 -0500
From: Yashas D <y-d@ti.com>
To: <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 1/2] dt-bindings: display: bridge: cdns,
 mhdp8546: Add no-hpd property to the cadence bridge
Date: Tue, 28 Jul 2026 18:23:35 +0530
Message-ID: <20260728125336.776116-2-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728125336.776116-1-y-d@ti.com>
References: <20260728125336.776116-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|IA3PR10MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e9d6e2-383c-41a7-c0c7-08deeca740dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: iA1lWNzmEHTqPKbGHOXBW005vVfWGoBB8WDEMK4IKLXi3TJPTyJuSmNjWwqS86xsZ+p3q8A0jj4o7vfA3Y3jPaOjoxIxMVObUmDVhzL5qr0SbP//ZQ3IxvKyhigS3hmQBPWWyEjt/9F9yjlgM2jb0pNFX6ShEEF5UrAodq8ScrVnpoX4JUvw2ta3BE/wE6KMIj/+X00/reCHNk2vzwndpqAAdHF4/EmCkgl4dfqEVafJzFufqH+5vHzx/PVnsgKDgAUSb8Bja8jYi5Ce5cQ4guNJS4zYyzfTPHTj3TfMHhzAuuhn9V5eGY3uNSKrL5Kg66QhI3oZq2snGbKQdhJfiCKqsm2UFXHIiJTtLpyJFu8icPMiMJe898A3KLdUp//jeM2C0tfGpF/YJ8Z69U+CeaIcAR4EuBQawvSO0cwaxeo7WPIBW9T3hJHQEmk2yu4pfCBS/JTwS7H01DMJs3yrzT6ZB+yw/nixLkJeYsQm71CfgQ3P3VEDYE/BzIzJPrQraoB2/hek3abTvpuGIKkg/jZ2IYnA0VvrsDdJ5H2aRR4l3SeN6omqsKMoQBrhS5+/p6bjHVstqk4JfBgDhagWFN/vLUorM9s4j3ZqAAo8IV595XehiyGBB9Kq8a59JoNe/iiLAtAmD9m+3N2sNzMzuTcHKLeZuFjl/IEF6SnSEXdXrSeepfU2nksmLkcy+HBZmxZRlpXZv2s40mNk+Gc7Lg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vxtto426hihsNJl9enm3wcstezOq7XkDYehpDJlBYzGi5E9JlbrO421gDm47IJEKcebTlBlnW7VrRbs9C83Y/F47j7MiCBC6L1RyfZy3oK0Q6odG+0V9XNZtl1zdvhEIBq3N8ysRf3y4xOnOzrq2ivU0ONnSMq+UyuXeUu79KpTrr0Y0eVGEKX/0iyqvXNqMuhLdG937A2GtYF4ckjW+EQ4TrLlNkdRhHak4khMDwK/y9wZr3FnGA51DsZ5ZAzEimlYaemfXz/RZeaAY9g+B/ACjvZI33Wo8+cy7zEWN4H20XwASZjNYMfO+fRKLKTxI2mNHGi9VoeF52H44CSuQ3O+0/mFDmtBtBgeHrPaBK4lEW6XU+hDvM6U4vrGy7aypgtgv0haFtKaGGGmt6Q7XsrjFsndgf8BeEZcuAJpbITfv/RaZlnnsxof6ADsUaGJp
X-Exchange-RoutingPolicyChecked: aXzENDG3ItXeLNQTQb1VyNix4B6RdW0RM1O/p3UAfc736tFibPiW1Mt/n2HRzLM0nxx51slbIX73DkyuHvKSHtxJ1t3McVYWhNVIjCH2A4zRPwUF2vQkux5vmdMD3naTBjkOyL6QG445V4QIeUl6Tv8JQIRMtwYoZFQwU2+P8V5KTeDN9sIRWFdT0o/AMjwQO+LtPlguMyBi2tN9+1yL7ftGUBnz+iajNelNfJzwfmmppMpXv/0yuCLi48WYVMBz+yE8qs9d5oB4DUChd8E+uUC7RqgNcRSwbVSArw42Zd8bHscBL1XjFl4Rt3rrHAxwqMJUOlNx0+VxWCmQnP0g1A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:53:42.4096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e9d6e2-383c-41a7-c0c7-08deeca740dd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfXzIIrDQQLf6zI
 CmJpY3qsDpn9q+ai4+YfGwQKuBaLPIUGUfpv+8+WVgezFydqyMXnmS2mQYX89G0EO8FLtBm54gl
 fRS6/D9mOw+4DxR78AkOtCk3FzH4RR3R5AxYsdC/49GZtgSGyahyQGcfg1u0hCIIGP6CNEHC3u5
 IDm/9TVKsfNTcaPDIVkljKGKc5D9oaPqifW6vkPsfnxHEV5zl+gXv+1/ZFYGFSVB2/dpNDBVFAO
 x+X46ANxdl4nd440ZdKCoNY1PYIoaLrZHDf29znHZRbOCU4UXQz07a15mFikBKumVBzXIpji0AM
 dby4WXYGKGoly85pd2TANRSo5UIODRJjKI+e9UIF8orwHutMJJi3mV/5A5YlgC3FdIb6cr5i/I2
 4s+tQLTXchUXmqxDl2RppcS5AptbdbuYpyYJ0lkcpExkSPu491Fl1uAF8HmWAW8j89CW6CYGmPD
 w2Be7lHBHEosLhTYqxA==
X-Proofpoint-ORIG-GUID: GKHnGVhm_d54fLGg5uhxJFKVhxH1A8jm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfX3Vy//GJDQ0js
 wy6jNyy4Dj5LcywMDHDF8R+hgchYqs9HGGdlp0HaJEZUFB2uMAa3wNkW8NjdsQuWxY+2IEL0sfV
 Kf/G54Os/rsXU/SykWEnxwBqwUYwvJM=
X-Proofpoint-GUID: GKHnGVhm_d54fLGg5uhxJFKVhxH1A8jm
X-Authority-Analysis: v=2.4 cv=IYW3n2qa c=1 sm=1 tr=0 ts=6a68a65a cx=c_pps
 a=zwUidnFXtIpczQ2t7519XA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=EzX1xrUl6JEdRszeJO8A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280113
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:01:38 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Rahul T R <r-ravikumar@ti.com>

The mhdp bridge can work without its HPD pin hooked up to the connector,
but the current bridge driver throws an error when hpd line is not
connected to the connector. For such cases, we need an indication for
no-hpd, using which we can bypass the hpd detection and instead use the
auxiliary channels connected to the DP connector to confirm the
connection.
So add no-hpd property to the bindings, to disable hpd when not
connected or cannot be used for hotplug detection.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../bindings/display/bridge/cdns,mhdp8546.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e..f19a4900ecd8 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -57,6 +57,23 @@ properties:
   interrupts:
     maxItems: 1
 
+  no-hpd:
+    type: boolean
+    description:
+      Set if the HPD line on the bridge isn't physically connected to the
+      DisplayPort connector or cannot be used for hotplug detection.
+
+      Valid use cases include:
+      - HPD pin not routed to the connector on the PCB
+      - HPD signal muxed with another function (e.g., audio) on the SoC,
+        making it unavailable for hotplug detection
+      - Hardware design where HPD cannot reliably detect monitor presence
+
+      When this property is set, the driver will use auxiliary channel (AUX)
+      DPCD reads to detect monitor connection instead of relying on the
+      hardware HPD signal. Monitor detection will use polling rather than
+      interrupt-driven detection.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.34.1

