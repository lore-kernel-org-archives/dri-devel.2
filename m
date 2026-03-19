Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1101090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0400610E8F1;
	Thu, 19 Mar 2026 14:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqQMfoLg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A026210E8F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTTdfmiNCoj+nngrQ5xlfVI8jQiZZhUWQOO8bY1UI7cIbhpX7xrQ5wqaw+MQBNtD8Sk1SanGMltD/Lxk+R1J2a+VJEraLDIz+HZyGx03176HgsRnqAo4/G/ajDKy4krGQmNXga2lBMFdiAo5kLGhspNGoh44PVoj+qnewoYQOKCgz8rS8L6CTfS4BPkQ7rfcNy5c0cNE6GLbknTnNbAWSswv19SBJnz68M1UAmKGPjxUnNsmPWmCI6qaa8mS5OEIJwHQB0XsZD/f9zadktONJ++KWYdRZMn3dL1DIT2BfhyPMEBNhCUFLrlOzw7IJ9R/sz5Sg7NJKNJ6ISkjPoC/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcXuPw55uQYatuAqOyDwBDCr6ctEA6psFUah4HFKnM0=;
 b=pHQPGkqmBlYVEItY8aUKzaeR2GP//uzrvZeVWqgoTlDsDk7zje5WbgjLPGoMk3a32+fge6PL8amxIA6sbaD4PdGsezY2BrQL5Y1En/Hyd2dyLZ+n58vQmjO7qqBKieMzHy+efWlvN1kvsBvVYI0mqLJ9Kd2ct6iVXoBL1WRjeuz38fnrQQxoCf8cRegp/2kOO8lzvG7Lp2bvFZvSmzdNo7vnUbcJLcTlqn86JuG1MtkrEow6bo8pfx9OEoLXPPdAOp5gol9iJwYSHU5Sl2tZ8ghVZTAtq+YLxyXDsk7DOO2uT7xPufrfcCTnoOjDCRIrambUsz/cZ+83OZos0EgnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcXuPw55uQYatuAqOyDwBDCr6ctEA6psFUah4HFKnM0=;
 b=XqQMfoLgRODSTq+gFkTyuRT3+EVnbyr2+mJ/5CXe1wrS1PkznNvATzoPy0o6zEOMRxBR6SMUSYNs22DvQWruDNYVjd0Va8XtA+LvEUJRWQEpKYuUOdokXYtaAijYhjNK2oIk7SerBAKYpL9d8UAT7cW36pgm3UOpgM7pzwUr3UM2mJrfbrdA47Sib1VYeU+roqACCCmkBKEMNzQWVBfrFutEt87q8SL3uNrtqYutlwAfrXH6y4nvJjvSBdTWbcp9pqyZKDSKWfk9+KfMhUNSgItrje5cqG+Jv47U9tOYgsua5cH3YICh8tNXgmylsepGbC5XtYf1YhWcnGm8eySepQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 14:39:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 14:39:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 23:39:13 +0900
Message-Id: <DH6U41MJ3T56.2L7AY1VDW57RS@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/8] gpu: nova-core: convert PMC registers to kernel
 register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Jesung Yang" <y.j3ms.n@gmail.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-1-22a358aa4c63@nvidia.com>
 <DH5XZP4LPOXG.XL69OTK91FIX@garyguo.net>
