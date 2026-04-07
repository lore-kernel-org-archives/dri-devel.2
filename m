Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD27EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9966E10E3A2;
	Tue,  7 Apr 2026 09:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSi9XMk4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="giunOpsj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0256210E3A0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:41:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376bKxm4009056
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +aNdOLb1kVbddgmRukReC1NXMi8K6aXQSmUkxoMsRfU=; b=lSi9XMk4U+ExtEXO
 O+U7UmT1eN2IrsYIyuVml3b0hOv3YoFeigaMh2U07U30aUp7Yoys95At6KpA4m8p
 zfJxdIAf76bEQrtiBviVLNA3odlxjtUQK1oiBvs46lfSBoghUoa5E8GzF3tOO5TQ
 cOI4EvvIS9DO0YjBhVJSS3R/3R0JAIxgYeLb+MDEbwYzChxLC25jv6om9+fC50BI
 7rp1G7Haj3t149Otb+hXUn5G2LaBM8HYue0YwHUyy3NFoiPbSMHzI9Zl5GRv5w8f
 8TnkO9xZFakniqp4R3pbqrO6lGvjZL4QK7krF/GkdFqlBqru+b1+1eSSctWsDgbo
 N6iMPw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrkt2s4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:41:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a016b99579so21584696d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554877; x=1776159677;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+aNdOLb1kVbddgmRukReC1NXMi8K6aXQSmUkxoMsRfU=;
 b=giunOpsjnrivexQvZiBx+w1IW+tRheU4VE9XkbequdcrVMjXWHK4VX8sE3W+MrsOtF
 5Ea0c6ChlMV1JsYO5sabTAMrG/6DqopL5JPIY4RF85GZ5dwu4v0cC+K6vzyoOhz8qQEK
 nIOgjp1XonMMw3kNT2vFyTXxJ0l/4yeUcH0TPW33maC/y22gAMoJkk84gQw9DCRaYdAG
 6u+LVv/Atsz2xwMjbQBWsYgB/nR0bXHbM9DhpVKtIy8aI+yHYBNSBCT07Fmy3SaNWuhB
 bgUT/U+ewye3EUMe2rOidyjDn6eYOU1wfNxrp1AUM5y3XLSRC6WolBP9b+1I7huhxyzW
 6CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554877; x=1776159677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+aNdOLb1kVbddgmRukReC1NXMi8K6aXQSmUkxoMsRfU=;
 b=G4pI2Ued+jd1ZIp8BIyIdPYmQMc+aUbIAkgzCqn2ikfscf6LfYtSE6uFSVtj8/Rp9p
 DtyhWgFlvewa+aHAuBReh7BY8ImkZYpyS8fS3xfv2ntrCJfWId/JtJV9nkRxMZI1XOPp
 rZIlcf+Qx/sih21lkPBIMZQnlKQ5C2Mj8izl5wrSQi14BSxIAygb8wG9QR8+q0AbE6AK
 llR4ISOSIwwy0PUjZiBWMelXlN2LOHbwVqArTHEqhtZjEV6D4tpL5G/j2N+E0WybHiuY
 rGnxTrQdeAAKbbosGCU5gD1JVYyIESWRRxkc8LaVhp0+K1TEzp6eHDWA7VnYfcEXBIp7
 Uz5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcxy9VHQqscc4sGSoC8ELVdWe4AvfAIOIQNzKDyyQx3OWxs4zrMgL3c8yFAB50BHdnP4UEzwLXgHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqRkLS5lfZK//I4htQGQAs/eWD8hSBGR0PXxlkoz2upaorl39L
 PTaPLTqR+oBZ2tCTUpiVmd3UOX5XX3kxP2Y7LI3us/ftosmI62nuI3y1fCJf6TnFZG31BntAVwf
 Qn6Jn1uH2x3vGkh1PGWEwccuSaczMoFGzA+VgIQDdzbLi8t7rztKT/wTev0GwZpsQDo4pUhg=
X-Gm-Gg: AeBDies+DxGgzlHx2zV+xi2wz6Sf2W0wiZGrrnhdQGb2lVhqQja0V6D6XH+5afJfEM0
 41qD1PQOV4FL6PJGwYuJNjcghK+UHTq1QvD9KzPWooB4KS9gI1jAVzpXphoexI75YDXOn7DLxmh
 8L3BwQB6mnux040NdnbnvKWZDjd4kJy+BzjwX9M58hJWCMEWWFkdicX0SeAs06jrX5pIvBsKcr6
 hXHsYb1YStq0UX1QwmyCw5L6/eZUGi2N8JNgWRURnj3r55kUqQ7ds3jbGyzN7kZ1nj3nIPehXAF
 rumhxTCY/FGGA9sOGR7OFXbA2Ei1VRZ3LbooqQxLbw22JsXxRv3edVHa4J7BU22p8y3HA6hFpBC
 QeJEkJfMEJWDYmqfTCUe8NMqt9zpWFmZjaKU2cXz54UeBCCA+OVXceS8VmE6NmjOfPp7Wsn/2qE
 YaWGo=
X-Received: by 2002:a05:622a:5f05:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-50d91383a55mr55395141cf.7.1775554877633; 
 Tue, 07 Apr 2026 02:41:17 -0700 (PDT)
X-Received: by 2002:a05:622a:5f05:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-50d91383a55mr55394931cf.7.1775554877176; 
 Tue, 07 Apr 2026 02:41:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cec6c31sm540646266b.37.2026.04.07.02.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:41:16 -0700 (PDT)
Message-ID: <63c62004-a6f7-455f-8dff-fc0139c00fb5@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm8650: Correct and complete DP
 address spaces
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-6-34f4024c65dc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260405-dts-qcom-display-regs-v2-6-34f4024c65dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rrz16imK c=1 sm=1 tr=0 ts=69d4d13e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kR4CFCDnwyPe45QzH1wA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: qGmmZmPgfrg295_hVtNy-801czDuBk_o
X-Proofpoint-GUID: qGmmZmPgfrg295_hVtNy-801czDuBk_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OSBTYWx0ZWRfX+4EgTRYqVO8w
 1nW8Gj/excPV+uC6XylmepL+EDf8qxtv75WmZwty6bkCg1UP/BovApEiUkiCmeVp3PWjPz6v6wH
 EuT2eTG7AHvnnLNHukbVM1UiIUic6CKsyYtryy/Onw2Cs/0xlBejULX7diyEb4p0xfpncst5YwG
 E7rjsGWpOxXWwhp94QPLQfcPPkUEyRTeADWcX3MmXHWZtdelHROgHUYGgLK76oJ2kl9oeYpEJQC
 cB3YaxcCFMOXcKPAWlCQAbFrNZtGhUBI9sbGP7OoX0qCfrwVzbYgYQRaa+JcdnA/T0sV1+CzrPP
 5QJlpsTasXWstjfqsDIxCCkS7QKb1VewwI8knca2Yknt1tAR+6N/+xdE96HG1xR/HhNAEXQPjVP
 bj/ljPLhgHygWfnbDeYzDMnQ+d6tkUV3Q6tt6Vgf/3h2eA/OcVd6prFQNw5nXf2VbTDykloQVRC
 cryjfJOPpEmFpEQu3Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070089
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

On 4/5/26 4:34 PM, Krzysztof Kozlowski wrote:
> DisplayPort block on Qualcomm SM8650 has few too short address space
> ranges and misses four more spaces.  Complete the hardware description,
> which in the future might be important for full feature support.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
