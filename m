Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A57FC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A686410E513;
	Tue,  7 Jul 2026 17:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/PlfDVY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3C510E513
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vym9v44LwfRSU86eVj0Qki/0AyjgPZAvTsyHtiTnTU3csnL9JfUln3b0/0X23QdTlaNMOo5ghVIcXHzEodVELluk1ta3di4Lruf2S5kSGT3OE69sEQevxgR6Mpe7DLKVVVSeFnY8jDrOXvRCBQLzv1oqUJcnZ04zv4vxskcqlfowJukcSTSjZZTRQoRzPyd8sM/F01JZ38DMBHXrwCMrcoYmyOqJ9b8DN2Rv1DOGJfwua51otvFHaBnp3zZfJPwBDDH5PPALnmGx6M2xQgADoEl8WhDja5+sHmS6eHcjwTkJdJRcU80xwVXNPDEVHXOgq8asQhBaqGWHr7U1fgsSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOd9k/YoMpK0oShX+azgsYZPt4VGsM3ZWMfw4eQA+yo=;
 b=ZLtbxH++kj9JT+ZTF6U8FaOSXGOQhmlC7yZ9Mo/cA9K4KQVTZ0z/+g/YXJQqfS4U6n+60WxZZFAmeQC7YdegHh/3yFx9hKY/C64jzQQaxZSSRL16Sa+W0b6Re3qhXFOPubHPGe04sEmkhmSed/IizxIHe4vSePwBlrx65RzmqRZWbLumI2aonAcYe3rN/L3OMei5jpoDhkqefi+7hnEiieF9v5Par76voOk4vGVIpNAkltA9epGuzsSkW6ffeXZ9feIDflwbxQH7B4oMvOhq4EZd9+2sWcw6DNTdpMLZ5S67DmRb211AceMy0k0GuRPtoQO7T30mJGfD3yGi9KluVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOd9k/YoMpK0oShX+azgsYZPt4VGsM3ZWMfw4eQA+yo=;
 b=B/PlfDVY0j0gPAmBvYzVLBNRLdvJ8vC0jGbcy5Hi4XtLOLeWmdyi8BmmbsHxEE6w75zwTSj5DbVHOpk5AxHdylY68iblJFJGo3Us2GDYq1hrT3OWrZFFxQdogZGQc5qcJXq4+zFGLzLECe0xonIIVInR+pkxS91VOBcMFNkM3Sw=
