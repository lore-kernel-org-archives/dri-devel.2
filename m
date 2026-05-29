Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E896CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DA910FA14;
	Fri, 29 May 2026 07:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VFoD/65H";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E36A10FA14
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edAfDwppPuPTLcc4a8nqqwawNVd2yPfiWIFp847RwsS//2GqMpRIjmQzxA9TPq7Nf3Bbg1fHOppOrwh9cCN+zVhUkxVDDUCbHRpuU4u3hXLL9O7Erd3PoDqGY1vevk53Xm4dfR/wXRUj9EFFTlT3GakF9oWoADGAgQLjDKrnfqN8T8R5X7GJaGAwcMhQIxCVk7adFsY23lx4o8g7O30zoKsAjEMU33cDtTBduqfnxp/sN9G/OsxQqhx3xRQD/5gZrYKqEWzXNry6ggRvnYOqMeXvEKnlHH+t/T00cmOz68kYd6OID5utdHDu+gysib2ju66AY3L7AYh5ZHVuJ4qvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bJOADw/0h0cuSPCZDRxRcnXDM8KWlaMePxIIe+oLxI=;
 b=TKndyIaaRzOYqyXx3XNeoJL/CA1kiIUM0n59l1nX+15IgMG2W4ZPsacbE3kjC7bOq+w9Hhhbpfc3sASfNtUMzldvfPEJ56yKlC70tGAeJSVNZS5oM/Mv5WouxeVFF19SXJ8TXL501+eL5ALorRRt+ZcQUY7Or7LC2n8iyzb6KsI0hg7IuObc8JL8YTMJQLMZYAfGIAEE+PDRiyX0N+xjKQJf+7ctWqG+2UPP9DgZTw/m9R/+RZLnkzWuHi77V3ZKtMvjVzlz7kmyUGRp3xHZWJeYd62iA/TMJScCBTktXncmPRjLfiTmHPqXTjPTfQHtcrhvDfJ6xHeDSijVYI2/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bJOADw/0h0cuSPCZDRxRcnXDM8KWlaMePxIIe+oLxI=;
 b=VFoD/65HL/Fy46WaOf6RvjBWpfhjtCddDm2YnGsPqbQbA3VhoeXZ6RqrUyUqIzxvyuQydCJy97Kfo568ojidy/964JwZmUsqEjsemkUG/+AFWLL5YO5CVU4qyJAeyTk79+7MdOrYZVI4cgsxKdgckwpe8/tE5r5LbJSVZ4naWhM6LoZ84ZKEXlstNNYlqzzbgJJcQWmEK5cEi4ZcYmh/8tsLqyQOxKkWRM1drynybW9XucTRaBLKf1ltQEWeKwhQy582x7fTKUudhnWYy2Fd0iG13uYP8TiO4qs02xP2oW/2hJ5APhrCOhmK3a5juoy7fTbGpS6hVc0ize/H7cbWNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:34:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:34:00 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v7 0/4] gpu: nova-core: run unload sequence upon unbinding
Date: Fri, 29 May 2026 16:33:40 +0900
Message-Id: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QQU7EMAwF0KuMsiYodmK3ZcU9EIs0TplI0Ixai
 ECj3p10JERLWf5I78f2Vc1xSnFWD6ermmJJc8pjDc3dSYWzH1+iTlKzQoMECKzHXLz+GF+zF+0
 Mdr3tG+7IqCouUxzS563t6bnmc5rf8/R1Ky+wvv7fU0AbzZ6kRdtH6ORxLEmSvw/5Ta1FBX8wG
 4ewx1gxDpFcx9YPbX/Adotxj23FIBha6MWGePzZbXGzx67iCI5CEPGR+YDpFxPQHlPFwQkjGS/
 A5oB5g//uzOvBaKAW6uQYuh1eluUbXiGSOdgBAAA=
