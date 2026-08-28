Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F16C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF0FB10F26B;
	Fri, 28 Aug 2026 06:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="UvMznaB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cYnWkjF5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPpwMpe0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="34QDSGoG";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1702010F26C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:41:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 691462201D;
 Fri, 28 Aug 2026 06:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787899284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B3gF4iYIHVsjphby6wuvDuD0isK+Kz28/eGxa3pnhPA=;
 b=UvMznaB3AE7rrbNx9iaFV39/A3g8ZAqog54HT1a057s6NcFsrhU1xX6jRos3RWDparjHdR
 qN8b8FN97DNSpHZsT7xTgOPKXLcMG6NqC1sBw0OrzAQ4vJ6u9ABaYEUiizH7BS62QaPlwd
 /yGQZcg/pKUVYLMZ7PiPEDxklmypj4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787899284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B3gF4iYIHVsjphby6wuvDuD0isK+Kz28/eGxa3pnhPA=;
 b=cYnWkjF5tf/Eq24pep84hrsOfZmgaYaRkJcRCJa8sYOhUjFU/7Zfa2M2A0ITkbqkCyQzPG
 8j/9cP3pxOv2/zDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sPpwMpe0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=34QDSGoG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787899280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B3gF4iYIHVsjphby6wuvDuD0isK+Kz28/eGxa3pnhPA=;
 b=sPpwMpe0g/70vEXkp7S6B+BwarfhDfsWwlLmZFmBELFGsGZ2NSlCIbqd3AJdOFv6SNNaaE
 eddY+04oPs3W/Z/+PwXfwb4DtGpzzOJm+nKrpKjMXe2PNQkei8uThpBG7druqocZT/Qbf1
 qKZL2o+VgaGFYtlk3nmByu+ynx06H38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787899280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B3gF4iYIHVsjphby6wuvDuD0isK+Kz28/eGxa3pnhPA=;
 b=34QDSGoGLRBJaPFRVVWZlZOO3ts0es0e2YDVg8ADaAcgEcffFfjKimjNfd9avDJm6Wbs3Y
 QV3x+F3vVyBSOiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12FDE13675;
 Fri, 28 Aug 2026 06:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BltMA5AtkWrkUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 28 Aug 2026 06:41:20 +0000
Message-ID: <4e284baf-3805-48ad-87cb-73b17a2a3d67@suse.de>
Date: Fri, 28 Aug 2026 08:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] [dri?] WARNING in drm_mode_config_validate
To: syzbot <syzbot+901485725495f4729987@syzkaller.appspotmail.com>,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, rubenru09@aol.com,
 simona@ffwll.ch, syzkaller-bugs@googlegroups.com
References: <6a908732.1d9ded08.62e62.00d7.GAE@google.com>
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
In-Reply-To: <6a908732.1d9ded08.62e62.00d7.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 691462201D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[];
 URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9b0fc292fc5639c];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,lists.freedesktop.org,vger.kernel.org,linux.intel.com,kernel.org,aol.com,ffwll.ch,googlegroups.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[10]; REDIRECTOR_URL(0.00)[goo.gl];
 MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[901485725495f4729987];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SUBJECT_HAS_QUESTION(0.00)[]
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

Am 27.08.26 um 20:51 schrieb syzbot:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    45c13f3f9e3b Merge tag 'hwlock-v7.3' of git://git.kernel.o..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ad399e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9b0fc292fc5639c
> dashboard link: https://syzkaller.appspot.com/bug?extid=901485725495f4729987
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17af0579580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17639625580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ac6556827073/disk-45c13f3f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/01ff014f18d2/vmlinux-45c13f3f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/77e9c6302a14/bzImage-45c13f3f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+901485725495f4729987@syzkaller.appspotmail.com
>
> usb 4-1: config 1 interface 0 altsetting 0 bulk endpoint 0x1 has invalid maxpacket 0
> usb 4-1: config 1 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 2
> usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> ------------[ cut here ]------------
> [PLANE:35:plane-0] pixel format with alpha exposed but blend mode not setup
> WARNING: drivers/gpu/drm/drm_mode_config.c:872 at validate_blend_mode_for_alpha_formats drivers/gpu/drm/drm_mode_config.c:872 [inline], CPU#1: kworker/1:0/24
> WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0xfb4/0x1be0 drivers/gpu/drm/drm_mode_config.c:938, CPU#1: kworker/1:0/24

