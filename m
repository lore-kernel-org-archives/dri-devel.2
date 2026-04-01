Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FE10FCACE
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2F910EE76;
	Wed,  1 Apr 2026 20:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RRCwf+HJ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0153A10EE76
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 20:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGL+40g+BQkLaM3fSqtQirKMtOCnMm9jfZBHYnj+kGfee2iHlmM8T23N4NS+Edh6Yz7Ppnhoyi1m8ksXvW1BXxDMmTfDsEALZ4NmNNTqbozDGSlvMj/Fa21aZRHsmMOSMhvxZS4WZJLMOhPkC4wFHUgdBpuvUKvzDpImulxTkNSzZG6EPcrpe3IJuMCMr5iTIr3+VCFnfRprszMwwKJmn8O2WXmyKTXfanAZP20pM+sBfRIJKpLpv6Vo9GRGpB/BHySFTwoToMRsGHb/dItWJEU7wBd10u0RjywzA2Tn8UPsd8IRdx54olPKS2O8XOdqJnVI9zIXaDJqN24xrlC6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKAXTe4vhb8lPXQjrFxjIzNRwFi1pt9Bih/e0LpiZiA=;
 b=dh+jTHspH+7su0nui5qrY4aQwUOGrXjdRVTigroUgjoo/0ql8sVTcfwk4QMIWH/5xsXrLMIfyySbDr2WGoDyrAVXYoH63ejPqvH6H3eJFuSd2P59TffjJ6MQ6rKVuqaJNXwfWe8c5NYlD0mv8uwVKEuzaFbF72KWdh6fmG4AQykxwsB4D5j1ZXUemxjkX82us/BT0niQCHmNcFNl1VaX01Tn5eI5NtY1PvM+0zKOdGaXWlqHM0zqgvYLKCW504gfGm9dPWXP6/8vghIKw7Hjntso2rlVmJFh1waIvJcU7fhBI6Luk6H4x2xboAiM+ft0IIft0S/xL9fduVyUBwKrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKAXTe4vhb8lPXQjrFxjIzNRwFi1pt9Bih/e0LpiZiA=;
 b=RRCwf+HJdVELYKzagOb/5ni1BZ2Td0W25UadM2wCfhj9Gp+i5auqjyv2Oc6d/v86Yizc+ort0Q5tXfWDBo9cN56JXVGu9clElMN44kF2QNWEeBq7uT4OXJhF+C7cAzcRQxrEUOV6PENeuMv3OwwkDpzktM+ScdT7s6CTdLTYbug=
