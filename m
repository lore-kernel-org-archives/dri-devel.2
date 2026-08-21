Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692E9C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFCD10E319;
	Fri, 21 Aug 2026 15:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="stK1XJCs";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6DB10E319
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:37:52 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a3ec9ef8d4so211903a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787326671; x=1787931471; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:date:message-id
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ryew6n4D2AjCQNgITduRRpkXWCv+k6Vg9rO7DLoolms=;
 b=stK1XJCsjM18JGudnWijHswiPtQ+arVod9/d4xFKE6U1F6bZllijzS2l9YKW182smb
 MaTmCxAIMbFe6WO9J223FYIxtO48ZnaWRfsnlxnLbQJv9TM57YY2oZneYLlrNhUzl7+Q
 W0LHgVNVm1sVZSJDFng1mI5E8XIVySRn3koqyFiQ+LYQ3xFleQPv4jo0pWicOb7Obsx/
 qgTJ4b1yUsCvljeQ88iB/SMKv21h2P/RBa3haQB5V0R/Ws3qOEYPtynbpENGNlkuDhUu
 diXU+Yfn5EjR3HlqrOP4htKnjKKhMDmx2bLbTKCq3n+fitqbX4dW56CLwNLBxM8/KvfQ
 YrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787326671; x=1787931471;
 h=mime-version:content-transfer-encoding:content-type:date:message-id
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ryew6n4D2AjCQNgITduRRpkXWCv+k6Vg9rO7DLoolms=;
 b=YMwHtHTRhExWXcv5rr6JSIFmbnOqG8V+WESCRuhjk6Dojzo4k/Icur2TdplhHvxeXS
 BthM/QieVIbmtNAUDWQum+pk6L3MVE7ogp2OiMYPeLy2WCJLgeZQXlHzDbcTkO0kL7kn
 VpW9gml9eyUzSNw+g4+GCpvZPuZ577uQbani1aOhJBt/A5S+BxeUcrvt5MFOBYC8aOLc
 VCsTcPcmAUcbEI0X6vXVk7frGmm/TReOPRdoHFMhhOQUPv3tEA6ZJ/EcAdwcc57wki+3
 oZGznk1XdkPIJ3jGPiJdu58QV7YyXhJeYkmqN+lbhDZ14J+AlAtIoX5qp6mmPK2PtM7y
 ZrCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJrF0UO2vMPJdXofh+8TatKv8BEWtbrfzdcsvh9+HufQ6EIG5f/z0fu5EVQbQb3C8zr3e+rL68r28=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZJe7XEiqsljeJy4+InjfeTQMjYFAxUQ0WYUPHQLaKdR9JoO3b
 MYaa4OiwQWIjic9tUwMc+XsrY1LiQDN5u1vwcHLRRvNE+sSkorzGRDteYlyGC8RG
X-Gm-Gg: AR+sD10VPdm1SacgxgTDr1INqHKsehAhPJdZGy3GylkYMOGH5cYRupBptDP3fI+hpLg
 fAT9YBPK7sPnNOXUQyjxAwI16ejUDq7WDAEs5O2OJjop41YH50lpzY5OyJIBZ8y9HtrEIEaZXNQ
 saMt25KQjYD8gfGSbwqk/bgH25hydB5TN45SjT4exxQEmUK1q+1lz2uP0CcrOYJp14EFEl/Sg0A
 QkQOiI2qmfLidcSf3d6dhdYLFqJSeDKZ5AQTcj10uHOdHl3Jyg09JgHXTiJ+VayjiExQsTIkyW8
 xKsZSx4ACwM4WuntFLgDxSns/CX/5iuqPQRp3rEU4sdC5LmqjBYMryCKZHUx32UNqFLhF2TkGma
 vLQW75fUGdoO2k8uJ5KZXKu+tV9XlD4fCirk1dLspPe2fTjTUDbzoqRTgG4rDKVJv+PRDZtb02G
 ex63jhENXI6Ijyy+KGgjCXO9TvCuK7+aiRT/TEKK5XHE6cAVDgk07y/x9KZXKtphWaoW97Eqflc
 98QtjBVbKi3jtML+Lt4JtCYJ+lfyNKOglBZBMjkMmecHjTU7W7x
