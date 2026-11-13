Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E5606A891
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ubvi0HbH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0971123F4;
	Fri, 13 Nov 2026 12:21:14 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011027.outbound.protection.outlook.com [40.107.74.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C36510E78F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg4eMLWgIcK1oTdceajwBfIGcPNIME9VmiOPMHyny2s0kUdx8sFarD3tfxe4WgqS/yicQkwcjosu6/iYFx4V+S5yw6wyhblJ6l7d7s/0h+MvojTLI/OMxPqvhvvjnXKsRRj6DwNPHFgDyfnwEl2SSt1t7IJtgT5ICQEcjTxo0TEYHw6MavWeN2bc5dUg2teBzy04D0kPs+RskqYckGSBh1SVo05YR9qWRElPzQ3Tnx+Erpr/pNghD6i5zFKyMkWOPEHG2TFAh+NKytmAos7m/EgznSm98YxptHqUVgYmaUpjagHUuvHyU4fVrs6viSnl9Ny304wO6TaG/97xZ4ATUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXf2i7xYHaGDVubXQI+U7OOVWE6aIz3nmIlyb1yZpIk=;
 b=GFmArihMoJ7pKil5qaIFPy3sKTXDU5CO6n1lhTTUden/jR3CcJOdksjlGRlWcCEZLWlIUayM/vbSDNnuc2zY1e3sWP9jxApTksXv8naCaOGa9IMfGWlDxneGfd/vQnS0Iyk1DlObzcnHzWNSqdOcK5ghogoX6wTXXX+3ZsoKsVm55foC952DN+L+hUwRs1SVsUy3N7E4iavqAUjp0RJE2N6JNEhgKgxhcQI3yE7AfqqrzGkPdUkoeWVyAk2zNOjm6PuL9KNOKyh+8Cx9G1dwtCiOWu4oIu+qqQhDh5bRxlnQSkCwmNptalAcaFVzvvfHaZ52OxtyfLnKSTLJIp/VHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXf2i7xYHaGDVubXQI+U7OOVWE6aIz3nmIlyb1yZpIk=;
 b=Ubvi0HbH0j6euZTJ8P7JRrniD0jTjL4Um1H53aDhR9byZgIMCYLPEYcPW5tUfI742jatQYkcvrQMZfGqt3I0ACFvP6Y/jj1UCVnMuu7xHjaPZfJRKle3NxqvU6cWRb/N/dFbLKxLP0QUa4qjDc9w9jIwN/biYVa6lTrO2ZIsbKI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:01 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:00 +0000
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
Subject: [PATCH v10 03/12] drm: renesas: rz-du: Reference the DRM device by
 pointer
Date: Fri, 13 Nov 2026 13:19:59 +0100
Message-ID: <249e7d61f9ab39a9d4cbc8349fabdaf65899c9c9.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0a5356f-c099-45c6-e1ba-08df418093ec
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: G1h0hTf5ILO7S+vNCZO2CJSKQpnQxN6z9dBsqnZtA7uUwhBPXpoq8W90Vh4ncNPw90vWuo5oaOUqfNLHFOjUMqurHLxlO5hddK9zWz+PptYdKnNmm3iYA0wM797toj31gUkk//oL6amf1xLksHzIBOjuxJCKyO+y0rTMuHN4l+qsV6IelrhubBcQDa9ftmdvmRmxWla3jYp3sd70ys3ngUhQj5tHASekuWddC6nMsWyTRCPqnzDZs5CMLc3VEYZZtwCHAkbdQbvt2ThxAGiAVtQJXJB+Wci5L0rz+pGFZAi+EYWR5RmI2vlyevHxvGc439OEQ6NHf/X6qJVWp2TkFTAwOFVJYKWZzJPrJTRN4ZNE7Ru+Ya1PguCSCc+9yH8wuJPynyVsmZ368dFtcTcvA26Pj4eP3c5awOHocojYeguknKNtyxkwD2QtYJ/WND7jnPzMmzDAqo+xiMUsG8ddRsYz1UgTQfvueIL7yNTzuryGdtr9Z34AeZcwNYbuFVnBRuX9RIBGVBILacBkMUQsS9bRVlTBqTiEEofBNuqaDSD0xqrPt2CDXE9ZUpZw0dgqo2ZqM9Pm1gukKJs9/iXo/zzlZDknh5yLdxL9FtaT4fFp0Al9BAneO64ZNEDqGnOxaoLdloFyewUv8ZS/gxUu/6onypS1GIpaprS0eVhaG/Ywo+UVRGONA3gL7PeqZPj96zDeXM9B317Jth8hD4rsQ4zE62mhYDmetgmdA981U9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6befAJX0tkBTmN1or0hFmj/P0FzXa4nezYeKFkh+ahrCDo4bs/QH+DZ/jA/?=
 =?us-ascii?Q?XKqEtcYDd3wj0AnA78+kyyyPwlSm9QetEaPmvrIeE5h4jdKqje/rFnP63c1l?=
 =?us-ascii?Q?Zghc5M5WxymB9xoHo/qiXqoMDI86zFucnFWdxC2lzNMonVlk+yAyO7UaOe3C?=
 =?us-ascii?Q?PVrhFsLaQEaX+VV5j1P5guR1Y0PjazzkE7LrU88bbmMzG8Vvh3m9shPDBdpU?=
 =?us-ascii?Q?jM46mwJ9Fy+K2vNWsxCzDVp6KGrV4BInT+mEGKBEnT1ZEed9/T1WblTYAJ3y?=
 =?us-ascii?Q?rVrg6XeJGafKPOLiJ8A1HnUGf02BrhyeA9VpPtdSfB/3Xt9nzIf8g6ELlFeQ?=
 =?us-ascii?Q?wRdYWRSIAoSET9rro8oH7zGajmLsq/hn+0kg3IsX3pIZFoU5AzIPlpnuEYiL?=
 =?us-ascii?Q?Jw1QSt7WILSP45cRMb+KFvOu6CVPHxP/26LvatRECBwdfL3zeRQf69CT+B8s?=
 =?us-ascii?Q?2R+NNeoUsDGWEIQBhytbwovqHWU7/I5/J44Z7eCHDnxz934kq23uOO2dhCQ8?=
 =?us-ascii?Q?0zwYPrkEx2yyDZFb5O+uSBcmRZHzh66p3DSRaRvlIlTZhFVHoZq3FT9djGvG?=
 =?us-ascii?Q?2BQLQBfueqkD0mXjQxVLxbLdxiUFIYV69Y+5KYg1vI66ucZBTTE/UXQ9Mw1F?=
 =?us-ascii?Q?pWqczPS8yHu6Rck2jpv0YMxhGVNQbvmHapjF71KMk2tctb2Gg6OnZu8ieSya?=
 =?us-ascii?Q?BT7MzGYzPeUgWutB8uzp7BUckKhfRdd70Q9ejIKZjlIDzTluKt0cwNYIRmmZ?=
 =?us-ascii?Q?OLRvlGIYSOuHjH1xTDJDcY/6phev0amLY1wLc5NVzebrbOsPRppQVP1818Nl?=
 =?us-ascii?Q?hiRl1wupVz2cAtLdba6sZzU4Zk2I7qSez7jm3022OHhKZPUYzTm9jt72ZWbZ?=
 =?us-ascii?Q?IWkAauKARfznQUveTYVnL28BILbZo1BiQ1Eo0Wx1p5XiD1IeZKr3OWdOsSQ1?=
 =?us-ascii?Q?/A4tn/glABGxaO6B2wjWYCjKTMQm3T3B0B46X3xLv6KDWMYdk3GrzHQ1LZR4?=
 =?us-ascii?Q?QZyCo7GmEF88qEO/yQyZVBsRqY5yueLFbjdLLOvTws8/9o7xPtgQXQkHoI+u?=
 =?us-ascii?Q?pYKe9+8w2Rc34x0ARjiSi7oiAMSNB+pwvYEAttO1Dqfx2TQUtUK1WYrAta2w?=
 =?us-ascii?Q?/PxMimxDEBchBY72N3b4W9AeRmplPUb+7yZ+ErUId9QqaqzzgroaNRasqa+p?=
 =?us-ascii?Q?pCr5BsPCvhxtIyFOf713fwLLSJMbsa4lsb260L/fjnJxZOrcuitKnELsvDM4?=
 =?us-ascii?Q?M+TVa2W8PbbqumEobIwGgW5ZDkUPZ2mmoNXLiT+HbOpurKIff1W1OyL/83vx?=
 =?us-ascii?Q?CeYlJBGRjv3tVKY89eI8W00AvZAhZczFAbvLcsEjkElSCx9R49tvk/tijkCA?=
 =?us-ascii?Q?toXmVUp1UjbL+taD8SFcfgyKNK8N1IJbmP625omtaxoWqtCK3STrAXgXxsW6?=
 =?us-ascii?Q?HVNdSvI6Ap9luE3XmzWBPFJORaN6AKeaXACb+ncx1qAXbA5wmPsAgcGykl0W?=
 =?us-ascii?Q?LBYtlUfaCErjEXuHo8Bo/O1/i277DdbLGsHSWGcpV4BMVL5r3G+j2g94gblt?=
 =?us-ascii?Q?pihWQw6Q8XsQpHcMpeowy4Z34tUmzxYyaqlPvK1YQwZX090TGt2bZd/6sTSO?=
 =?us-ascii?Q?hAwRcWXDbjhS26gQIaKJN6IrQf7l5vsSEsjbNiWx13I40FJJEeHyLPAe7jWI?=
 =?us-ascii?Q?1FxFzqvWsqFsdPdFayxhcNNsVw04mrQ1B3cUbxefLAV7aE/oiiXfQoQZGtT5?=
 =?us-ascii?Q?KBZ7YUIhv6ZWTz7m0jAfry9SHTnBbEjNFKXVtVB7MyF8ehKjp0f3?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a5356f-c099-45c6-e1ba-08df418093ec
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:00.6257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcIcHNnxdD6KQ8xANjwSdEH2lNHL/LKKECfaU439S6oADEJ/lZIk+Ws17i3dKG3GEbK6kJLAPzs6EN5hpSgrmb8szlC4N2OH4Jo7IcXvxU6TyHvZkGUewBoTcjcMl74K
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

struct rzg2l_du_device embeds the DRM device, which makes a DU instance
and the DRM device one and the same. RZ/G3E has two instances that have
to share a single DRM device.

In preparation of supporting it, reference the DRM device by pointer and
give it a container of its own. The instance is allocated with the DRM
device rather than with the platform device, as the CRTC and VSP cleanup
handlers point into it and run once the DRM device is released.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - Rebased on top of [1], converted the PM ops too.
 - Kept rzg2l_du_device as platform drvdata, use rcdu->ddev.

v9->v10:
 - No changes just rebased.

v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 39 ++++++++++++-------
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  7 +---
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  8 ++--
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |  4 +-
 7 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index c57884ab5b9b..398532933013 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -411,7 +411,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 
 	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
 
-	ret = drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
+	ret = drmm_crtc_init_with_planes(rcdu->ddev, crtc, primary, NULL,
 					 &crtc_funcs_rz, NULL);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index c7d71dd9198e..57197356143f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -17,6 +17,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -148,14 +149,14 @@ static int rzg2l_du_pm_suspend(struct device *dev)
 {
 	struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
 
-	return drm_mode_config_helper_suspend(&rcdu->ddev);
+	return drm_mode_config_helper_suspend(rcdu->ddev);
 }
 
 static int rzg2l_du_pm_resume(struct device *dev)
 {
 	struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
 
-	return drm_mode_config_helper_resume(&rcdu->ddev);
+	return drm_mode_config_helper_resume(rcdu->ddev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
@@ -165,10 +166,14 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
  * Platform driver
  */
 
+struct rzg2l_du_drm {
+	struct drm_device ddev;
+};
+
 static void rzg2l_du_remove(struct platform_device *pdev)
 {
 	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
-	struct drm_device *ddev = &rcdu->ddev;
+	struct drm_device *ddev = rcdu->ddev;
 
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
@@ -180,28 +185,34 @@ static void rzg2l_du_shutdown(struct platform_device *pdev)
 {
 	struct rzg2l_du_device *rcdu = platform_get_drvdata(pdev);
 
-	drm_atomic_helper_shutdown(&rcdu->ddev);
+	drm_atomic_helper_shutdown(rcdu->ddev);
 }
 
 static int rzg2l_du_probe(struct platform_device *pdev)
 {
 	struct rzg2l_du_device *rcdu;
+	struct rzg2l_du_drm *rzgdrm;
 	int ret;
 
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
 	/* Allocate and initialize the RZ/G2L device structure. */
-	rcdu = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
-				  struct rzg2l_du_device, ddev);
-	if (IS_ERR(rcdu))
-		return PTR_ERR(rcdu);
+	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
+				    struct rzg2l_du_drm, ddev);
+	if (IS_ERR(rzgdrm))
+		return PTR_ERR(rzgdrm);
 
-	rcdu->dev = &pdev->dev;
-	rcdu->info = of_device_get_match_data(rcdu->dev);
+	rcdu = drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
+	if (!rcdu)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, rcdu);
 
+	rcdu->dev = &pdev->dev;
+	rcdu->info = of_device_get_match_data(rcdu->dev);
+	rcdu->ddev = &rzgdrm->ddev;
+
 	/* I/O resources */
 	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcdu->mmio))
