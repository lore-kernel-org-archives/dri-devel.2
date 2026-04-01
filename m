Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5589ED3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BC310EF2A;
	Wed,  1 Apr 2026 07:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="emi3/UYz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1BD10EF40;
 Wed,  1 Apr 2026 07:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwcOtPKMLeukyXYJA/3v+Pkn38qcVENOZAKhKF0DuuonFBWOXWJ6AeC+AUbQzoNnOvHuvnCJupygrM7aGsS22aMPCDqaSsuEXPWMM/AmB23uIN2qcqpsiqpFD3JTXOZeC/i1EuXzYOe2dk3cRlpDXzG+rMO3SH6BSZlQXY/OhciKlzsf8nUx6whwtjpXzcjNoZua9Aw5Qp2pkFGIkAfWdD4LV4wUxBK+/YF3b7mDUyVaevFVmSkFY316wvqzZe3O15i8ZreCWjeYCC4RKslSCfQQ8X+wU3y+1H/qNVVnN9QwtpsyGX0EzpA6mxQST1E9ip/NnRtnk4NA4MdNz/uXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSZKnNC6TvyX/UZQ5cIr/tDx3B6Dy8WtA4WHrul7dY8=;
 b=ayK4xWH6vAa80XiQ/TKTiKmi27naDJF56jPHpXfvn4i5k2VtcWcteLu7gsD7zkRO+UCiP9Vxz0Y8CZlsOtt/ksMqwEnPNZhZyjEoiyy1sadn/BdxpybBNTVzxEBLsA5+GF5OcOfGDj1TaBFRllk5SaZa/QqT0x9JnmbWKJSCEcOi1B+39pd9t8+Kty1iH9FuOdWYtdzfLSPGxgoGYDb5KhleZF1utBFwc2RdVG69neeQn/EYIYCEHupYcT8JGqEvEbVfhTO/3gIiMdIzWki2j39h7mW7OfO5YZbpPSTkMcRhDZaAYV1qye57KC0Nj+NQMwqlE1SrViettHywMWewgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSZKnNC6TvyX/UZQ5cIr/tDx3B6Dy8WtA4WHrul7dY8=;
 b=emi3/UYzAO/symJU5EnBoOGRo28SSJuQIF6skFE4GgMncx7c318GBqItTG7ND/ezB3ZWia6k7YQMhKB4g3HGEo4yCRGWRlv69BPp3Y4mKY49SaZ4gGGiVTmrIygTrAR9r7CkJBqsdXDqngYyLMspyw6FX2ukwzHxvdIXOYRY9wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:15:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:15:41 +0000
