Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE0CCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F7E10E630;
	Mon, 12 Oct 2026 16:25:31 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716A210EF42
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7yYQesY9IWHxRkVWc80EO6kb2rbrAMdZC3OXxW4m6S5dsbrZ/AnjnURlZP2uO8B3ZWC5RJG74D/2jflnWnvfd750wnq27QOUsqE4/6PMqRvCtNI6u14f8xKQrGKPhBqVsDnp0aOsQ80SPy3yLP2MiwoXQpD2/V8iFY0CHuBi3HWwtzjYew8MEQZV/ccxm7OTTKv2XNxU9VMcyzEBE0/1xAkx+P+pGIr3Ird/qROTpaIQrWpfilCBGzNEpyYz9ryrgtla7RRA2REbDWnQViipl8QW93KNnIJF+2MKduATEdDWo5uUWIBfrB4mXhoM2ktxTbfG2oFNoleOzGsgM2UoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRxgvTOkuzHXkrYfn7D7qRYxKyUiREZs/GaHzhetmSU=;
 b=QLWhrYHGlREAkJiLE9MtT8rNHENXFt+I0WJSxTOg+/1jQGJdTmFaeyIiVN6j+Fw5UmRqcujC7AzBX0kLYN/Wq4qS+FC4NwNGFbZjK1shCafHRdLw7rXEPnXOapDRD6TkJKaw/g0JI/5mRqtB1NXJynVOibUixsdNBDh48ENSNEmFanlF7i2k9mpVydKDNa/mKhEuL8wODqKjZlq09IZ5ek8I33+1YXZFja0TxktLtwJGnyiWGhu0KMkuPGo+kRSOlGh8pnB5Zqk5aAERsSywl0BSWjFoN85jJvUnHNEqxXbIB4YzYgoFaJGLfDy95yZMmYmsqR2wBMxPH1KQ71jUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRxgvTOkuzHXkrYfn7D7qRYxKyUiREZs/GaHzhetmSU=;
 b=OVuBIHxfld9JJvqDvfofXFveCts2DflNthKk3BAoZGRlhTLCVfypqPSPYN2Gccw3Qx7Ie+xhl6nQHnj3+vt519wkugFq8Jgd7gfRQAy43CY8qHs59tghFyQqBriezyJuMpThUFgMc16OOCt/DTb1D6grR1mC9Gd5yeyxBosKPsw=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by SAWPR12MB999268.namprd12.prod.outlook.com (2603:10b6:806:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 16:25:20 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::56) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 16:25:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 16:25:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 11:25:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 11:25:14 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 12 Oct 2026 11:25:13 -0500
Message-ID: <3c6a2804-b4e8-98fa-c21c-5bf9064c9da0@amd.com>
Date: Mon, 12 Oct 2026 09:25:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix Kconfig invalid configuration
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: "Liam R. Howlett" <liam@infradead.org>, Mario Limonciello
 <superm1@kernel.org>
CC: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20261009011010.3521631-1-liam@infradead.org>
 <694d6976-4b2b-650b-ffe1-77f5f3cdd65d@amd.com>
