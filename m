Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B3CC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507E610E9DF;
	Sun, 13 Sep 2026 20:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ireE3+fT";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4617C10E374
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:18:47 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f16so760759e87.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789197525; x=1789802325; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rLeyn0OC1le5MSTZk6KLze1f/9azpPHpmNeLJDOBQ0U=;
 b=ireE3+fTjBQR7cuDM26y/1v/hClVHmhRwpL/zHLVS00ZIdC0nNpSMcbu/BQsf4xzHH
 IYYnM8FZUk/OOF2Z9CZQ4/DH/rRGBAodzFrIfzJRYLbqF3V9tVqRS+KmvRJuokABKqwh
 UP58dDGmTMXs14ai259JgEn6Zcny4V7QFYzy2Dki3cS4BCweHHXWgMLFZ4Dl5NEVmM8R
 1aPLwAyYOH6XdNeSrY2rudzPui+Sq5Ss/fdAeLsuEySH/O9wej7+OS3sQ9ziF6MdZmtU
 5XOA/avAEVwuOd25M3LtexC0ygVIrQXa7xAWzWcYj2Yg6ZNM4H5rmCHq+IaZdLAbG10G
 9fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789197525; x=1789802325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rLeyn0OC1le5MSTZk6KLze1f/9azpPHpmNeLJDOBQ0U=;
 b=VjhwJpNgItv4vt0j0S+jy548ZvmWtTKR8c6XJ27goyFXyWNgCyANIppJ4DMTYpSyTX
 4wzb6md7a2R9wTWtMMJtq2xkiaAsYoGGDeAsv2QdCxd727xXrDZ6rgeKxUP2W9EbQFkI
 S9PyI3qWbnpJ1AYrQUc/y2fn3Rf3KeCsw6l3xTruPxySPxP4B0ZTzjeONRTEhwADpX7j
 ABpibNdwVqZlNEZbbiw5SFzTbn1F4x22bT1894pZRh+7ZvlfREbOmM2J24cOAm811Lov
 +wfXQiRgZ8We/UdN6VAuYnTLSj3RATL9TrFMN+G7mVTH5imp6jqIyZIrh9eImyG5bS42
 Ia+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBznvTLe8OAbXeS/TJke4vxzjA0dNjAAz279w/J3gCpiuOtF+02+xVE85ia0VMK54CNOJDVybX8gYpw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k+QlPWz2TBQa9ncspcdX+zbbGjHH9AgQ5+ZKBOfhFkkc9ScM2J
 uuS3g2qju4114LU0VQoy/FQngOfKbKdiJGbwShy0YJH18cIp1GeBUO9q
X-Gm-Gg: AYBFou3hR3yR4ImqqtWpLqM5ta8AK6OEUzGMITvNNneJKXfvmEAJTJGetS8QvmUq5Ld
 TvfACrVMpWOal5uMQu6j8LyPuuGyrFJhB6P7f5sLjyFAwP8luehtkJMIM2QPqvdJN6aVMnWskit
 OXORWQdkzh1UAu+UhBT4REx8Nxk7HsBCOt1FFY+Uob8uKlGPaxNYwZxoXOjz9qqCNYTRRBpkAPx
 ZdkCxgTmf5RowfizYlFyLTrnZqHGNo6AEzg12wn4jrQpF1CpjLfucxNuh0Q+juT9TlNKarAHjGu
 du7jJ7OSwVHyB4IP0tLhtTCdpL3GEWTDv/nfdI4kManb0nvbEAeY961YYPwiPcW2JuU4LhgKJm4
 J6Er1f3XIKLxLZNT4awsP5fLhFTrjHqb8W+VpIj1J40v1E3MgbyLeE4U14Y6TN9h5v2ifr3DZy5
 FdqPUsGdRwPEHsH5KfjUrZn/++rtxz0CTnmdZ5bnHdp9udNJm2lsJ7kjwQVbEMNmtt3AYeBJgyD
 qPFWg==
