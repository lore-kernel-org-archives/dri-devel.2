Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7034C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294A010F0E4;
	Thu, 17 Sep 2026 20:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g9zEITWT";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B36310F0E4
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCekCYza/zZprfr6aoAkmwVM0+d9MqNozk7eMHpP/Dm3CsYrBLVzooCNneT6lnV1LL4qGvS+yu2gprA7A3jSOfXdtxMIepZ6daW4D21SM0J+YGnSuJEzLgS6huXZBp/JrG43EOi/MQcXRElEg5a3F5K4F0lZKXQG6Xq/cmII5ewYDC59U5fUoWE7IIx3q9hfWc5krIGdXD1uHdny+fISo6mTQACyw/QrBFRvYh0dKOoqQKP6fvtABAj16SaT7/3PVM+WuysCkh8Hdp38Y3zeirvRT0SuyO2ujSKupUiXpxJIxUUErrqTBjau21nAhQVohU8Dp0l6dqGXdoilTi3NMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkiXsryzjTaGoA/XNEcmWmz7NasOa/00VDeXEF3PPgM=;
 b=pA3lBz9q+Ak1M0B181/Xb3WtdCHoXjS8H5CqUwST4P/+wpqz+gabgXtVBdQT2Ue7RNuCP5ESLRg9UMV8UnpgvBfVafmi1lya+1x+7DF25tGHZd1dzI0bF8eSQ20SP+wEiVa2BNe/d/UxKNouTmh+cobbdLXwQ6SP/s7NxLysb2nuL9GWbxTOzRoc6ZkX9vMxLaG0pAcp7I2EOFC4dpCOQnrPUHsdFuZgp+uFTderDaIr4sAwotJuJ2P8b5aoEvtsj5uu8vFe5ZD/RaJDzgMpnBeezdNzpZN5BSw2VU6lcaiJEK3InLI0fqkbQ90TOf4nBYk3eslcA0TqlUb/Ffn06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkiXsryzjTaGoA/XNEcmWmz7NasOa/00VDeXEF3PPgM=;
 b=g9zEITWTzAWU6FWVvq0KlEbEgmrNUWHNDFO2tBDKd6bHSqZpISFPBYVsBWGtS+HZT7nY6SEa7q694RuK6B2tSfkP12sbBeV0z3CqerSx000fqMxgfheAJeJyQagu4yZ1eZq1d5vTIcF5ZFazE1Oq/SlWWuPXvVIRXoR1L8i76V8=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 20:24:52 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::9) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 20:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 20:24:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:24:51 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 15:24:50 -0500
Message-ID: <280ce606-90f4-ed96-449a-5fe2fa08de68@amd.com>
Date: Thu, 17 Sep 2026 13:24:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 3/5] accel/amdxdna: do not warn when a sync request is
 rejected
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, 
 Oded Gabbay <ogabbay@kernel.org>
CC: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Alex Deucher <alexdeucher@gmail.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>
References: <20260819224458.257346-1-taimuraz@kaitmazov.com>
 <20260819224458.257346-4-taimuraz@kaitmazov.com>
 <99a26a5a-a42a-f0b1-eaca-041629a7c103@amd.com>
In-Reply-To: <99a26a5a-a42a-f0b1-eaca-041629a7c103@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b282596-f5e4-4ff9-a4d3-08df14f9ba60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DSgzm/28/ZdP7zDjB2A8cvuZEsIXZrG00kWNWqja61bFnRGf4OedgFCQH90ZFdYmR9RyGMtFWKgZiGNU/oGxppDjR+Sio976zHZeCeqTOxFMjEY5mq3BmVa63KeOQztyKAZ/KJFw4HKW/j7OpMU29r6mTH1TN9I2BPx9WtLmoFU4QIAOXp62GEINo8PHc1Jrjbv7uZf2azB5FaYayvjlKl5gIvpdldIfMWzJdFul/DHwKagMqXUEmnr6I9hKxXXQOW0SI04TdMeCF/swK/dAbQdYLWJCQq0M/qaus/ZAHcj519QyRguqR6tIfQimRVW7gp6TxeCqyEBEjF78MfEfdmh2dfVTDVhIIvX1AlOqhd9qh2uRhXCakBkifmblJVeTDDxEi/pPExais4+4olbvwIxKlXolzus/DovYgrQwkBy6j52Oy8SEf9pAyb0lphaXOu0jieYajC4NMzeL8D4QNWYi+bVHTQftj/Xys8AVVQUJ2kp02RB+ycQNR3Mrfi7zJaGbu8nSwTIuCc6adf/PUD8EB+IBtOt96FEPddmLjOSAjsl3BcFIu8BvE+Z56FDUkvdB0a2y6A1jk17HDULj9CafUH/LzEllvT1IyJD9ElSHVYwO3/rlgVFSzQcmR8Fi2VLvSpQ6ehUQff2PQP9cqz+HBb2xZsZCWBP8sWJE8iyJ7/WysijwLLLcMY3K2y5NWUgP3I9KvF5eFXGZIj7zew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vKJpyHuZ+kuhIpMCS6kkmcP1QPiQfdNitizH1pw9hzWeyVHnfNviT5o64wGpQsgskwP8+ZSiQq96zjnlPJhXnTlJ8UELoqSLujs0M/ES+vnVdlYaQhVwxW26N+ctDgMrrwCHMuY/xScfdrXf02TCN07lDWVN9OboS0/puoLQujRAyHIVFyxJxgnvvvCr8WsTJ5/7giSQ5rK4/vzf6lp8qJTQZSCILmUn6PT2eCYcejDrXxWuizNIDp8/3NI2BhBVzNwEu958XTd9guOK4V4H2BmSuAQayvbmEB54ymELhVcnT3tGgSfad73hU6yvHF0tNl86on42bOTE+b8SrK754wRwk39Nj38a+muWVv11m7FoLAve8/11De+1SUaB/6eVDgndmX3QycHHtGop4LwiKm++VJteRnVcxNouIheUB43JGA2nImxMBwNvdsqgHZZe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:24:51.5737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b282596-f5e4-4ff9-a4d3-08df14f9ba60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

On 9/17/26 08:55, Lizhi Hou wrote:
>
> On 8/19/26 15:44, Taimuraz Kaitmazov wrote:
>> amdxdna_drm_sync_bo_ioctl() answers a failed amdxdna_flush_bo() with
>> drm_WARN(). Both of that function's error returns are decided by the
>> ioctl's arguments, so SYNC_BO with an offset past the end of the BO
>> splats and taints the kernel from an unprivileged caller.
>>
>> Log it at debug level, since the same caller can repeat it.
>>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 77a9493cd7ba..0e0f844526ca 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -1310,7 +1310,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device 
>> *dev,
>>           amdxdna_gem_unpin(abo);
>>             if (ret) {
>> -            drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
>> +            XDNA_DBG(xdna, "Flush BO %d failed, ret %d", 
>> args->handle, ret);
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>               goto put_obj;
>>           }
>>       }
