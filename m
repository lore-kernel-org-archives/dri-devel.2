Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72085606A33E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ARLkfSdQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HvVRbRqW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4D510FCB2;
	Wed, 11 Nov 2026 18:12:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC2510F997
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:12:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtZUD353388
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TpPJpMAeykiKgpS6Mi0eAQJ5
 tovbRl/3UVD0DVrSzfI=; b=ARLkfSdQVS2TC9m6CkNI798Zv9qBSMWtcTE2iZn5
 SDFjKpoOZxE5RE9jg18lKnNpM+YjZu4VFePK18NW5XOYAaFQzMjuB07KVSELqchO
 gRYClwlEK7Vhsk75GfiG7XOvQpbNp/ZM4BVCzO9OV2RWST+oOilqAEGh5omut/jM
 rQ7FIOc1238CCxui37iRvEm1QPePj9ZbMc+qCUXNOExHpSelMuQ7m7ApuTGBo60y
 TdCUmuBjUsrvXZhaUjTvB6dgPgzQ4OchwCPtEi0baTEkWSUmhr+ECWdkoE9Ge0DL
 aPkUXsIH0myPC1b2z9T1K6rQKptfUvgPBM3im/p0rb8Hqw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymrqjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:12:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9440b27c1feso563517685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420766; x=1795025566;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TpPJpMAeykiKgpS6Mi0eAQJ5tovbRl/3UVD0DVrSzfI=;
 b=HvVRbRqWvjCKpbPV9LN5CEFd+FlZFgV1Cv5MJ6BYw9FZ6sNSTSPVFqD2JAp2dSgPVr
 i2cAQWUaoWhTSyzY4zLpa5pZ4CJPq0q/g08sH9+j6KNNoeJ93G3a9UE8wSxkK8dfvyQA
 DOcl9EuHp4OIsOOsfHeu9RMF95vKH777IgwKh07HXj3cno5RwIWe5aymB0aevF89i9eb
 tSZ0xnElWtrJAwimJ1FSD6Dd4NjdP41qqOKYfmh/TOqzPW2vxxtgfF0w6WqRNBTRHIC8
 Hcn1XSZz6uX+bXCrO6jymTMT2P+XAQPnGN+/vSBhOOy8c/pIB/b5waLFteKgVyeyBg1z
 htRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420766; x=1795025566;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TpPJpMAeykiKgpS6Mi0eAQJ5tovbRl/3UVD0DVrSzfI=;
 b=1gG/3fqp1WMtIL8A46cGzsk08E6HQFYNrbtk1qsF3JguIdsiQclQ/2yKX4s1USf979
 xobzSP2YEbZNGO8X7pjcqOtYpjFI6bhk2If34Ma+nSc6ILCp04pomzuDCXcsytyzPGRy
 4D+qZtbuN5sGXrx0Kyra0uW8oyocssZyhzHgQU5qJkZZ6nnXZcV8yJi7q5MMPTL+6Fyz
 WrZUmvDKEB978xM1IcJehML5VzuZiyLzFgKUTjSBa6zuEPwb8RVn3MHXSN1RIu4VdXXP
 5ZBld9LF26zSg5M74K88J4+yue5XUIFpfZ2C3skXQK82OSZ/I2FbNZPBVSIhRF/PVCMU
 flog==
X-Forwarded-Encrypted: i=1;
 AL+hErGo1rpvtUf60+vTLKA37Y9HyVrQkiwCuBlMB2MZQDIvfBnqGSEmgP7iLT7un9E4bMyOSx7zUbejopU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+stwBoTc5eGuNIyx64bSUFz+D3oxZ+gW7rMpC2owZ+4A7umJwT
 TnBAgoA+i+juSx11V3gJz0ZNs6hbhfEWvDMrb6M3ZjqG4VzXqvOlDuQ0EGCq3S/a/MX5WLdOdH+
 07w19DoZYf0ZrWDDEtD4NWaR7ifV8KWByrM7rHoIMV4iObGgeFST6XyjdUJwqR+A2t9BZySU=
X-Gm-Gg: AYBFou1RVD96Jh4racTH31yI17RpmxTXfh1B+H/RDj+y7tutvxgURtu6pDmr7KMapVQ
 vDzBxPiqyhRaP1d3vBKRdXP6p1YF0ZbrcvMTONX5XSzSfLQP/b/sI5SkxH/979lS89BytJIZZ+P
 qSrPLw9ZqFsE69rWPoYq6mtNp+GN2lPDGzOBmBIQyLdLzKCP4fvrPK4DuW8/cKGyJFbnD+rXNA3
 N40ca3BlC/qwrKsaZJpE23ed18OktagfHV5o4fxzW3SVRlmlqJgnWybxvg8xFPW679EWYLdnf4u
 vPs+Tlf8ujv/JRBRW+wWv88ZYNzPM41W8UARzeUv29l+zhR548Y+S3E0qaCjKOOjw/JVO0Prt/X
 ev0VHiTqPbzfB4/JpwFKiNBnQYRdk2V85atvn0lPUTHhvddR7splBuW+RYTjSFNtFwIjwIDcli4
 dI0CNkgLJegYq86RwvOSriP5w0vZDq6OM8vjJAOubA77Nsy6t4Y2Rr1U0EGyiChg==
