Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A88CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3719A10E604;
	Wed,  7 Oct 2026 15:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XV9JI6F1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJjMD/qY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145DD10E5C9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:14:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtPEb1137234
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 15:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=szkFWt0ZfzsHXj2rUuLdhVzoMSBDNtRMahlxWQcs2Rk=; b=XV
 9JI6F1aO7kD2JUhvL3KHAXP4DYBoiUBuHa/z27oUbz547pz2h7vCMFuZBi/a8aI3
 QkB/k9Of4H/KihDr3p3kDhNxnvVRB3FGfDDdXcy4oGG7m68MoNNjJEkyno2+k8AQ
 E1VGxspJyKAmuYJvn9ULFXWlFfpuT0ILQwL62OIgYSGYGpJxOkMWw3lGYik/M642
 6xFobhZsR+6MZGxvNz5ExyIR22mg0N0cnSVItzD7LlxX/QGPHeS8NfalxpIovXLy
 Z+yr0wpXs4rOQZmB25gS3QGAVJkUo9Vt9b1NHkhmnJS1WNn2w7/EW0CZkBIeNfqy
 obFi5OxyWtOuC3z2tRUQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c71bn3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 15:14:20 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6dd1142710fso5238269eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 08:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791386059; cv=none;
 d=google.com; s=arc-20260327;
 b=pnoo/28Odm17WnT+4wT1EeqBsK6ESJseZ6U3ojcXgVxANFIH/jSzAvjWmMzRIhfL28
 s+01xs6MvGDaYt/rL7SsrvIqUf8iF2GlRSxi6217BhK7gMUIjtEuK3izM394vqCv6c8v
 L1a3gsGoH+HvB9NabvnA7+7YhUZ5EvgGl7qjdFa5GsvdV+8zeiltRs818WZqzGKz4inW
 o0bpKakttQ08AcRIg5n+0ZnPix8/nHdhRLki/jJKBC7vj65x5YQfmQdgxhpUU82qbhjk
 dPsx3MXhDthJyf5HU5hmz3HgcUq/8X9OaKTa/92LV2M9zYr/3g/y4ukcy0SOnXLfqgGM
 9coA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=szkFWt0ZfzsHXj2rUuLdhVzoMSBDNtRMahlxWQcs2Rk=;
 fh=RaYLndGQN/1qDUZX7fleGFMgsk3LtoSKUIc2GWiAOAU=;
 b=QSmKnSWprZfo/AhDjg9ZcwlfMIanCucxTdJOfmTDq1D8I/aLFbCOChlyHbg2wKE9fM
 hQexZ5giN9pS7yD89rQCxuhTYed2B2y3e3pV0HiTWnbNByDvhzjr78DXcQWeP5YPq09y
 hUK/h6/wJJnjiWwKvvKCYu9fjDTbKj9jl/MN8IG/wo+HIEMiIYH9fqoTf6Mpv2+dyMDd
 HXy9jaAXsj8WVsXB35Gf2Bcwp222GZmbMS43Tqy7sFuKGrQz/0By9C5zqVkuOnuXUKs9
 5Zc6UIwWXEE5nGYCpsCCjKX5/vZk3jOhO8s6OI5BihrU3rVdE4Rb/2O9X+CY3oyQY5Q7
 pp7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791386059; x=1791990859;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=szkFWt0ZfzsHXj2rUuLdhVzoMSBDNtRMahlxWQcs2Rk=;
 b=XJjMD/qYHJsp6WgTljGrpDog0Vk9reAiUPL5tQePZtAYXSQ1goIwcUOMlzVR0+0BK2
 LnU6CHraqUMrjj2pO8DdjPPA6sLdv9OCL6vlGx2S/qgJ3d8l+uUmFM+VVCaRo24ZgZc0
 Ql/MRYTRivIZFq0MKv7h0Gc2cAM5a0haXoHaX0bt9uEJTiQxjIHBcotqpgqQguraeoB6
 SI9Ur4x80+8ynpA21R7slMNPO43W4pASxINWYroZ3oVrnjDIubbujTNouasO3ZJ2y8O/
 5LPHhb+r2UtEp3B3aznlFgvPE//pdMkErHCUjKn6F8eSLu1TGWYZCTy1iFl1CJjbPv90
 zPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386059; x=1791990859;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=szkFWt0ZfzsHXj2rUuLdhVzoMSBDNtRMahlxWQcs2Rk=;
 b=gVsb9Gv6h7OWAosYENNfxoGzhY0x80YLaEB7DAzHUzBF5GzKZN6RQ7g3+uIaCnDvA1
 CCefDSbzfLR+gckOzFUIywWUjZ1GYR3emXGNt0UPiqnb/DBP+rDrqcRyQRNfLxG4Vh4d
 jd4pQl1NjmbutcVrDPMp6ZMfwrjfnjDEcL9qaqG6RfXwRTLriHEvjA5NnmgN/C3YVppt
 hu7dy6JdkQiDSIYsXoFPevdWmbiUakLvwpmu9F+Yu5Wx/OFZ246N4alhYfCuxR1Gt0Pv
 2VVNVne0+LJPKsUIhe1qMtMvYvdiCVLGfchsC48oGmbijwdVJvda7Wh7zS1i7DQCfuz3
 KOUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqcMSy9VfPkwj+mILyz4lF1bwuqh9zOZVIDbB6TfLgyzirEDUpWmi3I97wExezzKQEWzX9uNS5RFU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHTibBK15b1EH7H0Uo137sqp8yyV+3a7hJ3z8PCS9m3sRmWBBU
 xUUL9Ehu/AiDZ1aOb3Uwtu+Wfs+gxWt50xe0m0ggaSZSQbYonwQ+vixPIg7I0BRbD1HUtQIXiEm
 3MstqMlGXJOSRupZxbu4xu/Hy9ab7DhAP/iW8uhDwkHVnSHse2CyCAo2G84WXomVGuJvGiCDkTd
 5wMxuCd7vjHncCEEZZkt6jgzNFINn6ATSCk9j9HhNak3SqBg==
