Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF3606A8B2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Aq+J2cmW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD6710E7E8;
	Fri, 13 Nov 2026 12:21:24 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D1D10E7C2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUue3FkjmgYJExYxDtc0dKivSP3RGbSRLDklC8vgRdCzX3gwIkjtf0YhQdsx2bGb5hhWUx3PI50m/1zoGviloXgzoyo+CrSzBt8OvoAvMN2RU7l0lRVMua5G+rK+SsPaE1pZGFHe/1nzi7lSh3Ppw0FZPl+sdxkf4Eu4j37216gnrLR+GV5SEIubJ/6DO26gk5a5hBsxn4uqipa4zJxftnysrCuiQOvCuhzAZIlAydfDgj9JhkggUR+7fIYjurP+e8iv+bCNz08y2PWBS8fkhMPd4oR3Iu4L9Aa8qq29K8dyQ8fcB3Hj6ZkymO//qQikQU7JEQ9TTgsUsDN9gRYZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiOm048ozQCdwldH3pPwiWLPXPPspdna+ekG+xExv64=;
 b=WSIk1U+WxAH962xp2/GpflGeoPreNxPE3t3TVFdFMBx5XbmHaujFxozZcOqwrz+tpF9CyJQE/MScPjTh8b8NwNHABXTB8yeXwRH3mpnoXSNfiVC5qzuWGbS4+LrUjAoBngF0hRDu+aHSGp/L93xojohkGKKmpCNcSzHNjEqMrCdDil7TdxFgKnNPSmr9XAroTeKb1Pg74xZlhawoAQmPvMAsG154CiiIKvogmV6xuI6fPdigNx3VyA0I32pa3n21Jw7FowkZvzkZg9o3A76rr6ZP5X0LcdhStwi6KbN9xAcko1tkXE7GSVmYJAF8UF3O8qxE6vPvrDaU761Ho22Ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiOm048ozQCdwldH3pPwiWLPXPPspdna+ekG+xExv64=;
 b=Aq+J2cmW4XnttvBsDvR4xo3l8aJoPGON7ohWCytkk0kv0zT4kHgVlXuxLQN4shY8xCd3hkx6UcI8XIK7YVCBjqUcrXJ9+0XEicD5ciBKY6EpDfnfCZb8Sxy8dQYGx9FCMuf8S/IYwCYsF4IoFHuCnMlMtCTS38zsXb5zYHXB0/c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:14 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:14 +0000
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
Subject: [PATCH v10 05/12] drm: renesas: rz-du: Split the mode setting
 initialization