Received: from DM6PR04CA0014.namprd04.prod.outlook.com (2603:10b6:5:334::19)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 20:30:37 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::15) by DM6PR04CA0014.outlook.office365.com
 (2603:10b6:5:334::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 20:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 20:30:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 15:30:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 13:30:36 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 15:30:35 -0500
Message-ID: <93bf2720-ec34-82a9-fdf1-c67c1466cdd5@amd.com>
Date: Wed, 1 Apr 2026 13:30:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Support read-only user-pointer BO
 mappings
Content-Language: en-US
To: Matthew Brost <matthew.brost@intel.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <maciej.falkowski@linux.intel.com>, Max Zhen <max.zhen@amd.com>,
 <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260331172635.3275296-1-lizhi.hou@amd.com>
 <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
 <1f3bc6c6-86cc-dcc0-82dd-6dfc512bd9c7@amd.com>
 <ac17dHiluekQgmLd@gsse-cloud1.jf.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ac17dHiluekQgmLd@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: d6429f5d-5f4d-44d3-3d59-08de902d8882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q7cLLPdwkwzDqThJcxDvH7EIBlsvR6AROuR+5u6t1BH090RcrYKpud0sRG9Gh+QQCuPtROVWftUMpWrSuwoO1FE54FLGFeG0CIi3qCYX2hgxUoZQidrhLCOoBw+egSXYTo+cVVaV9hkxaxJlBfVs/QVpEI9NEQNcwWy4T+J1DeJbJac7/mv87xY3mjQMB8qg2vFazwHc0PWjB21P0zYyWNEF1PHSiiPb9huPWqOzfHjBgos6hAl89hqAo9vBS823UvlYiJ8PMP13Rv3afE18lIOoMkwY3RxpTKqw1G5Br9diPoub1JRcLCEaM+H40MOUanl7gnw3on14E4VedinBRgO8eXPb7c0mkKHxcO3t3/2NcPPWWdwjzO127LuJABPY8XueEw2/ysbmY5bQDf1sv4db31RyNUHCDVTRAspci4fNaXavEvcJxq90hwpn5p4sbRdBQ4ZurFqx7NgqP+BE0aUtzwKVCyLK/4npBR8KG/z0FBopsBgo91MI8ksW6NrvW3jUDhv3N65wBlk/SmYSMRJ7hw6SZ4MTE05/A/9SzHdiw7C8zT94ENJW9o9vi9jFlb8lJddcl9Z+rO2NbV6aYhnWm6bYU/VERCEXVTVgkWOe+iGGf1r0L7FTb0ft5BxM8ePWJBcXzvK8r9b7V1EOXQPr6s62kuuTCgIy0zpMn0cSHFGju7AgeD3VEINKU9s2mvjlXwDBzrDzBtC2dv6GNPxzcrozU8zUIPl3O6BZ4IoZxmpFHNojneqPoJUqFr8rsREaKHLSXBSv7LK6YWwA/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q+Ft9PywUx/bFVU8b671KPu/ODBrKcLOv/qcZPBMUdCyD5PLR937TbU+TZLV+EphkuTs+smY14437m4EZL9x+ArkZ+fv94zdC25HRycdYaaKktAQINged2dNPCxjv67PtUAkB7uXESJDXwjVNx0jrMW64rWOSILYdj/hpsc06tHN9JYhq1T3OIgUT52bJjDNIOyN0ptBWfHhRVSoE5eZZBsIIWMrLl2yzQCLPxf6HVdpR3npXdZ+1oS3zcUmT/LFdrNTh8zLVlhVjYgbZsNE/E4Xp6zigwb7+cSoCiK3vUkF5p2Kf7G4z4rcIAoBhqvgTJUU5o6GoYJkJZodN0Gv6c5UoFMdPsGQHk9hx0Pp0U+fpQtnivSTSM4lJO9sEGdKJ241XrsKx39Zp7eBQWS0v2hlwlq0oKiHyFbr4p1e6J5iPANrUDpvQbHkpIV00XyI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 20:30:37.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6429f5d-5f4d-44d3-3d59-08de902d8882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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


On 4/1/26 13:09, Matthew Brost wrote:
> On Wed, Apr 01, 2026 at 09:51:39AM -0700, Lizhi Hou wrote:
>> On 3/31/26 21:57, Matthew Brost wrote:
>>> On Tue, Mar 31, 2026 at 10:26:35AM -0700, Lizhi Hou wrote:
>>>> From: Max Zhen <max.zhen@amd.com>
>>>>
>>>> Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
>>>> objects from read-only user mappings.
>>>>
>>>> Detect read-only VMAs by checking VMA permissions across all user virtual
>>>> address ranges associated with the BO. When all entries are read-only, pin
>>>> user pages without FOLL_WRITE and export the resulting dmabuf as read-only
>>>> (O_RDONLY).
>>>>
>>>> This allows userptr BOs backed by read-only mappings to be safely imported
>>>> and used without requiring write access, which was previously rejected due
>>>> to unconditional FOLL_WRITE usage.
>>>>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> ---
>>>>    drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
>>>>    1 file changed, 27 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
>>>> index 4c0647057759..3769210c55cc 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>>>> @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>>>>    	.vunmap = amdxdna_ubuf_vunmap,
>>>>    };
>>>> +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
>>>> +{
>>>> +	struct mm_struct *mm = current->mm;
>>>> +	struct vm_area_struct *vma;
>>>> +	int ret;
>>>> +
>>>> +	mmap_read_lock(mm);
>>>> +
>>>> +	vma = find_vma(mm, va_ent->vaddr);
>>>> +	if (!vma ||
>>>> +	    vma->vm_start > va_ent->vaddr ||
>>>> +	    vma->vm_end - va_ent->vaddr < va_ent->len)
>>>> +		ret = -ENOENT;
>>>> +	else
>>>> +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
>>>> +
>>>> +	mmap_read_unlock(mm);
>>> This looks highly questionable. Drivers should be reaching into the core
>>> MM to create primitives.
>>>
>>> I also glanced at the userptr implementation here — it’s quite
>>> questionable as well, especially regarding whether notifier locking /
>>> hmm_range_fault interaction is needed on the driver side.
>> We implemented hmm_range_fault and notifier logic in amdxdna driver.
>>
>> https://github.com/torvalds/linux/blob/master/drivers/accel/amdxdna/aie2_ctx.c#L921
>>
>> The code in amdxdna_ubuf.c is just getting the pages from user allocated
>> buffer. The buffer pointer will not be used for device access.
>>
>> Instead, user space will do a mmap to get a different buffer pointer and
>> register to notifier for device access.
>>
>>> I’m fairly certain that, with a bit of thought and some extensions to
>>> DRM GPUSVM, amdxdna could build userptr on that layer (Xe does this
>>> wihtout SVM). That would isolate core MM interactions to the common DRM
>>> layer, which I believe the core MM folks would appreciate.
>>>
>>> The biggest issue I see is that get_pages() in GPUSVM also performs a
>>> DMA map, which amdxdna doesn’t appear to need. That should be easy
>>> enough to split out. But amdxdna does need locking semantics, notifiers,
>>> etc., which GPUSVM already provides.
>>>
>>> I’d rather see GPUSVM expanded for the amdxdna use case so future
>>> drivers can use it as well.
>>>
>>> Happy to work with you on this.
>> It is wonderful to use a common drm layer to handle all the similar
>> requests. It will simplify the driver for sure. I will start to work on
>> switching to GPUSVM. It might be taking some time.
>>
>> In the meanwhile, are you ok to merge this patch for now? This is a required
>> feature for our product.
>>
> It’s not my intent to hold up merging anything required for your driver
> or product timelines — rather, I want the DRM driver/accel stack to
> converge on a common implementation for SVM/userptr, since this is a
> really tricky area to get right.
>
> I’m sure we’re still missing some pieces in GPUSVM to make this feasible
> for all drivers, but we’re very open to refactors that would enable it.
> For example, AMDGPU is also looking into using this framework, and we’ve
> already discussed some refactoring there.
>
> Let me know if you have any questions about GPUSVM or about the
> refactors your driver would need to make use of it.

Cool. Thanks a lot. :) Yes, it is tricky area and glad to know it would 
be handled in drm layer.

