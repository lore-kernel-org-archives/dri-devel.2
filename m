Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471C2F34C51
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A320010E427;
	Mon, 13 Apr 2026 12:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBcauEDW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443610E427
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 12:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtrk7wIzeLEHU49R0W8Ua3IqQoMl0NJGWWnkQfV/jrN5RATlW2w1573LPHswjvOqwRNk8QQFiMvZe/SwDBfHq235+9SYcmXJjtnBjTH2cAzEsAQTRapEFPWphYYgPTkFDnov8Om+IL3YtSadlZ9AUvNwRy1yh5xt7VU7JR3xCsmWo1K45nOQmGMQp4JpOVwFXPe1r5LCkDJmfFF68HqFang5qyhGxWwjjZ3d2damp0XVKUusPrF0kKEhzooE4ifOsCQc2PAFsKAY7PHW8rjibOHpE/9VXEP+jdaLWOXLQI4hpK9PpEnMrTKKHJCysVKu5KU6oxrUngPOuFTWzugaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GNz6KF6xvmC2Eo89lfEglIaVTrzsctBDTWAanYisnA=;
 b=CdV0ymkVP2o+uRj9r3Ixdp9Mk8bpioNvNFnbW9UwepuQeLJuYITwdek7x8CwUznTdhfYSOGbZIGLh74vaSOAKYMwfF6VDVpShH6OfmsNOazFR2H+KSTALlo/ucLQzSBdfqneXlKeK0hCGaKQzE/Zqvj5P3NuJseGySFvsuhyMlFUKLlXVePTyNDMqKsyjUtGMU4d2qQtVrmG21Gn0+ND9cVupvDAo/6kN6tdujOGhylKy/st7lVXFYXFpMiH35lZZUA1C8rkk1xu10eboS3bnNq3gefM0buo8B0g+e2S/YpqdJaLLAdozDm2rLBqBalaKEYaqH26QEcjupJnLlasLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GNz6KF6xvmC2Eo89lfEglIaVTrzsctBDTWAanYisnA=;
 b=LBcauEDWtPt79GKfdIJVJps/x+W3Wca1z4qOhe5+m09DfI4PiC/31wlpXC0XjeTUooHyBGRdzQX2oCDrKeQCkRXgmalNGIRHNN2KRxSBVRZUfbjSYJ+1yGNZvfQvhbXlwwyIdAitjlVjh5t2/ZOxCjHOEIcJv6R8R1lsQGUznqNrhk2AMf1CUX/wM1l80hbThZ+avgfsrSFf3OfY3gB7cIByPUUUjbb5IzEyX43wqAccdk8jeZefZi9437zx/1OasvR2NhKztQCuJ34jjeNwCSgUuk7Pff3TUq3megZbGaqtn/5jYaP9XNJQ0KMF3h7zoYQ8+HocQyulTGjDLwo5VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 12:59:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 12:59:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 21:59:03 +0900
Message-Id: <DHS1MZ33QRON.2IEZR9MQOQ720@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] gpu: nova-core: vbios: use checked ops and accesses
 in `FwSecBiosImage::ucode`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-5-bc6f71d153d6@nvidia.com>
 <edff8db4-a3a5-4b21-a8e6-9871206ddeb9@nvidia.com>
 <DHRT5WO1KNM9.7QPD97ADIC3O@nvidia.com>
