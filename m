Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A85606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DHejP2Uq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f3lJH57e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7107A1125CD;
	Thu, 22 Oct 2026 12:48:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEC410E3C7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:47:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA062k3427078
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=06kemhZBYWxkv5vRs3riZ3fnXQfC1fnOjES4AGUZ0io=; b=DH
 ejP2UqKqnZRcjb3dBlJySyQ62Va4PpCZ3lH+mvy9or1T8HObGB0TJfC4G6h3wxzl
 xVPSoBw/Xy17TcuaBdjwd43QXaRkck90qrK/VEzlfDFbeQo26ggJ3Bb1pMJcsV8f
 ZV6OBhasP0QcQbGExDwvasAZhmjnoyPkglpToyrmCfqMsKctky6OjEd0eQuOvnku
 v5QHtohgNUYOe04uNysp2Kw7e5wobZ12qXZRHmMCBljN5QMqZvZDVxmT+kMvTrBK
 n2LyUDlHAOp9ki2QV9GzSNhNd1MUNOKw8KL/rq6iTjyrJebf+gxSI4ptdYQMu+Et
 TquK3SHU9+1tnQaGCvpQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq24x9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:47:58 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-70339873137so829631eaf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673278; cv=none;
 d=google.com; s=arc-20260327;
 b=e+A2Vxm3Xu3SM5SCm9QtaonG5Z+4XChGoxsXlBrtzShSkeNdaYLJVFZiGHU0Icyo0+
 TCr3EdvK5PycvAi32xN4Po0+12ZZky4ldI293E4KKAdEWDTDyirlIZw7ag/v0p0UJMIk
 0zO8gmVxCXKJ9k9WgwCKvA15GCbPOPiJfDqOe8DygfAEDEtcwVZNwjQuvoCux0mlOqBX
 vJxY7KqAOTUahsGF3R8yASnTq2kVuZE7b1SuDudTGYcui8YxHDuqBmvkI0JPdKhw9eyt
 KdX6eM2jNEKsSRAEuJQ9nc/6csXHrAllf77WHFpGS74SkgSoye8OMHv3K+diLWipFtzs
 J9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=06kemhZBYWxkv5vRs3riZ3fnXQfC1fnOjES4AGUZ0io=;
 fh=Nx/8WhhgsodE0SBSV2NMBLjqRsQB08lor9AnDUfMUuI=;
 b=pqjHlKagTY3phLYsbbuKqYAkGaQzGvwwRHkXq7KWoF/47xIKE1Bi3xP20ym8/S3mMw
 vljjgXwlO2Hybw/eLXjrM91xMLlslwUpWB3dIeWEuNKfJLX5Ea0QybVEqZIhwRRJV8eC
 Ccpy/jGUIgFy0zSNRpl08xDj2FeMrIXy1GNlEp4Ig3O5t/w3l10YsD2EwQKI+GJk4lEM
 h68XWUrhqrBv8wbqUUKKUabkbeBcIFH8BjqaqnnhWclZrcXXB8GRWSe8uaV7N0F7XuEe
 eokTPX+1PtXjn26/wbpyvgxOvl4r7NVxM/Q7SKuOExM6vyeCgFne/+0/fP7PvIGLM7/n
 5MvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792673278; x=1793278078;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=06kemhZBYWxkv5vRs3riZ3fnXQfC1fnOjES4AGUZ0io=;
 b=f3lJH57eGSKaQlkVNYMYs5kD7DtF4ul+6oEh9uw0uzONuiW2mC8NpQvyUnlP2c9KOw
 NwhSUH6FAFA5ab7V2XBDlTLuqxTZi2aXI6wzfGPI6L6N40ovzoTXJCJHxXCHkEWQDRvX
 iPfGr18Oy7GsHVnwcBYVrGW3sopJLJw3lJOJMtxGsbUuEQnFbQpNprn4J3KM9J540mwh
 HBKneRibLHNNAuImmpOasKYoMGhFVBDUr9JBXEZ/LDGOvQLLTFGYl+cuYIu+03rp0+Ya
 O0yxThSwnfBab842mtHLPI1sMqQJ5KavTPEqX12XAboeOQCNVgzLn++3dqQv+BSUqXiM
 UyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673278; x=1793278078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=06kemhZBYWxkv5vRs3riZ3fnXQfC1fnOjES4AGUZ0io=;
 b=H+/sFIxAjdA/gKCYFp4BAl7+vXi3dsTxv7b3yK08HXfKxtVzb1Ffec5c1nZ27ibzpC
 u8+FpQTC06VZHEYz76hrlkx0HwYgK6Oyl2cgqZM/xEGMFgUQZGVdNQFMUQ1zP/CKil62
 IFYoy3K8WrrBZJbrhtAVUlaSbK05EexmnG7DJbN4t2L/ycbGuVEinqiUYc0ATkoMFXcu
 ND6kXpukCETDwn/1Xj+obPa24atrmRkCOFMjQ3TqPivXWbZidxTa1CZhvMMIT1cO5erD
 ZdvEl+C6zv1pKxxbU34zO/bJ237gjfNfduhr8fXSPyxCRErSxpt90v7ya4Gm/T0dMSxS
 dWng==