@@ -228,18 +239,18 @@ static int rzg2l_du_probe(struct platform_device *pdev)
 	 * Register the DRM device with the core and the connectors with
 	 * sysfs.
 	 */
-	ret = drm_dev_register(&rcdu->ddev, 0);
+	ret = drm_dev_register(&rzgdrm->ddev, 0);
 	if (ret)
 		goto error;
 
-	drm_info(&rcdu->ddev, "Device %s probed\n", dev_name(&pdev->dev));
+	drm_info(&rzgdrm->ddev, "Device %s probed\n", dev_name(&pdev->dev));
 
-	drm_client_setup(&rcdu->ddev, NULL);
+	drm_client_setup(&rzgdrm->ddev, NULL);
 
 	return 0;
 
 error:
-	drm_kms_helper_poll_fini(&rcdu->ddev);
+	drm_kms_helper_poll_fini(&rzgdrm->ddev);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index e9626ef37cde..47ceaf892339 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -69,7 +69,7 @@ struct rzg2l_du_device {
 
 	void __iomem *mmio;
 
-	struct drm_device ddev;
+	struct drm_device *ddev;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
@@ -77,11 +77,6 @@ struct rzg2l_du_device {
 	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];
 };
 
-static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
-{
-	return container_of(dev, struct rzg2l_du_device, ddev);
-}
-
 static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
 				unsigned int feature)
 {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index a1b48973aa8e..5c21c5f9fbaf 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -52,8 +52,7 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
-	struct rzg2l_du_device *rcdu = to_rzg2l_du_device(renc->base.dev);
-	const struct rzg2l_du_device_info *info = rcdu->info;
+	const struct rzg2l_du_device_info *info = renc->dev->info;
 
 	if (renc->output != RZG2L_DU_OUTPUT_DPAD0)
 		return MODE_OK;
@@ -133,12 +132,13 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
 		enc_node, rzg2l_du_output_name(output));
 
