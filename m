Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2042DCD98F0
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741F710E422;
	Tue, 23 Jun 2026 06:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5fBE//+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C9710E422
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0P2JiXvxFYXKDwCz4SOi8S1T+DagFTGrfdECRTQeeWVr3+YyK1ikTPVtLoy3VDoZI3T78QIu0d59x3wOHwu/fm5SmTukml8hkH5IrWY/eVu0Ib9jH6kP6XExCKZEIFlEelqyceG8FBAa+0r4W9OkQ1mnBW+2Z15P6iVnQkybN5dw6iqDyXzOmnaJXiSGK5wD+X3APU7PLp0Iyj/flner23Zapjzafi5czFdsiY2sCXGVD1xttZgayIVkG89FzMwTtcPjf/IXmb/VOEeqU6g5rYe3JRe1+h32NaG3h/KxMNFo30S8GsMCtp9mPo71GZ6tnQfHLz6qzTm9FmjxelZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svBMYVsfpd4y+2Uv7PhMwtattM8/Gwi/ICmdOL6VtpI=;
 b=BEnRwg0p4/YTqm6YjvpW3NefVpE7eihDUz6AnleBJr9B071+Z0CofBN6Xgr283C4wPCXaae7VcShvH761iEQRHavzC4EYp3jCXJRelx+9YZNNjmwngF7VdVUPx6DcSTRUW36ABuMX09aHslfUaXVNh+qRRv42yx3Rg7rIqeNI4AG9vpedC6ZH4NpeCyjql4jHcG/jgnHehzbeJlnKq6rJe5iDaSpC9/cvgE8CUh/daHssGDzSh0PPskilC7/SenvfjvGqxyF21W/jY+CraTvrkWpTMZ+2EPLyRqAD1HRw45v1y/39Ua8436pS8DgnvO6lf00J99mIEDqcTPsGg+XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svBMYVsfpd4y+2Uv7PhMwtattM8/Gwi/ICmdOL6VtpI=;
 b=D5fBE//+gJjWhHsuISS2QlErUXYnLM+5SvGV5feH+wqsgYMvBEM9AKtB6Y6m6xfoKkvcbgYnAQgUcmM8AWS9E1tBQSN/vjghoql3ZrMoi+lIxFto/1nxmaJNZyUT1Q8hy4Z/QwqjfOHV/BrN1oPwTt1/qS6KBDgzahWWBzkpEiF01YHZxsSKUDdsaGx8g9rQOWhEE5Uh32FWmL8OH0T0xryyhM49annKNSjhuxA56NIYitldJ0PCTpgLx1YZ4n+jNwY0cc6/lU9eBnfhZkIubjaQA5jj46NwfK+fSdpj9D3g+UXV5PH5UulMXw3bcAouauN/kJ/WVaPjLnNsenGpTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Tue, 23 Jun
 2026 06:22:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 06:22:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 15:22:07 +0900
Message-Id: <DJG7NQBOIAH5.7SKTD88GB6NX@nvidia.com>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH 3/5] gpu: nova-core: falcon: Move PFALCON2 register
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
References: <20260617-nova-core-regs-split-v1-0-4c7dc4450ea7@nanonej.com>
 <20260617-nova-core-regs-split-v1-3-4c7dc4450ea7@nanonej.com>
