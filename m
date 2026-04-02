Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3504CC6B01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686FC10E22B;
	Thu,  2 Apr 2026 05:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4mRcwCk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DDE10E22B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdM8kp6ddioONaEVDVEZc4MExwhH3oBrYzwFGMO7qFn/FFhVkWus7d89YK+Ay+70kDXAohpUO64+9rxHKaNp5ZdcW4xQD/p1loWEn9KmN7zWAWzhX+naLVaTG6LQzWfdSmO/KZUC0j/RKm8FjZHN7KM22j4Ato5TQXw9G6LHuybUsQ7RXNzMznmXl84JY4KDCfbNE6gO8jKhQuTWXeHCXOJAKSKSDepKdod9UcC5HLCEb4VEvUW8Sr5PEpnfYzDPsI0lOEXdQiW/19ugsjRYNNggvYywi18eTrkxT30wcmTI0aolC6k7C7vDJfeXnQmR9UDzTK7xJJbBnvX2QI2MzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuj2HpLWXHee/YJE/XW1f/ch2sIJLYJkmygyy+0TNBs=;
 b=SFJsayZMal8vO8qWDkDoS8w6JwMRPHLAYyFCQqSkHOAgGRF8cQue7VrmN6T0vFb6q3YR9X7Ulg0xXYRVWM6RuE2ASF1ARfU3W6/6SKXOxoiLQpbBOAKeMFQ5KrWeBh1EXUyTAwDiN/xx3VfQInFTmSrCvalvPYW2IPG/jPmujrtXD2p1+L/9QX0SNfS9PF6T05RhSq9/vWZJo/WQ5qbTJcRgpBC1IRtF11esrhElBA71N5nL0LPdnkntb7OpUZmDznI+4oU/WG8ORNrRO1m5l+O1Q2hS86qrFPZCKra9iEF50JP/6S70wehnHhoDuolJSoa/Wngpm4wJcHg3QHp0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuj2HpLWXHee/YJE/XW1f/ch2sIJLYJkmygyy+0TNBs=;
 b=D4mRcwCkODUr5dsXuu1tGbj/ifLARPB8xKrjjEytjtLMENnsd0oWPkio1dlulRDfVtrvxjiBPoE8AwjN3qcJxyK3Bu+x36kNacc5a59KxqudeIyneci0ndKUBOjDxMIA6grcib//X0/5V87yNtEYO2byRG2FOC2+xt24KwsuW2s=
Received: from CH0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:610:e4::24)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 05:24:31 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::7b) by CH0PR03CA0199.outlook.office365.com
 (2603:10b6:610:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 05:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 05:24:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 00:24:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 22:26:32 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 00:24:29 -0500
Message-ID: <8c23f8b0-373e-956c-1430-311b0df6fb4b@amd.com>
Date: Wed, 1 Apr 2026 22:24:24 -0700
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b53717-7924-47ad-1f3b-08de90781e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: McZDZRXF8x/puYi0FIwpWyP7Ada/6kMmKtKcpPzuZwLgBuC1BCS3BnHJ25PGKSYuziSvyw+SOrXdMr9r/FQBWcsOHGviqBqAuoCpEjLV//0KjqBnwUD++25Y6PtmgbySCHS7IGngWdxXqoSz3eFkAbApuFORdpr/dG40HOlxY3u5K97H8mbRLBad3AQGrfz3ohjrbne3cGAcq6O0/84AaXDD8tqdVUmJ/eLzl8koAyx3ymRu2I3e0Zp2yNT25Ksl5WYnSapyhIaDN3T3onD/+62PCydrepgAL0D1Z80m3xskSbzt+FJ86Olttpe0gKAxeCpO2GSmkwM3vC1hCtKbExk+Yw/ieE2ayxztI+w+9Is2kNyZWseDtb3/BvS8Hrb2fPWjOUQwCdOKaN50Yw91rP8KaHUc0SjKjeS19dK5gVtHtRsiPIVqDp56i+HAXTcNKzIm4CRb9XacdKYKCgWMA2dHVztC3K+FChFl0rbVK6feJh6RF2LlUlHSJLnC0Sx3h6aXWoLm8CQ/oulxouIjpn7IFqFnJ5UUYUy4PwM/HuIXhrqjxqAOABAnKLEjHHjPTcxMGic06twJFmIgBCONkEmWr03cTl4EnkqbRV4TB/ZYvfgMoAQcOGEDhDhDxdFC6FFFeq1Cl9N3qQOvUGuadkHsCke/3ghdLErpP10/O4PCb7Gbbgq8HchmJRwU+fSiw609HTVmU5Or3me3pBpqdVq7s9PfeUcS+nsjYoFaoy2VLyuppGrLgTBHiHgrbhh6Q1Kv1gTrEUGDlS9eslNtWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S7QfFnawGVTzwzBOK1yJNmt1zbxOVUK2jKWLvi8jTnOfPmxRuXk7SevFuNNAVam9l0ydVOs+ESbScxpDDv9sn7EW8Fwe10w4AkdfVbpBq5y/bUqJxMPxC+t3vcJRvjnxbvtFbaQheEenSVu4ZYio1rp55Ekx7/nPFl1AsDd6AIaFwqrGEuf0XDfgwvqpDJlOl699NoVFir/zoST/9zOfxcpPa/CltTEcF6NwxXZ15D/chfUwjJYGyI104zSo8hjzXHnq9Yefs342ncmrYu5RLMxguoyV5zODEpFcaNsyCTw0dOfDiqiISDGBIALxE3ujL8oPuW3bTxpzOSrwX/8VXnHgvigul5txk7mpNgX0dwarov1GjrD4O8bXHoR8MSn3vhz/IiEoTuL3nXLxXk1UlTsF0Jzys5zXauUsxSolnZuBAh+dVBRvLE0dJd4S2AJK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 05:24:31.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b53717-7924-47ad-1f3b-08de90781e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

Applied to drm-misc-next

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
