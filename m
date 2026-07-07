Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111EBC44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5660410E508;
	Tue,  7 Jul 2026 17:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZmXzeTp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2F010E508
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucAJXhB44iTj7nKHobqG1ppxSO5gBDGfGx3yw/omkfJ28drvXSEelInC+WUl5zM7PR40dSay7w86cCeZJHAd+KS9Rajc3tW91fk3dPpaqTG2rKZIGwxww8ee0hM6GfqN63gfv1UR07t31pN7CKNuLuH1ML5b3Ea94udg125Ej91DoQgmufxFXtEQJMBmlaZgGcudmHLoij6//PEQyCzW6NoVKySB2qX20+m4ynSCRW8Qi0WW0I3GhT1qtrbgeIr5bWj+LLQRv++YYE5RK9722V9zRs8pVaqz/gOuaxTJBy28bP1S92MNeBKQCdkt+n0j3VzSbd77cICtajYQNArc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvfqtHzOw6qho6Tp1+E8m7kupdAeg6gPCxbrs+oIObE=;
 b=ZaOQdYaHec/FS4nkqLry7Th4EJxJAjjwuHBQLh9U/ZEmKfpn/qgV2yAo3Jr1Zozkq4gQ47ZGFi/Ab8RD0jlhtxU40jyM6RERWblWCsMgwO5E0no/NyFu/cR+DEYOYdjE3HMFT8D/khGhLaPXr3sdjD2WzYgTHV0M7gMjbqMNiPVtr2TnNHqyFp+edTuT6UNTV4j1/0pJ9IuSodf1dyLzAy0vkjFOKPXLSSr6c9d7L29usFm+yrKo+ACVTrrddpmp5IdW5MBg8uSSIhJThswdexHGVwO51aq7WP3JcgHfxLOYOJUy/+eJOS/+v44X9a30hsH7p5UoT0PB+N8Xlk1CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvfqtHzOw6qho6Tp1+E8m7kupdAeg6gPCxbrs+oIObE=;
 b=wZmXzeTp8SEAygcxjZ69GFTkYVHhkimoyzMOVLbp7wxhyCGUyYYkvGXyGguIwibbZzig0U9s4nLy2MCEKYsoqbBOhVXTH8p+0v9v7E0V8ErxRMa7ckhF6uOZPUuIbNHq3xiNe/WL5SB+sND3TDbToemGaQxE25oZ9Mu4SmU0vBk=
Received: from BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::10)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 17:12:48 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::56) by BY1P220CA0044.outlook.office365.com
 (2603:10b6:a03:59e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 17:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:12:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 12:12:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:12:46 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 12:12:46 -0500
Message-ID: <806fd875-2de0-e806-0c33-9f072d136d5a@amd.com>
Date: Tue, 7 Jul 2026 10:12:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: fix open_ref leak and stale client
 pointer on dma map failure
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707055658.479049-1-lizhi.hou@amd.com>
 <79627c5e-7ae4-40a6-8181-a611da01256d@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <79627c5e-7ae4-40a6-8181-a611da01256d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3aef20-daa9-47d7-297f-08dedc4af7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: DlYpu2gr2ZO4M1wRf+I9HvL/Ll3CYYh+8H8XlctqGNh/f2K1atpxACeQz7IonXjKmA2ilAxdlC0DH8iJyj9F9r/uu+Xh8TZtsgBvWwB2XdSxhdusfpzsuWPTkiMBTz/ElUE6gYxaObS9P2feIap2+m8sVaGRrJugVJ2Bl8YnBel6ZWxiYDX1TMhaq6I81goPFENMVTf0jEulR6HKRLaXRRnsuM+TYfK9AiW0DoLgcwJaFG+lyzjk9TNQA7mnsyKCOqE/nfi8vrebDMTUDK0anIYI1EFXr7ClVCyxQpK6aYCbspWTv3ULDtt2Klad7ujKw+GppBX+voSyM9qwNavW/dlkotAV9O80kwIB8+vh9cVTVjJ4hU/NFnA4eqbnGyU20CFgPjaUmlx/LtqVO39yZMZnS/NB5C3TZZtCpbrH46fvK9KdFPYkodoC81Rb1AYhdN2d6oJftZrYIUBbSPFwu55tKL3PMNcp1jGMJGZfI0lzeGWYOlJAuKrcnarm3T9TVNsSNbaUvhRzc9aW8bx3u9RCjUX8H3lHZRr8YoVQ/Fe+D/kcr1LN5h6gVNPgN54IczFRO05U2XsY2qYXN3lB2vwfixzZf9NPzp/9Z9NlF9YKuPt98F81fAVW2rAcC9XUGzfSUOpjCB1T3+cPOC/dYgsx4bg0iD5to8spjjik5VmvetpeKFzjdazl95Iw0bKmMpzCv9Blsf+CxckOeNHuQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: axQQi7+r9gJra7GyKxrfhP2tCv1sUfNsDoHsGZa4HojTGhz+EWpN57uYHp0Bcr8QP4a/vsr8V+pnCO1UpBoNUxHFkERj/LP/6xVYoibI2wy1WB8pOUjV9in3oZzVU0Eal0IPtnRvtV2fuHAUug8V2NdTMXcWdeRTc91PVmjOKfpRlobv5MYtF97YJhlgVLr7ZffIv6pPTBN37ULULVzmZDi6QBfAXt8a9MwaX+oiavHs8CXj2wj9uoG39JwdZd6jXavqYfYlZ8Xoj6An0vjGAE836MOg/9jINDRIh1bBj+/80D5p3oyfd7iH81Q7m45V1QWpkR/qhecaX8j/KippVDksFuwyFh+nsrXBogzng2uuBvc7qpY60vVOnVLHRuxY5hBkB8QNuRMgEBp9gDHKKiTbgPz8JXSvv+kftfiQKagMwuV/VLSyvzeZskSid4SM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:12:47.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3aef20-daa9-47d7-297f-08dedc4af7b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

On 7/7/26 08:09, Max Zhen wrote:
>
>
> On 7/6/2026 Mon 22:56, Lizhi Hou wrote:
>> amdxdna_gem_obj_open() increments open_ref before attempting to set up
>> the DMA address mapping.  When amdxdna_dma_map_bo() fails, the function
>> returned immediately without rolling back either change made on the 
>> first
>> open (open_ref == 1 path).
>>
>> Fix it by decrementing open_ref and clearing abo->client on the error 
>> path.
>>
>> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via 
>> module parameter")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index a4bd9e86bc8d..3f03d2db1603 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -663,8 +663,11 @@ static int amdxdna_gem_obj_open(struct 
>> drm_gem_object *gobj, struct drm_file *fi
>>       /* No need to set up dma addr mapping in PASID mode. */
>>       if (!amdxdna_pasid_on(abo->client)) {
>>           ret = amdxdna_dma_map_bo(xdna, abo);
>> -        if (ret)
>> +        if (ret) {
>> +            abo->open_ref--;
>> +            abo->client = NULL;
>>               return ret;
>> +        }
>>       }
>>         amdxdna_gem_add_bo_usage(abo);
>
