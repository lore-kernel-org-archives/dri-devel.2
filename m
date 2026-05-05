Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA5CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E4810E19B;
	Tue,  5 May 2026 20:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NvMLujDa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C209C10E19B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:52:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A0DC43B02;
 Tue,  5 May 2026 20:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0166DC2BCB4;
 Tue,  5 May 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778014358;
 bh=HChXrytaKurFkc9WqOBSK4ESIOzp4TbVSdtmIumCorE=;
 h=Date:From:To:Subject:From;
 b=NvMLujDalHQBRmPaPYRCs27vCTglfQJZmYSrmi1+HuoRaT+iJi3NMSR43QcuhkB+b
 zz5bY448GrhOrZr7lDUq3fD0G2B6q0M0mxAW340wZDIc8l0B8/0kpH0weiumiSaQa2
 Ei4YJkyaOZn1ma5RMOEgddSkOG/oQq6HCKiZiILGol/ySM5EfkMlIBCTIor/mtyHdL
 W13GpjOdcUI/SBd1Cevj3OhZaDvd1eAoo3GXRPIlr8zmGtFAwb2NYk5oeJVTuEYfO/
 eKVZFVCHxS11BAF8cORt8WEJRaGiY5sVIiBUMS81dn2gTK+SiK5EdnnYqUZBT+Mq9A
 7ZKTZV/8MH61Q==
Date: Tue, 5 May 2026 22:52:33 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and updates for v7.1-rc3
Message-ID: <afpYkddCLxIsicwb@carbonx1>
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

please pull four small patches for fbdev, of which two are important:
One fixes the bitmap font generation and the other prevents a possible
use-after-free in udlfb.

Thanks!
Helge

----------------------------------------------------------------

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc3

for you to fetch changes up to 8de779dc40d35d39fa07387b6f921eb11df0f511:

  fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free (2026-05-04 10:35:55 +0200)

----------------------------------------------------------------
fbdev fixes & cleanups for 7.1-rc3:

- Fix rotating fonts by 180 degrees [Thomas Zimmermann]
- Drop duplicate include of linux/module.h in fb_defio [Chen Ni]
- Add vm_ops in udlfb to prevent use-after-free [Rajat Gupta]
- ipu-v3: clean up kernel-doc warnings [Randy Dunlap]

----------------------------------------------------------------
Chen Ni (1):
      fbdev: defio: Remove duplicate include of linux/module.h

Rajat Gupta (1):
      fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free

Randy Dunlap (1):
      fbdev: ipu-v3: clean up kernel-doc warnings

Thomas Zimmermann (1):
      lib/fonts: Fix bit position when rotating by 180 degrees

 drivers/video/fbdev/core/fb_defio.c   |  1 -
 drivers/video/fbdev/udlfb.c           | 31 ++++++++++++++++++++++++++++++-
 include/video/imx-ipu-image-convert.h | 16 +++++++++++-----
 include/video/udlfb.h                 |  1 +
 lib/fonts/font_rotate.c               |  2 +-
 5 files changed, 43 insertions(+), 8 deletions(-)
