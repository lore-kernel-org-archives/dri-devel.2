Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA76CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2935D11A2B5;
	Thu,  4 Jun 2026 19:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UY167g5S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE2A11A2B5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:56:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CCDF60052;
 Thu,  4 Jun 2026 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E251F00898;
 Thu,  4 Jun 2026 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780602989;
 bh=k4E66+Qm9KwWQM5/kQcBrNPOY+Ih+8+k9hcsqjdGCMQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UY167g5S/TneNSSELM1GZOTWmNI4aeYJ+VVeGg8eCO7HJ4DAD/a2I+wOsGUbhzdTS
 CUv6vHBLSDE0vYilgBnZUALhQ5TbP3T1U/7GHCXCIUuhJsQsFxIq/CcEHyV58AyDJN
 FUR+I/9lqQlh4NkyLvy131sWdgNcIkcWuIc7Ia4SEmW7HDZ5GYY9h3piIIilOwh1l6
 iuXTtS6L07QrnUJhOKD8Udnhi93fWJ2xlJ5eopuvKyspnROd6NRwPfnN/jWWd3xe+9
 8HwBAYLVPTPYnB+Q8pwuFYoKPBG0Cx43gfuDpalQI22V7EGH8OlkjXBW2cEpJHRsnN
 W+F5AROa4ystA==
Message-ID: <abe9dd4c-194d-46c3-b074-941698c3236d@kernel.org>
Date: Thu, 4 Jun 2026 14:56:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Require carveout when PASID and
 force_iova are disabled
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260604195459.2423279-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260604195459.2423279-1-lizhi.hou@amd.com>
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



On 6/4/26 14:54, Lizhi Hou wrote:
> When both PASID and force_iova are disabled, carveout memory should be
> used. Reject buffer allocations that cannot use carveout memory in this
> configuration and return an error.
> 
> Fixes: 3cc5d7a59519 ("accel/amdxdna: Add carveout memory support for non-IOMMU systems")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index c677293c1ae7..1f066ed8d236 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -120,8 +120,14 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>   
>   	if (!amdxdna_iova_on(xdna)) {
>   		/* No need to fail open since user may use pa + carveout later. */
> -		if (amdxdna_sva_init(client))
> +		if (amdxdna_sva_init(client)) {
>   			XDNA_WARN(xdna, "PASID not available for pid %d", client->pid);
> +			if (!amdxdna_use_carveout(xdna)) {
> +				XDNA_ERR(xdna, "PASID unavailable and carveout not configured");
> +				kfree(client);
> +				return -EINVAL;
> +			}
> +		}
>   	}
>   	mmgrab(client->mm);
>   	init_srcu_struct(&client->hwctx_srcu);

