Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EB6C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD9910E3D7;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edu-teu-ac-jp.20251104.gappssmtp.com header.i=@edu-teu-ac-jp.20251104.gappssmtp.com header.b="0Ngyz/5l";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E9510E4EA
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 17:17:49 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 d75a77b69052e-52fb766bfd6so16765611cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 10:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789838268; cv=none;
 d=google.com; s=arc-20260327;
 b=QEjWuU/sWoDLpbYtly/oKRftM6z0BiogxKtNNZmgsMnzu4NS16YjYEMNYnQ5g7aU1K
 hd+knNDAXh8D53DPyLXAb6sOT60s+dsBClVfoB5zhYT7VjDeRIA6XsyBd4S/roXlPIBc
 ONbOAZ3pZkotbBslcEF/0j7MkhT3SpxbbgfxakLjk87S/0klFj/o9dJM2r7ngBB9to8A
 BSUp1DCXsi4HeaFrrn5OF2wn8Co4cJnNk1j3ADL4xDVvu3NebmTLSo6l71ljJs80zurl
 zIhGJNYbWcirzX2/5yzLH4615hn9MUQeIy0FTeYyZTCw3njYX1pUuWhHN/TFhqr+QiM8
 KPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=R7Ve6g6OCN8ExCi1nsElpX9hN7po+G0Rv1PjpYZh+Sk=;
 fh=710RK7yHHFZ1ldWII+eVJX/YjRhLfMkLChYTC2AP0Xk=;
 b=KvdPNZd1XMtG53+yw/2izNiPPG60MAxNsjK7KuLhmyibe6K0HL11m3pXkSJ1MzJx9i
 7kh+wzdlNYd09n/uNXaF2ExuDgq2hxP+Dj7jbRkSqmW38oJLkhfaPNYzNBNjTzUqmbcg
 GRxQvapF12MtfKc/Hh+7Yymxyi3PG36N6i5BgreZpdb0v/qMK/7b0x9V7d5Lq6gMc9fn
 a0Vbom5bOqv5T3INMKuPhcOYK1BkqvO8OzPLqlHql98qWnSM4FfDvzHy2OZ7TWkHGlox
 K1TU2T6GPvSJYNGgi5DlU+AUsmiCCtSONYh75zZ0Uwvc+ujyiJpZIQ0M5ZMmYesnVomB
 1P0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edu-teu-ac-jp.20251104.gappssmtp.com; s=20251104; t=1789838268; x=1790443068;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R7Ve6g6OCN8ExCi1nsElpX9hN7po+G0Rv1PjpYZh+Sk=;
 b=0Ngyz/5lLySNE6xsxpfhxSiXWl/tnDag/bugkPWbgrAmyNTNVu42CsoJqO3VbN5xwy
 hKjJyKntiDGvfCWTheAvsVeOvioZUsQ6Yx7NJEDU0rHhj6GLJMHGQ1nsrTQOrccgOYNg
 C1Fj/O/8jtliPqz6FelisGTzXjYp+A9fiI471Q9KjZN+PAQt/zUXyL/q3G+na+3Qbe90
 DI++Tco9AT3VH8LZMHyueNP6/4j5CDiUPYfqA5C8aHsh4LkKIJm0yYAAghxDEZW20CDU
 j3bdWTxtA4VodXB2JHx69xH4QLuK9vd1466yaYfzeYsCUWPvlUely4jj0wOxC6Q1rzS/
 YU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789838268; x=1790443068;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R7Ve6g6OCN8ExCi1nsElpX9hN7po+G0Rv1PjpYZh+Sk=;
 b=VfNyPyr3FyMF32ZMPqTuhjOZ1+NCnvGI7oMYN6GmpNXfy4WinX6SsYKydi26gi2sUT
 SGojmUHh0BkLieSan4UKq2dGE0k3r1vE4xm/zPLFsntsUag33PBJiXt+g3ZuQ4+atlCc
 F1UQw08UimnKkzMBAN6XfLt3whhQHM9EEGyVW13G+Mwpyn+vNLSdBSn/M1UUNPX/6lpR
 ThcM+3fk34TByIxhWstIqgt9f0mubUOrKUAQZBZr0/pI975u7L6cMhu/UqTjyYA8AROa
 oHVY4MTQFx6hs+BfdTTT2ibqQN/kllDlnQBYg0X+Ki0GOgbw6NigNT5KJPNegX2Z8dBc
 l13w==
