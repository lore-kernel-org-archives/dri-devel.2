Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3D606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YE6Q6Ae5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDD5112C12;
	Fri, 23 Oct 2026 16:50:28 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F58112C0A
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BChm7jsPDQDnkhpOr95RsC3xy435QyPoA+P/qyDzJun3ELJqprh52d2nJhWdalE0qH/T6yPOQJWcLazi1gwIcdoBs57su462UBX+2Um6Dl2/xt/2ai54uRH60mm4wFCuF4AEwtfX7s9GBiy2i/tKTeI1mmB/6OKUqElmp6XWe9Ek2b1QvX98Hbl3LBTyL2c9h9DQrLkTCnLpQpDwe+IeHC7wv5SCL4JQv3YPY/RV9aBEF2HlrC9gOsjAenTw2NqmoJAChZFjK8KQg2uUoFr3qRme3s0ugCH5GDENMAxNdUXz8Mplc1c9XUiLW3d0R4x9kPMJpdbATscZYxMks4J6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFqTYNzHRKpY2HliJuJhNqRlxPqChIN/iaoamWq709I=;
 b=tmuhPhtR+0ZeApcRC43mAyAcQedEFnPaOz5gqSYHKXPePimItqGc83RspjiA1Ijp8RAKX9psyrx89VZSzAz9VOwCsVOnVbpFqXzIpS8pZfyGuqpMjUBmS68AMNzHu5X/7Xmfd665jL+jL1ldIL+Tu0d/MJ7lPOlyyq+fP/WIoGr/BCTNQ1awJGf2/tOnPUya7EKF/PP9wHI2UXZiY7JxXYCHvfe4qv+o9TGjjiH/z7YkjHLh9GOlIzKC/5HpGIkLx3bK8qOr2HiiCoxiQfEC1rZke7XfyNr4smUqm4Kio1mwZAnRHUJVcf9s8ZyHqbTkyPUZS4N//TVEwYnKygSerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFqTYNzHRKpY2HliJuJhNqRlxPqChIN/iaoamWq709I=;
 b=YE6Q6Ae5RG3WbPMzOlpQjzNRGww8VKG5d4GI+ARMQz8oCiwx/l5CjlSzTLWwPg0jInbuiEEQYw6NaG859e1gswJx0OC74cxYaV+rbCONt+U6c/J8fzhU0+cR4KFNzQhN2d+WV2Q36MN/EKnoNAOs9os9rgHANkFOnCVhodqI9Bw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:49:39 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:49:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/10] drm: renesas: rz-du: Add RZ/G3E (R9A09G047) DU
 support
