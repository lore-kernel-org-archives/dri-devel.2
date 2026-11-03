Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA650606C829
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TUE/mQJ5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JHvg+oS7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A32E10F651;
	Tue,  3 Nov 2026 14:58:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2269810F635
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:58:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3E9maG4049129
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 14:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=bpod83vmD8+b5six8nkD+H3MifQwihy9OfP3u2dB1nY=; b=TU
 E/mQJ57EWkOciSfHqXbEljCXj4YQ+LeMzgJqnoGcvwiAjXinu/xJq81JNwv21b4I
 yu4Nz7YPi+aWs4zdITnRGhOrcV1L+3xxjLWleEKn3/QXCySfHcHjSyaGQSYJxia2
 /RyO5eO/wtFWE0BJOv/XL3juMHs4k6rROjNji6ved77sl8Vj8fUWGOMglXL+V8VD
 E+kFHq5rWwAGHhsWlPFVdz43RRWxElf5jrWz0lIk0PfoP7h2/0je32nj5E73mXrz
 RS72qMkRUOgsYSxFkN6M3SzMjqe/Cf9qrCPrCSbhxLbQNH1dHL4SNf1SaZa0zGFZ
 uzOFsWvZ2L2DHW0nFpxQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy3e1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 14:58:14 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4ab8b4887d4so3784227b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717894; cv=none;
 d=google.com; s=arc-20260327;
 b=eEpfvwdmsUi9nDAOAPZSDbQ4yFc7STnst0+Fe/PbLIk61ne4PsfO2Y5ljOpX8Lj48N
 xSIuYb2G+p//GnAIVYL52sufvdi7OGKWmpJAR1hYz/TNraJ8pp0e8Q5uYhtEfa87I14s
 3gWTf98GahPiQNh2Qp+BgWDcUrirq5S+RS0sNu/OcCHztOjJJ+Iek6W+h6l6hk7Mmi69
 keC2yVrtGKmh96GkmdIWluTe8ZLtkLhXU3xaicWt/MRp5B6IOQRQ92RN+mRuscCehr+t
 BRauO0u1jEGXo9I03gQ6vexfZCV+CBBstQ55RCy5TLWdlcz/7tpp3M+OL5iS1Cczo1b8
 Xo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=bpod83vmD8+b5six8nkD+H3MifQwihy9OfP3u2dB1nY=;
 fh=AqfWMJnOAH7Xd1qKaE1EXPHH7qQxCmXrULTPVaDwVqQ=;
 b=Y/edsMKN6pA4UD4iXhqBrLhEFLIx4JMpQdCKy3Zjd6V7XTSW9uFEVOHjbPGUB/u8ls
 iY2S7D6P6cvkLCIc6i9JlUM0zF97kSm52LZMK+bWPcTzgTkJynSyCQojNLm6hGbBpKFj
 0/rjfHQ8riYGaJLgZRlnc9pEqF8mfGmS6VzkzmK3MwbJRigQVy6+XPG7QUeiCridEGva
 gFxPoOx8UQK2E1lQ+9r/tTuIFbcez5Jp6LnmFMVfLKMOJ7uJkLOake7OTLWNHblnSFeJ
 fF0ALSuUj56hC5bA3qQg574qRH99S8I9EOvkSOPM5xCuEz+JkZ8JP5QIWGVcDALuUrvo
 9/TA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793717893; x=1794322693;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bpod83vmD8+b5six8nkD+H3MifQwihy9OfP3u2dB1nY=;
 b=JHvg+oS7aySaVHklY7fCtC8XzvnSwNu+1Y2MssDnPsGnSslkUjkHDz8cqRi8p49yDG
 wHIR+yXEeqyuLMthr1EUb2wZSt5eFZLMc/R5lai/CYhh/bRE/AYZeB45ia2fmxeYJhzp
 uX3VpQZ7DBCdS28dNoIaJVMj08apm31lkzYSYXhUnpglp9SEsm1V1bLjgEcEWsMIfKg7
 WXEPerEzX1b76kemaCJwQgno40VFn0Pd+9IkiGRyFgN5rw+ilqUdIXkj6zwbu2tbHVKD
 deVNPYpd+EloUtbAcFiA8EtWIjLS10FxXfufUpIvjbgiKpTE9c/CNesB+wV8x3iuMYhA
 fgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717893; x=1794322693;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bpod83vmD8+b5six8nkD+H3MifQwihy9OfP3u2dB1nY=;
 b=SNxRb+k3BNfKG3CgDQueiaSOzTpCSKJflugAPbezeOPbq8mzRrDZ4ygwRhTs615X8t
 i8aYHRVz1cDKPN4981O9Xd1F08PYmG6Z4IDhPTOq9j50lPE3zTHzaxq1KZqw05Fx3BtA
 k0j5EiXe0ijbi1RSqqUDGM+1vup8AAKL/GF3fDHryFMy+5h7Nu9ZV0l+hq12+P9wAL5h
 aqX5IHGq8ObO4Td4dOf7Cl/3KiZaETEk9smIRIJdIcIkDIv7aSI3nHVvzaOw5mSQAgVq
 6wnj1dNEeXMVUPUjVM2P75avPDjDB21GAw+TIiDgQVCm3/JSE1wcIYIbaDJUe67pve6c
 nrbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyxjq9mvcaB6Ga4/ykU6fdsdyiYf0g3pwB0BObQ89lxdSp/yZHT90JF1H+/GIitiY17bTUGplqLYM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z97iC9VvC0lQHOch1dDgJ6a++vB7iu74sj5g1+O8oxN9TPEw0BA
 DxDzHG2hVmXDfanY0RwaY/nns92Gc7yJ5EnQ455C2tQ0I9U26NLZIm61+ZbsX2urlJ1GyFSASD1
 yuP3xO8i3ravwJ1xRVJJQcgGr/2ACnZkvj1HNbookhQjXqrX3l+QUQRAWtmIFGvfeNxwlDDMZMA
 4/dntfB/05KDe+/zscljRSmB3kGFGqB0TJB+r1kLknwFnK8g==
