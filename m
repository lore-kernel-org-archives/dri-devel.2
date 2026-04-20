Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1AEF36C5F
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3D110E56E;
	Mon, 20 Apr 2026 12:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BA2fsnO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92CA10E56C;
 Mon, 20 Apr 2026 12:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk5vX6LBVfV9YGs+Kltr0+vgvK3Ws8lNCYT7hljihhYrhU7XOHrAIKwOc0kWsJhoNTx/zDYtnVGwHkG1ezC+NXAAtT65aMHufTf1c1sFRvLzYtJIE3DMpX0a/PdLAn6kvOCTioRVU6jw7szcO8iE7PwrT1bPa2AJT6KgpDwqNMwan30w9c0uxyBxuRkHi1ex168IobVE6de8LGxFyXPirERsNrHuPJLno0xDItJVE9I2O1y3TCb3Le9SzjqouOkvh7CG5fg0YwM0aJV4v8jwldE4GczpyMWm8ShU5ev5feUpwSjsBHXd3ebGeFMcVaQhCrGjzBsaRbfxE4+uZ6CJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2C9q2hLYw9QaLKLzTqQONdw035Lm+eszgb/bZXhMFs=;
 b=FzAEe6FrpSeM/mHgzUZO1C393LN2VQiKMU7quYtpG9BQ3QGY38rovDOvYjRCLgScj6GR9YYN7xOvs2k8mYxRxnXgVfHXDwMuSOiLCZf+tJDss9Hw3hEnkoASBAj5k1uE5RzlQohJD8idooEjwj/rFF9N4oECjQkHfp3r1n/s9N+BK/uUqm8uVazm1D91+E7m77LuOBzx2+97f+DBCGpXTzR5aGz+KM+jxH45cKwnk68cOGVNT13z8nETGYpmkpjEhVCMPYgdbUmsdxEOFvMl+7d02pDNXL4szkpUu99bCXJLeJJ2mBYHuWc+XOXxRSHvv1/Ve9Fqq/XmSy0wdURhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2C9q2hLYw9QaLKLzTqQONdw035Lm+eszgb/bZXhMFs=;
 b=1BA2fsnOZYk0gCNrCiH7kZVZdftlKfmFNP+rYYUuO+8mRhDOITHp3qGj/RQ2Pe/2XDZISLIb6XTK9ySgtEThbtyrS4uGEVsieJQef/LDfeT2/lEUvyejYU0J6qUxZSjOiDPg3YDH1Zsu6JeHq13jV8NHybPNkUIKjcwsRWbHEBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Mon, 20 Apr
 2026 12:15:12 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:15:12 +0000
