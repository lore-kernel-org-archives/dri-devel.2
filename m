Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A0FB518C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 09:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D3410E5CD;
	Wed,  8 Apr 2026 09:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfkGQWWM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTH5NkYW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92CD10E5CD
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 09:23:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387JZUG2451216
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 09:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KiZ60Bm5/wNkvNavKwZJumFtEUHbNYllnqbCkPd5EZk=; b=JfkGQWWM5tU5X0si
 qJtNVBmFm5gWTmauZcqxl4AdRTTvEkbmZ4/2uBdw5OZA84f6L9JKJF88t/lRLAnH
 z/vI8ZB6YooAS7ffr/vZWN/7a6FtCnW7HGqs6w040H/74RaEdD29JILnh0mNf9yd
 ooIcvS8/lQwI5df0g2B16Ec0tLJRuXNxicXXOcjFovgfFJ1mw0SGBOqTL+NyVDUP
 0Q9pgeNXRmB07CDXOodWqu7BMmB2cp7ZNvWJf9VWoVF2Srg3oz6c+UwOgsbpt6fo
 UFLpFmOnh8Ue6rXfGma7zmKL+gJmmaZR4XYd7oAjGm46YAhawl8GGrItAXKUiKOl
 YoCKDA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae6a1fd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 09:23:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8954b9b5da7so20800596d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775640189; x=1776244989;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiZ60Bm5/wNkvNavKwZJumFtEUHbNYllnqbCkPd5EZk=;
 b=ZTH5NkYWBImIRNYeXB77nrnYxFrE31f/4oeXQztdHFF77jYWILhAT8dRC3aSR38gCQ
 9Fekp7UzZpFBT+j5NnCDjMfwOUVHWgLjn2zTx6vChuaNN07PsPYo9JSgTwf+1k9NTIsc
 0ozInSLQJElTtlMje2gMi2B/9WNqZiaCDaJHIbddDz8DkuPPuWCvm+EdVStbqDWioA7f
 gGm8/Q+IMEGGhNt4Q+8IchTkT/fM/F0HrXv8Xk6EtEi7tq9IUfc+RXWqVfF6vR/eeeMG
 9y0353EsW19QGwcXqe0qI32EV57Xc9XZB/soZRhWCUGFhFMdY4ijYB5iO8t2pcZFY6WS
 0uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775640189; x=1776244989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiZ60Bm5/wNkvNavKwZJumFtEUHbNYllnqbCkPd5EZk=;
 b=DKUKSnrd+O4YnOiPN1x+q8uGeOAZjMehy/F1A8FToOeI0I9f8lWCMf+/kCtwAMyzMV
 ybiqXWIwhnrvxVS7jibODNqMyWCiE6DLQcgNUm7OAPhAq16IopbDFU5djLSgA7HT6/6z
 78lO/a0IGaFW8V4f4zcAW/3HFRKUFoZyn7cE2N239GOGgINtfiCEuhDM1nQnArTVwKpA
 rhJbXgtyZgDXiudK0yZeMhtDnvh1uzPOpsmPiKw2La28Ha1/ERBSzReML5RAoCNcDJv1
 b6WD0yaGeli0ymjJGDK2m2J9UtsoYM21vjXue2nwTBKGwKH5AHmOmpapZy+2a35dCMcZ
 LyLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdlxkSwzCykwhh6llAisW4I1iG29vIxMBmZve3dLc+Kf3UkjGgn8MnXsxIneMw9Hsh8U/gw6af/Is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0f2CiVDgY4sNHVBtXTikTcm4/K2tsR1D5tNHdyn0j6Y84iIM0
 SmpkMgvBhIfZFn5o4xqxAEtSlzBuEyUXFdYne+LebKCWzCrTdMLiw1jP/WplxSOOhinmkQTBTtp
 lHNQzrkhVS5xeZJ1JmCO792pLaGn57VTXVxX0E+clzFZ2XjCxArPy+/RppITHOgyxP/A7vXI=
