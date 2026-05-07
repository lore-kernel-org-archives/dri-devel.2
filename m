Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F26CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 19:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CF510F206;
	Thu,  7 May 2026 19:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i//P/Op4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2503110F206
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 19:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDB9m/rKsxEVQ34Ntr19svvc655fz8tsIi3tYcy426b8StCYyxmf1TjdMuc5tYi2cReV3ixqp1WryFhSgluOewClKCj/NcJ053q/qntqf+9vgOGuuaqa7+tunUZhiBpsi+f8Snqy7U1PRiqpF1K4GmLBmEDZjnPklQkiLLQxCONLJQxIqDKKob6NKY2bq0jaJhl53S4buVM2Bek2CxwMAnsZrquPU09kciMCxGE7gfH60c6ejTavR4RFBVNkYJKEJJdFx16WbCtG8NFO6lXBwejGRo+3EtztpY1PbE0N7+m/K26qaJtDSMcrcrDKwPXD4Torh0yUGZbmu4kvsdWtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBVAyPvggvraxEneTB9MGknPQ5esLCXNnfF/e6S5IJo=;
 b=Mgg/9QbVcVlY9/Jb0evYVlBeFKwxA9ZOCyUaMuMDZapHIVYZ14WScU5LH0MWRWvuf/7mhJ9E4Z9DYvMKrX823+jeWALbgMldRT3Wgy4G24/IOpmXHNW0vrdY5kTq7wBnvFV/71krGfhrdlm59mH/ApRdAJ5rns15A7CWZXMTcQo7RrVBObLQB/Ykukd1owRrQ29Fi38O2r4kIH+1f2HBusrzzObjB24LC5Zuk0k5j6lnzsdQp1cRnsA/l2wEpCJG/Syv1/LBPmJWl7zDaSvoG50mES5Ot+KK+/SjJ6UpLXQ72haztaGeYWI7S8zOnot/KBS6+CrnMP8Ed5C6kd/dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBVAyPvggvraxEneTB9MGknPQ5esLCXNnfF/e6S5IJo=;
 b=i//P/Op4dl34VXbZaa+Db0vOIdCzFa2At2h4J6aY5pM89BrGC4cSzhb/wB9RyJf7QntRrwa3qxKRLTs2NzhWTTGCY1jgvABTA1VQdZ02fsfYB0kfkocx4rSgWgyy5aD59+MUHtzRYYffr7FyS97ZZxiowWjUpFvd7icaLHrnp5h7cAzb9bzmihha7FmGzehMwyIRK+nwWX1F8f4fMR/s046sEtJJM9d3JJTIuoUclAa6c4PNnxk+RlI9PhNxwzvzQ0T6XnVhbOmHZASHNmRUu+SJ/pkkrIlYyqWPkxUeexg+opli6arEW8b2b8Ndbsvdu7gunlgLzCgPiiBiZCQKjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 19:44:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:44:16 +0000
Message-ID: <296ae420-5400-4903-8d36-62b471862065@nvidia.com>
Date: Thu, 7 May 2026 15:44:11 -0400
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-5-joelagnelf@nvidia.com>
 <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
