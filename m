Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA70C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1BE10E41F;
	Fri,  7 Aug 2026 14:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="oS7kWMFD";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022085.outbound.protection.outlook.com [52.101.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804F810E41F
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd8kxnJKyNVtECeFanCaLhXDBn/ktgVdrwzhSXVcl+zPAc2YMzVhVcXnPMN+kvXeU0tBP2EgwlYOmeGbiwv8c3aAAJftXVrxN+1hFn60sAAP4rZ/OpcEGn6H9XE+k7dGDHtDuEHvTfIjn3Am1bHxt+iu2CM3RXyKdVf1mex2xD5GVrWYKT6Prtmaakuu59RP69A3Hin+i/Yun/6RoVDhKwAQrKA7dVbwmZ3QKnLZ4sA7GY1lqgeUnUnuEEUQ2COcfIt+UGsmobuaFQIvjDyjj7JEMR5hx8PamqeEjjNbVbueeCEbLzJgny6vz9Do0lCjtD8u2hdIbs9WM8wwZtb6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH/TMyEOp8vCdWsu8741PJyK49RZiXIG5EepoWIFO9c=;
 b=s1WEWwXa3EB7UX3v6Zid4R+wXSfRRQqthuGn1qkMNZncfXZT6jdU3a2KQEPtYtGrsR3iIHhJt+RQhtbMK+EoRoaefdp4Mkf6D3OLDUdW0NmwEarTZBqE+rn/etyKnu1wQ/XPuXVHfLEl7PClawJ13lTjwJdZELuovDnLo1Kz0sZqoR4fz6ysOEQ8MSRyW+7W9CzR+Av9uE7dHaBSHvgpG6E2+Zjpta/VfwyQaJLNb1vwLeZRgXFlYNKDUEUIBAWb9gIPudhQQrtTLeLtIix0IGFDIbmLUOj5ikR2AWwJjljb3e6mx/brpR5Baxu7YtYVtDt/+NqWZIuFfORUfWb3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH/TMyEOp8vCdWsu8741PJyK49RZiXIG5EepoWIFO9c=;
 b=oS7kWMFDIy9Xqpch07O8nWQND6wztyhhUmpOT8JdKDotPB52hG9pn09JnLxWYMkiWd006ewvSe6nHde2nwypsGFUawwfhDflqGqc2bVYFsLBLUL6JPg0R3ZcHPfCS4pSJW7aQGHed6eVv0je0VM82NYmfmjYhrjDI56uCTxwHcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7211.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 14:09:59 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:09:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 15:09:58 +0100
Message-Id: <DKIRSGJA6BM4.2D18NHUDLELEV@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 01/12] rust: io: add Region::try_subregion
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
 <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
 <DKIRN9CO8EGF.2U1743ODPICPU@nvidia.com>
