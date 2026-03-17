Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27841F33817
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BD310E5B2;
	Tue, 17 Mar 2026 08:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9NDekBU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B3010E5B2;
 Tue, 17 Mar 2026 08:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McFP/BHU2lrs9KIM8sH4EYMx4QIA0mA4u/AGQToH5h/gZJdQ5LbUWdmhQTqm+ZHbxrZ7PnTUfXd6U4rKPJ5Bfa5uEFkGgb0uD3Y+z7hU5XYtEwxvIdSoTQal1kdsEDQUzNS2wJaZgfVVR3/8MbNlmnQvnDlzofOQldHUOmPEHM6NlUevffhzXPJMAZb4K3RJ4c7dlYWkF5lFZIdaExcU/DAl+B8ooqh14HfBDeDxMqMbMagOlh7NKC23CRQBf4XEqoqpKy/Ya34mQbBxFS8AXY/hRXVh8RfXYQAqwoDd40rs/G+SI6eeRlGbVA55oywWOs7W4+fHDyh+h2Bkq03z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjAH2CPR6LqL1bvyDzBf7uCFbAunSz6uqxeQ2CcVUo0=;
 b=yXenGQUcyeo1+o12SwwgdE+Dz8bMunKbiMRoES76X4WmOS130+adooFOanxPJ6b8u1atzkeBfXsQp/75/EaxKceI3CVV5GD6+QZfwrcuR+veAWXOuz4IOE0AM8FjP3L6rgXY+ssWwNJ0jMkiLlTvaSqKQ3oPxqnQCUuCZPhQ6/G9xQyYddSdHmkL5k7DTtnUZAKbdSBV9ESRIXq3XeeFnEtkMC6+10xvwZb9ylE6VsmffqcTP1DRqP/24FXq4eDbU5U9ERoK5ExP0djlM2/efWqPTE1Ck5JiYba9rA4o5zxXyRPZkye4Qpj7X/KBPGKM2ILIDr1E+YUMLsg4jPLY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjAH2CPR6LqL1bvyDzBf7uCFbAunSz6uqxeQ2CcVUo0=;
 b=B9NDekBUg/e9iaS++kne7yjBNnrT4kqpvNOuNYv2pr+kXRtDEWrSxFNqTfBCqKyytdRcDY0/R2HV37tl/wD5CT7iZiiDBsCd6e5m/H2j1PMvVETRjxYU1UtXD61R8tVatk64giVMEn/kIYUeAJGAWyOE4TYXJ5rMPUImVF+7oZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 08:47:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 08:47:25 +0000
Message-ID: <8a0a65eb-27c7-4d6d-81a5-2f8dcbfd9673@amd.com>
Date: Tue, 17 Mar 2026 09:47:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260316043255.226352-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6b0282-adcb-414d-6dd3-08de8401cfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TcRB5fthwWEgYeYKUHn/NdI/ClBRLZ3jaswcUtHATVsGa0hi/jD/u/3Ahrf+GOQJAd0X1HYA7jeyMtqyTFRej+NoIptttWg77dhMD8C5SHe/YtHWmEyBWfvUBkfH+XGD01dS7g8vWWb3AtOd08BvlBUOboPd2RxSKk2nAVlxJzVslCTeOnNpGikaIaA/9cW9LRn529C4dZXlM8WVcjsI+rivL985spmDsdXeDkANwsaW196b+cMvg2bQqLdCaGTcdRoGu+VP5iKaD0iX94q6wnHC9qdtF38cNslR+WS6/QgMjN4JQEBF5TUB2SfbTFsXSJlEuzcfONnUmeC/nKqDShtmsoJjy69yao1vR8G2koxr8MAeFVFvE6mEsdtFKTBrBd1UkB6Sa90LOUFPICoxA7Uhr2/AwefsHj5QvEse9vtIbZLS0DAfO9pS18jg38JyBVxZGOoSdy6o+H3V0M8U1VH6bGof85Ak4gyEkqYqLHAIfeIUJytgsl4Dht7yoHr/lGJgd4SupuL7ew8RUWqSg0KIamo6QXw2Wvw5NIhwU0i9hN4QAJknt9WbEbSMWq9gc2cyWDQoC6FPKjmerX8Dv65Sa+5MKfWW3kSqpUJStRFB+9HVFxCO0Ic6onpcP8/lGFCIAY/mLkhvT5RE/UC2Pp/aVIpjxj1EmeNWysVDHfeL01tVQ/iwPfhVDwFVrFLpIR9WiXJGmC1L7EVO189btix/JJjLZItoq17Jy2gXiMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWEvSnhJMjhxL0RVTUZUakZlMzlKZDM3MUFRZU1DY1k1WXh6WkR3cVp4ekhp?=
 =?utf-8?B?U3Y2ZkpxRy82NksrSnpJcGRmbzlDb0VVSU82TDg5dzdlQkt3N1p4TEkya25r?=
 =?utf-8?B?aXdhcDFibDRPVExyaXFmYkRCRDlOS1VTYkltcTF2bzVoS3pnMWxOT2JLeC9E?=
 =?utf-8?B?dnpWS2tvek53d3JwdzlRUkdsdlByanVOWDd1RTc4U2cvcmFreXlTVVFSOU5S?=
 =?utf-8?B?RFc0c2xmdGdUQTBXNEpyK25SWDNBSU1KN21td1ZvQk1YREY3ZFFoZy91N3g0?=
 =?utf-8?B?cnVrOVl0bnJJamd5ZXZ0OGhBZFBrM3ZLc0Z1MExzZFhyT3Y2WVNlSkdScDZv?=
 =?utf-8?B?UDBtY1BJbVNPeHUwS09lZlYza2J4VDBUYktIcTBMSW9jNURPYUg4WnZONnJm?=
 =?utf-8?B?bmIxdU9TVjl4Znd6SG0zSUsrU3dHZEc4NGU1cHNKQVNJblRZeFZTVE5udkkw?=
 =?utf-8?B?MzBINC81VTYxbzROZlRNUXVqdnJmbnlhMDFSMUgvMkIzcmo4ZHg0QklJWWtM?=
 =?utf-8?B?UGxwRXhyWFV6VlVHaGNKaDREcHdFSFJEbURGT0pBc216L2svdlh6VldOclVQ?=
 =?utf-8?B?N2ZJbDQyZElxUkl0c1NweTBEbGFrcllQYzNsYzY5dGpDWkdXbVVzbHRLQUpi?=
 =?utf-8?B?UUU1SjhBay9ueXpudURtVlhMZHdkSkJyaXF1T29sRFBYY0hTays4VWtReVRp?=
 =?utf-8?B?NFhIeGx5cVhnc2FtNzZWUWlCOUk0azBzYUltVXJIM0x4MWFjaHUrbkptdEJM?=
 =?utf-8?B?dzNEaVF5Ti9XcmRIMTNnb1VBM29NcXBia1VSTjZyeW1MYm94NGdtbitxTzJt?=
 =?utf-8?B?alNudDJrQ043Z3p6THJRejNoczZvdFpZVVhlTE8xcUQ3SlF0RHV4NGl5cTJh?=
 =?utf-8?B?dmNjR2xUNjM4OWVSNmEwUmRGYmtJbFkwTVUzUlI0RUJaMXRlYk5oRVhPOXl2?=
 =?utf-8?B?Z2c4U2tneG9iUkVDSmxPa0xCdGF6Z28zYW1NTllNS0g1aUM3bEVQUlUxNHkv?=
 =?utf-8?B?MkZFaDNCSVNpYjdVU1ZKQXRHYzV5dFJjd3NsR0VXeHBNTjBYQkJJYnNXbHlm?=
 =?utf-8?B?eTFia2Y2cTFFL0JwZU9jamhnK05UU09oT1lIanovdzc4MXQwMzBiREtTUnBB?=
 =?utf-8?B?QkZhU2c5dzlCNDF1NUZKM05vVTZkbUR3Q2dxYS85SXVwclRRb21XK3ZnM0dM?=
 =?utf-8?B?bUxDOXdZeDNDUnBmeUJpeGlET0hqUHpxOFJhL1dYM2Y3YWo5cFNseHg2OFk4?=
 =?utf-8?B?bG9CRkNmSG9WbFdsMktKN21KUXhGMEpXcGRUcXhRSmpJQ3FPclBpRVg1Y3JQ?=
 =?utf-8?B?T3JtNmxGajNMaldzcFc2aHdHalJxb01tcjhsenorL2x3WFdGRW1HeSt5dzE3?=
 =?utf-8?B?OGxqdWI0N3g2QUVnTWNMU1BYaGFyTmhCU3ZneFB6OTRlQ1RNY1dnZ01nZkQv?=
 =?utf-8?B?Q1oybllwdUI4UXlqT2FpZjRobHgrSlhKVEY2NUdwYjEvQktrdjBFVTRHd3Z4?=
 =?utf-8?B?eGJZQStRQnRjYzBCSUdEeFJubm96RWk3QmIvQmtCdjRPWTQ5eXczZ2trUXR5?=
 =?utf-8?B?TkVKUVF5WkZ1cDdtRDlDNnRNK3lMREN0dGh1L285bnp3VXhLZXE5QTlPZkY2?=
 =?utf-8?B?QmplNFN5ajdaVkNQR3Jwd2E5dHRLdTEvZFQ3NCtTNEI1eXlXdEJMWWU0SDZk?=
 =?utf-8?B?WjNxTzhhTEdXWS9zYUJGNGd4M2JmNFZ4c3BTd3hGbDdnWlpJK2syRkFNbGt2?=
 =?utf-8?B?TlBmUi9veFZFcmhyeXkyUUFQMWlBNmsxazdiMDg5eUgvNlltNDB3UFlnb0Jp?=
 =?utf-8?B?UFRkQ1J1ajZkaStRZHR6OUJHY3YvbjY1TmVVWitpQUNRVlkwYU50T2ZWaG51?=
 =?utf-8?B?dWs1cmJmNENRVzV2MEg5Q215aU15dk1XQ3ZpbldGT3RBN1FSVVVYSGpkbmdP?=
 =?utf-8?B?eCtSQmFHMS9KQjFyUDdwME1ScE1IU0d4VmpOV2VVYTZ5dVU2czZGRVFJOE9F?=
 =?utf-8?B?eGdjZmtUcTdhOFJaZ01udldwb2pKdytUbnB5RS9PeWZMRkR4YVJNS2NWK2pj?=
 =?utf-8?B?clFocWw4SjkydEsxUFZjVkZ2eStIcmxYSUV1dWZ1SjBUTlhQYjgrN01XaTA3?=
 =?utf-8?B?VmE0Uy9aa1hWMTV2UWE5bkhvZXc0OXRVNXVjbEcvQXlOYjZoRzNlS0thUzRH?=
 =?utf-8?B?bjZRdm90aUt0M001Ry8rK09UbmFseE5TMVBURWYxV3NYa2VSbGpGdkVvdmU2?=
 =?utf-8?B?cWU3QnF0MXk3bDVPS2RTS3NvWXpoYW1KSDk4SStJSDFJUUl1WWg0NEJBejkv?=
 =?utf-8?Q?LmAaAaSyz431YVWMDN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6b0282-adcb-414d-6dd3-08de8401cfa2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:47:25.0936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl40Jr3tuNwTcT0tLGzhyNePlDAXtTICqdPEJ7bMl1TnJP5uAzb3Zz77Z7kuq2Co
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

On 3/16/26 05:32, Matthew Brost wrote:
> Diverging requirements between GPU drivers using firmware scheduling
> and those using hardware scheduling have shown that drm_gpu_scheduler is
> no longer sufficient for firmware-scheduled GPU drivers. The technical
> debt, lack of memory-safety guarantees, absence of clear object-lifetime
> rules, and numerous driver-specific hacks have rendered
> drm_gpu_scheduler unmaintainable. It is time for a fresh design for
> firmware-scheduled GPU drivers—one that addresses all of the
> aforementioned shortcomings.
> 
> Add drm_dep, a lightweight GPU submission queue intended as a
> replacement for drm_gpu_scheduler for firmware-managed GPU schedulers
> (e.g. Xe, Panthor, AMDXDNA, PVR, Nouveau, Nova). Unlike
> drm_gpu_scheduler, which separates the scheduler (drm_gpu_scheduler)
> from the queue (drm_sched_entity) into two objects requiring external
> coordination, drm_dep merges both roles into a single struct
> drm_dep_queue. This eliminates the N:1 entity-to-scheduler mapping
> that is unnecessary for firmware schedulers which manage their own
> run-lists internally.

Yeah I can't count how often I considered re-writing the GPU scheduler from scratch.

But if that is done I completely agree that it should probably be done in Rust instead of C.

I've worked enough with save languages to aknoledge the advantages they have.

Regards,
Christian.

