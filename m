Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BEFEA82E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8236010E7D8;
	Wed, 25 Mar 2026 07:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sztwv1LS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5598F10E7D7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xi/bqpNrAyYhrNpunCDwGs4WKe6MXSa4mnbH+BoKTeCi6FL75Vnm7NikzLjVJoGDaBueeeurKOsCiO1ornOY4FI2EoBbPOtR8KnMfR4q0ktcHciJrxYhk6TLUvUiVdiol6PPLrEalLc/Vwadul9eW78GxT7OKq9xN849bRpUXxosFg62rSFsFSClxdz09USRznUm0tw82QgSAxeofHno3jojF2PGAC5fKugokWJd2VesYyMhb+77hHcVzNo/h1vnMQzun9PBspRJlTbBrng7O96YdqZkfuGR9XzWAT1w9mdcFwb6HRNX+/+fNdx0SOKujUAjZBjMZ4iLPUC/ODRvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xESHBlL6y2rZhItRKyAgTjz4UQ4YQRyfZA56z+gOZI=;
 b=B99p+sffRzTZ7pHbgNylHl/r7HpBO0l1NHQe5Ne29o0P/2XYs43e61vpt5HLXARJOZW7n7kkjNQohKCJLKNWceVQYaGSlAhPXuRy2InkLpNNBvgYeIkQ9CGj2ET+e2Kp2ouIsRLL4h8UoGNMvrD7RRlmVb72iP3dXylwdjHR72qdI4+PTxbKzoCSweK/ABcmCKx2Duep3wDetczGbRBxRAY/l+X/VIEzj6PwrCQSXm06R4oI3Kubwoo9dIRtRujclIbKZ9uLAT6y7PC54SvsnfPnkc0zBfgiNeS82/YXqEtodo8ZtVWM0xsmxNjwHKdXE8hDfAu0fl9UaNk76cXz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xESHBlL6y2rZhItRKyAgTjz4UQ4YQRyfZA56z+gOZI=;
 b=Sztwv1LSepeshuWDgzu0khuKjgXRQpB+ctktcOgYSp29g+vra4pmsbSloSV/JEEB74XvsCKObZu5Nd7xdkr8I2B5Bm/qCFpRgzqeP8fvcO8g3ii8qRkN+ebyVIV7fAUjOgOuG7zDkPzoOQWfeaXjfZHVNLcy/QdiFRaVRF/ZbBuRqy6Qa9DRrBnxjoPUObcbjiKONvRSsFED1JUsu+E4IL1yRmfm+A7m06feiZvLHtYX3h+X4AHHKHWm5eotVbunGTW368RsM4nLeCzOBTuGjmL42JuOYYRjC8G49iGEArW2+X4IbeBYRtlW4urIviWBX88wD+iMgty57L2/GdUC7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 07:43:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 07:43:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 16:43:42 +0900
Message-Id: <DHBP16AEXWIJ.33T5PPE3ZRMHI@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John
 Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] gpu: nova-core: use KVVec for SBufferIter flush
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-6-9a9fa6f1c4c3@nvidia.com>
 <abzMyv_WHE4CUyFf@nvdebian.thelocal>
