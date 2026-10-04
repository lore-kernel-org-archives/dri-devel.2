Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FE2CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 03:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2615510E0E7;
	Sun,  4 Oct 2026 03:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9y1h6YR";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FF310E0E7
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 03:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCyUEegaIeonU1mdNyOlyeRDqcp8hijrSpwiPwPYeM6kzcA+WbKOIy0rt1dK8T4/Jm3d9jaCVA4SJCrlP/R3MsS0B2qM3XmiSTk6XGexKOKZlHzElhQSnj0aSD4LZDGQuMuAP6PYDKXNUUBdzf2UOFf1LXlgT6ACelLCg8kEQf9rVhA1XLdG83vG1idxbhD1BM0y9LoJyL/oqfuwl3CkOrcBjyx1oVStNnbGLDSfljkYvHs8aIsFbkzVIM0fnfMuEaSpxZcnMsAQVdGNIoe6f4l4zcJEKuxUz0F86HIdFrj8/JHPkd+BprL8dxkAjKLzUgOMQfp1gGzG+nOwNroidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj6vdXAAWEBUSc4lx15P0WbjU1Sb6uBeDU+52oSbo7U=;
 b=hv4pTUx+r5Lvv8V+Zl41fRyq7vabUV4stL/n+0/hHwpnmnmhT1T5lVSK9vDHTEaLhZ2AxCUKpqR2O2vJXIMODHChAxwP2Nzf+18BovjXmqKoDvY3rpT+Ia6l+UHG7GirwZFnXRpDBpe45DSHZN+GhL7V5kizRfCtlvTCL0DaiuCJ+kY1iT7ONoauUN/jPxoRSSUW0vg6wuk9RF2clUPlQBxLtqyXeUF+aQihRtmeBXCeLAZYrRYYIuJcK92LRwa9vBueWZaqgjoZ1U3jIxF2pP283AcwPFa91szkpUDWeBuHqiojy5HNbU746kGas6fw2nEPM7KrlshlEizhxFyf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj6vdXAAWEBUSc4lx15P0WbjU1Sb6uBeDU+52oSbo7U=;
 b=l9y1h6YReyPcajrlTHB+LkPfAVIUuqZIcy86gb3ah6PXyyX3y5CeIfJ7ZBBevLo6q2WKtck1ZAorHq8TWs50G/O2zE2iXua3YgBKetZ5lgk3WLxQMNh356mTk2EtKO5QrL70J9W48SMi6o7dvHCdULzpvgURGdZNbni0aOt8o8+3VwRL9Y0xswLqlQMUaOHUc9ykJN3DE8k7v4ojdLqfLBqc5T4McBkvWsafyLxzffGfdxmnglcpPOuPG5SGrYfFiotRACKWyGIkJ48Vm+R3UzcOR+gky7vENll1ffm1T3OJ40+84cWHOQHmvW8vdHbC4YV7R0BcjamF3OssO5j/bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Sun, 4 Oct
 2026 03:49:58 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0472.015; Sun, 4 Oct 2026
 03:49:57 +0000
