Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC45C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8113E10F90B;
	Fri,  4 Sep 2026 07:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BJGsb4tT";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207E710F90B
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQpSgmBITfOK7by8FjRLsMgRMmbudQOEEmY28oPvJE0QG+kb/yfa1crMGhFO6d8sMVF1PbMjnrWDUjiwyCoJox2SE7hOCjBPw3pHZD1vUd2SGamOcC9M/DIcwIqNmfsdAVI6d0lezKJC6+ANG+N6hhVC6QdEARpWuYDjdyzKdeUSWtOK3FOrtCWWggjGTe/VHE0MfoavqK9/ENQBnNbWxDjx4xyY6n+Sar+aRHZm/mNsmhm6gd4L3XvMHkIiDSBTs/8gRtprW65wu2+9Pdz/HZxpGdriulfa/wRQExqvdXm5lVXl2eXGIuUeMrcAMV+3+u/CEg14nFyq7lpOs69tnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFhy6IwISsq25BdZreHbe+EAQUNwJS0JDZMkizq76Yc=;
 b=Oa+RVomykThHk7hspmpPOv8BIbqxmx58USiI0ha4UOc9F/OZA5tOq7QZ8aoQ5PuY2mxsVJCGWh5qD65IJZtPxvWdaiJKTMRQEhxsvmBC4a36mn0SWYV2djoFQWKZz8lsaSwrFUtSrddqsRioPv2Zdpl1ujDlWhozTAs5ps8vfwTJUto1iih3hxq7r/cty34KoAM6CcQTOnWHivXm9gQweM0U1khh+GEngtDFwpAaozjUjlb1Br6gOzS2IPM2t8soPOKnC6X+Wl1V8IGKaunf6PE+omjwCCLbY2Q9uKlGEY2yGsVHBVlC+ru93MHs2pLNqYsuu42+NVVuQ1F2y9VVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFhy6IwISsq25BdZreHbe+EAQUNwJS0JDZMkizq76Yc=;
 b=BJGsb4tToCUMctnMl8R1yuD9DJNpDDZqWjcsiO4paho+7mBmk72nxfXEJyi/v7GZjshD6Fl23UbG9EiO2a2qgvpk8WoAuqCRHQ1s4GIicZ9MWVrXfxNFd9Vc6+RQXVTSHHJNwAX/gk8CjEFbnsQUQTGaO8MAtAp6O3DZP/h6tKABQmONESgCbstTb0SMgaHg+iJ4OwRrAHxRdXkLoA/c0k4sLgt2P4nY7MjdCCW2/hpOmVKFUaT5+TFrnw/ZnCbGAm/znjXIB9mLhqg/ZvbVGo4s/2eS49L4wuK9951b0nEHA55eushZiLQECKGNNa+0uYE6lc6Eio71NNb4BTMBmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:56 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:56 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:55:03 +0800
