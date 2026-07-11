Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42258C44501
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B73C10E32B;
	Sat, 11 Jul 2026 10:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NuqZM2I";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40B010E329;
 Sat, 11 Jul 2026 10:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRU2VEqxpyTjGyJaOCvRXeI0/SlwLnRDk9ZzfkTam0Qp7+0/PHxD/7FPG1TWjT5HRVY/PQ1NpmSXMipOKMuyuhARFqAF/f77WEpf8pHPI2/Srbr0dpM9Yg8iD1rHgEi2T8ITOLe5jFOyCMswd5xzSt/yLGloSNGQsFtQhJv/uCsns2kMhvb/qYNclQkPeWc8u9p6dlLLm0O6giHgiBNX89XZz84KWa8hRnvLwG+TkRvqN0xfBZg+ly9AgSFZnlhAMsWk8haCOa+yBCMvgOdBJtkuh6pBaZmMap3ldZ5H8nuzo5gS0caZ6Foe4ompOZXAUoLMPwJaDFnypXQQJMf6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTkH6g6DIa3/40jSyTDdXePHAplKS5jq00Q7iH1xUyY=;
 b=N35hmfOcGg66ocOvOAMZM8GdBMuyt/7x/6ToEXrlG56Mqr8J5cI9RYuMwg7XZ+yNnqcfvuhzIkbyDSbGgLxpZk/3410T9FuHw3ib2ZTdF24g94vTY20RNc4jfE7OxwKu4G3zY8VE9fpJUb2oIBYxiLkctXoVZJcXd7JLAWWiexGQBCQrXbO6i16fFfiZaYDMjb0zwOIiI0mJS5KAzFKbiEyc0CzZBaOyS0z4qY+MAGRsHmCFfGalHuvcaCXxaO9sMOGdbbRGrVXk19nJnF4QbZxRGbLtpVRBxqdn75tw1dDyn1sPf5VgAeUONGIeVs9zNJPW3eERGBb2nqRvq/dKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTkH6g6DIa3/40jSyTDdXePHAplKS5jq00Q7iH1xUyY=;
 b=3NuqZM2I1I3Ec4HNlKPfaJ7xMnJUtBP+FEzA9kqITaKxZvU7S0rLkSGRh64qpLvXi7obPuz3AqEW7Br/jged38b6XdGk+Y73uEXo0M0j1ITl7uOpjbSiwtqO/5KsHhDj/TOlcgeV/GRaikT0v/z9nmdXX+qZOf4oaxishQumchw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 10:46:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 10:46:45 +0000
