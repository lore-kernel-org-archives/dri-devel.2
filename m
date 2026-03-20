Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE8C1098796
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9022410E002;
	Fri, 20 Mar 2026 15:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="b8lEzvtf";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020118.outbound.protection.outlook.com [52.101.196.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483F210E002;
 Fri, 20 Mar 2026 15:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omiW245PwQ4FDqOiPJKZCJy9w+zCVk2UPmuVQpq03yAmtGKmtnMjTLlFAJfwPxRP/XAxyFro4I/8jqTgj1zQy4Eq4UMWqClfkOHKsaBC64X1aCDZvndccxyDajtAcUXxSXMKdqD69CryCIdG3wtYwQ27LEma/fBqFYhidwnHHx4kWr1/4xdK9InGioCx037mEcsmgZuXnan5+w5VU4uzyMF7cL4dLWf/BBEPjBBM86D7XFXGxMgAjYa+nQBg3nqslZUygBvfVhytWFGfF865TXKjdktaPH8vbzX09/cZNBAh1S6l7R13IkvvsVIkE+wdUumoKBvvQdjahOFPKjeojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lhy5qnjIaFEeJ3Zfz2PWuxNO27xrEY6/QX/Qbx7wFo=;
 b=jKnMu+7uO+Q2zUGGu+iIPvm6lqWCwAmu8+U8CVbtxi/4y3xsGutqgbY4my33JdtwIvqGB4BrcuN/n9xzRG/iRZgGDcbM+Ddh+1wd8pvkpLeRmhXrPeqR3y5zeFzRRXWibSyQDtI/vSywWJpXYQo8m8lTX7Kdemx0GbblDUR5uYy3eFbKQT7WpmsyElSmtbY2IWEkVx0giIOya+XKq1mBC+k3Xx9yJeY7NFezFrmfs+Umy4Tw2tkl3JM5edojf5MUtM5RMg30sqkfYgZlWu9J/QaYdXiSCKFMR//4IK7fszgUjBIoQghwh9dp5M2T7CfVJoPq6Y42linfib2WBeQj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lhy5qnjIaFEeJ3Zfz2PWuxNO27xrEY6/QX/Qbx7wFo=;
 b=b8lEzvtfIE+tcnIrBIR5hE/K73CzRxrf6J/zB2qQ5SonKs+Q+GHIcoeqdyJBrV1TOZrg5krDRi4NSCsmCAhZ97N4R9vlK/zsuTbTiqY0R757XUSbdX720Cv6WK8ODTK6MjupC1Jq4+BWha/JZRK8AtBpAB1Tu41FQFGkzxgoXDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6749.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Fri, 20 Mar
 2026 15:05:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:05:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 15:05:00 +0000
Message-Id: <DH7PABYW5E20.JDWRFX88KCL7@garyguo.net>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] gpu: nova-core: convert to new dma::Coherent API
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-9-dakr@kernel.org>
 <DH7OODCRB8WQ.1GBKKZZHTNWC2@nvidia.com>
