Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048A5F8E4A7
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF8B10E28A;
	Fri, 17 Apr 2026 04:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="itIY8XBi";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF1D10E28A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENly3vsaN8gLngNMjjjot325tYZDI3pUBqAUvy1hahw9zUaHAtUXiLvgYBrY8Ce5kBLp0pUEp58ZcP6U7vzL8i02dfZZSfsFY0AY3YMHz/fVKkPSSyBZfO79eAXTH4lAq71z3nwsygPbsAvC7GlnVHWOS0KtbS5zOZanI+GOfagV6dNteP1ACGSjCQfrSOIxS+8Td4abcznJjio0Npylw3Kbz6CaJZxLsV/eUYIXUp7Nd4Zh4kHtc3k2DLvLHFx18Pv0ObSRDdG9iZ4SoMhIkG4UXE1wts1/uUYfqGyHgL1HfhqJhT5Mx9YkkrlMtBWx23Kan/uOUgwjEdAR52ndlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+0CNKKULV3617X0njKRH0X+mdhmVMAxW2rHx52qpns=;
 b=gDZ+M91rN4Ck/yG6O1iIIucX05VKoKpODdn5biHIJ0fxgeOlZUCk8nuF5uCkBnsWB4trCIRFuU852Wshay6Daxk2OEj6eXgZP8NnKigY9zDr1naSFrl6Neuc7gMNPT27/zAuj5GpHNdsI0U7NArKqpCftJZcNZhFZ+xfnbuR0t3NleBMuXA3Le3YsWh12/3dw68B0TAmJhGTRBGDQDe1mDNZcA1lLBL1cjeX17OH7VtoVYlSvHMKrNlPNSDO6ykrYUEBAI9RhK2LGnxdp3uwEXeW6GzlYCarK2hsWYXjl/2Q1ekkHarMCQ3gPZ+ANIUzHFXlC9rBVunuoy6RdUx7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+0CNKKULV3617X0njKRH0X+mdhmVMAxW2rHx52qpns=;
 b=itIY8XBiA9omEQWC5M7ecGtg0SpqOmfb/8H9zkkBtUNrr38cPHd6mbnKgB2uSq//em7j4XnsyBn0s/xaWW0ZPmLZF3BbEYX5wuWuf78HUuoD/l3naYceKBYc4fmaVJc/BeFNtBqlWkNz3TbgUh24I9cCxY5Thi4+CcVmAmaV22fF2K7sZU/85w7roXB7SHioi7ToXo0afJ9153QvU0GBDlFyMasGpv8B1OLWFIQRRwwdplGk6c6M0QCBEbOuVv+fRcMeB7hj0POmEObfjHytS8Fy+FTWepORRj5FUjy6YefcHTIwu4sB44ociI1+hs42kh+cXUo+xFPqxRBTqWcM+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 04:15:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 04:15:08 +0000
