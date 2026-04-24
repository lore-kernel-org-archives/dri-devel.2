Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96D7FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F6110E0E9;
	Fri, 24 Apr 2026 22:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RqnOgpU8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4833410E0E9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777070093; x=1808606093;
 h=date:from:to:cc:subject:message-id;
 bh=3HopLhOAfmINSYdImfoFsHkfsN4vAPjjPqkMmqS4KAU=;
 b=RqnOgpU80M8rcY7yrqWzPw7DpiDyR8hW7Q1Cgs4QdUzub7v+Kpx4rlF7
 yvkTqsBmgVDR9pJUE2NrzgDPEzaqqAox99qYydW6WkxmLQTL85f003vkq
 F+hpXf8q/HXT8WZUKWlw2pPwfXnS7Gxu0W2yF9K36IkDDK0D6d44hk7mJ
 PIu/IBnKqtGlVaEZJT0qmqm+HpdCHpZoI9wpfjXw1bvwwQm6QJkmYlWP0
 Yp88PEbZnvWt0kpndvIfELRrx49ImkIL8qDTR2MZ7tvnLPjI1nCLkZT1L
 NJnoUMSwDM5kxKPnUsF2P8FGel/w/1v2cM4ag7frHzP1eJkDhO9QuzHe/ A==;
X-CSE-ConnectionGUID: T8zd/qpMQwuI3qaHnRK6gA==
X-CSE-MsgGUID: BeXWw+o9R/+aEytCGCa0Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77970037"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="77970037"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2026 15:34:52 -0700
X-CSE-ConnectionGUID: cW6OTeEITcO2Z2om/MvPDA==
X-CSE-MsgGUID: Yw3BO2OAQOef181quTpsOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; d="scan'208";a="234866619"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
 by fmviesa004.fm.intel.com with ESMTP; 24 Apr 2026 15:34:49 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wGP6l-000000006Ar-04Fa;
 Fri, 24 Apr 2026 22:34:47 +0000
Date: Sat, 25 Apr 2026 06:34:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Linus Walleij <linusw@kernel.org>
Subject: [drm-misc:drm-misc-next 17/19] WARNING: modpost: vmlinux:
 section mismatch in reference: sys_call_table+0x130 (section: .text) ->
 keembay_emmc_phy_driver_init (section: .init.text)