In-Reply-To: <abzMyv_WHE4CUyFf@nvdebian.thelocal>
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b48a8b-a893-463f-37c3-08de8a423f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: L661JTgpLkOe3b/HzVmv6doRupzX3Tcpqcvcmey4x9sMen2YnDfKm1JiSiBf4TqTjp8iQNm8m2YR9qSbwb+uzi4kyL7JdGCFOWgDpGHbc4jD88s2Nt/iSyVCV9CqnaHxEtiuDJ4Py2wPF3/nNfJkBHTPa8e+J92bP/XHLuAnmkt78Whqdd0eL4S0N3KkptB85fUWJka8vH7jrWY9q7hJIOePiLccSYOUbYQajypyr3F3tsQYT8WvgTKpFIGgPC1MDdG9OPqmDGtl3x0vdW35qnqRkQoOb70HCIfVPEmtwzsGr+doPhaYoH4XDVRv24RhkpvRb8vS62ut0U+a/P08ulf0TEzl11NMtCUImvn5b6p1/FJVQhnyZ93dBoe31NumqtqdPkhc9w8L5p9EDcZm0DjiNqtQLvudaMt2+Lz7iqbH874jjpThV+WL2lwMsa20mcm0uRBuQWlt3d9LXZtWv1dCcV9D9BWjWJH+byY3ZC67dJLLie2X18bEPMlhLj7CUavP/n2RwFTReq4kf55s98HY8jd5bzq6m1Slt2tJY7eMZAskdERO8QcF1I2MrM+qR5VZLXV20QDibSJsBuDYxnVH8l5QI6Uk/aXWteiIgmvglmHDSqE/9mfeKYNL1BA28S/dVn6qPCLZ7sdVECnjXInQBzRWjgSKaeHFHjc2y8q9fohO2e47tTAKGQK62/pMdd8ssqjGdePuSFiS8B3xmR/p/hoFTpuab1thk/VNPjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WklzVkRSRjdPL2grVThtUWFTWTFXdTBUT0w2dTB6MHdlSklCR29CekFQYVBY?=
 =?utf-8?B?cXE1dWV6WERhaXB5dmEyWFVKOEsvbUhHeUdYdElXV2ZZc0RUU0VucnBCM2dD?=
 =?utf-8?B?OVpYUDFRUzdGSlNaNUx5NGtKdGxIbldpUHVlWVdzYWNlNGtnSVFUazd3N0Nm?=
 =?utf-8?B?OVErbDF6VElEcDVLRjZzeVBXZzE5QkdqRWxOemxtUnBtOEpTa3k0RlUwZ0lZ?=
 =?utf-8?B?U0ZGQ3BHNkpTajhoai9BYzNLcm1kTzc1cnE3TGFReVNNb1RyVkJ2bzcvMi9O?=
 =?utf-8?B?UVh0TEx0alJBdUtUakZNeTB0M21uTEllZGd5T3dUSzljeUZNNFFvVzl2RHEz?=
 =?utf-8?B?Mnp1blBXSjN1emJXcU53WXIwWklOdEVPdURzQzB6Q2pObms3dEFvc0FhN0Qx?=
 =?utf-8?B?WlJteFpWTkptNjgzMzlBb3o4R0pwWTY0TlF3Q284c0o1Z1E0ei9KSEJsbmJ5?=
 =?utf-8?B?QzBlZXNsSHNYVCtQRm1XTEJMSmY1THpFejEzVE1WL2ZWbHV4SUtlbmpYZklv?=
 =?utf-8?B?QnY4Ti9KOVJHZGd2MndVV3FvSnROaEtySCtYVTNWUVkzWjE2WEc4ODJnalZl?=
 =?utf-8?B?cFJ2cjI3Z0tXa3NqMXJURmFtSnN2WGNZMTkwN09OOW8zd3lpUzBVRzR1YVZG?=
 =?utf-8?B?UzYvcElFY2pvd0tWRkRiUDlNczRPOUdEMTFuN3YxdXRqZ3MzMm14ZnluMWVH?=
 =?utf-8?B?aWFIRlQ2SjlmalVXQXVnUktlVjByUXlYQnZPWDUzSHJHSEdVcGZBdEZNN01I?=
 =?utf-8?B?QmlhT0FlTW5MbGlxVjBuV2I0OTdJWnAveXFBMGxmeithWjA4bnp5TVdUNUE1?=
 =?utf-8?B?dGJQb1VtMy9Ec2VNVjhvNDRhRk9JN1QvL243THhoNWZLTHBXc2FhVzVveUV3?=
 =?utf-8?B?S2pkUTBZZHA2U2ZQYnBVKzFtTlNPRENZbXd6QmV3QXI0b3U0by9LNUcrT2Zi?=
 =?utf-8?B?L2N3RGZKQmgrZWxKUkZlQTRHbXhXWU56cEhmODBVeG91emtKK2Z2ejJqYkEx?=
 =?utf-8?B?S3cyUXV4Y0IxR0hkV1BjZHFHK0V3QzFLK1dnZEkvOXplOGYyNkZDajlNd2Rl?=
 =?utf-8?B?cVlsQmVaQUhSV3BUQmtrUmNLYXNPQUl3Q1JWNWdzVSt6ekxFbHRxc1FRR3Yw?=
 =?utf-8?B?eVNiMjNHeWRGeEhKMHFBV2pGbEtGSDdZU2VNSDJiUDlDTkgvTmFyQ1YrMlNN?=
 =?utf-8?B?bEF2Yy8xWWp6cUx3dDhjSEVraHQ5MVpMeEhZRW9pNzErN2Y1d2llVGlpYjNO?=
 =?utf-8?B?MWJ5R21sWmpsMGNvRFFNT0NzTjd6SWttVWNCVVJXSGJ0OVJoeGJmWUplQzI5?=
 =?utf-8?B?ejA5eFAzVFFsTTBrVERTSjJSUElkQ1ozaFBuSWF0RmdpOGlReGRWbnd2TExI?=
 =?utf-8?B?QVQ5WnRsMDBsS1pEUDVHQUcrZEJnV0E5NHF5eHdkcVUySTdkN3lhUzBLSndY?=
 =?utf-8?B?TldMVDhJYmkydFVLRWVGaXBkNlZNYW1taHYxamorUHh2bW1XVkpNSlZQbDJX?=
 =?utf-8?B?NlY5SC9IbFZxZjBJaHVxUm9oeXowU3VRL280dkJzbGkwTjczVkRTeUoxU3ZI?=
 =?utf-8?B?aGc2TFQwZ2d2ZTlGVUxMZkVtWk9YNGdwNzBZNzhGVm11UklVbWgrQmZsZDF0?=
 =?utf-8?B?ZXI0WDVkZ0MyQnJNU3pEaEovcHNOeWRlckFDcjFXYzZpWU1LNzNPMDcreDhp?=
 =?utf-8?B?NEZPUG10RkI4djFqV09BM1NRRUQyNjBJSGVFckh1WUthcXhWbUdkMnVTdGVx?=
 =?utf-8?B?bjBLc1NmYytaeG1PeVVMaGFOdFBwTUREWnp0dy9xUHpIT0Q1ZGFWcVVwYkti?=
 =?utf-8?B?ME5uZWVLTUF3dTlWTDc1VzFyeGE0Yjc4VGMxdHFFNERxY3pxNHdJOTVOVHJH?=
 =?utf-8?B?d0s2eVV1YjFZa0dKV0dPSlNPRTY5S1dxV3kvV1A4bGN1RnAwcVk2RGN4bElm?=
 =?utf-8?B?NWlRK0tpZ1JWUHMvZWFHUkV3bERYNkhBbHVTaFQ1NnJqdk5kak00L2dEZEgr?=
 =?utf-8?B?M2xVekk4VHJjdWtZajVGa0lta2dRbzZUMFpCcXpkUzJVU0hoMFNkZTB1VGhS?=
 =?utf-8?B?Y2s5RWdMMFIwTkhSUGllV3p5Z0grZSt5QWlQWUc0cDAzMzgrd2NCVXUySzZK?=
 =?utf-8?B?YzhWeGlqYTd5eEtiaW1HTXZDVFBjMXNzdDYzSVU0NG5rbnNTWnovZFgxUy9T?=
 =?utf-8?B?NjI4SFh2VnpRVS9WczZKRlRvQy9NYkhaT0w3Q0REelUwUHdnY05vMlp1bVF1?=
 =?utf-8?B?dzRZUjZaQnlGK1UvNW5TZUl4andrRFdWc0E0OFpxYnJkWmQyaHFwYWQzdXNX?=
 =?utf-8?B?ZlZCUi9UaG5SaHNEYU9IZ21PTEVYb2NITEtGRDFUZ0pIYjQ1Y2NMVnBFZHZs?=
 =?utf-8?Q?hpoOfE/BTSjyQ6XJwy0ooQuuroZ5gkZCJ9l/IDoX+6+U3?=
