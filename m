Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B60FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A0510E19F;
	Tue,  5 May 2026 18:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YhmH3Eid";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E43910E19F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778006886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZD1WNE1k/WmJPg25LWZyiq7MLw0O15fr/MzhzoxqC8A=;
 b=YhmH3Eidi3aufJ3TvORGcUJsDe5DclQkrBRz49q3URbeN5ZtdFRdirQKknlsy6A354ShlH
 HFzuu6W/R95sUHzBeZbuC1xZZ3ajvqd2mBTjP+FGzXNT9uBYjGSuX3F/UTlNloXltFuL4d
 4CMOIUzruR0ukyicoedZeSMnMI1wVh4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Tg1lc4YNNva2_AvHWKcf4g-1; Tue, 05 May 2026 14:48:02 -0400
X-MC-Unique: Tg1lc4YNNva2_AvHWKcf4g-1
X-Mimecast-MFC-AGG-ID: Tg1lc4YNNva2_AvHWKcf4g_1778006880
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39391b06ef8so14091581fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 11:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006880; x=1778611680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C1bqbiEVoTmEPJHjXzHnukQrIZ297oQVbCi2us/0k/k=;
 b=jOCxSeky5P3zJqwV+A1+EEgvD1WV3qG7MBye927GktVot+yYqivIyddEY4AQazZhyj
 Gsfybf/xbJW8Tpu67EPqyeSTscOxNrcby0gIxSY/a0IbnGfMWxtSYe270w0LZaNEY1+x
 3iY8TxcCIeWPV2vo6RxyW7UGcPtrKZGtWUnidrV9JpNdm7f8WkHgPNKWAXYHyvCDZaUF
 lRtkw8LfOmALMlL8ZdZ29470gRz5v1drn6VqkuT1VSxvB0Jp5f4eI1oWKqfwIfjLkWcA
 A8iVbVpBzmCZiKfcHlFrXIYafLt1U4/ya4B8fr7380/cGGvMgbQrgV53lvO7hx56jhHT
 0K4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ88I+zi6w+bBJDw/pR9dLmNpZOkTr46QZzxXew2NQPp54JBxQDvZylOXtQKQd6Zib/iO85Uk2T9LAs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRpkMtof8e91Gz4Rgl+J/ZNrx8n8AQ9Ed32/vuD1sqsXWXHPen
 ToN9cVkdWIbCxFibK7tm3LyAV2wQJRr5ZwIcw3tF7XTchgM43a8WiNx68mo57GjKsrfJC3NLibA
 VjqrBJ0XkMiyGUjQMrP2UcREt8qVP34vh5v6yM1DA+9x54DHtQzolTCxH6bAvb32LZYzp
X-Gm-Gg: AeBDievG2x7+aW3yK8ZQPhxjS3LNCt7TgZaxR/mRZQeMva1Dm8SCEFENfDIoQXkikES
 3HP/Sh6I12fVonMexBOmpCWLJvQefJgamMlWnP+xylylA+1DtF0tFEZrJbzilchzp7PPqpOzB5I
 OyHTZVtas59r0lCdIkpQTobJkDOvHqytst9IunMq8Ob19/LazciAbe+UMbKPayK1iQz/P+rBsnz
 05AC56ddClr3INTS20ExWW0OsIUs43w8j2w0jIrkxbFZeOF5sOed7Y8MDrqFu5mkdqmF0uKdd6L
 De5WxAugmiTdhOnsEgufWYbXl0G5+Iv2CZ47piSX7yEyaihG6/rd4/v+pTHbCvWp6nCYwkDKwad
 wQOFp7yzP4/+eGFj+dObenXZb89UqmopFn7tlqX593We1S3N52A618kOv7w==
X-Received: by 2002:a2e:864e:0:b0:38e:2fcc:78fe with SMTP id
 38308e7fff4ca-393c40bcb5cmr1627321fa.3.1778006880088; 
 Tue, 05 May 2026 11:48:00 -0700 (PDT)
X-Received: by 2002:a2e:864e:0:b0:38e:2fcc:78fe with SMTP id
 38308e7fff4ca-393c40bcb5cmr1627151fa.3.1778006879554; 
 Tue, 05 May 2026 11:47:59 -0700 (PDT)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba631sm44569421fa.12.2026.05.05.11.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 11:47:59 -0700 (PDT)
