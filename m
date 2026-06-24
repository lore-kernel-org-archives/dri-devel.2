Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF5CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E310910E0DB;
	Wed, 24 Jun 2026 17:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkqd9nry";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2F610E0DB
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:38:13 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-9672199c9ddso831377241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782322692; cv=none;
 d=google.com; s=arc-20240605;
 b=Nm730179Vg9YQxdx1J3BoOxfTVtoDloGOcpaGRDh79BJr8phYTFzEAkBwksAJyiun7
 dCBNQy522DeWs+kwcqJbwjY92aXygRGJLTgev7Kqv68iQXmh54PWmnvT9rFfUYtKbCr9
 UXs7Zf2984lbvw0xgegEJwEGFjRXOapiNfm0PgIjRzeT0dgDn7IegmejKqDxfIhBBgtk
 kuaf6wUpfZP0U0agtk76GFjqdEWzZCBSyTSPIgVmbYTbVNRx/QnY+gYQcS+87ug8wzgO
 dONnqLTsPoEg0QjMDxsHmXdKFuFXgMjrhptun9VYN+ZAAFOivhln+jPsPJ7aOjEHjEHN
 OOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PGoof1hYmqdVrgrC+LgtEv+D9gW718uEXw5l2W6Q4OY=;
 fh=ojRAjbbloC0n9aivNotTIdXmuCaG+zT+EyN/JoqKQXc=;
 b=YIc4zrPzwDzYAJOPY68sMmUofMfbpMAxlMr2UViSMmQZl59KH9vbcT3hyCo4u79lGI
 TkWk5jMR6OkHFMsl7e2yfB+W8QxohYM31quHfQdX/3cKIqhtvee5297AIEE+G1DO7LQ5
 pmdyFDLboCmDC3jMeOSvA1MXg8BKaCkSzExLIM9E10w/j0qSWoZ7fg560kN7TGsnXudk
 436WYxGb8WZ2bFWsJf+O03wJGywvMxgtQ5AsgzUoq+bz02++sdm0A6ERRh9lOyMObUPi
 fK3d3738J/J2czflO1U0oW9+rzxm1r50BACXpy3xzeezn8S68YKQVdh7NWGQu1AewsDf
 5j0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782322692; x=1782927492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGoof1hYmqdVrgrC+LgtEv+D9gW718uEXw5l2W6Q4OY=;
 b=hkqd9nry2gY2sF+RK4R4crh8bt9eiNOKPXmFYxdL/jvX6U12PD1434Cw+Rey3/JXM/
 M0QvIhbG/b9lVNKA7ppiddeO0t0IOeoBDvWW29C/vm6qgciN7LfH8aZarGUaqYYsZovm
 s1ZzIF/nAnPB8nlo0BkWqzlNVpQXPxIdgQHbq6xn4TQg40Wnhobcl9Hj/B86JE3XDwNA
 0uzD7W82l/h9r844kRzX9dH7m7wbnvlp+c9bxKyDacMdhNpLDDubuepyjqbqeUsNZZMF
 R7ZTtrW9CCQw3Ig0vXiRE8VFYvurJdTI17h8tXVGodTNjCBI1UP05vwJFyB9BMybaTar
 wlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322692; x=1782927492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGoof1hYmqdVrgrC+LgtEv+D9gW718uEXw5l2W6Q4OY=;
 b=bxQxynmSaQDYY8lLr9dI8AUBQqWdJJwmqCH+isIUUlIBrr3FHQbitvFGvk+/9mUGmW
 MxUNIySGwPtDU80idsIgYhwo7KYLiySSNqP0EZ4N3vTLGV/vxP4BZ1pE2OK4OdoqX3Lc
 SCCiH4GMiwMiPJZSxVD1P8q3m1vdjHYajzGbXQaETEF/UjQXh5lKoGnemwLfNYMwGhWr
 NDFeww1nLBcUURIZmvYcjt4kVymnoLZ1Hq+kLg2Nkn4deYkuGdbvsaW1dWvQJ9YdgU3F
 e4QO97KZzI4P3e4K8UsN0GxEosLA1cwei5EODLafA8zCeEK68BQSqWxgORCLfft1wWHA
 dQHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoG3zssVZ9ISrtLXkUbOH53XdrlJUc4cNhaGFDtEAVN7Kw80gnxJ4eBTh41VEMzs8aT1UX0gx5NrwI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOO3kyUl3SQeYxWk8cBreWGnPtbQFivAtmArxzUQUTR8JtXRfT
 4JNkPoKkaz8f88huUa+jwNmtGBBI//ji4JG+TGIqsmRkIVSPMAaddJnV7Oxt6pw5Cm/byVoBmPm
 NXve8aff5hWTeT3qp+iMzs0PGXCTbsWM=