Message-ID: <0d7af613-e18a-4746-8ec2-0138227fccaa@nvidia.com>
Date: Sun, 4 Oct 2026 05:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS
 disabled
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20261004-nova-int-fixup-v1-1-9e4bce097f94@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261004-nova-int-fixup-v1-1-9e4bce097f94@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 962e0215-4647-4b0f-539f-08df21ca8ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: wpHzBre/2RmQ6fA+tn6wFnUZ+rsfEM5LWQiE4yXX3wIpmqkJY/GVS6KOF1ITeX1Z42xcSt0oa7K2n3Jg4NJHs4gJx+pboY01gYXoD7HY+ar7nFlYB3uMfM9rBJ/5inI+VGnT9vPbo5jWR6BAibdU7xP1GA2NskNaqgHLOe/njVrAOP7Vavi29M8280m7zkXRsPWlOGPRFcj6AO/UnU/J7yHQGSWfNgWVXuWlkPDKWN9JxvV/Wb9Th6u7MRk9Z9h2c9jib4l7mFmQTVL8R6Rb7eXNi0/BuBNfhtPs49rTjIKPXDEJN9BTV9ik2ayZIkm0QzVpHaMGD8nbd/cXQI4pxkV7A3rxOG4YJ1kKIyBgx0/AaqTctI+vrc7UrasAFgopEFctfTFxJ0aLosrELx2PO6vJuBItAaholq4Y2nTKDLauRctRsZsu1ySzzT3eaB5xvt5CfuJUbnsWHPP+phDBr8lqXWwGeij/fScGxJrSnbx5+XOXUYdyjchIYMeZE03q6s5JVRjNsOagOx9Nzbqm6g1DxfxNjSCdRGl0vOgYpb2/Bii9ODg2H2xr3gAlJEplUKtUsCaTPNQLeLYNUmdgUSQ0FCVElbBY+JqkMvPZtwo3Xld1OW/omzJYWZQ5F6MGCt5zXoyzyq1DyKYU4bFsC7NCSmXnz1Iw1PrKX90DX9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0cvMjhOMW9PeXA2NnM4dUtXbnYzdjNDYmpXNnZZZnNrTVNzb1p2UERLQjBa?=
 =?utf-8?B?K0ZZdDdKY1IwN0ZMR1hFamN6bUk2bjF0RHhJaVlJZ2pwcEJST3VGeVlnWVdX?=
 =?utf-8?B?ZTVKS1hET09FcnU0cGxZYWFzanp1V1ZHK2lNa1VQTjVxeVlrSVQzTzcycWI3?=
 =?utf-8?B?VERrTWJZUEJoTHovN29GQytQVU8xTU9pUXdYK1VtQWVPTXVJeWhtRjFUZ1pG?=
 =?utf-8?B?aW0zNHFEZXdvaW00Q1lwd2VDdkQwTDE3YnhjZjYzVFdwdWZpcFBaUlUxU3lY?=
 =?utf-8?B?aUNJZlY3Y3ZRZ1Z5TDJ5YzF3OHJ6NVZERXBDY3pEa3EzYkk2NGV5RSs2UEds?=
 =?utf-8?B?VWVJam5OS0MvYnh0SmNqQUVzeXA4NTNVN3cvWGExSExKVExKZTVXYWoyM2F3?=
 =?utf-8?B?S3h0MEZvK0NwWWxNZWV5WnQ3Z1R0Z0czNnZyekQ4WWREREE3UW8vNTVzNjBM?=
 =?utf-8?B?TThHc1ZiZ05MQnJ0NGpoOFlFTlI2dVFxNUtUU1ZmdExSRmFPdFJ3bTl4Zmxm?=
 =?utf-8?B?SlprVWZIYmVIZzZsRDYyV0YyeWV4WnNHRkZ6dmVBb0Y5SGRTRURZTDRUcFJy?=
 =?utf-8?B?SGJKdEdjcEFIbU1VTGNWVzhGcDkwV2ZFbkhtYnAveXdjNHU2ZE9hb0x4WmND?=
 =?utf-8?B?Rkp0L0NlejMveE9TNW1UVTh5RkowbzRzSjdqbWVyZDE3UGgyL0pRSlQ5VFlj?=
 =?utf-8?B?ZkRQREpZYW9DT3o0K2tJWUpsaU5tT05BcVVQK3cxbHpORDJHMDI1OTBYVElu?=
 =?utf-8?B?Snl6ajNDand2UjUwbUNaRGI3c1ZCSGtUZkpQZ09FWDQ0QllncUNQTzlodU5W?=
 =?utf-8?B?UG5FZWh2WkI5cU41R1M3Yzc5aHcxNmxtU1ZKdXJYRnNlY1NRc3FrY25WbE5j?=
 =?utf-8?B?US9MaWFFc09UM251M09CTk1JU2VtbWEyN2duYnhYL3lRdlM1aXJONGpSTG1m?=
 =?utf-8?B?Sjhwb1V6c1VaZkVpNXAyb3BuK2ZwRUgya0dDUC9KMmQ1M1NtOCtOck93d3lm?=
 =?utf-8?B?WTl0NCtnc3E2U1lESFN1VnV2NHp2UWVabGJncFpIam5XUEdXVzU1eGJzVTF1?=
 =?utf-8?B?TVhaNUtyaDZJQWFoUVBVTzR1RGFSeHBTMWZaemllMWYwbCtrMnpoaVM4VDVB?=
 =?utf-8?B?bzB1MklMTU9lZXROTTN5RWxXZXI1NENlQkl0U3c0ZDhNNnF6VDY0b1hDa1BF?=
 =?utf-8?B?OGk2ZFVGZFo5VndXSDd6TWhkUjVGMDhjVWprNDV0M1ZBeFlBaUlzK0lYbnBV?=
 =?utf-8?B?aTZHSHhDR2NSZzV2dTBUYWFJNWRHNjhtSzB2MTJaU1h4U1pidlRPdkhaZmZ4?=
 =?utf-8?B?aWRtTUhOeldzRmVXOWZpMkl6K2tUbUJwRTJsZWNsYVJjc3VqTFh5T1ByQmxr?=
 =?utf-8?B?bGhKNlRBdklvQ044bE91VnZZQ3dxOTJscHQyYU00RW5FYURLQlRwblROaHJZ?=
 =?utf-8?B?eHFZcThWakRqSGpkQnQ0VTlpbzdtK3N6dXlsaWV3YjhySzFzYnBKajlLSjNy?=
 =?utf-8?B?Z3JUSXYrcHd4RmtWRjBRRnZabHBOYWFWM1UwRDVuNjFPOVN0MnRoZzZnNGh1?=
 =?utf-8?B?VWpHdFZkSzAyRW9XMXphbmNBajlkOWhmenFkS3JiTmU0eWxyRnZhMkxyN0VT?=
 =?utf-8?B?Zmd0SVhlM1o3akN2anB0RnJXYTVJSFVnamxxK0JFZGV0YkNETWJJUGtKSEd4?=
 =?utf-8?B?d0VDaFhQQTRxMi9KZERHMGwxcU8rWEtUbkVFc25Fc0hyc205OWhqck5USnBI?=
 =?utf-8?B?YlJta29pMVVkR2F1Z0dYa1NyU1BHL1VnSndMVEp0dXNlak9MWVNOTEovZnpI?=
 =?utf-8?B?Z2p5TFBGenZTUjQ5ZFVrNGk1UDJTTDVOV0NWSzM2eGx2U2hJdklOZjZoSXE4?=
 =?utf-8?B?ejlweWZydTB3L1dNNmluQ2dUMlhZM1JUYUtaekllTHU0a2ljS0RsSEF3WEIv?=
 =?utf-8?B?K0gxWGtBTUFFUVovUzVjUkxvTTRxQ055ZTFGc0QraGdXek1td0JUUXQ4ZmJP?=
 =?utf-8?B?bmE1eUEyMDhvdWQ1SXRxUjg1L2dNU3FLVkx6Vkt0V0cxVFFOYmdzRkt2WkNz?=
 =?utf-8?B?Q2pwMzQrM0VUWEhmV2lyY1lyM3h1ZC9mWlBsWVRwMlE1RmNFTTdWeXRPM3Er?=
 =?utf-8?B?SCt6d083OStVamJoajZHK3BteUFSalIrVkNJcS9jVGNZeUpMbmZNbUVER1J3?=
 =?utf-8?B?WmVxcmlWTyt3NWtxdjVCNjVmTVpUWEtzZVpIemtLcEZpQi9xUFhHamlZUkxn?=
 =?utf-8?B?S3hCVmxNamhhN09jcUNIaUJuRWlzTStBbVk2RUl0ZUw3aU45WTlqK3hIU3JW?=
 =?utf-8?B?azhSR2hNYTdxMkZGRDllUGtoZDMxNDRDRzdzNzRtWnVoMTBWQ215QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962e0215-4647-4b0f-539f-08df21ca8ec1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 03:49:57.4562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFhRNkSLLMOXqLRqC0nhoqhNhqP4l4L6vOnlTQCvFjylAOg6PeuE1QJaCdfcKr2fInbanBMvWZVRWMtBPfrxMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

