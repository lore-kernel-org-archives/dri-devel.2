Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A495CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DEE10EA90;
	Wed, 14 Oct 2026 18:10:52 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFC810EA90
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8GWaFH6VCJhcspPFc7cYXoLa229T9CemZNO12aIUepKtBwlpkGumo98dw40F7nEnyClnFfwcz5qqqNhqtEJWj4uOzQ5vTtOMWLzyDhyj8c5k6Qus6SwhaLdloBLYadAjju+6hf/UA8fZ/qM5NKKTC+JcYDu/pIEQPkTJMC+Ap1ffwNbEQ4fUQC7mSAehOPJYMjsEj2k7pQBJoNho+lNeAV/QsnbM1hSxOK1x6Uo1iKMPE2UDT3NpXU67ASmWbijdX7krtgpKilZWP1QLreH1myrLfJ9DW65lX1bD64fzWtoTv6WgYFVdk2F5oUFkWB8NQ8q+Wg+a+uhBY/wANMcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IEoV/dQ3OogD4olOtvwVZQQPGTpC9ib1Wu+vxl2vdU=;
 b=PDi25wWaofcAmL4Aa4Kz56CP/2rASuERUen7bWWJlog5Ey6Rh0N89y8GLpyW/Ze5UvnYuT/d+LH3KrtBc1GPGwjbKDwfwq1UaDWOrsyRecXC1mBrMH9k8VmCto6LTW16ANDPeUDokJjNMrllNRdFIvqIwFT8rkk41UM3hMtxFFF7HsCLHHKTYmOXi4q3DWL1p9DFr2Q7yXcx3PUJ7YJFQL64iYcjgWobuF1WBIEi+c5TuE6j2moHbGMrzDAS5ulTONRWNQlUSUcAN8C2v/apDcfTZ90GQwBuS6ccxJrP+WzzknKXEbNi3XpE5i1kwELCvjwqPfURE406HJLP82v7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IEoV/dQ3OogD4olOtvwVZQQPGTpC9ib1Wu+vxl2vdU=;
 b=f1vCy6S2mmCbhrKwB9nYf+aYuTKVNn08VGOY6kmc21QSxZ3yDotCbxWCwFPCNMsiCVe/Bly55llfgIXhmVO7fml3gVk1FI1ofzBJkMrb6TWLaDafSIULQKj1snaP/y5KPrGRWCqaxCjdY3AwAaf8N6t4bpzv/LujnL97kzUufeU=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 18:10:37 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::79) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 18:10:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 18:10:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:10:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 13:10:30 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 13:10:29 -0500
