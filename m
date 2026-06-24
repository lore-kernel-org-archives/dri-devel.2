Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2567CCD4F26
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 01:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0730D10E00E;
	Wed, 24 Jun 2026 01:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hZTPpt1w";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D6610E00E;
 Wed, 24 Jun 2026 01:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlp7zAiP6w3KbyGa3v0wa9IxDVdzrI9icrXRFWbqJgIfP4IxKGXUoAEdcyxhxT76ZYht5bxa609Z7mCJVa15XIQNEJ+RC9uMcEkYsVN+Yr0edPKj0xLZcoCLTeydnZNkaeBxDGwDr1Sp86Mm/edL3SYM/5TmbW1+jNEefqsCcx+8KfwkOX++TYgtQRbVzdQYcYsS4OVA+pqcMKURMb46XnlImCjQA8NOKQyzyNwFLybgpPQy6S5olaCYfVGhDXm6IUm43/jYNrqB0oiBCTVjLwPICs55cE3wuGbWP5jLc/vMHff9GWyl+Ca3B4/ByKhEiMJZPdfR28ioA2JWBZLr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2NXQ7NfWC6sMcZKowELSKboPcxMYNOH1TArTfq35EA=;
 b=D2PEPTrXoCTs3jn1S6tIYhxlSwnqllHRvQH1gg8zaMnUfla+RhEPw1f10i6Zs6MESxN1PNUxRQBHzCpclx1YR5ISmQfcNjq5jepqmc2Z2UfOz4AEpa26HhLpVCHRM7axIBh616KRaxyreHFGwRV2odYUBILRL6qNUIQCOHxAEbo5AE2TWANZcTzeg+0M+6rgsBGrS6dB2nJdW75RZ72eYGWv5GpGlydDWRxJOrVYA4yXgpuZmFXUM7IuW4BukS7Z6lxEW0SPceZvaEZZ8hM5Cr1SJ11NaSj8lWrbKoJ36FwjUQHMHxMVVg1iBVYasn0vearuJ+jtx0ngbcn3q30HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2NXQ7NfWC6sMcZKowELSKboPcxMYNOH1TArTfq35EA=;
 b=hZTPpt1wU7SLgfsgBV7wifasD25uhXBcGjhyXNPqQOQ97ISZp64KZ8KfJPOoYVVyx9sj29tAqHWA1JRw4VB2Au9kwOhH0H6ZgMDqhJf2qEV2ucs4DOpfcWAiaWtNbm5xqVUz3RQnmZvverpX9AtHQpvC4BmrdZRTC2uDnAGfa99McXlio0KsytqkfJlApJvHo/q06QsnC7jWiFS4ptcVsgG3L70In732rqt9LXaqjyJsediaPw6YA3fX0L9YT3CLyVnrv0g0Crv/fltxioDPZx0bg0RusnuF7X1pDL3+OxQTjAsJHtnUuaGFyRhIGc+NfuRNk+a+SsLQK0mMkIt/0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 01:21:20 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 01:21:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 10:21:16 +0900
Message-Id: <DJGVVXTT63F5.JUTP4LD46WVF@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 09/13] gpu: nova-core: wait for FSP boot earlier
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-9-f2853e49ff7d@nvidia.com>
 <DJBE8G5OR03O.1EDH7JL21U88A@nvidia.com>
