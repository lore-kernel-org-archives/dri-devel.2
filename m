Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60697CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0D110E56E;
	Thu,  7 May 2026 09:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NXpThsJc";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010031.outbound.protection.outlook.com [52.101.229.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6819B10E56E
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyC//ksDYDH//tQIFe1Ysm5jJbMjqvruM8vHXvrEFsZboUsUbUJP8ET49eq2PxLwbFro+MT3HvLGQewlqwH0lh3Mjh/G+suwaWzPax71b+kjD+7Mo5k6DbJLmFa9cwjPOil62HD/Gk74sK0m+mV9FZAHbEUXmne7xSYoJA/paVSnxVn1Fp5FcL+M3TMooBpSAN7N5lejbYciBDMfdHuaNAvGySr9OThgQsTbXhhLhi0RSLMDBVKKsOsesgSVQKMtcQNgXMhuDGOCXtZWogXD3P52qE0/6vBCtH2v8iPpbrUyxRXxoWwPuL9afxyphbhYk07LHdpxUMZRfIJl/e7kIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVEXUbAcLd/wgp5EAPQHD9zb3xmGBIzlXvH7wmWbl7I=;
 b=No44NFysjkiZtM4WKka8DaKd3twegiy1aB2w5tBCnl55OTmxNj5RWzfVkhMPsY3q3KUkl+A34ScIQBn8dR8qH+j08m7VSyt9vOfWo4OiXsr571E79E6YQCCukUs5NtShWXmkwA09N443zHJadjTDxTPa+rnzPIuZYwVDjhEVIEegWm33woH+kcCdlspb0nj68ntjbCvirNqr8MHCQypZw/jsK80zzPJ8zPEK/rGgBy/NFIOYbnAJgzigWZdkIFVECHkZYnmdZ9OCdKHbXT0EKL1wIss2MZ0YVvbDx3EcQpzKMWdFRZgxS2UDXcBZjIa0wb9rzep+ZBV7tiB9Ul7saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVEXUbAcLd/wgp5EAPQHD9zb3xmGBIzlXvH7wmWbl7I=;
 b=NXpThsJcOOfirw5TZPC5U12cjVoMMC0dPJrQMD38lNUB6r75j7U/O26sO5YurA/xlu2X/H1Q3jyiDQHmBBGLgVHO1ilsWM9KVFcdzqcYHMZNveGPLcDvm1Rqc1OCJQQAcnigd7u0Oyq9Qck8wa+yutwDmTwTJHVau5a9zjNOckY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB13787.jpnprd01.prod.outlook.com (2603:1096:405:1fc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:22:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 09:22:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/13] drm: renesas: rz-du: Add RZ/G3E support
