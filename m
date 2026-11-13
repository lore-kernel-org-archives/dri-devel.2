Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BE606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=IRmo0o9y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62C10FF7A;
	Fri, 13 Nov 2026 12:21:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D5010F944
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hui/CctSF4G6qsSrzgMItefBsX2L5vcOGifKyumaT61iFu7+4gQ5sPsvpSv8hT+FAus697C8F+NrARQuZA5Tpa4UHRtslpTN9eHLPpR8qaHAUmjNOFQqbooZPsCsF9/CiYVNCwsx8gNIiZWQzSxOdq+ywuNbEc969x2T+nGw/rjfxN7gPbczek48mVe8X7kZcnkMvxhwhaDXZInHaS7uskkcehowdnL3JzsxDiGOsV6krnNWC7QtagCHSiN2uatxwr5WpvJVkqU9vb5c96InuocknvbICiUUweo3Wx5ZJL1t7UA5sWZHzI6JYU/5tJcvuXxoDwyaPp7dj/+FN6BvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFCuF9nNbtXRhZz9p1ifxLs9PoD4IJ8YM1IYY+oWK30=;
 b=qVHWZJir5cXHDAlph+bPL14EJiDgHxo2EmjR7FomvdjvfWRNNUztYDxWn/T5X6U6brU7neIfH73G0ZiN8lAzdGd33jisWU5FyhwXCST2H3FP8Onmzu/y7QftGzxyGysUF16rDDyKjyCHxERukyY2nNsgEZqzyqyMY0T5w0kbCQNIQh+vK/hJX7l4oK68TQEDFASBugNwc6gQeWCTdLD30ga/76S+22/l0Hza1Dr5X0bkOcerFek8ojPczJW+JIRCFnFyPf8WZ4h539bE7CAy7rnWkORcXUgfZCBvSHKXwx9PNhbS0yR8FF0Cjgll/Hk7rLyAJTevvfQwsh/sSu9w7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFCuF9nNbtXRhZz9p1ifxLs9PoD4IJ8YM1IYY+oWK30=;
 b=IRmo0o9y6msi1+l9Q5BkTz4Iev68BgqSRs+i8+r9AdkgVazsLlLDkoB+79UW/Nk7GIbNQ09KctkmjUK4bzfiwzB7JdTUFxmuIEeJs+n9OJH//3I0/4YtuKRx9u6+TPmTxYJNM/sh/Hl6c5icmJyPVoD8KfHYiuGsv3o3jndZTf0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB14799.jpnprd01.prod.outlook.com
 (2603:1096:405:25e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:21:21 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:21:21 +0000
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
Subject: [PATCH v10 06/12] drm: renesas: rz-du: Make the CRTC index relative
 to the DRM device
Date: Fri, 13 Nov 2026 13:20:02 +0100
Message-ID: <04be21c034849955186adc9af9f6e70c9f740be0.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5bec186a-fd24-4ec4-0aef-08df4180a046
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|18002099003|22082099003|261009223027099003|3023799007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|38350700014;
X-Microsoft-Antispam-Message-Info: Pp4Oie/i7zyrZ7O4SgawxZu6CP0zThmMBMFz5d2Pc1Djfb+HDmVAcP7Buy5GpAzVBk6N1OoOoywPcL3rMXM6ezTVoGdd8JSkuFY0KGj7u9B38zdeWPReeWZuGi88nlDqXF9TzBMC8r+a9NY1ILQSJc1D2o6QWQXPTLTJg6zUd79KKxVrsp27F//GahQjgVEtFYPu6InhQ6ngvj3B9RZffxFi30XFV5RmjbThAX9GNTYJ4XIH/ok6FdR8iCc77TtAd/XPQG8smSIvBw+ZCmVztbHAR0RDKm/MTF1FQRTHd2uHsIRbLe0p/KiKWrzMgvoJwTZK0rzX/Dk12g7sON7gB3ctv15rGvsN+s1ZbWZ+jv3BJf6xSAV/APcEL0Ko0klrirVq7BexSBnoh09fNhNHJz5D1KoLBGWZOGYhkJtFbeZNf/g75pOHqUplQItR37HW6/UnqI3QrmqcB7mefGgUNF4hGSEqoTMkRJwKPXuEDi9wJjc/m/vuQw3/etwMyBewMZS5oJYrsYM/nGLoQg+/s2tBEBhwdUrcYvayvJluvO6CFqQ0Lcsx/2/fsG2vMo5KcomJpaeDW/8KEoDXH2IXHYCosTknq3IJ497gdCbU70UHkh64v93QN+HoVDDdVa46bvPsEvyxuPs29pa8mj+YtFD3UO+3bsp7ufjbtaQbE5SLJsKXCbY+wjUdwVWAzsXuRippk9TmutqFddA+TA/xsYn1Dqw/YobKbZdHP77FEzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c38duGJkyN7MtYawI9mG1LGsmmf4g/gzgMqWnYRAUh8qTYqr3p9CN7jzwIT2?=
 =?us-ascii?Q?bVfx1RSBnh3U5AUCUknifqMFws/+Qc8g8db+nBi6RxebX+pc2OyJKtYps2QT?=
 =?us-ascii?Q?Vih4/FQjzmzGI3mnnySFOgve6Iw8APiYqK+9TJmWZt1D9oBrD4cKJKJfePwP?=
 =?us-ascii?Q?+ZhqJXaBxiBf6+ImXanlWm9SYO0k8fLPZD+FxxHlrS4ToF6bHggraUfKHp9s?=
 =?us-ascii?Q?dowHqzmfEGkLJrum7cD2OxLlBtTzPzLEIV34PXi/GYxhPJP+/nk/v+tUy8GN?=
 =?us-ascii?Q?GcOta9jzASfkKxt85Wbit7882N+FyD/96+JSExu0z8GpA56HRpEnu08lImd6?=
 =?us-ascii?Q?9tbwZ9ycGD5byziLvbTw51vnC0vnei2b4DXKawLS4uuB6NdhGxalDB9gyD4y?=
 =?us-ascii?Q?oKNkVfs61VG9AQO0D86mAog7cuNS057E4ms2vJUMu2uJQYUl0UDym1uVY552?=
 =?us-ascii?Q?a5vhTcagh800SCnwIWA5n2Wk3D64dSBFnqhf/Lrbr7EHkPhuu3DDtfrs2aQL?=
 =?us-ascii?Q?v97aNlwqlsFZdU+qVKAIoPmRpXLnjYejXQ6ZbPC2OrZ5orUPChxU/usQMr1c?=
 =?us-ascii?Q?+r7b1aUxY8lhkL7cN28aPx2aATR4ZCeJuv7qBvJSN4m7haWfo1kYXQygI5gn?=
 =?us-ascii?Q?Py83AYXL+Omqb8kyzCYLfJ054Yvqu7E2VYc6hphxqSknTh/WUKM2pjdrIkbc?=
 =?us-ascii?Q?gsp/pigwsPZBFj2JgAOQpMmbB1KR2jRgMLjRh3OVpPU+NqxcsuzT77+WyJ7N?=
 =?us-ascii?Q?x58HNIi5Vlq/77epdIDKHIOJ/1aJb7XvMI/Cjv2vhR1xx8Xbcmam86Dqlw84?=
 =?us-ascii?Q?iMfYaHksP3fYSGlmnlqMFDf1PtFFdMgm1zsoe/zrXZVFe7/EITtNwjVHxcRH?=
 =?us-ascii?Q?HA0/ZhXAh9d7h4SDaLkijxXCgsdMcfNKJmomMSW8Hsur5A4+ZMw2X95+Us48?=
 =?us-ascii?Q?2zzp9wcMZOiEU4HvLp4Rjpa5tbHWmF1mD0328pjT+JGRIjyw3ELaKtt7V6/1?=
 =?us-ascii?Q?hkCI62Wh2OUHogrKixRotiaXlL/+r8P2EYXnvEHjCvEiEmdosO2AArAHCFtZ?=
 =?us-ascii?Q?Gf/heSB0GrJFKwH98j9KqnMMyS1mfEccHOEqjNlJYdZNzPxKF5Gcq9TVssml?=
 =?us-ascii?Q?LRZgGpFS/YdMmZhifmvGMAKKPCyAJBuzeanBuYTaVr8F4+tBhrQ8szEF7dQH?=
 =?us-ascii?Q?llE+CYer6+GDG4XsPzJT0/NUzQm/ccm8LLEDEyvcf7hWxQCDiQxhSf5QTS+n?=
 =?us-ascii?Q?T9mT4xhPVOHmx30Zj4rdgVesMt8L+CXSGFOCEEoA2d6yo4CKBPwZvp4zmDt/?=
 =?us-ascii?Q?GBZwzOtwo/Zs7hVQMPyY22Kk4b+bcWhMWQDAdDWVSI/r/5KO1loB570/twEB?=
 =?us-ascii?Q?fiH4pDe2PmM7phQOKMG0WuZg1lPkO9R4lBSM0Rb6tHYfQRbZ5Y10oHHvYRwu?=
 =?us-ascii?Q?eLNLjKxqe9PLSPJyrRear9BL0kaMyZjQjUkGWI+bDDTQRPkWxmMF8CKwpc2X?=
 =?us-ascii?Q?+VdqWsn+s9ei6v7suBRWBbYeb+39omTMpB3h43Fj/A9godDQHWBkg3kZNgqk?=
 =?us-ascii?Q?P6Eszs3bh6JpvzWKd2aWzL1LeFODWh8p6VtzyVp2QsOTQxjIHdCrs5uzlKbs?=
 =?us-ascii?Q?ahfhK6nyp1qGKwX5TRmZKBUn9Pshdhz6yameqyhW6DetOeRkinRMRJBw5M0j?=
 =?us-ascii?Q?B3Do/oaRSAr3XRF5in/AgCnBBQCtJOOYT+NfvlbOjn/qV0pA9SyJACM7vJFk?=
 =?us-ascii?Q?Q9XKwlCqpDespb0wdoQp0LrJnC7FysZlFu/Nq0Cb6BOHOTisnO1S?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bec186a-fd24-4ec4-0aef-08df4180a046
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:21:21.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl7uqSjb0N9dsTKTkgPx7PWAdfk4PJxIqV9G5Kmj7XYyY5+fxycZ2rvdYGxcrZKk8M1NFY4NOgwtoFp+CBv1vg3f9u98lo3KfXx0JaAehF0X3ahw7xbyS1akJ43k8fb7
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

The possible_crtcs masks of planes and encoders hold CRTC indices within
the DRM device, but rzg2l_du_vsps_init() and
rzg2l_du_modeset_init_finish() build them from the index of the CRTC
within the DU instance. The two only match while an instance owns the
whole DRM device.

In preparation for supporting RZ/G3E, where two instances share one,
record in each instance the index of its first CRTC and offset the masks
by it. The index is zero for instances that own their DRM device, so
their masks are unchanged.

No functional change intended.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v9->v10:
 - No changes.

v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h | 1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 47ceaf892339..2952c9d7348b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -70,6 +70,7 @@ struct rzg2l_du_device {
 	void __iomem *mmio;
 
 	struct drm_device *ddev;
+	unsigned int index;
 
 	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 73cb3199f90f..456b29538db9 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -367,7 +367,7 @@ static int rzg2l_du_vsps_init(struct rzg2l_du_device *rcdu)
 		else
 			vsps[vsps_count++].np = args.np;
 
-		vsps[j].crtcs_mask |= BIT(i);
+		vsps[j].crtcs_mask |= BIT(rcdu->index + i);
 
 		/*
 		 * Store the VSP pointer and pipe index in the CRTC. If the
@@ -480,7 +480,7 @@ int rzg2l_du_modeset_init_finish(struct drm_device *dev)
 		const struct rzg2l_du_output_routing *route =
 			&renc->dev->info->routes[renc->output];
 
-		encoder->possible_crtcs = route->possible_outputs;
+		encoder->possible_crtcs = route->possible_outputs << renc->dev->index;
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-- 
2.54.0

