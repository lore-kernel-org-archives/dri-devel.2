Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C65B10F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A53910EBEB;
	Tue, 31 Mar 2026 16:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CKdYDJvU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842F810EBEB
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 16:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvJN3cRA55tA/4N0/aTWrWYPZceh032aps6pPeWAPX9msCuf4D7igl6HDn9yl9H63DT5A4m89Z1cA1GOlDXOm1HwwHUB4Gci3k/4c2PdHdL71fy66wiE4kivN/pUukDvo0SdfYnuGsnMOjVL+HpK77MES4lgXM1suAGoww4Rm3o4loEApLJhcIScT6U6k9mAdDnuu5lGXZXiGppZ6JsdEZGWhNdnop6T0ocqOyRBiyJhjVhzaL8Q+8VIUJcqgncPICB/0R1DMAyPzGszba5ut/JoFMeCmMhjuQyHivve2NpaVyUlsjfWi1c9gyxSuj9uDoG0BeEvNuCXsj5fzOKQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4UjtPWaL/PjOBLxsZQXL5RIulQXKaRhRbrfw6RxtrY=;
 b=JGDArpUFPt0VFiPPM66FzDPciDoYqV7QLe5B8pAvWVMKDk+9eopf/3KJ3qVju8GOkib2DFK2gL4qJj5LATEDjKMjxSd68jx047IsgB0sNdp5sM7IwMGS3kBeZfULj+dPMlNrvMRLQzVwvnbWKrFsmP7bQ1SIPWF1VhX812SWqYWpvQg2IMWoQze3oXa6yNh3zEa2H6865mBmBZHxZeG/OUJC5GBzdlQLseZDf3alBXcxk8M0r/Ok2DKMrxt2J5O0mU6k6ZHPJ2aF59COSsPZ/nguKrwn/f3QysxILdeTHQy/dkWyoroHYTZ6Xr6hSjPEU+tM7IUjGgCM8b/dkF3qOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4UjtPWaL/PjOBLxsZQXL5RIulQXKaRhRbrfw6RxtrY=;
 b=CKdYDJvUOpJdGEHPew/p0h9/toW4eQzvoEBCCtKq8vKleCRafoun6pYr13hOOTv9PdLsBuKY6FUEn2Wif1v59ZroVKKQES97LtAruY5KCZ0Z3riYGDb0FUJ2+MY1bT7m9Iy9CzIkOYpafMEjVAElVkFlebvHqmUCUBYzSfwAXzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 31 Mar
 2026 16:32:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 16:32:52 +0000
