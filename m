Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE52E9380C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5D010E039;
	Mon, 13 Apr 2026 02:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4RApqgX";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C361E10E039;
 Mon, 13 Apr 2026 02:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfxTQ3ME1imlKbmSeGxjNncOXHVDHgNtgQRzD4NseAnjg+aBtxhG/qkcsz8dnyIAVNAGwniStAio2vRQzAH/BoHfZS9Z9ROh5Xuc0JMBOGNgoFCZU1/8vgMBwNRKHKZoIZVfjHJWZMvohgvGBnSQhyj78Aw1rqu5iQQUL1kz4LnN704CMJJmmU5iQ/5MP4amze8f8mZaMaIcA+0rrvIpSQh1PTrCKsx8sd8KG8N2A2FslNNoS3YR4Cjfcw1Q0O7WoN339cYsM+WRNt+oVmXeIIbCSLXW7Rxljbp4D/oONvhFoabWv1B5aryUPxs3/RmHa4T7q/EBavy1+Fx8q0A6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuhGG0EcYSe3/QHDnRFuU7KZUONrzylBpmxF0nZKA+8=;
 b=PfGCRNxyJuGkAUqOqgPoUnxJ/qIVwx3zNHYRHAy+qvv0shvWjQSK+j9mS2S8chSQx0lmTB+SwfobF57LPRJ6FtmsOfQM1K/dsqcugfsQJjTAdOMdpyx5wSuw9AzIpa3SYh/jklsC/OmQZ3SAgVf6slOn4MEcHbmdrH46DW0qmmv4RP0GJN8JKU7cgXZXnNofYG6SMmHp0g4hahdQuIlxCGIZDfPOW8a7vwLbUSmOsc9P5nPzTvSC18HADZvJerh/aGRLKVad2j0MH4NUhih0wmyThZ2QtLLLsWSXYGWVq4xsPQkU1D6r+QcHS7Fqf+XhNzZUkINlpzfUA1+glHuQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuhGG0EcYSe3/QHDnRFuU7KZUONrzylBpmxF0nZKA+8=;
 b=v4RApqgXK8iJ1o95fAaroKgA4Yy8K6eYW2moFwj51swSh/N4s67QcKbEF1GT6EovI+owRaSGFpmvvZn1zhkbPBHOTh1/M0aZGYc9nLz9PxJnOAGaL+41YlVpuUGsyhb1uNopd7xQPUFQPuU4Nttelijop+7YIbs2cCBNRQ/hTGc=
