Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5957ECD98EE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B6210ECEB;
	Tue, 16 Jun 2026 18:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oqKDcgiP";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460DB10E7FA
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 03:42:24 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-397e391cb2aso35335761fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781581342; cv=none;
 d=google.com; s=arc-20240605;
 b=JjkHGf8adlzfwtT5VmsRG+jaHAElVUtLvPaAXgUMBhr3/O6wL/3Pg7Ddnn5wBFe1or
 w/EMNKAYjvhcHvP2vKKg70t+igkGxmGW0EixiZNfIBFdguATxeZrvvx+kU72BWAdF6iE
 wbKC+depjgCVrmR4sUxWOP+IKoHQ/KoH09ezA9iuMUIBxvV5ycBs3SOtP2KgbUoOuU1a
 KbD+BpNiF42e8Bq+G7inNodFuH+i9WiejEEUzNxXk8Bznf08qCs8lCxscp1WYrpm/jPA
 9ZdBpCMv0uUpFYmR68hIr1Z0+OmLMZi5lrgbeTRrIibApXxTap7pfEKOq1ooq/1uBmWK
 xd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6QkO242zjqJOUCCQGA9Iv8kbh0YooY0Noa0v7iQvj0Q=;
 fh=4wdKYRDkqAnZisD+GgyEp2t+2kwjw34G4AbDoRz6acs=;
 b=CKa++sNnOFuBVYVGYwVIEyX3uv7DErpO5eXLxNesqpVbGFZZ4AB499H+/FSEveync5
 qFULN206EpiNWcinqqfnKtbKQp2WxjzDK7lK//WO+P7pFNdiWDtA34x1YTS3XBASCLAj
 mtZAu3vOFHJxWK48u+q6XxxO7kuYPxziYbNJ7NYWLDFz5xcWjUAqkUei8+7qxr3sIe1+
 kWoSHiBq7whiCmF7jwTdkbnDmKVwJjqE9tXqu64/oILg9NkI3rUgiwUefwBzpRsBdliL
 oySfDwQlUfeIRg6obU/jU5Vtfp8bIex3m7dEBAQEjDnDPCzXanVbAEb9b4oUa6G8YiQ9
 4spA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781581342; x=1782186142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QkO242zjqJOUCCQGA9Iv8kbh0YooY0Noa0v7iQvj0Q=;
 b=oqKDcgiP7+QssIFwqiPoCCekXCBYMU8wyhPRhHABNtzQbiPfKMBTCicEwfkmwfyWhl
 H0RbCfrevWi7LTKYYb23MG9DlDgilLJTV77GGMV36xX7xSpb6hLUj12BuYgjhRI4RgwQ
 JZ85Vk3qFu/cR7whDBCD8LBTd4piuRXDsxn0pjXh110WbR4J0Ww/c6NlGTMTQJvsCQXj
 sGBuR92A5iKl146QgksHzDhxCR/xbg1scTRy7cG84MdY3hbzDHhU7qO9W1hreqwxff4J
 hX2WMGIoPW9igX1HFUGgm/qwlCVm2W+fiSK5zmlQt1gFoa5tYvF5OxKiZTj/V8NHdzSU
 nQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781581342; x=1782186142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QkO242zjqJOUCCQGA9Iv8kbh0YooY0Noa0v7iQvj0Q=;
 b=J6VDwRBUy02UCRvmJ2VW8WOZjtOYCQZlOG41hXAh4M4+rkxzn1L7IF/Lh8cKyFad2f
 cf03RdNgfH/9Jifugc6pqR/8yk0GibEDCMtR3720iDn02rAZNlczRnHK6HOPrOdjY/IT
 HrJyXeCRI7oBe2KRtyjrj+xJOpiIE59AvozCWKGKQ/z7bN0Lg/mn7X8ziapGBHEsdf9y
 46X7vtuW6FgwIiChpzTZM6cUNrbAerkIgiRW7UljmtGkqcykV7w0/u8+7pR0KNcZgXcv
 pJzmemDN0naw8JT/qo1onQZ6oJ2ringr7CJzZrNSd7Ir2F1F4uPdZp5a/5Foa3A9HkMB
 y5qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ACAtZqKHXmw96pKgrwidRSmr/mPrn4zGcow0Cv1GM1BOgXMbNk1Y9VI+cZrl+aHvdcEHoMWawx6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC/EYSF8n7LTURRz9GWJMo28ETQuC7JyknPS5tyz9o+UBbrplf
 4BtIv80b/VmBZ8fJK0dekQHosbMPQmPKNQqm8zrJoJRKZYi240KFFUZXKBH6FSOOLT4LlClzk8B
 IZ2WfKElWz1/FT1omtXlPUZFiLDlN4ik=
