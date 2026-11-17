Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75770606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9Yt0Xwt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ljn2Mcrc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD33310E415;
	Tue, 17 Nov 2026 23:49:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39F8310E415
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:48:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMfS5V1495429
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=MaHtinZD1wk7Bum6txGTdaRyK+bUzqzEC5csqnjEg9U=; b=l9
 Yt0XwtTEg/JH+OmVRiqxMbLtJPe0XUm/k84+9qGFxBtGd6xCfQEHy629pzUNKkID
 Eo7PS1boWeTJY+wPsWLqO/mvzC5V2nciKCTdNjex+ROcG1yTJveyEN0YoEJW+nLB
 o0A1kvKabeZ1zQBhzozMJLlnH37Js5MGACX0vu/IDXm5NI8LsOXd4YUJTIgVPB/C
 89Onpq3arIrhkXPz+B9ndHoF5Ku/LgUEC06PylpdQrcbeRdIlBxUTn8uwwVTQJVC
 HZFsFPCBn5Z2zc9MW0+Y3rlopV7rTHbbM6noAHkWlyUslQcJpG6vqVoumerUy2Vh
 QVyyl5FuAtFhO5PZvdWw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8g7s4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:48:52 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6f4d828b9eeso330516eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794959332; cv=none;
 d=google.com; s=arc-20260327;
 b=UIVreO35u09lsRnKyNN7oba19MyNoAZg59rklwkr5x3ijfjiEAiCmuqdDinBcV7s53
 uGr+/sd7c+w1ayI9m49c2L0RiUJsw/WeSgTNLw29qF4ccsMMY1hK+mdJ1IzkO/Q8MHd3
 3KenTRpKKAXJzF3exWX5XVDEe5EDt7YCxHwQas6FFcfYdytY5NY2Tkv7xYJbQh+DRZWr
 hJS7VwglfSC3sLvj3YP8wYiaAjyVU/W63OwWFT+qbresswJ+7BCY+hi6YpkTjOSyfOiA
 NBrolAEeYPoj78a3+yd7LwE+WTKkDomFPBz6KZgRee93wba6nQ2HlkI1hV1ux87hX4Qp
 Hv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=MaHtinZD1wk7Bum6txGTdaRyK+bUzqzEC5csqnjEg9U=;
 fh=awUltsmqvSID5BIr+4aru6FIolfeDx9s1EwM3PELF5c=;
 b=P9cl4jjFD5dMjCw8kx9Ats8tR64G0FfdDSdSqiCND60QTbyQdd5vP096pORjaSJceu
 E/ehdhf79O8LkRWabTHdXENgG3JZfnK5xUvoIzECke+B1XICrXtA0UCXJa7b2RsAcesk
 xytertjirKKHxZCLNoPZO70bxIrhF2SVgJvpDNbi3AzvTMyW6ERVwz6+KVR0GxuEO7U1
 R5dfqRSaW2jp1tP6c9hxd50BtlhrfBuDvlkTvF0tVnkKBiFTK0GdUZSfvGeCJgg9UJp7
 UXCvEN0mB1pBnS3HXsQdPPuFKcHhFcvwRh0EH1UPg656piJi3ZDw+eLyhkeQyTHfg7vP
 1vdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794959332; x=1795564132;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MaHtinZD1wk7Bum6txGTdaRyK+bUzqzEC5csqnjEg9U=;
 b=Ljn2McrcNqnx2gkBJmUahQD7aaEeo7MfRvQ16olTrI6unCqR17bHT9vha5I42cFktR
 KtoLOsXxb+8hSayjfohJaQkoWQqGFoQJk5ms/1H/tZy3t0iNXNCZwudTpsq9zwLmrBBR
 MyUVRtVvoQ+6LXvegAjqppzh3wdc6q9FF5TlBhFvJvU6f9AaOLBofyFmALZXHnMdl4vf
 9F1Bysi3NdkbTtFYjmGGaJ2M/LevRCp9+3LXEAHAPbrrYxaFgGvSGjf5SQhFc4ZoYCpP
 w+0A5WUhadm5l+Iobz1b/fY2iO+bKLRBVwBI7/zdBWHN4zoA0Q4/K+py51ybp07rkfan
 /SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794959332; x=1795564132;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MaHtinZD1wk7Bum6txGTdaRyK+bUzqzEC5csqnjEg9U=;
 b=PWrAZ41/1bNt5VhgxG/5JgOMbVepFoXuAPgiTLhq75fkMNxEd4bxycx3uW3uoGbwQW
 ip0Uli59yMfOfWlA2eNP+tFKG9R3vg0mZmuaWi1wI0KRG8AS+gzSxFeY+Sg0l5dJYVQl
 n6Z8AhkzUl9mWqPV9zC8PodctbBuAzUEI/wabZazpaDlub6Jjdlugp6oM3DkyJTwHvYo
 2hSG7nF+9XW2lRtzML86oU2PH08dRDFjkKYO0SAP02jHLMANTsr1TIrtpnpfd+nzc1vA
 jVSAM5UuXUceZoDJiAY2xP62ZQgZ8HQZ/fHZD5dXaVm15nsaOA8k/ji9t+wwHUeAzgpt
 gjMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEnnFPaipamznIFVjnFCTF+90xoNt+SH7LWpRUZWEjYY79B5OxjyXA/BqMk5s7oDiikUmbSEymKhlA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8Tuf/eU8QnNInn4ypaYvYxwW7TQf5P7YEB4Xeh5UubgLFHKgi
 UuW6M751Gc5qaNviUgXow9AtRw340sFMJCB9lsro+J89guUiQ5s8kNHwDR7U4x19ZtT73Romwum
 zdxD2VHXijfSwzW9LVnf8vQpxJAJcGOUaGqmYxzL2HntdK4kTQmjc9X5gga79O8PxmCyya2If91
 cPEqiL9/0Jj1O6caz9U+9BQa8+uiFX75q3w4nmjHDou11m2A==