X-Received: by 2002:a05:620a:3955:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-947b001b12amr487872785a.59.1794420765738; 
 Wed, 11 Nov 2026 10:12:45 -0800 (PST)
X-Received: by 2002:a05:620a:3955:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-947b001b12amr487864685a.59.1794420765248; 
 Wed, 11 Nov 2026 10:12:45 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae115a2e05sm6544391fa.19.2026.11.11.10.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:12:44 -0800 (PST)
Date: Wed, 11 Nov 2026 20:12:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/3] dt-bindings: display/msm: Require DSI graph endpoint
Message-ID: <wtwyi4b4s2mynolj7pqk465cugahmtklhodmg7yehdmvubusbx@p6dhg7iwon2h>
References: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
 <20261110-display-msm-of-graph-v1-3-0f3106f817b4@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-display-msm-of-graph-v1-3-0f3106f817b4@oss.qualcomm.com>
X-Proofpoint-GUID: 5vnkuj2ty9v7iklZfKBlZ_3t7oSp7fup
X-Proofpoint-ORIG-GUID: 5vnkuj2ty9v7iklZfKBlZ_3t7oSp7fup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX9zqlgvI+h5nL
 OOlal01enHKKmlg4s6X2h+UM5lvKgwnJzQ0tJenf+hfiDnhwmhwFZjOeJ5sIhmK0UwJ8rnQdJq/
 qp5uFAj5JFuWSmtB1tLrxV4LzEscZQ57uY+F6WJTq3hVpGRryChCsgQN0AjtyxxxIjhMbjFoF2U
 bfDrSso+GHUrS5+hRTBTtTnQH46Felx+2jNtTSfSVhbVOoMW3jUO1aqeK7rkVeLD3cqrCMJrQgj
 R+d4I4c4FF/gVajKwmJD91q/WtQ7zKBlVUP/Gl1AWA5tZBVBksnLyLs5Z6Q6uzL6bVLfiNy5R3I
 2WcKmfz+WZgXHQ2R9rc0J9jve08ju4O/5840JW72Pflqum98Jk8CLuuRhL23wu+vMh4Vm60YFPz
 jG9iCH2hmQKV7xP55JGcWQcsToNRgxJy6F9F/v7GdFTMqMhOymgtibsx8R1wZ6/sAi3ctsAo8OA
 F9qNlbrMWQrqMmUjxfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX+dKmVlJYTMfE
 kPagzmdmP1w4nErFpKHVKDzY7USrV3M3WPYhfFiZFU4xqJOf6gw16HOy6y/imya2nijBDi2M9dq
 RLFNEDno37Gs3coXaRV2nt9YW8x1NPY=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af4b01e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=T4xdjuEbw3p0ivj6QRwA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110072
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

On Tue, Nov 10, 2026 at 01:57:44PM +0100, Krzysztof Kozlowski wrote:
> Technically, DSI controllers do not need OF graphs with endpoint to the
> panel and could rely directly on their child node (when panel is the
> child of DSI).
> 
> However Linux Qualcomm MSM DRM DSI driver never implemented such
> approach and it requires a valid graph endpoint pointing to the panel.
> If it is missing, the drivers will silently accept such DTS in
> dsi_host_parse_dt(), but later fail on dsi_host_attach() because number
> of lanes is not initialized.  The number of lanes is initialized to safe
> default only when there is a valid endpoint which is missing data-lanes.
> 
> Extend the bindings to validate existing DTS to match expected ABI.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 6 ++++++
>  .../devicetree/bindings/display/msm/qcom,milos-mdss.yaml          | 1 +
>  .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml        | 2 ++
>  .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml        | 1 +
>  .../devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml        | 4 +++-
>  .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml        | 8 ++++++--
>  .../devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml       | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sc8180x-mdss.yaml        | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sdm670-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 1 +
>  .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml         | 2 ++
>  .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml         | 1 +
>  25 files changed, 48 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Note to myself: per Rob's request this should be applied only after the
DTS changes.

-- 
With best wishes
Dmitry