In-Reply-To: <20260617-nova-core-regs-split-v1-3-4c7dc4450ea7@nanonej.com>
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f10686-72a4-4ee6-5f33-08ded0efc20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|23010399003|1800799024|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rm3qozbo2QVD+ikf1dUxoioc228++Nj1jUBXDaP5/h88T4IMEeSlIXWStgExDvWFDCJk1vA94WP6pP1aU2PwX5x00yWQzi7Hng70nE0ptdvW2VqLmtJWJbB64G90c8CsfbJvdFV8lGgy3ej2MyTbnNIfh3ip2/m/z58y3TPWsa2tylFJkx6GyYYMoj3U7rxw3wB3zLg8vuuMS818MMGOxnpl8ji5bqGZ/dnuHqY7oadDMWylpE/fId97VljEqOm3oW5FWSGdWy8kig+JK6HVFdi1AlU8wJBwewU69g75ipLpZD91fe7b8SiDeUoY4v6imQDrAH+Cflhdrz1M9WBh0656jIy+8y8z7LI6xucxMWE2ZaibzkBZTBAw3vTwLboyC23JSeNz/mYm+WiBpsDVcMxc7DZG/4DxwL2LrRhD8FjeoDSzdpi2NHT32XkHvRSmrtKIHqsDp+e6apmGCAsNcejF9+ZU1uYzIeaczu4dMcbhbRMmp96toyS5sp2rwuQFORMMbwNJoWncU/MS8Lu85U47VcuT+AHA4dYUycxTSiXBUlcP1n4SJDIY8/L4d8HAU+vjsIC45JBYY4K4SgaaHS73mDf4D7nLd577Q53UMWCjV7LuRwHCyzVm6vTbzBTVNCa/93YQOKLtDQiYbrVRfmTjUQmMYoAh4z9VMnxyZMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZFY2I4dlpzMzBNaml4NlQzNm9Lc1JnQUFQeDVMSUJyUEljaitNRjBTZllx?=
 =?utf-8?B?TExqemlndEMyWlBrRFR3TGtxdmlrcnNJaXhMd2NPaDdaV0x6YmhOSDRHb1l0?=
 =?utf-8?B?eG1VaklNQXl2VWZIekowT25Ea21MeWNjVmdpZ1dQbEZ6VnhpT1RFbU8wSlBo?=
 =?utf-8?B?T21NeGQvWmhhL3VmcFdUK0dJUWxtM2E3YUZSc3hKMzAzMmU1ekg1bDhUSXJV?=
 =?utf-8?B?N0ZzbHRqWUN4OTM3TGk2d2toUW41WlFORDFPV0trWlIwaTQwM3FOWkxYY2x1?=
 =?utf-8?B?cXdyWkpRUllkV3oweWxMY3Zka0pjNG9ZQnhPdTZta0tJb3g5RXV3SFYyZFFr?=
 =?utf-8?B?TU5WZSs3emVxUnNuRjhnaEZTRTZCNWI1QTlxTW1EM0doMnRxc2Q1U3Vhc3N6?=
 =?utf-8?B?SDA0Y0FWWHBhS1dkZ1JJNkQwS1hNdnBJUlBmSGVKNEVWREVBQTE3emUra3k4?=
 =?utf-8?B?Tk4wQkwvWjd3K0cxaFkwWVZQMnZ2eGpMdml6VDdqdUR3RkNyZFQvdHNydW5M?=
 =?utf-8?B?cjludGFvYm1td3JsNThaakUyQTFkNW11S0srK1ZtcjROUWthaUdhTFU4bkk1?=
 =?utf-8?B?UWExUkluNUR2KzU2czdlNW1JZmxGUUcwR3A1M25Kai9tMVFITzJ1cWRaWXM3?=
 =?utf-8?B?OStBU01pWVdZd0k5RHhTa2lhSjhmd3JQb212c3hyNFlrNUlMVTc5MlQ3TG01?=
 =?utf-8?B?YnRabUtYZ05SWGs1dWVOR1hOK2RlNmlySGxSeElqSFhxWE9RanA5Uk84OHJv?=
 =?utf-8?B?WlJ2T0FpK2c4UUx0UDNIL3FGVTJtUFN3S2VmOGk4WU5MM0hmMU5NYlArYWFO?=
 =?utf-8?B?R3V1OG95YlJHcndzS3RwSmdEZnhkSnJ3YW81RE1QT3k0WnJJWDBTNHRQMUhQ?=
 =?utf-8?B?LzlMdGd6TG9ZeHB5L0crVWRLQkQrdFh5dW1JUWpWWXZRcS9lT3JEQ0l1SW5P?=
 =?utf-8?B?MVZWbzIvd2Q3NEVZa1EvNjlFTmNZdk8wa2UwMHhwWTBkNmluODhDaURQdEJD?=
 =?utf-8?B?RldDcjZVNG9GVVA3d3VxS1Jsa2JXWEMrUVNEUUJ4QjR0ZnZvZDVKRnZyalFw?=
 =?utf-8?B?ejdzQ2VYOGpPVzVyWFhyemZrWHFNZGJPekJrZGlrZ2QvNGdvYURKOTNpVERw?=
 =?utf-8?B?SnRBdFdiUVJmaTJoS2xORldXVG5qK21uTzluSytNUW5aNE9ib2o0TGd6L2tx?=
 =?utf-8?B?S2pkVmtpTzZKd0lMN0F2K3lESkt0TkFnRUo4TEFLdGl2MG5ySUozNU84bHk4?=
 =?utf-8?B?c05TOXRhR1d1TzZpcVg3WHJVekljWnk3QlB2anJ4dW5XaUo4eDJEbTdHcUxj?=
 =?utf-8?B?eVJDcWxiclM2OTZYZnJqVGRRWnczcU4zYzJ0NzlIY2FlTVhlTjRjeWFiSXhJ?=
 =?utf-8?B?RXgxd21PSnRUSW4rNWI2THZwakU4TWtYcDBWcm5zZE9mck9vWU4yQVpJTTha?=
 =?utf-8?B?YzJMUjJxTExZaWEwQzFIeHFBSWhSQTE2d01hUzhqcUtLMnJmSThNUStqMzdh?=
 =?utf-8?B?cDdvN0luODkxN3BJcmdFTVNvM0I4RVJRZ0dCMnN2SlA0SXptOVlJRTVvaTBy?=
 =?utf-8?B?dFZWM1pqQTZMdjlFbU0wY3BUcW1UeGNBY1pPZXRIM05TYmZjYWJNbWIvWVR0?=
 =?utf-8?B?M2xKWDArdzkyMXpSNXBQeWpkUjFNTStPVHAxUHVyenF3SmlZV1BqZExLTFVs?=
 =?utf-8?B?Wkt4cUprdnFidUx0eGdORTl1KzhveEpUbHBJTjNIaGd4eG9xR3JWeFZ1bE9r?=
 =?utf-8?B?YTdoc0t1TzJvV0RxRUJhMGJBcVB2MTdGdy9TYm9wV3VsZUtJTVdNaWNsdkIw?=
 =?utf-8?B?UFRlYjVySXh1TjJXY2tmMkVYMUZHZmVhaFJHY0plOUVXV252b2Z6WjI3UllJ?=
 =?utf-8?B?dDltZERJTms4VkVXZEZ1NXlodFdEM3JmcG9YckoyTjN6NksxM29VRlZndDk0?=
 =?utf-8?B?QkJNcXZvdWZRUlB4VmVkQVViVUNmUjV6b3MzMGhFdVJBeUIrWG5yMEJ1bzFu?=
 =?utf-8?B?QTZBWHRXaGY5MDNvYWdWTklHOHMzL1Y4b3E4SmRIY1hUYXBHM3hVV1R1TzE5?=
 =?utf-8?B?eDZhaXVxQ3dCMExDQzZZQlZneEhZNWdvV1pYcUtqeU5jclJuVURsY1h0Nk9v?=
 =?utf-8?B?eDU1S25kVWZkZUM2ZHk4S1djQXcyK2pvV1kwWTJnTjJRRThYUzE5bE1SUDNL?=
 =?utf-8?B?YXNXbTl4SEszTzZIamlYT2MzWXNBcnNSOWZWcDlaUjg1aDVMd3NxZVVvUWY3?=
 =?utf-8?B?YWo0bU5ocjB4czRqNDk0NmVBYmF0TlZoMDc3blY4dWlhNlp4TWxlWVE1T01r?=
 =?utf-8?B?T1gxeUQyNVgyNkxUL3dlOUdNUkpObVQvbkFXQjFwNmNWV2lwSDl0OXRmei81?=
 =?utf-8?Q?0+Dz8GyD/vuw7qNcmqn/kiTr+eRak5EMvhwnQc/vaxu6v?=
