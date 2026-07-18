Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B481C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7DD10E243;
	Sat, 18 Jul 2026 18:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKXwf8Nk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PA5AZzSF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DB410E243
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:50:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGP9AK1130389
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /gWE/9u3scX7ScXyAJclC+r8DI0Ef3P6oFbYgHHIYls=; b=mKXwf8NkU1im2WKa
 jEQwtcVRi4W7XR96v6m6GEHgwMtRoBm4GvPICdJql7fuzZENJqhFuS/E3xRaZpj5
 +4/S2QFS/Q1bZ1qM0VTTAS/qMpeW2KXgeztZfzyuk+J9ZAfl+dGK26Dd4jTGAzgI
 PObONNXJpsPcJM3hAjkqgcD4uxf+NqufSeWaZ8cvhGCcokeVjSjihZQT7LknhZEF
 qYcmJJe/uu5Tw98gXdEZX3MxSvrcakyPX8vS1Y5wgQUW+A6Po+TjO0JjMoRx4u1g
 DZVmNOvqwcaa6j2DiKzBZuW+E1F2omo2t7LGfVWhSh/fer0K5oCIIoYbKyHIxxfJ
 ZPsM3Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04r8pp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:50:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de0739ab6so6426101a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784400648; x=1785005448;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/gWE/9u3scX7ScXyAJclC+r8DI0Ef3P6oFbYgHHIYls=;
 b=PA5AZzSFApEewi6tWbpOLm2J/srqwYBeCmRIHvYkO74Dk4UOM/UGUBgUGr95C/K6QA
 VdChrsxJKmbwJl61UUZPggPtOvPBmEP7oZ7DYoYcwe6OkTcOJ7tOZIQ+YoCJbenvNSjD
 hKPcP/UUwv2flZJxK7tnh8pjM1glW6vKVwR4Ew4wSlzI83FuquNxf9lWmh4tg9CUQMNC
 y6JFafGcy3dQM1Z0qHlVLLjhfkGgS5V+nzmjU8jpKI8MK2XgZH73wuNHcNXjsdk632+N
 GkMW7LUhRmNTFUnTHlRrCDGzb6vpcgyH5LQsaafVljJZy/GzC4CR4jld2ubyx+dkKsAK
 mnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784400648; x=1785005448;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/gWE/9u3scX7ScXyAJclC+r8DI0Ef3P6oFbYgHHIYls=;
 b=YW2YcSlszRWTrP31ZmYn4MvSAKDo8uReyp9tcQi/fctL8rvi8y56cqtZK/kfpwZjdA
 0hin8k9edP5hcAPFxsQQplwFXBZ6kv5tEAssB6/iCohPp/Splx8bhzwzpGnbG7+ffYfU
 pMFsfBi+LkqqFK4NhOgR6FDL2othJIMvqFlGuDqvnr6nEiqm3ftgVYpP12BhsqkRpFni
 4nrmi2OjyeAhFhuf9YL6P2SmmV9CLRj73qRLI3OT41lzlpXTtfR2J56HU3V5xVZLaawF
 QJdvSm5H/Yh2ojjpG0cg81kY8MIfbU6Yec+GyMfZhpHcGxAZK/UXWJrK/rymZqrtC6E4
 rr+g==
X-Gm-Message-State: AOJu0Yxm5KoWKnYt/TlFjMuOBeTzto5avrSPHSPmGwyyRwEpwR7JvVa+
 TwdD5Gazfw/pcxBDv0OxlyHa5nlSDGjCEMrkqCyQu4fdW6bcTCtUwTN1gh0SYI27tjA3B5+XgBh
 1rzZZr8G8ItiJZP60jIlriZSo45O2rjkLi97+G9hfnlQGjrZxM26SsJHpT8Ic9pcrUAC4tEw=
X-Gm-Gg: AfdE7cmV5glS3Mt+sJKrFLNULwJ/TgeoJZCamjLEtVs2BhAihlGCnX1L6eSsTu+c5aq
 6EwaOP2HTK/JrLb+G/U/Qk4DV2kYgzGMq0+KcxopYquWuNXSFdssl8Xwi/xtU02u3aQrmrQLYzN
 dgh84Fi+ffXVmXgQyDc9gHVp0jRl4gSnpA+SlCrAdseegaT23vCPIqAN7KWpQRCyKuy+STStkgn
 /a1ijsnlTQDeEZCZX8zZDKo1r32sx7qYPYx77DIrEyjJG+t4Fv4Ik80inKGnuoZpu9x4nGbzSFT
 HtBebPaXHBilOWbSMGGfMwfx+DQEaBPMZ6H14EXQXNIk55hzLgjfL/OgbzIIABybxu6isntIs8Z
 DaCDP6g==