X-Gm-Gg: AfdE7cn5hksbTxq+FfPIIG9T7oZTptlF9ItWmyv5pSKfiRFy1qGSh7LbAgHZFPZbKQO
 wKy1MKMuCKsUdvSDLhV8atmgFVBWE2v5DcQ4IBpDDiklInCsvPwi1bg0mhqlJABCXYrvTepudjM
 d37/b52f0kcQHUIY4Cf31DqNfcQKimhQTsiWZ/rruUY6Xbw74DOK1eXeDRVsyXdUiSxkUydlYGU
 Rk7nHAtwoWpl6CC2mVHV+NUqSFTBUCc9Nev4QlyssNkNs/nvNCTZyrPla+5ygwRbAX98RzdoZZg
 Fp7ZVMVBNXpdkX88tApyCSaGcas7HA==
X-Received: by 2002:a05:6102:41a0:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-72fd725ead5mr5246681137.14.1782322692121; Wed, 24 Jun 2026
 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260623023506.309858-1-damon.ding@rock-chips.com>
In-Reply-To: <20260623023506.309858-1-damon.ding@rock-chips.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Wed, 24 Jun 2026 19:38:00 +0200
X-Gm-Features: AVVi8CdFycjd2gVFzJ1Kdrg51k6ZkbagfB_vvpSZQZ7FNh59z9crh8DzhpJ0LEE
Message-ID: <CAAMcf8DL9rbxTYbgKDOsEdDWwxEj7En-BV-m2HR8g8dmksb73A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Fix PE/VS value shift
 mismatch during link training
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 23, 2026 at 4:35=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> VS/PE values returned by drm_dp_get_adjust_request_voltage() and
> drm_dp_get_adjust_request_pre_emphasis() are already encoded to their
> native DPCD register bit positions. However, DPCD_VOLTAGE_SWING_SET /
> DPCD_PRE_EMPHASIS_SET macros perform an extra internal shift. Feeding
> the raw offset-bearing values directly leads to overlapping bitfields
> and invalid lane training configuration, causing link training failures
> and black screen.
>
> Add right shift using DP_TRAIN_*_SHIFT constants to strip the DPCD bit
> offsets before passing values to the SET macros and subsequent checks.
> Apply this fix for both clock recovery and adjust training code paths.
>
> Reported-by: Vicente Bergas <vicencb@gmail.com>
> Closes: https://lore.kernel.org/all/CAAMcf8D-d+5n=3DH44KeKBSqWY42m+o32W+m=
O-r15VqWNyYhJL7Q@mail.gmail.com/
> Fixes: d84b087c7662 ("drm/bridge: analogix_dp: Apply DP helper APIs to ge=
t adjusted voltages and pre-emphasises")
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>
> ---
>
> Changes in v2:
> - Fix the ambiguous descriptions in commit msg.
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 7a85774aaac1..1d39a354c3d9 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -309,7 +309,9 @@ static void analogix_dp_get_adjust_training_lane(stru=
ct analogix_dp_device *dp,
>         lane_count =3D dp->link_train.lane_count;
>         for (lane =3D 0; lane < lane_count; lane++) {
>                 voltage_swing =3D drm_dp_get_adjust_request_voltage(link_=
status, lane);
> +               voltage_swing >>=3D DP_TRAIN_VOLTAGE_SWING_SHIFT;
>                 pre_emphasis =3D drm_dp_get_adjust_request_pre_emphasis(l=
ink_status, lane);
> +               pre_emphasis >>=3D DP_TRAIN_PRE_EMPHASIS_SHIFT;
>                 training_lane =3D DPCD_VOLTAGE_SWING_SET(voltage_swing) |
>                                 DPCD_PRE_EMPHASIS_SET(pre_emphasis);
>
> @@ -355,7 +357,9 @@ static int analogix_dp_process_clock_recovery(struct =
analogix_dp_device *dp)
>         for (lane =3D 0; lane < lane_count; lane++) {
>                 training_lane =3D analogix_dp_get_lane_link_training(dp, =
lane);
>                 voltage_swing =3D drm_dp_get_adjust_request_voltage(link_=
status, lane);
> +               voltage_swing >>=3D DP_TRAIN_VOLTAGE_SWING_SHIFT;
>                 pre_emphasis =3D drm_dp_get_adjust_request_pre_emphasis(l=
ink_status, lane);
> +               pre_emphasis >>=3D DP_TRAIN_PRE_EMPHASIS_SHIFT;
>
>                 if (DPCD_VOLTAGE_SWING_GET(training_lane) =3D=3D voltage_=
swing &&
>                     DPCD_PRE_EMPHASIS_GET(training_lane) =3D=3D pre_empha=
sis)
> --
> 2.34.1

Tested-by: Vicente Bergas

This patch was tested toghether with
[PATCH v1] drm/bridge: analogix_dp: Apply standard DP training delay helper=
s

Regards,
  Vicente.