-	renc = drmm_encoder_alloc(&rcdu->ddev, struct rzg2l_du_encoder, base,
+	renc = drmm_encoder_alloc(rcdu->ddev, struct rzg2l_du_encoder, base,
 				  &rzg2l_du_encoder_funcs, DRM_MODE_ENCODER_NONE,
 				  NULL);
 	if (IS_ERR(renc))
 		return PTR_ERR(renc);
 
+	renc->dev = rcdu;
 	renc->output = output;
 	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
 
@@ -153,7 +153,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 	}
 
 	/* Create the connector for the chain of bridges. */
-	connector = drm_bridge_connector_init(&rcdu->ddev, &renc->base);
+	connector = drm_bridge_connector_init(rcdu->ddev, &renc->base);
 	if (IS_ERR(connector)) {
 		dev_err(rcdu->dev,
 			"failed to created connector for output %s (%ld)\n",
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
index 3e430c1f6132..dfffcc14e0a3 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
@@ -17,6 +17,7 @@ struct rzg2l_du_device;
 
 struct rzg2l_du_encoder {
 	struct drm_encoder base;
+	struct rzg2l_du_device *dev;
 	enum rzg2l_du_output output;
 };
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 87f171145a23..13d14ecacba9 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -402,7 +402,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 
 int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 {
-	struct drm_device *dev = &rcdu->ddev;
+	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
 	unsigned int num_encoders;
 	int ret;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index 12fe35740c62..4df4f0ff0ed5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -298,7 +298,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 
 	vsp->vsp = &pdev->dev;
 
-	ret = drmm_add_action_or_reset(&rcdu->ddev, rzg2l_du_vsp_cleanup, vsp);
+	ret = drmm_add_action_or_reset(rcdu->ddev, rzg2l_du_vsp_cleanup, vsp);
 	if (ret < 0)
 		return ret;
 
@@ -324,7 +324,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
 					 : DRM_PLANE_TYPE_OVERLAY;
 		struct rzg2l_du_vsp_plane *plane;
 
-		plane = drmm_universal_plane_alloc(&rcdu->ddev, struct rzg2l_du_vsp_plane,
+		plane = drmm_universal_plane_alloc(rcdu->ddev, struct rzg2l_du_vsp_plane,
 						   plane, crtcs, &rzg2l_du_vsp_plane_funcs,
 						   rzg2l_du_vsp_formats,
 						   ARRAY_SIZE(rzg2l_du_vsp_formats),
-- 
2.54.0

