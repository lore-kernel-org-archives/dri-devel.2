Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD82C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03510F037;
	Thu, 20 Aug 2026 13:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VzbaBevi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A19410E1E3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:37:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7A65436F1;
 Thu, 20 Aug 2026 13:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF61F000E9;
 Thu, 20 Aug 2026 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787233078;
 bh=r5tYoO9WBm1tLv7ER2QnqFYjocUIL7hpHUfJ1V+TLk4=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=VzbaBeviejebDxyjjoFV+DL563LS845jYobE5Dl/Ag5MGl6HDbw7onqa/fvUrrprv
 CDqUbSB0MZDpsX1mrV/zn2R9bNErAt0UKMVJrUEaMVhiq8w2P80YHxj1JcWIR2tzLU
 FA5u7UfhxFQCXT9f+RKfBXrWOxyTyqOHM5qZnCoU=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 5.15-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 15:28:22 +0200
In-Reply-To: <20260731163910.838898-1-sashal@kernel.org>
Message-ID: <2026082022-crunching-flyer-8742@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-294156-greg=kroah.com@vger.kernel.org Fri Jul 31 19:02:50 2026
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 31 Jul 2026 12:39:10 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731163910.838898-1-sashal@kernel.org>

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
@@ -221,7 +221,6 @@ static int tegra_fbdev_probe(struct drm_
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -267,9 +266,6 @@ static int tegra_fbdev_probe(struct drm_
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -281,9 +277,9 @@ static int tegra_fbdev_probe(struct drm_
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

queue-5.15/udmabuf-do-not-create-malformed-scatterlists.patch
queue-5.15/net-ipip-require-cap_net_admin-in-the-device-netns-for-changelink.patch
queue-5.15/dma-buf-udmabuf-skip-redundant-cpu-sync-to-fix-cacheline-eexist-warning.patch
queue-5.15/wifi-brcmfmac-set-f2-blocksize-to-256-for-bcm43752.patch
queue-5.15/usb-gadget-f_tcm-synchronize-delayed-set_alt-with-teardown.patch
queue-5.15/input-mms114-reject-an-oversized-device-packet-size.patch
queue-5.15/iommu-amd-don-t-split-flush-for-amd_iommu_domain_flush_all.patch
queue-5.15/can-esd_usb2-rename-esd_usb2.c-to-esd_usb.c.patch
queue-5.15/media-mediatek-vcodec-fix-a-resource-leak-related-to.patch
queue-5.15/fbcon-rename-struct-fbcon_ops-to-struct-fbcon_par.patch
queue-5.15/fpga-dfl-afu-validate-dma-mapping-length-in-afu_dma_map_region.patch
queue-5.15/netfilter-nft_set_pipapo-move-cloning-of-match-info-to-insert-removal-path.patch
queue-5.15/smb-server-fix-minimum-smb1-pdu-size.patch
queue-5.15/vduse-remove-unused-vaddr-parameter-of-vduse_domain_free_coherent.patch
queue-5.15/net-sched-serialize-qdisc_rtab_list-against-concurrent-get-put.patch
queue-5.15/bootconfig-fix-null-pointer-arithmetic-in-xbc_snprint_cmdline.patch
queue-5.15/octeontx2-annotate-mmio-regions-as-__iomem.patch
queue-5.15/thunderbolt-update-property.c-function-documentation.patch
queue-5.15/drm-virtio-bound-edid-block-reads-to-the-response-buffer.patch
queue-5.15/media-marvell-cam-fix-missing-pci_disable_device-on-remove.patch
queue-5.15/net-macb-move-ring-size-computation-to-functions.patch
queue-5.15/net-mana-validate-the-packet-length-reported-by-the-nic.patch
queue-5.15/netfilter-nft_set_pipapo-move-prove_locking-helper-around.patch
queue-5.15/mlxsw-fix-refcount-leak-in-mlxsw_sp_port_lag_join.patch
queue-5.15/dma-buf-drivers-make-reserving-a-shared-slot-mandatory-v4.patch
queue-5.15/super-fix-emergency-thaw-deadlock-on-frozen-block-devices.patch
queue-5.15/thunderbolt-remove-service-debugfs-entries-during-unregister.patch
queue-5.15/octeontx2-af-cn10k-restrict-vf-lmtline-sharing-to-its-own-pf.patch
queue-5.15/mmc-vub300-fix-use-after-free-on-probe-failure.patch
queue-5.15/ipvs-separate-destination-availability-state.patch
queue-5.15/libceph-add-doutc-and-_client-debug-macros-support.patch
queue-5.15/bootconfig-move-xbc_snprint_cmdline-to-lib-bootconfig.c.patch
queue-5.15/taskstats-retain-dead-thread-stats-in-tgid-queries.patch
queue-5.15/fs-ntfs3-undo-critial-modificatins-to-keep-directory-consistency.patch
queue-5.15/ksmbd-rename-smb2_get_msg-to-smb_get_msg.patch
queue-5.15/net-ipa-fix-smem-state-handle-leaks-in-smp2p-init.patch
queue-5.15/octeontx2-pf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-5.15/drm-dp-mst-fix-oob-reads-on-2-byte-fields-in-sideband-reply-parsers.patch
queue-5.15/can-esd_usb-kill-anchored-urbs-before-freeing-netdevs.patch
queue-5.15/fbcon-use-correct-type-for-vc_resize-return-value.patch
queue-5.15/ipv4-adopt-dst_dev-skb_dst_dev-and-skb_dst_dev_net.patch
queue-5.15/net-ixp4xx_hss-fix-duplicate-hdlc-netdev-allocation.patch
queue-5.15/kvm-x86-mmu-document-the-rules-for-using-host_pfn_mapping_level.patch
queue-5.15/netfilter-nf_conntrack_sip-remove-net-variable-shadowing.patch
queue-5.15/smb-client-use-kvzalloc-for-megabyte-buffer-in-simple-fallocate.patch
queue-5.15/ksmbd-conn-lock-to-serialize-smb2-negotiate.patch
queue-5.15/remoteproc-qcom-pas-adjust-the-phys-addr-wrt-the-mem-region.patch
queue-5.15/wifi-ath6kl-fix-use-after-free-in-aggr_reset_state.patch
queue-5.15/asoc-mediatek-use-common-mtk_afe_pcm_platform-with-common-probe-cb.patch
queue-5.15/wifi-brcmfmac-fix-43752-sdio-fwvid-incorrectly-labelled-as-cypress-cyw.patch
queue-5.15/fs-ntfs3-make-ntfs_update_mftmirr-return-void.patch
queue-5.15/vduse-avoid-leaking-information-to-userspace.patch
queue-5.15/treewide-rename-pinctrl_gpio_direction_output_new.patch
queue-5.15/asoc-mediatek-mt8192-check-runtime-resume-during-probe.patch
queue-5.15/drm-dp-mst-fix-oob-reads-in-remote-dpcd-i2c-sideband-reply-parsers.patch
queue-5.15/tipc-restrict-socket-queue-dumps-in-enqueue-tracepoints.patch
queue-5.15/ceph-avoid-fs-reclaim-while-using-current-journal_info.patch
queue-5.15/ksmbd-fix-integer-overflow-in-set_file_allocation_info.patch
queue-5.15/f2fs-fix-uaf-issue-in-f2fs_merge_page_bio.patch
queue-5.15/drm-i915-hdcp-require-monotonically-increasing-seq_num_v.patch
queue-5.15/mmc-vub300-fix-use-after-free-on-disconnect.patch
queue-5.15/serial-sc16is7xx-implement-gpio-get_direction-callback.patch
queue-5.15/octeontx2-af-fix-apr-entry-mapping-based-on-apr_lmt_cfg.patch
queue-5.15/mtd-maps-vmu-flash-fix-fault-in-unaligned-fixup.patch
queue-5.15/ceph-fix-hanging-__ceph_get_caps-with-stale-mds_wanted.patch
queue-5.15/mtd-spi-nor-swp-improve-locking-user-experience.patch
queue-5.15/remoteproc-qcom-fix-leak-when-custom-dump_segments-addition-fails.patch
queue-5.15/libceph-amend-checking-to-fix-make-w-1-build-breakage.patch
queue-5.15/libceph-bound-pg_-temp-upmap-upmap_items-length-to-ceph_pg_max_size.patch
queue-5.15/selinux-avoid-sk_socket-dereference-in-selinux_sctp_bind_connect.patch
queue-5.15/kvm-rename-mmu_notifier_-to-mmu_invalidate_.patch
queue-5.15/drm-i915-hdcp-check-streams-bounds-before-overflow.patch
queue-5.15/net-dst-annotate-data-races-around-dst-output.patch
queue-5.15/ftrace-add-global-mutex-to-serialize-trace_parser-access.patch
queue-5.15/vduse-take-out-allocations-from-vduse_dev_alloc_coherent.patch
queue-5.15/lsm-infrastructure-management-of-the-sock-security.patch
queue-5.15/remoteproc-qcom-replace-kstrdup-with-kstrndup.patch
queue-5.15/ceph-print-cluster-fsid-and-client-global_id-in-all-debug-logs.patch
queue-5.15/audit-use-unsigned-int-instead-of-unsigned.patch
queue-5.15/media-mtk-vcodec-potential-null-pointer-deference-in.patch
queue-5.15/media-v4l2-fwnode-fix-subdev-owner-overwritten-in-v4l2_async_register_subdev_sensor.patch
queue-5.15/net-macb-use-napi-for-tx-completion-path.patch
queue-5.15/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-5.15/i2c-davinci-unregister-cpufreq-notifier-on-probe-failure.patch
queue-5.15/alsa-seq-close-a-re-opened-queue-timer-in-the-destructor.patch
queue-5.15/bootconfig-do-not-put-quotes-on-cmdline-items-unless-necessary.patch
queue-5.15/serial-8250_mid-fix-null-function-pointer-dereference-on-dnv-icx-d-snr-platforms.patch
queue-5.15/i2c-imx-separate-atomic-dma-and-non-dma-use-case.patch
queue-5.15/serial-sc16is7xx-fill-in-rs485_supported.patch
queue-5.15/locking-rt-fix-the-incorrect-rcu-protection-in-rt_spin_unlock.patch
queue-5.15/drm-displayid-fix-tiled-display-topology-id-size.patch
queue-5.15/netfilter-nft_set_pipapo-merge-deactivate-helper-into-caller.patch
queue-5.15/kvm-x86-mmu-directly-destroy-pte-list-when-recycling-rmaps.patch
queue-5.15/dm-integrity-don-t-increment-hash_offset-twice.patch
queue-5.15/vfs-audit-introduce-kern_path_parent-for-audit.patch
queue-5.15/bpf-fork-wipe-bpf_storage-before-bailouts-that-access-it.patch
queue-5.15/audit-fix-recursive-locking-deadlock-in-audit_dupe_exe.patch
queue-5.15/net-dst-add-four-helpers-to-annotate-data-races-around-dst-dev.patch
queue-5.15/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-5.15/thunderbolt-remove-xdomain-from-the-bus-without-holding-tb-lock.patch
queue-5.15/rxrpc-serialize-kernel-accept-preallocation-with-socket-teardown.patch
queue-5.15/net-macb-single-dma_alloc_coherent-for-dma-descriptors.patch
queue-5.15/serial-sc16is7xx-remove-obsolete-out_thread-label.patch
queue-5.15/9p-skip-nlink-update-in-cacheless-mode-to-fix-warn_on.patch
queue-5.15/dmaengine-dw-edma-add-spinlock-to-protect-done_int_mask-and-abort_int_mask.patch
queue-5.15/mmc-vub300-rename-probe-error-labels.patch
queue-5.15/net-macb-simplify-cleanup-napi-reschedule-checking.patch
queue-5.15/netfilter-nft_set_pipapo-use-gfp_kernel-for-insertions.patch
queue-5.15/mm-do-file-ownership-checks-with-the-proper-mount-idmap.patch
queue-5.15/vduse-use-fixed-4kb-bounce-pages-for-non-4kb-page-size.patch
queue-5.15/mtd-spi-nor-fix-spi_nor_try_unlock_all.patch
queue-5.15/alsa-hda-fix-cached-processing-coefficient-verbs.patch
queue-5.15/net-ip6_tunnel-require-cap_net_admin-in-the-device-netns-for-changelink.patch
queue-5.15/dm-verity-make-error-counter-atomic.patch
queue-5.15/media-aspeed-fix-missing-of_reserved_mem_device_release-on-probe-failure.patch
queue-5.15/alsa-hda-conexant-remove-mic-bias-threshold-override.patch
queue-5.15/media-i2c-imx219-correct-the-minimum-vblanking-value.patch
queue-5.15/mptcp-decrement-subflows-counter-on-failed-passive-join.patch
queue-5.15/ksmbd-validate-minimum-pdu-size-for-transform-requests.patch
queue-5.15/net-sched-sch_taprio-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
queue-5.15/i2c-imx-fix-locked-bus-on-smbus-block-read-of-0-atomic.patch
queue-5.15/drm-dp-mst-fix-buffer-overflows-in-sideband-chunk-accumulation.patch
queue-5.15/wifi-libertas_tf-fix-use-after-free-in-lbtf_free_adapter.patch
queue-5.15/kvm-x86-mmu-split-out-tdp-mmu-page-fault-handling.patch
queue-5.15/netfilter-nft_set_pipapo-don-t-leak-bad-clone-into-future-transaction.patch
queue-5.15/input-mms114-fix-touch-indexing-for-mms134s-and-mms136.patch
queue-5.15/smb-server-fix-minimum-smb2-pdu-size.patch
queue-5.15/mlxsw-spectrum-on-port-enslavement-to-a-lag-join-upper-s-bridges.patch
queue-5.15/firmware_loader-introduce-__free-cleanup-hanler.patch
queue-5.15/scsi-lpfc-fix-memory-leak-in-lpfc_sli4_driver_resource_setup.patch
queue-5.15/netfilter-nf_conntrack_sip-validate-skb_dst-before-accessing-it.patch
queue-5.15/thunderbolt-keep-xdomain-reference-during-the-lifetime-of-a-service.patch
queue-5.15/asoc-mediatek-mt8183-check-runtime-resume-during-probe.patch
queue-5.15/tcp-convert-to-dev_net_rcu.patch
queue-5.15/ceph-rename-_to_client-to-_to_fs_client.patch
queue-5.15/sc16is7xx-properly-resume-tx-after-stop.patch
queue-5.15/octeontx2-vf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-5.15/net-thunderbolt-fix-frags-overflow-by-bounding-frame_count.patch
queue-5.15/netfilter-nft_set_pipapo-make-pipapo_clone-helper-return-null.patch
queue-5.15/ntfs3-validate-split-point-offset-in-indx_insert_into_buffer.patch
queue-5.15/espintcp-use-sk_msg_free_partial-to-fix-partial-send.patch
queue-5.15/serial-8250_mid-remove-unneeded-test-for-setup-presence.patch
queue-5.15/net-macb-remove-illusion-about-tbqph-rbqph-being-per-queue.patch
queue-5.15/mptcp-fix-subflow-accounting-on-close.patch
queue-5.15/fscrypt-use-the-mount-idmap-for-the-owner-check-in-f.patch
queue-5.15/dmaengine-dw-edma-detach-the-private-data-and-chip-info-structures.patch
queue-5.15/input-ims-pcu-fix-firmware-leak-in-async-update.patch
queue-5.15/drm-amdgpu-fix-amdgpu_bo_move-when-old_mem-and-new_mem-are-both-gtt.patch
queue-5.15/media-i2c-imx219-drop-imx219_vts_-macros.patch
queue-5.15/net-sched-taprio-avoid-calling-child-ops-dequeue-child-twice.patch
queue-5.15/net-add-helper-function-to-parse-netlink-msg-of-ip_tunnel_encap.patch
queue-5.15/octeontx2-pf-fix-sqb-pointer-leak-on-init-failure.patch
queue-5.15/ksmbd-reject-repeated-smb2-negotiate-requests.patch
queue-5.15/tpm-tpm_tis_spi-use-wait_woken-in-wait_for_tmp_stat.patch
queue-5.15/media-i2c-imx219-rename-vts-to-frm_length.patch
queue-5.15/netfilter-nf_queue-pin-bridge-device-while-nfqueue-holds-fake-dst.patch
queue-5.15/mm-vmstat-fold-stranded-per-cpu-node-stats-when-a-node-comes-online.patch
queue-5.15/mptcp-cleanup-mpj-subflow-list-handling.patch
queue-5.15/remoteproc-qcom-fix-sparse-warnings.patch
queue-5.15/gpio-tegra-do-not-call-pinctrl-for-gpio-direction.patch
queue-5.15/libceph-fix-two-unsafe-bare-decodes-in-decode_lockers.patch
queue-5.15/net-sched-act_ct-preserve-tc_skb_cb-across-defragmentation.patch
queue-5.15/media-imx219-fix-maximum-frame-length-in-lines.patch
queue-5.15/serial-max310x-replace-bare-use-of-unsigned-with-unsigned-int-checkpatch.patch
queue-5.15/drm-i915-vrr-require-valid-min-max-vfreq-for-vrr.patch
queue-5.15/audit-widen-ino-fields-to-u64.patch
queue-5.15/lsm-use-default-hook-return-value-in-call_int_hook.patch
queue-5.15/net-macb-drop-in-flight-tx-skbs-on-close.patch
queue-5.15/asoc-mediatek-mt8192-afe-pcm-simplify-probe-with-local-dev-variable.patch
queue-5.15/media-v4l-async-set-owner-for-async-sub-devices.patch
queue-5.15/bpf-reject-bpf_map_type_inode_storage-creation-if-bpf-lsm-is-uninitialized.patch
queue-5.15/ovl-use-linked-upper-dentry-in-copy-up-tmpfile.patch
queue-5.15/netfilter-nft_set_pipapo-prepare-pipapo_get-helper-for-on-demand-clone.patch
queue-5.15/thunderbolt-remove-usage-of-the-deprecated-ida_simple_xx-api.patch
queue-5.15/netfilter-nft_set_pipapo-prepare-walk-function-for-on-demand-clone.patch
queue-5.15/taskstats-fill_stats_for_tgid-use-for_each_thread.patch
queue-5.15/thunderbolt-prevent-xdomain-delayed-work-use-after-free-on-disconnect.patch
queue-5.15/serial-sc16is7xx-fix-regression-with-gpio-configuration.patch
queue-5.15/asoc-mediatek-mt8192-afe-pcm-simplify-with-dev_err_probe.patch
queue-5.15/kvm-x86-mmu-rename-__direct_map-to-direct_map.patch
queue-5.15/asoc-mediatek-mt8192-afe-pcm-convert-to-devm_pm_runtime_enable.patch
queue-5.15/fs-resctrl-fix-double-add-of-pseudo-locked-region-s-rmid-to-free-list.patch
queue-5.15/dmaengine-dw-edma-remove-unused-irq-field-in-struct-dw_edma_chip.patch
queue-5.15/net-dst-annotate-data-races-around-dst-input.patch
queue-5.15/drm-virtio-use-uninterruptible-resv-lock-for-plane-updates.patch
queue-5.15/ksmbd-defer-destroy_previous_session-until-after-ntlm-authentication.patch
queue-5.15/drm-virtio-return-proper-error-codes-instead-of-1.patch
queue-5.15/serial-max310x-implement-gpio_chip-get_direction.patch
queue-5.15/sctp-avoid-auth_enable-sysctl-uaf-during-netns-teardown.patch
queue-5.15/kvm-x86-mmu-rename-pte_list_-destroy-remove-to-show-they-zap-sptes.patch
