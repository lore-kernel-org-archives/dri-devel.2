Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BB606A330
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nIqJSGB2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1458010E6C2;
	Fri, 23 Oct 2026 16:12:25 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C432710E6C9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmkc53LegEh48D0F4cXla3yyxyES50/7PLjf+Cj7n8qETQNbOZGuNrSLYep2AWQYtrF2LWhSiptRkpvHMOX2WCbw0Md2Usdo4LQ4RVssjL9VC8yZy77cIfA/k/sdgFN5HPinwfPjdn1fPH010jOVSnAxwV+Ft0pMYBobZBgAA6q6Z4ov/XU99LqEXf4wraXlh4BFElvBsRSduPPKOdqXClkbMdJIWckBjQfcdB8zO3/P3lPzK1XLM+yOLjSi/Mz7MpOeAeAlIvUzOt0raym33PruiYMCAwpyrer1fq9iii3Un0FrHrjm3n1nwRcuoCNPtGTC2ONkMCJdJc4umdJhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmXYlsRrntpMXLAIxLsc81MfK1u5438u4MJy5+G/Z6k=;
 b=rtTrSG8fLwZJnqu0sxnT0995bq6q90G2289unp8lw4svJN432FHryZFAl4srI18wADmhDcZf9xK3QmuSjbpKUguflXOK2fokkw8zCnsTJtpd8+YuI7csgmSSsGLpCrHz8eHHBYfGOneVfuCyZPxoWdiyuZhotSG9KAdEjHlhiy5GKReAA6/emJoyBzR8dNHwH0Gmj2ck9J5QHDi56+5iR3/uKbK4hdKMNlYkMfgA+qKZZ7pEpOPYmev9CL8Cjt5tfFAfI/FVmxFZaaSBQtsxl+RLGCw8jncnm1OcaArbtsmHyK6M90tBXJxN1wNDtTZXPwMXCLnrLqxi4keArDnD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=protonmail.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmXYlsRrntpMXLAIxLsc81MfK1u5438u4MJy5+G/Z6k=;
 b=nIqJSGB2cAzqu3rvxF11+fx0KnH47ZvUX2qf5RQsRvodsZawupLJ/kQg+Db+01YaiOoBwUSFWF911jLuQ09axOOKLvQkafWi6z9n7ecJckI0IGM2toMUR4bHZrU6Po7zmgEzySw7adRMk+GqywCDRosfDg0lzZEkseIg6xuksBk=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:10:55 +0000
