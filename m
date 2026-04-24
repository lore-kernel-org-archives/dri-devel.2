Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEB1FB44C5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880FA10F32D;
	Fri, 24 Apr 2026 07:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QhIBQf4O";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C09A10F327;
 Fri, 24 Apr 2026 07:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBILOLhjPwjtFvNhJx0IjXbRo4Ed1RLqfxm7ATLMl9pjT+9HismCb8rbRBzxXk4a2cGrQVuwqrXi6Wrz36MoFC/lSvWc615gOH01korHRWx1X8LA19/SOjDmEaV6/GcTzqqOY97hiyKPByni10Hv0+oZK0pnh6s1n1xLOrONTUWn9h2Y0kV9uTL/UuDgqhE+qe7Fk8xioe1P5xM9t9bV5mnOUJ7dITzh3pX/Y8g1C706IRU24TgLAiT4dOplpJuXTYQlhdDUnJhVRbKS1K5e+cTEkTOP7E9xpR+FC7EQ4XAlS3U3R0ecjO0H57Q4Uj/eGFyYsIPfOzh7haWhTMh8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H38PF4+sa36ICJRCQaz7nlRo1C2+jLyKKOpajd//AUc=;
 b=FOq4lJZTCjXoUzumo6lRmARuR62x5peqst8Ll9saw8ufR2UYO+ZrBr/3VioCBCJFmTKY3uNoeBm6oYbHygNmZiVd1jCcvpobBMvW9bjCDqD+Ekzcs/frINSTZ0RFL45loWjxQGVDZTXkhqKKTKXx4+KVpMWfBAkqGDr3dYBurKPtjC+r3LXj8QnSsMPilVZHdqgmd6EkhZdEoOWfiYzqJnFjg4nLjg4FzlzPFoRsQQ5kQOoPGkQCxjZy4a8ZhtBEOpg/yX97BMJ+EtlpkawGIPx1Qp+xN4Vfq7hN1LptugNLAhyHMxRhg0m9VOinQ30Q406zbECAUNYpQ40AaMS6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H38PF4+sa36ICJRCQaz7nlRo1C2+jLyKKOpajd//AUc=;
 b=QhIBQf4O1X7iBDbC9m7OEefQQOJtxQYMkTqHIziNaJz7ncvC852ia0MyIgDhgxiKkXuwmaYwWtZi+jMvq9oF97d6XSSKXN6ZMKPbswEpxn6N1RjcG7sSAp0XyE2UBeYpK70NV/P6ycFRKYDW70gBGL8G0xMpxmeUHOATWDNAb4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 07:24:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 07:24:24 +0000
Message-ID: <975a945c-1bb8-4dbe-9767-d39f3c98e778@amd.com>
Date: Fri, 24 Apr 2026 09:24:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: move read_indexed_register to
 amdgpu_reg_access
