Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823CCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F8F10E89B;
	Wed, 10 Jun 2026 10:28:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="SIIbqdmv";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021134.outbound.protection.outlook.com [52.101.100.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D6610E89B
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVr5RQuWyy2lYXGDz5nkWoKEZYW/TkEp5GBz9YU9AZyjycJquKEQsOXftZPuVkXkMdyuDWGZ9O37gOJ2kuOz8dj1QwzEWLXad7D156O4ARlPAHypJHa1nBCAa3tDBReaMdvQamtJvHsaO45NztIBuermq6G/D3gfnaxUVr/V6J1lEWaDpn2g05/7QJIOMO6y8wfdKGbbxmcVJLFK8SMsf27nMZd6DIL0dRFQsuoghnSdHJyv/0AldouJFMUgv+x1R0FrV49MZEMp+Yz4krmWc3lwXUJVHRDrjBYMnqZKZ9/2qx84jZrBwm4GyJvG05Yhh5z51XQXc+UzNtDWajNEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjLXky0iibg/oKlkruOrz0vNlK2cnK693tU08dF0QRE=;
 b=KkEFxqLgoHDCpxcM1aJXsTvz44iq13skYCC6DiLc8660Y+39HU3VuB8iL/oOyXuaucfzpFp7pwa6kYiLurlBSjH5d72rJEe5Pht3NmfYCLuB123NteHRE/GacKgTlJCZWs4cxJvoCNe79++Umdeak2sso3QOswhItkihEkWkOIEWu0Cun+3FJuFlztklsDUY4IJ1l5AYDXfz5Ctd3MULCa6gAPbdHwQbulpg4VszZXhHRW52dmn1m18qpkpZHEqPnwm7aeBPPyuMNcNokYMWPFqCzDYQbIL9lJpKtD4sAEKMjp3TWwp5kCDY/Yd/zh1GEQBn1Bs/zgH3jnqz1iDERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjLXky0iibg/oKlkruOrz0vNlK2cnK693tU08dF0QRE=;
 b=SIIbqdmvs8vVN9vu7pcZsnfHpfFhCMCsr1jXmE6X9DK4P+Ojp0MFmsGcNx9+kLeQZeIfFaN6p6mQb31axELN8123ijNKjWA9y7euTaDadnmTw0MMWJCDGW1O4f/m0H7fw7LU502993Mr4uUkpgArYUiaIrMKPpDCM+nG+fU29r8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB9114.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 10:28:00 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:28:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:27:59 +0100
Message-Id: <DJ5AQWO0KMIZ.1EUA18XBRIJC3@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH 3/4] gpu: nova-core: gsp: Extract usable FB region from GSP
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
 <DJ5ANU6OL6X2.D8ZG3LV755I8@garyguo.net>
