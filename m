Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A0606B993
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bKCIWEdh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B030610EF7F;
	Tue, 10 Nov 2026 10:25:03 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E8610EF9C;
 Tue, 10 Nov 2026 10:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ymk23qdjGuqT0JK+MIxro2WkjyBZIXOu0dAAmJ6rlhOP4kCPQ/h58aZMagLO8XG6ZZ8H1obMRpBIDVR1cplrSQI0EGOsszGhNeGH7pNkCtSZVzJf+D5lOVYl5JdnBfQlM/DzA7c4hADFjMr0zT/zP0Xxxv4c2OuWyhew/IkPOqKdnUftJ8XTJdA2iy2ktlkEDRw9JCt6mauDLgW442ne72K5Ymc/9UDed3HvaJFRnhGaL6bEUxIIbWSk+XGE3J2BmQxVOtKZ8ZRl+w7eiJ9ZYR8oXmi1uzLwmoqWRTOJ8PJXMRS6Ocb70baezU8KExjTU6DLo0x5/R5uwzaqjczQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/nKwf81HEAXYjgt7elMLPUtaYLCa7DgJ6vjW3z5IB8=;
 b=yxVEdeFb7uTceoI+h/j9Zdb/VqK5Gngx7f9LvaVs+dmIDgRiEZSTSBV+EN8pIGyPEaporn1QF+kYs2Q2m9uOOE/+V7uN7Bs6WtxmRgOdZ7rDWKPSTRkxcoirYU2NEEQQ8Vsd8yMmiQAu4Co/88aOAt08W1RE4/2yNZM/2/rX+NuhvwvVuI4/HOz3k/Spiz8llZb/GNqh+PmTCahBpEwl6QE+vzhl+Vt7TP5OpTTZ/upQxcMTU6BiZHu2EJkmuKPVpl/k2jDe/Rj8QJoxW95qT5xqJ+9FdRXfJzZJK6x8+BM/ge3TCElsGG4Ej/BB90VGfVjYGO+fs3WoEIacQ6ajVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/nKwf81HEAXYjgt7elMLPUtaYLCa7DgJ6vjW3z5IB8=;
 b=bKCIWEdhz8+AFqZrkPfW+FO58bSxAt3pp1Yps8kDYRkLGtQb6LjB66eADaPCOfEGuLxUbvxM8dDElKssY77V+AvXUyw3pWuFc4zsr/QfRcyDDe3/1thN3kzHl668d4gtGPcr1IETS86D8WbsgtFe6G8cDlhQDy3hy3w8gLtXh7w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 10:24:53 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 10:24:52 +0000
