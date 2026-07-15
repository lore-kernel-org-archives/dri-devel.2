Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E481C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 09:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972B610E155;
	Wed, 15 Jul 2026 09:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0VyDjLQN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BC810E14F;
 Wed, 15 Jul 2026 09:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNplpoUPNGxnuqz6DcLsDuzMB3lTNlMG+nZ6xgHRCYjkJtEiLm2ckWTYtVEbM8rTBOvdKLryyeJFOWddHXc+nO7YyWi4zB0OnrLNl0I+ip0WGoJaJoIUlifNbImyTtyfy9a5pSyb8NlVbfROCXnrYN9G8osKm8klZjkDrQ+D31bKEMlvgvN93Y7m8hiuAvrCnOogBA7BjkzaCNUkCgdg8UkzzL8ZQFhKX+4lN4n7HmLKveKdMi5eYX8SWMqeMTb82XFzqAYv/kxWgJxdL/dvWCe1GYhudXuxcrkN8suc6Myf9eDd0HG4jnJcb9hEjT+PAGP1YBrALczA24S0W4T9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjIUBtmEyXZqdRNtpIicMeo7aziDt73aBfi+rEznCn4=;
 b=u5XhtAbezs1qWg9l2yoIqXAzqvKj9Td5aPdTWHHYDSU8IEYRJJfL624jtjh+eUwOKdXDnpc9rJVooewfP0xdH7D1qFIUikUIuqHUu++SBKn0VBzCpKgv+razk+cs+kBe2t3d9zm5vq1jdPqw1Y2/9QHGE8+pW2EUDjMqkr+yBYRsHyHrMONcryQLmtf9ucq6r8UDQXPjqyl+4YnYduDM8EI2ybXPcBUNxxMI0K1z9Eox+EP+BzNo5Lwwp5Op8jzyEk6TltvNCo/FalfSDcohbDSUGR3RiHkgu2wNUGYrTLlsi7f8cBx9BCZdUkG+6D1H9TtP8MV3Y6EiXw2B0OYktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjIUBtmEyXZqdRNtpIicMeo7aziDt73aBfi+rEznCn4=;
 b=0VyDjLQNle7wmhh6rKtndWPrMwgxiJBb7tLqmTyClnJoAFyeFYTs3vJvxgTC451/j+n6SjFMSvbjBs4nw4wFVgeZYeWygY6u1LY0rb+J5MbK0J16tUI08eSUWk4rNwzeQwA4WmOJJNoYsLJoOmEWJhpJrj3z6KfN+EmMve4NQkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 09:15:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:15:43 +0000
