Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75B0CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFA310E1CD;
	Mon, 18 May 2026 15:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u72INwTA";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95E610E923
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScSr7O28quehO675EXWxi/J+C2MMKX/SfKBJvhzucEJ0d52y2LaxB4PeZAxe/zS+CvKp8WaqcNY8Mn2hvXbSQYhCb41jjGSaM+/WH+AZwJhOr5Dk/0cH3ue7oGHG3EJlYxWux2b70GFHbaYVl7cu+YWbWlidaFffeXQvtS5j4MeJ31p1I9MOJfjh7ZIsd07Ahh6Q0iMhaclQe1WVuTH47fMND3HE+ZnjXO6pOtPYwqcBwEs5hUlQqO5l/z0w1G00e4QpeyuzKNbdfAE3cuRB9+JUmmxQczsz/g4DNRcuieOrAOno0yj/MpjNLejDucdxYQ2jTqRTVNReQ0akKL2Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/zKahurwo7ZsQ0Fkij78L336XOJoyyMVYL/lrdBVBA=;
 b=KSaMyJoggstDPS6DulmxOwS2mH7793wUrCuHadrGOSN2xr+mkdBNJeyQol8LTPRH18bLeoPhoqDZoX3AQ7m2UruI1J3N8St6qCzQCZKhnGMouxpXpScPj1px5AbRz6/iPUF6lP9RJ0gdxcbf98uvjCGI/OJTi9bE18Ya0cLRlnrcnsjifD8jqC3XS6KANQbeoL7962wwOSTdYG2GE4v752ZA36Q+l7mOdMLlWDBUkPGJtvcwCC/nv7bErKrtza97W5MkFlvhRnU/7kxjZWPI9WJ9HxCWDJxP2FTHQ4yNgop5yhMlqj2lvYk78mYoESOy0WlVEg0qWGPOogY+rV665g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/zKahurwo7ZsQ0Fkij78L336XOJoyyMVYL/lrdBVBA=;
 b=u72INwTAq0LGDaO2Gv5CGAVO8y07rYzhyLoNyTN8S4ANeyCvWqkJAEqckJ3avbGiSiLH8hN2f0kRMebkU3UBE5O0x6Y+50RuWeRIrDKyJdW6Qkhx8TdCghxqC9bQSlbczqFQW9FdqIQ91ba2HkCAnA+4sTCmvBlIb6jIFfToP6Y=
