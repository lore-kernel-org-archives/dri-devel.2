Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACA606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xdG4YrCB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36FF10E38F;
	Mon,  9 Nov 2026 13:52:40 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4F910E38F;
 Mon,  9 Nov 2026 13:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzZnEHIxZehohdwPoKLIQZ2d0HtrkyIYsSM8v9+pyFrR2nSjNkxXe/zmkE+eUEsD7X2u34cuLZPJdyzXEuVnAKZgfOfWmypWGzqa2Dj16UObG5hRbvdRygG0X4t7U6vSA+hZjt91JdaMU+Yz7EXsySBHdz7nuTJT5xWy6GcZ0/1TJbmeNB9ZMP9amO7tb9yfwDbQAuUTdeZxvayFseDyJYzXA2z4PneqrJyaVDapWQV5IO9OIb1ClD1tMD/cGt7i8Ne9tFC63iizGbxjFZR8wDxJhNPYRsk+mLU1mUExDZFle3S6wjdurVP8YuI+6dQYIO/O+xrrs/gVs3PsGqePsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8xQT80jw2B1RjRqFdAOLRPMXepGzPdvXBWRNEvE2y0=;
 b=pxmmXQ9w77LM41S0C4961QfjSu8D6lFQkxpuEThmQsvyjru+IrdYW9zM7daHul8gcucIj+ulfz3ASC/k5nIg/dRaeTf7QMIgaKX92XyMBzVwITYqoLkTWOolXqYnHrtAfk9enUdnKe1Ag2wJ4/reqecZ0azpWyLYnsuOqBdKTVweioGF0n1g7+0HtEBoNV4xqMf+ooV+Mv+id/Lo1chSJfrs/t0t5So1vzNpa945+IVZP70lsc2AImbJ1agzCpUCSWrWUINuyHmysHbh1dIqb7/lXbdIo6JFWBPisgA/aPE0FMujHDUIJb+slgaEmtB67Ba9e88+EEDaEsJ97kFXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8xQT80jw2B1RjRqFdAOLRPMXepGzPdvXBWRNEvE2y0=;
 b=xdG4YrCBA0JYyegRF5tfSUyFRl2emsUCTwClwn/fGvY69qticoscwQ6r2ylmjYv3aYXirFxbYfQSR6/Rx8mV6dJ4o/ruKz0n1FgnXXlCH85TcJGbzLkalUozEx9N1V05sXJ0ZvMQQ92NjwijULODUlYILmlUUljmHXeiirihxwk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 13:52:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 13:52:30 +0000
