Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235E6C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0978210F4D5;
	Thu, 13 Aug 2026 18:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZsqHvtrX";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04DE10F4DA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je9PHXlAQXDipnHL8XwXCXXM0LCBs07U576j8/LsolWK5xjLgLEDy/cgubE5YvSphZ7/LKrkojBqOoxeUSfKXjtZNmCm06p0oWK0v9t8K2iwkUIDYqPCMzeNEiESs7qkYtV4kjjVIiBYmLsWCeV2gTlQOBIHk2bi8/+Wr+50ZeAbt8X/K6cyb8JBHdStytLbf4lbmeF4/H9rkcTuxIZN6U6umUQJGcHBO0jgVkJ7NQtlYKwTmwbF3dB4aGurB9MOzDUStJrwITJ3JU5GHuD2YoXPSei63ssiDnA/qHQZD528FTDtiXl3sFWprYqimEYkn9uxI6ai7vLQzeBdGUKiqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6JJtkStOT5t7Vr2BJG51M6jpv6w1dSC700B+6YKWak=;
 b=xrQMihUETTI5azIj9maRyrOd8TjC/5hLZ2tH3KWSgfO2jDZKAMElJWLMfFHgbQ6c3Kz2OgYXd4NelZ6oI5ZLXBbdPJKSc71KERAlp2NgTca3DUQ4/WOo23J8vvH+bxMTw7nLlJbqOcNjrIdkHKYcas3XFFiX4xZ4GmPjisf2s6Pnfnxs+w9pUkmswMskwcwa0k+6Cn3IKGMj3jlsMNtGBv1A1FLNzB7xT+pnlyj6rxvX9PjLNVQK1MoNHnIrkeCxXdM9IL1hvLlkSJbC+CsgkMxdymJiST7w6a2bx3UqRAYpsZpQD2y3OIMUDTk+nRT+4rES/cIqXOe/mdJWRWX8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6JJtkStOT5t7Vr2BJG51M6jpv6w1dSC700B+6YKWak=;
 b=ZsqHvtrXUgGuFPKJ4ofSA3+4Jzfe6Bl3sjbZGEDR+e4CqcXWezkSmln45qW1zn5DpwGgCGz2elNpEEs7s4bXXEqndYAG3/MhkvO1KBNCN1URd8+8x8Il/VNzDp2s0jv4qx9BLw3WZ5JeBJBz/B4rNmdYghPeFI4y5BnFtQBaAb4=
Received: from SJ0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:33b::23)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 18:09:08 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::b) by SJ0PR05CA0018.outlook.office365.com
 (2603:10b6:a03:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 18:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 18:09:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 13:09:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 13:08:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 13:08:54 -0500
Message-ID: <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
Date: Thu, 13 Aug 2026 11:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Taimuraz
 Kaitmazov" <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, "Zhen, Max" <Max.Zhen@amd.com>, "Santan,
 Sonal" <sonal.santan@amd.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
 <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af650a0-f83e-48e5-1b92-08def965f44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|3023799007|56012099006|13003099007|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 5rTviwbryeg0JhwyiC/wmgUt/TfRnCf9uB1A2PtpSD9icqwfT2PG+aJYo5PhFca2qkdM3gwkLFtfrmDDokafH2Clpyi6upticBe+ZSP3ekS7JB6NXjoy6RUmcYxcBSttHrvt3OkRGCaMyK4l1ipN1gWTBY2NMpnQom3EX81btzyhq5rWyjgKwaLaHDk3gM4zJK/BxyTCbITqhcCi4pDrgCTPrrYzHivYkFb0aAxE9ItX1gnNq9Okjx7soYfIvnmnPsbRPBAMxFUY47Z9nk1epvycUh6S6dvb1RBGC0k50Z6VjzNXM8UMkv91xg+UP1pO+XzAB6fsFjFX8NIAWlXTjJbsun0E6IkElbtNCGYPJ4CSo/fUf2Yx0HAHXTyb93LYXiWR2KsD8RuTbu/E9yHTbz9389RjQQqdXptJZmpXZ+SCxLk+/Yhv5Lo6EdbEuqT8JfLTT9QnUoDt2Ur0ycC2cy3iuqg4qb8grhvJ9+QlHAQglk6tj1FFOQ0mOrCA87cdPqSCWKXsVuFfhojNatpiEFNBc5RVtCzzOkG46RNlnQLXQ4ixNldgT00fxgzJpbBE6rhIMfsVOT5cN53J9KEBemci521WCmbSuWDKXit15tl4WW/7fcgkgnpeNJ5sx/utxDS0tkWo7LiUBxoO94D8OVruWzqS106pXI1Bqet3I1OBlhmBRPBVswtZ2gJBTj6IS5mhnWmFSPmiC4VUhemcTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(56012099006)(13003099007)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gpRvSINfg+xAUd6VCDrcNia1VzaFiwjTu0T+67pxBpH57CgosF12bGBBWPobpaTZNJmngJXmqllF95WJBKQnJG4+37zfcfSxNRzgJXS8DvSzlxafero6ZcGupYTBkXeon1cXt+rlabfLC7cW7hlhnUwgyikDKErVxENBkRjgK3o/PpyIVh2qS0m8QzI3OtTgAp0ZnRKvS3hLo82KYnaEUtE1mhLzdPV4lPR4humJSBqvdcfOiQswndJR/7/g+gaAmApl4kcTl+wNCYWYFoV+C8Cf4yGrSP6DH/XC/1RkmJ9iEiMM2a4XAEWm/maV2KfuPyqndSSAVJpjm96SVh4b777NmoBbVL3l+oKVrvZqElG3h+CQpHhX3lHcLWEy90caVi4w+h8NKuXWacYdM1rlaSpOEmCv5bdeaDtp1o1bV7SWkIWwIWGvwSMu5YYLmLy6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 18:09:01.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af650a0-f83e-48e5-1b92-08def965f44e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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


On 8/13/26 00:44, Christian König wrote:
> Hi Lizhi,
>
> yeah that sounds reasonable.
Thanks. :)
>
> An alternative would be to use DMA_BUF_IOCTL_SYNC from userspace, but that is usually only for the exporter to implement clflush or similar actions. As importer you need to be able to take the data as it is.
>
> We have discussed before if that shouldn't be changed somehow, but so far didn't settled on an interface.
>
> Question is why do you need clflush in the first place? The NPU is a PCIe device, isn't it? And so it should be using cache coherent memory accesses.

