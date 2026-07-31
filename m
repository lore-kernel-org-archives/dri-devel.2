Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68CFC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0764F10E228;
	Fri, 31 Jul 2026 19:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ic0oH/3l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F2710E228
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 19:20:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0399D40A92;
 Fri, 31 Jul 2026 19:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54001F00AC4;
 Fri, 31 Jul 2026 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785525600;
 bh=NIvYFcOnTHs5LUj/bjZowA8yIeUKukHYedpMECoTgwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ic0oH/3lDaxJqKkCudzS0rpasO3oMdpamyl1WgGQGQiBLYOcbBvD+j+0B2MZozx2h
 +mbSN68jB1E19p66PfLbUieNNs4l1TRUCIA1e0EzLYYPCAakyg6x51mqG7f1OI67yX
 mFJpRVvjk7tmNSC2wv2Zs8cIsg8Z5xzVFLCRj55bNNY8s5O1wgum1N3l+gIWp8SSU7
 /fpbOQbT7HwP7+JevbQbzUthL5FMZ7ShTiMFhI/HHY/2Q2VTU/4QT0HntL8DXqF5QM
 oLi9nmWcoZwuudo3NKaKkrFClueUyWMnwe5/tTGCyyCSE6W3cm2uQ82/U3ytlhnwmw
 flz6BnGRXx5Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 23/69] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-23-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-23-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:20:00 +0000
Message-Id: <20260731192000.A54001F00AC4@smtp.kernel.org>
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
- [High] The HDMI atomic check phase unconditionally sets `scrambler_needed=
` for TMDS character rates > 340 MHz without verifying if the source and si=
nk actually support scrambling, which can cause an ungraceful failure durin=
g the atomic commit phase.
--

--- Patch [23]: [PATCH v10 23/69] drm/display: hdmi-state-helper: Set HDMI =
scrambling requirement ---
commit e6622cfc80adce83ef4209e099003b9cb90bec11
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Set HDMI scrambling requirement

This commit centralizes the HDMI scrambling requirement check in the HDMI s=
tate
helper. It sets drm_connector_hdmi_state.scrambler_needed to true when the
computed TMDS character rate exceeds the HDMI 1.3 maximum limit.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 3377ea9361209..9544eb8659aa8 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -594,6 +594,9 @@ hdmi_compute_clock(const struct drm_connector *connec=
tor,
> =20
>  	conn_state->hdmi.tmds_char_rate =3D clock;
> =20
> +	/* TODO: also check drm_display_info.hdmi.scdc.scrambling.low_rates */
> +	conn_state->hdmi.scrambler_needed =3D (clock > HDMI_1_3_TMDS_CHAR_RATE_=
MAX_HZ);
> +

[Severity: High]
Does this code allow an atomic_check to succeed even when the source or sink
does not actually support scrambling?

In the KMS atomic framework, hardware capabilities must be validated during=
 the
atomic_check phase to prevent failures during atomic_commit. Here, we set
scrambler_needed to true for clocks > 340 MHz, but we don't seem to verify =
if
the sink or the source hardware actually supports scrambling.

If a malformed EDID advertises a high TMDS clock but lacks SCDC scrambling
support, or if a driver supports high clocks but fails to implement the
scrambler hooks, the atomic check phase will pass. Later, when
drm_connector_hdmi_enable_scrambling() is called during the commit phase, it
will evaluate scrambler_needed and return -EINVAL.

Failing during the atomic commit phase violates KMS rules and results in a
broken display pipeline. Should hdmi_compute_clock() or hdmi_clock_valid()
also verify drm_scdc_sink_supports_scrambling() and
drm_connector_hdmi_scrambler_supported() before succeeding?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D23
