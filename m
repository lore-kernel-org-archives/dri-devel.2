Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC857F9934D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A6710E318;
	Thu, 23 Apr 2026 07:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="FvilL6Rs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UpTpYbZp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TPneCo5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7ZsrRtzZ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5253310E30F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:44:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E38066A7E7;
 Thu, 23 Apr 2026 07:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776930275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6UdeIUNFSFDQwPm8VkVv1eo2Hua9oSVDrlzTA3TdpHA=;
 b=FvilL6RsYoazTN7bCuPbl46a45AGbMj2eJR6aPOvgHfqTh4MW2WFCwJYrH6GObqxlpBxA4
 uljuIymC61Vt2qiz+vbZJ6OdKMqmyYy/N575wqDbIywAUOxH70jjHXnEd4v+w95S+eDnoY
 NSEQMWRWV4YhcTo7FBneuPGZNNS0V4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776930275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6UdeIUNFSFDQwPm8VkVv1eo2Hua9oSVDrlzTA3TdpHA=;
 b=UpTpYbZpcMIc8sSpDS/ZGQki0u/YkXzGG92sMSaTCd43issbN2MoYLHs5iRVB9NqpcAYiR
 iQZS/T9FJbYxOfAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776930274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6UdeIUNFSFDQwPm8VkVv1eo2Hua9oSVDrlzTA3TdpHA=;
 b=TPneCo5JIJv+SYT02IMnlgjP8DWBlmDRkuDWZrE1EqncfKkRoyUpV+k0jAbaOG39Svysml
 I3WlAJzZlCBOpoqtPVWVQDMkRh6vFy/aQkkL3KDhW5X6PKFYwjJemjuxkdhcNz52vl5vMp
 Z6vjpwz2TdihrqsAOQjH28rS3kZjjLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776930274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6UdeIUNFSFDQwPm8VkVv1eo2Hua9oSVDrlzTA3TdpHA=;
 b=7ZsrRtzZtq18C103hlkrFzcgHtD9M7eZrNSVAxXdir7N5L9yCrpih8NEXfErNgaJrEVwA5
 us0loUv0PndfRMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADD06593A3;
 Thu, 23 Apr 2026 07:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HH6KOLN6Wk5RgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 07:44:34 +0000
Message-ID: <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
Date: Thu, 23 Apr 2026 09:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Jacob Keller <jacob.e.keller@intel.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
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
In-Reply-To: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
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

