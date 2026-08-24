Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD17C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4D610E38B;
	Mon, 24 Aug 2026 08:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KVuGNOam";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E25310E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:09:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67E9D600AD;
 Mon, 24 Aug 2026 08:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D2D1F000E9;
 Mon, 24 Aug 2026 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787558984;
 bh=1d8Hjv+x1QYhOu2D2hHNNxA/xzc/ePDob8OGXb0XKxI=;
 h=From:To:Cc:Subject:Date;
 b=KVuGNOamCY2IZ8prKX95MmHaWYs1CIOJXMazB/rz5/BeIgdtq2P1bdXTx6PNk5CnW
 SxgtuaHo28cp3a084iHgOeXFLNWHOQu1ultpCyKTWOc/Vg1mUBIDQsC6MAMll6sOXa
 lQ3meDp9IR+aUyaHwmIBc1EgYoWkAYUwc3Bx72fw9O8VkJpp9LCAQRVY5VcM+qLg46
 G3AjoHGFzVLNr54P6R66N/RdbSZGMdnYGsVUFlNz9RT+YqUwuzN/PfZXRDTwgkJH9a
 9BF0yfWmAdynRCI74V2+R+kVl8wugI6E2QpcCG2UuPplSBu5YiMEbfrr66fqmvRMB3
 GXYksXtu2wuXw==
From: Konstantin Sinyuk <ksinyuk@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology infrastructure
 for scale-up accelerator interconnects
Date: Mon, 24 Aug 2026 11:09:28 +0300
Message-ID: <cover.1787552412.git.ksinyuk@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Modern GPUs and AI accelerators are increasingly connected through scale-up
fabrics such as AMD xGMI today and emerging UALink systems [4]. Linux lacks
common, vendor-neutral infrastructure for reporting which accelerators are
directly connected, through which ports, and in what state.

Vendors expose fragments through driver-specific interfaces such as amdgpu's
xGMI sysfs [3] and AMD's UALink pod-configuration sysfs [6], while prior
per-driver proposals such as XeLink never became shared infrastructure, so
topology semantics remain per-driver.

Building on the LPC 2025 "Toward Mainline Linux Support for UALink" BoF
[1], this RFC proposes DRM Fabric: vendor-neutral, protocol-agnostic DRM
topology infrastructure for scale-up interconnects, using the model

    fabric -> endpoint -> port -> peer

A fabric groups the endpoints of one provider-defined interconnect
instance. An endpoint is one accelerator attachment holding its physical
ports. A port reports lane capability, operational state and optional
counters. A peer is a typed value naming the directly adjacent accelerator
or switch port, not a reference to a live kernel object; it may identify an
accelerator managed by another OS or an opaque switch in another trust
domain.

The core records direct adjacency only, not end-to-end reachability or
switch forwarding, which remain with the fabric controller. Vendor drivers
retain hardware discovery, firmware interaction, memory semantics and the
hardware-carried data path. DRM Fabric represents topology and control
state of DRM-managed accelerators; it does not create a network device or
own route computation, switch forwarding, transport, or congestion control.

Generic Netlink fits this multi-object, event-driven model better than
sysfs, which maps poorly onto dump enumeration and asynchronous
notifications, and provides the YAML-described uAPI discipline introduced
to DRM by DRM RAS [2]. Devlink was considered, but models devices and
subordinate objects rather than a fabric spanning DRM devices.

Patches 1-6 form a complete, separately tested read-only milestone that can
be merged independently while provisioning remains under review. Providers
publish objects, adjacency, operational state and optional port statistics
through a small in-kernel API; userspace queries the live graph but cannot
modify it.

Patches 7-12 add privileged provisioning for software-defined fabrics.
Userspace can create and delete empty fabrics, attach orphan endpoints
registered without a fabric, request administrative state and manage peer
adjacency, while the provider performs the hardware programming.
Administrative state records control-plane intent, operational state
remains provider-reported, and each port is managed either by its provider
or by userspace. The mutation operations are fabric-new, fabric-del,
endpoint-set, port-set, port-peer-new and port-peer-del.

