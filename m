Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A4BFC0343
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C1F10E344;
	Thu, 23 Apr 2026 15:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="BMNS0ckX";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622E310F19D;
 Thu, 23 Apr 2026 15:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOc2B7Vy5HinqHWmHbo5vWnv9oJIXA/pZmH5BSiyfwnxH9jPaH3o6RDta4DgbdTe6nnUeEDp+ssj9pg046ZVdA789WUpXjofchjz98pgjdqcG7rj+DxkwC7ALyoyF9XpYH6TRJoZWnetrlbSfqebQZBt5XBJFZuPc2jzIEDHZm9O1qUHadPlalRStX6HqSjIHkwxoY5GXt9dZ8Vmn0bpmQQjU7EjYyRt22OxaWdKU7/P3CGVG6bPmUjLMDHfyVQh5GLW0+NfiO8THfP0wwc/Kc2LuaXkGzvbEivr8XEkbdkmtYZweOMtBLAxwXAqFD99oG7aoDOqY7teiC32t609kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjnxWQurTN5WqSRabRV2JjUBe683OgLy2S72Ve+Czs4=;
 b=Mgy669eSBvnSqdDj1DjYCrNOobT9r0RxV45DB1irqJXgdWc72xLAepdIP9d1FMXTAhZDD4U/ehU975lXRrLQWOlb+8Xz+k49Dxwm8lrmZTqL13RIoJ/FbrC67kXBLR5vG5b//Wm+asvR0E9KTUcFoGLeMjXHKPcwcFPlBRZxW1/mrSNExtlFSJNqMbMkFbuRUqJ1AGYnRAPM1aTibQPtxEno0AGz/ysY0RfmRst6VTrPk4gClTFWzIFj9ucT8EXMeDL0Dhk8VU8oKXr+L1de3legb8oYZx89eQARlhYocBEH7RW7ZWgTOZk5QkOj6MzjgiYy8eB2XgW8P7hqSVi+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjnxWQurTN5WqSRabRV2JjUBe683OgLy2S72Ve+Czs4=;
 b=BMNS0ckXzpN4z8UX0hphFlVG9kQKtYBU5havDTL/ef4/cQtcdUHCKZuOR9WalxehNhbadSTcwYVi/BbOrD01tqcOGaxMVoo5V49/Fdtg7v151JP5EQTBDmk3LyHX5/nACEeoYZa1BrOkGNEL5qW4LE8qpIuNQD0C+NZBTXbevRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB3172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 15:09:35 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 15:09:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 16:09:34 +0100
Message-Id: <DI0MOCJ8BO4A.37OS3YPF3VPK3@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Lyude Paul" <lyude@redhat.com>
Cc: <nouveau@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Matthew Maurer" <mmaurer@google.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, <christian.koenig@amd.com>, "Asahi Lina"
 <lina@asahilina.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Krishna Ketan Rai" <prafulrai522@gmail.com>,
 <linux-media@vger.kernel.org>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 <linaro-mm-sig@lists.linaro.org>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <kernel@vger.kernel.org>
Subject: Re: [PATCH v12 4/5] rust: drm: gem: Introduce shmem::SGTable
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260421235346.672794-1-lyude@redhat.com>
 <20260421235346.672794-5-lyude@redhat.com>
 <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
