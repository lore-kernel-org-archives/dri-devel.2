Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F7F433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E636410E76C;
	Wed, 15 Apr 2026 23:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5PM8wFr";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A1910E76C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:18:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICb6z/KaCYK5DbPdpHmuudfnXtBWSYTD3vJWWmcJHxd6NcsHuEaMJuLZTxxuHeVugixeA+vuTxExm/TzbBUgIpMVFwKeIHzZgmR5/0pMYaXty+pv85CJhD94fzXVS+ZLbak28+k0top+PCnniwygw0OR4DsyIrP0O15mhBDjyAUM1l8H47rXxYewuLvcp4V27Mri8aia4SXOmik57iIf8GwP8+5+gvlSa1EfOhHDYXcTSiZ+V5tYw843JGhGp0S32bGCjyzaYNBBhLxSRIAFIHtW+UTQmBeSz/Im8Hh4IvIRFukJxGMuu3b8cVH6iVd5ktw9niPmkQIwzmgVFRJTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCFRfmayijSdLsI0nRO+S4mduQDG4PEcA0Zcc2nyVek=;
 b=fx62MkRCTisUDgtwAq5O8v1r1bCI8WiuN1exyzl8E/m9oNwJcLt2ElfZKPg3yYOAvj7VV0GJWtQiufiF5BeSa6tvc9qr2mZ71vkfkgLZdjoWnjwKKbUTe+BWzfkED4sEc+NfD7Lt9DyjeY6ouBDOC//e87V+WLE6Jos7sYTbpJJT6fkOAYkKFWSsVHPG4/Aab+4+nFaHDnOYieEkwUatmEekAaA7Nb7joiNx1bsSExlnKcUKNidoGKnT/QNYqr3N1uZIjI/d/exuG7d1Kv1/x+JCaGgn6wPa1rL9E5tTMEKVaZhxpIlRMyk8sKkyIoHuEcln4DUX9k8YCIEohOYDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCFRfmayijSdLsI0nRO+S4mduQDG4PEcA0Zcc2nyVek=;
 b=n5PM8wFr5O21Wg+NAZuZISOG6Yq2Td8SBLoZwwRspcjjKAevGTqBYqL5Ebg07SjndHzRt6mXSuTVq+U0GKoXwkre43RaXO6JjMbvjVhHbviMBjYNDnBrgNYAJGA6tQMo86xWY4CCyryYGnNPWAPJ9yTGI3zFN58ui7m2ZTdLFcndcG4cwnubdo4BqUkDWefDZavkBTpihKm2ENvQhP26ZyQHH0KmXMi5c02fDFCrUAX9p+rjAhcUxLgk0AsZNBva0hMMB7IRrROZKH3kKqAd6svQS8U+lgKol2CgWa8CH8cE0ujr7XPo4P/xzg/u3QhHz7VC33VitrSkuYm1vUuWgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.33; Wed, 15 Apr 2026 23:18:03 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 23:18:02 +0000
