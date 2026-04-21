Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A11BF5A8D1
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 02:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7AD410E1A5;
	Tue, 21 Apr 2026 02:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1iIMklr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761D610E1A5;
 Tue, 21 Apr 2026 02:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ih9gYdxd0nvyvhsAahE4l8242ibTWx3Tdapj0WQo9Lg4pNHsNx4SaU2jm4NL0Xt5KuyjRsn8YQqFyoof2IgW/GFQFimNkwzBUDSWJzv+/bBKXmcikE5nm6bnYXfMV4O+ILu3SDImc8tBr9i+sRe2MJLGqj72SiLYxHq0Yw5JuRkZdfd9EmyBGdHIycaJZhjMoutba+u1oZPMIJjA+er/PxjEpnH1wdpoLdLTtRpVnZxqnRM0LnhDSLk9mRlHjvzPohnxYW4ZgxdCJurqw49S2QDuRE8ePkfDE+gGdFxgeYVgOvcod3iyZEpyGyt3FQiGQIrP+ZSUOu0XB+sexpha2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQ07N2t/IZmfi3edK4DiMgMKnWHBFwqWzHk7jP+7F5s=;
 b=tCjX1dpEjCrpeGv+sMzDvYjc+QCbsrZQBfglZNtuKG5yMIJt9bNj+hSh1rnl2sacx1BqUG9gNc4M5RJ8mwG4jxF6+sLDDH3Js0fB1NJG8SCYFA9TwW8H/f/PW7oHxYhxFVoot6uzIT13Fl6ma4jiRfLYNTlZrb5U/57TEkCPEVErqWAFlPZ1tNQBxwKj5qlz+HfOUlG0XwRlTkOumyw9sUKPVXzQKHD2LQHojomXU8ZeFmwdNpXTQmmrKVBnnM9pnACy5ee1TLE8MfV++tnUyEOeWBpd6YwkIMQsnR6lyYoK9ZLQGKoBvWcKiQxZC8c+W9A/hrUBMoNHSh+Oia9fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQ07N2t/IZmfi3edK4DiMgMKnWHBFwqWzHk7jP+7F5s=;
 b=U1iIMklrNMX0A+s7dhXp+Fl78X70Eb8TQaSrUJmqzNxlduxXfk3+a7TcQAdnFlfXpE+ts/mdVLZ3Bzip5P9TMG1PkwcBZDhpD7TPTRad3fAs8BvU/qMcHalVfMFpxKPrbVP1GP8bVjit4C0L3mEY2Z1FeTSwNssCuRI3BHmACzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 02:31:31 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 02:31:31 +0000
Date: Tue, 21 Apr 2026 10:31:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: Honglei Huang <honglei1.huang@amd.com>
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Christian.Koenig@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Lingshan.Zhu@amd.com,
 Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 honghuan@amd.com
