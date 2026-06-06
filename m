Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A58FCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA6110E774;
	Sat,  6 Jun 2026 12:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UrmBsf1D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZSw1dIN8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB3710E774
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:16:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BESxI1332253
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1zE3o4VQZjHAay8n7mzWjWrr
 l7kDTW8knX8g5BBXo4w=; b=UrmBsf1DursXcp+DHml2Fw+Yi7SWRWd0SPCDjAiK
 X0pcnwOI8e9tRgFaO4kfR6ISmHjh8laeT6W9iZIW7p1Pej4g2Jmhax4DS+QHfWwp
 91qMxthPY+gDtsAE31QVZby9GR2PET2XYvWFWVtjbuH7/SIl0+1rdL4u6dLNMS+B
 UtkiaHFs3Qme3J6JImm1f7O3s8hSBaoU4/lwtDR3xBXZlLpl7RMMgtFdl6uRL7/5
 spyKfMYZ4yaYPOBrldqp3Sd0QBkCUXIJegkWb/cOIyJQKhLoSeREQWchVnTUkVqm
 hMDRnc8NCIa//tOs1R3NJxk0QY3W/9yEudgjFUl2QBtmgg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cshfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:16:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6cff652cc58so4660441137.3
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780748169; x=1781352969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1zE3o4VQZjHAay8n7mzWjWrrl7kDTW8knX8g5BBXo4w=;
 b=ZSw1dIN8AQysRduHZ8vAb9+OhgXKNe5/4No7Mlmbmz0kurBmHo9eNSC3YL24qxx3h6
 vkNDVSvIdw9pFNDXUTr0MGARdyL1TWFyERijTEjidI8JwUdARuH8c3Er/qann83uDz03
 iP5qOsRXRYtfPoSRe1kq2WIFvH1mQWOO8eHGSBiEjJNIUtA1tIA60UhuScsEEa9PbmTK
 um3RukLDQH+TNqj/CIeBTvG7eGk46EuhgjEuVnZo0FLnnASE+9uorB57Z6zdlWpeuTkg
 V7hBeCcA0ECaIkCtRh8TTLpXa2wAjDnGtZOYbIbZajegdYu5ylapU9O2yAPzzNG5xwHq
 ZePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780748169; x=1781352969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zE3o4VQZjHAay8n7mzWjWrrl7kDTW8knX8g5BBXo4w=;
 b=WL5rZXLpUvPoIjjhKLzpalsmV+6cTtmn73FN6jF/AVYwAdtIihlox4EuE1mNdh1Vki
 sci1qQIxTVq3ztsv8N/BzqB8C2roK0ZMkfA/ixIM1mk2KHJZkxPcR1/Px8LUlMzSadYe
 M5ri+jcrY6PZl7UvGjoyRe0j9VavVnq/jjENUjxjjYluN58GPVmGvSIQti+KfmDZFXoM
 JY0CXNPZilQfeEbSDRS/G1MRihhnEJTybcEGAsV0W46X26AbOdoEgcp/ShqwSEXq/maY
 gLmFX9lQwS/9xvbond0zAbJazJBEdDmi7tsjfEjDU+mdZjUBjunKJDavLrOJDfztl9HN
 bxDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QdaajpahDhQnJtALiAnWLuKirUGSpJnBqu2KxGGzJSgogp7C2ofauV/R2ckCPjy0EUV8KnjssHy8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaBguRS4OxVdAWqz8/d7pYva/Hkegr/bw/n23d4iHmQgQwDqb5
 U5mMP8YOYfV3MiWZZnZnugXDyJZeQyXpaSIrKaVeWCJ9Q4ornPsqQH9LhXWfEZ8/xOW4fuf8h5M
 nCR2B9H4RlmNQowuEygKlX8B+J3xjMPvEbwwHqAoDpkaMm4ErFjshuDr6rFKpCX/CTtRrhfM=
X-Gm-Gg: Acq92OGfF2zS9SzC9tfmxwBbfjzL5JpvlYoA+J33S4bSkB1Et9y2eiGL5Qb5hZ0qyk8
 LGULBQWXC6k4fLaOZmeQMfl4Lw2nEvYRVglWxbwls7Ex+6oIXmsPDbso0377oytSYNWwC2sm0kG
 ADVdxfFv5V31gCyPI2FP0dIlk41iiJ9CSWnpTR3fYLfXTFOcWrdljMvw5rcfjXwY/msdnZkzBwP
 2fnv48fM24ZwDPOj6XxuVBUXsXa+yn71nsDylghOsWd11jdWisKxmH/ZfMCBgxE7VJZd9zfYagw
 QM5XMXywTSmDGd4sbm5Rf4RU/uCoZpnksrsi4IjSdTHAorNI/uF/11T/zXGwcfOcBdZ/M5Q9gDm
 CsO5ZQ4WjM8mp42J4fs669q2M1mNRHmfFWdoBsQusJ4aAYDzvMaPmUyvqsB2lblCb7fH60shAo1
 yuZrcJRaFDaKpqiaplOkgsU1hm+4wFW8+xMuY4bryNCoMQtQ==
