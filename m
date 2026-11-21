Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A56606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSEPksMF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053E610E3CA;
	Sat, 21 Nov 2026 15:47:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A98A10E3CA;
 Sat, 21 Nov 2026 15:47:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5287845650;
 Sat, 21 Nov 2026 15:47:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795276041;
 b=ujrvoqDJ73TbdnKTNyOecNAb9t/0iRF5fOmwts9bAhkLFjIfHfBaxmhWeNGaSZ+CrCBo
 yOyyWzHC7fdFQi3COfA3qMrv1s8vNhn97v5dn5R9vm8FztBy00RnEEe0zMjI8n+hWU0Ek
 DwRSpRC+RGsUfi4BPpL1goQkBkou6h+lZuMG4X6Gbw+BWeWiqWq1Xfaio6mGZ9Gg56HPt
 Gp8lt4RdSxlt6nfaFGFOuaidEeCG09PmuzuSYe4zO3v+6g4EFkw0ryh0kH550mpK83hPe
 cNRfFEUAIb0qenG0rLc/WvvcynPcQM9jHpN26rxExB+OQpTGV9fISW255KnE4SeRNkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795276041;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=F5E/ZlPs4yzG3otHcOe3FnBTkOLh6I3GMMSmncibKPo=;
 b=ZsVG3DWgcomAEMzaErzPAZ8PyY/JuCk6xfI4Eu7w447C+4YMHpMaH1meak9fEYS4YE/9
 nCz+HqgVSOrhHfEsLZUGMM8QRp5Cf0kz1jE5F/E3NRimDd6u5zLGeVqIlrQYi+0lirt5L
 ghkD09HeLwSW7lfHJu3oJbcdBaBy9lOBcPo38RjBtz4kNsa0+gykxSOmkGciWI8SC3Yzb
 S8WwaqXt36ljxOOxxLthoHdJfiFNzKtt8VwAj8OpgwvBScfAOFsn+D0geA9vZ8TB1+xXS
 O7FNgg3C3CjT59y03V5L5jLs/U9Qbj/2PGbLgUFao9KnLb2RWqM1p96PRF1FPWcQzXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 280591F000CA;
 Sat, 21 Nov 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795276041;
 bh=F5E/ZlPs4yzG3otHcOe3FnBTkOLh6I3GMMSmncibKPo=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=jSEPksMFKQYxJa1RX28s3bgxBi02xvD0Xt5DYuuWDahdLmg3PGp8Wsec4g+pM6hy0
 ga0oLZukSela/moNqyHbg3OZsyWaIKF0yEu5On8vmhNGrW2Ej8atk/jVUphFDJ9U7A
 i6OMxPYYKw6WFfM+1zp47vba310bOEma4uQ7dCDjqFIx+METnvC3Q0vgWbTS7uJ74g
 dufCXo5d+wp7ZUi57iRowx40PaOujN6A/YxVMqWV4nquOzP0qr7nvW9GpuvOP5f8GS
 msiNEuAOkoa0RuqOU9/+FiVxSnoMJ/7UT0RH+0hK640kaMH/d6elhyFem5JgrtJlZj
 pT7c/zCKryC5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7F2AE4BCDE;
 Sat, 21 Nov 2026 15:47:19 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] drm/imagination: Fix leaks in HWRT data set
 handling
Date: Sat, 21 Nov 2026 15:47:18 +0000
Message-Id: <20261121-pvr-hwrt-common-v2-0-9f53bdf954de@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAa9AWsC/yXMQQqDMBBA0avIrDtgJiK2V5Euahx1BBOZqC2Id
 2/U5Vv8v0NkFY7wynZQ3iRK8An0yMANH98zSpsMlFNpDBmcN8Xhqwu6ME3BY5U/HdnCNpY7SNW
 s3MnvOtbv23FtRnbLuYHj+AOOuSqTcwAAAA==
X-Change-ID: 20261121-pvr-hwrt-common-809c2343b3ef
To: alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Cc: donald.robson@imgtec.com, mripard@kernel.org, 
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, 
 airlied@gmail.com, simona@ffwll.ch, tzimmermann@suse.de, 
 linux-kernel@vger.kernel.org, imagination@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795276038; l=1054;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=iAyx4VKD3Xv1616eFxfmrsRynviVXNZ24B8giwun1Vc=;
 b=mt/gzNvH8FhV/6IA+g7Buh16qvErqpTF/q1qscdAwycxY2+4UFHd09K3xpXY7hz6p/8lwyYPA
 1sJDj/8t6vECtMAcPFmhuVtJrrTUChVtLzidkrvHvidJBewqMAZZWO7
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: shyckless@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 is v1 with the Fixes tag corrected: the error path that skips
hwrt_fini_common_fw_structure() came with f1f55ed3ffe4, not with the
commit that added the ioctl (thanks to the Sashiko review).

Patch 2 fixes the other leak that review pointed out: the 32-bit layer
count is truncated into the 16-bit max_rts, so the SRTC and RAA objects
allocated for layers > 1 can be skipped on destroy.

Found with a static analysis tool and checked by hand. Compile tested on
arm64 (W=1, all files that include pvr_hwrt.h); I don't have the
hardware.

Changes in v2:
- 1/2: Fixes tag now points to f1f55ed3ffe4. No code change.
- 2/2: new.

v1: https://lore.kernel.org/all/20261121-pvr-hwrt-common-v1-1-784ce45b782a@gmail.com/
---
Suyuan Wang (2):
      drm/imagination: Destroy the common FW object when HWRT data setup fails
      drm/imagination: Don't truncate the layer count in max_rts

 drivers/gpu/drm/imagination/pvr_hwrt.c | 2 ++
 drivers/gpu/drm/imagination/pvr_hwrt.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)