Subject: Re: [RFC V3 00/12] drm/amdgpu: SVM implementation based on drm_gpusvm
Message-ID: <aebhbe9gMAqz1tpM@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: fae8b426-8e4d-43c9-6b2e-08de9f4e18cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zADk7thEZm5T0Ja9EpSVQSghw+Qebt9EdIG7VMB+0yGcVYd9OKQRM68K2YxhyxO1xtpY3OTMPRs2NAb8hFyUT7G6p0KIB9mn5UJKwlg6q+ov5L70YQQos1zKxlWHAn4ct8SwSKQqS4+S3IVVgb7aMNj7nBdqis/4zh1lvUb9yDg0+aA7eurgn1KCYWNlJFk76PKmvvWj0aRuZqEEEy1GKuv7E2kIScwgnvrYjJmjkBNZGomkru/FV2bwss+XEwhemfjT3Ei7SZRcrDgPRgoX8fnhcuuXjB0ee5LRa061mHFMk8393w+nm4Z5EjMiLaDaU2ay9yHV+L+QllEFLtwfr1iu4iq9V3CMZ6MENNO9QOa21a2r0GOhSd6il8cGIld5LpTXfFg3DkO+fv0DiqbJN7BE8UhQcQkjh2/A4qPSl8x1u0h+aZV289I/7e8ecXOLvxr2elxzyztEru6Pz7fUFIQtWw0jj3ulVwp6/Y6bzXDm39cp0lAzBoS77REq0esguSobv4OSCexBrnIpEECtEdWXwlGuekMY7K8/ww3nMrIrhQvl4lCSJj0sB/ZDReFqniXkY3XkdLClBtQjtQg3KeRrYZAa5SD/TxDlMi5RBrD4HxV9vTuMVQz9GPc04IPCMtf6lBGI4iGdXaAyFYHVmsG16Em6Hxsy+Hfz0os5Ftv0X656FCUfQQT+/K0icpzRPuTDUI9QJsuJa+zef0GnMLogtxcyEAnlnmAPzQxR3aIbTZam9TWEnkdqQopzAhHg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rh93LDXQwBii+DYLsd2bVWCDbW04ag/LzJcu6OO9FGgemNnhYXlXW91duBx?=
 =?us-ascii?Q?Yo/c8uyeUj7k0v/eMvFxbH3+vSAqd0F9YTCcpALogo16hNPtWO/QCoIew+p4?=
 =?us-ascii?Q?RmuVzlYILTl44KIAkubBpvf9+JxkGUDSGet3QEFoc4sGwVZ3/m53fz0Sw6lF?=
 =?us-ascii?Q?Ap142Xd9qzzn2rLuCPM7/PXQ/XV6JVj1gb5M8uGka0zWQ2xFLvYg5fjxSyxg?=
 =?us-ascii?Q?SpRXLZwl5TS6y7RdTRTsxf7FDobVKxzJZekBEwW/U/ywtVcC77hTwKEhOTZP?=
 =?us-ascii?Q?wRUYT/lvoEKRt8pZ2y+oPZREwrlrhe9quHVTnb/ALN+GPgY4mzrDNotuedqa?=
 =?us-ascii?Q?2FBGL6+M71rsdw3ggmJAtrzE2Io47SY7fwEkY0LrGewx/BBo/0O2Ay2Fr34g?=
 =?us-ascii?Q?lOWA/ua4x2Emzx9lf5ARlrukAJL34AZEk9KehkL9s3qZugA5D7BFLsYKoPCS?=
 =?us-ascii?Q?2NeBGnRWBzxXtpqHaeWEkKM4JNPG9o5WCcqIFo6nrxTiWTIQ8Tiy7f6SpAQ/?=
 =?us-ascii?Q?0VhIp0MvWpGDCw5z6gvdaX8HKYQqR1XLZYBtXK+6x9oUhIRgydNtqE53mxA0?=
 =?us-ascii?Q?lb718tSMZv1tO97KAH14G2+SqZIV3GoSt7BmxnH5AWkj0Js/GntHx2IESmy+?=
 =?us-ascii?Q?J5cdkXHg0ivQP4zFmFAuiYsBtXM9crGChtF3CBWniylEOrknzZIx+AXf8FN4?=
 =?us-ascii?Q?zXAG0aHm+yXCIPlzzJT2Srh8IIBQZsQ734IiEQ8ufKXJHEUr7t3lzjDiEftE?=
 =?us-ascii?Q?Fl/Gkf7ixaXYpnIDTBmMMYfAI1lk6xZToVhqpgvEgvAy2hNaDzObsbE8I8u3?=
 =?us-ascii?Q?Q0C0pZ9ms6OSu/+Yxv4gzTX+lMLH8P/Uyc0pQRgNb5jGORmtYtxLjnJh37zB?=
 =?us-ascii?Q?0wZNGdy0mv+yw3iKhMwgFffEWReXgFMaCaMkJGXViIgAwLGec6oKUhQQEgQM?=
 =?us-ascii?Q?+NFxrOOcpdMcg8iGd2F9VFX1DUkXrjvVFKROaXr7CyN4PuYqq9vNEy1cVkDA?=
 =?us-ascii?Q?D5h1WWr7Zgeh6xPIP314uG07XCU2ce5McBDRNo4IHyM2asm0Gtu8n+PRQt+N?=
 =?us-ascii?Q?epyETLfMgt77XN4YFYCnredL13UqFUJcX486KUZ2rscPZj0oXKwTUHnS7zwJ?=
 =?us-ascii?Q?QQC12tdSZyfGjDtsWiujRoyptc6F0OY8pHDHDv0Xgy/hcv8hLdRyfsE4Qs0O?=
 =?us-ascii?Q?8ahXOHZqbuwpOK81KcWVVLVNUN1nhAyarpjQ2kwf7AOph8WPNqehS1UzQjsA?=
 =?us-ascii?Q?QjGKsEnT7r/4hEeyylvsG4wLfglpm7qMN/iIP6Yn8z6il1EoCb2SmOZp1/G8?=
 =?us-ascii?Q?NEbpV9eLZxTk9jA6BL0PZk+YatWYREbYm72RWly53UiBgZDpr1K1nlIXz9Ec?=
 =?us-ascii?Q?Uq0WjKiH1/HalG8g7NAqUgsj3vk6LgIAFmBjjrJnZtFKpZUTsjR7+UoBU1jT?=
 =?us-ascii?Q?5LWsYUzmzX5U6WtseCBpf6+mWNeVZ2uWKHElO7d42OmDkY+qhxrMAdnhK71r?=
 =?us-ascii?Q?NQO7qNegQj/LSYwA71Mq3Tiy2pT/Iu051g2WD8YOy+Vsqxayk5Dvc6V5bvCp?=
 =?us-ascii?Q?zbdXS2mlPfy/2Wi4sGNV05Cmc0nP3U/GZ1jo0FSjPc0TQwpJuIS+PKF2UZiU?=
 =?us-ascii?Q?x5YySs1WBO8rqlfl5nv0mcNIBLHtK5uMbc6jxpNuANsoFi5DzaDu8gPxR77n?=
 =?us-ascii?Q?OcV+ETI0ugy1xPT+lvJ/c4LPs9fTrskwrzzsuzQMIFYyv+FW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae8b426-8e4d-43c9-6b2e-08de9f4e18cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 02:31:31.1117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfdQHxeIWiJuH3yGdwSNAJTPmytA+OszL8ZZypzfvY+9gLAcy5gu7hJK2wgEL6879e4WsuW+zlbe9IPIISQG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091
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

