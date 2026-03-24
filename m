Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA46FEC104
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B18F10E673;
	Tue, 24 Mar 2026 22:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRUlYJcq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BzM7xt5B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C411010E496
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCrfT3110426
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DXfDq3Ed/IGLER8UTluc261t
 apAHFbnvzfmNWppFei8=; b=KRUlYJcq6++KH3hcFE3AzmTVq9QteFk2BxBcsBFy
 Udag8jUwIhFKslaE2/HCbAqLkc4XGzibmDRsdQnTVN+DxcjcIuch94TwpZXSJzm4
 MgJZmKsb3ebAQQhTFf0CwJt1doDnFkDDQxr+dbsDqF1iFzbb9wEnKVTl/Rtmi4Ll
 3I4UMjm1SCRoeqo6Y2ayu2Zj0IWsg5JRaHZT8iAeGOJBhNBSt+DZLOkrRLFXOAqD
 jhjJt7flLxk0Qe7nqDSsdchjeQirwH4Nd+bfpxdnD7Om61otP1Pd29XjzalqAnnq
 S5Hych4IiZbiKie30zx8Q9esJs293NlCrez43XaXUHr7cg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvsnx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:20:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50925fed647so113373991cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774390801; x=1774995601;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DXfDq3Ed/IGLER8UTluc261tapAHFbnvzfmNWppFei8=;
 b=BzM7xt5BXkyINnhl6Gl4qA3DkrtcBdY/MgLnf9VlzSBw3epF7PfNGV2WLymzBsuPlB
 /vpX2Ol9qxlb4M0qxAHqAyElmN7JRGMTxsx0VgLvrWRJDZPpx8bVbdEL7n9kulrx16N8
 nIT4NF4yvG1FbcuTATM3I4I41xhS+fR6wFEP5pDUMxALaieg+WonTPDiJuFlmryzHQY5
 14QSO354LxmdMomhyD3UsjE0biMSG56agXz8CBYVD4bG0GhhyIkQwXjFOoOFYZ0OYD5i
 xRMd3IoxVpW2ZsFVSGVKRXHpGMP8pxqquXdKlM5yVnQWHa2EX7e/EQL01wJ9DmDfWj5m
 mCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774390801; x=1774995601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXfDq3Ed/IGLER8UTluc261tapAHFbnvzfmNWppFei8=;
 b=YcUimtbK+HWZ0yrvsg9z4f3pf7jVBhur48XrPkBa8iCyu26EC6H8CbFd1Xp7AACwQ+
 dMn6pNiW90pehNtNn4uVy691U2lAU82QfswUai6+E3HZ8MkHqDc8wj93shXwN1iB9YLj
 jr5GmWaSF0RUL75OchEgmZGre+CrjHOA80fnXmufHeTI5Q1+y6a0LCJieQ+V09nQ1bBq
 5xwrVxlE97H/Ie/xFQYrtdl7xuTsoGnPCcEGvAsXyccRIFF5JFlccEnkVpkRMUA7muRZ
 5XMiTI8OTBlXJBbVL5pThHA7cf6cQhPEeqO9nixiXv1Tb7ohrmiaIOPIxUPoHef2Fd0f
 7Suw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMQw5VNHVVsgP5VSlr1lY9mxH9CG+ChRuDpd28TW9PR2Lz10bv5KoEu1ADqpPAcIr2t9xtHuRijWQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1vOKeSvZSTthwk0dIjro/rAlySAY5eFR244bU9ZfeLzIQO4v2
 HP0fo8wMTr8EBRyYgP0uJcBT9AHdkYn7LtAx1tIx0yKDUHqKIiaLqt96JyMjNPF9wKMG99Sm9Qu
 q7wT1T89Hvby8TVyI7A12p+pRjD1fC6ZiFAPlkZSbAqeK1ZEdwTqU0n/6yoa6Cv/jz7nkA1U=
