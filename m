Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594AA109C029
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6C310E7BA;
	Wed, 25 Mar 2026 15:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyWLm4OJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+5uWJs1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C67710E7BA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 15:17:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFH0vR1554493
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 15:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=qIVcfQ0TGWgvjXq0OCDlbAoWHyoRDZrDfX+tWrwMbdU=; b=Qy
 WLm4OJjQ1bx33Pw41uggMemnb31xqDbzCUjX/sQobnZY6pLGl2vUDo+tc1VFW11j
 eiYjDik0JEpn9nJ+FAHpPPhu/AdxwfBOZse7RkdnarhiR4dMj+8KZFzI8qHLSKLc
 BNcCi4j5erjLjmKM5IA5H4kqK5d5tyyAVDjtV9ljkPwOyxB5dM++VaEXlNidCu4g
 Llp7fks546U+SGFJ3W/Xy1PooKk1siYz5PmqcurX+9avCKEvtjMycYLcJw0qYTnI
 rUpCBKg4DFg42VnuKxkcMWKvinnQQYET9HGhrpkegHelvsD73+lFgAaUBRHTrSn8
 Q5iF9Vsk995UIhDVXTjA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4gj78efp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 15:17:39 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d7f23bd25bso5671580a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451859; cv=none;
 d=google.com; s=arc-20240605;
 b=UEtUT2BwD6GZSQgDWKsiwUCZIi0c3OdWm8tXNxYM/teLsbj2cfjjil+3fIxX7vGWdW
 JATkQ2KkoBB6PzpWUcBTD40K0uiRdPRtuCPQLEo/bu6hOaE9Kg2FOebDMI2c6Vg5GYsc
 xbfElIFreg8kwrxO41wvmDEdJ3dRflLlNsFVdQwLSmlohXTFkMSOWZSgZ+uoxj0yOI0x
 7NUEPQMw2TOCcehTICzC1TZzrxbzX52a6iD6fLeMzRjwpF9Fa9hOQEorkMNkjnKWxk0m
 by4xI9/OpfSUG2FOHX2+GW0e9DEZZ0dzsrGBmWF5Ctz8l/xycp0baWs2R5/sH0h9cXax
 kyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qIVcfQ0TGWgvjXq0OCDlbAoWHyoRDZrDfX+tWrwMbdU=;
 fh=ZD+n65FybRu4utSB3YFSNMtpc0pF8tP/4b/VE+BYTXI=;
 b=I3/D5c9p0Lb4QdpQZ063fVKb/pPlgec2Ue37q3UyTBwq5yF/wuApmpXXnQbY6yRR8b
 cGcD8wIyR30SFaTM8aAetCgkfHDAYL0Uqn7c1OMNBZqV4AzumvFS3RsqodJZA/fsp/15
 z/GN93wuQn1zeew2s0cS5LXM92l/HivQc0hcPxNgqseRHsegDbLclwpurB/QT/o1bFmt
 g80QKOhzKW5qlk7PRWZZKYSmHH+8o+asffkwY9QZRtSxhNwfp2/XfcgWNh1ZLx0J/3gb
 8UZzP+0E/l9CrzmDj0EUzibb1b+YCtnhOASzlg7+1Vq4SfP4eWiRYq7lfWJIP7kBlGBZ
 8scA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774451859; x=1775056659;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qIVcfQ0TGWgvjXq0OCDlbAoWHyoRDZrDfX+tWrwMbdU=;
 b=f+5uWJs1hVpTCJHhj9V1x84cp6QwLmqFJfAPwRu8a5YQjRXpCuDSR+enuJnQeb9ktU
 mtwsuBJk6zhd1XkTRGjzoVd4A0baWPhsvWu0nDijseSVGTYwyYsxH1SUJ+0H8WYxo5ay
 vckQ2XZhzF2cN5ESxMDdtxoF+ppnz5EnFlOvAgaQpri+3iXhZlIuv4052/nG+8OTT/iq
 +kUMpNxiQ2bjWA4Zm89MiYi3GMdomcrgOQkExpudnMcTxytxmHKXiU7wIzfu2Ei1kYYe
 jylhWfC3JsgueNiCd2TMJ5l/HdycLXBxhCo2UPiy6OH6riYv080a32Jcn5vWRdMCtZpO
 V4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451859; x=1775056659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qIVcfQ0TGWgvjXq0OCDlbAoWHyoRDZrDfX+tWrwMbdU=;
 b=QVN2OEP9oPu1rMZazwE94POThChCOCJSqhonBWi2I3+GrRJKn5BUR9cTYm6aQv7Kaa
 z91c9nGHr82MHW4VmU9C7IrHONgK2zPhouO2KHZtsxpv0qSLEeirxUuRKkxp+nq4/4fB
 7Sa5LtUn9dHXEm8TPXyAlKF1Sl/LS5ddM/GR6fdvZU7Ph23krM69GwzacLKfzuSe1Jkz
 uWyGpVSyVcTWmrwm+ih4wA/tlYRi8Y17G2TuCfyC+PMUY2f4LE6hR+558SS9ahNQ1Opf
 WVhOwrdcp+t5yjcZgfGV00ErOoUKDWFIXpJyn6bQAXXGuT2/gnj3dc0cLYtuBy+Y5XeX
 qhRQ==
