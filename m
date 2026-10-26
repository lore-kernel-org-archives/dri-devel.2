Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PqjGSjFG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B2310ED80;
	Mon, 26 Oct 2026 10:04:34 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDF810ED80
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfyHFJ+SfCzDySWtGk4g43y/xInYDqvxL/c769binI3SNPLHvVRozTtSwYrkLMo+H14yN8pkaIOslwaWUOI8IX4JF0AckKLAznMu1rFBv+PKsgaUMfKdfU8apwpo+lK2+RQ0UdnhDnQJqtNCgR1s79LEiTHYj3ZqajWLgQyklxXiWOLFCr4nfHr8SSbV7y4RvsL6K6wP8B+RDJZ0DxtdmCLUOTvxORjBoCdAYhHZdwRS//n5SibXziHWETrdnRn2VD7+p0PRe8SO6rMnuK8W1ZCJcfW+Tsx6ovNxkR3TSXvyaNKEc/xLeC3io3kwkmx1OLhVZluIv857Co6F9S7SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=mHG6802UHiXx2CDX/ILZ6QVIzDc/C3mW8c3z2Qnv4zdhbLnJojzpq8lsdP1uDCiomphd+2FKkamZeyT9vXJIaHWRkT97nKrIQXMsHKhfHkC+/T4fSJmFcpVRbWaB/eQLB4kZDGUaw3WiYL6sAXpNKk/TL76/EpW77abDTgw2U8Z+hFvVbKsySDn2jAnYLtaA5nO/dpYlxj3L0M29JpB1G6I4/otdbsGN7Qy4H/aJfsSpGqb/LguEGRxwGoauADoDmiOXjQf6sGzkY3uJ1TA9vdi5VgUMlBpuPTVh1VPMoc4Yml83H93YkdbY7wnKi9aykM72tIhQRmxdzxrr7N8Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bqv1R8GmGKcasUcemz8w8yZIbvgHQVHBwtx+4sBYNs=;
 b=PqjGSjFGpKRQvOUy4GIpCcAMB0meZrIi/HpAWFubE65uso/LwNaqBxTvAHWRQvUehGaWbG329YWKKAN9hgi6ko7mydchzwnt/QYiQ1uYlBc7jYeZSFu65SJi2haIgyFLgei0qFmj8tUIuD1j7G8tZZjSuYq573S6PbcgZNIs+9hDLyt+Gx15i4sgDNa7Aol2FdvqrdP+ilYmbqnf2vi66X9AHTKCUtNhRhKAnRDHcHijLVagfoo79UZR1Dd+M6kkeT0PgoiIMEkDBcq+COVVLfMm/iwhmXWJ+tqwpVBCxL0yvjtK5slZWyiPfBkva8tdwIrlv21GaLQVY3y7gsqupw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:03:59 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:03:59 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:09 +0800