Message-ID: <cbd18119-66e8-8183-d951-eccb1c8b3380@amd.com>
Date: Wed, 14 Oct 2026 11:10:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 15/19] accel/amdxdna: Make populate_range common for
 AIE2 and AIE4
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-16-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261009225343.3079074-16-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 05712621-d583-45df-9fc6-08df2a1e72c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: aUkQSbdYkCmZvjsBwmc+dUKjhn1zBYKvaj8Bd4460od7FUXIq8un5raqSL2GV7plw4Cdmd07fCmni3cdxkstYoVDlBlkRAldt9IUxniKEEckoMyBL7zyEpCTI2a+j53aFLYqTYGpgWlpaW+e9v8JzFuxsFWaViHYl2AHSM10LWN3p6JStWfW3pRlu2a5ja+uL5/xjRoSIxx4iC6teDMHYRN+1CFwa6BGRs22Mihf6WF2NPImVmjAfvey1cPZInfBD5VTAMXM8Yqt2X0iDYcw9CK8C8gsTF6cbQNjF3JswYxdaINjinZrZmuuHB/SOBeo/Qr5UbB3zqepnuRTi6dvmFp5Ns3s6/dgBB2fnh9CVEMZlXbNjrjtf36t1sKEmwVw6Vorp+a4M9Lnkt6DJamsJO+4tZ9WznnFLBBKEKhI36xQ68CxxYIY4sqNN4HUVJtpBVRurhgZ90vbKXQVDCiMT4j3svOJtVm873Wb/JYsHnsgTJ7jlqs7vXmaVYi2+mPWbmGDW2eyjzHsfJVjk4wL0bWmHXoRtf8nqy7hJ1HdvXhJHsWDAQLrmE3RjbQadjg5F+1k2iTtwu870JLIbH67prd6mgezr7Odq4d2kBGFdrr+A8n71kaSGD5aWi4uCaTaJl6+TvcI6nByBPHIASNJbdPa0zyGFLpcQAHRI1JK3vo9OWjjMrJXGW881C/USI0pDzM9xzB1AeB2qzl+To6Haw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VOmQ6AYGS//BnDc/gzaevZRlh0Qa7q/ozMo/xvuyVCGXS5VYwm1YAYe6Cb+qct83XG7e5d6YLCuKBJ5CpsxWBeJVpM3NVFUwMryU0LTlOmKou1oeL5QlpyuwH18tuFgq3Y57QqEsEgituWfDkzkujtZOvJfbtd0/Asm889faMdvk41SO4vbk/5b72XfRIvFZ3p0/KBOJdkMkhUNb94wiLH8FpyRvLTeqd8UF6SUdJJ9jzs/r1NGUMGwajbKTVxo1WI4yKZXEqswQUc7pjMhc6BAkaxbRcR8L5dhEOTGYS76LVLhgS2nNGSPKnPjWlEvJIftwbmXxcxnHksY3xf/UB3/L25tjyRL0cCx/V5eRCNeSexR32DByou0EnacAsUzqEupqmU8UivYBZbF72MJhSBb2wpxJX/UN9djHgIQ2E2gW/d0TJrWi+87l9/4K8glM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 18:10:37.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05712621-d583-45df-9fc6-08df2a1e72c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
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


