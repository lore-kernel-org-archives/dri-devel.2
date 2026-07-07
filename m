Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02692C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42AE310EE58;
	Tue,  7 Jul 2026 17:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0p6O+pl5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4B310EE58
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbRVNKGH98g6Dp9FVZH7F21AeohMSCxpOsxVsMAI2lDNUGuk3QQX2z8OG05ogD+oBitG33ncEqbdQ1x8xWiuGU+VfsLWyskXbJwjJZBgiJLa+/5bSRdkIeEHE5P4fVZpc4GpNeyNttGPYxGpvFIklJ06INN4YI338yGrMRsKz77TMhDXFVzQJdpca5x/KlEfeCb783L+1pwJAX1sjinDITkM6A1ZauGb0QRcmAyy/+wiuoLi6GXVpZw06nfv/GOqpvNn73oKDyRKi93URs0ZNafZRakepdxRdNGBFvAmlheHlwlGWSLQwYuK1Wz9jKJqaKLU6OfUZxVqTRlJsnHvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef7a3NLdM8U2Mkxo35e2uHad8Ed8D+dUAQ1rTKLU8JA=;
 b=vB6ZMZCLNnaPicVDF8ezAkr02pdCA1Elp24woVQsNos0ZNbDnvc/b1S0v/j6ZIuu2H/OtsvoMseQRNQdKQGs2Mp8zoZen1B6sie9VOjSOmaTeVCXXx6dE0PyTSrz9PBeqeBYzn0ReSqCBcmEGqZ/iyHtTJMv7nUgA6Rx9uBU6vhTxWvZoE0ikbFUW48RxMSpAXSwtvlmJMWPdAKm2S5UaWBjhUvknAyPLvrJjB/++sV0k7fF7DtXqEJJpsO+rGdCFdblALFKb/C0jTT15selj6uOKjjuNFauno3szYBHhRrS8PoJQQ6TCHGQcZrLz+8F1RhK/MtLda6NsJv1KoTb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef7a3NLdM8U2Mkxo35e2uHad8Ed8D+dUAQ1rTKLU8JA=;
 b=0p6O+pl5cWj1ky6VlD7zwWt1enX8lTPorqyLTcg8dpmaGIGBu3JJJemAPUG38YbrbcfBXrhVLRI7thQw30Mb20wUP1ZEwrTxknfejJXDEFBlqIVKeiThUhe45w7KJjq6jxuYn8AmCPGjYeLMuakjgbk+kjLGI69SadDvBLTc3Hw=
