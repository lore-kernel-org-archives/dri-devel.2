Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A626FCD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5CD10F32A;
	Tue,  2 Jun 2026 15:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ujO8vf85";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B45710F311
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uANJ9vqpkefo8k5gbUq52zyJcVgtsU6vLch27FQllJlcchQ2KUXn0vpOC1SWtmgj8joYyQhw7YRmii3yjviHH1ImRBare013WrR/KY5xw7ABWL2Zop+VncXFulup7MnFLaZcnPbjs22mAh/F19UpYi3wLkyw3M8bzI2BRu5Zli1evCqkZY/ipALrSDZkJX8p9hxGf1koqGE0OdzydHfWNhf9K4vqd/ViJgyC+wSZE2bGNiNDnWQxE0IB7lWS34KL8PJqZ6mJCaqp88ReMWxfRF+k9NcwBSCsDfEbsxTQqgEp8kWVaaxpPJYrtvBoMbpHojmjmIuOc6SCfsUSlhqDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iANzVSyFUoog30JldP7OCNeJvUiVqypIZVOoaFPWTxc=;
 b=B/sBFZ1ga0H3HEkLsmzduFhWY2bflFe+cZaZ+jpkNA+wa6Yy6MtXb32sWYnC5NNMZ0rFIqYNAAFTX0uS07vDIvPVfGdvPrDoYWewm6Wb5prOOxkmEtBB6ArqisPZ9qcmEtDMo04LC1Ra94qSvOPBExUXIw55sOjnlKLvcsK4Mv/WTGHtcRxuGC2BjUpMWC7RjecCfuEKZnrOREzwS0sfsvHala+x7tvpWjepdJOMMWIPrqT1JwPuOkQFAa/QEPzLtP2i+6+fMrvrKGjOr3PGX10IMgc940DjUJs3z6741I3t2iYNmES7u30yPkRau+S971MsvrznPr0iq9Psy1RBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iANzVSyFUoog30JldP7OCNeJvUiVqypIZVOoaFPWTxc=;
 b=ujO8vf85dY+kgi4n9QkcvPzMJRYRbhfVZydZgQxLm5mqbzRDPh1yBSG8K8NGBkqzuk5X69vtSbGlD2r9/Q3dn4vuIpYd1IUyUjatWvGubDJQ8PuJyUFOLS5Dwjen1duDq+r0u2aHFoFN1RVFs9c69tIXgbo1jDKSgUp2eWcqzAs=
Received: from BL0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:91::27)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 2 Jun 2026
 15:40:40 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::2d) by BL0PR05CA0017.outlook.office365.com
 (2603:10b6:208:91::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 15:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 2 Jun 2026 15:40:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 10:40:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 10:40:39 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 2 Jun 2026 10:40:38 -0500
Message-ID: <de555b4a-61fa-2905-0b8b-8cc4acde73d1@amd.com>
Date: Tue, 2 Jun 2026 08:40:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Preserve user address when PASID is
 disabled
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260602040624.2206774-1-lizhi.hou@amd.com>
 <eec37a38-39b3-4a83-9024-a0e6d916ce54@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <eec37a38-39b3-4a83-9024-a0e6d916ce54@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cd002f-d1a5-4cfa-d12f-08dec0bd4c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0kx9Fsgco/xBnybsRjPoQuT4wBZunVtDUOJsueBBlx+gNMFOWY3+pTxP5bbJcI5G4Kyaf0cMfOIByea/jgIYgTcQ/wgwLcJJy3//nCLWWvJpEBGFa4EF+/IDnCSHlpzlV5hRSxiQbd4HxmGU476ANpCtuBToZhEcErhzLz14/yO7U2ZlZCLl/SSyiJ8VROIXkqEiOIgVBSYll1J5bWQAOo+T+s8LAMqmb264+pCrVR0BcMyr92yJE9Mb2F3RDTiOhOxAXT+Vi2ihpBV7UMTiQQgx+lKr9N7xB0jLgHsSwEez4a+yNa0CdPO6rG1iNRD0vEzoaWq8Wx9/YFz5bMoh9LZNxDaJ9LtzHfR6TEQMa50BV7trF2KxJKFvWkZrBcsY8EbF6WNjoReZoUjFuumpvpKHccHRLYHE8ypGdooJaWteEWcapcA3vu/U9Y2B89w+FqCpG5D7Ncorx1gdNAWNVAQwJ+aSLRu7fiP2jN0bf8usfDQQVzSrRYRTJUnP5jb3rUSkgiWP0tREjLHBJLdHgzh3BGvMX9On3pRn9owfDEpVe9pHm7bDGnT+5u0uaZO4lpg3RL2vZWloY8xGE0jAVzJPN23kXUGf0Rl9+v/zK+zIJOgERhh6lz8aP2R3kUVmt9pDf5VUjoVG02CX2h/+hkHZI5CLw/LnaJ05rGGEUMBxVJd+kTkQz47guhbmqtM8fsRkND6rZbLQEGv3UapiV04Liy+HR+bBnRqlqSWP7/0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yJlDoTN8QlaG7yUWqUjoMXu33tNjMfwZOIb+cxqSwBxidpChsNHEvnQ63mh30ZkX1jeX5WAHtHsaMprrwvaA63TXEjKGJGCrWwvaH3XIsAIR6/zE2qxi644G5vSb58Wc8ujnUgxyLr1dV2P2reqvdo3IlEciELWZXqPKiS/2Lrp3Lci7oNTIU1LSMmjZ6TCeODp5aPejWXrKJ9/hhC+6ZG2I48jq8gPvCW+XIKPMjM62ibezCPNyjE1F84JyfZFs19jO7/3Faz3T70JG+DkjKLG8mVZNGj5W3JtYGYFylWhYARE2gVePCgCD1YOGjq+UBssXjlE07SKtGvCpSNT2QfV1ws1JqDHEcYp52WxeXgJrmgqT2X0IHwxXGsdB4SpODTLj9M1x+I0KPrJ7VMhCZ1bvW2/ttpQUna9gSZIHA2u1qh27Cu5XYhXA4BKiz/Yu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 15:40:39.9022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cd002f-d1a5-4cfa-d12f-08dec0bd4c95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811
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

Applied to drm-misc-next-fixes

On 6/2/26 07:15, Mario Limonciello wrote:
>
>
> On 6/1/26 23:06, Lizhi Hou wrote:
>> When PASID is not used, the buffer user address is set to
>> AMDXDNA_INVALID_ADDR. As a result, heap buffer user address validation
>> fails even though the original userspace address is available.
>>
>> Preserve the userspace address regardless of PASID usage so heap buffer
>> address validation works correctly.
>>
>> Fixes: dbc8fd7a03cb ("accel/amdxdna: Add expandable device heap 
>> support")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 77e5fad08ae5..33cf5af98ceb 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -349,8 +349,11 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>       u32 nr_pages;
>>       int ret;
>>   -    if (!amdxdna_pasid_on(abo->client))
>> +    if (!amdxdna_pasid_on(abo->client)) {
>> +        /* Need to set uva for heap uva validation */
>> +        abo->mem.uva = addr;
>>           return 0;
>> +    }
>>         mapp = kzalloc_obj(*mapp);
>>       if (!mapp)
>
