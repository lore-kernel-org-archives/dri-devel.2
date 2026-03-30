Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD43FB3CEB
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118DC10E518;
	Mon, 30 Mar 2026 09:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7TrfrOc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RluGB1mW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C91A10E518
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:55:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U9sZca4086233
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Teg2kjJs2++27wL+k0/VJSnuNqL33lQ5+jphN52LdQw=; b=N7TrfrOcqlxzG0mu
 AmYq6rvIioRQ+E6RYjrOAHN6xc/rqAwUKrkFgHBUY1pFv6UFWCITRQWkYg4ZGHg5
 MUiwpf70jdqLNpjsWyOVQEvIouqLPRk9PDYsfbUrTovxQbhA6i+xt3OIBVCObTYW
 FTsHvgB8J0XtLZC2X5ZzZiivCdqZJzQ9T/EFECAFwR4f1wddTRxaANiQoywYa1Cl
 N7/VSGR5GGyScdLnpku2gjvmGCpFn4M9uLhJxGOoGWiBMAHemHanSWU1Kmd2Bhch
 5W5h5R3NhjrAeENJJjNEYDeOiEbWoommKyPvXbOazsBgxJoxgQyv8nQBZRiybG3B
 4F4x+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67715jm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:55:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb485c686cso146583285a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774864558; x=1775469358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Teg2kjJs2++27wL+k0/VJSnuNqL33lQ5+jphN52LdQw=;
 b=RluGB1mW3pPKkGIWKS+MIPSPeh7h+inn8+RKaSvKZxgyQlDDpXg6bXTKrN1Dfa8GOR
 fW/eJpX2gP1cUJtUbedFMlvWQImn8kdlLkQSWmfdqPkW7AxbYseedbxc2g7sZfbcY06I
 fMppGR1yErQicpRzlX+yRm5U0fe5vNnMnnMmJ9pJQCIlLQTLBhTUTRJVSjc4wqL5oAii
 Xfno9zTLdYTNueOO3NCjsMTLTrr8oQo5VRp4175bgQKK2vF6s3dPMtKPtt+ABDjoHXKf
 GdGIjDGpiW2YJU6M7BGJ9JdzKPY01ZdD5l0AugX+e547Hqv9tDi90lhVUxg/24UsE6k0
 ck3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774864558; x=1775469358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Teg2kjJs2++27wL+k0/VJSnuNqL33lQ5+jphN52LdQw=;
 b=W/pUpq5zCOUOUaQbx2jNYbeGmfzaqDA0UNHnYyk7dD/0HRUB6TVSxCiVkyQuTNkXp/
 oaI7SokyDGJksxPT9mAPfu4FuuJWa0wDYh7tgzOpH7d3aErxy4ZGZ9r9a+/ioZ39wm9e
 AR8ixqP8eBM8Ctb/0eTataFn8ahiODWOavuIJHgXwSktzSsA9bFbpzem5YvBljresPzN
 yQ0YhQBYyTqLCX/CBLxFDcJozpv4w74IOStWd8opYDauiuaKcvDTAf9F2fDfih9EaU3/
 3mXYxJnYJDEyVf0LQVi/QlgWRW7Qpsye3iX2Be3iKljL89l0OW8ufdass0GLGfP8X0D9
 hGWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5QoYE5WmF4xa1al+nPP8iAkeS5U+XkK6i+VSoMv+gbF7KGGp2k3g3GmCXYwHF+i3d5l41lyBZwME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzV0yzVzCEDHHt8baEJ3NtHmFoU9/qyJFquzlPJmP7cUzkBvR4d
 6w3Qpa2RKztpEDXQWdIsYEBPRRI7asgeLpI3BcP8wWzz9zesi2f2/01bZP+kgVHlYCnoEab2kZt
 6cubv8YelYetL7vNSgiGNGroMnRPf5eDgEg4KBWBgK2SuvbOsYhelzZTyJ0Ya4NlwmVfDsAk=
