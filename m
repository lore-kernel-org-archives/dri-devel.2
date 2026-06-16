Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278BFCD98F0
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFB910ECEC;
	Tue, 16 Jun 2026 18:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETMicLDo";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3595010E516
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 00:46:54 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-3995e22ef81so1966111fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781570812; cv=none;
 d=google.com; s=arc-20240605;
 b=g+m0+25vUc5cpUrzNokOXMb84hW54EhjRm2ODsKxu97F9i7JBy/wet9UbPg10LkSzS
 MdDgd6rFxQWuvX4+zXWmGjfTu3OvZxh/XNqXMIPu2CVuU5y7FD5fU4Vr+xotXOx2RPbW
 31MBKGNa/2Lhx9L6tdm8CHeYwNkevnhqY7QTBBqnIKIQHMKv14ps2o2fkCDDNr5LLBm9
 /0iPteu1gx4cbf3NVn3aHMR00gXAnOytdh+uQHX4j8oWFJNFVgtOUr2uPsiaGQ2aNlWI
 HgsBbXHihdVOLa9VC0kfLzYwiT474Ax5mv5XP63Y+U8Zyzhed/mUVRM1nsD69C+8BZEQ
 znFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XZzBisZobTLmcmNvYzhFguH9TGiSc8C8vFarxTJjYAU=;
 fh=JtvZqMA4jdHPbWM5qZSF2dxNDmRAEvfTyIx+7220xuA=;
 b=JEBMy+HfeykaWmBblfsFSho3Z+Z4CXpRJt+VRrcyTn/er3jCMWMhDnb2P5LR//914T
 AzBtsUmgKCTTkthdUjQjTxPBUEXLcUVNURZorbVBprqncVhIwgHq/XKMPQHhPXq+3Rhy
 colwIcAHEXFsk9VGccg/84rTAZqZczZWc2b4Tnac60Tq1JEw5S7FSQjL2Fhm9qglgt4l
 OIhKDmg+XqMJBOssFovyUP+M2L13CkJ8BckKEgK8v3cV7z5kMB7zDL8njOSE6qd1DY/A
 DdRw8VqMt/aZ+bh3Yreweg5uLvIgFQ3tsjs/IFEgG/zphWRgDqsF7TjUx01DDjQwyfiZ
 AM+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781570812; x=1782175612; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XZzBisZobTLmcmNvYzhFguH9TGiSc8C8vFarxTJjYAU=;
 b=ETMicLDovslt71h12g38sJ5BXnJ5Omo7OkbI0b6Fyei3aY9xgtWEhOdl9fN3jKzppw
 qYufyi69Dfu/usduOx9OIEnoPrwE+ixZVZNFnFld59L05Kb8fBQndLD+XYfVc7EEPvT+
 aPvLa5H5/zOWXoSs4u+TtgUS1H+aBacwoaVbqxBPJgVuJT9vYKYMGDPbdXlUUhtokOHk
 aksZy8VeQ8O3Wu+9Qkhw5BSpyoRXaOD572/jzi41Hn63tqfgNA9nrfb74xMWmY0ugdlK
 cQY0PPLHmiBmTyd/I+ITLmpzA8ke2gynKPAig0wdB5yxpyulwsnOJ3JhOA95MlceXxRn
 7P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570812; x=1782175612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZzBisZobTLmcmNvYzhFguH9TGiSc8C8vFarxTJjYAU=;
 b=IXyQolU4wY++C4biTxOf+ACS8tQHeYn9fAs1vvIsmEkQ5Yq0OkJFXraQyys3pZlFqM
 qcEyiimUL8XpFJkQHK4meTdZHdphbOrZliZ0WXsMQscgf/Vxzdy1kh/bIHnduvKBRLVd
 ZR5hFIEI7qo6Gqxsxw1KA8g4Bbeq0CYs7wsopZbTZgtBPIWUdsJrzkFeWgurAz2hFfSk
 zxdGKQul8LHIYMS6NQU5lKEKdH1ENY92CNC2qusOuHBx5GKaBiUMfUlJ0KIG22cL3KbZ
 82KbJ3Hs9iqJhJklyQKujO3L0Kk6dJc8N33qFRqtjzzp4184Bxupzd/artgBckkNXe3U
 FF3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ln2iiXmbBrQFrr8CGxATS90yU5jGvAb1AmabMVKoKmR/D4hHGHpoDQbCDfys5cHvNZFfXFE9wWnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywpq1Xfzvu4B/rmgQye+00wT2tTUZIn8L05VvDe8+vB9WPlVbWJ
 k7f4yoPHvhq0fEVDWvve+obxU5DaI9XGbDLkaUE3XinMb7asOXtQXRx830FT1J44YmS60AXBvPQ
 bJIsGAk1U8ECYoJYwsne1YuJWbJKLLuc=
