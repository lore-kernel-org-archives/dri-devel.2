Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989A606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qysYJrak
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 928B810F261;
	Mon,  9 Nov 2026 12:42:03 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AEBF10E44C;
 Mon,  9 Nov 2026 12:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji4hCJL9mJD7re0M7e2MC4AYPTzChXepnpTUXjrUIppanbBwNBWPweE2yI78xf1Npox2+6PBU4xplpvhHnRs3D9UwQp2u0Qt29Dut2/4NqTaaeJ3bkPHprLkjJeN8M/pMFr5Q9+ahVzdHbNIqr05Lo2AcTUVRHHGoCihFLk5rPOrLDcqkV4nK3n6j6WLTn6I4nEXGJfeR8mb8jgt+926O8V4OFGEv2Z8uG4gOWoBWy3kumcVudH9PMmgp7pFhnkx8Z54C0pcx5fXIEv7aCRqm6cUGp5Zjl7734AG/dnQpVcJZwP1LiggjF09MMoquhpv+wyxS2Q1ZUSzvrpZ6UzVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o23p/SiIISOwoTPKJXMJoj9fWYj5r77JAcAhNm1SNL0=;
 b=sm3cvP65Io7j+tBHSvwScz5H0C1mH/+lzBYtXG9IDglaiNzW8AuR/tzuf+RanCbtg8UiWonrsHRo8ddhhN6zMEajzBkzRU1yPjNo0Q0fcV6JjNz87Lw9fmhCWD9Ss0p1nkKmNUoJl+BJMcC9i/2NUm3Vw2Z7DzSGLUGkc/8yBITyRKIEDMuCmAwq1Mgwh9G/tM5hPRCUXvApCrMTb8nLeMYA5zxRbAJ7XeLDZhkrGbokUV5IhrK0Br+WYArPlmY4A4BZ2cpZ8KQwsLzd8/P5u/WE5CL/fW8pILzxMvxl5sxyCI8TxDc/SnFfheVCOSIdOi2aHG1nah0yHcA8BbvKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o23p/SiIISOwoTPKJXMJoj9fWYj5r77JAcAhNm1SNL0=;
 b=qysYJrakJoMVSp91yq0mEyCTZ6syr/l286nQygdeUOVQW8d8OmihNUa5BasAt7AKOZSSK2d99A3cyAl8/SC9oHgvi+bpjTwDR6PjsasxGVtjbs2oLEllYyCtFVrNyTf2+2l5+TYMeRSw8Nu+6f/5RcdB9k/MeIg8nX8BsjLYo00=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:41:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:41:54 +0000
