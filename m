Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E88C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2683A10EA2A;
	Fri, 25 Sep 2026 09:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edu-teu-ac-jp.20251104.gappssmtp.com header.i=@edu-teu-ac-jp.20251104.gappssmtp.com header.b="EYv5CVA2";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC9310EA2A
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:03:24 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 d75a77b69052e-530d8a00bcdso5457371cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790327003; cv=none;
 d=google.com; s=arc-20260327;
 b=HfhmvzL4YmtcMlM1EPzgq01ga4dI42u9MOMB2dmUT4JW+62Q5m7cemgHVSwZtw7rq+
 ypfc7C4khDiBHjBfdUxHgur2/7bIicpNWgo0QJ1AvDEL4Hp1sSIES5EKWjM0tK+zrTk5
 JMf/rBbL5GoKcYgmNbVQ/1k8pWr7UdANnTEU6gYVmYBPBfAKOpTsUgebPc7ooYYXHHZt
 kyukUp7AcKEst4fOwULhjQUXQgjhL/4X/Pu1naBNB5IBgtZzKUk9sZJP7Nxp/Ztavuwl
 iPtu6knxZraQDQ5a8ccMUcOt+SAN3kmYTQwgMcZ4zY8fceiEH7UnOFRt1ow6ad/m2q+k
 7dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=UUM1cagg6+KsxznGPIESuErtkI8Q27s07XUtQoLKiL8=;
 fh=JEGSdrxhcysQVgf15gCITfV2iBJwaoFmc4m8htrWF20=;
 b=CVwAIXcMLk+nKBgSy0bJr4JRfB4jxKn3n0IIM7d8ZV9D+VHVHoA+BIljVelB+OJHo2
 jxO0jQq+eVN5QloZSh1mbCqoVFH0N8gEb0bAoi/Idzdskjm1LTWRtv1LEHAbRQgX/d9T
 0wSxTmx6Z9+16O1b0ZAjAqSM2MVzOZyR+qjM9g0BRZcPX4LfpPStV06MGQWCiW1e8IoE
 JcNhFmAE1SO7Prv1wRJuSLlZleOQ2eXx6wJ45dHH3c7bzY7SeB4KPEO4JDSl4k+kypad
 Cv0WsoWSz0aFK7C3CT9b5KNwd6RZ9wv7/CiXFC+bppVIwz9dXtAJLRkmmuzaPaO1mk+2
 76GA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edu-teu-ac-jp.20251104.gappssmtp.com; s=20251104; t=1790327003; x=1790931803;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UUM1cagg6+KsxznGPIESuErtkI8Q27s07XUtQoLKiL8=;
 b=EYv5CVA2/TWNaNQTgSFqJ22lxALnjTaalbehgTNif5aIXOov9ALXllp027w4hOtOWV
 YzN4Xkviev13UIx+KUV38CdKswPhmgk5qIXP5dYR0DbEBbsiCPe1no4rQc/ZgVEP2rqj
 zW0ta2rHRZ1GL/GCZR3kY8N6gXx5A3wliNSDVMmmBMT3pr9+xwDBEblbkcyb38E4H/fK
 z4ZiRF1EE4+9y0KCxHfpR8FBS2ELEcSkEFWZpj/i8C5Swqk+g1tSXL2MfS8/7vN72Qv4
 zKn3AXv1nizr4deOtVFDRXgDm28wOb2y5dkZMJoUFbMm6ZKUfqPUiE9M5Pjxzfr37FzJ
 zzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790327003; x=1790931803;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UUM1cagg6+KsxznGPIESuErtkI8Q27s07XUtQoLKiL8=;
 b=id3JEExPfy5eLJDeq31lvWuthUg3mMy1iJbegcrvKhEGjxzUWyAAuSmssqVaA5A8BD
 84C3ceBnw2fzi9p4DvJkJLSuV0TVcv0dyWtI3qYbLMzFZ3AkH/dIFjAgBBvIpFrFu0Zr
 p1U2elb8mSjsj1IakdLm4L6UuXiLYrRQG/FH2vmfVKIeZgp47rZKbM5tDQs0C7WIANlV
 0AP+6gT54GXyFmmP6t7x1vHAnhhKvizn3jD7097+1pjgkj7cCxUjJ2w5Pt8UxSLFLLzS
 D9BlXmfv0i+iUfXgJO/XWcJYr0/O2RxcVABju5IBKOrpo3Ug8+rtKUrtikan993lcQ/2
 f3sw==