To: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260424004910.21003-1-gabrielsousa230@gmail.com>
 <20260424004910.21003-2-gabrielsousa230@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260424004910.21003-2-gabrielsousa230@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0938.namprd03.prod.outlook.com
 (2603:10b6:408:108::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: cfffc871-0654-4111-0501-08dea1d282d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: hvX40fC5GWAIFiyo/DQHe/XJ1P7TJoLH2Gc9XmeCqaWVPYKsi7SjUSPFNpkpqxk8zYRQSiH3HN3m7JxusqUlOWbdtUuBuek7lnOle7j7pS5vd2cSHeCZLQVkHY36bTO3NEbU6i98k61aDp7zEu6Xq05tuXYPtBtkiF6CU84qLKePExbw7IDb3GkC9hd6Tj/XqdyxhpbOQLerlMh4vwJw4UGj2jqBGMVNu8TUjgC8V3Dmm1BFS7CCYmuj2b398ubjFKnEi+URfXXRWy5VlEx04Kd1tpa5jEnP1N7nF4LCJsSSMbx2c5l7kKjUh9MrD5U6E7ibehRLy5dTqYKfiEdMI9v/jZH+sPE6CLW5DLJeUwJCuhgF+TpOAH/mlsQapn3YcIAPggPBOzUAG5fwdAS1l9Q62F0iS+qyYJT2XTPDl57KjMIRZ/8fR8UK6ieSVQuuBwUDt3yeGSefLp9+9OZIqDnGB0mv4dkek7WxMnc/bNYlVtH0euZK/ZMc/VdhNR0uRCGh+S5t5Xa5xjbJqkGeXVeL4X1HgyQRZCSUBCiZs9m/U0up1As2k0z7ytkY+OXFpsT6EgYaLH8hHYVHgbxER8yxX5AWmPt8UQbFTnresAfcYcqSY3Z10jw+f4wlJGH7AMB9aimwyv/WHKnbZCllIYunOZZwJN52wcAfE0fBVASR6cZ02IUJyrbrVnWmd0Q3qz7YB+B12Dv43IvnBXlf6zaVssOXtQZnvi19bxl9GXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGczZTlYNy95YWxhb0VyaXZtSTZWMUpMYjJ3KzdpWnZOOUhkN1pyU0owMk5D?=
 =?utf-8?B?Y1ZEdkdPTzlVVTUvbGZrNHBZaUY5eWJ0M1dCMENrQUkvU1FheHVlYkZCZHB3?=
 =?utf-8?B?dWloQlZiTk9uT3R3bGhWbElGTzYzSGhRODVvSzhOR3YrSEIxZk5hRm5xUU9D?=
 =?utf-8?B?aHdKdXF5R283NFpTeWxsYzJ1Uy9QOERZVGorS3hSclp6cEI0QlM2endDSEhm?=
 =?utf-8?B?UWlyUGU5SmRJSlR1Nmo3YS8zakM1UEpuTVczVHh0YXZpNldnVzZmNU9RYVJ4?=
 =?utf-8?B?dGZDd0Q0UCtsSW9Za0x4Nk1vZ3AxYkhEMko1U1ZzU3ZOMnFKWWVJMldsUStl?=
 =?utf-8?B?OG9kNG5jbldXYjZlR1JoYSs2ZVllS0N1Q2s4NHNXdTB5ZEVZakp3bDdvd3o3?=
 =?utf-8?B?VjJoUm96dmxJeW5ReWxKVWFhMjl0ZDdkREJlakRtdFpjb1d3dGlOMW5FQmFv?=
 =?utf-8?B?Q0ljZzAySHZweVQ2V1V5cDdZRjkwYXlwS3JyVjN3RVV1NFBoWElhRlRMak14?=
 =?utf-8?B?cEErTEoxYnA4L2dwenkwYTJycGt3bUNCWGl1aTVRLzBKNzFGWTlwQk1CSzlL?=
 =?utf-8?B?VHQ4UjREREQ0ODVDNndHYitGd1IzdTM2cVNKdTdpWVd2T2kvYmcxYklZdGU2?=
 =?utf-8?B?dzJhanY5OTlHQWMzVnJhb2x6SDFzZFhzSDJtTnhsVlIvMCtUWTE2VjNtT3ZR?=
 =?utf-8?B?aDllUVdybkptT3F4S0o0S3NFdW9RbjE5cnE4bUdlWHUzdDlNNFVQaUNLNVFt?=
 =?utf-8?B?bW5NZXFSRERaSDliODFiaXhwRVlUUnhCd0ovK2FZWGdzaUplQzdFS1E4anJV?=
 =?utf-8?B?WUQrOXB2QXM3ckg2RFpvZld2R04wUlVJQUVnSEw2eXR0QjRXRFJTd0hkYUls?=
 =?utf-8?B?RTYvT256VVdHL21EOFdvb2JqYkMyR2xwbTY5Z2RrUVU0aXJRUTh5SVdaRjZX?=
 =?utf-8?B?cHAvRVAvSXE0UG9jeEgxK09FMnFGNUd3U0MzZXZONzQwMzhsMlZNbkh4RElW?=
 =?utf-8?B?UG5GZDFVR0dkOWFJUkZhT2p5ZkpXZE5XdEQ0OE9iMjFGQVNNNkorU0lNb2xh?=
 =?utf-8?B?WW5jSTNzZkc3TlJUZkhtODkvVWNBQmQ1VjYvTk40VW1Kc0RNcVZWaTFsRHZL?=
 =?utf-8?B?SWt2RldOWTdYbTllQUZlZmpnSVdZUzR0cXRCWjgxM0pESnFTbFdSZmxIMGpR?=
 =?utf-8?B?K2gvWnA1STR3di8vS1pwVlRpK2xUK2IwbzZlN09Pd2I4UnMyZlVMMzJoVkJK?=
 =?utf-8?B?bXpYQWdZZTFuVFN6ZmVGR01obHFTcGZTcmJEWk1iekpkdHVXbUpGaXF2L0JG?=
 =?utf-8?B?RFZJTXptSkpkZExqeUtDTlhQc0o1TlY4SHcvd0JhZkhQQXdxdWFzSWJPZnpV?=
 =?utf-8?B?WFF6WmhTdnIrMmk1SFhNUzFLL2FpSnRyRHFIU3lvd1VpdTZuZ2RVZFBqb2Jq?=
 =?utf-8?B?cGdGK3pDSVp6dTY4RDNHcUpJSHd3V0hUcEwyWFJQeDNkUEczVU9GNWNhZGIx?=
 =?utf-8?B?eUtCbnVFWGhpQjArLzduRnB2dkJIUlZ3aENRQVVQcGR4WSsrK3Z5MmdPWm9y?=
 =?utf-8?B?YjdDR01OdEREbVhoM21ra1NNbHdjdzk5VkwxSUhmY2FVcFFqcUZLeHU4eG0w?=
 =?utf-8?B?a2NZaXRiaXBFRGtubEFVaG5nbnkvOWNlOWVyL0Qzb2J2TFdvOUpGT2IyQkhU?=
 =?utf-8?B?QWMxSnMrV0RDWUZydGt6aWJ6bk0rZU4reWNmYlNCcVZxNmNVMlhlN0lDL1ZF?=
 =?utf-8?B?Smd4Q2J5aGZtV01KMmRsZTZpVnArRlIxZi9xUzQ3RXNVY0pNNTZMcktFRWVR?=
 =?utf-8?B?cUtOSWR2dUZRVktzMWlBVWNybVVYQkcyOHBDa1BzcW5vQVNqTXgzbXgzRXZ0?=
 =?utf-8?B?NnhFbkpxWXR4eEEzTlBNVTZ6WjJqSmM1eHZZM3d4L0t6YWxVeWhFdVBkaDJp?=
 =?utf-8?B?VC9Hd2Ivb2lnZFd1SWhtQXpaT0RqczAvenFxeHUyTFFHSExOaVlYVDRmMzdi?=
 =?utf-8?B?b3UvUG5ncDFmZWVXVk1GaGFIR2s4NzV2QlhIWWxDTE1BN0ZiNUVreEZFNXRI?=
 =?utf-8?B?eVhNK0FJdzR4emt3VEd6ZmdSa3h3OXNsb1VEZEx3VWRqQVFVMklST3Vpc0dl?=
 =?utf-8?B?QUlSQXVvaUhvZEZRd3JRcFNmbzg2ZVBYOEJoRUhmZG01eExmOGYzLzJZUS9r?=
 =?utf-8?B?N0gzVDcxaEVkNFFlWERpazlZRUlwc082Wm9NSWpqVDQ2VFNiTVEyZ2VvQlFz?=
 =?utf-8?B?ektRTmE5bGZvMjFzQ043Yis4cGhpMUVrdEt1aUhNMXJLT3RIYmJSbE5sdStS?=
 =?utf-8?Q?kylqrk+b/vutPmGmdn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfffc871-0654-4111-0501-08dea1d282d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 07:24:24.5643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8ktX+Wl8dGYca928uikO6+DT5jZbpVId67ZqLHUbAu72OnORKeOsEpE4TmBYCrG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819
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

On 4/24/26 02:49, Gabriel Almeida wrote:
> The read_indexed_register helper is duplicated across multiple files
> with identical logic.
> 
> Move it to amdgpu_reg_access.c as
> amdgpu_read_indexed_register and update all users accordingly.
> 
> No functional changes intended.

Yeah, as far as I can see we have already abstracted the HW generation depending parts in amdgpu_gfx_select_se_sh(), so the change is most likely a valid cleanup.

> Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> ---
> v3:
> - split into two patches as requested
> 
> v2:
> - move read_indexed_register to amdgpu_reg_access.c
> - drop amdgpu_common
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 18 ++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  3 +++
>  drivers/gpu/drm/amd/amdgpu/nv.c               | 19 +----------------
>  drivers/gpu/drm/amd/amdgpu/soc15.c            | 19 +----------------
>  drivers/gpu/drm/amd/amdgpu/soc21.c            | 19 +----------------
>  drivers/gpu/drm/amd/amdgpu/soc24.c            | 21 +------------------
>  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         | 20 +-----------------
>  7 files changed, 26 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> index 540040c76..daefbeeee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
> @@ -956,3 +956,21 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
>  	}
>  	return ret;
>  }
> +
> +

