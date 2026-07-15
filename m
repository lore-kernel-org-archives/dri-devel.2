Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BF3C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27C710E139;
	Wed, 15 Jul 2026 07:25:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tWjF7Gml";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6135B10E139
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZsvCNhnsBL2GZtyGxs0REWDZkWlnJsw83vpq+Sg+QRHO058ll1Gs1HsJaWyXEfjRCV/mIYLbpupFh/A3eQflDhwfMavKJJByK/KiMdx85bq0vR0q0stkyCxSc4KzuhY3C4HECIm8Ebg3yGIR7Kske+xIhow6vqu8nyG6ShqaRmFjz+lyIbiyDY9Cw37qDS1LBlj8xnKUf9S5gxiNUwLdj6KEXXSsVYV5/d1XqcgQ7oM7KcFyo845Fn2dkuabXO+KHq4YOsNklhmUnHUkPXwwOxDuBT1YHLMF87tDMMsAPsf2Ki/bIVlWhHPBOun5KkJmxmh//Mid9UAdfKN7kFdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM2ucVcZ9kL6Iu4licbeT4SbZWd5HlQZ3suQAhXHjHU=;
 b=faVLR5IjB97juoJZ58+6ta/tsF0f7A4HvW+3gYnrXA/n0f/e1VNaX2+uUsOcz701ai+OfH+8czo4C/VEy+sGgMQziuofsNiddtXuCwn24q+KHGoH5DfaGAJxUtZOgXRyV7ChEaiNgSz1Txi+CIqsK3vBdBd4KH92VjCYQSmFb3mpjphGOQpUTizjZCrXiFv0jc3YII/1ewkcWWeiSNxDjrX+3CVrA54oJAwAQzSevqkb5WOBxp4dwJOU1MsiMm0ZazZ3ce/7zKkNirZey5groKB07+51ow0GTkEuIpsZ/3g1OLlYdc7NuK6owFjqzemihI8AknIRprlzlKqYzsL7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM2ucVcZ9kL6Iu4licbeT4SbZWd5HlQZ3suQAhXHjHU=;
 b=tWjF7GmlKUdap1Y0uszQRkT+zyz8IM07GYDDfxnUJBgLRKeyvgnOZnKepTMdbMXKsPbFzX6narTC4VrVRcsyme4eh2r2TP6aynpCv0HDOMwR9+oUz87oeAR9R79rsQFmvATl6YXw+2jPyttyTPW/JbwMcidlAQDmVOz3IhQQT3t6Stpe6jrP5/M0B8URJO4LahdkT89cUI9mkbx6AGRNfH3xRN9OZMPDLKkx86nmFWWpKakCZ9ENdMd7eUYf5U+RhmE/TnlukbtHgKngd/HKvL/1fph7bRcg1JywogPEIhnWoOQU0BXBjb8AJ//FsOfgvS7kwZyabFzWkgrXIuiiOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 07:25:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 07:25:51 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, thierry.reding@kernel.org