X-MS-Exchange-AntiSpam-MessageData-1: 6cgol+caAxZaCg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b48a8b-a893-463f-37c3-08de8a423f06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:43:46.7311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHuxOu/qpK7uW+/x39c5pcselaT0R93h3ENTy20ykpsn26BU7vt8Tr2yPMy0wNYcChk1kogRFbpadpi7+IvWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
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

On Fri Mar 20, 2026 at 1:32 PM JST, Alistair Popple wrote:
> On 2026-03-18 at 18:14 +1100, Eliot Courtney <ecourtney@nvidia.com> wrote=
...
>> Change flush_into_kvec to return KVVec instead of KVec. KVVec uses
>> vmalloc for large allocations, which is appropriate since RPC reply
>> payloads can be large (>=3D20 KiB).
>
> Out of curiosity do you know if there is any upper limit on payload size?

IIRC the largest one I saw in openrm was a few hundred KiB.
Theoretically, the largest complete payload you could have in a single
message is ~64 KiB since we don't support continuation records on the
receive path.

>
> And is there any concern about performance of vmalloc() vs. kmalloc() for=
 RPC
> messages?

`KVVec` uses `KVmalloc` which tries `Kmalloc` first. Most of the time,
`Kmalloc` should work. So this shouldn't regress performance really in
the common case, and it's required for the longer RPCs.