> Unlike drm_gpu_scheduler, which relies on external locking and lifetime
> management by the driver, drm_dep uses reference counting (kref) on both
> queues and jobs to guarantee object lifetime safety. A job holds a queue
> reference from init until its last put, and the queue holds a job reference
> from dispatch until the put_job worker runs. This makes use-after-free
> impossible even when completion arrives from IRQ context or concurrent
> teardown is in flight.
> 
> The core objects are:
> 
>   struct drm_dep_queue - a per-context submission queue owning an
>     ordered submit workqueue, a TDR timeout workqueue, an SPSC job
>     queue, and a pending-job list. Reference counted; drivers can embed
>     it and provide a .release vfunc for RCU-safe teardown.
> 
>   struct drm_dep_job - a single unit of GPU work. Drivers embed this
>     and provide a .release vfunc. Jobs carry an xarray of input
>     dma_fence dependencies and produce a drm_dep_fence as their
>     finished fence.
> 
>   struct drm_dep_fence - a dma_fence subclass wrapping an optional
>     parent hardware fence. The finished fence is armed (sequence
>     number assigned) before submission and signals when the hardware
>     fence signals (or immediately on synchronous completion).
> 
> Job lifecycle:
>   1. drm_dep_job_init() - allocate and initialise; job acquires a
>      queue reference.
>   2. drm_dep_job_add_dependency() and friends - register input fences;
>      duplicates from the same context are deduplicated.
>   3. drm_dep_job_arm() - assign sequence number, obtain finished fence.
>   4. drm_dep_job_push() - submit to queue.
> 
> Submission paths under queue lock:
>   - Bypass path: if DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set, the
>     SPSC queue is empty, no dependencies are pending, and credits are
>     available, the job is dispatched inline on the calling thread.
>   - Queued path: job is pushed onto the SPSC queue and the run_job
>     worker is kicked. The worker resolves remaining dependencies
>     (installing wakeup callbacks for unresolved fences) before calling
>     ops->run_job().
> 
> Credit-based throttling prevents hardware overflow: each job declares
> a credit cost at init time; dispatch is deferred until sufficient
> credits are available.
> 
> Timeout Detection and Recovery (TDR): a per-queue delayed work item
> fires when the head pending job exceeds q->job.timeout jiffies, calling
> ops->timedout_job(). drm_dep_queue_trigger_timeout() forces immediate
> expiry for device teardown.
> 
> IRQ-safe completion: queues flagged DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE
> allow drm_dep_job_done() to be called from hardirq context (e.g. a
> dma_fence callback). Dependency cleanup is deferred to process context
> after ops->run_job() returns to avoid calling xa_destroy() from IRQ.
> 
> Zombie-state guard: workers use kref_get_unless_zero() on entry and
> bail immediately if the queue refcount has already reached zero and
> async teardown is in flight, preventing use-after-free.
> 
> Teardown is always deferred to a module-private workqueue (dep_free_wq)
> so that destroy_workqueue() is never called from within one of the
> queue's own workers. Each queue holds a drm_dev_get() reference on its
> owning struct drm_device, released as the final step of teardown via
> drm_dev_put(). This prevents the driver module from being unloaded
> while any queue is still alive without requiring a separate drain API.
> 
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> ---
>  drivers/gpu/drm/Kconfig             |    4 +
>  drivers/gpu/drm/Makefile            |    1 +
>  drivers/gpu/drm/dep/Makefile        |    5 +
>  drivers/gpu/drm/dep/drm_dep_fence.c |  406 +++++++
>  drivers/gpu/drm/dep/drm_dep_fence.h |   25 +
>  drivers/gpu/drm/dep/drm_dep_job.c   |  675 +++++++++++
>  drivers/gpu/drm/dep/drm_dep_job.h   |   13 +
>  drivers/gpu/drm/dep/drm_dep_queue.c | 1647 +++++++++++++++++++++++++++
>  drivers/gpu/drm/dep/drm_dep_queue.h |   31 +
>  include/drm/drm_dep.h               |  597 ++++++++++
>  10 files changed, 3404 insertions(+)
>  create mode 100644 drivers/gpu/drm/dep/Makefile
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_fence.c
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_fence.h
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_job.c
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_job.h
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_queue.c
>  create mode 100644 drivers/gpu/drm/dep/drm_dep_queue.h
>  create mode 100644 include/drm/drm_dep.h
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 5386248e75b6..834f6e210551 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -276,6 +276,10 @@ config DRM_SCHED
>  	tristate
>  	depends on DRM
>  
> +config DRM_DEP
> +	tristate
> +	depends on DRM
> +
>  # Separate option as not all DRM drivers use it
>  config DRM_PANEL_BACKLIGHT_QUIRKS
>  	tristate
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..1ad87cc0e545 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -173,6 +173,7 @@ obj-y			+= clients/
>  obj-y			+= display/
>  obj-$(CONFIG_DRM_TTM)	+= ttm/
>  obj-$(CONFIG_DRM_SCHED)	+= scheduler/
> +obj-$(CONFIG_DRM_DEP)	+= dep/
>  obj-$(CONFIG_DRM_RADEON)+= radeon/
>  obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
>  obj-$(CONFIG_DRM_AMDGPU)+= amd/amdxcp/
> diff --git a/drivers/gpu/drm/dep/Makefile b/drivers/gpu/drm/dep/Makefile
> new file mode 100644
> index 000000000000..335f1af46a7b
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +drm_dep-y := drm_dep_queue.o drm_dep_job.o drm_dep_fence.o
> +
> +obj-$(CONFIG_DRM_DEP) += drm_dep.o
> diff --git a/drivers/gpu/drm/dep/drm_dep_fence.c b/drivers/gpu/drm/dep/drm_dep_fence.c
> new file mode 100644
> index 000000000000..ae05b9077772
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_fence.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +/**
> + * DOC: DRM dependency fence
> + *
> + * Each struct drm_dep_job has an associated struct drm_dep_fence that
> + * provides a single dma_fence (@finished) signalled when the hardware
> + * completes the job.
> + *
> + * The hardware fence returned by &drm_dep_queue_ops.run_job is stored as
> + * @parent. @finished is chained to @parent via drm_dep_job_done_cb() and
> + * is signalled once @parent signals (or immediately if run_job() returns
> + * NULL or an error).
> + *
> + * Drivers should expose @finished as the out-fence for GPU work since it is
> + * valid from the moment drm_dep_job_arm() returns, whereas the hardware fence
> + * could be a compound fence, which is disallowed when installed into
> + * drm_syncobjs or dma-resv.
> + *
> + * The fence uses the kernel's inline spinlock (NULL passed to dma_fence_init())
> + * so no separate lock allocation is required.
> + *
> + * Deadline propagation is supported: if a consumer sets a deadline via
> + * dma_fence_set_deadline(), it is forwarded to @parent when @parent is set.
> + * If @parent has not been set yet the deadline is stored in @deadline and
> + * forwarded at that point.
> + *
> + * Memory management: drm_dep_fence objects are allocated with kzalloc() and
> + * freed via kfree_rcu() once the fence is released, ensuring safety with
> + * RCU-protected fence accesses.
> + */
> +
> +#include <linux/slab.h>
> +#include <drm/drm_dep.h>
> +#include "drm_dep_fence.h"
> +
> +/**
> + * DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT - a fence deadline hint has been set
> + *
> + * Set by the deadline callback on the finished fence to indicate a deadline
> + * has been set which may need to be propagated to the parent hardware fence.
> + */
> +#define DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT	(DMA_FENCE_FLAG_USER_BITS + 1)
> +
> +/**
> + * struct drm_dep_fence - fence tracking the completion of a dep job
> + *
> + * Contains a single dma_fence (@finished) that is signalled when the
> + * hardware completes the job. The fence uses the kernel's inline_lock
> + * (no external spinlock required).
> + *
> + * This struct is private to the drm_dep module; external code interacts
> + * through the accessor functions declared in drm_dep_fence.h.
> + */
> +struct drm_dep_fence {
> +	/**
> +	 * @finished: signalled when the job completes on hardware.
> +	 *
> +	 * Drivers should use this fence as the out-fence for a job since it
> +	 * is available immediately upon drm_dep_job_arm().
> +	 */
> +	struct dma_fence finished;
> +
> +	/**
> +	 * @deadline: deadline set on @finished which potentially needs to be
> +	 * propagated to @parent.
> +	 */
> +	ktime_t	deadline;
> +
> +	/**
> +	 * @parent: The hardware fence returned by &drm_dep_queue_ops.run_job.
> +	 *
> +	 * @finished is signaled once @parent is signaled. The initial store is
> +	 * performed via smp_store_release to synchronize with deadline handling.
> +	 *
> +	 * All readers must access this under the fence lock and take a reference to
> +	 * it, as @parent is set to NULL under the fence lock when the drm_dep_fence
> +	 * signals, and this drop also releases its internal reference.
> +	 */
> +	struct dma_fence *parent;
> +
> +	/**
> +	 * @q: the queue this fence belongs to.
> +	 */
> +	struct drm_dep_queue *q;
> +};
> +
> +static const struct dma_fence_ops drm_dep_fence_ops;
> +
> +/**
> + * to_drm_dep_fence() - cast a dma_fence to its enclosing drm_dep_fence
> + * @f: dma_fence to cast
> + *
> + * Context: No context requirements (inline helper).
> + * Return: pointer to the enclosing &drm_dep_fence.
> + */
> +static struct drm_dep_fence *to_drm_dep_fence(struct dma_fence *f)
> +{
> +	return container_of(f, struct drm_dep_fence, finished);
> +}
> +
> +/**
> + * drm_dep_fence_set_parent() - store the hardware fence and propagate
> + *   any deadline
> + * @dfence: dep fence
> + * @parent: hardware fence returned by &drm_dep_queue_ops.run_job, or NULL/error
> + *
> + * Stores @parent on @dfence under smp_store_release() so that a concurrent
> + * drm_dep_fence_set_deadline() call sees the parent before checking the
> + * deadline bit. If a deadline has already been set on @dfence->finished it is
> + * forwarded to @parent immediately. Does nothing if @parent is NULL or an
> + * error pointer.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_fence_set_parent(struct drm_dep_fence *dfence,
> +			      struct dma_fence *parent)
> +{
> +	if (IS_ERR_OR_NULL(parent))
> +		return;
> +
> +	/*
> +	 * smp_store_release() to ensure a thread racing us in
> +	 * drm_dep_fence_set_deadline() sees the parent set before
> +	 * it calls test_bit(HAS_DEADLINE_BIT).
> +	 */
> +	smp_store_release(&dfence->parent, dma_fence_get(parent));
> +	if (test_bit(DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT,
> +		     &dfence->finished.flags))
> +		dma_fence_set_deadline(parent, dfence->deadline);
> +}
> +
> +/**
> + * drm_dep_fence_finished() - signal the finished fence with a result
> + * @dfence: dep fence to signal
> + * @result: error code to set, or 0 for success
> + *
> + * Sets the fence error to @result if non-zero, then signals
> + * @dfence->finished. Also removes parent visibility under the fence lock
> + * and drops the parent reference. Dropping the parent here allows the
> + * DRM dep fence to be completely decoupled from the DRM dep module.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_fence_finished(struct drm_dep_fence *dfence, int result)
> +{
> +	struct dma_fence *parent;
> +	unsigned long flags;
> +
> +	dma_fence_lock_irqsave(&dfence->finished, flags);
> +	if (result)
> +		dma_fence_set_error(&dfence->finished, result);
> +	dma_fence_signal_locked(&dfence->finished);
> +	parent = dfence->parent;
> +	dfence->parent = NULL;
> +	dma_fence_unlock_irqrestore(&dfence->finished, flags);
> +
> +	dma_fence_put(parent);
> +}
> +
> +static const char *drm_dep_fence_get_driver_name(struct dma_fence *fence)
> +{
> +	return "drm_dep";
> +}
> +
> +static const char *drm_dep_fence_get_timeline_name(struct dma_fence *f)
> +{
> +	struct drm_dep_fence *dfence = to_drm_dep_fence(f);
> +
> +	return dfence->q->name;
> +}
> +
> +/**
> + * drm_dep_fence_get_parent() - get a reference to the parent hardware fence
> + * @dfence: dep fence to query
> + *
> + * Returns a new reference to @dfence->parent, or NULL if the parent has
> + * already been cleared (i.e. @dfence->finished has signalled and the parent
> + * reference was dropped under the fence lock).
> + *
> + * Uses smp_load_acquire() to pair with the smp_store_release() in
> + * drm_dep_fence_set_parent(), ensuring that if we race a concurrent
> + * drm_dep_fence_set_parent() call we observe the parent pointer only after
> + * the store is fully visible — before set_parent() tests
> + * %DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT.
> + *
> + * Caller must hold the fence lock on @dfence->finished.
> + *
> + * Context: Any context, fence lock on @dfence->finished must be held.
> + * Return: a new reference to the parent fence, or NULL.
> + */
> +static struct dma_fence *drm_dep_fence_get_parent(struct drm_dep_fence *dfence)
> +{
> +	dma_fence_assert_held(&dfence->finished);
> +
> +	return dma_fence_get(smp_load_acquire(&dfence->parent));
> +}
> +
> +/**
> + * drm_dep_fence_set_deadline() - dma_fence_ops deadline callback
> + * @f: fence on which the deadline is being set
> + * @deadline: the deadline hint to apply
> + *
> + * Stores the earliest deadline under the fence lock, then propagates
> + * it to the parent hardware fence via smp_load_acquire() to race
> + * safely with drm_dep_fence_set_parent().
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_fence_set_deadline(struct dma_fence *f, ktime_t deadline)
> +{
> +	struct drm_dep_fence *dfence = to_drm_dep_fence(f);
> +	struct dma_fence *parent;
> +	unsigned long flags;
> +
> +	dma_fence_lock_irqsave(f, flags);
> +
> +	/* If we already have an earlier deadline, keep it: */
> +	if (test_bit(DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
> +	    ktime_before(dfence->deadline, deadline)) {
> +		dma_fence_unlock_irqrestore(f, flags);
> +		return;
> +	}
> +
> +	dfence->deadline = deadline;
> +	set_bit(DRM_DEP_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags);
> +
> +	parent = drm_dep_fence_get_parent(dfence);
> +	dma_fence_unlock_irqrestore(f, flags);
> +
> +	if (parent)
> +		dma_fence_set_deadline(parent, deadline);
> +
> +	dma_fence_put(parent);
> +}
> +
> +static const struct dma_fence_ops drm_dep_fence_ops = {
> +	.get_driver_name = drm_dep_fence_get_driver_name,
> +	.get_timeline_name = drm_dep_fence_get_timeline_name,
> +	.set_deadline = drm_dep_fence_set_deadline,
> +};
> +
> +/**
> + * drm_dep_fence_alloc() - allocate a dep fence
> + *
> + * Allocates a &drm_dep_fence with kzalloc() without initialising the
> + * dma_fence. Call drm_dep_fence_init() to fully initialise it.
> + *
> + * Context: Process context.
> + * Return: new &drm_dep_fence on success, NULL on allocation failure.
> + */
> +struct drm_dep_fence *drm_dep_fence_alloc(void)
> +{
> +	return kzalloc_obj(struct drm_dep_fence);
> +}
> +
> +/**
> + * drm_dep_fence_init() - initialise the dma_fence inside a dep fence
> + * @dfence: dep fence to initialise
> + * @q: queue the owning job belongs to
> + *
> + * Initialises @dfence->finished using the context and sequence number from @q.
> + * Passes NULL as the lock so the fence uses its inline spinlock.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_fence_init(struct drm_dep_fence *dfence, struct drm_dep_queue *q)
> +{
> +	u32 seq = ++q->fence.seqno;
> +
> +	/*
> +	 * XXX: Inline fence hazard: currently all expected users of DRM dep
> +	 * hardware fences have a unique lockdep class. If that ever changes,
> +	 * we will need to assign a unique lockdep class here so lockdep knows
> +	 * this fence is allowed to nest with driver hardware fences.
> +	 */
> +
> +	dfence->q = q;
> +	dma_fence_init(&dfence->finished, &drm_dep_fence_ops,
> +		       NULL, q->fence.context, seq);
> +}
> +
> +/**
> + * drm_dep_fence_cleanup() - release a dep fence at job teardown
> + * @dfence: dep fence to clean up
> + *
> + * Called from drm_dep_job_fini(). If the dep fence was armed (refcount > 0)
> + * it is released via dma_fence_put() and will be freed by the RCU release
> + * callback once all waiters have dropped their references. If it was never
> + * armed it is freed directly with kfree().
> + *
> + * Context: Any context.
> + */
> +void drm_dep_fence_cleanup(struct drm_dep_fence *dfence)
> +{
> +	if (drm_dep_fence_is_armed(dfence))
> +		dma_fence_put(&dfence->finished);
> +	else
> +		kfree(dfence);
> +}
> +
> +/**
> + * drm_dep_fence_is_armed() - check whether the fence has been armed
> + * @dfence: dep fence to check
> + *
> + * Returns true if drm_dep_job_arm() has been called, i.e. @dfence->finished
> + * has been initialised and its reference count is non-zero.  Used by
> + * assertions to enforce correct job lifecycle ordering (arm before push,
> + * add_dependency before arm).
> + *
> + * Context: Any context.
> + * Return: true if the fence is armed, false otherwise.
> + */
> +bool drm_dep_fence_is_armed(struct drm_dep_fence *dfence)
> +{
> +	return !!kref_read(&dfence->finished.refcount);
> +}
> +
> +/**
> + * drm_dep_fence_is_finished() - test whether the finished fence has signalled
> + * @dfence: dep fence to check
> + *
> + * Uses dma_fence_test_signaled_flag() to read %DMA_FENCE_FLAG_SIGNALED_BIT
> + * directly without invoking the fence's ->signaled() callback or triggering
> + * any signalling side-effects.
> + *
> + * Context: Any context.
> + * Return: true if @dfence->finished has been signalled, false otherwise.
> + */
> +bool drm_dep_fence_is_finished(struct drm_dep_fence *dfence)
> +{
> +	return dma_fence_test_signaled_flag(&dfence->finished);
> +}
> +
> +/**
> + * drm_dep_fence_is_complete() - test whether the job has completed
> + * @dfence: dep fence to check
> + *
> + * Takes the fence lock on @dfence->finished and calls
> + * drm_dep_fence_get_parent() to safely obtain a reference to the parent
> + * hardware fence — or NULL if the parent has already been cleared after
> + * signalling.  Calls dma_fence_is_signaled() on @parent outside the lock,
> + * which may invoke the fence's ->signaled() callback and trigger signalling
> + * side-effects if the fence has completed but the signalled flag has not yet
> + * been set.  The finished fence is tested via dma_fence_test_signaled_flag(),
> + * without side-effects.
> + *
> + * May only be called on a stopped queue (see drm_dep_queue_is_stopped()).
> + *
> + * Context: Process context. The queue must be stopped before calling this.
> + * Return: true if the job is complete, false otherwise.
> + */
> +bool drm_dep_fence_is_complete(struct drm_dep_fence *dfence)
> +{
> +	struct dma_fence *parent;
> +	unsigned long flags;
> +	bool complete;
> +
> +	dma_fence_lock_irqsave(&dfence->finished, flags);
> +	parent = drm_dep_fence_get_parent(dfence);
> +	dma_fence_unlock_irqrestore(&dfence->finished, flags);
> +
> +	complete = (parent && dma_fence_is_signaled(parent)) ||
> +		dma_fence_test_signaled_flag(&dfence->finished);
> +
> +	dma_fence_put(parent);
> +
> +	return complete;
> +}
> +
> +/**
> + * drm_dep_fence_to_dma() - return the finished dma_fence for a dep fence
> + * @dfence: dep fence to query
> + *
> + * No reference is taken; the caller must hold its own reference to the owning
> + * &drm_dep_job for the duration of the access.
> + *
> + * Context: Any context.
> + * Return: the finished &dma_fence.
> + */
> +struct dma_fence *drm_dep_fence_to_dma(struct drm_dep_fence *dfence)
> +{
> +	return &dfence->finished;
> +}
> +
> +/**
> + * drm_dep_fence_done() - signal the finished fence on job completion
> + * @dfence: dep fence to signal
> + * @result: job error code, or 0 on success
> + *
> + * Gets a temporary reference to @dfence->finished to guard against a racing
> + * last-put, signals the fence with @result, then drops the temporary
> + * reference. Called from drm_dep_job_done() in the queue core when a
> + * hardware completion callback fires or when run_job() returns immediately.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_fence_done(struct drm_dep_fence *dfence, int result)
> +{
> +	dma_fence_get(&dfence->finished);
> +	drm_dep_fence_finished(dfence, result);
> +	dma_fence_put(&dfence->finished);
> +}
> diff --git a/drivers/gpu/drm/dep/drm_dep_fence.h b/drivers/gpu/drm/dep/drm_dep_fence.h
> new file mode 100644
> index 000000000000..65a1582f858b
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_fence.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _DRM_DEP_FENCE_H_
> +#define _DRM_DEP_FENCE_H_
> +
> +#include <linux/dma-fence.h>
> +
> +struct drm_dep_fence;
> +struct drm_dep_queue;
> +
> +struct drm_dep_fence *drm_dep_fence_alloc(void);
> +void drm_dep_fence_init(struct drm_dep_fence *dfence, struct drm_dep_queue *q);
> +void drm_dep_fence_cleanup(struct drm_dep_fence *dfence);
> +void drm_dep_fence_set_parent(struct drm_dep_fence *dfence,
> +			      struct dma_fence *parent);
> +void drm_dep_fence_done(struct drm_dep_fence *dfence, int result);
> +bool drm_dep_fence_is_armed(struct drm_dep_fence *dfence);
> +bool drm_dep_fence_is_finished(struct drm_dep_fence *dfence);
> +bool drm_dep_fence_is_complete(struct drm_dep_fence *dfence);
> +struct dma_fence *drm_dep_fence_to_dma(struct drm_dep_fence *dfence);
> +
> +#endif /* _DRM_DEP_FENCE_H_ */
> diff --git a/drivers/gpu/drm/dep/drm_dep_job.c b/drivers/gpu/drm/dep/drm_dep_job.c
> new file mode 100644
> index 000000000000..2d012b29a5fc
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_job.c
> @@ -0,0 +1,675 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +/**
> + * DOC: DRM dependency job
> + *
> + * A struct drm_dep_job represents a single unit of GPU work associated with
> + * a struct drm_dep_queue. The lifecycle of a job is:
> + *
> + * 1. **Allocation**: the driver allocates memory for the job (typically by
> + *    embedding struct drm_dep_job in a larger structure) and calls
> + *    drm_dep_job_init() to initialise it. On success the job holds one
> + *    kref reference and a reference to its queue.
> + *
> + * 2. **Dependency collection**: the driver calls drm_dep_job_add_dependency(),
> + *    drm_dep_job_add_syncobj_dependency(), drm_dep_job_add_resv_dependencies(),
> + *    or drm_dep_job_add_implicit_dependencies() to register dma_fence objects
> + *    that must be signalled before the job can run. Duplicate fences from the
> + *    same fence context are deduplicated automatically.
> + *
> + * 3. **Arming**: drm_dep_job_arm() initialises the job's finished fence,
> + *    consuming a sequence number from the queue. After arming,
> + *    drm_dep_job_finished_fence() returns a valid fence that may be passed to
> + *    userspace or used as a dependency by other jobs.
> + *
> + * 4. **Submission**: drm_dep_job_push() submits the job to the queue. The
> + *    queue takes a reference that it holds until the job's finished fence
> + *    signals and the job is freed by the put_job worker.
> + *
> + * 5. **Completion**: when the job's hardware work finishes its finished fence
> + *    is signalled and drm_dep_job_put() is called by the queue. The driver
> + *    must release any driver-private resources in &drm_dep_job_ops.release.
> + *
> + * Reference counting uses drm_dep_job_get() / drm_dep_job_put(). The
> + * internal drm_dep_job_fini() tears down the dependency xarray and fence
> + * objects before the driver's release callback is invoked.
> + */
> +
> +#include <linux/dma-resv.h>
> +#include <linux/kref.h>
> +#include <linux/slab.h>
> +#include <drm/drm_dep.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_syncobj.h>
> +#include "drm_dep_fence.h"
> +#include "drm_dep_job.h"
> +#include "drm_dep_queue.h"
> +
> +/**
> + * drm_dep_job_init() - initialise a dep job
> + * @job: dep job to initialise
> + * @args: initialisation arguments
> + *
> + * Initialises @job with the queue, ops and credit count from @args.  Acquires
> + * a reference to @args->q via drm_dep_queue_get(); this reference is held for
> + * the lifetime of the job and released by drm_dep_job_release() when the last
> + * job reference is dropped.
> + *
> + * Resources are released automatically when the last reference is dropped
> + * via drm_dep_job_put(), which must be called to release the job; drivers
> + * must not free the job directly.
> + *
> + * Context: Process context. Allocates memory with GFP_KERNEL.
> + * Return: 0 on success, -%EINVAL if credits is 0,
> + *   -%ENOMEM on fence allocation failure.
> + */
> +int drm_dep_job_init(struct drm_dep_job *job,
> +		     const struct drm_dep_job_init_args *args)
> +{
> +	if (unlikely(!args->credits)) {
> +		pr_err("drm_dep: %s: credits cannot be 0\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	memset(job, 0, sizeof(*job));
> +
> +	job->dfence = drm_dep_fence_alloc();
> +	if (!job->dfence)
> +		return -ENOMEM;
> +
> +	job->ops = args->ops;
> +	job->q = drm_dep_queue_get(args->q);
> +	job->credits = args->credits;
> +
> +	kref_init(&job->refcount);
> +	xa_init_flags(&job->dependencies, XA_FLAGS_ALLOC);
> +	INIT_LIST_HEAD(&job->pending_link);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dep_job_init);
> +
> +/**
> + * drm_dep_job_drop_dependencies() - release all input dependency fences
> + * @job: dep job whose dependency xarray to drain
> + *
> + * Walks @job->dependencies, puts each fence, and destroys the xarray.
> + * Any slots still holding a %DRM_DEP_JOB_FENCE_PREALLOC sentinel —
> + * i.e. slots that were pre-allocated but never replaced — are silently
> + * skipped; the sentinel carries no reference.  Called from
> + * drm_dep_queue_run_job() in process context immediately after
> + * @ops->run_job() returns, before the final drm_dep_job_put().  Releasing
> + * dependencies here — while still in process context — avoids calling
> + * xa_destroy() from IRQ context if the job's last reference is later
> + * dropped from a dma_fence callback.
> + *
> + * Context: Process context.
> + */
> +void drm_dep_job_drop_dependencies(struct drm_dep_job *job)
> +{
> +	struct dma_fence *fence;
> +	unsigned long index;
> +
> +	xa_for_each(&job->dependencies, index, fence) {
> +		if (unlikely(fence == DRM_DEP_JOB_FENCE_PREALLOC))
> +			continue;
> +		dma_fence_put(fence);
> +	}
> +	xa_destroy(&job->dependencies);
> +}
> +
> +/**
> + * drm_dep_job_fini() - clean up a dep job
> + * @job: dep job to clean up
> + *
> + * Cleans up the dep fence and drops the queue reference held by @job.
> + *
> + * If the job was never armed (e.g. init failed before drm_dep_job_arm()),
> + * the dependency xarray is also released here.  For armed jobs the xarray
> + * has already been drained by drm_dep_job_drop_dependencies() in process
> + * context immediately after run_job(), so it is left untouched to avoid
> + * calling xa_destroy() from IRQ context.
> + *
> + * Warns if @job is still linked on the queue's pending list, which would
> + * indicate a bug in the teardown ordering.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_job_fini(struct drm_dep_job *job)
> +{
> +	bool armed = drm_dep_fence_is_armed(job->dfence);
> +
> +	WARN_ON(!list_empty(&job->pending_link));
> +
> +	drm_dep_fence_cleanup(job->dfence);
> +	job->dfence = NULL;
> +
> +	/*
> +	 * Armed jobs have their dependencies drained by
> +	 * drm_dep_job_drop_dependencies() in process context after run_job().
> +	 * Skip here to avoid calling xa_destroy() from IRQ context.
> +	 */
> +	if (!armed)
> +		drm_dep_job_drop_dependencies(job);
> +}
> +
> +/**
> + * drm_dep_job_get() - acquire a reference to a dep job
> + * @job: dep job to acquire a reference on, or NULL
> + *
> + * Context: Any context.
> + * Return: @job with an additional reference held, or NULL if @job is NULL.
> + */
> +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job)
> +{
> +	if (job)
> +		kref_get(&job->refcount);
> +	return job;
> +}
> +EXPORT_SYMBOL(drm_dep_job_get);
> +
> +/**
> + * drm_dep_job_release() - kref release callback for a dep job
> + * @kref: kref embedded in the dep job
> + *
> + * Calls drm_dep_job_fini(), then invokes &drm_dep_job_ops.release if set,
> + * otherwise frees @job with kfree().  Finally, releases the queue reference
> + * that was acquired by drm_dep_job_init() via drm_dep_queue_put().  The
> + * queue put is performed last to ensure no queue state is accessed after
> + * the job memory is freed.
> + *
> + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> + *   job's queue; otherwise process context only, as the release callback may
> + *   sleep.
> + */
> +static void drm_dep_job_release(struct kref *kref)
> +{
> +	struct drm_dep_job *job =
> +		container_of(kref, struct drm_dep_job, refcount);
> +	struct drm_dep_queue *q = job->q;
> +
> +	drm_dep_job_fini(job);
> +
> +	if (job->ops && job->ops->release)
> +		job->ops->release(job);
> +	else
> +		kfree(job);
> +
> +	drm_dep_queue_put(q);
> +}
> +
> +/**
> + * drm_dep_job_put() - release a reference to a dep job
> + * @job: dep job to release a reference on, or NULL
> + *
> + * When the last reference is dropped, calls &drm_dep_job_ops.release if set,
> + * otherwise frees @job with kfree(). Does nothing if @job is NULL.
> + *
> + * Context: Any context if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set on the
> + *   job's queue; otherwise process context only, as the release callback may
> + *   sleep.
> + */
> +void drm_dep_job_put(struct drm_dep_job *job)
> +{
> +	if (job)
> +		kref_put(&job->refcount, drm_dep_job_release);
> +}
> +EXPORT_SYMBOL(drm_dep_job_put);
> +
> +/**
> + * drm_dep_job_arm() - arm a dep job for submission
> + * @job: dep job to arm
> + *
> + * Initialises the finished fence on @job->dfence, assigning
> + * it a sequence number from the job's queue. Must be called after
> + * drm_dep_job_init() and before drm_dep_job_push(). Once armed,
> + * drm_dep_job_finished_fence() returns a valid fence that may be passed to
> + * userspace or used as a dependency by other jobs.
> + *
> + * Begins the DMA fence signalling path via dma_fence_begin_signalling().
> + * After this point, memory allocations that could trigger reclaim are
> + * forbidden; lockdep enforces this. arm() must always be paired with
> + * drm_dep_job_push(); lockdep also enforces this pairing.
> + *
> + * Warns if the job has already been armed.
> + *
> + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> + *   path.
> + */
> +void drm_dep_job_arm(struct drm_dep_job *job)
> +{
> +	drm_dep_queue_push_job_begin(job->q);
> +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> +	drm_dep_fence_init(job->dfence, job->q);
> +	job->signalling_cookie = dma_fence_begin_signalling();
> +}
> +EXPORT_SYMBOL(drm_dep_job_arm);
> +
> +/**
> + * drm_dep_job_push() - submit a job to its queue for execution
> + * @job: dep job to push
> + *
> + * Submits @job to the queue it was initialised with. Must be called after
> + * drm_dep_job_arm(). Acquires a reference on @job on behalf of the queue,
> + * held until the queue is fully done with it. The reference is released
> + * directly in the finished-fence dma_fence callback for queues with
> + * %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE (where drm_dep_job_done() may run
> + * from hardirq context), or via the put_job work item on the submit
> + * workqueue otherwise.
> + *
> + * Ends the DMA fence signalling path begun by drm_dep_job_arm() via
> + * dma_fence_end_signalling(). This must be paired with arm(); lockdep
> + * enforces the pairing.
> + *
> + * Once pushed, &drm_dep_queue_ops.run_job is guaranteed to be called for
> + * @job exactly once, even if the queue is killed or torn down before the
> + * job reaches the head of the queue. Drivers can use this guarantee to
> + * perform bookkeeping cleanup; the actual backend operation should be
> + * skipped when drm_dep_queue_is_killed() returns true.
> + *
> + * If the queue does not support the bypass path, the job is pushed directly
> + * onto the SPSC submission queue via drm_dep_queue_push_job() without holding
> + * @q->sched.lock. Otherwise, @q->sched.lock is taken and the job is either
> + * run immediately via drm_dep_queue_run_job() if it qualifies for bypass, or
> + * enqueued via drm_dep_queue_push_job() for dispatch by the run_job work item.
> + *
> + * Warns if the job has not been armed.
> + *
> + * Context: Process context if %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set
> + *   (takes @q->sched.lock, a mutex); any context otherwise. DMA fence signaling
> + *   path.
> + */
> +void drm_dep_job_push(struct drm_dep_job *job)
> +{
> +	struct drm_dep_queue *q = job->q;
> +
> +	WARN_ON(!drm_dep_fence_is_armed(job->dfence));
> +
> +	drm_dep_job_get(job);
> +
> +	if (!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED)) {
> +		drm_dep_queue_push_job(q, job);
> +		dma_fence_end_signalling(job->signalling_cookie);
> +		drm_dep_queue_push_job_end(job->q);
> +		return;
> +	}
> +
> +	scoped_guard(mutex, &q->sched.lock) {
> +		if (drm_dep_queue_can_job_bypass(q, job))
> +			drm_dep_queue_run_job(q, job);
> +		else
> +			drm_dep_queue_push_job(q, job);
> +	}
> +
> +	dma_fence_end_signalling(job->signalling_cookie);
> +	drm_dep_queue_push_job_end(job->q);
> +}
> +EXPORT_SYMBOL(drm_dep_job_push);
> +
> +/**
> + * drm_dep_job_add_dependency() - adds the fence as a job dependency
> + * @job: dep job to add the dependencies to
> + * @fence: the dma_fence to add to the list of dependencies, or
> + *         %DRM_DEP_JOB_FENCE_PREALLOC to reserve a slot for later.
> + *
> + * Note that @fence is consumed in both the success and error cases (except
> + * when @fence is %DRM_DEP_JOB_FENCE_PREALLOC, which carries no reference).
> + *
> + * Signalled fences and fences belonging to the same queue as @job (i.e. where
> + * fence->context matches the queue's finished fence context) are silently
> + * dropped; the job need not wait on its own queue's output.
> + *
> + * Warns if the job has already been armed (dependencies must be added before
> + * drm_dep_job_arm()).
> + *
> + * **Pre-allocation pattern**
> + *
> + * When multiple jobs across different queues must be prepared and submitted
> + * together in a single atomic commit — for example, where job A's finished
> + * fence is an input dependency of job B — all jobs must be armed and pushed
> + * within a single dma_fence_begin_signalling() / dma_fence_end_signalling()
> + * region.  Once that region has started no memory allocation is permitted.
> + *
> + * To handle this, pass %DRM_DEP_JOB_FENCE_PREALLOC during the preparation
> + * phase (before arming any job, while GFP_KERNEL allocation is still allowed)
> + * to pre-allocate a slot in @job->dependencies.  The slot index assigned by
> + * the underlying xarray must be tracked by the caller separately (e.g. it is
> + * always index 0 when the dependency array is empty, as Xe relies on).
> + * After all jobs have been armed and the finished fences are available, call
> + * drm_dep_job_replace_dependency() with that index and the real fence.
> + * drm_dep_job_replace_dependency() uses GFP_NOWAIT internally and may be
> + * called from atomic or signalling context.
> + *
> + * The sentinel slot is never skipped by the signalled-fence fast-path,
> + * ensuring a slot is always allocated even when the real fence is not yet
> + * known.
> + *
> + * **Example: bind job feeding TLB invalidation jobs**
> + *
> + * Consider a GPU with separate queues for page-table bind operations and for
> + * TLB invalidation.  A single atomic commit must:
> + *
> + *  1. Run a bind job that modifies page tables.
> + *  2. Run one TLB-invalidation job per MMU that depends on the bind
> + *     completing, so stale translations are flushed before the engines
> + *     continue.
> + *
> + * Because all jobs must be armed and pushed inside a signalling region (where
> + * GFP_KERNEL is forbidden), pre-allocate slots before entering the region::
> + *
> + *   // Phase 1 — process context, GFP_KERNEL allowed
> + *   drm_dep_job_init(bind_job, bind_queue, ops);
> + *   for_each_mmu(mmu) {
> + *       drm_dep_job_init(tlb_job[mmu], tlb_queue[mmu], ops);
> + *       // Pre-allocate slot at index 0; real fence not available yet
> + *       drm_dep_job_add_dependency(tlb_job[mmu], DRM_DEP_JOB_FENCE_PREALLOC);
> + *   }
> + *
> + *   // Phase 2 — inside signalling region, no GFP_KERNEL
> + *   dma_fence_begin_signalling();
> + *   drm_dep_job_arm(bind_job);
> + *   for_each_mmu(mmu) {
> + *       // Swap sentinel for bind job's finished fence
> + *       drm_dep_job_replace_dependency(tlb_job[mmu], 0,
> + *                                      dma_fence_get(bind_job->finished));
> + *       drm_dep_job_arm(tlb_job[mmu]);
> + *   }
> + *   drm_dep_job_push(bind_job);
> + *   for_each_mmu(mmu)
> + *       drm_dep_job_push(tlb_job[mmu]);
> + *   dma_fence_end_signalling();
> + *
> + * Context: Process context. May allocate memory with GFP_KERNEL.
> + * Return: If fence == DRM_DEP_JOB_FENCE_PREALLOC index of allocation on
> + * success, else 0 on success, or a negative error code.
> + */
> +int drm_dep_job_add_dependency(struct drm_dep_job *job, struct dma_fence *fence)
> +{
> +	struct drm_dep_queue *q = job->q;
> +	struct dma_fence *entry;
> +	unsigned long index;
> +	u32 id = 0;
> +	int ret;
> +
> +	WARN_ON(drm_dep_fence_is_armed(job->dfence));
> +	might_alloc(GFP_KERNEL);
> +
> +	if (!fence)
> +		return 0;
> +
> +	if (fence == DRM_DEP_JOB_FENCE_PREALLOC)
> +		goto add_fence;
> +
> +	/*
> +	 * Ignore signalled fences or fences from our own queue — finished
> +	 * fences use q->fence.context.
> +	 */
> +	if (dma_fence_test_signaled_flag(fence) ||
> +	    fence->context == q->fence.context) {
> +		dma_fence_put(fence);
> +		return 0;
> +	}
> +
> +	/* Deduplicate if we already depend on a fence from the same context.
> +	 * This lets the size of the array of deps scale with the number of
> +	 * engines involved, rather than the number of BOs.
> +	 */
> +	xa_for_each(&job->dependencies, index, entry) {
> +		if (entry == DRM_DEP_JOB_FENCE_PREALLOC ||
> +		    entry->context != fence->context)
> +			continue;
> +
> +		if (dma_fence_is_later(fence, entry)) {
> +			dma_fence_put(entry);
> +			xa_store(&job->dependencies, index, fence, GFP_KERNEL);
> +		} else {
> +			dma_fence_put(fence);
> +		}
> +		return 0;
> +	}
> +
> +add_fence:
> +	ret = xa_alloc(&job->dependencies, &id, fence, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (ret != 0) {
> +		if (fence != DRM_DEP_JOB_FENCE_PREALLOC)
> +			dma_fence_put(fence);
> +		return ret;
> +	}
> +
> +	return (fence == DRM_DEP_JOB_FENCE_PREALLOC) ? id : 0;
> +}
> +EXPORT_SYMBOL(drm_dep_job_add_dependency);
> +
> +/**
> + * drm_dep_job_replace_dependency() - replace a pre-allocated dependency slot
> + * @job: dep job to update
> + * @index: xarray index of the slot to replace, as returned when the sentinel
> + *         was originally inserted via drm_dep_job_add_dependency()
> + * @fence: the real dma_fence to store; its reference is always consumed
> + *
> + * Replaces the %DRM_DEP_JOB_FENCE_PREALLOC sentinel at @index in
> + * @job->dependencies with @fence.  The slot must have been pre-allocated by
> + * passing %DRM_DEP_JOB_FENCE_PREALLOC to drm_dep_job_add_dependency(); the
> + * existing entry is asserted to be the sentinel.
> + *
> + * This is the second half of the pre-allocation pattern described in
> + * drm_dep_job_add_dependency().  It is intended to be called inside a
> + * dma_fence_begin_signalling() / dma_fence_end_signalling() region where
> + * memory allocation with GFP_KERNEL is forbidden.  It uses GFP_NOWAIT
> + * internally so it is safe to call from atomic or signalling context, but
> + * since the slot has been pre-allocated no actual memory allocation occurs.
> + *
> + * If @fence is already signalled the slot is erased rather than storing a
> + * redundant dependency.  The successful store is asserted — if the store
> + * fails it indicates a programming error (slot index out of range or
> + * concurrent modification).
> + *
> + * Must be called before drm_dep_job_arm(). @fence is consumed in all cases.
> + *
> + * Context: Any context. DMA fence signaling path.
> + */
> +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 index,
> +				    struct dma_fence *fence)
> +{
> +	WARN_ON(xa_load(&job->dependencies, index) !=
> +		DRM_DEP_JOB_FENCE_PREALLOC);
> +
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		xa_erase(&job->dependencies, index);
> +		dma_fence_put(fence);
> +		return;
> +	}
> +
> +	if (WARN_ON(xa_is_err(xa_store(&job->dependencies, index, fence,
> +				       GFP_NOWAIT)))) {
> +		dma_fence_put(fence);
> +		return;
> +	}
> +}
> +EXPORT_SYMBOL(drm_dep_job_replace_dependency);
> +
> +/**
> + * drm_dep_job_add_syncobj_dependency() - adds a syncobj's fence as a
> + *   job dependency
> + * @job: dep job to add the dependencies to
> + * @file: drm file private pointer
> + * @handle: syncobj handle to lookup
> + * @point: timeline point
> + *
> + * This adds the fence matching the given syncobj to @job.
> + *
> + * Context: Process context.
> + * Return: 0 on success, or a negative error code.
> + */
> +int drm_dep_job_add_syncobj_dependency(struct drm_dep_job *job,
> +				       struct drm_file *file, u32 handle,
> +				       u32 point)
> +{
> +	struct dma_fence *fence;
> +	int ret;
> +
> +	ret = drm_syncobj_find_fence(file, handle, point, 0, &fence);
> +	if (ret)
> +		return ret;
> +
> +	return drm_dep_job_add_dependency(job, fence);
> +}
> +EXPORT_SYMBOL(drm_dep_job_add_syncobj_dependency);
> +
> +/**
> + * drm_dep_job_add_resv_dependencies() - add all fences from the resv to the job
> + * @job: dep job to add the dependencies to
> + * @resv: the dma_resv object to get the fences from
> + * @usage: the dma_resv_usage to use to filter the fences
> + *
> + * This adds all fences matching the given usage from @resv to @job.
> + * Must be called with the @resv lock held.
> + *
> + * Context: Process context.
> + * Return: 0 on success, or a negative error code.
> + */
> +int drm_dep_job_add_resv_dependencies(struct drm_dep_job *job,
> +				      struct dma_resv *resv,
> +				      enum dma_resv_usage usage)
> +{
> +	struct dma_resv_iter cursor;
> +	struct dma_fence *fence;
> +	int ret;
> +
> +	dma_resv_assert_held(resv);
> +
> +	dma_resv_for_each_fence(&cursor, resv, usage, fence) {
> +		/*
> +		 * As drm_dep_job_add_dependency always consumes the fence
> +		 * reference (even when it fails), and dma_resv_for_each_fence
> +		 * is not obtaining one, we need to grab one before calling.
> +		 */
> +		ret = drm_dep_job_add_dependency(job, dma_fence_get(fence));
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dep_job_add_resv_dependencies);
> +
> +/**
> + * drm_dep_job_add_implicit_dependencies() - adds implicit dependencies
> + *   as job dependencies
> + * @job: dep job to add the dependencies to
> + * @obj: the gem object to add new dependencies from.
> + * @write: whether the job might write the object (so we need to depend on
> + * shared fences in the reservation object).
> + *
> + * This should be called after drm_gem_lock_reservations() on your array of
> + * GEM objects used in the job but before updating the reservations with your
> + * own fences.
> + *
> + * Context: Process context.
> + * Return: 0 on success, or a negative error code.
> + */
> +int drm_dep_job_add_implicit_dependencies(struct drm_dep_job *job,
> +					  struct drm_gem_object *obj,
> +					  bool write)
> +{
> +	return drm_dep_job_add_resv_dependencies(job, obj->resv,
> +						 dma_resv_usage_rw(write));
> +}
> +EXPORT_SYMBOL(drm_dep_job_add_implicit_dependencies);
> +
> +/**
> + * drm_dep_job_is_signaled() - check whether a dep job has completed
> + * @job: dep job to check
> + *
> + * Determines whether @job has signalled. The queue should be stopped before
> + * calling this to obtain a stable snapshot of state. Both the parent hardware
> + * fence and the finished software fence are checked.
> + *
> + * Context: Process context. The queue must be stopped before calling this.
> + * Return: true if the job is signalled, false otherwise.
> + */
> +bool drm_dep_job_is_signaled(struct drm_dep_job *job)
> +{
> +	WARN_ON(!drm_dep_queue_is_stopped(job->q));
> +	return drm_dep_fence_is_complete(job->dfence);
> +}
> +EXPORT_SYMBOL(drm_dep_job_is_signaled);
> +
> +/**
> + * drm_dep_job_is_finished() - test whether a dep job's finished fence has signalled
> + * @job: dep job to check
> + *
> + * Tests whether the job's software finished fence has been signalled, using
> + * dma_fence_test_signaled_flag() to avoid any signalling side-effects. Unlike
> + * drm_dep_job_is_signaled(), this does not require the queue to be stopped and
> + * does not check the parent hardware fence — it is a lightweight test of the
> + * finished fence only.
> + *
> + * Context: Any context.
> + * Return: true if the job's finished fence has been signalled, false otherwise.
> + */
> +bool drm_dep_job_is_finished(struct drm_dep_job *job)
> +{
> +	return drm_dep_fence_is_finished(job->dfence);
> +}
> +EXPORT_SYMBOL(drm_dep_job_is_finished);
> +
> +/**
> + * drm_dep_job_invalidate_job() - increment the invalidation count for a job
> + * @job: dep job to invalidate
> + * @threshold: threshold above which the job is considered invalidated
> + *
> + * Increments @job->invalidate_count and returns true if it exceeds @threshold,
> + * indicating the job should be considered hung and discarded. The queue must
> + * be stopped before calling this function.
> + *
> + * Context: Process context. The queue must be stopped before calling this.
> + * Return: true if @job->invalidate_count exceeds @threshold, false otherwise.
> + */
> +bool drm_dep_job_invalidate_job(struct drm_dep_job *job, int threshold)
> +{
> +	WARN_ON(!drm_dep_queue_is_stopped(job->q));
> +	return ++job->invalidate_count > threshold;
> +}
> +EXPORT_SYMBOL(drm_dep_job_invalidate_job);
> +
> +/**
> + * drm_dep_job_finished_fence() - return the finished fence for a job
> + * @job: dep job to query
> + *
> + * No reference is taken on the returned fence; the caller must hold its own
> + * reference to @job for the duration of any access.
> + *
> + * Context: Any context.
> + * Return: the finished &dma_fence for @job.
> + */
> +struct dma_fence *drm_dep_job_finished_fence(struct drm_dep_job *job)
> +{
> +	return drm_dep_fence_to_dma(job->dfence);
> +}
> +EXPORT_SYMBOL(drm_dep_job_finished_fence);
> diff --git a/drivers/gpu/drm/dep/drm_dep_job.h b/drivers/gpu/drm/dep/drm_dep_job.h
> new file mode 100644
> index 000000000000..35c61d258fa1
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_job.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _DRM_DEP_JOB_H_
> +#define _DRM_DEP_JOB_H_
> +
> +struct drm_dep_queue;
> +
> +void drm_dep_job_drop_dependencies(struct drm_dep_job *job);
> +
> +#endif /* _DRM_DEP_JOB_H_ */
> diff --git a/drivers/gpu/drm/dep/drm_dep_queue.c b/drivers/gpu/drm/dep/drm_dep_queue.c
> new file mode 100644
> index 000000000000..dac02d0d22c4
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_queue.c
> @@ -0,0 +1,1647 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +/**
> + * DOC: DRM dependency queue
> + *
> + * The drm_dep subsystem provides a lightweight GPU submission queue that
> + * combines the roles of drm_gpu_scheduler and drm_sched_entity into a
> + * single object (struct drm_dep_queue). Each queue owns its own ordered
> + * submit workqueue, timeout workqueue, and TDR delayed-work.
> + *
> + * **Job lifecycle**
> + *
> + * 1. Allocate and initialise a job with drm_dep_job_init().
> + * 2. Add dependency fences with drm_dep_job_add_dependency() and friends.
> + * 3. Arm the job with drm_dep_job_arm() to obtain its out-fences.
> + * 4. Submit with drm_dep_job_push().
> + *
> + * **Submission paths**
> + *
> + * drm_dep_job_push() decides between two paths under @q->sched.lock:
> + *
> + * - **Bypass path** (drm_dep_queue_can_job_bypass()): if
> + *   %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set, the queue is not stopped,
> + *   the SPSC queue is empty, the job has no dependency fences, and credits
> + *   are available, the job is submitted inline on the calling thread without
> + *   touching the submit workqueue.
> + *
> + * - **Queued path** (drm_dep_queue_push_job()): the job is pushed onto an
> + *   SPSC queue and the run_job worker is kicked. The run_job worker pops the
> + *   job, resolves any remaining dependency fences (installing wakeup
> + *   callbacks for unresolved ones), and calls drm_dep_queue_run_job().
> + *
> + * **Running a job**
> + *
> + * drm_dep_queue_run_job() accounts credits, appends the job to the pending
> + * list (starting the TDR timer only when the list was previously empty),
> + * calls @ops->run_job(), stores the returned hardware fence as the parent
> + * of the job's dep fence, then installs a callback on it. When the hardware
> + * fence fires (or the job completes synchronously), drm_dep_job_done()
> + * signals the finished fence, returns credits, and kicks the put_job worker
> + * to free the job.
> + *
> + * **Timeout detection and recovery (TDR)**
> + *
> + * A delayed work item fires when a job on the pending list takes longer than
> + * @q->job.timeout jiffies. It calls @ops->timedout_job() and acts on the
> + * returned status (%DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED or
> + * %DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB).
> + * drm_dep_queue_trigger_timeout() forces the timer to fire immediately (without
> + * changing the stored timeout), for example during device teardown.
> + *
> + * **Reference counting**
> + *
> + * Jobs and queues are both reference counted.
> + *
> + * A job holds a reference to its queue from drm_dep_job_init() until
> + * drm_dep_job_put() drops the job's last reference and its release callback
> + * runs. This ensures the queue remains valid for the entire lifetime of any
> + * job that was submitted to it.
> + *
> + * The queue holds its own reference to a job for as long as the job is
> + * internally tracked: from the moment the job is added to the pending list
> + * in drm_dep_queue_run_job() until drm_dep_job_done() kicks the put_job
> + * worker, which calls drm_dep_job_put() to release that reference.
> + *
> + * **Hazard: use-after-free from within a worker**
> + *
> + * Because a job holds a queue reference, drm_dep_job_put() dropping the last
> + * job reference will also drop a queue reference via the job's release path.
> + * If that happens to be the last queue reference, drm_dep_queue_fini() can be
> + * called, which queues @q->free_work on dep_free_wq and returns immediately.
> + * free_work calls disable_work_sync() / disable_delayed_work_sync() on the
> + * queue's own workers before destroying its workqueues, so in practice a
> + * running worker always completes before the queue memory is freed.
> + *
> + * However, there is a secondary hazard: a worker can be queued while the
> + * queue is in a "zombie" state — refcount has already reached zero and async
> + * teardown is in flight, but the work item has not yet been disabled by
> + * free_work.  To guard against this every worker uses
> + * drm_dep_queue_get_unless_zero() at entry; if the refcount is already zero
> + * the worker bails immediately without touching the queue state.
> + *
> + * Because all actual teardown (disable_*_sync, destroy_workqueue) runs on
> + * dep_free_wq — which is independent of the queue's own submit/timeout
> + * workqueues — there is no deadlock risk.  Each queue holds a drm_dev_get()
> + * reference on its owning &drm_device, which is released as the last step of
> + * teardown.  This ensures the driver module cannot be unloaded while any queue
> + * is still alive.
> + */
> +
> +#include <linux/dma-resv.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue.h>
> +#include <drm/drm_dep.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_print.h>
> +#include "drm_dep_fence.h"
> +#include "drm_dep_job.h"
> +#include "drm_dep_queue.h"
> +
> +/*
> + * Dedicated workqueue for deferred drm_dep_queue teardown.  Using a
> + * module-private WQ instead of system_percpu_wq keeps teardown isolated
> + * from unrelated kernel subsystems.
> + */
> +static struct workqueue_struct *dep_free_wq;
> +
> +/**
> + * drm_dep_queue_flags_set() - set a flag on the queue under sched.lock
> + * @q: dep queue
> + * @flag: flag to set (one of &enum drm_dep_queue_flags)
> + *
> + * Sets @flag in @q->sched.flags. Must be called with @q->sched.lock
> + * held; the lockdep assertion enforces this.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + */
> +static void drm_dep_queue_flags_set(struct drm_dep_queue *q,
> +				    enum drm_dep_queue_flags flag)
> +{
> +	lockdep_assert_held(&q->sched.lock);
> +	q->sched.flags |= flag;
> +}
> +
> +/**
> + * drm_dep_queue_flags_clear() - clear a flag on the queue under sched.lock
> + * @q: dep queue
> + * @flag: flag to clear (one of &enum drm_dep_queue_flags)
> + *
> + * Clears @flag in @q->sched.flags. Must be called with @q->sched.lock
> + * held; the lockdep assertion enforces this.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + */
> +static void drm_dep_queue_flags_clear(struct drm_dep_queue *q,
> +				      enum drm_dep_queue_flags flag)
> +{
> +	lockdep_assert_held(&q->sched.lock);
> +	q->sched.flags &= ~flag;
> +}
> +
> +/**
> + * drm_dep_queue_has_credits() - check whether the queue has enough credits
> + * @q: dep queue
> + * @job: job requesting credits
> + *
> + * Checks whether the queue has enough available credits to dispatch
> + * @job. If @job->credits exceeds the queue's credit limit, it is
> + * clamped with a WARN.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + * Return: true if available credits >= @job->credits, false otherwise.
> + */
> +static bool drm_dep_queue_has_credits(struct drm_dep_queue *q,
> +				      struct drm_dep_job *job)
> +{
> +	u32 available;
> +
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	if (job->credits > q->credit.limit) {
> +		drm_warn(q->drm,
> +			 "Jobs may not exceed the credit limit, truncate.\n");
> +		job->credits = q->credit.limit;
> +	}
> +
> +	WARN_ON(check_sub_overflow(q->credit.limit,
> +				   atomic_read(&q->credit.count),
> +				   &available));
> +
> +	return available >= job->credits;
> +}
> +
> +/**
> + * drm_dep_queue_run_job_queue() - kick the run-job worker
> + * @q: dep queue
> + *
> + * Queues @q->sched.run_job on @q->sched.submit_wq unless the queue is stopped
> + * or the job queue is empty.  The empty-queue check avoids queueing a work item
> + * that would immediately return with nothing to do.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_queue_run_job_queue(struct drm_dep_queue *q)
> +{
> +	if (!drm_dep_queue_is_stopped(q) && spsc_queue_count(&q->job.queue))
> +		queue_work(q->sched.submit_wq, &q->sched.run_job);
> +}
> +
> +/**
> + * drm_dep_queue_put_job_queue() - kick the put-job worker
> + * @q: dep queue
> + *
> + * Queues @q->sched.put_job on @q->sched.submit_wq unless the queue
> + * is stopped.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_queue_put_job_queue(struct drm_dep_queue *q)
> +{
> +	if (!drm_dep_queue_is_stopped(q))
> +		queue_work(q->sched.submit_wq, &q->sched.put_job);
> +}
> +
> +/**
> + * drm_queue_start_timeout() - arm or re-arm the TDR delayed work
> + * @q: dep queue
> + *
> + * Arms the TDR delayed work with @q->job.timeout. No-op if
> + * @q->ops->timedout_job is NULL, the timeout is MAX_SCHEDULE_TIMEOUT,
> + * or the pending list is empty.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + */
> +static void drm_queue_start_timeout(struct drm_dep_queue *q)
> +{
> +	lockdep_assert_held(&q->job.lock);
> +
> +	if (!q->ops->timedout_job ||
> +	    q->job.timeout == MAX_SCHEDULE_TIMEOUT ||
> +	    list_empty(&q->job.pending))
> +		return;
> +
> +	mod_delayed_work(q->sched.timeout_wq, &q->sched.tdr, q->job.timeout);
> +}
> +
> +/**
> + * drm_queue_start_timeout_unlocked() - arm TDR, acquiring job.lock
> + * @q: dep queue
> + *
> + * Acquires @q->job.lock with irq and calls
> + * drm_queue_start_timeout().
> + *
> + * Context: Process context (workqueue).
> + */
> +static void drm_queue_start_timeout_unlocked(struct drm_dep_queue *q)
> +{
> +	guard(spinlock_irq)(&q->job.lock);
> +	drm_queue_start_timeout(q);
> +}
> +
> +/**
> + * drm_dep_queue_remove_dependency() - clear the active dependency and wake
> + *   the run-job worker
> + * @q: dep queue
> + * @f: the dependency fence being removed
> + *
> + * Stores @f into @q->dep.removed_fence via smp_store_release() so that the
> + * run-job worker can drop the reference to it in drm_dep_queue_is_ready(),
> + * paired with smp_load_acquire().  Clears @q->dep.fence and kicks the
> + * run-job worker.
> + *
> + * The fence reference is not dropped here; it is deferred to the run-job
> + * worker via @q->dep.removed_fence to keep this path suitable dma_fence
> + * callback removal in drm_dep_queue_kill().
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_queue_remove_dependency(struct drm_dep_queue *q,
> +					    struct dma_fence *f)
> +{
> +	/* removed_fence must be visible to the reader before &q->dep.fence */
> +	smp_store_release(&q->dep.removed_fence, f);
> +
> +	WRITE_ONCE(q->dep.fence, NULL);
> +	drm_dep_queue_run_job_queue(q);
> +}
> +
> +/**
> + * drm_dep_queue_wakeup() - dma_fence callback to wake the run-job worker
> + * @f: the signalled dependency fence
> + * @cb: callback embedded in the dep queue
> + *
> + * Called from dma_fence_signal() when the active dependency fence signals.
> + * Delegates to drm_dep_queue_remove_dependency() to clear @q->dep.fence and
> + * kick the run-job worker.  The fence reference is not dropped here; it is
> + * deferred to the run-job worker via @q->dep.removed_fence.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_queue_wakeup(struct dma_fence *f, struct dma_fence_cb *cb)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(cb, struct drm_dep_queue, dep.cb);
> +
> +	drm_dep_queue_remove_dependency(q, f);
> +}
> +
> +/**
> + * drm_dep_queue_is_ready() - check whether the queue has a dispatchable job
> + * @q: dep queue
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + * Return: true if SPSC queue non-empty and no dep fence pending,
> + *   false otherwise.
> + */
> +static bool drm_dep_queue_is_ready(struct drm_dep_queue *q)
> +{
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	if (!spsc_queue_count(&q->job.queue))
> +		return false;
> +
> +	if (READ_ONCE(q->dep.fence))
> +		return false;
> +
> +	/* Paired with smp_store_release in drm_dep_queue_remove_dependency() */
> +	dma_fence_put(smp_load_acquire(&q->dep.removed_fence));
> +
> +	q->dep.removed_fence = NULL;
> +
> +	return true;
> +}
> +
> +/**
> + * drm_dep_queue_is_killed() - check whether a dep queue has been killed
> + * @q: dep queue to check
> + *
> + * Return: true if %DRM_DEP_QUEUE_FLAGS_KILLED is set on @q, false otherwise.
> + *
> + * Context: Any context.
> + */
> +bool drm_dep_queue_is_killed(struct drm_dep_queue *q)
> +{
> +	return !!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_KILLED);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_is_killed);
> +
> +/**
> + * drm_dep_queue_is_initialized() - check whether a dep queue has been initialized
> + * @q: dep queue to check
> + *
> + * A queue is considered initialized once its ops pointer has been set by a
> + * successful call to drm_dep_queue_init().  Drivers that embed a
> + * &drm_dep_queue inside a larger structure may call this before attempting any
> + * other queue operation to confirm that initialization has taken place.
> + * drm_dep_queue_put() must be called if this function returns true to drop the
> + * initialization reference from drm_dep_queue_init().
> + *
> + * Return: true if @q has been initialized, false otherwise.
> + *
> + * Context: Any context.
> + */
> +bool drm_dep_queue_is_initialized(struct drm_dep_queue *q)
> +{
> +	return !!q->ops;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_is_initialized);
> +
> +/**
> + * drm_dep_queue_set_stopped() - pre-mark a queue as stopped before first use
> + * @q: dep queue to mark
> + *
> + * Sets %DRM_DEP_QUEUE_FLAGS_STOPPED directly on @q without going through the
> + * normal drm_dep_queue_stop() path.  This is only valid during the driver-side
> + * queue initialisation sequence — i.e. after drm_dep_queue_init() returns but
> + * before the queue is made visible to other threads (e.g. before it is added
> + * to any lookup structures).  Using this after the queue is live is a driver
> + * bug; use drm_dep_queue_stop() instead.
> + *
> + * Context: Process context, queue not yet visible to other threads.
> + */
> +void drm_dep_queue_set_stopped(struct drm_dep_queue *q)
> +{
> +	q->sched.flags |= DRM_DEP_QUEUE_FLAGS_STOPPED;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_set_stopped);
> +
> +/**
> + * drm_dep_queue_refcount() - read the current reference count of a queue
> + * @q: dep queue to query
> + *
> + * Returns the instantaneous kref value.  The count may change immediately
> + * after this call; callers must not make safety decisions based solely on
> + * the returned value.  Intended for diagnostic snapshots and debugfs output.
> + *
> + * Context: Any context.
> + * Return: current reference count.
> + */
> +unsigned int drm_dep_queue_refcount(const struct drm_dep_queue *q)
> +{
> +	return kref_read(&q->refcount);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_refcount);
> +
> +/**
> + * drm_dep_queue_timeout() - read the per-job TDR timeout for a queue
> + * @q: dep queue to query
> + *
> + * Returns the per-job timeout in jiffies as set at init time.
> + * %MAX_SCHEDULE_TIMEOUT means no timeout is configured.
> + *
> + * Context: Any context.
> + * Return: timeout in jiffies.
> + */
> +long drm_dep_queue_timeout(const struct drm_dep_queue *q)
> +{
> +	return q->job.timeout;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_timeout);
> +
> +/**
> + * drm_dep_queue_is_job_put_irq_safe() - test whether job-put from IRQ is allowed
> + * @q: dep queue
> + *
> + * Context: Any context.
> + * Return: true if %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set,
> + *   false otherwise.
> + */
> +static bool drm_dep_queue_is_job_put_irq_safe(const struct drm_dep_queue *q)
> +{
> +	return !!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE);
> +}
> +
> +/**
> + * drm_dep_queue_job_dependency() - get next unresolved dep fence
> + * @q: dep queue
> + * @job: job whose dependencies to advance
> + *
> + * Returns NULL immediately if the queue has been killed via
> + * drm_dep_queue_kill(), bypassing all dependency waits so that jobs
> + * drain through run_job as quickly as possible.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + * Return: next unresolved &dma_fence with a new reference, or NULL
> + *   when all dependencies have been consumed (or the queue is killed).
> + */
> +static struct dma_fence *
> +drm_dep_queue_job_dependency(struct drm_dep_queue *q,
> +			     struct drm_dep_job *job)
> +{
> +	struct dma_fence *f;
> +
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	if (drm_dep_queue_is_killed(q))
> +		return NULL;
> +
> +	f = xa_load(&job->dependencies, job->last_dependency);
> +	if (f) {
> +		job->last_dependency++;
> +		if (WARN_ON(DRM_DEP_JOB_FENCE_PREALLOC == f))
> +			return dma_fence_get_stub();
> +		return dma_fence_get(f);
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * drm_dep_queue_add_dep_cb() - install wakeup callback on dep fence
> + * @q: dep queue
> + * @job: job whose dependency fence is stored in @q->dep.fence
> + *
> + * Installs a wakeup callback on @q->dep.fence. Returns true if the
> + * callback was installed (the queue must wait), false if the fence is
> + * already signalled or is a self-fence from the same queue context.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + * Return: true if callback installed, false if fence already done.
> + */
> +static bool drm_dep_queue_add_dep_cb(struct drm_dep_queue *q,
> +				     struct drm_dep_job *job)
> +{
> +	struct dma_fence *fence = q->dep.fence;
> +
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	if (WARN_ON(fence->context == q->fence.context)) {
> +		dma_fence_put(q->dep.fence);
> +		q->dep.fence = NULL;
> +		return false;
> +	}
> +
> +	if (!dma_fence_add_callback(q->dep.fence, &q->dep.cb,
> +				    drm_dep_queue_wakeup))
> +		return true;
> +
> +	dma_fence_put(q->dep.fence);
> +	q->dep.fence = NULL;
> +
> +	return false;
> +}
> +
> +/**
> + * drm_dep_queue_pop_job() - pop a dispatchable job from the SPSC queue
> + * @q: dep queue
> + *
> + * Peeks at the head of the SPSC queue and drains all resolved
> + * dependencies. If a dependency is still pending, installs a wakeup
> + * callback and returns NULL. On success pops the job and returns it.
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + * Return: next dispatchable job, or NULL if a dep is still pending.
> + */
> +static struct drm_dep_job *drm_dep_queue_pop_job(struct drm_dep_queue *q)
> +{
> +	struct spsc_node *node;
> +	struct drm_dep_job *job;
> +
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	node = spsc_queue_peek(&q->job.queue);
> +	if (!node)
> +		return NULL;
> +
> +	job = container_of(node, struct drm_dep_job, queue_node);
> +
> +	while ((q->dep.fence = drm_dep_queue_job_dependency(q, job))) {
> +		if (drm_dep_queue_add_dep_cb(q, job))
> +			return NULL;
> +	}
> +
> +	spsc_queue_pop(&q->job.queue);
> +
> +	return job;
> +}
> +
> +/*
> + * drm_dep_queue_get_unless_zero() - try to acquire a queue reference
> + *
> + * Workers use this instead of drm_dep_queue_get() to guard against the zombie
> + * state: the queue's refcount has already reached zero (async teardown is in
> + * flight) but a work item was queued before free_work had a chance to cancel
> + * it.  If kref_get_unless_zero() fails the caller must bail immediately.
> + *
> + * Context: Any context.
> + * Returns true if the reference was acquired, false if the queue is zombie.
> + */
> +bool drm_dep_queue_get_unless_zero(struct drm_dep_queue *q)
> +{
> +	return kref_get_unless_zero(&q->refcount);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_get_unless_zero);
> +
> +/**
> + * drm_dep_queue_run_job_work() - run-job worker
> + * @work: work item embedded in the dep queue
> + *
> + * Acquires @q->sched.lock, checks stopped state, queue readiness and
> + * available credits, pops the next job via drm_dep_queue_pop_job(),
> + * dispatches it via drm_dep_queue_run_job(), then re-kicks itself.
> + *
> + * Uses drm_dep_queue_get_unless_zero() at entry and bails immediately if the
> + * queue is in zombie state (refcount already zero, async teardown in flight).
> + *
> + * Context: Process context (workqueue). DMA fence signaling path.
> + */
> +static void drm_dep_queue_run_job_work(struct work_struct *work)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(work, struct drm_dep_queue, sched.run_job);
> +	struct spsc_node *node;
> +	struct drm_dep_job *job;
> +	bool cookie = dma_fence_begin_signalling();
> +
> +	/* Bail if queue is zombie (refcount already zero, teardown in flight). */
> +	if (!drm_dep_queue_get_unless_zero(q)) {
> +		dma_fence_end_signalling(cookie);
> +		return;
> +	}
> +
> +	mutex_lock(&q->sched.lock);
> +
> +	if (drm_dep_queue_is_stopped(q))
> +		goto put_queue;
> +
> +	if (!drm_dep_queue_is_ready(q))
> +		goto put_queue;
> +
> +	/* Peek to check credits before committing to pop and dep resolution */
> +	node = spsc_queue_peek(&q->job.queue);
> +	if (!node)
> +		goto put_queue;
> +
> +	job = container_of(node, struct drm_dep_job, queue_node);
> +	if (!drm_dep_queue_has_credits(q, job))
> +		goto put_queue;
> +
> +	job = drm_dep_queue_pop_job(q);
> +	if (!job)
> +		goto put_queue;
> +
> +	drm_dep_queue_run_job(q, job);
> +	drm_dep_queue_run_job_queue(q);
> +
> +put_queue:
> +	mutex_unlock(&q->sched.lock);
> +	drm_dep_queue_put(q);
> +	dma_fence_end_signalling(cookie);
> +}
> +
> +/*
> + * drm_dep_queue_remove_job() - unlink a job from the pending list and reset TDR
> + * @q:   dep queue owning @job
> + * @job: job to remove
> + *
> + * Splices @job out of @q->job.pending, cancels any pending TDR delayed work,
> + * and arms the timeout for the new list head (if any).
> + *
> + * Context: Process context. Must hold @q->sched.lock. DMA fence signaling path.
> + */
> +static void drm_dep_queue_remove_job(struct drm_dep_queue *q,
> +				     struct drm_dep_job *job)
> +{
> +	lockdep_assert_held(&q->job.lock);
> +
> +	list_del_init(&job->pending_link);
> +	cancel_delayed_work(&q->sched.tdr);
> +	drm_queue_start_timeout(q);
> +}
> +
> +/**
> + * drm_dep_queue_get_finished_job() - dequeue a finished job
> + * @q: dep queue
> + *
> + * Under @q->job.lock checks the head of the pending list for a
> + * finished dep fence. If found, removes the job from the list,
> + * cancels the TDR, and re-arms it for the new head.
> + *
> + * Context: Process context (workqueue). DMA fence signaling path.
> + * Return: the finished &drm_dep_job, or NULL if none is ready.
> + */
> +static struct drm_dep_job *
> +drm_dep_queue_get_finished_job(struct drm_dep_queue *q)
> +{
> +	struct drm_dep_job *job;
> +
> +	guard(spinlock_irq)(&q->job.lock);
> +
> +	job = list_first_entry_or_null(&q->job.pending, struct drm_dep_job,
> +				       pending_link);
> +	if (job && drm_dep_fence_is_finished(job->dfence))
> +		drm_dep_queue_remove_job(q, job);
> +	else
> +		job = NULL;
> +
> +	return job;
> +}
> +
> +/**
> + * drm_dep_queue_put_job_work() - put-job worker
> + * @work: work item embedded in the dep queue
> + *
> + * Drains all finished jobs by calling drm_dep_job_put() in a loop,
> + * then kicks the run-job worker.
> + *
> + * Uses drm_dep_queue_get_unless_zero() at entry and bails immediately if the
> + * queue is in zombie state (refcount already zero, async teardown in flight).
> + *
> + * Wraps execution in dma_fence_begin_signalling() / dma_fence_end_signalling()
> + * because workqueue is shared with other items in the fence signaling path.
> + *
> + * Context: Process context (workqueue). DMA fence signaling path.
> + */
> +static void drm_dep_queue_put_job_work(struct work_struct *work)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(work, struct drm_dep_queue, sched.put_job);
> +	struct drm_dep_job *job;
> +	bool cookie = dma_fence_begin_signalling();
> +
> +	/* Bail if queue is zombie (refcount already zero, teardown in flight). */
> +	if (!drm_dep_queue_get_unless_zero(q)) {
> +		dma_fence_end_signalling(cookie);
> +		return;
> +	}
> +
> +	while ((job = drm_dep_queue_get_finished_job(q)))
> +		drm_dep_job_put(job);
> +
> +	drm_dep_queue_run_job_queue(q);
> +
> +	drm_dep_queue_put(q);
> +	dma_fence_end_signalling(cookie);
> +}
> +
> +/**
> + * drm_dep_queue_tdr_work() - TDR worker
> + * @work: work item embedded in the delayed TDR work
> + *
> + * Removes the head job from the pending list under @q->job.lock,
> + * asserts @q->ops->timedout_job is non-NULL, calls it outside the lock,
> + * requeues the job if %DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB, drops the
> + * queue's job reference on %DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED, and always
> + * restarts the TDR timer after handling the job (unless @q is stopping).
> + * Any other return value triggers a WARN.
> + *
> + * The TDR is never armed when @q->ops->timedout_job is NULL, so firing
> + * this worker without a timedout_job callback is a driver bug.
> + *
> + * Uses drm_dep_queue_get_unless_zero() at entry and bails immediately if the
> + * queue is in zombie state (refcount already zero, async teardown in flight).
> + *
> + * Wraps execution in dma_fence_begin_signalling() / dma_fence_end_signalling()
> + * because timedout_job() is expected to signal the guilty job's fence as part
> + * of reset.
> + *
> + * Context: Process context (workqueue). DMA fence signaling path.
> + */
> +static void drm_dep_queue_tdr_work(struct work_struct *work)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(work, struct drm_dep_queue, sched.tdr.work);
> +	struct drm_dep_job *job;
> +	bool cookie = dma_fence_begin_signalling();
> +
> +	/* Bail if queue is zombie (refcount already zero, teardown in flight). */
> +	if (!drm_dep_queue_get_unless_zero(q)) {
> +		dma_fence_end_signalling(cookie);
> +		return;
> +	}
> +
> +	scoped_guard(spinlock_irq, &q->job.lock) {
> +		job = list_first_entry_or_null(&q->job.pending,
> +					       struct drm_dep_job,
> +					       pending_link);
> +		if (job)
> +			/*
> +			 * Remove from pending so it cannot be freed
> +			 * concurrently by drm_dep_queue_get_finished_job() or
> +			 * .drm_dep_job_done().
> +			 */
> +			list_del_init(&job->pending_link);
> +	}
> +
> +	if (job) {
> +		enum drm_dep_timedout_stat status;
> +
> +		if (WARN_ON(!q->ops->timedout_job)) {
> +			drm_dep_job_put(job);
> +			goto out;
> +		}
> +
> +		status = q->ops->timedout_job(job);
> +
> +		switch (status) {
> +		case DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB:
> +			scoped_guard(spinlock_irq, &q->job.lock)
> +				list_add(&job->pending_link, &q->job.pending);
> +			drm_dep_queue_put_job_queue(q);
> +			break;
> +		case DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED:
> +			drm_dep_job_put(job);
> +			break;
> +		default:
> +			WARN_ON("invalid drm_dep_timedout_stat");
> +			break;
> +		}
> +	}
> +
> +out:
> +	drm_queue_start_timeout_unlocked(q);
> +	drm_dep_queue_put(q);
> +	dma_fence_end_signalling(cookie);
> +}
> +
> +/**
> + * drm_dep_alloc_submit_wq() - allocate an ordered submit workqueue
> + * @name: name for the workqueue
> + * @flags: DRM_DEP_QUEUE_FLAGS_* flags
> + *
> + * Allocates an ordered workqueue for job submission with %WQ_MEM_RECLAIM and
> + * %WQ_MEM_WARN_ON_RECLAIM set, ensuring the workqueue is safe to use from
> + * memory reclaim context and properly annotated for lockdep taint tracking.
> + * Adds %WQ_HIGHPRI if %DRM_DEP_QUEUE_FLAGS_HIGHPRI is set. When
> + * CONFIG_LOCKDEP is enabled, uses a dedicated lockdep map for annotation.
> + *
> + * Context: Process context.
> + * Return: the new &workqueue_struct, or NULL on failure.
> + */
> +static struct workqueue_struct *
> +drm_dep_alloc_submit_wq(const char *name, enum drm_dep_queue_flags flags)
> +{
> +	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_MEM_WARN_ON_RECLAIM;
> +
> +	if (flags & DRM_DEP_QUEUE_FLAGS_HIGHPRI)
> +		wq_flags |= WQ_HIGHPRI;
> +
> +#if IS_ENABLED(CONFIG_LOCKDEP)
> +	static struct lockdep_map map = {
> +		.name = "drm_dep_submit_lockdep_map"
> +	};
> +	return alloc_ordered_workqueue_lockdep_map(name, wq_flags, &map);
> +#else
> +	return alloc_ordered_workqueue(name, wq_flags);
> +#endif
> +}
> +
> +/**
> + * drm_dep_alloc_timeout_wq() - allocate an ordered TDR workqueue
> + * @name: name for the workqueue
> + *
> + * Allocates an ordered workqueue for timeout detection and recovery with
> + * %WQ_MEM_RECLAIM and %WQ_MEM_WARN_ON_RECLAIM set, ensuring consistent taint
> + * annotation with the submit workqueue. When CONFIG_LOCKDEP is enabled, uses
> + * a dedicated lockdep map for annotation.
> + *
> + * Context: Process context.
> + * Return: the new &workqueue_struct, or NULL on failure.
> + */
> +static struct workqueue_struct *drm_dep_alloc_timeout_wq(const char *name)
> +{
> +	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_MEM_WARN_ON_RECLAIM;
> +
> +#if IS_ENABLED(CONFIG_LOCKDEP)
> +	static struct lockdep_map map = {
> +		.name = "drm_dep_timeout_lockdep_map"
> +	};
> +	return alloc_ordered_workqueue_lockdep_map(name, wq_flags, &map);
> +#else
> +	return alloc_ordered_workqueue(name, wq_flags);
> +#endif
> +}
> +
> +/**
> + * drm_dep_queue_init() - initialize a dep queue
> + * @q: dep queue to initialize
> + * @args: initialization arguments
> + *
> + * Initializes all fields of @q from @args. If @args->submit_wq is NULL an
> + * ordered workqueue is allocated and owned by the queue
> + * (%DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ). If @args->timeout_wq is NULL an
> + * ordered workqueue is allocated and owned by the queue
> + * (%DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ). On success the queue holds one kref
> + * reference and drm_dep_queue_put() must be called to drop this reference
> + * (i.e., drivers cannot directly free the queue).
> + *
> + * When CONFIG_LOCKDEP is enabled, @q->sched.lock is primed against the
> + * fs_reclaim pseudo-lock so that lockdep can detect any lock ordering
> + * inversion between @sched.lock and memory reclaim.
> + *
> + * Return: 0 on success, %-EINVAL when @args->credit_limit is zero, @args->ops
> + * is NULL, @args->drm is NULL, @args->ops->run_job is NULL, or when
> + * @args->submit_wq or @args->timeout_wq is non-NULL but was not allocated with
> + * %WQ_MEM_WARN_ON_RECLAIM; %-ENOMEM when workqueue allocation fails.
> + *
> + * Context: Process context. May allocate memory and create workqueues.
> + */
> +int drm_dep_queue_init(struct drm_dep_queue *q,
> +		       const struct drm_dep_queue_init_args *args)
> +{
> +	if (!args->credit_limit || !args->drm || !args->ops ||
> +	    !args->ops->run_job)
> +		return -EINVAL;
> +
> +	if (args->submit_wq && !workqueue_is_reclaim_annotated(args->submit_wq))
> +		return -EINVAL;
> +
> +	if (args->timeout_wq &&
> +	    !workqueue_is_reclaim_annotated(args->timeout_wq))
> +		return -EINVAL;
> +
> +	memset(q, 0, sizeof(*q));
> +
> +	q->name = args->name;
> +	q->drm = args->drm;
> +	q->credit.limit = args->credit_limit;
> +	q->job.timeout = args->timeout ? args->timeout : MAX_SCHEDULE_TIMEOUT;
> +
> +	init_rcu_head(&q->rcu);
> +	INIT_LIST_HEAD(&q->job.pending);
> +	spin_lock_init(&q->job.lock);
> +	spsc_queue_init(&q->job.queue);
> +
> +	mutex_init(&q->sched.lock);
> +	if (IS_ENABLED(CONFIG_LOCKDEP)) {
> +		fs_reclaim_acquire(GFP_KERNEL);
> +		might_lock(&q->sched.lock);
> +		fs_reclaim_release(GFP_KERNEL);
> +	}
> +
> +	if (args->submit_wq) {
> +		q->sched.submit_wq = args->submit_wq;
> +	} else {
> +		q->sched.submit_wq = drm_dep_alloc_submit_wq(args->name ?: "drm_dep",
> +							     args->flags);
> +		if (!q->sched.submit_wq)
> +			return -ENOMEM;
> +
> +		q->sched.flags |= DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ;
> +	}
> +
> +	if (args->timeout_wq) {
> +		q->sched.timeout_wq = args->timeout_wq;
> +	} else {
> +		q->sched.timeout_wq = drm_dep_alloc_timeout_wq(args->name ?: "drm_dep");
> +		if (!q->sched.timeout_wq)
> +			goto err_submit_wq;
> +
> +		q->sched.flags |= DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ;
> +	}
> +
> +	q->sched.flags |= args->flags &
> +		~(DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ |
> +		  DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ);
> +
> +	INIT_DELAYED_WORK(&q->sched.tdr, drm_dep_queue_tdr_work);
> +	INIT_WORK(&q->sched.run_job, drm_dep_queue_run_job_work);
> +	INIT_WORK(&q->sched.put_job, drm_dep_queue_put_job_work);
> +
> +	q->fence.context = dma_fence_context_alloc(1);
> +
> +	kref_init(&q->refcount);
> +	q->ops = args->ops;
> +	drm_dev_get(q->drm);
> +
> +	return 0;
> +
> +err_submit_wq:
> +	if (q->sched.flags & DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ)
> +		destroy_workqueue(q->sched.submit_wq);
> +	mutex_destroy(&q->sched.lock);
> +
> +	return -ENOMEM;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_init);
> +
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING)
> +/**
> + * drm_dep_queue_push_job_begin() - mark the start of an arm/push critical section
> + * @q: dep queue the job belongs to
> + *
> + * Called at the start of drm_dep_job_arm() and warns if the push context is
> + * already owned by another task, which would indicate concurrent arm/push on
> + * the same queue.
> + *
> + * No-op when CONFIG_PROVE_LOCKING is disabled.
> + *
> + * Context: Process context. DMA fence signaling path.
> + */
> +void drm_dep_queue_push_job_begin(struct drm_dep_queue *q)
> +{
> +	WARN_ON(q->job.push.owner);
> +	q->job.push.owner = current;
> +}
> +
> +/**
> + * drm_dep_queue_push_job_end() - mark the end of an arm/push critical section
> + * @q: dep queue the job belongs to
> + *
> + * Called at the end of drm_dep_job_push() and warns if the push context is not
> + * owned by the current task, which would indicate a mismatched begin/end pair
> + * or a push from the wrong thread.
> + *
> + * No-op when CONFIG_PROVE_LOCKING is disabled.
> + *
> + * Context: Process context. DMA fence signaling path.
> + */
> +void drm_dep_queue_push_job_end(struct drm_dep_queue *q)
> +{
> +	WARN_ON(q->job.push.owner != current);
> +	q->job.push.owner = NULL;
> +}
> +#endif
> +
> +/**
> + * drm_dep_queue_assert_teardown_invariants() - assert teardown invariants
> + * @q: dep queue being torn down
> + *
> + * Warns if the pending-job list, the SPSC submission queue, or the credit
> + * counter is non-zero when called, or if the queue still has a non-zero
> + * reference count.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_queue_assert_teardown_invariants(struct drm_dep_queue *q)
> +{
> +	WARN_ON(!list_empty(&q->job.pending));
> +	WARN_ON(spsc_queue_count(&q->job.queue));
> +	WARN_ON(atomic_read(&q->credit.count));
> +	WARN_ON(drm_dep_queue_refcount(q));
> +}
> +
> +/**
> + * drm_dep_queue_release() - final internal cleanup of a dep queue
> + * @q: dep queue to clean up
> + *
> + * Asserts teardown invariants and destroys internal resources allocated by
> + * drm_dep_queue_init() that cannot be torn down earlier in the teardown
> + * sequence.  Currently this destroys @q->sched.lock.
> + *
> + * Drivers that implement &drm_dep_queue_ops.release **must** call this
> + * function after removing @q from any internal bookkeeping (e.g. lookup
> + * tables or lists) but before freeing the memory that contains @q.  When
> + * &drm_dep_queue_ops.release is NULL, drm_dep follows the default teardown
> + * path and calls this function automatically.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_queue_release(struct drm_dep_queue *q)
> +{
> +	drm_dep_queue_assert_teardown_invariants(q);
> +	mutex_destroy(&q->sched.lock);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_release);
> +
> +/**
> + * drm_dep_queue_free() - final cleanup of a dep queue
> + * @q: dep queue to free
> + *
> + * Invokes &drm_dep_queue_ops.release if set, in which case the driver is
> + * responsible for calling drm_dep_queue_release() and freeing @q itself.
> + * If &drm_dep_queue_ops.release is NULL, calls drm_dep_queue_release()
> + * and then frees @q with kfree_rcu().
> + *
> + * In either case, releases the drm_dev_get() reference taken at init time
> + * via drm_dev_put(), allowing the owning &drm_device to be unloaded once
> + * all queues have been freed.
> + *
> + * Context: Process context (workqueue), reclaim safe.
> + */
> +static void drm_dep_queue_free(struct drm_dep_queue *q)
> +{
> +	struct drm_device *drm = q->drm;
> +
> +	if (q->ops->release) {
> +		q->ops->release(q);
> +	} else {
> +		drm_dep_queue_release(q);
> +		kfree_rcu(q, rcu);
> +	}
> +	drm_dev_put(drm);
> +}
> +
> +/**
> + * drm_dep_queue_free_work() - deferred queue teardown worker
> + * @work: free_work item embedded in the dep queue
> + *
> + * Runs on dep_free_wq. Disables all work items synchronously
> + * (preventing re-queue and waiting for in-flight instances),
> + * destroys any owned workqueues, then calls drm_dep_queue_free().
> + * Running on dep_free_wq ensures destroy_workqueue() is never
> + * called from within one of the queue's own workers (deadlock)
> + * and disable_*_sync() cannot deadlock either.
> + *
> + * Context: Process context (workqueue), reclaim safe.
> + */
> +static void drm_dep_queue_free_work(struct work_struct *work)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(work, struct drm_dep_queue, free_work);
> +
> +	drm_dep_queue_assert_teardown_invariants(q);
> +
> +	disable_delayed_work_sync(&q->sched.tdr);
> +	disable_work_sync(&q->sched.run_job);
> +	disable_work_sync(&q->sched.put_job);
> +
> +	if (q->sched.flags & DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ)
> +		destroy_workqueue(q->sched.timeout_wq);
> +
> +	if (q->sched.flags & DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ)
> +		destroy_workqueue(q->sched.submit_wq);
> +
> +	drm_dep_queue_free(q);
> +}
> +
> +/**
> + * drm_dep_queue_fini() - tear down a dep queue
> + * @q: dep queue to tear down
> + *
> + * Asserts teardown invariants  and nitiates teardown of @q by queuing the
> + * deferred free work onto tht module-private dep_free_wq workqueue.  The work
> + * item disables any pending TDR and run/put-job work synchronously, destroys
> + * any workqueues that were allocated by drm_dep_queue_init(), and then releases
> + * the queue memory.
> + *
> + * Running teardown from dep_free_wq ensures that destroy_workqueue() is never
> + * called from within one of the queue's own workers (e.g. via
> + * drm_dep_queue_put()), which would deadlock.
> + *
> + * Drivers can wait for all outstanding deferred work to complete by waiting
> + * for the last drm_dev_put() reference on their &drm_device, which is
> + * released as the final step of each queue's teardown.
> + *
> + * Drivers that implement &drm_dep_queue_ops.fini **must** call this
> + * function after removing @q from any device bookkeeping but before freeing the
> + * memory that contains @q.  When &drm_dep_queue_ops.fini is NULL, drm_dep
> + * follows the default teardown path and calls this function automatically.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_queue_fini(struct drm_dep_queue *q)
> +{
> +	drm_dep_queue_assert_teardown_invariants(q);
> +
> +	INIT_WORK(&q->free_work, drm_dep_queue_free_work);
> +	queue_work(dep_free_wq, &q->free_work);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_fini);
> +
> +/**
> + * drm_dep_queue_get() - acquire a reference to a dep queue
> + * @q: dep queue to acquire a reference on, or NULL
> + *
> + * Return: @q with an additional reference held, or NULL if @q is NULL.
> + *
> + * Context: Any context.
> + */
> +struct drm_dep_queue *drm_dep_queue_get(struct drm_dep_queue *q)
> +{
> +	if (q)
> +		kref_get(&q->refcount);
> +	return q;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_get);
> +
> +/**
> + * __drm_dep_queue_release() - kref release callback for a dep queue
> + * @kref: kref embedded in the dep queue
> + *
> + * Calls &drm_dep_queue_ops.fini if set, otherwise calls
> + * drm_dep_queue_fini() to initiate deferred teardown.
> + *
> + * Context: Any context.
> + */
> +static void __drm_dep_queue_release(struct kref *kref)
> +{
> +	struct drm_dep_queue *q =
> +		container_of(kref, struct drm_dep_queue, refcount);
> +
> +	if (q->ops->fini)
> +		q->ops->fini(q);
> +	else
> +		drm_dep_queue_fini(q);
> +}
> +
> +/**
> + * drm_dep_queue_put() - release a reference to a dep queue
> + * @q: dep queue to release a reference on, or NULL
> + *
> + * When the last reference is dropped, calls &drm_dep_queue_ops.fini if set,
> + * otherwise calls drm_dep_queue_fini(). Final memory release is handled by
> + * &drm_dep_queue_ops.release (which must call drm_dep_queue_release()) if set,
> + * or drm_dep_queue_release() followed by kfree_rcu() otherwise.
> + * Does nothing if @q is NULL.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_queue_put(struct drm_dep_queue *q)
> +{
> +	if (q)
> +		kref_put(&q->refcount, __drm_dep_queue_release);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_put);
> +
> +/**
> + * drm_dep_queue_stop() - stop a dep queue from processing new jobs
> + * @q: dep queue to stop
> + *
> + * Sets %DRM_DEP_QUEUE_FLAGS_STOPPED on @q under both @q->sched.lock (mutex)
> + * and @q->job.lock (spinlock_irq), making the flag safe to test from finished
> + * fenced signaling context. Then cancels any in-flight run_job and put_job work
> + * items. Once stopped, the bypass path and the submit workqueue will not
> + * dispatch further jobs nor will any jobs be removed from the pending list.
> + * Call drm_dep_queue_start() to resume processing.
> + *
> + * Context: Process context. Waits for in-flight workers to complete.
> + */
> +void drm_dep_queue_stop(struct drm_dep_queue *q)
> +{
> +	scoped_guard(mutex, &q->sched.lock) {
> +		scoped_guard(spinlock_irq, &q->job.lock)
> +			drm_dep_queue_flags_set(q, DRM_DEP_QUEUE_FLAGS_STOPPED);
> +	}
> +	cancel_work_sync(&q->sched.run_job);
> +	cancel_work_sync(&q->sched.put_job);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_stop);
> +
> +/**
> + * drm_dep_queue_start() - resume a stopped dep queue
> + * @q: dep queue to start
> + *
> + * Clears %DRM_DEP_QUEUE_FLAGS_STOPPED on @q under both @q->sched.lock (mutex)
> + * and @q->job.lock (spinlock_irq), making the flag safe to test from IRQ
> + * context. Then re-queues the run_job and put_job work items so that any jobs
> + * pending since the queue was stopped are processed. Must only be called after
> + * drm_dep_queue_stop().
> + *
> + * Context: Process context.
> + */
> +void drm_dep_queue_start(struct drm_dep_queue *q)
> +{
> +	scoped_guard(mutex, &q->sched.lock) {
> +		scoped_guard(spinlock_irq, &q->job.lock)
> +			drm_dep_queue_flags_clear(q, DRM_DEP_QUEUE_FLAGS_STOPPED);
> +	}
> +	drm_dep_queue_run_job_queue(q);
> +	drm_dep_queue_put_job_queue(q);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_start);
> +
> +/**
> + * drm_dep_queue_trigger_timeout() - trigger the TDR immediately for
> + *   all pending jobs
> + * @q: dep queue to trigger timeout on
> + *
> + * Sets @q->job.timeout to 1 and arms the TDR delayed work with a one-jiffy
> + * delay, causing it to fire almost immediately without hot-spinning at zero
> + * delay. This is used to force-expire any pendind jobs on the queue, for
> + * example when the device is being torn down or has encountered an
> + * unrecoverable error.
> + *
> + * It is suggested that when this function is used, the first timedout_job call
> + * causes the driver to kick the queue off the hardware and signal all pending
> + * job fences. Subsequent calls continue to signal all pending job fences.
> + *
> + * Has no effect if the pending list is empty.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_queue_trigger_timeout(struct drm_dep_queue *q)
> +{
> +	guard(spinlock_irqsave)(&q->job.lock);
> +	q->job.timeout = 1;
> +	drm_queue_start_timeout(q);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_trigger_timeout);
> +
> +/**
> + * drm_dep_queue_cancel_tdr_sync() - cancel any pending TDR and wait
> + *   for it to finish
> + * @q: dep queue whose TDR to cancel
> + *
> + * Cancels the TDR delayed work item if it has not yet started, and waits for
> + * it to complete if it is already running.  After this call returns, the TDR
> + * worker is guaranteed not to be executing and will not fire again until
> + * explicitly rearmed (e.g. via drm_dep_queue_resume_timeout() or by a new
> + * job being submitted).
> + *
> + * Useful during error recovery or queue teardown when the caller needs to
> + * know that no timeout handling races with its own reset logic.
> + *
> + * Context: Process context. May sleep waiting for the TDR worker to finish.
> + */
> +void drm_dep_queue_cancel_tdr_sync(struct drm_dep_queue *q)
> +{
> +	cancel_delayed_work_sync(&q->sched.tdr);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_cancel_tdr_sync);
> +
> +/**
> + * drm_dep_queue_resume_timeout() - restart the TDR timer with the
> + *   configured timeout
> + * @q: dep queue to resume the timeout for
> + *
> + * Restarts the TDR delayed work using @q->job.timeout. Called after device
> + * recovery to give pending jobs a fresh full timeout window. Has no effect
> + * if the pending list is empty.
> + *
> + * Context: Any context.
> + */
> +void drm_dep_queue_resume_timeout(struct drm_dep_queue *q)
> +{
> +	drm_queue_start_timeout_unlocked(q);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_resume_timeout);
> +
> +/**
> + * drm_dep_queue_is_stopped() - check whether a dep queue is stopped
> + * @q: dep queue to check
> + *
> + * Return: true if %DRM_DEP_QUEUE_FLAGS_STOPPED is set on @q, false otherwise.
> + *
> + * Context: Any context.
> + */
> +bool drm_dep_queue_is_stopped(struct drm_dep_queue *q)
> +{
> +	return !!(q->sched.flags & DRM_DEP_QUEUE_FLAGS_STOPPED);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_is_stopped);
> +
> +/**
> + * drm_dep_queue_kill() - kill a dep queue and flush all pending jobs
> + * @q: dep queue to kill
> + *
> + * Sets %DRM_DEP_QUEUE_FLAGS_KILLED on @q under @q->sched.lock.  If a
> + * dependency fence is currently being waited on, its callback is removed and
> + * the run-job worker is kicked immediately so that the blocked job drains
> + * without waiting.
> + *
> + * Once killed, drm_dep_queue_job_dependency() returns NULL for all jobs,
> + * bypassing dependency waits so that every queued job drains through
> + * &drm_dep_queue_ops.run_job without blocking.
> + *
> + * The &drm_dep_queue_ops.run_job callback is guaranteed to be called for every
> + * job that was pushed before or after drm_dep_queue_kill(), even during queue
> + * teardown.  Drivers should use this guarantee to perform any necessary
> + * bookkeeping cleanup without executing the actual backend operation when the
> + * queue is killed.
> + *
> + * Unlike drm_dep_queue_stop(), killing is one-way: there is no corresponding
> + * start function.
> + *
> + * **Driver safety requirement**
> + *
> + * drm_dep_queue_kill() must only be called once the driver can guarantee that
> + * no job in the queue will touch memory associated with any of its fences
> + * (i.e., the queue has been removed from the device and will never be put back
> + * on).
> + *
> + * Context: Process context.
> + */
> +void drm_dep_queue_kill(struct drm_dep_queue *q)
> +{
> +	scoped_guard(mutex, &q->sched.lock) {
> +		struct dma_fence *fence;
> +
> +		drm_dep_queue_flags_set(q, DRM_DEP_QUEUE_FLAGS_KILLED);
> +
> +		/*
> +		 * Holding &q->sched.lock guarantees that the run-job work item
> +		 * cannot drop its reference to q->dep.fence concurrently, so
> +		 * reading q->dep.fence here is safe.
> +		 */
> +		fence = READ_ONCE(q->dep.fence);
> +		if (fence && dma_fence_remove_callback(fence, &q->dep.cb))
> +			drm_dep_queue_remove_dependency(q, fence);
> +	}
> +}
> +EXPORT_SYMBOL(drm_dep_queue_kill);
> +
> +/**
> + * drm_dep_queue_submit_wq() - retrieve the submit workqueue of a dep queue
> + * @q: dep queue whose workqueue to retrieve
> + *
> + * Drivers may use this to queue their own work items alongside the queue's
> + * internal run-job and put-job workers — for example to process incoming
> + * messages in the same serialisation domain.
> + *
> + * Prefer drm_dep_queue_work_enqueue() when the only need is to enqueue a
> + * work item, as it additionally checks the stopped state.  Use this accessor
> + * when the workqueue itself is required (e.g. for alloc_ordered_workqueue
> + * replacement or drain_workqueue calls).
> + *
> + * Context: Any context.
> + * Return: the &workqueue_struct used by @q for job submission.
> + */
> +struct workqueue_struct *drm_dep_queue_submit_wq(struct drm_dep_queue *q)
> +{
> +	return q->sched.submit_wq;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_submit_wq);
> +
> +/**
> + * drm_dep_queue_timeout_wq() - retrieve the timeout workqueue of a dep queue
> + * @q: dep queue whose workqueue to retrieve
> + *
> + * Returns the workqueue used by @q to run TDR (timeout detection and recovery)
> + * work.  Drivers may use this to queue their own timeout-domain work items, or
> + * to call drain_workqueue() when tearing down and needing to ensure all pending
> + * timeout callbacks have completed before proceeding.
> + *
> + * Context: Any context.
> + * Return: the &workqueue_struct used by @q for TDR work.
> + */
> +struct workqueue_struct *drm_dep_queue_timeout_wq(struct drm_dep_queue *q)
> +{
> +	return q->sched.timeout_wq;
> +}
> +EXPORT_SYMBOL(drm_dep_queue_timeout_wq);
> +
> +/**
> + * drm_dep_queue_work_enqueue() - queue work on the dep queue's submit workqueue
> + * @q: dep queue to enqueue work on
> + * @work: work item to enqueue
> + *
> + * Queues @work on @q->sched.submit_wq if the queue is not stopped.  This
> + * allows drivers to schedule custom work items that run serialised with the
> + * queue's own run-job and put-job workers.
> + *
> + * Return: true if the work was queued, false if the queue is stopped or the
> + * work item was already pending.
> + *
> + * Context: Any context.
> + */
> +bool drm_dep_queue_work_enqueue(struct drm_dep_queue *q,
> +				struct work_struct *work)
> +{
> +	if (drm_dep_queue_is_stopped(q))
> +		return false;
> +
> +	return queue_work(q->sched.submit_wq, work);
> +}
> +EXPORT_SYMBOL(drm_dep_queue_work_enqueue);
> +
> +/**
> + * drm_dep_queue_can_job_bypass() - test whether a job can skip the SPSC queue
> + * @q: dep queue
> + * @job: job to test
> + *
> + * A job may bypass the submit workqueue and run inline on the calling thread
> + * if all of the following hold:
> + *
> + *  - %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED is set on the queue
> + *  - the queue is not stopped
> + *  - the SPSC submission queue is empty (no other jobs waiting)
> + *  - the queue has enough credits for @job
> + *  - @job has no unresolved dependency fences
> + *
> + * Must be called under @q->sched.lock.
> + *
> + * Context: Process context. Must hold @q->sched.lock (a mutex).
> + * Return: true if the job may be run inline, false otherwise.
> + */
> +bool drm_dep_queue_can_job_bypass(struct drm_dep_queue *q,
> +				  struct drm_dep_job *job)
> +{
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	return q->sched.flags & DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED &&
> +		!drm_dep_queue_is_stopped(q) &&
> +		!spsc_queue_count(&q->job.queue) &&
> +		drm_dep_queue_has_credits(q, job) &&
> +		xa_empty(&job->dependencies);
> +}
> +
> +/**
> + * drm_dep_job_done() - mark a job as complete
> + * @job: the job that finished
> + * @result: error code to propagate, or 0 for success
> + *
> + * Subtracts @job->credits from the queue credit counter, then signals the
> + * job's dep fence with @result.
> + *
> + * When %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE is set (IRQ-safe path), a
> + * temporary extra reference is taken on @job before signalling the fence.
> + * This prevents a concurrent put-job worker — which may be woken by timeouts or
> + * queue starting — from freeing the job while this function still holds a
> + * pointer to it.  The extra reference is released at the end of the function.
> + *
> + * After signalling, the IRQ-safe path removes the job from the pending list
> + * under @q->job.lock, provided the queue is not stopped.  Removal is skipped
> + * when the queue is stopped so that drm_dep_queue_for_each_pending_job() can
> + * iterate the list without racing with the completion path.  On successful
> + * removal, kicks the run-job worker so the next queued job can be dispatched
> + * immediately, then drops the job reference.  If the job was already removed
> + * by TDR, or removal was skipped because the queue is stopped, kicks the
> + * put-job worker instead to allow the deferred put to complete.
> + *
> + * Context: Any context.
> + */
> +static void drm_dep_job_done(struct drm_dep_job *job, int result)
> +{
> +	struct drm_dep_queue *q = job->q;
> +	bool irq_safe = drm_dep_queue_is_job_put_irq_safe(q), removed = false;
> +
> +	/*
> +	 * Local ref to ensure the put worker—which may be woken by external
> +	 * forces (TDR, driver-side queue starting)—doesn't free the job behind
> +	 * this function's back after drm_dep_fence_done() while it is still on
> +	 * the pending list.
> +	 */
> +	if (irq_safe)
> +		drm_dep_job_get(job);
> +
> +	atomic_sub(job->credits, &q->credit.count);
> +	drm_dep_fence_done(job->dfence, result);
> +
> +	/* Only safe to touch job after fence signal if we have a local ref. */
> +
> +	if (irq_safe) {
> +		scoped_guard(spinlock_irqsave, &q->job.lock) {
> +			removed = !list_empty(&job->pending_link) &&
> +				!drm_dep_queue_is_stopped(q);
> +
> +			/* Guard against TDR operating on job */
> +			if (removed)
> +				drm_dep_queue_remove_job(q, job);
> +		}
> +	}
> +
> +	if (removed) {
> +		drm_dep_queue_run_job_queue(q);
> +		drm_dep_job_put(job);
> +	} else {
> +		drm_dep_queue_put_job_queue(q);
> +	}
> +
> +	if (irq_safe)
> +		drm_dep_job_put(job);
> +}
> +
> +/**
> + * drm_dep_job_done_cb() - dma_fence callback to complete a job
> + * @f: the hardware fence that signalled
> + * @cb: fence callback embedded in the dep job
> + *
> + * Extracts the job from @cb and calls drm_dep_job_done() with
> + * @f->error as the result.
> + *
> + * Context: Any context, but with IRQ disabled. May not sleep.
> + */
> +static void drm_dep_job_done_cb(struct dma_fence *f, struct dma_fence_cb *cb)
> +{
> +	struct drm_dep_job *job = container_of(cb, struct drm_dep_job, cb);
> +
> +	drm_dep_job_done(job, f->error);
> +}
> +
> +/**
> + * drm_dep_queue_run_job() - submit a job to hardware and set up
> + *   completion tracking
> + * @q: dep queue
> + * @job: job to run
> + *
> + * Accounts @job->credits against the queue, appends the job to the pending
> + * list, then calls @q->ops->run_job(). The TDR timer is started only when
> + * @job is the first entry on the pending list; subsequent jobs added while
> + * a TDR is already in flight do not reset the timer (which would otherwise
> + * extend the deadline for the already-running head job). Stores the returned
> + * hardware fence as the parent of the job's dep fence, then installs
> + * drm_dep_job_done_cb() on it. If the hardware fence is already signalled
> + * (%-ENOENT from dma_fence_add_callback()) or run_job() returns NULL/error,
> + * the job is completed immediately. Must be called under @q->sched.lock.
> + *
> + * Context: Process context. Must hold @q->sched.lock (a mutex). DMA fence
> + * signaling path.
> + */
> +void drm_dep_queue_run_job(struct drm_dep_queue *q, struct drm_dep_job *job)
> +{
> +	struct dma_fence *fence;
> +	int r;
> +
> +	lockdep_assert_held(&q->sched.lock);
> +
> +	drm_dep_job_get(job);
> +	atomic_add(job->credits, &q->credit.count);
> +
> +	scoped_guard(spinlock_irq, &q->job.lock) {
> +		bool first = list_empty(&q->job.pending);
> +
> +		list_add_tail(&job->pending_link, &q->job.pending);
> +		if (first)
> +			drm_queue_start_timeout(q);
> +	}
> +
> +	fence = q->ops->run_job(job);
> +	drm_dep_fence_set_parent(job->dfence, fence);
> +
> +	if (!IS_ERR_OR_NULL(fence)) {
> +		r = dma_fence_add_callback(fence, &job->cb,
> +					   drm_dep_job_done_cb);
> +		if (r == -ENOENT)
> +			drm_dep_job_done(job, fence->error);
> +		else if (r)
> +			drm_err(q->drm, "fence add callback failed (%d)\n", r);
> +		dma_fence_put(fence);
> +	} else {
> +		drm_dep_job_done(job, IS_ERR(fence) ? PTR_ERR(fence) : 0);
> +	}
> +
> +	/*
> +	 * Drop all input dependency fences now, in process context, before the
> +	 * final job put. Once the job is on the pending list its last reference
> +	 * may be dropped from a dma_fence callback (IRQ context), where calling
> +	 * xa_destroy() would be unsafe.
> +	 */
> +	drm_dep_job_drop_dependencies(job);
> +	drm_dep_job_put(job);
> +}
> +
> +/**
> + * drm_dep_queue_push_job() - enqueue a job on the SPSC submission queue
> + * @q: dep queue
> + * @job: job to push
> + *
> + * Pushes @job onto the SPSC queue. If the queue was previously empty
> + * (i.e. this is the first pending job), kicks the run_job worker so it
> + * processes the job promptly without waiting for the next wakeup.
> + * May be called with or without @q->sched.lock held.
> + *
> + * Context: Any context. DMA fence signaling path.
> + */
> +void drm_dep_queue_push_job(struct drm_dep_queue *q, struct drm_dep_job *job)
> +{
> +	/*
> +	 * spsc_queue_push() returns true if the queue was previously empty,
> +	 * i.e. this is the first pending job. Kick the run_job worker so it
> +	 * picks it up without waiting for the next wakeup.
> +	 */
> +	if (spsc_queue_push(&q->job.queue, &job->queue_node))
> +		drm_dep_queue_run_job_queue(q);
> +}
> +
> +/**
> + * drm_dep_init() - module initialiser
> + *
> + * Allocates the module-private dep_free_wq unbound workqueue used for
> + * deferred queue teardown.
> + *
> + * Return: 0 on success, %-ENOMEM if workqueue allocation fails.
> + */
> +static int __init drm_dep_init(void)
> +{
> +	dep_free_wq = alloc_workqueue("drm_dep_free", WQ_UNBOUND, 0);
> +	if (!dep_free_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * drm_dep_exit() - module exit
> + *
> + * Destroys the module-private dep_free_wq workqueue.
> + */
> +static void __exit drm_dep_exit(void)
> +{
> +	destroy_workqueue(dep_free_wq);
> +	dep_free_wq = NULL;
> +}
> +
> +module_init(drm_dep_init);
> +module_exit(drm_dep_exit);
> +
> +MODULE_DESCRIPTION("DRM dependency queue");
> +MODULE_LICENSE("Dual MIT/GPL");
> diff --git a/drivers/gpu/drm/dep/drm_dep_queue.h b/drivers/gpu/drm/dep/drm_dep_queue.h
> new file mode 100644
> index 000000000000..e5c217a3fab5
> --- /dev/null
> +++ b/drivers/gpu/drm/dep/drm_dep_queue.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _DRM_DEP_QUEUE_H_
> +#define _DRM_DEP_QUEUE_H_
> +
> +#include <linux/types.h>
> +
> +struct drm_dep_job;
> +struct drm_dep_queue;
> +
> +bool drm_dep_queue_can_job_bypass(struct drm_dep_queue *q,
> +				  struct drm_dep_job *job);
> +void drm_dep_queue_run_job(struct drm_dep_queue *q, struct drm_dep_job *job);
> +void drm_dep_queue_push_job(struct drm_dep_queue *q, struct drm_dep_job *job);
> +
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING)
> +void drm_dep_queue_push_job_begin(struct drm_dep_queue *q);
> +void drm_dep_queue_push_job_end(struct drm_dep_queue *q);
> +#else
> +static inline void drm_dep_queue_push_job_begin(struct drm_dep_queue *q)
> +{
> +}
> +static inline void drm_dep_queue_push_job_end(struct drm_dep_queue *q)
> +{
> +}
> +#endif
> +
> +#endif /* _DRM_DEP_QUEUE_H_ */
> diff --git a/include/drm/drm_dep.h b/include/drm/drm_dep.h
> new file mode 100644
> index 000000000000..615926584506
> --- /dev/null
> +++ b/include/drm/drm_dep.h
> @@ -0,0 +1,597 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Copyright © 2026 Intel Corporation
> + */
> +
> +#ifndef _DRM_DEP_H_
> +#define _DRM_DEP_H_
> +
> +#include <drm/spsc_queue.h>
> +#include <linux/dma-fence.h>
> +#include <linux/xarray.h>
> +#include <linux/workqueue.h>
> +
> +enum dma_resv_usage;
> +struct dma_resv;
> +struct drm_dep_fence;
> +struct drm_dep_job;
> +struct drm_dep_queue;
> +struct drm_file;
> +struct drm_gem_object;
> +
> +/**
> + * enum drm_dep_timedout_stat - return value of &drm_dep_queue_ops.timedout_job
> + * @DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED: driver signaled the job's finished
> + *   fence during reset; drm_dep may safely drop its reference to the job.
> + * @DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB: timeout was a false alarm; reinsert the
> + *   job at the head of the pending list so it can complete normally.
> + */
> +enum drm_dep_timedout_stat {
> +	DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED,
> +	DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB,
> +};
> +
> +/**
> + * struct drm_dep_queue_ops - driver callbacks for a dep queue
> + */
> +struct drm_dep_queue_ops {
> +	/**
> +	 * @run_job: submit the job to hardware. Returns the hardware completion
> +	 * fence (with a reference held for the scheduler), or NULL/ERR_PTR on
> +	 * synchronous completion or error.
> +	 */
> +	struct dma_fence *(*run_job)(struct drm_dep_job *job);
> +
> +	/**
> +	 * @timedout_job: called when the TDR fires for the head job. Must stop
> +	 * the hardware, then return %DRM_DEP_TIMEDOUT_STAT_JOB_SIGNALED if the
> +	 * job's fence was signalled during reset, or
> +	 * %DRM_DEP_TIMEDOUT_STAT_REQUEUE_JOB if the timeout was spurious or
> +	 * signalling was otherwise delayed, and the job should be re-inserted
> +	 * at the head of the pending list. Any other value triggers a WARN.
> +	 */
> +	enum drm_dep_timedout_stat (*timedout_job)(struct drm_dep_job *job);
> +
> +	/**
> +	 * @release: called when the last kref on the queue is dropped and
> +	 * drm_dep_queue_fini() has completed.  The driver is responsible for
> +	 * removing @q from any internal bookkeeping, calling
> +	 * drm_dep_queue_release(), and then freeing the memory containing @q
> +	 * (e.g. via kfree_rcu() using @q->rcu).  If NULL, drm_dep calls
> +	 * drm_dep_queue_release() and frees @q automatically via kfree_rcu().
> +	 * Use this when the queue is embedded in a larger structure.
> +	 */
> +	void (*release)(struct drm_dep_queue *q);
> +
> +	/**
> +	 * @fini: if set, called instead of drm_dep_queue_fini() when the last
> +	 * kref is dropped. The driver is responsible for calling
> +	 * drm_dep_queue_fini() itself after it is done with the queue. Use this
> +	 * when additional teardown logic must run before fini (e.g., cleanup
> +	 * firmware resources associated with the queue).
> +	 */
> +	void (*fini)(struct drm_dep_queue *q);
> +};
> +
> +/**
> + * enum drm_dep_queue_flags - flags for &drm_dep_queue and
> + *   &drm_dep_queue_init_args
> + *
> + * Flags are divided into three categories:
> + *
> + * - **Private static**: set internally at init time and never changed.
> + *   Drivers must not read or write these.
> + *   %DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ,
> + *   %DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ.
> + *
> + * - **Public dynamic**: toggled at runtime by drivers via accessors.
> + *   Any modification must be performed under &drm_dep_queue.sched.lock.
> + *   Accessor functions provide unstable reads.
> + *   %DRM_DEP_QUEUE_FLAGS_STOPPED,
> + *   %DRM_DEP_QUEUE_FLAGS_KILLED.
> + *
> + * - **Public static**: supplied by the driver in
> + *   &drm_dep_queue_init_args.flags at queue creation time and not modified
> + *   thereafter.
> + *   %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED,
> + *   %DRM_DEP_QUEUE_FLAGS_HIGHPRI,
> + *   %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE.
> + *
> + * @DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ: (private, static) submit workqueue was
> + *   allocated by drm_dep_queue_init() and will be destroyed by
> + *   drm_dep_queue_fini().
> + * @DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ: (private, static) timeout workqueue
> + *   was allocated by drm_dep_queue_init() and will be destroyed by
> + *   drm_dep_queue_fini().
> + * @DRM_DEP_QUEUE_FLAGS_STOPPED: (public, dynamic) the queue is stopped and
> + *   will not dispatch new jobs or remove jobs from the pending list, dropping
> + *   the drm_dep-owned reference. Set by drm_dep_queue_stop(), cleared by
> + *   drm_dep_queue_start().
> + * @DRM_DEP_QUEUE_FLAGS_KILLED: (public, dynamic) the queue has been killed
> + *   via drm_dep_queue_kill(). Any active dependency wait is cancelled
> + *   immediately.  Jobs continue to flow through run_job for bookkeeping
> + *   cleanup, but dependency waiting is skipped so that queued work drains
> + *   as quickly as possible.
> + * @DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED: (public, static) the queue supports
> + *   the bypass path where eligible jobs skip the SPSC queue and run inline.
> + * @DRM_DEP_QUEUE_FLAGS_HIGHPRI: (public, static) the submit workqueue owned
> + *   by the queue is created with %WQ_HIGHPRI, causing run-job and put-job
> + *   workers to execute at elevated priority. Only privileged clients (e.g.
> + *   drivers managing time-critical or real-time GPU contexts) should request
> + *   this flag; granting it to unprivileged userspace would allow priority
> + *   inversion attacks.
> + *   @drm_dep_queue_init_args.submit_wq is provided.
> + * @DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE: (public, static) when set,
> + *   drm_dep_job_done() may be called from hardirq context (e.g. from a
> + *   hardware-signalled dma_fence callback). drm_dep_job_done() will directly
> + *   dequeue the job and call drm_dep_job_put() without deferring to a
> + *   workqueue. The driver's &drm_dep_job_ops.release callback must therefore
> + *   be safe to invoke from IRQ context.
> + */
> +enum drm_dep_queue_flags {
> +	DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ	= BIT(0),
> +	DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ	= BIT(1),
> +	DRM_DEP_QUEUE_FLAGS_STOPPED		= BIT(2),
> +	DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED	= BIT(3),
> +	DRM_DEP_QUEUE_FLAGS_HIGHPRI		= BIT(4),
> +	DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE	= BIT(5),
> +	DRM_DEP_QUEUE_FLAGS_KILLED		= BIT(6),
> +};
> +
> +/**
> + * struct drm_dep_queue - a dependency-tracked GPU submission queue
> + *
> + * Combines the role of &drm_gpu_scheduler and &drm_sched_entity into a single
> + * object.  Each queue owns a submit workqueue (or borrows one), a timeout
> + * workqueue, an SPSC submission queue, and a pending-job list used for TDR.
> + *
> + * Initialise with drm_dep_queue_init(), tear down with drm_dep_queue_fini().
> + * Reference counted via drm_dep_queue_get() / drm_dep_queue_put().
> + *
> + * All fields are **opaque to drivers**.  Do not read or write any field
> + * directly; use the provided helper functions instead.  The sole exception
> + * is @rcu, which drivers may pass to kfree_rcu() when the queue is embedded
> + * inside a larger driver-managed structure and the &drm_dep_queue_ops.release
> + * vfunc performs an RCU-deferred free.
> + */
> +struct drm_dep_queue {
> +	/** @ops: driver callbacks, set at init time. */
> +	const struct drm_dep_queue_ops *ops;
> +	/** @name: human-readable name used for workqueue and fence naming. */
> +	const char *name;
> +	/** @drm: owning DRM device; a drm_dev_get() reference is held for the
> +	 *  lifetime of the queue to prevent module unload while queues are live.
> +	 */
> +	struct drm_device *drm;
> +	/** @refcount: reference count; use drm_dep_queue_get/put(). */
> +	struct kref refcount;
> +	/**
> +	 * @free_work: deferred teardown work queued unconditionally by
> +	 * drm_dep_queue_fini() onto the module-private dep_free_wq.  The work
> +	 * item disables pending workers synchronously and destroys any owned
> +	 * workqueues before releasing the queue memory and dropping the
> +	 * drm_dev_get() reference.  Running on dep_free_wq ensures
> +	 * destroy_workqueue() is never called from within one of the queue's
> +	 * own workers.
> +	 */
> +	struct work_struct free_work;
> +	/**
> +	 * @rcu: RCU head for deferred freeing.
> +	 *
> +	 * This is the **only** field drivers may access directly.  When the
> +	 * queue is embedded in a larger structure, implement
> +	 * &drm_dep_queue_ops.release, call drm_dep_queue_release() to destroy
> +	 * internal resources, then pass this field to kfree_rcu() so that any
> +	 * in-flight RCU readers referencing the queue's dma_fence timeline name
> +	 * complete before the memory is returned.  All other fields must be
> +	 * accessed through the provided helpers.
> +	 */
> +	struct rcu_head rcu;
> +
> +	/** @sched: scheduling and workqueue state. */
> +	struct {
> +		/** @sched.submit_wq: ordered workqueue for run/put-job work. */
> +		struct workqueue_struct	*submit_wq;
> +		/** @sched.timeout_wq: workqueue for the TDR delayed work. */
> +		struct workqueue_struct	*timeout_wq;
> +		/**
> +		 * @sched.run_job: work item that dispatches the next queued
> +		 * job.
> +		 */
> +		struct work_struct run_job;
> +		/** @sched.put_job: work item that frees finished jobs. */
> +		struct work_struct put_job;
> +		/** @sched.tdr: delayed work item for timeout/reset (TDR). */
> +		struct delayed_work tdr;
> +		/**
> +		 * @sched.lock: mutex serialising job dispatch, bypass
> +		 * decisions, stop/start, and flag updates.
> +		 */
> +		struct mutex lock;
> +		/**
> +		 * @sched.flags: bitmask of &enum drm_dep_queue_flags.
> +		 * Any modification after drm_dep_queue_init() must be
> +		 * performed under @sched.lock.
> +		 */
> +		enum drm_dep_queue_flags flags;
> +	} sched;
> +
> +	/** @job: pending-job tracking state. */
> +	struct {
> +		/**
> +		 * @job.pending: list of jobs that have been dispatched to
> +		 * hardware and not yet freed. Protected by @job.lock.
> +		 */
> +		struct list_head pending;
> +		/**
> +		 * @job.queue: SPSC queue of jobs waiting to be dispatched.
> +		 * Producers push via drm_dep_queue_push_job(); the run_job
> +		 * work item pops from the consumer side.
> +		 */
> +		struct spsc_queue queue;
> +		/**
> +		 * @job.lock: spinlock protecting @job.pending, TDR start, and
> +		 * the %DRM_DEP_QUEUE_FLAGS_STOPPED flag. Always acquired with
> +		 * irqsave (spin_lock_irqsave / spin_unlock_irqrestore) to
> +		 * support %DRM_DEP_QUEUE_FLAGS_JOB_PUT_IRQ_SAFE queues where
> +		 * drm_dep_job_done() may run from hardirq context.
> +		 */
> +		spinlock_t lock;
> +		/**
> +		 * @job.timeout: per-job TDR timeout in jiffies.
> +		 * %MAX_SCHEDULE_TIMEOUT means no timeout.
> +		 */
> +		long timeout;
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING)
> +		/**
> +		 * @job.push: lockdep annotation tracking the arm-to-push
> +		 * critical section.
> +		 */
> +		struct {
> +			/*
> +			 * @job.push.owner: task that currently holds the push
> +			 * context, used to assert single-owner invariants.
> +			 * NULL when idle.
> +			 */
> +			struct task_struct *owner;
> +		} push;
> +#endif
> +	} job;
> +
> +	/** @credit: hardware credit accounting. */
> +	struct {
> +		/** @credit.limit: maximum credits the queue can hold. */
> +		u32 limit;
> +		/** @credit.count: credits currently in flight (atomic). */
> +		atomic_t count;
> +	} credit;
> +
> +	/** @dep: current blocking dependency for the head SPSC job. */
> +	struct {
> +		/**
> +		 * @dep.fence: fence being waited on before the head job can
> +		 * run. NULL when no dependency is pending.
> +		 */
> +		struct dma_fence *fence;
> +		/**
> +		 * @dep.removed_fence: dependency fence whose callback has been
> +		 * removed.  The run-job worker must drop its reference to this
> +		 * fence before proceeding to call run_job.
> +		 */
> +		struct dma_fence *removed_fence;
> +		/** @dep.cb: callback installed on @dep.fence. */
> +		struct dma_fence_cb cb;
> +	} dep;
> +
> +	/** @fence: fence context and sequence number state. */
> +	struct {
> +		/**
> +		 * @fence.seqno: next sequence number to assign, incremented
> +		 * each time a job is armed.
> +		 */
> +		u32 seqno;
> +		/**
> +		 * @fence.context: base DMA fence context allocated at init
> +		 * time. Finished fences use this context.
> +		 */
> +		u64 context;
> +	} fence;
> +};
> +
> +/**
> + * struct drm_dep_queue_init_args - arguments for drm_dep_queue_init()
> + */
> +struct drm_dep_queue_init_args {
> +	/** @ops: driver callbacks; must not be NULL. */
> +	const struct drm_dep_queue_ops *ops;
> +	/** @name: human-readable name for workqueues and fence timelines. */
> +	const char *name;
> +	/** @drm: owning DRM device. A drm_dev_get() reference is taken at
> +	 *  queue init and released when the queue is freed, preventing module
> +	 *  unload while any queue is still alive.
> +	 */
> +	struct drm_device *drm;
> +	/**
> +	 * @submit_wq: workqueue for job dispatch. If NULL, an ordered
> +	 * workqueue is allocated and owned by the queue.  If non-NULL, the
> +	 * workqueue must have been allocated with %WQ_MEM_RECLAIM_TAINT;
> +	 * drm_dep_queue_init() returns %-EINVAL otherwise.
> +	 */
> +	struct workqueue_struct *submit_wq;
> +	/**
> +	 * @timeout_wq: workqueue for TDR. If NULL, an ordered workqueue
> +	 * is allocated and owned by the queue.  If non-NULL, the workqueue
> +	 * must have been allocated with %WQ_MEM_RECLAIM_TAINT;
> +	 * drm_dep_queue_init() returns %-EINVAL otherwise.
> +	 */
> +	struct workqueue_struct *timeout_wq;
> +	/** @credit_limit: maximum hardware credits; must be non-zero. */
> +	u32 credit_limit;
> +	/**
> +	 * @timeout: per-job TDR timeout in jiffies. Zero means no timeout
> +	 * (%MAX_SCHEDULE_TIMEOUT is used internally).
> +	 */
> +	long timeout;
> +	/**
> +	 * @flags: initial queue flags. %DRM_DEP_QUEUE_FLAGS_OWN_SUBMIT_WQ
> +	 * and %DRM_DEP_QUEUE_FLAGS_OWN_TIMEDOUT_WQ are managed internally
> +	 * and will be ignored if set here. Setting
> +	 * %DRM_DEP_QUEUE_FLAGS_HIGHPRI requests a high-priority submit
> +	 * workqueue; drivers must only set this for privileged clients.
> +	 */
> +	enum drm_dep_queue_flags flags;
> +};
> +
> +/**
> + * struct drm_dep_job_ops - driver callbacks for a dep job
> + */
> +struct drm_dep_job_ops {
> +	/**
> +	 * @release: called when the last reference to the job is dropped.
> +	 *
> +	 * If set, the driver is responsible for freeing the job. If NULL,
> +	 * drm_dep_job_put() will call kfree() on the job directly.
> +	 */
> +	void (*release)(struct drm_dep_job *job);
> +};
> +
> +/**
> + * struct drm_dep_job - a unit of work submitted to a dep queue
> + *
> + * All fields are **opaque to drivers**.  Do not read or write any field
> + * directly; use the provided helper functions instead.
> + */
> +struct drm_dep_job {
> +	/** @ops: driver callbacks for this job. */
> +	const struct drm_dep_job_ops *ops;
> +	/** @refcount: reference count, managed by drm_dep_job_get/put(). */
> +	struct kref refcount;
> +	/**
> +	 * @dependencies: xarray of &dma_fence dependencies before the job can
> +	 * run.
> +	 */
> +	struct xarray dependencies;
> +	/** @q: the queue this job is submitted to. */
> +	struct drm_dep_queue *q;
> +	/** @queue_node: SPSC queue linkage for pending submission. */
> +	struct spsc_node queue_node;
> +	/**
> +	 * @pending_link: list entry in the queue's pending job list. Protected
> +	 * by @job.q->job.lock.
> +	 */
> +	struct list_head pending_link;
> +	/** @dfence: finished fence for this job. */
> +	struct drm_dep_fence *dfence;
> +	/** @cb: fence callback used to watch for dependency completion. */
> +	struct dma_fence_cb cb;
> +	/** @credits: number of credits this job consumes from the queue. */
> +	u32 credits;
> +	/**
> +	 * @last_dependency: index into @dependencies of the next fence to
> +	 * check. Advanced by drm_dep_queue_job_dependency() as each
> +	 * dependency is consumed.
> +	 */
> +	u32 last_dependency;
> +	/**
> +	 * @invalidate_count: number of times this job has been invalidated.
> +	 * Incremented by drm_dep_job_invalidate_job().
> +	 */
> +	u32 invalidate_count;
> +	/**
> +	 * @signalling_cookie: return value of dma_fence_begin_signalling()
> +	 * captured in drm_dep_job_arm() and consumed by drm_dep_job_push().
> +	 * Not valid outside the arm→push window.
> +	 */
> +	bool signalling_cookie;
> +};
> +
> +/**
> + * struct drm_dep_job_init_args - arguments for drm_dep_job_init()
> + */
> +struct drm_dep_job_init_args {
> +	/**
> +	 * @ops: driver callbacks for the job, or NULL for default behaviour.
> +	 */
> +	const struct drm_dep_job_ops *ops;
> +	/** @q: the queue to associate the job with. A reference is taken. */
> +	struct drm_dep_queue *q;
> +	/** @credits: number of credits this job consumes; must be non-zero. */
> +	u32 credits;
> +};
> +
> +/* Queue API */
> +
> +/**
> + * drm_dep_queue_sched_guard() - acquire the queue scheduler lock as a guard
> + * @__q: dep queue whose scheduler lock to acquire
> + *
> + * Acquires @__q->sched.lock as a scoped mutex guard (released automatically
> + * when the enclosing scope exits).  This lock serialises all scheduler state
> + * transitions — stop/start/kill flag changes, bypass-path decisions, and the
> + * run-job worker — so it must be held when the driver needs to atomically
> + * inspect or modify queue state in relation to job submission.
> + *
> + * **When to use**
> + *
> + * Drivers that set %DRM_DEP_QUEUE_FLAGS_BYPASS_SUPPORTED and wish to
> + * serialise their own submit work against the bypass path must acquire this
> + * guard.  Without it, a concurrent caller of drm_dep_job_push() could take
> + * the bypass path and call ops->run_job() inline between the driver's
> + * eligibility check and its corresponding action, producing a race.
> + *
> + * **Constraint: only from submit_wq worker context**
> + *
> + * This guard must only be acquired from a work item running on the queue's
> + * submit workqueue (@q->sched.submit_wq) by drivers.
> + *
> + * Context: Process context only; must be called from submit_wq work by
> + * drivers.
> + */
> +#define drm_dep_queue_sched_guard(__q)	\
> +	guard(mutex)(&(__q)->sched.lock)
> +
> +int drm_dep_queue_init(struct drm_dep_queue *q,
> +		       const struct drm_dep_queue_init_args *args);
> +void drm_dep_queue_fini(struct drm_dep_queue *q);
> +void drm_dep_queue_release(struct drm_dep_queue *q);
> +struct drm_dep_queue *drm_dep_queue_get(struct drm_dep_queue *q);
> +bool drm_dep_queue_get_unless_zero(struct drm_dep_queue *q);
> +void drm_dep_queue_put(struct drm_dep_queue *q);
> +void drm_dep_queue_stop(struct drm_dep_queue *q);
> +void drm_dep_queue_start(struct drm_dep_queue *q);
> +void drm_dep_queue_kill(struct drm_dep_queue *q);
> +void drm_dep_queue_trigger_timeout(struct drm_dep_queue *q);
> +void drm_dep_queue_cancel_tdr_sync(struct drm_dep_queue *q);
> +void drm_dep_queue_resume_timeout(struct drm_dep_queue *q);
> +bool drm_dep_queue_work_enqueue(struct drm_dep_queue *q,
> +				struct work_struct *work);
> +bool drm_dep_queue_is_stopped(struct drm_dep_queue *q);
> +bool drm_dep_queue_is_killed(struct drm_dep_queue *q);
> +bool drm_dep_queue_is_initialized(struct drm_dep_queue *q);
> +void drm_dep_queue_set_stopped(struct drm_dep_queue *q);
> +unsigned int drm_dep_queue_refcount(const struct drm_dep_queue *q);
> +long drm_dep_queue_timeout(const struct drm_dep_queue *q);
> +struct workqueue_struct *drm_dep_queue_submit_wq(struct drm_dep_queue *q);
> +struct workqueue_struct *drm_dep_queue_timeout_wq(struct drm_dep_queue *q);
> +
> +/* Job API */
> +
> +/**
> + * DRM_DEP_JOB_FENCE_PREALLOC - sentinel value for pre-allocating a dependency slot
> + *
> + * Pass this to drm_dep_job_add_dependency() instead of a real fence to
> + * pre-allocate a slot in the job's dependency xarray during the preparation
> + * phase (where GFP_KERNEL is available).  The returned xarray index identifies
> + * the slot.  Call drm_dep_job_replace_dependency() later — inside a
> + * dma_fence_begin_signalling() region if needed — to swap in the real fence
> + * without further allocation.
> + *
> + * This sentinel is never treated as a dma_fence; it carries no reference count
> + * and must not be passed to dma_fence_put().  It is only valid as an argument
> + * to drm_dep_job_add_dependency() and as the expected stored value checked by
> + * drm_dep_job_replace_dependency().
> + */
> +#define DRM_DEP_JOB_FENCE_PREALLOC	((struct dma_fence *)-1)
> +
> +int drm_dep_job_init(struct drm_dep_job *job,
> +		     const struct drm_dep_job_init_args *args);
> +struct drm_dep_job *drm_dep_job_get(struct drm_dep_job *job);
> +void drm_dep_job_put(struct drm_dep_job *job);
> +void drm_dep_job_arm(struct drm_dep_job *job);
> +void drm_dep_job_push(struct drm_dep_job *job);
> +int drm_dep_job_add_dependency(struct drm_dep_job *job,
> +			       struct dma_fence *fence);
> +void drm_dep_job_replace_dependency(struct drm_dep_job *job, u32 index,
> +				    struct dma_fence *fence);
> +int drm_dep_job_add_syncobj_dependency(struct drm_dep_job *job,
> +				       struct drm_file *file, u32 handle,
> +				       u32 point);
> +int drm_dep_job_add_resv_dependencies(struct drm_dep_job *job,
> +				      struct dma_resv *resv,
> +				      enum dma_resv_usage usage);
> +int drm_dep_job_add_implicit_dependencies(struct drm_dep_job *job,
> +					  struct drm_gem_object *obj,
> +					  bool write);
> +bool drm_dep_job_is_signaled(struct drm_dep_job *job);
> +bool drm_dep_job_is_finished(struct drm_dep_job *job);
> +bool drm_dep_job_invalidate_job(struct drm_dep_job *job, int threshold);
> +struct dma_fence *drm_dep_job_finished_fence(struct drm_dep_job *job);
> +
> +/**
> + * struct drm_dep_queue_pending_job_iter - iterator state for
> + *   drm_dep_queue_for_each_pending_job()
> + * @q: queue being iterated
> + */
> +struct drm_dep_queue_pending_job_iter {
> +	struct drm_dep_queue *q;
> +};
> +
> +/* Drivers should never call this directly */
> +static inline struct drm_dep_queue_pending_job_iter
> +__drm_dep_queue_pending_job_iter_begin(struct drm_dep_queue *q)
> +{
> +	struct drm_dep_queue_pending_job_iter iter = {
> +		.q = q,
> +	};
> +
> +	WARN_ON(!drm_dep_queue_is_stopped(q));
> +	return iter;
> +}
> +
> +/* Drivers should never call this directly */
> +static inline void
> +__drm_dep_queue_pending_job_iter_end(struct drm_dep_queue_pending_job_iter iter)
> +{
> +	WARN_ON(!drm_dep_queue_is_stopped(iter.q));
> +}
> +
> +/* clang-format off */
> +DEFINE_CLASS(drm_dep_queue_pending_job_iter,
> +	     struct drm_dep_queue_pending_job_iter,
> +	     __drm_dep_queue_pending_job_iter_end(_T),
> +	     __drm_dep_queue_pending_job_iter_begin(__q),
> +	     struct drm_dep_queue *__q);
> +/* clang-format on */
> +static inline void *
> +class_drm_dep_queue_pending_job_iter_lock_ptr(
> +	class_drm_dep_queue_pending_job_iter_t *_T)
> +{ return _T; }
> +#define class_drm_dep_queue_pending_job_iter_is_conditional false
> +
> +/**
> + * drm_dep_queue_for_each_pending_job() - iterate over all pending jobs
> + *   in a queue
> + * @__job: loop cursor, a &struct drm_dep_job pointer
> + * @__q: &struct drm_dep_queue to iterate
> + *
> + * Iterates over every job currently on @__q->job.pending. The queue must be
> + * stopped (drm_dep_queue_stop() called) before using this iterator; a WARN_ON
> + * fires at the start and end of the scope if it is not.
> + *
> + * Context: Any context.
> + */
> +#define drm_dep_queue_for_each_pending_job(__job, __q)			\
> +	scoped_guard(drm_dep_queue_pending_job_iter, (__q))		\
> +		list_for_each_entry((__job), &(__q)->job.pending, pending_link)
> +
> +#endif

