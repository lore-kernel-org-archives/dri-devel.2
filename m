Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D1606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mvSq5I1j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C680910EB4F;
	Tue, 20 Oct 2026 05:09:02 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6BD10EB4F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:08:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IParernXF80fDupbFlZdef7JmxyyGJUYvAzsc85CSAIPNAIgxNO25EBAfWWXFsElf/tvi8e1MXjlOffcgD/fKHg84FM5/VQvjU+ZPOeZLNQN37smEmEGHbhrSVqVETXthiOWrUQ57USpGgMf6xfH8YNq1ox8HQaWHkrLVbevfecZDwSaCknVcKzJtSUKYjN9xlVfMXv3UZQWNbtE5mZkiojm5fsZs+Jsa0fxYJudrE8IxMq5+CUkMgWdzHDWBCzPiM2jB8hepcy6R1VQbflre+DbqrJN6k/Ji0vimxMAIlVHq74wDnEZbGi3snzMD1eV1ShMcovKNzBAlA2EbLJk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl7odfrl8l9l5wT1rTwisdn5xGgA1/Er5jpQ48UeDRc=;
 b=kddQOaC1QT03cEjeux3ja0tuXuxD5ytouMiUlEfztXcxRpTxQb9AqJ54gOL07nrmJk1UbD0RJRZA4nG8ArGetnOcL2HKDn7d9p0yaHR5hQQzbYTUseaKuMxo1Yos7byS82s2He7m3KKRxNtuIRX47P3e93iYHMhzHjYY0mxqAzPs4/7q3pioEctYxgLhQsr4wTuto6e/1tlWjqwvUTYLkc1Dxu1KQOWVd61wdm3sgRk5zRPzQx/ENEIJSmIRaOPJYhV7JNkMfH/Et7F8nXlbm0V5WmTHWmH+uKIFjoEnomg/eXDbO/CcxXl0zA/Bh1FhTMbdVC0jm+1ny0xFcWUM7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl7odfrl8l9l5wT1rTwisdn5xGgA1/Er5jpQ48UeDRc=;
 b=mvSq5I1jAelMJFfQUdmPNS+es1K5GhiWot0A7IuIER8WRN75P6hrGSELHO7rM4BQvhRUIbAK8u3LPDq8BHehQHakNn2CjxILTSoPjOW4mME40ExGiUK8AQCCfQ46Qh+OkufIKlS/9lZYFewyQ3RiVXLfaFFaYAfXhakU/9taMDdSVwjuJFTR4xB263Tvy5VUiaUQGdaLvcztZ16JSBEZ5JqK1uPtBSVGjIvElQ5MuFxhOvRBHEJ6kEUaWL1aq9KNX83a0AczTrUo2p6W7ZocMpKTR7SVELSu2jq+xdyt3qYPBJnJDIzsyfI5JnQBavv5dv56d6/3r3/nQjFwCPwfEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS4PR12MB9771.namprd12.prod.outlook.com (2603:10b6:8:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:08:52 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:08:52 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, webgeek1234@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/tegra: Support swapping chroma planes
Date: Tue, 20 Oct 2026 14:08:48 +0900
Message-ID: <HmrilxC8QwiAQGw2IQ1Ztw@nvidia.com>
In-Reply-To: <20261018-tegra-drm-yvu420-v2-1-512889103ab4@gmail.com>
References: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
 <20261018-tegra-drm-yvu420-v2-1-512889103ab4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS4PR12MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ebb572-5828-4409-e847-08df2e683b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|366016|376014|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: yI+3DcWRVyB8+faCUkgnUD7GvEsuJXjcaixQFs9dYn6uEkU58xXJ/BqHEQEU9TTvZ3vDq5SULbiEJyQZx9JH+9IKChuZOmxF0yg6HTEx2Gx7LXsTXCFVvHyfbU3NVMz1Yq/WdwlR84I+ZwJuF6QLCUldmH3QiwSDWcyO/azth1FRK46Gm7Fqw05hZ15tkSxGh+DlbBF88F8z8W9nv4lycHpX3BDkjaQ80qmDih7F/bYsN1lYI9Zk1DyE+35yv3K4vfudYRPutou5AHDx23C9U1rNjyyjqWi8nYhNh1qg0asFnbjJYG+QN/KwT5K4H8oIy5uRxEL7r4Cs5e8tFcRFGGwfuBwqcYh75UNY+Dv31LmFzTF9AeJQpcJ8A3oZGQv6NT85zTNd65nIAQUz61btz8RC2ajIsZ2Lw11pxzXQhoTk27WTpByQzs8GjblqQnR8DBDuoZYDZ87Z/1TPqy0ku/r+iFDNquLz+5SUAb5PDrC+TYsxauMhhmeR/rQv6laWD7dHud+7cV3JqzgEEda9zhyaH3b4FTP31yHFgzlTU3HRsZu1I5kHPFrZ5/yOfrsu6devRF2HPM5r87riFJdRqTlgl0bVSqlR22h3i2MruGLVWXwy7SarI7tLm/Ej+PM0kNCkPigq0JAjjRwLPW6l/BnRNc3YUmEPymti1XO4Jkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(366016)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhWOFJhbWZENnc3Z2hEZU51bnRnT0NUaUhYb2VsTWhFUUN5Ujk1RlZBQXQ5?=
 =?utf-8?B?bWNuOWt6M0ExL1lQVld2dC9vNzZ2M3NKM1E2TGJqREt1alE2V2k0NmlKbHBD?=
 =?utf-8?B?MnFuMXkrbjVZL1hSQ3ptd09adVFaaklaSXBMOFpYRDRPNTZkOC9GZHQwZU9P?=
 =?utf-8?B?eFJIYlFGNW4zVHZEODc4b2U4QUZZNE1icEhYY25MZmdxUTRTRTh2R1pMaHM0?=
 =?utf-8?B?T0VCczVMaXEraGUxWlovcGpLTCtPU2ZuL0ZlQi9XRzR6S2phRzlTaWdGYXor?=
 =?utf-8?B?aStwSWxSUWwrSFM4bHBqL1QvT0N3VTNLUTBaVnM1U05rQ0ZVZTJQdFdjRGhZ?=
 =?utf-8?B?dUpyZnlScDk1eGdoaUcxaUFGMlJ4UTBtZVdUaDR4TUNadzZ3SlhGYTlrZnpU?=
 =?utf-8?B?bFQrQWVmYU1abVo3N1RtY3lPcjVzbDZGclRkTUpVWXgrYlg0Rmo0RE9FQVdw?=
 =?utf-8?B?TVNVY3FhZGgxdnBUeERRbk4zdTJVdWpNSnRWMjBFeWZQdzR5U0wvUW9SQk8v?=
 =?utf-8?B?cHV6N1FhSWc4YW5CZVRuaEwrYnA3Z2JJZXVjdHlGdThSVS9qSzR2WGJaWWxI?=
 =?utf-8?B?Nkd2aFdUY0U1S2M2VUZQWTg2OUVKbkp5ZldnRm5TZjM1VkY3RWs0Mko5alZj?=
 =?utf-8?B?VjNLaGRWT01WcHRWejA0V3JPalBlNENQeWNiVjY5d0FrU0o3WU5wcWIrWVI5?=
 =?utf-8?B?MW80bUFXZCttczl6OVhVSnNZMXVuWG94TXdHSHVSQUpyaHlwL0lxWS9oQkEy?=
 =?utf-8?B?WGxqdVNSQStFd0VWZG82SC9UOE4wVk1qQVVPUWpCQ3FvcEdKOWUxdE5nRm1V?=
 =?utf-8?B?SmdBQ3d3L2hQVkhxdFJBT2RpZFI3dWtoOHNEWFZMVWIwTC91cGFKMHFjamhr?=
 =?utf-8?B?bUxpYUtWNG1Wa3dEclJxZmZvQVRUTnVvNE9PWjNETnNaV0c5OHkybWJzVWU5?=
 =?utf-8?B?VW5wUWNMUit2SkhVOGppM0NFSGo4WXZMOXhGekpxQnFoTVFnaHhDNTVFV0x2?=
 =?utf-8?B?TG1rUVczbjcwVFdLUXRxU1pveW1PRlBpQXlnbVNRZmRFUjh3UUMwQVBPSEYy?=
 =?utf-8?B?RVcxRm1qYUs1QThwdTBHNWNtWUxaSFVkOUtZSEdMWGJNMG5ZdFo3UGc4blB0?=
 =?utf-8?B?WFRDNEVTWDZud1JJOFh3RnBxSjQxa09EZWl2UThmVXBzRzhYRk9ydkxsNnlT?=
 =?utf-8?B?eVFFVnlRazF1bmFNMkRMZXF6b0kxSnJDUWtZT3JIWFJ5TmpiQ3NzdVkydFQz?=
 =?utf-8?B?dENBSXZ0M2Z1eDQzWGVIN3RudEprcTh3cElwMm5QamZJaHZTdE1NNkpXdjFK?=
 =?utf-8?B?VDBzYm9rZ2JpZjdBL2VIYTc5ZU1QYTRFVllmMGZpd0llVk9ZVkFEVG1NT05w?=
 =?utf-8?B?TFNRVDI5OGhKNlpia3ZNWXcvWjdoSHVVdm8wYkNmOENhclgzVXRZR052ZW9v?=
 =?utf-8?B?NG5mOWdha0FITWxzaUp3b0cyT1ZWS3B6anc0MzFXbnVCbTRYQ09hMW5lWGo4?=
 =?utf-8?B?VHYvdUZibC80YlVRVUtBb3UyZ0kxb1JUQWhvaUpVTDdOTXpBMHp1Y0hJcnBH?=
 =?utf-8?B?U1U2eEg2djE2M3VEbzFEN0hWQ2I4bmttdXdPSlppS0lRZ3FOQTJVYnR1VHVV?=
 =?utf-8?B?SGM1bld1VStvMkdadWlBRjlUczlSY2JYUXIwVGhpaElLd2JTUFV2U3hSTUcw?=
 =?utf-8?B?ZGFJRjBiQlNuZVFmR2daRm5lYjZZTm5lTGVMZ2NJZzJBakQzNVZKb3VqamR1?=
 =?utf-8?B?eWlVQzgvMUJKa3l2ZTJ3YjlvOWNoNFJHbjFVTjZqbUxNYTZaZlZDTm1VOWJ4?=
 =?utf-8?B?TzRjL2VteGFoaE95VWR2Rlo4R3owSC8xRThCZHZQNmFiNFl6WkIrbi8vRDc2?=
 =?utf-8?B?eDN3WlhucDljdHZrMkdQeHRiNTBLRlFCRVE3Y2RLejk4dnVlZUZINXJiNHlp?=
 =?utf-8?B?K2g5YWZjV29xeHRWY1o5bTFGRTVoWG5uWXRVbCt6RFVqOHg4RGJDTkgvNW5M?=
 =?utf-8?B?dVZoMFN4QkNVRnFuNStVbVYySEo5Yit0eFphK1dXeWFEL2VsSVdLZnYya3lB?=
 =?utf-8?B?ZDJ5VVgveituVkVBcmNteU9zVndNclRtLzg2aWs2aWhsTTJoSjNLclhSMU5H?=
 =?utf-8?B?YUdJbFhzUnJoOExYajgyNnl2eWxLME5KQWQvMEpJU01uclFpZWJXaVFxNHRW?=
 =?utf-8?B?TGRpaFhYbUh6eGdKVWRvRG5sUTJpYkI5VVFqMkk1Rkl2RkRYc2ErUXJzc2RQ?=
 =?utf-8?B?REZmbS82anE1aWNVSHZFeFE3MDJlQU0ycTNUR3RYZ2hxNkdkMXRzRTJrd3BX?=
 =?utf-8?B?M0pXcHlhT3Fjc3dFczFLVEJMNElxTnp4dTNiK29kL2tPK0t6dmlReHBvUEQx?=
 =?utf-8?Q?pq21uzS1f2HFomowK6YEZRTKM/nj11UYQzQofGxviGtz1?=
X-MS-Exchange-AntiSpam-MessageData-1: 4f0vgZ0Dt1y3uQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ebb572-5828-4409-e847-08df2e683b80
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:08:52.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wxxa3vAe2gLkuxaAtCJoV8xrkk7OXofSooOGsvkfnEetr8oMT7cYGIe9Fytn4d3uFP238QWgphdqf0vCbOqZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9771
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, October 19, 2026 7:03=E2=80=AFAM Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> The Tegra display controller supports some yuv types, but not their
> chroma swapped variants. For example, yuv420 is supported but yvu420 is
> not. This can be efficiently worked around by just passing the hardware
> said chroma planes backwards. Add a flag to the plane state struct and
> handling to both tegradc and nvdisplay paths.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c    |  6 +++++-
>  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
>  drivers/gpu/drm/tegra/plane.c |  5 ++++-
>  drivers/gpu/drm/tegra/plane.h |  3 ++-
>  4 files changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index b0bfa946e6979..39c2e920d76a6 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -740,7 +740,8 @@ static int tegra_plane_atomic_check(struct drm_plane =
*plane,
> =20
>  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
>  				 &plane_state->format,
> -				 &plane_state->swap);
> +				 &plane_state->swap,
> +				 &plane_state->swap_uv);
>  	if (err < 0)
>  		return err;
> =20
> @@ -872,6 +873,9 @@ static void tegra_plane_atomic_update(struct drm_plan=
e *plane,
>  			window.stride[i] =3D fb->pitches[i];
>  	}
> =20
> +	if (tegra_plane_state->swap_uv)
> +		swap(window.base[1], window.base[2]);
> +
>  	tegra_dc_setup_window(p, &window);
>  }
> =20
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 448f49f3a7d7e..6427155ac4fdf 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct drm=
_plane *plane,
> =20
>  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
>  				 &plane_state->format,
> -				 &plane_state->swap);
> +				 &plane_state->swap,
> +				 &plane_state->swap_uv);
>  	if (err < 0)
>  		return err;
> =20
> @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(struct=
 drm_plane *plane,
>  	tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> =20
>  	if (yuv && planes > 1) {
> -		base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> +		uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> +		uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> +
> +		base =3D tegra_plane_state->iova[u] + fb->offsets[u];
>  		base |=3D addr_flag;
> =20
>  		tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_U);
>  		tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_U);
> =20
>  		if (planes > 2) {
> -			base =3D tegra_plane_state->iova[2] + fb->offsets[2];
> +			base =3D tegra_plane_state->iova[v] + fb->offsets[v];
>  			base |=3D addr_flag;
> =20
>  			tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_V)=
;
>  			tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_V);
>  		}
> =20
> -		value =3D PITCH_U(fb->pitches[1]);
> +		value =3D PITCH_U(fb->pitches[u]);
> =20
>  		if (planes > 2)
> -			value |=3D PITCH_V(fb->pitches[2]);
> +			value |=3D PITCH_V(fb->pitches[v]);
> =20
>  		tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
>  	} else {

I noticed DC_WIN_PRECOMP_WGRP_PARAMS has a SWAP_UV bit. This is already=20
defined in dc.h. So we can use that for the hub.c implementation instead=20
of manually swapping.

Otherwise everything looks good to me. We could also enable the swap_uv=20
logic for other UV formats.

Cheers
Mikko

> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.=
c
> index 2148b0c59815c..757bc552809fe 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -59,6 +59,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *pl=
ane)
>  	copy->tiling =3D state->tiling;
>  	copy->format =3D state->format;
>  	copy->swap =3D state->swap;
> +	copy->swap_uv =3D state->swap_uv;
>  	copy->reflect_x =3D state->reflect_x;
>  	copy->reflect_y =3D state->reflect_y;
>  	copy->opaque =3D state->opaque;
> @@ -319,11 +320,13 @@ int tegra_plane_state_add(struct tegra_plane *plane=
,
>  	return 0;
>  }
> =20
> -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv=
)
>  {
>  	/* assume no swapping of fetched data */
>  	if (swap)
>  		*swap =3D BYTE_SWAP_NOSWAP;
> +	if (swap_uv)
> +		*swap_uv =3D false;
> =20
>  	switch (fourcc) {
>  	case DRM_FORMAT_ARGB4444:
> diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.=
h
> index e33a581e6490e..dba5f1b254e98 100644
> --- a/drivers/gpu/drm/tegra/plane.h
> +++ b/drivers/gpu/drm/tegra/plane.h
> @@ -49,6 +49,7 @@ struct tegra_plane_state {
>  	struct tegra_bo_tiling tiling;
>  	u32 format;
>  	u32 swap;
> +	bool swap_uv;
> =20
>  	bool reflect_x;
>  	bool reflect_y;
> @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
>  int tegra_plane_state_add(struct tegra_plane *plane,
>  			  struct drm_plane_state *state);
> =20
> -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv=
);
>  bool tegra_plane_format_is_indexed(unsigned int format);
>  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *planes=
, unsigned int *bpc);
>  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
>=20
> --=20
> 2.54.0
>=20
>=20
>=20