X-Received: by 2002:a17:90b:4a8c:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38e4b43c580mr8900795a91.2.1784400647532; 
 Sat, 18 Jul 2026 11:50:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8c:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38e4b43c580mr8900747a91.2.1784400647041; 
 Sat, 18 Jul 2026 11:50:47 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2ddfb35sm16761689c88.14.2026.07.18.11.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 11:50:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 02:50:41 +0800
Message-Id: <DK1X8I3XU0ZV.35WU5KISIRV14@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <Frank.Li@kernel.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 8/8] drm/xen: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-8-1133a8fc3785@oss.qualcomm.com>
 <20260716092822.8E0941F000E9@smtp.kernel.org>
In-Reply-To: <20260716092822.8E0941F000E9@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5bcb08 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2wNEMWLOeZIxy7tF4AQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE5NyBTYWx0ZWRfXzsMgzncPyF9j
 o5ldDyCAtY8RzTOKXIGvKIEpo6yerhe2n5h+LhGT51bshmVpfKXRhmtl5n2sYUg1ppAvbEmKwFr
 3u+NxynELsVB4V3xWztdbLZ+Uk4GIPOXtF0eaJPDPbkaYI4ZxlyMXLAGooxYwRlq43mrgyxXUa/
 ejXnHOAq/UkBT8zbrJWRXtpSF8HXH3qMAdGLfxFqhUaOLgsp7nsy3FV0iCz5bk5riFzY83LiBrY
 gvK/vTdbgEfb50NzTINXE2kE/FnBEo1WPJLjkexT9d4t7ek5UIAdmw5FwYD4156YZ2D1STsbsqX
 6ch4eHD6lJ9aTznJIvvGl1/0M2aBEVxF+GUq/hdMxQWRLdVIMYsKWaBG7E1Ewh5aRD1dj28r/RK
 pVsW/2f36eYWiqhri5IgoviWzmGfvyOf+fdxeQngoAusFxqwWXwn7LL9LRP82E3xIwMB6uSdTO1
 ZkP8ST7z2MBaqfuZ9ZQ==
X-Proofpoint-ORIG-GUID: Fb2RU2uUvrXyUAg5flKI6RtIxadGxOR_
X-Proofpoint-GUID: Fb2RU2uUvrXyUAg5flKI6RtIxadGxOR_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE5NyBTYWx0ZWRfX1q3r2P5wFNoY
 X4Zv7zfou3yUm6LJw0FJ158gWBexGpS3LusBka3a0LaOLXPTfccmWaa9BK2aT2XVgpCvFB0w/Nv
 Qt1pz2epkouuo26bOmvjllLtcGzkkxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180197
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