Date: Fri, 13 Nov 2026 13:20:01 +0100
Message-ID: <8aa3956e7c5934ee8a44c9db718955e12ceef4c2.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::21) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB14799:EE_
X-MS-Office365-Filtering-Correlation-Id: aabbb95e-cfef-4eb9-3d2c-08df41809c40
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: mz7diYZBYB5IDjLQAgIpHLV59OjjBJ1x476+Dm4swBmrixvL8kjJk2pDSxaCKoyT1MXu0usV7fZFzHpDhDuBU6D0qnXzvxUGqoilvbsdeI44HRSe0wZf0cqkY1D/0q2gPRLbs+23Kcpz7TCDcBdA9zA/ueImPINWGseWDTPcjf03Kka+18Aegttm1FU5C8FRrwHWGcag0Lmm8C4gricTBiEuIHvwIXAxoOiLstn5fTAh9ukgBcP8GIxmN8OZIPvrOUig4xmnXabeYV+T89IDCUi1b4WZ3vI9k2WD+1CXrK/b7gvCUK0Xt3+ZHxmPbMqUryL90On61jOtMtbLDc8vxgeOSm0wbOShxYVL4JmqHqocfZIoBeK1AwSyadf5fW12BU5yUO0q1ABgqG53OqjvmJvyjBTYF0F+6Z9nPx5NnS6M9/74XJrEpC8yvZzdRbhA0RivJs2yRojsJe2Jny9Vxt91IIZ+YTOmDC+9J9Dq5SWEjBns13P4OiuhWrNGZDefwQL4NU3G9qYrwgpMis+HnJS4pHc+ZgKZKE++BVWkMpAARnaZaxv7Q9HLdDoEL6OYxuFCYOZPre/nWA/v6aVv9+44a6YPH9r3jRNXhDO+wg/26mUfVbNTN2KbTvDRvbwcW0gB0kdwpnDTPhUMpriNTKbCJKeQ0W3gtHLmXI90TXP5ra450mFZ3U4nyDm4KQDAG4dyO2/QlHRO8e5nQXUzbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEKiDu7Mks/kEODrcMrk6af7VzLjLmZfAoNyiA1t0JV5wsZbZACXbd//vmYh?=
 =?us-ascii?Q?JNTl/K30ZqQQ/St+OAjx9QV80GDoS63zUyPGIRgyonIg7CtjOPUjRJeCKWHc?=
 =?us-ascii?Q?LQ4uWTNvx77D0rfFYpgm8eR5+mRwWS1mdSOp7JYnTl9dLzi73gLZ3x6LaVDQ?=
 =?us-ascii?Q?BUAEXR/pnmN7mXKMIt8MDiLmwAqrXk2IWe65NJx3yoEomK4DnRiPkYfDp/NF?=
 =?us-ascii?Q?XZVzGb64REZ0SaKr+aEnVmUTiBSW5qnuiDmKdff1wG5X0d9X/y/dxN8DTZmU?=
 =?us-ascii?Q?BtYWsA6dDqDB+R5Uzd/3iSnLs7gSkhleLdZ4ZnEhgskjPOYPaeokAd3X68Wx?=
 =?us-ascii?Q?M4j9bpkVefCxjVThZI6aNFksHG/bOQZ06vxXj9P8KizOwylE7+qkphu6Apix?=
 =?us-ascii?Q?hk4oT/Zity90RX0G/yF8lnwppPQiChEqEnQSiOe/CjdTjbtVS9wmyoncjq+3?=
 =?us-ascii?Q?IBQZ1OaQtxAF0ZyZiEvtRUVBMElD44op4uet1O3tZESQ9sA4lMbETGTkxBIl?=
 =?us-ascii?Q?+86bKXw3JKlARl/nWH1AvOl4H8UiIPNKUZ5PYNBWM6IIuzR9oCy4uGi7p0na?=
 =?us-ascii?Q?BXiAKCe2c30viiARbSIU9XDpQuErONiJqUYBpZyHOG8fHGj9i2l2FqmrukQl?=
 =?us-ascii?Q?Rkck2q6sGNADW8rnKf6Kk6tmpqAvxGYdVjC1JqtCOTYAfswK1VVfaTym2SYB?=
 =?us-ascii?Q?mU91I8xhUgq5RCd4q4MKuTvo8Qcv8uTUX5lsEgNtMX5TLsNnBkJ7qHJJ+G3E?=
 =?us-ascii?Q?a0CDj8s+0C+UDCipdoNTiSXhyQWW28xVkWwY6Kp9CBiVHRnL8suvk7csaliw?=
 =?us-ascii?Q?Y0MsO70cYb2FqRcolt9DvALMvx3bLCDCmBt1UHHKUtWxv7zBScQo8cgaYGDx?=
 =?us-ascii?Q?nJbM11hZl4b8gLgYcRFkzkN+csTOqXn96nJgFohcYu6qO1/5d2lmuWBqcy1I?=
 =?us-ascii?Q?qkeFY8+aJlFkfY85YgwRE/FGkZcSXqIPhmY6cFuPkXW/zbCQ7xqbXjZN7n06?=
 =?us-ascii?Q?uMMaQe3p4LN+X/Prn2n3t5+6eja59nTg1Oj69F1/A4bo0Ifas3xZnPhaxl0N?=
 =?us-ascii?Q?4RoBeyXcgZO/DPytRWtQBpDv2OFb6FtqGWPGcFQUeIBZ91A0LI8YEB4oqZhq?=
 =?us-ascii?Q?UayCQ3nNi3yTDZC6WjOi382SpThI63VW/uelHk67NYdcyJEXKvPRBOXw5TKt?=
 =?us-ascii?Q?oF0ifUlAyLavcthr7c79uc687ldQ3kXbkctXqpu4swVkMx096N1PjHCiHyQ1?=
 =?us-ascii?Q?bZBkhOpUvIMl1ZyNUJw60G4iJfgyZdb3+8ZYdHYvmOaIA8YZnlHDsc2GpdLx?=
 =?us-ascii?Q?BJnFNES8ESzpDmgBZzgN8Mc8W49yFuf9qJfM0DKtNrdFDE+4HNLfhZizsf2Y?=
 =?us-ascii?Q?tqRehTkIBFY+Er4z3tvoAwW+RaT678sfp802qqlZ4Q9tD1ubLANyn2XWcq5N?=
 =?us-ascii?Q?w4K8zx++ZVHytQma70OQWPkdkxhP/mLipxCEgNn/yWeqYYBf9lyQYP0OcsV4?=
 =?us-ascii?Q?H+pnqDUtasDhTo4VTTahqaSFksjqaWmGFx3RrBIQrMpjONjtO6w2CI6WuTB/?=
 =?us-ascii?Q?Wd4Uwkwvs5Aw4rM0Cyt1pPt4QiRXHSAsnE4xZZTjUXJV3m2IQYnW7q0PWH3L?=
 =?us-ascii?Q?wnPAoctClBEV0aBfbHWopUh+3Syze5uHDu1CcPi5kIGPlWO+ToAccg2f2FM4?=
 =?us-ascii?Q?JsGuHSdNjuPx2N5fzhM2c1HABVQd3S9rxL1OU5ABsVmP/ekWlVaYokBYNuBA?=
 =?us-ascii?Q?uIBHxVh9FIxmAj4/w6MLq0ggt4NjvMy2vqKHj7rOgsIUtBhyElKp?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabbb95e-cfef-4eb9-3d2c-08df41809c40
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:14.3607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOf71T1V6dNGkdv0aX/sMUDl/otpDUjBMKLMqoFeBKow2PVNkawDtLzUx3BxC+FfgxJD/vaFvcNswfqdUVBNtmb+i9+hApc2/sY0nSSovsvjKzNedT+sbFl077U/HT5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14799
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
once all instances have created their KMS objects, and call them from
the probe function.
As it is no longer tied to an instance, take from the DRM device and
the encoders what used to be taken from the instance.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - Dropped rzg2l_du_modeset_init(), call the helpers from probe.
 - Updated commit body accordingly.

