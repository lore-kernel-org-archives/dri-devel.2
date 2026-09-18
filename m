Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC70C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED2210F4AD;
	Fri, 18 Sep 2026 18:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UEv2mnA0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A363810F4AD
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789755233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZCWUomW5I9+ms3uPjNitTm1N4lAbHHCP3LaSArR6L8=;
 b=UEv2mnA0OxKP2EqFQd0wC8061qBRqL+x/YvLK47X6DpkP23GBs9sRyWtqgWlFtxzLh7kc0
 8Sl/g1Tbf/6qifjZYNkZnhhSuAQaFVP9Ggs6zrcneEZuPKBqmyn5w0XrZvn4TzIcZBOJ50
 Hn5aXa9mRt5vxHiknoRr/7ADNjti4gM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-L5hDHD6oPNC-wqVljhmlEA-1; Fri, 18 Sep 2026 14:13:52 -0400
X-MC-Unique: L5hDHD6oPNC-wqVljhmlEA-1
X-Mimecast-MFC-AGG-ID: L5hDHD6oPNC-wqVljhmlEA_1789755232
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530ef71ee55so13384681cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755232; x=1790360032;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J1jtneS41EfApWU8IJSvGq3jJfWC73gwxxyLVnNUCV4=;
 b=V9p32lPTJVT9ydGvS2jpa/CbTgdAZKPWz6Pn9EZo8dmwMIQR+7pJtz/axuLyxfk8rc
 27MQew6F88b8ppxcp98btLnGh8BdsF3paaSN+x8SAtt5zJPxtzKK5uCr2uDXvueFVMbH
 0OVggDfMRtnIDwBzpEPr/nJb0NvhkkSs8Bpg3/PZwOi6mYrKcCjb/MkJzEk5ErA49ed6
 dDye+F4XPqZDFFfjFfV+x968Wk/a3z/9+7O3u9xKwyJSfMF84lIT8KFnUAx+p3aheppj
 2T2wN88AY6Ml1hzMzdArS1yUxwEGKoTTNboujrkJAOOgTGJCW5XqqDJID2bKVaXKwunr
 /uKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrmn7iK5hI5St6ovccPLRYEiQsk6UoJKFXW3zm0raTsCT919DTcRANBiWa3+DblSOYaGDa69E905U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l4pxq/sjr4o4bO2P6M9Q9n/ceJ202ebhf8CZE75936Y4C1BO3t
 54bR3B6KdUZM4sV7ZCHY4XWJUd2ioSrRFd+Of+DPVmA6H0oBk5JXqkPsjsHWPTab9RvKr9LF8oa
 pt672KSyLKGlpkSZO5p05OJTlkjTe4Y3ZkmtqlsYk9AWX/01UophYBEknpCuzRUUZpQMPRg==
X-Gm-Gg: AYBFou0iB1Vi1TKcqtS1kQDi0y74mtn+p1y3BqRgUag68OLlhOOP21ZGGEPv4usEnxV
 30kEUFgDEY1OFbHBpxCUUppGGtXjBEvG/23rsHHJukcibAwD8zx2aW0ojWrwsLWIE5aFt5RtLCp
 A8uiespZOyEdZtEtYwcXvrxNhPWaE6RbXxSgQrVhPsuJBUPBWLcmYKw97mAdlsAedyyH5UewM5Z
 Q+Prt0lK5bPQmEPYXD5GFi+a4uTdKaxn6to0aa0sA//jnYq7wAxfh/LKfxtKudgN9IaruC8Fp+R
 MBt83hrBPoo2HdDiixXSB38NVczX9dE4hpoC39v+Pu2+t2t6X/LktqyrY/Q4MGv0BOLyKjH/
X-Received: by 2002:a05:622a:5c16:b0:532:9add:50b4 with SMTP id
 d75a77b69052e-5329e3f97b8mr62334601cf.68.1789755231731; 
 Fri, 18 Sep 2026 11:13:51 -0700 (PDT)
X-Received: by 2002:a05:622a:5c16:b0:532:9add:50b4 with SMTP id
 d75a77b69052e-5329e3f97b8mr62333991cf.68.1789755231255; 
 Fri, 18 Sep 2026 11:13:51 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260968826sm1929916d6.4.2026.09.18.11.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:13:50 -0700 (PDT)
Message-ID: <794fc2ed6ee73b65a5d714c16fd9c24bf92c4340.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: don't bump pin count on failed re-pin
 in nouveau_bo_pin_locked()
From: lyude@redhat.com
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, dakr@kernel.org, 
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 18 Sep 2026 14:13:49 -0400
In-Reply-To: <EACEF2F4E098413F+20260918025312.2814889-1-peiyang_he@smail.nju.edu.cn>
References: <EACEF2F4E098413F+20260918025312.2814889-1-peiyang_he@smail.nju.edu.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EjjGQQ8WER7ZLNzDHe3fqxi8rqFHobHCfY_hVBVGE3U_1789755232
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

