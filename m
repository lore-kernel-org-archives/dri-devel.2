Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3875C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513D310F2A2;
	Fri, 28 Aug 2026 07:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=berkeley.edu header.i=@berkeley.edu header.b="jRjVIRTx";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7F610E481
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:50:59 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so6164205ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896258; cv=none;
 d=google.com; s=arc-20260327;
 b=Zn8WhDLAQw42B4DXICBfOB6+kQBRYxH20LBVHbNgWWsOBdywAoMikBOVMTsBwj0WnX
 sfPO5vIRIQKplM+7bBRURMAdF0fIAPRn+by7eFpMxB6Z7v40VH7FaKmJwbI/P8dwX93n
 uqF54S/qhoYXWDKV7S5VAjOTJygzidvpV3tsG1qq4IXr7xQiyGU5PzV9x6BcvWZe/C3E
 jQOoJnwt4qEvij6j264s1PmGRWWYpOH3C4bEh/v9mbg095Y34TaaUv50FF0038dA3nWt
 uK+5LevDJ+ACz6g10K/Tgzgrk6ca1xX2c2ZC+3g7Uerro1P5MODTpgevHeRW1nHJXq2H
 6n/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
 fh=sn9cTGb8x7PLaaPWgc0wLJivLSPVKEN+x+jDoNR9dwE=;
 b=jdNGwHv+qIBYQ7pGwEwBx5GaoTGD7SvQr2uTjg2dRDaGubo5EymA66skuYG/fpDYgH
 5WGfMkWmiUby/vZchhXQZ/RzfpzvLo/mg0oD1L+/XBjZ56UB4blzHGfi7MQn0zsma0e2
 chtzo2cE8FdcGyUyc5FihvfV/94jtXW2XjAT1JXv+T/Ywbna3yecPcQnmmG6y/Vge1fv
 0MiI4gyv7AO3hBa6oO9sOOyBdIUtySOiM+R6FcRsNLXZNIwm/zNhQdFJ1XQkSPMCOs3C
 XhrJEdr00LGAcjKpIm+UxBuBdu81Mjq9+TG2lO6KTfcoE/EsizvjNSrMuJ4tIxmHza1y
 7uMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley.edu; s=google; t=1787896258; x=1788501058;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
 b=jRjVIRTxQ8VsnNUH5u5V3O5kDbEGaJk29mySxLrh7Lpa+0coanSV5vnKBC9SGHevqT
 lCiaQn9yz0Yh7JdB+M8ndzdNvI5yzL4cMqvMtPBtexJt2hGS1e8PvFTIMVn51Wk0zW/h
 TZTFyvgz9g4nIPuAzGiQrDGyN2xbPdHMJRBWdDNWJCoCEfZhMfnwidcET4UGT7uHayz2
 cCRbV5iReCek94OB4sRtfwUlU9OofFyrOoGFTs4YwXkLKMVfZHf6HyzRRflUZC1hRiaZ
 /ODV/tfypgGHSYQXKE7fEYcs0ywYEB51fYWUEVmpRO9YJF9PSAfb8nKspLHuoIeUxhNj
 8YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787896258; x=1788501058;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e87d5G70BjGRX707l9cgaVd7OCZfs4SUPvQc3fL2fBE=;
 b=HCvOnQOeeuxo6ihNlPWvjm0xNRKo2HtdAhA1+o7UIKAp0jG8P5NvezTvWdc4ITz8rM
 pYTSCPOONyssgj+sZ7eQ8O7CvFK7CRMqQ34kMsRsJUvL+8jfkrQdrPvjOYFRmWRt+5vk
 6gSTqAjYZa0XOKZKUVKNjDrYEzk1MJUUBnoI3vefUWj/NwqC88AtqZA2T9Nt2ZUW7A4i
 LKqASHQy97wXylRIJJz366vujQqG3MEApwRCSrglAINqtcPoQOrxTzQbiI8+EjrWICzr
 GiKATwi8axrXEBuIDYDwx34lyRwr+YH/RkyANACl2fSWL3yphHQEvB9VXUj0FnNxK8Qp
 0/pg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFWWykvH1t2e5m6b6+RA3hZffEJ7vwcSj9TAjiOzGEPvA47u61nwz+cowSarbRBDWk7RYfD6ZftZY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmXQ55GYg0B8OvGgiJEb8AwRY+oP8jeZWUyiB5UgbuW95JXREu
 KzamUrnG73k+YNNhQO/Es8IjVpc5y0fCQj8WS9lE0bG4gdIUThVuTTza2Ii2sPSP7+3knY4oHZG
 ptDb48aNsSbrRrckeC3Npbluk/4wiy/0lLt06B81T
