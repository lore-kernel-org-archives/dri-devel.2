Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18050C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5CAD10F3E8;
	Fri, 28 Aug 2026 14:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kIhGCkkm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6008310F3E6;
 Fri, 28 Aug 2026 14:34:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4870860008;
 Fri, 28 Aug 2026 14:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7391F000E9;
 Fri, 28 Aug 2026 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787927688;
 bh=42IFRTHRgTx5zHer4VK/hV5ApigHwvXB4T1L0ZHIrcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kIhGCkkmIz2nx2KZKyFou15+PXVKUl3SRmC9b87T5hkJ4mbMIXcIakjHeZ9Bym1zC
 0zTxfKBWOKbfFEYHEM6kXSkrLjx0RvashzdpoxI8IDLapA/gIcNZzeawb0dBDxprDh
 CVBXmNhQSUIxBg0sDra1xHAC0W0WUEzcTIjRqNveB1uf5Rlsn4HOYlP/GfLIiQFx86
 pG9tRWneNf32rlXANFcCHppv/RQ3cojn1/cm95n87NGgLX8GhjpGiakzd87Y5TCmwg
 m9dZD27yZjPjS0iYhOGD0pHhDD8pLuUAJE6wciVYBSO4zGJje5pQmB1E8DY3MmjsRV
 EWMFBUi+5x/7g==
Date: Fri, 28 Aug 2026 16:34:45 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 2/8] drm/i915/selftests: Use drm_* prints in live
 selftests
Message-ID: <apGaXnTIuHa5mbti@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-3-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-3-krzysztof.karas@intel.com>
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

Hi Krzysztof,

...

>  static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>  				unsigned int num_ranges,
> -				bool is_watertight)
> +				bool is_watertight,
> +				const struct drm_device *drm)
>  {
>  	unsigned int i;
>  	s32 prev;
> @@ -36,22 +39,22 @@ static int intel_fw_table_check(const struct intel_forcewake_range *ranges,
>  	for (i = 0, prev = -1; i < num_ranges; i++, ranges++) {
>  		/* Check that the table is watertight */
>  		if (is_watertight && (prev + 1) != (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is not watertight to previous (%x)\n",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
>  
>  		/* Check that the table never goes backwards */
>  		if (prev >= (s32)ranges->start) {
> -			pr_err("%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
> -			       __func__, i, ranges->start, ranges->end, prev);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) is less than the previous (%x)\n",
> +				__func__, i, ranges->start, ranges->end, prev);
>  			return -EINVAL;
>  		}
>  
>  		/* Check that the entry is valid */
>  		if (ranges->start >= ranges->end) {
> -			pr_err("%s: entry[%d]:(%x, %x) has negative length\n",
> -			       __func__, i, ranges->start, ranges->end);
> +			drm_err(drm, "%s: entry[%d]:(%x, %x) has negative length\n",
> +				__func__, i, ranges->start, ranges->end);
>  			return -EINVAL;
>  		}
>  
> @@ -126,7 +129,8 @@ int intel_uncore_mock_selftests(void)
>  	for (i = 0; i < ARRAY_SIZE(fw); i++) {
>  		err = intel_fw_table_check(fw[i].ranges,
>  					   fw[i].num_ranges,
> -					   fw[i].is_watertight);
> +					   fw[i].is_watertight,
> +					   NULL);

arrghh! Here we are again at the drm_err(NULL,...) case.

You could eventually do in intel_fw_table_check()

	if (drm)
		drm_err(drm, ...);
	else
		pr_err(...);

but I think it's not worth the effort, just leave pr_err().
Besides, passing the drm device is quite out of the scope of the
function itself, it's just odd!

Andi

>  		if (err)
>  			return err;
>  	}
