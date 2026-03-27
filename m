Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A184F10F286E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD6C10EEBE;
	Fri, 27 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKFI5eXk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OLf8UdNw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A9810EEB2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:21 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2Ptg2217681
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GtqaBpxT2LXyPXWxTBBWQj0QjDmEW2sCiiE6APe9YSs=; b=DKFI5eXkuMYtOMU1
 k78bJARrEBwcXoGjDTSq/3eOVU1IoM48gU1wj1PFYdb6GMV9oI6ERI6SDi9G+RPj
 5aQwxqauUZuYbg3xp1FYhfDHiEaYKXN5xPlJuYyUsInamIGYBhykTrCw8vhNreag
 fkuFmUSgGte/HUEQNPms03kXwZBj0uVxbrt+lQ39mBZiz4oWVb1WSE+cC2JN7jgc
 IIuMCj5VbRmOHEudN7OwYH7/a+H+7fq0P3zpcVX7jr7cPXyUfyHaoVwiLD5abVwr
 T+aW57qDCdh8R6jYAFvHHBEkKtlth+oLBQsbuE/wxl2sEOMlyYAXIDceR47GxwCw
 XkwqUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5w30rqwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4661881eso34462081cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640900; x=1775245700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtqaBpxT2LXyPXWxTBBWQj0QjDmEW2sCiiE6APe9YSs=;
 b=OLf8UdNwbxQIPbw9t+FMgzL45qu0YN6/92+XsDWhl3UJ1eagAJ92qHzTDp5yMoP+j1
 G03Ywvgh+AEHPjVbeSXUuvFfdjhPKtJseeBJJFn/QX7uvHn5bQLw9g96JWTdo3KcjvUl
 o8NkGnuAElGR8CenjQMBJtJy6wv4ME6SKS08ZKqkB61G7/+t+qo1SWmssZPnFkBZaT/c
 xCxcvTq+qmJPLhdfkk1ckKZoqp3kmmC2YlMcwbKB2OPw7bbBNrA1z5bLz7cuyV/b9TnX
 0A4390X+LzJvf4aeLPkZQdzkiydzobfY+tKuustueafb4MgrilTQwcVPp6OwIRpTl0FE
 ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640900; x=1775245700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GtqaBpxT2LXyPXWxTBBWQj0QjDmEW2sCiiE6APe9YSs=;
 b=hJqabAdgPW+MTIyQe0E0bWBydOZujGjR1j50CY2+O3cX/xR5Dj0W/0w2zEDwhTSEiX
 VTLvD460h5tSGm9V6A3AgWbNKbwKMrymcTwcxmOV8SRWTgBXpIPY+EZ9PaiQaMQS/rKg
 EbGMPCmrTw8+fvmMW3qLkfSRn+5jiC6ob15wdF/5WN5EbBUjdCMjhQ7UrhIvXIg0woSh
 rgHNoep7a7WD8jbuMKRm3oFrjrietdv4a0fvmrxBHyOqLFC9MuyQkTo4xevTJgp271jG
 CmtV6JeH8ihXmxl+dWC9ZnASfBbDWov2ojR5IqQ/ZkCoE/C/vfUmvetGm3oWUub3ruhd
 G57A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyj+58Num0fASOaFt6dkKz3ZuZluSxumSmu3XNeheWRLm7ROQQc5hmDhsaFILm30mT5gNSyOjAJR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNls2O4qeBY4PyrS4oL1ldzEkxhfbN+6oden/iBrOljFfQZzS3
 3Tr8F6sfAxQU5wg08q4m85pRcS19AR417sFp/VZOxkNTdpnmkcR+bz/o6eX4sdMWq8Octy4+hyI
 z9bCbBNaKkrG8IPyLj3aWoyEtwPOnf9c6fEeaLUFqFCgAMnefFGLDTaiByeK3NhYA25J6+Xs=
