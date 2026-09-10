Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB86EC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0C110F532;
	Fri, 11 Sep 2026 07:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sicoop.com header.i=@sicoop.com header.b="nVtWOBaH";
	dkim-atps=neutral
Received: from smtpout1.mo539.mail-out.ovh.net
 (smtpout1.mo539.mail-out.ovh.net [51.210.91.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3640610E618
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 16:52:24 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hgkHT4sWrz4FCb;
 Thu, 10 Sep 2026 16:52:21 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <bcm-kernel-feedback-list@broadcom.com>;
 Thu, 10 Sep 2026 16:52:21 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.201])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hgkHT3lz0z6Ntd; Thu, 10 Sep 2026 16:52:21 +0000 (UTC)
Received: from sicoop.com (unknown [10.1.6.7])
 (Authenticated sender: michaltoma@sicoop.com)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 828AD1B4403C;
 Thu, 10 Sep 2026 16:52:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0075acc4155-acff-4418-ad16-683ae0a87b58,
 D184D1A0A1014A0D56F8A815F0DE21A15A548AA1) smtp.auth=michaltoma@sicoop.com
X-OVh-ClientIp: 89.91.4.113
From: Michal TOMA <michaltoma@sicoop.com>
To: sashiko-bot@kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: Michal TOMA <michaltoma@sicoop.com>, bcm-kernel-feedback-list@broadcom.com,
 ian.forbes@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Release PRIME import in the BO destroy path
Date: Thu, 10 Sep 2026 18:52:19 +0200
Message-ID: <20260910165219.7542-1-michaltoma@sicoop.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910150035.788AF1F000FF@smtp.kernel.org>
References: <20260910150035.788AF1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16160322842110546236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF6pX5vpcS80JPTmqNLuphRsGggG7qnKK0W447olTa8x18xHywiZHYwydWM01Edd3/niP30dpypJk6tKYscP/iVZhW5lCbcZYPL/wCEgEKOD1gltMXAM9TrNqpjqxvW1DMOF/22a1MsuLQGdr7sp0Mt33UVLr1ITPXP6K2OdH7uLpjzOitg93bjz2Rb7LBHnNbr3CtsPP2g+YZqf4GKSyCLkt+AZADNZi9Wa9W1cPItB0C2ynbvLozOHyMUch2H9RsfsyWbGkTRHomPIsz6OhkaUdZLiu4DPVZ6Y3ji2Bf1A5Gabwar3DpGf4/zDdSwIgn4zZBK4uC3k5XJm0wKqbg/NgnE7MySnY0afWpLJ7PT+pSrq9fwOC5eZmQZdJQT0HRGazJJCCn16If3Hq5zUacuJutsdhY8Ea0DDgaECNQFzZg4jNDuMnVO+icN0fl/lWUK28hjJ2DO8HSXL+b3OWO+MGHYdS4CwQ1oig3FuGVr505+UAZN109ajHXBQBtENPVIMsU0M+gTiagewmTSzzHLharV/A1ht9DHp1tg7TfIs/8d7P5/8fKJpQlm04BnDglN50JvfZO5vP+9gzEhioKqOs+/lHwu+QxhTXWFgq50AIVMTGqd2RsHQ+TYN26VYUa6lDsw/Ap1aJ3Lyzfl7FoCjK6mqbHjjUXaL+ICnWhThw
DKIM-Signature: a=rsa-sha256; bh=zb+8StDB0wlJEo55QkYEs4giHU7INXOi+GpJyXdAHy4=; 
 c=relaxed/relaxed; d=sicoop.com; h=From; s=ovhmo62391-selector1;
 t=1789059142; v=1;
 b=nVtWOBaHAAcOKF2ivFxsHYG5bvZ9P+F32khHW5wMlWw/IAh8wN18KJFVNtlt4Z61rtXCdInI
 38fIzK9xXg314SflNg3zGMG0yY0n2sO6hHsEoY3QxESdm30oTRLdxYxvWUm2WrIgKsmJfTHK2LJ
 P3i8OdXlKnHfNAREdK0QctQjWjp4vf2+ZNCb4t3ijowL2mCiPulQxotksMEuqrjFHVJqv+1bnuj
 PFPAu4REzY/UwsPHsNCLpktnnxf+7h3N40DzqyXyP1dMPJ0DC+DUawdEaCL+0RaaKPy3xU4DONR
 4UPZrzk8ZH9a2eX7GUkvtIB0KksBtov57zj9Z00tDSL2Q==
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

