Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6C10F6FD9
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 16:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6610E68B;
	Wed,  1 Apr 2026 16:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="STQ196aI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAF510E68B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 16:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/jSqGFvOV5tOZNtr0t1fiHmr4NHH3qK5H8RiWwNa2NqFiQRpbuUZimfoTZ0zyz+g5rVUe0clLrbzs9SAeTB3Y2D/yNc4YatJYhmFt1hFfn5s+b7lbynLXCNsY8Dtx3yRVDyKV0FGM+AHQbiNRAaPx12TjsKXnXKb3UXmsJddi4NIXgJXUY1mYsaY4HvP8NYkHQlmjq5aKRRIaMteFGUA6uCFQJAIb4CnBOLzWFJ/VX4XPACGgWDkNX14JvmIFPgEsvf1YAcu7Nk1cdyQfK0OJVtanAv3+TFwJH8n4RgUiXXbHmpL8xxQSO2NBh+jkf5zKTLkFkfvzZ2Q7vMwLu3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfL99TPMhA67APknRITB/YG32zPFy3/0nIc6xhb6E+Y=;
 b=dV1J5yiyDhTYpzqW8Q2UqAXC5LdoFUhvOy54ljaUdDLeUnHEIv/e18j+3Wu3f/7xWNvakgchKcZQ5PNyFeJtjqR/gtaZEwgQiOcj4VMJBffEY5LWnAwEE2MivAWaXpWu5A/W/IaS7XOJbpk2YWkGYRP9c8WlerFUp8gl6aWkpev4vcuP7WWzCcwFwBtMOFTwhM1bv5Eu8AaKxzlteewoJspyFxbZkgKVzOOjHGWUEYUR2CvcL22HEu2v3hK78bXbeafxdR98fCyoM0249GNFeD8/YQHLdVGbaGrHAYJSo9iZd/2DzwDrfKZNkKPOMyWo9lIpWcuj6uX0haJ05XeP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfL99TPMhA67APknRITB/YG32zPFy3/0nIc6xhb6E+Y=;
 b=STQ196aId0LA304BFltQ0cQ3Bhk781vs0vWN9Q0UuzIQ48RooCMi4takAy3LfZooDfLXBIEE8gPolwaWjv4x0MHUtyif4qISM9Sr0IUqyyKMCg4kfl99qQFMMoKC7ZqnS0EZPJyFIkUW8Pdgq6sNUuwc2id8gThZG4dz9IGmBnY=
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 16:51:41 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::34) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 16:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 16:51:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 11:51:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 11:51:40 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 11:51:39 -0500
Message-ID: <1f3bc6c6-86cc-dcc0-82dd-6dfc512bd9c7@amd.com>
Date: Wed, 1 Apr 2026 09:51:39 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <acylqAdORtJs4cgO@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e966a76-9c7e-474a-57b1-08de900ef2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: waSTYQW9I+k9V+2e1L1IvDh6QgGUaifjfWAfHbpO/E3VlGq7cFNVn0fIhMrwTAPYZUE/Fg/OZB94xyhtV0De3Mw54/659MbZVS408X/1YxOMlN6Pk5obZpwX0xwjbPWBbBmlZJWlm+yhr4Z/pUsPjTSYCD4EehVvsKpZke6ZPvQtfMmqzrrs+L3PghL04Xl/OWCqkgDc3wr69p+RGeMxSRtGYKDt2CmHGuUk3cAYkLDkfGw/s0E4V+gyXhQjkqqVk8hlJcB3K/jCs6NL0GfKZH43ONOOuYuUmsPaI29AtzG/TNg5waPriQtESF+nLv2pkzMVCi6HGj+s0ctApqgYgPR4SJaMQpfZ5u+6cCRKUY2Ec/g+wOlDHqTHG3zsv3m0LJHc1mMsAa+WLAi21Vfx4JGOMqqI2PPPtJ7cR2vu3lPvaGLDHbQ4527Qw2exKN0HomfdEMXsWxA7F8lGkbI1p/bZgvGzy1vkSiPYrB4JlujTOIgO17pk1tPtQHcI0NfWba0f5ejIWgRNjdjuTjZ3djMCW+mW3SN+IcWKfGLWIqdV946pw8uiiIVqyUAaFk5Pk4gJVBZs8EdQBClvqhAdl72uwm7Jdy+ORpBkB+CoNxnVymZNpWddTCkTyE4Sn/VRcKfcZdZIOIesaER4/q32BiS96qn7qtqQffwbjQRh9dNRWD9K69JbdRZ4kZNCQ7c8p4OfxVyEqXy30ywidxB97nzwSnThTAjqXr3YBBYSmITBXZ+pJNno+isWun3TrftoJHfMjXxglMVfOh3H95B2nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DNzMDUTrCQC6ZM6qTGZUR++G26ks4wfGDbDlOvEBZHuCZP0Ijn8apSsgfzp4Gvrz1yFkE8xemi7roJ1Yvr6PYPATNAy7EJ7QEkl51nh9a9s9a/6cYy7q0LeulnMNaVMhfL6hAGjvTYGQqwvMzcExQaCJ6SYMOYCePwEPH+lGf5Di2pl4HqnrWBXwGEEX8Qj7TEg71NEPJZpgNbbS/KyYbxhxDSecPLl7HTDTGH0Q60aF8VJuzZeesxtMoy6VrE+ghqmVBDJlv++Rge0wNfjm/kKlCwHSWWLGWl3/1a9TTIS1R3Dei6Pq2iknl7m/ofRXI5zH0D5ECMc9tBUDIve5pYBEBZp34INnPH3v5RzIpEVzkp3zT9rcv0M1Qc8kcRJOalk+CYwufxX3oDm3cjg8FHwnUxgQ3JXMG1SrfSEB3tMntQD2slxFum4xKlyxoxd7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 16:51:41.2253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e966a76-9c7e-474a-57b1-08de900ef2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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


