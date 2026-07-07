Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B32C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EE510E42C;
	Tue,  7 Jul 2026 05:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdcjzbaG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0FF10E42C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 05:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orItAMxiGaY5q1iRN8tA88v8fTLe6fnYZmpvQmBmSyzNbpIY6WujZfQV6Vz6u3F7DbNI+Af7M1yvFlZtsOjXTqqIbvofWmJgYPpDhYJISb0+GrcTVXYptrIh/HCxrZlnaa7JR+NN/fXr/OxXTHvLtgBqwYL5R8uCXxuc5qGAfLef89T9+lkW//OoAXtPFXzVzT+t89Uaw7X91auQm/R84ug/jX4l6BxNAE0wNS32NE8xnd+zzBNEQpPU4S4P7pmTVd4CNSexeFMfo7gI+YDvGK1Crxpag3R2jRR4g0vN5yoAvQWK1gddwmxXa/nxLtfAC6olKt4AgQ5LFQtIfNKUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPvg6heO4EoKz/d6/112oxl3mAeFzhOK4DxB5/T812E=;
 b=VTnktnmB4QGgRg29V3oXdaWzngFOtheS1AhaiEvKhbuqqYdxCFoTZ6+XyBYluJX/3kcyy6XvvsbvE7XBK0PGWwqAR+AIjUkoS8UZXWNLJ2jqHdORv8CsaJqQNx8t3/hGPSBOsLg5ezDn7HXw956v3cdIfHMfKIyOqe6w3bTILBw33HxthAcfP40EwsMqsCkXjTPGFkVmNNT/mzs/mzkEJlS44gLBiomDN96mPUfERf2oqp3YjHeQJj2dP6BlanBXamK4yPauVYoZK8Jd56io6eJ1FsyrUwrF9z8Z9q0mhSHuC3XtkELHeOee+AIg4RRQJQxrFhoGEkfrMcxvvipChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPvg6heO4EoKz/d6/112oxl3mAeFzhOK4DxB5/T812E=;
 b=RdcjzbaGeh74XEqoJuHb8snEEFVWmMxj1k+kgsl/KuDe7FIMcvlQ07CHt4a0hLeVo21PNP4BoxmF/417QgJxFuTfLszcx9CpqdBcxohnXmN6Sxhm2A6XDnPkB24Cuy7PdxlmeZpZyOvHQzGnO+vp+w4C2lsT5woosBKIMB0ObRw=
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:47:37 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::88) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.12 via Frontend Transport; Tue, 7
 Jul 2026 05:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 05:47:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 00:47:36 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 00:47:35 -0500
Message-ID: <205482c8-088e-7c6f-ea0a-ef33ef65b224@amd.com>
Date: Mon, 6 Jul 2026 22:47:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 09/13] accel/amdxdna: Use unsigned long for nr_pages in
 amdxdna_hmm_register()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260616061532.3533469-1-lizhi.hou@amd.com>
 <d4576d55-b33b-4fb6-a10a-e553637cc911@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d4576d55-b33b-4fb6-a10a-e553637cc911@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c20385-0e83-405c-9df6-08dedbeb3fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fUxNDv3lNsrxi2APAeScG70zIhfWFExbrpY1lfDJ/NBlD+igtXSCX7ziZGvKGSE0dcByebWqNzr8L8DYNLHmjjl8RWwcDjp9NKDrDeOJUMPU8b7wuSm/FQYHAU/4k4Y+9zglzzo+htd/xPZVHL1kxXXD57jwefKY8WEC3VMnKCSzaGWNk2+4QdzzCcz5jQqbxx6zJxJx/vTl0lFo9tVRFUVAf9IDMCV8w2mZ9/YRKM1NIZJTLKftu92f0HcNDjR6qiBFdtYl6P2sp4DGzlFjJC6pBk82OFxRMw/fv7pFmk3uHUdOAA/sBWrI807syOro4ojWYoji2jKb+nWVX33Ef2IXjicJcciIVk0N9i6lyzIGOS01JRAxzMqaf4UP19/K+a+L7ImqFhihAO86ClCtq9XSWFdBNtynmwJ2ddMHn7soXBT0Y+9F+npDoqIPUk57BQCaVezebasIBkgiuW2mY9W1g5rG5ludiksY1uPY700eez6Zsly+jhU7Z1ISTO9NYqab5Ibqpulb3g7aKSmzYdRzUasY3WC5N2uBHO5cJDsd9ivznPk+M/arRc0xPRuP22cNK0CUdXGgc16cggq0P9wZKVyHX5SV6nP4H9K4YKJSXVqy9rtEafK0TrC/XDdJ8ybdrVUnoWlYeSXaj1h0CxBkkL6DJfLKdhwkMjCn0yAGXdezS6e3c45CG37umNjHp2XnXT67PcxJQvqa33S33A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LxlN5SvVfMhqzpYRYUxoyXiYn/8vN2lz8pw590W+MpdWLq9GZ2JimSvyNab9lZN5yPrFN1ZXb3YBQ0TalFh4MpUNf87wl5DXZPaC4VHoaD0nb+Ojj+nVr5wm2wd32APHhgVdxByCa8TSOZX5r48vIvQehyZQ6BHbKA3e+5bY+o9TEsHhxXSIoY6ROaK3YGuwZHLuykZd2ZKi9RdIOWvB9hxeyGAc5ifCzUjDU9gGifJKRpACTvg/jT7ftbYviUomv3wJFXT5GkgfiTkyZHlI3d1QsywZQOwuZJbd/DXvdUxuysj6h2xnsBb3xuvHUZztAnM85gPUI+Eych1JUmvYn61dVPqHFo262TvhyZQ0aqaJYdCz4PIXemQi2RFU+7HeSDvploARQ2XxV2eMO6pkRTxAKB0VZ0l+ygt1SrLJNzVVUpHcg5SwUhd5Aoe73fjJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:47:36.7603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c20385-0e83-405c-9df6-08dedbeb3fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 7/6/26 15:01, Max Zhen wrote:
>
>
> On 6/15/2026 Mon 23:15, Lizhi Hou wrote:
>> nr_pages is declared as u32 in amdxdna_hmm_register(), which may not be
>> large enough to represent the number of pages for large mappings.
>>
>> Use unsigned long for nr_pages to avoid potential overflow.
>>
>> Fixes: ac49797c1815 ("accel/amdxdna: Add GEM buffer object management")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index aef4c23a1a66..201536aff440 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -351,7 +351,7 @@ static int amdxdna_hmm_register(struct 
>> amdxdna_gem_obj *abo,
>>       unsigned long len = vma->vm_end - vma->vm_start;
>>       unsigned long addr = vma->vm_start;
>>       struct amdxdna_umap *mapp;
>> -    u32 nr_pages;
>> +    unsigned long nr_pages;
>>       int ret;
>>         if (!amdxdna_pasid_on(abo->client)) {
>
