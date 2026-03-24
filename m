Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892DAF54AD0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD51110E62D;
	Tue, 24 Mar 2026 16:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IVK1IIHD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012038.outbound.protection.outlook.com
 [40.107.200.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CF810E621
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxSz35Mfca02p+KYbY15D+W/Tc/SQPdcVFBOsrkzmwDeBynD2vRHXaCGEkI0jAXu/HOwDRxIFPq8JUJRGzM9zfYB+s/KE1G3PCyHsEZ28SWlHnk7E8KO5wDOttcdr33ubcd/09MSq5thCYYv3DHErcY4Y0ymC40Nhr2JxYo/gudMA7Z+mwpCKintDvRwYdMxplON/DAo/uvTwSS00QvygEJB/hE3Nqizzxxg5nTusuhpgnXBm7W6bmV2aekidSBZyvk6omKys03OJvTHt/crs61Xy3Z7xYRjAqaeQsRQuRDYVhEO4iBwWBvW5RYHYFrrBt3GBd9uTbAd7uCkfDn34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iIZ5/pxc7JbWTlXAC4XGzazSEUu9I3ipS9gqpMj+DA=;
 b=P86NctsPa4fIQLrNCQq8xTZFLBxbrPelildYvU723t8mBDynBnxI6G563aGhrFJobzjnFYZUZZpQudD4XROFuid006xSmyE8PkqeIwC8ivq231sal/KvaF2CCJS9sDP1G8Du7s/kxK7vN5GYz44PTdEnrBRD58IUHEtepGAOXbYCPvEnanI1clU8InZjb4EzqEkrYOT2vl4BEl4zT/ah/hlj6LOFFbbtIQ3p3V9CXTyJRXy3rKE/SHToAUVzwAuKHv11BbG4FpxBAUNsTog+4khQPbMiKA4BBJ122OXrZPyb7FIBYco8NvHMC0UzGe/bJZvBEyZCAwFR09UB0dsGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIZ5/pxc7JbWTlXAC4XGzazSEUu9I3ipS9gqpMj+DA=;
 b=IVK1IIHDj/u2yTb7ZBK0FFQkgNfJhdNb7yoPHiYbyPs2IbpclJH90gy5WVwYRot5o5RBsQBfQAFrckDzGk1PkihqscAz6lJ+kLtRxPH/m0V9BpKG3en+qft2C70U33X9MZ9pELuMXm9SEBmBTQYzc5fzW+YyhrocttAmdPOu7C8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 16:04:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 16:04:18 +0000
Message-ID: <23ad27a7-5086-4a03-8a1d-e7b7dbbfd825@amd.com>
Date: Tue, 24 Mar 2026 17:04:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: fix dead default for DRM_TTM_KUNIT_TEST
To: Julian Braha <julianbraha@gmail.com>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 karolina.stolarek@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260323124118.1414913-1-julianbraha@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323124118.1414913-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f6124b-6de1-4098-efbb-08de89bf0133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: G9g3Qq4GYQisIOXNXf+q1vvRgQrTHv1OqDsc3SWUvI2ThpYELJkSJQHOXxvcUdYiWAwjmKso4wXSxc9pcRYz0x0fQQR4uzt8AtrIvYUx520xj2XvbZNjtK6rdNMDboSunMBethGFRKna4QLlhpW/gt0F+WHFjFXpVFnoP2OzaGZFerjNHZdCvmsQgnLaSvhTZkX1I04nFbW1ZmIK+ykRHwlimW/3NGxpdUDu5d14Sug1lC7AvKMDYiokywRAFCdzvAwrznmr6c/PxiLWPtyPfTkTeCgqGPTQDjUIP6+XOuut4JvVcMPI74l60BVQhU9MpSoeiLajeCe4gG6Pv4AlF5lLvIJkOR0McwSBtN/IPWJjmpVUt3f6JFigDgmm+mz4cOismj/jVhxewrqgsbdoMcsyIfUxaAG1y+A7iCyjeZD3ie9jn1u1ngG6HhN0yXZWN6Y++RG0PkucglVLDWMRyiONfsi355vyxxjTW7/rZ7QksbBb7PbUgpEUgSGdtxdCPUoz1ZhmC+Rq9QTJuhbtk6C+Tm/mYkYx93OfIebYdTKkI52O9EWInwmNw9mJrVaCB7mA8ema5Rsv2aWz2maejogtkU+PcToPpSqHtaWu9b8vsKZd7XW+XXlWioyJUe49JImnW12bEP+2tlxaj+GO2rgl2z+MGR2H6UDwi6cownQF+Fa7QeLH12iODHbKWX288cF9qd6tUnkKciJWODtVg6tZQuoTRsBdrBZVsYbx3Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXU1MGRCclZrVGFubWppcERSTEs2UXIrZjFDUUZSaU56V2pwdFF2VVo2WHZv?=
 =?utf-8?B?QWJIUXlzeFR1ZkRnQVhDOHU3aUVva1ZFMHZKdzNYSlNrZjhBV0d5RnRaeWFn?=
 =?utf-8?B?RDg2V2pPWVJxUVJxckJRblJsLzc5M2xoY1hJVnNkZEQyOG1LYmI3bzdhc0VQ?=
 =?utf-8?B?cDdLT24vWmhiUzNFWUN1YWlkYUNwQjdrVmlSdmRxT0xQU3FhV2hMK1NITm5x?=
 =?utf-8?B?eElycnVVY2VMR3dpQzNJMXlYWmEzY0dJN1EyTk51SldKcStDZlptR2tVOEVH?=
 =?utf-8?B?dWVzd0V6ditYajNDdDRBUDdRSW9KSTZGdUI2UTFsOGdSckZaSFJXQk92WFMr?=
 =?utf-8?B?eXpBaGhqZmt5d1IzRk9IYktlL1ZmUjBMa1pSYkZFMTd1SjNRSEtDZmF0MkNv?=
 =?utf-8?B?OXJsTkMwWnJuMGNJMVlXbGhTRVBMM3c0dVo1cUZocDZJUlpYZTluRmJYZjVX?=
 =?utf-8?B?SDhWUHNsMjRnWDVEalM5RHZqNVJaMURMbEdQNlZVR0I4dzRHQ09DaHZjYUo4?=
 =?utf-8?B?MjFERXNiWG1Na2Q5UWE5U2I2b1lrTCtCUjFyQ1I5Z2NqODYwT0o5ZVVXWG45?=
 =?utf-8?B?NVRVcjZiUTBnelJIaUgrenVQU2NkTFBnN1hsODQ0Q2pEeElXVUpHRk9MQmth?=
 =?utf-8?B?alBTQ2JsdjBYL093cnhlZTk5b1orc2dyTm5VUkxJYkdEb2FScUtxeGF6dlY4?=
 =?utf-8?B?UjJTSXdSbk42L2RZVE1HMDVRSGNBRWlnRHFhOVdCTkx5MUpBNE9hMTlaR2lZ?=
 =?utf-8?B?Y0NFTDFCblBRSXJWaE9jU2dqMjZCWnY4Y0xBN1B5dmtKdWlqeFcya2dqQk45?=
 =?utf-8?B?YURMZVNNSGMxV1FuRUlkZ1ZyblhsdjBFT0VCb2tPQ2xDQngxOW42c2dQOTEy?=
 =?utf-8?B?eUEyWklBanMrWkhKQkNOWUJXVHYvV2tzdW52SDgxNkFsSG5DZTZXV3FPT09Y?=
 =?utf-8?B?NnlCM01YcmpLdHZFNlIxTElpMEFDejBZVVFhVFBsU2Y1MUxPeDc0cDQ3d0Ny?=
 =?utf-8?B?TDZ6NTRwUGNnbDFHUkw2WTl0bk4yUDdSWkdwdXVaVHhLWkhpSkdUekwwQ2dJ?=
 =?utf-8?B?VE5YSGNXTWVzeXI2b1pHZ1dydnZIL3FjSFNIRGhQcEtGdTQ1NTBUdVZ1MmtO?=
 =?utf-8?B?WnFRalc1UEFjc1JWZlR3SlRrdmVqbU9IZ1FmMVZnMXY1bTcxQUxSZ1RySGN6?=
 =?utf-8?B?U3dWRnYzbDJNWk44K2ovbXpGZDBnUHRteCtRRFgwOVdCVTlWQi9PdXYrOXVJ?=
 =?utf-8?B?M2p0ZUIyQytkSGtNY3V3aUI0SGIveVhDMHY0NHBndjBWSXdXMTdmaXJrTTA4?=
 =?utf-8?B?QnJUTWhyUzBwQlFldW1PVDZ4VUdNaFBlVitWU1hteDE1SWFtWFMzR3VxS3JQ?=
 =?utf-8?B?VTR4TTkwaHpZNXRnR1VscC82TStZSWUreVFweVAwd3F0LzJ6RXdkSSswK2dr?=
 =?utf-8?B?MmR6cW9Oa3hPVWg2SWpyRm5IT3lpOU56K01zWGZneEsyYWNOZTRvUTNlK3Qx?=
 =?utf-8?B?OVZEZjBxQXorTG4vek9pUDdBaEJ4K2swdkY1ODJ2VW00L256UVJ3NFd5dTRv?=
 =?utf-8?B?dG9iU216WFlhREErVEtkUEQrZ1BodGQ1Nll0WjdMSlpmN2FwRnFjUmVhV0VB?=
 =?utf-8?B?QXpoR2g2a2dQMU9pRnNULzI0S2NSTHhWRU0ya2lwTEZoM0ZEZ2xXdW5mRE5s?=
 =?utf-8?B?L2V0L3B2TUQzMW9sbGtyTWpJMXZiVkE3OWRONTc4QUYxT0pIZmQwbFVDa01N?=
 =?utf-8?B?c0tnWlVQVmx1cFN3V0RvUk9vUlhxRS9kWFV3NzBwRkROdHZQNnVhK0QyMnhZ?=
 =?utf-8?B?NkdIeTlTZ2d6MzNuTW4rckYzay9MMExJdi9uaTUyZFJJbk5ETVZsaUp5NVND?=
 =?utf-8?B?OG9pMlBRWWZJTW9IR0JLQVdIWjd5a3ROU2l5MHBvbnVKelhGZ3FSWmgwSmJj?=
 =?utf-8?B?c0twb1Y4UEdKRGlMZ2hvNHBmRUFWWWNvTk1acjEwcmN5TE5wQVRFejBNSjk4?=
 =?utf-8?B?dXVEd0VOdHErN05pck8weThaMGc4S1ZvVHZ0aVpzME5rUHM5ODhKOGdDdDZz?=
 =?utf-8?B?VEt4NEk4Y2FyTG5zNjJuV08yQ0dxZDdvWnVCNzNnWW8xRmczcTlCalRBZnNS?=
 =?utf-8?B?c1V3Nk11dnRjUitpQlFjeXZPcjJoMkI0QXRWR1Q4VGZZTXhwOHFzcm9rclor?=
 =?utf-8?B?N0RPbkEzenMwZU5ERzVoT3U1QURwV3hDeGYzYmFNYWlBK1dkdEJ6OTdzS2kx?=
 =?utf-8?B?ZmRaL1lDbk5XY1p5UkcxWnVGdG83VnM0M0FBQjJXdlF6THlBWklvendpd0FN?=
 =?utf-8?Q?e1c4Dzr9keNlvnI+tP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f6124b-6de1-4098-efbb-08de89bf0133
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:04:18.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9giczwjyHVcsdKeWcZJXceoIDi0yfMpQgP1uPkRvt2n8jCwe87yZ4ZvohuCL5UWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
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

On 3/23/26 13:41, Julian Braha wrote:
> The DRM_TTM_KUNIT_TEST config option should default
> to KUNIT_ALL_TESTS so that if all tests are enabled then
> it is included, but currently the 'default KUNIT_ALL_TESTS'
> statement is shadowed by an unconditional 'default n',
> meaning that this second default statement is currently dead code.
> 
> This dead code was found by kconfirm, a static analysis
> tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed and pushed to drm-misc-next.

Thanks,
Christian.

> ---
> v2: removed fixes tag
> ---
>  drivers/gpu/drm/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 05dc43c0b8c5..75c186f938b0 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -86,7 +86,6 @@ config DRM_KUNIT_TEST
> 
>  config DRM_TTM_KUNIT_TEST
>         tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
> -       default n
>         depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
>         select DRM_TTM
>         select DRM_BUDDY
> --
> 2.51.2
> 

