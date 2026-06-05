Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B0CCD6E75
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 03:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6CD11A3DC;
	Fri,  5 Jun 2026 03:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gy/68dDg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DEA11A3DC
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 03:09:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F24054389E;
 Fri,  5 Jun 2026 03:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5D1F00893;
 Fri,  5 Jun 2026 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780628951;
 bh=RF7lld1C2j/U8LrOMMtbKUk9ujiZNci+5Q5/wnVxTXw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gy/68dDgaDno8qYLeW7EdfzybY0fEbvhms/oitXKcuUYAGo5IJl6CI6Pyy8UZsMia
 5cP2d5g7GQUYn43QvItriCrXDBpQ0lc5SD1BX/wheuVMnHerhvpHgN80szcnBU9td7
 +CdAJ63hTwyVb/tmYjNjX9B+EW4ZikzCzFBesQ2utvUm6IiP32ZlVELPq8L+ApmJ2x
 qzsypjjJTOl2NKATmMjI4b/G1amYmvy3oCszwX5Avfa8bhoOR/jHzyk5kBFDn5dFrt
 Ln447Yb8PvNCtT+pWRxOvqDkSH4OM+RdsFq6r8x6B8SfwNyQ4hNLSsdnZ1cckXoeOh
 YQKipZw4nIkrA==
Date: Thu, 4 Jun 2026 22:09:10 -0500
From: Rob Herring <robh@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] accel/ethosu: fix IFM region index out-of-bounds in
 command stream parser
Message-ID: <20260605030910.GA1800024-robh@kernel.org>
References: <20260523195159.55801-1-meatuni001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523195159.55801-1-meatuni001@gmail.com>
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

On Sat, May 23, 2026 at 07:51:59PM +0000, Muhammad Bilal wrote:
> NPU_SET_IFM_REGION extracts the region index with param & 0x7f, giving
> a maximum value of 127. However region_size[] and output_region[] in
> struct ethosu_validated_cmdstream_info are both sized to
> NPU_BASEP_REGION_MAX (8), giving valid indices [0..7].
> 
> Every other region assignment in the same switch uses param & 0x7:
>   NPU_SET_OFM_REGION:  st.ofm.region  = param & 0x7;
>   NPU_SET_IFM2_REGION: st.ifm2.region = param & 0x7;
>   NPU_SET_WEIGHT_REGION: st.weight[0].region = param & 0x7;
>   NPU_SET_SCALE_REGION:  st.scale[0].region  = param & 0x7;
> 
> The 0x7f mask on IFM is inconsistent and appears to be a typo.
> 
> feat_matrix_length() and calc_sizes() use the region index directly
> as an array subscript into the kzalloc'd info struct:
>   info->region_size[fm->region] = max(...);
> 
> A userspace caller supplying NPU_SET_IFM_REGION with param > 7 causes
> a write up to 127*8 = 1016 bytes past the start of region_size[],
> corrupting adjacent kernel heap data.
> 
> Fix by applying the same & 0x7 mask used by all other region
> assignments.
> 
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've applied this and the rest of the patches you sent.

Rob
