Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6E6CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CE41126D2;
	Thu,  4 Jun 2026 15:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAQ8nRem";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iRhEJRu8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B201126D2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 15:13:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654EpcJe528695
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 15:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=4my79OSMQYPXhU2YUseQMtgxKn07AEG/1T3jHV6k98Y=; b=cA
 Q8nRemcWM1cs9R4fXnIyTAAMiK3S3VySEnx2ab2jHV+Y2+JPMDuLfcKVsugBD6J7
 yScjDxdDvrhuz77j2XQWlOGoyCqMyk7STeUHcPG+zWfw4vVYClEN08Ttqp0J7cxX
 ZhoaSmnTkAsEVjmZSPeMb+69Ft55fd8q6xDQw5Z99VSc+H3KNOzkIqfYuekKDeQQ
 vr6Fn9CMFYma2+Ub+wVyrD41VTVM1dW3h/aOetrf57WQzqrjDu1kmzpHJQQoy0WI
 H/YzuF0ozwapJT0SI4diu2lnZ5oOT4pQe0oaaiswuiV0L+b0enCKEnpZ98Md1IQ0
 74qmGX7KXzUjMdVDVgUQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekbgdr3vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 15:13:48 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-48576b309c7so1063733b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 08:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780586028; cv=none;
 d=google.com; s=arc-20240605;
 b=DU7Y1h0mrM1mbBWv/bYBUtEm9fGXe+izs94JyXMu5igVjEixIGCmJjn8xhCuoXjCxJ
 Pg4EhyGxN+YDpEZVFe3E6Sx++N/SXdyCYBF28uEEF31SZJ4qaactPkvVBL86y+z+MITv
 rE1qi/AeMB3QGzJoGD+bz4cFy9fno6cbTfA0De2nedb1d06wWH9+u675DLbnZQNWJ0YF
 9mgHDIGa3b3FaL5jSrxPXUDX1B9fNfYpK4Y5RC/h3MvyCF2azSg7IelRHDC5QQ91CmO6
 uVnTbEX0+BvAynHzIaa3ZwRDvtovt+rVPd+HBm453sDlI1HXwkvrEigqCJQ2kJv1T+mt
 LGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=4my79OSMQYPXhU2YUseQMtgxKn07AEG/1T3jHV6k98Y=;
 fh=xXhErSwIJ85HOi0D3tcwnKcTuVgRueGGB4LW8YMIlIQ=;
 b=dpMtfHm+f1185Hf2ixi1O7L0/MdTWdwGwcjDp5ZFGFsqtYnNZSgmdRbYhgxf9p2arZ
 LQ6PpYwTKxRK1fx2t6UN5/qZeY8vYZeWqo1+ke/isBULtejqlCulsxuy2iDUWs8Z2T6y
 46yfflo0wfhmGKJaAEdRiKpGK1hbxod2jn0XWAqkjvkSep3CCtmerOR+461T/GooQIRn
 z1I5Edkq0uPKjFPJcZrtwKKMwBosf4W44KE6kJpXVRxAMkzeRiGQEq/1GUQ2vi35FEXX
 fNOVMhCUP+xh3bLeVfI9IyRfPZoKjfdukuKzcAkMp4TwExvgE+eGh13oAfhx7TVUoOuL
 bzHQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780586028; x=1781190828;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4my79OSMQYPXhU2YUseQMtgxKn07AEG/1T3jHV6k98Y=;
 b=iRhEJRu884yZLoGeiBhNrqmvHow7TAD3Wddfpbi3qAtsjRsOrVtIzD32j6D8SJUYaw
 Oe+CCJiK3H+A0nqm6gOx9JafpcEN3c24ql5tizQGSg39iyVCuJqjRM2SBWszE09gEIpa
 zu1iBtD/pEE15HOQH3SNTuLuyqr5hUJovzz+84rEOAMOAn7ZR0HWZmW0aejCYS6m7uMj
 7Gj17C7731QBIi2Cnt4QvKIsDMxVonKmK77v5qKYuJsMqf0fhrGAdo3M5DGWHyl07fA0
 wLkwWd+7KuKYjd582sAitWMWvdElQt6sBT43nZzNlFTG5c/dEUOlSacrFDCPg1fnRoK4
 gbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780586028; x=1781190828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4my79OSMQYPXhU2YUseQMtgxKn07AEG/1T3jHV6k98Y=;
 b=jt18vvWnpMvFLQH7EiyfW2E9w37DcZxmnn3JQKrSoJ1X9Wo1cdH+d0tg6P0mSMWqG6
 7jn7/VW54eQjg63OqwnipU18kL28fAwBq71/wt8aOUekokPXbZPEjT/WxL6bkcf3uocS
 wtS7PQjTQMG0HEMxHfQxFuSEbWMlrHXcb97VMGeIYT8lb/9lCD9oog2gjhNgowUmGcRR
 zmrM81wCyOKsy02XxBWdgJHm/FP8jkPh2syDHYn889ZquGEBmlLoT1APF2BktZsvj1yI
 ekJt1GbEwgE9PfUL08ghe7PxgMQDQEajWa7G5NvPtG7gxPNyjarH1SEpN0MFMATUxhsp
 dQAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ930EdzMG7OmMtY5qUpaCWcSmeOe4z/27jSbJtzyKxntUlV5igYHBO4ZYv3VTU+iyPeiMmNLUZwvyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQd1R2YkhlslpklL3lqQ2L/phVgkJdpPxfhUdKGxA3MBHi9El6
 pgutpbwg5n1nKyjXiCh7UcwufxLj8EtTCNTSl6aMPGeiO/uVmohtxNWrIEqwbHffzCWdS8q44Ce
 VvpYLYPax12o8WFYDJ4StfFpYLmkC9kV6eyLPiOiufVbo6837VEBVcjl2YYCniXIiiywywE6qUk
 nTEmR2S85JS7YZT+tQgLTo2CQVuM/7p0CztNUUaIt3O/5ijQ==
