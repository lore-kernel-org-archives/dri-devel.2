Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AF9C982FC
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3E010E4B0;
	Mon, 21 Sep 2026 07:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aYlXwZBy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F18110E4B0;
 Mon, 21 Sep 2026 07:11:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1DD86021C;
 Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1CB1F000FF;
 Mon, 21 Sep 2026 07:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789974718;
 bh=KOn//5Fx69SvKI9c6/pbJgK9INP9LiA8swqlHSTqmLA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aYlXwZByx4GIaGh9YC0jV8PDdo3TrOIqIbz/ooXlXYv6NUfneKOnR+rCWa5ghHOjS
 JjEUDGuKB9oQcqn4jaB1tDey12p2oTnN/sPEIq965Ik7SEK7msob5LRQKjWQLJrYe8
 10rCgGZFiJSji4HKGPmzwHxItAyGuf30lxqte/mP1oKo7ih2dBMXT3Mv5aNSzGMBPE
 n6ejemLoiM+5DbWIzGbeVX0bYHKdHsLWwXxVcwzCo/DK1BTZ8n+NzNY6Rw2qDnB4uq
 ZIfGVNKyWab2X5ic4yE++Xc4Vn1Kpr8NEPqMENzAD/qzuu0f6PJwpB9yM6y6yRiEyc
 de0x7clSzHG1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: Split i845 and i9xx cursor updates
 into arm/noarm
To: "George Karagounis" <taterraster@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260919173914.111150-1-mail@taterr.org>
References: <20260919173914.111150-1-mail@taterr.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 07:11:57 +0000
Message-Id: <20260921071157.6E1CB1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915: atomic KMS violation and i9xx hardware quirk trigger in =
cursor update
- [Medium] drm/i915: missing CURPOS reprogram during i845 cursor shape chan=
ge
--

commit 80d531685d42e74f0f8ac2b8f9867c83e1f1a6b8
Author: George Karagounis <taterraster@gmail.com>
Date:   Sat Sep 19 17:39:14 2026 +0000

    drm/i915/display: Split i845 and i9xx cursor updates into arm/noarm
   =20
    There was a problem with the i845 and i9xx cursor update functions
    they handled both position updates and control/base/size updates in
    a single armed sequence. This prevented the cursor position from
    being updated asynchronously, which can make the cursor feel laggy
   =20
    To fix this i split the updates into two phases
    1. noarm Calculates and writes the CURPOS register immediately.
    2. arm Calculates and writes CURCNTR, CURBASE, and CURSIZE to
       latch the control and memory updates at vblank

> diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/dr=
m/i915/display/intel_cursor.c
> index 4afd275de86ea..bcf00b78a71b7 100644
> --- a/drivers/gpu/drm/i915/display/intel_cursor.c
> +++ b/drivers/gpu/drm/i915/display/intel_cursor.c
> @@ -271,14 +271,27 @@ static int i845_check_cursor(struct intel_crtc_stat=
e *crtc_state,
>  	return 0;
>  }
> =20
> -/* TODO: split into noarm+arm pair */
> +static void i845_cursor_update_noarm(struct intel_dsb *dsb,
> +				     struct intel_plane *plane,
> +				     const struct intel_crtc_state *crtc_state,
> +				     const struct intel_plane_state *plane_state)
> +{
> +	struct intel_display *display =3D to_intel_display(plane);
> +	u32 pos =3D 0;
> +
> +	if (plane_state && plane_state->uapi.visible)
> +		pos =3D intel_cursor_position(crtc_state, plane_state, false);
> +
> +	intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
> +}
> +

[Severity: High]
Does writing CURPOS in the noarm phase break atomic KMS synchronization?

Writing self-arming registers in the noarm phase can cause visible tearing
when updating the cursor position and image simultaneously.

[ ... ]

>  static void i845_cursor_update_arm(struct intel_dsb *dsb,
>  				   struct intel_plane *plane,
>  				   const struct intel_crtc_state *crtc_state,
>  				   const struct intel_plane_state *plane_state)
>  {
>  	struct intel_display *display =3D to_intel_display(plane);
> -	u32 cntl =3D 0, base =3D 0, pos =3D 0, size =3D 0;
> +	u32 cntl =3D 0, base =3D 0, size =3D 0;

[ ... ]

>  	/* On these chipsets we can only modify the base/size/stride
>  	 * whilst the cursor is disabled.
>  	 */
>  	if (plane->cursor.base !=3D base ||
>  	    plane->cursor.size !=3D size ||
>  	    plane->cursor.cntl !=3D cntl) {
>  		intel_de_write_fw(display, CURCNTR(display, PIPE_A), 0);
>  		intel_de_write_fw(display, CURBASE(display, PIPE_A), base);
>  		intel_de_write_fw(display, CURSIZE(display, PIPE_A), size);
> -		intel_de_write_fw(display, CURPOS(display, PIPE_A), pos);
>  		intel_de_write_fw(display, CURCNTR(display, PIPE_A), cntl);

[Severity: Medium]
Can the hardware lose the cursor position here?

The CURPOS write was removed from this atomic disabled-update sequence.
Updating the cursor base, size, or control on an i845 platform triggers a
temporary disable/enable cycle, and omitting the CURPOS reprogramming while
the cursor is temporarily disabled might cause the position to be lost.

[ ... ]

> +static void i9xx_cursor_update_noarm(struct intel_dsb *dsb,
> +				     struct intel_plane *plane,
> +				     const struct intel_crtc_state *crtc_state,
> +				     const struct intel_plane_state *plane_state)
> +{
> +	struct intel_display *display =3D to_intel_display(plane);
> +	enum pipe pipe =3D plane->pipe;
> +	u32 pos =3D 0;
> +
> +	if (plane_state && plane_state->uapi.visible)
> +		pos =3D intel_cursor_position(crtc_state, plane_state, false);
> +
> +	intel_de_write_dsb(display, dsb, CURPOS(display, pipe), pos);
> +}

[Severity: High]
Does prematurely writing CURPOS trigger the i9xx self-arming quirk?

Because CURCNTR has not yet been written in the arm phase, writing CURPOS
here causes it to arm itself prematurely. It gets canceled later by writes
to CURCNTR during the arm phase, resulting in dropped cursor position
updates.

[ ... ]

>  static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
>  				   struct intel_plane *plane,
>  				   const struct intel_crtc_state *crtc_state,
>  				   const struct intel_plane_state *plane_state)
>  {

[ ... ]

>  	/*
>  	 * On some platforms writing CURCNTR first will also
>  	 * cause CURPOS to be armed by the CURBASE write.
>  	 * Without the CURCNTR write the CURPOS write would
>  	 * arm itself. Thus we always update CURCNTR before
>  	 * CURPOS.
>  	 *
>  	 * On other platforms CURPOS always requires the
>  	 * CURBASE write to arm the update. Additionally
>  	 * a write to any of the cursor register will cancel
>  	 * an already armed cursor update. Thus leaving out
>  	 * the CURBASE write after CURPOS could lead to a
>  	 * cursor that doesn't appear to move, or even change
>  	 * shape. Thus we always write CURBASE.

[Severity: High]
Does the new update sequence violate the documented hardware quirk?

The hardware quirk documentation warns against the exact sequence introduced
by this patch. Since the commit message explicitly states the intent to make
cursor position updates asynchronous, this appears to be a violation of the
atomic KMS design.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919173914.1111=
50-1-mail@taterr.org?part=3D1
