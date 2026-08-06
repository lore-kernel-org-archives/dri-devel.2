Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D8C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F179710F19E;
	Thu,  6 Aug 2026 12:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJ5ElJog";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BA610F19E;
 Thu,  6 Aug 2026 12:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/gMVqaJFLN6QuE2WeVl1HEjr14k4ylI36yzS7lN9FC3xYHMQ0V6H3sZ1YMMErPWP/NmcVtnaVmKF5PBKc6WktVNFhHR2PGDMh4VYkQmZG5rS6AWUkTNMfUxAhwejcFV0UDCrsDa0/a4QxMqOFzenEDHwbPcDCFPdvWhEZMM+J+EqXdlU/UXy0tP/aC+BL418fHQmL2kJ+WWXzmCO0tI9IFhKtSui2m4bf390+U3Q6p69fSCwgVWtDP3e0IWbU/BMYsIvVfbItMdOH+1xtn1Iieo7vY+KRGNTpu64g0rGGCKhkODAZJ6BAfUQ2mQoU/iObrYSZwqsbbZsVNmg1unlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsVCzaiSAeSMa1PiacsF5t7ie72Dc6TZzdqAXxU1u84=;
 b=rXTPeMmMlE3K+McRpS7Y9Ppx3d3Uavahya5dXlVzlTLGdDlaszk7K6mI5pZ1jaHBOEGxJSTF8dLa4jAIVu8sjm4jH3W1+MKdui+vlB2GJ1/m4MRicEDETFWXhntwhuc2RdLnkdI2V9qPmbhEIEt+wBhUe9uBfpAzC4Ap0FR1+/1PORua+jqVokLs9Iw4x+yUE3sKGM6miZfmge5edF783m2gFiIiZIQLEAnexvK6gREbVjRCRzrtsW57of93kVaIVVBJS2gxCOYoMjE3ernMcIWyBcrnMeyWWeqW6vmxaf0HvjDgA+XXiK9N/sQQs1i5XbKcYYNj3+Xks8ssa6rgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsVCzaiSAeSMa1PiacsF5t7ie72Dc6TZzdqAXxU1u84=;
 b=eJ5ElJog+ePzVHyNv2Bc0Jy1x0byKG+gk0zhLVwoCm3MEw+DRgrqDC7isCA5IwlEowqPX5I8Hk4qPtcGvbSLeWBL3RlLuBtAb1lHYKqUiZxplc1q6mluwJOsOFy5Pomjhc9WFKSdWFYZpMX/PwF33nhHb5kICWtJ0ucWoP8t77c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 12:05:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 12:05:20 +0000
Message-ID: <bc6907ef-41a9-4318-8701-397d8407d826@amd.com>
Date: Thu, 6 Aug 2026 14:05:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add the BO-va mapping offset when
 kmapping an IB