In-Reply-To: <DHRT5WO1KNM9.7QPD97ADIC3O@nvidia.com>
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4953c217-9d59-44a4-9e31-08de995c72b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: f05Ze67rCbjPzDIepvCVUS/vJi7BhnhherUmoYKnQZgTaWB2IzNI9edcQonl1yGH62vhi9i4+9+p+L9V5ZZkCOK6VX+QahqLurAXzDSsjNZ74qWbtq9VjQjLkA+/xNkO0Nc2Rf2j9vzjofZGmoxqB+a9s2SWQNXhzYKLGUqJ1v8t5/M+WReorT3d/kH+yefI2U3HRebhz9lkMRg+h83wekrqD3dz9Y/hmTcvpbKmTzJIjNQ8jy0qhMdxmLKA8JIJl4nDdxFmL5ZtJe5mCgrg5C7a3kRh7g5WA+WxFWITH4WgWXq9dJXhcFK4JQRET9SAZUoyywbapEUBMgBxiyMFUGx09lpsbrauYMQdQ9cekn8LrPJcFbTkwagInbvsQLLnW8eWKldiKkgOO9BMr/KJNJmMvt590tqDl1UY460u/KXDNMaZQDM57BazKODfWxTASSNdxXVk1rt/O1NEMy/A6O7Pp38dovG+4VswDVut7iEbuA4ArGBJ9Xwa9y6A0MwLSjmHyvdTnyF/lDD7pWQfkC39brZz8yPeQmYEtFUQ6LD/uJ0U4tzXrRlorp9ArQjq9G/Au65GZrHg4LPzYUbt0+EfN/FNmGNGablat4xPocmRnNVtR0PNsHxUG34KECfgrM8xMAcdP30GUIurs7EhidqRUaDePWDI3tssZ4N1f5kbccpYZ2U/Bq6W8jFW6pN7mybp+/7BysYP1mHqxrjrC2i9HRFmLC7cTcSa1FWaK60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRCRVdxZ2NveTd4aldqcloxQXhXWkJYQ2kxWXhZRzQ5TUFVMVBhYysrNUsx?=
 =?utf-8?B?bGJXa2NXQjQxR0VDMEg1a1JTNWlEeDN2aERTdkJ2R3VqT2JXWmVxUXhSM2tu?=
 =?utf-8?B?aWxKRjhrUTQ3WFlDS1FHbjVTUWRtZnEyK3FwYzUxanBrT3JEdGxlRG5sa0to?=
 =?utf-8?B?NHRxWUM4ZmhqN3M4ZUZESXVsNVoxNkdKdG0yNm5FcUJJckdMR2VubVRSVkY2?=
 =?utf-8?B?MjFZU2JqMG9iYmMyMHVFNTNTM2hkQmQ1ckJpMTN0dUkxNXlnamJqTG12VTVZ?=
 =?utf-8?B?QUMzRUpFakhtd05BSjZLUUJycVpxc0dIMHdHUVh6Mnc5ODNyWDhiRzNCU0Ra?=
 =?utf-8?B?cEx0c2MyRUl2bjVMU0JSNS9kbjZndEs4RGE2NVkreFYyaXdvYXZRZVNFU0Nm?=
 =?utf-8?B?QStPOVIxY1pCYjlDakw0WWRxNWFKbjhYWVNYWkRsRXRaVDlqcjFsM3pqa2hX?=
 =?utf-8?B?NWt1OEp5WEh4SG9SRnVsd0lJVFJnWVFGQWVMNVB6VzlnN3NZS0RocGdTYlRs?=
 =?utf-8?B?MGdhdFVqRW0rWXNSZVgvRVBUdUlwb0lIV0ZmMjFIcTNmMGIzdHNwZDRiNjJi?=
 =?utf-8?B?bzBRT2tCTFlWdG9HME1SZVhpRC90TUZpbndod3U2UWh2cVB0UWNtUkMwcDZy?=
 =?utf-8?B?R2dCUTFuZ2xHemwzcXNRSFBkMlo5Z2lVMXF5YTkxczBWZkU2dUJNcEdldmh3?=
 =?utf-8?B?V250UHBzN3VkWDhpRWp2YStLWGNIVHZlR3dpYjlDVVpLOGJ6aWRsQjJSekF2?=
 =?utf-8?B?b2Z4d0JWTjdjOEZ2S1Vkb2twTkV3UHFwVnlLNldGdTJ2VldNQUV6Z1ZaN3Iy?=
 =?utf-8?B?NXpMQkorTjZlOGpiZzVHMWMzS25HNmNGUERacFUvblRyT0hHRFJINHhwaFkw?=
 =?utf-8?B?d3dROENrelM0YTZXNTZyT09EeERyRzRNNnlNNDQwcjE2di9weG9wWUVOYXhU?=
 =?utf-8?B?Y2hzTTFrUEFONktKSnVmdzlyV2Q1RUlYdlNRSFFoUWt5NmpRckk5RndzZkNp?=
 =?utf-8?B?d0pOTlRVTXhTOXpTUVMwaG4yd1N0SGNKZ0N6enJ0ZzM4aXQxOXlLU0JXSktP?=
 =?utf-8?B?b3kyWkRWMWhqK2lRVjJXZS9NTFJ1MXA5WkdSVDBTQk1IV2pBUzJjK1J5bnR2?=
 =?utf-8?B?UG1oWDFXRlRPajZXMUE2eDBwcUFTV3FLOXZoTFJ0Z2lIUHNLK3RqSUM0NFRB?=
 =?utf-8?B?TDV4RXZ6ZFNDbXZLUStJYlVpSzM4K3R2bHZpTG8weit1ZXlXUHVaRTYzT3JI?=
 =?utf-8?B?aC9temxNMkR4eHFGYjBvZzJ4bXRpa2lWL2pGVnhHOEQ2djJSQm9kR042NWFv?=
 =?utf-8?B?TjNQUHc5QTF2MTJuekZHbnQ4QWNITlE2ZE1iNjR5QUsxc2Y2a0dwNDIvZW1h?=
 =?utf-8?B?eWN2ZkQrN2ZudFF0VnBROFNOakRjb1F6UXVwZDNFNFVkelk2Y0V4RXJyTVB6?=
 =?utf-8?B?NkM0ZEwwSTNYTnREOFRlTGVydnlEcWNvS25RQlNqVHNSbVg1NGdRWjVJR2lE?=
 =?utf-8?B?ZDI2MXFQR3I5eGxSRHZ3dG9RSkRwZFJ1MnNvd2c0QjIwb1RFalgzRGwzcnhG?=
 =?utf-8?B?SllsNjNaRUkxTkdmYmp5UzUwZmJ5QUJ4S0NWOEhqd3I2U3lrNEJrUnpZcTZB?=
 =?utf-8?B?VDh2VGtocHJyLzdkL0NVY2FWZFF5cjgwV2NsNUhHNXNVb0JQUGpWcHNZeDQ2?=
 =?utf-8?B?OHJCc2RPaTViVVp6Z1o5TU1jTXlHUldJL0pNTklwazMyUHRvdVA4Nmw5RDE5?=
 =?utf-8?B?bHFqa0NLSTY4em4rSWZicXBKNmFuOFp6RUI5WGt3bVF5Tmp4SHZxc3YrUWlw?=
 =?utf-8?B?c1Q3SXRFb3Y3NkFpbGZTMkd5cTZBQkR0VW1uSmpOczJzUFVRelRqZnhKdUx5?=
 =?utf-8?B?cWRxTkQ3RTh0MTdXak9XeEh5QlBlb3M5OE9PVTh4aUg3R01MZklzOTJOaElw?=
 =?utf-8?B?QlMyMWNUUS9GV3lIbWc2ekl5T25sVERsWDNFU25Ob3dBdHVJMXNtZFRUd0hn?=
 =?utf-8?B?dmx4NG9sd1hUYzJza3QxTlExYVZrbjRGdVdLb1BrbzJxb1BrcS9TelJqTzZv?=
 =?utf-8?B?ZDBVUjZLOXVOdE5jU1VDa0ZFMXN0aXpwdTd1a3N0T2VHU3Nmdk9nZGVQUlZW?=
 =?utf-8?B?RS9TZk1sV2g5ZFh1a1FkcE4yYTlQakd4aUhCd2lpcmRZT1BmSGRnM0s1bWFL?=
 =?utf-8?B?blZDTE96WGJ5ZE5QREl4NnBZNk1TZThzWmJUak14WXZsYXFhVXQ1OU1jbDdI?=
 =?utf-8?B?Y3lNNkoyWDJvYXVlR05uSFYxQlAvd3RybE40Q1Y5cmpMVTNMcE9qaWJQSTQy?=
 =?utf-8?B?MzlEZ1VSRG1BMFpFMjB6SUZabk9XSmd1bUZnWnI4czFzUTFScTgxeGw2dTVI?=
 =?utf-8?Q?sjJLuY1Qyx8tvDIhLTdMqcaj/ULCmeshDhAcw2kkv/HeV?=
