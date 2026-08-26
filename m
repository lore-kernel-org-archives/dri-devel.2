Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC2BC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1B910EBF2;
	Wed, 26 Aug 2026 08:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JYar7Lm2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C4610EBF2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZx8Nb9NLEouNkNodAYp/UP1i+PapZdGQyAoW5GMs3W/xxeeHzJDFrD63dXgzfTpKkYCDIDuyndrt8qB8bSCXPaMnytNj3u+j0T6X+FWmv8ufBdyAxs0zqTTqro6VOACIZYLMaaAQn2Ag3n8mLG85B38UEvlP9t3FQZBRqaQlQq5alZZtuYhNuRAjoizGSs9PXyH+CuO31Usaz62CBz16cq63PLCVQ2u55YzDeQR4YO8h1bmJMuGjp5djym6wirgdLByVFYqxkSoOIwS5Kt6iO0TSYOA4cN6KC2km5Q7QwDfaDXF6L+JSvLj4NUyDEwgS2rbT4vQ3MF4qU0D8bwgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEbdQ6fUxRHe4Pma5TEaDLk3pHhBx+ccjaxwMZ1W1rI=;
 b=LxvmeSVr2jyhbZ+DlN8mMWIBQBhQhxO+XeASYBFvyZOU/l50/5x4vwe74ntHUHxFeCwcQ5tlwyIH+mN4BjcalpTmKHLHOkrlZumiDEjHWQ8YU6x8EJRidtJCCoe5MWjPreSDzhf6NAhI+3mm2ZbPplHbvUV58+FhSKP3uq8xztkk2m/bF32VqPWVj4GbqBnFfBYkAJjnVIJODYxjRvc1QA9mvYkA3bq1zRJLT7oXZXjULicf7u8fpiFO399lTC9NKS13yYVC1qz1Gtm2tdgE/TVzIK8g2z5e6oJO6wvP7T3BpgFhVYa1v5yFme6XCreXOLqsXT5oqm4ceelVtLbq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEbdQ6fUxRHe4Pma5TEaDLk3pHhBx+ccjaxwMZ1W1rI=;
 b=JYar7Lm2Z3sERWCAlpkNjJpO38SGwLqzEUDoMJPB/EUSJLxPwAVqxBjyV6wXXV0XY4gPa+RWOuPi8WbmsT74fYD5i6t/m4j079FS5IVo6crBDdPdBrGeNmhhCxk9m7LrN1YgYS6jDeja47uCrbVSJ8DdmezmwBtynzRCjNQ7g1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 08:37:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 26 Aug 2026
 08:37:39 +0000