X-Received: by 2002:a05:6102:c91:b0:6ef:fca1:13f2 with SMTP id
 ada2fe7eead31-6fefc8b5b6amr4334566137.7.1780748169187; 
 Sat, 06 Jun 2026 05:16:09 -0700 (PDT)
X-Received: by 2002:a05:6102:c91:b0:6ef:fca1:13f2 with SMTP id
 ada2fe7eead31-6fefc8b5b6amr4334521137.7.1780748168762; 
 Sat, 06 Jun 2026 05:16:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396abd6cbe6sm31092601fa.0.2026.06.06.05.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:16:06 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:16:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Ayushi Makhija <ayushi.makhija@oss.qualcomm.com>,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
Message-ID: <aiQPhPycW07t0U-6@umbar.lan>
References: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>
 <20260518-ili7807s-panel-v1-1-d7b048163b1c@oss.qualcomm.com>
 <ss3deh6wb4bjasig2r56bhl6opygpkid2ixztzdsegqgayuvdk@vgy4ytjzyife>
 <1ebc7c8a-b0de-4f25-b4dd-571909f9c67b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebc7c8a-b0de-4f25-b4dd-571909f9c67b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMiBTYWx0ZWRfX/+LOJlo8703G
 sZd461W0izz4Hmkf4btPUhoGpBwTH9lShwuy8ASDQnz/SF7/mj7PCVw2uJzjzp70UF1jvWCQAWn
 gp80Zo5uUuJQCWVP5IhgH8LcUAS0u6RHhoT4cYyTmMxEz81mNOgkDnhuGS7V6DpYw4ezELJoq72
 WWaBvB0zl5eSfxrkdBffls92lNlYQaTDBq94NGrGH3nA2uN+pZJcIvG+8HeJ2MRTVERzAz2Swr+
 cPfIHSUmbdDLJQn0HEFqEKUG6gaLg40luvuRr44LHyhAi9WFnnS2e5l1sOniVc339Pp8vlwBShB
 1I8UY2xolegy570+hXOST6T6V+UmHKG5j/vSgiOp7cdNSzbzB6+9t/YShJp0gnoWoy+7/Hb5SD9
 KvXszC3EGwifoNKzobVGISsjLfUJyzPK70Dj4umiG1TfKFO94WYKZrXeeRBXlDmv6kM+B9eJwAI
 icRlmDVGgwUjEGWDWbA==
X-Proofpoint-ORIG-GUID: D1l65_FfOfNPW8Dl50mfZHEdPGmqIk7b
X-Proofpoint-GUID: D1l65_FfOfNPW8Dl50mfZHEdPGmqIk7b
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a240f8a cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tJgGB5yCzY2aFmRDZG0A:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060122
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

On Wed, May 20, 2026 at 06:24:20PM +0530, Arpit Saini wrote:
> Hi Dmitry,
> 
> On 5/18/2026 9:53 PM, Dmitry Baryshkov wrote:
> > On Mon, May 18, 2026 at 04:34:12PM +0530, Arpit Saini wrote:
> > > ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
> > > The DLC DLC0697 1080x1920 LCD panel is based on this controller.
> > > 
> > > The panel requires a reset GPIO, backlight enable GPIO, I/O voltage
> > > supply (vddi), positive LCD bias supply (avdd) and negative LCD bias
> > > supply (avee). The panel operates in video burst mode with four data
> > > lanes using RGB888 pixel format.
> > > 
> > > Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/panel/ilitek,ili7807s.yaml    | 80 ++++++++++++++++++++++
> > >   MAINTAINERS                                        |  7 ++
> > >   2 files changed, 87 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> > > new file mode 100644
> > > index 000000000000..93c511d03c00
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
> > > @@ -0,0 +1,80 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/ilitek,ili7807s.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Ilitek ILI7807S-based DSI panels
> > > +
> > > +maintainers:
> > > +  - Arpit Saini <arpit.saini@oss.qualcomm.com>
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - dlc,dlc0697
> > > +      - const: ilitek,ili7807s
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +    description: DSI virtual channel
> > > +
> > > +  reset-gpios: true
> > > +
> > > +  backlight-en-gpios:
> > > +    description: Backlight enable GPIO (active high)
> > 
> > Is this actual GPIO or the GPIO-controlled supply?
> > 
> Addressed here https://lore.kernel.org/all/dd065ccd-d7cb-45b5-8733-64b4f6571b3d@oss.qualcomm.com/

It's not. Or, from your description, I can assume that it is a PWM
controller external to the panel. Please model it accordingly. I assume
there is no 'backlight-en' pin on the panel connector.

-- 
With best wishes
Dmitry
