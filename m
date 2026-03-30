Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694071061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB66210E2A6;
	Mon, 30 Mar 2026 17:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GusvJ86L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426DB10E2A6;
 Mon, 30 Mar 2026 17:50:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B886600CB;
 Mon, 30 Mar 2026 17:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E6CC4CEF7;
 Mon, 30 Mar 2026 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774893056;
 bh=Q9spMYTFq+Dexr7WoH95SGr4xl91pz3EmMkNzE9Au14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GusvJ86LVvM8M1LBOnDdFpvNBREKpKTRVkuf4BlxLpIwkJ+6vsvHqHFMSXWgo5OZj
 fV17YtxCgW0g5aYj/GQNEHlpCVGWZcSQUyVvqjNcpVqOeAWb8dG0Uj9pTl3AwQqepZ
 aGwveQBzfWFZUpAM5USstEJLGW2F3ANucCDriGcTB02yqPfOaMn4yfb+Qz7TVbGZfK
 O0XcJh6KiyqP+t6QtQu68wjtVnOGm6aZF1bgAM0HesuLXH7/0FPQLb/1PWe66v24ol
 joLTEhHUvOOje1MUMiBj1ZWLbIhT19FGzTVyyAH10KDFQh7X20MF5ebDrUGlLF5ufR
 CzrJ358YAx4qg==
Date: Mon, 30 Mar 2026 12:50:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, 
 Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/9] soc: qcom: ubwc: add helpers to get programmable
 values
Message-ID: <acq3GSPpZWiGucJb@baldur>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
 <20260125-iris-ubwc-v4-2-1ff30644ac81@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125-iris-ubwc-v4-2-1ff30644ac81@oss.qualcomm.com>
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

On Sun, Jan 25, 2026 at 01:30:04PM +0200, Dmitry Baryshkov wrote:
> Currently the database stores macrotile_mode in the data. However it
> can be derived from the rest of the data: it should be used for UBWC
> encoding >= 3.0 except for several corner cases (SM8150 and SC8180X).
> 
> The ubwc_bank_spread field seems to be based on the impreside data we
> had for the MDSS and DPU programming. In some cases UBWC engine inside
> the display controller doesn't need to program it, although bank spread
> is to be enabled.
> 
> Bank swizzle is also currently stored as is, but it is almost standard
> (banks 1-3 for UBWC 1.0 and 2-3 for other versions), the only exception
> being Lemans (it uses only bank 3).
> 
> Add helpers returning values from the config for now. They will be
> rewritten later, in a separate series, but having the helper now
> simplifies refacroring the code later.
> 
> Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Please find patch 1 and 2 in an immutable branch at:

  https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260125-iris-ubwc-v4-1-1ff30644ac81@oss.qualcomm.com

Regards,
Bjorn

> ---
>  include/linux/soc/qcom/ubwc.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
> index 5bdeca18d54d..f5d0e2341261 100644
> --- a/include/linux/soc/qcom/ubwc.h
> +++ b/include/linux/soc/qcom/ubwc.h
> @@ -84,4 +84,19 @@ static inline bool qcom_ubwc_min_acc_length_64b(const struct qcom_ubwc_cfg_data
>  		 cfg->ubwc_dec_version == UBWC_3_0);
>  }
>  
> +static inline bool qcom_ubwc_macrotile_mode(const struct qcom_ubwc_cfg_data *cfg)
> +{
> +	return cfg->macrotile_mode;
> +}
> +
> +static inline bool qcom_ubwc_bank_spread(const struct qcom_ubwc_cfg_data *cfg)
> +{
> +	return cfg->ubwc_bank_spread;
> +}
> +
> +static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)
> +{
> +	return cfg->ubwc_swizzle;
> +}
> +
>  #endif /* __QCOM_UBWC_H__ */
> 
> -- 
> 2.47.3
> 
