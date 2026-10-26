Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C03606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i1HD5ZpP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gWDE/jf0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2E010F16B;
	Mon, 26 Oct 2026 21:41:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB83D10F16B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:41:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIotq04081035
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:41:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=lWzxRcNP0EA974T23MJtm9JINdrJZubezdMnSoVs3yE=; b=i1
 HD5ZpPQh7FmJTdyM4lPzMiwyHeHp+XFvkKgfZ6OBqDRrW8DkvJyAS4W53OUFw5po
 SLQRtdxZe9ceVunbTWAwpCbVCdRZ5+ZEXFDYHi2QBSQcQF3wCuQjUZp+A7VTcFKE
 RkEG4qqasoRLcidRJ1MyQOAfGSmx2hcqdIeWoFKUDMJBnGiCUcgmcftRNBNFn6RT
 F3OGGURu1bbiK8HzRCawmWw7PI8t1lCB6y/iKFw+L+PdibcWCzkdvp7v2aXEvuB9
 rKrQqm6db2tT0yPshIDh+4OR/b/7kf0oNzsv26OtdjZtCLI+Y8nxaaRoQbgRXm99
 Rm1oZWDVarEmf4Ul9R3Q==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2f0j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:41:27 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-49dd26d6f07so3723670fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793050887; cv=none;
 d=google.com; s=arc-20260327;
 b=ENROySW6oRzJ7L5aGKaBu8+ZrpfPtZtdbUX96LKImCDhiAk75rtJlor2WXt3z3Rrx4
 121MJK1FgGRzOylvsaOAcoauyjEQ1aYVKLsF6/RQHYP/UOeM0KR4XiUgqGAem3FTmMu1
 wF0nlWnGbzv0nxxwsOXwQcI0M8l55nsMXPYJNVltCUenCkDviK3CL0JXfVTZxSZPpNXI
 wGfGdVwSpdIfqYJogGlBoGg2su2qeokYUFh28PlyZ7wk3pF8Whe9GtCieaCJnUp83PGa
 fYNm7ZNofgi7Q7fIRa+RkxFnz/qH5CVEl8nZkv4//2/t6H5SiFxgdlYKQ87oNBNAVRiX
 GVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=lWzxRcNP0EA974T23MJtm9JINdrJZubezdMnSoVs3yE=;
 fh=MPc7FUfOU5kkyZmbYpTS9BeU0txM7GPthg4fEcHOLHo=;
 b=eW+P6zfdH0zQhS0/YeELFFGsxNURXwGnclmG7vDIJEuD68F/gb9LevSTu9/oxeS+2o
 exBsAKaxcD/s748ABktodIYwU8nBiJfolI8mPdyGPPg1ZFf7Cxl6NDBKs2bBdmLJdQdF
 1vZJiVyVJmtrcZ9GQLhh2tiIphP+NIfIf4WyCdEAfAUIP3w7mLk7D32MbJr4ia/2aNzk
 /sfCG7b1nSCu0dEMncry/TidddBk9j9OoulYVwmrKsWQo38B61OValQd6KnGsla3ErdA
 j9rX+CzUvYJGMSSaS396kEG175GLxAS+jz6yaWqVGd75/+6kK0VWtruoF6PoKae+fhpJ
 X+2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793050887; x=1793655687;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lWzxRcNP0EA974T23MJtm9JINdrJZubezdMnSoVs3yE=;
 b=gWDE/jf0t2ACn64kqednqXnGZS8d38MyPvIS78DqkJPnLkkxezHczxpHZZmxTzJcD+
 iPjCrXvqbVFxU2mLXK/Xgo/93V071SlZolKjuncM1XtwGHEa0vBgS7jO9iGgo9AWOa6a
 Llh+Ez8fSgO+SAblGukVkXQGrAXIzaJPHklDNQ5UTceezw5Blhj9TkbIjtwnmRhSr6TM
 ZRk4b4iBrYoPMxFlvw2mM15yjlKkGmucgcuT987WC/qm/G/700RLLGq6jpUF64XWKgah
 Lm95TFY/Bcb5HkNY3pocxa0FcRpZH7FtoQ7iO5SbjodnOD1xiH1+9WiGzagmbN8HA9DN
 gEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050887; x=1793655687;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lWzxRcNP0EA974T23MJtm9JINdrJZubezdMnSoVs3yE=;
 b=YYnQ/0L/RHmircbDnjJSpmjK+O1cm02QkoAN8UZO4sCfPR6EFarL0MX5HkuS9K3R6A
 BDG6Wpk4GGtqnY4BfZloziWezvdu+G81NeCXam5rE21DbYPTU8DlLVVdeKlVklX8zR3V
 L0pyR6YxycK+saisaUoQFPXwFzupQ/vGiwHVsIqI6HHHU6/4QQ+v9RgYxNVD+34XIJyK
 Ef9erI6CBvL1BbUXhukcgiqfWFJT1rW7ekr44pm6opZgd7DHSztaKvUYEnsP3QDGoZYi
 w0uMi4OjgKcaWzRGGTBka21I76xi1x03gxc/Uptm/+STffjktoThCI27bfm8Gg4AS5zH
 qHbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFZL5iat16RzIXXyJtyVVRXcALJzDy1HkS5adbNvVvmV2YSE1jTMRrYSlmqmgyQZ21d+7pjgB+HPM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIYCjfqNKNXP61p/zKBEtPlN38NyaKyl7Hgjmmj8W/edDABOAo5
 mDTZgZsENNue26Qf894MqAwHYLn5aKZCBm0A6n8ll66K4T8Rmv9utPQ0wOMXMO5G4CG3OPlVmIL
 LuVZIRuqpDY4jhNg3ndEWZBNS3em/1wLJfLgehhjdIO62lAzsrFD2rdZRFtfzzBQv1qvG4J5nLo
 biwMPlmjwfh+TyKI6S5O5OyEpssAityMp9yofjqrTzcqHL9g==
