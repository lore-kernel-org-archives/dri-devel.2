Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64524C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5D610E425;
	Wed, 12 Aug 2026 15:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4+D/o4yx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CADC10E425
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTGK/XLBEeRRx4QU9HLPAP0aWCrYy7Ndh9NsnHV05F6U28x9n7j366naQ1Q2rjF3YdptGO63uE9+018hrC9dfRSypTssKa2c4v36eEfbXFDPwWEyQbYAp2Hie/zYOuoa9CWqk7QZRkhXPauUnTSsIiJjDlvGl+ij4cEQwSuOETFyKsysy8Pbz80uYFBWGJo943U/JirWd2b0LLB9c68sbJxhUFF70L97miM4Z2bCB1bFYpwu3j/DRu414AbOYA4naqhRup5wY9Fxwj88uCHrCL/PNixrXnayfMIdXPDPc1bWLbqHhBfHFxRlvN3xz4Of1wdjXRspZAQIb8q4E9oYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaj+IUZls1mEwf74SjwB8CWxMZTuOk6brAlQc/hv0rg=;
 b=vbkvE1Rc6zxT/ABZDafDa5aGTidgJDO1lkgvS8yw/asgfMG+pq3yJMK6dsIsXs1bnqTrldsiS9VjtUAGTEEoF/TUTY1vIJhNStUpL3OGL1Va7g44RmSQjonzXV219ZmR7I7uW0PQPUfYzBr/ACgN5+Ap6xKhOQrS/3zkXPlnFy96VnravUswMwtCoyMRkfBritd1DwPMx1VwWWdYp2RFStAS0zrIBhXrF4qmOCZYFFGDhRgBU8tFgDHTX+7Trijq/CDw5+SnwcEHCJvcDZ4R7iAHjI+YJ2qrkSav3/EhK2fr2kGR4Cfw6iwUHLm3uuNYj+CWzBBsriWnKtVrCrcU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaj+IUZls1mEwf74SjwB8CWxMZTuOk6brAlQc/hv0rg=;
 b=4+D/o4yxusbpntzbM6CVVyOEj7wrFQrdTUffPptStco7i4QPb2wJ8GBhdJPwP9lvGD7qOk0gpkJbeXyQE730/+p5x6fAdKKihT7GyVyun9aDcobY/F+fNqz+hwhcfRt3BwKZEgg00S/IGwIK1vMkvinyCkeLEcBNHhqY9SVlmUI=