Message-ID: <433d0729-b141-4f19-a0c3-656f033e8ea1@redhat.com>
Date: Tue, 5 May 2026 21:47:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Migrate on fault for device pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260505051658.2219537-1-mpenttil@redhat.com>
 <afmXIq8VY_vs1GPo@nvdebian.thelocal>
 <ecd81b6b-62ef-4dab-a93e-e65598d64841@redhat.com>
 <afowaUffi0JrnADf@gsse-cloud1.jf.intel.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <afowaUffi0JrnADf@gsse-cloud1.jf.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PeaBcEg12Ijf3jSMYq9FC1UbiTNx1O59xjNQGO0GGbw_1778006880
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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


On 5/5/26 21:01, Matthew Brost wrote:

> On Tue, May 05, 2026 at 10:18:14AM +0300, Mika Penttil=C3=A4 wrote:
>> On 5/5/26 10:09, Alistair Popple wrote:
>>
>>> Thanks for doing this work Mika. I've been meaning to take a look at th=
is series
>>> for a while. I'm currently at LSFMM but will try and take a look this w=
eek or
>>> next as it sounds quite useful.
>>>
>>>  - Alistair
>> Thanks Alistair and no problem, appreciate your insights whenever you ha=
ve time.
>>
> It looks like this series is breaking Intel's CI [1]. Looks like
> something in RCU is blowing up:
>
> <4> [212.361418] ------------[ cut here ]------------
> <4> [212.361431] Voluntary context switch within RCU read-side critical s=
ection!
> <4> [212.361432] WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_contex=
t_switch+0x82/0x780, CPU#11: kworker/u65:5/2352
> <4> [212.361440] Modules linked in: snd_hda_codec_intelhdmi snd_hda_codec=
_hdmi mei_lb mei_gsc_proxy mtd_intel_dg mei_gsc xe drm_gpuvm drm_gpusvm_hel=
per drm_buddy gpu_sched drm_ttm_helper ttm drm_suballoc_helper drm_exec drm=
_display_helper cec rc_core drm_kunit_helpers i2c_algo_bit kunit overlay in=
tel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequenc=
y_common intel_tcc_cooling x86_pkg_temp_thermal intel_powerclamp hid_generi=
c coretemp eeepc_wmi cmdlinepart asus_wmi binfmt_misc sparse_keymap spi_nor=
 mei_hdcp mei_pxp mtd wmi_bmof kvm_intel kvm irqbypass aesni_intel gf128mul=
 r8169 usbhid rapl hid intel_cstate realtek snd_hda_intel phy_package snd_i=
ntel_dspcfg intel_pmc_core snd_hda_codec idma64 nls_iso8859_1 pmt_telemetry=
 snd_hda_core video snd_hwdep pmt_discovery snd_pcm i2c_i801 pinctrl_alderl=
ake pmt_class snd_timer i2c_mux intel_pmc_ssram_telemetry acpi_tad acpi_pad=
 mei_me snd i2c_smbus spi_intel_pci soundcore mei spi_intel wmi intel_vsec =
dm_multipath msr nvme_fabrics fuse efi_pstore nfnetlink autofs4
> <4> [212.361711] CPU: 11 UID: 0 PID: 2352 Comm: kworker/u65:5 Tainted: G =
S   U              7.1.0-rc2-lgci-xe-xe-pw-165953v1-debug+ #1 PREEMPT(lazy)=
=20
> <4> [212.361715] Tainted: [S]=3DCPU_OUT_OF_SPEC, [U]=3DUSER
> <4> [212.361716] Hardware name: ASUS System Product Name/PRIME Z790-P WIF=
I, BIOS 0812 02/24/2023
> <4> [212.361718] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_w=
ork [xe]
> <4> [212.361833] RIP: 0010:rcu_note_context_switch+0x82/0x780
> <4> [212.361838] Code: 45 85 c0 74 0f 65 8b 05 24 84 ab 02 85 c0 0f 84 8d=
 01 00 00 45 84 ed 75 16 8b 83 bc 08 00 00 85 c0 7e 0c 48 8d 3d de ad 4d 02=
 <67> 48 0f b9 3a 8b 83 bc 08 00 00 85 c0 7e 0d 80 bb c0 08 00 00 00
