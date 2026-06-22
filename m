Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B83CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C113810E07B;
	Mon, 22 Jun 2026 01:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DOuOjv7g";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D672010E07B;
 Mon, 22 Jun 2026 01:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7SYed84i9+q2O4vOAcqqvks98Y3GMGCr8x0APE+W1PJbSlANOz+U8Rx2uxZ/XiamtMxI3Fk851TxY9EI5bYJsamLdMRemPFmj3IqIkLzg/0Gjeg0XwHOI9FHi0gVTPs0Lr+IzLA/iXfw19tvFp0Vsd/cPfucgaorKU66+4WUvCrod1pOFa28EdKIKBAO+BMjr2rLDB4tJvjOZBnqhCIT0scdfHLvtZKrijOgpLw1e55WkGAy8XHzVPp0Fe1Iz/h+jnMVUqDCst80KWB/OiOUgUTmedzRvwnTONyaYTRmnoTi4jAbElgj8Rd1LZ9KvYSwd99neawRVKkMImqxiOMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dWTTBdzB6qgFqwM9muENC5ALXsh1BO3DMbCCSQzvd4=;
 b=TZiqTeV/czkvbqciTi/tIjvTaGzBWUqLhGRwDeOwVYyv9tHgmPSqel7GB9F+j+Ng+uBoOaFAnnytn7tmNLx8BPuBwxx2ONi8614wujoyUfLyl0WdqY9Tac4yASOQNyVmldJGKgy1MeaRlGNi6oHYN/zkzpj5nbimyYhNRHgWzAml8mJQ+poMAyHuO2ZN8Xp0WuZJ26KfrdbtTjazXebp7trEXv5VOpY3t/6hYJkerLgwcv5qc35SQOmRiafCbaQ0JF/yPvsKitEJZZgrv6yijuOuchb29yjwkYN5ItNwyJycX2Z0TOJkTMHuuyF7fTOsk70KNIRhvVGaOLdT8zhTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dWTTBdzB6qgFqwM9muENC5ALXsh1BO3DMbCCSQzvd4=;
 b=DOuOjv7g1FV73QcyFNJqZ0yMYtXcBkMPSXNsOvI6Pevyt3dlFS5tY1pAxr+MxQI+cpWP1Gf6yuYzHUrAX6YJd9FSC3bEqabGNy3fg8EhLIXd1bcitJHX9sXM3S/ehKqgfSd1OLGbxiWaS3FUE62qRv3RYsEOAEhVj/4ztI+1IW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 01:56:02 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%4]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 01:56:02 +0000
