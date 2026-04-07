Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB573EDB7D1
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 08:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977B510E36B;
	Tue,  7 Apr 2026 08:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vN7YuWd2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BC110E00C;
 Tue,  7 Apr 2026 08:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF4W94vrX8lk4D06aJSo1i+7nOTBAOuiaRvqPXDodeo6cpNPv8WKzIDK7HtmAxjPZ7h9WKnYNFc4licKPewPY/dYONJoqGFA8kaLThXCmC0S/gxEnShh4Ki7Nj/YFsDI/9iedM/wkRnkDDQ67HxaAfj77OZVNh8NonQMPMszYReA9Lwt/69wRAs/57MwE8vQLSzNOi8giW2aOMqaqM75v41p2O23Y7kyGuIzDA9Uz54ntABGQTDrbGS/PdeIKmT2ORXqDqMbG9ui44nCdx1Lm6iZw/q/yorENE6AKieeg3/rQ2MSJXENYHvKHW2qh9Z0nB2AkzBO2CTo1EbU1ITXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hocbeow0Dc6m/eW/HD1vBRNJdfvE37EOAW2qvTXLgU=;
 b=gt/FTagIaudF8WIiFHMDscJYnsoBXqGTEvvz6d60k/RGoEQw9/TrY5uR9jHsUrA0aUn1qIoVlLeL1CPBlBkoJc0MM1IPyzervBOrD7ENVhHsbBfTiKcqSJHPDY5hXJ51QAHU5GWXy80cJ+eeKachkEbm1h/X5+mq/W7pVfZg4UeAzegKK9/3BwR8e8O0+4Y0XVnBO0eLATdL0GmqUzUt9qHStoibrRt5ORwZDeqYjzhJGJ+m+TavE2AHm260hV+ea2mHtt3oHlHspactU6TP7yeRdh31Z4pnPwwOsW8KdrOlCvaIODlyNS34q/dypaCS0PH6rdo1icJyKJZv5p0ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hocbeow0Dc6m/eW/HD1vBRNJdfvE37EOAW2qvTXLgU=;
 b=vN7YuWd2W7MEh/Bw4LS/6He3VF+xpuuLYlOaIvPR92p/xqKJTA3pS0rgTbm1Liuxk4a4kGZZhsE/lsHgv7kA0joHEG0gOJl72nLzea5zF7RY1yLD/c5+IKvzM9t7oP6C/d87lUbujc35Z+yVA1c1gsAR/FEWIqXmBOUuuwk91mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 08:07:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 08:07:58 +0000
