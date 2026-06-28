Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93191C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C959210E58B;
	Sun, 28 Jun 2026 22:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AfyvBxRy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBkv0LFI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF1B10E58B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:50:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SMjoJ61054721
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=j+vRFFpc+G0V53boa1pioH5l
 DzLNJAkcW+8BSOZcbSo=; b=AfyvBxRyo223qh0kt1HewpkBVIixQE6iJJrQUJza
 vsmwNGZOG5cYLbBgLndEco7RgaWs0/yUywvC5ebhj6yxuVqK/vIze/f0WziDgmyj
 Uexv0Ml2PkT35spCildFcWgRVwnp8m2PlwPMeJ3X7E7SnVPDduJMqvGJPX4lmy5Y
 8nexKvYyJXWUK22nvWwwt+NJcmHxL0CsdZ2SlWlj/NPro+lH3ogUSH01IWDj9B4i
 PDjSjeFltWdBN8jG2+xCIiNusLf1frOEgM5tLGKsXZoZCb+mMs1byPLLZr3fpyEJ
 fuPmbfafA0PyipaSZ4vDSOfjFoiEI3H6JoGnMP3sQ1FD7A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27083q7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:50:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f27f49bso58174585a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782687035; x=1783291835;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j+vRFFpc+G0V53boa1pioH5lDzLNJAkcW+8BSOZcbSo=;
 b=RBkv0LFIsBkZrtG4WGCBIp9nx6SL7aZlV1a3Qy10tZ53hFnFnLYzBN7OEX7vkcwZx0
 6cTUXSS76tjVPoaumAL1DTGqrZQAyuZstgyswmSDw2835vvtjsvjnKte+Ym0oWC3uHUU
 PR9GJZh7XvzzoHib2ZpzyiZ2Rg983FZKWx886C4kipsWNgsSLVl4+BdgTKRqPdU3VHKz
 e/w6s7TsqAOXyvLyyzmz1AGuw+VcTJSeiLQDsvvT9SIe6lOzyWjog5LQN4QGOWzSNM3R
 tWqn6y4s7VJrkTYBkfrccoE57MmWckeGHaMXksKTYu4F8IRCAIDPAc2bzRZgtR3XdyTj
 q6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782687035; x=1783291835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+vRFFpc+G0V53boa1pioH5lDzLNJAkcW+8BSOZcbSo=;
 b=M9R02acBoEu+5+hQ3RTZVGzxtuTA7OoD43CezQfnsRhHZuhODDbjpXd62dudKfwqUV
 3BM0meN8u+7F3nNC4NZ1dHY1sG9PxHe8edsr8lEfaJIjWkhV7CR1E2TijvqLMismTYkx
 KDAxBAlwjJhI6QG8SWytSUlOBUujsU/Vd1ml0o7nQoe2wc3iHMqYiEYzPcmA4KSxbdAP
 mjakXMhzzhrANrLcskxW0APH6kQgaNV7LSopKoiW1U9k6g5EZe/cD+kDrnmDKETtTV8r
 HBB9ouc2s9G/yWjJPt+1uOkeieBe88Fz9kYFEtNj1uiiAi+7LhxiDY9q7LSss3pDTl0w
 2P6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8y4t30Bj0cgViDVjb7Epp8Roo+QFnP+uuvBBkhRCYLsa/+VRjwpKTzpLltBCsnp4xwam3QJ271V0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQtm6btY2FuvssCMSGvKciCjU0AE+hkVETTFmz8hnQDPYMPXhp
 W4hsXXIZZlAEu+FJmSVAPLQ2olhCQJFsNuYWYNrqjfeu2apvOA5hOxpIwg+08VwHPUIoNV4ix0O
 exx1MuPdCYrTd8Pi2EtovtiSXdrOWXBLkG2AKu3aY3bUdtpJxVbXFSm8LbuF43aMQ0/ht3eYXJQ
 JjKhI=
X-Gm-Gg: AfdE7ck+gzFj9BlCOb1S704zw1FwaUK/zl39kvVCL/HSEi+EGgxyNM1iGB/hCf6qj07
 thTOlrHG6tPKn+eGqwIVqJCmA9BWRAvxSIEKOtN2dsxwKhIREtbjeCHrvVJpHrrMg1rNS8LKZH3
 fH+7r0b2AWqilyRu3hFFgHjMMLtcmp8ATSCGhlNpdg7PcqIChLwkl3KMpWgd/z02filvmFQ65V5
 DX7VIJqEI//FJfyCFEOfFObXdknL2VJ1UOahU/7ac/qhLE6pB61e+S9n+hJoaFszTv2NVpfI9uE
 mrmhYLO1wTu3G45Z4/Xj0G4kp+QVQCxGjo94uq/K59/EIlffYTSklGPf8bk3f72+np561FxtC0p
 m67PkyeHXBmYD4wzhBGWaIT5g16ZUEk+u7weqF39zJCh+VoiZa8C4KZKMnaEQMhunemvG9oD9Oa
 mcR+JBR7+uJlMkLUGWDCaOfFCb
X-Received: by 2002:a05:620a:4153:b0:90c:be8b:3676 with SMTP id
 af79cd13be357-92b3ee65133mr1273571685a.56.1782687035216; 
 Sun, 28 Jun 2026 15:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:90c:be8b:3676 with SMTP id
 af79cd13be357-92b3ee65133mr1273569285a.56.1782687034719; 
 Sun, 28 Jun 2026 15:50:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad6957a8b6sm5337343e87.39.2026.06.28.15.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:50:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:50:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
Message-ID: <n3ttyffbsve56cba4x4texugczjkogkv534rjvw643sbqjgcee@iktjvgiqzffy>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41a53c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX0nxORB2SAkO5
 hKOpbP0JUmbT9+esoDKdBYfaBy7JOpKA2aCqI4EPN3bUt+nifuRsuauwCHsZaIUzU/tYAsiVD28
 zJN2OMGZMfaL4xqm++9GTuL2Ca3bdds2XJHW1uph1bK+5+QQRKp3A3vwDMVhH1dfcfgnP9vbFV0
 rmK/dd6DFp47UGLBBeKjnM9ciIYLS4HtyO0fbNwhRX9RkPFfiPLrUmZ7s5NGKRvVLFW4bTdcB+d
 PxS9wl5v4m/B9r705YTMs4YS/vem/SfZIdJ1IsdRHq3OX9KCrW8CBLcYhA8h4o1yxdgILwvUviD
 AzghQ1IoSrg25dJXqwuhsc7woFnKgCwD7Sw/4b6tN3xJccJhXOvkqtBWeLIgSjBMbOLNzr+qxXi
 icmeQI830D1MvoKEYmyv2E2GkBWgFkw5YJeb1FvS5egl/cea151x7sbpRQSutgh8JvpzXIcKFMT
 4j3RHsSBmQ91DltJIbg==
X-Proofpoint-ORIG-GUID: 95OX5dNuSfqce9fV-fmA-JSo79CTRQpb
X-Proofpoint-GUID: 95OX5dNuSfqce9fV-fmA-JSo79CTRQpb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX4fpvYAx6v0Gj
 uPiRMZkUIwISIeyvaQWQi/IgO7J+4oDOSxWON6PVNSsfdZSItgU99fp/wFL+QLQry8re+ivWzVO
 0fWhDj8mnOuei8XJdJvSWYSimRoCF2U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280206
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

On Sun, Jun 28, 2026 at 11:53:58PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
> interconnects, IOMMU, OPP table and the zap-shader region.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 98 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