Received: from PH8PR02CA0034.namprd02.prod.outlook.com (2603:10b6:510:2da::13)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 17:13:31 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::15) by PH8PR02CA0034.outlook.office365.com
 (2603:10b6:510:2da::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:13:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:13:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:13:21 -0500
Message-ID: <6724ba79-1db6-aaeb-f7cc-36bde605b5b6@amd.com>
Date: Tue, 7 Jul 2026 10:13:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix hardware context race in
 amdxdna_update_heap()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055818.479165-1-lizhi.hou@amd.com>
 <afc73e8a-5948-417b-92d7-b4ae492c9072@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <afc73e8a-5948-417b-92d7-b4ae492c9072@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aafc62-9745-4be6-5498-08dedc4b115d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: FPa2kaVSkFBJ+PDX3msnmimyWOdCweM4XIzcEvlQrQJtC8XsBDI8zRoea8dTjMO1AK+uVc/Aek+V8m6epIA21VIqm7g/mSQUozpPIkwZt7+dVXA2mP4xSu9VW0a3aN4bsNXkZ7VaeKsMV02g+hRzrXTeNUxSdsDKXw8BMb692J2CT1oUxfKpAZ6sapul8LEwxpY972LKkNnCU5eBU75z8g2qAD80M1EZrsDBd1rCX5PhsDamSDS4XsVkW1iPHHfsF4wnw8R3Z4kjnqgGQXGO2OXjcL6ClbK7GgCLTDVTjcJB7EgD5KYIEUeviJm26e7mkgfa50ZyI8KJnO8YayTA9as7ZAIx2x9e5BuF0sG0Rrl22yIx/GxSKD4iwQiXILPvnh2k2hJjQ/65Nrxnatw/59qelMWvcDrDd23Ky4d0PD5KcUwowK2S+KjsLT8zz03sUIGdF+yPUa6O6sJ8We5iTo0kTxDkhE6zWY8eO2glxYdD8mmz09M0tLJOj/Z3K/wUDDd1RBzRB8hDmNKvHTSypTzcInX/s7jMJT1MdxhG/10HgaYDH6mAbIO860i0ko3WQQWy2rNWOulEJNqFhxB1sr9z+X+sE1C7f2KCoACJUdwdFu+igetWnv8iCOF69KCjpRA9VM3vhIOABhkUaasMX4vgJcCnAf5WIJ4ZA6W54cQD7F2tjZgIszUYrRnAvXHMXHXRBxmSv/4ckOqSp9sJgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQdcNKjz6mBfex4/Zll2vgP+4w8Kz5Z9SGYeAMR+GFZ/Mw8wcliSV46TPxrAKgZ19aG5P5qsJfdNP3gks1i1ZA+I/StNyJmn55vOsyeM84BvbGQvyl8oO/iQYEv4sb6DmfoQ/wCwNbzDLhmr+nGl1dXXdYcfAuXE1/wHfFwkKjCk11DDvuz9/Fud/WjQQTJl0PfPJJOmL1Vp3koMABfew/U6HdXgXIKNaeOxS4XaN2mophALRiD1oPHcQbqCyR5gwEtu+QcRYyWOiUI6QbWwo98Lci8I3riqYNcZXnhjdCXbHZJKgfc9NpTxyuzDG7J1NG3n73v045vL+PNUJv8+AuIUOc8AsnZUNYk3Z8ewjMhM0TZG2R7OnPU+tez8N2NXCgnjQYGS6mbJy8q27QcrhHXUiFqqQQLXjGwoXTv3XNMMqQeRSkYY86dWYv35QHac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:13:30.4730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aafc62-9745-4be6-5498-08dedc4b115d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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

On 7/7/26 08:18, Max Zhen wrote:
>
>
> On 7/6/2026 Mon 22:58, Lizhi Hou wrote:
>> amdxdna_update_heap() iterates over hardware contexts while holding
>> xdna->dev_lock. During the iteration, amdxdna_pm_resume_get_locked() may
>> temporarily release and reacquire the lock, allowing hardware 
>> contexts to
>> be modified concurrently.
>>
>> Fix the race by calling amdxdna_pm_resume_get_locked() before
>> iterating over hardware contexts.
>>
>> Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap 
>> support")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    |  6 ------
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 24 +++++++++++++++---------
>>   2 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 30ccb8d5e23d..101f324ee178 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -1222,10 +1222,6 @@ int aie2_hwctx_heap_expand(struct 
>> amdxdna_hwctx *hwctx,
>>       u64 addr;
>>       int ret;
>>   -    ret = amdxdna_pm_resume_get_locked(xdna);
>> -    if (ret)
>> -        return ret;
>> -
>>       addr = amdxdna_obj_dma_addr(heap);
>>       ret = aie2_add_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>>                   addr, heap->mem.size);
>> @@ -1234,7 +1230,5 @@ int aie2_hwctx_heap_expand(struct amdxdna_hwctx 
>> *hwctx,
>>                hwctx->name, heap->mem.size, ret);
>>       }
>>   -    amdxdna_pm_suspend_put(xdna);
>> -
>>       return ret;
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 9ae19393e488..8f8df9d04ec5 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -472,9 +472,7 @@ static int amdxdna_hwctx_expand_heap(struct 
>> amdxdna_hwctx *hwctx)
>>               break;
>>           }
>>   -        mutex_unlock(&client->mm_lock);
>>           ret = xdna->dev_info->ops->hwctx_heap_expand(hwctx, heap);
>> -        mutex_lock(&client->mm_lock);
>>           if (ret) {
>>               amdxdna_gem_unpin(heap);
>>               drm_gem_object_put(to_gobj(heap));
>> @@ -493,18 +491,26 @@ int amdxdna_update_heap(struct amdxdna_client 
>> *client, struct amdxdna_hwctx *hwc
>>       unsigned long hwctx_id;
>>       int ret;
>>   -    guard(mutex)(&client->mm_lock);
>> +    ret = amdxdna_pm_resume_get_locked(client->xdna);
>> +    if (ret)
>> +        return ret;
>>   -    if (hwctx)
>> -        return amdxdna_hwctx_expand_heap(hwctx);
>> +    mutex_lock(&client->mm_lock);
>>   -    amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> +    if (hwctx) {
>>           ret = amdxdna_hwctx_expand_heap(hwctx);
>> -        if (ret)
>> -            return ret;
>> +    } else {
>> +        amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> +            ret = amdxdna_hwctx_expand_heap(hwctx);
>> +            if (ret)
>> +                break;
>> +        }
>>       }
>> +    mutex_unlock(&client->mm_lock);
>>   -    return 0;
>> +    amdxdna_pm_suspend_put(client->xdna);
>> +
>> +    return ret;
>>   }
>>     static void
>