On 10/4/26 3:00 AM, Alexandre Courbot wrote:
> A module-wide new import becomes unused if the `NOVA_CORE_SELFTESTS`
> config option is disabled:
> 
>     warning: unused import: `Spec`
>       --> ../drivers/gpu/nova-core/driver.rs:29:9
>        |
>     29 |         Spec, //
>        |         ^^^^
>        |
> 
> Fix this by fully qualifying the unique use of `Spec` when the tests are
> enabled.
> 
> Fixes: 9cb3f5d56e81 ("gpu: nova-core: add an interrupt delivery self-test")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610031630.JOlyp48X-lkp@intel.com/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/driver.rs | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
> index d195fd2bcf8c..560a70c4f5a7 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -24,10 +24,7 @@
>  
>  use crate::{
>      api::NovaCoreApi,
> -    gpu::{
> -        Gpu,
> -        Spec, //
> -    }, //
> +    gpu::Gpu, //
>  };
>  
>  /// Counter for generating unique auxiliary device IDs.
> @@ -121,7 +118,7 @@ fn probe<'bound>(
>              // Run self-tests that do not depend on the `Gpu` instance.
>              #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
>              _: {
> -                let spec = Spec::new(pdev.as_ref(), bar)?;
> +                let spec = crate::gpu::Spec::new(pdev.as_ref(), bar)?;
>  
>                  // We must wait for GFW_BOOT completion before doing any significant setup on
>                  // the GPU.
> 
> ---
> base-commit: df718311a84188e26d499301c3921e4c392d557e
> change-id: 20261004-nova-int-fixup-4593b4d61084
> 
> Best regards,
> --  
> Alexandre Courbot <acourbot@nvidia.com>



