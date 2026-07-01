Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45E310E354;
	Wed,  1 Jul 2026 21:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gobIAxqc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57AB10E354
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:28:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D6084144A;
 Wed,  1 Jul 2026 21:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4DD1F000E9;
 Wed,  1 Jul 2026 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782941326;
 bh=JWA1N4RHivFqVG8s+1wmKZwcq65ruI8vsnbFCvfZR00=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gobIAxqcQsbBsxWfZvxlO3rGa3H+7Wj0M2+4w01AAcz/LYcv8i+Zt1rGXOyblQXBL
 2TC8qYUjPINUxhCoItjIMi6AOiYvIJ+2z0l3Vepo9HlvueNluE+BSOC0Brikz59EPU
 HCm2bQPiz6pkF7hqYCJTI2TMqJ9I9eFh0qF37462ZpBc9PSAEHHD+3GLKMroe2hre5
 C2KNNXx6k7zZ6Gu+qPWIhkTX6jOA4EkNYap9BC+SAIXYp54uWneeld8Rimer3tlMB4
 GQ/MHeQqF9DB4HORqg2MYikO91E+WqLNndwD5Fyw7SrgadKvPpcusRvCLIkW1XgT/G
 RRlom/tz5ltwA==
Message-ID: <9860bb38-5022-4213-9e4e-aecfd6824d04@kernel.org>
Date: Wed, 1 Jul 2026 16:28:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix use-after-free in debug BO command
 handling
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 shuvampandey1@gmail.com, karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260701155556.663541-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260701155556.663541-1-lizhi.hou@amd.com>
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



On 7/1/26 10:55, Lizhi Hou wrote:
> When a debug BO command completes, job->drv_cmd may already have been
> freed. Accessing it from aie2_sched_drvcmd_resp_handler() can result in
> a use-after-free and memory corruption.
> 
> Fix this by introducing reference counting for drv_cmd objects and
> transferring ownership to the job while it is in flight. This ensures
> that the command remains valid until the completion handler finishes
> processing it.
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviwed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c    | 68 +++++++++++++++++++++--------
>   drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
>   2 files changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 55eb29dece5b..8ec8a4d69b14 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -59,6 +59,18 @@ static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>   	return false;
>   }
>   
> +static void aie2_cmd_release(struct kref *ref)
> +{
> +	struct amdxdna_drv_cmd *drv_cmd = container_of(ref, struct amdxdna_drv_cmd, refcnt);
> +
> +	kfree(drv_cmd);
> +}
> +
> +static void aie2_cmd_put(struct amdxdna_drv_cmd *drv_cmd)
> +{
> +	kref_put(&drv_cmd->refcnt, aie2_cmd_release);
> +}
> +
>   static void aie2_job_release(struct kref *ref)
>   {
>   	struct amdxdna_sched_job *job;
> @@ -70,6 +82,8 @@ static void aie2_job_release(struct kref *ref)
>   	wake_up(&job->hwctx->priv->job_free_wq);
>   	if (job->out_fence)
>   		dma_fence_put(job->out_fence);
> +	if (job->drv_cmd)
> +		aie2_cmd_put(job->drv_cmd);
>   	kfree(job->aie2_job_health);
>   	kfree(job);
>   }
> @@ -901,7 +915,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   {
>   	struct amdxdna_client *client = hwctx->client;
>   	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_drv_cmd cmd = { 0 };
> +	struct amdxdna_drv_cmd *cmd;
>   	struct amdxdna_gem_obj *abo;
>   	u64 seq;
>   	int ret;
> @@ -912,32 +926,39 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   		return -EINVAL;
>   	}
>   
> +	cmd = kzalloc_obj(*cmd);
> +	if (!cmd) {
> +		ret = -ENOMEM;
> +		goto put_obj;
> +	}
> +	kref_init(&cmd->refcnt);
> +
>   	if (attach) {
>   		if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
>   			ret = -EBUSY;
> -			goto put_obj;
> +			goto put_cmd;
>   		}
> -		cmd.opcode = ATTACH_DEBUG_BO;
> +		cmd->opcode = ATTACH_DEBUG_BO;
>   	} else {
>   		if (abo->assigned_hwctx != hwctx->id) {
>   			ret = -EINVAL;
> -			goto put_obj;
> +			goto put_cmd;
>   		}
> -		cmd.opcode = DETACH_DEBUG_BO;
> +		cmd->opcode = DETACH_DEBUG_BO;
>   	}
>   
> -	ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
> +	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
>   				 &bo_hdl, 1, hwctx->id, &seq);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Submit command failed");
> -		goto put_obj;
> +		goto put_cmd;
>   	}
>   
>   	aie2_cmd_wait(hwctx, seq);
> -	if (cmd.result) {
> -		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
> +	if (cmd->result) {
> +		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>   		ret = -EINVAL;
> -		goto put_obj;
> +		goto put_cmd;
>   	}
>   
>   	if (attach)
> @@ -947,6 +968,8 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   
>   	XDNA_DBG(xdna, "Config debug BO %d to %s", bo_hdl, hwctx->name);
>   
> +put_cmd:
> +	aie2_cmd_put(cmd);
>   put_obj:
>   	amdxdna_gem_put_obj(abo);
>   	return ret;
> @@ -974,25 +997,32 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>   {
>   	struct amdxdna_client *client = hwctx->client;
>   	struct amdxdna_dev *xdna = client->xdna;
> -	struct amdxdna_drv_cmd cmd = { 0 };
> +	struct amdxdna_drv_cmd *cmd;
>   	u64 seq;
>   	int ret;
>   
> -	cmd.opcode = SYNC_DEBUG_BO;
> -	ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
> +	cmd = kzalloc_obj(*cmd);
> +	if (!cmd)
> +		return -ENOMEM;
> +	kref_init(&cmd->refcnt);
> +
> +	cmd->opcode = SYNC_DEBUG_BO;
> +	ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
>   				 &debug_bo_hdl, 1, hwctx->id, &seq);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Submit command failed");
> -		return ret;
> +		goto put_cmd;
>   	}
>   
>   	aie2_cmd_wait(hwctx, seq);
> -	if (cmd.result) {
> -		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
> -		return -EINVAL;
> +	if (cmd->result) {
> +		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
> +		ret = -EINVAL;
>   	}
>   
> -	return 0;
> +put_cmd:
> +	aie2_cmd_put(cmd);
> +	return ret;
>   }
>   
>   static int aie2_populate_range(struct amdxdna_gem_obj *abo)
> @@ -1139,6 +1169,8 @@ int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job,
>   		dma_resv_add_fence(job->bos[i]->resv, job->out_fence, DMA_RESV_USAGE_WRITE);
>   	job->seq = hwctx->priv->seq++;
>   	kref_get(&job->refcnt);
> +	if (job->drv_cmd)
> +		kref_get(&job->drv_cmd->refcnt);
>   	drm_sched_entity_push_job(&job->base);
>   
>   	*seq = job->seq;
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index aaae16430466..b6bef3af7dab 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -132,6 +132,7 @@ enum amdxdna_job_opcode {
>   struct amdxdna_drv_cmd {
>   	enum amdxdna_job_opcode	opcode;
>   	u32			result;
> +	struct kref		refcnt;
>   };
>   
>   struct app_health_report;

