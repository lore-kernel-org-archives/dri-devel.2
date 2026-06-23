Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC24ECD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466C88A3E;
	Tue, 23 Jun 2026 06:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7atbURm";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F10910E963
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMnsHNa4NWfLPUg037iOJUGAtCIOwA/rAc1HXCvPmnvNJs/M3ewwNx2QHL/Br9hyXk+dKNFuAacdPuBG1cN+7y0y7ZYoBuDQDwuyRKHVNC5vtuWI6QUiagTJig5H1YCCxhHFDPZPjI4l1ujddBHfyAjCNsQ9Nw1ZJgNIVjY6uWnQ/DfzQwAwsRlVvqgwHoWbmcUE95LAbEPYVDodyjioYZWBdgjbLVQyyEKqjX3WGg3dUuXh8j4qUHX559CbusVMRPeDYecEGfSQncNCuzBkRi+G03RRQIDW/KsiF13hdLejJodELjbCpr5x7Uspu+SsHI6EOoQtw6Dhyt9f4jRj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsS2HcAyzNaNxXYo2Uf9rNZnIz7iRe0uGsxWO9T/rYk=;
 b=e8UngzNiPiEA04a85X03X9kf8TXSGhHYR6MMzBtQcyjPg1pzmDz1NzwfxJyEhw0pueX0qlMcSSOdbutz6DU9QgNAJWSJ3bsHxScuFoabazuMjww0l6zu1JnnG35vbcvbcnD2u8iaxUJCKr7wW63zW1UvRQHEmVDenukbQ8/JxbNI5VYQBHVmZCARPOEocBx8GEMm8rqYyRZETuwk+kG1WUlPnkWRfL1yrp1+vyVK9qGWyZvX4eGyia1GcVVaAM9/2qZ+0wjI1+V+MCsHLq5XKhf7/0xd35weUC4MYfz3pyhulWNpOdZOdNSftRJYKVIe/k1JqDWjiWbzW/9zH6Bjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsS2HcAyzNaNxXYo2Uf9rNZnIz7iRe0uGsxWO9T/rYk=;
 b=A7atbURmO3pPXa9RqgwzO2eF5seBiN+Eao7ySYXOhZcFnJ01oYPI3jfTmnjfs375pXas/5cbL85VIAu+hEH38NKMEkBPAASoHMRAWX66A406tkWkV617uljUGPAbzs28yUUj+D2Ux3nQDw79f1+wOZATMEL6VrBxTTmmWu/DcIxb1RDipW3JpmXoDEsb3M8BfPunsQMTnpgQUZiroYeUTLlSGQYcby/jRgPKpqRYo+nCGXQvys0qDhDhnuQ1aTbP8IQVjgjlY+Pm+XJ/xGpk2/2yVzSUaEduelZmolv7tRXp4237YZ5ibCHHj2Tf5LQoza5V9gbXyKDV2FjIx+ppPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 06:19:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:19:02 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 15:18:58 +0900
Message-Id: <DJG7LBVUQ0FA.2G12DPFA5RWQT@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH 2/5] gpu: nova-core: gsp: Move PBUS register definition
Content-Transfer-Encoding: quoted-printable
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
 <20260617-nova-core-regs-split-v1-2-4c7dc4450ea7@nanonej.com>
