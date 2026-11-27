Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7E606A332
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IvQgDmET
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2801122EA;
	Fri, 27 Nov 2026 06:23:03 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51DF1122EA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nd4BcuuayT0BfB5+e8VxRWUh1QU4CZv6yUDJcGzSFdsrTEKwJ35kf5m0mhwQY/ejnrYN57fIIJh9YeznPEGGdCku0o5kxQlVUJRhyXe9pjyRtgKByRXMGXO7OG5ztuQy2IouHwFNBZrJkt1c3KOaM4onq2b3z8GBC55zblCyOYnvAo/3LWXMsG3/E/tJIlENzN9k83TZAygNT6YTHHIbGVtylVZ98Q/LATDkpFGaayksMm0JwwOwtWCkIvPqFAZIN6mTSwrwUeu1IcoZdKmWzSfOspL3/NSRd60WDJlnN1w6EZU9CcZGiJbTrlKQjynyCqCt/hxP3H2Amze6Zzq0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfnN/uu3Aq+rPgKrXYP2GTTCf0Y5Z3zOpVPbQM6MYtg=;
 b=n6hj6bgeFnmoVoo7deB00jr5hf3GmC4uEX+ocXvYIR/xqneFoxC/sgZsAOFCpJH5T4lIvpdAqys8nEBlh+WQoIuzOxRY76SbiJfaCznCzrVmogfOz7ACf8blEoG6cJACfuH0P+26s9UHueOPFAV8thybJBTNd3XnnU/V3mTG/FLWDT0VsaPcceLW2bP8wWazcvThVljvyTRj4pvYwqEO7Ehujx7hVGEyWU+Ozf0YgpWKHMqaZcxEX7jmXzjN/5+M8MZ6+syHBatEgW2/b4oNem34+kc/0p9QHHayL1tWusVg8n4LUWahVQlNLv7e7xlDHPJZOrKo+EdWJdll+qAT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfnN/uu3Aq+rPgKrXYP2GTTCf0Y5Z3zOpVPbQM6MYtg=;
 b=IvQgDmETq38p1xZeq+x71uvqDywP5PhtCDevWrBWDL2pTnbqJ7+WKlhpVw3JF4XFfne7xH6sL3ZelIeNvjW0EP91PET4LFZEX8gMZQvQ3GZNgQZJPqIA/WdKd8FiBOSSMWFTsgg48v+7qKiJrlIkZPe8yXM/+h3yrCHmQEXh+ugVLkRAnx8snsZ7VxL57w1AqrvALc206dMRmVusUzwa73gqN95+jU1Go6BtFgpGz1xKeqi4nqjfQkp3dqnIXPMdJdcIb1sTlnh0MDzf/JLSbbJUZ5MIjJ0FG48va7HXQZJh6jh4zrxNt9jKE59+O0g7bgbNNUyWlNM71LuxmTBuGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 06:22:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 06:22:51 +0000
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
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
Date: Fri, 27 Nov 2026 15:22:47 +0900
Message-ID: <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
In-Reply-To: <20261122081820.53199-11-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-11-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f2a4b8-b824-4f3e-0ce5-08df4c4edd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|4143699003|6133799003|22082099003|18002099003|3023799007|921020|11063799006|10067099003|56012099006|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qT+GFGbNrr9Ul0DkByoiIeV6r/wu6S6fBPtUzXRRJbvErZMg8p4K73I4tM1P8wsp0aw49eVfFm5gkC/KjDgJBxD6b4ENJw3LNpzhRjpU+JsjofscubRdc/cnd8uQr4bsRwWaSKP95jmJhrTvh220j4L4jU1zSMjO3b5OLoCN9mVZvhk0kHU7sfMeVjubnP6k11x500cmp986ovFJ3I73KWVVnhf5HyNzi/+hVmqXv2QEydB+lG8TtkTgbp2mYTYftzKRGAoPuvkPIJ2Zxx3TsrADQSnvPpI8tCMqfoLvKCWej57424ngXPwImthcoN2gWekJM/1Vu+xeYPTSjgc2ODtjcWEEX43Ge9VTnmZ7NprRF9IKZ1tSmtyIFQTHcV2yb1wNb2VpytBUVJ5ALRc13mk1bds36Z/EHMKsKBR6VW7Y1TCH8jwv3q6EAJ7+n0AoZHybH5OCVJYBEXQLqSp/l45Wu2GrRAeDIbAoQ2b1whUZHo2CPJpM9HwXaX6mwnADK6bZiDMG2HLmC5AWZQM5a3F4M/ezCkDYORI1haLFOmhTwu7LC5J2UqFk80gpy/mZlaNlxJij7MGqNceUtCFv/mhEMAey6zg+CsMw3bZPrJci+JHtYq9am4bst5czc2h5Z6b4OyGSYLAsSCHEpF3AueAXRk6k7LZznI0BFlEJ0P2lYrFrpyiXmAdI1P6baZu1Cn9VJEHvsKKBfCXGoCkOvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3dITE50RDF2RTUvbmJFRmc5OFNja2lOdTA2dmZkVjFHWDgwREFUMG1SUFd4?=
 =?utf-8?B?MzZLLytOSldLYmRRc1hkSjd4YjM4dFlpbUhmU2RLcFBQbGtZVVhOeHdlNGVO?=
 =?utf-8?B?bmtDRXYzaFdIdnlwdVZNNVFVQXBuSytpOStyNDNSV24zUU0zclJaQ1dIVGNG?=
 =?utf-8?B?cGx4UzBIWTFwWDFyQXAyT2RpS2VqWkhqOHUzMjVEaVVjdGxnZXJ0dC9sT3Ju?=
 =?utf-8?B?dEp0ZWJpY1hjSUZzclBXRUFDN2tDaGpxYzNBcDl6b3FMWUgvMnJHQlVxeEdZ?=
 =?utf-8?B?NWRFODloR2JxVzM3ZDdrclhUTHVIMmNkSE42eW8wZnpqeFdCbG9UUkJMMjVS?=
 =?utf-8?B?NmNLUnFMMHFDZzJDQlZlV3U0dkFUalhDYVlQeTdxQ1Avd2ZvZWVwSHgvazcr?=
 =?utf-8?B?bXpJajV4UTB5MTd6T292eElMWCtrbFVuMUZ4SVhoeWFmUVFDMDRzb0VMUmE2?=
 =?utf-8?B?aGdna1I4OFhELyt0bHR1bnB3bDhUbUdSdGFSTTlUWktxaUx1enpIQkRpbXp4?=
 =?utf-8?B?RlVaRm1tV1d2MEU2aTBKZVdZQnRvY2lubVZvOVdxSmNPZ2VMRTUvZVoyRDFZ?=
 =?utf-8?B?RDlKZ3k3MW56MzRlYzlJWktJdGJTYzlLeXZZMGN6VmFSc29sZ2dpNG9wWDly?=
 =?utf-8?B?aW9tMnRtRUVvdk5WMlB0cytFd0pTWG9aWkdVeC9yNXpWei9XR0NPS1dsK3Bt?=
 =?utf-8?B?Szk3V1IwZTJvN1J5NVlDanNleU1rVlRZdis3WVM2bHZRN2NiSlFZaWpDVCtV?=
 =?utf-8?B?aysyN1FaZStvclZ1VStoNm5ybzh1dmNvL0VrcnJBUklZR1RYZ0RLMll0WGR1?=
 =?utf-8?B?bUdRMWNRYmpXdmpMZm1UMzZnbFkydE1RbUFOU1pWM3lNRTZNZ2dMaDhHR3FN?=
 =?utf-8?B?ZUNZbnUzR2YyanBHbTdTK2c2ejJBMm1ZZEFWTzNBUGk1SzVtSFVud1RVeHhZ?=
 =?utf-8?B?MjB1YmhJL2RtRW91S0thK3Q1N3JlY29vZnFBZTFLV0R3UEUxUHFZL1F6ME4v?=
 =?utf-8?B?VTBkSUVOK0FyU1hPU3NhTXVHN1p3WWM5cW8ybjlJNnFQRm03Z1pCQ05EYlJ4?=
 =?utf-8?B?cm9tQitMS2xRNWI0dEoraU93MnlwcVZHbTIxZGdHeVdCdnVNNXQ1dXVYTFEw?=
 =?utf-8?B?SXdNN3A0VHh4NWtVMjdCUVI4QlErUjdFNGYzRGkwMnIrK1lzdlduZEtkeFJD?=
 =?utf-8?B?S05XaDE2UkJocXFGT0E2b1ZmdGRaMWNLVjg0c0IxM05sUG9KSEhOSzBPQ252?=
 =?utf-8?B?ZFhsT21pNGg2dmhrbXBCTG1SSEVCdGtzM3NMVWs1dWJDWEpzYWxEbHFPdEZG?=
 =?utf-8?B?YmlPQUdGUWVzakJPSkl0WDN0eHpIQVdqMm5TNStLdjcrMjAxYm0vVTdvU3BQ?=
 =?utf-8?B?R1QwaVFueG1yblNTaFpud0dNeTg5YlVYaVZmRGhaNmxxT09UZC9hWUlRdE5u?=
 =?utf-8?B?enVDMHlqaG9kS1VYamJ3MWdFMkI4NkRwemlqRjkxbjNKOU93eDM2UXFldnJz?=
 =?utf-8?B?OFgyM2xQWW9HRTFzWDh2UDFKc2t2QjYyTUxOWFZxTFdNVlZKV3ROWlErSk5M?=
 =?utf-8?B?SVNHbUtGY0lYV1N3RjNhS0FCcE45YkJqNTl6MUhiNEdGZFhZTEw5QjlWUDg4?=
 =?utf-8?B?U3VkNUlpSjRLTjJRUUdIYmNMSDRpVitMRktXZ0Q4bTExZzk4K3p5TEF4WG9U?=
 =?utf-8?B?OHR5bFRYZnN4VFB1eVU1NHlJVmdvK0o0MC91bUJvK3UxcWx0NkVSOW1XQTll?=
 =?utf-8?B?OW5qTkNRUENGRXV2citJUlZ0WXBmS2JpdFh5ME92SUZtQnVackRtSERmM1M2?=
 =?utf-8?B?dTFDU0lndy82OVRXSEZKUEVrMHZPTlIzL2NjWnNXcXIza3JSTzAzUXZJcWdX?=
 =?utf-8?B?NGk2eTJ4SVY1U1lMWUlHVEI4UW52VWVqaGZ3RzZBZ3BUU3o4MWFrZG1zRVpM?=
 =?utf-8?B?M0pCZ25DdGJmYnI4OXZ3QUdGajBJcUxZMk1TY0RWOEUrTEpDYzJKWUt5aHhy?=
 =?utf-8?B?NHhuQW55QzMvNDlTcEd4TEpNM0hNVUcyV3ZiT2pWVGdJZFRDVEdlNDRqbytz?=
 =?utf-8?B?UGlPcEhOSXVTM3hqV2NNbDB3M2JSa2NZbmpmbDY4d3ErTzZvNDlEK241YkZw?=
 =?utf-8?B?ZFRRZC9Idk5ZSVRrRXlLczZLaE9TRldqdkFvWnplNTRQUGFmalJPZ1ZqMG8w?=
 =?utf-8?B?T01nZXF1bTZ4NmVHeWdFNnFTTHpDUUNERmlNVi9FUVVxQll5YXpjQVc2NUJG?=
 =?utf-8?B?eWpCdVlidGd2SmhQSVZVRmY1ZkFTbjdyaERjM201clF0SFdvTEltSHBXL3B5?=
 =?utf-8?B?WEkrNnR0WWl3NnpjbnhhMW5MNTBjL1VJdHJoNk1BaG1BTmNaaEdxdDBDdm5i?=
 =?utf-8?Q?eBvLuIy/+GGUIoYVXGCew+7aFEicMcRfSdm8etEXnuMgz?=
