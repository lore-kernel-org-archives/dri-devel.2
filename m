Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE2FC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE8010EA90;
	Mon, 28 Sep 2026 13:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4tRZgHZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IpdTYsG0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE6F10EA90
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:57:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAJvN2404444
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=; b=Z4tRZgHZskb8ptT5
 TWLgXlXd5ZEfOMXoSIMOXv3xiSCfmZPrN/BXEN2Jx/EI7xgxsl/mhtg23qiOqhBr
 lotZeIr931hrlSEd5cQ/+wfndIUB7MMIEPhy0N4qQaoL3vx0QDP3gKzGCBMkjA4K
 qZEViEARpzKBw/bZJdJ6k6fM60UXmpX36/eFY3dIVjAN/AFSwPSLBAOzinZyFOZG
 8mAxM8Svcg16uWsn2JDQlVfu7pS1jD7EKG1O73xL6IcpK9DHPvN80Fj2n8ZkDcIH
 gzgCPX/52m/fh2UgSttxIDJ4qB8q8S1LQf9euuiVEAdLjZcrqYl5RVZOicTCxXKu
 X1l8WA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t1ss8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:57:48 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-86ab8302b54so2399877b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603868; cv=none;
 d=google.com; s=arc-20260327;
 b=g+2Kr9ic7IWsE0M7wXQmMUjUHWmrnnTgoDGGMaVELhxt4ZhhiP+ShMzu1TSE4eubsq
 +R29YibPvZ2zDUlSev1+xbFAwWadIcyjI2+ReiGa2ApeOIF9nTHesMhaiSBNCW1o2+J2
 nBn5IGeI7I3zMcVSzxaejDLzX6cRqKvq7SL98kjSb/H3GhRZHemoEmsgXfv/KFF5B8n9
 rNXKpSxo+AdTqMHKIP/tlWfZh0cCwnaaXALyVRqB5w1DOjtJF3JkLmmau0LPKKlJAQN6
 y9e0L4nLZ7jjojaa+DyEtxEyaUnHDCbgTxUNo2CBgGULGlvNv+MBEeCC7fBQZn+gZzS/
 PvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
 fh=xc2JQrxXDYwgdwDLTohYpYW5GN9MAXhbS8zHv0iC2vc=;
 b=jWrNmY4SH8fF6671SvEHg2mzfYdF+WyDCVhvRxLT5efMKozYDLYzLgBaUDzriaRCOm
 ZQ1SxMOoyVXYpEYGcdgYcq6lWej6VxPm6taKS3yxtol/0YvRiC5urbXBPMlVJ8elHYe3
 7SwuDN690MwvwagbN7UT0LRj8sl4Vap4ElnXDOiFHUe1NLu0cnhZinHgLJPm6WAO2vCy
 Ks50vqjbmjTRZbAKmNaq4BRcxF5ulKfKPuDgwCEys+z+hxk2mlh22UTZLH+ryukjG/dN
 1v7wSJIlqIU7J0RlV8hDXmQ9opyfyT6lCmar5o4MyhNicwTbWTbOThbDEcT9YbIoiqLC
 TxNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790603868; x=1791208668;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
 b=IpdTYsG0cZJTLs5Hyi1saGcKwVIzN6A7yX2PWm0EMZw/1/qVhHFdKyQpoSGJISDMkd
 7kfcrltUOKArKYet7lXEQJWrJ1d3S5kIV4BKXv/I1qGILqVwecKq0nrWW+ZmZ+VsEZMO
 GCJZskNytHCceyZcELvZnTAzklfP4VYav5UUr+U+Vk1TeOMXiKM6n/urnFq7H+YX9HoJ
 JbvwC+59FgI0G7SaVrKiIC046Tefa+kvgnfIaliO+/18m2d0rWByIVpmIRKEf6AUPPtl
 ECe6VeOfdevuVYOMg45V89/FEQjTPLS2QRM96AjYGY/TzWix25GfzYvh3Cx+pmQL8VIX
 TOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790603868; x=1791208668;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KNeJ1ZSGtxogqYjubG/I2m2j0TylLASWTRkIlPxaG/Y=;
 b=K+nJ31JqvzGvLW24smUVklV/Vfq+obzHE0MONPy859vR1sJifOAcV5AR22HOojwAc+
 +DVjCKN3E+z7BBR8nWCxIxdDed2nQOqdy+JTIv7MLhHR874ocDkfh+nLKjDKV/hfwbMg
 bRx2AAZwBxlnSh1ZfD/OEmWgb6ox2Te2uPd6JRjbkYTZvpCez0vLsOeYJEnV1L42Ul6D
 KX+jQPSjA32AR2Pyv7dAwB+61Y3kBLiP6eouOn5QEMlDjY0zuJ873zUe0UafdsJMTvHw
 uX9O4Npa5cjjZI8BokK26siR4WeMPiLonGzarkNLRA3JBNAsy+r+dkWwsiJTY+uGXUGB
 rfFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkpZmh9DDGtWxbMF5yhbigB/Nqwr2sKbwU4iH/mDI4yA6Fj/azfj+39kvvf6zyTlfY43AATYx7plk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLt1tiN5JbM0zUxDxA/hrG11nzS2PJo/wv+c9hTH+WYaKB+KOeM
 tXESVtjGghdimyxmSqq9RKuUTGDl9U71nG7OBNH1eVVP5OVcbxT320PFAEdfNmbk5be8YI3mKox
 56baQDBIfcuzdh2pYpDxQBqKmTVl14ObM9MwTDYZa3T5Wc3uxrXBSu4O2RWDRrKZ3XhzUkbwRq9
 Yw+gOt+AcFw+iOQCTxBab8q2hrfK0rXw4TqoORxTn2idFnPA==
