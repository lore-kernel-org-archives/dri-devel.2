Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kXasi6C+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0556910E280;
	Mon, 16 Nov 2026 05:29:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010011.outbound.protection.outlook.com
 [40.93.198.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2DC10E10C;
 Mon, 16 Nov 2026 05:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3NnFjLM14dgMeJJRwr3wAkqegyMzL6JN6Ga2wM76aYXRPitGpox9+HDrjgvrBisV+/9NeRQ4hQykj3BzWyOTYagDEpRXiya64pkg8GQXGVPgKBpNC/jhfEMvoiqX+OIW0uySareQbBVLf+rSnVDg5SGuQnkRp/kl1FInnjJEZ4/D3q5WDSMqci8kvWZhL+9XOrOx6NDiRDEq0GfQjeobyzQQ+o9A0BQvi9sBHS/2Co1B3LparhRqIEWvNODfJk+Plt1odXlAI9emUF7TwCjtlsbXDXN2Sy85yT1Qk34Tv8z92wN34vt2ajcnqmgXGlLpUfefwXxdi0X68UxuZ7NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZyoE5k+tZCmqdxTMPzLHAEif+TqC4NyKC4CPbRVgfM=;
 b=QSjbkU5x+D/ta2bueSRZRYkE/vYexjeffIjtpzsSh8/xWttxPWaLFCJkKMzTZm9MQBwd42b1QSOHKf0r0e2y2I6CshHnzgjoyQTzD9Z1TQuz50gbb1U0gH2y3I0pvJAm0gLuRs+LIsmPpuM8IeyCDuJ6o2mBGUvjUQJziDfVLW8RGj7LEl3HuTNitfTkSHNuTIfBhAUUEMLv0VMzaLaNMOdH8oEnW0z7LWtRtVIxwJaw3GozUXn4CDr2Ahh0Lvd4K9Q7B1aFx4BqmoTloem0bjBb+IjyNVSqTWzkde5kkij3IaRnWk90M7Vol4ciFCWVr+4FVT511YHcBL8oRNqu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZyoE5k+tZCmqdxTMPzLHAEif+TqC4NyKC4CPbRVgfM=;
 b=kXasi6C++MsNqOwRzeuNiQxmWiK2oz4dIZHR2TwYxeD0hO46mrEyjZknq6tSc2yvFNp/I5QWO3gZvI36SeFTg7iQP01FyoV+rl8lOSnH5iBsHppi9D6G8FWuw1rPFkTe30G1zjYSXsU14JYzba6v0+E4s7KnxYiM9y8b4eVZhxg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:18:17 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 05:18:17 +0000
Message-ID: <1bf6fd84-9ea5-49fd-b906-7b2c9692c018@amd.com>
Date: Mon, 16 Nov 2026 13:18:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/22] drm/amdgpu: add SVM core header and VM
 integration
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-3-ray.huang@amd.com>
 <ee28d94b-ab11-4625-9c01-435491548f9d@amd.com>
 <101922f3-d918-4429-a7c8-c96f72474993@amd.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <101922f3-d918-4429-a7c8-c96f72474993@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: c34bfbfd-f530-40ef-c9b3-08df43a10565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NK0g1ErDsTq19GX1MhairBC6UTahm62Um2UZQG0g7ocYkKYt4XMTYIJwZ/2cT8kAIY9Po5pTPwO4Cp9qC0toloOX4hUzTVPLv+t8eNCV48LOW5FamLwcoWLxLorCI7UXw6LvxPMOzP8vV3P90zO+/6Zgb0rjxbjs8PfU4hdOkGYKG2CrW+YleugB7wFp5i+F5PM4u+V6aB8DxJwQK78NDBbfjrYr3tvjlhIY6Z5/XNMbukM8QnpWyixGmQ11FQqh4Sz0f9JNuVValnKEm9ry8Z+wi27ma/46tSrrHSLs/5X+CXCYyOGlXAXeurST2gllkQWMd0uiJWbCvLxvYq6xexBqiZwSRpXx5VHkgUD/7YeCJfMjU1wNgcGHNDP27V84G+CJW7OYhLRKel3BRtDqZlB2XmwjApZa/WG0m/DJxVEdI4btwp7a/b68ZaaY0Pox/Vp1DTyaNS7pvcdN5jOkxJBS2sNQFPvBDTUT/jIZcMZc8baxEY3FZKSGj/+Lx1NS8dQRusaDWAc01GOaCo5jrkdp5wOuI9/2wQp023RxjZ8Iymzq1xMslxN6UBVWuN4cqyiTGX/cSqgLJ2+02bcB69qck8FClXySkOIa7kRzs23ZeDdbdQq5z7NE9HzGStEnI7Q1BW/UdGQfp104bycZbLfhf9lbrP8Z+floTLZGNmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blN3ZmNSYm9OaVR5cnlySUdIOTREcU9NZGNPeEhrZFZKSEZjN2xSR2IyNVBK?=
 =?utf-8?B?bUhuSGlSVnpIM240NGMyWlYzZWdOYVhBaS83aExVSGJub0VML0ZFZUxidzFL?=
 =?utf-8?B?VitnczRoR0VaYUJtRVdQSHgwVTBIS3l2QVRXa2ZtT1V0SFRkMm0welhHSjlR?=
 =?utf-8?B?b2FpODlOTW1UUmx5NzVXS0x5M3pmZ1I0dy9RanNycWwzVWpsMUVtRFp4QUtI?=
 =?utf-8?B?QU5oN3hIbDVkNEl2cVFmQ0ZvR2gyR2NzT0Q4Qzhac1JJUmNtVFFtQ2lPNDIr?=
 =?utf-8?B?L1k4eEcwcGt2ZzVWMWRvQUhxdDNFNVhPNENEbk1jT3Z4SEMrUk91TEJtVmJL?=
 =?utf-8?B?MEs5eklTajcrZE5XY09QdjcxSFZnZThGUk16V0JEMXU3dHBISFFyYXVDVlJR?=
 =?utf-8?B?OG9mcUp6QTlQS1FNWjBLK1ZLL3JTVFBraG9tdUFRR0h4dFowTjhwOGZsRWtP?=
 =?utf-8?B?U2oyczVrdzFVRTd0QTQvOGgxUHB3YlFLV3lTbjBZdXcyNkxBeFBJZzV5RDJn?=
 =?utf-8?B?K3FzV2pNSVhjVVJmb21Rbm10UDBrd3R4OTJRR3BRa0grTkg4WmI4L2lyM3c0?=
 =?utf-8?B?dW1nby9iNUhXcFd4YWJQQmxWQ1F3MmY4YkNyMjJlMmI1bDRXMER1dU9NVGdR?=
 =?utf-8?B?bXlXSWpuZ0UyR3puSVpmeWZKMzN0Ukg4YTMxVXdzeVRLOGs4Ry9YQS9TU3Bj?=
 =?utf-8?B?dWZMeEdCUktZU1pEM09raUQvM3V5U0NnWXVueG9UcjJFMWdXVkZFQ3A1c050?=
 =?utf-8?B?ckdZekxHT25HOXJEd1k1MGt2OHdsNTdaZFVHVzZYMm1aSUhWN3ZYTmVwNlA2?=
 =?utf-8?B?K3d0RVlmNUZTMUlkWGgyKzlpTVdLSjJqck9aWGJXOUNyend4c0V2YlBwYTRW?=
 =?utf-8?B?M3BabGxENTFQNEloZE5mVDEzUXAwNFFLd29jZVB6N2ozNkpqOUVJOEwvajVQ?=
 =?utf-8?B?RHFZUTlDOWN1QTFqc0djczk4bWlHb0Q1ME03NW1hemtmSmRQNFNVZE9sTXJQ?=
 =?utf-8?B?UkRzZlZTR2dHUWFFM2xPRlJlRTNwY2NiVDZVejZpL3dnOTFKbDJqdkY2bFJW?=
 =?utf-8?B?SUtPZnYyMzl1QStZdVZCZmlwYjI3bnZVNHhnRTBzbldzYjFtNlZlVnd6emlG?=
 =?utf-8?B?U3BQeHM3YzJoREQzZ080aXlaZy9NWk1zKy9Mem5OVk9MT3ArUDVhYnZ3SWVC?=
 =?utf-8?B?OFJlYVpmNGp6aWxoaytpelZXOWxRamhVUjJSQVFOSVIvMlJ3Sk95Z3E4MjMv?=
 =?utf-8?B?Ump3ZHlSQ0Y3cTUydDFvNXRqT1ZHeUNJK3N2ck4xVktEYlJEbjQvNHJ3MnFZ?=
 =?utf-8?B?Vk1pczJrSlg2OTdMTVJWVWR3b1VENnJudjdYWHZBeWo5akFtcjRJbEJZMTg4?=
 =?utf-8?B?VmhNWFJNMzBNUVJ3cXBCLzNuRXBDaDdRamEzdVpLNGdDWGE4ZXRUa200ZVVB?=
 =?utf-8?B?R2QzdFpMbGplVFJvTW1sTlZidFZRYmh0aDNQT0pXdEl4ZFNsM0hJa3g3ZUFI?=
 =?utf-8?B?T3lTSldrOU8ySkpqbnZ5cE1QeTJZYXplRUtIRjBOWVRxMG1USnVzZmJZRC9k?=
 =?utf-8?B?aUJ6QkhRWUhYc1MrWllORHdXMnBVUG80SHA3T010d2pvdDJuclVMSERlYUM2?=
 =?utf-8?B?OFZ2QXR0SGVlaXBzUTRKWSt1WDM2ZTdVNW9zVEV6NEtKakdGbHovcmtGY1dt?=
 =?utf-8?B?Z2VaRkpBdlEwdUl5WWpHaE5pT2duWGVMTlZ6MGlqTXBCb05wVTdzVU1Ia3dS?=
 =?utf-8?B?SHZQYW9menNFem83N0FaeVlMTlZVNmNTdEpKbGxBRGZaSG15d2ZSV3VjaCtS?=
 =?utf-8?B?a0o0ZjZaLzhVblp6bk1pblNhNFBza0VzeWhCVjJlbVQ2aVgxNHlEU216RFJK?=
 =?utf-8?B?ZFF2QVZrSkRFNUFBR2ZmSG9IMTdwWk1FQ1B4a25CZzUrUjN5UDB4cU1IWjU5?=
 =?utf-8?B?SlUzQ2ZpSTFPd3lIbjdiUExnYW9rRjJ6YVJCalQySlhJZXZXRExIM0pwMzBn?=
 =?utf-8?B?MnkwQ0h6SFVlSDlHSkNWU3h6MjUrS2VjQmduVFE4VnRxUEZ2VTZhelRaVGtJ?=
 =?utf-8?B?MERQTmZNTUFzQUNJeGNlZmY5TW1tcXlhOHVHSzJHWlJTS1Z0QmI2SUZaQzgx?=
 =?utf-8?B?UGVtd082UzdyOUFCSzNWK2drdFlQeDNuaEZiSkZiMlpoS2F5WHBrRmRJc2RJ?=
 =?utf-8?B?UWFmVE05ZzRSVzRhZE8wVDlXREFQQzhoMFF1UWE2aEJndDQ5RnI1V3g5clRO?=
 =?utf-8?B?Q1FQUDA2RFBodnNEZ0ZibWZScVJQVnlrQTF2Yzd6S3o1TzJ4dTgxbEhTWUgz?=
 =?utf-8?Q?1/XQjuj+rLl2QAuSrz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34bfbfd-f530-40ef-c9b3-08df43a10565
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:18:17.2742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4lR5LJv7SEIOZ9dm3cZ6/aCp3Ku2964ZfGekYDMExtAP0tquQzn7xkH7I1Occiey7q2s5+jocL/HTMk0jC9/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

