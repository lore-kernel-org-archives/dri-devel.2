Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61863C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F52710EDE4;
	Wed,  1 Jul 2026 07:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hCc/TeoJ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GR/M0HrH";
	dkim-atps=neutral
X-Greylist: delayed 584 seconds by postgrey-1.36 at gabe;
 Tue, 30 Jun 2026 10:39:08 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6DF10E4C7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:39:08 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9lGh1504311; Tue, 30 Jun 2026 05:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=xowsfSdIOVigP
 XZFL3OPW7RPp7omKmcx18SmEPhto6U=; b=hCc/TeoJAlY8RA3YfP16c4zYuuKYF
 alEZNlIdJA4g2ID43pWl2iHQNpc7DlIHhvfwlEOlM4A1Q02EdnAxiRUZ4BR9pWL8
 L+alJL5u6M4/kIBSRGq7CxJh3I68tqUWX9XZdBsWOeal5N6O2b0318JCxOrjsNRF
 SkrTHrlhZuw21BoMG9ormqF9i1est0pYlJethvpTcsPrKy131gf0I+GIH//ZVThH
 Q1eETcp1eBwV/Ss104SM8U7EVAds2gDDRdbbaAGL7aKOuG8sGCBNCNriD0iOLmr9
 JcMvHw7xRkXhl1/FQAyIGDyOeaKjeajO4137ISP3wdi/2PJ7dFRSnh+Og==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f47k79k5g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:38:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUZCDAN2PV2bKhDGnL+h74INl7Esbk3hr52zwgSqnY2eOEsXKxfxUw76bEfZeqia8bto/Kt9dw8eWzRIc7DWrTkJR8z/cf4H5dRZP2LhdcugYB1v59Girm5++S5fPK5UN9r9NAGxl6hQOqjjcmaHqPmkMbGJ22Jg6XoVqGLn7NmFUWtNeRAbwJdF096qybSDbwNXCr/zREG90ergLJ7ufrM+sMrY3JZ5GH0hyY803RD3y1H8j3bIGD9zHqWQen03LbZhMTnpOjYmZusN6EGyvOlXTrqPrhzAZi4ADZgyP1Q478abgGIuF4TVNPX7M+DnAPd+wuXHHo3QayBGHG8/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xowsfSdIOVigPXZFL3OPW7RPp7omKmcx18SmEPhto6U=;
 b=N1I4bb/TrFxgWGwq1wZ55l7uXCae8oSL3HlkEKx3R2GLtb8OOCTioHFxVvBTAwTtmv7IAgZ4Qd0QZB93y9CMmbF7nWery+xWZweiDu2rmpbS8OiTA93WWnyhPwP/XT8v3Bcw72fWiZ4jhfeKnE8d5du35L6QapgZQHZGiJLs1UQw9/UnZ000GT3DLL80cnmq7TZ/S/QuqFe1b2DBRKnnk7Mg8XPF/ds2sNx1q2xgTNAORaeKSbF5fMpb4UN+NY9X+J0AfJz5A0KVahmY2VNojtzEG9DxPW2nJ3WAdjJLXJ0jX1RNNAJNQZsNQjwKVsUfRIqGMwP/pZKCPUAV3oyktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xowsfSdIOVigPXZFL3OPW7RPp7omKmcx18SmEPhto6U=;
 b=GR/M0HrHC4ScEgrE4CkUr9/28sZeoshOY2wZEjotYOB3o90ls8gIJtw3U/HsGDmvtnbNBwr2peKKPufuGbcN4GwYUAHGSEBymz5bOnMAGJ4AkeQfmuRWrXiJuPtguHO5N6QxNRfigukOGgbrYROgQRs5esFJeY8gHidcYYEuKQs=
