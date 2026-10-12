Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DEBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222FC10F092;
	Mon, 12 Oct 2026 12:30:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0350010F077
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC02pO3365131
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ls8AOqBpZ2ngBQoNAA7Jpu1E
 3UX0n2AiAP1xAS2NcXg=; b=XSCvE/gnw2FUgpCu5FLGovGPGy6CyKoI27ZHt8s6
 DakM8ar9srcToncPCK2bQW+tZf+qZNX2wzzuHM/UBMl1KWSm3zqsxQZZOPVRbJUm
 HIfqMJmdYY7nuOKYvogJc5DW5+lRIlAGZu8ZclzPt+nFYxGgACDNPv/aNfcdaVCU
 K4k1hM5FJmVBjtK3FpuhJFd6W/PU/eA70y6ZaM5KacnJrW6O//niDX4mowlyywPI
 I9qb77r13hcqAiaT/6WsWMQDHsUBK/csAwHOqliTIenpKFHVD690UylLGgpT6yJO
 jftjx8tIIsxOydyNKbD5RAZ9vUSDekzxQgwF+5Ixh1RyJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr8pyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:30:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so542459785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808204; x=1792413004;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ls8AOqBpZ2ngBQoNAA7Jpu1E3UX0n2AiAP1xAS2NcXg=;
 b=F6OFN9IenNgtEJ5EVL8wGq6HfiMHoDTcKL7U7iQMgbVEV1O+y7HXY7aIJ3wVHUek6T
 j4mVNPMbVoq32O7LVzjiwVSObJY3QM4hiBTvKIQuMbpMdFmsq/6Ctz5PuCcJHmYyi+2l
 RVYeQD947PURcFCXsUu7YSP7P9wAUzLPN7L4OAtKVjXy6bN4iaeW6sEDTCBPBDMfrxdW
 tVQ8cEJNtapSQjJ9P6W3aiuXOUe3C9AZkt4VoTcwWGFfo6Ua/lKF8X1n1/0460mAwokY
 xC8farV8YBKHozGuuNq2+1mIHHIs4lRjj+X36p8NyAnnDBw8+H69Uy7wGrVzk8ulzOhu
 Lbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808204; x=1792413004;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ls8AOqBpZ2ngBQoNAA7Jpu1E3UX0n2AiAP1xAS2NcXg=;
 b=IbWkVQK+fT6Rr/KO3fs/l8GgK5bh39GLh4y6mK1cB0rE+hrVkJJKeFkN3sxtwk1cPG
 LyTvuLS5VpiXPgZW6bP2ouaP8O4oC9AueOdas67U6sVOCMAQ0Bl5c/CO2+IsQF303bNI
 2zuGw3/exdS6+gHER1h5XYvUyEZQ7FVz4caI/rprgi77WfwI/nQo0WPBWHXOmlR4tqqW
 uvqt2FnEkVVpnHGg/7OZV8wPcH/roQGZAbenzYI54+a0ma0ALI2Av2szKhePQYR9qWhv
 zVM5YJLaaurghf502Ft0H1HILylFGNREoMaDEz9xzN90F0U8v3445MRgLlDZ0EPGPeDG
 opkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP5CCZE8hWvw+cbjRjeewy23Ix3fkJZQJ/ReLFm4l2lFWCCx89Gy1CIQBjnjPTcBB9u1f/klvNcU8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKT10hiZPSeakWkUupYecSsGmfSn3JskbMk4+yzBn67slnZh13
 zYtL4eXTzgZoD+DXRnNEhf+s9Tm6OrewLDGhQidiXU3+xQm08oMPdRNQ7yxxCrH8qe4bwtDhhk3
 WJOD9pRFRcuBkbEH+rExuNPsVVUdSWy0N5qi4NMR2QEsLgoCVGhenThGQicwdafuw5s0PPT4=
X-Gm-Gg: AYBFou0tUxOROryefJzHglPWm963IAT5FDyj4T08yWWrLj3Sfd8v//FjiMvnLPj3xpC
 P681JWz26lQJtoZBtfmM61Khpz63KVcjNukXe64GVsIojdKqfnjNNDxIbf8t9lRNA8J2FmejAmm
 hOk5rTXKe05stS516EklaEbEjvbdKam5gz5M9bJcxmCGjOuhMWehIkLkRHTTN9iJ/vVkS/SWNXQ
 gv5llbkj4S8LRTBQSkSHeBDLLRLwHgBAXEKJ+JXH3saobHt+PMVzTFP+oT1OYbUaBfptYelJsvx
 vao78DAL6Wa3nqpKRu5IEX3mx5tskOuyQ64gYjG0ixHRAm3RKO0LqTQTT2nUOdfEWq/GbIBXCZM
 c4IUscLAtKQGV7/jqARIYvbzsncZhb77AQQj9GbR7Fg42BIVofBmYf+Gv4gXrLhpknhNy1fvCLz
 78EZ5R37hqUe2p
X-Received: by 2002:a05:620a:2259:10b0:93e:f1a7:a20 with SMTP id
 af79cd13be357-93ef1a754a5mr35781285a.56.1791808204271; 
 Mon, 12 Oct 2026 05:30:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2259:10b0:93e:f1a7:a20 with SMTP id
 af79cd13be357-93ef1a754a5mr35776485a.56.1791808203701; 
 Mon, 12 Oct 2026 05:30:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cca23csm29408461fa.27.2026.10.12.05.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:30:02 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:30:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
