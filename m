Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A0AF9D0E2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1DE10E620;
	Tue, 14 Apr 2026 16:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5R1Tav7j";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5416A10E620
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8yTCuNKBE8x5T6OnJdtxfGXemC+/61WTR6RoXvq87/vMUhQQmw248EHrxPCqr34rqUfbzvjZ8unfedMOocysDuQo7Xdc+QZSOduqxmevSGivGtOKP3vfB+kgyDYcTLEN7r9WPVZ3dBz+JoFya+BBr8edXktmBPsBHhTNRUURS+Rxdx0DXQLH0APCpw1+J1aM9LXV5VjLmvZJ6/AVUauNCNK47Lq4PaZRy2+CgimtSrakd3FL1tUwQwZZUPgjHfyrXoEN/0nAvAQM9I4nXGYnboWxGrO1aqj/kl4wrAshMzeKkaPtcvd+goqRrx+G2TcJUAoHzGT86SKMJPyDI3QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3jVdoNiStk3JfigHyVw6ZmLvCXJ9GpAMzqXhswZbk=;
 b=cwgw0D04tkDvyqmjqOEZWmIC0oAtwX04hGgLuD342sLO4WNlcsn8th290mAI7Va5JTcJOo9cS4EgLhTop2octaSgTD+eVwgCh2lZLaqU/2BovXvQSfoBYv8vVOiS0L/eeIVzJNGhJrny4adhkvAmvSRW03qibDLpIH2YHdVR0aBjvQnNu5sMgn4nwZG3cAd30hzf8zkqf4pU3MhAl572vggbA7Lp5UbnBnXGnHGtGUOexlfdiLalSWuFH8stlinzddv4O0OQCI+wAGihFIIRJZquhx0zHLqBqLsvRm6aa+Wy+81egwPozi9zkIMcMAa490lbRlTUPhLXWtoeRJL0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3jVdoNiStk3JfigHyVw6ZmLvCXJ9GpAMzqXhswZbk=;
 b=5R1Tav7jZixuWRSMhfDXUb++usHmmLE9iXODzJYoVkEpZ8LF0GVKTJQFTxDoZ/xZwSoEoxNGh5N0IUu9PZ3fWmYnqFcwY0wHMv3bv7OtqoGFJY0RO8fyS4HdRNimrze/9REo13CjI/YV09UlTTMejLup+dco+YEVj+YzyEC6Ku8=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 16:16:02 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::54) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 16:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 16:16:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:16:02 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 11:16:01 -0500
Message-ID: <671fd0d0-1385-940a-9989-5ee47268b961@amd.com>
Date: Tue, 14 Apr 2026 09:16:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix iommu_map_sgtable() return value
 handling
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
 <sonal.santan@amd.com>, Dan Carpenter <error27@gmail.com>, Wendy Liang
 <wendy.liang@amd.com>