Message-ID: <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
Date: Mon, 20 Apr 2026 14:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Honglei Huang <honglei1.huang@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, matthew.brost@intel.com,
 rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 aliceryhl@google.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 honghuan@amd.com
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420120739.1811731-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 80150017-4945-4d0a-7b80-08de9ed678de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RhLD42Ne0p7+8RGDUsK8p/yXMXRMG0JkAQPoFmFKl3FtnAItEWeGDLbpv/wTIMr3bd2RW07s9aeWboZSoEKIVchV/iBwsGFGuAm+gmakxTln6lB0+KU/b/4n8yNDPr4g3zUVOIda4mDQXLMH8fz61NsvD/NxsZS6TBYpBDZvZKdx0vEmGrWfGKg7c2nvuG3ZAZ0qVMZKQP9CHX3BB5aNObkbKCrv5d1rvlLfv5G2bJCsrUxLm5C89NDawQCAfTn3aInjhRLjitluHqqyrmIyGN0DYFSci66pE+GWIDGJTymMg4k/KFDpUlKEluIlze7cXNr+56YiKta2p6plh475J//S6LbCtJeanhIMiQnV3vh+ShKBSqVVmGHoygRK3gODBdRNkP1773N8qCelkKWiYQ5kABiC/dE9vuzqsz8ffclpnYaT14BFjsXT2ue99t7EAgZzjpYwd05GJ1Rt1EYn89/vT5DOICRSLxyHm2/DV//xALUWju1tFcPs+nAfy5dZg6y63SBRUAEdRmY32priUPPENCVuWBdDumXSYOp13BEkBHr86Fn2+18rmk3LFtrNHsNzYvMBRnG1APf564/aVSEKGOuORCLEQbb8GiCbpP4U7vIhoAfAERc94URJXE5kTwmEsLteiwIgV2mI+TtC66ZDeILKwE/Kpq51vmLDbYDfQNDNYrG9vhAn1so3b+D1muKhlzx1BAa1u/kclW3Hf7NxePt83KJjexC1hc9b8ie+gz6JMjt3SOAV2ROWCIFtggVSTWiYYW8Dfj8RqMH6mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2h3Y2pGSVVGUFFZTk8rRjlPUXRSTzlnN0EzYjl3NE9uN2ZMaHhubFh2NHFr?=
 =?utf-8?B?SFJkbndrYzgzSlhFL3FEN0NRSUxiZDVsY0lLOGN5NVRhK0l6aVFCY3VkMUQ5?=
 =?utf-8?B?bWp3UmFEME9UR0thUUIySDBRbTFNSDh6K2syRnA1ajlJSGlIM3dkaW85dENQ?=
 =?utf-8?B?cldmN29tK3Z3ZUZ1dWxjVmhqYnZrMG5BalVEYlRFZG1qTENtZElvTGVkbHlQ?=
 =?utf-8?B?RmN0dWtOWUdKQ0JCR2xodDhHTzNuQ3FIVnFodkdVVzZzY3F0YUtmbWE3Q2NQ?=
 =?utf-8?B?ME5iSW5NT0orSW9jb3lDVnoxV254Vk5YQ1c4U1o1Wlh6dWNiZmMxZk5hZnQ1?=
 =?utf-8?B?OVBRSlI1azlLOFU0bUQrSVFxbnE1TE1ySE5KZjY0RGxRcTFLdWR6Q05mcmw5?=
 =?utf-8?B?Wi95Qnc4dHRFSjZHeXpYR2dROVA1UkhpMVBFaXRyTk0ybmJtZ3NaeUE3R2k2?=
 =?utf-8?B?eEpmTW1ZdkhyNTlMeVRUL2lZeUJRb0tjU044dGkzdk1jTWNEVG9La3FIemwy?=
 =?utf-8?B?R25leVhyRnF5Z3M2Z1Z4N0VCRHZqcEphWUZQNjF6aXFwK1F1a1RrMU81aFk2?=
 =?utf-8?B?MHduRGxNd3BDVTZiMzBQQWtJOGZOOWIxQkdaQkdnMDQzcXI2ZFpnQTVsVHgy?=
 =?utf-8?B?YzNid3BTVm1Qb3JNd2xHd21LbERjV0RaSTVSR2tXTEZtbjBNVUVGaktYait6?=
 =?utf-8?B?bW56TnBsZG9kc2tRS251WE9CaWRheGlBVGpXR3NBckxGNzZORW1kem9Cb1dn?=
 =?utf-8?B?c01oT2NBN2E4ZmxwL2w3T2ZMNjdYbkZ1YnhKM04vQ2M3aEFkQ3U4MXdlNE1F?=
 =?utf-8?B?RHBoeTRxS0FCL212Y0xWZi9jTlc1UWNMZ3ExUFZiY0VieGdMOEtvR2NYckpO?=
 =?utf-8?B?WmZmNVMrc0ZRSDFTcVBZQ3FySG9KbjgrUldJUUNGL2FkL1QxVzJ1TGpwZW5p?=
 =?utf-8?B?UEkxL3BlUmFiWnloRHZTQzVSdkpSTFZZT1hldUxmRVo4STA1RHpVblBjSG9p?=
 =?utf-8?B?WWcycFI5WWhBUm9OZ3JoSDBJTHBGaURtSkxuSUE2dGV1MEpUVXNBOUNGd2tJ?=
 =?utf-8?B?VWxac1RIdzNCYktIRmh0VEJxYzB5MFl2TnJ3Mk9IU3lLOVNWQXkzWm1Db0xC?=
 =?utf-8?B?N2xDM2hZWUVHK1paY0hsQ1ZZSmkrNnp6VFNaV05BK0NROGorbzZyeWkwLzFS?=
 =?utf-8?B?U2lQS3FuNmtoNkxTVWtTQUJWTUxyWEZ2a3ZZOHpwalY1eDdSRG4xbWEvZGFw?=
 =?utf-8?B?eDc5eC95MkltbUlRK09mUkxMaWEwbnQxVkJWZHlVSFB1emRZcnRXbmFQZVQx?=
 =?utf-8?B?djEwejhQdnI4MURJcm5NMnpPM2tWSzRTeGVweTdmWmxVeGRnZldIUXhwK1pF?=
 =?utf-8?B?bnh3eHVhY3BUVXBVNU1na0pZMTZzd1dJd1V4MW1TVmVBT29pV2M3bjdxbFN5?=
 =?utf-8?B?alZLSWVVaHhWYTdXdmkvck5ISmZ6YjRhbm1Tc29QZlNVMitRNVhqY3p1c0ZI?=
 =?utf-8?B?azhHTVpXdlY1eXE1R2FZK0F6VFhmSXdEbENSU29SWnM3OUxDQStxb1VjeWkr?=
 =?utf-8?B?Nk1aOHBzU2hPVCtobkw3SDhzQ0pyQ21zbHgwa1RoZmluM3Zob1NIZGRPRDlx?=
 =?utf-8?B?WHJQOXBrL050WXhkRUM5bGpLa1NiT0J3OGpHSkVRMkNQZEc2eGdxL01neHVy?=
 =?utf-8?B?ck1rb2xERE5iQlV3MU1tWVE0ditqeG5Id1NjdDljcVBmdVhlbC8wZ1R1dVdi?=
 =?utf-8?B?U3o0NG1pejhmcCs2bnVtczNtNEthUnhsNFJwNXprUW5MZEFBS0JMUGs5dGZo?=
 =?utf-8?B?bFl4TTNQN2RxU3VpOUlxV2dvRDM1dHN0WWdQY2I5bHVPUDYzWmx6bTYrRlBC?=
 =?utf-8?B?cXZJNUZRbHgzL0NQMENlY1lkajJpL3lmMGhmS3dOdi8zTlJKWXBycXgycG91?=
 =?utf-8?B?NmpvTVdvNHlYWjVLbVJJckhUTGFvdkZtdWlzdWtUVDNGWkF4VVZXNlU0VkRB?=
 =?utf-8?B?WncwZmVSNEQxaDQ5R2Z2OW5NVncvSGU3SVEvYTAwVE5mWUpUS3A1YndoMHlC?=
 =?utf-8?B?Z2RPWHJDSWJkQWlYc24zTko0NG9pbUlZOCtRTkxFeXhwQTRPd0xUQnBJbml4?=
 =?utf-8?B?UTBKVjQ4T3dOemMxamtUNXJ0aER1ampYN3J1SmVvSFpGOGlubXM1N3dBMmJa?=
 =?utf-8?B?N3pUZlRPQnpoNWpod0l5T09oZWxtK21OT1IzZ0NWRWF1RlN0eTJwcStJWjZW?=
 =?utf-8?B?TGdEckFqQTczZ0Rlck9wTXNTWGpNeDdVcHJiSllmaWZoRThvSlRqSDk1QjFY?=
 =?utf-8?Q?Z4RnMepEvVTsYMfxWF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80150017-4945-4d0a-7b80-08de9ed678de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:15:12.2482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWSQb23ZhsCCSJg5WkO8VyGg6r2LTfKDO6qJqm39teVjlTSKmiT/0l4+gwl7zD4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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