In-Reply-To: <DJBE8G5OR03O.1EDH7JL21U88A@nvidia.com>
X-ClientProxiedBy: DS7P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::7)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 434b9c0c-e238-45df-8d78-08ded18ee570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: Ab168k5IPJqsD0DE6VqBH5g8kyik8bO1MRgj/6byd7tmfKew+1I459UUPVvD8NAFm+lYgbSGEWiVGaw705abm27wENCLry/sER3RB31ry//GrBEASUxPtlixY/jiwgNjHbkLoAi6GsSlhDYuxs6pFcV0ySlaz81II9k1iw7PHGDb23EY+6hXTUxckX9DAcq3d1c7vLMk7sXovrUtxXqbgqvn1llBlaWWIOy4Q3yHSNmo6ff+eAAA6rg6Epc0uXIsEefvsb7kA3w24JA5pcLwGymjTrFCCBvno6gSmVU+XdsDRGd0r9JalhOdz+hRwDZ64E6NIl9qpsTpRfz7VkH4G3mMIedI8oEMKG/gt2G+lE/Li5mF1fne0PZMr9gShJELTP3TmbwRDku4tQHkmzGQeT6f2E2Yr6G4ebQeHKQdE18n5u63Sl2h3f1/06Q3AHZAT9fXZzxl+CLSGv39dCoZu6rnkKMDl/Bt1HCW9EUYLQIX06LfIwqvOy7TYVuT5rX7GS8dcofi5zG8EnUzrUBKIChGulVGaoW5QenMd7s2qVFkUBmfRg6zj9vSXE+m/Kw46Sh/4if2yIftxkU81Whx20xmNLFQ2D8vllWflZdauazYPKD8IKRTCc1+2/h2Udo/Cyrn00Epc47SaMJIphTc3svS+xn6JUZC3HT2TjJFYOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlnZm9zM2YyNjNPd2hoOGpoa3IwaUh0eHZNWHA2cDdTMkNMeWJZbHVScy8y?=
 =?utf-8?B?YU1MM0tENFpkelQyYmRveWdEVEVvOFQwOWQ2Q1JGSjlRUkJkVFA2MFROTEZI?=
 =?utf-8?B?ZnNub1lpblppeVc2UlBQRmVzaDc4UUtQQmFKNTR5Y3p5eEdlQzJtTmtUalVH?=
 =?utf-8?B?dmZVVDhMS2NLWlp6UnRvZUFweHkvUWQ3ZEZ3WnZiZWsvU2NJVjg5YmdwN25E?=
 =?utf-8?B?MmI3cWx5Y2FqelgyeEw3aG9hRnovd2pEQVFrM05tTlV1aDJnQ0hjUEJqWFRU?=
 =?utf-8?B?ZzdDUTdSRFVNcEpVSTg1ajZaMnc2a0xzbmJ6Wm1MTGRoOTBLRzFBcS9xY2RG?=
 =?utf-8?B?T0dyRGtkSmsyRzJVcE8zZ0xWVFh6V3NDOFdaanA2RFpKbGJETzNRZVFyUkxR?=
 =?utf-8?B?ZC9GaDh1OCthcVltRlZOd0pGUEd0bGdoa1hkY3l4NkZpVVFjVG5aWHk2RFdX?=
 =?utf-8?B?dkVMWitPL3ZpcXFnTXBhY3Y1OUJlY1BEZU4zUVRWVjdHWnN3ZHgwc3hqQW5O?=
 =?utf-8?B?RHFkUXVXSU9KVXBFMXY1V09zdjU0R1NGUFNyeGY3QjZkT0x5V2V2c2hxWi9y?=
 =?utf-8?B?KzVzZ1BhRUh2d1A2UFkzOWQxQ0FhakM2NmNkRUV6blpXK2pZaEVzc09ZVFc2?=
 =?utf-8?B?SU5PTmpPVkN3TlUzMGNtMS9ZdnVIM2pERnl5KzhpdVoxRDlyeG1jcnI1RDl5?=
 =?utf-8?B?b0hpL3FQdkhQeS9ZZ1VzbTY4djRiaUE0WHhmYWsyWXk2R1V2L0ZUSUNLc29y?=
 =?utf-8?B?REE0SU5LZ1BnNTRESHNFYTFNNlRGMFBDVkN3N1FQeGtKVXFPaXh6N1h5RTc3?=
 =?utf-8?B?YldHL2YxcS82bGk5anB5bERWK25Zb0tSQ2twb3BBOU8wcWVmL21KRTJqOHNX?=
 =?utf-8?B?UStjbjRZUnRROUdKVGtMZUdSNGRrUHhKQ2RlWlR4NzZvaFdWUnNQWk4ydXB6?=
 =?utf-8?B?S2lZRXhVQ0Rqa21qSm9URTNQd3lKQUFzVTI0bEhhU3F0dUw5UVFueTZhd0dK?=
 =?utf-8?B?aGI3ZUhOd0pTYXN4VWpOZ3lXVjUvaUZKQTBxMnJrM3dtUmFtdE5hRE81aElJ?=
 =?utf-8?B?RDJZSXVxTUhxT3phOXZ0Q0RnNHhRRXVPMUtNaVR2dTh3SGJTdWZFdWtTUjF5?=
 =?utf-8?B?enk3U0tUanFQMTF5SWNoMExkWStDQ3VmMTNKem80Z3hZVDA1STY3Um1vOGJt?=
 =?utf-8?B?Sm8rYWxuNXdUeWE4UUU5b3ZDZEYwTHJHWHVJcEtmREIyLzRzMXVRWEpKeG9D?=
 =?utf-8?B?OW5yYm5rdHNjZmFHSm10MXlFUEV3R3lER2dSbStYRnhaL3ZFanBZdXZ6K2Zx?=
 =?utf-8?B?ODlHSmFwS3kyZ2Y4bXFPNm9FTjNVdmNoUllrc3lFTTczLzByUitRekdkSE93?=
 =?utf-8?B?ZXY2ZlBRVEUzWWVZVThZSTU0NnNiYkdBTHNVSC94dGpqOU0vb2dUYk95dnV1?=
 =?utf-8?B?MjlYSjdtcmtEVVl2M3k4cHE5ZVA0cVZGYzE1UFpHM21YTm55d00zQ0FnZHd2?=
 =?utf-8?B?RTZDalh1RFo5TmFzenNvTmJhbWI2dmdQSzladVlxSFR4bTY1QlhQMGUxOXdJ?=
 =?utf-8?B?WjBnZWRHc3dNUmtLNjhPb0xzSC85MkZUR2daNE1OZGd2N21BZVhwbEg1eEI2?=
 =?utf-8?B?MXVUVm95aDlldDNlWTh1NUdudmdsa2JkaURKVXJXZUhrNFY1UkJ3UjdIai9F?=
 =?utf-8?B?cU9qUDlvS2VIVllSZ1hxQ3BaMlVMSDZIYUk5TW50WkJJZ0Q5UVJYblhQbTB6?=
 =?utf-8?B?TEdobXFvRXorSEc3WkYvRG1GSW1DNW83MXhHRVo5bnZLSGRreVc5K05OQlQ5?=
 =?utf-8?B?MkhleTQ4Z05ncWR3bE1lK3BveEZQc2xPVXEzQkZLeXBzRDJNUkRNY0d3VmdH?=
 =?utf-8?B?VkxhaS8vWWkzcnQxQjUzbXVFRVVTaEdiU0d0bUhzVStnWEJLRDJvai9RcXp1?=
 =?utf-8?B?Z2ZGR3NqdGV5MkR6U2J5cDA1aFpWY0tKNXd4UmFiRjRlcEFYQzZzRUtkZUJG?=
 =?utf-8?B?TW5nT0pqUDVGZHo3cGVCc0NSYjZoazR0NitLZVVMQWZLckI2c2Rpa2dVdUpC?=
 =?utf-8?B?SjdPZkdWTWJKNDNyUDdVbVR6bFVJWUZxZDJkMTNadVpWb0YvdHpFQWZpdlRm?=
 =?utf-8?B?djFHMVpQSGorMUxhaXhqZmFpcXZ2M0oxMkpvRlNRTUp3bjlXZnlBd05JWVpz?=
 =?utf-8?B?Sy9OZjJqTXZ2czMrQVAwUHRic1czbHhISUR1YnowQUtIcDJrczgrNFNzMC9Y?=
 =?utf-8?B?RDVheVZLSGhqL09lY1pXdzFqbDJoVWZCbFNRSlRaajVBSzFWWU95VWo4eTFC?=
 =?utf-8?B?Z0J0QUZrKzFzdm81LzNwQkQvTUJDWDJpLzRVQWJGUmRYcmVBUnBiR3VBYy92?=
 =?utf-8?Q?IgLhN7D0aIvHezQY9HbzvCZxbVSW0s8Vy7EZPCmh6FcgS?=
