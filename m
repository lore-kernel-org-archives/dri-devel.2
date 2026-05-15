Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6D3CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 04:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E90B10F3BE;
	Fri, 15 May 2026 04:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hfzifJFK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F7710E04E
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 04:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778817958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ+iLTZST8FxP/oRfZ0ADx0fv2jSubDq1lGkoIHgCgI=;
 b=hfzifJFKP4h3SVYD4BbBln4j/zaEyBQx7nCC2voMwosrr8e+2DovDxNZ1AqPpZ1Gba4N+k
 IHJMUy/WI2mEpJsrbV9UDfMfeIHbw0tgSfdUOMm8FumFHxbboQrSv9SBg8sb/EmBGVEm0d
 FaEq7ShzNOGHpxRiHfT/Rc5KYQQlzv4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-O3a_MQ_uOWad8ar8icrqDA-1; Fri, 15 May 2026 00:05:56 -0400
X-MC-Unique: O3a_MQ_uOWad8ar8icrqDA-1
X-Mimecast-MFC-AGG-ID: O3a_MQ_uOWad8ar8icrqDA_1778817955
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a894c2d57cso1271859e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 21:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778817954; x=1779422754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZ+iLTZST8FxP/oRfZ0ADx0fv2jSubDq1lGkoIHgCgI=;
 b=aQS5QxHdPcuv5BLZgV3cxqc9LJhi+WbZskJkMMSkGFAFiOKyLNMapNFCcrdGfWJmJZ
 M2ly1Gju9Hxxy1VFmZhO0hideu4paL62tXasj/ZNRUuTXmdUBH+Gtwd94GXvBild8we8
 e9siHzzRZ7F9li4ZDNjjj0w0kLzCijmJg0qgjetgmS2qtjkkHoDIowN6dz7Z3lWNSNV5
 MFoLRXI1hTNSf9ARQsIT+AkzQM1NTc+GD0oaeNL5N1chM2SDDModWdXXVPaEFjAUMj69
 nWgh/ok+KQ0kcqoN8Hx2pO3gt+oSIpqadVZxwVHeF4Tp7vYXT4luQxljapFJgeWsRZO1
 gIFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BVbWFn7leNetEB9klcX7CQ/suAnzVgjjR85jVSNGxDA5iDdOW9XMhs5u0zwHA76aBF9EhSsrJLio=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxnhHzeuzrElr3ZrUZ/IiBG/3IBzyjGw02ul5CozKccA3jCOvB
 51eYQA94SQoDdVPXJ7LBOKUZNqb1h9CHt/KwFZMO5+QCDf/XmCngwzrJNzHM3CYmr2DrG4y7jhS
 hrDw8XoV+RJKWVARbyNrSZAF5rO4onkOrhaa8W5JAIGov04Ji2KgP6c/HHtSTpl78YXUn
X-Gm-Gg: Acq92OEEPaUhJ4jtK+fBgVtUYbSaeNzYG8pbxCLx3rH48HO986kS8Yq2Y4p26p8mr/f
 BiAv978rND0u5TvNxnqTA7gjX34+XZSY6JAFyYvdpqA4yo42y/WLi+TeEyUGumLa4pdidk6PHaz
 K4cLbQRpYwqHGQSRRCGnxa9PWZ+TvC/JPLcCm/KTlwUhgBQRXaBfUoLFjqkk+AgVXQNazk14khX
 NeyAhkXMkYUmtX2iwwY+pH8CoD49JGruMMAbpFB5a6w44oQexySPq+uW5x58KS2u/aJC04pNrRa
 aLvEattPF7LZfyp8GMkFisYav9EAv/Z7Kdsh8ZRBA0huWF8x2WooHugYM2s/UWtV6EzE7GMnryZ
 A4i6VXgjwkvb/+0ooryzlGIpXhzmkALyaAPet3TzshGnmDwg=
X-Received: by 2002:a05:6512:2397:b0:5a8:9909:50b1 with SMTP id
 2adb3069b0e04-5aa0e610e9amr452538e87.10.1778817954390; 
 Thu, 14 May 2026 21:05:54 -0700 (PDT)
X-Received: by 2002:a05:6512:2397:b0:5a8:9909:50b1 with SMTP id
 2adb3069b0e04-5aa0e610e9amr452515e87.10.1778817953842; 
 Thu, 14 May 2026 21:05:53 -0700 (PDT)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f11a7c2sm932482e87.32.2026.05.14.21.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 21:05:53 -0700 (PDT)
Message-ID: <2fe8d022-a414-4b23-af4f-9cecf1aac3d1@redhat.com>
Date: Fri, 15 May 2026 07:05:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] Migrate on fault for device pages
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260505184421.2324798-1-mpenttil@redhat.com>
 <agaN29W7hAklrCxz@parvat>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <agaN29W7hAklrCxz@parvat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: utXRWpgMHcrVQryHv87dVl2mscLWwDEEgfqv1rM1zc8_1778817955
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