Message-ID: <86af639c-1de4-4b72-8dad-9f5de012adfb@amd.com>
Date: Sun, 21 Jun 2026 21:55:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock
 in lockdep training
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <cbc54f68-b0bd-40ad-b5e7-ed8157128417@amd.com>
 <20260619121819.189293-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260619121819.189293-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::10) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: efa3e0b2-dd9c-471c-9c11-08ded00169a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1+U2JSwMRCoPiCCn6FzS7ch4jk6qMtLKsJlmb9N+GL7r2YG4dK5iH1sLEeFz8QWBIl6KfWMMiRoa0hIb4RahkSO6MD7eurBfyjPbSjhGhEVW1Gc6dBxqsyLl4uQeu3cH3Mz47DP0XjRPTHOQ45CXGMZrttTvyuESniGk72+74wBq16vLascjC7RZQLHQ1y6gcNV4lYDNNYQH8d8kafkze20AOYdpF3mPEMP868epThjAcowz9LS2Yka/NHLFaquJEodXbtugj8Yks0SJYTnJCfnJmbjZZ9c6FJCLCVAxjdnUgitHmuQafHSQdZ5ALUf8KDj+Xp72kN1BVQcsLNzhKEUOCz1Lko/KZgs1+5y3TIgHG6d/vBOtcZT3utDLiX3mZRZsmqJQdY+hCTXYDfaXVZyNM4/QTyOGZT7KJT/jEmF5jcsDTDMtFDy9KeB6+0Nxslgv9XtA5+ahJQhYODfc55BSdMSv2BAexVbactjG6GqgTz0Pkxb12VPyYl4/SAeYBDR6Tbn5PxHSyU4OuQJ+jvo7HODSehO77KazBD3YXbeEJaTSDu9zqGA+Crgnp02h6jfz+eo89Kk5PBbCecnSB49WsWTUQiBHclCx5RC7THRnU4I5eoS+IYL988mlsOGzCsZeFdRXILR84OCWpMf+m0ZhEN7nlWuylIZoOsiOHWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXh4WHJLemlncmZnTGR3QUZWSnA1dlRYREl6UTg0dVN2U0hSUk1lUVd2QTRS?=
 =?utf-8?B?UElIUWZMV0xKZTRIV0dzWDI1N2VEUkhLVnVTOGd3RHNFdm5IWkpiNitzNTgx?=
 =?utf-8?B?dEpYS3I0OCtBM2dVem44VTVqc2pBOTcvajdGeHcrMkduWEdvSW1SVEpXV21R?=
 =?utf-8?B?RXpTTGhMeDc3bnJVV0RGY2ZhZUlJSXBnZGgvNm9jK1FrVUY0MmpLeWs5SVNQ?=
 =?utf-8?B?aGdYSHU4cmx0N3FzUHhRdS9ML3grZEtxSThnN0prS3o3bWlYYUs4TlQxbFF4?=
 =?utf-8?B?elE0emNEcHZ4cUVHSCtrNE5xeHh0RjdPT2FjWmh3OGwxTjVyL0dldHYwc1V5?=
 =?utf-8?B?ZCtOeHFYY1pVOCtQSEFtVjRidkZmd2RpNk1RVnVPQ1JmejNOeGpKUGF3VTNE?=
 =?utf-8?B?dTE0aDVHeDZudmUvd0Y5NnpRenpCWVJFY08vVXE2ek80RUtRYUx0NkhGUytH?=
 =?utf-8?B?WWNIczVwVFUrRmlyblVTN1ZvZWpsVWpYbGx5UmdTU1lrZGY1eFZidHdZZGNQ?=
 =?utf-8?B?YmFiUHJGZGhmQ09nWUFQb0Rsei90T3Y4Tlo5U0tqa3F3d1htTjZEb3BLYXhw?=
 =?utf-8?B?bFloZktDcGJUczJsckRhWnI5WjQ1YitHRlNQSG1Qcm9Yck1TaHZ5UWdvN3Ey?=
 =?utf-8?B?MFZlbTUxVnJIWC9GQVRKem1janBJYzFzc0JHUnNZYzlOVHdSM3RsUTVpV2Uw?=
 =?utf-8?B?N25hV284K0pMYW5sNEZtL1cvbng4bWE3cFp5SU96VW1Qa0FOTzBhUU5qMFdn?=
 =?utf-8?B?SThjdEZPaGdIZ2d6S1JaazdQeFZxaHJDUFRRbnA4ZHdleUJCdU5qVmlrOTJp?=
 =?utf-8?B?WDhiaUhwWEU2ODhWM2x6QlRGVVNJNzFUakV0QlVNQXRrS2FVZngyYTY2Szg2?=
 =?utf-8?B?SXB2bXI5M0tzRXVFRmNnVFZjUkVpRlo0dEhuWm5Xb1d3UytPM1AzMHY2ZnBs?=
 =?utf-8?B?dnJPazdweGlEdS9BOWR3NlhaZ204NzJBcjltSUVZN0JqM0JXV2o4S0QreE5u?=
 =?utf-8?B?TTRjZGgxYzRTS0hGNHFOL2RRS2pnZmpUY1NiV2tFam41ZEI4NGVUbGU1cU5p?=
 =?utf-8?B?bFFna3NPSjJoZm5NTFJ1Q05mU01LaWpxNDFSdjhtc2JDbXU2ZjZQT2pYcC90?=
 =?utf-8?B?d3RXbnhHQnVIK3VtblVSdjE1L0pQNmxWWXV4VWN3c2plb1NHL2diVzhqWit6?=
 =?utf-8?B?OFZOSmZVOTJGdk9paFBzeHFDTU5OMkhzMUFPeWhUQS9GcmVmME5UL3kxTlFv?=
 =?utf-8?B?blkwZ0d3OTFlZEtTYVdISE5GMXVyK2JZYis2eThTZml5WVJHU0RPTFdXZlZW?=
 =?utf-8?B?YnNxR0RMeDRXV3crQUozdEJlZFovWW1KVlE2RkVtMUVBNHBPS0VTdlgyUXlZ?=
 =?utf-8?B?MkMyZWNqdk9wb2hMK1hmQVhwRUNBZHAzWlRpWTQ5VEJXUGN6UktBd2NjaC9G?=
 =?utf-8?B?YkxleVNGZU5SWEgzanpEdmlSZmJ2WTIvUTVOK2xCejgzWnJYWHFmalVBYlZE?=
 =?utf-8?B?TnhyWFlkNTlKdGU0NU1FT0djTFM3MnFOSHA4UkVhWnVOQTEwUmhjUUFzMjdM?=
 =?utf-8?B?WjVTaTExVU9VQnZIMFN0V0pTdXNhdTN1TkV0c29IRVZvM3pqb1I2bUVkeTVZ?=
 =?utf-8?B?MHVaRW5NME5vZ2ZNOFEramkvRVdvemNTNXFseDlWbHdNUTJQODB4VDRUUERk?=
 =?utf-8?B?a3M1SzFyU1lqK2ZXNUtZZ0xIL20yWDVjK3ZHb2p3WjBkQTA5OXl3TEJkSk9E?=
 =?utf-8?B?ZC9CVjdPSWFmbGw1NXE5QUNOMUcwV1laMU9mUXVGOXR0U2dYL1BTK251SHhZ?=
 =?utf-8?B?cjRHWGlPZFpxdy9paHhrYnVabGNvVDdFS2lZTmJZR3lvTTgxYlkrZm5BNmJV?=
 =?utf-8?B?bWZXMVpoWGxjaWlGNi9RRFI2ZGlMOEtlYXgxVWF0TXZIVlNiSW9XNnI4SHI4?=
 =?utf-8?B?VC9lZlNlQ0RKOFRCdFVMYmVxRkNxOHBKaktxaDNqK2h1VENvMDR6YnJmNjhw?=
 =?utf-8?B?NHBhc1ByTGRtcEVpS1RyTmVZRU05TVI5VUc0QUhzbnd6M1JrVVNyUkVGVWZr?=
 =?utf-8?B?ZEIvcnVQU0MzODVtVGEzcWs4OHBBZ1JoMVFGTDlHTzduZFovVEZrcUJXYlZm?=
 =?utf-8?B?K3g5dGFOQUs1b2Y3bXUzbWFFUTdRd3JadXQwVm1DN1RPZS9KZCs2U0VaZ1kz?=
 =?utf-8?B?WElHS1dUNWRzRGxHV1hIMkV2UTBWUkRXRGk0UlQ3bk5ndHV6RTI3NXFiNHgr?=
 =?utf-8?B?RzJVNTFaY0M3UzdMOTBGQldaTUZnQlg1aXljOElKS3BuZkJiSHhzbUZrVEVC?=
 =?utf-8?B?MEh2RmtTY3I0b00ybXR5Y1RtdzFTMU9EN0VacTJXSmphakNHbHNkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa3e0b2-dd9c-471c-9c11-08ded00169a7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 01:56:02.2600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxCKQtdh2DQdLCipq3mRAvq+LSpIYcRkxzM7MZ+6FULcr78EngkthAyx7DuBGagZb76ioXbrS/fC6CPxIIw50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
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

