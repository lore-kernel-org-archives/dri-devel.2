Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42D9CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 22:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023A710E41C;
	Mon,  4 May 2026 22:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1S7IowS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ap+EARG1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7652C10E894
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 22:40:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644KmAAB366515
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 22:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fKsRobYlVid8ozPAY7e2ux14
 j9F4sny35spO5DP0VcI=; b=I1S7IowSpcYgHQ4H0pXji/mLJv8SEaDLiv/VUtgp
 /z/FvWfVv0fDY24+m0OZoXQnGzvajzffJn169AGtzLyM3aYgk0+JY8oMisC3Uqab
 bWlYwEOeVuHCUbGHjGJ7s+trig68WzJhmOcnpy9nfd0LSdcIwjhL8nLKt7lleAy+
 1Y7PVLyqeEz/mlIGlNv9sFnWvSi928tP8L6/O1Evjw59pso+RwZnnP21HLRQLILa
 TvY0lJPOfM6fC1+pWb+594MNE+eWojJ/040hW/3I3rg6g1PAVOj3xYFtAotXvJXn
 gS+9sKljpzc5TeA3mi5bicUZ16POTgsIgNeoR7iuIfaGew==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6swu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 22:40:13 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56fa1c1ae6fso10318179e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777934413; x=1778539213;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fKsRobYlVid8ozPAY7e2ux14j9F4sny35spO5DP0VcI=;
 b=ap+EARG1LAzlA9IcgDYv5MTgZtDy6/bFQYBhy1gWGLoER5Uf77PVAd7/IDjlCax0/d
 jLFcR8mcWS7IZfscJVnN/gfz5/pO6uOPin1CFPHRa9fcruL6SG4uTMMKyqEAgoKn+GAT
 gFbG86tJyz7g/tzcYzuTeJrM+YRQfPDbje0rl/eA+gUyt+NgdK3bKCvwqbEuaGTBUAaS
 djiezfMm/BhYSSsuRGotKp0ibSfuXD6gV7NOutRNO0akUoLdt9Qf0TR5TRQt400bpAdU
 Pqu2ADP2xg2/TcP7nGP2hVKsfQw9765DmtnF+olCWww90l4mZJez/6LIosOHqdXjOXa2
 s2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777934413; x=1778539213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKsRobYlVid8ozPAY7e2ux14j9F4sny35spO5DP0VcI=;
 b=KAfpexvMg7KX9ilqtxjYdRZa5jHQrtdPLuf1mbFJz6XJtgQ4Sym/eebzz5BFF9uov8
 ytgAGfXnXr51xZp76lT/BxOyJK+vB6wuCvdpQd+iqcw0ob2HLMkff6L3UUg01OolJfoL
 SPDHBU5WdhsXL2u6s9oSOJTSAyK+ReDNt9quBNQ3YqY3IQc8k2gJgEZaGV0FMP0UN+VA
 kBM2AOJwX7VcFc9cXjKvhP3a5CDXJXBZ2vSnjxX6Yb4QdbMEgnkSnJo6MUxBIyavsuqk
 g9QlijKPTdt/fjEkMlxt71yhEvUaZ4jYUd1YU/bV07CAuP5Rx5P9sj8UxuvMIXRjzWRT
 EfBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p48v9iGL+EZvhQsUVPLj7PtrQ+d+E+8VRCZUO7HG0nGi8qfBRn/kDCRMbTB1y9kC0M/AnGlPZACM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6RW2qG9pFkf6gldgExJkOWQaeSXiu6UovxhMBcnlTqU+S5rC6
 GW3Sy4SSWUxyRDEKvZc19tbnCRvxI1SZPDR3pYs//PSpta+Zj3nqiqEGUC9QI9sTNqU0VECRuIz
 UfRjgUCjR8KZgDwMZOvgne6C5Cj4pwZbgmvOWjUj9FD6htpU7s+R9X8Hrfg/kPZfXjOqTWCE=