X-Gm-Gg: ATEYQzz95QoQ54nT3RqFPu/0UpHCsgP0taP6NyKFhrx8iQniQVqop+Tzl4fP+UAANY7
 PoXozj8PONOPNAv2fzrng2sdOBd1m0iqqJUClCwcykU1522u5kAFO1OO0kFwLNGFPVjpFyHNXQL
 9vbf7+30s8EfhAuUrZYZCopEbmnAessanqYZf8Q8CM0GeT2FqgX95ULRgXGa4muCtSd0nEFqP5D
 v6Sks42no2Q28CEsn8UF10ehofzHC8i8ca1IX6CVqz46+RQQ7eIOn3CtS4J+jnrrYqqjUuwz7SX
 8Jt2bsnax3IQ4opHDVvzTsb63fC14Y4I2krIUGW+fHG/FcE/Fsk8gwqbqRffiVKOSrJggF+omP1
 IOamuVLY9cY9EqUSbl0YQDg+QJ+/pG76w6FL3JQoYjGXWW+OatI6n9S8wkfqi6RIqO19GcJVN2e
 wIQVy34p7MEm3qolpAfnSgX976jg2bgmxU
X-Received: by 2002:ac8:7dc4:0:b0:501:51fb:622c with SMTP id
 d75a77b69052e-50ba3918de3mr49563511cf.37.1774640899821; 
 Fri, 27 Mar 2026 12:48:19 -0700 (PDT)
X-Received: by 2002:ac8:7dc4:0:b0:501:51fb:622c with SMTP id
 d75a77b69052e-50ba3918de3mr49563181cf.37.1774640899314; 
 Fri, 27 Mar 2026 12:48:19 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/8] drm/msm: Add Qualcomm Eliza SoC support
Date: Fri, 27 Mar 2026 21:47:50 +0200
Message-ID: <177463970838.3488980.16958516986078779184.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com>
References: <20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8QA_GoYhMyi9s5oHJr_iU8qppjSYaF7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX1JKhBe3G0iR1
 5oSZx0Q/RIjgpMUKXxBynm/6XelBV7KgQxtp4so7dsVgssdsPzbPT4JlKb0BVAfvKdovwIiNGvW
 mVO0f8KpWPFWVAlEFdBtNC9bxkM1Pusn7P2n9jEgJkqN2cdauMvVRMUlq4t9ygKCk95L83Ve1cM
 mnq/vQbHhQB4vZFpYMl3h4e6udiYe7uEqHYmea9zC3ri13x/4/8toCUyqppadjJ5qagW+69RT/T
 IINWLqI65pN5/CmpSzFgVe7gGF3oePiBqdiRM4zhnKtFDU0cgjux5lQxjZ39hC/Q6pIVSv0Zmp1
 jIwX+MccqVBaAatXs1FD8SJOfU81MQXFfG3sfXGspR2HfNU53ssa0n4BvNn5GhesU6uaTub74PV
 axtYdTv7fUB1BIdLo6u5YB7GRCcyp76ig7/FaAj03Z7DMOl94HiGjx/mlK4bYPOEP/XLVj2VPin
 ZKPqiaaCpcs5kmSTbkA==
X-Proofpoint-GUID: 8QA_GoYhMyi9s5oHJr_iU8qppjSYaF7b
X-Authority-Analysis: v=2.4 cv=F9dat6hN c=1 sm=1 tr=0 ts=69c6df04 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=7QP2yv1SlOzM556KXqkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270138
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

On Wed, 04 Mar 2026 13:58:42 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Add Rb tags.
> - Changes after review - changelog per individual patches
> - Link to v1: https://patch.msgid.link/20260303-drm-display-eliza-v1-0-814121dbb2bf@oss.qualcomm.com
> 
> The MDSS on Eliza SoC is evolution of one in SM8750, with several blocks
> removed and added HDMI.
> 
> [...]

Applied to msm-next, thanks!

[1/8] dt-bindings: display/msm: dp-controller: Add Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/069a1db1904f
[2/8] dt-bindings: display/msm: dsi-phy-7nm: Add Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4a0172e8a4d9
[3/8] dt-bindings: display/msm: dsi-controller-main: Add Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c01cca40073e
[4/8] dt-bindings: display/msm: qcom,sm8650-dpu: Add Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/df761873418a
[5/8] dt-bindings: display/msm: qcom,eliza-mdss: Add Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0a40e2e91b21
[7/8] drm/msm/dpu: Add support for Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0eb707bbc7fc
[8/8] drm/msm/mdss: Add support for Eliza SoC
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3e64e6959d8b

Best regards,
-- 
With best wishes
Dmitry