X-Gm-Gg: ATEYQzyYa3RAsiFxdE8xG3bH734ODrO1alD8C83GPx+4/g/uHMz4vgEEytmGq7SoRLW
 6rdodI7ZpsCG0OpHnJnAYws9PHrP6kDROE/y05NruOWx9J5XI9EEoxvA5wmUyZYwuZZKdbCxIQE
 W+vOCOqEGK9Dneuy0QQwMf+Yh4fJDUsV4PUxilSQ8tRJAQyCPG7p5R33e0i1CiOjRIl0mouwtTW
 a5oznUKRZV3112IvoIfUN94sPnCpj9wxUmJuuTH2o2Ynh9vNpjfVr9twTabZETjC20bSD6v37WL
 coLCGn6oIbBPWJUhQtt6kNKMSISGb9+jNdosG+YU6vkyoaMjNIHKMUEqmQsI1fg05XXFP0Z6VkX
 U//J6tc9YwEFqqQTBZxbyEaDUHasRk6IEjJnv4g53cNmwp3Ycej6evDcYCbRfqp3yx3dX9++WKi
 HF+CezOj7VxlouCfy1QABddCvRwPyWS3IzbLA=
X-Received: by 2002:a05:622a:820d:b0:501:b1d8:637a with SMTP id
 d75a77b69052e-50b80ea6259mr17386171cf.61.1774390800867; 
 Tue, 24 Mar 2026 15:20:00 -0700 (PDT)
X-Received: by 2002:a05:622a:820d:b0:501:b1d8:637a with SMTP id
 d75a77b69052e-50b80ea6259mr17385761cf.61.1774390800305; 
 Tue, 24 Mar 2026 15:20:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf972bbaasm33033261fa.6.2026.03.24.15.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 15:19:57 -0700 (PDT)
Date: Wed, 25 Mar 2026 00:19:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci <cristian_ci@protonmail.com>
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
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <fh7rfswcwcrquijgjq547b6jjuq2v3wxiweh5xnnd4z5ql5n7r@gt425ujkpctu>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
 <sdcfwycey5ykhn2fghun7imx3tjtnwat3ny3mut5dwstl7wvw6@maqrzlycwdn5>
 <GF8zsK-szOM98Ck2jznCOZ4xjuJTl9g1b0uPc1N79Dzf7PNzOiVgewdqPFGjqF3YD7tOUa2tzdc7rG_e7iNH8yjHOJ9DobsihTxRLUk8EL4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GF8zsK-szOM98Ck2jznCOZ4xjuJTl9g1b0uPc1N79Dzf7PNzOiVgewdqPFGjqF3YD7tOUa2tzdc7rG_e7iNH8yjHOJ9DobsihTxRLUk8EL4=@protonmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MiBTYWx0ZWRfXzoU1WQA/ata4
 Np9deByCK51k9R773OMu7yEByIrXQAGoKxSGXB+aGYxlPTXYXONm7PxaI5wuEu9PfInWRD8zwOt
 tLKPuX6l+IiRHl8S5+F4CZDjGcVmSYfCO4Ui+96WMBBXyFMVIT9xTh3p4RDr64bl/MliycMNPjD
 6+Nhz4zx9zcc7nocYj0cSe7LSZGqDmQkKuXgEzAsgaZ4olwr9JmPR8Li8KbVUVynRKBdCnfDfAP
 J00yj1Gsh4rffsD50gimaSQsYRMJuzN6NkpPIm95AVUN09Vm0ckP+L9Jc3n4uWHhRFdYEJSokTo
 OfEHb4LvDd8BCXpEzmC/aiURGg4FejeaS0LUh9+Snp85mfLrFx2+5tfJLIgmuP8N+vhSlI1REGG
 5YsRx0Ei+prQeJ5GliYNLZp6uxbnEq/FihBo+nKQC/sNmKX6rBn1fRAj1mdPETGx/0B5+vGSGro
 t8X+ZHGMKfFZgC8NzBw==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c30e12 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=0x0uYR1eAAAA:20
 a=zvOWnUYkAAAA:20 a=EUspDBNiAAAA:8 a=sfOm8-O8AAAA:8 a=BSL3PQau86bbBt3lHzsA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TvTJqdcANYtsRzA46cdi:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: mtyo1rtllgsKFXdHhTxVAyk4oyHU-5mt
X-Proofpoint-GUID: mtyo1rtllgsKFXdHhTxVAyk4oyHU-5mt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240172
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