Subject: [PATCH v7 04/15] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-4-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: a24692b3-4cd5-491d-c7aa-08df3348749c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021135927099003|261021121427099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XvMjHhMo3n6ReoBLfeEo9cRIel1h95q1Pvj1jtmz4k3hQvNef2SJG+ceRf7yNK49t1VlrJAItf4Ab4I+tLikl2k5sGtu84yI4ojD79p4OKaLHwh3M9EE8v2964wdJLiRWEsXwclMOOC3Xex3YzNbG15bI6AZEaeW2GbYfaoq4wgQmo0DHLFIuSHZr1JfpJEyCpyEZ4ohRSEi11zQQFctDmEMJgRLWvsj/cRWZIWTo7mWRzHEljNZq4afJRyAuXDP5qzQN/rLjUI9YWLHt5t+lXqe+bX+AOnF3AluKdqoTzTZbeqxeEVlzAQZAer7ElSe5Ni/LG1nyFP0w1RBgfV3f7zCaEMBp3YSb9G7MPYbQvD42bUA3goVbT6zWNvsmUnD76qxZfuNTxt5/kieX59U2AEQKz3kozMgh0r+UV6YscfUsLgEJRDCS63GvmZWughYDEQuTswnwqV/yJY4ng2E1MDiujWh8YsGJ7JIlYVMySuv8uVZ+RLaAbtjCaNtUg2CZdq+Qvm5thgHYAG4wR8NBRPWeXzHyWUzzzGL9r6TtZBkR9CWbmtTCjniszDKIkwIVyhTd0YozYVGestzlcpmE3J8MPz/CKRjhdAN3zinzOxaaQ0tYPtCfDC8meBQbx8oMuIB3CxsOvyEY9QRu4ZraRlSD6sca7e4Tw5EfoyJTBlKrdjp5YDrovMx9T1oJ/CiyCj019z+YrBqgNN1xvUopQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01TNmg4NEJtRE1pNFB4eHBlVzRIZmROTG5WOWdLT2hFWFVPWCttbmNTOUdZ?=
 =?utf-8?B?K1phY1lHc2x1Vmk4ZE44bEczNkNUZHltYlJrS2ZVb1lMSFlNV2FtNGt4aWEy?=
 =?utf-8?B?QmJYc3lGZElDaDRVNDRmYWhjMHYyTTJqaGhwK0ZLZU9EWUZKSXJyeU9zOVVz?=
 =?utf-8?B?V25PbzFqSU9FOFdBTkROa0EvL0lQYjlwNGg2OVMxN3IzMnpyT3MzYm9Nc0or?=
 =?utf-8?B?NVVFUXFHSlFnWHdRSWJzcStHeHhrWXpoK0FVNWRhNXppSlo2Y0FYQ2U1aUZz?=
 =?utf-8?B?ZzNDdFFDRVdLKzZKQnVGaDVBT1Vrd3ZMUGlQblVzZHlXVG9PeU1ldk9DVDZS?=
 =?utf-8?B?REpBczN6eXErdG84SUF5aEdFZCtQYWJnVndDRyt1VWVSb0E4cExLcWJUNk5N?=
 =?utf-8?B?WTB5QkxNRVg2SnVLWUxXUHBvc3ZmZDJ5aStpMGk0czQ0MkU5dmRqNGF1a2Q5?=
 =?utf-8?B?REpYRVVVM0ZCQ2pYVGVRYlp1dDYyZlgvYnBNWEdMVE82NE94RkF2YmJTclpn?=
 =?utf-8?B?KzhKWCtNYjBsQjFuQWYxZVlTTFJHeGxaWDlIaUcwY3paY21vcTVmRWpxbDIz?=
 =?utf-8?B?YkRtanZmTFVkUWFaN29BVVA5czBoZ01mQi9ibUhQaDhnckpzekNWcCtnRndo?=
 =?utf-8?B?Ni9NbER5NzE1OTYvdkpUVkkwNk13RkkzQWtCUmdrdTZwUlkwN3BKUlJwMnlB?=
 =?utf-8?B?U1pFUlk2cWNCNlROR3lMV3NEeGl5aVhyWFJ5SktVdnZmUHpkcjlJNVlOdkRE?=
 =?utf-8?B?R3BEbEdhYTZCUGRwZ2pZUlVEZmtTN3RlMml0Mmw4M0ZNOEs1R0ZPNjErZ1Ir?=
 =?utf-8?B?YWxZYW0zMUppZ3JVc0dvZWYrZUJlamtwQ1I1N1hDbEErbTlQcnZBcUlsclJ4?=
 =?utf-8?B?Ump5ejcvOGZORjB1V0tjMkRKUENPSXcrZkhYR09ZSSsrdElSUzBxQmx3RGl2?=
 =?utf-8?B?Y29lcHd4L2c4dTltSzY4VU5tTXozNmpCNi96eFljbG9rUVJPbFNVMlc4eDJp?=
 =?utf-8?B?anZHd0RWb3E3KzhodW9sajVoZWFhUmJ3emVTYXQweGpkelAvbDVFSllCN2Zm?=
 =?utf-8?B?VVBlMmxsWjBocXdaUEJhMFY3VmsvOEVYdlhkYWtZaGpRSFpaaEJYVEw5VkNW?=
 =?utf-8?B?eG4xUFlGQi9tT05CclM5YlFqdXFNVHBqa3lUbUMzVTQwcWRTaW1odjduTFdB?=
 =?utf-8?B?Tk54OUE2NjBOQTJzS0JabnZmSlFEOVJxWEZvejN0eHFaRVZ0RjhDa2VtWmZM?=
 =?utf-8?B?WGYyRlFjRCtpVUg1SmY4c1h4R01JUzJKSnNMclRLc3BBU0U4VWhrZ1lGb1RK?=
 =?utf-8?B?ZHA5Z0lPTmIwTHNFeS9KRHh6Vks1V2JVeWlsV1BIL2FHQWJjM3pWUWxoeWJN?=
 =?utf-8?B?RkI3Z0JaQnc1RStubHQ0OEhQeEpucFM5aXhSaGhKVXh0SlpJQ3RkTENrZWRv?=
 =?utf-8?B?WXRrY2puVC9jYjk5ZjNuTzExay9KTDFudm5pU0hNbU9VL2FuTDRGM1p3Z1Iy?=
 =?utf-8?B?blhEN0lKUlBpTlBkakp0d2RvY0FtRGNLZlg3Lzd6SlFielNMangwV09lUnhr?=
 =?utf-8?B?VklPMmg2TnZjNlQzWFdnWnpKcUppS3dMM1NaT2FOT1Z2RE11bGdDZHA5NThY?=
 =?utf-8?B?Y1FxdUZvUUV0bExscm4rQ3V0N1p1SGJTSG9ONjd2SGh0QkhyTGlnQzZnb3BW?=
 =?utf-8?B?UCtJNWVRQ0xNcUtzak1TaFFJSHlnelY5UURDUGVIam9kbW90S2RrT1M3anN6?=
 =?utf-8?B?MWc2UFBUM0lKQWUrNEtlNG5UV1ROY0NRaEQzaVRKMkUyQXI5eXJOMnpuUGJS?=
 =?utf-8?B?VDQyRGMxMDJvWkFEa1IxTXNiaGF1NlRVRUVLelRtbyttRGp1Slg2Z0tFbzVl?=
 =?utf-8?B?L3hMbStwbGx6OVpKZ01wUkp6YVFaci9PaCtScGVKcnhHV1R3YUE3c25yV2NS?=
 =?utf-8?B?NmVBZmd2UDBZVVRpdWFRVjB1Nm1FN3ozb3JkajM4M1Z0bkFCamV3WS9STjlv?=
 =?utf-8?B?a3Vad2FSb25mK2FncXMwalpoQ0hSZUN2NTcrcmlMUTZtSjdMQkdENjB2T3N3?=
 =?utf-8?B?Wk9OVFJueXFrK0RWc2N5VmRHZ2wyTFJqZ0hEdDRjdFF4ZHdnc1pPUGsvckZo?=
 =?utf-8?B?Z01uQTF3UXorVGVQZndwNmN5eHo5VHBOUjlLblkySDdLakpqUGphUzVNUVZR?=
 =?utf-8?B?bllmdi9UWm5tbzFMS3AyaUdoc0lRbWRaMzdLcVk3ME82OUtSc1pWUFRIaGJK?=
 =?utf-8?B?a1p3Q2F0MDRJaTZ0aVVxTDVmQTRnaDJPSXRNN2VEaGN5d05USFdsRzNEcUxq?=
 =?utf-8?B?dkIwZEpqL005a2NxUEEvNEFDSXg5VEU0Sld4dXIxYy9Bc2wrV3pRUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24692b3-4cd5-491d-c7aa-08df3348749c
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:03:59.8127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5LQQNsk/7CyGSVwPZr8DpW0vW8J5su3l8/Lpu6a49Uj8sJgwSMhz8iZ+EWRoGId/srZZL7F18cQ20uYETJLDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
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

