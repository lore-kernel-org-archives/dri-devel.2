Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C1ECD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 16:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A6F10E29F;
	Thu,  7 May 2026 16:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d1XwQngh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEFE10E29F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:55:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 303CF43605;
 Thu,  7 May 2026 16:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9123EC2BCB2;
 Thu,  7 May 2026 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778172959;
 bh=LHW4P3S1PHptuizxldqf/3Vcv1k1Ssfaue4jpA+d/lY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d1XwQngh1zmlvMCgQEMytEecBAjTWlSZg972op07cRwrQkUvku8qPTDc0X4qLBSZD
 HY1ThCLYm8MvZFTPYU/mKyjuXjD6PHsmN414hxdeXES+SUwmHIMIXf36MXQCMSOLIN
 TRktrQwKHD6ijvgV+fwqyuhk1glVG7l9/FIi10+Q1q7o8K4HwNl7SapvLjYU7fQUa1
 iQW3Pl8Id0T9UBE5DtYfHfkdoFmgtm64or+h1Qz7YwYwM1ysgLy03mdIlEhg4kDVMc
 9MkEFwmaBhFCWvoyLWQUj3D687hkTkG0+26y7LMol+J2cqOLk6Y8Cnlsdk0Q24xdwk
 AFEtsZIdPZL8Q==
Message-ID: <88330822-679b-497a-a2a1-93e0176cf022@kernel.org>
Date: Thu, 7 May 2026 11:55:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix clflush buffer size
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260507040207.178111-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260507040207.178111-1-lizhi.hou@amd.com>
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



On 5/6/26 23:02, Lizhi Hou wrote:
> The firmware is told the buffer is req.buf_size bytes. It may read/write
> the entire region. If the CPU only flushes a subset, the remaining cache
> lines could contain stale data, causing the device to see garbage.
> 
> Fixes: 6e87001fe19f ("accel/amdxdna: Adjust size for copy_to_user()")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/aie2_message.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 6e98af7b74db..a012e7e935ad 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -390,7 +390,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>   	req.num_cols = hweight32(aie_bitmap);
>   	req.aie_bitmap = aie_bitmap;
>   
> -	drm_clflush_virt_range(buff_addr, size); /* device can access */
> +	drm_clflush_virt_range(buff_addr, req.dump_buff_size); /* device can access */
>   	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Error during NPU query, status %d", ret);
> @@ -442,7 +442,7 @@ int aie2_query_telemetry(struct amdxdna_dev_hdl *ndev,
>   	req.buf_size = buf_sz;
>   	req.type = header->type;
>   
> -	drm_clflush_virt_range(addr, size); /* device can access */
> +	drm_clflush_virt_range(addr, req.buf_size); /* device can access */
>   	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Query telemetry failed, status %d", ret);
> @@ -1186,7 +1186,7 @@ int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
>   	req.context_id = context_id;
>   	req.buf_size = buf_size;
>   
> -	drm_clflush_virt_range(buf, sizeof(*report));
> +	drm_clflush_virt_range(buf, req.buf_size);
>   	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   	if (ret) {
>   		XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", ret, resp.status);