On 10/9/26 15:53, David Zhang wrote:
> When a user mapping of a BO is invalidated, the MMU notifier sets
> map_invalid and command submission must fault the range back in
> before attaching the job fence. AIE2 does this in
> aie2_populate_range(), which AIE4 command submission also needs.
>
> Move aie2_populate_range() from aie2_ctx.c into amdxdna_gem.c as
> amdxdna_populate_range(), next to the MMU notifier code, and declare
> it in amdxdna_gem.h. No functional change for AIE2.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 75 +----------------------------
>   drivers/accel/amdxdna/amdxdna_gem.c | 73 ++++++++++++++++++++++++++++
>   drivers/accel/amdxdna/amdxdna_gem.h |  1 +
>   3 files changed, 75 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 8c1b29964f8f..05ed71e641c3 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1105,79 +1105,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>   	return ret;
>   }
>   
> -static int aie2_populate_range(struct amdxdna_gem_obj *abo)
> -{
> -	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> -	struct amdxdna_umap *mapp;
> -	unsigned long timeout;
> -	struct mm_struct *mm;
> -	bool found;
> -	int ret;
> -
> -	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> -again:
> -	found = false;
> -	down_write(&xdna->notifier_lock);
> -	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> -		/*
> -		 * Skip entries that have already been unmapped.
> -		 *
> -		 * If userspace unmaps the address and later submits I/O using
> -		 * it, the IOMMU will reject the access and report a fault.
> -		 * Ignore such entries here.
> -		 */
> -		if (mapp->unmapped)
> -			continue;
> -
> -		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
> -			found = true;
> -			break;
> -		}
> -	}
> -
> -	if (!found) {
> -		/*
> -		 * This also covers the case where all mappings have been
> -		 * removed. There are no invalid mappings left to process.
> -		 * Any subsequent I/O using the unmapped address will be
> -		 * rejected by the IOMMU.
> -		 */
> -		abo->mem.map_invalid = false;
> -		up_write(&xdna->notifier_lock);
> -		return 0;
> -	}
> -
> -	up_write(&xdna->notifier_lock);
> -
> -	mm = mapp->notifier.mm;
> -	if (!mmget_not_zero(mm)) {
> -		amdxdna_umap_put(mapp);
> -		return -EFAULT;
> -	}
> -
> -	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
> -	if (ret)
> -		goto put_mm;
> -
> -	down_write(&xdna->notifier_lock);
> -	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
> -		up_write(&xdna->notifier_lock);
> -		amdxdna_umap_put(mapp);
> -		mmput(mm);
> -		goto again;
> -	}
> -	mapp->invalid = false;
> -	up_write(&xdna->notifier_lock);
> -	amdxdna_umap_put(mapp);
> -	mmput(mm);
> -	goto again;
> -
> -put_mm:
> -	amdxdna_umap_put(mapp);
> -	mmput(mm);
> -	return ret == -EBUSY ? -ETIME : ret;
> -}
> -
>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)
>   {
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
> @@ -1237,7 +1164,7 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   				goto cleanup_job;
>   			}
>   
> -			ret = aie2_populate_range(abo);
> +			ret = amdxdna_populate_range(abo);
>   			if (ret)
>   				goto cleanup_job;
>   			goto retry;
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index e1b72cef51bd..320604ec157f 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -337,6 +337,79 @@ void amdxdna_umap_put(struct amdxdna_umap *mapp)
>   	kref_put(&mapp->refcnt, amdxdna_umap_release);
>   }
>   
> +int amdxdna_populate_range(struct amdxdna_gem_obj *abo)
> +{
> +	struct amdxdna_dev *xdna = to_xdna_dev(to_gobj(abo)->dev);
> +	struct amdxdna_umap *mapp;
> +	unsigned long timeout;
> +	struct mm_struct *mm;
> +	bool found;
> +	int ret;
> +
> +	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +again:
> +	found = false;
> +	down_write(&xdna->notifier_lock);
> +	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
> +		/*
> +		 * Skip entries that have already been unmapped.
> +		 *
> +		 * If userspace unmaps the address and later submits I/O using
> +		 * it, the IOMMU will reject the access and report a fault.
> +		 * Ignore such entries here.
> +		 */
> +		if (mapp->unmapped)
> +			continue;
> +
> +		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		/*
> +		 * This also covers the case where all mappings have been
> +		 * removed. There are no invalid mappings left to process.
> +		 * Any subsequent I/O using the unmapped address will be
> +		 * rejected by the IOMMU.
> +		 */
> +		abo->mem.map_invalid = false;
> +		up_write(&xdna->notifier_lock);
> +		return 0;
> +	}
> +
> +	up_write(&xdna->notifier_lock);
> +
> +	mm = mapp->notifier.mm;
> +	if (!mmget_not_zero(mm)) {
> +		amdxdna_umap_put(mapp);
> +		return -EFAULT;
> +	}
> +
> +	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
> +	if (ret)
> +		goto put_mm;
> +
> +	down_write(&xdna->notifier_lock);
> +	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
> +		up_write(&xdna->notifier_lock);
> +		amdxdna_umap_put(mapp);
> +		mmput(mm);
> +		goto again;
> +	}
> +	mapp->invalid = false;
> +	up_write(&xdna->notifier_lock);
> +	amdxdna_umap_put(mapp);
> +	mmput(mm);
> +	goto again;
> +
> +put_mm:
> +	amdxdna_umap_put(mapp);
> +	mmput(mm);
> +	return ret == -EBUSY ? -ETIME : ret;
> +}
> +
>   static void amdxdna_hmm_unreg_work(struct work_struct *work)
>   {
>   	struct amdxdna_gem_obj *abo = container_of(work, struct amdxdna_gem_obj,
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
> index 9b4aa21a37c9..977548e19ae4 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.h
> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
> @@ -103,6 +103,7 @@ static inline u64 amdxdna_obj_dma_addr(struct amdxdna_gem_obj *abo)
>   }
>   
>   void amdxdna_umap_put(struct amdxdna_umap *mapp);
> +int amdxdna_populate_range(struct amdxdna_gem_obj *abo);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   void amdxdna_gem_heap_free(struct amdxdna_client *client, struct amdxdna_gem_obj *abo);
>   
>   struct drm_gem_object *
