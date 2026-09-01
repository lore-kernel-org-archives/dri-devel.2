Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E45C624D6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B94110EF4E;
	Tue,  1 Sep 2026 21:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hn8Hp4lB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5755810EF2C;
 Tue,  1 Sep 2026 21:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5gso6t9LC4VSn7ZTccacSd6ZSrB867ucdyMv/QQilRB4vk+lQIAmBBKPnhlz+JpC6prlvwGx+WF/q3GLwzeCSy3cNIaI83QvP2NALVpJLhUu6d3W8aZIqhNHh2jU+p1CBsIQ4pd7lg5LFi+2S2BK7QU+4LiilhCz2mgmYr6PN0OUTX3BYh5Pt91MZ7pTEzavDfGm/MSM7er6tgAYjFrh38M3QA5Jltdl1mYAKkdxQvdmV+uLCarBQeY6tl5F2Et/mnAcYkFwwjrZC5xrjWNszFjw1BQVWN7iy2Vqbkd4wQWCkmYfdSyWuqMDTP7SkfItoPP1gtTgM6cnjPAfjQi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgGLdRhyLQMxAhjokcjoWtXnTElFzEgg8U5j86E/SgU=;
 b=S/M9ZoEU/BrSXRn/VQxjvkY2QOMkl9oSt5/yACY2OXpP5wGLwLpg63jEAzrp3AUp3HerJTAKy7XpgV6oWoJISp2rsyay+2jfGe/O1wn2mY1YhHhmpwLq8adOOTqeaOCSO/r6K/s+cww2u5q4WUQNJTymR7PQgrYkr7jac0ESH1gL2mLUZPRT2pTA1AnMntyPzlX7jnRRNupMEMoHr72Nio6HtmNBQncMuJmrpEAe3elis3v9RI/bRyoggZZvrPwf6vuNVedhTpMEz0qZiypNYT4dr9kO9YKv2F+fNEEjY48hGakefwcoMThI5cSQ4l5Y9pYrA5/6c6lpM/IbcueFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgGLdRhyLQMxAhjokcjoWtXnTElFzEgg8U5j86E/SgU=;
 b=hn8Hp4lBt9dSY8M9CmxSHctRixR9p9BExJsURiV+TS3XdW0QLpAtHmi/xb7lTh2drGWBt7RjALnx0PmJ7IBg9nVWky+0fVl9h3UxqWTa5KbZE6OIKsptN9fnPoDGkbhG0ABhW4IYxmUXpHSgtVIFxiFckxqdV89kOOh/TdM5B0c=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:30:54 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:30:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Armin Wolf <W_Armin@gmx.de>, "hansg@kernel.org" <hansg@kernel.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux@weissschuh.net"
 <linux@weissschuh.net>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "jani.nikula@linux.intel.com"
 <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com"
 <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com"
 <rodrigo.vivi@intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
