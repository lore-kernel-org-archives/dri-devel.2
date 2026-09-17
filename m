Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A40C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511E310F0E7;
	Thu, 17 Sep 2026 20:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7cDAV8u";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CF210F0E7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrVzy7PYsOV4LCJ/CRX8vXN5ZKI6pua4SBqRdpAk0iINmfsb3hCBjaPYMxIbcMP6euBDjCwQOAmUEWajwlWGemjFi9KYsL7NGJ2wO81g+aO1qHAwwR4JZjUEW2r9/wvyEen3ntTcEPZ/ip/Cgb07vceWKcP5eMq0/w3SCFSYhooU7DP5iOXkObO6AYUzyI7ygI3Qb4he8cY5v/Z0CyqnRyFrKNkYh9ogYDQGLGSpiACScAcMT5/0HMPBrhi1Vr7n4ANpaFcX62KE5I5cSuhMQ0GT8VK40OKQD6hzphW7mpZ21hqwVSti6A659yr7etoMzTiELiHslcg1SLNvMGKH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECO53mBbXFyppcCn0gv7gdwZwX2rteTF+eYKwuH8Uv4=;
 b=WFlGScp3FE6HiG1IKGupIOB21aO9IUfI+fmFJffzO3kootsXFgFoLyTE/RtEAg/EU99xC6OXrSzxh2WMgQajYNUebWZIbrbIUvlNKcIuL8777qcVVJwan4lqGaG9uaus5SL99mDmgWtOTmW9S/KCjv2ffUZx/qAFQoh3lg9AL2tDgaq1U8AYb2EGKjbue4q/vzVMhh7m1zpfjB80DKqG0sDoZAmIyej/2XsSB3b0JXmKSeQdFsPVavo7S8A6d2FtmtuRXt772MEaAelYVtalLbIwbG9WvgsqVoL0ZzXQdPHwlpTldkCuVatKD4MNaANeGP271CxfWOpPK3T7OQ44Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECO53mBbXFyppcCn0gv7gdwZwX2rteTF+eYKwuH8Uv4=;
 b=U7cDAV8u1LfCv361NFO2/KP3aPTF/6wPNFZig/2uKfVN9r0l/7Exfb6KuCp5RkvsIDegvgfr0nk+9NCZg0wH0CM34brxytE3fxB/GfEbYX5mSy0yL42vk2/LokAB73z879QjRPmkDeVE5EMkyHDFRbrY5Y8vPnRWplmrvRmI7o8=
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.12; Thu, 17 Sep 2026 20:25:14 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::74) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 20:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 20:25:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:25:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 15:25:12 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 15:25:11 -0500
Message-ID: <abff73e5-8d05-7164-338b-232b21264f6d@amd.com>
Date: Thu, 17 Sep 2026 13:25:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/5] accel/amdxdna: do not fail a sync for a BO with no
 debug context
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
 <20260819224458.257346-6-taimuraz@kaitmazov.com>
 <d0157864-cfe6-a4f3-bc62-3338c04e806b@amd.com>
In-Reply-To: <d0157864-cfe6-a4f3-bc62-3338c04e806b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: e90f8a35-1372-4df6-c02a-08df14f9c71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /Qs0J51RsykTY6XqfFMyix7g4s87xcRGVwBCMRZ61hyz5n9Af/q+GaU69KVvtdVyoiphj7pmkW33yJIlYhZjppYO3H1TXbwCpJjN09S5SGFW6D5B4DP+G/l9wenyW5op3fsPRv9JeZb0F/0yP8StqIl2DtVYh3K5o37a3l/b85fLSC9Vpzk9klOKDIrNE5rwWTBIGrJW98INRJmH6drLeRf/YyhUNbf4ajGe7pf1Xb5vUPWSV6XwwJGEJl4F7x1jFTg4IWKGD1SQy/yfr0YdgcifMyr6VZkYh7Lp/k+hH+C/VSDrGDXcrEG17b8YnMUcJb84POtFTeOnq4YRnHizz/Xxlg6Zk35fC70bITDZvWdqhy2Ws7/yafZ2DNLrgMOHnWSltZhlEC9IHNH9+PhW4/WLN4ZE70nwJlkxYR3az/hfqzZ4AG+CuaexXSDY+4j4ieBzcPRZlAJeOGSr/ACG5jVitBIO/7uTuToL4mhidz5mH8GtNGYf9NnvlqyVK/c8fCWE7rWHc3zrEtI4/vv4RSLQ+jdeM1mrtk0+u7m4j2N9S3WmD4X64SOK10IVTePifMuS9NXk/3XerxtZXBU7Y81eEV3dCtQjnC3ZuIQfDZBDfi2kIArCyHl00BZxceEgn3IKpAG9Uj6jA/efocnwcWyKZ7U+qVDjCSzkU9KYJ9Wom00lMI3o8J062Tzuzp0Zuk0/MIW53CFs0hn6waJaTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CoaRw9o9NCk/f7recRA4uAZhZvg2BSgN29h8bofU27fdoAhhAgS9dzJvhDH1OhzjgHM2G9zrBfbWFd8D33Spqb2mW/Hf7CGxFduwh3SSyHhlldg+YTs2VqtI88fJ5e9+VyE/zvaHWh8BQ7IbLwVmNzo+BOiUyhfVb2fpo33E4+tjbDnDkstGkK+W1MrhMdQC3IVJg/bKfV4NntaTtP/RagGXeuHGi+3blFkVLm6SUQe4HFv62w7sIjOH6OwbimlyzBmx5xPon1rfc93Q6akaov/uLn2oX4pm6Fw34hM4hG5yus9jeL32OQmphpHlzYB1M9q0aP4/rEjws4Vv6mPI30777HcrBwqvEvXUDPiQBwmxXqBKtS/HBEaXqrUQ5h12uWLPNQlpqK/pLErFXSa8t4OCJK+DeAujAyrTVliKi6I/xs5N8znqHp/FJ+U6TURx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:25:12.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90f8a35-1372-4df6-c02a-08df14f9c71b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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

On 9/17/26 09:11, Lizhi Hou wrote:
>
> On 8/19/26 15:44, Taimuraz Kaitmazov wrote:
>> amdxdna_drm_sync_bo_ioctl() calls amdxdna_hwctx_sync_debug_bo() for 
>> every
>> FROM_DEVICE sync, which answers -EINVAL when the BO's assigned_hwctx 
>> names
>> no context. Only a BO attached with ATTACH_DEBUG_BO is ever given 
>> one, so
>> an ordinary read-back sync reports failure after its flush has 
>> already run.
>>
>> Ask for the debug sync only when the BO has a context. An unattached BO
>> carries AMDXDNA_INVALID_CTX_HANDLE and hwctx ids are allocated above 
>> it, so
>> the test is exact, -EINVAL keeps meaning that the named context is gone,
>> and the handle is not resolved twice. The field is written under 
>> dev_lock
>> and read here without it; the context is still resolved under that 
>> lock, so
>> a racing attach only decides whether this sync sees the buffer.
>>
>> Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 4be5298d1062..2613c94dd842 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -1319,7 +1319,8 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device 
>> *dev,
>>       XDNA_DBG(xdna, "Sync bo %d offset 0x%llx, size 0x%llx\n",
>>            args->handle, args->offset, args->size);
>>   -    if (args->direction == SYNC_DIRECT_FROM_DEVICE)
>> +    if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE &&
>> +        args->direction == SYNC_DIRECT_FROM_DEVICE)
>>           ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>     put_obj:
