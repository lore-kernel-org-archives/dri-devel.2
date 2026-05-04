Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2375FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F9610E815;
	Mon,  4 May 2026 19:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LA8GFd9h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7789510E004;
 Mon,  4 May 2026 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777922601; x=1809458601;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6EehDOOpmIN6njM8C8Ksja0bF905DNnueZTtvSexwhc=;
 b=LA8GFd9hX9Vu++57fAIbVfJFssQSz86qAJO7ysDHTohUv+trqNNXfe3L
 qLS8EB7u3JdIrbIhbGL4CjMxIEBdQDplVglkdpubIaKDvXl+UGXuuBG/n
 pwid1q4kL6YWmKPUoY4Dg49I/4XFCpY8xe/eIG1SIFK6YmsIr4LZmb/Uq
 WZ4C0E+deE1w6oy6azYWI1+jdjzoywENoj0Q5PSdylIE812LihwAZqeZv
 7jQSf1G/OY4qedeO3uvuwylYCnrr5KzJfbNV5+VA60vdnAZFwhrixpeqx
 I/OPHBP6IcUvVFh7R+NzVmsjnATrjMOupNBS+cw4ochD4ZTyPYBIA0eDr g==;
X-CSE-ConnectionGUID: jX0wc+yiTQCtF0rycgzgMA==
X-CSE-MsgGUID: 2euUmaqLS4qMSC/SjsI/6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89482108"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="89482108"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 12:23:21 -0700
X-CSE-ConnectionGUID: 6fohn/fARMWEjEy5uKwJbQ==
X-CSE-MsgGUID: 0h6DVZXBTsKewiNeZrDZ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="239565838"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 12:23:13 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: badal.nilawar@intel.com, rodrigo.vivi@intel.com, wojciech.drewek@intel.com,
 michael.brooks@intel.com, heikki.krogerus@intel.com,
 michael.j.ruhl@intel.com, thomas.hellstrom@linux.intel.com,
 michal.winiarski@intel.com, anshuman.gupta@intel.com,
 jacob.e.keller@intel.com, maarten.lankhorst@linux.intel.com,
 matthew.brost@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, singaravelan.nallasellan@intel.com,
 kelvin.gardiner@intel.com, jk@codeconstruct.com.au,
 matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 james.ausmus@intel.com
Subject: [RFC PATCH 0/1] Proposal for in-band firmware update over PLDM-MCTP
Date: Tue,  5 May 2026 01:04:21 +0530
Message-ID: <20260504193420.1232842-3-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.54.0
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

Problem statement: 

The CRI platform includes a dedicated I2C controller for in-band access to AMC.
AMC firmware updates leverage PLDM over MCTP, using the I2C controller as the
physical transport, enabled by the Linux kernel's MCTP-I2C driver
(drivers/net/mctp/mctp-i2c.c), which manages MCTP framing and delivery over the
I2C bus.

CRI Inband firmware update flow

        +-----------------------------------+
        |         User Space                |
        |	(PLDM requester/responder)  | 
        |   PLDM client via AF_MCTP socket  |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |        net/mctp core              |
        |   (routing, EID resolution,       |
        |    MCTP framing)                  |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |           mctp-i2c.c              |
        |   MCTP transport over i2c         |
        +-----------------------------------+
                          |
        +-----------------------------------+
        |          AMC Firmware             |
        |	(PLDM requester/responder)  | 
        |  MCTP Decode -> PLDM Processing   |
        +-----------------------------------+

Future GPU platforms may not include a dedicated I2C controller for MCTP
access; however, the requirement to support PLDM over MCTP persists. To
address this, a vendor-specific mailbox-based transport is proposed to
carry MCTP messages between the host and the GPU/AMC.

Solution:

The proposed approach involves implementing an MCTP transport layer with
binding type MCTP_PHYS_BINDING_VENDOR (0xFF) and incorporating it either
into the drivers/net/mctp/ directory or the drivers/gpu/drm/xe subsystem.
The latter is particularly fitting, as Xe is the exclusive consumer of
this functionality.


Option 1: MCTP Transport as Part of drivers/gpu/drm/xe Subsystem

Under this design, the Xe KMD takes sole ownership of the MCTP mailbox
transport layer. The implementation is introduced as a new source file,
xe-mctp-mailbox.c, placed within the drivers/gpu/drm/xe/ driver tree.

Although xe-mctp-mailbox.c resides within the Xe subsystem, it does not
operate in isolation from the broader networking stack. It integrates
with the standard Linux MCTP stack by registering an MCTP net device
via mctp_register_netdev(), allowing the net/mctp core to manage
routing, EID resolution, and MCTP framing in the usual way.
This means Xe retains direct ownership of the mailbox MMIO interface
(status, and data registers via BAR), while still participating as
transport in the MCTP network subsystem.


  +--------------------------------------------------+
  |                  User Space                      |
  |         (PLDM Requester / Responder)             |
  |       PLDM Client via AF_MCTP Socket             |
  +--------------------------------------------------+
                         |
                    AF_MCTP API
                         |
  +--------------------------------------------------+
  |              net/mctp Core                       |
  |    (Routing, EID Resolution, MCTP Framing)       |
  +--------------------------------------------------+
            |                        ^
            | mctp_register_netdev() | netdev / mctp_dev ops
            |   (called by Xe KMD)   |
  +--------------------------------------------------+
  | [NEW] drivers/gpu/drm/xe/xe-mctp-mailbox.c       |
  |                                                  |
  |   Owned by  : Xe KMD (drivers/gpu/drm/xe/)       |
  |   - Registers directly as MCTP net device        |
  |   - Implements MCTP transport over Mailbox MMIO  |
  +--------------------------------------------------+
                         |
           Direct MMIO access (BAR registers)
                         |
  +--------------------------------------------------+
  |         Intel Mailbox MMIO Registers             |
  |    (Doorbell, Status, Data Registers via BAR)    |
  +--------------------------------------------------+
                         |
              Hardware Mailbox Interface
                         |
  +--------------------------------------------------+
  |             GPU / AMC Firmware                   |
  |         (PLDM Requester / Responder)             |
  |   Mailbox Handler --> MCTP Decode                |
  |              --> PLDM Processing                 |
  +--------------------------------------------------+

Pros:
    + Tightly coupled with Xe and doesn't polute current generic mctp
      subsystem with vendor specific mailbox solution.
Cons:
    - Not a generic layer; cannot be easily reused or consumed
      by other drivers or subsystems outside of Xe.

RFC Patch: "xe/xe_mctp_mailbox: Add support for MCTP transport over mailbox"

Option 2: MCTP Transport as Part of net/mctp Subsystem

The MCTP mailbox driver (intel-mctp-mailbox.c) resides under
drivers/net/mctp/ and registers itself as an Auxiliary Bus Driver on the
Linux auxiliary bus. The Xe KMD is responsible for constructing an
Auxiliary Bus Device which encapsulates the mailbox ops and registering
it against the MCTP auxiliary bus driver. This binding allows the MCTP
layer to send and receive messages through the GPU mailbox interface.

  +--------------------------------------------------+
  |                  User Space                      |
  |         (PLDM Requester / Responder)             |
  |       PLDM Client via AF_MCTP Socket             |
  +--------------------------------------------------+
                         |
                    AF_MCTP API
                         |
  +--------------------------------------------------+
  |              net/mctp Core                       |
  |    (Routing, EID Resolution, MCTP Framing)       |
  +--------------------------------------------------+
                         |
              mctp_dev ops / netdev interface
                         |
  +--------------------------------------------------+
  | [NEW] drivers/net/mctp/intel-mctp-mailbox.c      |
  |                                                  |
  |   Registered as: Auxiliary Bus Driver            |
  |   - Binds to Auxiliary Device exposed by Xe KMD  |
  |   - Accesses mailbox ops shared via aux device   |
  +--------------------------------------------------+
       |                              |
       | auxiliary_driver_register()  | auxiliary_device_register()
       |                              |
  +--------------------+   +-------------------------+
  | Auxiliary Bus      |<->| Auxiliary Device        |
  | Driver             |   | (created by Xe KMD)     |
  | (intel-mctp-       |   | - Contains mailbox_ops  |
  |  mailbox.c)        |   |                         |
  | drivers/net/mctp/  |   |                         |
  +--------------------+   +-------------------------+
                         |
              mailbox_ops (send/recv via MMIO)
                         |
  +--------------------------------------------------+
  |         Intel Mailbox MMIO Registers             |
  |    (Status, Data Registers via BAR)              |
  +--------------------------------------------------+
                         |
              Hardware Mailbox Interface
                         |
  +--------------------------------------------------+
  |             GPU / AMC Firmware                   |
  |       (PLDM Requester / Responder)               |
  |   Mailbox Handler --> MCTP Decode                |
  |       --> PLDM Processing                        |
  +--------------------------------------------------+


Pros:
    + Natively part of the MCTP stack.
    + Consistent with existing MCTP transport implementations
      such as mctp-i2c and mctp-i3c. Probe occurs naturally
      when the auxiliary device is created, following standard
      kernel device model patterns.
Cons:
    - Introduction of vendor specific cases along with current
      generic mctp entries

	
Open for other ideas and suggestions.

Note: This RFC is prepared with AI assistance (e.g. GitHub Copilot etc).

Badal Nilawar (1):
  xe/xe_mctp_mailbox: Add support for MCTP transport over mailbox

 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_mctp_mailbox.c | 186 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_mctp_mailbox.h |  14 ++
 5 files changed, 208 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.c
 create mode 100644 drivers/gpu/drm/xe/xe_mctp_mailbox.h

-- 
2.54.0

