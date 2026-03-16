Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3C2F506E0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372A210E258;
	Mon, 16 Mar 2026 14:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjB8vNLd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmydZvDw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A62B10E258
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:34:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GBjh891428764
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=qpgGU0OS8HxTocU+awaVOYMZN98rW0ghZnAMh2Ic4BQ=; b=Mj
 B8vNLd2J9092Ip15xuHvtAyfvBeBSeRKgqMFCS0CLbxIG6xRcpOtv0nTUDYM7k2K
 7L9A+8kFzo8V4an0FO9tOw2RfJ0Cq581jhA2r5twlnnLbdK1vlQVxpkbHFNKtJSN
 JmwPGvfq5D2D2jR34d2W8298LwgXm/mo0bdrrB8nR3M0LHuZBSaQHeN42Oq8JdhH
 RCrC5BTdlF0lu8Sa4x7X8bGyJ7OwmURdrGtmUOmwIiJci89UV9zYpXPwMDi/YUt6
 xRlPlzP31Lo/VCgsLhE0zv3QotJyYy5dfapwugtwVaJoxMvFO7/tUzRSeASimVQz
 jkGR17JRxpdAn2Q364zA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxh998mn9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:34:54 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d4c7afa9e0so44905613a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671694; cv=none;
 d=google.com; s=arc-20240605;
 b=W79L3kpeG/gv+ThHcwEETyf3aUOpqJkY2rhR/qnPHV1V4k6bxptkOk6Be/KV+XGxFA
 G8n8Lf9HbWZKsK+q/ydsl3l0re54kz9UecYpDTL0sCx0red1rqaMfIEpLKeSkt1gA3YM
 VRh4xyCPFcIWtL1ixOLlRm7ayxEJ1BjBNlDXNEUBz4k7bnInBVFDQDr8Q4YAhTvXdCxk
 ta7C4n3i9cBJd9aReJNoxhovHtfor7hLRQRbq22F+dTNP2O/a6h+mnkqFfDL4WrOy9Iz
 iI9UG0GXtKXzew6AUDScArm4mBguKCW4xrp4fDyJg3STQqlYsQzcrV9bUq7RvBw+zxHh
 QiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qpgGU0OS8HxTocU+awaVOYMZN98rW0ghZnAMh2Ic4BQ=;
 fh=A5eQq6qb0kIm/sEGbrWG+oOVhpr5vMp73ibH0qjHWY4=;
 b=I0HPdCqdL9J28ArskQCGhL5ZiUBMCaPk7Xs4kyFZTecnf0ufdiWPBkFzoMATlihw3A
 dkrhxL+jtwIFoWNXGTn8ltuYWEcMGC9zprygvoHkH/+nwcSR3m332Edm0IlHf1jS6lHu
 NajQkkOa93FBTqROQaEStq5UA/M611pBBOcgtZ3ulHBPXpUnhpgzKf4d8mDJkz59PPN0
 LiZ00R1ddX77+rgzGxFzlev0jpQxJ5KAnKscQn70ghw2gsh6GUaurF1x2Oii3rOMUHSL
 YVQ22yo0KXjtxXR0A0xFg72NYNJkc+/1xvxPdmB+UxEnqIBf+KpY4x8lOid9p3/80Ocb
 MIDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773671694; x=1774276494;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qpgGU0OS8HxTocU+awaVOYMZN98rW0ghZnAMh2Ic4BQ=;
 b=MmydZvDw3zwF/zUfpecoO9P6rTB/de2nEybf17a/F6cEHyy1LiNvJkL4HmuMad/Hh1
 57YiG1iUIvMSCSJJ5UjPZy3cp5Hir4TQMz4D+40Pzt0x7KhtZSWUNAKIbuda4KqQeHTb
 ieYYezUWWXviJorpYtaD4kH7FxDWs3HiV5sOjvYGUZBHnfEPNjHbf8UrgYH1HyfA5vgs
 zaef+mpJE3rxrHdWTXxq1tUB4t8GDEYRTIHGYkojg4pAI+N+l/J60gB/+CHClzU92fxx
 6U4yEmrLSToKiV1yr8FNaRV3hZGqoPh/d8pnszbzf6YHSuLdbS/sk5DZHokinKuAMyYv
 KnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671694; x=1774276494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qpgGU0OS8HxTocU+awaVOYMZN98rW0ghZnAMh2Ic4BQ=;
 b=BCGlRzPd80T1rPkXSuQPbfrGrCwOgwEl4MVI8aGcYwTuqQ3evXEMaB+NEY2AkpqD6G
 C0OT5uPD/eTtNWTvrLIPVrttgIVJ1Cn4/5VZoNfS+Jc9tA4O0kiI7k6uw/D7RaJitr53
 ScXMDOef4e6m5oTHRUi3L9qzjRZTuHmBf3nbxTsaL8ZVEiuIKrVmxeinLhXVJkskZiic
 WvPePnQfGodAmqc7SkX/oteTwyRDdznfBa94eSAoo5zWBJEaxi3KW5atJJj99AxTZ/cm
 gdqwMD2sk8jWh47XwCvjF+hPphtrkg0CWh6Ys04xjNZwt8eOMzHoasR4qLESJ3sQ786s
 Losw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViCbPkrMtHsqA9ZneZR4JNdNsGkYrxm1fv+PGbApDaswyfoY9v6qikKkP+2l2s4wYUCqjGn0BQMEc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl+WX+M0Ivj+lhbIkbsQC9tGcmepsvUxi7XisWwKrj30rXjlZ8
 83UZ4aJ0XGGCjDJvEZd3vK9G/x64mHsLnPLDADTFVWwfGvpH0fL0U1AuNv7x5CjU08Jx0ReWCVO
 MlUZBtijZAV2QaBs66KksgRP+N3T/GcISOxKT3R1xwk7X+WwN4YWsT5RoTRTjFCTvHGcoym9paV
 ZKO3jbEWH557vyaZemgBlJJeXm6dy+zZGcot+SXoVCKKXcNg==
