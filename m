Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9323C98324
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0951A10E8C2;
	Fri, 25 Sep 2026 10:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=edu-teu-ac-jp.20251104.gappssmtp.com header.i=@edu-teu-ac-jp.20251104.gappssmtp.com header.b="p7iR012Q";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CE710E244
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:23:04 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb767cc7fso8465651cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790331783; cv=none;
 d=google.com; s=arc-20260327;
 b=Nx4YuLsBXNYQmskztkM33gqFfFeSI3Aym6iiL1kAwBnS1cy/uqdWR1aGEMfjy2RVdp
 5AeqC/R95JmZyDR8aWcSYBS5+GVZZdqyBjcckEoidqKdBTyDs7TLGSf/0sbA5/RkvnNJ
 +Suh7jEjDO5v20dSywYRKgssMQZz0cawxnlLRrIn9qnupNdfsrT+26C5HWOlz/r5++jr
 7g3stAYloi1kJkiSdqjGaDtsbGr7dafO5lK6Xk+0RPNVFMeYQe+DIMoi/149T6j7DsS8
 dDsnUQNHznhpKSzj5vlGSI4YWuU72lwqcmrIMnQxGc9ep+KvWVDUGXA2wqEG/cQcaOLH
 S1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/KYj7Y6lSruMZ/tfKwMvHVT/drrU+s53ZKcchLTKpKc=;
 fh=svZ7QOUoNMeh2FVvNEnjqCajo9dMILhJtjwYQQrc7MI=;
 b=lNbE3lJzYBt57vT4dI+vv9cQ2gj9f8qLTGYltlmeGHkc/rFusdHcJanurF3uvU4TLU
 DZN6W9b2C9TKeTlq0blFiXcw+H+Qx/Q+b7JaHgOc8t83OG6VSl+0sucC5v16HSziFeS6
 m6vPnj4QeB3dAq1k7NgulPrqpZWQPEApaa/duE0O3WAdrSsVkGFn6prU+fMV3ruNb2ZX
 nBPkJreTj5yVGOsIksT5FqCjwFGuXv0xmLALaBbLN8/ced37o5fwu6FU+oitv7Klhfmu
 Vv/r6g0+ka05ImG7T/OGZUnfFj9htORycgVrsYu6qOaRj1rjKj8jt/6NYHN0pfE+VF3S
 zJFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edu-teu-ac-jp.20251104.gappssmtp.com; s=20251104; t=1790331783; x=1790936583;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/KYj7Y6lSruMZ/tfKwMvHVT/drrU+s53ZKcchLTKpKc=;
 b=p7iR012QNi9WRakqcepiVtj9ZmfvIKAGEqPEunOB2DWgYQbnBHl8aAyOe6vzAjVU9z
 hifzryKosTORBfKRy3Sp24ajgWOidgqrukUgXLhgW5/oFYj8qVQmpiDz+JbttcPMGe2v
 Dp8dM4SIcQnqNWoCknziCZIlovltph+DfdxDWci77MfW/2lgDQ0H2RKeZ61Juz9ZRmeE
 zDLa6xF9/ch2HUJ1JXuMuL/nDTJk6FMrGNmUlNVACkmfH6daUFfEgIEVuBAiMkrX57BL
 FiR2BI711E7SjmRWaNQEQkqHBfPM8zjc+k1MVRvxwWrre0f1GcJrvcDsV1YWrLQUFyOK
 irsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331783; x=1790936583;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/KYj7Y6lSruMZ/tfKwMvHVT/drrU+s53ZKcchLTKpKc=;
 b=nUBcBH11gETiyJVkWMWuu1SIiMP7RSPjs/TIGmu0RUKPMDghSG6g7w4/ic3oxqeg/a
 9PVeLQ0cgiR1m4KCDhrNFncGdw0YOZXQr6Voi12Rpa5t5t9mF4ANUmrBZ8IaWj4FfqtY
 aMSqk83pzD+2/k356Mb8/8WVTbjQy7cVyr9V2vaUPIcD6Lfi6wABlR7Mtzbr0bC2p2VB
 nCMshGXthXfqkVQAsFCQlqpDt8UEojMIp6eisLNXyOXFCpA/IyJYGdkwje2RScKNvNxC
 A3KhpdhG3G8TKJOF/tdxVBYzX1A2fNEvn1j9e4MJ8oNN04piECnnczMtqC/kIDZKxBS7
 txOQ==
