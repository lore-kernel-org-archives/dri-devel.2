Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C567C106F307
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15C910E95E;
	Thu, 26 Mar 2026 08:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/eOHtnJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FBVOtPHi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855DB10EA1B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:59:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q8gdvq3957914
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+InTCHF7LoGwXLOOhuuAjn2qNztxUkaPBxxy3m5vIA=; b=Z/eOHtnJcz7u7hDU
 SVr0jYOlDBWYp2gczFoshuG56R1wBuPz7kThQAqVCnQkGnpu2MneNyghWrm1oXNZ
 oYZERd4I04X7DkTYpg0z1cVHDhIUx4lU5nkERRZKRXMK2gnmHWmHma47K/h+BBtS
 V+R1DjtTxDsTFt5qizlbQKe/C7araLYRxGjKKMcnjP3ELftbnwYNH0hAQoZq8poI
 kmQBDdIs/tIyUKZE5wdw7cSL9JTSDuiu1ZZPZv0i+IbtjMaBuxERej9C046x10GB
 HgPHeM1W98xEDWz6e8Gn7u6D+60AMBOyEqfQREnzmmoMJ0sGNFN50+kd9pDqrCMO
 sV9qWQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tjahe6a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:59:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so613090eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774515553; cv=none;
 d=google.com; s=arc-20240605;
 b=MJFMysfj5sO4WnFwmfLzLgxqpHGpIMyPFCXdDVUi/QImIODfzO1kl11xcH0akW1B7e
 KAiJO12+9QA6J9iXjRqPxFLr+A0awh13s9Ju0CW2f/UYtmZqnxnYwyPPnk0f2wFu53YG
 Rl2+9ku2+o5xYgL68po6FTrTfxVwR7cQHAtwdMyQN3NzC4+dS8Z+zwIdNIPmzv/HAjoG
 HQ5NAbACzYMlT7eJ+fKFXzqVwvjr2js7VWxXFve1kx/kLsGWI2H6PJLMrhp5Az+eFpyp
 4R18gOOeQ7SdKph08cOZnvpWPFB1IxwQU9HYUfssf2oV0jfb7QzOTIhT35zTsoHjaJQJ
 47og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+InTCHF7LoGwXLOOhuuAjn2qNztxUkaPBxxy3m5vIA=;
 fh=NpLio4OgpvU1uDyPaTZiC1V+JkKrnPt8h76Di5XW7BA=;
 b=BJ6B8Jb7b13NYMW18ZswEDR1BZFS4i4Ee7HmlkSozaXmlOViCMV7iHib/pboIcL3bs
 GHTtGa2ZDW8WoAcw68MVueFxH89sEvf3FNuDwh2TscAeHm8GNYVfDAYLohYGX9a2y7sv
 13CCdLof64vDDRY0nSJmq5vekb8sLQVl8WApsznUNCiDXCkQytziNSMYQ39smGC8xuE/
 ToaprHXF+9w5hVAT2VyXZSZZICBbKWgnf7YQ138GGynjWa0ReTwgVotX10NJYmiLyvcx
 B7ods3SL0XlpmtXasTDjx9vniV39QiOZ6Iy2WkzrwoVaS+ZQ1TfFrf6dlGH3FFtku7Ki
 WqQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774515553; x=1775120353;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+InTCHF7LoGwXLOOhuuAjn2qNztxUkaPBxxy3m5vIA=;
 b=FBVOtPHiRH0FulA2JJ2aq6VXq5dBL7JqPoPhlO7xcNt10G3H2nfNXcG680886+RAnu
 rSvSelw3Y8ks0MuBqYrYe2VoFEvTlnb+hj6Ubkt/lzc13VuOijtsY2Nqhdkc5VLVcMud
 QATdINTMKb3xnhpM27Y3YFLspPe+zgnmKCp/wKTuBfpnYf9iuGWydHhhGNINv7qEs1QL
 PnxRhgFpWVDaSwLq6HXMBtpJKGglPgqcc/XvtayB/qF8UB4EbLvaiXU1yQPobC+Lvegx
 lob/HeC6ygVemASx6acyWGNPnEpAq6FLBGGTUa0sSyselT6Fbubl4/mUPap4iTp+ulEm
 U9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515553; x=1775120353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+InTCHF7LoGwXLOOhuuAjn2qNztxUkaPBxxy3m5vIA=;
 b=frS8cEMTwIsvlaBzfYcPQilX2j4SB/pQ5YFpS4GTNGvx1Hp6+Zy1w1p5cx9F4v0wbF
 3Ji/A6JD2E0wXVUd14eUAqIUnFjjW2pP93DSeXWFDfgHhNtcNYH2K47MlxNgygvhMWyC
 loSGNKB+NYe0jtafgzB46OLKA9fpK1tcQjwXKGR9LbiWHdySN/MBOh8M0oEjnQT9Eci0
 CFHIBXMtLHE/aBZk01tVZyQE0DkZ5smZZ1m2VQ/ORj7jIMI2/glZpp0oeNSD6UOVFDav
 YWIn93In2sh/E4WJx+dELlidXcI2s7K3NNepaQPBNX26oLWmMDASmuGl039/r8PE9sVU
 J69w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMapehXeMO4O4f2ZfiBJMqpk0Ac3/N6hUc38fxN+U95eooo4mKLaKswTUTVQ/Ou+hbWzcMamU2aH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL3m8N/dI8zGCZt5YAL0C/4YgoVpj/700oP4+QLGs0Q/MvPmuW
 6T0loLmQk6nVlLyVhwL8ilfQlUU4HAcRK5xZgknSS6zUP7znnSgAh4zA32lbBONHfhRvjdLE6am
 acXTsobk+yF/4OSf9Pg32Xv8pieonbL9+vfdTRa4xUdHF3Zobw2tHQpT8wXLdvgz1WJ+zUhB0cE
 2E+QJWuVNSNUzlrlE5hjeLyxgSsBBp6nrYUbg9ukshty2G4A==