To: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-3-ce247012d4da@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a28afa-4159-40a9-9bbf-08def3b2fc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: pmAuUfRt8jsQb/9bv/KroZWdr45zpTxz7BB50tYrTBvcTPmZWuTJx42sgVIixe6XfeyDdUcDVVkZd9QING9bxH3Fg6vWhtQMvKz2qPlrf1RmjRug9wJBQc4jxwi5m/pzChToE50cSWyC979bFmgKUZC2ux3LtEGdRK6vUXYUq/m+FUpyDOf/1fyeAO4aLZ5OjLHAwLFEMs6CxJJ/7bUnF6zjyVp2SMCm3C+hCNxmg+/kOrdxKLUpKuqYp4dZC0Y0gYRK1paVQ6DGs01xGQSNwJEjuI7C1FZLBLTJcAXRnU+oUhPXrI1+qrG246/BbRui3NudhzJAcJTTwln/ZV7upNi0TcNwHU3iHFhWP6ymTn2x0keyWQp34qonADUGWyNBknihbJ8AnhBqkhAtZgtwPqRINEVzO/832zY1O0y7Os0wqDLuD/qfedSqzUI5+h0Rx5gGYx/HLpkrBh6T2iZjQv57dQ02l3LIMB7097+ez+H67FzgftnwBSGzBH4dsPNPsWFAVMOkoZ9ucm37fnntmeWD1/PEAJCU9Y/rdrBfp6PwrxoNWG/kYXKnSI3XeRY1CG8URyiYGAdFB54HS0B0yoGSClb8Ae/95Oz6RMbMULG6+79TNdQE+xfxjMmYUP4Bd2uiLx8XbrK4i71fLYcxJonHtJ5QKzRm+sVxmitkCC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJtdGpjSlg3T000TU1ldVdGYVZSOWNNS2h3MGdaYmo1ZDQ4aDk3dlN5cXE3?=
 =?utf-8?B?VnlLOUx2aDFncndvUzA2OFFDQTVDL05Kd3l6ZXhuSWRzQmZ3VklZTm1Ca09G?=
 =?utf-8?B?dlZpQVpabVVlb2pEOVBlSXVoellyRVN0NnUvQ0RiVmxWWUhXd0NhT1lYaXFE?=
 =?utf-8?B?bGVxaVkxWW5BNm5QZGNiWmxRdm05ZWppbGJaNGtPM25XY2E3U0p0amJPQkw3?=
 =?utf-8?B?SG5URFdFM2dhR0Y5dHNVNkdBc0sxS3ppb00yMThrd1B2YVBLdUtVeVM4ZVVt?=
 =?utf-8?B?ZkR2ZEZxY0NXUUVPVU5WdnR5c0FFdzI4dlFpMzhZWWtNZEhxRzhXYmFOL016?=
 =?utf-8?B?c0xDQ1pueUxYTHdXcW84YzdLQXZzdEFEZXdRZkRicHJqSTk1TEZmUk0vSG9x?=
 =?utf-8?B?M082eFRzVFNpVmtYV1dVQVU0OGNHM0pEYm1aNnFPRTBRK3N4QWJKSUtWaHFr?=
 =?utf-8?B?Vm5Ha1lsSGF5Y3ZWaW1MM0UrRTZCTFJUNVBTSjl1RXorM1ZHS2lKcEJOK2RV?=
 =?utf-8?B?cytKbDhkdUFFa1pJV3U5WFcwWW52UXpNWDYxSTNnQk1QdWRiaG9PcVNzdjc1?=
 =?utf-8?B?UERyemRUaXZ2TS93YjlLTE55bkhIbVBUZ1lDUjE0dGpxZzUrL3FHZXB1eFln?=
 =?utf-8?B?a2oySGR5SUJZWnFvS2N6VXozU055UFZCaVVzTDFXbWlsanJGb2szSnBlVUpS?=
 =?utf-8?B?M2RpamxuM1JoZHd5ZnZuT2FjckNKYmhXZnljREZnajJWbU54NzhqcUMydGIv?=
 =?utf-8?B?Z1pUSjBjdS9WNklIS3p4M0FnYnBJY0pWSS9zdXpBUXFrdE01YzNndXR4K0x1?=
 =?utf-8?B?QVYxL25ZSytEai9zSTduOTlXeHlkVmJqREVubDF1VVEwQkk1UmJYbEE4UExG?=
 =?utf-8?B?Qkw4c283UnNuaGtRRWNyZXFrTVR3dkRkakhzY0dzN3VxUldqTDdNOFN4aS9O?=
 =?utf-8?B?dm1JclVMQ3hjZUNUdlpEejY4QnFTdmhJU3RSUmNkazZFMTFmbmpkQXA4UUdo?=
 =?utf-8?B?c2dkMmEyNWhqY0t4ZGxDMjZocUZyc0JwaDlQWXU0eW1ZWHRZZkgwZjZ3YjZQ?=
 =?utf-8?B?bXUwR2huN0pmYkpzU3JhMmtGU3pzVDVyYTkyRjkwaFU3cmpRNk1vQXRXdGM0?=
 =?utf-8?B?Vlc5Y202cCtaY1B5UWUzSkoyRS9BQ1FROEVaUnVhUWo0QXJjQkR4NVkvQlhU?=
 =?utf-8?B?YStDdVdUdjg2bHIvM1dFYjV0R2xSdElWK1JoNnNoZ1F4Q2lPRFRvVHJvdU9a?=
 =?utf-8?B?Zkx2NWxjakkweUltdzh1L2dsUkZzMko0VkdFc3YrVGhvejBPQlFmYjJlNWwz?=
 =?utf-8?B?UzdpMFV1Rm1nNHU2UzUrYnNHZEhrdGtOS2Q2ZHM1NnZlR1hzY056V1lid3lK?=
 =?utf-8?B?ekwrbDJjZzY3RnM3a3dYekJENjhZR3o5Y2pwWFU1Rll6ZU9CTHVjSXhLM0ZX?=
 =?utf-8?B?S056YiszdkphZmh3bENmdVhucHNDZkd4TlJ2WWthNjlzWXJVWVNabjcwZ1I4?=
 =?utf-8?B?VVB6MS8xUWtOVnYzVkhxd0wzdmRwK0JhbTFCUnNpcXJRQTIydVJZU2FYV2Rk?=
 =?utf-8?B?cFZZQ2diNUZYdHk3YmNkelNwRjlFZXMybUZMb0VzVVhrQ2R3OUlMM1VYSWZr?=
 =?utf-8?B?Vjk4ZEVUU1N6ODRwaW9VanJReXAyQ1dyby9YNW1BdjQvaHd3THVQTEFrSWRj?=
 =?utf-8?B?Z3NYY1JTd1VZN2QrSkYvdU43dlIxRzNyTXRXejVUYnhJdDk4VlUzaUFCT3px?=
 =?utf-8?B?M3hSckFWL2pwZ29KZ2YwVTlRZFc5dUsyV2pzMXlGTVplWlRIVXR6U2g1aktB?=
 =?utf-8?B?RUNERUoxQ3l2ZVRRdE1oVVdTcnJ0U0JGVXpRb2RJR09yL25pSzZkNmZxRE5Y?=
 =?utf-8?B?NjFWUHBlcVhTR1Y0UmdPMXpHT3dNTURzMXQ0UmZKQ096WHNUSVJOSDI0cSs3?=
 =?utf-8?B?aEZoZTAvZEpybWdpMlI3dS9aai94N2FCMkxjYUZmK3hLMVZvVkxiV3FtUURN?=
 =?utf-8?B?YjJQM0YwRlAwQ2czQmJuK0MzZGJVY1NtOGVRbWFqT1NTVzJFN3RzcUl1TDZt?=
 =?utf-8?B?T05oeGpVei9Nb24yaHlvVm04Yy80REtNZHA2SUwxQzBFT0x2YzdoaFA3RGlE?=
 =?utf-8?B?VGVrUnM0OVlqdWt6Z1A1MkNnejhmL21oSitNZnV1eFZHZ05zelZmK25ic282?=
 =?utf-8?B?emdjYitDV3FLU2hqaHBmck9PeXVuYXhEZnN3S0ZYYUFXYzdMQ1BtQ0Npbk5J?=
 =?utf-8?B?cU1EelNsOXdIWUsvTkhQQTJta2g4RjFUaW9RTnRqQXA3N3JsdjdGYk9DdC91?=
 =?utf-8?Q?iLcfoNxCajgsBDVT3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a28afa-4159-40a9-9bbf-08def3b2fc97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:05:20.2570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/+w+sBrurCztAxGHk6PARlsXEPHGETCVScYbNtaqSz1kUN7urSuKFq6yjYJNFFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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



