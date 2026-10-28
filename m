Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC70606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UjV8pOXW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ze17AQyb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6748110E4BD;
	Wed, 28 Oct 2026 01:34:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBD310E4BD
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:34:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S0k8dT3784609
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Xm/wGXx2WzjPp6XsncEgT9WQiDFDT8zDzQqjFMg0UB4=; b=Uj
 V8pOXWAffqIp3CZMAyVWrXgVWRu0450pcGDimX5I66AOeUSNFIHx7xxmuRJXCBmt
 RLx+uNacyaY3hO9woAutTYamvzDszL5AOA74yQ1MpQWDSsamVX+lGSqNpk2X842i
 GDS4xWPGcDVu/Rq63IAd8U25Zdcq7BoscrJrRx+RuWvi+cX2w6SwllxXTXrQ33yq
 3iIyo0yN3CTG/i7+XRlVDUYEDxHb3gG/B/Ty85OJ33+Vh89dI4SNtl4RcIOZP/U+
 EnuV+pAsCVpuie25Q/Qf7DOFhhAmwyCi137KSJqNfN4uPS58zcDkm/UoSmDeqwBH
 Ob/iuIlDMIgBOFZt4fnQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy671xec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:34:25 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-82274137201so729029a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793151264; cv=none;
 d=google.com; s=arc-20260327;
 b=FmUzS0oTh7Kr7onq0XPG4c2Lp/FlAneYpc5haXWld9bUaEZPi4UndNXlDypKkE/BVt
 PMo71faPZ7WWQSiLytJ/FMGw3RVOFNOSXIDDh67nEpjyzvrZthHKHmHRarTtTAARCs7V
 xGiaKsUCAEf/24q+MzP7uY2lyXTzOaXQQIt8JzJOyqPb4pLWbfGwouPP5M+qp/wnQFZ7
 9cGcxLoGhkAsFh2IBAgJO0ZiadGpmjut515fL13Vl4FCvJVTMqQUCVc0hpAqLqQM5FlV
 /R1OCq0TbJZ7jrxs1XfLqHz4tXLOyaSb8muLWDDjXq0aYugCQ/1y9mLhqtlTAReLih3e
 JNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Xm/wGXx2WzjPp6XsncEgT9WQiDFDT8zDzQqjFMg0UB4=;
 fh=x0xPUK6/4PAScPQh+f+li5pUt7ntMAbalD0vMfgEJ2w=;
 b=d2+9bZpeBwKWMrEJLeNf3PhMIh1Rir+mh1csQW6Afxx08ztIfzX4D2oIchetRf51lh
 J9xZN3r8FCqHj6xkRW42m8f0rqzOGI5YZ4sCG7vIkEc4Ot6BM9Zx8AwkSd/dJs6EKQ1j
 f3onz0FkUbw8OirPQKLJ77P7pfHeuDo6jbPtcosFyaQTTc2Ydw84YEHTXQybUigrYMTJ
 vEP2kAyPdSN+YI6F0/mfElS65VLro7TJgOarYjOE2+rLskhTyp4fMp8ioOnrkWy44qqs
 e5XSZDqJPjuHfSFCuXPcOvp62JRV2TrJKBhDwzlxszFoTHe7FSQv4D6RYO1lqM/jXDHY
 hdog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793151264; x=1793756064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xm/wGXx2WzjPp6XsncEgT9WQiDFDT8zDzQqjFMg0UB4=;
 b=Ze17AQybsE5GZihPpqKpdf08gmoVgIkVkDVgdda5EUOponRo4DVPufXdPlng5mua/d
 wDIvDE5AUmS1LkXVFOTIV6a3S/GSWbMBewTJECatyoUuIMqR6EJznc61o06jkYhS2bYu
 MkJaNRzZ/y6QqN4W7zy2uAurhRbwDsWl1iArP+fpQugPzSP2duNVb6TYOp4k+CVGAULc
 epy4RfRUKId29y+ghV/6MyJvmBGq8VZVnaIDBRu/xFiYpTMpviILwohoyaDlcsXgVs0t
 7nApA1bl9ioc5qM+Wxzek9Md/e5d+3F8R7EFYtk6b8HNEmSimqqlSPZuS74sG/NOZIZd
 1PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793151264; x=1793756064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xm/wGXx2WzjPp6XsncEgT9WQiDFDT8zDzQqjFMg0UB4=;
 b=QmtCFNZiIY71mjGj9OXSQ4OSfVkj0vlkXVxoA6B5TXeFeNo0RJpd0XbX0gHyaKT87O
 pvT/me+Twdao+LoNaEvBGRVZ9NbNzdDIjkjgGZp5QddhLEHenUIxXwwtDTGDCMABFYxq
 AS31goIGa+lm/Kgy6w8jEfVu4idFFZAmIESRwbh0yPcDUpIubPtTF81wfHC/xR1khboE
 ypILTutPq5+t/aygFAFuPlwAGs3rQNf72mkH1pXuzGse9AMn828Fjn7QvC6qpQpqvjPt
 +6sjz24xXepmhpz85wgEv0jAioMj0YCydxQr/JQQxtSRzJog5ee3IyzcUmtA4L0h9DNZ
 Li+g==
X-Gm-Message-State: AFq9FYL+Y9o4ZMIAFNvS/ScGMfOf7li2Hq2H0UFDyZHwlFA9Pwxx+ID2
 DOM37xL4UiOarRQaZe8lIFusbTDpDZn9UPgbuhtHev89xR49qyXJt9sBpqlAnX9qL4pT7ewUd7h
 YedqM0i87nGXOqUXfG5dydLM67TCNJzBRKMTefKgLUIph33qR7HS6fhTMzX4X4sx+flYA6p9BwI
 8KI6/BC/qYiW5PCsuFUNuLRm1/agqT4PjGnoFfNgX6OoPexg==