Am 23.04.26 um 01:55 schrieb Jacob Keller:
> Hello,
>
> You may recall the issues I recently reported and submitted a fix for in
> the mgag200 DRM driver from [1].
>
> [1]:
> https://lore.kernel.org/all/20260202-jk-mgag200-fix-bad-udelay-v2-1-ce1e9665987d@intel.com/
>
> I recently have been running into another issue with the mgag200
> graphics driver on a similar platform. I noticed occasional spikes where
> Tx timestamps from the ice driver were delayed, very similar behavior to
> what was going on with the original bug report. However, this was on a
> system running v6.12.76, which contains my MGA G200 usleep fix.
>
> I analyzed the data with perf and have discovered what looks like
> another issue where the mgag200 polling routine is causing us issues.
>
> Here's a perf report which captures the cycles samples between the start
> of a Tx timestamp request and the point where we report it to the stack:
>
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] ret_from_fork_asm
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] ret_from_fork
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] kthread
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] worker_thread
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] process_one_work
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] output_poll_execute
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_client_dev_hotplug
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_fbdev_shmem_client_hotplug
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_fb_helper_hotplug_event
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_client_modeset_probe
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_helper_probe_single_connector_modes
>> +   89.87%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_vga_bmc_connector_helper_get_modes
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_connector_helper_get_modes
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_edid_read
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_edid_read_custom
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] _drm_do_get_edid
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] edid_block_read
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] drm_do_probe_ddc_edid
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] i2c_transfer
>> +   89.87%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __i2c_transfer
>> +   89.87%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] bit_xfer
>> -   59.65%    59.65%  kworker/65:1-ev  [kernel.kallsyms]         [k] delay_halt_tpause
>>       ret_from_fork_asm
>>       ret_from_fork
>>       kthread
>>       worker_thread
>>       process_one_work
>>       output_poll_execute
>>       drm_client_dev_hotplug
>>       drm_fbdev_shmem_client_hotplug
>>       drm_fb_helper_hotplug_event
>>       drm_client_modeset_probe
>>       drm_helper_probe_single_connector_modes
>>       mgag200_vga_bmc_connector_helper_get_modes
>>       drm_connector_helper_get_modes
>>       drm_edid_read
>>       drm_edid_read_custom
>>       _drm_do_get_edid
>>       edid_block_read
>>       drm_do_probe_ddc_edid
>>       i2c_transfer
>>       __i2c_transfer
>>     + bit_xfer
>> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __udelay
>> +   59.65%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] __const_udelay
>> +   51.11%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] sclhi
>> +   30.22%    30.22%  kworker/65:1-ev  [kernel.kallsyms]         [k] ioread8
>> +    7.30%     0.00%  kworker/65:1-ev  [kernel.kallsyms]         [k] delay_halt
>> +    7.30%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] acknak
>> +    7.29%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_ddc_algo_bit_data_setscl
>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] secondary_startup_64
>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] start_secondary
>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] cpu_startup_entry
>> +    5.02%     0.00%  swapper          [kernel.kallsyms]         [k] do_idle
>> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k] call_cpuidle
>> +    3.60%     0.00%  swapper          [kernel.kallsyms]         [k] cpuidle_enter
>> +    3.53%     0.00%  swapper          [kernel.kallsyms]         [k] cpuidle_enter_state
>> +    2.57%     0.00%  kworker/65:1-ev  [mgag200]                 [k] mgag200_ddc_algo_bit_data_setsda
>> +    2.14%     0.00%  perf             [unknown]                 [k] 0xffffffffffffffff
>> +    2.14%     0.00%  perf             perf                      [.] __cmd_record.constprop.0
>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] entry_SYSCALL_64
>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] do_syscall_64
>> +    2.14%     0.00%  perf             [kernel.kallsyms]         [k] x64_sys_call
>> +    2.06%     2.06%  swapper          [kernel.kallsyms]         [k] intel_idle
>> +    1.31%     0.42%  perf             [kernel.kallsyms]         [k] do_sys_poll
>> +    1.31%     0.00%  perf             perf                      [.] fdarray__poll
>> +    1.31%     0.00%  perf             libc.so.6                 [.] __poll
>> +    1.31%     0.00%  perf             [kernel.kallsyms]         [k] __x64_sys_poll
>> +    1.06%     0.00%  systemd-journal  systemd-journald          [.] 0x00005d6bb7cb3f64
>> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.] __libc_start_main
>> +    1.06%     0.00%  systemd-journal  libc.so.6                 [.] 0x00007d6ce3a2a1c9
>> +    1.06%     0.00%  systemd-journal  systemd-journald          [.] 0x00005d6bb7cb389e
>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] sd_event_run
>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] sd_event_dispatch
>> +    1.06%     0.00%  systemd-journal  libsystemd-shared-255.so  [.] 0x00007d6ce409d413
>> +    1.00%     0.00%  kworker/65:1-ev  [i2c_algo_bit]            [k] i2c_stop
>> +    0.83%     0.00%  perf             [kernel.kallsyms]         [k] perf_poll
>> +    0.83%     0.00%  perf             perf                      [.] record__mmap_read_evlist
>>
> As you can see, in this case we are spending +60% of the cycles in
> delay_halt_tpause which is part of the bit_xfer function for
> implementing i2c.

That's from the DDC's i2c channel, which we poll on regular intervals 
when we update the connector status. Dave's suggestion should at least 
mitigate the problem.

