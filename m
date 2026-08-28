Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D349CC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058C710E506;
	Fri, 28 Aug 2026 12:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vM17Lvyf";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5769110E506
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdKS9wBwqwLMOKKds70GXlMSvatK0HxIa5/gHKK/oezEFqZ5/wyalKxxuSjY+JuAcIky/lzNPcZqAE+EMhSf8LnMvd9FjTiiXL71VJ10PkWEacjdWsRmFSuxozvfceWPQGXueAek1Uc3g7cquLxhbUEVwgcvqOgAMQaObZLXUuk/G3xf4B0j23s+7COQif72uDbkGHNbNbdEYbayUMniY4rkagI0x/gUBQMb8LiopLNwSYKhyuxivy5OxZsgnUBmGHck7mPyQ1j+8v43a68+6QvOVcdog+0GjPfqkmoOuINf8dbxEt0nAR76wzFQR0semglwV1It7umkTwUkt7bg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRqT4nHMOxejs2GiKUJ4mr9vbgOaz6Y5O6rIDPN5wSY=;
 b=dLUrn0+VXAiHGhAjRGVhOHoSGSEzcoKzNcEDxa1bcmvZnAb2T1hbvaNTUyph9YWX6E+AmX7yxXtSI5XsDW0c3wzSFi9irwHs0cTd3/SG5E69jba4Sc+zKEUORAf1UO8xck3uLe5IEewHUIUHr14hjuipJv9LZ6mxLntzKcGaefyzNSP66HDwfa6ljM/OUs4l0ySSBIR2soD7Sm+e3xmXoikWM6+vUp1ClwBdYeAVRIei3RTueWuTjAzowFUAk4jVre2xDWAK4N/BbdNRTqKbtSsdbrntxSdLgPalwv9hLQQ9w0ayVlhULxkN7ZXsJBhqTujP3ikuYOpgEPRoA9fYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRqT4nHMOxejs2GiKUJ4mr9vbgOaz6Y5O6rIDPN5wSY=;
 b=vM17LvyfyAvlDihKKpj4V05xKbNTii9ZDc0vu/zW4EFmnYB29pVG2aHpZEQtZwm24OVq19uCRspJw8xKL1MyZJNa4cTd4IXGrOV/yS+mUkamkDE6wQJ4RCtE+U2sYQAZsdf02OmBLlff4WlXfWIMZboTlu7vAW7mplmljtcC9Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY6PR01MB17444.jpnprd01.prod.outlook.com (2603:1096:405:360::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:22:18 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 12:22:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
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
 Philipp Zabel <p.zabel@pengutronix.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/9] drm: renesas: rz-du: vsp: Keep the planes in the VSP