X-Gm-Gg: AYBFou37pEHpeaT6UUBY1DNASIUbf7pID4K7WiTTC1ZtCxgJ3oUu1E8U37qnYtmsF7J
 ae5SYqzhzAYcLPGJRcgXts23ruoq28Ksv2brR8/EHQBCZzTZVIi8UUCPhaIHp5hWUZF7AJru1o6
 y+P7BHgVKPwKh0yKGwk/2v85AVpm5KqQsm2YLIS4sXM9yodq/1TRjc759nXg==
X-Received: by 2002:a05:6820:1693:b0:6d8:9568:840a with SMTP id
 006d021491bc7-713ee188879mr490998eaf.46.1793151264387; 
 Tue, 27 Oct 2026 18:34:24 -0700 (PDT)
X-Received: by 2002:a05:6820:1693:b0:6d8:9568:840a with SMTP id
 006d021491bc7-713ee188879mr490977eaf.46.1793151263851; Tue, 27 Oct 2026
 18:34:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
 <20261027230452.130031-6-robin.clark@oss.qualcomm.com>
 <wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpglvwolx@jhnm65bzecnq>
In-Reply-To: <wxfx4nhwdx6dud4ahy3rfz3btfto4t2zor2pjbotlqpglvwolx@jhnm65bzecnq>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:34:12 -0700
X-Gm-Features: AclHuK81DT8Al8nkBjxOqnV-fm8QFvrgKVznMTWgvFE3fwVLYN4R8IQKMbENEUE
Message-ID: <CACSVV00rXU=UxbDMCiomUKZDZOcGg0viVnnJ68J8fg8rRFXdHg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/msm: Convert map helper to use dma-address
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: rHi8B4-7q1D_9xJB-psGovZsLFhm6oAm
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae15121 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=qffPo4UZxZtRrYcd1KIA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAwNSBTYWx0ZWRfXy/KZ7h8Mb4Bf
 Wy7k0LE7UBRXh0jWDeIbCUjzwbgDzsxTSjOdxxvDo1Zu6iStsID0BPVIMexRJ8IdDp7ZXcQH0ay
 a5pyQNUE7j5C00YE0YK0Ud7aRjmW3SE=
X-Proofpoint-GUID: rHi8B4-7q1D_9xJB-psGovZsLFhm6oAm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAwNSBTYWx0ZWRfX8nW8EjwXw39X
 tj9Qv42bLKVLs3M1P19QB7+9t5ScTst+9QyUCk4xcO5/ndMJJaJcXHQxiASSNERJ41GSY2+4VK+
 vUqeI4A3+61FVUYvGDB/1DemK6ONQOCVBMpYr8shrOfoXvuC2eVGy6b70nqxqkUi45JELXWAAVY
 s8Ntd0cSmjPPobJMnhkJ9h+yU30878SFzHp7ljfjoviv6oGDJozH+N9b+vRh0gVf/kXjTPyy9c9
 9VbxmX9Jss13J5kQKkflsgrUseMrC2gGkMYln9zRmhpSUGhKvHtxizVU07QxZY5B3rfjZ2iJPTe
 VbjneJaSK5o31n+47iXlRmOKk7pKBCfPrELhvhsfHfTO7zCJQ7TIKBmxNgvX6V/73qjD/TPmOLz
 k2BMpgqn9dDPxZeo2bQwpFOwUvjUtdt/C1opZ/yErUVa3ZBZ3l7OpFVnegTZv0r78LJiVHgk5D+
 26b0POcAtL702i9ptLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280005
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

On Tue, Oct 27, 2026 at 6:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Oct 27, 2026 at 04:04:48PM -0700, Rob Clark wrote:
> > Now that we have everything unified in one path, switch over to using
> > dma addresses for setting up the mapping.  This avoids issues with
> > CONFIG_DMABUF_DEBUG stripping the pages from the sgt.
> >
> > Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SF=
A14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=3Dy
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This commit seems to break GPU on db410c (which uses qcom_iommu).
>
> [  104.954564] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  104.954932] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> [  105.958559] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  109.082571] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  109.082670] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> [  110.086572] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  111.098576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for GPU
> to idle!
> [  111.098674] msm_mdp 1a01000.display-controller: [drm:adreno_load_gpu]
> *ERROR* gpu hw init failed: -22
> c[  112.102576] [drm:a3xx_idle] *ERROR* 03000600: timeout waiting for
> GPU to idle!

If that came down to this patch (and not the earlier msm_iommu.c
bits), then I'd look to the hint in the cover letter:

This all depends on being dma_map_direct() for the dma_map_sgtable()
to work.  This should be the case on modern things that use arm-smmu.
It's less clear when it comes to older pre-arm-smmu hw.  It's possible
that this series causes those things to catch fire.  If so, look to
commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to select
direct mapping") for inspiration.


BR,
-R

> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_=
iommu.c
> > index 479e5450a4dc..c2950d32c507 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, str=
uct sg_table *sgt, size_t off
> >       u64 addr =3D iova;
> >       unsigned int i;
> >
> > -     for_each_sgtable_sg (sgt, sg, i) {
> > -             size_t size =3D sg->length;
> > -             phys_addr_t phys =3D sg_phys(sg);
> > +     for_each_sgtable_dma_sg (sgt, sg, i) {
> > +             size_t size =3D sg_dma_len(sg);
> > +             phys_addr_t phys =3D sg_dma_address(sg);
> >
> >               if (!len)
> >                       break;
> > --
> > 2.56.0
> >
>
> --
> With best wishes
> Dmitry
