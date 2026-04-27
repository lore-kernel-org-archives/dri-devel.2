Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8262EFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C536B10E5B3;
	Mon, 27 Apr 2026 07:19:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ghw0KcZr";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBF710E5B2;
 Mon, 27 Apr 2026 07:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKNbFr7FbGGDCQA1Y/tO3YjWCJqykvnhen8EaRKDlqVqWXypK1rsc6XiZMLgsXJNHLuewUVqX9x9LKGg6HVh8NBk6YbnmKHvgnGENBHA6yyf1G0FScPaOD+iwy8jZL7bAfLw4fnMsf5at9kJgrAT1EQNNa5MxcGSclEmlBuc1w1hHyhGGSt+ol2NVakDuL7ZYE3fdQnfsQE98sufLU54HRgfImjMOWv3PxWCgLbjfs2q61y84VmwrTc3GNE1EJmsEUJsoSUTCax1d00RbR3xghWWm/GMPzkYPQB5oldfW7zyxUvtqNtQe1l18r98zs8jnqQcLrIx+rGVsDGcZ8PkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLCDxSxfrPhwgO21zUEgBqYQD5itXswST//9eoToMMU=;
 b=CVtUCeNDSuuXcQSHPG6GQTwh9vsjs3Wv61lcjGUZ0EZnPyS5o/KKGGHxSMmI/AXaPjqD60WRDtfVm2qytH8FK2mbqs2XHcTkG+pSznxur5ftt9/z3p63eQ8BjnKF95rkOh91a/ge7Kb9AYtuyU+e332aV31EJhEOLOHnin+6xbmQme/P3HIheIVed6zy1p8k75VB6cBnaeOjW4y951XzHFkvplYQlS25aQNx4aLTj7bgmvqyVc/1s6JazZEdwaHoaqVjP8kTxnLbGw7bw4NIWFa6ZGo07Qb0dUxheKeSjxAEvKy+jZpoF9UNEKmOisvxE+xBsU+fJ/jwuIxHIQocWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLCDxSxfrPhwgO21zUEgBqYQD5itXswST//9eoToMMU=;
 b=ghw0KcZrTaHkh+2athcNAwiYjpmKD8r9dec21CAkJgdPCAQuZfCX0USNnUuPmP/aGyexjDFlfY7ek/Vp9T7o+/a0abOuKhWt30ZJDexAD4t8ovCIBNyVAStSmv82JKDyKx+LLAJCDIngCDzZjDrZEv1F3muOAtdEGqR8IgB6rBb2qjzWeuX8smPhdNz3eoDIOodP23pKCEqfHjVfpP0ayDE/UGkfsDYct/KsNhG4z5xwqYbVD2uPgQO6uOlubXOdxXBmyHe87GgvVavyfExZ77FZ7etqmeua3qzwCWjQ+9rQEr9EHqbQhmEItOI+muGdER+ayVfJ4jP4pPrbAj1lwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 07:19:50 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 07:19:50 +0000
Date: Mon, 27 Apr 2026 15:20:59 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>,
 Douglas Anderson <dianders@chromium.org>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, Jyri Sarha <jyri.sarha@iki.fi>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 39/41] drm/imx: remove now-redundant call to
 drm_connector_attach_encoder()
