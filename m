Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E64BCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E758910E185;
	Thu, 21 May 2026 08:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsz/q4AN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFMM8Qn+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E2110E185
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:58:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L2SxCO3815922
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8/2fOEMVVPBZxITj1fKdOBooT5LNiEmv9iLF1eTMvuY=; b=jsz/q4ANigv0XvdY
 qbhjewZxHqEZgr0dqU+bgP33Sj2R0wl8IQJoXiE821UhoR8gS2+b2NRp+WGDvHp1
 R141VBHLn3FOYZPL+n5VLElstgIiPWmT/8Tj6PviF/ffOZBiJU3WqB3gXGjohupZ
 B8sIEEAFRkrRhXeF4rT94iAG2oTZV/197FnNZqSbcTqC3e1+4jvV8xfgR6lfEnyJ
 6MafDfhqBwR/G6xzIy5JQIuGRLEzosFo+bKzQ+XNd6BpVgnlNrHfwhAi5zJSh1IM
 4IZMcQ17UU5JniBdKF3pc7GezNM2h3DC2roqdLjT/7kLoDcaT1rMdLHe+okAncMw
 T5QXuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa1ch2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:58:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8c183c2eso32032971cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353896; x=1779958696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8/2fOEMVVPBZxITj1fKdOBooT5LNiEmv9iLF1eTMvuY=;
 b=KFMM8Qn++ISgkEhQRAr95PcmhuvtHh+t/+8BXuGyEQGLm3bEO1s0MX06s6Mp/3y7FE
 7KTiGqtopQSMu4iBFgAijlBtRkaDYo3zPz7GRhdw1Purh4pGKaKZBMAAXkkaQzBuEAuw
 p8OrrlMuqZxuZ4XmJtviWFn1lDaflnCjWesHKlz1ntyr0YQxWKRMryX70jLkzQ4Ul9qc
 bmdi76BLwp902HWBtGBo8BabBTE6uUTJJtoZPu+vFvCJsyS5q0AGlbyM15jhDs3Bj7Wb
 MnWlDSHWnfKSSZmbUwu8E2TOuFohbJlnoJQN2z2byXjXOTdISjVFTfpUGZkHor2C1Zkk
 pgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353896; x=1779958696;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/2fOEMVVPBZxITj1fKdOBooT5LNiEmv9iLF1eTMvuY=;
 b=BgAIW0+ht7KeKKU5uTS1PB3MAJOtCBnGxDc3zi1pEqNZrQtl4gbExLel8ihto8AoA0
 Coq4JIKhD6KaNhnHjubCaT9km0BCgN5gbJHPB3fjNR4s6IrIES4vN0FperVWp7OaLY7M
 Zej8M95sxRLtG8rezvQw7fWYXqpESt2HE+GNMklIONcliKfOxTRuuN3eHuD2vEeFPAl4
 B4wwImxoVRSGGsNEP0G1yVM5qF4egCh0SOsLctpM9kJrd6rvmKQBBj/OUBcrfYQVPwFa
 XwaUjJUi9A3dRzZIVZr2NziEZaeJHrCCNJBgqhiPQNDiZFrTXhXOGAZGjHUEBrQgPOQj
 DXWw==
X-Gm-Message-State: AOJu0YxTG4xytWGq/NLUgP7oFqRCT8t89vAUIv01hH/r2+rELf6Ve8hG
 V50z6M3B0mxFlyd7t0JEXBZpWZ5u/qGZFX769HmUDNTRoMzB9hHWvCb/ZMl4zFL6Bj/XGYJGw54
 LmBBB6+VVsfS7o7mI3wPm9zGIId4dfMEzx5e+/0y80yNpvRhXSqCldW72UhGA4yd6P7A258s=
X-Gm-Gg: Acq92OGBhSyRzeLcuxqx7/jRt9DAmRBZ758yuY230OjO79BOtM0jmIJ117hyYd7k6un
 liq0ZTcofsUJ1yvo9C1H2UV65vxs4lapsM1lcTqX8k7qNvCg+ShlicTM/WsJmhGPLQ7i0TeFNrx
 mRbjwaLh1xgoUlT2kNtiBDNGV4eE5Pe3jqm3+uFn9pxcu+MeXzaDwRc7WLyBTyWqLzab5T2CqQf
 hx55d1cgXj/6sUXkq0b13AkGSyFAroFbHYM+ic3H2W3iqH2GCWiU3PlZmDof8McILPsNMksCeWc
 gUvgNRkA32XzfBc5EVhnTqmHpRfIZSiLdf6FLdPf03XsoaYy6jFPpKluy63JJMaGbQLPu79vkmb
 Pli2XATfCFwDXHxCODi605Uy1Kr0BA9UbFUrY3PYOpk2Ucgi/1DZYaioXYDRdxxwyKgId5HDHd1
 Xu6Rc4LKsQKarvNg==
X-Received: by 2002:a05:622a:182a:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-516c54c365amr17459521cf.1.1779353895838; 
 Thu, 21 May 2026 01:58:15 -0700 (PDT)
X-Received: by 2002:a05:622a:182a:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-516c54c365amr17459281cf.1.1779353895437; 
 Thu, 21 May 2026 01:58:15 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6831187ecb7sm8674536a12.29.2026.05.21.01.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:58:14 -0700 (PDT)
Message-ID: <04d53467-a802-4221-87f3-95738136dc21@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: dts: qcom: sc8280xp-arcata: Drop duplicate
 DMIC supplies
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-11-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-11-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NyBTYWx0ZWRfX0SIRgr2z+Xzz
 Lc0XdTNwwrgzhLl0Ia5CmRvJhGRo2p4+iFFJ3DFonXycNEf3fD72xuj8U578fqUl3hdvurXaz9u
 1d1WxkW8bzfK6ydXEUZ6ZaD1RW34hVjJZdDoUy23W7KkdLZWZfob5WjSZindiqgcwNSO6DiLsVM
 PNEdskRKYkJxDeiSJwzZGGa5/7aBc/mOetR7DQF+lMUhJzNIsFqy86Hy7YbioexJiIgtaDiQDiH
 4sHWt7KvFaFTf18sRqr9POAia/1xosppscz1cyvpKZek9GVWZ0yP28vL63li/cf03hyuonnWqi6
 ZvZGvr8gDNpHf5+4qdXJ9esoKOFrJKeLRswuTWXDPfPkmjW7IaxSmrTBSYsSVjNcbYbYTOd9DxV
 Ncdl1kyP1HN8p0xUy/09ixUpJPxv3eWAf2X3zv954AwPsKvRy5RhlXSJTL0ID+3rYbpy6EMAoBV
 mw5ekv5Bf+ERs+PXcJg==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec928 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nWDPw3ULnp65fAu79uvVUAt3uR2WcUzm
X-Proofpoint-GUID: nWDPw3ULnp65fAu79uvVUAt3uR2WcUzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210087
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Align with the reference implementation from the ThinkPad X13s.
> 
> The audio-routing setup specifies two power supplies for each DMIC,
> but only one of them can be active at the same time.
> 
> Drop the redundant routes to the pull-up "VA MIC BIASn" supplies as
> done in commit a2e617f4e698 ("arm64: dts: qcom: sc8280xp-x13s: Drop
> duplicate DMIC supplies").
> 
> There is no functional difference except that we skip briefly switching
> to pull-up mode when shutting down the microphone.
> 
> Cc: Stephan Gerhold <stephan.gerhold@linaro.org>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
