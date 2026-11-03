Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E8606EE8E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iGxC1mwP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RxfUXSC8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CEA10E804;
	Tue,  3 Nov 2026 13:59:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1357F10E544
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:59:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ8gw3003270
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 13:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=u90xeG6/S0yuMe7vObs+gJMuK1wiVaVYhBCszGbd01w=; b=iG
 xC1mwPptWpdT1D6vcWOrJT7YGbwYWQ16/+X/ZgA8NlyLZrknojkAvk56J5TtjwN4
 R03mflmufRMrN0D9uBf3UWl/2DpOp+fCWgqxTG7hIACsCWJLN+KFalD9KPfFrCUA
 gJY7ayiDA5zzx/hOdwJv3S+nGXuSCR4phizUb6BGgtjJcb+GugZRuzaU/GGei9MQ
 KvCepF4IfDGf1M9qsIBGtz2V+kNsymzqdGwuMdTZ6M4F1fyO1jfjqYQtE7+woGQK
 Hjjs+ovy5jEPVdGGQYFRg8uYc1OGCRyhQAOn9kX5NR9OhUrJuFlBHMi3nXiEJTW7
 6n6vTAKO+h622dolteng==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq2ackex2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:59:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b0d864826cso7534238c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793714347; cv=none;
 d=google.com; s=arc-20260327;
 b=m7JOZ6UIi0bqkysKOgvPxuDlLoC3yzcd3t9ruQ3Zt95acGXDUlFlSKtATlww7HH8+H
 kRSb4NBfFHH2AT7XR0wg9siZtOGCAMwJR0CwmMY+Q26Tx0buAiz7bhB3aZK6Tu7pq1fo
 ImWqgXXet4Hl3IATaA6jzc7eRWEyWOpBx2gEUgxPwTVEMRx6s5QxjpZDBjMz2Jk+Mcuy
 2oI/MUshK2jxeVx8K3aRK+rw566lsL0OL/aHaZIidpguXDddXTLiXdUGhmZ/7FYHwTOl
 pttVFQohEazv6ippxBb/AK02J5DttT2o3+Xid85Vxxtg6JMM2WQFyUcxQVU9EfuK9o+0
 vLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=u90xeG6/S0yuMe7vObs+gJMuK1wiVaVYhBCszGbd01w=;
 fh=0eRrQ+sgYGVgYC2uWmPGdIL0TSyfHbbP8iMZMfDA7Wk=;
 b=opOYQTD5JdVvexAhL1fd7XWn8aRF85VqCE12kadSZceurT7K4J26BC6rH+gn+v4tiU
 iEPSfhh8FrmkHNJq4hFE41x781jEqfH1H4eJ/cL6OYPp8qZCMl18ftw0hd4ewmx+IgFv
 6z4y6ZtO/vl2hN2urrTdXGmfC1SIhlfTBHKd0nrofLUwxGM1PDX+78S1+cHDnWL2sks7
 MCe3Xj2BrPB4/gs7M/D633KhmrhIvPJ5crnXSvPBJNs7uu9OWHNxjhcl2Bhix0wIYtAc
 5KoA+uPHEDSmsJI7/O+N83yiu9F7ktg/shyJ379YhIWc0TItX+dYDVg5KxI+EDpwtZly
 IqeA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793714347; x=1794319147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u90xeG6/S0yuMe7vObs+gJMuK1wiVaVYhBCszGbd01w=;
 b=RxfUXSC8F7zW2xiEujHtWhxZVCcRhOuA32bx9FRmTKPoOBacEwY+9tfn1fNCSU9oix
 2n5pPIUjrPqF1Pvz5/Onyb0PmER8aLWxrxhmqO0K7uBwVR825FvJ573OoTIROfiTQBGf
 wBvJcFy3lC7oD7d0KCdYSkZmdTNOuuHWxlVobnYNDn2aOCew6MN7AtjHE4AavkefpPhP
 wChYvN1MyeSNWx7cf3nYCVwXOYbGBUcjU0B4VfGZKTdxJjvtMlqcgHU/D882va3t+Yal
 +lRe92vWKVMgVCEKJmYA40Udv6/9Tt6nbVAfQQp/OLJ5QeqxwZOmZIxAuZIzOGvpOIRq
 5ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793714347; x=1794319147;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u90xeG6/S0yuMe7vObs+gJMuK1wiVaVYhBCszGbd01w=;
 b=STW3HO/r3Bg/eZmEzvx5oljtpBaul9R2X/aJYo+f2SWH50oHb1auw6j+hw3p5tGtbs
 n2A1wyJvTW1yQ/USLpRYwHdPR2/B500AKyirDiRKoki22JvC4MBlpmomS0YU38UCyQBz
 otu/FEbsjeZAVEhTk1g622l2IkLlPo351UKxuFcIZRz1Rn8NLp5FI09HYU7g4pjHlwl5
 X9Br46SEBfUIeud+kxZe4aDBQ3VWFgn2FVv6pqiT40kfB2gcfa8CrGvEdNNZSyevOqxx
 kOklON8P+DtVtJeYnMzmzv50LkU+bpzF0h3Z7HikGclTMlRUAkcj0r+Iv+2J+ZZ8IsJ/
 ivyQ==
