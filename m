Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A45FC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A28810E24C;
	Fri, 25 Sep 2026 09:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WfDTFdKC";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C4910E24C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 09:16:51 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b79so643772e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790327810; cv=none;
 d=google.com; s=arc-20260327;
 b=p4cifxVXxwX/+AAigF1FacfXfFmpmYaapzvbwbUwMCdyyO8XmmEs9ZikJGKnWlF17t
 HQrAHDfaKXkrHQxERy55qxUoCREhezwIL8nNsR/mKr+bEOP8155xjjY6JIat8UnNEaei
 e1tp/p24U4wDmtoIBWeV9RPC0m0jcg4bJS39CzjOxm3CwGuKGgBcwl3KbAKLn7+vxWux
 OeQR4PeqYWMrJjxtKkOB5aYygvxDwmDZmg4NL7YvN/t0cnb3TlSwpxkLxzrN8K1Hz7lq
 CkIVmPTucgvnHez7vtDByHBDynGxuujOltG18T53j3w94zokZBWi0u0f+XLU+k0CqA+0
 6gNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sj16WZK8DScfBE9wIz3igJSXaU+orcExaWZ8e3HcReM=;
 fh=SthZ+TdA0qVT1ef/cl9ep4iLcEOgAZ8xnTC6XAV/qIs=;
 b=dsc/iFrpURog4SLKNlk/jgKw4pGqWdI2nMLTGXSwb7hxB0jybtnMPv0KND1zoqzzK+
 f5N1gmu28clh36GvcdoxoM+h1vpCjNev+2qvhHo0XQ9g30CGDNQLoQJxlWYEPUl67Vj1
 G0uKcYdxrLr9oITzI0KG6nPx3Oqd/6BlLozeRhKDkh/XsrkqKbiGy8PQdexPITNuakMo
 FAWTT3Dxi/Fm/EO6s3Ej07wEly8KqT2xw7QSPZxt5vIZHlFNlZPcMPTk0eFlE+sbeXBw
 9+9VbzUWBbLB6O8O8hzmtFacunzNAKez9tI2XC6H+rIr8WyDX+QF94p/b3ohYPr6BKXC
 8pqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790327810; x=1790932610; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sj16WZK8DScfBE9wIz3igJSXaU+orcExaWZ8e3HcReM=;
 b=WfDTFdKCI6Xs9f3+TtJY1gPvK/4t5SX1/b8BNOIbL6dkRTVmKRbuxpdBkT3wjmH8MR
 NJ9pajvpEaF3IuqJTRKFUX/jyk5SjaBMS0PCjYH8hPuJLaXPwCviaBLyXuqbxsk8aoYk
 9VlWbgKbOnydBioX21YOvJwb6gikUMlzzZEO++xrbQsaSG83x649g9lBpNRvG5zgTBuI
 xzS+5poFaXpG2vLUSmrLNEYaL+AcT4TQyhzZ5kmI03M65uNWhLXRN+6EqIh5jF5oMHhz
 wwMvz166rlTb7PnyX8buOegOCtOXl0UX0xl+c/Wc74qbbg6a5RDiQaWepNqiduXV+2to
 DXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790327810; x=1790932610;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sj16WZK8DScfBE9wIz3igJSXaU+orcExaWZ8e3HcReM=;
 b=l7aF9eFU7MmGnNg3cGoF9EhkON5OCDBLKqmeT9ZjCFBF8SpXyAEad/vlbFXy2P95Va
 NE655obkhlf4qdXb0vJPuF2twQZVGGzXVOVURniwuDF3Brm+TEUmQ+HCVI8Z6eoAl63F
 ZSzLtFgcS3N3X4VfMLlA+f7+AdqafwEj5zKdvwLK+3yy2PPC5VGgHmVqN54qegvyBPM2
 jXdKjXkQlmzB0A8BtPjQvGdXMERl0P3c4lKT7zQiIWFn4lA46gi+BPEbugQQtGraQAj7
 GPxqSK23fIADdfGHWIIrvzYxlQ1xOMTVjo7Inz7X+0h2BrxT1Qld1AoNruTqVSy/Lla4
 8TIw==
