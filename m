Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B499C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9484710E5E3;
	Tue, 25 Aug 2026 08:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2VzKgTm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BCC10E5E3;
 Tue, 25 Aug 2026 08:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWEB4oq0YybT4gVReig+o+U2OZ9xxvWH6wjjQ9sivHWtLm6GkgSX2M/U2j7Ov+jrPOP+4ty/MqzVyz6bMGHeWosXvt1eHpbdbb+yl4yhrpOtCa+iGkjx5AM6EYaxFAQNTtp1s5IYXSNuEp1k5CHW9UYiBsdjNFNx49/h7JpYK/vuMOm6/N+X6SNBjsVNo97Z2ExVwTE6zmRP2igYoeeuyo7oGhG16xDTLsMJIuGkizJ3vqCTGOmJWRHa0xtRQ+50yAdS58sbLOV8jx0ooTOuDHgkcIkA4Im7nWCCGyoNM4FVLkJKW/b4fbqIpvLbe1GCTbHDIkxJ+6yABgMYcjt0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkSm9O+7waSsZ7Hy+PjQLWUJLZmFbRzZY61UasaSNNM=;
 b=w0fkir+5Yq7pYxpCk7JqKk/S6G0wvASiKhGloWUBUeV5EHS5y89tez2VWEXgDHs2PDTOvgV3YlOEYmdagHfwkcOkeIx0rBnxJ7XHExYMFIdVKMLUNtqSUqt8ssasFIWQhmno5y0fU8ApGJ559fJN5AFHkJydVN44EjoQsbvlRHv06pUKOXvR52wA6hAIhRjepCuBOf+SiSZpbbJN3VeGVlYH0ycdMXSNaAck4J5DbYjw14ZMAO6U7bnX+SPwJ1SxrFRiETZmbw5yWiNt6ttEcD4Rou7QBseilwLxO90CgwV0W8BkmXTc95sh0vR7zeKiIcr6TeRU+Uneiz1rY03zzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkSm9O+7waSsZ7Hy+PjQLWUJLZmFbRzZY61UasaSNNM=;
 b=c2VzKgTmQTHGGvTvxro/UNBZOidNTUmZIp0Vx1xfd4EJptRpeXyYEJmMqJiH4kX5H9+f/8sG5WxGELaOZYbcqmKHrDULdopr+JtaJcmmmXwuhDBUv+HU7i84iLdy6Pjr+MREqDOw9G62q978jfKE9aVuMUqHTIU52PiNpNhMZlTwtlmoaVhP0pM2m0zc2Tf+bMzVZZ1CqJy0Xqvrswvkbk+Ooo+ESi05cPodmAqLJzVBrmufgMG092+rgJ8vGJ6ADH7bzdykgpYzktGDWh05xQNO9W37LdWrH9k9hsVXCa/fISrwCehpokRL2nd58e5QOjFEfdab+3cFT2BmgtKN5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Tue, 25 Aug 2026 08:33:45 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:33:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 17:33:41 +0900
Message-Id: <DKXVWSQ8Q627.31HTY1KERFBR8@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
 <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
