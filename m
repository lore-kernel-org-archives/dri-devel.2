Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EF4EDB7EF
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984C910E3D4;
	Tue,  7 Apr 2026 10:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MWWXkLGC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EHy1A3jd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F22010E3CA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:46:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376bn9O3402354
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 10:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ovv3xUR68mHIgFCgYKLFv+yIQG1IewaGYjv41OKvUbg=; b=MWWXkLGC2wj8hAli
 FGNann58B9eXEwG1lIm1UweSdTNdKUEzQK0cB+en3pcjl0v6tCzZl8K7Tkyyvy1n
 KoEkdM0xEpzr3lgfOhu1YqH6pXFp0Bbmh85tY8tSO6Np8amkIcsE1Su02UocXPih
 dj7OrDjOYOptdRh8TCqshzqSJKYu26Za0o3PPdKA3/YxVHelrmaO8CLQacFAZ6tI
 zuU4Nu56Hl14ZvynTQC8dQjL4RpAUyqp8bzyb7VKRXDnse1qWwpN/OiJ1dnFF5jq
 pQggZll6hOkz5POE7q7Tf+ofLnm25kJcBa1vGXHIZVBOPIwcX40/g25gbNXXW1Ef
 LMgmhA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhtb26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 10:46:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso66037421cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775558806; x=1776163606;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Ovv3xUR68mHIgFCgYKLFv+yIQG1IewaGYjv41OKvUbg=;
 b=EHy1A3jdWUxdNo/yfwCK3mKSylzjQRad0euM67rRz6LA0kaHEBf3/LJHTGWLXGcYWj
 Hl/eCQiV1x3g4xznyrq8bKZWV5TKnfzB2+X4+JjUQjx6OUVEonsguddB9UE82dzG3bET
 xVEwiNUgqV1kFvZia3bGxdPOVXxZa/cxnVWlQ1OdxdzyELgdnV6NtDAXi3PNnDmvkwu9
 xVJj5GhXrnL5AyEZA9XyrAToIjQRj/Gbkg/t9RvnTjrqMaRdFkfXJx/89IJZ9FjNj4Q+
 p7rtTnzSVS711muK86+rSVYPLz4AKrx8UmBRqktBHUQPMLBblLKoR70s/IhX7HAQqEhF
 8tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775558806; x=1776163606;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ovv3xUR68mHIgFCgYKLFv+yIQG1IewaGYjv41OKvUbg=;
 b=AqZbzY6pzX8sJtIxgw7DQLPv8mldAdsCYGTRP6e8Y81TC6RbJj1IaLvs/HZNFB+qL2
 w3wBicm97TFYoidah+tLWrc5Q4ZfMKhRGOvawnOMV8Q9DFPh2F5/cFHerEvGW3eg2jx2
 RhTtStu8azor4ARrpvWNYa5EizU+mFr/SqZajRnleFJfnjoLEjxEF5hk5mbS1R4h6O4d
 5Q4Tbh9868EB/00LRC1woK/7E6Fi6MO+wOO6CHecOMCxV2FntJlPag4ej9ZjOKVodQFc
 uVj+TEi7Urmgckyak0T//ppfg40Bs5RVw+a51mhX9O0Q0zA8kzOsUAAqmiXl4IK6RmLr
 dqGw==
X-Gm-Message-State: AOJu0Yx/Lr248sR/+PxXtflYKuV0lrnuXwL2oYoDW4BsQoiFGgxFtnGA
 icNy+R5o6o5jgblSmIutJOM0HPJBGqRGYh9vR+7338/faprYfwgO/B9AzrLjKmpZx3ZNewPr9ru
 VloAStqbt0y0nNI0kjVo/zz8trEx4n8Td5UKa+WIvuTzoEIKzab0mIeCTIWplOabK5RvZadk=
X-Gm-Gg: AeBDieu0OdN+GhWe/apCNh9p/bO4adu5WyjK6WM7qTbYuxtBC/o/P+HdMOf+wa7MQZy
 bZluPh4hLBUu3L58pPlTGWN2KBbpiuLposLLTE6ve8bIhuz4wT7Mxv3COXb1a8RdbV3BmVz4OUo
 rbNgaMOlqsVdYkJgmou8yNXs0E7lYsPZCDxraX+P2oge4Xmh/YO0EYBZxiWijaX9F8l/tEIHp3f
 QrEOIP+r+FqaLL1Q3Qz/qhwd5SELUGf/7+PWDXyhYJVB+5COq+uLKKE13C1ldXsllWKCx7ly1xH
 T4ZFDy8nTiUL/XlfXHFTGRpA/8T7cGH5sA2Uc3GJGMzcVrW5S8S3omHH0jiq4EMRNjY37oggpx8
 5bBGgcPANWlBh151BX0rVzavF5bN0jq3v4kyWaggmYQ+taRBD
X-Received: by 2002:a05:622a:820a:b0:50d:aa29:2b64 with SMTP id
 d75a77b69052e-50daa293e50mr7228841cf.33.1775558805706; 
 Tue, 07 Apr 2026 03:46:45 -0700 (PDT)
X-Received: by 2002:a05:622a:820a:b0:50d:aa29:2b64 with SMTP id
 d75a77b69052e-50daa293e50mr7228311cf.33.1775558805195; 
 Tue, 07 Apr 2026 03:46:45 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e52a0sm47139435f8f.30.2026.04.07.03.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 03:46:44 -0700 (PDT)
Message-ID: <86922e1a-b08f-4320-b397-0e6985cf56af@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] dt-bindings: display/panel: jadard,jd9365da-h3:
 describe Waveshare panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-3-5e9119b5a014@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260401-waveshare-dsi-touch-v1-3-5e9119b5a014@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMCBTYWx0ZWRfX382O2WIeNz5N
 mzYTeDwf41fEnHY2RML3z1tsLKnqaCwz07gA/LCA6JoKavx8rpPl1luFmWpDfuKJwBT9Gz2QrGU
 0AKTqwCFlp/aPUTEEfEY9au+IA4a4yzckk7FxLkgORPmtFKDnlG6pwuwkLWMM0PkCMUSjT0jBKu
 Ps0FAJrCZfIggbNmkycKwac6n+yLbcwdgG7mJg3WTM4N8BMZ8p/jXYNfsYsGE+nJ2YX1YkZCOoV
 HIYuL7MKvjm5ENYcBUu9r2R7TbLrG0MqcF5r/2EuBXiVpQlz+QskwvzFZSaLqWwMlFZPC6mkLwL
 hXOjQB1crQ4fdNbuY8B+VVCLRIyjh9kkf2eJMfzZFYbwo2AO1+ymVuVxHxypLlvLQE/VLVJ6rxI
 PgmwlH46LrR5qF+V3ljC1oENObtf2p9XhG18QA8CuDZyy1x4bAGHLvek99SvUk+OgVymTbGh83q
 Jq/xF2APCX5hf5Tmx7g==
X-Proofpoint-GUID: PNDQEuTabioYAmVoSDn-FzdBZM1ElVH8
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4e096 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=R9HfFlAMdinP4lNXC0UA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: PNDQEuTabioYAmVoSDn-FzdBZM1ElVH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070100
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

On 01/04/2026 09:26, Dmitry Baryshkov wrote:
> Describe Waveshare DSI panels which use JD9365 as a panel controller.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

