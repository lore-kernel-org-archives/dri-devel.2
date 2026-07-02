Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B98C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0981C10F198;
	Thu,  2 Jul 2026 07:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BzNqgOiW";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CC810F198
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pELJe5u1ntYXG9ct6MNV+xPjpticYVHvY8yHcal1Yf2iLmOWngSIudREGKM9H8zJt8ro52NPFEd2hIMoBn7wopUle3C3ULac6KsSeo6EWgl14FXouiw8s9dEvMT7oKYlWrwFLsHgo+H5EytS+WkOVsoxh5KltlGZ429uIsVSZQyyXisnCbYiqBzpHxdeZ9PP7DkqnI7K/Lxx6WpugGE4vnbbQAgoUSKDIxonKVCIMPBKSTOkYQLK2rjbkvnEQ4NMiQxKIsmC5xBiZMR0wOCIQJpMqlpLTbYyYZcr5XU35DyZYF2QTOdkyAJrQjDBr7SMnWRfPEbgyrTL/CkqUSRUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6B91nlpWq+aahSMBvbBd/jW0rguaHNKoBiXmnS4w/E=;
 b=OBU/gFI6q8ob1u/5BKOAH7mXLlfTnqOFW7T4MvT8lJSXHePK3KLmIWlqrboHfDaSpzynGmvgg3X4Ycr75HPNXoW5VXW5m+i4wrx8XTO4oHu8lzzc5/0eY3QKahTbA7OTAc+z4w+UR+R6RT0sUGmuGVUXjWZ3gWi99pvNDK+279fSv32z9MJjYqubb6RbMgMU8qmCPgMYxdPdBjOeoJT2q3AJRiqmfJ2dWchO7Eg7Rdv0Mtxpf8MwWPtQJ3KiwiO3YJkO19uw5XDydU9RkNP49DhwrlVuWQ97SaJbgz8X+aNpWrcG1JFfU1OEVVjSiftKVdq63PkwTSrRbmPKJTPQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6B91nlpWq+aahSMBvbBd/jW0rguaHNKoBiXmnS4w/E=;
 b=BzNqgOiWCx811fQxVkzPFlXzfQDtc+n+7drEK2FjOnEcrHWYooRlkB4s6hEiOCPkyuH0LCbqAkPArp+LdHVX3MZXCTyRK+RCYBogMin8Zbye8h9EDYPv2xqeOzjKD098NXVEuqaqOee9kKphPXUNcCz60XCrmCMOCfmYc4a2FSchwTDYV1lwDLHVlDahgIuJcFQPaOmGCvnNQonILat7ShgAj/hDs9JfW7Q68y380PeYOpT8hL8n+anMtCexCItpu4yrvp2qCy08oLiUY93Rm1Z5ZyAIOYAURjxXvd1ZF3YA6rABwhSk+yU8WmIxJqtQX+DaLKIwHTOEfunlj4s3mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 07:29:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:29:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 16:29:34 +0900
