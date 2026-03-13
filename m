Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E322D105F78C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DB410EBE2;
	Fri, 13 Mar 2026 12:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2LE2tGs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0hKAvdo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4685910EBE5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:33:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DAsF3k525821
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BDSd6M3ADucBUh7vaHNmBoAw2ElUft2U7rcIQs+bGmg=; b=N2LE2tGsId8fohuo
 cpgbtYagjGt1ueDsCHwFSzVhhDSG5ASaiHRm3AE3TXTbc4zyfJbGQlCGglenjJx+
 FFaZm518+/X6bIJ/+9R4Jur6nHWQFlF1su6J/r6zBrZnOm14W9JfgZeswk/90WjL
 XVsbLjl9fcqXCt4gDz1rYXb4O2EFt/AmS7ij365mmSoub+HLVW/GmIzLzCvyVd+n
 d+fFcAwG+EphWz3jrzcbcKH9k+ZR5Krge8GyedeixSzCRtFIpYXtLkdmX0ZOOF3/
 TmFfJqd/KmZ0Kc7JoAZztv0w+nX1dIDiVfUCY6pCfCpd3uMqzPKqnqho6lKfdI8L
 +q8uSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84r8u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:33:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd90210336so93513085a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773405204; x=1774010004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDSd6M3ADucBUh7vaHNmBoAw2ElUft2U7rcIQs+bGmg=;
 b=V0hKAvdoGaiNFL38TheNOCHpNEICxSPpl3Py7RibMz0C6xBMjEJpS9FvQ056uQNSe9
 DACBEDJQGTalFfDyJf7v/VkkeIgXDDfk8tFrQjv5eTfB+M34S+cmIwvJzh5UqKIpZ5TT
 N0fh5CW+pP3hy1csv5ZaOeNyqvXLkWxsYdvShY2IAs8AXN/VgHGHToF4fzj76tnEf+fh
 4dkVBS5lAwgwI3H4WYC4yixXxp6Mof11orqoCLSfyxVtV1XKxdCtNjkKWnuU7lMODy1C
 /kyo2sMLcqNnoqP+fzmWM+56OGFpBKRm45MB5DeFPYv83V6uVXIfc1zSoNYELoMcnzcV
 xbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773405204; x=1774010004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BDSd6M3ADucBUh7vaHNmBoAw2ElUft2U7rcIQs+bGmg=;
 b=OkjCVvgPgiU4cjAOujRpgPad865WhR2ASM7j4ZyMfkSvwQElmelc+YJTmJBWPKjylD
 oy7tPXPymcNMFm7/UJ6JXOsI556encB+X107szAPsQsRRW4cSFxtF1q+J4futqig8iwW
 3alihluTwHP5xtNq3Ezh0tNDwlYDaiEO2AqXcAKK8d9Ym0341QByZG3SsmiFkjFyPDyY
 3YL+/g2aI344nQdcgQzgJ+VNndsi4LoiiywGJi4rOFLvO1mGfJR0p46qYM6+G6LXP3Bb
 8maDrKL7suTLgcLukEnHDkeGHL6Q+MfsGDYX4G8xm6Y+v4F4MnGTeCMRzZiBJCng7dNT
 TN9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+3MMVUv5vOsiS1I8HTfKHSmdyfW9yJxlr1ewUwPpSrKzZH6XnVrqOkA0+DvanR6mRy+QFHtefo0I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1GNEp6H8Jop79XxzP1wkm1GMLdulHbDPXrUVv6i/oFSB+SNuK
 ccxtO10M7jDdCJXbfd9qPEx9ubRlTIu9xeyniuZuc/NX0KHm7rYF3EksVlZn7wJqGLOL/7Dtubg
 xltJi2fOsVKUwoMLCpdl8BScgmsXb3eD0r/6sVO3kMyL6jBwlYPHHllJHBmh2DBBHd+3JgrI=
