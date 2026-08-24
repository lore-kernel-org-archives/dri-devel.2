Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD6C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C8910E585;
	Mon, 24 Aug 2026 18:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aWQXtbxI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A0710E584;
 Mon, 24 Aug 2026 18:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOH7dPhvQPDYZnUPGv8xGxGdBe5UAL/1P1UwS0rS9KNY0g7EviurmDYOngJ2Ej29sH1MyZg5gKv5dDeDRZywPOYG49a1aRSwpZRIvd8yapwVi7vMEI/OpXXYIK5pVDGFRtbAWOMaDd/TEFeVwGVVCUHyqdE4wI1WmpWQnnBPPb41gJZJL2xm5lMb6TqsNH8oHCnxSFN2m8/x4M25OaLAorCSPoHG/EX8QGmsUiz4N+3vcK+ren3iusCFvU1yAcL2ovq1fO392Euoar8m7t5qLHPn9Zh251SdZSpeLD8i+u0NhO2XedpAWcRfGlyIGa5xkyZR+X6I8u3RYqYpXZrnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq8twci5iI8MmcuASO4+aKx0QsWiuJdudpb8G9JLwEQ=;
 b=fUB4Ir1csEIfwJIR6lvC6bRD6oDxJZQsrfVILhGdDwmrqOe9ucIdADUDOCn1ec8qupr6dgykd573bs+SxdASoADgrPBrK+1lDdAeFNyAptStldjhZqStBt7HZXyOcvDlGvo7S8iSeP1oXn1gJEUZZw8bEJwKQRgoJlnqLt5F9RGIcjEcGCgWiEWRucOSmCzbjaWRUlcy2ritMv43POd8E8TIUT6fdY6CjtX/JO3amfNyqINd1SGLx+S6ViNkOdQIaP/a1h4GNgmAEJ6k84MXoUtIMsKliOeeGF8r+XdKMceW37ha9ee78jEA1tpwoqLU8yFHcfjjFUHx6CIei7fp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq8twci5iI8MmcuASO4+aKx0QsWiuJdudpb8G9JLwEQ=;
 b=aWQXtbxIjHocF50Q8wlaeBN3HAZAvuVYAXiizDjeK2mRMCLIKrdXeoE7PxU+2P79D6gc7CUI5rFdFnBGyB+72mnep6RKTV4DdrxsyiVGpqPQMe8rLvgk2S57jCYtRShWhM3AgZLN259g51B1lU5cZcjW8cGj2vhFDY6wMcj4P0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:31:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 18:31:38 +0000
