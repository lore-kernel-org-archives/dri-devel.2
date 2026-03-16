Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C643F013F5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430B110E130;
	Mon, 16 Mar 2026 09:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="P5AXSQNg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dZ21jLKk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JKfdmvDB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+mRN/9Oz";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC2710E130
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:14:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA75E4D202;
 Mon, 16 Mar 2026 09:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773652465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w5KCBPqD081N8TfZVfbYED0aaQMeoJhOd+mhW7Mw2l0=;
 b=P5AXSQNg9lsSTVMJwS4y1FXEPePcwtshbx5eeXbXUSUTWYlu+he1euLNPWKT0l3VYjzOuj
 lQLATieH9hVVR+xHB3t3csIzUpi2PAlb5WVaZYizxTa+3/a406aIvbpJ5yNOrBaLdnW1Sn
 wLaiUqX6rSJo9zvZZUCiqpDrNK+aAp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773652465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w5KCBPqD081N8TfZVfbYED0aaQMeoJhOd+mhW7Mw2l0=;
 b=dZ21jLKkhqssqSKNpWx6mNeWTlPoQ7BP+/hspb4VE2T1D1BBEpKB3A48Vbu3BDtrm8hbwL
 NQImeGPHwRHyOzDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773652464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w5KCBPqD081N8TfZVfbYED0aaQMeoJhOd+mhW7Mw2l0=;
 b=JKfdmvDBPvR/MbnSPv1VU4BwqRRg54u4dDWsCsdCvlRiO2HDi8WNeSoNApiAo866eA5FFn
 ertbm2/czsbpl3PlJXt05TCofLxjXwmKJ5aXKk5aKwMK0Gb4JVYzYg+bFl/X2y/Dv9Ef0U
 33Ghme+QWqyz7kHYoqoumMUZXy1Zj80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773652464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w5KCBPqD081N8TfZVfbYED0aaQMeoJhOd+mhW7Mw2l0=;
 b=+mRN/9Oz6Capx8Nopfcw0d7ch9Xziifj7eRc1FMJ845DntiSE24se/7S9PClk7KBF2ZC1m
 LEZFzhI6HrVjPCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E38B4273B;
 Mon, 16 Mar 2026 09:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PxC5GfDJt2lADgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 09:14:24 +0000
Message-ID: <004c48cb-196a-4aac-bfc4-c440c9fd74d2@suse.de>
Date: Mon, 16 Mar 2026 10:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260316002649.211819-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch,collabora.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
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

Hi

