Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8377FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123DD10E251;
	Tue,  5 May 2026 18:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6DEKXUz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7742B10E46E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuLZ2QHZQWUjYCm/tKA/hfSmZyzoMwBJmKuG8ErAC7/UKALOFh13648MiOpUD+r8he7flPmdwW/VFjOIPDQE3/VGDZ10aVn2GIYq4uT/J0mvAk3ygShMXloqpQp77Ab2U/73AaYJJdBfzOlnoC9vRe6/qMCaKO5MzY1Dw1CvpS4B5gKVSqjSvpkGInPfQjLdgAHTqk+jNgnSH6G5fVmUOMctlYVsLzZxrrhCmMs8HiVa9c3rJPa2y689+7uABP2Nio9HWuK49eqaX3Eu65IVk9hUCsvz4urh0PdqfR06z0PEbiPbVAjxo8yi8Ky2VUDBeW8fQanvYCfWcwyah5JWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJcUekmMgbrLOtBbnBsNuLHrYCyZCkfX+d4/M7GGAdQ=;
 b=p370CINhlK2YaPKljwHNqBTTZECDPca2IaK2u5D+E05EjUEvUDxs5jWatM+x62hQVZ60DwniPt+PYdfQJmVxMOXEOMwWcol+0PX/MH93sR6bOKQV91J5ewiz/gDXG9oNNd8ZjPuh6brzUMoc0BY/zDtePgaaQNmXfJTAzqpjawYLV0JH7FHSy+OegaRUkJSYAiGGAXccB/XaIYZR3GJCwJFOavP8K6FxTQYfolpY1lxFuwVcsSfoQh1Pi0XNPx87poyIlEepFVmiHsU5ahsQ6E+c1Mo/WFz4+Z4F8ap/HqwO/Nra/cRsxV2ygk67bDkd55BhBbMw34G618L4ITsMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJcUekmMgbrLOtBbnBsNuLHrYCyZCkfX+d4/M7GGAdQ=;
 b=D6DEKXUz+rq95kRyRkzmSrruKl2IiAxeA1Uc4TWhqLnQ4yEMWfdEduXo4nQtnj4092wZACsEmTJyYg/maXP3idXnC+D8DEvLoalLB969bGv3KmSQbEQhcCbfYVDqmFxTsASe350A+lqe73Z84nQPpZbKy6k0gTNQPEGOOLMYYMgpYMGJ0kCzz1wuTA1rnKg2gGQvNxCiDtwo4to2YtMGpgSzGAJmrPAJk42bL1WSEbZsHBiteHWSM8abVCGzJcGVsHBEOPkm+Ig1HEJ1J9wwXXvcl8tGfZbxxE4gV8cyETVkDayelcnbbmwOAiW3GKuJ7taOjWbrK+HSIWsvUJlvOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.34; Tue, 5 May
 2026 18:25:48 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 18:25:47 +0000
