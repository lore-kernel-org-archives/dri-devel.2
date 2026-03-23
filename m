Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF6D58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A3010E360;
	Mon, 23 Mar 2026 03:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lq59Lzqr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZopWjvMO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC4310E360
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNRDhG391040
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k9cQIrU0AYsQsOTJuEvFRQFC
 fdB69ZgPbV1+C8oQkPY=; b=lq59LzqrTNtvtPfO4Ux9VZ5v6At1PTTZ3EKMxA1U
 UDbV7XmKA2vxp4Vnz28rHnMSqf6XINhKItV/Yn8QDC7Bzli+UXHoupjQ7wQ+XuG3
 UV25rN3Xn8IP3WwNufXbO8vFqy/jnb133zeCjZqo7wh2g7k4rh+Xj10C701qkDME
 lV+egHrbL5eQOlC0AjaibRk+FSCBb9k+N7Sp9sRXQhVl8AlKf1HlUNWj3lX1vdBl
 378kE3wWkdHV5hafwDGXuCa+JxZhreuGUTDn7fCxWcmimAVb3Myhxd+RstUs1x+c
 qWZ6vPISxlHopBIlsDbBfW9fCRNQQgh2YYaBIidF9OSCcA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e3rv3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4987c698so177761811cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238246; x=1774843046;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k9cQIrU0AYsQsOTJuEvFRQFCfdB69ZgPbV1+C8oQkPY=;
 b=ZopWjvMOMSQZ6xviSx/o5u3Kl7JFgx4frDfyOE0J4dtk7Z2qCPenzTSewoaUrkUPUk
 KEIhOr1UUwPLFCbECWDJjUEw9cPTvtkMs7I1J9Hhu+OiFj7Q32YXS+/pbbfahBk6rfeO
 mBuIh4ln6R8BgdO17N38rv4mX14URJYhLurgCFJEXo53Y0f9DwIE01zcqI0srmK70wEu
 zSrf7yuWComfXK0cFLKdNNviAg8/7WzxHAjTBkYTCuKpQ14YRR4VYqCpuU3B1WT3URFA
 4HEsMRIId3GnTS51mM5msIyhOZ84XoK7ReYjd5nHfX45L7wXvuhHrHghnqP1LjqS5HAp
 XVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238246; x=1774843046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9cQIrU0AYsQsOTJuEvFRQFCfdB69ZgPbV1+C8oQkPY=;
 b=UI2F8D2O6wQSIGDmgkQJWAU5KmYxi1JT5aPGl4ykhMhnvRgVpAunsTwvYq4MY+Z6gh
 bkFpLEMjoBd5lcImeU6OsgjuCv1u56J2I66IW96grwdINUE1Jgsft6CGd6wLt9+d6Qf4
 v5b5gFtbeXA8356gJbHb2ZWv8a8Ey0YBZ5kbndY59Az2m+rxzGRw0pCdTQfJWgwDOJto
 zTyXb7hWCzms8IKKJydv58lQsSZN4hFjmXo69UE/+wj09AKaIUBz+vtG5Wn1vBt5Lrt1
 RbzlmGMLTWg1Mmfhv72Xy9YBoATRFetod/2M35TNbCQhkXQBHSiEqH0mQLPSIzWGJL54
 MJDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUKqUMBtPtoLVaENpCSPplBVaPTy1W1cd9U+W7hczpNSi+EDy1T66RUh6bReMHUGuKz3oU3h6EIH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYutRhU8x5zkW82c5rMtLfxSmSrKncxJ6U2OKRtMS/ngA1h79j
 38DmhXTURev51Lz2EZ466dkYfE4YZn/VDXl58U4Wr590tRmvEoHrslLq2mf1aiVoB5w2zIcWGOX
 yGXZk67NFtONNZKogBoTTnok5VT+P3mCja4eBVieL1h+zi7v0WnJRYE4VX5WzdT7N+/m4//g=
X-Gm-Gg: ATEYQzyAHSnZMbtPkd39jlfxxdVQ8QzSPLAILctWyTg7i7XR41Kmz9DjBNZ8z8C0NQr
 q0zSPz4uSoS+uOMXzBp7WhABmeFoVlRTQfqrhfS+7F88kf9310dzgcLvRnDPlavAQ6EWsz9OE7F
 Bs4tlZ8pCzyXDxUv+0ao92OjIWXo8Tv4wayGOWgcuQApAtTuQnU/bBeBx+vgkmK3UcKlYx1bRPJ
 CRdTNb/gvOvSXwImDTuaTm+jbDXBEAlbk5zG3kKwNvjsh6yDa6Jxwu8i50ijK77zk1I5fDM/ByU
 bWiaxxYNTRl2GpVpi+84MEUON190b+q4AJJGz2R0KOlEvmWk327G8v++ZGlh9EHbjQSdpTGqRKS
 3UDppxRE2vPRltlK5i1lzxkVZaWQfpNsR2ZybPMb1wSNOynvSn/eUMPo9wBFjEmGe43bJXp4qz0
 NIxuMBHZ4I6Xib2yHzGQXVwiPSHI6ZZRc930k=
