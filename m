Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B0C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE9010E684;
	Sun, 27 Sep 2026 18:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gjC9nNFk";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MSy8BMAO";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9784510E684
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:28:19 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R7m2Ev2776667;
 Sun, 27 Sep 2026 13:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Gxu47pdppu7/IhBYSFKrpvBmFIUx34H5gRbp8Zjd/
 As=; b=gjC9nNFk8fDSU2ttG3U4/IovHnl04pvhFPrFBK22jPiwQ6+PAg1Het1JY
 uWOXQi+tUPTTWaTdA7vyJYsN/XFDh3mgXWty6MZAOn0Xp9VRK3b6BJEDrOXcUOuv
 wGK9CYHIx+gP67k8RfmXtuNrLe+360XIMafoTj0mX5bVaEuE9pNFEeZpkYEHkdut
 p7NCOFde9s2VbVi9fpoGA/hPm0+pK9gtkdo+noSfG0FESGgfvdmG5OdMEVmzGSM3
 Q3QMz4tZdLXbmQ+9lrKkPLeBRYXiVdmX1U0OisVLSmtQDH1ooqAVAScO0DaCIwxk
 TZdNIU16h+vnvriH3vLTi/N8DbHhw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nhp76-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:28:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2wOvE8Ln9RGZr4J6R9+8lHeYVGS+4BhjERdNGMIItRP84QGUQ34lRjJ+EPiCJvSen9mPC3GjN49YBvi3TZlZm4Q8NZVfOKsWT0cTeE/3UC85IPjkyJAZTNQS+OCu9lCATIX2l0xHEh96qPD7DATg+dn0jTYLlud8xyA1fiUdRizjdWW6lV3EmAigmD1fqlnA6LoP4BLsBr6QiHcW53Ex0q10Tw/bbuVsdIOQ0oPbk329G9tb6id9cuZq9/aWU74Xa7Z7Nn4oY5lnu1COWggRxMx/v2yyRbmSzVjLCcwzPGN3MdWxeVA4YYopdLU8I3989mRCN4DIikfPTtt0J7ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxu47pdppu7/IhBYSFKrpvBmFIUx34H5gRbp8Zjd/As=;
 b=PNluHgQOjcyixTjQApL7+IgZHF7MCJ3M5s3BoVqCCN2JJdOAiJky+wRdlutvQr5WcDvsrPP0xBhm1aws9oa8wSHNeGMINmRz9F1lhRcXyXXw7CtL0DqKRuLSFCznfweyig9+KZWSgPcuR2GF55KEHUUMaQWPoc8zU7dqg1N0NWXuCngQGukh8kSBLl6JDwfHteZD3I92McU+E1AV2o9IM2GwFvjqAg/Jz4dTcwjSSEhEoaO0XGBGoDuNf/OZ96n4MZ9Rgk+Y0W0Gx8TgqULUZLiSFbMiLcoxRJqsuu6oYrN4gLK7ZV7jP9M+asHOla9AsDjzJ4uyqtP/+LGeFMvvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxu47pdppu7/IhBYSFKrpvBmFIUx34H5gRbp8Zjd/As=;
 b=MSy8BMAO9wlO2xuCmvIjLTAiJVR7gjisXPBBKdWsKJbqhck6T1D1TEXmiPAAxJJ6SOVDMgP4fVo0b8LStVRGEdtn1BpEoL/TsCihlgq+zoSz3s9osB5EDSPX9NBy+8iS27rW6tf8uWeMRxWik53+gptF1NxT4bkh8Lj2e90V05I=
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by IA0PR10MB7547.namprd10.prod.outlook.com (2603:10b6:208:493::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sun, 27 Sep
 2026 18:26:23 +0000
Received: from BN3PEPF00022BC1.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::1) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:26:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF00022BC1.mail.protection.outlook.com (10.167.248.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:26:21 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:56 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:55 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPsSt1629926;
 Sun, 27 Sep 2026 13:25:55 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 13/14] arm64: defconfig: Enable DRM_SSD16XX for AM62L3 EVM
