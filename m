Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BB4C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 11:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6341510E0D2;
	Sat, 12 Sep 2026 11:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="qEkVgEMX";
	dkim-atps=neutral
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F0D10E0D2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1789211415; x=1789470615;
 bh=brHblU+c7r3MzG9dIZ+DO2MZ/5N6mzTS5GxaXqzuGRA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qEkVgEMXLzufGhROLJ76Gi910eT3sMOX0sqNYXUrzSkKkLPguKlX5qS3FDFMeF9fl
 PgunjSNhtizsENQzv3Pqb9aOrENcWy4hNQ2wJNm0teOdxRYGxegBzjD+TmXjBGLjoh
 ytd34upXrwm6w18NbcmzOiyIZyubljlmbfM1Prwy22ANwKCDiS/PzXLYIDarkAqLIU
 I54h4ijWeuP6DcTggVVK5dW6R4cDxx0Km+uxJy/A8d4MrMqRR+XqGWdc9oxeLLWnor
 xDmR5iaWz91w0vumq6VDHQHfP0EDMjFV4L8JjtxIOdXKlblaXwWx5N9K8nHYtY5cb3
 eGhFMAqNWMpcw==
X-Pm-Submission-Id: 4hhpbm6L9Mz1DDs3
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v6 3/3] drm/tyr: put iomem behind the hardware gate
Date: Sat, 12 Sep 2026 14:10:07 +0300
Message-ID: <20260912111011.5274-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <39E7E24E-147C-4894-AD8F-095B60FDA955@collabora.com>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-3-7b4e1e041fe5@onurozkan.dev>
 <39E7E24E-147C-4894-AD8F-095B60FDA955@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 24 Aug 2026 14:05:11 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> Hi Onur,=0D
> =0D
> =0D
> While testing this patch, I came across the following splat:=0D
> =0D
> =0D
> [   12.648287] WARNING: possible circular locking dependency detected=0D
> [   12.648826] 7.1.0-rc5-g991a312b28c2 #1 Not tainted=0D
> [   12.649245] ------------------------------------------------------=0D
> [   12.649782] modprobe/167 is trying to acquire lock:=0D
> [   12.650208] ffff0001f1713c80 (drivers/gpu/drm/tyr/reset/hw_gate.rs:42)=
{+.+.}-{4:4}, at: rust_helper_mutex_lock+0x14/0x20=0D
> [   12.651169] =0D
> [   12.651169] but task is already holding lock:=0D
> [   12.651677] ffff0001f1713cc0 (drivers/gpu/drm/tyr/reset/hw_gate.rs:43)=
{.+.+}-{0:0}, at: srcu_lock_acquire+0x4/0x40=0D
> [   12.652588] =0D
> [   12.652588] which lock already depends on the new lock.=0D
> [   12.652588] =0D
> [   12.653299] =0D
> [   12.653299] the existing dependency chain (in reverse order) is:=0D
> [   12.653948] =0D
> [   12.653948] -> #1 (drivers/gpu/drm/tyr/reset/hw_gate.rs:43){.+.+}-{0:0=
}:=0D
> [   12.654664]        srcu_lock_sync+0x30/0x3c=0D
> [   12.655035]        __synchronize_srcu+0x58/0x180=0D
> [   12.655441]        synchronize_srcu+0x20c/0x28c=0D
> [   12.655838]        _RNvNtCs8XoewxZdfnt_3tyr5reset9run_reset+0x3c/0x1d4=
 [tyr]=0D