I do not know the hardware detail. The legacy NPU device is not cache 
coherent. And the next generation (aie4) devices will be cache coherent.


Lizhi

>
> Regards,
> Christian.
>
> On 8/12/26 17:45, Lizhi Hou wrote:
>> Hi Christian,
>>
>> Thanks for pointing this out.
>>
>> Taimuraz, this is not introduced by your patch. And the current code violates dma-buf protocol. It look we need to unconditionally return -EOPNOTSUPP for imported BO at the beginning of amdxdna_flush_bo(). Could you help to modify your patch 1 for this if it makes sense?
>>
>>
>> Thanks,
>>
>> Lizhi
>>
>> On 8/12/26 01:57, Christian König wrote:
>>> On 8/12/26 01:13, Taimuraz Kaitmazov wrote:
>>>> SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours them
>>>> only on the vmap path. An imported BO is tested for first and flushes its
>>>> whole scatterlist,
>>> Absolutely clear NAK to that from a DMA-buf maintainer side.
>>>
>>> Flushing on imported scatterlist of a DMA-buf is a really big NO-GO.
>>>
>>> If DMA-buf imports are used with the device then the device needs to be able to coherently access the underlying memory.
>>>
>>> In other words you *CAN'T* call drm_clflush_pages() on imported memory.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> so a sync costs what the BO is worth rather than what
>>>> the caller asked to maintain: on npu4 an imported 64 MiB BO cost 1056 us
>>>> to sync at every size from 4 KiB up. Patch 5 reorders the arms so the
>>>> vmap path is tried first, and indexes the page-array fallback from the
>>>> requested offset.
>>>>
>>>> The four before it are the ground that has to be solid first. Patch 1
>>>> refuses an I/O memory mapping, which the driver currently stores as if it
>>>> were an ordinary kernel address. Patch 2 adds a probe that does not log,
>>>> so patch 5 does not make an exporter without a vmap op print on every
>>>> ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own range: a
>>>> zero length reaching drm_clflush_virt_range(), and an offset and size
>>>> added to the BO address without an overflow check, one level above a
>>>> function that checks the same arithmetic. All four stand on their own and
>>>> can be taken separately; only patch 5 depends on them.
>>>>
>>>> v1 did not reach dri-devel, so this is the first version visible there.
>>>> It is on lore via the other lists it was copied to:
>>>> https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitmazov.com/
>>>>
>>>> Changes in v2:
>>>>    - patch 2: take the device from the GEM object rather than abo->client.
>>>>      amdxdna_gem_obj_close() clears that pointer under abo->lock, which the
>>>>      pre-split code held across the log and the split did not.
>>>>    - new patch 3: return early from a zero-length flush.
>>>>    - new patch 4: check the sync range for overflow on a device BO.
>>>>    - patch 5: say why the persistent mapping adds no pin.
>>>>
>>>> The measurements in patch 5 were taken with the equivalent change in
>>>> AMD's out-of-tree xdna-driver, where this merged as #1541. That version
>>>> and this one differ only in a page-array fallback mainline has no field
>>>> for, reached when the mapping fails and the BO is neither imported nor
>>>> shmem backed, and in the name of the mapping helper. The flush and the
>>>> helper are otherwise identical. This version is compile-tested; it has
>>>> not been booted.
>>>>
>>>> Patch 1 is from inspection rather than a reproducer. The exporter I can
>>>> test against is amdgpu, and amdgpu is the case that cannot reach it: it
>>>> implements .pin, so a non peer to peer attachment like this driver's
>>>> forces the buffer to GTT before anything maps it. Reproducing it needs a
>>>> GPU whose exporter has no .pin, which I do not have paired with an NPU
>>>> here.
>>>>
>>>> Taimuraz Kaitmazov (5):
>>>>     accel/amdxdna: refuse an I/O memory mapping of an imported BO
>>>>     accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
>>>>     accel/amdxdna: return early from a zero-length flush
>>>>     accel/amdxdna: check the sync range for overflow on a device BO
>>>>     accel/amdxdna: flush only the requested range in amdxdna_flush_bo
>>>>
>>>>    drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++--------
>>>>    1 file changed, 49 insertions(+), 17 deletions(-)
>>>>
>>>> -- 
>>>> 2.55.0
>>>>
