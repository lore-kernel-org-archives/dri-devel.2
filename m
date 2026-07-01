Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85732C44500
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B1410EDF6;
	Wed,  1 Jul 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aK7HgXG5";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pv/rRiXL";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636E210E301
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:34:57 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6612uUZN2535139; Wed, 1 Jul 2026 01:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=0k9XXageYAKkC
 Fp/GGNQxaxVtPM66RYq+ONltup2mUw=; b=aK7HgXG5L4xfP2cMC8m6bprkguzOj
 lWhyfsKVtMU6UblZVDG8cco91Za7J0lhC0a4j1jbq0PFFBcupWCBQ17BBsmLwRx6
 Ktq4EX9WgaPViM86KtxzHwpiTSATIioRWPUDnunLrqGET8+WV9/x79wZMob7ooX/
 vx8WT4jZ+6/At5X9oQrjUxtD4SaI84VZmWn7eojJOS9jMO+qWJkbGu+EulVwrgye
 yj+LHpfXa8NLd+SY40BRhnWC9C4+XKiXKC0/xxKtBe2lo5T70tS71J6FM1Gl7U2S
 yjCdqRLuqx4H8zQkcTnRUcwd+e05Sjb8lSQJSjAWpC0qj3HTXg2hYzE5A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f4cpvwuvh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 01:34:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBG/i28Xy8LeYoXb02i8ZYzLmJSKiCLSeMQGVwAqgxJ5LM8QWyqxtHTCMDcx9Xgcu3HAsdEFGqtL/a2C+Ofan6qjew7RG7BKL49CQnOJdRA2EoY7zHr3J6raz1eOV7YmV6LddKgOCsq04uwSVixcowPN9qA/4fzglDzTqw6dh4nHhWJFFJ1rtdugriBMu6/JmWqhBV+8YjBrVzdMT/GcMs1D6rkP10Kb7ahmfAJ7xrFdQdPhAV7N1sBH1AAgRnoOU9s5X/3keMOpAo0ERsgWSsAApO0GZU2RE708Ng88LMJWyJFialGPzIsTSy/nOCYrIeRIljEfBM2tCF/he1sBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k9XXageYAKkCFp/GGNQxaxVtPM66RYq+ONltup2mUw=;
 b=cQhqJxkk3mCl+v5DVz3tfD4g7uqjF2DqOfEnyKXN/pRrwvlDRBbRJ8ddg6FRfXRauw4zVpWJ8IZ/deUGRfbqbgbFUg9emW2Ys9z16Jq3DyUM59k9F+K2C1Jx8KVnGLQHCrlLlJl91tAyUdH35kFTCdZs02H5f9s37fO1CLyMWp8pSj5Q3AIjC17IluNs0//VtRuOihnCdYAKTihiu52JY45w1wFhNa20SMUPXIWTjATbhb5vi7pTL1VOPf2brOx1wH/XdvFbH8PLOQ1VcEBY2B254XmT2+F7eYrKds6021As4+UrKpIVlUBBiiE0dqar4cvWUSG8B1XQWkGQ7Y0oTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k9XXageYAKkCFp/GGNQxaxVtPM66RYq+ONltup2mUw=;
 b=Pv/rRiXLKmmhSdyoewTcs7xnonkNHrVTSorBwxMbL9SnteivUK0fWo44G6Kbj4fVg5rpvmSKEOvyQZtYbhTykVJtR/6wX8o+s37EXzYTe0E1/9xPBa+RM0ewS7gIMkMNNBc8a1CtxFM17ISuf67QZZx+CZBCv1PSMpUIaUjF4KU=
