Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA37C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814E410EC10;
	Wed, 29 Jul 2026 12:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGmy5Xin";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DulyuaNn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0627710EC19
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:16:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBvITQ2916040
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=; b=jGmy5Xinb2xSD5pU
 kHsjiX+IZWn51oCYB4Ppb1FYqIy/oeen87suhLwu5Sg+VL6rlCk9VM0YMmDBNp+s
 8rzFlH6B/5sJlruWHdm2vF5PJGPQ8g+sqYoI4MMUj+3x6xl5Zurw5jrJN8XR0tPf
 uKFxDzS+xx8CYJi3DGNPHJqCTpqBLbZ6DJfBXRHc1yW8ctg6yOS/yZJc07a//Skj
 O+EVAGfhlavIZQvVKhNQPP83+RoWapp3IBI4F0A5kWHS6hA4sLil7zaWYoBBL36l
 31yCkPRzQT6/H69w88ZwElwuLcmpJxSYPa3x/JekTsGiWqCFJZhVS8EzK0U7uupk
 4wt/Yw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3mr2bg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:16:11 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9e8723ae1so60811a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785327370; x=1785932170;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=;
 b=DulyuaNnqYwkFvuTtuS7sCmZ+9w6ZFPiLqEzkhDemkCOPIj7UZ0/KWW6U7Ja5NUJvO
 xbEehAazYInKxYOprtmaiOV/cBFgtxGj8QteqHP1Q25l/hDKlIrDxq9f36i9vsanb+XE
 VM7+xO2RiQjdEMR6amsTQuGCTB3gcXPwBthmRdxGZ/pvILbvk5iCi/PeDRKQX2Mnr3t+
 xz5DHpl+Gs4ytoVsE9ekGL7+Xx+EjKOtpUS1tzKdz5OfbVhqmECfFgTpPsvMP6yYxVai
 CHmV7jyRNR0Jmky0tKDHMnKtz/HDc3fQ5GfwTZSQWwTc9sp6VhPzH536obcjW8WN4IGi
 JNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327370; x=1785932170;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBY6SqO9XgmLQLXW4MSm3F34QI/WpVUcAR/jeWmBW24=;
 b=ACwq4IrYT3CwAQnnPqNowA68TZ/1VqJtdfVKFdWpxkv7V/68qUbI69fqNfFimY6jWS
 AowYMwugybX76M7Sk4j6EfcQo9QI9SWjsWQd7A23Dxzl+RPxayXw4Z/9ru2oniQ4NQrP
 ubPn6pFGXvx6GSbhzZGG4M9ysiOHd8o/tdJhgFBpRMz0FG9IaBT5lHIPxYrZlT+3klke
 +8VPp5b5fKkHHeT9DztmXtxW/uwO9xFPKITbbKI7q6UT6RdYN7F1plrV3aFBxhgqBhkh
 sSq1zxaGYYBkwk0tf9X4mK245MCXIo4+RD5ggUXSjQEs1PpdQFbU2ENCu6u+OTS5NuLU
 3dPg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj8RSO9ULmGyTama5ZzhC1aPrwEUQtzm/ckm09IToe5/iZ7DtUQy1a2V07LWTXgfFKKDN1cRLpDp4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrOp/vSbOuCbM+jL6Pd+WpzbZh5hof7zaq0WJyRgb5wfQEqHf0
 Xaq1yKBGWfhfpNYVWSQKFqhI2Wf6HFV0ah+pVCBRHe2w3dps8JGx0uVzdIf/rdjfHlzKfVGvLGz
 fefk80s2wBSeWe19VXkW3z3xetRfB3jUGjUQyhf3ugyvCirjOElOtyXhT3yeJDcp6TPfF28A=
X-Gm-Gg: AR+sD13TWn22QmhYGH3WTcl9VM0Slp57l6NjKYJQQT/FCSwy1a8gtZqjU/6XAvCvnbU
 WRC9cWpQAx0lL9SM9KO1cSf8mqDMYvCHli1eIPaoYNGYENAlwS+7nlBYT30EgBXfwmjdfjP5d+n
 RdYSxbW4JixqpXHM8EZKH08cRIEaiMBXoj3XipCoinkOqD4VZuN3LLS6aFVnCcWMfI3BGYToTJu
 Fc6nu/W/mQYtdXIW0L5cz7Ihh+I8CuzA+nru65N4izE45w05/aZxPIFb2fSsIyWylwnnptuNipL
 j5QchwR3ltneFXYZ2Afnv3m83H+PC+cFrJfSrqHG/5+HMbZrhIAJhA7/WOHGmV6KiRda3O9sceW
 bA5eRvDGQrNtqCmQ7eBcGxsHN
X-Received: by 2002:a05:6830:67fb:b0:7dc:c92d:977d with SMTP id
 46e09a7af769-7effee11f80mr3115997a34.1.1785327370598; 
 Wed, 29 Jul 2026 05:16:10 -0700 (PDT)
X-Received: by 2002:a05:6830:67fb:b0:7dc:c92d:977d with SMTP id
 46e09a7af769-7effee11f80mr3115972a34.1.1785327370182; 
 Wed, 29 Jul 2026 05:16:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050be3a33sm768977a12.10.2026.07.29.05.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 05:16:09 -0700 (PDT)
Message-ID: <0ef4c658-be67-4df5-af56-ba1517700985@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: eliza: Add GPU cooling
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-8-64379dbebd7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfX76Vffrfbt6ed
 Kv+Xnh9hvOFXU5ZCPnM9wXmthsMSo9n6wxZh+f0KwwjIrOn9thSJJ/SMcsFLsuTWCJl277y7Usp
 x/hQLGk6Z2/UdSAFavyRRFhAN9ur6O1KqAhkNaroTCEX0oe4zHsfNSkeJ2UyQG6q3KlRwucMX1Q
 JsJZFEHK3at/r9MizhjDK17JVmgTUcFTwHH6uKq2N0Gndqmz6Dzjok2zYkLrSlCJ7H2C34KCUsu
 gOdiqgBmIAXSaFELPnJBg6Kyqknn5Ip6+XrfnbsYQ3calvSEYJIXuV80o8DCbpcQJniD7sH1ifX
 cdsPpxUyOcfrjmuFqRsNCxbivwNLomZti7ESRPoacXjA+3kuVbxM6c7LWVLBEM6VuBUU3ocGcrT
 GVF/ml61UFmt+RBq5IceUSMENCe9sg/WfYORbDnu4OTdB8FBpn4Mzaze1N2UfI1h3Q8FTB8BYoi
 5uTjhoO+6SYjJ7pFzqg==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a69ef0b cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: Tep--UNy9_loQryhVlf030uwIRbRmS20
X-Proofpoint-ORIG-GUID: Tep--UNy9_loQryhVlf030uwIRbRmS20
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfX3oKURFt5XuPh
 +7E4+w6qvf1OG/bgLz2S+NFxUEhENatBVfe/BFd768NCMUKQPDFhkQDnReJgNKLpHOeYHsH0EnR
 jCaFo7xNKFEkYUEsceH72HrbVctoHC0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290101
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

On 7/17/26 10:41 PM, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling the GPU speed
> when it reaches 95°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
