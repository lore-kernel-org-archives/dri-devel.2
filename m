Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D3CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AFD10F001;
	Thu,  7 May 2026 09:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vULdYZlq";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011054.outbound.protection.outlook.com [40.107.74.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31CDF10F001
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdLPBokZzedaYJDyEoP7CsIyP8wz7nHkvsGjo2+Hrm9+EjwF3qvMHUpwik8gaD2BYeS/dYdhP7E6V9nPUrE7h8BcJhKHjLc06a8QRQ3xpl72woDDrs0IuAkc2wMzfbsydV9dNApJLgYwfDE1wiNYqZxEt/QD+DrDfIEuKRlL2xdSDXaD4TdERWpr2aYZI1RaC90jaCjB1JspCtSo4iZo5S7E5Whqz0yFK9687ES35TNCaaZgooHLDmpAuxjqed2XxMPrN1XZMkn2CMFXquj6HCq+2k3VFsHaFA9xX/xnA0bU7trNwt6icrfzFZdzQx2fnmdPgu/jIya/4mTuBoJD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag2+K1NbXAElE1SYEexPU7uKo1rMKx2koTPZQp6laNM=;
 b=MSv/sE9Ex8H58/0dPYBVkd2z3GovE6sg66IlfulIUcAC/68UEkfET8fBtx/raN9k7fazc3mDm+4MJNyV2pn6Fvaw33psarHYYgBEhlEtv7OgCXY3XtXoTrQETyuH7Pz0QBskeX87eDd1PSNUPxU6AHClmRm8Uu4Ku+yQQAak4LsSl8rTMXMfOQNTkJVb4l7dquSNQ6YlboO3ueb7d7cC0AjKPeVr5g4d5vDuN7ZFTWCAS3ISyHL6vhBJCQls/FLKFSe5AxzffVBbjqL52GvTH7Vu2btGudHKB5SkDkAGZUsZ6LezrMoq9l9D+1QbPkvr/lD+hFRyWyCvKIkKOm48xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag2+K1NbXAElE1SYEexPU7uKo1rMKx2koTPZQp6laNM=;
 b=vULdYZlqb0YNhm38kAoMeEEssaP7vtrmJhv2h6ywYW/c/yU3e+UKci46T+ybZKiiXA6KPXSiMhl7egd3aRilyYycngHifqVixORJ90aZ/4fVC0XJ99iu8waIuL/4AqaNyvauTtcE72Mp+mCHfKEHOQuORr+8ORtowP3iRxw5EYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB16094.jpnprd01.prod.outlook.com (2603:1096:405:2e4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:23:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 09:23:22 +0000
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
Subject: [PATCH v7 09/13] drm: renesas: rz-du: Narrow active channels to
 DT-connected outputs
Date: Thu,  7 May 2026 11:21:37 +0200
Message-ID: <5fb923f51219674c62b32e04158ed93df19708c1.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB16094:EE_
X-MS-Office365-Filtering-Correlation-Id: 878b4f75-82a1-45ba-789e-08deac1a4889
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: oMElRRC3Pg7REIhtgDzT5Ve+Lb8kVa4JBYQv5f6ZXqkDBaSraKksQ8yPPw+XiaGeGXJzkpKpLkuBqeJq07kyFYdSb0bo6f7bxQAq1qdcqU3J0bPrPJUpqDmzHN0VwKHQHT5rUYYh4lFSx8VCIOkD0rS7gEhHo9ThKxaPNv+uSwc+Q87ismkW+INPGeofBTF97sxhJkswxQocrJ6HRz9ZM0+8APIXNiZUEOitrfMLnityqkFam33z5aVPuaAxF021Rzo7zwRonCzPxvDanNuOTbzxN2NAZwhdtiDfmuW+jUWYMkbJIAw8OjetyEMiZ0iE5AAh/iwIDPRxCOozgfPq9MC6lFt8ipriiQ7wycwpfvAFwOvTmbY4gxaEOWqsoXWrYZEA7yeKF5NMuRfXzTqHMQzt8AQ1WMXB7qG8Y8NQEL8i+SkEOTFE0SaQumSAPs7afuVuDZ4aHvtLcsKsUiu2tBtbqSf5REXf85UhFx4BBj+V2hEc5M8OyiMw/vBem7dWX3RRxH4bTu3+g3bF6ufjy5ypCnsOD5owdNfHlawjhJ/D4EmbSm9nHFRIm9a9uH+Y1pbyBU21R0pat2egrrBc+RF9lFFYxXcCQmEOV8uF4LwYD9ga2F7e6zxZ7FAI5qrv7JoCfyvvL1pJi3v1oLYTdD9jnr5ans3wzEE6h+y3QUo3pGMt4tsTZWKpy3P7Yovo+rNxIFnUVFuAiwouw3DkjiG6rJW4WiZFZscr5I0SSC0GbdRGh37bzMd+u5mWpPMg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VI9SZB10QPu0rwAtd+6NhL31bV6/a1XAhZ/VwMwvUgeyTYaijuJXx5JOZ6Mg?=
 =?us-ascii?Q?nGk3bbI5l18MLybDEQZSxgYQgP0/jrlXM2Wd7rwSe41sKkVtrw561jlXyrho?=
 =?us-ascii?Q?pTkRwDvojIlyiou2RYJLwp2U0d4Z+tI5MCBOo8Zf95zLOVx1dRKnl8eOXcA7?=
 =?us-ascii?Q?6DX4N/0/ZNCAHOWytPyQlOUtHLDv1az275Ik5H68oFAGtkSJgW4NQspS51wu?=
 =?us-ascii?Q?gSCSG9Xr45uK21XGiwIbG9R+ba5EaYb+bUsnq3DqIQyD1a7C4fiT8AjugSjo?=
 =?us-ascii?Q?4h6wtsCkCA5kh23o1nICUerng8tf6tsq2F8MUeI/L/P5eGV12YpRqmpCSeXF?=
 =?us-ascii?Q?yxSyoRUqeGg6tIAz2dwe4WiCTINWES5qlKv4QI7sKRlDDJedLOoYI2BKVsMh?=
 =?us-ascii?Q?RbylwFNBJ0NcPolWQZA/fPbx0Sq3SLQnvCsUY8PdLB5CWxJceFUDUokjPv4M?=
 =?us-ascii?Q?jWxd6bYdt4OnI6OL0Pdn37B/OPfa5zxcT+t0cpnMMFVdCXGyzc27KmL1tkzO?=
 =?us-ascii?Q?+sgxx8Enfd/rvhND/MWj2rgyT9/DwYBrfTd5mMDRa5BgcXGgQAi/6Xw0w6Sp?=
 =?us-ascii?Q?1LldGsAY/M15gjSLI7rHe6z/6bAMnOfpOe0wKaTiSILzv8/hFcYvIyvYjnVI?=
 =?us-ascii?Q?J0mQdjKy83blG++Gd8jfGqmjCVFa/YR5vdh3oP3xLGpzE1tK11d2QFSHdfdI?=
 =?us-ascii?Q?tmPd8LztbkG//W8oUaFL5k3CITq/twtWqJReVS4VyIg1jbOb8MpHnLXXdOhk?=
 =?us-ascii?Q?nlOWo2xWSwRux0LEswo+/k4tcTfIRB4PLgGPrZiM4vax+ofx+fIIBnDCFDlK?=
 =?us-ascii?Q?UFbTqo56BMtggJOtk9/6G8arDVSThlEhW8sPsRrQvXpqIQDrteYGEbBH6Kpy?=
 =?us-ascii?Q?s49X4hWfOFLzuPcEemKIXwv8521voE1IrBTBqcSezngI9WKpPIN2kTM5oP1C?=
 =?us-ascii?Q?vevkRya7C/1yL0o5NfBppo4Sid6HVqrzkgKxhoFRZ8OTaNC6SIJDwkYM7SMF?=
 =?us-ascii?Q?b7gD+pQYgLOeuHZyS/VHzwnkuebDySMRpEFgXeScYhQi/3WMIGjgo3WhTYY/?=
 =?us-ascii?Q?RmNDazpW1Y/dpKC7WphgN6kF3OeE1k5GA2J1vwQBEJTZAWIJm6bS4Wj1ZvNE?=
 =?us-ascii?Q?XPRRJSudRrpQOvDhqma5tx17azxMSJZmVfrQa5dQvlapu9qwrkD0xZ20YrTd?=
 =?us-ascii?Q?3J80ISWKMaZTllwssWjTpaOSHeby3BljmOmawZ+tiGxNNAsjjDwt4DJQQ94y?=
 =?us-ascii?Q?ttrgIPSqQlnHsQUS3G+Tus0X6v9L1gko4hszurUJ5sFA1QvOO65hg/g8nfv8?=
 =?us-ascii?Q?zfMPu/J7WejLOKI1ti4YcWDyVCXrGrKwxtNWZzfiwaCK3SpyXFw2e5T+4Mp9?=
 =?us-ascii?Q?KvHoe/Iw0QDXolbrxygCrFR2vDvM94sd/rjxGVTPMXLUSeW8PbgBbrw9A1EM?=
 =?us-ascii?Q?9cHgsJus5KVm3jZrFZDvlYQw9b0ODUXsxJmPJymhe+HDpI8SCJ2U5wqz6Kla?=
 =?us-ascii?Q?mzrCUmgUenbE7Ud1Ltcc8aTUnn6XT98JjPyadfKpZZhG7wKt249aUVE+dNNh?=
 =?us-ascii?Q?1qwVZORe/qXe5z4ADosJ9sT1SZE3XzQuhxsGfrcUhuYtdshoUyoGCC7lwUMG?=
 =?us-ascii?Q?Op1euPlhJRRiom3DnAynDA+wgxFGxtrpWzkrWBcnYR3T1nZOyka3jCJo5Kjv?=
 =?us-ascii?Q?QEh62Uwm75yP36Lzv7iCs8UXSNZzs9qNDh1q9NKLjdvEM9xexHAXoiZiZyIh?=
 =?us-ascii?Q?kFp9Ie3nLG3wl4It8rq1avCCuYh45DkifL+9uWPw1vfGdF4AaE8k?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878b4f75-82a1-45ba-789e-08deac1a4889
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:23:22.7833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q02EvWMG7VAjF3ZMGCFfgnwJbOgO/vQvyvaicdNKrCaWVWloXVVxr8ENxFetNi8RRuHNVket9hB8XPFlXLyVGhe7eCp/BJzG0dKTGbLo6pP6cVQnLd3zRBGwiwSVfHhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16094
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

Skip CRTC creation for DU channels that have no connected output in DT.
Scan the device endpoint graph to determine which channels have at least
one endpoint with a remote-endpoint phandle, and restrict the active
channels mask to that subset.

On EP-routing platforms (RZG2L_DU_FEATURE_EP_ROUTING), port@N maps
directly to DU channel N. On port-based platforms, any connected
endpoint activates the single hardware channel.

Update rzg2l_du_vsps_init() to compute the renesas,vsps property stride
from the full hardware channel count (hweight8(channels_mask)) rather
than the narrowed connected count, so the correct DT entry is selected
for each active channel.

No functional change intended for existing platforms.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v6->v7:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 58 +++++++++++++++++---
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 01b037594926..c2cd542a8cf5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -364,7 +364,8 @@ static int rzg2l_du_encoders_init(struct rzg2l_du_device *rcdu)
 	return num_encoders;
 }
 