In-Reply-To: <DH5XZP4LPOXG.XL69OTK91FIX@garyguo.net>
X-ClientProxiedBy: OSTPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:604:220::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d42f98-5cc8-4025-baa9-08de85c54c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1OuvJsu59NX7b3yb/9LulyR7pdAJXTMZm/g59T2J2R3Ffh9+GnVQ1eQQ0eCs2FxASQthRUPsTTx2UHzsxzejlMj7edNmD6RpbvlaOduTiAIJmi6Tyxf1gyqhO3PiCzLEY6B6s413fg0jBv95L7dLsmi9qXGX0HJJMTsanFMp8+fPbEM73DRb36yo86vjDvlUu/MwxsDpFGd7s+XcWGhqikYkuHH4S/oZo4sZfbs6vGGa94nMsQK/RdJpUS9a+gMA6UzTSy9N7B6VOCdHJbUoMOYp2YGIRgQXcOkLkx95SCX41cDe3SOs2NBIOO2L3/5ndErpQCW61Agy/7TAbF0a9QBj6THFuGKODyZ5UsiDPy5xzAvZ3Awyhfp2oxCgGWrJtzthLveWYqRu1vP+a0D0Nx8JXG7qgj+x+8e4frM6nD0wtwp1uuWGnYVc1IZdC53GAnngxsZMxwAls+gLzl68jPC3F/1tpDP63SAko8NELOXgStC3R3SWq0qE34zDxdur/hDSFuyEOx1VFTlhrnDCKT+AJ3a/eIchurEulscqCGybMiGg6nlAT0YX9YE41uxjI4FddgwG8yyIcHvxNP5Uzv0wcWuuei/Gde7662O8FLpnydEpJVLCO/pC+Eg6rUjYzbbUCBl8Y9s8NFmSj/pzUZFnRVZi+63ie1yFT/0MsEIsWaRSeR7/iZZQD5cnR9EZ44kwkF5AsCslltnMJhW7Crf7e7qUOyHeYT12Fyh+xvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1OL29uUGRlaWlFb0w1aFR5TkV0Wm8rS3Npc0ZHVlUwaExHTC9kWmdsemdO?=
 =?utf-8?B?T0hFUi8xTnRSSVlLcVlnMGZ0WTZOZlRIQzZ3Vnl6ZVR3WTQ2YXQ5M1lMVURS?=
 =?utf-8?B?M3hzUE5NR1h4N0hWM2ZSTjVNLzVMbHZqT1VPWThTTGhtN1k5cC9IRjBwTHdZ?=
 =?utf-8?B?NnJzNHdydGppU3I5NXVMZVFYSHFpVG44MjJXL1NDcThwOERGdkFyMC9VSFRp?=
 =?utf-8?B?VHB3QzYyNWZMWnFJM1dZQTR0bVZCSUdnODRlbUFtaVhqZ3hPQWtPVmUrZnNZ?=
 =?utf-8?B?T1dNcmphSDhXUFZKUEN3dk5KZ2h3bDhWanhnMjk2aU43MDl1Slc2L0tXTGc0?=
 =?utf-8?B?enUyNktEQm1VRmtkR3FGUHpsb05oSVY1ODRGMU8wQ2ZCazhyeVkzZlFmQ05B?=
 =?utf-8?B?U2RLOFBvOU0xSUVGTnlZREZubzBPOTY1TzhjdWY0RmtoWkNaSlVtQ2Y5akF4?=
 =?utf-8?B?ZG1KMlFOeUN0RE5weEc1R2MzUnhDT3MzM1VHZ0wxZ0NEcW5URVBhdTBoVXlN?=
 =?utf-8?B?REFCeksyd0ZrZ3N0TlJjRFVyZDVpTzhQeDBWSnRGdWhXcy9uM05DVG43SXIv?=
 =?utf-8?B?cDIraW1HZGRUZ0svQnRYQ1JNa3RQeFFCK0JteFltdUhBZ0VwQTFMdmlQUDNK?=
 =?utf-8?B?UVVRSnlVYllNMEZBaVlBT3NDL08vRHhQNHdTSDBHRmxjUDRld2dKS0FXUzQx?=
 =?utf-8?B?Ky9PVkNyM0h0UE5VSVE0MVhRUXJKc1BQM1dPV2dtM29RdE5CQ1NQSUxKSVdq?=
 =?utf-8?B?d21WQzhVY2xORjJGWXo0RlE4WXc0RHZKNDRzZGVTbEpxQkZWZHhrb3FyZ0pG?=
 =?utf-8?B?UTI0eWlQYTVVNmd5NmZzaEpxRDdoTnhOWW9tVVVxWXlVMldmS2xOYWFIbEtG?=
 =?utf-8?B?Um9IcncvcXEzbzFsN1RmZi9aeDQwZm9QS1FBa3VwdHZQU2dSRlFDTlUyY21I?=
 =?utf-8?B?OGNwbVNEcXQwOHRWbTE5ZTJ5cGgvRTBpVkUvMGhWSTZXRGQ5SVpTakZoQlpJ?=
 =?utf-8?B?c1RFYjhWNy9MaDJscXlBZjZJUzlmbE1yMzc1aG5EbDQyTEl0RWFrelNWeWNz?=
 =?utf-8?B?Ymx2WjNqTVh6M3BOUjMzVWVib3RYdnZkeG5heDZNdURZN2NubFRIdm5xVkYz?=
 =?utf-8?B?WDlZdnZBcmFqVEZCR0JzQ045TGNEb1p3b0Jna3N0bm5HTjRLVmdXL0VaSEtE?=
 =?utf-8?B?ZmFqTmxlT0JRa3hmUE4wWHg1MHpsOXV3NWUrVURCVU5ZY1BaUlpSRVlOaCtJ?=
 =?utf-8?B?QWxqMDZveFI1elUvWjJRbUZ4aDhjT1RGUkxQV3hRYnMyT0J2cWdGTGp4REYr?=
 =?utf-8?B?c2dJRXA2b2FjN1RZUWJlOHp0aTUwUjVTSHFHWG9KeWplSjZ5TWdFQ3NpSVVN?=
 =?utf-8?B?ZnUxSklrSmptZmsvaExDNWZZMW54WUpaVS96MWJBZ1RqOWhkWTBIaDBzTU5Y?=
 =?utf-8?B?eEhFbU1QSkMrSjJ3OVdZbE1tMUhncFN6ZnFFOXVhMUdZcGxoZ2M1eFdRdnNs?=
 =?utf-8?B?MGNrZkNWQTgwMENOOHZPRVhyZlNiQ00wbWc0UiszTlRHMFhJNlVKa2J3R05S?=
 =?utf-8?B?M1R1SmZCSTdwMTYzWFp2RnJOYkVlOWpnMEN1NUhCWkFLaUNhV1dER0svY2Vu?=
 =?utf-8?B?VDViVmd3dnFESllZL3I3MmprOU16Tjd6MHFVcTd3YlFLdE9UU3dvMmgrQWll?=
 =?utf-8?B?SVlPNlVNSG5pdytiZVhKdDRoV2E2OVlFR3RvTnZZdFJZbXlUMmhqVXNPalNS?=
 =?utf-8?B?Qnl1N0J0Z0x2Z2dsUHN3U1hJS0FsdDNXeTNFWmUzOHp0bGQ5Rm9pZDJXQUZx?=
 =?utf-8?B?S3RseFYxTWY4KzVzOUFkZzRBcGZFSE55M252cEhBTUsyOVY0bDNwRTQyU2hL?=
 =?utf-8?B?bDI3QU9uUk1odUFUd3VPSVhWNnlWQ0VKMkt4dE1QWjgzZTVCYkJPcVhBd0lx?=
 =?utf-8?B?TDg5R09XbjZOby9JcHFoOVQ1dHFWdkE1azQwV0hnRTNqY0QwZW5TMngxU2Fi?=
 =?utf-8?B?V3poK1Z3aHlpTGwwS2lGQ3NVWkRjalUyMXh1UnhKUU9iTkxTUkZ6Rkt0TGJW?=
 =?utf-8?B?MFN5bktIMVAzQmxEL3NvT0swRDJZTkk1NmZVTGpEQzFKQkdYOEw4emVIbWdl?=
 =?utf-8?B?VGhCdEJRV1RNRm56c1AxSDdsN0FCWjJXZmcxUEtQNlpjN2Y2YmQycGZUSWcx?=
 =?utf-8?B?aEI0Y2NtS1FseEVndk55L2o3WWE1Q213bWt6T0JYRm9mNTJxaDJUbzF1Ullz?=
 =?utf-8?B?cDQyaHpUeTRTRURSQnd1SmNrNE5OeTZ6NUpNSUVsOW9uTm5nZTN3L1VQMDFv?=
 =?utf-8?B?bGoySWxLdlVBOTZqL2JROSt5YUNxYkhYY3RUWlpXOE9sTjJTdmV5OEI5UmNM?=
 =?utf-8?Q?1Hs7k6KNeCgoQpKpn9OQ9k0VT2+MC44tnNiJQ3cSz4kFA?=