X-Gm-Message-State: AFuF++kQAO/DQEjUFB01+inVfEs3qQvk3cUW0LInuVRm88XuBYNB4WY6
 B+4wrUDmVXLuWmsj3//zD7z0cWVIqSZGtU0zAaU5kNWbm+tPu09CwqCNKRdk/uCDjZGvv7s8FZF
 tN1Nyb89fgmJl3EwXdexhPdJKi8GmFeO4xwNakYMEBBeGKKWIaRvWWyQ=
X-Gm-Gg: AYBFou3EAAU98Ub3E315MXUuAR8/PRqgsnlQH1ShzIsvNCcQzCwiW6mkOeJTA+1c6uc
 XiteRL7DljtohZMK8nh/SVqEAI4w3JUgsm9ED7rwKpAkewZlmOB7C1uwcy8iwdBT6F3KQ9squbt
 mHTTRLHp0nHQ+Qoo+37sIlqcYDJwh33i+8zD0ofZrxuu6zt8xI6yfh5AUNI2vNHsOxs2wzUmk3+
 L0O6VTgZEdg19s7t3gwavD8f/YnXIzJfxXGVJf6VKKXPeVWRAzr2A5vH7ufNSFkqSdnm81gUmlX
 wsUr4aoNiCW9/OyP2DG7O3GRE3hP8AGb1J/a1SbUCvxQ+qs6a2nqs8XSTK0+2FNS/0BDDVACFXY
 waPW+lSYwNrmYan8OQzBYFx6fA3CWkgsPtBplVCCDf+kMOg==
X-Received: by 2002:a05:622a:107:b0:531:175b:97e6 with SMTP id
 d75a77b69052e-5330b6d438amr32216001cf.54.1790327002921; Fri, 25 Sep 2026
 02:03:22 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>
Date: Fri, 25 Sep 2026 18:03:11 +0900
X-Gm-Features: AclHuK8uKIwMszV9uZI9jsv9hA3ReCxL7ah2w9L2B8U3f-2prJhiHot9xZdxkRc
Message-ID: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
Subject: [REGRESSION] drm/ttm: NULL dereference in ttm_resource_add_bulk_move
 after OOM on Navi32
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, bub4z0r@gmail.com, 
 thomas.hellstrom@linux.intel.com, christian.koenig@amd.com
Content-Type: multipart/alternative; boundary="0000000000000a8c02065c4afda9"
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

--0000000000000a8c02065c4afda9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT.
The
failure happened immediately after a global OOM condition and was followed
by an
RCU stall and a host reset.

The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire Navi32 /
RX
7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant userspace
versions
were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.

The first failure in the affected boot was:

kswapd0 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0
oom-kill: ... global_oom ... task_memcg=3D<redacted>, task=3Dllama-server
Out of memory: Killed process <pid> (llama-server)

amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for command submission=
!
WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at
ttm_resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRenderThread
/2457
BUG: kernel NULL pointer dereference, address: 0000000000000008
Oops: Oops: 0000 [#1] SMP NOPTI
RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]

The call chain was:

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

After the Oops, an `amdgpu` KFD cleanup worker and an `amdgpu_drm_release`
path were both blocked on TTM-related spinlocks. The journal does not
contain
`Kernel panic - not syncing`; I am calling this an Oops followed by a
lockup or
reset, not a confirmed formal panic.

