Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A127606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fX3ytTrz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E7710EF3E;
	Tue, 10 Nov 2026 10:02:04 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920FE10EF35;
 Tue, 10 Nov 2026 10:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwkAgjkw/vRyAQRGwFg8OkWSJjV8iJjM2LTOpO3SNY+NUNGGAFZNcRh/yFbYDxkYs/48LDQTotZwYA3Eh24+x4ZMUedUvfc4CCafFAiZEUllxBYnf12BDAdYfXGYGe6eonWROlasLTGXR1/jDiqnte/TKZ7Y5YWAtw/cz6bojJSzIrTIHJlOOoUri0iNxAZ4oJ9d3QDLo66NVW6A3C0c9t2vqtzfuyAa4gMtlixjgvB62dCjRbtr+72MmAEWTiWVTR4NXqnkEuGxU5CK+914OCZPVgR+k6mSi81FZ03mT9DJ7M1YpKOnDvOZFLPc6V7pIHm57dPGpj2mAE9UXVsuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljIjac9hUuqmxiVWwEbNkNgYqW87HLQm+39oUSEKh1Y=;
 b=xvN47yEWyhtEs3WTIx9Ihp8yRhG3B7AFkeAMSfBX9DKeI8NqA+PQEkk0BbEDvskfORZPmDy5vf9KjwkSAUb+uMCBVuk8M5WMrY8mrX8M4DcuDXBbF0cFt5wtIQiX9jR4ah9zFgIaIsW2EQFnUD4W5Jsgi7apm7VTwnBeIWC6By/BkQAx8p1drrF98Y0e0GIRaUehgSX1c2KTuk5heXZ4YvXewIHQHy/zhgy01SS7gwWshJKto6gcwDQFPtFLSiGYtcrGSZa1x+NV5QhxJFbuu3Bo15ptnfIx8VHSa+gQFzPgX+nWdg96EITG+TvHr1TPybDfSQLGKkXjr3UfKthWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljIjac9hUuqmxiVWwEbNkNgYqW87HLQm+39oUSEKh1Y=;
 b=fX3ytTrzNdh/ZlTY/W/sZStHsvDVdIwAAqX/dUchsmCk1jqIBsAfN3YoPbjo09ReiW1MsBcz4ns6h8R4yi7d059waJLUF/S1UB10UDiWv3m7OzrwTRm+1nKwWmQ5VFT3DxOfomihpnJCum8sXO1x0vwEuPZR8aHbTRWwfy20cDY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 10:01:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:01:53 +0000