X-Gm-Gg: AYBFou267j4sgEhhqu1L07JH8wouOxykgqz8IAyrZPv7FkleS7BidOz8iRx+TzPku+q
 XAw2nmpVeX+XnpTTVxemFwkdaFzNDpjOZhB5Z2QXoqKdZoPFxRgfLaIYAGaSU+RtrdzStARNOZS
 bgyQvCZlhZRDEJlwAS45GP8DBoee+F9xODEhZGOovfZRAPkq+9ll1cZG0M58FHk9Top+ZZZuEO2
 igei5qEEQ7bS0clk4b0Bw==
X-Received: by 2002:a05:6808:2207:b0:563:c491:8b5f with SMTP id
 5614622812f47-5640de2851dmr8710156b6e.47.1793717893537; 
 Tue, 03 Nov 2026 06:58:13 -0800 (PST)
X-Received: by 2002:a05:6808:2207:b0:563:c491:8b5f with SMTP id
 5614622812f47-5640de2851dmr8710134b6e.47.1793717893084; Tue, 03 Nov 2026
 06:58:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
 <a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qualcomm.com>
 <CACSVV02mTpCPZ-JtyYrsTEsRXKyS3zuxTehx=c91NbxgQSdpUQ@mail.gmail.com>
 <d4b18854-0e02-4fce-b168-d4e80035aaa8@gmail.com>
In-Reply-To: <d4b18854-0e02-4fce-b168-d4e80035aaa8@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 06:58:02 -0800
X-Gm-Features: AclHuK8GTgB6Euj6Jgwafzumtco69LVrTffNhbBVo0jvz2_1fame7MYtQsB5bOE
Message-ID: <CACSVV02_vNP4wnSvk7GQF9oueQh_aPer1UdKcVHHjLg_0MYfew@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: BpdWs3vU7qsKjMF1G4aBKPE_XLwBCbRl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OSBTYWx0ZWRfX8X1P3ODalM9/
 oQddLQYuKvwwc9TAEFSELwIL5cranOZuwnYGzDMbaGat33/mUA8ThngNoyYB+ycsUGr8TYA89Ll
 QYwdC4uv0kwGH4u35St6br1vjTVEW9P6KmfBl/XWY/BNG1CJ/YnYoFpmCibe0uFsHCDrHiYEhEo
 1AH3pHd2jIExijzuEJlEcPInqKjGBXWyUmynxMjHLSj8J+C2A7Ij72FrunOpiZfSqc1OHT+9dII
 YUCFlKOqwg19grRAN+MQIyIsAJ43EeL+4sHxP2CRxj7m9ERFP9+WYll+kt0in0F0DFQfhR/TU4v
 +hGFNmyWf/8Jriruu4DlFvx6jWdXRC8ZIXGiFSzhTSC4ocLoBGtXUkJLjfDX3YpEoOMJB335vYL
 /m9xkdQG1QpNW3OeLKYMewI8SRlMr1guT8qp6MJ+gd10TjlOCHvvV4jhiOYzJeryI83dsJGw/yj
 Qq1Am/mYfADyfbIRDaQ==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae9f686 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=bWKnDnX5kYEKHeIC6Q0A:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: BpdWs3vU7qsKjMF1G4aBKPE_XLwBCbRl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OSBTYWx0ZWRfX1/yJL4ZUkJVL
 AOFhYPhO9wACAq1AD/E83s+5b2ISlsQ7dg4j5EhH/jXnl1B+gRX5qVHu4WR9J0pmS/hXseM1J4l
 0vco7MWGo7QyVkiC+j4fXL7pwvtBgKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030059
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