Date: Fri, 28 Aug 2026 14:21:07 +0200
Message-ID: <20260828122113.1426778-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260828122113.1426778-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY6PR01MB17444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f46e530-3332-4fa4-22ed-08df04ff0098
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info: smiquT9fzMYTo+i3YHvAlFpwTfWFdVMySarNAqac7XynJeK88Oo3ODFwfXhWkk7twbXEuOKlFsANaglqSdkhdNhWaz3TIK/2AoZqI37rWZoSMw/dyo8Qv66OloXlJ1mBnC5xkz9cuS7hA+OmEI7TGBeRkTKi9T6C5IIo407fMs/prLq0CxrfNDh+Q+2w4m8XSwyoueg/upXR8qvZMaGkzt5o+HcOonqhtAVzuG2k8xqV3li67fQI9T4m5gCnH6a+UIUIeFN19opDF7IAqAqnSdXNCoAZG5wLGD76l95ZrpvdNWbxmu7SZpOb8gSm7in5si3qT0KK8BXHxCzXxiuGS2oUplry/d/Zlte5lvzw9BDr3f2a9J7hvr0gtyxWa3U1JajeBP4ViCYs7ztJG6bkfAAh0ls8UvnNFbUX1eNzocqOS+oBcmn1SnahyLHE2jSBi3zHHONwSijZkEunwU4OLe39Gam/pWmLcGcQAk3Yg8Z1voEiGpn+6EOn6cenqqDLsA5w8RMhEmbiVUhNwMFdIln7PEdIB3h9BMwb3qtqQ0ziyKTPWfVAMwYth/O3/s2l8PpP2CiwYhl3xjRR92Pc1hYGport25yxJPwsv1dxo8DDzZuP897UecbDz730x0u1Qb0UoPLeDMJN4gQ+YN1xRy/PkxXGiQmP1fgOBGsNbyDhjE96PWmZTWWK98ve51FrqEb6BobS0wFrfv6ZAxFOYK6+95r9cHEwigD07rmae1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRtRrbcXVVo5N4gY5Rc5NmIohkTNuRZIlMJ1g2NT/mKZ2+aphAVz+0psL7vA?=
 =?us-ascii?Q?nWGD0Mqptqm6arDjRych0ZjSY0RFm82mugqqIehbSgoCew3eWRpmZTySDIIz?=
 =?us-ascii?Q?zk7wVwHCd4XDJ886kkkatUEkQZqmN6f0AGrU0R8y6Xz9Hm1NmxbY239r6lIo?=
 =?us-ascii?Q?gJr15VKYYNpfwmddZcjNHfgqsjpZxpvXCJUo6dMdrHdsveqnYJBkUz/2iYgK?=
 =?us-ascii?Q?2Sl+ahuyRRoEsUpQX+ShDcEYVwl91ZP5mlITwWtQ2HuMZNzl9acSRAirEs42?=
 =?us-ascii?Q?ql7caWJxssVgn24bLK7xCvoyIrqBA6AKKMs3JPv95nA5h3R1kPr9MSzEoXMg?=
 =?us-ascii?Q?zxUE56NfgBr+pIFKLYGyAbGwpPAMGYzKZtVYi62sfD3OQ3tLjzPQJVUvIX94?=
 =?us-ascii?Q?90DZHN7G9ms7Osw/PdJIndYglW1gd6NQ+0BbU20kUnipROrev/fmgwA8ZODH?=
 =?us-ascii?Q?bc0dckF0EGXYNW/HX8FIqrD24N/NL4cmz/rgIHpQsRq6fQXkpjgZdGrhqbIW?=
 =?us-ascii?Q?irDQm1eiknn3reEVGbXfiZeRo5hIKzxKr01Y1auU+vWBpe0qG1QSbu6timni?=
 =?us-ascii?Q?c/Gm9xcMMf0O9eGYBkQwjks1D8D9nvz+SB/OTSXXfkioz62xMEyoDrEvNzR7?=
 =?us-ascii?Q?1rOQ4IrQgcJeqzJKcFVZrnq5YmeIcu8/IGHN4Bum8RIwEcmXIEt8Awe3zSeg?=
 =?us-ascii?Q?TVB1plD4GJ99boAcCqEPNnzLu/kmjRox16QztU5JVYWOWC2qr6vHewJCfTqG?=
 =?us-ascii?Q?at1XuMyNN+ns2BfKXVtMTm8jU1fSfH5f7TH5Tpy9E8jQTT9wiCbXoOMSQ/Zy?=
 =?us-ascii?Q?/MhruP6xbCzJuareD2/FRZXAfJV1v2dCRkmBeFZ5nw9bf02wm0YBJP8iDX9e?=
 =?us-ascii?Q?Irk6d4mobO0SC3VI2FxK5ABXIMiDXPLeF/ZBEtVha8+mu3TsqPJ3y0qCt6UV?=
 =?us-ascii?Q?IXnk0Sqmtk1pnvC55gMYQAOyZpJk0L06Hf2unrpwgcvj3QVHQZYAP1+Lv4qj?=
 =?us-ascii?Q?fohjP1wD80rWp9Ws09wJ79JyNH1e4Jj0591sRY8sElaWfI7vC6rWadIgld0o?=
 =?us-ascii?Q?yCC0H7lWCqEgLDG9PLBvX9/DmroMVdzU73zGVOwLmcBNnDmlgDYwGALv1I41?=
 =?us-ascii?Q?jPIu+heTaXV/IkF//knDq5tvoJp9ynFzmS8ZjaBO79YMIDdkZRUu2jl8Rjid?=
 =?us-ascii?Q?AnfXAGcBIWPAVB6FndEBO1zUBdiENaAdqvFnbV38t7L4DT6JYetl5/mF1EkI?=
 =?us-ascii?Q?oJTsPTA2MTXIqeuqzG8UcGPE/UOpX24Jm5GKKHJaTkqm6YwmsRfT/OBTI4J5?=
 =?us-ascii?Q?fOY6Yu0KIUlTXBf1tkVYbjcgK1zikQeoG/2PEnUs34TEWDLn2Szmi060YMLM?=
 =?us-ascii?Q?ZZCZLfnk3fGZjEQ8hfQsD82eOeOu0KmRa2eS7jAsc4hY15RAqsCS77SYX0Z6?=
 =?us-ascii?Q?bf84cigrUm+BoByWxon9waRJ2tdor2Ei9IBK59cJvwbF+7s9Y736Zub4XoKG?=
 =?us-ascii?Q?XvQMiSWvOPIa4sh3vJwar0meE7/s3CTRJnT0Y328di+ANzDRUs/mgyznB0IG?=
 =?us-ascii?Q?hKDAlltQQw6akkAYYcaG8QYwOqoOjgsX4hOMemKQewIbSeLtZIA3Nrj8xqB9?=
 =?us-ascii?Q?aUyO0o29znJuoy/+z7PpMasB5vSv48FeTiKeMtxJvuntKLhIp9+AuAUQQ9hn?=
 =?us-ascii?Q?NHlneaiZ11OJSEmYXp3Zm8IAZTwfiltLezbUHq8Zb5i6fv2KUqZD6rqRuPD3?=
 =?us-ascii?Q?FeqCF1yr3S9EChAdsIDY0i5BJcU2SIY4snhKDL3KBz15ZVvQJWJp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f46e530-3332-4fa4-22ed-08df04ff0098
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:22:18.4087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5Wcoaz5r2ifBCRVzDDszYNSDiA6lpxt97tSK9eoMqdpXgoV1/GQWfAMADxd/nythrGZVLd0Na+ywWKuIbCGQEyeO6KCW9WsqSKfyH/j92+64x44tpxBULWGUV6gYAEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17444
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

