Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE75EC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165FE10E415;
	Fri,  7 Aug 2026 13:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ippVWlRA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8CAF10E415
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 616306013A;
 Fri,  7 Aug 2026 13:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D24F1F01558;
 Fri,  7 Aug 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786110634;
 bh=6Pngd1+tyHYJXvoH3LT/mzc5dyVaNfgGY4fbk9hQIUM=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=ippVWlRAdQvozLpxITTWipyQFjGzOe1bTXgN+xr2XI1PTGIZy97x69nSOJ/DXJIiN
 AT/Ej6TChw7re43LeIrJcrOdvPYDOWfxhu/bqQ5Drzig0VMyMJyh/S1hpAwL9AoWJm
 y5zhEVXKG2GExUhwe0YGhLig2eog+2+BOi0iFjb0=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 6.6-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Aug 2026 15:49:51 +0200
In-Reply-To: <20260731155020.604703-2-sashal@kernel.org>
Message-ID: <2026080751-tweezers-musky-515d@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-294127-greg=kroah.com@vger.kernel.org Fri Jul 31 18:00:34 2026
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 31 Jul 2026 11:50:20 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731155020.604703-2-sashal@kernel.org>

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

queue-6.6/sysctl-treewide-constify-ctl_table_header-ctl_table_arg.patch
queue-6.6/wifi-brcmfmac-set-f2-blocksize-to-256-for-bcm43752.patch
queue-6.6/usb-gadget-f_tcm-synchronize-delayed-set_alt-with-teardown.patch
queue-6.6/net-sxgbe-free-tx-rings-on-rx-allocation-failure.patch
queue-6.6/usb-typec-ucsi-fix-race-condition-and-ordering-in-port-unregistration.patch
queue-6.6/drm-fb-helper-allocate-and-release-fb_info-in-single-place.patch
queue-6.6/pinctrl-qcom-sc8280xp-add-missing-wakeup-entries-for.patch
queue-6.6/forcedeth-fix-uaf-of-txrx_stats-in-nv_remove.patch
queue-6.6/hid-logitech-dj-standardise-hid_report_enum-variable.patch
queue-6.6/scsi-libsas-fix-ha-resume-deadlock-and-hisi_sas-disk.patch
queue-6.6/netfilter-nft_payload-fix-mask-build-for-partial-fie.patch
queue-6.6/bluetooth-iso-fix-timeout-vs-sync_timeout-typo-in-ch.patch
queue-6.6/net-sxgbe-check-descriptor-ring-allocation-failures.patch
queue-6.6/ipvs-fix-the-checksum-validations.patch
queue-6.6/mptcp-pm-avoid-code-duplication-to-lookup-endp.patch
queue-6.6/spi-spi-cadence-move-tx-fifo-full-busy-wait-into-fif.patch
queue-6.6/powerpc-boot-fix-simpleboot-cpu-node-lookup-check.patch
queue-6.6/ata-sata_mv-accept-1-or-2-resources-in-platform-prob.patch
queue-6.6/wifi-mac80211-validate-individual-twt-params-before-.patch
queue-6.6/mm-hugetlb-fix-swap-entry-corruption-when-clearing-u.patch
queue-6.6/dmaengine-idxd-fix-fdev-setup-failure-cleanup-in-idx.patch
queue-6.6/asoc-max98090-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.6/mptcp-pm-use-addr-entry-for-get_local_id.patch
queue-6.6/sched-add-task_struct-faults_disabled_mapping.patch
queue-6.6/libceph-add-doutc-and-_client-debug-macros-support.patch
queue-6.6/gve-fix-rx-queue-stall-on-alloc-failure.patch
queue-6.6/bluetooth-hci_sync-remove-unnecessary-hci_conn_get-i.patch
queue-6.6/drm-mediatek-check-crtc-state-before-freeing.patch
queue-6.6/usb-musb-omap2430-clean-up-probe-error-handling.patch
queue-6.6/bluetooth-iso-clear-iso_data-always-when-detaching-c.patch
queue-6.6/accel-qaic-use-sizeof-trans_hdr-for-transaction-leng.patch
queue-6.6/pinctrl-amd-don-t-clear-s4-wake-bits-at-probe.patch
queue-6.6/net-bridge-mrp-fix-option-tlv-length-in-mrp_test-fra.patch
queue-6.6/gpio-pch-use-raw_spinlock_t-for-the-register-lock.patch
queue-6.6/powerpc-boot-fix-treeboot-currituck-cpu-node-lookup-.patch
queue-6.6/wifi-ath6kl-fix-use-after-free-in-aggr_reset_state.patch
queue-6.6/wifi-brcmfmac-fix-43752-sdio-fwvid-incorrectly-labelled-as-cypress-cyw.patch
queue-6.6/keys-make-keyring-key-chunk-byte-order-agree-with-ke.patch
queue-6.6/hwmon-adt7470-fix-fans-stuck-in-manual-mode-on-i2c-e.patch
queue-6.6/ata-ahci_ceva-fix-error-paths-in-ceva_ahci_platform_.patch
queue-6.6/qede-sync-udp_tunnel-ports-outside-qede_lock-in-the-.patch
queue-6.6/tracing-mmiotrace-reset-dropped_count-in-mmio_reset_.patch
queue-6.6/netfilter-nf_conntrack_sip-widen-nat-rewrite-delta-t.patch
queue-6.6/usb-typec-ucsi-split-connector-lock-classes.patch
queue-6.6/ahci-introduce-ahci_ignore_port-helper.patch
queue-6.6/mm-huge_memory-unlock-i_mmap_rwsem-before-releasing-.patch
queue-6.6/bluetooth-l2cap-fix-uaf-in-l2cap_le_connect_rsp.patch
queue-6.6/scsi-zfcp-fix-memory-leak-during-adapter-release-by-.patch
queue-6.6/mptcp-pm-userspace-fix-use-after-free-in-get_local_id.patch
queue-6.6/net-dsa-mt7530-error-out-on-failed-reads-in-mt7531-p.patch
queue-6.6/scsi-libiscsi_tcp-bound-scsi-response-data-segment-t.patch
queue-6.6/bluetooth-hci_conn-hold-conn-reference-in-abort_conn.patch
queue-6.6/ipvs-do-not-mangle-icmp-replies-for-non-first-fragme.patch
queue-6.6/phy-zynqmp-fix-clock-error-handling-in-xpsgtr_phy_in.patch
queue-6.6/asoc-max98095-fix-missing-is_err-before-ptr_err-on-m.patch
queue-6.6/hid-logitech-dj-fix-wrong-detection-of-bad-dj_short-.patch
queue-6.6/rds-tcp-hold-the-rcu-lock-across-ipv6_chk_addr-in-rd.patch
queue-6.6/hwmon-lm90-only-report-alarms-if-driver-is-ready.patch
queue-6.6/ceph-print-cluster-fsid-and-client-global_id-in-all-debug-logs.patch
queue-6.6/media-v4l2-fwnode-fix-subdev-owner-overwritten-in-v4l2_async_register_subdev_sensor.patch
queue-6.6/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-6.6/hwmon-adt7470-fix-divide-by-zero-toctou-crash-in-fan.patch
queue-6.6/mptcp-add-mptcp_userspace_pm_lookup_addr-helper.patch
queue-6.6/hwmon-adt7470-fix-temperature-alarm-logic-in-hwmon_t.patch
queue-6.6/ksmbd-return-success-for-deferred-final-close.patch
queue-6.6/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-6.6/drm-renesas-move-rz-g2l-mipi-dsi-driver-to-rz-du.patch
queue-6.6/scsi-ufs-core-cancel-rtc-work-in-active-active-suspe.patch
queue-6.6/hwmon-adt7470-fix-cache-updated-before-hardware-writ.patch
queue-6.6/assoc_array-trim-the-final-shortcut-word-using-the-c.patch
queue-6.6/usb-musb-omap2430-do-not-put-borrowed-of_node-in-probe.patch
queue-6.6/ksmbd-fix-use-after-free-in-__close_file_table_ids.patch
queue-6.6/netfilter-xt_hashlimit-validate-hashtable-supports-x.patch
queue-6.6/scsi-target-iblock-fix-wrong-pr-ops-null-check-for-p.patch
queue-6.6/hwmon-adt7470-fix-swapped-pwm3-and-pwm4-auto-mode-ma.patch
queue-6.6/media-i2c-imx219-access-height-from-active-format-in-imx219_set_ctrl.patch
queue-6.6/usb-typec-ucsi-only-enable-supported-notifications.patch
queue-6.6/drm-i915-vrr-check-has_vrr-first-in-intel_vrr_is_capable.patch
queue-6.6/ipv6-fib6-fix-null-deref-in-fib6_walk_continue-on-mu.patch
queue-6.6/netfilter-br_netfilter-reallocate-headroom-if-necess.patch
queue-6.6/keys-fix-out-of-bounds-read-in-keyring_get_key_chunk.patch
queue-6.6/hwmon-adt7470-use-cached-pwm-frequency-value.patch
queue-6.6/hwmon-pmbus-fix-return-value-from-pmbus_update_byte_.patch
queue-6.6/phy-zynqmp-fix-runtime-pm-leak-on-probe-allocation-f.patch
queue-6.6/scsi-libiscsi-fix-stale-data-leak-into-the-scsi-sens.patch
queue-6.6/soc-qcom-ice-allow-explicit-votes-on-iface-clock-for.patch
queue-6.6/spi-spi-cadence-supports-transmission-with-bits_per_.patch
queue-6.6/sctp-close-udp-tunnel-sockets-during-netns-teardown.patch
queue-6.6/ipvs-fix-places-with-wrong-packet-offsets.patch
queue-6.6/drm-renesas-rzg2l_mipi_dsi-increase-reset-deassertion-delay.patch
queue-6.6/hwmon-adt7470-fix-pwm-auto-temp-state-array-and-boun.patch
queue-6.6/bluetooth-hci_sync-make-hci_cmd_sync_run_once-return.patch
queue-6.6/hwmon-adt7470-fix-busy-loop-and-i2c-flooding-in-upda.patch
queue-6.6/rxrpc-fix-irq-disabled-in-local_bh_enable.patch
queue-6.6/hwmon-nct6775-core-fix-number-of-temperature-registe.patch
queue-6.6/hwmon-nct6775-core-prevent-access-to-unsupported-wei.patch
queue-6.6/dmaengine-sun6i-dma-fix-reclaim-descriptors-while-te.patch
queue-6.6/media-i2c-imx219-drop-imx219_vts_-macros.patch
queue-6.6/rds-fix-inet6_addr_lst-null-dereference-when-ipv6-is.patch
queue-6.6/media-i2c-imx219-rename-vts-to-frm_length.patch
queue-6.6/smb-client-fix-buffer-leaks-in-smb1-read-and-write.patch
queue-6.6/scsi-target-clear-cmd_cnt-when-initial-counter-enrol.patch
queue-6.6/bluetooth-hci_sync-fix-hci_conn_del-use-in-hci_le_cr.patch
queue-6.6/net-phylink-put-link_gpio-if-phylink_create-fails.patch
queue-6.6/btrfs-zoned-fix-deadlock-between-metadata-writeback-.patch
queue-6.6/media-imx219-fix-maximum-frame-length-in-lines.patch
queue-6.6/media-i2c-imx219-group-functions-by-purpose.patch
queue-6.6/drm-i915-vrr-require-valid-min-max-vfreq-for-vrr.patch
queue-6.6/media-i2c-imx219-don-t-store-the-current-mode-in-the-imx219-structure.patch
queue-6.6/hwmon-nzxt-smart2-dma-align-output-buffer.patch
queue-6.6/rhashtable-clear-stale-iter-p-on-table-restart.patch
queue-6.6/drm-amdgpu-respect-placement-requirements-in-amdgpu_gtt_mgr-functions.patch
queue-6.6/powerpc-boot-fix-treeboot-akebono-cpu-node-lookup-ch.patch
queue-6.6/media-v4l-async-set-owner-for-async-sub-devices.patch
queue-6.6/thunderbolt-prevent-xdomain-delayed-work-use-after-f.patch
queue-6.6/netfilter-nf_tables-clone-set-on-flush-only.patch
queue-6.6/ata-libahci_platform-support-non-consecutive-port-nu.patch
queue-6.6/octeontx2-pf-set-correct-sequence-for-carrier-off-an.patch
queue-6.6/net-mpls-initialize-rtm_tos-in-mpls_getroute.patch
queue-6.6/ceph-fix-refcount-leak-in-ceph_readdir.patch
queue-6.6/netfilter-nf_conntrack_expect-restore-helper-propaga.patch
queue-6.6/bluetooth-btintel-validate-length-before-parsing-dia.patch
queue-6.6/firmware-stratix10-svc-fix-memory-leaks-and-list-cor.patch
queue-6.6/hid-logitech-dj-prevent-report_id_dj_short-related-u.patch
queue-6.6/sctp-avoid-auth_enable-sysctl-uaf-during-netns-teardown.patch
queue-6.6/iommu-sva-move-x86-disable-check-before-allocation.patch
queue-6.6/media-i2c-imx219-calculate-crop-rectangle-dynamically.patch
queue-6.6/net-do-not-send-icmp-ndisc-redirects-when-peer-alloc.patch
queue-6.6/phy-zynqmp-postpone-getting-clock-rate-until-actuall.patch
queue-6.6/can-isotp-check-register_netdevice_notifier-error-in.patch