In-Reply-To: <20260617-nova-core-regs-split-v1-2-4c7dc4450ea7@nanonej.com>
X-ClientProxiedBy: OS0PR01CA0151.jpnprd01.prod.outlook.com
 (2603:1096:604:27::26) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd31b18-d8d9-4a19-74ec-08ded0ef5208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|23010399003|1800799024|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IP+f3dkwWpT7MjNaB6Ri1xps8o0mQbgDZ/ZeYmwDvljJuYetXvEZcSAOQfulC1Z4CAudRlRKopLF2wySZ01cRxAt6sTYxTkt+SOpiPLYNleo9dfAq99IKjGa9o4l0nXdaupVeZWb+BH+j+g1fjxp9U/gZf6GddeIGjyMzAu2S/a4R4CkRsBbTNmzSQtx98Eh8G8MOf41qNgvsj+jzpKRhsh7veu/UzSP4+SVS9MrEAME3Ptji3mEvQuKwpIeglZXCt6j+YT2I7XAjjZQMFDetsBpYwm02Mk/hkozzo3st7Bkhfa0k0d8cDe3KqPe7YfljJTBqxcS6q7Bxt0YY8sjHakjHsBpplpd/Dqvj7lTPHEhSxhPkvCsUTo7Phmucgkcj0G1E8/0czXoDZdP3t+JIuwYngt+yD5Barr58AWzkVvs2tWM2MZDMwOS0VTNFAJKxb6kPPN8xE3HeOSdU+NEGEPx0BVMZWBS8jKEG/UMWs68jfdkCBC30YcwYVYIjCIXLuv7ePCAj0To8zdb+Zhs4gch04K3F0M5uVGoF+Q2rUfb0e/BxzVJqbNxi8YYdmj/dgLyiNs3WbHR0pYzl5neFm/+xhW0IFdlX07Uv+9s8+APoRB/fVxEg80zxQfCueKkh7aibT4YW1LVEAtWePfzoQXEWEW+oWa9/6JE5xub4eo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hKK1VlUjJteEFMQ3ppSEljOGVhR0MzTTJUU3duV2VreW5RdExJMERLUWFs?=
 =?utf-8?B?eFZTcTRvRzd3aEsxRHV5TERkejBSN3dBbVdHWXZyWG5MN0JmbllQTjY1dlgx?=
 =?utf-8?B?T2thQ3hnUEY3bldwcDZvQ0tNcmt2dmdyc3dNVitPZlg2V1hDbTFBaDRZR0hV?=
 =?utf-8?B?RjZTeWFQczBLYXhZdVd3TXI2YkdjeUpFUVVqZ1pTUEN0bkdnMDByRk15eWZZ?=
 =?utf-8?B?NnJCZitneWI3eXl3Y0c5amJsaDVacUZuNHVmN1QyLzB2TkZQUnZoZzRFWTRt?=
 =?utf-8?B?T3hVNWtTa3lSWm9xU0QxS1F6YVkwVXRzSTdPeGFlUldMQ1I2NnFXMy9yUzZh?=
 =?utf-8?B?ajBVcG9TMElRbGxWbUQwcHFGdGtXQ3pMTThQVjRnQjJaRXg0Y3owaGRwT2ps?=
 =?utf-8?B?R05Jb242QklCU2lxQ0FkYUI1T2RjNnZ6ek42NytTZmp4S0NRNlNIeURaWDZ1?=
 =?utf-8?B?dHh1ODA5Qmt6OE1Ed0Q5aHhsVHJhTmJJWmV5cG5WZGQ5d3U0ZTQyN210K1kw?=
 =?utf-8?B?L3N6V0U5N09KZjhOcFlwRDJJVTlUZFpaZzQ3TzBORVVQRC85NkwrOWZuaUhJ?=
 =?utf-8?B?OWoxQy9TZUcyVmM0QkRlRm9BV0p2WFdMN2lVbnhac0hkMVVLNE5rbUFZdC9q?=
 =?utf-8?B?Q2kyUVUwelZibG5KN0JPWFNjVnZRSlErb25YS2tRM2EwaW1ZbCtDcnpJOVA1?=
 =?utf-8?B?d29WWWIvVTFOSStpemFMY0kxaDZqcUZJNUU3aHNjcDFUY2RlKzNOWitpVnZu?=
 =?utf-8?B?ekw4L0l0ODU4SHFSbUhzMktGbVEydTA1ZzdZWHVRVFpWalZjR3ppWXNMRUx6?=
 =?utf-8?B?N3N3Sm5EUHNFbzlNb1ZSMUFudlIydFRVWHBZU2YxZHovODR5c3p4L05hZCtq?=
 =?utf-8?B?WUJtTEVlYzU1dXpkdUpmVWViYVRDQk90aEFRQ0FoZ3ZBVjZEU3YrYTl2cU9C?=
 =?utf-8?B?WFBYdHFQNWJGcjBLRXVmaVZwRnN2YXBIRHpkQmhreC9LYTg4UTdQbXJpa2lT?=
 =?utf-8?B?N0tyTWVWQkxoUlJjcVloc0NUd1dJczB1N0w4emtPTG5HcXJFU1dyZndQYjY2?=
 =?utf-8?B?NU5oSVdNQUllZW0ranBzTFh2ZklYaDdzSjJSTTFkeXpyQnUyY1BEZnd3V3lO?=
 =?utf-8?B?V0RnS0E0S0p6WmV4WDFNdGd3TExQN0xFY2YyeDNDOWRSd2hSMGRTd3RFZnpZ?=
 =?utf-8?B?ekE2eE1aMEYrWDd5cXo0YnYrdnF4bGRqenE1MHVsRmRvaXM3WDRxNDBpcXRV?=
 =?utf-8?B?OGpuOExteTJNcDY0TnNRK3d1Rk40VCtTK1lBMG1HVzY1YzdHME1manN3MEVZ?=
 =?utf-8?B?OXZBUHEwdnM4SWZvTEVROWpWVDRiQkx3YUZ6YW53Qm1DWFpmZTVtc2R4Miti?=
 =?utf-8?B?aFlBWjZLeHBpMDFIUzlqcUd4T1NINWw0TGRFK2U0V2FpWTMyTncrdFhYYndI?=
 =?utf-8?B?RmhNNGRmcFhWNXBaQ0dYWFYrYm5KdXYvRlVCdWJaR3lIK0dLcldEZ0x2ZjJh?=
 =?utf-8?B?VTRrYU1VUVp1aXg4WlBYbTUwNUtMSGlKRW05b1ZPUXhWc0hHWExVOGtDSXpv?=
 =?utf-8?B?YnZNY3NROUZaWWlCaVFpSERDU3V5Mi9CVzg5eHNxYTBFZks3NVJpZm1YMVBZ?=
 =?utf-8?B?Tng4OTNLWXd6Ti9UQUtHTWFUMStldW5xSHF6QWVsUUc3WmdSdytPeVNIUyto?=
 =?utf-8?B?dWFKM1U2ZW1YbEUyenp3NnBoZ1VyTHhOS25NMnV1dHlYd3M3UE16RFNOVE9y?=
 =?utf-8?B?enFLck96Nnh0ajdzMHZ5eE5NK2RTUjVZUmpYRTBPY0NqS1dFV1FGRWRaWjdX?=
 =?utf-8?B?Rk44ZTdwejhNNzh2TXdMcUcwaVRpcnMvZVE1TzlaTmdnTG1jalg2amRsbWxU?=
 =?utf-8?B?L2JlbzM5M0dxWWtFQXBRVG9WSHRRMWdkSStRbFJrc1p2TUZDcnNFMlV3aFBv?=
 =?utf-8?B?TUtmQnE0WkNkYkNrWFJxVmlzSE1nbjVzcmt5ZHYvMkZTUXVRcFlva2gvQnlN?=
 =?utf-8?B?ZVFqejBXdmxPSG5pc28yU0hHY0hSTjVzUUxlNjFUQVc1MStBTExGMTB6bm9j?=
 =?utf-8?B?TkErSEZDSlhqVC9KWjJOTG1zTk5IbVlmVzAybVZGVU9GYUUveEV2R1lkeWFS?=
 =?utf-8?B?ZWo5UDNLYWFGaGtkQzJOR0lucGJkaXJQcTVCQ2VlWUk5V0V4Ynh4QTJ1SkRM?=
 =?utf-8?B?L3IzbnZjWGdHTE1RWWhCLy9kdzNvVXQyVmU1VUhwVDRnZ3Bta3pkcWdUVVpC?=
 =?utf-8?B?MHFFUTlBKzlrOWZGMVY0UENoVGRzZEFJaWwxcHhCVlR5alNKWEtxTlkxSUlz?=
 =?utf-8?B?VjMvSHBMY0pGYTQ0ZkZEKzl2K1BWTjQzclRWQzhIVm5hblhtZlVNTVQ4Qk82?=
 =?utf-8?Q?G3toJk8fm1fB0ma3VtBLz6WwOSqhfr8VrrInsUslE8HVU?=
