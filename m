Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4827FC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB1E10E366;
	Mon,  7 Sep 2026 02:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUAOlBAq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4940210E366
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 02:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVXX620nBjT4ll0z4mWAk+wgpfxmK3sDYPfFuOyyCciGxCy3OGJ4j1H9Xl0T4DH+/7P/NLDkdE7A+ZsQBlcsOXXwRSFMLinvi1L4chF5WyC1D9JJidz92GDu7iUwtXT/gcXZh2/6CE0BBeEeY/KDPtbbVMdIlXjX7NUSmINo3LCCgqTN+gJm9xAexKkF1CMcSMCxvq7Elan7ehrWG2Im+3q0d4bB749C2j3EHi1CGB6bkCiU3CpYhriWp4uOOholzkPt2faAwoM7kBDSnfWTK/IsTjGNldhxdqMynr0P/GCSyHIwEwDVOfW+ZKoI2G0gMgyLOUu5ESoE5vTaJc3/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfS3uc+n6lxn4ApmhY3x2Suyfk2XfVfAKhkRMzYs0XQ=;
 b=WRgTq3nh3AEqEZwo90S1gmThh8xEXhC1TRVTAGlFEnWgbq/frLmQQ38Jhf/VHgpunAGjROqFfdTorHXNRZ0dY3KbZRNJdI55wE2xl+qE83OCob8gAVp6RIG3JR7IeyoBiVpa06IebJwiDtoXK0xlCmN0m+t03B7IbeVDSRHgkUDJAuIVxtZcuKnNJYK1bJORRf8gT/9kus7BzmsH8a2pXP/fnBOPFaUbfHYTGyDqzjR+pkZdWNhtu/w1WdSGX1vrqYaZ3mkPu/9U2b/o7t8mh0d+JH2s6DmHu9s4LbxeOKebPPUoPrrPDgaz0Rq1Y2O3tBKrmk2RocV6vdtI++WT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfS3uc+n6lxn4ApmhY3x2Suyfk2XfVfAKhkRMzYs0XQ=;
 b=cUAOlBAqoLiLWkGXhUT3H67OvvdmsFlPKldwhhzqJMTSdK5jbGbyBV45sNcdpt0TtQHK4gvZDNpeDfLpeWIPKbNmXMRIfWoMA05RRi9tOJ/KwB6JXdRzzm4nAXBISUMEfr0Srw1M5DGkAYr9qtZIyM94zfcHc+cHrA4KNqll8UEITKiHDuMLiyIBvS+iP1A+E7GTwDB35i596SkiFqWxjr30GmVK5+pwr5EVW67vJP7ot4xlTYN/SWNF07vrfqD10IzKsbSfMZBMgbf/ApD7+sFXOPKyjMKNfTEdhIJAZaqRRBiQkb/DvWVKq7k8rTm1VSUQozwI+/G+Dn1vb1Ct7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 02:10:57 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 02:10:57 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 11:10:54 +0900
