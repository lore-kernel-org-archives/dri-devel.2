Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123C3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D61710F680;
	Fri, 11 Sep 2026 15:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qd8x7K34";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C444910F680
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVtqJijotWwHHrEKglaO8EmBWZeHIctP7rKYPdhwFRt2jWrWQS0nShoDvStl/Pm49QrJLlmvfzonDELGVfPYJF8BO76H1mZwNJxwyKYSsOFohKqhWy2edD82q+qqXRua65sti1bsZqt/g/9Vw4Ka53Hdk7eFZgZ8UauAlSoSjbVP/SboYphlK3A91GgldN2ooltS8aCLLcbV8dII4f0Q2LUGsG8hK3J06OIMNJ/5OrA8fyrBoiYHt0YBt21HUhX8eveE3huJttMck+3wlYCIEGq4MFyizprGtgjnu2UEa1FjezI8GVo2fUvW6WWjtHRF4OxCpAkHCln2JS405HekRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76Kbe2uwCRZIxvmPQOMmotuzg1MiQsIcr7sOK1ps3uU=;
 b=g1wU29FsYPznWwLzU7QWvtw0xCcOgPCNEmjsHIKwnYgV/c8NwcaWik9XOAm9dDOeY54ymK1amEbd2I/0f9bVJEqI3KBwQaoscHcDjfZ9+4m8wjOGaZwuTslaeWW4VnodqsZjdF02JiyLp6Trtn4cWuRQ+4Rs2dzPPUhSzDW8jV6O07jx8Oj+Ln6O2rLZDaxYJuG5ONrTxGThDCZm85qyO3XbxtseiLXvPLGMifZqqgOaXwoR+JS5dAM1nkhghZ9CNij2iWcJfbaoZgxr2ju8ipkPJzz/mTVkalHxf7vS/C+q3ehQu/iOTVU30xF3wshEZ2zm768dxpJTr9kQJc+CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Kbe2uwCRZIxvmPQOMmotuzg1MiQsIcr7sOK1ps3uU=;
 b=qd8x7K34VUSMNBdoKRpDezb1got19WdKdn5lJiRhLqlnSdkjgm+43qYmjASV30Ts/S3T8sjt1MaUluRJJLj9DOT8lLpFgJPZ5YnWcBdN/pCE5T67gq7590UQkdln1Zf4O3UPMD9D9dYrBF/5kOT8YnVuQySqM7aCBdyCS6mQDqQ=
Received: from CH0PR03CA0323.namprd03.prod.outlook.com (2603:10b6:610:118::6)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 15:25:11 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::a0) by CH0PR03CA0323.outlook.office365.com
 (2603:10b6:610:118::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:25:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:25:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:25:08 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 10:25:08 -0500
Message-ID: <981166c9-091c-d1e6-e008-46bc40ccee58@amd.com>
Date: Fri, 11 Sep 2026 08:25:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 2/2] accel/amdxdna: Fix potential deadlock in BO open
 and close callbacks
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260902180955.3999242-1-lizhi.hou@amd.com>
 <20260902180955.3999242-2-lizhi.hou@amd.com>
 <83104024-65dc-4289-afe5-6892844dc344@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <83104024-65dc-4289-afe5-6892844dc344@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c51f482-21c5-47d3-b54d-08df1018dee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lltz1/ixIMudUFpYm9Pb90wOfpFQ1r3oXUMResVNFWXl3zOw+Obgx6D3Mvo2Vc2erssTOq2zrr95TIq8Q4ozx6xQN/1VqZHax12vwGd16EsyD7TFsD6NhW1Di0Rb4wymr60gpLg5K83qNZdWuWe9p6zfq2CkcNc7002slYtmthtv3jdB9Ig6m4rMVhttdFOkhYA1RjK0mREyxRvLiRIB+N2UCQ8+9EQrLyDNKNN0a+QhK1p7cBMnlUenAuCr1wANnYwlMcuwchCLtRArh1LE1dAxzLlAz2X3ocLr0eSNv6AnUD3glzvC57ID2XUmxNK78rajygXqTuncmh+5dFT8ZIF1VyF+jgVVYMhk5xm6jGhoCJGjGU6OcZrI/RixlxZ6G8fu/nMBmomLSJ15N6Xp5jKbQ0gla3KSc2VgQ+0m3rTNHoaDV8oF5ehsRWtXlLsaOIXEHh+l+Xl6lrvTDlEgAacLPWIlYbTIXAOSpjN9+zdbzV4BpMELud9CAAd3wGxv/yDsDn8mdU0PAqaEquC5f3772YZwEGn/i+k7xoCWyKDWF/67TbuwPiKbsk5+5PSZuKIS2i7zaDpJG5fFpTtGgFtuU/bp3rquu9nlRgB3T4yYAusuRcQrpp6jYtRiVP8vdMYwLsxwsbf4wGqmIosVTk0QdVk+KSj4i4+O30tOZqQym+WHFtUkkJkWGvHoz97+Ee/Qxqr9vB/qRwk7875sRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6l3I4u3hepKNa++NmAKs6rSGPZfkb5IJqT+P0h3u7W8dvPc/6ItzTMhCHYMfhCBFXdhUnkLRXov6lK97vqq+OABrzXQgJroIrwDkvqRgaFs3zCswGhJbNrVQdBXKF2HDzHyE9SVqgy++wAs/g5mV5lidob4v+/BoWRWNaNxbKk4loxvzyReTZh1Em8yGmLhe7j2Ltdm0B/H3y+6IEHNEqjs53q2Jgwji6LkuHdBK2XnoPpeO1Ll9dka2y32JPp97gbELQnyqb3ca30L0p5XGzxSsx886wdLHFMAvOtpg1mZ18KvlBqiXav3l5PAB5bPb00nUFEo1iksppFwveNVCdoebkUpCtbWDDW1bPFGrTnPX05WvUhVyYX8Hx2Hkk3HPrwowAl4xapVWmpj4CU2v3mms1Vq6PjeNVEex5QN036benYF5bnOjQBN+lKGO4OI2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:25:11.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c51f482-21c5-47d3-b54d-08df1018dee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
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

