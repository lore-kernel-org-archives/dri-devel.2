Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9006AC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C808810E118;
	Wed,  8 Jul 2026 14:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jgbop/F0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+s+7/Kd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6278710E118
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 14:45:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3NPp2753549
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 14:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5HotaLJOpxQKOWfRZToEfRIMXX4F1I/5+Refyn+Gzmo=; b=Jgbop/F06M/fLxuR
 Ld/hazN0kxogXEm0oYZWh3+HLlQXPdoDxHaJXMA6JhYDBG8snm/OiBruJBjQCfrB
 IYLJIe5YdqA5fPqJxLyGTwspMkv5gq4mCarcBG4pFEZEn6Rk5KQmADMzscrV4+BB
 ScPU/O3CasZcORibe7bOkbStOgpLTCWDmYGGe+v3b/ZyogNA9b4Wy4ZjVaCFTM+v
 uJGy7RoVrYP5feyANUoOWZuJ4yLXZLsoEZIhFthnw7i5fziIeaTWqQWJN1UEytCF
 3i0BmEBo9OkxLMeZU134pFbmfSRXsUVFe9/f/GY7c1wBKUyqD9EZOUjdiZaxJqcs
 Q1t6pw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hj7xx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 14:45:09 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-448d51840c4so401472fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783521909; x=1784126709;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5HotaLJOpxQKOWfRZToEfRIMXX4F1I/5+Refyn+Gzmo=;
 b=C+s+7/KdBoK5+0Mcnauztx7U53t3vUe1qDKGBtnDSKOdpoCX1AOJVuXNCfO1D3fVW4
 L1ley1QUops8ccu5iyobgLj9ITBVqXEUq8k3BAWMCsEFA8+jsYBh8jr7ehdSfDZPtK8p
 NR2dORTMi+erKgiszefWpv7buvK5Vdj/lpJaVroSUr2iL5WYWAqu6dZgU65MJm1BvXnl
 Nhhg1OWUaPE0fYwKs1mkX6VrlNgxr4DXbQDTAG7Pm32he163foFEnwFbcHZsS3LGIzp3
 l5wDYVk3ls+YEdJ+weThoArfl3UW6HMtiIm/WX+f2lZy+3PMQr6Z2CbfKdGPjZ/w1578
 sO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783521909; x=1784126709;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5HotaLJOpxQKOWfRZToEfRIMXX4F1I/5+Refyn+Gzmo=;
 b=nMZk3abRGPF6oFe/bM4rn2YSKSJBThzXwcK/iQJrP2+zMX63kXZamL4URhJreBbLyN
 l2+HKgl547G2sS3ilJBQ6Rj+ocmBTJlZ8OlCw18/d/wxXnyEx327ybmEAhzsXfR4H9ZB
 90B1oN4Mzxollj7o8CSKQhUigNkV1yiUF+XrfcFbYpCgWRRyqBWBJMaQbNiNyvEytUOB
 DUsZ+DiPPSTa+xtq8B1Nr3IhwaiI2TUUOpGCMy1zM9+HwQe8T/2FWC1BHiJW0C/hDzK5
 sHCPaNn5ZwUctcK1RFZOWcdNPnOTlZDsjXRFu7BfOafFIbYc2tuS/9AaUwB/AsceVaWj
 zkfg==
X-Gm-Message-State: AOJu0YwIhWzguRaQ4P31a3OdDJYD+OhpoS5oz9755QdYsj4exI5HNZiq
 F5C7TvtXXssstq2W9tbzTLDwHouXyzyQH+iQ1TfuoMvoWDls1wYXQwpam//RowTLqhURI+l0GZR
 TQrJGy/tYnRHgsaJQo+rXpqzXF4aOaD2j5MNvhT0UbUcUmoHffxEFJeOV2ui6ViU5byEEXPg=
X-Gm-Gg: AfdE7cnOYmT3sR8VHY51GqqaZhs7CHZ/mkRO+PNWTDVx+lOTPKWNeV0fH/pEQ8Vr1jt
 y1d2hW0HJMM3jV1boEpdecCsCUSGPcGGzh/oh5OaTV5+V15egQxXK22W/LukFPbk7yjvqHKVLTb
 qSK8KA7LDHQCoxRr6alw8SWd1Cy/TGt6p0l++oct5Fc8tKuLfhuCUE+/i3CEmsA2QXqqsOyoShv
 GH3xmcnrTgOy5aarU240mS+kRQU3bUuzD8XIBAZaolYPUYZukrny4fL1p+CYuKExQwpoDxS+VEl
 /QcnftuRfWShvO4AvfM/fGOKNQZm02n169m5Nz+5TAIc9+Gp44syHG0LH3QUloYFz8zjW+w7fOp
 wAqVyLj7yOfFgqRg=