Message-ID: <facb3939-a692-42a9-9d42-a5eafbfb0400@amd.com>
Date: Mon, 9 Nov 2026 14:52:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/22] drm/amdgpu/gmc: add get_svm_pte_flags callback
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
 <20261021025915.2433837-7-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-7-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 063665b9-8bd8-48cc-96d1-08df3e68b241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|921020|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Ea85nXBcg7mJm6i+UHnxJadUrp+QGcruvKMRzQ02UAn7altnrwPJ3QEObmhjdKciWTi76OOWG7/i+5+fZ6+RBxJ8tAooZX3Ms0JFyjqZP8oMTwFj/Ax/NvJEJmeKb+JkCBd56fg6/wYjCbKXEvcbSe97ei5pfemsaZKNovpK8GTiT6+fMOBKEYSaeK78PYSKPLCFFReVeM7rQx7Ev7YhVDmuy+vWMPG/6jDQTKqjRPCMSbLPMvuwvOVRohji5Qynbe8ul6vxOAGGqH1csmR0LW5U2zaeEq1JC0Y4JCoX4EH7SCFqhihhFwP5U5W4af01wfOc02n99m+ujPOChb7m3d82+L20KWn4GjZBe6Nkz+QHEap8S/h4WWwLv9zJS8+Ei3NPrJNHtSb/MEnZLKCVD5TJmjiCmOeItlhe6ekGeP5Dvf1Nqw96QX82EleTjkY1W2vnc7asZ3Ckl7d23wPrV3/VA6w08/rdVEDDhURyvmYKtYVgfTUzsqcJSCvrajNaiONXstal/mkFw285lA3eASed4Aw/S5jNpTlsPJXTdv3rI608RvoN56Ug87Npd9KAR7MvG/8fgOSoVCI41Go3I/nZJfssbIZY6nvKfJZzuSmZHswdK3cn6kL/WRQx+eN5aQzFgKDxTjPlIjzM2m5prljFwWQCtMDOdG30MHUeEWfuOBj6FeCxUpheFBjJgkqVgJZQeQ3G5WTk0YajPu17GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(921020)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTA3Q3ZFVmdWSzdCYkZscFF5RDZNeVdxdzd6MEdBV1Z0aTZ2Y0pUUklCZmlL?=
 =?utf-8?B?cDBjQUZ2aktIMXNwSnBNSDJEZzlpa3RYaSt5citIdmUyZlBORHBtS0lnWHdK?=
 =?utf-8?B?T0pvRDdOSzNnaTNXMzlOcE00K01EMXVoTVBkZWNTOG52TndzYmpIMmduSUlP?=
 =?utf-8?B?WlozVUVaT2x1V3pNa0NrV0RUVnFpbkRicXJYcGdNWlJRTmg4N3FXOUZsKzNy?=
 =?utf-8?B?TzRCTTZUazA2L1I3dUozOHJvUXVlUnY5Ym1EVEFONzR0QktMRUlMQ0QwNmd2?=
 =?utf-8?B?NW1FeHNNMUt4WksxN0xiNGVVNGtMaUZCOHRxdmxmQU4xMUxBWDBUemNJRElL?=
 =?utf-8?B?WlREb0xUcTVSY0NGM1VweXp6ZUlabDNXa2EwVFU2VVF0VVJUcHkrK2I3TDlv?=
 =?utf-8?B?c01ybWhzcCtTbVNZbFR3RXpVWE0xMmF3dGd5aExObjJVbTZ4WEFkYjNucUZo?=
 =?utf-8?B?ZmNLcEdwZnQzcGJXaUUyZ0ZhWG13cTFQNldCYWlIY1IrUW1GOXF4cVhFOXU4?=
 =?utf-8?B?N0F5b0JNTmEwa21DR1ZSSDVOQXpOblpweWFjUVFkVkR1Y09HWm5ZMUthNldP?=
 =?utf-8?B?VXZaU016enJablBGc1JTSmRyeDM2cTlhT3NSWkNKc1RVaFZLZ2R3WnVjWmk2?=
 =?utf-8?B?aFpHTk5wcXNEQjJLSXFGcXA0M2J0V1V1RHcrM0dEWUlFaTdEcDczNGtJd0ti?=
 =?utf-8?B?YytVeFRDVm5hVmg4cjRNTmlNcm1iakJjakdnSDRnR0ZyTkhIKzVIdlMra3or?=
 =?utf-8?B?QTAvM0QrRXIxSXdBUGJJemxLUUxNU0hmL284SXJCb2tzOFpEdDZkOVBSNTds?=
 =?utf-8?B?b3dnOXRBRVY5Q29Uck1RWlRiWGVWUGI4TlN0UHdWVkNtVlRPY1hzMk0xV0tH?=
 =?utf-8?B?UjlXajZmU29tOXk4aDJzZUprMlhmb2VvTmlPU1BNNGs3WjFOTDV0bDJyS2tU?=
 =?utf-8?B?L3lLU1cxc25Ua21NRzhrVm1WejJOUlhqektpTkhxMW9KdHliRmh1MDZWQjlQ?=
 =?utf-8?B?NWtvM3dUQ010Ykw0dHpIN3pBOWtaY2hYQVNEZ25KVGJXdERxZjNXYmxvcURB?=
 =?utf-8?B?OUJGZWNSRVpjdkZSSjZEUE1TdFpQZWdWbkpoaGxYcUpDcTlCeDd3Y3RZYUZP?=
 =?utf-8?B?eTZLdHhYNitKM0NKcXFzN2xXNUdnNml2ai9ZZTNsVXlrdWJtWkNrMVZTMThM?=
 =?utf-8?B?ZmVTZ0N4a2pOakFxNXJuSEJnWnJlUGxmQXBmKzNDSzdxQmo0NWZhemdCOWkr?=
 =?utf-8?B?UGozUWFYVFlEMDhZanBCQjFmWS9xM004bk9TUWkwcWltZEtqOHp3MUhZdVo5?=
 =?utf-8?B?WEp2eEdkb0RZNUhNcDU5SlFoMUQ5b2hkQVV4QWVUL1lPWERobE93Z2VjUm95?=
 =?utf-8?B?OFVsVHp1MnpIQmZROTJkdEtWTXBjZEJaY1ZSZGtNb0Q3bTZ6bnQ0YzlFbU91?=
 =?utf-8?B?WlBPRDJKNWM5anlDUDNpaG5UTUxmWms2Z2hSOVo5MWE1cVlsd3BWLytGQS95?=
 =?utf-8?B?eGR3bXRoaERtNytKcUhESEVBMkFVRk4rRlc5eWkyYmJ6OEFCdXhnd2d2NEVC?=
 =?utf-8?B?MWw2YlFzVVU4cVZOaWFtRG9OQWtmVWp1bnl6K2EzR2ZFVU5Jajc3N3BPOU1z?=
 =?utf-8?B?WkdmN2pXTUtEcjNPMEFyRzk1dTIyZEN4M3lyQitPVVhQQXJ6aDQ5a1QxOGxR?=
 =?utf-8?B?RzZqMUM1eGJsdHlmVUZGMmlJdmhJTWppakdHVWE1Rm1kdnBIYTBwV3ZaWEpO?=
 =?utf-8?B?YkxxMEk4RXhXZWlheG05a240Z0VHR3hTbi9ndFlvVnVzVFk0Y1JhYzNWRWJs?=
 =?utf-8?B?dDBPVkhBRTJrNEVIVVplZm5FdS8vN0tFM1lLcUMwZTdKanZaWVpUc2t4TitO?=
 =?utf-8?B?eHpJdklMWVRtZWZZK1VMNGhFTVNxbDMzNFcvTWdsc3hySGh4d29aWVBVTWlS?=
 =?utf-8?B?VjRLL1IwMTIwTTc2RVJIN3d5NUxLMVhOMHI0SHkzS0Q2R0hVNFA2TS83ZlBa?=
 =?utf-8?B?QWtwU1JxUHFwRllzTHZLZUVDeGp5SEI0M0IwY2FBT3FuM0N0elNCbVhJb2Nt?=
 =?utf-8?B?Q3BwNlNsQ1pFMHM3T1g0R1JFUWlzMWNhTDdZVExpMTdVRUZMcGVsN2k4WGxV?=
 =?utf-8?B?cmhTUzd2bVRPaTJaTG1mN3BuQjJVc2cwK1VxVFZuSVlXbHExWEtxOWtwRTQ5?=
 =?utf-8?B?NXgraWNyTUh4RUtTSmVyT0NSU3NERzJpeDNmeElHcy9iNUQwR1B1UCthMjJv?=
 =?utf-8?B?Y3NwVUEvWlcveFFtMEcwTFltMGVHZXBkQzFJcWd1NmlzeTFjRUwwZ1QyYlBX?=
 =?utf-8?Q?GCkQqRoo0iUea5ewRf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063665b9-8bd8-48cc-96d1-08df3e68b241
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:52:30.1582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw3DlQm5SHE2TUPkgEoR3tCZMnPzOBh5jvGWTbrAysnHc6gUf60dxGQWcKgD/+Ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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
> Add a gmc_funcs callback for computing the GPU PTE flags of an SVM
> mapping, plus a HW-agnostic input struct (amdgpu_svm_pte_flags_params)
> and the amdgpu_gmc_get_svm_pte_flags() wrapper. This lets the per-IP
> MTYPE/PTE selection live in the HW IP specific gmc_vX_0.c files instead
> of the SVM core, mirroring how get_vm_pte handles BO mappings.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  24 +++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  |  69 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 119 ++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index cffd5ca3fc66b..3f668fb71a632 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -150,6 +150,24 @@ struct amdgpu_vmhub {
>  	const struct amdgpu_vmhub_funcs *vmhub_funcs;
>  };
>  
> +/* Decoded inputs for the SVM PTE flag selection, gmc_funcs::get_svm_pte_flags */
> +struct amdgpu_svm_pte_flags_params {
> +	/* SVM attribute: coherent */
> +	bool coherent;
> +	/* SVM attribute: extended coherent */
> +	bool ext_coherent;
> +	/* SVM attribute: GPU read only */
> +	bool gpu_ro;
> +	/* SVM attribute: GPU executable */
> +	bool gpu_exec;
> +	/* mapping is in VRAM local device or remote P2P */
> +	bool is_vram;
> +	/* mapping is in this GPU's local VRAM */
> +	bool is_local;
> +	/* remote VRAM BO is on a GPU in the same XGMI hive as this GPU. */
> +	bool same_hive;
> +};
> +
>  /*
>   * GPU MC structures, functions & helpers
>   */
> @@ -178,6 +196,10 @@ struct amdgpu_gmc_funcs {
>  			   struct amdgpu_bo *bo,
>  			   uint32_t vm_flags,
>  			   uint64_t *pte_flags);
> +	/* get the full pte flags for an SVM mapping */
> +	uint64_t (*get_svm_pte_flags)(struct amdgpu_device *adev,
> +				      struct amdgpu_vm *vm,
> +				      const struct amdgpu_svm_pte_flags_params *params);

