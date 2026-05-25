Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B2DCD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 01:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD9E10E0DE;
	Mon, 25 May 2026 01:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="lsNroxPs";
	dkim-atps=neutral
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com
 [115.124.28.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8125610E013
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1779671150; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=KRD4CwUNddNbyDb569CFuMlttwFpKfF7Jr4vCxanrqc=;
 b=lsNroxPsPuWcHJrmkkUZOzlUxIy859YGJmFqM8jO3p8hHAcbeLi3sB14oDOAp8BPNl8ZgE6zomwXVa7kWoXRCQDBB77WDrn3B24yqxsDvWWjXBWqySPn8eygxt81DSfOMxayi3k9H4QKCGEzujhDJhO9J0IKweht+8aKX11ndA+8yYl2RYGb5cHWMZ/hs6jMNSaj2ZLTzHKXMA+XauiecIDL0iCHluLfjPX/TUUkaL0JfE2H/89RX9DJwrJ7jH8jFeB7rEZp5yoPq7TT6855ZvuHT4hVFFB3D3D8/ujb04aXKKBmGdZUk5KGXePa7HcfnDHs980kgeqYK9QOMimeaQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436527|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00528581-0.000132947-0.994581;
 FP=7591092290472043066|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037071049;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=23; RT=23; SR=0;
 TI=SMTPD_---.hfqF6UQ_1779671147; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hfqF6UQ_1779671147 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 25 May 2026 09:05:48 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com,
 xbpeng@lontium.com, qdchen@lontium.com, llzhang@lontium.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v12 0/2] Add Lontium LT7911EXC eDP to MIPI DSI bridge
Date: Mon, 25 May 2026 09:05:42 +0800
Message-Id: <20260525010545.9470-1-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sunyun Yang <syyang@lontium.com>

The LT7911EXC is an I2C-controlled bridge that receives eDP1.4
and output mipi dsi. This series introduces:

- A device tree binding YAML file describing the hardware
- A new DRM bridge driver implementing the basic functionality

Signed-off-by: Sunyun Yang<syyang@lontium.com>
---
Change in v12:
- dt-binding:
- drm/bridge:
 1. Move the cleanup work of drm_panel_bridge_remove() forward into lt7911exc_dsi_host_detach().                        [sashiko-bot]
 2. Do not hold any lock during lt7911exc_reset().
- Link to v11: https://lore.kernel.org/lkml/20260522015735.2833-1-syyang@lontium.com/

Change in v11:
- dt-binding:
- drm/bridge:
 1. Removed Reviewed-by, we would appreciate it if the maintainer could help review this.
 2. Use devm_gpiod_get(,, GPIOD_OUT_HIGH) to fix the reset GPIO backpowering issue.                                       [sashiko-bot]
 3. Fixed Use-After-Free vulnerability due to dynamic DRM bridge removal in DSI detach callback.
 4. Fixed Use-After-Free of regmap during DRM teardown because firmware upgrade worker defeats removal safeguard.
 5. Fixed firmware upgrade performs a hardware reset, causing silent loss of DRM state and a blank screen.
 6. Use of kmalloc for a 64KB software buffer is susceptible to memory fragmentation failures - Fix by using kvmalloc
 7. Use the 'lt7911exc->ocm_lock' mutex and the 'lt7911exc->upgrade' flag to resolve the race condition between
    DRM atomic modeset and firmware upgrade.
 8. Use the 'lt7911exc->upgrade_lock' mutex to prevent redundant upgrades.
 9. Use the 'lt7911exc->removed' flag to prevent the driver from being triggered to upgrade during the unload process.
- Link to v10: https://lore.kernel.org/lkml/20260519135816.26996-1-syyang@lontium.com/

Change in v10:
- dt-binding:
- drm/bridge:
 1. Fixed the firmware upgrade error paths to always clear the upgrade
    flag before returning, including firmware size validation failures
    and allocation failures.                                                                [sashiko-bot]
 2. Added proper locking in lt7911exc_atomic_pre_enable() and
    lt7911exc_atomic_post_disable() to serialize register accesses with the
    firmware upgrade flow and avoid concurrent I2C transactions.
 3. Added an exclusivity check in lt7911exc_dsi_host_attach() to reject multiple
    downstream attachments and prevent repeated drm_bridge_add() calls and panel bridge leaks.
 4. Reworked lt7911exc_firmware_store() to use mutex_trylock() so concurrent sysfs writers
    immediately return -EBUSY instead of blocking behind an active firmware upgrade.
 5. Updated the remove path to prevent new firmware upgrade work from being queued after
    device removal by setting the upgrade state before cancelling the worker.
- Link to v9: https://lore.kernel.org/lkml/20260519105019.22622-1-syyang@lontium.com/