Message-ID: <9b008bce-fdb1-4b5a-bf7b-f56442b31807@amd.com>
Date: Mon, 24 Aug 2026 20:31:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
To: Denis Pisarev <pisarevden@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mario.limonciello@amd.com,
 ionut_n2001@yahoo.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260819185349.29407-1-pisarevden@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0441.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d2fb39-07e9-4997-08b4-08df020def5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: l8/AiN6DuI8j4DCD1tlL6nRixx/OcioK9p4BY54Ig1Ay59arwuD3QXiWobYSvZX303oSqeKllj5XKQjvbUcnH656fxBojwYKrbt/H2bTfts8d/oYtMKr3eNRXldUWdK1FOSVNNOP3PY7KqG25Ae3H7z71sGlyrum74gfYdXPb63gBfREplJcpSPyvwrhiQIehO5+Elk8Xbs687apDMOor/g912WQhAdCoPNlQ5xY83lq/0HlzWgemkuhnKai527IRcUu5lzbhgwKhSaj06U3IEcPwrVjga1/27xA7PYnGjQimUWg5E27IfnknpzRQ/K5SflEtbx6S1nsUaxxsIzgKzs6n6FkKFyDFeuSAPy4r8/zYkuP32yQ9Rypic0pB8MCZRGrFlqozsini97dshUrHC/IiYG+6034cEHDSOc9LR5GTJ1a97h4pl3NK+C6yMrBKxcuD+mTB0TWi8CkySPbRSq90gzPMxAFJy20C39U0L9gM3r7hOBYw9gnki1ES18UyY1eEYFdS1lwfJ6mRgkcKOr3BfacWDStmUxsu6+tsOIiFcIKnm8dHtHUgtGuM8yoZj+CYF+rpH0tixwHN1KFgWOQSv2PNLo8yFETgtw+REwaQUn+WLCu3Lrza1EaKh+QQOXvyTDPQP6koO2qKDWcWo8CFHO0UF7gfba5bp87ckI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTdKakIybWh0aGxGVU1oS2w2d3Znc2ZHQ3c2WmFvbHREVUJRZ1FlYzRXREg4?=
 =?utf-8?B?aXFCQWVhUnIxV3VkR0tsOTMyZXBwYm1YYW83ZkM2Y0owTlpOcjBac2U2Q1dl?=
 =?utf-8?B?SkFVTUNtVDd2cVl2aExUd0xFVW02S0RLQ0RjT0VYV0tPSkowTEdxbVlBbnh5?=
 =?utf-8?B?ODZiTEdFdDllZEVmZHB2TUsxMkFibUpIb3NQYjVleThBMGhVRWlaRGh0YkFR?=
 =?utf-8?B?bVVjMjlpK0lxL290TE9KNVR6WkV3bjJXbHg4L2tBcHAzUU1Cd2wxYk5qU2R4?=
 =?utf-8?B?TXpXQWNlQkNEb0JiYXNpbjMxYnZzOG11djBzbXJTN0docFFKeFFkY2poM2dU?=
 =?utf-8?B?R2FTTzlOZ3BPazYvTXp0Q2ltdHF1eTQwM1V1MENmK1dHbVdCUyttV2ZZYnpn?=
 =?utf-8?B?aUQraFlBaU1GVFhhOVdOR2NPMEJLVHFhVGFtM0liczVGcWR3Tmw5Y01ZdTQ3?=
 =?utf-8?B?THROWDNEdEpJMmxMdURxSEc3Sm1MWnVkNFRFL2tQL0Z4c1ZPdUxJRjg1MVVK?=
 =?utf-8?B?VE11Slc2bFpEYXFRS3JkMlA4eXZ1bFhYb3lUMUFXVENvUGVKQ0loUnZjRHRz?=
 =?utf-8?B?SVYzQ0NwSEJGVlIySDdFS25POTMySjdFU0ZFVUFKSW0rWlNSd29INENlUHdR?=
 =?utf-8?B?NndFcXQ4cXd3dkp2cVc2L1dlblJLeDBvYlBEZWpHN2h3K2xobzh1OVdETzBS?=
 =?utf-8?B?azBkUGJDckYwbWlHV1c0TmNpc3BXTUZ1c3E3aTBiVk1zQm1LVmhWT0ZESSs0?=
 =?utf-8?B?cmQwYWl0VjB2aWpzdDdDbTlsTE5Ga2N4M0h4eGdHYmRIOTdGNWRSSklKSXN2?=
 =?utf-8?B?SFppRk9wSHJLWjYxOEFWMFBINi95em5OZzM5T3o0dy9xY3VQb0d1aEZlZGlj?=
 =?utf-8?B?ZVRHN2hwaUFEOTNPL0JOb1FuZEk0YXdZb0QrdkY2Yk5DVTFuVjZaRzV3N0p4?=
 =?utf-8?B?QVNnRVR1djVJc2UySUsySWJ2Y0JyQm8vYy84UFJDWGNlUFZBSDJJZC9hV2g4?=
 =?utf-8?B?SUhma25UQ0xlY1J5NUdNRmlFdlZwWFVXZm9rSDFEWWsyYUxVRk13OHZkRUVO?=
 =?utf-8?B?NWVJNWVSdWRKUlJsMWlYT2tNZGYzMythNHhzMWtsak4xYXMybGI5K3V5WXJM?=
 =?utf-8?B?NVdVdkdZbHJEcWkrUE1TZ0xUNjN3OXIxZGVybTF0dHhxRWlaSVUyOEJUQ0tS?=
 =?utf-8?B?SDhvSkFjVGhhSzE3eDRLVER5d09aWmwyUnlHbng4ckpmVTYxQlFyWjh1cjdG?=
 =?utf-8?B?U1hsT1hVTjMrTk5oZHRHYTZtV2MrYzZMNDFBVEFlRWQ0WG93OU5QVk1DaFcw?=
 =?utf-8?B?TktwVGRSUTZOYVo2ZEVBMHFpR3BJOVl3c1FwU3UwNXlyYU5XbnRDRUtyMmFp?=
 =?utf-8?B?Q0U5elRkbEV4UWN5WTFVUGdNTEdka0J2a0NoVVMvcVN4bUxGWFJqZXRvWXEr?=
 =?utf-8?B?R3RiS1ExSDJOQ2JrVVdxU1U2QmJSZGg4ZHo0cS9kM1ozTDk1NCtOUlhESklo?=
 =?utf-8?B?ZGdlb2Vqdm1JMXZaRDJWbnI0Q2hFQW84M1g0R1daQ01qd1ZpNUdtVWxnTTV2?=
 =?utf-8?B?RDEyTkdZUXNaQnBKZjdlNmsvV1BpUkszM0JQRTR0NXVtRTIxSTV5TjgxZlJF?=
 =?utf-8?B?RTgrZEZCV1F5N1ZvLzhrQTRFUk0rZ05tMkFubmRDc0luTnV4OVRLNTRHVmV3?=
 =?utf-8?B?ckk0YTNkclNKSHMwclRiUDFybmYvTXNuZlVSV09GeUowNGpydG5tRHpzTDRz?=
 =?utf-8?B?cDJOY3pnUnlDcWdEaFVsMjZhSEJHZ3liYWFKZ0Q1ZzhHVzlHRlIwaTZtckdK?=
 =?utf-8?B?OUhMQ0d6RXRZVHh4SEZoWE11VitnNHI0dXhRQyt0cVl1cDlFMis5czYwUU5Z?=
 =?utf-8?B?T3Q1dUY4NmRBdzdjS3JISUxQWlRFZ0pyTkUrV1dTRW8rekVuVUk5MW1YUGFq?=
 =?utf-8?B?VlN6VmYzVG5DK21KZTZ4MUh1SHdMWEJKN1lVbmUvdktHZWhJWUFxTGxrYVF1?=
 =?utf-8?B?MFlvdFBjN2FlcitUVHlEWE8yTCtJVDRwbmZSYk1tejFPM1VQaGh0TzUxS01Z?=
 =?utf-8?B?Qms3dUNQTTBzZ2tkb0lGa2FERVJBMitFbFY5Qy9hbjY3ME50Q3ZZTUFlUzlx?=
 =?utf-8?B?U3JLTWZETzl3WFFEMTlOZzBWMWlwSzdVWVQ2YW5vMW9xdzdmTEU3SUhEOXV0?=
 =?utf-8?B?bjB2MXJ2UXQrbHdkR29MeUhEL09HWitSVGcxUWM0bnBudUM4QnBuQjdPc0ts?=
 =?utf-8?B?NDhnMjVoemZoTndCRTZER1ZuUEkwQTcyL05UdmcyUDJUR1pqNDF0N1RyNjFU?=
 =?utf-8?Q?1RPkQdej9CQbpC+uJD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d2fb39-07e9-4997-08b4-08df020def5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:31:38.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eflJYPh66ZFxDGwvWuaH5iLQA22fp8emaRNBMjPAOK9Kn7ndaQxtJjoFlg4lduoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
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