X-Gm-Message-State: AFq9FYIeHM/OJObIj1o6iyG5O4532wAebrQJ3HvFevMPEexGm6j3szeL
 iz3R+/z1xwWzlwkvE1d16d1OHc5OBaF+3WXa22rOYB+8SJ6Mu7xVRw6aaqtmM5opJKG9BgckZRI
 m6BBL6pMatVxHs73Oolpk1ctKZ8JDih7KU4iODwz1IFioXh6YaiubVTnRzSUEFhhMcDYzsJtcmm
 XTt1CGqdBqHt24ubEtVThSSyxWQ8IkrGUrYL+6dxZTO9BJdA==
X-Gm-Gg: AYBFou3Dd7iM1nMcj/3/NyYOGzNW36GToR7G6s90QwyfgB+jdU9qvaQsbdcAC/aCrTE
 ZrR0V7dwqVWfkevmEBycwKbEiNySJ8tQsYnjDoG2cLa6gAVW1GYzGay5T3Ck8NYuvgo31i11n3S
 O7LQ64ooRfBxt28c6LKcWDhMNz6NgOD1xqLs7uOWZa9gw12CcUu1trL64DUQ==
X-Received: by 2002:a05:6820:8ca:b0:6d3:abd1:9b90 with SMTP id
 006d021491bc7-70a817ffd79mr1195051eaf.54.1792673277838; 
 Thu, 22 Oct 2026 05:47:57 -0700 (PDT)
X-Received: by 2002:a05:6820:8ca:b0:6d3:abd1:9b90 with SMTP id
 006d021491bc7-70a817ffd79mr1195042eaf.54.1792673277444; Thu, 22 Oct 2026
 05:47:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-6-robin.clark@oss.qualcomm.com>
 <aa6dda5b-419f-425f-a9b5-198a9bf7eac2@oss.qualcomm.com>
In-Reply-To: <aa6dda5b-419f-425f-a9b5-198a9bf7eac2@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 05:47:45 -0700
X-Gm-Features: AclHuK_bU7poutswK7uYA510NNIdE34sTKZBdGNumfyeiwA09wzxHoW41SK7b2o
Message-ID: <CACSVV02OCkPrTBuGN1n+nCkVOZP4WGacDSNy1GUp9okZqPNkuw@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada05fe cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=arxZg2z8A5urglJSSYUA:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: e_hRbeIBV2ssH2hN_tKlceoymv_tjuaa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfX7uOteB2zS3kg
 d3h7L9iGBQZAxbGu8wXs0ZLFB+jNgUmgXzKtfmAWFS3sTqJqwZ6mf+scsBNPwlyQVIloAX2xdEx
 sDKf6LpVzQkGi5iQA/nSuOLMIgPqk3o/pf8u+4Tb2pw/Wg3QBXhnysIxyGpePneJpkIIj5cxMH6
 pm8WKU9NCuymg7kLOancuojBaogBa+CaKwdZGHsUqlNb4NkLEbg4DExYA3xbswLirn+ebaVaC4u
 iY7uagIkZGU/WX3KfCuf2ckrjHZC3CHgZmNSdXdlBcMr4sK5ax0ztenbcjTxp61qcFYtO8fI3V0
 hp/RogvvQkQ1lazIfm3AJ/j3/SafNN7NZvdds1XJay593NbOABpO+6bBwA7aPPcLPBVijZXnHBV
 0QFew/OpaM4xVb1GtFxZkL+ZtDPLeA==
X-Proofpoint-ORIG-GUID: e_hRbeIBV2ssH2hN_tKlceoymv_tjuaa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfXxTSgTKUTbQpC
 MXBDuJLUsd0K55/vaWDTwNdZhYt3+iEUI3PIa8aDbGH0oMRsTPosmqCk1D1gftLXdhM1gOW80pU
 b7J9Uh8/DW+FZ6um+iKpcXi0mbU/iLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220050
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 12:19=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/21/26 10:41 PM, Rob Clark wrote:
> > We want to save/restore all of the CP_PROTECT regs across IFPC.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
>
> >  drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/dr=
m/msm/adreno/a8xx_catalog.c
> > index 55a805ab438c..45cd986ad4b5 100644
> > --- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> > +++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
> > @@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] =3D {
> >       REG_A8XX_CP_PROTECT_GLOBAL(53),
> >       REG_A8XX_CP_PROTECT_GLOBAL(54),
> >       REG_A8XX_CP_PROTECT_GLOBAL(55),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(56),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(57),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(58),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(59),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(60),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(61),
> > +     REG_A8XX_CP_PROTECT_GLOBAL(62),
> >       REG_A8XX_CP_PROTECT_GLOBAL(63),
>
> Sounds like we should autogen this part of the list?

yes.. but not yet :-)

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
