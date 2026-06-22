Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B9BCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFF510E4F8;
	Mon, 22 Jun 2026 07:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JIlvAYEy";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 135B010E4F8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9QXNKthAiGPTkhoNNodvssIJdUblHOXXMzgwluX1o6v/GSgBKwKdTTg0QORjL08HljWGnlLT5bU1QHb33GmyGMh2Fy5JNs8GWJuAa68Wh512U0rLQ4C6/MUMmyZNVlcJSaDVr29tHnhcQy5N9NKWLitw1GEzPX3kRmhUhoo+zmRtQ+nXovK4UsN5AfNt9RA1aSV2w3Xc2MSKIDl52S/ZRpTiDqRKZh9jf5wJl76RvHYZmfWiwVBixPV7KEAah2iZ1iZ8cstsK18B6/CIv4ivzVCAlTSDsb/wTDei6IcFfRgpx+N8W+EHaIUiZgIouzWKgUbNp8LnNCbCRXO2dom2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMaYIYFNkj4KGSaKf7D8Lg7sbkJf1Fb4UhKjt8H7dP4=;
 b=XW6WiLDEbPse9TuTMkwp+tMIKHISRZjGFQFCUwGjBzmJL+/l0aIGRblojDr9l3Z3gFsHdeGg2iRF1rWiF7G2XVGml6W5aqIoeZK3XY2o6ObaSKmeZz8rsRuBsbfs8tHT3nU9g/dRpuPNU9TlkT7Yjp03N82hFBpLZ8qt1BgPd/B68HCLOg6YHmU/BeKL8s0Xu8qKMvXkg8s3AFdFKctuCDepPuO2beJCDBrw035K/AFJQ1SCXHFjRN0Fy0GOvSGXkdflLdrE6R0bsvIzC5c1Bz1bpfgrfPpe41XWouwM5kSrogKJ1IUbDThhIA58FCkiTHeGVDRp1TippLwltPS4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMaYIYFNkj4KGSaKf7D8Lg7sbkJf1Fb4UhKjt8H7dP4=;
 b=JIlvAYEyBY7EXSWU639+6EdcKZboPpOsSUzZn/m9tkfXI2kaYQ9JFueOEdl1UggsfY493wgoTnPIx9cK/bzyAktn6TG63O3RYrb+Pb1HbObUxObFkMhUuMu4TiZGy6EvQLk4iZlsmVLOwnYBiSBm/qk9z+BQzqh7XI6oEfGJSQqTvoIeeODMBPVMRVfvl02PSSLPP0DiCyKOaeFZOyKXNZvCoNgXaqgT1+o/tWR2EHqHzh55xx3/L406tewMjUSTWBCIZ6QwAGd7D55TLk3MJY5+Er2njwAFitY49MHMgL1wI0Tv2uv0OfpqCZA30yJKOsrHgRks+xb7N9TQlcmsyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 07:50:57 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 07:50:56 +0000
