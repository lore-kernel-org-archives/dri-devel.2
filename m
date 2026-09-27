Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBB2C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C4010E676;
	Sun, 27 Sep 2026 18:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E+GiLypT";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CbR4xp28";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7385C10E679
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:26:09 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R8pbgn3706250;
 Sun, 27 Sep 2026 13:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ZhbZ43vVGnvQ0IYCxKWBLDtdACiVcvnqbKjQMbMxL
 n8=; b=E+GiLypTKY0V3GvQOqjsVLUcpsMlO1tp2l8MgZBknwkDvqKbscpEvs5JW
 p44tably5bfo8fJl6HC4RmxaGelDIcKc7dQ6sR1KMhu6SGyfjQqFo98pre770l/S
 9NjBSUMtGymP9pSN0ktTME/yaekFPHCjZ0PcljV9s6ykJr6DBsGkmZWiF5ZFXjoM
 havN8j6XVEqd6cxCLON1yMHzMFjejTLveqEJDvoyY9h4Cnf4sOx3RAG7Q+skA/z/
 kJmmK36HTl91LQ6xnZn7CsOl41MPQ5QM9EfJ0S1ZCeknfnh/Yx0PLLuR+7TINox6
 QrXw/Ivf00vEZnxQaPGCL6PysD8qg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gy00n9hsr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:26:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MS/fDUk0j2akcYWMub+XGrNT5BfkWeubWbQX4vizD5n00AhJgvHodrdBuac4bKALXWRq1dhDwbBbIFe63XmDdvsmTQ79i5kxccO1y8DL4i96YRyUSnQcLhTNN6p8JPbgRlj65tmLFW3ITEZSTOPw2PzCAmmQeWkrEg3EoMYmVNG+tLlWNiSGCUnSyjtrwzds9uJrVHNBtHl93B7EsNQFy9nn/lMNg+sEEZKypw9vVaQIwsEgVY3ZlEuqmxzkDQ+Yj4KnTo83Iu+Y69q1cVk+JvL5rth6hQAgMOKFc+z/RcgzARejxXhcjJ9rllfDq325cYY/1gQArf462NnuQDUTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhbZ43vVGnvQ0IYCxKWBLDtdACiVcvnqbKjQMbMxLn8=;
 b=K7FFBuft4PPK3mOg9+ZiggRWSYSlLbJSWORjiuMxf2tM+TD79rZZUClSHc/Izms/fQYfUJbC9qyB0F4LMzAcfnF2PR4YJRsSRSa1OVZF0ch/+NpvHpfA+B5378EgAHxl0K4vyFQRJC39vk0BQWauBNJnOFcAvPHXyJLgRrxXZI26NtY7cymfg8rcnIlOYpoUMnOMrmRPYtJQM3fGAVMcamIc/Qqz275xaVGtzvB/Z4kLshXU2q6NyokD29g9kBJvmO0/xxaO8a4qMVHZUT+xhgPj8sWQbaVYWbFwoTb2Kasm5AtH3mQtl+negDgm2xJAEWD94EpdlIMgDBgi0I7bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhbZ43vVGnvQ0IYCxKWBLDtdACiVcvnqbKjQMbMxLn8=;
 b=CbR4xp287cp8tSPPjSm3CLjY40giiPjgEYMiPVanz6fXiLMgO9mJduUqxmVZiXc9mfFq2lIUkM0WOHdoiDNI7XFy2dSc+tj0VH8u/J2Rnqbk0TKS8n4duL6V8MZGzVZA7pI+lnapro2HxnYZAzTlbxPQnzkuA8o06DWTFeQdK6Y=
