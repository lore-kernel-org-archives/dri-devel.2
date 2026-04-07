Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FE3FF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D46510E178;
	Tue,  7 Apr 2026 19:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Db/EPS89";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ifl15BeF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E840110E178
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:46:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Cjo782549916
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gIjq0YEjJ7jpzlM6N05h5tBr2Wsb2iFf41iaHc/0aBc=; b=Db/EPS89o38GK+rd
 YD38sVl4Fqi8z20nteZ0ZYxzzP1wz/f8eYn8RBklT8lZxpK1OGzQgxw75DQ8odrS
 V9eR6nR7oRJTew4Y7qJhX7zVGQzExbGpvo/Mim+bvI7fQuBatoAyDIuTE2GB8iGI
 DWmIcswTiZkcTzd+BKigVLHWHYgrOt+eMoCMG7wjNZPPTxNIq+q+Ujtf764uerWc
 4R4zaP65LSMURrP41eaYnZtvD8o0FW478kNuw59mRYjdxO9mVaZaq+pXarypvLKV
 SM9wW+IxOL+r+qk7MLSoVqVll15Io67LoQ4/wFX7i3rOqq+p8+HxnSKSog+9D9Pv
 0vJYVw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrecem3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:46:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c741f038f7cso2735827a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775591166; x=1776195966;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIjq0YEjJ7jpzlM6N05h5tBr2Wsb2iFf41iaHc/0aBc=;
 b=Ifl15BeFrkgdM3mVB+84MXEJXC3epms1yt5MpswbiYV7fXN6arqpv9BUbqEkX/yHZT
 L5ZGlgphahaMPsp0ULFqaClIt8jHkUIMFgdMdW8LxdFxez9/uPW61/waeoJn9Y8hOWwp
 w+W6mHw5hIqga7/07LTAqRZNllGxaGmJpwyqeuHUj73c9yAsakdbJHaMjm0VXS0rFYoH
 +t6DMZphab5WbJb62G//04MUOlZPO+6JLPKh4cR+Ek/zK9sVeG90nJ97stkIlypgCWR/
 mat/zRNTiny+3LBqH1I+Z06IwuAzljG1xp7LvTBY3HwmTvNE6W4trXoiWG5z275mhWgl
 wmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591166; x=1776195966;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIjq0YEjJ7jpzlM6N05h5tBr2Wsb2iFf41iaHc/0aBc=;
 b=F+McdCN4uoGSD9LBW5qRTU9xItXAUlgyMbYl3PGHRNCD+IXfq1wgo5qq8HbTCS1YpS
 s9NgLwOLZsz6B30eHZfmcdeZSMUlZC/8m3QiD7CdcMadvV8OYYv7DpzmlsTBJM5bKf/C
 g67L0RUlsVrSTUw7ui28GzYoTOrEKf7Z6E6n61+oWcQO0bmD8ZF6qrmrL1YL6iZ1l+ob
 Tz+We8ckmRMm77TgHpnzLOssy6by1L3kMyFY+9s7GpFvGAdmxOBzwsPjuwQIpbRs/XGA
 16Gd7JkBpPppvOGgWYYwbK6VL19xmOijFVROTkcakXyafzN2NfdFUqxq/DOTfX9WmcWL
 C1SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWRf2dIJpk/GkHivoGiZBqgO5uAutf7FS2GvVn4Xn1DBv8z255tf/loLfOk1w0EuKXcYBEeJ7Gf9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvwWTU/mdWuHr8nrVo1nrLowKB8kfYuNxScSIoJc6jjmXL/5sz
 KSvrSM4xp2/u5IeqskdrX9unoYQWV03NAzwHzQf8VwlFv9LNkXb2HVNDd1NFlEuoiUywahESdLW
 n/0Um1yNezTWAPq+eTrcRWvhwHGVC3aQbBP2WG8qSnFkGAmk5QsYDRJomUoTzh02BGEEgYNo=