Date: Fri, 23 Oct 2026 18:47:42 +0200
Message-ID: <08080acc36b67a48dbfadc135d3e30b74a154f6b.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 955c0b92-61b9-458e-963d-08df31259ca0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261021135927099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261022113327099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: sHbZ4vZ+44rJfPOwkqK5uI+TBWnss3P+B/V4h/TrQsrGNRKHdQzGUvmLvDiWzOXfdrAnevCPeLT7cCzF8Qz+8j5QCmXD7ZewZhZybpY08NDhCo3cYUwflEe3aqVYXkahfyk4pXlGP5TVIjbYFMZjPy7b/6M1Nk9pgorUQDc9XFeB5ZDi8P+E6DkflEaYzPe1vlk7JZfOx4ZdghcroqVS09zXoh0zektyZB1jekZHtGIDdlpL96ElTQICoumkozYGIaLlOfukyGWy0mO1KEHGFHgUfeTITYKtxUjIp/MB0uCJ1xeBwievd6VNiwcl5txCXkafwflUZSERnb+Olyf7Isft5q2wn/9fXApExeKuLimz8WHWz39Gy9x4tNXR9bGabgOFWdRCGHqqGYwkkf812EuDgBsvJS5Pgrr5lynh7L17c8oeEY4Gsywrxt9dIs2Nwr0kI82yf/JuVPQWcbzJuYYR06ExBgrI8iFffZlqdG1VoouRTzh7SRnN2mrfYQVS37TsxaqvL+aPJ2qdBZdJk0J7gqjaZz4qiXqEIx87FQcoyJFTuGautncmh/LPOacg8X2ed57MOAJkGc/dzg1lMLydQz29YAqkVYLJehco1N1isRXUn/lcCa0/meJAFSElKi+eC840M2f5zn7X2xOLJUe1EjYs3T4oYkZw4QjVO+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261022113327099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sM17NF6a7i4fhaInJK5jlASoHTCmZWpzAWrHrcIO295ve5rXCGbV6xFiXGon?=
 =?us-ascii?Q?XvAKJHtAY0fR85AO6qLdn0CXLzXOFQR8j0bL0EqUlAWFHaLRaStG+V/mQRjQ?=
 =?us-ascii?Q?cWkyVrr2C/jJXhFAb4AzVhk6WPJ3I9T0NkdBiO6yvYzQtESztzSDBbvqRsim?=
 =?us-ascii?Q?fXpfoW9Ee+bDpo7573Rs5RIfJs2XFnoCctubdBof1jgFf71jGka4aQ71NW2U?=
 =?us-ascii?Q?nneTEX6civ5o/ZvhQt7mI+bEvZwd1QcGD6fMlEf2tHj20KaX/ZVk1pgGKj5I?=
 =?us-ascii?Q?r7O7NF0ekYBOx6fGXNugWYfz4g2KLQPjGpMuPbQ4tA+So7AoHmybnD0R/nPE?=
 =?us-ascii?Q?4F/pV04pJlDAaOHi6zHciCIL7Bj+JYFn1M2jfhhMqkoHG8vJSWDVWNHMEhtw?=
 =?us-ascii?Q?bNefB2kFIHDEgN0Ma1JTQdQZHnT/opTVJ8S7FbieC0X4wujOuHW4RR0odIE8?=
 =?us-ascii?Q?NDoOb7MXGfWj5hr14PtSzxanmkq/xvxoZU/NjfkYTd7M9adHgqA3gJCT98Sa?=
 =?us-ascii?Q?6apti00U8PNPgExDrF/cFESqdvbwYzaVweoYuwTjp0Vs/iMPU8tg7nZ1KjMk?=
 =?us-ascii?Q?5Hvm1FJUfR9g7u00U4dnRvEhNxTyl80SLmWKi2EIjiWavV6KYEexY53NugA+?=
 =?us-ascii?Q?V6AOnk1zjfjGIfByYFlfQrkXv+JQzZUPB17xZoYUlbCoK9Z8VxnMRuwuMmyJ?=
 =?us-ascii?Q?fpNjph1RNdBzPvVWRsUts+REMFuYbKS7uQvaVDY+CehaJPjKyIMqGovVHEkS?=
 =?us-ascii?Q?dFQyix/QNr9NPOMHEWRTejPbAQYaEeyGYGR276Cc9HaIDqrdoa8ZvLkSYeZA?=
 =?us-ascii?Q?BNttj9dkgGkQtZMR/uQoGqMn2QQrU//6oSPwCBhRpAm5vqlR/al/V6J7eilM?=
 =?us-ascii?Q?fAdH9EOiTWMZ3sLAuRww+k5wM5/fJtp2PS68YnGlYOLW2NVH2bJzzOPE+osK?=
 =?us-ascii?Q?iw3Cyr7G94qGSV4rTLfpAe+0csTB43bdF7A7R7ypy8eYWHXyeL8Rf1DenO56?=
 =?us-ascii?Q?mrWcaN+loybex5puErSIY4HBAwaDZtzzk/5AVflxU97XrV8Q0/QipFwnzCgg?=
 =?us-ascii?Q?Lwhg4rBsC+QbNAgMDV5vSFX8AwPzBkcTVAIqRyvlIcnnWp01YYHR4fWElGyw?=
 =?us-ascii?Q?CzwFaWpVWUXfOdcx8/wulMnX6IpsjkxKR9g68zFKKNSnVpMu17o8/KnYR6XM?=
 =?us-ascii?Q?669QvVuJG7JvOJtJWJhbQCYcOveVRIOUKf2fKpOWgDxoAEkWXARmdFRD0pKC?=
 =?us-ascii?Q?ceXGlgKQBFqesX24I07YoSj4CX9AeozT4MbdhNd5I/rwbzEnNsjGEdRP4hvT?=
 =?us-ascii?Q?CS6Daixxqjhtu/wq2hVxZZtFqey6nXhTExKlK1NoHn8z5Y3DRjureVnsk20L?=
 =?us-ascii?Q?vZewm0+RrtG/zBE31iwHP6h/Igyp1K8KJbTRtuDbtjAqduIH93FqIT7Y3hvw?=
 =?us-ascii?Q?3AiB2zH/UsrngSHI6Hr1iIPUybxAobMnRHEQartFVaMhA5FVhK8IJi6kqc+e?=
 =?us-ascii?Q?aduCg9BCtdtIFhUVK0Hh+JZE2v2ECgtHMscijVoNiZJcm0VFqoiwkkhFuN/I?=
 =?us-ascii?Q?4gdIyEB1XYHRLJS5wfDA5FZk1s7FTc5rY9v03knMXTHFxAbDzpal+mp9DvnU?=
 =?us-ascii?Q?u8FX48k3WzYkhdlUO7+u9/AR4tBV5/4V+tN/GDKWuLbG5cbKovy0wjEuGmMO?=
 =?us-ascii?Q?u5vwyG64cTLZDhg+Ub2uDqyFTu4yTpCY0eUYQBESKl6HVBlpCZsJYCGh72RL?=
 =?us-ascii?Q?FJE60JLRrrGZpUlvaejflGWQoNya7uxTyB1DBuQ5zaLPyN4XPawm?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955c0b92-61b9-458e-963d-08df31259ca0
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:32.4455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTeVeQPabRs6kiKuPouO19N7pDysnE4XSBZyZA4AXxBs9zENDnNGtQXluP8L85DFwm20GpTYIBD0LmpN/pgDsH98V72SPKKnVY2LM1JcvarYMfcqB/QwHkuBN1WPxOPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RZ/G3E (R9A09G047) has two DU instances which can both drive the
DSI encoder and channel 1 of the LVDS encoder.
Expose them through a single DRM device, owned by a new display
subsystem driver that binds the DU instances as components.

