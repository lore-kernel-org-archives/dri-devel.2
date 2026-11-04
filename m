Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58047606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xrWOqnl3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B666410E86A;
	Wed,  4 Nov 2026 09:32:16 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6766F10E873;
 Wed,  4 Nov 2026 09:32:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+ksIMsuQAjvYkjvWIMSPtQiR4skdp11EJHOWV57cGwkSbizYxvEW8EfRqQ7Y5W/nntsfK+t3NPYU2rLQFW/k99U+PBs76fLWbiZjDVcBbaif1M6hTUpDLFkGZxqYY+9xQ9YkEmrZS/F2/WmpPJKkqNRpByzihOdCrFNOB0nAgh7grOwmbcMWeOGikudOmksHspPomcT3pEb7bQUssjVmKPDfmHz1ZMUWuc83PWvYCuESJiBSiyMWXHmWTFLTcxQkA9ZExydnimCz6kaP9aceXr7UxzopPlN8OV4l51lnZPtcgVvr7/VD7597pMm3RQ3lNzCGgLriz8GJzSjoWOD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8O4jD8fT828/rZNp45jfXvS9KH/2Hm9ML/XA/hyGRN0=;
 b=BMFGPwOqRXjSE9DSoVNPVulekuY+phm0FHmSGNPf9PGjt1laB4zPz+6Tgj2xJ7Ke5/YHuei3I+A55znA2khDGQkc0mrNJUG2qGga+Y2vhTmZ8KsbLCTu6mKuY+TV9xY9r1HilAWcRzUC8MEo9zozdp2ShMpNG78KFGF+//suy+otNq8Cm/DP5RE4GZAwp0RlqWkFLIDhKvC4HsO1Mx3eAwcOPQpGzQ+LF+25iFxhPgyxQPhHkugjQig0DvpcaQpcvObdUAy6oLXib6AgZyyxo2Vqb6onPGxTliux/ocW4hqYrAHLKQJbk2hEn572VoZ6E6p/nyGloTtH5SRnuXYo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O4jD8fT828/rZNp45jfXvS9KH/2Hm9ML/XA/hyGRN0=;
 b=xrWOqnl3Agnk02/1hUJPzkQRtem7LN2q2Mefo7aZdY1MptRwrIgJK/cEKKGgmSJ1kLlKWelx42HpeAas2/y+dnhLGJ2jMIO1tJ7ixjIxux3IRjAUJPOUJgy3eCEr11fDyzk5Szjt5quZY63Cf7Ku5AvmGivxMAu68JkAFvFUYt0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:32:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:32:06 +0000
Message-ID: <0566b969-cfee-444c-8a94-5fbb42859e07@amd.com>
Date: Wed, 4 Nov 2026 10:32:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missing parameter documentation in
 amdgpu_ttm_map_buffer
