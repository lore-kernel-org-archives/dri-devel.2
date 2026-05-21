Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D4CCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DEC10E4BD;
	Thu, 21 May 2026 17:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gvzMVLu";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3433210E4BD
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2D5OSTDu87lifPcq6tcB+YFVRUiwp7T791mjSD/aFeSMHfrd9+5VKNSXH3kiklZ14CJYotS2X5+RCLkZHNk0+74baOK0bxwFuBCFEzTG0VU7/1Y3rMQeEqdClpCIgYIYr66UBO3CEKCOGS90nLvEr4zyVL1r0ki9onfZanFw8xHVHcNeCvbCvyFT2j5yIalQ57zg1p22BoK1h0if8VxBOgtRTvgldflocKtAbNljjd2LRCj/jEsOAEWMT47HvrwuhPvEn/sd3hu37b/ljLEupCAJFW+mq5rBnDS4LtSDjEWeeaebYkq2pMUSQTxWNSSNghzyGoMZvd6VeWBN2YjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vONRz7RFZXEIb3OTxBTQ5Ao3Ze2/CD6tr6O6uVot7xU=;
 b=ng6lCG1lYEx+qd3lf6D4P6yb4S/9wjUdEk0e6l4rTY4eGw7wHe9mIOefbGKIKsGqoMcGG9td9mZ3Yre0+fUE+hSWl6heGRyCdtIulyrm/A0Y4tQd0zmg2pZFEE4U7vBgMpUEabai1Ow0V9QDjmPsDxMdYdWrOK4wP/qgVH6gu0C/qQTAlUBujZAJH+GOsfuZFsPfSo+19BCNsv3r1wL7z0LuT12ZFrLIgM3O7YVDKI1L3ytwGf7ntRBtlKJ0X9vdFETxApVka7fZvnoB1mTEpKhUlQ9g9TxtxHuALJb50/53cvHmXegF6fgkM0UuRVyS68K0hGpktmkXqwZkVrsrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vONRz7RFZXEIb3OTxBTQ5Ao3Ze2/CD6tr6O6uVot7xU=;
 b=5gvzMVLuU+uQg2ONfuZ1TFgMCd73OLNzvQo6hBh/TiuiAunLXdPn4xjySWxe07vWpdu9FavXhjMrk/yToJwLvNFXuTzWqithYVLpqtnx4/iQkLwQIsICKSAokpjCxdv4SS9BMaYrLEaPijZsHxGSeuQpEpZ7yN1UliTBYbKljsE=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 17:28:18 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::57) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 17:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 17:28:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 12:28:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 10:28:09 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 12:28:08 -0500
Message-ID: <819e2c14-0b8e-e1c9-a70f-bfe89c12d3da@amd.com>
Date: Thu, 21 May 2026 10:28:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Block running when IOMMU is off
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260520223531.1403302-1-lizhi.hou@amd.com>
 <c0018792-7867-4fc6-b64d-7e0fb8717f08@amd.com>
 <88097167-1bf9-235a-36dc-467207ee63c6@amd.com>
 <3154ab4f-1808-4e8c-a7a2-128938d52299@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <3154ab4f-1808-4e8c-a7a2-128938d52299@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6ff63-73bc-4601-c264-08deb75e57b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /YMsTog1dCFwM2e0hLLYqhL3I27j3P02KYN8FIa5sZHPcIHHoRb8Rxf5Pu1B9UpsdadZo35F038W7ELpvTxMYZgKLfX4ajxpNr+cBAwXZTp4BShciQjVnQFx1VGEZCB3jtNsDwfZsYsdOm4njX+eI480jKl5ARA2b34fbMkZ4e44kjlUH/uznyPZBIpUzSWpkULaO2vO+pif9XGWoNdRT7LJlal2/+hf0zGaeQK0iEqVAeXCMnJTVu3V4wvufoABYIz6h5EClX5xCgG6GERczuOsg6n0CJuIv7A0NJDbKDbDRZ1ud47g8Cc1B+Xu/MqiXa/GJ4vM5/ey7EjPpwXOuEYlD7koPu3P1OrQpunEswrSiZk42DkPij0UHbed7614nNaYjaBbNCqXF2W2MQ3takYEgs/lxZJ7kCjMH8JcZ+HBKUR8Yxnyg+3T6IJ987+w7Gs3DzGqmYM7fCk3OkV1cBNQDKM3tjL+cPAqwgGWNSVA6kld3v+4cmTkQ7QkB9/vYjgHzMmJxmhiSCwHFz3pHmdMTWex3pCf4Qm/2NVRxa8N8mu6BHbj7x1Ao5z/Ghf8uJ7EX33Gur2+6vwBwLFR9+cq/zYUOrF94nXv6cI6H3oUpKaEBvK921VvOpD3WuJaDruEqtw0qAIDo+mkZQ+HhscYGHUm2sTqqdXXB3BKahkuXUXMSf4Ky6c1IYVwkElq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i6fa2/orKufiso1SwWNIOBb4TGgL3UtQjCX2Ogn/p50Z6yH9nKh/PjV6N2wMadfrG5HTKwBOL1IR8tp3bSG9/uVNTi3FUwoxGFqIhzz0RuoJxKY7VaNUVt+UAjnqDvwXv7QMOnFigLjNEkZbm/ZKxBcPnCdkRqydXDMQX+7ZQpxbsh78ORHp8muE76ttt6gwKAXHahxz4rPByOfhq5KBpL+8V4os+81z81m/iViEzTyB+1v4zCH7KCsNSxNsBkqtyjKivFIDEih/SNvhiiCgpRlsylu/zjcGypmitLDegbY7BowXXP/PmdO9ZlGJW4zkhXI2vgN1FciwrvZjloOyH29bTYQC4B0s2b4Sk89yKCxGZBLL//TSvLMRg1EcgD1iVd7lE7dcU9U6Fwndkf3y2PO8N+xawcvfHtNBSya2Q+txmJpZpmS5ggJfxs6p+u7+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:28:15.8288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6ff63-73bc-4601-c264-08deb75e57b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
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

On 5/20/26 21:32, Mario Limonciello wrote:
>
>
> On 5/20/26 22:43, Lizhi Hou wrote:
>>
>> On 5/20/26 17:57, Mario Limonciello wrote:
>>>
>>>
>>> On 5/20/26 17:35, Lizhi Hou wrote:
>>>> The AIE2 device firmware requires IOMMU on.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5319
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> ---
>>>>   drivers/accel/amdxdna/aie2_pci.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/ 
>>>> amdxdna/aie2_pci.c
>>>> index c4d345d4c76b..22f66c7f534d 100644
>>>> --- a/drivers/accel/amdxdna/aie2_pci.c
>>>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>>>> @@ -490,6 +490,11 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>>>           return -EINVAL;
>>>>       }
>>>>   +    if (!xdna->group) {
>>>> +        XDNA_ERR(xdna, "Running without IOMMU not supported");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>>       ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
>>>>       if (!ndev)
>>>>           return -ENOMEM;
>>>
>>> I think it would be better to change the return for 
>>> amdxdna_iommu_init().
>>
>> amdxdna_iommu_init() is common code for all kinds of hardware. I 
>> would keep the check only for AIE2 now, which is known to require 
>> IOMMU on.
> Got it.  Then this makes sense.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>>
>> Lizhi
>>
>>>
>>> This has a check that lets !xdna->group pass; which can be turned 
>>> into an error code instead.
>