X-Gm-Message-State: APuU4Z+5FlQxWR28FB7JnLIVAzeiwJgF51T83jXhuFFF4dDacwD9HoFC
 l5MW8xhjzvOl3WnPlBCspjcIj6+FP1PNf797K4arJnvqvOHG2O91a3WMPCxB5n+Afbl9EIhIRzX
 2dQ6vqmPKM4FwMiUrlRPq1GJi+KAuofVecDsv64QNwBErcxmjq7hxLLcvDxZ1v1CEcIxwBwgyJY
 fEkhD4ERp9Mv34XeFIaKiWlbzsV56uZydAj4BsTUg0rI8Acw==
X-Gm-Gg: AYBFou1dQg7TFfiPuiYj65zwnp9fjpMQVZJPT8YJK8q1ZvgoTNtm8DuTslWs9hmn1tt
 36YTPSJlgqSMVF9njZOK7qdp+xAwkOqMg0wXG1sab4pRsu0kFKAUYteBnElaZdiEM75gwtRmdKf
 CCZACmQTdoFem4miPOjWyqT1/bhEuqwu1tS2Xbf+GC8Uwt983egovFr8Kn9w==
X-Received: by 2002:a05:701b:260c:b0:1ac:9ecb:acee with SMTP id
 a92af1059eb24-1ac9ecbb353mr16682674c88.39.1793714346767; 
 Tue, 03 Nov 2026 05:59:06 -0800 (PST)
X-Received: by 2002:a05:701b:260c:b0:1ac:9ecb:acee with SMTP id
 a92af1059eb24-1ac9ecbb353mr16682661c88.39.1793714346238; Tue, 03 Nov 2026
 05:59:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
 <a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qualcomm.com>
In-Reply-To: <a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 05:58:54 -0800
X-Gm-Features: AclHuK9kb5ZKwTYoNlq61wHUgD5ZG0TonX0oq6CE970XUEKeSRMrykv6fVdNHLo
Message-ID: <CACSVV02mTpCPZ-JtyYrsTEsRXKyS3zuxTehx=c91NbxgQSdpUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=T4gZ3PKQ c=1 sm=1 tr=0 ts=6ae9e8ab cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=dQossMmbW6WhV1w7_6cA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX3n7noQUjWPRl
 aGGBK4mI9DHZNV/6UN6jKZttSm3v6SNqWSY1GqXthTtdwvgQEPAxK/qCthplxuqm+XYcZ29uUqG
 ukCdUYE+fr6wWQVqx6LTbByqUMPA3umuzi1ITHKcIiWXf7tOO7TH4zjQfAU/Db+fJuxOEBZjEzZ
 bIhgk80SJ13gTLKd43DzVNQTJouEGMfEGqsWReuvSokOqzu48DxcO8COsa//6uRBiVS/a9jiJ72
 zKqFmmSEn8TX1OT5M44kuHnnkjGIPtra2/i3CSTf0spqHUfcmvWYMPWSX2IdFY2Xm4nD14faxu+
 I3fF7n0RDhwuJFCmstXJWgvD9XVm5vNInFFHuMxAO98Y2mSc3hDsm4AA6iTrbar4p64YNx6dk7t
 l8sc05iQpCuq7jMn6k47cQGALSmaifQ++yVqc2s8Gh5VXv+93PZFHY3lAMn1n0qIRu9xX2y5Dm1
 wB0Uomk8MkkQKnBfwsQ==
