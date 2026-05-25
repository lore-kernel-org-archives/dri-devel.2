Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD5CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB9A10E2DA;
	Mon, 25 May 2026 12:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjPtszwc";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E1810E2DA;
 Mon, 25 May 2026 12:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKt/NAzXt1EUexCTnBaFlUmqEmKTD/oFnY8NbmZAiGhYcmVhP5utGw2mBdHv22DppOB0yy390zSKTTZX0fatptGIQCYZsbRRsKqlLuAsDbTGAchifoFJQCjr3XCX+0byP1OOPGw8e78CnkakLy3IQgcqh7PBGBX8K5PDfzObnjWW87i/h1TgE1Wk1S3IUM1Mao2o9NYutCb0V0eoxWa/s9Sd8j4jAU1kp2hGlTqAMBKKLhHTObmIhzSOVD0boVMteQqgSJi+18rikxsMidc1Vohg2qpEATSTzhmhmn5j7T53Bfwos9JswyHbpSJZipJqf7rrQaJC2/LYbvem8KKhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUMfAEMQJc7XxxUNdgqjRPcyEa++2NTwvLKNfBRC9rs=;
 b=TngkT+B/CPxy1p4SAp5Lm//OPJbvvWN9Hu6CxHboSKamBclw79v5AMc1G1IvnzuN5OC1vF9UQt10yG5EntdbiiFwZB/GIyCPH1QsAbgkBoHeYfdFcUKvyY85fUlEnqHn7C5JA2y6/Rel278u3PRD5cp8lx2gEQt9N2HjdNB/iNO/my+I8jVo94/ALmKJfu7fKfaJb6qB9ZYQcnTTXkcP890XzBlWa6js4ClyXFrs29bvzQ4gXwXXdZcEmoVTBN7TReIFMrugkVI5g73VtA3oleBzisoAQy1Ilzjy3LoaoWEaLp7dt1dq/lYFMDzHMlpd8NXC0UkVLDCS4DqHPgT7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUMfAEMQJc7XxxUNdgqjRPcyEa++2NTwvLKNfBRC9rs=;
 b=gjPtszwcgUc41/WxbcibyYgIPTzq8VmgMU4SZjskoHg7cgtYwr50AadA2kTldqxLt3o0KYkX/6tepbNgo3rTXtY4XfrQdEbS6isnwDBmabnry6+kuATkwJmnBtwRlekxUOrp0+MriNUFGX/7FS2WALOj72fprQ1p+OBOXezyB3YsPwEAW15uh1HFbveilZflk87DmUo0839KQEax+TIlmSpu+rW2pR+fAg4qwsyfJihFRTlgNZeQQ2TZc3+Eci1minT3ykcQzXNzKqtE3eLIsCFDZ3h779pFMjTf2AeJbn5QRL0zgZjQ1Dd7NzYL8AIsCWqRP+tP4COqAJI3kdOz2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 12:38:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 12:38:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 21:38:39 +0900
Message-Id: <DIRRI8BMO3CL.1H4LSPXCKOAZN@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 14/20] gpu: nova-core: vbios: construct
 `FwSecBiosImage` directly from BIOS images
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-14-5d3f210c5602@nvidia.com>
 <b7bba000-adf4-4ebb-939b-8f9f549fa6b0@nvidia.com>
