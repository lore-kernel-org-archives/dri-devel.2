Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82750CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75A610E2E8;
	Thu,  1 Oct 2026 01:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="owdQbXbI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ok4laUU2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2404210E2E8
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:32:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910k2Iv2012667
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z5DJXNvk5Weolt4AKmsTjVt+UqV6Bq165jLKrQEAxU8=; b=owdQbXbIojqiN6Bd
 GqRk5nxGe4xu0O0WW0RTB6q7qQyjtMtpMp3tS7DbtCoTmDdzqr0tLJtd2L2tyuxm
 /jqvQYuY3NoIp1xM6eaMf2iJH/9+0z+K/oNxNHhdTy9Pfbka/W7R+s4RHaq6zQvY
 H6m0H8tGamYM+KcQKQS95KHz2VCPStw3md+0pmQyIBP/l1Sq6OobK13Oje8wZqi+
 M7ceAOcd4sRM4h75XDaG8wB+xbHUL53PBP4Rpj4U6l0BWaRWao8pUHFlzvPx+k41
 UluZOkVvhRSnCNzYLQAsbqr1NShvfg9IlJ9EGBsVICrBI/0d37JLuA3HlYwoquHs
 beVyaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh83vd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:32:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so1614627585a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790818323; x=1791423123;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5DJXNvk5Weolt4AKmsTjVt+UqV6Bq165jLKrQEAxU8=;
 b=Ok4laUU2TYuIgXervWHfRGezKMMZ5ej9OLpG2H/D4gwz4ogh4Zkt51fG06JjVgqFaL
 gt8nObF7YDpXf6lG5sTZcMgV0d+X4gLtJ+cF5Q9dmORzeEnN6J8cHDJ+Nbod+dCuKLwz
 jA3SoGEX2S7mEPawUopnge2C0JzmyVBdQ3vQbMfr1Lgy54LeysJF8bSAI1EzCQWbihpI
 qInzjN7HXeXy4+0NTGx4xam/onU1S2A/aLAj+VYgj7R7A+TRLFHRerQPFJI6tk6PA63F
 Doszs1I8nm798dBwnCtotOsAhtq/Q/D5ghSs0p26uvD++w4j3Xuf1/o1TK3EzQSVQDaJ
 x9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818323; x=1791423123;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z5DJXNvk5Weolt4AKmsTjVt+UqV6Bq165jLKrQEAxU8=;
 b=F9/su9bRSTTrizNlnnZP+CmEn33yB6NuFsmyDvqaS3xVHYMYIZ/mpvz/J5GjszerLo
 HY7PJkA5bcwFCnhmAcXa+AaLC/NT8TUDBeEJMdYla6nchrYeVvYHP/6tARmMLEc6XqFi
 0pryiz16CGeAPYyK/nv0I/oW052mDMUAQ5+y6jzeyr1ZsvYD5/Hmx4cAGMiXcJU9dfa3
 RGx/LTC5g62Z7v0P5dDwudwfXqahSiOzj7joKoKY/X13lrDNHBTgFze9K9Zug95+8B9U
 nQQ9SUpSxPxHsTIeNtWuJfSWg+Cujrkl7qb5/9teOAaBQKSer9AseTxKtOlKBnOcFWfR
 VquA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDHSzuiABAzEdLqNHmf7QYMzwTjCxhK0yVF/O60pnYm86OP4NpxUB2xfvhFHcN7cua1+nOHL/CbV4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nyoDLNCqdpL6UWmmjStcRBDrBspzZyfDPotgUX9qH0ZZl8Rj8K
 42PPeqEnkGfx1rpjVxXWpc6L98Exw6GTpVGsp7agBEiah0AbbdVJXEwXI2plGFpK2fZjxqI7PVF
 AOsugCejdObfrOffhQgV+9++jSztkSl8YHCUvVYpIH4m9xPWLLDixZZIz5uC6fgV5z29NrEg=
X-Gm-Gg: AYBFou36UVsS6i9MLQelLA/nm6EBaowcvhEvuBmSyqc1FXwWgzxW4EUktUZXcFX+HaF
 QQagXu1D8sWH8ieC1m3JYN1mUfJB6duvYpmsRNhyxfpTZxx+lf/CMoXMN8lUhSpdkX7ExEFfJhI
 UBKRzDcjt78yckMENNPKgPXQnuSIcXqT5FDsmYjLsX8Kh2UOO6Tv7xFRWwRHZB23w7lL878TKsF
 9+kCbKbjD5MSJXXbVshkuMXZG7ysdlnzmvGn6GKTRjQ+lSRLh88LWSfDz9yodG4JzQtW9xF3zhj
 ci9pyABtDAeomkYGkPNo3hJ+XcwDIvfc1JL8hO9o1b3aEh3eU23W9F15V/O5oE+N7+JUDa6Tb9d
 kkKsGLfz06vaW8VRTXZq1+8yBXkEmoUi+r89z5SDL/cSMfivK01UApInRbfRkKF1VJ8veZc4wvc
 e9UCvypAZwsptD
X-Received: by 2002:a05:620a:4504:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93ca97b9304mr576011685a.62.1790818321513; 
 Wed, 30 Sep 2026 18:32:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4504:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93ca97b9304mr576009185a.62.1790818320992; 
 Wed, 30 Sep 2026 18:32:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a779076c17sm8919831fa.41.2026.09.30.18.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:31:59 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:31:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 03/17] dt-bindings: display/msm: Document Nord MDSS