In-Reply-To: <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
X-ClientProxiedBy: TY4P301CA0122.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: e56c6e60-aecc-428a-9567-08df02839379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fe/14BXmQYcJQgGdlvjmpFgWvII9o3VOj0KKF2BHT7NvUpB8XqxFNt8n/sxrRSTvGYsiusYGBUAtFyizqujTW86dcwaDv0Ax0kDzwDRJbPXyMtfYzY6dtTGsKH9o0sJE19UEKzNsZM4vq30WWkGHPlD4uLGsKcAVc/+kXva3Cy1/orCPBX4Fm1XL0WrJVxvdynBuIga1g/1cWboeJNjHaLwyr+gGagNX3YyOfVO3RPS+5cxvpbg8XG1ddC1ETOIyKGctJqBd+KeXibk46N6rVUWS4rAY9K4DJU9NU8lDND9VPvJEga75J82mQHD+2XnQmJCPQLiTjQ6judAm0sAHdcDju2xDEdNBtxeaJGQCTWFmyKkKhWFzHhmKfgf02etwdzKnaMdVhkvOKIsFDWl8xjqFa3ia8SzXP5h2CVZqLtVZlhr27o6yt0hG8+t5uLTMb/CpHoVVl9l3CIVEqhcFs636tFXx0SELF/0MCH04q55mHfrt+UjTjK57scqQSPQIYPhrqmfg4c4kaygWZt7LdQkE7y02BgtPxJX/0zdm3XUBOVuJ8UFzPF7Mv2QVjJlzNHFhLEqcaRVR+vvLDMNrq4HA2CEDKmgLzw12KHqWDhz+D33zR2zaEY1+GcYBiWAS9xSD0oPi4+ZaA+1hXH4EZ/NQMxVLgkGf7H98OQylGU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZJUis0QkJKTWZtK2JWbmlLRURTUFJXQ0RvYjJYNWNSVkMrVVlVQXlVKzJm?=
 =?utf-8?B?VksvYkFzOU44TUFzeXRwb25GaG5EMnl1M2VaNm1sM0tRN2NBL0VUVU9xSXZo?=
 =?utf-8?B?MitjdExCdTRuWC81WHMybDgxQ0Q2ZkZTUm9ZMEgvUkRFVnV2YS9uY04vTXNz?=
 =?utf-8?B?aldHc2dDRUV6MFl4cmVLMmxtVkkrb1BOZTdEUjNWeTU4eXgxa2FwYVBiSFIv?=
 =?utf-8?B?VklQLzdTQkxYLzAwdU1vK0s4ZlhUdERxaGhRVHRnSXUwU2cybjgxUnB0VXA4?=
 =?utf-8?B?cExnRmplYWFML2R1NVRoeng5ZUZWYm96dTByVy9uMERaR1VuV29TYVA5aGxw?=
 =?utf-8?B?a1l3UVdMNGVaTHJQSkF4MjZGRTl0TkxsTGJ0dXhDc1RMYTFsWkxrRFlSV2dJ?=
 =?utf-8?B?Qk1ZdEtJWi9lOVkxd2swdHVzeE5SamkvY3E5blVjbVovek92ZkdvQzhSM05Q?=
 =?utf-8?B?ek9Zb3R6RUp6WDV5eG4zSksxRG1MdC94UDBlQ3Vxc0VmQmZvWlE5aExzM09G?=
 =?utf-8?B?VDUrbS9VR2V6d0IvYndoTEVrTldzNDRwRmpsdVc3S1J1S3BGdTUyMCtsMGdr?=
 =?utf-8?B?U05HZG9sQm4xRk4vMGU1ZGt3M2gvdWVJSzkwTndzZ042NG03RlJySkR5NWdh?=
 =?utf-8?B?RVVXNHFGTEZRQngrbWNjRjkrYlZnN0FjVHVDQlB1MnluUzJYb1RaT05IS3BN?=
 =?utf-8?B?YVBKejh4b3htVktJV0NsZXdRekFiU1pJMEFqSURpVlg0ZUFJdlZXVkFaNjFK?=
 =?utf-8?B?V2JLUE52VU1helVNczlhQitIeTRCeWZNSzAzMWFhbEJOT0pPcTdRMlI3b2RK?=
 =?utf-8?B?WTFWTzhRVjV0bnArekVBTmFuSm1MWUhCMW5SOHlRV1R4QkRCZHFkTUFTbCtx?=
 =?utf-8?B?cGh6dFhkUU1WWHMrMitlQUMwT1hpbHE5VnBocU14Q1hVZHNGM1lDNG1XNEhJ?=
 =?utf-8?B?M0MzSkxGMEtNK0NUcVV0UXNiUlJZTVRleHdGQjk0bCtHYVdnSVA0R3RSOXFB?=
 =?utf-8?B?Z1Y2YmdQcnJQamlNazVZSFQzTW84OG14d3RUemoxN2NRQ3F5NDZtSk5tWW1v?=
 =?utf-8?B?QjI4YjN0OFo4ZzZLQWNHTlVtSSsrcUNvN3pWR205Ny9zbWJmL08xSlBvY1Zi?=
 =?utf-8?B?dmNzRVlEMHA5NTEyK0trdVZzaVV5NXlRU2VEa3p5UWg4Tnovelc3bWdYSzVB?=
 =?utf-8?B?UU9EZWt0YzBMQkd6dmtwNm1HM3Q2R1VpWDE0cHpmbTVXc0JLYzZleTVqSzM1?=
 =?utf-8?B?TCtpR21PcVRnVzFEaFhMcFl4Qll0SUpOVHFUT0h5cnB6bU9JK1pTMTdrSVZx?=
 =?utf-8?B?YzNqdktwNDREdzhnU2M1UGZqdGZ0Sk1TeVhXSmk5allERUVaSTZhU3pMc2ZJ?=
 =?utf-8?B?aGhvNDdsTVgvR0M5ME02clBBSDN5eFVhcjNrUE5nZ1VQdzNyR0hja1dQQm82?=
 =?utf-8?B?SlUrZXBaNFArSEVxVndhQmVqVWt1aHZuZkpic1E2ZjcvcDRlbjYzVDBFVnh0?=
 =?utf-8?B?Y1licVZTV01XdUdFUDJ5YWFvSlRPYkdQajg2M2FhZ20xQUI3aCtqYmxOSUR2?=
 =?utf-8?B?eEp2cFo3RjFjbW5GZm9RNEQ5ZGdJWVJKYUlGOGVORUJSQ0drVFpPNjV5OUtB?=
 =?utf-8?B?WjhSWVZzOTQ2eFdTTURkdXJoMlZiZXN3WkpkN2tFeHgzK2Q2b2Q4Q1JNZWRu?=
 =?utf-8?B?Tk9mTnhWdHkvbk8xd0xBUlkrNGxLR1VRdWwxTS9NY3R0NUZUTzgzbFJKSzFU?=
 =?utf-8?B?bmpSWWxrZ0xRaGxLbER4REE4VFJOeUIwV2phZlQ2YityL3RSeWVNN3FHaHFn?=
 =?utf-8?B?YzBGOGtlRkF1V256QUt3WE9KVkt0aEJvT2xjT1FhQWY1MUVqSjg1UVdsN1Bq?=
 =?utf-8?B?Z01hNjYvZWJaYVZtQWpmRFpoMG5zRjV0MUVEZVlFbGpubUpJUmhQc0VvZ0ly?=
 =?utf-8?B?WTJoa2I3OG9sTi9QMnJKZ0lIME1jQ0lrOUVVMFIyYWV1RFRrVGYyRVpCbExy?=
 =?utf-8?B?QjN4UkVKbm5FOGtmS0hJaTVvaXVsWG5BTFRvcjVTdlBQYkx6SlVKWDYvQjJL?=
 =?utf-8?B?ellUWW1QREsvN0NKYnZkb0VKMncxRU5ldnBSSjh0NUVPejZCdGhpdjlvaVhP?=
 =?utf-8?B?ZWhGeExiTnNjZitlN1ZVMzV2ejcxZmt2TnRQckpUVzVQU2J0clA3NlJYYXh6?=
 =?utf-8?B?VGdhTWc3NHAzdnBYODQ0MmVSRXhHK0FpdzhvWjZQRVFpbGVGTFlqVk14MEJV?=
 =?utf-8?B?aFlLRmUwekZzNjhsMlBoQmFJMzJuSCt0di94MGJ5Si9Ja0FCdUs0UU1VbjdY?=
 =?utf-8?B?bm5PQnNWbkpicjdBMVE5cXljRWV1eEZNNXQzMHppY0Q0RFdBR0I4MVpxQVZM?=
 =?utf-8?Q?+IGdKiOgbEkfKgo2XYAZwpuYQ6LtccYLBwRl2smyq3kuB?=