Message-Id: <DL8PWSOK6S11.3T0U8AX63YFO1@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <ojeda@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: declare unlimited DMA max segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Matteo Kloiber" <kernel@matt3o12.de>
Content-Transfer-Encoding: quoted-printable
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-2-kernel@matt3o12.de>
In-Reply-To: <20260831233215.287881-2-kernel@matt3o12.de>
X-ClientProxiedBy: TYCP301CA0077.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: ddeed893-eaa5-4788-d60e-08df0c8540ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: fdbZ73iCaaN+UXZjgY3hg0iCDdYfzBEv6zS8HpgSkmimdAXCzLeb9T++ibiKZLk6NYLoTYDxi+6ZKUFLSDjgIfNoA3AzMHjNXNOFHvwjtyaSsp5G5+n+bdI++VpEnoVuH2lC/EUjz0nkZPyZ2S0rGQwH/gXjcaoWIuZcI73go/EKiAjSiKwP+RP8U/hLzZmziHuV4EAUlKnUNRoyCX+xNk9lB23gbcYgSRINT2WXwOGIMUplYASJAmFZ3qC/O6H2lmjDqnb8wtvuLD2dSF9GLKhryUPw2HymM/3krKaiHgsj5egI3Cfdi2i2syvkAbTQxu90CTlsrw1nnfR079snG866oNtBYwmBUo7JZP0o1fGOTr/3C9Ygmu8eW3ZR8p12fG6ewG1kjmT2pqwk+DbT9nzlFW0V6JMIvyEOa6+pGcJvvRNBEHMKnVY3O0Dyin3lvoxWg8p0nvwh8CBTlY88DBKyfqgxCE+MRj2DBoxmgY2x1j3/8kMxkf4WvlKuQwUJSrnaXGtEn6CZi9ZInP58MgPfSzrX17jxLz6oDcGFZIY9Dln8M/XZiSjLg4XfBxKW4RKv7OlqGcSRlAn6U5xtYFX0FDdrmzfWgEwxV4z1HaqK4xwmhz+v4Qfg44H5S7FhOdOlCK2MuvYgWixwq+VtubxBM2dA2RBhXLp4DWMn078=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZhdmJqR01icDdJR2M5dVNvTDF4cnM0aWxxWFYvNGRzTUF0WVNLcUJ3a080?=
 =?utf-8?B?c2kwWWx3YnVLVGtoMThDbkpFQ1dpaGdPMmUrbFJpb3pNaHhKVmhLU0oyQlNS?=
 =?utf-8?B?d3BubGNDODQwU1BwOWlKNDhlUEpXWndZSENHTFp2bUp4S3QzUFZpeWhSWlZo?=
 =?utf-8?B?MnlPeDA3SU5sWWdLMjZGdHZ6SzEwNVhvcUVzQ3RuNDdKMVBweW45a09MVHov?=
 =?utf-8?B?NXJ3V2p2SGRUR1k0RnBBNHI4N2IrSlhnbmVKZSsyV3RVeHo3MGdtRkFjbHR4?=
 =?utf-8?B?QmVkbENEa1YzdjIya2QvS0dpNFN6Q1h4S00vM3UzNkk2TDdDbmZTUXRlSzUz?=
 =?utf-8?B?TG5UaXNMRmEzU1BmUWw0aSs3M3dqMkxZelQzbUM5ZERDc0YxK2NUTi9wRmRo?=
 =?utf-8?B?MWFmSnRqV0xMbTNZSDJoNUlwWG8rRm1wcVpicDZyVVNsVVZoQ1pKeVUxaHM5?=
 =?utf-8?B?d2lHYzArbi83dFZwQ0NGbXRQT0xBR1FvMEttcG1oam83SzdiQm9tVmVBVGFL?=
 =?utf-8?B?eGZObyt2dmNVbFJWMXRYVEJpcVpYenJPRkY2eG1TYXpqYWNkeWNpdTNCdysx?=
 =?utf-8?B?L0RjUmYwRXViYm8wVlN3SVVLTnZ0dUNERjhxaWhaZ0FHUTNSRGJiRHNVcy9C?=
 =?utf-8?B?UlpWcmZQSVRKT3o3cnJOS2JMK0JxcW9MdFZsUWN6VHNkb3c5NUxLVnFQaDlI?=
 =?utf-8?B?M2owcldwUmQvS3FyZ3hvUkQvVnhnK3l4RkJ0Qi9LamZNek52SVRUemNyTytC?=
 =?utf-8?B?K3JFcWowaUIzNzY1QlZsMjJRVmh6N1o4ano1RDUzVndkdC9rUjZodWQrb2Jk?=
 =?utf-8?B?emFXeWJKWjdRVGlybmM3V2h6bGVSdVVWUXNiSEdxSlJ3eGtpR3BxR0xsaHVJ?=
 =?utf-8?B?K0luRDdHM1lQeUt5SURvV3ovdGpVL3RNN0lEM0pqRDlCQUFoWmZPdysxM0pa?=
 =?utf-8?B?TGFxb0JGWXUyMHduQ1ZPUmNCejVRRmJSdmpVZGpFNERJdC9HdW5jb1JIYmdr?=
 =?utf-8?B?ZzAxcnZXSzNMOUlrQ3FobGxlT3FBd3Vyc0EwTWltOUkxMlUxVldFWVIvcVpV?=
 =?utf-8?B?UmZoNTVQcUdUelE1Z0R5NjFuZDdmcEdpMENnRWRXSm9scVp0aGxORk5LUnJZ?=
 =?utf-8?B?MDgyRXVIckg1Z3NKQ2ZRcVpoZFVJcCtwK3Y5VlFmaDFXbWpaNjJuOUVtdW9G?=
 =?utf-8?B?WHVldjZuVTFKN21zTStDOU5pcXMzTkMvdy9uK2lzVldkYmZrNGJLOERxWmk2?=
 =?utf-8?B?NEhZUXZxUDZQN3FDaW0yUDd1R0s4NHo1RlNQb01iOWdKUEViQThaM0dtb2lQ?=
 =?utf-8?B?ZGtzNndHWG9WS0Yra05zY2ltTUtjZnFWSkdxdWM1TjAzR2JNbG1MdTNITStD?=
 =?utf-8?B?OFdVNmxCMEVnSmxySmhFZ05iQldFdThjbE9Xa1FWMlNSWkIzOWY3b1ltOFcx?=
 =?utf-8?B?anBwbk1YU2JmdzVYNllKZTQvRjIvL3NGVEdUWXdmM1ZXcWh4dE0yMThITnFC?=
 =?utf-8?B?S2JOUElnazQ5dDJzSVdoZkFqbEZrVzFMK05RclpEQ3BtVGJmanM1MTlLQTJM?=
 =?utf-8?B?bGN2UDk0UU9xbkpaZ1J0V2d4Q0Q0RTdSTXlFOUNOd1RrYXIwckJXSHY1Nm8z?=
 =?utf-8?B?a254c01aNzN0NUJyRzJKY0VNYnJlUmxTWUk4UStzNWZOVFUyYnB0UFoya3dl?=
 =?utf-8?B?Q1JLSTJIZVVMRUx5MFNTNm1BVytKZVhQQnplc0V1Ym8weUlFdHZHNFg1V0lV?=
 =?utf-8?B?T3RtQzNiRTgxZEFxdUFxWkpFcVUvWjBFL0tMMWg0RGZQWHlnWG8vaXp2LzlW?=
 =?utf-8?B?NTlTKzZvL2FvdTh6SnUyNStjVzcranhKOTNxZVZCY3JmYUxSeTNCd3ZtSGVX?=
 =?utf-8?B?UFZJSlgxR1R4SmFjM1FGTTgydTI0Ykk3SndSb2xjTm1rRlVySUM0aTlsUzdu?=
 =?utf-8?B?TEsyRFpsUmZYSHREdmd2Q3BpR2lGL1VNNWR2aHBteE8yMnN4TVNPOTVQQmtB?=
 =?utf-8?B?S1hTeDA3N2ZXU2hpMDkrU044bmRTSWszclhKZXV2T3BFdHRKMVlKU1daOHBV?=
 =?utf-8?B?cUJicHhlNnpRRnEwYkpKeXprbFcyazlqa1daMDlWdUlXK0lQQnIzWTljYnhM?=
 =?utf-8?B?SmVHWjNBZUlUVUVocmhRbWw4bjR1QmJzbi9MbVNmbUx6bjFsRUY1YjAvbFIy?=
 =?utf-8?B?NE1vcUhaelhhdGJDK29VS29YSllHRnJqZGNiZmNRcDRkekp2WGd0OHFyUnBK?=
 =?utf-8?B?anVxYVdleVIxajJOV3lnc0gxanhtUEMySzl4UEF6dkFGV0hnOXY5STF4aVBv?=
 =?utf-8?B?M3BPRTZaVTlRYmM1Q2V6SFg0QjhHVnluTzAwbnFWNXJUREJpK2V2MndWb2NO?=
 =?utf-8?Q?DdQkPFg+VQXPuZzSVxziwFIZF/klCV3dhBnFZPuee66TZ?=
