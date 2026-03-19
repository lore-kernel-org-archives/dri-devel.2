Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8E1090227
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6DF10E908;
	Thu, 19 Mar 2026 13:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1MTNSIt/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1a0VpoHg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1MTNSIt/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1a0VpoHg";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D722010E908
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 13:37:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3212C4D1E9;
 Thu, 19 Mar 2026 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773927458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0hOoVgrvrWssLHbO7D3D+SNV9TNdhV/zsQJ2wjDuaL0=;
 b=1MTNSIt/00f1lzYkXA8LtKkJTg4XFrYl4+6RHc5WwXLPA2QBD/l0RtQl+gHIZg5MeteJMO
 hUXXB7dJVJLpSmuXc/1Yue5PTttmBYvcJ8sh9/+uwWnlRfnzbOxtulV1KUSUTy1GFzCjQh
 0jla4SG1cO6igedS7e/8BGiaaA5RXt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773927458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0hOoVgrvrWssLHbO7D3D+SNV9TNdhV/zsQJ2wjDuaL0=;
 b=1a0VpoHgNo3YcNVr+0mU7ricVAbC3hP/mZX/03avfibH4voVIv2nhJu5WOVQHTgAQadUdq
 j6w+l2YtYHua11Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773927458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0hOoVgrvrWssLHbO7D3D+SNV9TNdhV/zsQJ2wjDuaL0=;
 b=1MTNSIt/00f1lzYkXA8LtKkJTg4XFrYl4+6RHc5WwXLPA2QBD/l0RtQl+gHIZg5MeteJMO
 hUXXB7dJVJLpSmuXc/1Yue5PTttmBYvcJ8sh9/+uwWnlRfnzbOxtulV1KUSUTy1GFzCjQh
 0jla4SG1cO6igedS7e/8BGiaaA5RXt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773927458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0hOoVgrvrWssLHbO7D3D+SNV9TNdhV/zsQJ2wjDuaL0=;
 b=1a0VpoHgNo3YcNVr+0mU7ricVAbC3hP/mZX/03avfibH4voVIv2nhJu5WOVQHTgAQadUdq
 j6w+l2YtYHua11Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDAAA4273B;
 Thu, 19 Mar 2026 13:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XW/HMCH8u2n9QAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 13:37:37 +0000
Message-ID: <92f2e569-59c9-411a-87aa-1b0f05850e43@suse.de>
Date: Thu, 19 Mar 2026 14:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] drm/mipi-dbi: Provide callbacks for atomic
 interfaces
To: David Lechner <david@lechnology.com>, javierm@redhat.com,
 lanzano.alex@gmail.com, kamlesh.gurudasani@gmail.com,
 architanant5@gmail.com, wens@kernel.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260311101438.365997-1-tzimmermann@suse.de>
 <20260311101438.365997-4-tzimmermann@suse.de>
 <7c5fcdca-eb77-4a7c-82e2-92bd46ddd275@lechnology.com>
 <fa8648a2-cbfd-43d8-912a-252f7a8ca56c@lechnology.com>
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
In-Reply-To: <fa8648a2-cbfd-43d8-912a-252f7a8ca56c@lechnology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[11]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Am 16.03.26 um 00:31 schrieb David Lechner:
> On 3/15/26 6:28 PM, David Lechner wrote:
>> On 3/11/26 5:10 AM, Thomas Zimmermann wrote:
>>> Refactor the existing simple-display callbacks such that they invoke
>>> helpers compatible with regular atomic modesetting. Allows for adding
>>> mipi-dbi drives that do not require simple-display helpers. Provide
>>> initializer macro for elements of the regular modesetting pipeline.
>>>
>>> As the new helpers are DRM functions, add the drm_ prefix. Mipi-dbi
>>> interfaces currently lack this.
>>>
>
>
>>>   static const struct drm_mode_config_helper_funcs mipi_dbi_mode_config_helper_funcs = {
>>> -	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>>> +	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
>>>   };
>>>   
>>>   static const struct drm_mode_config_funcs mipi_dbi_mode_config_funcs = {
>>> -	.fb_create = drm_gem_fb_create_with_dirty,
>>> -	.atomic_check = drm_atomic_helper_check,
>>> -	.atomic_commit = drm_atomic_helper_commit,
>>> +	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
>>>   };
>>>   
>>>   static const uint32_t mipi_dbi_formats[] = {
>>> -	DRM_FORMAT_RGB565,
>>> -	DRM_FORMAT_XRGB8888,
>>> +	DRM_MIPI_DBI_PLANE_FORMATS,
>>>   };
>> Why adding these macros? They are only used once, so it seems like it
>> just makes the code harder to read (one more place you have to jump to).
>>
>> Maybe this is common style in drm or something?
> I should have kept reading the next patches before I hit send.

Yeah, these macros will be used extensively by the other drivers.

>
> It would have helped if the commit message mentioned why we are doing
> this and not just what we are doing.

OK.

Best regards
Thomas

>
>>>   
>>>   /**
>>> @@ -633,8 +707,7 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
>>>   				   unsigned int rotation, size_t tx_buf_size)
>>>   {
>>>   	static const uint64_t modifiers[] = {
>>> -		DRM_FORMAT_MOD_LINEAR,
>>> -		DRM_FORMAT_MOD_INVALID
>>> +		DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
>>>   	};
>>>   	struct drm_device *drm = &dbidev->drm;
>>>   	int ret;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


