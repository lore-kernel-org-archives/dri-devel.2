Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16FACD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF20C11A969;
	Fri,  5 Jun 2026 16:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeKSml0d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D90811A969
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmsrrHu/kRFvZFKkgu9NCJRHnkjRn3FnfQsa0YwktM72CxO6ct6iZ6fNQACivquGCaXtUPdERt7TBysMCAvWorpcyccFvFyZfbiUyJzdlpz5umiNwJq0+xl1G3+UxcNaFSAYA/k8Zl4ejkmc4JmhfEMT38KTM5kJiLjXdjX09liKHgjprZ3+0T/cR8xx6fXoRnKtlGZtPQ9iunGTlPUt7KbAW3/5PVYVZmw9cqXbXKc6LFAUZFk56qNd8wRU6rgk8bZCqsZy1SKU4sop2M3c1+23tal4GwD2K1TzjPlgpeL7hFvmlQaHtYDDE6opIJP8wlvyadIsXATtzNPZMw/8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KszylNXkQrcNiLBpxgatqB6updQNVGNN/RHmaAuowcQ=;
 b=PhtrKU0g5mBiyegjMF1HE9xcy0fowyD8tdL1BUWaLS6q0cRdWmj8Ln5yctoxY2PnWzlT3Un4WqN4pZFmfg8epSGywkfq+ishJp0OQXlUd4/+htjJlCUJP6S82VQn5CBkf6K/GPmwMgpdJShveOzWnl0SNQBjFQLS9bb9CuyDqqbvXwUTIuhcaRnD4tC69/N0tZEN4/IWihANisazaG0q5tGr766G8WiwQgLrwoUX6M5scNuSEnmsTdoCZoweWpRTGTLMIi21wVidfN668W09l7RTru7VldU0me+rPHMpREmHSXFjH0T7XtNryHngiOdZ44m1ONTL83P0D/YUIuxIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KszylNXkQrcNiLBpxgatqB6updQNVGNN/RHmaAuowcQ=;
 b=MeKSml0dfNTaYmrJInjhwdN0rq4ulU2/hZb8Nr+65avzVMSpSnc673oA27eGBFnMVHLOtT+1b3XIcvWNhMwVmviA7jmP7oW6tcNi0c0UdDYO6aIt0ZJwycvuT4TlzRUYUNXoTo4s4qd+lWctNXLHXFsUUpU8raPzn7pdcif27+o=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 16:22:21 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::84) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 16:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Fri, 5 Jun 2026 16:22:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 11:22:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 11:22:20 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 11:22:20 -0500
Message-ID: <8495f5f8-2732-026f-d7d2-4568b5ce3d7f@amd.com>
Date: Fri, 5 Jun 2026 09:22:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Require carveout when PASID and
 force_iova are disabled
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260604195459.2423279-1-lizhi.hou@amd.com>
 <abe9dd4c-194d-46c3-b074-941698c3236d@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <abe9dd4c-194d-46c3-b074-941698c3236d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: dba46b96-2f17-43a7-d345-08dec31e9e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: FAY38n64G/RZN91Ez/ePqdVeIYMI8lEPc1yy/lriYZeEmhJqNki6noocDTyEbfxYaF20JxtjSMC3Qjo6lN3SlA6NZlRZKICNRmREUizkX8A6pc5K8SpZzkvH/Xt8qOBFebvsYTKLVwTSyIAwpt/pCSLRxSvAfb9X5BMXe3dwBJ22KY0R9xVEVXpFiP0YorDcDVymv5uBk1zCbHjmQly2pnDkCsP5K7JAT1wCFs7380r5vfFkbXjpJATCBnypfEs9KvYkuzbUp94HjuW4/IeikwVk8dDt9iwmlBpmMLoKpUWUeAvL9spQGQY5/i278ssIgeo/QBPLukS8R3zWon3tp86QtreTy242xZIiNpkBGP+uKQZjtvLBJGT3SQPWUqMVZVD+OpWAkOou6KbkB+IY82bBnRBR79XtfUMieD0MjbfAn7QxKIdDQ0kVNNYjYbDZ8yM9nkuAtxxnJNQi4DA3ilf+POFHUUbWD6MggRT7o6LZRKDKOUkryAI+8Su3Do7hgr/h4+3Mlk7VhImjsAaWkKbsXZpExhDvKTmUzg2z9aTfLSL7klLjgurFcr32Gd9jM4WROCWEFh4wG8izEpB6QQb1o7P0BsNhETGPyC8LvLGl5B70W3hCJ8caAF4YgDz1AD1mcJSwkyuOZdgY7Xguxt/cHz2IhntqyW7CNHRsctwZq0mYNQeM6jzTjB8wGHEGg24pnseh1tkq8T6vel89786FKGOGAX7mBATtz+wwbVQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v+tnQUM3vYgtmUBwI5h7BgB9kx/WWR1JgOqIwrkuyvaQOWo7XUge50jQRB6OlAhVA20UNktTEXNo5qCse7lINMokf9+QBBKBiX9YNPUCYh0t7sk5LUAmcRZhvM2d4EIXX/RfK6zfWgxpbQK33wCoSAVhQkdg1wSzHCxBSlih2IpVi5rRJ2GwtVWPg4J7YqX0P6iMmQvRNvcyTYYeCVH+6SrDrqAywzL3QEMegWY/D9nthvfQ2kCzzR76ZOcNLBCKGZK/meCXxk5CtGm70z5qBTQHkFgyfPfwfYLELUWERXYD2z4h1pWi/X/oOvQ9dOy50KwP1MBC/GxtPdPtoQtLqh6gPXZAoG93wlIduX2nM7SJeVhXjM4wqwo0uTBfj7WXLr9UpRRPuapif8kS+ug7sNbRGxfw36BnPoLr7t+bjKmxlVSBGuf5IiFtQa90p8Ax
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:22:20.9555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba46b96-2f17-43a7-d345-08dec31e9e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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

On 6/4/26 12:56, Mario Limonciello wrote:
>
>
> On 6/4/26 14:54, Lizhi Hou wrote:
>> When both PASID and force_iova are disabled, carveout memory should be
>> used. Reject buffer allocations that cannot use carveout memory in this
>> configuration and return an error.
>>
>> Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for 
>> non-IOMMU systems")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index c677293c1ae7..1f066ed8d236 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -120,8 +120,14 @@ static int amdxdna_drm_open(struct drm_device 
>> *ddev, struct drm_file *filp)
>>         if (!amdxdna_iova_on(xdna)) {
>>           /* No need to fail open since user may use pa + carveout 
>> later. */
>> -        if (amdxdna_sva_init(client))
>> +        if (amdxdna_sva_init(client)) {
>>               XDNA_WARN(xdna, "PASID not available for pid %d", 
>> client->pid);
>> +            if (!amdxdna_use_carveout(xdna)) {
>> +                XDNA_ERR(xdna, "PASID unavailable and carveout not 
>> configured");
>> +                kfree(client);
>> +                return -EINVAL;
>> +            }
>> +        }
>>       }
>>       mmgrab(client->mm);
>>       init_srcu_struct(&client->hwctx_srcu);
>