On Mon, Apr 20, 2026 at 09:12:55PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> V3 of the SVM patch series for amdgpu based on the drm_gpusvm framework. 
> This revision incorporates feedback from V1, adds XNACK on GPU fault handling,
> improves code organization, and removes the XNACK off (no GPU fault) implementation
> to focus on the fault driven model that aligns with drm_gpusvm's design. 
> The implementation references extensively from xe_svm.
> 
> This patch series implements SVM support with the following design:
> 
>   1. Attributes separated from physical page management:
> 
>     - Attribute layer (amdgpu_svm_attr_tree): a driver-side interval
>       tree storing per-range SVM attributes. Managed through SET_ATTR
>       ioctl and preserved across range lifecycle events.
> 
>     - Physical page layer (drm_gpusvm ranges): managed by the
>       drm_gpusvm framework, representing HMM-backed DMA mappings
>       and GPU page table entries.
> 
>     This separation ensures attributes survive when GPU ranges are
>     destroyed (partial munmap, attribute split, GC). The fault
>     handler recreates GPU ranges from the attribute tree on demand.
> 
>   2. GPU fault driven mapping (XNACK on):
> 
>     The core mapping path is driven by GPU page faults instead of ioctls.
>     amdgpu_svm_handle_fault() looks up SVM by PASID, runs GC,
>     resolves attributes, then maps via find_or_insert -> get_pages
>     -> GPU PTE update. For unregistered addresses, default
>     attributes are derived from VMA properties automatically.
> 
>   3. MMU notifier invalidation:
> 
>     Two-phase callback: event_begin() zaps GPU PTEs and flushes
>     TLB, event_end() unmaps DMA pages. UNMAP events queue ranges
>     to GC for deferred cleanup. Non-UNMAP events (eviction) rely
>     on GPU fault to remap.
> 
>   4. Garbage collector:
> 
>     GC workqueue processes unmapped ranges: removes them
>     from drm_gpusvm and clears corresponding attributes. No
>     rebuild or restore logic, GPU fault handles recreation.
> 
> Changes since V2:
>   - Add version tittle in commit message.
>   - Fix some content mistaken.
> 
> Changes since V1:
>   - Added GPU fault handler: amdgpu_svm_handle_fault with PASID-based
>     SVM lookup, following the standard flow: garbage collector ->
>     find or insert range -> check valid -> migrate (TODO) / get_pages
>     -> GPU bind/map.
> 
>   - Removed the restore worker queue entirely. V1 had separate GC
>     and restore workers: restore workers were responsible for 
>     synchronously restore in queue stop/start cause no GPU fault support.
>     With XNACK on fault driven model, synchronous restore is unnecessary,
>     the GPU fault handler recreates ranges on demand. The GC worker in 
>     V2 is simplified to only discard ranges and clear their attributes, 
>     with no rebuild or restore logic. AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED
>     support is removed as no restore worker.
> 
>   - Reworked MMU notifier callback (amdgpu_svm_range_invalidate):
>     V1 had a monolithic dispatcher with flag combinations and
>     queue ops (CLEAR_PTE/QUEUE_INTERVAL, UNMAP/RESTORE) plus
>     begin_restore() to quiesce KFD queues. V2 uses a two-phase
>     model: event_begin() zaps GPU PTEs and flushes TLB,
>     event_end() unmaps DMA pages and queues UNMAP ranges to GC.
>     Non-UNMAP events (eviction) just zap PTEs and let GPU fault
>     remap. Removed begin_restore/end_restore callbacks,
>     has_always_mapped_range() check, and NOTIFIER flag dispatch.
>     Added checkpoint timestamp capture on UNMAP for fault dedup.
> 
>   - Added amdgpu_svm_range_invalidate_interval(): when userspace
>     sets new attributes on a sub region of an existing attribute
>     range, the attribute tree splits the old range and the new
>     sub region gets different attributes. However, existing
>     drm_gpusvm ranges may across the new attribute boundary
>     (e.g., a 2M GPU range covers both the old and new attribute
>     regions). This function walks all gpusvm ranges in the
>     affected interval, zaps GPU PTEs and flushes TLB. Ranges
>     that cross the new boundary and old boundary are removed 
>     entirely so the GPU fault handler can recreate them with 
>     boundaries aligned to the updated attribute layout.
> 
>   - On MMU_NOTIFY_UNMAP events, discard all affected gpusvm ranges
>     entirely without synchronous rebuild in v1. The unmap may destroy
>     more ranges than strictly necessary (e.g., a partial munmap
>     hits a 2M range that extends beyond the unmapped region), but
>     the attribute layer preserves the still valid attributes for
>     the remaining address space. When the GPU next accesses those
>     addresses, the fault handler automatically recreates the
>     ranges with correct boundaries from the surviving attributes.
>     This avoids the synchronous rebuild logic that V1 required 
>     (unmap -> rebuild in GC/restore worker).
> 
>   - Add attribute creation for unregistered addresses:
>     amdgpu_svm_range_get_unregistered_attrs() derives default
>     SVM attributes from VMA properties and GPU IP capabilities
>     when the faulting address has no user attributes registered.
>     this feature is needed to pass ROCm user mode runtime tests:
>     kfd/rocr/hip. ROCm supports no registered virtual address access
>     with default SVM attributes before, so amdgpu svm needs to support.
> 
>   - Explicitly returns -EOPNOTSUPP in amdgpu_svm_init when XNACK
>     is disabled. V1 attempted mixed XNACK on/off support with
>     complex KFD queue quiesce/resume callbacks and ioctl driven
>     mapping paths, which added substantial complexity. V2 drops
>     these implementations to focus on the fault driven model.
> 
>   - Removed kgd2kfd_quiesce_mm()/resume_mm() dependency that V1
>     used for XNACK off queue control. For XNACK on, the GPU fault 
>     handler is the enterance for SVM range mapping, so no quiesce/resume
>     is needed for this version. 
> 
>   - Added new change triggers: TRIGGER_RANGE_SPLIT, TRIGGER_PREFETCH.
>     for sub attr set and prefetch trigger support.
> 
>   - Added helper functions: find_locked, get_bounds_locked,
>     set_default for GPU fault handling.
> 
>   - Design questions section removed.
> 
> TODO:
>   - Add multi GPU support.
>   - Add XNACK off mode.
>   - Add migration or prefetch. This part work is ongoing in:
>     https://lore.kernel.org/amd-gfx/20260410113146.146212-1-Junhua.Shen@amd.com/
> 
> Test results:
>   Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on:
>   - KFD test: 95%+ passed.
>   - ROCR test: all passed.
>   - HIP catch test: gfx943 (MI300X): 96% passed.
>                     gfx906 (MI60):99% passed.