X-Received: by 2002:a05:6402:d0e:b0:6a3:fee5:adc8 with SMTP id
 4fb4d7f45d1cf-6a42eeb84dcmr4232330a12.0.1787326670812; 
 Fri, 21 Aug 2026 08:37:50 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff156693sm6962450a12.15.2026.08.21.08.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:37:50 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Subject: [BUG] nouveau: lockdep: cli->mutex vs reservation inversion is back
 with atomic, via the cursor plane
Message-ID: <178732666901.188627.15234683743061737710@gmail.com>
Date: Fri, 21 Aug 2026 17:37:49 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Hi,

On a kernel with CONFIG_PROVE_LOCKING, nouveau reports a possible
circular locking dependency between cli->mutex and the buffer
reservation (reservation_ww_class_mutex) within two minutes of a
Wayland session starting, on the first cursor update. Full splat at
the end.

The two paths, as lockdep shows them:

  A  reservation -> cli->mutex

     drm_mode_cursor_ioctl
       drm_atomic_helper_update_plane
         nv50_disp_atomic_commit
           drm_atomic_helper_prepare_planes
             nv50_wndw_prepare_fb
               nouveau_bo_pin                  takes reservation
                 nouveau_bo_pin_locked
                   ttm_bo_validate
                     nouveau_bo_move
                       nouveau_bo_move_m2mf    takes cli->mutex   (nouveau_bo.c:1028)

  B  cli->mutex -> reservation

     nouveau_abi16_ioctl_channel_alloc
       nouveau_abi16_get                       takes cli->mutex   (nouveau_abi16.c:61)
         nouveau_channel_new
           nouveau_channel_ctor
             nouveau_channel_prep
               nouveau_bo_new_map
                 nouveau_bo_new_pin
                   nouveau_bo_pin              takes reservation

So the cursor buffer is pinned under its reservation, gets moved by TTM
on the way, and the M2MF copy takes cli->mutex underneath; while channel
allocation holds cli->mutex across the whole ioctl and pins the push
buffer, which takes a reservation underneath. Two locks, two orders.

This is not a new pairing. It is the one Ben Skeggs fixed in 2013:

  commit 060810d7abaa ("drm/nouveau: fix locking issues in page flipping paths")

which says "the pinning of new_bo can potentially cause a buffer move,
which would result in attempting to acquire the same mutex again", and
annotated the m2mf side with mutex_lock_nested(SINGLE_DEPTH_NESTING).
That annotation was then removed for the atomic case in

  commit 551620f2a381 ("drm/nouveau: Drop mutex_lock_nested for atomic")

whose message reads, in full candour, "Purely conjecture, but I think
the original locking inversion with the legacy page flip code between
flipping and ttm's bo move function shoudn't exist anymore with atomic:
With atomic the bo pinning and actual modeset commit is completely
separated in the code paths."

The conjecture was right about page flips and wrong about cursors. The
cursor plane still pins its buffer inside the atomic commit
(nv50_wndw_prepare_fb -> nouveau_bo_pin), and a pin can still move the
buffer, and the move still takes cli->mutex. That is path A above, and
it is exactly the shape the 2013 commit describes. Since that 2020
commit the atomic branch takes cli->mutex plainly, so lockdep now sees the
inversion against path B and reports it. I cannot say whether the
nested annotation was hiding a real deadlock or a false one; what I can
say is that the ordering it was covering is still there.

I have not seen the deadlock itself, only the report. To hit it one
thread has to be allocating a channel while another moves a cursor
whose buffer happens to need a TTM move. On this machine every GL
client opens a channel on start, and the compositor updates the cursor
constantly, so the window is open routinely even if it is narrow.

