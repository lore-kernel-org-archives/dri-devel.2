Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B686FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B477F10E4FF;
	Fri,  1 May 2026 06:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VejjGm0f";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D147B10E4FF
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xze/IrU1al0uxtDmvJYj1xqGg0JBeuh9v0PcGmMnyMgkh1BOYEK3RzTE/LXrp5ihRaGSKmpaH4nGE8Aa8K2XSYFr4VWmES47sJsVsYdC3HjxqXxXvvQeWMo1VchUx3q72Sg+IG+qBvT/WCrDnwXe+f//AhlmhO16l7+cFFl/pa9jITp80pql4AQJl6cbjFjaFil7WQgadXCbgX4+tO5Az4utEh8wr1HShyjLZf1lOD+yUsAXMJUMhoZ8ziSisT7IEKGpjhggmMNYLu8kAFneKGsi5gPAl6IDl5am/4x/IUGvFGiHqlaWoddhC1U78SZKg3j931EaIVr2x/vU8NsHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSZod6kFCtgQp5srK63dm8wIgwz12+HVNrLot9OLyTQ=;
 b=GrpN+smIodnzDqeIYjZEd0A6VMUpNhUj9WDq1AKJzPrNcxc7oTtmNUoiqMl7ni7AFg+sAbjUtJGVzjIb6Ydr+oEo5UlQXNMe2/I7QcSYV6jb+kpl2MlRPKu1C8mwnsGObpUoShtx6MXMsUbJxets+YsNEX9CYXrPC8aFANtvy2u7oA+Ysewe0Frblv0CfKB6bKGs9NjoNSv6eJ44MV+VZqFwTIKtL1TVTQYQKKCLTmK2zCyyjrj6xs2vlhcqaYlBVYVywXzL9eiLz1W2Lc5vIiN+mlTltr/9AHlPe9ON/EGSeK8zo6Xxs+3LIIn2iZwhG1LfLyZGpJQR24mzqjqLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZod6kFCtgQp5srK63dm8wIgwz12+HVNrLot9OLyTQ=;
 b=VejjGm0fzRqETlk0w6tsRhQ7fZufKvOPRr0EZFfNgjLZTTdEX4QcdelyDXwP0YW1q/DVd/b4yoxWr7CFg7Q8v4LdLupjBgF0Lb6y8Ei2aKcewUv3obOQ2pNJ4R8pzFVF2/MDRYs/5CvuXujmzEvCuiCsesyJTJUcPMpc39mAErj9sLy+6ef3tfazjFHrgDpwuzQ5v8o8Syb0QaPsgXgaFOsiMwsChQWi8VHakHYf/Tw7jnNQMsg/2whIBYASYbsPAPJfIVPyimck96IxipfSLbYMZVxGBf8XJn9lDMJs43MLwFBShaoF0qN+bAaNCQGpXsLBnY2MfRQtBueQ0Bc2rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 06:08:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 06:08:03 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:07:59 +0900
Message-Id: <DI7461FQ7S52.3CS33L8ZH9VH3@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] gpu: nova-core: switch to kernel bitfield macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-3-23ac400071cb@nvidia.com>
 <3bcc1806-396f-4fae-b88c-c79cc242cf03@nvidia.com>