Message-ID: <b0d54b3f-4708-433b-9180-afd6a54c6226@nvidia.com>
Date: Tue, 5 May 2026 14:25:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/22] gpu: nova-core: gsp: Return GspStaticInfo from
 boot()
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-2-joelagnelf@nvidia.com>
 <DI8AZLB2610U.10MNQ0IPV6NSL@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8AZLB2610U.10MNQ0IPV6NSL@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:52c::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a5df8a-587c-407d-9fb2-08deaad3ba56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9bwFhE18cOFhORpP6AAboVimhrArCx9A4hwcZkqpgq9KaPuBp+DLgH47y9Fn4FMfDfr1Y5kpS/sCGQyOtYJYbkp+RNxKTArjA4hqhQHg5RinmorPV5ZpCce6CHo3aIAXhQsPfpabBCACHLreYl4V0IJtGKPBJpHKlzd+hlkFuBssVerFviYAgyTpISUPb39v0rotYq82XNqwLLfrarDfRtiNi5ywCI4xkk2fKlAZAE/sjI2VVe8LfGdEkdNbfswdMDfX4oUiI6JnAFDD5erHz2NBYSTdNkKg+gaEPrjgYc/dZmZdFDx7lr+g785AHFKUtiij9b6kQSwa7P9zLnlzqjqNTU6xi74pQAWcF+NiqJDmGTxP+CoKaMFarvucH0Wk7dqDJYorGeZBhAHJ5/wV8YZdyLjaL5IrbwJ7Wx5j8MgX/FND9nfz0y9fYu/tPiFael3hlwr7S0pJBx4Tq//Wqp7YRI13XFHBNAKN0KaA862GRuSr4Whhpb1T80/83T3Q37cB7ZMp5AQqAjelFN9tAgBuvemvlVQTesFjTBmBxxO2Eq7pHko2MFctQBiaK7UaWjrtAoCLXLqJZx8T9Hbq4Q6Bx176TvMzKDQkkTo8jZXiN6WmFpa4JasLb5gI5lAG+TKAe/injSSVYc28KU0hkXvVd8wmwJMiLFdwdCHr7mRPmamhcDvVEKrZkyI6dzF/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZUKzZjczhSSi94dDY2VXc1clNucmZnd1ZqTGRCOVF2YUN0RXkrL1hYTzFp?=
 =?utf-8?B?Sk54RFRlNVFVeS83MnlKR0ZYOS9ZaHpqYzZpdXp5Z2pJMm9KVE1uUHZMMExT?=
 =?utf-8?B?M3hWdm1IVE9obWwvQzVKc29wZXZ3Q2kwZEFCYzNxYkVEZG50aHc4M3UvN2Rs?=
 =?utf-8?B?a3lYQkx2cGZMMUZlZFdiaFZ0V0djUi85VGttdDhNaS9tSWY5VFZiYnBqMjd1?=
 =?utf-8?B?UEp5ZEpKdjRwbEVFSm5JWWszZXErUk9sd1hHNVlLTDVwanhZM0V0YXJaazVO?=
 =?utf-8?B?WHovQXFvWms2dGtKeGZzYnp2V0N1emUwOXdDa2JHaUdOdUJkYWt5ZnhzY1Zw?=
 =?utf-8?B?b1h4bytaRnBHVjNxTDh0SnJqSkhsVDN0aENIS0ZUbFRWczM3ajNBemNYZ2Nr?=
 =?utf-8?B?MzhZdllaRzFoZVQxYi9EWlFrU1lsWHFlVGduUCtQM1hyenREQVhmcVZOMmdN?=
 =?utf-8?B?ay83Vlo1M1VjT2hOQnlETTFhVG41SWhvVXJCaUhLZGJyZ0dSWWJkSmRKWlA3?=
 =?utf-8?B?NVhWcTd3Y0Z1ZDZpNk1mZzF0dGY0akg1WWtmMVlmTEtIR0hua1FsYUVNaHVR?=
 =?utf-8?B?d1RUcTBpZzJib0FBZmV6akxhSGFGOGM2VmJobkFXSm1tdE5URmljRmFyMUlh?=
 =?utf-8?B?VjcraDJnTmEyQ3BSd3cxWUtuT0trQzgwYjdtd21BWHowaTVjOXBPTFo5NVpV?=
 =?utf-8?B?NHZIcXdCWTViaUkvbFRsdTR4SVpROS83U1F3dXI2Nld0cEdpbG5qRHcyY1Fv?=
 =?utf-8?B?b29jRWxJNTU2ZnVpZFpsdGcxQWhzMGhWR2NOQ3AvbWtoUlhkMm1DdXFWLzRj?=
 =?utf-8?B?TndxVzc4L2FWY01aV3hpenFTSXcyUEFXZm80enkreDErRmNjUWxibUpZZFVx?=
 =?utf-8?B?N01XSW92b3NWQ2h4SEp6cllsNVVWMmkwbEhpUlhLbjZMbyszUUx6bEF5UDFW?=
 =?utf-8?B?YW1tTVFSelByWmVPVlR4d2ZBTDd2bmMvMDcrZVFILzF6OE5paThxOWwyNkxP?=
 =?utf-8?B?Zkd5Mm5zbXRLV3h3MjVWYk04cFNKc0RTSEMveHhIeTNMem0rYmlLc0lqVGNy?=
 =?utf-8?B?VUhYL3d4ZXVFV0toV3UwOGJXMEg3QVlPRG1USW4wcE1ZNGt1U2lMQXdsMkJE?=
 =?utf-8?B?RmhhdnExNkJWTy9VQ3JlUkY5ZmswZW50eVcxSTZJMFZoUXkvaGF1VGRjTmlT?=
 =?utf-8?B?QXBoaEEwamJHZEd5TjJtZmxEdkpWb2xOMlVBNHNpRUFtMzFBTXhaVHM4QXNn?=
 =?utf-8?B?TGZwNG04WmpYMzNnS3JTVmxTMm9sQzJoeXFuQlpGSHJ3Mml3RFhlbllkbHpt?=
 =?utf-8?B?UEJOK3N2RG5RQXBBQ0Y2Z3paTUtkbmp0bHg4NWplT3h6SWpoSUtzQlFsbjcx?=
 =?utf-8?B?V3VQYlZPZU1jMkNtMXZNWVYxeDNOTUV0dExJZmNIV20yTkZLenlYNThVTnQ1?=
 =?utf-8?B?SWYzc0VXVmFyWDFMR08xZlA2NTY1ZXQzMTRjSGNkUFpURHFoWlFHclZ1a1p1?=
 =?utf-8?B?UE1jZTZzQUdyOFh6TWpHWWdNVTRPVEJSQjdKU1oyT3RsdVFTa0M3Ykh3Q0la?=
 =?utf-8?B?M29BR1hXdXRSYTJhOVp6QWdxVGwvcUkweEdmZ084ZEpNUmhxMitzcm0vNlRD?=
 =?utf-8?B?MzZ0c20xcjBKazRnSS9oRy8xVk0zaGxQZUxTRTNpdW94eDlvREs2UXF5L1NF?=
 =?utf-8?B?MDBsWVhhOFBUNnZ4QTQ3ekJtczNVMXpKVUJBVzFQKzhpMi9ydjZRRkVheSsr?=
 =?utf-8?B?TjdESGo1Nk1CYncvSFE5enkreUxGU2EwN2xyZHJVc0xNNEt3c1JWclZtSnUv?=
 =?utf-8?B?d21hM3RUejNvM05BamtPQmNtR093THZDdzVtcFp1b2lya0d2ZXJtRmRadUJr?=
 =?utf-8?B?T1JSc2hnS3NmSklkTEJiWDFFMHJGMEtkNmdOdlduNDRJcjk2THlIU2NmQnVw?=
 =?utf-8?B?Z256bzBWUDRKQzQ2Q3Z6NlhRV1VGVmMzV3U5L2U4VURtVjF6MTB2cWRnNGlM?=
 =?utf-8?B?QVlibXN3ZUlHSVZxVjdtVU85TTg3QkhEQTg5eXAwbmdZOEUzTkwvWXZEOFQ2?=
 =?utf-8?B?ckpNWnFkd05EajJnaUhLREl6Z2ZpY0NjNEVVS0U2MysrblY0VW5jaFp3NXBZ?=
 =?utf-8?B?THcrY2FhcFhlcnF1MUJHNnRmTTBudnlWOXU1RFV3Qk5qRjdvRmtCWTdlWkNU?=
 =?utf-8?B?Z2xDQ0xZejVnR3BEdTB4dHJkaVl1djQxcDJuUitkY1FRNGEzMkJkNXJKRWFL?=
 =?utf-8?B?VHUwZ1hIQmM2czFjUHJpWFp3ZlBHY3pqYnJ0ZXhydFIza0xKL3dEV1NvL2dF?=
 =?utf-8?B?b1Y1N3VRSGVtdTJyZFU1OW9ZNFhiVTdHSUpwVE1OamFReXF2UmFUUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a5df8a-587c-407d-9fb2-08deaad3ba56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 18:25:47.7459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsdwEPvVloBfhMJ5GmO2jFzcMb+ksNvznI2ltYAiWlBc1wdTEbSm1FgqTiD8BDVdMLsbVztZiyjnFxTCvMpzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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



