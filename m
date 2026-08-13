Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9FFC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD0010E187;
	Thu, 13 Aug 2026 07:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ql8WqJTu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177B510F1AC;
 Thu, 13 Aug 2026 07:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzd36PS3J3rIV+KIQIxypiFr7AjIdo6UH1BooNypyVpgRQNdMcXioy4naKjQ5oTL46MFWHAordyKIYoAYnsPLsTIQyn8+KokgR/KmYQm11nJqOOFHH0eySeeLF/C7khbji8dtaMWAufcEVgN93TwcaZK/RcLs2fS5Z8hDW7R7VOanQKQ7VXlucnD4oX9b1K5/KQvY0Xf165EecVjTRdF6xl7Xlf30vPdkl8htZo9KTJdTSEjP/9mxcOEPsvASLVVEAlqZGVULbwFjDRp/DFOju0YujkxHTD35Oe4wnVjZis8v/cpgMupgD127Ku8XShoqYm1vVMVgwVqr7wuAiScRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXfsuvpPdeBk8ghD8goxoBUsV+lIQDUqH+kWw5h//1Y=;
 b=uvyt8cSTkwrNS9Mh3qxPSUGiH0nwNAuclfOAL0/GaOJL1sgN4g0YTP1ojJecvwTwVWbN7M0gyuv0p3wpG6ck3NCNGb7irv/GIxdkVb3PVgb5lrnwn47pxU4Tt8L17xWDCe/MHHgYby8/rbc5c7U1cj4XEIJA03W/JrhojQv/3plFtgpVTdEydFPrEiL2vbmpaH2UEay7xggkMXYW/5Imo6iuQLoBYm3a0/OhPLJf/QdI5zk5IVnb5tGO7kH9vkBrmfxzaOw82u+P8QCN2wpRgsBBDEsJLHthdIBQUH01Oeq4f1lyOHt72s9kxB/6ZlHuknXVRlwVNKPPAYcAnepP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXfsuvpPdeBk8ghD8goxoBUsV+lIQDUqH+kWw5h//1Y=;
 b=ql8WqJTuMe5b6kjCJeh4D+Ek0CEQU/NgBPVC2AB227x64GcOdbB+eEqf2VUQxuloAdYMPBmJaNfGLy3lwuC+b7cn7b2KUcq5C9ANzouP1EShnuRP1DU+3XlifsdED719RchvYVnBvOXgkRe0q+vNMLeW79y2XGQMCr0/Pb4JL0Qg2ZEtKpBSS1xuFxHW9xfwfCUmpFo+Wgj7cV7LbVbJbSMSxn/fO4P+k8fnZY2jlho5DwvUTpLxPChkc2GDG6NT/b/sPrdTG4I5wpsQaIvb1W1hViZxMgOjG4g2eUjRtrW/42aOc53duOjDlUzMDOxeqgExGaTqLi3ddTEkgtbwDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:27:23 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:27:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 16:27:18 +0900