Subject: [PATCH v6 13/13] drm/imx: dc: Use prefetch engine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-13-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::18) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: f43b7899-49c8-497a-e219-08df0a59cf90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|6133799003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: hNpi1wRGrfR08ph9jsss+xlADLqCE6ICU9cRZKz55+Nt3uWzdBk8QnS04+WSwgB9ZqomJpeHIVjqCPGxeVJ3tv6/k0QAwpOiz337Vg1np/9mfEjA7Yznm1yvzkybKlT0F9P10IBamKReJKE4aihhEkxqEMAsUgYPNVil8lzvY8cWCgAYAtWBZzDa6jsEyAbEgzhvaMXsLmgkisPqmMTKRtXdUiUOyBla4sOLMUpUYPOmbDZw1Rn6mQUykytKyOt3IPQlQjJ897kd0+zVZICkGz4BpwuXsiKfyzsrx+sMdWMTrH53vAiWTrJMnFZIMZMV1Ak2LkBUznlOnLvepPNAoj0zPfhPPuuVivJcgkyZ1sjooDwv9NWcbrlAMu86peA+FBJQ/wyF0ZO0pPOofu7JMfBHMXxF+VWqfabWOZ6uR1X2ApifoO/cpazQcPioHlehycTZqNTY7icmw3jGnaw4opl449RYsCLYvJ95SuGrWXfHZSXD8wSu1iQ0pJ5L9nTXK4XCoN1Cya1YB78UZwQamBhX+P0CfGYdXfySMZAT1q5J6C9frwaYd1pf7hKn6F8xIJuHko/tvSuYXbmMA2n4xFsfPm24Ynx8NeipOrEBqFPgDdmHEz+vK0w8TRG2mCBNrWW22RFh1aILIBxpBYeIodswYMiRSsM6DrVXrsDJEP9YxKtolGFrkCOs2NwlPCiALL6B/Y+kVPhSXkrnDCAWNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk9LWGtiUmQ0djRWREtOMDJaTkVIYUJ3QnZCcDh0amM1YUc1V2NpaG1HL05m?=
 =?utf-8?B?TGpER3ZnTWE2a1RDek0ranB1UHBsSWpiNFR5T0lyQjB3dWhCQzRXZ0xoWHh6?=
 =?utf-8?B?MkFDZENUR1kxeFlwOWtPaER6K3lZeHlWb3V3a0RqRnVrbTRtay9UTmdLb3py?=
 =?utf-8?B?NjEveWwrMUdDTWdpWE1CWThiVWUvWFREdmxOQXpFNklzbEJ1eHF0aU5oaFZD?=
 =?utf-8?B?ZG9iMUlpUUZVVGRMSGxXcTg2dUdOd2dvTkdqVGx0QzdYVldhaEplMUhya2VK?=
 =?utf-8?B?M0dkSGFjT00rU096a2ZNWWo3eWZqM09wWEl0Y2xGaWtkTWw5VlVuNjByUVhF?=
 =?utf-8?B?Y1d4Q3NraVVxdzl6aTk4SlV2T0NvM0FwTGxRRWZ6T2hvY2FDbmVrYlQ0eXNu?=
 =?utf-8?B?dVZFQy9LTGZ2NjFDcW1IU0doTUNTdUtpaE9jNFdXSUVOTFdibytNZTdKZ2Rx?=
 =?utf-8?B?Z3hxeWtZRlZoRmx4UUhiYVBSZUZLTGo2Qno0dHdXK1RoYlVqZ01HaVZVOHNO?=
 =?utf-8?B?Z1R6aGEwTmNLQzlSUll0NzRGWmFNVXgvYVRHOUF6ZHZtbURxeDZiVlhxQ1gy?=
 =?utf-8?B?VWtMRFB5U290N2huTExFazYwaitxVTZUT0Z5NW10R2dxcHNOUHZzMDV1TnVI?=
 =?utf-8?B?WjhzZW95WnNidVdHRk9iN0hMaXg2V3NsdVVTd3F1dXJ3dGFNMDFoQ0lqcEF0?=
 =?utf-8?B?bk1ZN0tPOU5pK3NkVlhlMC9DM05XVDEzUjhtKzZOWEFJY2tZVW51UnZ1T0VG?=
 =?utf-8?B?aEFUT0xEb2xNOU5KbHRFU3BzamZsOWJlSEpxTkNiK0FJZmRPQUdFSWt1aVRh?=
 =?utf-8?B?LzhYSys1bHdpamJCRGgxc2Y4MWZGZ0VKOFFJTTgwSmdJR2psemt3SFhlS2gw?=
 =?utf-8?B?SzJabVFsOGNYeFU0bUJMV3VwNURHN2dyalVENkllS2NBWUppNmVNT1V3Wms0?=
 =?utf-8?B?SHZYK0hoSG1RZXNRSjUySSswSGt5Z2dzZkNTa2w5Nm1EZEowUlRLcjR5QWI0?=
 =?utf-8?B?QXpmUmpkSThDVVdsYXlUYjNWdFRJY2FFczVUeXUydjgzNy9aK2M0b2RndHQ0?=
 =?utf-8?B?YWJRNkk5cE1nVGdRc0FKL3Zxb2hsTlVmc2luM2dPT2VkQm8ydFAySk9tOWFw?=
 =?utf-8?B?akd2YjFERzgrSGJwdTlaMFRJTDhSMjdmcTVBVTI4cG1ocUc2NHFNUEwzYTV1?=
 =?utf-8?B?RTBCU2gxcDFHVUVMR29HRjVMOSt5Zk1HSVN0Si9pS05xU28zdmNkZHZrVlox?=
 =?utf-8?B?d3pUMGNqVU9qSEdwdDlaU0NGdFBtbWxacUJZbktSY2c2NmJ1KzN2L0VweENC?=
 =?utf-8?B?cnFrb0lWMWV3bXBHbVllU0o1azZZRzNVZktyOVpONlp4akJJWVpWc2lWYkVG?=
 =?utf-8?B?V1AvbXhHSGZwa1EvYm1JSmJkSjFVWE5QTlVIRXQzeXBjbDV0TlMyRU1TTHNp?=
 =?utf-8?B?MTFEVG9VaENTRXFiWnVMNld3UlRxTG1kWmhmcW9xQXdoK3RZYWR3UC9tMmd3?=
 =?utf-8?B?dlU4YUZEK21tNFlvTjNXVENlSGdUbjhQMmV4Y3NiclR5d2VTeXJ6T2VwMElM?=
 =?utf-8?B?cmNrSXp3aVFJL2t3ZHJDY05PUldSK3BMOFFNaWQ1V0R6dmp4QlpsODN2aVho?=
 =?utf-8?B?YThuUi9yWjJQbUZZcWtlZlhWUVdoNU9hQVR5UVZ5SmtDRkFWVnUwU2dYVFRX?=
 =?utf-8?B?RDlJQUdhTytyRUdKaGVUcDg4RWN0NnpWZHVpVW9aMWpISzVXMURYaytVMFM5?=
 =?utf-8?B?c1ZkcHRzNmR6WTNuei9FQmUrUDV2NjErWHBCZ2VBZjhuSWFYL1phMWhiUy9R?=
 =?utf-8?B?bnAzeTcvU2ZKOUxIUHUzWjFSUEs0MHpLN0o5VjNCTVZQTlEwRFZ3TmFtWUVN?=
 =?utf-8?B?dy9xVVlhbUZGM3dORUVqYnUyN2pjRnpsRmtXN3Y1S3R0ZFZsbGJhRytXbURj?=
 =?utf-8?B?VXIrQWZQeHUxOTV3RG1VbkJXTGRMR2R2T0dCeTBkTHpweWpUWFVMNjdvYURz?=
 =?utf-8?B?Z2tlWjltRDZqY3JqcjRLbGlCMENDK0c2ZVVCYUNZcDFUY0M4amlsT0E2SENt?=
 =?utf-8?B?bWZ2ZFpLeVhzUkxNV3ZNVVM0SWY0K1J4dUF4V2pwd3JuR3F2a0N2M3MxL0kx?=
 =?utf-8?B?OUhET1hYemZnVnMycnpqakoxSEI1T1JlVUE5VE1yYjlvN0ZpWUFkTkx4Q2lU?=
 =?utf-8?B?aFloTVdQWGQwM0VQOVd2ZzJJbklnVDJIUHQ3a0t3Y1k0WWc4UlBISWxGeXpG?=
 =?utf-8?B?V3dWSHo3ZGhQV2V5R1VvU1c4aFNOTTFydTR1M2h1aTFyd3FsMUVDV1p2UUd3?=
 =?utf-8?B?K0swWmJLV0JMODR0bzdzS0FYckc5ZzhnV093eXY4N3VxL3dMaVdXQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43b7899-49c8-497a-e219-08df0a59cf90
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:56.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywkFbQpcfofzmMqLaRp9pB1iIxmAu5XUh846uHRYSGQqwYEv1gFcDUF/+PfK0naRseOZfY5WYh1/eEilTR3xmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