Thread-Topic: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
Thread-Index: AQHdGxicLMRYOjDhTUW2+FI64yGRP7a6e5WA
Date: Tue, 1 Sep 2026 21:30:50 +0000
Message-ID: <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
In-Reply-To: <20260724025959.142826-3-W_Armin@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-01T21:29:02.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA3PR12MB9131:EE_
x-ms-office365-filtering-correlation-id: 7eab1ffc-d3a2-4274-a742-08df08704b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Jv8NAfTTQLbWOVZkZiwfCDjka7PxDF3pGr+9F92/ga3m5a0ddaL68yJ6tXjKBksuDSst33eUB934yH6Unx2ak8ucixXQRlmD7XrNHD8XngVwbKKxol23Y1xmeUnCiewXcU6W4PTnMaJ5tbxZobrDpisamRycZO/cftJFJbGkVqpMfZ/rXYTTpj6vC9HBztgqVFaNHNAFHDigH91d+1AdQXjpe6wsMgcsUXgWJ7zGhksU6bwh6SOJHQPQknntfxeDWodqwJRCfMBWlvR4yIfxY19rGvb6fURwV/Cn66Rl04aHkOyCFJpTMk/UbgDC32XZdFj6q7DUr6q6dDwialJwupb3C0AZolMXJ6XFmqj2O9yJy8EpI38xIu32T4t1Oo6+JtsmB/5+PuuARC8jxUVvWC6pA99x8yJ7d0thbvwd6xK3S+LIOwaeB79hw6NNgVLQm/j5Lx4acQnhzbToNmct1CiHvdiLIzfg0OriN/+E1PEc/vQFiHvxeEtI3y4QYPBLh4UarkSrCzfY4LIFXmNXr0Bf2LQdVDFUQVJovBSiGFsT2AwO4BgzLyU0ffQMFgel5Co9+PXiBXEXfVw0MAl9zAqSuag8uvHCjReHePFWd9upsN58jarhu6CbB+S6fu11lO8y8k7pRSeECUDkzm387iGKjzQwNUnrVWGpLtsh1hNPiGTr7ESIvUrFXCMY2caTrLwLLDf1eqbzCUVVLHY77imaTj/WDrGfT29Jsd97Yek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eN8H+ew9AoDBSl4RlYvs/ViDRwH3soSirvLJhjycrxVEMD9QjNNF0WRab+JD?=
 =?us-ascii?Q?a7FpmtvVy1hfji7SvQsapiP91YBom90ZPadkCES+H0IMXRUlk7BC7wGB7+ES?=
 =?us-ascii?Q?zzauMA2RucZTweWxijzzHQnAW9eVVA8vcxMhgpN2MU/Ef1TuHSLd1ns8vPEi?=
 =?us-ascii?Q?NdcOObem9TNm3cg2IWkBih9C4Ai+7ylSob8cte14S7GADa53jDeWz9f+brHj?=
 =?us-ascii?Q?wgJ+FGETpEAWIY50RcTxcIDKhbf58C279zrcPBVYwew2Qldd3StJ4rzdhu99?=
 =?us-ascii?Q?yqiBs+/Sfa3LEVz/Lkj6o8Gimc8EJrJbu2ijAZhvwnmn9s0p9VubmvdORRPn?=
 =?us-ascii?Q?yq/7BK3exs3ZqMilDgHNgE6FexsfNlV0qWiEI1g7MGUkhuJCa8Myvw6LfP1u?=
 =?us-ascii?Q?KdeiTq5hRDagrFcnKd/hZjhZeQKsZMHtqdxJ4bv4N0gzmOp3wckFun5ciUZ+?=
 =?us-ascii?Q?xJRQiTfGD8mqEaBhYbJgEpgsEKF0H0V+wPfnBenWKRicaR9dQtTLd7H9/Bv6?=
 =?us-ascii?Q?6w2pVfQeSuia5eho+PRSZNz8V41Jg7/a2tXO9cptHDi0X9ycQelsdl6YWxgs?=
 =?us-ascii?Q?2ggUWzTWnsRT2ja+5zimJny6K2UDWpnwTy2UEej1+GLYBP/nG+gvj1/kOHQi?=
 =?us-ascii?Q?wyNJDKP3Gxy8jYFTiFNPdcJsh50cpzLdLcsm2tzh0ZnKIyzNbt6/P3LErO46?=
 =?us-ascii?Q?k8T+owiPryisTNhT8ffHNXxOjJu1kdR1djXtOj5oxYDD3PPl/OVRw6lsUs+p?=
 =?us-ascii?Q?lNU1wpDR5K9+xUMf6ZL4zXMZXp8vj+76br4iGjhjDLZrKoaTzAd3Cqh8C6Y2?=
 =?us-ascii?Q?YgVz2gp6FReY+7WQ7hLvnf85wT62xnUKWi5yD5Ssasyvt8MFdUzBPXil4K1p?=
 =?us-ascii?Q?eU2e8rZZBeYKpk7eYs4ionlAylq7C40Y9ycd8m85iFt/KISZxSCQFGtg7CyH?=
 =?us-ascii?Q?9+Dzz6fD6SK7XUv5TPlXzCPYRVRLXoXwPZvNlp5hKGARMZgVRsXt/YnUlLT4?=
 =?us-ascii?Q?8QQ3ItAU2H4tLd4ZOYPYcOf86Dpb30PgiGI4rVcBLzqcCzJ5tA8VyGnNbxRZ?=
 =?us-ascii?Q?HCUC3CpB2VRwBKn3iMEbJNBnHsR9ciL4sagz22D2PCihkWEgbZjqn/hdbOW7?=
 =?us-ascii?Q?gdbJhSCXGV6oLnd4B+kKoichuuu/H1IZ2l4vLoVKJ4kGHsT3rnDTqxrMz5Iy?=
 =?us-ascii?Q?6M1gGzWlGa/qQyJY1HVmFfZG91bBcQPwXdZ6tYe3oo1tUbDhlbLR64JaZiSO?=
 =?us-ascii?Q?+hhC8JmTnMUPFUKnhG1Ov9FqBwpvEuRlFn1F9u6STvPceV1xFWyf09/kpMbX?=
 =?us-ascii?Q?mioi3/TtINUNTf9g55/MkkMdL/XtlQ68Htn6bYQ7rX+RwZd/vJF21fSwv5R0?=
 =?us-ascii?Q?mXpvXwEag1ENgw6pTDsJXtkK4bB3ZT358zhZqUxOTy8W/Ob4kwPV4TCtsr1q?=
 =?us-ascii?Q?Ve1z5JbMuBiZWJMhLhzIDKF0OedapZox3RkLgamtf1M3q9MvLKNrTpdMCf4v?=
 =?us-ascii?Q?0CAFOYqq5pOehaajvJWnTurSO1w46xLEaUEr+0gRGCMqY1GdIVExTNxM9esF?=
 =?us-ascii?Q?DrSfTzOJ0NWTjZMnAkNBL+1menij8jIEaL0VT9q4J18mXQWs1rGK01P5pGDs?=
 =?us-ascii?Q?URKMhI1MHnR1rr7imIssPEp1F2YDM8aZZcNV7K2AtR/vXW1nfOXlWwPfCC83?=
 =?us-ascii?Q?jVuu39GUaLmtSvmrOWmOlux81aj56a0TBETz6WVGTHHJhpew?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eab1ffc-d3a2-4274-a742-08df08704b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 21:30:50.6214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1m65ySK5MJp7RMslnbKRVPjmOexrSll+gjJbsTgKbRzWQCdYm9ArFQ1SbwK6R/W2AakA/8CsMf1IA+pCCz5AcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
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

