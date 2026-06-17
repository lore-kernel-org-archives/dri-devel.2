Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23698CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E2E10EA26;
	Wed, 17 Jun 2026 14:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNEiYOlz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC1410EA26
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tU71oW6kcjFOEpq0Dwx/QK3r+s4NXGR3ehWBBUP+YjpEbXWlqB7ko5kL5Z10wq+jsr4E8BEbDlfaDreFJ+BEgo0Q+18oNsN6YJN/zTYde+Q7ZuKLRrwY164oeaNYcF+IyNk0RAKas34xbK/D4+t/GYIoo9y2wxcZKeLpVAZIeyTOyUaonHa5QlcfYdPpKgt6lW8nEfxA1UakYQCcQcumdH1e6yxjNV4npcJwsG2W/nmzkrbAirM3rN8VpoXK7zYo6Wng/JniZERt/hiEaOyrei+MhL2qkigrNlq58LNdG2FNOx9tjXtVhYFF2WXPDJjt0Otrz/wSUpUkEQYJpmnsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxXy41+x0+p+60/75Bqxjd1aZ5aS4AVcw+NLV5zZenI=;
 b=j14V/HWbHo65iLLGy3AjDJ9qaESaB1F9xWpWyBOD+3H7FkWYUcI4DeY/Ykbfi4jVX5asD283GiUv0wLIA5l+xhpHM0UpSj+JQJyBvOpdGGa3Y2ruRGom/EGkWuDh0R2fQAbKD8noThyXiIktOD1f33j1OnarLw9yr14SAilaPB4FJUuH5JKImsQRKLqGEiA3BL+p+CcPdA2rsOxActQL0LPUyLSbTXi7NcEm3rEqscZZhjDbn06RItQX5KxhLrb3yrUdX4cszeslatxJFNQAuOlhlXkRQFYSNIJIoswyNtrUEaI1hDNsofYdLpKWAq++5xiaZChVxu4ZKnDNUUPaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxXy41+x0+p+60/75Bqxjd1aZ5aS4AVcw+NLV5zZenI=;
 b=QNEiYOlzNaC4CAUz24G4QeOhDJce82Hz5sCBx3+JXJW+bADgTJ1eWqT9buQSafobtJCtach7hVqaP9KmqzxapeX2YlclAAf713+b6cYciG6jlfeMTK7kR45Sj3EtDwrIaQ2L5xQAMpEbA4MCBFHAOJPuxS6+ZCH0pC3vNFPJ+Maun27Ub9TEpkjYr+IP9gWGgDNISVtxRKLr99skKSzWgVg5Nad6E1WBRuKnDK2i610wfF9JmcOPyXUnITL9VvzOcDST6cJgmaFIBS0jdgo8Pr6Yw2LxABQZ94jtLWddFif/kCixZqyz+oWzZrKhB0Rd1VjJtRHyVeZL/NwWJeh3dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:28:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:28:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 23:27:57 +0900