Message-ID: <ae8OW5mD8OXMU7sZ@raspi>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423115550.444930-5-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423115550.444930-5-luca.ceresoli@bootlin.com>
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5e37a7-0b3c-4ff0-e493-08dea42d5e88
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8MwVJNeg7ZyudoM0sahp06twXuC6VMSmseR/CYdgwg7yFEOrAkLbAeSJGvzNOxPbQ7p7b9sXbOk9ZS/DBMKdwYmHjtUt0wNupFMQcn4NHtKOvN/PQytNL/QFac4f30Oa6t9gRCGrMETIx89aO/n4sCGSj0FZGF+owqkmlJQIxY8uGHHJWf7Q6OBzWA6wAeOMGYflTalABQ90TGiGGSPN9Wa7y2HHrp5IC+jabovWXFS26dgto6n2EIfaaGT7sWC34qKdkvwR4LxgJSza75WOWJMP4Sd8I8my3j/Zs3coW19YggTmg6AXv9+ZCLDO8e20DCQ3G2uhz5mEtXk2YHn8KVbTfZocwWgH01qBo3q4hTsdUKxvuKMH8ETq2EaaiP0fHpWgzHLtOBvH3JQIOrBylOBWLTDmBMNjyHwhNf+tCQfDVFoqLX+k59Ebf4pNj2JXfldA9ZjuTmBh6P8ShO0qweB2jS8FaDqaCVXAoibae2TzZ7OweHNyRyECO/DRacyRMf1YLZmFX463RNom3QFzzRCPI5l6HDVMvHl9JQ9AP8kKN1RTEsBd4HRVLihPENZGGo6r1eBxSztf25/YX8Knxg4Uhas2tTNW+uPPkmTZodlUev6HraNomChouIat3i89DTicJMTxoe+swvz8JLuVnaI/vaFs5STz2ITOfpYaKQcwsFq84Y2OiAER6RLW/gJqIV+N/8u++jA159W6cO/SlWRdtZC9cbW2VcVqk/P2wm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yc8oTPW2yV4MbqV6J6DxUfdnNNUKmuPropFWkZpSCEEmKlYG8mYGIHJrWr5G?=
 =?us-ascii?Q?Jl6NckbkBNP4DONJ5Albwl1zL4dsS9JwgUSOh0uxqj4iIFwNXmBlpFA8C5bH?=
 =?us-ascii?Q?Eqt77R2eMccJ/oRwI3V8QwSkMAvcXst01uVzJIce/7bDEprkxHNOq8QdfvP+?=
 =?us-ascii?Q?NbzoOfCAWeXRHvXVozwH+GjXL+Qve0trFON63LGkaSMT8KQNyh0r3XcoZlGc?=
 =?us-ascii?Q?1LyyJYZCn926KUheniUTD7W2Hmyk7wxMNpew8k7CrsjhhCrJ+3rloe8t/NzK?=
 =?us-ascii?Q?yf53TQ0ulmGd56D+KbKoUBNcEKbKqMkjz0kV84NISHLnSDzuVC3ZCFApfiyk?=
 =?us-ascii?Q?WjjvPoJ04q/YrqydvnWbCH1MqwMWck3w0FOklFlXzcN3QtflYB6nTImA2OSq?=
 =?us-ascii?Q?HUW901U8Dl3+jM1LZiGlApheZ7RlgaC7gLLgiFxkq4Np+y5v8qRZ/h4LxbCf?=
 =?us-ascii?Q?RDITKDqMDsiyRMvEnu2y5gApzVJOf5+YzJqc1jq9ywQlSS4Hzy8hCURIj1Sm?=
 =?us-ascii?Q?H8HbOBG9hva7gvrQz6OqoKe5dK0JShOsXQWOA5boqe60UVz56+tRdaL/xXLQ?=
 =?us-ascii?Q?bGjmDG91y9BPIVIzrAUKg5eFaiNHz2wS9CsiaspfMm5f1f8AI7z101O2UF+Q?=
 =?us-ascii?Q?2azyXzloRO+jNEz5cR5mTLAgFAO9CU6tVxOYzPKbgbi2iZMlhVPlxNOewSPr?=
 =?us-ascii?Q?GU01CkUQTydkXVLB9jlRQTFTMDDBC8mNR9ACsmLf13xFsMonSmeQNbm4M3Bt?=
 =?us-ascii?Q?+Ergy59WPuLTkmbC0XeCSldJ1F9OasKAuEsjrHtz7WslCVv9jwR0tqRBS6nl?=
 =?us-ascii?Q?ocCANb8EBb/Hdy5ytCSt1Z9iA/yLAHECPEbfYaJ7Svv/CU2xSe+paKF6vv2s?=
 =?us-ascii?Q?/xPT66Qvdpp/7q7CWBti6AbmoS0oYe58JznuPafoxOyqMKORqWFD9sDMZuki?=
 =?us-ascii?Q?fj7HGbdFxJHntRtlsgRwC0tK9uijQGMSptOfkLSV/9tMY9BtdChdSFm9ZBXW?=
 =?us-ascii?Q?ZIFzYUFDfwjpClecIKvyvRJlim/HF8DsFxUC/yO++g5qoMvbmvSF23LLNvc1?=
 =?us-ascii?Q?QrYJRT9bwfs76QL/i3X+2zM/xCPTjH2lc4L432r6pvgx5+QZ7Ny5gFzmax64?=
 =?us-ascii?Q?QM8fzm27zhPM4tFVQpXrm5S3S8JRaoXk0M2PUKzYoMUTN1Emv6IakKoGL7ql?=
 =?us-ascii?Q?22YNDwm91a0UUEYZ3E6E2RTA47OH6lnRXw5AP54h5wmB38KUioCmWgUcFd3K?=
 =?us-ascii?Q?n50AIuEsBmUvlSk7/sjPUgJjMTVUy1YrdUXV2tcRE+cUhbhBg0Pz4PgCtk2N?=
 =?us-ascii?Q?QDvixP1dXRJ9ixcyESIvTEAAqtKqz1SornWLdKnw0SUOBRRohsT4KWxmgxr9?=
 =?us-ascii?Q?zYLvFbbAmo7ZDGaLXeYPMTJ7vYFCt7UufGVCFjqomrIlL+gE4kSkAsZjfzor?=
 =?us-ascii?Q?aFh2sWEH+sGEeUqggSSZIthqBcpMuaXgu+yi4K1YuHoAWOgHWfZVaLl4wRZ3?=
 =?us-ascii?Q?YV9u2Oj1ZlsgKTMHIDc3TT2IrCMzB8VQljbpSDiLl9qCIb6Tq8grFNx5zFxx?=
 =?us-ascii?Q?OyEHICXx2WtEyjT4VWj3sdc3gVO+m16vT71KhLpAmmnBSPxFNGYxJKUAHVMe?=
 =?us-ascii?Q?SomjQvuJzZ1poCmGbHoDr7oCblc3o4zO5oyfBu6tHQogwNymJ6+iPb4/dIwX?=
 =?us-ascii?Q?3PtbflmmVdmjnZ3kj3WJRfgxFC6g00twsocIE9CkcDVmbOZ9RmLfsBxaqZG7?=
 =?us-ascii?Q?xW5AmROkgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5e37a7-0b3c-4ff0-e493-08dea42d5e88
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:19:50.5085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKF8APV8F/uppik3KBepcH4DExHH9ctymACV1rllW+a6OQI2n+DLGDTibzGiqgX8iJgGcS2oCE1T45/P52X6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059
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

On Thu, Apr 23, 2026 at 01:55:48PM +0200, Luca Ceresoli wrote:
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/imx/dc/dc-kms.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Subject prefix should be 'drm/imx: dc:'.

With this fixed:
Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