X-MS-Exchange-AntiSpam-MessageData-1: iZEwuLS+exvIRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddeed893-eaa5-4788-d60e-08df0c8540ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 02:10:57.0456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAI2hTTzTqJbWCpp2+FdjQ660y97oVIH7uqOW5o2dpQBxgYRE2zN5Pjz7J+3ShkFA3zDpyjLz0qWC+sf2UcGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

On Tue Sep 1, 2026 at 8:32 AM JST, Matteo Kloiber wrote:
> The PCI default max_seg_size is 64 KiB. nova-core never raises it, so
> mapping the GSP firmware image (~60 MiB) as a scatter-gather table
> triggers a DMA-API debug warning when contiguous pages coalesce into
> segments that exceed the default:
>
>   DMA-API: nova-core 0000:00:03.0: mapping sg segment longer than
>   device claims to support [len=3D62914560] [max=3D65536]
>
> CONFIG_DMA_API_DEBUG=3Dy is required to see this warning.
>
> Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
> Assisted-by: Claude:claude-opus-4-8

Note: new kernel policy [1] asks that the specific model is not named, so
this should just be `Assisted-by: LLM`.

(also should be placed before your `Signed-off-by`)

[1] https://docs.kernel.org/process/coding-assistants.html

> ---
>  drivers/gpu/nova-core/gpu.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index fd1414004dd0..233ef2dc9688 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -343,6 +343,13 @@ pub(crate) fn new<'a>(
>                  // still constructing it, so no concurrent DMA allocatio=
ns can exist.
>                  unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
> =20
> +                // Nova re-decomposes SG segments into 4 KiB page-table =
entries, so it
> +                // has no upper bound on segment length; declare that to=
 the DMA layer.
> +                //
> +                // SAFETY: same invariant as above -- still constructing=
, no concurrent
> +                // DMA mapping can exist.
> +                unsafe { pdev.dma_set_max_seg_size(u32::MAX) };

Thanks, this patch looks correct and I would like to merge it early, but
one thing about the comment: it carries way more context than needed and
reads heavily, as is often the case when AI-generated. For instance,
"declare that to the DMA layer" is obvious from the method we are
calling. Make sure to give a human pass to such comments as they can
make the code tedious when they accumulate.

Conversely, `as above` is risky because the above in question might
change and we then lose the reference, so here it's actually better to
state the invariant in a self-contained way. Copy-pasting is ok. For
instance:

  // Nova walks SG segments to build page tables, so their length is
  // irrelevant to the device.
  //
  // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
  // still constructing it, so no concurrent DMA allocations can exist.

Since this seems to be your first patch, this is a good opportunity to
practice sending a v2. :)
