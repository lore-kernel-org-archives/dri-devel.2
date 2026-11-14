Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD86606A8A2
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TWVjFmA0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216A310E783;
	Sat, 14 Nov 2026 05:01:12 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA5A10E660
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794632456;
 bh=4W2648vMrjcfzlk9kqAxTmTAg2sYwZP40KKRsQxgVSU=;
 h=From:Subject:Date:To:Cc:From;
 b=TWVjFmA0WRneuaWdwTpsm7B1L8p/4TlNSgOZdbRSbqD9ukVcC7GhsZcvrNL2XxZSx
 k2RX1tdX9CkLcuvCRSs1LS83emgqOtb7z7nATld2i4jm1SYOaLaVFikBgiAPQNSk93
 tZ7P5hP/zFd9UqehK6cokcLAszq9CJ3w19AILQevJ+Q/+E39Mz4iYAxEj0l1u+WXQ3
 ZK3+9wF34Rv5ivA8uJSaOtqKr2gH1JmG9OSYOnbemE5iEd/NYl6clHdE2jNSkFIGa2
 z2C8TRhcuWDWKSCe/rucEpsrFLkjDQ+RN5gBIEeB3buTjWbI5wKf5T7zroj9828FZ/
 z3X4DbRnJTRhQ==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 53BC817E0E6E;
 Sat, 14 Nov 2026 06:00:56 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 0B26F48002C; Sat, 14 Nov 2026 06:00:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v12 00/23] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Date: Sat, 14 Nov 2026 06:00:33 +0100
Message-Id: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XTzWrDMAwH8FcpOc/DluWvnfYeYwfXltdAm4S4Z
 Cul7z6nMBKGSelRwvxspL+vTaaxpdy87a7NSFOb274rhYCXXRMOvvsi1sbSaICD5hIUy5euH/I
 ls/jN4sDa0zD2E52oO2dmogdyNiYRY1OEYaTU/tz5j89SH9p87sfL/bZJzN0/V2+6k2CcKS4sO
 qEBHH8P/fHo9/3oX0N/amZ7gsUrR7c9KF40ZJLe+2BMqnly8bSAbU/OXtCCtFSguK15uHgGHrw
 Pi5d4Qo8UyQioeWrt4baniucQVQCyBlHUPP2Ep4vHUUTnvHABqeaZtWe3PVO8vdHIk7chYXV+d
 uXJB/OzxfOhrMMbZSxU9+sWz3K57bniAWlCLaSS9X0IvgYfBZrPibHoQQfJZdRVUTwjzn+ExxI
 +xVWSVv4Xb7fbL+6Xvt7vAwAA
X-Change-ID: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Yury Smirnov <yurymonzon@gmail.com>, Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18058;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=4W2648vMrjcfzlk9kqAxTmTAg2sYwZP40KKRsQxgVSU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr36wfDb4Syu1KrFE8rES6h36vTFs1TlL9GD
 SjImkWCsxSri4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq9+sHAAoJENju1/PI
 O/qaQRcQAJvRhmPcw50lOeb3KoE3AVL7iCnGHjOjy6eX3RWgSDZ6h1SWZXLi3FhOxKc+K7QFHYH
 I/gxmP/HWppQipy+SaZ/m0fuVeEF7HwWXqQ1GX+xF1P58/kCaA0Y9az4f5mnro+C21xLnxC6vTt
 zQdREzS/NMpmwqWv05ixFVHXSf+Nj53djYDYnyZzZwCzRSYrtSn/v2/+MzfTsgcL1tWCWi37Q5t
 60daa5/kYW/7oR5/w6AeLq+gIMVCjg+UYukaFwjd1rdUalrXmLYWneFFqULPRxFMawDyywHTDVE
 z5SPtJAQjo2cQEO15QBfVcun5tVRCyVwNIkARRcU25Zg7rXPucAwyuWZZ7ZZ5z5DPO/3Joik5VA
 Be2llXd3yiZYhYMUujfgmWy0o759z+g7717hv9Ph76RT5FelkkNsUYbmZj+6gF31+plJjMOKmBY
 Elv2J5QUQ2pJQjeKXMDu6MjwyktGQwta9sZkFdEutUMBlvhvUKvxKmzoD0NpPIvUyGnCQcqk9Le
 F+4EYFbQ5F5KuMCmII+cdLfd9ao6HyHL4wdh6rvuu8oqWANOr+2AmOibbpFWamhb2FqvXbFcHDa
 bRRe/Scte7egwf3kUk4FNS9MCRSrIo1uP3pCEGCH2KM4lKzN8TcYKV4s1ak3yr0YGcP5Mf8ChB5
 pprBVAWI/bDuK48ntYiQobw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series updates the Synopsys Designware DisplayPort bridge
