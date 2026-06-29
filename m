Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD6C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF91710E0D4;
	Mon, 29 Jun 2026 17:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UdufgN4e";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010024.outbound.protection.outlook.com
 [52.101.193.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E74C10E0D0;
 Mon, 29 Jun 2026 17:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTi2H21UJDX/8DJrYy7XjumvmxyaxWnOwIzA+Q71kG7pJxzTTnpao2EFIXVISZUAUmrSwnZpWyZAKb7NyMEWfVq/mYgL8pTAcdpkJJ5MMMBklA8gbcnpH/ZthsfYnyWtJskXO9A1IoowjJZjHXv71kjtdr5mLp1UNxJVAOu2q4qaFUUGYR72Np8Su0VN36i6/ZB/iKN2O110xV055B65ATnKpTHcQn5ugV8eC5TWFj9HNOwGFS+5uG+0bL0qST16IeZH0EIig/ykJ9iPl7wA1YXkoTjuoGpZdMF4pq+8iEPDG4/SKo2KUGZnytFUzFWF3R8iRLiPh3iHsAiLdkd+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zELtQfPCvvCpHpa3LRpuDAcJ1DPJue0moAJ2C93+D/w=;
 b=wObVbRNtSpAwJYPh9sbq3t1Wou8HVrR4MSAV4bxrTUN5GIg66kOOku7zuX2XXVjkZspkjgYLrG5PujlmfR0cjRBqpiMQussDMt+Fzb81W9AExCbNJhjA2EK+F7yidltOHBw3loWida0sBtmrV7QK4ILt9Ey5q6wIHBoLns9AoFAkDrz567ku3cJf1NgbNGMWzjfaVku4Y7gE6dxcxFzfrXGSQB/pIM4LjQtP2XvFvDMd2Rgiz0ubSxRuANKx3wZ5p5znC53pOD2xk7rCFvMKAXMAjPUlQrpmlWMkHZGu6OU0RKlRn4KDvmxyuk6NOQ4L2PmggPwXmOHC/EH7E/R6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zELtQfPCvvCpHpa3LRpuDAcJ1DPJue0moAJ2C93+D/w=;
 b=UdufgN4e5I2R8sSwUqOv+OP6+zH2kbjN1tqbwsp4JAinI1L4KOieEcw+PCMaJu+yoLM+gyaJOdZZ+0tbNYNqU1E7LlfgljW75bqCb3M78PyOhI5rQZcU2nTp9Ec4Qfe3TTSKe9EGwmftJ7gViUEXXFZZa3203qWIaKAcRTe/IUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 17:53:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 17:53:29 +0000
Message-ID: <9935b6d9-d534-4275-8a7d-414ce555779a@amd.com>
Date: Mon, 29 Jun 2026 19:53:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: reject mapping info when BO VA is gone
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260629152807.13492-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260629152807.13492-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2a5159-1fef-4255-37d0-08ded60753a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5k6qbtUNlQwcaMQKkYsrYIZ3xSZi01Gdlcawxxe5Dkyyb/ZphB6LSCjIIdcQC/HvLppDWr5Ot8sP7Pu12EA7FyNSm9nDZHHm4K/JVETUr6MTqm+wf8kuMZzEhnvErau0NoA8kpvx0EGWvkC8kZkJSJJINYb6W93EJQz/dYAIgsuiOrSIdRaX8HqofU7b+p+2X6YMm9sA8GAqR7ek2GsqKo8wP5hUZrrSEg6n1qkMoNQUq/w9WplGLHUV04xoE12GLa5LpqhG3Mbn6nbha6Geqmvei7HbLZWFE1tRw7XxY5j/ajwhh7D2Og1z5TlaYlTS63XqSld32Jl+v5W0z+d0Hqhzd0uAt5MZlR/Cm/T+WXpZxMk7qxyCoufWyUfoS7IMNcWfXqV0wFdKlfWewDReAok2KzwYatvDsd27Wv1lo+VG7Fj59dsy++/WPZjEzHz/Jbp8grhC3sN2Ohobiid4o4HrL7Wi1qJfFEMdSolLloExSDY7qksHNXISvVjbl2jnz9gFq3DkJxLLHg2b8RIebuUkkdJU7CYmrZoPnkXsTAKHJ5Zl9eZpEZM/CTZ868TBtmYPPZs8BGgz6SWsVyxUkUyVLTxhv8t+/tsPk5tYfYteXPOwYm0zAK8VyH9fXFOfqxTTzWZnL2iSVZ5fKneB0lwX72wx2npefAsUN+RB6jI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJCY0kvS2pmRVRBaGdsU3ZDWDdTbmhaVGZHWnNNdUNBTndudXVSeFZIMXNE?=
 =?utf-8?B?UUJYV0lnbEwza3dSckVzR0VJS0cvZjRUV3EvSzBaaCtIYWtwaXh3elBBZTlp?=
 =?utf-8?B?MFpYTlJmd3N5bE40WUdGVkdXSTBUSnc0SElSTXUycUwwZHQ0TCtrMC9NSTYr?=
 =?utf-8?B?T0lLS0xwaVdiUUpMNkdiOWd3NjdRRTltMDlMcnNyaU85b0hUR3JWbjZvQ05Q?=
 =?utf-8?B?bmRJVC8wVlIzZGlmUWUxWnZ3ZUx5UUVkWkt2T1l3SGJDVEU1RU50WUtOVkx2?=
 =?utf-8?B?Sml2ckczMjMwa1A1aXlLL0RERDFwUHJhM0JoTFYxREdIRlFoUzRMV3ZocVV2?=
 =?utf-8?B?WDg3RmpOcmVpRnVJMnJnYXJjS1dmWlVuNnJSOVdxeFZuYndZVzRydUROb2dB?=
 =?utf-8?B?QTViZDNhRDMwVFRHWVFudnRjSVFnaitMTTg1YTRZOEtTSHorbjFHT01hejhs?=
 =?utf-8?B?QXF6c2dPY0JLUlFuQWgvK3RPSlhMd3VKRnVYRjhvMEZNNkU1UXloWG9FUEQx?=
 =?utf-8?B?MHl2RVBiL2xydWdZSVFxcDByVkdvaDJEZm9kbWVkMlg0Y2YvYW9uSytGOW1S?=
 =?utf-8?B?NHRpR3ZPVGVZZmp3SFZJYlk3RENnRncraTcxUzVFRVhxZUZMUkNFVmRQZzh1?=
 =?utf-8?B?Y0pzSVJYa09ON3QyT3BYZ0YrYi9DeEtiNTRMWk9WU0hNNFh0YzVIUlpJVUJI?=
 =?utf-8?B?TW53dVN6cEVUSzVhOEFmaFhMNkFETnluKytlUUM5b0tWSXNSdFpsdEFQNVpB?=
 =?utf-8?B?YkFGdTFpejVUSUhIUlFHMzFxalNST2szSUc4Yy9KNDNiZVhPSnp2Q01DN0pD?=
 =?utf-8?B?bXMzaDlXZENHcEVmL29mSU1IWlpIalk0M1QxRVJ6ZmQzcUdqeVZ0bFA4ZGM1?=
 =?utf-8?B?R1U4bksrbmFPZEVraEsybkZvVTdCcE1YaHhWRElyRzVIR3N4VHRZUDJCZTR5?=
 =?utf-8?B?bUxSVytWQkQ2TWVtY2ZrU3lmQnEyL2xOcDcvbVZxTk4ySEF1eGpZVFVOaDcx?=
 =?utf-8?B?Y2t5UnpBV2lhVnBRek1JdVhYS3BRU2RnQTcraVp0a3E3ZDU2MUNTTXVhSnFn?=
 =?utf-8?B?TVhBYVdqQTRULzJPK1Zlc2hFQ0JLMmtoNmc2dEtqMU4zb1RtdmxHNkVSbnRi?=
 =?utf-8?B?U2RlejUzNjJVYTRPZ1dvdmxvNGhndEJlVnFPRFExOTNhVXBTalFUamN1eHBC?=
 =?utf-8?B?eDlxTVNadytuYmZKNkl0b2Jka3B4N2gwYmNDQlVHZVVrY0g3NzhORDZuem1u?=
 =?utf-8?B?c25YbWlLODhnbDl0WGVjZXVqUVpibFdiQUtkSTRaSEN4eGxaM1V5S0F0NEkv?=
 =?utf-8?B?T21KMDFsUllnZ3YrU29SY2MxaWNKM2luaitDOW9VZ3FPRWhObDlYK0FYcHdX?=
 =?utf-8?B?M01VK3V4UTRnQVFnN1BLeHZDbEppbnBBZTNrL0t5ZWs2dStBSlpaa29lTmZW?=
 =?utf-8?B?dUc2QW53OWlvcWdkb0RWOG1lbEVQN1lWZHl3Rm5YVDJDTTRjanpNMCs0NnJm?=
 =?utf-8?B?OTFDeHVISFJnS2NJVkJGQytHT2ZoalgvVUJjV3hLb3RlUWdpQmlIbm1ZRVZo?=
 =?utf-8?B?bk1VUnl1NVYyaGxrTEFvRlM5ZGovWlY0WFdDY1lRZHRJd0FQM2VXbStKbW9v?=
 =?utf-8?B?SGg5ZFk2VjNYV1hFcUwwQmpISThZWFNIZjkxZysvZTh1ZGVoZ3IxWG5acTFw?=
 =?utf-8?B?RDd1TEtnVDVzYjFmK0ZWNFpoKzdPOEZWZzRGY2JCcnVRbmNZc08zbFZaZlJh?=
 =?utf-8?B?Q2s3TXA0K2NkdHRNUTNuVDNJSzFhUGttd3E4Vk5tdGx2UWtXaHllaXd6MFR0?=
 =?utf-8?B?cDM0MWRPYkhrdjdXaG5DQXY1dHpIZlQyeEwyWTRYQThRczY5aFA2U0ZQTkVZ?=
 =?utf-8?B?Z2N5UUxJTmJ2aVBVRG80cGZIams2VTZBdHFhM0Jpc3U2ZTJQNzZ2OVpHa1or?=
 =?utf-8?B?bU9nMkZET1BJb1dxRHVxRytvdXlzeG5SOURFRjd1amtRcVE0Y0JRZzRvdU9Z?=
 =?utf-8?B?dlk5dG9lVzBUU2dMeDhGdnBsUFM2cmFEMlMyeEN4VXpVdUp2MExMYzlITmhL?=
 =?utf-8?B?WjNDN0wwWXVHc1BRb1BCU3hQaFFZd012RW9PQ3M2a3A4Z29NYXVZZlJ3eitY?=
 =?utf-8?B?MnhoS2VvNEZxYjZVeGllRjVtQnBsdnN5M2lOalB6Z0xpSUZubExjRkZGcG9D?=
 =?utf-8?B?U21UU2hqTGN0bGxWcWJxYS9vRWE3elhVemhFaDZxT1FQRDFHTTc2V3hNZ08r?=
 =?utf-8?B?Q3RDWHJHUUpZZVF3NmVLTHJkc3l5Y2lrd2E3WDlWNDVQN2hKU2R6TXp2cTIr?=
 =?utf-8?B?bCtkbW9nMi9NMGNFNXdWdW5TTlpyWjhkSHRwSUZORDF4a2x4Nk1adz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2a5159-1fef-4255-37d0-08ded60753a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 17:53:29.1697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ernnxyrTcVBA5wNLcQJ7PaKzzydqiOQ8C2+sBTZPtf7E58UAkueFer0Xh+gmt4zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

On 6/29/26 17:28, Yousef Alhouseen wrote:
> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object before taking
> the object and VM locks. The object reference keeps the BO alive, but a
> concurrent handle close can remove the per-file BO VA before
> amdgpu_vm_bo_find() runs.
> 
> The mapping-list walks then dereference the NULL BO VA. Return -EINVAL
> when the BO is no longer associated with the VM.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Changes in v3:
> - Generate a clean patch against drm-misc-next instead of stacking on v1.
> - Keep only the intended !bo_va guard for the handle-close race.
> - Clarify the v2 withdrawal confusion in thread replies.
> 
> Changes in v2:
> - Describe the handle-close race instead of an initially unmapped BO.
> - Return -EINVAL instead of -ENOENT.
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 27be5083f2af..83ec994ad36b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  		struct drm_amdgpu_gem_vm_entry *vm_entries;
>  		struct amdgpu_bo_va_mapping *mapping;
>  		int num_mappings = 0;
> +
> +		if (!bo_va) {
> +			r = -EINVAL;
> +			goto out_exec;
> +		}
> +
>  		/*
>  		 * num_entries is set as an input to the size of the user-allocated array of
>  		 * drm_amdgpu_gem_vm_entry stored at args->value.