X-Gm-Gg: AYBFou3eXNN19uxURzr1sItuBau9MlzlNuyQQrm6qU+XbQLDSPy4jj7DKIxPBlpSpbZ
 Ko3u3CzKzLF3IKuKWyQDgL0ay8ZcbCDVycnPArj8cE2a0BwuZoamkNp5TLHsCS6OGyJYfyJdWC3
 tXARVET7SkbQSGtQ4I40+BPhSIdTxsvIRjbaMiuGZR0t4AOHDRb/i/T4WjtA==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006771b3a.23.1790603868171; 
 Mon, 28 Sep 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id
 d2e1a72fcca58-881c8819a45mr4006707b3a.23.1790603867726; Mon, 28 Sep 2026
 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:57:35 +0200
X-Gm-Features: AclHuK-nE9h16BssbY-0V-0Lcqrz78yNjoqqCVRnCD5BWpC1wzqbo2Hd-T05VXY
Message-ID: <CAPx+jO9Vj=42dHEwLzTHe1b+nrvip+ibVv4iPquxwJKbFAkm=A@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX8K0Vi8UWAwwG
 m6/CSuSOCwCexLXLy+f7E2fNdnLPzw+wlNs19xP7d5289Un4nz0zqk8JjFJjp62aqhK+IwJtqfw
 D6Ljsa+anW16eTgMYHwv7R4jnZBbYxPOok550U7B4KbtoyzyBVKZTPOqX09dpSpydEpH4wRGT+G
 EtsHDufVphg7wSr4NONEwosw+gWRqxAmmrnCY1dneOUjPz9mLBdSzPIAgkK/gp+lGp5meqe1tbp
 jv0owob43R/zS84Vsyy4+erhTok15am/WndIWCaMfYsQcyvJ0s4iwF7jvtGFJN7tyh4KU8EaYgF
 40XmDAGsV9p2yxQc3k48XwAWEcNU8GX9fLK+07oDauGvh0DxjXNZkbYn8D9Afunr9zR0xPmpYpY
 Hv4G7oB1I7FeyWJ3Ep5Tue5PEbYyqUNB1Ku6lVYrMYDILJ5hghJnBu+DsCkg2ZQ3PZn5JqRUApN
 nYbSR2gCbRuTCcui2ng==
X-Proofpoint-ORIG-GUID: QQ-C4fa2lDijDXvj4VslKNCOkutHwd7W
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba725c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=xo1k5ONJVskqAlz3UKAA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: QQ-C4fa2lDijDXvj4VslKNCOkutHwd7W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NSBTYWx0ZWRfX1IfsXodcVBSi
 vTBsC2sVjZT8VsXf5E4ZB7RmLT6sfIboYJNElZPuz0RO+a4zWwouF+pn3BAiklhpC2iawq0pTdr
 NdF1A+jIE+pOYaG2fJx62exQ9lD8uIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280055
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

On Mon, Sep 21, 2026 at 8:19=E2=80=AFPM Muzaffer Kadir via B4 Relay
<devnull+muzafferkadir.mainlining.org@kernel.org> wrote:
>
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>
> Document the compatible for the rpmpd found on MSM8952.
>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index a70bfacbc5d1..8ee1c25a7c9d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -76,6 +76,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,msm8937-rpmpd
> +              - qcom,msm8952-rpmpd
>            - const: qcom,msm8917-rpmpd
>        - items:
>            - enum:
>
> --
> 2.55.0
>
>
