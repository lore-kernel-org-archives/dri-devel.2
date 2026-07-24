Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18368C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADE410E082;
	Fri, 24 Jul 2026 18:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BO9JCQuL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14BE610E082
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7B4C41291;
 Fri, 24 Jul 2026 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAE21F000E9;
 Fri, 24 Jul 2026 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784918079;
 bh=2PNwBExVz2anWXXqfRrCVp5X8IWf9pYpKRyr8ctS4vk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BO9JCQuLv2sSaPceSrkOioDonFBKYHQRYeLCNVbkESd+Niuro/tgn1/r9w1TDgwTu
 vH2Yl8vwhyJGJ+2yrZGC3Q/g0AC8Ocje5jRjxwAkYPDJl3jZ7tenIMLG2UNHDMhAZe
 /N1wc4sl1l8zUB8JmRPo8rXhnNlRfOfgiiqR2LsmSACXxcVj9kuHi7t1yRGPE8Eil8
 4stmP5lirQF8Pr4sp3St1sJWFABmGkXih8k6zGK/7Wqb8GafeUv6OIo94+12v/h23p
 3Y9eAR6EAEjjdguk71mfg/Cjdz0QH3x48ADgAvslFMFNnA7nz7MWQ5/OdAd06sG2pI
 SkpbEjJRzl5bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/16] drm/bridge: synopsys: dw-dp: Add audio support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-16-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v6-16-041d99a19c4e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:34:38 +0000
Message-Id: <20260724183439.6CAE21F000E9@smtp.kernel.org>
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
- [High] DRM atomic_disable zeroes the SDP slot allocator bitmap without in=
validating the audio subsystem's active SDP slot (audio_sdp_nr), causing cr=
oss-subsystem races and hardware state corruption.
--

--- Patch [16]: [PATCH v6 16/16] drm/bridge: synopsys: dw-dp: Add audio sup=
port ---
commit 9b3a7d6fa62f20557e06c0ea7d9cc504eddb75d9
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add audio support

Implement audio support for the Synopsys DesignWare DisplayPort
controller.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 44a13b5d62d39..c7d6f63b5e9a1 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1886,6 +1924,212 @@ static void dw_dp_bridge_oob_notify(struct drm_br=
idge *bridge,
[ ... ]
> +static void dw_dp_audio_unprepare(struct drm_bridge *bridge,
> +				  struct drm_connector *connector)
> +{
> +	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +
> +	if (dp->audio_sdp_nr >=3D 0) {
> +		dw_dp_clear_sdp(dp, dp->audio_sdp_nr);
> +		dp->audio_sdp_nr =3D -1;
> +	}

[Severity: High]
Does this leave dp->audio_sdp_nr dangling if the display is disabled while
audio is active?

Looking at dw_dp_bridge_atomic_disable(), the SDP allocation bitmap is
bulk-cleared without resetting the audio subsystem's active SDP slot:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_atomic_disable() {
    ...
    scoped_guard(mutex, &dp->sdp_lock)
        bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
    ...
}

If userspace triggers a display disable, dw_dp_bridge_atomic_disable() zero=
es
the bitmap without resetting dp->audio_sdp_nr. When the display is re-enabl=
ed,
dw_dp_bridge_atomic_enable() might allocate that same slot for a video SDP.

If userspace later stops the audio stream, dw_dp_audio_unprepare() would see
the stale dp->audio_sdp_nr and clear the hardware registers for the newly
allocated video SDP.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v6-0-041d99a19c4e@collabora.com?part=3D16
