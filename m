Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A10CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D958C10E810;
	Wed, 30 Sep 2026 10:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLTco5Pe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AXoG5QNT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7EE10E810
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:39:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dV243330298
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NxsDdgmSrXEpefiv4dLm4x7z/LQYERZV07k4WnFvesk=; b=fLTco5PeKrhH7QwP
 /D2Q1oMQ5w0NSRXs4BBCB81BTKRePSuT32S7y6ZIuwUkch3S6ZsEa4zinCyLf28L
 dE0N/rrl1LP8LfzblqA3FOusyhSMUwAaM0EIzt/1fHbeagEzmO8XPmGCJ0TDDFjL
 Zmvvb4w8BlOS0od/vLrXab7Q82xgYDSZynNHU0RcGIzRaFkEw2Hxb47/zyIzeTyR
 CrAi6VozFthWMh/S6HbHycEPDeLFEkFAlN9urLIzrFnHKyOaXMixNTgNVYC/6hus
 O0otWeNhM+s5lTec+i5pIdq3m7yHzOJ1S/hQx6lQlzpI2TT4wcN3y09d8xX7qpwX
 YhARLw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3jwjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 10:39:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-915e9e1a5f1so5318826d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790764777; x=1791369577;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NxsDdgmSrXEpefiv4dLm4x7z/LQYERZV07k4WnFvesk=;
 b=AXoG5QNTuyeLdpNgR38uOuvUNUvlItEHF89dd+hWkiasAIiYSyvzMri6AQ7C/3yBGb
 3NbsCGpVuFpT7Sx+pVkJmvVgRoDeePdsTrR8OOcK+Qpva9oMmTOfpihC1k3y2IKZ8F7M
 opY6RxRHbL2hOGjwKG5+OfpxCz8s6GCrm3L4iKfIvTe7bhzsmMzQq9YtS4D7Ew5UjHmo
 eNYouOIbu3IdwMTzL6aqCImjf/EEslfG2CwvRHYwavyA33hPNl8sifsgGj04jxXrqCVp
 vASQG5woEzJbXkiUkxP/TGN8Ioh3qwbrH3yQ3Dz8g2toy1iTG6Pvgfm2MNnY3ZxjHp1A
 sNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764777; x=1791369577;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NxsDdgmSrXEpefiv4dLm4x7z/LQYERZV07k4WnFvesk=;
 b=tu0DGICWRt4lPqzjl/8eAMwVe18JXtdD6UMK4DE2yyodsOn8dyqScIzcGAh99Tot7H
 CdzoXkOL5Y83NtNoMr7ODGbWxGXj4CR35FnKx6KDdID0mfaBC37jPz9xJAydbjruOemB
 qDM1SnB9gZ9RxYOgwcyEaO96dNWMZdQaOR3qnTdvsv6eX0+ksKe1PFjXm7xiK1yp67ao
 fDbAZcjM++sAg3jDLRHxNnaVPlOCsj3LB9f/l+Vd7PVj8NQlMCh9vx5qTZp+0lBtrhTj
 4fSt97TOydOuuUjGK/OWssnVqgJ/ZUnT2HL2FP6mqsTzmEMHYuAKgMZ67iKbrqtX5Ze4
 m8UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycgf49hsOe87P3VClv6MA5UKXP0xsPrb30Uh45XB+SmHizipqF8pwrHJuEqyfj9wFkqqpKce2tjSQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mL1KeK3QVT6otNzz0e5xHCRV8k732J+bhpxtbv5xHrBZ1S4I/C
 k/A8w1gQcIEXYdhcG1FYLyJk7katOgq+OFss0TrUXEUJe8mlSEOFeuDE8nlOtHEZzh1SGRDNnEE
 I6pk+AgRB6U7fCJ9uikjk4evqWFdbFxp5IbPWI4VmMCnGCzJo22djYlUlwR46UOJrwZzXHo4=
X-Gm-Gg: AYBFou0BtMRR3o3fJYICuHWbUIgbO8wmZXGRxUUkAGxLLm7cNwlr7PvVFv1DhBsTHPG
 jpg1r09CKr1aAmVcuc+P185HdfxGNW4vHZUZLY5VU+/CYavSGKNeK4FD6NisdVY0OHjFZ+HJZ+W
 vHUrtGt8MmeSAHqUJSoVOU+yJErkfMUf/4xrOt6esNo0oLSdqML7u5exYw2bWzOhlFvyxhUii9n
 hXLOvzUsRFN0I09oG23hKEEAY/mYP1MWPvQ3iXTKclWbAOj55ER3Mse18KEm7s3iLLTRQUD9m6f
 JVC/zgpcXXE1W7R1kvXX35aLUl3j9uDZitQS3cxbkRaIeOA2a8GAtpBf0gUp6GycPnZsgvPxxKW
 i5pY2CATvzgn8ZXI2+YDA7w==
X-Received: by 2002:a05:620a:261c:b0:93b:c6ec:780d with SMTP id
 af79cd13be357-93ca9880834mr131067685a.5.1790764776841; 
 Wed, 30 Sep 2026 03:39:36 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:93b:c6ec:780d with SMTP id
 af79cd13be357-93ca9880834mr131061285a.5.1790764776150; 
 Wed, 30 Sep 2026 03:39:36 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e22f80f5asm47036666b.48.2026.09.30.03.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:39:35 -0700 (PDT)
Message-ID: <667fe242-7779-4a8b-aa01-19277ff8d6d1@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 12:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] arm64: dts: qcom: sdm845-google: Move panel pins
 into common
To: david@ixit.cz, Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-10-08d5c7bf72fc@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260924-crosshatch-panel-v2-10-08d5c7bf72fc@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XVz3AYzk9tdcP3ikopicHX389YQ-qJ_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MiBTYWx0ZWRfX0eJv9UDG6BuR
 pyVsDvrACPOfL/qvVFU/lbKEmT3pZTIlAMFeRK22mRD80ROPFkROjvsoMZrF4E61nRqkgnvmCDd
 ZFpVawb3d1NJrpjNoDJPMEAxy0i5gMfxf3zoaGcs07f1TChKkxSHOC5YuzyMBn6ps6sQbZR6LOy
 pTwF9OhiPlEOgTG0tywiXTuK674TRI0Izd1t86KfyeQ5ICyAThnJbju7DAbIvNOF8dHKOunex+G
 PvuDciGVb/v1O1W2nshL0/xwKwnXbeptU4KEqfi388sxp7A4AsJ/FHTmz/zoMuFkUl1K99Z5uMq
 aOSr5t5bU5eWudKY8NcN4/8WtJLwn1+GadIYrjG8ym2EESOlkPjSvW+eOfQOY2unSXRVaCkOGy7
 n8/PHBG0C9tZ1uhEzlJ6z3Q6h4bPD7oXmr4pGsH+X3Rhq7m2TVX7QVVvHIa3K5RMz6oNIMwj5IN
 T1z0bOlSXVpIWJgCJnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MiBTYWx0ZWRfX7u2roB1XM3BO
 eCLgC9IX5F/tgpbtYsEHz7klGLJHTskpOB2mt9Vgwmwhkt7bOMTrgL+eJwN3JNDf4HbmKohOpgv
 7UFcNUQuDLXxUH0Tw4olS9lHG2H6Qy0=
X-Proofpoint-GUID: XVz3AYzk9tdcP3ikopicHX389YQ-qJ_A
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abce6e9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=LCudcodfsoFH-Sas34MA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300042
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

On 9/24/26 4:01 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Both devices share the pinctrl configuration.
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

no real reason for this to be separate but okay..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
