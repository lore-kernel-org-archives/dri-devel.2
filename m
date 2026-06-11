Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD6FCD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 02:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A864810EC65;
	Thu, 11 Jun 2026 02:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="B2M6i+EU";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36AA10EC65;
 Thu, 11 Jun 2026 02:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V40iJ/Vl6/g893Wle2RbQ51f/lqViglNUnyNMDJRyfX8U6KES4100hNqdvSq79KWhc/OYOBMCedCe8LcG05qD39ctyGYeDiBU4IrmZABtDTi9BOp8y5gHGVwV7HzIkkhde3/FPceDm8zvv7yWPR50Nz/KoToo09KJTwm/gyFInjbDw5V0sK6PJo4GAw/HCEqRzNcuL2YUatP/2rjTwqiIBTD8kMsMgDnmrO4gUGSVoLCNRRd7tNN1PzmfYAcRhhHqNkNF92zkSvOVAORX4zi1WyOnJDfJL6xFQoDcftuDoltNOqGzd3sHociopRIvC8Xt591ZfCSBLqvyxTjkw5LPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUFn/eu40vieuCk7Q6EVwlMpWVxA7fZmTFVlTJrU8Go=;
 b=AoeQ3NZm8p4hP722jnhDV8SgVuSKjmEre84xeymVZskniPJ8igqDHLl9lnhzNA4w4hA+lLTVwInYsEAbCo/px1ctShJQWPZ2zshHObMLlICmIa/OYm8VMuSa6Yvxk5XgjCSnuPrjYzEBWEjYo8C3yFPM/uQQ4u3VsB3cOePBt2vz4V+6Ixj0PYTHG26UKYkDlhoYpbCmNrr9sPULRxwC+KsoaO+b2B2gV881nAJ/5f8pUau6dNoFPeuFcGp4yEO5to/ia/YSqBaXe9F7hfF4YUeH29SmA76OA6VrzJixwSl4JYod1jmOcNv78uy+/EX3Nzc+BUSDSevC0GPOPbQRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUFn/eu40vieuCk7Q6EVwlMpWVxA7fZmTFVlTJrU8Go=;
 b=B2M6i+EUaW82XznetIsdxjVqBqA6URfVVcP8yONOES6EyFbjrgvn0dP4FJ2acE/e5YUMPif59UBkJ+j9PWVu9ho0qp+kzwfGU74kL3ljM6EeCfsfHH0yUEof1hbxQxyU+9gSU12Jw3bOWmuaVUiJ3QXvBtOpFc7s9rWogzEQshl1fWfihzAPOnaIhD4TIzkNTCbsVIkfDedltQAtuROPk2HroKYp6KnMRVdrboE/ZhUhV0miYgYyfMXIUYmVe/k4L8i/aokqNwX6Vlm/i1fSuXK+aTRGztgFRKuBRa9a60y9iTh7HvAkX4iDMlemJsEoP8MqldJ4xK/LhAWedg9BPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AMBPR04MB12231.eurprd04.prod.outlook.com (2603:10a6:20b:758::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:14:09 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:14:09 +0000
Date: Thu, 11 Jun 2026 10:15:36 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>,
 Douglas Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andy Yan <andy.yan@rock-chips.com>, Xin Ji <xji@analogixsemi.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Fei Shao <fshao@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <aioaSKDk9LJYD6i3@raspi>
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AMBPR04MB12231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2f1acf-55eb-406e-b879-08dec75f1f22
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|19092799006|7416014|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6StVr6IYyT5KBLq9g+8WGDcugUvibZm/Bg7LP7A6RXapaJmOqer2pFspbV1RaRO4+b/EeeU7jPSw1YZE7ibCFuiPnHY+lUXqUoGDlaryHRyHOeSe4+s/iJEElbsFeC8hL1vlRHW1xqRNZ4Mn5PFq98PJrXUyjJ3xhehzI7AZh2gyRZ3WcXqZ35na3cuHrfj7fI9FE0iAkUFLtVKfJUBG/FfQgnFwtYhqEMLw5C9bxq107yGHwK4bincvSnqvxAsljj37VELYiFlGTbA6eaC16FxDnfeavGzq82rXHTSvPokyDlrFTtXsPQFEeDLg4ze7nZ1lh6N8UyPbTeFz91M6weGal2JPMytIbgmzQPtd4Bf6f+sJ77fM/+hk+oWvfF0/W/28FqzsQZ7jcqrFbzbI4OtnY/Mt/HQypMM8wuZku4o4+Njw9tDgtD/NzB3/q9kYMU3XT7lg8grwBI2IlyXd72AoRGWpwc3bUpQHsfcesXkFVja2PbLtEYwrxsmR2ur47wVqkoaW72CJDJMT2RH2fY8cJblr8uTjhWIRUmHPl8WUbTpRYEtEpB17j20hLsHzqmznVSF1xoC54qFTKD53lRHq8OLmkFeKkQP6CDWEchWMeqgeoks0MuXUYF/ms7u8pmxCXRJe7UCupXZ71MK41g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(7416014)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LiNfnh/LjXPDQVfg7ZDyJUHDzli364zCpZDha3bHwg3/p3NytDJa/lxP0i?=
 =?iso-8859-1?Q?NHNIBT+SjEl3kAHgBEfb0/fYazx32LMcMN63CAICPfUpJaFlnKA/h7mQ3V?=
 =?iso-8859-1?Q?7CneEh2z/M3Qf+T9AeSmFxtDURKOiIUh+cUeTpO8CSSLmWRtnxovBgWGck?=
 =?iso-8859-1?Q?GLhtilxQsT7OIeNIuf3zMJttbkcw+oTPOW9h94tjXu9jf4/p7PrAjiyip7?=
 =?iso-8859-1?Q?16KzY7CjHXYaR3afIPS5MQMItrL4ORKYJx57CEtf3ZIwRsBcHc5JQtc8+m?=
 =?iso-8859-1?Q?NTFSZEu76JY4YPkDViXR7BWnva3UZxcvKJFryYKI8bvzNTvYewWmge+6WJ?=
 =?iso-8859-1?Q?OZFvbpKoZ8JWGgzWM0CsgRRz5hx8zNyQPd5wTNtBu3v/R31muAu6dxPNUf?=
 =?iso-8859-1?Q?aCglg22Ae0vWV/XuP4XEFe80dIelkk00713qVU84hPPBhfKJhW7dFCtHOg?=
 =?iso-8859-1?Q?/GDfaurcR6MC/24J/IPfajPUe2XaawoNTn6TQSg67KshFiac3jnLPpYzTb?=
 =?iso-8859-1?Q?Y5kS+3AG8UAkxwhYFQ2/tgeDSNLUEjSRVNitvjAbEBMNcFccuDr0IJC391?=
 =?iso-8859-1?Q?5UenxKeLa4vVkjEXESK8zj6TyGIo5OJYBPhYKIqTfZGCgcvREdGe4XT+uF?=
 =?iso-8859-1?Q?+ajYFq3WMsUIxrkG/8hjwLHU+PSCbRFGHq9pObB+qjeJOASyTPVWvs/vG9?=
 =?iso-8859-1?Q?cHH23FHYkg6xJlRX3nA6mOV2mxHPatJQN7+gVndYL5eClXm/OxRyrid9Gk?=
 =?iso-8859-1?Q?QWq1kHxSSszqyHqUqRoavN3HZL7/Ow2+96V+WVoieUIUOKiGDroi75AaEm?=
 =?iso-8859-1?Q?CDUeIoboykI99q2XPjkNHHMOZ06q7OxW1ncgsKRBK3UjAzB/t8KWTMGtLf?=
 =?iso-8859-1?Q?QkcFLNuVm4Vz1DReiYB/5jjNMEGQi87Z421vDr5O6QOWDmvqrT/jInqRLt?=
 =?iso-8859-1?Q?WCvuiyTKX+ZVRTSpXiVD83+UVxVZleJce435wfwv9dBiSg/F1VS97oGrpi?=
 =?iso-8859-1?Q?DDpJimp86RsEvjfriti6A7frU0XlsFrOEn7hO1JfY3aDD0u+U0KyWrFXwK?=
 =?iso-8859-1?Q?Bxl7/3MMOyRn1YkuchrEIhbU22vwn0tqXEKNuOVPGE89L2+JeEjtPwJ1q2?=
 =?iso-8859-1?Q?/ny6b8rwZ2EKTeQ91dERKivcF3YJdVOvKe7prJfq1TRG3BOx4ywEoQTdvU?=
 =?iso-8859-1?Q?4CQZ2otZIDGQwnvo5ZkMDZN+e5fJL3OGfivLMON1HrcmdSKzccnR0aIXkw?=
 =?iso-8859-1?Q?N8hSZjbfyEciWju+WCM8cVch1VA58ZeqXOtCQ/vryRzcNkDXXHXymVV52s?=
 =?iso-8859-1?Q?cd4uXEBxR0vwZ88hdWLT/lLiktsbBavnrXZSwq21DM/MYZCeeEFs2NVLcO?=
 =?iso-8859-1?Q?4nLsTuhbTIerapdbR2EunC40u0wWyVEekReNEXBDYq09RApXAtOE+lKhae?=
 =?iso-8859-1?Q?NINLU/FT5h3Pn3S7eqhc3mh6rulEf9m0aW9ODMggEFedjRrqsZh9PZ0OTD?=
 =?iso-8859-1?Q?l8dSzC4Z2XepCmpk3dIJj52mdok6aS5rZ/HgJrOUg3oCc8tBxaS4NyKiu8?=
 =?iso-8859-1?Q?0FmwCaSQoOX39DtoiMBdpdtdaiUrDnEm87uQ+J0JFbFGLZUgfeua98JFvF?=
 =?iso-8859-1?Q?sAzkfR0gdvHhjaH6V8lez5qkiHnxWh2G8pv5bd9A15OIb1sC9GMtQ2kvKK?=
 =?iso-8859-1?Q?J9Iezg35ryF3URyh2NVJjxkesyJDrZs38AH+MNVOqFYLxtEtThZYwjt0Il?=
 =?iso-8859-1?Q?A8Z2fJ14IDyRxiMtBa/gvCzqyN+FJtWN1BHw6sNWrIu6HvbzMPWqJ+BNJ6?=
 =?iso-8859-1?Q?gJ3h+WVWRw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2f1acf-55eb-406e-b879-08dec75f1f22
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:14:09.5138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wXf3yUzHAna9yeLpVJc7O+EIf0BmtK9obNkQqGfAcrCWzG5mRIikzjBgl1D3jfX3RWy0O5/88YAHg2A9M+vBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12231
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

On Mon, May 18, 2026 at 12:04:01PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> While touching all these arrays, unify usage of whitespace in the list
> terminator and drop trailing commas there.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> the mentioned change to i2c_device_id is the following:
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	index 23ff24080dfd..aebd3a5e90af 100644
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
> 	 
> 	 struct i2c_device_id {
> 		char name[I2C_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;	/* Data private to the driver */
> 	+	union {
> 	+		/* Data private to the driver */
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 	 
> 	 /* pci_epf */
> 
> and this requires that .driver_data is assigned via a named initializer
> for static data. This requirement isn't a bad one because named
> initializers are also much better readable than list initializers.
> 
> The union added to struct i2c_device_id enables further cleanups like:
> 
> 	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
> 	index 0123ca8157a8..84272ba65d08 100644
> 	--- a/drivers/regulator/ad5398.c
> 	+++ b/drivers/regulator/ad5398.c
> 	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
> 	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};
> 	 
> 	 static const struct i2c_device_id ad5398_id[] = {
> 	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> 	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> 	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
> 	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
> 		{ }
> 	 };
> 	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
> 	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
> 		struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
> 		struct regulator_config config = { };
> 		struct ad5398_chip_info *chip;
> 	-	const struct ad5398_current_data_format *df =
> 	-			(struct ad5398_current_data_format *)id->driver_data;
> 	+	const struct ad5398_current_data_format *df = id->driver_data_ptr;
> 	 
> 		chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> 		if (!chip)
> 
> that are an improvement for readability (again!) and it keeps some
> properties of the pointers (here: being const) without having to pay
> attention for that. (I didn't find a nice driver below drivers/gpu that
> benefits, so this is "only" a regulator driver example.)
> 
> My additional motivation for this effort is CHERI[1]. This is a hardware
> extension that uses 128 bit pointers but unsigned long is still 64 bit.
> So with CHERI you cannot store pointers in unsigned long variables.
> 
> I was unsure if I should split the patch. I guess doing all of
> drivers/gpu/drm/bridge together is fine, please tell if I should split
> off drivers/gpu/drm/nouveau/ and/or drivers/gpu/drm/sitronix/.
> 
> Best regards
> Uwe
> 
> [1] https://cheri-alliance.org/discover-cheri/
>     https://lwn.net/Articles/1037974/
> 
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c           | 10 +++++-----
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c     |  2 +-
>  drivers/gpu/drm/bridge/analogix/anx7625.c              |  4 ++--
>  drivers/gpu/drm/bridge/chipone-icn6211.c               |  4 ++--
>  drivers/gpu/drm/bridge/chrontel-ch7033.c               |  2 +-
>  drivers/gpu/drm/bridge/ite-it6263.c                    |  2 +-

Reviewed-by: Liu Ying <victor.liu@nxp.com> # ite-it6263.c

-- 
Regards,
Liu Ying