Received: from BY3PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:217::29)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Mon, 13 Apr
 2026 02:50:42 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0024.outlook.office365.com
 (2603:10b6:a03:217::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 02:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 13 Apr 2026 02:50:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 12 Apr
 2026 21:50:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 12 Apr
 2026 21:50:40 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Apr 2026 21:50:37 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Christian.Koenig@amd.com>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, 
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, 
 <Ray.Huang@amd.com>, <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: Re: [PATCH RFC 4/6] drm/amdgpu: add SVM eviction fences for VRAM
 overcommit
Date: Mon, 13 Apr 2026 10:50:37 +0800
Message-ID: <20260413025037.11738-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ee389bc-5321-4ff7-82db-351d4f641e6a@amd.com>
References: <20260410113146.146212-1-Junhua.Shen@amd.com>
 <20260410113146.146212-5-Junhua.Shen@amd.com>
 <8ee389bc-5321-4ff7-82db-351d4f641e6a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Junhua.Shen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: befcf37c-d734-4bb9-e589-08de990773f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: WKSgFK5p4/k6RxHTabBfWgJMYwJA0we+M3785JjXiczp4teVn9HVN0GH3Wgy4Y0QrzASUb77VAP6Mthho0vlshjUkq2KCOmrFncEKfGmfp6e3nX6spAQ2gotYEKJGXJE8hvgb6+sgmaFVDVgwyaQTyjIxjGZE7NXNgXIg6ia6Z2z3ch0TUWO//vBPiouuCrx1HqfprqbwkflXwhv5GYQuRfZZCoJW86arqOPnQYCSE44hDCQWUeDlOKHkPW+aODRVOj+UDTGrq3P/EMemTsP5TzsmjXr0Do/LWpbVKqgwiS6/J6+aTuTR6LWIOD1VMpIx9gU2VbZh4januQqyL/W8S+jAzZ5SJZD7aF3Bvtyv0yqhUy3LMiT5pXdZH4EgMQZ5Vr2M8KZsKfMPqeWhCFhlcDM5A+Q9yc38/1ato8dFJ5OVvin3hpfBe/D8QSIcg2O+jNyQvNotuU31um+S1CVP9ceGYEvZiMbz+rCV5+bS4l2B1Uycfp+VCSA8LTdPLz5EZq/4iK3qK4PWBRdyvRHhoZii526M8oQ75JOAfTZRuhv0Yd8WeOiG5+0LanQvYtkTlILNlIRx5smm4jl3afna6Tn0e+4TZoNcwrHNubscsn1mDzdvtonNa+oTI0C0p8jED//Wcb9Iyi7Su/YhP5x6/nqfUwWIyRpkjXJVW4AS7sdbITp2+n/4czxFmXtdF5AyyrNMP9BsUGPbLi8N6o63Lsy+XQUx2EO8jCFbpSli+BlWyIN8eI8aeI8wvIyDrYsnU1n93Rvbw+136EcHokuFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N4MJzLPsSCOprgqxW5NlUBh6eNjZImZMvZ8p/mCy4YbJOhZMusM/tcuMLqNPDK9kwTCvKTiP6ZIE56tlnlQDZ4pjX4wnyZfRd61lHFigEDCZk+qw/doJMpKAKq2MlzLJbhHvgWfeSCKFl7S5JVfoCbR8v/sGQJAFs6n/EUu0cXtlsXmNQX+ZJgaHrp5UJS5EIAUu3FBhpGucGFu464+rgh9w5icWRZcfjPWGBTibhziuVUSFjhwBIOfzeCzYy9rESveAmDTt5sqhy9nnbxm0KsntoYzagp7uFgzMS7cyWBIORcYwHmb/WVShjrLN/bJdjO+9QNR0+UzfHd4+TXhLEn0V0g3hvkG6CD5vsEbaMG4eWFDhOhwBUlLW0VHtGLjCCFhNwzYNlTsx51E/SHLcvgQQApN/jlroBN6MA/hI9JLMqThP2pvoqB06TmZ5vURQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 02:50:42.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befcf37c-d734-4bb9-e589-08de990773f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

Hi Christian,

Thanks for the review.

On 4/10/26 13:31, Christian König wrote:
> On 4/10/26 13:31, Junhua Shen wrote:
>> Add eviction fence support so that TTM can reclaim SVM VRAM when the
>> system is under memory pressure.
>>
>> When TTM needs to evict a DISCARDABLE SVM BO, the fence's
>> enable_signaling callback schedules a work item that calls
>> hmm_range_fault(dev_private_owner=NULL) to trigger migrate_to_ram for
>> all device-private pages in the BO's virtual address range. After SDMA
>> copies the data back to system RAM, the fence is signaled and TTM
>> discards the now-empty VRAM resource.
>
> Absolutely clear NAK to that whole approach! This doesn't even remotely
> work correctly.
>
> Please see the documentation for dma_fence handling for the background.

Indeed, I was a bit hasty. I will revisit the dma_fence documentation
and study the KFD SVM eviction handling as a reference.

I will drop this eviction fence approach entirely in v2 and address
VRAM overcommit properly in a follow-up series.

>> The implementation adds:
>>   - struct amdgpu_svm_evict_fence with dma_fence_ops
>>   - amdgpu_svm_evict_bo_worker using mmu_interval_notifier
>>   - amdgpu_svm_evict_fence_create called from bo_alloc
>>   - AMDGPU_GEM_CREATE_DISCARDABLE flag on SVM BOs
>>   - fence attached as DMA_RESV_USAGE_BOOKKEEP
>>
>> Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>

[snip patch diff]

Regards,
Junhua