On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+moonafterrain.outlook.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> amdgpu_cs_patch_ibs() derives the CPU-side view of a UVD/VCE/VCN
> indirect buffer from the BO returned by amdgpu_cs_find_mapping():
> 
>     r = amdgpu_bo_kmap(aobj, (void **)&kptr);
>     kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> 
> amdgpu_bo_kmap() returns the start of the BO, so only the displacement
> of va_start inside the mapping is added.  The page tables, however, are
> programmed from mapping->offset (see amdgpu_vm_bo_update()), which
> records the offset_in_bo the client passed to AMDGPU_GEM_VA.  The GPU
> therefore resolves va_start to BO byte
> 
>     m->offset + (va_start - m->start * AMDGPU_GPU_PAGE_SIZE)
> 
> while the kernel inspects the byte m->offset lower.  Whenever an IB is
> submitted through a mapping created with a non-zero offset_in_bo, the
> two views disagree.
> 
> Add the missing term so the kmapped pointer describes the same bytes the
> page tables do.
> 
> Every other CPU-side consumer of amdgpu_cs_find_mapping() omits
> mapping->offset in the same way.
> 
> Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")

Good catch, but completely irrelevant in practice, so just drop that here.

> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 9c514cb01096..a72cee871af3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1047,7 +1047,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>                 if (r)
>                         return r;
> 
> -               kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> +               kptr += m->offset + va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> 
>                 if (ring->funcs->parse_cs) {
>                         memcpy(ib->ptr, kptr, ib->length_dw * 4);
> 
> --
> 2.51.2
> 
> 