On 3/31/26 21:57, Matthew Brost wrote:
> On Tue, Mar 31, 2026 at 10:26:35AM -0700, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Update the amdxdna user-pointer (ubuf) BO path to support creating buffer
>> objects from read-only user mappings.
>>
>> Detect read-only VMAs by checking VMA permissions across all user virtual
>> address ranges associated with the BO. When all entries are read-only, pin
>> user pages without FOLL_WRITE and export the resulting dmabuf as read-only
>> (O_RDONLY).
>>
>> This allows userptr BOs backed by read-only mappings to be safely imported
>> and used without requiring write access, which was previously rejected due
>> to unconditional FOLL_WRITE usage.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 29 ++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index 4c0647057759..3769210c55cc 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -125,6 +125,26 @@ static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>>   	.vunmap = amdxdna_ubuf_vunmap,
>>   };
>>   
>> +static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +	int ret;
>> +
>> +	mmap_read_lock(mm);
>> +
>> +	vma = find_vma(mm, va_ent->vaddr);
>> +	if (!vma ||
>> +	    vma->vm_start > va_ent->vaddr ||
>> +	    vma->vm_end - va_ent->vaddr < va_ent->len)
>> +		ret = -ENOENT;
>> +	else
>> +		ret = vma->vm_flags & VM_WRITE ? 0 : 1;
>> +
>> +	mmap_read_unlock(mm);
>
> This looks highly questionable. Drivers should be reaching into the core
> MM to create primitives.
>
> I also glanced at the userptr implementation here — it’s quite
> questionable as well, especially regarding whether notifier locking /
> hmm_range_fault interaction is needed on the driver side.

We implemented hmm_range_fault and notifier logic in amdxdna driver.

https://github.com/torvalds/linux/blob/master/drivers/accel/amdxdna/aie2_ctx.c#L921

The code in amdxdna_ubuf.c is just getting the pages from user allocated 
buffer. The buffer pointer will not be used for device access.

Instead, user space will do a mmap to get a different buffer pointer and 
register to notifier for device access.

>
> I’m fairly certain that, with a bit of thought and some extensions to
> DRM GPUSVM, amdxdna could build userptr on that layer (Xe does this
> wihtout SVM). That would isolate core MM interactions to the common DRM
> layer, which I believe the core MM folks would appreciate.
>
> The biggest issue I see is that get_pages() in GPUSVM also performs a
> DMA map, which amdxdna doesn’t appear to need. That should be easy
> enough to split out. But amdxdna does need locking semantics, notifiers,
> etc., which GPUSVM already provides.
>
> I’d rather see GPUSVM expanded for the amdxdna use case so future
> drivers can use it as well.
>
> Happy to work with you on this.

It is wonderful to use a common drm layer to handle all the similar 
requests. It will simplify the driver for sure. I will start to work on 
switching to GPUSVM. It might be taking some time.

In the meanwhile, are you ok to merge this patch for now? This is a 
required feature for our product.


Thanks,

Lizhi

>
> Matt
>
>> +	return ret;
>> +}
>> +
>>   struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>   				 u32 num_entries, void __user *va_entries)
>>   {
>> @@ -134,6 +154,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>   	struct amdxdna_ubuf_priv *ubuf;
>>   	u32 npages, start = 0;
>>   	struct dma_buf *dbuf;
>> +	bool readonly = true;
>>   	int i, ret;
>>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   
>> @@ -172,6 +193,10 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>   			ret = -EINVAL;
>>   			goto free_ent;
>>   		}
>> +
>> +		/* Pin pages as writable as long as not all entries are read-only. */
>> +		if (readonly && readonly_va_entry(&va_ent[i]) != 1)
>> +			readonly = false;
>>   	}
>>   
>>   	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
>> @@ -194,7 +219,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>   		npages = va_ent[i].len >> PAGE_SHIFT;
>>   
>>   		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>> -					  FOLL_WRITE | FOLL_LONGTERM,
>> +					  (readonly ? 0 : FOLL_WRITE) | FOLL_LONGTERM,
>>   					  &ubuf->pages[start]);
>>   		if (ret >= 0) {
>>   			start += ret;
>> @@ -211,7 +236,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>>   
>>   	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
>>   	exp_info.priv = ubuf;
>> -	exp_info.flags = O_RDWR | O_CLOEXEC;
>> +	exp_info.flags = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>>   
>>   	dbuf = dma_buf_export(&exp_info);
>>   	if (IS_ERR(dbuf)) {
>> -- 
>> 2.34.1
>>