In-Reply-To: <DI0MI6UF325Y.2TDWZGCN3WGIG@nvidia.com>
X-ClientProxiedBy: LO4P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::14) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: 81912077-307a-4179-0da2-08dea14a5487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kxZG9j20vcUDaxQz2LF4Dq3lJPHRGapUmK12RsukElnGZa8JyZ8DcjNVuGFqqd565XmrHkvVbM6lHxcBu1+VkqUBUz7eg00uQhyNellXHftZguJyd0AQmX5Y1zcZQUVbRfHPqjvN5ugdyRBiHTpNclCoK/XWT0gzF00Z7jA/KtyKqlG94qGlOWtx0x+A75b8v3LWHuabKHIpLCwV9sMYYvKKC1MAs8/JmcSuIY+55r4h7fzs5HixsSJsyeaAY0KQ+pZf0cxwZYFPaLXXJJTAQwyR+t5n6wbsPqYRz48Ubx3xkq0V07RyFDGzNjx98E7EIVgfoXQJWW4aML0FbVu76s9AZFFzJV0j3vhc0bY5VKyoO6fdl5rfMY6N/Pk8L07IkhsdmGQW8OzFJ27dSaUdN5d7Aki4YE8lHKa/w5ZvqXkdgSXqI78aP0LvVpCG83omKVkh4GdQKH6ke8cHzRrjF1Ym7AlQoaiteXMTzptGMJD0pIcED8BYt1gaaTnD25LqjBGlfCULgf/mkO7tlg3IWn58IKwcBxJIBcgN5NMu7mxrjBAOfyjBsI5oU8hds8KZdyvhdrtCclwevxSN548xqV6mShHyczv82NOWRBxyW2vU+9kp5Mj/r+SuvoBnYhZCIq5zBS1r9ehOFXwzLSZ4vFWQQZ/b6wBTMx91kG60oTI3/bM9yA2ap6QD97IuNXd2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZyWUMwTnBJWGJNenN2L3hVaXk1SnlmYyt4NnJhSEsrSmdHbWNQTDMrT2tT?=
 =?utf-8?B?Q2FDdXd4Z1RMQWdoSnhra2MraTg0TFg4SndDaG9vWkdjSyttSS9sMTdpK2RF?=
 =?utf-8?B?MFc4Nm5QVWhacVZZeXJQU0FwaUp1clFhWUViYTYwY0JRWkJUWVN4ZXhtaUJw?=
 =?utf-8?B?QUQvQjNLK1N4MTN1YkF2QTl6L3hxUkZDWjltWVBHYXhHNDhLaXJXN3U5NjBu?=
 =?utf-8?B?SWtHK2xlQWR3VmUyeFp2YVp5TThSeUpSRzRCZXgwUExnYUdKWFRaR25tNzJv?=
 =?utf-8?B?RlZQZUtnRXJNTXJkQ1VGcnBnR1hJajFuRTdEcWVndzEvSytsNnFENHByaUc2?=
 =?utf-8?B?dWQwbVdVSTUxSHVaQzE5R2dnd1ZERDNRa3IzK1kxS3BrWXVJRjd5NFVCaWY1?=
 =?utf-8?B?ZGJuZGMwcUJ6Ri9HREtheWFhNUZwMDc5a096bFd2enhTc1R3Z3F5TFZ1aHhV?=
 =?utf-8?B?OG94RFY1SVhNd3ZWV1djVUZHZGRJbGw2T3BVemxwbmNsL2Vyb2tHcnJreUth?=
 =?utf-8?B?Q090dlB2bWJBTDdSL2NodTRRUFdZMjNaVFhrQ1ZlVnZjSUpJbjJhZlNjT2pV?=
 =?utf-8?B?QnE1Y1ozem1nbmdDckJiQ1pLdzVBMU8vdjB1REhSYktRM3ZoK3lIbGtCR3J1?=
 =?utf-8?B?RU94b1hRQUJJOFhsOGtlSU9CQUhSUnZmNEd2cVljWVY3ZU5wTS8yVlplSmxz?=
 =?utf-8?B?bDNpVENtV1VMQjMwamtwMmltdjJsSXFweSt0NnVYbjU4Mm5HRVllNnhZVTcy?=
 =?utf-8?B?QjZVWHovQ0h4TnkvWmZzWW1DNi9BVVA1ZUlVNHQwdVNkMU1qQUpQNURFTGEx?=
 =?utf-8?B?Y09ZU2Y2RVFGLzRQRDFQR0pUNyt4dnF4SkQ0QUFXNW1RMXUxSEIrc2RydzVj?=
 =?utf-8?B?cTVOWDM0OTBDdjN4UEhVdllTOC9YM25RaDNaVnJZM29rWmRaSTZ4S0tMblha?=
 =?utf-8?B?Z0pHZGg5Y05vOWlja2REZkpWcGc4di9rSkJta3RlcW1jNVNJeW9RbGFLMTM0?=
 =?utf-8?B?WUxJTnpuOFM4b0pncDlhbXlYQzlUYWs0N2JLakdHd2NqL3k2MGFJMjNUVXp3?=
 =?utf-8?B?NkZPMWFLblZHNUZCQkJqUFIrbEtSV1lrbEgzVklDay9PdStLK0x1SVNCNXJo?=
 =?utf-8?B?Y1NCUmxPejBGNm5CbnBzNitBRnJLRWc4ODVqa0lBTnpkODdJQXFSbnl5aWRh?=
 =?utf-8?B?YTFKRUZKQTJYR054TW9zdmdhZHlra256czdTV2JkMVcwVWxweVBDcmZibUJD?=
 =?utf-8?B?cEVPVHF3c2I4bGsrdHFPVWR1YmZNQnVaVFN4WXB1NVIwK3Jyc0xyMG9QaFVU?=
 =?utf-8?B?TGgvd3lRaFR6QmRUTFNWYTJpMU53TTQ3Mkx3VnE0TUs1ZWZsRXJvTnlGR2Y2?=
 =?utf-8?B?aTN1VDV2dXpzeGZwdUordjlVWS9YbVRvVndSVUN2R2cvZUoxWHJydVg5K1Js?=
 =?utf-8?B?SmFwbmFGcGFTUTg4U2pPTDJBbXhURGZEQi9jTEFyR2R2T0ltWC8wRXpwc0dv?=
 =?utf-8?B?dVNJOXVaa0piMGdRQUdyWWZCOW9TUVBEMWtRLzllUlBCS1hTNzBIcVlLNkRn?=
 =?utf-8?B?VE9ZZ3NtaUdvd3NaVk5qaDl0TkJhMCtYVjViOWwvU1ZqZFFDdkdBTXJiMGRH?=
 =?utf-8?B?T0EwajFTdE9STXhXaTdSalB0Vk9nUHYvSnF4TmtqZGg0U2xvSnh0VEJ1ZFdz?=
 =?utf-8?B?ei93RlliRCtZRC9OM0lZRDdOUWVyZFVVblY4Yjc2MkxobitzYWpNclRYVVVJ?=
 =?utf-8?B?YmVkL3N0WFFzVmhYRHpIaVRaZVoyVllhRE1GenhpSTFhS1pVUkEvMmpHcUJH?=
 =?utf-8?B?WFF2QVNKOUtXOENpNjJCajZQK2F0a08zT0k0VlFtTWxoYnNWeW8rZUZ2MS9m?=
 =?utf-8?B?MG5WUTVmZXVYSlFJaHF6MUcwQ3RzMjVQaTVySVFxaVkyRTgxTjFMSXg0NU9O?=
 =?utf-8?B?am05UDV4NWM2ZWlsVVBwNUttTFg1dEV1QnMyb212cUZVSE4wdDk1NWh5MHQ0?=
 =?utf-8?B?ZTFaNkZFcHdobzJkTHFOYmhQMll6cGxtZFN0bTI1SGFkRWtYeTQxZk14Y0hN?=
 =?utf-8?B?MmZVcHNzRWNGaHJFa0t0cmlhQzRJRzFiSlF0SjgvNjlLSi8zcHo3ZTkyZWVx?=
 =?utf-8?B?U1piWENjMlJMQUhKamNZY1B3K2wrSnZCZE1xWG1YbkFFWTJyTGxlbXdDQ1RH?=
 =?utf-8?B?QytTbGt0OWdEWU5ZZHNnaEh5UDdDNkcwTXgzcTJUcE4vcmQ1bTZNRzVucmRI?=
 =?utf-8?B?VmZCRFEzRkVCR0pTYW16WklQaUk5UWVhNWNSbjJHZVl2eFpCU2ExSnJZKzNJ?=
 =?utf-8?B?Yi9mazA2NjUxVldVbjRla1BRdUZRNytRRHVUWVZxMUVvampWakZmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 81912077-307a-4179-0da2-08dea14a5487
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:09:35.2099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHItKrhYjlqkHORAjxsZZ0ImqnT8fiO1aT3IJ6vc5aRfN1qPbxV+NnPTHuokXaiERPn8+HPQigeJ5xKZKnoQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3172
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