X-Gm-Gg: Acq92OGNRYUI99BTppbLBRI/FZNtU9H8OOlNsSTAG88wBmfzmIbmDLuriFLdQ0ZkR99
 EwPL0khFQGa5GLKFnrk2yf44ob64K1y3mTJmnjh2AEMlcDnu87nUFTkWrPZ/Y7BYtu0MdaD0op3
 5T06UBkOB5Hz0gJtWEYNxOUbeWxyAZZTnn470Zj3uqTKdIwCm+Ey1YYU2hjjM17wZDpv6bJj5ID
 +tos9IyRM/zKw==
X-Received: by 2002:a05:6808:c1f7:b0:485:dac0:a7d with SMTP id
 5614622812f47-4865ac6394emr4440374b6e.22.1780586027674; 
 Thu, 04 Jun 2026 08:13:47 -0700 (PDT)
X-Received: by 2002:a05:6808:c1f7:b0:485:dac0:a7d with SMTP id
 5614622812f47-4865ac6394emr4440357b6e.22.1780586027300; Thu, 04 Jun 2026
 08:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
 <20260604-topic-yoga_submission-v1-2-57c70c23d0d6@oss.qualcomm.com>
 <7a330941-8715-4523-9f39-10b57586c69d@kernel.org>
In-Reply-To: <7a330941-8715-4523-9f39-10b57586c69d@kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 08:13:36 -0700
X-Gm-Features: AVVi8Cc6hFS_zyiHZip3PSaTAI0DzZRij3zeQsebuwBfCNnS4erThfLHMB24ZW4
Message-ID: <CACSVV03J7Y4-ADRNE+4qArqsWvQZ3qmTc04r7vmY64s0qDYFkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: P-wSn3-wqFAz7fDF49m43xkJf9UiV2Lk
X-Proofpoint-ORIG-GUID: P-wSn3-wqFAz7fDF49m43xkJf9UiV2Lk
X-Authority-Analysis: v=2.4 cv=a8cAM0SF c=1 sm=1 tr=0 ts=6a21962c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=8k6WQxmsAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dX0BPLNIrGpKtFaJ3e4A:9 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0OCBTYWx0ZWRfX8KpIR0HSXjh+
 L4loAackvHyLptHDuuW4CZ2m9q3ySzKngnMfrmImi/X5zLkzT4ycFdyTgM6IsystvnQ6z9y4OSM
 lmwx9bbmxtIA/fY4HXhQhGwp9JnFVP0EH/tW0iDkpwH+U0Q4yb4LE6KK8ssdwL54RjLABindM1f
 FVPIixuv2fQcA51rYLL1sdksGUEvAGZfPU1Ox/h6tEbbbyvDAP6RoXK5kM3Z49l3hLPbwBbqXRd
 oEfr2waja3bNcx75Svo/rIAIllzP1yFBAWd8v2ny2XPA6T6AwIgCVSbXuh3n1Kwjp4MvH9mZo05
 zD2EY8FWduPIo1wMFfGwrfJK/PjmWYJK7LUTwzvTz4zN/+xAdWyy+k3lXECUyINNgKsq6vaaTRx
 KOwjmVjaOkhombQBBSzV34Gq6X4kV3KHTt4evqt0rWiwV5RLh+ZznimGSU+1pyPczvKN4RA0YK3
 7mSEPg8+aD3GRWfPMPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040148
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jun 4, 2026 at 8:09=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 04/06/2026 10:06, Konrad Dybcio wrote:
> > The Yoga Slim 7x Gen11 is a Snapdragon X2 Elite-based 14" laptop from
> > Lenovo, featuring an OLED touch panel. Add a compatible for it.
> >
> > According to the spec page [1], there  also exist other variations
> > (based on the Mahua SoC and/or with a different type of display panel),
> > but those are to be described separately
> >
> > [1] https://psref.lenovo.com/Product/Yoga_Slim_7_14Q8Y11?tab=3Dspec
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Document=
ation/devicetree/bindings/arm/qcom.yaml
> > index 50cc18a6ec5eddaf48542b85387c2d430cd4721a..fca3d180489d4cd3eb2726a=
722f15febe44f03ad 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -68,6 +68,7 @@ properties:
> >
> >        - items:
> >            - enum:
> > +              - lenovo,yoga-slim7x-gen11
>
> I imagine you might want different panel variants, just like T14s has
> LCD and OLED?

I expect this will be the case.

BR,
-R

> Best regards,
> Krzysztof
