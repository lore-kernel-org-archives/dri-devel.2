Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F51088E63
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A9410E7F0;
	Thu, 19 Mar 2026 02:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lPvHyaAG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E054610E7F0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrUAqk1rVuN0aRO/BhZK+ixkSQF+v16EXr2dNiOaCfx43Pgzgcz1Pr9u/DmULWAUcj1FnkiECDFGhOMZuXZHsKdskeqmUCfdz5zt1A87OlldZLNRulXeUOqwa+USwCbVG4Kz56Bw61JsQxOpAGSa8yZTrCigXFeW5zcbof9z7PtdbQKlLI+mM6O9HbwsYaJfp4lXYSduLrITbzUhV+SWo1FgKPQKdvcg2DWnc2Ju/OxqGs78TYaYe4ZSU2H/5rFKdrhRlTwKUt4mX2WNGuUGMVlufvgTKM5nLV529RPCEgIQs7wC+A5Kh1P26kcMSZbR/DwKmzRFyiTvnAKycydsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H07z5TVA9WJMh/i6pR0HiDfrUKG+IedIR48Thr55PvE=;
 b=Qa0IFbbVLPHVHDn4Ir339WtEoN/+O4quUu7wdrEoV+v7m1rJXW+Rgfi4eE1dG67mmhOsU0Hsz3fa3MkQ1I8TA+AsowFKk9h0Y4P3dralD9iuk6lbmG2OP3thBHqkajfvxWTq5cp9Tl6/vFilmRXkrEejCAw/tqCV7WkU/8lvpmaVFfg5Y47/RJjBK3zofRwH8l9QTrcJ5QNoKR/d39hgJlPdmo+798v27kIyNR/gL2Vqm+jl1V56jzgCw0UIvPZhBx5uN02rPak4ifcn4GrsAkcDQgzII/lf28TzSeXYF71uvJjzXmCaHbwIg6u4cB59FuA65/GT1NOK9CVcpmozvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H07z5TVA9WJMh/i6pR0HiDfrUKG+IedIR48Thr55PvE=;
 b=lPvHyaAG6CAIIp1E/tWC2z1iihJ6iXPtUvzkJPajSFObed5j66AcDr6U3j9MHeaCTq/zKl4hCKTS915P7CcE1zjo9zciBHTbtFjHizeysfHgMCNu+2ew+AU4D841UMZj7S/zG5s44kl+gZS6p4BSGFtgJ8qDd4BzXjXXImz9Zn6QqN8L2gBMxQ2mbep0h5GJzymMS8s15IBakVPFmiFZCcXBNudWAKQqZWCpgkiDVE01xXa1ckpup1JoFQQOXbDP+7oUSVkE+QW2f7yX13zU7/wlpMZxLrg30oh7Tgn/ok9eRnZZwa/CuG8/onCC5deX37Zqm/ZIxl6oWQxvi9R97g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:16:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:16:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:16:40 +0900
Message-Id: <DH6EBIF5HHAE.3ECC0Y8TMIG14@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/8] gpu: nova-core: convert PMC registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-1-22a358aa4c63@nvidia.com>
 <DH6DL5899CLZ.2FMG8UQSNEII7@nvidia.com>
 <DH6E45KONHJD.15LJ780SCTJPC@nvidia.com>
