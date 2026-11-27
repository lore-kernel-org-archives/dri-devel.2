Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0Xm8FXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DC2112A03;
	Fri, 27 Nov 2026 10:27:45 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD6D11298F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:24 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a32576da88so4576436f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774463; x=1796379263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6GqXV/LyNS1eXCOHO9HEI0k077DJHCbRkOPximIJxE=;
 b=B0Xm8FXa6fcw9SDg87aWaeDenBFVWmuTXCHFMoeBlAfoxUmXOQxLq4kssPBzLf3598
 stNjl+BUFK164Sn5+mYhhhCaqC6sluUOwE5Ck0eLLAERrnzgf9xg5fIsq/3URTSOawOS
 zkAFp8It8WmVUH5v7sXaUyIxRNIxhQdntGhJxbs2oepBAs1dg1SgFhibFf9sFPOC/ZE4
 zBY71yS472gj2mIf/zWD88aTkRnpKOem9Omvk+WvQnsTMf3McanXxs8Kzz4aqJoSeF15
 JNbJ7oWbz0VffONXKFA5fN+6UsQxU1R4um2wmoeRhHpAtngDhryBh3M4Q7nViDjNnAOn
 Guvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774463; x=1796379263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6GqXV/LyNS1eXCOHO9HEI0k077DJHCbRkOPximIJxE=;
 b=KIa7wv8Z+r9czZvkmCuCSv59HH3jEnOZgxtkzY2WpH9iApTCEloa0VgV5yZBfIpe1a
 5hTCvAdMpReHigQPvCLB9Kyur1a3V65S0Mp/gKRwbj+Pf1BOemOapMhsm8bFW1SAt7Jl
 DZ97Y9cJn7+8hSoQW1vzmBtO6MFZV0mxAlxsl6wBQaTL09fd0ZrWfFAWgRapC/DEukV5
 0Jg5X9S5TyYIZ5BfaiSQNeNcXz+vkFghWLL+mqs53mkSZloxTEiPWMUHNfaOOrutIwVP
 fx4hhDbtjrmRTPuW0XX2vPxEF/UIGaZnNHBfwUYv9BzRLkmqym81MgQBPrzgkM3uKt96
 kGCw==
X-Forwarded-Encrypted: i=1;
 AL+hErHjay9533JjCXjmOfGESliHV6+oBEUqJOi5tGHa93UYWJCl3XdJlokbWTwP17v1psg+oFKz+P0X7bw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/U8JIF1Ju47lfXHhMOIe2EQklWFXRZbFUICRlzNBRAnH7Qu9jn
 /NIJs5F+m6S3c6/iKcXK3VQ2KS+lKV738W4QGkMa60+FsYCeBSwz6FE=
X-Gm-Gg: AZFdTZfQueGIG6x6hrApsC+nXnwSjepnx54sVAxMm9almLQE25HV1DlPeBPsGjFgnEW
 mfLAg9UkjQdgz5LLbCVh3RNQKLBP4PsIdR57p2V3xVbzH61AcZ/zGLyhehdpGx+PJo3O5fZeQbT
 WIeQ3euELrJraaUG3sKRNIFweKjzcMlrG4zNMcUOM6Vmr1fkCUATMnhS2BZ0A9ySN9ZlwXeXj8B
 TjtYBzhinz9atYQP2vuslOtYRtPXFtn49Fh7V9q7jygNAST1tr/6qqoTClzl5C1D+6BwX+4K7OO
 S3wwLQXy/GCR3uV8VnurJmHl2f29GTJDSZe9pZoWNK4KxXiwNT3roOWmBRw05e3GXbnVjLTr5nW
 GxCgniquV7Ba5ad/P7cIC+Wm523FPrcoQDPM22rUwL2O21FGbnx8nNCJfyjnpK1NVrGGVxneyHV
 FGqxRdxpZogsNjjmIQAnIS3kXuPeM0JMSPBvZh7DzcwLURYRpNWP5tV58V8s4+z6vlCis8mPhVx
 imo9SHbmQ1gvDkbEaecC2uT2ERuEPC4Pb7/meaNDUPySscEawpnCtJizWkLLJ98VUUnbpFUL3/2
 WhPNYxmZDwrnFo9TwYqWOzuqMuZQZh0Jthi0QhQCVllyL+8frVR/dfUSO9P879fEd9CqJsocCgx
 GuZ1RWhnwug1mYt1WdnXklxQQBnpLmOPoDRL6ouOFyNaV4qs8IPI4NvW8g2c=
X-Received: by 2002:a05:6000:2308:b0:49b:587:121a with SMTP id
 ffacd0b85a97d-4abb36787afmr49730970f8f.16.1795774462607; 
 Fri, 27 Nov 2026 02:14:22 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:22 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 00/10] drm/msm/dp: fix DisplayPort hotplug, link training,
 and multi-lane PHY setup
Date: Fri, 27 Nov 2026 11:14:07 +0100
Message-Id: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On platforms with a native DisplayPort connector using direct HPD
interrupts, DisplayPort initializes on cold boot, but physical cable
unplug and re-plug cycles leave the display blank even though link
training and stream enable callbacks report success.

This series fixes the underlying PHY lane setup, DPCD link-info caching,
SST training-pattern handover, link maintenance completion/stream
handling, and HPD / sink_count / runtime-PM / PHY / EDID state tracking
issues:

1. Configure PHY voltage swing and pre-emphasis across all active lanes
   and refresh lanes/link_rate in msm_dp_ctrl_set_vx_px().
