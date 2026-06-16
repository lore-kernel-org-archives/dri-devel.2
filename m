Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7BDCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3EE10EA8E;
	Tue, 16 Jun 2026 12:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="P2Let6pB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tRufQOU3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iPFK55Bw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wDap6hh1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE2210EA8E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 12:03:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 582496C7C2;
 Tue, 16 Jun 2026 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781611394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONWiKM7Vic5LxakVYN6jw350O+WnGabDHVpW9jiNQvI=;
 b=P2Let6pBmngnqWeoI5RmOPsQhg9PqEWFzU72wYvELSC2Qn1ckBZ/mW3BOAOb3r30bF73mj
 RCYK66a4jboHm00s/oDvYyb5eR1tQnmirPMWSxuwRM6xvb7NxkNCWo8vtAMnvF7Ln6/pDC
 R4eicRwN/Yvbk2R8YrGI+8nzXOE/QJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781611394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONWiKM7Vic5LxakVYN6jw350O+WnGabDHVpW9jiNQvI=;
 b=tRufQOU3dTRtfnFLruexmz2tVAS3hYzKJMX9hdzsdwNAYEUlVcceagwKf2lPa1ggm6J9BG
 XICQ9Zktd0OSu5DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781611392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONWiKM7Vic5LxakVYN6jw350O+WnGabDHVpW9jiNQvI=;
 b=iPFK55Bwox7oVKcZyvv+6ehUphQrnUwlzKZi1QwpCX/+sEk5OXVM1gA5En7bl6zTUA68Tz
 BQTup5jxdPDcwrlWAJmd56Roy23QL/ALFrH75Uc0EWmDij7Qm2zE7Axp9R8DceyijNtzjO
 no7rsp8QgDH6grphGH3AvLf79KmDUGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781611392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ONWiKM7Vic5LxakVYN6jw350O+WnGabDHVpW9jiNQvI=;
 b=wDap6hh1cMcGOxyDbSXvoAWOcwzH1l/LzQc7WtEj+9lpHQNrnscPWvTvWmyewkfJyR+vav
 nAx91r+j23lq8JCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 118AB779A8;
 Tue, 16 Jun 2026 12:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LDEHA4A7MWrOVAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 16 Jun 2026 12:03:12 +0000
Message-ID: <e9dc7a91-b1a3-44c4-b621-4a7c324ee192@suse.de>
Date: Tue, 16 Jun 2026 14:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fourcc: document format naming scheme
To: Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>
References: <20260426151641.93763-1-contact@emersion.fr>
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
In-Reply-To: <20260426151641.93763-1-contact@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ideasonboard.com,linux.intel.com,kernel.org,ffwll.ch,oss.qualcomm.com,fooishbar.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, intel.com:email,
 imap1.dmz-prg2.suse.org:helo, qualcomm.com:email, suse.de:email, suse.de:mid]
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

Hi,

thanks for documenting this. See below for some proof reading.

Am 26.04.26 um 17:16 schrieb Simon Ser:
> When adding a new format, one needs to pick a name and fourcc.
> This is not always an easy task: figuring out why current formats
> are named this way is tricky.
>
> Document current practice to make that process easier.
>
> See previous discussion at:
> https://lore.kernel.org/all/aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=@emersion.fr/
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> ---
>   include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index ac66fa93b5a3..dc737c4fa5f2 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -38,6 +38,45 @@ extern "C" {
>    * fourcc code, a Format Modifier may optionally be provided, in order to
>    * further describe the buffer's format - for example tiling or compression.
>    *
> + * Formats
> + * -------
> + *
> + * Formats describe how a buffer is interpreted to decode pixel color and alpha

Rather use singular because there is only one format per buffer. And use 
active voice. Something like

'A format describes how to interpret a buffer and decode ...'

> + * values. Formats are uniquely identified by a four character code (fourcc).

'four-character code'

> + * Memory layout is always described in little-endian order.

Use active voice and at least hint to the big-endian flag. Something like:

"By default, a pixel's bytes are in little-endian order."

> + *
> + * The following channels are defined:
> + *
> + * - "R", red
> + * - "G", green
> + * - "B", blue
> + * - "A", alpha
> + * - "C", color index (for paletted formats)
> + * - "D", darkness (inverse relationship between channel value and brightness)
> + * - "Y", luma/brightness
> + * - "U", blue-difference chroma (Cb)
> + * - "V", red-difference chroma (Cr)
> + * - "X", a placeholder for undefined/unused contents
> + *
> + * Formats using the RGB color model have names made up of a list of channels
> + * followed by the number of bits used by each channel, respectively. Any
> + * padding is explicitly indicated by the special "X" channel. Channels use
> + * unsigned integers, except when suffixed by "F" to indicate IEEE 754 floats.
> + * An underscore "_" can be used to delimit planes.

Give some examples here. Something like:

"For example, XRGB8888 describes a pixel with 4 bytes. The first byte is 
unused and the trailing bytes contain red, green and blue channels 
respectively. R32F describes a pixel with a single red channel storing a 
32-bit floating-point value."


> + *
> + * Multi-planar YUV formats use the following naming scheme for the most part:
> + *
> + * - The first letter indicates the number of planes, channel alignment and
> + *   ordering. It is should not be a letter already used to denote a channel.

'It is should not' -> "It should not" or "It must not" depending on the 
strictness of this rule.

> + * - The first digit indicates chroma sub-sampling: 0 for 2x2, 2 for 2x1, 4 for
> + *   none.
> + * - The two other digits indicate bits for the Y channel. If the Cb channel
> + *   comes before Cr, the digits are reversed.

Please give an example for a multi-planar format here.

> + *
> + * Fourccs are allocated on a first-come, first-served basis. New format names
> + * and fourccs should try to use the same naming scheme as existing, similar

'should try to' -> 'should'

Best regards
Thomas

> + * formats.
> + *
>    * Format Modifiers
>    * ----------------
>    *

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


