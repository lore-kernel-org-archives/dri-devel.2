Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D91606A332
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h70xA2I1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FFsiChVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDF310E8DB;
	Wed,  4 Nov 2026 22:12:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B1710E08A
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:11:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4LQueU2250966
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 22:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=eiT1btz924HjQNzzWl70B3xvzB6Cqt62IjRgfUiOL4Y=; b=h7
 0xA2I1xOUhDBkTTwFd3Y2vgiA3FBpt8z0GVTxo5Z80TEHVxaIdPqt50JXBrFoFw4
 +YhsMcPobW7taryWOxNEkhkusXUyIv4SOjBq9JwJDKMCvlJn3eDTdFUDIJp+seHH
 jzBPDEV+a+yyLz//eNdZ4wO2XNMroQjPZv3WVbXlqyUC+osDrBP9moQwgu2eVOw/
 ji1SVFa4f1GADGy9FBZ9eSxZnZqopFznMAfgIC7XF4Ms/Pl05P1aiZO1Byqr6UVW
 4X7RSomoUm0190v1+hFRbfa7JT9g1w43gABb6WtelVG7zjGzyyqaD/+I6+kg4oL9
 5BAC0jq6OgjIJ4SGlCpQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn2g2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 22:11:58 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6dd1142710fso2117103eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 14:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830316; cv=none;
 d=google.com; s=arc-20260327;
 b=Xd4UhsnN1eLsp4gm8ygAgSsR2cn+G6MFE6iTTK+23ndUXojE+R3W7UI/YS6MSNS5A0
 BcX2+Wj5jMgfXvWs0QKZQBtUNI1lzZae/MWiamSaLV3/Rdxl5Gic0VmwVSmR+nSinJCX
 0MvW0RwMb/ux9f63q21xFlTfnx2LHXfJjNkfihh6EU4E6McjCwGYPc5LiQju3dRkUltS
 MUOAeqq1CN6cH5stxqYHn1ly8Q+FC3GPsappGbwfjQaXk1uGJgzkpWLplOwli14UYcxB
 uLBwQqG5G4WaQBTFR7ix+n4nhTxZpQQTH4khoM/ADMl1/E/fGXW3GNvmUT1ceInNk9DU
 TsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=eiT1btz924HjQNzzWl70B3xvzB6Cqt62IjRgfUiOL4Y=;
 fh=jGBPDxeD5HZqc1VNdsKXP0BlUVm0k46o3LTzsOsin1M=;
 b=Le02Uu5KsqvUp0BuibK0lPnSML3N+C8XXa+UfwB8abLHIEE/Vxa/eXiDG8irGU4yNJ
 vR/oM62h09IgPt921Vm7JANfOK8GPPHg9/nm/abEiYdw/7Ys0KYqd8N10slk5Hg1WBoF
 GNhzl/wrUQKHUUPvh+D4SbVwcqvWOIjJs31bzLPSC9Z+VLX2bzS3IgbFlKZOgifr4sQn
 I8EvyYZb5gEBEc6QyZWavn/IL6aYCS3OghQ9rMOLksoG1qUcpqVTcsKGzYMvra1RTnHH
 0o5LPd2dX9dD4chph3WddTkoI/8nFGx54y+iQukPwNSYz9jgh4EDZ9AhbtSj9qjae1g8
 bBjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793830316; x=1794435116;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eiT1btz924HjQNzzWl70B3xvzB6Cqt62IjRgfUiOL4Y=;
 b=FFsiChVu86aU1fe6OQsltDAdUEiEGMaf1slbkelmfnMKnMql3AI3+NSd5sJzVK26SB
 zBR2lyT/YQzSWu5WwxzsIxd1yPbSkBQd+M5F/WCjxQWYuzHKnENw28qkqzpayTV2xxxz
 /RtMur1h6TrbMu2RJ+xJWYqyIMt64m5ieLdjbFgM0YRSUahhA+cyqTL8QvKYixhVlxm5
 PmCt3Z+Ur94YkbLb8sHNBvA2l65Wwk5N1cg7WYFIIJ90WPUIbOc+Q4X1jzuf6cBfg4GO
 osjQiKGXrfgY3U7DIJSWBZFPpFmExAv7bA3TepEZZXRSlvBudeHHAJeT+JaNhnVEGYS4
 kXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830316; x=1794435116;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eiT1btz924HjQNzzWl70B3xvzB6Cqt62IjRgfUiOL4Y=;
 b=nviBGokPXNNiJRXYpj3Ihi36546Xd3kmxStXQ3ubogrd/pCOarPaFy0rXlxiEQ4UPd
 uevKAALM+QdTp+YEqFhsKnMjKrzSdYjgZfR3tSYODCrcwmWBxaxwCXvHzcYprmtHn9J4
 7pHpUvlhCJmzakT6A9yBtERIXd2BtRQMbJ/KMwZjxbMLXfPy2dY7M2AMH8zgQ6r5QMul
 l34z4iZK4oue341EMERnWkOIc7D+6VNv2skeCUKrhc/D3OY8NymWYtNl3Ao+C4CnmElf
 KPRUg7C/iCb9AWtHTKJ8YvnQsee7VZmnq+mMZmBJSxnN7IWLyKl3sBGOsHDHuRmSQ21x
 ySPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnv51LPDpZaifQ8RaERgrJ7x/rdsosaYvcoj7tvkExlfVFlTnMaoOlSmKeWAPs02HosN/bh2CFV6I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zwrKaKGxLxzSsof5xn/LZilOJTTDhzxE2SmSFGCbExVcP29+Z
 heeK0/UGWepU6G8lysFF9NW4ZAd51EVEtqLsCRymDHYT7o6UOQZaA5JQAvnkT4Dmos5kmOrC2/v
 MJGjMRbvbjwNcxs8dHcOw2xmm8dD8UyPIWVfkbezyfQTO7XmrUtLauFnwRZeyUXaCPoVndBDGBc
 s4CzTk68ktONEUd8qQWV2luXkXJox+YXGNf66ywkV6qY0QUQ==