Message-ID: <d6275052-1715-4066-9291-4f4cce9c017a@amd.com>
Date: Mon, 9 Nov 2026 13:41:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/22] drm/amdgpu: implement SVM attribute tree and
 helper functions
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>,
 Aveline Noir <jm5905938@gmail.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-4-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-4-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a035f6-4d13-4eb4-e80c-08df3e5ed5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|5023799004|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: sSX+I9tdG7bMiKwKH+QXfA86nReJI9hoPfu1LKOJ5Gia03kmQzFYXuSJ1t+OjB910Jke5wTmnVQ6F7o1aRkpEHTZEcv/eN9RQylXFiYNJKbOEG6Hxcz60HNuATNzMhmFy48uqpE5dUrVloLrisPNc7QCRpDw0O2tq5ekLnywIMsJwW0f/kgRckrS6gADmpIQHHMOBTAZLTRmW9lTSG0zcN7dz0Rc7+gl4d+blwjcoARiYhgt3AzDzg1FMo0UD+shXJUKMtEON4P4/BqF5Gyaan1jl6xhcnzhTJ1FFOR2LGHuukJIjCyUbVe/lgbK71HU0RG3eII+/AI+2bS6UUagleqW1oMTNnijdUyUBhC1XTVXjlxmDIe2WZWJitrxXH3b2fO0MrKXqBRtaBj23dSpfWwXzuzvyIFsnhJ9jVy50mbecupzLh3lJ8HgzPAhV9ewNP9GtJRLpW8zNH0tuAAeTqKKrZalRkB5uJA8yBO/KZ0aPmlSnltAC8468ZnWeGEiGI1B4zraMYUBh/s4Y2m4oxcFP7e29BkqoWsoqjb9062Qd1rf26OMu+XOrNnAf6DCDmrUP57WI7M8ZpZOPvl/pRIKzCtertFo0IhkezVNYJHV857lq8Xf3IXfYSvbCElPokEYL4uqmhKz845ruRgTItG/K0Y7kDYOjG8ZRjSJALul2kF1ku2gRMfxeGhCyfu0Q8GEQCKQsd8FJZmI1pI6pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVaeHNmTjluVHFrYWljZFNqNWM4SVFlNUE4ajQyMXR1TDZMV2w1QlBEUXJQ?=
 =?utf-8?B?R2ZuL0Vyc1Iyb2ZtVnM3UFlzL2JUWGVZNHJBUkluWjRGRkFMMGxtdDhYeUxR?=
 =?utf-8?B?UVhQYjlYU1dQVXZlTmVoaFk1bVFqMlRxbFk3andycGZBVE9RK1JhWFFlZmRK?=
 =?utf-8?B?bXZnRUlnajZueU0rbmQ5ZXN1OEFKVmw1WDJCaXZRMjFhQkpjZy9GOGpFWVNL?=
 =?utf-8?B?OS82ZkVSeGo1K21YTjVOSW8wa0hvd21tWG1KRyt5dnRrRDY4UlJVd3YyUUpx?=
 =?utf-8?B?SlNubUVlcUFJWFZZa3BOOVRsRzRFQ215em5GdjRwMlNOZ1NVZlN6dEM3WGVM?=
 =?utf-8?B?NFY1bHZ0dUpoYTRuc2p0eERVRXpUeStneGZweDdtb28zOTFrS3ZPODdGM1NY?=
 =?utf-8?B?N09tcXhIblpramxjR0JlQ0ZPWmRLN0FFNnZLZExXNzhpam5BL01Ya2hhc205?=
 =?utf-8?B?Rk5rdUxDbDd0Z0lhcVBJK2htK0l0UGdsUHNDdWFFeC9ObEJoUjljbit6Vmpi?=
 =?utf-8?B?aFh1czhsN0NwWENiamhSUDNwZFlnbFY1amtUZ0NzODdrZVA3M3BPR2ZkQ3p3?=
 =?utf-8?B?SFl3VFQvZExsUUZBTTJiTGZjN05EbVkzclhnZ3k5ZjNvN2ZRU1lsY1ZsT0hB?=
 =?utf-8?B?dnZCakd4Z0l0NmdFZHVDa1ZJY1hhUEtjU0R5RnV2cTRCbnV5VklWZGRIVk1v?=
 =?utf-8?B?bndXKzFwWWFiQldSak5PMVBmT1RqalBodFNseHpSZVFldnozT3R3bWY0SXhH?=
 =?utf-8?B?d3VkWGcwREFXQ2YzcHp0Vys2UUFxN2dVQlJ2eDJ4NjJQUXMwU3RUd2xJSUFp?=
 =?utf-8?B?REFsV3VBdDRZWWpRenY0cFlmR21uL2kzUURrUkJKYWlYSGw1amZhdG1Ybm1p?=
 =?utf-8?B?bGo0eHl2VlpEdVVYYmhJb2FLeGhRQzVBekE4aXJPcXRDRGxYUSswYjMyam0z?=
 =?utf-8?B?UXBLRGtXWmJuU2pTaUY4c1VCZ1ptWDE1SEd2YWxmZ1VnaGZoMzQzRzVUV3oz?=
 =?utf-8?B?blkyMWhTbyt2VE1IWk9ZNWk5YjJHNVNxVjN5MjI1QVI1WURnaFcyY3M3YzJP?=
 =?utf-8?B?UDdKdUIzYkF2VW9vN0MycnVUc1JuZGRLdnB0Wmt0eVlwa2RHZjl3R21hcnNU?=
 =?utf-8?B?WlJwUjBQV1lTVzMrazhyNHRyL2t0WUl4YW5VVXRYeFlLaGxXZDJmZzRIK0Na?=
 =?utf-8?B?Y1A2WnNlaHNzVzFjaW15MThYK2oyU2lDRm9BdHY2ckN0Uy8vL1Q1MWZSRGtE?=
 =?utf-8?B?Y2lnS3NBTFNtUWkrY0hwT0IvTENzZ3JvOWxkYU9ZSmJpMDN1QktkS1pBUVdW?=
 =?utf-8?B?c0tnNFBMMENDdWtIcG1UOU13bFFMUHBRZjN0amRCQnpHV2NKbmVYYXcxNW10?=
 =?utf-8?B?SXF6Mk04NDFGOGVNNVk5MHZmRDQyakErZEgvVTNaMGx3VVVVczFsMFdRSDB2?=
 =?utf-8?B?RW5xQllyZGRZdFlrYlNSSnhDVWpuajBmQ204aDJaY2NoTHR4cFMzQnNwYktW?=
 =?utf-8?B?VksyMjZ6QVc3YStURFp6Q1dDMVBBS1dWOTlNbDYydG9nV2dLY2tOZWk3N3V0?=
 =?utf-8?B?NWl4RzhDeVMwWGdKUWs5OXdmT0JDUHR5VWxIR2pCUWltSEY4V3UrWWltU1V6?=
 =?utf-8?B?b04yQWtoSlZTWlBhTGsvcTZZRTlPSm1NWE0wa0ZaSmR0SE1KNVBVdmQzamg3?=
 =?utf-8?B?WW9XNHp2a2xNNk9GTU9wZ1FrSmZpaUlLU2pIWVlUSzBNL25qWjJRanBVU1l4?=
 =?utf-8?B?UC95bGtjQi9SVk9RVDY0RGRCRnpXSWFTN1E4UXp3ZjN1VENmODBUUFVqN2Rz?=
 =?utf-8?B?Mm1tdk1LZzBDd1YrZUVLNE9MazF2L2Y1U3RxZTN1cHRnUVMyeUlVUnpjQ3Ri?=
 =?utf-8?B?K0FMazJOWUkwNmJsQTV1S0dyWHVDOFlSZXF3RnppNmtiZ1BBNUlqVm5IY0Fl?=
 =?utf-8?B?TFN2L3dlSGFzYjJNUU1wN2lRWG1zTnlpSEFkVzByQzFFZGszVk9NeE1nYmh6?=
 =?utf-8?B?elM2V04xUkxtRHdoQVhIdm50M0wwUmVTalB3SkNHVjU5Ky9GK1BVdGEvb1BQ?=
 =?utf-8?B?VExFeGdWalBNSGJ6dEFUMjllSkszOXQwWWhQTlAzcS9LN0RER0R4TlVsUFVl?=
 =?utf-8?B?RUt6SnY2T1R5SWExNi9aQ3E1dktHNGlPekFmSXpjZ3N6ZjlBMzVpOFNzZDlp?=
 =?utf-8?B?dCtRaU83WU1wODg2RHg3QkQrdTA1dFA4ejErd2ZpcDlZdjl6SmlaVjR5SWMv?=
 =?utf-8?B?VTVnTFZZczNyaG1nZVV1S0MxcWF0blZ0OHNzajgrcVJzY3Y1WlNaMkRPRTNz?=
 =?utf-8?Q?Eg8uCdQLlNsQ4OfL3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a035f6-4d13-4eb4-e80c-08df3e5ed5a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:41:54.3818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3+l3IeOkHEfXBkvJus2IS1gTGPTUDKZ2/6gbMiTJOgFhBtCQhHNHkY/9gQwGD4/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 04:58, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add amdgpu_svm_attr.h with the SVM attribute types and tree
