Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5744CC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C31710EB24;
	Tue, 11 Aug 2026 10:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6VuNCqD";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8063F10E31A;
 Tue, 11 Aug 2026 10:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qViAugYvbCPVABVkv4nBqcJbf6sJO/x/ar9dNbsPl7XFzU4qlfSQgY2QyvINpFWCvG7YTo6hTVeoIWWLpJyL10Ba2zQk0XzzFTarU3lTUj7anL8EQhp6zOqw+uPQiItipaQESOk62FHtSsxdQsGW3YJuIRGBXhGlbdTQYsls8anwGrSiGkQf13nVOrOiVfRO8Fc5u63XAYLHhaQtf+jutumxWnghtJ/jRfbivOWMWdOMpkBwirxOYecu6qiXHPHOr8BuJz0tsnWEWY5aauc5litBX+TBrEInph5q0TQRWxizCqtq9BgNLOyCjaKiTDg5KW1zUxeTh3O5/RdqVEfJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcfTrqEdNWtkpbg9oLOxr0amehYcGgjazcGEemVziY4=;
 b=xPEqVA3guNIvrnWXTD6KTX66HOg7cHvhllbdTxOj5w2DgUxUE7UGBlE+Y3IeDBo77/F9W3o9ILYQhkRVEAVZeuIVrMbilyYEp+OFJfaFODG25OdCNgFA3l2ejXO+Ng/aw2GsKDTeewJITG7EkQjI91n1lJeasSMCAJGaLQivmg4AxT/UvwG3Jm1HojAB2v82qDcX/AMs3icsh9yt1s6mkifAB8w04wmk1CfsPXlwInVC+LKqJSZqyN3PMNFbrWiKdhgbRG7l6cLu+kDJTuYdXprfaWtzyIE6x3s9TYSmS9MjdwsZBI70sZZK/WW56dZyc1g8TfKlse8dQYt98Xd9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcfTrqEdNWtkpbg9oLOxr0amehYcGgjazcGEemVziY4=;
 b=s6VuNCqD1wwvbPU+td7IPQAIWNp5zJzeTZLUeBNyMGL/7BgIwJTlen7/2RFG27qCKg6biOg/YIsGY0EUVEhxcaL8idCLL4Te8hhZnd3bFw81UCCDUontOw/5B779evWJjJXDmGNsvRdqjKlzuicJFFDRy6RDlkV8er8woINVImA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 10:58:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:58:37 +0000