X-Gm-Gg: AYBFou3p/o3LA2cXSjtU2HnU8fWaYyfZPr2f36Co7Nv2QynkuOy6YpLJwX3xj2zShZi
 BOii70zyi2NOec/0s+O/j83gEElGOu4sxiR6LTaX62bMq8tDceK+abIAYppLfHrbpL3Wyj+GZF7
 HiMLaFvcvylnjd+iGXGYoDNBmchddjRl1R2UJ/mRqQas3jRdthboTSABuj1d8szUv4zK1JbADWR
 kxE2swmHCdTElUNN1xysg==
X-Received: by 2002:a05:6820:168c:b0:702:efc4:807d with SMTP id
 006d021491bc7-714f29eed8dmr10906932eaf.49.1793830315855; 
 Wed, 04 Nov 2026 14:11:55 -0800 (PST)
X-Received: by 2002:a05:6820:168c:b0:702:efc4:807d with SMTP id
 006d021491bc7-714f29eed8dmr10906914eaf.49.1793830315450; Wed, 04 Nov 2026
 14:11:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
In-Reply-To: <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 14:11:42 -0800
X-Gm-Features: AclHuK-PejnPAeVcWn1rFgQSugIaafHtbuWuLOPuri8tnD2WASiqu_5BlPlNCuI
Message-ID: <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
To: Robert Mader <robert.mader@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Bryan O'Donoghue" <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4OCBTYWx0ZWRfX7kYGg0Dz0dH7
 Wk+LnNagqG5fYdNF6z/1uGQYtIO25VzhuhV+YR/DMS/wNw9LqzXLJOkUxsb6HzMgtWoe4eAGnur
 qIHEEQ9bAwqW0fx92lYFRQd9mWv7dYBw0/FZ1Gv9VCqoW1OEtlPiML9txZIFdniDpDhkzaD6vQ0
 SQ1FBaZm3E5qU7jkO0Yo5/MoMn+vJz5A/LrbiZycPAWU9HL8FbQ8yYwBJTXctrdvAmaK7GVlzfC
 h7beGksMApY0KZ0pM3bi5rr2VPM/WxDWF5Dq7IgBD660gjhJ0zuCZmPI6tMJ7Cd2bscz7YwBfVA
 IA9jCEiW1qicgNytYwy+NXepDnT/FiCoTdBWb9IJdX1G1DfGfxWRBJwtepBZH1kcuceYTy8Pvka
 J6+tyXTKVhV73p0M9Hx0DhMLyhHmZpxkMElicOCHPqzidOGaawvMSbGPUuYewsPbNzGBxbt4TyF
 7TLrE1bvGd9GikIMLIw==
X-Proofpoint-GUID: jSS47_goIp6jXkPLmMZcsQfJR8I7cjxM
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aebadae cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=guYwWtrNydk0MfZTwrkA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4OCBTYWx0ZWRfXxayMit5NJuKd
 gwpjdyNX5ThKIDpmp36l2UgF+MDrhDndTKsMgJXGIYV3g0XB2HQD+SkNRPzDScaL3eMUI5Yb0nq
 ZQpFalq8B0sGPBYZr5sViJX/p4r3nuI=
X-Proofpoint-ORIG-GUID: jSS47_goIp6jXkPLmMZcsQfJR8I7cjxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040088
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

On Wed, Nov 4, 2026 at 11:00=E2=80=AFAM Robert Mader <robert.mader@collabor=
a.com> wrote:
>
> Nice, very happy to see the series!
>
> On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > The comment describing the QC10C buffer layout calls it a compressed
> > P010. It is not:
>
> If I'm not mistaken the display engine / the DRM side (including Mesa)
> describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> Gstreamer MR [1] . So if we can't pretend that QC10C =3D=3D
> P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire that
> up everywhere etc. OTOH if we want to keep the DRM side as is, then the
> comment should reflect that, IMO.

IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
as distinct formats, both with and without UBWC.  I'm not sure if the
same is true on video side but P010+UBWC was never exposed, or if it
truely only supports linear P010 and UBWC TP10.

BR,
-R

> Best regards,
>
> Robert
>
> 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/81=
95
>
> > P010 stores each sample in 16 bits, QC10C packs three
> > 10-bit samples in each 32-bit word, which is what the stride computed
> > below (width * 4 / 3) assumes. Name the format correctly.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/m=
edia/platform/qcom/iris/iris_buffer.c
> > index eb8de60c1177..ec2bf2a2d953 100644
> > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_i=
nst *inst)
> >
> >   /*
> >    * QC10C:
> > - * UBWC-compressed format for P010.
> > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed in=
 32 bits.
> >    * Contains 4 planes in the following order -
> >    * (A) Y_Meta_Plane
> >    * (B) Y_UBWC_Plane
> >