v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 32 ++++++++++------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 39 +++++++++++++-------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h |  4 +-
 3 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 57197356143f..d3cccbdf9012 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -223,17 +223,17 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 		return ret;
 
 	/* DRM/KMS objects */
-	ret = rzg2l_du_modeset_init(rcdu);
-	if (ret < 0) {
-		/*
-		 * Don't use dev_err_probe(), as it would overwrite the probe
-		 * deferral reason recorded in rzg2l_du_modeset_init().
-		 */
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to initialize DRM/KMS (%d)\n", ret);
+	ret = rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
+	if (ret < 0)
 		goto error;
-	}
+
+	ret = rzg2l_du_modeset_init_du(rcdu);
+	if (ret < 0)
+		goto error;
+
+	ret = rzg2l_du_modeset_init_finish(&rzgdrm->ddev);
+	if (ret < 0)
+		goto error_fini;
 
 	/*
 	 * Register the DRM device with the core and the connectors with
@@ -241,7 +241,7 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	 */
 	ret = drm_dev_register(&rzgdrm->ddev, 0);
 	if (ret)
-		goto error;
+		goto error_fini;
 
 	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
 
@@ -249,8 +249,16 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 
 	return 0;
 
-error:
+error_fini:
 	drm_kms_helper_poll_fini(&rzgdrm->ddev);
+error:
+	/*
+	 * Don't use dev_err_probe(), as it would overwrite the probe deferral
+	 * reason recorded while initializing the DRM/KMS objects.
+	 */
+	if (ret != -EPROBE_DEFER)
+		dev_err(&pdev->dev, "failed to initialize DRM/KMS (%d)\n", ret);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 6eb1865f43b4..73cb3199f90f 100644
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
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
index e2c599f115c6..98627a6de4c4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
@@ -29,7 +29,9 @@ struct rzg2l_du_format_info {
 
 const struct rzg2l_du_format_info *rzg2l_du_format_info(u32 fourcc);
 
-int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu);
+int rzg2l_du_modeset_init_drm(struct drm_device *dev);
+int rzg2l_du_modeset_init_du(struct rzg2l_du_device *rcdu);
+int rzg2l_du_modeset_init_finish(struct drm_device *dev);
 
 int rzg2l_du_dumb_create(struct drm_file *file, struct drm_device *dev,
 			 struct drm_mode_create_dumb *args);
-- 
2.54.0

