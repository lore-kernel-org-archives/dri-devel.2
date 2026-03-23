Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B63F483FB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1AD10E3EE;
	Mon, 23 Mar 2026 20:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0s2m9ON";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0B810E3EE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rujSxetNDQ8cbSyFIGrRMDZG59zU40HYMg6LLzZKyOJbl+9N33sk+InFrA2AWbqC4UDQETj4ZH49D4Ebmf1GCIg2E38HVfvABjI9ZNXrc3YR0zX6c8o71n/mGmi7flQJoJElCJR6Au9lSDcdCOR9baSGSUoGcDzm2xw68NysMGcnQU0oy6nAqjke/Ux0XAw21tahpeFggOB69zi+M1y842CB9Kf+ZyKso/V0R9i4Xk9IvoSoMaOp4ECvmR2j5YMuvROw4ClivDP944S7aXhHoNgFvK9duGEDc9Ke05kQ6lz6ubiE1UGNcr2eUhBRoXg8PwDpoh//p4tNmTIedq3O+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkdE9qc/O2rYGS2Vl9WpqvMP+btbngmjFardNIo8V0Y=;
 b=pMkNYQbuOzlfhET3YwdTXljzQ/2EyLky31jpllNQ+ZlZOaxVLM52573Ts6XdS8kA9qqJ/WUwXd5s1XZ8GZB5Jvv27uVMNzBNtbSyEH5PDexpKaUOjFTncGMQod5jVqVhw8sKwBhkmaSEETaLoZn5l9QWlU6ZVBZ+1ynvqBTOaOmP6r/DMmpOrNWXjrJ0ZKngMhQyisJoiQIMJ4i2qV9+61zZkicdPq1hrX5YgpUbC6uhgdQSOLouTAmAdbG54PlRNGGX5/7SMuZnsJmvR7GQkCTmuqJ3TqU/NFNPVYZRI5DqcNyhZM/LS6BkDgTLE2pyYW9LuSMQwhLxubKNbuzP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkdE9qc/O2rYGS2Vl9WpqvMP+btbngmjFardNIo8V0Y=;
 b=N0s2m9ONuWYEu7yMj/VpUZYVXofYr5hZucpd39ATrxkea1SvuG49UNSEFapchN6iXqa/HabPPqxzBnHQmv5Slf4vxXAgBoIT9sYugXZzJGJRh2r2Eey1kGK3+A9q3Bnl6UiDhnNpc8mxhIz3Bs2jSJ2vvmTNwJa4w6xOuEI3Bek=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:36:07 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::7d) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:36:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 15:36:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 15:36:05 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 15:36:04 -0500
Message-ID: <2061e07a-eeeb-2d7a-806c-0367073b9ee9@amd.com>
Date: Mon, 23 Mar 2026 13:36:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Return ERR_PTR on dma_alloc_noncoherent
 failure