Message-ID: <aecrclsbhu447xdfddwbhosyvhyvf6dzfv2nfznupao4oh6a3j@mqc623n6fnkt>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
 <f3qs4wcascfodjufisl4qtpycfb3lunff2fv4u3olybjius5kp@vahhjfjfh6wv>
 <a09f71a4-31e7-439d-b053-66b279ea27c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09f71a4-31e7-439d-b053-66b279ea27c7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfXzpFp4XoPq501
 3xJHTeyJotI6c8HxiY5rSrvvC4GXukXsni0t4pQC3LpG3NFsx7VKOzyQCsbznPEEWDwSOsRWDFM
 mypiypb7kQPmA1wn4bEsYJTxbGRqc1l4H7RXReilhO6yEUyNx7aBeX7mu/oJqJl9fO43jhL8i7N
 LPHbNWlbjuWEzr1pJtHKL+gU4Z+3CGRRlWdKKed6orvBB0Gy0nREYdZ27dR+P19gCCii9f/KcvH
 Wf5jcyDRhUK8uD6cuQWrVMSKmEL6K9W3wFsbab/EJY/TLaqxKJ3BJ5Xsi8kmyW12yNy3Q/ln47T
 wf2xTGQe5I9tPZ3ApPWntS96yHXRyLEq9GIEJ+WK8B7IznfaVRw9IgvsvfVMjsZA9Avc6SBwSh5
 JMSFtSVSgR5MNry6JnCKOpe/flvsxPK5ljAsL5Itg5kA5YBrB5azJmgfmjJG8FxhRoKxhUASJLC
 c87jB+EKkq1WBY7Z7gg==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6accd2cd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=fyugVKZb8pU3dQemVCEA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfXxczI0mUD9SfG
 r/ZmmVyeZTrEgIeT7miqUm0Rp3Qi02e0F8l8ZDBinqlFN+LUMBglBi2HNYdTBRd4igQJ89uXLZJ
 FWVmTToDoTzXXv30uxeTwb2zCSc2ir4=
X-Proofpoint-ORIG-GUID: ST5AxKWUWVV3KlgkMro2XMezX8wlWWGt
X-Proofpoint-GUID: ST5AxKWUWVV3KlgkMro2XMezX8wlWWGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On Mon, Oct 12, 2026 at 04:41:04PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/5/2026 9:02 AM, Dmitry Baryshkov wrote:
> > On Tue, Sep 15, 2026 at 05:27:48PM +0800, Yongxing Mou wrote:
> > > Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
> > > of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
> > > that powers the rest of the MDSS hardware.
> > > 
> > > Describe INT2 GDSC as an additional power domain of the DPU device
> > > rather than of the whole MDSS, since it only supplies DPU-local
> > > source pipes. Restrict the schema change to the Kaanapali DPU
> > > compatible via an if/then, so other platforms sharing
> > > qcom,sm8650-dpu.yaml (which don't have an INT2 GDSC) keep the
> > > existing single power-domain constraint.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/dpu-common.yaml           | 19 ++++++++++++++++--
> > >   .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
> > >   2 files changed, 40 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> > > index 3f953aa5e694..19b791a857b5 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
> > > @@ -25,8 +25,7 @@ properties:
> > >     interrupts:
> > >       maxItems: 1
> > > -  power-domains:
> > > -    maxItems: 1
> > > +  power-domains: true
> > >     operating-points-v2: true
> > >     opp-table:
> > > @@ -53,4 +52,20 @@ required:
> > >     - operating-points-v2
> > >     - ports
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: qcom,kaanapali-dpu
> > > +    then:
> > > +      properties:
> > > +        power-domains:
> > > +          minItems: 2
> > > +          maxItems: 2
> > > +    else:
> > > +      properties:
> > > +        power-domains:
> > > +          maxItems: 1
> > > +
> > >   additionalProperties: true
> > > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> > > index aa0cf0ec5b93..88aa71d2b912 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
> > > @@ -61,6 +61,29 @@ required:
> > >     - clocks
> > >     - clock-names
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: qcom,kaanapali-dpu
> > > +    then:
> > > +      properties:
> > > +        power-domains:
> > > +          items:
> > > +            - description: MMCX power domain
> > > +            - description: INT2 GDSC power domain
> > > +
> > > +        power-domain-names:
> > > +          minItems: 2
> > > +          maxItems: 2
> > > +          items:
> > > +            - const: mmcx
> > > +            - const: int2
> > 
> > Nit: I'd suggest more generic names here. If the next platform switches
> > from "mmcx" to some other domain, while keeping the split architecture,
> > the name becomes unapplicable (in the past we have seen platforms using
> > CX instead of MMCX). What about using names like "core", "int2"?
> > 
> Agreed, using "mmcx" would be too provider-specific, as the DPU performance
> domain can be CX on other platforms.
> 
> However, "core" might be confusing here because DISP_CC_MDSS_CORE_GDSC is
> already attached to the parent MDSS device. The first domain on the DPU is
> used for OPP performance-state voting, so would "perf" and "int2" be clearer
> generic names?

Responded on the other patch. I think that here we should be listing two
dispcc domains and then "core" and "int2" would be proper names for
them.

> > > +
> > > +      required:
> > > +        - power-domain-names
> > > +
> > >   unevaluatedProperties: false
> > >   examples:
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

-- 
With best wishes
Dmitry