X-Gm-Message-State: AFuF++mo88VL0mKYwV0vqeYryVte6U1xwPWPZWDvkK5YTiK6PBeNHyd/
 wF5BZjy1nQt9WCzjZ/ykW6b8iy75EkbyI7v6fL2+XhaaI2tgUHgXJ91pz7d9mLdHq3TciaVwXQb
 WzHh+yEaug66SCT0nAg94HWvPlCfnKnw=
X-Gm-Gg: AYBFou1AAqt+Y4HeYXiD9nA3ZIsVbkH86iidgf7hPXQFre4dDEZiYxKtPT2i2g4ARBK
 HURZIoCcoCbK7+ztKp4i5Yr3ggjML0BLoNIbIKvP25y0nvw2Z34CNPDAd3rKmhRYNYQ6f8NBAgK
 9oedINZnyyB9RJu2Q+3j/9HCDezd37VbPY/nI4KReKH0YfEhPtnMgiKFzRucfwjsWye0h5AUVpY
 3XHM2Ni2pv7AKCKu9KGywyb0ID/vPmOb6tTH03zjRK1gL70xUBMjoJrzaRFqhmoIey6Py4lzong
 WtlhjAA4HOIOJYOL6Bydz8j95Y4ttOYPG3zvDnE2SV7oGPgoKX/MGzlx6w==
X-Received: by 2002:a05:6512:308d:b0:5b8:bc5e:b587 with SMTP id
 2adb3069b0e04-5b8df21283cmr2091022e87.63.1790327809241; Fri, 25 Sep 2026
 02:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
In-Reply-To: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
From: Vadim Nikitushkin <bub4z0r@gmail.com>
Date: Fri, 25 Sep 2026 12:16:37 +0300
X-Gm-Features: AclHuK_1QA8nRvt8hPpnHcz-7FkjGgkazcQZw3vtZgc8Om7uFr1K0D3wvj-wRys
Message-ID: <CA+wMiErAPXhEz-yXDasF+XTqqQi34_cbTYnC3_=KGbsvCXi-jQ@mail.gmail.com>
Subject: Re: [REGRESSION] drm/ttm: NULL dereference in
 ttm_resource_add_bulk_move after OOM on Navi32
To: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 thomas.hellstrom@linux.intel.com, christian.koenig@amd.com
Content-Type: multipart/alternative; boundary="00000000000019f92b065c4b2dc6"
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

--00000000000019f92b065c4b2dc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yes, the signature matches. ttm_resource.c:235 in 7.2.y is the
WARN_ON(pos->first->bo->base.resv !=3D res->bo->base.resv) in
ttm_lru_bulk_move_add(): pos->first points at a freed resource, the resv
comparison reads garbage, and ttm_lru_bulk_move_pos_tail() then
dereferences the stale pos->last =E2=80=94 hence the NULL deref at +0xc9. T=
he oops
happens under bdev->lru_lock, which is why the KFD worker and
amdgpu_drm_release then hang on spinlocks.

Hibernation was just my trigger; ttm_device_prepare_hibernation() is a
global swapout, same ttm_bo_swapout_cb() path as ttm_global_swapout() under
memory pressure. So yes, any swapout pass can leave the dangling endpoint =
=E2=80=94
your report is the first hit I know of on a dGPU and without suspend. If
you can, please add the oops to drm/amd#5387
<https://github.com/drm/amd/issues/5387>, it's useful data.

