Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF3CCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E21410EC63;
	Mon, 12 Oct 2026 04:35:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5272A10E6DE;
 Mon, 12 Oct 2026 04:35:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A562414CB;
 Mon, 12 Oct 2026 04:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D91F0089B;
 Mon, 12 Oct 2026 04:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779743;
 bh=i/06CbasgK72sVZ7um1iuJIv3RvrAyrF5q4McKOOV84=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koooFfsI2FZaCdKiFvOtHECCCvbDU+9u/JJvu/dbZbVfOvXkM/gRmfDvRaJcDfnC+
 u/ZHwDK+BIbKz2DZLdSnJaycx1h1x3V6ZGTKePz/RmvYpQ6cUhZvA1nBFGlVZ3PwBq
 RgzxBretguGkWvDvj4OcDpVZX24sYRMhmR1H/P8ufCOzSHfnG75m6ajFydaCyKQNVr
 Yi/4HG4sXsuSVSavPkIlf4LNYD9C390Lj3Qbz12FRvGfW61h0ewWrmyrhpGZ04X7t2
 9ys/j3d1fRGTwFb9aSreugDFqWgTS1Ml4ASHw3cWVDhTTCaVQb+lW0Sn0oiapnmLZk
 XBOgikKSj9XQA==
Message-ID: <sashiko-outbox-167613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/56] drm/i915/ddi: Update Transcoder/DDI registers
 with the frl bits
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-9-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-9-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:35:42 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/i915/ddi: RMW race on XELPDP_PORT_BUF_CTL1 drops concurrent up=
dates
--

commit b719c1e4da553224ed64e6f2c9076a3b63adb0c1
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/ddi: Update Transcoder/DDI registers with the frl bits

This commit updates the Transcoder and DDI/PORT registers for HDMI FRL mode.
It sets the lane count, FRL shifter enable, and data width bits in both the
DDI_BUF_CTL and PORT_BUF_CTL registers.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index a46ab5d3d70fc..576e667746782 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3121,12 +3121,20 @@ static void intel_ddi_buf_disable(struct intel_en=
coder *encoder,
>  {
>  	struct intel_display *display =3D to_intel_display(encoder);
>  	enum port port =3D encoder->port;
> +	u32 val;
> =20
>  	intel_de_rmw(display, DDI_BUF_CTL(port), DDI_BUF_CTL_ENABLE, 0);
> =20
>  	if (DISPLAY_VER(display) >=3D 14)
>  		intel_wait_ddi_buf_idle(display, port);
> =20
> +	/* Clear PORT_BUF_CTL HDMI FRL Shifter Enable to 0 */
> +	if (crtc_state->frl.enable) {
> +		val =3D intel_de_read(display, XELPDP_PORT_BUF_CTL1(display, port));
> +		intel_de_write(display, XELPDP_PORT_BUF_CTL1(display, port),
> +			       val & ~XELPDP_PORT_HDMI_FRL_SHFTR_EN);

[Severity: High]
Can this manual read-modify-write sequence race with concurrent register
updates?

Looking at intel_ddi_buf_disable(), the sequence uses intel_de_read() follo=
wed
by intel_de_write() to clear the XELPDP_PORT_HDMI_FRL_SHFTR_EN bit in the
XELPDP_PORT_BUF_CTL1 register.

Because this manual sequence drops the uncore spinlock and DMC wakelock
between the read and the write, it creates a window where asynchronous Type=
-C
hotplug workers in intel_tc.c might concurrently modify shared bits in the
same register, such as XELPDP_TCSS_POWER_REQUEST or XELPDP_TC_PHY_OWNERSHIP.

Any concurrent update by a TC worker or another intel_de_rmw() operation
during this window could be permanently overwritten and lost by the subsequ=
ent
intel_de_write(), leading to potential display or Type-C PHY state corrupti=
on.

Should this use intel_de_rmw() instead to guarantee atomicity and continuity
of the uncore lock and DMC wakelock?

> +	}
> +
>  	mtl_ddi_disable_d2d(encoder);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D8