X-MS-Exchange-AntiSpam-MessageData-1: kHljYAbhrmgDpg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56c6e60-aecc-428a-9567-08df02839379
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:33:44.9360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eOCSQkcv/ApNXtV5orphQVSNratiZSP0IbitXx4laSzpUdAYESfj3NjhFaDFAstJ6x3noVlkjvFFBAwlH/Q9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

On Fri Aug 21, 2026 at 5:11 PM JST, Alexandre Courbot wrote:
> On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
>> Add bindings for area operations on bitmaps. Each one is
>> made safe by adding some extra checks compared to the underlying C code
>> (for example, checking bounds) and with additional checks to catch
>> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>>
>> Add tests demonstrating the edge cases.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/bitmap.rs | 242 +++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 240 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>> index fdcfc0409773..a4997022ff0f 100644
>> --- a/rust/kernel/bitmap.rs
>> +++ b/rust/kernel/bitmap.rs
>> @@ -10,7 +10,11 @@
>>  use crate::bindings;
>>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>>  use crate::pr_err;
>> -use core::ptr::NonNull;
>> +use crate::ptr::Alignment;
>> +use core::{
>> +    num::NonZero,
>> +    ptr::NonNull, //
>> +};
>> =20
>>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>>  ///
>> @@ -523,13 +527,160 @@ pub fn next_zero_bit(&self, start: usize) -> Opti=
on<usize> {
>>              Some(index)
>>          }
>>      }
>> +
>> +    /// Finds a contiguous area of `nbits` zero bits at or after `start=
`, where the area plus
>> +    /// `align_offset` is aligned to `align`.
>> +    ///
>> +    /// Returns the bit index of the start of the area, or [`None`] if =
no such area fitting in
>> +    /// the bitmap exists.
>> +    ///
>> +    /// The returned index plus `align_offset` is a multiple of `align`=
.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is=
 out of bounds.
>> +    #[inline]
>> +    pub fn next_zero_area_off(
>> +        &self,
>> +        start: usize,
>> +        nbits: NonZero<usize>,
>> +        align: Alignment,
>> +        align_offset: usize,
>> +    ) -> Option<usize> {
>> +        bitmap_assert!(
>> +            start < self.len(),
>> +            "`start` must be < {}, was {}",
>> +            self.len(),
>> +            start
>> +        );
>
> Do we need to potentially panic here if `start >=3D self.len()`? The
> question "is there an area of `nbits` bits after my bounds" can be
> answered by "there is `None`" without semantically sounding weird; and
> this test doesn't cover `start + nbits >=3D self.len()`, which should
> logically also be considered to be consistent. It seems like the C API
> also tolerates this, so as this is not a safety issue I guess the Rust
> one should do the same?
>
> If anything I'd say we should remove these tests from
> `next_bit`/`next_zero_bit` as well.
>
> Mutating methods should definitely keep that check, but for querying
> this looks like a legitimate way to use the API.

Yeah, I am following the convention of this file - e.g. `next_zero_bit`
has this same check as you have noted, presumably because these bindings
want to consider calling with start >=3D self.len() to be not intended
behaviour that's worth warning on? I personally don't mind, but I think
we should either have it on all of them or on none of them. For now, I
have kept them in to match the file convention but we could remove them
or convert to debug_assert! in a follow-up?

>
>> +
>> +        let nr =3D u32::try_from(nbits.get()).ok()?;
>> +        let align_mask =3D align.as_usize() - 1;
>> +
>> +        // The C alignment and end arithmetic must not overflow, or it =
can read out of bounds.
>> +        // Overflow is only possible on 32-bit.
>> +        #[cfg(not(CONFIG_64BIT))]
>> +        align_mask
>> +            .checked_add(self.len())?
>> +            .checked_add(nbits.get())?;
>
> Is it ok to not consider `align_offset` here? The C code adds it, and
> the result could overflow on large values, even on 64-bit.

It is ok not to consider it but the reason is very subtle. The tldr is
that align_offset only affects the important value by at most
`align_mask`.

Here is the latest `bitmap_find_next_zero_area_off` code on
bitmap-for-next:
```
unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
					     unsigned long size,
					     unsigned long start,
					     unsigned int nr,
					     unsigned long align_mask,
					     unsigned long align_offset)
{
	unsigned long end, i, off;

	for_each_clear_bit_from(start, map, size) {
		start =3D __ALIGN_MASK(start + align_offset, align_mask) - align_offset;
		end =3D start + nr;
		if (end > size)
			break;

		off =3D round_down(start, BITS_PER_LONG);
		i =3D find_last_bit(map + start / BITS_PER_LONG, end - off) + off;
		if (i >=3D end || i < start)
			return start;

		start =3D i;
	}

	return size;
}
```

It has
```
start =3D __ALIGN_MASK(start + align_offset, align_mask) - align_offset;
```

__ALIGN_MASK does this:
```
(((x) + (mask)) & ~(mask))
```

So it's

```
((start + align_offset + align_mask) & ~align_mask) - align_offset
```

A & ~B where B is (2**k - 1) =3D=3D A - A % 2**k, so we have

```
start + align_offset + align_mask - (start + align_offset + align_mask)%2**=
k - align_offset
```

So you can cancel the two align_offsets and get

```
start + align_mask - (start + align_offset + align_mask)%2**k
```

Since (start + align_offset + align_mask)%2**k <=3D align_mask, the only
way you can overflow your expression is through align_mask, not
align_offset. The upper bound of the expression is start' <=3D `start +
align_mask`.

We get the overflow/OOB read path if end overflows so `if (end > size)`
becomes wrong. `for_each_clear_bit_from` guarantees that start < size in
the body of the loop. So when we compute `end =3D start' + nr`, the upper
bound is `start + align_mask + nr` - that's the check here. We know
start < i32::MAX (thanks to the invariants we added) and align_mask <=3D
isize::MAX, and nr <=3D u32::MAX. So the total upper bound is `i32::MAX +
isize::MAX + u32::MAX`. This fits into `unsigned long` on 64 bit but not
on 32 bit, hence the cfg to only 32-bit.

