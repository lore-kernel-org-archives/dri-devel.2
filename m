Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCB3C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1677F10F08C;
	Thu, 17 Sep 2026 19:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fb4FliKz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2840510F08C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789672866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FyzJyJeSPWpqg7lw8x1mCB1MBijseGVtrutxbMvcJzw=;
 b=fb4FliKzeL1nKYkjq2BvOanBx09nk2C6+qyTYAnHilXmgI5qaOoXRYU3NbZT4sCOvIKlVN
 PMTwRQgpgWk2Vp0gXZQFkhGtT/udxv2J+RnwCLrD6QtMwwYJ+sPLXz8dZyimX+kEN/3ElY
 iZrAiU15xW+JLEvbGc8ewbHc+G4STdc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-h_8-cHALMB6q-pwzi0q_TQ-1; Thu, 17 Sep 2026 15:21:04 -0400
X-MC-Unique: h_8-cHALMB6q-pwzi0q_TQ-1
X-Mimecast-MFC-AGG-ID: h_8-cHALMB6q-pwzi0q_TQ_1789672864
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9104ba8bf51so717076d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789672864; x=1790277664;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kpLLCOIJaNkZQflZrI+TWuCqX2syaV6YM6JlIfmZxEk=;
 b=boszjpovuUq7pN6JpOWbjsLkxoNsG8pZskEf4o9AbcwUZAJkTcOOV164W5jLHHwlia
 UTH7DU7fYNcle4OXRIs2j9CoWohOFsyyrBJJfFkz2ZPntI1fIhXY5n/Aw5D6bKyfsxTL
 zxXzeGwqrgs7mRrrwlho1n1KG1koB03nFLZ/nFqJHCaq8JTTzRn/R/eHH2qekyJJDvyF
 ZbKDg0xwXV1aR2+LyNiygRWiHlgs3+3DpWTMl71J9zdiOIRi8HngTuZH+Z/m27Y+THKI
 Zx1nhwo1WRBldmVff5mB1EecCdS8gSN4cZQ3LOJimbGC5+VpPO9Cty/FG6JjopYfCCpH
 u41Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaXx2ybDzq8nKiKN2fEiVAcx7+HTVe0XssBFinJ5JUNsHdK++bsaa1GiI2I2dtvQTXVlEd4dh7SuQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZzqPJbFknbtPAIRB35jADezhE+RyWcjAL9Z5ulHUsIuE+fD0V
 CBNRVfWWRv9RfRxbMOKJKpoxr8myUD23iEbDphDBTyx9Aa6UWKvlZ4YeljxssBabN1OFtF+jQgh
 64KUPxrMVuzZXcW4YkvcCvDRVLhw3EdQORNURfhHuVNCkp6uU295SbmZi7cCJnPeIYV7Idrd/dJ
 Nmbw==
X-Gm-Gg: AYBFou3Vdm03pIac2cIPPhad5nbZHGLwUHy5jdVBG2mzadnIwNUnO2rrA50K3xSoT5h
 RYgF7O/fsrfd7xUC0BUghiRFKYd8EOdZRtkHVZWiytGolieAYhfjd37ZVjnUYKgmv5ZkmNKXksa
 iLQvkKE6sD8zlYJ9vG4c5bNJ126sReXCGiSSonKINfdGKXB5qMZj1Ghrio3rsQtMAz4GbVUoSW3
 +CQCCQ4nhWBG5etV8gzdufdh8YyAUcYAK4rII2Uq90Tjda02hM1wk5Ft6mN4h5V4h/mfooC4i9x
 oRT5uF9VXNmj+A7GpK/CEpyYMmPSpWQtc/zld7XqFwiLEpZTsHJjS8KjW27TWjxtD9S1jzZ1
X-Received: by 2002:a05:620a:4147:b0:939:ba2e:455f with SMTP id
 af79cd13be357-93bb797001amr1475875485a.51.1789672864066; 
 Thu, 17 Sep 2026 12:21:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4147:b0:939:ba2e:455f with SMTP id
 af79cd13be357-93bb797001amr1475870885a.51.1789672863572; 
 Thu, 17 Sep 2026 12:21:03 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b780cfa83sm522700085a.3.2026.09.17.12.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:21:03 -0700 (PDT)
