Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23134C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD9310ED16;
	Wed, 19 Aug 2026 06:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="FnDhUm9J";
	dkim-atps=neutral
X-Greylist: delayed 84203 seconds by postgrey-1.36 at gabe;
 Tue, 18 Aug 2026 02:42:00 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273D610E495;
 Tue, 18 Aug 2026 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=WO
 8FyUC4HwnkJnyEzBvf1tqLaeA8/0Z4r64+dWiiiOI=; b=FnDhUm9JJpk6qrtczi
 Of6bd+w3mjQgg6loGcD9abFLT4rUmqmTWSYDupVnzNZlPSw9xwNyRATzXGdH7N4o
 8Yi35Lan1CmM+apZ72pr8r4nzKdUodWLrMLztjmv82tz6CDjtgq3ZiXNeHVID1qc
 0pcVUuhTE+Vro2xr+r4kEH3QI=
Received: from debian.lenovo.com (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX3V9VxoNqomgEOQ--.254S2;
 Tue, 18 Aug 2026 10:41:29 +0800 (CST)
From: rh_king@163.com
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: siqueira@igalia.com, dillon.varone@amd.com, gaghik.khachatrian@amd.com,
 pinglei.lin@amd.com, zhikai.zhai@amd.com, robin.chen@amd.com,
 alex.hung@amd.com, Matthew.Stewart2@amd.com, jack.chang@amd.com,
 clayking@amd.com, chuntao.tso@amd.com, PeiChen.Huang@amd.com,
 Derek.Lai@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Kean Ren <rh_king@163.com>
Subject: [PATCH v2] drm/amdgpu/dc: Avoid PSR AUX WARN on unhealthy eDP link
Date: Tue, 18 Aug 2026 10:42:19 +0800
Message-ID: <20260818024219.2921012-1-rh_king@163.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817031640.2097973-1-rh_king@163.com>
References: <20260817031640.2097973-1-rh_king@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX3V9VxoNqomgEOQ--.254S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFy8AFWkurWkCr1kWFyUZFb_yoWDKFyrp3
 yfKFW5GrW8Zr42vF47J3W09rW5Z3W7Aa47JrZ3Gr1kZ3W5Aw1UuF18Zr1agF98GrZrJa13
 JF1kua4Ig3Wqkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_WlkJUUUUU=
X-Originating-IP: [36.141.44.3]
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC-BlD8WqDxlln9QAA3z
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

From: Kean Ren <rh_king@163.com>

v2: Keep the original `status` variable, just add `return status;` on
    each error path. The previous v1 attempt renamed `status` to a new
    `result` variable to avoid masking failures across the four
    core_link_write_dpcd() calls, but missed that the function's final
    `return status;` was then left returning uninitialised stack memory
    on the success path (caught by Sashiko AI review). Restoring the
    `status` name and only adding the early returns gives a smaller,
    more obvious diff.

When an eDP panel is still recovering right after resume (e.g. lid open
or AC return on a ThinkPad that has been in s2idle for hours), AUX/DPCD
writes may transiently fail. Two distinct code paths compound this into
a kernel WARN at dce_aux_transfer_raw():

  1. dpcd_set_link_settings() reuses a single `status` variable for
     four core_link_write_dpcd() calls and only emits DC_LOG_ERROR on
     failure. The first failing write gets overwritten by the next
     call, so the function can return DC_OK even when every DPCD write
     failed. Callers therefore cannot tell that the link is unhealthy
     and continue with PSR setup on a dead AUX channel.

  2. edp_setup_psr() does not consult link->link_status.link_active
     before pushing the PSR enable DPCD writes. When the link training
     failed, the sink is not actually there to ACK, so
     dm_helpers_dp_write_dpcd() -> dce_aux_transfer_raw() hangs until
     AUX_SW_DONE times out and triggers ASSERT_CRITICAL().

Observed on a Lenovo ThinkPad 21XHZDY2CN (BIOS R3HET22W 1.08) running
Ubuntu 24.04 with 6.17.0-1030-oem. The user-visible trigger is usually
a network event right after resume (unplug/replug the r8169 Ethernet
cable, NetworkManager roaming to wlan, or a lid-close -> lid-open
cycle). The dbus signal from those events causes a Wayland compositor
(gnome-shell) or an X11 client running under XWayland to issue
DRM_IOCTL_MODE_SETCRTC, which reaches amdgpu_dm_enable_self_refresh()
and then edp_setup_psr(). The "Xorg" comm name in the WARN trace is
XWayland, since this box boots into a GNOME Wayland session.

```
amdgpu 0000:c6:00.0: [drm] enabling link 0 failed: 15
amdgpu 0000:c6:00.0: [drm] *ERROR* dpcd_set_link_settings:1122:
        core_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed
amdgpu 0000:c6:00.0: [drm] *ERROR* dpcd_set_link_settings:1127:
        core_link_write_dpcd (DP_LANE_COUNT_SET) failed
amdgpu 0000:c6:00.0: [drm] *ERROR* dpcd_set_link_settings:1144:
        core_link_write_dpcd (DP_LINK_BW_SET) failed
amdgpu 0000:c6:00.0: [drm] *ERROR* dpcd_set_link_settings:1149:
        core_link_write_dpcd (DP_LINK_RATE_SET) failed
[- cut here -]
WARNING: CPU: 0 PID: 2615 at drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:393
        dce_aux_transfer_raw+0x296/0x2e0 [amdgpu]
CPU: 0 UID: 1000 PID: 2615 Comm: Xorg Tainted: G           O
        6.17.0-1030-oem #30-Ubuntu PREEMPT(voluntary)
Tainted: [O]=OOT_MODULE
Hardware name: LENOVO 21XHZDY2CN/21XHZDY2CN, BIOS R3HET22W (1.08 )
        06/24/2026
RIP: 0010:dce_aux_transfer_raw+0x296/0x2e0 [amdgpu]
Code: ff e9 49 ff ff ff 41 c7 04 24 04 00 00 00 eb eb 3c 01
       0f 87 4c f4 34 00 83 e0 01 3c 01 19 c0 83 e0 c0 83 c0 50
       e9 3f fe ff ff <0f> 0b 41 c7 04 24 03 00 00 00 eb c5
       41 c7 04 24 03 00 00 00 eb bb
RSP: 0018:ffffcdd6c53272f8 EFLAGS: 00010246
RAX: 0000000062000000 RBX: ffff8d353020fc80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffcdd6c5327358 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffcdd6c53273ac
R13: ffffcdd6c53273b0 R14: 0000000000000001 R15: ffff8d3562690000
FS:  00007b3cc831aac0(0000) GS:ffff8d4c6d669000(0000)
    knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000700f940020f8 CR3: 000000012fe37000 CR4: 0000000000f50ef0
PKRU: 55555554
Call stack:
 <TASK>
 link_aux_transfer_raw+0x48/0x80 [amdgpu]
 dc_link_aux_transfer_raw+0x24/0x40 [amdgpu]
 dm_dp_aux_transfer+0xee/0x2b0 [amdgpu]
 drm_dp_dpcd_access+0xbe/0x160 [drm_display_helper]
 drm_dp_dpcd_write+0xc4/0x120 [drm_display_helper]
 dm_helpers_dp_write_dpcd+0x29/0x60 [amdgpu]
 edp_setup_psr+0x156/0x5a0 [amdgpu]
 dc_link_setup_psr+0x20/0x40 [amdgpu]
 amdgpu_dm_link_setup_psr+0x155/0x1a0 [amdgpu]
 ? dm_write_reg_func+0x47/0xc0 [amdgpu]
 amdgpu_dm_enable_self_refresh+0xaa/0x240 [amdgpu]
 amdgpu_dm_commit_planes+0x636/0x1740 [amdgpu]
 ? manage_dm_interrupts+0xa5/0x280 [amdgpu]
 amdgpu_dm_atomic_commit_tail+0xb04/0x1270 [amdgpu]
 ? __set_output_tf.constprop.0+0xfd/0x1a0 [amdgpu]
 commit_tail+0xc6/0x1b0
 drm_atomic_helper_commit+0x132/0x160
 drm_atomic_commit+0xac/0xf0
 ? __pfx___drm_printfn_info+0x10/0x10
 drm_atomic_helper_set_config+0x82/0xd0
 drm_mode_setcrtc+0x3ff/0x9e0
 ? rmapiMapWithSecInfo+0x230/0x2b0 [nvidia]
 ? __pfx_drm_mode_setcrtc+0x10/0x10
 drm_ioctl_kernel+0xb4/0x110
 drm_ioctl+0x2ec/0x5b0
 ? __pfx_drm_mode_setcrtc+0x10/0x10
 amdgpu_drm_ioctl+0x4b/0xa0 [amdgpu]
 __x64_sys_ioctl+0xa2/0x100
 x64_sys_call+0x1226/0x2680
 do_syscall_64+0x80/0x8b0
 ? check_heap_object+0x17f/0x1c0
 ? nvidia_unlocked_ioctl+0x175/0x9a0 [nvidia]
 ? __x64_sys_ioctl+0xbf/0x100
 ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 ? do_syscall_64+0xb6/0x8b0
 ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 ? do_syscall_64+0xb6/0x8b0
 ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
 ? do_syscall_64+0xb6/0x8b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7b3cc8724f1d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8
 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8
 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007ffe65c05b80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000617240d63e10 RCX: 00007b3cc8724f1d
RDX: 00007ffe65c05c10 RSI: 00000000c06864a2 RDI: 0000000000000010
RBP: 00007ffe65c05bd0 R08: 0000000000000000 R09: 0000617240c4b700
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe65c05c10
R13: 00000000c06864a2 R14: 0000000000000010 R15: 000061723f332b30
 </TASK>
[- end trace 0000000000000000 -]
```

Fix both issues:

  - dpcd_set_link_settings(): add an early `return status;` after each
    failed core_link_write_dpcd() check, so callers see the real
    AUX/DPCD state instead of the last successful write.

  - edp_setup_psr(): short-circuit when link->link_status.link_active
    is false, so we never push PSR configuration over a dead AUX
    channel.

Signed-off-by: Kean Ren <rh_king@163.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c       | 30 ++++++++++++++++----
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 11 +++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 605bf19dc4f2..f15a5e7ea43a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1117,15 +1117,25 @@ enum dc_status dpcd_set_link_settings(
 				link->dpcd_caps.max_ln_count.bits.POST_LT_ADJ_REQ_SUPPORTED;
 	}

+	/* Bail out on the first DPCD write failure so callers can react and
+	 * subsequent operations (e.g. PSR setup) do not keep poking an
+	 * unhealthy AUX channel. Without this, a transient AUX/HPD glitch
+	 * during resume leads to a cascade of DPCD errors and ultimately a
+	 * WARN at dce_aux_transfer_raw() because AUX_SW_DONE never asserts.
+	 */
 	status = core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
-		&downspread.raw, sizeof(downspread));
-	if (status != DC_OK)
+				      &downspread.raw, sizeof(downspread));
+	if (status != DC_OK) {
 		DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_DOWNSPREAD_CTRL) failed\n", __func__, __LINE__);