Content-Language: en-US
In-Reply-To: <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:408:fe::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: f01e9b96-ef93-4281-4c07-08deac7105c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|10070799003|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: t0Va80DdST4xs6gSJ7vT45lLM4TNmYQDqrJLYl7ztwLFEXlkuU1aNEUw+NGK8/Ysh3de3ZPijQzw3a4OMgR7tvHh8qQgT0kBHJ4bfN/EHnDm6Qax1UPuCO1XFoBhfIcjqV9F+Q/pGDwbimsa3/Yufv2DYUbrIfR02brz7b4GQR9EO9D7y6tgQ/r72ItgYPIiqtNG509lzd5GBlBAuxOsd5esK4NmNOkI8hVEXhQYB32y6UCLGDDaxPa/nN+2krL+a8piUfx7zgQupmZzJYwwe+OmlJQnZnCZQ5EFnEQ2jffjiCXLS+hslugDTS2fKw6GOKrWl24MCZ8UuJ6nKa4vy0UMuHDfb1PQVs8rVXmXINFjgSe6y0Se298Qr1Ua1IoxUKszZw4eFlU3l0Rj24Nn8fvthXWTphc4bTq7UoOIqW1pzWsxuEUEaadcez7TtjK88EgwrHEFe8HwbtzLHTyXpzxOLOBynE9GRxlTKv0K9AZ2bU28YbVtYifRikf5bZ90cA9RXiH8FsZfvBcFf6yYBKWEBfN1lMCDYCJQh4mjrMWZoujcoZv255Cbp3X2XulGFR5MUMMbXbhOWf7HwiekxMBUrnCw7AUyx9ru17XP9Oi4cFFz62MAPgDcCgQ3B0Qe1li0Bj0LT4V544pQkVQT/AbH3sv/wBghRcp26ik40sln90s+N/5opEe0XjCxpe0D9NPwbVl2RNOnoHbRnnlOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c240S1JOSUg4REN6eDNJY0Nremgyd3J3N2pESng1WGJlaHlxMkJjeXN4VDVy?=
 =?utf-8?B?L0w5VmZSd2NVL2VRRmJaYTluZU1sUERubzlVeWxMVkpsdVIyNWRUNVFhZ0Y0?=
 =?utf-8?B?bjlNOW45VFlPWm1RRWZwUnFTZVozRkx4TXpXWXk2VThONUJBS3N4aWs4K1Ev?=
 =?utf-8?B?b2cxQktVMzZOMldIU21TaUUwQzFkY0tYMkVNcXo1YjU3SlVmS25saWRkbGl5?=
 =?utf-8?B?ekJsVXJWTERVVVpNNERsN29VRGFXYys2c2t2SEpsSnhFWDExaUdEQ3BRVXBr?=
 =?utf-8?B?T2syQ3p1YUVoRFlMRzZRNlAzRDU1YVhGL0hxL2NhRWRGMndsZjBNYXlJV0l0?=
 =?utf-8?B?eUxzNDdKQkFMVEphbkVOS2d1U0VVbEZTMkVSVXVaQkNwOS9ZZDEzNTE5bWk5?=
 =?utf-8?B?aHZNNWFDb293eG9IaUxmY3E0dWFVK2Y0dWp2bDJYOW00Qm9iZkQ4TzlHKy9a?=
 =?utf-8?B?aE9DS1JpYkdrVFJXS2Nrd081RWFsY2pxc25ydDIyeG1jWXk3eUVCTFdtZlVZ?=
 =?utf-8?B?TXBrSkVNbzhETVFveWkzWElHUTlQVS9NRVBObFNSNEx4YUtIejMvOXRtem5H?=
 =?utf-8?B?Wjc0TmlvSlo0TW1FNHdJRmtHb0Job1RXRUhkN2l6TWxwRjRmT2IxTElSa2h6?=
 =?utf-8?B?VDhES3NHR0h0dFZjdnkxYUJSS1dHOTdjTURaUURhamNhRmd6VEVSdlNtZVBj?=
 =?utf-8?B?NHlHbHR3UFB4OENOK3RrOSsvK2lFQjRUOGZuSWNlYzdZcmZtNnhwKzBkeWY0?=
 =?utf-8?B?VXFDU1d2VFJMMTdCVk9BWFFRZ3FNOGtpZUxHdzQ0RzZ2TEtCNkVGOC8vNS9v?=
 =?utf-8?B?NVREcGdCa05aN0NSV09sOEt5aXNtSHQvQmFKQkVLUG9rMGc0b1R4K1BoWWlZ?=
 =?utf-8?B?cTJDeCsxSXh0WWVLSW1VKzh4ZW05Nk5CRUV1NEdCVmZQU1NSRXdkV0tjRWpM?=
 =?utf-8?B?V0Q1dHJOa3lpbEI0TkoxdC9YeFN1T2EzVU9uTHduS09EdktiUUVZVm9wT1ZQ?=
 =?utf-8?B?NnowUkh0MkdlTUFIV0hFejc3d25RdmZDK1B6MXNNd09Tb0R0L0pPMHVvcXM1?=
 =?utf-8?B?bGFzMzNja0QrbXpybnk1cm95ZFkzS2pwZkRyY1JWL0tjd1VzNDRrZmJJY3V3?=
 =?utf-8?B?TmlRZXpPOGNFTUV1b05hT3BWcEJaTm5hbzlqYXNXOVV6SlJ2UXprV2lockVZ?=
 =?utf-8?B?c0tWSFJhTGdCa0dvRUVZL2puZ01xMk1XS1RYazZ2ZmNOYmlWWHBSWGMyWmY4?=
 =?utf-8?B?azhNUVQrT24rWGI1cE9wQlQvTmdvZFZQNWYyNHhqdTJDQysyVEhhRFdJYkZw?=
 =?utf-8?B?ZEV3dnJzOHdJZjVwcEgrVjhxUjNmNG91UG03MDJHRURiRHlPaTRYNXZjYWpl?=
 =?utf-8?B?ZUc2Nmd5ZlNJMlptaWtRVnRmZ0IvT2V5aUx3MmQ0VWVjamF3cHBoeVlxL1FP?=
 =?utf-8?B?bGZmdVZaTmk0RzFCMzNtUXV4U0VVNmVxU3BFS2NxS2VxZ25RZWlzbDBFTWda?=
 =?utf-8?B?WlZwTWs4VVZzYStDZDVyenBZSjNmTzdQblNYMElBK1FkOHJtdXU1ajhJS3BV?=
 =?utf-8?B?NlpUYW4rRnR0V1VZTGplYlR5aEZhdFVsRE5PREU3bXlsMXcyeVpXRzRhZEhz?=
 =?utf-8?B?eEsyaTl6Uk53eUNlN2RBVm9EU3AremE5VllGeVdCc0pZT29QY0gvbzRpd2lD?=
 =?utf-8?B?L05jRXhLMHozVktueUovazh4azlDRWZJclZSNm5acWJaNWhHSlBFeHI2TmxR?=
 =?utf-8?B?bWJvR2pqRWhtRUd1YUVrZHB1V05adzJwbDZLMjVSZWlJVk1OVzN3M0h4ZVhp?=
 =?utf-8?B?d1R2TjI3bHl0eWZ6dmgxME1leFpmRkowWDFTeDk5MEF3eVlTQklYOXVvK3FL?=
 =?utf-8?B?d0UyUlBCVkcwb1ZCWWRWbzJWQlFwTGk1SmJlVWxPQ3pIcjdnQzR1c0hmMWhF?=
 =?utf-8?B?Ni9vTUhUNUdyWmltdUsyR1hjMjhMd1BTZFAyLytUZWJub2kzcy9SN0ZRaXBN?=
 =?utf-8?B?R0lTdkVPVStBckx3QWlTWmNVTDJQUTBaRzVtYytqM0FWMHFKa2w3SWhETzdo?=
 =?utf-8?B?M0JxM2hOekJMcXNlT0lXR1NUckJQRnVjbmljRzVYYXRUYTZwWTFZVk9Ba0lC?=
 =?utf-8?B?UVB3V3ZTblQ1dy8wbUZyV2ZDNVA2RnErV3FjMWs1U0RST1BmTXhqOHQ4UXl1?=
 =?utf-8?B?eVdldzBVRUo5TVE1RVFHUk1UZWswcER5TEE0c2c1NnJ0THR6VG9reEV3ZGo1?=
 =?utf-8?B?dUY2N2c1RjJnQ0ZJeUt6eFQxdE1QVmdiRit3cnByelVQSkdJK1hGejJaUEcz?=
 =?utf-8?B?MGYycy9Dczh6b2ROSTJXYzhicFAzT00yY2FCbStzMzJaWDVZeG1qOGc0eWxG?=
 =?utf-8?Q?7a6Fy20o64ll5oR8fiS/H0npsJX1pdddgaAia1vfCXUVK?=