Message-ID: <4aaae413-ea6d-4865-be67-f352ee23aa4b@amd.com>
Date: Wed, 26 Aug 2026 10:37:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
To: Lizhi Hou <lizhi.hou@amd.com>, Taimuraz Kaitmazov
 <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.43960-2-taimuraz@kaitmazov.com>
 <5933effe-ef28-9838-1dd5-dc904be0a3bd@amd.com>
 <87c9bb85-2514-44ac-a976-e24526c7f76e@amd.com>
 <a782e2ad-d12a-66c8-447c-725d8e66593d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a782e2ad-d12a-66c8-447c-725d8e66593d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b0b6d8-e131-4581-bf28-08df034d49c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zjAzUlaI+EOJf9zPVw7VcDYFcw/+cgEXcLJTjP+P8F2d5psUvDRPzRL2i7BavsGT9w2HHuXBnb++VdD+LAHVeE/bETOiH3Dy3MpWbaq0sY3O/fffeoyQLVBnsyfU9VrijJfBEblnNJXlUZSRQQpMW1ZjyRbhTgcDSrJYbrn5sdZRZ/GwSkD5qFKe89hlcZT00ZhadrVTt326udAv4hKVGc3/VFpFM1/5DXWg9TVViWVBfHVimnfcT0ntT2CHFOyNOZauySh6iEt6Po6JrqcTCa5WB3hSTt+AyzV9dbTdMwUJnJVIC42BW/W3Vt7u0THpzT8aUGVSKEpLZQbe/Scgsw8VHo3/KD9eRnWYJAUJ3nHG1DcQhac6EGDiHmgTJs1IsCC+uu8irkLc6rlYRSOu5jCI6bykmsi92vFpHfAFg5nnBB1e+dp7K+KUdMWixoPupl6THrYB1WdxwjY5A9PeIAaZaIjv4sf+Hm43DguhCDvzj+xSZx+42UH7wuweqBcsAfSGvep3myq1NGpxkd72HX1J+IeeCF3DYSuINaLy1wnADq3Op7EwY/BIQdLIso62U25HgVbiiEpZucLCl4IZ2dkxzZho2gRoP7KrrXy+mNJ7L4OqD0vjeFQ6FcCIR4HakLPNLJrIE9rF2nU15XoLGSLv3S1eKKtxf3YoQjQN5uQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0xaQnE1VjZoUHRXQTVoSEp4Y3Y0ZG1McmVDeDJha1RuVHZ3NDJpQWNkWVhS?=
 =?utf-8?B?SVJSQXp1cmYxQllubFRJckJCNWdrM2VBOWc4VnFxcHBzUkt4TTc5VUc2cWND?=
 =?utf-8?B?aFkvNGlFQlNWRURpQ2wwUEJLU0ljNmpGK3QzQXpVck5GU2ZjankrRmtOZVpL?=
 =?utf-8?B?OTV2ejFlejZ1TDk1cnZBL2xRK0JpZWpPOWdOZ2htUTEzekhpa3dTYVNiMWRF?=
 =?utf-8?B?STlKRnBkMnRuRUtTdUVadGtGT2FzTnZYZGFjaUR2WGtKNWNxY0lHbldJTStt?=
 =?utf-8?B?MmpEZ2h1VEwzLzh5WklpUzhpeVlHM3lxdW9GaUxaSmNIQmpBa0lycUlhUDlO?=
 =?utf-8?B?MHRSYlgwcEhCNEtRaWhIQWZQOWNNWkVCelMyMDBqL1hnVjBxMlV2d1lzZUJT?=
 =?utf-8?B?RXJOTWJteGJVNkVMUWZDcklYeW5ZRldJeUNURjl3Q1VyL0JwZ3FIV052UFlR?=
 =?utf-8?B?UTg2T3NYT3lYSkt3aFNIeVdaN01YQ0JhYzROYkFWY2MveGVpemtlVnVqUFBT?=
 =?utf-8?B?RjhoekZkdktIRzlDVjRpSDBQL0FwRnQrSzAwZXR1ai9jTlI2SE9YQ2VUdXgr?=
 =?utf-8?B?cllxRlFlMXBieGpOb1hpS0tqTkUrclJOdDlIaGkxTXdxRVJ6RmhMWmJYekhs?=
 =?utf-8?B?aytxdXlvRS9oN3prYW1PajRVZUU1Tk11K0J4UGYxUk1odDc2WWVUOUd6R1ZI?=
 =?utf-8?B?YTRXTVJlelg2aSttMUhyS1ZmMUtkQ1I4aktVeTQ2ZWR3V3dIa2pXcHdsMDZD?=
 =?utf-8?B?V1paVStrQktJNzA4Qzk5Nlo4WkFpd09vTFVqaENqcXV1S3kwY3FTbE55clp2?=
 =?utf-8?B?NVBaaURjVFZnQ05qc21EN1N0OUNoNXRQS0gyOUxuRW8xMkZZdStEVXltSzl4?=
 =?utf-8?B?OGlIWUl6czZtOEZQU09tL3BnczB0aEIrbWM4RlNjYzc1VldhWXZxQVp3SWlF?=
 =?utf-8?B?aTJneEw0NzNKNGx1WVNORUpBV29GNTN2aUJvc0xIM0orU1RKVE5HTzBheGh6?=
 =?utf-8?B?M2tQTlBrZW5aWEk0dkZyQnU2VHZ5NmQzbmIyM21yUlBtMVhpbXFJa0RSQTd2?=
 =?utf-8?B?eWlIY3FxUElCZHBNN3lJUWlzWE1FWGs5UWhtZXcyZ1RPVHdLU2k0bkRubUpo?=
 =?utf-8?B?RXFSMUxvTDVHb2R2bGwyOC9SZTh1TjZEWVQyb2FuNHp3NEtaV2pWUHBGS2N4?=
 =?utf-8?B?aUdnOWFaOEk0elVIaUJlQmh6Z2owSFFIWkUvYUNXL1dwRFNCdjR5QjViMW5p?=
 =?utf-8?B?NnNWRDIwNHNpVTFxbWZJaTBpTmJreVNNL0FJQXRjNUd3NkVHQTlmdlN0TWFq?=
 =?utf-8?B?OHlIbGRSc2ZUVXJTR0dkL3RBTERRWVVhejAwTDRLemNBOXBHaTFRd1ByTGE4?=
 =?utf-8?B?cDBKbmFMdGVMc25MUlNjZ0VHOWt6R0ovbDM2T0ZZeTRKRGdyeUJBd1ROeGpY?=
 =?utf-8?B?VXBJaU5ma0ZtRTJDSGFFMmpzWW5DbHlzOTBQajBPVEx3cHdyKzY4WVJzdFNK?=
 =?utf-8?B?T2xYWTNSMVljMG52UWVrOTBBQUlQd01QaFd1S3hubzRvcXk3OG9VTHFqbnAx?=
 =?utf-8?B?NXA4S0lmY2N2NHUreEZ1WnFCbnk5WkE3cis1OCtuRjlJV3FtbXJLMXRxcWtj?=
 =?utf-8?B?dG9KM2hyRTRjSnRhNGF5TDAyR0lISFEyekRFMjJlaW96VmdwYml0RU8zbXlX?=
 =?utf-8?B?WWNNTmJLcHc1K3ljZWZrS1ZxWXFCVnYzZmVRdHRLT2k0clhubW0yZHE4aEVl?=
 =?utf-8?B?ZFRBa2JPKzIvWS9wSXZ3bWRCZUw3eEpCeVZRQTZ5YjV0MWtjM2N2WVA2b3U1?=
 =?utf-8?B?ellUVjc1Wm5yNk1xYlhVdmlrSnZCQUdjU042SHJWQkVlWW5leGZOeEo2dkUr?=
 =?utf-8?B?aXJyUUo4bkk2Q2ZUb1RsSHVxd1dKM2Foa0ZpVk5za3RjY0xueTFlQmRyTktW?=
 =?utf-8?B?b3ZHS3BnTUVZZ2dTYW5wSHZuUG1oSHR6MTNKTCtPY2gvcy9uWVk3QjQxUFVR?=
 =?utf-8?B?R3RGaDBaN29VWWlhbloxQXNJL2R3d2ZUSnBxVWw3ckQyRnBWUjF4Y2NxUUhH?=
 =?utf-8?B?dFR3ZkhSTlJKa0puY245ZzVkdUJiQi9xeEYvK1VnTnhJNkVXaVo5T05YRlFu?=
 =?utf-8?B?ZFZXUWFNUnFrUUZ6UFZ6dk8vK21GdUdTN3pFSjR4Y1BzTUpDa0pldVkrV29t?=
 =?utf-8?B?cWE1UFJ1aWNFSjI2OWZJa3h6emdTeVdLQ3g2VFJDZFg2TlhrbEF4Wkxrb3Iy?=
 =?utf-8?B?aDQyMzRaY2RiYVB6bW9VVm91UnRKSkFpcmZLYTRMVGF6akRNRzlwd0pqOVp0?=
 =?utf-8?Q?FpgOqn4g3MMnU+l9NF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0b6d8-e131-4581-bf28-08df034d49c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:37:39.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD+CpCp1UwdYQCWCwmW/gCSDnx4zB1UmLKwKiBIW6zHEhnJhVZqeZ8xfve4EbPJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

