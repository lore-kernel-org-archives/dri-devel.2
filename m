Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C7C79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2D10FA39;
	Fri,  4 Sep 2026 15:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x9o7N7nx";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013062.outbound.protection.outlook.com
 [40.107.162.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D241A10FA39
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 15:53:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+BIyBbL2AaWX/4AT8Jx5yQMVzZyQ3HUsbrR1OmuBfP9eTRvb/gxBa+IyLMA4QLWy6A9X9tC94dDlPTYXR/wIIMKNV3Vq9Y7Q3F5wOenRUdRjZeK7LTpk3pkrHwlW4GkiP+ffJ4eERXoB4dzSLHwXhAHkYyO+d6D92P9O6f46k18SM/OH2Qgqr9PhL//YQ+Tavmx/Z3wFJWL+uDO8sresnf7jhcIjLWJvCXXuYUSsnz+e2NTGI+Rz2s/l5SScVwU9uGaw0jh9MlmYD7VTp79Ud9F9xzojKcgWILCtFU9sSnyP/2CDT8XHZ0JoyJ4YKNmy91JPD2gYSpqDEe9n02wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I53Hz1NumfK+0PhHjqQL2LQlIdn+0GcaiRvI0XF36E=;
 b=rfeU0MzBYsyPhF30QzPcH51NWgZruXgqDjW6gPBzazplAd4xODWbxF8GQXkja0Tx6LFQBmmzX23GOQJYdV+Kvu0hq8g+oEp3LB7SP375f9uD6OcWREDsqdC2YMsB/ugAjXEkLdtL2gG6ZkUACIkoHwYXNvlOO9XLhAsK1oA5ZgvBebaNl1ND60893lg/+K4MuFkBMUjZg7j8kt1nSo6vyNBJWSqlyz6Shx2kVFAMSZxYiR4eL6k2KHcRkAuBkT0PZWjY9c7vt1oEY0ZalKAVjgJTndzDorRcpVrzmEyyy4hjKiy63Mcv85hu3WAh95Hpv8qOGUfvXwHzsYJB9ztIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I53Hz1NumfK+0PhHjqQL2LQlIdn+0GcaiRvI0XF36E=;
 b=x9o7N7nxJE0+tMJ3oGnFdkObi2i9Y9pqrf7e1HOoFfKskCYj1JQhOIHmP0kHpdI3VOgM5Hic5nxGndNEw6lcMYDtFjBb6Q2OpJ091VoGwlTew6dxmsgeUyyfSGwJU6hB4aTz8hp9rm5wsvGahxU8TEq7kUDLE3zFxdWhRaERdaQJto9R95BrZ9+6fumDTsvVRsBFulS9v8blqGZ6rFe9k16hdK2s33GKkW71UKHCHlSRKtJYUqT91y1f2tSOaJ0gN5bC6ikVHgUUtifG3T0uctcDLpJ411ziERJnlFHXkZ36uygZkjmH56qA30sGrbFSx64OWHFTW0kbIjlW9Fq5cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB12557.eurprd04.prod.outlook.com (2603:10a6:150:368::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:53:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 15:53:23 +0000
Date: Fri, 4 Sep 2026 10:53:12 -0500
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
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Message-ID: <aprpaBDDznzWY83V@SMW015318>
References: <20260813092836.38367-1-francesco@dolcini.it>
 <20260813092836.38367-3-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813092836.38367-3-francesco@dolcini.it>
X-ClientProxiedBy: PH0PR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:510:e::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB12557:EE_
X-MS-Office365-Filtering-Correlation-Id: dacb419a-dd1b-4f99-9b76-08df0a9ca686
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|22082099003|10067099003|11063799006|56012099006|4143699003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: d2isafmj2F2aFxafaYeFQmDilQEBP/pmsJxmnr0mp/bxULbRp3jdBkPv6HCFmX8QiMTpol8+L4vc3N7TZq/OoSXXx0uY6s3jjZn4qYbLJSxELAP8uyNYJCdLQclJ655kJrPPqtZr98FJ20untQ301hCnfVmspE5t4P2cScrsapY0BOlS29aypmhIZVTpcmBzyT42r2oxexCLkxIbZm2UTcPxgv4z964W8TNr7Y1BvL+2rvH+D16oqBbsx12EGItirlWDXmjyMPT+ESu+x7LVjpNJPl+Ik72JHInG1QotQCUVHBwKdS2F95BR8H42Yy14J3PCqPdkPaDnVVffy1IQzoNIi4IvmEykRgeF0AD/c1d1BI0zF8dmJwNPbJuYOxhVn2Eh/KCahdUA6PBo8f9uZpoTFyExUjBRL4pCkiGc0D1tTaYDTASLbkPTN6YPxRQLQnritnk8Cc+5+MKB5/rsalslatSjIfgdb14uAl9dwkFseeWMIl8k9A1BAn1FEq3vi65BNEWuHhIr4/76LEZV6cc0D66BgWtn4sTtLNzotx8xicQl5REyr3rfZzSg0EeJRCU79MmMhfTyoUCEocbGRYqYMqXA7n2QGY5uowZpUC8pp4CnlMltfREfHpz4H4r+vk0ifWRZvlwX4GAeBQPZluBa4dqgemFwufoz3UBlEI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nb5GEmJXVAkFWCuqF4RwxIko3V9Hu7Vu9t1A5TWr1s8F+7a0UxemH29QxsIE?=
 =?us-ascii?Q?ep/ZwwuUNUwuhl12jALlpqnb1uhGuqiZq7F9qeFWTEyR6+MawIhVRtx+oIrt?=
 =?us-ascii?Q?lje76JJV1C58CsLZhxXzm/0cU+JIYf9d2pRGCy8FshAciFhpBmLdn0m6eVsG?=
 =?us-ascii?Q?yxEjqszBIT57yvygbr5/uloI8L8S3BlTSdDSEE7+tu7a354BtcW2pQl00RCc?=
 =?us-ascii?Q?V9EQa7MOSXSYDOxcJgRF3Ohst22KTE1f5usyWkad6bHCtg/bgbdAnM4JDpZf?=
 =?us-ascii?Q?s8/hApDddX5QJpliw2mTvAI6CMzuPuXuBSI+inzKXZvRP5UyPy5VL1N2e7+A?=
 =?us-ascii?Q?IKwRt/8MspyjoH/HH4D9m2pZQQ25XK6RK2Wp9HQLO/RdQPKyNkMlgMWvwbF3?=
 =?us-ascii?Q?fIUp0XR8indiHvaovYGWX00/uHlOD+vlNaD4Lt29RRbf/md3iQ6aKjkR7uGf?=
 =?us-ascii?Q?CLcGHJnatstTp6qrqKl771XlnKqTHwupXpxtVnwRh0KjU7lZtP8JBX9ESHj4?=
 =?us-ascii?Q?VbWK5Lhwhp+xCd9FVBYCAqdlZGhZoacAFF1YGi4SqRjThisfy67XFUtlp1fF?=
 =?us-ascii?Q?HYBQ0HZU5GF+ETvtaxUgDq+hCj3Ta8jaZIC0c4wL0oZXtuJOEz3QNr3vmkjH?=
 =?us-ascii?Q?GwVZr6bWaFkV0DcGcnJe5cnyLZlYmDmsAe48xo8MPlVGD4oWQfaboCiXflkS?=
 =?us-ascii?Q?32vHHrDXbltfLBc7iLYCCY+mZ156szPcN/ZXyAZJYpmYTxilCpbrGsLdBx51?=
 =?us-ascii?Q?z0BIYPqYE73JjQF/SvQcB7paWpyScSSz31cfl/fGjglg2iLFdk90lqWI2RRE?=
 =?us-ascii?Q?XZhvbh5pczdIZlY3pqRASFc6eZ1sL4mRL1IslWo1fhO/Az//8xgJNwtFkTTX?=
 =?us-ascii?Q?ULUWVDPKysq4MZ5VwXoS8jaGVNRi1mOupNUTIiDdCKbROU2Mf/U86DYTJjFU?=
 =?us-ascii?Q?mmYlOz64+1TRejvQTRoTdIv9KuIQJ3Wx4uYALSjhI+JeeORM4sOJYEr4igmd?=
 =?us-ascii?Q?KT6EPb636NqX6ct2W+qvSNGa/9g0GWZLs6UiX0qz74HkCfsUVW2qGIoxAprq?=
 =?us-ascii?Q?wW4H4yVgyBq8NqL3CpmjBXDbjGmt44YaFCWUqM9HenmtTUL64xuIt/AwvNnK?=
 =?us-ascii?Q?fxGouijubUM7xlEfVHygUmCD9U85DwyW5MziXbF7Pnkvl12uH3sP2duJgJJ0?=
 =?us-ascii?Q?hVLDc/uLjc0qD5nRpMlvh07mV3xEG8Pk/bzNbPJ2Y1jS5AhVRmzXEEPjX3y4?=
 =?us-ascii?Q?4Esed5IGyPeeeTqksDw3nlFgZ4I+cin36w4JyQFiYcwmNbXpJ7irJPKxuA/W?=
 =?us-ascii?Q?KDl6loy4JyLl24nUyJfPotfGFIDQCxOQ2k1IMuhzKZ9FAJ9rL9ALWtBBf2L6?=
 =?us-ascii?Q?Q2JmHKhARS7XufoV+q67mMQ0GSSQJSqX8lm/Axc37znE2CeiB+yIgXzyZaUD?=
 =?us-ascii?Q?iFzTlAVk1cGMOkX+mIFG6SFC8qPS0XSJtGBoVbg0OE/d6TaoP3xfxCA7n161?=
 =?us-ascii?Q?JhmVNEMW26JB141YQDPjI+gyweXDRdEkq1mU9GB/dPQEFgU4cwQAqrBY6PLj?=
 =?us-ascii?Q?GmXuZn9UdLCzKGQI8F4bt74pLle9vRCvuDXMhzu2edPRhcboupiDytMKzGyq?=
 =?us-ascii?Q?KSfmIxMOdEzhLR0iid1+/6w6d+lnqwR+CBxbgDWvc0GRVHITBGod8LQdywBP?=
 =?us-ascii?Q?0wW4bL3Vp084cjRh7DsHjUMA1Xprb9b/cJ4jq+fhZyP4btIiOpqqg6WFFr6S?=
 =?us-ascii?Q?0m7oBJ/hw/jSvUuKZfXYlPvxYSsfaWRJ6nBF4C+JDTyiOpfxqvsE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacb419a-dd1b-4f99-9b76-08df0a9ca686
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:53:23.8708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ohI92RRO6aveHi/778GGj70OiV9HzCxBAYzscrPv1gokHzxuN7svIsFAgzR5NHjLcEvMOexeym5VOcQRsyQSbzDolWS7EEatF+l6Bp43QlQfewqqkd6vrinyjjD6lRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12557
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

On Thu, Aug 13, 2026 at 11:28:32AM +0200, Francesco Dolcini wrote:
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
> When the optional property is absent, or it has an invalid value, continue
> using the format reported by the downstream display device, preserving
> the existing behavior. The code is not validating the DT for
> correctness and just fall back to the previous behavior in case of
> errors.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa6UL[L]x
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Marek Vasut & Stefan Agner:

	Are you pick this patches?

Frank

> v4: add r-b and t-b tags
> v3: improve commit message and make it clear that the code assumes that
>     the DT is correct, when the DT contains an invalid property value,
>     the code safely fall-back to the previous behavior
> v2: use the common bus-width property instead of the legacy interface-pix-fmt
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8b4a500347fb..f8ecc8bbd63c 100644
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
> @@ -211,7 +214,10 @@ static int mxsfb_load(struct drm_device *drm,
>  		      const struct mxsfb_devdata *devdata)
>  {
>  	struct platform_device *pdev = to_platform_device(drm->dev);
> +	struct device_node *np = pdev->dev.of_node;
>  	struct mxsfb_drm_private *mxsfb;
> +	struct device_node *ep;
> +	u32 bus_width = 0;
>  	int ret;
>
>  	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
> @@ -238,6 +244,24 @@ static int mxsfb_load(struct drm_device *drm,
>  	if (IS_ERR(mxsfb->clk_disp_axi))
>  		mxsfb->clk_disp_axi = NULL;
>
> +	ep = of_graph_get_next_endpoint(np, NULL);
> +	if (ep) {
> +		of_property_read_u32(ep, "bus-width", &bus_width);
> +		of_node_put(ep);
> +	}
> +
> +	switch (bus_width) {
> +	case 16:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	case 18:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	case 24:
> +		mxsfb->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
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
