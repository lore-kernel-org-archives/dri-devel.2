Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB23CD6E43
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 23:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D91410F6E1;
	Thu, 28 May 2026 23:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eL/bxPpv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB60D10F6E1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:13:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 790FE43838;
 Thu, 28 May 2026 23:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25EC1F000E9;
 Thu, 28 May 2026 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780009992;
 bh=IEiBiTIF6bxWlxJuptDnCfTuQUzSkFcxDN1msgpL6rA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eL/bxPpvg4EeA64lIZxTvlD3Np0KEhiIgKElcTdqkbjvO0E+e5ddOAW5yCZy+lIry
 G2+A8xJEmGwJbgtoZ0gbJSdWthDgJd/UuZf1X7Dt+aLIc/2MIJC2NAFG7E6eYPFHKy
 1OmhdkRGC3XTFm5AmfwwttMBUPKcNS7fEdffa9uCz8MmAM+Jyz9Msp4GjjRGxtuiQf
 TD4mXwRv4/hf+NFSUftcK5rTrUw8jJxcpX9i4+aHX22KnSeClMSIr3hAfwncva/etr
 v1vq1OsU8hC1z3ZJKB/l7dyReoizul48bCMZwHQmnmVnX4owuL4OP/WFD+bfhOp8LJ
 C0IvCEZ+2x6iw==
Message-ID: <28dc206a-695d-482f-b434-c27eda960bfe@kernel.org>
Date: Thu, 28 May 2026 22:19:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Disable device buffer exporting
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260526185058.1780869-1-lizhi.hou@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260526185058.1780869-1-lizhi.hou@amd.com>
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



On 5/26/26 19:50, Lizhi Hou wrote:
> Device buffers are never intended to be exported. Disable exporting
> support explicitly.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 2dfdc56ba91d..2727e48afc0a 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -725,9 +725,15 @@ static int amdxdna_gem_dev_obj_vmap(struct drm_gem_object *obj, struct iosys_map
>   	return 0;
>   }
>   
> +static struct dma_buf *amdxdna_gem_dev_obj_export(struct drm_gem_object *gobj, int flags)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>   static const struct drm_gem_object_funcs amdxdna_gem_dev_obj_funcs = {
>   	.free = amdxdna_gem_dev_obj_free,
>   	.vmap = amdxdna_gem_dev_obj_vmap,
> +	.export = amdxdna_gem_dev_obj_export,
>   };
>   
>   static const struct drm_gem_object_funcs amdxdna_gem_shmem_funcs = {

