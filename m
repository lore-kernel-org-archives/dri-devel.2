Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60C1C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD24810F520;
	Fri, 11 Sep 2026 07:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sicoop.com header.i=@sicoop.com header.b="kybPoW2M";
	dkim-atps=neutral
Received: from smtpout7.mo539.mail-out.ovh.net
 (smtpout7.mo539.mail-out.ovh.net [51.210.91.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B12510E5FB
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:52:26 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHW6zDZz4F9T;
 Thu, 10 Sep 2026 16:52:23 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <christian.koenig@amd.com>; Thu, 10 Sep 2026 16:52:23 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.80])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hgkHW5mLnz6MbJ; Thu, 10 Sep 2026 16:52:23 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.2])
 (Authenticated sender: michaltoma@sicoop.com)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 05683941C3D; 
 Thu, 10 Sep 2026 16:52:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003a0747e58-7207-4f04-b569-9e5900309981,
 D184D1A0A1014A0D56F8A815F0DE21A15A548AA1) smtp.auth=michaltoma@sicoop.com
X-OVh-ClientIp: 89.91.4.113
From: Michal TOMA <michaltoma@sicoop.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Michal TOMA <michaltoma@sicoop.com>, bcm-kernel-feedback-list@broadcom.com,
 ian.forbes@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Michal TOMA <mt@sicoop.com>
Subject: [PATCH v2 0/3] drm/vmwgfx: Fix dma-buf import leaks and a crash on
 imported BOs
Date: Thu, 10 Sep 2026 18:52:18 +0200
Message-ID: <20260910165221.7558-1-michaltoma@sicoop.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16160885791526768937
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE14sWrx7m374hSunvwVZVkMQdJT1m8+gokp34rQLFtzW5Sa9jZXRf5NOGq/bCeiagz5hrElxgUAK41vhINK3nmhgXCtyziNObQoKyzJSmxCRbl0Brel4OYibN24VzbQDnuWVjUN8aionwXI0KD1pTQ1JunSDCwlqaJVYkxSSgUQkzHTBjLz1EJvXjyQTvOEGv3kI2IRxE/Fp7/AKY32L/c5N1GtOCqWiOO11HYiErQKCalE2jMM2XBwQW4eESxdTAJwbtOCjlC4lUI0xUPF1i9HNBmA+zL4KJBuWlG996FWfIpSLqPSBKgZlg/lpvIP1Pt9c5kGg//TzRFS2XErl2gHkFjHnPn2g1966CtioNNZdj2LzMBZ/4+0Syk49sWWdwrx/o5xsb0X71XS0MihMaKRnSJfk1HtuegaK0Rb52IQghQS5EqJjhT4AjCuCorVEbCuj9RrYyFX5iF023QwIbJht71pOqA5B+5ar5MINwPqpCFPVC3VJ/dqiH9hElau29MIMio3egS/QtlmtRozbXGYJ5FZjykcgzH1EYaDCVoWntTGhJ6/cSjh7p8blxF9JoM3RDLhgGZLoVk0sEb/fAEUzwlsJwMlwcbTUVvMb2c5bBHwfoIowXw/wpZq0laediK/6XlN3xlbh+/r4BibpfcCK6V6CKbfggTshmUQhpvKg
DKIM-Signature: a=rsa-sha256; bh=XsTgs84U0IAxOKk0L+IcUrkWh42l5P9yE0BWfIt9oqM=; 
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789059144; v=1;
 b=kybPoW2M4UIgZJ2dapCIF4ihptGEldhOUI/Hngxx4Y7Otgnrrf7NK39s7hYzdrb0dh0dfOB0
 oVTWk9nF2ux6r+41AzsAEY0XJnF5+chOk0f5xJKMcL7sev4Ew+4YcVUzr1p8sHpYnHbok0eMHo9
 F3mOB9Fy3xd443dD7Sc+8Ozyg9gZdY+ULxQJAXeE8PV3eZqsR/f7Z/7uuuT5S1/Oy/bbcFu4ZKP
 hjR0keEihdIgKyw0NKrcINWegUyY+mjLJiwFYbJTayR04f+H1dkoQSlvO0hKeyyesykJZT5qGrH
 KR3H+qSx/TPw0Uvstt6TukogmX0/aEbelUGakPCq8P1dQ==
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

From: Michal TOMA <mt@sicoop.com>

v1 was a single patch, "drm/vmwgfx: Release PRIME import in the BO
destroy path":

  https://lore.kernel.org/r/20260910142359.13716-1-michaltoma@sicoop.com

