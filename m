Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E79CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB1710E0ED;
	Tue,  6 Oct 2026 06:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="LMVWGaba";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KFYUDn6j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QjbHRkpF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xi/E1qR/";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949FB10E0ED
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:50:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A39B71FB0D;
 Tue,  6 Oct 2026 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791269446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=78ppojnmFGWaZ0WsJ8ViO6E7dQ28IkoJfWe+LP/oH88=;
 b=LMVWGabaFCp2b7/nBh6pWbfIXfsEb87yNzlkTaZ+j1Lm/tlJYCR9ENPNy2FOWhlUx0jzbN
 NpAVjjpgfPQI1bI8V8yjKmLc53RJZjLzuvae5iimucbFZHtqttdMzVoTMwU/Rvo1PT9Ts2
 rd3ui1TgLsxpEedhj4qEEaJRISKzOSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791269446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=78ppojnmFGWaZ0WsJ8ViO6E7dQ28IkoJfWe+LP/oH88=;
 b=KFYUDn6jU9CvVgjQB0qfm2ffi6bdI7YABCZTKWg6elyF/7FOikzihR8pfQugmXzCPB8i29
 LQ9TvkAHZ39jFlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791269442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=78ppojnmFGWaZ0WsJ8ViO6E7dQ28IkoJfWe+LP/oH88=;
 b=QjbHRkpF8NKW5KAKbIN6mxcWHrdHQTXlbsWdY6PYnnJMHqf21y/OCowd5bZkjrB9zDX1C6
 KhV45LsVB08VuSCjJXS0eOnvhfUjEmXDOCVZ4XVxp5tzkp9SgvqLdHtShcxkxTYlVw5pqx
 vy9KGLPkT+cokWF0JrC7S+RWlsraeno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791269442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=78ppojnmFGWaZ0WsJ8ViO6E7dQ28IkoJfWe+LP/oH88=;
 b=xi/E1qR/Vq2a7yCSX0eBRxm43d+Bh8dmISiNLdxe9JjVGgvqQWQrX+9YHOqoiFuvQUga0Q
 R0vrd8GL6O76LSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51692136F2;
 Tue,  6 Oct 2026 06:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wW4oOUGaxGrbKgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 06 Oct 2026 06:50:42 +0000
Message-ID: <7ee9d846-d29e-4c53-a66f-900f8bd7f26b@suse.de>
Date: Tue, 6 Oct 2026 08:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>
Cc: dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
 <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
 <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <3bfe2517-a5d3-4e86-99bd-6c28556f0f2d@igalia.com>
 <55914ef9-517d-48dd-a084-0f553f04cb8a@suse.de>
 <6820428b-64b8-4365-8117-d779fdc43af0@igalia.com>
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
In-Reply-To: <6820428b-64b8-4365-8117-d779fdc43af0@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[igalia.com,redhat.com,gmail.com];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, suse.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Am 02.10.26 um 23:13 schrieb Maíra Canal:
[...]
>> The first bullet point talks specifically about GPU acceleration. 
>> Mesa creates dumb buffers for _software rendering_. Ssd130x scans out 
>> the final result and transfers it to the panel. No GPU rendering 
>> involved there.
>>
>
> Mesa also uses dumb buffers for rendering. kmsro created dumb buffers as
> render targets for several render-only GPUs, such as V3D, Panfrost,
> Etnaviv, and others. You can check that in the function
> renderonly_create_kms_dumb_buffer_for_resource().


That function should not exist. But some authors of kernel drivers were 
not aware that they cannot use dumb buffers for rendering (I don't blame 
them) so they never even added a dedicated ioctl for buffer allocation. 
It works in practice because the hardware has no special requirements 
for the rendering buffers.

BTW the drivers you refer to do have ioctls for buffer allocation. 
Fixing Mesa would be appreciated.


>
> I believe I don't have the full historical background to affirm if dumb
> buffers should be used or not as render targets. If Mesa is using it for
> so many years, it's probably not wrong.

I assure you it is wrong. We have this discussion once per year or so, 
when someone uses dumb buffers for something they are not for. This 
mostly happens because we didn't reject unsupported input into dumb 
buffer early enough. Not we're stuck with user space's de-facto semantics.

For example, you can see this [1] discussion from Feb 2025 on color 
formats. Dumb buffers are meant to return linear RGB buffers, but user 
space allocates whatever it needs. So now we cannot fully reject invalid 
parameters without breaking something. Hence, the kernel now 
semi-whitelists and documents the exceptions. See [2]. There's 
multi-planar YUV in there!

[1] 
https://lore.kernel.org/dri-devel/dcd59a75-7945-4a2e-99f9-3abbb3e9de14@ideasonboard.com/
[2] 
https://elixir.bootlin.com/linux/v7.2.8/source/drivers/gpu/drm/drm_dumb_buffers.c#L149

Best regards
Thomas


>
> Best regards,
> - Maíra
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


