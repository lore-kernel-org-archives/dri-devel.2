Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5BC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 19:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA5110EEE0;
	Tue,  7 Jul 2026 19:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qLGSXke";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C27910EEE0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiDQnEBjRQ25kF7GET7u4Z1mg/VzfMQrCsIaybCTsgqNt6xTqIZavPYGxmFUZQvrh65l0a1z8MJBsPRg+cWnT1Sf4rl2oQoMAVOqmmREXG2JQndpOkVbyUePRFElQqTc8yoXnpnpXH0HQCLOSachF4hxmpnciSRMHO0+zLSf8goF23d444b6tVuZ7xbbWQ3bV/MIa70VpJOCNuVC2GTAehHkJ95l+w0M9odKiJwEDjntMQP5kXMfZD8zeMYuO84vjH+sGxsAiq2eVG9fIbWLeMmlv5oEWGhSKfe0abtHS2Jaeqc+8IlqMkSRKPDx4ornND+yUpwxOB8k5GzlcgCojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFWfG91FqJCShe9uUd1PABitbsb8xiZCU1DRjc+3P18=;
 b=ahR4npnXP3cgAdvPukB4xSiP90Ec09EozxsD71NkNirXT29FU/7nz+rKyxPibuoMlL7nbv3kyL07//3FMFKS1xhgtBOzJHJKrSZ3XBMNVKq2V4QXYyn7jGlCGNnw4PrIKgU37j6gfpEWscQMeBkf+eCVLJ6lntjsECmxyVV/AMDoahfUSNfJ/S5Daov9pW7OSg7E552KGvLn7CSZXjgc1Lym0H5BuoZPCAGufqt0U/+6dK36oUJxHD7bEKpsxatrHT31ocxJ95VgrMznOqEY70Zy3P1IG8R6Q3BsqaQQSVVSgEqhtjdq+aifTDdY/DDcqZuiBa/P2J0lyI9UXZRqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFWfG91FqJCShe9uUd1PABitbsb8xiZCU1DRjc+3P18=;
 b=0qLGSXke6+DI2SggKzPMLUtdHNdrCH+CkIGCPro3RbAyubKu1U49ZbJNa69MhqL15GAXeaB7+XkU8DRtsJOVwNR2Gfrf0bTlwmZy9Ly+tCA2Xl3y8sxRpvp6bEc4/b4Bsoz/OR2qU3u9CKcETe9ZlbAbODwSDUogm5YxuGL75x0=
