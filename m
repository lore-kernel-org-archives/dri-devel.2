Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C46EC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EA010E0E6;
	Mon, 27 Jul 2026 13:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmF5Qnt/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y5gHgRo2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9B010E0E6
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 13:58:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlfIm033185
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 13:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=2/I64L8gyijxS5bc44vT2Qmn8mMzYmRevPaSpuer7AY=; b=nm
 F5Qnt/+sbg12NOJAH11tzzZ4+3r6wCrzT0Ag+8iOBtWfWYAA7gqKio0snDQCsfk+
 aaZZmCdN1XsWGDFn3MdiuoSTQB5XSoWEABjBuIJxLQSjX6ANaelItxzbaI8At96O
 mg/NWJwmzfBU4P27m6yQfM7+FEYIEf5W9hXxszhlS8AnFrZY7ypBvy1kguUdADL+
 AnaNjhNK2zbNWqv1srGHYrPYYzqIOmmlalo0cC+YYvU5yhGwtA+DE9cFm2Sahvri
 DBbBMqpcGMQFdncXxfD29EP+ApoFxtDSBjP3kkQmRW3OzS68WDJvCkeXScT2f+cn
 EOAkA5ov1N1MzWCQopYg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c613ej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 13:58:34 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-456ae656699so3040743fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 06:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160713; cv=none;
 d=google.com; s=arc-20260327;
 b=bOISTM1mvE1uphKCDeIit4ch8LyS/jBzeArMTJqjGGO9aK6sHJdr6Ul7Tq+LM2wQPe
 H8JzcJngKVVrcjC38KyyArgCB6F3yJc63N8K9V8HiG8P6JclEG3Mt2HAWUzoawuJinrQ
 yRy/J70E1iAcsdIuOXi5Wjd9alLexaQ7rZ9xxNXwnjCOHclyw4rHqV1pyOkqeJfsToTJ
 ctv2RYORC+unUIWuMa5WOJwByy2GFQQv03FJmK0oAafyMAA4rR/CUHcFq1Y9RseSFIBn
 FwvB11y8zR6GyvLJbQGuW1ZgCKzQ6cebdXSATdMUfWbBiJmMj8cVJmBgNiG5b6aLuUU1
 3USg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=2/I64L8gyijxS5bc44vT2Qmn8mMzYmRevPaSpuer7AY=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=f+gagQaSt9H2+1KLDuGE3w1INn+X2ufnk786rAsg1An0N+27OoAHDXGOq7cOSN5vUz
 pO/TGrj+E1D1Dqp7IPAjy9x5rN0pkCTKInziPFVmN5jhU4tpOepF0LuX+zcNhxezTblz
 r0uGzL9N41UbRp5s7sqopEmaT8DMKQQ/dNvnhlkaq1hPOGElTUP4rH9E6uhkVM6Wl2Yc
 XvzRbhXZ6UAOtwaqnGYwpQ3K+bL4nAztvT21S8C4WCPL1bnerM+FhR+XyPEeHF1tIxZg
 J8nSDi7E8suurZ1fIaVxwGJAJY6fw4JJoG/NHfB8V4gbueccZuKCJctn/flFhYJGPipM
 HnIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785160713; x=1785765513;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2/I64L8gyijxS5bc44vT2Qmn8mMzYmRevPaSpuer7AY=;
 b=Y5gHgRo2WM8G5ozASrtrhfzKzGXwqucfhf5n+QgDY1WVr6H35+UrRukbnMTytfpvm6
 A+xgyNj9jTs51z/ht+PSzWVczUVxN35XNFJgf4c81hEv0gAagswIMEmVeOnH2rrIjgXs
 RzzRSPHtEaoOGeMPg9IQUAWHHqoqx7hhavJBWow0BxsnfzaLtCWJ75e/nWFamm0eZV5j
 UBVN02708b1pKYZ181gABhk5l3odsAWgnYrq2gHoY/aokJVvONl0WHdMWLanWFTIQQRg
 Sf6ve6yLfFgZoRTCNBJRtSutczvNUn0v3u6P5R++18fKD3jco9JhvPKB287CsODSx1VR
 LJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160713; x=1785765513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/I64L8gyijxS5bc44vT2Qmn8mMzYmRevPaSpuer7AY=;
 b=ZnZoCNnHLzviqPB+veOfSQwHRQiTcJr/8LsAnmUOStlWVZm4f+xc1Ymldj+CC2RVGX
 I0OrmXEw+pchbhlxYLkrcdSiNBTliHSqnsceUKj7HCFkYZKCFMJdbHeQxNmukFppRxo+
 xHq8k5x5anPE61IxfrYuNa2NihnDctaZtLJLpYXzhU09PGENNhN9jeXfVjB10iq+6vYp
 jQlwOQQ8k6o5GnHQvRolkP5LJVusdnA9xPAXtRkZW6Xa5J3/awB7jUT9HbX+HoAgm401
 58B5/eUBqpukd5XDhVaFiKcHzsPrVzegQcSTZ1SmQFaLE1YVLDy9MSBX1y7kuvQAxaku
 HDHQ==