Environment:

  7.2.0 (base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86), built from
  source with
  PROVE_LOCKING, DEBUG_WW_MUTEX_SLOWPATH, DEBUG_MUTEXES.
  Apple Mac mini Late 2009, MCP79 / GeForce 9400M (NVAC, nv50/Tesla).
  Wayland, labwc 0.20.1, Xwayland 24.1.13, Mesa 26.1.6.
  The splat appeared once, 118 s after boot, from labwc's first cursor
  update. lockdep reports each chain once, so one is the expected count.

The tree carries local nouveau patches, none of which touch
nouveau_bo_move_m2mf(), nouveau_abi16_get(), nouveau_channel_prep() or
cli->mutex; both frames in the splat are upstream code. I can retest
on a clean tree if that is wanted, and I can try to turn the report
into a deadlock with a channel-allocation loop against a cursor loop,
if that would help decide how real it is.

I am not proposing a fix, because I do not know which order is the
intended one. The two obvious shapes are to re-add the nested
annotation for atomic, which puts 2013 back and makes lockdep quiet
without answering the question, or to keep cli->mutex out of the move
path when called from a plane pin. Someone who knows why m2mf needs
cli->mutex at all is better placed than I am.

Marek

[  118.950482] WARNING: possible circular locking dependency detected
[  118.950486] 7.2.0-gentoo-nvac-soak #1 Tainted: G S         OE      
[  118.950491] ------------------------------------------------------
[  118.950493] labwc/8055 is trying to acquire lock:
[  118.950496] ffff889b88c302d0 (&cli->mutex){+.+.}-{4:4}, at: nouveau_bo_move_m2mf+0x9d/0x260 [nouveau]
[  118.950923] 
[  118.950923] but task is already holding lock:
[  118.950925] ffff889be638f198 (reservation_ww_class_mutex){+.+.}-{4:4}, at: nouveau_bo_pin+0x29/0xb0 [nouveau]
[  118.951221] 
[  118.951221] which lock already depends on the new lock.
[  118.951221] 
[  118.951223] 
[  118.951223] the existing dependency chain (in reverse order) is:
[  118.951226] 
[  118.951226] -> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
[  118.951235]        __lock_acquire+0x55d/0xbd0
[  118.951244]        lock_acquire.part.0+0x78/0x1c0
[  118.951249]        __ww_mutex_lock.constprop.0+0xfe/0x1640
[  118.951256]        ww_mutex_lock+0x3c/0xb0
[  118.951261]        nouveau_bo_pin+0x29/0xb0 [nouveau]
[  118.951501]        nouveau_bo_new_pin+0x7b/0xa0 [nouveau]
[  118.951501]        nouveau_bo_new_map+0x31/0x90 [nouveau]
[  118.951501]        nouveau_channel_prep+0xfb/0x330 [nouveau]
[  118.951501]        nouveau_channel_ctor+0x22e/0x5b0 [nouveau]
[  118.951501]        nouveau_channel_new+0x2b/0xc0 [nouveau]
[  118.951501]        nouveau_abi16_ioctl_channel_alloc+0x158/0x460 [nouveau]
[  118.951501]        drm_ioctl_kernel+0xb1/0x110
[  118.951501]        drm_ioctl+0x2b5/0x580
[  118.951501]        nouveau_drm_ioctl+0x5b/0xc0 [nouveau]
[  118.951501]        __x64_sys_ioctl+0x97/0xe0
[  118.951501]        do_syscall_64+0xf4/0x690
[  118.951501]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  118.951501] 
[  118.951501] -> #0 (&cli->mutex){+.+.}-{4:4}:
[  118.951501]        check_prev_add+0xe1/0xe00
[  118.951501]        validate_chain+0x4c1/0x730
[  118.951501]        __lock_acquire+0x55d/0xbd0
[  118.951501]        lock_acquire.part.0+0x78/0x1c0
[  118.951501]        __mutex_lock+0xda/0x10a0
[  118.951501]        nouveau_bo_move_m2mf+0x9d/0x260 [nouveau]
[  118.951501]        nouveau_bo_move+0x4ec/0x880 [nouveau]
[  118.951501]        ttm_bo_handle_move_mem+0xd0/0x1a0 [ttm]
[  118.951501]        ttm_bo_validate+0xf5/0x1e0 [ttm]
[  118.951501]        nouveau_bo_pin_locked+0xad/0x250 [nouveau]
[  118.951501]        nouveau_bo_pin+0x41/0xb0 [nouveau]
[  118.954757]        nv50_wndw_prepare_fb+0x4d/0x160 [nouveau]
[  118.954757]        drm_atomic_helper_prepare_planes.part.0+0x2d/0x1d0 [drm_kms_helper]
[  118.954757]        nv50_disp_atomic_commit.part.0+0xbc/0x1e0 [nouveau]
[  118.954757]        drm_atomic_commit+0xb1/0xe0
[  118.954757]        drm_atomic_helper_update_plane+0xf1/0x150 [drm_kms_helper]
[  118.954757]        drm_mode_cursor_universal+0xf4/0x2d0
[  118.954757]        drm_mode_cursor_common+0x110/0x240
[  118.954757]        drm_mode_cursor_ioctl+0x51/0x70
[  118.954757]        drm_ioctl_kernel+0xb1/0x110
[  118.954757]        drm_ioctl+0x2b5/0x580
[  118.954757]        nouveau_drm_ioctl+0x5b/0xc0 [nouveau]
[  118.954757]        __x64_sys_ioctl+0x97/0xe0
[  118.954757]        do_syscall_64+0xf4/0x690
[  118.954757]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  118.954757] 
[  118.954757] other info that might help us debug this:
[  118.954757] 
[  118.954757]  Possible unsafe locking scenario:
[  118.954757] 
[  118.954757]        CPU0                    CPU1
[  118.954757]        ----                    ----
[  118.954757]   lock(reservation_ww_class_mutex);
[  118.954757]                                lock(&cli->mutex);
[  118.954757]                                lock(reservation_ww_class_mutex);
[  118.954757]   lock(&cli->mutex);
[  118.954757] 
                - Last output repeated twice -
