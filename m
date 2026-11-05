Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160C606D838
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B0qcbkjW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D3E10E48E;
	Thu,  5 Nov 2026 15:52:45 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4756410E48E;
 Thu,  5 Nov 2026 15:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793893952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vm9GaetwlNgsLFvsFO/ZmvQshN8OyGA3xT49PjmygNMZRoceB9uuaQK6zPLFmRqOMoSd2MRx6GqFjdax0VUuVLSo8OTfYT3+XgTluhLcqYaNKmRv2GRNUSAJO8A7vcHZ7PtJlydubI9QyLc13gajma8c5NFIFbmPWRSWH/KwOMc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793893952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=o6F6viGtXT5EjueNMtEut/jZMxT/MCMMWh1OY9AsXAo=; 
 b=BIpBmh6ikQMQZN4v8qei/mt1eTzrc1afVVWQcj3Nw8WK09l9uO3/KNRwkcpKNcaZRGN7rnkFqtw4+kVCjfwUMpe30dvWTBA8SPMt9O9LaxrazOJo6R/AYk6NCu6GJzpofwGInKtHc1SK4TsBRwnuGl6i5o6D2ZUF/Oqkm2fVqmE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=B0qcbkjW3kEvpDJ5a1Z0YHKl22wOf1tAwNop85lU3TSXRyu+nwTt1ia1NdToD7TjwozBqwqzopeyx/FxoyuhZfudcEIEl0D1zkyidlNPagCDHOZXwq5Qh4YxXBJ30w+rrtYcIjXCPbjEEfSE6HnD8E2Rnn0GQg0raBQIqct59YM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=o6F6viGtXT5EjueNMtEut/jZMxT/MCMMWh1OY9AsXAo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793893952288570.7720246815022;
 Thu, 5 Nov 2026 07:52:32 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 00/27] VRR Target Rate Limiter KMS uAPI and Implementation
Date: Thu, 05 Nov 2026 16:51:51 +0100
Message-Id: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOwQ6CMBBEf4Xs2VVaDaae/A/jobSLrgGL20I0h
 n+3gjdPk0lm3swbIglThEPxBqGRI4d7NnpVgLva+4WQffagS12VRhkcRbDljhMJDrZndMaQN9u
 G9l5DrvVCDT9n5Om8+DjUN3Lpy/klhB5D3kpLDGobCV3oMvZQeOkwcb/5KXwhV44pyGu+Oaq5s
 zzS6v/RqLBE3Ti/96VS1a46utC2tg5i13kEztM0fQB+jF0w+QAAAA==
X-Change-ID: 20260919-vrr-limiter-uapi-c99ed93fe7d2
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series defines a proposed new userspace API for specifying frame
rate targets for variable refresh rate (VRR) mechanisms. This includes
specifying both a constrained range in which VRR should operate, as well
as a fixed target, and a new connector property for QMS (Quick Media
Switching) and passive VRR (as in, keeping the display in VRR mode
without doing VRR).

The reason for wanting such an uAPI is mainly to avoid the imperfection
of the real world. By constraining VRR to a limited range or a fixed
point entirely, we get the benefits of judder-free (or low-latency)
presentation for content within an expected range of frame rates,
without dipping into ones that cause visible brightness flicker. The
addition of QMS furthermore allows the connector to signal an upcoming
rate change ahead of time for media playback scenarios, such that
advanced processing algorithms in e.g. TVs don't have to be disabled to
meet the need to be able to present at full rates with no notice.

Aside from the uAPI, there's the EDID parsing and an implementation for
drivers that use the common HDMI state helpers, with it wired up for
Rockchip (tested and developed on RK3588).

The uAPI consists of 4 new CRTC properties for the frame rate
minimum/maximum target, and several new connector properties. Two of the
connector properties are for reporting the display's VRR range to any
client so that they're aware of quirks the kernel chooses to override
the ones in the EDID with, and the third is for explicitly setting a
mode the display should be in (Game, which is default, Off, and Media).