On 11/10/2026 10:46 PM, Kuehling, Felix wrote:

...

 >>> + * @checkpoint_ts: IH ring timestamp captured on unmap, used to drop
 >>> stale
 >>> + *                 faults.
 >>> + * @default_granularity: Default range granularity.
 >>> + * @xnack_enabled: Whether retry (XNACK) faults are enabled.
 >>> + * @invalidate_ranges: Callback of the MMU notifier invalidate event.
 >>> + */
 >>> +struct amdgpu_svm {
 >>> +    struct drm_gpusvm gpusvm;
 >>> +    struct kref refcount;
 >>> +    struct amdgpu_device *adev;
 >>> +    struct amdgpu_vm *vm;
 >>> +    struct amdgpu_svm_attr_tree *attr_tree;
 >>> +    struct rw_semaphore svm_lock;
 >>> +    spinlock_t work_lock;
 >>> +    struct amdgpu_svm_gc gc;
 >>> +    atomic_t exiting;
 >>> +    uint64_t checkpoint_ts;
 >> By now we have figured out that TS in faults are not useable for fault
 >> handling.
 >>
 >> Background is that they reset from time to time because of GFXOFF and
 >> may vary depending on the engine who sends the fault.
 >>
 >> Adding Timur from Valve on CC, he send out a patch to completely
 >> remove the existing timestamp handling from the fault filter.
 >>
 >> We need to come up with a different approach here.
 >
 > At least for the fault filter that shouldn't be a big problem. We don't
 > need the SW fault filter on any GPU that has a CAM. That should be any
 > GPU that supports retry faults starting with Vega20. AFAIK the only GPUs
 > that still need the SW fault filter are Vega10 and Raven. If the
 > timestamps work on those, we're fine. If there are any newer GPUs left
 > that don't enable the CAM for whatever reason, let's fix that instead.
 >
 > Regards,
 >    Felix

Hi Christian and Felix,

I totally remoed the ts check in amdgpu drm svm fault, following is 
diff, is that looks valid for you?

diff:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
index d95ac3651..15d8da7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.c
@@ -31,7 +31,6 @@
  #include "amdgpu.h"
  #include "amdgpu_vm.h"
  #include "amdgpu_gmc.h"
-#include "amdgpu_ih.h"
  #include "amdgpu_trace.h"

  #include <drm/drm_exec.h>
@@ -358,18 +357,16 @@ static int fault_map_range(struct amdgpu_svm *svm,
   * @adev: The amdgpu device.
   * @pasid: PASID of the faulting context.
   * @fault_page: Faulting page index.
- * @ts: IH ring timestamp of the fault.
   * @write_fault: True if the fault was caused by a write.
   *
   * Entry point from the VM fault path. Look up the SVM context, drop the
- * fault if the context is gone/exiting or the mm is dying, filter stale
- * retry faults using the checkpoint timestamp, then resolve the covering
+ * fault if the context is gone/exiting or the mm is dying, then 
resolve the covering
   * attribute range (creating a default one if needed) and map it.
   *
   * Return: 0 on success or a dropped fault, negative error code on 
failure.
   */
  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
-			    uint64_t fault_page, uint64_t ts,
+			    uint64_t fault_page,
  			    bool write_fault)
  {
  	struct amdgpu_svm *svm;
@@ -378,7 +375,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
*adev, uint32_t pasid,
  	unsigned long attr_start_page, attr_last_page;
  	uint64_t fault_addr = fault_page << PAGE_SHIFT;
  	struct mm_struct *mm = NULL;
-	uint64_t ckpt;
  	int ret;

  	if (amdgpu_in_reset(adev))
@@ -414,21 +410,6 @@ int amdgpu_svm_handle_fault(struct amdgpu_device 
*adev, uint32_t pasid,
  		goto out_put;
  	}

-	ckpt = READ_ONCE(svm->checkpoint_ts);
-	if (ckpt != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts, ckpt)) {
-			pr_debug(
-				"draining stale retry fault, drop fault 0x%llx ts=%llu 
checkpoint=%llu\n",
-				fault_addr, ts, ckpt);
-			amdgpu_gmc_filter_faults_remove(
-				adev, fault_page, pasid);
-			ret = 0;
-			goto out_put;
-		} else {
-			WRITE_ONCE(svm->checkpoint_ts, 0);
-		}
-	}
-
  	amdgpu_svm_lock(svm);

  	mutex_lock(&svm->attr_tree->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
index c169a9660..15c3915bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_fault.h
@@ -33,7 +33,7 @@ struct amdgpu_svm_attr_range;
  struct amdgpu_svm_attrs;

  int amdgpu_svm_handle_fault(struct amdgpu_device *adev, uint32_t pasid,
-			    uint64_t fault_page, uint64_t ts,
+			    uint64_t fault_page,
  			    bool write_fault);

  #endif /* __AMDGPU_SVM_FAULT_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
index 627b61c7e..f552725f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -758,39 +758,6 @@ void amdgpu_svm_range_unqueue(struct amdgpu_svm *svm,
  		drm_gpusvm_range_put(&range->base);
  }

-/**
- * amdgpu_svm_capture_checkpoint_ts() - Record the IH ring write 
pointer time
- * @svm: The SVM context.
- *
- * Capture the timestamp of the most recent interrupt handler write pointer
- * into @svm->checkpoint_ts. Retry faults whose timestamp predates this
- * checkpoint are stale and are dropped by the fault handler.
- */
-void amdgpu_svm_capture_checkpoint_ts(struct amdgpu_svm *svm)
-{
-	struct amdgpu_device *adev = svm->adev;
-	struct amdgpu_ih_ring *ih;
-	uint32_t checkpoint_wptr;
-
-	if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
-		ih = &adev->irq.ih1;
-		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-		if (ih->rptr != checkpoint_wptr) {
-			WRITE_ONCE(svm->checkpoint_ts,
-				   amdgpu_ih_decode_iv_ts(adev, ih,
-							  checkpoint_wptr, -1));
-			return;
-		}
-	}
-
-	ih = &adev->irq.ih_soft;
-	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
-	if (ih->rptr != checkpoint_wptr)
-		WRITE_ONCE(svm->checkpoint_ts,
-			   amdgpu_ih_decode_iv_ts(adev, ih,
-						  checkpoint_wptr, -1));
-}
-
  /**
   * amdgpu_svm_range_invalidate() - MMU notifier invalidate_ranges callback
   * @svm: The SVM context.
@@ -802,8 +769,7 @@ void amdgpu_svm_capture_checkpoint_ts(struct 
amdgpu_svm *svm)
   *
   * Dispatch the two phase notifier handling across every range in
   * [@adj_start, @adj_end): run the begin phase for all ranges, then
- * the end phase. On an unmap event, also capture a checkpoint timestamp
- * so stale retry faults can be filtered.
+ * the end phase.
   */
  void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
  				 struct drm_gpusvm_notifier *notifier,
