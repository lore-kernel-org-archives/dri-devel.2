Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5BDC531D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B0510F148;
	Thu, 23 Jul 2026 14:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fd5iyz3t";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6EF10F140
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEOMGgm1lCd48WLuDHKCcQNeDdkWdE+SjAYGnfMUebrZQ/Prq63IeF0rQZp7fjdS5COJDn/n0JOEcsbh1vJmHb8ip6GE/w3AkAAJHGSxQBpjmuutOsCySB0stC/vORzim9oAUFx5AkmxFUKzstXT4gPQJKXBuKI+VaLBy/TGvuzW2hTc0BXu+mlmc7e3O5DD9Yy/QkXJz/lmofG6GPvJRiwIIoztfS1amB/H+UWVGcXdTAs4t/9OlS1RAPxmz8TOmELluot3TZ6oYdZVpbWh5nDSjwQPFnmxmgZCoX+cXCW/1LaOwIQzO07pvfQn9GHZUBx/IHs28W9M4TrwosaOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWB6pvozlBH48ggVruU/IR/PCt2YLvlLimLeJ/owD0A=;
 b=whbtEdbRNuNAHQYqC5DaSKhLoEPxnHLiVIQLJ2w6ZwqtlELYAAIQ2WkZTrpP0huSNCfd0TYHXdTI8g89z8PXjvTgyWRexQNc9n9Nwzk80DxSaIL1LqltrI0xFDfHcFQp3iaj6PrfLtVXYEf8t3bPq1glhkhhNm98UTksL0D850+zPqQIV5ieyIHu+3WlYoPqo7aHEDxHh//BmG4ppx5XZkjG1p9gOuyoqlH/pnMSwbxtyTkJLgLhARN/692C7UZnyKUnaRKGNl4khDNWgpMJIcapPfbzzBK07sXFNhpBp+VbbJHLrkKpWecen7kKs3K6utg2L0PjOJJTOYVnv3Cw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWB6pvozlBH48ggVruU/IR/PCt2YLvlLimLeJ/owD0A=;
 b=fd5iyz3tWUYuDbEjz7SVQJkFjPOpMvLR4K7vA7Fj+oDtaLV+eGEsJlSZCBom70ss53pIqVDZmKlH7AJbM2duW0+gQdHRMoeZn8y3extqxb+3kKwh24MGNMWPyUzl2EBX1GI8KKFScNFNz7LtOvc8+n4GgwfpM5iSowO4VdsaHx49jaDsaxjtB14sveazQiJsYOTVru9lKCbUSJZU5b8PasKZ+jqGh2Fbzya+/o6lJqX/IfWdFKC32p11NPYtppZQsfzR319tNv+fPybNIWecMMLLGBw/azGHbyWOSBU1gSWivMIPp4x4pDbEjorbT+jt9XefiVQi5CCIkMae92cXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS3PR12MB999240.namprd12.prod.outlook.com (2603:10b6:8:38f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:12:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:12:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 23:12:30 +0900
Message-Id: <DK60G8GDS2V9.T0LEJKNA2JJA@nvidia.com>
Subject: Re: [PATCH v2 06/10] gpu: nova-core: correct FRTS vidmem offset
 calculation
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-6-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-6-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: OSTPR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:604:218::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS3PR12MB999240:EE_
X-MS-Office365-Filtering-Correlation-Id: 129a40d5-fd32-4a24-6727-08dee8c47113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|7416014|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LIGH5Kw5alcEF+mfvq4DgjuSp+v523chddZ6GqANE8umcng8v9HiYu606XmOnFtUS5cfrCkstiqlQrK/U6t3eFU5vUYrlhRHsMz/j4NFHTOfQiul3Z25kKF//NP038hTAOJIMzxKG0EZTQGSqGMy6tzmzKoihc7UGKl60r0GErDa2FZFRGGmZa5eVxdIJYdVvpVvJr+sU4isN+GR4C/HRtgy3uTS1MeRRZd59+vobu7mfbrcQ18L4QsVUUsEYwJzcyJ8TxBW8IyJqH6Zvvg+j/YM+x1bX83dVjVkJoURgbVt2elVWLnwU7+8758FWfDMAHu/uNal/j+G1AlHAxFOFYwAmcvqSc0KjxsjZPI4JiSKBBsCXJeqi5MBFGwZEd2ZVKB8SxhtfB33G3kD19bmsBiTLRPa84LMbKz6TwuGnZTwbS5ompA0tbsKI+jCzL50UngdwEjaTVc19N+Cs+lHQ69+FLWy4NGtB0Tx90BNPMG8VsySDkNOG949FtS+HmWcy5+7upIbEjk0vt6i7XBAO4mP3ciyoBcrfhHFpEAUzjZI/hvDzzZuRjLkldM9AbKVJbWMjNkbknecqXmvbuxowW7v4zg+F6NrCvEWeP346gtbZTwl7ST+LISL8U16FnQ0JTPc4SfEYsFtpu1zW/9CQtj3V0jATiqg5KSqEp8YpvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNjeXZkc0VhSXBTU3puUWw5V1psTkl6UktXMzhIdmNHMStkRXJ6RjhLUlJk?=
 =?utf-8?B?UDVIcXNTSVByb2VGZUV3Q0c1dlhLb0NsMUQzbzN1U3R6Y0FreDZYT1NQalls?=
 =?utf-8?B?VEhISWdwS25WUk1GVUtLbmg3NVZFbTR1ME1taGhmdC9BakhiUDVOalF6TDJP?=
 =?utf-8?B?SmpwSjU1VzRYbTJGR1ZBeEovQTk4NVpVWURaTW8zaHJQRHJuZ1FUc2VOdThO?=
 =?utf-8?B?ZFAvRThDNVZuVEo0M1dqMHMvblQwN09CTWFqdUNldTE5Wkt2eWJUMlRFUXVu?=
 =?utf-8?B?anl4QlFnRVpYcUV2azJLcmVQTEt2RktkaFc1SnE4R0ZNU01sMFBIaUFlVmw0?=
 =?utf-8?B?WkdITDQvKzBCSjFDMTA0R3kwMmpsdVIybFNHV09qYm9jMWFZZmxOQ0dZcXk2?=
 =?utf-8?B?c012RVdtZUE3Nm1kb1hmQSswUWJlOEFSaVVLVHVyK3orYk9zOFF4L0dTdThx?=
 =?utf-8?B?L1FBeFM3M0xNRmFEcW53MzJKTlJkZnlJcGNJdDcveTNKNUNzQ2lVdEd1QkRR?=
 =?utf-8?B?OGRkUjNVajVJOFNJcjZQc0lodTZJY2QvNFZtb1JkY2NnZzBXL0JMQjlKcWts?=
 =?utf-8?B?MktqNkxTUHpnMENQNld0eWFBNkNybFlPUlRWdEswNURHYlAvQURweWFNVWhD?=
 =?utf-8?B?cDhVNGw3bFdUd0JwUnFobkc5a2QzMGlzVkR5Um1PVVBLWGZmanl4QjVWdm1V?=
 =?utf-8?B?T2paNUxOUXpySGhmZzJmcS9aakVwNGtrSEduVmMrM2FUa0pudFFHTkhvK1Bo?=
 =?utf-8?B?SVFFVGljclpxT3ZVaW85SS9jakdJYi9ZaVlCZGVjbVdWQkZwS1lFZHFkNjRr?=
 =?utf-8?B?bjJmVjFvVU1NK0pmd1lEWFlpbFZ0OTZnaGRrZ1FxZVJsZnlITmJYNDJWczFD?=
 =?utf-8?B?Y01EM043NmpyZHNWejRRcE5BeFBCaHo1UXpmbUN1cGNHSGpCVnQ3Y0x4UzJn?=
 =?utf-8?B?RHlKTkdna3QrWlpWeTJ6UVBPVDcxWTdrYkcyT2dCTk1nODAwUXZORWdSbUx6?=
 =?utf-8?B?RlpYYXhjbFAybUpFK0pMRDBUbFhUeG9yRnVWQ2hWbThPNFVXeHNPUTVMUktF?=
 =?utf-8?B?YUFqZDZwNVFybnFsRjBtYXZNeWY5NjhBblIwVzVZYkJKRU5XVzQ0eFluOUtI?=
 =?utf-8?B?RFNmYlhyeHg0aHcrN3pyWDYrZ2ZNK09OMDhFTjUyVXBJQis1a3FiUFVRVW1z?=
 =?utf-8?B?OXB2VWNMYWVzWHAycEdPcno4cHhpcUs3SU9YYlB1U0J6Qi9mL1V2Ym1OSUcv?=
 =?utf-8?B?V0hueFBic1RsOFZ4ekNXc2ZzVHdodTJPeGYzbE5LU3B1MXRMeVA1MzJQOU51?=
 =?utf-8?B?LzMwS2dlL3A2MThKcnR6Z0FLY0xtQlRaMk50ZWlvbGU3b2laZUdtaDYwaG5Y?=
 =?utf-8?B?TnBYK0ZtMmg0SUtaUHkzaDJYMTYvY0tLY2FJNHFTZEg3TWRodHlaaXJCVkRJ?=
 =?utf-8?B?bk5yMVQ1N0NmVEpKRHhFNkpMcWJUbEF5bHJEalRpSVQ5aXMzWXVZc2QxLysw?=
 =?utf-8?B?NXdUQjU2enVzMEUrRERYR1JyTDFjVm9UZUNLOVcydk9MdGd0RVFqTC9kWG5u?=
 =?utf-8?B?cHR4K3p6U2IxaWRCeVorY1A1SmZBRnc1eitoREt1NlFaOUpoaGovNzRYU29C?=
 =?utf-8?B?YnZySVRvRGNERVhqbzlraHR6MnV3dFluNlRtb1VHMTBpOUlhNUlNRnZkZEt3?=
 =?utf-8?B?TDVGbkkyNU5RQ0MwVnBwRnNDTFpYdURydFNHNjFRWm1RZmNhamxCaktscDBj?=
 =?utf-8?B?ZTI2RUdSV3RSeFdqSm9RYnhDdEViMGdvZkFpVks0WFBjTmN2K1RhRS9RRVlP?=
 =?utf-8?B?RU1rVjJucS9RblhOcHZNeTZRM3ZueS9aYXZyaTUzdFBNWUZZVkhoOVR3WG9U?=
 =?utf-8?B?RW10NmJIR1VDNkFvd3Q0UnpManJ6cCtiMWs2YkN2Q3h5R09xd3JldEpsNkE2?=
 =?utf-8?B?V0Q1OGErdUtqaFlJMXFkUjAzVHl4a0tPeEJwK0Ftay9VQkw3VHRoNWgvKzIx?=
 =?utf-8?B?VXNpRkhpRktZcFhzQTl1MzZRcS9sQkhKaXN0NEhiY3YwUllVRlpETGNMK0FB?=
 =?utf-8?B?SXprNE1UWUg5L2RYUGJFRU5TTDkxVmdCTG41dWtBa3R0dWZNVHRHcVRmN2ZS?=
 =?utf-8?B?N3VsODQrTks0QjdMdWlEVkJja1hqVWt4NHZybVc1RzZPdkJvdXRkQ3JWRytt?=
 =?utf-8?B?ZnVYdFhIZVNmRlg3OUxXbC92QzhmNmRaZTJTSGx2OFVBdnNYay84ZHJnTU0x?=
 =?utf-8?B?dnpFSW9PaUR2R1hSby9KejcxeW4xT0ZBeFNKNEVqSHNiUUk0b2dPSG1iSUNQ?=
 =?utf-8?B?ZjhkSkRhejhpN3lCNkpHZTdwUTJoYzFnaGVLUmkwTGlsODE5S1U3R0d1OGRH?=
 =?utf-8?Q?lH4310ViHEDE4ppAncSQDhMX7PWAPJlo1OBBaHDBb4lGx?=
X-MS-Exchange-AntiSpam-MessageData-1: vEEUkJtRnUAglg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129a40d5-fd32-4a24-6727-08dee8c47113
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:12:34.4452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y86dOZnCAdpGnkkFXWlidm13+rEDcXZi5F7UYl+aZGQryVpovj5D3ThsMKEvZ2y/guXtxIZMRgPR++NHZWjuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999240
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

On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
> Currently, the frts vidmem offset is calculated based on the non-wpr
> heap size and pmu reservation size, but this is not right. The layout
> actually looks like this:
>
> | non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |
>
> It's just by coincidence + generous alignment that the values happened
> to match. Instead, define a per-architecture reserved size at the end of
> the framebuffer and use this plus the PMU reserved size to calculate the
> frts vidmem offset.
>
> Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of =
Trust boot")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb.rs           |  4 ++++
>  drivers/gpu/nova-core/fb/hal.rs       |  3 +++
>  drivers/gpu/nova-core/fb/hal/ga100.rs |  4 ++++
>  drivers/gpu/nova-core/fb/hal/ga102.rs |  4 ++++
>  drivers/gpu/nova-core/fb/hal/gb100.rs |  5 +++++
>  drivers/gpu/nova-core/fb/hal/gb202.rs |  5 +++++
>  drivers/gpu/nova-core/fb/hal/gh100.rs |  4 ++++
>  drivers/gpu/nova-core/fb/hal/tu102.rs |  8 ++++++++
>  drivers/gpu/nova-core/fsp.rs          | 25 ++++++++++++++++++-------
>  9 files changed, 55 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index fd60f93258a9..5ffe66af282f 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -305,6 +305,9 @@ pub(crate) struct FbSizes {
>      pub(crate) heap_size: u64,
>      /// PMU reserved memory size, in bytes.
>      pub(crate) pmu_reserved_size: u32,
> +    /// Size reserved at the end of the framebuffer. This is architectur=
e dependent and used to
> +    /// compute the FRTS offset for the FSP CoT message.
> +    pub(crate) fb_end_reserved_size: u32,
>      /// Number of VF partitions.
>      pub(crate) vf_partition_count: u8,
>  }
> @@ -322,6 +325,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Sel=
f> {
>                  .wpr_heap_size(chipset, fb_size)?,
>              heap_size: u64::from(hal.non_wpr_heap_size()),
>              pmu_reserved_size: hal.pmu_reserved_size(),
> +            fb_end_reserved_size: hal.fb_end_reserved_size(),
>              vf_partition_count: 0,
>          })
>      }
> diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/h=
al.rs
> index 714f0b51cd8f..aa50534550eb 100644
> --- a/drivers/gpu/nova-core/fb/hal.rs
> +++ b/drivers/gpu/nova-core/fb/hal.rs
> @@ -41,6 +41,9 @@ pub(crate) trait FbHal {
> =20
>      /// Returns the FRTS size, in bytes.
>      fn frts_size(&self) -> u64;
> +
> +    /// Returns the size reserved at the end of the framebuffer, in byte=
s.
> +    fn fb_end_reserved_size(&self) -> u32;

This connects to my comments on the previous patch, but this HAL method
is only ever used on the FSP path, yet we have to provide values (that
will remain unused), for all chipsets. This really strenghen the case
for making FbLayout/FbRanges/FbSizes local to the boot method they
belong to.

Since `fb_end_reserved_size` is only ever used by `fsp.rs`, it would
make sense (from an architectural point of view at least) to have it
defined as a HAL method - even though its name screams "fb". Since they
are firmware-dependent, I'm even tempted to place their definition as
constants into `firmware/fw.rs` to make that fact unmistakable (and keep
all firmware-dependent data in the same place, as missing these upon
update is a source for headaches). It's not perfectly clean but there is
precedent for that: `fb.rs` uses `LibosParams` for instance, and
`GspFwWprMeta` also comes from there.

<snip>
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 533fb95573ab..a38ba66626d8 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -134,20 +134,31 @@ struct FspCotMessage {
>  }
> =20
>  impl FspCotMessage {
> +    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. =
It is measured from the end
> +    /// of the framebuffer.
> +    fn frts_vidmem_offset(fb_info: &FbSizes) -> Result<u64> {
> +        let mut offset =3D u64::from(fb_info.fb_end_reserved_size);
> +
> +        if fb_info.pmu_reserved_size !=3D 0 {
> +            offset =3D offset
> +                .checked_add(u64::from(fb_info.pmu_reserved_size))
> +                .ok_or(EINVAL)?
> +                // The 2 MiB alignment is r570-specific.
> +                .align_up(Alignment::new::<SZ_2M>())
> +                .ok_or(EINVAL)?;

Note that we are adding two `u32`s and aligning to 2M - so there is no
risk of overflow. I think we can just document this, use unfallible
operators, and return a `u64` directly. Although `align_up` will still
return `Result`, so maybe we need to keep it after all - but the initial
addition can be unchecked.