> FYI: While testing with hmm_tests I ran into
>
> [  107.866004] ============================================
> [  107.866284] WARNING: possible recursive locking detected
> [  107.866577] 7.1.0-rc3-00311-g4277273ca0e1 #12 Not tainted
> [  107.866877] --------------------------------------------
> [  107.867217] hmm-tests/1098 is trying to acquire lock:
> [  107.867491] ffff888113571b38 (&mm->mmap_lock){++++}-{4:4}, at: dmirror_range_fault+0x147/0x610 [test_hmm] <- line 368 of lib/test_hmm.c
> [  107.868076] 
> [  107.868076] but task is already holding lock:
> [  107.868383] ffff888113571b38 (&mm->mmap_lock){++++}-{4:4}, at: dmirror_fault_and_migrate_to_device.constprop.0+0x3aa/0x6a0 [test_hmm] <- line 1267 of lib/test_hmm.c
> [  107.869076] 
> [  107.869076] other info that might help us debug this:
> [  107.869415]  Possible unsafe locking scenario:
> [  107.869415] 
> [  107.869729]        CPU0
> [  107.869866]        ----
> [  107.870054]   lock(&mm->mmap_lock);
> [  107.870247]   lock(&mm->mmap_lock);
> [  107.870436] 
> [  107.870436]  *** DEADLOCK ***
> [  107.870436] 
> [  107.870743]  May be due to missing lock nesting notation
> [  107.870743] 
> [  107.871158] 1 lock held by hmm-tests/1098:
> [  107.871377]  #0: ffff888113571b38 (&mm->mmap_lock){++++}-{4:4}, at: dmirror_fault_and_migrate_to_device.constprop.0+0x3aa/0x6a0 [test_hmm]
> [  107.872081] 
> [  107.872081] stack backtrace:
> [  107.872348] CPU: 1 UID: 0 PID: 1098 Comm: hmm-tests Not tainted 7.1.0-rc3-00311-g4277273ca0e1 #12 PREEMPT(full) 
> [  107.872350] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20260213-6.fc44 02/13/2026
> [  107.872354] Call Trace:
> [  107.872357]  <TASK>
> [  107.872358]  dump_stack_lvl+0x5d/0x80
> [  107.872385]  print_deadlock_bug.cold+0xc0/0xe2
> [  107.872393]  __lock_acquire+0x10cf/0x1b90
> [  107.872400]  lock_acquire+0x189/0x2f0
> [  107.872401]  ? dmirror_range_fault+0x147/0x610 [test_hmm]
> [  107.872404]  down_read+0x9b/0x4b0
> [  107.872420]  ? dmirror_range_fault+0x147/0x610 [test_hmm]
> [  107.872421]  ? lock_acquire+0x189/0x2f0
> [  107.872422]  ? __pfx_down_read+0x10/0x10
> [  107.872424]  ? __lock_acquire+0x3c2/0x1b90
> [  107.872425]  dmirror_range_fault+0x147/0x610 [test_hmm]
> [  107.872427]  ? __pfx_down_read+0x10/0x10
> [  107.872429]  ? __pfx_dmirror_range_fault+0x10/0x10 [test_hmm]
> [  107.872430]  ? __lock_acquire+0x3c2/0x1b90
> [  107.872434]  dmirror_fault_and_migrate_to_device.constprop.0+0x3bf/0x6a0 [test_hmm]
> [  107.872436]  ? __pfx_dmirror_fault_and_migrate_to_device.constprop.0+0x10/0x10 [test_hmm]
> [  107.872439]  ? find_held_lock+0x2b/0x80
> [  107.872444]  ? dmirror_device_remove_chunks+0x5b8/0xa00 [test_hmm]
> [  107.872445]  ? __is_insn_slot_addr+0xee/0x1f0
> [  107.872458]  ? lock_acquire+0x189/0x2f0
> [  107.872460]  ? avc_has_extended_perms+0x234/0x1350
> [  107.872476]  ? __might_fault+0x89/0x150
> [  107.872484]  ? lock_release+0xe1/0x320
> [  107.872486]  dmirror_fops_unlocked_ioctl+0x9ba/0xdb0 [test_hmm]
> [  107.872488]  ? ioctl_has_perm.constprop.0.isra.0+0x2fe/0x6c0
> [  107.872494]  ? __pfx_dmirror_fops_unlocked_ioctl+0x10/0x10 [test_hmm]
> [  107.872498]  ? count_memcg_events_mm.constprop.0+0x22/0x1a0
> [  107.872499]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> [  107.872501]  ? count_memcg_events_mm.constprop.0+0xaa/0x1a0
> [  107.872503]  ? lock_release+0xe1/0x320
> [  107.872504]  ? find_held_lock+0x2b/0x80
> [  107.872506]  ? exc_page_fault+0x7e/0xf0
> [  107.872510]  __x64_sys_ioctl+0x13c/0x1d0
> [  107.872521]  ? lockdep_hardirqs_on_prepare+0xd9/0x190
> [  107.872523]  do_syscall_64+0xf3/0x6a0
> [  107.872526]  ? exc_page_fault+0xde/0xf0
> [  107.872528]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  107.872529] RIP: 0033:0x7f7381c543ad
> [  107.872531] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  107.872532] RSP: 002b:00007ffc3160a9b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  107.872539] RAX: ffffffffffffffda RBX: 00007f7381b44000 RCX: 00007f7381c543ad
> [  107.872540] RDX: 00007ffc3160aa30 RSI: 00000000c0284803 RDI: 0000000000000022
> [  107.872541] RBP: 00007ffc3160aa00 R08: 00000000ffffffff R09: 0000000000000000
> [  107.872541] R10: 0000000000000022 R11: 0000000000000246 R12: 00007ffc3160aa24
> [  107.872542] R13: 000000000041f380 R14: 0000000000000200 R15: 00007f7381200000
> [  107.872544]  </TASK>
>
>
> Thanks,
> Balbir
>
Thanks, I could reproduce. Had lockdep dropped off so went unnoticed. It is nesting mmap_read_lock in the test suite, I will change that in next version.

--Mika


