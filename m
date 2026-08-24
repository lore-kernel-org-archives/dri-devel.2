Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD76C5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD05410E803;
	Mon, 24 Aug 2026 17:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BLMVktcU";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8F010E803
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787591132; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Quq82DUXd7SSkNKYci8TJeSRJhvRJLZYUC9GfeSV3B6PE6hMK9Q41sZNXWcFO5ghF1d/FUqIdA/8wUnE2HvtM2pprMPGcALDed5geVZ/t8HBe7Ux7BaVB1ea56WY1LefdZMsInUHV4OkbyDTdRrJmGQFOu5McBwqxDXfSDequJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787591132;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=S+dNR4CNFPI42UDfYOPGe6vamDis3ryR31DGUswzY7c=; 
 b=bfROYb19xeDzDBBfT01dvzsAfX76RQUeczRCvzzMkq0g+oBYkWcZYKcC313FlF9dy5Z+JBo23r3gNIB9/IBgT8vaHbXXxT3AtDvzodjTxztD9JX63Htl7qbqbeSvdGrutV5EWU6MJzIO0pTCQed7qPiL1KGdhVRxTbIBS9jgaFY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787591132; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=S+dNR4CNFPI42UDfYOPGe6vamDis3ryR31DGUswzY7c=;
 b=BLMVktcUFtbStSkZH4Mx37nX7kHwZ9Biz5IaG4GGN3dmBBOjqgiwTVN1YaXsHHg7
 l27UQUxyaCWrxgeA7JA9bhrQEWpx0bQbcmVREp3YUVPGsvK9+4ywp6HreHTIrjC96pI
 EXoddLabq7tcB+IU60GQZQ5FAIfpODv8gs62PqUk=
Received: by mx.zohomail.com with SMTPS id 1787591129640894.4389964293451;
 Mon, 24 Aug 2026 10:05:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 3/3] drm/tyr: put iomem behind the hardware gate
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260819-tyr-reset-impl-v6-3-7b4e1e041fe5@onurozkan.dev>
Date: Mon, 24 Aug 2026 14:05:11 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <39E7E24E-147C-4894-AD8F-095B60FDA955@collabora.com>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-3-7b4e1e041fe5@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Onur,


While testing this patch, I came across the following splat:


[   12.648287] WARNING: possible circular locking dependency detected
[   12.648826] 7.1.0-rc5-g991a312b28c2 #1 Not tainted
[   12.649245] ------------------------------------------------------
[   12.649782] modprobe/167 is trying to acquire lock:
[   12.650208] ffff0001f1713c80 =
(drivers/gpu/drm/tyr/reset/hw_gate.rs:42){+.+.}-{4:4}, at: =
rust_helper_mutex_lock+0x14/0x20
[   12.651169]=20
[   12.651169] but task is already holding lock:
[   12.651677] ffff0001f1713cc0 =
(drivers/gpu/drm/tyr/reset/hw_gate.rs:43){.+.+}-{0:0}, at: =
srcu_lock_acquire+0x4/0x40
[   12.652588]=20
[   12.652588] which lock already depends on the new lock.
[   12.652588]=20
[   12.653299]=20
[   12.653299] the existing dependency chain (in reverse order) is:
[   12.653948]=20
[   12.653948] -> #1 =
(drivers/gpu/drm/tyr/reset/hw_gate.rs:43){.+.+}-{0:0}:
[   12.654664]        srcu_lock_sync+0x30/0x3c
[   12.655035]        __synchronize_srcu+0x58/0x180
[   12.655441]        synchronize_srcu+0x20c/0x28c
[   12.655838]        =
_RNvNtCs8XoewxZdfnt_3tyr5reset9run_reset+0x3c/0x1d4 [tyr]
[   12.656469]        =
_RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformDriverNtNtCsbuTvttuFvbr_=
6kernel8platform6Driver5probe+0x254/0x470 [tyr]
[   12.657573]        =
_RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7AdapterNtNtCs8XoewxZdfnt_3t=
yr6driver17TyrPlatformDriverE14probe_callbackBT_+0x44/0x10c [tyr]
[   12.658812]        platform_probe+0x68/0xa4
[   12.659182]        really_probe+0x198/0x42c
[   12.659551]        __driver_probe_device+0xc8/0x190
[   12.659979]        driver_probe_device+0x40/0x240
[   12.660392]        __driver_attach+0xf8/0x294
[   12.660775]        bus_for_each_dev+0xec/0x144
[   12.661168]        driver_attach+0x24/0x30
[   12.661528]        bus_add_driver+0x158/0x2a8
[   12.661910]        driver_register+0x68/0x100
[   12.662293]        __platform_driver_register+0x24/0x30
[   12.662752]        init_module+0x70/0xfc4 [tyr]
[   12.663157]        do_one_initcall+0x114/0x4b4
[   12.663551]        do_init_module+0x54/0x220
[   12.663927]        load_module+0x1754/0x1984
[   12.664302]        __arm64_sys_init_module+0x184/0x23c
[   12.664755]        invoke_syscall+0x48/0xf8
[   12.665125]        el0_svc_common+0x90/0xdc
[   12.665494]        do_el0_svc+0x1c/0x28
[   12.665833]        el0_svc+0x54/0x258
[   12.666159]        el0t_64_sync_handler+0x78/0x12c
[   12.666582]        el0t_64_sync+0x198/0x19c
[   12.666948]=20
[   12.666948] -> #0 =
(drivers/gpu/drm/tyr/reset/hw_gate.rs:42){+.+.}-{4:4}:
[   12.667665]        __lock_acquire+0x18b4/0x3208
[   12.668062]        lock_acquire+0x110/0x300
[   12.668429]        __mutex_lock_common+0xec/0x1490
[   12.668851]        mutex_lock_nested+0x2c/0x38
[   12.669242]        rust_helper_mutex_lock+0x14/0x20
[   12.669671]        =
_RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19AddressSpaceManage=
r13as_wait_ready+0x28/0x108 [tyr]
[   12.670670]        =
_RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19AddressSpaceManage=
r11as_send_cmd+0x24/0xb0 [tyr]
[   12.671645]        =
_RNvXs_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB4_19AddressSpaceManager=
NtNtB8_4slot14SlotOperations8activate+0x2dc/0x3ac [tyr]
[   12.672807]        =
_RNvMs0_NtCs8XoewxZdfnt_3tyr2fwNtB5_8Firmware3new+0x12d4/0x184c [tyr]
[   12.673520]        =
_RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformDriverNtNtCsbuTvttuFvbr_=
6kernel8platform6Driver5probe+0x368/0x470 [tyr]
[   12.674622]        =
_RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7AdapterNtNtCs8XoewxZdfnt_3t=
yr6driver17TyrPlatformDriverE14probe_callbackBT_+0x44/0x10c [tyr]
[   12.675860]        platform_probe+0x68/0xa4
[   12.676228]        really_probe+0x198/0x42c
[   12.676596]        __driver_probe_device+0xc8/0x190
[   12.677024]        driver_probe_device+0x40/0x240
[   12.677437]        __driver_attach+0xf8/0x294
[   12.677818]        bus_for_each_dev+0xec/0x144
[   12.678210]        driver_attach+0x24/0x30
[   12.678570]        bus_add_driver+0x158/0x2a8
[   12.678951]        driver_register+0x68/0x100
[   12.679334]        __platform_driver_register+0x24/0x30
[   12.679792]        init_module+0x70/0xfc4 [tyr]
[   12.680196]        do_one_initcall+0x114/0x4b4
[   12.680589]        do_init_module+0x54/0x220
[   12.680964]        load_module+0x1754/0x1984
[   12.681338]        __arm64_sys_init_module+0x184/0x23c
[   12.681790]        invoke_syscall+0x48/0xf8
[   12.682159]        el0_svc_common+0x90/0xdc
[   12.682529]        do_el0_svc+0x1c/0x28
[   12.682868]        el0_svc+0x54/0x258
[   12.683193]        el0t_64_sync_handler+0x78/0x12c
[   12.683615]        el0t_64_sync+0x198/0x19c
[   12.683982]=20
[   12.683982] other info that might help us debug this:
[   12.683982]=20
[   12.684677]  Possible unsafe locking scenario:
[   12.684677]=20
[   12.685192]        CPU0                    CPU1
[   12.685586]        ----                    ----
[   12.685981]   rlock(drivers/gpu/drm/tyr/reset/hw_gate.rs:43);
[   12.686483]                                =
lock(drivers/gpu/drm/tyr/reset/hw_gate.rs:42);
[   12.687196]                                =
lock(drivers/gpu/drm/tyr/reset/hw_gate.rs:43);
[   12.687908]   lock(drivers/gpu/drm/tyr/reset/hw_gate.rs:42);
[   12.688403]=20
[   12.688403]  *** DEADLOCK ***
[   12.688403]=20
[   12.688917] 3 locks held by modprobe/167:
[   12.689268]  #0: ffff0001f0ee3938 (&dev->mutex){....}-{4:4}, at: =
__driver_attach+0xec/0x294
[   12.690004]  #1: ffff0001f3573468 =
(drivers/gpu/drm/tyr/mmu.rs:76){+.+.}-{4:4}, at: =
rust_helper_mutex_lock+0x14/0x20
[   12.690921]  #2: ffff0001f1713cc0 =
(drivers/gpu/drm/tyr/reset/hw_gate.rs:43){.+.+}-{0:0}, at: =
srcu_lock_acquire+0x4/0x40
[   12.691869]=20
[   12.691869] stack backtrace:
[   12.692250] CPU: 4 UID: 0 PID: 167 Comm: modprobe Not tainted =
7.1.0-rc5-g991a312b28c2 #1 PREEMPT=20
[   12.692255] Hardware name: Radxa ROCK 5B (DT)
[   12.692257] Call trace:
[   12.692258]  show_stack+0x18/0x24 (C)
[   12.692266]  dump_stack_lvl+0x40/0x9c
[   12.692272]  dump_stack+0x18/0x24
[   12.692278]  print_circular_bug+0x324/0x32c
[   12.692283]  check_noncircular+0x15c/0x178
[   12.692287]  __lock_acquire+0x18b4/0x3208
[   12.692291]  lock_acquire+0x110/0x300
[   12.692295]  __mutex_lock_common+0xec/0x1490
[   12.692300]  mutex_lock_nested+0x2c/0x38
[   12.692306]  rust_helper_mutex_lock+0x14/0x20
[   12.692311]  =
_RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19AddressSpaceManage=
r13as_wait_ready+0x28/0x108 [tyr]
[   12.692323]  =
_RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19AddressSpaceManage=
r11as_send_cmd+0x24/0xb0 [tyr]
[   12.692334]  =
_RNvXs_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB4_19AddressSpaceManager=
NtNtB8_4slot14SlotOperations8activate+0x2dc/0x3ac [tyr]
[   12.692346]  =
_RNvMs0_NtCs8XoewxZdfnt_3tyr2fwNtB5_8Firmware3new+0x12d4/0x184c [tyr]
[   12.692357]  =
_RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformDriverNtNtCsbuTvttuFvbr_=
6kernel8platform6Driver5probe+0x368/0x470 [tyr]
[   12.692368]  =
_RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7AdapterNtNtCs8XoewxZdfnt_3t=
yr6driver17TyrPlatformDriverE14probe_callbackBT_+0x44/0x10c [tyr]
[   12.692379]  platform_probe+0x68/0xa4
[   12.692385]  really_probe+0x198/0x42c
[   12.692389]  __driver_probe_device+0xc8/0x190
[   12.692393]  driver_probe_device+0x40/0x240
[   12.692398]  __driver_attach+0xf8/0x294
[   12.692402]  bus_for_each_dev+0xec/0x144
[   12.692409]  driver_attach+0x24/0x30
[   12.692413]  bus_add_driver+0x158/0x2a8
[   12.692416]  driver_register+0x68/0x100
[   12.692420]  __platform_driver_register+0x24/0x30
[   12.692426]  init_module+0x70/0xfc4 [tyr]
[   12.692437]  do_one_initcall+0x114/0x4b4
[   12.692443]  do_init_module+0x54/0x220
[   12.692447]  load_module+0x1754/0x1984
[   12.692451]  __arm64_sys_init_module+0x184/0x23c
[   12.692458]  invoke_syscall+0x48/0xf8
[   12.692464]  el0_svc_common+0x90/0xdc
[   12.692470]  do_el0_svc+0x1c/0x28
[   12.692476]  el0_svc+0x54/0x258
[   12.692482]  el0t_64_sync_handler+0x78/0x12c
[   12.692489]  el0t_64_sync+0x198/0x19c

I suggest that we take the gate only once per public AS operation, and =
pass
&IoMem to the lower layers as needed. This has the side effect of making =
the
whole AS op atomic w.r.t to resets, which does not appear to be the case =
today,
as we nest calls to access(). Additionally, we can reintroduce the &mut =
self's
that were removed to make this compile; which I'd prefer. This can =
probably be
done by cloning the Arc<HwGate>, so it doesn't borrow self, i.e.:

let hw =3D self.hw.clone();
let guard =3D hw.access(); // doesn't borrow self

-- Daniel



