Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FE606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R4GyU30K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CCD610F225;
	Mon,  9 Nov 2026 12:26:37 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BA510F225;
 Mon,  9 Nov 2026 12:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQN1veFoKCI3sSOPIoeyfJ+svQZKC/8gXf6xLF5aeHSCjhqT9q9wI5Ni+WNA4qgOXfBYE5MfvldUzsEOzLvLojgqVAtRQxbTxegtYaql2KylFnV6gxSm8rk7En0DG/cKu9LunVamscpvCbt3jHbCkz9ajVruO8k27Xdq+vb1ASkSeFr87zeVNsbYSYaohEHjbCGHpWcyhSoGhi717w6WDIxqNGzUV6zy/EBGe8wVoy/hatQXCkdWI3eU488r4xBkDmgoq1Tuvf3WzgCeMByWYeEu6qJuoIJCH9YFJAlxYKQOdDesBDanbISDPxzUMRUiMmKPE42WZB1OpE3IPsEUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7VewC7lQJnFRNJhbkXtssqbhVGJMNBW13bV8xpwKRE=;
 b=ZCRqkk4HkHe4k51cTvJOpUqdBZRU1dEzmX4nef9D7GChLvTYCQVIytdQ8/djMJhfR9160V8hkMncAU6l0YMS/DALR2dO2lF8iWTFAJHqwEc2vt84ZTyfSfwYxrXds9NKFLWYrr8dyCGaR9Wil+MID4mFGKn1Acy8RxyY+BGYynvjETbNjiHelZh6f+oWmUnqctoPfunGEZ4syU55Gyqu8ewwWtrNVwp2ZUx4Y+n9q6wERq3AdB3tS6DOf00fGN372+dANMUohykdYfCkkWQ2VXV3LmoR+T4k0ayitmcjsDuMY06SUj0WIxAcT5JiiEh7aaFpBYw+3tQWvhROCJkH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7VewC7lQJnFRNJhbkXtssqbhVGJMNBW13bV8xpwKRE=;
 b=R4GyU30KfkBLRzMR4Yj/aH+UKCgXrTshUXdq4JB4SqX72+VSVApYvmAbPy9QWKxaHQ+M0XGo9p+kn+8Pp+4qHZLnsVm/w5mEYGA6yR9LtYRucK72OqIthd5makArhcT3igR1mgWNVEbaZUGIhUUB7sZ49pnOR927E3fxog7TZOA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB834210.namprd12.prod.outlook.com (2603:10b6:806:517::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:26:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:26:29 +0000
Message-ID: <f6c7edfa-232d-43c7-9da1-8634ff62cb46@amd.com>
Date: Mon, 9 Nov 2026 13:26:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/22] drm/amdgpu: add SVM ioctl UAPI definitions
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
 <20261021025915.2433837-2-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-2-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB834210:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe457b0-3e63-4a53-b0b6-08df3e5cade2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|921020|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: QSWgZ1FILX1/RwkimYbmv0FudMiwITyTtJVOUt8BOFH/7wDHM8FJ/O8xFa4FX7j3TLTITDbbbZ/tfIhJKZPuq6I/jn4wMN9+nBz5Rs/AdTchbuHk6LraMNPpv9wePemq15ieRhsaxAI010C0uHOnqUQRSZWoS/GokZFDMFKJRr8f6yAuU1wN7QaOSPCT04IltRvP+11jjdjPtvAxxHtu/kB5TiFWADTWksAe9Amw6djQOhxNUkav0kEt4EBGnuQraYkJ8+2Oo3paFkeCx8wqBWHpU9rOSBflHN/QVg+wxeGxt80Ff9j0yQbkoQOOAZcgGfnDP3/jPwmTiqYFJPYx/oaa31FPfs4CucdKUWcSPOPg0utZq/P2GawwH/RAzDqS54IQxrqEcseKXp5TxqKHl7kgL6NwFabbRS8ZYwQY8dV8NbyHt7MUmpJ2buABV/EpPHDHdBtvd8uM2Haml5emqmEna/EJ95HO3/FNqLAh2eF0IngJhd3cticsm2QKvtGg0JzX+zI7tG3sCJg6a9s9kzAeoXN9VdlvtlAhb1qP0G3kCUVCXy+yz9BYRMeStntIvnSsVeE8n7LhoSFcwru5zlfPM5ScMoHk9yf+A+r+3jrsoWevMDDK6bKOeq5AP9P1CYuXgMEwG1WREv/VhtyoeqeQadTW8HVMmNvzxxBhjqvXxafCsKb6NO99Y5ijhqFE91yBJzkEHhgMY1TP4SI3LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpyeTQrNDk0a055MGRzMFIvK1V2WGVNRUdCcjNocW1rd1ppSTZhRk95NWlI?=
 =?utf-8?B?UXhPdmxLMEgwQ2E1RkczbXpEM3Y4NUVFeVJUTUFNZFY2VWU0NWZ2SWhScGQ3?=
 =?utf-8?B?bG04ODRrUDhoZWlUQ095SnFOOXpRd1dEMGxYNkdxY2tGTDVUWkN2UlBHTjBU?=
 =?utf-8?B?ZzZuYUZIcjJpVXcxandRUTZKY1lob1V6cThRRVFnQ0x4Rjk5QTdhRzZiMUp5?=
 =?utf-8?B?SHptdS9vYmJLWXFaT2xBZnh5ZGNIUGs1UEJtUUpQZTBoNTNHVHNCUkxjcHhm?=
 =?utf-8?B?S0NTTXFWaU1DQ2gvdHU1OGlCVDhrZ002cUdRdnlKQkloSnNza3BmQlBiTlFR?=
 =?utf-8?B?V1l5TzdmTmtSb1pGb3BjbXluZlJ3WFdtMXRJWUdIdmRiaU5KRVRuUW00QjJa?=
 =?utf-8?B?UkY3QVhKU1FDUUZvTWFVQXYxejRCU2srSmdQWWsvK0tvZS93L3grTC9DbnVi?=
 =?utf-8?B?dHo4d0U0U3lIbWxzcDlnbmI5eHQ2bkU1ek85S3BTNVpYTWE0UDg2ZTI0bTgv?=
 =?utf-8?B?NTI3U3NFNEdtSDBVNjZLRXlsM3R4aUpyb2VQeUJjQlhEcWdkM0lNYnJTR3dS?=
 =?utf-8?B?eTdUTkd3VDIwdlVzUDhxblZxUUZBODJTcyt3WXZUb1JreUFzVHA4eEJKdlhD?=
 =?utf-8?B?eWhUUlc3MWNNaGprN3hHdy83SFdaTFlSSC9yZ2hGYUM2NTJOR3NqRmJ1ejNY?=
 =?utf-8?B?NTNFaUdLK3lpM3REWmUwUDJ2cVg5eHpDNlBIc2JuY3JlMkN0c0xIZjZ1SlFV?=
 =?utf-8?B?c0dyQ1VNWjZDdGdWaWZEaXhKR01ReFNuOEYxRXlFem51ZThBcUNBeGllS3pH?=
 =?utf-8?B?L3lsSi9vRXo2VHFUbmY2dVBBMEJlZWpkb3FodEk1VE5OOElNRit0KzdvQjBw?=
 =?utf-8?B?OHliQW85bStnZGZZcnhwUWpQRWNlbXNoak5LenVNNHBZZ1NhWEZmVEh4dlhF?=
 =?utf-8?B?SXNOU2tpdE5FUVN4aFpKdFpnSGt6S2ErNWYrcDc3dkwrd2RLUHh2dmdIdEhD?=
 =?utf-8?B?VmF4dm8wanhkWXIrUmVZYzFEMHpKSWR6dXNSazZ0Z1lCT1dvR2dob2hyM3JE?=
 =?utf-8?B?SXpvUzllcnRtVG95WStpM2txK2FOQk9nc2kwdUREb0RsMkdVTXRsTm1lVVZa?=
 =?utf-8?B?aTBpVzR0Q29QbzZRb1JrS0ZxOUYxazFBTWtMT2xuQ1dKVUdvTG5CRkdaTmR4?=
 =?utf-8?B?Qzg1M1NjbytDVVhTYnQ3cTY3QVRTdTNUU00zckR2VFpQZ09keTdQdmsxeC80?=
 =?utf-8?B?SDdrdFMvNUxhTy8wVVp2dmgyQXNKNmhZaDNoT3owL2tDVVhTTEZ4bkdVZytO?=
 =?utf-8?B?QUpuREdMM2pZSnBWWU83Umo0MGFyTnZjSlQ5QnRhaHFDMFdHOEREa2ExSDlB?=
 =?utf-8?B?Z2ZqZUJPa1JCY0pQRUR6SlNwSU9jem02d2F1UEdVMWJYWGd0cmlPZkVweW9P?=
 =?utf-8?B?emp6Y01MdXdVRmVqL3Q5M0J1WnZocE11MlFhSCtkR2o5bUIySEdvTXpod1VW?=
 =?utf-8?B?Uk5JN0Z5N3dlWURBc1dDTXNzLy9hUGkra3VVUVdRYjhyYUsxMUM1b3cvZWNX?=
 =?utf-8?B?SzAxUzJ1eXd0MURvQUtPMjFhdzRWelYrbkNKbk1zb2kyZXp2eDRvdnpCOUt0?=
 =?utf-8?B?LzRGL3lkN2N3aGcrQW0xMnJlM3lwVFFYVmtRRkE4QklWSTFRcGlDMGE2WFNn?=
 =?utf-8?B?ZktYMEtZN0UrM1c2SjUzMDY4RTJyQXJCaGVwWnVKbW96WHlvbEZQS1BYMXBx?=
 =?utf-8?B?RnRHR1gzNjBsMEtPVUpQTGM3RXRqQWlNVXo3YnRFOExnemh5Uk5JdU1LRVlH?=
 =?utf-8?B?MktnUTQvVmg1ZjVUdWRCM09PTzNJdDVJOHMxK2tiWHJzckNqbWFGbGxiaDFk?=
 =?utf-8?B?R1lrQUt2RDloMUVqYlpRb0xzaVZZWFBtRytadjB1SWJMQS92b2psUzR6YUJp?=
 =?utf-8?B?KzFtdHZQVnRzemlkKzhIQlhOSFpwVjRQVXM1S3FPK0t4blQyVVAxMkRhbGJy?=
 =?utf-8?B?NkJvdVJwOVYyUGRhS2FyVC9YOGluYStROHBZNW1uOHB2Y1Nka3JhR1cwSXJi?=
 =?utf-8?B?NG1Sa2tQazViTkErYTIreEUrem4vMUdBMXRUdHBpVGJlTHNYL3VxU2JidGUy?=
 =?utf-8?B?dUxTQXdOR3pJbjRDcVo5MlZhNUlVNStkT3ZxaTljMzFpZmZFMUtqZmtqNXpU?=
 =?utf-8?B?UE1PWWxLcTRDZU5EejZDVHNjSk1WVmZtRXhPTVdNRVQvTlovWFVDdmFDOTRH?=
 =?utf-8?B?YlBTeENLSTNJQlA1SWlBckZJMUJYZy9wUzk3VDVIekNkdzdkd2RyeGtaTC8v?=
 =?utf-8?Q?WvY+MnovviMGTgfHxM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe457b0-3e63-4a53-b0b6-08df3e5cade2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:26:28.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEGJlgZGI5vuWOQ8gaJVqFG2RWrOXcx9oy45FUGra4K2kkhg7pN63fTbAQUdqgrk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB834210
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
> Define the following ioctl structures and enums:
> - DRM_AMDGPU_GEM_SVM ioctl command and DRM_IOCTL_AMDGPU_GEM_SVM macro
> - enum amdgpu_ioctl_svm_op: SET_ATTR, GET_ATTR, RESET_ATTR operations
> - enum amdgpu_ioctl_svm_access: INACCESSIBLE, IN_PLACE, ALLOW_MIGRATE
> - enum amdgpu_ioctl_svm_location: SYSMEM, UNDEFINED, LOCAL, HIVE
> - enum amdgpu_ioctl_svm_attr_type: PREFERRED_LOC, PREFETCH_LOC, ACCESS,
>   GRANULARITY, HOST_ACCESS, COHERENT, EXT_COHERENT, GPU_RO,
>   GPU_EXEC, GPU_READ_MOSTLY
> - struct drm_amdgpu_svm_attribute: type and value pair
> - struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
>   operation, nattr, and attrs_ptr
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/amdgpu_drm.h | 127 ++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index cd1b8034a2fb4..cfe463f2114a1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>  #define DRM_AMDGPU_UALINK_HANDLE	0x1B
> +#define DRM_AMDGPU_GEM_SVM		0x1C
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -83,6 +84,9 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>  #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
> +#define DRM_IOCTL_AMDGPU_GEM_SVM	\
> +	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, \
> +		  struct drm_amdgpu_gem_svm)
>  
>  /**
>   * DOC: memory domains
> @@ -1735,6 +1739,129 @@ union drm_amdgpu_ualink_handle {
>  	union drm_amdgpu_ualink_handle_out out;
>  };
>  
> +/**
> + * enum amdgpu_ioctl_svm_op - operation selector for DRM_IOCTL_AMDGPU_GEM_SVM.
> + * @AMDGPU_SVM_OP_SET_ATTR: apply the attributes in @attrs_ptr to the VA range
> + *                          [@start_addr, @start_addr + @size).
> + * @AMDGPU_SVM_OP_GET_ATTR: query the attributes at @start_addr. The caller
> + *                          lists the attribute types it is interested in via
> + *                          @attrs_ptr; the kernel fills in their current
> + *                          values and updates @size to the length of the
> + *                          contiguous range starting at @start_addr over
> + *                          which those values are constant. Input @size is an
> + *                          upper bound. This lets user space (e.g. CRIU) walk
> + *                          the address space and read back all attributes
> + *                          without knowing the range boundaries in advance.
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
> + * @AMDGPU_SVM_ACCESS_IN_PLACE:     GPU may access the range only at its
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
> + * enum amdgpu_ioctl_svm_location - values for AMDGPU_SVM_ATTR_PREFERRED_LOC /
> + *                            AMDGPU_SVM_ATTR_PREFETCH_LOC.
> + * @AMDGPU_SVM_LOCATION_SYSMEM:    back the range with system memory.
> + * @AMDGPU_SVM_LOCATION_UNDEFINED: no preference; the driver chooses.
> + * @AMDGPU_SVM_LOCATION_LOCAL:     back the range with the local VRAM of the
> + *                                 device the SVM context belongs to.
> + * @AMDGPU_SVM_LOCATION_HIVE:      back the range with the VRAM of any device
> + *                                 in the same XGMI hive as the local device.
> + *
> + * The location is expressed as a fixed enum rather than a device file
> + * descriptor on purpose: a descriptor has no stable meaning across a
> + * checkpoint/restore (CRIU) cycle.
> + */
> +enum amdgpu_ioctl_svm_location {
> +	AMDGPU_SVM_LOCATION_SYSMEM	= 0,
> +	AMDGPU_SVM_LOCATION_UNDEFINED	= 1,
> +	AMDGPU_SVM_LOCATION_LOCAL	= 2,
> +	AMDGPU_SVM_LOCATION_HIVE	= 3,
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
> +	AMDGPU_SVM_ATTR_GPU_RO				= 7,
> +	AMDGPU_SVM_ATTR_GPU_EXEC			= 8,
> +	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 9,
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
> +	/**
> +	 * Size of the range in bytes. For AMDGPU_SVM_OP_GET_ATTR this is an
> +	 * input upper bound and is updated on return to the length of the
> +	 * contiguous range starting at @start_addr with constant attributes.
> +	 */
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

