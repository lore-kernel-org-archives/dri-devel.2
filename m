Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B41090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816CA10E911;
	Thu, 19 Mar 2026 14:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsbzHaNY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512A110E968
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 14:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAnIVwZiFzoI40o3L9Ne9v/aeKIiQwzMZ3KEEuiaeBATD0ouVe8SZqoiu1HZQuUG7uZ+EjJGB/NwnIkLIbgOuXffH4aRFN7+74UOo9EufFxtrFKAw/eB2UXxub1Xma+VCNUalz7/HjL71thQ8VfGQxE0WMVXfzotGXnO+8+ewejIhse9DE94PDp+lXowFP+x4SoWuNrtjlab+7KC8SPz05nMcL9gXnoWU/fBSn64bq1ev0O3OxHs1jV4BkNObZmfaS2yYMYK5huo3R8x5iQJQt9DZFAhj7aF8S/7gouaD5NO6EdC2eGFH+GXMeo8OgUcrNcKGSWwMHs7rTOefswQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6JOPb8sKgccqzQgM9lYviJUQCSLBMB1uSw3wuRZwDw=;
 b=Xo3rPO7aLrxjLUynLPV1yDSIgBpa8P+64qlq5rRaKCWSHRU6TeUaf1Gkv9FAYqqQtEcUXKNOmeereX+lUsEzd0gxzClGaW1OtkYc4eXXv8nzXJuDvrXjZamFAQmZtHTyK3mrHh+3ndSx/m6xprmrT+ZH/mJBbvoVSxFlZJlG9wZHWQ3JOmbnjf9Fx31ygUa6S23z9qu9QJkCH/8iJeGHPRVaKa4sKUt3gmGSruO5eCUjUDlHCwr1ypfaTXYgTNRu3NdEqKVeRGnQCeBruywqUNwATsiaB1yllpw6XMetAlQ/i+FdE7pd+N/soTKZh2iHJ9k5dqrb0Ek33YB/0jpSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6JOPb8sKgccqzQgM9lYviJUQCSLBMB1uSw3wuRZwDw=;
 b=JsbzHaNYb8nAv/HRjC7c5wDI6G6TLWyf3GGMfwT3Ppx1pnU5Y7/8dTbZlF/XoUcOxU4klVg8evmCNyg30wnMrcbHpjRLjK2CDWym/U+kMOLe6SLfwsVS0V0QKvCn4S0vS5w3DDjDA9nBRk9NNmxMqDLf3fEVc8W6TWt6alw+QBFZy7ld2qXcfeOcZGmw71l/qnCEAt0G2tC6hsT8KsyDU8T69AqgJfLSFZu8d22hWfJ2YcSk5hwXJcXG0KUyi8FPY6VYxEHQJXfoB60knqONQdJ+vdhKtZGGMi+otfPWoMGgOSUrW9TaMnkCLvAEJd9Y+gag+CEYwNNU6XSDCRAtNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 14:18:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 14:18:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 23:18:08 +0900
Message-Id: <DH6TNWGBRZTG.JL331O1Q943Q@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
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
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-1-22a358aa4c63@nvidia.com>
 <DH6DL5899CLZ.2FMG8UQSNEII7@nvidia.com>
 <DH6E45KONHJD.15LJ780SCTJPC@nvidia.com>
 <DH6EBIF5HHAE.3ECC0Y8TMIG14@nvidia.com>