Change in v9:
- dt-binding:
- drm/bridge:
 1. DSI transfer callback returns success for reads without populating                        [sashiko-bot]
    the receive buffer, leaking uninitialized memory. - fixed it by
    implementing  a strict whitelist mechanism.
 2. DSI transfer callback polls for eDP video readiness before the
    upstream encoder is enabled, guaranteeing a timeout. - removed
 3. The driver attempts I2C transfers while the hardware is held in
    physical reset. - fixed
 4. Missing DRM_MIPI_DSI Kconfig dependency causes linker errors. - fixed
 5. request_firmware is called while holding the hardware lock and
    halting the MCU, risking a system pipeline stall. - fixed
 6. Sleeping functions are called from atomic context in the DRM bridge callbacks. - fixed
 7. lt7911exc_dsi_host_transfer bypasses the required MCU hardware halt sequence. - fixed by
    internal firmware controls the panel initialization sequence and handles all MIPI
    DSI command transmission.
- Link to v8: https://lore.kernel.org/lkml/20260515080934.9870-1-syyang@lontium.com/

Change in v8:
- dt-binding:
- drm/bridge:
 1. Protect firmware upgrade and DRM bridge callback paths with ocm_lock.          [sashiko-bot]
 2. Remove the hardware reset from the remove callback, and ensure that
    all hardware reset operations are protected by ocm_lock.
 3. crc reconstruction explicitly casts each byte to u32 before shifting
 4. The display configuration is handled by the firmware, and the MIPI
    DSI host registration issue has been fixed.
 5. The batch register read/write operations have already been updated
    to include return value checking.
 6. The dev_err_probe() used outside of probe context has been fixed.
- Link to v7: https://lore.kernel.org/lkml/20260512064013.40066-1-syyang@lontium.com/

Change in v7:
- dt-binding:
 1. fix commit message typos(Receiver、signal)                            [sashiko-bot]
 2. remove the ambiguity caused by "signal/dual".
- drm/bridge:
 1. using devm_regulator_get_enable avoids power leaks.                   [sashiko-bot]
 2. set reset gpio is low after cutting off power in lt7911exc_remove function, avoid backpowering.
 3. synchronous request_firmware() call cause a permanent probe failure if the driver is built-in,
    probe executes before the root filesystem is mounted, which would cause this to fail with -ENOENT,
    we have removed this functionality. Use trigger to upgrade.
 4. add `depends on I2C` and `select REGMAP_I2C` in Kconfig.
 5. add return value of `devm_drm_bridge_add()` in `probe()`.
 6. add directly header files (linux/slab.h, linux/delay.h, linux/regulator/consumer.h)
- Link to v6: https://lore.kernel.org/lkml/20260508134702.4713-1-syyang@lontium.com/

Change in v6:
- dt-binding:
- drm/bridge:
 1. use #define FW_FILE  "Lontium/lt7911exc_fw.bin" to match linux-firmware
- Link to v5: https://lore.kernel.org/lkml/20260506013153.2240-1-syyang@lontium.com/

Change in v5:
- dt-binding:
- drm/bridge:
 1. Change "mipi" to "mipi dsi" in the commit message.     [Dmitry]
 2. Change "eDP/MIPI" to "eDP/MIPI DSI" in Kconfig.
- Link to v4: https://lore.kernel.org/lkml/20260430094612.3408174-1-syyang@lontium.com/

Change in v4:
- dt-binding:
 1. Fix the missing spaces on the "subject".             [Krzysztof]
 2. Fix the error descriptions for port@0 and port@1.
- drm/bridge:
- Link to v3: https://lore.kernel.org/lkml/20260429040541.3404116-1-syyang@lontium.com/

Change in v3:
- dt-binding:
- drm/bridge:
 1. already submit lt7911exc_fw.bin to linux-firmware.  [Dmitry]
 2. remove lt7911exc_remove function.
 3. drop  the "lontium, "  in lt7911exc_i2c_table.
- Link to v2: https://lore.kernel.org/lkml/20260428063224.3316655-1-syyang@lontium.com/

Change in v2:
- dt-binding:
 1. reset pins use active low.                        [Dmitry]
- drm/bridge:
 1. use atomic_* callbacks.                           [Quentin]
 2. fix the incorrect formatting and spaces.
 3. add the required header files.                    [Dmitry]
 4. remove "enabled" flag.
 5. remove *fw from the lt7911exc struct.
 6. .max_register and .range_max use actual range.
 7. regulator use bulk interface.
 8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
 9. Replace GPL v2 with GPL.
- Link to v1: https://lore.kernel.org/lkml/20260420023354.1192642-1-syyang@lontium.com/

---
Sunyun Yang (2):
  dt-bindings: bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
  drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge

 .../display/bridge/lontium,lt7911exc.yaml     |  89 +++
 drivers/gpu/drm/bridge/Kconfig                |  16 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 700 ++++++++++++++++++
 4 files changed, 806 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c

-- 
2.34.1