X-Gm-Gg: AeBDiev7f+lA6qnvAueKPEJrIoTwgLjwqgZHGZIrK4ce16UhCnA55epo7Tm73VjVrCG
 ptPC25yZvO/+7PYs/7LkM6XEPzRm45DKrXy8NY1yyH16z4/9lbi25hnfa9eJi4JzIODlm66vuqC
 V+q2DXzEwvlX2wM1QK+xd1bXG0v+6dM7vQUvbginrqXPYexQkVPGHIUU+quykGnSd+CHKo6VQ+f
 y+iDfIoTBZlO2v6vUezGc/cN5qEUA506TAB9nG8gNqjRrxs6RjN0cwWlmjQpK7hKVNOxvAE/lmS
 vmj4ovyItV0POCVCFSNMLb3zEiYE+8vh2VowBOl4mQbJOSvQDW3gGENa056BPave4JV2dkF5Ye2
 KwB3GBaQ0FVAfEiqpALZMp1cRNjReCT43UBHVMbIGKos41cc4X6UrWDLpgf78LjSDTnCPQGXvwk
 IUNVU=
X-Received: by 2002:a05:622a:13cc:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-50db0327a7bmr32414231cf.7.1775640189356; 
 Wed, 08 Apr 2026 02:23:09 -0700 (PDT)
X-Received: by 2002:a05:622a:13cc:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-50db0327a7bmr32413901cf.7.1775640188928; 
 Wed, 08 Apr 2026 02:23:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cff130fsm630996766b.47.2026.04.08.02.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 02:23:08 -0700 (PDT)
Message-ID: <0dce2f2e-2671-46f4-b78f-3a6ecb068311@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 11:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] arm64: dts: qcom: Add GPU support for Glymur
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-3-2135eb11c562@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-3-2135eb11c562@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4NSBTYWx0ZWRfX8iNEzfkA24Yf
 Pz1xBqIViLRw/wHsbnBuu7I12v3D1AEzy4TPZgftCjvgRGBFPUCgCwSbrjIdMLf+tcUemevTZNy
 HoRkdSQT/2s3OrMWjpRR3tvasXsM32QWkNQt2Ro8c51Duk7alOpcqPJ4UxA1CHhach3YGaMB1jt
 ClJ7jjfogwcif9uL20+qsvJO8EM9+XuY+1D/Xm3hNurjmG6nObnVTi1bQv8BTItTBGO/ZAD0tXT
 B2ZJVAGJIDMm5hWeIYyficfnl6f5pb1Hau+ck93sXYYKI3NDGdSJ/+Uh0wboEwmGdrC6uVzT6ay
 2l2PC0r9rRolU6+8nBckpJ7OYC8EoHA1iInZN8oZJQHMY5bw94mbSFkUkAF0BbYc54PceOI2OzL
 PChb6TV7YZWZdflvisWQ3IrAm3eNcSG+YNi2TG/kDP0l3x0MTr8SPuzWAvBElZjFW9CgIVtsCzr
 PQJqvItN8oaPkzKa7gw==
X-Proofpoint-GUID: YHTxkX_JuqXtoLcosFoaA60Ni-QGstbc
X-Proofpoint-ORIG-GUID: YHTxkX_JuqXtoLcosFoaA60Ni-QGstbc
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d61e7d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=rDmyxzWSWjEmya7nUckA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080085
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

On 4/4/26 11:03 PM, Akhil P Oommen wrote:
> The Adreno X2 series GPU present in Glymur SoC belongs to the A8x
> family. It is a new HW IP with architectural improvements as well
> as different set of hw configs like GMEM, num SPs, Caches sizes etc.
> 
> Add the GPU and GMU nodes to describe this hardware.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			gpu_zap_shader: zap-shader {
> +				status = "disabled";
> +				memory-region = <&gpu_microcode_mem>;
> +			};

My understanding is that we may drop this

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