X-Gm-Gg: Acq92OFO8KPoF9Ed7f2ryxY6PHiRnPpi8glUxS0Er/9yHZBJZ4jxGnj6xnTu72fS8aJ
 B7IIzC3hMtOZwuBqv7PbkEoyBJJh9XKpuQXVyF8vU9p+GrvuGpwrmt11ehD3EcBk3IPHGGBdS4C
 lv16qbkTILqsfA4mjo+fLAJsjEXsdZiTS06KNpqFij8psXDcRQ8zHTiRLZ2P4qEZFhxW161U63P
 4CbY3FAn45Kzo4FuTn+sGt0o4CD7YgOJhKl6snuJncvY9OazbPBC/sQNj8nK8iiNVJPY8b72V/I
 eQE0hF/vBuIjOydM/Sb6tMuM2TVrdop/suiDZpgPxzIu/1E=
X-Received: by 2002:a2e:bd8a:0:b0:393:a7d7:7e84 with SMTP id
 38308e7fff4ca-39935773dd6mr36326101fa.24.1781581342125; Mon, 15 Jun 2026
 20:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260615234922.151263-1-skainsworth@gmail.com>
 <CAHYiNPbJ59kWedhzZh9pCOvdd82jPd0mPSvqUcAcpAB_GuYaTA@mail.gmail.com>
In-Reply-To: <CAHYiNPbJ59kWedhzZh9pCOvdd82jPd0mPSvqUcAcpAB_GuYaTA@mail.gmail.com>
From: Samuel Ainsworth <skainsworth@gmail.com>
Date: Tue, 16 Jun 2026 03:41:44 +0000
X-Gm-Features: AVVi8CeqzzoRgnheQTFzthQuFy62FqPdkdsu_fToWpW-W3S4M8fVlIw4YMeHeVs
Message-ID: <CAHYiNPacyFu0Pft2SSS_to6-KZ+zoiF0LGtJk1Gd93Fn84aASg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] drm/ttm: fix bulk_move cursor use-after-free for
 unevictable resources
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Welp, I spoke too soon. v1 is broken.

While stress-testing the fix on the affected machine (KASAN + DEBUG_LIST,
ordinary desktop use rather than only hibernate cycles), I hit a new
use-after-free that this patch introduces:

  BUG: KASAN: slab-use-after-free in ttm_lru_bulk_move_tail+0xa93/0xcb0 [tt=
m]
  Read of size 8 ... by task .swayosd-server
   ttm_lru_bulk_move_tail+0xa93/0xcb0 [ttm]
   amdgpu_vm_move_to_lru_tail+0x29/0x40 [amdgpu]
   amdgpu_cs_ioctl+0x4247/0x5090 [amdgpu]
  Freed by:
   ttm_resource_free+0x1f8/0x390 [ttm]
   ttm_bo_delayed_delete+0x69/0x100 [ttm]

By dropping the ttm_resource_unevictable() gate from
ttm_resource_del_bulk_move() and removing any tracked resource, the del now=
 runs
for resources that have become unevictable. ttm_lru_bulk_move_del() updates
pos->first/pos->last by walking the manager LRU
(ttm_lru_next_res()/ttm_lru_prev_res()), but an unevictable resource's lru.=
link
has been moved to bdev->unevictable, so the walk lands on an unrelated reso=
urce
and leaves the cursor pointing outside the bulk-move range. That resource i=
s
freed later, and the next ttm_lru_bulk_move_tail() dereferences the danglin=
g
cursor.

IIUC the resource needs to be taken off the cursor at the point it becomes
unevictable (while its link is still on the manager LRU), not deferred to
free/teardown. The kunit tests passed only because they used a single-eleme=
nt
cursor, where ttm_lru_bulk_move_del() clears pos without walking; they did
not cover the multi-element / moved-link case that this UAF needs.

I am not 100% convinced I have this pinned down yet, but I believe I may be
making progress. Feedback welcome!

I'll try to follow up with a v2 that fixes it at the unevictable transition=
 and
adds tests that actually exercise the multi-element case. Apologies for the
confusion.

Best,
Sam


On Tue, Jun 16, 2026 at 12:46=E2=80=AFAM Samuel Ainsworth <skainsworth@gmai=
l.com> wrote:
>
> Welp, I spoke too soon. v1 is broken.
>
> While stress-testing the fix on the affected machine (KASAN + DEBUG_LIST,
> ordinary desktop use rather than only hibernate cycles), I hit a new
> use-after-free that this patch introduces:
>
>   BUG: KASAN: slab-use-after-free in ttm_lru_bulk_move_tail+0xa93/0xcb0 [=
ttm]
>   Read of size 8 ... by task .swayosd-server
>    ttm_lru_bulk_move_tail+0xa93/0xcb0 [ttm]
>    amdgpu_vm_move_to_lru_tail+0x29/0x40 [amdgpu]
>    amdgpu_cs_ioctl+0x4247/0x5090 [amdgpu]
>   Freed by:
>    ttm_resource_free+0x1f8/0x390 [ttm]
>    ttm_bo_delayed_delete+0x69/0x100 [ttm]
>
> By dropping the ttm_resource_unevictable() gate from
> ttm_resource_del_bulk_move() and removing any tracked resource, the del n=
ow runs
> for resources that have become unevictable. ttm_lru_bulk_move_del() updat=
es
> pos->first/pos->last by walking the manager LRU
> (ttm_lru_next_res()/ttm_lru_prev_res()), but an unevictable resource's lr=
u.link
> has been moved to bdev->unevictable, so the walk lands on an unrelated re=
source
> and leaves the cursor pointing outside the bulk-move range. That resource=
 is
