Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658BA109E53D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B3510E1D4;
	Thu, 26 Mar 2026 02:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NAjgbQZP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F327010E1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:31:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C790660053;
 Thu, 26 Mar 2026 02:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CDCC4CEF7;
 Thu, 26 Mar 2026 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774492267;
 bh=1luHTjr8ISZj/JtJBLwaNEaHlIFIG7hcmwlKfkRBWDw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NAjgbQZP9xdyldpkB7+1mA8zi3L5NCsPIhg5//cvdFEbAvqGcM84Pv3r2h/eqbtiA
 Cu/EqHLRhPSKtVpdVuTY/f5utJlgzChvesqqEPtr3Et13PXBplWut7mHNXTZYO4Mdd
 kb/ZWlrvb/+ewvySSYWeQYaK9w99HD8OaEth0xSMST/lqxP6K4yfT3J2NvARsQ4Vjg
 oiSQ1Xm9RSKkoF/Ur0Tphmp6E8PR2Ej1Oa8hTfPZxQEUZfOSKfSKztgn2fOLjzfg4H
 9GvwmgY3H8AUP414a4VtPWf7z3hJeYnuKj7L/6JYcO0i5Jjwp+1GS8WevM9sPs1BHV
 /sahA8BClidaA==
Message-ID: <b1333a9f-1034-4e3d-a1bd-b6e1348a9f87@kernel.org>
Date: Wed, 25 Mar 2026 21:31:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Fix leak when pinning ubuf pages
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260326010642.2596525-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260326010642.2596525-1-lizhi.hou@amd.com>
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



On 3/25/26 20:06, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> When pin_user_pages_fast() returns fewer pages than requested, the pages
> that were successfully pinned are not released, leading to a leak.
> 
> Fix this by unpinning any partially pinned pages before returning failure.
> 
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index fb999aa25318..4c0647057759 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -196,13 +196,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
>   					  FOLL_WRITE | FOLL_LONGTERM,
>   					  &ubuf->pages[start]);
> -		if (ret < 0 || ret != npages) {
> -			ret = -ENOMEM;
> +		if (ret >= 0) {
> +			start += ret;
> +			if (ret != npages) {
> +				XDNA_ERR(xdna, "Partially pinned pages %d/%u", ret, npages);
> +				ret = -ENOMEM;
> +				goto destroy_pages;
> +			}
> +		} else {
>   			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
>   			goto destroy_pages;
>   		}
> -
> -		start += ret;
>   	}
>   
>   	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;