It would be best to also include the ROCm runtime merge request in the
cover letter, and clarify that the above test results are based on V3 +
user-space ROCR.

https://github.com/ROCm/rocm-systems/pull/4364

Thanks,
Ray

> 
> Patch overview:
> 
>   01/12 UAPI: DRM_AMDGPU_GEM_SVM ioctl, SVM flags, SET_ATTR/GET_ATTR
>         operations, attribute types in amdgpu_drm.h.
> 
>   02/12 Core header: amdgpu_svm wrapping drm_gpusvm with refcount,
>         attr_tree, GC struct, locks, and VM integration hooks.
> 
>   03/12 Attribute types: amdgpu_svm_attrs, attr_range (interval tree
>         node), attr_tree, access enum, flag masks, change triggers.
> 
>   04/12 Attribute tree ops: interval tree lookup, insert, remove,
>         find_locked, get_bounds_locked, set_default, and lifecycle.
> 
>   05/12 Attribute set/get/clear: validate UAPI attributes, apply to
>         tree with head/tail splitting, change propagation, and query.
> 
>   06/12 Range types: amdgpu_svm_range extending drm_gpusvm_range
>         with gpu_mapped state, pending ops, work queue linkage,
>         and op_ctx for batch processing.
> 
>   07/12 Range GPU mapping: PTE flags computation with read_only
>         support, GPU page table update, range mapping loop.
> 
>   08/12 Notifier and GC helpers: two-phase notifier events, range
>         removal, GC enqueue/add with dedicated workqueue.
> 
>   09/12 Attribute change and invalidation: apply attribute triggers
>         to GPU ranges, invalidate_interval for boundary realignment,
>         work queue dequeue helpers, checkpoint timestamp.
> 
>   10/12 Initialization and lifecycle: kmem_cache, drm_gpusvm_init
>         with chunk sizes (2M/64K/4K), XNACK detection, GC init,
>         PASID lookup, TLB flush, and init/close/fini lifecycle.
> 
>   11/12 Ioctl, GC, and fault handler: ioctl dispatcher, GC worker,
>         and amdgpu_svm_fault.c/h with full fault path including
>         unregistered attribute derivation and retry logic.
> 
>   12/12 Build integration: Kconfig (CONFIG_DRM_AMDGPU_SVM), Makefile
>         rules, ioctl registration, and amdgpu_vm fault dispatch.
> 
> Honglei Huang (12):
>   drm/amdgpu: define SVM UAPI for GPU shared virtual memory
>   drm/amdgpu: introduce SVM core header and VM integration
>   drm/amdgpu: define SVM attribute subsystem types
>   drm/amdgpu: implement SVM attribute tree and helper functions
>   drm/amdgpu: implement SVM attribute set, get, and clear
>   drm/amdgpu: define SVM range types and work queue interface
>   drm/amdgpu: implement SVM range GPU mapping core
>   drm/amdgpu: implement SVM range notifier and GC helpers
>   drm/amdgpu: implement SVM attribute change and invalidation callback
>   drm/amdgpu: implement SVM initialization and lifecycle
>   drm/amdgpu: add SVM ioctl, garbage collector, and fault handler
>   drm/amdgpu: integrate SVM into build system and VM fault path
> 
>  drivers/gpu/drm/amd/amdgpu/Kconfig            |  11 +
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  13 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       | 467 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       | 162 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  | 952 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h  | 144 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c | 368 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h |  39 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 863 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h | 148 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   4 +
>  include/uapi/drm/amdgpu_drm.h                 |  39 +
>  14 files changed, 3231 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> 
> -- 
> 2.34.1
> 