Lizhi

>
> Matt
>
>> Thanks,
>>
>> Lizhi
>>
>>> Matt
>>>
>>>> +	return ret;
>>>> +}
>>>> +
>>>>    struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>>    				 u32 num_entries, void __user *va_entries)
>>>>    {
>>>> @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>>    	struct amdxdna_ubuf_priv *ubuf;
>>>>    	u32 npages, start = 0;
>>>>    	struct dma_buf *dbuf;
>>>> +	bool readonly = true;
>>>>    	int i, ret;
>>>>    	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>>> @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>>    			ret = -EINVAL;
>>>>    			goto free_ent;
>>>>    		}
>>>> +
>>>> +		/* Pin pages as writable as long as not all entries are read-only. */
>>>> +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
>>>> +			readonly = false;
>>>>    	}
>>>>    	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
>>>> @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>>    		npages = va_ent[i].len >> PAGE_SHIFT;
>>>>    		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>>>> -					  FOLL_WRITE | FOLL_LONGTERM,
>>>> +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>>>>    					  &ubuf->pages[start]);
>>>>    		if (ret >= 0) {
>>>>    			start += ret;
>>>> @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>>>    	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>>>>    	exp_info.priv = ubuf;
>>>> -	exp_info.flags = O_RDWR | O_CLOEXEC;
>>>> +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>>>>    	dbuf = dma_buf_export(&exp_info);
>>>>    	if (IS_ERR(dbuf)) {
>>>> -- 
>>>> 2.34.1
>>>>
