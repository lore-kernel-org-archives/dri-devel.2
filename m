Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E36606A800
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jPSmbn+c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA2F10E502;
	Sat,  7 Nov 2026 00:39:46 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8457D10E502
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 00:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQq3SJJB4OePUDX1m9Ho7IcF8f+ccwLtEatoND2WeDoxQlf3konUbsjgI+w+xVQFQV+95O6itHKDPJIEI99XzbkLIUuRS4tyfHnlnsDAKkGgLSWLS/X6woFprysISf+Qqoj4swopXnR0dKHq3TXHpiUZTSreAcu8o4egmxVYFHxfc84NCfVvTjQLkpn8U+AzaEaUz8Ggj3Zm/crd9o6V2gyt7fA+XRm9J3Nu3OATb0+agyhO1q3WnY2JVilzICMrLxFduHX4+WDWvuNNynm8Uy+6mIEAbgcbScnMvwsAIShTKiXeaGo+KXXumMssqIeLxSsH5TxCfT8HewdShzysTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1qe+Ai+Cjg9nPrR5ZL/qLniQ+zYp17ei2DAbjmh7DE=;
 b=gtvaXKFYYe6bbpiTODaNZtzhEiICojarclk2WYKnPsUEealuwKRAH0XYhbowY85ytQ2mXPi06pjARfrRiwcHRqbYsgRU+jpleFOQ0XL9eWg3XXorJ43sMEIPk8+RHDOIS5QE2TPvWVA3m54jTy2QtKb0HC4eJnkgyC4gH9Oq38d3EuETrgDVhuBX+PsjzrAQKDe9CiVLW94ENkex1PTYHp1X7MkFVf0peDeWAzgoCzaU+mU4EaKYqrBo5C2dZKg54WLakW136yzPICAa0lLY+HE4jOfPRaJWT3mgaQrY+B7YDnzuz2TN7YLyNAaOdAROSYk4/HBq39cMZ0whhKV4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1qe+Ai+Cjg9nPrR5ZL/qLniQ+zYp17ei2DAbjmh7DE=;
 b=jPSmbn+cxE7uNNW0cGykKuJlEMx8Iv1d9ZbKoGhgK2VVmOip6idwYa9BPrcgwyEsnfkeDFwCrWaGtPUZx/emrnR/40UloTZxOiGK83keVpu1GKpAhs1Q8mu/FWBEMbZ2ckJqWj3wlXXbYWO9FmuwsZdEUdu5cux0PsoTdD3lFRcqpyWW0XxPdKhlD34mf26brAHW4NNYkY+0cn1czEQR8LcDlVGBitDILgremo4mCypLmVzwD0ujfT55/zJZAFPwblrMT/GaToOyxNfm5YjZZgDMxQHVGMKEpRgW8ZwCzphthNevUQ4T+3SA6ai/ciiVzwJbfmeTgJa7gCNkyP4RPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 00:39:33 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 00:39:33 +0000
