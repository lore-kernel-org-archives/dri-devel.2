Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1660C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67B610F0AA;
	Wed,  2 Sep 2026 08:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEz5Bo4U";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4660410F0AA;
 Wed,  2 Sep 2026 08:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV4lqgph84HnOdbXTyKcfwkT8HWXVg8uVw1JrGeYd531zG69kVJcZi+6t1gsr303uBqlbxoU28vA0Do4nQQWE5HREYICTOI7KCvnnJH1H+DDqepdVigV6B9ju1poi2/Ke4iF/1e+0GUhdmS1zB7FQTBpyh9SCUtKnDqCtQPgfU9FVwr0C0LsC/AyfpPuswexOQr3Rk+Y8Aa61spyJYECEQXWVdAvaorX/BFF6lfcrq3MOTMS08t/DJ8RsUvJT/R5MjxxbrLb+aSQhtW+bDozJG7WofEtrl/9zrjE6SVcOHEhjdNhA68cAR0dyWx6ej1WTYfqTeYUg+GjQMSubsC9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnfwFOtJwvgOtSCtrXTY6wgEKJrIIdAbepjE9mbehKw=;
 b=xuw9CL26zvrg4YOLkES0WWGxL0Ng/AuexZWvSWFEraqJpjV4mkTlqpsduACuCE6Xyn5CV6Jgg4tGIqQbAiTFyUnKRUfTCVt81cARaTJCVZDoML4yeFxNvBUO0ajKsdxHjbcuMDIuaRKXsakBtzaS3bQA1IjwKcQTj9EkO7YMLutSwbb7hjcgw2uBOthfGI9fE8vxWiL6G/f9agJoWjALAbRQi66lmlWCWar/c6bfifdrzAdGA+B+6jU0oVZH5pWGFd5EEh1s6KG4NxDNyZRcA6Ncq6xdJqVmzocH5I/OumGR1PjCKm/tgnp195o5662nsxkKZ3CBl9RRgAKvoGvHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnfwFOtJwvgOtSCtrXTY6wgEKJrIIdAbepjE9mbehKw=;
 b=cEz5Bo4UxbDqCHV5/EWyMnz9sFWhn7DJsjk1omOuDQVuuaA95Xy8BYY51Ve+BYw2uM/c8ykvJhNG6FAuq9UzQxQQDkbyiDdwrM+5oeGqbog3nM3R7YD+clm9j0v2XgskIIVCQZj2nizkTTDMnYBEfsMPicoVKRL+wsio59bGUlYBC8tY7+6lvZb6W4AGtXaxIFZNQd3MHN+/M85ojwMHggL9wIhXRqahqWLQedCJU9SLWQWdT9WSsPtVKyg2UrFLD8Ru6/JFUIF0cpUB4GcS+8OLS4IVpZtBPBYXtzDhKInsN3PuS+CItLHDKOZrE0su7pMUsdG3ciE1RLZnO+pRNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:35:08 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:35:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 17:35:04 +0900
Message-Id: <DL4OY7H72UXD.2FWYTKH2SSZ5I@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] gpu: nova-core: use cv! for constant casts
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
 <20260901-cv-v2-3-446bc69d2ade@nvidia.com>
 <DL3YIG34IP1Y.1G32YQU0JYUTE@garyguo.net>