A bit kerneldoc here would be nice to have, but not mandatory.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +			       u32 se_num, u32 sh_num, u32 reg_offset)
> +{
> +	uint32_t val;
> +
> +	mutex_lock(&adev->grbm_idx_mutex);
> +	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> +
> +	val = RREG32(reg_offset);
> +
> +	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> +		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +	return val;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> index 4d88e5cd1..a1011af6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
> @@ -160,4 +160,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev, uint32_t inst,
>  				    uint32_t reg_addr, char reg_name[],
>  				    uint32_t expected_value, uint32_t mask);
>  
> +uint32_t amdgpu_read_indexed_register(struct amdgpu_device *adev,
> +					u32 se_num, u32 sh_num, u32 reg_offset);
> +
>  #endif /* __AMDGPU_REG_ACCESS_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 030d80664..72edf5326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -354,29 +354,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
>  	{ SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
>  };
>  
> -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -					 u32 sh_num, u32 reg_offset)
> -{
> -	uint32_t val;
> -
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -	val = RREG32(reg_offset);
> -
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -	return val;
> -}
> -
>  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
>  				      bool indexed, u32 se_num,
>  				      u32 sh_num, u32 reg_offset)
>  {
>  	if (indexed) {
> -		return nv_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
>  	} else {
>  		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>  			return adev->gfx.config.gb_addr_config;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 27bcbbae5..87b398dd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -401,29 +401,12 @@ static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
>  	{ SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
>  };
>  
> -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -					 u32 sh_num, u32 reg_offset)
> -{
> -	uint32_t val;
> -
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -	val = RREG32(reg_offset);
> -
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -	return val;
> -}
> -
>  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
>  					 bool indexed, u32 se_num,
>  					 u32 sh_num, u32 reg_offset)
>  {
>  	if (indexed) {
> -		return soc15_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
>  	} else {
>  		if (reg_offset == SOC15_REG_OFFSET(GC, 0, mmGB_ADDR_CONFIG))
>  			return adev->gfx.config.gb_addr_config;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 7e4353d0c..93c002e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -306,29 +306,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
>  	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>  
> -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
> -					 u32 sh_num, u32 reg_offset)
> -{
> -	uint32_t val;
> -
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -	val = RREG32(reg_offset);
> -
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -	return val;
> -}
> -
>  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
>  				      bool indexed, u32 se_num,
>  				      u32 sh_num, u32 reg_offset)
>  {
>  	if (indexed) {
> -		return soc21_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
>  	} else {
>  		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) && adev->gfx.config.gb_addr_config)
>  			return adev->gfx.config.gb_addr_config;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index d1adf19a5..265db9331 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -132,31 +132,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
>  	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
>  };
>  
> -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
> -					    u32 se_num,
> -					    u32 sh_num,
> -					    u32 reg_offset)
> -{
> -	uint32_t val;
> -
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -	val = RREG32(reg_offset);
> -
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -	return val;
> -}
> -
>  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
>  					 bool indexed, u32 se_num,
>  					 u32 sh_num, u32 reg_offset)
>  {
>  	if (indexed) {
> -		return soc24_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
>  	} else {
>  		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG) &&
>  		    adev->gfx.config.gb_addr_config)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 709b1669b..4a5fe8e9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -184,31 +184,13 @@ static struct soc15_allowed_register_entry soc_v1_0_allowed_read_registers[] = {
>  	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
>  };
>  
> -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *adev,
> -					       u32 se_num,
> -					       u32 sh_num,
> -					       u32 reg_offset)
> -{
> -	uint32_t val;
> -
> -	mutex_lock(&adev->grbm_idx_mutex);
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xffffffff, 0);
> -
> -	val = RREG32(reg_offset);
> -
> -	if (se_num != 0xffffffff || sh_num != 0xffffffff)
> -		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
> -	mutex_unlock(&adev->grbm_idx_mutex);
> -	return val;
> -}
>  
>  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev,
>  					    bool indexed, u32 se_num,
>  					    u32 sh_num, u32 reg_offset)
>  {
>  	if (indexed) {
> -		return soc_v1_0_read_indexed_register(adev, se_num, sh_num, reg_offset);
> +		return amdgpu_read_indexed_register(adev, se_num, sh_num, reg_offset);
>  	} else {
>  		if (reg_offset == SOC15_REG_OFFSET(GC, 0, regGB_ADDR_CONFIG_1) &&
>  		    adev->gfx.config.gb_addr_config)

