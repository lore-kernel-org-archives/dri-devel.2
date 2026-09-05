Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9645DC624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 06:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5A10E5A6;
	Sat,  5 Sep 2026 06:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eo9RXTHj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7997010E5A6
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 06:13:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 598FE60209;
 Sat,  5 Sep 2026 06:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EAF1F00A3D;
 Sat,  5 Sep 2026 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788588807;
 bh=QrxI7mqAy55p6XQPqdWZBFEz5nGe3PIJJErn0xZ3rqU=;
 h=Date:From:To:Cc:Subject;
 b=Eo9RXTHjiF1zmiF2AfHHVJDrRi8j0L7mdhXcKGNgwWEHenF1nafDZe/9k0yjMEpg9
 0xjJZgUGJsu+XNkw1ql430TygypYwCNho0PElvlOePig0GBkpxhzs/OmALHr2Os1tB
 90vSDE2gpfXRrSx5Y1Voed09nLlmenJvzV72oWKi7IXBbVDCPLedJee1Fgo/krNTGD
 dB+Jj8TFQF2VhpL8ebUJJpgehsEOoceytZVQA6rU9+BYGt5maUcgNJ8c7C4xQcDQvY
 GYouyyX4O946x3UjqQkhbKIg5uBov0XsJKoyKFXN6TFNRm1NrPSZ7uVkm+xzWS7h54
 L1RBucaPf6HBg==
Date: Fri, 4 Sep 2026 23:13:26 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Kees Cook <kees+treewide@kernel.org>,
 Manuel Ebner <manuelebnerli@mailbox.org>
Subject: [GIT PULL] kmalloc_obj() conversions for v7.3-rc2
Message-ID: <202609042302.CE61BD262@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Linus,

Please pull these kmalloc_obj() conversions for v7.3-rc2.

If this is too late in the cycle, no worries, I'll wait and do it in the
second week of the v7.4 merge window for its -rc1. I only discovered
earlier this week that Coccinelle had missed a bunch in the v7.0
tree-wide conversions due to its (silent) failure to parse functions
using scope_guard() and family[1]. Since -rc2 hadn't cut yet, I thought
if you wanted these now, I could get them to you.

Anyway, here's the commit log repeated:

This is another run of the Coccinelle script for converting kmalloc()
family of allocations to kmalloc_obj() via the existing rules in
scripts/coccinelle/api/kmalloc_objs.cocci

This catches both the set of kmalloc() uses added since the first
kmalloc_obj() conversions in v7.0 and adds a large group missed in the
first pass due to Coccinelle not interacting well with the cleanup.h
scoped_...() family of macros[1]. I worked around this with spatch's
"--macro-file" argument to a file with all the scoped_...() macros mapped
to Coccinelle's YACFE_ITERATOR[2] as that was the closest viable control
flow indicator I could find.

Build tested allmodconfig on x86, arm64, arm, loongarch, mips, powerpc,
riscv, and s390 with no new warnings.

Link: https://lore.kernel.org/lkml/202609021314.8A9C0B8@keescook/ [1]
Link: https://github.com/coccinelle/coccinelle/blob/master/standard.h [2]

Thanks!

-Kees

The following changes since commit 986c24e0fe44f844b44d365b71ce831947f50298:

  Merge tag 'hid-for-linus-2026090401' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2026-09-04 09:25:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kmalloc_obj-v7.3-rc2

for you to fetch changes up to 3a2c4d55e32ad65efebdb6de44eef3bfa08bb49d:

  treewide: refresh kmalloc_obj() conversions (2026-09-04 21:37:00 -0700)

----------------------------------------------------------------
kmalloc_obj conversions for v7.3-rc2

- Run scripts/coccinelle/api/kmalloc_objs.cocci for v7.3