Message-ID: <af5baacd-d06c-4533-9061-bc7fc93a3c59@amd.com>
Date: Tue, 10 Nov 2026 18:24:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/22] drm/amdgpu/gmc: add get_svm_pte_flags callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
 <8e63dc68-065a-457d-9cce-68d68a952a6d@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <8e63dc68-065a-457d-9cce-68d68a952a6d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::13) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: af462b29-3bb9-448f-1ad1-08df3f14db8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003|6133799003|10067099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261102123227099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: vNt5405LE1/jMgjn+VYUh1KCpSArEq8TrzxFIq/hST5sRsHucQ1C93bnJn5Uhb7GDvVmqaRf4FqVTcveruRG83MOD2vCc0ZCecg19Me115F9d0NGwNXwBSyHovfve3Yp9r1uf7vio4k2Fy/ooxsKJSwWkdFlSrMa35z0EKaNsEw7FV4jlGv5z/ouPbc5YvDgtbz0EqbOqh1N4Nmy5qW4PvKbk+TedhcZbwrelUaAYzS/rJ1CFPhitmgq8heHS7ps3VN987caRYB/hNHhJsZ0JDOQ+LINqIIYiUhOCPCj2tQMH2jRJSADw7Id5BpZ0SXpE3rBwPsqreq3fIIKR1Pc3NLZPx2njGY0gjrX/fP9LLgjAK50hRljkHzyydeOq0JmhPExTI81/47QlLklBUrPXdOZce/8gK4dZ0Wk7EvyT0P68nm6CA5HfGHFQsK87df3Fs7n5L3k1SIjdihcI6xlZVCcatsecDCfKtiDq89em5V6S6XdtUui0g6AgKxgUQjJyYvfCyJP77pC4P0PHLs6tg0CE2z5YsjyEXwFrcMpmbw8vo3hEvVB2gNcNjJEIYTXnuQVuYuVEVheAv2SbR1NCXn7mGTtjW2cezqiNVyaDSAAZUgZWGbfOpixEjBotoTg9HsuiJ8CVMc9WxmTA6g7p072xlra3dkDS3pF5oVbUz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRmTzBEcTdxU1FFQTQ5YjFrRlYxQnZXL2dhdXdKMk14RXJpeExiRy9KaXR1?=
 =?utf-8?B?MVM2REdvbjdVVzdCeFVhZ3pUeEt0YWpGRzJTeUxxTVpVMklzV3I2dFpUSit0?=
 =?utf-8?B?UjhRdmJlMldZUm9Qejk1NVhqNkI4ZTZTdjBOUDlMdWE4MHpwYngvUVppazBp?=
 =?utf-8?B?a1YzL0ZsNWppZ2ljOFlKNUl5NXNOUHY4ZmNIellPVDB3aWM1SUtRVzFheXgv?=
 =?utf-8?B?c09yZlk5R2psajZ6ZFhYUjU5K1FOOFBzb1JtTVdMa3pOSndiS1J1ZFRVRVhN?=
 =?utf-8?B?VWgzMkM0clVBbVVYM0E3UnRGQjJmU3RSNkpwVVh2YTlBOTRZcnYxQ3oyRW9W?=
 =?utf-8?B?c3N5SjJBRlpLdHdsZjJWNkNxYmNnUkJVNkRGRHZoVlVKUnRQYitOWVJRRXJ4?=
 =?utf-8?B?eDlHb2IyNWszR2xrVVVzZVVvZmxCdmNZbW10OU9ieG52NzZ0c2o5ODRNVXdp?=
 =?utf-8?B?UHNUY1BZRDZDY1RHQU5LVXJEUlNjN1VsUVJXOFhPY1FrdDY3V2JyZ1NOajBS?=
 =?utf-8?B?cjN6R3RKSEhjaEUvRE9jczJpWFFMb0ZDQnk0UU05aE5DSEJJNjcxUWhjbUxx?=
 =?utf-8?B?WDFWeEI5bDJhaWlyc1NTN1plaXhoRWhwelB3Y1F6SWtEQlJoUjJmZ1ZockR3?=
 =?utf-8?B?ZGg4RlJWTU0vM1pIQ0lVdVNCOGFoUk1rb004VFBKcUNLVWxiNjZWbm5kK1Q2?=
 =?utf-8?B?UmJEcFlCMFBFM29mK296QW5VZTNrdkROU3lkbE8zWm9UYXluUXpQSmRZYy9l?=
 =?utf-8?B?S2RySU4yVmsxRXVTM1BZR0dBdlJNd21tcXU4NnNJSkYxOVZOblVuNGtCREJm?=
 =?utf-8?B?b1NQemV4VDRZVzhnZzhEU1p6YjRSc1krTEZsVWg4RVFpVGJBRjQ3OVZLT0R5?=
 =?utf-8?B?WGVPZkdHTC82U0ZwYThuWFN2V05YK0tDNHN1aTFHRGJINVZPT0U0VnRHMlNO?=
 =?utf-8?B?ZUs5KzVPTUNSZ2lzbHpmVG1LdGU0YnlBaHRFcXFDZm1ldWdienR5Q1BIemJq?=
 =?utf-8?B?dlZ1SWlFeURES2Y5Q2RxZ0lYaVB2UGdUYWV6Z1Z2NmxnS1pMTW94NXRkcllp?=
 =?utf-8?B?aTczYVkrWkdmSy92WkhhVHB1MGphNks3MmxzRGEzcDdYY01UcExIY0tzaGxl?=
 =?utf-8?B?YU95NHNKODdLM2d6ZjBRRGdDb0Y4VkRwUDBqdWRMckNPN3VHRkY4RlJRTzgw?=
 =?utf-8?B?NFFkZHNjMGJJbVFVd3gvY2MzNVFtMi9TdHZWTXVqMGtWY3BBekdMblIwRDFZ?=
 =?utf-8?B?aWNmQ1hBNzFxUFVwYXN5dmxiZCtCS3NFY0k1cE10NkJQS2p0dDhyRlBaMnl1?=
 =?utf-8?B?d3FoSzZCNkN3cXA0WjIrVlNRTGdHU3NJT0t1SFRxdEJMMDIwUVF2cVNQc1Fr?=
 =?utf-8?B?dHFOK25ackdtSlNmTVZXdUs2T3RrblNoOHFSaWM2MUxqUE1FOEovVkZNejQ3?=
 =?utf-8?B?NUt3ZVBvSW1QOWY5OGxrYmdXWFY4NVE2a3JneWNFQkFYeUd3SFo0djVlTm1s?=
 =?utf-8?B?TUMwWXJmSUFMVHF0QkNzWGpOMXJ6QUhBV2VoWWxzc2NGQ1JxeC9iUXQ1dk54?=
 =?utf-8?B?VzUwSnJ3RHFPbm9ZUTNlcXMyUjRpQkVTdUpiWkRRWVNNS3dmczVWQUhVVFlv?=
 =?utf-8?B?bUxpTHo1aldsdmErdkt2blQxQXdKMWJtVUg0OFBsV0dKUnFibVFYQnhFMy9U?=
 =?utf-8?B?ellSQW05bGlaODlHa093SkRldktzRnp2MnJSMjlHN0Q1emc3S0l3ZStSRktp?=
 =?utf-8?B?aUhVWWhNZWRISStnUjlKUldXSW5tUzBXa0lRRnNCSkhlWGdtNlBKd3dKU3U5?=
 =?utf-8?B?UVIwNUNNTEVBSE5USk5kSHZPVllZelZmRWhOYmx4Tm9yNE9QZlBnZEZRbngz?=
 =?utf-8?B?OS9CTW5haDNXZGRBUVBJMGozSGVKZUxNYTVKbUZCSjNoRWJPTWFOODRZLy81?=
 =?utf-8?B?cURFSU8rUHdQZEdRQVhYNHVhbXVwMjJyWmJ0ak10em1uZndWK3RQc01aWFhW?=
 =?utf-8?B?K3hoSW04VTQ2MUlrQkFEUkVSWE9jbnh4OUVLc21UdXZmaFNnNjAvVzBTeXZp?=
 =?utf-8?B?TkhvVTRMNHdhUm1weWNjRjA1d2UrRUZraElpSXlVOS9tR24xQlVDR3dIU3F6?=
 =?utf-8?B?VTFRTXZtZ1EycjBLTDU0dzFZV1RMNTd1ZWxudVoxakJxa3l4dnRmUGFMekVh?=
 =?utf-8?B?UHo1VG91Y1FpOFFuYzVTTkhOU1hMQllhMU8wSVhJNUtkNlBFVzhpcnlmUGQw?=
 =?utf-8?B?dVdwRVlqd1N5Z3Rqdk9YbDNZU2FDUEFqSjBTY2NVRG5oaEQ2ODFJMHFtR1hW?=
 =?utf-8?Q?kt7jBuZ78p6CVvCbIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af462b29-3bb9-448f-1ad1-08df3f14db8a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:24:52.7802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2kQx6rUmZv+zRFmw85HnrMaTb4FPW+Q3sg4a6xaKv8vsBDKaJ8199bk0xzBhbBn/pWR2HML9TjM3X8EC6UL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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



