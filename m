Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773F606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUA8XUC1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8EF10ED34;
	Wed,  4 Nov 2026 08:58:05 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE0B10F939
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:09:13 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-7c03744ef27so30735137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793758152; cv=none;
 d=google.com; s=arc-20260327;
 b=BUmRahWHY8VV+6VZFrHCLhdQVAZvW6gKtOj8CWIm2S5wqpApSNKrJtdJkWO5iKxaOI
 FcrIs84UbE7tNaSqnwr2bWRxsDDJL2AbBDqLfUt/ZgS4GfIAJ0MEKDj0bNjlu+Lcz6YP
 PrD3AcSel6EmeB7mY6DNs4EN7tDerhakFdA/KDXZOh3zUn+xua4B8ybKvS2a8kEQQszV
 kfSg4/0dIV192GZD09uxQEFkY01x2V3D/cIHwsGStsz9ynEqwrWS+u+5ZODrXk6dFDZQ
 X5rNokmPPNn6Pyi3NuySIX+FulTlhYAMdTalueXytbwf9Ip8mW6JLJEoTcz7vrMGzA6O
 ni7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=wdNKaEpkHidcE5D48p4g2g5pEIMu8tMTclDfHdiVVm0=;
 fh=W9ubnprjfhhnj+18819S5RuqFQUcwyy476l5eFBuzds=;
 b=J0uw07P7S+sS9A0jRvGDtBhN3lf2DLG6nkDvca3H+LmkGJ3SFLKGKUvVG38dR/S8Yv
 UogkQuM9mzFzoxqmb8zpCjBt2o2I28gSsWl2/FpzRZJr5O9zCghJSOt31M/wvzQTzY92
 CH0+Pgiu9Tnh+xYN5XNGIkWCioyE4TQdlHzWN0UChXRjmWP169spNxPRdgb8kaDrHn+B
 JOFHdQcMPe0chHc69kHo/vUFB8ykQeWkiFNUTavjftiOUUXoifZD9ouGL+zXvhsD/cdY
 YlNyTHeiI/ybcGVNkdY1HDD1MU0Qx8EATQFHwRGs2j3KkWtddSCf8xKJdQiQL2rveXYK
 V6AQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793758152; x=1794362952; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wdNKaEpkHidcE5D48p4g2g5pEIMu8tMTclDfHdiVVm0=;
 b=mUA8XUC1j0r0i8i0s7FTjOXdSIijRiVd1tIgjm3In6a3FVKlyeKJWQ+/6jNFq7VxZ4
 RDKzaWqxk34T+B7NMT1Ir92L3/3/keS+AoZjhZmdZXJooeeToSU8kQY0syr87fYJk24c
 DvlSGTIVBcQlOCjgd+J0611oizc6M98iL0I13UOCh5CcnAXroLk8yVPKa2VC33b/6LzI
 hbXQ3zBYR7at9GdhI4jvh1SeQE0oH54VuPxKnXgV1FbZX1YQLpkS0kdfD5FehJLL1tzF
 B0yDWQcUgqLaKqZBAgWANZnuaZNx4sBivES4IUqNf3yY8YkNJ35/3MrutHGiDNH3RjyD
 6YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793758152; x=1794362952;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wdNKaEpkHidcE5D48p4g2g5pEIMu8tMTclDfHdiVVm0=;
 b=jfGs8ZzVhrF/AgwviqIUYnermWqJyeS6uZ0IwLLY/5qxdPH45RbDLmPN8AXkAIXY97
 u3iAoR7R+WXjk+StRaG8kHk5L+617JVWke/p08XZsi+6DcDzSc2ffzFpppgbhHqN7qma
 ILFEMYS4cSelZLUPc09TpNNFUVvqzP6y4CY20ggIKeyK6rfeZfEdf0N+pVUvUVvnD6Nn
 cIy9pWqveYh989FQjH83qSHD9OuX6zEAIK/4HSSljwHRmk8EG+41nA6w1bpHiHzvdv0E
 jitk2Ji+q7rexsJERSIuUme8+9Grkbkk0ssDfszpMq6qHsLxWryOFi7qPc5aXBWy3BdQ
 335A==
X-Gm-Message-State: APuU4Z85s6h1xLU26Q2u5P2LZ1rOilmKNhm1waivmtVzni5n1p0KNRvN
 BFc6GKh9/fPSg1cpC2+FS23RcsAQnfmy6n5uuvImYNlibKNgAgX5sjKNsablL/VwFeGsfWJTp5/
 G9Hus6D6LUMTkfZ2UxHrvpMndbElWh38=