This is consistent with the stale `bulk_move` endpoint bug introduced by
`b2ed01e7ad3d` ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout
failure", v7.1+): `ttm_tt_swapout()` returns the number of pages swapped on
success (never zero for a populated ttm), so the
`ttm_resource_del_bulk_move_unevictable()` /
`ttm_resource_move_to_lru_tail()` pair under `if (!ret)` is skipped on ever=
y
successful swapout. A swapped-out resource stays inside its BO's bulk_move
range while unevictable; a later `ttm_resource_free()` /
`ttm_bo_set_bulk_move()` skips it via the `!ttm_resource_unevictable()`
guard, leaving a dangling range endpoint. Upstream names
`ttm_resource_add_bulk_move()` as one of the places that trips over that
cursor (a use-after-free on the dangling endpoint) =E2=80=94 exactly the fu=
nction
my NULL dereference hit at `+0xc9`.

The trigger on my system differs from the hibernation cycles reported in
https://gitlab.freedesktop.org/drm/amd/-/issues/5387: here the swapout was
driven by runtime memory pressure =E2=80=94 a global OOM followed by
`ttm_global_swapout()` reached from
`amdgpu_gem_fault()`/`ttm_tt_populate()`.
If the mechanism is the same, the defect is not suspend-specific; any
memory-pressure eviction pass can leave the stale endpoint.

The upstream fix history is worth noting:

- 3db7d7d <
https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802db=
b25cf8
>
  was the intended fix, but it was applied to the wrong `if`: it changed
  `if (ret)` to `if (ret > 0)` after `ttm_resource_try_charge()` in
  `ttm_bo_alloc_at_place()` (a separate dmem-charge bypass) and left the
  `if (!ret)` after `ttm_tt_swapout()` untouched. A kernel carrying only
  `3db7d7d` therefore still has the original bug.
- fcfe647 <
https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f35=
37ceed
>
  applies the intended `if (ret > 0)` at the swapout site and restores the
  charge check (`Cc: stable # v7.1+`).

I checked the source release used for `linux-cachyos 7.2.4-1`:
`cachyos-7.2.4-1` <
https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1>.
It still contains:

ret =3D ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
if (!ret) {
        ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
        ttm_resource_move_to_lru_tail(bo->resource);
}

The installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, so
the
installed binary also has the old zero-only condition. The CachyOS 7.2.4
PKGBUILD does not list a TTM bulk-move patch. Version check
(upstream sources):

- `v6.18.52` does not contain `b2ed01e7ad3d` =E2=80=94 it keeps the pre-cha=
nge
  structure: the resource is removed from the bulk_move before the
  swapout and re-added conditionally, so it is not affected.
- `v7.2.6` and `v7.2.7` still have `if (!ret)` at this site. The host now
  runs `7.2.6-1-cachyos` (booted) and its installed `ttm.ko` still shows th=
e
  same code generation.
- `v7.3-rc4` has the corrected `if (ret > 0)` form.

The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and
`UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`. For completeness:
the only out-of-tree module was `v4l2loopback` (a DKMS V4L2 loopback
device) =E2=80=94 not in the DRM/TTM path.

Caveats: I have not boot-tested a fixed kernel on this hardware =E2=80=94 n=
o
native kernel A/B was performed. The evidence above is source-level plus
disassembly of the installed `ttm.ko`; `drm/amd#5387` has the live
reproduction data on a different GPU.

Since `fcfe647` already carries `Cc: stable # v7.1+`, I assume the 7.2.y
backport is queued =E2=80=94 `7.2.7` (latest 7.2.y) still carries the bug. =
Two
things this report adds: (a) an independent hit through a non-hibernation
trigger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 all show the
old condition); (b) a heads-up that trees which picked up `3db7d7d`
alone are still buggy =E2=80=94 its one-line change landed on the wrong `if=
`, so
the intended swapout-site fix only exists in `fcfe647` (this
backport-unit warning is now also on public record via a comment on the
CachyOS issue). Does the crash signature above match the dangling-cursor
mechanism?