Received: from SA0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:130::31)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 15:55:48 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::57) by SA0PR13CA0026.outlook.office365.com
 (2603:10b6:806:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 15:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 15:55:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 18 May
 2026 10:55:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 May
 2026 10:55:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 18 May 2026 10:55:46 -0500
Message-ID: <0f0dc434-dff9-a6cc-a5a1-2d200eef5905@amd.com>
Date: Mon, 18 May 2026 08:55:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Remove mmap and export support for ubuf
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>, <max.zhen@amd.com>,
 <sonal.santan@amd.com>
References: <20260515155332.743097-1-lizhi.hou@amd.com>
 <2a5cfc68-61ae-4399-86b3-3e16dfd1e42a@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <2a5cfc68-61ae-4399-86b3-3e16dfd1e42a@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 97dbe1ef-4b27-449d-7135-08deb4f5edb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: ylyAItKh+0MEQsW/pLh/uDdu/zSeuZ+pUejc3bTP95NyukJ7fuIMRxTK5xlhR+KGglpJnpxBYZKhxPa5PdVsAGyn4zykHb7sV+x9AujmmorNIrQeRf0YwqjBSbaLQIxl8UMm/nDbbViRbhdaUcyNQBhcSiAXWPK2zSU2AKOQLqqXW4hVjZGW0VCEWQHf14fbDpJV8p0tXou0W8YRlEwVigjPj88tAa//Ew4waekk2ZJLtdhVlWU4+DEmeeeIP6p+qlqKa0oyUVMnogUUSUQrbXvgdLrdaVWHJ/ajJTJoyRqcI1cVLe8+lwU++vowQPPaTtmPTaMvDMwsEkrneK++0TJPe+czdxa+dTFwLXORrnPwQOxae191seLHmHQfsVUQiB6K+UDybZDpp09p8hOXu90hWa8pybTN6Icp1OffoBxgv14/o8kqgXDhEiHLEFKqzbx1YT66j/E5f00Pkhzy0D4GRxRIjUaBrkdpgmQQQ9GqR8Nmn2YT8disINUWVkZIy+wQVHBn7PSr4yDXz3OGQPYzOHVS6+H9/1trWCt/ptlpOrsy+NPe395VwoTArTDPt/1v6RRhX9OVwhFBw4heXXjpxqp0luKte3Ka04VV+cTkLUjin/va328FQWmD2Dvp/nRNuD3yVsateWo7D8zz15hEqW877Ld6KqaBs41k/dEGPPhbpVxS15uV01Daxtrog0gu0BDO39zTN25ZDkiYRmp2OUhFjnX+HFd+NDc98XM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gCMPKi+O3EXKU+IH4cGCHPHcGIOR5gDFWOeEhLHb5UlMGWfG1GevCwylHyTFE6q7VmjsQwS32PI5tnFrZywEHd+yFl8p+Tvns8UAkFoGMRN5rSaiV/EIhB5UMx+R78AJ/7BWAP8Y4avgnphWHkS4FaiDVdZKVSLWisQGQ8ZqqWSfvUkAnOX6i8V+Sto85DYHWWrvTNdhXi186EHKxSr1hvlxwpawgLirZN7tC/g34hvECPfsjq+Pt61Tgfp1mNJRz6iPEfWqHLU22CnrOVtw7LuGc8DuoVet+mevz/KSz+Omen/LDj2r6nRTOA1v2CUOe/wCkczHH9MzPwUhZPicxVWhBS3ndD19GQPfQtQDWSfLDGfeJ0R+3pOmYTpPgjBILTHMxoM84EwjLQ6qY8YvQar4ex2KpE9AI/gsgP86RfAtBrjy5umn8ij1sWdg2EWE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:55:48.0315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dbe1ef-4b27-449d-7135-08deb4f5edb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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


On 5/18/26 04:46, Christian König wrote:
>
> On 5/15/26 17:53, Lizhi Hou wrote:
>> Ubuf pages should not be mmaped or exported. Remove the ubuf mmap callback
>> and return -EOPNOTSUPP when exporting ubuf objects.
>>
>> ubuf vmap is also removed for there is not a real use case yet.
>>
>> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c  |  9 +++++++-
>>   drivers/accel/amdxdna/amdxdna_gem.h  |  2 ++
>>   drivers/accel/amdxdna/amdxdna_ubuf.c | 32 ----------------------------
>>   3 files changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 319d2064fafa..6087264ba1b5 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -492,6 +492,9 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
>>   	struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>   
>> +	if (abo->pri)
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
>> +	abo->pri = true;
>> +
>> +	return abo;
>>   }
>>   
>>   static struct amdxdna_gem_obj *
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
>> index 4fc48a1189d2..162e5499f5e0 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>> @@ -54,6 +54,8 @@ struct amdxdna_gem_obj {
>>   
>>   	/* True, if BO is managed by XRT, not application */
>>   	bool				internal;
>> +	/* True, if BO is not exportable */
>> +	bool				pri;
> That member name could be improved.
Sure, I will change it to private_buffer.
>
>>   };
>>   
>>   #define to_gobj(obj)    (&(obj)->base.base)
>> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> index 3769210c55cc..df4ab225fbf9 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
>> @@ -87,42 +87,10 @@ static const struct vm_operations_struct amdxdna_ubuf_vm_ops = {
>>   	.fault = amdxdna_ubuf_vm_fault,
>>   };
> As pointed out by the kernel test robot the amdxdna_ubuf_vm_ops structure and amdxdna_ubuf_vm_fault function is now dead code, please remove as well.

Will fix this and post V2 patch.

Thanks for reviewing.

Lizhi

>
> Apart from that looks good to me,
> Christian.
>
>>   
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