X-Change-ID: 20251216-nova-unload-4029b3b76950
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0228.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 943a8f01-744d-4b5b-1626-08debd54a683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: dlu09XyJPtPsWIyD3sGTJJ0HQN450ZX5Iu2FfiDOhKKzW53QdzI2ALxjsXL/xYNZEocP/Y94slJ6Fz5vftEw20PU+p0N1pMrNQYS1nxBZ3ImzJvQgjtCMl4tK9Y/DdSzqm4O5mZoPhJ28i0D6o2ifEhInO2KJdWUE95nCn2/fBfsBani9312MmtQbcfDD8nU4IIyKtIMSGwOISABLNvHii+DyFkFkCSoL5T2dcHUax5Q8oN2Jv3sc8lLE8L1cTGrrNeiUClxgiHURy5Xn/hcKUSEL03zbOKPuUM+Rgaxh7ARP5K0p/kSK0YwGHeVU+SSl1dCxGy0u0O7nNGo9YPC916SZtfiiDTxqTwUKhlbk9FOqHzHMGqPfwRwN7Mlpynz3oOcNyqGX6a7X7yX0ob1ik6LxEQKtlGWdoIra6339tfNp+5ru6Xxcpg3+hOTgYrU0s/lSUPCrQJzvRm6foZ3/wdK3u3mHqdaYyTbUapTUB7eIRS08tiiFkAHxk1W9fIm54jhmPNJr9t+hhek88+hWP5UXo8uGEc7cWbem/Uo3e6BnaThAvGH5HaXQfkUg++4G4rAtoPQI7IWiPgsmdQKsrb6epp1fCV2XPiDh492s5wTvxqMcIPjXHeSAPcKeqFV+9XaHXuBeH8/ozlGzRBnQw6TOMvK4CaIsp57UWZu2K53ZUCWPrmqySe47gpEYlv6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdZRlJXd2tqMGpJeGlUdHhQTDVlVkFOOUU4TWJidnc3WjdWUGw5S0F1VWVP?=
 =?utf-8?B?TlBtVFBhTmVTMWtNMTRRVEFLRjdpWGxBMVZ0L3NrZWl1d0pQclVDdFk5Ri9U?=
 =?utf-8?B?TkpDOUVWblUwMHV5RUtoZmxqNVk5MHBPcW9ROGZaRy9odytRL3FrUzBaSDhS?=
 =?utf-8?B?ekwxQnRmYVFFY2Z5UFdwc2ZuZ0RDQThrVk5EODBPVEQwcE9CdFliMDhUYThB?=
 =?utf-8?B?TUNkK0o1WFN6dVprZXIvNUswVmtncFhDV1VkU2FuSFd5OE53eFhTNGloWk5S?=
 =?utf-8?B?cDg0UnFaN1lsK0c2eS9DQThpTnpZR01PaTFHcHVqNFQxRGRvYTQ2eDZWb2hM?=
 =?utf-8?B?Q1JPLzRQTERya0tkQVp6NlZyU1JKUG5RQ0FDQ01iQnZpR1FJWXhNVVA2OGVV?=
 =?utf-8?B?QXROQVJtd0xxVWJPR3JDS25YRE9KS0lrSCtwV2hVSlNuWHRhbFpieE9ObDhV?=
 =?utf-8?B?Yk9nTEtXTnBHN0xXR1NaZHpMKzdRUmVMT3YyWVF0RzRPMDF6NHFnZzFZc3kz?=
 =?utf-8?B?bGdPeG5rOWNOUGpqWG9nWGxsbVRSWEU2K0ZMeVFQU0RvWGdKOXltbjlHZEMr?=
 =?utf-8?B?NFQwWGpWeGdNSXpGU1dIcUFqSFNCMTVYLzM3U0hIMFUyclVqNGVwV21TYlk5?=
 =?utf-8?B?MVVuYW9zR1N2UlpvazVNN3M5SzhObUZISW94aytzTUsrR0RtY2JRRWlzWUpY?=
 =?utf-8?B?NmNKM3JKOUdlN3lQNlJYZkJzV1Rsd0xKZXRpSytvVWhuakU0eTVLdEFGQWpW?=
 =?utf-8?B?SGZ3TyttcFVXbGh4QXdsWUVrV21yZUhEbmpiQzFkRGxLQ0E1NHZrSldKcjZE?=
 =?utf-8?B?NkZrMlFXelZYZUs4R2duNnkrcGlZdldMeXZ3NnhmUzkzVURVeE01Zld3c1o0?=
 =?utf-8?B?UjRsOVdVQW1sbHo3czBjV0h4cm5iQ2ZLZ0lmS01xWUVoUGF4anJxTnVBYTVh?=
 =?utf-8?B?MGZYTXY1d3QwTlVHN1haUVFtWTdxMmZBV0lTMGcycUFueEljS3RGWkJDZFpH?=
 =?utf-8?B?dnJmdHlPcUFtOFg1bytQSW5BY3ZxNnpWNFROUmZNc0pJSkUvOEd3UFpmdlVW?=
 =?utf-8?B?MVVPSTNVT0JIZjkwRFhiMi9IN3crQVhWTlAvbWMyR2hUR3d2L3JkbmhsdmFt?=
 =?utf-8?B?bk9hYjRwdHI1QWppQ1BuemxYRUNiVy93V2xwUWh2dzhVcFlYcmE4L1FlRVF0?=
 =?utf-8?B?dGt4TnNmOGJ5SThWKzFtdHgvNGJhSWV2bkZNcTJ3K1JRd3lhM3JTMGhkc3l4?=
 =?utf-8?B?Z2tOWDBhRHVIRlJ3NlVoNTV3ZHhjYm5NT2NGbXR0ZXVDeFVOYk1MLzJINDdt?=
 =?utf-8?B?UXp1emw0ZFo4dDViL2FJdmVlRjBCOTJPM0hWOStGRkxUQ25WRnFFcVptTXFj?=
 =?utf-8?B?eldFbk9CUStIdXNPbGI3bU5FZmZXbjBlQ2ErUVJOL3QvWGk4bmRHbE81eERP?=
 =?utf-8?B?cHV1ZC9mUkJKUnFNQzNqeEtyOTNmZDF5WTJ4QjRWU2VxbkJ4VEdqTjJIY0lm?=
 =?utf-8?B?d0EvVk9qUGdXVkI2ZHFIRVRlSkl2TmVVTDZydFpEbTU5amx1NWtoNnlwL1lU?=
 =?utf-8?B?SjRJM1kzQnZhUHI4U2FDcVhacldHSVJBR3pzQ1EvYW1CSFBhRkV3bDFCaVkw?=
 =?utf-8?B?UWtzcVhtbEx1RUJRbHhnNGFZUjROQUR0RklmQVAxNjE5TFp3OWpzemU0V3dC?=
 =?utf-8?B?ZEtJVi9iTUx1VEtBdGJEbHByYlIrNDNMcDlOWW0yYzJ2VkgxMk5HVS9EWThJ?=
 =?utf-8?B?RzVuRitlQ05KY3pySHNsVkJUUStzUnMyeVFLYXpVcVFkZ2tTYy9sN0JGRHpp?=
 =?utf-8?B?QThhcmNWRVVweFhkRXAwejAvOXVCa1FVVFhuRUYzdkNTRlNoZ1g5azc0NjJ4?=
 =?utf-8?B?c1owSkxmTURlOFppQVdzVmhBa3RCS2NVdGV3TFdRNnVhcUpjWHdmdURPK0Zk?=
 =?utf-8?B?WDEwSEo2aktvSFNTcG0vdmFRbDJ1bW9hUGRzL0JaQmtTQXhBZnpyVkQ1WWcy?=
 =?utf-8?B?OU8zRHVGZWw2ckp3K2NkdG9JdCtBdWV5VlI1NVczVEZJZkhqcndVbm9JSGVp?=
 =?utf-8?B?VW5mWXR2bGxhK3R0Vy9CdTdMVmdJNWVqQzlmU0VJV3BKVzZ5eWttUzFUcFNM?=
 =?utf-8?B?eHhKd2JKZzB0Ty9lNUdBNHpob2Z0Nmc4T05JaEFDTUl0RWZReWY5KzhzOGFK?=
 =?utf-8?B?cU44cFlOT1p3Qk1VZ3c4UjN2VkNZRkp6ZTdoNkxJVTAzTjZNdDNZck94MUJ6?=
 =?utf-8?B?M0tpaUVPdy85L3lTWkprYTRBWXJmUlpNK3Rkb0NBMmpVTHpCUFdZcWdZNmFn?=
 =?utf-8?B?ck04WDROM09EbGZiUEJnRllFMVFmaUdHSCtsZG0rV3YyUjhRR1BRNndZWHRO?=
 =?utf-8?Q?mokOkMZFEtaqBSjc34MtZRia6oEKoTT5qnDlOI7KDIbfs?=