together with the only existing user: The Rockchip RK3576/RK3588:

 1. Follow-up bridges (PHY, USB-C connector)
    This is needed to get USB-C DP AltMode working; I've followed
    the Qualcomm driver as reference

 2. Runtime PM
    The initial driver has been upstreamed without RPM; add it to
    avoid wasting power when nothing is plugged

 3. Audio
    The initial driver has been upstreamed without audio support;
    this adds all missing bits for audio with single stream transport

There is a soft-dependency on these two USBDP series, which are needed
to get sensible USB-C DP AltMode on RK3588/RK3576:

 * https://lore.kernel.org/linux-phy/20261114-b4-rockchip-dwc3-rockchip-glue-v19-0-b79fb5f4b42a@collabora.com/
 * https://lore.kernel.org/linux-phy/20261114-b4-rockchip-usbdp-cleanup-part3-v17-0-1af5f566408e@collabora.com/

Boards using the DP controller for native DP connectors (or HDMI
bridges), currently directly link to the connector/hdmi bridge. These
are not affected by the USBDP changes and should keep working in any
case. The difference is, that with this series the DRM side is aware of
the link. I don't have any of those boards, so this code path is
untested. This becomes relevant for boards having on-board DP2HDMI
chips and exposing an HDMI connector as the port will be properly
named "card<number>-HDMI-A-<number>" when properly described.

I added a dedicated bridge callback for out-of-band hotplug events,
which is separate from the hotplug_notify. I have a feeling, that
there might be a better solution, but haven't found it. Please comment.

Changes in v12:
- Link to v11: https://patch.msgid.link/20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com
- rebase to drm-misc-next (v7.4-rc2 based)
- Collect Reviewed-by/Acked-by from Andy Yan and Chaoyi Chen
- Collect Tested-by from Igor Paunovic
- Add new patch adding system PM support
- In patch adding runtime PM support - handle dw_dp_runtime_resume()
  error for the disabled runtime PM case (Sashiko)
- Hold audio lock in dw_dp_reset() to avoid ALSA race with controller
  reset (Sashiko)
- In Fix error handling for DP link enablement, avoid running
  drm_dp_link_power_down() when link is already down to avoid a
  stall (Sashiko)
- Do synchronized runtime PM put in bridge detach or attach error
  to ensure IRQ is balanced correctly during teardown (Sashiko)
- Add new patch to retrain when compositor kept output enabled, but
  display got replugged in between
- Move HPD enforcing debug message to generic bridge driver, to have
  them all in the same file and keeping the vendor specific glue as
  small as possible
- Ignored Sashiko complaining about sleeping in DRM atomic_enable,
  which is perfectly fine
- Ignored Sashiko complaining about dw_dp_hpd_work() being able to
  retrain link in parallel to dw_dp_link_disable from atomic_disable;
  this cannot run into SError. In worst case HPD is ignored when display
  is disabled at exactly the same time. It's not worth further
  increasing the size of this series for that.
- Ignored Sashiko's report, that a long_hpd IRQ might be overridden
  by a follow-up normal hpd. There is only so much we can do when
  IRQs are processed too slow. Caching interrupts for that reason
  makes no sense.
- Ignored Sashiko complaining about unchecked regmap_read, which
  cannot fail as it is for MMIO
- Ignored Sashiko's missing bandwidth check for explicitly negotiated
  downstream formats; pre-existing and unreachable with existing
  downstream bridges, which either use FIXED or return dw-dp's
  bandwidth-filtered format list

Changes in v11:
- Link to v10: https://patch.msgid.link/20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com
- Move IRQ enablement slighty from before AUX bridge registration to directly
  afterwards in case there is a DP AUX related spurious interrupt
  (Sashiko)
- Cleanup SDP registers if there is an error in __dw_dp_audio_enable()
  (Sashiko)
- Clear XMIT_ENABLE in error handling of dw_dp_link_enable() (Sashiko)
- Move code to get next bridge to probe function, as it involves
  -EPROBE_DEFER; my previous change accidently broke modular build (Sashiko)