Date: Thu,  7 May 2026 11:21:28 +0200
Message-ID: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB13787:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b37796-f2d6-47e8-6029-08deac1a210b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: G4+eI88OF/4sNwPlCgTMG1sDny3oVFS/D6bvibkBc6MfUjLyJFgg3gcJN8meaD3wA38lSWuhm2sCqD0MwUoXLCTvKNhq8Bewr34lkPK83mMCVKJWmrc+t2FQS6pnkXoIYGIeSpvFAD+qTmQBF8E2+6enJ77z2y1MrRAXn4SAfq+q9i4cuebiYr63hvkSXniQNU3S0TQmoD1wYU39PR6ff74njdlhPxqvYh9YVmZu/hma73TrwSNWv9S4/+r363YcSAgqQkFLlzksiLdg86ffSNCfD3xXDkpaWR7TFkWLhcAQM0WFyJjS8g1rkDVgutmWKt8mvM7C5IWVrMTuMsLNbJTeB8AyC6YU5Lq+hoJXe+YnC95j/lmYwmtMMl9618FxYEU/RbpO0MN6sPb3xop3vv6agxa8s2GVM3KIEHaHUDvJQ4hRdRcXTgGY8UAqHAhC5zMkx0CYBmbEH2Vrp1PeSS5CEEklrXsttajcBlBZvJn/H3Znk3crLFCyTsyRrfpClwvr1d9zjhhZMNeFIwRDJ3kjGzRL1zTgRJzTGyOSnEDQckO9XDFL71IrKsrA3krOMm2qox0G6lmeimb4a/PqC5aNzebqCHIt746RQQnaUKC0r5rYIlAqWjul+zQrd63rzkmyDD0dhNye+GVr5nxErfzf0dZrG6FauEfN8AXk7a/RJousGkDpx16j99PIqYfkCeGXUxrrrR3CyujsfpTqBh+9lHUKAoeXuX1vLcmJ67Eb+DadIv+SmRYzooNRAXk9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(3023799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUDgyf75/srM+jj6gZmlfaeT+ftQr1CwwXQusV6Fv57PicY3fj0+MNFLktFL?=
 =?us-ascii?Q?+5uo2ihKXrptYqyZ5msZPeAMiQWCWdAvoWZT7KpULsWZ/5ffx3NmMoo4oYMZ?=
 =?us-ascii?Q?D1DojvkcPieVI6PNFxbDtr47lUQ/tlCDgq1K5AqZ8wmJ6ILtoNX1re2iaIX4?=
 =?us-ascii?Q?YahtPGOJLML7kobJI+EzNjpvXD+8YcRhrj/59qmV9PreGN24WzMl6Vm+BeZk?=
 =?us-ascii?Q?9f/LuuOySjxdUJwG8pwxjEGB+GnVl8BG+EKcRxI79Pkx7npAusrpduJIaNlk?=
 =?us-ascii?Q?Vcu3KHxu7r/5o2YjJjSROj4HgsH0bjXcASD4UMY6qkG68ISo/MHPaIO3b7ZX?=
 =?us-ascii?Q?acC6HYlpJTTFAXxrEjGqO1w7KJyZIGA2wv/8kNqN6814XDbfx3ykaWK+GH+C?=
 =?us-ascii?Q?XEWQpt4AeXVRydHft67sELuDdnIszGNXHFkC3MHXTSAV/Wrlp3qe5qaqy9qS?=
 =?us-ascii?Q?vqr9rBhzBsXeVdEI8M49CuoBU481DYkSKDSI/0+truuHcpsW3p5nBZ8OIaV1?=
 =?us-ascii?Q?CjEnEIRDexTltWnOo9FtYZqzEsFH3h0OVdweV6LtcKENrOxx+6RTIcLYM57F?=
 =?us-ascii?Q?thDI7K1Ro+1mpoOmOYYM44xrDVMnR1fheL6BVtUM/XudYozVsTheIBGF9KMr?=
 =?us-ascii?Q?CrzGQb5yc7ViLCzqmmuYmL+daOtxbnUL8rZfShNS6UVooAXGS5kbhhCt1udX?=
 =?us-ascii?Q?dzUrLakMAARZIQUIqaTMrnBRWbevxtSnYrCF7tWcAP8cm8ai5w1h+GguPBL5?=
 =?us-ascii?Q?VNi17UY8T+7E2YxNjFcMDpWTrV8GoQX6YlJTbchPpcTa/CuqOJ7Ur0Xqg6kF?=
 =?us-ascii?Q?tEw4y9yTKvxHdLETEBtijYqWkPvL3cC0QMwsQrkKJipvVJz/oBOodkLZOtLy?=
 =?us-ascii?Q?kxIHFIUpULzS1Z9WoiBpZmtBXoQeF/tp1orIDYOFhMUlfbnmLSNQjgvAOoG0?=
 =?us-ascii?Q?pTBZMdomqdJlLWixLtqWzFCIqrgnF8StC+od/V6nkW6oW6RNLdgAUzPkJdXn?=
 =?us-ascii?Q?F7h5CYrfB9Sezw5azzEbKAGrQrLiUnhsBWR91yOBvhbNVy569QySy8nNevKe?=
 =?us-ascii?Q?lV9NGJFAtf9xJtM1pUUmvWPH6RUj5TfeoaELYGUBiqSwydGrwm+Te5GBQr1p?=
 =?us-ascii?Q?TpIUr0pC8TFETfRcRYVBKrtsAemRr4br28kXsIPtc2q1GBgVxxT9OtJT5tDk?=
 =?us-ascii?Q?feP5ZM40NNKiZAx8514qV/3PQs5iBraC1Pzs0BRzdiOyJ+0m2aWdHYJYQ2QG?=
 =?us-ascii?Q?534MliNeDoadiQfpHJ+gX+WUiWTlxNlKEOl0EXMzYuiD5pRQThnlB3ld9ZoR?=
 =?us-ascii?Q?qX0jDNsIiOAYKu8Gavlq+OQhLtuPTssbs0vW9HV3UraxMfyvYlU2aIt+HWTE?=
 =?us-ascii?Q?pWLyWQNxsJ0cOPTcepjfjIca+RzL0RrOYe9zWuLVxM2rtc5drRnhz6DANQqm?=
 =?us-ascii?Q?9E8qBIem19FFr9JG80FqIYn+iiT1021FoL8AppsoXse3wPuut2Ib8CnCIl2a?=
 =?us-ascii?Q?qLWLxMi2qlIr3EB4srEK9pmAIa9GMGQwjSDObsmc2qhTaeGZxYPwDjx4IiaZ?=
 =?us-ascii?Q?SvpAxbCjx5Ntko/Fb78b6bv1M7keS3NtQP693VrrJtWoyFCcdBf3pkrVLSzd?=
 =?us-ascii?Q?/Fi/i9v63RoWGHleGaCWVlOt86Xh40c9x2iEnWgR3BaieUGODjMZz73sDUnn?=
 =?us-ascii?Q?2L7EwzQmUri0KRZJJ8Kyijc45P7jYT9bCKQ2wg+LuFZ8i7ovdvb06Pn8HUqh?=
 =?us-ascii?Q?JU+smuwNZrXNKywTLw9jR7qWm/wJzgstyBoBKSjNde1SAe2+PAc6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b37796-f2d6-47e8-6029-08deac1a210b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:22:16.1387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtSG8+1+dJHx7ZbplRZKoEY4pSY5RHHVA/adhSZRotZPDXP6AH504y3TqNrYFNbx6tJbR0lxNqnmjsqi3kJ9JcEo98ujVYWOrkE6Wk7+CAdbrl2kjDImFh7pO3C2Os2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13787
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

Dear All,

This patch series adds DU/DRM support for the 2 Display Units (DUs) interface
found on the Renesas RZ/G3E SoC.

RZ/G3E SoC has 2 LCD controller (LCDC0 and LCDC1), both are composed
of Frame Compression Processor (FCPVD), Video Signal Processor (VSPD),
and Display Unit (DU).

LCDC0 is connected to LVDS (single or dual channel) and DSI.
LCDC1 is connected to LVDS (single ch), DSI, and GPIO (Parallel I/F).

This apply on top of [1]

[1] https://lore.kernel.org/all/20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Thanks & Regards,
Tommaso

v6->v7:
 - Rebased on top of next-20260605
 - Splitted the original series into smaller chunks for easy review and easy
   merging. The original series is available here:
   http://lore.kernel.org/all/cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com/
 - PATCH 01/13: Collected LPinchart tag. Removed wrong fixes tag.
 - PATCH 02/13: Rebased on top of [1]. Use single DRM device aggregating
   both DU instances (1 DU dt node), modelling single port for each DU0,
   DU1 and multiple endpoints for outputs.
 - PATCH 12/13: Removed feature flag usage, rebased on top of T2H/N2H LCDC series [1]
   Reworked commit body as now outputs routing is based on endpoint id
   instead of port number. Fixed rzg2l_du_r9a09g047_info instead of
   rzg2l_du_r9a09g047_du_info.
   Added bump of RZG2L_DU_MAX_CRTCS and RZG2L_DU_MAX_VSPS to 2.


Tommaso Merciai (13):
  dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
  dt-bindings: display: renesas,rzg2l-du: Add support for RZ/G3E SoC
  drm: renesas: rz-du: Move mmio from rzg2l_du_device to rzg2l_du_crtc
  drm: renesas: rz-du: crtc: Introduce rzg2l_du_crtc_clk_get()
  reset: Add devm_reset_control_get_optional_shared_by_index()
  drm: renesas: rz-du: crtc: Parameterize rzg2l_du_crtc_create() with
    hw/sw index
  drm: renesas: rz-du: kms: Enable multi CRTC creation
  drm: renesas: rz-du: Add endpoint-based output routing
  drm: renesas: rz-du: Narrow active channels to DT-connected outputs
  drm: renesas: rz-du: Skip disabled endpoint nodes in encoder init
  drm: renesas: rz-du: Add multi-VSP instance support in plane selection
  drm: renesas: rz-du: Add RZ/G3E support
  drm: renesas: rz-du: Update output routing comment to reflect all
    supported outputs

 .../bindings/display/renesas,rzg2l-du.yaml    | 135 +++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 109 ++++++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.h |   7 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  33 +++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  21 ++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 144 +++++++++++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   3 +-
 include/linux/reset.h                         |  18 +++
 8 files changed, 410 insertions(+), 60 deletions(-)

-- 
2.54.0

