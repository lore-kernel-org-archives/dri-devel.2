Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D4C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DEC10E0CC;
	Thu,  9 Jul 2026 19:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNheesOf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h1to8r1J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1D510E0CF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 19:13:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXPs52388520
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 19:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=; b=KNheesOfomsVUduc
 CcvE8SZac96fJwdfD/TF5VQoEEcRgWj7I7Frf00hqvY9YqdBKm+Q4GHzmND/guqL
 btUvlew9kmRNw+mfAP2J5jKDtmluhG7B4jpcDaecLJDHLua6GQA6kXhzFr+ldrb5
 jq0mhLmSnUMZWsb9Obz8avq6lEubhe6hzOH4+7RJzLx85w70UhKvzl6DAzRxb0So
 b/XFXEOcEn+TUYyz7rsBbLtMnbUfuTClcpfLx7lfS6duopKQc1jj+ivBPNAwOUCh
 ZWXzokrJCv4KqAa8umDnUVMD6E43C8+9lcMn7+xCHPtCFduKmq8bbtZE1nNfKuRt
 Jz7J5Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydvkqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 19:13:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e9c0c4492so3223385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783624424; x=1784229224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=;
 b=h1to8r1JtcdqrvIsppoh+D9o8WJ6TwzJbqx2X2Uzlu+JoyGarXdVCLFfOqXIwP5RUw
 aAofMtDg72IQy56Y9utwo4lpWuHiWAgX4Vz9+6FJ8agysn7Ui8+sH+y6M5zO6SUxIn62
 rA5Ro+aF1lljWxaEzY3nVVOL+xbgFC7clo5KOLOL9YmuZndo8S2jlCvmOJWy1p6h/Ev2
 iqvE0lCx74Zjk9fuOD2BaOLwtreB0KmSler1xw9meJcvX4BvzkkQy9J13HDUqesPufX0
 m8wECiGpo9jp+pTlJlQLYDDbEokpanTveTpk2/wHXlJihu2adfwFxKMoDw8BdZdKQgzI
 PB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624424; x=1784229224;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ukg8K27ZNplR+yNjefMWINfSHgjifpE3C2eq9F7iWjM=;
 b=LZtkGe4NqYZv9dhfy20r5SPimLXTAqUAYHcwSlNvbsSu1GY5/gWYTFNo4zPyg9AgNI
 g45hOhq/ykDajgWnopKX/TkDmJNvg9mqlF+zlABsCw+TQH7b1PdHxJ0OlGyWkbgzVOWY
 myaelKjN01mK7nWSOFn7dT6hWjVGj7u/OwmizurLrqbV1J2Rj4jPDNNnp0tVBaYUNNXh
 hdgdNA82vJneM8fYYS+2Gg3w1RGH84YxQKCJO2oWvXkbv2g1U+kiJCKFFZHUxmQssNj4
 6QSccat+FuJAdlXx0LYIMSYBWI5V0gdSnPAdwqaDdHDG3uDcQOclgSVoMRvC/+TtZApc
 GdEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUyq0PcGU7bqbkHLdZpZG5KQ9DQzbA0dhTgXKUSmg/9I05+KjNCkUtnDnij9tTfAxtI5yiP+T4UqY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx40sT+kzDvzknGNnY9UCgODlF3c6G7HR2rNE/livBYnWUA8u4H
 SaApZdsGH+5WGeymH1bU5w/Mi4elfYQpDRHc+Xp0/j2XgWX5s+43GxfnZBVB+f5p8FTUIZON0k/
 dfw5ySYYLbV/i7dgn3Qo88okGUedtt/fSa/AptYuz/zVby0GGP8eZ9cmUPRFbfxskjB4nMLw=
X-Gm-Gg: AfdE7ck+qTd3raBdSykb7zsnTenYL0Y9wlIXOFwlGJ8tkWlrv6hBZIjB7AcFaXLHKF+
 SHwT85Id+F0+XKqsHF9QSVP+wrz7AZ6ZlI3vXtWo7r74oqFoKwFAvpEHURt8TCBNIuyaD9fUnz1
 mRBJ9R8O0oAYHYaNeqHtqkTP47Q2c2QqsQSc0v83Ba630L+uD3ffbB8nyJVGTOopl/BsA9z2Drm
 XvWQit8jBK5GPh39bYEW+u6LIMab2kXMMS4g4GaCOoGNkDJgm6C6tZNg8+3VnyR9wh8yYlCwbLQ
 dxYjFxrHjIJbzIAeimHz1hKU078kZPIPgHAVGw8Y8fnko9dGWL3SyGA9VCIJBXb8pDaEze72Mwx
 fa0EwKFN2Dw6d583PUG71PBk2KRtVgSc/85c=
X-Received: by 2002:a05:6214:529c:b0:8eb:1061:552c with SMTP id
 6a1803df08f44-8ff941c2fc6mr52515936d6.5.1783624424254; 
 Thu, 09 Jul 2026 12:13:44 -0700 (PDT)
X-Received: by 2002:a05:6214:529c:b0:8eb:1061:552c with SMTP id
 6a1803df08f44-8ff941c2fc6mr52515356d6.5.1783624423732; 
 Thu, 09 Jul 2026 12:13:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69c14972fc7sm595785a12.22.2026.07.09.12.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 12:13:42 -0700 (PDT)
Message-ID: <88edd673-1220-43ca-805f-675890be0cfc@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 21:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] arm64: dts: qcom: shikra: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
 <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-6-b388ec5dce77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfXyaOmrDhe/W6o
 SxfMdX2Uku7+HQ9K+CyjEYJJhiKFCFl8JemsVFXjWZYUfAlwxJGNLTSKzRy4zDv70N6HwgcO2e3
 6mLo/81genyFYVNRimhuoQjVbusB9j0=
X-Proofpoint-ORIG-GUID: _htwZZ29TE8ULj8kAedtFizsKZ9xaNX6
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4ff2e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _htwZZ29TE8ULj8kAedtFizsKZ9xaNX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX0CqNR5Aq0D8d
 5hvnlQ0gl5hfoRLD4/CTAm7KDNB/07ulAq4RrBJLW0YNqk+6dYAhAUbOZS4+ZJ5MNGx/QIcY4JI
 cJI+4pNEOEBIMABH+yWQx4FczVj1iQ7LocnY86rH+82qEtzbItfRoZ1DGZcwRHmAJCUuMUwv2Bx
 ekV3vXTsiyFP8/BSNFN+X7iKS5dt0WgpS80698dD0IjShnZAWLPKWsXYlwWeNkZp1IQbcrlxrrx
 i5AXnJLBkAXG6dmzAIrOLyXf9IrKhBXHJaba6Hk/+m+6+6+qUqg0FlsmYvoA5ZbUNX7HbLGjw0/
 arrPcTvLNFqZNo+r8kVPLiKAp9YtPRAHyFees/BnMN9K4AiISl99CnSll/dq4rlIlkaSWoWZU8z
 hAYtVZn13Q2C7VgnmkfL0b1qeucYR5IJu8xD2P6+zT5CnLs03DFtrwloqkuT2phv8cflqNl7Rlx
 yY3PRLBkxnb8Jx4wJVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090189
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

On 7/9/26 8:42 PM, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling the GPU speed
> when reaching 115°C.
> 
> Without passive_delay, the governor fires only on trip crossing
> interrupts. Temperature stabilizing between two trips generates no
> interrupt, so not all cooling levels are applied. Set passive_delay to
> enable periodic polling to ensure all cooling levels are applied.
> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
