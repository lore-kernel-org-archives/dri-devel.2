Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C7EDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60DA10E320;
	Tue,  7 Apr 2026 09:11:05 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5922A10E320
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:11:05 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-951a4e8d1b5so1437516241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775553064; x=1776157864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNZASjgqAlCAiE4mw8qwv/Flo+VjivMPygkU64fW+o0=;
 b=Exsfr9SiJIdKuHYVjUx3UgUTGRT6bBCDhGpYACEhPouzPHGrW831vTpVP/tskXbB44
 0IuNNMi37I/yYjlXLd8tvbXh+7pPkH0iP9sKqgsZF8MfO1PzriaP9lo+CcPDKK8/fEej
 BpLx6qeGS2ODchIHJNByW+AlyJeyeY2GcUiWLuKy/L7D7KE9xKu3K1Y3MJ2i3Q+HzMA8
 +866jxQPoOOKRxSrUNIHIW52DvsdO8fzTHDIdfmj1BXoRO8CmgjkqR2ZeEKP3peBcBcL
 yVRXBpxdys6AUsBie7L6jTMpriE3X8hl+QeXzDIxQXtjVBVJxqKvSrUh8WNW0ZovQ9jK
 4Waw==
X-Gm-Message-State: AOJu0YzvEQ462gyTdovdhKZxNj4mDBoRIX2yXKD21bicNFZhiK6dDg9w
 2YBbWlmN/K9wnUCngfAmyvlefcj1CFgD7FQ8CpXIi+nz4rr110KSh67UueM6pyjP
X-Gm-Gg: AeBDieuaXXXJAnzTIj6c/Fihg9isIfUnkwCHW4o0hGaPSnz3nrbauyku7z6ccCu6476
 htVmxe+APn7pLXg09f7/h5JM8FcJucAYOQOU0n/E6ac9buNAqFd35P5v2Qh/aO++6miLQOxnQKi
 kJu1MaEPeDM53b82SpFDuKDb15iEGTfhAORdU5H1TG58LF3iItPgja6mokEnv0DoJMJ4/U986G2
 T49zKKzhChMBr8o9oh+Kgvr/hKhmiR183dN1HOhZInEf6XD3+kYX3XxMoxpKDc2R+Qn6o8NhGR/
 Hm/E65XRGR0TvmqYdYE/wE7qsxFWLlGy4FZQ8yBM+53aJEzYdyi0GnSSHwHmunvqGdfM/BORiHX
 273qSYDWJCrnTLFiZXmMysjLYz9NHH6a/LrYzteqoVWxSsH4KWpzsl8cmiRexavWViOdTth8447
 d3xTOmDHSxmLOtWot5Q6akdXfDeBx0bp7vtDa61yBpuSM3GiQpZj3enpuJBUKA28vW
X-Received: by 2002:a05:6102:3e0b:b0:602:ac40:96ad with SMTP id
 ada2fe7eead31-605a50e2b82mr5128855137.30.1775553064208; 
 Tue, 07 Apr 2026 02:11:04 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-60583093d14sm18589108137.11.2026.04.07.02.11.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:11:04 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-56eec951db1so572781e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:11:03 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc1:b0:605:57f5:6d26 with SMTP id
 ada2fe7eead31-605a4c9a0cdmr5737340137.5.1775553063692; Tue, 07 Apr 2026
 02:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260323164526.2292491-5-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260323164526.2292491-5-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Apr 2026 11:10:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com>
X-Gm-Features: AQROBzA1sHxPH0RAVNNk6u3T6X_CdwB9koc1lAfq-_hUfXtBdCfv_IjKKIEuZmo
Message-ID: <CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm: rcar-du: Don't leak device_link to CMM
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Laurent,

