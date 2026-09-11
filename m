Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6BBC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 17:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA7610ECAF;
	Fri, 11 Sep 2026 17:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nstRHO//";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2CF10ECAF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 17:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRb9dWZV0WFB2NEdLB1xAPbQSJXSACTXYK3sxdS+8Q1tAbm4PPVS+LDIdkzRdMmL2fg0mGUznxaFJHOcPs+4yOTHkETtx58rNyhb7SSqIcTyvh6B4qTKkeaLA3rTjllNpMqyr+WiE/xgm4CZVRLh9nPrY04kMuPRIItJXyJbN94rfxxsFA/y5l7bvqsSHK5ub5wga8ekX6/P0Y+2yxfTHe8QxfUgA71Ib7CDj4HMxvn02biFH6dEre04woPbkHGBoDJ0r+QLxVb4gZsRn6eoXNZ5cJN78vXNKQxGzoHou55kH/TgUV/ztoiRObplftu+py+R3tX9OFJ1q5o3CMeQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvR06hpwlQRanhUBAskef8C8aU14BWP9Ag+3VbnUwMY=;
 b=ykQ1qlNeUaZUj/o7zPJvKVNX40r2G/M+/RGAqjHs/Oh5xkA4VfU0SZQilli53fSv1eKJcjbF4Fc3o6itylfUUEQ1Z57Iv4ccG/sdkJDiXqaY2kaBefU7a+YUHq6hnsIRGBQ0VD4Jk3keFFDFwivby2GXFvLrV3+sn3+NpyeEjFGS1iELUuiW6S2uj5XjEjt879K/8x6Up6NbOprjVwFVWCYute0h67aI7DX0Egzu0AH818mvzC9UPMsSVBxuLeCUNijGhPV9/VQV71NipX+LbWxFreK7szx0K/9zyav3qgeJ0JYLM5Prl7GLc8Vtu51QLyZDvyRRQS9ZtdXflDpBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvR06hpwlQRanhUBAskef8C8aU14BWP9Ag+3VbnUwMY=;
 b=nstRHO//0LB/ZoE3ZI2Eq8IDrEGQvZ0Qj2+Qb5TVw7SGZ7t7JdLvwV2CRxvyYSaXlzOBZFpfOv0WoSwxKT7gNLA2AsYr2LKERsleMDVqqvEgPpmHTatqSHQMnryAalNECR9nEE3KYU8Ivm6WBCFbAn4Ov8vSUqX7p9DcE+CFDPM=
Received: from CH2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:610:5b::40)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 17:11:03 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::4a) by CH2PR07CA0066.outlook.office365.com
 (2603:10b6:610:5b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:11:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:11:01 -0500
Received: from [172.19.69.155] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:11:01 -0500
Message-ID: <e8e52df0-c0b5-4823-b5c7-58ef3d341818@amd.com>
Date: Fri, 11 Sep 2026 10:11:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fully initialize map structure before
 registering notifier
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20260911163907.1193852-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Max Zhen <max.zhen@amd.com>
In-Reply-To: <20260911163907.1193852-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 663c6bf9-b8dd-46f0-3d62-08df1027a838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|6133799003|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: 8WGEcHqzJ5h4yMNg2wANpxajXX0fYIgMc26Cqs1pBwXTfiyMZ9bDrmcjO/1joNa/Jz7NqzNa+hNbOSZ7WSsaufX77Cdb45584Pi412kiq9gL5JLZdgaldJoQypkv4Nf2k+5rN+SkhnlIj3tPpMFr5KgYxI1BMxrUXI+O5fsr+d7x15yoESLE6VaWc598UyOE0+4kVFKVmAK7vKIEoSyQf5vq1i9ySkR9XYgu1goqZfHg5/hvet+s8coZxAHYwJoqNFBiz2IcEEcAXdunFN7dx/yoUEAMQQxmsYme3bFqfFAF6mLdVIZQybOLx2VXJfRGAXJXW//jtIwxY34RonSMKCy/ctGpooke6yzyw4lla2OeauqCnbUHc/7IhEcHpt1q/2r77NYDnLexbWTaW/VbYGSLx0fbaNAbhDWaC/f27IjUYCv38K0cGeU/7D6sJg8PA/Kpf18o86JSGLhuzyYwbdQqvdg/Q2CLLGXwhK7cfA65SkRoCf8PkFSOqKW5zXby/3GBfXKkAoFOnUXY1pyb3xpDiQ2glgwf1fluRTDHPzSF0g/QlwdYQOyBkbJVATCWExC45W+dwds8J+Pl5lDe/SBQcg0KKd/emLnwWOywzIbuutXq+3vGikVdEm8x4iFVjvOS+luUDwLr5VPYHeAl3nz7VMbO934/9s4+c+u2mKt5DdJLOWjUzF32EJD5WNQLEkwxyUMJ9aHCpF4eSUobPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4JmOLHCUne4ibiXgL0evwRVE91gWmudJkVsQpIWabj0LRrgshh1PkyaDxyaro9b7kx3cs/vqNuK6P4RQfjN/9vobC0mnmENvni7pm3xKZNkw8nm10Kc2Db/HMjclyRgklvJa7bU6oSU2dmieBrJwFrSoYDATpB8NzkN0nYv76kortBrNHEFz4t9znmgK/z0JhBdbwkoed0E4vEYoZQnAZeT3gVzKy3n5WSkLpu0pCmNoDNE5jUlFuWG6RxQgfBfWTKajBnvunxbLTDqeCCE1q65eI3YdS6N8IpRAvS9CyBfwAbt3GYHBZHCZY8J02r4raSX+3dDDElT5FUmyHJih+URrPrGsPb+bAuKm2Lhl7b7C+WOAGVdsoIRKIwoSnRmB4ReHRp0mk9mjEunMRyohE1ZHnTtuo1RugSyyz13kgae0w/Z4vNr0ekxIhS0Q4ykX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:11:02.1500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663c6bf9-b8dd-46f0-3d62-08df1027a838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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



On 9/11/2026 Fri 09:39, Lizhi Hou wrote:
> The map structure is currently only partially initialized when the
> notifier is registered. Although holding mmap_write_lock() prevents
> the notifier callback from running before the remaining initialization
> is complete, the ordering can be confusing during code review.
> 
> Fully initialize the map structure before registering the notifier so
> that the structure is completely constructed before it is published.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Max Zhen <max.zhen@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 5a1a2ee261b7..e861db6f9369 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -415,6 +415,15 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   		goto free_map;
>   	}
>   
> +	mapp->range.notifier = &mapp->notifier;
> +	mapp->range.start = vma->vm_start;
> +	mapp->range.end = vma->vm_end;
> +	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
> +	mapp->abo = abo;
> +	kref_init(&mapp->refcnt);
> +
> +	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
> +
>   	ret = mmu_interval_notifier_insert_locked(&mapp->notifier,
>   						  current->mm,
>   						  addr,
> @@ -425,15 +434,6 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>   		goto free_pfns;
>   	}
>   
> -	mapp->range.notifier = &mapp->notifier;
> -	mapp->range.start = vma->vm_start;
> -	mapp->range.end = vma->vm_end;
> -	mapp->range.default_flags = HMM_PFN_REQ_FAULT;
> -	mapp->abo = abo;
> -	kref_init(&mapp->refcnt);
> -
> -	INIT_WORK(&mapp->hmm_unreg_work, amdxdna_hmm_unreg_work);
> -
>   	down_write(&xdna->notifier_lock);
>   	if (list_empty(&abo->mem.umap_list))
>   		abo->mem.uva = addr;