Message-ID: <ce4c6b64-98ff-4b50-8454-9cdb5aa6970e@nvidia.com>
Date: Fri, 6 Nov 2026 16:39:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
To: Vladislav Zaharov <vladazaharova2018@gmail.com>, dakr@kernel.org
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261014154554.231015-1-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: b458a80f-383e-4f2d-41b5-08df3c6797cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|5023799004|11063799006|261021121427099003|56012099006|261022115727099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 8+7hcUU1XVna4I5x/uzpC8KaFbvSdmf82c90zP/KN29ZZSYfIgv9N8zJVKmESX435vtiXUP6ldWtBoALTV37fR/7fuekmYuh+IEZR27Gj7lNm1dzH0/yPUiXAYzefhrXuYvymXVCjgF21cjRdRpbOHOvBFzA5dN2HAd9J9o2p/e64Se/nTvzKoLTAtKdaLYYMdx98wP6iJin9TVsvzl+zqa4xOyvkxab5kLzML84b4MiWA3lNNl0mXFT9YsNM79WGlqsC3kFSPLwHjhOE3licnLQ7ewwaLF3G28Bwy7jivjELmf4LXVrBWKSYw/HirbGiFam7MO2Me3gVABvbGOXBsonJS9jsXa8MVusPtkDFIT6P9eCZMxQAFSJ7YSenYvo4hOp77g41Y2nsNGMf1rQ4S2M79V9iFcjl6eootlMFDpAojDNdfOVzKtZJzf3lfmQg3OhpWE5HCePKH8Pw+RV+Jxmg8CQdfzpvHJa5iP1Q72l0NPWsWqEXiDN6uttxnXv1TOCN7jSexnIGjkiW6WSqwNw3H9ijVoxbiIOuE/CjBeqyPtI7kafoNW/4bXDC4ByawrFwcZXgXhQ43b5ULBg3TiKU0pbtsoNY1piAeNap4bliE7vGw9P/8TED/d0Vu0+9KKWrxZGOLvGHtrpy7SV4KftS843knFkTmXSd1OM9z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(11063799006)(261021121427099003)(56012099006)(261022115727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEdPaFlqRUE5Y0IrTHNycVdDVGNBTVJ0OFpjUkp2Y24rNHYwMnd5RFFLVnhj?=
 =?utf-8?B?dmdJNUZ1VVNucXdnL2RjTTZRUzUzeGpsSjRzbkNOOFdPZ01QcjMreHBoSjIw?=
 =?utf-8?B?dXhaNHpaVk5paERXU3UvRys4a2lYRE1McS94emtqbWZZWlRwQnBCWXgvR2Uz?=
 =?utf-8?B?ZW5TTUFXVkVSWXo2R3lDS3E1eTMxT0lWb2lHRDF6NHRSWFJheUJTbkYyZ2VV?=
 =?utf-8?B?S1pPWFZHWmJ3dzhHdXJxU1kvTGVvRzRiMlRYUms5emVGN3dIT0lOTDZtemll?=
 =?utf-8?B?T0w3Vkc2VEU1MStBdytaNG5IVkdpTXExR0FEcEVEZCtRRkFjb3Y1SDRPZmdy?=
 =?utf-8?B?OHQwYlN2WjExN2V5NngyUlZaZ3RjM0lBeHA2Ym5sTlErcy9zeTRrSTVzYzEy?=
 =?utf-8?B?bXR5bVZWOWtBcUpiZUUzeGRycllZMCtBdzErbDAyMThkMFAraHdqNkNaMCtj?=
 =?utf-8?B?QnBsQ2FKWm9YTC9oYXl4dE84ZXd4ZURneVJoTFkwT2pwZTlObUJrVTVoMGFB?=
 =?utf-8?B?QUpEY2VjejQrekNqZDV6eFU5VlZQSlVzckFLempUZ1hVQ1daWEY2bDg5cGZU?=
 =?utf-8?B?VEI3RENERVFDYjhIS2MyNDVEcW5aZHJYZm5jL20zQmNKZ3VoVHJ6bTZJbVZ0?=
 =?utf-8?B?UEd5UExNb1VaN2IvUTVNay9JSkFiaWQ1Q25ER2JCeWMxNmFGd1Z6SytWUEw0?=
 =?utf-8?B?aGtPYXE4VFh6VmJSaW50R1J6eGFwTFNqL3lsbmE4QUhHZEJ0N1p5WUN0L2Qw?=
 =?utf-8?B?c1lWbUNiYm1LaDZzNUNZSUxORDVIQXM4VWZpTFRWd25OR2lPWVFHS3pqTjZQ?=
 =?utf-8?B?a1UvWGVnczc2ZG9qRy9BaXhZUkFuY2RYcFJzemZkMUZBdGNwbWVZd0FhNEJq?=
 =?utf-8?B?OFpiN3NuYlQ2YzBtNzFHaGNFem9iS2VsRkdNZ1lqUXFFSnFQOEU3ZzF0TW1Q?=
 =?utf-8?B?N3Q1TEdBelFodEFXWkRCYlNKWlZTMmVZZFc2K1lyanFmQThqWUxScHcvMkZ5?=
 =?utf-8?B?bmNCVWhQWFhaOG0zOGRjaEFPQUVnYXFaSE1POFduOW1mYlUyV1crMmtRVm42?=
 =?utf-8?B?WmR1YXpTY1hMNnAzdjdTdjRsUnhhSVd6dytnclFKdHZtNGs1M2x0V3gzYk1B?=
 =?utf-8?B?T3hwaG80bmxsb0xoQUhDSjJoeUhJdThObVp3VjRtNWZwb29uOGJXbllRejg0?=
 =?utf-8?B?NHZPVGhuVVdXTS9PeStKVnlRT0pERWJOb2FjTHh5M3JORnBVa2llaVdTMklW?=
 =?utf-8?B?ajNRMW12c0p0MEZHLzh1Mkt5ejhRQThCY2FxaVJoSXFHeWlXYVRvSm1nQ3Er?=
 =?utf-8?B?R3FzK0FYMk43cjZ4dUlKZ0xPdk5PaXVUVjRMUC9FR2dPVlVlQzNZV0x3YVlj?=
 =?utf-8?B?ZEpObE45SXl1RU5FUEVydkxPa1ord3NyQTZvVk5ROGZXeGhlS2VXL1QyWTFt?=
 =?utf-8?B?OFpDSDZURC8rMDBvWDAxUXo1WXlNSW13M0hoV0l3V01YTTIyWkhxMUNwdkFG?=
 =?utf-8?B?NWttMGJicEd5ZFBUdU9RZGtrNllac3l2RVI2OTJHYlAwY0hwbzZlOUxPL2Ny?=
 =?utf-8?B?UGUzenUyWk8rLzBMV3NCWWRRUkhxYnpGMlYzcDFzai94Wjg3TXNGWEc2dmVK?=
 =?utf-8?B?V0VadW5vNHpTMnlJcmxNQ0xhMjhTZ3NaSC85VUZRcS9Ma0FnRFA0RnBzWUZo?=
 =?utf-8?B?YkU3VGpNdkJwQzh1K211cEhpbTB2bmpyUUdZcE1scTlwdzcvSHpPRkJ0S3ZD?=
 =?utf-8?B?VFBlNWs2SGZDcnZDSjkzZHh1SkVvd2V0dStmVG5FRkUvSFlxSUFRVnd5YkxF?=
 =?utf-8?B?UXJTMFFIQ2EwS1I2N3lUMVNHQjRPVTRaM2x3NVRkR1dDRFdqaXFBdFdyU0Rj?=
 =?utf-8?B?clJyV2pleTZrMllDdFhzMThabEI3OTdnc0I3UHpZc2RQaE4zcWtXYndhblRK?=
 =?utf-8?B?OC83ZGw3ajVMcGdlUXllSFU1RGc4VEJQVHlLM1krRTNBa0pFK2ZGMFZsbHJ2?=
 =?utf-8?B?NVlrSnU5eWR4V0o4TlpCME1Rc29DdHF6dUtBcHNxYW94V1RLWklsbUFHNkdw?=
 =?utf-8?B?NmtHQzZuTWxlKzc4aFFTa1A5b0FFTUNaQm9GRFNhMmsyYU1ZcDEzbzFwRm1S?=
 =?utf-8?B?OC9BQUZpTFBWK3ZVSGxxbnNBUG5uck9jdjRiWDNNZjNGMzlRWTJjOGR6cVFO?=
 =?utf-8?B?UFVneGVNazJweVhTdTN1dnQxNStNa0lFa01YNmFYOHRldkRaY1FEanpyYjlT?=
 =?utf-8?B?K1VjU3V3Y3dmdnZIb2w4Nm1PaEt2RHRVRHREWXV4cXB2Q2xicytHWTIyNlUv?=
 =?utf-8?B?MzFrdHlyY1pmOThFNTUyczdnNmNadEZiT2dDR2JMZHdwQWpSazA5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b458a80f-383e-4f2d-41b5-08df3c6797cb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:39:33.7655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdVngfuhmxw9WmnOWaTSFAnPdwaHdbcSBVtN9Dby7FAzIs5vkCJz8SWQjMviVc7AnMPe3gaV2m8/ys2e0dacvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 8:45 AM, Vladislav Zaharov wrote:
> The GSP-RM log buffers are exposed through debugfs, but they are DMA
> allocations of the device, so they go away as soon as the GPU is unbound,
> and in particular when probe() fails. That is the case todo.rst asks
> about, and the one where a GSP log is most useful.
> 
> Patch 1 moves the debugfs root into the module data. Patch 2 adds a
> gsp_keep_logs module parameter: when it is set, whatever the GSP wrote
> is copied into module memory and kept under a "retained" directory until
> the module is unloaded. Patch 3 drops the completed item from todo.rst.
> 
> v5 got no comments, so this version only carries one fix and a rebase.
> 
> Changes since v5:
>  - keep the "put" pointer read before the barrier in the copy, rather
>    than the one the copy reads again, which is not ordered against the
>    rest of the data (reported by the Sashiko review bot)
>  - rebase onto current drm-rust-next
> 
> Tested on a GB203 on top of drm-rust-next with the TLV firmware images:
> 
>   - without gsp_keep_logs nothing changes, and no "retained" directory
>     is created;
>   - with gsp_keep_logs=1, retained/<BDF>/{loginit,logintr,logrm} hold
>     the full 64 KiB of each buffer after unbind;

Although this "works", it has a significant usability issue that I think
we need not accept. We should fix it instead.

Specifically, (as you mention above), I had to add "retained/" to the
directory path in order to retrieve the logs. That is awkward, because
that means that if I ask for gsp_keep_logs=1, now I have to know/remember
that they are in:

    /sys/kernel/debug/nova-core/retained/<BDF>/

instead of:

    /sys/kernel/debug/nova-core/<BDF>

We should try hard to avoid such complications, especially given that
debugging is often done when one has a thousand other complicated things
going on at the same time, late at night, too.

I did a very quick LLM-powered fix on top of your series, and it seems to
work just fine without the "retained/" subdir.

Can you please do that? I can look more closely and provide details and/or
help, if necessary, I have the PoC diffs here.

Let me know how I can help.

thanks,
-- 
John Hubbard


>   - binding again does not disturb the copies, and a second unbind
>     replaces them, leaving one set;
>   - with a failure injected after the GSP has booted, probe() fails with
>     -EINVAL and the logs of that attempt are still readable;
>   - with a failure injected into the driver registration, the module
>     fails to load, leaves no debugfs directory behind, and the next load
>     works;
>   - repeated load/unload cycles leave nothing behind.
> 
> No warnings or oopses in dmesg. Each patch builds on its own, and the
> series is clean with CLIPPY=1, rustfmtcheck and checkpatch --strict
> (apart from the MAINTAINERS note for the new file, which is already
> covered by "F: drivers/gpu/nova-core/").
> 
> v5: https://lore.kernel.org/nova-gpu/20260923045551.229259-1-vladazaharova2018@gmail.com/
> 
> Vladislav Zaharov (3):
>   gpu: nova-core: move the debugfs root into the module data
>   gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
>   Documentation: nova: remove completed GSP log buffer task
> 
>  Documentation/gpu/nova/core/todo.rst   |  12 --
>  drivers/gpu/nova-core/gsp.rs           | 100 ++--------
>  drivers/gpu/nova-core/gsp/logbuffer.rs | 255 +++++++++++++++++++++++++
>  drivers/gpu/nova-core/nova_core.rs     | 101 ++++++++--
>  4 files changed, 356 insertions(+), 112 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs
> 
> 
> base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025


