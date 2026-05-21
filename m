Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9768ECD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083C910E47F;
	Thu, 21 May 2026 08:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kPhiLWMS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RO2oGyaH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DECE10E47F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:52:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L6aD0i2157896
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PrEtA8AuXxln3e3Nbl82hLH/2uWUXSrq3eJbCHfTlVs=; b=kPhiLWMSsboB+AeT
 pp+xU/5P7YvW+Jjv8sYPZSMlzbkf8QiD2Guf7BPQYt4g1nS3JqgvAp+ZiR8VOXrH
 /KmGleKdiGqbMc18MQsD6n0Fnqq3ouHA3ZvaoT+VSHk7AbJ0VjR2nlKeYvDwPUmb
 8z5I2NMGtbCR/0ehUF55Cr53TPy6HfGXeFiaa8ASDMBHe0hO7PbGz+MU1wsul9oY
 F2m4KLVOO1o17jF4zU6UQOiPWuOi5rApc730tY+kvaNMnVX+aUYVsgh6g/MSretO
 wX3P8jm5FltKthH/vUauCbZ5XCCliTuY5x8N20ybiSR154RYuIjPh0FPrzYXzTUD
 ewCiOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma42b1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:52:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8c183c2eso32019311cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353551; x=1779958351;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrEtA8AuXxln3e3Nbl82hLH/2uWUXSrq3eJbCHfTlVs=;
 b=RO2oGyaHJCiJif9so9ggbexpwAmYuDNmDS1738H7nS+IUk4F5riPbSYiWObICne8Fx
 DddcKSFkHsvrszBLPmEqFUIk4fKrYd8kREWB/JttgtJo3dslI7wp6GCctlu6HTIyacxB
 qvgK8MF8ym1fMdZwqXsdd84pVGxVx7wMTSWvqbCz+jMK+ySGAYcb+1G2A/TdinT+qMKa
 kRgVMssC0F14cqkxU4U9iPaLuwGPgjlP+TkST6LQxI2qBYCjtD/gFaUAA6xf7UF5LWfd
 GbDMwBcRlF3TW/tJJmVXAKwBiMXrVMf8x35eWhx2DNiWQMb8KnDnWeHJeTQ6S+gGBM/2
 +1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353551; x=1779958351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrEtA8AuXxln3e3Nbl82hLH/2uWUXSrq3eJbCHfTlVs=;
 b=RDqHwWtgLYF73h2RdeC1YzTI6PWVgmGY4WI+nQ2CHynrWJvuieuuMWKfu2flDhMzyK
 R6hbtG3SPnI/XsNs2bgSOq/EHGotvpaLOl+RqY3as6imB5eFHiUCVP8F9DSpe3+9Nt9W
 32DPqFNp/cBC70NG9/RBLUmcU8KUS8QrmJ0NbNJVf1dwqxszsxBekOnvHOj+d0yK1trB
 Yd/aJ8Jd/tmYYnXbOV8zb8GiINA+2B2bqp+rVAmVVZiz/7MvnRFFrKf47d3+3GkpNMje
 9S9Vrf9uuY+dKkKuYG+kV8AcXhxz+DKXGiUv+9kkjqrtEVYBBtTc9/147xEq4UQ2Pkyd
 sOvw==
X-Gm-Message-State: AOJu0Yy9t9+JYXt93bEhmzx5nlnM6jp4Z4eWULzZ3ma4i1cg74jYwM73
 ksdKKm5RyKhNLu+0bCbrW+iCRE5WvgMAGacSeaSHauCqIZYPgDM87sIbVHXdsHYaL15uHmeAaFl
 VkcHigXEBIa6RBWa0oGTMNviAveuASGvOPzM9qAawyglQWQiDtfYrR4489ZoKuXu/0uSoQjE=
X-Gm-Gg: Acq92OFb9WkCAgvy/4Zf1im2EkPC4DcD5UDRYqr4kR/G8uA0WqilgNFJVnM3mMw+/fR
 jTTKVair/PjQ85pfM8bUnEWVLEgD+ZKhA2CNRc/wBEoYLqPWv51BbcLbVBn0Yxk5sbrXWv6GhaU
 JqrvI3DrCqrElY0Q+GkP12F96xqtNYwZT4Zdwz3Ez4qtc2yKJjBxgmzZBYgfrCziG829aOsGh1w
 d2ZKMpQU0CsIUjmYyFvIz4DieaEJErnO/+WIygyCsgGNsHxKM53Hif7c372LrNwCxM1Pz5pfQOF
 oi8N23+IC5g67lB4FURYXf1LTmD7X23NCV48A4pQC0+R4//vQ1rJcwiKoNhcyM3MLRA7MjZa/9V
 Ox/u9bQuu34wEJXRdmUtkt5z7ZlU0x6oJropUC46RwKce1RUkwlaM1b+D5/mANOyJliWv3Kb6iO
 4/Xiw=
X-Received: by 2002:ac8:5dd0:0:b0:509:39b5:a977 with SMTP id
 d75a77b69052e-516c560aa11mr16078461cf.5.1779353550779; 
 Thu, 21 May 2026 01:52:30 -0700 (PDT)
X-Received: by 2002:ac8:5dd0:0:b0:509:39b5:a977 with SMTP id
 d75a77b69052e-516c560aa11mr16078301cf.5.1779353550391; 
 Thu, 21 May 2026 01:52:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc8aa02f25sm17540466b.45.2026.05.21.01.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:52:29 -0700 (PDT)
Message-ID: <418efc2a-d7de-4c1d-98e1-634f08bc3a85@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] arm64: dts: qcom: sc8280xp-arcata: add USB-C
 orientation GPIOs
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
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-4-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-4-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec7cf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 0qki4LWxZGV5DA2x6xVmIBuEbtP1ZWnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX850OVb/RQVYw
 40iIkk7fmqN6gMeWFWT6rfsosoZizTd8GwifD8myadtMa+xBxQgJn7jbaIDEiGj3vPCa/RS3oh8
 8wPQYYRa4hT2z4rZm2WlD2K5PZDs5s+hGP5OL7CEP0F5PWsi/VsJznRMqEIkfrqZhlwCb1U6V7Z
 aESm59/B4GE9lcZNayN07DssgVfcZbqbwpnp8BfhkMfUPxqLRQyP5JI7unQXTif5l8YAyJjYEdI
 5lAK0efKoo6T2HK3oWiIUHCs8e1DnogL/vb87/FoX9W60h6PWp1Tyq/hGVw8L/OU4Fg01m+Q2mH
 s4b9l5ZNg84EJz+gzlbFo3vUpiKlYfyHnmm64mqE9cWI+FCNwilKajd/Wpc5P4o5SO+akU8jIov
 Dsrzkk33CAzna4bODyHnGIOHwnOWDn3sH0e85LKAA+g3nYQRyuDdLEcL0bJKisGc3GMTRUF1uRL
 JyCzRhJcTwRp0CsV3cg==
X-Proofpoint-ORIG-GUID: 0qki4LWxZGV5DA2x6xVmIBuEbtP1ZWnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086
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
> Define the USB-C orientation GPIOs so that the USB-C ports orientation
> is known without having to resort to the alt mode notifications.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

The commit message is slightly misleading - there is no orientation
data otherwise

Konrad