On 11/10/2026 6:01 PM, Christian König wrote:
> On 11/10/26 07:57, Huang, Honglei wrote:
>>
>>
>> On 11/9/2026 9:52 PM, Christian König wrote:
>>> On 10/21/26 04:58, Huang Rui wrote:
>>>> From: Honglei Huang <honghuan@amd.com>
>>>>
>>>> Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
>>>> mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
>>>> and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
>>>> MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
>>>> of the SVM core, mirroring how get_vm_pte handles BO mappings.
>>>>
>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>> Suggested-by: Huang Rui <ray.huang@amd.com>
>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
>>>>    3 files changed, 212 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> index cffd5ca3fc66b..3f668fb71a632 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> @@ -150,6 +150,24 @@ struct amdgpu_vmhub {
>>>>        const struct amdgpu_vmhub_funcs *vmhub_funcs;
>>>>    };
>>>>    +/* Decoded inputs for the SVM PTE flag selection, gmc_funcs::get_svm_pte_flags */
>>>> +struct amdgpu_svm_pte_flags_params {
>>>> +    /* SVM attribute: coherent */
>>>> +    bool coherent;
>>>> +    /* SVM attribute: extended coherent */
>>>> +    bool ext_coherent;
>>>> +    /* SVM attribute: GPU read only */
>>>> +    bool gpu_ro;
>>>> +    /* SVM attribute: GPU executable */
>>>> +    bool gpu_exec;
>>>> +    /* mapping is in VRAM local device or remote P2P */
>>>> +    bool is_vram;
>>>> +    /* mapping is in this GPU's local VRAM */
>>>> +    bool is_local;
>>>> +    /* remote VRAM BO is on a GPU in the same XGMI hive as this GPU. */
>>>> +    bool same_hive;
>>>> +};
>>>> +
>>>>    /*
>>>>     * GPU MC structures, functions & helpers
>>>>     */
>>>> @@ -178,6 +196,10 @@ struct amdgpu_gmc_funcs {
>>>>                   struct amdgpu_bo *bo,
>>>>                   uint32_t vm_flags,
>>>>                   uint64_t *pte_flags);
>>>> +    /* get the full pte flags for an SVM mapping */
>>>> +    uint64_t (*get_svm_pte_flags)(struct amdgpu_device *adev,
>>>> +                      struct amdgpu_vm *vm,
>>>> +                      const struct amdgpu_svm_pte_flags_params *params);
>>>
>>> That looks like a really really bad idea to me.
>>>
>>> Please add the SVM flags to the existing amdgpu_gmc_get_vm_pte() function.
>>>
>>> Additional to that you also need to modify the destination addr and not just the flags.
>>
>> Will change to existing amdgpu_gmc_get_vm_pte function
> 
> It might be necessary to rework the existing amdgpu_gmc_get_vm_pte function to get the BO flags as parameter instead of the BO itself so that it can be used for both use cases.
> 
> Maybe split that into a separate patch.