Message-ID: <12f1819b-c221-408f-8231-0b11d97e5d36@amd.com>
Date: Wed, 1 Apr 2026 09:15:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com,
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: e502806f-1195-424a-43d5-08de8fbe7bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: IMmTQi0vixK0xP7of0CSXxrPYkNGtZRFw2UnJlkQ/O5SdhiBEpWw0OVXX18G0a+0IBRRaejyGqi8r6TPsAWXjz2QXWNUVvu8v7reLqF0zbN2XkWF45u5mjP7tTLPQjqopvF9pOs+TTDVctow/5G/kyB3bx5OWeEy6j4mh/XPDNZ5Q8+KHGK6ayUd7CiNjjDfWt+43IW0WWGoEblGF11XWRNldOT7XRKBQqRyr1kf3kaW1Y7O+H5nFbWMUP9qsPGZOIW4ieZUmDccYtU/oSgH74PfZAsPPsjQxWq532C7b2i+ZpMQs+U87X/Yorudh3fQh77XyR0ZUfFS70nckUI81S4yJxN4UEC/SH76ttiDE2jHLRAvV+cO7e/usKknOYwP+tVNaA7JI2aIe+bMj6Dae9IAjIV+kU3s3wbZQHV5JgXEg9qUXR7rwjxMFaJXZS7SX1UuKWLQyD2b2pvyLS5gzXAuA/y2/HqnaGu5+GN6gwAvxemMzj6TcNPMt7OJzNChwp53xL9mP5al0wrvXUh2UPMTBu6cK53joDTJOkpYSKC2KoYz+Uo8+pI5SQA+YiaEuDjJL7R3B+YXXhgluWVE+jyWUWyZtF04k8eqquIgIJLmEmScfF9jZR11O5PQdT0cHObHxJ2viHUM5x2SHI5EWwCXRnWvdt4OlPmdCmCG4UiK0ZgTYML2k4SGJ6qT9ZUXu4d+kXke3o1rG32omTUPMo1PtJO1x8mrnM1pL8yw32Bd93JyntVoFEu09HwgTjl9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVUNGEvTmQrYzd3RXVoVGsvWkwvaU5kYnVybDVaajh3UnNQVWQvaHFCbmFu?=
 =?utf-8?B?UW0rVXZhTVVWOFlXTi9hL0ljRzdzVEkvTWt3UnFaNllaelpGeGE3UzdTdko0?=
 =?utf-8?B?Vm1jemozMWQ2UytnYVhkVlRaM3l0c295S0NtZ0psUFQrckQ0bGZRcE02MW1N?=
 =?utf-8?B?STM4NHJnT0JPNDJNNWg4T2pJUDlMVGxUUUZuTEtWak0zTjh1aCtMeFNiTVZI?=
 =?utf-8?B?R3VwMCtCbHp4Zk1wK0U1QmcyVVd4THhmYzYzQzVxNTNxSSt0MmhWd3NXYnly?=
 =?utf-8?B?SThuTWFVNEVuRGVEeWVZb25SZlgySzNIVmJqYTVWRGxSNDgyUWIra01WRDdQ?=
 =?utf-8?B?d1BsQ1lmak43UytrZkY2N3NVWDI3Tm9ldEtrUEkwTTFPWWJldW1wWUcrNFRW?=
 =?utf-8?B?MjU4UFhpaHpZancwbDkxZ0QrQzVvcmI1L0hHWFkzTnFyakRQZHlBMUUvY3Vk?=
 =?utf-8?B?dVlMWFpreUYyemRzZUZidTlPTHRHbTJVN1AycEh5NG1VOUlYazVuWlc3RTJG?=
 =?utf-8?B?YkV6YWRSaXh2WUc5dndxSkFiMWNBeHpYK1JwMHZVOTNpMVZsVWNxVUtMNzZH?=
 =?utf-8?B?L2tpUXFMMVNyRnpNQ3RkaG4vdVFMSVZ1ZFhBWHJyaERxdVR4Sk8yZStIOHh4?=
 =?utf-8?B?RTdVTFY2YnNLblE1RmhkNFpXTWlBL3pzZnlSM0JGekxPZWg5bmt4VTNZWXlS?=
 =?utf-8?B?bTJYdjEzNDh2cENveHgvcmRwVm1XdDVodUJmSUNwYmdPd2NKTnpzS0FZTTZ4?=
 =?utf-8?B?T1EraGhKa3hUc3dPUzRHMTkvT2MybmtTYmpOV2FicUJvbVJYcElOR1lzb25J?=
 =?utf-8?B?c3JBejkwbUdMY3N4K3IwWWdmbE9hOUtncEVzbWdoWWtlclhHRHFxZlozYnMv?=
 =?utf-8?B?ZDRNcGYvdTN2UXVBK2hEQ3ZRZzJUVjBWb1hoVXhZYzZLZ2VucktoRmw0L042?=
 =?utf-8?B?Q2Z2Q1lYV1VNdzc1SzZlL1JKaVdBL3h4VXNwYVVjcjlRenZpTXpDZitlc0p2?=
 =?utf-8?B?ZWZDUUF6RkpCRTA5ODN1SWwwcW5NME5BQm1QVTRhQ3JKQ0pXTHZBY1Z1Z3JY?=
 =?utf-8?B?OCtrNTNzSldZZkpsbllvOFhYUmhNNnlXR2NmMGVZcUxjRjVPbGQ3RjBDVXhJ?=
 =?utf-8?B?UDhuS3N5UGRhYVNiTWM1UkIzZTVoZHJndDhhdmk0Y3AraFJKekZBWE8wdWhy?=
 =?utf-8?B?MlFsazhMemFLS2w5aDlZZVR4Um1vWitNY0lWdC9kQ1FhQW5iM3c2SEEremlD?=
 =?utf-8?B?ZHVZa1V4OWE3QXRnbUpNZVZ6YllEMWZqbUx5NXM1V2dheWdCYUtYcmNwUmVD?=
 =?utf-8?B?dVVrZit5WnFmUHFreHF6dEtHdWNkVTZzQUhWKzJlbGIvaUM4bkk2eEtBUXhm?=
 =?utf-8?B?RkJYWlllRHlLcE5wZzk3QU9VZEl3UGNBTUNxZjl2RHdJV0VIK0FlT0E4d2cr?=
 =?utf-8?B?QzlKUkM2ZlJPbUtxTk44VDBYbFdVZnk0L3l4NkltUXA1NTZuUWIyUEFBVFVx?=
 =?utf-8?B?QjFFWUtvQndmS1p4elhwcElocjAxQnNETTc4VWtPN2VEd3h6cnJQWWlLSGRL?=
 =?utf-8?B?THRFd0NpVTZGMzZLeDVsNDkzY2VqSXpidEl5QVllZXc3V3doN2tOanliZmRD?=
 =?utf-8?B?d0NzWUd3MjJjcE1aVHBpS1Z1cHlaR1FEVEhndm1tK2VEUnladld1aFNQTlRw?=
 =?utf-8?B?RExZYjRXWjJxZGg4VXptRjBqNGZjS3ZIb3NwYWdzb05NWU5kRTZYVFl3NmUx?=
 =?utf-8?B?dGpKZlBZSXFZQ0lSdk13dVpiVGIxYmxHVTVtVWZOellpODFyeit5b3hGVWpN?=
 =?utf-8?B?RjJXNjVYZmlOSUE1TDF6M1VIdnlwUUd3SkJEU0FOR1phUlZvdmpkRGtNbi9V?=
 =?utf-8?B?ak1Gcm1TbEk3ZTkvOEFhTUczd2lBSkUrVUp6VGtvN3pIVC9HKzh4VVp5SGdp?=
 =?utf-8?B?cS80YUxSaW1sOUR0alFNNTJ6Zm5TNk9nWEtvRG9FVCszbnZEdmtsVTB6bm9Z?=
 =?utf-8?B?cWxkZkkxZnZFaXdjWTJwSEYxY0pQWVE1NkYvbTBHbE5BM2N5b24rdmxCaDRQ?=
 =?utf-8?B?L1hBOG9rQU1pRTkzc3phYlRIZUdKQ1Nsenp3UWxHbHJZN3k2Y08vNi9PV3hP?=
 =?utf-8?B?b2V3dWlHc2Q4QzViYUluQ3ErQ0hTejhDQXh5ZmR0QTdlVTNtOEZwd1Y3bEhD?=
 =?utf-8?B?cHpUald0bXdSM1BTZi9BdTZ6aytHeDdGeWdoTzVPNWZWTGREVzVpdmtTeEFn?=
 =?utf-8?B?Q3hhWUxsK3RLVkdyWXJlejVHVEZSaEduWTBFTEFrV0xwR2FZaHNpcmE4KzFI?=
 =?utf-8?Q?qEQxe7D5Ga9zgaz4ur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e502806f-1195-424a-43d5-08de8fbe7bd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:15:41.8566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O6u+JPhLU3dzqxMB+dGn522h+g0CJsQhk3A86PX/zggiOqVZ4CYOd6dVjTAaO2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