Changes in v10:
- Link to v9: https://patch.msgid.link/20260803-synopsys-dw-dp-improvements-v9-0-2e6e46135312@collabora.com
- Rework IRQ handling, so that the IRQ is enabled on bridge attach,
  dropping the patch introducing devm_work_autocancel() as that
  happens manually now during bridge detach (Sashiko)
- Update Fix error handling in dw_dp_link_enable(), so that it also
  ensures incorrect cleanup in dw_dp_link_disable(). While this kind
  of does two things now, it is one logical change and thus kept in
  one patch (Sashiko)
- Simplify IRQ handling in runtime PM patch and fix bisectability
  issue with runtime PM patch for generic bridge code applied, but
  runtime PM patch for Rockchip not yet applied
- Use 64 bit variables for matching the controller addresses, which
  is cleaner and future proof (Sashiko)
- Move all of the code previous patch versions added to dw_dp_bind
  and dw_dp_unbind to the bridge_attach/detach callbacks instead,
  which keeps dw_dp_bind nice and clean. It means that everything
  is properly initialized once the bridge has been attached.
- v9 got a Tested-by from Igor Paunovic <royalnet026@gmail.com>
  for RK3588 based Orange Pi 5 Plus (USB-C DP AltMode). I'm not
  carrying this over as quite a few patches changed due to the
  latest Sashiko feedback, even though I don't expect any
  regressions.

Changes in v9:
- Link to v8: https://patch.msgid.link/20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com
- Add yet another patch, which fixes missing resorce cleanups when
  dw_dp_link_enable() runs into errors (Sashiko)
- Acquire audio_lock guard in dw_dp_audio_mute_stream (Sashiko)
- Ensure dp->bridge.dev is set in dw_dp_hpd_work (Sashiko)
- Error out if hardware returns more bytes then requested by
  DP AUX transfer (Sashiko)
- The other Sashiko problems reported on v8 are false positives
  as far as I can tell

Changes in v8:
- Link to v7: https://patch.msgid.link/20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com
- Add new patch moving DP AUX bridge registration into
  bridge_attach/detach callbacks, which simplifies cleanup and ensures
  it is (un)registered at the right point in time (Sashiko)
- Update Fix incorrect resource lifetimes in bind callback patch to
  ensure at the end of the probe, the device is fully functional,
  also only register the bridge once all necessary bits are available
  as it is in theory reachable at this point (Sashiko)
- Update the patch cancelling HPD worker to simply use
  devm_work_autocancel() as a result of this rework
- Add a new patch describing why the reset line state is not explicitly
  changed (Sashiko)
- Merge the two patches for the AUX transfer timeout handling to avoid a
  temporary race condition and synchronize IRQs after the reset to fix
  yet another race condition (Sashiko)
- Add a new patch to properly support short I2C reads (Sashiko)
- Rework Runtime PM handling again, so that the OOB handling is done
  before the 100ms sleep. Also ensure it is enabled at the right point
  in time after the cleanup changes. (Sashiko)
- Add new patch to drop useless reservation for SDP slot 0, which
  fix a race condition (Sashiko)
- Also restore audio mute status when audio functionality is restored
  after atomic disable/enable cycle (Sashiko)
- Setup SDP audio frame channel_allocation according to information
  received from ALSA (Sashko)
- Sashiko feedback ignored by me and that may or may not appear again
  in this version as Sashiko does not seem to properly take the whole
  series into account and thus probably ignores the changelog
  * A divide-by-zero vulnerability exists in dw_dp_video_enable when
    processing a display mode with a clock value of 1; I believe this
    clock cannot drive a real mode
  * I2C-over-AUX reply status (NACK/DEFER) is silently discarded,
    causing deferred I2C transactions to falsely succeed and return
    garbage data; this is a false positive. It seems Sashiko got
    confused by the bit patterns. Nothing is discarded.
  * Potential Use-After-Free of the connector and encoder due to missing
    DRM device reference in OOB hotplug event handling; Sashiko
    missed that drm_for_each_bridge_in_chain() is now the renamed
    drm_for_each_bridge_in_chain_scoped().
  * Missing runtime PM acquisition in out-of-band HPD callbacks leads to
    SError crashes once runtime PM is enabled; Sashiko failed to
    notice that Runtime PM is only introduced in a later patch
  * Calling a sleeping function (msleep) from a runtime PM resume
    callback that is reachable from an atomic commit path; Sashiko
    failed to understand that atomic DRM functions may sleep
  * Missing system sleep callbacks prevent the device and its power
    domain from suspending during system sleep for native DP
    configurations; this needs separate investigation considering
    system sleep is broken on recent Rockchip platforms (same error
    appears a few times)
  * There is a bunch of pre-existing issues that are fixed later
    in the series

Changes in v7:
- Link to v6: https://lore.kernel.org/r/20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com
- Move drm_bridge_add() to probe and only attach it in the bind
  function, as the object is re-used and not fully cleared by
  drm_bridge_remove (Sashiko)
- Add a new patch resetting the DP AUX sub-controller on message
  timeout to have decent error recovery (Sashiko)
- Fix dp_dp_rockchip_get_vo_grf -> dw_dp_rockchip_get_vo_grf (Sashiko)
- Introduce pm_active in the PM runtime patch, to early exit
  on atomic_disable when atomic_enable failed to get runtime
  PM enabled (Sashiko)
- Introduce drm_bound in the PM runtime patch, which is (un)set
  when the driver is bound to a DRM encoder and used to enable
  IRQ enabling in the runtime PM handlers. This in turn protects
  the system of potential spurious interrupts. (Sashiko)
- In the audio patch, fix support for hotplug with a running
  audio stream. (Sashiko)
- To avoid further blowing up the series, I've decided not to
  act on these "pre-existing" issues reported by Sashiko. I
  think it makes sense to handle them separately:
    * Short HPD and Long HPD events share a single boolean state
      variable, causing critical hot plug events to be lost if
      interrupts arrive in quick succession.
    * DP AUX lifetime complains (registered too early / unregistered
      too late); reported multiple times
    * The driver fails to support DP AUX short reads, incorrectly
      rejecting them with -EBUSY instead of returning the number
      of bytes successfully transferred, which breaks I2C-over-AUX.
- Collected Reviewed-by from Krzysztof Kozlowski on the
  DT binding patch

Changes in v6:
- Link to v5: https://lore.kernel.org/r/20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com
- Fix overlong commit message in mutex patch
- Update MEDIA_BUS_FMT_FIXED patch, to use input format as output format
  when output format is MEDIA_BUS_FMT_FIXED (Sashiko)
- Drop patch moving dw_dp_bridge_atomic_get_output_bus_fmts (no longer
  needed)
- Reword the comment about platforms other than RK3576 and RK3588
  shouldn't get the VO GRF from the USBDP to make it more obvious
  that no such platform exist at the moment and thus the alternative
  path will not be implemented at this point in time (Sashiko)
- Update the runtime PM code to have much better error handling
  as well as support for platforms not using runtime PM (Sashiko)
- Update the runtime PM code to keep the device suspended when
  probed, but unbound as a nice side effect
- Fix error handling for dw_dp_audio_infoframe_send() in audio
  patch (Sashiko)
- Fix typo in sample width check in audio patch (Sashiko)
- Improve cleanup of SDP in audio patch (Sashiko)

Changes in v5:
- Link to v4: https://lore.kernel.org/r/20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com
- Add new patch to cancel pending HPD work on unbind (Sashiko)
- Add new patch to add missing mutex cleanups on module removal (Sashiko)
- Add new patch moving dw_dp_bridge_atomic_get_output_bus_fmts
- Update MEDIA_BUS_FMT_FIXED patch to avoid fixed RGB888 format
  and instead use whatever works for the negotiated bandwidth (Sashiko)
- Add more error checking for runtime PM patches (Sashiko)
- Ensure runtime PM is held in interrupt handler (Sashiko)
- Fix usbc_mode logic inversion for runtime PM in unbind (Sashiko)
- Move sleep for HPD_HOT_PLUG from hotplug handler to runtime
  resume function; no need to sleep when runtime PM is kept
  active and runtime PM resume is a slow operation anyways. (Sashiko)
- Add new patch to protect sdp_reg_bank from concurrent access (Sashiko)
- Add new patch to use regmap_set_bits in dw_dp_send_sdp()
- Update DT binding patch to be all about the selected solution and
  mention the ABI break
- Clear SDP in the audio patch on unprepare (Sashiko)
- Add a comment, that only 1,2 or 8 channels are supported (Sashiko)
- Error out on unsupported sample_width (Sashiko)
- Fix missing error check for clock enable (Sashiko)