Message-ID: <461e376f-afb1-440f-b534-3784c830ae63@amd.com>
Date: Tue, 11 Aug 2026 12:58:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/18] drm/amdgpu: add SVM ioctl UAPI definitions
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
References: <20260804094246.1719318-1-ray.huang@amd.com>
 <20260804094246.1719318-2-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260804094246.1719318-2-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:208:23e::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: a96def49-3f71-45df-ff53-08def7977e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|921020|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pJSkqUcGYTzhlSrOQaEba39NJYc+Rg3C/8d/Hag8IYQ3uXKIW3a1Vd7BsygvFZRy5NrGSzbDAjEZoksL2c8/NtukeaU9TGVS+PFuy9IsR3lFfLbdgfDckyQCc8rDZEC7XUltNaQmINvt6EFSPwU02L5fzcQbxMZ7eL690lEOwDuiTJq2zpqAxa+v2ESoWA5DS5Ha563V42Wzs49+dMnOvzJJwwb0hY0+ygWsEeCnVeZjSFmuUNFRZJF9pkJ5zjEGVWD/hURnQPDJ6kHcDTxj9J3vwf7lFFAdBS30TBeDGidM2onLwDv6RTsVIihFQsZ7j2AKNwvASGY1p468i0WO/Yf61n/WDBkBARahRKnSD/jHOVL3/p7vfwePs2q/KxcHHHVDs9HnEdp7c1sj1gj91MshEQSF+r+otdsBJmTcfAFrU+5R+gtY/vW79ou7Ro0QQC6s9RapNPbbCd1BziWkAGrHNgho06c4+uMFaKq9vW8HFBBDKJt9yzo1wVuoqVVAuERFhJ8xgK0oosMbRMgse8sZzt3AI0aUx52mFqWfTLdp8hsVrJFTHAbGLRpicGr4vbkis+o4c3aQmB5OmSxbwB4cTHrP3CjUhLC0v1Q3xNAZDvAcdyoY+6sHA7NJwPx3OIV7Tqh+k7FFkUwHjxO63bR4oXoOCTg61FAsTVKJ7+SWicRehpkzA89msk8Jb8ZxPltSKvx54ZhERGlelpbFhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlISGwwbkE2TnlkL1JjTy85UE1RR25VMXRvWmNFSmxUSG1YbmZBODJXdDZK?=
 =?utf-8?B?dzhMbE1LcTNoaEZ3SC9YKzhyOUZYVFA4TlZhQjM3QzJicWV4Zm00bTFqR25Q?=
 =?utf-8?B?by9tUFd2K1VZYkx6SVJkN3granJWS2xEeW5MczBGbXVrUTVVcHM1c3JCWHdO?=
 =?utf-8?B?WWcrWmpwWnhuOTNudDZtdEU4dSs0QktEbTdMVisyNEtrWHAybGJjWGx6Slhl?=
 =?utf-8?B?SGtheTNHVjh6dFZBelN0TmlPSXdDcW9paTZEdld5Qlgxb1ozNnhNa1lXWTc4?=
 =?utf-8?B?UXVtNGdQOTRRU3liQnMySGpITk9iMGp6a0R5R0l6dXBBUEFyTWppTWtDTlFH?=
 =?utf-8?B?WlcvOUhrRWl5dk1EWWJqUkExSEVKOENjMXg1QTFmOWZVbEZOU1JoZ0FKYlMz?=
 =?utf-8?B?SE5EWFBITVJRS280Q0RWcXJMVTd0RURFekY0Q1JHdExHVFdDYklxQXVVUkF6?=
 =?utf-8?B?WmJYQy9kQm12NE1kbDZyeHpBQ0VtTXI1Y3cwQnI5M3ZZcTFrbzFPMG1FZisw?=
 =?utf-8?B?aitGWWdEajl3ZEx3SVRUaHVwRHJzRFFpaW5CK3pWdGpzSHRJUXVncjAwTkxE?=
 =?utf-8?B?ZnVRcXloOTI5RDh4WVZwK0poL3NLRFlBa2RUMmx1bWtzcDljaGNmbnZsY3Y4?=
 =?utf-8?B?Sy9DWHI5aHdFUm41ODFyVWwvaitlbkk0S0FCc1pTb0RaTDlIRnJWOUp6Z1Jq?=
 =?utf-8?B?eXUrcWtRbDF3M2lBSWdFZ3B4MERpbVVyN3BxeGpaQlZHYnFrazhjM0M5RnAx?=
 =?utf-8?B?VHIvdFNXLy9MU29tOFB1UmtFNytaZVhyS3ZhOVgrMHN2YVd0a1RVQXJJMkhw?=
 =?utf-8?B?U1pWSGV5SlJHUFF6Z2UxMFFEMHZ4bVZCZFh6SlV3TWhKbkRubE91THhYNThJ?=
 =?utf-8?B?MHRpVVNvZDROZlBpVjRhanRsNjcxM1hUcFZHNUwrWHpEdm9lN1cra0tIR3NJ?=
 =?utf-8?B?SzhqbUxSYWhscGlPRm9uZUVRUXZDbG42eVBvUVk3d0ZDbEcya2xRc2ZDajlY?=
 =?utf-8?B?NHVZTlNWYTZNczFDYWh6Y2Y1MG8vdjdPVXBBc0RJSkl4LzZKYWNGQnhybHRV?=
 =?utf-8?B?ODhMRjlUVy9JQkN1TWJoNk9yVmJpdzE4YVlHUmo3SXNvWDc0Q0ROQ1JzWlAv?=
 =?utf-8?B?VUJuK0F2amRHNEtWOVMxMUpZMDJ0a2ZNdWNveXZQZUJpNE9Ka1dYSzc4dTVQ?=
 =?utf-8?B?ME5xQjBjT2ZZZkNNTnNpZmJCakxFYkRmOFQzbkN1RkZubG80Sk9WYUlEd1Z3?=
 =?utf-8?B?U29CVGVwV0ZaRmZmTFRHeUsxYjdVTW5WTlVrYnlUS0tNUHJlVGUxNm45K3pG?=
 =?utf-8?B?SmJRdU9OR2R6MWplR01qS1hEZG11SmwrMzloKzR1TmptYnVENCtsTm1xNXYy?=
 =?utf-8?B?YnpsME8yRkRaR1MvZGhMWGo2LzVOdW93aFhTK09uMlNiaUpHNzlkS0FvdGVs?=
 =?utf-8?B?dnJPQTZ3WmJyVm9VUGxTYk9DRWlCSVdmWG43eDd2Qm41cjhWMCtCeVNNZFls?=
 =?utf-8?B?OTJranBHTmR6VWxxUkN2ZUh3MmlHa05hdVhNN1UrWm9SY05HalZpcXJBQ2hG?=
 =?utf-8?B?b2dTYjRUdTYxazVTYStzQWlWclMrcGxjNFdkcC91VEV2MmFTOVJUQ3RXN3J3?=
 =?utf-8?B?QllvSjRXNTh3TGJ1aG9WeENvMEpVZW1WQlBkbGhhcjRud3oxbU5Ia3lteXFU?=
 =?utf-8?B?R0J1cXdhNHFIekE3T2gvekFUcmJXNERDclQ5ZDRIQ2t0ZTBuWVhMODZWY2o5?=
 =?utf-8?B?cTl2NHV4NXNGc2JUWjNOTkJnR3Zkd1FhZGxzVnlrUExDM20vZ0ZROXd5L0hF?=
 =?utf-8?B?UG1TbU1TUkhKZ3FkcVNSK3I5R3hBVlBRRk9wdjdlNExHTTVNNGl6aG92ZUhM?=
 =?utf-8?B?YnhMU1pCRWwzdzJ6clpTN1hLYVNhU2hTYmRRVDhRN1BYeWVINUVGSkRzSmM1?=
 =?utf-8?B?bCtJVHZrb3owUlYrTnJXbnVkVGF1R3BwSzBkOTB0bEZvS016NkRPd2FGOU84?=
 =?utf-8?B?Sll4ZG5BdS9DOWpZakpIeGg2VW5nUXg0ME1uSXRodmQza2xSU090VC9jS0ht?=
 =?utf-8?B?Yk0xTWZmdE5uVld5N2xHL1JnYmdYWnBZc1NMdGFSS3dCTFpjemJvTE1Eb3hQ?=
 =?utf-8?B?c3Bkc2V6eEhGRmNwZ25DL3Z6aDFzWFVFRXpJTWlwRjlMb0FMNzFYZ3JWbzFI?=
 =?utf-8?B?QXlud2VRSEdyNWgxTDhmejR1dkNlV251L1E1YXFGSHNJc0pib0N0SUJ6bUJK?=
 =?utf-8?B?S1RFSEFjbW9CMS9RaUFBNUVFemRTR0hKaE5vWTROMm4ySGcvU2JXakFOVFpM?=
 =?utf-8?Q?TD1O2UD8Mw2DpaJbxM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96def49-3f71-45df-ff53-08def7977e7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:58:36.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOkW5xpOeO2+E+b7zczPavkb/gK+eXrVbQBnd4AAS6Yp9l6QmDukdC1IsZr3s0np
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
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