X-MS-Exchange-AntiSpam-MessageData-1: nuRa647IaurvQw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f2a4b8-b824-4f3e-0ce5-08df4c4edd2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:22:51.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSGWKu7kUdq4Vi9TxiWy6nu+InvFGo5aOlDCZR/OrfG+34ez1DHWITYDPAaTsXeHh1kFuR/g1WQjzNgH/ozWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
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
> Parameterize configuration based on bus flags passed from the bridge or
> panel. The list of supported flags includes now pixel clock polarity,
> display enable (DE) polarity, and data alignment.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index d48d498068ac8..faecd6f94359f 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <linux/clk.h>
> +#include <linux/media-bus-format.h>
>  #include <linux/of.h>
> =20
>  #include <drm/drm_atomic_helper.h>
> @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm_encod=
er *encoder,
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
>  	struct drm_connector_state *conn_state;
> +	struct drm_bridge_state *bridge_state;
>  	struct drm_crtc_state *crtc_state;
>  	struct drm_connector *connector;
>  	struct drm_display_mode *mode;
> @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder,
>  	crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->crtc);
>  	mode =3D &crtc_state->adjusted_mode;
> =20
> +	/* Get but flags from the bridge state. */

s/but/bus/

> +	bridge_state =3D drm_atomic_get_new_bridge_state(state, output->bridge)=
;
> +	if (bridge_state)
> +		bus_flags =3D bridge_state->input_bus_cfg.flags;
> +	else
> +		bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +			    DRM_BUS_FLAG_DE_HIGH |
> +			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> +
>  	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
> =20
>  	value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
>  	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
> =20
> -	/* configure H- and V-sync signal polarities */
> +	/* configure H- and V-sync and pixel clock signal polarities */
>  	value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
> =20
>  	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder,
>  	else
>  		value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> =20
> +	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> +		value &=3D ~BIT(PIN_LSC0);
> +	else
> +		value |=3D BIT(PIN_LSC0);