X-Gm-Gg: AYBFou3QxVurdHA19Wq17NKAkNkl/7A8ExytHaFd10utxn7DrjGgw91vIF5qCWMvNtT
 6k3T3v8o/ZVsyoLHYpMI2f22Z4N2kv4IHAIFXZIQ5DoHCvZmF/W6m8u2pIinHiDH4Z/ggh3cA1h
 eex2RHhMV8mvRBIi/qMuBBXbwr2LyfQxK7d/G5Y15BJdK7Bzacdpu5200gRQ==
X-Received: by 2002:a05:6870:a2c9:b0:491:8695:3323 with SMTP id
 586e51a60fabf-4a83f5338fdmr4761491fac.24.1793050887089; 
 Mon, 26 Oct 2026 14:41:27 -0700 (PDT)
X-Received: by 2002:a05:6870:a2c9:b0:491:8695:3323 with SMTP id
 586e51a60fabf-4a83f5338fdmr4761476fac.24.1793050886681; Mon, 26 Oct 2026
 14:41:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <9671164f87138a0caf5c69b66129bbd6faf932f8.1793044688.git.bvanassche@acm.org>
In-Reply-To: <9671164f87138a0caf5c69b66129bbd6faf932f8.1793044688.git.bvanassche@acm.org>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:41:15 -0700
X-Gm-Features: AclHuK_7zT2IvHbHTNDkSXUCFvxh-cTVSQ0IQQuP8eK-pbBj0w4a_pzyD7ZWFRw
Message-ID: <CACSVV03Vjjd7AV3WrrpxbDgHAjWAUrru8GnJQK7HLwSSzQ=XAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix a lock leak in
 msm_ioctl_gem_info_set_metadata()
To: Bart Van Assche <bvanassche@acm.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yuan Chen <chenyuan@kylinos.cn>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfXxPrHdzdBO84L
 mC8kmfVGgx/vXAXBs0akABV2toe+iKOTPIcmI6jv/YtrlQDtyo/D9Mvh875xF5T7EfNnOjLOh0D
 flSobJTaU9u1kvUgu35PezXFCqnr8zw=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfc907 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=N54-gffFAAAA:8
 a=058b4stj7-OAlbUbkHcA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfXwBLKZQi3r8Zq
 JQAoEtp4e8JgX9d4OtYUOZa1Q5ZT4t6gEB4Wj8O0WrgbWSI6oW+ZgProMlxiXNfBQ9PADqaS7w8
 82oE8JX09PlmkFqd+caB3Xe9HkGzqVsCXA6ZltKWF9pn1nOTxEAlST0habLlIQzPJkVjwq+TLeQ
 H5O2ajfpVfbl3Vg4842XS5TMLrrjNaWjJZy6olRYkTG39awY9jBDxdXNK//yu9O7iX6jmafRcab
 LBjqvRPIjkfqpYZjiZqWHdnoSmBWFxC9OyWpg3/XnHHQVKKbZe/5mMfC1ucAcV/jcUMVr2/At47
 Y1khxTTDG7fmdOebb6cjtuCqvoz4lnMcSZcal9Tkfr4dLrRQy8Z2o7Qfp98kaOVVkpgahUBy5V7
 g6lBHPvEI51P5yPoFpO86mksRViC6+RqYin6tgXmc+E78zd/2F7VeIk4Wwx1aS1o0td/Qz/lOiC
 3hCKGqkpm5IWHf1kjCQ==
X-Proofpoint-GUID: 4FDAw1zoU8VOkZ63gCPosDnVWD8qkFxD
X-Proofpoint-ORIG-GUID: 4FDAw1zoU8VOkZ63gCPosDnVWD8qkFxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260086
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

On Mon, Oct 26, 2026 at 12:58=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> If krealloc() fails, msm_ioctl_gem_info_set_metadata() returns without
> unlocking the GEM object. Fix this by jumping to a new label that
> unlocks the GEM object before the buffer is freed. This bug has been
> detected by the Clang thread-safety analyzer.
>
> Fixes: 1c8c354098ea ("drm/msm: Add error handling for krealloc in metadat=
a setup")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

You nerd-sniped me into:
https://lore.kernel.org/all/20261026213701.22126-1-robin.clark@oss.qualcomm=
.com/

(but I'll take your patch for -fixes and rebase mine on top)

BR,
-R

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.=
c
> index 5e8f3ce26b32..7ab808322be6 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -571,13 +571,14 @@ static int msm_ioctl_gem_info_set_metadata(struct d=
rm_gem_object *obj,
>                 krealloc(msm_obj->metadata, metadata_size, GFP_KERNEL);
>         if (!new_metadata) {
>                 ret =3D -ENOMEM;
> -               goto out;
> +               goto unlock;
>         }
>
>         msm_obj->metadata =3D new_metadata;
>         msm_obj->metadata_size =3D metadata_size;
>         memcpy(msm_obj->metadata, buf, metadata_size);
>
> +unlock:
>         msm_gem_unlock(obj);
>
>  out:
