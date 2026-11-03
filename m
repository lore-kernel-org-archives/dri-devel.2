Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC45606A33B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MyUKH3NQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAFB10F38E;
	Tue,  3 Nov 2026 06:20:59 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3309E10E343
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqUIPFodO7AlfkO13yAG/eR/NoY1sa7jQaEaKlbFl0LCbN36hBc3zBKrpAiHFMyd9ZB9f9hA6w/alvRM2ZmaxIpjhtWXOz61zZ1LTt3U4MlrMsx3dofGPV/CcPSws6OaDOC/wTv60T9UGHzWqbWae4hheG7vaeX9+cyr9SUIMXmwmwuEtWiNwwbHGsG8Kf4pYkJr5iTzsPnbfXJigq6nVTi8ZF19kSTCYH7JglIWX4H+gwU9vtRwpEFFxu1i764g0Vx6aqrwJVm1uiYKEX6vegwr/Q2MaH5HrUSiH+CUbfJgLQncixdvFW1AbjM3qmxnqPnVk2iD+eKfriAAyzXYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko7FdkAMOQQHdb7qpDIPbQCiXsNJVxZaZbF5vtJYVcY=;
 b=yzXiyJS+Ybm8+etFSU88m6vSCHfFe4OYZ2od9I/jz+ZG3mukC1d61HcY8PchNpoAzYVRa0SXOazQ3xAP24lZEGx4UvzWjKObOgGltENJtDuhdf3xzUhPh4FwwaNuudVX+IrmMe4Tr8lwkytuAj1QTdJEU6CPhpssbr55xMG5g8NHpWKOK+r9Rh1pn7GJtL22e1Ko3HfTF474iXUoFEJEQBV5GlXmGhKaV46t7Z9b+cxPde17OMxMuXrkx20ElYeKc9L2cfv0p7kGWumgfZhMPLO1XFswQ19VvFd5OVmWLJ9tRnNydSlMi1RqQDyIvEbcUROlrFtbMpVGNJoGbM4WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7FdkAMOQQHdb7qpDIPbQCiXsNJVxZaZbF5vtJYVcY=;
 b=MyUKH3NQKDocu2BOC2h7zlAqLxAty7w3UqX9YXZy9IzLMOZBsAgrbjbMD8SUup2umwzp1RlIqRcU5oztw4L8FqE92vXepY+JMBX53b6Z1ysjBb7RL6oZMjoL2D7SdTb020tGNZX+fV/Jr9CTgNckNZRpPG/1ytrlfR2Qd876tY8DuK70ODZYrtAJCNRWULawsEL7HzkK18+xJAy6e/VoOH+spPgZ0UWm+qzQer4lddL9m0RVE3h7uKnkaAbuXZoluIrjpsnX47mIJXbYdB9xjDz+pnFX944FCk8Cnixj7gLL2U01UFhh8gAp8eCyQ6WU4WVO/y1WOiDO1SyJGTRX+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by BR0PR04MB346493.eurprd04.prod.outlook.com (2603:10a6:2c8:2d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:20:50 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:20:50 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:00 +0800
Subject: [PATCH v9 04/16] drm/imx: dc-kms: Use driver specific
 .atomic_commit_tail callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-4-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0312.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::14) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|BR0PR04MB346493:EE_