On Tue, Mar 24, 2026 at 01:10:13PM +0000, cristian_ci wrote:
> On Saturday, March 21st, 2026 at 17:46, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > On Sat, Mar 21, 2026 at 05:23:20PM +0100, Cristian Cozzolino via B4 Relay wrote:
> > > From: Cristian Cozzolino <cristian_ci@protonmail.com>
> > >
> > > Document Novatek NT35532-based DSI display panel.
> > >
> > > Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> > > ---
> > >  .../bindings/display/panel/novatek,nt35532.yaml    | 77 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  5 ++
> > >  2 files changed, 82 insertions(+)
> > 
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: novatek,nt35532
> > 
> > This is not enough to identify the panel. This name identifies the
> > controller inside the panel, however the exact settings (and the
> > behaviour) would depend on the exact TFT "glass" used with this
> > controller. Downstream usually doesn't care that much and frequently
> > just uses the controller name or the the controller with some kind of
> > "description" like ("wqhd-dsc-cmd").
> 
> Ok but I just don't understand the following: I'd like to know (also 
> considering that I find it difficult to find someone, outside of this 
> ML, available to discuss this stuff, specifically) exactly why the 
> current bindings are not enough.
> I mean: looking at schematics and datasheets of other similar devices 
> and based on observations about my device, I believe the generic bindings 
> approach for nt35532 works quite well for panels.
> Novatek made the IC first and then whoever buys it can be a display 
> vendor. If we talk about downstream, differences between panels are described 
> there (i.e. my panel makes use of four supplies, while other ones could use 
> a different configuration).

Different "glass" means different programming sequences. Take a look
at the existing drivers which handle multiple panels. Sequences, modes,
etc. are different though the DDIC (controller) is the same. For Android
kernels this is handled by putting all the information into the DT. This
approach does not align well with the upstream DT expectations /
guidelines / philosophy / etc.

For example, let's take two NT35532 panels described by [1], [2]. The
sequences are somewhat similar, but the contents is completely
different. From the upstream point of view, each should be described by
its own compatible string (so that the kernel can identify them).

[1] https://github.com/eliot-shao/qcom/blob/master/display/LCM-NT35532-JM55FH-1080p/kernel/arch/arm/boot/dts/qcom/dsi-panel-nt35532-jm55fh-1080p-video.dtsi
[2] https://github.com/balika011/android_kernel_xiaomi_msm8953/blob/master/arch/arm/boot/dts/qcom/dsi-panel-nt35532-fhd-video.dtsi

> 
> > What does it mean for the upstream:
> > - Try identifying the actual panel used for the phones. Sometimes
> >   googling for spare or replacement parts would reveal such a name.
> >   Sometimes it can be seen as a marking on the cable or on the backside
> >   of the panel (again, googling).
> 
> It seems that 'google' approach fails, in my case :( (I only know that 
> the vendor assigned Smartron the work to design the HW - but SW too - 
> of the device. Nevertheless, Smartron is neither OEM nor ODM, so the 
> company was relying, at the time, on a series of chinese manufacturers to provide 
> parts required for this device, including panel suppliers: in general, 
> the list of panel suppliers for Smartron includes BOE, Tianma and other known 
> companies. So, this panel may be any of those, paired with NT35532, and work 
> anyway). Unfortunately, even if marking on the cable is known, that doesn't 
> identify the panel but the cable itself (which is available on the market, 
> though), instead, in this case.
> 
> > - If not found, come up with some artificial identifier that would
> >   identify the controller+glass combo (e.g. "tianma,fhd-video" or
> >   "lenovo,j606f-boe-nt36523w" (where lenovo,j6006f is a device name and
> >   boe is a "supplier").
> 
> Assuming that resources available which I've as source of information 
> for this panel are limited (the ones also described in v1's review thread), 
> my vendor devicetree describes the panel in  'qcom,mdss_dsi_nt35532_1080p_cs_video' 
> node and makes use of:
> 
> qcom,mdss-dsi-panel-name = "nt35532 1080p cs video mode dsi panel";
> 
> property. Until now, close-to-mainline devicetree I was using the following 
> compatible for the panel:
> 
> compatible = "flipkart,rimob-nt35532-cs";

In the lack of any information, this is probably as good as anything
else. Please describe in your commit message that you don't know the
exact vendor of the panel (nor the id of the panel).

> 
> and I'm not sure about the exact meaning of 'cs' suffix. I cannot state 'CS' 
> as panel supplier and use that upstream without proof/evidence. What do 
> you suggest, in this regard?
> 
> 

-- 
With best wishes
Dmitry