In-Reply-To: <3bcc1806-396f-4fae-b88c-c79cc242cf03@nvidia.com>
X-ClientProxiedBy: TYCP301CA0075.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7cd3db-1ea2-4c6a-59c0-08dea74800f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: uqXmwqvTuWbDsSzMFcFOs1D1rjOF7vgM8A42sPyxhBUUxsrhnR3ZcBO6j7D1aj8cM44JsA1Iirovcon+wrDT35zRpK1q0I0C3Bm0Sx21vfb5Lw/vsL5MmUKOnJ/Sb6kqt1EeAbhDDLwOsWWlAit5ZzfR8ucE+4sxd54S9Asx1KR7PHvHOUsxgAas96sjVWjvuBrLoxk+kx4EBukomOmTinHxgPnTcbBQ4iDq4ReGFRkP3/F3DwKASEalU9BTVu7ji+vMSZx9uB+m/B9cTfxDGD1l3/b292B7hWJ5IZtjAbgezQX26oAYuU169Lultp8Oo3h2hGlkrrvlJyc75e9PR4uLXHJPbIycvVLk6tt7Ar/liI3ezdnLnwBzHSszLiffEWD4uczXQ7IgmLLer84/w/qdbTj9ZqYwCrkk3B+Y7bi6cgt+4u6sVecN7v9GGEHds2sW24d0K8oTbFR9bjKBv5Dl4Zp9KFLdOI9eAGDI24EMaFAlPxNS0U+57Zsm3R5Eb84NY+uzP3tvyVgQzCOYdNcjn7vQIK3f9fVf+/PU4YUucutxqI6gsvL8/Wl5oynMon0HOgJRmoDLjPC2rWebwYT+ddpflnoKZA12KFIPdrPFUwxQ4Z+xgAIZ087YLw4RfwwEcJ/QcfpNEL5VZqK1SOt+1fIoiMKvQWscD6KKETaJwdUzUKrBfywUH4zwdFwr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnFTME9BNEdDVk14Mk82SnZPYjFkd3pRT0dzbHM5aHVOSXFSckcyTTJoLzFv?=
 =?utf-8?B?VXVIMCtidnlPS1B3NXducnRyRkdzUFRMck96WUJnODFGNFlhNlRWcktsckZ4?=
 =?utf-8?B?ZmlkVVZycCtveWZ3R1dpeW5GOFF4UlBVNmw1c0I5ajEvUkVsUWxpczJBT3NG?=
 =?utf-8?B?eERHVlNVLzRqdGlCY0tzNnp0aFpiOE5BUDcwdkxaZFhxcllISDNWSXV6SDZ4?=
 =?utf-8?B?SEFLSWRzK2FoK0UrZnhoWEI3M08yL1I4ZGxlaWgxekhXdU5iTHJtMWxDMFQv?=
 =?utf-8?B?VllrR2trWGhPTGcvVkhaQklRaTFMTXZlT0FCRHZqdnJ1VE01SVp6MDIwTlRl?=
 =?utf-8?B?WTQvYUdXSXVsejRLSk03V2V1YzR2VHVPMG13dS9oemcxT0hLSTl6VGdQaDY3?=
 =?utf-8?B?UWZNYXVybzluYkhTTGllTkNac0h3eElPbjJlSUFxZlBGMjhGWHc0SnorQmp5?=
 =?utf-8?B?N1J3dnhENm9MT1FTTTloMjBublRya2JOM1JiT1E1UnZHMzR2MFRkOXBqNmZ0?=
 =?utf-8?B?eUNITEZhclIzZnZDb0cvdWRCS0p6eExNSW4yWW80bWZSdjRSUnUzK1liMDNT?=
 =?utf-8?B?ZE5pRnlYMUg2bzJKZHNvZ294dmgrNForcXFJUmVPS2ZYRTJOVVdid2hDN2Rq?=
 =?utf-8?B?clpUdVFPdVRzdEY5QmRsQzJ1aFpPVXZxelYrNDJrVjB5a1ErbTVnb1hUSmVs?=
 =?utf-8?B?QUhIQWNQbmVhWHQ3VnJvV1NsSFV1V0U3elVhNllwUitxNEQwODFvQjA4V2dE?=
 =?utf-8?B?aEYrK1UwM0ZtM2psL09NRGczclM0S2tjU0NrTFRZT0dKRmFkWmFka0oyVEUr?=
 =?utf-8?B?OFJmb1dyZi8xOWlkZysrSi9tTmJLck9ZNlQyVHdYb2ZZSndiWXZVcHlkcHlS?=
 =?utf-8?B?citHbE5vVTYrakRsaWlhTktaaUJKcFFmS0xoSTNxUzFyckRRejhzazF4NG1O?=
 =?utf-8?B?aTZOK3ZhTlNSaEE0SytGd3VCTmtKLy94OUl0SlowWGhEbjNla1g1V0h5V25I?=
 =?utf-8?B?ZERDa3VsM1NOQTE4TmZFTlhDZ3FQUkZwSUtZQ00wY1Y5OGs1NTdtWEhEY2VN?=
 =?utf-8?B?VDlXbndOVXFadWt2YVk0aGdqSVJRV2tCQ0xFdWErK1cvS0RVYjdFbFdDYXhY?=
 =?utf-8?B?bmJlS2l0c1p4STV6ZnFleDh5aTZJblJRV1FNdzFtbzhSZTVubTU5QXdsRkhU?=
 =?utf-8?B?citWY2w3M3V1eTIzeWNSeEVXTjVpeTNvSEZzNUFieWlPRW9lSnYxc01mY2po?=
 =?utf-8?B?dUZJRXhHb012S0QrNHM5eVBrZTFMOURmcWF6Qlc2bndhbHg5bXZudkZUM0xI?=
 =?utf-8?B?MTA4WDA1ZEtEejlWNDl0SnRMV1BreEJlQ245VGYzSzkzd3c2S0U1dndrN3Y3?=
 =?utf-8?B?cXk2bldNOFl0SFZWVW9IWTQxR0dwODJYYUxwbXJLNGVQR0UzbE56eE94SlJq?=
 =?utf-8?B?NUFCK3JNWHo4N01jM0I2YW50c3dBNDdaTmhoNDlHV1BndklwRXAwVi9zK2hE?=
 =?utf-8?B?dG5iZklYc1RPd3MxYkxLNkRVVnFYZjRBMUIrcmlrVStSeTNzSi9QaGFmRFd0?=
 =?utf-8?B?YnV0UDA1WUtQOElYSm5HOWxGUUp4OFBYcUdBalEyTmFaUVBGWHJRbDZoSUtO?=
 =?utf-8?B?OVppK0p1S3FidENqbEgxUWVDaG5SVmg0MVl4YzZmSTRGZDJoY0RVQzZramRI?=
 =?utf-8?B?SHBiK2xmTW9USVhmZGZYd1pldXMyaW9xdXR2UXhlMGdZSE9FNFJCTmh3TWZ2?=
 =?utf-8?B?Ujgwd29xNkwzZ0tsU3FoSHJhWmZnM3duTDVvVk5vbFZrZTFGZlVPdWVsa0lJ?=
 =?utf-8?B?UFBPMlRuS3c0SDNOTERDQ3QraTgwa20zWW03cmZsWG9vNVA5WGtsTVd3Y3N4?=
 =?utf-8?B?RTJPd2V5VE1wQTRncFNBMS91ajVYdk5XTVdsd0hUZkd0aXFuR0p3cWhoSHRk?=
 =?utf-8?B?UzN4U3JpMFF3VFhKMjFxU2RqVWtPdjBQalJHbmZBNnE1Qkp5Z2pzMjM3em0w?=
 =?utf-8?B?amgyaWVtSSt0QjNPcjVTVEdxaWw1cVhFZzRhMFhhSVVmUVdFTUtRVmk3clBI?=
 =?utf-8?B?RXlpdy9BbDEzQWlmWm0zVEpmMG16bWtZcElLY1l6UjI3SXBkR3hkeitjelR0?=
 =?utf-8?B?TmFTK29MVkpHMGpGdFlpK24yUUhlZWUrclhqVjNuUXVLaENocjJyZWMwcnE5?=
 =?utf-8?B?bFppalRsZmZYejVvTzB2QW05VHYyalVWL1RET3UwN0E1RC9jYXVDdFQxLytT?=
 =?utf-8?B?aDZKTDJORUZCU1NEWmNyeUZFM1B2b3VoUTduTlZPSWh4SWh5bTJtYWZHdm9M?=
 =?utf-8?B?aHBrWEZaZFZPeklOZG1zV1hEamszV1Y0L3FQVnlxS3VZQlNJK2oxSy93bHo4?=
 =?utf-8?Q?vgfFK+14qH14YLdEkFOZM7/qn5CTwsMHpdhdOLepLPWFX?=
X-MS-Exchange-AntiSpam-MessageData-1: UK69pTubIGfa8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7cd3db-1ea2-4c6a-59c0-08dea74800f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:08:03.0215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HIeVGYNZTlKGsDTFhnjCNEGcxTdUfFE7fwiEomQ0i0yVcKH4ufJwUstslZNHNhVicLVBF1724yuptxU2uXG0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

On Thu Apr 16, 2026 at 8:20 AM JST, John Hubbard wrote:
> On 4/9/26 7:58 AM, Alexandre Courbot wrote:
>> Replace uses of the Nova-internal `bitfield!` macro by the kernel one,
>> and remove the now-unneeded local macro.
>
> "and". :)
>
> Translation: this wants to be two patches: a "use the new kernel
> macro", and a pure "delete unused code" patch.

Done - it looks a bit weird as the `bitfield` module needs to be
orphaned to avoid the unused code clippy warning, but I agree this makes
review easier.
