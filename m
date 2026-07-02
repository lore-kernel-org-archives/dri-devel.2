Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3DCC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A830D10F451;
	Thu,  2 Jul 2026 15:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cmWn6uhF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2DF10F451
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EBE9601F2;
 Thu,  2 Jul 2026 15:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193371F000E9;
 Thu,  2 Jul 2026 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005242;
 bh=377Jpxk9mNU6QJHsVTbKwM9b/4GKgNikVuV88EP+xuM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cmWn6uhF3BI4/1kb8x3L8TxuGYn5Z7iY03Zef9WZko9VxoNbEbgfGSCAJGZ23QHav
 NOnSTNhGq9ZtqXbRLsZMdq8G82fhsgxzjjXfdxw/MhigRyED/D8xB7eGVoBZmgsPmX
 WEMFxAoJwoPG6RmXNHrdPQiUb7JEboZsm2ee3iM2eO4bgoNzDaO7Axtun1hHkV4yrD
 n8aLzjvDsxHMy7lqOb+q//q9nDA5OuwKGraOWT7E0m+oxC8IXWpCRfcagEMd5LSYC7
 oFy4EtZnO46XzsayJPG6pJ0KHvfq+Am9mV/RKkKoi7Wm+3zZaF2EhHw4gxQ2qAswn9
 EdlyK7gDURjJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/39] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-11-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-11-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:14:01 +0000
Message-Id: <20260702151402.193371F000E9@smtp.kernel.org>
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
- [High] Missing validation of SCDC scrambling capabilities in HDMI atomic =
check, leading to atomic commit failure.
- [Low] Kernel doc for `scrambler_needed` incorrectly claims it considers c=
apabilities.
--

commit 8506d2c44481f513bea9b489debfc6aacfc2b9a2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Set HDMI scrambling requirement
   =20
This commit sets the drm_connector_hdmi_state.scrambler_needed flag when
the computed TMDS character rate exceeds the HDMI 1.3 maximum limit.
By centralizing this clock-based requirement in the HDMI state helper, it
removes the need for drivers to open-code the threshold check.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 69ccfbf123fe3..34e48e04d9712 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -592,6 +592,7 @@ hdmi_compute_clock(const struct drm_connector *connec=
tor,
>  		return -EINVAL;
> =20
>  	conn_state->hdmi.tmds_char_rate =3D clock;
> +	conn_state->hdmi.scrambler_needed =3D (clock > HDMI_1_3_TMDS_CHAR_RATE_=
MAX_HZ);

[Severity: High]
Does this code fail to validate SCDC scrambling capabilities during atomic
check?

Setting scrambler_needed purely based on the clock rate, without validating=
 if
scrambling is actually supported by the sink and source, allows invalid ato=
mic
states to proceed.

If an HDMI sink provides a buggy EDID reporting >=3D 340 MHz but without SC=
DC
scrambling support (or the source lacks scrambling support), a mode requiri=
ng
>340 MHz TMDS rate could be requested.  hdmi_clock_valid() passes because
info->max_tmds_clock doesn't reject it.

Because hdmi_compute_clock() unconditionally sets scrambler_needed =3D true
without checking if scrambling is actually supported by both source and sin=
k,
the atomic_check succeeds.

Then, atomic_commit calls drm_connector_hdmi_enable_scrambling(), which che=
cks
capabilities, finds them lacking, and returns -EINVAL.

Returning an error during the atomic commit phase violates the DRM atomic K=
MS
contract.  This leads to a state where the hardware might be partially
programmed and the driver aborts the commit, which can cause black screens,
driver state desync, or kernel warnings.

[Severity: Low]
Does this change make the kernel documentation for drm_connector_hdmi_state
inaccurate?

In include/drm/drm_connector.h, the kernel doc for scrambler_needed states
it is computed from the capabilities:

include/drm/drm_connector.h:drm_connector_hdmi_state
	/**
	 * @scrambler_needed: Whether HDMI 2.0 SCDC scrambling is required
	 * for the negotiated mode/bpc/format.
	 *
	 * Computed by drm_atomic_helper_connector_hdmi_check() from
	 * @tmds_char_rate and the source/sink scrambling capabilities.

But the implementation now only checks the clock against
HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ, creating a documentation mismatch.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D11
