Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FD606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FCli9A6P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8CB10E18D;
	Mon,  9 Nov 2026 14:20:50 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011069.outbound.protection.outlook.com
 [40.107.130.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A13010E18D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpnpxYJSIrn+6KwlsqkV/7wuqpQQIvkM7Zvimc/cvER9dggEezJquXR/N2S5R7gP1UEud4RVfiJAyhJMSnNc9wQmaTcfHQOQSgdS4mU4PTcsLbja+EGzeIOPWRf423Q67ji2wN1bDlUacwjZCEwm9dQEPCWKpMoDMtWO+8xx5rxeBe0TvQmcHg/VA77t67rpz+ZSP51fCHBCfRNR6sUPtztYqfWZ3ynVsH85FkI+9nw5LhdzWT3dK2785sV9vm8lTGrsRTuQp7IVewrLHbAjfi3NPjyrtAKBo3DMH62ko881zCNXLXP9ubb0xgs3TK34nL4diNyMWlN59NZjq920jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGC7Xqvp9CrCPYVN5VKslRo7Z6OFZLJ/GpA5FVauIFg=;
 b=e1nNHgGy/TTjbBMi5d1b4hhxjwtb/hIK7b7meatatnY2pWuVc6/QT+eP+KgCoRXGy2POD2mt69EHLTvS3FeHHSa7jfWLi5BqPLxfuQ6tAU7gD4qEtXiUfA2T4q8WLg/Kkc82wi7dJ9VgTuC48vLfuOTZugXfcf1rJW41O654S4vQT8HC5iPQKlVhtpWcs9Ty5Yg9XWtF7Zgwjfn6EfI1QNHAeHFEQR2/+kHK99QFX+wfwtDRwWbR1PTNmWorJD+AIQhKfhZcPWtHE6ki8xJWkXWjRfBNbw1BmwxOQEz/0/wAkhuPs90Y0L5uidaWWDj+hGuROcRe/jqLgeCVQ1LV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGC7Xqvp9CrCPYVN5VKslRo7Z6OFZLJ/GpA5FVauIFg=;
 b=FCli9A6PkICL6EpZufE3q5ZeYsZFrBmIET2sgsPD8OEcpTmbiTjlK2Y5noLQZr8aNsjAZlIqzTn3JdmtYD24Txq4IKvovmZnt0gLxZyi8EIKZmqJdeHzlyQDIB+Z8Hb+OerNmPF0SuhBapBXfl4lG0vDcbOGlP1lu1duPgmAP/yZpDVeh8B2s/471qzn8hSwdE9nqcI6L6eG0j6fhTI7UPHWq7sI6ykrWBHXyhMqSG6whCRlf8axoBdxMahaWeZqIvWI5ZPJZ6MWk1awpzmz34H3oQhGoLWFdDRgX/GPEijgPT5vw5jFyZq8SlRUZlrBBgFVX8l3W2ZMJfbuFzfI4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DB9PR04MB11627.eurprd04.prod.outlook.com
 (2603:10a6:10:60c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:20:39 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:20:39 +0000
Date: Mon, 9 Nov 2026 16:20:35 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, imx@lists.linux.dev
Subject: Re: [PATCH RESEND 30/83] drm/mxsfb: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avHWpIZSkyrkJMmw@vm>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-30-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-drm-no-more-config-reset-v1-30-1f58d1e33380@kernel.org>
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DB9PR04MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 6517d44b-14ac-4202-dc83-08df3e6ca120
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|7416014|376014|366016|1800799024|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: GRJ6JB3ZjaEGdQSBQpeZW7nh9PjfoEV4np/942aYx5q5X7G0hLT5bIn24VdtziYomo+1kJZ0uZk4QDjZxdccY8kYhhJHETTNamQebEdBmFtfciciETEBEHfH8pJdxGmZi3OKVqlcodPDZUnEvGFvtbgYX6tiRZnawJzxleRgNM1WJMr6evowmksLS7hQFco4B27Mm4zFhcS09z+cyZ/zyVCTkZooiMJ5JAH/4eWaL4sZDJCGnXeWxVnGri2gK1nQRGER4EFYdv3kzk2nYcWkjBmZhcz0WfQ3cKk5A8w05eLte1f3fK4tTiXMnktxe/7O5jK9iGxVBvB+WdDFZs0g+3VM000/+8Os6EsOLgw62NC5W0I5zO5eGCBMBLYqM6iU6ubYy8YU2pJiBDPIW/ka8DQLM1ym8dauxILmUQ0womQnrujrKVWUbmCf42TbsY2byNOhtsVXsHpbof/qAHNzEN+bG12jVzf19toFxiF1ea13bC7Faer/fzw2Z8glK6C47T9kaWNwk9Z1BoEolp2x0R2JPCHUYABsodYmm5XevFngo0wcqhZz2VG6LOi4oEbgcd3NDuwRWhYNTO5tnEUzqgL05cBnXDIzqOYLEe9ttvIipHpkfFqLDP6TB6rkuq0OlWX2tI5x+iFzCN6LgzH8qhGOSu7Xadjg40sWduGHz3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbnWtI/KCyVhB2J+uah2f3IlPLsOs0G4x98HNdsKCj6g52MUE89ESko6e8+1?=
 =?us-ascii?Q?xYmtjY0EsGsUfAL1N6YUMaVyd8LwpgGqn7nBPyVgf+J9264qv/YAjHUeD+Ye?=
 =?us-ascii?Q?ApChXhFJN+jLmiiNCadEZW0Y8V7DGR//EdIBOD/7bNFXcLHo8Ydk6uMPCB+Q?=
 =?us-ascii?Q?h0bGDI/SR5zRZisZ/OTE2GobPFlr7vFfE//OHHg2v1Zquv1Qs1edILjLusKZ?=
 =?us-ascii?Q?Ldb9XggPk+MNPxg0NARN/2khxlrruT+IPn6LupELM2t3uAEzrDVj4CFgMrh2?=
 =?us-ascii?Q?typZet7GPVjflVIL6Smr2AZvshoKDp6Y6Mdau07lbXVInHNijhXSdQZNAYTy?=
 =?us-ascii?Q?oPYKBmpX1VK+lv/ZngI9sDXv+UyCTkpTvln+Heh2tUYgSnpNLytj3gy3C1Qy?=
 =?us-ascii?Q?B9ePylbK2VTqz+7X2aCASaSCNzMNKwrg0df7oJWU06ThPJ312uFmC+SoXF37?=
 =?us-ascii?Q?NtD0ZQrfsOxvC7pPJHbuGRww4SdLPULJnbME0nkAwd/IwkvcGgfwlHuGkG4l?=
 =?us-ascii?Q?SeNPvjz3JYmLonf1E0su3YopUx9EA7hARaGWD9/ZbH6zA0oNzSP2TaLcCxA8?=
 =?us-ascii?Q?Y3XMGv5YvDoaJSpei9Cyv9h3saRZmayZLFmoTs/KHbFZMZctD6UPdB3AxlNT?=
 =?us-ascii?Q?FPyzEgAe5DMekHa93EWrsjBJXUJ0mqfj6xjCqoV8n4nXrZ7ClGnRiGF/p2do?=
 =?us-ascii?Q?LaBi/0KBn3o76Lvn1hMK1N/iVTMhittOIA4iZW+OC18jfm8qml+AAT8zrjxA?=
 =?us-ascii?Q?OKVwmZCpVmxooZtm8z9NeZlYhjVgEsBluUk6p2Qk6PRguotxsQVbkVn73uJj?=
 =?us-ascii?Q?IsDpPowaPBKqUfKMvwwXv8fv6FWfOJCsSeF1tOJYshA1Kd9+JcZ/CvZEnt8X?=
 =?us-ascii?Q?PO/4GUtYb1Qkt2X/GFCAtL4QXa/Ic+ULZZXpaaY1pC+qiQBtqK7ADk5nsGaB?=
 =?us-ascii?Q?7qpoXbCxV7zFphxmZ7tcOpOSLQy73aW1fnLmrtwN2jhmqQkTs+asOYFZa9Wi?=
 =?us-ascii?Q?0ujvUmFdPtVPBe3AT+hjnUEyYWl2hmlHzdi1uVg4jJZjOtIhREcjzFm3d3/G?=
 =?us-ascii?Q?wM2XQXEMyDV6idsmjLSlkwf3kJKbF2kDbjIS6BMubOIKVaBB9c2jUmSwJ9ML?=
 =?us-ascii?Q?mLD1z1EWpIm95ot0ER2wn4TnBNmXmsXiHgnUODM9rUQR4xhrEG12EtSrWQPD?=
 =?us-ascii?Q?ZR2w3n+qnpih3cCt/xoU8+Sb9qCnGDXONhrfH9BfgU9+mqjpYu2N+aIjRRwW?=
 =?us-ascii?Q?YuFdVEX6P2a+ugRsg0fmT7G8XzoAy0+HCZYen07tdCw2Aewx+w/2k4NjTVUz?=
 =?us-ascii?Q?Kv8YR0xsrc6wyunOYhEVxMp3HbmWMyRMLKJXyLaac/sM1BySBQwCYgmaKKwb?=
 =?us-ascii?Q?pt3XCMc8GZY7JQppksX+KuAggQhalJWBJSMbGJbmlp5JwvQR0p2+EVEFCHlv?=
 =?us-ascii?Q?q+im/XOGOU0wA2SeVPoFoNarYPsDywRNV4KKj1xthanhwjcSoBd+GQh/17S+?=
 =?us-ascii?Q?WwO6juOuQOEw0fkuv14ongi2PaIdP+1Ne25qNPliaxmyVqW8j/zFMWUNtnyU?=
 =?us-ascii?Q?NqMDQ/niLZJ24xsEuEYNBeN4SxAzPTTiqhYM0SmSKDR1DB0QmKzR0bna4TCC?=
 =?us-ascii?Q?zlN5ysWyToj21n0g1NieOXXZFq3LHxOP9vyuSMfTc5fjl7hz+pe/M2U3jFB1?=
 =?us-ascii?Q?V3QEDXjlWQXWlCERnHpmYUgVueSZXoCRBbetlaQFTOL9IICNlC8i/fw3JdVw?=
 =?us-ascii?Q?YQhCyao6J7YVviNeWv9tqyJUgnwpzXI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517d44b-14ac-4202-dc83-08df3e6ca120
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:20:39.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phN5SRdL1col4CsV7hHClH3nQGi1Y7Wd/BeNq5cGulAxvJ/XQnzznjq1lLqLc9sS3ofL4vScv7+EGdQzeCNTpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11627
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 04:29:39PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 641691fc92c8..04ac1c06f435 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -323,5 +323,7 @@ static int mxsfb_load(struct drm_device *drm,
>  	drm->mode_config.helper_private	= &mxsfb_mode_config_helpers;
>  
> -	drm_mode_config_reset(drm);
> +	ret = drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto err_vblank;
>  
>  	ret = platform_get_irq(pdev, 0);
> 
> -- 
> 2.55.0
> 

-- 
Thanks,
Laurentiu