--0000000000000a8c02065c4afda9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>I hit a kernel Oops in the AMDGPU/TTM swap=
out path on a Radeon RX 7800 XT. The<br>failure happened immediately after =
a global OOM condition and was followed by an<br>RCU stall and a host reset=
.<br><br>The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire=
 Navi32 / RX<br>7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant =
userspace versions<br>were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and li=
bdrm `2.4.134-1.1`.<br><br>The first failure in the affected boot was:<br><=
br>kswapd0 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0<br>o=
om-kill: ... global_oom ... task_memcg=3D&lt;redacted&gt;, task=3Dllama-ser=
ver<br>Out of memory: Killed process &lt;pid&gt; (llama-server)<br><br>amdg=
pu 0000:03:00.0: [drm] *ERROR* Not enough memory for command submission!<br=
>WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at ttm_resource_add_bulk_m=
ove+0x124/0x150 [ttm], CPU#15: QSGRenderThread<br>/2457<br>BUG: kernel NULL=
 pointer dereference, address: 0000000000000008<br>Oops: Oops: 0000 [#1] SM=
P NOPTI<br>RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]<br><br>The call=
 chain was:<br><br>ttm_resource_add_bulk_move<br>ttm_resource_alloc<br>ttm_=
bo_swapout_cb<br>ttm_lru_walk_for_evict<br>ttm_bo_swapout<br>ttm_global_swa=
pout<br>ttm_tt_populate<br>ttm_bo_populate<br>ttm_bo_vm_fault_reserved<br>a=
mdgpu_gem_fault<br><br>After the Oops, an `amdgpu` KFD cleanup worker and a=
n `amdgpu_drm_release`<br>path were both blocked on TTM-related spinlocks. =
The journal does not contain<br>`Kernel panic - not syncing`; I am calling =
this an Oops followed by a lockup or<br>reset, not a confirmed formal panic=
.<br><br>This is consistent with the stale `bulk_move` endpoint bug introdu=
ced by<br>`b2ed01e7ad3d` (&quot;drm/ttm: Fix ttm_bo_swapout() infinite LRU =
walk on swapout<br>failure&quot;, v7.1+): `ttm_tt_swapout()` returns the nu=
mber of pages swapped on<br>success (never zero for a populated ttm), so th=
e<br>`ttm_resource_del_bulk_move_unevictable()` /<br>`ttm_resource_move_to_=
lru_tail()` pair under `if (!ret)` is skipped on every<br>successful swapou=
t. A swapped-out resource stays inside its BO&#39;s bulk_move<br>range whil=
e unevictable; a later `ttm_resource_free()` /<br>`ttm_bo_set_bulk_move()` =
skips it via the `!ttm_resource_unevictable()`<br>guard, leaving a dangling=
 range endpoint. Upstream names<br>`ttm_resource_add_bulk_move()` as one of=
 the places that trips over that<br>cursor (a use-after-free on the danglin=
g endpoint) =E2=80=94 exactly the function<br>my NULL dereference hit at `+=
0xc9`.<br><br>The trigger on my system differs from the hibernation cycles =
reported in<br><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/5=
387">https://gitlab.freedesktop.org/drm/amd/-/issues/5387</a>: here the swa=
pout was<br>driven by runtime memory pressure =E2=80=94 a global OOM follow=
ed by<br>`ttm_global_swapout()` reached from `amdgpu_gem_fault()`/`ttm_tt_p=
opulate()`.<br>If the mechanism is the same, the defect is not suspend-spec=
ific; any<br>memory-pressure eviction pass can leave the stale endpoint.<br=
><br>The upstream fix history is worth noting:<br><br>- 3db7d7d &lt;<a href=
=3D"https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e364188=
02dbb25cf8">https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e14=
1e36418802dbb25cf8</a>&gt;<br>=C2=A0 was the intended fix, but it was appli=
ed to the wrong `if`: it changed<br>=C2=A0 `if (ret)` to `if (ret &gt; 0)` =
after `ttm_resource_try_charge()` in<br>=C2=A0 `ttm_bo_alloc_at_place()` (a=
 separate dmem-charge bypass) and left the<br>=C2=A0 `if (!ret)` after `ttm=
_tt_swapout()` untouched. A kernel carrying only<br>=C2=A0 `3db7d7d` theref=
ore still has the original bug.<br>- fcfe647 &lt;<a href=3D"https://github.=
com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed">https:/=
/github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed<=
/a>&gt;<br>=C2=A0 applies the intended `if (ret &gt; 0)` at the swapout sit=
e and restores the<br>=C2=A0 charge check (`Cc: stable # v7.1+`).<br><br>I =
checked the source release used for `linux-cachyos 7.2.4-1`:<br>`cachyos-7.=
2.4-1` &lt;<a href=3D"https://github.com/CachyOS/linux/releases/tag/cachyos=
-7.2.4-1">https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1</a>=
&gt;.<br>It still contains:<br><br>ret =3D ttm_tt_swapout(bdev, tt, swapout=
_walk-&gt;gfp_flags);<br>if (!ret) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttm_res=
ource_del_bulk_move_unevictable(bo-&gt;resource, bo);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ttm_resource_move_to_lru_tail(bo-&gt;resource);<br>}<br><br>The =
installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, so the<b=
r>installed binary also has the old zero-only condition. The CachyOS 7.2.4<=
br>PKGBUILD does not list a TTM bulk-move patch. Version check<br>(upstream=
 sources):<br><br>- `v6.18.52` does not contain `b2ed01e7ad3d` =E2=80=94 it=
 keeps the pre-change<br>=C2=A0 structure: the resource is removed from the=
 bulk_move before the<br>=C2=A0 swapout and re-added conditionally, so it i=
