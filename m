Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4595606A320
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=rJ39A804
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7866112C32;
	Fri, 23 Oct 2026 16:50:42 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CEC710E6B1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9fTtuU/WIG+l3jOivogJu/Zg++tIpOzbWTajHbbiBwAoGuPbV5bHIDla4a5S53SVWXpIZtZvTZu33nGy5HaT8NEzW1ZmkoILRqBGGo8xC9ehqsojZ9jfxYFSN7+VD+d72AiJXMqKno8Y5rlTu4lHjPhCzh5O6WpsuDgZVvOOUaq7iIox+e6/of2spWEkIyWijrVBFiJIKbnRKwWrEcvaJpysaLRrUtfZbBrY0IasAunAJDIahzjxkBjW3pHNA8WVNa7NGmRqHKZOTXQGHk63Qjp0WZCLaDxrXPCEp35sHjQcivkqESsgUG+isvXGsCOV2wQBfC5w1LZ03hxXM3wZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4YCnV34eMVRzYcKryRCiIzZ+UdtWQXLosuHrMUZygw=;
 b=FDL2KalvhMFvp4hlsYSS5Mw5mvEWMp3T6R7wKWDJehVlM8zOvCMYXuPp5AExvydS13OeWXKwJWP8uFXivHe17nBTurXUy5dHkBIrYB4j+aYwrCB8JeA3/fNl9TlwZvrUK5m/OSaX/wmmBS7b5Fvf2TClLqSlMudqYmT8UlCBLSCb6dA5U4cUpTWcuSRdW5puoegSYigCWqgAWl9/fQqv7jn1kLZakFdg9I1Kd22o/2isDat2Yqe/DNu9lSB3xe7l1Wy8fe3qooiL523IkiJv778o70yCAk4DsRq4KY+8QU7XkhpNsbO48DH1LJfuBWYps0EiPMhhA9PuK7sygJgKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4YCnV34eMVRzYcKryRCiIzZ+UdtWQXLosuHrMUZygw=;
 b=rJ39A804CV0l/H3ejIdQay9TDGw2C2Wry69hNZpQSNqv3E0nj0q9DksyKDF7xfMN9uFde3KCGDZqZFSE0GluBqgrISw+L4ahVAik3YoulcKWof+wyuXB/lxW0YoVWCl9oSsNGk3dwx49Al3vukkDBB/q2Hu0rWXCWhhW/bcZfvU=
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
Subject: [PATCH v9 08/10] drm: renesas: rz-du: Share the encoder of an output
 driven by several DUs
