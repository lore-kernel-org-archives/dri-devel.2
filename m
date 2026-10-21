Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37332606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QF+iY6NP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bJ54oV1h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9531B10E307;
	Wed, 21 Oct 2026 16:05:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B440610FECB
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:05:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU3Y5992026
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=BGhrLTjEVfeSljGkSaGNfONmhTnpvkCre2s3TB8eGiY=; b=QF
 +iY6NPtVXDmkFg2c754dCaLi9wBZJ64tabbPIqvCYM2hw7K6TXqh18264ncOM+vE
 zZGvgHNo+edigL6gc/1wD+g+/n35dC4k4EYCl5iEhXncVUXlZFb3+r7wY0mOuQsq
 d865b3iiJsccMFLqflj4kW8MU2bEC/3n5eDnHKh0clPtJzpaL2h4a060IXOC0iAZ
 wwn0spZv94Qv/mPqTvnnf9+e5t5g6nENhuGu6jxtnaakUdCgK/nrNpGP9iY+1Lyj
 kI9Idp3Hk+WiT+IzrQ20sygP+zOn+0fwJvLDb3McMzB8iFo4mIhAmicUmrKyTqo7
 iicxtwYBIZTQAjToK0NQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r3x6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 16:05:44 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-48296f34f1dso946443fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792598744; cv=none;
 d=google.com; s=arc-20260327;
 b=hLiVWJ0kRCCVNxkryICnUQ7VBdzYZlbZmPYI9uQuiRYAZrSPkWfFwoeG3S2iIab86+
 Ial0N+M/Qcfxr4Pq66Y67dGrp4PMLrEXjKaMTZyViopLFa5daYRYBAkwAPhrxmmvuPDM
 P5EmWbmnYMI250CP7zItrNUloUis0jX8vRCaggf9C+NQKOSEXZ9nyKcK36MGhs7s1ynp
 ARDAT4lHanXuFZicl3IAJ5drzgFkXu92jGTt14EVR4kMCvtwvKJeDhZYvjxXVakPkyG3
 iDTEnQOxXbiWKunIa5nGJVMJ0hS267Y/i4EwWy8lIIE8yoZ+SC8yLe5lqZwVTPsGVnZN
 FSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=BGhrLTjEVfeSljGkSaGNfONmhTnpvkCre2s3TB8eGiY=;
 fh=0x8+NYFxBj1pRKjw76Mr5cqwLig9A87q4sy/HxpSX6A=;
 b=SjTgXqzulSPiHFuxoYCldytCfxfhp5SyaFbUfzcPBMrwj0CbKrFYMnHsuyHZD0vVv5
 TZEn0bbMhUSYKRIg5OSDl5El6zUstgFTUeGMu2T3olHjugUAvPnyCD+xNV5QWQ/OFeyj
 kSwvS2HYjD6IqaVf4QQNYuYrXhtxXrj38q5wKxBak0J+Zy8/3jhCQWV6THUV0zSmPWCt
 Trlewq96DMrAFmlLV+FHPFdOT0HypuGbi3FeWjJKN1eb6PdzpbY8neR3kz7KeH8ojHKM
 6/a0njMIK6AHRhH/TFpyADgBqXWWiwS+bHk2WQDbAym6zmmbpXEBLCXGip+Pz2HJgHP2
 SZ9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792598744; x=1793203544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BGhrLTjEVfeSljGkSaGNfONmhTnpvkCre2s3TB8eGiY=;
 b=bJ54oV1h/y7YujbODV4IBpTpIwkBeJ1wZ7eEueySPPPdGHoDq2p7wVP7CHkm3Y0oUb
 671btpDLDoEDbKngYZelRe9wqLo/G72+Ngg3IpDdef2MkYYnR77m7ZrCqmK5LtBaKrjH
 xut2xN2wRmYjMwJMiMYV/eQeO0xw6EjmqQLJsFGnx7v9aZorw+AlrVZwXogcpWXLtzdh
 AHMd6eym5FAfgYGsfp4sXkQrSVeaJMXZKXa2pTffVtZhyyz+ex9zWFXnIvAsYYhhHhyg
 P5u050fg1dpFhoKQeoyUPQgoyKXXZShTQLrQkT9+k3KXef3MtSTnvObon37QsdwoGL/6
 gWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598744; x=1793203544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BGhrLTjEVfeSljGkSaGNfONmhTnpvkCre2s3TB8eGiY=;
 b=ANHnpBNovwAhBH9ypNSUHaz7fZ3GXmuaPyYwbdZw5t8wzMRnMoRjzpB/U4cf8WbFGj
 4rYISL67IPI74KmGR6iNZq/3+CkdAbeqPIKbB5iQRd3UQQJ5YwpUoQxDAX3O8xh01eY4
 OuBKyEXENZv7iCVfRo6r270ntj2VvR4RWYtAu76NeIPT2A0UEhnDmaiJR3VokVje+ZK3
 X+di3XR+VshQpUAnek0UnZC206tPhxFk4qUf+0+OWi8jKFfO5THL8bCH0C2pSHxaXikT
 ejwmud1EQn1L2AhavEHVRlINssO4dQ0fEtBze0j4P7pzfpr4fBP9SjXJSekHqfprl0xV
 ye6Q==