Message-Id: <DKNMZFISQSKV.1CBCZTDPMT5RW@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 3/5] rust: bitmap: add contiguous area operations
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-3-6c767770b3f4@nvidia.com> <anzYJhbIr-aix4qX@yury>
In-Reply-To: <anzYJhbIr-aix4qX@yury>
X-ClientProxiedBy: TYWPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e415eb-1b31-4af7-bdf3-08def90c50d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: j4MuQucmEjJO52DCY0hdrDprxOYcELntAlQKX6ncyq5PcTlpELlHI3dmRmmu/8s4QVP2JfN0qRvjxgTLRFyGiQk/+PhchCHxULqmM6KMSd6/cwP7GLuzV3l7anuGV0qZLxpJdMxW6Tpuq027+7/F2AWlD87aQm+b7WFHuPGufpy8leBZlv/ANGlABWBUsWQdHWS8FPl7EMHXE0ANuhRpLgQgHlSRI03IoTBziIM0xsEKbZFK/k+2m5kv23UmaH92Q9iqBIY3C9fTcASmjbre/Rp55hkdfV47fT+OXpwKZheLOaMudwEs28L5Me1ie1Z7QKYvI+AQUjvnEfDDDuMphZjo/pULlTNFpq5Z/wnDV9IWez5XaKti8A/NvzpRNUsBArY+QVJJpB2s1yume9N2my6+b37XpLPduL9I7B5bQsfN4nHevMLlJUH7RRjsE1gJfh+6uWsJaQ+1gqOULa9rcBzclmI6ONQ9RJd187XXXx6qGo/K0umvpuif4qXkmxyu5YGCN+dgdKx/P64YMGlaO4ftbu9qjQPwH27g/QIuC1PoyKjFjVC4Qluq+qLveMnLQhNTJPmz4JO1Ld9aVwLRBXWnHBVK2lF5kF7cc0CvCCLXgFkGZZHaUDx6hoB3GuZESuqkJNXGilUbkbTEeRtxuuh1u5bj7EZ0G+IMS+KkUVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JWbk91bW5KYm0vbFl5SHF5RnB1T3VJbHd3KzRzUS9JcG5MSGc3V2ZPZW1h?=
 =?utf-8?B?bWhuT0dYMDdvclVmT0Z2cnVWZk9EaU4yL2x3OHlIUklXeDdYak5CMUMwbkNq?=
 =?utf-8?B?OElYOFB6MHZzZDVSblNNYlNSdDR0bC84ZEdWUWwrTnNYM3NFN3owYzRucGJa?=
 =?utf-8?B?NUtSMWRraEdNYzMrRTAyK3V3OEZ0UXFIZmhDdW13QW8vNHV4aCtZaDNYd0dS?=
 =?utf-8?B?M1ZIbGp4WHJ2ZktYN3ZsMmgyUlhLbXoxZ1NLRUc3UVR1WFpBNjJKbzZqcXZR?=
 =?utf-8?B?SWpsanZhOTExK0ZsVTFETVZVQ3hlSlFWU1pXUnFGUWJaMFNVdTBSSTBRa3Fz?=
 =?utf-8?B?azQvTmtpNCtjMTNPTUFma0RZZFJHYU93SVhOYmtpb2QvVERqZ2pMamJ5ZEhS?=
 =?utf-8?B?QlBUM2xLQWRzNFg2WnUrNXJBOXlqblhObllvYm1jTVRMWFJIZWdVMDMvNHZy?=
 =?utf-8?B?VSt4eUxHbHNrMEM3Rjd5K1N2QTB5d1V2bkNQM3ZEazV6U09vYXNFaXpUcWQ2?=
 =?utf-8?B?T091bU9vdzdlSEE5c09uMWZkMlFiNDhkQ0dIV0hLOUtvclRWVXc2WTBRWGg4?=
 =?utf-8?B?RlFrSTExempJL0VsVjlZQTVQR0tzQ3BRUTdsZ2VWTWlvMFdUcjdQMHBlUThQ?=
 =?utf-8?B?eWFveHVCb1lkcHNhbWtuaUxjclJlQXpGd0FZUEJlNWJxTW0yWUxxSmtIM1F6?=
 =?utf-8?B?ZkxmZHFZeTlua1l0NUJFQkI2bGd1em5aSWROazkxbmRoeDN3Yk04dE9rQ05C?=
 =?utf-8?B?ckM5TWxoalAvRWFENFJlclBtWm10WjNzN0dOaC83Y1VTZ3p5L1lBQnpTYnFJ?=
 =?utf-8?B?emtCQlpxNUZpUnpCT2pOR2JYY2xLT1FLd3pybGlqc3FCRjhOSmUwM0J2SnBO?=
 =?utf-8?B?MmhuTGRzNGpUOGtONjNKb2ZHQVZKbkRQNVkybU5mSGJLQ0ZoQ0puS2Fua2xr?=
 =?utf-8?B?UVpVeE1OTUtPYmZxSU1mbU81OTd3NXhyMkU1OG9ReC9DZHQxK2k4TkRRRmMy?=
 =?utf-8?B?bFlFeGU2Z0lMajdBdVQ5SkY3ZUtFNHFjRjRieTVLOVFacmRRQnROK2Y3cXNQ?=
 =?utf-8?B?N2VRamI4NGVyN0dQZTVvY002NE1WczVDYTh2M2kyWEV1Z0ZETG9rQTRmcThK?=
 =?utf-8?B?L3h6TVc3RUIzUEJSWmdzZTN1OE9SMVNvOFJ0Qlp1OWtLWmhlMkZXbElSVTEy?=
 =?utf-8?B?ck90V2NZWFRzZ1B4WEdKZ2dRcGRnTEN5RkppcitkMzJlU2YyUlBiWk0rVnJC?=
 =?utf-8?B?RzlUQXRUQ1hlbjkwcGhpM05JQ3dCZklHdWhRM2p4NUZ1TFY3WnZsdjRMVkFj?=
 =?utf-8?B?MlprYW12bVZTUU52dWxLbkg5dHV0bDRLRldMTndMV0hISnlFS3V0dEphR0Fz?=
 =?utf-8?B?N2E2ckZGWDdmRlVyYjFpQnNwZXg1Tk9OcGJLRWxLWm41NDN2NDlzNGNJUG9C?=
 =?utf-8?B?Q2dPdVFvYjByNzk3d0ducWpHYUNFSWp4bTl6K214aC85T0VVODZRVFJEcitr?=
 =?utf-8?B?T1pNbVlDLzhZdmtzcm5RUERwZFMxZ1pRVmJpM0g5Z3IzQ25JdFJhMll0QVl3?=
 =?utf-8?B?U2FQMnRuQTI0YVg4RUF3WkJGNWpGN0paai9peEhQN21Kd0QreC9IWEYzRFEr?=
 =?utf-8?B?bi8zcERlUElSYmZCd1Y5TlZTaHp2NUt2bENtcGJtSG9aTmZwK2FMYUhobkVl?=
 =?utf-8?B?ZXBHVDBhLzQrdm0vNFFud043RlZPSFlUenZoUjZiaUVSTWxwRTBPYzhIMU1S?=
 =?utf-8?B?L3V3RjlKZUYwYmtablMyekhReVFRSDhxeFJaSjNnUkxNcnJHOWJiNWswRlB2?=
 =?utf-8?B?cHVjRUhiQmNZMjlaWnlGa0ZTN1pCbVlBR3ZQcWVpZkJqcHdKRUFjZ0loZ3JF?=
 =?utf-8?B?Q1dKeVIzTG9ONjdQWkhmdUJwYVJXV1FkS2c5QTlHS012MEhmcmFDWUVTRy9B?=
 =?utf-8?B?WVFBWGZab2VQK1RKZmxEMjJnc2gzNkhGMjVXOU5ScmtaaUxoMU1BWElGZS8w?=
 =?utf-8?B?Z2N2WXBrblVwRFV0N1BGNjJPWWxNWXRibnVDNlhzaXhFRno4bWM0RWNtU05r?=
 =?utf-8?B?aGUzRDd4TzdMKzFXVStSdXVVWVlmR2dJZEJxa2xXY1hPbzhvdUs0QjNoVm42?=
 =?utf-8?B?ZTQvTHpOVEJ1YzlPL1JTS2NhSXVML0VnTUhPbG56cFpIRTMzb0FRQ1lDQjhC?=
 =?utf-8?B?VGxtb2VBNUU5a0NXTGpEWkhjVUpaL25qRWpZN25xRi96NHBtNXB5eWgzckRM?=
 =?utf-8?B?cHcxYXFKdkFIT0M0KzYva2RQRFZ3Qjg3U0tZS1p1NlVCSTY5Zzg4Wk8yaTMz?=
 =?utf-8?B?Q01QQm94RG9ENk1sczc5UDVIUC82RVlHL29LS3FQT3RUK2diSUFCTXRtdzJD?=
 =?utf-8?Q?lOTuervmNDMzcOyL2ns6I8iU39KSMfUJGy06plh+J06mn?=