Message-ID: <202604250623.02dzJcGX-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   03af6c3afc4893988ceed54531f5dde4bebd6024
commit: 07853e95424869059d7ce1cd25c800f88ee03e95 [17/19] drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel
config: mips-randconfig-r111-20260424 (https://download.01.org/0day-ci/archive/20260425/202604250623.02dzJcGX-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260425/202604250623.02dzJcGX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604250623.02dzJcGX-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: sys_call_table+0x130 (section: .text) -> keembay_emmc_phy_driver_init (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: sys_call_table+0x138 (section: .text) -> keembay_emmc_phy_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: irq_map_generic_chip+0x2a8 (section: .text) -> keembay_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: irq_unmap_generic_chip+0xe0 (section: .text) -> keembay_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dev_map_redirect_multi+0x1dc (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dev_map_redirect_multi+0x310 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dev_map_redirect_multi+0x364 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: crypto_des3_ede_encrypt+0x3c (section: .text) -> ltq_rcu_usb2_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rzg2l_irqc_common_probe+0x294 (section: .text) -> keembay_usb_phy_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mchp_eic_probe+0x228 (section: .text) -> keembay_usb_phy_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpiochip_hierarchy_irq_domain_alloc+0xb8 (section: .text) -> keembay_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __traceiter_rpmh_send_msg+0x44 (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __traceiter_rpmh_send_msg+0x48 (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __tcs_buffer_write+0x6c (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __tcs_buffer_write+0x74 (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __do_trace_rpmh_send_msg+0x4c (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __do_trace_rpmh_send_msg+0x54 (section: .text) -> armada375_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gsm_dlci_free+0x68 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fimd_bind+0xa4 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fimd_bind+0xec (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fimd_bind+0x154 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fimd_bind+0x1a0 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: fimd_bind+0x204 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mixer_bind+0x294 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mixer_bind+0x314 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: mixer_bind+0x350 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vidi_bind+0x80 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vidi_bind+0xa4 (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vidi_bind+0xcc (section: .text) -> phy_berlin_usb_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: pm8xxx_irq_domain_alloc+0xa8 (section: .text) -> keembay_usb_phy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bond_handle_frame+0x68 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bond_handle_frame+0x110 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipvlan_process_multicast+0x37c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipvlan_queue_xmit+0x17c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipvlan_queue_xmit+0x1e8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipvlan_queue_xmit+0x40c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipvlan_rcv_frame+0xa8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dummy_xmit+0x1a8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_xmit+0x1d0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_xmit+0x22c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_xmit+0x314 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_packet_handshake_receive_worker+0x90 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_packet_rx_poll+0x6ac (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_packet_rx_poll+0x7d0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_packet_receive+0x380 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_packet_receive+0x68c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wg_socket_send_skb_to_peer+0xc8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ovpn_decrypt_post+0x4c4 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ovpn_net_xmit+0x1cc (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ovpn_net_xmit+0x22c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ovpn_tcp_rcv+0xa8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: eql_slave_xmit+0x110 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macsec_start_xmit+0x474 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macsec_handle_frame+0x520 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macsec_decrypt+0x8c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macsec_decrypt+0x294 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macvlan_process_broadcast+0x1b4 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: macvlan_handle_frame+0x3f4 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tun_do_read+0x98c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tap_handle_frame+0x310 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tap_do_read+0x480 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: veth_poll+0x1e8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: veth_poll+0x918 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: veth_poll+0xdf0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_xmit_one+0x7a8 (section: .text) -> mvebu_a3700_utmi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_changelink+0x314 (section: .text) -> mvebu_a3700_utmi_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_xmit+0x4f0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_xmit+0x828 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_xmit+0xc40 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_fill_metadata_dst+0x240 (section: .text) -> mvebu_a3700_utmi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: neigh_reduce+0x14c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_fdb_delete+0xd4 (section: .text) -> mvebu_a3700_utmi_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_switchdev_event+0x1c4 (section: .text) -> mvebu_a3700_utmi_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_update_default_fdb_entry+0x1a4 (section: .text) -> mvebu_a3700_utmi_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxlan_vnifilter_process+0xdbc (section: .text) -> mvebu_a3700_utmi_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: geneve_xmit+0x3d0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: geneve_xmit+0x52c (section: .text) -> mvebu_a3700_utmi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: geneve_xmit+0xdc0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: geneve_fill_metadata_dst+0x398 (section: .text) -> mvebu_a3700_utmi_driver_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: gtp_dev_xmit+0x718 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: arcnet_reply_work+0x148 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: arcnet_send_packet+0x188 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vcan_tx+0x1ac (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vcan_tx+0x1bc (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vcan_tx+0x1f8 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vxcan_xmit+0x110 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: slcan_receive_buf+0x508 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: slcan_receive_buf+0x8c0 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: can_put_echo_skb+0x15c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ems_usb_start_xmit+0x350 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: esd_usb_start_xmit+0x360 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: esd_usb_start_xmit+0x3f4 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: es58x_start_xmit+0x400 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gs_can_start_xmit+0x540 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kvaser_usb_start_xmit+0x3ec (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: kvaser_usb_start_xmit+0x408 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_do_recv+0x18c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_do_recv+0x39c (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ppp_xmit_process+0x360 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ppp_xmit_process+0x384 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ppp_xmit_process+0x584 (section: .text) -> intel_cbphy_driver_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ppp_xmit_process+0x5c4 (section: .text) -> intel_cbphy_driver_init (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
