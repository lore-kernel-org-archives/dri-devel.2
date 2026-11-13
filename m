Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE606A8B2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JDBYNMk6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BFB10F944;
	Fri, 13 Nov 2026 12:21:35 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F8F10F944
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB1+F2D6g3QUAyTh3AoAZyjVxPnIHqMOAfQuQoQ7btrOuHvo+umAoQXHSpu3KLX7tgMR9QKDSfiOpOEvzzSg53vGO+4NrOOiM+at4rn5bvTO3+3c6jw2hQWGGnY1wSjFX/JDQaloA6p6x0TFJ0upZXsH/Qw3PH9J7dB0akGJMr+efq083EeeGZotAgfrVApTKgQa7hh9crqs77wCjKhvzkSLQ/IzRcvEF2W64by7uO2H8T1pu5ozfHIXc1POIcaFVY+0LwNRSuyqWE3Zh7RWI9ZuZ4Lj3IjnwmbpPdtGiiwhpAxGQvZ6nJaLjAoaTWdxgDSx0rfw5HcYcOf6Mp3wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWy1idYsbBEtAF3S3g6yQCWM9u5eMcKUV3zDK/gra9I=;
 b=SHNRp+QceL8o0uEjV2aLdT2xxC0SN4OodNGbEgIKgkUXGY9qKILoe8sd8+m/uDR3lKmDca09AxzVyLkpmFofY6u28TppN02gTiWl+KcKwqNAQ4fNk2GDXiu/mtBUwvngQIojprg0GSkMOSIwVu845Wko9P0GfWCYTChYmsCWaVZkxxP3SkC1Klhli1OPXsNnK0fx1rUQgTkjs8ilDjZ2WQOBF2fzQo+ECg/N3tbT4eqlqjI8/uMURejZUjgYxPHemoHDXrXWpBvB7ba/D1tQ4/tbvlYhZ0iYJjUaPV/jWnrHAfEPvi7iiZCGzmQs3MLwoYstUFz1VRm6An9vmnP1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWy1idYsbBEtAF3S3g6yQCWM9u5eMcKUV3zDK/gra9I=;
 b=JDBYNMk6xsSlpsY9Y04IGizz/iTH112zvXk/jO2s2OQPNNaD5hEOgysP7W60m4puLgzYVp8svkRJy+zZQmitWCEYM2fxBCdUi14g8IT1nX3HD1/EnrNILFXWEolLOREeGFbFnq8cPpMOe0HG6pi5aiG9ckmOwMBvZm6qtm8MKk8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:28 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:28 +0000
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
Subject: [PATCH v10 07/12] drm: renesas: rz-du: Share the encoder of an output
 driven by several DUs
