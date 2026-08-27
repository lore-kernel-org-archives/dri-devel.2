Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE50C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0D710E63A;
	Thu, 27 Aug 2026 10:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RIn4pUyP";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010052.outbound.protection.outlook.com [52.101.228.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2191710E63A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4PNqMd8u0FbOwYV1RuaTblF12swama/6ERqpNw8tRSyKOJQG2oOcCplug2LIMxe20iRY9xfIHsNoJzj2NCQjDRghiRrbtWi+RpKYzfiu3U/Jv8gmQ5Wjsgg1+AUj1zXZOM9pjJ0erb4ex55OefSF/QCaEQKeaXNsxbGJ0lfaSj7+6CNKC5K5u0ejW2NrfDRyjI22DuDIChhEuPhva+vOvvDrqDo9Oc/ojibC+5U3Ynf9lwz6VGZV8zB5O4gFpDPfftuUX2qA+QfP1DApQ+yNJ49V0WGgaEyyLp9JZjySyxebJtNf+3Mn4UCBAe49W60r/95zB9qvJU7V6aRQsi+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXK16EF7AQ3d8QItkfi8Z0oIn9qrqSG5gxaJuMzkd2U=;
 b=lrxAJat9QtXI2pzryAcyCpunw2qJMs6cqTRux7QPwQmzA1uo7Osx3OJmqE+1sVRR1b0LscsAOSueQIW/XmMviGtO/RtWewc9hG2UeuP4fUHXo6qhuPqOF3Afsvs/eCZJtBIQEFeMw/gCudmF542VWCRbqWgmLtTdEmtiqJ/qVXfnpWj4Nr+GW17KrQdp2Wk8rG5qNTnhfwEDPBgnkaNS/FQnItq2L0wmueJcnC+7l/iShsW4dnbMoh0czivnMcFZg4qKNiteqS2sQrqcX60noxUq8mXF4kIbgsolVNn3H992Mn8wxrV2TGQUtnG/78kKsD32/vydYTKqAKmG53c+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXK16EF7AQ3d8QItkfi8Z0oIn9qrqSG5gxaJuMzkd2U=;
 b=RIn4pUyPAZlMw9nbZ4R/xxqQaDIFjkkNWZicvESpcbiV9jyEK9BQvgQ+SYsYojFIdUI7vBVlhkFGDwBs//5z4IU7ea5d3z/9LT+JvlcsiVwIi/vUPQ/k0qBHogTPuQlWrddbtWt6uOxLg2EQsIZzqY3wPT7KoXuiYLt15cbpFrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY4PR01MB12947.jpnprd01.prod.outlook.com (2603:1096:405:1e7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 10:28:56 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 10:28:56 +0000
Date: Thu, 27 Aug 2026 12:28:45 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 04/13] drm: renesas: rzg2l_mipi_dsi: Add support for
 DSI PWRRDY
