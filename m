Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CEFCD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C29910E746;
	Wed, 10 Jun 2026 06:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QExtq/XF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A42510E744
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmt6CT1RuiQv9tdw+wNkAr5KiyPs6TqbyI3h6shvtOX6N1lU4SeAc53W4JbzC2ZqhHyAom9kPJVnMTQOqAxjjN8ink8Crl3Rh64xNAvr/STVHbU1ECjyJXYwIr2monQijDZN4ux4z1c11gN2wjgKvOqAf1p/w6Qe4OUIyHR6BltUpf7f/F1FXXlgj0EgCmcd+ygGbSxXR2m5nHI7XPgXDhlDrYoXToIIjdHFXioE+Xh2/j2bSgqqeq+cUE6xT2hvpcxIRHHbUhlSgeQn6Nn85cXL30EQOGEEEFdbeyKhIw1TYHpJ7SVIzEaYe4lFPzvBKjfSTU+5luWX0C8fOMKmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVFEx9Fqwmja3c4GrGRMph++SASVnoGOe8aBR1pHqNU=;
 b=C0Km7AmCQb9LwOgslCS3cnjUap+ZIFvu8cPSL6orqAGwyMnQuZTiiz+PhhSqkxIDLCvO4FGcMoZGzOaT4FTLvCLaAm+qERhAu6PGTginQ6TOIF1dog/EnWrb4048w3jdyM8IRy/v48l+VV5WTFuP8jZ6xaSJFufims50/7cDfufo1GCnRAe0jwT5bpA4XPSUm6TOCICXJ47UV1RNXmwOcR9UyN7ZyYY3WQ7sjaPOohJAFWSR+Ebgf8Fcqb92IBuTA/zYKUmXeJupsbKn+l6ryXWBQNoeuWqJfwHLOyhDahsSAWSu0YtEcG1/WVsM9RpivyvpN9A356jmF7rjVAYqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVFEx9Fqwmja3c4GrGRMph++SASVnoGOe8aBR1pHqNU=;
 b=QExtq/XFeGP8tfo39VHONZ0qMHDgNCX/E69Ns2UUADARADC2YamV5J0iOoaGpi05lvvmA8qwtG0kprHx8iVn4NjKDygcnTCWAbQVp/oZXn7YvbcQIlAQxh1f4zIUsxSVNZQ4rh/kpJJz8tduMeIVdYh9eFe3msiyLguF10xsEts=
Received: from SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:25:51 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::52) by SJ0PR13CA0033.outlook.office365.com
 (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:25:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 01:25:50 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 01:25:50 -0500
Message-ID: <e4baf435-fa0d-2674-a553-67697683d40d@amd.com>
Date: Tue, 9 Jun 2026 23:25:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Clear sva pointer after unbind
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260604202815.2425882-1-lizhi.hou@amd.com>
 <77abee6c-922c-4079-a89d-35fa285df49a@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <77abee6c-922c-4079-a89d-35fa285df49a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 8300c697-1558-4cbd-32d4-08dec6b91e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S3PvVdFLMWyN1+p5+f5+3pT1jW0IEHznvOyje1QRI9EeUDdPp42JkTAxM5jk8OXb2ZmTOEMB+jCH0ZKawQmklBiGZ5qUCD/WC5lOsFlKSFSdHZW0I16o9Z0ex1gfpbW3BzKvDz003IpixWgif/jcyEUUrgeffYJtk0bYsoQr+tB3SN4AkXz5FAHjJ8Yz3PYcZY7KbLCwWHpVNAtUw9iwgAqX75jnX64ZYUokk8SlCQVUlgFB9ju8rwxbyrntBX94YUd9SwvAueSKxbo3DXI+cj4eAJCQMdfDxStXx0iyc6802KBaCD5sS/hGgcbJ6EiRpiOczZeIEgzoLsXWi7X1Wdt1d05TZiST+Gv9JH2iiq75NrvPkh3HFmbjOpvPWEaOS6EzHURW4D4+srgl8F0400t3oyN/tiI9V2YoFN2T0yfhJIyPdsfU7wMTX8h0mVZReVc3wq96RbMW4JH+JrjUPkDXNsEF4/fWr9kHIaAg38gdQRbSNCxmt2vzHZhI9hpgRglUhyx4t0jcFvJMRedqC8TU1K5euSOnOcnXfWxu1bYMy+CPbaOOPyHnpvPo9O+i7GScDtRK99OlEVQZoVVZiArSKdJ0z5HhGACdmZlNvHpNxSiI9TcmVP5HeUCOoIezUc3ZehkzdLpK6kCRJhKVb8oY8EOy5IYSls5LSVBPBCPudeTosfzYnsF/TJ+/kuyp50jyyKLvDBd/PBEwZD8cuM7yxtONCbqMIPNrH3YDihY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +sh3V0F3dfZ80g2jd0qbygayNmz4JYc1Ef79PHBEwwcSEQdHvS+aCj+X1rsMBv1aoIp2Ctowv9cpjHaLJRvRC4VJU25QyVWg/pdmpek2fABdcGNjAcXSdswEjq5PwmLhYP9NBKaHDRxUYHL8VdQIEfOIdlKe/tPzRBul7g4+kvCFwXlvwcZu7aCV4qvw0M+iMTFOxsb2xCxNrVFyir7ddqNK/6re7iVxh+/5f0R8GLDc1kIHx8JuZFwcTGqV4PpERmIWJdAlm0uEav3r3ZOdzVlaefn4Q5KWH849KdaTPtR19YG6L/Oq3glvn+Vb/vJsb3kcaV52vvhU+YK4hE7QPKQK1v2c/L6A/CMtD2MbddGW0HhTpaG93jZ7PCaa6c0PfcfT1F/2vSAjUgOo6q5gwEmnd4cdqrgN9vMyYe0wB8t+mjU13xPLeBMt8SMALUcy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:25:51.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8300c697-1558-4cbd-32d4-08dec6b91e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

Applied to drm-misc-next-fixes

On 6/9/26 15:44, Mario Limonciello wrote:
>
>
> On 6/4/26 15:28, Lizhi Hou wrote:
>> Add client->sva = NULL after the unbind makes it consistent with how
>> amdxdna_sva_fini() already clears the pointer after unbinding. The
>> IS_ERR_OR_NULL guard in sva_fini will then correctly skip the second
>> unbind.
>>
>> Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for 
>> non-IOMMU systems")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c 
>> b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index 1f066ed8d236..65489bb3f2b0 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -87,6 +87,7 @@ static int amdxdna_sva_init(struct amdxdna_client 
>> *client)
>>       client->pasid = iommu_sva_get_pasid(client->sva);
>>       if (client->pasid == IOMMU_PASID_INVALID) {
>>           iommu_sva_unbind_device(client->sva);
>> +        client->sva = NULL;
>>           XDNA_ERR(xdna, "SVA get pasid failed");
>>           return -ENODEV;
>>       }
>