Request the LVDS duty cycle for the new LVDS channel 1 output as well.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - Added newly architetture support creating an ad hoc component
   driver for RZ/G3E display subsystem that embed the 2 du instances
   into single drm device.

v7->v8:
 - Modelled using ports/port instead of port/ep.
 - Rebased on top of RZ/G3L du support [1]
   [1] https://lore.kernel.org/all/20260826174854.199139-1-biju.das.jz@bp.renesas.com/
 - Added mode_clock_min, mode_clock_max for parallel output.
 - Improved commit msg and commit body.

v6->v7:
 - Removed feature flag usage, rebased on top of T2H/N2H LCDC series [1]
   [1] https://patchwork.global.renesas.com/project/spl2-reviews/list/?series=694&state=%2A&archive=both
 - Reworked commit body as now outputs routing is based on endpoint id
   instead of port number.
 - Fixed rzg2l_du_r9a09g047_info instead of rzg2l_du_r9a09g047_du_info.
 - Added bump of RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.

v5->v6:
 - Aligned ports numbering with the bindings changes.

v4->v5:
 - Fixed RG2L_DU_FEATURE_SMUX2_DSI_CLK to RZG2L_DU_FEATURE_SMUX2_DSI_CLK,
   update commit body accordingly.
 - Added features field documentation.

v3->v4:
 - No changes.

v2->v3:
 - No changes.

v1->v2:
 - Instead of using clk-provider API to select the right parent clock,
   based on the outputs. Just set the correct duty cycle based on the
   output, this reflects at CPG lvl to select the right parent.
 - Updated commit message accordingly.

 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  77 +++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  13 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |   3 +-
 .../drm/renesas/rz-du/rzg2l_du_subsystem.c    | 231 ++++++++++++++++++
 5 files changed, 316 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg2l_du_subsystem.c

diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
index 46decb7ac4f1..a3d064957c70 100644
--- a/drivers/gpu/drm/renesas/rz-du/Makefile
+++ b/drivers/gpu/drm/renesas/rz-du/Makefile
@@ -3,6 +3,7 @@ rzg2l-du-drm-y := rzg2l_du_crtc.o \
 		  rzg2l_du_drv.o \
 		  rzg2l_du_encoder.o \
 		  rzg2l_du_kms.o \
