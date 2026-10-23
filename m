Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F020606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=a5urtvw2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D9110E5BE;
	Fri, 23 Oct 2026 16:49:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3CF10E5BE
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJMPUw0YH3sKKp+J5+DHrY0zjaKhSepgWCyag5GUbnyrIHteHQo1yCpm9u1dKOLBGTP0o6WHLPGpjbpUkzdRjYgr0tC1kmjBLRy8i0msK8cCrce4qeAMsDxhJ5jYm12JHGgbgSt2IrqaSBGa6W5hjy20RWMEgGqgDzRQmuG/9wzJ1x0/zvTyxUcEjETLjMNwj5vIZx+duRozK9lxfEF/LpzmeV87VEpkSU8m36F3jIVURz/U9MdJAO+sLOOxzXRwk5my18Q4PVmmGuoXAihgUkV7whfT0Om4oDQL2Fy/J+RhLFoNFm9QSRU2MfVVWW5pTzstG9oN1hXr+ukV6M8y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vrS2pQ7GxmzBxm27FOL3q04HluxVbyJxTzVLGJYGjg=;
 b=MQtgH/2w75RclsVsLJK3M6mONuCE0NkcuJgYuR0iUVgxZart2ujeDP2dDXZYxH8PLW8Kto6dq52i26rGuCk1wqaGAAFFGOXFHNwnQhf16pe0vGhW76yiwSA8xzBze8s7ZepSnosiUhyjqFmhNXNJ5K55+o1j6uSF6tRe8nzvOD0KzM15fA9ILgd3uBmZZgMlXka/6wuSrc3oAFZb6SwICpPNr+FqcWjtJxtSDLzRNcwjc6t+/OJ39ho6a2x87hMrzAXcolJtaSMW6XiMQygXAjDKfllcsKm84ZNDUapQXbAbkQ7EFPeVZqdUG6ZF+UhWPPYc9SGRWpElCM90O1NXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vrS2pQ7GxmzBxm27FOL3q04HluxVbyJxTzVLGJYGjg=;
 b=a5urtvw2AQKD8naO8aYpZgi4VsCMypOOLto2yD0JUvCYKJBEo+PfaN0IwZDLUnYaXZ6xStv7tcUtZRLZy9Z3aH896CRZBnge0Jsu4Sew+Pln3IKf/FkBiJ5DiNHjU78rA/JrYF1CrzTM07uywew93QJ1JgtAEB+tWNbQaU9LWX4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:48:54 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:48:54 +0000
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
Subject: [PATCH v9 03/10] drm: renesas: rz-du: vsp: Keep the planes in the VSP
Date: Fri, 23 Oct 2026 18:47:36 +0200
Message-ID: <388b8b03fd6a955dd89d4b7326bdc22d6e3f44b4.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 009d49da-5946-434b-1f83-08df312585db
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|18002099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: N8a5ue41iMlVzIEx5tUQ54li4+I0wSNXAULUXAiNK+AWE/amJEViQKbbLtj3a85ljG/eM3h8Qo+2tzCyyVfDGPrjF18pHcysZDwBYRYS6/6m+almykgZKdp5HOf20Wsdl0R0E/JhScPeKC+9qgOHd7mYKo/LGs0CrdWlHZkGEjZhH1yHPQv82Vv3lgTP1zFYbMvWs283ZlC+Ijpk7YyMQ5BPeO04Z78lz38rb/QSGEBn1GNbUq4EhoQTQUDwyidwFErC8jlXr/fS7kXDQWdVboqbV4EUknPhWgk/kMn7YUNs8VhRmsjGzSSttlv5nvFqcs2YElFVmbtlIOyIOjpa1NYKhLxhq8Cx638iM7GQyXcXtlJgDxT2bPC+1txkmi36AEyJCs810Pwy5wuvm8IWLQ9V75zYMTMo+RaPhA+x4/r6lWxqFn1YU6Rx+JbCa1mbCf1FqSmMGr9q4D1AmUZRY/BkDsbuwq1wq6SDyjMmWvY+hoa5mxdYWPQcaLUzjAyPJixXnEef1cJfMVu27MUnPvyxdNATyTyJaAhZ1WL0qalw/gs2NtgODBlXYkqB+RBz8eTOr4sgv9fN6V7NJhUEBK3YDTSn3d/R+9lq9ilJChm18dDqf1aitfzl9GjMUPmyK9PL/6aIHgAwySIxxnWctwmZXKl5ClyaNN6w6LGP5A0cF3lLzBR6k6Zk9sKZxUGaARSxb/sLv6ioU/chfcZWbZj4i6yoZytoROtaKZKT1Xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9c3kzQ9pvZdkUK9JPJE29IfepHXV6F7Vs4Tc/xXo15hV1HzXwG8679QxRRj2?=
 =?us-ascii?Q?ou+18yYR0UcyGJkZTnkq4jjsgC+DZDPXOMXEW0HlBZz9OS5MAunTFTPx3dff?=
 =?us-ascii?Q?gy45Vi+/IKE7SsB9ujwbQ8zozKH2FNpgONbCUz9g3ouCSFkox8avhvk8hXir?=
 =?us-ascii?Q?2zsOJL7QgaDkP/Ve50gtr65wJ2EA/ch0FqxU49Vk46gXi/lxS7RYi5wXlosy?=
 =?us-ascii?Q?sgHq4Wy90Vtc22uUGxzuQbI1LlGvrVvCw89VMtt2FuReRi3bgzAGv7V5CWMb?=
 =?us-ascii?Q?Cpe3nGNOFE/wGviagwirxMtk9jxwi4gaPJwgg58scI4PEOYcdU0PuSh76vvB?=
 =?us-ascii?Q?9Rxx9XUpW4l1BWJkLxLsgPKy2J38ZBPTEeViQCztKgjBGq9wa1Bp608Twd0X?=
 =?us-ascii?Q?QhHiIObO7wih+3ZbYqC2OUXZS5YicHfuaaWQybs3AhKY09xJB06FIUjb1bZW?=
 =?us-ascii?Q?xq4uBGer5J+YWyzd+MboPuEoyfJ81x/eY5W0uBPkeVNdeQijnyMl38EOWLvl?=
 =?us-ascii?Q?aHFRWVPPMZrKRi0nhpgZayndxfdei7chuX6zVoF498y6wOo9spaA/pn4dQSg?=
 =?us-ascii?Q?ZxVk4XuCZMJmMW8GOllElDRJGHuCIFtEsDxt2ZPsNRTp0sWy5irQynDbdYPy?=
 =?us-ascii?Q?CdsXE5UutGBMhnjRt6M9cb0jVpqa4JNaLf/5N1Sre2gyGYjsGlC+WrgOuMH7?=
 =?us-ascii?Q?AI0dz12jPuBFi+fF6iDEFMRvMI6lK2vshcCrR1SFbFpBePQRB9oh6pyUnG5N?=
 =?us-ascii?Q?aURZwHOYd7AE4IRc17pYbDbl2E20uR9bJwteNLIFQ17/9HcqHk0KPrWH6+GE?=
 =?us-ascii?Q?QYqEoW2+p+lmCfOVzO2Csu0QOy54uU7wolzSlzcA9k9jZvXkcsQpNA5uUnc1?=
 =?us-ascii?Q?aZxE6NBt7pBxc50HlwXkQxtRyNhO2wYxC9/8dUkxl64eiUgceoRy5cDYSVLN?=
 =?us-ascii?Q?UR6z5RR692ViqzPp3b2Nv+tgfKMHAvseTqjAyKw8DoiuAwGf/543Fo4ygJAt?=
 =?us-ascii?Q?JAlRBJmWY1RGnbToY1TeB0YTeMM5qftV07F/3lXWOTQXAxlshLlCQIEnktYq?=
 =?us-ascii?Q?w2mwK6hfp91PuJy4rBH8PA3RjIdb036Q2+reFt1I4jR3PlUgFJadqslD+9Oa?=
 =?us-ascii?Q?BraRBYXvFoTH9iXTNHYuPiZb3HqBNTfLXYzvkeF6/xfeAnFgKU77EZy/fAdP?=
 =?us-ascii?Q?zYgN4M/+x8Cw262c3xSqNo30I4tkiHbnzqSWNZvsP+0npMtCAnHvCZarpXgX?=
 =?us-ascii?Q?/2lFDMZP8hvq3bDd+TcEd4LgBLCovSHD/V22wlwunIQW9IlkEk7ic+Yj4OXX?=
 =?us-ascii?Q?+pxtgKXFmTgePSF9Qi0duKlT7HPBepzRCjch/hi8bdnvEwpVm58K/xZHeFjT?=
 =?us-ascii?Q?+Ok8ZgC53VYrjEPC9/9g/NcDn1A3pwvDv6uHX+98EdMD2xHk2ZIg2xrkQ8M9?=
 =?us-ascii?Q?0ee1bvdkZ492OtPB2y3ltHfYy45WBlbUm83idAp8oQDmqoBrHhLl4u/OGDlO?=
 =?us-ascii?Q?+cIterTq+MOyAxTzcQB3H2DdZLw3B4ci1h3If0N6H+8YLChAsmVcKzvu0oUV?=
 =?us-ascii?Q?FeLF7YDEj8FuUD74q8Qjc/huLRdyLDjUHQ/bvlSI5a5iLtZ/GNjaCZdTEFgq?=
 =?us-ascii?Q?smwZTyzi/XVuTT0UophX1qso4NVKh4nxXaa3Qm/U3FenmHg5o6uGTZLqzAeO?=
 =?us-ascii?Q?mFrgRsA4FFdk2SWKRZI8meLw1y1Ldp7RIMF0/TB2khALoJFVaxIePszPYbZi?=
 =?us-ascii?Q?HFyodyQG2FhA0ETlR8id3RtRRi7c2pNpyoWVGtyE1Rl8oz2h/0vH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009d49da-5946-434b-1f83-08df312585db
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:48:54.0060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J/sDtWiaR+Rf4Qs4fKzL1V24n4LbGvUEaCfOUzSv56FZPDABEbqQfrhPYGn4LkOgrgHYhYhutgQVZMXUs9v1KbcrFpUZ3l7hxv/iP1wQc/UljQre7Dy0cMXVb2atPx7
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