X-Gm-Gg: ATEYQzx3IfbgPhC4ht4kUncHPAYe5Z70y/TNTx/8VMv3lmLlRYdOEcLItTQZQkX8UqW
 kHlKGfWsq+W1v54klwvxOWczf638tcVxFU1tUXKFNgeH+wXj/7xPwuh+LoGz8TCU+FXibeUwJXB
 zXxTJFoCw0jWTagc0kLxjdT6OD7y+oMKPrYupIr/c/vtB7rmm8ec5HmkaYJr7Fjkli/lriPybyj
 N3OG5ybWNmuwAVckHBX+iG2kc0YzvJbuzdNvik61qCxhZY4IPKqFfBSur38nB+h/82tXEdC7T/v
 yPkzTreKKGIxzT5oIl2I/WI5oGAAnP8wQrHVGAJPYeL8cG/V3z/aOgNC7CiRrgbSrZAHDwvSfrx
 GaGoZQ/zV9siZiTy0Kw5Fc/Gcqvd+ssAn1OiUC5KHxANxShc8vEaXHJVB2P0Iwy0nlHGnl/mhm1
 9+NJI=
X-Received: by 2002:a05:620a:44d3:b0:7e6:9e2b:6140 with SMTP id
 af79cd13be357-8cdb5bb356dmr351084785a.8.1773405203713; 
 Fri, 13 Mar 2026 05:33:23 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:7e6:9e2b:6140 with SMTP id
 af79cd13be357-8cdb5bb356dmr351079285a.8.1773405203234; 
 Fri, 13 Mar 2026 05:33:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976d0b7722sm41877066b.66.2026.03.13.05.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 05:33:22 -0700 (PDT)
Message-ID: <4d5d0fe1-9aea-4ace-a369-275cbb728afa@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout:
 Enable MDSS and add panel
To: Yedaya Katsman <yedaya.ka@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Kamil_Go=C5=82da?=
 <kamil.golda@protonmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260312-panel-patches-v3-0-6ed8c006d0be@gmail.com>
 <20260312-panel-patches-v3-3-6ed8c006d0be@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260312-panel-patches-v3-3-6ed8c006d0be@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b40414 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=sfOm8-O8AAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bqK5-dEd6McJkE9xslgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5OSBTYWx0ZWRfX/83dwSfoISER
 5Mmwc+NuuVlJq41PW18LpGBsV/rYEl9MYkkF4kTP2/1oomUsbSQN+oBw8qRz6+i2Tbq7hUK+dku
 RTpFgrnkxo9DuVEt+qYbSQ3Ad4SVloL5IYsc147mHAutS+vi7qO7lm/qX+QfgiN+IbeavLskYoa
 KEAnMGeaCE2GCS9FsG9WWR+Yyoz8w6cWyQA2yg982Z1MsvyCv+ad40y4wgVpewrnyksZuQ3SxY9
 7uNchNbwH09tyR8AQmETEPQ5GqIMEU+DRMMWapJPh18n8mMws86O5MfIHYj+FOGnVGfrDOdaJj7
 6K+hEZtkJP3l7koIwQ9hjssQCDwdKHNslwvsmbzz29nGXQ7JlxS+PBD0oc2jgI9NhcroOzCysLf
 M8WO0YykUEFSW0b5W0+B+CpOiaarfZGXuQZHcZeaoDxdnLZrVmqzSdypj/WiWri9DnCBOOJ7S+U
 DgXwgHx3WAHtb86QMVA==
X-Proofpoint-ORIG-GUID: 3ywE9FWi5rJKKH9L5viSXssFaeEE1vSu
X-Proofpoint-GUID: 3ywE9FWi5rJKKH9L5viSXssFaeEE1vSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130099
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

On 3/12/26 12:55 PM, Yedaya Katsman wrote:
> Enable the MDSS nodes and add supplies and bindings for the Samsung S6E8FCO
> DSI controller for the M1906F9 panel.
> 
> The ldo and iovcc gpio pins boot up with a current of 16 mA, but they work
> fine with 2mA, so I used that.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
