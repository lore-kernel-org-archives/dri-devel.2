Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD5EC88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC6910F67E;
	Fri, 11 Sep 2026 15:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AunyIOZQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E753810F67E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmLXTNFFRj/fJ+c2FeE5V3vr2Iken3svugoJDuek5ucc/0q1kZLO0MiMh3/Ar1QgglbVeq8R3vCKCuDtfHAjeI2hFnOgnC/uDPyjIUfWyLSd6prcQ2CNWgEwY8RkJgZBgCM9vopEeSWkL6X9XZghsT7XswX7BYWRP1XqEwETHMQVFQpM2m44SXBbWotHmRjAn+N9TKMvNYL1u2JfxKqIxQYZWHiL8tiQPm7odq/aofNPnv5lpaZm63LUOvIdcvGZBKxkSItmDtf1BX2YWXiSD/OR1xuedrqwehDDeSWxR60MEyZTkaiG89iY9FALDJz4fqiPhnSKl5lThD/1/gaMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er1DCqmVi6rnDTQqo5M90hh0iC3zHAVclOpDEVMa+co=;
 b=sXZsEX9gZqGjITSD+lNrwrgUWc/F5iSyjRsJUuzDs5Imy6DNH3G6htYL/zp2BDT86Z0KDvyZITWc5OcKBhcFmyw97GBQ5MYdduqjQSg3qpz7gi1GOKsdYFPiAQxbwlTQ01vRrqiHSfaEfTf6U6XZBst4rO6m7Z1vxQoMCtONeONfgZzFmue0J+EERdL7yj3G4w+RxZdDsTz1EM8kc+qxtN1LeReuh0W1ckhNYoCO9eKnjpUBhILI46WzOvU3Uv+KnljbjxxtyJe7oWVOrFhh2i2QxoskPGp+DSNgrp0KoeougE8bKRZX7jxGL/3s3pQjAO4SKk1UKY0YS0QHGV4DuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er1DCqmVi6rnDTQqo5M90hh0iC3zHAVclOpDEVMa+co=;
 b=AunyIOZQgEBhtl9Wn/DYE0e4gEk6BNG99ns51MZvn3M5p4fu6kWh3+PZGKjm5TNNeqF0n1qnhuVmnb0n5xl5mzNezHnVrU6YS76pRS+P0WVJGz89RAZbXmJ4baUxPIIwLVQBBWUtwcWwRPIKhhrKjgnpRMfrgzl06BbI/krE660=
Received: from PH8P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::32)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:24:50 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:510:2db:cafe::66) by PH8P223CA0001.outlook.office365.com
 (2603:10b6:510:2db::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 15:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:24:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:24:49 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 10:24:48 -0500
Message-ID: <2e8a565e-a204-6833-3bcf-9220508e2903@amd.com>
Date: Fri, 11 Sep 2026 08:24:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/2] accel/amdxdna: Disable BO import via flink
Content-Language: en-US
To: Max Zhen <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <mario.limonciello@amd.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260902180955.3999242-1-lizhi.hou@amd.com>
 <8a526163-0762-4be4-a827-b2c11fef5959@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <8a526163-0762-4be4-a827-b2c11fef5959@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 77216d8e-69c9-46e4-d5df-08df1018d1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 2W57Cn+EDg4zPsWEoKH4/rqGzeY2g0fJvNoANVqxHaKYcS1YNI9VJkexItV1DfCAN6/JyM+n3SUhLZRDvTcmyIEa6pouG7zhdU0fUNmNrM6rMwML7rr87wHvikl288w47WTggRwE7mtAhLC2OR8zFiRQkq+eGAl/Xv82GSkoZ3BJVr7RoJrikQUmJj/2WvCz5ht9tWmVr3HAs187FG2QcUSmwMGgYObGAborHugVKDgJ3YyjvP1IU8voGK797KEsVR6qcY23igNTJG7YOzKHSYDShM19lXZScVOImMWgVSkLtQWXDs9T7J5E5tXbLrU7JUcu95URHCWjBuovNelugQQCGHXD/miq5vF9bQpZN9fcZchL6bgQMjucclf7AwcbXoYZsJbMuna0lluKOjFd9RXETZATHh/TI7ZirPB2rojPAIhs31DfTLVfS74N1Zh6DdblXwnUTZV4uoogtPeH00ZUISBCNv68TV63z+tkJ7NonwoL2LM+WO7AG07qdsWp8tNlbutV602LVev1ubrwIxM9TcbyzTdDE9dv2232CUvfjTvXPu7FCKqXcnlF3PqC16/zJlqc/m3DFdxBmgkN8l22si/efhT8T0T31aU0kgGYSJ0U1Sfka97chHBhAurk6Ikg4mmMTfY18CUAD84cizZB9o8tKw7xyMuWCelsVEy966SzodwKYBcCI9/GRuaWQOvop5927kGFf503Nu/jrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vzNzPI+O0cCH15i8GGWFyOCArqfrvcd21iKNgu1bQmXOF4Ec5a8mxasBheCv4zpeN+sM+12FlYpC9b2vA4kV6KQMZJNkro5slfB9rMljDWfkCkd/Ahz0wX3Me8CdcBTAKEAOw9xfFaCgCmoQfXwg2JnG/+00WHmQNJBCWCBlO0t2KaAnLZXLe8WuB99Iy/CqjXoaZIvOJdMzctPnK8jbpOJprAP6dKH5VHftkuz6mb0kXUoQP9aw+9Q/KdG8aDgcEtP9iPPyq+8UoeQ8GX5GaiS2BNZTygp8kjROGwsoqaC13GsOvDRa7oa4tVb4PKNeXY9p+YnLLabF6j+RDer+8exiiQqOC81W1DNIPZ3O72DXWMM286fN31kTAmBEDlChOzxs+VPj4449VzF/fFV+72aMXaEKqQ8puRwG2xHesWsJpffnX7FIEv59z4ewUXF2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:24:49.4595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77216d8e-69c9-46e4-d5df-08df1018d1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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

On 9/2/26 11:48, Max Zhen wrote:
>
>
> On 9/2/2026 Wed 11:09, Lizhi Hou wrote:
>> Accessing abo->client in amdxdna_gem_del_bo_usage() may result in a
>> use-after-free when the BO is imported via flink.
>>
>> Disable flink import by verifing that filp->driver_priv matches the 
>> client
>> stored in abo->client before accessing the client.
>>
>> Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for 
>> non-IOMMU systems")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Max Zhen <max.zhen@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 476649685e5a..1353393194e2 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -697,6 +697,8 @@ static int amdxdna_gem_obj_open(struct 
>> drm_gem_object *gobj, struct drm_file *fi
>>       int ret;
>>         guard(mutex)(&abo->lock);
>> +    if (abo->open_ref > 0 && filp->driver_priv != abo->client)
>> +        return -EPERM;
>>       abo->open_ref++;
>>       if (abo->open_ref > 1)
>>           return 0;
>