>
> I also occasionally see these messages coming on dmesg:
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:44 1762811 kernel: workqueue: work_for_cpu_fn hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
>> Apr 20 23:14:45 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
>> Apr 20 23:15:15 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>> Apr 20 23:15:25 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
>> Apr 20 23:15:46 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:27 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 5 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 7 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 11 times, consider switching to WQ_UNBOUND
>> Apr 20 23:16:45 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
>> Apr 20 23:17:49 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 19 times, consider switching to WQ_UNBOUND
>> Apr 20 23:20:33 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
>> Apr 20 23:26:00 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
>> Apr 20 23:36:56 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
>> Apr 20 23:58:46 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
>> Apr 21 00:34:27 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 515 times, consider switching to WQ_UNBOUND
>> Apr 21 00:42:28 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 515 times, consider switching to WQ_UNBOUND
>> Apr 21 02:09:51 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 1027 times, consider switching to WQ_UNBOUND
>> Apr 21 03:27:40 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 1027 times, consider switching to WQ_UNBOUND
>> Apr 21 05:04:37 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 2051 times, consider switching to WQ_UNBOUND
>> Apr 21 08:09:39 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 35 times, consider switching to WQ_UNBOUND
>> Apr 21 08:10:07 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 67 times, consider switching to WQ_UNBOUND
>> Apr 21 08:10:10 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 131 times, consider switching to WQ_UNBOUND
>> Apr 21 08:10:21 1762811 kernel: workqueue: vmstat_update hogged CPU for >10000us 259 times, consider switching to WQ_UNBOUND
>> Apr 21 09:14:18 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 2051 times, consider switching to WQ_UNBOUND
>> Apr 21 10:54:08 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 4099 times, consider switching to WQ_UNBOUND
>> Apr 21 21:11:47 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4099 times, consider switching to WQ_UNBOUND
>> Apr 21 22:33:11 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 8195 times, consider switching to WQ_UNBOUND
>> Apr 22 20:31:04 1762811 kernel: workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 8195 times, consider switching to WQ_UNBOUND
>> Apr 22 21:51:17 1762811 kernel: workqueue: output_poll_execute hogged CPU for >10000us 16387 times, consider switching to WQ_UNBOUND
> These all appear to be workqueue warnings about functions that are
> hogging CPU. If I look carefully, it looks like they are all possibly
> related to the same mgag200 driver. At the very least
> output_poll_execute is certainly related to the mgag200 stall.

Polling the DDC involves acquiring locks so that it does not interfere 
with display updates. These errors about drm_fb_helper_damage_work() are 
fallout. The function most likely waits for the DDC polling to finish.
>
> I do noot understand exactly what is causing the driver to get stuck,
> its something in the i2c routine for reading the EDID block.
>
> I also see this being printed:
>
>   EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
>
> It appears to print quite consistently every few seconds. I guess this
> might be possibly related to a bad EDID block on the mgag200 device?
> What does this even mean?

The monitor's EDID is wrong. This is likely another fallout from the issue.

