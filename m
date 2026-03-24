Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE15F54ABA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0393810E00F;
	Tue, 24 Mar 2026 14:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="zQ8EaZdH";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BC510E00F;
 Tue, 24 Mar 2026 14:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5rKz2ir50AtOrQaBN8a9eJTUVQTSlU7Lbd7Gp6sa31Ur5XlLUz00TcEEvG/ok92Dc81P8Q57z23yTO0XyefLBkDRGqP8QuYOj0wbufiNsqNqUdkDS3C7LaC+f79YucHditqfOEaDX3A0O9YQO/XlBRPuvd3o5YQwXUorjqx3FX+ZIbbLUYsRawvzuI/oceBzJeCqN+UkGxti2ZRpncQ0h3WX6tS98RyI04HeYMWQZt+FJAbzNmawriz7amhkrBEhFoMe+OXbrLePSlxVdwgSnpzd5ksJUxMU6sJ29ySkauuK6XDiEcGLqoyGkTOE39UhHizYZzbzk332HAuLp8NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leL33x+zZ6z6+LDgutm4yCaziziYsSTOzxZc7WidzsQ=;
 b=a23Q5eNrk5zrxfc0TEwD5BqTLmJuiffgQRsqpoVk05Et2plaItqSPz3K3f2/1jLpGsLfRwTh7RJ2Zf7IEgXPzg9wGuwxrQOkUrtSfbo2mYjTKzGtPAhXPOfnE2u9Ht9hAh/+uyhIvPMqZb2fedLxx7UDAvZdKCRMXpZV9oagsEixmoYaaOg9y+Ny81+yao3ierqZIKtzwgdwXBPylQFWVJ8561us6D1eSSmCg8j1Hnxt6Rmslf1iSoXdM7oeiUnlykYhX9Cq/YwTcU9PM62bDEJ/KuSG4WThkBdYtfgNAoqElmP7ivcCZsRYsFx1myzpC9hvenS4TYPGhiZ6FWbg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leL33x+zZ6z6+LDgutm4yCaziziYsSTOzxZc7WidzsQ=;
 b=zQ8EaZdHNIH4iHqo1dTejgBDKO4ugdDOhpEbaTuUWtzRdPY8b7PUA20zHmnXXaOea32B43N85UGgklrAbBgUaHfOaEUFTAAZ72TYzPGDMCbhcbR4xBTPoDLNKhVOJZfxv/kVTucOCzPo/4TjlNHmTgAj6pM3n65Y63UTVFpha10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2676.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:06:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 14:06:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 14:06:01 +0000
Message-Id: <DHB2JCKXZ5ZN.LA5E3HY3YHGS@garyguo.net>
Subject: Re: [PATCH v2 2/8] rust: dma: add generalized container for types
 other than slices
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <8WwJUXIwwCnCTXlAJw77hgSFS-jjhGgfJQoyIaVPdDf99QqTFd1uHhEj56PCo9Ihv-koAQP7826Vpx8HZkKE5A==@protonmail.internalid>
 <20260320194626.36263-3-dakr@kernel.org> <877br1qr6v.fsf@kernel.org>
