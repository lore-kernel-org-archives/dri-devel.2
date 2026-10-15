Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41CACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559A51122C4;
	Thu, 15 Oct 2026 10:48:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56F71122C4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jgHM3510197
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0OZMHg29644rNWbo4GaxuaRmBYNK1O49lNyql6VgKs4=; b=OGEzkrva/xzsPw3k
 FFF52HXYiJffBL6gde3MMJzNJtVzIncBkLqoZen3uOFl+kNL+r0zdeTgyj5Dz1Qk
 T+IK2oulH1tDGYGdm8AIvUWPISjop6R/4Wjfb2Mm3pg2F0ura7Yx8QZ1PgPcMOPw
 hebYv4ZrM2gBo2eFdZ9hf1/6/ywDmG4DPJlfc6Cw3FkRoUeJpTdJ3eCjZIQe1Zkm
 +60p0vrAmC9zU2raXcBMcJH9YBA3IczUEok7NH02V8TULNNwAtdAKil2iX6SVji9
 iwVBtx0KzwePLreL/yx4b28Zw6XjhQ2Oh4e0XMXU+bdBhY13n9Cy7RKYGW/kBUUm
 l0nREQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds9me6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53568f05f8bso14870111cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061325; x=1792666125;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0OZMHg29644rNWbo4GaxuaRmBYNK1O49lNyql6VgKs4=;
 b=bl5pFhKTD43smvgeu3TT72hNLG+jJcq0ZHhfsyDMIwIrHtE8eYA6uNrsVNJM/s2DoB
 lnyb70NZxd0OOg1q7RPKEMwMKmQmRayV69j89wU8EtF20j1lE9tmdPm4qoMaQMf+AkKe
 LYKZvgky0BEqI1Ta5rwCy6q5lity3qcr3QSuLwCVfH/WQeL3ynzUM98kzrGwVvDQsyvG
 nScAx+GENbd+shpJElPUVBG3fOAN/OHJcVDmD6udsT8uAL0DkEdP2c7K2+cKQv/dcegt
 kWutzCy9Z20ZnpyoWTZfJtpARI8L/d75qEsuplvaG/+ZSeCk90v8HjXgkJnYgIXKAP3D
 qg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061325; x=1792666125;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0OZMHg29644rNWbo4GaxuaRmBYNK1O49lNyql6VgKs4=;
 b=DM2w5HNRuO1MB//Cxi/cizyFN5TE6dr4NqTxZZKYONRB/zo73QAFb+fndEZhh1cq0d
 0quN929R3ZU6u4o0nRjryd6CzFx+xRFCzs3qfLLC9B+NQzh8QAlG9fErcE5DsEuS3+e+
 l5daBaDO34BKI4lglwhanSxqrGkeXBjMdNKanQ3PmcmCG/l1zcG612yo//hn8Ed2vFfn
 DCIHmwLoxNuXnlt0SBvc9I5TpHnxEI0egRadaWNVHtUCE3nT40NZpKYLuuZLLBRgFncO
 C/bsZe6upzY/QF2wm0BSPz0sYhewuyFWmRm7dgCJaXMEZsj23jWuSY5N1tlOH++b1KNA
 l9Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWAM6XXN3VyOAl40fdwRiz10sBr475RwzSilF1nRWvrqS05stU7VS5SLQQKc4jsFtN5w4r6zlBGsk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLTEBuMhKU/akEt6bOw1NZkRuKqPvJu2bK/j3Q1F0mkH4VXJPYq
 oT5PA09i85cgGbGM2DmS/nKaoPrY1YkNXvpIrDNeYyLXvBYTCs85PIzIJjLcDpFnJEc10RG4adC
 rY+Xd+mFzaWp/v9/U0hHfnaND30NaboAetqaogqc8hXTG7LBXVsMgO4xK4jOUxSkysM2WWDw=
X-Gm-Gg: AYBFou00tRGVLw062skvIkQCUMK3sm9MkEWaeEcvyKcHZ36/8WZjMb4pjSVhwnfpXL0
 hcHowVb4S8mCSurVqk9JeQJrqF+v59oRLH8pbYXQqJNV1ynHRQ1EDiJVYmfTqIawOJS6wF/vm7/
 q/7KJ4PXgkgnMJ8J0NNulUt9Y3kEBS+rTfFQXoiiSpLQu0cZIm5ctoGf9vvCUQTpLPCAW/hH3VJ
 lxYEzRq5XmcjEGxD7Nx9i1dOGEK1Z+C3OwrhPiIXsigdgI/5sRr5B57OprgRX5Pdb023YB5Fbpn
 XXM85tBc4B2Qgdu1Di5vSIgloft39EBlOclM4mMSR7sjOW17idwNz7nkCkGMXLMJsOIKENwV9xM
 QTNgAtNjUhbwBRP56f3gUkQ==
X-Received: by 2002:a05:620a:45a1:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93ebd1ff38fmr3641740185a.3.1792061324935; 
 Thu, 15 Oct 2026 03:48:44 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:939:9205:4d78 with SMTP id
 af79cd13be357-93ebd1ff38fmr3641734885a.3.1792061324391; 
 Thu, 15 Oct 2026 03:48:44 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed963e710sm109029866b.20.2026.10.15.03.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:48:41 -0700 (PDT)
Message-ID: <da480a5f-ac8d-4dc7-8358-e22cbccfda52@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP &
 MPSS
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-3-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-3-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TnjWbQQTdzulxA9cJaME9SO5TDxofFg5
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0af8d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=81bJPUnbi0zmkLSSE44A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX7OdZ586N3ort
 GOEG1QUjwmpM3Ik1zpb+URsG4TvN7DMfMbp2X9J2hsgSHjUBDamxsjmbnXnlYUK/ii2rLKFe8XC
 tl5KVhc2GdYk6wLYBFCb+DoXiYsGphHFcJfmOmbIHU/m3fz5oLuasT5Yq4946uPwIkGUIMveeEI
 LQQogv+hXrE9hROjrumxwFDxntDBWfCrKtQ2xEO9KKk1HB8Wp8xDy7f67Fhu81dSyD1KsTDXHGJ
 djRYDcIg8sRrisx87luGPXOsg4J2k5oEENTEj4wdfUSl5MIMtkDxz8Gh9uDp87e9sBl4v/RwxJf
 bkFt7BW1MGbvsPpp5Tot12A4MIL5v6sE5BYdmC/RE0/yfmrV9mv6VP1L4XVu5qUNWofL0rP12e4
 wexubv9Gyu6gJlVJGPj/l0SNAg1G6hmAUo9aUCqUn4n3O9I5oir056f4DZFQ2CjF+l8Ob/3fOQU
 TJn83zvH/VssTsaXbeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX3jA2Oy8oxGx5
 ZR7ML52XKmU0YC7DX8VSncMLRploCURzNfV1ODBFlRu9ABEivF4ZN5rG9a4LET9RyX5Sgj3lIY2
 cEjoaC7csfGTqu0rll3dtaR5EgLNC/8=
X-Proofpoint-GUID: TnjWbQQTdzulxA9cJaME9SO5TDxofFg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150042
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

On 9/26/26 4:00 PM, erebion wrote:
> Enable the ADSP, CDSP and MPSS (Modem) nodes for the Xperia 10 III.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