X-Gm-Gg: ATEYQzxCwWIAGvIoVVI+ju3+Zfz6m4uccs68Xd+WVrQUgn2rzAoEg0y61H1tOqsLiSl
 wZ6cwclA5pnJPH5wq30tCJQVd0/AT2fX8yDZZKQv+g6+CY/vxXMkLeJ1YeuG0WlLGt+oRqbnMkh
 iAIkK1LNgNzTvMBnvGVD7fKlEqXPRqp2k9eEEQKWTegaWK1XHnJ0rQh2YW7MMuYYulp2pYlazQx
 WP0GO0=
X-Received: by 2002:a05:7022:ea2a:b0:128:d1cf:8ab with SMTP id
 a92af1059eb24-12a96e46fa2mr3330861c88.6.1774515552569; 
 Thu, 26 Mar 2026 01:59:12 -0700 (PDT)
X-Received: by 2002:a05:7022:ea2a:b0:128:d1cf:8ab with SMTP id
 a92af1059eb24-12a96e46fa2mr3330834c88.6.1774515552022; Thu, 26 Mar 2026
 01:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 14:29:00 +0530
X-Gm-Features: AQROBzAUo4DH20fFy9231utP08t2yCcbvqzwHE_c69J9vb6d_jOiVNCU3yNfHHw
Message-ID: <CAGptzHNDSYrA9U0-Ej-Ay6xFu88inPc1RM04j941HOPwQ0m46w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display/msm: qcm2290-mdss: Fix missing
 ranges in example
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: OqyoluIA_IPECge6KimZajCxiYC9uxZ8
X-Authority-Analysis: v=2.4 cv=Nr3cssdJ c=1 sm=1 tr=0 ts=69c4f561 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=u0WoYhsv3NxjMHURO3IA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: OqyoluIA_IPECge6KimZajCxiYC9uxZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NCBTYWx0ZWRfX8uVKIdMTpE+p
 yFW+2o3alITsGgUjVtnIgjNx34Jo9KP3WV6Mej++GYuyr67Z6dHpjEuczWLkM4aRs9jHDHPKlIl
 neouAKAfNA34tuUwEc0GTiCD2XOVlqJp90ph057pgt00HoliLnuFgJs87wEFqCpdPvHzIDSebxs
 bTdMu+9TkGxnRk4s7+IzVmQZwmULNkKY9qwn41VtM9jzGP85gENr8cQEKGo+mBZuhB1oQYXqOmI
 XAjH6wf3a+OQOFWnCNw+WFeiyPDCYnK/JUsYsWoIJ0aWELqJbZfFxBFqAzzgmIaqdD4NSGI1KZF
 lwSToZlKOlFJ6Mf/EclhDG539XMCjRR2611CUrMAG8u+Jk7RkyjBhHLTmubVJvxs4GWMN0hXr7l
 qOYlrYacprehfPIujPm+0UrCYJVaIKl5i3v/HrK6Id1BAdWjxO3LoimxNVutml8eK0ZTPgZFZPt
 T5zPpVZDFgw0xuKpy5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260064
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

On Wed, Mar 25, 2026 at 5:52=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Device node has children with MMIO addressing, so must have ranges:
>
>   msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000 (qcom,qcm2=
290-mdss): 'ranges' is a required property
>
> Fixes: 966a08c293cb ("dt-bindings: display: msm: qcm2290-mdss: Fix iommus=
 property")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> ---
>
> Fix for commit taken by Bjorn (Qualcomm SoC).
> ---
>  .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-m=
dss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.=
yaml
> index 2772cdec7e42..bb09ecd1a5b4 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yam=
l
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yam=
l
> @@ -108,6 +108,7 @@ examples:
>                               "cpu-cfg";
>
>          iommus =3D <&apps_smmu 0x420 0x2>;
> +        ranges;


Ah, it was surely an oversight on my part, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>          display-controller@5e01000 {
>              compatible =3D "qcom,qcm2290-dpu";
> --
> 2.51.0
>