Received: from CH2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:610:50::17)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:34:35 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::6f) by CH2PR16CA0007.outlook.office365.com
 (2603:10b6:610:50::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 06:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 06:34:34 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:34:33 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 1 Jul
 2026 01:34:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 1 Jul 2026 01:34:33 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6616YTpq730479;
 Wed, 1 Jul 2026 01:34:29 -0500
From: Yashas D <y-d@ti.com>
To: <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>, <d-mittal@ti.com>, 
 <b-padhi@ti.com>, <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/tidss: Fix synclost issue while disabling layer due to
 erratum i2097
Date: Wed, 1 Jul 2026 12:03:37 +0530
Message-ID: <20260701063337.2165966-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS7PR10MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8684f982-c9d0-4a03-9fe2-08ded73ad0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|18002099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info: zUpvEH/l0VL739wXSHTMUb8IuPAK93z9qD7d3SyMsEFU9yttOjaFs4O5M5OONkFAwsYXwsgN3y7J+B4SH/FA7X8H9vDfzr5vhgDUZDwA0aPJnUvUttEKpd9oAXKNc1WMbmjPR4P887Ckp6ytNWQ0UrjCZt1hG7n/WNXkWSrgliJJeN/RycUsvNWWEa7nsQafvAWJMuI/y6o8tvwW48oD/NuvMyPB/LDSTLCgTAZw1FivOW7Hjz5//9clcymJVGverprJgeJfj/RLzlYLxxj+zr0wzZQ/jzLOEud7zDnjaycDBN+Fu9ifwwsYDdadAMbZnedlFjFtL0ndBqkcyEIU3titqBJyB7+KcQ9otDRaItPjMbqPwMiEz4B8ASpTvwWVshdKyGTyH1teDfa0JUAvZv/zWBsZ/09rTB8s5B9C1ENwNn5VOy8MvncnWXZYqUnUIuxXdTQGqFVSB6sJ/lEsvqS1Zh0OyzDtqBqjCl6PL1vOv7bfGKwnWBDbRA+b8ftaKVCANq2k22YrDK56qjLidurwDCr8EgLVdwyCB+rg42bxT1d2wzp8Aak7OPmUmxg4Bgo0l004pibwmmg9i6qyFzSOMv9XjmEdntGYSaBFofFYF3q+Qq12L1ZuEa9+l8saSv1xvgqeMFbSTtvR/t5M7XdCZ4e3riBTiCPfUef4IHrqvb0Q+r8uvzxVg/Dq0mISWJs11E0Yipxzkj48LPzgxA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(13003099007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XZw3Foi90xKdcdTE0B2l6MWhIjz6KIS1xB1+MIQlmJoCysoEfvYxssakFrXHeJDc6XQCCjjDvWNFvWyroQS+jW40bgJBD5BQbBW+VfPnx8iIx5Bu94WP3h2g1rWGOf7KP22Y5w9vRSgmi3kEmWh7u1rfKvmNsEr8tY02ULt4qepqXgcB36zHdPwC36UaOtosxN5z+nJIfUwrUNwLydXO0kOCHaF0gsFEwpDzFY+HxvFzsdY7TaXKjJL4TkYGJu9LTnsDWEEQb+F9xD1vVwnPeYnAg5aAY3CvbLiTYC3rdwPWCAtxxoN+vZ+9PW4+lL4dKbFjK0HF/PaunJsieZx/I8SYEihnnMP95LLWYfF3Zskbae9mnp4bUBuWPRhqLOJlYyAjMaQpUOpsFhMMoNTzdlUCAGPn+uaa4ca5Kz2Lr1KGf7WVf+wJx+U+C8dBYGGq
X-Exchange-RoutingPolicyChecked: e2nnYD67lwDsDoO3jhwSa0/ZLR+H+KfHcgIhJfSXtBwERO9WM5bA3AOcHLGcLbvpnjb8Cl7tV0ur6fbJ5FOCHqynlwwxt0qdd7hsu0Cp+Kkg/+v/OLGOo1NP+cTL8DdPL1aV7HTq3KeO8yLH6Zfp5LkyoBvoXIfHhZvys6A+fgIt95j7AtWi7keekvl5+aEprgFtq0IuvoPkQuPMeOSYGln4RtusI4KiYbvo3a0EvT2vwZKj4Jz2hvPrTDmlt9fxustDE2j40eIcPDfmdLX2/XdqTHevmmyobU8l+yiP64l0ySeru3vnI8lLZxx/mXiz9LVraTerpnJM0Ujzpzt19w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:34:34.2173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8684f982-c9d0-4a03-9fe2-08ded73ad0ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Authority-Analysis: v=2.4 cv=c6abhx9l c=1 sm=1 tr=0 ts=6a44b500 cx=c_pps
 a=OAmo50eV21M7Ophgg7+Z+Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=0nn6oRAVf0Vw3THuGEMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfX8vV7UalGUlup
 +ltzpm4eW9GZpkSz6A3JW/L17ZlIg+E44+OVW+7MQ58pUuOr/TFKE45e9ISs9GL9IuS11azY4mq
 8AIEsRy6chfwOJ0hi9TabetaPLU4SKU=
X-Proofpoint-GUID: FArJp467aVArNCB9TcxYvC7m6FWzIZHY
X-Proofpoint-ORIG-GUID: FArJp467aVArNCB9TcxYvC7m6FWzIZHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NCBTYWx0ZWRfXy9YCAWNgyM90
 RiJ7XertUu/yNggFl3o/eGodM8fNpS54h4MFBDKxPh0/HnKqOJQqr98QrycaU12LXXCfe1qjKfR
 STQio+TpIUXEbO7IdBt5/zsRqy+8w4z1Q3hwbiShj3mzfWLp3NZ2pr/u6D90JCgIVCCR7Gc2fr9
 ZInsy9VNGn0v/pd10tFyrEwDIoilqP5yACRKR8y12yw0OH31Y5rDfeba1/F8cMSf7QPhmfyT/FC
 MVemjNGpsMUxs5DDPjKxCN8NX3N4nCKLMXcTjCWdQYGPWubw2rasCcme6ZtE1ShtDQEfX2pXSWO
 1R6D39heMCWAxajy/esS4chA7E0K8cQ6R8PKWu42jfV8WSL6Mxy4iSj5cRYgdOYThEAEklt9osx
 9Gh26oJKw2/7h+bnLCe3LLVoK2hAeh9ktl5APv4J9vB8+AjYxzMw2kVoN3Yat2IsDh9JVk0KL2B
 hhHhzNABgJTdUXgiA0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010064
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

A gap beyond a frame duration for disabling the layer in overlay manager
and go bit setting on the corresponding video port may lead to SYNC_LOST.
Fix by moving the layer to the non-visible area and deferring the ENABLE=0
write, immediately before the GO bit, guaranteeing both occur within the
same frame window.

Link: https://www.ti.com/lit/pdf/sprz530 # i2097

Signed-off-by: Yashas D <y-d@ti.com>
---

changelog v1->v2: 
- Flushed the pending layers in dispc_vp_disable to prevent hanging layers in hardware 
  when dispc_vp_go is not called in CRTC teardown and modeset paths.
- Removed the AM62L switch case as its the same as the default case.

Link to v1: https://lore.kernel.org/all/20260630103802.1853564-1-y-d@ti.com/

 drivers/gpu/drm/tidss/tidss_dispc.c | 118 +++++++++++++++++++++++++++-
 drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 58d5eb033bdb..02a3cf50e0ce 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -38,6 +38,8 @@
 #include "tidss_dispc_regs.h"
 #include "tidss_scale_coefs.h"
 
+#define OVR_LAYER_MAX_POS(mask)		FIELD_MAX(mask)
+
 static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
 	[DSS_REVISION_OFF] =                    0x00,
 	[DSS_SYSCONFIG_OFF] =                   0x04,
@@ -467,6 +469,8 @@ struct dispc_device {
 
 	struct clk *fclk;
 
+	unsigned long fclk_rate;
+
 	bool is_enabled;
 
 	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
@@ -477,6 +481,9 @@ struct dispc_device {
 	u32 memory_bandwidth_limit;
 
 	struct dispc_errata errata;
+
+	/* WA for erratum i2097: OVR Layer Disable May Cause Sync Lost. */
+	u32 pending_disable_layers[TIDSS_MAX_PORTS];
 };
 
 static void dispc_write(struct dispc_device *dispc, u16 reg, u32 val)
@@ -1134,6 +1141,12 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 	bool align, onoff, rf, ieo, ipc, ihs, ivs;
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 
+	/*
+	 * WA for erratum i2097: clear any stale layer disable tracking
+	 * state left over from the previous VP enable/disable cycle.
+	 */
+	dispc->pending_disable_layers[hw_videoport] = 0;
+
 	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
 				    tstate->bus_flags);
 
@@ -1210,6 +1223,23 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
 
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 {
+	u32 layer;
+
+	/*
+	 * WA for erratum i2097: flush any pending layer disables directly.
+	 * dispc_vp_go() is not called in the CRTC teardown and modeset paths
+	 * so pending_disable_layers would otherwise never be consumed, leaving
+	 * layers enabled in hardware. Sync lost does not matter here since the
+	 * VP is being disabled.
+	 */
+	for (layer = 0; layer < dispc->feat->num_vids; layer++) {
+		if (dispc->pending_disable_layers[hw_videoport] & BIT(layer))
+			OVR_REG_FLD_MOD(dispc, hw_videoport,
+					DISPC_OVR_ATTRIBUTES(layer),
+					0, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
+	}
+	dispc->pending_disable_layers[hw_videoport] = 0;
+
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
 		       DISPC_VP_CONTROL_ENABLE_MASK);
 }
@@ -1233,6 +1263,38 @@ void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
 {
 	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
 			   DISPC_VP_CONTROL_GOBIT_MASK));