X-Gm-Gg: AYBFou1fum/l/88iX0QHJHINruTeevxQ+X4k8n6ZqaQZPHh147NGbHPBc6jYlPy7/bi
 aGDcp/K1WS5Wnddqs+SAK9RUKfyZpEEc55AOyJ/zY0kk0VPZ3Yr2LbDHMPRcMq7i3vzyvJ6q0Y+
 q1I1HtgHgNkUxovC6Bm6J2IoGSd5Wz6ZUm5BARX4iRUWeOjy+Om3C9zswt+EfEFkgqQTT3Ju/jd
 04EeLGzHTZyEM/3tfONI7h/+3YpA/Dot4v2DDhz8vQIzT+vlcBembseXUOdMpfU4wz1zI9lN/l4
 i0dbbkIUt2lJR0PIuQmW7HHTjDgU0y8xH2WGVzhq/E6BOCw7c7FmlftbQfWmKszm3gM169WEhwT
 KCWF8F9pSUXg+WsG8q12figSoG7vnKsaJZSeE
X-Received: by 2002:a05:6102:4413:b0:7ca:e2c1:9a09 with SMTP id
 ada2fe7eead31-7d0726d358amr4131982137.20.1793758151843; Tue, 03 Nov 2026
 18:09:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Giulio Malitesta <atsetilam@gmail.com>
Date: Wed, 4 Nov 2026 03:09:00 +0100
X-Gm-Features: AclHuK82eVrDulfR_7MB913QuNE2CnTpTIrVmDhYtKUFGnbhqUjhNSAzk9GFVUI
Message-ID: <CAM0DsqVFH-wt+q8yZdq67unXAzXRAq90KDDLoRY5d-X87DNxeQ@mail.gmail.com>
Subject: drm/appletbdrm: kvzalloc'd request buffer can be rejected by USB DMA
 mapping
To: admin@kodeit.net, aditya.garg@linux.dev
Cc: dri-devel@lists.freedesktop.org, tzimmermann@suse.de, k@chaosmail.tech
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I'm not a developer, so please take this as a user report. The problem
was found and analysed by Claude (an AI assistant) on my machine: it
read my kernel log and the driver source, and I'm passing on what it
found in case it's useful. I can't judge the code myself, and no fix
has been tested.

Hardware: MacBookPro16,1 (2019, T2).
Kernel: 7.2.11 from t2linux (linux-t2 on Arch). It is tainted: it uses
the out-of-tree t2bce USB stack, and my own modified amdgpu and
apple-gmux modules. The trace below goes through t2bce, so I can't
rule out that it plays a part.

On each of the last four boots that lasted more than a few minutes,
the log shows this warning once:

  t2bce_core 0000:04:00.1: rejecting DMA map of vmalloc memory
  WARNING: ./include/linux/dma-mapping.h:523 at
    usb_hcd_map_urb_for_dma+0x524/0x580, CPU#0: listello-core/1983
  Call Trace:
   usb_hcd_submit_urb+0x321/0xad0
   usb_start_wait_urb+0x9f/0x230
   appletbdrm_send_request+0x67/0xb0 [appletbdrm]
   appletbdrm_primary_plane_helper_atomic_update+0x2d8/0x350 [appletbdrm]
   drm_atomic_helper_commit_planes+0x114/0x330
   ...
   drm_atomic_helper_dirtyfb+0x221/0x320
   drm_mode_dirtyfb_ioctl+0x1ef/0x240

and then, repeatedly:

  appletbdrm 7-6:2.1: [drm] *ERROR* Failed to send message (-11)

That error appeared 5274 times during one session of about 11 days, in
short bursts of up to about 20 per minute. Only the first occurrence
produces the warning, since it is a WARN_ONCE, so it's an assumption
that the later errors have the same cause.

The likely cause: commit aaaa684bab1f ("drm/appletbdrm: Use kvzalloc
for big allocations") allocates the request buffer with kvzalloc().
When memory is fragmented, this can fall back to vmalloc, and that
buffer then goes to usb_bulk_msg(), whose DMA mapping refuses vmalloc
addresses. The same concern was raised by an automated review of that
patch in April, and I couldn't find a reply to it:
https://lore.gitlab.freedesktop.org/drm-ai-reviews/302f22e3-5390-4c0a-aa06-bfd02a3175c0@suse.de/t/

The kvzalloc() call is still present in current mainline (7.4-rc1), in
appletbdrm_primary_plane_helper_begin_fb_access(). I haven't run
mainline on this machine.

The impact seems small: I haven't noticed anything on the Touch Bar,
and the machine stays stable. Presumably a frame is lost when this
happens, so the bar could show stale content until its next redraw.

That automated review suggested kzalloc() with __GFP_RETRY_MAYFAIL, or
usb_alloc_coherent(), as alternatives. I can't say whether either is
right, but I can test a patch on this machine if that helps. I may
need some guidance, and I'd also be using Claude for that.

Thanks for your work on this driver,
Giulio Malitesta