-static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
+static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu,
+			      unsigned long channels_mask)
 {
 	const struct device_node *np = rcdu->dev->of_node;
 	const char *vsps_prop_name = "renesas,vsps";
@@ -374,6 +375,8 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 		unsigned int crtcs_mask;
 	} vsps[RZG2L_DU_MAX_VSPS] = { { NULL, }, };
 	unsigned int vsps_count = 0;
+	unsigned int swindex = 0;
+	unsigned int hwindex;
 	unsigned int cells;
 	unsigned int i;
 	int ret;
@@ -384,15 +387,15 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 	 * connected DU CRTCs.
 	 */
 	ret = of_property_count_u32_elems(np, vsps_prop_name);
-	cells = ret / rcdu->num_crtcs - 1;
+	cells = ret / hweight8(rcdu->info->channels_mask) - 1;
 	if (cells != 1)
 		return -EINVAL;
 
-	for (i = 0; i < rcdu->num_crtcs; ++i) {
+	for_each_set_bit(hwindex, &channels_mask, RZG2L_DU_MAX_CRTCS) {
 		unsigned int j;
 
 		ret = of_parse_phandle_with_fixed_args(np, vsps_prop_name,
-						       cells, i, &args);
+						       cells, hwindex, &args);
 		if (ret < 0)
 			goto done;
 
@@ -410,15 +413,16 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 		else
 			vsps[vsps_count++].np = args.np;
 
-		vsps[j].crtcs_mask |= BIT(i);
+		vsps[j].crtcs_mask |= BIT(swindex);
 
 		/*
 		 * Store the VSP pointer and pipe index in the CRTC. If the
 		 * second cell of the 'renesas,vsps' specifier isn't present,
 		 * default to 0.
 		 */
-		rcdu->crtcs[i].vsp = &rcdu->vsps[j];
-		rcdu->crtcs[i].vsp_pipe = cells >= 1 ? args.args[0] : 0;
+		rcdu->crtcs[swindex].vsp = &rcdu->vsps[j];
+		rcdu->crtcs[swindex].vsp_pipe = cells >= 1 ? args.args[0] : 0;
+		swindex++;
 	}
 
 	/*
@@ -443,8 +447,36 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 	return ret;
 }
 
+static unsigned int rzg2l_du_connected_channels(struct rzg2l_du_device *rcdu)
+{
+	struct device_node *np = rcdu->dev->of_node;
+	unsigned int connected = 0;
+	struct device_node *ep_node;
+
+	for_each_endpoint_of_node(np, ep_node) {
+		struct of_endpoint ep;
+		struct device_node *remote;
+
+		if (!of_device_is_available(ep_node))
+			continue;
+
+		if (of_graph_parse_endpoint(ep_node, &ep))
+			continue;
+
+		remote = of_graph_get_remote_endpoint(ep_node);
+		if (!remote)
+			continue;
+		of_node_put(remote);
+
+		connected |= BIT(ep.port);
+	}
+
+	return rcdu->info->channels_mask & connected;
+}
+
 int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 {
+	struct device_node *np = rcdu->dev->of_node;
 	struct drm_device *dev = &rcdu->ddev;
 	struct drm_encoder *encoder;
 	unsigned long channels_mask;
@@ -470,7 +502,15 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 	dev->mode_config.max_width = 1920;
 	dev->mode_config.max_height = 1920;
 
-	channels_mask = rcdu->info->channels_mask;
+	if (rzg2l_du_ep_routing(np)) {
+		channels_mask = rzg2l_du_connected_channels(rcdu);
+		if (!channels_mask) {
+			dev_err(rcdu->dev, "no connected DU channels found in DT\n");
+			return -ENODEV;
+		}
+	} else {
+		channels_mask = rcdu->info->channels_mask;
+	}
 	rcdu->num_crtcs = hweight8(channels_mask);
 
 	/*
@@ -482,7 +522,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		return ret;
 
 	/* Initialize the compositors. */
-	ret = rzg2l_du_vsps_init(rcdu);
+	ret = rzg2l_du_vsps_init(rcdu, channels_mask);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0