In-Reply-To: <877br1qr6v.fsf@kernel.org>
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2676:EE_
X-MS-Office365-Filtering-Correlation-Id: 25efe760-540e-4e17-c103-08de89ae7b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: gJzY1aKYD8J1HEf4B+fh2bB7QWajKL5/O37G/j3+ml2JVD1eAIHXzDd8w9UKkdjLEOpyUO06MqhN+UXTaFVM2OsGo3isOfAfZhvdbmpRh7kl19AyKWdMo9dZltwlzTWdIvuAwjiCFx3G2zDEeVSbBqYeATqlcE86c/nDyNb0n/etxWZJikjYC0LQkI5Cf8WrHZOuL0TYsQL8BIdMB/uedAZ+awonqJxfX0HTgt4T9TsgMi8gjYvbEypNuoGDTwxCcqtoODEau8caDO84d/pkvkuuVWbX0NPQa/V8JrNkYM6kB207S8pkP07tltJhY23/HQD5OZrI1M4e40AQ3i0PDtSEqZjjxTCnmV6ZmIsNu6b9oe//Gbjnh2I0a89OWkjzIXMcnxboCwg8AgPgMHsRf/tB1oxvDAcbMne0oofl73jFZXPJh2v+mQlr9rOxWBT+4N9G6XRi1lnhNeae2iJF+PpvfiZhyNtP46DfvV+9N7+HeUDdRG0xrgO0Jg4/VRgqkK3oZ3OY0ragLzWtvn/KoiSIMe1ISYjgSOlK/OIKkyf8abey0zuV8a+7E4GSyZr+KNC7ei/lbmD4Wlo34+r1gSnvQYyaelArpfRyscT8ECPtntrZy8MhwEgFD0nHZ03KYzBMUTWO4K0Ue6l5VzsRpD73f7fMXZvXrCx4afIhs7uXM3MyW58bsf9MuXzijwR7WwLBgBTTagQwipAXbkAYcBjPAwpbpDHHMPhCAhn+J1ttJHpFrIX0DygVndiBc0/e4oMQp37rfSmT5Za3U/gLKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xLOHI3Sk1GYm55aUJqZnNXemtIRHYycmJRdkkvQUwvam5sVURFVnNNY3RM?=
 =?utf-8?B?RWdmcFRWRGQ0T1F4Q2ZweEJ4Q2R0RFFMU1NKU2NscnYwNHRjTXN0NjlKN0lv?=
 =?utf-8?B?Nk9SS1NDV3BaYzFsRjljMFYwdXNRR1d5MDdJcjVEVnMwNjJQMEtmTlVEVHNH?=
 =?utf-8?B?ckZpM0xIS2x2U0swZzR2QjFvQTdIWlpyOHBBWWMvTDhyVGhoczhHZ0c1YVdN?=
 =?utf-8?B?cndaZEZTcFIzaVhxVWJkZWVvNzFiZ1pDRURRQmVlMStmSFdBeTNQNVUrbEZ0?=
 =?utf-8?B?bmIvNnlFdVR5U3ppVTlFaXZReFhYeGZPQ3k4azFIcXJ2QTRTLzJwQm5BSEZ6?=
 =?utf-8?B?L0FicU90MFRYZm9SbmE5akVob1VUVHk0L1ErV0pBanYydGdOVlNSam52NnQ2?=
 =?utf-8?B?S2tUMFNlcG9hN05LNnlvdXFUWUk0MzcwaXRzMUZ3akpjQmFUdG9XbWVjR3l0?=
 =?utf-8?B?ajVDWDQ4YUsyNmFDZ0UvR0lYVEJBYi9zaUEyUDRGOW5aaGUxVk5LbTNZNCtn?=
 =?utf-8?B?Q2xSdCs5WVo3aTF6T0dOMnZNay9NZ1h1TS9wTUNDWnQ2QzE0WHdpa0E4VmlZ?=
 =?utf-8?B?Q2M5T0wvNjl2ejJobXlWYStWUFNwU0FFS3FQNmlqMDJuamVRQkQycWI0MDlz?=
 =?utf-8?B?M0NGVmExclpHVFlEeU9HNGVmemhYcEZvcmJBUDJUSzNESHRvYVFCT05DZTJH?=
 =?utf-8?B?RVBxb0plTlUzTDg0ZGtIRUZHQzBnZktUQTl3TGVLY1ZRQ3Uyc2Y2aUFIOFV0?=
 =?utf-8?B?L2RIM1VxWEJCZjdIUzVOMEpNU3diUjlDN0pOS0IzNVd0ajBoVk5JUWtGY1JT?=
 =?utf-8?B?SyttRjlHVmdEQlArTVNxN0o1V0Ixa2NMK2lXa3p0eVpQUGRqdmJvbUtTbWk0?=
 =?utf-8?B?SzYvZWJCK0pnNkpRWmhZV25mdlU0YnVzajQ0cXYwdC8rWEZlYXFodVU1Y3ls?=
 =?utf-8?B?ckNvTy9tTWRENUx3akZxT2xJRmM1UC82M00zZ0RmL3M1QTIvSDNjN1RDcm1o?=
 =?utf-8?B?UTN6emlsdGJpejVadXdNeVVLOVNMT3pxdjNlYzZ2bUZiZXZXK0NsV3NiNjF4?=
 =?utf-8?B?YW5HL0oxTS9GZzFIRVg0SUsxdzMrcTUvV2tma1gwd3RGczQ0aHlFNklMeFll?=
 =?utf-8?B?cDVIMnUwNnI2amJhYXh6Z2Y2MW5SNGdQcVJrY2hpdndMNUFPeEE1eVZHY2hH?=
 =?utf-8?B?cjRKSWJuMW1SVnFyaXF4cmlSOWlsS0oybktiY2I3OUdnZnQ3M1AvS0RDdklm?=
 =?utf-8?B?RDkyRDYyMU5uN1UrSnZQOE1PdUJlZlRnOXhGRHo0NHVFWjdOODZPaThBN2x0?=
 =?utf-8?B?RHpvclFZYzJydXRaOWdMQzFPWllwaFNYRDVrM2xIRndlc1JzdHo5cGxmbW5X?=
 =?utf-8?B?ejFPaHFuVjNEK25TR3FIZ3BhSDR1MGhLb1BGYVpvZzFNMmlrNEE1L0JJSjJr?=
 =?utf-8?B?cVhaMCtlYWoyeDAwNExydVRPQjV3aTlGbS9zT2VpUXdXS0lJMElYK3lUN3Z2?=
 =?utf-8?B?UUU0V082NDVBQm52eGxaZVo0VXB5REhPL1BVRGV0N3JBV1Z3Sld4a1pHYlNL?=
 =?utf-8?B?S1Jta1JRNWNoblIxOWhuSHd3S2FvWUYwd3plU3gweGt6NWwvUWNWSlAzajN4?=
 =?utf-8?B?OFIySnZRTnV0VzVBbWFzd3FxQVpXWlA5cnhQQlFPYXRYdlhBMndLek9uRThF?=
 =?utf-8?B?NlVodnhITkkxd2NOMFNENnhRVzBMeDBDYkhOYlhUdGFyR3FVMGlFWVJiOUo1?=
 =?utf-8?B?RWRFUVNMcXFTc1dEVzNHZ3RmOHl1eDVrdVZ3dmphQ0x5NTJZdEVPSFBTeGVS?=
 =?utf-8?B?QitZYVEyU0xsM2J4aXJPcW9OL3NVZVlLbnJEMEo0aVVGYjBDcTlDQW10ZkR1?=
 =?utf-8?B?V2N1bW1JY2ovdS9mN0Q4VjZWeGdnZXRrSVpCWWFUNWZHNWduSXdWU0ZrNFRM?=
 =?utf-8?B?VFl4WmlYbjZVVkxpMjBlQ0tGVitTcGNWeVdJVlplbVlRcllIU3JSM1FYek13?=
 =?utf-8?B?VGE0cjlsbmptYllJektRd1AxT01JODAxQmk5R1ZhSmxOTHpIT2ZUK1ZvVUdG?=
 =?utf-8?B?U3ZHNTdQdmVreitZSDhlZnFUNXdXa2w3cGJ0Y3lrSWVFVFlOd3pzTFJkbmt1?=
 =?utf-8?B?bjkzT2JwbU0zWThqNzFZZmpXT1o4MjR2TE04K1pCK2JWdEhSc1FReU5yUEVG?=
 =?utf-8?B?Mnk5QVMwb2k3b3Zwc3pwV09LUm43QWFLR3NPSGdLOFdBRGlieVVnNkVWdmF2?=
 =?utf-8?B?ZUZpMkZCelJxOThXVm9Oc1hxL1FhQ3ZSREpQYVF2ZkkyeDFIeHRkbTZJVXo4?=
 =?utf-8?B?anIvQ3ZUQTN0MjB2cmJ3a2VZU25mcDF3Z1pzSVRsODYxTk5iYjZnQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 25efe760-540e-4e17-c103-08de89ae7b52
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:06:02.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VFcDbnWlXJ6bWyccNCpo8zmVgt97zEs+18uiaILIuq0GMql+gCW9urmV1hJiB/3z/2Wk/iQUcy2MVxutu9BZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2676
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

