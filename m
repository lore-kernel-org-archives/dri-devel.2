Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2846AFB5EBD
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADE710E1E2;
	Tue, 17 Mar 2026 05:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJckABlb";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCBF10E1E2;
 Tue, 17 Mar 2026 05:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGmhIshGKgUry5bvEdpIIt7Wh8u7NJYWHEs2Dx/5LmVuN5RONzzuPSHzEV070bUO4J7kdY3zI0esKpAHXa8BeOJvJYNZF67MaLGTolMXDGtFoGqf4yZGBPDENvejHbwz6V12AAh1t6LaXaml/0v3PB5LuKJyMx1YLtTtZe7Yj7DRWme9yoCPzM3UqfWDf7/PsYoiR/LSoLwPzsnvR0zTh6yMOD8O++gHOemDrMiM2OF2MuofUk6knuHSZek4rlubQmIHTERbQARxxlM8fNVFTKsZ6IrJaK1ELmRk9SqZRUImAoZKIcHzdQdRMNtYMkInDn+Zv6N7TvPMrFKwgE4UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARc+IYwNfMVsMhauVrhAvF8TTmXJMBGBwF/OaQH2c68=;
 b=TaA5Zjq68RIg3Fq6lUGP8yKVfQRPjmCvz/VfdoBcS2zCUIK+g/LroAn6y3da4cMDHc8+ruVmKJVsJHJpleQUpUe2X5bsIUVih3wgbk4fcLy7gVZBY+wPJc/xKt3T4a6bW3Ltt+ycfPOzotJW5Z9ob2su9s+AF/E/1aG0V5B1wKi+upofwwtPFYSv6RELvu0RbyUSU6SwovNSQ1wrmhGWL4MbFB4dR+GpYw9/QYXfD8AS+OO2tnfZ6/FtT4S6bHFGk0fX6abIykhJq1HCUFad0hF5HKAaNWctg2Nzjf0FwwJH2uX5tClMzhSRVXXJF12QMcVmBQYNcQq1xBD1VQl4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARc+IYwNfMVsMhauVrhAvF8TTmXJMBGBwF/OaQH2c68=;
 b=OJckABlbKXwq7UHz2tzMxbo7xqhwBY+wv3yPlv3UwTieBGLGoxkHojxEiYTL8vQ66ibSzC3jDu06tPvmria21ofu0ERSAmXfRYzoO99XW06IFuINzxwYCiN55kIWQJ573+pAH90wRCkx5M56NA/X6ZiYTsCLCCuj0/9FJ/B1Q3x2Qt2eRjf7v/gFgAQWsN68cB5glhc1x0ngqGv3ncRa1C4TnfjQXkNEsQtfJY2q5MF4RguLgkW1B/UjwoA9pzKNt7PnPvqHQuQ+MDnq5k305bMYphTz4H5Ea78AMc80AafH12jIkc3pCRr4x0/nf19VsMYr43PuIm7RaNaQZ7GfAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.17; Tue, 17 Mar 2026 05:21:19 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 05:21:18 +0000
