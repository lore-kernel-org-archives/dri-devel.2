Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55AF3D5FC
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 10:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C432910E0C4;
	Sun, 29 Mar 2026 10:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDdB0hyO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cplv2fYM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F3710E0C4
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:12:09 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62T5w0wC294306
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qcamN5b4r83psLd3XWUhDk/8
 Hm8gMoREH44LLVdVMo8=; b=bDdB0hyOPIfAI4NHVMaqK0JQBinty95zlRNWsiZE
 d13UnfXiyROzhzQOjpb28Y/7YVOAVVfLRqeyGzZwG151eCPQTo+Ngur5HYFPITCl
 EX0phWmKFtMeIzRMKSzfLbpz/v3aujEMBw81KbwbiWSfrrLPiYMVZr3CRezvwG0j
 uZdQkTm6U61k5x1079IIhMu9RBIiZ9XBhmtpFO4gDGOMGToUEy9XxePKWtZCPmuM
 OZnV1PCOU5WtA/qTk7g7gAu0y4uNZvufV3ySx70EL4BCKV3mkTJ/n3vayy3PF94R
 +/I6WmrwB3f1dQR79dkbYlKxjHY3WPbkWRX+dC4JrqAwUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685haert-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:12:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso104499381cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774779128; x=1775383928;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qcamN5b4r83psLd3XWUhDk/8Hm8gMoREH44LLVdVMo8=;
 b=Cplv2fYMDgMrQxV1cyRro2fQ0cNYFapMul7jCCuAhnKm7/lIRFVgiKlk41Qbddvkiw
 titQX6o5OP7HKV38FPP0jyiOiQ5BWReIseYHZ21Bs8vylLfRiTs/86tkfG0ssku5uuER
 yBGede7q/jBmnD4Tlpw63gxV/n7mn+SteQoyIPho1DW/9Fx7IGFt1W3V5IS1BvmxmAKD
 kMUEyWVzfaGvPnDAkhFd0qtCawCs7Q3tFon3+sqIfYR3weyEbVLJG9ynuUpXckwpb01P
 /kZiEgu1UGBGOXo+nxvFOdrL5bVap8aJjesycmdx/yYH4skeWjlTwrxI5bMabSbsvcXb
 2isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774779128; x=1775383928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qcamN5b4r83psLd3XWUhDk/8Hm8gMoREH44LLVdVMo8=;
 b=VCW9RM3Pi2fWgSa5OhKKByvXbSBtu+CpBHPHgMyjGghEKKuC/1gTpCv4htpoiqp9u4
 0exNJrmLdtcBYhQ1F5rIyAKUz9t7eUIdf+pat5GwBCF/G5XeltS1vJ6Kf291pamuyJNJ
 iA4u3Z10GtvxPZEcJkvKv92XNaJWgLcNOsVehwIaalCN0lm36wK9wcQ8t/YYyua4Pg7U
 YnZ67O79kLbuoLBIwDDP2L2WTkYqC6fr2LPi9U/CE2kOguJkbN4q3z8WyOXBOQEs09t3
 tI4ow12vrvVgIX7+bCQ4Gn/gDTnKGlYXQAD4VkGDOYFhwAgzMZrOElBiG3+doYH/Nt4x
 wOrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Fepdy38o0F0t1uuTG7Aq6b3Wv8BolU4XvBklbn/tz/VFyXpBgHt02gZoVg3fB1RGUr0Kgp7zrvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7w8G370/ZLF6GwMuLegWT5Mdit5Py4eR/Nnlghajdb89Aoj9K
 JZZFVKxPd1/2YMJGGAuSKmmzW0hSBQv2mQMovW6LKza6V0TEqiKavp4z9d1id3FPiqlWPfj678N
 pSSLxIsf3zbIdhU5VWE2t2z0qFlpnLYPJHd7mq7aLqQ7KUJJdZnOzuXOZDvMpyT/ZEhomEZQ=