Message-ID: <d8d6741c-31dc-445e-ba05-7d8e6b3ea586@amd.com>
Date: Tue, 7 Apr 2026 10:07:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] drm/amdgpu: pass all the sdma scheds to amdgpu_mman
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_NwbqrJAmrBKsG_BgGGtYCpM=MGc+Bpyvwr0hdVbmMYHA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NwbqrJAmrBKsG_BgGGtYCpM=MGc+Bpyvwr0hdVbmMYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fa8399-c01a-4efe-cfaa-08de947cc787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Avibmj/DvthkJDufepEgq2S1BoSiLHWlCNfw/O0N8KnBGWyd/DBHXE80hOoi63381LqKnr5WT0q8o8SjdDWBeVFTKeKP2/5juV+rTpcAGaFbIXC+PRd/BsaC0hC2F2qJQ9s6UMh5ipxWsc0CTdzzFq2KN5PKbSql0SR2hLm4UlaH/EX2AY6Sk/AXzDj5HOv02y+SMtq5JfIWIgIylSyC7iCaCN1Q7AMYFCKJW+4UTuENoCb1iafKvRRm7UKFPtwvwR+tzIviPXt1XCnqQ0yX3d+S2yng5kMCjcs2RFznQHTgTXgUERfekWvJcRcGHzCI0SIecIZADkwUZvhlqZU1e1jkeqRD2/ArOE4uoqH1tP/pSv/C9rM64NaWIh0q/j86Z2/9Cp2bdGJnMtjnlvFJTmD1+LVm119RX+lRG5D6eZPH4u2aYlrIhEHSivB2yO2qW8sGJtK9FwXJwO5rSVmoFis+Ss4ZwbKmereHZZxQIfzs25KrpZfIAXqL1ZSez6MDRoIymWw9GQYs7GrKjFAbfztuklu9TYJc2qLuSXEhDvqposWRjjG1MvLWKrqtZ4wF4w21UGYjeqTI0BSHjl01wnBqDdGicgeEhBYyghTLCUW9GwJG8Hk/XGpowF/IU34/h+wxf9JCs+kjDkbB8CgxFLTD8kDciW/nlx9C9UTE+tlTFN0b16EDINcPM0RHPeuWGCbbmMWtBmBtX6rJT+j9M+Fl27CIuLsqe/nkKIbJwQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emM4Yk9RQXg5MjRtcU4vUXR2OFRWaE5wS3VBT2RYU3o3WFQyOWt3VkF0QllL?=
 =?utf-8?B?Y2c0cVl4aXVOcEJGdDdEYkhpaFFrZUFBSi9UY1BkZ1luQ0FDU1FONXBQK1p0?=
 =?utf-8?B?RHNEM01zSDlIYTVESVpBVk5NVDcvNlliRS9oZGdSRmRka2NzandkSWQ4ZGRk?=
 =?utf-8?B?d1BjM2dQUmd0a3FqYjgrQjhwQ3dtMk9aVHlxSUZFSW9ua1A0REdnaUx2Wms0?=
 =?utf-8?B?QlpGUEtpTXhIalgxMTRmcWppazV6T0pOa0xQVEdiejlyb1ZwS0ZMVmgyNmVP?=
 =?utf-8?B?WThCdG9JZTZpRVBpRU5DN0F2VkNpKzlZb2tvbVN0aTNFNmxGTG04SlJBTFY1?=
 =?utf-8?B?SXdiSlcrQ29raHFBYThZdEl0U2JlWEFTWmpweHFnSDRJdEhLUzNGZEpvVXpP?=
 =?utf-8?B?bG0yUVdURE1jZlFjWXZBa3RBUkhTT29oRDRPWGRaMXkrNER4OUU4UWJDRHd2?=
 =?utf-8?B?S0VXdmE1TjdBaFgxOWJhZFRvRzRPcHlRdVB6U1krT2pHWG5CdW9leVlHTVdi?=
 =?utf-8?B?MTVhQ2F3S1ZJV1ZZUitQcy8zT3BLR1ZXL0RJR3F4VzdneVp5SXdzWWdDYWJ1?=
 =?utf-8?B?RDYyOTl0ZkNxREJFV0ZPLzNaS0srSXhYUGtXQ2o2VkgwdlV4Y2hXTUt1SDNs?=
 =?utf-8?B?UFJIZEdWT281T1d4U0FRUXFmeTVJSWloeWp6VUxSZVhod3A5ekVrL0phV1BE?=
 =?utf-8?B?YVRyYkYwZ1RTQ09aSDgrd2twbVJPeExMRzdLd2IwcUFFeTdlM2VaVU9Za3kw?=
 =?utf-8?B?dzgxV0RuekQvbnpvUXZTeVA1Y2QwVmJ6ZDVSRUFabHlsOFh3STRLNFVENnNG?=
 =?utf-8?B?UHBXNFR0SHk3VDN4MjdDb0RQK3dtdmVHd3BId1Qvc2w0MGZ1MWU5YWFUcWN4?=
 =?utf-8?B?MXNZYlZNZlVnbFV3T0dmKzlKbmF4THpxaFhhOUo1WHlBV0RUVTRQNVU0a2ZN?=
 =?utf-8?B?MW55NEM2bkcwUjI1VEVaZzFEbTlZUm03dHJZeHdDTXJvM1RqSE9KQnJ2eTJl?=
 =?utf-8?B?bExRckQydkNtWU5VTzZxSWlNTFFMT1d4aCtDNWRScEo5eHpvSzJRbUY5SXlU?=
 =?utf-8?B?N01zUnB4QjQrTDErMjM0NlR2Yk0zcDRMbkgyb0FtUmJTQTZqb0I4TW9HeTQ5?=
 =?utf-8?B?cm54S3RmNlZwNE1LQit2b2tVUCttaFNrQXhRUDNNdXo4L0pMNE53Vno2RU5s?=
 =?utf-8?B?bldlNkNBQ1dLeU00YnJYRWVEdzQzWjRFZTh6TFpTN0x3QXNrN0VxM3ltdEpV?=
 =?utf-8?B?ZVRrU3BRZVdhVTQyejhDUmNZQnhoUEZMNXd1VFZQTVB5cXVhVDJCclRsNkVk?=
 =?utf-8?B?WUUzM3I5dzV1TTVCQkNrS1JkeVFCY2U5N2F4TXJHVmYwRnprdllHbVdHZU8v?=
 =?utf-8?B?QVpFaGZsUFF1MnUxTUxZanVEZk02WGtXS1dUVHcrd1lkSkcvUTQ0TmJxOHpo?=
 =?utf-8?B?cHZGVnRsa0VMb1hrbTFEbDBDam8zU0N4T21pbmluaVhlcG5wSTRYR3NjZGZL?=
 =?utf-8?B?MDVEb2EvUmJnQ2dBYi9WLzdSak5MMlVhd01wMWhtMy9TUVlEWDcyandWeTN4?=
 =?utf-8?B?RmlIMU94bFlZeDE4Y3pFeXZHRDRUS29sQW9DRlU4ZEdIRVVSM09NVlRyOGlv?=
 =?utf-8?B?YjhEM2sybXFNN1VLYXdhYmRBYnB6emwxQlpCNUZXNVZhdDlacEE3RUNJWW5F?=
 =?utf-8?B?U3M5NkJqeGhPVFFHbFpMZDJRcFV6OVN6K3RLWG1oVkJlaUpFQjBZOHBma2px?=
 =?utf-8?B?cDlQa0I4eHBNNnhmbEp5cGJab1Z0MkVBakkzV1dPc0x6R3hicVkya1NENGF4?=
 =?utf-8?B?TXdoR091a29oQlFBSWozUUJoNnV5UFpXbWZ2T0lWTml5d3lWVmxpQUdzamQ0?=
 =?utf-8?B?T0ducXdZT2hWejZ6OE9LaHJ0OGpCWEhhWGdkRzJGSjJuSjc2bUs3ZnRqOGZC?=
 =?utf-8?B?N2ZJNjFValFRMDVhZmxzdkFjRHBzZWNUNUVFbmF2aG5NQm9vRTZybS9HQlFz?=
 =?utf-8?B?dnozSHFXSlhzRUN6NVVRd3RiZ045Vnd6UDFuazRxb2JWYUFzMnozNEUva3dJ?=
 =?utf-8?B?STFEM2ptbDdYbFVUU2dBb3EzbDFGaGZJUzcxU2RwYjFibUlnRzNnd3Z2OEE1?=
 =?utf-8?B?YmlCUWNIZU9sUmkxcHRQTUtXMnRJMGRXYUMzSWlOd3plOFZyV1lheG1yYXJZ?=
 =?utf-8?B?ek9TYkd0K1dWSS9SeCtmZFdib3prd2dnSjJRWENoSUF4b1NNSDNQd0IzNHdi?=
 =?utf-8?B?dDdQZC9QRXFMdzZxZ1EyancwL3NIVEtDeXFZcjRJbHBYVlB5VjFhUzJTc2ds?=
 =?utf-8?Q?WNePoQBd7XMLIo2cfo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa8399-c01a-4efe-cfaa-08de947cc787
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:07:58.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBbL+yg0Hkq2DXxwqtH5aP9g3WO1DJhtudvBoXFNtJi2aFOOEIvmqDj1qV0PA6In
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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