+
+	if (dispc->errata.i2097 &&
+	    dispc->pending_disable_layers[hw_videoport]) {
+		u32 layer;
+		u32 delay_ns;
+
+		/* WA for erratum i2097: set GO bit #1 to latch position
+		 * changes into the DSS pipeline, wait 10 DSS functional clock
+		 * cycles, then write ENABLE=0.
+		 */
+		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
+			       DISPC_VP_CONTROL_GOBIT_MASK);
+
+		if (dispc->fclk_rate)
+			delay_ns = DIV_ROUND_UP_ULL((u64)10 * NSEC_PER_SEC,
+						    dispc->fclk_rate);
+		else
+			delay_ns = 500;
+
+		ndelay(delay_ns);
+
+		for (layer = 0; layer < dispc->feat->num_vids; layer++) {
+			if (dispc->pending_disable_layers[hw_videoport] &
+			    BIT(layer))
+				OVR_REG_FLD_MOD(dispc, hw_videoport,
+						DISPC_OVR_ATTRIBUTES(layer),
+						0,
+						DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
+		}
+		dispc->pending_disable_layers[hw_videoport] = 0;
+	}
+
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
 		       DISPC_VP_CONTROL_GOBIT_MASK);
 }
@@ -1503,6 +1565,53 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
 	if (dispc->feat->subrev == DISPC_K2G)
 		return;
 