On 4/20/26 14:07, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Add amdgpu drm SVM API definitions built on the
> DRM GPUSVM framework.
> 
> This includes:
> - DRM_AMDGPU_GEM_SVM ioctl
> - AMDGPU_SVM_FLAG_* flags
> - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
> - AMDGPU_SVM_ATTR_* attribute types
> - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
> - struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 406a42be4..bed71ed9b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> +#define DRM_AMDGPU_GEM_SVM		0x1a
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
>  
>  /**
>   * DOC: memory domains
> @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
>  	__u64 matrix[12];
>  };
>  
> +#define AMDGPU_SVM_FLAG_HOST_ACCESS		0x00000001
> +#define AMDGPU_SVM_FLAG_COHERENT		0x00000002
> +#define AMDGPU_SVM_FLAG_HIVE_LOCAL		0x00000004
> +#define AMDGPU_SVM_FLAG_GPU_RO			0x00000008
> +#define AMDGPU_SVM_FLAG_GPU_EXEC		0x00000010
> +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY		0x00000020
> +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED	0x00000040
> +#define AMDGPU_SVM_FLAG_EXT_COHERENT		0x00000080
> +
> +#define AMDGPU_SVM_OP_SET_ATTR		0
> +#define AMDGPU_SVM_OP_GET_ATTR		1
> +
> +#define AMDGPU_SVM_ATTR_PREFERRED_LOC		0
> +#define AMDGPU_SVM_ATTR_PREFETCH_LOC		1

Up till here the interface makes perfect sense, but then it becomes a bit fuzzy.

> +#define AMDGPU_SVM_ATTR_ACCESS			2
> +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE		3
> +#define AMDGPU_SVM_ATTR_NO_ACCESS		4

Why are those separate attributes? What is the difference between those?

> +#define AMDGPU_SVM_ATTR_SET_FLAGS		5
> +#define AMDGPU_SVM_ATTR_CLR_FLAGS		6

Why is that separated into set and clear flags?

> +#define AMDGPU_SVM_ATTR_GRANULARITY		7
> +
> +#define AMDGPU_SVM_LOCATION_SYSMEM		0
> +#define AMDGPU_SVM_LOCATION_UNDEFINED		0xffffffff

No location for device local memory?

> +
> +struct drm_amdgpu_svm_attribute {
> +	__u32 type;
> +	__u32 value;
> +};
> +
> +struct drm_amdgpu_gem_svm {
> +	__u64 start_addr;
> +	__u64 size;
> +	__u32 operation;
> +	__u32 nattr;
> +	__u64 attrs_ptr;
> +};

Those struct make perfect sense but clearly need documentation. Preferable as kerneldoc.

And we usually use unions in this header to separate the input from the output parameters.

Regards,
Christian.

> +
>  #if defined(__cplusplus)
>  }
>  #endif

