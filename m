Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC38DF36C31
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 07:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2814310EBCA;
	Mon, 20 Apr 2026 07:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBbtt0Ag";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012024.outbound.protection.outlook.com
 [40.107.200.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16BD10EBC4
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 07:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2Vc0yiVYUBxG0og+GlK4xsDa3wQlzRU2PZeffDjCNyrs7DvAFXN5naf5hVNBwsb0m+O1N+OkefH1k4bCJdfbfLyAxHF+Wf2Ki0ifLniK0116Z+TgEHmNKAi8jMc5fC/YLCIdprv7tBYWNMw8spg0enSfrnYha+yZMFTJ+fn9eZf16AwJSHbbDo9CrH4M8KNfpc/n9FCJM+FhaNOT2iNWdNDQ4abMHvkZhgLAHsVZuvJtIkweIMdLpEMLuYRC1YmOsUUaTgWBZep6gsCKbhpPI0gqvpgxrgzu3EL0VkAJzSCT79tK2mzlKzKz61tNaUyMLix5FVD//mkxLgbLZjyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WKRZP7nvYULjLwFUh2QVim7srXU6nN1gfG6SuxNTM0=;
 b=xGBgEF2GNRzVMLhAgLNAS4+gurtx9BzltFhhUx2uthWdHHXGjvRcKffQgN7LwTKGAYMc+X2vomaA3bN7reGoALUqNWo0dYzeGZOFPvpnz4be499YABXQ5Wi8iEh/pyx4UG8D1XR6Z6h58V5xTSmXJbBPx5dNB2rit5vyhdV7a6ZNbVL2voffomhapK/nSgM83FSwULw6O3muQOIv4NI6/fpiDmmQeiCXV6yw/ChHORsykqN3LK8gxk24h454Lhzxcw3HaUUwxktIvSMSJuvRPzD/xoS8H09ImLx2ROIY/HcpoC4nnnnMJvlVIMEEq9yKpBnR008pyUO1QRlFxGT6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WKRZP7nvYULjLwFUh2QVim7srXU6nN1gfG6SuxNTM0=;
 b=sBbtt0Agkk8Ap2F/TcRsHd0vYXIPm9oris4/PAodiG43PJ2ilGitrUvC99Gl0o6i6dXrc6sAOwUlpjn3SuiekakQB6lsI1OpYwCXSslnOpNhUV2jatY/kAlCT+c1E1U57Q4zD99WJb0jCv95QVEorbV3I5VMS/YCH8oOCTMxtX7ITI9b2nWa0wYH/7FnEGH3oHMLJ4DmUqte9gJXL10rtytZa1hfLgGXpvCyTmjCdQn0Ff8pueLXNv0CP2u/jowmuICqinVLZ8OoH/K+xepWy52Nd6oBDL4kZjUHZp6iyK7K+GY8kn4jvYKdRKrtrClNkKce/Me06cEgWMNDrpZEmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 07:19:37 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 07:19:37 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Vamsee Vardhan Thummala <vthummala@nvidia.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2] gpu: host1x: Fix device reference leak in device_add()
 error path