[  118.954757] 3 locks held by labwc/8055:
[  118.954757]  #0: ffffc8b8412bba00 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_cursor_common+0xd2/0x240
[  118.954757]  #1: ffffc8b8412bba28 (crtc_ww_class_mutex){+.+.}-{4:4}, at: drm_mode_cursor_common+0xd2/0x240
[  118.954757]  #2: ffff889be638f198 (reservation_ww_class_mutex){+.+.}-{4:4}, at: nouveau_bo_pin+0x29/0xb0 [nouveau]
[  118.954757] 
[  118.954757] stack backtrace:
[  118.954757] CPU: 0 UID: 1000 PID: 8055 Comm: labwc Tainted: G S         OE       7.2.0-gentoo-nvac-soak #1 PREEMPT(lazy) 
[  118.954757] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  118.954757] Hardware name: Apple Inc. Macmini3,1/Mac-F22C86C8, BIOS     MM31.88Z.0081.B06.0904271717 04/27/09
[  118.954757] Call Trace:
[  118.954757]  <TASK>
[  118.954757]  dump_stack_lvl+0x6e/0xa0
[  118.954757]  print_circular_bug.cold+0x38/0x46
[  118.954757]  check_noncircular+0x148/0x170
[  118.954757]  check_prev_add+0xe1/0xe00
[  118.954757]  ? look_up_lock_class+0x59/0x120
[  118.954757]  validate_chain+0x4c1/0x730
[  118.954757]  __lock_acquire+0x55d/0xbd0
[  118.954757]  lock_acquire.part.0+0x78/0x1c0
[  118.954757]  ? nouveau_bo_move_m2mf+0x9d/0x260 [nouveau]
[  118.954757]  __mutex_lock+0xda/0x10a0
[  118.954757]  ? nouveau_bo_move_m2mf+0x9d/0x260 [nouveau]
                - Last output repeated 2 times -