X-Gm-Message-State: AFq9FYK74XvrRrbUPOKLnHH0agX6H/r7hDr+QF0c/nW5RjO+5qDKlxU2
 Rt9FVJz26hKuKoPEHHbbQcF8tW4bhm7kWxy4eNu7C/7NNp4RxrLgzNvLPTmqP9Okfrng68Elvl9
 b+i7RHkUMoN2wmyXODoVBU0a0q9EKjtcdFHQzmFwDNPceww96DT9qEeay4FTc0Wcgok3fsYohVg
 dcgzlyQfjshMNbQBAA8E/JEuVr2A0e5bTOIJ+WEevaDXvhrg==
X-Gm-Gg: AYBFou2kgCpTK2HvvEsO+g7CkykDOVf2ZbbQXL5aQlqJRgpfD8wrUUmbiehbJ1XnXOz
 MsjmJH5X2YdHpXa0M186EgNre12ZnQUGUPAT8vPdpSrM7jLD7SJoETNUOY9nnqtQjNgYHBedgJj
 9LgPYalawyxbigrKPbM8YMDiT63562cJxQ/ia7R3laTkbkdIrhZISs4JNxIQ==
X-Received: by 2002:a05:6870:7d15:b0:47d:b8a7:40f5 with SMTP id
 586e51a60fabf-4a7dc2035ffmr1350679fac.22.1792598743674; 
 Wed, 21 Oct 2026 09:05:43 -0700 (PDT)
X-Received: by 2002:a05:6870:7d15:b0:47d:b8a7:40f5 with SMTP id
 586e51a60fabf-4a7dc2035ffmr1350633fac.22.1792598743215; Wed, 21 Oct 2026
 09:05:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-10-robin.clark@oss.qualcomm.com>
 <7f3a33a2-8194-4d6a-8459-73371bbf1b16@oss.qualcomm.com>
In-Reply-To: <7f3a33a2-8194-4d6a-8459-73371bbf1b16@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:05:32 -0700
X-Gm-Features: AclHuK_bRz_aEIm5tFG7vlDWVRVzspcPQvhEeeXHkuLP65uLy6f3eGGa47m5FX0
Message-ID: <CACSVV03b9vRO6fqH4ERhpAWT_=F8dKfP-MmqCD2cT_=Gk47=vw@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/msm/a8xx: devcoredump state capture support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e2d8 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Exdpg9e_d2Mu9UHmcJoA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: qu8L2ULZlF3BihuUiLJkwxKWgthVGpXM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX3pJrPYF4btLS
 ankN1zE6m4AauEZBU6yfkIDOf3V5lQmxpWctsH/Cdcn7UPR2i0IWOHU23eSfCNnc+bqMmbXqtya
 O4p4yy3INIEHPYJkVZ7gi3VQ3FlcoR3PMq1ZERzop/55mgdtbfo3fnMaaMrlIY3RH85SVkYvVyl
 r7QUK98RMX6jACpECFTGMvUjq/zB/IHAscNTViT3v9RPByE7udsgJ4rXF/taEgKLUDXxdOgPIpO
 KuQRN7Fzjbxmp9KUmMSRPQS/MWWU5xdNOTsbJYXpravfbfFHr/xxidY0W22FEowhJr9m+ngKfed
 OuT1A9D2W8K9VONM0UT95L26M4DboIFfGDH/8paP1w40p0pYTxE//Vzfkt/6HThjSjgsGbziOC5
 oV1fyEzG9xJt0zK4HG0s1NFysiTbK9V16jGCpVWXN+CrY5xA48XefMItMlp4Bx+IskISJnC4S4U
 ynHkYULNP80YN5eQPeQ==
X-Proofpoint-GUID: qu8L2ULZlF3BihuUiLJkwxKWgthVGpXM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX4XFCGxBJaZj4
 i9MUMmS2vVCr9EI6eRqxw3qPfYRN+QAKPHdsbZoJVp6rQCYq9kT5wC6xfVpn8j7xRvcc9LtWB0a
 QVhT301DDX6Bod5j8DxThfvgBpqeHjs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 1:42=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/20/26 10:46 PM, Rob Clark wrote:
> > This attempts to make it easier to compare to kgsl, the downstream
> > driver, to make it easier to spot bugs or missing things.  Such as
> > re-using function names, etc.
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > ---
>
> [...]
>
> > +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> > +             .show =3D a8xx_show,
> > +#endif
> >               .gpu_busy =3D a8xx_gpu_busy,
> >               .gpu_get_freq =3D a6xx_gmu_get_freq,
> >               .gpu_set_freq =3D a6xx_gpu_set_freq,
> > +#if defined(CONFIG_DRM_MSM_GPU_STATE)
> > +             .gpu_state_get =3D a8xx_gpu_state_get,
> > +             .gpu_state_put =3D a8xx_gpu_state_put,
> > +#endif
>
> It's odd to have 2 identical compile bounds side by side,
> I'd just group them
>
> [...]
>
>
> > +static void gen8_cx_dbgc_debugbus_select(struct msm_gpu *gpu, u32 bloc=
k_id, u32 index)
> > +{
> > +     u32 reg;
> > +
> > +     reg =3D A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(index) |
> > +             A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id);
> > +
> > +     gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_A, reg);
> > +     gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_B, reg);
> > +     gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_C, reg);
> > +     gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_D, reg);
> > +
> > +     /* Wait 1 us to make sure the data is flowing */
> > +     udelay(1);
>
> Should that be a readback instead?

I'll update to a better comment from a (different?) version of kgsl:

/*
* There needs to be a delay of 1 us to ensure enough time for correct
* data is funneled into the trace buffer
*/

Hard to say, but sounds like the delay is about more than making sure
the AHB write lands.  Same goes for other delays and barriers.  I
guess downstream snapshot is well tested during bringup, so it should
be safe to align with what it does.

BR,
-R