Will push to drm-misc-fixes in just a moment

On Fri, 2026-09-18 at 10:53 +0800, Peiyang He wrote:
> nouveau_bo_pin_locked() checks whether an already pinned BO is in a
> memory domain compatible with a new pin request. When the domains are
> incompatible, it sets -EBUSY but still calls ttm_bo_pin() before
> returning.
>=20
> Callers treat a failed nouveau_bo_pin() as not having acquired a new
> pin,
> so the extra pin count is never decreased by a matching unpin.
> This triggers the warning in ttm_bo_release():
>=20
> =09WARN_ON_ONCE(bo->pin_count);
>=20
> Found when fuzzing the nouveau driver with a modified Syzkaller:
>=20
> =09WARNING: drivers/gpu/drm/ttm/ttm_bo.c:256 at
> ttm_bo_release+0x827/0x9e0 drivers/gpu/drm/ttm/ttm_bo.c:256, CPU#1:
> syz.3.24/2212
> =09Modules linked in:
> =09CPU: 1 UID: 0 PID: 2212 Comm: syz.3.24 Not tainted 7.2.0 #24
> PREEMPT(lazy)
> =09nouveau 0000:01:00.0: gsp:msg fn:103 len:0x40/0x20 res:0x19
> resp:0x19
> =09Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> =09RIP: 0010:ttm_bo_release+0x827/0x9e0
> drivers/gpu/drm/ttm/ttm_bo.c:256
> =09Code: 02 00 0f 85 51 01 00 00 48 8b 7b 08 e8 d2 20 01 00 e9
> 80 fd ff ff e8 d8 15 c0 fe 90 0f 0b 90 e9 e1 f8 ff ff e8 ca 15 c0 fe
> 90 <0f> 0b 90 e9 a4 f8 ff ff e8 bc 15 c0 fe be 03 00 00 00 4c 89 e7
> e8
> =09msg: 00000000: 05 00 d0 c1 04 00 f0 f1 01 30 00 00 2d 90 00
> 00=C2=A0 .........0..-...
> =09RSP: 0018:ffffc9000f5cf710 EFLAGS: 00010293
> =09RAX: 0000000000000000 RBX: ffff888018e5d2a8 RCX:
> ffffffff82bb1b36
> =09RDX: ffff888017b68000 RSI: 0000000000000004 RDI:
> ffff888018e5d2a8
> =09msg: 00000010: 19 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00=C2=A0 ................
> =09RBP: ffff88801261c720 R08: 0000000000000001 R09:
> ffffed10031cba55
> =09R10: ffff888018e5d2ab R11: 00000000000000f3 R12:
> ffff888018e5d290
> =09R13: ffff888018e5d2d4 R14: ffff88801b219c18 R15:
> dffffc0000000000
> =09FS:=C2=A0 0000000000000000(0000) GS:ffff8880e0f6f000(0000)
> knlGS:0000000000000000
> =09CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =09CR2: 0000001b31223ffc CR3: 0000000028e00005 CR4:
> 0000000000770ef0
> =09PKRU: 80000000
> =09Call Trace:
> =09<TASK>
> =09kref_put include/linux/kref.h:65 [inline]
> =09ttm_bo_put drivers/gpu/drm/ttm/ttm_bo.c:325 [inline]
> =09ttm_bo_fini+0x55/0x80 drivers/gpu/drm/ttm/ttm_bo.c:330
> =09nouveau_gem_object_del+0xb2/0x1b0
> drivers/gpu/drm/nouveau/nouveau_gem.c:90
> =09drm_gem_object_free+0x5f/0x90 drivers/gpu/drm/drm_gem.c:1165
> =09kref_put include/linux/kref.h:65 [inline]
> =09__drm_gem_object_put include/drm/drm_gem.h:562 [inline]
> =09drm_gem_object_put include/drm/drm_gem.h:575 [inline]
> =09nouveau_abi16_chan_fini.constprop.0+0x44f/0x5a0
> drivers/gpu/drm/nouveau/nouveau_abi16.c:195
> =09nouveau 0000:01:00.0: syz.2.23[2209]: Unknown handle
> 0x00000000
> =09nouveau_abi16_fini+0x1d0/0x340
> drivers/gpu/drm/nouveau/nouveau_abi16.c:225
> =09nouveau_drm_postclose+0x18b/0x3e0
> drivers/gpu/drm/nouveau/nouveau_drm.c:1284
> =09nouveau 0000:01:00.0: syz.2.23[2209]: validate_init
> =09drm_file_free.part.0+0x6d6/0xb60
> drivers/gpu/drm/drm_file.c:267
> =09drm_file_free drivers/gpu/drm/drm_file.c:237 [inline]
> =09drm_close_helper.isra.0+0x11a/0x160
> drivers/gpu/drm/drm_file.c:290
> =09drm_release+0x1ab/0x330 drivers/gpu/drm/drm_file.c:438
> =09__fput+0x39c/0xa60 fs/file_table.c:512
> =09nouveau 0000:01:00.0: syz.2.23[2209]: validate: -2
> =09task_work_run+0x15a/0x230 kernel/task_work.c:233
> =09exit_task_work include/linux/task_work.h:40 [inline]
> =09do_exit+0x82b/0x25a0 kernel/exit.c:1009
> =09do_group_exit+0xc2/0x280 kernel/exit.c:1152
> =09get_signal+0x1d6e/0x1f30 kernel/signal.c:3046
> =09arch_do_signal_or_restart+0x7d/0x6e0
> arch/x86/kernel/signal.c:337
> =09__exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
> =09exit_to_user_mode_loop+0xdf/0x440 kernel/entry/common.c:101
> =09__exit_to_user_mode_prepare include/linux/irq-entry-
> common.h:207 [inline]
> =09syscall_exit_to_user_mode_prepare include/linux/irq-entry-
> common.h:230 [inline]
> =09syscall_exit_to_user_mode include/linux/entry-common.h:318
> [inline]
> =09do_syscall_64+0x4f8/0x690 arch/x86/entry/syscall_64.c:100
> =09entry_SYSCALL_64_after_hwframe+0x77/0x7f
> =09RIP: 0033:0x7f12bac8594d
> =09Code: Unable to access opcode bytes at 0x7f12bac85923.
> =09RSP: 002b:00007f12b96e70d8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000ca
> =09RAX: 0000000000000001 RBX: 00007f12baf15fa8 RCX:
> 00007f12bac8594d
> =09RDX: 00000000000f4240 RSI: 0000000000000081 RDI:
> 00007f12baf15fac
> =09RBP: 00007f12baf15fa0 R08: 00007f12baee8000 R09:
> 0000000000000000
> =09R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> =09R13: 00007f12baf16038 R14: 0000000000000006 R15:
> 00007ffe2ed394b0
> =09</TASK>
> =09irq event stamp: 47867
> =09hardirqs last=C2=A0 enabled at (47883): [<ffffffff815cafc6>]
> __up_console_sem+0x66/0x70 kernel/printk/printk.c:347
> =09hardirqs last disabled at (47892): [<ffffffff815cafab>]
> __up_console_sem+0x4b/0x70 kernel/printk/printk.c:345
> =09softirqs last=C2=A0 enabled at (47880): [<ffffffff81434277>]
> __do_softirq kernel/softirq.c:656 [inline]
> =09softirqs last=C2=A0 enabled at (47880): [<ffffffff81434277>]
> invoke_softirq kernel/softirq.c:496 [inline]
> =09softirqs last=C2=A0 enabled at (47880): [<ffffffff81434277>]
> __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
> =09softirqs last disabled at (47875): [<ffffffff81434277>]
> __do_softirq kernel/softirq.c:656 [inline]
> =09softirqs last disabled at (47875): [<ffffffff81434277>]
> invoke_softirq kernel/softirq.c:496 [inline]
> =09softirqs last disabled at (47875): [<ffffffff81434277>]
> __irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
>=20
> Fix by calling ttm_bo_pin() only when the existing placement is
> compatible
> with the new pin request. This matches the correct behavior in other
> DRM
> drivers such as amdgpu_bo_pin() in amdgpu.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ad76b3f7c7a0 ("drm/nouveau: teach nouveau_bo_pin() how to
> force a contig vram allocation")
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: LLM
> ---
> Changes in v2:
> =C2=A0 - replace goto with else branch (suggested by Lyude Paul)
> =C2=A0 - fix Assisted-by tag
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_bo.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c
> b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 0e8de6d4b36f..6dcb92575eb4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -578,8 +578,9 @@ int nouveau_bo_pin_locked(struct nouveau_bo
> *nvbo, uint32_t domain, bool contig)
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "0x%08x vs 0x%08x\n", bo=
,
> =C2=A0=09=09=09=09 bo->resource->mem_type, domain);
> =C2=A0=09=09=09ret =3D -EBUSY;
> +=09=09} else {
> +=09=09=09ttm_bo_pin(&nvbo->bo);
> =C2=A0=09=09}
> -=09=09ttm_bo_pin(&nvbo->bo);
> =C2=A0=09=09goto out;
> =C2=A0=09}
> =C2=A0
>=20
> base-commit: df2908090cda368b01ff43709f51890076c56157

