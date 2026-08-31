Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1188C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2036010E297;
	Mon, 31 Aug 2026 10:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tnaxwRdv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SyiJ4uzs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MI8emGWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yuQjlVim";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B47410E297
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:34:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FDA622605;
 Mon, 31 Aug 2026 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788172487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Phv0ZebiZfK+29VSYNMS4Vd8RhCPIJFdfiNAqlZZrGY=;
 b=tnaxwRdv/5j3nK7Gd2aAUwPqiyVOs5ArI039YSDgAoC54UpFtPVIGS3VUdpNyTdALI/0OP
 F6Tm4OttKrN8zZ4zL3/VgaX+Oud62AaF8VWi8TdH3opkQbaFEMIrUO2aPTDHQ9qD6/QT9d
 INA9O1bEQhOGL6B44Z4ZgeKkI2nqYak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788172487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Phv0ZebiZfK+29VSYNMS4Vd8RhCPIJFdfiNAqlZZrGY=;
 b=SyiJ4uzspc7Jym8wwbzgAtLZBPbBrgpnVLJLqWDgJNavPFYP9xkbPL/J8uFtEP+qFud6+t
 PmhSprbE6WRFwYAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788172481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Phv0ZebiZfK+29VSYNMS4Vd8RhCPIJFdfiNAqlZZrGY=;
 b=MI8emGWnpKBjTS5/k+LxWZFbPlhw6p8+oAiqQF3p53TtwecICqnL5n1U7JqD2gfWWSrOH6
 tWRxITmbwWHS5W5t+MyTgg2kOx5DuLxlh7cvhUptgWk/QDggXS9+XKzbbZXivsvzzHwkiM
 v7kBMoFJ3q0t89XJQE9jhmgDWngYXm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788172481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Phv0ZebiZfK+29VSYNMS4Vd8RhCPIJFdfiNAqlZZrGY=;
 b=yuQjlVimRqK7Oy6UzL8qJOirq0NwUaZg9AaspkNZ33NolC8QidRDudt037ib9NptiejeGU
 aVX8MueE/T8r0sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96BBE13515;
 Mon, 31 Aug 2026 10:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2tOOI71YlWpeFAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 31 Aug 2026 10:34:37 +0000
Message-ID: <efaaeafb-2fb3-452b-a18f-cbcde3183fd4@suse.de>
Date: Mon, 31 Aug 2026 12:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sysfb: Fix display output on Lenovo D330 (and others)
To: Ard Biesheuvel <ardb@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
References: <20260827140726.420734-1-tzimmermann@suse.de>
 <6b778c42-577b-4df1-a364-d4123f45080a@app.fastmail.com>
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
In-Reply-To: <6b778c42-577b-4df1-a364-d4123f45080a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[kernel.org,redhat.com,linaro.org,linux.intel.com,ffwll.ch,gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.com:url,
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

Hi Ard

Am 27.08.26 um 18:56 schrieb Ard Biesheuvel:
> Hello Thomas,
>
> On Thu, 27 Aug 2026, at 16:01, Thomas Zimmermann wrote:
>> The kernel mis-interprets the display geometry given by the Lenovo
>> D330 as incorrect. The values are correct, but the display output
>> is rotated by 90°. With the kernel's firmware quirk applied the output
>> is garbled.
>>
>> Remove the firmware quirk for the Lenovo D330 and let DRM's sysfb
>> drivers set the correct panel orientation instead. To make this work
>> for any display mode, use the panel size for looking up the correct
>> orientation.
>>
>> Tested on a Lenovo D330-10IGM IdeaPad.
>>
>> Thomas Zimmermann (3):
>>    drm/edid: Add drm_edid_get_preferred_size()
>>    drm/sysfb: Use preferred panel size for panel orientation quirks
>>    firmware/sysfb: Remove rotation quirk for Lenovo D330
>>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

The Sashiko bot warns that the quirk is required on the device's older 
UEFI firmware revisions.  I can confirm that the quirk breaks display 
output for the latest firmware (ver 8NCN43WW).  How is this usually 
being handled? Can I expect affected users to update their firmware?

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