X-Gm-Gg: Acq92OHYHR0gUMdVgFF+f+iPrLPamhvI4muLGrAn2yWHoxSX9fNTO4T4Pm2YZChXzxY
 /f5+BBoMBHdWcBa3v0gZd8p34jL/yMquKUKvbEM/aiY3DiO6v/ilDx0IW0ZmLHS64vruIavDWSU
 2tuP3AvzvSvmuLhJ/EvqlWI4FBfZc6ck9lMh0bFyejZ4p7DwtRfZbCVw7DkTO2Pws9AXtt3EOqj
 5JvUxL+JDk1GZ22z9BUF4U+skFgm0DlGYU4kwynt8C29UgsodnXYiyO/KxyqyfyjcXT33tvSdZW
 HL+4xT8vZrSAO7bVEXOi6eNWO2RaUJR/9LKgk4k=
X-Received: by 2002:a2e:bcc4:0:b0:394:5b8:48a1 with SMTP id
 38308e7fff4ca-3995c47ce76mr4993671fa.7.1781570812311; Mon, 15 Jun 2026
 17:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260615234922.151263-1-skainsworth@gmail.com>
In-Reply-To: <20260615234922.151263-1-skainsworth@gmail.com>
From: Samuel Ainsworth <skainsworth@gmail.com>
Date: Tue, 16 Jun 2026 00:46:15 +0000
X-Gm-Features: AVVi8CdOsPk17pRH2ywiQo_s0PwjY1AzylbJehtnQaaUg5_vY0aRRGY4CW-_w5o
Message-ID: <CAHYiNPbJ59kWedhzZh9pCOvdd82jPd0mPSvqUcAcpAB_GuYaTA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] drm/ttm: fix bulk_move cursor use-after-free for
 unevictable resources
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000068fc8f0654544705"
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:18:52 +0000
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

--00000000000068fc8f0654544705
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Welp, I spoke too soon. v1 is broken.

While stress-testing the fix on the affected machine (KASAN + DEBUG_LIST,
ordinary desktop use rather than only hibernate cycles), I hit a new
use-after-free that this patch introduces:

  BUG: KASAN: slab-use-after-free in ttm_lru_bulk_move_tail+0xa93/0xcb0
[ttm]
  Read of size 8 ... by task .swayosd-server
   ttm_lru_bulk_move_tail+0xa93/0xcb0 [ttm]
   amdgpu_vm_move_to_lru_tail+0x29/0x40 [amdgpu]
   amdgpu_cs_ioctl+0x4247/0x5090 [amdgpu]
  Freed by:
   ttm_resource_free+0x1f8/0x390 [ttm]
   ttm_bo_delayed_delete+0x69/0x100 [ttm]

By dropping the ttm_resource_unevictable() gate from
ttm_resource_del_bulk_move() and removing any tracked resource, the del now
runs
for resources that have become unevictable. ttm_lru_bulk_move_del() updates
pos->first/pos->last by walking the manager LRU
(ttm_lru_next_res()/ttm_lru_prev_res()), but an unevictable resource's
lru.link
has been moved to bdev->unevictable, so the walk lands on an unrelated
resource
and leaves the cursor pointing outside the bulk-move range. That resource i=
s
freed later, and the next ttm_lru_bulk_move_tail() dereferences the danglin=
g
cursor.

IIUC the resource needs to be taken off the cursor at the point it becomes
unevictable (while its link is still on the manager LRU), not deferred to
free/teardown. The kunit tests passed only because they used a
single-element
cursor, where ttm_lru_bulk_move_del() clears pos without walking; they did
not cover the multi-element / moved-link case that this UAF needs.

I am not 100% convinced I have this pinned down yet, but I believe I may be
making progress. Feedback welcome!

I'll try to follow up with a v2 that fixes it at the unevictable transition
and
adds tests that actually exercise the multi-element case. Apologies for the
confusion.

Best,
Sam

On Mon, Jun 15, 2026 at 11:49=E2=80=AFPM Samuel Ainsworth <skainsworth@gmai=
l.com>
wrote:

> A resource added to a bo's bulk_move LRU cursor can become unevictable
> (pinned or swapped) after it has been added. ttm_resource_del_bulk_move()
> then skips removing it -- both on free and on ttm_bo_set_bulk_move() duri=
ng
> bo teardown -- because the resource is unevictable, leaving the cursor's
> pos->first/pos->last pointing at it. Once freed, the next allocation on
> that
> bulk_move dereferences the dangling cursor (use-after-free) and corrupts
> the
> LRU list, which CONFIG_DEBUG_LIST turns into a fatal BUG.
>
> In the field this is a hibernation-triggered panic on a Framework 13 (AMD
> Ryzen 7040): a buffer swapped out during hibernate is closed after resume
> (amdgpu_gem_object_close -> amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()),
> which leaves its unevictable resource on the VM's bulk_move cursor; a lat=
er
> GEM allocation on that cursor then faults (drm/amd issue #5387).
>
> Patch 1 tracks cursor membership explicitly so the del always undoes the
> add, regardless of any pin/swap transition. Patch 2 adds kunit regression
> coverage.
>
> Validating the bug (no GPU required, patch 2):
>
>  - ttm_bo_bulk_move_swapped_free_dangles allocates a resource on a
>    bulk_move cursor, swaps out its bo's ttm so the resource becomes
>    unevictable, frees it, and asserts the cursor no longer references the
>    freed resource. Without the fix this fails: pos->first/pos->last still
>    equal the freed pointer.
>
>  - ttm_bo_bulk_move_dangling_corrupts then allocates on the same
>    bulk_move; without the fix, KASAN reports a slab-use-after-free in
>    ttm_resource_add_bulk_move().
>
> On the affected machine, a throwaway debug kernel that WARN_ONCE()s when
> ttm_resource_del_bulk_move() skips an unevictable resource still on the
> cursor was used to test. It fired during a normal hibernate/resume cycle,
> via
> amdgpu_gem_object_close() -> amdgpu_vm_bo_del() -> ttm_bo_set_bulk_move()=
.
> That confirmed the production trigger and that the planted state matches
> the field crash (the ttm_resource.c WARN_ON, then list_del corruption).
>
> With the patch 1 fix, both kunit tests pass and the full TTM kunit suite =
is
> green (no KASAN report, no CONFIG_DEBUG_LIST splat). Furthermore, I set u=
p
> a
> kernel with the fix, built with KASAN + CONFIG_DEBUG_LIST + lockdep, and
> ran 10
> hibernate/resume/GEM-close cycles under GPU load with no use-after-free
> nor LRU
> list corruption.
>
> I am new to this area, so review of the approach is very welcome -- in
> particular whether tracking membership on the resource is preferrable vs
> removing it from the cursor at the point it becomes unevictable.
>
> Samuel Ainsworth (2):
>   drm/ttm: don't leave bulk_move cursor dangling for unevictable
>     resources
>   drm/ttm/tests: add bulk_move cursor regression tests
>
>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 163 ++++++++++++++++++++++++
>  drivers/gpu/drm/ttm/ttm_resource.c      |  18 ++-
>  include/drm/ttm/ttm_resource.h          |   9 ++
>  3 files changed, 187 insertions(+), 3 deletions(-)
>
>
> base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43
> --
> 2.54.0
>

--00000000000068fc8f0654544705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Welp, I spoke too soon. v1 is broken.<br>=
<br>While stress-testing the fix on the affected machine (KASAN + DEBUG_LIS=
T,<br>ordinary desktop use rather than only hibernate cycles), I hit a new<=
br>use-after-free that this patch introduces:<br><br>=C2=A0 BUG: KASAN: sla=
b-use-after-free in ttm_lru_bulk_move_tail+0xa93/0xcb0 [ttm]<br>=C2=A0 Read=
 of size 8 ... by task .swayosd-server<br>=C2=A0 =C2=A0ttm_lru_bulk_move_ta=
il+0xa93/0xcb0 [ttm]<br>=C2=A0 =C2=A0amdgpu_vm_move_to_lru_tail+0x29/0x40 [=
amdgpu]<br>=C2=A0 =C2=A0amdgpu_cs_ioctl+0x4247/0x5090 [amdgpu]<br>=C2=A0 Fr=
eed by:<br>=C2=A0 =C2=A0ttm_resource_free+0x1f8/0x390 [ttm]<br>=C2=A0 =C2=
=A0ttm_bo_delayed_delete+0x69/0x100 [ttm]<br><br>By dropping the ttm_resour=
ce_unevictable() gate from<br>ttm_resource_del_bulk_move() and removing any=
 tracked resource, the del now runs<br>for resources that have become unevi=
ctable. ttm_lru_bulk_move_del() updates<br>pos-&gt;first/pos-&gt;last by wa=
lking the manager LRU<br>(ttm_lru_next_res()/ttm_lru_prev_res()), but an un=
evictable resource&#39;s lru.link<br>has been moved to bdev-&gt;unevictable=
, so the walk lands on an unrelated resource<br>and leaves the cursor point=
ing outside the bulk-move range. That resource is<br>freed later, and the n=
ext ttm_lru_bulk_move_tail() dereferences the dangling<br>cursor.<br><br>II=
UC the resource needs to be taken off the cursor at the point it becomes<br=
>unevictable (while its link is still on the manager LRU), not deferred to<=
br>free/teardown. The kunit tests passed only because they used a single-el=
ement<br>cursor, where ttm_lru_bulk_move_del() clears pos without walking; =
they did<br>not cover the multi-element / moved-link case that this UAF nee=
ds.<br><br>I am not 100% convinced I have this pinned down yet, but I belie=
ve I may be<br>making progress. Feedback welcome!<br><br>I&#39;ll try to fo=
llow up with a v2 that fixes it at the unevictable transition and<br>adds t=
ests that actually exercise the multi-element case. Apologies for the<br>co=
nfusion.<br><br></div><div>Best,<br></div><div>Sam</div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Jun 15, 2026 at 11:49=E2=80=AFPM Samuel Ainsworth &lt;<a href=3D"mailt=
o:skainsworth@gmail.com">skainsworth@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">A resource added to a bo&#39;=
s bulk_move LRU cursor can become unevictable<br>
(pinned or swapped) after it has been added. ttm_resource_del_bulk_move()<b=
r>
then skips removing it -- both on free and on ttm_bo_set_bulk_move() during=
<br>
bo teardown -- because the resource is unevictable, leaving the cursor&#39;=
s<br>
pos-&gt;first/pos-&gt;last pointing at it. Once freed, the next allocation =
on that<br>
bulk_move dereferences the dangling cursor (use-after-free) and corrupts th=
e<br>
LRU list, which CONFIG_DEBUG_LIST turns into a fatal BUG.<br>
<br>
In the field this is a hibernation-triggered panic on a Framework 13 (AMD<b=
r>
Ryzen 7040): a buffer swapped out during hibernate is closed after resume<b=
r>
(amdgpu_gem_object_close -&gt; amdgpu_vm_bo_del -&gt; ttm_bo_set_bulk_move(=
)),<br>
which leaves its unevictable resource on the VM&#39;s bulk_move cursor; a l=
ater<br>
GEM allocation on that cursor then faults (drm/amd issue #5387).<br>
<br>
Patch 1 tracks cursor membership explicitly so the del always undoes the<br=
>
add, regardless of any pin/swap transition. Patch 2 adds kunit regression<b=
r>
coverage.<br>
<br>
Validating the bug (no GPU required, patch 2):<br>
<br>
=C2=A0- ttm_bo_bulk_move_swapped_free_dangles allocates a resource on a<br>
=C2=A0 =C2=A0bulk_move cursor, swaps out its bo&#39;s ttm so the resource b=
ecomes<br>
=C2=A0 =C2=A0unevictable, frees it, and asserts the cursor no longer refere=
nces the<br>
=C2=A0 =C2=A0freed resource. Without the fix this fails: pos-&gt;first/pos-=
&gt;last still<br>
=C2=A0 =C2=A0equal the freed pointer.<br>
<br>
=C2=A0- ttm_bo_bulk_move_dangling_corrupts then allocates on the same<br>
=C2=A0 =C2=A0bulk_move; without the fix, KASAN reports a slab-use-after-fre=
e in<br>
=C2=A0 =C2=A0ttm_resource_add_bulk_move().<br>
<br>
On the affected machine, a throwaway debug kernel that WARN_ONCE()s when<br=
>
ttm_resource_del_bulk_move() skips an unevictable resource still on the<br>
cursor was used to test. It fired during a normal hibernate/resume cycle, v=
ia<br>
amdgpu_gem_object_close() -&gt; amdgpu_vm_bo_del() -&gt; ttm_bo_set_bulk_mo=
ve().<br>
That confirmed the production trigger and that the planted state matches<br=
>
the field crash (the ttm_resource.c WARN_ON, then list_del corruption).<br>
<br>
With the patch 1 fix, both kunit tests pass and the full TTM kunit suite is=
<br>
green (no KASAN report, no CONFIG_DEBUG_LIST splat). Furthermore, I set up =
a<br>
kernel with the fix, built with KASAN + CONFIG_DEBUG_LIST + lockdep, and ra=
n 10<br>
hibernate/resume/GEM-close cycles under GPU load with no use-after-free nor=
 LRU<br>
list corruption.<br>
<br>
I am new to this area, so review of the approach is very welcome -- in<br>
particular whether tracking membership on the resource is preferrable vs<br=
>
removing it from the cursor at the point it becomes unevictable.<br>
<br>
Samuel Ainsworth (2):<br>
=C2=A0 drm/ttm: don&#39;t leave bulk_move cursor dangling for unevictable<b=
r>
=C2=A0 =C2=A0 resources<br>
=C2=A0 drm/ttm/tests: add bulk_move cursor regression tests<br>
<br>
=C2=A0drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 163 +++++++++++++++++++++++=
+<br>
=C2=A0drivers/gpu/drm/ttm/ttm_resource.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 ++-=
<br>
=C2=A0include/drm/ttm/ttm_resource.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A09 ++<br>
=C2=A03 files changed, 187 insertions(+), 3 deletions(-)<br>
<br>
<br>
base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43<br>
--<br>
2.54.0<br>
</blockquote></div></div>

--00000000000068fc8f0654544705--
