Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9A606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=W1n5Ac8d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB9210F367;
	Mon,  9 Nov 2026 14:15:35 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A42F10F367
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLgkqDmcaLC4sScKNFUQJbwbHOoc4rKvxXO84FLK30xCwrI73fSvFZ4RDjZIRnHJdcDsUIsUeM1zplkoUxIYt3aKjBbbwMMmq6QMzKKp3NVd54M5wugeR9pz/ywd15PcaU9CODvVX785CLnowSMznuwPjhQusMefTg3IeCRDDfuGQ61n+XpJhHEAWkLZKU4jCHSzC6fhanIuH0OXePCsOM2gN3kCEag3+sWPqG+aeI39zGwFcOqPHSLCIFBBrswFvwtTY67zOZXF1UrjbbEQ2DFIEj1cqEqt7bi4jxx+1aKovaJiT+/OBQg7LEr7ZpIrDtF7zfowyHiZCMTHK1ea4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXrh7wF6rf0fMrzGy59eKCj09C2ll32+H8+16PlXNCA=;
 b=bgRihssT9Kl1jaAvTAKVCRVgttXdyGLvlU1mZYOsKUl9G1bYAe3Emd5zTR/dVcL5dfNsT7QyrcCWOVQtFg5gWwdzkWqdjLSAsV1XBcJ5Hd07SIyoSwiqQz0Q7J/1P6DCaJFq03jClP9KB2I+YNmKGQQyYo5iCqq8nxkgJoGAMqeEtFx/g5Iz4Q7+eDqNJYyEM2mvbv/hkgsflgRKPA+eSz/a0VUX823poFduDd0aXRt89mVOQtcXbykt4/kXhShkr6KqW+quRjhlIakU7x9WUcF0erUL6DxRTsBeXpw87JeIFKePgRvC9sdqg4gTO+BsOxShYmeCa+KDDP2fSjWe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXrh7wF6rf0fMrzGy59eKCj09C2ll32+H8+16PlXNCA=;
 b=W1n5Ac8dmTIA4W7/im+agyRA1kFDF9lTWLssrbf/6ka/TXxqjsT6kkbK3xjJlpJT0d2TdYGNYXR753RyadmGvzEaW16+RjofnTTBmtc/ssXcPNlkRuoB7X+3THTX3Nzaz/LUxrZTKuPdnxUW6bdXjSYL9mLG4AnEH21AnMmr8KmB67nQSRDbesZERMXuaPqrXGr+EED5NDSo1VaEMYC4eI+JDpEltbQK41jhN+69tSZOe48zQ9fekfRlGAzMG6ZPdlMHDkdpYEgEa63nNJUDm8TCjKTKh/4SD/fSeeULyBe0QChZI+3VMzcniuj2c9HSvwIb5+JqjIHjhLslIUQJDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AM8PR04MB7922.eurprd04.prod.outlook.com
 (2603:10a6:20b:249::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:15:23 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:15:23 +0000
Date: Mon, 9 Nov 2026 16:15:19 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
Subject: Re: [PATCH RESEND 18/83] drm/imx/dcss: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avHU-iRdVAMnN_rF@vm>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-18-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-drm-no-more-config-reset-v1-18-1f58d1e33380@kernel.org>
X-ClientProxiedBy: AS4P192CA0035.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::18) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AM8PR04MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e4c4b6-b9eb-4784-c859-08df3e6be4d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|19092799006|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9mkjuT+TbbmjHzT5AomuEe1WNhtoAzCoxhJIe7GjZTG0aQwE/+z7R41j0Q9qsJA/uY4C+YyuIfPlwoFY3WveAlYTWMl/BkTXU5ZyU+MyH6WXAq3EGjYARNEEWZ5/1iDqvB2RcF7joaMYws/1I+nBxmCy2oGRLWXoNbk5lJZHz+kAEhHr6/7mXz8Ywg6rXWOloMpdFi6TEcCrgjDFOuVXMx6pDxgbL0fBLaILCPHK3TBpBNCh9dY5VofRB5DPOvz2uCpXZU5rU75FrRvsi5cCJnYYunThBnz/zDcuwztD7r+gBjCbsZhzOtNqUFrTabqB88YUsC4YIplTKxyX0JBMZnu4wWMTPtEsdCMQCubtYUbY30boCWtyyyxSEAurGxujOIEi/K0Ti3AOuQz2sD1o0YEoDjvoDryJOJ/usbZi8Sm1wUjYc8TTSVtETC3zdPf0DU+afi+OkEjdYC5osRd433nH8rW70YJyxi5hIc+WvbeZlHCTniNpBzDzeGjPOLieiosF0bh2naS1ozs2h67Yg82vJFoVCDsI18y+YnabdpSVMDzkRDbf8/2fq6fVvmV5JFIwXFvxTP2UDHP3nmw8j5A/YdaCy8EcNTFfNSBEAmBrewbGUdOkmMWhAcAsa/y7/AY0EwH4ifcXiiR/sCb7oizPUpSEzXaqgzeuBPxjgaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(19092799006)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ge7Kxconenr+dQRjdbxS9WxFge+LLVFqDfZvXVTd25qDMjeAH02X53KWCt8l?=
 =?us-ascii?Q?AK1GW/YZMpVZjc558ySd7bKUdycNoK2rnqE8WIa95SuqPp8BjeszvfvlTohH?=
 =?us-ascii?Q?xHYxmYxyp1giwVjRU9VgUTtv+IQL0PBKLXPp+Ha+zRTRWoJAVBTqo3iiZCjd?=
 =?us-ascii?Q?SQWAV4Kxwn4+JF/p86dQEZVh2/xZjorwvqOzOdV7+89wtZ8O14mD4dBFsuov?=
 =?us-ascii?Q?y5+dFGEZ3KS67fvP9Zxh7jRnoQMP7cSG17Fy9unfepWx/HtNBXSnliWPWLEM?=
 =?us-ascii?Q?HoGwEBSQMyh+VMiI7jL6YOJ3HWUeYOZFVj/pGT0mQ9f5v7VB5flkgEqisyQJ?=
 =?us-ascii?Q?fqkKeSMGPXo0dhMPaYsmeNE3S9jE4/l85ci1X/Q8N7EsnN8LppnmZZFgiTOT?=
 =?us-ascii?Q?85saziAN2gffkgU7+SgjKOJvlysdcbdmxG/snm2Zjx0lEb9N6EMd+FxNw68j?=
 =?us-ascii?Q?SITgZ3Fb0K55OxpjdtK21K+WvSmc9NbhyV1gx4dhM1G9j3U1/0ZxNUSm8jT2?=
 =?us-ascii?Q?7ILY0Z2HGEjdb5+XoUcBch3Y4zk80PdmcKGV+cSievakXn9gUHxgMV9YCASV?=
 =?us-ascii?Q?sj+UlvDB5WemNJNUJx2tgJz9J7M3yLiMpG34X0W24ko8aAaeA+MlW9r+d8sN?=
 =?us-ascii?Q?huQxA5vK47cAghE/b5rK8esdns/O/Us0ykeXwbbZcx5Q1jd8zJS3AqJLPZpK?=
 =?us-ascii?Q?n0LTz/l4j1jh7hARkSYuCUZPvcUF5ojQzOsJYwfjQLaO1YLRPYojVYUxaza/?=
 =?us-ascii?Q?iGOqtX1Qgmh8NHHTfTLz5nnl2QlkXwfG6CEykIX8mMI9MIFXQjGmYVpvygPK?=
 =?us-ascii?Q?aTk92G2hIXDTBCmQh8o2V7rYclDuBwq6mprv2qrRwjbamMFcJNu+xgB3jVvw?=
 =?us-ascii?Q?euSaDtHOZx7l+F6KiYHU+oQQMv6bKqEHDxjqItUC0K0e4WyRgBYCiNTB+9gB?=
 =?us-ascii?Q?81I07O/htCUrkawW18PUvGvUBnjPFGzS37I2zE5p9QaRF6c0XTvkR3f6XMlo?=
 =?us-ascii?Q?ce1rIekA/ch4e1SdgoWh5cp0B5ev2vVFiw8Vce3hbGmq6FxKolRVE+zCSTx2?=
 =?us-ascii?Q?1hWo7XXDWSy/PJNFnOuPcUEJmGAFNHsvzxQGnNZD7SlhCJecbP/xnscBrFO0?=
 =?us-ascii?Q?F7vXrBglkyoWP38gIrPwcIHeDYb6tN5pt2grUf+rvP4RbJ9lWp3kf4O5vVg/?=
 =?us-ascii?Q?g7TY0rBlhf8Mrkjo7bnAiqkGDCXGOa9ufX7Y2rRr1+owaFRY2MoFMGSQ8xuB?=
 =?us-ascii?Q?/aCSdia1wX4D6A5GFg6N2krB3qAor1ZqrUkkD49ORI5RWtTaibl+NCz+mWcW?=
 =?us-ascii?Q?HhYQC2lPtbXlYFJ3dTpDcT+cgAAhXI6q/ITnAP5PQb2hxlBBOQp92TegRJkw?=
 =?us-ascii?Q?YCxqzL+08kG8AoqGzrZih9f8IOLCmtHVISFEJBbKUL9J9Lxp7HoTMs4WQuEh?=
 =?us-ascii?Q?lWVL+el4srUYRmZYcH0yDDIdwp0jir61nwnjomdurXJR57NRvOzq45ju9uJC?=
 =?us-ascii?Q?7bOpBxW97oYjJsHvytK8LClsfoldP+m5bUi4ZiYIrpb3Z48wss8HxHRysVVn?=
 =?us-ascii?Q?tfaoAV+XIOscI04n0kPIHydDXsOTmFn+b8WSnVNQdBthV8fEpoXamgTX1Fin?=
 =?us-ascii?Q?Xi282K7Mszu3Ue2y4T2VZzOS9U/voXURr1wiD5vgm/xtmgF641+OaVTffJFz?=
 =?us-ascii?Q?DvZMZ7zjS6dVkp/CB9dTb3ioUtkpXYkP+DbUpXMzrhIZJAxy8n8FhqlHu43i?=
 =?us-ascii?Q?0jXdFfuI+eO2RljlAAr/UmM623gqBEs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e4c4b6-b9eb-4784-c859-08df3e6be4d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:15:23.4421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ARmSWdmT90GMMdYcyLcMB+KoLrElt/9wZx1zRZHdjSjMKvejE7gIel39DQRg8l2qG5gHDqFkmJxQYsoG65oQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7922
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

On Thu, Nov 05, 2026 at 04:29:27PM +0100, Maxime Ripard wrote:
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

I think I already gave my r-b tag on this before the resend... Anyway,

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/imx/dcss/dcss-kms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> index 7c5a6e2bc89a..92ac29960e48 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> @@ -142,5 +142,7 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
>  		goto cleanup_mode_config;
>  
> -	drm_mode_config_reset(drm);
> +	ret = drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto cleanup_crtc;
>  
>  	drm_kms_helper_poll_init(drm);
> 
> -- 
> 2.55.0
> 

-- 
Thanks,
Laurentiu
