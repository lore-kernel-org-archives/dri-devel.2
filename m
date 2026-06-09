Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00ECD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC0110E21D;
	Tue,  9 Jun 2026 10:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tb5PWmiG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629B510E21D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:09:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4BD360172;
 Tue,  9 Jun 2026 10:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452091F00893;
 Tue,  9 Jun 2026 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999744;
 bh=UTULqAeQamY6Bc1kW8MSZYHR0Nr/KQgY9ck0IyzLqOo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tb5PWmiGU5CZQHH2v7hAq23yL6hFRX8oI0G0kB51gNE3+3dFBY45s6/TBf2G/T7CR
 Em2nVjKOo+Gugj22ViW06QQrRPAO0VUUi9ZIIcgKPghb8WESiBzDieKYSSVCVuaKB0
 SjA2LkEnoXscGB4aQQsMXbk8yLQ+KJbV74qcqYQC3WztlIMLao69ISzLhOTbEDKhBQ
 8NWa0N3wt4MD6/s2ZF4+Hz+xuAw6dHCXSp+qo09+1cjdQhOMYnPJszYAtsW7tHjSUY
 oZbPUefXyBTtX1SZT40aJJbreoP6R4qRL9nLzMpp7koPs2tVIDKye2dbRs/vjaK6Uy
 4jcwprk0Yi+JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/15] drm/msm/dp: make bridge helpers use dp_display
 to allow re-use
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-13-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-13-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:09:03 +0000
Message-Id: <20260609100904.452091F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Hardcoded base encoder in `msm_dp_display_atomic_enable` breaks MS=
T reuse
- [Low] Kernel-doc mismatch for `msm_dp_display_mode_valid`

Pre-existing issues:
- [High] `msm_dp_display_mode_valid` ignores the `info` parameter, validati=
ng against the wrong sink in MST
--

commit 79702b8fc2a6d1a516b0d64051edab10a8d7764e
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: make bridge helpers use dp_display to allow re-use

This commit modifies the DP bridge helpers to directly take the dp_display
object rather than a drm_bridge pointer. This refactoring is intended to
allow the MST bridge to reuse the same helpers.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index f1970e6dd7e46..cdb7dd4cd7cbd 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -738,24 +738,21 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp)
> =20
>  /**
>   * msm_dp_bridge_mode_valid - callback to determine if specified mode is=
 valid
> - * @bridge: Pointer to drm bridge structure
> + * @dp: Pointer to dp display structure
>   * @info: display info
>   * @mode: Pointer to drm mode structure
>   * Returns: Validity status for specified mode
>   */

[Severity: Low]
This isn't a bug, but there is a mismatch in the documentation. The
kernel-doc still refers to the old function name msm_dp_bridge_mode_valid,
while the function was renamed to msm_dp_display_mode_valid.

> -enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
> -					  const struct drm_display_info *info,
> -					  const struct drm_display_mode *mode)
> +enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
> +					       const struct drm_display_info *info,
> +					       const struct drm_display_mode *mode)

[Severity: High]
This is a pre-existing issue, but since these helpers are being exposed for
MST bridge reuse, does it cause problems that the info parameter is ignored?

Inside msm_dp_display_mode_valid(), the code checks capabilities against
dp->connector->display_info instead of using the provided info parameter:

	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
	     msm_dp_display->panel->vsc_sdp_supported) ||
	     msm_dp_wide_bus_available(dp))
		mode_pclk_khz /=3D 2;

If this is used for an MST stream, won't this validate the mode against the
main DP connector's capabilities rather than the specific MST sink's
capabilities?

[ ... ]

> @@ -1406,11 +1403,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_disp=
lay, struct drm_device *dev,
>  	return 0;
>  }
> =20
> -void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> -				 struct drm_atomic_commit *state)
> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
> +				  struct drm_atomic_commit *state)
>  {
> -	struct msm_dp_bridge *msm_dp_bridge =3D to_dp_bridge(drm_bridge);
> -	struct msm_dp *msm_dp_display =3D msm_dp_bridge->msm_dp_display;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *crtc_state;
>  	int rc =3D 0;
> @@ -1419,7 +1414,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge =
*drm_bridge,
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
>  	crtc =3D drm_atomic_get_new_crtc_for_encoder(state,
> -						   drm_bridge->encoder);
> +						   msm_dp_display->bridge->encoder);

[Severity: High]
Will this hardcoded encoder lookup break MST support?

In an MST topology, each stream operates through its own distinct virtual
drm_bridge and drm_encoder. By hardcoding msm_dp_display->bridge->encoder
here, the primary DP encoder is used instead of the encoder for the specific
bridge being updated.

If the primary encoder isn't participating in the MST stream's atomic commi=
t,
won't drm_atomic_get_new_crtc_for_encoder() return NULL and cause the
helper to bail out silently without programming the mode?

>  	if (!crtc)
>  		return;
>  	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D13
