Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A8ECD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC8FD10E2A4;
	Sun, 17 May 2026 18:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSmJ8zbu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T7v0pQyI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E9510E2A1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:27:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64H1P7VC1697510
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=; b=SSmJ8zbujuLqmSrJ
 hP4SOwcuU2/B8tj4fWaGfPBNfswDzwWRaUaQMHW70GI3sgVxCVQ7v3ipcL/Pk7Xf
 9ijtK7lEPicROvKX95rXsAi5bd4oB6Mzz3zVyjLv/xXx4axbdrJAB9Su0yCxVfuT
 aqgwaDyVCDhhP73wUZQ2uA+JydvmdKJcyIGFsonoNeh+T1D0K49nhik/l3ThtVb1
 oGRMZNV8mQmfnsT7hUk7OUdc4Km1xVeBqpKPHT6D1xgY0ZSBJfRuEOaPZhmsHa0A
 9O/OhHgFGf7fxFK01WyVOmONmMX+R+of8+EmEeN8mEs/ctRFKjgB4WV8tTd1CDvn
 ejDWNw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g3bd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:27:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-514b5d6bb45so29546151cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779042422; x=1779647222;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=;
 b=T7v0pQyIFDPoHR97yIevxtH0bnSTIj/prWB/s2gTsb3dGdckMPxiwZzwBGzNI32qgL
 iolWxbaVxYbPFNYvcWIZCqR0pY9YWgtWHBaX7z90LrmjAEeESROBsisQul0Z0uZOFqJT
 ercOpZOf3qQwUxsEzcgSOcRNt+NmeJTSQ8q/TGOf5niKYKtvJ5B2uA4sqY4AVwoiPYdA
 KmhqGr69t4XARyB4XRGOghlDrFfuXH+c0KYfVDqMWKTnTrVVj6iHFwV8iGfqc3ylAYQ/
 cfc0KiXZ8PcVS1NYLr+jnCTIQ0tH/7szrJGOD836eWDKmTBcqti1R67mj35Oo3D38nrT
 /t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779042422; x=1779647222;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=47IgD0Iol6l33UGUteMSnMp1BqqYxxlTxqbsNmGL4o0=;
 b=dw3dSOkOQ7nUIrXO9JaOCO2U0OW2l0XnTVp7dKyphi0TRADeaWoyl6Pc7bTV1Bo9KK
 M+HqoKHxApr1YjaW/N0ohSz5KOiyXDb7GkXsSqz9YA1Qdc/rUNVs5S/+6hJ1h1Z2NT4L
 cOZa0h2q+d63qdXHRBd6gqYnuMifr98hz7OZjxAjTjp1Qc4f2dA+BtJADMZcohBN2WTF
 oIfBkEUyol0lawQzbcCJ071ui7AQxeEsSoPULteTGvcTQSaXxAM1gKZ+mHIKQFJOsEG1
 JQuGOt17L010S2HuTzzCDzV3BgK0wi8B8Rnr7urYrIxJVJM5Ite0Hg3isqk48wfxwBjx
 RpTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OnkR5+BOoj9MBRwvt7u6Rcc7PPcstjvOAlfjNycqk0GDeq8aw08FCwVJfv62U8S9UK2eKph5Ub7w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxv4OgfZ0g4hEoul6udV5H8/9ZYERpnIqY16ZFSTjI87VKBmljN
 Zb+3cCOMT8Nh0ONeuf7j5cO1oGiNL8VGAe2vED+tX5d1gOK6Fx9GPintDhcXMqMB/8vWvYfxDrV
 Eh5B5KeRGuOww8wQzOriXH1QAGy8zJRkza8Mv1wYBDztiR6aCw2vfX8RfRQUtbCx6K6cpK2w=