Date: Mon, 22 Jun 2026 15:52:26 +0800
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
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <ajjpuroFPI_U2Fw6@raspi>
References: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
 <DJD6I8NMLN3W.3LVT4L17HT5TU@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJD6I8NMLN3W.3LVT4L17HT5TU@bootlin.com>
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c8e6f9-a223-499f-d3a2-08ded032fe23
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|1800799024|23010399003|18002099003|22082099003|3023799007|4143699003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 570S1L6PQMLL4NsV8qpS7lw49IzQcdKm142+OFkYgeYyY0l7MHFzRLEGtuyI2o+uQyYkmMmkpAPdjTsFYtfVrN7xDEMEdWQFLVTkPKxpU0pEnRHC4G4OPWd8et//0i3AGRhg1ItXKltERnsxZWOLhnTyOjUMGCn5Un4eLOX52MMcIuI3sclL3Zep9I4cIbHldJUBb7TbiNLMRvOwX9DTfLG2HYSXXZGeOXuV5y7kVbd30q5m9bP9mZE3TXSsWTbayrKgi615KonQi7btBpbWwRgaN/8D9UkeV1VUL8X8iYvziXUHzqwHPtpxbfveWb8YsceNoE0v2DYGr7/A49RRdBDfihVQ6ZGo5EE9Z17hatJBLEUjiOf2lNAWovx6Qo/9kP98kebMV56H2FOhSESJUGVcjCfj90iIkXgozYp0BlES4Bvabysr8ApnpBgs1qBY2o6my9ywRgFsDDQnORlTNXJ9cU/QB/+ihqdpZN+81Ngr/Psz+wS1dxXE78US6/MivToVaRdskzOrsYiyidYR9/kweGAF2nhqTvQSH2hTC+O9ZH/nKxKVt9J4wzMGlMyqMIEYvChZH5zpbI/haciSAgnEO69cjXQM/U+7sb4Mi7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wp5MyLw4ECUJvOODTAtPA3h6KD/cq6kPTFBs10mwy31XhJWGtD5h2gPuJZkw?=
 =?us-ascii?Q?5CWjmR+leWtLbeKLnzhiTCu70zVY8IZBzsnkQeAgnTzMfbn4euavlw+mi7ol?=
 =?us-ascii?Q?oif/TyzrwGqeQCqRSMEkpo0Kzc/m5bO/Kqjm3MgXFiacfcOKJkie8+sXUhXZ?=
 =?us-ascii?Q?g93obqby6Q7piIr9yZNRV5fqWLIAFeCMz9UWF0jdX6X10VsUFg8ziuqypHTL?=
 =?us-ascii?Q?LrK/Y6ZMsVH6Cm2gceqS823KoKiDDz9mC/YWoqIGcVg4G6yYV5hqXjDkis1T?=
 =?us-ascii?Q?IGQG1Pk/JwrB24kEitMHd+JwVM9LiXv/yDZQdTNzTm9kipVyrnw1nXZjthII?=
 =?us-ascii?Q?B/bSvbVhZrKkzWfWcHauGENAidorV5NXDS9jWh8MQI5W4/nvNhPBawxnlL3B?=
 =?us-ascii?Q?20l7Y9DJkELGk3e4NFS8lh/8zI5YoMppVk9JH9Y1ll7EBUoj/wHGnZZwvJEC?=
 =?us-ascii?Q?VCrtobrRauxz5XjGzPWKDFbICW84Dhn1z2hSGkiW+fJtdUpNkc0cFfUXTo2S?=
 =?us-ascii?Q?+1MxfuNJ149kNBNuteTxemfPf2+d7sMbuDWaWoLZhS57T3carhsCCgrZFGXD?=
 =?us-ascii?Q?kBQ3TNmWAsaLymYitfEgo4i4wb/oKtbkqmT24XbdspRF8w/SeCquA0SbqUca?=
 =?us-ascii?Q?S9bD2HrSwZekwruxfGIdrm9BPACv75FNwUS2IhUEg3RXlvK2rbbBkZIY33l6?=
 =?us-ascii?Q?gTT9MI04o0P+xF/AtJIe+kMxoEBIGipMbn/YBsWRF1GPXSugxXUAAnhz6fCk?=
 =?us-ascii?Q?FqAgxE1QbSqMjSpQ0hSWrucMUFJw3a0GDC5CXv041AOCitc0S03h9DwlZMnd?=
 =?us-ascii?Q?CA2uFD8D9tOvnP5FOaCg0XccKESpIVsMKzp3M4+OMIK0R3G6lXI1QnnMjJlD?=
 =?us-ascii?Q?IQj6DwBSA0rRMnyGtNww4w3b55RDeprGJQ0ixXUGTIPYpJ8dkP8tIWYTfER9?=
 =?us-ascii?Q?msy5MFuJZGUrOGAtdcQY8uQzRYDUnzcSUne2dpO/j1+V2wCMlaG0UGD8N9e4?=
 =?us-ascii?Q?nMuqogQY5f34vIgOLuioftGNiQ9hckLcHMlE0+cUfZgbyOGhzcUf9pzL3zGR?=
 =?us-ascii?Q?8OZ3MQiwco6Wrdz2/loDVsyBVVeq4nmKjpvjur9lFgC9wIYJSFtyHUqDi4kZ?=
 =?us-ascii?Q?DRtw4Li8k5Sg6HQMG53W6IbtCjYiM9HP1j/YpkfeYbL/pol/sKPWjCOay6vx?=
 =?us-ascii?Q?c5/MyTp/Loi031VSIhIu2Si+e0+4h8VA3c6hZVkP9WZu0org9CJxFDfqJoZ5?=
 =?us-ascii?Q?DZ3r9Sw4qepjMLUqQHZQ1CFrxsnLRCoYC/8lHm5D+lyh+7nRkRx7a4O2ijQS?=
 =?us-ascii?Q?aJUCIcVGz6zmBZ1xF6Od6iKEcUUAqnRhzKLw/wkF/WI2HbQQY1YrLvWI0WVs?=
 =?us-ascii?Q?u2blDB+b5eUETF9EXqGDLakrlzySFPae/GYU8z5EWENynK5vz+PXD74rXLeJ?=
 =?us-ascii?Q?FjSybIxhBhSRMj9qxIpzL0Gqi3RGVENwXjq0ZpeHmw+PDsZjT2Lb7FK/mqOd?=
 =?us-ascii?Q?s2jVfA0DnO1J0bGZzELnKLe2sxi7sqnio9mLsoD0b3wp2HP6un4uGz4HSBAV?=
 =?us-ascii?Q?A2f5OtAvbUkImLPR8v5IVDXq/1Nnw27bXzDrHOLhgjlIYNiz/19sc78fD9Ji?=
 =?us-ascii?Q?O2HGssr90eZ6368xejYlvMDPomN56KjPO5Sp+1Zja9w4CCWNwXx56+S7sifW?=
 =?us-ascii?Q?lZYz/pRSFydrPmWQS1aKAtd01nbwLwZBTH+PgSZ3fJP2uYtR+i208GxuC+LJ?=
 =?us-ascii?Q?ZCU+zt+CdA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c8e6f9-a223-499f-d3a2-08ded032fe23
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:50:56.8855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUIOEH6wejSMYZgIL7+QKV8KcgK4hs0k52WU6p9pZh0x4ubTSUeIUpODHlBBfzsLuIdT9yDZzVM3ex1GvmRvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681
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