Message-ID: <9fd4458240f45ea1ea6d4d79362f72d847b958aa.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: fix double-free in nvif_vmm_dtor
From: lyude@redhat.com
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, dakr@kernel.org, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 bskeggs@redhat.com, 	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de
Date: Thu, 17 Sep 2026 15:21:02 -0400
In-Reply-To: <03BA723D9E5FF725+20260916103138.2651605-1-peiyang_he@smail.nju.edu.cn>
References: <03BA723D9E5FF725+20260916103138.2651605-1-peiyang_he@smail.nju.edu.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AlVEPbf390LlSUr-rPLKPa8yaZiT9B-pdSGU14R-Wc8_1789672864
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in a moment

On Wed, 2026-09-16 at 18:31 +0800, Peiyang He wrote:
> On failure, nouveau_cli_init() calls nouveau_cli_fini() to tear
> the client down. Then, nouveau_drm_open() also enters into its
> cleanup path and calls nouveau_cli_fini() AGAIN. nouveau_cli_fini()
> calls nouveau_vmm_fini():
>=20
> =09void
> =09nouveau_vmm_fini(struct nouveau_vmm *vmm)
> =09{
> =09=09nouveau_svmm_fini(&vmm->svmm);
> =09=09nvif_vmm_dtor(&vmm->vmm);
> =09=09vmm->cli =3D NULL;
> =09}
>=20
> Inside nvif_vmm_dtor(), vmm->page is freed unconditionally:
>=20
> =09void
> =09nvif_vmm_dtor(struct nvif_vmm *vmm)
> =09{
> =09=09kfree(vmm->page);
> =09=09nvif_object_dtor(&vmm->object);
> =09}
>=20
> vmm->page is never cleared after being freed, so the second call of
> nvif_vmm_dtor() will cause a double-free.
>=20
> Found by fuzzing the nouveau driver with a modified Syzkaller:
>=20
> =09BUG: KASAN: double-free in nvif_vmm_dtor+0x31/0x50
> drivers/gpu/drm/nouveau/nvif/vmm.c:194
> =09Free of addr ffff888010fcdc30 by task syz.0.173/2567
>=20
> =09CPU: 1 UID: 0 PID: 2567 Comm: syz.0.173 Not tainted 7.2.0
> #24 PREEMPT(lazy)=20
> =09Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> =09Call Trace:
> =09<TASK>
> =09__dump_stack lib/dump_stack.c:94 [inline]
> =09dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
> =09print_address_description mm/kasan/report.c:378 [inline]
> =09print_report+0xcb/0x5a0 mm/kasan/report.c:482
> =09kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:557
> =09check_slab_allocation+0xe4/0x110 mm/kasan/common.c:235
> =09kasan_slab_pre_free include/linux/kasan.h:199 [inline]
> =09slab_free_hook mm/slub.c:2622 [inline]
> =09slab_free mm/slub.c:6377 [inline]
> =09kfree+0x192/0x590 mm/slub.c:6692
> =09nvif_vmm_dtor+0x31/0x50
> drivers/gpu/drm/nouveau/nvif/vmm.c:194
> =09nouveau_vmm_fini+0x16/0x50
> drivers/gpu/drm/nouveau/nouveau_vmm.c:127
> =09nouveau_cli_fini+0x10e/0x210
> drivers/gpu/drm/nouveau/nouveau_drm.c:225
> =09nouveau_drm_open+0x24e/0x740
> drivers/gpu/drm/nouveau/nouveau_drm.c:1255
> =09drm_file_alloc+0x5f2/0xad0 drivers/gpu/drm/drm_file.c:176
> =09drm_open_helper+0x1d7/0x4a0 drivers/gpu/drm/drm_file.c:335
> =09drm_open+0x190/0x3d0 drivers/gpu/drm/drm_file.c:388
> =09drm_stub_open+0x1f2/0x460 drivers/gpu/drm/drm_drv.c:1211
> =09chrdev_open+0x21c/0x660 fs/char_dev.c:411
> =09do_dentry_open+0x59d/0x12b0 fs/open.c:947
> =09vfs_open+0x82/0x390 fs/open.c:1052
> =09do_open fs/namei.c:4700 [inline]
> =09path_openat+0x2345/0x3420 fs/namei.c:4863
> =09do_file_open+0x207/0x460 fs/namei.c:4892
> =09do_sys_openat2+0xd1/0x1d0 fs/open.c:1368
> =09do_sys_open fs/open.c:1374 [inline]
> =09__do_sys_openat fs/open.c:1390 [inline]
> =09__se_sys_openat fs/open.c:1385 [inline]
> =09__x64_sys_openat+0x144/0x200 fs/open.c:1385
> =09do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =09do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
> =09entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =09RIP: 0033:0x7fc6d687594d
> =09Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48
> 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01
> 48
> =09RSP: 002b:00007fc6d5295008 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> =09RAX: ffffffffffffffda RBX: 00007fc6d6b06180 RCX:
> 00007fc6d687594d
> =09RDX: 0000000000022501 RSI: 0000200000000000 RDI:
> ffffffffffffff9c
> =09RBP: 00007fc6d691c303 R08: 0000000000000000 R09:
> 0000000000000000
> =09R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> =09R13: 00007fc6d6b06218 R14: 00007fc6d6b06180 R15:
> 00007ffd9451d760
> =09</TASK>
>=20
> =09Allocated by task 2567 on cpu 1 at 163.593900s:
> =09kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =09kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =09poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> =09__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
> =09kasan_kmalloc include/linux/kasan.h:263 [inline]
> =09__do_kmalloc_node mm/slub.c:5334 [inline]
> =09__kmalloc_noprof+0x304/0x7c0 mm/slub.c:5359
> =09_kmalloc_noprof include/linux/slab.h:992 [inline]
> =09nvif_vmm_ctor+0x3c0/0x7e0
> drivers/gpu/drm/nouveau/nvif/vmm.c:237
> =09nouveau_vmm_init+0x40/0x90
> drivers/gpu/drm/nouveau/nouveau_vmm.c:134
> =09nouveau_cli_init+0x7b9/0xe10
> drivers/gpu/drm/nouveau/nouveau_drm.c:293
> =09nouveau_drm_open+0x236/0x740
> drivers/gpu/drm/nouveau/nouveau_drm.c:1243
> =09drm_file_alloc+0x5f2/0xad0 drivers/gpu/drm/drm_file.c:176
> =09drm_open_helper+0x1d7/0x4a0 drivers/gpu/drm/drm_file.c:335
> =09drm_open+0x190/0x3d0 drivers/gpu/drm/drm_file.c:388
> =09drm_stub_open+0x1f2/0x460 drivers/gpu/drm/drm_drv.c:1211
> =09chrdev_open+0x21c/0x660 fs/char_dev.c:411
> =09do_dentry_open+0x59d/0x12b0 fs/open.c:947
> =09vfs_open+0x82/0x390 fs/open.c:1052
> =09do_open fs/namei.c:4700 [inline]
> =09path_openat+0x2345/0x3420 fs/namei.c:4863
> =09do_file_open+0x207/0x460 fs/namei.c:4892
> =09do_sys_openat2+0xd1/0x1d0 fs/open.c:1368
> =09do_sys_open fs/open.c:1374 [inline]
> =09__do_sys_openat fs/open.c:1390 [inline]
> =09__se_sys_openat fs/open.c:1385 [inline]
> =09__x64_sys_openat+0x144/0x200 fs/open.c:1385
> =09do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =09do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
> =09entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =09Freed by task 2567 on cpu 1 at 163.601355s:
> =09kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =09kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =09kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
> =09poison_slab_object mm/kasan/common.c:253 [inline]
> =09__kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
> =09kasan_slab_free include/linux/kasan.h:235 [inline]
> =09slab_free_hook mm/slub.c:2677 [inline]
> =09slab_free mm/slub.c:6377 [inline]
> =09kfree+0x383/0x590 mm/slub.c:6692
> =09nvif_vmm_dtor+0x31/0x50
> drivers/gpu/drm/nouveau/nvif/vmm.c:194
> =09nouveau_vmm_fini+0x16/0x50
> drivers/gpu/drm/nouveau/nouveau_vmm.c:127
> =09nouveau_cli_fini+0x10e/0x210
> drivers/gpu/drm/nouveau/nouveau_drm.c:225
> =09nouveau_cli_init+0x593/0xe10
> drivers/gpu/drm/nouveau/nouveau_drm.c:324
> =09nouveau_drm_open+0x236/0x740
> drivers/gpu/drm/nouveau/nouveau_drm.c:1243
> =09drm_file_alloc+0x5f2/0xad0 drivers/gpu/drm/drm_file.c:176
> =09drm_open_helper+0x1d7/0x4a0 drivers/gpu/drm/drm_file.c:335
> =09drm_open+0x190/0x3d0 drivers/gpu/drm/drm_file.c:388
> =09drm_stub_open+0x1f2/0x460 drivers/gpu/drm/drm_drv.c:1211
> =09chrdev_open+0x21c/0x660 fs/char_dev.c:411
> =09do_dentry_open+0x59d/0x12b0 fs/open.c:947
> =09vfs_open+0x82/0x390 fs/open.c:1052
> =09do_open fs/namei.c:4700 [inline]
> =09path_openat+0x2345/0x3420 fs/namei.c:4863
> =09do_file_open+0x207/0x460 fs/namei.c:4892
> =09do_sys_openat2+0xd1/0x1d0 fs/open.c:1368
> =09do_sys_open fs/open.c:1374 [inline]
> =09__do_sys_openat fs/open.c:1390 [inline]
> =09__se_sys_openat fs/open.c:1385 [inline]
> =09__x64_sys_openat+0x144/0x200 fs/open.c:1385
> =09do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =09do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
> =09entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =09The buggy address belongs to the object at ffff888010fcdc30
> =09which belongs to the cache kmalloc-16 of size 16
> =09The buggy address is located 0 bytes inside of
> =0916-byte region [ffff888010fcdc30, ffff888010fcdc40)
>=20
> =09The buggy address belongs to the physical page:
> =09page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x10fcd
> =09flags: 0x100000000000000(node=3D0|zone=3D1)
> =09page_type: f5(slab)
> =09raw: 0100000000000000 ffff88800d441640 dead000000000100
> dead000000000122
> =09raw: 0000000000000000 0000000000550055 00000000f5000000
> 0000000000000000
> =09page dumped because: kasan: bad access detected
>=20
> =09Memory state around the buggy address:
> =09ffff888010fcdb00: fc fc 00 04 fc fc fc fc fa fb fc fc fc fc
> fa fb
> =09ffff888010fcdb80: fc fc fc fc fa fb fc fc fc fc 00 07 fc fc
> fc fc
> =09>ffff888010fcdc00: fa fb fc fc fc fc fa fb fc fc fc fc fa fb
> fc fc
> =09=09=09=09=09=09=09=09
> =09=09^
> =09ffff888010fcdc80: fc fc fa fb fc fc fc fc 00 04 fc fc fc fc
> fa fb
> =09ffff888010fcdd00: fc fc fc fc 00 00 fc fc fc fc fa fb fc fc
> fc fc
>=20
> Fix by removing the redundant teardown in nouveau_drm_open(),
> since nouveau_cli_init() already does the cleanup work.
> Also clear vmm->page after its freeing.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 20d8a88e557a ("drm/nouveau: tidy up the client init/fini
> interfaces")
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: LLM
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 4 +---
> =C2=A0drivers/gpu/drm/nouveau/nvif/vmm.c=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A02 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c
> b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index e16f59b00f6f..c465d59ef0a6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1251,10 +1251,8 @@ nouveau_drm_open(struct drm_device *dev,
> struct drm_file *fpriv)
> =C2=A0=09mutex_unlock(&drm->clients_lock);
> =C2=A0
> =C2=A0done:
> -=09if (ret && cli) {
> -=09=09nouveau_cli_fini(cli);
> +=09if (ret && cli)
> =C2=A0=09=09kfree(cli);
> -=09}
> =C2=A0
> =C2=A0=09pm_runtime_mark_last_busy(dev->dev);
> =C2=A0=09pm_runtime_put_autosuspend(dev->dev);
> diff --git a/drivers/gpu/drm/nouveau/nvif/vmm.c
> b/drivers/gpu/drm/nouveau/nvif/vmm.c
> index 65c3e883b119..579af70766f2 100644
> --- a/drivers/gpu/drm/nouveau/nvif/vmm.c
> +++ b/drivers/gpu/drm/nouveau/nvif/vmm.c
> @@ -192,6 +192,7 @@ void
> =C2=A0nvif_vmm_dtor(struct nvif_vmm *vmm)
> =C2=A0{
> =C2=A0=09kfree(vmm->page);
> +=09vmm->page =3D NULL;
> =C2=A0=09nvif_object_dtor(&vmm->object);
> =C2=A0}
> =C2=A0