On 7.2.y: the backport is in the 7.2.8-rc1 review series as "[PATCH 7.2
436/438] drm/ttm: fix swapped-out resources never leaving their bulk_move
range" (review closes 25 Sep 14:05 UTC, so 7.2.8 should follow shortly).
7.2.y has no ttm_resource_try_charge(), so 3db7d7d can't be cherry-picked
there at all (Greg's bot reported FAILED); the stable patch is the two
commits squashed into the single swapout-site hunk. Your point (b) still
applies to anyone hand-picking from mainline =E2=80=94 a tree carrying only=
 3db7d7d
is unfixed.

Thanks for the detailed analysis.

Vadim




=D0=BF=D1=82, 25 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:0=
3, =E8=B5=A4=E5=B2=A1=E6=82=A0 <c0a25004a6@edu.teu.ac.jp>:

> Hi,
>
> I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT=
.
> The
> failure happened immediately after a global OOM condition and was followe=
d
> by an
> RCU stall and a host reset.
>
> The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire Navi32
> / RX
> 7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant userspace
> versions
> were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.
>
> The first failure in the affected boot was:
>
> kswapd0 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0
> oom-kill: ... global_oom ... task_memcg=3D<redacted>, task=3Dllama-server
> Out of memory: Killed process <pid> (llama-server)
>
> amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for command
> submission!
> WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at
> ttm_resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRenderThread
> /2457
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]
>
> The call chain was:
>
> ttm_resource_add_bulk_move
> ttm_resource_alloc
> ttm_bo_swapout_cb
> ttm_lru_walk_for_evict
> ttm_bo_swapout
> ttm_global_swapout
> ttm_tt_populate
> ttm_bo_populate
> ttm_bo_vm_fault_reserved
> amdgpu_gem_fault
>
> After the Oops, an `amdgpu` KFD cleanup worker and an `amdgpu_drm_release=
`
> path were both blocked on TTM-related spinlocks. The journal does not
> contain
> `Kernel panic - not syncing`; I am calling this an Oops followed by a
> lockup or
> reset, not a confirmed formal panic.
>
> This is consistent with the stale `bulk_move` endpoint bug introduced by
> `b2ed01e7ad3d` ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapo=
ut
> failure", v7.1+): `ttm_tt_swapout()` returns the number of pages swapped =
on
> success (never zero for a populated ttm), so the
> `ttm_resource_del_bulk_move_unevictable()` /
> `ttm_resource_move_to_lru_tail()` pair under `if (!ret)` is skipped on
> every
> successful swapout. A swapped-out resource stays inside its BO's bulk_mov=
e
> range while unevictable; a later `ttm_resource_free()` /
> `ttm_bo_set_bulk_move()` skips it via the `!ttm_resource_unevictable()`
> guard, leaving a dangling range endpoint. Upstream names
> `ttm_resource_add_bulk_move()` as one of the places that trips over that
> cursor (a use-after-free on the dangling endpoint) =E2=80=94 exactly the =
function
> my NULL dereference hit at `+0xc9`.
>
> The trigger on my system differs from the hibernation cycles reported in
> https://gitlab.freedesktop.org/drm/amd/-/issues/5387: here the swapout wa=
s
> driven by runtime memory pressure =E2=80=94 a global OOM followed by
> `ttm_global_swapout()` reached from
> `amdgpu_gem_fault()`/`ttm_tt_populate()`.
> If the mechanism is the same, the defect is not suspend-specific; any
> memory-pressure eviction pass can leave the stale endpoint.
>
> The upstream fix history is worth noting:
>
> - 3db7d7d <
> https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802=
dbb25cf8
> >
>   was the intended fix, but it was applied to the wrong `if`: it changed
>   `if (ret)` to `if (ret > 0)` after `ttm_resource_try_charge()` in
>   `ttm_bo_alloc_at_place()` (a separate dmem-charge bypass) and left the
>   `if (!ret)` after `ttm_tt_swapout()` untouched. A kernel carrying only
>   `3db7d7d` therefore still has the original bug.
> - fcfe647 <
> https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f=
3537ceed
> >
>   applies the intended `if (ret > 0)` at the swapout site and restores th=
e
>   charge check (`Cc: stable # v7.1+`).
>
> I checked the source release used for `linux-cachyos 7.2.4-1`:
> `cachyos-7.2.4-1` <
> https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1>.
> It still contains:
>
> ret =3D ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
> if (!ret) {
>         ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
>         ttm_resource_move_to_lru_tail(bo->resource);
> }
>
> The installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, so
> the
> installed binary also has the old zero-only condition. The CachyOS 7.2.4
> PKGBUILD does not list a TTM bulk-move patch. Version check
> (upstream sources):
>
> - `v6.18.52` does not contain `b2ed01e7ad3d` =E2=80=94 it keeps the pre-c=
hange
>   structure: the resource is removed from the bulk_move before the
>   swapout and re-added conditionally, so it is not affected.
> - `v7.2.6` and `v7.2.7` still have `if (!ret)` at this site. The host now
>   runs `7.2.6-1-cachyos` (booted) and its installed `ttm.ko` still shows
> the
>   same code generation.
> - `v7.3-rc4` has the corrected `if (ret > 0)` form.
>
> The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and
> `UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`. For completeness:
> the only out-of-tree module was `v4l2loopback` (a DKMS V4L2 loopback
> device) =E2=80=94 not in the DRM/TTM path.
>
> Caveats: I have not boot-tested a fixed kernel on this hardware =E2=80=94=
 no