>
> I am not sure how I'd go about verifying this, or root causing what is
> going wrong.
>
> It looks like we print the message as part of _drm_do_get_edid(), and
> this definitely is called as part of the mgag200 routines:
>
>> -   33.33%    33.33%  kworker/64:1-ev  [kernel.kallsyms]  [k] _drm_do_get_edid
>>       ret_from_fork_asm
>>       ret_from_fork
>>       kthread
>>       worker_thread
>>       process_one_work
>>       output_poll_execute
>>       drm_client_dev_hotplug
>>       drm_fbdev_shmem_client_hotplug
>>       drm_fb_helper_hotplug_event
>>       drm_client_modeset_probe
>>       drm_helper_probe_single_connector_modes
>>       mgag200_vga_bmc_connector_helper_get_modes
>>       drm_connector_helper_get_modes
>>       drm_edid_read
>>       drm_edid_read_custom
>>       _drm_do_get_edid
> This makes me think that we're reading a bad EDID. I enabled drm.debug
> setting to get more data:
>
>> Apr 22 23:47:11 1762811 kernel: EDID block 0 (tag 0x00) checksum is invalid, remainder is 125
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:connector_bad_edid] [CONNECTOR:36:VGA-1] EDID is invalid:
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  00 ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> Apr 22 23:47:11 1762811 kernel:         [00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

This EDID has a correct identifier in the first 8 bytes and the rest is 
garbage.

>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x720": 60 74250 1280 1390 1430 1650 720 725 730 750 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 68250 1280 1328 1360 1440 768 771 778 790 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x768": 60 79500 1280 1344 1472 1664 768 771 778 798 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 71000 1280 1328 1360 1440 800 803 809 823 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x800": 60 83500 1280 1352 1480 1680 800 803 809 831 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x960": 60 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1360x768": 60 85500 1360 1424 1536 1792 768 771 777 795 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 85500 1366 1436 1579 1792 768 771 774 798 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1366x768": 60 72000 1366 1380 1436 1500 768 769 772 800 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1400x1050": 60 121750 1400 1488 1632 1864 1050 1053 1057 1089 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 88750 1440 1488 1520 1600 900 903 909 926 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1440x900": 60 106500 1440 1520 1672 1904 900 903 909 934 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x900": 60 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1600x1200": 60 162000 1600 1664 1856 2160 1200 1201 1204 1250 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1680x1050": 60 146250 1680 1784 1960 2240 1050 1053 1059 1089 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1792x1344": 60 204750 1792 1920 2120 2448 1344 1345 1348 1394 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1856x1392": 60 218250 1856 1952 2176 2528 1392 1393 1396 1439 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1080": 60 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 154000 1920 1968 2000 2080 1200 1203 1209 1235 0x40 0x9 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1200": 60 193250 1920 2056 2256 2592 1200 1203 1209 1245 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "1920x1440": 60 234000 1920 2048 2256 2600 1440 1441 1444 1500 0x40 0x6 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_mode_prune_invalid] Rejected mode: "2048x1152": 60 162000 2048 2074 2154 2250 1152 1153 1156 1200 0x40 0x5 (VIRTUAL_X)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] [CONNECTOR:36:VGA-1] probed modes:
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "1024x768": 60 65000 1024 1048 1184 1344 768 771 777 806 0x48 0xa
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 60 40000 800 840 968 1056 600 601 605 628 0x40 0x5
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "800x600": 56 36000 800 824 896 1024 600 601 603 625 0x40 0x5
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "848x480": 60 33750 848 864 976 1088 480 486 494 517 0x40 0x5
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_helper_probe_single_connector_modes] Probed mode: "640x480": 60 25175 640 656 752 800 480 490 492 525 0x40 0xa
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] enabled? yes
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] Not using firmware configuration
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for cmdline mode
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] looking for preferred mode, tile 0
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CONNECTOR:36:VGA-1] Found mode 1024x768
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] picking CRTCs for 1024x768 config
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_modeset_probe] [CRTC:34:crtc-0] desired mode 1024x768 set (0,0)
>> Apr 22 23:47:11 1762811 kernel: mgag200 0000:b5:00.0: [drm:drm_client_dev_hotplug] fbdev: ret=0
> Does anyone have any idea whats going wrong here? A google search seems
> to imply this is reading the EDID data from the VGA cable...

The HW is probably broken.

>
> I'm also curious if its possible to stop polling for so long with udelay
> in the i2c logic somehow? I am not very familiar with i2c, but it is
> frustrating that this driver is causing yet another stall that is
> impacting timing sensitive data. Even if in this case its due to a
> faulty cable.. it is frustrating that such result causes the PTP
> failures. Would switching to WQ_UNBOUND be helpful here at all?

Try Dave's suggestion to avoid polling.  The driver won't be able to 
detect changes to the connector status, though.

Best regards
Thomas

>
> Thanks,
> Jake

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


