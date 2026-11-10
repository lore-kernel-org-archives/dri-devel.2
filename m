Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F1606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bfmu6yLu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50C410EF53;
	Tue, 10 Nov 2026 18:37:30 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE8910EF53
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:37:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwBgB3vR2HQ9hKgt0e32sHrl0A1HxtiW60PICd38AOEyaVgcUp9GtQoZcdTJ3Uf+i6LMJEEEhDg3Fv4p4UznmSoVPV3eWWqiThuFqqkjc7uZadFarPOr8jHD9lP//ZBoQ8sa3+EKePpQJbKZSDuLtvuc9QgSQRgt13WHYzqcX2LjIVGzR/R9W6WfAdkCt+EMQO7ySs/LW/kiGGHlT5x/PvHTEocVL2TANTJKpzxm9cAsvAvWuKlXBMgG18nMlm+Ik66XkNfPffSU6VhbBliq4PnqgjRkOen4ffzKVuc0hjw2BMeWzICpaRtPI9WloOeaRH77IGC9sK7I0isWLkFpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc181okZn0i4sqk+BxTLR6TtgHMQwWaCGuUU3/wIzVk=;
 b=hRs/1bh2pQKRRZqh4CySlrfr2JPbvYg1guYJ6EgnWfsA6iexHy5YCZQOVBmt4r1rqS6BelyU0Xg8xxT0Uis9rigHUPXQe0W2dJzkrbiB2x9HrdjeKA8bm1t+3KfTqv8Ei1WxmwgVp2VPUwsx/Gs9/c5/QB+SbGR2n9wUSe8+003dvG7KXw0BfbZLF0l+M/T++nkTYaKejTm2OIEvUnxiC8uerehoCBo/KWLj6K6ydZhNGpO9KjsuUnZw8vmLeTk+vWCMv6geplFi/FWMsIY55fHJ09BoRY7gfCpXNp/vNx2y9EvXa5TNKo6z06NA7jXp9Z9q56dUdgBb/UcOEVVqRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc181okZn0i4sqk+BxTLR6TtgHMQwWaCGuUU3/wIzVk=;
 b=Bfmu6yLuyknVsCCOuofjDrAranhIOnqCy3RHiTJHCPRKgHojTTj193LDFtWYS7fLRB2HPDyWlLcprLI5Il5FguRAMLCPFK7WuDenxYdTufDfHObg5Krwj+7oB9OWhy6SzVZSlF646TLnAf36Gf0dwySWnRMLpm8eGg+Wq1KQMw0=