X-Received: by 2002:a05:6870:2150:b0:449:bccf:bb6e with SMTP id
 586e51a60fabf-451637bc19bmr1788791fac.7.1783521908573; 
 Wed, 08 Jul 2026 07:45:08 -0700 (PDT)
X-Received: by 2002:a05:6870:2150:b0:449:bccf:bb6e with SMTP id
 586e51a60fabf-451637bc19bmr1788765fac.7.1783521907887; 
 Wed, 08 Jul 2026 07:45:07 -0700 (PDT)
Received: from localhost ([151.243.38.149]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb559559sm17037998fac.9.2026.07.08.07.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:45:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 22:44:52 +0800
Message-Id: <DJT9QUB9KH7L.ULPE8GOZ3RS1@oss.qualcomm.com>
Subject: Re: [PATCH 4/9] drm/mcde: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <Frank.Li@kernel.org>,
 <imx@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-4-b4e1ca053623@oss.qualcomm.com>
 <20260704184456.8C1571F000E9@smtp.kernel.org>
In-Reply-To: <20260704184456.8C1571F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfXwe3B8sxPjImo
 Ke2bJICX9A2byul66u5ZnPyZR0H7te6m9qVAjsT3zNNcwyp00EYNMECLoXuHT8TI0mwfEkcGl8R
 TzH6rIDDfb8GJCxcx7pXiF4RUEaU1wiBGQL6Ho/Yi6Z/YD9yklvi6yYthJ92iUiorEUawr45sGg
 unjYAa2AW9JZVnMe7adSgPVunTAQruZ40qpRxWKVMYIsvzEGc2HkIbCwB3Oajj5ub5n4Y2JxN9R
 pl4+i1dOlIPmQuuuHQXLnHWvcocxTK6JKY7jiEuP430CgucAd5npW8pUaI8AFlpVn0hvXTfj8fp
 2XyRYdJvzy66uvrKcY07soydOXef5kgS0Tf9xk0SZnq/8Fgy/a/3CQK0HEoBjNQSpW908/P3YX4
 9BverfKCUqos8ZS2KhwQ8tZk2p7R0lC786JUiBLszRmMp4pX59ZVSeSRGuPKwMB8Yudnm8g8kqV
 /AS2pYMnoTvYdtWQ2mA==
X-Proofpoint-GUID: CN300D-B14GxxMcSK0rCtf5Y5zMV1y0a
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e6275 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yd_HwtBYiBPprMbcnowA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0NSBTYWx0ZWRfXyqw6dNAcdAZf
 j5NTUANsbJVNAAr/ovt0e15bk+bsFTwoYR/MMM/vlrseHB6R5sVzxJp6p2l+noaR1Ibnv4VczaE
 ln5X7qzkrC7p47WV8ex5tE5Mk9DUzis=
X-Proofpoint-ORIG-GUID: CN300D-B14GxxMcSK0rCtf5Y5zMV1y0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080145
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

On Sun Jul 5, 2026 at 2:44 AM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] Uninitialized NULL pointer dereference when attaching encode=
r to connector.
>
> Pre-existing issues:
> - [High] Atomic callbacks directly access global `obj->state` pointers in=
stead of using the state passed in the `drm_atomic_commit` parameter.
> --
>
> commit 098f44a54758ae5b340970e3384cc9330909fb06
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/mcde: replace struct drm_simple_display_pipe with regular atomic help=
ers
>    =20
> Convert MCDE to explicit plane, CRTC and encoder objects.
>    =20
> Keep FIFO, event and framebuffer update sequencing intact, and install
> GEM framebuffer prepare callback explicitly.
>
>> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/=
mcde_display.c
>> index 257a6e84dd583..4d86fa5030ebf 100644
>> --- a/drivers/gpu/drm/mcde/mcde_display.c
>> +++ b/drivers/gpu/drm/mcde/mcde_display.c
>
> [ ... ]
>
>> @@ -1149,16 +1171,14 @@ static void mcde_setup_dsi(struct mcde *mcde, co=
nst struct drm_display_mode *mod
>>  	*dsi_formatter_frame =3D formatter_frame;
>>  }
>> =20
>> -static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
>> -				struct drm_crtc_state *cstate,
>> -				struct drm_plane_state *plane_state)
>> +static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					   struct drm_atomic_commit *state)
>>  {
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_plane *plane =3D &pipe->plane;
>>  	struct drm_device *drm =3D crtc->dev;
>>  	struct mcde *mcde =3D to_mcde(drm);
>> +	struct drm_crtc_state *cstate =3D crtc->state;
>
> [Severity: High]
> This isn't a bug introduced by this patch, as it was inherited from the
> simple-kms implementation, but does this newly added line introduce a dat=
a
> race?
>
> In non-blocking commits, the DRM core asynchronously executes the worker
> thread while simultaneously swapping the global state pointers. Reading t=
he
> global crtc->state here instead of fetching the new state from the state
> parameter (e.g. using drm_atomic_get_new_crtc_state()) can race with
> subsequent commits, potentially programming the hardware with mismatched
> states.
>
> [ ... ]
>
>> -static void mcde_display_update(struct drm_simple_display_pipe *pipe,
>> -				struct drm_plane_state *old_pstate)
>> +static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
>> +					    struct drm_atomic_commit *state)
>>  {
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_device *drm =3D crtc->dev;
>> -	struct mcde *mcde =3D to_mcde(drm);
>> -	struct drm_pending_vblank_event *event =3D crtc->state->event;
>> -	struct drm_plane *plane =3D &pipe->plane;
>> +	struct drm_crtc *crtc =3D plane->state->crtc;
>> +	struct drm_device *drm;
>> +	struct mcde *mcde;
>> +	struct drm_pending_vblank_event *event;
>>  	struct drm_plane_state *pstate =3D plane->state;
>>  	struct drm_framebuffer *fb =3D pstate->fb;
>> =20
>> +	if (!crtc)
>> +		return;
>> +
>> +	drm =3D crtc->dev;
>> +	mcde =3D to_mcde(drm);
>> +	event =3D crtc->state->event;
>
> [Severity: High]
> This is a pre-existing issue, but does accessing crtc->state->event here
> continue to expose a time-of-check to time-of-use race?
>
> If a compositor queues multiple rapid non-blocking commits, reading the e=
vent
> from the global state might clear the event belonging to a subsequent com=
mit,
> leaving the later commit's worker with a NULL event and hanging the compo=
sitor
> waiting for a page flip.
>
> [ ... ]
>
>> @@ -1510,11 +1577,30 @@ int mcde_display_init(struct drm_device *drm)
>>  	if (ret)
>>  		return ret;
>> =20
>> -	ret =3D drm_simple_display_pipe_init(drm, &mcde->pipe,
>> -					   &mcde_display_funcs,
>> -					   formats, ARRAY_SIZE(formats),
>> -					   NULL,
>> -					   mcde->connector);
>> +	ret =3D drm_universal_plane_init(drm, &mcde->plane, 0,
>> +				       &mcde_plane_funcs,
>> +				       formats, ARRAY_SIZE(formats),
>> +				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drm_plane_helper_add(&mcde->plane, &mcde_plane_helper_funcs);
>> +
>> +	ret =3D drm_crtc_init_with_planes(drm, &mcde->crtc, &mcde->plane,
>> +					NULL, &mcde_crtc_funcs, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	drm_crtc_helper_add(&mcde->crtc, &mcde_crtc_helper_funcs);
>> +
>> +	ret =3D drm_encoder_init(drm, &mcde->encoder, &mcde_encoder_funcs,
>> +			       DRM_MODE_ENCODER_NONE, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mcde->encoder.possible_crtcs =3D drm_crtc_mask(&mcde->crtc);
>> +
>> +	ret =3D drm_connector_attach_encoder(mcde->connector, &mcde->encoder);
>
> [Severity: Critical]
> Will this lead to a NULL pointer dereference during probe?
>
> mcde->connector appears to be a zero-initialized struct member that is no=
t
> allocated or populated prior to this call. Because
> drm_connector_attach_encoder() unconditionally dereferences the connector
> argument, passing it a NULL pointer will lead to an immediate kernel oops=
.

Will drop drm_connector_attach_encoder() as mcde->connector is not used.