Message-ID: <f5744c22-4b15-42a7-a4dc-a9554e5bb3ea@nvidia.com>
Date: Mon, 16 Mar 2026 22:21:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, Timur Tabi <ttabi@nvidia.com>
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260316120820.2117081-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca1b634-674e-4bfc-983d-08de83e504d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: dYQVdDpwHVXAHV2kdotf5YX+/DfbYdyJt8yWN9dQ0QsUWGJPf+TYBFrhzA4etZ1LV1re3msRyTAoAPTPKctWZXX5yZGIN/1oV+yEO8NjvUKbGsK7/mmvTzdNkYdJN38AeAHDvp2O3LUiJQAwA4DKkJaO2mjcfjyHSXRxctjC4H0aya8jp3O1m7oBnpgi2AJA76LEdO7jP2Af824rrvA/olABKU6ZqGgBWBnfUi0BRjHpB6pufaTqYuWDZtv6HTzOU1KfNmOrVxkR1Ty3wWC+yH+Ux+O1QdB+ReXPRRC8nWDS5SvM2dhvFK1TGfdqWaSzIoTn5hmlDX/V/N9RodwokHl78lO7vWIJuFEjboehM+6hJKV/tuBmFF3TjRc9BFlqt2ep/nwL/pLFqBQE3Wihf9346rtu3FbS76uLLcd9Y10Ocw+pWQF+LIdvIYgpSMt6XjJ6fwUojSi4hjhq7ecdzKfruX/+2wd6NaqkKYU+JCD+gKN2FOJTeNmJikqeCbWeiWZorKEA40Eu/qAyTD0zZzVHrumKDmtnvPosVjzU4zMqjItGIY/CK+K48rKt/isDjO9rGU01sfW9ZAliJHDUsWPZq6uUUN8y7/wtK86OQhkfPF8BiH/wYA55myi/9242KzIFRH0KTEJFMEc+ubXzCBDEhD4Gef1z66hxtcqbP2lvW0jI/sKGC2aJr1lanQhqKQsJz98pSt2cTesdfbzvYm8SxYb9D23c+3entwUjfKntkRp3NrMOTnUahMmw7q7n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hIY2FxcWVoK0tkc0pZV1FlSUtrVzVVaGdqVnQyR0xQMU9LdXJ3clNsVXJh?=
 =?utf-8?B?dStPWHdYM2xIajJVc0FEMGJCV21McnB5ZmhYaHU3N3QyWkpmajJoWDBoeHVl?=
 =?utf-8?B?dktjNXdVRkVhWkozb0Q1UUp2TlZLaXJMaGN4c3pzdXd0Y2M0WS8wWlViQS9k?=
 =?utf-8?B?R0pRV3BRVHhoeFg1SUdQS0wxdlcxUDBPd1ZnU0FTbXplNlkrNXdSZXl3eGY3?=
 =?utf-8?B?cDNqMDdOVGRNRGJMa2owL1pReENGdURjeCtiN283RThMQ044a1lGYW1wRlAz?=
 =?utf-8?B?MVk4SWwrWDBIMHZRUjI2T2tuanNnaythcitQWkttRGV3Sm4vdFliVlBVRjg1?=
 =?utf-8?B?dW1oVjZIV0RNQWFNVjNVbzNFL3E5KzZyTG9sQVdBRm40Sjc2b1NjSG5hSi9P?=
 =?utf-8?B?MFM1RlNUVDJSdndpWjlUL0hBM0dTOFQrU2E0WENRZDlCRWVkVjQyM21zQ3NB?=
 =?utf-8?B?TUFVVFI5VkNtMVZnd3ZuLzR0cjZRaTAyM0Q3STk4dkkvSVRrRjZoUVJYSHBC?=
 =?utf-8?B?U2I4N0p2d1IzeVNaNS82MVBNcUJGbWtnRkhBU2lTbVRCeVNWWEY4VWJFVVFi?=
 =?utf-8?B?UHk1eHgwWlZpNTUwNU9jNkVBbkZvU3BpOEJLSHArR2xWWHFNYUlhS1NPL3Bp?=
 =?utf-8?B?MTZwbXVsK0c4UjFQeC9ZMEdwc2JCZGhLVWlvMllzeTBHWG1MSnVXZU9hS3lQ?=
 =?utf-8?B?QWtMSkN4Y1FUTXdBVnFhSUVHRjU3ZHJlWE4xUk41cUk4cS9mSWJpR0tMWmcz?=
 =?utf-8?B?d3dFc3lKWXVIRzlCUlJBSXh0U2llbGdLS25QTWR6a1E4bG9IT2JncmF2Tkxr?=
 =?utf-8?B?WjJ5TWRJeWh3V3VMOGhTR0ZxNDdyemd1Zk9DMVVSa2c3clB0VVMvbGtZN3ox?=
 =?utf-8?B?Tzd3akhVTkpkcjRnTlZlOEEzanZrQk92ckltdWQzL1dmbG1KZ3BTRWVNZS9l?=
 =?utf-8?B?KzhuUm02emNNalpKbG9sa0xta1ZKWHRhdmZHMnlacVpCaEQ4MzBZUUd1K2hz?=
 =?utf-8?B?TnpvS1BqRGorMk1QOGJvb0F1dEtVdlJVdkRubmIrazlGK0RrNGk4OEpLRDlj?=
 =?utf-8?B?SGpyUkxxbTY2dWtyQ1BOQTVhcXNGSmN5MzBSaXFja0V5bFlCdGFQRUwwemp4?=
 =?utf-8?B?ZnRwTG1OS3hwM3VGN1dQZUhVWVlPT0dHd0Z0cHNmQ2dsT1ltNzdhVEw3Q2Vx?=
 =?utf-8?B?WnJvbG1BUWo0S0NOREQzWS83ejJMbEpWSFd1ZGNHS1lEeDVCQWdtZ291QU16?=
 =?utf-8?B?YlczY0FFczJja0N5NFRDeEk2STg5dXFSOXhTZGp3MGpja3RmNEJvd0FHMlBD?=
 =?utf-8?B?RCtkSk1SZUphUlZUVm5RcVBUKyt0Q3FoM1ArbmZmQkZhcjdaazZmTnBXQjNQ?=
 =?utf-8?B?bk1wd3dIUVBuVnV4L3UrQkttenh3NzJYdkRhckRKZFZhSzZGRFN3Y0dWd1Yr?=
 =?utf-8?B?eWVER3NVT1JVVS92SXBLa3lyTkFqUFZvMCtuQThYOGJhQUZSbWhRTXZCcDdB?=
 =?utf-8?B?SE5BK0Vtb1lrNUl0aklOV3V4MUtoM3h6R0NHVkJ1YUN6aVJIQ09jNm5Ld1NZ?=
 =?utf-8?B?SmZ3Yytxa0lNNkREYUhMR05CMVdZVVBuYTlaUS9MYzFMQ2VBcW4yeFBSSXov?=
 =?utf-8?B?ekJKZWk1ZTU0eGNCdUlXMnN5bFQzVHlReEh1czdlcXpyVExPYksvZi83c0tX?=
 =?utf-8?B?WHJMMGROaTZ4VHdzcWE0SUZnak1BK3lSMkFZY2NWQXoxb2xQaGNZdXFwL053?=
 =?utf-8?B?N3FJMmloRzBCT0dhaWExZHhNeHZaVm80SkZYOGVhMkwvWDZJSW9uQ0tBalpW?=
 =?utf-8?B?TDhyVEN3OG1reEd2Zkw1Ulg2WmlmSFU0ZW1VMWxXeU14SHRGRFNEZlBDbi9s?=
 =?utf-8?B?WDFyZ2FuOXdLVzE4Um5RUDZpaEFlTFVEbjU5Nms0MXUvVGhmSE9XczQ4dEJI?=
 =?utf-8?B?OFAxd0Q3ZEFTSlNGQTdCdW43cTlydXJJMWY3SEIrOXdIdnl4MDd0YnpOOTVK?=
 =?utf-8?B?SjlWWTBkVkkxL1NUaWUrZnhFV0FRcFkrV1JYQmlnQStnTlVwYi9HVXpOUUxQ?=
 =?utf-8?B?UFRpdk4zaHhwY1hLMUM5RjNYVWVlQTEyVHZha3paOG5acDMwblFrdU54S3BB?=
 =?utf-8?B?WkdCM1R2ZmxVYmZVT1k5SDBUSjdLaVd1ZlFKZVZzUmFVYkZqdHViTTRHWThT?=
 =?utf-8?B?bzE2L1AwdFVHTVViczhJNEFTakZwaWt3ZDJUUWhwYWZhN1lKUUloVWF1WXB6?=
 =?utf-8?B?REZiQ2FXZUlJMEZvTGdwSDF2RldKb1NjVzE1MW1RbG9yY1FhbHdwRE14eFVE?=
 =?utf-8?B?b1JJMEREOCtUNEhSNDZnWjdpTDVxejBCTmxFWlpkUHhqdVYyRVRJQ0pwdGRz?=
 =?utf-8?Q?7BKAQmOlWqhrOZpc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca1b634-674e-4bfc-983d-08de83e504d6
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:21:18.7252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mII+6wQH3UJFsIBbarckroN38WgyH0AYZdHvA7hJ7S9dO692YLFSsgRSEaVsZCS4JpKMPNVySV0IKK39Raj2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

