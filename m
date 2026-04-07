Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5652EFF5126
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 17:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B643689BE8;
	Tue,  7 Apr 2026 17:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8ux524l";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55C789BE8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 17:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOob7QzgQz6/ryL7aeNnFEQ+Y7P/Bpu+r+BimnfU3O01N7DhAUVjaqzPnUayhHOVo3U1LDSFZP1a+82MD4tfqwBkYWzLiV3TmixGAVujpSZF9+SY4wvFpRJWOXi2puBrBOhbYjc5Qrb4HXYlMerdSUrG5SBpyPKrqwpCc6y7duiFF1XR+piJnfMhcVwNgiBkmx1/l2IchH1nrohmf8gjbC8TTF7C3d6099q+E1oNaTxEv02GQl62UuMN+RqO9eRjOXeC8I8TC6bBgej7T9Y60YLXWxUVUoA+7ORT/E4+PxVBVozjwNGngOPOu9FuFKjFNSQZP/GJK9gripw+W78QWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqU6A5NHccpaA0zRJYpNhmP+CuzGjcKKLnXqJIt+dY8=;
 b=HHPfVV4mP/MWqHP337PXFBLqDH9WXBjC4ZhMY/wKo4utxeScMRiSZCJ+2BxKS4zkOd0fxm/p8tocwIlA2rMLYREbXcCOoBVwasVkhDBqVrzIxeGC4S1UzhJE7ZMoSBfjuVaGjnFuogMhstxTJzKxDha2y3Sae2u/lTVc1GGzte8iM5Gl/J+1zkv8i2GvMty/pgv0UEgT0xBRRLakeS+b5LkKVKSlprhm50nxCl1zsgpe13FRvc2iRMUzrPVmx7x3WDRspC40YfaeVqlxPve5TKnaOhd+aAOD5JLBM8exNp5Qul0/ysl2dhotOFqgmB3qs6vH31TzfDem6yGrhnMa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqU6A5NHccpaA0zRJYpNhmP+CuzGjcKKLnXqJIt+dY8=;
 b=o8ux524lGereqthBW73YMjxt7+gyXdTJNmwkzRXgK8QhsKXutS0ZquZqTVOt+24OTyNo1kFv7LsRHwR0GzwfqM8Fu30x4rQalR9K1/jwycL0IrWxCleIMPyfl+mT+P0xb/S2JQZAaZZUzDNRucbUfv2f5Nuq106x3186HBAd5PU=
Received: from SJ0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:a03:333::14)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:23:29 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::25) by SJ0PR03CA0099.outlook.office365.com
 (2603:10b6:a03:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 17:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 17:23:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 12:23:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 10:23:28 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 12:23:27 -0500
Message-ID: <a378c871-a944-2751-510c-84bd2de9561f@amd.com>
Date: Tue, 7 Apr 2026 10:23:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Handle DETACH_DEBUG_BO through
 config_debug_bo path
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260406211403.4011988-1-lizhi.hou@amd.com>
 <ea3bc9a5-e21f-4346-8af4-4ebc0f44a234@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ea3bc9a5-e21f-4346-8af4-4ebc0f44a234@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: e4962966-d749-4e7c-8122-08de94ca627b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2izw65C3zH//72lhDhf2Xmb7WqO+MxyekSlNEW59icWqW6Qsj/XZf40kIYZDGl4WVQf46LeEjc2jsxPfL0HrMEFacv9aDXqfShxhHltGuP4RbCbQLtalzGL3R2sqbwWJne/L2ViO+0XWjj7OoQcROMhMLc6nMSrr+ESWEU3BoHY1LZyUVohxfLH0GhzzC/qaf14wTF6G/5Xb+ltCL08JfwbzGrfMBzoN4oIFq0pRz+iS7HkPGI2NAf86iszYM5qPga6inyU0d7YksH8OuWREK1aIrWzj6meC/oDvpuOJYNwkS60JRUEPSZYSOVRzO88WVAQ1ViaVWz+9TeBYmBrfhvtTx8yXZIXv5tVusU/jrMu0BK9Hp0i3Jxq3yZDPVcbjWqcFscOY0JyNmM6zCj7u+SeJi5+ZvO8uvNNw0xWPgXKvcOr+TwPTBTCd7nAG17PGl45Ez2+hSjMw8UpY+JmbboMeLLfAUeaXjnl/WQDSIPqHFdgjj4++aT4cCO/FzZ1sfhSdcaLP3HTIY5JGf2qhUxcBRf8pGztKGOV1BMaaEU5lHqzi3bEVYclNdePORn5OG4C+xXtt+XkhKVadw4BljwJeTZ7xgNsZnk4mgg6FZC2bzqHu2nHvJvZZR7y147XOelS1xkRf6uxJEngxw+Wh5vHrJjtXHnCvnRRnZ8+qmag3trcZPAYZTMRmS/jGzDLCM7KL7YeqQ/d5ys1NK51Z8uxK1vxtVZKOtIDPyig6uaWwQMUQzVgLcYg5FDdQIhYJVGZUB+XGQGfl5feYmAkKRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CpgUdLmA377OcIqsaxxJknx547MWTgKVA3tXpMO4mDe1m71lZFf2VVZluFq0CMxqonJ3ZtqgkzzUDn5fjmCM4vI+eTvJrxYrkddjiBWBxZj7eJquhMsfHqZUC2QRWxXe9rUILagJTy4K0uOvvz+JA5BFhukX1I1ZSz1D2EteRRS++W/31P7A++yUFxWhG361L77o5N+c4E87f84zq52RaRpbcX5budU+S9aCGKK5ErqerNinW2hRtjF1gQQ96yH0X/blReioOiTjDTqgXPdpwptTxAPgHZZnH+BOH+2lQ0zZeeLrxFkcRwnPBWCrRqFfuNSEGho5yBSdqI4aCOsIJNbw12ptu/mrP9H6TqIOLStXZHC/cj/9MwM+y72Xeq7Y+oeaI30tKQt7nwH5urt8KhKwJKuizfhFb56i8YC9jkTZc7SVc+SGy+f7k84aeMoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:23:28.8423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4962966-d749-4e7c-8122-08de94ca627b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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


On 4/6/26 14:29, Mario Limonciello wrote:
>
>
> On 4/6/26 16:14, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Route DETACH_DEBUG_BO through aie2_config_debug_bo() the same way as
>> ATTACH_DEBUG_BO.
>>
>> The scheduler switch in aie2_sched_job_run() already handles
>> ATTACH_DEBUG_BO with aie2_config_debug_bo(), but DETACH_DEBUG_BO was
>> not included in that path. Add an explicit fallthrough so both attach
>> and detach operations use the same handler.
>>
>> This fixes debug BO detach handling by ensuring the detach command is
>> processed by the expected configuration path.
>>
>> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 8db32f8e2362..c464cf8024c3 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -360,6 +360,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>               ret = aie2_sync_bo(hwctx, job, 
>> aie2_sched_drvcmd_resp_handler);
>>               break;
>>           case ATTACH_DEBUG_BO:
>> +            fallthrough;
>> +        case DETACH_DEBUG_BO:
>
> TBH - I don't think you actually need the fallthrough command here 
> unless you plan to add new code in the ATTACH_DEBUG_BO case.
>
> IE you can do this:
>
> case ATTACH_DEBUG_BO:
> case DETACH_DEBUG_BO:
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Thanks. Applied to drm-misc-next.

Lizhi

>
>>               ret = aie2_config_debug_bo(hwctx, job, 
>> aie2_sched_drvcmd_resp_handler);
>>               break;
>>           default:
>
