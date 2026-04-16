Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA285F8E489
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6F810E23E;
	Thu, 16 Apr 2026 22:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vjx7F3/u";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0922410E23E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 22:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af0ziI118WpbJgO4ljnhfZAqrJv2D91eI6ay4+d9fUrvm7/SnE4nnfCIGVsC1mmpx5DAaaLvLVA88hw5/6QgeIDTY6YtylbazD1TgPxEB+Iouh1ebnRvureAZDe8ODuaI6pDZByRSGDVtQSHD7L0DgzmwJPla4RMwgNDGdW5G7amF/oesPSUJUQVft1hPnXiab7sKJzjtErX37PCp9GaDOfO/ILRyBjN0wyvejvBEN6QIrUz1g6lYjsHH5ita99m1MEcQdG04RDK2fd+iJH7dxPI+YPxOMKKjjwryMIufTcgL4OlP2XR9NiHpWWT/EMO2Uc4r+uwzuw0dU3J1CKmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oodr/XIic5lbgcXuZZ+eatLn74Jks4qCxkSXa4/ek5E=;
 b=tvC6IZSlv5z/9UajmJrMQF2Wj3ofAe108SHo9pqao17kg/CaHe5lOM4cL7jchplv0fFd+/pbDn9aqo0Ahfu1hXB6o6V7H8xesUTFJMU4ykRdyQoos4rKOpiTaldp/F2o00Z1LqWK8AR7esm7IZ/tamQngn0Q79Tx527cuOo3jP2YNtb9AfN9HLEb6DdSpMZWXHP9VUH+vO7o6g6BXnrQDIqy9bVFSI+dKSJBLeSgWZh2+kzjfUQsXHZs8yJwSOIWmQWwVuDxnO8brMFwbIgna0aPGgOPlwAp/UAJsd/+w1Jpr2zLdqoeWrlvzBi/j/d3zQuFr+2aKGPT81ioe8eUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oodr/XIic5lbgcXuZZ+eatLn74Jks4qCxkSXa4/ek5E=;
 b=Vjx7F3/uvkbImLKa5OHWgz1tpjuy7zugxReNHqIBLyoq3PpCwQYoYDz/B+kENTMN3XpcqIIVkw1bpNUsFdVU/+XJr7mlvOpPsMV084eyd3kS1MZJrBcaUFdYWuc/O3SBhXmxxayKWDAOmMwMHfOY/zREehAi/z6rltoGl1igLuL47nlLraxP1kewS9oObhQNe00cC7cYRLk3WVpcr7U6g3JnnOHGucAkFvhshRxVrNyJfgkLWP2EcMoBiBCIGbvi8W1BVjMi2L7FcMxhytyor/B8IG3/8U54kjkdEq2Je5aGKLCiJ7z/vBxTgIAkha3hDmX30bRK69Dobqu/IhhtCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 22:43:27 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 22:43:25 +0000