In-Reply-To: <b7bba000-adf4-4ebb-939b-8f9f549fa6b0@nvidia.com>
X-ClientProxiedBy: TY4P286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: b330e792-5247-42a9-4f69-08deba5a8e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|4143699003|11063799006|3023799007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XstuJ1w25NYRhKZlZmMJIzeLFaLGICFhrb1X1uxYeO27zroTS4gdrz6KZwomplTX37Iqf3AGIo80pOigga30/36dtYWxAGYi/J3up0Apb17Xg1VR6MdnhHsPowDwyNoPqz3FZaAZWULdhtX6/yw9LtfREyBKsV+VCeMCjZgQZ68xOAWvga0gkpwAlW8nwmBOlzTS1JpHUcNIQm4uhYzFc3QEQ4xIaF8Pth0lJUHH0lJXMEeOi2+QNhHGRyt2RBHAh85KKm1WQwOrRNIinxhkAAAYSKjJJri/R3KaUkWdRZ+npwOgkb0JzAiCkKlXWJOdJUHQGxxagiDVVUv89sKUWCm002S1Ta1x4Y8X1eESJRg0+/fQOJLfxZSAAvtHbrpmRfcj10Bz4J019WUnC63ibZ8zxl1q86avaKs8KUctGHqScf8XC6B/5ZhKrWtdh4ORE4d9+pw9fzbhdtZqs/EdGN7CMiAbEB1xlS2SyVgqLETT9uhudArKQsWixDNebMhy1FC8yhdqtvLA2JX01GQ0ox8WpEfLmAC8oeiGwqaha8pMW5ZlViyDtoItjgznFp7K3n4VNlYEL+LBkF8sVmfo297YI/qnpNSf09kVMCsDFzYAeRX4aP5/Nh4eag3jQl5ZxiUUdHyQkTWe9VlX5PFQnro0jG5MuqFNOxFrrS+IAXN/p4xiSguhO2ekZ95vPkdj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVAreVZqWUVMTDUxT2thUjc2dEtYY05VTElvbmY4Vld3YkJJZGVPcyswYlk4?=
 =?utf-8?B?QjU1T3Ftd2dPS2pDT2FBQ2t5V1dnQnFGWU9Sc0Fxd081UjlJdm05elhCRUVX?=
 =?utf-8?B?clNiOTk5SkFTRlJMNjlleUQ4SkRsS0lhbUdPOUNCeE9ScWtkcTRqRmV2Kys1?=
 =?utf-8?B?NUlmVHowWUhFY0ZxWUlYc1IvdHdFampjVXAwRHZGV3VWMTBiZzNUZnpUM2xM?=
 =?utf-8?B?NXQ0NzBOOFlpN01UblQreU1XTTUwdnFwa1piTFpzWVlYeFNFWHZPODRjYXFM?=
 =?utf-8?B?RmQ0UWhrelJYZnlQUm9jUlFGVkNtS2J2R2NzZ0U0dnE3Z0RzMEYyUHZRSm8r?=
 =?utf-8?B?a1JpSitpd0NXWWErQVFCN2tZMUgyZVJ4SEdDT3RKZUZhenY0a1l1aVRmRHYr?=
 =?utf-8?B?ZTFiWUlQSVhQckF4NUZkM2I2TzBnSEd6d0E2d1M2NWJGdmwyNUdYazZjRVgy?=
 =?utf-8?B?K1cwWVMyQ09YSElSQjJ1a0d0NkZvdUJ4bmdLMmVIa2lzUUtiNzhlWTdaRzV5?=
 =?utf-8?B?Rmtodyszc3VBdU1Remsxbjk3dC9ndnlBNzRjZENjMGhldlJRaU80OWdvckhI?=
 =?utf-8?B?emlPMlByVldUdWMvOE9LWnZtdFUvWExYMU1aL0hDVmo1NlZ0b09ERkFySEQ0?=
 =?utf-8?B?UTlNcVlsWFYrbVh6SjE0elVFdW91MXdFbEVlYkU0eDZLbTR3RGYwR2RUNzlI?=
 =?utf-8?B?SUdMWFJheGFIZkczMEZXNi9PMnFheW5TK1JGaUZ5Mi9rYUp2ekgwUEZwTFVr?=
 =?utf-8?B?ZmxlUG84dERHWHROTUU2akZ6MWYzNnNNYTB1U05QYkQ2WVJ3NjZkdmh1b1VU?=
 =?utf-8?B?UGl6Z1Q0SlJudmMxYjcyQjJRaFZNdFVYakNLaGg3VUIwTnJlS0dLTVkydjNY?=
 =?utf-8?B?dkhtYW05QVczNlg3ZmoyVHhvdkljMVRDT251WVdWRVBsL2liMGFseHAxdG5h?=
 =?utf-8?B?V0NqbTN4OHZlb0lIQWh5MHkyYWN2OUNCcXV2OHoxeHRNVUl1UitFc3J2ajVT?=
 =?utf-8?B?cTVhb1hkTExiMmNPbTV1d1hBMkFvaXpmRFFSbFRMQXJsZGdDeUhaM1BYdEtz?=
 =?utf-8?B?RjV6aUQvS3RvSVM1b3I3ZmFMUlE5Um9LbEVra1M2UXNzdnhlVXM0M2w4ZGc2?=
 =?utf-8?B?V0xIMW5xeW5qTnBLZTBjQllzS0tBc0tGbG5PaUFHZGJJSnJ6S1RGdnYvNzg2?=
 =?utf-8?B?Mld3OE5ZSGM4WTBEUmxsRVRZcnpGRElJS2FkR1BLdE5TRVJPWkhNcnNpQ1dl?=
 =?utf-8?B?TWIzSmVHMnBqQmFmT2tVQmpzdXptbUJxMVY5RU1NVkgrWWNnei9SRWg2ekg4?=
 =?utf-8?B?U2FmaEdIeTZCWWVsbkxVR25ybXhBTTR5S0FZRkIvM25Gb0FUMXFTSHZ4dDMw?=
 =?utf-8?B?UlRiSnVBQ2ZTYUcxbzh1L0tqWXFQRGsyblcxRkN0bnozSEVwMzYrdUVwT1l5?=
 =?utf-8?B?UCtoOGF5WXhMQXd1N2kzWS9Odkp1S2FaNUhURW5Vb3Z6OEFzVDNwWFJRNVhK?=
 =?utf-8?B?a1BKVDI2TWZ1QUN1SWJNd1QwbVMxWkNPeXJCamhJdmhUaW9sWEltU2loZ1pJ?=
 =?utf-8?B?STdnK0dMcHpSb2JJcDZja1NLZEM0SFNrUWM2QUNmZitPWUI3WUwrbENtdHZa?=
 =?utf-8?B?V3ZGTE91dlpId1ZXVXJSRlBKRnBKbE1UM0l4b1NXbjI4UERpR0p4SXIzK3hX?=
 =?utf-8?B?Mkg4VWZTN2EyWGJxR090bkpIUytkV3lKUkN2UktJWE5razlGcmYwQkl3blNv?=
 =?utf-8?B?c1VmNDJmVHBlMk1SN09pNGF4VmxabXNybHpEUmhZY3NiY3R3SmZZYnJjYUpk?=
 =?utf-8?B?U3EwQnF0Q2RGYitZTURHQWxMNC9XVWJWKzZDbmUyMnk2QWRrYWJ4TFRHQjRx?=
 =?utf-8?B?NnFhUjVKYi82UHpDWS9NOUZUdmt1TGl0VEtJSmJsZHlqcmEremphMTlxNUlG?=
 =?utf-8?B?ZkZiRmFoQkduVlhMUXZHbXltM3dDZ0RSZ2F1SC9TMFVaaFhQek8xbHZET3lV?=
 =?utf-8?B?L2Q0eWZDN0RIK3JQNEJGdkpFbDErUHcxaVVPMURTR2VRT3Y1aHYwMFQvZjY5?=
 =?utf-8?B?U3FjcXdBbEM2R3B3KzBWVzRpMjhsdksvbk1FeTh4bFRmMFdwc2JUK3hjOE5i?=
 =?utf-8?B?Nkh2WURGTGtxb3RyT3hwQWVEbzJpb2N0MGRJTnFDaWEyTmxxMFAvOWhINkhO?=
 =?utf-8?B?N0ZXanNSWVFUODYrQ1htMWJGOW5OOTFPeWk5dWNhaWN0d29UVEkrRHZlMnhD?=
 =?utf-8?B?L09lU0V0OEI4Y2lqR2pJZXY1WWVUanh4Q1EzR3FUaG9ZM0wzRkliZjFKbUQ2?=
 =?utf-8?B?VGErbzE4aURtQnZvLzVXN1hLaDlybXhIZHFTVlhxWFJRRS9Yd2pObDlMNjNW?=
 =?utf-8?Q?HCt8J9Rkws0RRzgWDgCHGJ9EYojoU+QjtckJo+Ot0X2VT?=