Message-ID: <a221aadf-a953-4fed-912a-11fbd16b65ae@nvidia.com>
Date: Wed, 15 Apr 2026 16:18:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
 <DHRO963VKBJG.1RNNN4EJ791PP@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DHRO963VKBJG.1RNNN4EJ791PP@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: fac2db09-6d87-43c9-24f9-08de9b453dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LhMzvRP0HBCbYlVIWbZXaIU6Api7huXJ/PQzjfrkrhWGKAxEjfBccqKZAZXrcqE40Ze0mRdpA+YmOGaRS/JP2nfE+mhB6ZTG5sNqzuN+oObmvrj7VhxIN+RhmNaykCX045nDGZJ68ijmT4TsSmm6wYOgNvIwXCQvOhj9O7TsscB3Kb2U30gM7FytZ+lBx2R5oFzpMjfmdrjRlsNpcSxRVj0EjLeE0FLvmKhdoHk7FXBfmmh3UHeUP08vcqKziEiM3XN5OjMP5mVF6xQXP0xq1VyOJgZqt8v0pEjg733K174VC88+RIM9zf70r5vWKgAsNvWAWZXJTbnvCTVV2JTxmvZaSmrrv38zAIMyMQNEof6AakqEoOs+zRlcZFmEKW4MqMmwWpVbK4hSAxIOQr972DSIuFGfYZWSxcBNkfADiKZ8er73o7/NVsVR7Gk17bBayVhQN+2UZ/l9OvmCnlZrRXw0uNFTqEeBGh2YShgnM1L9k4ypE2VakS6sYeK9D9x0fEJ7+STpv0/3EI4UtMnM4zydaKJRLcLITUtfVwPJcqx21JTfG9W2Z1GguiXYMG41IWT70A8l0wMB+beHmTqFHwJ5fneyGbc/LaD4b4I61yxBtcKh8CWOYpiKSqlyCBHVD2KKxWPJkX8HL0l0ZpyLe4IC4HQ0ANKbu/AaqNZHfiUwzORlE/B4q1HT5MMinskILtk91aUCk6P87iaoH2e7B99UTywW4E5MAuFsNVLi6vlomZ7Yci0YuOhbD3c2AzMUtTsKlvgYM3Tb2QjNQzkheA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFVtdlROTmxoTmxSaVBrdXUxYjZzVm1RQTk1TXVHL3Z1czJtZnAzbDNUTUR2?=
 =?utf-8?B?YlZlUzdFRTdQQ1FmY0JsbmhYN3RSZFZUT25DK0ZaYU1VVXJVOWp1cE9sbktj?=
 =?utf-8?B?ZDdCbE1ZMU5DdW10Sm1mb1R2dzlQSitiM3RzREhuajU0OW5NYmdCL2thR2VF?=
 =?utf-8?B?bUhzQU5MUURxeDBqbzdwMkZ4WVJweExwREhVY1Y4V2c5YkJGbTZ1eGFPZmpI?=
 =?utf-8?B?U0Yxak43UHp0c21peW1LWjIvVnFncStGcmowQTI1OFFDSml1R3BnZk10bk5k?=
 =?utf-8?B?eVJGYlF1NmlCOERabnN4cWRTMllBRDB0dmp3WTRFTGVkcmN5eHJHMFdSc2JU?=
 =?utf-8?B?cmJKMnFYdi9XOUdSZmJQK2VYUmNpYWdScytEaUkyTWNJVTN0YnVTRDFReUJy?=
 =?utf-8?B?eHVsbStueTQ3R1A5d3dGZ0xEUklpVldqMUg3alVWRnNLWnpvZmVnK0NRejc4?=
 =?utf-8?B?YzhMbGIveDBLbmdIMjFsRUd0em9PK3BxY2ZVMy9pOE91c0RyeWxWN1l5c1E5?=
 =?utf-8?B?UlljdTJMV09zcGJKV2tqbFNENjh5R0ZQWmxuUUlMZ2x3bnp6SzROOGJyMFJo?=
 =?utf-8?B?QWdQOUdpT2JyU0UzczVOY3pCY2JFQzZJQWZzRjhJVWhOUGdnSkIyNXVpRGlM?=
 =?utf-8?B?SnJwMHNVVkV6dlVxTFBKbVF3cDJndGMrWnkyeE9JbUV5QmMxUjVqUWlORDky?=
 =?utf-8?B?RFlEL1dnWnJaYi9TelRGekdxTDFqNC9Ybll1L0ZPTnVJeCtGZGlNNFQwZHNl?=
 =?utf-8?B?MjhNeDYwd0FWcGI0SG44Y3dWS3pOdHFpMG9aVzk5a1BMWk5jTmdpUkFScFA0?=
 =?utf-8?B?UzdBdXo0aGpYVnNUT1dSVmQ2QVFubzhRMnFoV0Z4amxJU25UYS9nNlZHSzBj?=
 =?utf-8?B?UHk5YUNlcDJOdnBqUDVWOWJuUzZvWlZZRDVHTzl2ejM2SncyZ0NTdThPNGxG?=
 =?utf-8?B?N3ZJbzNocVFiLzdyUndINHNqM2tGMXkramJBZHdZenQ5ZG0rZUZJM3gwWlVP?=
 =?utf-8?B?UGRFSDdVMWJrN1ZtQnl5MjUwUTZ0NzVUQWdNVWR5VE9EWktkRDhzUzdIR0xt?=
 =?utf-8?B?SXJ3TkQrU1BBU0t4ejVjeDQyMjhCSDBVeU5oS0Q0UjRQVHd4ZTFva25GcGxk?=
 =?utf-8?B?cDhvajg1S29PWFFKZmN2c1FxQ3FaNG1nV29qQlJQV3FhWk9RbkQwbGR3Mm1I?=
 =?utf-8?B?YmszUmJtTDNjQWRHZ3ExQjlRbkprT1M2dVJPNTZqRTJsc09TR3YrOVM0OStJ?=
 =?utf-8?B?clNpOEE1ZkNNY0cxYWFXMFNmODI4emM0c3ZRVHJEZjFKdW4raW05RW5ENUFj?=
 =?utf-8?B?VFNzelBCbm42WkJhZG5rckNKNWE3alpJaEl2OWZ2amNHb0R5QzI4eUdHU203?=
 =?utf-8?B?L0JTVFhoQm8vdWFNWTBXZ0dZekZRd3MvWDBTZE0wYlJKLytaWWswWlA0THNs?=
 =?utf-8?B?MjVNdGVXb25xZXlhQTFCbEM5Lyt5SWF4b2ZBbHo0U251bHlHbDlJRGNobGZV?=
 =?utf-8?B?VWIrdVVGVmtreEYybU5XcUdGNEJZcEdvcXJrRzdQTVR1S25SR1Y1R3gzcXA0?=
 =?utf-8?B?cUlhLy9lTUEzS211cmwwL1hGQUpHaFhIR0MwTUZwQlZQNFpwTS94N3RmRWYw?=
 =?utf-8?B?L3gvNzJsRTl5UEZKSzBUNlVVRlFPZ2ZXMTF5TzRocTkzZTE5cWsrSjR6ZUM4?=
 =?utf-8?B?bnp4cERjMjhPYVR0SXU4RXRDLzNJc1MzUXRXOXFBTEEyeEhnQnVpa1I1NmFm?=
 =?utf-8?B?YU9RMGpZVS84eklmczB0YzU1VHEvL0JTZFhBL3Bwak9mcVlpcWVGNjZOYUk1?=
 =?utf-8?B?SlhBZ2l0b2FUbkJLZDBrMmpqVklvc2hUQzVpRXJLTjJkZnV2VnRXQjJKamEy?=
 =?utf-8?B?cllIdC9MUzJpYmlHK290RHpCSmx5RlloemlVWmZzMENVeXB6SVp0Z1dha2JZ?=
 =?utf-8?B?V241bkFMQVYwWUN4M0gzMVdpd1Uvc0JLUm45ZWsvQXI2cDBwMDhBTkxad2tr?=
 =?utf-8?B?NFFIZDc0aDlkMkduaUdaVnpsc1pzRm9IdGlJMUNDcTROVzlIcGQxLzFkL1dw?=
 =?utf-8?B?dnVLMGlRcGYrUEFrd1k4QmpqbHBlV29iYVhWRzBUS2FnaUhrN0pnRmFxMXFm?=
 =?utf-8?B?SGFXcld6N29obU5jUjRpWHphcW5kRG5Fc0hRbGhvRHp2WjBrbXkzcXBubTdv?=
 =?utf-8?B?RUI0a2g0T1FwVERaTUtaUE5RSjlCamRTbFRybXdhQVIrLzFQcmppanZHUHZy?=
 =?utf-8?B?UE9ROW1tTUlwMkpYYnpMcU9OMk5SWVhXeTJQQTVING16amFzNWNCdm5nTEdt?=
 =?utf-8?B?STcxa1IyKzRhRUZUeERSd3hld3VaYU8wRWNwUmJQVXh2Nkx1U2F1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2db09-6d87-43c9-24f9-08de9b453dcc
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 23:18:02.7733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6Uih1mvla1zHipKhua20h5JWg1Ki451VDaZ8cLEJI3II+TAxV4qcp4q8IurQGPK3xFFB04C2ODBd5na0wwE2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
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