Date: Mon, 20 Apr 2026 16:19:33 +0900
Message-ID: <q6Ni253ETr-zY8OZRWnm4g@nvidia.com>
In-Reply-To: <20260413141328.2954939-1-lgs201920130244@gmail.com>
References: <20260413141328.2954939-1-lgs201920130244@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0171.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6024c0ff-dcca-4258-94e9-08de9ead2e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: U6lVEAnIEovHEPlyRtguvHr8ZAfPq4PpRZdMS/UULK6qetRWmSd8dGX9ryg4MmFTGHzTjRT+8S0nHlgaxEWbbGNOIxP7UzP5Mp1E2m+1Qsbo+Bqihx9tsvrht0pNFo3mJZk5b5z3XaY044wYQ7cDjmnnbpiYl1nDjLDt8GX9WgdK80On77wDCpbGzI0sNDAKOwM8ZAtYQZGNR76uR5Elf1vOw/j1p7ehZik7Qcqhn7l//ifao+N7pqSnTeH7Lo6rcpUYsv3TpC2WtJ1QlboTnUD6DbPl23sGZpdtWBpGQptW/kG7LluBt714BtUu6GBLQgQ4ffy/R/eJtgSSV4gexaYNRcqcwfb0lRfSYK08g3DECEIdoGcT/TuN/xzdT4X1tiSFAPrqBF5TRIyclymIglrPd/SkmNXqqU+Hf4oHuqOSacBF4h2f5ZFjLXckoDS1pyVMoBvcpDcDcfZ6XyByt7xzz93tL1vO5VxlKKj25eB2GR+vZE7XWcvjHvjYWWtCnR1A39oy/uUwBVenau/Tgb/2v+9KgXfVUUq2XtlWKl10et35T7JWWgh4yVfCSnXNN0aTRiukk1Rvo9LwmNYz36R2mEI3XRCmQFP4bFQh+GqjrslxozU+o3O5cowJB9WOOtQ16ipZD6X0freinohRxdj4FpVPcoYSwo7M2c3dYaFXvXgZXraKqhWaOQAno0T4ia7dMZsGMLt7k1hG3W2gu3ylS9yilbWDntxRGnKraOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1PNExDZHlwOGt6RzJkZFJNZGdFc0FLRVR0aEZPeXhydFRuTTVlZm5odmNF?=
 =?utf-8?B?bTBYeGRUUWtEYnZCSnE0eW5uZHlkMU1zQ2FKNzlvaE1CWlpiRE1oN2Y3bUdh?=
 =?utf-8?B?aTg0UzN1QmdLWkhQcDhwZmplaW9zWlVEWThlZDM1SlVvRGVnUmtDVVVqOGxG?=
 =?utf-8?B?SFNVVng1d0N1UWNZaU4weVJKeVdIWkpDOVRqZWNFMVRUSVdoSC9sd2dUbDBZ?=
 =?utf-8?B?bEhyZTZKa00yQ3RFNnlSeHNpME9UN21SRWNHOG1sWDd2d2dRRXVyMWZXWkFr?=
 =?utf-8?B?RlpMYXNwdHAvMk9VT1o2NkNPYkx5N2VadU8rQmEzaGJEaG8yVFcwcTVUNjR6?=
 =?utf-8?B?d2RvZWxjUXRDdWNzOElYV0d6VmhHTUF2Q0E0b2dhRWxSWmxGR29wRU8zVWRX?=
 =?utf-8?B?d0Vsay96WHlQL1hnTDR4YzVPdXpRQ0pGMjZBTUFRbktxWEwySGxWYXJhZFkx?=
 =?utf-8?B?V0JPRWMrWit3TkFvbG1QNXFhTHdYZEZaN1hVYTRJVFgvYzV0U0JzNUpIWGV6?=
 =?utf-8?B?T0FVL2ozRUd4SzkzY3BSbEtwM1pPb1c5clhDSkJNbDZHUEMrQVlCVDhtbjZ5?=
 =?utf-8?B?ZmNwV2ZvYmxKSzRTejZCY2dVSkpVKzQwSlRSRDRnc2lFTStBVUZYTDMvUTR4?=
 =?utf-8?B?UE5kWHpLVzB1d29IUUprV05EVEJuL01TclFCZno1UW93ZFlaaUpVMEoxQVRQ?=
 =?utf-8?B?SE0xazNUYWpjQjBncGlDd2xZby9QeS9RSFVUcm9CNUZHbGo0R0pjMi85dDF0?=
 =?utf-8?B?Rkk1cG5uK0paNkFxUmlOMHFvU2MvNDQ2VzN4V215b0FHalIyWEV1cCtyK3lG?=
 =?utf-8?B?MkoyVTZiK3dmeldWSGwvUllOWEwreHNBNEZQNFlPeGhRZ2kwcmhZS1VTQXNE?=
 =?utf-8?B?QitvRmlIU01rTXhTTjVReGJ5RE1vc1Q4ZjA4NjBNU0I0WDBQNFlqbk1IaVZN?=
 =?utf-8?B?RUpxNTRvTXVBb0FXS2NCWUFFWFM4MURMZ0Q1dzJkcGEzZWhCdy8yNHkrcnVm?=
 =?utf-8?B?NFd0ZHJSREx3bG9vbGZVMjNDd2lvVkVta0Zld0FYVXJBYVBPV0tFTE1nbjdv?=
 =?utf-8?B?VHJUcjN1b2NqWGRsRGExSTdzSXVKMDEzRkdHa08vdHdYME9KTDRYdmdidlZt?=
 =?utf-8?B?TGFLVGNWY3UwZ1U4M3FkS1hCTWdxd3pMV1NkMFB6d2xjbGppTTR0ZExOUW8z?=
 =?utf-8?B?dldHZmRYb1NqZ1Q4dVNENENCMlo5LzB6NUFIRjNoVWJFUzVhdWJKWmloemJI?=
 =?utf-8?B?YS9VWE9xbDNyZkZhdnNXL25oTHNtcldTVUN6cEtPQTZLeGN2QVUxOFpPTFpk?=
 =?utf-8?B?OXE3OTVlQThibE45TytQMFZnZDNVS0xHcHl2TmpnTGNBd2M5UUtqUENGR3ZK?=
 =?utf-8?B?SmxSYllFZXFmYWVuZk9KMmRaaWxPdmJqMWNqdWNmVGpvWWJuUHNuUVgwNzBn?=
 =?utf-8?B?VU9VamluM0QyK3crWkxiWGtLSzBqVDdXRXN3bnJ3R2NEU1h2L1RGVHF2aW9X?=
 =?utf-8?B?ck1XZFB2bUZ5MUJVT0xRWUdIUTJFeDIyMGRCbmh0cDVJVmxiSEtJUjlUMjRo?=
 =?utf-8?B?ZjRIc1cyK0RLMExFNGhoRFBkdFpxQjJ1ZSs4WWhpelFydlpZWjlUa2w4T2dT?=
 =?utf-8?B?aC9ZdlI4UEtFeXlXOVQ2Wi9TNVpmRG1rOTVvMVN1dXhpV1Q2Rk41S1lSN0dG?=
 =?utf-8?B?bE1CZ255UkQvYlZnQkJnbTVaUkRqZXNqOGxvelRmSTRBc1lGeVZrK2V2RjZO?=
 =?utf-8?B?NFpBZ2Fsa0o0bll4dFd5ekVrM1FtMGRxWVZXdDQvaGdTK2NESnR5RUFtUmZq?=
 =?utf-8?B?emdPWlE5cFh2TWduUm51dHJ5TmhPOFk5TG1MaGZNVjJUc1dSUkpwazdLVHIy?=
 =?utf-8?B?dll4M1FPRUgzTEVGOWRidGE4eC8rdVBvQnhkMlNQV1F3a0tKS0Z0QkN1a3Nr?=
 =?utf-8?B?WDI1cTVLa0gwUU9Md2ZQeGxzL3k5ODlPR1B5ekNJWHN6TVJLVXBVMHExclN3?=
 =?utf-8?B?Yk5iZHpCWCsrc2g3UEdrUVgraUxML056ZWZGUllQQngyZ0VvK1VoSGFDR1hM?=
 =?utf-8?B?bWZReVlJY25Uc2dKbHhib243SmwxT2JOWTBFdnI1YWduVlRhSmhkU3R4MFdk?=
 =?utf-8?B?SkJlUGNsYTF6OUtHYm90RVRxeTF0MjlheHdEQ2lmVHVZLy9xRG12QklnVFo2?=
 =?utf-8?B?MndTaXJUMEt2Ui9jOXZWU1JwZmRrZGVvSlhzQ2FpWkpHMzhheWdidnV3d2ZT?=
 =?utf-8?B?bVBKNW9vMm9NaStGeXlGRmx1akJhUmdUNENwc2dHM0x3NWdzZHlUWk50RTI2?=
 =?utf-8?B?T2t3dHN5UE9wMCttdDVXZkFKVVl0VldLYnNjcGRHandqNnl2VlJvWU1oVXRB?=
 =?utf-8?Q?rki1+ScCQp8Erx9E+Kh0a7wDoF3KVy0iLnlVSFYLNTMjQ?=