Message-ID: <8075b7f1-1540-40fa-9ffc-8a7badd39b5e@nvidia.com>
Date: Thu, 16 Apr 2026 15:43:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d237a6-606b-4b3b-8675-08de9c0991bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xiZQcHEbPDjHHoPRCiBpsgsCa6o6/Xa01SHLNWafELtkaMm6H13SrnFmmO801UKTD3Sot+8ACt1xLNhsu20C/51yC45OjHZvUAyoiHHXodqwUKbXP7HnxVAacV+DKPqJJgHf4DmR2puZgN2HYBUFnHU0g/6pETtRzPkZf6XB+dF4LiGEOlGGG4dr610vud4ApIuRaqmzUzisUbowiInGssW0/9Iyb0yakVQ0i7GqWmGueInfIPuLi8oLX2/xRX6DPEr6QWtY0eb9KPuCov1o4cdEqso1KYAOGcUIJLq+jEwgfu0HX/KU5Wk84mLkvElf2+25GNSfQ8HCdeFSZcuuqO5Rk0blfLiIlbL5ItnU5np+n8CFLMKA2/SQOWdy0Rcua4VCxg0DYRr8yrkfAVrN4xL4w4AeV+7Nf8kcQZO/cbiU8UXz/CVBXzVKrkeTSAbAmIySNEQx5aJTMa9Avw7EfRr9ZNcNtrnpg0iR/jVfeaI5hEVx8Rv6Jij1fqCnXHwdM4gDZmqm+299BexCg5S2wNQ+FGGwAAGJwRjpKXWqhuho3YQCQ7QbdoUB9pDP3KswiOvYjrwoRHGW17McnR1EXx8qhEgc6ivWCp4D7ytql75iAa70pg155uayldhuzKktTk0nJG3+tZlMrDnRWBkMf/7GXxgqbpUfr/HWWyJdPzRu8eMKYyOs9k2hJ1EQJrzgEm7O0mx8G93FML0yB9B+k7cr6Or2tEjaTLax4P4Li5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJnVzJwT1l1MkwxYlZPSldzUTBTL1RyZU9RUE9OS010cytVbWVmaThFNTN6?=
 =?utf-8?B?N2tnaHMyVENlczE4RElGN1dSa0hZbnNKVSs3NzBjMUp6SG80ajZRODQrOVJW?=
 =?utf-8?B?Ym5mMzQ3d1lpcWxZdDZpR1VBZk1sZUhWeFRsNDN6RW5odkdYd3VZRmE4RVVk?=
 =?utf-8?B?WDBheEtVUWJXZDRRbXUrYTdCd3BxWXFZbGh2ZDJOd2N2UjlnM1lNRHJBMXFm?=
 =?utf-8?B?QlljaCtBK3hsV2N5Z3dyK0ZRejk5cW4zd3FzbTNzaTlYQmY5UTNBL3lWR0Jx?=
 =?utf-8?B?ZzdoaW5RbEVPb1c2bS92ckpwcVBaSXJkenNJZlp2VmtJUmNvWGhtdGFYSzRM?=
 =?utf-8?B?Zm9iL0F2WFNEZkVtR3ZDV0huYzhDc29LeUhZaTY5WEhEQlFIWEJIdGczTSs0?=
 =?utf-8?B?bkhxVkRwQWhZdjFNaVRiU1lQaFRqVGZqMFZwdkVXbFIwVi8xZjk2NERxU0pM?=
 =?utf-8?B?cDlJKzBIVnNQTG16d25DNnpwQTY4eEgvWVlsdm5lZDdJbEViUmh6dTFJY3kx?=
 =?utf-8?B?Wmt3d1BQSmxJeER2dG5UWjRZY2Fmby95K1BqQ09kam95QXMrYUxaL3VVWHJy?=
 =?utf-8?B?M1hJTUE1L0xsWWoxSVFyY2pGaHhVbEFYaURxMEhWOVNNLzY5Nm1BQUhSUW9i?=
 =?utf-8?B?SzByakZXTklIUkRaNmVxaE5rTWttQ1NPK2pOdGFxNVdKYmJBdHp4UVBsTWhK?=
 =?utf-8?B?bVk0eUE3QXRXTzBLcHRta2JTV2Z2U0ZTN3p1SWZXaE80ODZFemx0bWszaWNT?=
 =?utf-8?B?Wk9XTFk5MXU5dk1pSzFkdFI2T1cwaFJub3p1QjdLQk55dlRaTktoTldla0FK?=
 =?utf-8?B?SDdCZ25vS2liaE9Xd3o2RTdOVVJjUUdtdG9mekpYOXEvTVFLVzB4clhDUFRG?=
 =?utf-8?B?MHFYTnkwa0J2ZndBNnc0N0JGK3VYTG5ETEwrdTNubkdtanJEa1gwVXRnQ0NW?=
 =?utf-8?B?OS8rRnhtMkc3TzhIZW1RbWJGWUZla0ZoT2VIMTBMWkFlRGNpdlpaN2lFSGc4?=
 =?utf-8?B?UDdzK200YWViQzhSRXplVkFzbHJDc2ZVUUpNSi9CbVowaEhzU1kzQUE4a2hp?=
 =?utf-8?B?bDB2UitLL3haMDZ2Q3NxSjdCSGlrSHB5NHZBd1QvL3ZEQyt3TFRhbXphei9v?=
 =?utf-8?B?cko0WUpWVGNEQys4aGZiVkQ3Q3g5SzhQZWMzeGJTVHFFMS9VbElhUlVGWnV3?=
 =?utf-8?B?SW5ZMFBQRHFDdzhNVXJPTktjTU1HaWxJd2huK3RuNnN3ZVBHeVdUamk0Zlh3?=
 =?utf-8?B?WUhYYmQ5bVBhOW1xR0kyRms3R0dCUDFORlBWbjVBV0Q3QldrQ0Z5L2lQVW14?=
 =?utf-8?B?VlZjS2duSVdCcWttNHk5eXpkV093d1VuS0RROW5qcDQrSWFKSlJ2VW9mK0s3?=
 =?utf-8?B?dVhTa3hHaVZJam01YkViNFM1UEd4Mm5jS1RRc3g1NkdrZkp5TVE2MkxYQXJp?=
 =?utf-8?B?VDREZzR2QUp1WDF4YjV6Q1E0K29xdGlhR1hYbTd4VCt2WXJvQ09zOXY1K0c0?=
 =?utf-8?B?WGRyQUtvWk5JTWVpMW80MENCYlJFQmYvVXFvdkEvRi9iVnMxN0RCd0JheC9X?=
 =?utf-8?B?STBhQ2FPVEk2ckZDelFINjc0OE5lNEcwcmVlQ1E0NStPUlRSU3RnVU8wTStG?=
 =?utf-8?B?WS9HUWhIWEQySmwyeGI5ZHAyL0w5UzV6Rmd0RHRoYnUwVFhJbzU1d3lwVWo5?=
 =?utf-8?B?d0lRM0ZVMnc1RWU1dWlVaktYNUc4SWxOVGhhWms4QXoraVpaczRQcnM1OTRJ?=
 =?utf-8?B?NWwrdk5oUktCWWR0c2NqeUpKa3RQamFJcHB4ZkhON0JXNHRDbTFuTGhsd0Q0?=
 =?utf-8?B?T3ZRakdUTy9UV2tISnBmcXEzaGx2THpNS1Foc3ZmSVZHcmREZjY5cnQweEJU?=
 =?utf-8?B?UGhpWjM0OVp1OFByVzdQSjlyVHlmNW1RbGhweTVSeHliVFNLQytSTkh6cXRz?=
 =?utf-8?B?cXdMckI4dHlId0lrWW1DM3Ayd0QyTjd1SXp6TTl4Ymtwc0VKYWtNQlNuMTdN?=
 =?utf-8?B?SzFtczN1ZjM2K2p4MkpIaFhhSzJEVk9OTmVrTzR0WE5XdkxLVlJ0c3FoaUU3?=
 =?utf-8?B?aWhoMFkyK21VUyt5SVJVQVdDSWl4djJLTkF4UnlpTjVDNjlBOElhS1FSTE5P?=
 =?utf-8?B?bUdYaHZFK0hwRmtpblc0MU1VQmw4TTNhRnJFZGFucGE0OTZCNlE4UWtna0cw?=
 =?utf-8?B?OXBCYi9WVzIydDI0eFRVRHU5MFBlbjZZNWJ4dE10YmRvVi80V0M5Y0k3T3dL?=
 =?utf-8?B?QU41dmZ2dC9KOTlVWXJPTmt3Rm9ZczRrQWVmY21KQTlibXlWbjA4OC9jMDJ6?=
 =?utf-8?B?RWNoNDdDYU50S1k5dXZ6and3WmEyYS9keTRabWRJdGdwaXp1Tmxkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d237a6-606b-4b3b-8675-08de9c0991bc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 22:43:24.8908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hAq+DffuwTVhLZORdKBUDlV4lX5gpUAN7f/n2zNJ6SVUa7KFxN7bZVTk7/ntK+bY8A0BHY6mM9FSOaXiLbgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
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

