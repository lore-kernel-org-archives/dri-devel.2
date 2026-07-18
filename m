Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683D2C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCB610E19E;
	Sat, 18 Jul 2026 18:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Je3Nto1/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adZLsPyd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173B910E19E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:05:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGPOdn970018
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lj0KthQFjmiFZbaHRNHX9gCpXpklkdkuBiE4u7UUrik=; b=Je3Nto1/82UDhWTB
 LlXPAqggJHP6ka018H7tN9MJVbIYg/bY7tislxhqsZjNP1GJTs0UZzDnB4iswY+8
 DSL6IzetPwBYgLDz0MH4KS2fB3Ga9HVQtFGt2/Ce1H3xKHplXFfTZj3OId+sCGNJ
 UYRJi+v2nmg2B6Hmti/ZldXz0WqJ//3KNRrPwARep5swGFbl7/947zbIj2lKuUBY
 9srp0HBoo5GIO1zYAoaTS2VjdyDSC+yR3MurAzu1+YAokF3jmYFFGWDdBobRlybh
 imDxJ1ZfOHcttLCNRJndgZ9VuLS3sGfjzN0hP+SGWBRhyONPU3NvCNTMkzi/JAhj
 tSZQ3Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvs9eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:05:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so5999190a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784397914; x=1785002714;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lj0KthQFjmiFZbaHRNHX9gCpXpklkdkuBiE4u7UUrik=;
 b=adZLsPydpa9umRCph3AIR4L7b1zupKaWIW2asP+50hGZ15gpGBNgtJ7LVL7RNRvqQD
 tYkRT1pKrYZPqUKV1YZsgqLz5LlUdnXHJ/LVSw3ve6KiyLfigolFhoZh23/PZwIA3hA5
 sV4Hsrl+YlKka13Z0+oqscLigYFS+R7lVEX0Pa8PgNjerpDhymqAhZbvrQotNi++6HSc
 3AcYj67vSG4L7ud2guCD/vY9I+iWVAVohRb0Xr5LiYntcBAp6pNUfHCZFYk9GVydx2Yu
 8oYgeqtTEpcgmuNUWHNnquuRAExmHe6iQtW6pHQujIX9UW08HCQ24BBdnBFzmQLitqj2
 o8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784397914; x=1785002714;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lj0KthQFjmiFZbaHRNHX9gCpXpklkdkuBiE4u7UUrik=;
 b=JvxSiuVKnGSXGENKl5JbZtZZHjQSHBieOIujFxKX0WEa0j1WxH6UxBr4wyBVPH1v2p
 qAM4fstnBWrdvajr4eu+fwxh5+fNJq/u5hBY0XmWEZ09jeNj3HssCpmMCt5WPiMAg8cb
 muq2q6R8QR8BMCemWbKfKmeRrDB07/FRlBPbn1Vly6Te66ZvDaSY1kPdTdAu3xsfL2M5
 nrPAlM1wHxup+EJ9ZT6AGiTuc5i94yiMbIFbGnhk9UhGyT4KBN9pnjh2LZxjZcD6nl/I
 SRuhnqET0s5XAZ0YchIERhtlR7JtWbUb3xLdLmYu2kBkibeaD9crfX66DppmNJwdp+pa
 gJtA==
X-Gm-Message-State: AOJu0YzbaMTgC9WLWWue1oQJPz4kDde52VGt1yRuI2hBEZ8iFRaErNIr
 Ve0bLy1lt+DAUevjRzsvHuaV2ya7BdiSMmTWLYf6qHT7ewgS/snEMKWBzFyeSuBrsTMnHrs8CmK
 6oKeq234wtYpfVIf3KvVqNqO7hInw/jnJ33LdVgE7/6E3zm3jKUWZ3YIJSzZD6Yp3mD1Thdg=