Please do not apply that one on its own. An automated review flagged an
interaction with the existing TTM_TT_FLAG_EXTERNAL handling in
vmw_ttm_map_dma(), and it turned out to be real: with v1 applied and
nothing else, an unprivileged render node client can oops the kernel.
That is what patch 1 of this series fixes, and it has to come first.

  1/3 drm/vmwgfx: Don't map or free the exporter's sg_table for
      imported BOs
      Fixes: b32233acceff, Cc: stable # v6.9+
  2/3 drm/vmwgfx: Release PRIME import in the BO destroy path
      (v1, unchanged)
      Fixes: b32233acceff, Cc: stable # v6.6+
  3/3 drm/vmwgfx: Don't leak a GEM handle when referencing a surface
      by fd
      Fixes: d6667f0ddf46, Cc: stable # v6.11+

Changes since v1:
 - new 1/3. Without it, 2/3 turns a silent leak into a NULL pointer
   dereference.
 - new 3/3. It was written before v1 was posted but held back, since
   the two fixes are independent.
 - 2/3 is byte for byte what was posted as v1.

Why the order matters
---------------------
For a TTM tt with TTM_TT_FLAG_EXTERNAL, vmw_ttm_map_dma() points
vsgt->sgt at the exporter's sg_table and then calls
vmw_ttm_map_for_dma(), which maps &vmw_tt->sgt: the inline table, which
for an imported buffer is never populated. dma_map_sgtable() is called
with orig_nents == 0, warns, and returns -EIO, and out_map_fail then
calls sg_free_table() on the exporter's table, leaving sgl == NULL and
orig_nents unchanged.

Today that only corrupts and leaks, because vmwgfx never releases a
PRIME import, so nothing ever unmaps the attachment. 2/3 fixes exactly
that leak, and in doing so makes the exporter unmap the table that
vmwgfx already freed:

  dma_unmap_sgtable(dev, sg with sgl == NULL, orig_nents == N)
    dma_direct_unmap_sg() -> for_each_sg(NULL, sg, N, i)

which dereferences NULL, in the TTM delayed-delete worker.

1/3 is worth having on its own: binding an imported dma-buf has never
worked, it always failed with -EIO and damaged the exporter's table on
the way out. With 1/3 it works.

Reachability, and how this was reproduced
-----------------------------------------
Three ioctls, all DRM_RENDER_ALLOW, as an ordinary user: import a
dma-buf with DRM_IOCTL_PRIME_FD_TO_HANDLE (a udmabuf here), create a
guest-backed surface on it with DRM_VMW_GB_SURFACE_CREATE_EXT
(base.buffer_handle = the imported handle), then submit
SVGA_3D_CMD_UPDATE_GB_SURFACE for that surface with DRM_VMW_EXECBUF.
Validation moves the buffer to VMW_BO_DOMAIN_MOB, which binds the tt.

Without 1/3, with 2/3 applied:

  WARNING: kernel/dma/mapping.c:266 at __dma_map_sg_attrs+0xdd/0x1d0
   dma_map_sgtable+0x1d/0x30
   vmw_ttm_map_dma+0xf6/0x140 [vmwgfx]
   vmw_move+0x1cd/0x2c0 [vmwgfx]
   ttm_bo_handle_move_mem+0xc0/0x180 [ttm]
   ttm_bo_validate+0xd2/0x1d0 [ttm]
   vmw_validation_bo_validate+0xb5/0x180 [vmwgfx]
   vmw_execbuf_process+0x852/0x1330 [vmwgfx]
   vmw_execbuf_ioctl+0x10d/0x1d0 [vmwgfx]

  vmwgfx 0000:00:02.0: [drm] VSG table map failed!

and then, when the buffer is released:

  BUG: kernel NULL pointer dereference, address: 000000000000001c
  Workqueue: ttm ttm_bo_delayed_delete [ttm]
  RIP: 0010:dma_direct_unmap_sg+0x62/0x200
   unmap_udmabuf+0x24/0x40
   dma_buf_unmap_attachment_unlocked+0x46/0x70
   drm_prime_gem_destroy+0x28/0x50
   vmw_bo_free+0x15b/0x1f0 [vmwgfx]

The closing process exits normally, since this runs in the delete
worker; the worker dies holding TTM and dma-resv locks and the machine
wedges shortly afterwards.

With the full series, the same program logs nothing, the execbuf is
accepted, and the buffer is released with no entry left in
/sys/kernel/debug/dma_buf/bufinfo.

