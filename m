Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDAECD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 03:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6776410F1CC;
	Thu, 21 May 2026 03:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vN60MTsI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577DC10F1CC
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAtVeZjK0RY0DJpySGIPOZtC1mbM7fCxClB9ChD9Or7lvjDqDWHsH97kn6mivmxOWzV31LOrjJwfNso/gCSANoA+iS3mxL1Xe3QyvLLbADLWZaYtyvxl+0CEOiOWH8l8l8aMUGs8X6uSJUUepeHPTk28kRWSS+nr2c7XMdwsMcbZe3fq7aL+POVNLSNPyYjHm4N5jBqebxVZmXGvBdNqdvilldgMytaZ6lZ7ij8uVj89xrSVKDHPoMNksSQURzhboLDKEYxzPrtRnN/qtA4cJazm8vfaUXKOWbYcAa2Z2O8K8qWzWjZ5QNn74x2oYNllS71CX9q60YaSC03AJRhC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65N2xu4dJeKbNwoAABLi9IR0zf9b6/6CXJqhXuUaTsA=;
 b=Fp8LjZwGYIE3E6wxNZ1jjNWnJEVwMQ+LWWQYDH3aJxkZhpJbQRykLl1kBfAbx1ZrlCm37gniVTvR94ejrnFSfZgokGY7KjBEuPuKZZu5I3oqmr825unWpzkCAQlBNV5zcp9R/WILW6DgD134RH2eOZnh1DZf3OAZkEXKCwmAlzZ0yNJXBJJZRZTBd2kMEncCvx+orl11DN3WqRHpaGStD+DcaRNkUWqIi+yNXH9rm0d2WhhSnFhdyMTq7B5jiIoSb4L29MC2xGcjEYJf/gFqTQuIQsLrgUAx3iHUAfQz7WiwKQaGBpdY3XRRrfuk0nbTGXPcZkX0M6tFpBjCY3eYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65N2xu4dJeKbNwoAABLi9IR0zf9b6/6CXJqhXuUaTsA=;
 b=vN60MTsI0sbtJYnV0L6aI4P6NNkyakKO268N8zv+UzqoTcxo33B/msV/rA9CsyCdu5JYfSDYPUthKDHI3Swn1QXzKsJdsnacJr0W/NByXZEbabxJFsi5SpuafxFcujaCInxlVQJvGPXGYlquslzNnc16v9nyjGNCDXpV+pKnHmA=
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 03:43:42 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::c3) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 03:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 03:43:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 22:43:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 22:43:41 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 22:43:40 -0500
Message-ID: <88097167-1bf9-235a-36dc-467207ee63c6@amd.com>
Date: Wed, 20 May 2026 20:43:40 -0700
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
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <c0018792-7867-4fc6-b64d-7e0fb8717f08@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e84d0c-f25d-492e-ae7a-08deb6eb26cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|11063799006|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sCz1kVOYnNvNoeGGrYNRoYOfVlIHYqKVac9EtSxsx9tDx3J9ozD/zzoqmIX4HnzjmXbs8wu0S27vq1Oee6wZvK+mTpM0DmDMEKt7G0ssnHdkDQWSK70T/2EnkrJcMzYp3MPyQWXpwpXOPkRqcrwmrwYrd6t/fcwf0ICjtwyPyQvq3Y0BEV6qqKoXLTPUt8oQfObIcA+lkweptouwP8LONt50aInkABOvaBe5RECIaG1h4p5WXTFnUi1yCd/1cx4cYyUeFxVJOFKF22HgSMmyVQAmK8wlVrEGDS6ck1P3miUub3TbwAQg8oq0tyN7UNGAvb/fuK3etUueXaNK87sK8FGJ5ktWFq4uA9d2Ra9bcQTiJ8pSXTEatEzaTNNxnvr1JyhVuMga/5HUcVYB+tdG8IK3CWrzJFP1oiWx4CWD/OvLkTNsl8YjKTup3oIzTA3TdpncJco4iJ3giAjfot/lW5fbjVl4aWvbZfZ3HtZGfx5fAHN7uc5U9UfxAG7h108UGJTRuh/o9MeKDLAVimcPSCou/IoqgZqEwFwXPs3WTik0EYAMqgLjYZ6Mo5DWLb3I3Q8TXgXvTeSNtbQW8XMg8wtg6ao0VvGBu2Fv1MiRCIn6YS3hY9Ru7I+km4Zm57lYDwM+tfz8WfRRs92RkHaq5SQE+bMwrEZCHlUv/nbsMiAQaFs8ZpKO/kM77LsD+OBo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(11063799006)(4143699003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80KmJOuk00hdIROZhN+BmXHshFk5A9/5jaBQg4o6E17SU/qPU5vH/IAwy8e9H4okF6qVIXV0uTi4jQNe3EEMlideh62IS1pbLaoluw3jV+5CvdF7my0XTZ0ORQRuGkuQnetGK1NOs3byrWd4tpB1o5Wtz6Qy/kJZLJOOapVmUU3eoadUyrhA8wmouy3wCq7/9lx23pQPN8T+dmj9eVubHmUQI9cdYztm03ujcDj/hVXllBWMhbxM3DkNl0uEeSyBUiLp6K4FmaeOExV76Wgmcl5amQ3f26gulHyRKKYxQ5uOylojFfuyCZJctC9b+YZjOwJuJHPcyAvZWgiwJPuhngw8I94gWnrgaPuOS89y0DGsM4zewT/f3cMbpEcI69w5qT8o47QnONF2IYs/NXOJReyI+eGqDicnbyxzyOFZDLhN9q4zRTOgKs0nJ5OTLtVr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:43:41.7024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e84d0c-f25d-492e-ae7a-08deb6eb26cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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


On 5/20/26 17:57, Mario Limonciello wrote:
>
>
> On 5/20/26 17:35, Lizhi Hou wrote:
>> The AIE2 device firmware requires IOMMU on.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5319
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_pci.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c 
>> b/drivers/accel/amdxdna/aie2_pci.c
>> index c4d345d4c76b..22f66c7f534d 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -490,6 +490,11 @@ static int aie2_init(struct amdxdna_dev *xdna)
>>           return -EINVAL;
>>       }
>>   +    if (!xdna->group) {
>> +        XDNA_ERR(xdna, "Running without IOMMU not supported");
>> +        return -EINVAL;
>> +    }
>> +
>>       ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
>>       if (!ndev)
>>           return -ENOMEM;
>
> I think it would be better to change the return for amdxdna_iommu_init().

amdxdna_iommu_init() is common code for all kinds of hardware. I would 
keep the check only for AIE2 now, which is known to require IOMMU on.


Lizhi

>
> This has a check that lets !xdna->group pass; which can be turned into 
> an error code instead.
