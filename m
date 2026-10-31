Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DE606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YN5aJTzg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GZLoDL4D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02D610E078;
	Sat, 31 Oct 2026 21:48:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C37310E389
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:48:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJFBla2398527
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4EItL5xvGpqO6UWOBBCZmsuF
 utwBGP9FjsFh6RXA9XA=; b=YN5aJTzguTybW9G+mlI0XJtw+n6bdR+mgrsGe4kH
 a8Dyzz44XUjSs7EpHb6Uj13LvRztzPUNAERCSCVsjO4uQzUyrOoht1lktdmwIwJN
 IB23nBH8TUFg9jCQboo1dkPIHs1ouP3XJ5POq+XgPz1aMiVzUjJZ+Ix5Epq27NKv
 sKdmwHSFLUHcMEu+UbIgQsUykWcPsemrV1fICWURhTyLU9ULzLIQS0+hnvQ3Jocx
 VuhbN/GN4A9+yQpGPF1gvjP43XD/mhfDm0Wfp0x+PVMVgtS4JS90CW47Qhkil74N
 u96yuT7J7TiTdXdJNKdFseH5+s4+L7EdbKpP302HsMVCEQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93ej0a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:48:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ecdc701a2so209982485a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793483291; x=1794088091;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4EItL5xvGpqO6UWOBBCZmsuFutwBGP9FjsFh6RXA9XA=;
 b=GZLoDL4DcpkFL50Ld5rPuVJbCVgHyyqDXSDxyU+Fkqr684fC2DxyNOI0deREdvBr8y
 uzDBDNUlmUP2tVKukRGdX1Wte3xfbipPq7EQTH1QcHEgvvt/b8MfuDpcQKjwODb4Icev
 gHshXxdYJ0DtK5CNXQrW/o63Yfex9F8jWfSqNTX5z+oosQU9vU71h6kjtHro9kyhIlLp
 a3DSrLhF6RhOwzPtjNQWbZ/himX0LNZ8MEqa66ChUfxMYwQkJI90J/D9WVqaNluuRDkS
 HAiejaWIdJnXa0P60nSTAEQgHBumdSoAFWbUhj7UAHRzq6LKWp7o6PVgUqVoNRMWujRi
 804w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793483291; x=1794088091;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4EItL5xvGpqO6UWOBBCZmsuFutwBGP9FjsFh6RXA9XA=;
 b=y92oD02Q/A0BE7rR2myMaUkvkVmkZ5M+nZD9iKhTjPWsxPXJebBw2tR1HwrAP2PVaH
 /INoimgNI0iPsymfPS0aKNIO4p/J2SJVQ++erAO/YPFnpj0DwhiMJB/wCz8se7grY8se
 CdCx2p537dSEx6T22bF8NUi2fdvn8fSKDnB1sBSmgCSr3+JmAe5RyNWjVzKKIKwdmsv7
 xeaJtt/DF4sQ4kqEprcGl3mi/d0BqRDOddUZqy1TwoeLnL6USLVhGc7CmN3yMcFBzLOf
 aHsGZvlaqrxVuNmlfBJyy5WQ/UE9rV8OdjDxpdUb1pP13UoIcpNp+vofgM/bS/AdEAzU
 YQKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6P4C30e0bGQTIJR53lbUyhfRomOwOyK+RfPb8Cw4EYFM2D/jZQlxJ45Zc3QfNcw4Wr3qnsqT1/44=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYItwQS70bNZk5nr3YZhblLUyihTZ4LEQA1jRnt72jgjY51bfKFD
 vAlrArYujGf6ytaQDnkmeCJbMpc9PWoAcI8QlsmqGlM35S8w7lSYkKsjVNvAPEk8hCsr+KMy/cH
 7d+Gd8u2DPw/5rqvrPKKS+9HD94/n2X2sBudNhaEKFNWJhqjYaon1wVrZ2z6s+8k4EEGDzO0=
X-Gm-Gg: AYBFou2QuC9+x8/It0tnptbFpDQF5sZExTfOVgCZPrTxgND69HCP85LElHpHrV2RZKR
 PzQFcItKJDCr1CPeMecy/U7FMrdItOjZRLa6+goinIC7sFInomI/6cvG7zshHJLUZQ45pZk8+Ao
 6F6V8f14s850tO1PVf8icY4biZSbwqn8x46FD/1W4qBBZN7fRyY9lT5x57NhOyT3v4PGuKvj7eH
 dYaM1Qx1rZhIq5tNnik+0kko8bHXvD0P/ejHhD5DmLynPWDZhdhdj8bsDcbhh4dxI4RJgjOZl93
 i1lKkHDzI4JttfG+erDymbuY4mypwGQJE+h3C43F9l0sjGcaWiClmHYSOxdOrLH9QSZjqqgOgWS
 nlOm7QmNkqOvnn57TI8RBjZonASpgHt67fH/NKuPMTqx34rWFDEOnRJL1Bf6ooL7qPMlr31ZdZM
 Cg+JZlGLopKjUnQ/2237krsYkq7vulKoOEnxByODIIdaZkfNckYTK090+EJ7t5Rg==
