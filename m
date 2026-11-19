Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E560A2600
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=slrhnxxq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9170C1122D8;
	Thu, 19 Nov 2026 11:25:08 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022139.outbound.protection.outlook.com [52.101.96.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0754112081
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtfKNVGH8F0hoYaY3haQaJwcJFD+3Mk/1XRoZkJ4C4IOyXW06sgml/nhOiAn8X9cxEY9BbsV8ZYS4XkKP9RJe79iePYOw1pjzJ7XNLA2LMSiICClGEowCwOR40C596nXCFJwDmVF9iIiA595YD6VnXzpsP0ZnF79dUq6lyJZoR+RvCSgBBZyYgaUOL7y0Xe9Vi5UaBfpnBZfheD2awgCqrWeaZlbRAdhbxWPbtgHXyGBvwWJ61i2O3ET9BVLiD7dw/JzZV53rqHxZOSGoFQLcAk5jSWgSTeLd0omCPlqo7GjscXxC8CXtkXOuDF/ww7Z54pVpyrthkumR46MihM04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPVxTASvMF2LRkTKbKSd2Av5oq4CzABsWU71CpGoW40=;
 b=ikySBike0v/qFlitLS/+OqPX+NKtBKLF1sKMHkjuDl5NyT8reJtn8PZuLI4LC6wWTqvziGiO0uUzWUOxJ3nMczZb2M1CPMUeXaIdGrIDmjX4rr5nziGq+pt/MBoac2mjEGdDlUgsB7XF4DZTe1wTczPPKZcLJ1qU68MikBR8tfgEi2x1LZPkPKN5XJ5hrPqMyXIaUEDTdtDzBB14/ZVqzAN0WiXbum3jkRGa1xZ0E7+4vkobRjDJtKB+CXiUtf8snTtpKPeg9SfOd9XpIZJvvwxtF8oKvX37eRCel/cFmcfUkrKVPTnXl/XWaa7uT9MbqHJfXTrL7JR8l2fJTe7Fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPVxTASvMF2LRkTKbKSd2Av5oq4CzABsWU71CpGoW40=;
 b=slrhnxxqbteYMztNmPNc2kQxUe/9WbuCQNJdNerArL/M8q3g8ZDT65jLDv+ZE/My4iWXrKh80ECJrc/5om/DipQSzCvd/a7VVxCnqJYHks0ObSS7xUPpXLLgLbgbwoMz4ZEe2oMT2L1CM2FHkAzbwvpoTGYz3diredX9w2FbGIk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB2195.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:64::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:24:57 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 11:24:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 11:24:55 +0000
Message-Id: <DMZ5ER6XTNLG.2ZJOF7F4100XW@garyguo.net>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261118181245.2583303-1-dakr@kernel.org>
 <20261119111746.3049044-1-aliceryhl@google.com>
In-Reply-To: <20261119111746.3049044-1-aliceryhl@google.com>
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: 065263e8-4bd9-4c58-b2fe-08df462fbd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|10070799003|1800799024|22082099003|18002099003|4143699003|5023799004|56012099006|10067099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: efdSElmxlDQjE8PPeur+bVlXrOZmd0FO7I5n5+YK1yHmO+SLr2/iqvnzAlvnfz4LEC1jIMfEkvrFTgs5ZTtgQ5WOPY84R+Xlujim9Z2PhnoBW8vESafT+MalbXmqluz+IDg/hPSpr2jBtbprJAwB0+61XXLhcEIX2hGFIeevocbQC8DSRy10GUFz3dx1WhJRn8ZB238ZDAEBbtVngt27a9VkghxJ5XHwSrObA7FI7QgWF+mRXsbQO99pLALNGFQyAwK5noOG0DOKKrFDvfWAqg/725aOhIpNK+Xa+7Fnxkm4oAAqXnLr5EGCljN7LX7mC7kpwfG7asPHZB3ev8AGU3OsdJ9qelPtPJ4J13i/7hpeF+sSctG28hnQz/DYkKk/kzQl8kXAoSNyypVosn5BMQ6tR4lcenV1EK1c/6X3kp9XucFuaMH0uw8D5xT+mmRoYUtY19X9QiuPuIPbkhhW8E/dVGwsumgDoz280Q6bwzGSVzYOg5svP/gFwj0M6/hBwup1fn1+yiPSpgVtWZcnOhOL0aYdIF8pr0mB29lBrkY60O6tLwIG3eKNC9lMZlYSI8BBDd2x60g2hwPtIK6Obf2IkqFPXEr+d/bhWtUfmDOD1EdF06fi9hpNdYPRERx+Ql5YRD+oNd84rVJ2ZO88iwx4ojaOio918XBjhDexCUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(56012099006)(10067099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHl1TTRONUtjM2l0WGhiNkNNK0N3SVVTNVRqRi9hNFROVGxrLzBSOCtkK2dw?=
 =?utf-8?B?QTVZWDlGYWRVUFM3eTNNTHJKcjRDUmF3S0xQbXp3dlZLbkkyR2ZTQm9iZm1w?=
 =?utf-8?B?OThTNHBYc01UT2cvM2FLWDFFTVpJVE5DUWtvYjRMWkR0YkJpZHR1MzhxOFph?=
 =?utf-8?B?cVRnZ3FtUS9YeXgvOXUvMUJRUDFCK1c4QmlIdXVVc2IvWFNKdjlVMVhpTkxQ?=
 =?utf-8?B?ejZxY2hsOWwrUDlPaW9LaW1ONmhUT05mV1dMSjY4VGl2bEwyL1huSFVGRnRF?=
 =?utf-8?B?M0QvdGQrK1k3VHErajFvL3AvaW9BcWZoSHorU0hPTHB6SEdoUm9Ucm9WUUtD?=
 =?utf-8?B?SXlrZWZYMVdwMWNnTEpJWnAzVjR4Ynh1SFJ5SHZBUlpPRENUWXZCTE1LQ013?=
 =?utf-8?B?WUkyekZncHJQOWQ2eEE2K0ZuZVgxMERYRVVWcGZiSUhUci96WGtETlRyRUIy?=
 =?utf-8?B?cm84YmxOTXRUTFdrcjRYSUtYTHpZeVZYR09Db21xR2U3eUZqZ2JMcDBENmhV?=
 =?utf-8?B?TzFKamJBSEtETktNWCs0d0xha1lwZzA3TGY3RCsrL3BBNE4xQU05OWxzaWNj?=
 =?utf-8?B?Y1c3d1kxOFlsb1IzMVB4ekpHVGZvYTg2VXVqUVU0d21OKytRMG1WREEzQXZp?=
 =?utf-8?B?Wm1uM2N6UXVnOFBMN0pxOXlpUnZ3UWh5U3FiSk5kaUFOVkowc1NmWHhJZVpK?=
 =?utf-8?B?UmdzdW1kOGJ4NDJlNmFnVDJqZGtZMGw4UENZaFY0Y0NJT2hlbWxyQnJQM2E3?=
 =?utf-8?B?SWFWdndwQnlKVEFaaHRKSjROZ3NOQTlyRnNKTDNpb0pwcVc0R3dzTmVDQ2RT?=
 =?utf-8?B?L3BqNTNFQVVtUElCRHRDMXJaQ3BwVE53QU43Y2hDbkJOa3ZMRW53UjJkZWZQ?=
 =?utf-8?B?UzVObTliMDRmaW1RZGpzWkZIZmp1YzNsc21JZmxFaEdza1FDZExZL2VKdjJ5?=
 =?utf-8?B?RmxyalduVVBpR0dtejZGZ0ZzRm0wbEZJRTZ5VDdsekV6VUpVMUlENWQwWXVR?=
 =?utf-8?B?UUdWZVhOcFVSOTFpTmJPN1Z4bnVTc0orRGdTZWkydnFISXdoMGV5TitWSUxD?=
 =?utf-8?B?Z1ZKTFE0RXNTamV2SjRUTjRMUjdsUEg1VCtyalB2UUN6VmIwenBXNXBwajFw?=
 =?utf-8?B?Q0w0ZUJ1aUd1Y3ZoSTROMlpJVGdmYjA1dDJsL2xRTXk5M04wQ25RZjEydGNB?=
 =?utf-8?B?RlZPbXRqdHFhdFV3THFKSi94c0I1dkJlMHBPNGlPQlBJYmxadktmQ3YrWG1E?=
 =?utf-8?B?cEhNZFJMYWlFY0Q5dllqUkIwa005RzlOd2U2SEwrQTJublowN01YWnNaeEJs?=
 =?utf-8?B?cXhvcHlPclE1QXlQbmpPbU52eDNHcWRUUXZBdHJCYTZIOXk5dXczZEcyM1N2?=
 =?utf-8?B?RWZDWVNRR3JSU2IvbE5Id2JiMEFTbFZNMWpORW1HQThncjRuOFFQNUtkelY5?=
 =?utf-8?B?SUljWVVHVjF3eEVITnl5RWFhemYrczQxTi9pdTVYNHJYek1wSXpueDFESEkr?=
 =?utf-8?B?dmp5OEU1Umc5SkVyakFER0RNUUZrM1RnUUlwUWlZOFlMbkNLOEpUNFdGQUlK?=
 =?utf-8?B?Smx4dU1LUUZzUFN4TTZSa3lkcWw4Uk81SUhWQU9mZXcxdWMySlpHc2hGUkI2?=
 =?utf-8?B?MzBKSWhGcXNzVHRnZ09Da0ZXYkdVMnhic2poRTFma294bklWcUZVcG9NWm9G?=
 =?utf-8?B?Tk9ONUF2M1JwVXJQZWlxVGdtOUgrVFRGT29uMkxyU0oxOFhPYzlORTh6Sldi?=
 =?utf-8?B?NUo4ZUdQQUFSdVZqZVN0Y0RVaXdZdmJyNFM3RGFIM3NBN3pzQUJ0bEpXWncz?=
 =?utf-8?B?NjBsUndKakptc3BtckFVVlZaYU5QRDJkeXRZK012eEVKM25pclFKQUE4RC9v?=
 =?utf-8?B?ZWc0U1dNcUhzbDFmOStMMU5NalgzRG02cW9rZEg5RjJmWmRsWDJIdTRndXpK?=
 =?utf-8?B?cG5PNWdlMFdCK1AxSE1qYWZLNzNxVit2VG91VWE2S2xscitIWmRhSWtiMjhw?=
 =?utf-8?B?ZHNISm5qbmUxRVQxVTZlTnVvb3JIMm5iSklad2x1U1lwVUc2czlWdFh3SDdT?=
 =?utf-8?B?SUZoamJGVjBqUURvQVo1TXh0azg3cTZhSFNFMy9OZGNFVUlRNHB2blIvbVJD?=
 =?utf-8?B?Q0kvNTEwcllydzdBY2xQakhva2tiZmkxazllbHNjaXRnZEJ6RG40Q0ZaaHdu?=
 =?utf-8?B?VWh2Q0M4Y0RYTnFPTFQ1bFNYUWorWHZMSDZTbW92SkpHWlVlbjNKQmZLVldh?=
 =?utf-8?B?M2dDd2tBOUNqcGc1eFBuZHZjRGdVNDZCUXM4Y1g5RWVLTUdBaTVjQ1JTS0p1?=
 =?utf-8?B?TVdBQ0ZDQlhwSlY0UDc5TmN5RjV6UExVMTBkdlNSLzBoQUF1N0I2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 065263e8-4bd9-4c58-b2fe-08df462fbd86
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:24:56.8170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdMBhNmiJXg6PbE2FJdbM3hOqN8yirO9Frw2LQP6piORcq355oJ3nM5XoZEvx0EsCY44jaA3JWW+NlSRvIfuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2195
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 11:17 AM GMT, Alice Ryhl wrote:
> On Wed, Nov 18, 2026 at 07:07:35PM +0100, Danilo Krummrich wrote:
>> Driver::Data is owned by the reference-counted drm::Device and can
>> outlive device unregistration and driver unbind. Driver state belongs in
>> RegistrationData, whose lifetime ends with registration teardown.
>>=20
>> The intended model is that, after drm_dev_unplug(), surviving DRM
>> objects (e.g. through remaining userspace handles) no longer require
>> access to the driver state. Thus Driver::RegistrationData is available
>> (and sufficient) for all DRM callbacks into the driver.
>>=20
>> Remove Driver::Data, its storage and Deref implementation, and the
>> unused workqueue implementations that depend on it. Drop the data
>> initializer argument from UnregisteredDevice::new() and update its
>> callers.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> Makes sense to me. Both in-tree users had `type Data =3D ()` anyway, and
> nothing uses the `WorkItem`/`HasWork` impls on `drm::Device`, so this is
> a pure simplification.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> One small suggestion below.
>
>> -        release: Some(Device::<T>::release),
>> +        release: None,
>
> [...]
>
>>  #[repr(C)]
>>  pub struct Device<T: drm::Driver, C: DeviceContext =3D Normal> {
>>      dev: Opaque<bindings::drm_device>,
>> -    data: T::Data,
>>      pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationDat=
a<'static>>>,
>>      _ctx: PhantomData<C>,
>>  }
>
> With `release` gone, nothing ever runs `drop_in_place()` on the Rust
> side of `Device` anymore. That's fine today since all remaining fields
> are trivially droppable, but it is now an implicit requirement on the
> struct: anyone adding a field with a `Drop` impl (or a pinned field
> that needs a destructor) would silently leak it.
>
> Could you add a short comment on the struct along the lines of "no
> `release` callback is installed, so no field of this struct may require
> dropping"? That way the next person adding a field knows they have to
> bring back the `release` callback.
>
> (For what it's worth, I checked the lifetime-parameterized `File`
> series [1] against this: `open_count`/`open_count_wq` are both
> droppable without a destructor, and the two merge cleanly, so no
> ordering constraint there as far as I can tell.)

Instead of a comment, a const assertion of !needs_drop would be better.

Best,
Gary