References: <20260413180238.668441-1-lizhi.hou@amd.com>
 <620d8ae0-f219-4698-b8c3-72143e7cd30c@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <620d8ae0-f219-4698-b8c3-72143e7cd30c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: d7446992-df1e-470b-da45-08de9a411f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +4jppkaKgIhNbstfKG43gu576GGxYjR93ErNgfJrHBNZms1BtLSJVwnTbcYKlIkpJV1qcz0QdhHruSqoK4Y2B8X8BewBCOWRi8GyV88ODrOsvGMQE0t78xLhGu5ZlBG1IJv8tj+NBvgj4GpqxhGynP90pXSqcen8H7nAA8oyIhfuxtMTE62mFEBGXQkU8Tw+wvS7xD1AIIAGOgp+KCMWMDHgaFrfIpAN39e9MTQtnLjcDavfKRjZtWnt8W3RD/HZsnbGJ3gBnQut6kmtr7nOFaX7Uab5XAdNn2vbgaaZgI3UxqVFsywJSqdxCviS90vCmFSDClCtyP77D09jI8fnrWw84hPB/JrirAevrfjBPsS/u0EiSVT0VHQb/GzelaQb6IxfO8CE5Pbp6EGy6XPUt4ZZrwJWP7bjaYj5o+P23QhjBic3Lf14PO8gI/5yfbf83FlR2y4CI75mlcjzMhKjrK9xmQ1ppNUH2Yfz780uAPPY3KzsE9f9dOrOK4n8DzG//MUmSog/WSZZTbjfawYz84Q1DED0rO3tC5cucwBpq4lDcHdYzOHA70unaQ5p/00oeT3+nr6wvrSHlmEH+uwNejGu5S9VXBNvPNvRUoq7J3OkW2n3iz84IrIIKVs1SCyk+N0Kgry6+pNEmKDrYM1tNP3iU3yw1ZANRxIZ9xUPCU4tDFt3oZVTfaO+Ur5TEkqzAh80ZfhiqjsnUVJyFOIb0LBKZ3z7ax6iRCDpkUHcS9sktX2af/6Ct3lGOWZ3X6UyYVtKc7+ZBqqOzk3iyOFp7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: URdaDOm7FW7PfG0auVaLpg1p9ucBPXF1kg69+g1t81TpUeUB9n5fNzVGEfsgOM0YLESbMsrFJj16Qeug2OiYpBKiUBSO3YCJMkWlsWa/O0zcMH7lIrANaOfJV/p8ph16H8Sx1tJ3wv3LteQmhgQo4wIeSRidVKKzkPRsHfr35xtZdS+kB+cKKZAKzvDmM7AZOF9XqsIdBxmabHRS0WYuccJh2kR297miB6P9xFlOr4kv4JC3SDswAVd0aVxBy13FLnt/kr0+xZcxWor9G0X0+UnYtgapovPmS7XVjqNuzbOU3cIhO0X2jTm6+DTAefp5nswdnMIcdoQvpTV/iYpeUqJzVSdmWTYd/HYEPr/Jf3oy0HxRaKKYZOJ/mjfoF5SD2ghjBC9HFN5EMnXQu8O5ncScvHf7Y4d2HUJjGSmjkvb0PA2iE3kYv/uILsgS+Vu4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:16:02.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7446992-df1e-470b-da45-08de9a411f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

On 4/13/26 11:27, Mario Limonciello wrote:
>
>
> On 4/13/26 13:02, Lizhi Hou wrote:
>> iommu_map_sgtable() returns negative error codes on failure, but the
>> result is stored in an unsigned variable. This prevents proper error
>> detection.
>>
>> Change the variable type to ssize_t so negative error values can be
>> handled correctly.
>>
>> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via 
>> module parameter")
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/all/adk7kOUBwIyYnX1M@stanley.mountain/
>> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_iommu.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c 
>> b/drivers/accel/amdxdna/amdxdna_iommu.c
>> index 4626434d4180..2676cfcfabee 100644
>> --- a/drivers/accel/amdxdna/amdxdna_iommu.c
>> +++ b/drivers/accel/amdxdna/amdxdna_iommu.c
>> @@ -40,7 +40,7 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, 
>> struct amdxdna_gem_obj *abo)
>>       struct sg_table *sgt;
>>       dma_addr_t dma_addr;
>>       struct iova *iova;
>> -    size_t size;
>> +    ssize_t size;
>>         if (abo->type != AMDXDNA_BO_DEV_HEAP && abo->type != 
>> AMDXDNA_BO_SHMEM)
>>           return 0;
>> @@ -65,7 +65,14 @@ int amdxdna_iommu_map_bo(struct amdxdna_dev *xdna, 
>> struct amdxdna_gem_obj *abo)
>>         size = iommu_map_sgtable(xdna->domain, dma_addr, sgt,
>>                    IOMMU_READ | IOMMU_WRITE);
>> +    if (size < 0) {
>> +        XDNA_ERR(xdna, "iommu_map_sgtable failed: %zd", size);
>> +        __free_iova(&xdna->iovad, iova);
>> +        return size;
>> +    }
>> +
>>       if (size < abo->mem.size) {
>> +        iommu_unmap(xdna->domain, dma_addr, size);
>>           __free_iova(&xdna->iovad, iova);
>>           return -ENXIO;
>>       }
>