X-MS-Exchange-AntiSpam-MessageData-1: nUKoMfSpc5PoaA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434b9c0c-e238-45df-8d78-08ded18ee570
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 01:21:20.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGDyCMevJqks2p+XviW/NxonbsV0Zulr1Raam1ZkVryB794CIjA5MCSdB7Me77OtTFKudM8LYFrlya6rhZgp6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

On Wed Jun 17, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
> On Mon Jun 15, 2026 at 11:40 PM JST, Eliot Courtney wrote:
>> For GPU architectures that use FSP CoT boot, ensure that FSP itself is
>> booted before trying to use it. In particular, accessing registers like
>> `NV_USABLE_FB_SIZE_IN_MB` for `FbHal::vidmem_size` should happen after
>> FSP is booted. Currently, we wait for FSP boot too late. So, move this
>> wait to a new preboot phase.
>
> Can you give a source for why `NV_USABLE_FB_SIZE_IN_MB` depends on the
> FSP?
>
> <...>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index b3c91731db45..ca37892c3b38 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -295,7 +295,8 @@ pub(crate) fn new(
>>                  dev_info!(pdev,"NVIDIA ({})\n", spec);
>>              })?,
>> =20
>> -            // We must wait for GFW_BOOT completion before doing any si=
gnificant setup on the GPU.
>> +            // We must wait for some architecture specific setup to com=
plete before doing any
>> +            // significant setup on the GPU.
>>              _: {
>>                  let hal =3D hal::gpu_hal(spec.chipset);
>>                  let dma_mask =3D hal.dma_mask();
>> @@ -304,8 +305,8 @@ pub(crate) fn new(
>>                  // still constructing it, so no concurrent DMA allocati=
ons can exist.
>>                  unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
>> =20
>> -                hal.wait_gfw_boot_completion(bar)
>> -                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not c=
omplete\n"))?;
>> +                hal.wait_preboot_completion(bar, spec.chipset)
>> +                    .inspect_err(|_| dev_err!(pdev, "preboot firmware d=
id not complete\n"))?;
>
> It seems like there is going to be a need to make the `Fsp` available at
> the `Gpu` level to support the vGPU needs [1].
>
> So I guess the solution here will be to just instanciate the `Fsp` as we
> do for e.g. the falcons if we are on Hopper+. Hopefully that will also
> achieve what this patch intends to do.
>
> [1] https://lore.kernel.org/all/DJAZRULU1QHZ.2NSTR1ZPOQUSN@nvidia.com/

Yes I prefer that, cos we will get to keep Fsp creation requiring the
wait. We should document that it's required to create Fsp (wait for Fsp
boot) before accessing various registers etc though. So we can drop this
patch.

thanks!