On 8/24/26 18:08, Lizhi Hou wrote:
> On 8/24/26 07:06, Christian König wrote:
>> On 8/17/26 19:53, Lizhi Hou wrote:
>>> On 8/13/26 09:46, Taimuraz Kaitmazov wrote:
>>>> amdxdna_gem_obj_vmap() takes whatever dma_buf_vmap() returns and only
>>>> rejects a NULL vaddr. iosys_map is discriminated by is_iomem, so an
>>>> exporter answering with an I/O mapping leaves a void __iomem pointer in
>>>> abo->mem.kva, which amdxdna_cmd_set_error() memsets and memcpys through.
>>>>
>>>> amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
>>>> buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
>>>> peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
>>>> no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
>>>> object, so an NPU paired with nouveau or radeon does.
>>>>
>>>> Refuse the mapping. vmw_gem_vmap() does the same; unlike that one this
>>>> path is reachable from an unprivileged ioctl, so it does not warn.
>>>>
>>>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>>>> ---
>>>>    drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
>>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> index 1f190b319bb..b66ec9e4828 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>>> @@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *ma
>>>>          dma_resv_assert_held(obj->resv);
>>>>    -    if (is_import_bo(abo))
>>>> +    if (is_import_bo(abo)) {
>>>>            ret = dma_buf_vmap(abo->dma_buf, map);
>> Mhm, why does amdxdna a vmap in the first place? For some workaround?
> 
> This is used for flushing the imported BO before. Based on our discussion before, the driver should not flush imported BO, so this becomes a invalid case.
> 
> On the other hand, vmap on a io_mem should not happen. So I suggested to move the check to amdxdna_gem_vmap() for an extra check.

Oh my, you should not use a vmap to flush CPU caches even if you own that GEM buffer! That is as buggy as it can be and most likely doesn't work 100% reliable.

What is the complete command submission flow here?

Regards,
Christian.

> 
> 
> Thanks,
> 
> Lizhi
> 
>>
>> Usually DMA-buf only provides that framebuffer emulation scanout inside the kernel.
>>
>> On the other hand as far as I can see that here should work correctly.
>>
>> Regards,
>> Christian.
>>
>>>> -    else
>>>> +        /* Callers use mem.kva as an ordinary kernel address. */
>>>> +        if (!ret && map->is_iomem) {
>>>> +            dma_buf_vunmap(abo->dma_buf, map);
>>>> +            return -EOPNOTSUPP;
>>>> +        }
>>> Thanks for the fix. The 'is_iomem' check should be moved to amdxdna_gem_vmap() to cover all the cases.
>>>
>>> Lizhi
>>>
>>>> +    } else {
>>>>            ret = drm_gem_shmem_object_vmap(obj, map);
>>>> +    }
>>>>        if (ret)
>>>>            return ret;
>>>>        if (!map->vaddr)

