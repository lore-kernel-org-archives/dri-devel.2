Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAE9C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF41A10F09F;
	Thu, 27 Aug 2026 14:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tKRRFqz2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD10610F09F;
 Thu, 27 Aug 2026 14:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9B8YYB8l0I5T9r/dZRMLKss8wSUe0+BOXCg1uUvDwE3L74u3kjy6kpaBnKcltpTzTNbNrgf5HKl13x5/pAKvOzrBvTwbzK5wo/kuWiVVw6pKx2Q9Ke97izgx08eVRo2g65gbDN+5n8+rDOKPu+3DFNS5DitbR4re2NPwpPTx/IWHfkTFjoS7YhaQyc/Z+EClEciwdNmiqQijpTutFaeuHqbRZbXmRxnW83rNEK7lKeONnBDPKWSvp2erwniLIuCxtRokGHDHZ+VRk60cZppQnBi08G2xdB17TuhYj4pVQomets004Z+sVZb0HJN9QdaDnMOoHR82LJNToYGcf2tSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq+mAaRZrS+jr3EHGLGaE/1LvrbLTHDvC3fTMDUvuyI=;
 b=xX06pTo9ec9oEEeTQbmbl34T03rcbLmmOM///VBVco7IwJYeiYHpBtoaHSIiggwwseGCtbtXlxTT5fllAeTrBYPF8ERAn9H8wJWMyXTMMEwA+VV1l9mIO7pSF7ZpKqCBK3CQeKBjGTsRyLgTnJ++ZH/+FlNGRFDXn3mCh+0uvQMClZg8Q8Att+cMPI644ERy+RZ4PJbe8lXT0RWMzIE+d/AMAmJz1KbB3QPQoqVQXiUimFFHOsZ4HjRco6q7UW50uEIjfVcrMIvHUH2hnk+gll1w3fqDGGEi1DZAg3FJP2fAfoB7qBt3sNsdp2ZzZpvc44yCH3LJ99wIYCrjOXXGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq+mAaRZrS+jr3EHGLGaE/1LvrbLTHDvC3fTMDUvuyI=;
 b=tKRRFqz2Oet0fFTlbxiSsl7SjqWdkvA5jZM61gxGjZwrm/FbQ6sPzr3589OAS9m9WjuZi8v7YDrmoWPBIJI9vP0SMdZ3+lh8hC5LFxoYKsr8exSZpD6pexmSCZ8NGuTSBE0uwXs/d+zZUqQB3f9ZgVAafR3msBcRWE9Zyfo7AkVBUFIeTzjaUKpX0qOqTUOP99gdNhwBiehfqgl+4NT11LtzKAcUBW2+Dzzs259gKTz5ucy4pDlHLvyeijL+nhrkHv22ohhyRjfS/nHlel2T/u8k+mmafNWFRU4BXqs7R310XZgIAslXFVydVKPinP0RdmddcyqmzInl82dltJAE1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LVUPR12MB999161.namprd12.prod.outlook.com (2603:10b6:408:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:25:49 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:25:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 23:25:45 +0900
Message-Id: <DKZSNG5J5UA8.12HFHO9KURG0G@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] gpu: nova-core: add NVKV encoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
 <DKT2C9FT6IBW.3L5PJN1J8IVLD@kernel.org>
 <DKT2NSDRJXYX.1S0H8K3Z75QVK@kernel.org>
