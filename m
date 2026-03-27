Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC25B10F2874
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 22:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0E910EEB0;
	Fri, 27 Mar 2026 22:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T3RUMpUS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9OvEw2K";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629A10EEB0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:58:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RMossf2067962
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0HasHbQ7U+CmeckZsO+aDEKW
 CrV/1CPpy5fZ05F1gXk=; b=T3RUMpUSy2wWFZf5tz1/4GjAtSbNtg/sWrNJ/uHY
 yDAFhfuQo2WfR2fz0VzRBbMcSxFAbe5HXJPftZgfPJgFssqzkpmOas6Biqj6bmoA
 025lGTQxcTevlltWgJgDPiERPWLwhG7Hd/ozvVloxwOpPLz0ozPteKitD2YPfYfc
 bSV4tSLyXKBndBidGo+N/HseYyvhB4zjJkyT1k2TT+0wOGmBcv9mm7kUm0vu8ybg
 LBcRlzpf5za3+a+tsLO3bVFJUhOrKKm7L0mvxZKs6G1OdPfn6IIpMqXL0mJGC+yS
 IUs4VVNZ9wlCjAMtuayejU+jzjx4IRcK3fSN8SYBqirP7g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d631q00j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 22:58:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-509070bda13so92728531cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774652334; x=1775257134;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HasHbQ7U+CmeckZsO+aDEKWCrV/1CPpy5fZ05F1gXk=;
 b=Q9OvEw2K+CEgRR0lN4gg5zvuqhtD2U5jnRORI7e4veoAvyQ58JhN5QXvGTPeDqCKS3
 +v1RNpfZUfT0ZbFV/KcTB9LSSjK4r9Kn7xo/CeHMw2MQeUH4NYExGHEmxmVVJvHhEDtr
 XFfzJm6XMkN9O84+SMXRZAasbS+o+/nAVGz6ePF8opAMz2k76ZGJnZI7TeSvrU1lufO1
 x0cuEWhrizx6WVMPKtJXYS6y21ZPfNCoXi3vU8+wBMg5GOqLHcgdMHFxZoBxxwwgZwBX
 wseQhCmI9RL4/7HTW6ADLvgsJ5dABo+MprgBYefTgjQ3aoVynx4lEDyyL/CDc0N0ca1d
 dltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652334; x=1775257134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HasHbQ7U+CmeckZsO+aDEKWCrV/1CPpy5fZ05F1gXk=;
 b=Npkktmc8sl6XozXmnJSA7Ns4p53FrilUI+y1Y2lwngBo7I9z4atp6bfgfU/w+biC+1
 iSQxN9GhUTRhLlM5ptU9x2oTKFOfXB4yKufwQsyP0wTlmtRU/9JbO2LHH5A56wmlub/x
 se1Vg356VMAg1QAMYn2cfPL9I9wMeJ1aDKSSztx+W9Ao8eRQlZYhlm+AzMJ4MG5ogqAt
 aONOQOxzO/druC1gyfWwaJaZAEdL8I0Wqdkkcx5mIDDSpLIL0LDtMzeRS/4jDDeJEMNv
 sTFkRPR2Kn1eINyUw99jlnn/9Fi0fqICPodF2lCPnbEPGs8LOX7sxyji9CQnR7qj0IjD
 gsvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuVHQUh5pG+vSjC/hBydQGszGU7rk8yne0YZm3FHpgbH99FGdsPo3G1f8zdU9NykACB8s2PGtbgIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj7jBFqUTinGMVn4PaJKdzjhi0yGx/OgCYOOK62Qq5nhogEwJG
 y8pFrCI+yiAVkLt59T3FvIp+bttSEVw3Um/wV13pjqh+gBqkVeioRui+8qpmpubKi4Di0I+8MRX
 SLNhPT/z+spPCy2NvORsII/xg6UVHW0yW6dKO+sjQPtRRvhjyBLCOFkSFhoxggUd3HRyY65k=
