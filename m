Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066F6C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60DF010E3B6;
	Sun, 27 Sep 2026 18:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wf9udtI/";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SmEFy1JH";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24ED10E3B6
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:26:33 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R9XsmL3194826; Sun, 27 Sep 2026 13:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=X1mM9gs1nIz5Fzf2Ww7Bvu0QUO803oFcMhrvtc5E1
 +c=; b=Wf9udtI/OZQqQAhenRbz4TjUvG2LCHJBC4K1GXEQjqT6TT8XRTjvDdV3Q
 VFDTqgnURQe/wUF4LkpfHq/FWkN9hNrd+N943PuvK/NYHA0hz13GHfPMnr9ecdqh
 6ZQ8PVoBV1FulnMXGeICLIBhNwpRgnLysdJTPWP6NP97gaMx2KBhHnVCjNyqS/jy
 DVxpODVe89gO3Iny4kXl9puspgA/GsTGpyt4bSdEoZq/QOPkDxwp/6pEhW+gdkoF
 +C9sLJTMvMpqAliEP1fGWLBk8/NhNzFzcosrhaleoQ9HRfEG0KQlPd+K9UYhZKMi
 qD8TT1ZHOkUZ5R6AfDfb6AACj8Z9A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxwe5hxj8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:26:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0xdRrYm7ckB9gPgdQDwSFfCsTMMA5YNsSGEVx3TfEB/psBj9fSzCw8n0+m5SJvVhgshRffH7Jt/NBu95oBrIlxE+SrG4sHLP8PGKcb80nHN66quIV9btP7aXpdMff/ajc3qHupbw35ZU8lHH2Mq4oCRyakMLlPMk/QdHXJPneLRozKn0VsQsMF73foL2krvWQomXhsUMMJFeVCuKx90Ae5ikNOp/6jLWmNHULiCCSDRB/RxvJhtNki8bugVleAIiDCzpxSA8E1n4r21guiHCqs+j54U769FSzbH3bzTXDTDe6gLDDVtmlHVzWTiL0WKtnr+LNyZ3SlAtS4+YPYsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1mM9gs1nIz5Fzf2Ww7Bvu0QUO803oFcMhrvtc5E1+c=;
 b=nbqELOTla0cr9MxrUCDiI/Cmk+kL65SRxmtU4N3K0BTtvFUmbWLnENuhbXl+c7jzqSByzqyB4dJlQ3TGARAxPAe7of3ulmSRxF+08KT4pfjIWxOmizmQPKNpoW7Yfr30r5+sO53YZPBWwSw4K9ahcbnhJ6TcEH6/jVvCg8SgAd6+Sv+pVsa2hbPK43iVv+eHQq0kJKARaWtXNIT0MEM7ppAp5hQROqI3uo1nMBNzUq/oXpgygTYQL2VpEkL70Yjixjc57MTbpCwJsgPvN07L38hCQ21wMBd1uxR+XMLj56f+PWNiTMut6+axrilEIuQRhJffvJ2slCStSiqU7y83hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1mM9gs1nIz5Fzf2Ww7Bvu0QUO803oFcMhrvtc5E1+c=;
 b=SmEFy1JHh0Hx3eG9cK23WqzKVV0Zvgyc/hIU/QW9qhVDo01J6+HH49neSwlAK2nH4yucKtoAyQ07qWqoOfG6ffSOzcufesBGXlqCjhGetrvC273aSEQVfDWRx1jz9jcj2hVwbSIZGGhLHE52GHOwxJkoVTgKW99WKWzjuLMqPrU=
Received: from IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::6)
 by SJ5PPFC41A007A8.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Sun, 27 Sep
 2026 18:26:12 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::9b) by IA1P220CA0009.outlook.office365.com
 (2603:10b6:208:461::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:26:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:26:10 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:39 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:39 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPcKo2547890;
 Sun, 27 Sep 2026 13:25:38 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 10/14] drm/solomon: ssd16xx: Expose session management as
 plane properties
