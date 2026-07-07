Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A84C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882ED10E51F;
	Tue,  7 Jul 2026 16:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wEuLrrNL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2593210E51F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp3VWBiH9T4l0Vd8g2dM0PDPTAe1ikR1zGdYMIoygBDU8iK1+UdJRuOQFMgAuYTBpC1cX7IyPPsjXGT+HSTebL609U/UURTADkN6umnGya4ofmZxPncSkdfidGP6ogQpceVwqm+0J4V1O/PFFAv85b6TfPML8qdhxdKTpyycLjzc6vaI1VNHBOjg5F3geAoUAGvnDM3OtS3/kLywT1BOk2BJvWhizz1UFMRZrAtQuk3A/EEFGNIGvsaIWQsQ1MIsPeQvlSQjYHESQSP1l2bn1wbTzvCHHBPBmt9QTVaa5eXyeyD8ZrNRr+8Zbnb0SGDLQ3KPvSDQdwl/umR4HZmqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrsmoaFiWgfi3sqRcH4SzCXCQl1bYZoTRTy0NKeE9d4=;
 b=h2o0a1xg6n6hDbcSvQPPcOQjwXg0WBUhXkwyAxICXDFJ6iCDOnEy3tEFBR5NGuJiT5NTfCXba87/Le/8Ube1rPl6PubvrrCEWcuXn2wKmIisJTZUFjJ1E3nwX0tAXvcY8Hd6+pRlDCXs1c73thzuH7TBfQp1x9yKBm75ifASYOhKRv0SaJJs3F/2LqgaLbgNS6wSW6JnkXb3H2UasJ+F57IlbZ3WKrfLn/hFSAPZO8fOCR5q9PB1YWjSqrSJDmxOIIV2PzcUnNMSA+3KOncVo64ve1EkUhSescEwnHCdPjIhp4MA/zWxQy4CZ5uNZhA+tG2/huN+MIuBBLsc/xRu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrsmoaFiWgfi3sqRcH4SzCXCQl1bYZoTRTy0NKeE9d4=;
 b=wEuLrrNLA5IbritNRxMNyb7k7/2a45qI0Sy7V9uDJWil0+DtvwNLJCd7xfelCZms8WqkjFDBtj15VlEFVqm6UCy9Elble/0fxrHz/5GIDXOs+/6X7/AS3I8lSMTzi4BIcV+fR36kukamkkwA3ZO0n4Cb25lvL15v2ZvJlezwYOQ=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 16:54:59 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::16) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 16:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 16:54:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 11:54:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:54:57 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 11:54:56 -0500
Message-ID: <8dcdd7f2-dd66-d875-4551-7a35cf495520@amd.com>
Date: Tue, 7 Jul 2026 09:54:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-buf: explicitely forbid exposing pages from
 get_user_pages()
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 <sumit.semwal@linaro.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <Max.Zhen@amd.com>, <Mario.Limonciello@amd.com>, <airlied@gmail.com>,
 <karol.wachowski@linux.intel.com>
CC: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20260630080112.1117341-1-christian.koenig@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260630080112.1117341-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 01097a04-5a55-4109-943e-08dedc487ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: iC7bqjh8HXXD44OekFX4EClZhSHY2fkivkE4/K3utqdwPSLpbdYCYnA/pD/SZcPmzhYw8b7VLvtPCv/u+YFvJt+FBu9pZEL/fuOogPPyPUGn66tNNxxGm+p9MC0ZgrDkSvUq4dm1loZCaidXJkprWBlSBXzZ30qVJ2lCoCn3WaH4ENBnhJ9j2HeNQeOkpn98gKQc/9+XIb06YPFLLVKoFhzbn7bvmqSaGhx2bEVthNeS7TSHinKinjQrxBcwcIFAGI+JJe9G+Js55GL3Bo0eujysblFKdjT/tEWveW3FHNAHeMFT3UdlQcEMioXLhzt7frvnHz2Wu7Hupj+d3Orn0Bg/tshqxWiX6K9//z65EX+Hq6tFrdwmcq055hxVCJYkyGtXN1pHdc6Fz4g8ejL1BUhhalCEyQYhvcP5WPBF1h5+vyXhNo1DO+8puTYOmaKUacAGruV/W0tHrtWrEU37b02Idb6b7hT05cIOXdB9ETi2tFs3Wz+3SG/3v8XRT4oGYuYjn6w2pzoTl5/hcT8jLWSYMFcORozDbsXtIw21LU+CAFccW7GdRwFR49aJvaDgI2+FWHxIS8C+zaRF+y0YaW1CnK8+KGQbffcMsUkyCt5NWo/ocp0/8yEPOJT3DvrQDZS/6eaF0B9x2JpfvqAkBj7oIPqkwq0l3F0E6ZnE9uWuQKkzLXytNzjnFlmazjQdBwz1RXiV7zcwE8J4sVtHdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XbPmcbT1vnszd+2rjN76v2vylkgF8iMGX7pCbadarYU5dnHUQVRIXjHbYYZwwlDvwh/blXw6Z3tzaLD2RuA1WrAwtj9zVhl2sIEs9DZRxQ5NqoQT3RvnIRy+zLE+Zsa5eP5HrpHmNiIbohT8OAIz541VGsF2abjp8uR3dey+MwQlwDN1poWe6rbIqVYWELQpyWKmnaKV91pbbcaJ8Ge8D7B5alsuTRF4HDC4fo3EKxrs1H7KhEpoiD2FGT2f89nUCCPpQ7t31K1Tr+bQf7ekb16tPlOv0xwQygMK7ZVXFVfMfq2K29B2gZyv2+kOvVULJ7J9b7ELTN2i8XQ17Jemtl7EHOswgYGuyrxEFyV2YVpqeS7BVKGM/aiMtsl1yZRlz2Di2bWVKUgCKdxGxnCCwRJxx5mXBRvSkCUIbjvUPuwFjwyOWR49mYpGhO3/ktIo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:54:58.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01097a04-5a55-4109-943e-08dedc487ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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


On 6/30/26 01:01, Christian König wrote:
> We recently had another incident where two drivers put pages they got from
> get_user_pages() into a DMA-buf and cause quite a number of problems.
>
> Explicitely document that this is not something exporters can do.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/dma-buf.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 71f37544a5c6..aa5af4f439c2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -685,6 +685,14 @@ static struct file *dma_buf_getfile(size_t size, int flags)
>    *
>    * For the detailed semantics exporters are expected to implement see
>    * &dma_buf_ops.
> + *
> + * It is explicitely forbidden for exporters to expose buffers they don't "own"
> + * as DMA-buf. This includes pages acquired by get_user_pages() or other import
> + * mechanism. Not following this rule can create numerous security problems.
> + *
> + * It is also strongly discouraged to expose the same backing store through
> + * multiple DMA-bufs at the same time. This eventually creates aliasing and
> + * cache coherency problems which are extremely hard to debug and fix.
>    */
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   
>   /**