On 9/2/26 11:51, Max Zhen wrote:
>
>
> On 9/2/2026 Wed 11:09, Lizhi Hou wrote:
>> In amdxdna_gem_obj_open(), abo->lock is held when calling
>> amdxdna_gem_add_bo_usage(), which then acquires client->mm_lock.
>>
>> However, the heap update path may acquire these locks in the reverse
>> order, creating a potential deadlock.
>>
>> Fix this by saving the client pointer locally before acquiring 
>> abo->lock,
>> and releasing abo->lock before calling amdxdna_gem_add_bo_usage().
>>
>> Apply the same change to amdxdna_gem_obj_close().
>>
>> Fixes: 1f513a3ec3a9 ("accel/amdxdna: Add per-process BO memory usage 
>> query support")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 34 +++++++++++++++++++----------
>>   1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 1353393194e2..0d165b66c1fc 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -641,10 +641,8 @@ amdxdna_gem_skip_bo_usage(struct amdxdna_gem_obj 
>> *abo)
>>   }
>>     static void
>> -amdxdna_gem_add_bo_usage(struct amdxdna_gem_obj *abo)
>> +amdxdna_gem_add_bo_usage(struct amdxdna_client *client, struct 
>> amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_client *client = abo->client;
>> -
>>       if (amdxdna_gem_skip_bo_usage(abo))
>>           return;
>>   @@ -656,10 +654,8 @@ amdxdna_gem_add_bo_usage(struct 
>> amdxdna_gem_obj *abo)
>>   }
>>     static void
>> -amdxdna_gem_del_bo_usage(struct amdxdna_gem_obj *abo)
>> +amdxdna_gem_del_bo_usage(struct amdxdna_client *client, struct 
>> amdxdna_gem_obj *abo)
>>   {
>> -    struct amdxdna_client *client = abo->client;
>> -
>>       if (amdxdna_gem_skip_bo_usage(abo))
>>           return;
>>   @@ -694,14 +690,20 @@ static int amdxdna_gem_obj_open(struct 
>> drm_gem_object *gobj, struct drm_file *fi
>>   {
>>       struct amdxdna_dev *xdna = to_xdna_dev(gobj->dev);
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> +    struct amdxdna_client *client;
>>       int ret;
>>   -    guard(mutex)(&abo->lock);
>> -    if (abo->open_ref > 0 && filp->driver_priv != abo->client)
>> +    mutex_lock(&abo->lock);
>> +    if (abo->open_ref > 0 && filp->driver_priv != abo->client) {
>> +        mutex_unlock(&abo->lock);
>>           return -EPERM;
>> +    }
>> +
>>       abo->open_ref++;
>> -    if (abo->open_ref > 1)
>> +    if (abo->open_ref > 1) {
>> +        mutex_unlock(&abo->lock);
>>           return 0;
>> +    }
>>         /* Attached to the client when first opened by it. */
>>       abo->client = filp->driver_priv;
>> @@ -712,26 +714,34 @@ static int amdxdna_gem_obj_open(struct 
>> drm_gem_object *gobj, struct drm_file *fi
>>           if (ret) {
>>               abo->open_ref--;
>>               abo->client = NULL;
>> +            mutex_unlock(&abo->lock);
>>               return ret;
>>           }
>>       }
>> +    client = abo->client;
>> +    mutex_unlock(&abo->lock);
>>   -    amdxdna_gem_add_bo_usage(abo);
>> +    amdxdna_gem_add_bo_usage(client, abo);
>>       return 0;
>>   }
>>     static void amdxdna_gem_obj_close(struct drm_gem_object *gobj, 
>> struct drm_file *filp)
>>   {
>>       struct amdxdna_gem_obj *abo = to_xdna_obj(gobj);
>> +    struct amdxdna_client *client = NULL;
>>   -    guard(mutex)(&abo->lock);
>> +    mutex_lock(&abo->lock);
>>       abo->open_ref--;
>>         if (abo->open_ref == 0) {
>> -        amdxdna_gem_del_bo_usage(abo);
>>           /* Detach from the client when last closed by it. */
>> +        client = abo->client;
>>           abo->client = NULL;
>>       }
>> +    mutex_unlock(&abo->lock);
>> +
>> +    if (client)
>> +        amdxdna_gem_del_bo_usage(client, abo);
>>   }
>>     static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, 
>> struct iosys_map *map)
>
