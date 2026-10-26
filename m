Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FEB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyZeAlHm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D889110E4FB;
	Mon, 26 Oct 2026 07:17:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69F210E4D4;
 Mon, 26 Oct 2026 07:16:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92238438BB;
 Mon, 26 Oct 2026 07:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A631F01825;
 Mon, 26 Oct 2026 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999014;
 bh=hSbhNpatzEnO4hwtFbBU7aRdCQ03TrbKNZMM1lLw85A=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=gyZeAlHmzO6/lbTX0qdxWanb53yYatpweL58QSR+/yTzuu79I1JPoYOd3/4sghZyn
 f73NnDV5UUmZn356nZqtejgAHhSlzDzXnWapSZwKb7h/S7WU31JyRJgXm7l7LrkZdE
 2mPX1aZVDT7peqlIMAEXz3L+La1w2KbKu5BhdiXrY/Aghtd4jpfmonZF1tfrWid5/o
 tuDsgpdKTcEAGIeaRHpAqqWHhhg1VRerTBhhIrBDC5lOPrkL5XssLYdQ6V0t0Hxvat
 DspNzYmUuasAxfNogmpVqktIOsXkRR6CW7MW7L9oqBHFVKL0sTobwjTB8Hx/s/LE0D
 eRY5Fq2rNSQxg==
Message-ID: <sashiko-outbox-184653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/20] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
To: "Animesh Manna" <animesh.manna@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026054001.799894-17-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-17-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:16:53 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915/alpm: uninitialized mutex lock in intel_alpm_lobf_disable=
()
--

commit 3691f816d97c5d3f84209f1900c4bc02406c352b
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: Replace is_edp() with alpm_is_possible()

This commit introduces intel_alpm_is_possible() to check ALPM capability
from DPCD and LTTPR info instead of checking intel_dp_is_edp() in
intel_alpm_lobf_compute_config(). It also removes the intel_dp_is_edp()
checks from intel_alpm_lobf_enable() and intel_alpm_lobf_disable().

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 4e761022485d7..205f1ae10d431 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c

[ ... ]

> @@ -829,9 +848,6 @@ void intel_alpm_lobf_disable(const struct intel_crtc_=
state *new_crtc_state)
> =20
>  		intel_dp =3D enc_to_intel_dp(encoder);
> =20
> -		if (!intel_dp_is_edp(intel_dp))
> -			continue;
> -
>  		mutex_lock(&intel_dp->alpm.lock);
>  		intel_de_write(display, ALPM_CTL(display, cpu_transcoder), 0);
>  		drm_dbg_kms(display->drm, "Link off between frames (LOBF) disabled\n");

[Severity: High]
Can removing the intel_dp_is_edp() check in intel_alpm_lobf_disable() cause
mutex_lock(&intel_dp->alpm.lock) to be called on an uninitialized mutex?

In drivers/gpu/drm/i915/display/intel_alpm.c, intel_alpm_init() only
initializes alpm.lock when intel_alpm_source_supported(intel_dp) is true:

void intel_alpm_init(struct intel_dp *intel_dp)
{
	if (!intel_alpm_source_supported(intel_dp))
		return;

	mutex_init(&intel_dp->alpm.lock);
}

On platforms with DISPLAY_VER between 20 and 34, intel_alpm_source_supporte=
d()
is only true for eDP encoders, so non-eDP DP encoders leave alpm.lock
uninitialized.

In drivers/gpu/drm/i915/display/intel_display.c, intel_pre_plane_update()
checks whether LOBF is being disabled via intel_crtc_lobf_disabling(), which
inspects old_crtc_state->has_lobf, but then passes new_crtc_state to
intel_alpm_lobf_disable():

	if (intel_crtc_lobf_disabling(old_crtc_state, new_crtc_state))
		intel_alpm_lobf_disable(new_crtc_state);

If a CRTC with LOBF active on an eDP encoder (old_crtc_state->has_lobf is
true) is switched in an atomic modeset to a non-eDP DP encoder
(new_crtc_state->has_lobf is false), intel_alpm_lobf_disable() iterates over
new_crtc_state->uapi.encoder_mask and calls mutex_lock(&intel_dp->alpm.lock)
on the non-eDP encoder whose mutex was never initialized.

Additionally, because intel_alpm_lobf_disable() inspects new_crtc_state
rather than old_crtc_state, disabling a CRTC by detaching its connector
(leaving new_crtc_state->uapi.encoder_mask empty) skips the loop and leaves
ALPM_CTL enabled, or on DISPLAY_VER >=3D 35 locks the new encoder's alpm.lo=
ck
instead of the old encoder's.

Should intel_pre_plane_update() pass old_crtc_state to
intel_alpm_lobf_disable(const struct intel_crtc_state *old_crtc_state) so it
operates on the encoder and transcoder where LOBF was previously enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026054001.7998=
94-1-animesh.manna@intel.com?part=3D16
