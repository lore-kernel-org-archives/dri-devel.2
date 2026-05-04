Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A349FFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 11:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9DB10E25F;
	Mon,  4 May 2026 11:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="sSd/5Q9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVcp+077";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sSd/5Q9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVcp+077";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC9710E298
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 11:44:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FC4E5BCC8;
 Mon,  4 May 2026 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777895067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yOJYkCLSKlLn0oFJEHpzst8c/cZ9u/rRzhDZKri8pFM=;
 b=sSd/5Q9wOpZVpDMKLCOiKGg3bIPnCgDyXTVMlRIj3GEtVTRuzqmZEObV69R5r7SUoF1/YB
 nw7CmGegoIw30TCvNzy7DV7y6a7nGWw6KjCj6AGj/0bLsuxpQ5fIbLV+zo1Z51zCKI61zy
 QOxYJsxY/YpSLS1R+4e0ACqXy0Cmqws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777895067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yOJYkCLSKlLn0oFJEHpzst8c/cZ9u/rRzhDZKri8pFM=;
 b=jVcp+077SjeWeH9I2mLWY8Cblq2Nz56QpY4jqfGaKYZlqFOYib6L75xl1Kb8W3D0p3DRNj
 hILgWoKvZDA+GmDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777895067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yOJYkCLSKlLn0oFJEHpzst8c/cZ9u/rRzhDZKri8pFM=;
 b=sSd/5Q9wOpZVpDMKLCOiKGg3bIPnCgDyXTVMlRIj3GEtVTRuzqmZEObV69R5r7SUoF1/YB
 nw7CmGegoIw30TCvNzy7DV7y6a7nGWw6KjCj6AGj/0bLsuxpQ5fIbLV+zo1Z51zCKI61zy
 QOxYJsxY/YpSLS1R+4e0ACqXy0Cmqws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777895067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yOJYkCLSKlLn0oFJEHpzst8c/cZ9u/rRzhDZKri8pFM=;
 b=jVcp+077SjeWeH9I2mLWY8Cblq2Nz56QpY4jqfGaKYZlqFOYib6L75xl1Kb8W3D0p3DRNj
 hILgWoKvZDA+GmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58AAB593A3;
 Mon,  4 May 2026 11:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A9WAE5uG+Gm2LAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 04 May 2026 11:44:27 +0000
Message-ID: <1c856d01-a13a-46cf-9338-cf8fbdaa35ca@suse.de>
Date: Mon, 4 May 2026 13:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Native DisplayID support in core DRM
To: Jani Nikula <jani.nikula@linux.intel.com>, Simon Ser
 <contact@emersion.fr>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Cc: Vidith Madhu <vmadhu@nvidia.com>, dri-devel@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, xorg-devel@lists.x.org
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
 <aeaJlED2e1ZXsLlt@intel.com>
 <nNHAgq_075xcIstZgSRJ0LASnvNd7FP6D2XfBPVa3SyjPX1nErxrrRqEIcd4nO7a0WY-pvrTS9NOR_ESqsHGsbpuLNRBGdzyn6-Vi-QSyPQ=@emersion.fr>
 <faf56da55c4a67edc2474134eb335bbd874f684b@intel.com>
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
In-Reply-To: <faf56da55c4a67edc2474134eb335bbd874f684b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo,emersion.fr:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid]
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

Am 04.05.26 um 12:30 schrieb Jani Nikula:
> On Thu, 30 Apr 2026, Simon Ser <contact@emersion.fr> wrote:
>> The big one here is the "EDID" blob property exposed by KMS. We can't just put
>> a DisplayID blob in there, that would break user-space. We'll need a new
>> property.
> I think the big question is what do we do with the EDID property when we
> encounter a display with native DisplayID.
>
> The VESA E-DDC spec says the host should try DisplayID first, and not
> read the EDID if a DisplayID is found. However, if we only update the
> DisplayID property and not the EDID property, I think that'll be a
> regression.

Is there a technical problem/side effect/interference from reading both?

>
> So maybe we need to read both DisplayID and EDID, contrary to what the
> E-DDC spec says. Obviously that means slower detection overall, for all
> displays, old and new. Especially if there are errors reading DisplayID,
> which you'd expect with old displays.

IMHO we should

1) follow the spec and expose DisplayID first and EDID only if the 
former is not available, and
2) provide a kernel config option to provide both.

People building kernel usually have control over user space as well. 
That option can be enabled by anyone with a legacy user space. This also 
puts some mild pressure on user space to implement DisplayID.

>
> There's an additional catch. The E-DDC spec says the capabilities in the
> DisplayID don't need to be a strict superset of the capabilities in the
> EDID. The idea is that the DisplayID is for new hosts, and the EDID is
> for legacy and max interoperability. But if we read both and aim for no
> regressions, we'll have to expose a union of the capabilities.
>
> Strict adherence to spec isn't exactly what EDID is known for. We're
> likely to encounter displays where the DisplayID and EDID contradict
> each other, and we'll have to mediate between them.

Same here. DisplayID first and treat EDID as legacy.

Best regards
Thomas

>
> And what userspace does with all of this is a mess of its own...
>
>
> BR,
> Jani.
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