X-MS-Exchange-AntiSpam-MessageData-1: 3Dfp5YL8CS8zQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d42f98-5cc8-4025-baa9-08de85c54c66
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:39:17.1720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSRE4yngT79drDbvG/EjHQ4UHDOrMUXIr+41LwDLgyuiMMvr5UnRF92Tm2k9ubnjdjgp3YkcHZLjXUpDurEhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
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

On Wed Mar 18, 2026 at 10:28 PM JST, Gary Guo wrote:
> On Wed Mar 18, 2026 at 8:05 AM GMT, Alexandre Courbot wrote:
>> Convert all PMC registers to use the kernel's register macro and update
>> the code accordingly.
>>
>> nova-core's registers have some constant properties (like a 32-bit size
>> and a crate visibility), so introduce the `nv_reg` macro to shorten
>> their declaration.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon.rs |  7 ++--
>>  drivers/gpu/nova-core/gpu.rs    | 37 ++++++++++-----------
>>  drivers/gpu/nova-core/regs.rs   | 73 +++++++++++++++++++++++++++++++---=
-------
>>  3 files changed, 78 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fal=
con.rs
>> index 7097a206ec3c..4721865f59d9 100644
>> --- a/drivers/gpu/nova-core/falcon.rs
>> +++ b/drivers/gpu/nova-core/falcon.rs
>> @@ -13,7 +13,10 @@
>>          DmaAddress,
>>          DmaMask, //
>>      },
>> -    io::poll::read_poll_timeout,
>> +    io::{
>> +        poll::read_poll_timeout, //
>> +        Io,
>> +    },
>>      prelude::*,
>>      sync::aref::ARef,
>>      time::Delta,
>> @@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>> =20
>>          regs::NV_PFALCON_FALCON_RM::default()
>> -            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
>> +            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>              .write(bar, &E::ID);
>> =20
>>          Ok(())
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 8579d632e717..d81abc7de3d7 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -4,6 +4,8 @@
>>      device,
>>      devres::Devres,
>>      fmt,
>> +    io::Io,
>> +    num::Bounded,
>>      pci,
>>      prelude::*,
>>      sync::Arc, //
>> @@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::=
Result {
>>  }
>> =20
>>  /// Enum representation of the GPU generation.
>> -///
>> -/// TODO: remove the `Default` trait implementation, and the `#[default=
]`
>> -/// attribute, once the register!() macro (which creates Architecture i=
tems) no
>> -/// longer requires it for read-only fields.
>> -#[derive(fmt::Debug, Default, Copy, Clone)]
>> -#[repr(u8)]
>> +#[derive(fmt::Debug, Copy, Clone)]
>>  pub(crate) enum Architecture {
>> -    #[default]
>>      Turing =3D 0x16,
>>      Ampere =3D 0x17,
>>      Ada =3D 0x19,
>>  }
>> =20
>> -impl TryFrom<u8> for Architecture {
>> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>>      type Error =3D Error;
>> =20
>> -    fn try_from(value: u8) -> Result<Self> {
>> -        match value {
>> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
>> +        match u8::from(value) {
>>              0x16 =3D> Ok(Self::Turing),
>>              0x17 =3D> Ok(Self::Ampere),
>>              0x19 =3D> Ok(Self::Ada),
>> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>>      }
>>  }
>> =20
>> -impl From<Architecture> for u8 {
>> +impl From<Architecture> for Bounded<u32, 6> {
>>      fn from(value: Architecture) -> Self {
>> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always l=
ossless.
>> -        value as u8
>> +        match value {
>> +            Architecture::Turing =3D> Bounded::<u32, 6>::new::<0x16>(),
>> +            Architecture::Ampere =3D> Bounded::<u32, 6>::new::<0x17>(),
>> +            Architecture::Ada =3D> Bounded::<u32, 6>::new::<0x19>(),
>
> Yikes.. this looks ugly.

Very ugly. This should be replaced by the `TryFrom` and `Into` derive
macros soon enough though (adding Jesung for visibility).

Another temporary solution would be to use `Bounded::from_expr` - in
this case we can turn this into a single statement. But since it is not
strictly a case where we cannot do without it, I preferred to eschew it.

>
>> +        }
>>      }
>>  }
>> =20
>>  pub(crate) struct Revision {
>> -    major: u8,
>> -    minor: u8,
>> +    major: Bounded<u8, 4>,
>> +    minor: Bounded<u8, 4>,
>>  }
>> =20
>>  impl From<regs::NV_PMC_BOOT_42> for Revision {
>>      fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
>>          Self {
>> -            major: boot0.major_revision(),
>> -            minor: boot0.minor_revision(),
>> +            major: boot0.major_revision().cast(),
>> +            minor: boot0.minor_revision().cast(),
>>          }
>>      }
>>  }
>> @@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result=
<Spec> {
>>          //     from an earlier (pre-Fermi) era, and then using boot42 t=
o precisely identify the GPU.
>>          //     Somewhere in the Rubin timeframe, boot0 will no longer h=
ave space to add new GPU IDs.
>> =20
>> -        let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
>> +        let boot0 =3D bar.read(regs::NV_PMC_BOOT_0);
>> =20
>>          if boot0.is_older_than_fermi() {
>>              return Err(ENODEV);
>>          }
>> =20
>> -        let boot42 =3D regs::NV_PMC_BOOT_42::read(bar);
>> +        let boot42 =3D bar.read(regs::NV_PMC_BOOT_42);
>>          Spec::try_from(boot42).inspect_err(|_| {
>>              dev_err!(dev, "Unsupported chipset: {}\n", boot42);
>>          })
>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.=
rs
>> index 53f412f0ca32..62c2065e63ef 100644
>> --- a/drivers/gpu/nova-core/regs.rs
>> +++ b/drivers/gpu/nova-core/regs.rs
>> @@ -35,20 +35,64 @@
>>      num::FromSafeCast,
>>  };
>> =20
>> +// All nova-core registers are 32-bit and `pub(crate)`. Wrap the `regis=
ter!` macro to avoid
>> +// repeating this information for every register.
>> +macro_rules! nv_reg {
>> +    (
>> +        $(
>> +            $(#[$attr:meta])* $name:ident $([ $size:expr $(, stride =3D=
 $stride:expr)? ])?
>> +                $(@ $offset:literal)?
>> +                $(@ $base:ident + $base_offset:literal)?
>> +                $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alias=
_idx:expr])? )?
>> +            $(, $comment:literal)? { $($fields:tt)* }
>> +        )*
>> +    )=3D> {
>> +        $(
>> +        ::kernel::io::register!(
>> +            @reg $(#[$attr])* pub(crate) $name(u32) $([$size $(, stride=
 =3D $stride)?])?
>> +                $(@ $offset)?
>> +                $(@ $base + $base_offset)?
>> +                $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?
>> +            $(, $comment)? { $($fields)* }
>> +        );
>> +        )*
>> +    };
>> +}
>> +
>>  // PMC
>> =20
>> -register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about=
 the GPU" {
>> -    3:0     minor_revision as u8, "Minor revision of the chip";
>> -    7:4     major_revision as u8, "Major revision of the chip";
>> -    8:8     architecture_1 as u8, "MSB of the architecture";
>> -    23:20   implementation as u8, "Implementation version of the archit=
ecture";
>> -    28:24   architecture_0 as u8, "Lower bits of the architecture";
>> -});
>> +nv_reg! {
>> +    /// Basic revision information about the GPU.
>> +    NV_PMC_BOOT_0 @ 0x00000000 {
>> +        /// Minor revision of the chip.
>> +        3:0     minor_revision;
>> +        /// Major revision of the chip.
>> +        7:4     major_revision;
>> +        /// MSB of the architecture.
>> +        8:8     architecture_1;
>> +        /// Implementation version of the architecture.
>> +        23:20   implementation;
>> +        /// Lower bits of the architecture.
>> +        28:24   architecture_0;
>> +    }
>> +
>> +    /// Extended architecture information.
>> +    NV_PMC_BOOT_42 @ 0x00000a00 {
>> +        /// Minor revision of the chip.
>> +        15:12   minor_revision;
>> +        /// Major revision of the chip.
>> +        19:16   major_revision;
>> +        /// Implementation version of the architecture.
>> +        23:20   implementation;
>> +        /// Architecture value.
>> +        29:24   architecture ?=3D> Architecture;
>> +    }
>> +}
>> =20
>>  impl NV_PMC_BOOT_0 {
>>      pub(crate) fn is_older_than_fermi(self) -> bool {
>>          // From https://github.com/NVIDIA/open-gpu-doc/tree/master/manu=
als :
>> -        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u8 =3D 0xc;
>> +        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u32 =3D 0xc;
>> =20
>>          // Older chips left arch1 zeroed out. That, combined with an ar=
ch0 value that is less than
>>          // GF100, means "older than Fermi".
>> @@ -56,13 +100,6 @@ pub(crate) fn is_older_than_fermi(self) -> bool {
>>      }
>>  }
>> =20
>> -register!(NV_PMC_BOOT_42 @ 0x00000a00, "Extended architecture informati=
on" {
>> -    15:12   minor_revision as u8, "Minor revision of the chip";
>> -    19:16   major_revision as u8, "Major revision of the chip";
>> -    23:20   implementation as u8, "Implementation version of the archit=
ecture";
>> -    29:24   architecture as u8 ?=3D> Architecture, "Architecture value"=
;
>> -});
>> -
>>  impl NV_PMC_BOOT_42 {
>>      /// Combines `architecture` and `implementation` to obtain a code u=
nique to the chipset.
>>      pub(crate) fn chipset(self) -> Result<Chipset> {
>> @@ -76,8 +113,8 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
>> =20
>>      /// Returns the raw architecture value from the register.
>>      fn architecture_raw(self) -> u8 {
>> -        ((self.0 >> Self::ARCHITECTURE_RANGE.start()) & ((1 << Self::AR=
CHITECTURE_RANGE.len()) - 1))
>> -            as u8
>> +        ((self.inner >> Self::ARCHITECTURE_RANGE.start())
>
> This should be using `self.into_raw()` rather than accessing the `inner` =
field
> directly (which should be considered impl detail of the macro).

Indeed - done.