Date: Sun, 27 Sep 2026 23:53:25 +0530
Message-ID: <20260927182329.4193961-11-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ5PPFC41A007A8:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61ffc9-0957-479a-d4d1-08df1cc4ce21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|921020|56012099006|10067099003|6133799003|3023799007|18002099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info: S4DPm0oGSOQEYfmeZEPUZL/ZvtUSBLmqFgEi/8UWx7xleDsKimAx9iRTRgRKmmPEKsPazJaauoZZwRaA+t8w3WHReQQvD1XllCbeZsJFxujfRK2I+KzNncV0kEq18X2rYnN5xD6NH8MOetsVxrlOi+XaH3yrsWStnJRRq2ir9LvRd5hE2OGDy7OqSoGm3+UwOuGIrDZFWu2ML4aVMdWzDi8MHcHMl2oeHQWErH83C43aMOuehuJgohfxm2u1QMb7N0uvKKKXinsI/ctIY8po/voU8yRSJ0QikgsIkW6dUTP39oREkvSLCvyJHLn1IDDdRi94xtrx+GtL8/7kNZ+1QRzah5bC/HRlppwk5pAS921OqnAFXC4Xyi7/6Nz9+2C1JqonL9zde1qE1wNTkC0q5pzOn2tx62TgJRmCyq/ccPFpxjy3Id1BaKiogt49rkm1QMEBoHvKuozKrRNz136jxQrQiGXv0AYyEGiUJLwAcMGmi60SCmwcQZH/aCNFj4VH+naPhuNNi+jwKwyuVBKYKGPFekn2nmXCCK085YqiabGQuQj/6JYJs+oyUQNqSDdZQMSpFWY9S4eWeyHdj3HmaFff2ihfcdp/gxbw+sajxGoUPitrUc3FvvpGeOXg0NK5Tq3HDDY9xwcYnTjfwkyow4f+ww931L6akMg539hAXJ4xQUS9TNfuaFNKnh3RaAhhZsEjN/dSCLfJDWeAeDeOOJye0n7mD2jHork3bYx/evhGswNMC6MXP2ioxWRuiRhP
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(921020)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(18092099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cUYYEo1e63rVjsfkQbJtknD2dHQra+CN7SnZzw371a6gxACS3yfLUooexwpU5sTRZS2oY+IsbS4G9rAN+Am53zDipzKrH5mX/FtkhL7t0z/Fk5fUug8dLgxxrkMmupYxEkawRItrfRoLHLvuGA2jIqpw/qVqiFSgNUfHUWrpZb3kKm6+Ntay4rNeuOdA3SYXP6+R+dUbg14czQ7B9uknqOISFQb49WlquEvJ4mbK3dpFBI59De7ZnTRiqRm2NF+5AYy/7o5ght4Se6HoDtqDYwYB+04idmLAN8RY1jWQ+YdVG8YxQvWchtUZoIPklwWkGNlKCn8COFHGjwSK5XenC4VPRdZcUNBI7dwazd9Mv5ctik5auumk1cdB+W8P2X5lqxRf8SLYQ3KAF/AMYjruzqGiaVk/6wcQvQ8qI722QsMgdHpJ6FliUxIw7fiOjuGV
X-Exchange-RoutingPolicyChecked: 1C0aonEsLF4JOSeoOvxTJhkPF2sD4W1H5c8QFSIy5VCvBc5bmjWBAly0A93ZsIfrAm6oiRocypee8KXuQOa9/Dj1VZnKBn8RQMy04gbw1u1X++UsN3ESJdeB1AjcfkpA+UiXX6vZGiChMT/Y/0YF6zQJxq64+TNkgoLLuBNyPkKMxlaJ0hihCyYQIDxLOEDuo/LagRPOLV+assiItDpGL3705dSl3Ux7FteHWaREJ/ldjRGnSyyJp24lN1Ener/Fsu80Oyp1oeK2ZQzNvfaGBPLQwW85MPgC4mbbuBB3a+kJU6bvps99Z7v69c6wBr2Hx8AE2wcB5rm/3mW8edeeWg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:26:10.6234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61ffc9-0957-479a-d4d1-08df1cc4ce21
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41A007A8
X-Authority-Analysis: v=2.4 cv=aeP0Dhot c=1 sm=1 tr=0 ts=6ab95fd4 cx=c_pps
 a=S2IqtmjrQAXuShkhhqPLog==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=T0vVnQU9xsppt9j-3NwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXxZ5fcNz48xA/
 qdRmv9lu+QAqozizUHTFewjIkChTAM0u8wLcOU2BCoaCV7fYelk561yDQxgeqSbezgkToQqL41d
 A/CtnJv/ZtVwOXANlXRNMptq9xWuG5At7MOn/s9LSU0yWgX7KTgu+EgRkdP8u9u5M9ogIncZsqF
 VuyEL+ZuwMZ3wlw6IPXVXMmbNUo3ohkBeegEJRm6HQM0ZSRHb5N51DUYW9p8t7uY0sG/WYd782m
 +I35uRmfj+bZgcHrz3yOxYcLrSdqxMmucfYn8u2Iy121jIJcngSw68rx1ST4TcRSRj6nW4kGcZ3
 Tm9/c0c9mIusTqIZrIDLl8aO+C5UlP12FL+S3E0IAmwbQJz2oHJ5Kyv5XUKiZsaFNY7RScbDvOR
 MbFamsckiUt22gaLEMucRh3gC+R4mlAdiXtnsvohvCbJc2VQR5/PslyosvLNb6cqGfsveXoh50b
 38ZYCG+vepV1etCsZ6w==
X-Proofpoint-ORIG-GUID: h7LOWsiGTZGtq0okjvO2dS8V6kiVyn27
X-Proofpoint-GUID: h7LOWsiGTZGtq0okjvO2dS8V6kiVyn27
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXzZuNPKWqjb+K
 fr0v2NxS/kM+/cU+piJ18nmHPQRSZUWDwqVLCIHBUfeUDcbe4o1gqgIeIndeMS8n3tDEwNWm5/U
 bt9aB/asCxyrwIoQB/zYHkGub3R4gno=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

Add DRM plane properties for the clear_on_* and refresh_mode_init
session management flags, allowing userspace to control automatic
display clear/refresh behaviour at lifecycle transitions:

  - clear_on_init: clear display when a new DRM master opens
  - clear_on_close: clear display when the displaying client exits
  - clear_on_disable: clear display when CRTC is disabled
  - refresh_mode_init: override refresh mode for the first frame
    after a new master opens (e.g. force full refresh to clear
    ghosting before normal partial updates)

Each property is an enum with values:
  disabled / partial / full / fast

These map to the internal representation (-1 for disabled, 0/1/2 for
partial/full/fast refresh modes respectively).

Defaults are seeded from the panel configuration at probe time and
can be adjusted at runtime via standard DRM property interfaces
(e.g. modetest, drm_info, or compositor property APIs).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - New patch: Extracted session management properties into dedicated patch
    as plane properties

 drivers/gpu/drm/solomon/ssd16xx.c | 134 ++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 3815af0cee5c..6331f367d864 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -205,6 +205,18 @@ enum ssd16xx_color_mode {
 	SSD16XX_COLOR_MODE_3COLOR = 1, /* 3-colour BWR; RED RAM used for red pixels */
 };
 
+/*
+ * Clear/refresh-mode-init session property values exposed to userspace.
+ * "disabled" means the action is skipped; the others select which refresh
+ * mode to use for the clear/init operation.
+ */
+enum ssd16xx_session_mode {
+	SSD16XX_SESSION_DISABLED = 0,
+	SSD16XX_SESSION_PARTIAL,
+	SSD16XX_SESSION_FULL,
+	SSD16XX_SESSION_FAST,
+};
+
 /* Border waveform enum indices (0-9); mapped to HW bytes via
  * controller_cfg->border_waveform_table[]
  */
@@ -402,6 +414,10 @@ struct ssd16xx_device {
 	struct drm_framebuffer *last_fb;        /* Last drawn FB for reinit redraws */
 	struct drm_property *refresh_mode_property;
 	struct drm_property *color_mode_property;
+	struct drm_property *clear_on_init_property;
+	struct drm_property *clear_on_close_property;
+	struct drm_property *clear_on_disable_property;
+	struct drm_property *refresh_mode_init_property;
 };
 
 /* Plane state subclass: refresh_mode lives on the plane, not the connector,
@@ -411,6 +427,10 @@ struct ssd16xx_plane_state {
 	struct drm_shadow_plane_state base;
 	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
 	enum ssd16xx_color_mode color_mode;     /* Pending color mode */
+	int clear_on_init;    /* Session: -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_close;
+	int clear_on_disable;
+	int refresh_mode_init;
 };
 
 #define to_ssd16xx_plane_state(s) \
@@ -1426,6 +1446,10 @@ static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plan
 	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
 	ssd_state->refresh_mode = device->refresh_mode;
 	ssd_state->color_mode = device->color_mode;
+	ssd_state->clear_on_init = device->clear_on_init;
+	ssd_state->clear_on_close = device->clear_on_close;
+	ssd_state->clear_on_disable = device->clear_on_disable;
+	ssd_state->refresh_mode_init = device->refresh_mode_init;
 
 	return &ssd_state->base.base;
 }
@@ -1456,6 +1480,24 @@ static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
 	kfree(ssd_state);
 }
 
+/*
+ * Convert internal clear_on / refresh_mode_init value (-1=disabled, 0/1/2=mode)
+ * to the userspace-facing enum (0=disabled, 1=partial, 2=full, 3=fast).
+ */
+static inline unsigned int ssd16xx_internal_to_session_prop(int internal_val)
+{
+	if (internal_val < 0)
+		return SSD16XX_SESSION_DISABLED;
+	return (unsigned int)internal_val + 1;
+}
+
+static inline int ssd16xx_session_prop_to_internal(uint64_t prop_val)
+{
+	if (prop_val == SSD16XX_SESSION_DISABLED)
+		return -1;
+	return (int)prop_val - 1;
+}
+
 static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 					     const struct drm_plane_state *state,
 					     struct drm_property *property,
@@ -1472,6 +1514,22 @@ static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 		*val = ssd_state->color_mode;
 		return 0;
 	}