X-Gm-Gg: ATEYQzyX+OYRMs85duS5GPKA+smSakBONNj8K3mWFlxnD0yDVv1qyIzPYLV+ZvgYPAW
 RcyHosRFrmgyZuwSiNKKm89P9FRQ2jm5Zg+OV8+ZAzbmc7jDXahrqbswAqF0+xNIobOSo4UGEf/
 gFvPB4wXtjlr5+wGR7eAS92cT+QcFqeRTxwFKme9P93J4Rd59HIlIFjwkLzfFlc0mMvlob34lAo
 4p2doq0REVJwiOWxtkK1EjVCIUeZCkb8Q2YKVsnC+Ml4WGfcJBIfnVfVrW7yMIcWjnI/skHMoy1
 9pesYSfDVQiF/YcbpaYiVmNJq+qrXNhsqIhZrO4x817AnJiNeTJ1tnJFRV9Lzg6E5gpwdaY3xdN
 BpZkp2wryLV4YI+4MiLV2p6ygHaEJ5yhbvyZ2cwMCPHwYlqver7MzelDVsj38ABUo8u0eC0w8Lm
 fsMgY=
X-Received: by 2002:ac8:574b:0:b0:509:2c6e:f6e0 with SMTP id
 d75a77b69052e-50ba39f670dmr116889281cf.8.1774864557972; 
 Mon, 30 Mar 2026 02:55:57 -0700 (PDT)
X-Received: by 2002:ac8:574b:0:b0:509:2c6e:f6e0 with SMTP id
 d75a77b69052e-50ba39f670dmr116888971cf.8.1774864557560; 
 Mon, 30 Mar 2026 02:55:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7ae256bbsm265895766b.3.2026.03.30.02.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 02:55:56 -0700 (PDT)
Message-ID: <2edf563e-ee32-4ecc-b912-d0a19b8e5d67@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 11:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: milos: Add display (MDSS)
To: Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
 <20260327-milos-mdss-v2-9-bc586683f5ca@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-milos-mdss-v2-9-bc586683f5ca@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rcYtYJqGHlx1Gn8a-WKIyxhAK5a_pKzU
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca48ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=WWQFUNGd85j635JlVwcA:9 a=QEXdDO2ut3YA:10
 a=AYr37p2UDEkA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: rcYtYJqGHlx1Gn8a-WKIyxhAK5a_pKzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3NyBTYWx0ZWRfX5dmGEDOAaFkK
 bItdPYU6Q2V2qH4Vv9cLg7b+yWvjuxOdHNuT1y9ALjoWs3FRLwGnDUmstQXWBYT4G7hFlwHmXqS
 Z5Rh68nqKst6LFFndebjnqXtl8bXKUwCydlG/phYd/SrfZ2yvh1Zxz+1g+gbPe3EtFPyZigX++9
 AFYbiKPxBomiHAJZKr70MLhRm3jx2odVcp7Oadcbj2/f0dd9wnSGjSgaR8RFRfWytdl2tasCRNm
 ClMArX8sgeNL7iLKnJ7NlBz4KsLrtldRZ0yXawnYm82R/I5q9/beH5cpPdascxE02xMlJiPamHT
 xLlXDxQ9LnC3n1+aRGqEfQA3BJExgDBL5s8TKn0n63OXmyvcVm8Pm+hxpFE5yQ/Kw9XC4xWuwCk
 TtcabDj77hMZbf/FGtoE0l+roNo+dsjB4JLMhdFoFQ/i6S1HIMU63lho3hCcnD4/wBfVY4oKLdL
 W7AdUmDs2njeaLoapNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300077
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

On 3/27/26 5:12 PM, Luca Weiss wrote:
> Add device nodes for display: MDSS, DPU, DSI and DSI PHY.
> 
> DisplayPort is not added for now.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