X-MS-Exchange-AntiSpam-MessageData-1: vVMShnBEszNvwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f10686-72a4-4ee6-5f33-08ded0efc20e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:22:10.6204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oqbaWbGJGLxJvIC/8JyOF955RHmoO68ARhLmW/1u1SmpVaBp0tj4z7ArjljyJP1UTPdrw69BeHVBXCPZdvgnA==
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
> Move PFALCON2 register definition into falcon module and update registers
> visibility.
>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
> ---
>  drivers/gpu/nova-core/falcon.rs           | 71 ++++++++++++++++++-------=
------
>  drivers/gpu/nova-core/falcon/hal/ga102.rs | 38 +++++++++--------
>  drivers/gpu/nova-core/falcon/regs.rs      | 30 +++++++++++++
>  drivers/gpu/nova-core/regs.rs             | 23 ----------
>  4 files changed, 92 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 94c7696a6493..c2215ddd9e80 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -37,12 +37,12 @@
>          self,
>          FromSafeCast, //
>      },
> -    regs,
>  };
> =20
>  pub(crate) mod fsp;
>  pub(crate) mod gsp;
>  mod hal;
> +mod regs;
>  pub(crate) mod sec2;
> =20
>  /// Alignment (in bytes) of falcon memory blocks.
> @@ -99,7 +99,7 @@ pub(crate) enum FalconSecurityModel with TryFrom<Bounde=
d<u32, 2>> {
> =20
>  bounded_enum! {
>      /// Signing algorithm for a given firmware, used in the
> -    /// [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is pass=
ed to the Falcon Boot ROM
> +    /// [`super::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is pass=
ed to the Falcon Boot ROM
>      /// (BROM) as a parameter.
>      #[derive(Debug, Copy, Clone)]
>      pub(crate) enum FalconModSelAlgo with TryFrom<Bounded<u32, 8>> {
> @@ -374,13 +374,13 @@ pub(crate) fn new(dev: &device::Device, chipset: Ch=
ipset) -> Result<Self> {
> =20
>      /// Resets DMA-related registers.
>      pub(crate) fn dma_reset(&self, bar: Bar0<'_>) {
> -        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
> +        bar.update(crate::regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {

It's a bit of a bummer that we need to rescope all these registers
because a few have moved. I think we should try and take the same
approach as patch 2, i.e. make sure each register is only used in one
module by introducing the right abstractions, and move all the registers
of that module in one go.

The `falcon` module is definitely the most register-rich, so it's
probably a good idea to keep it for last, unless you have the patience
to check each of its registers one by one. (LSP can make the task easier
though :)).