+		return status;
+	}

 	status = core_link_write_dpcd(link, DP_LANE_COUNT_SET,
-		&lane_count_set.raw, 1);
-	if (status != DC_OK)
+				      &lane_count_set.raw, 1);
+	if (status != DC_OK) {
 		DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LANE_COUNT_SET) failed\n", __func__, __LINE__);
+		return status;
+	}

 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_13 &&
 			lt_settings->link_settings.use_link_rate_set == true) {
@@ -1141,19 +1151,25 @@ enum dc_status dpcd_set_link_settings(
 					supported_link_rates, sizeof(supported_link_rates));
 		}
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
-		if (status != DC_OK)
+		if (status != DC_OK) {
 			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
+			return status;
+		}

 		status = core_link_write_dpcd(link, DP_LINK_RATE_SET,
-				&lt_settings->link_settings.link_rate_set, 1);
-		if (status != DC_OK)
+					      &lt_settings->link_settings.link_rate_set, 1);
+		if (status != DC_OK) {
 			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_RATE_SET) failed\n", __func__, __LINE__);
+			return status;
+		}
 	} else {
 		rate = get_dpcd_link_rate(&lt_settings->link_settings);

 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
-		if (status != DC_OK)
+		if (status != DC_OK) {
 			DC_LOG_ERROR("%s:%d: core_link_write_dpcd (DP_LINK_BW_SET) failed\n", __func__, __LINE__);
+			return status;
+		}
 	}

 	if (rate) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 80a372ceaa51..43a0facc8884 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -699,6 +699,17 @@ bool edp_setup_psr(struct dc_link *link,
 	if (!link)
 		return false;

+	/* Skip PSR setup when the eDP link is not active. When AUX/DPCD
+	 * writes are failing (e.g. after a resume where the panel has not
+	 * fully come back yet), edp_setup_psr() will still try to push
+	 * configuration over the AUX channel. That auxiliary transfer never
+	 * completes and triggers ASSERT_CRITICAL() in dce_aux_transfer_raw().
+	 * The DPCD read of the PSR cap below is also unsafe on a dead link,
+	 * so bail out early before touching the sink.
+	 */
+	if (!link->link_status.link_active)
+		return false;
+
 	/* This is a workaround: some vendors require the source to
 	 * read the PSR cap; otherwise, the vendor's PSR feature will
 	 * fall back to its default behavior, causing a misconfiguration
--
2.47.3