[  118.954757]  nouveau_bo_move_m2mf+0x9d/0x260 [nouveau]
[  118.954757]  nouveau_bo_move+0x4ec/0x880 [nouveau]
[  118.954757]  ? lock_is_held_type+0x9a/0x110
[  118.954757]  ? dma_resv_reserve_fences+0x2db/0x360
[  118.954757]  ttm_bo_handle_move_mem+0xd0/0x1a0 [ttm]
[  118.954757]  ttm_bo_validate+0xf5/0x1e0 [ttm]
[  118.954757]  nouveau_bo_pin_locked+0xad/0x250 [nouveau]
[  118.954757]  nouveau_bo_pin+0x41/0xb0 [nouveau]
[  118.954757]  nv50_wndw_prepare_fb+0x4d/0x160 [nouveau]
[  118.954757]  drm_atomic_helper_prepare_planes.part.0+0x2d/0x1d0 [drm_kms_helper]
[  118.954757]  nv50_disp_atomic_commit.part.0+0xbc/0x1e0 [nouveau]
[  118.954757]  drm_atomic_commit+0xb1/0xe0
[  118.954757]  ? __pfx___drm_printfn_info+0x10/0x10
[  118.954757]  drm_atomic_helper_update_plane+0xf1/0x150 [drm_kms_helper]
[  118.954757]  drm_mode_cursor_universal+0xf4/0x2d0
[  118.954757]  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
[  118.954757]  drm_mode_cursor_common+0x110/0x240
[  118.954757]  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
[  118.954757]  drm_mode_cursor_ioctl+0x51/0x70
[  118.954757]  drm_ioctl_kernel+0xb1/0x110
[  118.954757]  drm_ioctl+0x2b5/0x580
[  118.954757]  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
[  118.954757]  nouveau_drm_ioctl+0x5b/0xc0 [nouveau]
[  118.954757]  __x64_sys_ioctl+0x97/0xe0
[  118.954757]  do_syscall_64+0xf4/0x690
[  118.954757]  ? __lock_acquire+0x55d/0xbd0
[  118.954757]  ? timerqueue_linked_add+0x7e/0xd0
[  118.954757]  ? __hrtimer_start_range_ns+0x1db/0x6c0
[  118.954757]  ? find_held_lock+0x2b/0x80
                - Last output repeated twice -
[  118.954757]  ? __lock_release.isra.0+0x59/0x170
[  118.954757]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
[  118.954757]  ? trace_hardirqs_on+0x18/0xf0
[  118.954757]  ? finish_task_switch.isra.0+0x103/0x3b0
[  118.954757]  ? __schedule+0x674/0x800
[  118.954757]  ? trace_hardirqs_off+0x4e/0xe0
[  118.954757]  ? schedule+0x3a/0x100
[  118.954757]  ? switch_fpu_return+0x115/0x140
[  118.954757]  ? trace_hardirqs_on_prepare+0xc6/0xe0
[  118.954757]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
[  118.954757]  ? trace_hardirqs_on+0x18/0xf0
[  118.954757]  ? do_syscall_64+0xab/0x690
[  118.954757]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  118.954757] RIP: 0033:0x7f7154522e3f
[  118.954757] RAX: ffffffffffffffda RBX: 000055a34bec4a88 RCX: 00007f7154522e3f
[  118.954757] RDX: 00007ffd6d92e900 RSI: 00000000c01c64a3 RDI: 000000000000000e
[  118.954757] RBP: 00007ffd6d92e900 R08: 0000000000000040 R09: 000055a34be9a3e0
[  118.954757] R10: 0000000000000030 R11: 0000000000000246 R12: 00000000c01c64a3
[  118.954757] R13: 000000000000000e R14: 00007ffd6d92eb40 R15: 000055a34cdaebf0
[  118.954757]  </TASK>