> <4> [212.361840] RSP: 0018:ffffc9000186f4a0 EFLAGS: 00010002
> <4> [212.361843] RAX: 0000000000000001 RBX: ffff88810a3a8040 RCX: 0000000=
000000000
> <4> [212.361845] RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffff=
f839bcea0
> <4> [212.361846] RBP: ffffc9000186f4e8 R08: 0000000000000001 R09: 0000000=
000000000
> <4> [212.361848] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888=
85f1b6a00
> <4> [212.361849] R13: 0000000000000000 R14: ffffffff83248312 R15: ffffc90=
00186f630
> <4> [212.361851] FS:  0000000000000000(0000) GS:ffff8888db203000(0000) kn=
lGS:0000000000000000
> <4> [212.361853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4> [212.361854] CR2: 00007fe433b2f088 CR3: 000000000344a000 CR4: 0000000=
000f52ef0
> <4> [212.361856] PKRU: 55555554
> <4> [212.361858] Call Trace:
> <4> [212.361859]  <TASK>
> <4> [212.361862]  ? lock_is_held_type+0xa3/0x130
> <4> [212.361868]  __schedule+0x103/0x1f70
> <4> [212.361870]  ? lock_acquire+0xc4/0x300
> <4> [212.361874]  ? find_held_lock+0x31/0x90
> <4> [212.361877]  ? schedule+0x10e/0x180
> <4> [212.361880]  ? lock_release+0xd0/0x2b0
> <4> [212.361885]  schedule+0x3a/0x180
> <4> [212.361888]  io_schedule+0x4c/0x80
> <4> [212.361890]  ? softleaf_entry_wait_on_locked+0x147/0x2b0
> <4> [212.361894]  softleaf_entry_wait_on_locked+0x24f/0x2b0
> <4> [212.361899]  ? __pfx_wake_page_function+0x10/0x10
> <4> [212.361904]  migration_entry_wait+0xff/0x190
> <4> [212.361909]  hmm_vma_handle_pte+0x440/0x790
> <4> [212.361914]  hmm_vma_walk_pmd+0x5c8/0x1360
> <4> [212.361918]  ? xe_pagefault_queue_work+0x1a9/0x520 [xe]
> <4> [212.362015]  walk_pgd_range+0x57f/0xd70
> <4> [212.362017]  ? lock_is_held_type+0xa3/0x130
> <4> [212.362028]  __walk_page_range+0x8e/0x290
> <4> [212.362034]  walk_page_range_mm_unsafe+0x19e/0x270
> <4> [212.362036]  ? trace_hardirqs_on+0x22/0xf0
> <4> [212.362043]  walk_page_range+0x2a/0x40
> <4> [212.362045]  hmm_range_fault+0x94/0x190
> <4> [212.362053]  drm_gpusvm_get_pages+0x269/0xa30 [drm_gpusvm_helper]
> <4> [212.362067]  drm_gpusvm_range_get_pages+0x2e/0x50 [drm_gpusvm_helper=
]
> <4> [212.362071]  __xe_svm_handle_pagefault+0x3e0/0xef0 [xe]
> <4> [212.362181]  ? __lock_acquire+0x43e/0x2790
> <4> [212.362188]  ? lock_is_held_type+0xa3/0x130
> <4> [212.362193]  ? lock_is_held_type+0xa3/0x130
> <4> [212.362197]  ? xe_vm_find_overlapping_vma+0x57/0x1e0 [xe]
> <4> [212.362304]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
> <4> [212.362412]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
> <4> [212.362509]  process_one_work+0x239/0x740
> <4> [212.362518]  worker_thread+0x200/0x3f0
> <4> [212.362521]  ? __pfx_worker_thread+0x10/0x10
> <4> [212.362524]  kthread+0x10d/0x150
> <4> [212.362527]  ? __pfx_kthread+0x10/0x10
> <4> [212.362530]  ret_from_fork+0x3bd/0x470
> <4> [212.362533]  ? __pfx_kthread+0x10/0x10
> <4> [212.362536]  ret_from_fork_asm+0x1a/0x30
> <4> [212.362546]  </TASK>
> <4> [212.362547] irq event stamp: 2057044
>
> I=E2=80=99ll be out this Thursday for five weeks, but assuming you can so=
rt this
> part out, I=E2=80=99m fine with the series moving forward. I=E2=80=99ve l=
ooked at this
> several times, and it seems sane enough to me.
>
> On our list we also have the Sashiko setup [2], which I=E2=80=99ve found =
to be
> incredibly helpful for series that do deep MM work. I=E2=80=99m not sure =
why
> Sashiko is saying this series didn=E2=80=99t apply, since it applied clea=
nly to
> our CI branches. If you can get Sashiko to run on it, that might be
> helpful as well.
>
> Matt

Yes there seemed to be a missing pte_unmap() before migration_entry_wait().=
.. fixed and sent v10.

--Mika


>
> [1] https://intel-gfx-ci.01.org/tree/intel-xe/xe-pw-165953v1/shard-bmg-4/=
igt@xe_exec_system_allocator@process-many-stride-mmap-race-nomemset.html
> [2] https://sashiko.dev/#/patchset/20260505051658.2219537-1-mpenttil%40re=
dhat.com
>
>