Alex please make sure to include this one in your -fixes pull request.

Thanks,
Christian.

On 3/31/26 16:38, Alex Deucher wrote:
> Applied.  Thanks!
> 
> Alex
> 
> On Tue, Mar 31, 2026 at 10:29 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>>
>>
>> On 3/31/26 16:21, Mikhail Gavrilov wrote:
>>> Replace the PASID IDR + spinlock with XArray as noted in the TODO
>>> left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
>>> flags").
>>>
>>> The IDR conversion still has an IRQ safety issue:
>>> amdgpu_pasid_free() can be called from hardirq context via the fence
>>> signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
>>> in process context, creating a potential deadlock:
>>>
>>>      CPU0
>>>      ----
>>>      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>>>      <Interrupt>
>>>        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
>>>
>>>    The hardirq call chain is:
>>>
>>>      sdma_v6_0_process_trap_irq
>>>       -> amdgpu_fence_process
>>>        -> dma_fence_signal
>>>         -> drm_sched_job_done
>>>          -> dma_fence_signal
>>>           -> amdgpu_pasid_free_cb
>>>            -> amdgpu_pasid_free
>>>
>>> Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
>>> locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
>>> Both xa_alloc_cyclic() and xa_erase() then handle locking
>>> consistently, fixing the IRQ safety issue and removing the need for
>>> an explicit spinlock.
>>>
>>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>>> Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
>>> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>
>>> v7: Rebased on amd-staging-drm-next which already includes
>>>     dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
>>>     Updated commit message to reflect that sleeping-under-spinlock
>>>     is already fixed and the xarray conversion now addresses the
>>>     remaining IRQ safety issue.  Inverted error check to
>>>     if (r < 0) return r; per Christian König.
>>> v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
>>>     so all xa operations use IRQ-safe locking internally.  Drop
>>>     Cc: stable since the regression was never released to any stable
>>>     kernel. (Christian König)
>>>     https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavrilov@gmail.com/
>>> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>>>     since xa_erase() only uses plain xa_lock() which is not safe from
>>>     hardirq context.
>>>     https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmail.com/
>>> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>>>     xa_lock_irqsave, as suggested by Lijo Lazar.
>>>     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
>>> v3: Replace IDR with XArray instead of fixing the spinlock, as
>>>     suggested by Lijo Lazar.
>>>     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
>>> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>>>     lock inconsistency (spin_lock -> spin_lock_irqsave).
>>>     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
>>> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>>>     using idr_preload/GFP_NOWAIT.
>>>     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
>>>  1 file changed, 13 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> index e495a8fa13fd..a6ac3b4ce0df 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>>> @@ -22,7 +22,7 @@
>>>   */
>>>  #include "amdgpu_ids.h"
>>>
>>> -#include <linux/idr.h>
>>> +#include <linux/xarray.h>
>>>  #include <linux/dma-fence-array.h>
>>>
>>>
>>> @@ -40,8 +40,8 @@
>>>   * VMs are looked up from the PASID per amdgpu_device.
>>>   */
>>>
>>> -static DEFINE_IDR(amdgpu_pasid_idr);
>>> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
>>> +static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
>>> +static u32 amdgpu_pasid_xa_next;
>>>
>>>  /* Helper to free pasid from a fence callback */
>>>  struct amdgpu_pasid_cb {
>>> @@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
>>>   */
>>>  int amdgpu_pasid_alloc(unsigned int bits)
>>>  {
>>> -     int pasid;
>>> +     u32 pasid;
>>> +     int r;
>>>
>>>       if (bits == 0)
>>>               return -EINVAL;
>>>
>>> -     spin_lock(&amdgpu_pasid_idr_lock);
>>> -     /* TODO: Need to replace the idr with an xarry, and then
>>> -      * handle the internal locking with ATOMIC safe paths.
>>> -      */
>>> -     pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
>>> -                              1U << bits, GFP_ATOMIC);
>>> -     spin_unlock(&amdgpu_pasid_idr_lock);
>>> -
>>> -     if (pasid >= 0)
>>> -             trace_amdgpu_pasid_allocated(pasid);
>>> +     r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
>>> +                         XA_LIMIT(1, (1U << bits) - 1),
>>> +                         &amdgpu_pasid_xa_next, GFP_KERNEL);
>>> +     if (r < 0)
>>> +             return r;
>>>
>>> +     trace_amdgpu_pasid_allocated(pasid);
>>>       return pasid;
>>>  }
>>>
>>> @@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>>>  void amdgpu_pasid_free(u32 pasid)
>>>  {
>>>       trace_amdgpu_pasid_freed(pasid);
>>> -
>>> -     spin_lock(&amdgpu_pasid_idr_lock);
>>> -     idr_remove(&amdgpu_pasid_idr, pasid);
>>> -     spin_unlock(&amdgpu_pasid_idr_lock);
>>> +     xa_erase(&amdgpu_pasid_xa, pasid);
>>>  }
>>>
>>>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
>>> @@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>>>   */
>>>  void amdgpu_pasid_mgr_cleanup(void)
>>>  {
>>> -     spin_lock(&amdgpu_pasid_idr_lock);
>>> -     idr_destroy(&amdgpu_pasid_idr);
>>> -     spin_unlock(&amdgpu_pasid_idr_lock);
>>> +     xa_destroy(&amdgpu_pasid_xa);
>>>  }
>>

