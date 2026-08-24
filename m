Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F285C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7678C10E56E;
	Mon, 24 Aug 2026 16:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p1Bzj6Am";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF71710E56E
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 16:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY26qbpfForgG9gbqPZj0vNPJPGDeKcZAojib8XOq9jnk0qJTM7tlSTImA/UzHzs6uTd0FwOvA3b/o6ZcvM9ZiYFi5tDoxA++FHgFqDwzYQFwR6AkvXj3PIu3O6rlCn2WRx45Y10YHZPG4HbiltrJSpc2wCwH+f/w4JZpCqoYXpQN+PXWXBBR6V++THTDtvUC09gnTBYJCWpBBqI6lrwkOAAPW/wAi68Povqqwjt6hluDFEiws+fB6lugDN6vYeaEsag/ZxIkXs8PCxeE6d+VrFNIj8fkXc3hpDw717+yoOxuate+Ls5WboZZan1BMKhaCDOf+GWH1G8t1/t5tv9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoTrOkb2s6Ak9ZZ9TVuiyor5gEhRT9imG9Uw5QLEWCM=;
 b=HrXqGPnPySwBgEAEMXORuzU2gF8X29tjgPRQJ0GrS+lmD7SiuMBLolYQzQjBqUbXNgvuK3F3Hbu1/zZhAiXSCh+0r+ebYxQ6NsTeMxSFEU19K6+y9akxesZdhxh9Ol4HsejanHJeuX53UZXMdJ3TwLIfT0OfILYl2dGzgZxMWPP1c+c0o8z2GANWHkkASyeJ0V8djmp7XyKZI6JqR6XKXwkWIujAQpUuYQWd/qLirwu0RAUS+wYzcW2vpTlMRpWzpE6G+LeQbBC8Uzuots1WvPxkPw9VI4GkhYxGAUpdRxPhmbhqlvDZUmLl4WchAjV3nmteE1ndFNwg5vYsDGUUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoTrOkb2s6Ak9ZZ9TVuiyor5gEhRT9imG9Uw5QLEWCM=;
 b=p1Bzj6Amp/J2p/aYDclP6Vwlct47zC4bVsEU89B9BJrET1YIafJihJMKeWvXF4I3kiaZsTrGkcJgxn+3V4eItJkZ4YYZ8UaBQlH/whgL2zGYKx52N2r8GcF9dEjBvY0aTjuC/CMWz3stjxHjWxN+4kM1hbusU6ez06KDtPfkB2s=