On 8/4/26 11:42, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Define the following ioctl structures and enums:
> - DRM_AMDGPU_GEM_SVM ioctl command and DRM_IOCTL_AMDGPU_GEM_SVM macro
> - enum amdgpu_ioctl_svm_op: SET_ATTR, GET_ATTR, RESET_ATTR operations
> - enum amdgpu_ioctl_svm_access: INACCESSIBLE, IN_PLACE, ALLOW_MIGRATE
> - enum amdgpu_ioctl_svm_location: SYSMEM, UNDEFINED
> - enum amdgpu_ioctl_svm_attr_type: PREFERRED_LOC, PREFETCH_LOC, ACCESS,
>   GRANULARITY, HOST_ACCESS, COHERENT, EXT_COHERENT, HIVE_LOCAL, GPU_RO,
>   GPU_EXEC, GPU_READ_MOSTLY
> - struct drm_amdgpu_svm_attribute: type and value pair
> - struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
>   operation, nattr, and attrs_ptr
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 106 ++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b32c72a662b61..4c49cd36f0e77 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -59,6 +59,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
> +#define DRM_AMDGPU_GEM_SVM		0x1B
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -81,6 +82,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
> +#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>  
>  /**
>   * DOC: memory domains
> @@ -1694,6 +1696,110 @@ struct drm_amdgpu_proc_options {
>  	} kfd_sigbus_delay;
>  };
>  
> +/**
> + * enum amdgpu_ioctl_svm_op - operation selector for DRM_IOCTL_AMDGPU_GEM_SVM.
> + * @AMDGPU_SVM_OP_SET_ATTR: apply the attributes in @attrs_ptr to the VA range.
> + * @AMDGPU_SVM_OP_GET_ATTR: read back the current value of each attribute
> + *                          listed in @attrs_ptr for the given VA range.

That this works on the given VA range is not correct.

To read out the attributes userspace needs to give the start addr and attributes and get the size the attributes are the same in return.

Only this way CRIU is able to read out the attributes from kernel to userspace.

> + * @AMDGPU_SVM_OP_RESET_ATTR: reset all attributes for the VA range to their
> + *                            default values. @attrs_ptr and @nattr are ignored.
> + */
> +enum amdgpu_ioctl_svm_op {
> +	AMDGPU_SVM_OP_SET_ATTR = 0,
> +	AMDGPU_SVM_OP_GET_ATTR = 1,
> +	AMDGPU_SVM_OP_RESET_ATTR = 2,
> +};
> +
> +/**
> + * enum amdgpu_ioctl_svm_access - values for AMDGPU_SVM_ATTR_ACCESS.
> + * @AMDGPU_SVM_ACCESS_INACCESSIBLE: GPU must not access the range; any access
> + *                                  is a fault.
> + * @AMDGPU_SVM_ACCESS_IN_PLACE:     GPU may access the range
This needs more.  only at its
> + *                                  current backing store; the driver will
> + *                                  never migrate pages to local VRAM.
> + * @AMDGPU_SVM_ACCESS_ALLOW_MIGRATE: GPU may access the range and the driver
> + *                                  is allowed (but not required) to migrate
> + *                                  pages between system memory and local
> + *                                  VRAM to satisfy the preferred/prefetch
> + *                                  location.
> + */
> +enum amdgpu_ioctl_svm_access {
> +	AMDGPU_SVM_ACCESS_INACCESSIBLE		= 0,
> +	AMDGPU_SVM_ACCESS_IN_PLACE			= 1,
> +	AMDGPU_SVM_ACCESS_ALLOW_MIGRATE		= 2,
> +};
> +
> +/**
> + * enum amdgpu_svm_location - values for AMDGPU_SVM_ATTR_PREFERRED_LOC /
> + *                            AMDGPU_SVM_ATTR_PREFETCH_LOC.
> + * @AMDGPU_SVM_LOCATION_SYSMEM:    back the range with system memory.
> + * @AMDGPU_SVM_LOCATION_UNDEFINED: no preference; the driver chooses.
> + */
> +enum amdgpu_ioctl_svm_location {
> +	AMDGPU_SVM_LOCATION_SYSMEM	= 0,
> +	AMDGPU_SVM_LOCATION_UNDEFINED	= 0xffffffffU,

Please make the AMDGPU_SVM_LOCATION_UNDEFINED 1 here and add a value AMDGPU_SVM_LOCATION_LOCAL and AMDGPU_SVM_LOCATION_HIVE.

The XE idea of giving the file descriptor of the device driver to prefetch to is a clear NAK from my side now. This whole concept breaks as soon as you add CRIU to the picture.

> +};
> +
> +/**
> + * enum amdgpu_ioctl_svm_attr_type - attribute selector for
> + *                                   &drm_amdgpu_svm_attribute.type.
> + *
> + * @AMDGPU_SVM_ATTR_PREFERRED_LOC: Preferred backing location for the range.
> + *	Value is one of &enum amdgpu_ioctl_svm_location.
> + * @AMDGPU_SVM_ATTR_PREFETCH_LOC: Prefetch target for the range. Value is
> + *	one of &enum amdgpu_ioctl_svm_location.
> + * @AMDGPU_SVM_ATTR_ACCESS: GPU access policy for the range. Value is one
> + *	of &enum amdgpu_ioctl_svm_access.
> + * @AMDGPU_SVM_ATTR_GRANULARITY: log2 of the migration granularity in pages.
> + * @AMDGPU_SVM_ATTR_HOST_ACCESS: Guarantee host access to memory.
> + * @AMDGPU_SVM_ATTR_COHERENT: Fine-grained coherency between all devices
> + *	with access.
> + * @AMDGPU_SVM_ATTR_EXT_COHERENT: Fine-grained coherency between all devices
> + *	using device-scope atomics.

> + * @AMDGPU_SVM_ATTR_HIVE_LOCAL: Use any GPU in the same XGMI hive as the
> + *	preferred device.

Please drop that one, it should be covered by AMDGPU_SVM_LOCATION_* above.

Regards,
Christian.

> + * @AMDGPU_SVM_ATTR_GPU_RO: GPUs only read the range, allowing replication.
> + * @AMDGPU_SVM_ATTR_GPU_EXEC: Allow execution on GPU.
> + * @AMDGPU_SVM_ATTR_GPU_READ_MOSTLY: GPUs mostly read the range; may allow
> + *	optimizations similar to GPU_RO, but writes still fault.
> + */
> +enum amdgpu_ioctl_svm_attr_type {
> +	AMDGPU_SVM_ATTR_PREFERRED_LOC		= 0,
> +	AMDGPU_SVM_ATTR_PREFETCH_LOC		= 1,
> +	AMDGPU_SVM_ATTR_ACCESS				= 2,
> +	AMDGPU_SVM_ATTR_GRANULARITY			= 3,
> +	/* Boolean attributes below: value must be 0 or 1. */
> +	AMDGPU_SVM_ATTR_HOST_ACCESS			= 4,
> +	AMDGPU_SVM_ATTR_COHERENT			= 5,
> +	AMDGPU_SVM_ATTR_EXT_COHERENT		= 6,
> +	AMDGPU_SVM_ATTR_HIVE_LOCAL			= 7,
> +	AMDGPU_SVM_ATTR_GPU_RO				= 8,
> +	AMDGPU_SVM_ATTR_GPU_EXEC			= 9,
> +	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 10,
> +};
> +
> +/* One (type, value) pair carried by DRM_IOCTL_AMDGPU_GEM_SVM. */
> +struct drm_amdgpu_svm_attribute {
> +	/** AMDGPU_SVM_ATTR_* */
> +	__u32 type;
> +	/** Attribute value; interpretation depends on @type */
> +	__u32 value;
> +};
> +
> +/* Argument for DRM_IOCTL_AMDGPU_GEM_SVM. */
> +struct drm_amdgpu_gem_svm {
> +	/** Start of the virtual address range */
> +	__u64 start_addr;
> +	/** Size of the range in bytes */
> +	__u64 size;
> +	/** AMDGPU_SVM_OP_* */
> +	__u32 operation;
> +	/** Number of struct drm_amdgpu_svm_attribute entries in @attrs_ptr */
> +	__u32 nattr;
> +	/** User pointer to an array of @nattr struct drm_amdgpu_svm_attribute */
> +	__u64 attrs_ptr;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif

