Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C879FCA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F8310E496;
	Thu,  8 Oct 2026 13:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PWzeL0x1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1478D10E496
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:35:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77A0F4141D;
 Thu,  8 Oct 2026 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3992F1F000FF;
 Thu,  8 Oct 2026 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791466515;
 bh=7JJq+viT3IaL35KmfiwygZ4Y9fu0UUo3sRNONKolOhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PWzeL0x1mKO9YbCnkSUJWbAVT49aB8GnlifqkH+WDNLtAxvpTsG6Kx4Sjq6vjTfJC
 uH/Y63GEooRcDTep3+PPQFNMXEm2Ea0AYQZ8wotGTOm5e3EOGdVX+adIc5Cd2YkZ6G
 8wwmnxRMXPGnbAmC2VkJoICKTiYf+/oIDI1cJk9Ebg1eYpP2oYLlnt9OulDU3hNdJL
 5EtrPVyrF50qc5XjGsssKkY6blKAu9h8SJpRdl0IqJBtV+F/dlM2Yp6Z8483jKAg/w
 igCxAaNSW0k65mPLTuUyvvIiPjloDl7yG/9udQhnev296vgrAJmaA/TY6oKsbNmqDj
 UAweJjHZgv2pA==
Message-ID: <sashiko-outbox-164219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 9/9] drm/panel: novatek-nt35950: use the atomic
 state to select the mode
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-panel-atomic-state-v1-9-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <20261008-panel-atomic-state-v1-9-b157fddb8de1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:35:14 +0000
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
- [High] drm/panel: atomic_check rejects CRTC disable with MODE_ID=3D0
- [Low] drm/panel: nt35950: unbalanced regulator disable in atomic_prepare =
error path
--

commit bb80efea394ba9e6d61de8428c59d0a3f71bf60e
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/panel: novatek-nt35950: use the atomic state to select the mode

The commit subclasses the panel state to store selected mode parameters
and switches callbacks to their atomic variants so the driver can look
up and validate the mode directly in atomic_check().

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/=
drm/panel/panel-novatek-nt35950.c
> index 94aa6489d99fc..f5161f11b1f5e 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
[ ... ]
> @@ -354,11 +339,43 @@ static int nt35950_sharp_init_vregs(struct nt35950 =
*nt, struct device *dev)
>  	return 0;
>  }
> =20
> -static int nt35950_prepare(struct drm_panel *panel)
> +static int nt35950_atomic_check(struct drm_panel *panel,
> +				struct drm_atomic_commit *commit)
> +{
> +	struct nt35950 *nt =3D to_nt35950(panel);
> +	struct drm_panel_state *panel_state;
> +	struct drm_crtc_state *crtc_state;
> +	int i;
> +
> +	panel_state =3D drm_atomic_get_new_panel_state(commit, panel);
> +	crtc_state =3D drm_atomic_get_new_crtc_state_for_panel(commit, panel);
> +	if (!panel_state || !crtc_state)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < nt->desc->num_modes; i++) {
> +		if (drm_mode_match(&crtc_state->mode,
> +				   &nt->desc->mode_data[i].mode,
> +				   DRM_MODE_MATCH_TIMINGS | DRM_MODE_MATCH_CLOCK)) {
> +			to_nt35950_state(panel_state)->mode_data =3D
> +				&nt->desc->mode_data[i];
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

[Severity: High]
Does this unconditional mode matching loop fail to account for CRTC
disablements?

When a userspace atomic commit sets MODE_ID=3D0 on the CRTC but leaves the
connector's CRTC_ID unchanged (like DPMS off or blanking), `crtc_state->ena=
ble`
is false and `mode` is zeroed. In this scenario, checking the zeroed mode
against valid panel modes will find no match, causing `nt35950_atomic_check=
()`
to erroneously reject valid state commits with -EINVAL, preventing userspace
from disabling the display using standard KMS atomic updates.

> +
> +static int nt35950_atomic_prepare(struct drm_panel *panel,
> +				  struct drm_atomic_commit *commit)
>  {
>  	struct nt35950 *nt =3D to_nt35950(panel);
> +	struct drm_panel_state *panel_state;
>  	int ret;
> =20
> +	panel_state =3D drm_atomic_get_new_panel_state(commit, panel);
> +	if (!panel_state || !to_nt35950_state(panel_state)->mode_data)
> +		return -EINVAL;
> +
>  	ret =3D regulator_enable(nt->vregs[0].consumer);
>  	if (ret)
>  		return ret;
[ ... ]
> @@ -380,7 +397,7 @@ static int nt35950_prepare(struct drm_panel *panel)
> =20
>  	nt35950_reset(nt);
> =20
> -	ret =3D nt35950_on(nt);
> +	ret =3D nt35950_on(nt, to_nt35950_state(panel_state)->mode_data);
> =20
>  end:
>  	if (ret < 0) {

[Severity: Low]
Can this error path cause an unbalanced regulator disable?

In `nt35950_atomic_prepare()`, regulators are enabled one by one, and on
failure, it jumps to the error path here:

    end:
        if (ret < 0) {
            regulator_bulk_disable(ARRAY_SIZE(nt->vregs), nt->vregs);
            return ret;
        }

This error path calls `regulator_bulk_disable()` on all 4 regulators, inclu=
ding
the one that just failed and any subsequent regulators that were never enab=
led,
resulting in unbalanced regulator disables. This triggers warnings and trac=
king
corruption. Additionally, the error path fails to assert the reset GPIO to
power down the panel properly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-panel-atom=
ic-state-v1-0-b157fddb8de1@oss.qualcomm.com?part=3D9
