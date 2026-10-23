Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63B606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BHeE7Uf2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1054B112C0A;
	Fri, 23 Oct 2026 16:50:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D6810E6B1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSHY/jwQfCxt4qV2VxXLBo+Tn7RHY7RknsA/g1p6niif8PEeZjlHNJEXp/iFUSFQmXR7kbYZ31rpWQNgb6OhMkZzTrGP6tC4omEvIor7xo+jCRPW8ixc+39Y/jR2CCLyiID0cuu4LMd8oT9goWRRwqCHS2jGlqfBuZa/xZZzYEO0OjkXpq9wzRns7PVuGvxYBCxLvI8jZ9PHNHjWKDUgoSlwYS4SGVasbdJ/3T7AB/EcA9uM/ZqOmMCl9UNB4lw+TEwcj9Kc4m11DDAKK2HXVU8K78XyMOcQDEY92tp6zbN+l+F2IeeVv+JcCdB/Uz4/Q2u3tFmrOiIU9Ptmy78k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj86PYaBB6HQiushgSLvnwqArh7NqRhqZXhX0DUa+Ks=;
 b=Cnx5JlPNmuOD/MPbV3HR0y0cA58yhIxDmVMKx2Qhkdaeoszy+Xf5vKyv49iizSGfDMoCzcjg/pzFQ2MrCtRXxFOyChkTe1jkNuQw5o0G7iY99zNVE9RfopEx7fESWyM4xAmBX8QiVe3J4hFlLtNVPQqf8x4mZFlwDJkmeFkRCGCt7vllwrHRw0QKK/GvAFQUztGQOujhBcFPiEaIpBMKlsiyJszh9M2U1yKRWrUIFG8lzbj+fRYOdkGhxqCNIoHOUN6YWS+0B8Re80LTMkJbDpDb17YiDy+SB9sxLKk+wpPIbq9xrwhvBh1GSmnFnTcBhC8uxttcNjUiVpDvJeFYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj86PYaBB6HQiushgSLvnwqArh7NqRhqZXhX0DUa+Ks=;
 b=BHeE7Uf2OU/3xiu4MAKdV+fmtAL6BdZYrtNIsHlIVw51TI5ATeKZ3G/Tatdgi4834myKZqmCyRouzvuqpD6Mc1NVYXHGAnuOn6F8Mv6tN+gIH6fbS+VM7wGTmIkDCobxgpQVaGZydh0XTRzkEf4lNZH0T78eHlH1n0j0EUo1CIc=
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
Subject: [PATCH v9 06/10] drm: renesas: rz-du: Split the mode setting
 initialization