> native kernel A/B was performed. The evidence above is source-level plus
> disassembly of the installed `ttm.ko`; `drm/amd#5387` has the live
> reproduction data on a different GPU.
>
> Since `fcfe647` already carries `Cc: stable # v7.1+`, I assume the 7.2.y
> backport is queued =E2=80=94 `7.2.7` (latest 7.2.y) still carries the bug=
. Two
> things this report adds: (a) an independent hit through a non-hibernation
> trigger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 all show the
> old condition); (b) a heads-up that trees which picked up `3db7d7d`
> alone are still buggy =E2=80=94 its one-line change landed on the wrong `=
if`, so
> the intended swapout-site fix only exists in `fcfe647` (this
> backport-unit warning is now also on public record via a comment on the
> CachyOS issue). Does the crash signature above match the dangling-cursor
> mechanism?
>

--00000000000019f92b065c4b2dc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote dir=3D"ltr"><p dir=3D"ltr">Hi,</p><p dir=3D"lt=
r">Yes, the signature matches. ttm_resource.c:235 in 7.2.y is the WARN_ON(p=
os-&gt;first-&gt;bo-&gt;base.resv !=3D res-&gt;bo-&gt;base.resv) in ttm_lru=
_bulk_move_add(): pos-&gt;first points at a freed resource, the resv compar=
ison reads garbage, and ttm_lru_bulk_move_pos_tail() then dereferences the =
stale pos-&gt;last =E2=80=94 hence the NULL deref at +0xc9. The oops happen=
s under bdev-&gt;lru_lock, which is why the KFD worker and amdgpu_drm_relea=
se then hang on spinlocks.</p><p dir=3D"ltr">Hibernation was just my trigge=
r; ttm_device_prepare_hibernation() is a global swapout, same ttm_bo_swapou=
t_cb() path as ttm_global_swapout() under memory pressure. So yes, any swap=
out pass can leave the dangling endpoint =E2=80=94 your report is the first=
 hit I know of on a dGPU and without suspend. If you can, please add the oo=
ps to <span><a href=3D"https://github.com/drm/amd/issues/5387" target=3D"_b=
lank" rel=3D"noreferrer"><span><span></span>drm/amd#5387</span><span></span=
></a></span>, it&#39;s useful data.</p><p dir=3D"ltr">On 7.2.y: the backpor=
t is in the 7.2.8-rc1 review series as &quot;[PATCH 7.2 436/438] drm/ttm: f=
ix swapped-out resources never leaving their bulk_move range&quot; (review =
closes 25 Sep 14:05 UTC, so 7.2.8 should follow shortly). 7.2.y has no ttm_=
resource_try_charge(), so 3db7d7d can&#39;t be cherry-picked there at all (=
Greg&#39;s bot reported FAILED); the stable patch is the two commits squash=
ed into the single swapout-site hunk. Your point (b) still applies to anyon=
e hand-picking from mainline =E2=80=94 a tree carrying only 3db7d7d is unfi=
xed.</p><p dir=3D"ltr">Thanks for the detailed analysis.</p><p dir=3D"ltr">=
Vadim</p></blockquote><p dir=3D"ltr"><br></p><br></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=
=BF=D1=82, 25 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:03, =
=E8=B5=A4=E5=B2=A1=E6=82=A0 &lt;<a href=3D"mailto:c0a25004a6@edu.teu.ac.jp"=
>c0a25004a6@edu.teu.ac.jp</a>&gt;:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div>Hi,<br><br>I hit a kernel Oops in =
the AMDGPU/TTM swapout path on a Radeon RX 7800 XT. The<br>failure happened=
 immediately after a global OOM condition and was followed by an<br>RCU sta=