X-Received: by 2002:a05:620a:29c1:b0:93f:228c:52fc with SMTP id
 af79cd13be357-9442175b13emr960249785a.58.1793483290809; 
 Sat, 31 Oct 2026 14:48:10 -0700 (PDT)
X-Received: by 2002:a05:620a:29c1:b0:93f:228c:52fc with SMTP id
 af79cd13be357-9442175b13emr960246385a.58.1793483290275; 
 Sat, 31 Oct 2026 14:48:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e5e6sm790440e87.57.2026.10.31.14.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 14:48:09 -0700 (PDT)
Date: Sat, 31 Oct 2026 23:48:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Taniya Das <taniya.das@oss.qualcomm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
Message-ID: <dkwloahmxcka2ykjdrf6nh6d6cde6zgd7fe5s763h7s6nv3eqe@pm32d33ghgbb>
References: <20261029123238.29877-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261029123238.29877-4-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029123238.29877-4-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfX6/iLIZs0auH0
 Bv4S7xLb9X4jcbh+9obQKDD4sZTxm01Xdh7+2oySrwauYYCRmx+Z6BZWxBhbJajpkfg9NwPzqLV
 t88UtZjSyFcm6Z+okYFaBt69YCjJ+33liMFtyD4MkQLAv0l8dQGJJsZIl7s6/fYklWkmKDbcvA5
 knA0zqn6BhNODKdHIKS9o6tIXlEy2nfvovFEXHV6lRN6rGMbfhwFwiVHgvwjSQMKbs9KHtEXYXe
 0WfiJqdfklx1rI7DJiVpDnXjwSuIEgsiatcVZD8afN3ehZY+vzf1zcnEGEkDxWEHEbGrwjeo17J
 2Vm37fLHnCHiySU8n/Yy9qT4sjEjWxx6sqTU3NdGUeQvWhDHOEjw42xM8VcpEqGxpB2yioIWGeZ
 XhdBxEDbI3gIOTZd43GsH2VXL7i1K1/Xz2pKzpVkza4uACsKLgm2KPzAvt1EejPTCjzLuUAf2Ti
 HLcTQlOuxEcpVgVAm8g==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae6621b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=b0wOoaS58wixzsa18XgA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: JfYCSKUWC5XwoPjqTfZTm15gvB43Nk2f
X-Proofpoint-GUID: JfYCSKUWC5XwoPjqTfZTm15gvB43Nk2f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4NiBTYWx0ZWRfXyvNsHx0NBUsF
 PUM+FnH+NGDVE9XAZxyNhY8rZfuD+ZcLB9uVBd9E67x5xwl1n4PDF24LccgRUaeOOq7fZrNVpi6
 Eevngfc4qHB1e1UVselhDjkmkXQijWs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:32:38PM +0800, Qianhui Xu wrote:
> The SM8750 display clock controller provides, beside the MDSS core
> reset, block resets for the MDSS core INT2 interrupt controller and for
> the MDSS RSC.  On devices whose bootloader hands over with the display
> block still active (PLLs locked, MDSS core / INT2 / RSC out of reset),
> the kernel so far reset only the MDSS core and left the INT2 and RSC
> blocks in the state left behind by the bootloader; command-mode panel
> initialisation then fails with command DMA timeouts and the display
> comes up as backlight only, without a DRM device.
> 
> Describe all three block resets so that the MDSS reset returns the
> whole display subsystem to a known state before any display hardware is
> programmed.
> 
> The reset runs after the display clock controller has programmed its
> PLLs (the clock controller supplies the MDSS clocks and power domain,
> so it always probes first).  The block resets do not touch the PLL
> registers and no display pipeline is active at this point, so the PLL
> configuration survives the reset and nothing visible can glitch.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> index dd738d13df..950c528bc4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> @@ -3071,7 +3071,9 @@ mdss: display-subsystem@ae00000 {
>  				 <&gcc GCC_DISP_HF_AXI_CLK>,
>  				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
>  
> -			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>,
> +				 <&dispcc DISP_CC_MDSS_CORE_INT2_BCR>,
> +				 <&dispcc DISP_CC_MDSS_RSCC_BCR>;

Please drop the RSCC reset

>  
>  			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
>  					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