In-Reply-To: <DJ5ANU6OL6X2.D8ZG3LV755I8@garyguo.net>
X-ClientProxiedBy: LO4P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::20) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: ee99bc83-878d-4cee-cb2c-08dec6daf246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|23010399003|10070799003|376014|1800799024|3023799007|5023799004|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o6YvzQVNUiZvIEnD+reWBMKpPlSGVbHR9SwzgymAdigWMWy1/WsOrlvPjkOa+Im9H4bjelXDofmN1P8wuudXGpbnxpTd0rqzT8zBf+K6hq/iDIals2IAtXU5gkpgKy2EjuIgpZfTO/yYqaGOsIiRRPPISuFH0T6oXJQTwJxSNImaibxumhMR5EbpM1YbbdRpc1sZ6OxiRSHS8Jsq9Uq/hzRJJ870JtlavbaWCqoekjKWOYFwFxazSFN1oa6FrLUjlriGg5uKAJBk24WV6qmEswY165Xp0h3sb33iPYAvtiNEhwYlzuBEilBu6fU5wFrvQkCD5pXZsKUrmkHd20eN0BIENhdfndIxOI9qA2Tb8e9VYnRj5uLDFJbHQo1V5Mhjp0KTb/RWzEpI2CntpL+7+WapVmwEu3H0slyzPmGSWCru4z50aUF45IOYfcL57YqDQnTKiQ8tzKYWnEPYy9Sj7mliJ/hHiJBJF7B+MQCqXGLjvucCgzsaRppc7Kc7vyyBZ8kAXZlz+T9kvE4UKtQjYrNPTFrHj9GaXZJkcudXp3LRAV2ttT3fOBsWFdG3AEDgLdBJ6ipKsryv4L9WtGOe4XqshzsGjj9eklrEqGyGEXfqiL0q9cLmWcukeeyU1M09o93thYKJUjDvRzWn6j7Y2Fg9aUzBa4vBc2aMAv232sD1k6Pqci6EGOuxJYw2tA3U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(23010399003)(10070799003)(376014)(1800799024)(3023799007)(5023799004)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1pVcjdaNTNNK25GMVEwMXRobklYeFg1U0o3Q3dRWGlKZEVaYkZrZGRNeUtX?=
 =?utf-8?B?TWd0eHR2bVI0OHNwZ2NiLzZZVU1QREhtVElCdUpsMEVpNUE5N2JyU2t1ZHNN?=
 =?utf-8?B?NFpBRllxS1FaMHA0TzRXVEpISlhmNitNeFJXdm95R3MxeHZlTmV5WEl1SG5V?=
 =?utf-8?B?djBEdXU5UW9laEdvazlpZGpueWlTdTZQWGwvMENrWkk5djdZZnMybEdhOXB3?=
 =?utf-8?B?VEh6YVhsNmpsVU0vTGlzZHFUVGh2WEY1SzlVQXJENDlPcFJSS3gzT3JGMjhJ?=
 =?utf-8?B?cUR6NUJHbGdHR3RiVk9WUk9mQWhOY1ZjT3RrNk81bE9hVGswTWpYUjNVNjJH?=
 =?utf-8?B?ckFQRWxQN2hyUTg0R1RBTDhoL2JTd2NYclB0dWl0ckljVmRPSUhRa2JzcW1x?=
 =?utf-8?B?cUJ2K1g1M1lMaktvOC93cGlYTXpBbHZyUmdaVXFjM3MxczlsZzk5bGRDMldS?=
 =?utf-8?B?QzdSUzJTTE5UR09uRmxXQlJGcW9UOWVXVHhoeDFGeDVmc2ZaY2ZiaEJqM3hG?=
 =?utf-8?B?dGVIS21nZHJ6bTFkSHRFK1p5V1NqYUplVGJOcXpLcEVSd0Fva0VXNEQ1MW5E?=
 =?utf-8?B?R1Y5WDl2UEw2NU0wZXpqZzhMY284clNaMlhmM3NMb1pxTmRqa0hTT3kwaXpw?=
 =?utf-8?B?cVV0SGNUNFIrN1pVSHp5Vm4yMlcrbEdPNW9nS0pEYmxjYUY0MnJmczgvY3BH?=
 =?utf-8?B?bEx5NkgyNGpHTXYzN0JjTDF3V3BDc3cydXFGRzdreVZad1ByUjNuTFU0TmpJ?=
 =?utf-8?B?Q2tvRjJlY0VmY2QzbnVFRW01Mm9tVHNrUE1uRk4rZGpLT014TjdqM0grc0V0?=
 =?utf-8?B?ZCs1NjBJejNJTEJXNEVwdlhDaFRQUUU2QWZnSFloTjNtbEY4eG1LdlF1dHRN?=
 =?utf-8?B?RlF2bDdmaWt6QmxjMmphT2ZNdG82S2hMWFBCS1FGT09kZzVrOFZETWRJMFZa?=
 =?utf-8?B?OHhBTGY1MjlBNHVidytXS2VyUHFHUkxxdGJJSk9HT2ZYUE03cVRqN0lEaXlG?=
 =?utf-8?B?QUk1SWJMaU5SVEZnTE5abkxOTC8xUVdPMlBrbDVkTUNRUmJTTDBnSzdjSHhM?=
 =?utf-8?B?bjY0bGtMQW5XeHpuWkxOMUFUVXg1RVlMcVFQV04yK3VVN3JhZlVPQWE5WFls?=
 =?utf-8?B?c3NIcjBrYkU2SHRlcXB3L3BGajRJQUNGbGxIUDBHN1dUNS93ZjIvdXJsZE1r?=
 =?utf-8?B?dnMxeHRKdVR5d210S1NZa0E5K2E0SVFpWmlZOWtYVEdRTHdqT0gxYWZRSkxv?=
 =?utf-8?B?QXRUL2dPTlloV3BTRys2a0JZSEVZc3hQNjdSZVNPUjZERHhjbnhzWWgweERY?=
 =?utf-8?B?NDh3bUg2YURHM2kyMG1pZmRoNVk3c0xvZk04dnlBNG9naDVLVFJXY1hVT2hP?=
 =?utf-8?B?ZXIzaG1yV0hxTkNOSFpVVnpVeDBlZ3NQY1l2NmVkd1VxbTFZV2NTK3hraitr?=
 =?utf-8?B?MWRtMDVZcUNqekNYcDRYNjUwL0NwcFE0N25qdDFKOEk3SGNwTGFGdi9hWTRj?=
 =?utf-8?B?bzNvUmhiaE0zM0RLbU9OSW1sM09ieUowUERBZFJ2UDVUNERiOE1JKzhzNUZK?=
 =?utf-8?B?NDVJZDYzVysyUGZDMGhxVWo1TXAzK2J2V0o3aE5iOGVYNXlkNWhzbTBVZ2c5?=
 =?utf-8?B?MHBGb3F0SCtXYnhPdHEvYnE3VGtyQmJaeWNXV0JVbXE2VEVjcTR3SlhFMWs3?=
 =?utf-8?B?THZFRWZkL3F4QWo4QnhwY3dMYmZ4cTFFdTBZYjIrU0tEdHE2bnBtOVlGckpI?=
 =?utf-8?B?L0NVYTlpSzlaeEpEQ1JhalJxRE1rK2dNT1hqOGZVODZuQlh3S255K00wUDNh?=
 =?utf-8?B?VUk5alhicStHZmlmWGRUcC90V1p1U3Qyc1kxNnMxblY0QjJtcGVxMHVzSG1D?=
 =?utf-8?B?QTJET3VCa09HQzdSYnB4ZFE4eTQzcmRnbEdkTjZ2QmovZFN3eExQMUNQclNO?=
 =?utf-8?B?c3lUSWh5dWVXblRBYnE2MkhRTlV2ZW5DaElNS0ZnTldJRkphVkpJNitZYlVN?=
 =?utf-8?B?YS92V3MzZEJYbU5ySU5JMFZROTNhelkza1g0THcrQVV6RU12WjViU3dtYkQ5?=
 =?utf-8?B?dDlFOFFEZCtyMjdMaE0ydk1wUE9kczhhTXNLbEpXMm1NTGNIRDUrNEQzVlRU?=
 =?utf-8?B?ZUdjSjZHVlcwRWF4ZUx5YWQ2Tzloa1F5L1VJdkFENkVEOHZBYkxOVjNNVVZM?=
 =?utf-8?B?Y0QyV2M3Vk9wdGxPM1RDbSs3NS9JK28rdVg4NGVONnl6SnhvMW5UODRvNXZU?=
 =?utf-8?B?NVF6K2FIcnd2cEphbUVMQk5Ya2l4cFlDb3A5VVd3ZUJOMk0wZGpIWjNjd2Zr?=
 =?utf-8?B?Wmh2K2wrY0dqZjl1YUU3VVV3WVFWZVBwTFdReVFOa1pXdGpUSzBHQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee99bc83-878d-4cee-cb2c-08dec6daf246
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:28:00.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBHEh+e79oJVGdA5BDy3dzyplxZtesTaElbKmXcgZVucqsrjtE1ptfrMKcXUbcacymlWhIwcfMO5yV532mip+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB9114
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