X-MS-Exchange-AntiSpam-MessageData-1: +Sk7xqqcngaIWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6024c0ff-dcca-4258-94e9-08de9ead2e3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:19:37.6912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmu3KDWumW8Zo1ngpap0RlKVJrTFXKOHiwrhLljqOga6+XW3yTmU++YRu21qCpZPHIu6qY1yO51iflZknBkYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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

On Monday, April 13, 2026 11:13=E2=80=AFPM Guangshuo Li wrote:
> After device_initialize(), the embedded struct device in struct
> host1x_device should be released through the device core with
> put_device().
>=20
> In host1x_device_add(), the empty-subdevice path calls
> device_add(&device->dev), but if that fails it only logs the error and
> continues without dropping the device reference. That leaks the
> reference held on the embedded struct device.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fix this by removing the device from host1x->devices and calling
> put_device() when device_add() fails.
>=20
> Fixes: fab823d82ee50 ("gpu: host1x: Allow loading tegra-drm without enabl=
ed engines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
>=20
>  drivers/firmware/edd.c   | 2 +-
>  drivers/gpu/host1x/bus.c | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
> index 55dec4eb2c00..82b326ce83ce 100644
> --- a/drivers/firmware/edd.c
> +++ b/drivers/firmware/edd.c
> @@ -748,7 +748,7 @@ edd_init(void)
> =20
>  		rc =3D edd_device_register(edev, i);
>  		if (rc) {
> -			kfree(edev);
> +			kobject_put(&edev->kobj);
>  			goto out;
>  		}
>  		edd_devices[i] =3D edev;

Unrelated ..

> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 723a80895cd4..63fe037c3b65 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -477,8 +477,12 @@ static int host1x_device_add(struct host1x *host1x,
>  	 */
>  	if (list_empty(&device->subdevs)) {
>  		err =3D device_add(&device->dev);
> -		if (err < 0)
> +		if (err < 0) {
>  			dev_err(&device->dev, "failed to add device: %d\n", err);
> +			list_del(&device->list);
> +			put_device(&device->dev);
> +			return err;
> +		}
>  		else
>  			device->registered =3D true;

This isn't a leak -- if device_add fails, the device is still on the
device list, though in a "stuck" state, and will get cleaned up through
host1x_device_del.

Thanks
Mikko

>  	}
> --=20
> 2.43.0
>=20
>=20