On Fri, Jun 19, 2026 at 06:49:55PM +0200, Luca Ceresoli wrote:
> Hello Liu,

Hi Luca,

> 
> On Fri May 15, 2026 at 8:54 AM CEST, Liu Ying wrote:
> > i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
> > rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typical
> > 1920x1080p@60Hz CEA/DMT display mode with a pixel clock rate running
> > at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mode,
> > while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz = 445.5MHz.
> > Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
> > clock rate deviation for timings.  So, for those display modes read
> > from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID
> > operation bit masks set, pixel clock rate could be adjusted to match
> > with the PLL frequency(for the above example, the pixel clock rate is
> > adjusted to be 148.444444MHz with about -0.03% deviation from the 148.5MHz
> > nominal rate so that the adjusted rate matches with the 445.333333MHz PLL
> > frequency).
> >
> > Instead of checking the last bridge's operation bit masks against
> > DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
> > +/-0.5% pixel clock rate deviation, check any bridge after this bridge,
> > because the last bridge is usually a display connector bridge without
> > any operation bit mask when the clock rate deviation is allowed.
> >
> > Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> > Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> 
> I'm perhaps not the most qualified to review this change, but let me try.

Thanks for your review.

> 
> > --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > @@ -489,25 +489,43 @@ static int imx93_dsi_get_phy_configure_opts(struct imx93_dsi *dsi,
> >  	return 0;
> >  }
> >
> > +static inline struct drm_bridge *
> > +imx93_dsi_get_next_bridge_in_chain(struct drm_bridge *bridge)
> > +{
> > +	struct drm_bridge *next = drm_bridge_get_next_bridge(bridge);
> > +
> > +	drm_bridge_put(bridge);
> > +
> > +	return next;
> > +}
> > +
> >  static enum drm_mode_status
> >  imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
> >  {
> >  	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
> > -	struct drm_bridge *last_bridge __free(drm_bridge_put) =
> > -		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
> > +	struct drm_bridge *bridge;
> >
> > -	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
> > -	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
> > -		unsigned long pixel_clock_rate = mode->clock * 1000;
> > -		unsigned long rounded_rate;
> > +	for (bridge = drm_bridge_get_next_bridge(dmd_bridge);
> > +	     bridge;
> > +	     bridge = imx93_dsi_get_next_bridge_in_chain(bridge)) {
> > +		if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
> > +		    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
> > +			unsigned long pixel_clock_rate = mode->clock * 1000;
> > +			unsigned long rounded_rate;
> >
> > -		/* Allow +/-0.5% pixel clock rate deviation */
> > -		rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
> > -		if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
> > -		    rounded_rate > pixel_clock_rate * 1005 / 1000) {
> > -			dev_dbg(dsi->dev, "failed to round clock for mode " DRM_MODE_FMT "\n",
> > -				DRM_MODE_ARG(mode));
> > -			return MODE_NOCLOCK;
> > +			/* Allow +/-0.5% pixel clock rate deviation */
> > +			rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
> > +			if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
> > +			    rounded_rate > pixel_clock_rate * 1005 / 1000) {
> > +				dev_dbg(dsi->dev,
> > +					"failed to round clock for mode " DRM_MODE_FMT "\n",
> > +					DRM_MODE_ARG(mode));
> > +				drm_bridge_put(bridge);
> > +				return MODE_NOCLOCK;
> > +			}
> > +
> > +			drm_bridge_put(bridge);
> > +			break;
> >  		}
> >  	}
> 
> Is this logic specific to the imx93 MIPI DSI host only? Or should it be
> made generic for all dw-hdmi users, or even every DSI host?

