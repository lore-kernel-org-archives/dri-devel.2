Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41319CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CAE10E97F;
	Wed, 10 Jun 2026 13:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICR/aSus";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhOXxcDf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674B610E968
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:31:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ACBmRm1169802
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wg9PboEwMxlYPdtB2q8pTY18DjjWx3Pqn276RgTauZY=; b=ICR/aSuslL6b0sMB
 uRfP3A/2hEcK1Nc8h28i4AOggzIaDORne+4X59pQW1/S0tRJ4OUBcER0whl/unCG
 +vhfTOavxKRsjfwy1YdMLKhP+hTxHTXWB7Bf/SCm3TAgt95Es1zyd6pXaVBAWYku
 eb3EuSnl90V/KM9KFUXMCYU7BJEnpDusCsvWxP2NDBEgagLY4TQnGU0iTMY9t6ep
 eiGq2LDoWVfeRYQx5/tjEHX0wG47STekL9AjIQDDebDi0IB/E9ByFVqeeMP3oXhn
 WZsnrQsIsDZm+ls2899gfwSY3fmtue86Oo0rSiT/in50zSoTjOy6ftca83uQLSst
 v9EsFw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq4w1s0ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:31:44 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-48637dce961so5626279b6e.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781098304; x=1781703104;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wg9PboEwMxlYPdtB2q8pTY18DjjWx3Pqn276RgTauZY=;
 b=hhOXxcDfbG53985K5GgmmtAl0GYbSPYCUfs7lBWkE8FJe5fZg802cv8VVWgn2Xla8u
 q9vovmykPZUUY1KrMl0KOxZuRlthrHI2BrsVISv+JLewNYtXYI8PEmMxHWlNkd3qDeBu
 02wPyRzKQL3zA383Nh47K8pes1Lm9JWOgSAE4BWMkX1TwX5J6zHLkv0m2ZlXPkM/Y/VX
 yPniaxMA9UgD5GU08lRar+Cu0vQZgq8LESvNm3Xtkd51SfnPoQAPW4Mh+MYH7+iBRlxh
 XvWtlHB/BT5hELNPNknewBV8G/PFUkbW8EcLZuHKQ4L2vvSVyt57330hGXKNfv7JpBMt
 um+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098304; x=1781703104;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wg9PboEwMxlYPdtB2q8pTY18DjjWx3Pqn276RgTauZY=;
 b=ht9dHmgmAfs42LzAw8AcKF8KSy7DnZgmTRWGxajkt29eErPO+a1E6bijNUyvvmQKqE
 JQjBEVAVnSVJJneWxjL/9Gx2/WORH8XI40BbI/NhG/6aGoLqIcUbrYi2gSek/W98rECm
 GqZ5iepaTJfeecqUeo97dVVLF3hBjkS2bB4w9BEn0gqwOsdqbc6x4qvH+T3NXGJyOj9Q
 zfJ+vsbjcJhro83/1duYCcpB13rAbZAwQjcJz2Wlg/bXsAd8CmxSwTgF0uIOHR/oo/Sf
 RbzZPuzeXvnrl6s0VZBzYWF4z5xhBIUXSvhfBP0fi4JavPfqHHe1994ZZw9A9EJm13Sn
 3ngg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9i0rjYTx4vgeSS1tBX+8jfmiVEP9f96aSNWViOdrE9EiXrXkAbQJqBdpcdOikLlEFbRkOu+BlZ1jY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsjwrB37F62m9FbDypxovJ0rz31fXnzUCzlepWAaeML2xDBae3
 trahR+nw8WgDXuiWdhSuqAtw4aW/jdj7DZgYvQ/E8TJjySD7dFnIJlhXAL8ayXF2g9KpkqEN8T5
 Zpt51lYOUkZcXrXbp/ALKXGfrcDyI4dctAoRsU1E9fThAaLk0cPZpSLZbhcHAZ3q/tEsnDF4=
X-Gm-Gg: Acq92OHAYB2x7jYImns0aYlBgmuu9SA6/cEM33l6kzbqIvHoFGeLQ0bQHwzQGQzp0yB
 bCTkZJ/v3EF0OIbooPZt3OwGhMuc2AgyJJJKxIFfInH/gBQg5U4SIjr3fAwm5aWzE6ow7crcMYp
 Grevq6CAAzRLohr7wf3u5nn7jbaeSjFqiLP4DI8+d2juEr0ht3Hd40YZLvhiv0oHkBrNYJg3L16
 jpeb+GsVkSRJAXjcCCrAhzULCRWxEnNA9wCGoZYHqSjPr8pWTJnV0NxUOSTgt4OpynTS2DpzwSw
 QcdLI4jewt9qy9blXltxBtKARbq0zfK6LnX1wKOlPQlIau3q1xTkppzYbO+MRBAuIf8qVrg1xhA
 Hr5tkQdLdux1xGNKNIY4ttbuZrCqnRAlWJZ0uAK7Iq4g=
X-Received: by 2002:a05:6808:f88:b0:479:ed26:fbc9 with SMTP id
 5614622812f47-4868df001efmr14620731b6e.32.1781098303581; 
 Wed, 10 Jun 2026 06:31:43 -0700 (PDT)