X-MS-Exchange-AntiSpam-MessageData-1: 3VT7UOg8VyI7GQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e415eb-1b31-4af7-bdf3-08def90c50d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:27:22.6685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3jlE/vUbz0sBvcbnPaonh9oxcErc8myq/9EeILDl5JI8h4tJrgdExcQ3y2c+vMTOQ/d1tVusE+N+QaS8UVMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

On Thu Aug 13, 2026 at 5:31 AM JST, Yury Norov wrote:
> On Wed, Aug 12, 2026 at 05:51:23PM +0900, Eliot Courtney wrote:
>> Add bindings for area operations on bitmaps. Each one is
>> made safe by adding some extra checks compared to the underlying C code
>> (for example, checking bounds) and with additional checks to catch
>> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>>=20
>> Add tests demonstrating the edge cases.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/bitmap.rs | 236 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 236 insertions(+)
>>=20
>> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>> index fdcfc0409773..74c92cc452c9 100644
>> --- a/rust/kernel/bitmap.rs
>> +++ b/rust/kernel/bitmap.rs
>> @@ -10,6 +10,7 @@
>>  use crate::bindings;
>>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>>  use crate::pr_err;
>> +use crate::ptr::Alignment;
>>  use core::ptr::NonNull;
>> =20
>>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>> @@ -523,6 +524,139 @@ pub fn next_zero_bit(&self, start: usize) -> Optio=
n<usize> {
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
>> +        nbits: usize,
>> +        align: Alignment,
>> +        align_offset: usize,
>> +    ) -> Option<usize> {
>> +        bitmap_assert!(
>> +            start < self.len(),
>> +            "`start` must be < {}, was {}",
>> +            self.len(),
>> +            start
>> +        );
>> +
>> +        let nr =3D u32::try_from(nbits).ok()?;
>
> What about nbits =3D=3D 0? In C, this is a undef, and thus in the current
> rust implementation. Maybe make it NonZero?
>
> The same question about align and align_offset.

NonZero sounds good to me for `nbits`. For `align`, it's already
guaranteed to be at least 1. For `align_offset`, passing 0 is normal and
valid (and we need to for implementing `next_zero_area` just below)

>
>> +        let align_mask =3D align.as_usize() - 1;
>> +
>> +        // The C alignment and end arithmetic must not overflow, or it =
can read out of bounds.
>> +        // Overflow is only possible on 32-bit.
>> +        #[cfg(not(CONFIG_64BIT))]
>> +        align_mask.checked_add(self.len())?.checked_add(nbits)?;
>> +
>> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with=
 an out of bounds `start`
>> +        // value and, given the overflow check above, never reads beyon=
d `self.len()` bits.
>> +        let index =3D unsafe {
>> +            bindings::bitmap_find_next_zero_area_off(
>> +                self.as_ptr().cast_mut(),
>> +                self.len(),
>> +                start,
>> +                nr,
>> +                align_mask,
>> +                align_offset,
>> +            )
>> +        };
>> +
>> +        (index < self.len()).then_some(index)
>> +    }
>> +
>> +    /// Finds a contiguous area of `nbits` zero bits at or after `start=
`, aligned to `align`.
>> +    ///
>> +    /// Returns the bit index of the start of the area, or [`None`] if =
no such area fitting in
>> +    /// the bitmap exists.
>> +    ///
>> +    /// The returned index is a multiple of `align`.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is=
 out of bounds.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>> +    /// use kernel::bitmap::BitmapVec;
>> +    /// use kernel::ptr::Alignment;
>> +    ///
>> +    /// let mut b =3D BitmapVec::new(64, GFP_KERNEL)?;
>> +    /// let unaligned =3D Alignment::new::<1>();
>> +    ///
>> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, unaligned));
>> +    /// b.set(0, 5);
>> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, unaligned));
>> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, Alignment::new::<8>(=
)));
>> +    /// assert_eq!(None, b.next_zero_area(0, 65, unaligned));
>> +    /// # Ok::<(), AllocError>(())
>> +    /// ```
>> +    #[inline]
>> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align: Ali=
gnment) -> Option<usize> {
>> +        self.next_zero_area_off(start, nbits, align, 0)
>> +    }
>> +
>> +    /// Sets a contiguous area of `nbits` bits starting at `start`.
>> +    ///
>> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `sta=
rt..start + nbits` is out of
>> +    /// bounds, does nothing.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `=
start..start + nbits` is out
>> +    /// of bounds.
>> +    #[inline]
>> +    pub fn set(&mut self, start: usize, nbits: usize) {
>> +        bitmap_assert_return!(
>> +            start
>> +                .checked_add(nbits)
>> +                .is_some_and(|end| end <=3D self.len()),
>> +            "Area `start..start + nbits` ({}..{}) must be within bounds=
 {}",
>> +            start,
>> +            start.saturating_add(nbits),
>> +            self.len()
>> +        );
>> +        // SAFETY: The area `start..start + nbits` is within bounds and=
 a `Bitmap` is at most
>> +        // `i32::MAX` bits, so the casts are lossless.
>> +        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32=
, nbits as i32) };
>> +    }
>
> In the case of bitmap_set/clear(), nbits =3D=3D 0 makes it a no-op, and
> guarantees that the pointer is not dereferenced. So, no undefined
> behavior. But in rust case, I believe, it should be a stronger policy.
>
> I'd add an assertion, at least, or better make it NonZero.
>
> Thanks,
> Yury

Yeah, NonZero sounds good to me here too. Thanks!

>
>> +
>> +    /// Clears a contiguous area of `nbits` bits starting at `start`.
>> +    ///
>> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `sta=
rt..start + nbits` is out of
>> +    /// bounds, does nothing.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `=
start..start + nbits` is out
>> +    /// of bounds.
>> +    #[inline]
>> +    pub fn clear(&mut self, start: usize, nbits: usize) {
>> +        bitmap_assert_return!(
>> +            start
>> +                .checked_add(nbits)
>> +                .is_some_and(|end| end <=3D self.len()),
>> +            "Area `start..start + nbits` ({}..{}) must be within bounds=
 {}",
>> +            start,
>> +            start.saturating_add(nbits),
>> +            self.len()
>> +        );
>> +        // SAFETY: The area `start..start + nbits` is within bounds and=
 a `Bitmap` is at most
>> +        // `i32::MAX` bits, so the casts are lossless.
>> +        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u=
32, nbits as i32) };
>> +    }
>>  }