Am 16.03.26 um 01:26 schrieb Pedro Demarchi Gomes:
> When running ./tools/testing/selftests/mm/split_huge_page_test multiple
> times with /sys/kernel/mm/transparent_hugepage/shmem_enabled and
> /sys/kernel/mm/transparent_hugepage/enabled set as always the following BUG
> occurs:
>
> [  232.728858] ------------[ cut here ]------------
> [  232.729458] kernel BUG at mm/memory.c:2276!
> [  232.729726] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [  232.730217] CPU: 19 UID: 60578 PID: 1497 Comm: llvmpipe-9 Not tainted 7.0.0-rc1mm-new+ #19 PREEMPT(lazy)
> [  232.730855] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
> [  232.731360] RIP: 0010:walk_to_pmd+0x29e/0x3c0
> [  232.731569] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
> [  232.732614] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
> [  232.732991] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
> [  232.733362] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
> [  232.733801] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
> [  232.734168] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
> [  232.734459] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
> [  232.734861] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
> [  232.735265] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  232.735548] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
> [  232.736031] Call Trace:
> [  232.736273]  <TASK>
> [  232.736500]  get_locked_pte+0x1f/0xa0
> [  232.736878]  insert_pfn+0x9f/0x350
> [  232.737190]  ? __pfx_pat_pagerange_is_ram+0x10/0x10
> [  232.737614]  ? __pfx_insert_pfn+0x10/0x10
> [  232.737990]  ? __pfx_css_rstat_updated+0x10/0x10
> [  232.738281]  ? __pfx_pfn_modify_allowed+0x10/0x10
> [  232.738552]  ? lookup_memtype+0x62/0x180
> [  232.738761]  vmf_insert_pfn_prot+0x14b/0x340
> [  232.739012]  ? __pfx_vmf_insert_pfn_prot+0x10/0x10
> [  232.739247]  ? __pfx___might_resched+0x10/0x10
> [  232.739475]  drm_gem_shmem_fault.cold+0x18/0x39
> [  232.739677]  ? rcu_read_unlock+0x20/0x70
> [  232.739882]  __do_fault+0x251/0x7b0
> [  232.740028]  do_fault+0x6e1/0xc00
> [  232.740167]  ? __lock_acquire+0x590/0xc40
> [  232.740335]  handle_pte_fault+0x439/0x760
> [  232.740498]  ? mtree_range_walk+0x252/0xae0
> [  232.740669]  ? __pfx_handle_pte_fault+0x10/0x10
> [  232.740899]  __handle_mm_fault+0xa02/0xf30
> [  232.741066]  ? __pfx___handle_mm_fault+0x10/0x10
> [  232.741255]  ? find_vma+0xa1/0x120
> [  232.741403]  handle_mm_fault+0x2bf/0x8f0
> [  232.741564]  do_user_addr_fault+0x2d3/0xed0
> [  232.741736]  ? trace_page_fault_user+0x1bf/0x240
> [  232.741969]  exc_page_fault+0x87/0x120
> [  232.742124]  asm_exc_page_fault+0x26/0x30
> [  232.742288] RIP: 0033:0x7fb4d73ed546
> [  232.742441] Code: 66 41 0f 6f fb 66 44 0f 6d dc 66 44 0f 6f c6 66 41 0f 6d f1 66 0f 6c fc 66 45 0f 6c c1 66 44 0f 6f c9 66 0f 6d ca 66 0f db f0 <66> 0f df 04 08 66 44 0f 6c ca 66 45 0f db c2 66 44 0f df 10 66 44
> [  232.743193] RSP: 002b:00007fb4907f68a0 EFLAGS: 00010206
> [  232.743565] RAX: 00007fb47840aa00 RBX: 00007fb4d73ec070 RCX: 0000000000001400
> [  232.743871] RDX: 0000000000002800 RSI: 0000000000003c00 RDI: 0000000000000001
> [  232.744150] RBP: 0000000000000004 R08: 0000000000001400 R09: 00007fb4d73ec060
> [  232.744433] R10: 000055f0261a4288 R11: 00007fb4c013da40 R12: 0000000000000008
> [  232.744712] R13: 0000000000000000 R14: 4332322132212110 R15: 0000000000000004
> [  232.746616]  </TASK>
> [  232.746711] Modules linked in: nft_nat nft_masq veth bridge stp llc snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore overlay rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr ppdev 9pnet_virtio 9pnet parport_pc i2c_piix4 netfs pcspkr parport i2c_smbus joydev sunrpc vfat fat loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport zram lz4hc_compress vmw_vmci lz4_compress vsock e1000 bochs serio_raw ata_generic pata_acpi scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse qemu_fw_cfg
> [  232.749308] ---[ end trace 0000000000000000 ]---
> [  232.749507] RIP: 0010:walk_to_pmd+0x29e/0x3c0
> [  232.749692] Code: d8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 89 ea 48 89 de 4c 89 f7 e8 ae 85 ff ff 85 c0 0f 84 1f fe ff ff 31 db eb d0 <0f> 0b 48 89 ea 48 89 de 4c 89 f7 e8 92 8b ff ff 85 c0 75 e8 48 b8
> [  232.750428] RSP: 0000:ffff8881aa6ff9a8 EFLAGS: 00010282
> [  232.750645] RAX: 8000000142e002e7 RBX: ffff8881433cae10 RCX: dffffc0000000000
> [  232.750954] RDX: 0000000000000000 RSI: 00007fb47840b000 RDI: 8000000142e002e7
> [  232.751232] RBP: 00007fb47840b000 R08: 0000000000000000 R09: 1ffff110354dff46
> [  232.751514] R10: fffffbfff0cb921d R11: 00000000910da5ce R12: 1ffffffff0c1fcdd
> [  232.751837] R13: 1ffffffff0c23f36 R14: ffff888171628040 R15: 0000000000000000
> [  232.752124] FS:  00007fb4907f86c0(0000) GS:ffff888791f2c000(0000) knlGS:0000000000000000
> [  232.752441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  232.752674] CR2: 00007fb47840be00 CR3: 000000015e6dc000 CR4: 00000000000006f0
> [  232.752983] Kernel panic - not syncing: Fatal exception
> [  232.753510] Kernel Offset: disabled
> [  232.754643] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> This happens when two concurrent page faults occur within the same PMD range.
> One fault installs a PMD mapping through vmf_insert_pfn_pmd(), while the other
> attempts to install a PTE mapping via vmf_insert_pfn(). The bug is
> triggered because a pmd_trans_huge is not expected when walking the page
> table inside vmf_insert_pfn.
>
> Avoid this race by adding a huge_fault callback to drm_gem_shmem_vm_ops so that
> PMD-sized mappings are handled through the appropriate huge page fault path.
>
> Fixes: 211b9a39f261 ("drm/shmem-helper: Map huge pages in fault handler")
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>
> Changes in v3:
>   - Pass a try_pmd boolean parameter to drm_gem_shmem_any_fault
>   - Compile drm_gem_shmem_huge_fault only if CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> is defined to avoid a build warning
>
> Changes in v2: https://lore.kernel.org/dri-devel/20260313141719.3949700-1-pedrodemargomes@gmail.com/
>   - Keep the #ifdef unindented
>   - Create drm_gem_shmem_any_fault to handle faults of any order and use
> drm_gem_shmem_[huge_]fault() as wrappers
>
> v1: https://lore.kernel.org/all/20260312155027.1682606-1-pedrodemargomes@gmail.com/
>
> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 63 ++++++++++++++------------
>   1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 7b5a49935ae4..9428c3ab7283 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -550,36 +550,18 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>
> -static bool drm_gem_shmem_try_map_pmd(struct vm_fault *vmf, unsigned long addr,
> -				      struct page *page)
> -{
> -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long paddr = pfn << PAGE_SHIFT;
> -	bool aligned = (addr & ~PMD_MASK) == (paddr & ~PMD_MASK);
> -
> -	if (aligned &&
> -	    pmd_none(*vmf->pmd) &&
> -	    folio_test_pmd_mappable(page_folio(page))) {
> -		pfn &= PMD_MASK >> PAGE_SHIFT;
> -		if (vmf_insert_pfn_pmd(vmf, pfn, false) == VM_FAULT_NOPAGE)
> -			return true;
> -	}
> -#endif
> -
> -	return false;
> -}
> -
> -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> +static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, bool try_pmd)

Please write two functions. One for huge pages and one for regular page 
faults.

Best regards
Thomas

>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct drm_gem_object *obj = vma->vm_private_data;
>   	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>   	loff_t num_pages = obj->size >> PAGE_SHIFT;
> -	vm_fault_t ret;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
>   	struct page **pages = shmem->pages;
>   	pgoff_t page_offset;
>   	unsigned long pfn;
> +	unsigned long paddr;
> +	bool aligned;
>
>   	/* Offset to faulty address in the VMA. */
>   	page_offset = vmf->pgoff - vma->vm_pgoff;
> @@ -593,13 +575,19 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>   		goto out;
>   	}
>
> -	if (drm_gem_shmem_try_map_pmd(vmf, vmf->address, pages[page_offset])) {
> -		ret = VM_FAULT_NOPAGE;
> -		goto out;
> -	}
> -
>   	pfn = page_to_pfn(pages[page_offset]);
> -	ret = vmf_insert_pfn(vma, vmf->address, pfn);
> +	if (try_pmd) {
> +		paddr = pfn << PAGE_SHIFT;
> +		aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
> +
> +		if (aligned &&
> +		    folio_test_pmd_mappable(page_folio(pages[page_offset]))) {
> +			pfn &= PMD_MASK >> PAGE_SHIFT;
> +			ret = vmf_insert_pfn_pmd(vmf, pfn, false);
> +		}
> +	} else {
> +		ret = vmf_insert_pfn(vma, vmf->address, pfn);
> +	}
>
>    out:
>   	dma_resv_unlock(shmem->base.resv);
> @@ -607,6 +595,22 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>   	return ret;
>   }
>
> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> +static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
> +					   unsigned int order)
> +{
> +	if (order != PMD_ORDER)
> +		return VM_FAULT_FALLBACK;
> +
> +	return drm_gem_shmem_any_fault(vmf, true);
> +}
> +#endif
> +
> +static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> +{
> +	return drm_gem_shmem_any_fault(vmf, false);
> +}
> +
>   static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
>   {
>   	struct drm_gem_object *obj = vma->vm_private_data;
> @@ -643,6 +647,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>
>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>   	.fault = drm_gem_shmem_fault,
> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> +	.huge_fault = drm_gem_shmem_huge_fault,
> +#endif
>   	.open = drm_gem_shmem_vm_open,
>   	.close = drm_gem_shmem_vm_close,
>   };
> --
> 2.47.3
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