In-Reply-To: <DL3YIG34IP1Y.1G32YQU0JYUTE@garyguo.net>
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cf5056-89d8-45e3-16c7-08df08cd185a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|10070799003|366016|4143699003|921020|10067099003|11063799006|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: cBJuCQlzRhRaoaSIkfDTB1LCWnfLGwq53EuSFpdzFVebel6nU8t6kyWW10xnlohxvo/zVDr8StyaVW9MXlvanwfp4nOE+IL/tnk0TcZ7OhBo6MOeAGwQLnhUzVtCaZSwrZmHEhpg5aiAiv+iBJ6h/b+TTOC31/4Li2SUoPjGtaWHGY25Ww+aMaVxdTWAxqmRsmX0+6vZntnAUnheYiYIPOlLpGW+laAXjKDIGuvFAC6B04flFOJ/mitxxkmEM2JkY7GQnLeu68xnp/+RAJuTjZD35ePTGFRX9OuLPfoQtxNi/5685y67pjfFdfH4O47pfztWom8SIbQP9iXnc2YIXOQmDdkec2hq7R9D3WHexjlpswytmmQhpZrqr+2A1wFxaILdktszYatbNbI9+iW6TmviVtdwmQASilZcCU4swbJdHkmRpEfdCBRWhe82XPpFAqhU9r/eI+B0HZqPdgg0l7u00Y/vYqxOtpDvuMfk9HMkq4+UgLkel/+xy4+A+lMmPcjcAyNWySFQDMAkr5712JDd5+J9nH60O42T2xlVrUsshgm9IoDFZmCxlj7/Jb1FJgPPx7H36ZnibGR3l+Zop+JjOZwiw1sYQqi0ek0TfG6bvAE/J5fRUESFECNLB2GxPHBfcO0avWLleunFb+Zy+LW6bGcQWAhMnjfRIOGuJOAqJ2nYhr67t1AJGXPQfmk/MeCVvrnObbDHcUMaY+Fzmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(10070799003)(366016)(4143699003)(921020)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1FHR0ZRbGtzbHZhSGlydGtoNk9IYzR2czNUdGM0YXlYOG94WitjYUV3RVFH?=
 =?utf-8?B?YVE4SFJwOFhFVWFWZHE1L0syNHVLZDliOXk4RG9MQTRLVlkxbWdyVUJTdG1j?=
 =?utf-8?B?SHlZWGN6WEdENFFCQk1NZ2pRMm45RVd3ZXM4OVRqbUdub1dJdW82d2VPL1BN?=
 =?utf-8?B?VThRNFFQUU9iV2VpVG94WENNLzB1TENJUk1Sck9mdVN6WlRPWG9GSG9XeWU4?=
 =?utf-8?B?K085VWF6R2JadGNqVk41QkQyZWFuNmZQczhzcS9TY0FYaVI1LzVrSEdtRk80?=
 =?utf-8?B?LzBBMm9jdXEvVFFuNlo2ZEorWUtJS2RsY0RHOWlBRDRTTkdwNjJHR1JiVjZw?=
 =?utf-8?B?NlI4c2ZZZXdqa0lEc1VnaWQvRWVCVDV6QnJpTjVhb0hxdTlqWEhUbkxueW50?=
 =?utf-8?B?QUx6RUkwcUkzQitjMXRjZGwva0VaNDFiTEkxTVRjWnlDRU1pVnowVVNiUHV5?=
 =?utf-8?B?bnN4cTFDcGQyQ2NzaUdvUkdyVnFheGdYcFFHMFMxaWZMNE5YU3lKQktDTnFl?=
 =?utf-8?B?L0tIbjZ6bEpWRTN1WWwvcXVyUUFQUjJJOHVhTHY3dXgxYWpCWUFheElBZkZw?=
 =?utf-8?B?aHBnS0JxVUhhUXJGRHJiWklpckU5Zzh3VU1ldS9YNU83eE8rdzQrYkN2ZllH?=
 =?utf-8?B?M05jNzAxeXVHS2llUHVkRC9sczNHZkU5WTc4WlorTmNYYWU4eE9xaTg3aFI4?=
 =?utf-8?B?TGJQMG9IejAzakhaY3ZJZWlybVgrVEdqWmFxWHB4T3VKQ2VtTEJFK2hZQlNj?=
 =?utf-8?B?QnVkZkpaMlZndEJrdlFKWjYyakxsUTdTU2pxK2luUTN1WHFHdlRDMTJQZFhY?=
 =?utf-8?B?KzExUGlTcm5qaHpFK0dlZ08ySllWb0FaLytNQ3RUKy9FM3UvL1VBMVcvV3p1?=
 =?utf-8?B?TGdOSjZyS0l5dThaWENRbEVnUGZVZVVKczVpT3FtYkpwNWFwSERvSy9HTXhk?=
 =?utf-8?B?cnMrcjI4anptN3lrZkxtK2tHRkxSbVJZcWRXSVVXRFF6am1WSkhPaFNlbmV1?=
 =?utf-8?B?NG5Sb2w4aGFIRHAxV2xwWlNVSVI4cVlMWUU4aURoYmtFVjl0RmVtSTJqMmZC?=
 =?utf-8?B?b3FES2xMUFJWRjRFQWpZTGtwV3RLYkVVUDFCMjRpbER1emZzK1lZM3hsc3da?=
 =?utf-8?B?U1dwZXBNNGR2ZVVUL2lyTE9FK2cwa1JBMGJKWG0zU0c4S3JSczgrQWVIb3NY?=
 =?utf-8?B?QVNXZjhLRldocVFwaWJESTl6OUxtL1BLNlRTNzZWdGNWVWdBdjNUdGNRS0NS?=
 =?utf-8?B?c3BHWEhqbGlPb0NOVDE5Z3Q2b2F5TTZOLy9YazcwakFFZCsxTWhTZytWTzFQ?=
 =?utf-8?B?Rnk1cUN2TG00TlRrcTgzOHVSYTN4b2pWTDArTlVOaG9FMHMvb0p4ajJzRlda?=
 =?utf-8?B?WVN1c0tKQ1IwMjZPL3hsMEtITlpJTWx3RGZUbXBxSlhsVlZNd3hoQk9YNERj?=
 =?utf-8?B?QytJTnZ0cVVISjRGK01tNklQa24zdjZxOXU2a093NUF5K2FrSDJZSCs4UU8v?=
 =?utf-8?B?VWdwSGZjTk42a0JkbWdzSnN3WG96VWd1bzJ4Nlp4Wm1LNzdkenlzUGNhTndU?=
 =?utf-8?B?bitzK3Zwb3ExcE9NSk1vWTBLNkgxMmlFT1ZsUkd3SFhmczNTbDdUejVrMWht?=
 =?utf-8?B?Qkc3aWUwWlE0NnF6QWs1WC9FSDM3bVR1LytoUFpjRkRUV0gzcnE2QlppTVRo?=
 =?utf-8?B?MTVCTG02bmxJNjZvcno5VXlCV1ZMdVdrU2JUK3plV3lsYmpsS3RHVkFReHV6?=
 =?utf-8?B?bzlOZ1ZjYlFLWjJESldQOTZ0c0E4MDlQVFgzcjNmZHVvSFJ4dWtPL0lEUzFi?=
 =?utf-8?B?VDVDU0JWNDVld0FFdUZXLzlMRVB5MG5HNGNvYjU0MFJ3ckVFWGsrY0FVbk9K?=
 =?utf-8?B?OXdpWHMzT3QwbXVxeTNPaFFmajRMOUh6MEpOVUM0T2R0UVNhV3Bsdk9aYlM1?=
 =?utf-8?B?STdCQUdPNXZrUVBpQkZqSE5OeTdaUTNSN1JwOE1NVEpNTnAwd3p4bGsrRGg1?=
 =?utf-8?B?M25YOWJObkk3ekZjNnpucmVzc1hjS3Y2NVc0K1dOQmE4eFd4dUUxS1N0WXFa?=
 =?utf-8?B?K1ludzcwc3pGWTB3VE8wN0F0a015dU1uNE9QUlhCbHdJNzh5dHIvOGl6RzZK?=
 =?utf-8?B?TzBTazR1VURPd0R6L2tqc0k3ZEdrVExVdmZxdmo5Vmg4TUh6VmFIdndTT0RE?=
 =?utf-8?B?T0hEUHB2Q1BpcmUrcTJXMTJTeFRaMVhZUUhKTVVKWjZobkFyL0xPWllFOUpX?=
 =?utf-8?B?SVR3QTVhbWRnS004M1Fmb0RGaE4ydzEva3hhWnFYU2krK1psVTN1dHI0TXRT?=
 =?utf-8?B?UlFQclpXK1gxd1dMT3ZEbkQrUzJOTUtTL1Y2L3hBK2l4aGhxVTVaMWFMN3RR?=
 =?utf-8?Q?N9ZuyXmN7ldwg2ghSoBZFz888LQ/dGd5rNt47p577y5y5?=