X-MS-Exchange-AntiSpam-MessageData-1: JTANI742/NPrxQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01e9b96-ef93-4281-4c07-08deac7105c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:44:16.3496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVagD+1tICX3Sb37Xl3KLjd40+5FOqVo8Fiku8m5ZgAGAnEnanuZ9gnfgG7XdNX7KgpPOm2Hx1BvbtmEumPCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

Hi Alex,

On Sun, 03 May 2026, Alexandre Courbot wrote:
> `Pramin::new` takes different arguments (also check the other examples).

Fixed.

> The HRT series [1] will allow you to greatly simplify all this by
> storing a `&'a Bar0` directly in this structure. It will most likely
> land this cycle, so I think it's a good idea to proactively depend on
> them. It should apply cleanly (modulo the Tyr patches IIRC, but you can
> skip them if you don't build the driver) on top of `drm-rust-next` - on
> top of which this should also be rebased anyway.
>
> [1] https://lore.kernel.org/all/20260427221155.2144848-1-dakr@kernel.org/

Actually, I was going in the direction of making Bar0, GpuMm and Bar1
use Arc instead of lifetimes initially. The reason is, some of these are
long lived references. Directly using `&'a Bar0` means the lifetimes
also gets threaded to Pramin and then threads to GpuMm which is long
lived in some of my later patches. Some of the cases where we will have
long lived mappings are also vGPU and channels. I spoke to Danilo about
this, and we discussed that an initial approach could just use Arc since
refcounts are cheap and it should be just as performant, then once we
have the design ironed out, we can migrate to using lifetimes in this
code where appropriate. Even before HRT, I already used lifetimes and
analyzed the tradeoffs.

> I don't think that checking the range in this type is particularly
> useful, because this abstraction cannot validate VRAM ownership
> completely: VRAM can be sparse, reserved, or protected, and with the
> current bound access to these invalid areas is not prevented.

I think there's value in keeping this. The range check is similar in
spirit to what `Bar0` accessors do -- bounds are checked, but a passing
check doesn't guarantee the IO will succeed at the hardware level (an
address in a valid range could still cause issues). That's not a reason
to remove the guard; it still catches obvious bugs early. Having a sanity
check that says "this address is at least within the declared VRAM
region" is more useful than having no check at all, even if ownership
semantics aren't enforced at this layer.

