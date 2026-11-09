Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80502606A32A
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wijH168k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FFD10E115;
	Mon,  9 Nov 2026 12:52:21 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512D310F26C;
 Mon,  9 Nov 2026 12:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FutxzzhS0vI/XgPnvd4KVuyQLHH05LpB1giNi6VIDi85FgJ+IiZwNIvPWToaqHAER9dx4mWKUesve7hXYCtS9h5Xr1tn7IWNSEEgqDHX2iPKi+MXfXvVyx/ATJnVqscE1YSVsR2YPsXMg6sE4vYNpDjS8D2a7ReRkpEH0q+dBlX8gedq+fdgtLicgTCufDRCO4M7RnFJlU6l1d6/zeQYL3pPyf4PeWa0YNWTsxJNzonnlB3eq5R8QvERI9xTcnVjH6fKUVsLaNhJUB8R9YO0IXnQdtJ05RCgWshgpXNPWGCbS5UyrsIQNPKMx5BeAD3bV6/orDi0DeZRD721zaSsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rFcAWoqdAiJBdDoYcEjq/ADEcHiF/vOJNra+7nGwig=;
 b=DHG22fv+XugY/DKJNKZBGauz2r6Gz9h3NZ5g5p9aY8NpiOQEMVrFfaOGbGG9I+KZ+IJPt7BZeHRxEwmhNchEijOte6k3UrIDaobOPrfG4N9HOR9hBByGpEyk8ZEZipjF+mj9cQUSFnHa7iOZv7PJFqACJFWlmsQVP9YsoAt0591ZdxfIMt2AsDTZ/yKlyXbhKVIMo8/OgRi0NDc+0FMlgmhOBFVvMcf+iEr2fU3MILyM6oMOgP3DNOKa/nBOoXFeilvM7PjTUpl4gTdyhPTcdRqnYh9YFFrofvXNM7+t+1ijM5QHZRTHet/qh9G5b9mP+bn56KGt2CiBLviWdojjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rFcAWoqdAiJBdDoYcEjq/ADEcHiF/vOJNra+7nGwig=;
 b=wijH168ktKTZG0f+RPOAN+BCP/lRYFBRREsan0cPiUvYWKcOzndEwzCHSmE6UoI73sklYdmYFu0c4PyDRh5vGaNFURhrGxkP2yLh2YOseZM8jA/gxLyexc5Lqm8fvyUHRiz11HWLbXmP2oZX1LUYjZE0N/g8F7Asyx8IAompeAM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:52:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:52:10 +0000