2. Zero out cached link_info in msm_dp_panel_read_dpcd() so re-plugging
   a different sink does not reuse stale rate, use_rate_set, or
   capability flags.
3. Avoid redundant back-to-back link training in
   msm_dp_display_prepare_link() and keep DP_TRAINING_PATTERN_SET active
   until msm_dp_ctrl_on_stream() is ready to switch REG_DP_STATE_CTRL to
   DP_STATE_CTRL_SEND_VIDEO.
4. Guard msm_dp_ctrl_push_idle(), reinitialize ctrl->video_comp, and
   keep training pattern active until stream clocks are enabled in
   msm_dp_ctrl_link_maintenance().
5. Use asynchronous pm_runtime_put() on HPD unplug/notify paths called
   from msm_dp_display_irq_thread() to avoid a synchronous disable_irq()
   self-deadlock in msm_dp_pm_runtime_suspend().
6. Track drm_dp_read_sink_count_cap() in link->has_sink_count and keep
   sink_count and prev_sink_count synchronized across plug and unplug.
7. Keep dp->plugged, AUX transfer enablement, and runtime PM references
   balanced across plug, unplug, detect, prepare_link, and empty branch
   dongle notifications.
8. Keep the DP PHY initialized across msm_dp_display_unprepare() and
   system sleep while a sink remains plugged in (removing now-unused
   msm_dp_ctrl_reinit_phy()).
9. Re-read EDID on demand in msm_dp_display_get_modes() when
   edid_blob_ptr is NULL (e.g. after DRM_FORCE_OFF).
10. Dispatch DP_DP_IRQ_HPD_INT_MASK to msm_dp_irq_hpd_handle(), skipping
    sink requests when mainlink clocks are off and emitting bridge HPD
    notifications on branch DS_PORT_STATUS_CHANGED events (kept at the
    end of the series so it can be dropped if superseded by in-flight
    DRM_CONNECTOR_DP_IRQ_HPD changes).

Changes in v2:
- Add Jens Glathe's Tested-by on unchanged patches 1, 3, and 5.
- Patch 1: clarify commit message regarding persistent ctrl->phy_opts
  staleness on link maintenance and update Fixes tag to 937f941ca06f.
- Patch 2: zero out the entire link_info struct (rate, use_rate_set,
  and capabilities) before parsing DPCD.
- Patch 4: drop redundant msm_dp_ctrl_configure_source_params() call (as
  msm-next already calls msm_dp_ctrl_config_ctrl_streams() inside
  msm_dp_ctrl_link_train(), avoiding unclocked pixel_base access when
  no stream is active), guard msm_dp_ctrl_push_idle() and
  msm_dp_ctrl_clear_training_pattern() / SEND_VIDEO with stream_clks_on,
  and update Fixes tag to 8ede2ecc3e5e.
- Reorder and split HPD changes (was patch 7) into four focused patches
  (patches 6-9):
  - Patch 6: DP_SINK_COUNT capability and prev_sink_count synchronization.
  - Patch 7: dp->plugged, AUX gate, msm_dp_bridge_detect() runtime PM
    release, prepare_link locking, and empty branch dongle handling.
  - Patch 8: PHY lifecycle across msm_dp_display_unprepare(), unplug, and
    system sleep, removing msm_dp_ctrl_reinit_phy().
  - Patch 9: on-demand EDID re-read in msm_dp_display_get_modes() and
    DRM_FORCE_OFF error log suppression.
- Patch 10 (was 5): move to end of series, guard
  msm_dp_ctrl_handle_sink_request() with ctrl->link_clks_on, guard
  msm_dp_irq_hpd_handle() with dp->plugged, and handle branch
  DS_PORT_STATUS_CHANGED connect/disconnect with non-reentrant
  drm_bridge_hpd_notify().
- Link to v1: https://lore.kernel.org/r/20261121214105.32596-1-gianfranco.mariotti94@gmail.com

Testing:
Hardware-tested across cold boot, unplug/re-plug, monitor swap (4K60
native DP and DP-to-HDMI branch adapter), connector DPMS/off cycles, and
IRQ_HPD link-retrain cycles on a QCS8275 (Monaco) SMARC board (SECO F86)
with a native DisplayPort connector running v6.18 + the FROMLIST DP
HPD/MST series (Qualcomm Linux / QLI 2.0), then forward-ported and
build-tested against msm-next.

Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>

Gianfranco Mariotti (10):
  drm/msm/dp: configure voltage swing and pre-emphasis for all active
    lanes
  drm/msm/dp: reset cached link_info before reading DPCD capabilities
  drm/msm/dp: keep training pattern active until stream video is ready
  drm/msm/dp: reinit video_comp and guard stream state on link
    maintenance
  drm/msm/dp: avoid synchronous runtime PM put from HPD IRQ thread
  drm/msm/dp: track DP_SINK_COUNT capability and sync prev_sink_count
  drm/msm/dp: fix HPD plugged, AUX gate, and runtime PM tracking
  drm/msm/dp: keep PHY initialized while plugged across link unprepare
  drm/msm/dp: re-read EDID on demand in get_modes when blob is missing
  drm/msm/dp: dispatch native IRQ_HPD directly to
    msm_dp_irq_hpd_handle()

 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  44 +++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 228 +++++++++++++++++++---------
 drivers/gpu/drm/msm/dp/dp_link.c    |  26 +++-
 drivers/gpu/drm/msm/dp/dp_link.h    |   2 +
 drivers/gpu/drm/msm/dp/dp_panel.c   |  20 ++-
 6 files changed, 215 insertions(+), 106 deletions(-)


base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
-- 
2.25.1