Message-Id: <DJNWQA2PE5I7.TCF08DZTLSLV@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 19/19] drm: nova: Use drm::Device<Registered> to
 access the parent bus device
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-20-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-20-dakr@kernel.org>
X-ClientProxiedBy: OS3P286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1e48bb-f6c2-4a60-4bd1-08ded80bacba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10070799003|11063799006|22082099003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: qlVpbG2NSW600nbEKbnLJ/IxS7ZZKJ9NkM/rcR9caSDN0dl8OG3O65/hcFYXUf3CDe3zCM/PDhxyKEcVsbQcgLNAAl62f6bswLPWwM/t0Toz3inEudbbG3Luve2iQIE8x+RxsjPKHi7cIqUOO6ZYZHOmjWBH2UjUlrO9wJeIShWgFj9z6Abv62NyTrDM7FTDr48FVLiUo9g1Oa9jzsXA3ZZA7CLoFrUiD6FcOfvlcEsnK3KRnUx+LVf/XJOON64OrIM0ZuEx6yKgbptcLkuZ1JOq25NxdwV7fv1sY7UbA9Cicp9RsM6Dk2l7M01xOFBaQodLFrulJemXvECUZUny+KmEwnX7ZzBefJAXbXIlsUhQePVcdFJX+a3n5givIyefh4WLasFcnTOPg+euHMcJoYkCbIiMoQh38jaY2MYr/9E7bLB3iZPJcYh6O1lDdj4YME4L5H5ln09sxPEVeparSZoHSOo6YFO3jrA6z62rsAJv68LvWzp3kVITdVE1nXhTHm95zd4vIsTjNCcolL/XFFd+5LrC4wTZCC2yB85ZAyWpJAFBmtLFx3hiiTgEIJgffxtcNoxyIjJ7NNlTaVD7HUQr/ulhBHIvL49gxU+3nSOnAkssCVlabZQ+yHmoGCYF6XJaTE+rO/sjE3s6RkFotcXY58BKd6Zm8cWuLoWf+ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10070799003)(11063799006)(22082099003)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlrMXZEVThYL3RKKzdpNStWdS8vYnNTRnhyeWFHYk5xdWVSdm1LZ1RKWFVr?=
 =?utf-8?B?VjhuWTZibTdaTzkzOG9QQlZReko1WnArWnVrMnFqdE9HdFBBdUdqQ1VCUFJj?=
 =?utf-8?B?NStDRFpkY0ZaLzEyaFU0Vk85NUJ2UkkwVXdiZThXSjJBTW5CeUdiVFhrakVq?=
 =?utf-8?B?N1hKaDAwM2psMHdCbGVyTGZwZmh0OEx0dDl6TDFmL2ozdjBnZS9Ua0VwK0x6?=
 =?utf-8?B?U2MxemZnK0pnMmpreDEzK1NnU2c3VVlEczhaRFBoUG1MUDNENFJjaDFYWjdO?=
 =?utf-8?B?ckpUcGN1ZDdva3lIdUJzcGEzV3R3bEFSZE53bE1vZmJ3a2ZrLzQrV2NsZGhh?=
 =?utf-8?B?SFNDVTl2d08rOXMvM1NBQmprbG5EWWdjQjdsSEZBanRja1pwRTYwamwvVHVU?=
 =?utf-8?B?TkNPVTl5UkRZN2srR291cEVqUlorSHRRcG9kOTdPOXJoS2VPQURMV1I5MGNO?=
 =?utf-8?B?M251ZFp4TjhpVnlPci91M1FXdXExcnQ4Wm0yaDBTQzE5cWlqbjFyd1RhUDU4?=
 =?utf-8?B?ZWdGbFljSG54SDhSeHozbWp4SVJyc015TE81TUt5SWt0cHZkMkx6S0YxSXhk?=
 =?utf-8?B?V2dtaXNwVFkxc1ZmNGlHZnpBLzYyeWtlMEZVRFJmSkJpN092ZjJ1dGV6NlRK?=
 =?utf-8?B?eEN2a2cxcmI2SEZyREZPWDR2bE9WaTgxalNCdUVTWXdhMW9sbWdXQWNaeVNh?=
 =?utf-8?B?cUtIb2xQOHVWNUxIb0xGaHJZWjFROXVLdEphdjdsTVIrN3FBMVFoNGpqb0lX?=
 =?utf-8?B?YTlqcHo1WVBJMkRyVXdqTVVoZkRTQUhWVFV5dnYvNmpxeWhyLzgvMEN6NTRI?=
 =?utf-8?B?WUJETWRvckZ6Z1hZd1ZWd3NDa292QWlXREhidDJqRUd1SjBkMHhITXlQNkhY?=
 =?utf-8?B?UW9vTWo4WXNPVStSbnhXdzNYdjZLYWxqYWo1RGd1dHpFR3lqUzMySnJFRnR2?=
 =?utf-8?B?R05sbnFpeGI0cFhvczZOZzVVSUdDeVl3bDd0TmtVeVEzd3J3QTVpNHMzU2p6?=
 =?utf-8?B?MDBxTHZsK3NmcWJTOG1jUy9RYWppSXlvUWpCT0xkVEhTYVNpajZlcERBaysw?=
 =?utf-8?B?cTl3RVBpbDU3Z2pwZ01qRTFOTmM4WHArSXEyaFFxYmFmTm1iU1dkZkVzRmh0?=
 =?utf-8?B?ZUEwcGR2R2dHcE5BbTY4QUw2a3dMWDN1RythUHUyWFhTajJYaGZsL1ZHSTVk?=
 =?utf-8?B?NkhCSTNVbThuRkdubS8yeVdiRkh1ODRSQ3RwTFZLaUl5R1V5bitkaVJhOXlO?=
 =?utf-8?B?bE81cHRUYTlMZjV6SmMvbExXRGYxZlhNL0NNR0VhZ1pRcUJITDZKSFZIbGVy?=
 =?utf-8?B?V0Y4QThEYk5vaFl0OVFYYW5uRVpscG50SjdiK21jTXZrc3FLNEQvYUZEZW4y?=
 =?utf-8?B?TnBHRVIwNXFQRjFuc3lldXdKbnpFaVVYUTVGYmF3bW5Pc0R5dDFNdDhVdDVL?=
 =?utf-8?B?RzY0WFMwZXRWUXhHUzBxV0RocW5TU2NJcDl6UWVSZ2Rzb1NPcUZ4NnJIM2FE?=
 =?utf-8?B?TDIrNjVnaTY3UEFuUW12a01zYXdrc3RoY2pka24wQVpORmZCbTdGR1h1WElx?=
 =?utf-8?B?Ly9sempRZzYwSXB0cXowMzl0aXNUa3lscDIyR0VvMFF2NEVsdEtHQ2NINzRR?=
 =?utf-8?B?RmE4M3c4Ni9jWGtHT0REcy80dG0yK3lWeEg1TUpYWUNnNEduUGpUcDJvd1Fy?=
 =?utf-8?B?SjNjaXFzVWJsQmRoMHEvQWFFaTc3anl2K25EREhXTXN6MWZHbTNoSlA5V0R6?=
 =?utf-8?B?akwwa1pqT25NSDFuWVhDb2N1d0JpaTNwZ0gyMm44L1RVYXBnNXQ4SnNhcVY1?=
 =?utf-8?B?SzJEUTVsUGFTWHBuYU1WMHRpTzZXNmREOWhaTWY1WFRCRXJMMDBENjByUXFz?=
 =?utf-8?B?cjV0c1BqeUNvemp5SkV5Um5hOExPeHV1UURvb3pqUUlLeUE0Qms4SUlXK2dF?=
 =?utf-8?B?RnhQSHkraGNnaUpHWU5ERGVxdzRMRmJqY2I5QWR5a2dwRDJ1NXlqY2NxUDcz?=
 =?utf-8?B?ZWoxVytoZ0pHbnoxbW5uUGM0RHg3S1VHcXBjNklrcTc5SnlVQXJwaW9WclY5?=
 =?utf-8?B?TjVqeGZad0dlcW5jamNtbVdiMjI2VUhzZDRzc0krZ3g1Y09QU1EvYXExTGxE?=
 =?utf-8?B?cHBkQkZGUGVzRnF5WmhQdU9WSnpPeEczamdkcUZacG5sdGtPb2Vkc0hJWFhO?=
 =?utf-8?B?QUNmVVlCUi9jQ3Q4UVVtYTQwb0k1MnM1dk5tOC9jRDZVeXRSOTQyMUE1R0Rx?=
 =?utf-8?B?THBab2w2SVJpSkZjdGdyR2ZTQUJFL0Y2czYyQ2twVHRLNWlFR253c0hka0dP?=
 =?utf-8?B?S0Z5WEM0ZXFhZlVLcVkvUXAvTldqSld4SzBlSWpmVE11a2J5d0ZPdS9yTnhi?=
 =?utf-8?Q?ycL1EuyVIxpdK//W82PiC8nPk6/BcAlqC1sGlDLm7SLM8?=