> infrastructure together with the helper implementation in
> amdgpu_svm_attr.c that uses them. The header is squashed into the
> implementation patch so it does not stand alone as declarations
> without an implementation.
> 
> amdgpu_svm_attr.h:
> - Internal flag bitmask definitions mapped from UAPI attr types
> - PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
> - struct amdgpu_svm_attrs: user set attribute range
> - struct amdgpu_svm_attr_range: interval tree node with attrs
> - struct amdgpu_svm_attr_tree: mutex protected RB tree for store and
>   search
> - enum amdgpu_svm_attr_change_trigger: change flags of user attribute
>   changes
> 
> amdgpu_svm_attr.c:
> - Default attribute initialization: amdgpu_svm_attr_set_default
> - Device memory and VRAM preference helpers
> - VMA validity checker: amdgpu_svm_check_vma
> - Attribute equality comparison: attr_equal
> - Interval tree CRUD operations: find, get_bounds,
>   alloc, insert, and remove
> - attr_set_interval helper for range boundary updates
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 235 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 182 ++++++++++++++
>  2 files changed, 417 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> new file mode 100644
> index 0000000000000..a5afa75421fbd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
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
> + */
> +
> +#include "amdgpu_svm.h"
> +#include "amdgpu_svm_attr.h"
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/lockdep.h>
> +#include <linux/minmax.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +
> +struct attr_set_ctx {
> +	struct amdgpu_svm_attrs old_attrs;
> +	struct amdgpu_svm_attrs new_attrs;
> +	unsigned long start_page;
> +	unsigned long last_page;
> +};
> +
> +struct attr_get_ctx {
> +	int32_t preferred_loc;
> +	int32_t prefetch_loc;
> +	enum amdgpu_ioctl_svm_access access;
> +	uint32_t granularity;
> +	uint32_t flags_and;
> +	bool has_range;
> +};
> +