To: Arnaud Bonnet <abo@medichon.fr>, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261104024754.166260-1-abo@medichon.fr>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261104024754.166260-1-abo@medichon.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:52f::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: 71443a24-aafb-41b4-9497-08df3a567e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006|261022105027099003|261102123227099003|261009223027099003|261021121427099003|261026140227099003|261021135927099003|261026121527099003|261028144727099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: Gi869VCmbfg7FsyOW8bFYUAPWHnoLaDtzjlW+0v9kMnpRPqT0ytLb7R2AEvrf51pjWBe6GUOpX07U5Ua0feORe/YlXtfE9MBEEB0MAF03S4rwa5PZ6QlkZ0mypplA1fODQ6Ko7IymrKauzmXcWxYz2pok8l/y1m7YTLow+9qs5WySOgAavEoM9HBo8AJrlDXewwr+NRoAZ9pY4rVVNaHsqy2+uaLk224kWgCjOeQ3hPMKtPKLGKPGvEE7j01TNOLfcT41n0F4LByqx4TWbzvJ4ACmfAXqDX7DrI9jOBMYtSs7GwTJbvhOAT0x2c/qdfE8moiFwlhsUXKnUZgRjfzEJXnYUh/Udg3sFFPziC0vIue6HDnPwNAdj8oaOm8VwSNn9+8IR0hSuaFG2TvQfyHE9CRdlXRJ3jCW0I5Wro7i+/rgwD1/2DMmzIj6CVoj/nzVs1tPyjWr6kbEzsa8KseilyN4Y9ySAjPNWl4n70CkF4XI7sJqTQWcepFYiiYwy+6GKEAO3SrHrzJyY9MlJdusTLgF5lEtFRhf/RzRqBG6muP76Xz52wCDKidO77ueWgUcftkSIIvg5wZ+oTSJghfwLh5ad+kzjudVn9tXt+xr8/uYjZYts/q31JoLdiLLnHfEwp/thyqVCsoLM8Gk+nryMuRLPcvyCYxeHGUMFy1bj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261026140227099003)(261021135927099003)(261026121527099003)(261028144727099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1d6SFZvMTEvd2h1dThDbUIvQk9RMGRxUFdiZWE0TkxFQ3ZNb0ZEczR3ZmRL?=
 =?utf-8?B?eFlYaHF2WVROWHV2L2JXeVRMR2RRK3hQREROMTRhWWhETDgzMDNJbTR2aGhP?=
 =?utf-8?B?RUFQSDJiNkZlamFvbjZPNEN1eUpSZVRqcDRyK0FJYnROVEhJcGtqZHhaVXNm?=
 =?utf-8?B?U09iVDFzVHBsUEFnMFdEYlB6SzFUTFUzejNORG1XS256RlgvbnZVZ2dVZUJl?=
 =?utf-8?B?STBIcnVQMWpxb1JSQ2tPbWJlbHNvbGhzZnJDVTczODg3czJHZHAvbEhPRXdD?=
 =?utf-8?B?Uzdnb1NJckhDbHdVcUw5TUlvN2Jwcjdzc1JscmRNMDN1NzBsN0xaR0dJdm1N?=
 =?utf-8?B?UHh2UzFkMkg5WHhPdDlienljUkE5VTRnUzZRc0NPYkVqQ0hGV1cyWkJPN3U0?=
 =?utf-8?B?Y2lSVWRHT0E5RVV5RWFJSGJWR2lmVDU3RHc5WDZUN01FY1A3alY4UWZjVjh4?=
 =?utf-8?B?d2J2cVowU081QkhFbW9oU1prN2lGRUdjaUtsQ0Q2MzNWbHVkVmZpQkxEcEZU?=
 =?utf-8?B?WEp5TWlJVEx0ZEtyRXR2YmNwWXRpTHJyYlFPajZzN0tGK1BIRE4xcW5XQVFR?=
 =?utf-8?B?UUpGMmRWQ29Lc3gvVjZzWnVSZ2F5OTlENkZMbUZCVjFsc1c4WndEbldROEE1?=
 =?utf-8?B?Mi90emVnZjRwSURTQkYvaXNQaUdPbWN5OURxTUlpOHRSc2J6UWNMQUMxeU9T?=
 =?utf-8?B?QVRjRjhnZnp6UG5QRE5wNzVheFp3cnQ5OU85SVA5QUpKTHVReDhaNmVQWi9B?=
 =?utf-8?B?dTJEczBENklzOXVtM3JjS2NmWUVaU05LRlZLNGQwVkVHc1NCc2pybHY3QVYv?=
 =?utf-8?B?NUJtcjA2VkJxZkl3SmlnSW9OaldWZCtXTzQvbjRtMjJNVDBoVHp0L3ZFUzJ2?=
 =?utf-8?B?QUdydGRZZ0hZdVRuNjNsRHhIVnVoQmdDcVo1R041RVZKaUtaUEtBdnpFY1Ra?=
 =?utf-8?B?clRuS0k5WDdLQms3a2xPajlacjU2M21tT2R0d0ZuVVEwWlpmZmExM1JpVDlr?=
 =?utf-8?B?djV1MGdKeEZmNzVKNmt4NlQ0eXcyOWhvNGZxb1hjby9jMDV4MEswM0RqQXBB?=
 =?utf-8?B?WGp2TWNiaUg4V2ZsbDlvWUlZOW1Pb01NbnNKQm5ZY0s2R0ZyY1FTWFh2K1dP?=
 =?utf-8?B?ZUVFSXpsSE9MRGkraHZ2bStwbVJOc3FjbHRWbncrNXdRSm92dGZMMEJEcTcv?=
 =?utf-8?B?MWRxNkRMWlBiOWZpVzY5bHEwR2VjOWpldkkzallpckRYcGlmcVl4MFpiYlhi?=
 =?utf-8?B?cmZZMjBRVFVoZTZPTnltUHIwbk93Q1dNdjNiMDc3MS9LblM1TWhWSjlpU1g1?=
 =?utf-8?B?ZldwOGNrNlQ2VWgvSGlJYUZ3cmNlZ01qNVNGTjNBdE0wRFVaYUFMSTQzY3d2?=
 =?utf-8?B?OTArR0xIQVhjN3dKakVSZVcxSmlhRlZvMW5GV0pRYXg1MHJCdHZNMG5iR1Iy?=
 =?utf-8?B?VmxlbU1LZDlQejZCWk9iNnlFdHgvWFcwbklKWVNXd0ZRYXFjYjNCb0hBSExI?=
 =?utf-8?B?Rk5zY3JUZy9haDJLZVBXZDBjWnBvZXFLVnFyOHh4alY2NHAyRCtCUmdSQ1Vm?=
 =?utf-8?B?ZE9kd1gvU0FRM0dKMHVxcUVuMmNNelNLc3NCQmZEK2g0Q21IUWd0dklmUVNu?=
 =?utf-8?B?NFJZMGthajN5dUNLZmxQVUFYVFFwVVZDaFlGTWF5NDdld0NvRXp2aVl5NSsx?=
 =?utf-8?B?amZuc1dSa2F4QmlyeEdTYlZHbWtkQkxRSHRwT0RrY3lGZEhqZGVMNU5KTFZN?=
 =?utf-8?B?R1NCdnZGMi81K3kvLzZFZUdiSng0TzBCZDk2K3RXbFhXbmVNaGVXU1pBS3Q3?=
 =?utf-8?B?SWxuVjlMeGNRWVFDcjE3eWR5OW8xbW93K0ZkNlp0cDhSTUZYNEFCN2hHT0RY?=
 =?utf-8?B?VGx5M1FqR0h3ZG91RUFFK2pVKzZKSkZva21iMXB0REJxQzJWWGxUVE4xVjFu?=
 =?utf-8?B?N3BMdmZ2ZlRZU00wOFBDUDNGVmFqU2dXRVlMb0YzYXNiWkk4c1RIbzNOOFk3?=
 =?utf-8?B?OVBtNXlhV1lLRTYwekFreTYraW5hOGt2NVMwOXVENlZUUmJjM2pCY2g3Yy8z?=
 =?utf-8?B?ekxoMG5CZXZEeTNxKzhtQ1podTM5UGYxNkhqL1NDOFhiN0xnOEt5MFl2TThG?=
 =?utf-8?B?SXorZG5ybnpFcFNCbHU4cXFiaFc2RmZSTUtDcHVRN3hjNkZOdmNWSlllbVk3?=
 =?utf-8?B?VnpnSVJHMnlBemxJMDdhcG1pWjE2a1BkZk5LdGlqRjBDb05xcHhKSmJOOXVi?=
 =?utf-8?B?dzIrNHZuTVA0aXdMc1hCWG5Rdm5SY2ZZV2ZSOVlWck9tb0ZsdVBRWXJnVFFp?=
 =?utf-8?Q?0CYzQtUqWD6tu/X1K4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71443a24-aafb-41b4-9497-08df3a567e0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:32:06.7521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMQNHihRZTSYvyR3FOlv8oCZ45rpmKsYn6toJ5YR52dJpaxudR426llZgf8yNjuk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190
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

On 11/4/26 03:47, Arnaud Bonnet wrote:
> [Sie erhalten nicht häufig E-Mails von abo@medichon.fr. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Commit 48c4aaeef621 ("drm/amdgpu/ttm: Make buffer copy source readonly")
> introduces a new parameter @readonly in function amdgpu_ttm_map_buffer()
> but doesn't update the documentation, leading to the following warning:
> 
>   Warning: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:209 function
>   parameter 'readonly' not described in 'amdgpu_ttm_map_buffer'
> 
> Add the missing description to the kernel doc comments for the readonly
> parameter.
> 
> Signed-off-by: Arnaud Bonnet <abo@medichon.fr>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0f86777250fc..d3a875a32af1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -195,6 +195,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>   * @addr: resulting address inside the MC address space
>   * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
>   *                 needed) or false for a direct address
> + * @readonly: true if the mapping should be created with non-writeable pages
>   *
>   * Setup one of the GART windows to access a specific piece of memory or return
>   * the physical address for local memory.
> --
> 2.53.0
> 

