Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BB4F9D0DA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC11D10E62D;
	Tue, 14 Apr 2026 16:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A+JL0elu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B484D10E628
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:31:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B2075600CB;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E285C19425;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776184280;
 bh=gNqdE9d81DRyUjeuqyd3JZqlKkL8O3oEZBn4pvoKquI=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=A+JL0eluU8YhIaTg9TVLcFGK6AaI6NWA8iV8RdB5LAie5AE4Tj8N8vWVSWz0/AAyg
 TsztY8nxACWFQ70K/mdmRl08JzP6x9Wc/xTJbHrhcL2CGVFUzS6ATo4iYvPDkwKnnd
 LEMsorVqoZY16SqhRbYn3aR34yLlNZ7JGwKv5vb1n6phC66iFe9Vjta2fOOYotaTCj
 XyEBM/bsg3oNQE86A5m8KB2NJ7LJctVDMxLTF8NtUpR002wXFmMakuRjssdtfFxhqi
 6Jb3Vfb+iZ9vgyoKMo/Ighkls5jNFyanvzUcKlkpvc3kfeLeZLwxQR2f2MEYrQh5g3
 Gjga8N+Z85RzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 47ED0F9D0DC;
 Tue, 14 Apr 2026 16:31:20 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/3] Introduce generic context device bus for IOMMU context
 isolation
Date: Tue, 14 Apr 2026 22:01:14 +0530
Message-Id: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJr3mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0MT3eT83ILSktSk0mLdVAtTozRLS5PUVCNTJaCGgqLUtMwKsGHRsbW
 1AE2VhC1cAAAA
X-Change-ID: 20260414-computebus-e852f994ee25
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776184278; l=2594;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=gNqdE9d81DRyUjeuqyd3JZqlKkL8O3oEZBn4pvoKquI=;
 b=baxjKIj5uScDYrCIYv1qYvM3a63CPT0wbgKn65lPfsAUxTA/AlgOpd2u7suXXwN600FcGRQqF
 3nuqpzm5lmqBrQTEYy04WW8GTzfnkrDDDEQwfOQK54jlvxWaVJzVsAz
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Endpoint-Received: by B4 Relay for ekansh.gupta@oss.qualcomm.com/20260223
 with auth_id=647
X-Original-From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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
Reply-To: ekansh.gupta@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series introduces a generic context device bus to replace driver-specific
implementations and enable proper IOMMU handling of synthetic context bank
devices used by accelerator and GPU drivers.

Background:
-----------
During review of the fastrpc driver changes [1], it was pointed out that using
a platform driver for compute bank (CB) devices was incorrect since these are
synthetic IOMMU context banks, not real platform devices. The platform driver
approach also had a race condition where device nodes were created before
channel resources were initialized, and probe was async, allowing applications
to open devices before sessions were available.

The reviewer suggested following the pattern used in host1x_memory_context_list_init()
and creating devices manually. During review of the QDA driver [2], it was
further suggested to create a generic bus type that could be shared across
multiple drivers rather than having each driver implement its own bus.

This series implements that suggestion by:
1. Creating a generic context_device_bus_type in drivers/base/
2. Migrating the existing host1x driver to use it
3. Converting fastrpc to use it, fixing the race condition in the process

References:
-----------
[1] Fastrpc platform driver review:
    https://lore.kernel.org/all/golcrcr6voafr3fqsnihyjyut36sii55vzws4josfhkjjg3nie@ur43qq2kvlsv/

[2] QDA driver review requesting generic bus:
    https://lore.kernel.org/all/en5tdgemre7vq5qihe6wnkbrro24vtzwfxwqrpnrrmugxoszs7@x2ox64zeznvd/

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Ekansh Gupta (3):
      drivers: base: Add generic context device bus
      gpu: host1x: Migrate to generic context device bus
      misc: fastrpc: Use context device bus for compute banks

 drivers/base/Kconfig             |   3 +
 drivers/base/Makefile            |   1 +
 drivers/base/context_bus.c       |  24 ++++++
 drivers/gpu/host1x/Kconfig       |   5 +-
 drivers/gpu/host1x/Makefile      |   1 -
 drivers/gpu/host1x/context.c     |   2 +-
 drivers/gpu/host1x/context.h     |   3 +-
 drivers/gpu/host1x/context_bus.c |  26 ------
 drivers/iommu/iommu.c            |   6 +-
 drivers/misc/Kconfig             |   1 +
 drivers/misc/fastrpc.c           | 180 +++++++++++++++++++++++++++------------
 include/linux/context_bus.h      |  15 ++++
 12 files changed, 174 insertions(+), 93 deletions(-)
---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260414-computebus-e852f994ee25

Best regards,
-- 
Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>


