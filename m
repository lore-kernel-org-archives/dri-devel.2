Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D878DC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD5510E454;
	Fri, 17 Jul 2026 10:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mYi+SYJT";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 26CEA10E454
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB851476;
 Fri, 17 Jul 2026 03:48:15 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3893F7D8;
 Fri, 17 Jul 2026 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285299; bh=0bo60OYleFw4VVrqObP8ApRUIOYI6RLqGrqNR2tMODE=;
 h=From:To:Cc:Subject:Date:From;
 b=mYi+SYJTdBEMMnkc3FtM0+BHldq32tyWavXaEQUxQs3O4tpZfaOLtaQBru5O+7ceD
 rStsHlQ6Jj30YrQrIVjSsiwzQ1mAjhT/e2UKXEt6LsITLXOBuv6/AzcSKloDp8dndC
 vCjWtLTZjUicPg9qJdirqwRHbb3EiXRvY8S26Xz8=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 0/8] Arm Core Local Accelerator Driver
Date: Fri, 17 Jul 2026 11:47:44 +0100
Message-ID: <20260717104759.123203-1-ryan.roberts@arm.com>
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

Hi All,

This RFC introduces a driver for the Arm Core Local Accelerator (CLA), a
CPU-local interface for programming attached accelerators. While the interface
is agnostic to the accelerator type, the initial (and currently only) target is
a compute engine.

The RFC aims to engage the community and get feedback on some key aspects. This
will help plan our approach for eventual upstreaming. The patches implement a
bare bones driver to aid discussion. Arm plans to publish the CLA spec in
future, but for now I hope the documentation included with patch 1 suffices.
Note that the CLA is not part of the Arm Architecture.

Patch 1 documents the hardware and driver design, and adds a driver skeleton.
Patches 2-4 initialize and probe the device. Patches 5-8 add context management
for switching the device between different users.

Aspects I'm seeking feedback for:

* The general structure of the driver: The current shape addresses the
  performance requirements we have for the use cases, and is therefore our
  preferred approach. But there are some unusual aspects due to the HW design.

* Driver interaction with architectural support: I've opted to treat the CLA as
  a device rather than a CPU extension, so it's implemented as a (mostly)
  self-contained driver. It has some unavoidable coupling to the arch code since
  it needs to share page tables and ASIDs (arm64_mm_context_[put|get]()).

* The location of the driver: although most accelerators will likely be compute
  ones, CLA is a generic MMIO interface that could handle any kind of
  accelerator. It's currently implemented as a misc driver. accel is another
  potential option, but given the current SVA approach, we would not use any of
  the services (memory-management or otherwise) that accel provides.

* User space availability: The kernel driver exposes the capabilities of the
  hardware to user space. Arm plans to open source a user space driver, but does
  not yet have any committed date. I'd like to understand if the availability of
  this component will be a prerequisite for upstream acceptance of the kernel
  driver; either way, I'm hoping we can at least progress with some discussion
  in its absence.

I'm deliberately constraining the scope to bare-metal support for now.
Virtualization is something we are considering (and have prototyped), but plan
to post a separate RFC for that as follow-up, once we have agreement on
direction for the bare-metal driver.

Source, along with some tests, is available at [1]. Patches based on v7.2-rc3.

[1] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/cla-driver-v1-rfc-tests

Thanks,
Ryan


Jean-Philippe Brucker (5):
  misc/arm-cla: Add driver skeleton and documentation
  misc/arm-cla: Add launch operation helpers
  misc/arm-cla: Probe firmware-described devices
  misc/arm-cla: Initialize devices on CPU bringup
  misc/arm-cla: Accelerator context save and restore

Ryan Roberts (3):
  misc/arm-cla: Set up memory translation context
  misc/arm-cla: Manage domain contexts
  misc/arm-cla: Add userspace interface

 Documentation/misc-devices/arm-cla.rst | 206 ++++++++++
 drivers/misc/Kconfig                   |   1 +
 drivers/misc/Makefile                  |   1 +
 drivers/misc/arm-cla/Kconfig           |  10 +
 drivers/misc/arm-cla/Makefile          |  13 +
 drivers/misc/arm-cla/arm-cla-regs.h    | 179 +++++++++
 drivers/misc/arm-cla/arm-cla.h         | 296 +++++++++++++++
 drivers/misc/arm-cla/cla-ctx.c         | 142 +++++++
 drivers/misc/arm-cla/cla-init.c        | 503 +++++++++++++++++++++++++
 drivers/misc/arm-cla/cla-mtc.c         | 139 +++++++
 drivers/misc/arm-cla/cla-ops.c         | 342 +++++++++++++++++
 drivers/misc/arm-cla/cla-regs.c        | 263 +++++++++++++
 drivers/misc/arm-cla/cla-sched.c       | 474 +++++++++++++++++++++++
 drivers/misc/arm-cla/cla-topology.c    | 187 +++++++++
 drivers/misc/arm-cla/cla-user.c        | 351 +++++++++++++++++
 include/uapi/linux/arm-cla.h           | 207 ++++++++++
 16 files changed, 3314 insertions(+)
 create mode 100644 Documentation/misc-devices/arm-cla.rst
 create mode 100644 drivers/misc/arm-cla/Kconfig
 create mode 100644 drivers/misc/arm-cla/Makefile
 create mode 100644 drivers/misc/arm-cla/arm-cla-regs.h
 create mode 100644 drivers/misc/arm-cla/arm-cla.h
 create mode 100644 drivers/misc/arm-cla/cla-ctx.c
 create mode 100644 drivers/misc/arm-cla/cla-init.c
 create mode 100644 drivers/misc/arm-cla/cla-mtc.c
 create mode 100644 drivers/misc/arm-cla/cla-ops.c
 create mode 100644 drivers/misc/arm-cla/cla-regs.c
 create mode 100644 drivers/misc/arm-cla/cla-sched.c
 create mode 100644 drivers/misc/arm-cla/cla-topology.c
 create mode 100644 drivers/misc/arm-cla/cla-user.c
 create mode 100644 include/uapi/linux/arm-cla.h

--
2.43.0