Date: Fri, 23 Oct 2026 18:47:41 +0200
Message-ID: <986c6f3e0deeadac501c581231b8d1afdce2d5c3.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff466d01-5753-486c-7ec7-08df312598c9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: L5pryPOsFaateVmAaxsx29y3qFUhsgZekoMPbIayvEwyGeUHFj7gr8sdU4EPznjIUMWYVx+xal17JANZiOdd2TZZuK7WgqKDlizeQDQyCjTPo29GTs5omF0fxYWgl7px81XnC+Kuc4J7Z6rVILncQpQPbmhD2VwlqFGcYhvozhKi6g7NJWeuiV1vI9/zykEegJOT+RNMK4ejl2lOo/X2AGDT1ngdfVdRibZdZr9jaeyDYSCSc8xwcjYHTgPN3nTH8jETOTQRfLJyktLPXQqCEYRADdr8u304gMk3HxzS93VpQJqM3yBMEvLGVnSyuUcITHCWMykHyIKpFXCbG9sU2rZn3KkU1KUOAixcWHfhRoICXSvBxMqo6UYNQFHFWloDprb4wrQR9dMIc75xXd4Z634yW23KR5OYfqXfOvknUZsvJ2EMrptls7Q5ZNUxrxWXkLNv3weTwlaidMYhatZ64OkQVAqiLrSMpnnPUuw7clf743RD+Dr8UGRPYOiffwNYH6uDonI+zn8RrQCavo4d6A1BYI2SiSsBsnKIKW6E6aXrCXnKbZKsZPZ6exhgaKwo4kmoS+8Pg0IH8sMQYcENqLoz5Jy+odHeJYr/17sim7vf324JnvUrCmeNKqqmk0XozeD6WQUrXjVtR9Zu0PpeOihdhqI8YhdBG0y3HRCeDHukMEO+bYNiaK49R4VPSPyB02hgVR8ZMliEEECiTf2P3rLs7D0TqaxP47vk6aMMvIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCmGHNpuZnK/IPc46uVMAl6DMWv17wR5OgKpY4FOngvRmGUI+DJIfLbsaErE?=
 =?us-ascii?Q?mDkXDamobbh+kSib+mymkAI2vxGaK37gu62mWHyfuGSFQnPBSSIGym8xmZ8f?=
 =?us-ascii?Q?RfbU4hhyLVgs3VHA02o2DZMQ9+Vh67xj+h1UsR01V8JqMR+CFJLq87Okodpr?=
 =?us-ascii?Q?WWvnJLKIWKonfRYADKwChgR4WdIttInt3g5DjHVEi9VMYpuJxSUCUqxYC7Pv?=
 =?us-ascii?Q?VMY8oKSktqVIF1HAhHP26l+0n3CYyniNkKDKxV8mwqXV9uE+KpfsBC/FMug7?=
 =?us-ascii?Q?5rheBMz3AQWUK7rk4sfAggC7H3ugpkWdKtdRRCGZxCAZ2MtlF7xNyRMTghcS?=
 =?us-ascii?Q?D85NQ2BsZXVm8thxA8nTLfpSPI3nC0Mv+AH+Y1kSl5XxB6i9JwxrVxPaHsC3?=
 =?us-ascii?Q?YFWt3ISO6/xBJeLDBoHVPDkyJR3qNXjiA38Z6gxrIOIflt07DqlSzp1id7Qc?=
 =?us-ascii?Q?MWrTEbHHFgpGYUmG4sawZk5D7Gd1R7ViDVYxktB/CArkvCyzPc6VIODyPzLy?=
 =?us-ascii?Q?LcCjCjQAvD6iSc4LG3JRsvCXdF/4SpAdeiZEePZ7VUlh3jJzJKD03RVT1lqc?=
 =?us-ascii?Q?AJ8EuJE1XINhiqzl8wojlMGBTF2louYxl6Q1FsJerQNpDe2PhFuhdy1Xzu1X?=
 =?us-ascii?Q?X35zYFkjzXlOvwrgOf/LD4k+c93MyYlMPcv4KFNbzXegF5Gkauqv2TGnY+bU?=
 =?us-ascii?Q?AP4TFLeGZJWyDbZF4ReMxmfUIaFKf4ZSkCOTQ4gLNzVetlvfAEwk6VTjjJOl?=
 =?us-ascii?Q?4kUWBA1+kMR/O7mttTD/ZvHKcCwMZW1ooZnA2AV3lufweJggImcO4GU1Ry+C?=
 =?us-ascii?Q?G4ESO1lFpduzpNdhj2xmKiusNOgdpTakGSA4iH2nYbxnfY1mTUqXR/RrzrKx?=
 =?us-ascii?Q?Po8RJ7PjuHKVF5Zoo90q90d3TpLmdofTjXbguxP7ulf92x1NnyeYIQpWwmrI?=
 =?us-ascii?Q?r7CJz1t41QibaDN9g1GBXal9rA5NQMQ+jyy3nWQ6weeDH0p+1vgZB3fG1wAC?=
 =?us-ascii?Q?A53KKHef5rxBCzH74PlZ1OJtrrxKaLEKaqW1wFZ3x96OwXbxeM11VsMCO/Ox?=
 =?us-ascii?Q?BGuAAUdc+q3+jLB6ZX5bXNLcJlDOi6ShsT2l9xEbtCpoWWSur9Lbs4tVHSWz?=
 =?us-ascii?Q?aPOOE6owhM0beN5bchFvA5UELLDDtgSyy3WM5Ol65GfFu5czWTlxeYQwSe8F?=
 =?us-ascii?Q?zEZS5T6NlQ47DGI/DxL2edvaHuR8CzJIS8YWtKha9HPACpbVqHJXI4j5nqpY?=
 =?us-ascii?Q?0QrhAbGBEBv802uh+R66p97ClERvh3SZ7KoZ2WYn9zylOMNUnv7KKSGS0KUO?=
 =?us-ascii?Q?0KzfmusjnilLXA1EY70KKVyCKuCFT2zk0Zci+A5CuAa7KrjnEA4uhFrriv+5?=
 =?us-ascii?Q?LtpkzG5gdJHHAKNyi89cRTDNWVbbX9h0aaelYup5VBBbZmF1X3/eTE/oBhK2?=
 =?us-ascii?Q?XmxKXYTJwg65L9LYVZcmKpAQ03dJ/pJUl3jMtHvu5SKIzhBquMwzIpMeVLFB?=
 =?us-ascii?Q?Qf9wO1W3Z+qVrentNfFQAVskiQfFCj1VXI28QnUSmCVxrHsl/QpcZeEuuD8j?=
 =?us-ascii?Q?1v7QY+Tck1XF5E4Ng/+IyMPnYgjch7qj0UWrUUWc1BdyI02dZ4L3NhFSRu8/?=
 =?us-ascii?Q?M+kiz6WYdrA+kXjM/s/aHUz5YdN7QuZsgvd9ANGPH8kJZkkV9lSspNvxxbgv?=
 =?us-ascii?Q?d8pGuVTODM0rjoW1np5aIr32FHevJL9H2Y9tCl7CTL6rsrFFYoJykqU6i2Gs?=
 =?us-ascii?Q?VYNdjniwmInhAsZabochAg8qseomG1+2bQ6AHjMcn88KjhDyoQew?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff466d01-5753-486c-7ec7-08df312598c9
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:25.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FadCwsD9EDAEHH0qu/Lf7VDPwSeLuPZrmU9vn77T7N1hgciHTAK7+NVCCW9FAiSXNsaBn5srW+faGwLKBVCbk1LwOITPt6SoYrkXZz+kYtNugJW2xQwjkPCEGjeCrc/h
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