X-Gm-Gg: AeBDiesfd9mO7YNAAnBmmxuTkj9m9guooUiq2m6x28AwUpXVeBHW783txlrhNy3J9lW
 ge+MoJPtcmrjk3JeY/BBAWbM1TETuX0vBj0d5JbaRtSkUaNou9PRTGkLh/xMUr3mm7VaSrrnrj9
 n1nJq3cpy4M2ivfSDW4Vl5/rZP/VKe0UO+haNwsPxu9rnBt6Y4jXn28veUPOzLBn810TJXtiZr0
 PhTiXEFI9xzMJI249k5JZylqGz74BATBlCLXe3SPTzPcfF87no3iNra40eYTPcYqvk8Jn9X+NSU
 vxehjQRXFpsw2bw3q5bLZFMU14Iv3b6gCwt9xLqu7ZVcJPJoZ6TC8qjKTng7JASJaMiGqU4+Lma
 1Wltko2rllwdw9WXmH0rvsOiB1wKQq/3zLvRiAepm6o5FuFpo1CJWlRe2yEOMSQRMEcIQvDMkNf
 EymOVFTxK0kVsKUH1zqUTbeLN2eovBxu7v4wutOY+IaWJdBA==
X-Received: by 2002:a05:6122:896:b0:572:353f:be2d with SMTP id
 71dfb90a1353d-5750c6b2f14mr6080129e0c.13.1777934412950; 
 Mon, 04 May 2026 15:40:12 -0700 (PDT)
X-Received: by 2002:a05:6122:896:b0:572:353f:be2d with SMTP id
 71dfb90a1353d-5750c6b2f14mr6080099e0c.13.1777934412502; 
 Mon, 04 May 2026 15:40:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3936108fb8bsm33734251fa.2.2026.05.04.15.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 15:40:09 -0700 (PDT)
Date: Tue, 5 May 2026 01:40:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: milos-fairphone-fp6: Enable display
Message-ID: <6hygg2pm6fbp3scdurycihyov4ffgpkd4szmtjvwjpok7qbfk6@czbszxhvn7ev>
References: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
 <20260501-fp6-panel-v1-4-e09cb05651cc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-fp6-panel-v1-4-e09cb05651cc@fairphone.com>
X-Proofpoint-ORIG-GUID: zZguLRGPFCvsOB9q8tz1m2rDHyJdcTQF
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f9204d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=t_WoDEAhxH4J7FjSGWwA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: zZguLRGPFCvsOB9q8tz1m2rDHyJdcTQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIxMCBTYWx0ZWRfX2ps5EM55L6G3
 CESD6z1lPbyHllRmCYfPT62mIN3ZO9r2dWNMnxdwnupR+pyVPrv9kRvF/iDvmYjioke/Ej9Tza5
 yQIpoLY2Mg0gRIopHzw5O2TY/wI9LOVbENcqxsZa5moog3dZ/kENVu9zCnfDNJj+2cRj1NfOhUB
 LgYz0g5RByXKKr2AYjVARFYhtLXSYtq/Qh/k+6vHCIVH7SIZz/pvSNEeT46p2/4P5qkIBCiCPFb
 /MUOWxGTRkobNmC7iFZwjN4AFoUOGwu2/aArkxTvesQdwoede5LgtAkaYFmAyK2gYb6Q4VfVB6W
 y8xhft4U6T2C5tiIGnxioWc+hVjNQHw8CVCICb0MVtuXNDSVFfaSCQeXYM1Fa+ejNIoicV7RGaz
 VR9nnkMcbk8YdV7EvVQiexMpPC9Dz6zN4VVuXe82YhrB8KM6IkZsZXH7zDj2OnSXA+bAn0vOFcb
 X6Yl4dqvuJiZdJh+v2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040210
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

On Fri, May 01, 2026 at 03:52:48PM +0200, Luca Weiss wrote:
> Configure the MDSS nodes for the phone and add the panel node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 

Modulo panel's compatible (which is discussed elsewhere):


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
