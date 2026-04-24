Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F36FB44A9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDB410E3C2;
	Fri, 24 Apr 2026 05:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PU9Lqbdn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D5189151
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777009162; x=1808545162;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=i72CY4gqZclW2HGVs581T5Bd7V3pdqJvrzwY2ReUjys=;
 b=PU9Lqbdn1MZY2Khozm95z4Qvqq07xw0C5pqCJEd1aG+fmwfZZEzzS79p
 1BG/I3wAvEXGfVcHPm7xoBOJliuRKJpbukkNc7X7oxVEwgkvT+fFYzOGD
 jcdBGmMG3Jnhc2SCoKVd3TmTmGwEZxV01xlY3QW9pUV16Pk2XIIhEsIBT
 cIL1/RtNb1rgNyhTfyBGMUVHWt8CRNQf83vahMcDFFEeiQtFd8yeRp6rf
 qpeqQqA7CuUNzuOL6nJZC6stAdrMVg2WlKVI2aUSFmGmtw6FSyH5E80/B
 viuxXdF9bjqCVyAbJqyv33KRy6aFZG/rwaRdTBZLS/BabkuPIwl+rw6TQ g==;
X-CSE-ConnectionGUID: t8y6hThtTpuLEhFfaK1juw==
X-CSE-MsgGUID: 0o86DF4tTuCI4XWDXRHVgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77894179"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="77894179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 22:39:21 -0700
X-CSE-ConnectionGUID: +Ar+qhrYSWaePDIEBxqNRQ==
X-CSE-MsgGUID: T8N3xlkQRJ+xzM/l0/nK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="230197519"
Received: from brehonyx-mobl.ger.corp.intel.com (HELO [10.245.64.94])
 ([10.245.64.94])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 22:39:19 -0700
Message-ID: <2a4e7ce2-64dc-4c17-ae51-5e53c59669cf@linux.intel.com>
Date: Fri, 24 Apr 2026 07:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Add overflow check to remap_pfn_range during
 mmap
To: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 youssef.abdulrahman@oss.qualcomm.com, jeff.hugo@oss.qualcomm.com,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Lukas Maar <lukas.maar@tugraz.at>
References: <20260423204412.2861046-1-zachary.mckevitt@oss.qualcomm.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260423204412.2861046-1-zachary.mckevitt@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/23/2026 10:44 PM, Zack McKevitt wrote:
> The call to remap_pfn_range in qaic_gem_object_mmap is susceptible to
> (re)mapping beyond the VMA if the BO is too large. This can cause use
> after free issues when munmap() unmaps only the VMA region and not the
> additional mappings. To prevent this, check the remaining size of the
> VMA before remapping and truncate the remapped length if sg->length is
> too large.
> 
> Reported-by: Lukas Maar <lukas.maar@tugraz.at>
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> ---
>  drivers/accel/qaic/qaic_data.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index 95300c2f7d8a..8a6948f11346 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -606,8 +606,11 @@ static const struct vm_operations_struct drm_vm_ops = {
>  static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  {
>  	struct qaic_bo *bo = to_qaic_bo(obj);
> +	unsigned long remap_start;
>  	unsigned long offset = 0;
> +	unsigned long remap_end;
>  	struct scatterlist *sg;
> +	unsigned long length;
>  	int ret = 0;
>  
>  	if (drm_gem_is_imported(obj))
> @@ -615,11 +618,24 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
>  
>  	for (sg = bo->sgt->sgl; sg; sg = sg_next(sg)) {
>  		if (sg_page(sg)) {
> +			/* if sg is too large for the VMA, so truncate it to fit */
> +			if (check_add_overflow(vma->vm_start, offset, &remap_start))
> +				return -EINVAL;
> +			if (check_add_overflow(remap_start, sg->length, &remap_end))
> +				return -EINVAL;
> +			if (remap_end >= vma->vm_end)

nit: seems that remap_end == vma->vmd_end would fit, shouldn't this
check be?
if (remap_end > vma->vm_end)

> +				length = vma->vm_end - remap_start;
> +			else
> +				length = sg->length;
> +
> +			if (length <= 0)
nit: unsigned long length can't really go negative
> +				goto out;
> +
>  			ret = remap_pfn_range(vma, vma->vm_start + offset, page_to_pfn(sg_page(sg)),
> -					      sg->length, vma->vm_page_prot);
> +					      length, vma->vm_page_prot);
>  			if (ret)
>  				goto out;
> -			offset += sg->length;
> +			offset += length;
>  		}
>  	}
>  

With these
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
