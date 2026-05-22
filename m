Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F60ACD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9CF10E17F;
	Fri, 22 May 2026 09:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VELran0c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XoMW2c/o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A5E10E17F
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:36:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8plMN1816067
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 APbwl7JfZz1MFEo4M6V4SzoKbJVoUA0Dkbs8rwWXxR0=; b=VELran0c6hntsmhM
 mEB5xbFWjfu7Lb1Kyx7nNim1bPGhBazuvf/3rskHwt9P2v5dCTdYCjLu8bvcG2VE
 8CUkuv4mCbVkNAyPSyUe/y8VgDXG8g5mBuqh3g++t2bfzjBKgd053AZc32hhwcwz
 ehSKPc3oZrVSuEk9r8RCfHojoPIOMMadUe4TK7FCth2gsujHw+v5F/gdTAABYS5n
 Kxpm7KiqCtpkGfX25l6fdPh5A3sbUvZKQ5ffBKm1OSvftzH7RqidV0fM2WU1RP17
 GMIzpLDSih+iJoyKakApKYq+huTBtQNLAguwgu5kCHYnq9i3vR0DFOBU9kv/+exx
 +KQp/g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm1bk8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:36:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91345d517bdso157673785a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779442605; x=1780047405;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APbwl7JfZz1MFEo4M6V4SzoKbJVoUA0Dkbs8rwWXxR0=;
 b=XoMW2c/ouC/3FJHajvJmYOU0jreMGNtaI11P2/GWY4Qt3ESe739mWJdjDr0rGo4YUe
 IR4VfW0PK0Ij+ij/zbC5Rfyc1IVJSy4i7y7HbkJijGY7ElOhSlmnSZf7zQ3ZnHIHAsVL
 IIyBy9TXrkoKnRrafjwf1Gv9pDKaXr7gqoJVsLiWeqXvDkcOUdwUsNhzTJbzwdNzTvEC
 nek0kzJFFTFYff4VFJ8PuD9mOXARcyiOC3h2TH8t0vZk3JY6KObsMOPDE8X09UOPn5HO
 gEQCo5sb1FGtAhp8YVvAb2VeEbFPadrQw3+2La0iFE9AhzyLW3qdbTGJjdSnGcNBgcag
 EM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442605; x=1780047405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APbwl7JfZz1MFEo4M6V4SzoKbJVoUA0Dkbs8rwWXxR0=;
 b=cuB9kDPeO4b2yv6XGXQgp102E9NsPBcupWHj4Zu0lvqwGSjhKu5d+18E/rLGeZw6tn
 G8rpg4pUzVPpuB2GZp5kltS2iAtupwbYw8ieRD8q2J/4h6Ewk++1sbHz3WVZ117DUKku
 IpsYxoy9sTZIq6V76FCvLFMXEUXd25lJQzAU9xVnCtUPEJo99EK0wOrLUX2/RGaxNOHX
 uY+he+LNciFA/84idSZ6oMEDHheCmeQKz48Tvznr/nTI0+CDWtswUluUt7CsoyTBO4Nj
 Hf8KuGRslBTYPNJV5Jk8y0vXzo6SH1J9fwf7BET/FHcmNHYoEIug5VJaWo7mNVk1trLf
 Az0A==
X-Gm-Message-State: AOJu0Yy9ESGF0RoT1tlldOKXNkF3wNzz5ZfIOlBp8CkwPMDlFl3jLD1d
 qeUvJfBqcM3mzhI46I7V6qkELWFPzWwlMUrG2rKt4jK+vMBvcEGF20J3uOKi4STubdhGDragGid
 aZD/7f/MhXi2qI68+MnYg7aM7Id3fVhFIb3tMIVSdvCyJgYfBciNd0FCrQWQX7Vm9iVyDdBE=
X-Gm-Gg: Acq92OHq/UPEcogxA9qwzYEj6Ya/RTk+QE3KHRn1ZMK0ISI56J4dwolR4SobIEzwi+k
 XxuRlvXt8H0QVP8mR+PPftCDjw8Lv0d1fROj3oF5GWg2VIoM8L1MRSS6yStGaWzaO3fPoLJFPy8
 JO8OajtleZQ55hbeZ3aZkG4SOM0IV9wAZC8OGX1jJg5chvWCii3/12zyYqHxIKa9Qb+mzYp4afI
 YQeSH9nJodKCWcd01urzHyK5jP/iZAb2ApRiWzm1UqadOZNDMDhSWH3RfTjfmqpACWZQlFI+i+v
 PcD0HsykRRuxL+CM2fPHKBaITwdsysgFWSf+2tCjtuvSTtFr4YpKMXeS/cWQ77Cq1/L5u83Yo5v
 f3he/OiSqQoemOFUIjlMZFFarfppxq0wAiMtI7H2pMuDpxA==
X-Received: by 2002:a05:620a:2813:b0:908:a758:baae with SMTP id
 af79cd13be357-914b49fdfc3mr274380985a.6.1779442605299; 
 Fri, 22 May 2026 02:36:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2813:b0:908:a758:baae with SMTP id
 af79cd13be357-914b49fdfc3mr274378485a.6.1779442604807; 
 Fri, 22 May 2026 02:36:44 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688bb427027sm460761a12.25.2026.05.22.02.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:36:43 -0700 (PDT)
Message-ID: <d9c4a227-97e3-4ae3-a095-a387b7035f08@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sc8280xp-arcata: Enable 4-lane DP
 support
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
 <20260520-surface-sp9-5g-for-next-v1-6-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-6-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jNjoDJIMIRX3hr11Qz0AT4T7yaaPes1q
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a1023ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NSBTYWx0ZWRfX2dT/2kExDvno
 j3xo2uf7TcmiKm5tXvrLuuR8N8rJu1zRo8obQsFQHyDk6N68Siekux1SoaA5odhDqnP1HK7sodZ
 Jznb1ikZ9msiBPdQt6RujGWTldiR/VFDy2axyQfgE5MMwnw3rWUV4OGJjEE2SDHtRJwJ2BQD4E/
 UyJSpyiHDMUJr0d/PvRt0iz0U5saQ8UktOpSZK23wIIyOvjEkmxgCi5lQNOh5c/IvJuTwYDFG+h
 WZgnBfMaNRwxvs3ZNPhxobN7dUTMkHwGFhP+NCrKVn38myrped3oNrOunUCqHvUFnW9W36D2PsA
 EHfnvP/MtJqPbEAHAoakVLqoIwMzk1+1jMfjo+bKi1JcBR3Atkb1VNWf/gXWjJDLyTlfLPgZlaP
 tu/fKE8XfdAMEIP/yipTW/8OBrwa1fd3zuybvjtX9++dIzjpTsFSqc6HdwWjY79iaWUMS1Ople3
 zTbdoEsFhNgtQ/sNWZQ==
X-Proofpoint-GUID: jNjoDJIMIRX3hr11Qz0AT4T7yaaPes1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220095
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
> Allow up to 4 lanes for the DisplayPort link from the PHYs to the
> controllers and allow mode-switch events to reach the QMP Combo PHYs
> for the 2 left-side USB-C ports.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
