Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED362CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 15:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A3410EDA7;
	Tue, 19 May 2026 15:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KwHGkTQz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB3B10E2E9
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx9Q39dOSMW9aA+lqI/Z/hehTJ2YVR14MlP5BFM0cfvIjCREmDwwd6jNpc7W4voHMzVyfE1gUr/bQiPCIL/9UWT4A554EIgm4Hf/WQKJFrkDnKwTaoSK9zBH+Voh1XjUCGlqBbMr12YFFQrkqrw+ttbKWudz5guC8kF8BQhtR8i2l2Oels1r4csN4dPPG31hTWzAU2rDS/w2sO52u4P/BVkc7Lj3MFOazB+M0HiQ1u8rFeM9rlLiKoWVMX9H8BQeVrmhIjFor8hmt11boXu0TTSEAGlGqqncfCZMpRXzB8AYjBKN2M9fyxKtaeq01QcVpPlbwxAFplyVNgmQH95L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIrj++g2kfnbfhGo7Mp+4Y8PdnDkPcKwL04nGUMjCXo=;
 b=Y4lfdKxijekDadeu26hN/YDbLVfo/INDMvCxp24XIkJ91TQxMjn8Gjoo8V9PAi0SgavGQGVGmpb5YtAq3SXmhx92IMs5w40Pc9iQ/nmgcsEzXHG7JvSqP0YhUmuC8RZQ0MI3HJTbh+QyljijZk+p2FFwnAJ09uSZoTdIdcq2y77eOuLQMSWHF9pRv0KrZ66mLlgowDq4ppTw4jLm8kjLpeBynz66Mp7ZQFcDS6sbqsbQ1bog17yXgQEpEIR1WLlcOVmehMhPmROU6ECtlzZ5cr1VFxyTFpexY8zdarfiiC2LtxMfaPpShjqfK4EtF2OMYYAIN//EN84JVqhMjG5SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIrj++g2kfnbfhGo7Mp+4Y8PdnDkPcKwL04nGUMjCXo=;
 b=KwHGkTQz14eEUAftHbWDzX48J1C3bu6qbs1KCG7jWm4uEVhZZHrOvYHBtur/UwoYob03K/RFlWJsCCTZFiMg//dkB4q0FmOtvBHz+K5va/jtQ10U9Qbf+tzS1iSocBpoDqyOnbUgHmIhkHe1m4lvc8nQmAaf0iazmDzLUG71Wvk=
