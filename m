Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56EDC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BAF10ECF1;
	Thu, 10 Sep 2026 22:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tip9PTBN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE8210EBD0;
 Thu, 10 Sep 2026 22:21:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD78B601F0;
 Thu, 10 Sep 2026 22:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686621F000FF;
 Thu, 10 Sep 2026 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789078879;
 bh=hMftyWYO7h32qDbE7ZfNTFDE8JGJslDOC+EQt/xXI4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Tip9PTBNfjEkwOldlmzsr09Tpwe1CnquLUhtDgAoEFHcxhb0wIua4iAjduY5UuSF+
 yOpr+asDCW6rms6qq1sbwpgR/N5lt64sg6JCwO5IfmZWA+fwENwgiyIEx7kKIrVcwj
 9nvBWJBdR96bwKC66LB8x6/DHfnclqlpcru2iHeNGko3KclFEzteHEDl15rnGBsEFD
 udFIImfvhDpE0OAr4AlMlsWoEhIdGaqaufrBD4T0Sjw+uX6EyLN7UCDGyv0QkQsjo8
 JQ5pxKjryG5ts+Su661Qu7K59g76opmp8SihhRHlDmq/59+fzP5skM8tmjAC/71GIT
 WmgoY9oTNpOmQ==
Date: Fri, 11 Sep 2026 00:21:15 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <aqMrxRny29Kbtkdq@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-5-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-5-krzysztof.karas@intel.com>
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

> @@ -1477,6 +1477,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		sg_dma_len(s) = s_length;
>  		s->offset -= s_iova_off;
>  		s_length = iova_align(iovad, s_length + s_iova_off);
> +		if (overflows_type(s_length, s->length)) {
> +			ret = -EOVERFLOW;

the value of ret here doesn't really matter because it returns
anyway an -EINVAL. We can completely remove this assignment.

> +			goto out_restore_sg;
> +		}
>  		s->length = s_length;
>  
>  		/*
> @@ -1493,7 +1497,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   time through here (i.e. before it has a meaningful value).
>  		 */
>  		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_prev_len;

Please add a blank line here.

> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> +				ret = -EOVERFLOW;

same goes here.

Thanks,
Andi

> +				goto out_restore_sg;
> +			}