On 4/12/26 7:29 PM, Eliot Courtney wrote:
> On Thu Apr 9, 2026 at 11:58 PM JST, Alexandre Courbot wrote:
...
> In the nova version of bitfield we had @check_field_bounds. If we put
> in the bit numbers the wrong way around, this patch gives a compile
> error like:
> 
> ```
> attempt to compute `4_u32 - 7_u32`, which would overflow
> ```
> 
> The original nova version looks like it used build_assert, but I think
> we can do it with const assert!, so we should be able to get a better
> build error message for this case:
> 
> ```
> const _: () = assert!($hi >= $lo, "bitfield: hi bit must be >= lo bit");
> ```
> 
> With just that we get an extra build error, although it still spams the
> confusing build error. We could also consider adding a function like:
> 
> ```
> pub const fn bitfield_width(hi: u32, lo: u32) -> u32 {
>   assert!(hi >= lo, "bitfield: hi bit must be >= lo bit");
>   hi + 1 - lo
> }
> ```
> 
> Using this instead gets rid of some confusing build errors since we can
> also use it in type bounds. But to get rid of all of them we would need
> to do it for the mask etc and others.
> 
> WDYT?

Just an admin note: if you do any or all of the above, please let's make
it a separate patch, so that this first patch remains just a "move the
code" (almost, anyway).


thanks,
-- 
John Hubbard