In-Reply-To: <DH7OODCRB8WQ.1GBKKZZHTNWC2@nvidia.com>
X-ClientProxiedBy: LO4P123CA0510.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 2776db4d-f88a-4723-2f6a-08de86920f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2ATnw3/cjdMqLRyQ+2xo4Vii04y6gsfAzvPpWHvOhJoIoRYzOUd0lvhghwMVrS9Tcb9XzQJ2UgWVVeDT5OK8NCLbbk998z90i7oyK1DIpD2aVSLnoRUB8CgksJxX584WdOEr7VTH8zJ6LK3/IlKpvcJ0to2RuJ+eVt2+flnIhlbtLei8rhae8sCI0ytEbX0SkSpEWSXxwlhrxqGgbgRD2P1mT7ei4Bibqbf9B7WKSrpgCcaRi8lSUL11GWxsU3p0AROEwAttl2fVwD6mDPy+ZeshJbbN56vmsdY8jSd4t/tE1VAk8rO/Y55vuPktOIJA1jOA40W2lm78rGZRKiHTXUaD/a3GQ5AP+eE+5QEXDuIuL1IueZhl2nWmd7fDyrTtVHha5O0ggn+fCFRtDPoosb7iEwm9LU90qlNiAKIQJKN8vSyH5AdAXzDidq08hrRC9/1LyLd9vLO0AFeripPlc5rJwSKcubA2oAMUbTFSbtI9v920CepZfBjGUdFvnDbDn6NVradqCsGQNckHcKdPqTRpUR5qCnLa/swT9vMdHVb8JapXv4lSgw461BnLcTjbZ88Kx2ftHrDJIjNPxwKVbOuqT5CdRSi3oqBVh8c0jIwpaW+6886yUBW6/I3T6mDty2Z4+T2a4x6yIUsoLVrGLaJBSijrduyeGOwTgH+3X+9FmOsJeJP5AhCUpyDwLKv5aUderOqFVdFne5ac6Fh+KjaKc48bmuBwBKh0Awip7JQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRUK0VxM1pqQ3N5QWNwZnJaRVlpSWNqWHIvUmplS1ZpbC96bGYzZHlWVjNM?=
 =?utf-8?B?eFloanhzMExWZWpOeGJRZ0RZWmV6STNFRHdoRzN2UXBFalkweDFvK3dybFRW?=
 =?utf-8?B?M1ZTWERLTkQzbnhCd3RwaEw5V0xGTEpvdE9tMDUzeDA1WjFaUk1hZzR3eFNB?=
 =?utf-8?B?SE1Uckxzc1BybUJocjZpT2hpRXBxNEFsWWNNUjhwNWdhMjZIUDBLaURwT0lj?=
 =?utf-8?B?K1RSUUs3Qkp4eFQrY1JhWGdpazJ4MHY5WkZ6L2RhcjM3cXRxUldEUzNVWVBG?=
 =?utf-8?B?Um9mYjhyaEMvcHZqT3F3ZlRabmpCbTh1a0tDaERMT1RWQXRsWFU5RE9zR3Uz?=
 =?utf-8?B?SVN1d2hsSFh2Q2Zid1dpUHFNYk53NGFJSVoyWWE4TkgxclNseVZzcml6bFNp?=
 =?utf-8?B?NDlXRkZHSVpibjMrY0N1OEJOMTRHSkM4S2hYYVVJRWp4RHdSbzVqSHo4VmJJ?=
 =?utf-8?B?WmR1WXBOOWtBdG44V1ZUSUVZTHRzMHN5aThQT00yelplTHM2allWS0tCV1Bz?=
 =?utf-8?B?UW5OalVPbzJHdStCc3pwNVRlcmkyM0dYK2FiV1lNWFJiN0I2V2hJYmlSN3A0?=
 =?utf-8?B?cEpRRS9mbllBdXVBU0tXOXo1RGJQdnhKQWw2K25QSFdsR1JEYzVtV3dSVmZI?=
 =?utf-8?B?RWh2ekJsNXdhb1BkbHM0SVRlK2JrRkhpTi9HbXFIZTA2aWJrbmxIS0hNY3hh?=
 =?utf-8?B?Z2tab1VwZi9WR3FwWUxoditJeWZkS2JBcEpzZWNMSFFGV3lDM3AyaGhkYy8w?=
 =?utf-8?B?QXJZVDdySng2SnFBdDNRNXVGZ0hBUGtaMzVXK0c1ZzFYOUZmQkVvaXlsSzJV?=
 =?utf-8?B?Z0NSRExoWWFvc0JwRTYvQ2diQkRFc3NuRi9VOEVVUkxEdWZPeTdSQTY2czRI?=
 =?utf-8?B?VWxTU2dmUC9WTFdjQm1aT2lodVVyWGZDdnFmTVFpMHlsSnJ6c1BvV1orbGl6?=
 =?utf-8?B?WUhRdFFTd3FmWHhkNVlaSkZwQVhNVmZFYzI3RVFIaWFZamFSK1kxRXRxdmg1?=
 =?utf-8?B?M2gzajlqazRFVGM3QWRNN0pqcXN1bkZGUkRnM29sOTYraTdYV1ZQakJGUG1G?=
 =?utf-8?B?SVh2NmtuQWNNQktZYVUyOXljbVhZdXFOU3dyU2IxaCt1ZzgvZk53T0hQaU5H?=
 =?utf-8?B?ZHh6eTlQNXhSNWM0RzZ4bmNFYkhOL3FVaG9BcjlWYnZvZXFXcGNibDIwVFlt?=
 =?utf-8?B?WjE0UG5xYnM5Y0RuWm5JbGkwdUpQZFhGV3FEcHFpMVFtMEMzWUUwVHhlcS9u?=
 =?utf-8?B?MWFvUG5rS2lhUEFSb1pqR2xJNVhiOThIR3ZBSkxRbGJJSGlsUmh3bng5M3I2?=
 =?utf-8?B?THAwbUVrd2tmVC94aG1jSzBEYk1ZZkRnVzF0RDd1WHZXcDgyZklxbTdjSWJ3?=
 =?utf-8?B?YlREWXlYWG12a3BYby93bzFwNWJiZ01xcThWOG81cjBwUnhBbDlSTDJ4OXlW?=
 =?utf-8?B?ODYzQmFQa2syYVc1d2FxbEVOdWxuak5xOHQ0RzB2RVhMd0U5SkE1ZDN2Q0h6?=
 =?utf-8?B?Rmo4SzRqZlRzb3ZVcXcrQ295MFhtK1NsZHprbDJ1OVhXN3RIMzFwRHpNNHQ3?=
 =?utf-8?B?ZG5yNStTMnlMZFVhdzF5Zy9hakl3eVNQMGpCbDA3YU1jQThML3djS2U1Vngz?=
 =?utf-8?B?Z3Y0Z2lJczN0Z3FXUmJqS3VweGFqbnlhU08xZHBHS1QyZDBuYU5adFZ5WjZ3?=
 =?utf-8?B?YlFYODNETXAzUlVyZXlURVROcFh0QUhTdkpnZGlURFZ3aUJhSnZJRU8rb055?=
 =?utf-8?B?dzBmcUNoamhHbDBKOHJQZlZhcnh5ZHAvazhoTGxyZ0JEZmg4a2duR3crUzho?=
 =?utf-8?B?UDdvS0VYVjFzOVdXSzBhQVJrUGkzVDlKZnJVMVBMYklsYVM1a2pYRDB6Tk90?=
 =?utf-8?B?SSsvZ2F2Zk4wOXRYTlZiZ2llUHFabitQa1RWZjlub2ViYVhDM2pEclc0SGM0?=
 =?utf-8?B?RHF2RERGMno2Z2lwWU9hU3pRUVFjZ2ZZbTFTeitSeXNvMDd0bExkVmZKcnpt?=
 =?utf-8?B?dGJaMk9iL2s0L3dmdzB5MzNwbXhFUDhlbVI4SkRqOWE3Z3FVN0h0WDNqMWJP?=
 =?utf-8?B?WUVwQnk0MkhvakRVZUo1bmhSbWcyYmF5TU5NaVlkRUxLNHRCZHMybmhUUURL?=
 =?utf-8?B?WjMvVGpEdDBnY2FYT0kvbGdDYkN4WWI5Q3QrWjRCUnp5RmF4SWJkS0xwbUJk?=
 =?utf-8?B?TzhtZ1NQTWkyWmI3aUg2TnV2VmJnV2lRVGthQSs5WkdXR1pTbUtwNWVJb2x6?=
 =?utf-8?B?c0ZBTnBTS0NJb3pNbjBybWdUWW5RcFhXcEdyRFhlbEJ6UUtCdVNEYmxQOS9J?=
 =?utf-8?B?TXZyekxFTExFT3cvTHEwdll3T1hicFhxWVFrYlJlQW1SMkk1Z2F2QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2776db4d-f88a-4723-2f6a-08de86920f25
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:05:01.1548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwlr+r+D4nKl/POpn/SOklr+BjKdyrr+BEdgbODo4FVDIZV1LCsip+FQ/gUfEAGcP8bg+j0w+f1mQ9GFwOWuIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6749
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

