Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F970CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6C10E7CF;
	Wed, 27 May 2026 13:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="WdFV/iGV";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7231E10E7CF
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQlXoayCSbk7hS7IAE8w1xSCRrwBVXqJE9/0v0xodtdp/IqISVdCT7sS25WCKRRKxKfQsIkTEnJmI3wxsvo35btOj2IzkE2J9Lh1Nct28aoCSGxSccssh2ktvLaAWdDKo5uTYXZJZwr5+c5EyrMiGZ8PQm+gr4vU5UfxDttqzIM7NGJ6dej1Fo/GXQfr/qXNhgYUfYZPTgSQh5MbCCppf+IUA28SrA3RkicWiNiVEZ2tbgzjbMDpnB8gr9dL6M5CGUJuD8SlE9i4//zIQwpouHp74M3b3SKxxqmnwKnPpoM/HmH3Mkk3KAQwxwTBtXJb28wuxaZUT3j0usDhiSHuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7O788utEkviJE3TfbuHTI6ic9ba/25URnP4Euhfk4M=;
 b=YPBzkopEh2kSm5YpnENCfntEPrDkf6UrjpWOcp/XBxz6CDJkps1QkovZmA9CTZ7AIkULciE1Faj+4/SwsNA55ca16NlcrQJXh+L7Sr6Xm2ugfgyj7D4MJ3efi0pZWPHP+iNrlEeZXZPKpEjo/ZRe/BI//svKOPrdzHjcgJ3Em/apBluSx1Uxv/ULyrMxYkowsSHWc7AfRqwMw90NEG7uhHcA5eXoaoUhFip/8ZonXc/vMXHsFNz9NQrE9mTQH4h/gOZvThYzsX3ZcWs6LbwOFXXIz4tlwGm1Nwk8Oy70ZCA3zmnSEJwFePh/myJ+WddFUadCndcq7ly/uX4I9TS/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7O788utEkviJE3TfbuHTI6ic9ba/25URnP4Euhfk4M=;
 b=WdFV/iGVYXMU3Cr4I/mw9laJyqYBPPed7sYbuoZSAM5lWzEn/VKoqc2HXd+I8f23fdZRZcfOj7x4Zbzsc2t8tYY7iXlKKh8ZorzJZ8MSNPOyuVifJSzOmT+8eOGE3wJ7duStGXrAt7bl6dv24Ggwz6oXnQeMwLgL+L/DrI/EKFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8539.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:21:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:21:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:21:50 +0100