X-MS-Office365-Filtering-Correlation-Id: c7716527-1e5c-4c13-9603-08df39729b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: Kg3UqwhrlHI7ZUEmmEv7L0Y9KaEZfmkpIAss9c6i9mjcx5euAJKu8isIuwXbWScD3X9hEZFt014KeP2f7beN6GS6oZh2mwRpMnEJXq6nLPkWF1/Aw1r3ulGzTQnRaoXyvjvZmkjs52WnAL8h63C9ree9T6AGzrF922R3wWksNCMyLicmPlq7vRkDWHjNOkYYA0BVoDcA/sLrEPxYwsDK/f6E8uNo3fEXYZg9RYTI2ob1XexKGWWqiyozCuyF2/xNEAvTmXhjoGjBZtPZOlhIWhznd5tAfLGgEYYKMnJZjWUXxIZf6cb5XMWLEycQrBiOfr2kiY8FmCKi/sQSrCs4wbhWnNNdI+WoF4cotAfEaRgqbQDbWm72lyp6YHQfPrzyghjMl1La3ofo5i4eeHltea0rxGEpftNhyMILKNnbNms3Mc1i6Wtvx6pLGM+UKY8sf3X2itgoVcaRV7AU2j5ZNXbWf1oRWfquXiRcWKepJjmwh+Mcf5nwNWjuazjhOYlZrq9daH3D08pupwU2G+JOAAbIIfmqfKtBqJ5rF/Kty2v4uW7kG0L9h55EHNxB5am0El/5RrZDYS4zg4sCGt1BSIhH6V2N78ofqEpCViUodGdCDMCh6qPW18SnO59WBwYEwXiQgIz+BV6eabNPD3zodyM17sSw+S2+OTQWwIo97MGmGQ3sNJ4ilWUWmDlxZEfCwlTO7CFAyu5V9IGzqJfFLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andhTURWMU8zYzdtVW9rUHc3SDBLQUZjT3dhL2VqYnlId3FZeHRoWVRqOGRy?=
 =?utf-8?B?eWFoaDFNdUwwUDJINmFOYWxYalI5eks0QVcxd3JqeUR3MDVQeFR5UXg0VmZS?=
 =?utf-8?B?ZWxDbE5lSWlsdTExWW5qdjdUdnFKZC9pcStKOHltWEQ5MTFUeSs4cVVEYWxT?=
 =?utf-8?B?V05qUVRNQzZXT0RsL0JCY2pDVTJWMTFKTUtUbjVocEJJa3VQOWFLRHY5MCsv?=
 =?utf-8?B?V0RjNTd2elZrNEg4UFpqdFV2Tit3T05ZRkVJZ0V0RGhkOEdPdkc1OTRqcTU4?=
 =?utf-8?B?RFNTbmd0a3poMGJZT1dWRjJXenluYjM2NS9YSWlwdUpvNy84eFNzVXRzeGRu?=
 =?utf-8?B?NGJrM3ViNUkxdE9oRnNXRk9BdmFMS1dpS2NrMmhncmZqTHhGdE9vVDdoZ0ow?=
 =?utf-8?B?VXo3RWVCanRuNTJPYWRabmUzRmZhbXJiT1FiOGQ3dENxSGNkV0JvOHZjaGZx?=
 =?utf-8?B?Z3J5VVdva2RMVTU1ekFQOTVwTVpzb2lRNnpxNFkzS08xUEgzbnhkTFV2aXgw?=
 =?utf-8?B?ZXNNWkgxRlJNZk5ZVVM4a2pHWkZkeGJPOVI3aEYzWlp2SGRaQUloeVp1QVFV?=
 =?utf-8?B?VWRxWWE4OHNIVkM4TVJGajJLVklRVWg3QU1pK1ZwWEh1SlhJRXZuL0NNc3hq?=
 =?utf-8?B?akFORWJKTW4xZ2IzNk5vLzFBTmRRTGhpSzA2T3lKNG4wbXUrR3N0M2RLdHNZ?=
 =?utf-8?B?UWNWVFQ5L0I2LzdWaDh4Y0tKRjhxL25ZYldrcXZNWXF3SWxkQkQwVVJFeEFW?=
 =?utf-8?B?WUxBdzBobTBaY1NGNTQ4eTJNZExFci95cXltR040VWc4d1lGTmJ3RGQ4UnFU?=
 =?utf-8?B?bkl3cTdaQk1jbDU1TXRMa2JESWV0RU1OdjZ4TFNPSVJLdG5uRlk2T1lHRkFW?=
 =?utf-8?B?WFNJMnJYYlNZd3Q0SE9DeEZKaFE0RFdnTjdFeUZMRlo5TjlBbE5tT1pyNjQ0?=
 =?utf-8?B?YUtkeXk3SXJWaFRHTVpXYlFKOHdhVkk5OGg1UUxldzZzR0J4QkplNUI1YUVO?=
 =?utf-8?B?Vk9jTXlIckR2ZmNOSkN3Wm1jNTNLdlNTTUsvWkt3d1V3b3lER1FFbUI1R20w?=
 =?utf-8?B?d0hTV0RLY3B0Z1YzdERTMXRlNHlNWStWemdKK1RrNVd6WjIrMVd1S2hWU01W?=
 =?utf-8?B?ZHlhQk41cFBCWGVzV0h5UzRBWlhRU3NtNy90ZTRwSGpVLy9VWnVyREhTTjVK?=
 =?utf-8?B?cDB5QnpUS2k2SlkzY0NLc3JpZjhZdXdvakJxWEwwKzlsYkRVdmpzdVUxdE1q?=
 =?utf-8?B?SUFpRlcxbVBlRGkyZHFOSEpzdUtrVVRhbWhjSDlMSmp0a3E4ODVDemxadEhG?=
 =?utf-8?B?WDdWeW5Sb3JuNE5wb1RlR2tocENIWE1LeGlCQ0trSzVpSWs3NXp4cExINTFH?=
 =?utf-8?B?VVZTNFdFM05TWHI2Q0NqTHdaaTYvYzhFdXkwRjJXaEhTSStVcGlmL2EyZW1n?=
 =?utf-8?B?WXJ3VmMvcXRvUzk5OGZ4VWF2anlCYUlLRU1TTkZUb2xWYW0xaEovdUQ3K3hl?=
 =?utf-8?B?UUpxcExEclhhS2JoZmc5WEN5ZWliZFZnU0wzU0NFSlpUelJyaTRGTDNjRklv?=
 =?utf-8?B?RDB4ZjdsZlpKRXJraUMvQXFHNlhOL0tVVEZRMENXQVpRWGhiYktFVDJvS2Yw?=
 =?utf-8?B?dStmQ2psTTJiZWpWT1NlK3NPYSt3TjZYaWU1UytGUUhsSXhKMWdjQXJoWHk0?=
 =?utf-8?B?WXNKNGw5WTJ1ZEZtakVRYzI4ZWdqRW5vQVI4L1Zwdm5ZaUJpekhaNHlldWFP?=
 =?utf-8?B?Mk54NTBUelVXZExJRnM2ZTBNeVNZbDdjcWxNVHViZ0l5OWgyOVlOR2NqV0JF?=
 =?utf-8?B?aVFPTVZUNEJDYWVVV0RwRVNvWnMyYmJMYlliaCtDOWlaV1pVZEx5blR1bkdp?=
 =?utf-8?B?aEpCT2thdVd0SktUR2tYblo2dWtwMS9DYnBCWm1VNjhaR2tEcmpsOGFlb2dx?=
 =?utf-8?B?VkFqcWFCWERhR3FrZGphTUNUY0JVMDRUSDF6TDNlWlhxNy95Zm8yd3FRZ08z?=
 =?utf-8?B?T0ZnSlcyRnRJbXNGY2o4RzlxVmF2VlR5ZE5SYzA4d2taOXFsMTg0WWZOWkpL?=
 =?utf-8?B?NTFxcjA3dHJoWE9tZ2NpZ21VTjlqaER0RWk2QUdmQ0Z2Wkd4Q3BTWXU0N3VI?=
 =?utf-8?B?alMrNGhBaW5nNnB5OHU1bmRYZ1J5NEJ1bUlLL3ZBYTh5RlVVYW5aSWVUbUM4?=
 =?utf-8?B?d1ZTRXBQWDNEaTlQdkNEbUxoK3EzOG4wRTVmMmtycURKNXc5bHBWWFlIalE4?=
 =?utf-8?B?cXY1SDdxQzFua2RvOUtNcHZXZnF1WjRDeTBJclJJcjc0TEx3VGFoTGU3eXZl?=
 =?utf-8?B?ZHQvODMzcjBuWDJTVURTd1RRUUZvY0VlbCtjOHB3SkNZQWYyaTh4QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7716527-1e5c-4c13-9603-08df39729b75
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:20:50.8844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXlpi5tBE7/i4Vn6ik8sYnJ3s2Hf8ykCYdmSyVNSq/mja5v9lndgnnu6AHWJopCWZzJwKjk+vWNvhsbJgLDngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB346493
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