X-Proofpoint-GUID: 5Lx5avBszj0zt6vPaTA2Os51RlCgXXRj
X-Proofpoint-ORIG-GUID: 5Lx5avBszj0zt6vPaTA2Os51RlCgXXRj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX/1te8roWYTsM
 C3pKtkHLiVYCpH+5PHnDYtgCgxurdUZgsXLhzPd8LFXn5lsr1VpW252Q2uVWvOTvZqrEofMgPNt
 llVn5oGPbf6quuFdiB6UL74SgyMNnKQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030055
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

On Tue, Nov 3, 2026 at 3:28=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/2/26 8:00 PM, Rob Clark wrote:
> > We need to move the gpu lock around a bit for the next patch.  Use
> > scoped_guard/etc so we don't have to make the error path handling more
> > complicated.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
> >  1 file changed, 12 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/ms=
m_debugfs.c
> > index f12701e286ec..aa59b28a3392 100644
> > --- a/drivers/gpu/drm/msm/msm_debugfs.c
> > +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> > @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct=
 file *file)
> >       struct drm_device *dev =3D inode->i_private;
> >       struct msm_drm_private *priv =3D dev->dev_private;
> >       struct msm_gpu *gpu =3D priv->gpu;
> > -     struct msm_gpu_show_priv *show_priv;
> >       int ret;
> >
> >       if (!gpu || !gpu->funcs->gpu_state_get)
> >               return -ENODEV;
> >
> > -     show_priv =3D kmalloc_obj(*show_priv);
> > +     struct msm_gpu_show_priv *show_priv __free(kfree)
> > +             =3D kmalloc_obj(*show_priv);
> >       if (!show_priv)
> >               return -ENOMEM;
> >
> > -     ret =3D mutex_lock_interruptible(&gpu->lock);
> > -     if (ret)
> > -             goto free_priv;
> > -
> > -     pm_runtime_get_sync(&gpu->pdev->dev);
> > -     msm_gpu_hw_init(gpu);
> > -     show_priv->state =3D gpu->funcs->gpu_state_get(gpu);
> > -     pm_runtime_put_sync(&gpu->pdev->dev);
> > -
> > -     mutex_unlock(&gpu->lock);
> > +     scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> > +             scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock)=
 {
> > +                     msm_gpu_hw_init(gpu);
> > +                     show_priv->state =3D gpu->funcs->gpu_state_get(gp=
u);
> > +             }
>
> My clanker tells me we can't grab the PM reference before a mutex,
> as the recovery mechanism depends on the rpm count being appropriate
> to let it drop it (and kill gx this way)

Yeah, but we also can't do it in the other order, or more specifically
disabling ifpc needs to come before gpu lock or it can deadlock with
recovery.. but ifpc disable needs to be after runpm get.

Re-working that ordering was the whole of introducing cleanup.h, to
avoid the error path with mutex_lock_interruptible() after taking
runpm

I guess if you are hammering on debugfs while crashing the gpu, maybe
the first recovery fails, and then a subsequent one eventually
succeeds.

BR,
-R