One prefetch engine consists of one DPR channel and one or two PRGs.
Each PRG handles one planar in a pixel format.  Every FetchUnit used
by KMS may attach to a PRG and hence use a prefetch engine.  So, to
simplify driver code, always use prefetch engines for FetchUnits in
KMS driver and avoid supporting bypassing them.  Aside from configuring
and disabling a prefetch engine along with a FetchUnit for atomic
commits, properly disable the prefetch engine at boot and adapt burst
size/stride fixup requirements from PRG in FetchUnit driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c  | 135 ++++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/imx/dc/dc-fu.c    |  27 +++++++-
 drivers/gpu/drm/imx/dc/dc-fu.h    |   2 +-
 drivers/gpu/drm/imx/dc/dc-kms.h   |   5 ++
 drivers/gpu/drm/imx/dc/dc-plane.c |  46 +++++++++++--
 5 files changed, 193 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index beefa01e4fa2..4fb86b0ebc59 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-kms.h"
 #include "dc-pe.h"
@@ -204,7 +205,13 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 				drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
+	struct drm_plane_state *new_plane_state =
+			drm_atomic_get_new_plane_state(state, crtc->primary);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	bool disabling_plane;
 	int idx;
 
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
@@ -216,13 +223,40 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	enable_irq(dc_crtc->irq_ed_cont_shdload);
 
