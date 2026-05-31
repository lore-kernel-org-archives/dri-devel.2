Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD424CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47D610E4D2;
	Sun, 31 May 2026 13:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e/7ESWWx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D0310E4D2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 13:17:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 986EB40DC9;
 Sun, 31 May 2026 13:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED61F00898;
 Sun, 31 May 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780233454;
 bh=TgK3o33LQKPM1WDdIyiHkK6bLsiY8RdbftsC17rVWmg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=e/7ESWWxcrAR+s+EGYHS9UoUj4lwkMKq41hno2mRHVN0amaHTG8h46Y43OpSu0+YF
 pCsLBzOuawYbfW7EdDy+QCWwbM/yJ4UUyn3D3v/QpuYeZDGnrPfkc1bXU9lbmXb6ZQ
 k1y92hL2KLCRYuX8kJx83OqrEjisIetlCxg0pk3JcANIkLGT8omEFmmcqnd7mxOnzb
 2AUyEgCcL85e043JPQV2ufWaGdMrq7p+W8ujf1i4BTDSxgfHGloKy24iYtk0l6Tgwl
 Q44NM5gJ7BpYmpsIxzkXRnLkLCS7pnJNBYKPkNqnWQa0kHkOMncfVUapCX5SLsnWIA
 Y1L9ziXb4Wc8g==
Message-ID: <11e636a3-8338-4f87-8519-1b38af62a00f@kernel.org>
Date: Sun, 31 May 2026 15:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Return errors for failed debug BO
 commands
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260529162122.1976376-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260529162122.1976376-1-lizhi.hou@amd.com>
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



On 5/29/26 18:21, Lizhi Hou wrote:
> The config and sync debug BO commands currently may report success even
> when the operation fails.
> 
> Capture the firmware return status and propagate the corresponding error
> to userspace.
> 
> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 2ad343728782..da89b3701f5b 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -305,17 +305,13 @@ aie2_sched_drvcmd_resp_handler(void *handle, void __iomem *data, size_t size)
>   	struct amdxdna_sched_job *job = handle;
>   	int ret = 0;
>   
> -	if (unlikely(!data))
> -		goto out;
> -
> -	if (unlikely(size != sizeof(u32))) {
> +	if (unlikely(!data || size != sizeof(u32))) {
> +		job->drv_cmd->result = U32_MAX;
>   		ret = -EINVAL;
> -		goto out;
> +	} else {
> +		job->drv_cmd->result = readl(data);
>   	}
>   
> -	job->drv_cmd->result = readl(data);
> -
> -out:
>   	aie2_sched_notify(job);
>   	return ret;
>   }
> @@ -940,6 +936,7 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
>   	aie2_cmd_wait(hwctx, seq);
>   	if (cmd.result) {
>   		XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
> +		ret = -EINVAL;
>   		goto put_obj;
>   	}
>   