X-MS-Exchange-AntiSpam-MessageData-1: jMqIvs5roNl5lA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd31b18-d8d9-4a19-74ec-08ded0ef5208
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:19:02.6618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRvMKM/RzZuXW4KOjR8NzHQOvGScP70mU3NuvxivjB1dn1xB6wRrZ/ZEvpCIrXgrLc3a3av5r3pMqIbUyLvIrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662
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

On Wed Jun 17, 2026 at 8:48 AM JST, Antonin Malzieu Ridolfi via B4 Relay wr=
ote:
> From: Antonin Malzieu Ridolfi <dev@nanonej.com>
>
> Move PBUS register definition into gsp module and update registers
> visibility.
>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>

This one also didn't pass `rustfmtcheck` - please make sure to run the
checklist [1] (notably `rustfmt`) on each patch before submitting.

Some more comments below.

[1] https://rust-for-linux.com/contributing#submit-checklist-addendum

> ---
>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 12 ++++++------
>  drivers/gpu/nova-core/gsp/regs.rs      | 11 +++++++++++
>  drivers/gpu/nova-core/regs.rs          | 11 -----------
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> index eb7166148cc9..d46e8ec65785 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> @@ -37,6 +37,7 @@
>              GspHal,
>              UnloadBundle, //
>          },
> +        regs,
>          sequencer::{
>              GspSequencer,
>              GspSequencerParams, //
> @@ -44,7 +45,6 @@
>          Gsp,
>          GspFwWprMeta, //
>      },
> -    regs,
>      vbios::Vbios, //
>  };
> =20
> @@ -141,7 +141,7 @@ fn run(
>              .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}=
\n", e));
> =20
>          // Remove WPR2 region if set.
> -        let wpr2_hi =3D bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
> +        let wpr2_hi =3D bar.read(crate::regs::NV_PFB_PRI_MMU_WPR2_ADDR_H=
I);

