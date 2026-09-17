Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD35C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 712E710E4EB;
	Thu, 17 Sep 2026 10:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q6Ibgn4I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7859110E4EB
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5649060214;
 Thu, 17 Sep 2026 10:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B41F000FF;
 Thu, 17 Sep 2026 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1789640206;
 bh=rCRd6MB5YHVDOa7KnX5qbyFVixgoECc2Fr8bQRiVMak=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=Q6Ibgn4IZk6Pcq6BdsBxe1P9Ih8LCxaRNDZDy+U/PPpplKfTJLOKtuluceHJT6BNo
 JYmCY7Cc8hjP4dmS7AGDqcutbFgmthfWasNzJbHUnNkOtg154J1xWG8jR8KFUS8lXP
 QyeySpyBy3ULc1yPw/aY8ZKooTo6OjMH2AGcCjVw=
Subject: Patch "drm/ttm: Drop tt->restore after successful restore" has been
 added to the 6.18-stable tree
To: airlied@gmail.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
 matthew.brost@intel.com, mripard@kernel.org, ray.huang@amd.com,
 sashal@kernel.org, simona@ffwll.ch, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Sep 2026 11:13:30 +0100
In-Reply-To: <20260912143418.2961430-2-sashal@kernel.org>
Message-ID: <2026091730-consonant-trickery-32d2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore
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


This is a note to let you know that I've just added the patch titled

    drm/ttm: Drop tt->restore after successful restore

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-ttm-drop-tt-restore-after-successful-restore.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-328038-greg=kroah.com@vger.kernel.org Sat Sep 12 15:44:38 2026
From: Sasha Levin <sashal@kernel.org>
Date: Sat, 12 Sep 2026 10:34:18 -0400
Subject: drm/ttm: Drop tt->restore after successful restore
To: stable@vger.kernel.org
Cc: "Matthew Brost" <matthew.brost@intel.com>, "Thomas Hellstr�m" <thomas.hellstrom@linux.intel.com>, "Christian Koenig" <christian.koenig@amd.com>, "Huang Rui" <ray.huang@amd.com>, "Matthew Auld" <matthew.auld@intel.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Sasha Levin" <sashal@kernel.org>
Message-ID: <20260912143418.2961430-2-sashal@kernel.org>

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 941ac10529b3be5965a88d432a161ab459672ba8 ]

ttm_pool_restore_and_alloc() can successfully complete the restore
process via ttm_pool_restore_commit(), but tt->restore is not dropped
afterward. As a result, subsequent backup/restore flows observe what
appears to be a completed restore, while in reality shmem handles are
still installed in tt->pages, leading to the stack trace below.

Fix this by freeing and dropping tt->restore in
ttm_pool_restore_and_alloc() upon successful completion of the restore.

