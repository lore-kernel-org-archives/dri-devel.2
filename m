Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6912AC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E9810E88D;
	Thu, 17 Sep 2026 14:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iy3mhe7+";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B1310E88D
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTUIAu/NQUI3hEkTCBHq9JUpbI143x2cxUEFB6CHysOwywypcg57Zif/Sxn2XGbD7xpf/rhdOGBNB+44noVEnMpl7dbYATAuD8oFNoMyrISgNvKYempj8Mt7C0P6ge+wB8m4TyclnUg7nlT5wyvKCfsX1pYTwwQ54VGaR559awA7qJGyMT2gKpVCEK0BgQ9OdX0PJy5dF7gQ2rSYGot8w8Ir9cWbPJgxQLfBmOPWMq68RJukColNP3xssQr6vL+QRohdnptz/jWVx904pq+tp5+mhKz4n4M4xBVYq7SYNjCEinFLEDpWSSVsu1wzIYVdJDDh2i13aUC20ZHEWBoWWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF3K/0Ps+QwSicPEWcXZ9rL6zIZXbd5WKY8sDsDWoKk=;
 b=twfXlL5ZXw2MKr03QVDtJfrRaEPeAGdTa2V3+IPdXB33AQDknrTU1mo+TsS/EuJXnQdVHjAhTxscnpyyBwez6tv/oVAHxYq8xwfPL4XtZcO/MpzfDdAmjoqLeDUALfu68Sq36w0TMmam9BWmET8qJgZ9xIQffmp/RysFyV1LzrJNxmumSJAQK+excwfP7LjqUx3nv5eQz8It8tVrBFBEoWeTXO6CeMISzFRUmEfjRRgQAKs7+pj/266WrCzHCPH+cYGrNDmTjf7TRZRfSO09wdY1204FqPiYl3aMyV3ga/CjOPJTzrKx4aUhA55neJOICbwBNhaU/7XVnlg5Q8vXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF3K/0Ps+QwSicPEWcXZ9rL6zIZXbd5WKY8sDsDWoKk=;
 b=iy3mhe7+k4TFT/omdXEn+pkNctgrfHwXJ8KsedlnoW9qG1AH5aJQy6hK2uP0YQci4svckNJpOYwrZ2DFb9+JG3eeXBI6tmY5vqg527bwtHo2WHQL8kVAHXahatM8gA/IkSlPyHH/2/xynyFnISwXStzQxTmycG/BiDLCTpzRJVQCkWYUey5DbCPXK3QLQ/tLYg83WfoKUvQHttPOe+wTmXkYfY6WxhgrLA8lP9OiAowTwXbS+PgGMmzzTTu1uB48Z6lr0iSPOMGRfcPqAJJVbGhNMA1m76Jn7QGO0TFMe2IVN7OnyrX5yPo7RB0sqIDqSfW55dkwSS6UaIJJqwoTzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:24:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 14:24:42 +0000
Date: Thu, 17 Sep 2026 09:24:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v5 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <aqv4Hr10KBafVow2@SMW015318>
References: <20260917140042.118181-1-francesco@dolcini.it>
 <20260917140042.118181-3-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917140042.118181-3-francesco@dolcini.it>
