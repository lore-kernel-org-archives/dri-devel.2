Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4727FCA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E75710EA7E;
	Fri,  9 Oct 2026 15:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qdjn2qCB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010059.outbound.protection.outlook.com
 [40.93.198.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8398D10F6A3;
 Fri,  9 Oct 2026 15:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shxgvDt0me5cde8FK+X5iLzUeym1fm3+zxRG0LbPw9v3i0wwobh+4iRqvspnh0HjZ0MHru1+1WVLnBmXAbHFIPccdVVmU0gm2PvX2Emjmsl7maMhU88h21yJ6+c9GxabPmf8DAdfsNI8jkRKg05HFs0G2zOZWu+771UihtDkHyuUEqd760AAxUvddDb6d0NF349uZRdhYZ3LOu0NvbocQPH25oAW5pgR71lQ2ip0TIlLm+UzOyVMYaMs026zLCOzJiL31z7ZjdbkyeiAfIlAc0jJe4xmPOGv1VnK52qJf4zX9esdmGd+X5xY1gEfkT+jVxTZbPDa44OlGeIasDuGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqzl5Wlog2CHlRUnqGWTElc0l83f2R3GsoIz2GkTpjA=;
 b=uC2mD+P5Gc81tf6m3kszICZh37jAon0tVwNaQd7c7L2P+X+gasGOGTdmbkwIUwR5n1x1aAyfxs35wD6ELymbSX7RbGdTuV6VJeqmDVd9WYWDI1HeK7kV7g0q2DsEt0WV4z+XcAo4uINy1QdlX5FmUFtrhyCHmJ91RtvQZmEohJiErDbMz8oZn1pB8/7Ws/JDy8eGk9alnpmMAzeh2MjqZ9Z94/yxXJdY1IlOjN6fk9PRZB6FaICWNt0LYuU+kRUTj5OuUoNxZ4jYevIcui6TBhc5jpF0hahWg52euswwUZ58BK+KCkOCXf5gqiWa6nvMX4tnVxG4F9gjRNk/98nNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqzl5Wlog2CHlRUnqGWTElc0l83f2R3GsoIz2GkTpjA=;
 b=Qdjn2qCByPf0GqhL6ErwZloaAQ8qVVy6v8ONrPK8OGgn1nPXwXd2R0WRn+GCS8ZRbyy4I4Pyu6QQD2UbqXbYRgyxcq7htA7P400YHSu7GOdFd3HSdWp5ejgDKtZIoDi8m8Wmf/I2Y73aXHKhJYGozggJKISod9SPFY35ZfMEKMU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by MN0PR12MB6150.namprd12.prod.outlook.com
 (2603:10b6:208:3c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 9 Oct
 2026 15:33:44 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:33:44 +0000
Message-ID: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
Date: Fri, 9 Oct 2026 11:33:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
From: "Kuehling, Felix" <felix.kuehling@amd.com>
To: Henry Martin <bsdhenrymartin@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
 <2bbea75d-2e3f-4a57-a291-5f5d9ca698c5@amd.com>
Content-Language: en-US
In-Reply-To: <2bbea75d-2e3f-4a57-a291-5f5d9ca698c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fed93e3-0a9a-4e3b-5f01-08df261ab41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|4143699003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Zt7NBZVT9ac6/O7FrrmGEnxtgyl8uKrLIXUuyp4mfrixondyRQNLiGnkTh357THKDD3eCcp4pBB9Z4QqM2T4QiAVo+YIGyUiW8npgMN3UHCo+j6wRWzdt+7/2kWfIJYztg+4KM4twQvNhtlmrE6jn1KRS5neJz7AjN//GLvoLAPd+Af2vtmuzbaEexsKAv7or0uQjpS/npSZHmlSXrWWnzGmbL07qHT+g5s83pzLzxKgxZOo574ZbVGMIy5s+a+mcDYQm8Ca3nZ35DZpEl0/ZoaV4O+g0mkhuTUDg05MARaNEhoFe5me5jjjmsyKmun9S1omXFQSIF9pY/VtVwD2ifE4/msgC84sMzL5Tb0DFOYCNFuYkgiI8XYoVLZCpwMWplJgj947f+NNnfA1aw/0lryx13Lbz0RF5V4IjJA8x8vFTUStw8pxN0CxaaVxhsosJKzsEc/k8BemXe0fLsSYV0pDtu6KaH3toQIb7rOtcNT/z1at6B5M5nHX733n2ugxJvOu2SouCp1hVoYADPC7GZ9eeljtTx/LsCecmumQVNvkFPo3Je1kQi7l2ZXUYINquMznaJR1VwgnAQpVIe9dpKz/iWE2051AG7fZuH+w94uGzMUiEr/ohqWoKZjWPSnlHStAj8yPDdTXm3o/B5SdjXEvqGD7ijRmeHi5sUg9EBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(4143699003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emhoQVUrWGNTcnJ6dlBLa0Vob3JlZUtnNFhobGNsK2R0YjFialZWa2NNNEc2?=
 =?utf-8?B?UHFBSDZqT0RyVWVUSWY0elNaQ0dPcHBaQmxxOVFBdFZLalhxb29ZTFhXN21q?=
 =?utf-8?B?NEVvZjZVOStYZUZab3duOVRUOUFuV1VNK0hEYjdZakJwemdMU00yWXhtQXg2?=
 =?utf-8?B?SytlRWxVK0VOc2Q4UGI1ZWNLOGVNTjlBK0pyYmtLY2FxRVEva3p1cUozRWtu?=
 =?utf-8?B?bDEyN1dleWZ1VStrcmNMcXJQQXRvYytyN1Y1VU14TE1tazlnYnBBRVZMSmF0?=
 =?utf-8?B?bU1PeTN4TlduVnc4RnZWc2JRRDNpZ0gzUTRBSm15dGdyQXQrNkc1UDhZN1pP?=
 =?utf-8?B?Yk9oZ3ROdHFxcS85RXJRaTlWdnpRZFJMV3NqWGFwSk9qRE13R05lUGtSN2w0?=
 =?utf-8?B?Q0pvUmF2dTc1bUY3aWY5ZTRRdzFFVjlYTjZDdnQ1ekVmZTR3TENmeG1ETTh2?=
 =?utf-8?B?SUhNV21wdUhlV3A1b3VTT3c5K3lVampxZi9sQ3d0OUk0blJSTktsZmNDdktr?=
 =?utf-8?B?dlpybGZDUDBxRlRpZ1JEWkVPYlZYMG9KWjc2d2NQMytvSXdNeWhhbnlmY0Fo?=
 =?utf-8?B?MHc4VGs4cXpUN1ZxS3dDRHNQNzYrcUUwdzQzMUpoUzV6VWh0UndVRStJbUdn?=
 =?utf-8?B?aGJaN2w2SHZrQjBmWWNNNGFpeFg4a1pXYnc4NnhueExSSitrOS9BdmVwSUtO?=
 =?utf-8?B?MzN0dnJMTmV0d1lpNkwrQjVaQXFoZC93RzI5eFBTNVRMRGtQQVNqRmR0ZHlQ?=
 =?utf-8?B?a1gvdjJyVHdDTXBicmw5OVlKUEtNZTRRa1l6VWR2THZTNTBqY0taaUFXSVFi?=
 =?utf-8?B?dmp1N3dsWXRjd2FjZkovOXZRUFlSTWYvWG1RUG04Njd2LzA0S1AyVCszNUh3?=
 =?utf-8?B?MTQwMWRxVTVwV3pMeEd4UXROeEpkSXRtZ0NzUXRTekNrNm9KaEk3ZlZ4b014?=
 =?utf-8?B?cEgzZHozSUhiU0szMTBWSDJLN1VJMkU4OWovaWRBV2xBb09jelNISmFrcnRT?=
 =?utf-8?B?c1FIaFBDSUlZMFZhQ1JCYTc4bmR0TmpNQUhyenFvelVoeGVoUmt6cjV1amw1?=
 =?utf-8?B?TXFjNXBoMHpSZUFiYlhVdDFybm1VNy81M2tybHduRTNEZDNoZGJjai9mdVBI?=
 =?utf-8?B?WTlTUGJjdlBmMVRYZHpqTTN0Tk5rNFVCVExtU00vK1QwVXhUYjEvRlI4VjVS?=
 =?utf-8?B?aFRIMWtwOUNLWFhXSkNFcWljS1lIVDRrQUFFeVRNZTNtQUZwR2o1dDQ4a3Nj?=
 =?utf-8?B?UXRUb3lSOFovbmZ0MzA2V1ZJVVcwRE1ha2w0aGVnTzhZS3ArTzNzT1pCZGZs?=
 =?utf-8?B?QUpPT1I2SGpFV1NWeWc4R1BDZGZEaVpiN3F0QU1Ha2NlaUFSd1FBSklGYjUx?=
 =?utf-8?B?aFpNOWRCVVg0MFBPVU1pczA0OUo3V0JlSzNESllrL01vUlV1eFdPZDB1eDVH?=
 =?utf-8?B?M2tIVFJ2SzBDYlhuNE5LM0JjS1FDSzZ3VFo1ZEx1VGltdk9QTVV1ZnEvcXNJ?=
 =?utf-8?B?RVQ2MFVZRGR4THVHMGlZVktGNHZPelZ3cXZWVzBMKzFyWWJ5OUZpRlQxTkNx?=
 =?utf-8?B?bDVPWFp2aWxoOStQOHBZbUJ6QS8xU0c5WmgydzF1elhDUVY1c1J0TEV5WEkz?=
 =?utf-8?B?QXJDRVp6eE5POWozWEJUcHRGV1RzU25KZTdjN1dYRW5JU1JFQm9nSEhSc3Iz?=
 =?utf-8?B?bDl1Rk9HSDIxTU1qamk4MWhMb2VQLzFXenE3Zm5mQlVjRHpJK3Y5c0NNTGZ1?=
 =?utf-8?B?YzBmWVEzQStOOFVMUlZXL0tPamYzMDZLWFNJWjFUOWNTSElyM2w0bGkxL1dw?=
 =?utf-8?B?bFkrY25Nc1dJVm81WEVwblAxTHhMNW10RjBsRXcxRyt2K0ZTRnorbEpQeEJP?=
 =?utf-8?B?eUY5bFdqd0V3SWprc0p3TTlpVGRFZTJzOEVpaUNHTkw5OWl4N2F4TEIxQWRR?=
 =?utf-8?B?cGRzVHdWVUtENFNhL3grdUlMQnJTT2JBNCsrbGt2VEtTSU80ZTlFQlNPSkxG?=
 =?utf-8?B?YTNIYUhpcEdPOHJELy9kYXd4MEFvQXhtWEVJVkNWWGZnQ2plN29NbUJ3S1Jo?=
 =?utf-8?B?bC9BNnh5OXFnNERUejVmY1l0cFFacWRKQTR5TEtCdFAzdTlRSU0zV3NjazdC?=
 =?utf-8?B?MzVlSU1vc1B6NGhySUN5UnBsMXpXRmxDNGJONlNYOFc4RG0rK2J3Nkp1SERY?=
 =?utf-8?B?WUlyUk1JWmlBSkdoOVFlWTlsdVRXdjlEU3RzQjNreFlzdDV5aldFWTJEZWda?=
 =?utf-8?B?Z1E3TkRhRlplRWZ5c3hnazc2S1ZKdVBZOFhjSUdZZjBzWThOOHZnbFcyY3hX?=
 =?utf-8?Q?Ek4iN7H3qvmuwiJWcR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fed93e3-0a9a-4e3b-5f01-08df261ab41e
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:33:44.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWd46IskLnKJFm3v/1DmItrjEdwmrp0NdYGEdVHoAAJbNdkP3L4lDPVMwHO0snSbkDUGHfPknJ0O6nSGUVzttA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

On 2026-10-09 11:00, Kuehling, Felix wrote:
> On 2026-10-09 06:18, Henry Martin wrote:
>> The check-and-allocate sequence on pdd->qpd.proc_doorbells is
>> lockless at every call site of kfd_alloc_process_doorbells():
>> kfd_get_process_doorbells() (mmap of /dev/kfd), kfd_ioctl_create_queue()
>> and the CRIU restore path each test the pointer under different
>> locking (or none), so two racing threads can both observe NULL and
>> each allocate a doorbell BO and bitmap, orphaning one allocation and
>> handing the two mappings different backing pages.
>>
>> Move the serialization into kfd_alloc_process_doorbells() itself:
>> take kfd->doorbell_mutex and re-check under it, so all three call
>> sites are covered regardless of their own locking.  The existing
>> doorbell_mutex users (kfd_get_kernel_doorbell() /
>> kfd_release_kernel_doorbell()) only guard the device-global
>> kfd->doorbell_bitmap in short non-sleeping sections and never call
>> into this path, so there is no nesting.
>>
>> This vulnerability was discovered by Tencent CodeBuddy Security.
>>
>> Fixes: 428542d91772 ("drm/amd/display: Setup for 
>> mmhubbub3_warmup_mcif with big buffer")
>> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> I'm applying the patch to amd-staging-drm-next.

An automatic Claude review pointed out two problems with the patch. I 
agree with both:

The Fixes: tag points at an unrelated drm/amd/display commit 
(428542d91772). It must be corrected — 2105a15a2046 ("drm/amdgpu: use 
doorbell mgr for kfd process doorbells") is the commit that introduced 
the allocation being fixed.

The patch holds the device-global kfd->doorbell_mutex across 
bitmap_zalloc(GFP_KERNEL) and amdgpu_bo_create_kernel(), while that same 
mutex is already acquired under dqm_lock via start_cpsch -> pm_init -> 
kq_initialize -> kfd_get_kernel_doorbell(). That is a plausible ABBA 
inversion once reclaim/TTM eviction runs the KFD eviction fence back 
into dqm_lock. Please either post lockdep (CONFIG_PROVE_LOCKING) results 
for a boot + queue-create cycle, or switch to a per-process-device lock, 
which also avoids serialising unrelated processes behind a device-wide 
mutex for per-process state.

Regards,
   Felix


>
> Thanks,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> index fdcf7f2d1b5b4..07f881573837e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
>> @@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev 
>> *kfd, struct kfd_process_device *
>>       int r;
>>       struct qcm_process_device *qpd = &pdd->qpd;
>>
>> +    mutex_lock(&kfd->doorbell_mutex);
>> +
>> +    /* Another thread may have won the check-and-allocate race */
>> +    if (qpd->proc_doorbells) {
>> +        mutex_unlock(&kfd->doorbell_mutex);
>> +        return 0;
>> +    }
>> +
>>       /* Allocate bitmap for dynamic doorbell allocation */
>>       qpd->doorbell_bitmap = 
>> bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>>                            GFP_KERNEL);
>>       if (!qpd->doorbell_bitmap) {
>>           DRM_ERROR("Failed to allocate process doorbell bitmap\n");
>> -        return -ENOMEM;
>> +        r = -ENOMEM;
>> +        goto unlock;
>>       }
>>
>>       r = init_doorbell_bitmap(&pdd->qpd, kfd);
>> @@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev 
>> *kfd, struct kfd_process_device *
>>           DRM_ERROR("Failed to allocate process doorbells\n");
>>           goto err;
>>       }
>> +
>> +    mutex_unlock(&kfd->doorbell_mutex);
>>       return 0;
>>
>>   err:
>>       bitmap_free(qpd->doorbell_bitmap);
>>       qpd->doorbell_bitmap = NULL;
>> +unlock:
>> +    mutex_unlock(&kfd->doorbell_mutex);
>>       return r;
>>   }
>>
>> -- 
>> 2.43.7