On 5/2/2026 11:41 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> Refactor the GSP boot function to return GetGspStaticInfoReply.
>>
>> This enables access required for memory management initialization to:
>> - bar1_pde_base: BAR1 page directory base.
>> - bar2_pde_base: BAR2 page directory base.
>> - usable memory regions in video memory.
>>
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>> Cc: Nikola Djukic <ndjukic@nvidia.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs      |  8 ++++++--
>>  drivers/gpu/nova-core/gsp/boot.rs | 12 ++++++++----
>>  2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 0f6fe9a1b955..f2a8915a1ff4 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -21,7 +21,10 @@
>>      },
>>      fb::SysmemFlush,
>>      gfw,
>> -    gsp::Gsp,
>> +    gsp::{
>> +        commands::GetGspStaticInfoReply,
>> +        Gsp, //
>> +    },
>>      regs,
>>  };
>>  
>> @@ -238,6 +241,7 @@ pub(crate) struct Gpu {
>>      /// GSP runtime data. Temporarily an empty placeholder.
>>      #[pin]
>>      gsp: Gsp,
>> +    gsp_static_info: GetGspStaticInfoReply,
> 
> A short doccomment would be nice, but otherwise this looks good.

I had added one before, but John suggested to drop it. I could add it back again
if all agree on what we want to do. I am Ok with either though I'd lean more to
the fact that its not necessary since it will basically read like the variable.

thanks.