In-Reply-To: <DH6E45KONHJD.15LJ780SCTJPC@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0138.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 807f27b0-0522-44cd-6799-08de855d9138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3YovsSrxBA2RHKJdz3B2jSesdTrM/HT9YWJGq8R1guZ6lzCGZBLvJfn3f0LN/6gGTn1HhX8uRXJ6DLfadWBGs8w8nUvn5Wk8jIZ70pH1bp/b7H9WdxTvqm26gTR99z3NGSHZkjzBBiIs0zHjLoNck0UcV3afdoqN5Ae26G8OZvAi7qfG38dKPKNLVVb103xUKaHWWHplQiNl/JM13ZRUAj0NvQepP7/zyPHNj+HiGtDJ9hWUq5Lc2UgtduvcQxkRRkcN64cU5fFf83emI8wZRcNUkOr+vkEiitn4cXIaOrtOhe/RWvxLrpEX3+qXud/5slWaq58hOxhTjImN29JGgTx6ze8JGBYdDqxvv0Wk7EEbV8Szsk3yMWywlqNbGtlaD3pJMG63mkLC8L3Gv92KctchblBedIk3baCJbCwM5FlzUQ0nstRlWarJz/oXsSO6/fPBtb+HjAw+so+67F5szhCpOpPntD5T5eXoNIs7jybHpRhnm9a5SVZ2AWhxuoG3fdhBqUvSTojs+jfycbdD1OV9DwwIXd6VFGKPbtitFTPS4QhardM8b2IaH90Kkju9a740pofjCUqXWJjAeQuaIXoVdEWf9D//T1ND4b1yul4Brt3pmqo/HNk4DJG+DLh2VAdqsXNbICluKt/WD/lW+YuQohlqZl1eifl6wN4Ox+G9dph+W9xgR1T6emWTOcTslU8IgCNIKXXXR1uJPG6trNdPtmcaOq3fTTyicGvgfnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R204cFBMUjZqSVAxdHJDOC8weGJwckErVzlWbzgzSTlFZStwSWNFMm90cDBD?=
 =?utf-8?B?K0x3OXV3bmZ1OGx5S0ZsTTV1ZTJlMTRCbmVaOHZWc2wyZVFZNUE5QVNZa3Y2?=
 =?utf-8?B?dzcyNGJQaGgzVys5bFQwMS9wcEx4NWplUkkvdkE5TStnTUlFRmljUmF6S2E1?=
 =?utf-8?B?cllKV2JqN0dCckNKS1plYmJSMXExMllQMllXQWNiVWVvaHZpWGkrbTNPN3h0?=
 =?utf-8?B?Mzd4VHZuMlB6UTlWWktsVjZxMnVmRU15eWE4NXBaTkRRZXpaU2pxRERoV0s0?=
 =?utf-8?B?a0RiUTlaYjhiT2ZwS2cvbUpIOXRyMFc2SzU2ZUhINVZGRlBlRXdGeEluSzUy?=
 =?utf-8?B?dngrSTdNcXBzRUU4YU5GQk40VVo1Qnl0SG1waDkxbXNYOUNMYzJ2alVMRjhw?=
 =?utf-8?B?OWl4V2xCejRtTHJTdzRBRmpRKzdQS2t5OU5zVDZJZmV0M29jUEJsczNaaCtN?=
 =?utf-8?B?NVBOQU85amptSTJmNFhxQk56K2xTa0RHS28vczF0NjhZdEZ1NHpwTTNDOUpU?=
 =?utf-8?B?aW1GdFBSdFp1VFNrWWJ2NlJma3FQZzltejVGU3MzUzZNQW1TNGVtaDltTENr?=
 =?utf-8?B?NDFHRGZJckIyVU1mM0V1SW1LZTd4czBLdUhxWlZJcFBCSnJ5cXhBUURNUDZj?=
 =?utf-8?B?cExDUUhCc0lvY25kT3lHWGEzMWxpbEh4MG9RZFM5dWkrWlRuMCt6eCt4VUxl?=
 =?utf-8?B?MFdBRFFxMzRnNEZWcTZ0cDUwUzFqWWF0eGp5YUJUSzdYa3pWbHZiU3lNeGhn?=
 =?utf-8?B?Vm9vWGVYWitWVFRGY1g4M0NNWTJDbGhFdUJXZW9KSm1JK2dvcTZiTTVYUUlx?=
 =?utf-8?B?VTZCUGNKaVpvSytWQ3VXNk4vWHlTZGxwZ2NFa1ZaN09iYVE0dUd1S0VSajFT?=
 =?utf-8?B?OWFBZXFTV2w4bTNWdFFCajdWUVNhbnFUQTdBV0k1L01qM0JQUFVoZWVyVTh4?=
 =?utf-8?B?RlBvMzd2b1N2cU5FZmoycnBtSzhkamxGZ284OGZzMnErTm1WUEF0NzQyVXFO?=
 =?utf-8?B?UklPRERFWWtkTjl3MUNsek9WclZXdzExS1lGa3luNTQ2SFh6UWQ5NnFIQWt4?=
 =?utf-8?B?d2hlSmFQaWlzUks0VVE3WlRjYkZGVWp3N0RSZUtyL3hEMHd0aVdPendHV2tD?=
 =?utf-8?B?c3hLUTQreGk4WHNOOW44WVlUazNmZGZoNFZ0bytyeVlUU1hBaFRYSTcyNFlq?=
 =?utf-8?B?eTFhNThPWXNUZFRUOE5uODF0Q1NoeEx4QzJaSi9leDdSNnlQN0VnZ1VmQjRm?=
 =?utf-8?B?ekFQK2tjbDZ0QXUvSTlrNE83Rzl2ZmJVeFlHSng0VjhjeFUvc1B3bENJKzhE?=
 =?utf-8?B?a05RL1ZOMkZkaTMxSnlTTDk1TTFFdUhacjhTbTlkMzV6dkxWSGNGTlhsOVFy?=
 =?utf-8?B?UDZxc3lVemlDOGJWNENUbUYvcHd2ZUNaa1R2QUoveGxOWFFlMmw2Z2tET0hk?=
 =?utf-8?B?Y0xncVFkTnc4QysxYjBUcUNyNXdaQmFyVTNvWENEMjNZOWdkOHpRemMrdXJL?=
 =?utf-8?B?SmtQa3Rrb1o0T0hkRW5DQTlibzUzOWNTNWR5dUF5MFhza3Z5VGgxRlJJTVNI?=
 =?utf-8?B?Wk5iRkI1akh4OE4wR1dGVEdXanNPTmNHMVk2S0pIUy83MEZqbWlWejNaMFow?=
 =?utf-8?B?UlFSYnZwSHQ3ZWEvV2MyUFlXaWFUaGlkOWxPQjBTUVQ4VTc5bEYwN1VCY2FT?=
 =?utf-8?B?cllnMlBhTDFHeHozTHYxUWtZVUdFZ3l3ek13c3BmNUNOQ09Fd3NnYmI3SkFw?=
 =?utf-8?B?dWx3ZkRHMXhRTTRSUk41b2s3UjN2SUlPZnpTY1RzTjQwY3BGN1g0b3FVM3U1?=
 =?utf-8?B?c21GRTJoVnREcDQzSnFoamM0UjJpS0JCN3llU05Zb0t1dVVrekxZNllOZzFY?=
 =?utf-8?B?Rm4xdDhHRFdLc0hBZXB0YWQ4N0NhaGlmT3QrcFRkTERaUWlEMVJZSi9FMzc4?=
 =?utf-8?B?OXdMcitENlA2R0hjUThpbk8veTFMQTc4ZE5FZTdadlhHcDFxblc4bm1TOVln?=
 =?utf-8?B?M0FrdTdJM1dXcG1UWm1uTENxeDFXam95Zk5OTm83UUJqdHZGbE5MUzVHNjhR?=
 =?utf-8?B?UXlXUkRKT1RsOE5NSXYzV1NuQUxuM2p5NlZaa0NDdkw0YkIwcTNqdVB5VXNO?=
 =?utf-8?B?V1BwdjZtM0w1U3pPd2d2eml2dlZmb2UrTnY0amh3SVV0bm82NFhhMFI0RXMw?=
 =?utf-8?B?MnRPVUNTQVpHbHdWeWUrL1JaTEIveTM2RlZvV05FNDBLZGJ3aWd2WTBGdnVS?=
 =?utf-8?B?eHkzZnZJaUI2SmUxQUhTUTRaQzdXNWxNcW42bTVKcURYV0xEVnN5cmdjWjly?=
 =?utf-8?B?ZkVDYlJjYms2aVRWYTh4U2hFdmdSTGJEWHUxdHh3c0dBbmthMTFrajNQdko0?=
 =?utf-8?Q?0JUBj6+GNoEOuZh5ruhXw8JBTdRWJqlj4mjegQV5D5TwE?=