Message-ID: <ef271b2e-adfc-48d8-9d0f-1890357db284@amd.com>
Date: Tue, 31 Mar 2026 11:32:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support read-only user-pointer BO
 mappings
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260326162759.2674547-1-lizhi.hou@amd.com>
 <a4886d87-b359-4bf8-ae2c-02e17664bd8e@amd.com>
 <1f3a273f-ba47-08b2-92d4-b2d656241669@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1f3a273f-ba47-08b2-92d4-b2d656241669@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0504.namprd03.prod.outlook.com
 (2603:10b6:408:130::29) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0ffbb7-93e1-4ab8-20d5-08de8f432750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: fzDLVL8AJNibIrCVjFrjUirpiWbroh8Xb2Bt79pQ3VWdD0/JkB+2Y//aPcJqrqTeaeWh5m/+L/+VCPa2FfUXQFZz5ptzQ8ovxwGtxVS1VEXWmiwRaSDCi6duAU4hMoai7vqtkVLCVt/M3IQ81BUQpfgpsG509mLw7W5Jjl56lEu15NeInQ5wz0yMIs1RjljjHM06agHSTALe8BWjMUkkAxFn8/JQV8VEFz/XtBTA7rwPxMZJjnI6gZly+QcvMvCvsxzRdys8dKVNY1qAb4A3q/pieMd01kB8hggdsnK2P71KbYRZtR8a/Eg/1Yv3jGww5liJOKd5+YH6U0oOrAzC+PICLu1bc6kRboxbc5shN33SFVEDMauCgIaWNgerlkPGHZXuqip1jX3D1m/QpsKOrY1XZrcE6Gaf4EPvO2JSiALobL7K8Om32+jgQHZcubxd0oGu998P9EhjClVYvZ87X2TBYXH2QeSP3J8YMqxhzYc0odSVcfiGPph8okffIaMKoBVdEcV2D+YPH/M8HbtKTxh/J8J9pFO07p8KMfEQVJGEaeyXKDzuIYAMlRzVwL0/50eU4kZTpg/dCGZkzKCH0ZeAAABn1hC1UULoSwxyGsxL3Tt6LReyIdnK3Lu0uovuPP+Du84yObnZ5e26yBg7A6i9F4NbaZw4drohtFmzBS2tJ30S7zovRZb0jX14DVEw3AkDyaYxU+MXtAXCzuHL2xa6j7nTzGq2k/7v4ke9Rh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElqczR1Skk0QnlUbnF5dlZSdDNLZUtpODdLaDk2M2Q3TnFGc2hKMFhoUncx?=
 =?utf-8?B?TStRTDZtMVpmR01paDBTL1pJLzFHNmlvK28vOVVHNldRRVFsYzd2K3NFOTc3?=
 =?utf-8?B?cGNDb2JOOW5wNkFoMzRuMjFkKy83UmhhRWM3R1FkNUdlOE1seXJQbHB1WVls?=
 =?utf-8?B?NHZRekdzR082Mnh6aVc2emFmZldYSGFHdGdBMlBvN2F6ck9xUXByY1JjdVFr?=
 =?utf-8?B?TUE3UmtHN1l6WUhTMm4zdVRsa1dBZWpPZGswSWYvNGRSbEV2MGlTR3JVdTkv?=
 =?utf-8?B?QzVXdXFmQjdydndONVo2VnhzNnNmSXpGdWVvRHg1R0Q2b0tsN2FKOXR3MVRN?=
 =?utf-8?B?bEplRmNZQ252VUtTSTJTZzVlbWRiRHpHUlNpVll5UWJtdUd0MExDaHpwUyt0?=
 =?utf-8?B?UHE0K1ZRWWdXSkk5dnR2SU5ZWm43eDAvVnR4bFYwaENZNTVkMFJ6cU5WV3Y0?=
 =?utf-8?B?MER3aktLVG5OZXAzSDI0SFZzaDhWZUVLQTlTUkh0MjRRZk4xcDNxamYwQzJj?=
 =?utf-8?B?T05hMlZSemdvV05wUnI2alJLeGoxaWo0ZDNQY3cxOUZYY2Uxdml6b2JJcWl0?=
 =?utf-8?B?ZXRQVlRQdlpjbi90eTRaWkVuTE5NU0pvRzBCUHFVRmdqQkxhdVlnYnoxNVQx?=
 =?utf-8?B?b09UV001cDVDSm1ZbGx0QTZDYjBxM0NuMUpodzVGNXhLVUNrZU9uZVhYc3o5?=
 =?utf-8?B?TStGVkxkOW5kU0J0T2p4a2x5TVlVaTA2MktpU0dWZUpveHhZcVZUdUdTYndv?=
 =?utf-8?B?RGl6OWZ0NzFURzFCZnFBeHhzU1pGdmhmcC8zWHQwWm9wTTlmUGtIaEVCWlFX?=
 =?utf-8?B?TVMrMlpTbDFBbTQ3STJGSFcrTy8yZXluUzFhU1BnUThIbUVBTDZqSzZvSFV3?=
 =?utf-8?B?cEttSTNhQ3JDa1U0Qm8yK1NsaGFNSTVBZ1dmakhrTzcvYzlxUHdxY09RWFE4?=
 =?utf-8?B?ZFBZL2xRMHpCVmNVMU45ZUFHL0ZQWjNsamtTSlI4Q2pzNU9ITGZBbklBYW5X?=
 =?utf-8?B?b205MmM4QUhnNWRjc1BQRnl1SzgwSDE5aFcyZGZzbXVQM0t0THREOTgwK3hz?=
 =?utf-8?B?QmtpZkc4ZjhNMUw4V1U2QzJiR1BXcVlMZW42L28wbjBXMGd1YXlsb2Q3WDJM?=
 =?utf-8?B?b1I5R0tzNHZCNmVCN2NmdU9jd3R0QktNK0tHdFRjQW1Dc2ttUEgzdTRZK0V3?=
 =?utf-8?B?ZjRsSmgvSmpEblpoUEpDMEkwNXRvOGJWQjJjc1dxZXNNSWc3Vmx4L3RyTjBQ?=
 =?utf-8?B?bkZhL1J5M01LbzQ5U3YzaVIzUVh0blpWTGpEQlpRV25kdytzUTJ0TG50MTlP?=
 =?utf-8?B?c1pWRklMRm5UMXJSK3dDQ0FwbTVrbTQvKzQ3Y00xVnlxYWliVTdyUFltc3lx?=
 =?utf-8?B?RERpVUliT25GRHhRUldkQ2x3Q3ZIY0U2VTVpbVRHVEM2NDFVVWlyczBEZ29a?=
 =?utf-8?B?L3NkZm9SdDhZcWg3cVZXbFYxMVFYRitsUkxWSUZhTUhxVTY3WjBueXlTbEJY?=
 =?utf-8?B?M2xCZnlQcTlTbmY5cWpUSlZBMmdGRzZSVTZaVHFnWXg3M05nZGdQb09NQnVO?=
 =?utf-8?B?em5zQk5EZnBxU3hWL1ZpZ0RTejA5VVdZeHdmZmJPQkJtL3pNNFFLdVlJcU9t?=
 =?utf-8?B?bGovK2tpcmNuSnIxejIyaDhpNVBFVXZZWWkwY1R1VWpMdlk1RTRVeENhVG5M?=
 =?utf-8?B?SWZKZTVJSDduSnk4ZDRtMVZDU1FVMkw4M0Zwam03SjR2ckduZ3JhY1AxSVJm?=
 =?utf-8?B?NkdiOC9ERGNROVhORUx4Qm5mMGdnMmhmUkhQSTJoWjBWZEMzY0NzRlQ5cXJE?=
 =?utf-8?B?bjNWYnI4cGN2OVFzbmhaMmRtajZYNFRNNUpxbWVFMzJVMjYzR21TVlBMY3BU?=
 =?utf-8?B?Wnp1aDJhQ052Z0dsUXVuTVFldUszSHFvS29Hd2VTbkpPSGFGWUIvR1Y2dzB6?=
 =?utf-8?B?Z2VUVjJ1SGpMUW5oL0drS3I4TlpaWkJ4ZjJCeWxncUh0Y3pOc3dVTE9OeC93?=
 =?utf-8?B?M3VVTzJKdVM5RFlnOVkvWDRvbjVMRlR1aFpwS24vck0wQmcxSjE1RHRnRWQx?=
 =?utf-8?B?T2lod1luNTROUndiNkJIcjVyam0yTTZ4ZVFsb08rZXlabExWM21FQnZVd1Ux?=
 =?utf-8?B?QWV4SmxUY2g0VDRsUXFyK2p6bjhReVlLUnpoY0pwWVV5YXd3djdNTGJKcjZ5?=
 =?utf-8?B?Q3F4cUNMcHhhbUtnaE5JNTZFVTl2aFZXTTFzR3drWWtJUFdGaEZiMGNYczk0?=
 =?utf-8?B?ZUpSQXNodHBRSllQV000MUVuZUVnNTlJUHVuZzBCSkxhT01HWDBvbEErV3l3?=
 =?utf-8?B?TDVwbkYyTU1zWFRWMFY1RVdGOGp4UGkvNnJrd3A1SjgxR0J1anh5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ffbb7-93e1-4ab8-20d5-08de8f432750
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 16:32:52.0988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzyuV9mP19LKRMfdZDZmsQCWYb3y6vhBRS/oEt2L8EI5YdVqnpjXGX4An0zvkO809DHf0XgtsvWXcUJLLAOWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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