Hi Mikhail,

Thank you so much for providing the deterministic reproducer! This is extremely helpful - I really appreciate the detailed build notes and explanation of the lockdep cycle.

Ill test this on my side this week and confirm the splat. Once we have the fix ready and tested, Ill be sure to credit you with Tested-by and acknowledge your help in identifying and reproducing the issue.

Your assistance is much appreciated!

Best regards,
Vitaly

On 2026-06-19 08:18, Mikhail Gavrilov wrote:
> [You don't often get email from mikhail.v.gavrilov@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Makes sense, thanks. I won't respin this one then.
>
> Vitaly, for the reorder, here is a deterministic reproducer so you can confirm
> the splat on your side without a round-trip. It arms an mmu_interval_notifier
> via GEM_USERPTR over anonymous memory, then forces reclaim of that exact range
> with madvise(MADV_PAGEOUT), so amdgpu_hmm_invalidate_gfx() takes notifier_lock
> under fs_reclaim in the calling thread. Needs CONFIG_PROVE_LOCKING and a fresh
> boot; build/run notes are in the header. Happy to give Tested-by once you post.
>
> // SPDX-License-Identifier: MIT
> /*
>  * amdgpu-notifier-reclaim-repro.c
>  *
>  * Deterministic reproducer for the false circular-locking-dependency splat
>  * produced by drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c.
>  *
>  * amdgpu_lockdep_init() (run at module load) calls fs_reclaim_acquire()
>  * while holding the dummy notifier_lock, teaching lockdep that it is legal
>  * to enter reclaim with the MMU-notifier lock held. The real notifier lock
>  * is taken in amdgpu_hmm_invalidate_gfx(), which mm/ calls from inside
>  * reclaim, so the reverse edge fs_reclaim -> mmu_notifier -> notifier_lock
>  * is mandatory. The cycle is closed the first time reclaim unmaps a page
>  * covered by an amdgpu userptr interval notifier.
>  *
>  * This program installs such a notifier (GEM_USERPTR) over anonymous memory
>  * and then forces synchronous reclaim of that exact range with
>  * MADV_PAGEOUT, which runs try_to_unmap()->invalidate_range_start() with
>  * fs_reclaim held in the calling thread, closing the loop on demand.
>  *
>  * Requirements:
>  *   - kernel built with CONFIG_PROVE_LOCKING (lockdep)
>  *   - amdgpu loaded; run from a FRESH boot (the first lockdep splat of any
>  *     kind calls debug_locks_off() and silences all later reports)
>  *
>  * Build:  cc -O2 -o repro amdgpu-notifier-reclaim-repro.c
>  * Run:    ./repro                 # picks the first amdgpu render node
>  *         ./repro /dev/dri/renderD129
>  * Watch:  sudo dmesg -w
>  */
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <stdint.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <dirent.h>
> #include <sys/ioctl.h>
> #include <sys/mman.h>
>
> /* --- minimal amdgpu uapi (self-contained, no libdrm needed) ----------- */
> #ifndef DRM_IOCTL_BASE
> #define DRM_IOCTL_BASE 'd'
> #endif
> #define DRM_COMMAND_BASE 0x40
> #define DRM_AMDGPU_GEM_USERPTR 0x11
>
> struct drm_amdgpu_gem_userptr {
>         uint64_t addr;
>         uint64_t size;
>         uint32_t flags;
>         uint32_t handle;
> };
>
> #define DRM_IOCTL_AMDGPU_GEM_USERPTR \
>         _IOWR(DRM_IOCTL_BASE, DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, \
>               struct drm_amdgpu_gem_userptr)
>
> #define AMDGPU_GEM_USERPTR_READONLY (1 << 0)
> #define AMDGPU_GEM_USERPTR_ANONONLY (1 << 1)
> #define AMDGPU_GEM_USERPTR_VALIDATE (1 << 2)
> #define AMDGPU_GEM_USERPTR_REGISTER (1 << 3)
>
> #ifndef MADV_PAGEOUT
> #define MADV_PAGEOUT 21
> #endif
>
> /* ------------------------------------------------------------ */
>
> #define BUF_SIZE (64ull * 1024 * 1024) /* 64 MiB, page aligned by mmap */
>
> static int open_amdgpu_render(const char *forced)
> {
>         if (forced) {
>                 int fd = open(forced, O_RDWR | O_CLOEXEC);
>                 if (fd < 0)
>                         perror(forced);
>                 return fd;
>         }
>
>         /* try renderD128..renderD143 and keep the first that accepts GEM_USERPTR */
>         for (int i = 128; i < 144; i++) {
>                 char path[64];
>                 snprintf(path, sizeof(path), "/dev/dri/renderD%d", i);
>                 int fd = open(path, O_RDWR | O_CLOEXEC);
>                 if (fd < 0)
>                         continue;
>
>                 /* probe: a zero-size userptr returns -EINVAL on amdgpu but
>                  * -ENOTTY/-ENODEV on a non-amdgpu driver, which lets us tell
>                  * the nodes apart without pulling in libdrm version ioctls. */
>                 struct drm_amdgpu_gem_userptr probe = { 0 };
>                 errno = 0;
>                 ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &probe);
>                 if (errno == ENOTTY || errno == ENODEV || errno == EOPNOTSUPP) {
>                         close(fd);
>                         continue;
>                 }
>                 fprintf(stderr, "using %s\n", path);
>                 return fd;
>         }
>         fprintf(stderr, "no amdgpu render node found under /dev/dri\n");
>         return -1;
> }
>
> int main(int argc, char **argv)
> {
>         int fd = open_amdgpu_render(argc > 1 ? argv[1] : NULL);
>         if (fd < 0)
>                 return 1;
>
>         /* anonymous, private, page-aligned region for the userptr */
>         void *buf = mmap(NULL, BUF_SIZE, PROT_READ | PROT_WRITE,
>                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (buf == MAP_FAILED) {
>                 perror("mmap");
>                 return 1;
>         }
>         memset(buf, 0xa5, BUF_SIZE); /* fault every page in */
>
>         /* REGISTER installs the mmu_interval_notifier (amdgpu_hmm_register());
>          * VALIDATE additionally faults the pages via hmm_range_fault() and
>          * binds them into GTT. ANONONLY matches our MAP_ANONYMOUS region. */
>         struct drm_amdgpu_gem_userptr up = {
>                 .addr  = (uint64_t)(uintptr_t)buf,
>                 .size  = BUF_SIZE,
>                 .flags = AMDGPU_GEM_USERPTR_ANONONLY |
>                          AMDGPU_GEM_USERPTR_REGISTER |
>                          AMDGPU_GEM_USERPTR_VALIDATE,
>         };
>         if (ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &up)) {
>                 perror("GEM_USERPTR (VALIDATE)");
>                 /* retry without VALIDATE: the notifier is still registered, the
>                  * pages are present from the memset, MADV_PAGEOUT still works */
>                 up.flags = AMDGPU_GEM_USERPTR_ANONONLY |
>                            AMDGPU_GEM_USERPTR_REGISTER;
>                 if (ioctl(fd, DRM_IOCTL_AMDGPU_GEM_USERPTR, &up)) {
>                         perror("GEM_USERPTR (REGISTER)");
>                         return 1;
>                 }
>         }
>         fprintf(stderr, "userptr handle=%u, interval notifier armed over %p..%p\n",
>                 up.handle, buf, (char *)buf + BUF_SIZE);
>
>         /* Force synchronous reclaim of the notifier-covered range. MADV_PAGEOUT
>          * runs shrink_folio_list()->try_to_unmap()->invalidate_range_start()
>          * with fs_reclaim held in THIS thread, so amdgpu_hmm_invalidate_gfx()
>          * takes notifier_lock under fs_reclaim and lockdep closes the cycle.
>          *
>          * A few iterations (re-touching in between) cover the race where pages
>          * are already paged out on the first pass. */
>         for (int it = 0; it < 8; it++) {
>                 if (madvise(buf, BUF_SIZE, MADV_PAGEOUT))
>                         perror("madvise(MADV_PAGEOUT)");
>                 usleep(50 * 1000);
>                 memset(buf, 0xa5, BUF_SIZE); /* fault back in for the next pass */
>         }
>
>         fprintf(stderr,
>                 "done: check dmesg for "
>                 "\"possible circular locking dependency\" / amdgpu_hmm_invalidate_gfx\n");
>
>         munmap(buf, BUF_SIZE);
>         close(fd);
>         return 0;
> }