Received: from SJ0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:a03:3a0::35)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 18:26:02 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::9a) by SJ0PR03CA0270.outlook.office365.com
 (2603:10b6:a03:3a0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:26:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Sun, 27 Sep 2026 18:26:02 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:26:01 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:26:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:26:01 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIQ0eH1629989;
 Sun, 27 Sep 2026 13:26:00 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [DO_NOT_MERGE PATCH v2 14/14] arm64: dts: ti: Add AM62L3 EVM overlay
 for GDEY042T81 e-paper display
Date: Sun, 27 Sep 2026 23:53:29 +0530
Message-ID: <20260927182329.4193961-15-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 841cd43a-7dcc-4a94-dffd-08df1cc4c96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|10067099003|3023799007|22082099003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info: Ejf3/oUfDELw1ssnpd4uO0FssPBns944NhKuzOv41PJ5goHg5mZhWC6Mbq57KMSZ56lZHwNbIqDP/oSgAbLMx8y9JbUiO/oB3vN03/8HAk8D6J8OlnxP6dqaN/k4RPtUyf+KQANmCkpPMfmkePUFOrpOMNN9SRYW+27roqg6hpTK7dl26W1ReF6hhDFVDJa3EnoTg8/K+q7hOwRCZKtTduAp8WbDY/dO3zLzloQlOsW0I2DUT/7A3Gm0ZQgOslAwjLeTbhRV+KsBSsmjL/ayScF01Cgb9p39hf86uiBfSj1oOahaGz4kFvMpNJqys0YLpUH640EDsw7OYrqmrAvo1kldOc0EwHD42+1pDxtgfooCdnAGPgjqdjtafZPCYT9djxqLBn4ICqRgUdXsb8/AfwuAzf4yZHlSyp78tQV6/6BNuBHsdqDvWleb7W6xuslDZLCMBfu2CV0ecfzcvaaJEyi8B++MxhaPhun5wYBk70Qyp3WPFcmmPh6xzGpBMPFaaYh97YqpCfvIB0vrB5wr85P3wzcCmLxbICfKAvP8TPPDYBsakkT2rdYtQ9dny+5PAJb7JLu5oljDuGH2kGcBd6L0z/ETsQr4oRUgTHV9HRsy7nXOh1ORm910H5027CfHcMae28g7CZhxTxbNI9ncHA83sbrNYlMYMoLoH0LISGp4EQ4LuQE2Lo0kYQyaYred
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Im3EdNvcFuZsbWwEMS8nBcVhQq9y0s4nMrNIQ4b00bXkI3djMKaDC/kt/e5/tFLu08nHn5G7euas7ZfwX4WnQbsAP58f4UqZRMVEsoaEfj2zyMaJ9QB3iXKWJ0RNYFbXIJflmR3maRjnHSXpJ52c4tvJJghJuznEJvNGRzYozkeGuxFMZU0vCb9ZQHmWgmbY0rJrKgWj5Agftoy0bH6ECsgoPfQ20XSCwTY158BUPfhaJ4+3bNQJqTGacia9QzseprtjtT+0bDglymbu6OXvSxxy1AmoZ57bmkTzKUALKG1hPsArUrE8TCq5xUWR4co0va63WX6dru9zzVWFonbxTTLl87o+vqitSXyA7BDVWFcI/Dl448y8YFO5vE/PBqtUuUBCJjZo/AUQ2vzjgB894Z9fD9us2r5KxSVfLV+/xZi+Lo8dopk/Ouq67AnWWj4v
X-Exchange-RoutingPolicyChecked: kgFmvqvO1yFE59oMTHFiFVa0/RLZ1EtlIZKqm8oyQO/NtYIwJvf3a0Ha4psRCD7Vnfa0S3ecw1fzCZWS2Qw1bKdQjS6XRSxFqNzHIuNWKS1ofxfH897Ung+AXj9ldc1Vb0hF1/EanDx+hWWfNKWU5/rvOadq1gd3J1U+zbi9Sq5dq8cUAiI9tgXtDv42T+lagaqgE6sYfyexsWvL4xXmUZUazoTbh3V6GiO7SD8rQnaq6DDzc5ML6U3o8O428kl+zsssUIecsmPfTaoq6VF3xKLeAzhEtIqawbgkkhA0zeDM8IRBCTpYdqQ9MRbhwL2F8a7ylxt7E7lBsgYVITO1DA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:26:02.7341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841cd43a-7dcc-4a94-dffd-08df1cc4c96f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-GUID: cjHZg9Dtf_k1KFfTxp_cZyrslmwRdHQv
X-Authority-Analysis: v=2.4 cv=fKysTpae c=1 sm=1 tr=0 ts=6ab95fbd cx=c_pps
 a=rwqFklNBBe0PgClOpsUSJg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=zmbZ_4TfkIE7zwaIlw4A:9
X-Proofpoint-ORIG-GUID: cjHZg9Dtf_k1KFfTxp_cZyrslmwRdHQv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXxu5gk8p19UIs
 TtCQYehj7RDOVBCn2N0zZowQUJcxBRRhChWLby8whZIwUXp3YS7dV+hJ9vFhnY1mlfrJ3uVEl/i
 t8adCx3F4UJExHCjtCB7orPlGJhOpmw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX8lqXjB/fixJc
 fDO4hxiW/T5TsLmObaY2CxXjJ2TC6TjiKM15gITcmkZO0eWqjPk+4rQIEoglevYUB7vQmuAfU4Q
 gO37KZPilUi6fb97ig5U1r7WW10ZxuaNCLNx4UBn3xP4zBCTlBiRV64H2+TpePIJxkcl1lmdE7b
 6FSupGIMcPeoJhtLnhGY4Tc1RWIVrvODirij/Z+YFYCOPrzWeLkMa1+m8FbIi7BwE4HJE3GnvGm
 GHX5JlaNyodN5tcMFCl2oGR8QBKrCJDJe+7gl1hLRNITJD0YSWJjfvHFzO32xDdnk4TEwwpTRko
 xgBM0dZ79N0xQKbrsJ12dYjQa7Wt5UEzbc7fQZ7PNyi3pd/VsoihDn6Uaff2UR208iaO56Sq9PP
 6IpP1N+wKLiQ2q80P+hml+LducqbvuBLx9tfUJfmOixY0xcF08vHjYsgxbykl3WbGuu6NbRt2Rn
 kakNW89Q7/08NVnUD3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
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

Add device tree overlay for the Good Display GDEY042T81 4.2" e-paper
panel connected to the AM62L3 EVM via SPI.

The overlay configures SPI1 with the SSD1683-based GDEY042T81 panel
at 2MHz, with reset, busy, and DC GPIOs connected to MCU GPIO0.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - No changes: Minor improvements to DTS overlay structure

NOTE: This should only be merged post driver is merged

 arch/arm64/boot/dts/ti/Makefile               |  6 ++
 .../ti/k3-am62l3-evm-epaper-gdey042t81.dtso   | 96 +++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 795978e962ee..90e7a687ca86 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -82,6 +82,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62d2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62l3-beaglebadge.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62l3-evm.dtb
 
+# Overlays for AM62Lx EVM
+dtb-$(CONFIG_ARCH_K3) += k3-am62l3-evm-epaper-gdey042t81.dtbo
+
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-var-som-symphony.dtb
@@ -319,6 +322,8 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
+k3-am62l3-evm-epaper-gdey042t81-dtbs := k3-am62l3-evm.dtb \
+	k3-am62l3-evm-epaper-gdey042t81.dtbo
 k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
@@ -458,6 +463,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
 	k3-am62a7-sk-hdmi-audio.dtb \
+	k3-am62l3-evm-epaper-gdey042t81.dtb \
 	k3-am62p5-sk-csi2-imx219.dtb \
 	k3-am62p5-sk-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso b/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
new file mode 100644
index 000000000000..50975a2cdd2a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/*
+ * DT Overlay for GoodDisplay GDEY042T81 4.2" E-Paper Display on AM62L3 EVM
+ *
+ * The GDEY042T81 is a 400x300 black-and-white e-paper panel driven by a
+ * Solomon SSD1683 controller, connected via SPI1 on the AM62L3 EVM
+ * expansion header.
+ *
+ * Pin mapping (AM62L3 EVM expansion header):
+ * P5  --> BUSY  (GPMC0_AD0.GPIO0_31)
+ * P26 --> RST   (GPMC0_AD1.GPIO0_16)
+ * P27 --> CLK   (GPMC0_AD5.SPI1_CLK)
+ * P28 --> DC    (GPMC0_AD2.GPIO0_17)
+ * P29 --> DAT   (GPMC0_AD3.SPI1_D1 / MOSI)
+ * P30 --> CS    (GPMC0_AD4.SPI1_CS0)
+ *
+ * The GPMC0_AD[0:5] pins are multiplexed for SPI1 and GPIO use; GPMC0 is
+ * already disabled by default in the SoC DTSI.
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&pmx0 {
+	dc_pins_default: epaper-dc-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x0080, PIN_OUTPUT, 7) /* (K22) GPMC0_AD2.GPIO0_17 */
+		>;
+	};
+
+	rst_pins_default: epaper-rst-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x007c, PIN_OUTPUT, 7) /* (L23) GPMC0_AD1.GPIO0_16 */
+		>;
+	};
+
+	busy_pins_default: epaper-busy-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x00b8, PIN_INPUT, 7) /* (L21) GPMC0_AD0.GPIO0_31 */
+		>;
+	};
+
+	main_spi1_pins_default: main-spi1-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x008c, PIN_OUTPUT, 4) /* (H22) GPMC0_AD5.SPI1_CLK */
+			AM62LX_IOPAD(0x0088, PIN_OUTPUT, 4) /* (K23) GPMC0_AD4.SPI1_CS0 */
+			AM62LX_IOPAD(0x0084, PIN_OUTPUT, 4) /* (J23) GPMC0_AD3.SPI1_D1  */
+		>;
+	};
+
+	fet_sel_pins_default: epaper-fet-sel-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x01a8, PIN_OUTPUT, 7) /* (E13) SPI0_CLK.GPIO0_89 */
+		>;
+	};
+};
+
+/* Drive GPIO0_89 high to select the SPI1 path on the VOUT0 FET switch */
+&gpio0 {
+	fet-sel-hog {
+		gpio-hog;
+		gpios = <89 0>;
+		output-high;
+		line-name = "GPIO_EXP_CONN_FET_SEL";
+	};
+};
+
+&gpmc0 {
+	status = "disabled";
+};
+
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi1_pins_default>, <&fet_sel_pins_default>;
+	status = "okay";
+
+	gdey042t81: display@0 {
+		compatible = "gooddisplay,gdey042t81", "solomon,ssd1683";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dc_pins_default>,
+			    <&rst_pins_default>,
+			    <&busy_pins_default>;
+		spi-max-frequency = <2000000>;
+		reset-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
+		dc-gpios    = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		busy-gpios  = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.39.1