Message-ID: <13b16ffb-f9aa-4b83-a1cc-1b9ac8475c5f@amd.com>
Date: Sat, 11 Jul 2026 12:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/33] drm/amdgpu: Preallocate system BO pages outside
 the reservation lock
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-34-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260711025619.2540575-34-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: b55ff0cc-7ea3-4e36-12e9-08dedf39b37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rQzDGCPN8Q95Hw5WtmNzh7RC9Lzo0qxKpzYcUm5/VRLAYQgj8WGgPITgKypnlUWAD3zI1TW6fJrvRIl5vUUucsr91RB1tY3oG4fXEGYyhoFu/sQrQFmKC0q30rVBBd4kAdjqL8Bk088aiGIjIdwLu6aiEUVVj0WhhJzxEfTaKNU8ZmCRVvsQT7nTOmK12WDPSkqm2XMK4gldOPYd/D36jGqvmumnZ9b2VCooT+/e/u2ittWDFP42GQZa7k5LKlqzOBdY6JUEnGojiU6L0721GXvnvCwHce+CtQZiyydDTicFMM5FE5fxrcgoU8ujNXWxP2kHv7c1lPqz0B3Fumuugv7y1rj3yZ2SF+nal3+7lE4mghne94WhDGS+tSircFUTYk1QUeoz0L57AaNUbbsZkwaDiJUK+/LOMpjOqI2VE9iTSzXXfwaobDNfAwQq3423fYig3EQ5nZkMLbKbulk1oaXzolrdDpBorsxhpaBDO9GC2fjLbUwRkDoASw/XcTWewLPpv1Gq3NS9XGJgVZgm2rFoNGvUSguGZ8Fs3pdiBdoGsYTW8EmiKr+OxoVTDfiQV/Ps97zxYqssZR16/JJbxY60jRki1HyWQ4xNmm0mBR0AUMxjoMvXTo79vqDv00cX5M0+kF9+aVk20A5RPqALvgLMLlGt5kTjWgtrMRYOZvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5hRTFrQzE5cDAzN3lKY0xmam95Vy9ZKzVyTHRwTWFoVHpHNlRjMDlEdjBP?=
 =?utf-8?B?b05aN1RycnRBNjR3UWcrUWR6UGptTm9OWkdXeng1bzZmTHU2UElUU3pVNkw1?=
 =?utf-8?B?TXE4c1FJZDJMQ2ZENDYvRHVsQnhJSDdqTUlZOEdzZ3lBUWFTbjJPZXdtby9h?=
 =?utf-8?B?K3dtZGdZTWY5QXBUeTRUa0gvMWhuK0tFU055OXl5WHlRNEJ2SWtWN2VFV1pI?=
 =?utf-8?B?WEt3L3dkeUVidllvZkJBdFk1UWdiMTZ4NjkxbjVaMjhISnZrR3lEZ1BPWFpo?=
 =?utf-8?B?TG1oU1VFOWZ1eTduSXBOTWJUVlBoeDkyc243bUZOR1ZHV2RJYk5OSkYrTDVE?=
 =?utf-8?B?TVA2Tm9ySWVSV00wanVGV3p1b0MzNjVXN3l5Y1d3bkJQN0FnUlh3RzJXUEV3?=
 =?utf-8?B?WDVJSnJlVnhoOWFlanVrN1NaKzFBei95NmsyaWpTWUl1d2hBRWFGTkF3Z1VZ?=
 =?utf-8?B?YU1pMVFRRmRsUlloTFJ2NEJtZ0txVncrQWRRN1VGRDNLNXBhU0FGd0t5QmEr?=
 =?utf-8?B?WnRlcnpsVEZJcUJaRjdVSUZscEgzMWZ1Q2theXBkUTVLTDZpcDU2emx0RW8w?=
 =?utf-8?B?cU96Q1h1RnpaSEpDVWY5dEdmUmtyMGdBTlJaRjJvdThLb3FOZlF4Y3JyelNl?=
 =?utf-8?B?SWVybDdrZVBtMlVKMFNkVGJvT0VDMzhiRC93WVZjYlZ6ZzN5d2JlNFU0UlZC?=
 =?utf-8?B?eWVwVGVXeTVYMnEvNzN6SXZHd0dQbzViRlFzWG9uZ1pncUdmZk50WFdWYUZD?=
 =?utf-8?B?L1hyOGZseWM5WDh4M29pOEZQLzVFZVRyNExWUTgvSnJvelp4N25HeWxkaEdT?=
 =?utf-8?B?N3R5Ynd0Tm4rQnNzQTVPSWVxS0pxL1RQM1ZsQlNUUmV1a0NMejYrYlZPRkZx?=
 =?utf-8?B?MWtaZkxPS0hMWHFzZHNNK1RWcG9zTWlYb1c0UU5waWdYTHM3Y3BVQ1B1c0tn?=
 =?utf-8?B?Y0kva1poV3p1Rnd2eTYrWXZDUmJ6MVFtbnpSZHZkdkdSSFlsZnh5bHBvdmNo?=
 =?utf-8?B?OUpZSDh5d3RuSHpYRVROeDlBRWhrd2svQUY5NDhVQ0g3MGZlOWhQZUtxbDdY?=
 =?utf-8?B?UzNXbzJzMWdvU0o1UmJqaDhRdzh1Z3VrSEZyMnVPRUFKbGl5aGg1WDdBSGlS?=
 =?utf-8?B?dXgrUkpJMnNuaGE4Q3g1N1p4WEE1QkIxc2hpdk8vRlh6TlYvbW1ub25jQUZM?=
 =?utf-8?B?WmdIUFRSU2ZNb1l2akR6UWRGcmlTNlJvNi9vRDgyQ1oxcXk0bHpORmZ6WnhN?=
 =?utf-8?B?QXl3d2U0OWFWc0x1V2toSG5ZcFkyRmxNNWVLQTE0em56dTFpMDNRZHI3ZFlI?=
 =?utf-8?B?YjYrTEh2SFBzOWJMS1hzTDF5QU1PSHA2SGhKaU1wYXpWaVJsUTI1ZXVZZ2No?=
 =?utf-8?B?OWcxam15S0hqaGVDbTJxQU5jYy9WbTcwYVQzdC9SZEtGbGJyUEJGM2tOQUxq?=
 =?utf-8?B?UUZtZk1TOUtidk5NL2w4NXNlVE9SYSsvSTBtbjU3MGl5T0pUUW5temYzUTgy?=
 =?utf-8?B?TFVLZGQ3V2VBZDRhS2RLeE95STlnb0RhZWVPNklJc05mN1lvQjhqV1lFN01X?=
 =?utf-8?B?ejRjWFNKS1pKL1pxNGgxUitCUlBkRFY1aCtaVytlRW5iOUxDZ09qWld6ZFhP?=
 =?utf-8?B?M1lEOXRMVnEwNmJ2bndCRkFuTFptRlZ6NzdQdE1Oak5OUnd3bW9LOVAwZDVD?=
 =?utf-8?B?YkNzWHR1RkhJWVFqRE5mM3Y5Mjg0ZHVGanJCVUR3SHkyOXhTMktNSzZnV3py?=
 =?utf-8?B?MXcrU1YvbVRiK1liWC9tdjYrR1d3OUFPSUpScVdRMS81c2FRNlJqY0xjUW14?=
 =?utf-8?B?SkRDRmtxOWNtOUJuNjR4REVLVkQySjAxdEk0OTNBZ2NVWWoyWVdoMzhZdmpF?=
 =?utf-8?B?VEtVbFVWR0lUbVg3REtZcC81SHVlaFpjb1RyaU8xQTQrTzVSa214OW1rbWxM?=
 =?utf-8?B?MlQwaGNMQmZCaE44ay91TzlSUFRVcldGanRyVHdzRS9IdlVtQXJQb3liOFNV?=
 =?utf-8?B?eWFNcGI5K01KdVJseEFUc01tSWx0akowSndzd3I5RmlmRlpWRnNsL2xGVWU2?=
 =?utf-8?B?QS9MYWpKODB5OGx2V1V1Q3pvLy9BSVNhT2JPT1hzUkR6TENGaFloRWtYTzFZ?=
 =?utf-8?B?TFlxSHh1RU9paFpUb3h5QXNScDNMQk9DRjhjUlZJelhRNXI2Tzh3MGpramsw?=
 =?utf-8?B?TG5MbzB2akRPMlBCM0UxV0FWYk9NZy9keUgxOXVQS1FjZldYYkdpbFJUc3Z4?=
 =?utf-8?B?Und6QTY1Sy92TW40Y3dUSkR5dnhsS21mSzE3WDFpcjVxb09OYnhYMXhKanVD?=
 =?utf-8?Q?sjkcu5QoSkC3I4y1+3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55ff0cc-7ea3-4e36-12e9-08dedf39b37b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 10:46:45.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szCkxKd6+9rxHGTwwhcN6T5NR7Xiea83qcYzEVWp2Zu8e8K/0T0BZi8PVHG+KsVE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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