X-Received: by 2002:a05:6512:3b87:b0:5b8:9ee1:10fd with SMTP id
 2adb3069b0e04-5b8a0343aefmr3048202e87.32.1789197524822; 
 Sat, 12 Sep 2026 00:18:44 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04571b0sm1096277e87.13.2026.09.12.00.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:18:44 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v3 0/3] gpu: nova-core: retain the GSP-RM log buffers
Date: Sat, 12 Sep 2026 14:18:39 +0700
Message-ID: <20260912071842.622696-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The GSP-RM log buffers are exposed through debugfs, but the entries are
owned by the Gpu that probe() builds, and the buffers themselves are DMA
allocations that cannot outlive the device. They are therefore gone as
soon as the GPU is unbound, and in particular as soon as probe() fails -
which is the case todo.rst singled out, and the one where a GSP log is
worth having.

Patch 1 is a fix this series needs: init() builds the Registration before
the guard that clears the debugfs root, so a registration that fails
leaves the root behind with nothing left to remove it, and the next load
finds the name taken. Patch 2 adds a gsp_keep_logs module parameter: when
it is set, whatever the GSP wrote is copied into memory owned by the
module and exposed under a "retained" directory until the module is
unloaded. Patch 3 drops the now completed task from todo.rst.

Changes since v2:
 - rebase onto current drm-rust-next, where Coherent carries the lifetime
   of the bound device; the live log buffers borrow the device rather
   than holding a reference to it, and only the copies keep one
 - make gsp_keep_logs a bool, now that module parameters support it
 - add the dma_rmb() discussed on v1, as dma_mb(Read), between reading
   the "put" pointer and copying the buffer
 - build the debugfs guard before the Registration (patch 1), so that a
   failed module init cannot leave either directory behind
 - keep nothing when CONFIG_DEBUG_FS is off, where a Dir is a zero-sized
   type and the copies could never be read back
 - take the snapshots before acquiring the global lock, rather than
   holding it across three 64 KiB allocations

Testing was done on top of drm-rust-next with the TLV firmware images
installed. On a GB203:

  - with gsp_keep_logs unset, no "retained" directory is created and the
    entries disappear on unbind, as before;
  - with gsp_keep_logs=1, retained/<BDF>/{loginit,logintr,logrm} hold
    the contents the live entries had, all 64 KiB of each readable;
  - binding the GPU again recreates the live entries without disturbing
    the copies, and unbinding it a second time replaces them, leaving
    exactly one set behind;
  - with a failure injected after the GSP has booted, probe() fails with
    -EINVAL, the driver stays unbound, and the logs of that attempt are
    still readable;
  - with a failure injected into the Registration instead, the module
    fails to load and leaves no debugfs directory behind, where before
    patch 1 the next load would have found the name taken;
  - the copies are released on module unload, and three load/unload
    cycles leave nothing behind;
  - 1, Y and y turn it on, 0 and N turn it off, and a value that is
    neither is refused at load time.

The parameter does need a value: the Rust bool param ops do not set
KERNEL_PARAM_OPS_FL_NOARG, so a bare gsp_keep_logs is refused, where the
C bool would have taken it.

No warnings, oopses or refcount complaints in dmesg throughout. Built and
checked with CLIPPY=1 and rustfmtcheck. checkpatch --strict is clean
apart from the MAINTAINERS note for the new file, which is already
covered by the existing "F: drivers/gpu/nova-core/" pattern.

John Hubbard's r000 series adds three more log buffers in gsp.rs.
Whichever of the two lands second needs a small rebase; the retained
copies extend to the new buffers by adding them to RetainedLogBuffers.

v2: https://lore.kernel.org/nova-gpu/20260815050826.306717-1-vladazaharova2018@gmail.com/
v1: https://lore.kernel.org/nova-gpu/20260812113752.532537-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (3):
  gpu: nova-core: build the debugfs guard before registering the driver
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/gsp.rs           | 100 ++-------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 267 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  36 +++-
 4 files changed, 320 insertions(+), 95 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: 73e5616f3d197c1af5a04a481fe0f13aa3913bd1
-- 
2.55.0