Test results
------------
Kernel 7.2.3 on the guest below, comparing modules built from its own
vmwgfx sources, which are identical to drm-misc-fixes for the files
involved.

  import + surface + execbuf + release, as above:
    2/3 only:      WARN, "VSG table map failed!", execbuf -EIO,
                   then an oops in ttm_bo_delayed_delete and a hang
    1/3 + 2/3 + 3/3: no WARN, execbuf accepted, buffer released, no
                   oops, kernel taint unchanged

  PRIME_FD_TO_HANDLE reproducer, 8 x 4 MiB udmabufs (2/3):
    stock:  all 8 remain, count 1, still attached
    series: none remain, with 3D acceleration on and off

  DRM_VMW_GB_SURFACE_REF_EXT(PRIME) from a second render file (3/3),
  each checked while that file was still open:
    udmabuf fd, 8 calls:
      without 3/3: -EINVAL, 8 imports held (count 3), 8 WARNs
      with 3/3:    -EINVAL, nothing imported, no WARN
    dumb buffer fd, 4 calls:
      without 3/3: -EINVAL, 4 stray GEM handles, 4 WARNs
      with 3/3:    -EINVAL, no stray handle, no WARN
    buffer exported before a surface was created on it, 4 calls
    (reaches the changed function and succeeds):
      without 3/3: surface returned, 4 stray GEM handles
      with 3/3:    surface returned, no stray handle
    buffer created together with its surface (a TTM prime export that
    never reaches the changed function), 4 calls:
      unchanged either way

  KWin 6.7.4, 5-minute replay of a terminal workload, 3D on:
    2/3 only:  udmabufs 4 -> 20 (140 MiB), never released, WARNs
    2/3 + 3/3: udmabufs 4 -> 6 -> 4, no pinned pages, no WARN
  (not re-run with 1/3 in place; 1/3 does not touch that path)

Test environment
----------------
- VirtualBox 7.2 (Guest Additions 7.2.16), VMSVGA adapter, 4 vCPUs,
  3.8 GiB RAM. Tested with 3D acceleration on (vmwgfx shader model
  SM_5) and off (Legacy). DMA map mode is vmw_dma_map_populate.
- openSUSE Tumbleweed kernel 7.2.3-1-default. The vmwgfx files
  involved are byte-identical to drm-misc-fixes 4600b4d1a9ee. The test
  modules were built out of tree from those sources, which adds the E
  taint.
- The kernel was already tainted W+O before any test: two boot-time
  warnings unrelated to vmwgfx (arch/x86/mm/pat/set_memory.c:727 and
  kernel/rcu/tree_plugin.h:823), plus VirtualBox's out-of-tree
  vboxguest/vboxsf.
- KDE Plasma / KWin 6.7.4, Mesa 26.2.1.
- W=1 build of drivers/gpu/drm/vmwgfx/ on drm-misc-fixes: no warnings
  before or after. checkpatch.pl --strict is clean on all three.

Not tested
----------
- VMware Workstation or ESXi hosts; only VirtualBox VMSVGA.
- A full kernel built from drm-misc-fixes; only the 7.2.3 kernel with
  modules built from identical vmwgfx sources.
- Kernels with KASAN, lockdep or kmemleak enabled. IGT was not run.
- Stable backports were not built. 3/3 uses
  drm_gem_is_prime_exported_dma_buf(), added in v6.17 (660cd44659a0);
  older trees carrying d6667f0ddf46 would need that helper as well.

Not fixed here
--------------
The review of v1 also pointed out that vmw_prime_import_sg_table()
returns NULL rather than an ERR_PTR when vmw_bo_create() fails, and
that drm_gem_prime_import_dev() only checks IS_ERR() before
dereferencing the result. That is real, but reaching it needs a buffer
object allocation failure; I have not managed to trigger it, so I am
not posting an untested patch for it here.

Classification
--------------
Per Documentation/process/threat-model.rst I am treating these as
regular bugs. The leaks are bounded by the importing process's memory
cgroup, and the crash needs 2/3 applied without 1/3, which exists only
in this posting and in the v1 mail.

Workaround for the leaks
------------------------
KWIN_DISABLE_UDMABUF_IMPORT=1 in the session environment makes KWin 6.7
use its copy path, which avoids the imports entirely.

Tool use
--------
I found the problem because my VM repeatedly ran out of memory and had
to be rebooted. An LLM coding assistant (Claude, Anthropic) did the
diagnostics that traced it back to this code, wrote these patches and
their changelogs, and built the reproducers and the test tooling used
to confirm the results above, including the crash that prompted 1/3.

Michal TOMA (3):
  drm/vmwgfx: Don't map or free the exporter's sg_table for imported BOs
  drm/vmwgfx: Release PRIME import in the BO destroy path
  drm/vmwgfx: Don't leak a GEM handle when referencing a surface by fd

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c         |  3 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c    | 48 +++++++++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 20 +++++++--
 3 files changed, 47 insertions(+), 24 deletions(-)


base-commit: 4600b4d1a9ee730d03ddac5ce409cd2730ce8c0c
-- 
2.55.0