Subject: Re: [PATCH 59/60] drm/tegra: Convert to atomic_create_state
Date: Wed, 15 Jul 2026 16:25:48 +0900
Message-ID: <Y7bDDzPZSAm-SByysuBRXw@nvidia.com>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-59-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-59-302d986fe5f0@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cfdd22-4a97-4630-19e0-08dee2424ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 29vx4iZu6XQpF3+gAYeGt6n6d2uLWFYR7dWjh/bYHKSDrxcO+vVNTP7ow+0V2nsL6mW0giMAvbRBvgCG+YHM7MIJs4zBeuk1bHh+BzNyN9LcqkG52BlzmQsFMxMtuiaub5yYgus77jDk3uSmhYaCHiOPmyVQKTlBv+0xA7AYVpjgBi3PMlPjqeI17FT5SnqRyBX2lI6JW41+xzWE+gGyrrwh/HRT2jeOXHKgQhiq6KXKa53ltkinz/P0mOoMZuzy016TmS2KcaHDQkggeD4T24UBCXAMDjdZbhQEKRdOuJcB42Dpr00mgZAD6L30y8LfLHkDRLGJLJ/jRx127RoASvA5oED+ARgKTo9DzvttM/j6Evkqa3bqdHQw6UbvKjUic4zk3Hqit8P/tg80XnQa6YhY/+kLmmr8+TiNqx6HjGvZ7UdfbJEI8lyNiYIriE/AZuXwAu+3Qeb/UzXwrfHDqARqT05hn70DSJOCaoW8EilK4dEAC5Z/lckTCpBWO/KN0FddWYSFdP0TvmBAVL6DH8rz96enuzjvovdAhC7Rs6e7qzApMzQts9QwgyWmOgAFwuEosbUJuTD7uOO+SHuriDCAgG0mTsLZ0bFvUKRbWepoJqXyMMFCyFgn5Tu9wFK0rZoFHZ89Nz+OLPE96eiPA/qCMzYGwCEVBeEqDyP+2yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxvcFNsd1RZQjJxSEI1KzJySkRNcHpBRUtPV1IrcGt0Wk5RWG9jd1IyWkJP?=
 =?utf-8?B?Ujhnd0FacWRrWVE1UXBUaFZ6bVE4bVVaZUpNYnZBZUxZOS9tUnYrZ2NZT0gv?=
 =?utf-8?B?RVcrRE4vWHRPdU9WQ3ZFbFM2WjUvcnB4dWJqR2l6L2RaYU1WalA5TVFWckhB?=
 =?utf-8?B?ejJDZFBBZVg1R2JJaVVLUGdiWGc5SGxZYjVHdjVDcFZOT3ljT3BzNGxUendV?=
 =?utf-8?B?cVo3dWU3SU1NOG15ZktxY29XVllBTHphQzVnU0VWN0RobG5GZE5PLzZGdmFv?=
 =?utf-8?B?bDlxOERhS0t1VlN1OENERGliM1hJbERhNXZyc243WDZWekhTdUR3alNmTjVu?=
 =?utf-8?B?cysrbHRkSVY0SGtFNFJxY040UmpuWDFRSTBlSFFwcFZyNkdBaHVVaFdHZUg0?=
 =?utf-8?B?WU1SS1A1dDBSTnBZUmx1aE8yQ0VXazFUeVRJc2JHWXlmOEdJWWxmaXNPM3p4?=
 =?utf-8?B?dnhlRjNSSE96ZmU4TFRreTJYc3Q4ZXAycVNzR0RlMkVBa3Z1ZVd0TXJmZU82?=
 =?utf-8?B?Rm5UNHdHRU5aL2pTTXczb1RJTGFpYXNlOHc1cXVMdEcrVzYvNGkvTDZTaDdD?=
 =?utf-8?B?Z1BBaVhRcHVDQWNGZHk3SFowTS8rVFZ2Ujh3d29PaFJBdDdJdkt2QzI0OHFN?=
 =?utf-8?B?TmprY0FMb0pCdVBuVjlISXEvaXUza3hvbGNkcldML0NOQys2dkVaSWJGekc4?=
 =?utf-8?B?SmJNdmZnRUpmbC82dzhXeS9kV2w2V1ZUNWROZmhkeVNNZEZKZk9pT3BZLzR5?=
 =?utf-8?B?TUh5OTF2VjFjOFUrWTNyQWc5RVpXQ2JmbWlWeGxwTUhTOWdaVUUveUpVcEpm?=
 =?utf-8?B?MTVOZkcvQUYrazJHY3l3dkVISEo5RTIzb1daUXhkb3lqVEZNZFhjL0VvWkJm?=
 =?utf-8?B?Y045QU03aXpuSmh3R3RDMG9FYUxQRXp4LzBaZUpTeXRxa1VxNTdiNzZCcVhL?=
 =?utf-8?B?L1FmNHorcnUvaFBlUDE5cERqUlhSZ3dqY1NZNFZtNy95WHFWOEVHTDYwa2Rm?=
 =?utf-8?B?bjJ6ZkpzK2l2ZkJJeFpkNkxWNXB2QTdFNnROdEhEa2lYOXg2eVo0TkFSUncz?=
 =?utf-8?B?MzBrSXNuTEk5ckdUYkNMTTQwRlIya2JLR3ZjeWhFNXBGQkhXQ211THYvd0k4?=
 =?utf-8?B?NTNSZTlZaXZoWlFsdnJUNExFVTNOWmVtWFlGM2l5bEVOUkFudDJGZzZBL0dC?=
 =?utf-8?B?WExreEgwanBUbVVFZ1hsYjFPbzhKUkpTUlQvRGcvTWlpZ0NVYVVJYURhZ2Fw?=
 =?utf-8?B?Ny82dlBxVUVkdHk5dWJOdGliMnFXQms1czRWa1JCTUd5cVZxY3dEOGhVM3dy?=
 =?utf-8?B?TFpaSS9IOHU2YVMra2dIRUtuMVFCZjE5Mld0NjF5T3V6ZllwZ3krdk5rUDhF?=
 =?utf-8?B?NTdWL29IUVJJNFJCamE4STR1NXI5QlRYOGhTY1YxKzhQUnFWR0lKSlNiTFRF?=
 =?utf-8?B?ZkVUZmROME1ENnZGa0pkbVVGRm85aUx6cDUxUVFTWUIweFU0dUVyZ2lBUFJq?=
 =?utf-8?B?aDEwdE5WNy9QaU9rMnRoRlFmK1VOSldIc2VkWFd1bGZWNzJCZkRmcHBJY3lC?=
 =?utf-8?B?bVg5QkNhaDZSSk1CSnkraWMwSm5WRTk2MmZDTkxHdmkweC9tY2loRFdWbXhT?=
 =?utf-8?B?TkhOWUkwTlRiWlV4bTcrMW1mbkVPcTI3SElzWVQ3YlhJaExtR3dwdTVPQXND?=
 =?utf-8?B?eG1LTEFPeFNsUDFFVWt1YjJERFJjNzVEWXNUMFB0aHFTeFFBUVltZFQyN2s2?=
 =?utf-8?B?WTVEUmpGSHE1VFB0cWh6N2NhRTByamNod0x6SFpYRjh1dit5M1JxUnUyTHBY?=
 =?utf-8?B?WGVrWFFwMGpXR1p4UnhLeFJRdHprbzhUNGFXejdrU2ZEWndPUUtteDcyMFM5?=
 =?utf-8?B?b21ZNWs5Yy9OMlZuV3NUaytOd1pQODdiVFNXbjQwU0Fsd2NsN1hjZHVtSVFI?=
 =?utf-8?B?S0pwMVZtMGxnQlFaVGVzY1dvWHZldDhOdm8xSHBpZ3pWYjc0R08yWUtMK09I?=
 =?utf-8?B?T1ZRS2VCV2Y3L0diNG5oYXFidkFRdlhkaGEwWno1N3p2Z1JmS2JjaUlRTDFN?=
 =?utf-8?B?eUdHcEQ5b1ErZzRnMXUxZkY3bkdoWHd0WHRsby8yMVI4UDRKQ0tGMXBuN0hD?=
 =?utf-8?B?WGFpbm9CRXNXWUphMjM3cGhCQUgwOWd3UGJVc290VUYvNVFxZ3JRdVc1TXBB?=
 =?utf-8?B?OUF4V0F2anA3V0pTODJrYkd2THVlMTNXUm5TNjBla3lWYkVtMllyd1R3ZDZ5?=
 =?utf-8?B?eVl4WithSDFxMWZndmVUeFdxVEErSjM3K3BpUysveTRVdmdpY1RxZkl0VVc4?=
 =?utf-8?B?UWp1eDc0WEJJeUdIYnF6RXQzTThQOXNyRFpuRVVTZzE0UzNHV1cwNmdsOTRu?=
 =?utf-8?Q?81Fe60tlugGP/W1mzvABhp679DQHOjlD/A5jiQJzI6tfB?=