20545 [  309.784531] RIP: 0010:sg_alloc_append_table_from_pages+0x38c/0x490
20547 [  309.809570] RSP: 0018:ffffc9000623b838 EFLAGS: 00010206
20548 [  309.814827] RAX: 0000000000001000 RBX: ffff88816e42a160 RCX: 0000000000000000
20549 [  309.821986] RDX: 0000000000002000 RSI: 0000000000000003 RDI: 0000000000001000
20550 [  309.829147] RBP: ffff88816e42a168 R08: 0000000000000002 R09: 000000007ffff000
20551 [  309.836310] R10: ffffc9000623b928 R11: 0000000000000000 R12: 000000007ffff000
20552 [  309.843471] R13: ffff88815ba5a100 R14: 0000000000000000 R15: 0000000000000001
20553 [  309.850634] FS:  00007f9ff305e700(0000) GS:ffff888276c94000(0000) knlGS:0000000000000000
20554 [  309.858749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
20555 [  309.864519] CR2: 00007f9fca701000 CR3: 00000001565e2005 CR4: 0000000008f70ef0
20556 [  309.871678] PKRU: 55555558
20557 [  309.874403] Call Trace:
20558 [  309.876866]  <TASK>
20559 [  309.878988]  sg_alloc_table_from_pages_segment+0x60/0x100
20560 [  309.884415]  ? ttm_resource_manager_usage+0x36/0x60 [ttm]
20561 [  309.889845]  ? xe_tt_map_sg+0x7d/0xd0 [xe]
20562 [  309.894045]  xe_tt_map_sg+0x7d/0xd0 [xe]
20563 [  309.898037]  xe_bo_move+0x927/0xaa0 [xe]
20564 [  309.902029]  ttm_bo_handle_move_mem+0xba/0x170 [ttm]
20565 [  309.907022]  ttm_bo_validate+0xbe/0x190 [ttm]
20566 [  309.911405]  xe_bo_validate+0x9a/0x120 [xe]
20567 [  309.915663]  xe_gpuvm_validate+0xd9/0x140 [xe]
20568 [  309.920206]  drm_gpuvm_validate+0x2f0/0x5b0 [drm_gpuvm]
20569 [  309.925459]  ? drm_exec_lock_obj+0x63/0x210 [drm_exec]
20570 [  309.930627]  xe_vm_validate_rebind+0x46/0xb0 [xe]
20571 [  309.935428]  xe_exec_fn+0x20/0x40 [xe]
20572 [  309.939249]  drm_gpuvm_exec_lock+0x78/0xc0 [drm_gpuvm]
20573 [  309.944410]  xe_validation_exec_lock+0x5a/0xa0 [xe]
20574 [  309.949385]  xe_exec_ioctl+0x806/0xc30 [xe]
20575 [  309.953639]  ? ttwu_queue_wakelist+0xd9/0xf0
20576 [  309.957935]  ? __pfx_xe_exec_fn+0x10/0x10 [xe]
20577 [  309.962449]  ? __wake_up_common+0x73/0xa0
20578 [  309.966482]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20579 [  309.971263]  drm_ioctl_kernel+0xa3/0x100
20580 [  309.975209]  drm_ioctl+0x213/0x440
20581 [  309.978637]  ? __pfx_xe_exec_ioctl+0x10/0x10 [xe]
20582 [  309.983415]  xe_drm_ioctl+0x67/0xd0 [xe]
20583 [  309.987408]  __x64_sys_ioctl+0x7f/0xd0

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260617015531.1164189-1-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_pool.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -838,6 +838,7 @@ int ttm_pool_restore_and_alloc(struct tt
 {
 	struct ttm_pool_tt_restore *restore = tt->restore;
 	struct ttm_pool_alloc_state alloc;
+	int ret;
 
 	if (WARN_ON(!ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
@@ -861,14 +862,22 @@ int ttm_pool_restore_and_alloc(struct tt
 	} else {
 		alloc = restore->snapshot_alloc;
 		if (ttm_pool_restore_valid(restore)) {
-			int ret = ttm_pool_restore_commit(restore, tt->backup,
-							  ctx, &alloc);
+			ret = ttm_pool_restore_commit(restore, tt->backup,
+						      ctx, &alloc);
 
 			if (ret)
 				return ret;
 		}
-		if (!alloc.remaining_pages)
+		if (!alloc.remaining_pages) {
+			ret = ttm_pool_apply_caching(&alloc);
+			if (ret)
+				return ret;
+
+			kfree(tt->restore);
+			tt->restore = NULL;
+
 			return 0;
+		}
 	}
 
 	return __ttm_pool_alloc(pool, tt, ctx, &alloc, restore);


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.18/drm-amdgpu-make-amdgpu_vm_flush-non-failing-in-submission-path.patch
queue-6.18/asoc-ux500-remove-obsolete-prcmu-qos-calls.patch
queue-6.18/net-reject-oversized-tx_queue_len-at-netlink-parse-t.patch
queue-6.18/ksmbd-remove-stale-channels-from-all-sessions-on-tea.patch
queue-6.18/drm-amd-display-check-for-sharpening-case-when-calcu.patch
queue-6.18/clk-qcom-clk-rpmh-make-all-vrms-optional.patch
queue-6.18/media-imon-add-imon-vfd-hid-oem-v1.2-key-mappings.patch
queue-6.18/hwmon-ina2xx-replace-masks-with-enum-in-alert-functi.patch
queue-6.18/wifi-mac80211_hwsim-reject-undersized-hwsim_attr_tx_.patch
queue-6.18/pci-intel-gw-enable-clock-before-phy-init.patch
queue-6.18/tracing-undo-the-registration-when-enabling-the-histogram-trigger-fails.patch
queue-6.18/watchdog-msc313e-enable-clock-before-accessing-hardw.patch
queue-6.18/wifi-iwlwifi-acpi-validate-wgds-table-revision-index.patch
queue-6.18/sched_ext-fix-timer-pinning-and-return-value-in-scx_.patch
queue-6.18/netfilter-ipset-mark-the-rcu-locked-areas-properly.patch
queue-6.18/media-chips-media-wave5-add-timeout-while-stop_streaming.patch
queue-6.18/platform-chrome-resolve-kb_wake_angle-visibility-rac.patch
queue-6.18/edac-altera-use-ecc-manager-compatible-to-select-a10-s10-irq-layout.patch
queue-6.18/thermal-drivers-tegra-soctherma-switch-to-devm-cooli.patch
queue-6.18/asoc-amd-yc-add-dmi-quirk-for-hyperx-omen-gaming-lap.patch
queue-6.18/asoc-fsl_micfil-balance-mclk-enable-disable.patch
queue-6.18/drm-xe-i2c-keep-the-i2c-controller-always-enabled.patch
queue-6.18/drm-nouveau-gsp-add-sec2-to-ga100-chip-table.patch
queue-6.18/revert-arm64-dts-qcom-sm8350-fix-the-pcie-iommu-map-.patch
queue-6.18/iommu-arm-smmu-qcom-ensure-smmu-is-powered-up-in-set.patch
queue-6.18/bpf-guard-__get_user-acesss-with-access_ok-for-uprob.patch
queue-6.18/init-main-read-bootconfig-header-with-get_unaligned_le32.patch
queue-6.18/drm-amdgpu-avoid-integer-overflow-in-va-range-check.patch
queue-6.18/net-ethernet-oa_tc6-export-standard-defined-register.patch
queue-6.18/alsa-usb-audio-add-quirk-for-novation-mininova.patch
queue-6.18/tracing-disable-kcov-instrumentation-for-trace_irqso.patch
queue-6.18/f2fs-accurately-adjust-free_sections-during-free_segment_range.patch
queue-6.18/net-mlx5e-fix-ets-zero-bw-reporting-when-one-tc-hold.patch
queue-6.18/sctp-fix-err_chunk-memory-leaks-in-init-handling.patch
queue-6.18/alsa-seq-oss-reject-reads-that-cannot-fit-the-next-e.patch
queue-6.18/netfilter-nfnetlink_log-wait-for-rcu-grace-period-be.patch
queue-6.18/drm-amdkfd-check-bounds-for-allocate_sdma_queue-rest.patch
queue-6.18/scsi-pm8001-reject-firmware-update-in-fatal-error-st.patch
queue-6.18/drm-arm-komeda-fix-error-handling-for-clk_prepare_en.patch
queue-6.18/net-mlx5-e-switch-prevent-mc_list-repopulation-durin.patch
queue-6.18/leds-uleds-return-efault-on-copy_to_user-failure.patch
queue-6.18/tcp-rename-icsk_timeout-to-tcp_timeout_expires.patch
queue-6.18/usb-usbtmc-don-t-store-usb_device_id.patch
queue-6.18/net-sched-pie-clamp-psched_mtu-in-pie_drop_early.patch
queue-6.18/net-mlx5e-verify-unique-vhca_id-count-instead-of-ran.patch
queue-6.18/arm64-panic-from-init_irq-if-irq-handler-stacks-cann.patch
queue-6.18/mailbox-make-mbox_send_message-return-error-code-whe.patch
queue-6.18/btrfs-fix-reloc-root-cleanup-in-merge_reloc_roots.patch
queue-6.18/drm-amdgpu-plumb-timedout-fence-through-to-force-completion.patch
queue-6.18/alsa-usb-audio-add-fixed_rate-quirk-for-jbl-quantum6.patch
queue-6.18/iommu-rockchip-disable-fetch-dte-time-limit.patch
queue-6.18/usb-cdc-acm-start-bulk-in-polling-when-always_poll_c.patch
queue-6.18/edac-altera-use-parent-device-for-devres-in-altr_portb_setup.patch
queue-6.18/thunderbolt-increase-timeout-for-configuration-ready.patch
queue-6.18/x86-microcode-amd-move-the-no-revision-fixup-to-get_.patch
queue-6.18/net-sched-act_api-budget-all-shared-attributes-in-no.patch
queue-6.18/ip6_gre-check-tunnel-info-before-xmit-in-ip6gre_tunn.patch
queue-6.18/perf-symbol-do-not-use-debug-file-as-the-binary-type.patch
queue-6.18/sunvdc-unmap-ldc-cookies-when-the-descriptor-send-fa.patch
queue-6.18/tipc-fix-integer-overflow-in-tipc_recvmsg-and-tipc_r.patch
queue-6.18/media-qcom-iris-fix-runtime-pm-reference-leaks.patch
queue-6.18/alsa-hda-ca0132-add-quirk_generic-path-for-gigabyte-.patch
queue-6.18/char-nvram-remove-redundant-nvram_mutex.patch
queue-6.18/regulator-da9121-use-subvariant-ids-in-the-i2c-table.patch
queue-6.18/documentation-hwmon-replace-full-width-colon-by-a-st.patch
queue-6.18/sparc64-uprobes-add-missing-break.patch
queue-6.18/s390-cio-purge-based-on-the-cdev-s-online-status.patch
queue-6.18/dmaengine-altera-msgdma-use-memcpy_toio-for-descript.patch
queue-6.18/sched_ext-update-demo-schedulers-and-selftests-to-us.patch
queue-6.18/media-chips-media-wave5-add-range-checks-for-dec_out.patch
queue-6.18/pm-hibernate-call-preallocate_image-after-freeze-pre.patch
queue-6.18/net-au1000-move-free_irq-out-of-the-close-time-spinl.patch
queue-6.18/netfilter-nf_conntrack_expect-zero-at-allocation-tim.patch
queue-6.18/drm-i915-display-clear-sel_fetch_plane_ctl-on-plane-disable.patch
queue-6.18/scsi-mpi3mr-fix-target-device-refcount-leak-in-mpi3m.patch
queue-6.18/net-micrel-fix-typos-in-micrel-driver-code-comments.patch
queue-6.18/wifi-libipw-fix-key-index-receive-bound-checks.patch
queue-6.18/bpf-check-ancestor-frames-for-rbtree-callbacks.patch
queue-6.18/erofs-separate-plain-and-compressed-filesystems-formally.patch
queue-6.18/pds_core-fix-cmd_regs-access-racing-bar-unmap-on-res.patch
queue-6.18/asoc-ab8500-validate-and-program-tdm-slots-correctly.patch
queue-6.18/iommu-riscv-disable-sade.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-elitebook-830-g8-8.patch
queue-6.18/net-stmmac-initialize-ptp_lock-at-probe-time.patch
queue-6.18/wifi-mac80211-don-t-call-ieee80211_handle_reconfig_f.patch
queue-6.18/net-macb-initialize-ptp-state-before-registering-clock.patch
queue-6.18/driver-core-avoid-warning-when-removing-a-device-whi.patch
queue-6.18/revert-arm64-dts-qcom-lemans-fix-the-pcie-iommu-map-.patch
queue-6.18/wifi-iwlwifi-pcie-null-rx-pointers-after-free.patch
queue-6.18/wifi-iwlwifi-mvm-validate-sta_id-in-ba-window-status.patch
queue-6.18/net-mana-hardening-reject-zero-max_num_queues-from-m.patch
queue-6.18/media-iris-turn-platform-data-into-constants.patch
queue-6.18/hwmon-sht4x-fix-return-value-from-heater_enable_stor.patch
queue-6.18/wifi-mwifiex-replace-one-element-arrays-with-flexibl.patch
queue-6.18/sctp-fix-soft-lockup-from-unpadded-asconf-ack-parame.patch
queue-6.18/net-cap-tx_queue_len-at-s16_max-to-prevent-oversized.patch
queue-6.18/bluetooth-btusb-fix-uaf-of-btusb_data-by-rx_work.patch
queue-6.18/wifi-cfg80211-harden-cfg80211_defragment_element.patch
queue-6.18/arm-tegra-tf600t-invert-accelerometer-calibration-ma.patch
queue-6.18/isofs-handle-set_blocksize-failures.patch
queue-6.18/bootconfig-fix-integer-overflow-in-initrd-size-check.patch
queue-6.18/perf-powerpc-vpadtl-fix-raw_size-of-dtl-samples.patch
queue-6.18/pds_core-don-t-release-pci-regions-for-vfs-on-reset.patch
queue-6.18/drm-amdgpu-harden-fru-pia-parsing-with-bounded-helpe.patch
queue-6.18/xprtrdma-add-request-pool-slack-for-delayed-recyclin.patch
queue-6.18/bpftool-pass-host-flags-to-bootstrap-libbpf.patch
queue-6.18/alsa-hda-realtek-add-mute-led-quirk-for-hp-laptop-14.patch
queue-6.18/btrfs-fix-the-possible-bioc_list-memory-leak-during-.patch
queue-6.18/wifi-nl80211-check-link-is-beaconing-for-color-chang.patch
queue-6.18/f2fs-validate-inline-dentry-name-lengths-before-conv.patch
queue-6.18/md-raid5-account-discard-io.patch
queue-6.18/net-ethernet-oa_tc6-improve-the-error-recovery.patch
queue-6.18/i2c-designware-global-register-definitions.patch
queue-6.18/x86-mm-pat-allocate-split-page-tables-as-kernel-page-tables.patch
queue-6.18/net-ethernet-oa_tc6-interrupt-is-active-low-level-tr.patch
queue-6.18/asoc-codecs-rk3328-use-managed-gpio-and-clock-helper.patch
queue-6.18/net-dsa-mv88e6xxx-fix-number-of-g1-interrupts-for-63.patch
queue-6.18/alsa-hda-cs35l41-imply-serial_multi_instantiate.patch
queue-6.18/dm-raid-only-requeue-bios-when-dm-is-suspending.patch
queue-6.18/drm-amdkfd-fix-smi-event-cross-process-information-l.patch
queue-6.18/drm-panel-jadard-jd9365da-h3-set-prepare_prev_first.patch
queue-6.18/drm-amd-display-propagate-hdmi-rgb-quantization-selectability.patch
queue-6.18/ksmbd-apply-create-security-descriptor-first.patch
queue-6.18/net-mlx5-e-switch-fix-use-after-free-in-mlx5_eswitch.patch
queue-6.18/net-mlx5-register-sf-resource-on-pf-port-representor.patch
queue-6.18/landlock-transpose-the-layer-masks-data-structure.patch
queue-6.18/reapply-bnxt_en-bring-back-rtnl_lock-in-the-bnxt_open-path.patch
queue-6.18/landlock-clarify-documentation-for-the-ioctl-access-right.patch
queue-6.18/smb-move-copychunk-definitions-to-common-smb2pdu.h.patch
queue-6.18/wifi-rtw89-disable-htc-field-in-ap-mode.patch
queue-6.18/wifi-iwlwifi-mvm-add-a-check-on-the-tid-coming-from-.patch
queue-6.18/bpf-reject-redirect-helpers-without-a-bpf_net_contex.patch
queue-6.18/net-ethernet-cortina-finish-rx-updates-before-napi-c.patch
queue-6.18/net-rds-fix-tcp-stream-corruption-with-large-pages.patch
queue-6.18/drivers-of-validate-live-tree-string-properties-befo.patch
queue-6.18/net-net_failover-fix-the-deadlock-in-net_failover_sl.patch
queue-6.18/scsi-qla2xxx-zero-dport-diagnostics-buffer-to-avoid-info-leak.patch
queue-6.18/selftests-powerpc-tm-fix-tcheck-reading-uninitialise.patch
queue-6.18/octeontx2-af-fix-pf-cgx-debugfs-pci-bus-lookup.patch
queue-6.18/nfs-fix-eof-updates-after-nfsv4.2-fallocate-zero-ran.patch
queue-6.18/btrfs-fix-transaction-use-after-free-in-raid-stripe-.patch
queue-6.18/mailbox-imx-use-devm_of_platform_populate.patch
queue-6.18/wifi-rtw88-add-null-check-for-chip-edcca_th-in-rtw_f.patch
queue-6.18/tracing-add-boot-time-backup-of-persistent-ring-buff.patch
queue-6.18/blk-cgroup-protect-iterating-blkgs-with-blkcg-lock-i.patch
queue-6.18/watchdog-imx7ulp_wdt-keep-wdog-running-until-a55-ent.patch
queue-6.18/drm-amdgpu-add-first-record-offset-check.patch
queue-6.18/wifi-ralink-rt2x00-init-eeprom-properly.patch
queue-6.18/edac-igen6-fix-channel-selection-hash.patch
queue-6.18/mmc-davinci-avoid-null-deref-of-host-data-in-irq-han.patch
queue-6.18/wifi-iwlwifi-bound-aligned-tlv-advance-in-fw-parser.patch
queue-6.18/smb-client-fix-security-flag-calculation-when-setting-security-descriptors.patch
queue-6.18/smb-client-validate-new-eof-for-zero-range.patch
queue-6.18/asoc-rt712-sdca-reset-codec-at-io_init-to-fix-silent.patch
queue-6.18/smb-client-refactor-acl-setting-control-flow-in-id_mode_to_cifs_acl.patch
queue-6.18/drm-panel-edp-add-lg-lp129wt232166-panel.patch
queue-6.18/net-sched-fq_pie-clamp-quantum-in-change-path.patch
queue-6.18/smb-client-fix-races-in-cifsd-thread-creation.patch
queue-6.18/netlabel-fix-ipv6-unlabeled-address-add-error-handli.patch
queue-6.18/drm-renesas-rzg2l_mipi_dsi-fix-deassert-assert-of-cm.patch
queue-6.18/drm-rockchip-dw_dp-select-drm_bridge_connector.patch
queue-6.18/asoc-ux500-deassert-the-msp-reset-during-probe.patch
queue-6.18/bluetooth-btintel-bound-firmware-id-by-tlv-length.patch
queue-6.18/acpica-prevent-adding-invalid-references.patch
queue-6.18/hwmon-ina2xx-decouple-in0-and-curr1-alarms.patch
queue-6.18/wifi-mac80211-clarify-beacon-parsing-with-mbssid-ema.patch
queue-6.18/dpaa2-switch-fix-handling-of-napi-on-the-remove-path.patch
queue-6.18/ppp-ppp_synctty-simplify-tty-disc_data-access.patch
queue-6.18/drm-panel-enable-gpiolib-for-panels-which-uses-funct.patch
queue-6.18/drivers-hv-vmbus-add-vtl2-redirect-connection-id.patch
queue-6.18/tools-nolibc-avoid-call-to-wcslen-in-_start_c-insert.patch
queue-6.18/alsa-usb-audio-caiaq-validate-ep1-reply-lengths.patch
queue-6.18/ima-return-error-early-if-file-xattr-cannot-be-chang.patch
queue-6.18/net-airoha-enable-rx_done-interrupt-for-rx-queue-31.patch
queue-6.18/drm-amd-display-rebuild-infoframes-on-output-color-space-changes.patch
queue-6.18/dibs-unregister-dibs_class-after-error.patch
queue-6.18/net-dsa-qca8k-add-support-for-force-mode-for-fixed-l.patch
queue-6.18/soc-tegra-fuse-register-nvmem-lookups-at-probe.patch
queue-6.18/mmc-renesas_sdhi-add-of-entry-for-rz-g2e-soc.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-255-15.6-inch-g9-n.patch
queue-6.18/asoc-amd-yc-add-alienware-m15-r7-amd-to-dmic-quirk-t.patch
queue-6.18/acpica-add-boundary-checks-in-two-places.patch
queue-6.18/wifi-iwlwifi-pcie-add-two-lnl-pci-ids.patch
queue-6.18/fbcon-don-t-suspend-resume-when-vc-is-graphics-mode.patch
queue-6.18/mips-cps-assemble-jr.hb-with-an-r2-isa-level.patch
queue-6.18/asoc-fsl-asoc-card-reduce-wm8904-pll-ratio-to-meet-f.patch
queue-6.18/soundwire-intel-move-suspend-tracking-from-trigger-t.patch
queue-6.18/vxlan-mdb-fix-use-after-free-in-vxlan_mdb_remote_src.patch
queue-6.18/net-stmmac-add-stmmac_tso_header_size.patch
queue-6.18/btrfs-balance-fix-potential-bg-lookup-failure-in-btr.patch
queue-6.18/net-usb-cx82310_eth-drop-urb-after-0xffff-reboot-sen.patch
queue-6.18/asoc-rockchip-spdif-restore-regcache-cache-only-mode.patch
queue-6.18/pinctrl-renesas-rzv2m-use-enotsupp-instead-of-eopnot.patch
queue-6.18/media-em28xx-video-fix-missing-res_free-on-init_usb_.patch
queue-6.18/net-sched-act_api-size-the-rtm_getaction-reply-from-.patch
queue-6.18/vxlan-reject-dynamic-fdb-entries-that-reference-a-ne.patch
queue-6.18/asoc-intel-avs-clean-up-streams-if-their-initializat.patch
queue-6.18/genirq-manage-make-nmi-cleanup-rt-safe.patch
queue-6.18/net-mlx5e-fix-setting-rs-fec-after-remapping.patch
queue-6.18/asoc-ux500-validate-msp-dai-configuration.patch
queue-6.18/drm-amdgpu-use-atomic-operation-to-achieve-lockless-.patch
queue-6.18/thunderbolt-avoid-reserved-fields-in-path-config-spa.patch
queue-6.18/net-ethernet-cortina-count-rx-descriptors-for-freeq-.patch
queue-6.18/ksmbd-fix-sd_ndr.data-memory-leak-in-ksmbd_vfs_set_s.patch
queue-6.18/apparmor-propagate-enomem-correctly-in-unpack_table.patch
queue-6.18/bpf-fix-null-ptr-deref-when-showing-a-void-btf-type.patch
queue-6.18/net-stmmac-reconfigure-rx-packet-parser-table-in-stm.patch
queue-6.18/revert-arm64-dts-qcom-qcs6490-rb3gen2-fix-the-pcie-i.patch
queue-6.18/drm-amdgpu-bound-gpio-i2c-table-entry-count-from-vbi.patch
queue-6.18/alsa-usb-audio-add-quirk-for-yamaha-cds3000.patch
queue-6.18/drm-amdgpu-userq-pin-mqd-and-fw-object-bo-to-avoid-e.patch
queue-6.18/alsa-usb-audio-add-db-map-quirk-for-razer-barracuda-.patch
queue-6.18/raw-annotate-disconnect-side-ipv4-match-writers.patch
queue-6.18/drm-amdgpu-pm-fix-smartshift-bias-sysfs-store-pm-ref.patch
queue-6.18/net-hsr-require-valid-eot-supervision-tlv.patch
queue-6.18/bluetooth-iso-fix-malformed-iso_end-cont-handling.patch
queue-6.18/hwmon-adt7462-add-of_match_table-to-support-devicetr.patch
queue-6.18/bluetooth-btmtk-declare-mt7920-mt7961-1a-bluetooth-f.patch
queue-6.18/wifi-ath11k-fix-invalid-data-access-in-ath11k_dp_rx_.patch
queue-6.18/net-remove-conflicting-altnames-for-dying-netns-in-_.patch
queue-6.18/net-sun4i-emac-fix-missing-of_node_put-for-phy_node.patch
queue-6.18/bpf-track-verifier-instruction-stats-for-each-subpro.patch
queue-6.18/bnxt_en-handle-buffer-allocation-failure-in-bnxt_rx_ring_reset.patch
queue-6.18/revert-arm64-dts-qcom-kodiak-fix-the-pcie-iommu-map-.patch
queue-6.18/bluetooth-btmtk-disable-remote-wakeup-for-mt7922-mt7.patch
queue-6.18/rdma-mlx5-use-qp-port-when-decoding-responder-cqes.patch
queue-6.18/nvme-tcp-defer-tls-inline-send-to-io_work.patch
queue-6.18/net-ibm-emac-reserve-vlan-header-in-mjs-limit.patch
queue-6.18/drm-amdkfd-fix-oob-memory-exposure-in-get_wave_state.patch
queue-6.18/devlink-refactor-resource-functions-to-be-generic.patch
queue-6.18/drm-rz-du-ensure-correct-suspend-resume-ordering-wit.patch
queue-6.18/x86-mm-pat-convert-split_large_page-to-use-ptdescs.patch
queue-6.18/drm-amdkfd-check-find_first_zero_bit-before-__set_bi.patch
queue-6.18/scsi-qla2xxx-skip-vport-under-deletion-in-report-id-acquisition.patch
queue-6.18/landlock-fix-use-after-free-of-the-source-s-parent-directory.patch
queue-6.18/scsi-qla2xxx-fix-soft-lockup-polling-continuation-iocb-signature.patch
queue-6.18/asoc-rt5645-perform-the-initial-jack-detect-at-probe.patch
queue-6.18/ipv6-null-check-fib6_node-before-accessing-in-__ip6_.patch
queue-6.18/net-rds-don-t-let-rds_conn_shutdown-consume-a-concur.patch
queue-6.18/sctp-fix-a-toctou-race-in-sctp_cmd_timer_start.patch
queue-6.18/netfs-fix-subreq-ref-leak.patch
queue-6.18/sched-make-class_schedulers-avoid-pushing-current-an.patch
queue-6.18/alsa-usb-audio-add-quirk-for-corsair-virtuoso-later-.patch
queue-6.18/net-wwan-t7xx-add-delay-between-md-and-sap-suspend.patch
queue-6.18/asoc-amd-yc-add-dmi-quirk-for-hp-victus-laptop-16-e1.patch
queue-6.18/bluetooth-btrtl-add-the-support-for-rtl8761cuv.patch
queue-6.18/netfs-fix-unbuffered-dio-write-partial-transfer-erro.patch
queue-6.18/netfilter-nf_conntrack_sip-fix-oob-read-in-sip_skip_.patch
queue-6.18/revert-arm64-dts-qcom-sm8550-fix-the-pcie-iommu-map-.patch
queue-6.18/vdpa-ifcvf-handle-dev_set_name-failure-in-ifcvf_vdpa.patch
queue-6.18/mmc-core-add-validation-for-host-provided-max_segs.patch
queue-6.18/drm-amdkfd-check-bounds-on-allocate_doorbell.patch
queue-6.18/pci-switchtec-add-gen6-device-ids.patch
queue-6.18/wifi-mt76-transform-aspm_conf-for-pci_disable_link_s.patch
queue-6.18/sched_ext-fix-nonexistent-field-in-sched-ext.rst-exa.patch
queue-6.18/wifi-rtw89-8851bu-add-mercusys-ma60xnb-2c4e-0128.patch
queue-6.18/bridge-add-missing-read_once-annotations-around-fdb-.patch
queue-6.18/bnxt-fix-head-underflow-on-xdp-head-grow.patch
queue-6.18/acpica-add-boundary-checks-in-acpi_ps_get_next_field.patch
queue-6.18/vsock-use-sk_acceptq_is_full-helper-in-all-transport.patch
queue-6.18/hwmon-corsair-cpro-create-debugfs-entries-after-hwmo.patch
queue-6.18/ksmbd-use-memcmp-to-compare-clientguids.patch
queue-6.18/wifi-iwlwifi-mvm-validate-mac_link_id-in-session-pro.patch
queue-6.18/xen-gntalloc-validate-grant-count-before-allocation.patch
queue-6.18/fwctl-bnxt_en-move-common-definitions-to-include-linux-bnxt.patch
queue-6.18/irqchip-gic-v4-don-t-advertise-vlpis-if-no-its-is-pr.patch
queue-6.18/bpf-nul-terminate-replaced-sysctl-value.patch
queue-6.18/scsi-qla2xxx-fix-use-after-free-of-qpair-work-on-queue-teardown.patch
queue-6.18/net-gro-fix-nesting-of-tcp-gso-skbs-in-skb_gro_recei.patch
queue-6.18/idpf-introduce-local-idpf-structure-to-store-virtchnl-queue-chunks.patch
queue-6.18/idpf-disable-dim-work-before-freeing-q_vectors.patch
queue-6.18/drm-amdkfd-unwind-debug-trap-enable-on-copy_to_user-.patch
queue-6.18/usb-gadget-goku_udc-avoid-null-deref-of-dev-driver-i.patch
queue-6.18/net-ethernet-mtk_eth_soc-avoid-writing-to-esw-regist.patch
queue-6.18/perf-risc-v-check-cpu_hw_evt-before-dereference-in-o.patch
queue-6.18/tty-serial-8250-protect-against-null-uart-port.dev-i.patch
queue-6.18/acpica-add-validation-for-node-in-acpi_ns_build_norm.patch
queue-6.18/net-sched-cls_route-free-emptied-bucket-on-filter-mo.patch
queue-6.18/scsi-bfa-reduce-kernel-stack-usage-in-bfa_fcs_lport_.patch
queue-6.18/thunderbolt-verify-pcie-adapter-in-detect-state-befo.patch
queue-6.18/iommu-riscv-add-command-queue-lock.patch
queue-6.18/bluetooth-l2cap-clear-flag_defer_setup-only-for-same.patch
queue-6.18/drm-bridge-tc358768-set-pre_enable_prev_first-for-re.patch
queue-6.18/net-hns3-improve-the-unused_tuple-parameter-setting.patch
queue-6.18/bluetooth-btintel_pcie-add-50-ms-delay-before-mac-in.patch
queue-6.18/hwmon-ina2xx-parameterize-ina2xx_data-in-ina226_aler.patch
queue-6.18/bluetooth-l2cap-validate-connectionless-psm-length.patch
queue-6.18/iommu-amd-do-not-reallocate-ga-log-buffers-on-resume.patch
queue-6.18/acpica-enhance-oem-id-and-table-id-validation-in-acp.patch
queue-6.18/erofs-add-sysfs-feature-entry-for-xattr-prefixes.patch
queue-6.18/ksmbd-break-rh-leases-before-delete-on-close.patch
queue-6.18/rdma-umem-be-careful-about-boundary-conditions-in-ib.patch
queue-6.18/bitfield-wire-__bf_shf-to-__builtin_ctzll.patch
queue-6.18/octeontx2-af-fix-limiting-sriov-vf-count-logic.patch
queue-6.18/net-lan966x-restore-rx-state-on-reload-failure.patch
queue-6.18/hfs-rework-hfsplus_readdir-logic.patch
queue-6.18/ipv6-honor-oif-when-choosing-nexthop-for-locally-gen.patch
queue-6.18/idpf-account-for-vlan-header-when-parsing-rsc-packet.patch
queue-6.18/fbdev-pm2fb-unwind-wc-setup-on-probe-failure.patch
queue-6.18/wifi-iwlwifi-mvm-fix-sched-scan-ie-sizing.patch
queue-6.18/phonet-check-register_netdevice_notifier-error-in-ph.patch
queue-6.18/wifi-mac80211-ibss-wait-for-in-flight-tx-on-disconne.patch
queue-6.18/asoc-ab8500-repair-the-dapm-capture-graph.patch
queue-6.18/rtc-aspeed-add-ast2700-compatible.patch
queue-6.18/thermal-drivers-qcom-tsens-atomic-temperature-read-w.patch
queue-6.18/nvme-core-align-fabrics_q-teardown-with-admin_q-in-n.patch
queue-6.18/bpftool-strip-all-wformat-flags-from-bootstrap-libbp.patch
queue-6.18/virtio-fs-avoid-double-free-on-failed-queue-setup.patch
queue-6.18/net-mlx5-relax-capability-check-for-eswitch-query-pa.patch
queue-6.18/net-cpsw_new-unregister-devlink-on-port-registration.patch
queue-6.18/thunderbolt-improve-multi-display-displayport-tunnel.patch
queue-6.18/alsa-ump-do-not-touch-legacy_rmidi-before-it-exists.patch
queue-6.18/igmp-convert-struct-ip_sf_list-to-rcu.patch
queue-6.18/cifs-fix-support-for-creating-sfu-socket.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-victus-16-e0xxx-88.patch
queue-6.18/net-icmp-avoid-invalid-transport-header-access-in-ic.patch
queue-6.18/pci-avoid-sbr-for-qualcomm-wcn6855-wcn7850-wifi-sdx6.patch
queue-6.18/nvme-remove-stale-namespaces-by-nsid-range-during-sc.patch
queue-6.18/rdma-irdma-replace-waitqueue-and-flag-with-completio.patch
queue-6.18/drm-amdgpu-check-and-drop-invalid-bad-page-records.patch
queue-6.18/wifi-cfg80211-validate-rx-tx-mlme-callback-frame-len.patch
queue-6.18/ksmbd-treat-unnamed-data-stream-as-base-file.patch
queue-6.18/net-ipv6-clamp-to-ip6_max_mtu-in-ip6_dst_mtu_maybe_f.patch
queue-6.18/smb-client-fix-data-corruption-in-emulated-insert-ra.patch
queue-6.18/sched-core-call-wq_worker_tick-for-the-execution-con.patch
queue-6.18/rdma-counter-fix-num_counters-leak-on-bind_qp-failur.patch
queue-6.18/soundwire-validate-dt-compatible-before-parsing-it.patch
queue-6.18/dibs-remove-reset-of-static-vars-in-dibs_init.patch
queue-6.18/net-txgbe-fix-phylink-leak-on-aml-init-failure.patch
queue-6.18/drm-amdgpu-add-a-helper-to-calculate-ring-distance.patch
queue-6.18/ras-amd-atl-edac-amd64-only-load-atl-when-needed.patch
queue-6.18/f2fs-validate-move_range-destination-size.patch
queue-6.18/coresight-perf-retrieve-path-and-source-from-event-d.patch
queue-6.18/watchdog-lenovo_se10_wdt-fix-use-after-free-and-reso.patch
queue-6.18/net-ibm-emac-fix-unchecked-platform_get_irq-return-v.patch
queue-6.18/platform-x86-msi-ec-add-support-for-msi-pulse-gl66-1.patch
queue-6.18/gfs2-fix-quota-init-duplicate-scan.patch
queue-6.18/perf-x86-intel-uncore-guard-against-invalid-box-cont.patch
queue-6.18/wifi-rtw89-phy-check-length-before-parsing-phy-statu.patch
queue-6.18/drm-panel-edp-add-boe-nt140whm-n4t-boe-nt140whm-t05-.patch
queue-6.18/asoc-intel-avs-clean-up-the-bus-when-fetching-ml-cap.patch
queue-6.18/wifi-mac80211-always-allow-transmitting-null-data-on.patch
queue-6.18/usb-serial-spcp8x5-don-t-store-usb_device_id.patch
queue-6.18/watchdog-lenovo_se10_wdt-add-support-for-se10-gen-2-.patch
queue-6.18/erofs-add-missing-buf-off-in-erofs_bread.patch
queue-6.18/net-mlx5e-fix-missing-fec-mode-mapping-for-rs_544_51.patch
queue-6.18/spi-spi-qcom-qspi-fix-incomplete-error-handling-in-r.patch
queue-6.18/hwmon-aspeed-pwm-tacho-propagate-reset-deassert-erro.patch
queue-6.18/tipc-dont-send-random-pad-bytes-in-reset-activate-me.patch
queue-6.18/ksmbd-don-t-hold-ci-m_lock-while-waiting-for-a-lease.patch
queue-6.18/watchdog-msc313e-fix-clock-leak-and-spurious-timer-i.patch
queue-6.18/sched_ext-fix-vtime-delta-loss-in-scx_flatcg-cgroup-.patch
queue-6.18/rtc-cmos-use-platform_get_irq_optional-in-cmos_platf.patch
queue-6.18/mptcp-pm-reset-retrans_time-when-add_addr-entry-is-reused.patch
queue-6.18/wifi-iwlwifi-pcie-fix-acpi-dsm-check.patch
queue-6.18/x86-itmt-don-t-make-itmt-enablement-depend-on-debugf.patch
queue-6.18/nvme-fc-do-not-cancel-requests-in-io-target-before-i.patch
queue-6.18/drm-arm-malidp-use-clk_bulk-api-in-runtime-pm-resume.patch
queue-6.18/scsi-qla2xxx-unlink-nvme-unsol-ctx-before-freeing-on-ls-reject-error.patch
queue-6.18/asoc-amd-yc-fix-memory-leak-in-acp6x_pdm_dma_close.patch
queue-6.18/acpica-validate-handler-object-type-in-two-places.patch
queue-6.18/sched-rt-dl-skip-migrate-disabled-tasks-when-picking.patch
queue-6.18/tcp-remove-icsk-icsk_retransmit_timer.patch
queue-6.18/drm-amd-display-honor-broadcast-rgb-for-bt.2020-rgb-output.patch
queue-6.18/ppp-ppp_async-simplify-tty-disc_data-access.patch
queue-6.18/drm-gma500-return-errors-from-oaktrail-hdmi-i2c-read.patch
queue-6.18/s390-time-use-jiffies-instead-of-jiffies_64.patch
queue-6.18/alsa-hda-cs35l56-fail-if-wmfw-file-is-missing.patch
queue-6.18/pci-iproc-protect-root-bus-removal-with-rescan-lock.patch
queue-6.18/printk-nbcon-change-nbcon_irq_work-to-irq_work_lazy.patch
queue-6.18/dpaa2-switch-fix-the-error-path-in-dpaa2_switch_rx.patch
queue-6.18/usbip-vhci_hcd-fix-null-deref-in-status_show_vhci.patch
queue-6.18/usb-gadget-udc-skip-pullup-if-already-connected.patch
queue-6.18/firmware-stratix10-svc-fix-fcs-smc-call-kernel-doc.patch
queue-6.18/scsi-qla2xxx-null-out-freed-pointers-in-qla2x00_mem_alloc-error-path.patch
queue-6.18/wifi-mac80211-unify-link-sta-removal-in-vif-link-rem.patch
queue-6.18/watchdog-msc313e-fix-undefined-behavior.patch
queue-6.18/bluetooth-btusb-mt7925-add-vid-pid-0e8d-8c38.patch
queue-6.18/fs-ntfs3-validate-index-entry-key-bounds.patch
queue-6.18/idpf-fix-kernel-doc-descriptions-to-avoid-warnings.patch
queue-6.18/net-stmmac-xgmac2-disable-rbue-in-default-rx-interru.patch
queue-6.18/iio-adc-qcom-spmi-iadc-balance-enable_irq_wake-on-dr.patch
queue-6.18/smb-client-bound-dirent-name-against-end-of-smb-resp.patch
queue-6.18/net-sched-defer-qdisc-freeing-after-failed-creation.patch
queue-6.18/leds-st1202-validate-pattern-input-before-stopping-t.patch
queue-6.18/watchdog-msc313e-sync-timeout-value-if-wdt-was-runni.patch
queue-6.18/alsa-hda-realtek-add-hda_codec_quirk-for-samsung-750.patch
queue-6.18/hwmon-ltc4282-make-sure-clk_init_data-is-fully-initi.patch
queue-6.18/acpica-fix-null-pointer-dereference-in-acpi_ns_custo.patch
queue-6.18/sched-eevdf-fix-rb-augmented-with-multi-fields.patch
queue-6.18/net-sched-dualpi2-clamp-psched_mtu-at-all-call-sites.patch
queue-6.18/virtio_input-stop-callbacks-before-unregistering-inp.patch
queue-6.18/bpf-don-t-predict-jmp32-pointer-vs-zero-comparisons.patch
queue-6.18/asoc-bcm-bcm63xx-publish-the-of-module-aliases.patch
queue-6.18/wifi-rtw89-pci-enable-ltr-based-on-pcie-control-regi.patch
queue-6.18/tee-optee-allow-mt_normal_tagged-shared-memory.patch
queue-6.18/wifi-libertas-reject-short-monitor-tx-frames.patch
queue-6.18/virtio_console-do-not-free-control-out-buffers-on-re.patch
queue-6.18/net-macb-replace-open-coded-implementation-with-napi_schedule.patch
queue-6.18/net-bcmasp-fix-tx_spb_ring_full-checking-same-slot-c.patch
queue-6.18/drm-ttm-tidy-usage-of-local-variables-a-little-bit.patch
queue-6.18/net-dsa-lantiq_gswip-fix-gswip_mdio_phy_fcontx_en-va.patch
queue-6.18/tracing-probes-fix-use-after-free-on-field-name-type.patch
queue-6.18/drm-mediatek-dsi-add-compatible-for-mt8167-dsi.patch
queue-6.18/mptcp-remove-unneeded-read_once-annotation.patch
queue-6.18/crypto-atmel-ecc-add-support-for-atecc608b.patch
queue-6.18/iio-light-stk3310-deal-with-the-ps-interrupt-issue-i.patch
queue-6.18/net-mlx5-switch-vport-hca-cap-helpers-to-kvzalloc.patch
queue-6.18/netfilter-nfnetlink_log-cope-with-concurrent-instanc.patch
queue-6.18/asoc-ux500-propagate-msp-setup-errors.patch
queue-6.18/net-rds-acquire-rds_in_xmit-in-rds_tcp_reset_callbac.patch
queue-6.18/thermal-sysfs-switch-to-use-scnprintf-to-suppress-tr.patch
queue-6.18/drm-amd-ras-fix-cper-ring-debugfs-read-overflow.patch
queue-6.18/hwmon-gpio-fan-take-fan_data-lock-in-gpio_fan_shutdo.patch
queue-6.18/btrfs-scrub-report-the-failing-sector-s-address-not-.patch
queue-6.18/revert-arm64-dts-qcom-sm8150-fix-the-pcie-iommu-map-.patch
queue-6.18/net-mlx5e-fix-use-after-free-race-in-sample_restore_.patch
queue-6.18/btrfs-tree-checker-validate-names-in-root_ref-and-ro.patch
queue-6.18/drop_monitor-perform-u64_stats-updates-under-irq-dis.patch
queue-6.18/alsa-usx2y-drain-pending-us-428-pipe-4-output-comman.patch
queue-6.18/tracing-take-the-reference-before-publishing-the-named-histogram-trigger.patch
queue-6.18/asoc-mt6351-publish-the-of-module-alias.patch
queue-6.18/rcu-tasks-fix-possible-boot-time-tests-failed-for-th.patch
queue-6.18/virtio-pci-return-irq_handled-after-non-zero-isr.patch
queue-6.18/ksmbd-prevent-out-of-bounds-reads-in-share-config-re.patch
queue-6.18/bpf-share-several-utility-functions-as-internal-api.patch
queue-6.18/net-rds-use-clear_bit_unlock-in-release_refill.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-lenovo-yoga-7-16iap7.patch
queue-6.18/mlxsw-spectrum_ptp-fix-napi_gro_receive-call-from-gc.patch
queue-6.18/ksmbd-fix-n.data-memory-leak-in-ksmbd_vfs_set_dos_at.patch
queue-6.18/wifi-mac80211-validate-deauth-frame-length-before-re.patch
queue-6.18/spi-dw-fix-wrong-rx_sample_dly-setting-after-resume.patch
queue-6.18/crypto-atmel-sha204a-remove-sysfs-group-before-hwrng.patch
queue-6.18/bonding-do-not-clear-curr_active_slave-prematurely-w.patch
queue-6.18/io_uring-rw-end-write-accounting-from-ki_complete.patch
queue-6.18/net-sched-act_api-fix-skb-sizing-and-action-leak-on-.patch
queue-6.18/octeontx2-af-mcs-clear-stale-x2p-calibration-state-b.patch
queue-6.18/mfd-db8500-prcmu-fold-dbx500-header-into-db8500.patch
queue-6.18/ipv6-sr-restore-network-header-before-routing-and-fo.patch
queue-6.18/bluetooth-btusb-mediatek-fix-leaked-runtime-pm-refer.patch
queue-6.18/ionic-use-netif_txq_maybe_stop-in-ionic_tx.patch
queue-6.18/acpica-improve-argument-parsing-in-acpi_ps_get_next_.patch
queue-6.18/net-macb-use-netif_napi_add_tx-instead-of-netif_napi_add-for-tx-napi.patch
queue-6.18/drm-gud-add-rcade-display-adapter-vid-pid-pair.patch
queue-6.18/xen-front-pgdir-shbuf-free-grant-reference-head-on-e.patch
queue-6.18/ksmbd-rate-limit-unmapped-sid-errors.patch
queue-6.18/bpf-mark-sched_process_wait-argument-as-nullable.patch
queue-6.18/s390-ipl-fix-null-deref-in-kdump-without-re-ipl-parm.patch
queue-6.18/ata-libata-core-disable-lpm-on-wdc-wd141kfgx-68fh9n0.patch
queue-6.18/smb-client-flush-dirty-data-before-punching-a-hole.patch
queue-6.18/rdma-umem-make-ib_umem_is_contiguous-safe-on-32-bit.patch
queue-6.18/bpf-reject-untrusted-allocated-object-pointers.patch
queue-6.18/idpf-introduce-idpf_q_vec_rsrc-struct-and-move-vector-resources-to-it.patch
queue-6.18/mmc-davinci-fix-mmc_add_host-order-in-probe.patch
queue-6.18/media-remove-conditional-return-with-no-effect.patch
queue-6.18/cachefiles-fix-potential-uaf-kasan-warning.patch
queue-6.18/pci-mediatek-protect-root-bus-removal-with-rescan-lo.patch
queue-6.18/bonding-use-skb_cow_head-in-bond_do_alb_xmit-and-rlb.patch
queue-6.18/scripts-modpost-detect-and-report-truncated-buf_prin.patch
queue-6.18/i3c-mipi-i3c-hci-tolerate-i3c_master_add_i3c_dev_loc.patch
queue-6.18/usb-gadget-aspeed_udc-avoid-past-the-end-iterator-in.patch
queue-6.18/media-chips-media-wave5-release-m2m_ctx-after-instan.patch
queue-6.18/asoc-ux500-request-the-msp-mmio-resource.patch
queue-6.18/sched-fair-reject-misfit-pulls-onto-busy-smt-sibling.patch
queue-6.18/crypto-ccp-fix-possible-deadlock-in-sev-init-failure.patch
queue-6.18/drm-pagemap-dma-unmap-pages-before-handling-migration-errors.patch
queue-6.18/wifi-rsi-validate-beacon-length-before-fixed-buffer-.patch
queue-6.18/drm-xe-guc-add-support-for-no_response_busy-in-ctb.patch
queue-6.18/pci-sysfs-add-cap_sys_admin-check-to-__resource_resi.patch
queue-6.18/netfs-fix-i_size-update-for-partial-transfer.patch
queue-6.18/octeontx2-pf-reset-htb-scheduler-topology-before-fre.patch
queue-6.18/fuse-set-ff-flock-only-on-success.patch
queue-6.18/f2fs-limit-recovery-filename-logging-to-stored-length.patch
queue-6.18/alsa-hda-report-a-change-when-only-the-channel-statu.patch
queue-6.18/net-sched-drr-clamp-quantum-in-change-class.patch
queue-6.18/asoc-ux500-correct-msp-frame-and-bit-clock-setup.patch
queue-6.18/ipv6-mcast-fix-rcu-list-diversion-in-ip6_mc_del1_src.patch
queue-6.18/scsi-mpt3sas-avoid-out-of-bounds-cpumask_of_node-cal.patch
queue-6.18/asoc-intel-sof_sdw-append-dai-type-to-dai-link-name-.patch
queue-6.18/perf-core-allow-list_del-during-perf_event_overflow.patch
queue-6.18/x86-topology-add-missing-struct-declaration-and-attr.patch
queue-6.18/drm-imagination-populate-fw-common-context-id-before.patch
queue-6.18/net-ethernet-cortina-count-dropped-frames-as-napi-wo.patch
queue-6.18/bluetooth-btusb-add-support-for-tp-link-tl-ub250.patch
queue-6.18/bluetooth-btintel_pcie-clear-automask-on-spurious-in.patch
queue-6.18/landlock-add-access_mask_subset-helper.patch
queue-6.18/powerpc-kexec_file-use-inclusive-range-checks-for-ex.patch
queue-6.18/asoc-ux500-allow-repeated-msp-prepare-calls.patch
queue-6.18/asoc-intel-sof_sdw-add-quirks-for-new-dell-laptops.patch
queue-6.18/drm-logicvc-drop-the-select-of-the-nonexistent-confi.patch
queue-6.18/workqueue-reject-watchdog-thresholds-that-overflow-j.patch
queue-6.18/mailbox-imx-add-a-channel-shutdown-field.patch
queue-6.18/selftests-alsa-fix-the-step-check-for-integer-contro.patch
queue-6.18/scsi-qla2xxx-serialize-nvme-unsol-ctx-list-with-a-per-fcport-lock.patch
queue-6.18/smb-client-fail-dacl-rewrite-when-the-new-dacl-exceeds-64k.patch
queue-6.18/net-ks8851-fix-receiver-error-in-100base-tx-mode-fol.patch
queue-6.18/ata-libata-pmp-add-jmicron-jms562-quirk.patch
queue-6.18/net-ipv6-fix-udp-length-overflow-with-pmtu-discover-.patch
queue-6.18/alsa-pcm-serialize-pcm-mmap-with-buffer-reallocation.patch
queue-6.18/drm-amdkfd-fix-uaf-race-in-destroy_queue_cpsch.patch
queue-6.18/bridge-do-not-suppress-arp-probes-and-dad-ns-uncondi.patch
queue-6.18/s390-zcore-removed-unused-variables.patch
queue-6.18/scsi-qla2xxx-use-ring-slot-helpers-in-__qla2x00_alloc_iocbs.patch
queue-6.18/net-macb-fix-null-pointer-dereference-on-unbind-with.patch
queue-6.18/revert-arm64-dts-qcom-sm8250-fix-the-pcie-iommu-map-.patch
queue-6.18/bluetooth-l2cap-fix-out-of-bounds-write-in-l2cap_ecr.patch
queue-6.18/drm-imagination-don-t-timeout-job-if-its-fence-has-b.patch
queue-6.18/rdma-mlx5-create-odp-eq-for-non-pinned-dmabuf-mrs.patch
queue-6.18/iommu-arm-smmu-v3-disable-implementations-during-dev.patch
queue-6.18/befs-handle-set_blocksize-failures.patch
queue-6.18/drm-dp-add-dsc-virtual-dpcd-quirk-for-realtek-mst-br.patch
queue-6.18/i3c-master-svc-prevent-irq-storm-from-false-slvstart.patch
queue-6.18/net-mlx5-lag-use-local-tracker-to-update-active-port.patch
queue-6.18/nvmet-rdma-fix-queue-leak-when-connect-backlog-is-ex.patch
queue-6.18/netfs-break-unbuffered-write-when-netfs_alloc_subreq.patch
queue-6.18/spi-dw-dma-wait-for-controller-idle-before-completin.patch
queue-6.18/acpica-validate-byte_count-in-acpi_ps_get_next_packa.patch
queue-6.18/perf-ftrace-fix-warning-in-__unregister_ftrace_funct.patch
queue-6.18/bluetooth-hci_sysfs-fix-null-pointer-dereference-in-.patch
queue-6.18/edac-igen6-fix-channel-address-decode-for-non-hash-m.patch
queue-6.18/af_unix-update-last-skb-marker-in-manage_oob.patch
queue-6.18/hid-multitouch-fix-yoga-book-9-14iah10-touchscreen-m.patch
queue-6.18/btrfs-do-not-force-reloc-root-creation-during-qgroup.patch
queue-6.18/drm-amdgpu-prefer-rom-bar-for-default-vga-device.patch
queue-6.18/ntfs3-fix-out-of-bounds-read-in-ntfs_dir_emit-and-hd.patch
queue-6.18/f2fs-fix-to-reclaim-space-in-f2fs_allocate_pinning_section.patch
queue-6.18/thunderbolt-verify-router-ready-bit-is-set-after-rou.patch
queue-6.18/iommu-amd-add-numa-node-affinity-for-iommu-log-buffe.patch
queue-6.18/drm-gud-validate-gud_rotation_0-is-present-in-suppor.patch
queue-6.18/ksmbd-propagate-dacl-parsing-errors.patch
queue-6.18/watchdog-msc313e-avoid-division-by-zero.patch
queue-6.18/wifi-cfg80211-validate-ies-in-cfg80211_wext_siwgenie.patch
queue-6.18/scsi-core-do-not-block-on-tag-allocation-in-scsi_eh_.patch
queue-6.18/ata-ahci-fail-probe-if-bar-too-small-for-claimed-por.patch
queue-6.18/wifi-iwlwifi-mld-purge-async-notifications-upon-nic-.patch
queue-6.18/platform-x86-intel-hid-add-hp-probook-x360-440-g1-to.patch
queue-6.18/integrity-check-for-null-returned-by-asymmetric_key_.patch
queue-6.18/bluetooth-btusb-add-realtek-rtl8922ae-vid-pid-0bda-d.patch-27355
queue-6.18/acpica-fix-use-after-free-in-acpi_ds_terminate_contr.patch
queue-6.18/drm-amd-display-fix-dpms-using-partially-updated-pip.patch
queue-6.18/net-rds-use-wq_has_sleeper-in-release_in_xmit.patch
queue-6.18/pci-avoid-flr-for-mediatek-mt7925-wifi.patch
queue-6.18/netfilter-ip6_tables-set-f_proto-when-proto-value-is.patch
queue-6.18/ppp_async-drop-the-errored-frame-instead-of-resettin.patch
queue-6.18/acpi-scan-honor-_dep-for-acpi0016-pci-cxl-host-bridg.patch
queue-6.18/alsa-es18xx-check-control-allocation-before-private-.patch
queue-6.18/pci-wait-for-device-readiness-after-d3hot-d0uninitia.patch
queue-6.18/tracing-set-the-trace-clock-before-registering-the-histogram-trigger.patch
queue-6.18/crypto-omap-add-omap_des_unregister_algs-helper.patch
queue-6.18/acpica-add-package-limit-checks-in-parser-functions.patch
queue-6.18/net-sched-sfq-clamp-quantum-in-change-path.patch
queue-6.18/scsi-pm8001-reject-non-fatal-dump-when-controller-is.patch
queue-6.18/asoc-ux500-fix-msp-stream-lifecycle-handling.patch
queue-6.18/md-raid5-let-stripe-batch-bm_seq-comparison-wrap-saf.patch
queue-6.18/x86-mm-pat-don-t-gate-cpa_lock-on-debug_pagealloc_enabled.patch
queue-6.18/btrfs-tree-checker-validate-inode_ref-s-namelen.patch
queue-6.18/dibs-change-dibs_class-to-a-const-struct.patch
queue-6.18/drm-amdgpu-cap-atom-command-table-nesting-depth.patch
queue-6.18/net-mlx5-hws-handle-destroying-table-that-has-a-miss.patch
queue-6.18/revert-arm64-dts-qcom-sm8750-fix-the-pcie-iommu-map-.patch
queue-6.18/cachefiles-fix-double-fput.patch
queue-6.18/net-bridge-remove-stale-rcu_barrier-in-br_multicast_.patch
queue-6.18/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-6.18/bluetooth-hci_core-fix-race-condition-during-device-.patch
queue-6.18/powerpc-fadump-add-timeout-to-rtas-busy-wait-loops.patch
queue-6.18/asoc-amd-renoir-fix-disable_pdm_interrupts-to-clear-.patch
queue-6.18/wifi-iwlwifi-mvm-validate-tx_cmd-response-layout.patch
queue-6.18/ksmbd-fix-credit-charge-calculation-for-smb2-query_i.patch
queue-6.18/soundwire-dmi-quirks-disable-ghost-realtek-devices.patch
queue-6.18/alsa-seq-remove-arbitrary-prioq-insertion-limit.patch
queue-6.18/ipv4-fib-don-t-dump-dying-fib_info-in-fib_leaf_notif.patch
queue-6.18/clk-samsung-exynos850-mark-apm-i3c-clocks-as-critica.patch
queue-6.18/mfd-tps65219-make-poweroff-handler-conditional-on-sy.patch
queue-6.18/perf-x86-intel-ds-factor-out-pebs-group-processing-c.patch
queue-6.18/clk-renesas-cpg-mssr-add-number-of-clock-cells-check.patch
queue-6.18/btrfs-fix-use-after-free-on-reloc-root-after-error-i.patch
queue-6.18/net-sched-cls_route-fix-in-place-replace.patch
queue-6.18/wifi-rtw89-suspend-dig-when-remain-on-channel.patch
queue-6.18/perf-x86-intel-correct-pt_regs-flags-update-for-pebs.patch
queue-6.18/media-qcom-camss-avoid-format-string-warning.patch
queue-6.18/thunderbolt-don-t-access-path-config-space-on-lane-1.patch
queue-6.18/drm-panel-edp-add-csw-pnb601ls1-2-and-lgd-lp116wha-s.patch
queue-6.18/libbpf-add-__nr_bpf-definition-for-loongarch.patch
queue-6.18/net-ethtool-cmis_cdb-hold-instance-lock-for-ops-lock.patch
queue-6.18/cifs-fix-support-for-creating-sfu-fifo.patch
queue-6.18/accel-qaic-address-potential-out-of-bounds-read-in-r.patch
queue-6.18/smb-client-zero-initialize-stack-allocated-cifs_open.patch
queue-6.18/s390-ism-folio_put-after-error.patch
queue-6.18/btrfs-restore-active-device-pointers-after-failed-sp.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-victus-15-fa0xxx-m.patch
queue-6.18/wifi-iwlwifi-fix-the-access-to-cnvr-top-registers.patch
queue-6.18/net-rds-acquire-the-fastpath-locks-in-rds_conn_shutd.patch
queue-6.18/vhost-vdpa-protect-config_ctx-from-being-freed-under.patch
queue-6.18/revert-f2fs-check-in-memory-block-bitmap.patch
queue-6.18/alsa-hda-conexant-add-pin-config-quirk-for-lenovo-id.patch
queue-6.18/net-amd-xgbe-discard-rx-packets-with-bad-fcs.patch
queue-6.18/net-phy-dp83867-handle-the-active-high-led-polarity-.patch
queue-6.18/genetlink-pin-family-module-during-policy-dump.patch
queue-6.18/qnx4-handle-set_blocksize-failures.patch
queue-6.18/firmware-arm_scmi-validate-sensor_update-payload-siz.patch
queue-6.18/clk-socfpga-agilex-implement-l3_main_free_clk.patch
queue-6.18/9p-use-kvzalloc-for-readdir-buffer.patch
queue-6.18/hwmon-nct6694-do-not-expose-enable-on-dtin-temperatu.patch
queue-6.18/net-bridge-mcast-properly-convert-mglist-to-rcu.patch
queue-6.18/s390-ipl-fix-null-deref-in-dump_reipl-without-re-ipl.patch
queue-6.18/ptp-ocp-add-shutdown-callback.patch
queue-6.18/drivers-of-validate-status-properties-in-reconfig-st.patch
queue-6.18/virtio_input-reset-device-if-input_register_device-f.patch
queue-6.18/ksmbd-use-connection-clientguid-for-lease-lookup.patch
queue-6.18/fs-ntfs3-preserve-non-dos-attribute-bits-in-system.d.patch
queue-6.18/net-mana-restore-the-xdp-program-pointer-when-pre-al.patch
queue-6.18/smb-client-mark-file-sparse-before-emulating-insert-.patch
queue-6.18/sparc-disable-compat-support-with-lld.patch
queue-6.18/locking-lockdep-invalidate-stale-class_cache-entries.patch
queue-6.18/bpf-reject-non-scalar-bpf_loop-iteration-counts.patch
queue-6.18/exit-hold-a-reference-to-thread_pid-across-proc_flush_pid.patch
queue-6.18/xhci-prevent-queuing-new-commands-if-xhci-is-inacces.patch
queue-6.18/media-platform-cros-ec-add-kulnex-and-moxoe-to-the-m.patch
queue-6.18/wifi-mac80211-avoid-out-of-bounds-access-in-monitor.patch
queue-6.18/wifi-iwlwifi-add-support-for-ax231.patch
queue-6.18/ipv6-addrconf-fix-temp-address-generation-after-pref.patch
queue-6.18/crypto-ixp4xx-fix-buffer-chain-unwind-on-allocation-.patch
queue-6.18/bpf-reject-legacy-packet-loads-from-callbacks.patch
queue-6.18/acpi-pci-clear-_dep-dependencies-after-pci-root-brid.patch
queue-6.18/btrfs-only-account-delalloc-bytes-for-regular-file-i.patch
queue-6.18/e1000e-limit-endianness-conversion-to-boundary-words.patch
queue-6.18/net-dsa-mv88e6xxx-enable-.rmu_disable-for-6320-famil.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-lenovo-yoga-pro-7-14i.patch
queue-6.18/ns-add-__ns_ref_read.patch
queue-6.18/asoc-codecs-pcm3168a-prevent-regulator-double-disabl.patch
queue-6.18/net-dsa-bcm_sf2-bound-the-cfp-rule-dump-by-the-calle.patch
queue-6.18/nexthop-initialize-extack-in-remove_nh_grp_entry.patch
queue-6.18/perf-core-skip-empty-aux-records-with-only-format-fl.patch
queue-6.18/btrfs-detach-failed-sprout-device-from-transaction-u.patch
queue-6.18/sctp-unwind-address-notifier-registration-on-failure.patch
queue-6.18/net-usb-qmi_wwan-add-meig-srm813q.patch
queue-6.18/hfsplus-rework-hfsplus_readdir-logic.patch
queue-6.18/omfs-handle-set_blocksize-failures.patch
queue-6.18/wifi-iwlwifi-mvm-fix-a-possible-underflow.patch
queue-6.18/asoc-ux500-program-the-msp-fifo-watermarks.patch
queue-6.18/bpf-mark-faultable-stack-helpers-as-sleepable.patch
queue-6.18/net-rds-tcp-don-t-force-rds_conn_resetting-over-a-co.patch
queue-6.18/net-mlx5e-keep-hw-timestamp-stats-monotonic-across-r.patch
queue-6.18/btrfs-return-proper-negative-error-code-for-update_r.patch
queue-6.18/serial-8250-fix-possible-isr-soft-lockup.patch
queue-6.18/gfs2-move-quota_init-qc-iterator-increment.patch
queue-6.18/alsa-hda-realtek-alc882-fixup-for-clevo-p775tm1.patch
queue-6.18/bpf-print-breakdown-of-insns-processed-by-subprogs.patch
queue-6.18/revert-arm64-dts-qcom-sc8180x-fix-the-pcie-iommu-map.patch
queue-6.18/ice-pass-the-return-value-of-skb_checksum_help.patch
queue-6.18/gpio-usbio-add-acpi-device-id-for-nvl-platforms.patch
queue-6.18/hfsplus-fix-issue-of-direct-writes-beyond-end-of-fil.patch
queue-6.18/virt-acrn-fix-irqfd-use-after-free-during-eventfd-sh.patch
queue-6.18/drm-amdgpu-avoid-force-completing-uninitialized-uvd-rings.patch
queue-6.18/net-stmmac-add-tso-check-for-header-length.patch
queue-6.18/bpf-fix-reg-invariants-violation-on-speculative-poin.patch
queue-6.18/iomap-don-t-make-req_polled-imply-req_nowait.patch
queue-6.18/asoc-rockchip-rockchip_pdm-handle-runtime-pm-resume-.patch
queue-6.18/drm-amd-display-fix-crc-open-failure-during-active-r.patch
queue-6.18/ppc-fadump-invoke-kmsg_dump-in-fadump-panic-path.patch
queue-6.18/wifi-iwlwifi-mvm-fix-an-off-by-1-boundary-check.patch
queue-6.18/psp-validate-ipv4-header-fields-in-psp_dev_rcv.patch
queue-6.18/bpf-report-maximum-combined-stack-depth.patch
queue-6.18/bluetooth-btusb-fix-leaked-runtime-pm-reference-in-b.patch
queue-6.18/asoc-intel-avs-honor-nhlt-override-when-setting-up-a.patch
queue-6.18/revert-arm64-dts-qcom-sar2130p-fix-the-pcie-iommu-ma.patch
queue-6.18/scsi-mpi3mr-fix-null-pointer-dereference-in-mpi3mr_s.patch
queue-6.18/pwm-mediatek-set-mt7628-pwm45_fixup-flag-to-false.patch
queue-6.18/thunderbolt-set-tb-root_switch-to-null-when-domain-i.patch
queue-6.18/drm-amd-pm-si-don-t-schedule-thermal-work-when-queue.patch
queue-6.18/drop_monitor-fix-size-calculations-for-64-bit-attrib.patch
queue-6.18/net-hsr-enable-promiscuous-mode-on-interlink-port-wi.patch
queue-6.18/bpf-fix-null-ptr-deref-in-btf_var_show.patch
queue-6.18/drm-nouveau-bios-skip-the-ifr-header-if-present.patch
queue-6.18/media-chips-media-wave5-fix-reports-from-kernel-lock.patch
queue-6.18/tracing-remove-get_trigger_ops-and-add-count_func-from-trigger-ops.patch
queue-6.18/net-mlx5e-move-representor-vnic-reporter-to-eswitch-.patch
queue-6.18/wifi-iwlwifi-mvm-fix-out-of-bounds-tid_data-access-i.patch
queue-6.18/tipc-fix-null-deref-in-tipc_named_node_up-on-empty-p.patch
queue-6.18/net-ethernet-oa_tc6-handle-the-oa-tc6-spi-protected-.patch
queue-6.18/net-ethernet-oa_tc6-protect-skb-pointer-used-by-two-.patch
queue-6.18/bpf-mark-bpf_btf_find_by_name_kind-as-sleepable.patch
queue-6.18/wifi-mt76-mt7925-add-netgear-a8500-usb-device-id.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-asus-vivobook-x509dap.patch
queue-6.18/smb-client-use-atomic_t-for-mnt_cifs_flags.patch
queue-6.18/drm-amdgpu-use-system-unbound-workqueue-for-soft-ih-.patch
queue-6.18/net-ipv4-fix-udp-length-overflow-with-pmtu-discover-.patch
queue-6.18/wifi-nl80211-increase-ie_len-size-to-prevent-truncat.patch
queue-6.18/watchdog-msc313e-fix-null-pointer-dereference-in-pm-.patch
queue-6.18/nvme-validate-fdp-configuration-descriptor-sizes.patch
queue-6.18/net-phy-motorcomm-use-device-properties-for-firmware.patch
queue-6.18/ns-rename-to-exit_nsproxy_namespaces.patch
queue-6.18/pds_core-quiesce-dma-before-freeing-resources.patch
queue-6.18/selftests-bpf-fix-flaky-bpf_nf-test-when-random-nat-.patch
queue-6.18/btrfs-use-lockless-read-in-nr_cached_objects-shrinke.patch
queue-6.18/media-as102-do-not-rely-on-id-table-address-comparis.patch
queue-6.18/thunderbolt-don-t-disable-lane-adapter-if-xdomain-la.patch
queue-6.18/f2fs-block-cache-dio-write-during-f2fs_enable_checkpoint.patch
queue-6.18/opp-of-fix-potential-multiplication-overflow-when-ca.patch
queue-6.18/kcsan-silence-wmaybe-uninitialized-when-calling-__kc.patch
queue-6.18/net-sfp-add-quirk-for-oem-2.5g-optical-modules.patch
queue-6.18/firmware-arm_scmi-validate-base_error_event-payload-.patch
queue-6.18/ksmbd-validate-smb2-lease-create-contexts.patch
queue-6.18/bus-fsl-mc-wait-for-the-mc-firmware-to-complete-its-.patch
queue-6.18/drm-virtio-fix-a-null-vs-err_ptr-bug-in-virtio_gpu_u.patch
queue-6.18/iio-adc-rtq6056-add-i2c_device_id-support.patch
queue-6.18/ksmbd-start-file-id-allocation-at-1.patch
queue-6.18/mm-damon-core-avoid-infinite-kdamond_merge_regions-i.patch
queue-6.18/revert-arm64-dts-qcom-sdm845-fix-the-pcie-iommu-map-.patch
queue-6.18/net-macb-rename-bp-sgmii_phy-field-to-bp-phy.patch
queue-6.18/net-microchip-sparx5-clean-up-psfp-resources-on-flow.patch
queue-6.18/net-dsa-mv88e6xxx-bound-the-policy-rule-dump-by-the-.patch
queue-6.18/net-mlx5-hws-check-if-device-is-down-while-polling-f.patch
queue-6.18/ufs-do-not-treat-unreadable-directory-blocks-as-empt.patch
queue-6.18/drm-amd-display-set-gpuvm-min-page-size-to-4k-on-dcn.patch
queue-6.18/alsa-usb-audio-propagate-write-errors-in-generic-mix.patch
queue-6.18/rtc-mv-add-suspend-resume-support-for-wakeup.patch
queue-6.18/watchdog-msc313e-fix-spurious-reset-on-suspend.patch
queue-6.18/drm-amdgpu-validate-and-share-psp-fw_pri_buf-copies-.patch
queue-6.18/asoc-ti-omap3pandora-update-board-check-to-use-dt-co.patch
queue-6.18/drm-amdgpu-fix-buffer-overflow-during-vbios-update.patch
queue-6.18/spi-xilinx-let-transfers-timeout-in-case-of-no-irq.patch
queue-6.18/ipmi-si-use-platform_get_irq_optional-to-retrieve-in.patch
queue-6.18/rdma-bnxt_re-proper-rollback-if-the-ioremap-fails.patch
queue-6.18/drm-panel-edp-add-auo-b140xtn07.5-auo-b140hak03.5-au.patch
queue-6.18/iommu-amd-fix-premature-break-in-init_iommu_one-agai.patch
queue-6.18/selftests-cgroup-fix-cg_run_in_subcgroups-ignoring-a.patch
queue-6.18/netfilter-cttimeout-prevent-uaf-during-module-unload.patch
queue-6.18/net-dsa-mv88e6xxx-define-.pot_clear-for-6321.patch
queue-6.18/ksmbd-deny-renaming-directory-with-open-children.patch
queue-6.18/sched-account-cgroup-cpu-time-to-the-execution-conte.patch
queue-6.18/soundwire-intel_auxdevice-add-cs42l43b-to-wake_capab.patch
queue-6.18/bluetooth-btusb-add-support-for-intel-lizard-peak-2-.patch
queue-6.18/asoc-intel-avs-do-not-ignore-enoent-when-loading-a-t.patch
queue-6.18/hpfs-handle-set_blocksize-failures.patch
queue-6.18/ksmbd-validate-sid-namespace-before-mapping-ids.patch
queue-6.18/scsi-qla2xxx-clamp-max_npiv_vports-to-vp_ctrl-bitmap-capacity.patch
queue-6.18/edac-igen6-fix-interleave-boundary-condition.patch
queue-6.18/wifi-rsi-avoid-reading-tkip-mic-keys-for-non-tkip-ci.patch
queue-6.18/asoc-intel-avs-allow-the-topology-to-carry-nhlt-data.patch
queue-6.18/hwmon-pmbus-lm25066-fix-pmbus-coefficients-for-lm506.patch
queue-6.18/drm-amdgpu-ras-add-ras_suspend-callback-and-use-it-f.patch
queue-6.18/perf-x86-intel-prevent-drain_pebs-reentry.patch
queue-6.18/net-airoha-reserve-rx-headroom-to-avoid-skb-realloca.patch
queue-6.18/rdma-mlx5-fix-state-and-counter-desync-on-loopback-e.patch
queue-6.18/wifi-ath11k-cancel-ssr-work-items-during-pci-shutdow.patch
queue-6.18/mptcp-do-not-reschedule-the-rtx-timer-for-fallback-sockets.patch
queue-6.18/net-macb-unify-device-pointer-naming-convention.patch
queue-6.18/wifi-iwlwifi-mld-keep-healthy-link-on-emlsr-missed-b.patch
queue-6.18/riscv-panic-if-irq-handler-stacks-cannot-be-allocate.patch
queue-6.18/asoc-tas2781-update-default-register-address-to-tas2.patch
queue-6.18/md-raid10-fix-writes_pending-and-barrier-reference-l.patch
queue-6.18/alsa-hda-realtek-fix-speakers-on-mechrevo-wujie-seri.patch
queue-6.18/drm-amd-ras-reset-cper-ring-on-corrupt-entry-size.patch
queue-6.18/net-ethernet-oa_tc6-add-the-oa_tc6_-prefix-to-standa.patch
queue-6.18/spi-core-abort-active-target-transfer-on-controller-.patch
queue-6.18/netfs-fix-barriering-when-walking-subrequest-list.patch
queue-6.18/arm-tegra-p880-lower-cpu-thermal-limit.patch
queue-6.18/btrfs-zstd-fix-lost-wakeup-when-waiting-for-a-worksp.patch
queue-6.18/ksmbd-align-smb2-oplock-break-ack-handling.patch
queue-6.18/tls-flush-backlog-before-waiting-for-a-new-record.patch
queue-6.18/drm-amdkfd-let-driver-decide-buffer-size-at-amdkfd_i.patch
queue-6.18/mfd-rsmu-add-8a34002-support.patch
queue-6.18/drm-amdgpu-reorder-ib-schedule-sequence.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-pavilion-x360.patch
queue-6.18/drm-gem-consider-gem-object-reclaimable-if-shrinking.patch
queue-6.18/wifi-iwlwifi-mld-call-iwl_mld_free_ap_early_key-for-.patch
queue-6.18/net-thunderx-fix-ptp-device-ref-leak-in-nicvf_probe.patch
queue-6.18/clk-clk-axi-clkgen-add-support-versal-timings.patch
queue-6.18/net-dsa-mt7530-populate-lpi_interfaces-to-fix-eee-su.patch
queue-6.18/pci-sysfs-use-kstrtobool-to-parse-the-rom-attribute-.patch
queue-6.18/net-sched-cls_u32-fix-duplicate-handle-when-node-id-.patch
queue-6.18/scsi-qla2xxx-use-memset_io-to-clear-qlafx00-request-ring-slot.patch
queue-6.18/bluetooth-rfcomm-validate-skb-length-in-rfcomm_recv_.patch
queue-6.18/asoc-intel-catpt-complete-coredump-handling.patch
queue-6.18/ice-add-missing-xa_destroy-for-sched_node_ids.patch
queue-6.18/asoc-rockchip-rockchip_pdm-reorder-clock-enable-sequ.patch
queue-6.18/wifi-mac80211-explicitly-disable-ftm-responder-on-ap.patch
queue-6.18/net-ethernet-oa_tc6-fix-for-the-wrong-data-type.patch
queue-6.18/affs-handle-set_blocksize-failures.patch
queue-6.18/bpf-reject-bpf_pseudo_func-reference-to-the-main-pro.patch
queue-6.18/net-sched-cls_api-don-t-replay-rtm_getchain-in-tc_ct.patch
queue-6.18/platform-x86-sel3350-platform-retain-led-state-on-lo.patch
queue-6.18/blk-cgroup-fix-leaks-and-online-flag-on-radix_tree_i.patch
queue-6.18/tls-reject-the-combination-of-tls-and-sockmap.patch
queue-6.18/gpib-suppress-setting-end-on-error-from-ni_usb-dongl.patch
queue-6.18/leds-trigger-gpio-use-gpiod_flags_bit_nonexclusive.patch
queue-6.18/bpf-mask-pseudo-pointer-values-in-verifier-logs.patch
queue-6.18/alsa-usb-audio-add-quirk-flags-for-sc13a.patch
queue-6.18/vhost-vdpa-don-t-install-the-eventfd_ctx_fdget-error.patch
queue-6.18/net-ethernet-oa_tc6-disable-tx-queues-on-fatal-error.patch
queue-6.18/wifi-mt76-mt7921-validate-clc-firmware-records.patch
queue-6.18/drm-amd-pm-bound-pp_dpm_set_pp_table-memcpy.patch
queue-6.18/s390-boot-fix-physical-memory-search-range.patch
queue-6.18/arm64-kprobes-allow-reentering-kprobes-while-single-.patch
queue-6.18/arm64-fixmap-allow-256k-early_ioremap-at-any-offset.patch
queue-6.18/wifi-mt76-mt7925-add-320mhz-bandwidth-to-bss_rlm_tlv.patch
queue-6.18/pci-plda-protect-root-bus-removal-with-rescan-lock.patch
queue-6.18/wifi-nl80211-reject-beacons-with-bad-he-operation.patch
queue-6.18/net-ibm-emac-mal-fix-potential-system-hang-in-mal_re.patch
queue-6.18/scsi-qla2xxx-fix-queue-teardown-null-dma_free-and-bitmap-locking.patch
queue-6.18/btrfs-use-on-disk-uuid-for-s_uuid-in-temp_fsid-mount.patch
queue-6.18/hwmon-corsair-cpro-remove-debugfs-entries-when-probe.patch
queue-6.18/vdpa-octeon_ep-use-4-bytes-for-mailbox-signature.patch
queue-6.18/asoc-qcom-q6apm-return-error-code-to-consumers-on-fa.patch
queue-6.18/net-dsa-sja1105-flower-reject-cross-chip-redirect.patch
queue-6.18/af_unix-unlink-scc_entry-in-unix_del_edge.patch
queue-6.18/hid-multitouch-honor-contactcount-for-yoga-book-9-to.patch
queue-6.18/tracing-merge-struct-event_trigger_ops-into-struct-event_command.patch
queue-6.18/hwmon-dell-smm-add-dell-latitude-7530-to-fan-control.patch
queue-6.18/s390-boot-avoid-ipl-parameter-append-past-command-li.patch
queue-6.18/thunderbolt-keep-xdomain-reference-during-the-lifeti.patch
queue-6.18/arm-9484-1-enable-interrupts-when-unhandled-user-fau.patch
queue-6.18/drm-amdgpu-fix-missing-unwind-in-amdgpu_ib_schedule-error-path.patch
queue-6.18/net-mlx5-e-switch-align-disable-sequence-with-switch.patch
queue-6.18/asoc-topology-check-pcm-and-dai-name-strings-before-.patch
queue-6.18/net-mana-clear-rdma-teardown-and-suspend-state-in-ma.patch
queue-6.18/platform-x86-dell-laptop-add-inspiron-n5110-to-touch.patch
queue-6.18/net-stmmac-fix-tx-descriptor-availability-check-for-.patch
queue-6.18/clk-keystone-don-t-cache-clock-rate.patch
queue-6.18/acpica-fix-condition-check-in-acpi_ps_parse_loop.patch
queue-6.18/vdpa_sim_blk-reject-out-of-range-sector-starts.patch
queue-6.18/accel-amdxdna-remove-__counted_by-from-struct-amdxdn.patch
queue-6.18/usb-core-hcd-fix-possible-deadlock-in-rh-control-tra.patch
queue-6.18/nvme-refresh-multipath-head-zoned-limits-from-path-l.patch
queue-6.18/rtase-fix-flow-control-configuration.patch
queue-6.18/net-macb-destroy-the-phylink-instance-on-the-probe-e.patch
queue-6.18/xdrgen-fix-union-declarations.patch
queue-6.18/alsa-hda-add-lenovo-legion-7i-16iax7-17aa3874-quirk.patch
queue-6.18/net-hinic-fix-mailbox-segment-buffer-overflow.patch
queue-6.18/minix-handle-set_blocksize-failures.patch
queue-6.18/netfilter-nf_conntrack-use-get_unaligned_be32-in-tcp.patch
queue-6.18/wifi-rtw89-disable-csi-stbc-for-vht-160mhz.patch
queue-6.18/drm-panel-tdo-tl070wsh30-use-refcounted-allocation-i.patch
queue-6.18/ipvs-fix-reversed-sequence-option-serialization.patch
queue-6.18/wifi-iwlwifi-mld-don-t-warn-on-wowlan-suspend-w-o-ne.patch
queue-6.18/eth-nfp-bound-the-ntuple-rule-dump-by-the-caller-s-b.patch
queue-6.18/bluetooth-hci_mrvl-fix-wrong-return-value-check-of-w.patch
queue-6.18/devlink-add-port-level-resource-registration-infrast.patch
queue-6.18/btrfs-zoned-finish-active-block-group-cleanup-if-cal.patch
queue-6.18/ksmbd-fix-acl.sd_buf-memory-leak-and-invalid-sd_size.patch
queue-6.18/watchdog-fix-hrtimer-start-when-pretimeout-is-zero.patch
queue-6.18/drm-xe-fix-null-pointer-dereference-in-devcoredump-c.patch
queue-6.18/alsa-dummy-report-a-change-when-one-capture-switch-c.patch
queue-6.18/pinctrl-renesas-rzg2l-add-sr-register-cache-for-pm-s.patch
queue-6.18/asoc-intel-sst-publish-the-pci-module-aliases.patch
queue-6.18/genirq-proc-size-interrupt-directory-names-for-10-di.patch
queue-6.18/9p-invalidate-readdir-buffer-on-seek.patch
queue-6.18/net-ethernet-mtk_eth_soc-populate-lpi_interfaces-to-.patch
queue-6.18/erofs-disable-lz4-rolling-decompression-for-now.patch
queue-6.18/net-dsa-mt7530-add-en7528-support.patch
queue-6.18/net-ethernet-cortina-count-rx-drops-once-per-frame.patch
queue-6.18/net-ethernet-cortina-no-mapping-is-a-dropped-rx.patch
queue-6.18/mmc-renesas_sdhi-add-of-entry-for-rz-g2n-soc.patch
queue-6.18/drm-rockchip-rk3066_hdmi-add-missing-kconfig-selects.patch
queue-6.18/gpio-dwapb-mask-interrupts-at-hardware-initializatio.patch
queue-6.18/netconsole-take-target_cleanup_list_lock-in-drop_net.patch
queue-6.18/net-drop_monitor-fix-info-leak-in-net_dm_attr_payloa.patch
queue-6.18/mailbox-imx-use-devm_pm_runtime_enable.patch
queue-6.18/alsa-caiaq-fix-potential-double-free-at-error-path.patch
queue-6.18/revert-arm64-dts-qcom-talos-fix-the-pcie-iommu-map-e.patch
queue-6.18/arm-ensure-interrupts-are-enabled-in-__do_user_fault.patch
queue-6.18/acpica-enhance-buffer-validation-in-acpi_ut_walk_aml.patch
queue-6.18/alsa-hda-realtek-add-mute-led-quirk-for-hp-victus-16.patch
queue-6.18/iio-accel-mma8452-switch-to-non-devm-request_threade.patch
queue-6.18/phy-qcom-m31-eusb2-make-usb-repeater-optional.patch
queue-6.18/vxlan-initialize-_md-in-vxlan_xmit_one.patch
queue-6.18/af_packet-don-t-cast-tpacket_hdr.tp_len-to-int-in-tp.patch
queue-6.18/ksmbd-find-bound-sessions-during-reauthentication.patch
queue-6.18/pinctrl-mediatek-paris-bypass-pinctrl-gpio-layer-in-.patch
queue-6.18/usb-host-add-arch_airoha-in-xhci-mtk-dependency.patch
queue-6.18/hwmon-sht4x-rely-on-subsystem-locking.patch
queue-6.18/powerpc-kexec_file-use-inclusive-range-checks-in-add.patch
queue-6.18/leds-pca9532-don-t-stop-blinking-for-non-zero-bright.patch
queue-6.18/soundwire-only-handle-alert-events-when-the-peripher.patch
queue-6.18/clk-samsung-exynos990-fix-peric0-1-usi-clock-types.patch
queue-6.18/bonding-alb-fix-uninitialized-transport-header-acces.patch
queue-6.18/spi-dw-mmio-add-acpi-id-leca0002-for-lecarc-socs.patch
queue-6.18/drm-amdgpu-flush-pending-rcu-callbacks-on-module-unl.patch
queue-6.18/vhost-scsi-flush-backend-after-device-ioctls.patch
queue-6.18/scsi-qla2xxx-fix-64g-link-speed-reporting-in-get_data_rate.patch
queue-6.18/s390-vtime-use-__this_cpu_read-get-rid-of-read_once.patch
queue-6.18/wifi-cfg80211-reject-duplicate-wiphy-cipher-suite-en.patch
queue-6.18/drm-panel-simple-add-am-1280800w8tzqw-t00h.patch
queue-6.18/net-ethernet-cortina-fix-budget-accounting.patch
queue-6.18/ksmbd-treat-read-control-opens-as-stat-opens-only-fo.patch
queue-6.18/drm-vc4-hvs-v3d-fix-null-dereference-in-unbind.patch
queue-6.18/net-qrtr-fix-node-refcount-leak-on-ctrl-packet-alloc.patch
queue-6.18/asoc-intel-avs-fix-unbalanced-module-reference-count.patch
queue-6.18/net-iptunnel-fix-stale-transport-header-during-tunne.patch
queue-6.18/rtc-bq32000-add-delay-between-rtc-reads.patch
queue-6.18/drm-amd-pm-si-fix-updating-clock-limits-from-power-s.patch
queue-6.18/documentation-hwmon-document-hwmon_notify_event.patch
queue-6.18/bluetooth-btusb-mt7922-add-vid-pid-0e8d-223c.patch
queue-6.18/dpaa2-switch-rework-fdb-management-on-the-bridge-lea.patch
queue-6.18/asoc-codecs-pcm3168a-drop-config_pm-conditional-prep.patch
queue-6.18/exfat-fix-handling-of-damaged-volume-in-exfat_create.patch
queue-6.18/btrfs-protect-sb_write_pointer-with-invalidate-lock.patch
queue-6.18/pci-proc-fix-race-between-pci_proc_init-and-pci_bus_.patch
queue-6.18/hwmon-corsair-psu-fix-linear11-calculation.patch
queue-6.18/coresight-disable-source-helpers-in-coresight_disabl.patch
queue-6.18/rdma-rtrs-srv-fix-integer-underflow-in-process_read-.patch
queue-6.18/bpf-reject-tail-calls-directly-from-callback-frames.patch
queue-6.18/f2fs-reject-setattr-size-changes-on-large-folio-files.patch
queue-6.18/net-rds-don-t-sleep-inside-rds_ib_conn_path_shutdown.patch
queue-6.18/wifi-ath9k-obtain-system-gpios-from-descriptors.patch
queue-6.18/net-stmmac-fix-tso-support-when-some-channels-have-t.patch
queue-6.18/bpf-require-mem_percpu-for-percpu-kptr-stores.patch
queue-6.18/smb-client-validate-new-eof-for-insert-range.patch
queue-6.18/virtio-fix-use-after-free-in-unregister_virtio_devic.patch
queue-6.18/btrfs-send-fix-lost-error-return-value-in-will_overw.patch
queue-6.18/acpica-fix-integer-overflow-in-acpi_ex_opcode_3a_1t_.patch
queue-6.18/hwmon-ina2xx-rely-on-subsystem-locking.patch
queue-6.18/drm-virtio-use-the-dma-api-for-resource-backing-on-x.patch
queue-6.18/bluetooth-btintel-validate-version-tlv-value-lengths.patch
queue-6.18/bluetooth-btintel_pcie-validate-packet_len-before-sk.patch
queue-6.18/scsi-qla2xxx-validate-bsg-request_len-before-reading-vendor_cmd.patch
queue-6.18/rds-filter-rds_info_-getsockopt-by-caller-s-netns.patch
queue-6.18/wifi-ath9k_htc-don-t-store-usb_device_id.patch
queue-6.18/thunderbolt-release-request-if-tb_cfg_request-fails-.patch
queue-6.18/vdpa_sim_net-check-tx-pull-result-before-rx-copy.patch
queue-6.18/drm-amdgpu-validate-ras-eeprom-tbl_size-before-recor.patch
queue-6.18/bluetooth-btintel_pcie-fix-tx_handle-bounds-off-by-o.patch
queue-6.18/bluetooth-btusb-add-realtek-rtl8922ae-vid-pid-0bda-d.patch
queue-6.18/wifi-mac80211-use-chandef-in-ieee80211_get_sta_bw.patch
queue-6.18/media-dm1105-fix-missing-error-check-for-dma_alloc_c.patch
queue-6.18/dmaengine-dw-axi-dmac-fix-pm-for-system-sleep-and-ch.patch
queue-6.18/wifi-iwlwifi-mvm-fix-p2p-device-binding-handling.patch
queue-6.18/wifi-cfg80211-validate-assoc-response-length-before-.patch
queue-6.18/hwmon-raspberrypi-fix-delayed-work-teardown-race.patch
queue-6.18/hid-bpf-add-huion-inspiroy-frego-m-button-quirk.patch
queue-6.18/ipv6-mcast-use-copy-on-write-rcu-updates-in-ip6_mc_s.patch
queue-6.18/net-dsa-realtek-rtl8365mb-add-support-for-rtl8367sb.patch
queue-6.18/bpf-reject-resilient-lock-operations-in-rbtree-callb.patch
queue-6.18/configfs-unhash-the-dentry-before-dropping-the-item-in-rmdir.patch
queue-6.18/net-sched-act_csum-don-t-mangle-udp-tunnel-gso-packe.patch
queue-6.18/drm-xe-oa-remove-sysfs-entry-on-idr_alloc-failure-in.patch
queue-6.18/driver-core-replace-dev-can_match-with-dev_can_match.patch
queue-6.18/pci-rockchip-protect-root-bus-removal-with-rescan-lo.patch
queue-6.18/scripts-mksysmap-drop-the-module_info-symbols-from-k.patch
queue-6.18/net-usb-pegasus-don-t-rely-on-id-table-pointer-arith.patch
queue-6.18/netfs-fix-decision-whether-to-disallow-write-streami.patch
queue-6.18/net-sched-cls_route-reject-handle-aliasing.patch
queue-6.18/eth-mlx5-fix-macsec-dependency.patch
queue-6.18/ksmbd-preserve-vfs-inherited-posix-acl-mask.patch
queue-6.18/s390-diag324-preserve-ebusy-return-code.patch
queue-6.18/drm-amdgpu-userq-fix-struct-drm_amdgpu_info_device-p.patch
queue-6.18/bpf-mark-signal-tracepoint-siginfo-arguments-as-scal.patch
queue-6.18/wifi-iwlwifi-mvm-parse-beacon-notif-per-layout.patch
queue-6.18/net-bcmasp-clear-txcb-last-before-writing-each-descr.patch
queue-6.18/drm-xe-flush-lsc-untyped-l1-dataport-cache-after-rcs-ccs-batches.patch
queue-6.18/hsr-broadcast-netlink-notifications-in-the-device-s-.patch
queue-6.18/sched-eevdf-fix-augmented-max_slice.patch
queue-6.18/drm-adp-drop-the-select-of-the-nonexistent-config_dr.patch
queue-6.18/dlm-add-usercopy-whitelist-to-dlm_cb-cache.patch
queue-6.18/f2fs-embed-f2fs_gc_kthread-in-f2fs_sb_info.patch
queue-6.18/libbpf-also-reset-insn-data-_cur-on-realloc-failure.patch
queue-6.18/wifi-iwlwifi-transition-to-basic-uapsd-with-mac_pm_p.patch
queue-6.18/ksmbd-mark-invalid-session-responses-as-signed.patch
queue-6.18/spi-tegra210-quad-allocate-dma-memory-for-dma-engine.patch
queue-6.18/ata-libata-core-disable-lpm-on-wd-green-2.5-480gb.patch
queue-6.18/media-v4l2-common-always-register-clock-with-device-.patch
queue-6.18/bluetooth-l2cap-fix-chan-mode-for-le_conn_req-ext_fl.patch
queue-6.18/ksmbd-fix-lease-break-and-ack-state-handling.patch
queue-6.18/ppp_synctty-ensure-a-writeable-skb-header.patch
queue-6.18/ipv6-use-read_once-for-bindv6only-default-in-inet6_c.patch
queue-6.18/perf-fix-addr_filter_ranges-lifetime.patch
queue-6.18/smb-client-fix-integer-truncation-in-collapse-range.patch
queue-6.18/thunderbolt-keep-the-domain-reference-while-processi.patch
queue-6.18/pci-stop-setting-cached-power-state-to-unknown-on-un.patch
queue-6.18/cxl-region-validate-partition-index-before-array-acc.patch
queue-6.18/usb-xhci-remove-legacy-num_trbs_free-tracking.patch
queue-6.18/net-mctp-i3c-serialize-probe-with-bus-removal.patch
queue-6.18/wifi-iwlwifi-mld-honor-bss_changed_beacon_enabled.patch
queue-6.18/firmware-stratix10-svc-change-get-provision-data-to-.patch
queue-6.18/irqchip-gic-v5-preserve-icc_cr0_el1-state.patch
queue-6.18/coresight-platform-defer-connection-counter-incremen.patch
queue-6.18/thunderbolt-don-t-create-multiple-dma-tunnels-on-fir.patch
queue-6.18/edac-device_sysfs-use-kstrtouint-for-poll_msec-to-pr.patch
queue-6.18/pci-altera-protect-root-bus-removal-with-rescan-lock.patch
queue-6.18/eth-nfp-drop-the-replaced-rule-from-the-list-when-re.patch
queue-6.18/media-video-i2c-use-vb2_video_unregister_device-on-d.patch
queue-6.18/net-sched-sch_drr-make-cl-quantum-lockless.patch
queue-6.18/jfs-handle-set_blocksize-failures.patch
queue-6.18/spi-add-null-check-for-spi_get_device_id-in-spi_get_.patch
queue-6.18/drm-amdkfd-properly-acquire-queue-buffers-in-criu-re.patch
queue-6.18/net-sched-ets-clamp-quantum-in-parse-and-fallback-pa.patch
queue-6.18/scsi-qla2xxx-bound-vp-index-against-vp_ctrl-iocb-bitmap-size.patch
queue-6.18/alsa-caiaq-decoupling-ep1_in_urb-in-caiaq-dev.patch
queue-6.18/serial-8250_port-recognize-upio_au.patch
queue-6.18/mptcp-prevent-race-between-disconnect-and-rtx.patch
queue-6.18/tcp-introduce-icsk-icsk_keepalive_timer.patch
queue-6.18/net-macb-put-the-mdio-child-node-reference-on-succes.patch
queue-6.18/arm64-daifflags-make-local_daif_-helpers-__always_in.patch
queue-6.18/net-napi-skip-last-poll-when-arming-gro-timer-in-bus.patch
queue-6.18/wifi-mt76-mt7925-handle-320mhz-bandwidth-in-rxv-and-.patch
queue-6.18/host1x-bus-fix-missing-ops-null-check-in-error-teard.patch
queue-6.18/staging-fbtft-make-dirty_lock-irq-safe.patch
queue-6.18/wifi-ath12k-prevent-incorrect-vif-chanctx-switch-whe.patch
queue-6.18/landlock-use-mem_is_zero-in-is_layer_masks_allowed.patch
queue-6.18/wifi-iwlwifi-mld-disallow-puncturing-in-us-ca-for-wh.patch
queue-6.18/wifi-mt76-mt7921-skip-unknown-clc-firmware-records.patch
queue-6.18/asoc-mediatek-mt8365-afe-pcm-fix-possible-null-point.patch
queue-6.18/revert-arm64-dts-qcom-sm8650-fix-the-pcie-iommu-map-.patch
queue-6.18/drm-panel-edp-add-auo-b133han06.6-and-boe-nv133fhm-n.patch
queue-6.18/x86-mm-pat-acquire-init_mm-read-lock-on-attribute-changes-to-avoid-uaf.patch
queue-6.18/tracing-fix-to-avoid-creating-trace-instances-with-d.patch
queue-6.18/asoc-meson-aiu-validate-written-enum-values.patch
queue-6.18/configfs_depend_prep-pass-configfs_dirent-instead-of.patch
queue-6.18/rds-annotate-data-race-around-rs_seen_congestion.patch
queue-6.18/bpf-only-enforce-8-frame-call-stack-limit-for-all-st.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-lenovo-xiaoxin-14-gt.patch
queue-6.18/freevxfs-don-t-bug-on-unknown-typed-extent-type.patch
queue-6.18/powerpc-pseries-ensure-vpa-slb_shadow-dtl-are-unregi.patch
queue-6.18/drm-amd-display-find-link-encoder-for-flexible-dig-m.patch
queue-6.18/eth-ice-don-t-dereference-pointers-from-tp_printk.patch
queue-6.18/regulator-core-clamp-voltage-constraints-before-appl.patch
queue-6.18/powercap-intel_rapl-fix-memory-leak-in-rapl_add_pack.patch
queue-6.18/irqchip-gic-v5-immediately-exec-priority-drop-follow.patch
queue-6.18/drm-ttm-drop-tt-restore-after-successful-restore.patch
queue-6.18/openvswitch-fix-wrong-flag-value-in-get_ipv6_ext_hdr.patch
queue-6.18/arm64-trans_pgd-clone-only-the-linear-map-that-exist.patch
queue-6.18/pinctrl-renesas-rzg2l-handle-rz-v2h-p-iolh-configura.patch
queue-6.18/vhost-vdpa-reject-vring_num-larger-than-device-max.patch
queue-6.18/smb-client-transport-fix-debug-printing-in-__release.patch
queue-6.18/cifs-validate-idmap-key-payload-length.patch
queue-6.18/hid-hidpp-fix-potential-uaf-in-hidpp_connect_event.patch
queue-6.18/ata-libata-core-disable-lpm-on-some-wd-drives.patch
queue-6.18/asoc-intel-avs-refactor-and-fix-init_config-access.patch
queue-6.18/netfilter-cttimeout-detach-dataplane-timeout-policy-and-repurpose-refcount.patch
queue-6.18/l2tp-fix-tunnel-and-session-refcount-leak-on-seq_fil.patch
queue-6.18/crypto-ecc-unbreak-the-build-on-arm-with-config_kasa.patch
queue-6.18/drm-amd-pm-check-smuv13.0.6-12-metrics-integrity.patch
queue-6.18/af_unix-return-immediately-when-manage_oob-returns-n.patch
queue-6.18/alsa-ice1724-fix-blocking-open-for-independent-surro.patch
queue-6.18/bfs-handle-set_blocksize-failures.patch
queue-6.18/net-phy-mediatek-ge-disable-eee-on-the-mt7530-phy.patch
queue-6.18/asoc-ab8500-reset-the-audio-block-before-configuring.patch
queue-6.18/pinctrl-mediatek-common-v1-bypass-pinctrl-gpio-layer.patch
queue-6.18/alsa-hda-restore-mfg-widget-enumeration-after-core-s.patch
queue-6.18/usb-xusbatm-don-t-rely-on-id-table-pointer-arithmeti.patch
queue-6.18/drm-cirrus-qemu-validate-bar0-size-during-probe.patch
queue-6.18/netfs-fix-error-vs-transferred-passed-to-ki_complete.patch
queue-6.18/wifi-mt76-mt7925-populate-eht-320mhz-mcs-map-in-sta_.patch
queue-6.18/hwmon-ina2xx-acquire-hwmon_lock-in-shunt_resistor_sh.patch
queue-6.18/net-sched-hhf-clamp-quantum-in-change-and-init-paths.patch
queue-6.18/rdma-irdma-fix-typo-in-sq-completions-generation.patch
queue-6.18/gfs2-page-poisoning-fix.patch
queue-6.18/nvme-rdma-fix-eio-cleanup-order-in-queue_rq.patch
queue-6.18/revert-arm64-dts-qcom-sm8450-fix-the-pcie-iommu-map-.patch
queue-6.18/drm-amd-display-initialize-dsc_caps-to-0.patch
queue-6.18/net-rds-clear-cp_flags-bits-individually-in-rds_conn.patch
queue-6.18/hwmon-fix-potential-uaf-in-pec_store.patch
queue-6.18/drm-amd-display-avoid-dpms-on-for-phantom-stream.patch
queue-6.18/net-ethernet-mtk_eth_soc-fix-supported_interface-set.patch
queue-6.18/scsi-target-iscsi-fix-hang-for-aborted-write_pending.patch
queue-6.18/bluetooth-btusb-add-mercusys-ma530-for-realtek-rtl87.patch
queue-6.18/ntfs3-handle-set_blocksize-failures.patch
queue-6.18/usb-xhci-improve-soft-retries-after-short-transfers.patch
queue-6.18/asoc-ab8500-correct-digital-interface-format-setup.patch
queue-6.18/bus-mhi-host-pci_generic-round-up-nr_irqs-to-power-o.patch
queue-6.18/ipmr-account-multicast-table-and-route-memory.patch
queue-6.18/media-qcom-camss-vfe-340-proper-client-handling.patch
queue-6.18/scripts-mksysmap-fix-escape-of-in-the-__pi_-pattern.patch
queue-6.18/gpio-pisosr-read-ngpios-as-u32.patch
queue-6.18/media-rc-mceusb-add-support-for-04eb-e033.patch