Received: from DM3PEPF000265BD.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::39) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 16:10:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BD.mail.protection.outlook.com (10.167.23.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 16:10:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 11:10:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 11:10:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 11:10:53 -0500
Message-ID: <1b64aa76-92bd-033e-ee0e-bd7692b3a2c6@amd.com>
Date: Fri, 23 Oct 2026 09:10:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/5] accel/amdxdna: Use compatible fdinfo engine key
Content-Language: en-US
To: Umio-Yasuno - coelacanth_dream <coelacanth_dream@protonmail.com>, Max Zhen
 <max.zhen@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20261022155753.232976-1-max.zhen@amd.com>
 <qAXy4UirzgL1y5Voy73b1qQ5-Fa_UPNl--88ahgTxRsSyCIv3DNdH5BuSoBYG-i6TTNzXl9RtS32KGeXaLvghgM39yNrAUFq5_ZG9d9w5Tc=@protonmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <qAXy4UirzgL1y5Voy73b1qQ5-Fa_UPNl--88ahgTxRsSyCIv3DNdH5BuSoBYG-i6TTNzXl9RtS32KGeXaLvghgM39yNrAUFq5_ZG9d9w5Tc=@protonmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BD:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8ef1c4-07ea-4e5c-5659-08df31203784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|261009223027099003|3023799007|261021123027099003|261021121427099003|261022105027099003|11063799006|56012099006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: fTpMfvWwSlzRcxnPgCPfnk7hsPuHHSAa33p/DBFjT++D9g9I1SPk/XxUIpDTNugnpRpNRk+T91lPmO+HRFjKwTluOosIUrzEBN/Q1IoJ/93cQlhxGJHVRNeuSuV68Z2P8R1teVSxhdQTGInQRnIECWHGjRy82aJXB3oB9M1G+0W7akumkEd362gcrQJoF7MmCg+B99dI13+VghKPFPcr90Q7w4zmMBHQRnZ8ysT7ZaMCUw2T/2Lh/ZN7ryVF/i4dqCP6QVukYqxT2Z+aAuHZiSc+JgDSKBIzoU9ZGJqgtrtT64wLhFRyKQyN+J2ZSgkrQYWEnZ0QHO+Xb/RhSj/d2XfZnMgxifYSUDN+DuYHgiJhbzojg/Ftaiy1j3VWIkgQjWrFYHRoyd5z4y1niMYdBHbCqeeajQFIJ91Sr90nSVh+VWfgsy+9T54hMtzhRvZDvwRHZ3Wa1osBjCTOLGRLPL70TZSOSyfzveVjyPIAwYZA2bmU8qMBPj3cRngP+nilY+rmoLNBkoXnywdzyYsVUsjx1OOGlFThJvaoV8/SGh0U23WsK4iZxkRtK3d4TJP2XtIFb+hFkpWo6VRlo9q1CQ6ClQuhn6CxNCF3NTaQIOvWUQSoCAOD76kh81vVlwPqt5RBm/RpFGfcXDI2RYIr3AUwo3AElbUfVGxzCkeYPed3kBHggHO+RVSowMSHFOG+7NZ0njBTBeV6mdQj5WlCyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(261009223027099003)(3023799007)(261021123027099003)(261021121427099003)(261022105027099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: spN7ATS7eqBiSMFxhIdiraP2C9Bqxp7uXBobWNPgqZrweG2yYunOOzPpWLGVVhsom/Q98LJmkXehw6qALBWJp7eSKVmBQ5rZKeBUHBrptbqJHVZuiQMzcMeTM1FS6MAxWCAjZENgWJoKu8IlvPlE8T6U4xYGoSsJiUhOiNHzVJbvqIZadd7+QuIeqB59jbml9hcX16olJCjhG+PdpcR7vuxLRfSFGAXkCrqtffSlynjRFBtNTTeOLVWeq9cXDQQbHFy0m5jSriPU/m/Md6UCJhis4N5GkdXZJJ32zCTMpRxnAkTOhoYUYO2n+EykXB0JpCpiaNcOWi8ie1pcSBHXta9JWqHiJj7OR/AiYHrbtU39HvB4X70cfToKzTqnu4tqLKxm6inu9aVVAddFK1bEHu7NeiWuunsStnYMUZzSveSpGQnM4v1ijvL6e30+SzyC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:10:54.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8ef1c4-07ea-4e5c-5659-08df31203784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-24.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied to drm-misc-next.

On 10/23/26 03:37, Umio-Yasuno - coelacanth_dream wrote:
> On Friday, October 23rd, 2026 at 0:58, Max Zhen <max.zhen@amd.com> wrote:
>
>> The released out-of-tree amdxdna driver uses amdxdna_accel_driver as the
>> drm-engine key string, which is consumed by several applications.
>>
>> Use the same key string in the upstream driver to maintain compatibility
>> with the out-of-tree driver.
>>
>> Reported-by: Umio Yasuno <coelacanth_dream@protonmail.com>
>> Closes: https://github.com/amd/xdna-driver/issues/1754
>> Fixes: 489a8539ca6f ("accel/amdxdna: Expose NPU device busy time via DRM fdinfo")
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Reviewed-by: Umio Yasuno <coelacanth_dream@protonmail.com>
>
> Thanks!
>
>> ---
>>   Documentation/accel/amdxdna/amdnpu.rst  | 2 +-
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
>> index d72af1b51ccf..b0cc481c73ae 100644
>> --- a/Documentation/accel/amdxdna/amdnpu.rst
>> +++ b/Documentation/accel/amdxdna/amdnpu.rst
>> @@ -289,7 +289,7 @@ Example of the output showing the implemented key value pairs:
>>           drm-driver:	amdxdna_accel_driver
>>           drm-client-id:	3219
>>           drm-pdev:	0000:c5:00.1
>> -        drm-engine-npu: 14003870 ns
>> +        drm-engine-amdxdna_accel_driver:        14003870 ns
>>           amdxdna_accel_driver-heap-alloc:	60 KiB
>>           amdxdna_accel_driver-internal-alloc:	67588 KiB
>>           amdxdna_accel_driver-external-alloc:	0
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index edf807c93144..f233eb70a295 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -284,9 +284,9 @@ static void amdxdna_show_fdinfo(struct drm_printer *p, struct drm_file *filp)
>>   {
>>   	struct amdxdna_client *client = filp->driver_priv;
>>   	size_t heap_usage, external_usage, internal_usage;
>> -	char *drv_name = filp->minor->dev->driver->name;
>> +	char *drv_name = "amdxdna_accel_driver";
>>
>> -	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
>> +	drm_printf(p, "drm-engine-%s:\t%llu ns\n", drv_name,
>>   		   amdxdna_io_stats_busy_time_ns(client));
>>
>>   	mutex_lock(&client->mm_lock);
>> --
>> 2.34.1
>>
>>
>
