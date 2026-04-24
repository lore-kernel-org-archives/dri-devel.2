Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC6DFB44BB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0127C10E111;
	Fri, 24 Apr 2026 06:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QOP0tRah";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlAWa/QQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ykhq56WD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xPIXmnlR";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94AD610E111
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:57:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1ABC46A868;
 Fri, 24 Apr 2026 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777013857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpEtZHInfoJgNByDQrjuZX346W4lKTBgi1Yot9+im3w=;
 b=QOP0tRahStTw46nTPTpypuDDCPbYqbgwO4bjR9K7pIUwMbbIVLwahs8OIN1MvlABp4t/Sa
 NL+ESNQbqhuDrsAyoXGdOlYPwMZZlN50spb1qJFxP0SrIH5ceja/a1Wg7olIKffuy31H0i
 Jtni9Otd4oonlxig6KsIqy0XQxcpv3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777013857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpEtZHInfoJgNByDQrjuZX346W4lKTBgi1Yot9+im3w=;
 b=wlAWa/QQPALVUUNbN3DfqWjkZL+zVDnvetXZkPsNfbbJo8Z1RN+EDyfPgDZGLwH0dQaVSm
 h+bvDiT7vWimYBBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ykhq56WD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xPIXmnlR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777013856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpEtZHInfoJgNByDQrjuZX346W4lKTBgi1Yot9+im3w=;
 b=Ykhq56WDVY34N+fT9poaj/jYN/T1QzB2JLXxBf9M/IHE7aojLoo+Y/n4PEjU3Z7iUQNKHs
 MBZVwa2ZkmXuvGzaambmiFzny/wjTJ8S30IxW5eSetYWqHbw+JkPprB/K3OPaJ0XvfyfdH
 NwnJZ9cHdgYig2uHHTQcqWFVL7+qtrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777013856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rpEtZHInfoJgNByDQrjuZX346W4lKTBgi1Yot9+im3w=;
 b=xPIXmnlRkERWokC1kFBkJV2jBKcc5qVtoCST3vYa+HolS8Op70DZ2ZK2CtCxYCc7gNJCbF
 orjb+sXC0XxG6hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F24B5593AE;
 Fri, 24 Apr 2026 06:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TOLpOV8U62lhKQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 24 Apr 2026 06:57:35 +0000
Message-ID: <3fe83b69-b868-45a8-9862-50c6f0fdeb95@suse.de>
Date: Fri, 24 Apr 2026 08:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260423205531.49971-1-deller@gmx.de>
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
In-Reply-To: <20260423205531.49971-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmx.de,vger.kernel.org,lists.freedesktop.org];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.de];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 gmx.de:email, suse.com:url, bootlin.com:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1ABC46A868
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

Am 23.04.26 um 22:55 schrieb Helge Deller:
> This item is tagged for beginners, so often people not familiar with
> the fbdev drivers think this is an easy task, start up their AI tools
> and blindly send in the generated code as patches.
>
> The problem:
> - Those patches often introduce bugs, so
> - ideally want the code tested, since ressource misconfigurations
>    often lead to failing drivers
> - The patches are often unnecessary, since in the old machines with the
>    old graphic cards resource conflicts usually don't happen as only one
>    graphic card can be used at a time anyway.
> - and today most relevant drivers have necessary patches already
>    implemented.
>
> So, let's get rid of this todo item and silence the steady stream of
> stupid patches.

I see that AI patches can be problematic, but reserving these regions is 
still the correct thing to do. Removing the TODO item will not change that.

Some background on why this item exists: we currently use aperture 
helpers [1] to manage ownership of the framebuffer memory during boot 
up. This is necessary to switch from the system-framebuffer driver 
(i..e, simplefb, simpledrm, etc) to the hardware's native driver. But 
this is all ad-hoc because Linux' resource management doesn't do this 
for us. Before we can integrate any such functionality, we have to fix 
all drivers to reserve their resources correctly.

If we remove the TODO item, we'd likely still want to move forward with 
improving resource management. If that breaks unfixed fbdev drivers, 
users would then also send bug reports.

And the other point is (again) that if there are no means of testing a 
driver and no information whether a driver is actually in used by 
anyone, it's maybe time to remove the driver.

[1] 
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/video/aperture.c#L17

Best regards
Thomas


>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   Documentation/gpu/todo.rst | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index bc9f14c8a2ec..b4dd64a8cc06 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>   
>   Level: Intermediate
>   
> -Request memory regions in all fbdev drivers
> ---------------------------------------------
> -
> -Old/ancient fbdev drivers do not request their memory properly.
> -Go through these drivers and add code to request the memory regions
> -that the driver uses. This requires adding calls to request_mem_region(),
> -pci_request_region() or similar functions. Use helpers for managed cleanup
> -where possible. Problematic areas include hardware that has exclusive ranges
> -like VGA. VGA16fb does not request the range as it is expected.
> -Drivers are pretty bad at doing this and there used to be conflicts among
> -DRM and fbdev drivers. Still, it's the correct thing to do.
> -
> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
> -
> -Level: Starter
> -
>   Remove driver dependencies on FB_DEVICE
>   ---------------------------------------
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