On 4/16/26 3:18 PM, Danilo Krummrich wrote:
> On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
>> Can we please put this into your drm-rust-next-staging ASAP? I don't
>> think we have any comments that would really need to hold that up.
> 
> I would like to see the first patch being split up and we also need to agree the
> merge strategy for this series and obtain the corresponding ACKs first.
> 
> That said, I'm not a huge fan of the drm-rust-next-staging thing. It started out
> as part of Alex' (private) process of staging patches he's about to pick up
> (which is fine of course).
> 
> But now it seems to develop into some semi-official "shadow infrastructure" for
> when the drm-rust tree is closed after -rc6 and during the merge window, and
> it's not part of the official drm-rust workflow and other maintainers don't have
> oversight of it.

Yes, a patchset vaccuum existed. :)

> 
> So, in order to not motivate workarounds, starting from the next cycle, the
> drm-rust-next branch will be open for new features at all times.
> 
> Consequently, all patches applied to drm-rust-next after -rc6 do not target the
> upcoming merge window, but the next one.
> 
> Fixes for code that is within drm-rust-next and was merged before -rc6 have to
> go into drm-rust-next-fixes.
> 
> drm-rust-fixes will continue to be the target for fixes for the current -rc.
> 

Perfect, that's what we were instintively trying to replicate, after all.

> I will update all corresponding documentation in the next days and send another
> announcement mail, so it is not only this one buried in a thread where no one
> expects it. :)
> 
> - Danilo

thanks,
-- 
John Hubbard

