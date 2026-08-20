Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D2EC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D2710E1DA;
	Thu, 20 Aug 2026 13:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDgSqVuA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAA310E1DA
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:14:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14DC460A5D;
 Thu, 20 Aug 2026 13:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942D11F000E9;
 Thu, 20 Aug 2026 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787231640;
 bh=PACkK0/AyBvI3bCvQONYadr3efloVprR7zIi187mMbg=;
 h=Subject:To:Cc:From:Date:In-Reply-To;
 b=xDgSqVuAMT5SoNw9WsCiE2kzB8vef6WumyneAucElEpBTQF+qQjVBkj2GkfwNxTwh
 XxaveUSdENhDcvnzf7nON1POYbSHcW27tYMcL2nqqDkL4nPg+QytSt04CeO4Qyrl2N
 UMGtTUMqUoY6BlAahb6uOFteDXfp0A2X0JQg+w+s=
Subject: Patch "drm/tegra: fbdev: Remove offset into framebuffer memory" has
 been added to the 6.1-stable tree
To: dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 sashal@kernel.org, treding@nvidia.com, tzimmermann@suse.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 15:10:07 +0200
In-Reply-To: <20260731162521.789037-1-sashal@kernel.org>
Message-ID: <2026082007-trouble-unscrew-aa17@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-294144-greg=kroah.com@vger.kernel.org Fri Jul 31 18:46:30 2026
From: Sasha Levin <sashal@kernel.org>
Date: Fri, 31 Jul 2026 12:25:21 -0400
Subject: drm/tegra: fbdev: Remove offset into framebuffer memory
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Sasha Levin <sashal@kernel.org>
Message-ID: <20260731162521.789037-1-sashal@kernel.org>

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
@@ -222,7 +222,6 @@ static int tegra_fbdev_probe(struct drm_
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -268,9 +267,6 @@ static int tegra_fbdev_probe(struct drm_
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -282,9 +278,9 @@ static int tegra_fbdev_probe(struct drm_
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

queue-6.1/udmabuf-do-not-create-malformed-scatterlists.patch
queue-6.1/treewide-rename-pinctrl_gpio_direction_input_new.patch
queue-6.1/dma-buf-udmabuf-skip-redundant-cpu-sync-to-fix-cacheline-eexist-warning.patch
queue-6.1/wifi-brcmfmac-set-f2-blocksize-to-256-for-bcm43752.patch
queue-6.1/usb-gadget-f_tcm-synchronize-delayed-set_alt-with-teardown.patch
queue-6.1/input-mms114-reject-an-oversized-device-packet-size.patch
queue-6.1/iommu-amd-don-t-split-flush-for-amd_iommu_domain_flush_all.patch
queue-6.1/dm-fix-trailing-statements.patch
queue-6.1/fbcon-rename-struct-fbcon_ops-to-struct-fbcon_par.patch
queue-6.1/usb-typec-ucsi-fix-race-condition-and-ordering-in-port-unregistration.patch
queue-6.1/fpga-dfl-afu-validate-dma-mapping-length-in-afu_dma_map_region.patch
queue-6.1/mm-mm_init-fix-uninitialized-struct-pages-for-zone_device.patch
queue-6.1/netfilter-nft_set_pipapo-move-cloning-of-match-info-to-insert-removal-path.patch
queue-6.1/vduse-remove-unused-vaddr-parameter-of-vduse_domain_free_coherent.patch
queue-6.1/netfilter-nf_tables-remove-unused-nft_reduce_is_readonly.patch
queue-6.1/bootconfig-fix-null-pointer-arithmetic-in-xbc_snprint_cmdline.patch
queue-6.1/alsa-hda-codecs-hdmi-disable-keep-alive-before-audio-format-change.patch
queue-6.1/octeontx2-annotate-mmio-regions-as-__iomem.patch
queue-6.1/siw-inline-do_tcp_sendpages.patch
queue-6.1/kvm-s390-pci-fix-resource-leak-on-irq-registration-f.patch
queue-6.1/net-mana-validate-the-packet-length-reported-by-the-nic.patch
queue-6.1/netfilter-nft_set_pipapo-move-prove_locking-helper-around.patch
queue-6.1/mlxsw-fix-refcount-leak-in-mlxsw_sp_port_lag_join.patch
queue-6.1/mptcp-pm-avoid-code-duplication-to-lookup-endp.patch
queue-6.1/s390-cpum_cf-merge-source-files-for-cpu-measurement-counter-facility.patch
queue-6.1/octeontx2-af-cn10k-restrict-vf-lmtline-sharing-to-its-own-pf.patch
queue-6.1/mm-move-most-of-core-mm-initialization-to-mm-mm_init.c.patch
queue-6.1/mptcp-pm-use-addr-entry-for-get_local_id.patch
queue-6.1/mmc-vub300-fix-use-after-free-on-probe-failure.patch
queue-6.1/ipvs-separate-destination-availability-state.patch
queue-6.1/libceph-add-doutc-and-_client-debug-macros-support.patch
queue-6.1/ata-libata-core-reject-an-invalid-concurrent-positioning-ranges-count.patch
queue-6.1/bootconfig-move-xbc_snprint_cmdline-to-lib-bootconfig.c.patch
queue-6.1/taskstats-retain-dead-thread-stats-in-tgid-queries.patch
queue-6.1/fs-ntfs3-undo-critial-modificatins-to-keep-directory-consistency.patch
queue-6.1/mm-vmemmap-devdax-fix-kernel-crash-when-probing-devdax-devices.patch
queue-6.1/usb-musb-omap2430-clean-up-probe-error-handling.patch
queue-6.1/dm-add-missing-empty-lines.patch
queue-6.1/net-ipa-fix-smem-state-handle-leaks-in-smp2p-init.patch
queue-6.1/vfio-pci-fix-racy-bitfields-and-tighten-struct-layout.patch
queue-6.1/octeontx2-pf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-6.1/ceph-pass-the-mdsc-to-several-helpers.patch
queue-6.1/fbcon-use-correct-type-for-vc_resize-return-value.patch
queue-6.1/netfilter-nf_conntrack_sip-remove-net-variable-shadowing.patch
queue-6.1/netfilter-nf_tables-pass-context-structure-to-nft_parse_register_load.patch
queue-6.1/remoteproc-qcom-pas-adjust-the-phys-addr-wrt-the-mem-region.patch
queue-6.1/wifi-ath6kl-fix-use-after-free-in-aggr_reset_state.patch
queue-6.1/asoc-mediatek-use-common-mtk_afe_pcm_platform-with-common-probe-cb.patch
queue-6.1/wifi-brcmfmac-fix-43752-sdio-fwvid-incorrectly-labelled-as-cypress-cyw.patch
queue-6.1/vduse-avoid-leaking-information-to-userspace.patch
queue-6.1/asoc-mediatek-mt8192-check-runtime-resume-during-probe.patch
queue-6.1/tipc-restrict-socket-queue-dumps-in-enqueue-tracepoints.patch
queue-6.1/ceph-avoid-fs-reclaim-while-using-current-journal_info.patch
queue-6.1/drm-i915-hdcp-move-to-using-intel_display-in-intel_hdcp.patch
queue-6.1/usb-typec-ucsi-split-connector-lock-classes.patch
queue-6.1/f2fs-fix-uaf-issue-in-f2fs_merge_page_bio.patch
queue-6.1/drm-i915-hdcp-require-monotonically-increasing-seq_num_v.patch
queue-6.1/pmdomain-imx-fix-i.mx8mp-power-notifier.patch
queue-6.1/mmc-vub300-fix-use-after-free-on-disconnect.patch
queue-6.1/mtd-maps-vmu-flash-fix-fault-in-unaligned-fixup.patch
queue-6.1/ceph-fix-hanging-__ceph_get_caps-with-stale-mds_wanted.patch
queue-6.1/remoteproc-qcom-fix-leak-when-custom-dump_segments-addition-fails.patch
queue-6.1/libceph-amend-checking-to-fix-make-w-1-build-breakage.patch
queue-6.1/dm-crypt-correct-foo-to-foo.patch
queue-6.1/libceph-bound-pg_-temp-upmap-upmap_items-length-to-ceph_pg_max_size.patch
queue-6.1/selinux-avoid-sk_socket-dereference-in-selinux_sctp_bind_connect.patch
queue-6.1/mptcp-pm-userspace-fix-use-after-free-in-get_local_id.patch
queue-6.1/drm-bridge-cdns-dsi-replace-deprecated-universal_dev_pm_ops.patch
queue-6.1/kvm-introduce-vcpu-wants_to_run.patch
queue-6.1/drm-i915-hdcp-check-streams-bounds-before-overflow.patch
queue-6.1/dm-remove-unnecessary-braces-from-single-statement-blocks.patch
queue-6.1/tcp_bpf-inline-do_tcp_sendpages-as-it-s-now-a-wrapper-around-tcp_sendmsg.patch
queue-6.1/bluetooth-remove-usage-of-the-deprecated-ida_simple_xx-api.patch
queue-6.1/vduse-take-out-allocations-from-vduse_dev_alloc_coherent.patch
queue-6.1/lsm-infrastructure-management-of-the-sock-security.patch
queue-6.1/remoteproc-qcom-replace-kstrdup-with-kstrndup.patch
queue-6.1/audit-use-unsigned-int-instead-of-unsigned.patch
queue-6.1/wifi-brcmfmac-drain-bus_reset-work-on-device-removal.patch
queue-6.1/i2c-davinci-unregister-cpufreq-notifier-on-probe-failure.patch
queue-6.1/bootconfig-do-not-put-quotes-on-cmdline-items-unless-necessary.patch
queue-6.1/mptcp-add-mptcp_userspace_pm_lookup_addr-helper.patch
queue-6.1/i2c-imx-separate-atomic-dma-and-non-dma-use-case.patch
queue-6.1/locking-rt-fix-the-incorrect-rcu-protection-in-rt_spin_unlock.patch
queue-6.1/drm-displayid-fix-tiled-display-topology-id-size.patch
queue-6.1/netfilter-nft_set_pipapo-merge-deactivate-helper-into-caller.patch
queue-6.1/dm-integrity-don-t-increment-hash_offset-twice.patch
queue-6.1/vfs-audit-introduce-kern_path_parent-for-audit.patch
queue-6.1/bpf-fork-wipe-bpf_storage-before-bailouts-that-access-it.patch
queue-6.1/audit-fix-recursive-locking-deadlock-in-audit_dupe_exe.patch
queue-6.1/asoc-fsl_sai-fix-spurious-bclk-on-resume-by-clearing-byp.patch
queue-6.1/drm-tegra-fbdev-remove-offset-into-framebuffer-memory.patch
queue-6.1/rxrpc-serialize-kernel-accept-preallocation-with-socket-teardown.patch
queue-6.1/mei-bus-access-mei_device-under-device_lock-on-cleanup.patch
queue-6.1/usb-musb-omap2430-do-not-put-borrowed-of_node-in-probe.patch
queue-6.1/block-stop-the-timeout-timer-when-releasing-a-never-.patch
queue-6.1/s390-cpum_cf-move-stccm_avail.patch
queue-6.1/9p-skip-nlink-update-in-cacheless-mode-to-fix-warn_on.patch
queue-6.1/netfilter-nf_tables-drop-unused-3rd-argument-from-validate-callback-ops.patch
queue-6.1/mmc-vub300-rename-probe-error-labels.patch
queue-6.1/kvm-x86-only-reset-tsc-deadline-timer-in-apic_timer_expired-on-kvm_run.patch
queue-6.1/usb-typec-ucsi-only-enable-supported-notifications.patch
queue-6.1/netfilter-nft_set_pipapo-use-gfp_kernel-for-insertions.patch
queue-6.1/tracing-rename-kvfree_rcu-to-kvfree_rcu_mightsleep.patch
queue-6.1/drm-i915-vrr-check-has_vrr-first-in-intel_vrr_is_capable.patch
queue-6.1/mm-do-file-ownership-checks-with-the-proper-mount-idmap.patch
queue-6.1/vduse-use-fixed-4kb-bounce-pages-for-non-4kb-page-size.patch
queue-6.1/alsa-hda-fix-cached-processing-coefficient-verbs.patch
queue-6.1/net-ip6_tunnel-require-cap_net_admin-in-the-device-netns-for-changelink.patch
queue-6.1/dm-verity-make-error-counter-atomic.patch
queue-6.1/alsa-hda-conexant-remove-mic-bias-threshold-override.patch
queue-6.1/media-i2c-imx219-correct-the-minimum-vblanking-value.patch
queue-6.1/kvm-s390-pci-fix-memory-accounting-for-pinned-unpinn.patch
queue-6.1/net-sched-sch_taprio-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
queue-6.1/i2c-imx-fix-locked-bus-on-smbus-block-read-of-0-atomic.patch
queue-6.1/wifi-libertas_tf-fix-use-after-free-in-lbtf_free_adapter.patch
queue-6.1/netfilter-nft_set_pipapo-don-t-leak-bad-clone-into-future-transaction.patch
queue-6.1/input-mms114-fix-touch-indexing-for-mms134s-and-mms136.patch
queue-6.1/mlxsw-spectrum-on-port-enslavement-to-a-lag-join-upper-s-bridges.patch
queue-6.1/firmware_loader-introduce-__free-cleanup-hanler.patch
queue-6.1/netfilter-nf_conntrack_sip-validate-skb_dst-before-accessing-it.patch
queue-6.1/espintcp-inline-do_tcp_sendpages.patch
queue-6.1/s390-perf_cpum_cf-add-missing-array_index_nospec-to-__hw_perf_event_init.patch
queue-6.1/asoc-mediatek-mt8183-check-runtime-resume-during-probe.patch
queue-6.1/dm-verity-avoid-double-increment-of-use_bh_wq_enabled.patch
queue-6.1/ceph-rename-_to_client-to-_to_fs_client.patch
queue-6.1/octeontx2-vf-clear-stale-mailbox-irq-state-before-request_irq.patch
queue-6.1/net-thunderbolt-fix-frags-overflow-by-bounding-frame_count.patch
queue-6.1/netfilter-nft_set_pipapo-make-pipapo_clone-helper-return-null.patch
queue-6.1/ntfs3-validate-split-point-offset-in-indx_insert_into_buffer.patch
queue-6.1/espintcp-use-sk_msg_free_partial-to-fix-partial-send.patch
queue-6.1/netfilter-bitwise-rename-some-boolean-operation-functions.patch
queue-6.1/fscrypt-use-the-mount-idmap-for-the-owner-check-in-f.patch
queue-6.1/input-ims-pcu-fix-firmware-leak-in-async-update.patch
queue-6.1/kernel-user-allow-user_struct-locked_vm-to-be-usable.patch
queue-6.1/media-i2c-imx219-drop-imx219_vts_-macros.patch
queue-6.1/s390-cpum_cf-move-cpum_cf_ctrset_size.patch
queue-6.1/net-sched-taprio-avoid-calling-child-ops-dequeue-child-twice.patch
queue-6.1/octeontx2-pf-fix-sqb-pointer-leak-on-init-failure.patch
queue-6.1/ipmi-fix-refcount-leak-in-i_ipmi_request.patch
queue-6.1/kvm-s390-pci-fix-missing-error-codes-and-memory-unac.patch
queue-6.1/tracing-osnoise-call-synchronize_rcu-when-unregistering.patch
queue-6.1/media-i2c-imx219-rename-vts-to-frm_length.patch
queue-6.1/remoteproc-qcom-fix-sparse-warnings.patch
queue-6.1/gpio-tegra-do-not-call-pinctrl-for-gpio-direction.patch
queue-6.1/libceph-fix-two-unsafe-bare-decodes-in-decode_lockers.patch
queue-6.1/netfilter-nft_objref-validate-objref-and-objrefmap-expressions.patch
queue-6.1/net-sched-act_ct-preserve-tc_skb_cb-across-defragmentation.patch
queue-6.1/media-imx219-fix-maximum-frame-length-in-lines.patch
queue-6.1/serial-max310x-replace-bare-use-of-unsigned-with-unsigned-int-checkpatch.patch
queue-6.1/drm-i915-vrr-require-valid-min-max-vfreq-for-vrr.patch
queue-6.1/audit-widen-ino-fields-to-u64.patch
queue-6.1/net-macb-drop-in-flight-tx-skbs-on-close.patch
queue-6.1/drm-amdgpu-respect-placement-requirements-in-amdgpu_gtt_mgr-functions.patch
queue-6.1/asoc-mediatek-mt8192-afe-pcm-simplify-probe-with-local-dev-variable.patch
queue-6.1/bpf-reject-bpf_map_type_inode_storage-creation-if-bpf-lsm-is-uninitialized.patch
queue-6.1/ovl-use-linked-upper-dentry-in-copy-up-tmpfile.patch
queue-6.1/bluetooth-hci-remove-hci_amp-support.patch
queue-6.1/netfilter-nft_set_pipapo-prepare-pipapo_get-helper-for-on-demand-clone.patch
queue-6.1/tcp_bpf-smc-tls-espintcp-siw-reduce-msg_sendpage_notlast-usage.patch
queue-6.1/netfilter-nft_set_pipapo-prepare-walk-function-for-on-demand-clone.patch
queue-6.1/taskstats-fill_stats_for_tgid-use-for_each_thread.patch
queue-6.1/thunderbolt-prevent-xdomain-delayed-work-use-after-free-on-disconnect.patch
queue-6.1/asoc-mediatek-mt8192-afe-pcm-simplify-with-dev_err_probe.patch
queue-6.1/asoc-mediatek-mt8192-afe-pcm-convert-to-devm_pm_runtime_enable.patch
queue-6.1/fs-resctrl-fix-double-add-of-pseudo-locked-region-s-rmid-to-free-list.patch
queue-6.1/s390-cpum_cf-remove-in-kernel-counting-facility-interface.patch
queue-6.1/asoc-sof-ipc3-control-fix-heap-overflow-in-bytes_ext-put-get.patch
queue-6.1/kvm-s390-pci-fix-aisb-calculation.patch
queue-6.1/serial-max310x-implement-gpio_chip-get_direction.patch
queue-6.1/sctp-avoid-auth_enable-sysctl-uaf-during-netns-teardown.patch
queue-6.1/gpio-mt7621-avoid-corruption-of-shared-interrupt-trigger-state.patch