On Tue Mar 24, 2026 at 1:42 PM GMT, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
>
>> +    /// Returns a reference to the data in the region.
>>      ///
>> -    /// # Examples
>> +    /// # Safety
>>      ///
>> -    /// ```
>> -    /// # use kernel::device::{Bound, Device};
>> -    /// use kernel::dma::{attrs::*, CoherentAllocation};
>> +    /// * Callers must ensure that the device does not read/write to/fr=
om memory while the returned
>> +    ///   slice is live.
>> +    /// * Callers must ensure that this call does not race with a write=
 to the same region while
>> +    ///   the returned slice is live.
>> +    #[inline]
>> +    pub unsafe fn as_ref(&self) -> &T {
>> +        // SAFETY: per safety requirement.
>
> Is this enough? Don't you need to assert a valid bit pattern? I assume
> you get this from `FromBytes`, but that bound is not on `T` in this impl
> block.

Concetually `Coherent<T>` is a container of `T` so it should always hold a =
valid
bit pattern for the type. Perhaps this should be added to the type invarian=
t.

FromBytes is only needed at the constructor level as that's the only place =
where
you're asserting that initial bit pattern is valid.


>
>> +        unsafe { &*self.as_ptr() }
>> +    }
>> +
>> +    /// Returns a mutable reference to the data in the region.
>>      ///
>> -    /// # fn test(dev: &Device<Bound>) -> Result {
>> -    /// let c: CoherentAllocation<u64> =3D
>> -    ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATT=
R_NO_WARN)?;
>> -    /// # Ok::<(), Error>(()) }
>> -    /// ```
>> -    pub fn alloc_attrs(
>> +    /// # Safety
>> +    ///
>> +    /// * Callers must ensure that the device does not read/write to/fr=
om memory while the returned
>> +    ///   slice is live.
>> +    /// * Callers must ensure that this call does not race with a read =
or write to the same region
>> +    ///   while the returned slice is live.
>> +    #[expect(clippy::mut_from_ref, reason =3D "unsafe to use API")]
>> +    #[inline]
>> +    pub unsafe fn as_mut(&self) -> &mut T {
>> +        // SAFETY: per safety requirement.
>
> Same.
>
>> +        unsafe { &mut *self.as_mut_ptr() }
>> +    }
>> +
>> +    /// Reads the value of `field` and ensures that its type is [`FromB=
ytes`].
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This must be called from the [`dma_read`] macro which ensures t=
hat the `field` pointer is
>> +    /// validated beforehand.
>> +    ///
>> [...]
>> +
>> +impl<T: AsBytes + FromBytes> Coherent<T> {
>> +    /// Allocates a region of `T` of coherent memory.
>> +    #[expect(unused)]
>> +    fn alloc_with_attrs(
>>          dev: &device::Device<Bound>,
>> -        count: usize,
>>          gfp_flags: kernel::alloc::Flags,
>>          dma_attrs: Attrs,
>> -    ) -> Result<CoherentAllocation<T>> {
>> -        build_assert!(
>> -            core::mem::size_of::<T>() > 0,
>> -            "It doesn't make sense for the allocated type to be a ZST"
>> -        );
>> +    ) -> Result<Self> {
>> +        const {
>> +            assert!(
>> +                core::mem::size_of::<T>() > 0,
>> +                "It doesn't make sense for the allocated type to be a Z=
ST"
>> +            );
>> +        }
>>
>> -        let size =3D count
>> -            .checked_mul(core::mem::size_of::<T>())
>> -            .ok_or(EOVERFLOW)?;
>>          let mut dma_handle =3D 0;
>>          // SAFETY: Device pointer is guaranteed as valid by the type in=
variant on `Device`.
>>          let addr =3D unsafe {
>>              bindings::dma_alloc_attrs(
>>                  dev.as_raw(),
>> -                size,
>> +                core::mem::size_of::<T>(),
>>                  &mut dma_handle,
>>                  gfp_flags.as_raw(),
>>                  dma_attrs.as_raw(),
>>              )
>>          };
>> -        let addr =3D NonNull::new(addr).ok_or(ENOMEM)?;
>> +        let cpu_addr =3D NonNull::new(addr.cast()).ok_or(ENOMEM)?;
>>          // INVARIANT:
>> -        // - We just successfully allocated a coherent region which is =
accessible for
>> -        //   `count` elements, hence the cpu address is valid. We also =
hold a refcounted reference
>> -        //   to the device.
>> -        // - The allocated `size` is equal to `size_of::<T> * count`.
>> -        // - The allocated `size` fits into a `usize`.
>> +        // - We just successfully allocated a coherent region which is =
adequately sized for `T`,
>> +        //   hence the cpu address is valid.
>
> The invariant says "valid for the lifetime", do you need to argue for
> the duration of the validity?

It says "For the lifetime of an instance of ..." which is basically equal t=
o
saying nothing. I think that part should just be removed.

>
>> +        // - We also hold a refcounted reference to the device.
>
> This does not relate to the second invariant of `Self`.

The second invariant is about size, which is addressed in the first bullet
point. This is about the third invariant, which the doc-comemnt just says "=
TODO"
currently.

Best,
Gary