Fix off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH and FRAMEHEIGHT
macro definitions.  The first two macros are used to set a fetchunit's
source buffer dimension and the other two are used to set a fetchunit's
frame dimension.  It appears that display controller itself works ok
without this fix, however, it enters panic mode when prefetch engine(DPRC
and PRGs) attaches to it without this fix.

Fixes: 0e177d5ce01c ("drm/imx: Add i.MX8qxp Display Controller pixel engine")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v2:
- Collect Alexander's and Frank's R-b tags.
---
 drivers/gpu/drm/imx/dc/dc-fu.c | 4 ++--
 drivers/gpu/drm/imx/dc/dc-fu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 1d8f74babef8..2e197b3344bd 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -31,8 +31,8 @@
 #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
 
 /* SOURCEBUFFERDIMENSION */
-#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* LAYEROFFSET */
 #define LAYERYOFFSET(x)			FIELD_PREP(GENMASK(30, 16), (x))
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index f678de3ca8c0..cc93317e3001 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -38,8 +38,8 @@
 #define YUVCONVERSIONMODE(x)		FIELD_PREP(YUVCONVERSIONMODE_MASK, (x))
 
 /* FRAMEDIMENSIONS */
-#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* CONTROL */
 #define INPUTSELECT_MASK		GENMASK(4, 3)

-- 
2.43.0

