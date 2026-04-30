Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30557FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F18F10E438;
	Thu, 30 Apr 2026 14:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="QQBhxrxL";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF5010E438
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCuTO/XUET9CWV++4P1LGyBEbiHuZAg8IgZlzj7w6Pn6Poo9wMAcx+CRfiXvxaP5vI4LJaV8TvwX3LE/kJvAzuYJQqnpZxgZdwFKHIAG+ZoRCTbjVcxq4qMazpd079ynA3O2wPXuuT/+nsrvDj0IiRqAblSgM6s4hu2iOrN3fuZDsEReaBsSn+CvPRLXEz1jaQIKZwPCqleOt3VFmjud3E1gHucqAHCmxpxYVzDjSEvkVQTe81F5rzV2r65I2CHZocWsnAPhdLwmhfXJGFj+S9eJpR/La1aIEr7MZ5pxofSax7DK/bfRX27eXv3QkmN+2MgA4CKwYgKyJwwteVnMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBXqYvceFbdEZwPLTLtUKY2nVIn2DSP2zCS6HkTIvFQ=;
 b=MQVJimnonCJrN3dHauUnJchaF03R89WH+XXgfYtfpnvxFxVrrzRZ6cT3UQlxUh2k7hBgwLTvU+wFe9XdrfIemKT91OTifJAa9JPnTlchyh39RaVbYtkttkI3gTKsLxzRD6vmEyJRDRZz2ELn7+4Pcc5hHpWo7lVjXZSIN9Xtg/yeXacla5rTJ2yk1YvGYKfDoJ1NLz5LlSVZdUrchkg1d7TQP+eRVePXC9qwvD0U3V/SWsxI6Uu6FhNRhu6ROBazQQu63E90NXobcAS5OayxbmnOJ6ibzi1CrQdOvpykzykWwhkc0zFkKljc/V2emlzEmBuvAp+FQUWHPNoxrLywtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBXqYvceFbdEZwPLTLtUKY2nVIn2DSP2zCS6HkTIvFQ=;
 b=QQBhxrxL+9OI3YczbHqCnNxUIA1ZOxeNUch4zhpndTnZ8Yllf2lGE+aaTtmzwLhForpMkisD2hKDxh5DFLLJX+egd2PRht/xIZvANNFjLX84hbYOm72QaJcB5DdfpUAqojp8kx++YpYQPQ6p1GYWxeL9rNKouLoYvKkF42rqX/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB1952.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:116::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 14:31:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 14:31:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 15:31:45 +0100
