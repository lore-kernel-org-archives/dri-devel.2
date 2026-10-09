Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896C3CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16A610E9DC;
	Fri,  9 Oct 2026 15:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uh9MD4Mh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8A810E9DC
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 15:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um3UR+ngUBZiNqHG3gfB4Krt/WHUiWNex6fGCbJiRpQXaGzEo6xjutkqmCnF/Xup68dRIaOsniiqrgKq+2zaKKuCh/5OYXIwkjlpyD3i4nuAEkS4NXF+EYYulpucqpV4PKuCd//+YjbIBwylJSpONTNQ3+WNehPMtpjjsroonnvhpSc/nmDlJl6qf9Uz5R3FKw382NexL5vEst97bJMRdVyf5aOyEw4N0BULuncZ+T0AEZZ796ZV8oFopoIN7nzMDstr0s/17lp83X/Yj1OZNiHUAjfIEKc0nZaUsH+uTZuVyKfnVRvOHMyAx/smsWuR9nao35BLsgg5Bq7UPy+ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDutRPGz3QE9EwRkPudDUt3N1XuqFkxhtJkTbzupVc8=;
 b=Q5IayKxengn+YP2Jl6u0KWJlqFEGMmIqREXPYSYu2ZDiZf3a7yifZMQ/e9sre6lR3AdA+V5TVaKxJHd7wVVL1BRmMD0i/B/SOh9zXQywzum3PCIkINkjn5+9QRdK51jRemqjlHtUttkY/kholGYcnkMvwnR1RwZ0VC+dMxSGtDxbB+fT7FyLfArJBGqMKYE6ulmTpJyC/N5lCw0J4/vbwCrfgP6ETjPNhTUc6JAK4EHqN8R77RfY+TPfrSQ+dS3cTBJExmM4U8TCWq8asuAXewJg437yfwpXXKd31ab5edUuWdSjkACdWKM0jJw0Fz0IvNlFldDhgelBP/TyG1Ztdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDutRPGz3QE9EwRkPudDUt3N1XuqFkxhtJkTbzupVc8=;
 b=uh9MD4MhSZOMFgHH6iFIpUQ7DWJIr3a6YoDAKh7X/Nsj4hHT9xjWjtmc+imE0Eu0eyOyyMptAUVUXDrmofS3P+PKBqBnCwWyrDnztJD391XcURqnzypXw1sw27E1ecfn/wJvSKcDbZPa/vWT2XYHkS6Og88O1b5VNcNJUFwMNpI=
Received: from CY5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::10)
 by DS3PR12MB393264.namprd12.prod.outlook.com (2603:10b6:8:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:57:33 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:930:ed:cafe::9e) by CY5P220CA0003.outlook.office365.com
 (2603:10b6:930:ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 15:57:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:57:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:57:28 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 10:57:27 -0500
Message-ID: <bcbfc6c2-705e-ec35-6543-ae5e6ecaab6b@amd.com>
Date: Fri, 9 Oct 2026 08:57:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Reject device heap BO when dev_mem_size is
 not set
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20261008232416.2646054-1-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261008232416.2646054-1-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS3PR12MB393264:EE_
X-MS-Office365-Filtering-Correlation-Id: 9022350e-0398-4092-1498-08df261e080a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1rdmSnHSn6MbL74TdtKqcGYzXNKmKg60nyVJ7UjGLxdUKWuK5p06nq+0eiz4UC0eIXx+CNMwuJHWwgO5TbqHVQX705yy+mALs+X1ruRr1AXTfGXTDY9y4k2SPDle226y4nAKpCYSJVJsPRkWubxVdhPkGgPebKXO9keR8lLLC/T28/AQU76LrkrOFCuajIo0XKUqtPAOLdbe1gHJRPA7taybnqTl0/jOkmpyaH3FGpJ2TFG9CVK24ZR7MbyXawQW/XAVnaOJYTLTEJkPkSs/Cgg2sDSHH1S/wk4gZmlartEClauWMNfbV60TJ7ppffaLwlR/GkVv+IOVYrQubkuw5iJPyJOlSxb2y67XugcAaWo3cXDEMRgvpCHg0aPtUQzbP31wbijzlKye3ho3QXsAGYdYIa7PDeyvCV8mHzXlcbRRqzgpiUJQeglLYQktzPZmB/nhuE8NWIvRRJaAuOMzUlmBuH8BzUBLB08nvfgHV6ZB5op4tCnG3ycSUurI4xwLpxS9m2ra/Gs9Q5LwPaRgjLyOEz/2VMPe5IDrNAqvjJ+R8vaLnf97oKmcOzjEg3MugUB3OUqkgB+yAPVegHNgUEm5HhYXglgXlW44RZrMSYg5Oh1ycqli7Vxozxi/a45e3OBUixFo1/Pt/5PZJ0Pwz2EQlSZ2i1ixFiCq12HB9WQmL0oTEAYhCjiF16D+jD2e07QCN8KG87bm90ELF1NIFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kE732TUHBEFz9LMHKIFbhmQb+7cNNX4bjeTahasuQdPFdge/uuu0JQ6HgWbHf323Oro/DDRm+Is6R/vWhgVtdgHfuUxZ1SqyRC9EqiFH2I1BiytfYUEN3PU9sv09G2wG0WYxePyqwjRGS8UpCOghePJ/Nl9/80D6q7X0v552i92HOYQ7sk/eaAunK74Ea7+3kH4QIewE6QWgaOAH3BojbSQ0HbELOmaPJ/Ug3tVojt1PA+V2nsMqHqtIMnekrXk1YShCNQW+BfS0XWalbtiZJwYE/WtIv6llE2Di/HII0cp67x4248r1ESj56K11h3sz4I9riVMsMoGsn2Wn22nuc4cxMise0g3J0Hi3AF3lPoHB22a34jUiwVKXqMiSN9Vc3fcdw8VwdWa7yXyHZAsoyq54wL5UaaNccgrLKcZbe+7D0L1EN9LPqYRwQ7d2qe1Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:57:33.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9022350e-0398-4092-1498-08df261e080a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB393264
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


On 10/8/26 16:24, David Zhang wrote:
> NPU3 devices do not set dev_mem_size, since they do not use a device
> heap. Creating an AMDXDNA_BO_DEV_HEAP BO on such a device hits the
> WARN_ON(!is_power_of_2(dev_mem_size)) check, which any user with
> access to the device node can trigger.
>
> Return -EOPNOTSUPP when dev_mem_size is 0.
>
> Fixes: d76856beb4a4 ("accel/amdxdna: Refactor GEM BO handling and add helper APIs for address retrieval")
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index f4832337ec31..f14484bc31ec 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1140,6 +1140,11 @@ amdxdna_drm_create_dev_heap_bo(struct drm_device *dev,
>   	struct amdxdna_gem_obj *abo;
>   	int ret;
>   
> +	if (!xdna->dev_info->dev_mem_size) {
> +		XDNA_DBG(xdna, "Device heap is not supported");
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	WARN_ON(!is_power_of_2(xdna->dev_info->dev_mem_size));
>   	XDNA_DBG(xdna, "Requested dev heap size 0x%llx", args->size);
>   	if (!args->size || !IS_ALIGNED(args->size, xdna->dev_info->dev_mem_size)) {