X-MS-Exchange-AntiSpam-MessageData-1: qzVP0wiivkt7tg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807f27b0-0522-44cd-6799-08de855d9138
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:16:44.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnfsZlvnp6jscsyKtzT/C6VEU7fuczbZZso6TIOZ4GVJqHgltKdr5hPwOmuCpqWpaxiqPC0af2/+ASkGTppcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

On Thu Mar 19, 2026 at 11:07 AM JST, Alexandre Courbot wrote:
> On Thu Mar 19, 2026 at 10:42 AM JST, Eliot Courtney wrote:
>> On Wed Mar 18, 2026 at 5:05 PM JST, Alexandre Courbot wrote:
>>> Convert all PMC registers to use the kernel's register macro and update
>>> the code accordingly.
>>>
>>> nova-core's registers have some constant properties (like a 32-bit size
>>> and a crate visibility), so introduce the `nv_reg` macro to shorten
>>> their declaration.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/falcon.rs |  7 ++--
>>>  drivers/gpu/nova-core/gpu.rs    | 37 ++++++++++-----------
>>>  drivers/gpu/nova-core/regs.rs   | 73 +++++++++++++++++++++++++++++++--=
--------
>>>  3 files changed, 78 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/fa=
lcon.rs
>>> index 7097a206ec3c..4721865f59d9 100644
>>> --- a/drivers/gpu/nova-core/falcon.rs
>>> +++ b/drivers/gpu/nova-core/falcon.rs
>>> @@ -13,7 +13,10 @@
>>>          DmaAddress,
>>>          DmaMask, //
>>>      },
>>> -    io::poll::read_poll_timeout,
>>> +    io::{
>>> +        poll::read_poll_timeout, //
>>> +        Io,
>>> +    },
>>
>> nit: // should be on the last import?
>
> It should, thanks.
>
>>
>>>      prelude::*,
>>>      sync::aref::ARef,
>>>      time::Delta,
>>> @@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>>> =20
>>>          regs::NV_PFALCON_FALCON_RM::default()
>>> -            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
>>> +            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>>              .write(bar, &E::ID);
>>> =20
>>>          Ok(())
>>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.r=
s
>>> index 8579d632e717..d81abc7de3d7 100644
>>> --- a/drivers/gpu/nova-core/gpu.rs
>>> +++ b/drivers/gpu/nova-core/gpu.rs
>>> @@ -4,6 +4,8 @@
>>>      device,
>>>      devres::Devres,
>>>      fmt,
>>> +    io::Io,
>>> +    num::Bounded,
>>>      pci,
>>>      prelude::*,
>>>      sync::Arc, //
>>> @@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt:=
:Result {
>>>  }
>>> =20
>>>  /// Enum representation of the GPU generation.
>>> -///
>>> -/// TODO: remove the `Default` trait implementation, and the `#[defaul=
t]`
>>> -/// attribute, once the register!() macro (which creates Architecture =
items) no
>>> -/// longer requires it for read-only fields.
>>> -#[derive(fmt::Debug, Default, Copy, Clone)]
>>> -#[repr(u8)]
>>> +#[derive(fmt::Debug, Copy, Clone)]
>>>  pub(crate) enum Architecture {
>>> -    #[default]
>>>      Turing =3D 0x16,
>>>      Ampere =3D 0x17,
>>>      Ada =3D 0x19,
>>>  }
>>> =20
>>> -impl TryFrom<u8> for Architecture {
>>> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>>>      type Error =3D Error;
>>> =20
>>> -    fn try_from(value: u8) -> Result<Self> {
>>> -        match value {
>>> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
>>> +        match u8::from(value) {
>>>              0x16 =3D> Ok(Self::Turing),
>>>              0x17 =3D> Ok(Self::Ampere),
>>>              0x19 =3D> Ok(Self::Ada),
>>> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>>>      }
>>>  }
>>> =20
>>> -impl From<Architecture> for u8 {
>>> +impl From<Architecture> for Bounded<u32, 6> {
>>>      fn from(value: Architecture) -> Self {
>>> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always =
lossless.
>>> -        value as u8
>>> +        match value {
>>> +            Architecture::Turing =3D> Bounded::<u32, 6>::new::<0x16>()=
,
>>> +            Architecture::Ampere =3D> Bounded::<u32, 6>::new::<0x17>()=
,
>>> +            Architecture::Ada =3D> Bounded::<u32, 6>::new::<0x19>(),
>>> +        }
>>>      }
>>>  }
>>> =20
>>>  pub(crate) struct Revision {
>>> -    major: u8,
>>> -    minor: u8,
>>> +    major: Bounded<u8, 4>,
>>> +    minor: Bounded<u8, 4>,
>>>  }
>>> =20
>>>  impl From<regs::NV_PMC_BOOT_42> for Revision {
>>>      fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
>>>          Self {
>>> -            major: boot0.major_revision(),
>>> -            minor: boot0.minor_revision(),
>>> +            major: boot0.major_revision().cast(),
>>> +            minor: boot0.minor_revision().cast(),
>>>          }
>>>      }
>>>  }
>>> @@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Resul=
t<Spec> {
>>>          //     from an earlier (pre-Fermi) era, and then using boot42 =
to precisely identify the GPU.
>>>          //     Somewhere in the Rubin timeframe, boot0 will no longer =
have space to add new GPU IDs.
>>> =20
>>> -        let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
>>> +        let boot0 =3D bar.read(regs::NV_PMC_BOOT_0);
>>> =20
>>>          if boot0.is_older_than_fermi() {
>>>              return Err(ENODEV);
>>>          }
>>> =20
>>> -        let boot42 =3D regs::NV_PMC_BOOT_42::read(bar);
>>> +        let boot42 =3D bar.read(regs::NV_PMC_BOOT_42);
>>>          Spec::try_from(boot42).inspect_err(|_| {
>>>              dev_err!(dev, "Unsupported chipset: {}\n", boot42);
>>>          })
>>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs=
.rs
>>> index 53f412f0ca32..62c2065e63ef 100644
>>> --- a/drivers/gpu/nova-core/regs.rs
>>> +++ b/drivers/gpu/nova-core/regs.rs
>>> @@ -35,20 +35,64 @@
>>>      num::FromSafeCast,
>>>  };
>>> =20
>>> +// All nova-core registers are 32-bit and `pub(crate)`. Wrap the `regi=
ster!` macro to avoid
>>> +// repeating this information for every register.
>>> +macro_rules! nv_reg {
>>> +    (
>>> +        $(
>>> +            $(#[$attr:meta])* $name:ident $([ $size:expr $(, stride =
=3D $stride:expr)? ])?
>>> +                $(@ $offset:literal)?
>>> +                $(@ $base:ident + $base_offset:literal)?
>>> +                $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alia=
s_idx:expr])? )?
>>> +            $(, $comment:literal)? { $($fields:tt)* }
>>> +        )*
>>> +    )=3D> {
>>> +        $(
>>> +        ::kernel::io::register!(
>>> +            @reg $(#[$attr])* pub(crate) $name(u32) $([$size $(, strid=
e =3D $stride)?])?
>>> +                $(@ $offset)?
>>> +                $(@ $base + $base_offset)?
>>> +                $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?
>>> +            $(, $comment)? { $($fields)* }
>>> +        );
>>> +        )*
>>> +    };
>>> +}
>>> +
>>
>> Is it really worth introducing this macro to save pub(crate) and (u32)?
>> Are we definitely going to always be using pub(crate) and u32?
>
> So far we are. I'm not particularly passionate about it, but I think
> it's nice not having to repeat ourselves (and potentially introduce
> typos).

One downside is that the nested macros make it harder to check the
implementation since you have to go to this definition, then to the
register macro definition if you want to check something. And I also
feel like I need to read this intermediate macro definition to see if
it's doing anything special if I run into some error.

Personally I would probably go with just using the register macro
directly, and then we can tighten the visibility later if it's useful
without having to change all of these. But not a super strong opinion,
so up to you. Just doesn't feel like it saves us that much in typing the
extra tens of characters.

