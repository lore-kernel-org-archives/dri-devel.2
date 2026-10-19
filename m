Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442A606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZB1S4fUq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D9110EA7E;
	Mon, 19 Oct 2026 17:04:16 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC22310EA7E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 17:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsXwax4b9Wyd0IDnfOQFGi/QCUnGgf350vpiIZ4hbAR7MIeD23HS9COkL7/1jd8U1cTojSP/l2XYsXzBg985xfChIhL9hJwpmBtCUZh00AAXUbkB5Zf5CvMKTbr6ZghbOqWdVvvnC+BlJtd0TK+2ND+EO4eUvPe9qJ8JeuEWXzpOA31dpnJOmxF3wrE7tUo/5W8vOyahTGH+6pjuojhT5gZE1ls1ubgYPTizp7vPTGbHQnjB8D76VQrTEp6llWl5fbTBxaih+DRiZzmKvRMMMFJkf80OwmwrFtkyI9SdsW/uP3aEXnJJKSW41g3/2J4kJiympX3wa4i7bSTMcD7lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnsXX21rMe4Aa+Xef7Ubwo1TerT0QV1dBqZfO98Kc6c=;
 b=PRdNawGrzwdf3mnau3xOBluIdpd+9ADTRt6p+3e75kPXQLox/A3fnoaVY2TIotc6q7WHZx1Igw32ILUCsqkzSyYeQA+8idaZ51xZpbL/1OJCJjTRb61Vuzk5y/tR49JqxFsRlieeImY96XJL8C8nyQMVmd306K11c/9M6jvOZXR4Fu6CawYRgGstnJGspwwZd6i6FzN6yD+bcGX2NC5kDEFAaKdk99IY0JR8guYilLEahZivrrNdJR58Jrwbxdibr+ThSFlx4g5Sx+DylPOnkvJGGKfTHswj3Zdgmx+aHg67SOIF4SABk3ce0ByH08+3N+KuzAEjxgBdOuIPYtMlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnsXX21rMe4Aa+Xef7Ubwo1TerT0QV1dBqZfO98Kc6c=;
 b=ZB1S4fUquI+AfZTnAKitMtpITRFG8E9YnP0PGll2i78epKc1RZxCA5S2qhEM14BZRh7b3BBeKQI+smn7GaWwVbmBABTKl0wV70dd4mtXDiEa4vPK1X41nWOZxY375SDAl0xlTIg7RmREnJuAmXIqSU4AGmAOSo2kWwBXwLUz/D0=
Received: from DS7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::15) by
 IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 17:04:04 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::a3) by DS7P220CA0047.outlook.office365.com
 (2603:10b6:8:224::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 17:04:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 17:04:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 12:03:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 12:03:54 -0500
Message-ID: <ea571031-8265-5b08-9a9b-9d623fe2191f@amd.com>
Date: Mon, 19 Oct 2026 10:03:56 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V5 14/19] accel/amdxdna: Move HMM invalidate wait into
 common GEM code
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Hayden Laccabue
 <Hayden.Laccabue@amd.com>
References: <yidong.zhang@amd.com>
 <20261019164746.827277-1-yidong.zhang@amd.com>
 <20261019164746.827277-15-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261019164746.827277-15-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a96933-87f5-4890-39b9-08df2e02f9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 9XRR+diXXrmGqHiesLM/o8moHXashCUMS7qfmmazRS2dLE0Aw9fbNjKVpSQIOZjpwweGdwVvWPCkNmKE6+YVU6E72p9WqFWTMP+wuJQy04koLiC5jeW11COYsUVZ06gsb4wgywb5zArv44tX4cHo5rVqApMfknKwypIP6wr1gxlXGhK7JHSqguj8bsVL7/qTyTcpteJLfX1r0XNWznWvLWsbH2/Utb/Gtow8je/nYy4+UhR2Uyuo0P74W46n1KPrncSiyPBY3YRwktXk9GFYEURw6XSZNYY+dsQk3Hm8prnKJqsgrk72pxHpK28fDuJoL4vOgcTReVGKdAALem4SzA1oImCruMolh3+yPsVzKRBG1DmjCyaSEjHMxBc6NIt8atRl2hn5MTRhOxdiz6eRvBQlpVgZFlm4ZOWtKNZCrhXDQ6uyR+zqFYRsFD83mNrAEJbnM+3iF/A2cD2pcxAMRnAViYcbrrMHWbSIg+lbuMeUevwelAjzAyEIMy16Tjl05yeiYGxb/FCJSCAebgn4VnmuneAJTiJC14Uq+MIWwL6//vMQlht0bHdPV5nPzlmLp315s3ghWwF8dZXE4nD2cgEnlYCl2edGrCXXhfEgydabWmhiuUCUT4FUr5qTxeMtUB+LyZVKqRGqnFJo3ErRZ7eVWl6OLWpHviwMPE9XNh/YEmvQtrLqQlGLEe2p01dF9cgoEwmbtjxdQ/OF07yp+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wOLStMDKMbxQOjTCQh5sfG1Ae1X6B1z/xhejQscFH+SpcVWfnnSqbYhJbNca6gC/Sk/FAmCRlB//t3I456jIZctxDqwyC5VqRcL2NColOB3OcCfoyGyKWajEthEjYyCU7Vu5973q4ByXW+jc8ysFK28K7HwPG8LlcAo7r2Rqh9R52yN97jTVWxrO5MaK8TGIMqKE3uGZqS3eXa6YMldRQikJPs4XYLyONkFxvsqGR7USYd4rEWf1WG8pGTrjjGwxN1WpmNTZFv+3QzJ9GZCM0CTRaMzYIDxpB+/rhNaFO9T9QZuIlLPOpjUY8yWGBgwq7lryquQ9Qgheja9BOgw/VHajOKJe0lye1XQnQhw1xhyViVDujtegqc2owZPt/kPmox8mt7hdjOT2iMe1/X1VU7ccqhdkrXC1zsxVgrSyIBMcVyWzKmVgh8GVIl/hxOj2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:04:02.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a96933-87f5-4890-39b9-08df2e02f9c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/26 09:47, David Zhang wrote:
> When a user mapping of a BO is invalidated, the driver must wait for
> the BO's reservation fences before the pages are released. AIE2 does
> this in aie2_hmm_invalidate() through the .hmm_invalidate callback,
> and AIE4 needs the same wait.
>
> Do the wait directly in amdxdna_hmm_invalidate() in amdxdna_gem.c and
> remove the .hmm_invalidate callback and aie2_hmm_invalidate(). Devices
> that do not attach fences to user BOs return from the wait at once.
>
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c        | 11 -----------
>   drivers/accel/amdxdna/aie2_pci.c        |  1 -
>   drivers/accel/amdxdna/aie2_pci.h        |  1 -
>   drivers/accel/amdxdna/amdxdna_gem.c     |  9 +++++++--
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |  1 -
>   5 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 6f63a8f94215..1c3cc32f119b 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1288,17 +1288,6 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   	return ret;
>   }
>   
> -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo,
> -			 unsigned long cur_seq)
> -{
> -	/*
> -	 * The pages must not be released while the device may still access
> -	 * them, so this wait must be neither interruptible nor time limited.
> -	 */
> -	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> -			      false, MAX_SCHEDULE_TIMEOUT);
> -}
> -
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx,
>   			   struct amdxdna_gem_obj *heap)
>   {
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 1b029d33a24b..690ad035463c 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -1228,7 +1228,6 @@ const struct amdxdna_dev_ops aie2_ops = {
>   	.hwctx_config = aie2_hwctx_config,
>   	.hwctx_sync_debug_bo = aie2_hwctx_sync_debug_bo,
>   	.cmd_submit = aie2_cmd_submit,
> -	.hmm_invalidate = aie2_hmm_invalidate,
>   	.get_array = aie2_get_array,
>   	.get_dev_revision = aie2_get_dev_rev,
>   	.hwctx_heap_expand = aie2_hwctx_heap_expand,
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 709e7545c65f..13391275df31 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -272,7 +272,6 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   void aie2_hwctx_suspend(struct amdxdna_client *client);
>   int aie2_hwctx_resume(struct amdxdna_client *client);
>   int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
> -void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>   int aie2_hwctx_heap_expand(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
>   
>   #endif /* _AIE2_PCI_H_ */
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 37bfa5058095..0af1506f6363 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -12,6 +12,7 @@
>   #include <drm/gpu_scheduler.h>
>   #include <linux/dma-buf.h>
>   #include <linux/dma-direct.h>
> +#include <linux/dma-resv.h>
>   #include <linux/iosys-map.h>
>   #include <linux/pagemap.h>
>   #include <linux/swap.h>
> @@ -249,8 +250,12 @@ static bool amdxdna_hmm_invalidate(struct mmu_interval_notifier *mni,
>   	mmu_interval_set_seq(&mapp->notifier, cur_seq);
>   	up_write(&xdna->notifier_lock);
>   
> -	if (xdna->dev_info->ops->hmm_invalidate)
> -		xdna->dev_info->ops->hmm_invalidate(abo, cur_seq);
> +	/*
> +	 * The pages must not be released while the device may still access
> +	 * them, so this wait must be neither interruptible nor time limited.
> +	 */
> +	dma_resv_wait_timeout(to_gobj(abo)->resv, DMA_RESV_USAGE_BOOKKEEP,
> +			      false, MAX_SCHEDULE_TIMEOUT);
>   
>   	if (range->event == MMU_NOTIFY_UNMAP) {
>   		down_write(&xdna->notifier_lock);
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> index b27492e2bf8a..274e5b609882 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
> @@ -63,7 +63,6 @@ struct amdxdna_dev_ops {
>   	int (*hwctx_config)(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>   	int (*hwctx_sync_debug_bo)(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   	int (*hwctx_heap_expand)(struct amdxdna_hwctx *hwctx, struct amdxdna_gem_obj *heap);
> -	void (*hmm_invalidate)(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	int (*cmd_submit)(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>   	int (*cmd_wait)(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   	int (*get_aie_info)(struct amdxdna_client *client, struct amdxdna_drm_get_info *args);