Date: Fri, 23 Oct 2026 18:47:39 +0200
Message-ID: <4a0b296dca776c6e5d584435fd6c4201d8f90ea4.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20c9384d-d583-4af9-acef-08df3125911e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: fEP62RGK/tAjoXkvoUY2kdsQBPxiF2oOtOOrjlYzajZP4LJUdcoCCt75wzezxWRJWzoimAT2FBTKVl2npqEMwL0sEhNcnZ26y8lDi39SHd9yvBniglLT36OcV771PVUv0RZabCnR62o6vB4ZfO5pUiD/5xFFatA+9zaQScBXMOyZ2uunaXcnNFgwz6dMu3mzezxaSbLgp18iJcqUKKNUesntMhQ4rFyA6/YqTDMNdBTOS5+1yhO46kTIbsnXR2oso8Jj2e9NEBcO0ILtTPU8gzMiK7kdd06Hhadm4buZT9v6i6lY77wv+yuoiLzrTslRamCJR6omfcPZ4DbEIhN1BGp22wGlFFGX0liYBTdI43w1JiYSxWOGkIdZnnjwOEQj/QEsVLInYE7up7REXI17fvHroDNhyXNStZkKeCKX3X1L0S+SijLgcU5rNyUbRfZ7oj7iMXIJIg/2UMRGUit3IBEYWhSNHlmpNehw8APEb0XRIcI12EE8ompTOYvV/iejeP+Ire5fitUc1q7nfBA3OwGv6PVp1telPEczgC+RpZoeAAD9CbI+EAsLIGTB4P4Nl0/22kWXHqD2HOEo3cLDU1yJcxTFrK/GIDlJTIdLWnHn6d87wguUxd+wstNvjdW04vn0VB0t6rtx39P0yeVBtaLqn0yTGi8IL3FSYeoDKKEJ3ZZL/1zCmxdjynmUJBkZdlNYq8crEMEXvbqjpG0akg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ne3g7Ky5YLgK1G7ZOKqQ1buo6dKRzTxEZdAblUWIRdo9zo+ZGydR4LmskdBR?=
 =?us-ascii?Q?jVhpOHmt6Sy4rzrNEpasS0BcrQinxEV4DWbjGZdSlzV611f8pSsl+qyiYwV5?=
 =?us-ascii?Q?ciQPQBrC+lgpXHuu2ieTWg2ba1e5dvGbL+LICjOqkvaMt23K91XoW4i0F7fB?=
 =?us-ascii?Q?a/56ya83zjJy5jcdMc0JWHqkf1ss/TOLSmTjMTGz5WJrhHPzPHfjs6c7Rt4d?=
 =?us-ascii?Q?71JPcevX4oeeeXpqlX8ZDXE1I8JyHtRzew8AUzfBSbrKovjGMoiqYaQR28QN?=
 =?us-ascii?Q?+slkTaPymce0Sa4W5SSLyvRqzGMyFc1wog16kwnFFrFzA1VEphrz6UrzDYUi?=
 =?us-ascii?Q?sPHMAhAFsUJjsgJBT7AqHhj9R0WDEdmrPdU7nfzybM6Zma+FbOSRvqwZkJie?=
 =?us-ascii?Q?k0Vtcn48dhfqy1B6eQGgCzxK/bkiyPruCgybQfE6T9ZmiFquiGpNZgJoohTS?=
 =?us-ascii?Q?nTE01ysIG13xNN8VW3BanLQ4FN7S+Ppf+IBJgVQ4JOvlAVJj6Ig1O8m2uxX/?=
 =?us-ascii?Q?BemVgzkuqqajaOXOGAgz2PXFsAJqwkltbw/uT9erNiTex3m+BSHfffngYFLq?=
 =?us-ascii?Q?cnUzCm/h6UOvRzmhZV/GG1KczQMXdX0VFMtnVCjipGs00FOtAhipElein6Y3?=
 =?us-ascii?Q?nRP2kpPRjp9sdKxWdAph9VFo7oRljL5nWJnLP26fAHADXIJVcyZB+5q6tirV?=
 =?us-ascii?Q?aKNlU0MOAmsqk0dKfcP7ahXMtzzdiAVqKpfdB187vEwvDKhMQkqiCjyztrkw?=
 =?us-ascii?Q?32jJ+bk/l5Fvu3yaT303Uc1w8YM1BgpSScWc+PcRMNyDJICbE8KVaG3b1/uC?=
 =?us-ascii?Q?1O/5Oq9prlcZ30C8ZIAGpaTs2KDBayCeajhXlUVZCt03ryszSiZ0/xC10+u/?=
 =?us-ascii?Q?rLljNY4OdbmiVmTZ4zUrLggZJI7QeGND0UaorHRIWMgX2tfxm+I//em2UyMC?=
 =?us-ascii?Q?t3Aj/3CisegcPnYJtUGm45s1H4GyVMVP4uv0vRlrvB/HbDPVquOOG6g3iVAS?=
 =?us-ascii?Q?+qwqGz4JAoBNLyo+UD/h0Ao5elxhzM6f+cyv1MSaGs9P3YUmSPUtMekybldk?=
 =?us-ascii?Q?9zf2pKNQfjncxtrLJsALo3eKhTAdvpJtfKxMpER7b9ufli/i6JdLCfVKrpJc?=
 =?us-ascii?Q?A9v/6y/rOtoINUSms8Zn60sQqsbNI1YY8dQN0yCIOcAEDhlRqzIaTSCJLBtY?=
 =?us-ascii?Q?jUlNFmPcK18YoSkNn0BbKFVpbGmkHbu9x6JJViyuH0IUqPeKr/+uy0Vjacts?=
 =?us-ascii?Q?f9kHyY07A0bLd5mFXdZnrt5wtx5z5Iq+q2VsIzI8HysYm/cqC5L8erTtFtPI?=
 =?us-ascii?Q?prKWnIxD5LAmxNl48Q9Xe5pJp5YOr4dg2R2ZUewMGJPOH2R8dbxSKgoIRVl7?=
 =?us-ascii?Q?xprow3hA37i7WXAYpSnccdMl5qxdbjJG2O77xWI5VWn2bfUFsqVWJ0O6N1Rt?=
 =?us-ascii?Q?W7RtypvphK4NJu1fFuUAqa//VvCqR5D0qfvjOqK0iA7ztbGtTzT9MPpoCulr?=
 =?us-ascii?Q?zo74mTteSEKAsCbTR7WMSJTlwfOQjTNeQKAdyu3J7UaPzOYguKwTFbEb/wKc?=
 =?us-ascii?Q?6h3KIXbAk9mPwjgEiCfIVD6dmcjLTyut2QTN8Isw5ygD6RbLlE/NXyJnuovU?=
 =?us-ascii?Q?2T2jABPh34Mz8L7KoyZGma33lxjazGQaK9+FazhQ73oMVd1mkJD4E4kckwiv?=
 =?us-ascii?Q?2MAcbJfwL+6hlrZnv2tqxqCrV1zQjfkb4wpq4hwgMYkV+EYf8rPqj/OwJrR5?=
 =?us-ascii?Q?OYPMAGbsOf7GCaS8KvrdbF1iTbgWugNJibLdUcoW111poAyOmEJ3?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c9384d-d583-4af9-acef-08df3125911e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:13.1815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBgXgeEVhZrNnQyeMi4QySlQnCz/vMbwaXxVzh/pVAyivL551qdo6XhbnSotlv1yr0eVn5j1ayMmbJQDlComTa6ixE55VU+9kIdh83G/OR69bqndWeME8GBlcMdsPfe9
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