Each VSP numbers its planes from zero, so the device-wide search in
rzg2l_du_vsp_get_drm_plane() picks the wrong plane as soon as a SoC has
more than one VSP: the primary plane of the second CRTC is looked up on
the first VSP, whose possible_crtcs mask does not cover that CRTC.

In preparation of supporting RZ/G3E, store the planes in the VSP that
owns them and index the per-VSP array directly from
rzg2l_du_crtc_create(). Validate the pipe index read from the device
tree, and drop the now unused search helper.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v7->v8
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 10 ++++++---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  | 21 ++++---------------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  | 11 ++++------
 3 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 5aecf325e89b..81934fcb551b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -420,9 +420,13 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu, unsigned int swindex,
 	init_waitqueue_head(&rcrtc->flip_wait);
 	rcrtc->dev = rcdu;
 
-	primary = rzg2l_du_vsp_get_drm_plane(rcrtc, rcrtc->vsp_pipe);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
+	if (rcrtc->vsp_pipe >= rcrtc->vsp->num_planes) {
+		dev_err(rcdu->dev, "invalid VSP pipe %u for DU%u\n",
+			rcrtc->vsp_pipe, hwindex);
+		return -EINVAL;
+	}
+
+	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
 
 	ret = drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
 					 &crtc_funcs_rz, NULL);
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index 1efa0f0451fe..b0565b88d841 100644
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
@@ -306,7 +290,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 	struct rzg2l_du_device *rcdu = vsp->dev;
 	struct platform_device *pdev;
 	unsigned int num_crtcs = hweight32(crtcs);
-	unsigned int num_planes = 2;
+	unsigned int num_planes = RZG2L_DU_VSP_MAX_PLANES;
 	unsigned int i;
 	int ret;
 
@@ -353,6 +337,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
 		plane->vsp = vsp;
 		plane->index = i;
+		vsp->planes[i] = plane;
 
 		drm_plane_helper_add(&plane->plane,
 				     &rzg2l_du_vsp_plane_helper_funcs);
@@ -365,6 +350,8 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 					BIT(DRM_MODE_BLEND_PIXEL_NONE) |
 					BIT(DRM_MODE_BLEND_PREMULTI) |
 					BIT(DRM_MODE_BLEND_COVERAGE));
+
+		vsp->num_planes++;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
index a22aaf0843ed..63f6e508264d 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
@@ -27,11 +27,15 @@ struct rzg2l_du_vsp_plane {
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
+	unsigned int num_planes;
 };
 
 static inline struct rzg2l_du_vsp_plane *to_rzg2l_vsp_plane(struct drm_plane *p)
@@ -62,8 +66,6 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc);
 void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc);
 void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc);
-struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
-					     unsigned int pipe_index);
 #else
 static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 				    unsigned int crtcs)
@@ -74,11 +76,6 @@ static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node
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

