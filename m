Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E027DC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BDF10EA8C;
	Mon, 14 Sep 2026 00:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pV4RbnyS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jeAacogQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D46310EA8C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06PFU081764
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=m6cyjb8rvJgjpNHcKIGuyrR4
 K/63avLkOqM4IYNdfLc=; b=pV4RbnyS+ZKMb067rnZasHmxkw5OKRNsqUexRM0r
 gLmXg/DXevHf8mGodUB8QyzZnDZAl02+F11Egy56d6rdUCAAa9uUjkPH+V5cnMMD
 LpzwTrQPNMqLPQYuh3X/II0l1XNsoqDcONm/QPB5tnJcfUMSBD9zNkOFlMMXTJkw
 23U2BvVhNUfIWJNjRTDirs8izA22ZC8pLKGW9Jnc4evYRParlF1JMO6GOm50qzgk
 2pYq5r28xIWBLmOoKtkCVf8jnP2DS4IGYlYeUVfxcAgZYquIG9DtPRje95zrslnW
 ZXwtac6UuS5talmniY68gJZTDeGKbxay3bZDh8DMd9lR6w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cmeuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:45:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-798c310ebb9so640864137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789346726; x=1789951526;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m6cyjb8rvJgjpNHcKIGuyrR4K/63avLkOqM4IYNdfLc=;
 b=jeAacogQ7zHGn9MKlxqk8YyqZLipfNHuYFBq1KXRCk/ykESK9N4jlKG0VzPAJfE0nD
 VQS1SAo+0dOC0IBkAWCXyMcgqgh75qFPE9sLqZ7KAz86yhLqrdOAPiOhbdUH/EnsMaiL
 2isukdiMMVRaUbXYaZkjGAcPzSLLczcCN6qeGliN0eb4FEs3V7KsgRkvpwfFOE/rvlcE
 Zj4bftAC+1lrja9pg0iT7GBsbhCzTb7aVCKiNoe3T5W9f+TQlCWcwqUUfJaVV6S+1tro
 pYTcL1Kf5KnZQubZjqCvTY4yzS/wMdrvlHEY0PN3YLvGTyxPBar07ZJ+Fix1b16AQM+U
 fqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789346726; x=1789951526;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m6cyjb8rvJgjpNHcKIGuyrR4K/63avLkOqM4IYNdfLc=;
 b=Nv8hzopmMvzPCqGba7q9I/Plt62qSAAmXOst6aFV5wVM0Sbb5pIKLVgL1gvvEMcKuz
 C/LXLlmopyw8XasizKy9LfEUs1yF1SIgauvecTUhoaidOi2R+ZN0rSQpbnOVCCZPleAd
 R1ZFX8OM8JVVWUJeGo/0Rju5canB6Owz4dH8goc4IBVAIphm+7SkiQdrLxK4HNuu4mKQ
 ONpV5DXNqrmJI0E4bcU0XEN7c0RyqA/3sW71o3jQVJkgVlFKchIvTrFdZFVZHOxe5/4X
 j3osOdH82dZNnG74LwIEIbLlxS/JxVIsvXVUb8s+6OvJBzTTUh4sCG54+h/oz9g3a/q+
 MoNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGjiSs+Q0yDkOlvPPlZjKi23HbzkD5hvrmS5aPl/m70cUZkIgnmyLAMG4AKoLRmHMRZIwPF9Bc6mI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9cI47KZl++ifBTFoaYpQsdgApwXveS/OFa3ydLn7HuJjR0xjU
 oTy/wUlqKnapGHmKKF7+utakzlJBaN9OkKJKULK2Tv/WX3Ff+G5+Y3brM0OYFMkI/Xd2I6WCjpJ
 CmhmhG2Zi3oMwwPbOwQGnBBt9MPjw5NjgyOze9Vodk9+87QkTGgV32BZIoPJFC0TcIkWbJ/o=