X-Received: by 2002:a05:622a:511:b0:4f1:de87:ad90 with SMTP id
 d75a77b69052e-50b245b6f3fmr206743191cf.4.1774238245964; 
 Sun, 22 Mar 2026 20:57:25 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:4f1:de87:ad90 with SMTP id
 d75a77b69052e-50b245b6f3fmr206742971cf.4.1774238245538; 
 Sun, 22 Mar 2026 20:57:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b74sm2242484e87.6.2026.03.22.20.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:57:24 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:57:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 04/16] drm/hx8357d: Use regular atomic helpers; drop
 simple-display helpers
Message-ID: <i6glsf2tfikmcfen2xkvxnqp7kddfgyctbbi57pca23nx5mefb@2qvwne42uf5r>
References: <20260319160110.109610-1-tzimmermann@suse.de>
 <20260319160110.109610-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319160110.109610-5-tzimmermann@suse.de>
X-Proofpoint-ORIG-GUID: FhB2KlLOVXCDP_Djbx-iUM36Lomz2mPh
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c0ba27 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=WZHNqt2aAAAA:8
 a=Si4M6a7Bfedi3b75hxYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=PrHl9onO2p7xFKlKy1af:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNyBTYWx0ZWRfX7wITcVlovXcH
 IqNmVGGfhKiseiprKG9Ovpt6VotWQWnH7NYVlVcvW62fDq9V/Nl3OldNTz9bxTh8KLIipPZVLfp
 /NqTtioKzkBhGH462YDxRxFMnzsQ6f+cXmFq9ZnfxRMsTXa0Nmf/dGqzXJ9qpSjVODav2XSZVpm
 02UUQArSlVzagxDAn+BJV9L8//y0Igw6fIY2CiXe5dILDsnWZV0mLUOiCtiyHiAUB/wHc68E1/4
 /nUSN9UwhMVFLOveUD7Q+n48p7zYhx3fif6qzf2pGOkF9DNfFmtsbN8tT3g6+9HRRuY1K0Ma2/J
 A1nj0jrib85EKccSsMw1yuiBo8LPafbvZsx+cb971Vj8pCICMif1h2ubTftCtmg8zstPG3j4tdT
 o0RxFVxRoOqYkooHVa/H+oGyeZbfrUdpjUMIxemWaFppgZDKHGhFwxLHw4/Ji+ZzogJHNuETmDM
 KM+Nl7YFnDcpOh9UBbA==
X-Proofpoint-GUID: FhB2KlLOVXCDP_Djbx-iUM36Lomz2mPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230027
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

On Thu, Mar 19, 2026 at 04:59:40PM +0100, Thomas Zimmermann wrote:
> Replace simple-display helpers with regular atomic helpers. Store the
> pipeline elements in struct hx8357d_device and initialize them as part
> of probing the device. Use mipi-dbi's existing helpers and initializer
> macros where possible.
> 
> Effectively open-codes the modesetting code in the initializer helpers
> of mipi-dbi and simple-display. Hx8357d requires a custom helper for
> CRTC enablement, and non-freeing cleanup of the pipeline.
> 
> v2:
> - fix connector initialization
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: David Lechner <david@lechnology.com>
> ---
>  drivers/gpu/drm/tiny/hx8357d.c | 135 +++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 13 deletions(-)
> 
> @@ -183,8 +215,35 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
>  	drm_dev_exit(idx);
>  }
>  
> -static const struct drm_simple_display_pipe_funcs hx8357d_pipe_funcs = {
> -	DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(yx240qv29_enable),
> +static const struct drm_crtc_helper_funcs hx8357d_crtc_helper_funcs = {
> +	DRM_MIPI_DBI_CRTC_HELPER_FUNCS,
> +	.atomic_enable = hx8357d_crtc_helper_atomic_enable,
> +};
> +
> +static const struct drm_crtc_funcs hx8357d_crtc_funcs = {
> +	DRM_MIPI_DBI_CRTC_FUNCS,
> +	.destroy = drm_crtc_cleanup,

Nit: would it make sense to use drmm_FOO_init for all allocated
objects? I think we have all corresponding functions except for
drmm_universal_planes_init()

> +};
> +

-- 
With best wishes
Dmitry