Message-ID: <e2423693-a6d2-45fc-9a0d-0665b07301c2@amd.com>
Date: Mon, 9 Nov 2026 13:52:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/22] drm/amdgpu: implement SVM attribute
 set/get/clear operations
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
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-5-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-5-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: df570b33-23f7-4e6f-cba4-08df3e604476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|6133799003|10067099003|921020|4143699003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003;
X-Microsoft-Antispam-Message-Info: mvnUrHYddwgYPTQh/z3PVOiWNbvYS8DnSP2HfeoVUW8GmNA0t7hwfrwNP2Czya8x981I22ivMKFvC3W2C6PamL4BP1NiGMc8qksbv2i3EqdmtiP/GYg7L7QJU/djdhXM9y7wO6I2q6KK9AA1vRXOgXEWOc1DFaTzmjB5ss7lOLhQNrjX6UOeivhCRaya/E9nJSuY7pziKebbzz74MDtQcX5FBxCHWJSjqwz0a7HOmjzBOyOMJ9ZGZFAwzTGsDuCqFwFrJJgXcsjun2ttIH1tuo9jjmwtA4gmvSQ/e43YAi8JkDDVS1dew7WzsGNyJDcmCgAwu84De+nT36gIImsUW12w2Oy7kJWXjO83ryv2RH5JbKcM8fa61uoyPrypFP+sqNzwvgZmwo/QZLcfj3MdL38vACG4bbU1mHPqIiDlHUx9cd4iZFnfCaEH5Q8xWvy6OPHgBOaZmXilKs26p9K+sgNn+M4jV09QF0JFgEodFcQJbM2w1G1gDAJSvdYN5KCXTP+NZsl9yJKGJxtcAPPyGU3ZGW3FdHspKsna8ayKk3VY9kG2/WEo9xTsz6AhawtUPNhN+c/KwO+qF17epErAmXB++HBDQZRHg5TI1d+P1MwxPyytXhf7KbAkxavt4qpWlhlqJpI528YyQFQLw5V3m5bsk5EsSAUn9mLW02kiTyhWgHYpnCB0KQ/RSsHQvY2MqOjZQA+IPWUuDTO7YKkhTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJPMkwrckQ2dGRZZ3VJTDY2WUR5c084RzFpcnhHVUh3SU1UcmlYQ1JYeE14?=
 =?utf-8?B?MGw2RWZRcFBvV21idnRoUjRKeDZobko3YkRtdEp3bGRma1ZlUTAvVTRTOVNC?=
 =?utf-8?B?R1BSSmJOb3VmT28yRnMxczU1R3lLbU9vWWlWaldVVW1uUUp0MmgzZG1hc3hY?=
 =?utf-8?B?K21QLy9Zc2Mxb2pkNlpHNlFOaTFsYkFFOUlkdVgyQ21ya1Fwamsxa0d3WkM3?=
 =?utf-8?B?a2hMTXlqdnE0czVLQWl3MGVHZHVZL2tUK2J2RUVHRCtIcnNib2wrL3NueTdH?=
 =?utf-8?B?Wnl2UFBlZDRjbFZWNXlhMVFydFMvRHJnY0lVTHhQTmVmWlBxLzUvYWdwcHVl?=
 =?utf-8?B?UnNoaTErY2tONDA2RThpREd5eGFIVFhjMldFbmxtZzhjODJjL01uR2hmRHVt?=
 =?utf-8?B?STNRT0FFV1UwWngydUtYVVNXVkFSUG9BRFZDMkZxZ29Bbjh3WEZRcXNpdmpl?=
 =?utf-8?B?RXBwdXluSU1uckhyKzhPQ0t0dWVwdXFkRHR6Yk1xcGlrUUx5OEhSbWFWNE1W?=
 =?utf-8?B?dHNuS2tyd0IweDdZVGx2bWltMWltMVZwYmlhTTZqdGRyZ3hxQ0pqZlZRNG1U?=
 =?utf-8?B?RXIvVFdzTmtEQlRXbUUxNERKdXVWeVkxUDJic3M5KzdmRFh2eDl6bFc5QThM?=
 =?utf-8?B?VUI5R0VVVU1XL2RJVW5ZR0pMRXBnR1A0MDgyN1FiRzIzOFhqZzZhL2RDNUpq?=
 =?utf-8?B?NWNTSGFqL053VFh3RWI4eS9oWU9seDdqRWFrSTJWeTFDN09YL1g4RW5IbllE?=
 =?utf-8?B?OU4vaWkyTWlSS0pCLzM0M002czN2SDVRSWNHYm9mMTNjS1dueEdFaEQ3eFlN?=
 =?utf-8?B?MDdlK3J0dzhzc1BFS05qZVBkYUxTSUdCYk9iYzJNQnZubU9LRTF0ZTlhNGp3?=
 =?utf-8?B?UUx3dU1kWE1SNzl0MUxGdnZSaC9RdVJzR1NyaU12OXZ0NExKdERFZUVzK1Nu?=
 =?utf-8?B?LzlpYWcrWVcrM2dYMldjR3A0N0N5VklIdWI1eGFnUmkrSjNudURESzU0L3h2?=
 =?utf-8?B?VGpMSGVGV1NWaSsxeGMwRHZlV2F6ZFc3eVhlK05ENGcyZDRSQ0hvTWFvOTBF?=
 =?utf-8?B?Um9FYys0Wm5xamZOUmwyWUtQK0M4K21oT0M5eWFnNlhpVktsbjk4NUZuTGtV?=
 =?utf-8?B?NGlDNGZiQytJVnUzWjMzTUpkVThtamZmVmI0K3RvMGFuZ2ZvNFBmdnJLQW1i?=
 =?utf-8?B?b2Vic01TaGVmb1dlMFRSeS9pejBuT3VRSURwSUcvM0FuVUE4WG5heUFZRTVC?=
 =?utf-8?B?RENBZ3QrY2t3MTZDTWlTcjVjRnJud24vbjJxcEpSNGN5VXN1TC8vNzRUbzBY?=
 =?utf-8?B?aHRISXNKZjRnZ2hsU2Uwa3VhdEZ3bUpHNzUwcnFSRkZSUThlbjdhdWViRmph?=
 =?utf-8?B?cm5RL1Z1b3dZc0ZJNnFnTmU3MzF2U1ltK3dSa1hkcUdHRjFadlNkaUtJZzRR?=
 =?utf-8?B?ZStLZkVIdklOdDVpTEF0clFMRkRkMFNqZ2ZoMTNzRmFSNFVBYW5IQ2lTb3E1?=
 =?utf-8?B?cWtyZTFLV1Y2d1pZc0hybW9iYkl5bU5NVnVuU2tPeXVvZ0JGQ0xRUVVnNko0?=
 =?utf-8?B?N3dnK0JhY2dpWWVzbHBIN3BHb2ZEemZXL05WVy9xelYxRkV4bEdNRG9EbVMv?=
 =?utf-8?B?dFExSFgzU3pWcGQ2TDl5T3UxYksySERkaUd4a0xKd3BKZGpyTEpSOU0rbXNo?=
 =?utf-8?B?Z2l0MlZTbEZpbzNGMklyaUQwd3huWkExSWpvS3lLbzNuamV6MytneXUxVjNE?=
 =?utf-8?B?YXJDV1hRN0tSUWxDWmlZRCtncEM1VXlyL0lpa3Z5NmlScGZLdlFKdUxQemhz?=
 =?utf-8?B?N252WENVdjNNTTJNdWJCQlNuMEdhc2tiOE95cHFnZ1g1NzJQS0taR2Z0TFhC?=
 =?utf-8?B?cHpZS3V1dGR4TjA0bzNUZUJUVHllR3ZqeUVIS2lXWCtkZFV3S3lKYXlmWExs?=
 =?utf-8?B?c1hQdnZwQVczVHRXcXd4REl3dm1jME1MS3NUZGh3NDBMVmFCRzVhdk9aWStl?=
 =?utf-8?B?bGRlQk1DVFFWV2xnR0JYMVFMMzJuOWJMdnlRWmtiTGxyYUNCcFdCMDRqL0tm?=
 =?utf-8?B?V0xqSWl6VlNmb2xQS1FOdXBKOFF4cm5qOHU2M2lIUHBiQjNWZ2JxVFROTzRS?=
 =?utf-8?B?VHhIaFVJMXhGVGRuamFybzZBbkpWd0JkL2lQV2Fmb05DRUxySnAzT1VPNksr?=
 =?utf-8?B?ckdxOWdHY3kyQmJsa0VXb3NEQXBaaTIvQXJpWS9JNWJzZGJFWWtTSi92TWZI?=
 =?utf-8?B?clh2YUR3VmkzanNRbVlPN1FlVG5kZDBiVzdlY25kbytkTk5HY0tBVGhYNXNn?=
 =?utf-8?Q?nu23GMob1f1fbHT0hH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df570b33-23f7-4e6f-cba4-08df3e604476
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:52:09.9225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDN8yatBuoWYhdyOKGnQoU1BPpAR+fHitEoAn1yCJTO8rFhNtapnpbobh/Z7G2wE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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
> Complete attribute subsystem with validation, tree modification, and
> public API:
> - Attribute validation: per-type checks for preferred_loc, prefetch_loc,
>   access, flags, granularity
> - Flag application: attr_apply_flag, amdgpu_svm_attr_apply
> - VMA range validation: amdgpu_svm_attr_validate_range_vma
> - VM BO overlap detection: amdgpu_svm_attr_check_vm_bo
> - Tree modification with gap/overlap handling:
>   amdgpu_svm_attr_set_hole (new range in gap),
>   amdgpu_svm_attr_set_existing (split/update existing range)
> - amdgpu_svm_attr_set_range: cursor based iteration with per segment
> - Lifecycle: amdgpu_svm_attr_tree_create/destroy
> - Public API: amdgpu_svm_attr_set (validate, set_range with retry),
>   amdgpu_svm_attr_get (aggregate attrs across interval),
>   amdgpu_svm_attr_clear (interval removal with split),
>   amdgpu_svm_attr_reset
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 736 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h |  20 +
>  2 files changed, 756 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> index a5afa75421fbd..c76e10473968e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
> @@ -78,6 +78,43 @@ struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
>  	return vma;
>  }
>  
> +/*
> + * amdgpu_svm_attr_range_is_valid - validate an attr ioctl address range
> + *
> + * Synchronous input validation for the SVM set/get-attr ioctls: walk the
> + * CPU VMAs covering [start_page, last_page] and reject the request if any
> + * part is unmapped or backed by an unsupported VMA (-EOPNOTSUPP).
> + *
> + */
> +static int amdgpu_svm_attr_range_is_valid(struct amdgpu_svm *svm,
> +					  unsigned long start_page,
> +					  unsigned long last_page)
> +{
> +	struct mm_struct *mm = svm->gpusvm.mm;
> +	struct vm_area_struct *vma;
> +	unsigned long start, end;
> +	int r = 0;
> +
> +	if (!mm)
> +		return -EFAULT;
> +
> +	start = start_page << PAGE_SHIFT;
> +	end = (last_page + 1) << PAGE_SHIFT;
> +
> +	mmap_read_lock(mm);
> +	do {
> +		vma = amdgpu_svm_check_vma(mm, start);
> +		if (IS_ERR(vma)) {
> +			r = PTR_ERR(vma);
> +			break;
> +		}
> +		start = min(end, vma->vm_end);
> +	} while (start < end);
> +	mmap_read_unlock(mm);

Again a clear NAK to any of those static checks!

The result of the check becomes invalid ass soon as the mman_read_lock is dropped, so that here only gives a completely false picture if some operation is valid or not.

We have two possibilities here, either keep the mman_read_lock while installing the SVM range or completely drop the check and make sure that faulting on a range which isn't backed by any VMA or an invalid VMA is properly handled in the fault handler.

I think we need to have a resilent fault handler who can deal with such errors anyway, so it is probably the best approach to go down that route.

Regards,
Christian.

> +
> +	return r;
> +}
> +
>  static void attr_set_interval(struct amdgpu_svm_attr_range *range,
>  				unsigned long start_page,
>  				unsigned long last_page)
> @@ -233,3 +270,702 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
>  	if (free_range)
>  		kfree(range);
>  }
> +
> +static void attr_change_ctx_set(
> +		struct attr_set_ctx *change,
> +		const struct amdgpu_svm_attrs *old_attrs,
> +		const struct amdgpu_svm_attrs *new_attrs,
> +		unsigned long start_page,
> +		unsigned long last_page)
> +{
> +	change->old_attrs = *old_attrs;
> +	change->new_attrs = *new_attrs;
> +	change->start_page = start_page;
> +	change->last_page = last_page;
> +}
> +
> +static inline int attr_check_preferred_loc(uint32_t value)
> +{
> +	/*
> +	 * SYSMEM and UNDEFINED are always valid; LOCAL/HIVE select device
> +	 * VRAM (see enum amdgpu_ioctl_svm_location).
> +	 */
> +	switch (value) {
> +	case AMDGPU_SVM_LOCATION_SYSMEM:
> +	case AMDGPU_SVM_LOCATION_UNDEFINED:
> +	case AMDGPU_SVM_LOCATION_LOCAL:
> +	case AMDGPU_SVM_LOCATION_HIVE:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static inline int attr_check_prefetch_loc(uint32_t value)
> +{
> +	/*
> +	 * Prefetch accepts the same values as the preferred location (see
> +	 * enum amdgpu_ioctl_svm_location); UNDEFINED means no prefetch and is
> +	 * what GET_ATTR reports for default or mixed ranges, so it must round
> +	 * trip through SET for CRIU restore.
> +	 */
> +	switch (value) {
> +	case AMDGPU_SVM_LOCATION_SYSMEM:
> +	case AMDGPU_SVM_LOCATION_UNDEFINED:
> +	case AMDGPU_SVM_LOCATION_LOCAL:
> +	case AMDGPU_SVM_LOCATION_HIVE:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static inline int attr_check_access(uint32_t value)
> +{
> +	switch (value) {
> +	case AMDGPU_SVM_ACCESS_INACCESSIBLE:
> +	case AMDGPU_SVM_ACCESS_IN_PLACE:
> +	case AMDGPU_SVM_ACCESS_ALLOW_MIGRATE:
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool attr_flag_type_to_bit(uint32_t type, uint32_t *flag_bit)
> +{
> +	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS ||
> +	    type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
> +		return false;
> +
> +	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
> +	return true;
> +}
> +
> +static inline int attr_check_flag_value(uint32_t value)
> +{
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_flag_attr(uint32_t type, uint32_t value)
> +{
> +	uint32_t flag_bit;
> +	int ret;
> +
> +	if (!attr_flag_type_to_bit(type, &flag_bit))
> +		return -EINVAL;
> +
> +	ret = attr_check_flag_value(value);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static inline int attr_check_granularity(uint32_t value)
> +{
> +	return 0;
> +}
> +
> +static int attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
> +{
> +	switch (attr->type) {
> +	case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +		return attr_check_preferred_loc(attr->value);
> +	case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +		return attr_check_prefetch_loc(attr->value);
> +	case AMDGPU_SVM_ATTR_ACCESS:
> +		return attr_check_access(attr->value);
> +	case AMDGPU_SVM_ATTR_GRANULARITY:
> +		return attr_check_granularity(attr->value);
> +	case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +	case AMDGPU_SVM_ATTR_COHERENT:
> +	case AMDGPU_SVM_ATTR_GPU_RO:
> +	case AMDGPU_SVM_ATTR_GPU_EXEC:
> +	case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +	case AMDGPU_SVM_ATTR_EXT_COHERENT:
> +		return attr_check_flag_attr(attr->type, attr->value);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void attr_apply_flag(struct amdgpu_svm_attrs *attrs,
> +			    uint32_t type, uint32_t value)
> +{
> +	uint32_t flag_bit;
> +
> +	if (!attr_flag_type_to_bit(type, &flag_bit))
> +		return;
> +
> +	if (value)
> +		attrs->flags |= flag_bit;
> +	else
> +		attrs->flags &= ~flag_bit;
> +}
> +
> +static void attr_apply(struct amdgpu_svm_attrs *attrs,
> +					uint32_t nattr,
> +					const struct drm_amdgpu_svm_attribute *pattrs)
> +{
> +	const struct drm_amdgpu_svm_attribute *attr;
> +
> +	for (attr = pattrs; nattr--; attr++) {
> +		switch (attr->type) {
> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +			attrs->preferred_loc = (int32_t)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +			attrs->prefetch_loc = (int32_t)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_ACCESS:
> +			attrs->access = (enum amdgpu_ioctl_svm_access)attr->value;
> +			break;
> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +		case AMDGPU_SVM_ATTR_COHERENT:
> +		case AMDGPU_SVM_ATTR_GPU_RO:
> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +		case AMDGPU_SVM_ATTR_EXT_COHERENT:
> +			attr_apply_flag(attrs, attr->type, attr->value);
> +			break;
> +		case AMDGPU_SVM_ATTR_GRANULARITY:
> +			attrs->granularity = min_t(uint32_t, attr->value, 0x3f);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range,
> +			    uint32_t nattr,
> +			    const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm_attrs target;
> +
> +	target = range->attrs;
> +	attr_apply(&target, nattr, attrs);
> +	return attr_equal(&range->attrs, &target);
> +}
> +
> +static int
> +amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs,
> +			  struct attr_set_ctx *change)
> +{
> +	struct amdgpu_svm_attrs new_attrs;
> +	struct amdgpu_svm_attr_range *range;
> +
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	if (start_page > last_page)
> +		return 0;
> +
> +	new_attrs = *default_attrs;
> +	attr_apply(&new_attrs, nattr, attrs);
> +
> +	/* Always create a range entry even when attrs equal defaults */
> +	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +
> +	attr_change_ctx_set(change, default_attrs,
> +				       &new_attrs, start_page, last_page);
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_svm_attr_set_existing() - Apply attrs to part of an existing range
> + *
> + * Update @range over [@start_page, @last_page]. If the request fully covers
> + * @range the attrs are updated in place, otherwise the range is split into the
> + * head/tail, carrying the old attrs, and the covered middle, carrying
> + * the new attrs. The resulting change is reported by @change.
> + */
> +static int
> +amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
> +			     struct amdgpu_svm_attr_range *range,
> +			     unsigned long start_page, unsigned long last_page,
> +			     uint32_t nattr,
> +			     const struct drm_amdgpu_svm_attribute *attrs,
> +			     struct attr_set_ctx *change)
> +{
> +	unsigned long range_start = amdgpu_svm_attr_start_page(range);
> +	unsigned long range_last = amdgpu_svm_attr_last_page(range);
> +	struct amdgpu_svm_attr_range *left = NULL;
> +	struct amdgpu_svm_attr_range *right = NULL;
> +	struct amdgpu_svm_attrs old_attrs;
> +	struct amdgpu_svm_attrs new_attrs;
> +
> +	lockdep_assert_held(&attr_tree->lock);
> +
> +	old_attrs = range->attrs;
> +
> +	if (attr_same_attrs(range, nattr, attrs)) {
> +		/* Report old==new so apply_attr_change can decide */
> +		attr_change_ctx_set(change, &old_attrs,
> +					       &old_attrs,
> +					       start_page, last_page);
> +		return 0;
> +	}
> +
> +	new_attrs = old_attrs;
> +	attr_apply(&new_attrs, nattr, attrs);
> +
> +	/* only need to update attr */
> +	if (start_page == range_start && last_page == range_last) {
> +		range->attrs = new_attrs;
> +		attr_change_ctx_set(change, &old_attrs,
> +					       &new_attrs, start_page, last_page);
> +		return 0;
> +	}
> +
> +	/* split head */
> +	if (start_page > range_start) {
> +		left = amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old_attrs);
> +		if (!left)
> +			return -ENOMEM;
> +	}
> +
> +	/* split tail */
> +	if (last_page < range_last) {
> +		right = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &old_attrs);
> +		if (!right) {
> +			kfree(left);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	attr_remove_range_locked(attr_tree, range, false);
> +	if (left)
> +		amdgpu_svm_attr_range_insert_locked(attr_tree, left);
> +	attr_set_interval(range, start_page, last_page);
> +	range->attrs = new_attrs;
> +	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +	if (right)
> +		amdgpu_svm_attr_range_insert_locked(attr_tree, right);
> +
> +	attr_change_ctx_set(change, &old_attrs,
> +				       &new_attrs, start_page, last_page);
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_svm_attr_set_range() - Apply attr changes across [@start_page, @last_page]
> + *
> + * Walk the interval in segments, each segment being either an existing range
> + * or a hole.
> + */
> +static int
> +amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
> +			  const struct amdgpu_svm_attrs *default_attrs,
> +			  unsigned long start_page, unsigned long last_page,
> +			  uint32_t nattr,
> +			  const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm *svm = attr_tree->svm;
> +	unsigned long cursor = start_page;
> +	bool need_retry = false;
> +
> +	while (cursor <= last_page) {
> +		struct interval_tree_node *node;
> +		unsigned long seg_last;
> +		struct attr_set_ctx change = { 0 };
> +		int ret;
> +
> +		amdgpu_svm_lock(svm);
> +		mutex_lock(&attr_tree->lock);
> +		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
> +		if (node) {
> +			struct amdgpu_svm_attr_range *range;
> +
> +			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
> +			seg_last = min(last_page, amdgpu_svm_attr_last_page(range));
> +			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
> +								   cursor, seg_last,
> +								   nattr, attrs, &change);
> +		} else {
> +			struct interval_tree_node *next;
> +
> +			seg_last = last_page;
> +			if (cursor != ULONG_MAX) {
> +				next = interval_tree_iter_first(&attr_tree->tree,
> +								cursor + 1,
> +								ULONG_MAX);
> +				if (next) {
> +					struct amdgpu_svm_attr_range *next_range;
> +
> +					next_range = container_of(next,
> +						struct amdgpu_svm_attr_range,
> +						it_node);
> +					seg_last = min(last_page,
> +						       amdgpu_svm_attr_start_page(next_range) - 1);
> +				}
> +			}
> +			ret = amdgpu_svm_attr_set_hole(attr_tree,
> +							       default_attrs,
> +							       cursor, seg_last,
> +							       nattr, attrs,
> +							       &change);
> +		}
> +		mutex_unlock(&attr_tree->lock);
> +
> +		if (ret) {
> +			amdgpu_svm_unlock(svm);
> +			return ret;
> +		}
> +
> +		ret = amdgpu_svm_apply_attr_change(svm,
> +						   &change.old_attrs,
> +						   &change.new_attrs,
> +						   change.start_page,
> +						   change.last_page);
> +		amdgpu_svm_unlock(svm);
> +
> +		if (ret == -EAGAIN) {
> +			need_retry = true;
> +			ret = 0;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		if (seg_last == ULONG_MAX || seg_last == last_page)
> +			break;
> +
> +		cursor = seg_last + 1;
> +	}
> +
> +	return need_retry ? -EAGAIN : 0;
> +}
> +
> +struct amdgpu_svm_attr_tree *
> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
> +{
> +	struct amdgpu_svm_attr_tree *attr_tree;
> +
> +	attr_tree = kzalloc_obj(*attr_tree, GFP_KERNEL);
> +	if (!attr_tree)
> +		return NULL;
> +
> +	mutex_init(&attr_tree->lock);
> +	attr_tree->tree = RB_ROOT_CACHED;
> +	INIT_LIST_HEAD(&attr_tree->range_list);
> +	attr_tree->svm = svm;
> +	return attr_tree;
> +}
> +
> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
> +{
> +	struct amdgpu_svm_attr_range *range, *tmp;
> +
> +	if (!attr_tree)
> +		return;
> +
> +	mutex_lock(&attr_tree->lock);
> +	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
> +		interval_tree_remove(&range->it_node, &attr_tree->tree);
> +		list_del_init(&range->list);
> +		kfree(range);
> +	}
> +	mutex_unlock(&attr_tree->lock);
> +
> +	mutex_destroy(&attr_tree->lock);
> +	kfree(attr_tree);
> +}
> +
> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
> +			uint64_t start,
> +			uint64_t size,
> +			uint32_t nattr,
> +			const struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	struct amdgpu_svm *svm = attr_tree->svm;
> +	struct amdgpu_svm_attrs default_attrs;
> +	unsigned long start_page, last_page;
> +	uint32_t i;
> +	int r;
> +
> +	start_page = start >> PAGE_SHIFT;
> +	last_page = (start + size - 1) >> PAGE_SHIFT;
> +
> +	for (i = 0; i < nattr; i++) {
> +		pr_debug("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
> +			 attrs[i].type, attrs[i].value, start_page, last_page,
> +			 svm->xnack_enabled ? 1 : 0);
> +		r = attr_set_validate(&attrs[i]);
> +		if (r) {
> +			pr_debug("invalid attribute %u value 0x%08x",
> +					 attrs[i].type, attrs[i].value);
> +			return r;
> +		}
> +	}
> +
> +	r = amdgpu_svm_attr_range_is_valid(svm, start_page, last_page);
> +	if (r)
> +		return r;
> +
> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
> +
> +retry:
> +	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
> +					       start_page, last_page,
> +					       nattr, attrs);
> +	if (r == -EAGAIN) {
> +		pr_debug("attr_set retry [0x%lx-0x%lx]\n",
> +				 start_page, last_page);
> +		amdgpu_svm_sync_work(svm);
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	return r;
> +}
> +
> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	struct interval_tree_node *node;
> +	int r = 0;
> +
> +	if (start_page > last_page)
> +		return -EINVAL;
> +
> +	mutex_lock(&attr_tree->lock);
> +
> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
> +	while (node) {
> +		struct interval_tree_node *next;
> +		struct amdgpu_svm_attr_range *range;
> +		unsigned long range_start;
> +		unsigned long range_last;
> +
> +		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
> +		next = interval_tree_iter_next(node, start_page, last_page);
> +		range_start = amdgpu_svm_attr_start_page(range);
> +		range_last = amdgpu_svm_attr_last_page(range);
> +
> +		if (range_start < start_page && range_last > last_page) {
> +			struct amdgpu_svm_attr_range *tail;
> +
> +			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last,
> +							   &range->attrs);
> +			if (!tail) {
> +				r = -ENOMEM;
> +				break;
> +			}
> +
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, range_start, start_page - 1);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, tail);
> +		} else if (range_start < start_page) {
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, range_start, start_page - 1);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +		} else if (range_last > last_page) {
> +			attr_remove_range_locked(attr_tree, range, false);
> +			attr_set_interval(range, last_page + 1, range_last);
> +			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
> +		} else {
> +			attr_remove_range_locked(attr_tree, range, true);
> +		}
> +
> +		node = next;
> +	}
> +
> +	mutex_unlock(&attr_tree->lock);
> +	return r;
> +}
> +
> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	/*
> +	 * Range with no attr node in this implementation is treated the
> +	 * same as one that explicitly stores default attrs. So clear
> +	 * the attribute ranges when user wants to reset the attrs.
> +	 *
> +	 * - GET_ATTR: return default_attrs to userspace when there is no attr
> +	 *   range.
> +	 * - SET_ATTR: holes are treated as having default_attrs when
> +	 *   computing the change trigger.
> +	 * - Fault: attr lookup falls back to defaults when no attr range exists,
> +	 *   so migration and PTE flag decisions are unchanged.
> +	 *
> +	 * This approach simplifies the implementation and avoids redundant
> +	 * attribute maintenance. This ioctl operation is for attribute only,
> +	 * so do not invalidate the GPU mapping here.
> +	 */
> +	return amdgpu_svm_attr_clear(attr_tree, start_page, last_page);
> +}
> +
> +static void attr_get_ctx_add(struct attr_get_ctx *ctx,
> +			       const struct amdgpu_svm_attrs *attrs)
> +{
> +	if (!ctx->has_range) {
> +		ctx->preferred_loc = attrs->preferred_loc;
> +		ctx->prefetch_loc = attrs->prefetch_loc;
> +		ctx->granularity = attrs->granularity;
> +		ctx->access = attrs->access;
> +		ctx->flags_and = attrs->flags;
> +		ctx->has_range = true;
> +		return;
> +	}
> +
> +	if (ctx->preferred_loc != attrs->preferred_loc)
> +		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	if (ctx->prefetch_loc != attrs->prefetch_loc)
> +		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
> +	if (attrs->granularity < ctx->granularity)
> +		ctx->granularity = attrs->granularity;
> +	if (ctx->access != attrs->access)
> +		ctx->access = AMDGPU_SVM_ACCESS_INACCESSIBLE;
> +	ctx->flags_and &= attrs->flags;
> +}
> +
> +static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
> +				uint32_t nattr,
> +				struct drm_amdgpu_svm_attribute *attrs)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < nattr; i++) {
> +		switch (attrs[i].type) {
> +		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
> +			attrs[i].value = ctx->preferred_loc;
> +			break;
> +		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
> +			attrs[i].value = ctx->prefetch_loc;
> +			break;
> +		case AMDGPU_SVM_ATTR_ACCESS:
> +			attrs[i].value = (uint32_t)ctx->access;
> +			break;
> +		case AMDGPU_SVM_ATTR_HOST_ACCESS:
> +		case AMDGPU_SVM_ATTR_COHERENT:
> +		case AMDGPU_SVM_ATTR_GPU_RO:
> +		case AMDGPU_SVM_ATTR_GPU_EXEC:
> +		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
> +		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
> +			uint32_t flag_bit;
> +
> +			if (!attr_flag_type_to_bit(attrs[i].type, &flag_bit))
> +				return -EINVAL;
> +
> +			attrs[i].value = (ctx->flags_and & flag_bit) ? 1 : 0;
> +			break;
> +		}
> +		case AMDGPU_SVM_ATTR_GRANULARITY:
> +			attrs[i].value = ctx->granularity;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * On return @out_size is shrunk to the length of the contiguous range starting
> + * at @start over which all attributes are identical, so user space (e.g. CRIU)
> + * can walk the address space one uniform range at a time.
> + */
> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
> +			uint64_t start, uint64_t size,
> +			uint32_t nattr,
> +			struct drm_amdgpu_svm_attribute *attrs,
> +			uint64_t *out_size)
> +{
> +	struct amdgpu_svm_attrs default_attrs;
> +	struct amdgpu_svm_attrs ref_attrs;
> +	struct attr_get_ctx ctx = { 0 };
> +	struct interval_tree_node *node;
> +	unsigned long start_page, last_page, cursor, homog_last;
> +	bool have_ref = false;
> +	int r;
> +
> +	start_page = start >> PAGE_SHIFT;
> +	last_page = (start + size - 1) >> PAGE_SHIFT;
> +
> +	r = amdgpu_svm_attr_range_is_valid(attr_tree->svm, start_page, last_page);
> +	if (r)
> +		return r;
> +
> +	mutex_lock(&attr_tree->lock);
> +	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
> +
> +	homog_last = start_page;
> +	cursor = start_page;
> +	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
> +
> +	while (cursor <= last_page) {
> +		const struct amdgpu_svm_attrs *range_attrs;
> +		unsigned long range_last = last_page;
> +		struct amdgpu_svm_attr_range *range = NULL;
> +		unsigned long next;
> +
> +		if (node) {
> +			range = container_of(node, struct amdgpu_svm_attr_range,
> +					     it_node);
> +
> +			if (amdgpu_svm_attr_last_page(range) < cursor) {
> +				node = interval_tree_iter_next(node, start_page,
> +							       last_page);
> +				continue;
> +			}
> +
> +			if (amdgpu_svm_attr_start_page(range) <= cursor) {
> +				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
> +				node = interval_tree_iter_next(node, start_page,
> +							       last_page);
> +			} else {
> +				range_last = min(last_page,
> +						 amdgpu_svm_attr_start_page(range) - 1);
> +				range = NULL;
> +			}
> +		}
> +
> +		range_attrs = range ? &range->attrs : &default_attrs;
> +
> +		if (!have_ref) {
> +			ref_attrs = *range_attrs;
> +			have_ref = true;
> +		} else if (!attr_equal(range_attrs, &ref_attrs)) {
> +			break;
> +		}
> +
> +		homog_last = range_last;
> +
> +		if (range_last == ULONG_MAX)
> +			break;
> +
> +		next = range_last + 1;
> +		if (next <= cursor)
> +			break;
> +		cursor = next;
> +	}
> +
> +	if (!have_ref)
> +		ref_attrs = default_attrs;
> +
> +	attr_get_ctx_add(&ctx, &ref_attrs);
> +	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
> +	mutex_unlock(&attr_tree->lock);
> +
> +	if (!r && out_size)
> +		*out_size = ((uint64_t)(homog_last - start_page) + 1) << PAGE_SHIFT;
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> index 36fee11aa9ea0..56bcd81c608cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
> @@ -158,6 +158,9 @@ enum amdgpu_svm_attr_change_trigger {
>  	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
>  	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
>  
> +struct amdgpu_svm_attr_tree *
> +amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
> +void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
>  struct amdgpu_svm_attr_range *
>  amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
>  			   unsigned long page);
> @@ -169,6 +172,23 @@ amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
>  void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
>  				 struct amdgpu_svm_attrs *attrs);
>  
> +int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
> +			   uint64_t start,
> +			   uint64_t size,
> +			   uint32_t nattr,
> +			   const struct drm_amdgpu_svm_attribute *attrs);
> +int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
> +				       uint64_t start,
> +				       uint64_t size,
> +				       uint32_t nattr,
> +				       struct drm_amdgpu_svm_attribute *attrs,
> +				       uint64_t *out_size);
> +int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page);
> +int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
> +			  unsigned long start_page,
> +			  unsigned long last_page);
>  struct amdgpu_svm_attr_range *
>  amdgpu_svm_attr_range_alloc(unsigned long start_page,
>  			   unsigned long last_page,

