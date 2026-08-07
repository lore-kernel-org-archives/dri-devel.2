Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1665C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAEF10F4D1;
	Fri,  7 Aug 2026 13:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qyzxb9Np";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ACD10F4C8
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:06:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDB71600D8;
 Fri,  7 Aug 2026 13:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5C1F000E9;
 Fri,  7 Aug 2026 13:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786108001;
 bh=avZCRQbkpPaUbAJpLDXP70sHq/iZO29mcAxmY+IKOBU=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=Qyzxb9Np29/1omcZG3mInY6Tp3s7FSkXTDU30K/IGvJWUyhIgMMkvlaXAfwqYHoPr
 /5dBzyM8Z8xe6gh3jPBtNIb+UkOQW5MkV/3iFyqlzL4+KjH1AyRDLxG55ZK/Gnfec4
 a9m5X5n4MKvoUcT4nd+Ky53MJE64JIoD8LBSd3kk=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 6.12-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Aug 2026 15:05:39 +0200
In-Reply-To: <20260731111052.3596094-2-sashal@kernel.org>
Message-ID: <2026080738-enzyme-registry-c810@gregkh>
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

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-294035-greg=kroah.com@vger.kernel.org Fri Jul 31 13:23:29 2026
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 31 Jul 2026 07:10:52 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731111052.3596094-2-sashal@kernel.org>

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
 drivers/gpu/drm/tegra/fbdev.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -75,7 +75,6 @@ static int tegra_fbdev_probe(struct drm_
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -112,9 +111,6 @@ static int tegra_fbdev_probe(struct drm_
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -126,9 +122,9 @@ static int tegra_fbdev_probe(struct drm_
 	}
 
 	info->flags |= FBINFO_VIRTFB;
-	info->screen_buffer = bo->vaddr + offset;
+	info->screen_buffer = bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;


Patches currently in stable-queue which might be from sashal@kernel.org are

queue-6.12/wifi-brcmfmac-set-f2-blocksize-to-256-for-bcm43752.patch
queue-6.12/net-dsa-mt7530-check-bus-read-errors-in-the-mdio-reg.patch
queue-6.12/um-set-parent-death-signal-for-userspace-process.patch
queue-6.12/usb-gadget-f_tcm-synchronize-delayed-set_alt-with-teardown.patch
queue-6.12/drm-xe-rtp-de-whitelist-oa-registers-for-all-hwe-s-f.patch
queue-6.12/media-uapi-rkisp-correct-name-version-enum.patch
queue-6.12/net-sxgbe-free-tx-rings-on-rx-allocation-failure.patch
queue-6.12/rtase-fix-double-free-of-multi-frag-skb-on-dma-map-f.patch
queue-6.12/usb-typec-ucsi-fix-race-condition-and-ordering-in-port-unregistration.patch
queue-6.12/drm-xe-introduce-xe_gt_dbg_printer.patch
queue-6.12/drm-fb-helper-allocate-and-release-fb_info-in-single-place.patch
queue-6.12/drm-xe-rtp-maintain-oa-whitelists-separately.patch
queue-6.12/pinctrl-qcom-sc8280xp-add-missing-wakeup-entries-for.patch
queue-6.12/forcedeth-fix-uaf-of-txrx_stats-in-nv_remove.patch
queue-6.12/alsa-hda-codecs-hdmi-disable-keep-alive-before-audio-format-change.patch
queue-6.12/hid-logitech-dj-standardise-hid_report_enum-variable.patch
queue-6.12/scsi-libsas-fix-ha-resume-deadlock-and-hisi_sas-disk.patch
queue-6.12/netfilter-nft_payload-fix-mask-build-for-partial-fie.patch
queue-6.12/bluetooth-iso-fix-timeout-vs-sync_timeout-typo-in-ch.patch
queue-6.12/um-set-parent-death-signal-for-ubd-io-thread-process.patch
queue-6.12/net-sxgbe-check-descriptor-ring-allocation-failures.patch
queue-6.12/ipvs-fix-the-checksum-validations.patch
queue-6.12/mptcp-pm-avoid-code-duplication-to-lookup-endp.patch
queue-6.12/hwmon-ina2xx-fix-various-overflow-issues.patch
queue-6.12/spi-spi-cadence-move-tx-fifo-full-busy-wait-into-fif.patch
queue-6.12/powerpc-boot-fix-simpleboot-cpu-node-lookup-check.patch
queue-6.12/ata-sata_mv-accept-1-or-2-resources-in-platform-prob.patch
queue-6.12/drm-xe-rtp-generalize-whitelist_apply_to_hwe.patch
queue-6.12/wifi-mac80211-validate-individual-twt-params-before-.patch
queue-6.12/mm-hugetlb-fix-swap-entry-corruption-when-clearing-u.patch
queue-6.12/dmaengine-idxd-fix-fdev-setup-failure-cleanup-in-idx.patch
queue-6.12/asoc-max98090-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.12/keys-trusted-dcp-fix-key_len-validation-and-calc_blo.patch
queue-6.12/drm-xe-oa-de-whitelist-oa-registers-on-oa-stream-ope.patch
queue-6.12/mptcp-pm-use-addr-entry-for-get_local_id.patch
queue-6.12/drm-xe-rtp-save-oa-nonpriv-registers-to-register-sav.patch
queue-6.12/bluetooth-hci_sync-remove-unnecessary-hci_conn_get-i.patch
queue-6.12/drm-mediatek-check-crtc-state-before-freeing.patch
queue-6.12/bluetooth-iso-clear-iso_data-always-when-detaching-c.patch
queue-6.12/bluetooth-iso-fix-leaking-sk-after-socket-release.patch
queue-6.12/hwmon-ina2xx-add-support-for-ina260.patch
queue-6.12/accel-qaic-use-sizeof-trans_hdr-for-transaction-leng.patch
queue-6.12/pinctrl-amd-don-t-clear-s4-wake-bits-at-probe.patch
queue-6.12/net-bridge-mrp-fix-option-tlv-length-in-mrp_test-fra.patch
queue-6.12/kmemleak-iommu-iova-fix-transient-kmemleak-false-positive.patch
queue-6.12/gpio-pch-use-raw_spinlock_t-for-the-register-lock.patch
queue-6.12/drm-xe-rtp-refactor-oag-mmio-trigger-register-whitel.patch
queue-6.12/hwmon-ina2xx-add-support-for-ina234.patch
queue-6.12/drm-xe-apply-whitelist-to-engine-save-restore.patch
queue-6.12/powerpc-boot-fix-treeboot-currituck-cpu-node-lookup-.patch
queue-6.12/wifi-ath6kl-fix-use-after-free-in-aggr_reset_state.patch
queue-6.12/wifi-brcmfmac-fix-43752-sdio-fwvid-incorrectly-labelled-as-cypress-cyw.patch
queue-6.12/keys-make-keyring-key-chunk-byte-order-agree-with-ke.patch
queue-6.12/drm-xe-rtp-toggle-deny-bit-to-de-whitelist-oa-regs.patch
queue-6.12/hwmon-adt7470-fix-fans-stuck-in-manual-mode-on-i2c-e.patch
queue-6.12/net-airoha-fix-register-index-for-tx-fwd-counter-con.patch
queue-6.12/ata-ahci_ceva-fix-error-paths-in-ceva_ahci_platform_.patch
queue-6.12/qede-sync-udp_tunnel-ports-outside-qede_lock-in-the-.patch
queue-6.12/tracing-mmiotrace-reset-dropped_count-in-mmio_reset_.patch
queue-6.12/netfilter-nf_conntrack_sip-widen-nat-rewrite-delta-t.patch
queue-6.12/drm-i915-hdcp-move-to-using-intel_display-in-intel_hdcp.patch
queue-6.12/usb-typec-ucsi-split-connector-lock-classes.patch
queue-6.12/ahci-introduce-ahci_ignore_port-helper.patch
queue-6.12/drm-i915-hdcp-require-monotonically-increasing-seq_num_v.patch
queue-6.12/net-udp_tunnel-fix-memory-leak-in-udp_tunnel_nic_unr.patch
queue-6.12/bluetooth-iso-validate-sockaddr_iso-first-in-iso_soc.patch
queue-6.12/net-libwx-fix-fdir-atr-queue-mismatch-for-software-v.patch
queue-6.12/riscv-mm-fix-out-of-bounds-page-table-walk-during-me.patch
queue-6.12/netfilter-nf_tables-make-nft_object-rhltable-per-tab.patch
queue-6.12/mm-huge_memory-unlock-i_mmap_rwsem-before-releasing-.patch
queue-6.12/bluetooth-l2cap-fix-uaf-in-l2cap_le_connect_rsp.patch
queue-6.12/hwmon-ina226-add-support-for-sy24655.patch
queue-6.12/scsi-zfcp-fix-memory-leak-during-adapter-release-by-.patch
queue-6.12/mptcp-pm-userspace-fix-use-after-free-in-get_local_id.patch
queue-6.12/hwmon-ina2xx-make-it-easier-to-add-more-devices.patch
queue-6.12/net-dsa-mt7530-error-out-on-failed-reads-in-mt7531-p.patch
queue-6.12/scsi-libiscsi_tcp-bound-scsi-response-data-segment-t.patch
queue-6.12/bluetooth-hci_conn-hold-conn-reference-in-abort_conn.patch
queue-6.12/ipvs-do-not-mangle-icmp-replies-for-non-first-fragme.patch
queue-6.12/phy-zynqmp-fix-clock-error-handling-in-xpsgtr_phy_in.patch
queue-6.12/asoc-max98095-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.12/hid-logitech-dj-fix-wrong-detection-of-bad-dj_short-.patch
queue-6.12/rds-tcp-hold-the-rcu-lock-across-ipv6_chk_addr-in-rd.patch
queue-6.12/drm-xe-rtp-ensure-locking-ref-counting-for-oa-whitel.patch
queue-6.12/um-add-os_set_pdeathsig-helper-function.patch
queue-6.12/hwmon-lm90-only-report-alarms-if-driver-is-ready.patch
queue-6.12/of-reserved_mem-add-code-to-dynamically-allocate-res.patch
queue-6.12/bpf-reset-register-bounds-before-narrowing-retval-ra.patch
queue-6.12/drm-xe-rtp-keep-track-of-non-oa-nonpriv-slots.patch
queue-6.12/net-ethernet-mtk_eth_soc-support-named-irqs.patch
queue-6.12/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-6.12/hwmon-adt7470-fix-divide-by-zero-toctou-crash-in-fan.patch
queue-6.12/mptcp-add-mptcp_userspace_pm_lookup_addr-helper.patch
queue-6.12/drm-sched-store-the-drm-client_id-in-drm_sched_fence.patch
queue-6.12/of-reserved_mem-prevent-oob-when-too-many-dynamic-re.patch
queue-6.12/hwmon-adt7470-fix-temperature-alarm-logic-in-hwmon_t.patch
queue-6.12/ksmbd-return-success-for-deferred-final-close.patch
queue-6.12/hwmon-ina2xx-add-support-for-has_alerts-configuratio.patch
queue-6.12/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-6.12/scsi-ufs-core-cancel-rtc-work-in-active-active-suspe.patch
queue-6.12/drm-exec-remove-the-index-parameter-from-drm_exec_for_each_locked_obj.patch
queue-6.12/hwmon-adt7470-fix-cache-updated-before-hardware-writ.patch
queue-6.12/assoc_array-trim-the-final-shortcut-word-using-the-c.patch
queue-6.12/mm-kmemleak-fix-checksum-computation-for-per-cpu-objects.patch
queue-6.12/ksmbd-fix-use-after-free-in-__close_file_table_ids.patch
queue-6.12/drm-xe-wait-on-external-bo-kernel-fences-in-exec-ioctl.patch
queue-6.12/drm-amdgpu-gfx-fix-cleaner-shader-ib-buffer-overflow.patch
queue-6.12/netfilter-xt_hashlimit-validate-hashtable-supports-x.patch
queue-6.12/scsi-target-iblock-fix-wrong-pr-ops-null-check-for-p.patch
queue-6.12/net-ethernet-mtk_eth_soc-add-consts-for-irq-index.patch
queue-6.12/hwmon-adt7470-fix-swapped-pwm3-and-pwm4-auto-mode-ma.patch
queue-6.12/media-chips-media-wave5-support-cbp-profile.patch
queue-6.12/um-use-os_set_pdeathsig-helper-in-winch-thread-proce.patch
queue-6.12/idpf-fix-mailbox-irq-name-leak-on-request-failure.patch
queue-6.12/drm-i915-vrr-check-has_vrr-first-in-intel_vrr_is_capable.patch
queue-6.12/btrfs-fix-leaking-btrfs_fs_state_remounting-flag.patch
queue-6.12/netfilter-br_netfilter-reallocate-headroom-if-necess.patch
queue-6.12/idpf-adjust-txq-ring-count-minimum.patch
queue-6.12/pinctrl-qcom-unconditionally-mark-gpio-as-wakeup-ena.patch
queue-6.12/gpio-sloppy-logic-analyzer-fix-memory-leak-in-gpio_l.patch
queue-6.12/keys-fix-out-of-bounds-read-in-keyring_get_key_chunk.patch
queue-6.12/drm-amdgpu-fix-context-pstate-override-handling.patch
queue-6.12/hwmon-sht3x-fix-unaligned-accesses.patch
queue-6.12/mm-slab-prevent-unbounded-recursion-in-free-path-wit.patch
queue-6.12/fs-proc-task_mmu-fix-pagemap_scan-written-state-for-.patch
queue-6.12/hwmon-adt7470-use-cached-pwm-frequency-value.patch
queue-6.12/hwmon-pmbus-fix-return-value-from-pmbus_update_byte_.patch
queue-6.12/phy-zynqmp-fix-runtime-pm-leak-on-probe-allocation-f.patch
queue-6.12/scsi-libiscsi-fix-stale-data-leak-into-the-scsi-sens.patch
queue-6.12/tracing-mmiotrace-add-null-check-for-mmio_trace_arra.patch
queue-6.12/drm-xe-rtp-add-ring_force_to_nonpriv_deny-to-oa-whit.patch
queue-6.12/spi-spi-cadence-supports-transmission-with-bits_per_.patch
queue-6.12/kunit-tool-skip-stty-when-stdin-is-not-a-tty.patch
queue-6.12/um-preserve-errno-within-signal-handler.patch
queue-6.12/ipvs-fix-places-with-wrong-packet-offsets.patch
queue-6.12/hwmon-adt7470-fix-pwm-auto-temp-state-array-and-boun.patch
queue-6.12/hwmon-ina2xx-shift-ina234-shunt-and-current-register.patch
queue-6.12/drm-amdgpu-give-each-kernel-job-a-unique-id.patch
queue-6.12/netconsole-avoid-oob-reads-msg-is-not-nul-terminated.patch
queue-6.12/bluetooth-hci_sync-make-hci_cmd_sync_run_once-return.patch
queue-6.12/hwmon-adt7470-fix-busy-loop-and-i2c-flooding-in-upda.patch
queue-6.12/bluetooth-iso-avoid-deadlocks-in-iso_sock_timeout.patch
queue-6.12/hwmon-nct6775-core-fix-number-of-temperature-registe.patch
queue-6.12/hwmon-nct6775-core-prevent-access-to-unsupported-wei.patch
queue-6.12/dmaengine-sun6i-dma-fix-reclaim-descriptors-while-te.patch
queue-6.12/drm-xe-hold-a-dma-buf-reference-for-imported-bos.patch
queue-6.12/sched-deadline-use-revised-wakeup-rule-only-for-runn.patch
queue-6.12/rds-fix-inet6_addr_lst-null-dereference-when-ipv6-is.patch
queue-6.12/media-i2c-imx219-rename-vts-to-frm_length.patch
queue-6.12/smb-client-fix-buffer-leaks-in-smb1-read-and-write.patch
queue-6.12/scsi-target-clear-cmd_cnt-when-initial-counter-enrol.patch
queue-6.12/lib-alloc_tag-introduce-mem_alloc_profiling_permanen.patch
queue-6.12/bluetooth-hci_sync-fix-hci_conn_del-use-in-hci_le_cr.patch
queue-6.12/net-phylink-put-link_gpio-if-phylink_create-fails.patch
queue-6.12/btrfs-zoned-fix-deadlock-between-metadata-writeback-.patch
queue-6.12/media-imx219-fix-maximum-frame-length-in-lines.patch
queue-6.12/tracing-remove-trace_event_fl_filtered-logic.patch
queue-6.12/drm-i915-vrr-require-valid-min-max-vfreq-for-vrr.patch
queue-6.12/um-set-parent-death-signal-for-write_sigio-thread-pr.patch
queue-6.12/hwmon-nzxt-smart2-dma-align-output-buffer.patch
queue-6.12/rhashtable-clear-stale-iter-p-on-table-restart.patch
queue-6.12/drm-amdgpu-respect-placement-requirements-in-amdgpu_gtt_mgr-functions.patch
queue-6.12/powerpc-boot-fix-treeboot-akebono-cpu-node-lookup-ch.patch
queue-6.12/hwmon-ltc4282-fix-reading-the-minimum-alarm-voltage.patch
queue-6.12/thunderbolt-prevent-xdomain-delayed-work-use-after-f.patch
queue-6.12/ata-libahci_platform-support-non-consecutive-port-nu.patch
queue-6.12/octeontx2-pf-set-correct-sequence-for-carrier-off-an.patch
queue-6.12/net-mpls-initialize-rtm_tos-in-mpls_getroute.patch
queue-6.12/um-set-parent-death-signal-for-winch-thread-process.patch
queue-6.12/netfilter-nf_conntrack_expect-restore-helper-propaga.patch
queue-6.12/bluetooth-btintel-validate-length-before-parsing-dia.patch
queue-6.12/net-ethernet-mtk_eth_soc-pass-eth-to-mtk_handle_irq_.patch
queue-6.12/drivers-hv-vmbus-replace-lockdep_hardirq_threaded-wi.patch
queue-6.12/drm-xe-rename-___xe_bo_create_locked.patch
queue-6.12/hid-logitech-dj-prevent-report_id_dj_short-related-u.patch
queue-6.12/net-do-not-send-icmp-ndisc-redirects-when-peer-alloc.patch
queue-6.12/phy-zynqmp-postpone-getting-clock-rate-until-actuall.patch
queue-6.12/kunit-tool-terminate-kernel-under-test-on-sigint.patch
queue-6.12/can-isotp-check-register_netdevice_notifier-error-in.patch