Provider callbacks may sleep or report state back into the core, so
drm_fabric_lock is not held across them. Provisioning instead uses an outer
mutation lock across validation, callback and commit. The complete locking,
lifetime and failure contracts are documented in
Documentation/gpu/drm-fabric.rst.

Every operation is confined to the initial network namespace, and mutation
additionally requires CAP_NET_ADMIN.

drm_fabric_sim is a software-only provider modeled on netdevsim [5]. It
registers linear, mesh and switch-facing topologies without accelerator
hardware and gains provisioning callbacks and fault injection. Its debugfs
interface is not ABI; the reviewed interface is the Generic Netlink family.

The series defines no accelerator memory sharing, MMU programming, data
transport, route computation, switch policy, key management, live
migration, required userspace daemon or protocol-specific commands.

No production provider is included. Shipping only the synthetic provider is
deliberate, allowing the object model and uAPI to be reviewed before being
tied to hardware. We used the public amdgpu xGMI implementation to shape
the provider API, but that mapping has not been validated by AMD.

Example queries using the in-tree YNL tool are:

    $ ./tools/net/ynl/pyynl/cli.py \
          --spec Documentation/netlink/specs/drm_fabric.yaml \
          --dump fabric-get
    $ ./tools/net/ynl/pyynl/cli.py \
          --spec Documentation/netlink/specs/drm_fabric.yaml \
          --dump endpoint-get --json '{"fabric-id": <id>}'
    $ ./tools/net/ynl/pyynl/cli.py \
          --spec Documentation/netlink/specs/drm_fabric.yaml \
          --do port-get --json '{"endpoint-id": <id>, "port-index": 0}'

Testing includes 12/12 per-commit W=1 builds, 43 passing KUnit tests and
172 passing kselftest results across 14 programs. KASAN, UBSAN, lockdep,
atomic-sleep and kmemleak validation completed without reports.

The series is also available from the public review tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/ksinyuk/linux.git/tag/?h=drm-fabric-v1

We are specifically requesting feedback on:

  1. Is fabric -> endpoint -> port -> peer the right minimum common DRM
     representation for accelerator interconnects?

  2. Are the Generic Netlink semantics, including dump consistency,
     notifications and optional port statistics, aligned with YNL
     expectations?

  3. Do the object model and provider API cover xGMI topology-management
     requirements, or would any xGMI requirement force protocol-specific
     uAPI or provider semantics? AMD's assessment would be especially
     valuable.

[1] LPC 2025 BoF, "Toward Mainline Linux Support for UALink":
    https://lpc.events/event/19/contributions/2308/

[2] Riana Tauro, "[PATCH v10 0/5] Introduce DRM_RAS using generic netlink
    for RAS", 2026-03-04:
    https://lore.kernel.org/dri-devel/20260304074412.464435-7-riana.tauro@intel.com

[3] amdgpu xGMI topology:
    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c

[4] UALink specification:
    https://ualinkconsortium.org/specification/

[5] netdevsim:
    Documentation/networking/devlink/netdevsim.rst

[6] Alex Deucher, "[PATCH 00/95] Add UALink instrastructure series 1",
    2026-08-21:
    https://lore.kernel.org/amd-gfx/20260821193458.808626-1-alexander.deucher@amd.com/

Ilia Levi (4):
  drm/fabric: add core object model and provider API
  drm/fabric: add query uAPI and generated headers
  drm/fabric: add topology-provisioning core
  drm/fabric: add provisioning netlink uAPI