On Thu, Sep 10, 2026 at 03:00:34PM +0000, sashiko-bot@kernel.org wrote:
> - [High] Double free of the exporter's sg_table triggered by combining
> the newly added drm_prime_gem_destroy() with a pre-existing incorrect
> error path in vmw_ttm_map_dma().

Thanks - this is real, and it means the patch as posted must not be
applied on its own. I reproduced it on the affected guest. The
mechanism differs a little from the one described, and the outcome is
worse than a double free: it is a NULL pointer dereference in a TTM
workqueue, which wedged the machine.

Corrected mechanism
-------------------
sg_free_table() sets table->sgl = NULL but leaves table->orig_nents
alone, so the second sg_free_table() from the exporter is in fact a
no-op. The crash comes one step earlier, in the unmap:

  drm_prime_gem_destroy()
    dma_buf_unmap_attachment_unlocked()
      udmabuf unmap_udmabuf() -> put_sg_table()
        dma_unmap_sgtable(dev, sg, ...)
          dma_unmap_sg_attrs(dev, sgt->sgl = NULL, sgt->orig_nents = N)
            dma_direct_unmap_sg() -> for_each_sg(NULL, sg, N, i)

which dereferences NULL on the first iteration.

Why vmw_ttm_map_dma() fails for every imported buffer
-----------------------------------------------------
For TTM_TT_FLAG_EXTERNAL, vmw_ttm_map_dma() points vsgt->sgt at the
exporter's table:

	if (vmw_tt->dma_ttm.page_flags & TTM_TT_FLAG_EXTERNAL) {
		vsgt->sgt = vmw_tt->dma_ttm.sg;
	} else {
		vsgt->sgt = &vmw_tt->sgt;
		ret = sg_alloc_table_from_pages_segment(&vmw_tt->sgt, ...);

but then calls vmw_ttm_map_for_dma(), which maps &vmw_tt->sgt - the
inline table, not the one vsgt->sgt points to. For an imported buffer
that inline table is never populated (vmw_ttm_tt_create() kzallocs the
vmw_ttm_tt), so dma_map_sgtable() is called with orig_nents == 0,
trips the WARN_ON_ONCE in __dma_map_sg_attrs() and returns -EIO. Then
out_map_fail calls sg_free_table() on the *exporter's* table.

That path is therefore taken on every attempt to bind an imported
buffer object, not only in some rare error case. vmw_ttm_unmap_dma()
would free the exporter's table too, if a map ever succeeded.

Note also that the exporter has already DMA-mapped that table for our
device in dma_buf_map_attachment(), so vmwgfx should not be mapping it
a second time at all.

Reachability
------------
An unprivileged process with access to the render node can get there
with three ioctls, all DRM_RENDER_ALLOW: import a dma-buf
(DRM_IOCTL_PRIME_FD_TO_HANDLE, e.g. a udmabuf), create a GB surface
backed by that buffer (DRM_VMW_GB_SURFACE_CREATE_EXT with
base.buffer_handle set), then submit SVGA_3D_CMD_UPDATE_GB_SURFACE for
that surface with DRM_VMW_EXECBUF. Validation moves the backing buffer
to VMW_BO_DOMAIN_MOB, which binds the TTM tt:

 WARNING: kernel/dma/mapping.c:266 at __dma_map_sg_attrs+0xdd/0x1d0
 Call Trace:
  dma_map_sgtable+0x1d/0x30
  vmw_ttm_map_dma+0xf6/0x140 [vmwgfx]
  vmw_move+0x1cd/0x2c0 [vmwgfx]
  ttm_bo_handle_move_mem+0xc0/0x180 [ttm]
  ttm_bo_validate+0xd2/0x1d0 [ttm]
  vmw_validation_bo_validate+0xb5/0x180 [vmwgfx]
  vmw_execbuf_process+0x852/0x1330 [vmwgfx]
  vmw_execbuf_ioctl+0x10d/0x1d0 [vmwgfx]
  drm_ioctl_kernel+0xa6/0x100
  drm_ioctl+0x2ad/0x590
  __x64_sys_ioctl+0xb9/0x100
  do_syscall_64+0xe1/0x610

 vmwgfx 0000:00:02.0: [drm] VSG table map failed!

execbuf returns -EIO, but the exporter's sg_table has already been
freed. Releasing the buffer afterwards, with my patch applied:

 BUG: kernel NULL pointer dereference, address: 000000000000001c
 Oops: 0000 [#1] SMP NOPTI
 Workqueue: ttm ttm_bo_delayed_delete [ttm]
 RIP: 0010:dma_direct_unmap_sg+0x62/0x200
 Call Trace:
  unmap_udmabuf+0x24/0x40
  dma_buf_unmap_attachment+0x43/0x80
  dma_buf_unmap_attachment_unlocked+0x46/0x70
  drm_prime_gem_destroy+0x28/0x50
  vmw_bo_free+0x15b/0x1f0 [vmwgfx]
  process_one_work+0x19f/0x370
  worker_thread+0x1b1/0x310
  kthread+0xe4/0x120

Since this runs in the TTM delayed-delete worker rather than in the
caller, the closing process exits normally and the worker dies holding
TTM/dma-resv locks. The desktop wedged a few seconds later and the VM
had to be reset.

Without my patch the same sequence only corrupts and leaks the
exporter's mapping, because nothing ever unmaps the attachment - which
is exactly the leak I was fixing. So the patch does not create the bug,
but it does turn it into a locally triggerable crash.

What I intend to send
---------------------
Please do not apply the posted patch as it stands. I will send a
series instead:

  1) fix vmw_ttm_map_dma()/vmw_ttm_unmap_dma() for external TTM tt:
     use the exporter's already-mapped sg_table as-is, and never map,
     unmap or free it. Fixes: b32233acceff ("drm/vmwgfx: Fix prime
     import/export")
  2) the drm_prime_gem_destroy() cleanup posted here, unchanged
  3) a second leak that was ready but held back: the GEM handle
     vmw_buffer_prime_to_surface_base() creates for the fd passed to
     DRM_VMW_GB_SURFACE_REF_EXT is never returned to userspace and
     never deleted. Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of
     dumb buffers")