On 3/16/26 5:08 AM, Cheng-Yang Chou wrote:
> Rename nova-core driver from "NovaCore" to "nova-core" and nova-drm
> driver from "Nova" to "nova-drm" to follow kernel naming conventions
> before these names become UAPI (e.g. exposed via driver_override).
> 
> Also fix the nova-drm driver description from "Nvidia Graphics" to
> "NVIDIA Graphics and Compute".
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1228
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Acked-by: Timur Tabi <ttabi@nvidia.com>
> ---
>   drivers/gpu/drm/nova/driver.rs     | 6 +++---
>   drivers/gpu/drm/nova/nova.rs       | 2 +-
>   drivers/gpu/nova-core/nova_core.rs | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
> index b1af0a099551..e3de04f358f0 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -32,11 +32,11 @@ pub(crate) struct NovaData {
>       major: 0,
>       minor: 0,
>       patchlevel: 0,
> -    name: c"nova",
> -    desc: c"Nvidia Graphics",
> +    name: c"nova-drm",
> +    desc: c"NVIDIA Graphics and Compute",
>   };
>   
> -const NOVA_CORE_MODULE_NAME: &CStr = c"NovaCore";
> +const NOVA_CORE_MODULE_NAME: &CStr = c"nova-core";
>   const AUXILIARY_NAME: &CStr = c"nova-drm";
>   
>   kernel::auxiliary_device_table!(
> diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
> index 8893e58ee0db..1fd454c7e0df 100644
> --- a/drivers/gpu/drm/nova/nova.rs
> +++ b/drivers/gpu/drm/nova/nova.rs
> @@ -10,7 +10,7 @@
>   
>   kernel::module_auxiliary_driver! {
>       type: NovaDriver,
> -    name: "Nova",
> +    name: "nova-drm",
>       authors: ["Danilo Krummrich"],
>       description: "Nova GPU driver",
>       license: "GPL v2",
> diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
> index c1121e7c64c5..90e98380687b 100644
> --- a/drivers/gpu/nova-core/nova_core.rs
> +++ b/drivers/gpu/nova-core/nova_core.rs
> @@ -22,7 +22,7 @@
>   
>   kernel::module_pci_driver! {
>       type: driver::NovaCore,
> -    name: "NovaCore",
> +    name: "nova-core",
>       authors: ["Danilo Krummrich"],
>       description: "Nova Core GPU driver",
>       license: "GPL v2",