Message-ID: <8e63dc68-065a-457d-9cce-68d68a952a6d@amd.com>
Date: Tue, 10 Nov 2026 11:01:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/22] drm/amdgpu/gmc: add get_svm_pte_flags callback
To: "Huang, Honglei" <honghuan@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-7-ray.huang@amd.com>
 <facb3939-a692-42a9-9d42-a5eafbfb0400@amd.com>
 <dbe3f45b-442b-4677-aa9c-8c3f2fbdda8c@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <dbe3f45b-442b-4677-aa9c-8c3f2fbdda8c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e925c3-5fdb-40a8-7c52-08df3f11a57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|10067099003|3023799007|4143699003|11063799006|261009223027099003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261009220027099003|261009221227099003|261009221727099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: tltoosotDCuDe+8F6LfZSNtqnrN1ZP7oWWddF2axPw7w+qefJGNEMxCqit6E/a+TJKAdlZ8r/mSXEnkM4XJS14Q/HdPvutAbty5GIzNzciGRbBMVhD6NmUcOcXP+KMhX+Vitz2EGJ1LmOVy5WJXijnjjmaeSdf9wWh/E/2rOW0hW35BlvZhUfLijGtUHZGqs1d0gY2T/EtCMY0rfnEA0mWhtyfXt1bTlUcGOJDz8OysQVP/XjddIRhSsSwPScELX5hEEJ06g0Lg+w7MtMOSSWXJQzqOzkPsLsUgA6MFrw62j9zWxnY0RzVi4aiWo4ArfI3Eaa41H7ZGb4WscSlRyQMmTejWyad9oPrBtP30gV7fw5/LW8SAD+ROPDLuQfQuKqNvksamAFZ3xpeDThYHe8GuDSRkr1aG6NutEByUd8W1DFU4bb/TTW5Ayj7CmNrfoAXV5ARTmTtJAiAc6+W6sg+rGXyd2/vBIs40q3a8Bs5rZUecmKAO+8QASwnP75YBKky9iOMD8/l3uf/aWHSW7N0b1u2Cq6lFotc7F5wopVCTxiuQbINFVFDJUphypNOtv1pYj7qcR4YIv0UORqlgDDIatYGeMSC0HZakBY9xeM0NVeoCkD9HIPr2loaHVcZCzxYjpfhY+JgEKQ3yJrxlOzrexgV2IU8znR1s0WH1XLXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9DUjd5ZS82c3RPcVh5VE5DOThOQ2VsUGI5TzV6WnVpMldkNHB6OHFVQVBE?=
 =?utf-8?B?M1J3WUlPd0dVNXpNNHdFUnU0a1FwVTdXOFE5ZG1kaUV2UE9xSnhwM3J2V3Zs?=
 =?utf-8?B?bzFpY0U2RjVDbmNJK2hRR3cya0QrWjcyVmhCUWxCL3VoYUQ3MjgwaE02WXhj?=
 =?utf-8?B?YWppWkN0YkxSMm9ib08wWWNaYjQ5T1B6Z2cyK216R2hUWUE0TG4rZlBzTEJT?=
 =?utf-8?B?OXg2Ukl0SnBQcWdmcnJkNkE2dWtmWGo0R0VWSy9NMGVTOVFHNlkxWkNiQ1NE?=
 =?utf-8?B?QVQ5a05JMXUweHFMWHJPREsrUis1TTNyUHpqVWRoZ09pVi9XbkNBYTl6bmc2?=
 =?utf-8?B?NjB6dDREWkIreUY3MnhGTTdBT3pva1BwUFp0NjVqclNhVG96eGo0L2ROL2pn?=
 =?utf-8?B?SEZOOE13WENib1o5ajhKcFRDVFF1Z3p0TXJKSWRtbThEUFduYnB5ZkNaZUF5?=
 =?utf-8?B?QW9VcTRPTkNST1N6T2tRZlZraFRpaUIyYlpNZXMzajVsQ3dVY0RDWWR1NGFY?=
 =?utf-8?B?NTZIVjlRa21RenpWR0pQZk1jbXJNdVpNY0t6c0RUY29sOVNFU0VPV2Fka0FZ?=
 =?utf-8?B?VTdaRGNGUU5pUXM2RmsvL1FHWHhRVVVrTzh1aU1CVTZDcUZCK3lPUHRpckNh?=
 =?utf-8?B?cEltZkZURHJtUU02K0tqanFQcGlBMktOa043NTdwZFBFQWM1VDdIS29EMU5B?=
 =?utf-8?B?OUNHS0EybFZUWVdkMGFyQTVlQWhreVRBSjk4RjVYYzJCVGkyRXpZY29MWGhC?=
 =?utf-8?B?ZGNUVHhYZ1dSVTVibkdpNzRYUXZZanBqOTU4UW5teDV5Tk12S2tyd3dGZEVu?=
 =?utf-8?B?Zm9sazVJRnYyVzhEMHU2Q3NYdHBSSTZ2aHAvKytvSzNWVUJ5a0syWndmcjhz?=
 =?utf-8?B?UW5pZEo0UXhKZ0FFbXZRUm5jNTd0c1dEL1EzWFdhNThmMWlsWFpKRmgyN3Fy?=
 =?utf-8?B?bUtySVlXVFRDNXg0UEtQb25Ua1VtRGMvUVVkYk5EeXNsOSs2T1ZJVStMaDd0?=
 =?utf-8?B?U1VSU2xEQnJaK3FBRUlnWEZMWDRSa0VEU09ERWlGOXYvSUZVeXJsUHpUMGg3?=
 =?utf-8?B?S1V2VE1OMlhDZ2g4RnJNOEMxQVlvVEFyYTJiS2xVOVdTZ24yODZFNXJYN3Ur?=
 =?utf-8?B?bnA2aGVhMU93R3NTQVc4dGQ2NVg2MFBYaXBZKzl2WFRlc1diV2xENzVjaUZL?=
 =?utf-8?B?ZVNEREt1dnlXaDhJMnk2TEprdkExdmJxcGJtRWFiclBheHdpNGU4VmF5bTQx?=
 =?utf-8?B?TkxiUk8vVWdrRS95QzFkWFVvbDM3RXZRUy9Pd0JXTHU5UFFtSGxUNnRYQ0J4?=
 =?utf-8?B?cENLdlpYeklEQUlkUVlxd2xvUFUrZDNMRzRqT0ovK3JPZVFwWmdBZ0VyQmFZ?=
 =?utf-8?B?dVVkSmZOUVNEb0pzTHVWWXV3ai9rMlFxNjdXeG9RWCtHUGRXb3M0Um5qWmlp?=
 =?utf-8?B?Snp0dXJsTmFsOHJkMVdmQi9xRlRHREFnR1N3dkE1dWVnVE9Ba1RFd2FQcjdJ?=
 =?utf-8?B?Z3AzOFpRSHFEbGFhaFZMWUFxbXRBL2Zacy83TnV0MC9qSHB0Y1dIckc1cDM1?=
 =?utf-8?B?Nzd1T1I4aWdOT3JyQUdDRHB5MXVXUWpDN0JneEJKaUlMVDVKOVlBeTgwSmlM?=
 =?utf-8?B?d1N4aGJkc0NYUEhFUndDdUtrYlhqVEd0bkY1dENtUmNmTkkvNzNpOXNzcmt3?=
 =?utf-8?B?WHpCY2oybEpxdXQwSUVKaHcwUjNnSDlna0xQakNUeEpidzlBZnIvdDRLT0Yw?=
 =?utf-8?B?YndOd0FpeEpWNllNaUExbGJvOFhFK25CREtoWm5MQ2lKbEJpQ1hsQ01jZ2NX?=
 =?utf-8?B?R00vVHBHSzlVM0ovMjdXY3ZYOU5NWGZLK3J2eDJaOXRrMjBVWHE2aUwxMDFB?=
 =?utf-8?B?UUVCKzY0S2NsaU1uNmRGNXUrTXZaS3dzOFJaMFJGZUdwZHhBbDd2RkVDNSts?=
 =?utf-8?B?UDFsNENXTHVnQXIwZFAvSXB1Y29KZzlJQjY1Z2tnZmIrSlNMeUdBTDRPRG1i?=
 =?utf-8?B?SzFkcWpWVFE2bFlqRjZKdHBwNzZRUzEwT3VRZGdGMU9Tall2UjRkNTZjRktm?=
 =?utf-8?B?Vzk1Y0d4QXMvSlh1NUt6c0FzZDNEK3lXQ2U1Qmx2b09aRlhuZFcwZzg2UDRl?=
 =?utf-8?B?RHYzcnVQQVdNakZOcHRNSVo5czlrUFhmUEh3M1psRnNjbTNlaCtweTIxck0v?=
 =?utf-8?B?VDNlcEVLZ1p3S1ZDZWhVWDRjTVJSZ1dFc2JxTmpid25hUlVIbUtOZmw5Nzdj?=
 =?utf-8?B?dU9Uc1hkWGVWWWFVc05xZGdQek8wUFlrRlN6aHpiRys2MjJ5cTVrT0UwMmpw?=
 =?utf-8?Q?Jf3oh/2X7KO7V9grBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e925c3-5fdb-40a8-7c52-08df3f11a57c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:01:53.7082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvHbvn83vrdQnVCTW/Zl+TA4o+r56Ve//zqFL+curLx5qEdinCZPm/JwRTGW3+Cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 07:57, Huang, Honglei wrote:
> 
> 
> On 11/9/2026 9:52 PM, Christian König wrote:
>> On 10/21/26 04:58, Huang Rui wrote:
>>> From: Honglei Huang <honghuan@amd.com>
>>>
>>> Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
>>> mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
>>> and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
>>> MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
>>> of the SVM core, mirroring how get_vm_pte handles BO mappings.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Suggested-by: Huang Rui <ray.huang@amd.com>
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
>>>   3 files changed, 212 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index cffd5ca3fc66b..3f668fb71a632 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -150,6 +150,24 @@ struct amdgpu_vmhub {
>>>       const struct amdgpu_vmhub_funcs *vmhub_funcs;
>>>   };
>>>   +/* Decoded inputs for the SVM PTE flag selection, gmc_funcs::get_svm_pte_flags */
>>> +struct amdgpu_svm_pte_flags_params {
>>> +    /* SVM attribute: coherent */
>>> +    bool coherent;
>>> +    /* SVM attribute: extended coherent */
>>> +    bool ext_coherent;
>>> +    /* SVM attribute: GPU read only */
>>> +    bool gpu_ro;
>>> +    /* SVM attribute: GPU executable */
>>> +    bool gpu_exec;
>>> +    /* mapping is in VRAM local device or remote P2P */
>>> +    bool is_vram;
>>> +    /* mapping is in this GPU's local VRAM */
>>> +    bool is_local;
>>> +    /* remote VRAM BO is on a GPU in the same XGMI hive as this GPU. */
>>> +    bool same_hive;
>>> +};
>>> +
>>>   /*
>>>    * GPU MC structures, functions & helpers
>>>    */
>>> @@ -178,6 +196,10 @@ struct amdgpu_gmc_funcs {
>>>                  struct amdgpu_bo *bo,
>>>                  uint32_t vm_flags,
>>>                  uint64_t *pte_flags);
>>> +    /* get the full pte flags for an SVM mapping */
>>> +    uint64_t (*get_svm_pte_flags)(struct amdgpu_device *adev,
>>> +                      struct amdgpu_vm *vm,
>>> +                      const struct amdgpu_svm_pte_flags_params *params);
>>
>> That looks like a really really bad idea to me.
>>
>> Please add the SVM flags to the existing amdgpu_gmc_get_vm_pte() function.
>>
>> Additional to that you also need to modify the destination addr and not just the flags.
> 
> Will change to existing amdgpu_gmc_get_vm_pte function

