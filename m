Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6180DF506D5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9D610E3B2;
	Mon, 16 Mar 2026 14:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="arScxS3I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YXKOo4Ny";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8281A10E26F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:32:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GCXAPI1621856
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=nPjoJxU6spHa5+lTcvGzrMEEtAKQiTdlw1paS2lURbA=; b=ar
 ScxS3IVvm0Kxuicjj7HLo3E/T3Pg/Y4QAvUMTtwkx/k85npO9oc3KL+NdeHiKHLf
 cUcgBYJNC7yNrNBM+J//3ZR+skr3vlBmlmT5NWRcIN01L3t8XYuuxTUDP0aGju31
 OvqmPDzV28KysmrqR+6P2LjxilQiMMsPZ25FV77MzFP2+hE399B8l1fs7T9YpFeW
 RQD96nVrdULnddeSxMxVE9IPMVYCrw4jsMfQk0SUchW+XPqZfMX0P8y0a8vcHsRL
 aF+jlgQJknlysdSH9fxGo05y+L+RPyW4Tn03ZL9L9RvNAxBea8jyyww/SbJ3Y5sE
 s/3ds6mUEm6Q3ju0T1/w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyegem2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:32:02 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7521130b6so42581097a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671522; cv=none;
 d=google.com; s=arc-20240605;
 b=T0+zuZg39axj/S5yxDRood8D+kimbacmnXEhsc+OLOQiqhpBmHHbqrLhYaUBaKiQh1
 h1waUDD0xRU2q5qh3/eY0xOPGD4CesyV/5dTwbhA86l2zULsYV9Ny2UmJLD74Z0Bq4at
 JvNjgFuvf43VpoBx1hmUx00A6jvUKTf6zjYbOH97sPqMWRZL9VlWoDoVIWnM1momWkZs
 ETOX2vvADBHKxIeFELZmx/RlM8trt0YGGI9KRO8aPQ7DeIXcfkfqZC0Vjt+2boDBZPr7
 VYIHhpdgHqZJQqUvOJxSA11w2kiD3VGTU9nGBuxx1jhMYwolGzCEduTwGI59f8xrOk4p
 Ibfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=nPjoJxU6spHa5+lTcvGzrMEEtAKQiTdlw1paS2lURbA=;
 fh=Pp03wKGIUqXZNKVmL4fixzZ2cYGtpfya9AbrFCJxs3g=;
 b=CakTO56T/y8GHIQLbmOJLuxF/m82vXnu5B+6QXni0W3UJAEXOgxWhIKnJjMb3O1EtT
 xK5aokAsaYm0KxU76tpETmYjCyNIU+nKm53Mzv4cI0BkOo1DAuup0c0eg58W6/HxQxqh
 Fjva0jBEONPfcRGLyVTMTCS97uHAzipbgHnPjMK3eRYDwFKCvvvuvkNv0KusKx7+Est5
 XfD+15IPfPUGKkM9aWCzJQ3zn6bWQQW0EZGlC8Uy6UhQ4jhHSpGdniv7wZJ9Vlipz7nt
 NAPYFIxDVK5oM5fMOhz+uuKRa+IxQv+QdqG45+3ZAIK0kmPzcSh1TeV7RNHS6RnJcUR/
 WXiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773671522; x=1774276322;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nPjoJxU6spHa5+lTcvGzrMEEtAKQiTdlw1paS2lURbA=;
 b=YXKOo4NyUFii6ppsbBjVrGoaKemhBTqBkxc9TpymZFs3sot70PhVCcf45JhWxWah0X
 5oOObZmK/kEJ/0XauhS1YYNZ75ZsmYqeV1rRwfFpto/IkllVnE7oa8IBL/purH+bdlKh
 M4TPtsgoOexDdHl2yF5uKRJCFV6q0oXWBpRJsKgdy3zT8Pr6KExVvajfl7g+Tq0F27KU
 oUUBw4hJm0wUPbgYEoVEu1MG702imHZFeaCM9hNLg/o1zqWWBq2WMbhd8soHNCP9VXnZ
 XhLb1Na13vlCDrxFR8mMmTUvGUYnBqfeZfHstfRiIgl9Blu+/NNAmWnaY6k6WhAXlDEA
 iwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671522; x=1774276322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPjoJxU6spHa5+lTcvGzrMEEtAKQiTdlw1paS2lURbA=;
 b=SRWb7BYSzYhwdpDmDGJI02/5viYmJlsDZWsFG3U4Pkj4GG/wdmCK8OtYOeG7Ub04s4
 ZD3ugT7WMpYdLfLWzsIv77HdAfa4f7TbG24OMNxGgMA3bngNva03crn04kFbGrQ6bbJA
 oxws0unJ0L+xYcfh9Zgsru1EC9ebH3TMugTwMbDX2qBzem/dRoMSke0v+1UVWLh9vVCE
 p49MPPL2lCRiS5xotB+ZcVdIGV3sbiftQUf0sHqI2havQCBLRWzAh2ngu8hmn/L2wV4K
 CqzIxOx/+6GMg050NOKc2c/MzmmYaOj2WY8j+nOnu6wQvtNuU967HCUvHmduL46BmKiw
 4eEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9Q4hAys0JGFjACF+YwVmvpV7sefgKNhNotMV3NuAB6kktIWDLG46kBoLV9U20c70qpzbiGb0foV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjv98hCDdAEcHSLvzixYMG6auOr/ubSPDfd21WqaHKmQdGvhdF
 t52z3PpLBY5AjfUCbFjNsf9gv8AVGMDjx8k/kGcdVYBqx3njT2Ga1KPsQHrbinBBl/LpvBtCChr
 n/T0gkEk0EbxvWEnuWfIxM1cH8g5344Zf8cmEz0zz4uju3rT9mZ6vhabFQ6T1BS61qkbWJmdRMT
 b+s5i5CtTwY9Zui7Td5VZ4vxYX1Z7qHFpUk6Kqjxu4KDfI+w==