> +bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs)
> +{
> +	if (attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
> +	    attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM)
> +		return true;
> +
> +	if (attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
> +	    attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
> +		return true;
> +
> +	return false;
> +}
> +
> +struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
> +					unsigned long addr)
> +{
> +	const unsigned long unsupported_vm_flags = VM_IO | VM_PFNMAP |
> +						   VM_MIXEDMAP;
> +	struct vm_area_struct *vma = vma_lookup(mm, addr);
> +
> +	if (!vma)
> +		return ERR_PTR(-EFAULT);
> +
> +	if (vma->vm_flags & unsupported_vm_flags)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	return vma;
> +}
> +
> +static void attr_set_interval(struct amdgpu_svm_attr_range *range,
> +				unsigned long start_page,
> +				unsigned long last_page)
> +{
> +	range->it_node.start = start_page;
> +	range->it_node.last = last_page;
> +}
> +
> +void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
> +				 struct amdgpu_svm_attrs *attrs)
> +{
> +	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	attrs->granularity = svm->default_granularity;
> +	attrs->flags = AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_COHERENT;
> +	attrs->access = svm->xnack_enabled ?
> +		AMDGPU_SVM_ACCESS_ALLOW_MIGRATE : AMDGPU_SVM_ACCESS_INACCESSIBLE;
> +}
> +
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +			   unsigned long page)
> +{
> +	struct interval_tree_node *node;
> +
> +	node = interval_tree_iter_first(&attr_tree->tree, page, page);
> +	if (node)
> +		return container_of(node, struct amdgpu_svm_attr_range, it_node);
> +
> +	return NULL;
> +}

I think this whole block of functions can be static, but not 100% sure.

If they are used outside of this C file please add kerneldoc for them.

Apart from those generic comments I don't feel like I knew enough about drm_gpusvm and the ROCm requirements to judge if that is really correct or not.

Writing that I added Aveline on CC, it would be really cool if you could take a look as well.