X-Gm-Gg: ATEYQzyYVDKxL8W8JdULqjavGeT7b2z4EtjKNBQCBzJnMgz1clPsrglumhBqWXWJVU7
 untY5cHDWX6LDnbXB43CqqpdRzyFNlOHXrxqmXHpwN6FOUiGLznBWnB51KC7vYzAxk0cHaIKNli
 9g+CcvMKQBxLkl1JC9x2tL+/b+QKY/nQYAPRcRqfh0pdXOcytB6J6OBFgg/fC23kpL1jWUbngnK
 kiA/uZ9K8+nGSzCHFMe5dBWpiJXDQyvTqq93Q==
X-Received: by 2002:a05:6830:f96:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d782593b16mr9291043a34.21.1773671693886; 
 Mon, 16 Mar 2026 07:34:53 -0700 (PDT)
X-Received: by 2002:a05:6830:f96:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d782593b16mr9291020a34.21.1773671693506; Mon, 16 Mar 2026
 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
 <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
In-Reply-To: <6gxzcgwzvqoaqgynwnturjybanjrk2jmmsa3qh3r7vafyyzj44@dfzkd3vigluu>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 07:34:42 -0700
X-Gm-Features: AaiRm504oEpIuaNMAPdwmyeHEdylJ_ESyNWoS7oE2Ztnzgl2FhmB6Sbe8Jj8mx4
Message-ID: <CACSVV03tAeLuwuHRqnaSkSgtGj=nJ5Gt3bzLJZT9SXXRY7jvfw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RJ++3oi+ c=1 sm=1 tr=0 ts=69b8150e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=OH4h9_dtBadAJ_YzgJkA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfX4LhalyfUF7XN
 Iq9s8qlrWDlv+zhc8vTzocFAzchfu7UHCLgH76jk3Sknv8Hb/XQr9cIqJ8UGSGQmZVBzRNJeyix
 Zt/DOrcD2p3B/dF+0b2Dp0m1ZcroA6DxFaBWiMz2g6zapmAKT3xdOooxymF4QR/a7YmE9OyssAv
 PQGZnNYdh++sca+yJD9yIP7mtDAsV/5u7NyrnLefCOhhel4k0hPGkW7Tqg7EapnshlU1wWVKwNQ
 juiQ4FY9FLXrRT5H8/I3duxK0hdVo5cKVO0oAbPsM9kW7iVi64K+vGNaLSXt+fexHgzJlgcQRGS
 WeJcmn77ginUgtc0H/Y2BngQggCEw+fopPpMbVSVoE66LbHvlwKrzKHphd8PTlauTEIMQtmt1JW
 /CKDNBrTVaR/t7s1CKUiuUKEBADSyIz0+RP/BegzQRoZBqiiXfAriVGlXtmTlKDHLR13ot22KIu
 Wsq1MP+RpZ0hirBIc2Q==
X-Proofpoint-ORIG-GUID: jb6f_DXJgcbLUfvng8eRT9hgFvsho3oc
X-Proofpoint-GUID: jb6f_DXJgcbLUfvng8eRT9hgFvsho3oc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160108
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

On Mon, Mar 16, 2026 at 7:28=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Mar 16, 2026 at 10:22:44AM +0100, Konrad Dybcio wrote:
> > On 3/14/26 5:14 AM, Alexander Koskovich wrote:
> > > Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> > > GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family(=
)
> > > to family >=3D ADRENO_6XX_GEN4.
> > >
> > > This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to rep=
ort
> > > an incorrect GMEM_BASE which results in severe rendering corruption.
> > >
> > > Update check to also include ADRENO_6XX_GEN3 to fix A650.
> > >
> > > Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
> >
> > Hm, that commit also changed the value for A730 - Akhil/Rob, should
> > that be changed back?
>
> I'd say, I'm also surprised about something being broken for A650. Which
> path / stack uses this value?

Anything that samples from GMEM (gl or vk).. which could include
blend_equation_advanced, custom resolve, etc.

It's maybe not common enough to immediately notice something wrong, it
depends on your DE.

BR,
-R

> >
> > Konrad
> >
> > > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > > ---
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/dr=
m/msm/adreno/adreno_gpu.c
> > > index d5fe6f6f0dec..0ac3fba5c277 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct =
msm_context *ctx,
> > >             *value =3D adreno_gpu->info->gmem;
> > >             return 0;
> > >     case MSM_PARAM_GMEM_BASE:
> > > -           if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN4)
> > > +           if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN3)
> > >                     *value =3D 0;
> > >             else
> > >                     *value =3D 0x100000;
> > >
> > > ---
> > > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> > > change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
> > >
> > > Best regards,
>
> --
> With best wishes
> Dmitry