Received: from DS7P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::15) by
 DS7PR10MB7130.namprd10.prod.outlook.com (2603:10b6:8:e2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 10:38:45 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:25c:cafe::6e) by DS7P221CA0023.outlook.office365.com
 (2603:10b6:8:25c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 10:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 10:38:44 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:38:43 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 30 Jun
 2026 05:38:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 30 Jun 2026 05:38:43 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65UAcccn2867109;
 Tue, 30 Jun 2026 05:38:39 -0500
From: Yashas D <y-d@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <y-d@ti.com>, <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>
Subject: [PATCH] drm/tidss: Fix synclost issue while disabling layer due to
 erratum i2097
Date: Tue, 30 Jun 2026 16:08:02 +0530
Message-ID: <20260630103802.1853564-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS7PR10MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cfaa57-ae28-4333-e325-08ded693c292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|13003099007|921020|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ugRfmtUaqV0PpcTtxxu9Pk0x4eSslCnSFbGJ5CKB3TDR5S6Jf72tjA5eF/YjQsMGkVMRYLswleNc1VY2lxpvWrwZMUI8ZFNvBbjIN0A9TZ3IiXt6eMufpJgaird+K4un2Qy+cuN84cvtyPBKcx+uIoaehycftEaCmsKToPCrIw+UOdqMbUhZ81OslfMboK5hTHTlsbQYDov1JRyStFR/t2F12Uow//q9bjqRnEMxvl85T08qegNRPgxETeadTkPMJjhYahe0lGAR7mGFnrR1ixzOgTCAXJ53irW3LmDCF9KA5IwVGGgZ+Mb8l29ghaZ1qPSvRkLi6aoEJu/gdrNiacy1dXY8Ck+VZ8FVyIqiuIQCxKoa6q8sXEbkP9oCXTj8aP/EPXec602ZMpuC8hDoExMi0RNrvukZyyuHB1eYt/zcPYnvPRWF39HsiIpy8pRQ2o8vTx1SkPBn5H5k2A9y38IgxPMdIivqB4vmSfaLSb+xS3UVayLENL6lem/gNE9MH5P7GVEFKApgVFS3F7ExkrOEK/Ic+9h5QYfz8tHTHjnK63IeJbon5dXKbKkTqpycnOPWOF3gIkvCNRgBUtmGZ+wc1XAKM44RIRYCbDc9jnq+Qvclo/R516GA4egTMCxIOt9iA7fqdMkQFGEbL6Of5PxL244B9q/bOj0bll1czfk3ponXgCKKPrZcJYyUdHm3GLQK2df6JgEz/HmGvmZ0I+XRwkNbHeMFsB/2BjTH8y4M2CAt8OR1813reGqflIrF
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(921020)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UuHcya3tZdwsCW9Sh8w6/6P0EJsKO0XFrJiuBAy0rsGQtKFCk+H9UUR/WIlNFTj/qfAnjHoZElhTJdcPiwS6H2UthIaI02oYfVw8ukL2RWkoPLx45HbhH26TIdx7it/UY7akq4NFXrJRIS10RqCNuI9HwVrqaT2pNF2Mg4XbhItZSmrGK1T802VPSMiXwrpFlZDvKskpi8xboa8IKq+akR2eEeVOB/eR2en6MIyGo85VtyHB4Xfqovlxb6Um6NWOlqBDrJVGwRfcW77hVyvpbd/Hk1zljaI3CwArE2gRPUOFmRCmaC14yPoAT9u0c3Qa2JdCjBuq2ZB6iM0W+G+0INYYgcCj8/SXb7yT66w9hjpgCMbt3aNddokJ7KQQjpuS3TqHpKuzoAuOJlYR/scK2t4h0HAO9Hu7pJIlJ6MjbAFDpaHXww0pUUfVsd4ky33S
X-Exchange-RoutingPolicyChecked: oI/KRXPXng9Qhn+TMVI5cXxMCieX+FgakjbOOQ7dELqoNvjQDivJTiCiEqdPaL3TKeZ8iBkhkVqXnoaGTp6rln4o+CYIIAVIvl/+Lp5S3t32q7HfVsaD4tY+2+nlC71niZK9PIrTZjq9q+WAd8/m1+XTClahQB210xLKNcQBYa6DDopG/iBxRfY+wUXaQFmJcEJ3P3yatvgb6fqjxkr7ZlKdWw5UM8jsOWLMccK8lnYa8px2UNpFZEHTp3R8y7fy0e0u5aRFuPsKfgPmdA6dheUspIci/K1uHdu4M9DvRT/8qrHsu7KPR6CjbsGRksvf9kXX30yMPJNu+iX1GlpYmw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:38:44.5205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cfaa57-ae28-4333-e325-08ded693c292
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7130
X-Proofpoint-GUID: fKURiyANi2n1nxWx5xXYqKH2w8Z1kc7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NiBTYWx0ZWRfX+IQyW9tUrHRm
 54vxRZFTyjS7T5PLrrrkxbCKAqbMBer1TvPW9BUNdJ6G0Ocfds7zRypWZ32l1mn936ewKJC0BI8
 6Rpb0yG38XRerBZo5NHSob6MlEM2t3gOvmqPt8uD7SH3Hfw7VO74ofPQUV3+FvdXbb4U4GIrrv+
 SJMYr33B2F7whtWCH+FolFfHRHDFXmacr4BXQ4G1S6D/iDAPieg1J2ChHxfiZWR3hlG+l0tkPsB
 /sXyeScr3DwJKM/TxnuPxq9GbaoquqqPLngtTlnqHRojzhD7HHY3WkbswwWh72tLC0Korp5cyQ5
 bZ/9v42ddPH79gFJfk3rAxFxtSQgMtztsrfkliaI5YHC+86vJjwabrGh3pnLR43Hq/ws8Ymcflt
 SxkyMs28Fz23qVAa3U7fdROM8s16oHMT8GFNuD/9MvpRm9iq2DZWratvXbidmImMat70BwmSW+E
 OjstEP867wQriGzC0SQ==
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a439cbe cx=c_pps
 a=cj6+QZNyov9unU3rCXIAQA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=m22jFpp0KcHbOLsz02AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NiBTYWx0ZWRfX4seglloJK/cv
 vbYfiSDpZl4oy1UIZhIYgxD7VqSv565oq6bbMbJ53RM4vaWTtMlcPw1iscTsL4+NrEpBPTBXCiP
 GLP64TB+neCw2U3JIN+7bnU5XHmbwSA=
X-Proofpoint-ORIG-GUID: fKURiyANi2n1nxWx5xXYqKH2w8Z1kc7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300096
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

Link: https://www.ti.com/lit/pdf/sprz530

Signed-off-by: Yashas D <y-d@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 108 ++++++++++++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
 2 files changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 58d5eb033bdb..6cbf9dfc38b8 100644
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
+	// WA for erratum i2097: OVR Layer Disable May Cause Sync Lost.
+	u32 pending_disable_layers[TIDSS_MAX_PORTS];
 };
 
 static void dispc_write(struct dispc_device *dispc, u16 reg, u32 val)
@@ -1128,6 +1135,12 @@ static void dispc_enable_am65x_oldi(struct dispc_device *dispc, u32 hw_videoport
 void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 		      const struct drm_crtc_state *state)
 {
+	/*
+	 * WA for erratum i2097: clear any stale layer disable tracking
+	 * state left over from the previous VP enable/disable cycle.
+	 */
+	dispc->pending_disable_layers[hw_videoport] = 0;
+
 	const struct tidss_crtc_state *tstate = to_tidss_crtc_state(state);
 	const struct dispc_bus_format *fmt;
 	const struct drm_display_mode *mode = &state->adjusted_mode;
@@ -1233,6 +1246,38 @@ void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
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
@@ -1503,6 +1548,63 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
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
+		case DISPC_AM62L:
+			OVR_REG_FLD_MOD(dispc, 0,
+					DISPC_OVR_ATTRIBUTES(0),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
+					DISPC_OVR_ATTRIBUTES_POSX_MASK);
+			OVR_REG_FLD_MOD(dispc, 0,
+					DISPC_OVR_ATTRIBUTES(0),
+					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
+					DISPC_OVR_ATTRIBUTES_POSY_MASK);
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
@@ -2871,6 +2973,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
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

