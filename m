Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2A0EC01A1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBF110E3FB;
	Mon, 23 Mar 2026 07:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lqqjaBMr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SarpKtuY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bxd9brr/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bvCM4sTD";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8376010E3FB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:51:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3016F5BD63;
 Mon, 23 Mar 2026 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774252280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8xkWSPq+kZviJ8GgHMDMb13XYFI0T5EqWTWYBo4ArxA=;
 b=lqqjaBMr7ID1HXEGECg9mEg3fqXz6LphZHenKLBQo8xVt5P8gvtA8go+rDWvBn7RBgY67b
 uR7EttpLSO0bxBK8oAPl1WXNzGdnFFHEtgSWpgj2E7OScncMDjcBHodejR8cAaTks5QBg7
 odBu/cjB8QWymMx654dQgFkgO7qpqAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774252280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8xkWSPq+kZviJ8GgHMDMb13XYFI0T5EqWTWYBo4ArxA=;
 b=SarpKtuYBfydZEqXSUvkVfddEe6IqJ7AVFmywDjDM2QnWFuuvf7oOC4SXvF/Y3gUuWR6sM
 6eWr9y9UbIvH11Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774252279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8xkWSPq+kZviJ8GgHMDMb13XYFI0T5EqWTWYBo4ArxA=;
 b=Bxd9brr/YMsR5Gs8rBWwMdC/mBjYjLYcNaLx3b0rIs2KID+Gp0Y/BiSVxk5gnR/gSWXJgd
 80ZQt2eSjBCQeQh2nYY+PEKvAS4L8y0vV+BwJez1xH/9XkhiveOg7pRQbS1D503da/FSBc
 zqBN04KaW385LEEaCBOoeiW49RGBX/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774252279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8xkWSPq+kZviJ8GgHMDMb13XYFI0T5EqWTWYBo4ArxA=;
 b=bvCM4sTD9VU+ocKSKHs06bp+eetz4mjWY9h4qEZsOoz62+J1Rk+AtQxewpB5vsnBM0wyYu
 OOrsZSqQJ2ijCTCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D05E14377B;
 Mon, 23 Mar 2026 07:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XFtxMfbwwGl/eQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 07:51:18 +0000
Message-ID: <351271b1-3597-4c62-9451-4d3cd4f65a3e@suse.de>
Date: Mon, 23 Mar 2026 08:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/16] drm/ili9225: Use regular atomic helpers; drop
 simple-display helpers
To: David Lechner <david@lechnology.com>, javierm@redhat.com,
 lanzano.alex@gmail.com, kamlesh.gurudasani@gmail.com,
 architanant5@gmail.com, wens@kernel.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260319160110.109610-1-tzimmermann@suse.de>
 <20260319160110.109610-7-tzimmermann@suse.de>
 <48ee60a0-d7e7-45e4-95b3-0ff8df007138@lechnology.com>
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
In-Reply-To: <48ee60a0-d7e7-45e4-95b3-0ff8df007138@lechnology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid, suse.de:email]
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



Am 22.03.26 um 02:13 schrieb David Lechner:
> On 3/19/26 10:59 AM, Thomas Zimmermann wrote:
>> Replace simple-display helpers with regular atomic helpers. Store the
>> pipeline elements in struct ili9225_device and initialize them as part
>> of probing the device. Use mipi-dbi's existing helpers and initializer
>> macros where possible.
>>
>> Effectively open-codes the modesetting code in the initializer helpers
>> of mipi-dbi and simple-display. Ili9225 requires custom helpers for
>> various pipeline elements, and non-freeing cleanup of the pipeline.
>>
>> v3:
>> - set dbi variable (David)
>> v2:
>> - fix connector initialization
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Acked-by: David Lechner <david@lechnology.com>
>> ---
> I dug up one of these and it is working now too. So I think this
> series is in good shape now.
>
> Tested-by: David Lechner <david@lechnology.com>

Fantastic, thanks  a lot.


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


