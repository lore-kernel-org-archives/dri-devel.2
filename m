Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD94C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AB310F498;
	Fri,  7 Aug 2026 12:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SF9QElLj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA6E10F498
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 12:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43DB443B4E;
 Fri,  7 Aug 2026 12:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F301F00A3E;
 Fri,  7 Aug 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786104931;
 bh=XiCPUtUZ2JanFLTnd6AnX+6XOjqlusgmct3pFa3Ldk8=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=SF9QElLjH6n0R95B84l4m4sG8qSY0QHQ/tH8sl023aO8YiYREi2v8Hk3jWQFGM6Pe
 LYTDvD5lLkgiuN0jdChxNJGdHksNckDh2FbArOcngESrjvxQfwvfIiF92IPZcxtmTW
 9S5u4KShjjVJNLG1Nk+3miAC0958cQN2Dx3YT18c=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 6.18-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Aug 2026 14:14:59 +0200
In-Reply-To: <20260731024101.3339564-2-sashal@kernel.org>
Message-ID: <2026080759-huddle-guide-a496@gregkh>
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

to the 6.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-6.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-293911-greg=kroah.com@vger.kernel.org Fri Jul 31 04:41:11 2026
From: Sasha Levin <sashal@kernel.org>
Date: Thu, 30 Jul 2026 22:41:01 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731024101.3339564-2-sashal@kernel.org>

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
@@ -78,7 +78,6 @@ int tegra_fbdev_driver_fbdev_probe(struc
 	struct fb_info *info = helper->info;
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct tegra_bo *bo;
 	size_t size;
 	int err;
@@ -118,9 +117,6 @@ int tegra_fbdev_driver_fbdev_probe(struc
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -132,9 +128,9 @@ int tegra_fbdev_driver_fbdev_probe(struc
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

queue-6.18/net-dsa-mt7530-check-bus-read-errors-in-the-mdio-reg.patch
queue-6.18/drm-xe-guc-fix-buffer-overflow-in-steered-register-list-allocation.patch
queue-6.18/drm-xe-rtp-de-whitelist-oa-registers-for-all-hwe-s-f.patch
queue-6.18/media-uapi-rkisp-correct-name-version-enum.patch
queue-6.18/net-sxgbe-free-tx-rings-on-rx-allocation-failure.patch
queue-6.18/rtase-fix-double-free-of-multi-frag-skb-on-dma-map-f.patch
queue-6.18/usb-typec-ucsi-fix-race-condition-and-ordering-in-port-unregistration.patch
queue-6.18/asoc-sdca-ensure-that-control-range-is-large-enough-.patch
queue-6.18/ice-suppress-dpll-errors-during-reset-recovery.patch
queue-6.18/drivers-hv-allocate-the-paravisor-synic-pages-when-r.patch
queue-6.18/scsi-ufs-core-avoid-irq-thread-wakeup-during-active-.patch
queue-6.18/drm-fb-helper-allocate-and-release-fb_info-in-single-place.patch
queue-6.18/drm-xe-rtp-maintain-oa-whitelists-separately.patch
queue-6.18/pinctrl-qcom-sc8280xp-add-missing-wakeup-entries-for.patch
queue-6.18/forcedeth-fix-uaf-of-txrx_stats-in-nv_remove.patch
queue-6.18/hid-logitech-dj-standardise-hid_report_enum-variable.patch
queue-6.18/scsi-libsas-fix-ha-resume-deadlock-and-hisi_sas-disk.patch
queue-6.18/selftest-af_unix-create-its-own-.gitignore.patch
queue-6.18/netfilter-nft_payload-fix-mask-build-for-partial-fie.patch
queue-6.18/ptp-netc-fix-potential-interrupt-storm-caused-by-inc.patch
queue-6.18/bluetooth-iso-fix-timeout-vs-sync_timeout-typo-in-ch.patch
queue-6.18/net-sxgbe-check-descriptor-ring-allocation-failures.patch
queue-6.18/bluetooth-iso-fix-data-race-on-iso_pi-sk-in-socket-a.patch
queue-6.18/ipvs-fix-the-checksum-validations.patch
queue-6.18/net-handshake-drain-pending-requests-at-net-namespac.patch
queue-6.18/media-qcom-camss-csid-340-fix-unused-variables.patch
queue-6.18/phy-qcom-m31-eusb2-fix-return-value-of-init-call.patch
queue-6.18/hwmon-ina2xx-fix-various-overflow-issues.patch
queue-6.18/spi-spi-cadence-move-tx-fifo-full-busy-wait-into-fif.patch
queue-6.18/powerpc-boot-fix-simpleboot-cpu-node-lookup-check.patch
queue-6.18/ata-sata_mv-accept-1-or-2-resources-in-platform-prob.patch
queue-6.18/arch-x86-mshyperv-discover-confidential-vmbus-availa.patch
queue-6.18/drm-xe-rtp-generalize-whitelist_apply_to_hwe.patch
queue-6.18/wifi-mac80211-validate-individual-twt-params-before-.patch
queue-6.18/drivers-hv-rename-fields-for-synic-message-and-event.patch
queue-6.18/mm-hugetlb-fix-swap-entry-corruption-when-clearing-u.patch
queue-6.18/selftests-af_unix-add-tests-for-econnreset-and-eof-s.patch
queue-6.18/dmaengine-idxd-fix-fdev-setup-failure-cleanup-in-idx.patch
queue-6.18/asoc-max98090-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.18/keys-trusted-dcp-fix-key_len-validation-and-calc_blo.patch
queue-6.18/drm-xe-oa-de-whitelist-oa-registers-on-oa-stream-ope.patch
queue-6.18/drm-xe-rtp-save-oa-nonpriv-registers-to-register-sav.patch
queue-6.18/bluetooth-hci_sync-remove-unnecessary-hci_conn_get-i.patch
queue-6.18/drm-mediatek-check-crtc-state-before-freeing.patch
queue-6.18/bluetooth-iso-clear-iso_data-always-when-detaching-c.patch
queue-6.18/bluetooth-iso-fix-leaking-sk-after-socket-release.patch
queue-6.18/accel-qaic-use-sizeof-trans_hdr-for-transaction-leng.patch
queue-6.18/pinctrl-amd-don-t-clear-s4-wake-bits-at-probe.patch
queue-6.18/net-bridge-mrp-fix-option-tlv-length-in-mrp_test-fra.patch
queue-6.18/iommu-arm-smmu-v3-iommufd-require-exactly-one-stream.patch
queue-6.18/selftests-net-af_unix-test-listen-rejects-wrong-sock.patch
queue-6.18/file-ensure-cleanup.patch
queue-6.18/drm-xe-rtp-refactor-oag-mmio-trigger-register-whitel.patch
queue-6.18/hwmon-ina2xx-add-support-for-ina234.patch
queue-6.18/powerpc-boot-fix-treeboot-currituck-cpu-node-lookup-.patch
queue-6.18/mshv-fix-level-triggered-check-on-uninitialized-data.patch
queue-6.18/keys-make-keyring-key-chunk-byte-order-agree-with-ke.patch
queue-6.18/drm-xe-rtp-toggle-deny-bit-to-de-whitelist-oa-regs.patch
queue-6.18/hwmon-adt7470-fix-fans-stuck-in-manual-mode-on-i2c-e.patch
queue-6.18/af_unix-fix-listen-succeeding-on-sockets-in-the-wron.patch
queue-6.18/btrfs-raid56-fix-an-incorrect-csum-skip-during-scrub.patch
queue-6.18/ata-ahci_ceva-fix-error-paths-in-ceva_ahci_platform_.patch
queue-6.18/qede-sync-udp_tunnel-ports-outside-qede_lock-in-the-.patch
queue-6.18/netfs-release-readahead-folios-on-iterator-preparati.patch
queue-6.18/tracing-mmiotrace-reset-dropped_count-in-mmio_reset_.patch
queue-6.18/netfilter-nf_conntrack_sip-widen-nat-rewrite-delta-t.patch
queue-6.18/selftests-seccomp-fix-pointer-type-mismatch-build-er.patch
queue-6.18/netfs-handle-single-writeback-rolling-buffer-allocat.patch
queue-6.18/usb-typec-ucsi-split-connector-lock-classes.patch
queue-6.18/net-udp_tunnel-fix-memory-leak-in-udp_tunnel_nic_unr.patch
queue-6.18/bluetooth-iso-validate-sockaddr_iso-first-in-iso_soc.patch
queue-6.18/net-libwx-fix-fdir-atr-queue-mismatch-for-software-v.patch
queue-6.18/riscv-mm-fix-out-of-bounds-page-table-walk-during-me.patch
queue-6.18/netfilter-nf_tables-make-nft_object-rhltable-per-tab.patch
queue-6.18/mm-huge_memory-unlock-i_mmap_rwsem-before-releasing-.patch
queue-6.18/netfs-clear-pg_private_2-on-copy-to-cache-append-fai.patch
queue-6.18/drm-i915-dp-ignore-the-sink-s-dsc-max-frl-rate-witho.patch
queue-6.18/bluetooth-l2cap-fix-uaf-in-l2cap_le_connect_rsp.patch
queue-6.18/scsi-zfcp-fix-memory-leak-during-adapter-release-by-.patch
queue-6.18/hwmon-ina2xx-make-it-easier-to-add-more-devices.patch
queue-6.18/net-dsa-mt7530-error-out-on-failed-reads-in-mt7531-p.patch
queue-6.18/scsi-libiscsi_tcp-bound-scsi-response-data-segment-t.patch
queue-6.18/bluetooth-iso-fix-refcounting-of-iso_conn.patch
queue-6.18/net-handshake-hand-off-the-pinned-file-reference-to-.patch
queue-6.18/mshv-fix-sleeping-under-spinlock-in-mshv_portid_allo.patch
queue-6.18/mshv-adjust-interrupt-control-structure-for-arm64.patch
queue-6.18/bluetooth-hci_conn-hold-conn-reference-in-abort_conn.patch
queue-6.18/ipvs-do-not-mangle-icmp-replies-for-non-first-fragme.patch
queue-6.18/phy-zynqmp-fix-clock-error-handling-in-xpsgtr_phy_in.patch
queue-6.18/asoc-max98095-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.18/mshv-fix-duplicate-gsi-detection-for-gsi-0.patch
queue-6.18/hid-logitech-dj-fix-wrong-detection-of-bad-dj_short-.patch
queue-6.18/rds-tcp-hold-the-rcu-lock-across-ipv6_chk_addr-in-rd.patch
queue-6.18/bluetooth-iso-fix-connected-closed-transition-on-shu.patch
queue-6.18/drm-xe-rtp-ensure-locking-ref-counting-for-oa-whitel.patch
queue-6.18/hwmon-lm90-only-report-alarms-if-driver-is-ready.patch
queue-6.18/drm-xe-rtp-keep-track-of-non-oa-nonpriv-slots.patch
queue-6.18/mshv-order-pt_vp_array-publish-against-irqfd-asserti.patch
queue-6.18/bluetooth-iso-hold-sk-properly-in-iso_conn_ready.patch
queue-6.18/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-6.18/hwmon-adt7470-fix-divide-by-zero-toctou-crash-in-fan.patch
queue-6.18/spi-spi-nxp-fspi-add-per-soc-sdr-dtr-clock-rate-limi.patch
queue-6.18/of-reserved_mem-prevent-oob-when-too-many-dynamic-re.patch
queue-6.18/hwmon-adt7470-fix-temperature-alarm-logic-in-hwmon_t.patch
queue-6.18/btrfs-zoned-reset-meta_write_pointer-on-zone-reset.patch
queue-6.18/ksmbd-return-success-for-deferred-final-close.patch
queue-6.18/fprobe-fix-module-reference-count-leak-on-error-in-r.patch
queue-6.18/bluetooth-iso-ensure-no-dangling-hcon-references-in-.patch
queue-6.18/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-6.18/scsi-ufs-core-cancel-rtc-work-in-active-active-suspe.patch
queue-6.18/hwmon-adt7470-fix-cache-updated-before-hardware-writ.patch
queue-6.18/assoc_array-trim-the-final-shortcut-word-using-the-c.patch
queue-6.18/ksmbd-fix-use-after-free-in-__close_file_table_ids.patch
queue-6.18/netfilter-xt_hashlimit-validate-hashtable-supports-x.patch
queue-6.18/scsi-target-iblock-fix-wrong-pr-ops-null-check-for-p.patch
queue-6.18/hwmon-adt7470-fix-swapped-pwm3-and-pwm4-auto-mode-ma.patch
queue-6.18/media-chips-media-wave5-support-cbp-profile.patch
queue-6.18/idpf-fix-mailbox-irq-name-leak-on-request-failure.patch
queue-6.18/xsk-use-a-smaller-new-lock-for-shared-pool-case.patch
queue-6.18/btrfs-fix-leaking-btrfs_fs_state_remounting-flag.patch
queue-6.18/netfilter-br_netfilter-reallocate-headroom-if-necess.patch
queue-6.18/idpf-adjust-txq-ring-count-minimum.patch
queue-6.18/pinctrl-qcom-unconditionally-mark-gpio-as-wakeup-ena.patch
queue-6.18/gpio-sloppy-logic-analyzer-fix-memory-leak-in-gpio_l.patch
queue-6.18/file-add-fd_-add-prepare.patch
queue-6.18/keys-fix-out-of-bounds-read-in-keyring_get_key_chunk.patch
queue-6.18/drm-amdgpu-fix-context-pstate-override-handling.patch
queue-6.18/hwmon-sht3x-fix-unaligned-accesses.patch
queue-6.18/mm-slab-prevent-unbounded-recursion-in-free-path-wit.patch
queue-6.18/fs-proc-task_mmu-fix-pagemap_scan-written-state-for-.patch
queue-6.18/hwmon-adt7470-use-cached-pwm-frequency-value.patch
queue-6.18/hwmon-pmbus-fix-return-value-from-pmbus_update_byte_.patch
queue-6.18/iomap-add-a-separate-bio_set-for-iomap_split_ioend.patch
queue-6.18/mshv-fix-race-in-mshv_irqfd_deassign.patch
queue-6.18/selftests-lkdtm-rename-stackleak_erasing-to-kstack_e.patch
queue-6.18/phy-zynqmp-fix-runtime-pm-leak-on-probe-allocation-f.patch
queue-6.18/kvm-arm64-reject-guest_memfd-memslots-when-the-vm-ha.patch
queue-6.18/scsi-libiscsi-fix-stale-data-leak-into-the-scsi-sens.patch
queue-6.18/asoc-tas2781-use-correct-calibration-data-for-sinega.patch
queue-6.18/tracing-mmiotrace-add-null-check-for-mmio_trace_arra.patch
queue-6.18/bluetooth-iso-lock-sk-in-iso_sock_getname.patch
queue-6.18/drm-xe-rtp-add-ring_force_to_nonpriv_deny-to-oa-whit.patch
queue-6.18/x86-boot-add-volatile-clobbers-and-zero-length-test-.patch
queue-6.18/net-handshake-take-a-long-lived-file-reference-at-su.patch
queue-6.18/spi-spi-cadence-supports-transmission-with-bits_per_.patch
queue-6.18/kunit-tool-skip-stty-when-stdin-is-not-a-tty.patch
queue-6.18/ipvs-fix-places-with-wrong-packet-offsets.patch
queue-6.18/net-handshake-convert-handshake_nl_accept_doit-to-fd.patch
queue-6.18/hwmon-adt7470-fix-pwm-auto-temp-state-array-and-boun.patch
queue-6.18/drm-gpusvm-publish-dpagemap-early-to-avoid-device-ma.patch
queue-6.18/hwmon-ina2xx-shift-ina234-shunt-and-current-register.patch
queue-6.18/scsi-ufs-core-revert-delegate-the-interrupt-service-.patch
queue-6.18/xsk-fix-buffer-leak-in-xsk_drop_skb-for-af_xdp-multi.patch
queue-6.18/media-qcom-camss-fix-rdi-streaming-for-csid-340.patch
queue-6.18/bluetooth-hci_sync-make-hci_cmd_sync_run_once-return.patch
queue-6.18/hwmon-adt7470-fix-busy-loop-and-i2c-flooding-in-upda.patch
queue-6.18/bluetooth-iso-avoid-deadlocks-in-iso_sock_timeout.patch
queue-6.18/hwmon-nct6775-core-fix-number-of-temperature-registe.patch
queue-6.18/hwmon-nct6775-core-prevent-access-to-unsupported-wei.patch
queue-6.18/dmaengine-sun6i-dma-fix-reclaim-descriptors-while-te.patch
queue-6.18/sched-deadline-use-revised-wakeup-rule-only-for-runn.patch
queue-6.18/rds-fix-inet6_addr_lst-null-dereference-when-ipv6-is.patch
queue-6.18/net-handshake-close-the-submit-side-sock_hold-race.patch
queue-6.18/bluetooth-iso-fix-not-updating-bis-sender-source-add.patch
queue-6.18/smb-client-fix-buffer-leaks-in-smb1-read-and-write.patch
queue-6.18/scsi-target-clear-cmd_cnt-when-initial-counter-enrol.patch
queue-6.18/lib-alloc_tag-introduce-mem_alloc_profiling_permanen.patch
queue-6.18/bluetooth-hci-add-initial-support-for-past.patch
queue-6.18/bluetooth-hci_sync-fix-hci_conn_del-use-in-hci_le_cr.patch
queue-6.18/net-phylink-put-link_gpio-if-phylink_create-fails.patch
queue-6.18/btrfs-zoned-fix-deadlock-between-metadata-writeback-.patch
queue-6.18/drm-i915-hdmi-poll-for-200-msec-for-tmds_scrambler_s.patch
queue-6.18/net-handshake-fix-null-ptr-deref-in-handshake_comple.patch
queue-6.18/hwmon-nzxt-smart2-dma-align-output-buffer.patch
queue-6.18/drm-amdgpu-respect-placement-requirements-in-amdgpu_gtt_mgr-functions.patch
queue-6.18/powerpc-boot-fix-treeboot-akebono-cpu-node-lookup-ch.patch
queue-6.18/hwmon-ltc4282-fix-reading-the-minimum-alarm-voltage.patch
queue-6.18/thunderbolt-prevent-xdomain-delayed-work-use-after-f.patch
queue-6.18/alsa-hda-realtek-add-quirk-for-hp-dragonfly-folio-g3.patch
queue-6.18/octeontx2-pf-set-correct-sequence-for-carrier-off-an.patch
queue-6.18/net-mpls-initialize-rtm_tos-in-mpls_getroute.patch
queue-6.18/userfaultfd-prevent-registration-of-special-vmas.patch
queue-6.18/netfilter-nf_conntrack_expect-restore-helper-propaga.patch
queue-6.18/bluetooth-iso-lock-sk-in-iso_connect_ind.patch
queue-6.18/bluetooth-btintel-validate-length-before-parsing-dia.patch
queue-6.18/net-ethernet-mtk_eth_soc-pass-eth-to-mtk_handle_irq_.patch
queue-6.18/riscv-drop-__init-from-vec_check_unaligned_access_sp.patch
queue-6.18/drivers-hv-vmbus-replace-lockdep_hardirq_threaded-wi.patch
queue-6.18/hid-logitech-dj-prevent-report_id_dj_short-related-u.patch
queue-6.18/net-do-not-send-icmp-ndisc-redirects-when-peer-alloc.patch
queue-6.18/xsk-drain-continuation-descs-after-overflow-in-xsk_b.patch
queue-6.18/kunit-tool-terminate-kernel-under-test-on-sigint.patch
queue-6.18/can-isotp-check-register_netdevice_notifier-error-in.patch