Konstantin Sinyuk (8):
  drm/fabric: implement query netlink operations
  drm/fabric: add read-only synthetic provider
  drm/fabric: add object-model KUnit tests
  drm/fabric: add YNL query and policy selftests
  drm/fabric: implement mutation netlink operations
  drm/fabric: make the synthetic provider writable
  drm/fabric: add mutation KUnit tests
  drm/fabric: add mutation netlink selftests

 Documentation/gpu/drm-fabric.rst              |  479 +++
 Documentation/gpu/index.rst                   |    1 +
 Documentation/netlink/specs/drm_fabric.yaml   |  580 ++++
 MAINTAINERS                                   |   14 +
 drivers/gpu/drm/Kconfig                       |    1 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/fabric/.kunitconfig           |    5 +
 drivers/gpu/drm/fabric/.kunitconfig.debug     |   16 +
 drivers/gpu/drm/fabric/Kconfig                |   41 +
 drivers/gpu/drm/fabric/Makefile               |    9 +
 drivers/gpu/drm/fabric/drm_fabric.c           | 1045 +++++++
 drivers/gpu/drm/fabric/drm_fabric_internal.h  |   66 +
 drivers/gpu/drm/fabric/drm_fabric_netlink.c   | 1310 ++++++++
 drivers/gpu/drm/fabric/drm_fabric_nl.c        |  231 ++
 drivers/gpu/drm/fabric/drm_fabric_nl.h        |   66 +
 drivers/gpu/drm/fabric/drm_fabric_sim.c       | 1044 +++++++
 drivers/gpu/drm/fabric/drm_fabric_test.c      | 2635 +++++++++++++++++
 include/drm/drm_fabric.h                      |  333 +++
 include/uapi/drm/drm_fabric.h                 |  162 +
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/drivers/gpu/drm_fabric/Makefile |   44 +
 .../drivers/gpu/drm_fabric/README.rst         |  146 +
 .../drivers/gpu/drm_fabric/cap_netadmin.py    |  314 ++
 .../gpu/drm_fabric/check-spec-regen.sh        |  114 +
 .../selftests/drivers/gpu/drm_fabric/config   |   13 +
 .../drivers/gpu/drm_fabric/dump_intr_abi.py   |  361 +++
 .../drivers/gpu/drm_fabric/dump_scale_abi.py  |  178 ++
 .../drivers/gpu/drm_fabric/fabric_abi.py      |  553 ++++
 .../drivers/gpu/drm_fabric/fault_abi.py       |  302 ++
 .../gpu/drm_fabric/harness_reset_abi.py       |  113 +
 .../drivers/gpu/drm_fabric/hotplug_abi.py     |  331 +++
 .../drivers/gpu/drm_fabric/lib_drm_fabric.py  |  498 ++++
 .../drivers/gpu/drm_fabric/netns_abi.py       |  294 ++
 .../drivers/gpu/drm_fabric/nl_policy_probe.py |  651 ++++
 .../drivers/gpu/drm_fabric/port_cursor_abi.py |  401 +++
 .../gpu/drm_fabric/port_stats_cap_abi.py      |  374 +++
 .../drm_fabric/provisioning_scenarios_abi.py  |  324 ++
 .../selftests/drivers/gpu/drm_fabric/settings |    1 +
 .../drivers/gpu/drm_fabric/switch_abi.py      |  137 +
 39 files changed, 13189 insertions(+)
 create mode 100644 Documentation/gpu/drm-fabric.rst
 create mode 100644 Documentation/netlink/specs/drm_fabric.yaml
 create mode 100644 drivers/gpu/drm/fabric/.kunitconfig
 create mode 100644 drivers/gpu/drm/fabric/.kunitconfig.debug
 create mode 100644 drivers/gpu/drm/fabric/Kconfig
 create mode 100644 drivers/gpu/drm/fabric/Makefile
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_internal.h
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_netlink.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_nl.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_nl.h
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_sim.c
 create mode 100644 drivers/gpu/drm/fabric/drm_fabric_test.c
 create mode 100644 include/drm/drm_fabric.h
 create mode 100644 include/uapi/drm/drm_fabric.h
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/Makefile
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/README.rst
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/cap_netadmin.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/check-spec-regen.sh
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/config
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/dump_intr_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/dump_scale_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/fabric_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/fault_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/hotplug_abi.py
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/lib_drm_fabric.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/netns_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/nl_policy_probe.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/port_cursor_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/port_stats_cap_abi.py
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/provisioning_scenarios_abi.py
 create mode 100644 tools/testing/selftests/drivers/gpu/drm_fabric/settings
 create mode 100755 tools/testing/selftests/drivers/gpu/drm_fabric/switch_abi.py


base-commit: e3e05bddbe9fea67639d2a3551e7cf2d473b804c
-- 
2.43.0