On Mon, 23 Mar 2026 at 18:22, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The DU driver creates device_link instances between the DU and CMMs, but
> never deletes them. Fix it by introducing a rcar_du_cmm structure to
> group the CMM device and device_link, and deleting the links at cleanup
> time.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch, which is now commit 3bce3fdd1ff2ba24 ("drm:
rcar-du: Don't leak device_link to CMM") in drm-misc/for-linux-next.

This causes koelsch to hang during boot when a display is already
connected before boot:

      [drm] Initialized rcar-du 1.0.0 for feb00000.display on minor 0
      rcar-du feb00000.display: [drm] Device feb00000.display probed

When no display is connected, the system boots fine.

While looking into this, I noticed that hotplug after boot crashes,
but I haven't bisected that. It definitely worked a few months ago:

    Unable to handle kernel NULL pointer dereference at virtual
address 00000000 when read
    [00000000] *pgd=00000000
    Internal error: Oops: 5 [#1] SMP ARM
    CPU: 1 UID: 0 PID: 43 Comm: kworker/1:3 Not tainted
7.0.0-rc3-shmobile-00734-g3bce3fdd1ff2 #2454 VOLUNTARY
    Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
    Workqueue: events adv7511_hpd_work
    PC is at rcar_du_crtc_atomic_enable+0x14/0xa4
    LR is at drm_atomic_helper_commit_crtc_enable+0xb0/0xd4
    pc : [<c0534700>]    lr : [<c05145f8>]    psr: a0000013
    sp : f0939b88  ip : fffffff8  fp : c1fe25b8
    r10: c21d01ac  r9 : c0c7862b  r8 : c0a99acc
    r7 : c21d000c  r6 : c2e1c800  r5 : c21d0000  r4 : c21d0398
    r3 : 00000000  r2 : 00000000  r1 : c24ed800  r0 : c21d0398
    Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5387d  Table: 4231006a  DAC: 00000051
    Register r0 information: non-slab/vmalloc memory
    Register r1 information: slab kmalloc-64 start c24ed800 pointer
offset 0 size 64
    Register r2 information: NULL pointer
    Register r3 information: NULL pointer
    Register r4 information: non-slab/vmalloc memory
    Register r5 information: non-slab/vmalloc memory
    Register r6 information: slab kmalloc-512 start c2e1c800 pointer
offset 0 size 512
    Register r7 information: non-slab/vmalloc memory
    Register r8 information: non-slab/vmalloc memory
    Register r9 information: non-slab/vmalloc memory
    Register r10 information: non-slab/vmalloc memory
    Register r11 information: slab kmalloc-128 start c1fe2580 pointer
offset 56 size 128
    Register r12 information: non-paged memory
    Process kworker/1:3 (pid: 43, stack limit = 0xdcd99ef9)
    Stack: (0xf0939b88 to 0xf093a000)
    9b80:                   c21d0398 00000000 c24ed800 c05145f8
00000048 c1fde6c0
    9ba0: c2f7c680 c21d000c c24ed800 46818964 00000009 c0a9bf18
c24ed800 c0515350
    9bc0: c24ed800 c21d000c 46818964 c0535aac c24ed800 00000000
46818964 c05187dc
    9be0: 00000000 c24ed800 c21d000c 00000000 c21d000c c05189a4
c24ed800 c21d000c
    9c00: c15bac10 00000001 c21d000c c04de554 c24ed800 c22d1400
c21d1000 c0109fdc
    9c20: 00000000 c15bac10 00000000 00000000 00000000 00000000
00000000 c0109fdc
    9c40: 00000000 c15bac10 00000000 00000000 00000000 00000000
00000000 ff6cd0a0
    9c60: 00000000 f0939c80 c1542a00 c050e368 00000000 c21d01b0
00000000 00000000
    9c80: c1c30000 00000008 0000000e 00000000 00000000 00000000
c1ce8f24 c21d35a8
    9ca0: 00000000 ff6cd0a0 ffffffff c21d000c c1542a18 c1542a00
c1542ab8 000000f0
    9cc0: 00000043 000000f0 00000001 c050e470 c1c30000 c095df28
c21d0058 c21d0058
    9ce0: c21d0058 c1542a00 c21d000c 00000000 c1542ab8 000000f0
00000043 c050e5a4
    9d00: 00000000 c1542a00 00000000 c0521a44 00000000 c2d89000
c1514c00 c1077124
    9d20: 000000f0 c0521a7c c14b2800 c047f16c 00000000 c14df800
00000043 00000000
    9d40: 00000000 c14b2800 c14b2958 00000000 00000000 0000003e
c0a81464 00000000
    9d60: 00000001 c04c0688 c14b2800 c10798fc 00000000 c04c2654
c1079918 c0a81464
    9d80: c0a814b8 00000001 0000003e c1079918 c0a81464 00000000
00000000 0000003e
    9da0: 00000001 c1079a18 00000000 c04c298c c0fe6d84 c0c6f88c
00000001 00000001
    9dc0: c0fe491c c1076f84 c1076f84 00000000 c0fe491c c0a96a00
00000000 c047d3e8
    9de0: c0f04ff8 00000000 c1076f84 c047f974 c2d89000 c0f059d4
c2d891cc c0f059d4
    9e00: c21d000c c0a96a00 00000000 c0478508 60000013 00000000
00000000 00000780
    9e20: 00000438 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9e40: 00000000 00000000 00000020 ff6cd0a0 c1542ab8 c1542a00
c2d89000 00000000
    9e60: 00000000 c0521674 00000000 c24f05c0 c102cee8 c0944738
00000cc0 00000000
    9e80: c1542a18 00000001 c141f505 00000000 00000000 00000780
00000438 00000780
    9ea0: 00000438 00000020 00000018 ff6cd0a0 c1542ab8 c1542a00
c1542a00 c21d000c
    9ec0: c17d81b8 c10349c0 c141f505 61c88647 c17d81bc c050d594
c1542a00 00000000
    9ee0: c21d00a8 c1542a00 c21d0094 c050d948 c17d81c8 00000001
c17d8278 c04e2f44
    9f00: c17d81b8 c141f500 ef7cd600 c053dba8 000000d0 ff6cd0a0
c1cede80 c0143f50
    9f20: c0a01828 00000000 c1c30000 ff6cd0a0 c1c30000 c1c30000
ef7cd620 ef7cd600
    9f40: c014424c c1cede80 ef7cd620 ef7cd600 c014424c c1c30000
c1cedeac c1034ee0
    9f60: 00000000 c01443bc 00000000 c1d00780 c169eac0 c1c30000
c014424c c1cede80
    9f80: f08fdecc 00000000 00000000 c014b654 c169eac0 c014b558
00000000 00000000
    9fa0: 00000000 00000000 00000000 c010014c 00000000 00000000
00000000 00000000
    9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
00000000 00000000
    Call trace:
     rcar_du_crtc_atomic_enable from
drm_atomic_helper_commit_crtc_enable+0xb0/0xd4
     drm_atomic_helper_commit_crtc_enable from
drm_atomic_helper_commit_modeset_enables+0x10/0x38
     drm_atomic_helper_commit_modeset_enables from
rcar_du_atomic_commit_tail+0x54/0xb8
     rcar_du_atomic_commit_tail from commit_tail+0x6c/0x138
     commit_tail from drm_atomic_helper_commit+0xf4/0x104
     drm_atomic_helper_commit from drm_atomic_commit+0xbc/0xec
     drm_atomic_commit from drm_client_modeset_commit_atomic+0x190/0x214
     drm_client_modeset_commit_atomic from
drm_client_modeset_commit_locked+0x3c/0x148
     drm_client_modeset_commit_locked from drm_client_modeset_commit+0x28/0x3c
     drm_client_modeset_commit from
__drm_fb_helper_restore_fbdev_mode_unlocked+0xa4/0xac
     __drm_fb_helper_restore_fbdev_mode_unlocked from
drm_fb_helper_set_par+0x2c/0x38
     drm_fb_helper_set_par from fbcon_init+0x2c8/0x460
     fbcon_init from visual_init+0x98/0xe4
     visual_init from do_bind_con_driver+0x1f0/0x260
     do_bind_con_driver from do_take_over_console+0x12c/0x174
     do_take_over_console from do_fbcon_takeover+0x4c/0xb0
     do_fbcon_takeover from fbcon_fb_registered+0xf4/0x160
     fbcon_fb_registered from register_framebuffer+0x1f8/0x21c
     register_framebuffer from
__drm_fb_helper_initial_config_and_unlock+0x468/0x534
     __drm_fb_helper_initial_config_and_unlock from drm_client_hotplug+0x50/0x94
     drm_client_hotplug from drm_client_dev_hotplug+0x80/0x8c
     drm_client_dev_hotplug from drm_bridge_hpd_notify+0x30/0x3c
     drm_bridge_hpd_notify from adv7511_hpd_work+0x74/0xb4
     adv7511_hpd_work from process_scheduled_works+0x1d8/0x324
     process_scheduled_works from worker_thread+0x170/0x208
     worker_thread from kthread+0xfc/0x108
     kthread from ret_from_fork+0x14/0x28
    Exception stack(0xf0939fb0 to 0xf0939ff8)
    9fa0:                                     00000000 00000000
00000000 00000000
    9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
    Code: e1a04000 e5903520 e5906468 e59054d8 (e5930000)
    ---[ end trace 0000000000000000 ]---

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