@@ -814,9 +780,6 @@ void amdgpu_svm_range_invalidate(struct amdgpu_svm *svm,
  	struct drm_gpusvm_range *r;
  	bool needs_flush = false;

-	if (mmu_range->event == MMU_NOTIFY_UNMAP)
-		amdgpu_svm_capture_checkpoint_ts(svm);
-
  	r = first;
  	drm_gpusvm_for_each_range(r, notifier, adj_start, adj_end)
  		needs_flush |= amdgpu_svm_range_notifier_event_begin(svm, r,

Regards,
Honglei

 >
 >
 >>
 >>> +    u8 default_granularity;
 >>> +    bool xnack_enabled;
 >> It's probably ok to have that here for now, but that will become a VM
 >> property in the future I think.
 >>
 >>> +    void (*invalidate_ranges)(struct amdgpu_svm *svm,
 >>> +                  struct drm_gpusvm_notifier *notifier,
 >>> +                  const struct mmu_notifier_range *mmu_range,
 >>> +                  struct drm_gpusvm_range *first,
 >>> +                  uint64_t adj_start, uint64_t adj_end);
 >> That looks a bit questionable. Why is that a pointer inside the
 >> amdgpu_svm structure?
 >>
 >> Apart from those questions that looks rather reasonable.
 >>
 >> Regards,
 >> Christian.
...