Currently, a CRTC can be disabled by a commit without considering
it's relevant plane's status(either enabled or disabled).  A problem
is that dc_crtc_atomic_disable() puts Pixel Engine and Display Engine's
runtime PMs, so dc_plane_atomic_update() or dc_plane_atomic_disable()
may access registers with AXI clock and CFG clock disabled.  To fix
this, specify .atomic_commit_tail callback(based on
drm_atomic_helper_commit_tail() without the unneeded
drm_atomic_helper_fake_vblank() function call) to add
DRM_PLANE_COMMIT_ACTIVE_ONLY and DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET
flags to drm_atomic_helper_commit_planes() function call's flags
argument so that .atomic_update and .atomic_disable callbacks in
dc_plane.c are skipped when necessary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Newly introduced.  (Sashiko AI bot)
---
 drivers/gpu/drm/imx/dc/dc-kms.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
index 0e2ce6a42548..9ffa15ac43a2 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.c
+++ b/drivers/gpu/drm/imx/dc/dc-kms.c
@@ -15,6 +15,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -30,6 +31,29 @@ static const struct drm_mode_config_funcs dc_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static void dc_drm_atomic_commit_tail(struct drm_atomic_commit *state)
+{
+	struct drm_device *dev = state->dev;
+
+	drm_atomic_helper_commit_modeset_disables(dev, state);
+
+	drm_atomic_helper_commit_planes(dev, state,
+					DRM_PLANE_COMMIT_ACTIVE_ONLY |
+					DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET);
+
+	drm_atomic_helper_commit_modeset_enables(dev, state);
+
+	drm_atomic_helper_commit_hw_done(state);
+
+	drm_atomic_helper_wait_for_vblanks(dev, state);
+
+	drm_atomic_helper_cleanup_planes(dev, state);
+}
+
+static const struct drm_mode_config_helper_funcs dc_drm_mode_config_helpers = {
+	.atomic_commit_tail = dc_drm_atomic_commit_tail,
+};
+
 static const struct drm_encoder_funcs dc_kms_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -103,6 +127,7 @@ int dc_kms_init(struct dc_drm_device *dc_drm)
 	drm->mode_config.max_width = 8192;
 	drm->mode_config.max_height = 8192;
 	drm->mode_config.funcs = &dc_drm_mode_config_funcs;
+	drm->mode_config.helper_private = &dc_drm_mode_config_helpers;
 
 	drm->vblank_disable_immediate = true;
 	drm->max_vblank_count = DC_FRAMEGEN_MAX_FRAME_INDEX;

-- 
2.43.0