Received: from BN9PR03CA0312.namprd03.prod.outlook.com (2603:10b6:408:112::17)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:54:10 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::9) by BN9PR03CA0312.outlook.office365.com
 (2603:10b6:408:112::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 15:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:54:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 10:54:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 08:54:09 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 10:54:09 -0500
Message-ID: <a8fb9f0b-0cad-e4ea-c778-b87338ce8bf5@amd.com>
Date: Tue, 19 May 2026 08:54:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Remove mmap and export support for ubuf
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>, <max.zhen@amd.com>,
 <sonal.santan@amd.com>
References: <20260518155706.937461-1-lizhi.hou@amd.com>
 <a83bfea0-7d3a-40cb-a437-5be09d59660b@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <a83bfea0-7d3a-40cb-a437-5be09d59660b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: c008501a-7e9d-46f8-bc0b-08deb5beddd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|56012099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: kUY0jo0Vg7UTzI2WxM5LibGLWzAsCVetKTqjR+MktL/NklGEIuceRoYxxzY2iyAY4tUN69qeJS4h6dnRW6jut1tfazv5YgjiY0quiSCqoEPeEMJzyrXIEz9ORgiTcBIhHpiUeOXoueXyK6x7T3yK3TvrP7zwJXlRRnfygIt34YbQ7+uNKrGoUwg4mQZSeRCfLhRLbLP+IpYWji75HD2AN5BLjd5oISjEPg4cBEQl+ie73M0nRwX7bHB/Im/w7BKWnN12xfCqg+JnkW5qDTnnRlgugyJB2YLdEFIDkGjatkape4A6A5LFeZguAm5qAQB6xJhvqv4JMHpbWHiOA7UyoM2j+8hHLUZJ7cMHn4NTV2mpfQIlzROynHJ6mTb/n/rDFG6RBTruHBnkRzFna9aAQG8oDG4j036ax6mSyy/rZHJB3MEN3nVFdENkEz09csH2C0vfYz/Sq/5Zvgxiq4fn9abLIE33Ej+HZRauY8x7BnlD6bYhyF6FkkghyAxI+f+EU9d4GmE18QfKthfs4bwC+m8g3Gb55UjOP49JBX62MszM+ykUvwtVRVbn71FYCurQkfK4HCBBT4JeHJn2ly75h8dQgJHvdx6AOeMapV0ZhFzO3WdTXwbKy+x5i4huf4wKfuFj8+zjnEHU638zfHdGZ2AY4pjt/TCbB4TcXo+DiOAYRNJ4q7hNPZIqB8hX8w9samigvNObvCdJZnDLPk2UOXRSnSYHg6v7VvGCoKZF5Dg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(56012099003)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: snNAx22568PvRCXBRIXyT35N46+mZC67GZW7DnyWSG2ZGsBAsG+vgQEz8BtfFbBBcdN99qs9UwVSUZagSd6Nzg6nmrnpVt7b+Nz5uGMnpy9DgjKsoB8Et+J1L3Scs94I/2LNZNuwc2Cvjbqo8ef2F6mBtybGj2RFzWi4DQ2NWmORHc7KxU4y2I8cH19kSH6B4FQy7EXnhyzXYlph+fZKorYjWJcloexcogj5i0FwfaUwbXk3Or6IoNg6AITezSau8nIs/PrFHIs0Jyh069iItCZYYc9IjZGICcFQg9zXBGhNtxyu6+HlYmYYWU6uXwZsJrlJGwSL7DdclzlNqs24JaVBD2+sPRUid04N126/iHOAYO3QYO88wLbT2G/y/X0ZkNGyR+ctKAqqh5cZF0u3y89pQQ+cYv0/XkuYc9NQOG3KjSGhjl0RjlkGV1jOlRch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:54:10.2882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c008501a-7e9d-46f8-bc0b-08deb5beddd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

Applied to drm-misc-fixes

On 5/18/26 23:42, Christian König wrote:
> On 5/18/26 17:57, Lizhi Hou wrote:
>> Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
>> and return -EOPNOTSUPP when exporting ubuf objects.
>>
>> ubuf vmap is also removed for there is not a real use case yet.
>>
>> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>> v2:
>>    Remove dead code amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault
>>    function.
>>    Rename Non-exportable buffer flag from 'pri' to 'private_buffer'
>>
>>   drivers/accel/amdxdna/amdxdna_gem.c  |  9 ++++-
>>   drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 50 ----------------------------
>>   3 files changed, 10 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 319d2064fafa..6b9b556de555 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
>>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   
>> +	if (abo->private_buffer)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>>   	if (abo->dma_buf) {
>>   		get_dma_buf(abo->dma_buf);
>>   		return abo->dma_buf;
>> @@ -716,6 +719,7 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>>   {
>>   	struct amdxdna_dev *xdna = to_xdna_dev(dev);
>>   	struct amdxdna_drm_va_tbl va_tbl;
>> +	struct amdxdna_gem_obj *abo;
>>   	struct drm_gem_object *gobj;
>>   	struct dma_buf *dma_buf;
>>   
>> @@ -742,7 +746,10 @@ amdxdna_gem_create_ubuf_object(struct drm_device *dev, struct amdxdna_drm_create
>>   
>>   	dma_buf_put(dma_buf);
>>   
>> -	return to_xdna_obj(gobj);
>> +	abo = to_xdna_obj(gobj);
>> +	abo->private_buffer = true;
>> +
>> +	return abo;
>>   }
>>   
>>   static struct amdxdna_gem_obj *
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
>> index 4fc48a1189d2..957305ccb485 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
>>   
>>   	/* True, if BO is managed by XRT, not application */
>>   	bool				internal;
>> +	/* True, if BO is not exportable */
>> +	bool				private_buffer;
>>   };
>>   
>>   #define to_gobj(obj)    (&(obj)->base.base)
>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index 3769210c55cc..bb60fb80467e 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -69,60 +69,10 @@ static void amdxdna_ubuf_release(struct dma_buf *dbuf)
>>   	kfree(ubuf);
>>   }
>>   
>> -static vm_fault_t amdxdna_ubuf_vm_fault(struct vm_fault *vmf)
>> -{
>> -	struct vm_area_struct *vma = vmf->vma;
>> -	struct amdxdna_ubuf_priv *ubuf;
>> -	unsigned long pfn;
>> -	pgoff_t pgoff;
>> -
>> -	ubuf = vma->vm_private_data;
>> -	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
>> -
>> -	pfn = page_to_pfn(ubuf->pages[pgoff]);
>> -	return vmf_insert_pfn(vma, vmf->address, pfn);
>> -}
>> -
>> -static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
>> -	.fault = amdxdna_ubuf_vm_fault,
>> -};
>> -
>> -static int amdxdna_ubuf_mmap(struct dma_buf *dbuf, struct vm_area_struct *vma)
>> -{
>> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
>> -
>> -	vma->vm_ops = &amdxdna_ubuf_vm_ops;
>> -	vma->vm_private_data = ubuf;
>> -	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
>> -
>> -	return 0;
>> -}
>> -
>> -static int amdxdna_ubuf_vmap(struct dma_buf *dbuf, struct iosys_map *map)
>> -{
>> -	struct amdxdna_ubuf_priv *ubuf = dbuf->priv;
>> -	void *kva;
>> -
>> -	kva = vmap(ubuf->pages, ubuf->nr_pages, VM_MAP, PAGE_KERNEL);
>> -	if (!kva)
>> -		return -EINVAL;
>> -
>> -	iosys_map_set_vaddr(map, kva);
>> -	return 0;
>> -}
>> -
>> -static void amdxdna_ubuf_vunmap(struct dma_buf *dbuf, struct iosys_map *map)
>> -{
>> -	vunmap(map->vaddr);
>> -}
>> -
>>   static const struct dma_buf_ops amdxdna_ubuf_dmabuf_ops = {
>>   	.map_dma_buf = amdxdna_ubuf_map,
>>   	.unmap_dma_buf = amdxdna_ubuf_unmap,
>>   	.release = amdxdna_ubuf_release,
>> -	.mmap = amdxdna_ubuf_mmap,
>> -	.vmap = amdxdna_ubuf_vmap,
>> -	.vunmap = amdxdna_ubuf_vunmap,
>>   };
>>   
>>   static int readonly_va_entry(struct amdxdna_drm_va_entry *va_ent)