X-Gm-Message-State: AFuF++n27X2xxxpm/GrVk2jLObVoQElSR7k4M8xkCkaJPajevrzR5/Qe
 EMOBD8vg0Vyu0h4c+jmsYF5muQt26uw2Qa37eNVdiXLweqQOO8hUaG9ZPpcc+J/SVD4zh/DXx3g
 I7tFI8O8H5e5z6Z4A2K+FR4w2InrLJ1BRNyAlSVKUPQ==
X-Gm-Gg: AYBFou2xda3+xYUceRleEEVernZqgR9QUZLB74YlIT0Cu+eKFNFsAhOYdO4lHj3C1eX
 +41Cs/R27SzFIHWIYklVjZP+lpDWqgp3SInKZ/O8T93OqOi0aQcA3mkFUBI2rkUTRxjUD+oTG6C
 EuLN5FqT/KRO2hE87A2zQUv0toO2ERQAVaeUr6qRM4cgJok+opK7dE5gBuWRBQ/TRXEXCLUIz/S
 BxRZ0rROh5MauKuNhLyA4hQlSk3lW6p2NOuD0q+SNzY8QCdtAt0b6hlFCRMsFiRf/gH7x60i/BB
 x21KqfwlftsANtzqmKrVB33PEfkSv7a3GyAT6APZqInkS4/Bu4IyTJ4CeMXal5wFsbZDSI3Pgzu
 IkBc7D6pbx0J22a3UE7Xis+Ebj+L96eTqT9xK0qntJMbyeA==
X-Received: by 2002:ac8:5a12:0:b0:530:b2e4:91c1 with SMTP id
 d75a77b69052e-5330b7062efmr37105751cf.58.1790331783257; Fri, 25 Sep 2026
 03:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y9VQNZnAKCoCjWtLeA5TS+CLm0rPgsa7YrE8vOPDo4pV-mDQ@mail.gmail.com>
 <CA+wMiErAPXhEz-yXDasF+XTqqQi34_cbTYnC3_=KGbsvCXi-jQ@mail.gmail.com>
In-Reply-To: <CA+wMiErAPXhEz-yXDasF+XTqqQi34_cbTYnC3_=KGbsvCXi-jQ@mail.gmail.com>
From: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>
Date: Fri, 25 Sep 2026 19:22:51 +0900
X-Gm-Features: AclHuK8df403yVVhA73QCLWCoo8aiPrFQLE253GeAayB4TKHJdVs29mpeA5Lhcc
Message-ID: <CA+Y9VQM76Y6K1LZSVJiy07KNiaujx=nWww83Ny1o-Mnq5RcxhA@mail.gmail.com>
Subject: Re: [REGRESSION] drm/ttm: NULL dereference in
 ttm_resource_add_bulk_move after OOM on Navi32
To: Vadim Nikitushkin <bub4z0r@gmail.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 thomas.hellstrom@linux.intel.com, christian.koenig@amd.com
Content-Type: multipart/alternative; boundary="000000000000f8f37d065c4c1943"
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

--000000000000f8f37d065c4c1943
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vadim,

Thanks for confirming =E2=80=94 the pos->first/pos->last detail matches wha=
t
the journal showed, and the bdev->lru_lock explanation lines up
exactly with the KFD / amdgpu_drm_release hangs I saw afterwards.

The oops details are now on drm/amd#5387 as requested. I'll report
back once 7.2.8 reaches me via the CachyOS package.

Best regards,
Yuu Akaoka (nekomario28)

2026=E5=B9=B49=E6=9C=8825=E6=97=A5(=E9=87=91) 18:16 Vadim Nikitushkin <bub4=
z0r@gmail.com>:

> Hi,
>
> Yes, the signature matches. ttm_resource.c:235 in 7.2.y is the
> WARN_ON(pos->first->bo->base.resv !=3D res->bo->base.resv) in
> ttm_lru_bulk_move_add(): pos->first points at a freed resource, the resv
> comparison reads garbage, and ttm_lru_bulk_move_pos_tail() then
> dereferences the stale pos->last =E2=80=94 hence the NULL deref at +0xc9.=
 The oops
> happens under bdev->lru_lock, which is why the KFD worker and
> amdgpu_drm_release then hang on spinlocks.
>
> Hibernation was just my trigger; ttm_device_prepare_hibernation() is a
> global swapout, same ttm_bo_swapout_cb() path as ttm_global_swapout() und=
er
> memory pressure. So yes, any swapout pass can leave the dangling endpoint=
 =E2=80=94
> your report is the first hit I know of on a dGPU and without suspend. If
> you can, please add the oops to drm/amd#5387
> <https://github.com/drm/amd/issues/5387>, it's useful data.
>
> On 7.2.y: the backport is in the 7.2.8-rc1 review series as "[PATCH 7.2
> 436/438] drm/ttm: fix swapped-out resources never leaving their bulk_move
> range" (review closes 25 Sep 14:05 UTC, so 7.2.8 should follow shortly).
> 7.2.y has no ttm_resource_try_charge(), so 3db7d7d can't be cherry-picked
> there at all (Greg's bot reported FAILED); the stable patch is the two
> commits squashed into the single swapout-site hunk. Your point (b) still
> applies to anyone hand-picking from mainline =E2=80=94 a tree carrying on=
ly 3db7d7d
> is unfixed.
>
> Thanks for the detailed analysis.
>
> Vadim
>
>
>
>
> =D0=BF=D1=82, 25 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12=
:03, =E8=B5=A4=E5=B2=A1=E6=82=A0 <c0a25004a6@edu.teu.ac.jp>:
>
>> Hi,
>>
>> I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800
>> XT. The
>> failure happened immediately after a global OOM condition and was
>> followed by an
>> RCU stall and a host reset.
>>
>> The kernel was `7.2.4-1-cachyos` on CachyOS. The GPU is a Sapphire Navi3=
2
>> / RX
>> 7800 XT (`1002:747e`, subsystem `1da2:475d`). The relevant userspace
>> versions
>> were Mesa `26.2.2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.
>>
>> The first failure in the affected boot was:
>>
>> kswapd0 invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0
>> oom-kill: ... global_oom ... task_memcg=3D<redacted>, task=3Dllama-serve=
r
>> Out of memory: Killed process <pid> (llama-server)
>>
>> amdgpu 0000:03:00.0: [drm] *ERROR* Not enough memory for command
>> submission!
>> WARNING: drivers/gpu/drm/ttm/ttm_resource.c:235 at
>> ttm_resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRenderThread
>> /2457
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> RIP: ttm_resource_add_bulk_move+0xc9/0x150 [ttm]
>>
>> The call chain was:
>>
>> ttm_resource_add_bulk_move
>> ttm_resource_alloc
>> ttm_bo_swapout_cb
>> ttm_lru_walk_for_evict
>> ttm_bo_swapout
>> ttm_global_swapout
>> ttm_tt_populate
>> ttm_bo_populate
>> ttm_bo_vm_fault_reserved
>> amdgpu_gem_fault
>>
>> After the Oops, an `amdgpu` KFD cleanup worker and an `amdgpu_drm_releas=
e`
>> path were both blocked on TTM-related spinlocks. The journal does not
>> contain
>> `Kernel panic - not syncing`; I am calling this an Oops followed by a
>> lockup or
>> reset, not a confirmed formal panic.
>>
>> This is consistent with the stale `bulk_move` endpoint bug introduced by
>> `b2ed01e7ad3d` ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
>> swapout
>> failure", v7.1+): `ttm_tt_swapout()` returns the number of pages swapped
>> on
>> success (never zero for a populated ttm), so the
>> `ttm_resource_del_bulk_move_unevictable()` /
>> `ttm_resource_move_to_lru_tail()` pair under `if (!ret)` is skipped on
>> every
>> successful swapout. A swapped-out resource stays inside its BO's bulk_mo=
ve
>> range while unevictable; a later `ttm_resource_free()` /
>> `ttm_bo_set_bulk_move()` skips it via the `!ttm_resource_unevictable()`
>> guard, leaving a dangling range endpoint. Upstream names
>> `ttm_resource_add_bulk_move()` as one of the places that trips over that
>> cursor (a use-after-free on the dangling endpoint) =E2=80=94 exactly the=
 function
>> my NULL dereference hit at `+0xc9`.
>>
>> The trigger on my system differs from the hibernation cycles reported in
>> https://gitlab.freedesktop.org/drm/amd/-/issues/5387: here the swapout
>> was
>> driven by runtime memory pressure =E2=80=94 a global OOM followed by
>> `ttm_global_swapout()` reached from
>> `amdgpu_gem_fault()`/`ttm_tt_populate()`.
>> If the mechanism is the same, the defect is not suspend-specific; any
>> memory-pressure eviction pass can leave the stale endpoint.
>>
>> The upstream fix history is worth noting:
>>
>> - 3db7d7d <
>> https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e3641880=
2dbb25cf8
>> >
>>   was the intended fix, but it was applied to the wrong `if`: it changed
>>   `if (ret)` to `if (ret > 0)` after `ttm_resource_try_charge()` in
>>   `ttm_bo_alloc_at_place()` (a separate dmem-charge bypass) and left the
>>   `if (!ret)` after `ttm_tt_swapout()` untouched. A kernel carrying only
>>   `3db7d7d` therefore still has the original bug.
>> - fcfe647 <
>> https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197=
f3537ceed
>> >
>>   applies the intended `if (ret > 0)` at the swapout site and restores t=
he
>>   charge check (`Cc: stable # v7.1+`).
>>
>> I checked the source release used for `linux-cachyos 7.2.4-1`:
>> `cachyos-7.2.4-1` <
>> https://github.com/CachyOS/linux/releases/tag/cachyos-7.2.4-1>.
>> It still contains:
>>
>> ret =3D ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
>> if (!ret) {
>>         ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
>>         ttm_resource_move_to_lru_tail(bo->resource);
>> }
>>
>> The installed `ttm.ko` has the matching `test eax,eax` / `jne` branch, s=
o
>> the
>> installed binary also has the old zero-only condition. The CachyOS 7.2.4
>> PKGBUILD does not list a TTM bulk-move patch. Version check
>> (upstream sources):
>>
>> - `v6.18.52` does not contain `b2ed01e7ad3d` =E2=80=94 it keeps the pre-=
change
>>   structure: the resource is removed from the bulk_move before the
>>   swapout and re-added conditionally, so it is not affected.
>> - `v7.2.6` and `v7.2.7` still have `if (!ret)` at this site. The host no=
w
>>   runs `7.2.6-1-cachyos` (booted) and its installed `ttm.ko` still shows
>> the
>>   same code generation.
>> - `v7.3-rc4` has the corrected `if (ret > 0)` form.
>>
>> The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and
>> `UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`. For completeness:
>> the only out-of-tree module was `v4l2loopback` (a DKMS V4L2 loopback
>> device) =E2=80=94 not in the DRM/TTM path.
>>
>> Caveats: I have not boot-tested a fixed kernel on this hardware =E2=80=
=94 no
>> native kernel A/B was performed. The evidence above is source-level plus
>> disassembly of the installed `ttm.ko`; `drm/amd#5387` has the live
>> reproduction data on a different GPU.
>>
>> Since `fcfe647` already carries `Cc: stable # v7.1+`, I assume the 7.2.y
>> backport is queued =E2=80=94 `7.2.7` (latest 7.2.y) still carries the bu=
g. Two
>> things this report adds: (a) an independent hit through a non-hibernatio=
n
>> trigger, on a distribution kernel (CachyOS 7.2.4/7.2.6/7.2.7 all show th=
e
>> old condition); (b) a heads-up that trees which picked up `3db7d7d`
>> alone are still buggy =E2=80=94 its one-line change landed on the wrong =
`if`, so
>> the intended swapout-site fix only exists in `fcfe647` (this
>> backport-unit warning is now also on public record via a comment on the
>> CachyOS issue). Does the crash signature above match the dangling-cursor
>> mechanism?
>>
>

--000000000000f8f37d065c4c1943
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"background-color:transparent">Hi Vadim=
,</span></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><div><br>Thanks for confirming =E2=
=80=94 the pos-&gt;first/pos-&gt;last detail matches what<br>the journal sh=
owed, and the bdev-&gt;lru_lock explanation lines up<br>exactly with the KF=
D / amdgpu_drm_release hangs I saw afterwards.<br><br>The oops details are =
now on drm/amd#5387 as requested. I&#39;ll report<br>back once 7.2.8 reache=
s me via the CachyOS package.<br><br>Best regards,<br>Yuu Akaoka (nekomario=
28)</div></div></div></div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">2026=E5=B9=B49=E6=9C=8825=
=E6=97=A5(=E9=87=91) 18:16 Vadim Nikitushkin &lt;<a href=3D"mailto:bub4z0r@=
gmail.com">bub4z0r@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div dir=3D"ltr"><blockquote dir=3D"ltr"><p dir=3D"lt=
r">Hi,</p><p dir=3D"ltr">Yes, the signature matches. ttm_resource.c:235 in =
7.2.y is the WARN_ON(pos-&gt;first-&gt;bo-&gt;base.resv !=3D res-&gt;bo-&gt=
;base.resv) in ttm_lru_bulk_move_add(): pos-&gt;first points at a freed res=
ource, the resv comparison reads garbage, and ttm_lru_bulk_move_pos_tail() =
then dereferences the stale pos-&gt;last =E2=80=94 hence the NULL deref at =
+0xc9. The oops happens under bdev-&gt;lru_lock, which is why the KFD worke=
r and amdgpu_drm_release then hang on spinlocks.</p><p dir=3D"ltr">Hibernat=
ion was just my trigger; ttm_device_prepare_hibernation() is a global swapo=
ut, same ttm_bo_swapout_cb() path as ttm_global_swapout() under memory pres=
sure. So yes, any swapout pass can leave the dangling endpoint =E2=80=94 yo=
ur report is the first hit I know of on a dGPU and without suspend. If you =
can, please add the oops to <span><a href=3D"https://github.com/drm/amd/iss=
ues/5387" rel=3D"noreferrer" target=3D"_blank"><span><span></span>drm/amd#5=
387</span><span></span></a></span>, it&#39;s useful data.</p><p dir=3D"ltr"=
>On 7.2.y: the backport is in the 7.2.8-rc1 review series as &quot;[PATCH 7=
.2 436/438] drm/ttm: fix swapped-out resources never leaving their bulk_mov=
e range&quot; (review closes 25 Sep 14:05 UTC, so 7.2.8 should follow short=
ly). 7.2.y has no ttm_resource_try_charge(), so 3db7d7d can&#39;t be cherry=
-picked there at all (Greg&#39;s bot reported FAILED); the stable patch is =
the two commits squashed into the single swapout-site hunk. Your point (b) =
still applies to anyone hand-picking from mainline =E2=80=94 a tree carryin=
g only 3db7d7d is unfixed.</p><p dir=3D"ltr">Thanks for the detailed analys=
is.</p><p dir=3D"ltr">Vadim</p></blockquote><p dir=3D"ltr"><br></p><br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=
=BF=D1=82, 25 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 12:03, =
=E8=B5=A4=E5=B2=A1=E6=82=A0 &lt;<a href=3D"mailto:c0a25004a6@edu.teu.ac.jp"=
 target=3D"_blank">c0a25004a6@edu.teu.ac.jp</a>&gt;:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi,<br><br>I hit=
 a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT. The<b=
r>failure happened immediately after a global OOM condition and was followe=
d by an<br>RCU stall and a host reset.<br><br>The kernel was `7.2.4-1-cachy=
os` on CachyOS. The GPU is a Sapphire Navi32 / RX<br>7800 XT (`1002:747e`, =
subsystem `1da2:475d`). The relevant userspace versions<br>were Mesa `26.2.=
2-2`, KWin/Plasma `6.7.5-1.1`, and libdrm `2.4.134-1.1`.<br><br>The first f=
ailure in the affected boot was:<br><br>kswapd0 invoked oom-killer: gfp_mas=
k=3D0xcc0(GFP_KERNEL), order=3D0<br>oom-kill: ... global_oom ... task_memcg=
=3D&lt;redacted&gt;, task=3Dllama-server<br>Out of memory: Killed process &=
lt;pid&gt; (llama-server)<br><br>amdgpu 0000:03:00.0: [drm] *ERROR* Not eno=
ugh memory for command submission!<br>WARNING: drivers/gpu/drm/ttm/ttm_reso=
urce.c:235 at ttm_resource_add_bulk_move+0x124/0x150 [ttm], CPU#15: QSGRend=
erThread<br>/2457<br>BUG: kernel NULL pointer dereference, address: 0000000=
000000008<br>Oops: Oops: 0000 [#1] SMP NOPTI<br>RIP: ttm_resource_add_bulk_=
move+0xc9/0x150 [ttm]<br><br>The call chain was:<br><br>ttm_resource_add_bu=
lk_move<br>ttm_resource_alloc<br>ttm_bo_swapout_cb<br>ttm_lru_walk_for_evic=
t<br>ttm_bo_swapout<br>ttm_global_swapout<br>ttm_tt_populate<br>ttm_bo_popu=
late<br>ttm_bo_vm_fault_reserved<br>amdgpu_gem_fault<br><br>After the Oops,=
 an `amdgpu` KFD cleanup worker and an `amdgpu_drm_release`<br>path were bo=
th blocked on TTM-related spinlocks. The journal does not contain<br>`Kerne=
l panic - not syncing`; I am calling this an Oops followed by a lockup or<b=
r>reset, not a confirmed formal panic.<br><br>This is consistent with the s=
tale `bulk_move` endpoint bug introduced by<br>`b2ed01e7ad3d` (&quot;drm/tt=
m: Fix ttm_bo_swapout() infinite LRU walk on swapout<br>failure&quot;, v7.1=
+): `ttm_tt_swapout()` returns the number of pages swapped on<br>success (n=
ever zero for a populated ttm), so the<br>`ttm_resource_del_bulk_move_unevi=
ctable()` /<br>`ttm_resource_move_to_lru_tail()` pair under `if (!ret)` is =
skipped on every<br>successful swapout. A swapped-out resource stays inside=
 its BO&#39;s bulk_move<br>range while unevictable; a later `ttm_resource_f=
ree()` /<br>`ttm_bo_set_bulk_move()` skips it via the `!ttm_resource_unevic=
table()`<br>guard, leaving a dangling range endpoint. Upstream names<br>`tt=
m_resource_add_bulk_move()` as one of the places that trips over that<br>cu=
rsor (a use-after-free on the dangling endpoint) =E2=80=94 exactly the func=
tion<br>my NULL dereference hit at `+0xc9`.<br><br>The trigger on my system=
 differs from the hibernation cycles reported in<br><a href=3D"https://gitl=
ab.freedesktop.org/drm/amd/-/issues/5387" target=3D"_blank">https://gitlab.=
freedesktop.org/drm/amd/-/issues/5387</a>: here the swapout was<br>driven b=
y runtime memory pressure =E2=80=94 a global OOM followed by<br>`ttm_global=
_swapout()` reached from `amdgpu_gem_fault()`/`ttm_tt_populate()`.<br>If th=
e mechanism is the same, the defect is not suspend-specific; any<br>memory-=
pressure eviction pass can leave the stale endpoint.<br><br>The upstream fi=
x history is worth noting:<br><br>- 3db7d7d &lt;<a href=3D"https://github.c=
om/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8" target=
=3D"_blank">https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e14=
1e36418802dbb25cf8</a>&gt;<br>=C2=A0 was the intended fix, but it was appli=
ed to the wrong `if`: it changed<br>=C2=A0 `if (ret)` to `if (ret &gt; 0)` =
after `ttm_resource_try_charge()` in<br>=C2=A0 `ttm_bo_alloc_at_place()` (a=
 separate dmem-charge bypass) and left the<br>=C2=A0 `if (!ret)` after `ttm=
_tt_swapout()` untouched. A kernel carrying only<br>=C2=A0 `3db7d7d` theref=
ore still has the original bug.<br>- fcfe647 &lt;<a href=3D"https://github.=
com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed" target=
=3D"_blank">https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36=
f498f9197f3537ceed</a>&gt;<br>=C2=A0 applies the intended `if (ret &gt; 0)`=
 at the swapout site and restores the<br>=C2=A0 charge check (`Cc: stable #=
 v7.1+`).<br><br>I checked the source release used for `linux-cachyos 7.2.4=
-1`:<br>`cachyos-7.2.4-1` &lt;<a href=3D"https://github.com/CachyOS/linux/r=
eleases/tag/cachyos-7.2.4-1" target=3D"_blank">https://github.com/CachyOS/l=
inux/releases/tag/cachyos-7.2.4-1</a>&gt;.<br>It still contains:<br><br>ret=
 =3D ttm_tt_swapout(bdev, tt, swapout_walk-&gt;gfp_flags);<br>if (!ret) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttm_resource_del_bulk_move_unevictable(bo-&gt=
;resource, bo);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ttm_resource_move_to_lru_tai=
l(bo-&gt;resource);<br>}<br><br>The installed `ttm.ko` has the matching `te=
st eax,eax` / `jne` branch, so the<br>installed binary also has the old zer=
o-only condition. The CachyOS 7.2.4<br>PKGBUILD does not list a TTM bulk-mo=
ve patch. Version check<br>(upstream sources):<br><br>- `v6.18.52` does not=
 contain `b2ed01e7ad3d` =E2=80=94 it keeps the pre-change<br>=C2=A0 structu=
re: the resource is removed from the bulk_move before the<br>=C2=A0 swapout=
 and re-added conditionally, so it is not affected.<br>- `v7.2.6` and `v7.2=
.7` still have `if (!ret)` at this site. The host now<br>=C2=A0 runs `7.2.6=
-1-cachyos` (booted) and its installed `ttm.ko` still shows the<br>=C2=A0 s=
ame code generation.<br>- `v7.3-rc4` has the corrected `if (ret &gt; 0)` fo=
rm.<br><br>The kernel was tainted with `CPU_OUT_OF_SPEC`, `OOT_MODULE`, and=
<br>`UNSIGNED_MODULE`; the Oops also set `WARN` and `DIE`. For completeness=
:<br>the only out-of-tree module was `v4l2loopback` (a DKMS V4L2 loopback<b=
r>device) =E2=80=94 not in the DRM/TTM path.<br><br>Caveats: I have not boo=
t-tested a fixed kernel on this hardware =E2=80=94 no<br>native kernel A/B =
was performed. The evidence above is source-level plus<br>disassembly of th=
e installed `ttm.ko`; `drm/amd#5387` has the live<br>reproduction data on a=
 different GPU.<br><br>Since `fcfe647` already carries `Cc: stable # v7.1+`=
, I assume the 7.2.y<br>backport is queued =E2=80=94 `7.2.7` (latest 7.2.y)=
 still carries the bug. Two<br>things this report adds: (a) an independent =
hit through a non-hibernation<br>trigger, on a distribution kernel (CachyOS=
 7.2.4/7.2.6/7.2.7 all show the<br>old condition); (b) a heads-up that tree=
s which picked up `3db7d7d`<br>alone are still buggy =E2=80=94 its one-line=
 change landed on the wrong `if`, so<br>the intended swapout-site fix only =
exists in `fcfe647` (this<br>backport-unit warning is now also on public re=
cord via a comment on the<br>CachyOS issue). Does the crash signature above=
 match the dangling-cursor<br>mechanism?<span style=3D"font-family:monospac=
e"></span></div></div>
</blockquote></div>
</blockquote></div>

--000000000000f8f37d065c4c1943--
