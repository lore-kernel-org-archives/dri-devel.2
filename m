Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ACEC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9638910E559;
	Wed,  9 Sep 2026 16:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nX1U3Gj+";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD80010E559
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:32:30 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1331ce1bso1432505e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788971549; x=1789576349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yG+S01jgDNF6gG2aUjEkOKkHDiymuefIawG26yDnYyI=;
 b=nX1U3Gj+Bff6Oko2mi4Osktn5cYKAkj7Kgy3yZXr6z6g8BAncfqoUoBwC0ZG2hCAXT
 eecVjLURj3uR8IR7jbQziJoxB0UAkp3NFPFFjUwjzzsgtCdmA87mrBFxBwwsP3SkifoP
 bDe0zKO4yZalcZau72YhUKOb0uvt4BHd/HVovF0XYAwVkv3TuGVlLsvCSqBn6GxH9klB
 QKjD1VdDS65DngiQLm8NbJUxLOf3TyuqU3ztLewscB0R0cxQ/+6rBLs3/1G8RgRPH3v+
 KratySELrCkzygDFay5oE0wv9cCcF8vSZ3C4WyLqBHWpIjkczPZRr85Tq5xo8rS1H1pG
 sz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788971549; x=1789576349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yG+S01jgDNF6gG2aUjEkOKkHDiymuefIawG26yDnYyI=;
 b=fyfpbduUJDqgV3vi4S4aYyMI2SUnH/OPqsVIrdEswZ9Nwian/+vXfTVj1fxgMBPFYI
 Cmd8Zk54bso5BXfGDMlRmjnCoI8JX859jzCrGmQmxRk7AUz26q8GyQKoDoEJZwbU+/8t
 Y+84HOPMrJ2G1Lt9E+LlY3pyygKFvBa6LgXUyIQ8KVtE5uxHk8yL5UQY2sEW65jnmxaI
 XUjRBo3NHpvwgv9G79l6skGwMpJSInWpAedG7hgrKpUl6InCuibIu6IWEeH3p5Pi5lD/
 YlIeFtGh4G16/eu499n9gP4VzwZuBbYmWfnuvFgaMt4IUMJy0MGfTxEHbjuK3mzPRS3B
 fIpA==
X-Gm-Message-State: AFuF++n7jr5nsdQJILXnivnqB9ZSdkFkwiDWZVkl7RWB90HA4mlpQBrd
 Y/7NDndBTKB9l4l4ATufXU/F0kgwhkq4aG7YPC0b7vFN65/rNh36sRlsn5D+Oc87
X-Gm-Gg: AYBFou1a8eHRSp3wWPctudjfvJJpDY2PTSFaL/zbLE2R9nUMrL5M9leY5Q//a08UfrX
 nZgK0msT9biapfvywVYcFexcy/Hvq3cnSlBH10sT+45agqNIFxiMrzYyK+XnPlwlJY4T7yIKL5R
 Ni8ZfLAH1m1smJQlL0WBOlXbAj+RXovBI7AOvWG8bMrLgLtKiJ3N1RtfGTG6MPqfzkcvwdL0jYW
 DGT5+VaTDT8ukmnNTCZVynWV+L9P6UG7UXmPv2+Xt41X8/yvRy5bk/PupvyhrXJqpzY3J0jbKVq
 mY0bI89n08zioyJZglgDCVf78BSYRFmlmTVwBeyBHDC7HR/C1b5eUb12zg1kfPyihVKaahKw8DD
 VsZ1zTY69VPBCqfQQOSRC0xuLRRWmokYbQHvJsW+ZMP4/kdFFWUfpmJvDKXSTHnKUIIlvrRqbQU
 Ac4dVY9cgtUX4VAn3qEJKaoMX2jJ3YZa6iETiVfXQM5QA+y000twGd0SrS/xLcBQSmTPdtiZk8E
 9Ax7a1+8rXirKEfTI1znVbLIajSQCooWgXCb7s60w3FWzoKd4G1jMnuEGVzWod6XYWqIem++MNv
 Onjc
X-Received: by 2002:a05:600c:620f:b0:49c:eac2:ddad with SMTP id
 5b1f17b1804b1-49d2570acaemr21422495e9.1.1788971549021; 
 Wed, 09 Sep 2026 09:32:29 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900E58FC5516AABB3E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:e58f:c551:6aab:b3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26bf332esm2604635e9.8.2026.09.09.09.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:32:28 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v2 0/3] drm/dp: shared HDR metadata SDP helper,
 and max bpc for dw-dp