Public

> -----Original Message-----
> From: Armin Wolf <W_Armin@gmx.de>
> Sent: Thursday, July 23, 2026 11:00 PM
> To: hansg@kernel.org; ilpo.jarvinen@linux.intel.com
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux@weissschuh.net; rafael@kernel.org; lenb@kernel.org; linux-
> acpi@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
> simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
> devel@lists.freedesktop.org; patrik.r.jakobsson@gmail.com;
> maarten.lankhorst@linux.intel.com; mripard@kernel.org;
> tzimmermann@suse.de; jani.nikula@linux.intel.com;
> joonas.lahtinen@linux.intel.com; rodrigo.vivi@intel.com;
> tursulin@ursulin.net; intel-gfx@lists.freedesktop.org;
> matthew.brost@intel.com; thomas.hellstrom@linux.intel.com; intel-
> xe@lists.freedesktop.org
> Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
> nvidia_wmi_ec_supported()
>
> The WMI-ACPI driver now supports architectures other than x86.
> Remove the CONFIG_X86 handling from video-detect and the associated
> drivers to simplify the resulting code.
>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/Kconfig               | 2 +-
>  drivers/acpi/video_detect.c        | 8 --------
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
>  drivers/gpu/drm/gma500/Kconfig     | 1 -
>  drivers/gpu/drm/i915/Kconfig       | 1 -
>  drivers/gpu/drm/radeon/Kconfig     | 4 +---
>  drivers/gpu/drm/xe/Kconfig         | 5 ++---
>  drivers/platform/loongarch/Kconfig | 1 +
>  8 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> f165d14cf61a..cc1e58fa664b 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>       tristate "Video"
>       depends on BACKLIGHT_CLASS_DEVICE
>       depends on INPUT
> -     depends on ACPI_WMI || !X86
> +     depends on ACPI_WMI
>       select THERMAL
>       help
>         This driver implements the ACPI Extensions For Display Adapters d=
iff
> --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c index
> 458efa4fe9d4..af9280b244f1 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context,
> void **rv)
>       return AE_OK;
>  }
>
> -/* This depends on ACPI_WMI which is X86 only */ -#ifdef CONFIG_X86
> static bool nvidia_wmi_ec_supported(void)  {
>       struct wmi_brightness_args args =3D {
> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>        */
>       return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;  } -#else -static =
bool
> nvidia_wmi_ec_supported(void) -{
> -     return false;
> -}
> -#endif
>
>  /* Force to use vendor driver when the ACPI device is known to be
>   * buggy */
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 12e4a41bf1f0..50305630f533 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>       # ACPI_VIDEO's dependencies must also be selected.
>       select INPUT if ACPI
>       select ACPI_VIDEO if ACPI
> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> -     select X86_PLATFORM_DEVICES if ACPI && X86

The change below makes sense, but this one looks like it should remain unle=
ss X86_PLATFORM_DEVICES is handled some other way?

Alex

> -     select ACPI_WMI if ACPI && X86
> +     select ACPI_WMI if ACPI
>       help
>         Choose this option if you have a recent AMD Radeon graphics card.
>
> diff --git a/drivers/gpu/drm/gma500/Kconfig
> b/drivers/gpu/drm/gma500/Kconfig index a2acaa699dd5..dc4c56638819
> 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -11,7 +11,6 @@ config DRM_GMA500
>       select ACPI_VIDEO if ACPI
>       select BACKLIGHT_CLASS_DEVICE if ACPI
>       select INPUT if ACPI
> -     select X86_PLATFORM_DEVICES if ACPI
>       select ACPI_WMI if ACPI
>       help
>         Say yes for an experimental 2D KMS framebuffer driver for the dif=
f --
> git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig index
> 5e939004b646..71426b9c91f0 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -28,7 +28,6 @@ config DRM_I915
>       # but for select to work, need to select ACPI_VIDEO's dependencies,
> ick
>       select BACKLIGHT_CLASS_DEVICE if ACPI
>       select INPUT if ACPI
> -     select X86_PLATFORM_DEVICES if ACPI
>       select ACPI_WMI if ACPI
>       select ACPI_VIDEO if ACPI
>       select SYNC_FILE
> diff --git a/drivers/gpu/drm/radeon/Kconfig
> b/drivers/gpu/drm/radeon/Kconfig index c479f0c0dd5c..3cd70aef770e
> 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -25,9 +25,7 @@ config DRM_RADEON
>       # ACPI_VIDEO's dependencies must also be selected.
>       select INPUT if ACPI
>       select ACPI_VIDEO if ACPI
> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> -     select X86_PLATFORM_DEVICES if ACPI && X86
> -     select ACPI_WMI if ACPI && X86
> +     select ACPI_WMI if ACPI
>       help
>         Choose this option if you have an ATI Radeon graphics card.  Ther=
e
>         are both PCI and AGP versions.  You don't need to choose this to =
diff -
> -git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig index
> 4d7dcaff2b91..502c7b3c1f16 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -4,7 +4,6 @@ config DRM_XE
>       depends on DRM && PCI
>       depends on KUNIT || !KUNIT
>       depends on INTEL_VSEC || !INTEL_VSEC
> -     depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
>       depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
>       select INTERVAL_TREE
>       # we need shmfs for the swappable backing store, and in particular
> @@ -29,8 +28,8 @@ config DRM_XE
>       # but for select to work, need to select ACPI_VIDEO's dependencies,
> ick
>       select BACKLIGHT_CLASS_DEVICE if ACPI
>       select INPUT if ACPI
> -     select ACPI_VIDEO if X86 && ACPI
> -     select ACPI_WMI if X86 && ACPI
> +     select ACPI_VIDEO if ACPI
> +     select ACPI_WMI if ACPI
>       select SYNC_FILE
>       select CRC32
>       select SND_HDA_I915 if SND_HDA_CORE
> diff --git a/drivers/platform/loongarch/Kconfig
> b/drivers/platform/loongarch/Kconfig
> index 447528797d07..db7833842142 100644
> --- a/drivers/platform/loongarch/Kconfig
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
>       depends on INPUT
>       depends on MACH_LOONGSON64
>       select ACPI_VIDEO
> +     select ACPI_WMI
>       select INPUT_SPARSEKMAP
>       default y
>       help
> --
> 2.39.5