Message-ID: <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
Date: Wed, 15 Jul 2026 11:15:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999131:EE_
X-MS-Office365-Filtering-Correlation-Id: cd705307-5c58-4605-3c26-08dee251a57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: FIdEpi3A66NPxGTO/Xkl4wXlvWIXKFWc6MtP+/7BUBcg+gPKBQ8JzyGnQ0hVq7gUnCKfUJmM9/uF2Iq+5vuJGvZUwwK4WIz9IuMZRMWUq5p0h8ZutN4EyvlpFKbpqtCshIgOinI4ToN4LhOznpTt3hH5TGFlB3r0sNO0I5G32pAdhIsiNM7K4/mT4dm2jkFhbPs0TRM4zZWdSB7IWVp6OlRJVDsSH8uavz+pMMNvvN917aSBfP5LgGMm1gRieGkGqnJqCOYwAPMOGXZ9ixDELfmuq7nmmoBWOGT+gMUcZm4VMHrChgecwimls4UgtJIOUWhpUd50QJ6u3UvLkziAah7ejzGduWTHWVJzIw8zJRiBD7irjjMZvXOh9cNo/hdsazHlr59xB1wgBX78JcmnLSwe0HRtM3KDFgS490eUkgKY34IOaEd//82YH1F9mMzZUlM9wR2wwPdJ+givcd9xJCCh8qbR1PDotTaqXtYmz5XbYZ0oU9Q3Fr4QsliPsUxxNEndW9VOM9dhc/KpCzwBnB10yCogVoni6biDrFOsnVNTnA1d8Gg2/J21k3d0YAS6PzMfHydGtWDeU37R3UunQLNzZ7x7lEskH/fF7QPPkNAW+dIUiWBVvabBJ9iBxT94kxx+IqjlL8njwE55+F3Dug9KHjLDcmwAT1YnwtRDbY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU0wMThKMFZlenR5NGY5cVNqMTAxQ1c5MW51QXRqQ2VZRUJqOHduZkUwK1hO?=
 =?utf-8?B?SjE5UTNzZ2hHYTFNRGpiakkzKzhCTEE2K29DWkNoUEJjUHVaS21rSDladDQw?=
 =?utf-8?B?TmdKSHVBYUJnUFJQTTF4RDhPK0ZkZUhJTiswU2gveWIwUFBFUUxNMmk5RUJ1?=
 =?utf-8?B?U1M3WEFUK2VBQTR3Ymcyc2pObTdEZzJUOUw5cjZVTmpuRVVSQmU4Tnprb1Z0?=
 =?utf-8?B?dkpyKytJNmlJSWNRa1Fac0NhTUEveTdtb1dFQ1pjQmRoMXNYcTd5d3lyWHA3?=
 =?utf-8?B?NGxtRllJK1NYck9sV3FWRUdvMXNtMjVCREFhZUtqQkYydHlPTlRwbStKaEZB?=
 =?utf-8?B?RUVrOEI5Z1oxZENNMjJVYUpzcWNuZHdOak1ZNktZMjJDaWswRjFuV05FeVB3?=
 =?utf-8?B?WVp4MjVvYXZoTGllQkxpdWJTSGZ6SnhRU2gzRUtheEFGQ2RaNnZMV1UwQURV?=
 =?utf-8?B?ODl2WWVJQTBSWlpCdlJwZUl0RWQ3NXhtYTFtYjRLTmtVMW54N25ScUE4VStJ?=
 =?utf-8?B?cE5LS1VRbmRGNHBoV3FlUUZXTyttZ05BMThHWE1PTEdZQTl6WGtCTUdab0RX?=
 =?utf-8?B?Zkd1UG1FSGJFQUhNNlFPQno1Z3lOZExLUk9nVG1zTmxlWFZoTXhNazRoUldC?=
 =?utf-8?B?RHpwMDhKRkR3bzNEaWVYQnBoMXp5Zm9xNG9MSVRpMUx4MkN2Mkx5bnV0V3d3?=
 =?utf-8?B?WmpkVm11OExFcE5vZGFFa2wwcmNzdk14Tkg1M3lncTQwQVR2eENrTVVzWUl3?=
 =?utf-8?B?dXVkTXVPS1g3cUdTZU1vRTl1dFpZblFOeEZ5ZFFDR1dpV3hNV25aSCtxTGpG?=
 =?utf-8?B?akFWYXdTRGlXOXhCMW1kWGxqTkVTKzZZQjljT0NkaisrMXdzanQ3V0tRWW9r?=
 =?utf-8?B?V1Uxc0ZKTys5WmtWR2ZYUHBUR21nZUdNZ1lIeEw5aitnMDNJdFdCSDB1RVhu?=
 =?utf-8?B?UURYZE5VMkdEeTNxZG5la2ZQV2lWZENuVTJLRHFDUWR2aXMySjRiRTdQamhS?=
 =?utf-8?B?SWlrc0NTWENURVFSRGEzdC9sSnU3TEEzelZLa2o3RTJqVGVYZjJ2aFkwUktB?=
 =?utf-8?B?MWIxMGRjbTY1RjQ3WlUyKzN4OUFzVk1NT0RTTXJ1VjBISzQ0R3lEcnZMK0Ey?=
 =?utf-8?B?bzVSYmc4ZlpjSTBhT1EveDdzOWJLVjVpMm55VldjS0FoOHUzQUEzb2dVQy9i?=
 =?utf-8?B?R2Z6REpwQkZva3RlYTQydmNyZGw5dWpCeGIxeVY5c2JLNDdSRDRra0drZDBt?=
 =?utf-8?B?dVRXQXFleUl1UlpQY0srRCtIeXlqclFUZkxpVnBYV2t0WmEvUFRJNVRHQVJv?=
 =?utf-8?B?RWJhZ3hZYk5XS29NbnJXbmY0R1UxRktmZ3MwS0NNNEJHKzFmb0xIREpqaFFS?=
 =?utf-8?B?ejFRUlhnVWlxejVrOUxSSmVyWEFWNEZDZEY0UksrVG1VS0JuaGtjT1FWQmpF?=
 =?utf-8?B?b1p2YWxoUWhpenNtM3FzUzRuRCswU0lMV2FyaERhK3dLRFNsdW5hYVdmblRN?=
 =?utf-8?B?VTlKanExa2FKRVhJSG8zNEdYRG5nRkl5SHFFT0FaSW9VMGNEcUdYWkRFSjhU?=
 =?utf-8?B?QlBHeXNrcXpLVmZZWVBWRDZSMDkyNzNHZVhid0hpOVlTKzJkY1ZTRlhmZTVW?=
 =?utf-8?B?cmcxUUh4MXlyQlVFTzRPZHhOU256Qll4aXBGMEJEYWhYcTJkRmppd3JwV2pF?=
 =?utf-8?B?VnlXN2xDS012ckR4TnFZdDBtcFFQWWxkQ2QzWE9BRWRwVWphdTdNL0s2WmFh?=
 =?utf-8?B?WFNZSUgzV2YwZkt2MWVYS3JNL0F0MWZHRWhxMkxBN3BhaHJ6d0tiVTAzZDZJ?=
 =?utf-8?B?TS9hZHVCalhPV001SzN1Y0lqMFBVdXRnZjdXZDYvWWFWMTRsOGVsR0pxLzhi?=
 =?utf-8?B?cGZWMXkra2V1bXBYeElUTC9mcVZNVzljcG5iMmIrTU9DUVE3Ymk5Z2xjejR1?=
 =?utf-8?B?YnVwWHVKdG9BekxWYUxSaVhQYXk3WmpDK1QzdHViYjNTT2FFRUU3ZURwQnlG?=
 =?utf-8?B?bHhSUFhwNVRzRWw5S2swbWdlYmJ1aDNWZGdiRWFtUFlQdW9Yczg1Z1J6ZEdO?=
 =?utf-8?B?OWZwWUhDSy9nMU96NmkvT2RuY0NoM0N4UTZlcGhGY0NtR3NkajVmamdNZDRV?=
 =?utf-8?B?VDdnME92VURzNzdNM1R0QkJZNEw1Rm5FNDVYTk5JYW84QUxsM2xnM1EwWDBx?=
 =?utf-8?B?cmVKeVhoNmg4L1JjZnJFTGdrMlc1YnYvYWxvVlNWL3hsL2xIdy9DMy93VXpS?=
 =?utf-8?B?elRPTG9rTU5aOWFzTVZhNGJud2Z6Tko1MWRQV2hDQndQUWFJdS85ZE1xRXRq?=
 =?utf-8?Q?4icOdEii1JbBGkb2nk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd705307-5c58-4605-3c26-08dee251a57a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:15:43.0956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQD4Y+xtwDxGKq6P5UlrWsZvb5JUtTG6hENPTesZtl4imeaP70zFN+LGeAXg/Yx8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131
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