+	if (dispc->errata.i2097 && !enable) {
+		/*
+		 * WA for erratum i2097:
+		 *
+		 * Do not write ENABLE=0 directly. Instead move the layer to
+		 * the non-visible area so it contributes no pixels.
+		 *
+		 * Position register layout differs per SoC:
+		 *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
+		 *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
+		 */
+		switch (dispc->feat->subrev) {
+		case DISPC_J721E:
+			OVR_REG_FLD_MOD(dispc, hw_videoport,
+					DISPC_OVR_ATTRIBUTES2(layer),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
+					DISPC_OVR_ATTRIBUTES2_POSX_MASK);
+			OVR_REG_FLD_MOD(dispc, hw_videoport,
+					DISPC_OVR_ATTRIBUTES2(layer),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
+					DISPC_OVR_ATTRIBUTES2_POSY_MASK);
+			break;
+		default:
+			OVR_REG_FLD_MOD(dispc, hw_videoport,
+					DISPC_OVR_ATTRIBUTES(layer),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
+					DISPC_OVR_ATTRIBUTES_POSX_MASK);
+			OVR_REG_FLD_MOD(dispc, hw_videoport,
+					DISPC_OVR_ATTRIBUTES(layer),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
+					DISPC_OVR_ATTRIBUTES_POSY_MASK);
+			break;
+		}
+
+		dispc->pending_disable_layers[hw_videoport] |= BIT(layer);
+		return;
+	}
+
+	if (dispc->errata.i2097 && enable) {
+		/*
+		 * Layer being re-enabled: cancel any pending disable so
+		 * dispc_vp_go() does not write ENABLE=0 after we have
+		 * just written ENABLE=1 here.
+		 */
+		dispc->pending_disable_layers[hw_videoport] &= ~BIT(layer);
+	}
+
 	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
 			!!enable, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
 }
@@ -2871,6 +2980,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
 		dispc->errata.i2000 = true;
 		dev_info(dispc->dev, "WA for erratum i2000: YUV formats disabled\n");
 	}
+
+	if (dispc->feat->subrev != DISPC_K2G) {
+		dispc->errata.i2097 = true;
+		dev_info(dispc->dev,
+			 "WA for erratum i2097: OVR layer disable uses non-visible area\n");
+	}
 }
 
 /*
@@ -3059,7 +3174,8 @@ int dispc_init(struct tidss_device *tidss)
 			__func__, PTR_ERR(dispc->fclk));
 		return PTR_ERR(dispc->fclk);
 	}
-	dev_dbg(dev, "DSS fclk %lu Hz\n", clk_get_rate(dispc->fclk));
+	dispc->fclk_rate = clk_get_rate(dispc->fclk);
+	dev_dbg(dev, "DSS fclk %lu Hz\n", dispc->fclk_rate);
 
 	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
 			     &dispc->memory_bandwidth_limit);
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 739d211d0018..e2ce9fdf1279 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -57,6 +57,7 @@ struct dispc_vid_info {
 
 struct dispc_errata {
 	bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
+	bool i2097; /* OVR Layer Disable May Cause Sync Lost */
 };
 
 enum dispc_vp_bus_type {
-- 
2.34.1