Date: Fri, 13 Nov 2026 13:20:03 +0100
Message-ID: <1d149f50391e48dd64355473309fb610ef1c17bf.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c626f29-9750-4224-2cf7-08df4180a472
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: AUM3VTVJRzmqW0O+b0GhHh4kwRIr+dIguyckUZsnSRV/8dVu51ldAP5XnZdcW2cW2CFLWXv3F48D0ZHrIz0wCY4wCLeGBHrM6HvyWVjTvHawCn7BkaeAvpqftpoeqxXgemtW9AmtGmOtSxWzcMV3ClSIQ+sxjNjy8ohOVcv18MvuLyGe4mz4+CPQ7yTGLM/LLQWY7Yc8Pp762ZGdBFbGKRyDpPth6P+Rgf7dYm0wWfO7PpuCJcAXlj6DexCiiW5FHcj0VS5ksVnPJtAzwjOmreyaYC5pX+9+GntNoFeQ/ZHN37QQBAO1rlZROGcQt5yL6qEUkOqye1nnpDmCl4+uaIY4kVcj1HTVRT887cCbTRy+24NrXIadtvgeoo8kQjkxMdP1CUbWjAhJu5QtbdhuLWuWGbXrZHflwqKL90UeDF9sCS5OroHIykP/Tf1JJ900rO2JOx02AniYGza3A8M+oMY9yzldKf5MWHnZ113UH8DfpCUO0tLgOCqkzX+JOlPmr48iS0X7L38p7L1jafrs9RoX82kApViZ/ggbSIbOC5jpgwD/kQ0w3ZGrLCwRcIwMVg3uvFYLrgP+uxn5eF/bW9WFbfR0MpO0+80SnQtuzwB/pixVXmtCP+K7fjQD+/E0jCC4NmlvGcVd86s5tlUiFb75YFdKh8RY/J3oHM5ii+a/GeVw+qqcRAlalMugmSVGw+QM5qTiabQNa4CCr/ErEY6kg3izI2W64M3ky3U4jNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJnH3sn2YrNa7VntJ90DdsENN771rgQVFbqpFolEh7SCSoR7o6cNjC/uXMel?=
 =?us-ascii?Q?4ih59oPv/XOF22uLbPLkkM4sNk/rY15YGtiV0ce53NbBMuYjwkzix4v1kZ8z?=
 =?us-ascii?Q?47wxi+XQ1fvM/dFo7i0n75L4+KQWMde0C1q+R2sUgjJZAnc33IzKChlOTLar?=
 =?us-ascii?Q?TwH1wbcKAdlai9qA9v+/c1BpsCQbh61HlXR0WJgt0ED33DHZ/oKvhueldjH6?=
 =?us-ascii?Q?259wd5elxo5k9zdWaCpyYu6ezaOXepEg4I5SAWF+RrwCBYrcANlN/Xk7hqVS?=
 =?us-ascii?Q?dU865apVBVr9+ts3Yqg1x009ic7qKh9abh5YXvDWi6AKXjcRrujBy0IUnnXO?=
 =?us-ascii?Q?cj96DjcFG8ZNJSEG76jWioJe/ozi3AMcPlcFA0j8UqlKS6a6QBFLVEjwxfPD?=
 =?us-ascii?Q?tQOdxXs658EdcatDBTdMaGXsAqN8mFV2v2/s9CZ/5ssMs3HU1VULoiQY555R?=
 =?us-ascii?Q?gUwE38AmDL8k8RPAbt7xc2l2UExwPM1BZAg4b1KJwrqIRk9RehJ2zKmpMVS7?=
 =?us-ascii?Q?U7TsfQj1O/vjdJrxvoiCTgihP0fnwc7DQJzBZ1CaPcPAtub0bxPJA5CFEy8W?=
 =?us-ascii?Q?v5FHmYMpAUIrns7SeR7O4GrSNZF0QFyBq54Z9fZ+lV/fzc76OzigFLnaCEcy?=
 =?us-ascii?Q?DJzcdEwq7lF3cFevqILcEBiGaTn5G5jnSzpzzX/eJDYiWW7vo9Lr9/IE67n9?=
 =?us-ascii?Q?HGxqhOvnZhW/ufPN73pf/xmrdgg3VrUbr6QZU6RaMFe5SZpBuJIGF8W9Ylud?=
 =?us-ascii?Q?h33/zPd7+VAek7OMMNttXa11iNPOtWYv9pM35T7FV35BfS6binM0Eh6UVux1?=
 =?us-ascii?Q?7uWTWZ7vT/WL5RlVwfws1g7cNmyb9rqWmQPpiF7zCF+X54L/kT62RoFPLxKK?=
 =?us-ascii?Q?xnLBrwfWHNjPGj+pW4uV05Sg81vbZ7/BRzpZa11KyxDsvwl8+jw55WqvmBJi?=
 =?us-ascii?Q?x7qR+u67kW70KV406dx8f2fO40lFA5oJOfJRTAjYQ1fOJtaJsVSsfVG9VmPa?=
 =?us-ascii?Q?efRaNFo6m3eMTMJXcwcStevOLzSF91l5GmGb6kHn9f35WIpx9S3kfRjKXxUs?=
 =?us-ascii?Q?BG2P6FR/Z1INcdYum4UZ/Xey1DQTDHfEpu2w1rcTd3rfgv2dtvtjxX8t9pMO?=
 =?us-ascii?Q?gj/+a4ZtiqQFZWqVRjzgkgACf0bBTqqRwxrD6APJVFkPB3EsyQ+zomlKUXLf?=
 =?us-ascii?Q?GJMPx9bpC/7vBFgZFTExAilSiRhd/QfBFFLw/w9nibrIvpsp4jZa3E0Z8SjI?=
 =?us-ascii?Q?Frg1VrLM8mFx+l1HkWtIYtNNMEIOEkxJ5H5NeU3Z5YjdzsXe+LHn/3zFM11P?=
 =?us-ascii?Q?qEj2B8a6fRnV+ZZ3Pvb5w+MEBF/KoeBHW+CYd37wq/wVWqs/7LU5Sv8yjCZT?=
 =?us-ascii?Q?SMSfqqJlnHje8XdYXRSmD8ysfvfyIg6Y55hyZWMGtD7YWtQRC/OE5vnlHvIH?=
 =?us-ascii?Q?fnkAAvjPypguvm1b42souFeUqcisfEa30JiJ4kD04APYUHBFJ2JjpsFgwtGm?=
 =?us-ascii?Q?wuoFgL41wmM1gGW1MGf8n6ZnLxVGqjnOFarmgQZIUJBUZ3CVfY5n6zB2VMVF?=
 =?us-ascii?Q?9PU2V+uMjyTUCVGUcGhnmRaFqzlJuovL7qWnQxYUTGR3dEBFReA46VVva9r7?=
 =?us-ascii?Q?BQbgo7DFHLAEi7C0GO4SHKSJbML8b+PviS4t+a6YK+emrHQ6PX4YblRN+bDR?=
 =?us-ascii?Q?2zzWTFOt/kWnYI+nONyEtETOwPSEH8pO3kvOrOqLDDyK8U5gPa3DRA2dj8TE?=
 =?us-ascii?Q?IvXaVPE3kxS9YrNSBTLlvo/RBaET+CM+n620vswrwWH2lHgb7YFx?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c626f29-9750-4224-2cf7-08df4180a472
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:28.3440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrnBGEF/rgfGrmY63cfhP7Lqp7AG7gWZuctIs0AgfnJSunxBZpMORcuhW7uSFw0UmkiXWp0m8J7pCqunQWyb7+lZ7/OxdPS2OvhnHtiarfnLDGupiepPnS3el5hqa0EV
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
v9->v10:
 - No changes.

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
index 456b29538db9..001c802539e7 100644
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