X-MS-Exchange-AntiSpam-MessageData-1: +vmBJ991FQip6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e48bb-f6c2-4a60-4bd1-08ded80bacba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:29:38.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMb2E3qQC4w/cMLomaqrdrrXmqSLrDNTLi5UJ08U4PIN7GfTp38/VDJXnoL5UNqd/t4KRo4K/ygRuz3TaiB5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> The get_param ioctl needs access to the parent auxiliary device. Since
> ioctl handlers run inside a RegistrationGuard, accept
> &NovaDevice<Registered> to obtain &auxiliary::Device<Bound> via as_ref()
> directly. This removes the need for drm::Device data, hence set it to
> ().
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs | 11 ++---------
>  drivers/gpu/drm/nova/file.rs   |  7 ++++---
>  2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index bd2a55405db8..739690bc2db5 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -29,11 +29,6 @@ pub(crate) struct Nova<'bound> {
>  /// Convienence type alias for the DRM device type for this driver
>  pub(crate) type NovaDevice<Ctx =3D drm::Normal> =3D drm::Device<NovaDriv=
er, Ctx>;
> =20
> -#[pin_data]
> -pub(crate) struct NovaData {
> -    pub(crate) adev: ARef<auxiliary::Device>,
> -}

Went through all of this series to see that! :)

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