Message-ID: <71bc5290-a3f1-407a-bdc4-115e31a995b9@nvidia.com>
Date: Thu, 16 Apr 2026 21:15:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
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
 <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
 <DHV3N3R9NJU3.2HXR63MP02NPO@nvidia.com>
 <fc4b9204-b4c5-415f-8435-e7ae03418dcc@nvidia.com>
 <DHV4MIBWUT0S.2S1QWXGU4LFK3@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHV4MIBWUT0S.2S1QWXGU4LFK3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:408:e2::14) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e178713-ce4f-4e19-b0d9-08de9c37e8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2K6wfdBshw0BhuA9GaqmxO58Qv8k92KJCbreQtfUzHoMOiuEtNjeBOWTRDLnMXtyFTFD3FsJqnb0lUV2OxAfj/5A565DKO7wtllRTnOrEGbd5PuVTjknssjlL6krc1/Y7uaZVgnBwSZiY/YB1mF41HoBLdhkHT9ECLNVkj/EyNi8Ve5CpUM618GhmI1RGU/Tp4LA/buIas7OcdIutiil+U3FCxW0+XZqvCGebmcpIPwOGw5Pf5eKG+BIUAjjPYrFeaP9V5w4af0tiAk6vvsdT2jXCC9w1n3KwlxgAVGOlzpxXWjzFN3Ri2GJjp0le3b5EmaU11UYRjAiUVFBkpLi53GqHddDLZIuwIKJWfdAk8UTrg0vei7n5xXZO7YSH2nxBBtXvNVuL7XNIjyopWbLysnpeU92CboHUfw7358f7QwqPHuJXlWxiJ1Fl5e5sdcccwngMcIUG6+ey4+nSb/2UJ6co3Ibo6zIlQwf4juO1xDrRsn6WCqkRFrx5MZmeuKbXslOwQbvY+cQtVRUSdFHRjfkafwYF/LNov76bZgXWJA4N8uRCM2yskwQwvhqbeK/kE2xei3yXMhuhwxWLue5jGHu8hXsr3fIfOP+Lmtk/Z+u1t1/5AoQlhboMackYIUBqw90zy2aGyHpmF9xTkvkpj5TmgW0iWWg7x7enwKpVWoGleY9l9SH96o9OVtReoIqwO8NSwQNUIeunoPN9sU1Zptj8P/Hy7PjJJgWMRSnxog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JjVlB1ZFdTQjAxeTUrcjE1TWtUNnlwWldEVzQ0c0FUdVVlaUZvQXUxYVd2?=
 =?utf-8?B?RjZEQ2VkUXRXRFgxbG9vRi93SXRNdmlPWHI5Q05LWFkwbGgyVXZGT0R2UU1v?=
 =?utf-8?B?ZGRJUkpkWVAxMHRtaDRuR3Y3b1FtOTc1T3hRU2s5RkpKNGNOKzhqNGVzYW1o?=
 =?utf-8?B?QmZzclJ5L0c1WklSUVhaUWQ1OWx5VHdWL3plQjNYK3lPYzhTNkhBWHg1L3pM?=
 =?utf-8?B?MDg4KzRSWHBmLzBBU1JWU1pNRGg4U1g0Z1RVU2wxa2FUdkFNYXU2YmIydnVn?=
 =?utf-8?B?aHJEemt2T09nMEQzVzhIVUl0MHdCc0NhOHVUU2lid0FaTWl0a1NhZkVKdW14?=
 =?utf-8?B?WFRtWjNFdXdiV2picFN5LytTNjNwbkNMdlJtdTZpdktsM3VRK1VFcXN5RDAw?=
 =?utf-8?B?OUFURGFNM21qamlZdjVNay80ejcrb0FySWk4TUlhZmZqUWk0QzV6Z0tZVVNV?=
 =?utf-8?B?T01EcmN6V3RqcDdZWEZxWVIzYVJPL2xvZ1VjRUNqdFlMSHdxaWJ6b0Q4RVl1?=
 =?utf-8?B?VUZ4em5TVHdFaVl0TSt3TmxzY3VSanR6RkJuOTNwd0RRUko1blMzSVRtYU0y?=
 =?utf-8?B?Z0hQbWt4RzRQL3hVWFIzYkhOREU2aHptbTdxb0FjQldRTythdTcyTTdhcjFl?=
 =?utf-8?B?RzBzNmFTMVk1Mlh0dnh6a3NrbjFJWWpJOXVuUDhrcklqdDV3NVlJOUJ4OFBK?=
 =?utf-8?B?Mk1zSFZuVExnbHp6RkhFUVVxSHpVRmo2S3V6QkdIcUprWmlzdEtVV3JvR25s?=
 =?utf-8?B?MFlrSjZLUGVhTDZlWE9GSDNEcXkvdVYrOVc2S0czL05NeXNkMWI4ajhSNlVq?=
 =?utf-8?B?S2ZKb3ZGd0F5VzZqOExXY2ZPY2pPczJDVC95WVB5Q3FUQVcvcDdYdlB6OVVE?=
 =?utf-8?B?eWZqckZQMi9DUEU4THhKM0dQRWhHdkRZa0NpZVNKd0ZSdGdvTDlQTnFEK0Fm?=
 =?utf-8?B?MXI0TEVyeFlMM3lleWI4QmptdTNlcisrck9UTXZsekRUUGtUUkFLaWJEL3Y2?=
 =?utf-8?B?VUxPakxMblFqZWx1ZmRXamZNUFZWWkhmSkJ6dDJWQi93RDVPMnpJQTdkVXYw?=
 =?utf-8?B?cTltdGZFQXNQbVpMTzNJWllyakJCTkQ0WFp5bzM5R1FrVkF6Y1d6RkliQ3Zs?=
 =?utf-8?B?UGxqbGZsQk9tQ3l2bVFoai9ablo2ZkRSd1J2Tmc1RzdaMDJwNVFwdEZOcXBC?=
 =?utf-8?B?WHovNFc3RUU4ZmFkcVk0TVZKamxJNUdkdlpLa0hhTEsvb2xTOEh2WUdTdHZq?=
 =?utf-8?B?N013aGFtQmcweWtkQ1RiOFRXcEUxUnBsY2ttbGllSWpPSmpvbWlMSXFqRGE1?=
 =?utf-8?B?TmpKa2srQUNVZ040Q1BGdzRQdi9UTGRNWE54eXZMaldXRjVJQmdyOE9DNWtD?=
 =?utf-8?B?akdGWWovMU4xNk9HcTd1cm1hK3JkSWxSaDJ5L25VNjZSbnNwOEd6cDNIRi9Q?=
 =?utf-8?B?ZnRPektVZlN6d2hVK0pWZFRWNktyUGNMczc1bXQ3OU9OQzNIOStrV083QWd0?=
 =?utf-8?B?Q1lJaktoQVpOeEpsZnVyWDlTenV4Q2dnNTkxUUlYUjBONUs1YW42WmxJT3pZ?=
 =?utf-8?B?Uk5EWUo0enZvb1FleDFQTzgwOUJCdVFwZVNhMEM4MnNLUjN1c2NHeHpHak82?=
 =?utf-8?B?NUFlZzh3TXZVd3p6dlFNWmtlMjBWOFdIMU4zNGR1U1d1cWtBWUQ2aTFyMkdU?=
 =?utf-8?B?eUJkZjhwdFhqdlphVkpRekhsbVJuY1BPWlVYa2JPeGFhTEhKbEZGWVRFSXVw?=
 =?utf-8?B?T05FYUYwUDJEYUJFT20yeHhUMGd3VDdiS2VSQlQ2VFJwYXBJMUNuZFBCMFll?=
 =?utf-8?B?QmhFZFJ0Nm81NCs3UHQvMFlWcEVuUURscDBaOThZc0VSRDJ6SVlnL21ya2tS?=
 =?utf-8?B?Z1JkRHdmYnkvdFQvNjNObFp6L1k5Zmp3RTljeEpWakhjTm96NWtPNEhRMkRX?=
 =?utf-8?B?d0dDN21qRUtnOTJFaXBkODdXR21scUZxSUw4VG8yTU1acWoyQ0pPVHZJR21r?=
 =?utf-8?B?SGNmYXlXOTdXaC9ENm9NSUx0VlYzRUQ4YVJ5VFhtVGsrblp3bUg2TjlKR0li?=
 =?utf-8?B?OHc5RVJCREFGZEdUVDdndzNEWXNscUgyOXNubFA0WHpZQ3NhSXd6SFJGbVV0?=
 =?utf-8?B?aUNjaFh5dkNXUGVSdEpxU1AxaVkyeEVXY2RDMmFNUFJMdjViejFna1RqeHE2?=
 =?utf-8?B?VnhuYTk4anpGWkQ4dUlvcDNzeUxqdktuM3VyTzNsZTlPVUNMTzVDb3YyNFFr?=
 =?utf-8?B?WDBQVjVSeGZDU0ozSEM1UjczOFlPS3M1eEJFN2VGcWEzYnpQTjZncmhOa3la?=
 =?utf-8?B?b1Y1b3FXUWhBY2NucDdKRXcxT1FqU0xuUTZod0o3R0hHRll2bmxQQUFJMVlz?=
 =?utf-8?Q?Z//5HnZ8fJyPfz7o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e178713-ce4f-4e19-b0d9-08de9c37e8df
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 04:15:08.0021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/OlH3S2HWICEPu4Zk2LUbf4XaEaOYokWeYuOo0IDQq81MhqOFX9kEVcaxrBwQElXNWHEH2cEBt85owFf1Z0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

On 4/16/26 8:57 PM, Alexandre Courbot wrote:
...
>> Yes, some conflicts, but probably not too bad, due to the much
>> newer base, right?
> 
> Most of the time, hopefully. But that's still labor shifted from us (as
> I would address the conflicts before merging the patches) to the
> drm-rust maintainers.

This point would carry some real weight, were it not for the fact that
one of the drm-rust maintainers is the one who suggested this approach!

Please let's take "yes" for an answer here.

...
> It's actually 4 weeks (from -rc6 to release, plus 2 weeks until -rc1).

I knew it felt longer than 20%. So yes, 40% of the year. This is a real
gap.

> 
> I agree it would be nice to improve the situation - I'm just not sure
> that keeping drm-rust-next open is the optimal solution here.

Me neither, but I'm *very* convinced that it is a solid improvement over
what we have been doing. I really don't see the case against doing this.


thanks,
-- 
John Hubbard