Got it, will split that into a new patch.

Regards,
Honglei

> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Honglei
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>        /* override per-page pte flags */
>>>>        void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>>>>                          struct amdgpu_vm *vm,
>>>> @@ -378,6 +400,8 @@ struct amdgpu_gmc {
>>>>    #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
>>>>        ((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
>>>>                           (pte_flags)))
>>>> +#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
>>>> +    ((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
>>>>    #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)    \
>>>>        (adev)->gmc.gmc_funcs->override_vm_pte_flags            \
>>>>            ((adev), (vm), (addr), (pte_flags))
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> index 0cc73982ed6f9..a541173e34a4e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>> @@ -551,6 +551,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>>>>            *flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>>>>    }
>>>>    +/*
>>>> + * Mirror of the GFX12 cases of svm_range_get_pte_flags(), with the
>>>> + * per IP logic kept here in the HW specific file.
>>>> + */
>>>> +static uint64_t
>>>> +gmc_v12_0_get_svm_pte_flags(struct amdgpu_device *adev,
>>>> +                struct amdgpu_vm *vm,
>>>> +                const struct amdgpu_svm_pte_flags_params *params)
>>>> +{
>>>> +    uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>>>> +    bool coherent = params->coherent;
>>>> +    bool ext_coherent = params->ext_coherent;
>>>> +    bool is_local = params->is_local;
>>>> +    bool is_vram = params->is_vram;
>>>> +    bool snoop = !is_vram;
>>>> +    uint32_t mapping_flags = 0;
>>>> +    unsigned int mtype_local, mtype_remote;
>>>> +    bool is_aid_a1;
>>>> +    uint64_t pte_flags;
>>>> +
>>>> +    switch (gc_ip_version) {
>>>> +    case IP_VERSION(12, 0, 0):
>>>> +    case IP_VERSION(12, 0, 1):
>>>> +        mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>>> +        break;
>>>> +    case IP_VERSION(12, 1, 0):
>>>> +        is_aid_a1 = (adev->rev_id & 0x10);
>>>> +        mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
>>>> +                amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>>>> +                is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
>>>> +        mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
>>>> +        snoop = true;
>>>> +
>>>> +        if (is_local) {
>>>> +            mapping_flags |= mtype_local;
>>>> +        } else if (ext_coherent) {
>>>> +            mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>> +        } else {
>>>> +            /* system memory or remote VRAM */
>>>> +            mapping_flags |= mtype_remote;
>>>> +        }
>>>> +        break;
>>>> +    default:
>>>> +        mapping_flags |= coherent ?
>>>> +            AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    if (params->gpu_exec)
>>>> +        mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>>>> +
>>>> +    pte_flags = AMDGPU_PTE_VALID;
>>>> +    pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>>>> +    pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>>> +    pte_flags |= AMDGPU_PTE_IS_PTE;
>>>> +
>>>> +    gmc_v12_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>>>> +    pte_flags |= AMDGPU_PTE_READABLE;
>>>> +    if (!params->gpu_ro)
>>>> +        pte_flags |= AMDGPU_PTE_WRITEABLE;
>>>> +
>>>> +    if (gc_ip_version == IP_VERSION(12, 1, 0) &&
>>>> +        adev->have_atomics_support)
>>>> +        pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
>>>> +
>>>> +    return pte_flags;
>>>> +}
>>>> +
>>>>    static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
>>>>    {
>>>>        return 0;
>>>> @@ -580,6 +648,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>>>>        .emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
>>>>        .get_vm_pde = gmc_v12_0_get_vm_pde,
>>>>        .get_vm_pte = gmc_v12_0_get_vm_pte,
>>>> +    .get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
>>>>        .get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
>>>>        .get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
>>>>    };
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index 633772fa71fda..a3a5fa048a393 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -1199,6 +1199,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>>>>            gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>>>>    }
>>>>    +/*
>>>> + * Mirror of the GFX9 cases of svm_range_get_pte_flags(), with the
>>>> + * per IP logic kept here in the HW specific file.
>>>> + */
>>>> +static uint64_t
>>>> +gmc_v9_0_get_svm_pte_flags(struct amdgpu_device *adev,
>>>> +               struct amdgpu_vm *vm,
>>>> +               const struct amdgpu_svm_pte_flags_params *params)
>>>> +{
>>>> +    uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>>>> +    bool coherent = params->coherent;
>>>> +    bool ext_coherent = params->ext_coherent;
>>>> +    bool is_local = params->is_local;
>>>> +    bool is_vram = params->is_vram;
>>>> +    bool same_hive = params->same_hive;
>>>> +    bool snoop = !is_vram;
>>>> +    uint32_t mapping_flags = 0;
>>>> +    unsigned int mtype_local;
>>>> +    uint64_t pte_flags;
>>>> +
>>>> +    switch (gc_ip_version) {
>>>> +    case IP_VERSION(9, 4, 1):
>>>> +        if (is_vram) {
>>>> +            if (is_local) {
>>>> +                mapping_flags |= coherent ?
>>>> +                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>>> +            } else {
>>>> +                mapping_flags |= coherent ?
>>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +                if (same_hive)
>>>> +                    snoop = true;
>>>> +            }
>>>> +        } else {
>>>> +            mapping_flags |= coherent ?
>>>> +                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        }
>>>> +        break;
>>>> +    case IP_VERSION(9, 4, 2):
>>>> +        if (is_vram) {
>>>> +            if (is_local) {
>>>> +                mapping_flags |= coherent ?
>>>> +                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>>> +                if (adev->gmc.xgmi.connected_to_cpu)
>>>> +                    snoop = true;
>>>> +            } else {
>>>> +                mapping_flags |= coherent ?
>>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +                if (same_hive)
>>>> +                    snoop = true;
>>>> +            }
>>>> +        } else {
>>>> +            mapping_flags |= coherent ?
>>>> +                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        }
>>>> +        break;
>>>> +    case IP_VERSION(9, 4, 3):
>>>> +    case IP_VERSION(9, 4, 4):
>>>> +    case IP_VERSION(9, 5, 0):
>>>> +        if (ext_coherent)
>>>> +            mtype_local = AMDGPU_VM_MTYPE_CC;
>>>> +        else
>>>> +            mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
>>>> +                amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
>>>> +                AMDGPU_VM_MTYPE_RW;
>>>> +        snoop = true;
>>>> +        if (is_vram) {
>>>> +            /* local HBM region close to partition */
>>>> +            if (is_local)
>>>> +                mapping_flags |= mtype_local;
>>>> +            /* local HBM region far from partition or remote XGMI GPU
>>>> +             * with regular system scope coherence
>>>> +             */
>>>> +            else if (same_hive && !ext_coherent)
>>>> +                mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>>> +            /* PCIe P2P on GPUs pre-9.5.0 */
>>>> +            else if (gc_ip_version < IP_VERSION(9, 5, 0) && !same_hive)
>>>> +                mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>> +            /* Other remote memory */
>>>> +            else
>>>> +                mapping_flags |= ext_coherent ?
>>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        } else if (adev->flags & AMD_IS_APU) {
>>>> +            /* On NUMA systems, locality is determined per-page
>>>> +             * in gmc_v9_0_override_vm_pte_flags.
>>>> +             */
>>>> +            if (num_possible_nodes() <= 1)
>>>> +                mapping_flags |= mtype_local;
>>>> +            else
>>>> +                mapping_flags |= ext_coherent ?
>>>> +                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        } else {
>>>> +            if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
>>>> +                mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>> +            else
>>>> +                mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>>> +        }
>>>> +        break;
>>>> +    default:
>>>> +        mapping_flags |= coherent ?
>>>> +            AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    if (params->gpu_exec)
>>>> +        mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>>>> +
>>>> +    pte_flags = AMDGPU_PTE_VALID;
>>>> +    pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
>>>> +    pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>>> +
>>>> +    gmc_v9_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
>>>> +    pte_flags |= AMDGPU_PTE_READABLE;
>>>> +    if (!params->gpu_ro)
>>>> +        pte_flags |= AMDGPU_PTE_WRITEABLE;
>>>> +
>>>> +    return pte_flags;
>>>> +}
>>>> +
>>>>    static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>>>>                           struct amdgpu_vm *vm,
>>>>                           uint64_t addr, uint64_t *flags)
>>>> @@ -1316,6 +1434,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>>>>        .emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
>>>>        .get_vm_pde = gmc_v9_0_get_vm_pde,
>>>>        .get_vm_pte = gmc_v9_0_get_vm_pte,
>>>> +    .get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
>>>>        .override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
>>>>        .get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>>>>        .query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
>>>
>>
> 