> [   12.656469]        _RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformD=
riverNtNtCsbuTvttuFvbr_6kernel8platform6Driver5probe+0x254/0x470 [tyr]=0D
> [   12.657573]        _RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7Adap=
terNtNtCs8XoewxZdfnt_3tyr6driver17TyrPlatformDriverE14probe_callbackBT_+0x4=
4/0x10c [tyr]=0D
> [   12.658812]        platform_probe+0x68/0xa4=0D
> [   12.659182]        really_probe+0x198/0x42c=0D
> [   12.659551]        __driver_probe_device+0xc8/0x190=0D
> [   12.659979]        driver_probe_device+0x40/0x240=0D
> [   12.660392]        __driver_attach+0xf8/0x294=0D
> [   12.660775]        bus_for_each_dev+0xec/0x144=0D
> [   12.661168]        driver_attach+0x24/0x30=0D
> [   12.661528]        bus_add_driver+0x158/0x2a8=0D
> [   12.661910]        driver_register+0x68/0x100=0D
> [   12.662293]        __platform_driver_register+0x24/0x30=0D
> [   12.662752]        init_module+0x70/0xfc4 [tyr]=0D
> [   12.663157]        do_one_initcall+0x114/0x4b4=0D
> [   12.663551]        do_init_module+0x54/0x220=0D
> [   12.663927]        load_module+0x1754/0x1984=0D
> [   12.664302]        __arm64_sys_init_module+0x184/0x23c=0D
> [   12.664755]        invoke_syscall+0x48/0xf8=0D
> [   12.665125]        el0_svc_common+0x90/0xdc=0D
> [   12.665494]        do_el0_svc+0x1c/0x28=0D
> [   12.665833]        el0_svc+0x54/0x258=0D
> [   12.666159]        el0t_64_sync_handler+0x78/0x12c=0D
> [   12.666582]        el0t_64_sync+0x198/0x19c=0D
> [   12.666948] =0D
> [   12.666948] -> #0 (drivers/gpu/drm/tyr/reset/hw_gate.rs:42){+.+.}-{4:4=
}:=0D
> [   12.667665]        __lock_acquire+0x18b4/0x3208=0D
> [   12.668062]        lock_acquire+0x110/0x300=0D
> [   12.668429]        __mutex_lock_common+0xec/0x1490=0D
> [   12.668851]        mutex_lock_nested+0x2c/0x38=0D
> [   12.669242]        rust_helper_mutex_lock+0x14/0x20=0D
> [   12.669671]        _RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNt=
B5_19AddressSpaceManager13as_wait_ready+0x28/0x108 [tyr]=0D
> [   12.670670]        _RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNt=
B5_19AddressSpaceManager11as_send_cmd+0x24/0xb0 [tyr]=0D
> [   12.671645]        _RNvXs_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB=
4_19AddressSpaceManagerNtNtB8_4slot14SlotOperations8activate+0x2dc/0x3ac [t=
yr]=0D
> [   12.672807]        _RNvMs0_NtCs8XoewxZdfnt_3tyr2fwNtB5_8Firmware3new+0=
x12d4/0x184c [tyr]=0D
> [   12.673520]        _RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformD=
riverNtNtCsbuTvttuFvbr_6kernel8platform6Driver5probe+0x368/0x470 [tyr]=0D
> [   12.674622]        _RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7Adap=
terNtNtCs8XoewxZdfnt_3tyr6driver17TyrPlatformDriverE14probe_callbackBT_+0x4=
4/0x10c [tyr]=0D
> [   12.675860]        platform_probe+0x68/0xa4=0D
> [   12.676228]        really_probe+0x198/0x42c=0D
> [   12.676596]        __driver_probe_device+0xc8/0x190=0D
> [   12.677024]        driver_probe_device+0x40/0x240=0D
> [   12.677437]        __driver_attach+0xf8/0x294=0D
> [   12.677818]        bus_for_each_dev+0xec/0x144=0D
> [   12.678210]        driver_attach+0x24/0x30=0D
> [   12.678570]        bus_add_driver+0x158/0x2a8=0D
> [   12.678951]        driver_register+0x68/0x100=0D
> [   12.679334]        __platform_driver_register+0x24/0x30=0D
> [   12.679792]        init_module+0x70/0xfc4 [tyr]=0D
> [   12.680196]        do_one_initcall+0x114/0x4b4=0D
> [   12.680589]        do_init_module+0x54/0x220=0D
> [   12.680964]        load_module+0x1754/0x1984=0D
> [   12.681338]        __arm64_sys_init_module+0x184/0x23c=0D
> [   12.681790]        invoke_syscall+0x48/0xf8=0D
> [   12.682159]        el0_svc_common+0x90/0xdc=0D
> [   12.682529]        do_el0_svc+0x1c/0x28=0D
> [   12.682868]        el0_svc+0x54/0x258=0D
> [   12.683193]        el0t_64_sync_handler+0x78/0x12c=0D
> [   12.683615]        el0t_64_sync+0x198/0x19c=0D
> [   12.683982] =0D
> [   12.683982] other info that might help us debug this:=0D
> [   12.683982] =0D
> [   12.684677]  Possible unsafe locking scenario:=0D
> [   12.684677] =0D
> [   12.685192]        CPU0                    CPU1=0D
> [   12.685586]        ----                    ----=0D
> [   12.685981]   rlock(drivers/gpu/drm/tyr/reset/hw_gate.rs:43);=0D
> [   12.686483]                                lock(drivers/gpu/drm/tyr/re=
set/hw_gate.rs:42);=0D
> [   12.687196]                                lock(drivers/gpu/drm/tyr/re=
set/hw_gate.rs:43);=0D
> [   12.687908]   lock(drivers/gpu/drm/tyr/reset/hw_gate.rs:42);=0D
> [   12.688403] =0D
> [   12.688403]  *** DEADLOCK ***=0D
> [   12.688403] =0D
> [   12.688917] 3 locks held by modprobe/167:=0D
> [   12.689268]  #0: ffff0001f0ee3938 (&dev->mutex){....}-{4:4}, at: __dri=
ver_attach+0xec/0x294=0D
> [   12.690004]  #1: ffff0001f3573468 (drivers/gpu/drm/tyr/mmu.rs:76){+.+.=
}-{4:4}, at: rust_helper_mutex_lock+0x14/0x20=0D
> [   12.690921]  #2: ffff0001f1713cc0 (drivers/gpu/drm/tyr/reset/hw_gate.r=
s:43){.+.+}-{0:0}, at: srcu_lock_acquire+0x4/0x40=0D
> [   12.691869] =0D
> [   12.691869] stack backtrace:=0D
> [   12.692250] CPU: 4 UID: 0 PID: 167 Comm: modprobe Not tainted 7.1.0-rc=
5-g991a312b28c2 #1 PREEMPT =0D
> [   12.692255] Hardware name: Radxa ROCK 5B (DT)=0D
> [   12.692257] Call trace:=0D
> [   12.692258]  show_stack+0x18/0x24 (C)=0D
> [   12.692266]  dump_stack_lvl+0x40/0x9c=0D
> [   12.692272]  dump_stack+0x18/0x24=0D
> [   12.692278]  print_circular_bug+0x324/0x32c=0D
> [   12.692283]  check_noncircular+0x15c/0x178=0D
> [   12.692287]  __lock_acquire+0x18b4/0x3208=0D
> [   12.692291]  lock_acquire+0x110/0x300=0D
> [   12.692295]  __mutex_lock_common+0xec/0x1490=0D
> [   12.692300]  mutex_lock_nested+0x2c/0x38=0D
> [   12.692306]  rust_helper_mutex_lock+0x14/0x20=0D
> [   12.692311]  _RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19A=
ddressSpaceManager13as_wait_ready+0x28/0x108 [tyr]=0D
> [   12.692323]  _RNvMs0_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB5_19A=
ddressSpaceManager11as_send_cmd+0x24/0xb0 [tyr]=0D
> [   12.692334]  _RNvXs_NtNtCs8XoewxZdfnt_3tyr3mmu13address_spaceNtB4_19Ad=
dressSpaceManagerNtNtB8_4slot14SlotOperations8activate+0x2dc/0x3ac [tyr]=0D
> [   12.692346]  _RNvMs0_NtCs8XoewxZdfnt_3tyr2fwNtB5_8Firmware3new+0x12d4/=
0x184c [tyr]=0D
> [   12.692357]  _RNvXNtCs8XoewxZdfnt_3tyr6driverNtB2_17TyrPlatformDriverN=
tNtCsbuTvttuFvbr_6kernel8platform6Driver5probe+0x368/0x470 [tyr]=0D
> [   12.692368]  _RNvMs0_NtCsbuTvttuFvbr_6kernel8platformINtB5_7AdapterNtN=
tCs8XoewxZdfnt_3tyr6driver17TyrPlatformDriverE14probe_callbackBT_+0x44/0x10=
c [tyr]=0D
> [   12.692379]  platform_probe+0x68/0xa4=0D
> [   12.692385]  really_probe+0x198/0x42c=0D
> [   12.692389]  __driver_probe_device+0xc8/0x190=0D
> [   12.692393]  driver_probe_device+0x40/0x240=0D
> [   12.692398]  __driver_attach+0xf8/0x294=0D
> [   12.692402]  bus_for_each_dev+0xec/0x144=0D
> [   12.692409]  driver_attach+0x24/0x30=0D
> [   12.692413]  bus_add_driver+0x158/0x2a8=0D
> [   12.692416]  driver_register+0x68/0x100=0D
> [   12.692420]  __platform_driver_register+0x24/0x30=0D
> [   12.692426]  init_module+0x70/0xfc4 [tyr]=0D
> [   12.692437]  do_one_initcall+0x114/0x4b4=0D
> [   12.692443]  do_init_module+0x54/0x220=0D
> [   12.692447]  load_module+0x1754/0x1984=0D
> [   12.692451]  __arm64_sys_init_module+0x184/0x23c=0D
> [   12.692458]  invoke_syscall+0x48/0xf8=0D
> [   12.692464]  el0_svc_common+0x90/0xdc=0D
> [   12.692470]  do_el0_svc+0x1c/0x28=0D
> [   12.692476]  el0_svc+0x54/0x258=0D
> [   12.692482]  el0t_64_sync_handler+0x78/0x12c=0D
> [   12.692489]  el0t_64_sync+0x198/0x19c=0D
> =0D
> I suggest that we take the gate only once per public AS operation, and pa=
ss=0D
> &IoMem to the lower layers as needed. This has the side effect of making =
the=0D
> whole AS op atomic w.r.t to resets, which does not appear to be the case =
today,=0D
> as we nest calls to access(). Additionally, we can reintroduce the &mut s=
elf's=0D
> that were removed to make this compile; which I'd prefer. This can probab=
ly be=0D
> done by cloning the Arc<HwGate>, so it doesn't borrow self, i.e.:=0D
> =0D
> let hw =3D self.hw.clone();=0D
> let guard =3D hw.access(); // doesn't borrow self=0D
> =0D
> -- Daniel=0D
> =0D
=0D
Hi Daniel,=0D
=0D
I fixed this in v7 [1] and tested on Orange Pi, the deadlock shouldn't happ=
en=0D
anymore.=0D
=0D
[1]: https://lore.kernel.org/all/20260912-tyr-reset-impl-v7-0-077ce72084eb@=
onurozkan.dev=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> =0D
