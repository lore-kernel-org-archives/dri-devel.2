Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F1DFED3CB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5D510E9D9;
	Fri, 24 Apr 2026 13:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BIDqvUrG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E59C10E9D9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 13:28:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 105A940E15;
 Fri, 24 Apr 2026 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BEAC2BCB6;
 Fri, 24 Apr 2026 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777037338;
 bh=BEfGB8RjYhIuJXmNUypefZ6/Od0uAzaYOP1hU0ZuA/4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BIDqvUrGWxRPqHkwIC1balqxWUO5kpWlnL5Q4wGmS8KLgMmGMYf8wUpST0CjrM4pq
 lLNQpe+W1YNGUPqlB2fHO3THh4J/BVcpEhxUqnSjlDL9SDxC5FCRCb05OPJSycg3kn
 Z4cVgWzpe4fotAkAynAhDPZX715UbA5K+dwEZ0gSGR3qUDHRaQBZQv+H1TjuxYglN0
 0rBGHwpajkB/FNUOdxX9wnIq5wiG2qp9ZTLGk6bUM07tZ737iA4LYWs/EWSISUVCM2
 UpOn5Pv/L4iu3rw9ys3pXt/qz5FFPF33FCpR2rETuMmnPPYTZ6CGP+Q3pHBYyhLlLI
 wW+8XKqsuJDuw==