----------------------------------------------------------------
Kees Cook (2):
      drm/amd/display: Fix harmless type mismatch in allocation
      treewide: refresh kmalloc_obj() conversions

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 mm/damon/tests/vaddr-kunit.h                       |  2 +-
 drivers/media/platform/renesas/rcar-isp/core.c     |  2 +-
 drivers/net/ethernet/amd/pds_core/core.c           |  3 +-
 drivers/nvme/host/core.c                           |  3 +-
 drivers/opp/core.c                                 |  4 +-
 drivers/pmdomain/core.c                            |  2 +-
 drivers/power/sequencing/core.c                    |  2 +-
 kernel/events/core.c                               |  5 +--
 kernel/futex/core.c                                |  6 +--
 net/wireless/core.c                                |  5 +--
 arch/arm64/crypto/aes-neonbs-glue.c                |  4 +-
 arch/arm64/kvm/nested.c                            |  2 +-
 arch/loongarch/kvm/intc/dmsintc.c                  |  2 +-
 arch/mips/bcm47xx/buttons.c                        |  8 ++--
 arch/powerpc/sysdev/xive/common.c                  |  2 +-
 arch/riscv/kvm/vcpu_pmu.c                          |  4 +-
 arch/s390/kvm/s390/s390.c                          |  4 +-
 drivers/accel/rocket/rocket_job.c                  |  2 +-
 drivers/acpi/irq.c                                 |  8 ++--
 drivers/base/property.c                            |  2 +-
 drivers/block/drbd/drbd_nl_gen.c                   | 40 +++++++++--------
 drivers/block/ublk_drv.c                           |  4 +-
 drivers/block/zram/backend_lz4.c                   |  2 +-
 drivers/clk/ti/composite.c                         |  2 +-
 drivers/clk/ti/mux.c                               |  2 +-
 drivers/cpufreq/amd-pstate.c                       |  2 +-
 drivers/crypto/inside-secure/eip93/eip93-common.c  |  5 +--
 .../crypto/intel/qat/qat_common/qat_comp_algs.c    |  3 +-
 drivers/crypto/ti/dthev2-aes.c                     |  8 ++--
 drivers/devfreq/hisi_uncore_freq.c                 |  2 +-
 drivers/dma-buf/st-dma-fence.c                     |  2 +-
 drivers/dma-buf/udmabuf.c                          |  4 +-
 drivers/dma/switchtec_dma.c                        |  7 ++-
 drivers/edac/versalnet_edac.c                      |  2 +-
 drivers/firmware/arm_scmi/driver.c                 |  2 +-
 drivers/firmware/qcom/qcom_tzmem.c                 |  8 ++--
 drivers/firmware/ti_sci.c                          |  2 +-
 drivers/fpga/dfl-afu-dma-region.c                  |  2 +-
 drivers/gpio/gpio-aggregator.c                     |  4 +-
 drivers/gpio/gpio-mpsse.c                          |  2 +-
 drivers/gpio/gpio-sim.c                            |  3 +-
 drivers/gpio/gpio-virtuser.c                       |  3 +-
 drivers/gpio/gpiolib-cdev.c                        |  2 +-
 drivers/gpio/gpiolib.c                             |  4 +-
 drivers/gpu/buddy.c                                | 13 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 12 ++---
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  |  8 ++--
 .../display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 18 ++++----
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c |  4 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |  2 +-
 .../amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c   |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |  2 +-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |  2 +-
 .../gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c |  2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |  2 +-
 .../amd/display/dc/irq/dcn42/irq_service_dcn42.c   |  2 +-
 .../amd/display/dc/irq/dcn60/irq_service_dcn60.c   |  3 +-
 .../drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c    |  2 +-
 .../amd/display/dc/resource/dcn30/dcn30_resource.c |  4 +-
 .../display/dc/resource/dcn302/dcn302_resource.c   |  4 +-
 .../display/dc/resource/dcn303/dcn303_resource.c   |  4 +-
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |  4 +-
 .../display/dc/resource/dcn314/dcn314_resource.c   |  4 +-
 .../display/dc/resource/dcn315/dcn315_resource.c   |  4 +-
 .../display/dc/resource/dcn316/dcn316_resource.c   |  4 +-
 .../amd/display/dc/resource/dcn32/dcn32_resource.c |  4 +-
 .../display/dc/resource/dcn321/dcn321_resource.c   |  4 +-
 .../amd/display/dc/resource/dcn35/dcn35_resource.c |  4 +-
 .../display/dc/resource/dcn351/dcn351_resource.c   |  4 +-
 .../amd/display/dc/resource/dcn36/dcn36_resource.c |  4 +-
 .../display/dc/resource/dcn401/dcn401_resource.c   |  4 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c | 50 ++++++++++-----------
 .../display/dc/resource/dcn42b/dcn42b_resource.c   | 46 +++++++++----------
 .../amd/display/dc/resource/dcn60/dcn60_resource.c | 42 +++++++++--------
 drivers/gpu/drm/amd/display/modules/power/power.c  |  5 +--
 .../gpu/drm/amd/display/modules/power/power_abm.c  |  3 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c   |  4 +-
 drivers/gpu/drm/amd/ras/core/cmd.c                 |  4 +-
 drivers/gpu/drm/drm_exec.c                         |  2 +-
 drivers/gpu/drm/drm_syncobj.c                      |  2 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c       |  2 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             |  4 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |  4 +-
 drivers/gpu/drm/vkms/vkms_configfs.c               |  8 ++--
 drivers/gpu/drm/xe/xe_amc.c                        |  2 +-
 drivers/gpu/drm/xe/xe_vm.c                         |  2 +-
 drivers/hid/hid-asus.c                             |  6 +--
 drivers/hid/hid-steam.c                            |  4 +-
 drivers/hid/hid-steelseries-arctis.c               |  2 +-
 drivers/hv/channel.c                               |  5 +--
 drivers/hv/hv_balloon.c                            |  2 +-
 drivers/hwmon/applesmc.c                           | 17 ++++---
 drivers/hwtracing/coresight/coresight-core.c       |  2 +-
 drivers/i2c/busses/i2c-gpio.c                      |  2 +-
 drivers/i3c/master/amd-i3c-master.c                |  4 +-
 drivers/iio/adc/ad7280a.c                          |  4 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
 drivers/iio/inkern.c                               |  2 +-
 drivers/infiniband/core/nldev.c                    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c       |  3 +-
 drivers/input/input.c                              |  2 +-
 drivers/input/keyboard/adp5585-keys.c              |  4 +-
 drivers/input/keyboard/atkbd.c                     |  2 +-
 drivers/input/misc/ims-pcu.c                       |  2 +-
 drivers/input/mouse/psmouse-smbus.c                |  2 +-
 drivers/input/serio/serio_raw.c                    |  2 +-
 drivers/iommu/iommufd/device.c                     |  2 +-
 drivers/iommu/iommufd/driver.c                     |  2 +-
 drivers/iommu/iommufd/hwpt_noiommu.c               |  2 +-
 drivers/iommu/vsi-iommu.c                          |  2 +-
 drivers/irqchip/irq-gic-v5-irs.c                   |  2 +-
 drivers/irqchip/irq-loongarch-ir.c                 |  2 +-
 drivers/irqchip/irq-realtek-rtl.c                  |  2 +-
 drivers/mailbox/riscv-sbi-mpxy-mbox.c              |  2 +-
 drivers/md/dm-inlinecrypt.c                        |  2 +-
 drivers/md/md-llbitmap.c                           |  4 +-
 drivers/media/platform/allegro-dvt/allegro-core.c  |  2 +-
 drivers/media/platform/amd/isp4/isp4_interface.c   |  6 +--
 drivers/media/rc/igorplugusb.c                     |  2 +-
 drivers/mfd/mfd-core.c                             |  4 +-
 drivers/mfd/ucb1x00-assabet.c                      |  2 +-
 drivers/mtd/mtd_virt_concat.c                      |  4 +-
 drivers/mtd/mtdconcat.c                            |  2 +-
 drivers/net/dsa/mv88e6xxx/tcflower.c               |  2 +-
 drivers/net/ethernet/alibaba/eea/eea_adminq.c      |  7 ++-
 drivers/net/ethernet/alibaba/eea/eea_net.c         |  8 ++--
 drivers/net/ethernet/alibaba/eea/eea_pci.c         |  2 +-
 drivers/net/ethernet/alibaba/eea/eea_ring.c        |  2 +-
 drivers/net/ethernet/alibaba/eea/eea_rx.c          |  5 +--
 drivers/net/ethernet/alibaba/eea/eea_tx.c          |  3 +-
 drivers/net/ethernet/amd/pds_core/fw.c             |  6 +--
 drivers/net/ethernet/cadence/macb_main.c           |  2 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c       |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  6 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  5 +--
 drivers/net/ethernet/intel/libie/controlq.c        |  3 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  | 13 +++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |  2 +-
 .../mellanox/mlx5/core/steering/sws/dr_icm_pool.c  |  2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        |  2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  8 ++--
 drivers/net/ntb_netdev.c                           |  3 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |  2 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |  3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   |  2 +-
 drivers/net/wireless/morsemicro/mm81x/mac.c        |  9 ++--
 drivers/net/wireless/morsemicro/mm81x/yaps.c       | 10 ++---
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c        | 14 +++---
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c          |  2 +-
 drivers/net/wireless/nxp/nxpwifi/ie.c              | 14 +++---
 drivers/net/wireless/nxp/nxpwifi/init.c            |  2 +-
 drivers/net/wireless/nxp/nxpwifi/main.c            |  8 ++--
 drivers/net/wireless/nxp/nxpwifi/scan.c            | 13 +++---
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c         |  2 +-
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c         |  2 +-
 drivers/net/wireless/nxp/nxpwifi/uap_event.c       |  2 +-
 drivers/nvdimm/region_devs.c                       |  3 +-
 drivers/nvme/host/pci.c                            |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c                  |  4 +-
 drivers/platform/x86/amd/hsmp/acpi.c               |  5 +--
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c   |  4 +-
 drivers/platform/x86/intel/pmc/pwrm_telemetry.c    |  3 +-
 drivers/power/reset/reboot-mode.c                  |  6 +--
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  2 +-
 drivers/power/supply/power_supply_core.c           |  6 +--
 drivers/ptp/ptp_chardev.c                          |  2 +-
 drivers/s390/block/dasd.c                          |  2 +-
 drivers/scsi/fnic/fnic_debugfs.c                   |  2 +-
 drivers/scsi/leapraid/leapraid_func.c              | 52 +++++++++-------------
 drivers/scsi/scsi_scan.c                           |  2 +-
 drivers/soc/bcm/brcmstb/common.c                   |  2 +-
 drivers/spi/spi-offload.c                          |  2 +-
 drivers/staging/greybus/raw.c                      |  2 +-
 drivers/staging/media/atomisp/pci/sh_css.c         | 30 +++++--------
 .../staging/media/atomisp/pci/sh_css_firmware.c    |  4 +-
 drivers/tee/qcomtee/user_obj.c                     |  3 +-
 drivers/thunderbolt/stream.c                       | 12 +++--
 drivers/tty/moxa.c                                 |  3 +-
 drivers/tty/vt/consolemap.c                        |  3 +-
 drivers/ufs/core/ufs-txeq.c                        |  2 +-
 drivers/ufs/host/ufs-qcom.c                        |  2 +-
 drivers/usb/gadget/function/f_ncm.c                |  2 +-
 drivers/usb/usbip/usbip_common.c                   |  2 +-
 drivers/xen/grant-table.c                          |  2 +-
 fs/9p/vfs_dentry.c                                 |  3 +-
 fs/afs/dir.c                                       |  2 +-
 fs/afs/symlink.c                                   |  3 +-
 fs/binfmt_misc.c                                   |  7 ++-
 fs/ceph/addr.c                                     |  2 +-
 fs/ceph/mds_client.c                               |  2 +-
 fs/ceph/subvolume_metrics.c                        |  2 +-
 fs/coredump.c                                      |  2 +-
 fs/ext4/fast_commit.c                              |  4 +-
 fs/fuse/file.c                                     |  3 +-
 fs/fuse/readdir.c                                  |  2 +-
 fs/hfs/bnode.c                                     |  2 +-
 fs/namespace.c                                     |  2 +-
 fs/nfsd/export.c                                   |  7 ++-
 fs/nfsd/nfs4callback.c                             |  4 +-
 fs/nfsd/nfs4state.c                                |  7 +--
 fs/nfsd/nfsctl.c                                   |  2 +-
 fs/ntfs/bitmap.c                                   |  2 +-
 fs/ntfs/compress.c                                 |  8 ++--
 fs/ntfs/dir.c                                      | 16 +++----
 fs/ntfs/ea.c                                       |  2 +-
 fs/ntfs/index.c                                    |  2 +-
 fs/ntfs/logfile.c                                  |  2 +-
 fs/ntfs/mft.c                                      | 10 +++--
 fs/ntfs/runlist.c                                  | 14 +++---
 fs/ntfs/super.c                                    |  2 +-
 fs/overlayfs/readdir.c                             |  2 +-
 fs/smb/client/cifs_swn.c                           |  2 +-
 fs/smb/client/dfs_cache.c                          |  2 +-
 fs/smb/client/smb2inode.c                          |  2 +-
 fs/smb/server/ksmbd_work.c                         |  2 +-
 fs/smb/server/smb2pdu.c                            |  2 +-
 fs/xfs/libxfs/xfs_da_btree.c                       |  4 +-
 init/initramfs_test.c                              |  2 +-
 io_uring/napi.c                                    |  2 +-
 io_uring/zcrx.c                                    |  4 +-
 kernel/bpf/diagnostics.c                           |  2 +-
 kernel/bpf/hashtab.c                               |  2 +-
 kernel/bpf/liveness.c                              |  2 +-
 kernel/bpf/log.c                                   |  2 +-
 kernel/bpf/verifier.c                              |  5 +--
 kernel/dma/map_benchmark.c                         |  3 +-
 kernel/irq/manage.c                                |  2 +-
 kernel/jump_label.c                                |  5 +--
 kernel/kthread.c                                   |  2 +-
 kernel/sched/ext/cid.c                             | 16 +++----
 kernel/sched/ext/ext.c                             |  2 +-
 kernel/sched/ext/sub.c                             |  2 +-
 kernel/trace/fprobe.c                              |  2 +-
 kernel/trace/ring_buffer.c                         |  4 +-
 kernel/trace/trace_eprobe.c                        |  2 +-
 kernel/trace/trace_remote.c                        | 10 ++---
 lib/test_rhashtable.c                              |  2 +-
 lib/test_workqueue.c                               |  4 +-
 lib/tests/kunit_iov_iter.c                         |  2 +-
 net/batman-adv/hard-interface.c                    |  2 +-
 net/bluetooth/hci_sync.c                           |  3 +-
 net/devlink/netlink.c                              |  2 +-
 net/devlink/param.c                                |  7 ++-
 net/ipv4/tcp_ipv4.c                                |  4 +-
 net/mac80211/nan.c                                 |  3 +-
 net/mctp/test/route-test.c                         |  2 +-
 net/mctp/test/utils.c                              |  2 +-
 net/netfilter/nf_tables_api.c                      |  2 +-
 net/netfilter/nfnetlink_cttimeout.c                |  2 +-
 net/rds/info.c                                     |  2 +-
 net/rxrpc/key.c                                    |  2 +-
 net/sched/act_gate.c                               |  4 +-
 net/sched/act_tunnel_key.c                         |  2 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |  5 +--
 net/sunrpc/svcauth_unix.c                          |  4 +-
 net/sunrpc/xdr.c                                   |  3 +-
 net/unix/af_unix.c                                 |  4 +-
 net/wireless/nl80211.c                             |  9 ++--
 security/integrity/ima/ima_queue.c                 |  3 +-
 sound/core/compress_offload.c                      |  4 +-
 sound/core/control.c                               |  6 +--
 sound/core/control_led.c                           |  2 +-
 sound/core/init.c                                  |  2 +-
 sound/core/misc.c                                  |  2 +-
 sound/core/oss/mixer_oss.c                         |  2 +-
 sound/core/pcm_native.c                            |  2 +-
 sound/core/seq/oss/seq_oss_synth.c                 |  2 +-
 sound/core/seq/seq_clientmgr.c                     |  2 +-
 sound/core/seq/seq_virmidi.c                       |  2 +-
 sound/core/timer.c                                 |  2 +-
 sound/drivers/aloop.c                              |  4 +-
 sound/isa/gus/gus_dma.c                            |  2 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |  2 +-
 sound/pci/ctxfi/ctamixer.c                         |  4 +-
 sound/pci/ctxfi/ctdaio.c                           |  4 +-
 sound/pci/ctxfi/ctsrc.c                            |  4 +-
 sound/pci/ctxfi/cttimer.c                          |  2 +-
 sound/pci/emu10k1/emufx.c                          |  2 +-
 sound/soc/codecs/simple-amplifier.c                |  2 +-
 sound/soc/generic/simple-card-utils.c              |  2 +-
 sound/soc/meson/gx-formatter.c                     |  2 +-
 sound/soc/qcom/qdsp6/q6afe.c                       |  2 +-
 sound/soc/sdca/sdca_functions.c                    | 19 ++++----
 sound/soc/sof/sof-client-probes-ipc4.c             |  2 +-
 sound/soc/sof/sof-client.c                         |  2 +-
 sound/sparc/amd7930.c                              |  2 +-
 304 files changed, 637 insertions(+), 726 deletions(-)

-- 
Kees Cook