On 3/31/26 11:29, Lizhi Hou wrote:
> 
> On 3/31/26 09:13, Mario Limonciello wrote:
>>
>>
>> On 3/26/26 11:27, Lizhi Hou wrote:
>>> From: Max Zhen <max.zhen@amd.com>
>>>
>>> Update the amdxdna user-pointer (ubuf) BO path to support creating 
>>> buffer
>>> objects from read-only user mappings.
>>>
>>> Detect read-only VMAs by checking VMA permissions across all user 
>>> virtual
>>> address ranges associated with the BO. When all entries are read- 
>>> only, pin
>>> user pages without FOLL_WRITE and export the resulting dmabuf as 
>>> read-only
>>> (O_RDONLY).
>>>
>>> This allows userptr BOs backed by read-only mappings to be safely 
>>> imported
>>> and used without requiring write access, which was previously 
>>> rejected due
>>> to unconditional FOLL_WRITE usage.
>>>
>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 30 ++++++++++++++++++++++++++--
>>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/ 
>>> amdxdna/amdxdna_ubuf.c
>>> index 4c0647057759..1a0e2a274170 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>>> @@ -125,6 +125,27 @@ static const struct dma_buf_ops 
>>> amdxdna_ubuf_dmabuf_ops = {
>>>       .vunmap = amdxdna_ubuf_vunmap,
>>>   };
>>>   +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
>>> +{
>>> +    struct mm_struct *mm = current->mm;
>>> +    struct vm_area_struct *vma;
>>> +    int ret;
>>> +
>>> +    mmap_read_lock(mm);
>>> +
>>> +    vma = find_vma(mm, va_ent->vaddr);
>>> +    if (!vma ||
>>> +        vma->vm_start > va_ent->vaddr ||
>>> +        vma->vm_end < va_ent->vaddr ||
>>> +        vma->vm_end - va_ent->vaddr < va_ent->len)
>>> +        ret = -ENOENT;
>>
>> The check on line "vma->vm_end < va_ent->vaddr" appears to be 
>> unreachable.
>> find_vma() is documented to return the first VMA where vma->vm_end > 
>> addr, so
>> if vma is non-NULL, this condition can never be true.
> Sure. I will remove it.
>>
>>> +    else
>>> +        ret = vma->vm_flags & VM_WRITE ? 0 : 1;
>>> +
>>> +    mmap_read_unlock(mm);
>>> +    return ret;
>>> +}
>>> +
>>>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>                    u32 num_entries, void __user *va_entries)
>>>   {
>>> @@ -134,6 +155,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>>> drm_device *dev,
>>>       struct amdxdna_ubuf_priv *ubuf;
>>>       u32 npages, start = 0;
>>>       struct dma_buf *dbuf;
>>> +    bool readonly = true;
>>>       int i, ret;
>>>       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>>   @@ -172,6 +194,10 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>>> drm_device *dev,
>>>               ret = -EINVAL;
>>>               goto free_ent;
>>>           }
>>> +
>>> +        /* Pin pages as writable as long as not all entries are 
>>> read-only. */
>>> +        if (readonly && readonly_va_entry(&va_ent[i]) != 1)
>>> +            readonly = false;
>>>       }
>>
>> The check "!= 1" treats errors the same as writable VMAs. 
>> readonly_va_entry()
>> returns -ENOENT for errors, 0 for writable, and 1 for read-only.
>>
>> Extra error handling maybe needed?
> 
> The idea is to specifically handle the readonly_va_entry() == 1 case. 
> For -ENOENT and 0, it fallbacks to writeable and the error handling will 
> be done by checking pin_user_pages_fast() return value.
OK.
> 
> 
> Lizhi
> 
>>
>>>         ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
>>> @@ -194,7 +220,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>>> drm_device *dev,
>>>           npages = va_ent[i].len >> PAGE_SHIFT;
>>>             ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>>> -                      FOLL_WRITE | FOLL_LONGTERM,
>>> +                      (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>>>                         &ubuf->pages[start]);
>>>           if (ret >= 0) {
>>>               start += ret;
>>> @@ -211,7 +237,7 @@ struct dma_buf *amdxdna_get_ubuf(struct 
>>> drm_device *dev,
>>>         exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>>>       exp_info.priv = ubuf;
>>> -    exp_info.flags = O_RDWR | O_CLOEXEC;
>>> +    exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>>>         dbuf = dma_buf_export(&exp_info);
>>>       if (IS_ERR(dbuf)) {
>>