It would be nice if we could avoid re-scoping registers that don't move,
and I think we can achieve that as part of a slightly larger series.

Notice how we are accessing `PFB` registers (`WPR2_ADDR_HI` and
`WPR_ADDR_LO`) despite being in the `gsp` module. Let's start by fixing
that.

These two registers are only ever accessed by the GSP's TU102 HAL to
check whether a WPR2 region (a memory range going between `ADDR_LO` and
`ADDR_HI`) is set and what its range is. The TU102 code manipulates
these registers directly, but we could move them to the right place if
we did that as a FB service.

There could be a function in the `fb` module that reads the registers
and returns an `Option<Range<u64>>` - `None` if `is_wpr2_set` is
`false`, or the WPR2 range otherwise. Then the GSP TU102 HAL would just
use this function instead of poking the register as it currently does.

Doing so would move the WPR2 registers to the right place, and provide the
right abstraction for the WPR2 region.

A patch series doing this could look like this:

- Add the `fb` module function abstracting the WPR2 region registers and
  use it in the GSP's TU102 HAL.
- Move the `NV_PFB_PRI_MMU_WPR2_ADDR*` registers under the `fb` module.
- Move the `NV_PBUS_SW_SCRATCH_0E_FRTS_ERR` register under the `gsp`
  module, since it is clearly themed after `FRTS`, which is part of the
  GSP boot. But, without moving `NV_PBUS_SW_SCRATCH` (the actual
  register being aliased). I expect you will hit a bug of the `register`
  macro when doing this one - I'll try to address it, but the first two
  steps should be safe to do and correct.
