Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F52C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88BC10F3B9;
	Tue, 15 Sep 2026 09:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KLK2liwT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5p2OKQn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAC910F388
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:53:58 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9hS4t3560954
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pF/QF/hhxoHrOKiHFcOtOanP
 8OYOtIshKOaIzZ6HLNg=; b=KLK2liwT8BmNgKS33FVJjQLjLmDLdquSsUYoHrqq
 hrg3EOqWjk3mJv4Gm/qPyKVJAo0/oWHqTNmKLSpCuKkYmbeSDZucfHMwYGZnL0GI
 jD69y2mBQdXOcg8geyyJBqNB5PD0p98bqHlfTL6kq7n8fDwlod2R14f9D9uAxg/i
 Y1YqCDk0wYBfOtO0zdRDWA59X/7Qg2FxLUxQezMGrtgXGQqNtBOv+dapzgPRKxT2
 ntMOiww9EcP6OSDIMIGzae61y29M1pXgIaG5ijroRsjokQBaowPa/7IJMRo/7dDv
 9JMAKdCQrJgs6mivmcFBDh4nlhCYZn6NXxuIBMn5PTaICQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9uv0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:53:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a08ff8451so466557285a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789466036; x=1790070836;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pF/QF/hhxoHrOKiHFcOtOanP8OYOtIshKOaIzZ6HLNg=;
 b=O5p2OKQnDnAs+3t2ZcxB0gykwc64xd869BR70B+BXDvl7YpYqoXUfp6KAmsKV7BALY
 6zwRzZJyZHofZ4du8wiZ/Jv21EEjCSzix93WKuao7c27iTz/WDk3qDd7pNb0m3mi6TKq
 VuDTKfa/frKlctGkWmAhLdJ8/ikdhAFwfLxwYdetdC9qHaFSqay5nFruq9uH/aMBspMI
 e+CBRckGxREhGgfE3+wuX0JiJt+TJEqeWrIg0PQscxSe8lQrXJEorC1Lwm4GgnORaMJs
 6HNlmvbX1pKHEmtkoRt6HS5CeXcU+kOtkSykSKkFKNAAVeFPjnZAohItYJNsHB6QK/aE
 llLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789466036; x=1790070836;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pF/QF/hhxoHrOKiHFcOtOanP8OYOtIshKOaIzZ6HLNg=;
 b=BbrrqzPN/6TjPA9roXwD22GPM5BWgoAqyylaiAaKgFk5cNHXuJbrtxthRUNyr8tnls
 D3OgfXhPqXuncTsexwoALmFNmWlOUCsT90v+/SnC8bhj8pBgsem+tevt0vuMPKsQfSpv
 6acJnjpTRx8r0zoXaQJpT9xuIzSiuwWUGXjiRzKVEHfl/l7vLppE6Mu9JHGVpGyXby/+
 0/k8JulicVZ1RoNiRHOiCnGG6cRUOlPsgDXTEYLGbb96VbOxRkjwkI4tO10yKTOG0q4+
 S8ABv2a5goxqoyiVKkr6uB04AGBq1PEQ/a+6WVcPgBWwDzYGzzcGhRZZqaxEF5eEwLZV
 Ef+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvcoJ7fJ+RMK2cbX0087k3vFb6ux5qrr54VQGqDNdZNLFysh3iIPex5+TIQMe+Xjc4w+40UQfrCLI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAFNCOn/5Cqfyt97GU4z+QXkqLTHC1bkYnZuQuUVPS+pfB7ybQ
 +6GP0+M4Lfu0lv8FShrUhDGTFWVkzZiVfDBYE3uWbRgojxLt3gV5B1N0ZBwQQnVbmT/S2Hw5RlF
 hell7+kTquApF3qfgSPyyJSR7ved0KhoAH3c6tYILkXVngieLhngKnBRT925ZBo4HT8YluwM=