X-ClientProxiedBy: PH0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be9f981-c42b-4841-e8b6-08df14c76a29
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|4143699003|10067099003|11063799006|22082099003|18002099003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: sCZTTP4JzqRdB/84WJl/MrWB3U1Bk26UrvrYwZW/RnKD1vwPKDY9FqXjnO07nPEV3scsEOnSyFqK1gqeJQ7W35wdnGcXeSIJOm64eTgVftegDzCDBh9sOvWWGsipvIHWvpEmbdpQd9LxvZTwCvIZSoCsXObIFJ2FpvnLNmkAhwxuKSf1GYPT7F137kMTk0iwx3sKhg0DL0Oi/nXR0TBMsy+++Xij6Oj7uWr0iDdwW6+tQ4m+tJATS06J+nTaERb8tp6X18BRS3CQA/hvXh4EphFtIbC7IG3Idv5XszfcbMdoMAIGkC2X3JS4CAQ2HFcZDmVaNrxZGxC85RUUMql4/CvRIl6vntZmpsTBs4e92Tpc6uEj7HNcnfGIAhNLnXgpE+i13Y5LgtrDWwHT+2q/EhPbfKENO2+feNX903Kf28oj4BwB05knjPIYSbiIr+TGm6oOprsGFWt23+3OajB7nMJw5ImJufmsRhXVp0pSrGBoL+s5t7AEK2jL7q2VSXjKuEL0Pe9Dx9xzZtkeOgwHUCMpxRpxFeNyXT1OcsV0Zn68noxCD0NMqZwWot92nS9jH4jifuDJt9ZoyWXvm/hjenxL/iKjZQOJjws1JXuvC+lBH2aClzmv7hHKhj/TcgWU7atIECvtrFIA39ghkWrc/kTwnB6Mg5AvGM6Bwvrc5A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFXX3L6EBM9yhlbZPfV4kWJhC9eduUW3J9e4X0eXbWxy6WlqE2BLR7kNJJW2?=
 =?us-ascii?Q?aKjszkS2olCBGBGVZmMWe8QoSGaXcTAS2qbguV90URyfJ5ueF0Td1r31rYjS?=
 =?us-ascii?Q?QA2O442XNH9asEoDbjvQmwBcOZyEidw3Vn5rwhybmFX9wD7ZFeYeSLqCe2mN?=
 =?us-ascii?Q?ZZhh+bbggXKd3t2YMqwshfNXrrmzqQDZXIEqO/7yIS48UX+TJGpcHe/pwYei?=
 =?us-ascii?Q?6WSwo6Lk0gRZiXsfmz5DGD0aXXVqyMY1EMOK9HN7hyPr2fqQEyOZj3z3gfIv?=
 =?us-ascii?Q?MneGO2PD3uRJUH1HzFx9wcZhBDBoC4Nb0g5o2dnJW6Ywupw8jyoeX0Kb7IqF?=
 =?us-ascii?Q?/NgGHIYd5Ne8fyvc4IEfK8AlY1j0pI348olSbNe5gDdzOls6fJ3X6DiVC40j?=
 =?us-ascii?Q?wCRDA2TUuzUrHBIauL4K2A15UIJvwU6sv4sVT4Dtw0iGu/e3q3Y7BrYPfn90?=
 =?us-ascii?Q?9pJkBe5XjBpVDUIHXA0SBaNo76iNQrPlIzz/9z4XZbd9YKD3pd/UlNLNuKZC?=
 =?us-ascii?Q?mcmrrESZU4gzAvB9sXPt7IAiNgRuwNhoTByAGtYmjhrFT/jaDmWWDhvoykvW?=
 =?us-ascii?Q?CttgEtmb2PJu0I9yYtUVwNKrXvQ+RNlna+miQVah1LvrnZ20OS9irhsBlkf7?=
 =?us-ascii?Q?VVBLRdBhIHWn4kPSIVZz7cgygnmuhmtfEylTK+EKcb5iWpJGVq5xjEV7fHvW?=
 =?us-ascii?Q?MP6uhq8BzJZ/pbjIYVOG329Id3DXGQqx3N+7kFM2qefhIB5Irp03Pji0LycM?=
 =?us-ascii?Q?qjycmjwYRbP8Dmi23ep7d17mkeskqarRpEmf08IcHTdgkZGzZ7cvGcR3lB7q?=
 =?us-ascii?Q?KA7wZ44vhIeZCkrnod6n3kSG4fWcVzYyy2LSX8vgLFVbzW+qEKQGCOcSd/uQ?=
 =?us-ascii?Q?Orxyv3Ey/i67jMe3WuAcEcU2fVjbVemFttOcSsmuRIOHxTikKh/IsOdPkyzv?=
 =?us-ascii?Q?vUwN0M6MxTzJypJSTUyepoTLoNj2S4WEtodbvbC33eMZ/A1OwzikrvFQAAx0?=
 =?us-ascii?Q?EadfguUkdJ3w/5yJxw+Q4QL5y2mCOl8k1HWQ7HxGb4gmIywsnCVtZF6jy1A5?=
 =?us-ascii?Q?EjBxV6CD4O/C6wHtJuny+8XbmeKVwW3rqpRBVaJw/1Z7cJg01PNLnLZ+zIwS?=
 =?us-ascii?Q?z1UUvFYNCOz/kAnTS3/8kC7+DZhVxL7dNLXqTPrxJvTwRF/BQ2ouIhEcwTCN?=
 =?us-ascii?Q?RU3MobjwG1F7UXtwj4E5qdaOaa+b7KUT6FiyzTvkCg2lMVwlhkxSPhZRItGL?=
 =?us-ascii?Q?muA2mBAtw0DOPnlzLVSqR6ireRhFOcrPe2frZLh1s9Vm5sVRccSetaisgkpf?=
 =?us-ascii?Q?Tke5xCvI8Aa/UToFWSUzVvF+PpFypzaW8ZG4xi4RcxNA/371/8I75TIqjSGw?=
 =?us-ascii?Q?uQcLKHDfta0+jSOyPy1ggLhG9koHCizBGoGud8ZWZdcnq1xJQRE5QwbmZCJC?=
 =?us-ascii?Q?uccw5O/nSEm6bMuTx2xKg0dJrXGkPuIgy97aYh3kA3lKjmqbCGZQzl+bOp8/?=
 =?us-ascii?Q?fFZmzjOoGyBVhO5XY2vwQACY3q3YNazLTH+FVTuUqE7cvsSChSF8H4f3Bdmz?=
 =?us-ascii?Q?W0lObvQi1QNdQ4zkdyIBGxMI4JozZI+UYtqcFBAwb3sRQoo92+2WPanuswZB?=
 =?us-ascii?Q?kfTPTMXBGOnUqWes+LlIi3gPBTKtynbG52SwnMkloiejczitrXPGc5FLES1N?=
 =?us-ascii?Q?tSbfOEIljeFt3jICCQGzXTM+PAMSab4tD9y9ZAHwMBYlV97jCfmyOcZ0rOp4?=
 =?us-ascii?Q?6djwfeNprjy3UOG3LonHYei7KvOYoQfzDMo67r9AhAwgV8vMO69Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be9f981-c42b-4841-e8b6-08df14c76a29
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:24:42.5343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E4EguQP34AC9wAFvbqhjFvK1t8sjn10N4u/ZWzAeo9KN2N8evdB68yqqbaQvAo5VZRTlO0FvFJTFMbnhKLjzRyG53icFngWJQ14Fcky/S9SLF+aCMQUCPIEvxBET8xM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684
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