In-Reply-To: <DH6EBIF5HHAE.3ECC0Y8TMIG14@nvidia.com>
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 87dd77f4-4256-423c-efa1-08de85c25a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Mp2EoNM5Seess8YAIymwAPWwaFkQWPXLV87BNyY37fcaCnim10N9KyZY+In9YmaaoncjEIiFZ97EvEQ+6vuAyupO41jtWvN4pkGoKzusma+8pPtuprniL3M9YcoiRMzQqmf7wbzR6HHHzoDjZtQkQqMRR0+5lLoKKIb8QFkQ0qx2XgbYGuu3QUgO/fydncqkyi1eJ6QTApqZFieCfTBlj4fKvcm5/bHuByfD2RYWdxcf87UPvk1/5LrU8aQFHURSDaUqiDqRIF8kszkveNtg0fGhLYj8l4ZVHZDIQ6Va2n9iOTPiMVAkfbivhBw4cxstwmg6uFJ1k2CAPxZoY3uCA6xFteCFa0YIKwWroKlShjA9AQQtLbtJJ4gBvhdReZ19VA36fsSytG+e/G7lOoGfOUbyt+MNwJotCDDrOsQCLoaZbA9WtPmltDPfs0yk+X9q2Y4KBZ2k8KoCG1sMobQov2dCQaC2Z1r5FuSSzNtsP0usVB1X/MvLTaS9A+CiTGwnznQ8MlB74ZRrjeO5eDa9XSSrVOHNEVdKvYUdX38VyxQAv+nreS2xI9e8O7LI2GdBaINkuHecxOLFUYa64WRaa6dJvWsZLsuUJHbKdFg1/SqIY9A7hp52b09zJiStKTxEeOk7JQZTVi1t/IB9YzJM5xsuyloEFuCydPIglPnvikD516JdWfXqM+XIFQiypDsWJPDKv1qBWOrGPRJyg/6bzv7sc3xaOsZzKWY6v/qxcac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG1vSjJoTVA1cFpQYzgwQWd6VzZyRXRoOHZQZWF2TWxRVENHeElXamJxK1F1?=
 =?utf-8?B?MWoxSzJlQ1V6a2l6dDQwLzJJeHMvbmFVOWV4MDAzeUNCL2lpMk8rb3JvM2lH?=
 =?utf-8?B?ZXJIR2tOSFFMTUdNSllyNmtZTVhrY3RaSkdJV2dSYkt3MFh1M0NWaEFHN2Qv?=
 =?utf-8?B?N3JJRGxJNmFJdkFMaWhpcXdjaUVqdWY4SG14RndPYzhiN2NQVnBIVWllVWx3?=
 =?utf-8?B?VC80ZnNqdTRyelFGQ1AvWlBJMWU5RzFyb255alAyM1p5U3NUS29ZVGVaemlp?=
 =?utf-8?B?WThIeWdmSytmanNhWGRUUEMxaVlxRTl5c01BUEJSMDkvV0Z0Q28xa2d5YnhX?=
 =?utf-8?B?Um1LaE5JUVVHUUxJQy9DVlNueHN0TDNtTWNLNGU5MFo4RThKME5lS01JdDhM?=
 =?utf-8?B?djhxZjJ2YnJ6L3VJeWtNREJpaFlHT1VkQW1ybVhQb1BjTEVxOU1BT3ViUTMv?=
 =?utf-8?B?NlY3RTVJdXhVeHR6TGZuSkZHT0IrejkyKzd5SjNPc0VwZ3p4M05LWU1tYnZ5?=
 =?utf-8?B?blNUeHoxazNSSDRrbm1ES0pFZkNhTFFxa212QWVla0RYZThoVUJ5ZnYxeFBj?=
 =?utf-8?B?OEVsZjQzcWZ2dGdvSXMrQmxwOThxdHBRK0N6Y0FpRHpKbTFEczFqYkdIZk1w?=
 =?utf-8?B?dEdvSTk4dWJVeVhESHk4aFhxMWNQYVFsNDMzYWtNekFITE5IdFZUQzJFY2pw?=
 =?utf-8?B?bFJIK29BeVZOc3BreWtaR3VBeFc5cDQxRTBmVnc1TWxlSGMxWU1Uek91Nm8x?=
 =?utf-8?B?b3dHR3cwNk0rT3dJcFJSTVltc3grQ05FVzZ6UVdVd2w0ampYMTlsb1NqN0lG?=
 =?utf-8?B?T2E1NFJXUVd3ZTA2S1k2VGdvV01rRzNzaCs1cGhqdXNzdGl3eEhyU2hrY21k?=
 =?utf-8?B?KzFCNXk2d09kMkM4U3Y2aUdOZVk5cHJIeE1FM0lFUDJPSUIzNmhZRHhRR2pX?=
 =?utf-8?B?SUZiLzh3S3AwRzc5L0o2SXk4SFpsa0tVNGpFdjNTV0xEK3lJL0hZVHFYWk1Q?=
 =?utf-8?B?b2NkNG9aYVEvWXlVNWExQnlTNzI2c2p4enowR09lWng2ejdBbnp5alZEMm9W?=
 =?utf-8?B?c3YzOHJWQnpROWdRcU1QTUpsUDRqY2NWTHQ3UysyQzUrbnJhcmFpOEpMblRi?=
 =?utf-8?B?aFArdENMdmtmckJVd0NwUm0rZEFtQVI4cWhiYnBVcWRUd2tnNkpuT21XajZa?=
 =?utf-8?B?bUVkZHloSlM0RVdPT2dXN25PNFZzZGxZbXFEdVFHaUJ2QmNtTmlPNGY3RjR1?=
 =?utf-8?B?TmU2OVBSdU5mbmdCb1UxWVl0eEVXNnczWjUzblloYklrWUY0bWtuUzJRZnly?=
 =?utf-8?B?N3dJTmdqWkJBdk5WWGl2VmlTTWNLbGRLcnV6Skh1RDdxblZ0OVI0SERKZ0lq?=
 =?utf-8?B?WEN6MS9FSEF6NnZHb2xSVVQreXZhWUEwaG9KNXRVY004Qm5tbjFrZm5jZWM3?=
 =?utf-8?B?RENNWFQ3U3NkREo3QTV3NXhPVWJxcFdvb011aDhZa0VMMmI5eU8reVpLNC96?=
 =?utf-8?B?c0FDMytVejBjNFlBNXRtM0wvRzBYeHdSVHZMOE1iZmU0SjhnenhmVnNYTCtP?=
 =?utf-8?B?Q0pWY0xkZ3U5T01jTllXeDhHMUswZlBDTFdsaGp2WFNjU1lndkJQVmRyM3Rl?=
 =?utf-8?B?ZG51U0NUMFlmT0cxMGtUbU1RSHdiZmlQdUk0eFJpN3dwQlZkVGpMaldoR3Zx?=
 =?utf-8?B?VkhtcHp4UG1NWTdES1NGWHhJV1lHOHRsWlJkc25OcUU5L2J6Q0x4b3BxWWpJ?=
 =?utf-8?B?eUJhampvWjdqK3NmS0dSUnVDanNac2tIVENsRVhuSkh5bTJETnBKcUdubU1m?=
 =?utf-8?B?ZUlpcDcvcTF2QnRObEVURTFTSjl0eHM5VEhJQmV4RjQxL21hTFRpR0NIdnNi?=
 =?utf-8?B?M1ZBQ3Q5N2NXYjd0bnA3M3JZNm9ycG81NHFkTWhiS0lsVitPRThxd0hkT09U?=
 =?utf-8?B?MnZCK1FIUlJMMHprOHNLZG1IU0grOVVEbmI4SkF0eGpndjNFSE80ZmJFZmtY?=
 =?utf-8?B?YVVFMWNxRzU0NWVmNmpDRmN6YVJiZE1NQTFwS1g1SWFSMU9TdTY4WW5NNWl5?=
 =?utf-8?B?Q01xNWVVOGxTanpuOHNCZ0dNRkFmcTRraE1EUXRZNnRwNUlaTldTaHN5OEZ1?=
 =?utf-8?B?RVRNTXlhcjJXeWNUVjE5N0RSZllnajZ5Z0pxK3VBSFhBL1FJOFJmSVFiSnZp?=
 =?utf-8?B?ZWxaa2o5NmdPL3pCdExHdUxOb0dJR1RNWXp2QkRIdHZaOVBZL2RsdVZjQ3VN?=
 =?utf-8?B?aDRMbUZacG8xSzQ4RkZQelZrK2dRQ1J5VllhdDc4TkhBbkorQURUUGFMVzht?=
 =?utf-8?B?enFFcSsvRisrWXducllHeGp0WVVqOVllT2dvcGN2ak15NGg2dVlBM0NoZlRo?=
 =?utf-8?Q?ILxxmZ7bDC/IHMIH9zKkDlsVl1JLevIkg1XOvLM8Z9s5N?=