It might be necessary to rework the existing amdgpu_gmc_get_vm_pte function to get the BO flags as parameter instead of the BO itself so that it can be used for both use cases.

Maybe split that into a separate patch.

Regards,
Christian.

> 
> Regards,
> Honglei
> 
>>
>> Regards,
>> Christian.
>>
>>>       /* override per-page pte flags */
>>>       void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>>>                         struct amdgpu_vm *vm,
>>> @@ -378,6 +400,8 @@ struct amdgpu_gmc {
>>>   #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
>>>       ((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
>>>                          (pte_flags)))
>>> +#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
>>> +    ((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
>>>   #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)    \
>>>       (adev)->gmc.gmc_funcs->override_vm_pte_flags            \
>>>           ((adev), (vm), (addr), (pte_flags))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index 0cc73982ed6f9..a541173e34a4e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -551,6 +551,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>>>           *flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>>>   }
>>>   +/*
>>> + * Mirror of the GFX12 cases of svm_range_get_pte_flags(), with the
>>> + * per IP logic kept here in the HW specific file.
>>> + */
>>> +static uint64_t
>>> +gmc_v12_0_get_svm_pte_flags(struct amdgpu_device *adev,
>>> +                struct amdgpu_vm *vm,
>>> +                const struct amdgpu_svm_pte_flags_params *params)
>>> +{
>>> +    uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>>> +    bool coherent = params->coherent;
>>> +    bool ext_coherent = params->ext_coherent;
>>> +    bool is_local = params->is_local;
>>> +    bool is_vram = params->is_vram;
>>> +    bool snoop = !is_vram;
>>> +    uint32_t mapping_flags = 0;
>>> +    unsigned int mtype_local, mtype_remote;
>>> +    bool is_aid_a1;
>>> +    uint64_t pte_flags;
>>> +
>>> +    switch (gc_ip_version) {
>>> +    case IP_VERSION(12, 0, 0):
>>> +    case IP_VERSION(12, 0, 1):
>>> +        mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>> +        break;
>>> +    case IP_VERSION(12, 1, 0):
>>> +        is_aid_a1 = (adev->rev_id & 0x10);
>>> +        mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
>>> +                amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>>> +                is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
>>> +        mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
>>> +        snoop = true;
>>> +
>>> +        if (is_local) {
>>> +            mapping_flags |= mtype_local;
>>> +        } else if (ext_coherent) {
>>> +            mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>> +        } else {
>>> +            /* system memory or remote VRAM */
>>> +            mapping_flags |= mtype_remote;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        mapping_flags |= coherent ?
>>> +            AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        break;
>>> +    }
>>> +
>>> +    if (params->gpu_exec)
>>> +        mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>>> +
>>> +    pte_flags = AMDGPU_PTE_VALID;
>>> +    pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>>> +    pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>> +    pte_flags |= AMDGPU_PTE_IS_PTE;
>>> +
>>> +    gmc_v12_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>>> +    pte_flags |= AMDGPU_PTE_READABLE;
>>> +    if (!params->gpu_ro)
>>> +        pte_flags |= AMDGPU_PTE_WRITEABLE;
>>> +
>>> +    if (gc_ip_version == IP_VERSION(12, 1, 0) &&
>>> +        adev->have_atomics_support)
>>> +        pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
>>> +
>>> +    return pte_flags;
>>> +}
>>> +
>>>   static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
>>>   {
>>>       return 0;
>>> @@ -580,6 +648,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>>>       .emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
>>>       .get_vm_pde = gmc_v12_0_get_vm_pde,
>>>       .get_vm_pte = gmc_v12_0_get_vm_pte,
>>> +    .get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
>>>       .get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
>>>       .get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
>>>   };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 633772fa71fda..a3a5fa048a393 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1199,6 +1199,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>>>           gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>>>   }
>>>   +/*
>>> + * Mirror of the GFX9 cases of svm_range_get_pte_flags(), with the
>>> + * per IP logic kept here in the HW specific file.
>>> + */
>>> +static uint64_t
>>> +gmc_v9_0_get_svm_pte_flags(struct amdgpu_device *adev,
>>> +               struct amdgpu_vm *vm,
>>> +               const struct amdgpu_svm_pte_flags_params *params)
>>> +{
>>> +    uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>>> +    bool coherent = params->coherent;
>>> +    bool ext_coherent = params->ext_coherent;
>>> +    bool is_local = params->is_local;
>>> +    bool is_vram = params->is_vram;
>>> +    bool same_hive = params->same_hive;
>>> +    bool snoop = !is_vram;
>>> +    uint32_t mapping_flags = 0;
>>> +    unsigned int mtype_local;
>>> +    uint64_t pte_flags;
>>> +
>>> +    switch (gc_ip_version) {
>>> +    case IP_VERSION(9, 4, 1):
>>> +        if (is_vram) {
>>> +            if (is_local) {
>>> +                mapping_flags |= coherent ?
>>> +                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>> +            } else {
>>> +                mapping_flags |= coherent ?
>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +                if (same_hive)
>>> +                    snoop = true;
>>> +            }
>>> +        } else {
>>> +            mapping_flags |= coherent ?
>>> +                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        }
>>> +        break;
>>> +    case IP_VERSION(9, 4, 2):
>>> +        if (is_vram) {
>>> +            if (is_local) {
>>> +                mapping_flags |= coherent ?
>>> +                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>> +                if (adev->gmc.xgmi.connected_to_cpu)
>>> +                    snoop = true;
>>> +            } else {
>>> +                mapping_flags |= coherent ?
>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +                if (same_hive)
>>> +                    snoop = true;
>>> +            }
>>> +        } else {
>>> +            mapping_flags |= coherent ?
>>> +                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        }
>>> +        break;
>>> +    case IP_VERSION(9, 4, 3):
>>> +    case IP_VERSION(9, 4, 4):
>>> +    case IP_VERSION(9, 5, 0):
>>> +        if (ext_coherent)
>>> +            mtype_local = AMDGPU_VM_MTYPE_CC;
>>> +        else
>>> +            mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>>> +                amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
>>> +                AMDGPU_VM_MTYPE_RW;
>>> +        snoop = true;
>>> +        if (is_vram) {
>>> +            /* local HBM region close to partition */
>>> +            if (is_local)
>>> +                mapping_flags |= mtype_local;
>>> +            /* local HBM region far from partition or remote XGMI GPU
>>> +             * with regular system scope coherence
>>> +             */
>>> +            else if (same_hive && !ext_coherent)
>>> +                mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>> +            /* PCIe P2P on GPUs pre-9.5.0 */
>>> +            else if (gc_ip_version < IP_VERSION(9, 5, 0) && !same_hive)
>>> +                mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>> +            /* Other remote memory */
>>> +            else
>>> +                mapping_flags |= ext_coherent ?
>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        } else if (adev->flags & AMD_IS_APU) {
>>> +            /* On NUMA systems, locality is determined per-page
>>> +             * in gmc_v9_0_override_vm_pte_flags.
>>> +             */
>>> +            if (num_possible_nodes() <= 1)
>>> +                mapping_flags |= mtype_local;
>>> +            else
>>> +                mapping_flags |= ext_coherent ?
>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        } else {
>>> +            if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
>>> +                mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>> +            else
>>> +                mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        mapping_flags |= coherent ?
>>> +            AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>> +        break;
>>> +    }
>>> +
>>> +    if (params->gpu_exec)
>>> +        mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>>> +
>>> +    pte_flags = AMDGPU_PTE_VALID;
>>> +    pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>>> +    pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>> +
>>> +    gmc_v9_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>>> +    pte_flags |= AMDGPU_PTE_READABLE;
>>> +    if (!params->gpu_ro)
>>> +        pte_flags |= AMDGPU_PTE_WRITEABLE;
>>> +
>>> +    return pte_flags;
>>> +}
>>> +
>>>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>>>                          struct amdgpu_vm *vm,
>>>                          uint64_t addr, uint64_t *flags)
>>> @@ -1316,6 +1434,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>>>       .emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
>>>       .get_vm_pde = gmc_v9_0_get_vm_pde,
>>>       .get_vm_pte = gmc_v9_0_get_vm_pte,
>>> +    .get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
>>>       .override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
>>>       .get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>>>       .query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
>>
> 

