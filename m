Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DEFCD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0737F10F22E;
	Thu, 21 May 2026 07:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFYxBjQL";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A967B10F22E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:09:59 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45ea19f412aso394360f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779347398; x=1779952198; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q3/xpxUO6thsRAszOIsZ6+lXY5oUjTLCyWKPqe1vTLg=;
 b=cFYxBjQLd0ILnV3kTWcRlWJB4H1yFq04lkiwGFaXub84bdKukpwwOBapKtIAAzZD77
 AttvIwNnUNl/dAloXCh8gRdkNylVQ/in7Ko/O0RHNIC/4ZL0Ym8rxqL9KAgiuoBYniOO
 C9hZ2v2Y/ooNJLdWYQelH42TyLfOvQonXUhlbXys/gNpQijv0++gF3IeTyHBhQHHYF8O
 HeP+9VOGp6u8DZUA1rsRXrDJx2aT1o5JyWlkuPzDuml0LIGJ2Kx7yjcYycPWNm7h2CFp
 /OOquWoiLwKbdxuohNIn/6xA5QxQ0L+EwK+iUOKWFhF/d57exqy6E9FGABlAAKJDJjfp
 n72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779347398; x=1779952198;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3/xpxUO6thsRAszOIsZ6+lXY5oUjTLCyWKPqe1vTLg=;
 b=DEQYdKBnhH22Q6yVXSJ7bgo/cPe682Qg8P+YqGDdwa3yVGYnPEXoRlUz8eARbzicBr
 DJgCib3fKuP2khIfWZh3HUPSZg2q4vLIQNiZt+32tNZQi1TLmMjcJQRzz9O9DQIN5aaE
 KqNQRyqbfZrCc8Qbh3GUnhFaWpjjqASvcXphW/aDhN0KgVRJbaVZmfCaHmD8PQdnVw51
 4r7UrO9z/auCDgbHwnmH+nttQyaBQpYQhxAvnHC4MVOTiXT7BBtYZCXaKHkM1FM/9esC
 IiZKc65EftoPWcTk7gwPnpmbsvNybR32MXS0HTvQxeiNhhqNz+NkJcOYr2CtVydpikLv
 fMLw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gvzx07fS9zsDI1reP45V/LjB6PS76LRH+D05ypTr4ZG4eCFDvFgB0Mmz9CJPHXFEM1/qfTcSop5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM6Jof+SPwl3yNzrDvFdzESa7vkYn5aXTyuWh9d53/OBDu/YDo
 ZF0HuDvPHyPswfZqD8FuMooZVF4uzejbG9zjKul0sDAuYXng4A890S17
X-Gm-Gg: Acq92OG0DbemmkE4DqZ1NQmEymY8cGZqyinkWtdvTXGnblZkCwP9allGqDLrpKw1Wlw
 pZ6Nn/6EutmyKeIxrJjk+wzeSgZR8xksXoY5Xqrm2slIlwQRgymYCFECsu2GK4lZEcziveo2N+R
 3J7cx+HElgDqcIMpASlGZeDtlFVO9LcSmFXHM+H36KtbOY8OstndXJML4/WbeU5ds3LTh9Ee8fL
 04Ypgso7hFZLE+VOXGshHJdBt3SnHKSVVOg35gJXo8UbpeRDmWyabITBaPuyVqmzMs0Ya98W8SJ
 NEDFXkgfarvyqHlLughd+Q1VlFsRfK37RRhC4uUPr07Rv0WiDzTmKyOVrkLwd8C0e+rDoESANGV
 2pOwb+ya72m0JWa7b9FqCESXlBz6MaK6cDKWW+vTuL7Rxr0Yu20zU2s98SrhmoIx0zFQBG5As7z
 /7QJgTe97q2ocDq+4KqrUduaI=
X-Received: by 2002:a05:6000:1ac7:b0:454:a41f:d082 with SMTP id
 ffacd0b85a97d-45ea3ae5fdfmr2355942f8f.3.1779347397866; 
 Thu, 21 May 2026 00:09:57 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cf58fsm850498f8f.3.2026.05.21.00.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 00:09:57 -0700 (PDT)
Date: Thu, 21 May 2026 10:09:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: FOP_UNSIGNED_OFFSET abuse
Message-ID: <ag6vwpcCBN_VC1dm@stanley.mountain>
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

Is there a point to FOP_UNSIGNED_OFFSET now that everyone is on 64bit?
I thought the flag was for back in the day where we it was a huge deal
to access 4GB instead of 2GB.

It's mostly used in DRM.  drm_open_helper() forces you to set the flag
but drm_read() ignores the offset so I don't understand the point of
this.

regards,
dan carpenter

$ git grep FOP_UNSIGNED_OFFSET
drivers/accel/amdxdna/amdxdna_pci_drv.c:        .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/char/adi.c:     .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/char/mem.c:     .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/adp/adp_drv.c:  .fop_flags      = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:        .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/drm_file.c:     if (WARN_ON_ONCE(!(filp->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
drivers/gpu/drm/gma500/psb_drv.c:       .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/i915/i915_driver.c:     .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/nouveau/nouveau_drm.c:  .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/panthor/panthor_drv.c:  .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/radeon/radeon_drv.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/tegra/drm.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:    .fop_flags = FOP_UNSIGNED_OFFSET,
drivers/gpu/drm/xe/xe_device.c: .fop_flags = FOP_UNSIGNED_OFFSET,
fs/proc/base.c: if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
fs/proc/base.c: .fop_flags      = FOP_UNSIGNED_OFFSET,
fs/read_write.c:        return file->f_op->fop_flags & FOP_UNSIGNED_OFFSET;
include/drm/drm_accel.h:        .fop_flags      = FOP_UNSIGNED_OFFSET
include/drm/drm_gem.h:  .fop_flags      = FOP_UNSIGNED_OFFSET
include/drm/drm_gem_dma_helper.h:               .fop_flags = FOP_UNSIGNED_OFFSET, \
include/linux/fs.h:#define FOP_UNSIGNED_OFFSET  ((__force fop_flags_t)(1 << 5))
mm/mmap.c:      if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
rust/bindings/bindings_helper.h:const fop_flags_t RUST_CONST_HELPER_FOP_UNSIGNED_OFFSET = FOP_UNSIGNED_OFFSET;
rust/kernel/drm/gem/mod.rs:    fops.fop_flags = bindings::FOP_UNSIGNED_OFFSET;