X-MS-Exchange-AntiSpam-MessageData-1: 3YRPj0t6VvYDhg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943a8f01-744d-4b5b-1626-08debd54a683
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:34:00.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyIxzo0XzwK8OOpRzwQJyHOzZc4Ew/TCUNHZeqlAPzBtarGf520diNtnx+U0lGEPc1IYfT+N8VxgLMZMa5ppwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Currently the GSP is left running and the WPR2 memory region untouched
when the driver is unbound. This is obviously not ideal for at least two
reasons:

- Probing requires setting up the WPR2 region, which cannot be done if
  there is already one in place. Hence the current requirement to reset
  the GPU (using e.g. `echo 1 >/sys/bus/pci/devices/.../reset`) before
  the driver can be probed again after removal.
- The running GSP may still attempt to access shared memory regions
  which the kernel might recycle.

On top of that, there is a nasty bug in the Blackwell VBIOS that
sometimes borks the GPU upon PCI reset, requiring a reboot. So relying
on the PCI reset to unload/reload Nova is really not practical here.

This series does what is needed to leave the GPU in a clean state after
unbind, for all currently supported GPUs. Blackwell support is just a
placeholder and will be completed by the Blackwell boot support series.

This revision is based on `drm-rust-next`.

A branch with the series is available at [1].

