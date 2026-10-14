Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11865CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6965C10EA94;
	Wed, 14 Oct 2026 18:39:19 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011037.outbound.protection.outlook.com
 [40.107.130.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ACD10EA94
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqD6N9V98mkKb14ZDVvfRyqk2nVxBqnEnXR+fulrYNdiBwcay10tVzp5xW522vNAQyCgkYVLW1m5kQOnzQbFpY3JctkyvSzxbHzlnL/s2Mtt9YwLLdlJ51iQj86JQzzUYHLWMnCCVKg+sHb1vjWJe+FBp42d8N6I7UjopnudUUPnFtWMEU6djvuvFzR9aSDLIXKhRPbo/fCPu5IHbc5apYjDQHGeaQbQEy3vSEjA2Y7UneLDffWjl2fepndpLmIph9kfrOjHkbAPi9rB29pfPsXw+9cyqJpqg9kbKM+wWVvW3P1w0nIayIfZTdDFvj5r39kNfJRZBB55GPX8x2K0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBgfx7sg4WuJOvxIzNr1com88hctd7lk3xlY9wc3CqU=;
 b=Yvjp113rKhQ0K5Aw7WtoUCIEQkQaGqDKnSnJFiUwE+G7yPXf1b3xIGHChVUr/9E6PQ8+oOJTkmK2P9nrZcOBwIX3920bEW6nVGXXShmIcVOjmatHKLiBU0L9bzszoE83rzV3aEpOmXqOm2npQZ9fZhgErFE9i0YtFZnHLYcMfpyQ2iD5sa4yxi2bZuMZ7+n+F1qCUcXfOrVRv1bG6kgpKVy6Jd6/hGHGU52yCrlrtQQYrEPtw2HwIloiDEqFxCrwf9hcP34sh0mEamGJwGhS9+DJzoF1aJCMgmPUxxlmKfsHWl3kk+Asll63z2NmQlACqrq55QXTWAA8uj9hxFTPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBgfx7sg4WuJOvxIzNr1com88hctd7lk3xlY9wc3CqU=;
 b=IsVEfW/lS7mPcHxEZvEz/uD39etsI5FLA98xk9WJ2p3D/xIojvcyABrDY5eqZ/APt7NkkyOeitdvU6ttHa0J/jW0pJw/SHEZ++IlVRJO778/qAo6OVbPDTNifvEv84OmATxPwGZAA07LikDTcdbhpzdBJLdAQmxOJbygJUrZoDV/PidFQcy0l8P6kCM+L6f2FFK5DrbfPYDsiDJqklNbwXk3/es/4XNbJQw2hQvZHXFjnN3Y1JabIldUpi/ee2YA/IHNWUVfRqXdhG0yeK8ufqYbc4+j3YnpFByNiW42Ft8oyQzM8OxnsoGA+mwNYJ10KlCfvAWtxpNvcy/4pxBOQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS5PR04MB11321.eurprd04.prod.outlook.com (2603:10a6:20b:6c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 18:39:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 18:39:09 +0000
Date: Wed, 14 Oct 2026 13:38:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
Subject: Re: [PATCH 25/75] drm/imx: ipuv3: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <as_MQ-uf1D6ZV3FF@SMW015318>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-25-586c9c026823@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-25-586c9c026823@kernel.org>
X-ClientProxiedBy: PH8P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS5PR04MB11321:EE_
X-MS-Office365-Filtering-Correlation-Id: 653b78db-c343-4555-93f0-08df2a226ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|18002099003|10067099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: cOTJBbfkdmwWTjBNmNt7jCDHiAaAI6XFuDcgoLncz3JrGFa7B6P0Drs0nyoFnRUdSZUz0dHK1lvzAILqpfLOlFqPvASWwxs5mHtPpmrjPKD6KOt/J7HVry082J7M33kyCcFDEm+vHlu5lmGR/48LLy5Qy+pbxHxFE6lXgY2OVyc2LQ3x9bnGij9poCvIQ4FtFW0RHrncPwz2K8vujCXP0XYjASnMyp7YjWavp87Honvlj0fHvYYhpO1vZtHRk8g7Q455OFUEZM+EdIkZNnxKCVa6qe1yojds/jDHuFkHve77mkF4gpWVtcO1GGclFXqhoZQ+F4ZlXqwa6uUYlrh+dE2Kl2vNT/ntxRBEO9ibqzbGvBfoZBhWkrXskpAAXzGIdG+4R+6inqjSH37193ZTmi0v4CBFCIpHtKCP/SV6GNxXRXQ8IvBmwx2c7LtV+T+Jlp1H6/w9c6vu0Y+Y400wvkA0C5B9S3PVpdJXdj4PjxYRppRnxWidyQVbjyTImbIz3rC6W/0rdwGmJ9ZCvuQndKg/6EET5zLUTFGFCFJ1c6+nuVBlxncpjn0OHigkqjgNGL/rgWDjQajFEXaNlyFxByTsB9cn1WrutdsMCUCofJExl83JDrNt4eqph27QIGKs2gCDeFQ62ODRKDaGhm0DqNE0VS4+iSvzsCEr6zBIv7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBCQlViIDTBjhyfg8Fv9lmReJAtrUx6sOvQDBQiZAfhuCrK3EejFVGq1sxW0?=
 =?us-ascii?Q?zY9iCjmE8JdGBa196jOPbNH0RdYzfqzLeIglCRNHX1zNNgJR3j6BA7RB1muY?=
 =?us-ascii?Q?bn8+oUFOeXaNKb2kzw6s8yzAQG4pXSSG//njejYJgSS1xElhnXUzTIVTgFsv?=
 =?us-ascii?Q?OTz02hJla7MZiNA7fSExOCtMmqpgWjC0XKAh1bR9IJ0JQ5gHqnS5RKidYdv1?=
 =?us-ascii?Q?cw08RGtRT8MXphu7G+hPbCVCtVAkS9/44qevAJKcgAfWLfq3xHvsV1eDbnDH?=
 =?us-ascii?Q?zLeQD11MK6M3ozTb3Duu1w8IrxSzqtHlZKi8NcrT92BljmrblALtszIaoNXU?=
 =?us-ascii?Q?z/ACEzAi+LO7k7uQ5wmA9arp9f5Gj93aMqzNKmPtKCaWXOkj+C41uyt3NCzp?=
 =?us-ascii?Q?ibHBIbRRTrdGptVt/2cfnbBVpan68tAU1sGw/FbxvhGIvWGfJfEhGvFjcai0?=
 =?us-ascii?Q?sM2S6offyIFs8yaTLvZb22ENQ8P+vS/6rDgEFEwRgxAGbNw5fPuci9SamOWL?=
 =?us-ascii?Q?RyrAFiyZK/DXaqeqRMvV4chg3lMNvGBQu8U3FEzVntcRBCzr32Qp0Sv2M554?=
 =?us-ascii?Q?NIjqtqPj25HCpSQNSRS6rHax8tXWNIPiq/MZgyCdk2uI76EJtMCznkeZjZHR?=
 =?us-ascii?Q?+NKXCwgZkDUDzBJQzdqJl5v2hi+C4KaHCJonCdsdfPS47Acowk71pseuX13o?=
 =?us-ascii?Q?rISWh2/wtfp5EtnCsmnuiSe75ks3u5UCKQZzJlDvqGdnqyzWU2XpX14YKa5S?=
 =?us-ascii?Q?LStVLDdb0OR2gKW0DJImS/Buim+CAyjiIKFB8ftZmIYcVvyaRRGFVnoQ63PE?=
 =?us-ascii?Q?JUvdqD3KoWrjkze0B0yO1BFyh7s1KErgOVfvsf15l737p0m0lm6cuPE24eom?=
 =?us-ascii?Q?8n/gIWzkewbtwbrIizEOHmI459Idl9Sjdhl/h6ZM7cGzLVGQ58WCQ6PKjY7d?=
 =?us-ascii?Q?Cs7IIphGljIHOjEadx1fRRg8P3hyNyqJM2DLLViDRY8eMQzFVbkrSIzbnbHe?=
 =?us-ascii?Q?vqrc6ZEyLqq45PM4K5qnndjDobdfNHTr/qXtKa1XW7Ot9fT9Gng4yInt4sLF?=
 =?us-ascii?Q?qLtzHUatMYUbKMr5/TL7740GJ4S2UnUTvaxj4scWdMiH0hcN3ze3gzRd/x1U?=
 =?us-ascii?Q?8DzLMqWfOilPGR0Fw6wzplG0YXKTldn75wz8E4g54RG+ywY4aVbPj9MWZXXX?=
 =?us-ascii?Q?/knwOPGhsuwHYgtFNywY+jfFjuVIN478n8722fyBw6kV21OPYN4lsh/NoR9m?=
 =?us-ascii?Q?ZfpQ6NK2KABLF1glrHEYUnGiabkIStVCXLY85iA3NzVyKEjcFcQ1QWbvXpHt?=
 =?us-ascii?Q?GU3Bsx6OIt3A+vKFL/dXAU4mDXZH20EOyMdiPH+lw8Zjq5jlU0YJz56rIZlV?=
 =?us-ascii?Q?c7UzmIzKnog2Nbhl/V2/nSyITCX+XhtMOEQ0h5Q5bUxYWgRiri3pNXtrfd9n?=
 =?us-ascii?Q?Ne9nCzlVpP4RHi41gbOe+4Odtzr1Q6iF1WfFRU6I8vwkcegxGBELKJsfBr6v?=
 =?us-ascii?Q?LznkmKMXronf72dWkWAUTMbIeV5nG/GU6vHgHhG/sYFYE8cTW7OHccL0edAb?=
 =?us-ascii?Q?eyuA67ZFQTeJ6r0Qzkl6sdgVoPIJaVDRjoQcXeURlYeQl7xxijLRSiTXJ/gk?=
 =?us-ascii?Q?ztljZMxfD9zQXFbgDrO/0+UOcXnfZhqX044FxwrYUnFrHuR87NHo3r4NOE1+?=
 =?us-ascii?Q?AwDBpBrlwBKzkPatxp4wKple0MtfiIxz8VDr2WE6gCqikqYRU5u0zQ4Tt809?=
 =?us-ascii?Q?qINedTbir0ORAm/9JbHixgbJaTaPqTv7bUc64dORMq51tCLF+c+h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653b78db-c343-4555-93f0-08df2a226ef2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:39:09.1819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bybhqnP3Zfrrp35rAYdTl0qAEDz7sJS/bLAIlAtoQFU+EhHlRCNMtS9ricK+MEKmtZoCUQk3eS3hAsskchdjPhNG0pHbmXxaFOV77/PQ4rzXeR96rRwSvoVKvyPuh7lM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11321
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

On Wed, Oct 14, 2026 at 07:26:48PM +0200, Maxime Ripard wrote:
> The imx: ipuv3 connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>
> Switch to drm_atomic_helper_connector_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> index e861b8b9d8fa..4ece79374372 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> @@ -312,11 +312,11 @@ static void imx_tve_connector_destroy(struct drm_connector *connector)
>  }
>
>  static const struct drm_connector_funcs imx_tve_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = imx_tve_connector_destroy,
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>
>  static const struct drm_connector_helper_funcs imx_tve_connector_helper_funcs = {
>
> --
> 2.55.0
>
>