X-Gm-Gg: AR+sD13fcj5YLupUH56q+TTw+0gip+LRyh0PFxYwRQWMwIb0MrIYdZ1ndptH9HMBm+u
 gXFgmn/TWGrDd+Lr2aSQxjQxxe8lrWA7ACHPSJ/IBWacU/80k+C3moAQscV5ahPjvKe4fyAEkSr
 ZpRf0Zz+nlVfi8whEcM1Ghu1Mckz3EivYNWbKA8TyoweAPdklIABfJ1wM/GGEZUoO20FQ13hLJz
 dOQ/lkQmNqRnZqyNOc9ZSyYoNdgPWeBypypTO+62gbjflJo6t3+WaKi+TIuNKGNbNm1CokoKm6W
 5akr76PPWKf/Vlgjh+SOOb6rTsbbMry9dg13+57h1zFsNTke4KrRUAk4NUnvju/jTzM1gz6c4/L
 7Y1QSt/xXE5u1SRdKO7KIlSPgfLskm971rw==
X-Received: by 2002:a17:902:f647:b0:2d7:1cbd:9ceb with SMTP id
 d9443c01a7336-2d7269d6badmr162549875ad.12.1787896257763; Thu, 27 Aug 2026
 22:50:57 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:50:55 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:50:55 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:50:55 -0700
X-Gm-Features: AcwNN1WWqcM5yhXJkATKhrOpZ343F8pl4CTVCtlosXKNbW4VXRhrPmb_dA1bLu4
Message-ID: <CA+0ovCgp6tg_QwAh01C3RAV4-s0Lv2BarzoRZtnpor63TRTX-g@mail.gmail.com>
Subject: [BUG] drm/bochs: drm_gem_shmem_release() WARN on nonzero
 vmap_use_count when unbinding bochs-drm
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: falemi@asu.edu, virtualization@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/192-warning-in-drm-gem-shmem-release/

  bochs-drm 0000:00:01.0: [drm]
drm_WARN_ON(refcount_read(&shmem->vmap_use_count))
  WARNING: drivers/gpu/drm/drm_gem_shmem_helper.c:177 at
drm_gem_shmem_release+0x2d2/0x6d0
drivers/gpu/drm/drm_gem_shmem_helper.c:177, CPU#1: syz.1.397/14947
  RIP: 0010:drm_gem_shmem_release+0x5bb/0x6d0
drivers/gpu/drm/drm_gem_shmem_helper.c:177
  Call Trace:
   drm_gem_shmem_release+0x5bb/0x6d0 drivers/gpu/drm/drm_gem_shmem_helper.c:177
   drm_gem_shmem_free drivers/gpu/drm/drm_gem_shmem_helper.c:207 [inline]
   drm_gem_shmem_object_free+0x15/0x20 include/drm/drm_gem_shmem_helper.h:161
   drm_client_buffer_delete+0x189/0x2d0 drivers/gpu/drm/drm_client.c:201
   drm_fbdev_shmem_fb_destroy+0xac/0xd0 drivers/gpu/drm/drm_fbdev_shmem.c:67
   do_unregister_framebuffer drivers/video/fbdev/core/fbmem.c:561 [inline]
   unregister_framebuffer+0x2bd/0x3b0 drivers/video/fbdev/core/fbmem.c:606
   drm_client_dev_unregister+0x223/0x2d0 drivers/gpu/drm/drm_client_event.c:46
   drm_dev_unregister+0x44/0x730 drivers/gpu/drm/drm_drv.c:1155
   drm_dev_unplug+0x45/0xa0 drivers/gpu/drm/drm_drv.c:497
   bochs_pci_remove+0x3e/0x50 drivers/gpu/drm/tiny/bochs.c:785
   pci_device_remove+0xa3/0x250 drivers/pci/pci-driver.c:512
   unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244

We do not have a reproducer for this one -- it was found by the fuzzer and we
have not been able to reproduce it deliberately.

Happy to test a patch if that would help.

Regards,
