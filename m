Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFA606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jAzOV/4B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52A110E1D9;
	Fri, 27 Nov 2026 05:01:56 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CA910E1D9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSWSjwKUk3sP8F8irgIw+wJk1Y7LhmE9oCPRC883pzOc3QMqf1pppmbo7XC2lIXEVGKCHuz2tnp+/VX4rhmYuiOzA8W5GIoIZiGKj+vexEwYESZanpUIlhop+46JkZ9IRFCXluM9UdL3gzKGKn8Fj2iNFRU6g+ctauQKrQCKAqSL3ltQoBWyNDeRHLhYTr8kz5f9UqOrDwI9alH3VY9d2UIFceJQSuthwoNoBAs7P+3560ZFrBnmJI4/xXCAXdaZoJgb8D0ghsNGqp0YtRXewC+A6jmmBLOOsrZy63RldFdchXDk2OyLDiYS/uyXOacvNC7BYLBORrEOpChC4dLLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/boAQSUqApmk/GkfVOs3gP+uZfLp1k59AqBna71dfY=;
 b=Ks4FD8KHTkgsOrZuxMI+2ji480HwTcRCTkYeatlpu+WVdDoS2ZuObfUQcOzjYNi4gS7RLDWNKGboM+bnRqUgXktXk5T3ZBjUqC1kpdc3GpAmwlL/ikX0CzK9y5zPAwb3CE6HyviVx+WnMVGuFxvmnkgmN2sLBUzWoCKZvJTyfwKiyQOUsB465blLI6fwd4dCgUaYa5YGFZnwSNLm9ln0nuiRspABwr3PQERhTVd+nyv59Qdc8xKT662odJp1Xy5UW1gPdijANTGq0ZK3kciFFxId2IjMHQmL1DmhgzT0GVisXziDW7X9+63tqGk6kxrqw5oGjwE6E0zMwYo8faJ69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/boAQSUqApmk/GkfVOs3gP+uZfLp1k59AqBna71dfY=;
 b=jAzOV/4BH3ZG7W/auvSGNBNSL+mhItFX8f0czEIwyd36u53PEPrldZUmZhSR8RnvhxlKLULajfe4USr4B4cXlDBxaM2vmc8O5zH35960Lti7j2/JhnceFPLq2RPGr4KtF8gBtiSAXrxeLLcU9HRSCgjhfVGi3q3/GV7HHX+owKgFiZHNOp3Pf/FOrlj/GXe2JgMjL8YOmQafSEaP0E/hnioKQ6/395vvJT5yxUlbClwF2mCVsLJUeAkMTfJuDHoX1rB53hmr6tyEI8Y499hbNKTEVddAaXTVJ7+81vf+DAWtFEVHBBtmidhORG8hQpBm82Nd6erQfUyNveUdbwNbGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 05:01:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:01:45 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 08/12] drm/tegra: output: Make panel parsing
 configurable
Date: Fri, 27 Nov 2026 14:01:41 +0900
Message-ID: <YNjEIJ2qT8OQf1jrgwTBHw@nvidia.com>
In-Reply-To: <20261122081820.53199-9-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-9-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0199.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c6c8f5-777a-47cb-0675-08df4c4388bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|10070799003|376014|1800799024|10067099003|4143699003|261026121527099003|56012099006|921020|11063799006|261009223027099003|261021121427099003|261022075727099003|261028144727099003|261022105027099003|261021123027099003|261102123227099003|261026140227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: J8Ps3Wdrj9iV7tk8kTaKFpZ8fsFfVv7jkpcTpRJt6D1rT3i3ox68eZGUXR7ziwZE5fhTrKBvu6xmV3czziM6fzYXszXkAoBwSGco+OnZx1R3HRj/+XpwKD/TTe4D0cG7MZPUQmpCGIXKXPacYQqXl+3KtcMTBGbFSYrzdIVcHXab7UFB1vqa9cIKCHjZCw8ZgH256Ah9+6MJZbHuptvMaU0WGhpHz2f1eMUmhYA4rwFt8y4o4fwWFfnD7GLqdkgsNzBCEOD9VKIFKlNy0gGSj1AtUv0KBmQrKEeJzfZboXuIH24JpVzmAkQyQfH2C2wXJGqQ/Q6y0tebYFnJOMN0UlMPMgws0TBIU5UYH9DICSRcxlje+EZ+JXHooFipk8zrPpkdZvpxDP5JMiA4NnEptGmoQInXHtlr/zo4sSYjqMQ6dtHpAoW4iXuHgArDYN7ZhdOOaONt2B47SPiBZaJt+tp0cXBk0GJFmR3AItE643Pf9J1+2SNEfc0zZt/HWhptUke+WLr9H98HfL7YJx1gPYPS6mM18ArLXb1/KBpHbJLri8aOgBw/sqE8qy887cU00bKgwQoFDy2P6rlUXLpywUWI68IpPLit5mqR5t3lyWl4Iw6tG7/UmvxR7igTwFVE7wPGPg78F9Ck/o5gQtVcUk9YNR9Btkfc+oEHP/MUhqcyZhMa9MnafJchjlFgluSxR7I4WPKc5YrHTB8z8qFDRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(10070799003)(376014)(1800799024)(10067099003)(4143699003)(261026121527099003)(56012099006)(921020)(11063799006)(261009223027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Q1Sy9uOCtmbXdvVFhPRnppS1RZYWJuNm5mSjBGYkdJN1pzUm92MGl2am9p?=
 =?utf-8?B?eXhqRmpUa0N2aFJlSzNENUZIaUcwVDBwcXVxVTJtdk9URFZMRWdXNFJvbHIx?=
 =?utf-8?B?TENoc1FyYnROM1JaV2UzdGRXcU05czRJVlJRVUNWczJuMC9yUlhBR0pwMUJh?=
 =?utf-8?B?Q0FuNllmaHJZSlk0N081ZDIrZXBOa2NrZVlwNmh1RGJ1MnBWeGFUbGpESGR6?=
 =?utf-8?B?WGRRdFNYNVd3QXdhdjRST3h6Sk4reWtKMWZKY0pmUEFZcUtlYU1LdkE0YitM?=
 =?utf-8?B?V3pTb1ZOUlVYRGhZaVM3bFRhcnhNNExqSHZpdlN5KzBpSi9FU3pWeTd5TWM0?=
 =?utf-8?B?cGxTMmtoRnpEL09RZUlwTGVLQnNBL0czVHFMclY0SkdNZUpGcTIrM050WXhs?=
 =?utf-8?B?TWJTMUhIQWNoVW1wS2IvWnlxc25URExBQnlzOW5HUlBXOC9SeEgzSXU2VFdv?=
 =?utf-8?B?ejlMR0JyQ2U2ODFteld5K1ZZK2d2TmxXUGxNSjBsbCtJZWd3ZUp4ek5ucXg4?=
 =?utf-8?B?QW1ZWURmMzBESnBCejBqZHpiZkd4Z2h4TDdWa3JkSERKUXdXcVlFd1dtV3c0?=
 =?utf-8?B?Y29RMnhvd0ozKzhPYTAzNHJQTFF6cjN6YklGNjF0QjRaNE9yYy9lT09qa25J?=
 =?utf-8?B?bmVEOHJFTjRiNG5SVHI2VGsxaHNiWTdNdzFpYkVLNmZUYkRjUzl5SG9DMHJt?=
 =?utf-8?B?WXhyMktaUFhoSUJkNlFSR2tWSFZCbit3bHhza3p0Z0hYakdkZDlpK0pxRjFs?=
 =?utf-8?B?WTlhcnhaZ1dBdGpTS0RHU1VSNGVINTk0VzBMWjIvdXNvOVphVFNPR1kyYm5I?=
 =?utf-8?B?OVRnL2d3OXFudEt6Z3EvbVQxU0V3a24wNDZwZ1JxR1RMNTFGUlFSczN6endk?=
 =?utf-8?B?UFFNRVd4VzVDQ1E2T2dIN0psKzUweVUxMGkrZGJpdnVscWFkWGNTQzlWU3VX?=
 =?utf-8?B?OE9TN3ZhekZ6MmRFZjVPWWdvcWJXS05PSXhsa1AyZmkvT0xPczk1dGdFMzRP?=
 =?utf-8?B?QU5qVUduMCswZUd2NG1PZTJ4NDBITmh1RlhyNUhxaFVSQ2J1NWtZNjNsRThY?=
 =?utf-8?B?TEo3TEUyVXFpUDVjNm5ydi9nUUhLSnVpT3lnNGJtWlJ1QXdSVGZlTkJUMUha?=
 =?utf-8?B?dklYSjFUSVhBcGU5RnFKWFFhU3UwZnFPWGxVdHl1S1hmeEpCSUp4M3N6cHlT?=
 =?utf-8?B?cXVONjFiQ2NkVThNOXZwdFpCakJaZGhRaWlsMkN0MnE3alNDb3IyL2Z2SS9I?=
 =?utf-8?B?R2N2VmdVUDZ2RjJYZHprQ0R0aUxMWEJuTkhJZE1tUWdGTnArd1NqaEZZZ29C?=
 =?utf-8?B?cWwvU0QwS0FmamRPRURUSFBMWWFvNTdjMlF0eGxJTUFLdDA0cHBsTUQ2Wkw5?=
 =?utf-8?B?L3l5ajNuWFhzVE5LVVo4RXplV1ljVFRiVUMyd3Z4N1JuVTFyYmNFKzNRSHpx?=
 =?utf-8?B?aG5UbUNXdkdyY2ppWmF3K3VBRDBSMFY2LzBXTmJiQ3VGcVFkM01CWlFLK2lu?=
 =?utf-8?B?OWZQajFJZXpFVEhSYm1vSUhtcXg3UTBtZmMvNXkzSFNWTm1scUJJdU9KYjRu?=
 =?utf-8?B?YkZRdXZ2RkJ4aHVYMGJSd2xLU29OS2FqYWhlaURLbkZSZHcyeWNhNExKVUFC?=
 =?utf-8?B?Zmd1THBmWTBtZy9ETDI5Z3dLaXBiSGxaYjFqcmt4dG00WnFiWUtrdXI3VFIr?=
 =?utf-8?B?RmpmWnVzU0I4T0E4aXJQSVlKUHdSNDlYb2Y3UktlbG55SFNweGtWby9KVWhY?=
 =?utf-8?B?eXUyMWFvUlVqTzZib3hlZTAwcXQyQkx2L0lzeDBMRTRGT0dOdlZJNVlyWHJW?=
 =?utf-8?B?NkNYdUdlc3o4Q2xMZHB4TFFKWldCeGJzejAvMzF5a0xtV1pNK1pyMjJQYXJs?=
 =?utf-8?B?QkJqYW16eHdPVUU4byt5NWNjVHdnYW1PcnRyV0dROWoyTGpGcHNGRkVwNnEr?=
 =?utf-8?B?NVdxNlV0Y0VuaXYxdmVzNjVkakxwc0psbDEvRnNtUXYrL2loOThFQzZHVmhS?=
 =?utf-8?B?MTc5RTN4bWd6ZVYxZHR4b1NkbDBwN2VYdm1pM05lb0tmb0NwOG5NaVk4UVBh?=
 =?utf-8?B?WURvQmtJMmtRdzk0MGRyOVN6UkZmOFhXOWVIYUlxME41ZE9BTGt1a2x2ZG5J?=
 =?utf-8?B?YUMvSUI2RFhWdllsWU90NVl1TmhaK1pYNTZQaGRCT1UzMFZOTUQ2Q3lORjRz?=
 =?utf-8?B?UldwWXRJTWoya21YN2htNHdSOWI0SnBLcnA2SnVTSXUxTXc5OWY4SzNNSW1E?=
 =?utf-8?B?TFppcVRBSVpQRDNicGlwalNWcC9RdWNIVmwzSndHSmRheGdLRlErZmdMK1pD?=
 =?utf-8?B?L3NDb3Y5VnI0RWZVaGh5YkYwOVZhVS9YVXp1ZE8wQ0FWOCs3N2htTFUxSnQ5?=
 =?utf-8?Q?yyNBoHZgjeaEEwF9zQVAWDkxkjk6UBS0tQjvA910jF9IY?=
X-MS-Exchange-AntiSpam-MessageData-1: i/xonhDTyYCocg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c6c8f5-777a-47cb-0675-08df4c4388bc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:01:45.2632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRwvYqLtdGImr4pXLwHWjTA+jIMF7DrKb8PWN07faDhZugy/jV4T9GEbELdRYqGq9ya3JEUmZXCpQwOeBUliNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> The tegra_output_probe() function performs panel parsing unconditionally,
> even for devices that do not require it or that handle panel parsing on
> their own (like DSI).
>=20
> This causes devices with dual DSI panels to fail, because they rely on th=
e
> OF graph to find the secondary DSI controller, whereas
> tegra_output_probe() treats this port as a direct connection to the panel=
.
> An example of such a device is the Xiaomi Mi Pad. Make panel parsing
> configurable.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/drm.h    |  2 +-
>  drivers/gpu/drm/tegra/dsi.c    |  2 +-
>  drivers/gpu/drm/tegra/hdmi.c   |  2 +-
>  drivers/gpu/drm/tegra/output.c | 52 ++++++++++++++++++----------------
>  drivers/gpu/drm/tegra/rgb.c    |  2 +-
>  drivers/gpu/drm/tegra/sor.c    |  2 +-
>  6 files changed, 32 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> index bc720ae8d95e1..e53fe68161cb8 100644
> --- a/drivers/gpu/drm/tegra/drm.h
> +++ b/drivers/gpu/drm/tegra/drm.h
> @@ -156,7 +156,7 @@ static inline struct tegra_output *connector_to_outpu=
t(struct drm_connector *c)
>  }
> =20
>  /* from output.c */
> -int tegra_output_probe(struct tegra_output *output);
> +int tegra_output_probe(struct tegra_output *output, bool get_panel);
>  void tegra_output_remove(struct tegra_output *output);
>  int tegra_output_init(struct drm_device *drm, struct tegra_output *outpu=
t);
>  void tegra_output_exit(struct tegra_output *output);
> diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> index b5806a53e75ac..6d6adc485e51e 100644
> --- a/drivers/gpu/drm/tegra/dsi.c
> +++ b/drivers/gpu/drm/tegra/dsi.c
> @@ -1617,7 +1617,7 @@ static int tegra_dsi_probe(struct platform_device *=
pdev)
>  	if (err < 0)
>  		return err;
> =20
> -	err =3D tegra_output_probe(&dsi->output);
> +	err =3D tegra_output_probe(&dsi->output, false);
>  	if (err < 0)
>  		return err;
> =20
> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index 3a94968bd983a..e8c4347f09e69 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -1855,7 +1855,7 @@ static int tegra_hdmi_probe(struct platform_device =
*pdev)
> =20
>  	hdmi->output.dev =3D &pdev->dev;
> =20
> -	err =3D tegra_output_probe(&hdmi->output);
> +	err =3D tegra_output_probe(&hdmi->output, true);
>  	if (err < 0)
>  		return err;
> =20
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/outpu=
t.c
> index eebf0ec0eea0a..d7d7f6ce0a8c3 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -93,7 +93,7 @@ static irqreturn_t hpd_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> -int tegra_output_probe(struct tegra_output *output)
> +int tegra_output_probe(struct tegra_output *output, bool get_panel)
>  {
>  	struct device_node *ddc, *panel;
>  	const void *edid;
> @@ -103,31 +103,33 @@ int tegra_output_probe(struct tegra_output *output)
>  	if (!output->of_node)
>  		output->of_node =3D output->dev->of_node;
> =20
> -	err =3D drm_of_find_panel_or_bridge(output->of_node, -1, -1,
> -					  &output->panel, &output->bridge);
> -	if (err && err !=3D -ENODEV)
> -		return err;
> -
> -	panel =3D of_parse_phandle(output->of_node, "nvidia,panel", 0);
> -	if (panel) {
> -		/*
> -		 * Don't mix nvidia,panel phandle with the graph in a
> -		 * device-tree.
> -		 */
> -		WARN_ON(output->panel || output->bridge);
> -
> -		if (output->panel) {
> -			drm_panel_put(output->panel);
> -			output->panel =3D NULL;
> -		}
> -
> -		output->panel =3D of_drm_find_panel(panel);
> -		of_node_put(panel);
> -
> -		if (IS_ERR(output->panel)) {
> -			err =3D PTR_ERR(output->panel);
> -			output->panel =3D NULL;
> +	if (get_panel) {
> +		err =3D drm_of_find_panel_or_bridge(output->of_node, -1, -1,
> +						  &output->panel, &output->bridge);
> +		if (err && err !=3D -ENODEV)
>  			return err;
> +
> +		panel =3D of_parse_phandle(output->of_node, "nvidia,panel", 0);
> +		if (panel) {
> +			/*
> +			 * Don't mix nvidia,panel phandle with the graph in a
> +			 * device-tree.
> +			 */
> +			WARN_ON(output->panel || output->bridge);
> +
> +			if (output->panel) {
> +				drm_panel_put(output->panel);
> +				output->panel =3D NULL;
> +			}
> +
> +			output->panel =3D of_drm_find_panel(panel);
> +			of_node_put(panel);
> +
> +			if (IS_ERR(output->panel)) {
> +				err =3D PTR_ERR(output->panel);
> +				output->panel =3D NULL;
> +				return err;
> +			}
>  		}
>  	}
> =20
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index 40a02cf5939aa..227a178f761bd 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -236,7 +236,7 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
>  	rgb->output.of_node =3D np;
>  	rgb->dc =3D dc;
> =20
> -	err =3D tegra_output_probe(&rgb->output);
> +	err =3D tegra_output_probe(&rgb->output, true);
>  	if (err < 0)
>  		return err;
> =20
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 061c5dbb738be..ebac9068b670f 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -3803,7 +3803,7 @@ static int tegra_sor_probe(struct platform_device *=
pdev)
>  	if (err < 0)
>  		goto put_aux;
> =20
> -	err =3D tegra_output_probe(&sor->output);
> +	err =3D tegra_output_probe(&sor->output, true);
>  	if (err < 0) {
>  		dev_err_probe(&pdev->dev, err, "failed to probe output\n");
>  		goto put_aux;
> --=20
> 2.53.0
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