s not affected.<br>- `v7.2.6` and `v7.2.7` still have `if (!ret)` at this s=
ite. The host now<br>=C2=A0 runs `7.2.6-1-cachyos` (booted) and its install=
ed `ttm.ko` still shows the<br>=C2=A0 same code generation.<br>- `v7.3-rc4`=
 has the corrected `if (ret &gt; 0)` form.<br><br>The kernel was tainted wi=
th `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and<br>`UNSIGNED_MODULE`; the Oops also=
 set `WARN` and `DIE`. For completeness:<br>the only out-of-tree module was=
 `v4l2loopback` (a DKMS V4L2 loopback<br>device) =E2=80=94 not in the DRM/T=
TM path.<br><br>Caveats: I have not boot-tested a fixed kernel on this hard=
ware =E2=80=94 no<br>native kernel A/B was performed. The evidence above is=
 source-level plus<br>disassembly of the installed `ttm.ko`; `drm/amd#5387`=
 has the live<br>reproduction data on a different GPU.<br><br>Since `fcfe64=
7` already carries `Cc: stable # v7.1+`, I assume the 7.2.y<br>backport is =
queued =E2=80=94 `7.2.7` (latest 7.2.y) still carries the bug. Two<br>thing=
s this report adds: (a) an independent hit through a non-hibernation<br>tri=
gger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 all show the<br>o=
ld condition); (b) a heads-up that trees which picked up `3db7d7d`<br>alone=
 are still buggy =E2=80=94 its one-line change landed on the wrong `if`, so=
<br>the intended swapout-site fix only exists in `fcfe647` (this<br>backpor=
t-unit warning is now also on public record via a comment on the<br>CachyOS=
 issue). Does the crash signature above match the dangling-cursor<br>mechan=
ism?<span style=3D"font-family:monospace"></span></div></div>

--0000000000000a8c02065c4afda9--