Content-Language: en-US
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <maciej.falkowski@linux.intel.com>
CC: Wendy Liang <wendy.liang@amd.com>, <linux-kernel@vger.kernel.org>,
 <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260323173719.2311474-1-lizhi.hou@amd.com>
 <8d2f44e4-46fd-471f-91a2-5f76b128761f@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <8d2f44e4-46fd-471f-91a2-5f76b128761f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5c8b80-cf1e-46b8-a0d4-08de891bcfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: DKoIDYAtNBivvx042WISJsQOPP/d25h7p9OOxAYmLoOn+cn+Mk8VIZ77JrSMArwmsTTqIWvhXr03zVIss7cV8WUTppt3YejccZudXHBNUiKiG9ZtxVaNDly2hJlmVkQ/FO/CxPSNQUvM/hiXc+S3xyLmV43ZAtJu/PLFyTQHuSv+bM0/+EOvwXPOvZ07q/XYTpCeiv+LEPn6YgoOY+jlXglH4vWkUCs+nf/Y5d74swQ3iP5wsOVgQgHY6mvqECoSsoAkdTDmAmX2dQMPmaS4i6p9Xhmbkm5e7HmYp46WiNOi4WdqZ8iIz5XIVLfi3ivqJm4Jx2Qz9D7VivjtsCnAQTc3zLIArh2bioxW/SLY6O85O4UF/cb/5ryzA74hQe/tC9dFPHsIJNFCGHrdxThp4C8PuiCNoio3IPlnWyRcZ6h9EuYTT+pMQnlZ/jItmkmpbBTw3gPaavD7wvitIFZkk7iNGb+//HUrUKlfQYA8IvKcXpeNWTOt3416YVye2y0HIOax78vCR29SPr0VpoRNy6V/2aPm7s5YfYBNbBMLPSdQfNB8kUj3VYRKZSoy5Ll6lWdeiZGSdtnhHimSh17hL5N9hFHjw6ZNNYKxyzL9s2UMdqkvMeIZLCOc/oQgDxhVywRWWvWaKwtQKs5F/VfL8Za3wF4jxA/EfAfOIzQ6TsmIzVMyoocK/6FnYzCtZj/0iEb94JLA6fC8mhIybpvfSoAOFtHiwwnNpw6IlJGyIStN+uankVv59ApvpJdi8t+9WlDjp9tXWZm7MYQAYUH+vg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5KZKtdMbmc+M2F2FQf7WEfmg+FaPRq0fehbMmh2DlqU5/5kHd+W/hDMcVdFuU8OFmcIGaPyJqroEnKBFkJlU3XQ3I3+xqt1Pz/XshUU/ixnrwcUU95/mR/Cr4eeb23uhHWy/ZQBmki4S9bZnRWZyDDUYHFXdJAZ6QE2dcl6UI94S8SC6u1tjasNeA9dXvas8oF/0Oo3VRDQs9kiHRZC/UteqPsiwf3iFsGyJ9rjjJLhd9qKqAc2dXsQUyLq/dB6N5D6o0vujP2PvZH9w7DYCUEP2bm+VI4yeHhhS3MX3U26yJ4enrZ8wbfwOpCPsLuTu6D/LfvV7JCJl/yqJjCuvuR1hg3yHvV9Nlx8B7Kx1yD3Lw0A4Bl0d5Xu1pWGchBAuBZELJiUsk1wyBDGESfzUf4RSt/xQKoX6phKB9St9PCG2iWzIOO/0C3XnC0Jbl/q6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:36:07.4530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c8b80-cf1e-46b8-a0d4-08de891bcfb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

On 3/23/26 10:56, Mario Limonciello (AMD) (kernel.org) wrote:
>
>
> On 3/23/2026 12:37 PM, Lizhi Hou wrote:
>> From: Wendy Liang <wendy.liang@amd.com>
>>
>> dma_alloc_noncoherent() returns NULL on failure, but callers of
>> aie2_alloc_msg_buffer() check for IS_ERR(). Return ERR_PTR(-ENOMEM)
>> instead of NULL to match the amdxdna_iommu_alloc() path and the
>> caller's error checking convention.
>>
>> Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via 
>> module parameter")
>> Signed-off-by: Wendy Liang <wendy.liang@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_message.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_message.c 
>> b/drivers/accel/amdxdna/aie2_message.c
>> index 7e219a5eda56..a1c546c3e81c 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -56,6 +56,7 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl 
>> *ndev, u32 *size,
>>                   dma_addr_t *dma_addr)
>>   {
>>       struct amdxdna_dev *xdna = ndev->xdna;
>> +    void *vaddr;
>>       int order;
>>         *size = max(*size, SZ_8K);
>> @@ -67,8 +68,12 @@ void *aie2_alloc_msg_buffer(struct amdxdna_dev_hdl 
>> *ndev, u32 *size,
>>       if (amdxdna_iova_on(xdna))
>>           return amdxdna_iommu_alloc(xdna, *size, dma_addr);
>>   -    return dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
>> +    vaddr = dma_alloc_noncoherent(xdna->ddev.dev, *size, dma_addr,
>>                         DMA_FROM_DEVICE, GFP_KERNEL);
>> +    if (!vaddr)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    return vaddr;
>>   }
>>     void aie2_free_msg_buffer(struct amdxdna_dev_hdl *ndev, size_t size,
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