I think this is the wrong way around: SAMPLE_POSEDGE means that the=20
pixel data is sampled on a rising edge. That is, it should be driven on=20
the low edge so it's ready for sampling in time for the rising edge.

LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly, 1)=20
corresponds to a data transition on the falling edge, i.e. sampling on=20
the rising edge.

Section 31.9.6 states this a bit more clearly: "an active low pixel=20
clock means that the data changes on the falling edge of the clock, to=20
be latched on the rising edge".

> +
>  	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
> =20
> -	/* XXX: parameterize? */
> -	value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
> -		DISP_ORDER_RED_BLUE;
> +	/* configure DE signal polarities */
> +	value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3));
> +
> +	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> +		value |=3D BIT(PIN_LSPI);
> +	else
> +		value &=3D ~BIT(PIN_LSPI);
> +
> +	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
> +
> +	/* configure DATA order and alignment */
> +	value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> +
> +	if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> +		value |=3D DISP_ALIGNMENT_LSB;
> +	else
> +		value &=3D ~DISP_ALIGNMENT_LSB;

DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check=20
here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/MSB=20
bit ordering in a classical way, instead:

  // DISP_DATA_ALIGNMENT =3D 0 (MSB)
  LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
              R[7:2], G[7:2], B[7:2]};
=20
  // DISP_DATA_ALIGNMENT =3D 1 (LSB)
  LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};

I suppose MSB is more natural for 18-bit panels and LSB for 24-bit=20
panels depending on the layout. So the correct value depends on how the=20
panel is wired to the SoC on the board. Hence, I think we should=20
describe this with a new property in device tree under rgb/dbi or=20
endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And=20
document that this means the above kind of wiring - not all RGB888=20
panels use it.

> +
>  	tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL);
> =20
>  	tegra_dc_commit(rgb->dc);
> --=20
> 2.53.0
>=20
>=20




