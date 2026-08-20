Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D01C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2394110F045;
	Thu, 20 Aug 2026 13:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEV9HB6E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BE110F066
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:53:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0635C60008;
 Thu, 20 Aug 2026 13:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061651F000E9;
 Thu, 20 Aug 2026 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787234022;
 bh=1ydBr5l0kQpwNpwfdRpGtu5rak5HycpQQfmXdm/j7fI=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=gEV9HB6EamltYN3mWFkzAGTn2wB6bCZtJTUbD7bWdskY+UNozKKjUxgBQFQYBzkWg
 ZhyB+hGzoU9M4b7mWW2nvKt9/bQbVUt9ncdlFuQzg0lAcmEdSO6m5iaAnr9MKgb8lv
 ccHticwKRd1SFpdF0yjiP+vm2HtzkVM9k/QXm4uA=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 5.10-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 15:40:24 +0200
In-Reply-To: <20260731165703.883481-1-sashal@kernel.org>
Message-ID: <2026082024-henna-lens-1a8f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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

    drm/tegra: fbdev: Remove offset into framebuffer memory

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-294165-greg=kroah.com@vger.kernel.org Fri Jul 31 19:12:09 2026
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 31 Jul 2026 12:57:03 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731165703.883481-1-sashal@kernel.org>

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit a18b6e30ecd69096beda4a0c96d2570900c3879a ]

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.10+
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20260421073646.144712-3-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tegra/fb.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -211,7 +211,6 @@ static int tegra_fbdev_probe(struct drm_
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -257,9 +256,6 @@ static int tegra_fbdev_probe(struct drm_
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -271,9 +267,9 @@ static int tegra_fbdev_probe(struct drm_
 	}
 
 	drm->mode_config.fb_base = (resource_size_t)bo->iova;
-	info->screen_base = (void __iomem *)bo->vaddr + offset;
+	info->screen_base = (void __iomem *)bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-5.10/udmabuf-do-not-create-malformed-scatterlists.patch
queue-5.10/rxrpc-fix-notification-vs-call-release-vs-recvmsg.patch
queue-5.10/net-ipip-require-cap_net_admin-in-the-device-netns-for-changelink.patch
queue-5.10/dma-buf-udmabuf-skip-redundant-cpu-sync-to-fix-cacheline-eexist-warning.patch
queue-5.10/usb-gadget-f_tcm-synchronize-delayed-set_alt-with-teardown.patch
queue-5.10/input-mms114-reject-an-oversized-device-packet-size.patch
queue-5.10/scsi-target-bound-pr-out-transportid-parsing-to-the-received-buffer.patch
queue-5.10/usb-gadget-udc-bdc-free-irq-and-drain-func_wake_notify-before-teardown.patch
queue-5.10/media-mediatek-vcodec-fix-a-resource-leak-related-to.patch
queue-5.10/fpga-dfl-afu-validate-dma-mapping-length-in-afu_dma_map_region.patch
queue-5.10/netfilter-nft_set_pipapo-move-cloning-of-match-info-to-insert-removal-path.patch
queue-5.10/mm-ptdump-always-stabilise-against-page-table-freeing-using-init_mm.patch
queue-5.10/jbd2-fix-integer-underflow-in-jbd2_journal_initialize_fast_commit.patch
queue-5.10/net-sched-serialize-qdisc_rtab_list-against-concurrent-get-put.patch
queue-5.10/bootconfig-fix-null-pointer-arithmetic-in-xbc_snprint_cmdline.patch
queue-5.10/scsi-target-core-generate-correct-identifiers-for-pr-out-transport-ids.patch
queue-5.10/octeontx2-annotate-mmio-regions-as-__iomem.patch
queue-5.10/drm-virtio-bound-edid-block-reads-to-the-response-buffer.patch
queue-5.10/media-marvell-cam-fix-missing-pci_disable_device-on-remove.patch
queue-5.10/net-gro-fix-double-aggregation-of-flush-marked-skbs.patch
queue-5.10/kvm-x86-check-for-in-kernel-xapic-when-querying-apicv-for-directed-yield.patch
queue-5.10/mlxsw-fix-refcount-leak-in-mlxsw_sp_port_lag_join.patch
queue-5.10/net-9p-fix-infinite-loop-in-p9_client_rpc-on-fatal-signal.patch
queue-5.10/dma-buf-drivers-make-reserving-a-shared-slot-mandatory-v4.patch
queue-5.10/super-fix-emergency-thaw-deadlock-on-frozen-block-devices.patch
queue-5.10/scsi-sd-sd_zbc-use-logical-blocks-as-unit-when-querying-zones.patch
queue-5.10/mmc-vub300-fix-use-after-free-on-probe-failure.patch
queue-5.10/ipvs-separate-destination-availability-state.patch
queue-5.10/net-pktgen-fix-code-style-warning-block-comments.patch
queue-5.10/libceph-add-doutc-and-_client-debug-macros-support.patch
queue-5.10/bootconfig-move-xbc_snprint_cmdline-to-lib-bootconfig.c.patch
queue-5.10/taskstats-retain-dead-thread-stats-in-tgid-queries.patch
queue-5.10/usb-serial-keyspan_pda-fix-write-implementation.patch
queue-5.10/net-ipa-fix-smem-state-handle-leaks-in-smp2p-init.patch
queue-5.10/octeontx2-pf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-5.10/drm-dp-mst-fix-oob-reads-on-2-byte-fields-in-sideband-reply-parsers.patch
queue-5.10/kvm-x86-drop-vcpu-parameter-from-kvm_x86_ops.hwapic_isr_update.patch
queue-5.10/ice-fix-vf-interrupts-cleanup.patch
queue-5.10/scsi-target-core-pr-initialize-arrays-at-declaration-time.patch
queue-5.10/netfilter-nf_conntrack_sip-remove-net-variable-shadowing.patch
queue-5.10/smb-client-use-kvzalloc-for-megabyte-buffer-in-simple-fallocate.patch
queue-5.10/can-gs_usb-gs_usb_receive_bulk_callback-resubmit-urb-on-skb-allocation-failure.patch
queue-5.10/mtd-spi-nor-intel-remove-global-protection-flag.patch
queue-5.10/wifi-ath6kl-fix-use-after-free-in-aggr_reset_state.patch
queue-5.10/drm-dp-mst-fix-oob-reads-in-remote-dpcd-i2c-sideband-reply-parsers.patch
queue-5.10/tipc-restrict-socket-queue-dumps-in-enqueue-tracepoints.patch
queue-5.10/ceph-avoid-fs-reclaim-while-using-current-journal_info.patch
queue-5.10/kvm-x86-move-apicv_active-into-struct-kvm_lapic.patch
queue-5.10/drm-i915-hdcp-require-monotonically-increasing-seq_num_v.patch
queue-5.10/rxrpc-fix-recv-recv-race-of-completed-call.patch
queue-5.10/mmc-vub300-fix-use-after-free-on-disconnect.patch
queue-5.10/serial-sc16is7xx-implement-gpio-get_direction-callback.patch
queue-5.10/mtd-maps-vmu-flash-fix-fault-in-unaligned-fixup.patch
queue-5.10/ceph-fix-hanging-__ceph_get_caps-with-stale-mds_wanted.patch
queue-5.10/mtd-spi-nor-swp-improve-locking-user-experience.patch
queue-5.10/libceph-amend-checking-to-fix-make-w-1-build-breakage.patch
queue-5.10/libceph-bound-pg_-temp-upmap-upmap_items-length-to-ceph_pg_max_size.patch
queue-5.10/selinux-avoid-sk_socket-dereference-in-selinux_sctp_bind_connect.patch
queue-5.10/drm-amd-pm-fix-torn-gpu-metrics-reads.patch
queue-5.10/kvm-introduce-vcpu-wants_to_run.patch
queue-5.10/ftrace-add-global-mutex-to-serialize-trace_parser-access.patch
queue-5.10/usb-serial-keyspan_pda-refactor-write-room-handling.patch
queue-5.10/lsm-infrastructure-management-of-the-sock-security.patch
queue-5.10/i2c-bcm-iproc-remove-printout-on-handled-timeouts.patch
queue-5.10/audit-use-unsigned-int-instead-of-unsigned.patch
queue-5.10/media-mtk-vcodec-potential-null-pointer-deference-in.patch
queue-5.10/media-v4l2-fwnode-fix-subdev-owner-overwritten-in-v4l2_async_register_subdev_sensor.patch
queue-5.10/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-5.10/i2c-davinci-unregister-cpufreq-notifier-on-probe-failure.patch
queue-5.10/alsa-seq-close-a-re-opened-queue-timer-in-the-destructor.patch
queue-5.10/bootconfig-do-not-put-quotes-on-cmdline-items-unless-necessary.patch
queue-5.10/serial-8250_mid-fix-null-function-pointer-dereference-on-dnv-icx-d-snr-platforms.patch
queue-5.10/ice-fix-memory-leak-in-ice_lbtest_prepare_rings.patch
queue-5.10/rxrpc-fix-socket-notification-race.patch
queue-5.10/i2c-imx-separate-atomic-dma-and-non-dma-use-case.patch
queue-5.10/serial-sc16is7xx-fill-in-rs485_supported.patch
queue-5.10/drm-displayid-fix-tiled-display-topology-id-size.patch
queue-5.10/netfilter-nft_set_pipapo-merge-deactivate-helper-into-caller.patch
queue-5.10/dm-integrity-don-t-increment-hash_offset-twice.patch
queue-5.10/fs-don-t-block-write-during-exec-on-pre-content-watched-files.patch
queue-5.10/vfs-audit-introduce-kern_path_parent-for-audit.patch
queue-5.10/audit-fix-recursive-locking-deadlock-in-audit_dupe_exe.patch
queue-5.10/usb-gadget-bdc-fix-checkpatch.pl-spacing-error.patch
queue-5.10/binfmt_misc-restore-write-access-when-removing-an-entry.patch
queue-5.10/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-5.10/thunderbolt-remove-xdomain-from-the-bus-without-holding-tb-lock.patch
queue-5.10/rxrpc-serialize-kernel-accept-preallocation-with-socket-teardown.patch
queue-5.10/rdma-rtrs-srv-bound-rdma-write-length-to-chunk-size-in-rdma_write_sg.patch
queue-5.10/serial-sc16is7xx-remove-obsolete-out_thread-label.patch
queue-5.10/9p-skip-nlink-update-in-cacheless-mode-to-fix-warn_on.patch
queue-5.10/dmaengine-dw-edma-add-spinlock-to-protect-done_int_mask-and-abort_int_mask.patch
queue-5.10/mmc-vub300-rename-probe-error-labels.patch
queue-5.10/net-sched-act_gact-act_police-range-check-the-fallback-control-action.patch
queue-5.10/kvm-x86-only-reset-tsc-deadline-timer-in-apic_timer_expired-on-kvm_run.patch
queue-5.10/netfilter-nft_set_pipapo-use-gfp_kernel-for-insertions.patch
queue-5.10/i2c-iproc-reset-bus-after-timeout-if-start_busy-is-stuck.patch
queue-5.10/mtd-spi-nor-fix-spi_nor_try_unlock_all.patch
queue-5.10/alsa-hda-fix-cached-processing-coefficient-verbs.patch
queue-5.10/net-ip6_tunnel-require-cap_net_admin-in-the-device-netns-for-changelink.patch
queue-5.10/dm-verity-make-error-counter-atomic.patch
queue-5.10/device-property-add-fwnode_irq_get_byname.patch
queue-5.10/jbd2-add-a-helper-to-find-out-number-of-fast-commit-blocks.patch
queue-5.10/usb-serial-keyspan_pda-clean-up-comments-and-whitespace.patch
queue-5.10/media-aspeed-fix-missing-of_reserved_mem_device_release-on-probe-failure.patch
queue-5.10/media-i2c-imx219-correct-the-minimum-vblanking-value.patch
queue-5.10/mptcp-decrement-subflows-counter-on-failed-passive-join.patch
queue-5.10/hwmon-npcm750-pwm-fan-stop-fan-timer-on-device-detach.patch
queue-5.10/fsnotify-opt-in-for-permission-events-at-file-open-time.patch
queue-5.10/mptcp-only-set-data_fin-when-a-mapping-is-present.patch
queue-5.10/net-sched-sch_taprio-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
queue-5.10/i2c-imx-fix-locked-bus-on-smbus-block-read-of-0-atomic.patch
queue-5.10/usb-serial-keyspan_pda-fix-data-loss-on-receive-throttling.patch
queue-5.10/drm-dp-mst-fix-buffer-overflows-in-sideband-chunk-accumulation.patch
queue-5.10/wifi-libertas_tf-fix-use-after-free-in-lbtf_free_adapter.patch
queue-5.10/mlxsw-spectrum-apply-rif-configuration-when-joining-a-lag.patch
queue-5.10/netfilter-nft_set_pipapo-don-t-leak-bad-clone-into-future-transaction.patch
queue-5.10/mlxsw-spectrum-on-port-enslavement-to-a-lag-join-upper-s-bridges.patch
queue-5.10/firmware_loader-introduce-__free-cleanup-hanler.patch
queue-5.10/scsi-lpfc-fix-memory-leak-in-lpfc_sli4_driver_resource_setup.patch
queue-5.10/netfilter-nf_conntrack_sip-validate-skb_dst-before-accessing-it.patch
queue-5.10/thunderbolt-keep-xdomain-reference-during-the-lifetime-of-a-service.patch
queue-5.10/asoc-mediatek-mt8183-check-runtime-resume-during-probe.patch
queue-5.10/ceph-rename-_to_client-to-_to_fs_client.patch
queue-5.10/sc16is7xx-properly-resume-tx-after-stop.patch
queue-5.10/octeontx2-vf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-5.10/input-ims-pcu-fix-race-condition-in-reset_device-sysfs-callback.patch
queue-5.10/net-thunderbolt-fix-frags-overflow-by-bounding-frame_count.patch
queue-5.10/netfilter-nft_set_pipapo-make-pipapo_clone-helper-return-null.patch
queue-5.10/net-pktgen-fix-proc-entry-use-after-free.patch
queue-5.10/bluetooth-hidp-reject-frames-without-a-transaction-header.patch
queue-5.10/espintcp-use-sk_msg_free_partial-to-fix-partial-send.patch
queue-5.10/mtd-spi-nor-sst-remove-global-protection-flag.patch
queue-5.10/scsi-sd-sd_zbc-improve-source-code-documentation.patch
queue-5.10/serial-8250_mid-remove-unneeded-test-for-setup-presence.patch
queue-5.10/skbuff-introduce-skb_pull_data.patch
queue-5.10/mptcp-fix-subflow-accounting-on-close.patch
queue-5.10/alsa-usx2y-bound-the-hwdep-mmap-fault-offset.patch
queue-5.10/input-ims-pcu-fix-firmware-leak-in-async-update.patch
queue-5.10/usb-serial-keyspan_pda-add-write-fifo-support.patch
queue-5.10/media-i2c-imx219-drop-imx219_vts_-macros.patch
queue-5.10/net-sched-taprio-avoid-calling-child-ops-dequeue-child-twice.patch
queue-5.10/net-add-helper-function-to-parse-netlink-msg-of-ip_tunnel_encap.patch
queue-5.10/octeontx2-pf-fix-sqb-pointer-leak-on-init-failure.patch
queue-5.10/tpm-tpm_tis_spi-use-wait_woken-in-wait_for_tmp_stat.patch
queue-5.10/media-i2c-imx219-rename-vts-to-frm_length.patch
queue-5.10/pci-add-pci_find_vsec_capability-to-find-a-specific-vsec.patch
queue-5.10/mm-vmstat-fold-stranded-per-cpu-node-stats-when-a-node-comes-online.patch
queue-5.10/scsi-scsi_debug-fix-report-zones-alloc_len-underflow-oob-write.patch
queue-5.10/gpio-tegra-do-not-call-pinctrl-for-gpio-direction.patch
queue-5.10/libceph-fix-two-unsafe-bare-decodes-in-decode_lockers.patch
queue-5.10/scsi-scsi_debug-rename-zone-type-constants.patch
queue-5.10/media-imx219-fix-maximum-frame-length-in-lines.patch
queue-5.10/serial-max310x-replace-bare-use-of-unsigned-with-unsigned-int-checkpatch.patch
queue-5.10/sched-psi-shut-down-rtpoll_timer-in-psi_cgroup_free.patch
queue-5.10/audit-widen-ino-fields-to-u64.patch
queue-5.10/lsm-use-default-hook-return-value-in-call_int_hook.patch
queue-5.10/scsi-sd-sd_zbc-return-early-in-sd_zbc_check_zoned_characteristics.patch
queue-5.10/media-v4l-async-set-owner-for-async-sub-devices.patch
queue-5.10/bpf-reject-bpf_map_type_inode_storage-creation-if-bpf-lsm-is-uninitialized.patch
queue-5.10/ovl-use-linked-upper-dentry-in-copy-up-tmpfile.patch
queue-5.10/alsa-usx2y-fix-potential-leaks-of-uninitialized-memory.patch
queue-5.10/netfilter-nft_set_pipapo-prepare-pipapo_get-helper-for-on-demand-clone.patch
queue-5.10/netfilter-nft_set_pipapo-prepare-walk-function-for-on-demand-clone.patch
queue-5.10/taskstats-fill_stats_for_tgid-use-for_each_thread.patch
queue-5.10/thunderbolt-prevent-xdomain-delayed-work-use-after-free-on-disconnect.patch
queue-5.10/serial-sc16is7xx-fix-regression-with-gpio-configuration.patch
queue-5.10/dmaengine-dw-edma-improve-the-linked-list-and-data-blocks-definition.patch
queue-5.10/fs-resctrl-fix-double-add-of-pseudo-locked-region-s-rmid-to-free-list.patch
queue-5.10/dmaengine-dw-edma-remove-unused-irq-field-in-struct-dw_edma_chip.patch
queue-5.10/mtd-spi-nor-move-software-write-protection-logic-out-of-the-core.patch
queue-5.10/drm-virtio-use-uninterruptible-resv-lock-for-plane-updates.patch
queue-5.10/drm-virtio-return-proper-error-codes-instead-of-1.patch
queue-5.10/serial-max310x-implement-gpio_chip-get_direction.patch
queue-5.10/sctp-avoid-auth_enable-sysctl-uaf-during-netns-teardown.patch
queue-5.10/i2c-smbus-use-device_-functions-instead-of-of_.patch
