Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221BAFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155710EB1D;
	Tue, 28 Apr 2026 11:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bvv2T7tO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADBF10EB1D;
 Tue, 28 Apr 2026 11:36:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB3DD60128;
 Tue, 28 Apr 2026 11:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C9C2BCAF;
 Tue, 28 Apr 2026 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777376182;
 bh=EjuVpeXvk+QMO3YZj7e27menUivVdWrZAaKc/D2Uxb0=;
 h=From:To:Cc:Subject:Date:From;
 b=Bvv2T7tOfw+gh4Gtgn7oVzjhdZ0DzOfbHUpkTuYZEaPb6yvJBK/AwB1u/b3oO2inr
 3lSXaRZSSRLWDmDlpFQU+3RwKCbMNZcshbatV3o/0/iUvT+9JC3Dx2lnaYgBWO44UO
 RdEQQWAPqDKC5LZKPwFVjMIaKJAZeLInmSUXY56QM5/4AImV9tL4Gzp4nARJZYd8zZ
 P3GVxTV8EcCUXzPFDo1Eu1A9C4jaIcIU/NQxV5DXnRdZDIyke4hLgahmZTaltPNrMx
 jhD2sXKWmhsnvHsiFFUswMxOBT5kyJ+678U7wIP5CbwQTPyN0E0AT89u0jh8ZES4tZ
 bZ79QEglbDGvw==
From: Thierry Reding <thierry.reding@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Date: Tue, 28 Apr 2026 13:36:14 +0200
Message-ID: <20260428113616.3896930-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
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

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

    drivers/gpu/drm/i915/display/skl_watermark.c

between commit:

    a97c88a176b6 ("drm/i915/wm: Verify the correct plane DDB entry")

from Linus' tree and commits (possibly others, too):

    4268d1397d94 ("drm/i915/wm: Extract skl_ddb_entry_verify()")
    fd52fb0d6cc2 ("drm/i915/wm: Verify 'ddb_y' as well as 'ddb'")

from the drm-intel tree.

I fixed it up manually, but it looks like I could've simply used the
version from the drm-intel tree. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.
