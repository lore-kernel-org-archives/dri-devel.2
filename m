Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0923ACA5FED
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5199510E15A;
	Sat,  3 Oct 2026 16:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R6hMQC1r";
	dkim-atps=neutral
Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com
 [74.125.231.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA7910E15A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 16:39:02 +0000 (UTC)
Received: by mail-oo2-f40.google.com with SMTP id
 46e09a7af769-822f7e70796so712146a34.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791045541; x=1791650341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TKJeZ90AHzCg5KqCt7ePHWHr6buLXihZVRjmawQi7xU=;
 b=R6hMQC1radHq8cy9uDmgIrfDeOWCj7gCYPPgZJPWxboqxgAEclUMZ9Jd+b74Jjb6pj
 sqD6FsFPV5pHbCgguQfLfSlN68IyrUx4Zk6LetW0Zv4BTZrPZubKXlyC2UwSgu8DLwsD
 DZaN07gl9HGFnsh+eJhRD5ViVTf+tFIa3f03ZdzmNDPAbmvYsr0oiEk1MOGjtldiuqtk
 ZHDmgUhmMqenCNMfFBRcI5Xm1eSS1Wu+QHB0SNoEGDn9rnEqLcgTBzFfYR3+iam03zYh
 SHIk4ec5KZaFzIYTXCfjLS9L+8mKICY4deBcy/S1M7hotu1iwpTrBMcrtJWDwAnyM8+g
 +lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791045541; x=1791650341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TKJeZ90AHzCg5KqCt7ePHWHr6buLXihZVRjmawQi7xU=;
 b=DzNXEk0IeNHJtysR9aDnhyENPkOgsPYAgCOwRrV92PMlsABHXslWsyIk2iB3Mg/uyC
 hY7AKYuWNjybx/d2FWudN5AuxukB1qaPVHapeYRVJaxvnazLKRH0zA9Bpp3zkWpRhur3
 pWxopC8+x9S4BQfkCpVS1sBoUA+QvhZIUM58bGsYJuI8KyWwaj5BjwMPevqjxqO3PNK0
 uk/NnbjL+ZRnYDjmgrHz2qc2NMoefyvP7PouZLLgtlpI6Mh5P+TxO3g5ka4BOFMnj4zv
 GGO6xVSbDJbtA6OjMHYZrGHdDW5btqmXXSAIkmhin3XxQmCrk2MmIAUxG+jzH5mH728b
 55dQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByk3BLqW00K0sRJqYVKWQPJ2hz08idd0x8eE3+e9o1xin6Ob0l6+9GFeGAkylby0GpqEXGiGSpu8L4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxdcOnMZZzH0hLULLytDvZCzfPTT4HoWJNXdxZ9Eff+PQZzLuP
 1rFbuCzYkkqQhVFEmCiPOVjoH74iFcUALL/34RAYSoI6AESaTV0Gbjfi
X-Gm-Gg: AYBFou2cyMYdYYm5W6ToCGc9QomkFiM6Y0/O9F8GMKwaF8GnKQkB4qia55fhZrUFdJk
 Zme/NMigi17VnsQyYr5UFkOy4HJyLWRvODbxEHbPaH0PDKamMwQsw0atnPupN17vI51WXkwbSHL
 y62Zd6oMyhG3+tXvZ+HGQRrZW00AF630V4fNKWHDY7vadguDzsb9HiJQ14tPSkuch+CJKVNy7Jp
 aTDtzqEFMY1d7Wo65sRxhsNwi3jkqC7ZpS4wX7QX8Nq/zlrTfBdV4LTDor4RWjb5em78QtvGjw9
 LWWkbCG44uv7Qr7+s1QSLxmrYGiY8vkoPjeh+0jxNVj2KauBdxS2caDkd12Gx9Ex05w69AHQ/mA
 y8YpIChuRRTpIvHerGh1fF9zzpREkDrm9azRsCLivypgvX3RLoLwz0OKOc3Ipa16eHb5sIlQQvs
 tjwdYYkJDZb6NTQ6aXukP1OSWiUscKfSYC2WITTk92EmAQeqes+IkNJXdwcWGXIj8=
X-Received: by 2002:a05:6830:438d:b0:80c:d34f:5f63 with SMTP id
 46e09a7af769-82283671cc3mr6660679a34.28.1791045541448; 
 Sat, 03 Oct 2026 09:39:01 -0700 (PDT)
Received: from beelink.. ([187.14.126.14]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8227aa6cdf1sm6723839a34.26.2026.10.03.09.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 09:39:00 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: maaz.mombasawala@broadcom.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
Date: Sat,  3 Oct 2026 13:38:50 -0300
Message-ID: <20261003163851.2257947-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
References: <DLUS51Y9OLMS.UQR4UY71TFUP@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Maaz,

Thanks for testing.

I think the reason you could not reproduce is that the original PoC
opens two fds to the same vmwgfx render node.  When the importer
and exporter are the same device, drm_gem_prime_import_dev() hits
the drm_gem_is_prime_exported_dma_buf() check (drm_prime.c:976):
it sees dma_buf->ops == drm_gem_prime_dmabuf_ops && obj->dev == dev,
and returns dma_buf->priv directly without attaching or mapping —
so drm_gem_unmap_dma_buf() is never reached and the kfree never fires.

To hit the invalid-free, the PRIME import must go through a
different DRM device (e.g. virtio-gpu) so the full attachment
map/unmap path is taken.  In addition, the BO must be bound to a GB
surface before the import, so that vmw_ttm_map_dma() runs and
caches vsgt.sgt = &vmw_tt->sgt (the embedded member).  Without the
bind, the TTM is not DMA-mapped and get_sg_table falls through to
drm_prime_pages_to_sg(), which allocates a fresh table — no bug.

With an updated PoC that uses a second GPU for import and binds the
BO first, I was able to reproduce on mainline 7.3-rc4 (6edd14dd67d7):

  BUG: KASAN: invalid-free in drm_gem_unmap_dma_buf+0x6b/0x80
  Free of addr ffff888103c34e60 by task poc_mm04_attack/242

  CPU: 2 UID: 65534 PID: 242 Comm: poc_mm04_attack Not tainted
       7.3.0-rc4-g6edd14dd67d7-dirty #8 PREEMPT(lazy)
  Call Trace:
   <TASK>
   kasan_report_invalid_free+0xb8/0xe0
   check_slab_allocation+0xf5/0x100
   kfree+0x163/0x510
   drm_gem_unmap_dma_buf+0x6b/0x80
   dma_buf_unmap_attachment_unlocked+0x72/0xc0
   drm_gem_prime_import_dev+0x1f5/0x260
   virtgpu_gem_prime_import+0x328/0x580
   drm_gem_prime_fd_to_handle+0x116/0x370
   drm_ioctl+0x3d4/0x790

  Allocated by task 242:
   vmw_ttm_tt_create+0x4c/0x130
   ttm_tt_create+0xca/0x190
   ttm_bo_handle_move_mem+0xea/0x270
   vmw_bo_create+0x248/0x3c0
   vmw_gem_object_create_ioctl+0xa1/0x1a0

  The buggy address belongs to the cache kmalloc-192 of size 192
  The buggy address is located 96 bytes inside of
   160-byte region [ffff888103c34e00, ffff888103c34ea0)

Setup:
  - QEMU with -device vmware-svga -device virtio-gpu-pci
  - Kernel: 7.3-rc4, KASAN, CONFIG_DRM_VMWGFX=y
  - Three local-only changes to make vmwgfx probe on QEMU:
    1. pitchlock error return bypassed (hardware capability
       check, not security-relevant — VMware real passes it)
    2. SVGA_CAP_GBOBJECTS forced (QEMU does not advertise it;
       VMware real does)
    3. max_mob_pages/max_mob_size forced to 256 MB (QEMU
       returns 0; VMware real provides real values)
    None of these touch the PRIME export/import path or the
    sg_table ownership code.
  - DMA map mode: vmw_dma_map_populate (line in boot log:
    "DMA map mode: Caching DMA mappings")

Steps (runs as uid 65534):
  1. DRM_VMW_ALLOC_DMABUF(262144) on vmwgfx renderD128
  2. DRM_IOCTL_PRIME_HANDLE_TO_FD
  3. DRM_VMW_GB_SURFACE_CREATE 256x256
  4. EXECBUF BIND_GB_SURFACE(sid, mobid=handle)
     -> vmw_ttm_bind -> vmw_ttm_map_dma
     -> sets vsgt.sgt = &vmw_tt->sgt  (embedded, vmw_dma_map_populate)
  5. DRM_IOCTL_PRIME_FD_TO_HANDLE on virtio-gpu renderD129
     -> dma_buf_map_attachment -> drm_gem_map_dma_buf
        -> vmw_gem_object_get_sg_table returns &vmw_tt->sgt
     -> virtgpu_gem_prime_import_sg_table fails with -ENODEV
        (no blob resource support in this QEMU config)
     -> error cleanup: dma_buf_unmap_attachment_unlocked
        -> drm_gem_unmap_dma_buf: sg_free_table + kfree(&vmw_tt->sgt)
     => KASAN: invalid-free (interior pointer of vmw_ttm_tt)

I also found a second, related bug in the same function.  When
testing without the GBOBJECTS/MOB patches (i.e. vanilla QEMU where
BOs go to VRAM only), vmw_gem_object_get_sg_table() does
container_of(bo->ttm, ...) without checking that bo->ttm is
non-NULL.  Without MOB, the BO stays in VRAM and no TTM TT is
ever allocated, so bo->ttm is NULL and the dereference faults:

  BUG: KASAN: null-ptr-deref in vmw_gem_object_get_sg_table+0x2f/0xa0
  Read of size 8 at addr 0000000000000088 by task poc_sgtable/330

  CPU: 0 UID: 0 PID: 330 Comm: poc_sgtable Not tainted
       7.3.0-rc4-g6edd14dd67d7-dirty #7 PREEMPT(lazy)
  Call Trace:
   vmw_gem_object_get_sg_table+0x2f/0xa0
   drm_gem_map_dma_buf+0x79/0x120
   dma_buf_map_attachment+0xc1/0x4f0
   drm_gem_prime_import_dev+0xe0/0x260
   virtgpu_gem_prime_import+0x328/0x580
   drm_gem_prime_fd_to_handle+0x116/0x370

  Steps:
    1. DRM_IOCTL_MODE_CREATE_DUMB on vmwgfx (64x64x32)
    2. DRM_IOCTL_PRIME_HANDLE_TO_FD
    3. DRM_IOCTL_PRIME_FD_TO_HANDLE on virtio-gpu
    -> NULL pointer dereference at offset 0x88

I have both PoC sources and the full KASAN/dmesg logs ready.
Regarding Zack's request for igt tests: I have not written those
yet but plan to include them with v2.

Would you like me to send v2 as two patches (1/2 NULL-check,
2/2 embedded sg_table fix) in this same thread, or do you prefer
the NULL-deref fix as a separate submission?

thanks,
Aldo