X-Gm-Gg: AYBFou2xo2E7N9ZfRgWXC71yJXmMDh/soyF7qq0EtsYRTCs9GQ4QKZ0O1MRRyhcDXEA
 zJZAdFtjsUnmKxEqFReBtAdwawS/WS8VsfYQB1rl+gJWd/06jNleQd1AFfZU0+0Fgg3JZFSqfQR
 2JSjeHfKx8xUqG53Qe97IhSqPVkuKzBXO8q29xRykGzMHPufqxH5cLkGXtRbaZEop0HqvX1aDPx
 slbnCvjIbOtNEIA6ikJRm2k4/MTMzHvG95ln3tJojez1dJEr2VCcDfL9jBVXwATss4LQDrR7rNM
 fKGHppTgpoPq+iYqFVm5HyvIMNpJS0xQGkBurG5o9KRAdA3jwO3e08iV/DuZTXuXGf3bd3NH7LD
 jO5GdbKTd+olOsg==
X-Received: by 2002:a05:620a:199c:b0:937:6771:e7e7 with SMTP id
 af79cd13be357-93a299f58c0mr218164885a.30.1789466036476; 
 Tue, 15 Sep 2026 02:53:56 -0700 (PDT)
X-Received: by 2002:a05:620a:199c:b0:937:6771:e7e7 with SMTP id
 af79cd13be357-93a299f58c0mr218157985a.30.1789466035894; 
 Tue, 15 Sep 2026 02:53:55 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e8249e3e8sm4523405e9.12.2026.09.15.02.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:53:54 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:53:52 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
Message-ID: <saph4ecgnjpxd2fxeg277aihe2lnybkfk34ipb2nkg6wamxytw@qpm5cta6cemz>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa915b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OUGWfBxzjYAD_LoOebAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE0MSBTYWx0ZWRfX7jjJsXeWBSah
 +Xpxn3mer1xq8aOUFCoU4yGFLUHsuu9V6WQJKZ/1f+62cV0BtZfqjBnKFlVJanth3u0fa7M2wNl
 QEIS3qyJ+B7EcWWXOgFwq2XiAvbPnHHnbVn1ylxiS3WP7wqiKv8uoI9qrqELegHihTnpaDWGd45
 ydNhJ3EmZJRAL+mBRv4yKqVnGC/KtH8UsgEfxxs3aoVwKwKsiIAANxhh4VD6gr3KgUwGzrsKX4j
 7wuJkCP6MDoGdtEnPeuykiuzgtlWKsMuu2i02/XZBEzuzwz9y8FYVsuwBApI5ya6Dcf1WWSC4L6
 WnI8ImSAwQQNXl3BHpR8MLOfhmavRC0UBwTKJM3GGF+wk8gooVF9UEQzzqOg3tQPqSvVjoM7Rq1
 wzusYRiQojrnaqGJluOskHjSWRgH8oOpE097oGISZ5C9sHIY9jextbAMbRUkHTIPElK9/a79RAP
 hhgDhbSbUMeiRsQY21A==
X-Proofpoint-GUID: WHKqzv9vGvEbwPZOXfstSrcnazCj8ZuA
X-Proofpoint-ORIG-GUID: WHKqzv9vGvEbwPZOXfstSrcnazCj8ZuA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE0MSBTYWx0ZWRfX771fNLp1WFef
 VASgX9A1Ab4HHO7ikkpo0W25J8dnpWKIKK43HQY8Hb6gpTyyZGF7CilgVCdqq5BxGZJJ4tsfwPT
 E1L4XDRK8nHlln3HT4smKeN/3LmeWuE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150141
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

On 26-09-15 17:27:50, Yongxing Mou wrote:
> The INT2 GDSC on Kaanapali (SM8850) powers a subset of the DPU
> source pipes (VIG2/VIG3/DMA5). Add it as a second power domain of
> the display-controller (DPU) node, alongside the existing MMCX
> performance-state power domain.
> 
> The MDSS node's CORE_GDSC is unaffected, since it continues to power
> the rest of the MDSS hardware on its own.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