Received: from SJ0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:a03:39c::27)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 16:08:10 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4e) by SJ0PR03CA0352.outlook.office365.com
 (2603:10b6:a03:39c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:08:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 11:08:09 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 11:08:08 -0500
Message-ID: <a782e2ad-d12a-66c8-447c-725d8e66593d@amd.com>
Date: Mon, 24 Aug 2026 09:08:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Taimuraz
 Kaitmazov" <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, Oded Gabbay
 <ogabbay@kernel.org>
CC: Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 "Sonal Santan" <sonal.santan@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.43960-2-taimuraz@kaitmazov.com>
 <5933effe-ef28-9838-1dd5-dc904be0a3bd@amd.com>
 <87c9bb85-2514-44ac-a976-e24526c7f76e@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <87c9bb85-2514-44ac-a976-e24526c7f76e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: cdef32c0-d9af-4d37-db4a-08df01f9e480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oGKK1fd5yJawePR8mwwg/tFuRmO+IfgC1E9sYqJHD16jxYuI28O8+FuacDCcj2TX+03NXR0siR3pZHPuyfoNp+13XLmPPDxZNEwzvHFyLKgJN2jLG98OaKqaUXp9FXsBH9vlNPZAsc8t7Cb+vMJiL17LTNwPqW+umR1orNm7p0dq97sRX/RUkWnz0suqrXpZ9vwOFrdYeSHCiY/z1SO2qOvN8SQMUlRSeXbqKxMFKFKLEnyW1XURHh/DiyrKa9s1T5Uvrc4Hw9qa/3XjsaeZd9YgBtgQhMl01RShjxWr1ShkfzWmLEkQxC+f2r36t/fS/sqSfD3ZstXmApMsZW7546OIg/kYv0M2TLpkIWnw+S8/j9mn3YZtS8F0nWjnv3CGvTLuUCsQfkfHfexwK+hBzSQwQOkg6DMQD/oZBm4ql16A5l44ZJMd+Y1ImbUZzIvinWmOhAwSg7alIl8q6S1EmwW+QUAXIt1UQaJrWKqt6EJ7zd1prWnwHjdTwxyswfWbaXkxt6ru2zcVJezES83ASX9NOIvseHngMXeMUtdxvKQKy0PptZ/eLhfY31Bh1LY3whAIWU5leTmzFk5zQT5IqdOWfxwR6A4MUlT0tSF7toqgu9Xbjdymbi4kCviod5KfHeJsKFwyPnS82U8R0zMyj/OdV8LD4RpyvJ3AKjxHK4GVcbfOH2mrdh6GWASmpBdFRq01wPnSFMqsyk+0Q5TVwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7fZqTkIKwVn7TGYtW5G0aWE8oqfpjv4XzDLyDM/YodMfVBkmBLydf3f78lgOyaEAFsDqM57ZHqA2TxRTBS2lzqDSOp/dvb8pQRGD4x090BaV+InG9nPfQ3CcBLkW9rBmJ4iVEBrbrWlD3DzBQ06u1g0dlQpvEiGZ5HS0VGVLK5Kwkohz+3rMDhJbeUx50UHhoIOCjDky6kOWWfoJhcQY0Gle0sEEGFvNb0lljAeI5EPQrcGFxunEdSoQIOJZBePWPHf4xC6XOyCkHeryjP2oLJJaGUtcbzU2DagFaJM0o6Z8q8CJyXnVU56iT+V/o/h/bB/j/p3dn4HrhcLdezOeCNvwTEILYckpyTaGWYfKypWbqLys+s+B+U+MBVwjI42AWWj0x/ig7cthWiB/r4HecIZX+PcyiPlGjbPUzevJrYr1wuJx72UVTqoirpgLw3Yn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:08:09.9564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef32c0-d9af-4d37-db4a-08df01f9e480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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


On 8/24/26 07:06, Christian König wrote:
> On 8/17/26 19:53, Lizhi Hou wrote:
>> On 8/13/26 09:46, Taimuraz Kaitmazov wrote:
>>> amdxdna_gem_obj_vmap() takes whatever dma_buf_vmap() returns and only
>>> rejects a NULL vaddr. iosys_map is discriminated by is_iomem, so an
>>> exporter answering with an I/O mapping leaves a void __iomem pointer in
>>> abo->mem.kva, which amdxdna_cmd_set_error() memsets and memcpys through.
>>>
>>> amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
>>> buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
>>> peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
>>> no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
>>> object, so an NPU paired with nouveau or radeon does.
>>>
>>> Refuse the mapping. vmw_gem_vmap() does the same; unlike that one this
>>> path is reachable from an unprivileged ioctl, so it does not warn.
>>>
>>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>>> ---
>>>    drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>> index 1f190b319bb..b66ec9e4828 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>> @@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *ma
>>>          dma_resv_assert_held(obj->resv);
>>>    -    if (is_import_bo(abo))
>>> +    if (is_import_bo(abo)) {
>>>            ret = dma_buf_vmap(abo->dma_buf, map);
> Mhm, why does amdxdna a vmap in the first place? For some workaround?

This is used for flushing the imported BO before. Based on our 
discussion before, the driver should not flush imported BO, so this 
becomes a invalid case.

On the other hand, vmap on a io_mem should not happen. So I suggested to 
move the check to amdxdna_gem_vmap() for an extra check.


Thanks,

Lizhi

>
> Usually DMA-buf only provides that framebuffer emulation scanout inside the kernel.
>
> On the other hand as far as I can see that here should work correctly.
>
> Regards,
> Christian.
>
>>> -    else
>>> +        /* Callers use mem.kva as an ordinary kernel address. */
>>> +        if (!ret && map->is_iomem) {
>>> +            dma_buf_vunmap(abo->dma_buf, map);
>>> +            return -EOPNOTSUPP;
>>> +        }
>> Thanks for the fix. The 'is_iomem' check should be moved to amdxdna_gem_vmap() to cover all the cases.
>>
>> Lizhi
>>
>>> +    } else {
>>>            ret = drm_gem_shmem_object_vmap(obj, map);
>>> +    }
>>>        if (ret)
>>>            return ret;
>>>        if (!map->vaddr)