X-Gm-Gg: AfdE7cnpGQs38IX6K0TePa9hRK+21dtY5AoRgJuIiIoKiZcP+s0qfXW9a4HkGU7b1EH
 xGzYglSTVKepBvQWn/BTKUH29zMGZ/zefrRrGQhgPsL2m3OLh2Ru0nJv1hxxtRXA5G8l2fPAR6L
 N4+sx/FTtUuP+aq2YFlHydPujHIbQsX9MMtogAYAfKyn0lJAfwddXcpaD7TDhzO8S3pWUy1Il6r
 lz0NGObIp1oMLm9q6I3q7MDOoqHoydIbAcsenr8ha70raA0Ts1/CT2kkWDsmZyXkFfil/lYr2lW
 aV9YKdMDKDi2CwsLG2qcTlheAOPOVOORR+A5aVN2ksDb1+qxLClYBTkajI10H+4kDN3ADw9rM3g
 Q79rPTA==
X-Received: by 2002:a17:90b:1c8e:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-38e4b410b8bmr8278184a91.14.1784397913589; 
 Sat, 18 Jul 2026 11:05:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8e:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-38e4b410b8bmr8278140a91.14.1784397912961; 
 Sat, 18 Jul 2026 11:05:12 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1de21asm19412321eec.23.2026.07.18.11.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 11:05:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 02:05:07 +0800
Message-Id: <DK1W9M41UF2X.36VEVZJUD1M17@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <Frank.Li@kernel.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 4/8] drm/pl111: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-4-1133a8fc3785@oss.qualcomm.com>
 <20260716092621.D8C091F00A3A@smtp.kernel.org>
In-Reply-To: <20260716092621.D8C091F00A3A@smtp.kernel.org>
X-Proofpoint-GUID: 2YmDWQCy1T9QC0mXwXFUkznEwOSaCI2c
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5bc05a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=QurC80Wvr54F7t3_XBwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE4OSBTYWx0ZWRfX244gPEXlBYj5
 BrelvK9zDAMfsnGxxm59DnbZKGKyrof9jPlMnRNIt9cwxPOk8KsZ07v6OZChKzAD8k5bqnhEfe4
 rdzSl06RXDVno1omNe5d9EQBTbGc/UUbGPyr62TKBJqDqoHA7cQnyKTcy4qtwsPPW25z6ZQC1mL
 9ZFww21ti7aBVK1hX70/37/cn4vtwtHw/48oSWbtRV9Qa0M6VIY4vVZNVB0q6oPIUJU0DIbCGWU
 MmtkHx5KkPN8MJ0zDtd1f3TEGN6XA0ETQJhI4wNtz4cpSOkYqt3dazLoc04V9ta/a6zopIObPXY
 t7/eIfxLuzVlN0EjbIV/zdWM3oM2Ap33AgLUdB3f73b2rL0ZSJ7mVh1JzAG4qu8HGTAhN3TgyL0
 D9Zt+sPg8Qz2upO5yB8MoPdW4b1bIXXUHe3fKEmRfaDBWgLbwQqEvgmWz9ZbGyrfnp9VXmiD/P+
 pW3qAsBt+AOlUPWdUPA==
X-Proofpoint-ORIG-GUID: 2YmDWQCy1T9QC0mXwXFUkznEwOSaCI2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE4OSBTYWx0ZWRfX5SpDNi9L+xte
 UcNo5KlvSyNHlqzTwSrBVA+KftGeMHDRa+Ia0KSHkRZbZ4TLKO5SrpJYpKQZANLY5nKXoQU86Lj
 o+hlFZhqnZNVNrxdDn+AGU3OyY9xTmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180189
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

