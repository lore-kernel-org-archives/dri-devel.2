Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F94C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AED10E202;
	Fri, 31 Jul 2026 13:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I00iG3zA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZasKaRP3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B6510F25B
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VBgfim3797916
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1UHWdcuhd2ga8Vdy+j8u28yQ
 M6gZ2F4ymuOo6UaOwbs=; b=I00iG3zAd30bL2pPz5zBZVS5nLd1F5N+EP0CwfhL
 XyRMaLuqZE8Few53OAAtaL476uf3jPuBvCx69cFid7FAHMpJ1HG3QJXT648s2ofy
 KBksuOXUA+nHhQfCsPtuDnRWvN1SrIomk40y0QQ3eyyVPwlr+POodctKif6GvMW5
 jnfOp9cp02A3T+u7meseSkSwXUtWK+MUQIN43znGk05jgqxQMqVtKbc021aFTvXl
 gstk/le1toMTW3F2+CDTxF2aSVK3DvbXdHkrBohbAaK7cbJXxFzIYhifBkx1Ktyj
 BV00FG4U/lwmgFLZ5uNVWVfUE4Q9n7dPwkdUdHdpy9u5NQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u0ejk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:37:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso6984451cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785505055; x=1786109855;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1UHWdcuhd2ga8Vdy+j8u28yQM6gZ2F4ymuOo6UaOwbs=;
 b=ZasKaRP3Bb+eqkY0fVDk6iQ+etnM1dcdzdUT8tmKapvk3Xpkhf6dEleaXQx/8H0mB4
 oeKi56C48z+tTbPzvXGfs9chCmm3dvKy2l7MO3TQ26Jr+7cmv+I+eCooAVVu/3bZKdmB
 ryMCoyeZgtuNMHxrYmy7gs6wTPqi0LFaKMy44PCcJkTfnD9pPWKcgECK6E/qAVq2jUCi
 rt/S87YB5LwKErJsY+B7n53wk3vdjDsJ2lXWbndUKKvEQaT+W7uIpe7LPS3F2UsY0ySD
 ThBK0s+0+amqwHNrd7fQqUN60quKnlH+8RUJ6/UywtuC9oaN6gfnCuHmRNrmiKl231pd
 lmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785505055; x=1786109855;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1UHWdcuhd2ga8Vdy+j8u28yQM6gZ2F4ymuOo6UaOwbs=;
 b=lIj9YmMi1ogp6Hv/+DxULNUzAkzxV7KwCut1HtoomS3XgEjZt2pVH1UJpzW8nX8s8q
 ZhTuW2swrH5bEJNjaS+BmEZGsZWZu+U+Zqid8dWQsVonxGubgxhKn536FDBCIzQ1528F
 7vkGdqHcAspqyJP/Op37kLPjpjsGmtX+vfxtse758O5uz5D7EEuMPhSPM6CaIjwB86Ab
 R3zZiFdfnkG5Ral5Vb3P7JjToY2HuUYkYf3sPKpP+lYNNUBiF3Q6vvvtJFC6tpYQsIH/
 o3D0eVohSLtpSDShNU+uRoo0+gbEiPOvhzV19WekYhqqsh0r571NNULdCHz1RNJ/RrUs
 0oNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTgRFYtaaxt5Zpup6MqrSlvUBLS2qSkNrJmmoRZ+o65k1tiXSdMCLwDjw7TdzAZAneTh7fWW8ZoPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzncQP+RbEDDDQdW2PXvjk94/qu68/uW8X/nTMSt2xWuLCBc3+L
 gemKoAAhFGliy0wKwJdY0fL7uhlkMMrQA6BiCH8wL67xcN1/X17GR1Hz5Xcpq1EOdNLSfF++vJ4
 P46LDf/amZdLm2w0994YQ56+kxl/zTmHWGQdF1/ktps6+dn6KPMX7Wjs7wcIRzGcJSoRFYcI=