Message-ID: <26abc339-2e8d-4ab8-9006-4da741f8f08b@kernel.org>
Date: Fri, 24 Apr 2026 08:28:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] accel/amdxdna: Set default DPM level based on QoS
 for temporal-only mode
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260424040824.2253607-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260424040824.2253607-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 4/23/26 23:08, Lizhi Hou wrote:
> The QoS request provided when creating a hardware context is currently
> ignored when operating in temporal-only mode. Change this to use resource
> allocation through xrs_allocate_resource(), which sets the default DPM
> level according to the QoS request.
> 
> When multiple hardware contexts are active, track their required DPM
> levels and set the default DPM level to the highest among them.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 34 +++++++++++++----------------
>   drivers/accel/amdxdna/aie2_pci.c    |  1 +
>   drivers/accel/amdxdna/aie2_pci.h    |  1 +
>   drivers/accel/amdxdna/aie2_pm.c     |  2 +-
>   drivers/accel/amdxdna/aie2_solver.c | 10 ++++++++-
>   drivers/accel/amdxdna/npu1_regs.c   |  1 +
>   drivers/accel/amdxdna/npu4_regs.c   |  1 +
>   drivers/accel/amdxdna/npu5_regs.c   |  1 +
>   drivers/accel/amdxdna/npu6_regs.c   |  1 +
>   9 files changed, 31 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index d37123d925b6..0261f7f26236 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -540,22 +540,24 @@ static int aie2_alloc_resource(struct amdxdna_hwctx *hwctx)
>   {
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
>   	struct alloc_requests *xrs_req;
> +	u32 temporal_only_col = 0;
>   	int ret;
>   
> -	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
> -		hwctx->num_unused_col = xdna->dev_handle->total_col - hwctx->num_col;
> -		hwctx->num_col = xdna->dev_handle->total_col;
> -		return aie2_create_context(xdna->dev_handle, hwctx);
> -	}
> -
>   	xrs_req = kzalloc_obj(*xrs_req);
>   	if (!xrs_req)
>   		return -ENOMEM;
>   
> -	xrs_req->cdo.start_cols = hwctx->col_list;
> -	xrs_req->cdo.cols_len = hwctx->col_list_len;
> -	xrs_req->cdo.ncols = hwctx->num_col;
> -	xrs_req->cdo.qos_cap.opc = hwctx->max_opc;
> +	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
> +		xrs_req->cdo.start_cols = &temporal_only_col;
> +		xrs_req->cdo.cols_len = 1;
> +		xrs_req->cdo.ncols = xdna->dev_handle->total_col;
> +	} else {
> +		xrs_req->cdo.start_cols = hwctx->col_list;
> +		xrs_req->cdo.cols_len = hwctx->col_list_len;
> +		xrs_req->cdo.ncols = hwctx->num_col;
> +	}
> +	/* Use platform opc */
> +	xrs_req->cdo.qos_cap.opc = xdna->dev_handle->priv->col_opc * hwctx->num_col;
>   
>   	xrs_req->rqos.gops = hwctx->qos.gops;
>   	xrs_req->rqos.fps = hwctx->qos.fps;
> @@ -579,15 +581,9 @@ static void aie2_release_resource(struct amdxdna_hwctx *hwctx)
>   	struct amdxdna_dev *xdna = hwctx->client->xdna;
>   	int ret;
>   
> -	if (AIE_FEATURE_ON(&xdna->dev_handle->aie, AIE2_TEMPORAL_ONLY)) {
> -		ret = aie2_destroy_context(xdna->dev_handle, hwctx);
> -		if (ret && ret != -ENODEV)
> -			XDNA_ERR(xdna, "Destroy temporal only context failed, ret %d", ret);
> -	} else {
> -		ret = xrs_release_resource(xdna->xrs_hdl, (uintptr_t)hwctx);
> -		if (ret)
> -			XDNA_ERR(xdna, "Release AIE resource failed, ret %d", ret);
> -	}
> +	ret = xrs_release_resource(xdna->xrs_hdl, (uintptr_t)hwctx);
> +	if (ret)
> +		XDNA_ERR(xdna, "Release AIE resource failed, ret %d", ret);
>   }
>   
>   static int aie2_ctx_syncobj_create(struct amdxdna_hwctx *hwctx)
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 1d1fb012294a..a07e453a1721 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -246,6 +246,7 @@ static int aie2_xrs_load(void *cb_arg, struct xrs_action_load *action)
>   	xdna = hwctx->client->xdna;
>   
>   	hwctx->start_col = action->part.start_col;
> +	hwctx->num_unused_col = action->part.ncols - hwctx->num_col;
>   	hwctx->num_col = action->part.ncols;
>   	ret = aie2_create_context(xdna->dev_handle, hwctx);
>   	if (ret)
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index c44616065058..f12073175676 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -237,6 +237,7 @@ struct amdxdna_dev_priv {
>   #define COL_ALIGN_NONE   0
>   #define COL_ALIGN_NATURE 1
>   	u32				col_align;
> +	u32				col_opc;
>   	u32				mbox_dev_addr;
>   	/* If mbox_size is 0, use BAR size. See MBOX_SIZE macro */
>   	u32				mbox_size;
> diff --git a/drivers/accel/amdxdna/aie2_pm.c b/drivers/accel/amdxdna/aie2_pm.c
> index 786d688bd82c..d9ccd7fc8a6d 100644
> --- a/drivers/accel/amdxdna/aie2_pm.c
> +++ b/drivers/accel/amdxdna/aie2_pm.c
> @@ -74,7 +74,7 @@ int aie2_pm_init(struct amdxdna_dev_hdl *ndev)
>   		return ret;
>   
>   	ndev->pw_mode = POWER_MODE_DEFAULT;
> -	ndev->dft_dpm_level = ndev->max_dpm_level;
> +	ndev->dft_dpm_level = 0;
>   
>   	return 0;
>   }
> diff --git a/drivers/accel/amdxdna/aie2_solver.c b/drivers/accel/amdxdna/aie2_solver.c
> index 3611e3268d79..6f3ee77d5264 100644
> --- a/drivers/accel/amdxdna/aie2_solver.c
> +++ b/drivers/accel/amdxdna/aie2_solver.c
> @@ -52,7 +52,7 @@ static u32 calculate_gops(struct aie_qos *rqos)
>   	u32 service_rate = 0;
>   
>   	if (rqos->latency)
> -		service_rate = (1000 / rqos->latency);
> +		service_rate = max_t(u32, 1000 / rqos->latency, 1);
>   
>   	if (rqos->fps > service_rate)
>   		return rqos->fps * rqos->gops;
> @@ -348,6 +348,7 @@ int xrs_release_resource(void *hdl, u64 rid)
>   {
>   	struct solver_state *xrs = hdl;
>   	struct solver_node *node;
> +	u32 level = 0;
>   
>   	node = rg_search_node(&xrs->rgp, rid);
>   	if (!node) {
> @@ -358,6 +359,13 @@ int xrs_release_resource(void *hdl, u64 rid)
>   	xrs->cfg.actions->unload(node->cb_arg);
>   	remove_solver_node(&xrs->rgp, node);
>   
> +	/* set the dpm level which fits all the sessions */
> +	list_for_each_entry(node, &xrs->rgp.node_list, list) {
> +		if (node->dpm_level > level)
> +			level = node->dpm_level;
> +	}
> +	xrs->cfg.actions->set_dft_dpm_level(xrs->cfg.ddev, level);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/accel/amdxdna/npu1_regs.c b/drivers/accel/amdxdna/npu1_regs.c
> index d7e50c6b06ef..4e48c030a69f 100644
> --- a/drivers/accel/amdxdna/npu1_regs.c
> +++ b/drivers/accel/amdxdna/npu1_regs.c
> @@ -97,6 +97,7 @@ static const struct amdxdna_dev_priv npu1_dev_priv = {
>   	.rt_config	= npu1_default_rt_cfg,
>   	.dpm_clk_tbl	= npu1_dpm_clk_table,
>   	.col_align	= COL_ALIGN_NONE,
> +	.col_opc	= 2048,
>   	.mbox_dev_addr  = NPU1_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU1_SRAM_BAR_BASE,
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index 935999ced70f..eddc31803a50 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -160,6 +160,7 @@ static const struct amdxdna_dev_priv npu4_dev_priv = {
>   	.rt_config	= npu4_default_rt_cfg,
>   	.dpm_clk_tbl	= npu4_dpm_clk_table,
>   	.col_align	= COL_ALIGN_NATURE,
> +	.col_opc	= 4096,
>   	.mbox_dev_addr  = NPU4_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU4_SRAM_BAR_BASE,
> diff --git a/drivers/accel/amdxdna/npu5_regs.c b/drivers/accel/amdxdna/npu5_regs.c
> index 795bd1996845..a9102978e4a8 100644
> --- a/drivers/accel/amdxdna/npu5_regs.c
> +++ b/drivers/accel/amdxdna/npu5_regs.c
> @@ -67,6 +67,7 @@ static const struct amdxdna_dev_priv npu5_dev_priv = {
>   	.rt_config	= npu4_default_rt_cfg,
>   	.dpm_clk_tbl	= npu4_dpm_clk_table,
>   	.col_align	= COL_ALIGN_NATURE,
> +	.col_opc	= 4096,
>   	.mbox_dev_addr  = NPU5_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU5_SRAM_BAR_BASE,
> diff --git a/drivers/accel/amdxdna/npu6_regs.c b/drivers/accel/amdxdna/npu6_regs.c
> index 3125d1ce45ab..e0db3a09740b 100644
> --- a/drivers/accel/amdxdna/npu6_regs.c
> +++ b/drivers/accel/amdxdna/npu6_regs.c
> @@ -67,6 +67,7 @@ static const struct amdxdna_dev_priv npu6_dev_priv = {
>   	.rt_config	= npu4_default_rt_cfg,
>   	.dpm_clk_tbl	= npu4_dpm_clk_table,
>   	.col_align	= COL_ALIGN_NATURE,
> +	.col_opc	= 4096,
>   	.mbox_dev_addr  = NPU6_MBOX_BAR_BASE,
>   	.mbox_size      = 0, /* Use BAR size */
>   	.sram_dev_addr  = NPU6_SRAM_BAR_BASE,

