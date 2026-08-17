Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A473C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6640910E797;
	Mon, 17 Aug 2026 12:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YbgPbpXj";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E167D10E794
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCKQm90XuAajymeOUV2LkSR1JTvGwNwwt8LZQsAH92/9Mo3eWjazQLfEij1YOa2yNETGmKAQ1/4CWZ2XX7YIm+KXOrBvQvhjqUNwHtY0Sd06RlEFi3cbS95njvh7q1nx9o+xHWZSPaDX20cHWRLditEnDn9bBFYfCSh92gbyjSCEWn8VjRfTQdRQOYqlcSVsfRmjcznQVF5fu6OlgmL+rc064OneoznRM1FcxOpophk9Ik6zQ5LdqoN4Q7tDOgF0TYvkOtDQLELqyi7AyvpruuW4L1YTRxBaKmkm9D6JVjj7uwQQZPgO0wTYkttXwLWRgVSx9LpHpbAwUKNf0ef30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XHqtesdvt/9oFnNyaorD49lg1HnlBxKGtBMEh4uLmU=;
 b=tK25JyYYdDMMOtsEKZ7YiGAp0mI4d9/xrdgfM/e51DBB7y/bG65WeCGlj037G4Q+ZzZbb030urvWr41f69tHZDdi7HhBCjxr8x950RZ5hzjzmVTQvqgABJqThPGHbMREn/udtjCFfzTd7zi4i+08pM7yBZZ4gubl0pFlDsQNZKvKu4w+4MBInC5i9og1Pbxxw5y4clmYTG13HP8QKupyrUbb+K0AwbSUs2j+j3GjTHSyd2H7zZDnoWLrKwJltqgbi5Y2r/srqvP76cnKFCXc+1e+nF9db9jGcG64Z1YXii+Q39+pUJtPg1F5hvyy+bi0lfXcOM/FTK/O+LdEjLH9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XHqtesdvt/9oFnNyaorD49lg1HnlBxKGtBMEh4uLmU=;
 b=YbgPbpXj2qQ/UVHAgDIoT9F8LBfEb3ej/7VEE4u9w2zrFGo/94MpbQXysSU+/cIvYvcB5LPt5+/2GLfifcFS0zJz478IZvXqEBR8fVSanZu4yNFqSAFmwVqXWcMBASWljvWXcZVDriNEFP1116hBa5Cq9OUCrSXMxRAmY+6mtujOi9xyarvI46CneNZsgfRGlLuPNgvWzc2T67mz2c2M2cFZx8O97c649u3pnWMVPxbX1pKIwKLJLYkYwilxAHrrumiryYjwtSDBS94KD9aM/YTh1xELTY8lvtjj6mxiPuKKsrg8qAEzTDltpFuTk8Mg68dmanan39mR6u4LdA1Ing==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB9191.eurprd04.prod.outlook.com
 (2603:10a6:20b:44e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:35:08 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:35:07 +0000
Date: Mon, 17 Aug 2026 15:35:03 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Frank.Li@nxp.com, 
 Sascha Hauer <s.hauer@pengutronix.de>, festevam@gmail.com, imx@lists.linux.dev,
 kernel@pengutronix.de, l.stach@pengutronix.de
Subject: Re: [PATCH v2 18/61] drm/imx/dcss: Convert to atomic_create_state
Message-ID: <xvedve5evh2myckam3fmtbyuh3wqyqnasnx7ij2jnnqecraahx@e4tvvyqf2czv>
References: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
 <20260814-drm-no-more-plane-reset-v2-18-82d2963dd134@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-drm-no-more-plane-reset-v2-18-82d2963dd134@kernel.org>
X-ClientProxiedBy: AS4P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: bed47479-eee5-46a0-0a1d-08defc5bf864
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|7416014|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GAN8UkG4dJ7RoZxWXl+jYBOhTNV7ROtZi/hUmvY4vHvAgWttaGcd0IzNcxe6kfs/3ism+i6BzwHh4ASlm5GCpvGG3btdz1IERH7wqjbe+hTqTJLiZCBZ+YQU0rr6AemhtVnHV55spAGIL/jOAUIY8x0/djglwCULHnLXTl2fux7Jd7rNhepjzAhOiqex8MGAs/MjjJaiZIOsQoPV2F6lIzvFK8AxoqPXmcLb9vFgIcxpXoE8uxhsd/UcwSJ2M1E6LpSlikor6PrQIrG5jHY6kPTGdeXVhlMK8p0a3rj2053vqMNvy6DB/ZCGofsQAmIpVQLzutalj4k6jDr9ixNOTFJzHbxi/IIcrgy97lpnED7dSNxvzDgt8PGeiu0SvOb5nTLjso2dkJnAhdPCPs3Bpr+hPbdjpxS6yAqGFTZpEvF6p2VNWKofc2LQqEdox5E2bNC5J9Aot+vboz8O97e5OQzvsGmBZDN6ET+N9LUYzlelkCntGCGCx5K+NbW6SwYVWyOiOhBAn4rAhlsziaks+JNKABw3rNDYPVZPxlAWsn4TMdfcc/JC6RTbsfuviHSSLCXgTkKOKm0kCV8nO9eJ2v05pnee2pIGWtcCyymJFXPI6RVIlg/ROPfGYNYrg3HvhR3VRvEjH8ivBIMF9wkW/yQyq+JB+3bDgK5bql7TGc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(7416014)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTyttU37gMIkb4H+IHN9Iofs57Qg8HUpJqLqP7aVQh5lPVyLhBrX1Pic1EXP?=
 =?us-ascii?Q?Jy5l5+FRwyWCMs/okz5xmmbzW3cnqww6n4ZAZxCjJ+SF2Kgd8Q2bZtNLcN5y?=
 =?us-ascii?Q?liYYeVXjTY6ZedH07X+AXGRd0mURLnreHIsVDlOV7d7NbvZ7yhICCu3OvZUx?=
 =?us-ascii?Q?YILNmOsNkNCSuN/oyKHcaHaokU+ESwhXPgLRMO3ULybErI8M5c2BFh6lPp5H?=
 =?us-ascii?Q?dvsRu0PN/HxT9O6MKhWqchJHDzY5cGSEwfh2P1Sufc6eXO7In3wfTrcSR3rq?=
 =?us-ascii?Q?/1RA+grNN+C4JjCvQKkr0GpZjFJ13P3BwAQMXvKjlKB3ud8Mqb8akxJgXrQl?=
 =?us-ascii?Q?0FRrMzB5hNVMA8xOWCuLWJMcKQNF3cByTiOVYfwtVBN5srbQ7mSFZCvbzcFN?=
 =?us-ascii?Q?n6+OmbvM7WZkHO+UY3vhTPAYH3g7W5ng5hWiBiIzN3Gq7tRtiI15wqueXW25?=
 =?us-ascii?Q?t3ks1cC5d3Hg/yJDAMmpjrpNVOpgBAVJhkdXJAPFa2f3yJ6bdj5yBegbKmqD?=
 =?us-ascii?Q?g5UpwgHUeCBqpjr9tPz591HD/X+cXdYmiPbP5rkhR/jtnqmCMICUrGdn3MId?=
 =?us-ascii?Q?0DJrk9Kh+yeVvP3vuEvDHxIO6F1IH2CujfmYxRoPI9jFviW949c+HWCaFj9d?=
 =?us-ascii?Q?5jiljTlQ36f33RR5QGv3ijgmUlzd8ARlrvyR/81oD9++QPi/5MpPEo/C5Kw/?=
 =?us-ascii?Q?dFjMbC0KZqO1teKx9xj7trJa3r3hnHRW8j1wLv6iKS8WZTKMJXUv/Ob1pe22?=
 =?us-ascii?Q?liOHP3M2K+t1kp+8Sw2QqbXY0euf6Bg7pZfy6S8E/Y/jG8YobMewgyVCmsSm?=
 =?us-ascii?Q?zLRiPh6e3+OLzKUUL9+Fj6PMJ5w6w5o1EvqRv0ThreRPr8xeF1RLgNRyTbs5?=
 =?us-ascii?Q?pFvoaPEYN72QsOeDrAUDSGJ3+jxGEUi4WpKV7pNrgwW2vmIFQ3LVz7nJ0uHT?=
 =?us-ascii?Q?iKLOFnQxGFvSvVFd7biO9w+73hDjVnGlv734N/yFCsYoFhgHphyejh0Wc737?=
 =?us-ascii?Q?8TG8UmKMR5uFK2b8h4M5LzLAcb4dis8yd5QqOdf+P1/D7WBtwGrLnZv5rRGa?=
 =?us-ascii?Q?BCeNflxGQpYBG8gEwMPPwBO+sFX8ElRjlj8rQrpDKGlSs1Tl2zHLVLb4p6+s?=
 =?us-ascii?Q?g5zJcoY/XTRBFsCKYGZL/eveN+GCLGFgCTiZ0/PE9Tz/XTzj76SFn9y6wf+c?=
 =?us-ascii?Q?uUN/WWBwUHEa3f7Z++gMKPyoN7Y+VUwTnkci41LspK6E+/vkqXkYH4i2+f2z?=
 =?us-ascii?Q?6RGpsgdGNHiPYlO/KKRirXvyhribj+zOyPFcaEbShUCo/rUh9dpjm4l58cRA?=
 =?us-ascii?Q?SaMEuKq0c8ApTEsmHLGpEI+2/Fg1RT1D14twSNPAVPJvxSmygRRDWX0hgKPR?=
 =?us-ascii?Q?nrbb7ee8tK4yu4H0udMQDhTMzjzhFxbdi4SDfzYEutJlCBPjRsIbUV3h3zyq?=
 =?us-ascii?Q?/XJGjjqGuGdknKuzvNVp3soWrjiKvsow6aN2ROBXKH+7g3fKu7OVqqjj+YGU?=
 =?us-ascii?Q?FeQrMN3QR/Yy98Wo5CTwRvZ65IY4qy+61/cfE2VftxGyVP1aJeXCz6M0Cdh0?=
 =?us-ascii?Q?s1S48b1DdSYYNQoG2/GsGlZrrTLRSC3wcrv0spJSplopVrOPns8HNF/MgEQK?=
 =?us-ascii?Q?x+Gu2OI8Cagnc6N6kXJRWPV8E5zb2LjYYqOIxrJIzphmR8gZrG/K0jpagk0/?=
 =?us-ascii?Q?Emqy3tnTIw1rDaITjM02AWPiJuQ3BDwo1W6xOKeHwOwf4MwX7GklLNzbtLVM?=
 =?us-ascii?Q?0wNKM/t/QTdMmuRr+ztkSVke86xrZgo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed47479-eee5-46a0-0a1d-08defc5bf864
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:35:07.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mu+4J8LSnos0C3EvSZgC8/2uBSUY2YmglB9Dbp8Q8tHy55pVTwESKpEiolebLRZGTkq1E16Bl+dlNRJxuNhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191
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

On Fri, Aug 14, 2026 at 04:57:07PM +0200, Maxime Ripard wrote:
> The plane only initializes a pristine state in its reset hook
> using drm_atomic_helper_plane_reset(), which is equivalent to what
> atomic_create_state expects. Convert to it.
> 
> The conversion was done using the following Coccinelle semantic patch:
> 
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
> 
> struct drm_plane_funcs funcs = {
>   ...,
> - .reset = drm_atomic_helper_plane_reset,
> + .atomic_create_state = drm_atomic_helper_plane_create_state,
>   ...,
> };
> 
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .reset = reset_func,
>     ...,
> };
> 
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
> 
>  void reset_func(...)
>  {
>  	<+...
> (
>  	__drm_atomic_helper_plane_reset(...);
> |
> 	__drm_gem_reset_shadow_plane(...);
> )
>  	...+>
>  }
> 
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .atomic_destroy_state = destroy_func,
>     ...,
> };
> 
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>     coccinelle.new_name = old_name.replace("_reset", "_create_state")
> else:
>     coccinelle.new_name = old_name
> 
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
> -   .reset = reset_func,
> +   .atomic_create_state = new_name,
>     ...,
> };
> 
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	...
> (
> -	if (P->state) {
> - 		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -		P->funcs->atomic_destroy_state(P, P->state);
> |
> -		destroy_func(P, P->state);
> )
> - 		...+>
> - 	}
> |
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -	WARN_ON(P->state);
> )
>  	...
> (
> -	kfree(P->state);
> |
> -	kfree(container_func(P->state));
> |
>  	// kfree is optional
> )
> (
> -	P->state = NULL;
> |
>  	// plane->state clearing is optional
> )
>  	...
>  }
> 
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
> 
>  void mtk_plane_reset(struct drm_plane *P)
>  {
>  	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
>  		...
> -	}
>  	...
>  }
> 
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
> 
>  void nv50_wndw_reset(...)
>  {
>  	...
> -	if (WARN_ON(!(S = kzalloc_obj(*S))))
> +	S = kzalloc_obj(*S);
> +	if (WARN_ON(!S))
>  		return;
>  	...
>  }
> 
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	<...
>  	S = kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> |
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
>  }
> 
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	S = kzalloc_obj(*S);
> 	...
> (
>  	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (S == NULL) {
>  		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> |
> -	__drm_gem_reset_shadow_plane(P, PS);
> +	__drm_gem_shadow_plane_state_init(P, PS);
> )
> 	...
> }
> 
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	<+...
> -	return;
> +	return ERR_PTR(-EINVAL);
> 	...+>
> }
> 
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_atomic_helper_plane_state_init(PS, P);
> 	...
> +
> +	return PS;
> }
> 
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