Feel free to add Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +
> +/**
> + * amdgpu_svm_attr_get_bounds_locked() - Find attributes  or surrounding bounds
> + * @attr_tree: attribute tree to search.
> + * @page: page index to look up.
> + * @start_page: out, first page of the returned range or gap.
> + * @last_page: out, last page of the returned range or gap.
> + *
> + * If @page is covered by an attribute range, return that range and report its
> + * bounds. Otherwise return NULL and fill @start_page/@last_page with the bounds
> + * of the default attribute gap around @page, clamped by neighboring explicit
> + * ranges or [0, ULONG_MAX] when none.
> + *
> + * Return: the covering range, or NULL if @page falls in a gap.
> + */
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +				  unsigned long page,
> +				  unsigned long *start_page,
> +				  unsigned long *last_page)
> +{
> +	struct amdgpu_svm_attr_range *attr_range;
> +	struct interval_tree_node *node;
> +	struct rb_node *rb;
> +
> +	attr_range = amdgpu_svm_attr_find_locked(attr_tree, page);
> +	if (attr_range) {
> +		*start_page = amdgpu_svm_attr_start_page(attr_range);
> +		*last_page = amdgpu_svm_attr_last_page(attr_range);
> +		return attr_range;
> +	}
> +
> +	*start_page = 0;
> +	*last_page = ULONG_MAX;
> +
> +	if (page == ULONG_MAX)
> +		return NULL;
> +
> +	node = interval_tree_iter_first(&attr_tree->tree, page + 1, ULONG_MAX);
> +	if (node) {
> +		if (node->start > page)
> +			*last_page = node->start - 1;
> +
> +		rb = rb_prev(&node->rb);
> +		if (rb) {
> +			node = container_of(rb, struct interval_tree_node, rb);
> +			if (node->last < page)
> +				*start_page = node->last + 1;
> +		}
> +	} else {
> +		rb = rb_last(&attr_tree->tree.rb_root);
> +
> +		if (rb) {
> +			node = container_of(rb, struct interval_tree_node, rb);
> +			if (node->last < page)
> +				*start_page = node->last + 1;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool attr_equal(const struct amdgpu_svm_attrs *a,
> +				 const struct amdgpu_svm_attrs *b)
> +{
> +	return a->flags == b->flags &&
> +	       a->preferred_loc == b->preferred_loc &&
> +	       a->prefetch_loc == b->prefetch_loc &&
> +		       a->granularity == b->granularity &&
> +		       a->access == b->access;
> +}
> +
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
> +			   unsigned long last_page,
> +			   const struct amdgpu_svm_attrs *attrs)
> +{
> +	struct amdgpu_svm_attr_range *range;
> +
> +	range = kzalloc_obj(*range, GFP_KERNEL);
> +	if (!range)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&range->list);
> +	attr_set_interval(range, start_page, last_page);
> +	range->attrs = *attrs;
> +	return range;
> +}
> +
> +void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +					 struct amdgpu_svm_attr_range *range)
> +{
> +	struct interval_tree_node *node;
> +	struct amdgpu_svm_attr_range *next;
> +
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	/*
> +	 * Keep @range_list ordered by start page: insert before the first range
> +	 * starting at or after @range, then add to the interval tree.
> +	 */
> +	node = interval_tree_iter_first(&attr_tree->tree, amdgpu_svm_attr_start_page(range),
> +					ULONG_MAX);
> +	if (node) {
> +		next = container_of(node, struct amdgpu_svm_attr_range, it_node);
> +		list_add_tail(&range->list, &next->list);
> +	} else {
> +		list_add_tail(&range->list, &attr_tree->range_list);
> +	}
> +
> +	interval_tree_insert(&range->it_node, &attr_tree->tree);
> +}
> +
> +static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +					  struct amdgpu_svm_attr_range *range,
> +					  bool free_range)
> +{
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	interval_tree_remove(&range->it_node, &attr_tree->tree);
> +	list_del_init(&range->list);
> +	if (free_range)
> +		kfree(range);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> new file mode 100644
> index 0000000000000..36fee11aa9ea0
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> @@ -0,0 +1,182 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
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
> + */
> +
> +#ifndef __AMDGPU_SVM_ATTR_H__
> +#define __AMDGPU_SVM_ATTR_H__
> +
> +#include <drm/amdgpu_drm.h>
> +#include <linux/interval_tree.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/rbtree.h>
> +#include <linux/types.h>
> +
> +/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
> +#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS		(1u << 0)
> +#define AMDGPU_SVM_ATTR_BIT_COHERENT		(1u << 1)
> +#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT	(1u << 2)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_RO		(1u << 3)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC		(1u << 4)
> +#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY	(1u << 5)
> +
> +#define AMDGPU_SVM_PTE_FLAG_MASK \
> +	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
> +	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
> +
> +#define AMDGPU_SVM_MAPPING_FLAG_MASK \
> +	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | \
> +	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
> +
> +/**
> + * struct amdgpu_svm_attrs - SVM attributes for an address range
> + * @preferred_loc: Preferred backing location, using AMDGPU_SVM_LOCATION_*.
> + * @prefetch_loc: Target location for prefetch requests, using
> + *                AMDGPU_SVM_LOCATION_*.
> + * @flags: Internal AMDGPU_SVM_ATTR_BIT_* flags mapped from the UAPI.
> + * @granularity: Mapping granularity encoded as a page order.
> + * @access: CPU/GPU access policy from the SVM UAPI.
> + */
> +struct amdgpu_svm_attrs {
> +	int32_t preferred_loc;
> +	int32_t prefetch_loc;
> +	uint32_t flags;
> +	uint32_t granularity;
> +	enum amdgpu_ioctl_svm_access access;
> +};
> +
> +/**
> + * struct amdgpu_svm_attr_range - a range of user attributes
> + * @it_node: interval tree node keyed by [start, last] page index.
> + * @list: links the range into amdgpu_svm_attr_tree.range_list in address order.
> + * @attrs: the attributes applied to this range.
> + */
> +struct amdgpu_svm_attr_range {
> +	struct interval_tree_node it_node;
> +	struct list_head list;
> +	struct amdgpu_svm_attrs attrs;
> +};
> +
> +static inline unsigned long
> +amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.start;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.last;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
> +{
> +	return range->it_node.start << PAGE_SHIFT;
> +}
> +
> +static inline unsigned long
> +amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
> +{
> +	return (range->it_node.last + 1) << PAGE_SHIFT;
> +}
> +
> +struct amdgpu_svm;
> +struct mm_struct;
> +struct vm_area_struct;
> +
> +static inline bool
> +amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
> +{
> +	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
> +	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
> +}
> +
> +/**
> + * struct amdgpu_svm_attr_tree - per-SVM store of user attribute ranges
> + * @lock: protects @tree and @range_list.
> + * @tree: interval tree of struct amdgpu_svm_attr_range for fast lookup.
> + * @range_list: address-ordered list of the same ranges, kept in sync with
> + *              @tree to allow ordered traversal during modification.
> + * @svm: back pointer to the owning SVM instance.
> + */
> +struct amdgpu_svm_attr_tree {
> +	struct mutex lock;
> +	struct rb_root_cached tree;
> +	struct list_head range_list;
> +	struct amdgpu_svm *svm;
> +};
> +
> +/**
> + * enum amdgpu_svm_attr_change_trigger - effects caused by an attribute change
> + * @AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE: Access policy changed.
> + * @AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE: GPU PTE permission/cache bits changed.
> + * @AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE: Mapping policy bits changed.
> + * @AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE: Preferred or prefetch location changed.
> + * @AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE: Range granularity changed.
> + * @AMDGPU_SVM_ATTR_TRIGGER_PREFETCH: New attributes request a VRAM prefetch.
> + *
> + * Bitmask describing what an attribute update touched. It drives whether the
> + * existing GPU mappings must be invalidated and/or remapped.
> + */
> +enum amdgpu_svm_attr_change_trigger {
> +	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
> +	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
> +	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
> +	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
> +	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
> +	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
> +};
> +
> +/*
> + * Attribute changes that require invalidating existing GPU mappings.
> + * A granularity-only change does not, so it is intentionally excluded.
> + */
> +#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
> +	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
> +	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
> +
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +			   unsigned long page);
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +				  unsigned long page,
> +				  unsigned long *start_page,
> +				  unsigned long *last_page);
> +void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
> +				 struct amdgpu_svm_attrs *attrs);
> +
> +struct amdgpu_svm_attr_range *
> +amdgpu_svm_attr_range_alloc(unsigned long start_page,
> +			   unsigned long last_page,
> +			   const struct amdgpu_svm_attrs *attrs);
> +void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
> +					 struct amdgpu_svm_attr_range *range);
> +bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
> +struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
> +					unsigned long addr);
> +
> +#endif /* __AMDGPU_SVM_ATTR_H__ */