The Media VRR display mode sets HDMI displays to use QMS. Whether or not
a particular display supports QMS can be determined from the EDID, i.e.
the kernel does not act as userspace's EDID parser through a redundant
property for this.

For some background on why the uAPI uses numerator/denominator frame
rate pairs as opposed to frame intervals or microhertz, my slides from
Display Next Hackfest 2026 give an explanation:

https://gitlab.freedesktop.org/-/project/2891/uploads/9db8886701e2598271a8c4c6dc4dc2b1/display_next_hackfest_2026.pdf

In short: for QMS, we have a very limited set of frame rate targets that
signalling is supported for. This includes both rates such as 24 Hz, and
24/1.001 Hz. Making userspace give us a frame rate as a rational
expression rather than as the output of some rounding calculations
spares us the pain and suffering of then having to correctly guess which
frame rate was originally meant as a target with a <0.1% accuracy
requirement.

There is also a set of IGT tests for exercising the new uAPI on actual
hardware:

https://gitlab.freedesktop.org/CounterPillow/igt-gpu-tools/-/tree/vrr-limiter

== Currently known deficiencies as of v2 ==

I've decided to send out a new revision now rather than wait longer, in
order to get more feedback on the approach. There's still some stuff
that isn't quite right or there yet though:

1. The immutable VRR flavour property for userspace isn't in yet, but
   this will be added in the next revision; it's not relevant for the
   general approach.
2. The EMP packet's m_const flag is not generated correctly for QMS.
   Doing more commits skips without making changes to the connector
   state skips the connector check, so it doesn't get updated to tick
   over from m_const=0 to m_const=1 in a QMS tfr change scenario.
3. On my particular hardware, using modes for QMS that require TMDS
   scrambling, with QMS rates that are quite low, results in a black
   picture despite the display entering QMS mode. The IGT test contains
   a workaround for this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Make mode_changed on vrr_enabled change a driver-specific
  consideration, and do it for Rockchip after verifying it's needed
- Move CRTC VRR limiter property attachment to separate function, to be
  invoked by driver
- Invoke aforementioned function in Rockchip VOP2 driver for RK3588
- Validate target range completeness in common CRTC atomic_check code
- Move early hdmi_validate_vrr !vrr_enabled bailout to before state
  re-use check