Each VSP numbers its planes from zero, so the device-wide search in
rzg2l_du_vsp_get_drm_plane() picks the wrong plane as soon as a SoC has
more than one VSP: the primary plane of the second CRTC is looked up on
the first VSP, whose possible_crtcs mask does not cover that CRTC.

In preparation for supporting RZ/G3E, store the planes in the VSP that
owns them and index the per-VSP array directly from
rzg2l_du_crtc_create(), as the R-Car DU driver does, and drop the now
unused search helper.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - Dropped the vsp_pipe bounds check in rzg2l_du_crtc_create() and the
   now unused num_planes field, aligning with rcar_du_crtc_create().
 - Updated commit message accordingly.

v7->v8:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  4 +---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  | 19 ++-----------------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  | 10 +++-------
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index ab2f24cc7683..c57884ab5b9b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -409,9 +409,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 	init_waitqueue_head(&rcrtc->flip_wait);
 	rcrtc->dev = rcdu;
 
-	primary = rzg2l_du_vsp_get_drm_plane(rcrtc, rcrtc->vsp_pipe);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
+	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
 
 	ret = drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
 					 &crtc_funcs_rz, NULL);
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index 944bc9ac9589..12fe35740c62 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -71,22 +71,6 @@ void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
 	vsp1_du_atomic_flush(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
 }
 
-struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
-					     unsigned int pipe_index)
-{
-	struct rzg2l_du_device *rcdu = crtc->vsp->dev;
-	struct drm_plane *plane = NULL;
-
-	drm_for_each_plane(plane, &rcdu->ddev) {
-		struct rzg2l_du_vsp_plane *vsp_plane = to_rzg2l_vsp_plane(plane);
-
-		if (vsp_plane->index == pipe_index)
-			break;
-	}
-
-	return plane ? plane : ERR_PTR(-EINVAL);
-}
-
 static const u32 rzg2l_du_vsp_formats[] = {
 	DRM_FORMAT_RGB332,
 	DRM_FORMAT_ARGB4444,
@@ -303,7 +287,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 	struct rzg2l_du_device *rcdu = vsp->dev;
 	struct platform_device *pdev;
 	unsigned int num_crtcs = hweight32(crtcs);
-	unsigned int num_planes = 2;
+	unsigned int num_planes = RZG2L_DU_VSP_MAX_PLANES;
 	unsigned int i;
 	int ret;
 
@@ -350,6 +334,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
 		plane->vsp = vsp;
 		plane->index = i;
+		vsp->planes[i] = plane;
 
 		drm_plane_helper_add(&plane->plane,
 				     &rzg2l_du_vsp_plane_helper_funcs);
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
index a22aaf0843ed..acb41d343297 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
@@ -27,11 +27,14 @@ struct rzg2l_du_vsp_plane {
 	unsigned int index;
 };
 
+#define RZG2L_DU_VSP_MAX_PLANES		2
+
 struct rzg2l_du_vsp {
 	unsigned int index;
 	struct device *vsp;
 	struct device_link *link;
 	struct rzg2l_du_device *dev;
+	struct rzg2l_du_vsp_plane *planes[RZG2L_DU_VSP_MAX_PLANES];
 };
 
 static inline struct rzg2l_du_vsp_plane *to_rzg2l_vsp_plane(struct drm_plane *p)
@@ -62,8 +65,6 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc);
 void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc);
 void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc);
-struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
-					     unsigned int pipe_index);
 #else
 static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 				    unsigned int crtcs)
@@ -74,11 +75,6 @@ static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node
 static inline void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc) { };
 static inline void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc) { };
 static inline void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc) { };
-static inline struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
-							   unsigned int pipe_index)
-{
-	return ERR_PTR(-ENXIO);
-}
 #endif
 
 #endif /* __RZG2L_DU_VSP_H__ */
-- 
2.54.0