+		  rzg2l_du_subsystem.o \
 
 rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+= rzg2l_du_vsp.o
 obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 84da5a2df8f6..c75f05a2145a 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -76,6 +76,31 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
 	.mode_clock_max = 87000,
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g047_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 1,
+		},
+		[RZG2L_DU_OUTPUT_LVDS0] = {
+			.possible_outputs = BIT(0),
+			.port = 2,
+		},
+		[RZG2L_DU_OUTPUT_LVDS1] = {
+			.possible_outputs = BIT(0),
+			.port = 3,
+		},
+	},
+	.features = RZG2L_DU_FEATURE_COMPONENT,
+	.mode_clock_min = 5400,
+	.mode_clock_max = 87000,
+};
+
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
@@ -103,6 +128,7 @@ static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
 	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
+	{ .compatible = "renesas,r9a09g047-du", .data = &rzg2l_du_r9a09g047_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
 	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
@@ -115,7 +141,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 	static const char * const names[] = {
 		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
 		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
-		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
+		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0",
+		[RZG2L_DU_OUTPUT_LVDS1] = "LVDS1"
 	};
 
 	if (output >= ARRAY_SIZE(names))
@@ -130,7 +157,7 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 
 DEFINE_DRM_GEM_DMA_FOPS(rzg2l_du_fops);
 
-static const struct drm_driver rzg2l_du_driver = {
+const struct drm_driver rzg2l_du_drm_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(rzg2l_du_dumb_create),
 	DRM_FBDEV_DMA_DRIVER_OPS,
@@ -151,8 +178,17 @@ struct rzg2l_du_drm {
 
 static void rzg2l_du_remove(struct platform_device *pdev)
 {
-	struct rzg2l_du_drm *rzgdrm = platform_get_drvdata(pdev);
-	struct drm_device *ddev = &rzgdrm->ddev;
+	const struct rzg2l_du_device_info *info = of_device_get_match_data(&pdev->dev);
+	struct rzg2l_du_drm *rzgdrm;
+	struct drm_device *ddev;
+
+	if (info->features & RZG2L_DU_FEATURE_COMPONENT) {
+		rzg2l_du_instance_remove(pdev);
+		return;
+	}
+
+	rzgdrm = platform_get_drvdata(pdev);
+	ddev = &rzgdrm->ddev;
 
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
@@ -162,13 +198,19 @@ static void rzg2l_du_remove(struct platform_device *pdev)
 
 static void rzg2l_du_shutdown(struct platform_device *pdev)
 {
-	struct rzg2l_du_drm *rzgdrm = platform_get_drvdata(pdev);
+	const struct rzg2l_du_device_info *info = of_device_get_match_data(&pdev->dev);
+	struct rzg2l_du_drm *rzgdrm;
+
+	if (info->features & RZG2L_DU_FEATURE_COMPONENT)
+		return;
 
+	rzgdrm = platform_get_drvdata(pdev);
 	drm_atomic_helper_shutdown(&rzgdrm->ddev);
 }
 
 static int rzg2l_du_probe(struct platform_device *pdev)
 {
+	const struct rzg2l_du_device_info *info;
 	struct rzg2l_du_device *rcdu;
 	struct rzg2l_du_drm *rzgdrm;
 	int ret;
@@ -176,8 +218,12 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
+	info = of_device_get_match_data(&pdev->dev);
+	if (info->features & RZG2L_DU_FEATURE_COMPONENT)
+		return rzg2l_du_instance_probe(pdev);
+
 	/* Allocate and initialize the RZ/G2L device structure. */
-	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
+	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_drm_driver,
 				    struct rzg2l_du_drm, ddev);
 	if (IS_ERR(rzgdrm))
 		return PTR_ERR(rzgdrm);
@@ -243,7 +289,24 @@ static struct platform_driver rzg2l_du_platform_driver = {
 	},
 };
 
-module_platform_driver(rzg2l_du_platform_driver);
+static struct platform_driver * const rzg2l_du_drivers[] = {
+	&rzg2l_du_platform_driver,
+	&rzg2l_du_subsystem_driver,
+};
+
+static int __init rzg2l_du_init(void)
+{
+	return platform_register_drivers(rzg2l_du_drivers,
+					 ARRAY_SIZE(rzg2l_du_drivers));
+}
+module_init(rzg2l_du_init);
+
+static void __exit rzg2l_du_exit(void)
+{
+	platform_unregister_drivers(rzg2l_du_drivers,
+				    ARRAY_SIZE(rzg2l_du_drivers));
+}
+module_exit(rzg2l_du_exit);
 
 MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L Display Unit DRM Driver");
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 2952c9d7348b..ede398269d10 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -19,13 +19,17 @@
 
 struct device;
 struct drm_property;
+struct platform_device;
+struct platform_driver;
 
 #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+#define RZG2L_DU_FEATURE_COMPONENT	BIT(1)	/* Bound as a display subsystem component */
 
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
 	RZG2L_DU_OUTPUT_LVDS0,
+	RZG2L_DU_OUTPUT_LVDS1,
 	RZG2L_DU_OUTPUT_MAX,
 };
 
@@ -34,7 +38,7 @@ enum rzg2l_du_output {
  * @possible_outputs: bitmask of possible outputs
  * @port: device tree port number corresponding to this output route
  *
- * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing data
+ * The DU has 4 possible outputs (DPAD0, DSI0, LVDS0/1). Output routing data
  * specify the valid SoC outputs, which CRTC can drive the output, and the type
  * of in-SoC encoder for the output.
  */
@@ -86,4 +90,11 @@ static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
 
 const char *rzg2l_du_output_name(enum rzg2l_du_output output);
 
+extern const struct drm_driver rzg2l_du_drm_driver;
+
+int rzg2l_du_instance_probe(struct platform_device *pdev);
+void rzg2l_du_instance_remove(struct platform_device *pdev);
+
+extern struct platform_driver rzg2l_du_subsystem_driver;
+
 #endif /* __RZG2L_DU_DRV_H__ */
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 45f980ea3c20..60709e0fc601 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -80,7 +80,8 @@ static void rzg2l_du_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	 * - LVDS path has DUTY H/L=4/3, 4/7 duty cycle.
 	 * - DSI/RGB path has symmetric 50% duty cycle.
 	 */
-	if (renc->output == RZG2L_DU_OUTPUT_LVDS0)
+	if (renc->output == RZG2L_DU_OUTPUT_LVDS0 ||
+	    renc->output == RZG2L_DU_OUTPUT_LVDS1)
 		clk_set_duty_cycle(clk_parent, 4, 7);
 	else
 		clk_set_duty_cycle(clk_parent, 1, 2);
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_subsystem.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_subsystem.c
new file mode 100644
index 000000000000..9edd0ab3e1dd
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_subsystem.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RZ/G2L Display Unit subsystem DRM driver
+ *
+ * The DU instances of a display subsystem are bound as components of a single
+ * DRM device, owned by the display subsystem driver.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ */
+
+#include <linux/component.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+#include "rzg2l_du_drv.h"
+#include "rzg2l_du_kms.h"
+
+/* -----------------------------------------------------------------------------
+ * DU instance
+ */
+
+struct rzg2l_du_instance {
+	struct device *dev;
+	const struct rzg2l_du_device_info *info;
+	void __iomem *mmio;
+};
+
+static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
+				  void *data)
+{
+	struct rzg2l_du_instance *du = dev_get_drvdata(dev);
+	struct drm_device *ddev = data;
+	struct rzg2l_du_device *rcdu;
+	int ret;
+
+	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
+	if (!rcdu)
+		return -ENOMEM;
+
+	rcdu->dev = du->dev;
+	rcdu->info = du->info;
+	rcdu->mmio = du->mmio;
+	rcdu->ddev = ddev;
+
+	rcdu->index = ddev->mode_config.num_crtc;
+
+	if (!rcdu->index)
+		drm_dev_set_dma_dev(ddev, dev);
+
+	ret = rzg2l_du_modeset_init_du(rcdu);
+	if (ret < 0)
+		return ret;
+
+	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct component_ops rzg2l_du_instance_ops = {
+	.bind = rzg2l_du_instance_bind,
+};
+
+int rzg2l_du_instance_probe(struct platform_device *pdev)
+{
+	struct rzg2l_du_instance *du;
+	int ret;
+
+	du = devm_kzalloc(&pdev->dev, sizeof(*du), GFP_KERNEL);
+	if (!du)
+		return -ENOMEM;
+
+	du->dev = &pdev->dev;
+	du->info = of_device_get_match_data(du->dev);
+
+	du->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(du->mmio))
+		return PTR_ERR(du->mmio);
+
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, du);
+
+	return component_add(&pdev->dev, &rzg2l_du_instance_ops);
+}
+
+void rzg2l_du_instance_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rzg2l_du_instance_ops);
+}
+
+/* -----------------------------------------------------------------------------
+ * Display subsystem
+ */
+
+static int rzg2l_du_subsystem_bind(struct device *dev)
+{
+	struct drm_device *ddev;
+	int ret;
+
+	ddev = drm_dev_alloc(&rzg2l_du_drm_driver, dev);
+	if (IS_ERR(ddev))
+		return PTR_ERR(ddev);
+
+	dev_set_drvdata(dev, ddev);
+
+	ret = rzg2l_du_modeset_init_drm(ddev);
+	if (ret < 0)
+		goto error;
+
+	ret = component_bind_all(dev, ddev);
+	if (ret < 0)
+		goto error;
+
+	ret = rzg2l_du_modeset_init_finish(ddev);
+	if (ret < 0)
+		goto error_unbind;
+
+	ret = drm_dev_register(ddev, 0);
+	if (ret)
+		goto error_unbind;
+
+	drm_info(ddev, "Device %s probed with %u CRTCs\n",
+		 dev_name(dev), ddev->mode_config.num_crtc);
+
+	drm_client_setup(ddev, NULL);
+
+	return 0;
+
+error_unbind:
+	drm_kms_helper_poll_fini(ddev);
+	component_unbind_all(dev, ddev);
+error:
+	dev_set_drvdata(dev, NULL);
+	drm_dev_put(ddev);
+	return ret;
+}
+
+static void rzg2l_du_subsystem_unbind(struct device *dev)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+
+	drm_dev_unregister(ddev);
+	drm_atomic_helper_shutdown(ddev);
+	drm_kms_helper_poll_fini(ddev);
+
+	component_unbind_all(dev, ddev);
+
+	dev_set_drvdata(dev, NULL);
+	drm_dev_put(ddev);
+}
+
+static const struct component_master_ops rzg2l_du_subsystem_ops = {
+	.bind = rzg2l_du_subsystem_bind,
+	.unbind = rzg2l_du_subsystem_unbind,
+};
+
+static int rzg2l_du_subsystem_probe(struct platform_device *pdev)
+{
+	struct component_match *match = NULL;
+	struct device *dev = &pdev->dev;
+	unsigned int i;
+
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	/* Each ports entry references the ports node of a DU instance. */
+	for (i = 0; ; i++) {
+		struct device_node *ports;
+
+		ports = of_parse_phandle(dev->of_node, "ports", i);
+		if (!ports)
+			break;
+
+		if (of_device_is_available(ports->parent))
+			drm_of_component_match_add(dev, &match,
+						   component_compare_of,
+						   ports->parent);
+
+		of_node_put(ports);
+	}
+
+	if (IS_ERR(match))
+		return dev_err_probe(dev, PTR_ERR(match), "failed to build the component match\n");
+
+	if (!match)
+		return dev_err_probe(dev, -ENODEV, "no enabled DU instance in ports\n");
+
+	return component_master_add_with_match(dev, &rzg2l_du_subsystem_ops,
+					       match);
+}
+
+static void rzg2l_du_subsystem_remove(struct platform_device *pdev)
+{
+	component_master_del(&pdev->dev, &rzg2l_du_subsystem_ops);
+}
+
+static void rzg2l_du_subsystem_shutdown(struct platform_device *pdev)
+{
+	drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
+}
+
+static const struct of_device_id rzg2l_du_subsystem_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-display-subsystem" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rzg2l_du_subsystem_of_table);
+
+struct platform_driver rzg2l_du_subsystem_driver = {
+	.probe		= rzg2l_du_subsystem_probe,
+	.remove		= rzg2l_du_subsystem_remove,
+	.shutdown	= rzg2l_du_subsystem_shutdown,
+	.driver		= {
+		.name	= "rzg2l-du-subsystem",
+		.of_match_table = rzg2l_du_subsystem_of_table,
+	},
+};
-- 
2.54.0