>
>> Update GspSequence to use KVVec accordingly.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/sequencer.rs | 4 ++--
>>  drivers/gpu/nova-core/sbuffer.rs       | 6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-c=
ore/gsp/sequencer.rs
>> index 474e4c8021db..c8f587d2d57b 100644
>> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
>> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
>> @@ -42,7 +42,7 @@ struct GspSequence {
>>      /// Current command index for error reporting.
>>      cmd_index: u32,
>>      /// Command data buffer containing the sequence of commands.
>> -    cmd_data: KVec<u8>,
>> +    cmd_data: KVVec<u8>,
>>  }
>> =20
>>  impl MessageFromGsp for GspSequence {
>> @@ -54,7 +54,7 @@ fn read(
>>          msg: &Self::Message,
>>          sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
>>      ) -> Result<Self, Self::InitError> {
>> -        let cmd_data =3D sbuffer.flush_into_kvec(GFP_KERNEL)?;
>> +        let cmd_data =3D sbuffer.read_to_vec(GFP_KERNEL)?;
>>          Ok(GspSequence {
>>              cmd_index: msg.cmd_index(),
>>              cmd_data,
>> diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sb=
uffer.rs
>> index 3a41d224c77a..ae2facdcbdd4 100644
>> --- a/drivers/gpu/nova-core/sbuffer.rs
>> +++ b/drivers/gpu/nova-core/sbuffer.rs
>> @@ -162,11 +162,11 @@ pub(crate) fn read_exact(&mut self, mut dst: &mut =
[u8]) -> Result {
>>          Ok(())
>>      }
>> =20
>> -    /// Read all the remaining data into a [`KVec`].
>> +    /// Read all the remaining data into a [`KVVec`].
>>      ///
>>      /// `self` will be empty after this operation.
>> -    pub(crate) fn flush_into_kvec(&mut self, flags: kernel::alloc::Flag=
s) -> Result<KVec<u8>> {
>> -        let mut buf =3D KVec::<u8>::new();
>> +    pub(crate) fn read_to_vec(&mut self, flags: kernel::alloc::Flags) -=
> Result<KVVec<u8>> {
>> +        let mut buf =3D KVVec::<u8>::new();
>> =20
>>          if let Some(slice) =3D core::mem::take(&mut self.cur_slice) {
>>              buf.extend_from_slice(slice, flags)?;
>>=20
>> --=20
>> 2.53.0
>>=20