On a SoC with several DU instances an output can be reachable from more
than one of them, but a drm_bridge can only be attached to one encoder.

In preparation for supporting RZ/G3E, where the DSI and the LVDS channel
1 are reachable from both instances, let the first instance create the
encoder and the others add their CRTC to its possible_crtcs mask, which
rzg2l_du_modeset_init_finish() then extends rather than overwrites.

Without this the second drm_bridge_attach() fails with -EBUSY, leaving
behind the encoder allocated just before it.

SoCs with a single instance are unaffected, as no encoder is ever
already attached.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 12 ++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index 5c21c5f9fbaf..45f980ea3c20 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -129,6 +129,18 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 			return -EPROBE_DEFER;
 	}
 
+	/*
+	 * A bridge can only be attached to one encoder. If another DU instance
+	 * has already attached it, add this instance's CRTC to that encoder.
+	 */
+	if (bridge->dev == rcdu->ddev && bridge->encoder) {
+		const struct rzg2l_du_output_routing *route =
+			&rcdu->info->routes[output];
+
+		bridge->encoder->possible_crtcs |= route->possible_outputs << rcdu->index;
+		return 0;
+	}
+
 	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
 		enc_node, rzg2l_du_output_name(output));
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index cad378418b38..c20c0e0188ea 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -480,7 +480,7 @@ int rzg2l_du_modeset_init_finish(struct drm_device *dev)
 		const struct rzg2l_du_output_routing *route =
 			&renc->dev->info->routes[renc->output];
 
-		encoder->possible_crtcs = route->possible_outputs << renc->dev->index;
+		encoder->possible_crtcs |= route->possible_outputs << renc->dev->index;
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-- 
2.54.0