X-Gm-Message-State: AFuF++l5yCaHBjmlrKnM62z8fLwN7NrbAhKI8zGhvFbB67NQiuYyWQOm
 IrEGOhx3pVkW37OdKyIqNEbK0HFmT8uwolZQBS5QWz2XgeBk5BY7hxJ6iK5zLDh6p0Gq2sBWpLZ
 ThPqMtWef4Kdk5PwFi50x+MBtfuBcup3hsPWBYusP31F965IYmZ1u
X-Gm-Gg: AYBFou3rUFMjMj1Zdo5fYwjNHSwIRuOwmSKV4hVrDC1HirE2ggSrCFoApZj6fG3qegs
 Zb5Kxt5zF/9lfMWSA1pZGMsvcyBJPCkeOM1BQalJF/b63ugDUbKnRIVRdSSxGAPWsNVh0FjWr7r
 36ypWAYo2+XEmyKbMnAnTmLOEf6sC6i7RfUf+3L39q2DpVpOLi18OQjIGfBX7c6IRYU8d1FhhcS
 TLfU+Fap258vukCzUV5vLuNqlHEQ3OaYLV9KaXQ/GFXx0zx4by/iQQFCZYpcZ710he64v8Q+VmM
 Xqe5Py8lferakzMBL2QFElNe7CbiOFKb7Uvrl9TVrTAipnvEHJ6+1xPNeIsubHIf6dBAR63e4u4
 w2d0l33U7rmY=
X-Received: by 2002:ac8:7fcd:0:b0:532:9ef6:dfc0 with SMTP id
 d75a77b69052e-532b73a14f4mr25523091cf.53.1789838268482; Sat, 19 Sep 2026
 10:17:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 19 Sep 2026 12:17:48 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Sat, 19 Sep 2026 12:17:48 -0500
MIME-Version: 1.0
From: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>
Date: Sat, 19 Sep 2026 12:17:48 -0500
X-Gm-Features: AcwNN1U6eW3sJMNWTyX3MG-4-eOsK_LMjyjSvhVim6hgfUZWI9wia56GdOESNko
Message-ID: <CA+Y9VQPNWWGFqErKbbM+S2PcEXbJ30O71sA6h8s-+YVRMC51TQ@mail.gmail.com>
Subject: [REGRESSION] drm/ttm: NULL dereference in ttm_resource_add_bulk_move
 after OOM on Navi32
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

CachyOS package issue: https://github.com/CachyOS/linux-cachyos/issues/1058

Hi,

I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT. The
failure happened immediately after a global OOM condition and was followed by an
RCU stall and a host reset.

The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire Navi32 / RX
7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant userspace versions
were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.

The first failure in the affected boot was:

```text
kswapd0 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0
oom-kill: ... global_oom ...
Out of memory: Killed process <redacted>

amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for command submission!
WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235
    at ttm_resource_add_bulk_move+0x124/0x150 [ttm]
BUG: kernel NULL pointer dereference, address: 0000000000000008
Oops: Oops: 0000 [#1] SMP NOPTI
RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]
```

The call chain was:

```text
ttm_resource_add_bulk_move
ttm_resource_alloc
ttm_bo_swapout_cb
ttm_lru_walk_for_evict
ttm_bo_swapout
ttm_global_swapout
ttm_tt_populate
ttm_bo_populate
ttm_bo_vm_fault_reserved
amdgpu_gem_fault
```

After the Oops, an `amdgpu` KFD cleanup worker and an `amdgpu_drm_release`
path were both blocked on TTM-related spinlocks. The journal does not contain
`Kernel panic - not syncing`; I am calling this an Oops followed by a lockup or
reset, not a confirmed formal panic.

This looks related to the recent TTM fixes:

- [3db7d7d](https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8)
  fixes swapped-out resources remaining in a `bulk_move` range.
- [fcfe647](https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed)
  changes the cleanup condition after `ttm_tt_swapout()` from `if (!ret)` to
  `if (ret > 0)`.

I checked the source release used for `linux-cachyos 7.2.4-1`:
[`cachyos-7.2.4-1`](https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1).
It still contains:

```c
ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
if (!ret) {
        ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
        ttm_resource_move_to_lru_tail(bo->resource);
}
```

The installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, so the
installed binary also has the old zero-only condition. The CachyOS 7.2.4
packaging recipe does not list a TTM bulk-move patch. The current
`cachyos-7.2.6-1` source release also still contains `if (!ret)` at this call
site; 7.2.6 has not been boot-tested on the affected host.

The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and
`UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`.

Does this match the stale `bulk_move` endpoint issue fixed by
`3db7d7d`/`fcfe647`,
and should those fixes be backported to kernels based on 7.2.4?