X-Gm-Gg: ATEYQzxlLhNUCFekbRJ+tpjpUbDpX+/GS97gfxJKsFkxcIfl/LlFPDAsLsKubhgMEBw
 YdnNZjfgC/x4a/svtUnVacC2jm7PqQ1RoJh6sRB/3yCcEwrD0oo9Nz8Ongqt7FYMRjsm1fD99j+
 w88BPh5chXSKoTaPJ+SZTbzXcbXU0nFY5tmUW4GFREsFNI+GVhODR+whTdPmzgyXTCqpXRJK57t
 EtcctvfJ4vZs4bLR0yrHFGcDxBTYXXWasmEy/eVhzGWQIcEoMuRuuVr9pwndR/sbnlDd+mMKaPX
 Y+u/hnUTyIBoVMqq1BEVxE8sO/Sz4b3z3AHricGRXhuwRJ/lDF+AzPGzFacqQLMWNF2z1HlcyMZ
 RlJIqJeM4QX4aTxELEGIDvCXmdtsyH+pLivKaxLjmyjzixlH+kSSzR8Qex+lzbGPzppAz6XqlL9
 BuUc3Ad3d8dWsb+n3LbDgz+KxWwQEJpaOFeIg=
X-Received: by 2002:a05:622a:1a93:b0:50b:532c:2ab4 with SMTP id
 d75a77b69052e-50ba380a52cmr118052441cf.12.1774779127738; 
 Sun, 29 Mar 2026 03:12:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1a93:b0:50b:532c:2ab4 with SMTP id
 d75a77b69052e-50ba380a52cmr118052051cf.12.1774779127248; 
 Sun, 29 Mar 2026 03:12:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c8389524esm8614521fa.21.2026.03.29.03.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 03:12:05 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:12:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 display and GPU
Message-ID: <o2sbqzcix74u46g74sil2c3b6mgd6zsrmafesoqltfbbrzqhjh@uochk3so46yx>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-3-06edff9c4509@protonmail.com>
 <us3ps4bgf5ekk2iudcgs2wa4b5qd4mzokec4q55pmhb6kvt6ht@qm4mmzdai2t2>
 <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <O7THc5h8ZhgzNpklYKTGOnEZKlN4BtHZHjKZt2KErekNb3E-hizt2dw7xuJ8G6giEyivmvC0f6-eIfCT6fJkUA7_CVQwhAktCXfBqAVV_Zo=@protonmail.com>
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69c8faf8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=sfOm8-O8AAAA:8 a=BrrjAlgp8CM1T73XSN8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA3NyBTYWx0ZWRfX59ErA7a/WmUl
 2TfjJu9ZYVxpsCWaQKenmRkTcMVyrwN/raSNa0BqUrEgFFBlzp+ck5dm466G4rki4nWokow5ApJ
 nfNv79rau1D7+XfSAe7FkqdvCt0nFOAgGhW/WTmZ9PTsfQrVcOcVXHLgO8Eu3kfbK1vY7mummrV
 m4aJdWSNBK8cHq3ItzPzszgCisoo6hd0xr3epL7uJ91PbAKWuCtA9E2mCY9ztl+tuCdOTKO120H
 Vmmy9+3g8TE7T8HZ1V8lG0iUVVGNq3tmmjgKgrCoaJ/yabUKEr89uQ7KI5b9CrYAhSea1A5Xl3T
 8h1MUj55gyKpJ97iWNKTNALfAh41jztw0HyzGGmgiKFOu8hSGzctVm4MPpJYHc0Oh9uYDUlTsGz
 XGe1qW3VNiuwnHetkNrM73q+ccka3GwhV+ngTrGsnhKz2JVHIrvlh2Ltl42JfDHA2szDUocGKPk
 pfPDz87Mnp8tO3H9WZA==
X-Proofpoint-ORIG-GUID: 7kRJPJZ8-552X_dSUEC3iRyDuhvQWHiz
X-Proofpoint-GUID: 7kRJPJZ8-552X_dSUEC3iRyDuhvQWHiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290077
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

On Sat, Mar 28, 2026 at 05:30:53PM +0000, cristian_ci wrote:
> On Friday, March 27th, 2026 at 23:57, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Fri, Mar 27, 2026 at 03:30:49PM +0100, Cristian Cozzolino via B4 Relay wrote:
> > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > >
> > > Add the description for the display panel found on this phone.
> > > And with this done we can also enable the GPU and set the zap shader
> > > firmware path.
> > >
> > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > ---
> > >  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 73 ++++++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> I wonder if I should, instead, edit the compatible property by adding a 
> second string (for the fallback), like this:
> 
> compatible = "flipkart,rimob-panel-nt35532-cs", "novatek,nt35532";
> 
> and, therefore, add "novatek,nt35532" string also to (patch 1/6)'s 
> bindings example. Let me know what you think.

What would it mean? I think we usually don't include the IC into the
compat list for the panel, but feel free to prove me wrong.


-- 
With best wishes
Dmitry