>
> PRAMIN should only model the hardware windowing mechanism; address
> validity belongs to the higher layers that allocate or obtain those
> addresses. IIUC nothing will explode if we try to read or write into
> areas that are not VRAM.
> The problem with this lock is that it is buried, alongside its usage
> guide, deep into this type, ensuring that users won't ever see it. It
> will create deadlocks rather than preventing them.

Having an internal lock isn't inherently problematic -- the GPU buddy
allocator bindings follow the same pattern, for example. Let us go by usecase,
lets not complicate design based on a hypothetical. I wouldn't move the mutex
out of Pramin just based on guessing and complicate/thread the mutable reference
to layers that don't need to handle that complexity.

Further, what concrete design or use case requires mutex to be external? I
wouldn't add that complexity based on hypotheticals -- we go by actual use
cases, and there are actual users of this code in the patches that follow. For
what it's worth, I did try the outer-mutex approach myself before you mentioned
it and decided against it for this and the buddy code based on the reasons
mentioned.

> And when you look closer at it, you realize it is actually acquired for
> any use of `Pramin`, since the only method it exposes is `get_window`,
> which acquires the lock, and returns a `PraminWindow` which has exactly
> the same layout as `Pramin`, except that the lock is acquired.
>
> So what's the point? Let's just make `get_window` require a `&mut self`
> and let the owner of `Pramin` decide how to manage concurrent accesses.
> At least the doccomment for the lock will be visible from a higher
> layer.

The point is to keep it simple. What you're suggesting requires the
caller to do: lock + get_window + access window. My design is get_window
+ access window -- you need the latter two anyway, so the locking is
absorbed without any extra burden. Propagating lock outward adds
complexity at every layer that calls into `Pramin`; handling the lock
internally, as done elsewhere in the codebase, avoids that.

> Currently `Pramin` mixes elements of hardware access, memory management,
> and synchronization into the same type, squashing what should be
> different layers into a single one. Now that the `Io` trait is merged
> and available in `drm-rust-next`, it is a good time to implement the
> feedback I gave on v8. Roughly:
>
> - `Pramin` should just be the owner and arbiter of the
>   `NV_PBUS_BAR0_WINDOW` register. Its `get_window(&mut self,
>   window_base: Bounded<u64, 24>)` method simply returns a window to the
>   1MB area starting from `base << 16`. It's the simplest possible
>   abstraction.
> - The returned window implements `Io` and `IoKnownSize`. This will allow
>   users to do all the fancy stuff that comes with `Io`, including
>   projections.
> - Random accesses to VRAM, which are needed for walking the page tables
>   and updating them, can be built on top of this simple API. Either by
>   adding read/write ops directly to `Pramin`, or by defining another
>   type that owns a `&mut Pramin` and moves the window automatically if
>   the next access is out of bounds. This should result in window
>   management code that is simpler than the current `compute_window`.
>
> That's really all we need. Then `GpuMm` can manage concurrency similarly
> to the current model by wrapping `Pramin` inside a `Mutex`, and is also
> free to experiment with different locking strategies, something the
> current design doesn't allow.

I am looking into implementing `Io`/`IoKnownSize` on `PraminWindow` --
that part makes sense independently. The `Io` impl would operate on the
current fixed 1MB window view; the auto-repositioning methods stay as a
there is a usecase (more later). None of this requires the locking changes.

I'm familiar with the v8 feedback, but I disagree with parts of it. The
current design isn't complex -- it's the external locking + split into
multiple types approach that I think would make it more complex. I'm
adopting the parts of your suggestions that I agreed with.

The auto-repositioning is actively used and not hypothetical.
`install_mappings` (mm/pagetable/map.rs) holds a single `PraminWindow`
while writing PDEs at scattered buddy-allocated VRAM addresses and then
walking up to 4 PDE levels per VFN -- each level a separately-allocated
4KB page that can be many MB apart. `invalidate_ptes` similarly holds one
window across all VFNs: for a range mapping more than ~256 PT pages the
PTE region alone spans > 1MB. Removing auto-repositioning would push that
window arithmetic onto every caller.

> > +        // TODO: Convert to Bounded<u64, 40> when available.
>
> It's available. :)

Changed to use Bounded, thanks for that primitive.

> I think this method (and `write_window_base`) should be methods of the
> `NV_PBUS_BAR0_WINDOW` register (`window_base` and `set_window_base`)

Agreed, I will move it to the registers.

> > +        vram_offset: usize,
>
> This should be a `u64`, since it is a VRAM address.
>
> Actually, I noticed that you introduced a `VramAddress` type in a latter
> patch. It might be worth introducing it earlier and using it everywhere
> a VRAM address is involved, that way we cannot make any mistake - not
> critical for now, but feel free to do it if you think it helps.

Cool, I will look into it. Sounds reasonable to do.

thanks,
-- 
Joel Fernandes