Date: Wed,  9 Sep 2026 18:31:58 +0200
Message-ID: <20260909163206.36409-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is v2 of "drm/bridge: synopsys: dw-dp: Add HDR support" [1], resent
as three patches instead of five.

The two patches that actually enabled HDR output on dw-dp are not here.
They were written on top of Sebastian's "Synopsys DisplayPort Controller
improvements for RK3588" series, and that series has not landed. I
checked rather than assumed: against drm-misc-next they no longer apply,
and every failing hunk sits on context that only exists in that series -
vsc_sdp_nr, audio_sdp_nr, dw_dp_clear_sdp(), the runtime PM conversion
and dw_dp_rockchip_hpd_sw_cfg(). None of those symbols are in mainline.
Holding the rest hostage to that seemed wrong when the first three
patches stand on their own, so they go alone and I will resend the other
two once the dw-dp work is in.

What is left is useful without them:

 1/3 moves i915's private HDR metadata SDP packing into a shared DP
     helper and converts i915 to use it. No functional change; the
     second user follows later. Jani's Ack from v1 is carried over.

 2/3 fixes a real bug: the bridge connector loses its max bpc value on
     connector reset, so a driver that attaches the property gets it
     reset behind userspace's back.

 3/3 attaches the "max bpc" property on dw-dp. To be precise about what
     that does: the property is a limit, not an enabler.
     drm_atomic_connector_check() derives max_bpc from the sink's EDID
     and only clamps it against max_requested_bpc when the property
     exists, so the min() can never raise it. dw-dp's format filter
     therefore already lets its 10 bpc entries through on a sink that
     reports 10 bpc, with no property attached. What the property adds
     is userspace control - the ability to ask for less - and a defined
     upper bound of 10, the deepest entry in dw_dp_output_formats[]. It
     is also the case that motivated 2/3, and a prerequisite for the
     HDR patches that follow later.

Changes in v2:
 - Dropped 4/5 and 5/5; they depend on the dw-dp improvements series
   and no longer apply to drm-misc-next.
 - Retitled the series, since it no longer adds HDR support by itself.
 - Rebased onto drm-misc-next bf63a72ea005. No changes to the code.

One thing worth flagging for 2/3 and 3/3: Cristian's HDMI 2.0 series
removes connector->max_bpc in its patch 71. That series is not in
drm-misc-next either, so these two are correct as they stand today, but
if it lands first I will respin them against whatever replaces that
field. Say the word if you would rather I wait for it.

A note on how this was made, since the patches carry Assisted-by tags.
I work in a pair: I run the board, take the measurements and decide what
goes in; an LLM assistant (Claude, by Anthropic) helps me read the
source, draft the changelogs and re-check my claims against the tree
before I send anything.

What I have not done here is boot-test this exact three-patch series on
hardware. The code is unchanged from v1, whose runtime testing was done
on an Orange Pi 5 Plus running a rockchip-devel kernel that carried the
v9 generation of the dw-dp series, with the patches on top; those runtime
tests were never repeated on plain drm-misc-next. That caveat bites
hardest on 3/3: mainline's dw_dp-rockchip.c is not the file I tested
against. For v2 I have only checked that the patches apply and build-
tested nothing. Say so and I will do a full build and boot test before
you take it.

[1] https://lore.kernel.org/all/20260808095749.9428-1-royalnet026@gmail.com/

Igor Paunovic (3):
  drm/dp: Add drm_dp_hdr_metadata_infoframe_sdp_pack()
  drm/display: bridge-connector: Preserve max bpc across connector reset
  drm/rockchip: dw_dp: Attach "max bpc" connector property

 drivers/gpu/drm/display/drm_bridge_connector.c |  6 +-
 drivers/gpu/drm/display/drm_dp_helper.c        | 88 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c                |  5 ++
 drivers/gpu/drm/i915/display/intel_dp.c        | 84 +-----------------------
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c      | 26 ++++++++
 include/drm/display/drm_dp_helper.h            |  4 ++
 6 files changed, 131 insertions(+), 82 deletions(-)

base-commit: bf63a72ea005d5e1cc12a9ad5e228c4b44246b0f