On 7/11/26 04:56, Matthew Brost wrote:
> Populating a GTT (system) buffer object under the reservation lock can
> stall in reclaim and compaction while trying to satisfy beneficial-order
> allocations, holding the lock for the duration.

Yeah and that is perfectly intentional behavior.

I really don't see any reason for any driver to change that.

The purpose of the dma_resv lock is to stall other allocation for the same object it protects, making sure that we don't have multiple threads allocating memory for the same buffer object.

Why in the world should that be a problem?

Regards,
Christian.

> 
> Mirror the Xe out-of-lock preallocation for pure system BOs: when a
> gem_create request targets AMDGPU_GEM_DOMAIN_GTT only, fill the full page
> backing up front via ttm_pool_prealloc_fill_full() before taking the
> reservation lock. The populate under the lock then simply installs these
> pages instead of reclaiming and compacting in the critical section. The
> fill is best-effort - a short fill falls back to the normal in-lock
> allocation for the remaining pages, and any leftover pages are released
> by ttm_pool_prealloc_fini() on all exit paths.
> 
> Unlike Xe, amdgpu has no background defragmenter, so the higher-order
> reclaim backoff is left disabled (normal reclaim). If the pool uses
> dma-alloc (swiotlb), the fill bails and the feature is a silent no-op.
> 
> Factor the tt pool selection into amdgpu_ttm_tt_pool_id() and
> amdgpu_ttm_pool() so the preallocation targets the exact pool the
> populate will consume, and thread an optional prealloc bag through
> amdgpu_gem_object_create() and amdgpu_bo_param into the populate ctx.
> 
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> 
> v3:
>  - Keep WC caching only when USWC is supported and bound the
>    preallocation to available GTT space (Sashiko)
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 73 +++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 39 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +
>  8 files changed, 108 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 20831dbebc31..940f58848a97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -345,7 +345,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
>  
>  	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
>  			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
> -			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
> +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0, NULL);
>  
>  	amdgpu_bo_unreserve(mem->bo);
>  
> @@ -1811,7 +1811,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>  		 domain_string(alloc_domain), xcp_id);
>  
>  	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
> -				       bo_type, NULL, &gobj, xcp_id + 1);
> +				       bo_type, NULL, &gobj, xcp_id + 1, NULL);
>  	if (ret) {
>  		pr_debug("Failed to create BO on domain %s. ret %d\n",
>  			 domain_string(alloc_domain), ret);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2..51510e831129 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -435,7 +435,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>  
>  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
>  				       AMDGPU_GEM_DOMAIN_CPU, flags,
> -				       ttm_bo_type_sg, resv, &gobj, 0);
> +				       ttm_bo_type_sg, resv, &gobj, 0, NULL);
>  	if (ret)
>  		goto error;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbc..e8b732218e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -39,6 +39,7 @@
>  #include <drm/drm_exec.h>
>  #include <drm/drm_gem_ttm_helper.h>
>  #include <drm/ttm/ttm_tt.h>
> +#include <drm/ttm/ttm_pool.h>
>  #include <drm/drm_syncobj.h>
>  
>  #include "amdgpu.h"
> @@ -168,7 +169,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>  			     int alignment, u32 initial_domain,
>  			     u64 flags, enum ttm_bo_type type,
>  			     struct dma_resv *resv,
> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> +			     struct ttm_pool_prealloc *prealloc)
>  {
>  	struct amdgpu_bo *bo;
>  	struct amdgpu_bo_user *ubo;
> @@ -188,6 +190,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>  	bp.domain = initial_domain;
>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>  	bp.xcp_id_plus1 = xcp_id_plus1;
> +	bp.prealloc = prealloc;
>  
>  	r = amdgpu_bo_create_user(adev, &bp, &ubo);
>  	if (r)
> @@ -412,6 +415,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	struct dma_resv *resv = NULL;
>  	struct drm_gem_object *gobj;
>  	uint32_t handle, initial_domain;
> +	struct ttm_pool_prealloc prealloc = {};
> +	struct ttm_pool *prealloc_pool = NULL;
>  	int r;
>  
>  	/* reject invalid gem flags */
> @@ -443,10 +448,57 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>  	}
>  
> +	/*
> +	 * For system-only (pure GTT) BOs, preallocate the whole page backing
> +	 * up front, outside the reservation lock. Populate under the lock then
> +	 * just installs these pages instead of reclaiming/compacting in the
> +	 * critical section. Best-effort: a short fill falls back to the normal
> +	 * in-lock allocation for the missing pages.
> +	 */
> +	if (args->in.domains == AMDGPU_GEM_DOMAIN_GTT) {
> +		struct ttm_resource_manager *gtt_man =
> +			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +		int32_t xcp_id = adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
> +		int32_t pool_id = amdgpu_ttm_tt_pool_id(adev, xcp_id);
> +		/*
> +		 * Mirror the USWC handling in amdgpu_bo_create(): the flag is
> +		 * stripped when the platform can't do write-combining, in which
> +		 * case the tt is created ttm_cached. The prealloc caching must
> +		 * match the final tt caching exactly, otherwise ttm_pool_free()
> +		 * would restore the wrong PAT state on these pages (PAT aliasing
> +		 * / leak of WC pages into the cached allocator).
> +		 */
> +		bool uswc = (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
> +			amdgpu_bo_support_uswc(flags);
> +		enum ttm_caching caching =
> +			uswc ? ttm_write_combined : ttm_cached;
> +
> +		/*
> +		 * Only prealloc when the request fits the currently-available
> +		 * GTT (total manager size minus current usage). This mirrors the
> +		 * amdgpu_bo_validate_size() bound applied later in
> +		 * amdgpu_bo_create() while also skipping the up-front reclaim /
> +		 * compaction when GTT is already near full or the user-controlled
> +		 * size is over-large (the creation path handles those anyway).
> +		 */
> +		if (gtt_man) {
> +			u64 used = ttm_resource_manager_usage(gtt_man);
> +			u64 avail = gtt_man->size > used ?
> +				gtt_man->size - used : 0;
> +
> +			if (size <= avail) {
> +				prealloc_pool = amdgpu_ttm_pool(adev, pool_id);
> +				ttm_pool_prealloc_fill_full(prealloc_pool,
> +							    caching, &prealloc,
> +							    PFN_UP(size), false);
> +			}
> +		}
> +	}
> +
>  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>  		r = amdgpu_bo_reserve(vm->root.bo, false);
>  		if (r)
> -			return r;
> +			goto out_prealloc;
>  
>  		resv = vm->root.bo->tbo.base.resv;
>  	}
> @@ -455,7 +507,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  retry:
>  	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>  				     initial_domain,
> -				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
> +				     flags, ttm_bo_type_device, resv, &gobj,
> +				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);
>  	if (r && r != -ERESTARTSYS) {
>  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
>  			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> @@ -479,17 +532,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_unreserve(vm->root.bo);
>  	}
>  	if (r)
> -		return r;
> +		goto out_prealloc;
>  
>  	r = drm_gem_handle_create(filp, gobj, &handle);
>  	/* drop reference from allocate - handle holds it now */
>  	drm_gem_object_put(gobj);
>  	if (r)
> -		return r;
> +		goto out_prealloc;
>  
>  	memset(args, 0, sizeof(*args));
>  	args->out.handle = handle;
> -	return 0;
> +
> +out_prealloc:
> +	if (prealloc_pool)
> +		ttm_pool_prealloc_fini(prealloc_pool, &prealloc);
> +	return r;
>  }
>  
>  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> @@ -528,7 +585,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  
>  	/* create a gem object to contain this object in */
>  	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
> -				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> +				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
>  	if (r)
>  		return r;
>  
> @@ -1298,7 +1355,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>  	domain = amdgpu_bo_get_preferred_domain(adev,
>  				amdgpu_display_supported_domains(adev, flags));
>  	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
> -				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> +				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
>  	if (r)
>  		return -ENOMEM;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b558336bc4c6..706aeca011f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -35,6 +35,8 @@
>  
>  extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
>  
> +struct ttm_pool_prealloc;
> +
>  unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
>  
>  /*
> @@ -45,7 +47,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>  			     int alignment, u32 initial_domain,
>  			     u64 flags, enum ttm_bo_type type,
>  			     struct dma_resv *resv,
> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> +			     struct ttm_pool_prealloc *prealloc);
>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>  			    struct drm_device *dev,
>  			    struct drm_mode_create_dumb *args);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index f98bfba59a2c..18c4cf3f35a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -632,7 +632,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  		/* We opt to avoid OOM on system pages allocations */
>  		.gfp_retry_mayfail = true,
>  		.allow_res_evict = bp->type != ttm_bo_type_kernel,
> -		.resv = bp->resv
> +		.resv = bp->resv,
> +		.prealloc = bp->prealloc,
>  	};
>  	struct amdgpu_bo *bo;
>  	unsigned long page_align, size = bp->size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index ff11a0903499..11f1d403f152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -45,6 +45,8 @@
>  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
>  #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
>  
> +struct ttm_pool_prealloc;
> +
>  struct amdgpu_bo_param {
>  	unsigned long			size;
>  	int				byte_align;
> @@ -58,6 +60,8 @@ struct amdgpu_bo_param {
>  	void				(*destroy)(struct ttm_buffer_object *bo);
>  	/* xcp partition number plus 1, 0 means any partition */
>  	int8_t				xcp_id_plus1;
> +	/* optional out-of-lock preallocated backing (system/GTT only) */
> +	struct ttm_pool_prealloc	*prealloc;
>  };
>  
>  /* bo virtual addresses in a vm */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b10b0878df37..c9cd4714f515 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1173,6 +1173,30 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
>  	kfree(sgt);
>  }
>  
> +/*
> + * amdgpu_ttm_tt_pool_id - compute the ttm pool id backing a given xcp
> + *
> + * Mirrors the mapping used when creating the gtt ttm_tt, so callers that only
> + * have an xcp id (e.g. an out-of-lock preallocation before the bo exists) pick
> + * the same pool the populate will use.
> + */
> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id)
> +{
> +	if (adev->gmc.mem_partitions && xcp_id >= 0)
> +		return KFD_XCP_MEM_ID(adev, xcp_id);
> +
> +	return xcp_id;
> +}
> +
> +/* amdgpu_ttm_pool - select the ttm pool for a given pool id */
> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id)
> +{
> +	if (adev->mman.ttm_pools && pool_id >= 0)
> +		return &adev->mman.ttm_pools[pool_id];
> +
> +	return &adev->mman.bdev.pool;
> +}
> +
>  /**
>   * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
>   *
> @@ -1194,10 +1218,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>  		return NULL;
>  
>  	gtt->gobj = &bo->base;
> -	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
> -		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
> -	else
> -		gtt->pool_id = abo->xcp_id;
> +	gtt->pool_id = amdgpu_ttm_tt_pool_id(adev, abo->xcp_id);
>  
>  	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
>  		caching = ttm_write_combined;
> @@ -1239,10 +1260,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
>  	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
>  		return 0;
>  
> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> -	else
> -		pool = &adev->mman.bdev.pool;
> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
>  	ret = ttm_pool_alloc(pool, ttm, ctx);
>  	if (ret)
>  		return ret;
> @@ -1284,10 +1302,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
>  
>  	adev = amdgpu_ttm_adev(bdev);
>  
> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> -	else
> -		pool = &adev->mman.bdev.pool;
> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
>  
>  	return ttm_pool_free(pool, ttm);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ff9e2e346609..f90844937b73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -207,6 +207,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id);
> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id);
> +
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct amdgpu_hmm_range *range);