> freed later, and the next ttm_lru_bulk_move_tail() dereferences the dangl=
ing
> cursor.
>
> IIUC the resource needs to be taken off the cursor at the point it become=
s
> unevictable (while its link is still on the manager LRU), not deferred to
> free/teardown. The kunit tests passed only because they used a single-ele=
ment
> cursor, where ttm_lru_bulk_move_del() clears pos without walking; they di=
d
> not cover the multi-element / moved-link case that this UAF needs.
>
> I am not 100% convinced I have this pinned down yet, but I believe I may =
be
> making progress. Feedback welcome!
>
> I'll try to follow up with a v2 that fixes it at the unevictable transiti=
on and
> adds tests that actually exercise the multi-element case. Apologies for t=
he
> confusion.
>
> Best,
> Sam
>
> On Mon, Jun 15, 2026 at 11:49=E2=80=AFPM Samuel Ainsworth <skainsworth@gm=
ail.com> wrote:
>>
>> A resource added to a bo's bulk_move LRU cursor can become unevictable
>> (pinned or swapped) after it has been added. ttm_resource_del_bulk_move(=
)
>> then skips removing it -- both on free and on ttm_bo_set_bulk_move() dur=
ing
>> bo teardown -- because the resource is unevictable, leaving the cursor's
>> pos->first/pos->last pointing at it. Once freed, the next allocation on =
that
>> bulk_move dereferences the dangling cursor (use-after-free) and corrupts=
 the
>> LRU list, which CONFIG_DEBUG_LIST turns into a fatal BUG.
>>
>> In the field this is a hibernation-triggered panic on a Framework 13 (AM=
D
>> Ryzen 7040): a buffer swapped out during hibernate is closed after resum=
e
>> (amdgpu_gem_object_close -> amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()),
>> which leaves its unevictable resource on the VM's bulk_move cursor; a la=
ter
>> GEM allocation on that cursor then faults (drm/amd issue #5387).
>>
>> Patch 1 tracks cursor membership explicitly so the del always undoes the
>> add, regardless of any pin/swap transition. Patch 2 adds kunit regressio=
n
>> coverage.
>>
>> Validating the bug (no GPU required, patch 2):
>>
>>  - ttm_bo_bulk_move_swapped_free_dangles allocates a resource on a
>>    bulk_move cursor, swaps out its bo's ttm so the resource becomes
>>    unevictable, frees it, and asserts the cursor no longer references th=
e
>>    freed resource. Without the fix this fails: pos->first/pos->last stil=
l
>>    equal the freed pointer.
>>
>>  - ttm_bo_bulk_move_dangling_corrupts then allocates on the same
>>    bulk_move; without the fix, KASAN reports a slab-use-after-free in
>>    ttm_resource_add_bulk_move().
>>
>> On the affected machine, a throwaway debug kernel that WARN_ONCE()s when
>> ttm_resource_del_bulk_move() skips an unevictable resource still on the
>> cursor was used to test. It fired during a normal hibernate/resume cycle=
, via
>> amdgpu_gem_object_close() -> amdgpu_vm_bo_del() -> ttm_bo_set_bulk_move(=
).
>> That confirmed the production trigger and that the planted state matches
>> the field crash (the ttm_resource.c WARN_ON, then list_del corruption).
>>
>> With the patch 1 fix, both kunit tests pass and the full TTM kunit suite=
 is
>> green (no KASAN report, no CONFIG_DEBUG_LIST splat). Furthermore, I set =
up a
>> kernel with the fix, built with KASAN + CONFIG_DEBUG_LIST + lockdep, and=
 ran 10
>> hibernate/resume/GEM-close cycles under GPU load with no use-after-free =
nor LRU
>> list corruption.
>>
>> I am new to this area, so review of the approach is very welcome -- in
>> particular whether tracking membership on the resource is preferrable vs
>> removing it from the cursor at the point it becomes unevictable.
>>
>> Samuel Ainsworth (2):
>>   drm/ttm: don't leave bulk_move cursor dangling for unevictable
>>     resources
>>   drm/ttm/tests: add bulk_move cursor regression tests
>>
>>  drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 163 ++++++++++++++++++++++++
>>  drivers/gpu/drm/ttm/ttm_resource.c      |  18 ++-
>>  include/drm/ttm/ttm_resource.h          |   9 ++
>>  3 files changed, 187 insertions(+), 3 deletions(-)
>>
>>
>> base-commit: 2c7d5b0a5ec0fc713a7f350806553643e87e6f43
>> --
>> 2.54.0