X-MS-Exchange-AntiSpam-MessageData-1: 5S+OLAwhs3K2jg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf5056-89d8-45e3-16c7-08df08cd185a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:35:08.1261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AEDKDvYzb0IrmcqruFWk/om1PkcA+qBwo1S4uMiYf0faqa6Qdr4OhnnDRYIyvf//uhuej4ZceuUPC6T1wO5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

On Tue Sep 1, 2026 at 8:52 PM JST, Gary Guo wrote:
> On Tue Sep 1, 2026 at 6:06 AM BST, Eliot Courtney wrote:
>> The new `cv!` macro allows safe casting of constant expressions in a
>> const context. Update code in nova-core to use it.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> I like the ergnomics improvement :)
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
>> ---
>>  drivers/gpu/nova-core/falcon.rs                    |  9 ++--
>>  drivers/gpu/nova-core/fb/hal/gb100.rs              |  4 +-
>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 +--
>>  drivers/gpu/nova-core/fsp.rs                       |  3 +-
>>  drivers/gpu/nova-core/gsp/cmdq.rs                  |  6 +--
>>  drivers/gpu/nova-core/gsp/fw.rs                    | 38 +++++++--------
>>  drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
>>  drivers/gpu/nova-core/num.rs                       | 55 +--------------=
-------
>>  8 files changed, 28 insertions(+), 96 deletions(-)

Thanks for the reviews!