On Thu Jul 16, 2026 at 5:26 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Pending vblank events are leaked during CRTC disable. The DRM su=
bsystem requires that pending vblank events requested by userspace (e.g., d=
uring a pageflip) are consumed and sent when the CRTC is disabled. In this =
patch, event consumption is implemented in `pl111_crtc_helper_atomic_flush(=
)`. However, the DRM core (`drm_atomic_helper_commit_planes`) only calls `a=
tomic_flush` for active CRTCs. When a CRTC is being disabled, `atomic_flush=
` is skipped, and the event must be consumed in the `atomic_disable` hook. =
`pl111_crtc_helper_atomic_disable()` fails to check for or consume `cstate-=
>event`. As a result, the event is leaked.
> - [High] Unsafe access to global plane state in `pl111_crtc_helper_atomic=
_enable()`. The function retrieves the framebuffer using `priv->plane.state=
->fb` directly instead of using the committed atomic state via `drm_atomic_=
get_new_plane_state()`. In the DRM core, non-blocking atomic commits synchr=
onously swap the global state pointers before the asynchronous commit worke=
rs run. This creates a Time-of-Check to Time-of-Use (TOCTOU) vulnerability.
> - [High] Sleeping functions are called from atomic context. The DRM subsy=
stem guide explicitly defines CRTC `atomic_enable` and `atomic_disable` cal=
lbacks as executing in an atomic context during non-blocking commits, where=
 sleeping is strictly forbidden. However, `pl111_crtc_helper_atomic_enable(=
)` and `pl111_crtc_helper_atomic_disable()` call blocking functions: `clk_p=
repare_enable()`, `clk_disable_unprepare()`, and `msleep(20)`.
> --
>
> --- Patch [4]: [PATCH v2 4/8] drm/pl111: replace struct drm_simple_displa=
y_pipe with regular atomic helpers ---
> commit 07a755e3243c0f70ec87dc33910c7d68aa70590c
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/pl111: replace struct drm_simple_display_pipe with regular atomic hel=
pers
>    =20
> Replace PL111 simple display pipe with explicit plane, CRTC and encoder
> objects. Keep the existing PL111 timing, format and pitch validation, but
> move it into the explicit atomic check paths. Move event handling to the =
CRTC
> commit path.
>
>> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl1=
11/pl111_display.c
>> index 5d10bc5fdf1f6..beb6423d4d439 100644
>> --- a/drivers/gpu/drm/pl111/pl111_display.c
>> +++ b/drivers/gpu/drm/pl111/pl111_display.c
>
> [ ... ]
>
>> @@ -117,16 +137,14 @@ static int pl111_display_check(struct drm_simple_d=
isplay_pipe *pipe,
>> -static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>> -				 struct drm_crtc_state *cstate,
>> -				 struct drm_plane_state *plane_state)
>> +static void pl111_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					    struct drm_atomic_commit *commit)
>>  {
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_plane *plane =3D &pipe->plane;
>>  	struct drm_device *drm =3D crtc->dev;
>>  	struct pl111_drm_dev_private *priv =3D drm->dev_private;
>> +	struct drm_crtc_state *cstate =3D drm_atomic_get_new_crtc_state(commit=
, crtc);
>>  	const struct drm_display_mode *mode =3D &cstate->mode;
>> -	struct drm_framebuffer *fb =3D plane->state->fb;
>> +	struct drm_framebuffer *fb =3D priv->plane.state->fb;
>
> [Severity: High]
> This is a pre-existing issue, but does this direct access to the global p=
lane
> state in pl111_crtc_helper_atomic_enable() introduce a time-of-check to
> time-of-use vulnerability?
>
> By retrieving the framebuffer using priv->plane.state->fb directly instea=
d
> of fetching the committed atomic state via drm_atomic_get_new_plane_state=
(),
> this might race with subsequent commits. If userspace submits a non-block=
ing
> commit to enable the CRTC, followed immediately by another commit that
> disables the primary plane (setting fb to NULL), the global state pointer
> updates to the second commit. When the first commit's asynchronous worker
> executes this function, it could read the new global state where fb is NU=
LL,
> causing a null pointer dereference when accessing fb->format->format.
>

As replied in patch 5, I'll switch to drm_atomic_get_new_plane_state()

>>  	struct drm_connector *connector =3D priv->connector;
>>  	struct drm_bridge *bridge =3D priv->bridge;
>>  	bool grayscale =3D false;
>>  	u32 cntl;
>>  	u32 ppl, hsw, hfp, hbp;
>>  	u32 lpp, vsw, vfp, vbp;
>>  	u32 cpl, tim2;
>>  	int ret;
>> =20
>>  	ret =3D clk_set_rate(priv->clk, mode->clock * 1000);
>>  	if (ret) {
>>  		drm_err(drm,
>>  			"Failed to set pixel clock rate to %d: %d\n",
>>  			mode->clock * 1000, ret);
>>  	}
>> =20
>>  	clk_prepare_enable(priv->clk);
>
> [Severity: High]
> This is a pre-existing issue, but are blocking functions being called fro=
m an
> atomic context here?
>
> The DRM subsystem explicitly defines CRTC atomic_enable and atomic_disabl=
e
> callbacks as executing in an atomic context during non-blocking commits,
> where sleeping is strictly forbidden. However,=20
> pl111_crtc_helper_atomic_enable() calls blocking functions such as=20
> clk_prepare_enable() and msleep(). This might lead to system instability,=
=20
> kernel warnings, or deadlocks.

I think it's a false positive.

>
> [ ... ]
>
>>  	/* The PL110 in Integrator/Versatile does the BGR routing externally *=
/
>>  	if (priv->variant->external_bgr)
>>  		cntl &=3D ~CNTL_BGR;
>> =20
>>  	/* Power sequence: first enable and chill */
>>  	writel(cntl, priv->regs + priv->ctrl);
>> =20
>>  	/*
>>  	 * We expect this delay to stabilize the contrast
>>  	 * voltage Vee as stipulated by the manual
>>  	 */
>>  	msleep(20);
>
> [Severity: High]
> This is a pre-existing issue, but similar to the clk_prepare_enable() cal=
l,
> does calling msleep() in pl111_crtc_helper_atomic_enable() violate the DR=
M
> subsystem guidelines for atomic context execution?
>
> Sleeping from this path could cause warnings or deadlocks during non-bloc=
king
> commits.
>

ditto

> [ ... ]
>
>> @@ -355,9 +373,9 @@ static void pl111_display_enable(struct drm_simple_d=
isplay_pipe *pipe,
>>  		drm_crtc_vblank_on(crtc);
>>  }
>> =20
>> -static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
>> +static void pl111_crtc_helper_atomic_disable(struct drm_crtc *crtc,
>> +					     struct drm_atomic_commit *commit)
>>  {
>
> [Severity: High]
> This is a pre-existing issue, but does pl111_crtc_helper_atomic_disable()=
 leak
> pending vblank events during CRTC disable?
>
> The DRM subsystem requires that pending vblank events requested by usersp=
ace
> (like during a pageflip) are consumed and sent when the CRTC is disabled.=
 In
> this code, event consumption happens in pl111_crtc_helper_atomic_flush().
> However, the DRM core skips atomic_flush() for disabled CRTCs, meaning th=
e
> event must be consumed in the atomic_disable hook.
>
> Since pl111_crtc_helper_atomic_disable() fails to check for or consume
> cstate->event, the event might be leaked. This could trigger a kernel war=
ning
> in drm_atomic_helper_commit_hw_done() and cause the userspace compositor =
to
> hang indefinitely.
>

I don't think this is an issue here.

In drm_atomic_helper_commit_planes(), atomic_flush() is invoked after
atomic_disable(), and it is only skipped for inactive CRTCs when
active_only is set [1]:

    if (active_only && !new_crtc_state->active)
        continue;

    funcs->atomic_flush(crtc, state);

However, in the default helper path active_only is not set [2], so
atomic_flush() should still be called in this case. Because of that, I
don't think an extra event handling path in atomic_disable() is
required here.

[1] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atom=
ic_helper.c#L3055
[2] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atom=
ic_helper.c#L2968

>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>>  	struct drm_device *drm =3D crtc->dev;
>>  	struct pl111_drm_dev_private *priv =3D drm->dev_private;
>>  	u32 cntl;
>
> [ ... ]
>
>>  	/* Power Down */
>>  	cntl =3D readl(priv->regs + priv->ctrl);
>>  	if (cntl & CNTL_LCDPWR) {
>>  		cntl &=3D ~CNTL_LCDPWR;
>>  		writel(cntl, priv->regs + priv->ctrl);
>>  	}
>> =20
>>  	/*
>>  	 * We expect this delay to stabilize the contrast voltage Vee as
>>  	 * stipulated by the manual
>>  	 */
>>  	msleep(20);
>> =20
>>  	if (priv->variant_display_disable)
>>  		priv->variant_display_disable(drm);
>> =20
>>  	/* Disable */
>>  	writel(0, priv->regs + priv->ctrl);
>> =20
>>  	clk_disable_unprepare(priv->clk);
>>  }
>
> [Severity: High]
> This is a pre-existing issue, but does calling msleep() and
> clk_disable_unprepare() in pl111_crtc_helper_atomic_disable() block execu=
tion
> in an atomic context?
>
> Since this callback runs in an atomic context during non-blocking commits=
,
> these blocking calls might lead to system instability or deadlocks.

I think this is a false positive.