Message-Id: <DITHODOO34QL.3DGCQYFZ1GRAU@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 12/24] rust: pci: make Driver trait
 lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-13-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-13-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 75782c1c-44d6-4d8d-3ed7-08debbf2e976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|4143699003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: tV9b08uJtO+MeFdWt4ChaaFAlJn2InSNCD6SpqOQ2iGsDugVZy2HUf0s9zxAx3qwkPLnm0+qfkakxVFYKDXUFmTpXpz/0LFl9MRAYMQTXazBP5D21SZAXKYP5JuZkwL+wnOoJwN9hPzB4DXG3BvXKCImT3skwNah5HnDaXzbIFd07bl+olWa8RBbWBykj+R59Lt/SSAHbzWJOsE/OZ3XxQGEoo9XZ5kByZyI489QJOs847/T+uMj7IEAUFC+ZmRO+5KQncQqS9DzO4Xrr2K7j8yrKQA7zdvLctN7W3zTy/6XBpcAwCwelpues+ESWQnpqmg+0f7dqoq4uGTisytvAXwGqAuj2H6mJiCV9Mv7hGcDwe8Z02LmL4DE4U3/+kTipHghzcGXtgAhyD3lBUIVGZq3tyVb62UT1tmbnOku7XxlobaOgUDdQp3zKH+GZ8mQSX9TZqviDXVCiEEe4Cv+xK1lQJwpc3jfRLGoVOWK9YXPuGHw6zbtQknj0eMV4pmRqsPMemEhRn4MwA7CtIMEpYl9NwMwS6RRjLExzmefByq1Z4DJZNGMr7TrZ0tZuN9p2ZgM/cycAa1DXx+D1/0e/xskFNFJWxaLthaILRasR455BOk/sr7fh1+INOYBcK+PLqby++eyGHtuXQHBpbLoJXX0sqJuk8CogYoe3B9a7l2xIFjJXvEVCchcXYUZ7FMUPUu4Cei1rzyvJwLGcWNRzZAyfkSfZ1q8lLZtvxYbapE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(4143699003)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0k4d2s5bXdxbERyei9aYlJRMlFNV0VveVhiNTV6V1IvQ3k0V1lPNDZseC9W?=
 =?utf-8?B?d2NxNlV5MFlXb1VKOGNxY1c0bldNWnhxU3N1YzhBaTRWNVYzdUZ2a2VOek14?=
 =?utf-8?B?UTQ5bllOTkVGNkUwUnVVOVhFL1h4U2NyamxveDY5QXlDdkpsTVRrbnBNZ0RG?=
 =?utf-8?B?VEx2UkZzaVZTVzRRSjRYUkFCOHRLKy9JZnV1ODJjZjlVV0tmY2pmbXg0WVRZ?=
 =?utf-8?B?eWlmUGExblpQMzYvY0FQRDI3aHZUbTFSdnJkK2M1QXFXYXNTYnpnb1RtS0Zq?=
 =?utf-8?B?Nm5HY0VNU3VlT00wSmRtRU5EWFNXSXVpWmcvLzg1VWViN3lkbExpWGMvRVBO?=
 =?utf-8?B?WjFOZFloNGxVbWRCK1RCVDlBYktHQ2lSeXJkMUNKTnEraG1LcUtzQVNSZEYr?=
 =?utf-8?B?c1o5azI4NGJ4Z1E5cndXK1FvZVhyVGNFWGQ4QVBSUE5lUVc5QlRyNkVwbUdK?=
 =?utf-8?B?c1RyZEdzclkveDJncjVjVWZGQUYvQjlpTlRoL2NESG1FVTMxOVBEWCtnS2xr?=
 =?utf-8?B?b1VjMWlEMythZjd6ZmgvSHltSHYwbXNrZGRkUjZVekhJQ2ZwS3RPbTBSSmdT?=
 =?utf-8?B?VEhuczd6U1oxV3ZHRTBjWUJia1hNUXYwcm9mN3E3UmIvRXU1RUU1MnRLTTlG?=
 =?utf-8?B?N21QZGdaREw0Q2QzblNsUCtlRStyeWRuUjlQZVpqMUlOanluck1oTStTTFVn?=
 =?utf-8?B?MkVPVEo0M1JjQ3Q4bGg3bkZoWmV4NXNCbHlEZHZsS2NRTFIyUTQ3elRQbXhq?=
 =?utf-8?B?Q1JMbDRsMVlXM3JobFlCT2VTeDFXaVUrQ0ZGZG54ZEViMGdDanRHWm9oZUtV?=
 =?utf-8?B?VEVyWDRyN3J6YTBQTllxYmd5ZzdPaFFpR3dXZzBIK3lLUnFxdGdtYWgwSHVZ?=
 =?utf-8?B?OXFpeloyYmVsUEtWSS9UR0xQSkFaSXpvMm5ON0NyaWlsWWZXUy92Sy9pUXVw?=
 =?utf-8?B?ZUgrYmJ4aGhTdVpiV2ZycjIyK2ljcHlpUmI3bkFZb3JOVHdiT01pdjFyZi8r?=
 =?utf-8?B?NzE0NCtQTituQlVkMVhVMkNXVzRwazhNd0V4MkVpVUhGdjdpcG0xSmdFaUs3?=
 =?utf-8?B?cHNRSDlXd1Q1Q0Vrdk9UMG9XeHQ3WFpiWXVLSWRxVWJ2Z2cyWGlzY3J6V2xt?=
 =?utf-8?B?REtQbjNnMURYSHh2bTUvRnE0MEdjQmp0UklQQTNLRHFQWjVkOEdpSU9yU0ZJ?=
 =?utf-8?B?KzFoT3Y2Yk56eE4xaDJXR1EwWHRlQkF3MjFzZVNyM0R3MWRxMzJYWHZtczdz?=
 =?utf-8?B?WWpRM2FwekNPV01LWVFBTTVFMHRDOUxRZk1SNERDTVhmSjdTUVhXcTQxMmt6?=
 =?utf-8?B?ajErZkZFZUZBMk9BQ25HU3pFUzJILzNCWE9zbi80ZGd0L3I4b2w0b2JnMFFG?=
 =?utf-8?B?OVp1YThGVmNjVkQ5SitRV09qK1VEYlNaa3lzdmJWV3B2U1RoOERBdlB6N0Jk?=
 =?utf-8?B?bC81eGNvSDNXSjdQTHV6Z2xZaGk3bmR1NFpleHArbkJka0p2L1NGeFRVMU5X?=
 =?utf-8?B?a21zNklGZG1EdllocCt1YXU5SE9RN0dXYjlVUnVRNUwzOWdoYVJJbVMvRVh4?=
 =?utf-8?B?Z2tQRE5XTmFzVm9iK2hyM09NNThWVVJWZGZuZEoveDlTdjloRzVVUjZrbkJ6?=
 =?utf-8?B?aU1RcVBLakxLQmNkS2I4UDh5RDFyRjRBQTk3dHFRenNNN1VDL0UwZHFqckFv?=
 =?utf-8?B?ZlVaWDIzY0lPeW41TU1SZFYrS09FQU43R3grdklYN3hydFgwdmFzWUFZVUI1?=
 =?utf-8?B?Q0NuQlVBdm14NmVDWDJEWEZPZ3IvcEdkV0hmWjF1T1FyY1JtOXVQWHZOZ2xN?=
 =?utf-8?B?aloyTWRDUm93c0IzMkNvQy95T3ZHS1YzRyt1OFVibis4KzhkNENMemVaSTRP?=
 =?utf-8?B?dHZCZEV0VjhZNVJzd242MXdWTGdEcVBqdHpITW42YlNCcGVVdzFUSFNtbGI3?=
 =?utf-8?B?Y0gxOG5uUWdxZHBkcTlNNWNQSzlOV1RJR0hrZDZwd053TzlCRE9qWmlrZm50?=
 =?utf-8?B?MlVERUFFU1orVmNBQmUwZk5rb0NiWGpKdGZrOElKUHB4N1l2N09ySUFLaXUz?=
 =?utf-8?B?cWRyZTNLYXZzbi82ZXkzbUVnK2phNWthbzAxbmRNTVpyY0FCa0Fwa3BlZExX?=
 =?utf-8?B?R1lNTzBLYjBzOFhjbVV3Ui9VUUZya3JqcEk2elFMNTJUOGFzRXZVbVdJa0Rm?=
 =?utf-8?B?SkVNSTVYdG0xZDRIYjNwQUFjZzBVTkVnNEh6d1FJb3ZjdlY2YVBiZ2swaVhr?=
 =?utf-8?B?SlJHVUVUamtlL0E4NWF6Vk51TWEzQURvcFVpOUVZZ0dVSWtNR1lad2F4OVJG?=
 =?utf-8?B?SWN1enhnbEZzSWtwbllaV3NmZWRLWHBzNUVGTVZaNnhEY2dZekJSUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 75782c1c-44d6-4d8d-3ed7-08debbf2e976
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:21:50.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aSCSDlL4MgcD9JIxufLZCq8Hl6aj4bkYXNSHy33vvbC4RwdrPg31FsfweSSL1W5CtV0iTEvINUu9PaA2uxnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8539
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

On Mon May 25, 2026 at 9:20 PM BST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>=20
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>=20
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/driver.rs       |  9 ++++++---
>  rust/kernel/pci.rs                    | 28 +++++++++++++--------------
>  samples/rust/rust_dma.rs              |  7 +++++--
>  samples/rust/rust_driver_auxiliary.rs |  7 +++++--
>  samples/rust/rust_driver_pci.rs       |  7 +++++--
>  5 files changed, 35 insertions(+), 23 deletions(-)