In-Reply-To: <694d6976-4b2b-650b-ffe1-77f5f3cdd65d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|SAWPR12MB999268:EE_
X-MS-Office365-Filtering-Correlation-Id: 839c134b-3c65-455e-a0b1-08df287d68a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|10067099003|261009223027099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: h3oETF1HS5W5TNCmxZDbdxBOB8lVxxv5JW2DuFdZQt6dFBNJ/ACjiDeVyBzCZ7yTraAvlmJqiKDr7xC0FrAP7ZZRW14Za9FJJR7wOjWv9MMee3+wnx8cZ/iAeufm6Yn1SU4pvANnwHltQ1h46eOfTtAXaqMHETHI7/klTewH38BYVeGQBXy5g+kDV4vUlDXXJBSXjcHnXNyze6+K3emEbR8KgcGc8qNU+ldF2IkZfmcI028Cnr9BT1rRNXhsHmsw5qrkXQXcj/721fRhKPdFz1a7IILKDn3GslitiryTAm8T/q8DUIEBPS80IXYQ8Q3HP80L67fin37Vm3Ko2Oa1KuGxTu1eTnBEIT3UNuUiJCJlXbGh2KeXLm0o9GhaGaVF4/98zuxc5owjXkP9xyQ80vEol2uY1AWdMg8fVXPwosFY0yAsM9JDUL0sKB9M4f9REsQ1vU3L2rg8eV1mKgTAigXCiVxEtszedK2vNEROUcQ93KSh2ADq6/2q8BdTZ66oPG+zzOWtvvJdP6dzEUr/TXpxqhhVe5dpxHbEAgHAKgOZnFIbxHaGzHU4mylyIkjlL20sBrxqam23kYM1Lu4v53S1oQ4kvHO3amin1C9WEPwnTvfrItX4/wl9Fyreocxne01kazYGDYlbON6Tz12mNNL74ZqD9qQuZswlxWAgiKqAD54A2b6Aeloc/4mKANBg3T9KdxjhV86us3zf7eRebA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(10067099003)(261009223027099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f7bsgq37+T5jRMusd3/acKKZpyBORQK5NXENtUvcktX5RW3+o7sf4O0fAplhzpSXZAtizSZo5G8IrvlaetjHLNj0FVCCnmbIvj6jj2IUANy1etYbCSuo17Tp/W0jLEiNJ3CDaR3BuFskdtJApifN9KslaPdfMAVZfc4idROVNLG9jt1P6zLa9OVHIIMY1/iTOr1z162arHKnSPOg9WQa2l0NnVACsulSCbYuoK2okIDa/gOqanpEHXlMLTCUVV/g5L2csPsY1ZuAWcSbodeGtszySnK7FwzU8s8YpkaTgyzog8Cs61SzIpDCBL8yLdIfx33UV9aS5tW6sZMYRrnQ23eM7JaMBds5qGaL1j/2i6suoGS5JJ1Yxzd5XO+9hmQT7hJho2Z4U14OP+6xqBRztIwf0y4H6osl0opK6ynrvQHMmLkDBK3hQi/jIjskcDBw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:25:20.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c134b-3c65-455e-a0b1-08df287d68a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999268
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

Applied to drm-misc-fixes.

On 10/9/26 08:59, Lizhi Hou wrote:
>
> On 10/8/26 18:10, Liam R. Howlett wrote:
>> The amdxdna has a soft dependency on the amd_pmf module.  It will use an
>> exported function if it is available and fall back to another function
>> if it is not enabled.
>>
>> amdxdna and amd_pmf are tridstate modules supporting both built [y] and
>> modularized [m] in the .config file.  Since the amdxdna decides to use
>> the amd_pmf if it is either a module or built in (see
>> drivers/accel/amdxdna/aie2_pci.h), then there is an issue if they are
>> not compiled either both as modules or both as built-in.
>>
>> Adding the optional dependency to Kconfig does not allow the
>> configuration from being selected.
>>
>> Fixes: f66d6cc6891e4 ("accel/amdxdna: Support sensors for column 
>> utilization")
>> Signed-off-by: Liam R. Howlett <liam@infradead.org>
>> ---
>>   drivers/accel/amdxdna/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/accel/amdxdna/Kconfig 
>> b/drivers/accel/amdxdna/Kconfig
>> index f39d7a87296cd..eddff490b4f75 100644
>> --- a/drivers/accel/amdxdna/Kconfig
>> +++ b/drivers/accel/amdxdna/Kconfig
>> @@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
>>       depends on DRM_ACCEL
>>       depends on PCI && HAS_IOMEM
>>       depends on X86_64
>> +    depends on AMD_PMF || !AMD_PMF
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>       select DRM_SCHED
>>       select DRM_GEM_SHMEM_HELPER
>>       select FW_LOADER