X-Gm-Message-State: AOJu0Yz5erxSAB54N4Wr8oIQs6NsdpcurIQq7TKJ/HEo6tKy0R2uLynF
 j6ZJy/7xp7w2CgvToYs3oT8vwn34zFrpebGqOgaZreWDbeia62HM3CelQUpoKFo27P9qTPQCMNd
 3gKkT23B4kNX7UrzUn5kX2RfVSPtif/HlsL5B4/MSaty3GbqbSatzvjf+Eyq5RInqISstV+X3c8
 Eacsvy6tzYkIiwC5ea9QfzvdZgHGldNVZsxrZXIM9zlkbdHA==
X-Gm-Gg: ATEYQzw+Cr5LtI+vWKUwQvaaGefu06invZn+DR+qaMSl960AW6J51HLPFIvmMz3WOLb
 TtKg173wQaD2Hqa1vBWNVqu1ODprqMB6HhouLxWRm3aVSczg5h6aKW1JY1VpBuzD4cw71+7tLf2
 J1mC9hBGCTewZjhIzet7Go9PA36DgQ30tnFBZwuU9IUBEqPC1euijkDGPBZQ6bL9EiLYZpIVJ9z
 uD4mKyTsbNVA43tRKpUCd6zoiKdM7ATscR+nA==
X-Received: by 2002:a05:6830:668c:b0:7d7:ddb9:670c with SMTP id
 46e09a7af769-7d9d4f5f0e5mr2258470a34.9.1774451859080; 
 Wed, 25 Mar 2026 08:17:39 -0700 (PDT)
X-Received: by 2002:a05:6830:668c:b0:7d7:ddb9:670c with SMTP id
 46e09a7af769-7d9d4f5f0e5mr2258442a34.9.1774451858552; Wed, 25 Mar 2026
 08:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
 <u45hgj7ypgf4jzbqxlaxihskk7gmfy675ez7lcxnkm4mg2sxiu@skqnmucupa5m>
In-Reply-To: <u45hgj7ypgf4jzbqxlaxihskk7gmfy675ez7lcxnkm4mg2sxiu@skqnmucupa5m>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 08:17:27 -0700
X-Gm-Features: AaiRm511hktueHPP5wRku9HWF-2ua0STDOZ1QHKDvPthw61tGoVf0ZqaxMAmJxQ
Message-ID: <CACSVV02g3=4BqNEVx6aviR_zhe6frz8JHEvW7SgF3bbdwFkQwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm: Disallow foreign mapping of _NO_SHARE
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=M9hA6iws c=1 sm=1 tr=0 ts=69c3fc93 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=bNE71Ysd2Sgnr7TPTuYA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExMCBTYWx0ZWRfX8DEN+NPKEjtL
 /OuvkDtV/8Ik7xeNCdPoSPMyXOonj565S3tnuhNiGmBDHUVN52NdKz+3p/fHF/ales1d0GVU6We
 PJwPpy+jgHp0kWbq+3S6U9PjUZSWgcw18vuFLMewoa4jbegU9Tcjo62Y+aMvijX9KeINvsbKWk7
 L+lYtw3schZq1HTLbri/wBll4UUGUrexpNDuUADL8iLaYrEo1BS8xTUurbrQieF7G/JHtCSfcDZ
 s7/jF07YizoQYDvFhiB6gcOFyEca4iM3H/AtBWnXf6gou34IHJLXMsPfJ8eMqLdV+qHXtkYmcmN
 /XcUDnX73U0pHGlpzQrzuRsra4Y/ZdQqkObUsuuw5fM268TVe/2wXrv8B8qoW382SiCk2X3yyZg
 zdE3m8dhsj4doigLz5PZSOwzIEmTKg65Bi5Nvbnl2LPC4wwkfFEGuHauMtjzDjGWrkFEPpQ7zcG
 lz9XQDOUrqPsgefb3aA==
X-Proofpoint-GUID: FOrQd1C_psT4N9hnx1mX8s1pQ1embsYx
X-Proofpoint-ORIG-GUID: FOrQd1C_psT4N9hnx1mX8s1pQ1embsYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250110
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

On Tue, Mar 24, 2026 at 3:20=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Mar 24, 2026 at 03:05:17PM -0700, Rob Clark wrote:
> > This restriction applies to mapping of _NO_SHARE objs in the kms vm as
> > well as importing/exporting BOs.  Since the DPU has it's own VM, scanou=
t
> > counts as "exporting" a BO from outside of it's host VM.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> > v2: Fix issue with MAP_NULL
> >
> >  drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/ms=
m_gem_vma.c
> > index 1c6b0920c0d8..43d61e0919bd 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> > @@ -373,6 +373,12 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct dr=
m_gem_object *obj,
> >       struct msm_gem_vma *vma;
> >       int ret;
> >
> > +     /* _NO_SHARE objs cannot be mapped outside of their "host" vm: */
> > +     if (obj && (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE) &&
> > +         GEM_WARN_ON(obj->resv !=3D drm_gpuvm_resv(gpuvm))) {
>
> Can this be used to spam the logs?

yeah, perhaps it should use UERR() instead

>
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       drm_gpuvm_resv_assert_held(&vm->base);
> >
> >       vma =3D kzalloc(sizeof(*vma), GFP_KERNEL);
> > --
> > 2.53.0
> >
>
> --
> With best wishes
> Dmitry