On Wed Jun 10, 2026 at 11:23 AM BST, Gary Guo wrote:
> On Tue Jun 9, 2026 at 9:04 AM BST, Alexandre Courbot wrote:
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Add usable_fb_regions_iter() to GspStaticConfigInfo to extract the first
>> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
>> that are not reserved or protected.
>>
>> The extracted region is stored in GetGspStaticInfoReply and exposed as
>> usable_fb_region field for use by the memory subsystem.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/commands.rs    |  9 +++++--
>>  drivers/gpu/nova-core/gsp/fw/commands.rs | 40 +++++++++++++++++++++++++=
++++++-
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-co=
re/gsp/commands.rs
>> index f84de9f4f045..d955f52a93bb 100644
>> --- a/drivers/gpu/nova-core/gsp/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/commands.rs
>> @@ -5,6 +5,7 @@
>>      array,
>>      convert::Infallible,
>>      ffi::FromBytesUntilNulError,
>> +    ops::Range,
>>      str::Utf8Error, //
>>  };
>> =20
>> @@ -191,15 +192,18 @@ fn init(&self) -> impl Init<Self::Command, Self::I=
nitError> {
>>      }
>>  }
>> =20
>> -/// The reply from the GSP to the [`GetGspInfo`] command.
>> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>>  pub(crate) struct GetGspStaticInfoReply {
>>      gpu_name: [u8; 64],
>> +    /// Usable FB (VRAM) region for driver memory allocation.
>> +    #[expect(dead_code)]
>> +    pub(crate) usable_fb_region: Range<u64>,
>>  }
>> =20
>>  impl MessageFromGsp for GetGspStaticInfoReply {
>>      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
>>      type Message =3D fw::commands::GspStaticConfigInfo;
>> -    type InitError =3D Infallible;
>> +    type InitError =3D Error;
>> =20
>>      fn read(
>>          msg: &Self::Message,
>> @@ -207,6 +211,7 @@ fn read(
>>      ) -> Result<Self, Self::InitError> {
>>          Ok(GetGspStaticInfoReply {
>>              gpu_name: msg.gpu_name_str(),
>> +            usable_fb_region: msg.usable_fb_regions_iter().next().ok_or=
(ENODEV)?,
>
> Does it just essentially require a FB to be present? What would happen to=
 GPUs
> without display support like RTX PRO 4500 Blackwell Server Edition?

Actually looks like FB in Nova just means "VRAM" and not actually "Framebuf=
fer".
Is this documented somewhere or am I just incapable of finding it?

Best,
Gary

>
> I feel that this check should be done by the user of `GetGspStaticInfoRep=
ly`,
> the firmware doesn't reply with an error.