Message-ID: <apARXewkGWRwEpf2@tom-desktop>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826174854.199139-5-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY4PR01MB12947:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e924896-6e94-495e-7c39-08df0425ffa1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|23010399003|366016|38350700014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GiiDmWbWO5mn3GRf7sLWhh99AUEv85UHhfvCuu39Ce6NJgS3oJ/0mR7+gKeRf/7bRrUbZt7PDdCLRr5p1CXwoqa229TKMney4fj9mYj/eWtC8hHBZ2ErVXMQUwVwSH8oatxCK6TOSW14EEjT1poLYf013fMRzlWz9K0/vD/v6zJ0USBd/6OpJOKd7wvIcHX1VX57PM7IbGKB/28qEw9OAcqypjvHUG4aUpruq6hE9Y5GLjrSvIHmoZ+zRyVzP98GOVCwl+1jTWrArVA2HOAPNYXt522UsC/mEfyTytcw2OBvkfjdOQzXeqeFm9Am4zA6C8II4vpyTAi8eA3yuoFX8IFNvNZjFmhv3uuVXp3xyYj/AeTubfU/e7pQOx3kJNXtRfEeDqS8Ax+RmRb97RODsFXXxSphjKvFcMVyNEevEsOfsQ8YNNtgN3r0qks18vFb2+5cBVn9DjesN1zfETqT4q9ev3x27CcPEzX8KGfjVFAdRSPGPlmMgtYmyonYSJ2R7cqbl/OI/jvShvLy6xtlnP+0nHjKscHIYSM1dwCdVsV5/n7YHSx0Nol6S/can+/2V39FocVbfSfrc4HFkv094SWCKBgxYaXbafBWNdaBKSNDYz+jwDKJfF+wc2JPZdkOE6Fyz8qBi83odImUwn2ywRN90NvFeJSLqTO57LDTICp2H2BPhg+QJfwnXE/d9pWYR9wjXMtCaT3GlL1TDsQJfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(23010399003)(366016)(38350700014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tF2FSOR46HdByi9HfuxH+Oi0Uvbeykzj2Xlfzohk/ZDmH7IdYhgM9H5zYQd0?=
 =?us-ascii?Q?lrcFrzeHMZxgU4v1/oBxXuvopyO45k1v/918wX9y7UjpfDwsaUkcGj/tv1ar?=
 =?us-ascii?Q?Q/n8JYn+YStRRJjV+8PYD7gN379wXAoJrgOABU5d5m8qHDE6D9gyNWgYqK8d?=
 =?us-ascii?Q?XzpdDHcZxYb9D/znGUNiER3ozEqxqZpFl8aySdqub0+LhlLZ+cnS1kuzIuwd?=
 =?us-ascii?Q?fH3H3MpRHkRoPQHvgKfrB499bNFZ2J0bD+NqW/rHI+vifXL7wkwzb7e32bA/?=
 =?us-ascii?Q?QwKGL7yEdwiaMwefZQvTzo0+YEJX2CfL7wzTG+nIGMfBW/c1OZC2ZXz8vxQ7?=
 =?us-ascii?Q?O/RsxxsD9k38+76rt3LAzynAXWwYRbLYGMsrXDc6h8fRZStMncIeDMcjYOiZ?=
 =?us-ascii?Q?0CRJ7zeeQ6aU0KRdNe5aINtB7XP9Xt7RP/sxFJ1Urg+WFnIZuG4tOB9n2T1Z?=
 =?us-ascii?Q?7A8yCw6JBI2FrYbUxqtPNgFOI/KZSxB2qV3dMMYKDotSORBPIE9vW1+lHEBj?=
 =?us-ascii?Q?WHmeSVDQk+JorwBdhOYkrLlmNbWzDepK93CueLwxJD0ZAzHou9aPiCP6NpVI?=
 =?us-ascii?Q?IjY+3ThDggEx0GskZ4KNC6dM5b+aUvlLJt244AYAzu/CEoqzi5YGM1DnHdI3?=
 =?us-ascii?Q?A/PeeKtoBinIqq5C8DEIzUw2bpcDz6/e8w9jKCV5+jqdwfQPfxh25WO0cCZR?=
 =?us-ascii?Q?NvF+XZrJTYfBNaJp5haV+pTzdLomzBDkyf3QgMPAY82u5+Sc1rxPDGo+CJlU?=
 =?us-ascii?Q?IGduWJ8TSHrCxtC7+fWnkp/bKDK+iWFptwRe4zDi59UgAfRgwXoXAuqrkZJm?=
 =?us-ascii?Q?gtAQgKjFMcGjdaocWFWDPmiOAs6Jk4ooydRRktCojVxUiSQoqH5gm0fbcA5h?=
 =?us-ascii?Q?kQFCtokeW+PHoddclhWGSutyePXJGkZxqEGU0fbh5ySpEjZgmMAscx27C9xv?=
 =?us-ascii?Q?/h82lQeLnyh1y0jVsO8DDkUX526ebwAVhYtVyDJpTcod1KjlXswbUhlW5xUB?=
 =?us-ascii?Q?UaSJRF0ktqQSUdJRWkuqNBlw6KEvWWFUY/AvQ3G4MQjH+ZTgO2hjjsbLjtyy?=
 =?us-ascii?Q?VAMrIMWmUEDhZfGDf5Orc+G0dlQRiJTT8Po77EcWru1htdT9Nt/uxVe+7j0E?=
 =?us-ascii?Q?sFIa8Nhy+TW3CjHfue0wReM/A7vmoX/mT8EKiHSa6Z1PKS5nzuUMPhVkD3lT?=
 =?us-ascii?Q?ucuqlrkFB5HjZmt34X70yAwSEGEkIRmHylMPN7YNooGpPEjcbd6RsiyNx+ZW?=
 =?us-ascii?Q?4gBjoapz0m9a6bIxV19fimqzS5NdzLjoOo2KhwQGUTSTQNM0pDl7leooGi0p?=
 =?us-ascii?Q?ZGZ0lTJbJS8/miIndkAwJhFW8l8ira6V6eUc2dJ1DIKr4JbwDJiiCFOLQFRN?=
 =?us-ascii?Q?26xjISamQYT64XgSQ1Bq8RG3LvN/EIIWaxzdET+dU50lQGhrPCdzZ3OeYgn6?=
 =?us-ascii?Q?I4/Bst92eBsCPZJJcYxCjNCyvllW6t0CbVgbp+lB5suIkB3QZZByErKMrqbw?=
 =?us-ascii?Q?mhEppps726glByV8HGlIp4LspqRdP4LmGTYZkHe2CRu9UOEDohGVH45BTfje?=
 =?us-ascii?Q?eLkH3xYWsS4MssH/OsZZ5S3N9o94TwamHv6uRkiQ8JDAILbrhO6xiJo2BetW?=
 =?us-ascii?Q?WnnDVOxsubYfZtqzfvyw/wABjepNHIuWz9f/YnpYV76WT4tTqD7MlnVy2fLC?=
 =?us-ascii?Q?rRFWvjaY+z+oJRWCPuQpRoV5oCXVVBcS0024yrVRhTAS6Dcrr0oZ1VhWpFTw?=
 =?us-ascii?Q?JbxRhWU7n4+WXfCVpTc2YIDbSXVPSrM/SYEwafRNtBPCzvyFtXwS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e924896-6e94-495e-7c39-08df0425ffa1
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:28:56.3308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYdDKZXgPcOCoScVvL8r+be/h6Lh2Jy5jtaLStYlgGYC0WleViktyyJykChMuTEi8bmgxPJP4y+MKVKN93RQVR4QTs38pnUJePsrf9A3xJxsbyPrJusWD9gRZnHpppFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12947
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

Hi Biju,
Thanks for your patch.

On Wed, Aug 26, 2026 at 06:48:38PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The register for controlling power to the DSI region is in the SYSC
> (System Controller) block. Add support for controlling the DSI PWRRDY
> signal so the driver can efficiently manage power to the DSI region.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Updated powerseq API names.
> v1->v2:
>  * Switched to power sequence for handling pwrrdy signal.
>  * Dropped header file regmap.h and mfd/syscon.h
>  * Added header file pwrseq/consumer.h
> ---
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index d67e1230b70c..7df5f4a4161b 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/units.h>
> @@ -63,6 +64,7 @@ struct rzg2l_mipi_dsi_hw_info {
>  	unsigned long max_dclk;
>  	u16 activation_dly;
>  	u8 features;
> +	bool pwrrdy;
>  };
>  
>  struct rzv2h_dsi_mode_calc {
> @@ -87,6 +89,8 @@ struct rzg2l_mipi_dsi {
>  	struct clk *vclk;
>  	struct clk *lpclk;
>  
> +	struct pwrseq_desc *pwrseq;
> +
>  	enum mipi_dsi_pixel_format format;
>  	unsigned int num_data_lanes;
>  	unsigned int lanes;
> @@ -1396,6 +1400,36 @@ static const struct dev_pm_ops rzg2l_mipi_pm_ops = {
>   * Probe & Remove
>   */
>  
> +static void rzg2l_mipi_dsi_pwrrdy_off(void *data)
> +{
> +	pwrseq_disable(data);
> +}
> +
> +static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi)
> +{
> +	int ret;
> +
> +	if (!dsi->info->pwrrdy)

Maybe better to introduce a new feature flag like:

	RZ_MIPI_DSI_FEATURE_PWRRDY

And drop bool pwrrdy from rzg2l_mipi_dsi_hw_info?

> +		return 0;
> +
> +	dsi->pwrseq = devm_pwrseq_get(dsi->dev, "dsi-pwrrdy");
> +	if (IS_ERR(dsi->pwrseq)) {
> +		/*
> +		 * This platform requires a sequencer. If we can't get it, we
> +		 * must return the error (including -EPROBE_DEFER to wait for
> +		 * the provider to appear)
> +		 */
> +		return dev_err_probe(dsi->dev, PTR_ERR(dsi->pwrseq),
> +				     "Failed to get required power sequencer\n");
> +	}
> +
> +	ret = pwrseq_enable(dsi->pwrseq);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dsi->dev, rzg2l_mipi_dsi_pwrrdy_off, dsi->pwrseq);

I think we can drop devm_add_action_or_reset() as devm_pwrseq_get()
already register devm_pwrseq_put() -> pwrseq_put() which already
call pwrseq_disable() if desc->powered_on.

Then we can drop rzg2l_mipi_dsi_pwrrdy_off().

Kind regards,
Tommaso

> +}
> +
>  static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  {
>  	unsigned int num_data_lanes;
> @@ -1454,6 +1488,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dsi);
>  
> +	ret = rzg2l_mipi_dsi_pwrrdy_init(dsi);
> +	if (ret)
> +		return ret;
> +
>  	pm_runtime_enable(dsi->dev);
>  
>  	ret = pm_runtime_resume_and_get(dsi->dev);
> -- 
> 2.43.0
> 