X-Gm-Message-State: AOJu0Ywq9oHbNpXnrOBjb/a+zq1jTkS7XCvNGtD9t64kjwi6bby2iF/x
 ik1I0AnOJ9R4F90BPeriUt3QivB+N8V9ICmVNL27gJ7aj5+zx0aVgXoQPkoz8WtYowQLqWq/SOH
 2nYIGttHViHl2ZbqU5RdO8FgZ4vfFCikfWzm4ratSvnheaBm7/1oT3Qgl9rC2Ove2iHvd/wHTsB
 jHFpi175x7S0BpkCb/rxiyF0TPVkH2XS49OQ5TXVTjiJe2qA==
X-Gm-Gg: AR+sD13rdo4bcZBk76vq4pmcBmJ8hQB7MhT+oB8VrUsrBLwdtFfPcwRaxhEGx52iRpx
 pVeKJv6qk+x9diQrogG7PlB4z7Hg8z0WcM5INoz7lBC8baXcpLHOFQxQJD4IUrZ8F6LVlCCVxXf
 UUC1E2H0tYvcKJEJFUj9oRkqc60vPSSFPeHBv3BH+KAuVXulRnvW35EXyf
X-Received: by 2002:a05:6870:8555:b0:455:d1ed:221b with SMTP id
 586e51a60fabf-457f281f022mr6445980fac.37.1785160713141; 
 Mon, 27 Jul 2026 06:58:33 -0700 (PDT)
X-Received: by 2002:a05:6870:8555:b0:455:d1ed:221b with SMTP id
 586e51a60fabf-457f281f022mr6445968fac.37.1785160712776; Mon, 27 Jul 2026
 06:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260726174215.30010-1-robin.clark@oss.qualcomm.com>
 <20260726175737.407241F000E9@smtp.kernel.org>
In-Reply-To: <20260726175737.407241F000E9@smtp.kernel.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 06:58:21 -0700
X-Gm-Features: AUfX_mzjX5Oe7EwHSY1PGT2PCj3gUKS-CcVwTXWCey8klABS0TwYWJpECrVMSmQ
Message-ID: <CACSVV025Ss2=z1gwnPpn0w7=9AWE=z+9zVpjc_-TwLPWp-5c=g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Preemption timeout should be greater than
 hangcheck
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a67640a cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qWa5M4ji-oYYbHf_jLQA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMyBTYWx0ZWRfX3bmMdiEQWahb
 yEJQNKh6+6IhAgaMRf0vmZQgMZfHAohlxpcNcPpjUbQ2NiFj63FW2C3MAmQ5Ugt44McO4DT9D79
 KVvCXFUpHeyg2vnrza4wjBfNLOP0+fU=