On Fri Mar 20, 2026 at 2:36 PM GMT, Alexandre Courbot wrote:
> On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> Remove all usages of dma::CoherentAllocation and use the new
>> dma::Coherent type instead.
>>
>> Note that there are still remainders of the old dma::CoherentAllocation
>> API, such as as_slice() and as_slice_mut().
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/gpu/nova-core/dma.rs      | 19 +++++------
>>  drivers/gpu/nova-core/falcon.rs   |  7 ++--
>>  drivers/gpu/nova-core/firmware.rs | 10 ++----
>>  drivers/gpu/nova-core/gsp.rs      | 18 ++++++----
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 55 ++++++++++++-------------------
>>  5 files changed, 46 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
>> index 7215398969da..3c19d5ffcfe8 100644
>> --- a/drivers/gpu/nova-core/dma.rs
>> +++ b/drivers/gpu/nova-core/dma.rs
>> @@ -9,13 +9,13 @@
>> =20
>>  use kernel::{
>>      device,
>> -    dma::CoherentAllocation,
>> +    dma::Coherent,
>>      page::PAGE_SIZE,
>>      prelude::*, //
>>  };
>> =20
>>  pub(crate) struct DmaObject {
>> -    dma: CoherentAllocation<u8>,
>> +    dma: Coherent<[u8]>,
>>  }
>
> Actually, do we even still have a need for `DmaObject` now that
> `Coherent` is available? It would be nice to check (as a follow-up
> patch, I can look into it) whether we can remove that whole nova-local
> `dma` module.
>
>> =20
>>  impl DmaObject {
>> @@ -24,23 +24,22 @@ pub(crate) fn new(dev: &device::Device<device::Bound=
>, len: usize) -> Result<Sel
>>              .map_err(|_| EINVAL)?
>>              .pad_to_align()
>>              .size();
>> -        let dma =3D CoherentAllocation::alloc_coherent(dev, len, GFP_KE=
RNEL | __GFP_ZERO)?;
>> +        let dma =3D Coherent::zeroed_slice(dev, len, GFP_KERNEL)?;
>> =20
>>          Ok(Self { dma })
>>      }
>> =20
>>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: =
&[u8]) -> Result<Self> {
>> -        Self::new(dev, data.len()).and_then(|mut dma_obj| {
>> -            // SAFETY: We have just allocated the DMA memory, we are th=
e only users and
>> -            // we haven't made the device aware of the handle yet.
>> -            unsafe { dma_obj.write(data, 0)? }
>> -            Ok(dma_obj)
>> -        })
>> +        let dma_obj =3D Self::new(dev, data.len())?;
>> +        // SAFETY: We have just allocated the DMA memory, we are the on=
ly users and
>> +        // we haven't made the device aware of the handle yet.
>> +        unsafe { dma_obj.as_mut()[..data.len()].copy_from_slice(data) }=
;
>> +        Ok(dma_obj)
>>      }
>>  }
>> =20
>>  impl Deref for DmaObject {
>> -    type Target =3D CoherentAllocation<u8>;
>> +    type Target =3D Coherent<[u8]>;
>> =20
>>      fn deref(&self) -> &Self::Target {
>>          &self.dma
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 37bfee1d0949..39f5df568ddb 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -25,10 +25,7 @@
>>      driver::Bar0,
>>      falcon::hal::LoadMethod,
>>      gpu::Chipset,
>> -    num::{
>> -        FromSafeCast,
>> -        IntoSafeCast, //
>> -    },
>> +    num::FromSafeCast,
>>      regs,
>>      regs::macros::RegisterBase, //
>>  };
>> @@ -434,7 +431,7 @@ fn dma_wr<F: FalconFirmware<Target =3D E>>(
>>              }
>>              FalconMem::Dmem =3D> (
>>                  0,
>> -                fw.dma_handle_with_offset(load_offsets.src_start.into_s=
afe_cast())?,
>> +                fw.dma_handle() + DmaAddress::from(load_offsets.src_sta=
rt),
>
> Aren't we losing the bounds checking done by `dma_handle_with_offset`?
>
> Mmm, but looking below we are checking that the end of the transfer
> doesn't go beyond the object bounds, so that was probably redundant
> anyway. Maybe we should do a `checked_add` still for safety.

I've had this as `dma_handle_with_offset` no longer make sense in the conte=
xt of
generic `Coherent` type. Although, I can probably add something like:

impl View<'_, Coherent<...>, ...> {
    fn dma_handle(&self) -> DmaAddress;
}

to replace this so you can get the DMA handle for any projections of the
coherent object (and the bounds checking is done when projecting).

Best,
Gary