X-Gm-Gg: AYBFou0nJnyOzLPs2gmkdGbMBj/+lrAaOI8JwQhQvr/fxqqH3UCIHUKA7AMlsHo31hC
 5oq3pbgq3nrABDWbkiHLns0h/7qLdvEZ8N3ucawXjjY6KUcoKRCxEzpOCnel8xwlKS27dAi3H3z
 5To0M8DIYxEDqOj8vhcSMmWGWofD92Uw8adJLlFYQl0TNz4ZTrVXdLjAe4AOLYlz6XSr5v4mZGT
 JYGUEwXGm2VEh8qEOBxGQ==
X-Received: by 2002:a05:6820:7090:20b0:71a:eea9:8173 with SMTP id
 006d021491bc7-71b1877ef1amr514920eaf.85.1794959331845; 
 Tue, 17 Nov 2026 15:48:51 -0800 (PST)
X-Received: by 2002:a05:6820:7090:20b0:71a:eea9:8173 with SMTP id
 006d021491bc7-71b1877ef1amr514912eaf.85.1794959331427; Tue, 17 Nov 2026
 15:48:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
 <20261111-a3xx-fix-me-v1-1-d81f50f1ba1e@oss.qualcomm.com>
 <079897df-fa2c-4ba0-bd45-7b357783b0a8@oss.qualcomm.com>
In-Reply-To: <079897df-fa2c-4ba0-bd45-7b357783b0a8@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 15:48:39 -0800
X-Gm-Features: AclHuK_gQ7TVoqme6UT0Bozf3_qr3rMIt2eYSB4MEtmBZmpM37PScfWEwT5xtvM
Message-ID: <CACSVV00s1MbvVp0NXRXEqPMu6Fh0FTzto7TGSKgfOb9pkp9tmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/msm/a3xx: report CP protected mode faults
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
X-Proofpoint-GUID: TZHRlMEQPlEzWEqKZ6xPXcjW8toQdOwK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5NCBTYWx0ZWRfX+HDAumtf0Bkm
 fWK3YhQpkEN0FsZt29FUQRD0X8t5xb6E9KyXZsN/RGS8qfgnMFTOBRwWWVnQ1MAgjsCq28K86s3
 DDrra8mkxlJQmad8dsMRU/fsObdnI1A=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afce7e4 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=C0sjHUWUpF4vuSjdFmsA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5NCBTYWx0ZWRfXyglBViRbiAnn
 lfNbE2hTL53xkKDjxB8rgE3ncFdYOjLKuJC1lJ5F4JlySzruzyPv0riLr0MfXfXSoSWXhnPJiqR
 cdE/D7KIISm54JHfzzt74qL6SZGBjnpL/BuvT374uIrBzjz5iKQaJ195mtoULIoDx9KX+kwVUvW
 kRU0SKSWK+JA4d4AO33zhWj9QBwani8dP8wBZi6p+aKgZD6Yawxm7cKPW/EECjDJ9vXmzAr15v+
 /35G7GqwlnR2XqUL2YyudgkCv6JLMbJ14zonCtr8H4t1LdJZ8dNQd8OnIgGpXl7FaoOFdwo78ZS
 GFv2//3dVHI19/UkjvKRmDeIbxDqojdx/Dj4Gn0uoTvF9b9J7iP/9SDlZVg3em9nnpBsCdsodDi
 NAD5YLDKoolHEg+kizpMzjcM6RVzZM5cazu0PYKncOLfaH4h/nfOlsuGHYSPU68tBtgF6CGBVZb
 aBb/BSaVTyWSuzwEr9w==
X-Proofpoint-ORIG-GUID: TZHRlMEQPlEzWEqKZ6xPXcjW8toQdOwK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170094
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

On Tue, Nov 17, 2026 at 7:53=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
>
>
> On 11-Nov-26 14:05, Dmitry Baryshkov wrote:
> > a3xx_irq() acks every interrupt without looking at it, so a write to a
> > protected register shows up only as a hangcheck timeout with no hint of
> > which register was hit. Print the faulting address the way a4xx and a5x=
x
> > already do.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a3xx_gpu.c
> > index 160d302e16a3..7e03b7305493 100644
> > --- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> > @@ -419,7 +419,14 @@ static irqreturn_t a3xx_irq(struct msm_gpu *gpu)
> >       status =3D gpu_read(gpu, REG_A3XX_RBBM_INT_0_STATUS);
> >       DBG("%s: %08x", gpu->name, status);
> >
> > -     // TODO
> > +     if (status & A3XX_INT0_CP_REG_PROTECT_FAULT) {
> > +             u32 val =3D gpu_read(gpu, REG_A3XX_CP_PROTECT_STATUS);
> > +
> > +             dev_err_ratelimited(gpu->dev->dev,
> > +                     "CP | protected mode error | %s | addr=3D0x%8.8X =
| status=3D0x%8.8X\n",
> > +                     val & (1 << 24) ? "WRITE" : "READ",
> > +                     (val & 0xFFFFF) >> 2, val);
>
> I would really like BIT/GENMASK here..

Have a look at how it is done here, to keep it all tied back to
register defn xml:

https://patchwork.freedesktop.org/patch/768455/?series=3D178338&rev=3D1

BR,
-R