X-MS-Exchange-AntiSpam-MessageData-1: 7GkcyP5aPgfiXw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b330e792-5247-42a9-4f69-08deba5a8e49
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 12:38:43.1414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXs2XRIzisfSdyW4r+AbMG9JDwPv806CA/4V78BJIDnpfJDt35GBVLUjA/yPACKhx+2oIrHJ6nvpsqhuVoTd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4
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

On Sat May 23, 2026 at 9:13 AM JST, John Hubbard wrote:
> On 5/18/26 7:55 PM, Eliot Courtney wrote:
>> `FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
>> gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
>> and construct `FwSecBiosImage` directly, as a simplification.
>>=20
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++------------------=
-------
>>  1 file changed, 39 insertions(+), 59 deletions(-)
> ...> @@ -353,15 +349,23 @@ pub(crate) fn new(dev: &device::Device, bar0: =
&Bar0) -> Result<Vbios> {
>>          }
>> =20
>>          // Using all the images, setup the falcon data pointer in Fwsec=
.
>> -        if let (Some(mut second), Some(first), Some(pci_at)) =3D
>> +        if let (Some(second), Some(first), Some(pci_at)) =3D
>>              (second_fwsec_image, first_fwsec_image, pci_at_image)
>>          {
>> -            second
>> -                .setup_falcon_data(&pci_at, &first)
>> +            let fwsec_image =3D FwSecBiosImage::new(pci_at, first, seco=
nd)
>>                  .inspect_err(|e| dev_err!(dev, "Falcon data setup faile=
d: {:?}\n", e))?;
>> -            Ok(Vbios {
>> -                fwsec_image: second.build()?,
>> -            })
>> +
>> +            if cfg!(debug_assertions) {
>> +                // Print the desc header for debugging
>
> Both this patch, and patch 16/20 are doing a tiny bit of work to
> preserve this printing. And that looks good.
>
> However, after careful consideration over several months, I have
> come to believe that this printing is no longer earning its keep,
> even for debug-level printing.
>
> A significant fraction of the dmesg debug level output is consumed
> by this one print, for example:
>
> nova-core 0000:01:00.0: PmuLookupTableEntry desc: V3(
>     FalconUCodeDescV3 {
>         hdr: 78381825,
>         stored_size: 59904,
>         pkc_data_offset: 1444,
>         interface_offset: 28,
>         imem_phys_base: 0,
>         imem_load_size: 57856,
>         imem_virt_base: 0,
>         dmem_phys_base: 0,
>         dmem_load_size: 2048,
>         engine_id_mask: 1024,
>         ucode_id: 9,
>         signature_count: 3,
>         signature_versions: 7,
>         _reserved: 37449,
>     },
> )
>
> ...and yet it is exceedingly rare to make use of that particular
> data, even when debugging.
>
> Let's just delete it. As always, bringup people can add it back in
> temporarily if they need it. But they likely never will, because new
> hardware doesn't hit this path anyway.

Yeah, good idea - I am glad to hear tbh. I wanted to delete these when
working on this but I wasn't completely sure what people find useful
for debugging etc so I left it alone. Thanks!