X-MS-Exchange-AntiSpam-MessageData-1: fpbUvOOcEwTU3Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cfdd22-4a97-4630-19e0-08dee2424ca5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:25:51.7016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykAdcGC6a6M1bH4owx5whPyPt6+mHR38BJV4VeQmdF94kLbvcdOAyYdp2ZSWLMkeAecDxwbaDub3F/lTAYFRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
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

On Thursday, July 9, 2026 8:51=E2=80=AFPM Maxime Ripard wrote:
> The plane reset implementation creates a custom state subclass, but
> only initializes a pristine state without resetting any hardware. This
> is equivalent to what atomic_create_state expects. Convert to it.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: jonathanh@nvidia.com
> Cc: linux-tegra@vger.kernel.org
> Cc: mperttunen@nvidia.com
> Cc: thierry.reding@kernel.org
> ---
>  drivers/gpu/drm/tegra/plane.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.=
c
> index 0cb30910773f..2148b0c59815 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -22,32 +22,28 @@ static void tegra_plane_destroy(struct drm_plane *pla=
ne)
> =20
>  	drm_plane_cleanup(plane);
>  	kfree(p);
>  }
> =20
> -static void tegra_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *tegra_plane_atomic_create_state(struct dr=
m_plane *plane)
>  {
>  	struct tegra_plane *p =3D to_tegra_plane(plane);
>  	struct tegra_plane_state *state;
>  	unsigned int i;
> =20
> -	if (plane->state)
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -
> -	kfree(plane->state);
> -	plane->state =3D NULL;
> -
>  	state =3D kzalloc_obj(*state);
> -	if (state) {
> -		plane->state =3D &state->base;
> -		plane->state->plane =3D plane;
> -		plane->state->zpos =3D p->index;
> -		plane->state->normalized_zpos =3D p->index;
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> =20
> -		for (i =3D 0; i < 3; i++)
> -			state->iova[i] =3D DMA_MAPPING_ERROR;
> -	}
> +	state->base.plane =3D plane;
> +	state->base.zpos =3D p->index;
> +	state->base.normalized_zpos =3D p->index;
> +
> +	for (i =3D 0; i < 3; i++)
> +		state->iova[i] =3D DMA_MAPPING_ERROR;
> +
> +	return &state->base;
>  }
> =20
>  static struct drm_plane_state *
>  tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
>  {
> @@ -129,11 +125,11 @@ static bool tegra_plane_format_mod_supported(struct=
 drm_plane *plane,
> =20
>  const struct drm_plane_funcs tegra_plane_funcs =3D {
>  	.update_plane =3D drm_atomic_helper_update_plane,
>  	.disable_plane =3D drm_atomic_helper_disable_plane,
>  	.destroy =3D tegra_plane_destroy,
> -	.reset =3D tegra_plane_reset,
> +	.atomic_create_state =3D tegra_plane_atomic_create_state,
>  	.atomic_duplicate_state =3D tegra_plane_atomic_duplicate_state,
>  	.atomic_destroy_state =3D tegra_plane_atomic_destroy_state,
>  	.format_mod_supported =3D tegra_plane_format_mod_supported,
>  };
> =20
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>