Received: from CH0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:610:77::30)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:38:24 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::8b) by CH0PR04CA0055.outlook.office365.com
 (2603:10b6:610:77::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 19:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 19:38:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 14:38:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 14:38:22 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 14:38:22 -0500
Message-ID: <da8a2cf1-b6ce-ec02-1105-3a72cce0e747@amd.com>
Date: Tue, 7 Jul 2026 12:38:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix potential NULL pointer access in
 amdxdna_gem_vmap()
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260707172316.539699-1-lizhi.hou@amd.com>
 <1ce38058-6773-4784-95ea-0c48af4a0b4c@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <1ce38058-6773-4784-95ea-0c48af4a0b4c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: e55d6da5-fd12-4e0c-10ae-08dedc5f4ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: iLwB0VAuD3Kh+652B65L52jkLVhsVh+sI0n44W84FIV163mga8xJrAkhE1eIX8i5+oFwyHPq1uTv4Q0dA+vaG8vBBwV3mLb6ovy5rxz3cQ0LUSoXqEng2FQ4U5W64jwnnIoJTkcK/AugT2qNgFK9fqeiepTUkB721JR7+fc9t0r70EV4V5um1hzrCcglyJzGQHhN8O0wVTkAJQ26hTXv5K8mfzpmZtvbF0NsgwdqXGU5LscPgwUF3FVyL11p+xjUfjfhBAxDBidTboJ4bbHgVSJ9WvB5z7CjixwrbKTaheqI5Mib+qz80uFH/DHYFVKeItmiLUH1WYRw4ZV0rQoJMEnEAvJx5CokgwjYHfLPbyIW2T/nFA9qX3UCbUxt85BsG+4VrDWNyPycvf4NFydOcfnNDA2c74oRrlFR/iuxydw1uLVp44c+RSDFxjdLgxWV+9eyOr5N17oeRYUSgu6g9TJnsbI7vQ/aVHrQVu8xTxT2sH33s0VPHiezwAKjn2+vhzvpl9T0Abk5X4CAGyWF6ZbYgjz73dpv7z4d1BJ3idzlT/4UXNBC+kPesF0C9CXtdNULvdRHqmk35zjobyFX+lIKvTcBcyWaUs60h9JkCDvTA14CPfAymJO0pCCxKW7blAhA7asjQ/F27Y4FRsslIB4dlq0yEITkRseA+kQWpARV2M+71RlHE3TIwr0NJt8Fshc8gg2cbJeoFTvIDARTiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U+kCoSvjdyfxKf6zJOtLwH+n5zAJ4fb3rJPWvxLp0YIotN3WIZv5v/jY3krOQzbLwsN/iX8SaPWQSjYzTgaZ5yuQ/PWDTPJMZpFvTU80/BN/TipV1yqobVcqRhcFLBeYQdwas8aGyYA2CucMGLbuSg1Q5xKgD1gd3y8EjxXaJHRoaod7qBve4cFXZsTuRHmSRRoTCwISADjPeLEmns/8XW6+jyKSI5fVXpdetlrS+eSXk5S0MXradMm4OsgDWQKpvuQU8caigFsJT9OsYw21O4KRM7grQU2V0wAgMI+M/gDG8XrNMsiqTKgWW5Skc3nmriOT23OmObabbNu7bC/mvpeXpRZSjZtIrOmSYwrt+4VTkwP4XkVNftzGC2FlwWYUxQ49a0f1dcmd7IrV8RzwdFxRGjYenr00if+ajMQWONZOfcZYnwXau9EaTw0QSGUL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:38:23.7454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d6da5-fd12-4e0c-10ae-08dedc5f4ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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


On 7/7/26 10:29, Max Zhen wrote:
>
>
> On 7/7/2026 Tue 10:23, Lizhi Hou wrote:
>> If the heap BO was never vmapped before its handle was closed and the
>> user then vmaps the dev BO (which triggers amdxdna_gem_vmap(heap_bo)),
>> and drm_gem_vmap fails — NULL pointer dereference at abo->client->xdna.
>>
>> Fix it by get xdna pointer through to_xdna_dev(to_gobj(abo)->dev).
>>
>> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add 
>> helper APIs for address retrieval")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>

Thanks a lot for reviewing the patch. Sashiko bot reports other places 
which can trigger abo->client NULL pointer dereference. I will create a 
V2 patch which fix those places as well.

Lizhi

>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 64c7d82713b0..5033a0e5c6ab 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -198,6 +198,7 @@ amdxdna_gem_destroy_obj(struct amdxdna_gem_obj *abo)
>>    */
>>   void *amdxdna_gem_vmap(struct amdxdna_gem_obj *abo)
>>   {
>> +    struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
>>       struct iosys_map map = IOSYS_MAP_INIT_VADDR(NULL);
>>       int ret;
>>   @@ -210,7 +211,7 @@ void *amdxdna_gem_vmap(struct amdxdna_gem_obj 
>> *abo)
>>       if (!abo->mem.kva) {
>>           ret = drm_gem_vmap(to_gobj(abo), &map);
>>           if (ret)
>> -            XDNA_ERR(abo->client->xdna, "Vmap bo failed, ret %d", ret);
>> +            XDNA_ERR(xdna, "Vmap bo failed, ret %d", ret);
>>           else
>>               abo->mem.kva = map.vaddr;
>>       }
>