-	/* flush plane update out to display */
-	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	disabling_plane = drm_atomic_plane_disabling(old_plane_state,
+						     new_plane_state);
+
+	if (disabling_plane) {
+		unsigned long flags;
+
+		dc_crtc_dbg(crtc, "disabling plane\n");
+
+		/*
+		 * Don't relinquish CPU until DPRC REPEAT_EN is disabled and
+		 * sync is triggered.
+		 */
+		local_irq_save(flags);
+		preempt_disable();
+
+		DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+
+		local_irq_restore(flags);
+		preempt_enable();
+	} else {
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	}
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
 
 	disable_irq(dc_crtc->irq_ed_cont_shdload);
 
+	if (disabling_plane)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
 	drm_dev_exit(idx);
@@ -320,14 +354,33 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
+static inline void
+__dc_crtc_disable_fg_along_with_dprc_repeat_en(struct drm_crtc *crtc)
 {
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	unsigned long flags;
 
-	enable_irq(dc_crtc->irq_dec_seqcomplete);
+	/* Don't relinquish CPU until DPRC REPEAT_EN is disabled. */
+	local_irq_save(flags);
+	preempt_disable();
+
+	/*
+	 * Sync to FrameGen frame index moving so that
+	 * FrameGen can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
 	dc_fg_disable(dc_crtc->fg);
-	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
-	disable_irq(dc_crtc->irq_dec_seqcomplete);
+	/*
+	 * There is one frame leftover after FrameGen disablement.
+	 * Sync to FrameGen frame index moving so that DPRC REPEAT_EN
+	 * can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 }
 
 static void
@@ -335,14 +388,29 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_crtc_state *old_crtc_state =
+				drm_atomic_get_old_crtc_state(state, crtc);
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	int idx;
 
 	if (!drm_dev_enter(crtc->dev, &idx))
 		goto out;
 
-	__dc_crtc_disable_fg(crtc);
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask)
+		__dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	else
+		dc_fg_disable(dc_crtc->fg);
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -367,7 +435,10 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 {
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	enum dc_link_id ed_src, lb_sec;
+	bool disable_dprc = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
@@ -377,13 +448,53 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		return;
 	}
 
+	ret = pm_runtime_resume_and_get(dc_drm->pe->dev);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
+			    ret);
+		goto out1;
+	}
+
 	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
 		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
-		goto out;
+		goto out2;
 	}
 
-	dc_crtc_dbg(crtc, "disabling at boot\n");
-	__dc_crtc_disable_fg(crtc);
+	ret = dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
+		goto out2;
+	}
+
+	if (ed_src == LINK_ID_CONSTFRAME0 || ed_src == LINK_ID_CONSTFRAME1)
+		goto disable;
+
+	ret = dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
+	if (ret) {
+		dc_crtc_err(crtc,
+			    "failed to get primary plane LayerBlend secondary source\n");
+		goto out2;
+	}
+
+	disable_dprc = true;
+
+disable:
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling along with DPRC REPEAT_EN at boot\n");
+		__dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	} else {
+		dc_crtc_dbg(crtc, "disabling at boot\n");
+		dc_fg_disable(dc_crtc->fg);
+	}
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (disable_dprc)
+		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
+
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	if (!dc_drm->pe_clk_axi_disabled) {
@@ -391,7 +502,9 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		dc_drm->pe_clk_axi_disabled = true;
 	}
 
-out:
+out2:
+	pm_runtime_put(dc_drm->pe->dev);
+out1:
 	pm_runtime_put(dc_crtc->de->dev);
 }
 
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 8339f44c0091..28f962af6974 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -124,13 +124,28 @@ static inline void dc_fu_set_numbuffers(struct dc_fu *fu, unsigned int num)
 			  SETNUMBUFFERS_MASK, SETNUMBUFFERS(num));
 }
 
-static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+static unsigned int dc_fu_burst_size_fixup(dma_addr_t baddr)
 {
-	unsigned int burst_size, burst_length;
+	unsigned int burst_size;
 
 	burst_size = 1 << __ffs(baddr);
 	burst_size = round_up(burst_size, 8);
 	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_fu_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+{
+	unsigned int burst_size, burst_length;
+
+	burst_size = dc_fu_burst_size_fixup(baddr);
 	burst_length = burst_size / 8;
 
 	regmap_write_bits(fu->reg_cfg, BURSTBUFFERMANAGEMENT,
@@ -150,8 +165,14 @@ void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp)
 }
 
 static void dc_fu_set_src_stride(struct dc_fu *fu, enum dc_fu_frac frac,
-				 unsigned int stride)
+				 unsigned int width, int bpp, dma_addr_t baddr)
 {
+	unsigned int burst_size = dc_fu_burst_size_fixup(baddr);
+	unsigned int stride;
+
+	stride = width * (bpp / 8);
+	stride = dc_fu_stride_fixup(stride, burst_size);
+
 	regmap_write_bits(fu->reg_cfg, fu->reg_sourcebufferattributes[frac],
 			  STRIDE_MASK, STRIDE(stride));
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index 9fbd7aadd264..0527a7b2221d 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -87,7 +87,7 @@ struct dc_fu_ops {
 	void (*set_baseaddress)(struct dc_fu *fu, enum dc_fu_frac frac,
 				dma_addr_t baddr);
 	void (*set_src_stride)(struct dc_fu *fu, enum dc_fu_frac frac,
-			       unsigned int stride);
+			       unsigned int width, int bpp, dma_addr_t baddr);
 	void (*set_src_buf_dimensions)(struct dc_fu *fu, enum dc_fu_frac frac,
 				       int w, int h);
 	void (*set_fmt)(struct dc_fu *fu, enum dc_fu_frac frac,
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index a25d47eebd28..8b45b21a6f8a 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -130,4 +130,9 @@ struct dc_plane {
 	struct dc_ed *ed;
 };
 
+static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct dc_plane, base);
+}
+
 #endif /* __DC_KMS_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index dea7404fe659..bf4b00c54c94 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -17,6 +17,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-fu.h"
 #include "dc-kms.h"
@@ -44,11 +45,6 @@ static const struct drm_plane_funcs dc_plane_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
-static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct dc_plane, base);
-}
-
 static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 {
 	int src_h = drm_rect_height(&state->src) >> 16;
@@ -88,6 +84,28 @@ static int dc_plane_check_fb(struct drm_plane_state *state)
 	return 0;
 }
 
+static int dc_plane_check_dprc(struct drm_plane_state *state)
+{
+	struct dc_plane *dplane = to_dc_plane(state->plane);
+	struct drm_framebuffer *fb = state->fb;
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	struct dc_dprc *dprc = dplane->fu->dprc;
+	u32 src_w = drm_rect_width(&state->src) >> 16;
+
+	if (!dc_dprc_rtram_width_supported(dprc, src_w)) {
+		dc_plane_dbg(state->plane, "bad RTRAM width for DPRC\n");
+		return -EINVAL;
+	}
+
+	if (!dc_dprc_stride_supported(dprc, fb->pitches[0], src_w, fb->format,
+				      baseaddr)) {
+		dc_plane_dbg(state->plane, "fb bad pitches[0] for DPRC\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
@@ -123,7 +141,11 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return dc_plane_check_fb(plane_state);
+	ret = dc_plane_check_fb(plane_state);
+	if (ret)
+		return ret;
+
+	return dc_plane_check_dprc(plane_state);
 }
 
 static void
@@ -131,6 +153,12 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state =
 				drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_state =
+				drm_atomic_get_old_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	bool needs_modeset = drm_atomic_crtc_needs_modeset(new_crtc_state);
+	bool prefetch_start = needs_modeset || !old_state->fb;
 	struct dc_plane *dplane = to_dc_plane(plane);
 	struct drm_framebuffer *fb = new_state->fb;
 	const struct dc_fu_ops *fu_ops;
@@ -152,7 +180,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	fu_ops->set_layerblend(fu, lb);
 	fu_ops->set_burstlength(fu, baseaddr);
-	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, fb->pitches[0]);
+	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, src_w,
+			       fb->format->cpp[0] * 8, baseaddr);
 	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
 	fu_ops->set_fmt(fu, DC_FETCHUNIT_FRAC0, fb->format);
 	fu_ops->set_framedimensions(fu, src_w, src_h);
@@ -161,6 +190,9 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
 
+	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
+			  fb->pitches[0], fb->format, baseaddr, prefetch_start);
+
 	dc_lb_pec_dynamic_prim_sel(lb, dc_cf_get_link_id(dplane->cf));
 	dc_lb_pec_dynamic_sec_sel(lb, fu_ops->get_link_id(fu));
 	dc_lb_mode(lb, LB_BLEND);

-- 
2.43.0

