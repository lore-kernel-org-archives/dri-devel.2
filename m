Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE756C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFF910EC0B;
	Mon, 14 Sep 2026 08:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="jmRIjMVd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QpoC+eJo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTQCctNi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k4IzUrIN";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10E210EC0B
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:43:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3985F21999;
 Mon, 14 Sep 2026 08:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789375407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNzA19kIXHEuude39NsbbW5ax6APsTMzeGpgSANfn4c=;
 b=jmRIjMVd1qri01KsbGJDuGd14QySeH/L2j77NQJ9F952dppFF/49KxRLxkkRa6yZNpny+f
 dWjrDNUS7IyJGwK6qp1pFMpiWWUoha03h5K++1zg81MZDwgbik7AmtIbGkHZckaKtAG3Em
 OZVXHvrc0FLVN6rGORcfkM9es0UwBNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789375407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNzA19kIXHEuude39NsbbW5ax6APsTMzeGpgSANfn4c=;
 b=QpoC+eJojzWI5MRZBxFcy/j1wK0SV7BNP4/0f8RXcTUU7tPgIJZHeFXV676b6+8oRurWyA
 VRejQE9o1E4V8cDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZTQCctNi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k4IzUrIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789375403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNzA19kIXHEuude39NsbbW5ax6APsTMzeGpgSANfn4c=;
 b=ZTQCctNiazHDZVjkvDv7fhqkypc3I1y+h/+r/BC1A0gubyeXyjRYbT2JP1hOIa/uY6YjS1
 RP3RTDC8j8b5FNolgbSDOTFXMPl07WwJbL9m9UgWlW/XHiBUzFS7impmPfKqNk41nMY7Bu
 4EcgGdZ+/nqg1FHDF4FaEy94hNGkKlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789375403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNzA19kIXHEuude39NsbbW5ax6APsTMzeGpgSANfn4c=;
 b=k4IzUrINRQtTtJv62W9i588IhUbjg+8aKdyhaVH0vHFFqLmGZaYpMhIFzOxhuph8lh4HwX
 M1Iop+2ewwFjSHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F05681368C;
 Mon, 14 Sep 2026 08:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dCFgOaqzp2rJJAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 14 Sep 2026 08:43:22 +0000
Message-ID: <1f383114-e367-4b67-899b-14a393fece94@suse.de>
Date: Mon, 14 Sep 2026 10:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
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
In-Reply-To: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3985F21999
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fabiopiparo.com:url,bootlin.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

Am 13.08.26 um 06:27 schrieb Fabio Piparo:
> The symptom
> ===========
>
> I am working with a Raspberry Pi 5 driving a 128x32 SSD1306 over I2C
> through ssd130x, brought up with dtoverlay=ssd1306, and a GLES client
> rendering into it. The GPU renders straight into the panel's framebuffer.
> The panel shows a blocky pattern that is affected by CPU load. The kernel
> is 6.18.39.
>
> A capture:
>
>    https://files.fabiopiparo.com/ssd130-line-glitch.webp
>
> This is a simple trail traveling left to right, and the busier the Pi is,
> the shorter the trail (link above). On an idle machine the leftovers build
> up into a blocky fog. That was the clue that pointed me at the CPU cache,
> since the lifetime of the artifact tracks memory pressure.
>
> The trace
> =========
>
> I made a test program that flips between two alternating solid frames
> while i2c_write payloads are traced. 15 of the 31 flushes carry bytes
> from both frames in one payload, mixed at 64 byte granularity.

I assume you write these frames quickly one after the other? As i2c is 
really slow, you might write to buffers that are still being transferred 
in the background.

Do you read back the status of the page flips? DRM should tell you when 
it has completed transferring a frame. See [1]

[1] 
https://elixir.bootlin.com/linux/v7.2.5/source/drivers/gpu/drm/drm_file.c#L85

Best regards
Thomas


>
> What appears to happen
> ======================
>
> My reading: the driver's XRGB conversion reads the framebuffer through a
> cached mapping while the GPU writes the same memory directly, so what
> reaches the panel is whatever lines the CPU still holds. The 64 byte
> granularity and the load dependence both fit that, and write-combining
> the mapping makes it stop.
>
> What stops it
> =============
>
> Setting shmem->map_wc in a .gem_create_object hook makes all the traced
> payloads come out as expected.
>
> Whether the exporter is the right place for this, I do not know.
>
> I am happy to test anything on this hardware and report back.
>
> Disclosure
> ==========
>
> The panel, the symptom and the i2c trace come from my own hardware. The
> analysis above and the change came out of a long debugging session with
> an AI assistant.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