ll and a host reset.<br><br>The kernel was `7.2.4-1-cachyos` on CachyOS. Th=
e GPU is a Sapphire Navi32 / RX<br>7800 XT (`1002:747e`, subsystem `1da2:47=
5d`). The relevant userspace versions<br>were Mesa `26.2.2-2`, KWin/Plasma =
`6.7.5-1.1`, and libdrm `2.4.134-1.1`.<br><br>The first failure in the affe=
cted boot was:<br><br>kswapd0 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERN=
EL), order=3D0<br>oom-kill: ... global_oom ... task_memcg=3D&lt;redacted&gt=
;, task=3Dllama-server<br>Out of memory: Killed process &lt;pid&gt; (llama-=
server)<br><br>amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for com=
mand submission!<br>WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at ttm_=
resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRenderThread<br>/2457<=
br>BUG: kernel NULL pointer dereference, address: 0000000000000008<br>Oops:=
 Oops: 0000 [#1] SMP NOPTI<br>RIP: ttm_resource_add_bulk_move+0xc9/0x150 [t=
tm]<br><br>The call chain was:<br><br>ttm_resource_add_bulk_move<br>ttm_res=
ource_alloc<br>ttm_bo_swapout_cb<br>ttm_lru_walk_for_evict<br>ttm_bo_swapou=
t<br>ttm_global_swapout<br>ttm_tt_populate<br>ttm_bo_populate<br>ttm_bo_vm_=
fault_reserved<br>amdgpu_gem_fault<br><br>After the Oops, an `amdgpu` KFD c=
leanup worker and an `amdgpu_drm_release`<br>path were both blocked on TTM-=
related spinlocks. The journal does not contain<br>`Kernel panic - not sync=
ing`; I am calling this an Oops followed by a lockup or<br>reset, not a con=
firmed formal panic.<br><br>This is consistent with the stale `bulk_move` e=
ndpoint bug introduced by<br>`b2ed01e7ad3d` (&quot;drm/ttm: Fix ttm_bo_swap=
out() infinite LRU walk on swapout<br>failure&quot;, v7.1+): `ttm_tt_swapou=
t()` returns the number of pages swapped on<br>success (never zero for a po=
pulated ttm), so the<br>`ttm_resource_del_bulk_move_unevictable()` /<br>`tt=
m_resource_move_to_lru_tail()` pair under `if (!ret)` is skipped on every<b=
r>successful swapout. A swapped-out resource stays inside its BO&#39;s bulk=
_move<br>range while unevictable; a later `ttm_resource_free()` /<br>`ttm_b=
o_set_bulk_move()` skips it via the `!ttm_resource_unevictable()`<br>guard,=
 leaving a dangling range endpoint. Upstream names<br>`ttm_resource_add_bul=
k_move()` as one of the places that trips over that<br>cursor (a use-after-=
free on the dangling endpoint) =E2=80=94 exactly the function<br>my NULL de=
reference hit at `+0xc9`.<br><br>The trigger on my system differs from the =
hibernation cycles reported in<br><a href=3D"https://gitlab.freedesktop.org=
/drm/amd/-/issues/5387" target=3D"_blank">https://gitlab.freedesktop.org/dr=
m/amd/-/issues/5387</a>: here the swapout was<br>driven by runtime memory p=
ressure =E2=80=94 a global OOM followed by<br>`ttm_global_swapout()` reache=
d from `amdgpu_gem_fault()`/`ttm_tt_populate()`.<br>If the mechanism is the=
 same, the defect is not suspend-specific; any<br>memory-pressure eviction =
pass can leave the stale endpoint.<br><br>The upstream fix history is worth=
 noting:<br><br>- 3db7d7d &lt;<a href=3D"https://github.com/torvalds/linux/=
commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8" target=3D"_blank">https://=
github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8</=
a>&gt;<br>=C2=A0 was the intended fix, but it was applied to the wrong `if`=
: it changed<br>=C2=A0 `if (ret)` to `if (ret &gt; 0)` after `ttm_resource_=
try_charge()` in<br>=C2=A0 `ttm_bo_alloc_at_place()` (a separate dmem-charg=
e bypass) and left the<br>=C2=A0 `if (!ret)` after `ttm_tt_swapout()` untou=
ched. A kernel carrying only<br>=C2=A0 `3db7d7d` therefore still has the or=
iginal bug.<br>- fcfe647 &lt;<a href=3D"https://github.com/torvalds/linux/c=
ommit/fcfe64715b425262af1b36f498f9197f3537ceed" target=3D"_blank">https://g=
ithub.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed</a=
>&gt;<br>=C2=A0 applies the intended `if (ret &gt; 0)` at the swapout site =
and restores the<br>=C2=A0 charge check (`Cc: stable # v7.1+`).<br><br>I ch=
ecked the source release used for `linux-cachyos 7.2.4-1`:<br>`cachyos-7.2.=
4-1` &lt;<a href=3D"https://github.com/CachyOS/linux/releases/tag/cachyos-7=
.2.4-1" target=3D"_blank">https://github.com/CachyOS/linux/releases/tag/cac=
hyos-7.2.4-1</a>&gt;.<br>It still contains:<br><br>ret =3D ttm_tt_swapout(b=
dev, tt, swapout_walk-&gt;gfp_flags);<br>if (!ret) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ttm_resource_del_bulk_move_unevictable(bo-&gt;resource, bo);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttm_resource_move_to_lru_tail(bo-&gt;resource);=
<br>}<br><br>The installed `ttm.ko` has the matching `test eax,eax` / `jne`=
 branch, so the<br>installed binary also has the old zero-only condition. T=
he CachyOS 7.2.4<br>PKGBUILD does not list a TTM bulk-move patch. Version c=
heck<br>(upstream sources):<br><br>- `v6.18.52` does not contain `b2ed01e7a=
d3d` =E2=80=94 it keeps the pre-change<br>=C2=A0 structure: the resource is=
 removed from the bulk_move before the<br>=C2=A0 swapout and re-added condi=
tionally, so it is not affected.<br>- `v7.2.6` and `v7.2.7` still have `if =
(!ret)` at this site. The host now<br>=C2=A0 runs `7.2.6-1-cachyos` (booted=
) and its installed `ttm.ko` still shows the<br>=C2=A0 same code generation=
.<br>- `v7.3-rc4` has the corrected `if (ret &gt; 0)` form.<br><br>The kern=
el was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and<br>`UNSIGNED_MODUL=
E`; the Oops also set `WARN` and `DIE`. For completeness:<br>the only out-o=
f-tree module was `v4l2loopback` (a DKMS V4L2 loopback<br>device) =E2=80=94=
 not in the DRM/TTM path.<br><br>Caveats: I have not boot-tested a fixed ke=
rnel on this hardware =E2=80=94 no<br>native kernel A/B was performed. The =
evidence above is source-level plus<br>disassembly of the installed `ttm.ko=
`; `drm/amd#5387` has the live<br>reproduction data on a different GPU.<br>=
<br>Since `fcfe647` already carries `Cc: stable # v7.1+`, I assume the 7.2.=
y<br>backport is queued =E2=80=94 `7.2.7` (latest 7.2.y) still carries the =
bug. Two<br>things this report adds: (a) an independent hit through a non-h=
ibernation<br>trigger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 =
all show the<br>old condition); (b) a heads-up that trees which picked up `=
3db7d7d`<br>alone are still buggy =E2=80=94 its one-line change landed on t=
he wrong `if`, so<br>the intended swapout-site fix only exists in `fcfe647`=
 (this<br>backport-unit warning is now also on public record via a comment =
on the<br>CachyOS issue). Does the crash signature above match the dangling=
-cursor<br>mechanism?<span style=3D"font-family:monospace"></span></div></d=
iv>
</blockquote></div>

--00000000000019f92b065c4b2dc6--