X-Gm-Gg: AYBFou070NIIEXz02vffuc3+ucymGpxTaYnj2uEBobs6YtG8bWCXLCqkZh6z9TTufoo
 y4YK4UFr2f/WbUA/d/wz93wl+G6kBYgANf4J3KWm7zaShHb91PgKU9KD7vvqwzLYihgFnKLaQ0f
 mboD4e1QYPO0j8b5sG/C0bQDmczz8LwEGCZwqGnegnBDwKkeXGvIPuwLWo
X-Received: by 2002:a05:6820:1f10:b0:6b7:46fa:1699 with SMTP id
 006d021491bc7-6e7a729155dmr2528863eaf.46.1791386059629; 
 Wed, 07 Oct 2026 08:14:19 -0700 (PDT)
X-Received: by 2002:a05:6820:1f10:b0:6b7:46fa:1699 with SMTP id
 006d021491bc7-6e7a729155dmr2528820eaf.46.1791386059053; Wed, 07 Oct 2026
 08:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
 <20261006131000.81501-5-robin.clark@oss.qualcomm.com>
 <20261006132545.8BFD51F000FF@smtp.kernel.org>
 <20261007052330.39998-1-kmehltretter@gmail.com>
In-Reply-To: <20261007052330.39998-1-kmehltretter@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 08:14:07 -0700
X-Gm-Features: AclHuK8EBLwtBO-Vlh8FHgDrHt105FPpsXtmu7CifdypQkUFfIWf2MiobeJA2n4
Message-ID: <CACSVV01gRju3CkSR093Y0-2qL2ghmi=GZXZW0fBZjxjue_e6qg@mail.gmail.com>
Subject: Re: [RFT 4/5] drm/msm: Convert iommu map/unmap to helpers
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfX+YpGHapjfIq7
 3GLvT9QoZjk4g4dVhoMZExoJczP90a1cJCimSXUfPKpPMn4ZABFh7fIOaDzHoCORFLDVWTN9Xbg
 pno3S/W9Q+T1hXfNZwnwViC1OjbFJ2I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MCBTYWx0ZWRfXxF91/4yjCGrd
 oY3B6DVeNFmgFgHF1Ku0Qn2FqbqXilcrpHCCEjmXB1IhTW6pm+jrkBeJT6VrEeswvDNIVFtslsI
 F3UpqcpLbwJNVjRp60v311Pgwbkof8642C6ODyAKAPEMa6WtguzaEADO3mc7hnRv+94xsBg7iy+
 hZZaMICZWrY5yI4GJJdDghp+JzcvwYS9KOia+p8k/k2RsfCmo0uz7K1W9BAb6hkUVYO3HGLLCz/
 zlddcGVLM5zMBKz52yJRiHNidT4Sd7MY1dMdwkorZuQIRKJg8JfrBTnhdDA694QLz+xJid58eh/
 jRwVOqnZ6uEI+HCNgn3lNcms7lPPkwxZ8u28d9F02fhasU7hKa+s7aGCjW6h0eb+LIL2BP964Nb
 AOSd/dAnIheCjUNlUMJjVkxpqiLsvVUDoBYIFRFfwS+QAZTYN5itcib28TbCHEx/+eiYaQA2URu
 PYK37GxrfM6iz5T/JAw==
X-Proofpoint-GUID: rjhr5KBRzu_NC3P6rXf7dHjrgFs3Z2KI
X-Proofpoint-ORIG-GUID: rjhr5KBRzu_NC3P6rXf7dHjrgFs3Z2KI
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac661cc cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=2Fj81AndoEX41f5wj6YA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070060
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

On Tue, Oct 6, 2026 at 10:23=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> > By passing NULL for iotlb_gather, does this bypass the IOMMU driver's T=
LB
> > gathering and flushing mechanism?
>
> Yes. On arm64 QEMU/SMMUv3, unmap_pages(..., NULL) returned 4096 after
> device DMA populated the IOTLB, but the next DMA still reached the old
> page. It faulted after an explicit IOTLB flush.
>
> Using iommu_unmap() invalidated the translation:
>
>         return iommu_unmap(domain, iova, pgsize * pgcount);
>
> > It appears this replaces iommu_map_sgtable() with a call to __do_map(),
> > but there is no declaration or definition of __do_map() available.
> >
> > [...]
> >
> > Similar to the mapping path, is __do_unmap() actually defined?
>
> Patch 3 defines both helpers. msm_iommu.o builds with all five patches.

Sashiko is kinda funny sometimes :-)

BR,
-R