X-Gm-Gg: AeBDiev7nd1hIY8pn4z1OvbqtWjkg2CKrIbFOHBWmmbAAJ/gqvQuxM96H+GlVUI4UWa
 Wn+6zURb56bFgI3y5BdpspeJYo+frzdvAqcEm+hCgJ8FiwVrbJ7xEHZuZZk5MgJQD0Cswn1zIvQ
 7EHGJSplaiHcUuKGhl/g7DIjHwyDGv38IMCdDsYGVA3MnqjFcLg8qQ1IdZ2a9dZCEMA7n6RDBzL
 QmjsYX7cZvrynhzeg4arj+/EwkmNQNt8xOq11iUAO6LLlie9PjO3cfzbZnkyezakR3668+VWwUs
 vRrxzezIoytQQn5y1pmwbXGhUC2Y8faSEEATlJlq0ny+xTdq6nC9qotrYktcMmqxMVbXU5j9cx/
 B514WhDIN2azSyBvqGhp6eVgdej5KQG9mq0FCTFzJfric0A==
X-Received: by 2002:a05:6a20:3d8b:b0:39b:949d:6078 with SMTP id
 adf61e73a8af0-39f2ed105f1mr20293001637.6.1775591165651; 
 Tue, 07 Apr 2026 12:46:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8b:b0:39b:949d:6078 with SMTP id
 adf61e73a8af0-39f2ed105f1mr20292960637.6.1775591165144; 
 Tue, 07 Apr 2026 12:46:05 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76d2684b75sm13359006a12.14.2026.04.07.12.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:46:04 -0700 (PDT)
Message-ID: <aeb8fa01-3ae0-42d6-9bf0-226184b36260@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 01:15:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/6] dt-bindings: display/msm/gmu: Document Adreno
 810 GMU
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-1-ce337ca87a9e@pm.me>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260402-adreno-810-v2-1-ce337ca87a9e@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d55efe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=CPVj27tIqRs5YXHx02MA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: LNJhNr9XY_zXykepFhb6ycKcpUzQbo6w
X-Proofpoint-ORIG-GUID: LNJhNr9XY_zXykepFhb6ycKcpUzQbo6w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4MCBTYWx0ZWRfX/KIpb3jbrj5x
 ZIK6DbE5Upf5PT9wYNRHwDgEQYheZHWVck1tZen+IdXnx/Ws6ju9jocUGyaFDJYnTMcIS5g1bqd
 PQBWWuszVGiNqOZaqyRORCWO8zUrb4HAMOKS1aC5Thquy9RFJP5tj+R9ybGqYpEJR33708Zcijq
 deMc5as/ytwAw5spbzqsnTDVkUM4tah1/r6uXhqvpKPfTdH3crPlFyWiqiYFQ4SNG8outrRU/va
 65Jlv+/cKVwHGtohvTZ70U9cHlDw/HjZT4UmuxvR+g2DmrnY4ODchmTDGRbja8sCwdQ7ArAfo7j
 FIl4CKkeqHniNxGovPoMNKu8tMWKOglBTNYqbctEzfuCzg2oYfjhMOI473uW9QEMV1dXvPZVxz2
 KW6BNogJNt95N7dj24bxEImWT0loA8hTwgsjYNgnEAgIvFg7C5SSHr5R4AI+WINW+iVxloxNF2P
 7W6AdIcacoJngYDuz4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070180
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

On 4/3/2026 4:39 AM, Alexander Koskovich wrote:
> Document Adreno 810 GMU in the dt-binding specification.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  .../devicetree/bindings/display/msm/gmu.yaml       | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> index e32056ae0f5d..2853f6aef966 100644
> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> @@ -299,6 +299,38 @@ allOf:
>        required:
>          - qcom,qmp
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,adreno-gmu-810.0
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Core GMU registers
> +        reg-names:
> +          items:
> +            - const: gmu
> +        clocks:
> +          items:
> +            - description: GPU AHB clock
> +            - description: GMU clock
> +            - description: GPU CX clock
> +            - description: GPU AXI clock
> +            - description: GPU MEMNOC clock
> +            - description: GMU HUB clock
> +            - description: GPUSS DEMET clock

DEMET clk vote from sw is not required for Milos GPU.

-Akhil.

> +        clock-names:
> +          items:
> +            - const: ahb
> +            - const: gmu
> +            - const: cxo
> +            - const: axi
> +            - const: memnoc
> +            - const: hub
> +            - const: demet
> +
>    - if:
>        properties:
>          compatible:
> 