This comes from gud supporting ARGB8888 on it's primary plane.  But the 
driver does not know the hardware's blend mode without a change to the 
gud protocol.

I think the easiest solution is to drop support for ARGB from gud.

Best regards
Thomas

> Modules linked in:
> CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(lazy)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:validate_blend_mode_for_alpha_formats drivers/gpu/drm/drm_mode_config.c:872 [inline]
> RIP: 0010:drm_mode_config_validate+0xfbb/0x1be0 drivers/gpu/drm/drm_mode_config.c:938
> Code: 00 49 8b 57 18 48 89 f8 48 c1 e8 03 0f b6 04 28 84 c0 74 08 3c 03 0f 8e 00 0b 00 00 48 8d 3d fc 06 ce 07 41 8b b7 c8 00 00 00 <67> 48 0f b9 3a e9 fa fd ff ff 48 8b 5c 24 20 e8 31 3d 68 fe 48 8d
> RSP: 0018:ffffc9000019edd0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff888108692dc0 RSI: 0000000000000023 RDI: ffffffff8b1a99a0
> RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffed102175f9ca
> R13: ffffed102175f9cb R14: 0000000000000001 R15: ffff88810bafcd60
> FS:  0000000000000000(0000) GS:ffff8882684eb000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000000 CR3: 0000000119ed8000 CR4: 00000000003506f0
> Call Trace:
>   <TASK>
>   drm_dev_register+0x56e/0x7b0 drivers/gpu/drm/drm_drv.c:1077
>   gud_probe+0x17f4/0x1c20 drivers/gpu/drm/gud/gud_drv.c:646
>   usb_probe_interface+0x386/0x9b0 drivers/usb/core/driver.c:399
>   call_driver_probe drivers/base/dd.c:628 [inline]
>   really_probe+0x241/0xa60 drivers/base/dd.c:706
>   __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
>   driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
>   __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
>   bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
>   __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
>   device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
>   bus_probe_device+0x64/0x160 drivers/base/bus.c:620
>   device_add+0x121d/0x1970 drivers/base/core.c:3776
>   usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2268
>   usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
>   usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
>   call_driver_probe drivers/base/dd.c:628 [inline]
>   really_probe+0x241/0xa60 drivers/base/dd.c:706
>   __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
>   driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
>   __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
>   bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
>   __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
>   device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
>   bus_probe_device+0x64/0x160 drivers/base/bus.c:620
>   device_add+0x121d/0x1970 drivers/base/core.c:3776
>   usb_new_device.part.0+0xcc2/0x1686 drivers/usb/core/hub.c:2708
>   usb_new_device drivers/usb/core/hub.c:5833 [inline]
>   hub_port_connect drivers/usb/core/hub.c:5580 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
>   port_event drivers/usb/core/hub.c:5884 [inline]
>   hub_event.cold+0x51a/0xe9d drivers/usb/core/hub.c:5966
>   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
>   process_scheduled_works kernel/workqueue.c:3470 [inline]
>   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
>   kthread+0x373/0x450 kernel/kthread.c:436
>   ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> ----------------
> Code disassembly (best guess):
>     0:	00 49 8b             	add    %cl,-0x75(%rcx)
>     3:	57                   	push   %rdi
>     4:	18 48 89             	sbb    %cl,-0x77(%rax)
>     7:	f8                   	clc
>     8:	48 c1 e8 03          	shr    $0x3,%rax
>     c:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax
>    10:	84 c0                	test   %al,%al
>    12:	74 08                	je     0x1c
>    14:	3c 03                	cmp    $0x3,%al
>    16:	0f 8e 00 0b 00 00    	jle    0xb1c
>    1c:	48 8d 3d fc 06 ce 07 	lea    0x7ce06fc(%rip),%rdi        # 0x7ce071f
>    23:	41 8b b7 c8 00 00 00 	mov    0xc8(%r15),%esi
> * 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
>    2f:	e9 fa fd ff ff       	jmp    0xfffffe2e
>    34:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
>    39:	e8 31 3d 68 fe       	call   0xfe683d6f
>    3e:	48                   	rex.W
>    3f:	8d                   	.byte 0x8d
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


