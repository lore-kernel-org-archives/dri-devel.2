Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6EEC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CBD10EFA0;
	Wed,  9 Sep 2026 08:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="j27fhShv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rAiVPu6p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHZ+68w/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="litFSRiF";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4BE10EF9C;
 Wed,  9 Sep 2026 08:01:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5308A1F7AF;
 Wed,  9 Sep 2026 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788940890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+w6mHfMv7ALo2DRy+HOaCZ0lsuSiiOBsrZzxBKyKAw=;
 b=j27fhShvgAohUMfs8OwK3hesxgv/nJpbEf9u4Dft7c0wKiycToXgr9AIDoMlyWmtWUbgAS
 Jk+v1GMSDpWx37aCG/ErjIHWvomw2tV7yNGLhAjJsrq3ZKwfYYqrDuyzHTKNQWmGy+fIHq
 lbWU1e0uL7cHZNEV97HBn4xZuwBfGG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788940890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+w6mHfMv7ALo2DRy+HOaCZ0lsuSiiOBsrZzxBKyKAw=;
 b=rAiVPu6plSd7Zy67NELRDMXUGW0kJsTVWUJW3ENJPX86AYoZTcnnVZSj64aggPNahKAgy6
 E+riASYvOlIpCfCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tHZ+68w/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=litFSRiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788940885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+w6mHfMv7ALo2DRy+HOaCZ0lsuSiiOBsrZzxBKyKAw=;
 b=tHZ+68w/PpQ5aX2RKeT7BtD2CGvGXPZspFfjx24b2gWaEmmGb5/bPv+y08J7pK+EB+vZmF
 uoLmfM8ovodRWFHtQriMjSnLAEO5YeV2DXxCyNP1HR5wfKuxKe+v7HxVi9mKzy9iUa0GtK
 MwaJhDA+vLpw/gsZA1xpndzhXiu7bjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788940885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V+w6mHfMv7ALo2DRy+HOaCZ0lsuSiiOBsrZzxBKyKAw=;
 b=litFSRiFgfgWm4xB9HTHLoC46sB3724Rigpz/RTt8nF2O+/Nh1v2Q+Qlxkocu28Lt149UU
 dTGYYKQHPaPB7/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDA121352C;
 Wed,  9 Sep 2026 08:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JEkJLVQSoWqzGQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:01:24 +0000
Message-ID: <2642740a-b894-47bd-b26e-cabdaa14d8b8@suse.de>
Date: Wed, 9 Sep 2026 10:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
To: Klara Modin <klarasmodin@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Thorsten Leemhuis <linux@leemhuis.info>,
 Manuel Ebner <manuelebner@mailbox.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260908175427.47207-1-klarasmodin@gmail.com>
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
In-Reply-To: <20260908175427.47207-1-klarasmodin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5308A1F7AF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,kernel.org,google.com];
 RCPT_COUNT_TWELVE(0.00)[17]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,leemhuis.info:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,garyguo.net:email,suse.com:url];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,garyguo.net:email,leemhuis.info:email];
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

Am 08.09.26 um 19:54 schrieb Klara Modin:
> When the commit b67d2d039f64 ("drm/gem: Add callback for when handle
> count goes to 0") added the handle_free callback, it did not update the
> rust abstraction, which will cause a build failure when that is enabled.
> Rather than just adding another None initializer, use
> ..pin_init::zeroed() to make all unlisted callbacks None, and remove the
> existing None-initializations.
>
> Fixes: b67d2d039f64 ("drm/gem: Add callback for when handle count goes to 0")
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Klara Modin <klarasmodin@gmail.com>

Please see my bug report at [1].  This patch fixes half of it. I still get

error[E0063]: missing field `handle_free` in initializer of 
`drm_gem_object_funcs`
    --> /home/tzimmermann/Projekte/linux/rust/kernel/drm/gem/shmem.rs:130:52
     |
130 |     const VTABLE: bindings::drm_gem_object_funcs = 
bindings::drm_gem_object_funcs {
     | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`

error: aborting due to 1 previous error

[1] 
https://lore.kernel.org/dri-devel/CANiq72mUW5d1dOQDgpYjuKoUaZAi-im7j3v30Wd4KTDznmM9zw@mail.gmail.com/T/#r8f10eefc91d3bbce58869433b8258882c2d19ff5

Best regards
Thomas



> ---
>   rust/kernel/drm/gem/mod.rs | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d5..af8274134a71 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -266,18 +266,8 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
>           free: Some(Self::free_callback),
>           open: Some(open_callback::<T>),
>           close: Some(close_callback::<T>),
> -        print_info: None,
> -        export: None,
> -        pin: None,
> -        unpin: None,
> -        get_sg_table: None,
> -        vmap: None,
> -        vunmap: None,
> -        mmap: None,
> -        status: None,
>           vm_ops: core::ptr::null_mut(),
> -        evict: None,
> -        rss: None,
> +        ..pin_init::zeroed()
>       };
>   
>       /// Returns the `Device` that owns this GEM object.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