The other point in the review, vmw_prime_import_sg_table() returning
NULL rather than an ERR_PTR when vmw_bo_create() fails, is real as
well. I am leaving it out of the series: it needs a buffer object
allocation failure to reach, I have not managed to trigger it, and I
would rather not post a patch I could not test. It is called out in the
cover letter.

The proposed 1) looks like this; I will post it with test results:

@@ vmw_ttm_map_dma()
 	case vmw_dma_map_bind:
 	case vmw_dma_map_populate:
 		if (vmw_tt->dma_ttm.page_flags & TTM_TT_FLAG_EXTERNAL) {
+			/*
+			 * The exporter has already mapped its sg_table for
+			 * this device in dma_buf_map_attachment(). Use it
+			 * as-is; it is not ours to map or to free.
+			 */
 			vsgt->sgt = vmw_tt->dma_ttm.sg;
-		} else {
-			vsgt->sgt = &vmw_tt->sgt;
-			ret = sg_alloc_table_from_pages_segment(...);
-			if (ret)
-				goto out_sg_alloc_fail;
+			break;
 		}
+		vsgt->sgt = &vmw_tt->sgt;
+		ret = sg_alloc_table_from_pages_segment(...);
+		if (ret)
+			goto out_sg_alloc_fail;
 		ret = vmw_ttm_map_for_dma(vmw_tt);

@@ vmw_ttm_unmap_dma()
+	if (vmw_tt->dma_ttm.page_flags & TTM_TT_FLAG_EXTERNAL) {
+		vmw_tt->vsgt.sgt = NULL;
+		vmw_tt->mapped = false;
+		return;
+	}

I have 1) built and tested here. With it, the reproducer above logs
nothing at all: no WARN_ON_ONCE(), no "VSG table map failed!", and
DRM_VMW_EXECBUF is accepted instead of returning -EIO, so an imported
buffer object can now be bound at all. Releasing the buffer afterwards
leaves no entry in /sys/kernel/debug/dma_buf/bufinfo and no oops, and
the reproducers for the two leaks from the original posting still
behave as they did.

The reproducer for the crash above, and the ones for the two leaks, are
small C and Python programs; each is included below the cut of the
patch it belongs to in the series.

The analysis and the reproducers here were produced the same way as
described in the tool-use note of the original patch.