X-Gm-Gg: Acq92OFcOOxOn4U0wAH4zSxTrU6+3+xwH/9USsRwIp8Zg38MlE8Hblp3C8L8nQcggiv
 JRzAbKNnR2EjhHV02+Ou0DqcHtIXUVDYy71uzdVS4IvZVKvzQR8Ma3EWi+q/LgM7RZIHx/Hm88Z
 roz5jKdagPoYj1xzYqHzHFG3fuOevcLDuDlERH3J+7iCGYhWmm85DcvCOGMoJUasODllrHQjEc6
 yZ+maXIWfYm8k2zJNeKP5TIHDo/jf8p03VmphiAwJ1xa9kC9xdB99nz1vjCGr/sSQmgqDvhqUUi
 G2RXimrvaBogX0dqEfiXy9WWJTKI69TEGQe8OFoeHe8NbLJWNi0dq7Q+S5IYak5hZ6GpPYRqv2P
 8NGuOw/gBcXL3zNmJnw21WOqMHMKtUDjmdizSGQoD4yvI3+bmuMc4raoOz8AKYbrAowdPHNUF4c
 1aR/WnEmh9J1mm2PHIVhx1PYDuhupDDGIONQ8=
X-Received: by 2002:a05:622a:901b:b0:50d:7d8a:5d45 with SMTP id
 d75a77b69052e-5165a2754a0mr151817671cf.36.1779042422413; 
 Sun, 17 May 2026 11:27:02 -0700 (PDT)
X-Received: by 2002:a05:622a:901b:b0:50d:7d8a:5d45 with SMTP id
 d75a77b69052e-5165a2754a0mr151817231cf.36.1779042421835; 
 Sun, 17 May 2026 11:27:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c885sm2814535e87.11.2026.05.17.11.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 11:26:59 -0700 (PDT)
Date: Sun, 17 May 2026 21:26:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Message-ID: <vjdz65uy4pxlbt2e4wlwvdu5llwazyopeqb3caswvejenm5iv7@3s3p7iz4otef>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
 <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
 <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6572f5b-3686-46ca-956d-c06a7363cef2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5OCBTYWx0ZWRfX4QFZDXOL9M7m
 4/cl6+DtQDIAmuPBSeNjLj4aABGCncmUNHNHRVOPaEtwBXM3jkHDmWmgeAM+alulfyCQGy9748D
 Tw1ghs0B1IEkU0uEDToZ24TlqKEmC4UgBNLwr1Y3V17z5xh+f14g8AzctbbNpcOlcyXRIJ3A3M2
 Eu4eTexHY3eIbbx+9bKIARCeBbfE19Pdj5ZZNzKcSq6x0Rr7/X5Ho7FT+awpLmtU1RaWTHNgLVQ
 czeD9BI0sP8X/9dApfOUxQJ2slzYlzjdOc7l8iaH+eC1rzxsWhPAQzM5O16GbVQ5ZgJ6BlSRLdG
 YTMNARs8OR5abcCUn4gNeShVgT8quLowwfPXh2ZC9U7mBFsb++IFDwa1hHRvPpNmO1aqpNZ+JKX
 C07xDLFFjPRcmWwAlVhEaveXwsj6HB2mamVsJzD/tcV7Q8QsJ8yAGY9WMs5jxCsU+oX/9hU1rye
 nBxwkSegOTupBM+muTg==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a0a0877 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yUhn81BH2gEySD1AKRsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 20T-mk1wqzZ9u3q0kkL5ghSNgOSHb6lv
X-Proofpoint-ORIG-GUID: 20T-mk1wqzZ9u3q0kkL5ghSNgOSHb6lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170198
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

On Thu, May 14, 2026 at 12:17:54PM +0530, Gaurav Kohli wrote:
> 
> 
> On 5/13/2026 11:23 PM, Dmitry Baryshkov wrote:
> > On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
> > > From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > 
> > > Unlike the CPU, the GPU does not throttle its speed automatically when it
> > > reaches high temperatures.
> > > 
> > > Set up GPU cooling by throttling the GPU speed
> > > when reaching 105°C.
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
> > >   1 file changed, 135 insertions(+), 30 deletions(-)
> > > 
> > > +
> > >   			thermal-sensors = <&tsens5 0>;
> > >   			trips {
> > > -				gpuss-0-hot {
> > > -					temperature = <120000>;
> > > +				gpuss_0_alert0: gpuss-0-alert0 {
> > > +					temperature = <105000>;
> > >   					hysteresis = <5000>;
> > > -					type = "hot";
> > > +					type = "passive";
> > >   				};
> > 
> > Why don't we keep both passive and hot trip points?
> > 
> 
> Need guidance here, we are keeping passive at low temp so still hot trip is
> needed for such cases.

I think we are saying the same. Keep both passive and hot trip points.

> 
> > >   				gpuss-0-critical {
> > > 
> > 
> 

-- 
With best wishes
Dmitry