On Thu, Sep 17, 2026 at 04:00:37PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
> format reported by the downstream panel or bridge describes the display
> input, but it does not describe how the LCDIF data pins are physically
> wired on the board.
>
> These can differ. For example, a 16-bit LCDIF bus can be connected to a
> 24-bit display by wiring the available color bits to the corresponding
> display inputs. In that case, using the display's 24-bit format to
> configure LCDIF selects the wrong data-bus mode and changes the assignment
> of color bits on the LCD_DATA pins.
>
> Read the optional bus-width endpoint property from the LCDIF output port
> and use it to select the media bus format used to configure LCDIF. This
> allows the LCDIF bus mode to describe the physical interface
> independently of the downstream display format.
>
> When the property is absent, continue using the format reported by the
> downstream display device, preserving the previous behavior. The
> devicetree binding restricts bus-width to 16, 18 or 24; any other value
> means the devicetree is broken, so fail the probe instead of silently
> falling back to the previous behavior.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v5: fail probe on invalid bus-width instead of falling back to the
>     previous behavior; factor the property parsing into its own
>     mxsfb_of_bus_fmt() helper. Drop the r-b/t-b tags below since they
>     were given for the previous silent-fallback behavior and for a
>     different code shape; needs re-review.
> v4: add r-b and t-b tags
> v3: improve commit message and make it clear that the code assumes that
>     the DT is correct, when the DT contains an invalid property value,
>     the code safely fall-back to the previous behavior
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
>
> Dropped for v5:
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa6UL[L]x
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 43 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 +++++++++
>  3 files changed, 57 insertions(+)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8b4a500347fb..641691fc92c8 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -12,7 +12,10 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/media-bus-format.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/pm_runtime.h>
> @@ -207,11 +210,41 @@ static void mxsfb_irq_uninstall(struct drm_device *dev)
>  	free_irq(mxsfb->irq, dev);
>  }
>
> +static int mxsfb_of_bus_fmt(const struct device_node *ep, u32 *bus_format)
> +{
> +	u32 bus_width;
> +	int ret;
> +
> +	ret = of_property_read_u32(ep, "bus-width", &bus_width);
> +	if (ret == -EINVAL)
> +		return 0;
> +	if (ret)
> +		return ret;
> +
> +	switch (bus_width) {
> +	case 16:
> +		*bus_format = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	case 18:
> +		*bus_format = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	case 24:
> +		*bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxsfb_load(struct drm_device *drm,
>  		      const struct mxsfb_devdata *devdata)
>  {
>  	struct platform_device *pdev = to_platform_device(drm->dev);
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mxsfb_drm_private *mxsfb;
> +	struct device_node *ep;
>  	int ret;
>
>  	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
> @@ -238,6 +271,16 @@ static int mxsfb_load(struct drm_device *drm,
>  	if (IS_ERR(mxsfb->clk_disp_axi))
>  		mxsfb->clk_disp_axi = NULL;
>
> +	ep = of_graph_get_next_endpoint(np, NULL);
> +	if (ep) {
> +		ret = mxsfb_of_bus_fmt(ep, &mxsfb->bus_format);
> +		of_node_put(ep);
> +		if (ret) {
> +			dev_err(drm->dev, "Invalid bus-width endpoint property\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> index d160d921b25f..bdc47ce5be79 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
> @@ -46,6 +46,8 @@ struct mxsfb_drm_private {
>  	struct drm_connector		*connector;
>  	struct drm_bridge		*bridge;
>
> +	u32				bus_format;
> +
>  	bool				crc_active;
>  };
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index d8ebebc5314b..1d78c486d147 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -386,6 +386,18 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>  	if (!bus_format)
>  		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>
> +	/*
> +	 * Prefer the bus format derived from the OF graph endpoint "bus-width"
> +	 * property when available. Otherwise, use the bus format reported by
> +	 * the downstream bridge or panel.
> +	 *
> +	 * This supports mismatched display and interface bus widths, such as
> +	 * a 24-bit panel connected through an 18-bit interface or an 18-bit
> +	 * panel connected through a 24-bit interface.
> +	 */
> +	if (mxsfb->bus_format)
> +		bus_format = mxsfb->bus_format;
> +
>  	mxsfb_crtc_mode_set_nofb(mxsfb, bridge_state, bus_format);
>
>  	/* Write cur_buf as well to avoid an initial corrupt frame */
> --
> 2.47.3
>
>