- Move addition of state re-use check's check for vrr target members to
  the patch that actually implements them (d'oh)
- Make sure old_crtc_state in hdmi_validate_vrr is non-null before
  dereferencing it
- Fix KUnit tests not working unless there was a mode_changed on
  vrr_enabled change by explicitly getting a new connector state in each
  test, refactoring all this out into a small function to call in each
- Use guard macro to acquire and release the modeset lock in KUnit
  tests, fixing a leak of a held lock when tests fail
- Move added edids to drm_kunit_edid.c instead of defining them in the
  header
- Add KUnit tests for limiter range incompleteness
- Deduplicate HDMI VRR EDID parsing with what already landed in drm-tip
  and I rebased across by accident. Includes moving from monitor_range
  to hdmi.vrr_cap.vrr_{min,max}
- Minor doc fix for the aforementioned already landed stuff
- Add vrr_display_min/vrr_display_max connector properties, including
  HDMI helper to set them appropriately
- Add vrr_display_mode property for userspace to explicitly control the
  VRR mode a display is in, in order to avoid blanking. Defaults to
  "Game".
- Enable aforementioned connector properties for Rockchip dw_hdmi_qp
- Change qms_enabled to be just another enum value in vrr_display_mode
- Get rid of the VIC field, read that from the avi infoframe in EMP
  generation instead
- Remove the memcpy prior state path in hdmi_validate_vrr
- Redo EMP generation with respect to new mode logic, remove some
  redundancy
- Clear EMP infoframe regardless of sink-side support
- In hdmi_validate_vrr_limits, round up the vtotal check based on
  vtotal remainder
- Support edge case of sinks that only support QMS, and not VRR,
  and extend the QMS tests for this with another EDID
- In drm_crtc_helper_vrr_vsync, make the cur_err >= denom check
  explicitly cast denom (u32) to int after dividing by 2, to avoid
  both the bad u32 promotion of cur_err and the *2 wraparound
- In hdmi_validate_vrr, reset vrr state error accumulator if VRR target
  changes
- In hdmi_validate_vrr, check for NULL old_conn_state before accessing
  it for the QMS tfr byte check
- Drop the patch for disabling VRR in helper_set_config, as it'd regress
  Xorg.
- Link to v1: https://patch.msgid.link/20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com

---
Derek Foreman (4):
      video/hdmi: Add VTEM EMP packing
      drm/bridge: Add VTEM EMP support
      drm/connector: hdmi: Add VTEM EMP generation
      drm/bridge: synopsys: Add VTEM EMP support

Nicolas Frattaroli (23):
      drm: Add VRR state
      drm/connector: add vrr_display_mode connector property
      drm/crtc-helper: Add VRR helper functions
      drm/connector: Add drm_display_info_is_vrr_capable
      drm: Add VRR target frame rate properties
      drm/connector: Add vrr_display_{min,max} connector properties
      drm: Implement VRR rate limiting
      drm/rockchip: dw_hdmi_qp: Add VRR support
      drm/rockchip: Set mode_changed on vrr_enabled change
      drm/rockchip: vop2: Enable VRR
      drm/edid: Parse QMS flag from HDMI SCDS
      drm/edid: Parse QMS TFR min/max flags from HDMI SCDS
      drm/connector: Add "Media" VRR display mode for QMS
      video/hdmi: Add support for QMS in VTEM EMP packing
      drm/connector: hdmi: Add QMS to VTEM EMP generation
      drm/connector: hdmi: Add QMS state validation and computation
      drm/rockchip: dw_hdmi_qp: Add QMS support
      drm/tests: hdmi: Add "Game Mode" VRR tests
      drm/tests: hdmi: Add Fixed/Constrained rate VRR tests
      drm/tests: hdmi: Add Quick Media Switching tests
      drm/connector: Fix docs for cnmvrr and cinemavrr members
      drm/debugfs: Expose HDMI VRR in vrr_range debugfs
      drm/tests: hdmi: Add tests for vrr_display_{min,max} properties

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   50 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       |    1 +
 drivers/gpu/drm/display/drm_bridge_connector.c     |   41 +
 drivers/gpu/drm/display/drm_hdmi_helper.c          |   55 +
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  488 ++++++++
 drivers/gpu/drm/drm_atomic.c                       |   14 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   28 +
 drivers/gpu/drm/drm_connector.c                    |  217 ++++
 drivers/gpu/drm/drm_crtc.c                         |   34 +
 drivers/gpu/drm/drm_crtc_helper.c                  |   93 ++
 drivers/gpu/drm/drm_debugfs.c                      |   24 +-
 drivers/gpu/drm/drm_edid.c                         |    7 +
 drivers/gpu/drm/drm_mode_config.c                  |   20 +
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |   33 +
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   20 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |   65 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |   10 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c       |    4 +
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 1308 ++++++++++++++++++++
 drivers/gpu/drm/tests/drm_kunit_edid.c             |  420 +++++++
 drivers/gpu/drm/tests/drm_kunit_edid.h             |    3 +
 drivers/video/hdmi.c                               |   99 +-
 include/drm/display/drm_hdmi_helper.h              |    3 +
 include/drm/drm_bridge.h                           |   29 +
 include/drm/drm_connector.h                        |  107 +-
 include/drm/drm_crtc.h                             |   19 +
 include/drm/drm_crtc_helper.h                      |    6 +
 include/drm/drm_edid.h                             |    3 +
 include/drm/drm_mode_config.h                      |   45 +
 include/linux/hdmi.h                               |   21 +
 30 files changed, 3245 insertions(+), 22 deletions(-)
---
base-commit: 0e8b43b5a5ef2dd52c454158e7fd8a927d796eb4
change-id: 20260919-vrr-limiter-uapi-c99ed93fe7d2

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