X-MS-Exchange-AntiSpam-MessageData-1: 59CwjcJ5xncr3A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dd77f4-4256-423c-efa1-08de85c25a2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:18:11.9767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNHExBVs/qV/hyxatlgZwE7hsaLe7eMEzRqF9o76ivZuiJQZzvoye+KvhOtR8aD9ENGwfwUmQxKA6IJEI8cNvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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

On Thu Mar 19, 2026 at 11:16 AM JST, Eliot Courtney wrote:
> On Thu Mar 19, 2026 at 11:07 AM JST, Alexandre Courbot wrote:
>> On Thu Mar 19, 2026 at 10:42 AM JST, Eliot Courtney wrote:
>>> On Wed Mar 18, 2026 at 5:05 PM JST, Alexandre Courbot wrote:
>>>> Convert all PMC registers to use the kernel's register macro and updat=
e
>>>> the code accordingly.
>>>>
>>>> nova-core's registers have some constant properties (like a 32-bit siz=
e
>>>> and a crate visibility), so introduce the `nv_reg` macro to shorten
>>>> their declaration.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/falcon.rs |  7 ++--
>>>>  drivers/gpu/nova-core/gpu.rs    | 37 ++++++++++-----------
>>>>  drivers/gpu/nova-core/regs.rs   | 73 +++++++++++++++++++++++++++++++-=
---------
>>>>  3 files changed, 78 insertions(+), 39 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/f=
alcon.rs
>>>> index 7097a206ec3c..4721865f59d9 100644
>>>> --- a/drivers/gpu/nova-core/falcon.rs
>>>> +++ b/drivers/gpu/nova-core/falcon.rs
>>>> @@ -13,7 +13,10 @@
>>>>          DmaAddress,
>>>>          DmaMask, //
>>>>      },
>>>> -    io::poll::read_poll_timeout,
>>>> +    io::{
>>>> +        poll::read_poll_timeout, //
>>>> +        Io,
>>>> +    },
>>>
>>> nit: // should be on the last import?
>>
>> It should, thanks.
>>
>>>
>>>>      prelude::*,
>>>>      sync::aref::ARef,
>>>>      time::Delta,
>>>> @@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
>>>>          self.hal.reset_wait_mem_scrubbing(bar)?;
>>>> =20
>>>>          regs::NV_PFALCON_FALCON_RM::default()
>>>> -            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
>>>> +            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
>>>>              .write(bar, &E::ID);
>>>> =20
>>>>          Ok(())
>>>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.=
rs
>>>> index 8579d632e717..d81abc7de3d7 100644
>>>> --- a/drivers/gpu/nova-core/gpu.rs
>>>> +++ b/drivers/gpu/nova-core/gpu.rs
>>>> @@ -4,6 +4,8 @@
>>>>      device,
>>>>      devres::Devres,
>>>>      fmt,
>>>> +    io::Io,
>>>> +    num::Bounded,
>>>>      pci,
>>>>      prelude::*,
>>>>      sync::Arc, //
>>>> @@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt=
::Result {
>>>>  }
>>>> =20
>>>>  /// Enum representation of the GPU generation.
>>>> -///
>>>> -/// TODO: remove the `Default` trait implementation, and the `#[defau=
lt]`
>>>> -/// attribute, once the register!() macro (which creates Architecture=
 items) no
>>>> -/// longer requires it for read-only fields.
>>>> -#[derive(fmt::Debug, Default, Copy, Clone)]
>>>> -#[repr(u8)]
>>>> +#[derive(fmt::Debug, Copy, Clone)]
>>>>  pub(crate) enum Architecture {
>>>> -    #[default]
>>>>      Turing =3D 0x16,
>>>>      Ampere =3D 0x17,
>>>>      Ada =3D 0x19,
>>>>  }
>>>> =20
>>>> -impl TryFrom<u8> for Architecture {
>>>> +impl TryFrom<Bounded<u32, 6>> for Architecture {
>>>>      type Error =3D Error;
>>>> =20
>>>> -    fn try_from(value: u8) -> Result<Self> {
>>>> -        match value {
>>>> +    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
>>>> +        match u8::from(value) {
>>>>              0x16 =3D> Ok(Self::Turing),
>>>>              0x17 =3D> Ok(Self::Ampere),
>>>>              0x19 =3D> Ok(Self::Ada),
>>>> @@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
>>>>      }
>>>>  }
>>>> =20
>>>> -impl From<Architecture> for u8 {
>>>> +impl From<Architecture> for Bounded<u32, 6> {
>>>>      fn from(value: Architecture) -> Self {
>>>> -        // CAST: `Architecture` is `repr(u8)`, so this cast is always=
 lossless.
>>>> -        value as u8
>>>> +        match value {
>>>> +            Architecture::Turing =3D> Bounded::<u32, 6>::new::<0x16>(=
),
>>>> +            Architecture::Ampere =3D> Bounded::<u32, 6>::new::<0x17>(=
),
>>>> +            Architecture::Ada =3D> Bounded::<u32, 6>::new::<0x19>(),
>>>> +        }
>>>>      }
>>>>  }
>>>> =20
>>>>  pub(crate) struct Revision {
>>>> -    major: u8,
>>>> -    minor: u8,
>>>> +    major: Bounded<u8, 4>,
>>>> +    minor: Bounded<u8, 4>,
>>>>  }
>>>> =20
>>>>  impl From<regs::NV_PMC_BOOT_42> for Revision {
>>>>      fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
>>>>          Self {
>>>> -            major: boot0.major_revision(),
>>>> -            minor: boot0.minor_revision(),
>>>> +            major: boot0.major_revision().cast(),
>>>> +            minor: boot0.minor_revision().cast(),
>>>>          }
>>>>      }
>>>>  }
>>>> @@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Resu=
lt<Spec> {
>>>>          //     from an earlier (pre-Fermi) era, and then using boot42=
 to precisely identify the GPU.
>>>>          //     Somewhere in the Rubin timeframe, boot0 will no longer=
 have space to add new GPU IDs.
>>>> =20
>>>> -        let boot0 =3D regs::NV_PMC_BOOT_0::read(bar);
>>>> +        let boot0 =3D bar.read(regs::NV_PMC_BOOT_0);
>>>> =20
>>>>          if boot0.is_older_than_fermi() {
>>>>              return Err(ENODEV);
>>>>          }
>>>> =20
>>>> -        let boot42 =3D regs::NV_PMC_BOOT_42::read(bar);
>>>> +        let boot42 =3D bar.read(regs::NV_PMC_BOOT_42);
>>>>          Spec::try_from(boot42).inspect_err(|_| {
>>>>              dev_err!(dev, "Unsupported chipset: {}\n", boot42);
>>>>          })
>>>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/reg=
s.rs
>>>> index 53f412f0ca32..62c2065e63ef 100644
>>>> --- a/drivers/gpu/nova-core/regs.rs
>>>> +++ b/drivers/gpu/nova-core/regs.rs
>>>> @@ -35,20 +35,64 @@
>>>>      num::FromSafeCast,
>>>>  };
>>>> =20
>>>> +// All nova-core registers are 32-bit and `pub(crate)`. Wrap the `reg=
ister!` macro to avoid
>>>> +// repeating this information for every register.
>>>> +macro_rules! nv_reg {
>>>> +    (
>>>> +        $(
>>>> +            $(#[$attr:meta])* $name:ident $([ $size:expr $(, stride =
=3D $stride:expr)? ])?
>>>> +                $(@ $offset:literal)?
>>>> +                $(@ $base:ident + $base_offset:literal)?
>>>> +                $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$ali=
as_idx:expr])? )?
>>>> +            $(, $comment:literal)? { $($fields:tt)* }
>>>> +        )*
>>>> +    )=3D> {
>>>> +        $(
>>>> +        ::kernel::io::register!(
>>>> +            @reg $(#[$attr])* pub(crate) $name(u32) $([$size $(, stri=
de =3D $stride)?])?
>>>> +                $(@ $offset)?
>>>> +                $(@ $base + $base_offset)?
>>>> +                $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?
>>>> +            $(, $comment)? { $($fields)* }
>>>> +        );
>>>> +        )*
>>>> +    };
>>>> +}
>>>> +
>>>
>>> Is it really worth introducing this macro to save pub(crate) and (u32)?
>>> Are we definitely going to always be using pub(crate) and u32?
>>
>> So far we are. I'm not particularly passionate about it, but I think
>> it's nice not having to repeat ourselves (and potentially introduce
>> typos).
>
> One downside is that the nested macros make it harder to check the
> implementation since you have to go to this definition, then to the
> register macro definition if you want to check something. And I also
> feel like I need to read this intermediate macro definition to see if
> it's doing anything special if I run into some error.
>
> Personally I would probably go with just using the register macro
> directly, and then we can tighten the visibility later if it's useful
> without having to change all of these. But not a super strong opinion,
> so up to you. Just doesn't feel like it saves us that much in typing the
> extra tens of characters.

IIRC Danilo also had reservations about `nv_reg` when we chatted about
it - I'll remove it from the next revision to see what it looks like.