X-Gm-Gg: ATEYQzxHCVlobeQmkhuLiVLby0ipfKcaR2LhnGLAQ2OuqVX770qPa9/y03p9DXUNYWV
 k1NUafW7TC/VM2CX32Qx+w3nct4IQQflUDuabUujtzULNHQ4Brk8hAfMh+Q/SHLy7LRCAZOStnP
 UVYDJSY6L9mpabR83jX8XnEm007PjwjctWCoID4OJgSMFcYW5YarO2vz1nHh+svCtCYWmjmbmnG
 AX+4KswU4O/3ozGvXYWmPpV6m6dshuMR/J+Sw==
X-Received: by 2002:a05:6820:460c:b0:67b:a4fa:7a0 with SMTP id
 006d021491bc7-67bdaa2ef02mr7072523eaf.44.1773671522017; 
 Mon, 16 Mar 2026 07:32:02 -0700 (PDT)
X-Received: by 2002:a05:6820:460c:b0:67b:a4fa:7a0 with SMTP id
 006d021491bc7-67bdaa2ef02mr7072506eaf.44.1773671521640; Mon, 16 Mar 2026
 07:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
In-Reply-To: <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 07:31:50 -0700
X-Gm-Features: AaiRm53KsSumyAMa122GPvfxaOMRHHLZur1wBvUHnn-OvvsV8SAklqaudVZG-u8
Message-ID: <CACSVV00HQY6OfWRSWDcv4KnpwhTO+aLpTXLoQuGutvTTmgJFnw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>, Sean Paul <sean@poorly.run>,
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
X-Proofpoint-GUID: QhrP9ZheJfmJTVqSI_hER0uFXyjo5VZ5
X-Proofpoint-ORIG-GUID: QhrP9ZheJfmJTVqSI_hER0uFXyjo5VZ5
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b81462 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=QvdgE7p1BmYn3sne2WYA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfX1dpLXpPCU538
 XdHjTkK/aY1uslKSbEnarwvd0M3Makqd2ZwJE3CVvvKUnmA+I6zWcONzGMq0Avsllg1SrHWJzDm
 jsCOO7Uz1yxBGcmi2o7pPbPctQcJ10hG57HneOw237It5Dsedz4al8NS2v8ny1hBqeTtpeNj+T+
 SnbRCw1QvE2yWP6Gwg5UbhoW6LpN6WiOmhpUJhL68vxXRC9IQ6a8fLBgmLlAQ/DwZGFyvPsx1Ou
 6hyQUG8pRNgupJRV3NbtX5ZJJDFS28qNyJVkKT16TyrFnlELCy1ZkoSUc5MdVuPsUVRIGEtJmBd
 slyrxVJDvdYbl7BnFvq4Jjo9q+NfESwkuLwDzrwdPObyeMXzDQ9Cdb5Cxk6t2+OgwgLW5Qd7ZoD
 TvoN7lKuePDWRxtl+FXDttacxA70upphHuIn3e5bONy96k+VpZ48h8mvBvovUlQD1SGWH7Li7Dp
 9znCOou+Hiv6yxxyEGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

On Mon, Mar 16, 2026 at 2:22=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 3/14/26 5:14 AM, Alexander Koskovich wrote:
> > Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
> > GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
> > to family >=3D ADRENO_6XX_GEN4.
> >
> > This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to repor=
t
> > an incorrect GMEM_BASE which results in severe rendering corruption.
> >
> > Update check to also include ADRENO_6XX_GEN3 to fix A650.
> >
> > Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
>
> Hm, that commit also changed the value for A730 - Akhil/Rob, should
> that be changed back?

No, it was incorrect before my patch.  The only problem was the change
happened in a6xx_gen3, not a6xx_gen4.  So this patch is correct.

BR,
-R

> Konrad
>
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.c
> > index d5fe6f6f0dec..0ac3fba5c277 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -376,7 +376,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
> >               *value =3D adreno_gpu->info->gmem;
> >               return 0;
> >       case MSM_PARAM_GMEM_BASE:
> > -             if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN4)
> > +             if (adreno_gpu->info->family >=3D ADRENO_6XX_GEN3)
> >                       *value =3D 0;
> >               else
> >                       *value =3D 0x100000;
> >
> > ---
> > base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> > change-id: 20260314-fix-gmem-base-a650-cfd9bfcea425
> >
> > Best regards,