Changes in PATCHv4:
 - Link to v3: https://lore.kernel.org/all/20260612-synopsys-dw-dp-improvements-v3-0-dc61e6352508@collabora.com/
 - Drop "Simplify driver data setting" (effectively reverted later on)
 - Add "Fix incorrect resource lifetimes in bind callback", which
   affects all following patches quite a bit (Sashiko)
 - Update "Add follow-up bridge support" to mention that fatal errors
   are fine (Sashiko)
 - Update "Add out-of-band HPD notify handler" to use
   drm_for_each_bridge_in_chain() instead of
   drm_for_each_bridge_in_chain_scoped() required after rebase to
   latest drm-misc-next
 - Add 100ms sleep in hpd detect functions after runtime resume in the
   "Add Runtime PM support" patch (Andy Yan)
 - Keep runtime PM enabled if DP is used without USB-C to avoid missing
   HPD signals in "Add Runtime PM support" patch (Andy Yan)
 - Update patch description of DT binding patch and drop RFC tag
 - Use pm_runtime_resume_and_get() in the audio startup function, which
   allows easy error handling (Sashiko)
 - Avoid updating audio_interface in the audio prepare function when
   an error related early exit happens (Sashiko)
 - Add error handling for clock prepare calls in audio prepare function
   (Sashiko)

Changes in PATCHv3:
- Link to v2: https://lore.kernel.org/r/20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com
- Collect Reviewed-by on "Simplify driver data setting" patch (Andy Yan)
- Use of_drm_get_bridge_by_endpoint instead of devm_drm_of_get_bridge (Luca Ceresoli)
- Use FIELD_PREP_WM16 instead of FIELD_PREP_WM16_CONST (Chaoyi Chen)
- Rebase to latest drm-misc-next (Dropped Cristian's patches)

Changes in PATCHv2:
 * Link to v1: https://lore.kernel.org/r/20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com
 * rebased to latest drm-misc-next
 * prepended the Patches from Cristian's cleanup series, as they also
   needed a rebase and should be merged first
   https://lore.kernel.org/dri-devel/20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com/
 * fix issue with the audio stream (un)prepare handling in last patch

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (22):
      drm/bridge: synopsys: dw-dp: Register DP AUX on bridge attach
      drm/bridge: synopsys: dw-dp: Fix incorrect resource lifetimes in bind callback
      drm/bridge: synopsys: dw-dp: Fix error handling for DP link enablement
      drm/bridge: synopsys: dw-dp: Document missing reset line deassert
      drm/bridge: synopsys: dw-dp: Add missing mutex cleanups on module removal
      drm/bridge: synopsys: dw-dp: Fix AUX transfer timeout race condition
      drm/bridge: synopsys: dw-dp: Fix support for short I2C reads
      drm/bridge: synopsys: dw-dp: Free output_fmts when none are valid
      drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
      drm/bridge: synopsys: dw-dp: Add follow-up bridge support
      drm/bridge: Add out-of-band HPD notify handler
      drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
      drm/rockchip: dw_dp: Implement out-of-band HPD handling
      drm/bridge: synopsys: dw-dp: Add Runtime PM support
      drm/rockchip: dw_dp: Add runtime PM support
      drm/rockchip: dw_dp: Add system PM support
      drm/bridge: synopsys: dw-dp: Protect sdp_reg_bank from concurrent access
      drm/bridge: synopsys: dw-dp: Drop useless reservation of first slot
      drm/bridge: synopsys: dw-dp: Clear only enabled SDPs on atomic disable
      drm/bridge: synopsys: dw-dp: Use regmap_set_bits in dw_dp_send_sdp
      dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells
      drm/bridge: synopsys: dw-dp: Add audio support

Yury Smirnov (1):
      drm/bridge: synopsys: dw-dp: Retrain on hotplug with pre-enabled link

 .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   9 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 801 +++++++++++++++++++--
 drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 189 ++++-
 include/drm/bridge/dw_dp.h                         |  13 +-
 include/drm/drm_bridge.h                           |  14 +
 6 files changed, 925 insertions(+), 107 deletions(-)
---
base-commit: fc72cd52fb284f3707fa36a68ea5a22543a51d71
change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd

Best regards,
--  
Sebastian Reichel <sebastian.reichel@collabora.com>