X-Gm-Gg: AYBFou0GdMiopyj8AUM1mYpsJUcvapwqtWIhIbv8fV6RY5L/lmibYC3V/V6XsrtJGLd
 tvNcxXVxkIiAYp90rQ2xLB02RN3DoTds6pVJWNQXh0mGJqUXnVb3StJNFt/LnERuJOX7E00Xdts
 brAe/HrYfgt/GfOJjT9kcSLg6rWYQjzyRfanSXMxq6Glc1dmgD/Mo7usLr/kvkAYr+naWtK/uw/
 7++Ocix2clMvo/nlfr5tosrh4QrmuyoIMdai4RvpOwOckvbRZHKVSI2ajG7zCYFAWZqXqXhX0f5
 QOlAUWzYHIEtE+d/ahg+DkuZu9B4ssDkz6+ktaaO8gwTuBHSiQs03w5+ZACxu2xXGJkaP53Plwp
 rLt09jlE9u80KgrpJX9q3jRoj4TybwlsrqPb886/TscnSgBry6JEI6xbLTvHvJGffPNaCA0aS61
 rX3XjqFU6ORiYU
X-Received: by 2002:a05:6102:f09:b0:784:b882:9567 with SMTP id
 ada2fe7eead31-79b5838eb62mr114033137.6.1789346726001; 
 Sun, 13 Sep 2026 17:45:26 -0700 (PDT)
X-Received: by 2002:a05:6102:f09:b0:784:b882:9567 with SMTP id
 ada2fe7eead31-79b5838eb62mr114008137.6.1789346725637; 
 Sun, 13 Sep 2026 17:45:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04795d2sm2093901e87.68.2026.09.13.17.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:45:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:45:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] drm/msm/hdmi_bridge: Correct poweroff/audio
 cleanup order in post_disable
Message-ID: <uw3yo7jli2pv7byofdezzhklr62fegzsxdb4l6umq26nt72r6a@5cetzwxi7cvn>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-3-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfX0SoV7JW9vNqk
 hNOoJmbqMQW/0UOldCxPr6LHu/Y+jLvINVRdUevAlw9S+CJmWbNaYUubCC7GzoJZgYNlYwWMPXU
 +AZJGofx3pzqevnheQWTEPTkGb4I8czJio0v4gOmdcNHetlMzVZ+cjBrHyNwNIHy0268/maBuk0
 KM/YLQbLkvH05GpnFOzsAMEBZPxD2da62j6uatpeQbeEZeeBphhYdRVlGEQjc5COF9qAdTluT/X
 hV9Tbybt1Gr8kyLjbk2iOgLkRyD9E1v9AXi3K6osK790lVdy9YasROAIR4beOCFYPGKvPhfRI4P
 sFbz+NAswgf71er11TGqcy//ddGNtFYT8zlLWxlrdeXl/++Hh7cGoYFWgkaHD0QbSER6BDg9m6D
 Cq9/97xOlK+z0kwXy1oE3aDpt2rGoMo+PF7Gw72LtULjpw7zBZHuxeTTcohzwRxMKEyPyesovDt
 BinVh77lhDY6bPh+5hg==
X-Authority-Analysis: v=2.4 cv=EMyTQFZC c=1 sm=1 tr=0 ts=6aa743a7 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1VKk1TRdkn99K7eK9r0A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNyBTYWx0ZWRfX6fxgTS84Tt7J
 4jKHJncc9YszibXiP9Y4O9HkbFDSWbDFL7qJXMxOVUy1YPFg8cordQQv4bBMbdcv+2nfVkf37k5
 Soeqh0VSlWqtg3jeYWH1O/Nttw6iNQo=
X-Proofpoint-GUID: Qu6ijRe16n-qauAyBaQy7NKMEmBEoSej
X-Proofpoint-ORIG-GUID: Qu6ijRe16n-qauAyBaQy7NKMEmBEoSej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140007
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

On Fri, Sep 11, 2026 at 12:29:36PM +0200, Krzysztof Kozlowski wrote:
> Turning off the power in msm_hdmi_bridge_atomic_post_disable() should
> follow reverse order of powering up, not only because it is logical, but
> also because msm_hdmi_audio_update() accesses registers thus block
> should still be powered on.
> 
> Depending on specific timing, existing code could have accesses to MMIO
> of powered off block.
> 
> Cc: stable@vger.kernel.org
> Fixes: c0c0d9eeeb8d ("drm/msm: hdmi audio support")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