Message-Id: <DJBE8G5OR03O.1EDH7JL21U88A@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 09/13] gpu: nova-core: wait for FSP boot earlier
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-9-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-9-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: OSTP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:227::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2590f64a-acac-4114-23fd-08decc7ca2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uXP6YDNKnX/lR47b83jjOvefIREX1uzAltVAIY6GWm6Dt33CQrZKHzhPTaBQxttlNG4YI7BzmOeFVw5JzNgySQwsuTkOfGXsH7h/NS5UF9pRR5E4prJb2QpPmXis0t/rL6q5WdoD8wOjaelRo7UhyjzaewSP93BYSjIFkgdv/0Z50y4SVpyfSR8uiQr8w9it5R67L3XRcfXnr3Er7WhIdaza1wYm/kbXmk++Tco9/9omorYPUFee3fKt0k7KguWZcAkxmFB0GDfgQqnfsftVCsQV2j2Uz0W7x2QGT7NtuhzzAVxdQ8tDM5YFpEmo+PZXyQ14Q+gJLhDtnZg9PLm7VvQcgGTMYZWpBHxbFaXdeFxhbmIAbHH5dulN/iSfHbNs12GFnsINSCsGH2ZOqSKshs28r+GgmNKTRKeg8pnuApEw6gKXqdVJZ2ElnmUODhzBQH3nesr9ojfvdDttoRHBpqZTkAF5cuV31sXlfUDOVLbLueBxuLgjPn6Zc0wzNleNk4b/C6HbqyXZ/0RZfiHOZWepSrxv1/odoOgN+OhKjVpwQ9xGzsectskVhrFqxuPQ83zkHr30D22farCTW+nqr2UZbQg7Q5pGjeJ6u0f8N1j7yjZscrc2ZaHz9p8trVY7nB8Tw5X3NhyPDaRnc16kFVcT77tQT1xPU56Bg4VSf/XG/01IlV2TuEgmS8pdgRlr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZENTRm4rNklHZUNXK1FocW9rRWt4ZmFpNnZwTit3djdORExnMVQ5aHZhalhk?=
 =?utf-8?B?WUkyTVRLWW14b3g1YVRmQi91RnJ0RGlsNHFWRFVBL2c1RnhjZTdmRmQ0V0dK?=
 =?utf-8?B?b1hNRzdjeFo5KzZkb3dkclZaTFNwbWl2TlRCVU92WHROL1g5cDRWVHFtN0dm?=
 =?utf-8?B?bG8vRG5WZGhrS0ZFWWxMdEdYdWxvZGZQWSs3L2dycThrV1dvT0ZoREpaMzV3?=
 =?utf-8?B?SSt3NU5jSGFuV0RzVDdXMm0rME1GME9TMUs3ZWh1SzFFVCtUK1FKcEtjMEdT?=
 =?utf-8?B?S1kzOHJPemp4NFcvZ2lYdzIzOEpvaUFudkFQQ3JNUURPdDBuVmhDWllYdEFF?=
 =?utf-8?B?WGhsS1F6VllvTmprYTZWVDZvZ2huZWVpSFczemVUTFhZVjVIT1JUMWZVaGF4?=
 =?utf-8?B?ZGxBSmxOZlNOVHA0Z0pSd2VpQTNvRDRzS0dybEZsRjQzcEUvaktkRVVJS2Q4?=
 =?utf-8?B?OTJwbUIrZUVRejZEM0Y3bFVXeFEyaURJNGtvb3U5RGM1akdZZTRjeUt6aGRz?=
 =?utf-8?B?RUdNZk1QK1JmZ05VSUI1azZxeEt3THdMMkRhQm50VVB5alhldnM0M29kZ1RQ?=
 =?utf-8?B?Sy9xMi9HOUZCd2ZqT3llNVl2eThFSllxKzhxZm5jczNRWUUzWHcxdGp3bi9v?=
 =?utf-8?B?K0cyQXRaY3lSc3hjYlVuM3V5Y3ROZ0NvakNDM0RIbFE0eklNSlJJZDZPdXhD?=
 =?utf-8?B?YVdjUHhIalF1Z1JISFI5YytSQ3hTY3QwVi9HSjU2V20rUEtTbk1mUWFpbmtG?=
 =?utf-8?B?UHRKd093cUJWOGlKbk83NzdHSWJneDJYUmNVcDR0bC9leVJxdFNramh0dmkw?=
 =?utf-8?B?VVl5UTdiQzR4RUNwY3dTMjllU3hqWmliOVdvMUlmL2JqMkRLaHBqYUMyNzl5?=
 =?utf-8?B?dUtsSnNVck9xMkV0a0hnRy9uNUpjdTkxc0YvcTlIVE45U0Q5NzZmalFra090?=
 =?utf-8?B?RmtvYTRvOWg0SVAwZWlwNEJYTTRKdUdPVit1R0k3WS9xeGcrNlBrbUFjM2F4?=
 =?utf-8?B?SiszRHZpZlpuUDVzTzRoNnVDdVVpSlhrbFEwSkVYQ2gzV3RFa25wUEFWMTB2?=
 =?utf-8?B?bWx5RGhETGFCSkNaMDBMQ2ZEMUN6aUNCb0piNHU4a2JQa21KY0FlWGNRNGpZ?=
 =?utf-8?B?Q1JreG1iRzk2c3RJTHhKbGFPWmhnN2c1MDh1VXVpeU4zQitwaFg5TFNBeWs0?=
 =?utf-8?B?a2Y3YnkycHBMWGFCaTRqL0d4U09wdFl2VVM1UUZiWjlpZk1kNy9EWldWcG5V?=
 =?utf-8?B?anpac0tIOG5GNEJ0N0dYdXQycTVITU91KzVDRk90QlpwL3JMendYYTZkYlRS?=
 =?utf-8?B?Y08xemVCTjBHajdFRDlVd2MwbGFLcExYcGNFdUdUV1Exb0NXcVhaZlQyWmN1?=
 =?utf-8?B?YnVtTy9KWDIzRG9CUDFYbTZSazNwMEsxTDQ0SEdUMG1LK29lbEh6bHl6bFNL?=
 =?utf-8?B?aXNGdU1XbDV2YUlHL09pTXVRMkdTTkxtQ01yRVliVlFpK3RXaFJDOGtFRmZs?=
 =?utf-8?B?Zk1QTzVMVFV4NTNzdzRmR3haYjRWWGJHNjdwZFk2Zm1TM3FZZldFR0diUWR1?=
 =?utf-8?B?cDVQSmtBNTJ1bGRqZnJzb2xhMWJ5Zmd1SEoyRUtqeTRyMEF3VktoeXhsWU9J?=
 =?utf-8?B?THlMUkhBemk2aWt2MlFGak5xSHZXTWdtWDA5K0NNMHEzVEdtNU5LQWszWXp4?=
 =?utf-8?B?TUlhMk56VXFFRFBPVE1VU1hDK2pVaEZ2ellpMkVvQ21HbE9MalRmNlkvbFBl?=
 =?utf-8?B?QVdnZlIvWDZXVUpBell5SysvNnJSQ2hvazVwdStHUVpMdURZUmxjTmZMcGVt?=
 =?utf-8?B?WTBZQ1lkenZSc3dHR1JTaXBKdVJxOEcrcDUvNGd3QTlvUFN2RzZrV0hqL0xU?=
 =?utf-8?B?MmZKaE5wZDZGeEIwaU5RMUE2QmtGNmc5OEpMQWk5VEp6Yzk1ZjMwN1NSUTFK?=
 =?utf-8?B?TUlsOFpmcGpQSEhZa2ljSmNGVmMvaFVJRFBBUGhPeElaMVB4QWsrTGdnajRi?=
 =?utf-8?B?UEJjZVRjaEpWSDdDY2hDZUZjZjZ3eEx4ZENYd0o2dWwxZmlEZ0ljZFNRVVNV?=
 =?utf-8?B?RmVtbzhiay9hMFF4TDV4WXFIbFcxdG5WMFdxRTV6R21UNTRpU0dTNUYwTE82?=
 =?utf-8?B?aXV2VCt5dWxEN1pPdnR2d0lyMHlWaE5tWTNNbXBmUUdndGlEMnJ0S3duNmZW?=
 =?utf-8?B?aXZTUUx2RVpTRzhYaWw3TnJqZGV4ejdKMHIvczBKQy83Q3k3aDltYnEzNFlP?=
 =?utf-8?B?QUs5bHhVLzhvd3Y4SHQ1UGxnM2lBVU9rMHNEWGdHdFZZZGw5ZWFmWWN3OUo1?=
 =?utf-8?B?UmVpOHJZdWlTcE9rdi8xbU50M2hWeGcwdE85MTlJMzZOVmZKNXdWYSt6L2dT?=
 =?utf-8?Q?mnG6W4gzU4zK1kNEnZxkfYbQO7DwU/LjHhammCxnADGnn?=