Message-ID: <pco56quuwsogsi52cq25e7dumiwigqth3aays4snvwjbntonwn@hjjy6tyqinly>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
 <aqtECDwHPiUUZqTB@QCOM-aGQu4IUr3Y>
 <7d2611bb-532f-4553-9d16-66c4b9c495c9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d2611bb-532f-4553-9d16-66c4b9c495c9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNSBTYWx0ZWRfX1OLD6Rg2jcrK
 o8Xzo2dSj0u/v0niytRpNIM8yUplyA40FBo6umNUGFxQJhLkM6L3ZPnkq/ytCiYrl6DWxiBK0hJ
 7JPhL+RpIZCwxa9RSesFsDbdyO1UAyRpb1WjR4Feny4cqyrSxE7iaLD1jVEU/W2zsnfZQxI1IKq
 8+GyI8wCtUPeCEqy9RVb3zAG5qwn6Ps86+QM7ieLzJSO9/65KFHas0tNNMubwKaxpALEpOH/ub/
 pUTHFpjOm/BLEVh08Nv3pZwcsiHRvt5qfGCdkzGTTgkWJIuaxsfL82trg33P3gu97VEfC0wgFmF
 tGgvWvJVitgmMWeRxNONmDxHGcaLds/ObL3AQ5XlWUYFzg6jjNHkmKYNP5SNsA4ScdbqpG3hFvY
 ijU4nQN2Q/fNazQzhnsWO6pfsydk9vfYJ5tJodkptjfW7sZEm1+V3lpM7SOpNlYKIYkpgusAlsE
 kRTwnW9VOMOmb4LIKIw==
X-Proofpoint-ORIG-GUID: WFuTzMaJuqNTzOwssIQ6IPrAl6S0vWUL
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abdb814 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=ybxY3fLTiW4QoAl5E9EA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: WFuTzMaJuqNTzOwssIQ6IPrAl6S0vWUL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNSBTYWx0ZWRfX0qCkHAGm1F4f
 nv6fHJ5Q3A+jAtQwOMkenPxZ+2WKpAbfOyy4UpkEA+TVGBweYCla1dBCZNKzjcU1gITdHPN+X+D
 jqrfNLZekDIjVJz0+wTHhFGyzYUcAsM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010005
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

On Thu, Sep 17, 2026 at 11:12:38AM +0530, Nabige Aala wrote:
> 
> On 9/17/2026 7:06 AM, Shawn Guo wrote:
> > On Fri, Sep 11, 2026 at 09:06:34PM +0530, Nabige Aala wrote:
> > > From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > > 
> > > Add the binding for the display subsystem (MDSS) found on the Qualcomm
> > > Nord SoC. Nord is MDSS 12.1, DP-only (no DSI), with two independent DP
> > > controllers.
> > > 
> > > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > > Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/qcom,nord-mdss.yaml       | 98 ++++++++++++++++++++++
> > >   1 file changed, 98 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> > > new file mode 100644
> > > index 000000000000..0b0cacdca9db
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> > > @@ -0,0 +1,98 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/msm/qcom,nord-mdss.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Nord display subsystem (MDSS)
> > > +
> > > +maintainers:
> > > +  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
> > > +
> > > +description:
> > > +  Nord display subsystem consists of MDSS (display controller), DPU 1499A
> > > +  (display processing unit), and display interface controllers (DP only, no DSI).
> > > +  This is MDSS 12.1, DP-only, with 2 independent DP controllers.
> > > +
> > > +$ref: /schemas/display/msm/mdss-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: qcom,nord-mdss
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: Display AHB
> > > +      - description: Display hf AXI
> > > +      - description: Display core
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: iface
> > > +      - const: bus
> > > +      - const: core
> > > +
> > > +  iommus:
> > > +    maxItems: 1
> > The DTS in downstream repository doesn't seem to agree. There is two
> > items for iommus.
> 
> I checked the Nord IPCAT. the resulted SID is same for both the SID (i.e. 
> 0x03e0) in downstream repository.
> 
> I think we should update the downstream DT and use a single SID entry.
> 
> > > +
> > > +  interconnects:
> > > +    items:
> > > +      - description: Interconnect path from mdp0 port to the data bus
> > > +      - description: Interconnect path from CPU to the reg bus
> > > +
> > > +  interconnect-names:
> > > +    items:
> > > +      - const: mdp0-mem
> > > +      - const: cpu-cfg
> > > +
> > > +patternProperties:
> > > +  "^display-controller@[0-9a-f]+$":
> > > +    type: object
> > > +    additionalProperties: true
> > > +    properties:
> > > +      compatible:
> > > +        const: qcom,nord-dpu
> > > +
> > > +  "^displayport-controller@[0-9a-f]+$":
> > > +    type: object
> > > +    additionalProperties: true
> > > +    properties:
> > > +      compatible:
> > > +        const: qcom,nord-dp
> > > +
> > > +  "^phy@[0-9a-f]+$":
> > > +    type: object
> > > +    additionalProperties: true
> > > +    properties:
> > > +      compatible:
> > > +        const: qcom,nord-dp-phy
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,dispcc-nord.h>
> > Please run dt_binding_check against mainline kernel where the header is
> > actually qcom,nord-dispcc.h.
> 
> Ack, I will update according to mainline kernel.

Just drop the header from the bindings and use ephemeral clocks and
resets.


-- 
With best wishes
Dmitry