I think it's kind of specific to the i.MX93 MIPI DSI host only, because
1) the i.MX93 MIPI DPHY PLL(integrated into i.MX93 MIPI DPHY IP) supports
the best DPHY PLL frequency @445.333333MHz for the typical 1920x1080p@60Hz
display mode, which is lower than the expected/nominal frequency @445.5MHz
and 2) the generic DW MIPI DSI driver(dw-mipi-dsi.c) is PHY-agnostic, which
means vendors may attach different MIPI DPHY IPs to the common MIPI DSI host
IP and likely there would be no frequency mismatch between the pixel clock
and the PLL like i.MX93 has.

> 
> Also, iterating over the bridge chain is not very clean. I'm working on
> bridge hotplug (not upstream yet) and bad things would happen if a bridge
> were hot-unplugged during this loop.

The iterating is essentially the same to drm_for_each_bridge_in_chain_from()
except that bridge_chain_mutex is not taken(since it's already taken) and
the starting bridge is fixed to be the next bridge.  A few bridge core APIs
like drm_bridge_chain_mode_valid() call drm_for_each_bridge_in_chain_from().
So, the iterating looks clean to me and I'm not aware of any bad things which
would happen when bridge hotplug is considered.

> If the core did this sort of algorithm
> it would be able to be more robust.

Is the core dw-mipi-dsi.c?
If yes, do you think it's worth doing that even if the frequency mismatch
between the pixel clock and the PLL is kind of specific to the i.MX93 MIPI
DSI host?

> 
> Finally, out of my utter ignorance on the subject, is the VESA +/-0.5%
> margin generic enough that this driver can always rely on it?

I see several upstream drivers rely on it, see "git grep '0.5%' drivers/gpu/"
output.  And every display mode allows -/+ 0.5% pixel clock rate deviation
according to VESA Display Monitor Timing Standard [1], though [1] is a found
by a random Google search.

[1] https://glenwing.github.io/docs/VESA-DMT-1.13.pdf

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Regards,
Liu Ying