That looks like a really really bad idea to me.

Please add the SVM flags to the existing amdgpu_gmc_get_vm_pte() function.

Additional to that you also need to modify the destination addr and not just the flags.

Regards,
Christian.

>  	/* override per-page pte flags */
>  	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>  				      struct amdgpu_vm *vm,
> @@ -378,6 +400,8 @@ struct amdgpu_gmc {
>  #define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
>  	((adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
>  					   (pte_flags)))
> +#define amdgpu_gmc_get_svm_pte_flags(adev, vm, params) \
> +	((adev)->gmc.gmc_funcs->get_svm_pte_flags((adev), (vm), (params)))
>  #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
>  	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
>  		((adev), (vm), (addr), (pte_flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 0cc73982ed6f9..a541173e34a4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -551,6 +551,74 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>  }
>  
> +/*
> + * Mirror of the GFX12 cases of svm_range_get_pte_flags(), with the
> + * per IP logic kept here in the HW specific file.
> + */
> +static uint64_t
> +gmc_v12_0_get_svm_pte_flags(struct amdgpu_device *adev,
> +			    struct amdgpu_vm *vm,
> +			    const struct amdgpu_svm_pte_flags_params *params)
> +{
> +	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	bool coherent = params->coherent;
> +	bool ext_coherent = params->ext_coherent;
> +	bool is_local = params->is_local;
> +	bool is_vram = params->is_vram;
> +	bool snoop = !is_vram;
> +	uint32_t mapping_flags = 0;
> +	unsigned int mtype_local, mtype_remote;
> +	bool is_aid_a1;
> +	uint64_t pte_flags;
> +
> +	switch (gc_ip_version) {
> +	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 0, 1):
> +		mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +		break;
> +	case IP_VERSION(12, 1, 0):
> +		is_aid_a1 = (adev->rev_id & 0x10);
> +		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
> +				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> +				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
> +		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
> +		snoop = true;
> +
> +		if (is_local) {
> +			mapping_flags |= mtype_local;
> +		} else if (ext_coherent) {
> +			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		} else {
> +			/* system memory or remote VRAM */
> +			mapping_flags |= mtype_remote;
> +		}
> +		break;
> +	default:
> +		mapping_flags |= coherent ?
> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		break;
> +	}
> +
> +	if (params->gpu_exec)
> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
> +
> +	pte_flags = AMDGPU_PTE_VALID;
> +	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> +	pte_flags |= AMDGPU_PTE_IS_PTE;
> +
> +	gmc_v12_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
> +	pte_flags |= AMDGPU_PTE_READABLE;
> +	if (!params->gpu_ro)
> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
> +
> +	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
> +	    adev->have_atomics_support)
> +		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
> +
> +	return pte_flags;
> +}
> +
>  static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
>  {
>  	return 0;
> @@ -580,6 +648,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>  	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
>  	.get_vm_pde = gmc_v12_0_get_vm_pde,
>  	.get_vm_pte = gmc_v12_0_get_vm_pte,
> +	.get_svm_pte_flags = gmc_v12_0_get_svm_pte_flags,
>  	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
>  	.get_dcc_alignment = gmc_v12_0_get_dcc_alignment,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 633772fa71fda..a3a5fa048a393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1199,6 +1199,124 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>  }
>  
> +/*
> + * Mirror of the GFX9 cases of svm_range_get_pte_flags(), with the
> + * per IP logic kept here in the HW specific file.
> + */
> +static uint64_t
> +gmc_v9_0_get_svm_pte_flags(struct amdgpu_device *adev,
> +			   struct amdgpu_vm *vm,
> +			   const struct amdgpu_svm_pte_flags_params *params)
> +{
> +	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
> +	bool coherent = params->coherent;
> +	bool ext_coherent = params->ext_coherent;
> +	bool is_local = params->is_local;
> +	bool is_vram = params->is_vram;
> +	bool same_hive = params->same_hive;
> +	bool snoop = !is_vram;
> +	uint32_t mapping_flags = 0;
> +	unsigned int mtype_local;
> +	uint64_t pte_flags;
> +
> +	switch (gc_ip_version) {
> +	case IP_VERSION(9, 4, 1):
> +		if (is_vram) {
> +			if (is_local) {
> +				mapping_flags |= coherent ?
> +					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> +			} else {
> +				mapping_flags |= coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +				if (same_hive)
> +					snoop = true;
> +			}
> +		} else {
> +			mapping_flags |= coherent ?
> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		}
> +		break;
> +	case IP_VERSION(9, 4, 2):
> +		if (is_vram) {
> +			if (is_local) {
> +				mapping_flags |= coherent ?
> +					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> +				if (adev->gmc.xgmi.connected_to_cpu)
> +					snoop = true;
> +			} else {
> +				mapping_flags |= coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +				if (same_hive)
> +					snoop = true;
> +			}
> +		} else {
> +			mapping_flags |= coherent ?
> +				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		}
> +		break;
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 5, 0):
> +		if (ext_coherent)
> +			mtype_local = AMDGPU_VM_MTYPE_CC;
> +		else
> +			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> +				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
> +				AMDGPU_VM_MTYPE_RW;
> +		snoop = true;
> +		if (is_vram) {
> +			/* local HBM region close to partition */
> +			if (is_local)
> +				mapping_flags |= mtype_local;
> +			/* local HBM region far from partition or remote XGMI GPU
> +			 * with regular system scope coherence
> +			 */
> +			else if (same_hive && !ext_coherent)
> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +			/* PCIe P2P on GPUs pre-9.5.0 */
> +			else if (gc_ip_version < IP_VERSION(9, 5, 0) && !same_hive)
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +			/* Other remote memory */
> +			else
> +				mapping_flags |= ext_coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		} else if (adev->flags & AMD_IS_APU) {
> +			/* On NUMA systems, locality is determined per-page
> +			 * in gmc_v9_0_override_vm_pte_flags.
> +			 */
> +			if (num_possible_nodes() <= 1)
> +				mapping_flags |= mtype_local;
> +			else
> +				mapping_flags |= ext_coherent ?
> +					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		} else {
> +			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +		}
> +		break;
> +	default:
> +		mapping_flags |= coherent ?
> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +		break;
> +	}
> +
> +	if (params->gpu_exec)
> +		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
> +
> +	pte_flags = AMDGPU_PTE_VALID;
> +	pte_flags |= is_vram ? 0 : AMDGPU_PTE_SYSTEM;
> +	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> +
> +	gmc_v9_0_get_vm_pte(adev, vm, NULL, mapping_flags, &pte_flags);
> +	pte_flags |= AMDGPU_PTE_READABLE;
> +	if (!params->gpu_ro)
> +		pte_flags |= AMDGPU_PTE_WRITEABLE;
> +
> +	return pte_flags;
> +}
> +
>  static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>  					   struct amdgpu_vm *vm,
>  					   uint64_t addr, uint64_t *flags)
> @@ -1316,6 +1434,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>  	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
>  	.get_vm_pde = gmc_v9_0_get_vm_pde,
>  	.get_vm_pte = gmc_v9_0_get_vm_pte,
> +	.get_svm_pte_flags = gmc_v9_0_get_svm_pte_flags,
>  	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
>  	.get_vbios_fb_size = gmc_v9_0_get_vbios_fb_size,
>  	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,