X-Gm-Gg: AR+sD10tt34gthSGMclqJjPpFmWgKEe5/T7fPrSBZSM4TXVuUJW5r3m5j1u2KeH3N9i
 MWb3wXdJDRUkk+Jqn92tATEaMaaxQRu4xebrC3pV9wO7Tz95wkRTU5pzQbz/IQD5s5y2OcpLOdq
 hYvxxxHaBDt4Ou2DSPEsn1S4FjSeJN5N5LT5TomwPlnjwCft15wC0cTMpvqEfe4OcONAK51MDmZ
 UYET9XA51AoSHdHE6jSmewnEMI/59xUbYz5CermcZLBb1CpUtPRi5bnpe6j1u+KMKmYdpVEF7+k
 6R+Pb86a8HQr4X6ZoMFsyCweQ73AlxvDJVXTBCtfl87NCx1gSmUm9oJgLoMYHkAXTf3ZmQ/4SVr
 oqDfcKO6wJD0i85dIXHMmAwC/oJYuM9KZXBllH1ARSomAi9kc6k+HB0cf0FS2CyVOrYDIbtTruV
 HwuAsD2ms7N8shEQ==
X-Received: by 2002:a05:622a:305:b0:521:103d:9f98 with SMTP id
 d75a77b69052e-52b4ccd6226mr22722471cf.19.1785505055023; 
 Fri, 31 Jul 2026 06:37:35 -0700 (PDT)
X-Received: by 2002:a05:622a:305:b0:521:103d:9f98 with SMTP id
 d75a77b69052e-52b4ccd6226mr22721811cf.19.1785505054447; 
 Fri, 31 Jul 2026 06:37:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e2441ec2sm309349e87.43.2026.07.31.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 06:37:33 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:37:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 4/6] drm/msm: fbdev: Calculate buffer geometry with
 format helpers
Message-ID: <zufng4s4refvweovvogyq62zxl726npmzqh2sf474qmje2uwlt@qaavrkvos55m>
References: <20260618141249.151338-1-tzimmermann@suse.de>
 <20260618141249.151338-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618141249.151338-5-tzimmermann@suse.de>
X-Proofpoint-ORIG-GUID: MnIZhSdM9YBBypoquGEi4BIVHjeJTcWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX52JRlol1mqC4
 C0JRjnLn8Fp2Z8RAhvXTEitNaLZRkym8og3uMuLAhsn+XEy06H7KV5h0EJaVBTKabaOk/WF2spO
 NcglrD4AoPUHxpVtYlQMv9TSK1qefWqd3QHhHw0QqS7ZdGd/EKX5aWKCLXXd1Efz37BduA09EA8
 TpSzhDov7WFN5CHWThUlois+4b6gA9ExE/6xPSDNazJ0qX8MIA4HtHlmJAs87GLOia3UmAlTX9s
 IyZ/AnaTSoFVem2/CjHE6dM52UDJx3p7fG0/1DNe1aRPLthgy5y39/eD1mdl10QhtnxUfuogzQS
 FT5LbK1jXL6yeUHOPEVWwlGlLIKgJ4w4ly+MUAgSe+ly/v/Zpf105HOA/EzGAmtrO31/NF7hCQm
 luCPrH2KVr2kzjaPWCyVx86slODx/Nd4TihnVYo9fwnZ+FSeHDewogOKvJApyMfz7s8FmvVAqGS
 Dfo4PVpmxtJty12/UjA==
X-Proofpoint-GUID: MnIZhSdM9YBBypoquGEi4BIVHjeJTcWy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEwMyBTYWx0ZWRfX/Xj/jhx4CHLz
 EimA6gGLY4zeqk4iPr+2ZAm6QXaa6g8xKmyuw+5Tfq+1rbrub49ca405mSxQphrNF5seylyRjPB
 NZspcgf77iOhcdE6Rio31lmEE5AROq0=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6ca520 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=yktShXf9RslwC1abtNAA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310103
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jun 18, 2026 at 04:11:35PM +0200, Thomas Zimmermann wrote:
> Replace the geometry and size calculation in msm's fbdev emulation
> with DRM format helpers. This consists of a 4CC lookup from the fbdev
> parameters, format lookup, pitch calculation and size calculation.
> Then allocate the GEM buffer object for the framebuffer memory from
> the calculated size.
> 
> Explicitly align the size of the allocated GEM buffer object to full
> pages. The contained memory is the framebuffer memory as seen by fbdev.
> The page alignment is required for mmap.
> 
> v2:
> - clarify the page alignment of the buffer size (Dmitry)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/msm/msm_drv.h   |  7 -------
>  drivers/gpu/drm/msm/msm_fbdev.c | 26 ++++++++++++--------------
>  2 files changed, 12 insertions(+), 21 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
