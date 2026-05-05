Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CDACD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F4010E1A3;
	Tue,  5 May 2026 12:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHGmGxZm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bihFGkPM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7512B10E1A3
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:45:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6457asD6366348
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 12:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rRe7fzW8DQ71/cGj/cijBCqJ
 qRhiTXRVLYdroRmMEqo=; b=dHGmGxZmiOshcuXXPHq5EUSBNAeM+v6KpaiPZIA+
 9Kx72YGRypaD8rrPSnQfUoNeEyGtQjzcMIcV7SIQjrwV5iaBatPyXrhSlVwtqiDK
 s88Vyft9gpSjY8ebwOcIguBI/viXmvZzaI3x1SGPIiiX71tc9SMHfaHoHVOpc0NH
 LqyYUQBzALGLkUDqGA7FMdiB+AdtLNXJWJdo34rPGBfNKunM+DF278Mb1+L6cvqc
 Ape7FtV9UBRgIIAs8Cu8DK9MwkJf3Ayy9K2oZhRq5tR8OD0Eo24QLN4+dEM+qNUC
 RdAWWIEscliqR7Th2422aWCw/fHO4l8SJZCZt3/8dkPZng==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6vfk6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 12:45:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e575a50bcso70798491cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777985145; x=1778589945;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rRe7fzW8DQ71/cGj/cijBCqJqRhiTXRVLYdroRmMEqo=;
 b=bihFGkPM43fhBsRRdUeNZ3i1nGmJiDs594mnufxNYWS9dTiBdDk7qufru9JX+pWONI
 642ZDgZOEiNXGkBPFn1kzuTsolT1xQnu1suSHYYFKLkssUDv1ZDMdIw89hAe9wn35iN6
 VidPBjax/MPxWe3M+mTBd9xDieGW7Sul97M/bATruVqKmD3Y7RehJN55A89/2a/tV6v1
 G1GbduB0uBH6Ugy0+gn87VJHI3e3Ce8WismqAXto62Uz3zQJXb2zfNEEjawjI0SF1PLZ
 CuaF3zT5dcVvQirWeUPJI4gkSXfVTiKO6Ng1NwMOerfYTyUNoo4Okmw019zTFgsgqIhx
 wrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985145; x=1778589945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRe7fzW8DQ71/cGj/cijBCqJqRhiTXRVLYdroRmMEqo=;
 b=qytIS/UiwfM0SK7TY3ocBtYZAqxk0bebtmxYNQu/uOBULp+B7PfkAjPPRzD3g82qn4
 KSP3+ySqF8ZzBIujl0rPGuZlB3xY5QRjsThRTij/2mlq89aKmIc01ARaKCcfZ/yrYu4D
 X55dquoIjWuM9tmZwTUpVTZ8FnzcrjfGRBpTnY+ReQ4q549yL3ZlS0M4NzX2Rq8+7oAG
 6Gr7NgFOQ5hWr132grETSZt8AGHvke68x/KxZ4h2Xtm+bkka1NaOmpkyJ2ovYKSy6ALA
 81YKpxsbfVODZfu99uPgxnIVMqetbu9rt4hwIVwSSuR8BqiiSX6hxMzl5yabTqpXiqri
 X+2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8qOX676vffWAJO7D5swxrhjw9B6BX4e8/m90NofHgattswDYzuwnW6UzmZxcHcrUlQuVMRQn6z60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaMEnm6wP/hnol7+CK4wxEMRsublfebXsFMi9+6BQrUL8jwH2x
 B39IbPSGHswghqsS19M5EBCVSXGXMehm26T/M4SARdsaiw/cBafp13AllsU/0qAnmTflFLvN9um
 l2CavS3u5VP3BHc/eZNDthsmr6CkYn2svCmWpzJ2kqoxreSOyf/XTSljorQu7w03IpgFSZIw=
X-Gm-Gg: AeBDieuT66INPVU6cOjCZtDWBmytpHivnJWNWwjXKUXEenwP2riIjvWUmqSXO/ZSXNl
 M18IDjF7zn+aEXzhEgNW8xgxzWhm2VEW9X0gJwrl38+JObVzmQpQuhpwL9W4gvKF2JrMhMqEP3h
 VYn2TOpiMrn3Ft59RoaHaIZEsRN1TrfY3kKdouB+deJ97hbJMJNsIOwy0P/achkpb31AMiSS5dW
 Ze9CydE9UU1/RGFFft4XrXUpYIGzhHHRObHXnSqbzfBJwzePpOfyV6xYCa+WRBW7pw6MR1lmjm8
 xHFwfIps/FmcaoiIxQ/chxX7SDR3Muz9RFIB2anX569lfnTcGQzSDxEIqDSAz7BWXyaULDRNcRu
 dg4AFHiPxasouSWusCqL/9ZRy2YrDjgpnQ9g5onfcUmKpTFvYHOFM5pnWHUvEnUo5S8G5EEQtBS
 J5JipBdenEAjwUkPR4ocbLMnWNaWgU4GwxfFSS33Y6W4K83A==
X-Received: by 2002:ac8:5796:0:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-5104bf98b3fmr196771211cf.36.1777985143109; 
 Tue, 05 May 2026 05:45:43 -0700 (PDT)
X-Received: by 2002:ac8:5796:0:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-5104bf98b3fmr196768301cf.36.1777985140468; 
 Tue, 05 May 2026 05:45:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm3867561e87.29.2026.05.05.05.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:45:39 -0700 (PDT)
Date: Tue, 5 May 2026 15:45:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 touchscreen
Message-ID: <hsisxgvzte5h3zuobmrjdx4uasan4urj5xbes2flxdq5cakygx@ok3rhermb2hw>
References: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
 <20260331-rimob-new-features-v5-5-5fcf42a29c12@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-rimob-new-features-v5-5-5fcf42a29c12@protonmail.com>
X-Proofpoint-ORIG-GUID: Ddm9m05aCJNCBIQYcZcXY8s50jwdi8fx
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f9e679 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=sfOm8-O8AAAA:8
 a=EUspDBNiAAAA:8 a=FcDylz7_6oNKbyFHn_0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: Ddm9m05aCJNCBIQYcZcXY8s50jwdi8fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEyMSBTYWx0ZWRfXxJ1pl9fo9iOD
 lak9JVcs5LFWLP7ZY5WEK7+mrtJ1N4cUG9UBZrLAnCTKXQXHGcZD0M9KBS3p8rW5Qll2lfW+Ppk
 RWLXNrKRe3vNhTRWF6+5TBj0vi4l/VLqUak8XQPAgzxa09yOf35xbSoirCum995ZZTtKkVt/Tiq
 DwVFjIO6Y7aB26WqbrSkPUcEuxQb/7ZX+XsWnuCXubouxs48INNsB+FfWKBNJsw8N/Qq9oZ3HzZ
 IVpoj3DDRC2lsIv2NB6/gLR+Vo+b3yFUG/s56pR47H/tbd1EK/nd4Z9MgjrPlXdMFEFq2P1xgGU
 roatsPgNkWgPkx3gcPcHRyB76nUPj72w5QiRhuPjobFbbJ1TLAldVs/z08eqmD5fgdp2fRiqqZ3
 WVK7oUnpYSV7gQMx45K6zCWOgyq7iSAD4DK8SYTOpoL1pF3VU8CfCO9GGCqg8vpTnaQ4izwzdFa
 PfbrBbgcSDF0s3DYsPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050121
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

On Tue, Mar 31, 2026 at 11:47:13AM +0200, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> This device uses a Goodix GT5688 touch controller, connected to i2c_3.
> Add it to the device tree.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