Received: from PH8PR05CA0012.namprd05.prod.outlook.com (2603:10b6:510:2cc::11)
 by DS6PR12MB801076.namprd12.prod.outlook.com (2603:10b6:8:417::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:36:48 +0000
Received: from MW3PEPF00001658.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::63) by PH8PR05CA0012.outlook.office365.com
 (2603:10b6:510:2cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:36:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001658.mail.protection.outlook.com (10.167.249.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 10 Nov 2026 18:36:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:36:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:36:47 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:36:46 -0600
Message-ID: <f95e9599-7427-b9c5-b3f3-58505eaebc37@amd.com>
Date: Tue, 10 Nov 2026 10:36:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND V1 3/4] accel/amdxdna: Add AIE4 debug buffer support
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
 <20261104224302.643329-4-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261104224302.643329-4-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001658:EE_|DS6PR12MB801076:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e73080-a26e-4bcb-3a22-08df3f599425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|56012099006|5023799004|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aDcbca03JEfayP2AZ+WFMB2lW/qMXv5QfProyBf0m0d2jY8XxxmompgRAE5MDg31Z8OQCU4g80LgL5cH6M6ZikqQC6jA2y0To8pMNKmLi1+hRd5Cfzc3N59ICS88PoRUVjq6fnGPoG7cTscgLmxhW8pYUrmQdJtn0R0cWZTqykYlVb883FYpEngmtjaTmuM7yuAdMSW07Lfop0XyMK0SRsftl0Rd4j64ifhvGiyhO7TTcoSy7LB3Z63FJZgfj+D4TJojIRPeNhugpABpUlxgtUYH7tV9zeX8SpG9Yomu9NryupNrkcNSX1/w3ErqeNupzGRHMjqkvWs0vDJC3iTAqW/Iz7TVo0OnY1hcnN3NE6/hrqlDFxM00Usv7FXTQDPUW/yhb9vRgf+Yj6VgsoVWDBCjafMuJEcJ9N8G6DtJQkN+GvApIo4UcXZQlgJ1t5+3Yn9omLCjubKHqG6KLfpW+dfpCefNSVdZXcTHklWF1FLJ79Z5qsAr0ZJ22uFyUXoCzl7fhx/jt38LI4eKnkPINt9rFb+8JM5Mbepo56NuNzabV0tiUXFPT0ay5A99OoJ6wCqvyprBZGkks3FSAeQRgMtjNb6b6B444XYQe5RkRmMKX9DA7GToucgYHvDazEKVI/SpSRpCRteNkpMTLpugMch0YQIfc+qmJm7iKjP9gZ8wg2KNeViyT7RWF/wlcQgZw1PFXf5MVLeAOmkFi/wf0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jb3iu5qFOdD2O0Fl+ZBWUxpsk5Xez5KYuel7u2/W4j0jH9hvXtvShkGMC2jIW3NPDtiB/Lx3f8FfS8l6nMAXLTkiFgLJFZkrGjvuKMLoZIMoeHgWUWtjkqWY2eZBm7+t+bC0VD6G98OfKqIvDW+oYj38lZBTjjmP3LWEcF+gJUUTHCA2JULRJ4VOOjA4thAIbJw7nOV2RoDN7uF+pk5CrSgW6dRgGxFt/KB0fHt7kwY8cs+zYmit7Q4eEZ8OTLb5exIjA21BOOMdEZCrYHXEo3JisJN5Tp8zTp/sw6Eu8noIDIKU9qi+eTUI1cepg4Ic23KBm9Y+6+yO+PgLcoir7hwzcPyunFweVa8Hm7x7ZRDCkVyLQfDeVacpo1IqKQ3pEbGJrvUGjUeKOtzT2h8eEMNeodqdqnt4urkOzIPrY6RznR2z8Wt68h68A1pQeLfP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:36:47.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e73080-a26e-4bcb-3a22-08df3f599425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW3PEPF00001658.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB801076
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
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/26 14:43, David Zhang wrote:
> Let user space attach a debug buffer to an AIE4 hardware context through
> the hwctx config ioctl. The buffer stays attached across suspend and
> resume: the driver removes it from the firmware context before suspend
> and configures it again on resume.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_ctx.c      | 284 +++++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_message.c  |  20 ++
>   drivers/accel/amdxdna/aie4_msg_priv.h |  35 ++++
>   drivers/accel/amdxdna/aie4_pci.c      |   4 +
>   drivers/accel/amdxdna/aie4_pci.h      |  10 +
>   drivers/accel/amdxdna/amdxdna_ctx.c   |   4 +-
>   include/uapi/drm/amdxdna_accel.h      |  50 +++++
>   7 files changed, 405 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie4_ctx.c
> index a3f0a69b93b7..972e924dc1b3 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
> @@ -9,6 +9,7 @@
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_print.h>
>   #include <drm/gpu_scheduler.h>
> +#include <linux/bitfield.h>
>   #include <linux/hmm.h>
>   #include <linux/iommu.h>
>   #include <linux/types.h>
> @@ -130,6 +131,70 @@ static void aie4_msg_destroy_context(struct amdxdna_dev_hdl *ndev, u32 hw_contex
>   		XDNA_WARN(xdna, "destroy ctx id %d failed %d", hw_context_id, ret);
>   }
>   
> +/* Release the debug buffer of @type, taken on attach. */
> +static void aie4_hwctx_put_fw_buf(struct amdxdna_hwctx *hwctx, u32 type)
> +{
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +
> +	priv->fw_buf_bo[type]->assigned_hwctx = AMDXDNA_INVALID_CTX_HANDLE;
> +	/* Drop the reference taken when the buffer was attached. */
> +	amdxdna_gem_put_obj(priv->fw_buf_bo[type]);
> +	priv->fw_buf_bo[type] = NULL;
> +}
> +
> +static int aie4_fw_buf_property(u32 type)
> +{
> +	switch (type) {
> +	case AMDXDNA_FW_BUF_LOG:
> +		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_LOG_BUFFER;
> +	case AMDXDNA_FW_BUF_DEBUG:
> +		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_BUFFER;
> +	case AMDXDNA_FW_BUF_TRACE:
> +		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_TRACE_BUFFER;
> +	case AMDXDNA_FW_BUF_DBG_Q:
> +		return AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_QUEUE;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +/* Release all attached debug buffers. */
> +static void aie4_hwctx_put_fw_bufs(struct amdxdna_hwctx *hwctx)
> +{
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	u32 type;
> +
> +	for (type = 0; type < ARRAY_SIZE(priv->fw_buf_bo); type++) {
> +		if (priv->fw_buf_bo[type])
> +			aie4_hwctx_put_fw_buf(hwctx, type);
> +	}
> +}
> +
> +/*
> + * Configure the attached debug buffers on the firmware context, or remove
> + * them from it. Suspend and resume recreate the firmware context, so the
> + * buffers are removed first and configured again afterwards.
> + */
> +static void aie4_hwctx_cfg_fw_bufs(struct amdxdna_hwctx *hwctx, bool attach)
> +{
> +	struct aie4_msg_context_config_cert_logging none = { };
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +	u32 type;
> +	int ret;
> +
> +	for (type = 0; type < ARRAY_SIZE(priv->fw_buf_bo); type++) {
> +		if (!priv->fw_buf_bo[type])
> +			continue;
> +		ret = aie4_configure_hw_context_cert_log(xdna->dev_handle, priv->hw_ctx_id,
> +							 aie4_fw_buf_property(type),
> +							 attach ? &priv->fw_buf_cl[type] : &none);
> +		if (ret)
> +			XDNA_WARN(xdna, "%s debug buffer type %u on %s failed, ret %d",
> +				  attach ? "Configure" : "Remove", type, hwctx->name, ret);
> +	}
> +}
> +
>   static u8 aie4_parse_priority_to_dev(u32 priority)
>   {
>   	switch (priority) {
> @@ -198,6 +263,9 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx)
>   	hwctx->start_col = 0;
>   	hwctx->num_col = ndev->total_col;
>   
> +	/* Pairs with aie4_hwctx_destroy(): re-attach debug buffers after resume or reset. */
> +	aie4_hwctx_cfg_fw_bufs(hwctx, true);
> +
>   	/* Set up driver doorbell and return invalid offset to userspace. */
>   	mutex_lock(&priv->io_lock);
>   	ret = aie4_doorbell_setup(hwctx, &resp);
> @@ -256,8 +324,15 @@ void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags flags
>   	if (has_error)
>   		wake_up_all(&priv->job_list_wq);
>   
> -	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID)
> +	if (flags != AIE4_HWCTX_DISCONNECT && priv->hw_ctx_id != CTX_INVALID_ID) {
> +		/*
> +		 * Pairs with aie4_hwctx_create(): detach debug buffers.
> +		 * On error, skip it; firmware drops them with the context.
> +		 */
> +		if (flags != AIE4_HWCTX_ERROR)
> +			aie4_hwctx_cfg_fw_bufs(hwctx, false);
>   		aie4_msg_destroy_context(ndev, priv->hw_ctx_id);
> +	}
>   
>   	if (cert_comp)
>   		aie4_put_cert_comp(cert_comp);
> @@ -430,6 +505,8 @@ void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx)
>   		aie4_hwctx_wait_for_running(hwctx);
>   		destroy_workqueue(priv->job_work_q);
>   	}
> +	/* The context is gone, so release its debug buffers. */
> +	aie4_hwctx_put_fw_bufs(hwctx);
>   	aie4_hwctx_umq_fini(hwctx);
>   	mutex_destroy(&priv->io_lock);
>   	kfree(hwctx->priv);
> @@ -1284,3 +1361,208 @@ int aie4_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   	mmput(job->mm);
>   	return ret;
>   }
> +
> +/*
> + * Attach or detach the debug buffer @meta describes. @meta is a kernel copy
> + * of the user descriptor.
> + *
> + * The buffer stays attached until user space removes it or frees the
> + * hardware context. After suspend, resume or context recovery, the driver
> + * configures it again on the new firmware context.
> + */
> +static int aie4_hwctx_cfg_fw_buf(struct amdxdna_hwctx *hwctx,
> +				 const struct amdxdna_fw_buffer_metadata *meta,
> +				 u32 size, bool attach)
> +{
> +	struct aie4_msg_context_config_cert_logging cl = { };
> +	struct amdxdna_hwctx_priv *priv = hwctx->priv;
> +	struct amdxdna_client *client = hwctx->client;
> +	struct amdxdna_dev *xdna = client->xdna;
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +	struct amdxdna_gem_obj *payload_bo;
> +	u32 prev_size = 0;
> +	u64 base_addr;
> +	u32 property;
> +	u32 seen = 0;	/* uC indices in the descriptor */
> +	u32 used = 0;	/* uC indices with a slice size above 0 */
> +	int ret;
> +	int i;
> +
> +	if (!meta || size < sizeof(*meta)) {
> +		XDNA_DBG(xdna, "Invalid debug buffer descriptor, size %u", size);
> +		return -EINVAL;
> +	}
> +
> +	if (XDNA_MBZ_DBG(xdna, meta->pad, sizeof(meta->pad)))
> +		return -EINVAL;
> +
> +	ret = aie4_fw_buf_property(meta->buf_type);
> +	if (ret < 0) {
> +		XDNA_DBG(xdna, "Unsupported buf_type %u", meta->buf_type);
> +		return ret;
> +	}
> +	property = ret;
> +
> +	/*
> +	 * On attach, this reference is held until detach or context teardown.
> +	 * The device reaches the buffer through the process address space
> +	 * (PASID), so the BO is not pinned or fenced: if the process changes
> +	 * that mapping, only its own jobs are affected.
> +	 */
> +	payload_bo = amdxdna_gem_get_obj(client, meta->bo_handle, AMDXDNA_BO_SHARE);
> +	if (!payload_bo) {
> +		XDNA_DBG(xdna, "Get bo %u failed", meta->bo_handle);
> +		return -EINVAL;
> +	}
> +
> +	if (!attach) {
> +		if (payload_bo != priv->fw_buf_bo[meta->buf_type]) {
> +			XDNA_DBG(xdna, "BO %u is not attached as debug buffer type %u on %s",
> +				 meta->bo_handle, meta->buf_type, hwctx->name);
> +			ret = -EINVAL;
> +			goto put_obj;
> +		}
> +
> +		/*
> +		 * While the context has a firmware context, remove the buffer
> +		 * from it. After a reset or resume that could not recreate it,
> +		 * there is no firmware context, so only drop the driver's
> +		 * reference to the BO.
> +		 */
> +		if (priv->hw_ctx_id != CTX_INVALID_ID) {
> +			ret = aie4_configure_hw_context_cert_log(ndev, priv->hw_ctx_id,
> +								 property, &cl);
> +			/* Firmware may still use it, so keep it attached. */
> +			if (ret)
> +				goto put_obj;
> +		}
> +
> +		/* Release the attach reference; put_obj drops the lookup one. */
> +		aie4_hwctx_put_fw_buf(hwctx, meta->buf_type);
> +		XDNA_DBG(xdna, "Detached debug buffer type %u BO %u from %s",
> +			 meta->buf_type, meta->bo_handle, hwctx->name);
> +		ret = 0;
> +		goto put_obj;
> +	}
> +
> +	if (!meta->num_ucs || meta->num_ucs > AIE4_MAX_NUM_CERTS ||
> +	    size < struct_size(meta, uc_info, meta->num_ucs)) {
> +		XDNA_DBG(xdna, "Invalid num_ucs %u for size %u", meta->num_ucs, size);
> +		ret = -EINVAL;
> +		goto put_obj;
> +	}
> +
> +	/* One buffer of each type per context. */
> +	if (priv->fw_buf_bo[meta->buf_type]) {
> +		XDNA_DBG(xdna, "Debug buffer type %u already attached on %s",
> +			 meta->buf_type, hwctx->name);
> +		ret = -EBUSY;
> +		goto put_obj;
> +	}
> +
> +	if (payload_bo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
> +		XDNA_DBG(xdna, "BO %u already attached to a context",
> +			 meta->bo_handle);
> +		ret = -EBUSY;
> +		goto put_obj;
> +	}
> +
> +	if (priv->hw_ctx_id == CTX_INVALID_ID) {
> +		XDNA_ERR(xdna, "No firmware context to attach debug buffer type %u on %s",
> +			 meta->buf_type, hwctx->name);
> +		ret = -ENODEV;
> +		goto put_obj;
> +	}
> +
> +	base_addr = amdxdna_gem_dev_addr(payload_bo);
> +	if (base_addr == AMDXDNA_INVALID_ADDR) {
> +		XDNA_DBG(xdna, "Debug buffer type %u payload BO %u is not mapped",
> +			 meta->buf_type, meta->bo_handle);
> +		ret = -EINVAL;
> +		goto put_obj;
> +	}
> +
> +	for (i = 0; i < meta->num_ucs; i++) {
> +		u32 slice_size = meta->uc_info[i].size;
> +		u32 index = meta->uc_info[i].index;
> +		u32 next_size;
> +
> +		if (index >= AIE4_MAX_NUM_CERTS) {
> +			XDNA_DBG(xdna, "Invalid uc index %u", index);
> +			ret = -EINVAL;
> +			goto put_obj;
> +		}
> +
> +		if (seen & BIT(index)) {
> +			XDNA_DBG(xdna, "Duplicate uc index %u", index);
> +			ret = -EINVAL;
> +			goto put_obj;
> +		}
> +		seen |= BIT(index);
> +
> +		if (!slice_size)
> +			continue;
> +
> +		if (check_add_overflow(prev_size, slice_size, &next_size) ||
> +		    next_size > payload_bo->mem.size) {
> +			XDNA_DBG(xdna, "uc[%u] slice 0x%x at 0x%x overflows bo size %lu",
> +				 index, slice_size, prev_size, payload_bo->mem.size);
> +			ret = -EINVAL;
> +			goto put_obj;
> +		}
> +
> +		cl.info[index].paddr = base_addr + prev_size;
> +		cl.info[index].size = slice_size;
> +		used |= BIT(index);
> +		prev_size = next_size;
> +	}
> +
> +	if (!used) {
> +		XDNA_DBG(xdna, "Debug buffer type %u: all uc slices are empty",
> +			 meta->buf_type);
> +		ret = -EINVAL;
> +		goto put_obj;
> +	}
> +
> +	/* cl.info[] is indexed by uC, so cover up to the highest one used. */
> +	cl.num = FIELD_PREP(AIE4_MSG_CERT_LOG_NUM, fls(used));
> +	ret = aie4_configure_hw_context_cert_log(ndev, priv->hw_ctx_id, property, &cl);
> +	if (ret)
> +		goto put_obj;
> +
> +	/* Keep the lookup reference. */
> +	payload_bo->assigned_hwctx = hwctx->id;
> +	priv->fw_buf_bo[meta->buf_type] = payload_bo;
> +	priv->fw_buf_cl[meta->buf_type] = cl;
> +	XDNA_DBG(xdna, "Attached debug buffer type %u BO %u to %s",
> +		 meta->buf_type, meta->bo_handle, hwctx->name);
> +	return 0;
> +
> +put_obj:
> +	amdxdna_gem_put_obj(payload_bo);
> +	return ret;
> +}
> +
> +int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value,
> +		      void *buf, u32 size)
> +{
> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
> +
> +	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> +
> +	switch (type) {
> +	case DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF:
> +		return aie4_hwctx_cfg_fw_buf(hwctx, buf, size, true);
> +	case DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF:
> +		return aie4_hwctx_cfg_fw_buf(hwctx, buf, size, false);
> +	default:
> +		XDNA_DBG(xdna, "Not supported type %d", type);
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +int aie4_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
> +{
> +	/* NO-OP */
> +	return 0;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index 060e199f4006..bc862cbe68f3 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -326,3 +326,23 @@ int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us)
>   
>   	return ret;
>   }
> +
> +int aie4_configure_hw_context_cert_log(struct amdxdna_dev_hdl *ndev,
> +				       u32 hw_context_id, u32 property,
> +				       const struct aie4_msg_context_config_cert_logging *cl)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_configure_hw_context, AIE4_MSG_OP_CONFIGURE_HW_CONTEXT);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	req.hw_context_id = hw_context_id;
> +	req.property = property;
> +	req.cert_logging = *cl;
> +
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(xdna, "Configure debug buffer failed, ctx %u property %u ret %d",
> +			 hw_context_id, property, ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 566f6abc9e2d..977f7651341a 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -22,6 +22,7 @@ enum aie4_msg_opcode {
>   	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
>   	AIE4_MSG_OP_CREATE_HW_CONTEXT                = 0x30003,
>   	AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
> +	AIE4_MSG_OP_CONFIGURE_HW_CONTEXT             = 0x30005,
>   	AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>   	AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
>   	AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
> @@ -156,6 +157,40 @@ struct aie4_msg_destroy_hw_context_resp {
>   	__u16 resvd;
>   } __packed;
>   
> +enum aie4_msg_configure_hw_context_property {
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_PRIORITY_BAND,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_SCHEDULING,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_DPM,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_LOG_BUFFER,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_BUFFER,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_TRACE_BUFFER,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_CERT_DEBUG_QUEUE,
> +	AIE4_CONFIGURE_HW_CONTEXT_PROPERTY_HANDLE,
> +};
> +
> +#define AIE4_MAX_NUM_CERTS	6
> +
> +struct aie4_msg_context_config_cert_logging_info {
> +	__u64 paddr;
> +	__u32 size;
> +} __packed;
> +
> +struct aie4_msg_context_config_cert_logging {
> +#define AIE4_MSG_CERT_LOG_NUM	GENMASK(7, 0)
> +	__u32 num;
> +	struct aie4_msg_context_config_cert_logging_info info[AIE4_MAX_NUM_CERTS];
> +} __packed;
> +
> +struct aie4_msg_configure_hw_context_req {
> +	__u32 hw_context_id;
> +	__u32 property;
> +	struct aie4_msg_context_config_cert_logging cert_logging;
> +} __packed;
> +
> +struct aie4_msg_configure_hw_context_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   struct aie4_tile_info {
>   	__u32 size;
>   	__u16 major;
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 02dcb2f813d4..101f0f27b466 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1393,6 +1393,8 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>   	.hwctx_init		= aie4_hwctx_init,
>   	.hwctx_stop		= aie4_hwctx_stop,
>   	.hwctx_fini		= aie4_hwctx_fini,
> +	.hwctx_config		= aie4_hwctx_config,
> +	.hwctx_sync_debug_bo	= aie4_hwctx_sync_debug_bo,
>   	.cmd_submit		= aie4_cmd_submit,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> @@ -1408,6 +1410,8 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>   	.hwctx_init		= aie4_hwctx_init,
>   	.hwctx_stop		= aie4_hwctx_stop,
>   	.hwctx_fini		= aie4_hwctx_fini,
> +	.hwctx_config		= aie4_hwctx_config,
> +	.hwctx_sync_debug_bo	= aie4_hwctx_sync_debug_bo,
>   	.cmd_submit		= aie4_cmd_submit,
>   	.cmd_wait		= aie4_cmd_wait,
>   	.get_aie_info		= aie4_get_info,
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index fdc55e498246..158e68199952 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -49,6 +49,10 @@ struct amdxdna_hwctx_priv {
>   	struct cert_comp                *cert_comp;
>   	u32                             hw_ctx_id;
>   	bool                            has_error;
> +	/* Attached debug buffers, held until removal or fini. */
> +	struct amdxdna_gem_obj          *fw_buf_bo[AMDXDNA_FW_BUF_NUM];
> +	/* Their configuration, sent again when the context is created. */
> +	struct aie4_msg_context_config_cert_logging fw_buf_cl[AMDXDNA_FW_BUF_NUM];
>   
>   	/* Direct and indirect packet storage aliasing umq_bo. */
>   	u64                             write_index;
> @@ -142,6 +146,9 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
>   int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
>   			 const void *data, size_t size);
>   int aie4_set_ctx_hysteresis(struct amdxdna_dev_hdl *ndev, u32 timeout_us);
> +int aie4_configure_hw_context_cert_log(struct amdxdna_dev_hdl *ndev,
> +				       u32 hw_context_id, u32 property,
> +				       const struct aie4_msg_context_config_cert_logging *cl);
>   u32 aie4_msg_pasid(struct amdxdna_client *client);
>   
>   /* aie4_ctx.c */
> @@ -161,6 +168,9 @@ int aie4_hwctx_create(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_destroy(struct amdxdna_hwctx *hwctx, enum aie4_hwctx_flags);
>   int aie4_hwctx_wait_for_running(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_resume_jobs(struct amdxdna_hwctx *hwctx);
> +int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value,
> +		      void *buf, u32 size);
> +int aie4_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl);
>   
>   /* aie4_pci.c */
>   void aie4_hwctx_suspend_all(struct amdxdna_dev_hdl *ndev, int clean_jobs);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index f4004630dc1b..0a730a637180 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -365,9 +365,11 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
>   
>   	switch (args->param_type) {
>   	case DRM_AMDXDNA_HWCTX_CONFIG_CU:
> +	case DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF:
> +	case DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF:
>   		/* For those types that param_val is pointer */
>   		if (buf_size > PAGE_SIZE) {
> -			XDNA_ERR(xdna, "Config CU param buffer too large");
> +			XDNA_ERR(xdna, "Config param buffer too large");
>   			return -E2BIG;
>   		}
>   
> diff --git a/include/uapi/drm/amdxdna_accel.h b/include/uapi/drm/amdxdna_accel.h
> index 51a507561df6..0e41c45ba720 100644
> --- a/include/uapi/drm/amdxdna_accel.h
> +++ b/include/uapi/drm/amdxdna_accel.h
> @@ -135,6 +135,56 @@ enum amdxdna_drm_config_hwctx_param {
>   	DRM_AMDXDNA_HWCTX_CONFIG_CU,
>   	DRM_AMDXDNA_HWCTX_ASSIGN_DBG_BUF,
>   	DRM_AMDXDNA_HWCTX_REMOVE_DBG_BUF,
> +	DRM_AMDXDNA_HWCTX_ASSIGN_FW_BUF = 4,
> +	DRM_AMDXDNA_HWCTX_REMOVE_FW_BUF,
> +};
> +
> +/**
> + * enum amdxdna_fw_buf_type - Debug buffer type.
> + * @AMDXDNA_FW_BUF_DEBUG: Debug buffer.
> + * @AMDXDNA_FW_BUF_TRACE: Trace buffer.
> + * @AMDXDNA_FW_BUF_DBG_Q: Debug queue.
> + * @AMDXDNA_FW_BUF_LOG:   Log buffer.
> + * @AMDXDNA_FW_BUF_NUM:   Number of debug buffer types.
> + */
> +enum amdxdna_fw_buf_type {
> +	AMDXDNA_FW_BUF_DEBUG = 0,
> +	AMDXDNA_FW_BUF_TRACE,
> +	AMDXDNA_FW_BUF_DBG_Q,
> +	AMDXDNA_FW_BUF_LOG,
> +	AMDXDNA_FW_BUF_NUM,
> +};
> +
> +/**
> + * struct amdxdna_uc_info_entry - per-uC slice descriptor in
> + *                                struct amdxdna_fw_buffer_metadata.
> + * @index: uC index. The payload BO is sliced per-uC; @index must be unique
> + *         within an array and stay below the device's CERT uC count.
> + * @size:  Per-uC slice size in bytes. Entries with size 0 are skipped.
> + *         At least one entry must have a size greater than 0.
> + */
> +struct amdxdna_uc_info_entry {
> +	__u32 index;
> +	__u32 size;
> +};
> +
> +/**
> + * struct amdxdna_fw_buffer_metadata - per-hwctx debug buffer description.
> + * @buf_type:   One of enum amdxdna_fw_buf_type.
> + * @num_ucs:    Number of valid entries in @uc_info.
> + * @pad:        MBZ. Reserved for ABI growth.
> + * @bo_handle:  Handle of the payload BO (AMDXDNA_BO_SHARE) holding the
> + *              concatenated per-uC slices.
> + * @command_id: User tag for trace correlation.
> + * @uc_info:    Per-uC slice descriptors, in payload BO layout order.
> + */
> +struct amdxdna_fw_buffer_metadata {
> +	__u8 buf_type;
> +	__u8 num_ucs;
> +	__u8 pad[2];
> +	__u32 bo_handle;
> +	__u64 command_id;
> +	struct amdxdna_uc_info_entry uc_info[] __counted_by(num_ucs);
>   };
>   
>   /**
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