X-Gm-Gg: ATEYQzzDNs7HUHu7Soh52xX45nsTk52VppJQ9LeT6wg1zt7YNIaWE1DGoT/vQGYkH5Q
 7iyjDu185E/CteZUGeIFAjviejYYVXbUDQeadb7ChMD/4Hucc7j31nOyBqOFzYMPdUJd31vKjOz
 qtQLUHuUIoaskBUeLF/EHihX6aGf97JX0U7VhLY6ZfUo/7QlD0PHY2El0aQnBgE6UbKlNTivWwN
 7hUgR3oJPZIv9fCWe8rlgf3qI22CWZfxkVbwJ6nEVsM+RHcmMxZvqyywU4Ky/k1+21imCFHPRTp
 yE0vxFboDDGhi9ec06hX8Uvgi+zwcRbyL1QyHpp7ogCImGUNjfZJYdTqOf6kCiZHyTLrCzlyvf4
 dm8ytGVGiKUcKCVW51xnTRSdDIgB6TsM2ulLA4Gjcdnsn/3WekP0Iu8ktnTpE99j/hatCLfsBEx
 5pWSs5M5dJbZQ9q7vrGyOb6FfObT6yTRKMm4U=
X-Received: by 2002:ac8:5a89:0:b0:509:1b5c:fe25 with SMTP id
 d75a77b69052e-50b994a2ef2mr90546711cf.23.1774652333911; 
 Fri, 27 Mar 2026 15:58:53 -0700 (PDT)
X-Received: by 2002:ac8:5a89:0:b0:509:1b5c:fe25 with SMTP id
 d75a77b69052e-50b994a2ef2mr90546351cf.23.1774652333475; 
 Fri, 27 Mar 2026 15:58:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f431dsm72435e87.10.2026.03.27.15.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 15:58:51 -0700 (PDT)
Date: Sat, 28 Mar 2026 00:58:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
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
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 Hall sensor
Message-ID: <skmtzw4acdrlovne6jyryurxnxwlgieqtztygzt6u4i2vchtez@edd3a4576ecb>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-6-06edff9c4509@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-rimob-new-features-v4-6-06edff9c4509@protonmail.com>
X-Authority-Analysis: v=2.4 cv=OcyVzxTY c=1 sm=1 tr=0 ts=69c70bae cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=sfOm8-O8AAAA:8
 a=EUspDBNiAAAA:8 a=wzU05Ad-4HqZ1xQACKwA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: nIU_epKFLYK5E92xOGM1E7byd3mWhF85
X-Proofpoint-GUID: nIU_epKFLYK5E92xOGM1E7byd3mWhF85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDE2MCBTYWx0ZWRfX2uhTKHpZCzyV
 bvrvDI3r9Yms9TO7FsfLWpzmlWmpCCmuYlsLv2xpwbrFdVmwN/k6V6CyzmAoG7wLY74ai8ruYsK
 iBRrLQWF+tc6j0MNzRoyU6BiYkJhXhAiFaPMw6DSU+AJr0aXl/ztE0woBGMKJIaSHWMOFpb9gwx
 abAP8ezvXJlHUdR/MMCI9ERp6qrotER7xbBbRdL/cNi0tmvNUj0tHNr/dUzpe27frkFHtrtLwy2
 ESEFwqCt0lADarppw2PzVuGp8c0ZoCgoF7io0YgU+rnSxU2KTRswQKRDHdVqB2qlov5+z/gY9Q3
 DBq/Kq73QK+SOIvLRkoE0woQ5EuNccZQSzcBcRVzFU8l0fczrC+0YVx9/tqZw6uGBO3p5T5O8yY
 UHCqFVUGM8qvvfXazpyoTbfV33bH/60c0RTO1NKSSxzIWCBsDB57QRGwOtp9LghSgLJe8Wy05uD
 9yHYdkAcNQqQbu1Yisw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270160
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

On Fri, Mar 27, 2026 at 03:30:52PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Enable the Hall effect sensor (flip cover) for Billion Capture+.
> The GPIO is mapped to SW_LID events as in other qcom devices.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