Message-Id: <DI6K97GKZKRG.2O9FPPA36J6RU@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org> <afMaAfcxpDR3xIE1@google.com>
In-Reply-To: <afMaAfcxpDR3xIE1@google.com>
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf53b15-72cb-4e8a-ffc1-08dea6c534d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1HYmu9vz2lEbO1eZ2g3K0ZCRBcr26Y29NOM4jmhBj6PzNYv9mBU+wdsNkM89O034Ci0zXJIOreM0rbtfAeLcie2R28o4CaewzTAl6vYSLdXfBd8hPqmBaaZEyfTiruwYBRgUffEsrxnqXT3prnoCRrRhn/dqTbv6lViPrZjamTT8J9N6bg+K8pn30mP30Wa4DzUjhR4XeqHYPIE2GfQlmm7bn0gxE/O2P0tIAnlhzaUTwqC7zFMwGV5G7LfMHGBB/PRjPjO1mpWXadu6cKvCNm+vanqhAxfPcwsOQCehucdN5iFrMlT8Ui5LqKBHRgCLSWGhyi+Zp6vs1RNhe3aU4k5N6fUMnyr26K6bwtHgyqgq/wQF2rphXiFDcWi5wOOL43lKCOvaUVokTiXfWYp7b7t7YfQmEIuxtWMa60W5Z+UNmVOwsP6+hpwsqrtPsXCDCB15z6LkDX0KAth1g1/H1JalBKcOmuj6urNHEZs3Jt0lggLbPGrWKVN6+9oStdwYttjVCWA4W/EkhHqGQ1jmZ/AvBXhAZSD83SyYJqB/0vU3CObEm8ASQRVtxZ2kCxJVPskhYY9BWxRaIZ31rv53gyQJX8UGuUa4y6n9vic+m3NXw6YGDieKvex9KbQubU76e65tU+4ds4DfJ6HDFoT5e7EgTtgSp8+TjofsV4qOgNm4NHnV0Z2lWvGU2A+mpunhLpGK1jkZXyaezRxJhOD7PIaYmeGawgRxM91NLC7Z6EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFxa2dqeXBWSms4SzRWS1RISnJNVE1jVGZVK2ZVQVhZcmoyU2RUcmdqcmgw?=
 =?utf-8?B?Zk9XdGxnM1duNEcwbjUzcXBJU1h5dHlPQU53U1N3OVRqZ1I0aS9MaDk5enM1?=
 =?utf-8?B?SU9ndERWeVF1VjNkRmJmSmxSWWFyek95NFcvR2ZoK0loYWhNUDhZZU1GalVL?=
 =?utf-8?B?R3JNc2VVSjgvMWVwczBqaEU2Y2JINDdLaXdENjlGWFJTMnVua3NjZytZOW1v?=
 =?utf-8?B?SEd0M2FiNHpVekcrVzhJTXlUL0RBM0I0QzdYU1ZNRk5VelFIUVR5UUxHU1c5?=
 =?utf-8?B?aTZESUVuQWdtbUxYWkZ6bWo4SkdabUhYNFBOekNUNDhadk1KVW9QZ1NRYTEz?=
 =?utf-8?B?aDZkcjFWVjMzL0dxWVMxdm9IeC8vSWV3QVdOZzVVcXEvZVRyazZuakdXUjJI?=
 =?utf-8?B?RkZvajhsb1JuN1N2bHNRZ1FsVFNtZUZranZDYkVGV2QvSkIvTE1HRUdycjdE?=
 =?utf-8?B?Vmh6azRrMUFCK0lJMnVXbFBNVjM3cW1MNWc2MGVSUkEwQUtHcTIxbDdXNU5O?=
 =?utf-8?B?bWR4NEtSRlM3R09FaTZBWk82TUJOb2FMdW4wUFdyRE9GOWM1aDVDUHZZWWRM?=
 =?utf-8?B?WE80NjB1bHFoazdHc2Q4NVFlTTlDVFVabGhIdXIrclNzcXZra0RaQjZjZUZL?=
 =?utf-8?B?c1kvRnljb3dkUHQ0VWE4ZXJJd2JIWUcrSWlRak1rS0s2TDI4V25GRncvbDJU?=
 =?utf-8?B?REVIQWducTB1U3hKU24xSTM0UHFUdnZ4U0lsam1VRm13K2FVSDVzTGlrNlVq?=
 =?utf-8?B?c2Faemh3Q1AzY2h1TFdtZ3lwQmN4NGVxQ2VnYVMxM0t2R0pEN1RqQ2NYQ1h5?=
 =?utf-8?B?NXlSYWF1ZlFHb2FZQXlleGFGUk1keFUyeTZIN2lKamZuYVRxajI2NU9GVmdP?=
 =?utf-8?B?NTBkcmFwbnIxeXpEVmdoYlJTMFFFMHRKRnE0aFRUdzEyN3VKeCtRSko1UFBU?=
 =?utf-8?B?YU1BWjloRlZhOGtrVVU2cThCZ09pQWoxcWlualRvR1o4T3RVMnd3ZWZUTmNR?=
 =?utf-8?B?TUpocFVhWk5Ncmk4N3JFeFY4TmdzeUhTYnVXdzdSbmYxN3JxcXdIeGVzR0E5?=
 =?utf-8?B?YjNWOHBIYndFRU9yYVZldllNTEpCeThNRWZTOHF1ZmIvUkd0Wm9oVW95UEFw?=
 =?utf-8?B?bjNZa1hQSTh1b1RRMEpTR1F4K0VXL2xRckFxOUkyU2h4amFNUnBuMlBSOXlR?=
 =?utf-8?B?bHFGa3pSTGNWejhUWmZMaFVpQ0xvT0swY05SZzMrdVVIVWlkeDZuYTlaUmFv?=
 =?utf-8?B?U2lHT3d6YWN4bmpXOUJ5MW81LzZ0VzRDbUprZXlpVVRtMGQ5UUt1UTdRQVgz?=
 =?utf-8?B?MzdrdVBSL3VOVXRVcnpSSTd5eWs5RU84b1Bzd2taSzJFZUFmNHh5OHdPY3RS?=
 =?utf-8?B?cC9yck55ak5YS3J0N01TTFFzSTAwZkplaTZja0FGbXJveDlaWUJ1RG5ocG1Q?=
 =?utf-8?B?enlyS2J5bHRQMmdYaWVzRHFiY082NVBCV0IzRTZ4a3dCNG9ZNDVvNUlNUmlT?=
 =?utf-8?B?UmJOT3BhSFI4TkM0QzFKQW93T2JubUlvcUpSSy9FYTlNRG1WUzJjNm1qVVBU?=
 =?utf-8?B?S3lyWVNDSlNHK2VIRWlxOEZzOTZGVHA1Z3FJcmdQaGhUa3g5VzNkaHhiWlg4?=
 =?utf-8?B?NGJLZDRkL2l1SnJTUFVzL1NPVDZCUWREcWp4MzFuUzhtNWw2Zy9ET0R3VGM1?=
 =?utf-8?B?dG5Sd0RUQlJyNDEydENwM1FWV2tMRjNyRHBUT3FtM0p5dGNiUFVwNER6MGJk?=
 =?utf-8?B?QmN0aGpHdU4yMlhBTEwrekxpdzNUckhBTk4wNHpJK3c5U2l0ck96bjRrKzY4?=
 =?utf-8?B?VktEMkZES2ZWb05WQVdIT3BBb1BycThubnNKRkVhdys0YTlMQ2RrcTRFT1hu?=
 =?utf-8?B?UklUQU5NVjdBbkh5bjQ0SXBTZ2FOd2RIUmVRR0pveUlMY2k1V2RSbkVTR0tp?=
 =?utf-8?B?dDlzaWZzS3cyWkkwb3F4UGRxT2o2ZndlQnk3bm1NMklSQ1VITllLYUJtdHkx?=
 =?utf-8?B?Wm81V2tjVTdoczNXQ0wrbVF0MFJET0lrRFNIQUhwckJDRy9qQmVFM0h2a0pG?=
 =?utf-8?B?UGFRNDJPdFdxa2lYV09ZZ25FRWlnV2Z0Rnl3VHA4ZitMQk9NZVFFMGsyQ3hs?=
 =?utf-8?B?YlNMc0VzV0ladVE1MW1xdVcvYTJib3NjN20vd0l0czBzWHMzZDZoZVdaeTlN?=
 =?utf-8?B?cVNJbHVmQS9RRWd3YkRqaStNMXUxVTVMTWF5d2VNVW9vSmxjWTRpQ2N3TnIv?=
 =?utf-8?B?RXVRd0FQLytkME0vSG5zNGoxcEVxV3R3aU1LSWlocFVXZHhKR3RBMVhzMG5X?=
 =?utf-8?B?YnRrSnVRMlpYcUc3eE9OU0c2aFBtb1dJelI1TkdLbmdYTGhid0ErZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf53b15-72cb-4e8a-ffc1-08dea6c534d2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:31:45.9132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMUIdR/VzUtIQ0BwNRklJlc/2HdDi20GPFAqgwoSD5yVh5R4507Sq3UYfkVugCpZPKfIF/CrasVsFV1PRP+i/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1952
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

