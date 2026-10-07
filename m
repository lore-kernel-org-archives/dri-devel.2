Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60787CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713DF10E6C1;
	Wed,  7 Oct 2026 20:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bLc/fvJ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9257B10E6C1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:45:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35AC342AD4;
 Wed,  7 Oct 2026 20:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED571F000FF;
 Wed,  7 Oct 2026 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791405950;
 bh=n8l2PoE90t/H1EmocqiyivcQZJzqCYsnIlfoHjqAV3c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bLc/fvJ5f7/X/1VPu0wgiRuv/RTBT3dHKmcBjuCrcfWQI+3kfkGeqXR9Qzo0SDuMe
 7DZO9RFdjAbNyAl+AWnFbNLh4rbTlhPEfb1Yh5WJdpKMm6oLpS5+9LHP31x/ELrGgU
 okm39a/XfJK4FiH2F7C+UVC0LtvDt3eztrMW4KGv55n6Ib7Htk5aGMi2XgwUp67RK9
 0ZV3TF+xDEQsIbc3rtmRhT4COakNa8tUNZdonA8hLk8DF26UlS46kCkFkmY+P5J7kj
 DKX+kl2trvU61hudemiNRltQPzYwxL3AoVuF059EWnDYOjSHorucpjV5xVnCkL0ryH
 bsqgJy5X6MTWg==
Date: Wed, 7 Oct 2026 15:45:49 -0500
From: Rob Herring <robh@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
Message-ID: <20261007204549.GA234290-robh@kernel.org>
References: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
 <20261007-glymur-dtfix-v4-2-31f7143e759b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-glymur-dtfix-v4-2-31f7143e759b@oss.qualcomm.com>
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

On Wed, Oct 07, 2026 at 03:51:18PM +0530, Ekansh Gupta wrote:
> The reg value of a compute-cb node must match the SID (the lower
> nibble of its IOMMU stream ID) it is associated with. In the cdsp
> fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
> mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
> 14, which don't match their SIDs and leads to SMMU translation errors.
> Fix the reg values, and rename the nodes accordingly.
> 
> Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
> Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index de7c395d9c35..3219603372ce 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -8471,9 +8471,9 @@ compute-cb@8 {
>  
>  					/* note: compute-cb@9 is secure */
>  
> -					compute-cb@10 {
> +					compute-cb@c {
>  						compatible = "qcom,fastrpc-compute-cb";
> -						reg = <10>;
> +						reg = <12>;

Normally, reg is written in hex too.

Rob