On Thu Apr 23, 2026 at 4:01 PM BST, Alexandre Courbot wrote:
> Hi Lyude,
>
> On Wed Apr 22, 2026 at 8:52 AM JST, Lyude Paul wrote:
>> In order to do this, we need to be careful to ensure that any interface =
we
>> expose for scatterlists ensures that any mappings created from one are
>> destroyed on driver-unbind. To do this, we introduce a Devres resource i=
nto
>> shmem::Object that we use in order to ensure that we release any SGTable
>> mappings on driver-unbind. We store this in an UnsafeCell and protect
>> access to it using the dma_resv lock that we already have from the shmem
>> gem object, which is the same lock that currently protects
>> drm_gem_object_shmem->sgt.
>>
>> We also provide two different methods for acquiring an sg table:
>> self.sg_table(), and self.owned_sg_table(). The first function is for
>> short-term uses of mapped SGTables, the second is for callers that need =
to
>> hold onto the mapped SGTable for an extended period of time. The second
>> variant uses Devres of course, whereas the first simply relies on rust's
>> borrow checker to prevent driver-unbind when using the mapped SGTable.
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>
>> ---
>> V3:
>> * Rename OwnedSGTable to shmem::SGTable. Since the current version of th=
e
>>   SGTable abstractions now has a `Owned` and `Borrowed` variant, I think
>>   renaming this to shmem::SGTable makes things less confusing.
>>   We do however, keep the name of owned_sg_table() as-is.
>> V4:
>> * Clarify safety comments for SGTable to explain why the object is
>>   thread-safe.
>> * Rename from SGTableRef to SGTable
>> V10:
>> * Use Devres in order to ensure that SGTables are revocable, and are
>>   unmapped on driver-unbind.
>> V11:
>> * s/create_sg_table()/get_sg_table()
>> * Get rid of extraneous `ret =3D ` in shmem::Object::get_sg_table()
>> V12:
>> * Actually move sgt_res in this patch and not the next one
>>
>>  rust/kernel/drm/gem/shmem.rs | 192 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 190 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
>> index 11749c36e8695..a477312c8a09b 100644
>> --- a/rust/kernel/drm/gem/shmem.rs
>> +++ b/rust/kernel/drm/gem/shmem.rs
>> @@ -11,25 +11,38 @@
>> =20
>>  use crate::{
>>      container_of,
>> +    device::{
>> +        self,
>> +        Bound, //
>> +    },
>> +    devres::*,
>>      drm::{
>>          driver,
>>          gem,
>>          private::Sealed,
>>          Device, //
>>      },
>> -    error::to_result,
>> +    error::{
>> +        from_err_ptr,
>> +        to_result, //
>> +    },
>>      prelude::*,
>> +    scatterlist,
>>      types::{
>>          ARef,
>
> This fails on master:
>
>     error[E0432]: unresolved import `crate::sync::ARef`
>       --> ../rust/kernel/drm/gem/shmem.rs:36:5
>       |
>     36 |     sync::ARef,
>       |     ^^^^^^^^^^ no `ARef` in `sync`
>
> Importing `sync::aref::ARef` seems to be the correct way now.
>
>>          Opaque, //
>>      }, //
>>  };
>>  use core::{
>> +    cell::UnsafeCell,
>>      ops::{
>>          Deref,
>>          DerefMut, //
>>      },
>> -    ptr::NonNull,
>> +    ptr::{
>> +        self,
>> +        NonNull, //
>> +    },
>>  };
>>  use gem::{
>>      BaseObjectPrivate,
>> @@ -61,6 +74,11 @@ pub struct ObjectConfig<'a, T: DriverObject> {
>>  #[repr(C)]
>>  #[pin_data]
>>  pub struct Object<T: DriverObject> {
>> +    /// Devres object for unmapping any SGTable on driver-unbind.
>> +    ///
>> +    /// This is protected by the object's dma_resv lock. It needs to be=
 before `obj` to ensure that
>> +    /// it is destroyed before `obj` on `Drop`.
>> +    sgt_res: UnsafeCell<Option<Devres<SGTableMap<T>>>>,
>
> I didn't like this `UnsafeCell<Option>` since the last time, but only fig=
ured how to replace it now:
>
>     sgt_res: SetOnce<Devres<SGTableMap<T>>>,
>
> It's actually designed for that! And lets you remove at least one unsafe
> statement, while simplifying `get_sg_table` quite a bit. With the other
> suggestions I have below, here is my version of `get_sg_table` for
> reference:
>
>     fn get_sg_table<'a>(
>         &'a self,
>         dev: &'a device::Device<Bound>,
>     ) -> Result<&'a Devres<SGTableMap<T>>> {
>         let _dma_resv =3D DmaResvGuard::new(self);
>
>         if let Some(devres) =3D self.sgt_res.as_ref() {
>             Ok(devres)
>         } else {
>             // Only called for the side-effect of populating the GEM SG t=
able.
>             // SAFETY: We grabbed the lock required for calling this func=
tion above.
>             from_err_ptr(unsafe {
>                 bindings::drm_gem_shmem_get_pages_sgt_locked(self.as_raw_=
shmem())
>             })?;
>
>             // INVARIANT:
>             // - We called drm_gem_shmem_get_pages_sgt_locked above and c=
hecked that it
>             //   succeeded, fulfilling the invariant of `SGTableMap` that=
 the object's `sgt` field
>             //   is initialized.
>             // - We store this Devres in the object itself and don't move=
 it, ensuring that the
>             //   object it points to remains valid for the lifetime of th=
e `SGTableMap`.
>             let devres =3D
>                 Devres::new(dev, init!(SGTableMap { obj: self.into() })).=
inspect_err(|_| {
>                     // We can't make sure that the pages for this object =
are unmapped on
>                     // driver-unbind, so we need to release the sgt
>                     // SAFETY:
>                     // - We grabbed the lock required for calling this fu=
nction above
>                     // - We checked above that get_pages_sgt_locked() was=
 successful
>                     unsafe { bindings::__drm_gem_shmem_free_sgt_locked(se=
lf.as_raw_shmem()) }
>                 })?;
>
>             self.sgt_res.populate(devres);
>
>             // PANIC: `populate` has just succeeded, guaranteeing that `s=
gt_res` is populated.
>             Ok(self.sgt_res.as_ref().unwrap())
>         }
>     }
>
> And if only we could populate the `SetOnce` with a `impl Init<T, E>`,
> then we could even remove the DMA reservation acquisition on the fast
> path, because `SetOnce` comes with its own locking and the DMA lock here
> is used outside of its intended scope. I'll try to push the necessary
> work for `SetOnce` and maybe we can do that as a follow-up patch.

I have this sitting in my once_wip branch for while
https://github.com/nbdd0121/linux/commits/once_wip/
(the specific commit that adds init support is
https://github.com/nbdd0121/linux/commit/4aabdbcf20b11626c253f203745b1d55c3=
7ab2ee).

This was implemented for lazy revocable support which Alvin has picked up, =
see
https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-1-074badd=
18716@linux.dev/

Best,
Gary