On 8/19/26 20:53, Denis Pisarev wrote:
> Hi,
> 
> This RFC follows up on bugzilla 219492 ("failed to write reg 28b4 wait
> reg 28c6" after hibernation) and on the resume_gpu_stable proposal
> rejected in January:
> 
>   https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gmail.com/
> 
> The rejection argued that (a) kiq sched.ready is managed correctly -
> set false in suspend, set true again only after ring tests pass on
> resume - and (b) the proposed flag would have disabled the KIQ flush
> path permanently. Both points are correct, and this RFC takes a
> different route: nothing is disabled proactively; the driver reacts to
> observed failures.
> 
> MEASURED FAILURE MODE (Cezanne iGPU, Ryzen 7 PRO 5850U, 7.1.8, KDE
> Wayland, no ROCm):
> 
> - S4 resume -> "failed to write reg 28b4/28c6" + "1a6f4/1a706" pairs
>   begin in the same second as the thaw and continue at 80-140/hour
>   for 9+ hours until reboot. kiq sched.ready is true throughout (the
>   ring test at resume passed).
> - Two user-visible consequences: each failed flush burns the ~5 s KIQ
>   retry window (desktop-wide sluggishness), and the invalidation is
>   then silently dropped (stale TLBs - correctness).
> 
> TRIGGER ISOLATION (single-variable tests, one hibernate cycle each):
> 
> - stock (GFXOFF allowed across S4):    ~70-140 errors / 30 min of use
> - GFXOFF held off across S4:                    0 errors (30 min)
> - GFXOFF re-enabled 40 min after the clean
>   resume:                                      0 errors (15 min;
>   gating resumption not independently verified)
> 
> So the wedge forms in the S4 resume window while GFXOFF is allowed,
> and is consistent with the existing semaphore workaround comment in
> gmc_v9_0.c about losing invalidate-acknowledge state across
> power-gating cycles. A boot-time amdgpu.pg_mask=0 does not even
> initialize on this part (probe -ETIMEDOUT), so runtime debugfs
> control was used.
> 
> THE PATCH (1/1):
> 
> - amdgpu_gmc_fw_reg_write_reg_wait() returns -ETIME on failure and
>   counts consecutive failures
> - gmc_v9_0_flush_gpu_tlb() uses its existing MMIO path as fallback
>   when the KIQ submit fails (invalidations no longer dropped), and
>   after 3 consecutive failures skips the KIQ path entirely until the
>   counter resets - so wedged systems stop paying 5 s per flush
> - counter resets on every success and in gmc_v9_0_hw_fini(); each
>   suspend/resume cycle re-arms KIQ. No proactive disabling anywhere.
> - gmc_v10/v11/v12 call sites unchanged and compile-safe (int return
>   used as statement); extending the fallback to them is trivial once
>   the approach is agreed.
> 
> This mirrors what the sibling PASID path already does (KIQ submit,
> -ETIME on timeout, MMIO variant as fallback), applied to the per-VMID
> path.
> 
> OPEN QUESTIONS:
> 
> 1. Root cause in the S4 window: RLC/ME not processing KIQ invalidates
>    while GFXOFF is allowed? Happy to run tracing (amdgpu.vm_debug,
>    VM_INVALIDATE ack registers) on the affected hardware on request.
> 2. Should the latch be per-xcc-inst?
> 3. Should amdgpu_gmc_flush_gpu_tlb_pasid()'s KIQ branch share the
>    latch?

That still doesn't make any sense at all.

First of all GFXOFF completely turns of the CP/ME/KIQ, so sending *anything* to the KIQ including the ring test would fail.

Then second fallback is simply not an acceptable option, it is a *must* have to have a working KIQ.

Regards,
Christian.

> 
> Patch 1/1 follows. Comments very welcome - especially on whether the
> failure-driven fallback is the right shape vs. fixing the S4 resume
> ordering directly.
> 
> Denis Pisarev
> 
> Denis Pisarev (1):
>   drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
>     unresponsive
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> --
> 2.55.0
> 