[1] https://github.com/Gnurou/linux/tree/b4/nova-unload

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v7:
- Rebase on current drm-rust-next.
- Drop merged patches.
- Integrate Eliot's unload-on-drop improvement.
- Use `&Gsp` instead of `Pin<&mut Gsp>` in HAL.
- Add a new patch that runs the unload bundle if `Gsp::boot` fails.
- Link to v6: https://patch.msgid.link/20260521-nova-unload-v6-0-65f581c812c9@nvidia.com

Changes in v6:
- Inline TU102 local `run_booter` method in its unique call site.
- Rename unload bundle field to `unload_bundle`.
- Make Sec2UnloadBundle private.
- Continue GSP teardown upon partial failure.
- Store the unload bundle into `NovaCore`.
- Take the unload bundle by value to make it one-shot.
- Link to v5: https://patch.msgid.link/20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com

Changes in v5:
- Rebase on top of the Device HRT series.
- Drop the now unneeded "gpu: nova-core: split BAR acquisition in unbind()".
- Link to v4: https://patch.msgid.link/20260427-nova-unload-v4-0-e145ccddae66@nvidia.com

Changes in v4:
- Remove `warn_on_err` macro as it isn't performing as expected and
  distracts from the goal of the series.
- Add John's patch from the Blackwell series refactoring the Booter
  Loader runner code.
- Add a GSP HAL and move the existing TU102/SEC2 boot sequence into it
  in preparation for the Hopper/Blackwell FSP boot path.
- Prepare the firmware required for unloading at probe time and save it
  into an unload bundle, as we cannot guarantee filesystem access at
  unload time.
- Constrain `UNLOADING_GUEST_DRIVER`'s visibility to the parent module.
- Also write the sentinel value `0xff` into `mbox1` when running Booter
  Unloader to align with OpenRM.
- Link to v3: https://patch.msgid.link/20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com

Changes in v3:
- Disambiguate doccomment for `warn_on_err`.
- Test the correct bit instead of the whole register value to determine
  that the GSP has stopped.
- Use an enum instead of a boolean to encode the power level when
  shutting down the GSP.
- Add missing newline to `dev_err`.
- Add missing doccomments for new types.
- Use values from bindings instead of magic numbers.
- Remove the redundant `get_gsp_info` function.
- Better document Booter Unloader mailbox sentinel value, and check the
  value of mbox0 upon return.
- Link to v2: https://patch.msgid.link/20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com

Changes in v2:
- Rebase on top of `master` and remove unneeded/obsolete preparatory patches.
- Tidy up the imports of commands from the `fw` module in the `gsp` module.
- Link to v1: https://patch.msgid.link/20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com

---
Alexandre Courbot (4):
      gpu: nova-core: gsp: move chipset-specific parts of the boot process into a HAL
      gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloading
      gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
      gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails

 drivers/gpu/nova-core/firmware/booter.rs          |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs           |   1 -
 drivers/gpu/nova-core/gpu.rs                      |  34 ++-
 drivers/gpu/nova-core/gsp.rs                      |   4 +
 drivers/gpu/nova-core/gsp/boot.rs                 | 290 +++++++++---------
 drivers/gpu/nova-core/gsp/commands.rs             |  43 +++
 drivers/gpu/nova-core/gsp/fw.rs                   |   4 +
 drivers/gpu/nova-core/gsp/fw/commands.rs          |  45 +++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  11 +
 drivers/gpu/nova-core/gsp/hal.rs                  |  94 ++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs            |  51 ++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs            | 349 ++++++++++++++++++++++
 drivers/gpu/nova-core/regs.rs                     |   5 +
 13 files changed, 775 insertions(+), 157 deletions(-)
---
base-commit: 0e42ec83d46ab8877d38d37493328ed7d1a24de8
change-id: 20251216-nova-unload-4029b3b76950

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