On 7/14/26 18:03, Anirudh Srinivasan wrote:
> radeon fails to probe on platforms that have all their memory above the
> 32-bit range with an -ENOMEM because dummy_page_init calls
> alloc_page(GFP_DMA32), which would fail.

Unfortunately I clearly have to reject this.

The DMA32 allocation is mandatory for radeon to work correctly on some platforms.

> Allow this driver to work on such platforms by falling back to
> ZONE_NORMAL regions. dma_map_page called subsequently would catch any
> issues with the device being unable to DMA into the mapped page.

No, it doesn't.

It's just your special case that dma_map_page() is able to use some IOMMU to remap the page below 32bits so that the driver can access it.

The problem is that we have quite a bunch of cases where this doesn't work correctly and eventually result in all kinds of trouble, including random memory corruptions.

In those cases it's better to not load the driver at all than to later deal with corrupted data.

What could be possible is to add a special quirk for your platform to not allocate the dummy page as DMA32 in the first place.

> An equivalent fix was applied to ttm in commit 0a8c1feed387 ("drm/ttm:
> allocate dummy_read_page without DMA32 on fail")

Yeah, but only after making sure that radeon still doesn't load on such platforms.

Regards,
Christian.

> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> I had issues getting a R5 430 (Oland) with the radeon driver to probe on
> a spacemit K3, which has no 32-bit memory regions. With this patch, the
> driver was able to probe. The K3 supports up to 40 bit DMA and also has
> an IOMMU, so the card works with the board. I was able to reach a
> framebuffer console with this patch.
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 705c012fcf9e0..e8b1fa715a648 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -783,9 +783,15 @@ int radeon_dummy_page_init(struct radeon_device *rdev)
>  {
>         if (rdev->dummy_page.page)
>                 return 0;
> -       rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO);
> -       if (rdev->dummy_page.page == NULL)
> -               return -ENOMEM;
> +       rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO |
> +                                   __GFP_NOWARN);
> +       /* Retry without GFP_DMA32 for platforms where DMA32 is not available */
> +       if (rdev->dummy_page.page == NULL) {
> +               rdev->dummy_page.page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +               if (rdev->dummy_page.page == NULL)
> +                       return -ENOMEM;
> +               dev_warn(&rdev->pdev->dev, "Falling back to non-DMA32 dummy page allocation\n");
> +       }
>         rdev->dummy_page.addr = dma_map_page(&rdev->pdev->dev, rdev->dummy_page.page,
>                                         0, PAGE_SIZE, DMA_BIDIRECTIONAL);
>         if (dma_mapping_error(&rdev->pdev->dev, rdev->dummy_page.addr)) {
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260714-radeon_32bit_fix-8b1058b6d571
> 
> Best regards,
> --
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> 