On Thu Jul 16, 2026 at 5:28 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [Critical] Global state data race in `atomic_enable` leading to a NULL =
pointer dereference.
> - [High] Pending vblank events are leaked when the CRTC is disabled, caus=
ing userspace to hang.
>
> Pre-existing issues:
> - [High] Global state data race in `atomic_update` causing stolen events =
and userspace hangs.
> --
>
> --- Patch [8]: [PATCH v2 8/8] drm/xen: replace struct drm_simple_display_=
pipe with regular atomic helpers ---
> commit 545da3a98a8e32db9ed9bc44680620afafb3b601
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/xen: replace struct drm_simple_display_pipe with regular atomic helpe=
rs
>
> Replace Xen frontend simple display pipe with explicit plane, CRTC and
> encoder objects for each pipeline.
>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/x=
en/xen_drm_front_kms.c
>> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> @@ -105,24 +111,21 @@ static void send_pending_event(struct xen_drm_fron=
t_drm_pipeline *pipeline)
>>  	spin_unlock_irqrestore(&dev->event_lock, flags);
>>  }
>> =20
>> -static void display_enable(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_crtc_state *crtc_state,
>> -			   struct drm_plane_state *plane_state)
>> +static void xen_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					      struct drm_atomic_commit *commit)
>>  {
>> -	struct xen_drm_front_drm_pipeline *pipeline =3D
>> -			to_xen_drm_pipeline(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_=
crtc(crtc);
>> +	struct drm_plane_state *plane_state =3D pipeline->plane.state;
>> +	struct drm_framebuffer *fb =3D plane_state->fb;
>>  	int ret, idx;
>> =20
>> -	if (!drm_dev_enter(pipe->crtc.dev, &idx))
>> +	if (!drm_dev_enter(crtc->dev, &idx))
>>  		return;
>> =20
>>  	ret =3D xen_drm_front_mode_set(pipeline, crtc->x, crtc->y,
>>  				     fb->width, fb->height,
>
> [Severity: Critical]
> Can this sequence cause a NULL pointer dereference?
>
> In xen_drm_crtc_helper_atomic_enable(), the global plane state is
> read asynchronously and fb is dereferenced directly.
>
> If userspace submits two non-blocking atomic commits rapidly (the
> first enabling the CRTC and plane, and the second disabling the plane),
> the global state pointer (pipeline->plane.state) is swapped
> synchronously during the ioctl.
>
> When the first commit's worker executes, it reads the newer state where
> fb is NULL, and unconditionally dereferences fb->width.
>
> Would it be safer to extract the state from the commit object using
> drm_atomic_get_new_plane_state(commit, &pipeline->plane)?

As replied in patch 5, will do

>
>>  				     fb->format->cpp[0] * 8,
>>  				     xen_drm_front_fb_to_cookie(fb));
>> -
>>  	if (ret) {
>>  		DRM_ERROR("Failed to enable display: %d\n", ret);
>
> [ ... ]
>
>> @@ -131,13 +134,13 @@ static void display_enable(struct drm_simple_displ=
ay_pipe *pipe,
>>  	drm_dev_exit(idx);
>>  }
>> =20
>> -static void display_disable(struct drm_simple_display_pipe *pipe)
>> +static void xen_drm_crtc_helper_atomic_disable(struct drm_crtc *crtc,
>> +					       struct drm_atomic_commit *commit)
>>  {
>> -	struct xen_drm_front_drm_pipeline *pipeline =3D
>> -			to_xen_drm_pipeline(pipe);
>> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_=
crtc(crtc);
>>  	int ret =3D 0, idx;
>> =20
>> -	if (drm_dev_enter(pipe->crtc.dev, &idx)) {
>> +	if (drm_dev_enter(crtc->dev, &idx)) {
>>  		ret =3D xen_drm_front_mode_set(pipeline, 0, 0, 0, 0, 0,
>>  					     xen_drm_front_fb_to_cookie(NULL));
>>  		drm_dev_exit(idx);
>> @@ -147,6 +150,11 @@ static void display_disable(struct drm_simple_displ=
ay_pipe *pipe)
>> =20
>>  	/* Make sure we can restart with enabled connector next time */
>>  	pipeline->conn_connected =3D true;
>> +
>> +	/* release stalled event if any */
>> +	send_pending_event(pipeline);
>> +}
>
> [Severity: High]
> Does this function leak the vblank event when the CRTC is disabled?
>
> When moving away from drm_simple_kms_helper, the driver loses the core
> helper's automatic consumption of crtc_state->event during CRTC
> disable.
>
> If userspace submits an atomic commit that disables the CRTC and
> requests a vblank event (e.g., modeset to 0 or DPMS off),
> xen_drm_crtc_helper_atomic_disable() completely omits the consumption and
> signaling of the event.
>
> This leaves the event dangling, which causes a kernel warning in the
> commit tail and hangs the userspace compositor indefinitely as it waits
> for the pageflip event.
>
> Should this function pull and signal the event from
> drm_atomic_get_new_crtc_state(commit, crtc)->event?
>

I would like to preserve the original xen frontend behavior here.

> [ ... ]
>
>> @@ -242,12 +261,12 @@ static int display_check(struct drm_simple_display=
_pipe *pipe,
>>  	return 0;
>>  }
>> =20
>> -static void display_update(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_plane_state *old_plane_state)
>> +static void xen_drm_plane_helper_atomic_update(struct drm_plane *plane,
>> +					       struct drm_atomic_commit *commit)
>>  {
>> -	struct xen_drm_front_drm_pipeline *pipeline =3D
>> -			to_xen_drm_pipeline(pipe);
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_s=
tate(commit, plane);
>> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_=
plane(plane);
>> +	struct drm_crtc *crtc =3D &pipeline->crtc;
>>  	struct drm_pending_vblank_event *event;
>>  	int idx;
>
> [Severity: High]
> This is a pre-existing issue, but can this code steal events from
> future commits?
>
> In xen_drm_plane_helper_atomic_update(), the global CRTC state's event
> is accessed directly:
>
> event =3D crtc->state->event;
>
> Since crtc->state is swapped synchronously, it may reflect a future
> commit's state by the time this worker runs. The worker would then steal
> the future commit's event and clear it.
>
> When the future commit's worker runs, it finds no event, while the
> current commit's original event is stranded on its old state object and
> never signaled, resulting in userspace hangs.
>
> Should the event be fetched reliably from the specific commit object
> using drm_atomic_get_new_crtc_state(commit, crtc)->event?

Will access crtc state with drm_atomic_get_new_crtc_state(commit, crtc)