rzg2l_du_modeset_init() initializes the mode configuration of the DRM
device and creates the KMS objects of the DU instance. On RZ/G3E two
instances share a DRM device, so the mode configuration is initialized
once while each instance creates its own KMS objects.

In preparation for supporting RZ/G3E SoC, split them into
rzg2l_du_modeset_init_drm(), rzg2l_du_modeset_init_du() and
rzg2l_du_modeset_init_finish(), the latter completing the DRM device
once all instances have created their KMS objects.
As it is no longer tied to an instance, take from the DRM device and
the encoders what used to be taken from the instance.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 54 +++++++++++++++-----
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h |  3 ++
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 6eb1865f43b4..287f3f9fe56f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -400,11 +400,8 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 	return ret;
 }
 
-int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
+int rzg2l_du_modeset_init_drm(struct drm_device *dev)
 {
-	struct drm_device *dev = rcdu->ddev;
-	struct drm_encoder *encoder;
-	unsigned int num_encoders;
 	int ret;
 
 	ret = drmm_mode_config_init(dev);
@@ -424,15 +421,14 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 	dev->mode_config.max_width = 1920;
 	dev->mode_config.max_height = 1920;
 
-	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
+	return 0;
+}
 
-	/*
-	 * Initialize vertical blanking interrupts handling. Start with vblank
-	 * disabled for all CRTCs.
-	 */
-	ret = drm_vblank_init(dev, rcdu->num_crtcs);
-	if (ret < 0)
-		return ret;
+int rzg2l_du_modeset_init_du(struct rzg2l_du_device *rcdu)
+{
+	int ret;
+
+	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
 
 	/* Initialize the compositors. */
 	ret = rzg2l_du_vsps_init(rcdu);
@@ -455,6 +451,23 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+int rzg2l_du_modeset_init_finish(struct drm_device *dev)
+{
+	struct drm_encoder *encoder;
+	unsigned int num_encoders;
+	int ret;
+
+	/*
+	 * Initialize vertical blanking interrupts handling. Start with vblank
+	 * disabled for all CRTCs.
+	 */
+	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
+	if (ret < 0)
+		return ret;
+
 	num_encoders = dev->mode_config.num_encoder;
 
 	/*
@@ -465,7 +478,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 		struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
 		const struct rzg2l_du_output_routing *route =
-			&rcdu->info->routes[renc->output];
+			&renc->dev->info->routes[renc->output];
 
 		encoder->possible_crtcs = route->possible_outputs;
 		encoder->possible_clones = (1 << num_encoders) - 1;
@@ -477,3 +490,18 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 
 	return 0;
 }
+
+int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
+{
+	int ret;
+
+	ret = rzg2l_du_modeset_init_drm(rcdu->ddev);
+	if (ret < 0)
+		return ret;
+
+	ret = rzg2l_du_modeset_init_du(rcdu);
+	if (ret < 0)
+		return ret;
+
+	return rzg2l_du_modeset_init_finish(rcdu->ddev);
+}
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
index e2c599f115c6..0de2582f6bcd 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
@@ -30,6 +30,9 @@ struct rzg2l_du_format_info {
 const struct rzg2l_du_format_info *rzg2l_du_format_info(u32 fourcc);
 
 int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu);
+int rzg2l_du_modeset_init_drm(struct drm_device *dev);
+int rzg2l_du_modeset_init_du(struct rzg2l_du_device *rcdu);
+int rzg2l_du_modeset_init_finish(struct drm_device *dev);
 
 int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
 			 struct drm_mode_create_dumb *args);
-- 
2.54.0