On 4/3/26 17:08, Alex Deucher wrote:
> On Fri, Apr 3, 2026 at 4:36 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>>
>> This will allow the use of all of them for clear/fill buffer
>> operations.
>> Since drm_sched_entity_init requires a scheduler array, we
>> store schedulers rather than rings. For the few places that need
>> access to a ring, we can get it from the sched using container_of.
>>
>> Since the code is the same for all sdma versions, add a new
>> helper amdgpu_sdma_set_buffer_funcs_scheds to set buffer_funcs_scheds
>> based on the number of sdma instances.
>>
>> Note: the new sched array is identical to the amdgpu_vm_manager one.
>> These 2 could be merged.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  4 ++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 32 ++++++++++++++++++----
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  8 ++----
>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  6 +---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  5 +---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  5 +---
>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c     |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/si_dma.c        |  3 +-
>>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   |  3 +-
>>  17 files changed, 48 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 49e7881750fa..e3a8701f0b27 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1467,6 +1467,8 @@ ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>>  ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>>  void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
>>                                    const struct amdgpu_vm_pte_funcs *vm_pte_funcs);
>> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>> +                                        const struct amdgpu_buffer_funcs *buffer_funcs);
>>
>>  /* atpx handler */
>>  #if defined(CONFIG_VGA_SWITCHEROO)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 0c0489395edf..4da8de34be3d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3700,7 +3700,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>         adev->num_rings = 0;
>>         RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>>         adev->mman.buffer_funcs = NULL;
>> -       adev->mman.buffer_funcs_ring = NULL;
>> +       adev->mman.num_buffer_funcs_scheds = 0;
>>         adev->vm_manager.vm_pte_funcs = NULL;
>>         adev->vm_manager.vm_pte_num_scheds = 0;
>>         adev->gmc.gmc_funcs = NULL;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index e9e53c7c37d0..1a253e4257ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -708,12 +708,14 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>>  void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>                               uint32_t vmhub, uint32_t flush_type)
>>  {
>> -       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> +       struct amdgpu_ring *ring;
>>         struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>         struct dma_fence *fence;
>>         struct amdgpu_job *job;
>>         int r;
>>
>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>> +
>>         if (!hub->sdma_invalidation_workaround || vmid ||
>>             !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
>>             !ring->sched.ready) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 3c63f87832e4..4ba7321b75e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -168,7 +168,7 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>>  {
>>         struct amdgpu_ring *ring;
>>
>> -       ring = adev->mman.buffer_funcs_ring;
>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>>         WARN_ON(job->ibs[0].length_dw > num_dw);
>>
>> @@ -2349,18 +2349,17 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>>                 return;
>>
>>         if (enable) {
>> -               struct amdgpu_ring *ring;
>>                 struct drm_gpu_scheduler *sched;
>>
>> -               if (!adev->mman.buffer_funcs_ring || !adev->mman.buffer_funcs_ring->sched.ready) {
>> +               if (!adev->mman.num_buffer_funcs_scheds ||
>> +                   !adev->mman.buffer_funcs_scheds[0]->ready) {
>>                         dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>>                         return;
>>                 }
>>
>>                 num_clear_entities = 1;
>>                 num_move_entities = 1;
>> -               ring = adev->mman.buffer_funcs_ring;
>> -               sched = &ring->sched;
>> +               sched = adev->mman.buffer_funcs_scheds[0];
>>                 r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>>                                                   &adev->mman.default_entity,
>>                                                   DRM_SCHED_PRIORITY_KERNEL,
>> @@ -2497,7 +2496,7 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>>         unsigned int i;
>>         int r;
>>
>> -       ring = adev->mman.buffer_funcs_ring;
>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>
>>         if (!ring->sched.ready) {
>>                 dev_err(adev->dev,
>> @@ -2730,6 +2729,27 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
>>         return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>>  }
>>
>> +void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>> +                                        const struct amdgpu_buffer_funcs *buffer_funcs)
>> +{
>> +       struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> 
> Only gfx9 and newer have multiple hubs.  Additionally, sdma 4.x is
> attached to mmhub.  sdma 5.x is attached to gfxhub.  Might be worth a
> comment here that this is just for the sdma_invalidation_workaround
> check so it's only relevant for specific chips that have that set in
> case someone attempts to do something else here in the future.

IIRC this workaround only applies to Navi 1x and there the SDMA is connected to the gfxhub.

But I agree that this really needs at least a comment explaining why we do this.

Christian.

> 
> Alex
> 
>> +       struct drm_gpu_scheduler *sched;
>> +       int i;
>> +
>> +       adev->mman.buffer_funcs = buffer_funcs;
>> +
>> +       for (i = 0; i < adev->sdma.num_instances; i++) {
>> +               if (adev->sdma.has_page_queue)
>> +                       sched = &adev->sdma.instance[i].page.sched;
>> +               else
>> +                       sched = &adev->sdma.instance[i].ring.sched;
>> +               adev->mman.buffer_funcs_scheds[i] = sched;
>> +       }
>> +
>> +       adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
>> +               1 : adev->sdma.num_instances;
>> +}
>> +
>>  #if defined(CONFIG_DEBUG_FS)
>>
>>  static int amdgpu_ttm_page_pool_show(struct seq_file *m, void *unused)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 3b1973611446..a6249252948b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -67,7 +67,8 @@ struct amdgpu_mman {
>>
>>         /* buffer handling */
>>         const struct amdgpu_buffer_funcs        *buffer_funcs;
>> -       struct amdgpu_ring                      *buffer_funcs_ring;
>> +       struct drm_gpu_scheduler                *buffer_funcs_scheds[AMDGPU_MAX_RINGS];
>> +       u32                                     num_buffer_funcs_scheds;
>>         bool                                    buffer_funcs_enabled;
>>
>>         /* @default_entity: for workarounds, has no gart windows */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 22780c09177d..26276dcfd458 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -1340,8 +1340,7 @@ static const struct amdgpu_buffer_funcs cik_sdma_buffer_funcs = {
>>
>>  static void cik_sdma_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &cik_sdma_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &cik_sdma_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version cik_sdma_ip_block =
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index 0090ace49024..c6a059ca59e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -1235,8 +1235,7 @@ static const struct amdgpu_buffer_funcs sdma_v2_4_buffer_funcs = {
>>
>>  static void sdma_v2_4_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v2_4_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v2_4_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v2_4_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index 2526d393162a..cb516a25210d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -1677,8 +1677,7 @@ static const struct amdgpu_buffer_funcs sdma_v3_0_buffer_funcs = {
>>
>>  static void sdma_v3_0_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v3_0_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v3_0_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v3_0_ip_block =
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 44f0f23e1148..d56be26f216b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2626,13 +2626,9 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
>>  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>>         if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
>> -               adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
>> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_buffer_funcs);
>>         else
>> -               adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
>> -       if (adev->sdma.has_page_queue)
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
>> -       else
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +               amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_0_buffer_funcs);
>>  }
>>
>>  static void sdma_v4_0_get_ras_error_count(uint32_t value,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index 78bdfed0a7fd..67e9697301b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -2316,11 +2316,7 @@ static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
>>
>>  static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v4_4_2_buffer_funcs;
>> -       if (adev->sdma.has_page_queue)
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
>> -       else
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v4_4_2_buffer_funcs);
>>  }
>>
>>  /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 52f4e9e099cb..86f5eb784d57 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -2052,10 +2052,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
>>
>>  static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       if (adev->mman.buffer_funcs == NULL) {
>> -               adev->mman.buffer_funcs = &sdma_v5_0_buffer_funcs;
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> -       }
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_0_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v5_0_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index b4fb90cc8f7d..3fec838374b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -2056,10 +2056,7 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
>>
>>  static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       if (adev->mman.buffer_funcs == NULL) {
>> -               adev->mman.buffer_funcs = &sdma_v5_2_buffer_funcs;
>> -               adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> -       }
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v5_2_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v5_2_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index b005672f2f96..064508cecd11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -1895,8 +1895,7 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
>>
>>  static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v6_0_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v6_0_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v6_0_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index 5679a94d0815..60447729271e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -1845,8 +1845,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
>>
>>  static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v7_0_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_0_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v7_0_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> index f20e0fc3fc74..c3428d2731dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> @@ -1764,8 +1764,7 @@ static const struct amdgpu_buffer_funcs sdma_v7_1_buffer_funcs = {
>>
>>  static void sdma_v7_1_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &sdma_v7_1_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &sdma_v7_1_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version sdma_v7_1_ip_block = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> index 3e58feb2d5e4..155067c20a0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> @@ -833,8 +833,7 @@ static const struct amdgpu_buffer_funcs si_dma_buffer_funcs = {
>>
>>  static void si_dma_set_buffer_funcs(struct amdgpu_device *adev)
>>  {
>> -       adev->mman.buffer_funcs = &si_dma_buffer_funcs;
>> -       adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
>> +       amdgpu_sdma_set_buffer_funcs_scheds(adev, &si_dma_buffer_funcs);
>>  }
>>
>>  const struct amdgpu_ip_block_version si_dma_ip_block =
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 964efa325908..28dc6886c1ff 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -129,13 +129,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>>                              struct dma_fence **mfence)
>>  {
>>         const u64 GTT_MAX_PAGES = AMDGPU_GTT_MAX_TRANSFER_SIZE;
>> -       struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>> +       struct amdgpu_ring *ring;
>>         struct amdgpu_ttm_buffer_entity *entity;
>>         u64 gart_s, gart_d;
>>         struct dma_fence *next;
>>         u64 size;
>>         int r;
>>
>> +       ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>>         entity = &adev->mman.move_entities[0];
>>
>>         mutex_lock(&entity->lock);
>> --
>> 2.43.0
>>

