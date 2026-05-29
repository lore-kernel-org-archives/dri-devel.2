Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F02CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 04:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B1610F867;
	Fri, 29 May 2026 04:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICdLpdph";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A289710F867
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:27:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ilh22z8TN+bDsPRvP/pqDgaY8O00i2/0l5BRCaKyXX/8/Y78JiErPepSJ5ShM2UIJ2sQ78LV1bxMOV+/cTm6t8QuWmh9I4fFYs6rGBgQ1W3D7M6zsSoECyXr11qQp9sJhRZHuYSwWt1PeWQIkJ50Q47ZROZsMfUpq3DO8YlFZuGYXsPgpRVm1lw+mSsjhyz00aTRyIzFGYwDRvjDBR1Fl98N27619TmFgA+5MY9XcE1jMFf0E21ccuGr7OGi7OXMzWa9IRKDDMBw88/klgSMpVm1qNY6b4seNcgeXS389j/sRtXQHSBz+dMbQr7KXX88y4T4SbTC/NvASgZAsqfxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBHszpVoN0Hnimn4JyMdwPIiNX50ay0H85IAzkdBRkk=;
 b=IJDE4J0reG+YHR8c0v7zrrCuIVRroLSWDR6nwMVcpVyQYDpx1U/BGl23vvYJ9g0nZ/NDcpaYvU2sjCAorYyr0DMqNsalW4W/jkpw8jhSOeIU4LObbSYdSDluH2lNlVrv62QhqSXfZSivrlE9Oj7Q0iWRGo2Tg6rakv+UlDf0tpOx+4NGMbrslyJM1iWEg07jBotZleGGytW3LIVdLSHH8krfBeFaEJJPrgzilwaA/a3sHOQwh/BOhjAc72Rhwef1oeRKyX7Hd1RVP/twXXI1jC8e+Ofc3BIb3uNK8U3cNIfbZ3Hnf8inBB0r5Wdp+geoCL7OoOE83jdsxC9xB05XxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBHszpVoN0Hnimn4JyMdwPIiNX50ay0H85IAzkdBRkk=;
 b=ICdLpdphpOOCizoeNwUznY3pPJ7aGQwgeUBk5mi8++f8tsR8qArGx5RmczoUYYj66eHpXJmtmk1qBD6m1NkhZHNuJ4aqWrliISE9NNV3WW8i4LhL5sLooLdg7uEpN2aN+AV8tED9l3GwGF5L0ZsJeBUU6o1Y71zKonzfAVy6iv8=
Received: from SA9PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:6e::6)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 04:26:57 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::3) by SA9PR11CA0001.outlook.office365.com
 (2603:10b6:806:6e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Fri, 29
 May 2026 04:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 04:26:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 23:26:57 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 28 May 2026 23:26:56 -0500
Message-ID: <6817ecd8-cbf7-8ade-6926-7375bda20e73@amd.com>
Date: Thu, 28 May 2026 21:26:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Disable device buffer exporting
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260526185058.1780869-1-lizhi.hou@amd.com>
 <28dc206a-695d-482f-b434-c27eda960bfe@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <28dc206a-695d-482f-b434-c27eda960bfe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e87f3a1-1b31-43e9-fedf-08debd3a8548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: wQ6YGuwcQCwW4n4RbLfXxI4cC0kFWzklH2pGmDUgz23OuoNljA/EtaWKOlNr+Y6Av14yTcSXEBJc8daxAPfU9cZl7MVfwOn5ylZMgLUYMii1J75hGSF3/DnHRzmHKTRooWHxiSDWR1yPdL01l7MmMHgaDm0MlCQqzmrCiHHWfobf+6szfvjEkNvge8Cmy9Gm6Wt3KZN2TAST/Cc1IsrZhIZMIihe39TTOdzkmuFcLuJu7uIHnGm5asiqUbOgWn25EWUQKrL4grtk814coZ24u4kfrlzYAV2ugYp9xVlvS0JvyP7VKL9gJTQbciIP9T2unzOlDA+fjcRTj/OIhjgyBvtkLY5FR16FVL02CTzojURp2+Fd64eAJZNqn1p4zmYolK5fOyyeIoH+LmiHgEBfdQBqvUvOCRJCo9axoINvGKq/JkJZ0CMftMp3dhHyVC4HzF47FTdnlW5QlbfJh2AqulU2/8+QSMpmFLXZ9BbnpzdqZ3bFgbD4an9Nw+c4x0GOlcl287KcdHtpTJixu9fPgWdp/HEwOcy2prL7dJ/nqA0mMy5jE4aTs2hqp8qPwbo8/HcTQVDPl6IZGyQCUgCI6OHJa+xkS/ow+INXFlaxv5lpJXw0dhLeXKalh84XUX/nSZMkxa/66Pv5tEoPAC5UTv3Par8POtq5sx5btflySn9CJjvo6OoONaZugRDRJhrayLQ3eNY8R0ZjM//KlhGoSH5Dd5l2YRukEN5zFXPQags=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RD4Dq/t00tn12hfqTE4Tg58RKMmdbMGRWlX+vgNsc1QESs0Hz+ML5y0cquDTuncD3/oGsE6rx/Wb4hIa6Y1CDQN35tPqkjgfWyxEGEF0oYxDtYkapPFKf4Q5FsYcKQfVtZOV2z2I8bR8mJTlHSN1TxXznT7en7f1JJPhBqzlXdo6rOsjET5ZPEfGImtwt5V1D9UARBrd/Wy4RK1XULQZRmLMN66hKLEcmENvODoLaEGHDTlyVGY8RfksUjQJyyUKs0ts06XSDxS+R+rp7Rqri06f6KasgCgKC18XcC+HXhalKvoH3zVQXOUUzzoSbpkPcRdHrJ5HbVzsX8E4uli6Fu5I3VuTQufPfT35bDLHCIqzzhjngoTHMi19o4bwUADdgt5vUQvp9Wdqk7/WpKLTsZr9/xFjoIkLN1AB2GvuxBECpra9wRD4bfkUka/w27NX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 04:26:57.4483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e87f3a1-1b31-43e9-fedf-08debd3a8548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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

On 5/28/26 14:19, Mario Limonciello wrote:
>
>
> On 5/26/26 19:50, Lizhi Hou wrote:
>> Device buffers are never intended to be exported. Disable exporting
>> support explicitly.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 2dfdc56ba91d..2727e48afc0a 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -725,9 +725,15 @@ static int amdxdna_gem_dev_obj_vmap(struct 
>> drm_gem_object *obj, struct iosys_map
>>       return 0;
>>   }
>>   +static struct dma_buf *amdxdna_gem_dev_obj_export(struct 
>> drm_gem_object *gobj, int flags)
>> +{
>> +    return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>>   static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
>>       .free = amdxdna_gem_dev_obj_free,
>>       .vmap = amdxdna_gem_dev_obj_vmap,
>> +    .export = amdxdna_gem_dev_obj_export,
>>   };
>>     static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {
>