X-MS-Exchange-AntiSpam-MessageData-1: tT7BKPQQizorow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4953c217-9d59-44a4-9e31-08de995c72b6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:59:07.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dv5kIfjg4cxr9kpDPBLVRPgx6z4kERT89zpTmKL3tmiW42gZLRHFeCPGA8LlUy4K7NrGTs+PR+pKTIL8THGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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

On Mon Apr 13, 2026 at 3:20 PM JST, Eliot Courtney wrote:
> On Sat Apr 11, 2026 at 12:05 AM JST, Joel Fernandes wrote:
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com> , one comment below
>>
>> On 4/10/2026 4:38 AM, Eliot Courtney wrote:
>>> Use checked arithmetic and access for extracting the microcode since th=
e
>>> offsets are firmware derived.
>>>=20
>>> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucod=
e extraction")
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbi=
os.rs
>>> index 3bd3ac3a69f2..b509cd8407a5 100644
>>> --- a/drivers/gpu/nova-core/vbios.rs
>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>> @@ -1027,16 +1027,21 @@ pub(crate) fn header(&self) -> Result<FalconUCo=
deDesc> {
>>> =20
>>>      /// Get the ucode data as a byte slice
>>>      pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]=
> {
>>> -        let falcon_ucode_offset =3D self.falcon_ucode_offset;
>>> -
>>>          // The ucode data follows the descriptor.
>>> -        let ucode_data_offset =3D falcon_ucode_offset + desc.size();
>>> -        let size =3D usize::from_safe_cast(desc.imem_load_size() + des=
c.dmem_load_size());
>>> +        let data =3D self
>>> +            .base
>>> +            .data
>>> +            .get(self.falcon_ucode_offset..)
>>> +            .ok_or(ERANGE)?;
>>> +        let size =3D usize::from_safe_cast(
>>> +            desc.imem_load_size()
>>> +                .checked_add(desc.dmem_load_size())
>>> +                .ok_or(ERANGE)?,
>>> +        );
>>> =20
>>>          // Get the data slice, checking bounds in a single operation.
>>> -        self.base
>>> -            .data
>>> -            .get(ucode_data_offset..ucode_data_offset + size)
>>> +        data.get(desc.size()..)
>>> +            .and_then(|data| data.get(..size))
>>
>> It might be worth adding something like:
>>
>> data.get_slice(start, size) -> Result
>>
>> in R4L longer term if the data.get(start..).and_then(|data|
>> data.get(..size)) pattern is common. It seems to be so in this series.
>
> Yeah, this sounds reasonable although I think we'd need a name that
> makes it more obvious it takes a size. I had a look at rust standard
> library code and it seems a common pattern is to use split_at_checked
> for the initial split. Unfortunately we can't use that yet I think since
> it's in 1.80.0, but maybe we can use it very soon.

IIUC MRSV will be 1.85 when -rc1 is released, so we should be able to
use `split_at_checked`. I've been looking forward to it as well.

>
> I had a look and it looks like there aren't really other existing
> patterns like .get(start..).and_then(.. get(..size)) in the rust kernel
> code. And in nova-core other usages of getting start..start+size slices
> have local proofs that start+size doesn't overflow.
>
> For the most part in other code hopefully we have local proofs that
> start..start+size won't overflow and we can just .get(start..start+size).

Rust is really missing a way to build a range using a starting point and
a size... but I guess there is a good reason for that.