Date: Sun, 27 Sep 2026 23:53:28 +0530
Message-ID: <20260927182329.4193961-14-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC1:EE_|IA0PR10MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad99929-b2b6-4520-5bf2-08df1cc4d46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|56012099006|10067099003|22082099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info: +z8SmPSSEO/05tMIjTBsFCXMnK7xSOjmu4RVWlA1lM7+Bmm2IscvOeQobMpnfnOq/+EWVeEYmVsDjdTkJbf+3fAMeVc6UntZKd0w6Hs2uD2bkgtLdAkFIyMcTwSiKjb1oARA87Oi7BdGU3JRH8/hLqVG9rznJfM/3lt3nbkaNOvuK0RAAVvzGf+HDzAv5XX3fLzidV9t885VNuDaI5mYmWKoousAHgPsjkzVOgebaM5eM+ww40h8+Si1qCyVFoxewhW21rH1pLjwiZCfMaeZtyGd5SBZUd77tCLEkRZgIojvaa23xvGaEMpg55mVPRpuHatIzCaLXRRk732zg49jC3DJhll2qKjS4ZpceZPezyrXYwPLbw4Qi3Oq+2HUglFp3/aD98pQEmT/XhKqS3fLHW0k4cNSsUhjsX2EpajHLVDZCffGFWMAx7vX0K88F01r29ufprWqjh5RK2fRFsO18FjfeX8pgDKSqsb0ZUXZgY7y254KzQInM5fXE+E7Q9RMODyX5YT33tdRmF232PUx9uhac/YsdwlDmUIKRKSju+vIyqrJdFQ74cuUicGIoNIvfJyUfe0D1v0n4QPLdHh+tPsu2wemUgJMnRl8UN5jKe3TVWXViV4OjiTQjADfP3zVqAScs2cIOZZnnlzSgjmT6bTOnDnij33OLZ09g9HGFjt4p5FUl4wxG6ktoAxjL+qWBaxGL078tjw8YDcdLsr5bQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(10067099003)(22082099003)(18002099003)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N+UCwWvcSuXiersb+CjQB2h9JdSoogkckAmuzA7PP7FfNhPJwQEbVM6rzhurXHutsINFG57t5XJRDh7QVhPrs6/oKgVMh1WnV8fX9Ebkdbzaa6F4nt9mx+vGM/3BFz9AyAmEiMqstiONEkKb8QrmIpto4Y9A+7gBxZ03YjlvuIGOFCh3YU2Bod98+ukbj5h+fh0hAESRGVWjQ4+1NZQxKJVUdzSLKsd1l+DcJeVe/wkgXbAd9fOlunJaYlJTWY2gYxrcw3HcMyWfm9+c3T/2TM3jo4yuDCXp6wH5Q+UlfbGFV1D0x28xaOtraH9ZhMaZe1tQz+1nk19eKRh+i9jehLY/eIgdvsS0C+hdNFGKqhNwevjup8L39wngy7UjhqRhUrPtFML21NBTU+yi/ZpvmKpHBveLpaGEIzCRxKonaMKABllUpfLy7E7HaWFZeq2v
X-Exchange-RoutingPolicyChecked: aAouggygX5eTL0gvtXB+dI2BfrwivgCG+101ZfBmZYmvqzPM92/82uefB9anhDNdlWNyz83P3gk1zq+xsC3A2gQ5qe5sy7rJ1he/2xeshvlNKzusc4A3lL53Y0spLWv2X9XaqggapIjP3gocwClwV4fO5fBaMOAtGdVj2iizmRJIPo0/wE1jmsu82CltxRMaYm0/vgHnfdynjkk/xX0blOryoTV+giRSR40oQRUnKNq9HXPSkO12Rl+TfawGoaJ4EWHZXFXW8ZP4xoP/L87ZIimHbw3A6FMM/Ayu6KFjlaf/yK+mOakWWp07JEflaTeSdS5eg2xOQkwRtXPQ4EtqEg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:26:21.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad99929-b2b6-4520-5bf2-08df1cc4d46c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7547
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX1zgcZf4ZT02z
 uhJ0DR3igz7wv+hRWJ6KEDhrxSgt2QqyBSfl44LnkzECfdgv933daFCEk1qQcHiiV3gX9z66jn7
 TUaY5Hb2iYardXsomw5+pq4P3VfaeDs=
X-Proofpoint-ORIG-GUID: Rx1z0zQVDdgs6FTSDXGeNELEGHfLDBBf
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6ab9603f cx=c_pps
 a=Qv0FdJiMAyQkWbHkl99ofg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=fGhLjsSNAAAA:8 a=sozttTNsAAAA:8 a=vHdQt_7x38hL7c0CWosA:9
 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-GUID: Rx1z0zQVDdgs6FTSDXGeNELEGHfLDBBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX5/psd4avIfgU
 cj1niMX/9cJzYh/yD7WXqfIZ5yVFKBOiXsJBlg2fCN7pOobVqt0EYq901kunuMf9GDZCMm3dxhy
 ZXVjisYtPuX635ApqbAr5/bu4cbb7Yticj7+xvjVbxqu3znb57YcndiqKq1z5azJtBTp+UdzbTg
 1ydEI46xawZGrMOmGZra4Vs+DwSqgOBJaiDmAyVnvl96s85/z0OP8u/1DuEJPtGI5/uzHV8Wa1q
 XEm3ASjoazPPNWeVI3+strAYLQog2L0IKqYPlX/+TJNlbyXWLNqZg1aVHQEp+CfHEiSj29gDpdY
 FrKa8gMGUh4+lxN6uPRL9bL85qWMJroTFTNJ4XlvzzfsEYiDPgPpPEjX1SFngGPGUf/E0oYzTVn
 VqroL7tMedvT0C9O00z3JXXzR48fmlvgNS/8WRbjhwmIu9qx1BbOOMqGYqgWd+f00dzq0FEsSTe
 SjCnTaWfWGLNetKmjuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270073
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

Enable the SSD16xx e-paper DRM driver as a module in the arm64
defconfig for use with the AM62L3 EVM and BeagleBadge boards
which comes with ssd16xx based epaper display mounted on the
board [0].

[0]:
https://www.beagleboard.org/boards/beaglebadge
https://www.beagleboard.org/blog/2026-03-09-introducing-beaglebadge-a-new-vision-for-open-source-wearables-and-iot

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - Updated defconfig for DRM_SSD16XX (renamed from DRM_PANEL_SSD16XX)

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6858b75a05f4..f10e295d5aae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1050,6 +1050,7 @@ CONFIG_ROCKCHIP_DW_HDMI_QP=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_ROCKCHIP_LVDS=y
+CONFIG_DRM_SSD16XX=m
 CONFIG_DRM_STM=m
 CONFIG_DRM_STM_LVDS=m
 CONFIG_DRM_SUN4I=m
-- 
2.39.1