X-Proofpoint-ORIG-GUID: 7OJzPNIErylxG_zi6r4ZMcaB0O-FTb7N
X-Proofpoint-GUID: 7OJzPNIErylxG_zi6r4ZMcaB0O-FTb7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMyBTYWx0ZWRfXxXXYd9yrI1hR
 FekrWoPy6txVFMR5zkwyECWF8ZJoOH/yzyKHtytzi9NtIg7c5KM5hiVSU4zrFhMOLnVL9rXB99q
 JktmqG7QvfJbI1l10p5SYPo73a6E/G0Ivgbb0SAN+frpG1Flbt+12EqZblhdAZJYwfA9QsRs4Er
 XNEfZMrJ73dAzUXQSZLciacT/8vxPwX5ddZhQgGavOEdmJFJhZ6HzKoW8/GHqV7JzX/kDNvBeMa
 EXjLP8ni8vUpdL0EPRK3nuF45HKfyL+O9eWQMAMTYhHN57okaLMU0iLO9X30TgAHExU/d/dinrv
 w/aCg6fTRt8LeI1sRqrWKEFci7qmHW3nnboSPK/nnH4lCzhDSmQuJ+KH12ICpF9kL7TMX1SZstq
 Kj1TJIfqcmZ96hmqwdALb0WubHqt4cSnDxPDmFWoOR7WRDrXPDhAa47+lpLfuJqbvzRz19kPJ3w
 t2vbL3BCTMRl4rl1ygw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270133
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

On Sun, Jul 26, 2026 at 10:57=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The preemption timeout calculation fails to account for the ha=
ngcheck progress multiplier, causing premature job termination for long-run=
ning jobs.
> --
>
> --- Patch [1]: [PATCH] drm/msm: Preemption timeout should be greater than=
 hangcheck ---
> commit 5454ddf4018869efeec2d7c8f2767056ad2612d9
> Author: Rob Clark <robin.clark@oss.qualcomm.com>
>
> drm/msm: Preemption timeout should be greater than hangcheck
>
> This commit changes the preemption timeout from a hard-coded 10 seconds t=
o
> the maximum of 10 seconds and the configured hangcheck period. This is
> intended to prevent the preemption timer from prematurely killing
> long-running jobs that are otherwise compliant with the hangcheck timeout=
.
>
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.h b/drivers/gpu/dr=
m/msm/adreno/a6xx_preempt.h
> > index df36c945b836b..178017aad26e6 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
> > @@ -35,6 +35,14 @@ static inline void set_preempt_state(struct a6xx_gpu=
 *gpu,
> >       smp_mb__after_atomic();
> >  }
> >
> > +static inline void set_preempt_timer(struct a6xx_gpu *gpu)
> > +{
> > +     struct msm_drm_private *priv =3D gpu->base.base.dev->dev_private;
> > +     unsigned t =3D max(10000, priv->hangcheck_period);
>
> [Severity: Medium]
> Will this under-calculate the true hangcheck timeout when progress detect=
ion
> is enabled?
>
> According to msm_ringbuffer.h, when progress detection is enabled, the
> hangcheck timer duration is halved and allows up to
> DRM_MSM_HANGCHECK_PROGRESS_RETRIES extra cycles.
>
> If a user sets a large hangcheck period via debugfs to allow for long
> compute shaders, wouldn't using priv->hangcheck_period directly here resu=
lt
> in a preemption timeout that is shorter than the actual allowed hangcheck
> time, potentially still killing the job prematurely?
>

yes, but the progress detection is based on detecting that the CP
advanced, which won't be the case for long running compute shaders

BR,
-R

> > +
> > +     mod_timer(&gpu->preempt_timer, jiffies + msecs_to_jiffies(t));
> > +}
> > +
> >  /* Write the most recent wptr for the given ring into the hardware */
> >  static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_r=
ingbuffer *ring)
> >  {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726174215.30=
010-1-robin.clark@oss.qualcomm.com?part=3D1
