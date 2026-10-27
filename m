Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD3606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w7xS2WIf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FXsKVxQj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=w7xS2WIf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FXsKVxQj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962BB10F3BF;
	Tue, 27 Oct 2026 10:29:34 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C48B10E3F7
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:29:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14A7721EFB;
 Tue, 27 Oct 2026 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793096962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k444X39/YaQ8vvcb2TO5d3th3eGpgXn1bRiIQ7v217w=;
 b=w7xS2WIfqvYVe+u1Qpz1jHNUwZZzVgzUF3bzX727ThRcKwI/avRF28rd2EJhzu4K/ayug7
 yqm8/W/s/WxoQj+jouF1GdWvJySXo+a8HqSHkWXSNzeO8/0FWq6lFRL4OVDt9ATcP0Xx4a
 YXu4bdBQ16/R4vxLR/FfrLAKED2UPrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793096962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k444X39/YaQ8vvcb2TO5d3th3eGpgXn1bRiIQ7v217w=;
 b=FXsKVxQjm6fxnsPOig2H1Z0dXxsgFd6QbI+lbQlM6OQg7OVxwpkssuaIW6nwSBKfC1mtKq
 2gj7cnLwZOU1NWAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w7xS2WIf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FXsKVxQj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793096962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k444X39/YaQ8vvcb2TO5d3th3eGpgXn1bRiIQ7v217w=;
 b=w7xS2WIfqvYVe+u1Qpz1jHNUwZZzVgzUF3bzX727ThRcKwI/avRF28rd2EJhzu4K/ayug7
 yqm8/W/s/WxoQj+jouF1GdWvJySXo+a8HqSHkWXSNzeO8/0FWq6lFRL4OVDt9ATcP0Xx4a
 YXu4bdBQ16/R4vxLR/FfrLAKED2UPrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793096962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k444X39/YaQ8vvcb2TO5d3th3eGpgXn1bRiIQ7v217w=;
 b=FXsKVxQjm6fxnsPOig2H1Z0dXxsgFd6QbI+lbQlM6OQg7OVxwpkssuaIW6nwSBKfC1mtKq
 2gj7cnLwZOU1NWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A18F1321C;
 Tue, 27 Oct 2026 10:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qv97CwF94GoTEAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 10:29:21 +0000
Message-ID: <eaaa4b5a-9de9-41ed-a77b-aa2c6531eed6@suse.de>
Date: Tue, 27 Oct 2026 11:29:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev: Replace __MODULE_STRING() with __stringify()
To: Petr Pavlu <petr.pavlu@suse.com>, Sasha Levin <sashal@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261022175543.1831620-1-sashal@kernel.org>
 <2a9b1325-386b-4460-8651-13fc43dca6c6@suse.de>
 <3e3b9652-7de5-4391-8b5d-122f00c4b585@suse.com>
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
In-Reply-To: <3e3b9652-7de5-4391-8b5d-122f00c4b585@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14A7721EFB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.freedesktop.org:url];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,google.com,atomlin.com,lists.freedesktop.org,vger.kernel.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.50
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 27.10.26 um 10:00 schrieb Petr Pavlu:
> On 10/23/26 10:51 AM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 22.10.26 um 19:55 schrieb Sasha Levin:
>>> Commit 08abfa5a161e ("drivers: Replace __MODULE_STRING() with
>>> __stringify()") converted the drm_fbdev_overalloc parameter description
>>> in drm_fb_helper.c ahead of the removal of __MODULE_STRING().
>>>
>>> Commit 6b5a66fd9f21 ("drm/fbdev: Move fbdev module parameters next to
>>> module init") moved that parameter into drm_kms_helper_common.c while it
>>> still used __MODULE_STRING(), so the conversion never reached the moved
>>> code. drm_kms_helper_common.c is now the last user of the macro, and
>>> removing the macro breaks the build with CONFIG_DRM_FBDEV_EMULATION=y:
>>>
>>>     drivers/gpu/drm/drm_kms_helper_common.c:46:18: error: expected ')' before '__MODULE_STRING'
>>>
>>> Use __stringify() instead. The parameter description is unchanged.
>>>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>>> ---
>>> This depends on 6b5a66fd9f21 in drm-next and 08abfa5a161e in
>>> modules-next, both queued for 7.4. Petr plans to remove
>>> __MODULE_STRING() once his conversions are in mainline, so this needs to
>>> land first, either through drm-misc after 7.4-rc1 or together with the
>>> removal patch.
>> Dave, could we put this patch directly into drm-next? It seems like this fixes a broken merge commit.
> It looks like Linus took care of this. Merge commit 5b0764a53235 ("Merge
> tag 'drm-next-2026-10-21' of https://gitlab.freedesktop.org/drm/kernel")
> updated drivers/gpu/drm/drm_kms_helper_common.c to use __stringify()
> instead of __MODULE_STRING(). The current mainline has no remaining uses of
> __MODULE_STRING().

Great, thanks for the info.  I'll drop this patch then.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