On Thu Apr 30, 2026 at 9:59 AM BST, Alice Ryhl wrote:
> On Tue, Apr 28, 2026 at 12:09:40AM +0200, Danilo Krummrich wrote:
>> Add a registration_data pointer to struct auxiliary_device, allowing the
>> registering (parent) driver to attach private data to the device at
>> registration time and retrieve it later when called back by the
>> auxiliary (child) driver.
>>=20
>> By tying the data to the device's registration, Rust drivers can bind
>> the lifetime of device resources to it, since the auxiliary bus
>> guarantees that the parent driver remains bound while the auxiliary
>> device is bound.
>>=20
>> On the Rust side, Registration<T> takes ownership of the data via
>> ForeignOwnable. A TypeId is stored alongside the data for runtime type
>> checking, making Device::registration_data<T>() a safe method.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> So overall I think this patch makes sense. A few comments below.
>
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus=
.h
>> index bc09b55e3682..4e1ad8ccbcdd 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -62,6 +62,9 @@
>>   * @sysfs.irqs: irqs xarray contains irq indices which are used by the =
device,
>>   * @sysfs.lock: Synchronize irq sysfs creation,
>>   * @sysfs.irq_dir_exists: whether "irqs" directory exists,
>> + * @registration_data_rust: private data owned by the registering (pare=
nt)
>> + *                          driver; valid for as long as the device is
>> + *                          registered with the driver core,
>>   *
>>   * An auxiliary_device represents a part of its parent device's functio=
nality.
>>   * It is given a name that, combined with the registering drivers
>> @@ -148,6 +151,7 @@ struct auxiliary_device {
>>  		struct mutex lock; /* Synchronize irq sysfs creation */
>>  		bool irq_dir_exists;
>>  	} sysfs;
>> +	void *registration_data_rust;
>
> Is this really Rust-specific? Would you not want C drivers with the same
> pattern to do the same thing?
>
>> +        // SAFETY: `ptr` is non-null and was set via `into_foreign()` i=
n `Registration::new()`;
>> +        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset =
0, so reading a `TypeId`
>> +        // at the start of the allocation is valid regardless of `T`.
>> +        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
>> +        if type_id !=3D TypeId::of::<T>() {
>> +            return Err(EINVAL);
>> +        }
>
> Right, okay, so if you put C stuff there, we need the layout to be
> compatible with Rust type ids.
>
> Still, we could have Rust expose a couple methods to allow C code to use
> the same field with a null type id.
>
> But I guess this is all future work.
>
>> +        let data =3D KBox::pin_init::<Error>(
>> +            try_pin_init!(RegistrationData {
>> +                type_id: TypeId::of::<T>(),
>> +                data <- data,
>> +            }),
>> +            GFP_KERNEL,
>> +        )?;
>> +
>> +        let boxed =3D KBox::new(Opaque::<bindings::auxiliary_device>::z=
eroed(), GFP_KERNEL)?;
>
> Use __GFP_ZERO here instead?

On thing I wanted to implement in pin-init is a way to hint whether a type
prefers uninit or zero-init before initializing. Something like

    pub unsafe trait PinInit<T: ?Sized, E =3D Infallible>: Sized {
        const PREFER_ZERO_INIT: bool =3D false;

        unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;

        // Extra safety requirement that `slot` is zero-filled.
        unsafe fn __pinned_init_from_zero(self, slot: *mut T) -> Result<(),=
 E> {
            self.__pinned_init(slot)
        }
    }

Then the `pin_init` macro, if it detects that `..Zeroable::zeroed()` is use=
d,
can generate a impl where `PREFER_ZERO_INIT` is set to `true`, `__pinned_in=
it`
that does a memset + `__pinned_init_from_zero`.

Then we can have `KBox::pin_init` checks `PREFER_ZERO_INIT`. If true, it ad=
ds a
`__GFP_ZERO` flag and invoke the `__pinned_init_from_zero` method, other wi=
se it
uses the `__pinned_init` method without the __GFP_ZERO flag.

I've been tempting to this for a while now, but I prioritize landing the
self-referential feature before this one.

Best,
Gary