X-MS-Exchange-AntiSpam-MessageData-1: bml2PherkPiSwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2590f64a-acac-4114-23fd-08decc7ca2c5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:28:01.4025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNMA5h28zyoCmIe1sKRBWnaRchZIMJfDVM4JxvYEB7OUjPh3dw2eUCfNKUoHpVPcgqP4vLaf50VOWVTL2DQKEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
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

On Mon Jun 15, 2026 at 11:40 PM JST, Eliot Courtney wrote:
> For GPU architectures that use FSP CoT boot, ensure that FSP itself is
> booted before trying to use it. In particular, accessing registers like
> `NV_USABLE_FB_SIZE_IN_MB` for `FbHal::vidmem_size` should happen after
> FSP is booted. Currently, we wait for FSP boot too late. So, move this
> wait to a new preboot phase.

Can you give a source for why `NV_USABLE_FB_SIZE_IN_MB` depends on the
FSP?

<...>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index b3c91731db45..ca37892c3b38 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -295,7 +295,8 @@ pub(crate) fn new(
>                  dev_info!(pdev,"NVIDIA ({})\n", spec);
>              })?,
> =20
> -            // We must wait for GFW_BOOT completion before doing any sig=
nificant setup on the GPU.
> +            // We must wait for some architecture specific setup to comp=
lete before doing any
> +            // significant setup on the GPU.
>              _: {
>                  let hal =3D hal::gpu_hal(spec.chipset);
>                  let dma_mask =3D hal.dma_mask();
> @@ -304,8 +305,8 @@ pub(crate) fn new(
>                  // still constructing it, so no concurrent DMA allocatio=
ns can exist.
>                  unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
> =20
> -                hal.wait_gfw_boot_completion(bar)
> -                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not co=
mplete\n"))?;
> +                hal.wait_preboot_completion(bar, spec.chipset)
> +                    .inspect_err(|_| dev_err!(pdev, "preboot firmware di=
d not complete\n"))?;

It seems like there is going to be a need to make the `Fsp` available at
the `Gpu` level to support the vGPU needs [1].

So I guess the solution here will be to just instanciate the `Fsp` as we
do for e.g. the falcons if we are on Hopper+. Hopefully that will also
achieve what this patch intends to do.

[1] https://lore.kernel.org/all/DJAZRULU1QHZ.2NSTR1ZPOQUSN@nvidia.com/