In-Reply-To: <DKT2NSDRJXYX.1S0H8K3Z75QVK@kernel.org>
X-ClientProxiedBy: TYCPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LVUPR12MB999161:EE_
X-MS-Office365-Filtering-Correlation-Id: 548ff955-9586-4532-0253-08df04471782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|7416014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RLGlZlmpVGzY1qqLF1HJg8Vuj3FKXPjngEOf241P+m9gZRJzS1JNQWNhKV5MJkvKUg3SaRzHz/M9zHovJ36RLblY56dNKJr5kX5nl9DrncIJDhWtnABTn+RV85v/VimdoXzpGbFdFYdH4d/Mz9yCV4rIFHDKxKHWeBmhaTZSAP+h7WPp3gTf8eFbmKGLFZPpkdlsNPK565aVtbYGjIXCFm6TF+CcyiBKkyp63qWKyojp0bnjuvWE8yKM6plTtyOhOnQrBqBmG4deS/DDUlKppZzIqqBbQ9kScu0DNwnnp5k0EE4UaXt9tlW9YO40qB2JFiKRbh0u/T2Pn17Gc1IdmIP/bhHEbzgr7zUSCZb0YsdUf+0R7livl+7o0+laoZcBms5jnIFs/MFbR2p+G+6yHna+SV8JwuiQ1s4Xj5UrYpcyzr/0INGv8bOcAfoSdPKaX6VSi8F4NPP2aMuxCFQy7AdIhg3FKMFb069ckv6gBDVToALGXguqUU2KRtz9H9+67qyJL+hkR/ttbc3d5hQDxDzuRmdPx4y7IuoRxeSrrLVK0wvk/Iq88+BbsgX760P78HocGZY35BUHF1nykLFhF6QYTcMSEmmi8FvChDnlOdnn3gxy9Yki4atWax4NdieW9TigRm21kQ78T+n52hH8vHvqEzNOXuSRCMk2Fqa2xGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(7416014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzUvUFlHK0Rtb29xVXl5VGo3WjRrc0RRUDMybGJ2RzhPZUdyUWdSTFIwVmI1?=
 =?utf-8?B?cFJmdU0yRGRzbEExcmlzSGRhUUFLTzFlYmpPODcxR3g5Nk5GNmY4b2VyL0JV?=
 =?utf-8?B?b0xjM0tPS3NXWDlzZ2RKOXFQWTZXc3RZZGxJcUJIalVqK2J6anErOWRXTHN4?=
 =?utf-8?B?YTZIQTV2M3ZhV0RPb1lLUEE2NGkrbXdES3V2K1RycnFGNjkwYUFkQm5TVFFU?=
 =?utf-8?B?cXRkRGtwcUtUc2RwQU1OUVBSbGtvR1c4Y0dVY3FkK2g5ZW5YYUlhRXRSZkhJ?=
 =?utf-8?B?WFd0eFEwdXBxcXNxTk50cEJBbHhvMTlIbmMwejU1eFljbGlhQ29sTCtmSTNr?=
 =?utf-8?B?NEtETy9QWjczV29sbVd5eXhrMUJydTZvZXNDWk9TV003VjV2bHRHd0QxN0Nk?=
 =?utf-8?B?T0ZvU1lieHJwSnFkT05iS3k5N01mU050Wlp3Q1p1Y01WWjZoN2lJdjF5anpR?=
 =?utf-8?B?TFdHL1hReDBPMjFtY0hMUUVSNko5eUhOTDl1WmtGOTY3cy9YU3ZwR1U3VDlK?=
 =?utf-8?B?WXozdmpGL3ZnWGpNeUN5MEE1TkZxYmY2VE4wWHJuQlVpVGp2SDBxRWk4Z3ht?=
 =?utf-8?B?UVZwazE2UVRCWjgzZFVySjk5dzY0eHpuRXVDZUZDTVU4bm1nOVRaK2FHeGRH?=
 =?utf-8?B?anoyRk9uMUJzbTFZSkJHc0ZvSXNvUEdKTU9TOS94RTh2S2NBTERXeUg2Vmpy?=
 =?utf-8?B?cVFCT2RXSjlDSlhmZVROMFRKVnhxRmh3dHYvdkZCMDBsZFJRVzRpY0ZQN2dH?=
 =?utf-8?B?cE5KL3QrbkJBRk5CQnpiSWhYbjdVRUtjc2pweWNoSDAzeCtxNWtrRFBlRzI4?=
 =?utf-8?B?cjNLS3EyRS91c1llMnltd2MyaFNCS01obHZrM0hyRW9xS2Fvem9HdDlZK3hV?=
 =?utf-8?B?U1cveEEyKzUwZG0yT3picXpzdEZUU3hORXhkK0p6TXFsRkRGczd5VlYyUEFo?=
 =?utf-8?B?MkllK3E0TDNuU0tpWmwwSkZocVlyVFV3djlLWkNhWEZYYytWaWUvMm9UUGRo?=
 =?utf-8?B?UjdSemNoazNCQXpDRVUzZ1NhU0dJM3puSlQxT1psV2dFdmtSRWRPVW5nd0hi?=
 =?utf-8?B?NDRyaisxM1JPNC9SUlhTTlRINmRXQjF4MFAycG1kTXRuZXp2c05qOGZtMnQz?=
 =?utf-8?B?OEVuZUdKbnNwekVFK002Y0RldW50SW9yenNNTW1hM01QS1E5L0JZMVdtRVZw?=
 =?utf-8?B?YlNTOEczUzJUQjkwNk9oRHc0MGovTnNOMDVRMmxuYzY3dVJ4cGVSNGtwL2Vq?=
 =?utf-8?B?T2FQa3BLMUgybDl3anN4T2VoR3ZTTG12WE4xZ0RDTXlteFNvMGVJbjdEL2xh?=
 =?utf-8?B?b20yaGRhVy82UEJDZFFZb3piYWVSaDZDWGpjNDZ4QnlEcnVQZDJnNWM2K1Vs?=
 =?utf-8?B?Q2JuTWI4S1NJcFpyOXdKdTk0ZmQzWFUxOWk5SHA3REtrN0Z3SjFTaHowOEtW?=
 =?utf-8?B?cU5iZHIwNVNEVGo1QnFGR3dLS28zTHJSV2I0OE1udDJDVG54dTFwbXVBNVhw?=
 =?utf-8?B?Y05mSm5MMExjNFlpbEY3ZTNxUFFtMzI4bGw2SUZ0OS91Mzdjd1VJejZ4T0VR?=
 =?utf-8?B?Y1cweE5iQUxVSUkvNm14cC9kbFhQbnBCOGl4bU9ydHJSYnVFRHYzWXEwaWZh?=
 =?utf-8?B?NFYrdXdnQ1o3Z3o3eWdlM0VJNjFuYk1zK09UK1JWbkJmNVBuc004R0g5Mjl2?=
 =?utf-8?B?c1VDRkxJTVdhZzdqUnlHcWk3ZkdpaWFtVnlHWGNyYmJwNStBd1JjcHZnK1Y1?=
 =?utf-8?B?S25PR2ZOOEJLT3g4dWN3UVRGVUVtbWt5amNoeGdVNVZKNWZ5TzZBY0trWkxU?=
 =?utf-8?B?eG9SNDF2ckZjL1BDTUJyK2dOVE5DSUFRR1JQWEptVXhMRjRKWTdaUi9kY2pC?=
 =?utf-8?B?WVl4RHMyNlFOVklqQjhXcVYwMTU0TUlzajhqNyt4YTFQWUd2VGNCU0JIZU4v?=
 =?utf-8?B?aUZ2TmNzNEhVOEUwRmZPRnd2bERnNktkN3ZqRXBBZjVnYXRYaVBnVjB6Q0x6?=
 =?utf-8?B?NnQvNUZqRnV4VnBEZ3hpcmlyMjRlTlFoTjdMSERQNHduTjZpQU8vOUtYTUk3?=
 =?utf-8?B?OVRHeE5uRkZnQXlHSGovZlBEdGZQYXNPYkNWZndkZVlqZ1RGV05DYTEyVHhG?=
 =?utf-8?B?TWVmbFRCQmF1eTN6QS9qWndEa1d4UGg0MmhuSmZOK3E3SlJhQXJxeWZFNXhH?=
 =?utf-8?B?Q1ZGZUU0M25XZm1WYjlnRVBScU5adEtRbGpHcERPWEtMajNjU3lXdDhzRytB?=
 =?utf-8?B?L3hzMXJTU2xkVFppY2lnWDdtMFAwMnN4QlB1czVPRXZQakZBbzBtMDRqdlVu?=
 =?utf-8?B?aytNbkJESUZmTmEyVXk5Q25kb0MyVGw2N2lnRHU4ZUR2RFpVMTMwTGJ5dXJS?=
 =?utf-8?Q?GwFBaMlVSO75zefldVf/nlBl2LNCU0bVGV3o2X2knTUBD?=
X-MS-Exchange-AntiSpam-MessageData-1: DY2CRWNWvss1NQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548ff955-9586-4532-0253-08df04471782
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:25:49.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iZw/RcB/qZwlc97MMdLD/ZEHw9AqjouJidJnaTy2054Hi41VBkEddbgA9kEEe0Gzlfd3OCZS2h6y7d4j2i6+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999161
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

On Thu Aug 20, 2026 at 1:47 AM JST, Danilo Krummrich wrote:
> On Wed Aug 19, 2026 at 6:32 PM CEST, Danilo Krummrich wrote:
>> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>>> +    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
>>> +        let num_entries =3D bytes.len().div_ceil(size_of::<u64>());
>>> +        self.backing.reserve(num_entries, GFP_KERNEL)?;
>>> +
>>> +        let spare =3D self.backing.spare_capacity_mut();
>>> +        let dst =3D spare.as_mut_ptr().cast::<u8>();
>>> +
>>> +        // SAFETY: At least `bytes.len()` bytes of space are guarantee=
d since `num_entries`
>>> +        // worth of space was just reserved.
>>> +        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, b=
ytes.len()) };
>>> +
>>> +        let padding =3D num_entries * size_of::<u64>() - bytes.len();
>>> +        if padding > 0 {
>>> +            // SAFETY: At least `num_entries * size_of::<u64>()` bytes=
 of space are guaranteed.
>>> +            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, p=
adding) };
>>> +        }
>>> +
>>> +        // SAFETY: These bytes were just initialized and every bit pat=
tern is valid for `u64`.
>>> +        unsafe { self.backing.inc_len(num_entries) };
>>> +
>>> +        Ok(())
>>> +    }
>>
>> Ick! That's a lot of unsafe code. I think we can avoid this by using KVV=
ec<u8>
>> instead of KVVec<u64>, ideally in a new type that upholds the padding in=
variant.
>>
>> Here's a diff of what I came up with; note that it also gets us rid of t=
he
>> unsafe in take_u32s() in the decoder by using zerocopy.
>>
>> (Technically it would also be possible to make Cursor operate on a byte =
stream
>> and let zerocopy to the rest, as all the take methods are fallible alrea=
dy. But
>> I think the invariant on EncodedStream makes sense.)
>
> Actually, I forgot to add the optimization you made back in, here's the p=
roper
> diff:
>
> (Also used T: IntoBytes as argument for extend_with_padding().)

I sent the respin of this series using your EncodedStream idea but I
think I should add you as Co-developed-by. If that makes sense I will
add it plus your Signed-off-by (I think that's the right process?).