On Tue, Nov 3, 2026 at 6:24=E2=80=AFAM Anna Maniscalco
<anna.maniscalco2000@gmail.com> wrote:
>
> On 11/3/26 2:58 PM, Rob Clark wrote:
> > On Tue, Nov 3, 2026 at 3:28=E2=80=AFAM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >> On 11/2/26 8:00 PM, Rob Clark wrote:
> >>> We need to move the gpu lock around a bit for the next patch.  Use
> >>> scoped_guard/etc so we don't have to make the error path handling mor=
e
> >>> complicated.
> >>>
> >>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> >>> ---
> >>>   drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++----------------=
---
> >>>   1 file changed, 12 insertions(+), 19 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/=
msm_debugfs.c
> >>> index f12701e286ec..aa59b28a3392 100644
> >>> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> >>> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> >>> @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, stru=
ct file *file)
> >>>        struct drm_device *dev =3D inode->i_private;
> >>>        struct msm_drm_private *priv =3D dev->dev_private;
> >>>        struct msm_gpu *gpu =3D priv->gpu;
> >>> -     struct msm_gpu_show_priv *show_priv;
> >>>        int ret;
> >>>
> >>>        if (!gpu || !gpu->funcs->gpu_state_get)
> >>>                return -ENODEV;
> >>>
> >>> -     show_priv =3D kmalloc_obj(*show_priv);
> >>> +     struct msm_gpu_show_priv *show_priv __free(kfree)
> >>> +             =3D kmalloc_obj(*show_priv);
> >>>        if (!show_priv)
> >>>                return -ENOMEM;
> >>>
> >>> -     ret =3D mutex_lock_interruptible(&gpu->lock);
> >>> -     if (ret)
> >>> -             goto free_priv;
> >>> -
> >>> -     pm_runtime_get_sync(&gpu->pdev->dev);
> >>> -     msm_gpu_hw_init(gpu);
> >>> -     show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> >>> -     pm_runtime_put_sync(&gpu->pdev->dev);
> >>> -
> >>> -     mutex_unlock(&gpu->lock);
> >>> +     scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> >>> +             scoped_cond_guard (mutex_intr, return -EINTR, &gpu->loc=
k) {
> >>> +                     msm_gpu_hw_init(gpu);
> >>> +                     show_priv->state =3D gpu->funcs->gpu_state_get(=
gpu);
> >>> +             }
> >> My clanker tells me we can't grab the PM reference before a mutex,
> >> as the recovery mechanism depends on the rpm count being appropriate
> >> to let it drop it (and kill gx this way)
> > Yeah, but we also can't do it in the other order, or more specifically
> > disabling ifpc needs to come before gpu lock or it can deadlock with
> > recovery.. but ifpc disable needs to be after runpm get.
> >
> > Re-working that ordering was the whole of introducing cleanup.h, to
> > avoid the error path with mutex_lock_interruptible() after taking
> > runpm
> >
> > I guess if you are hammering on debugfs while crashing the gpu, maybe
> > the first recovery fails, and then a subsequent one eventually
> > succeeds.
> I guess it leads to a sort of deadlock scenario because the recovery
> path waits
> for power to collapse, though it timeouts after one second.
>
> After that hangcheck will have to trigger again so I guess the delay
> introduced
> would be significant.
>
> I really wish there was some better way of doing recovery that didn't
> rely on
> the counbter having a known value.
>

Yeah, I don't love it either.. but also don't see a better option.  My
best answer is "this is debugfs, it's only best-effort"

BR,
-R