Received: from PH8PR07CA0038.namprd07.prod.outlook.com (2603:10b6:510:2cf::18)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 17:13:07 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::62) by PH8PR07CA0038.outlook.office365.com
 (2603:10b6:510:2cf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:13:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:13:03 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:13:03 -0500
Message-ID: <af44ba99-b220-cbba-a147-d9618620ae49@amd.com>
Date: Tue, 7 Jul 2026 10:13:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix deadlock on debug BO command timeout
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055732.479103-1-lizhi.hou@amd.com>
 <5cbef92d-485d-49a9-ba51-001c959e0b28@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <5cbef92d-485d-49a9-ba51-001c959e0b28@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 6825ecf2-6160-45e5-2866-08dedc4b02d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|5023799004|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: F9xt7Sy3hwhRS5jPU5BCWuZlMtc+e0zwIdglzkZ/ND840X54ckNjU/u08hA4rL5eKnFcjmaomt0imcj0w4w2w5gXd6OmKsDLKZxBohveJlpcQSC+dJlqhpniEE2iKApplqBcLtHAxqlczc33w+hnKR0yeCuShG+Gfl3N60ZSoyJjUSieBb1ynjmc6Ys+85kJM8u2gToO1LiqydzMs9Sx1AIoMpYrN7DP+4lDHvURK/acflVMMqxVaSnN3STa4yqk8k2NvhsU/iUvYZF8pMrqJ0rhTLoG7R3qGW2LiGr+qQE7xzN6W7HgwMq/KnruZd6rCdJ4xqbXNhCzgsFTkyznoXeaeBwzZvaQTa0H9kKiI6JSd+xnh+JHekOHGMaJtAiCnPflJKiTi/gpfs0zJuRGweumUAEqZQUGTuBgs6bRudh2/76hHAAW9jPLxKHJlXb2n3/9qICx4x3E51Ep+lHGvcwldK+cR0qnQFIRuYlVGaM/y+ZgjTyd1khL+34FjD+ricgyiwS+4hboBxfroDGkvOa1GpPWYfT8rz2U9z2+bIIFslGlz8bZXyVfg9E4xdP0RRXkmHb35aiyBAHJ4TExaZKBsRVpzldpTkY96dM4nHdzISMOjrMTZPdB3i15mxm1dM0KIYKLAinWRvFxxlRoxayHbxsKmjli1sAtli0pJHJQeMcbu4+z7RZ4KOVLG5cND7iLtkP/05NhrZV76pkZqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(5023799004)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Ueyq+2djKV/AghsJ0rVHLB+t4m6j2dsc02XCmW8tJ3WyPm2VNUQ+UTO/Jwh0i4GoiO5jFOtheSxf1XppwsDt7Jo8Bnj1FCFv7IS4IDdVumyFnPDuIW/rJQEiPZSy2b2D193WwKeQCpQMz+4X5CsdplJrVgxmiVisTuI6d3HSWb3Q1F+9+xZNIqSrDRLp0zbxzNxJca+Lt43cc7QJTafocekhhISEx43/UAwlVfV2qbmfqqRJ2uVBFD0wKfNkYvSRulL2C02IV7dG2ghcfXdEMFFimIxbJl88qrvmlVTbupGFv7U3b+Ref6MPvbHfo2KQ1oczSgHDmyn9UpUh0/zu9eJwiAmKevEysvdBVKZ5vKcghelum3eZ6S7zpP8NYvsBbtY3b7oobNHpUU1ZoQgDUf5vvhp7Zq7U/t+iDNGXnyo9YOe5Lxci1ydCc8OffS7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:13:06.1078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6825ecf2-6160-45e5-2866-08dedc4b02d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

On 7/7/26 08:12, Max Zhen wrote:
>
>
> On 7/6/2026 Mon 22:57, Lizhi Hou wrote:
>> Both amdxdna_hwctx_sync_debug_bo() and amdxdna_drm_config_hwctx_ioctl()
>> hold xdna->dev_lock while invoking backend operations. If the hardware
>> hangs, aie2_cmd_wait() blocks waiting for a firmware response. When the
>> DRM scheduler timeout expires, aie2_sched_job_timedout() is invoked to
>> reset the hardware. However, the timeout handler also attempts to 
>> acquire
>> dev_lock, resulting in a deadlock.
>>
>> Avoid this by releasing dev_lock before waiting for the firmware
>> response and reacquiring it after the wait completes. This allows the
>> timeout handler to proceed with device recovery when a debug BO command
>> times out.
>>
>> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    | 5 ++++-
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 6 ++++++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 7bf635634e64..30ccb8d5e23d 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -900,13 +900,16 @@ static int aie2_hwctx_cu_config(struct 
>> amdxdna_hwctx *hwctx, void *buf, u32 size
>>   static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>>   {
>>       struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
>> +    struct amdxdna_dev *xdna = hwctx->client->xdna;
>>         if (!out_fence) {
>> -        XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
>> +        XDNA_ERR(xdna, "Failed to get fence");
>>           return;
>>       }
>>   +    mutex_unlock(&xdna->dev_lock);
>>       dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
>> +    mutex_lock(&xdna->dev_lock);
>>       dma_fence_put(out_fence);
>>   }
>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 67a2abcf173e..9ae19393e488 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -310,6 +310,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct d
>>       if (!drm_dev_enter(dev, &idx))
>>           return -ENODEV;
>>   +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>>       hwctx = xa_erase(&client->hwctx_xa, args->handle);
>>       if (!hwctx) {
>> @@ -328,6 +329,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct d
>>       XDNA_DBG(xdna, "PID %d destroyed HW context %d", client->pid, 
>> args->handle);
>>   out:
>>       mutex_unlock(&xdna->dev_lock);
>> +    mutex_unlock(&xdna->client_lock);
>>       drm_dev_exit(idx);
>>       return ret;
>>   }
>> @@ -388,6 +390,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct dr
>>           goto free_buf;
>>       }
>>   +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>>       hwctx = xa_load(&client->hwctx_xa, args->handle);
>>       if (!hwctx) {
>> @@ -400,6 +403,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct 
>> drm_device *dev, void *data, struct dr
>>     unlock:
>>       mutex_unlock(&xdna->dev_lock);
>> +    mutex_unlock(&xdna->client_lock);
>>       amdxdna_pm_suspend_put(xdna);
>>   free_buf:
>>       kfree(buf);
>> @@ -428,6 +432,7 @@ int amdxdna_hwctx_sync_debug_bo(struct 
>> amdxdna_client *client, u32 debug_bo_hdl)
>>       }
>>         abo = to_xdna_obj(gobj);
>> +    mutex_lock(&xdna->client_lock);
>>       mutex_lock(&xdna->dev_lock);
>>       hwctx = xa_load(&client->hwctx_xa, abo->assigned_hwctx);
>>       if (!hwctx) {
>> @@ -439,6 +444,7 @@ int amdxdna_hwctx_sync_debug_bo(struct 
>> amdxdna_client *client, u32 debug_bo_hdl)
>>     unlock:
>>       mutex_unlock(&xdna->dev_lock);
>> +    mutex_unlock(&xdna->client_lock);
>>       amdxdna_pm_suspend_put(xdna);
>>   put_obj:
>>       drm_gem_object_put(gobj);
>