Received: from DS7PR05CA0017.namprd05.prod.outlook.com (2603:10b6:5:3b9::22)
 by PH7PR12MB9152.namprd12.prod.outlook.com (2603:10b6:510:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:45:15 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::3a) by DS7PR05CA0017.outlook.office365.com
 (2603:10b6:5:3b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Wed,
 12 Aug 2026 15:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 15:45:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 10:45:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 10:45:12 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 10:45:11 -0500
Message-ID: <224dd281-da48-84b3-a048-016b51aa0362@amd.com>
Date: Wed, 12 Aug 2026 08:45:11 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ee663474-5de0-4ffe-8ac1-1dcdff5dbc28@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH7PR12MB9152:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bf70af-7cbc-4ed4-7ef3-08def888b342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|56012099006|10067099003|18002099003|11063799006|4143699003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: qByRcup/tz7rRHYACtNw8gcFrvi266I83C445jDqW3BpE2PSk1tFqWdwltM6k3A/JXu1GzzWr18pul6bZ8TaK8V5MtnIr5BU0saIjKLJ3a2TBzxdomd+eNbOeYf+nBGhe3YGos0V1zUOwXM3v0h1Yb3w+Lt5/BhS2eWBEqVlC1M9njjwf7DeH2O+ktuElvDStKCQeQC1a2GSS/sEaHnRY1XshZEi+sdNqyHHOJVGx4yKFQV4WbRf3yReSRZhRE8v/Qab3snhe1K2IxCn7ePR2eI2FJqdLKThP2sZycfvSUlAh8Yh0poHEoiN3xkakIm0W24CPDDYpOEMmVY4uYvn3fdO0e7pMHtBwND8b0MH6Jnp9vj4wKyHEmVAFnwxaRT9kORBmtAfkrrDJxJBjqNE1Bv9eouafq5mixnU6ed15o0t2fGld5MYwEmL1CBqcwUKe6ATrfqwCVyDHJs/5iwGhFAxhtMFgSZDLJtg37FhKr/mem0/YFMtwUP1cRE3mpqLp3EF1qJQOTd4pRSTIVYx9Usq2jd/HnXp8aw+4fSsO1T6HipI5+eOA7eBYeV/YjUSicBBXJSM9QAEkNern3UK5vWFKnh7VnWLcCFk13Hms/kduq7cm+yweDrEMaESZ2dchtxobgeIHQ7bSyB3drW7wulllkZsxpCYz6pKSLgCVikvDg1GOZLvtb2L192LDxlYIAQTiicCp5Zqc68gYg+xjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(11063799006)(4143699003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dCrDWSYNJN39yJ/sNdK2/SEz/aorfvDdTw7oQriBtHF+6F/8ek4is7WPt12ttlQYWPRqs4uwBSBScip5CpqRv2A7V+5iPPDuYQIeZUTfHDm0jbbeiI6nGHHYOGcUsFhRmUFQ0DT9wUBxJ/eE9OwlvlIP/YsoHdyvJE+NwuIEtq3tnogPPlzUM5/NWJGlIaSELynfyq7BCf5kJh6qyWN4fjlhhppSUMhnZanYxbtMJTC81xpkhqJIwSA6Y7dz7V6VQRTUz6dUwfbId8x7PcWdfMloEl0eITdeA/P2i0glwYKsxvCyawsZdQfmOXjY1231ygw1DaRpkcR89T6+mm5yknRpRb7VbWXPVPCRv7zvHkhCu1bPPg9ImJiR/irmYBQ3URuffcvvYFTX2sq56L5ymSAIWTQe2f2ck/5dSCDR2aHIDqqbjiM4m3VQwWmn5OXE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:45:13.8976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bf70af-7cbc-4ed4-7ef3-08def888b342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9152
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

Hi Christian,

Thanks for pointing this out.

Taimuraz, this is not introduced by your patch. And the current code 
violates dma-buf protocol. It look we need to unconditionally return 
-EOPNOTSUPP for imported BO at the beginning of amdxdna_flush_bo(). 
Could you help to modify your patch 1 for this if it makes sense?


Thanks,

Lizhi

On 8/12/26 01:57, Christian König wrote:
> On 8/12/26 01:13, Taimuraz Kaitmazov wrote:
>> SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours them
>> only on the vmap path. An imported BO is tested for first and flushes its
>> whole scatterlist,
> Absolutely clear NAK to that from a DMA-buf maintainer side.
>
> Flushing on imported scatterlist of a DMA-buf is a really big NO-GO.
>
> If DMA-buf imports are used with the device then the device needs to be able to coherently access the underlying memory.
>
> In other words you *CAN'T* call drm_clflush_pages() on imported memory.
>
> Regards,
> Christian.
>
>> so a sync costs what the BO is worth rather than what
>> the caller asked to maintain: on npu4 an imported 64 MiB BO cost 1056 us
>> to sync at every size from 4 KiB up. Patch 5 reorders the arms so the
>> vmap path is tried first, and indexes the page-array fallback from the
>> requested offset.
>>
>> The four before it are the ground that has to be solid first. Patch 1
>> refuses an I/O memory mapping, which the driver currently stores as if it
>> were an ordinary kernel address. Patch 2 adds a probe that does not log,
>> so patch 5 does not make an exporter without a vmap op print on every
>> ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own range: a
>> zero length reaching drm_clflush_virt_range(), and an offset and size
>> added to the BO address without an overflow check, one level above a
>> function that checks the same arithmetic. All four stand on their own and
>> can be taken separately; only patch 5 depends on them.
>>
>> v1 did not reach dri-devel, so this is the first version visible there.
>> It is on lore via the other lists it was copied to:
>> https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitmazov.com/
>>
>> Changes in v2:
>>   - patch 2: take the device from the GEM object rather than abo->client.
>>     amdxdna_gem_obj_close() clears that pointer under abo->lock, which the
>>     pre-split code held across the log and the split did not.
>>   - new patch 3: return early from a zero-length flush.
>>   - new patch 4: check the sync range for overflow on a device BO.
>>   - patch 5: say why the persistent mapping adds no pin.
>>
>> The measurements in patch 5 were taken with the equivalent change in
>> AMD's out-of-tree xdna-driver, where this merged as #1541. That version
>> and this one differ only in a page-array fallback mainline has no field
>> for, reached when the mapping fails and the BO is neither imported nor
>> shmem backed, and in the name of the mapping helper. The flush and the
>> helper are otherwise identical. This version is compile-tested; it has
>> not been booted.
>>
>> Patch 1 is from inspection rather than a reproducer. The exporter I can
>> test against is amdgpu, and amdgpu is the case that cannot reach it: it
>> implements .pin, so a non peer to peer attachment like this driver's
>> forces the buffer to GTT before anything maps it. Reproducing it needs a
>> GPU whose exporter has no .pin, which I do not have paired with an NPU
>> here.
>>
>> Taimuraz Kaitmazov (5):
>>    accel/amdxdna: refuse an I/O memory mapping of an imported BO
>>    accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
>>    accel/amdxdna: return early from a zero-length flush
>>    accel/amdxdna: check the sync range for overflow on a device BO
>>    accel/amdxdna: flush only the requested range in amdxdna_flush_bo
>>
>>   drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++--------
>>   1 file changed, 49 insertions(+), 17 deletions(-)
>>
>> --
>> 2.55.0
>>