X-Received: by 2002:a05:6808:f88:b0:479:ed26:fbc9 with SMTP id
 5614622812f47-4868df001efmr14620647b6e.32.1781098302891; 
 Wed, 10 Jun 2026 06:31:42 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e5a00sm557977595e9.15.2026.06.10.06.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:31:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:31:40 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, rob.clark@oss.qualcomm.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
Message-ID: <uieb6ukjokwnppc5zfr6bjychqsnpikwmiy7j7dmt2kgk7k4zi@2stv37ijv36o>
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-2-57c70c23d0d6@oss.qualcomm.com>
 <7a330941-8715-4523-9f39-10b57586c69d@kernel.org>
 <CACSVV03J7Y4-ADRNE+4qArqsWvQZ3qmTc04r7vmY64s0qDYFkw@mail.gmail.com>
 <799fea04-e7d0-4184-b9ae-4cebfdac38d5@kernel.org>
 <841a54ff-6287-48d2-a513-a7442d624ab6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841a54ff-6287-48d2-a513-a7442d624ab6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0a5n1Wt6EM6p1SwqFZsnh6NjgdvtRH2n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyOSBTYWx0ZWRfXxCQR9gxpP4vy
 wjNVnwOFWxOvYoVju9xs65hfnSeq61lRdwRRoQ1Y67q75FPoxzRlhcYHeG315w2L66gm4OycerS
 2R6rTYh56pNZ4TI9k/BOPumMV3cB0vb5vd8bzjDASGIzzRklViuS3Q4x7D9Il7VZteQUnmmtdZw
 Foq6TUSwsOJYnVEpIi+izsKkCCamN+GFsXI+ZXnlto4l6FwRNpTLyJUJ8owjIsOmHxlMSPDvQYF
 qtp0yCY5DSK5+gskEfWM8aFBnxzKKdBQMCm3iprflle+ZKFRcsJgAaWV4OckFYuv8HqZp5iCrkr
 z1qUPXirEalALT2FmGxQW3LcfyFPndEEFI3R0jYWV/CqW/lui0feWI0CoNUnbNIwqiYikmEtB+T
 I4RtyzvPHQu96vlRiBeGVGuBi/x4bIQ81/7QVcEgwIRPWbkEe3tMg2S2OI/s1UyfI/IeNM8hbtu
 qW1WGdUaB4Wpm2D9W9A==
X-Proofpoint-GUID: 0a5n1Wt6EM6p1SwqFZsnh6NjgdvtRH2n
X-Authority-Analysis: v=2.4 cv=ZfEt8MVA c=1 sm=1 tr=0 ts=6a296740 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=BSZ3G9h0/EKbgBlQZBbU/w==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=8k6WQxmsAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8xXDVyUwim6Fg5z79ZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100129
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

On 26-06-10 14:12:30, Konrad Dybcio wrote:
> On 6/4/26 5:18 PM, Krzysztof Kozlowski wrote:
> > On 04/06/2026 17:13, Rob Clark wrote:
> >> On Thu, Jun 4, 2026 at 8:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>
> >>> On 04/06/2026 10:06, Konrad Dybcio wrote:
> >>>> The Yoga Slim 7x Gen11 is a Snapdragon X2 Elite-based 14" laptop from
> >>>> Lenovo, featuring an OLED touch panel. Add a compatible for it.
> >>>>
> >>>> According to the spec page [1], there  also exist other variations
> >>>> (based on the Mahua SoC and/or with a different type of display panel),
> >>>> but those are to be described separately
> >>>>
> >>>> [1] https://psref.lenovo.com/Product/Yoga_Slim_7_14Q8Y11?tab=spec
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>> index 50cc18a6ec5eddaf48542b85387c2d430cd4721a..fca3d180489d4cd3eb2726a722f15febe44f03ad 100644
> >>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >>>> @@ -68,6 +68,7 @@ properties:
> >>>>
> >>>>        - items:
> >>>>            - enum:
> >>>> +              - lenovo,yoga-slim7x-gen11
> >>>
> >>> I imagine you might want different panel variants, just like T14s has
> >>> LCD and OLED?
> >>
> >> I expect this will be the case.
> > 
> > Then better to prepare for this now, otherwise later you need to change
> > bindings. If unsure what other variants are, then at least make this
> > compatible panel-specific, e.g. lenovo,yoga-slim7x-gen11-oled-foo-bar.
> 
> I took another look at psref [1] and there's only OLED SKUs (today?).
> There are however, two different resolutions available and both can be
> touch/notouch.

If the other SKU doesn't have touch, then you might as well mark now this
one with touch suffix or something like that.

> 
> I don't know what this will entail - if the panels are both samsung, I
> would guesstimate the same driver works for them (and Doug was against
> adding new compatibles [2]).
> 
> There's also different SoCs (which will need another #include in DT to
> override, sorta like hamoa and purwa models; they seem not to be
> available in the store rn, but I'd assume it's fine to just rely on the
> SoC strings in the compatible chain to differentiate them.

I think this can be reworked later on, as long as the dtb name stays the
same.