+	if (property == device->clear_on_init_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_init);
+		return 0;
+	}
+	if (property == device->clear_on_close_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_close);
+		return 0;
+	}
+	if (property == device->clear_on_disable_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_disable);
+		return 0;
+	}
+	if (property == device->refresh_mode_init_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->refresh_mode_init);
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1501,6 +1559,30 @@ static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
 		ssd_state->color_mode = val;
 		return 0;
 	}
+	if (property == device->clear_on_init_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_init = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->clear_on_close_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_close = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->clear_on_disable_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_disable = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->refresh_mode_init_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->refresh_mode_init = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1588,6 +1670,10 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 
 	device->refresh_mode = new_ssd->refresh_mode;
 	device->color_mode = new_ssd->color_mode;
+	device->clear_on_init = new_ssd->clear_on_init;
+	device->clear_on_close = new_ssd->clear_on_close;
+	device->clear_on_disable = new_ssd->clear_on_disable;
+	device->refresh_mode_init = new_ssd->refresh_mode_init;
 
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
@@ -1897,6 +1983,13 @@ static const struct drm_prop_enum_list ssd16xx_color_mode_enum[] = {
 	{ SSD16XX_COLOR_MODE_3COLOR, "3-color"     },
 };
 
+static const struct drm_prop_enum_list ssd16xx_session_mode_enum[] = {
+	{ SSD16XX_SESSION_DISABLED, "disabled" },
+	{ SSD16XX_SESSION_PARTIAL,  "partial"  },
+	{ SSD16XX_SESSION_FULL,     "full"     },
+	{ SSD16XX_SESSION_FAST,     "fast"     },
+};
+
 static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 {
 	struct drm_device *drm = &device->drm;
@@ -1928,6 +2021,47 @@ static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 	drm_object_attach_property(plane_obj,
 				   device->color_mode_property,
 				   device->color_mode);
+
+	device->clear_on_init_property =
+		drm_property_create_enum(drm, 0, "clear_on_init",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_init_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_init_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_init));
+
+	device->clear_on_close_property =
+		drm_property_create_enum(drm, 0, "clear_on_close",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_close_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_close_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_close));
+
+	device->clear_on_disable_property =
+		drm_property_create_enum(drm, 0, "clear_on_disable",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_disable_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_disable_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_disable));
+
+	device->refresh_mode_init_property =
+		drm_property_create_enum(drm, 0, "refresh_mode_init",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->refresh_mode_init_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->refresh_mode_init_property,
+				   ssd16xx_internal_to_session_prop(device->refresh_mode_init));
+
 	return 0;
 }
 static const struct drm_connector_funcs ssd16xx_connector_funcs = {
-- 
2.39.1