In-Reply-To: <DKIRN9CO8EGF.2U1743ODPICPU@nvidia.com>
X-ClientProxiedBy: LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: cf547cab-a1fb-4a00-b80f-08def48d90b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|10070799003|22082099003|18002099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: NMxddiE3Y5FLyoHhq2OMKFvdhoHK4yBZQ4ytaKQ8BTUMkun/YhluzzEjv6CLfxYk9kb1pzCQua3i6wL/mwcvYqTCP3owZkZ0mCQyD7DibX9JSugW4a8Mq/ZN0+wxMpNKd9a4XlHxELf2L/bJIEX3sNiAFeE63emQc7IMmkUsfAC57qIhM1HW7Ktan363qbVGSBPQ2YZoEFV3kECXVd3zoRvo5K3xAM5qA7vpvdVFZ744Q9Fv2tofQgSuHd2X4nQQUI3fyRUViFIpG+Q9lOEwDQUc8UjlrjmUtMKKIW9pPM+LdMKRGkpF9y/UV4GjpNXc/bLvIu9VHjIYeKIo5AtqM0sRupM2lwGep6bxTHKEQvU5Qe3f7EL/Lj0WXdLoEZuerMhI4HgdBsSNNhJpySTd3Ixi9TwwWC5Ai8Z4uY7Drd2HfWZkSw6CmSNIVXNqdnRC7bxn7xZGApXXvwPj9L3aDNHg6F2o3Cd/3VYVhj0XUmGOe/ozfc0ATIhNwU60O6Df3xNpgH49Hci7ZqFXP9eleJXjJhE653KMs+hzG6NZs9bN8pl4an3GYjq79qJSGZxjqHbSFi2yO5+svaxV798xUuv/lpWb9C0LmgojJAQFxmJ1rH9UhAc22QsVJDE+wOU8nekzlJO5DAXEleSwQIpVnqp2Tv1URCNffAInlowg+8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVJWkhSSjBxNHFhZUx0Q2xKYmR2Z20wdXYxQXJsRnpKVkVZOHJMRGxmQVVk?=
 =?utf-8?B?V09OQVFzQXJJb3JRZTlTVmpGZy93Nk5lSVBIZDlCS1JLQjBkN3A1Tld1SFZ0?=
 =?utf-8?B?YkMxOU1kQThMQVRCQ3drRllaRzJyR1BVZjRZWlFkZngxbzhOdjh3RWlhRnVi?=
 =?utf-8?B?SWcrNTlKTE1vVWpPcHUxMnJ5TlN6YTlaK2plc1RhTkNLSnJXQ2ZlMjlrY0la?=
 =?utf-8?B?bGt3dW9hNE1vVXVTNWRpSnA2RHNwUzYzSVhETVBKN3Y0VFZzVmUzOTNBVGtT?=
 =?utf-8?B?N0tNL1I0SFpsUTF2TllXMnhYUndCZ3NpQVVDNjNvekpVM3d2RU9JYkRkaFlo?=
 =?utf-8?B?L1F5YmVnN3VhMGs5bThCaE50MldVZ3JkRVB5UEc4bGRSVWZoV0pHS0pKeE5o?=
 =?utf-8?B?OFp1S1l3T3Y4MWUvTUJpZngzSVQvNXNqamdOQTlKdVRYYTFLbzJCQlRqOTZq?=
 =?utf-8?B?ak5XL0ttT0s2N3k0dGNXSFl5UzZ2Vi9FcUQ2ckN4RXZWZUt3d0FwZFRYRmxh?=
 =?utf-8?B?cXhLMitXdmxvNjhialpJMVdROTRaa1R3UERJNjloQlNPMzZmbkpkcGwyL1da?=
 =?utf-8?B?UWp2WlFna0RaUithV2UzMWJZT05lUGpLYjZWbUl6TTFjUEt4c1drWHAwb1A0?=
 =?utf-8?B?aG1qVzJaa1RTcGdWVEhTR25UdkNTZXJsVUx4K0dhYjR0OXIyazQ5TmJmeGdS?=
 =?utf-8?B?UnZlODJLSGg4azFOSmNjMkdZN1lJYUphQ3N0Vnh3L0pSbk1VZHc5Q0tBV3Z1?=
 =?utf-8?B?T3dtU1pYbHlRdnVvby9YWDBSSzlETGRBUzlFNUZzVnN0Zy96a0ZzWXV1MTQw?=
 =?utf-8?B?V085TTMwTVBXZ29NZXI1bUN3aGdoR1NjTWkyOUcrQzQ2cTdTT1pJVFNpVytH?=
 =?utf-8?B?bmZZSEZ2Q1BwbnJnZ2FiQUNURDNpN2tOUUlNcWFvNlBwblhFOEJnbFg2Vnhv?=
 =?utf-8?B?dnpHc2s2eGczU1d0QlExVjZqM0xEUWY2YTc4SGxJR2ltWE90QjJGTlV3Z05N?=
 =?utf-8?B?M1NxUjRZU0tza2ZtdXpkODY3bE5ITzg1R2N5NnY3WEdlNHNDbVNwVVhab0Ji?=
 =?utf-8?B?bDBySzZUOHdKenlSRmwzRTVvNVVHRUl3WXc1b2V2TzR5MkNFMUpLdG51L2l2?=
 =?utf-8?B?b1N1K0ZDSm4zK3FlUzJqdzNCVDZoRTczOHc2cTNiZjJRUG5GeFpkQ1dNakl2?=
 =?utf-8?B?RFFac0VFWE1SVGdnaU8xRjhPMWY5OGluWUJ0OVNqcFY2R0dxaWtzSVFSellE?=
 =?utf-8?B?VGU0SGJOOUJ2OG1YVjMwa0xZSHRmNFlLeEZyYkZqKzJtMW12Y2hTS2lLbXBl?=
 =?utf-8?B?RzgybXgwcUorcGE5NCsrMHluR2xxZkFVcWdYUU96c2tGcnlCeXdkRnpzOTRV?=
 =?utf-8?B?aXl0NC9jZjFTcG9QZUtQbnhmWTZucWdyQ1lFRU54U3FucUlQLy9INXZ6V1FO?=
 =?utf-8?B?dGd1dzlmMjg1WTBhYnQrdkxMb3hObnpFTzVrL2dPMDlXTVZWRGx0YkF1T2NK?=
 =?utf-8?B?b1IzL1NsQjJEKzhxVENRKzBhc0RwdE5OZHU3b1lvN25GMnkvdHRtOFdRUlJs?=
 =?utf-8?B?TDZZYmNFRjJBUDZIK0xMMjJWNU5jNmh3RVNRWXpLRWlkVmtCbkIzMHVUZFFw?=
 =?utf-8?B?ZXdHck1ScEM2MFJsNXVzUC9qaXJnWlBncEpuWnJrZWZSS3Z0a0tYeW5xdmtH?=
 =?utf-8?B?NVErUjZMWEV2UGFqd0dNK2dVZXhlMWZWTU0xVGI4ZG0vN0d0VmVmNUYvRHNl?=
 =?utf-8?B?RnMzaXJrVU9XOG1rWHJaSHBOSjZMWkpCc29IK1ZMK0ZYNE1odTdxTHorMTF6?=
 =?utf-8?B?NTR0N1lDZU5meUdpeis1b05JaHB4R1gxVUpOV0Z4anFaVU9RT3d4a2JsYW1a?=
 =?utf-8?B?bzhMczJtSEtsZjl2UnpBdlhXOG9vQm11QmhmWW1INlZXZU03elFVY1RHdEU1?=
 =?utf-8?B?a0FyeG9Fc0s0SDF5dzFuSVhuM1BNdVdqeGp2YnhUSFZsSS9uYkVvcElMQ0hW?=
 =?utf-8?B?NmRRVTV6eXR0eU9FMSs5Y2JsMjJpRDMxQzM0MGJLWHBpQ2xYUE81TmVNWFMy?=
 =?utf-8?B?SCs0cGZNOFNSdjBmcVcrRGsvQlF6MyswSzV1QXpvejZQOTZjbkt4Rm43NUhq?=
 =?utf-8?B?TnMvb3lMdWx0amRZZW5nQzl5QzBBRzU4OHRUK1RSdXZmeWs2SnpiWGV4Vndo?=
 =?utf-8?B?dVUvS0pBL2dzU09zb3k4YWdkYkpURko3eUxweU8yc1VIZG5ObXhVdktva2tm?=
 =?utf-8?B?UU5VYStHQWJJVTQ1aVJrWkZaU3h6ZDFsU0N1QUdCeUw0cDdLbGVBQkpOUWIx?=
 =?utf-8?B?VjYzQnNLSzJpVGJZL2E0dTJianIrbk42SDlMVUtsd2RpU3hTalpuZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cf547cab-a1fb-4a00-b80f-08def48d90b4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:09:58.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAtAQMe/v4oszs+tSQBn0QZR0EhSekL9HEWhZUHvI3QiV7KX0IPsBjUsSpP9sQpjUSI9mscVKdn82aSzqJkRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7211
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

On Fri Aug 7, 2026 at 3:03 PM BST, Alexandre Courbot wrote:
> On Wed Aug 5, 2026 at 7:43 PM JST, Gary Guo wrote:
>> On Wed Aug 5, 2026 at 6:44 AM BST, Eliot Courtney wrote:
>>> Add a helper to get a subregion of an IO view fallibly.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> Looks like the case where you need this don't actually require a `Region=
`
>> (dynamically sized type) but rather a fixed size window?
>>
>> In that case the next version of
>> https://lore.kernel.org/rust-for-linux/20260721-typed_register-v1-0-452d=
72b60262@garyguo.net/
>> will contain what you need.
>
> Looks like we are going to need to full series (or at least until and
> including patch 11) before this can get in. Gary, what tree are you
> planning to merge the register projection series into? It would be nice
> if we could do it in a way that makes it possible for this series to be
> merged shortly after (either through `drm-rust-next`, or a merged signed
> tag) for the next cycle.

I think a topic branch next cycle would be the best approach. That said, gi=
ven
that all non-sample drivers using it is drm, this can be taken through drm-=
rust
too. I guess it's Danilo's call.

Best,
Gary
