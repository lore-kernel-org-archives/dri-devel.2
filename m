Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D0FF886F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 12:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D1310E28D;
	Mon,  4 May 2026 12:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="XUQaqx74";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ppk+FitQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kOBmH6VZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pL64sR/i";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D656F10E28D
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 12:21:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96BE06AE03;
 Mon,  4 May 2026 12:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777897280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F5zjTNwoyT2IoNc1zcJgNkhXYh+PMszy4TK5gnQ6e48=;
 b=XUQaqx74rr5H65nlbpzs6vAI/dabkcqM8kE5bQvax00ni4s5/zUq+BbTd7WeTKL9nic5wm
 b+PrixDWIY7PqKZfvOY8hiyPbOuKfX7MzJAylzns3g+X20Bhzye5naevhAm8Mqu/fmjvck
 jbMM9C4Y3r8ZkBEl9XJCOS/eAH3NnYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777897280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F5zjTNwoyT2IoNc1zcJgNkhXYh+PMszy4TK5gnQ6e48=;
 b=Ppk+FitQz5ukoHT3voquYX7wFpr8k5iyFfJpBzNixojB+rJfIfgky9/MKzF7BgwmeleS5o
 +sOtrZBVblb3OWCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777897279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F5zjTNwoyT2IoNc1zcJgNkhXYh+PMszy4TK5gnQ6e48=;
 b=kOBmH6VZZT1JdK7v63G7pbsJnWeO6SoyDkY0oM33B3eMBh/h3bO+fDZqsMTgpvaxfGgZWE
 wJRbBB9fkVjoq8t426zr+bMc5DWsPKBSAGFqr0m+QEyw3SAexPy7BFMlPS1J/CgWSv99W6
 bZG0gVQgfqFjb0OdVWKX4Q58982EMzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777897279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F5zjTNwoyT2IoNc1zcJgNkhXYh+PMszy4TK5gnQ6e48=;
 b=pL64sR/isihBA0eQFNmMlJnQ1axf9TrHYmeBIxNSOVLGcWKJT26dgoIUFA0yDGthQugziY
 BhkXXEY5HzmvasDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C9A3593A3;
 Mon,  4 May 2026 12:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9KVVFT+P+Gl7UgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 04 May 2026 12:21:19 +0000
Message-ID: <4ac687c9-b363-46c9-91f0-6715c2cefadb@suse.de>
Date: Mon, 4 May 2026 14:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/vmwgfx: Use DRM's vblank timer
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, dri-devel@lists.freedesktop.org
References: <20260427150250.699768-1-tzimmermann@suse.de>
 <CABQX2QOqMct4SKiZF1dkUv7fs86qe=SAt8V_3yP52DE43XhevQ@mail.gmail.com>
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
In-Reply-To: <CABQX2QOqMct4SKiZF1dkUv7fs86qe=SAt8V_3yP52DE43XhevQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,broadcom.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email, broadcom.com:email]
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

Am 28.04.26 um 07:54 schrieb Zack Rusin:
> On Mon, Apr 27, 2026 at 11:02 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Replace vmwgfx's vblank timer with DRM's shared implementation. The
>> common code is mostly equivalent, but provides additional protection
>> against concurrent changes to the vblank counter.
>>
>> Patches 1 and 2 align vmwgfx with the shared code, so that it can be
>> converted easily.
>>
>> The conversion is in patch 3. It replaces vmwgfx's custom timer with
>> calls to DRM's vblank interfaces. Initialization happens internally.
>>
>> This series should get some more testing.
>>
>> v2:
>> - patch 3: fix vblank cancalling in CRTC cleanup (Zack)
>> - patch 2: mention timer restart in commit message (Zack)
>>
>> Thomas Zimmermann (3):
>>    drm/vmwgfx: Determine lock-waiting timeout from vblank state
>>    drm/vmwgfx: Move vblank handling into separate helper
>>    drm/vmwgfx: Convert to DRM vblank timers
>>
>>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 -
>>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  1 +
>>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  1 +
>>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  1 +
>>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 70 ++++++++--------------------
>>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h |  2 +-
>>   6 files changed, 24 insertions(+), 53 deletions(-)
>>
>> --
>> 2.54.0
>
> Looks great! Feel free to push through drm-misc-next or I can do it
> for you if you prefer.
>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

Merged now. Thanks a lot.

Best regards
Thomas

>
> z

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


