Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2E9C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D612010E011;
	Wed, 16 Sep 2026 11:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yPCQ7f7g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0m8DXT4c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a3CzjK4f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k1IyKPLj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9766110E011
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:40:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D83D521D92;
 Wed, 16 Sep 2026 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789558826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ACCVKSOT1L3CY8XolLfX55VUFwK/vZiCkUVPuDdiiM=;
 b=yPCQ7f7g0Zfwl+BtMonqJwbEy9ve/CxLm2dGq3e8U9DBeEFwcX6OATLHvFzh4HJzkG+JZZ
 bkVGstIfKz2T+S2GzDb5E5CidQPIpJSZMSzJDKEAWvD3WcmSJy8HckqOo7O8lrPB2QJYSH
 K7kWGYBD/DMAOHdwyCaYF9QxRaX6zoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789558826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ACCVKSOT1L3CY8XolLfX55VUFwK/vZiCkUVPuDdiiM=;
 b=0m8DXT4c4S07Jgs584c92IYC6ruu7436ztco68xzjD3HnelS3o+RrnLAMraS+YSS0nMeCk
 d9w4MFLHfTeovyCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789558821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ACCVKSOT1L3CY8XolLfX55VUFwK/vZiCkUVPuDdiiM=;
 b=a3CzjK4f6Pzl6L6U+1MsfPjlg/SxnuYy1ufdFijvmPcW1LQMkLN8/d9jRoo/5eBGA40+K5
 p1vQ+6rsTQlQYosdGAJxPiGXTkkjdLgNikWYJOckExnCUkdlGzIDUqjSbQdSRhzKpb9s+e
 oO50ngeiCC9qu+KomLMUB6Ge56hUW7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789558821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ACCVKSOT1L3CY8XolLfX55VUFwK/vZiCkUVPuDdiiM=;
 b=k1IyKPLjCEiACFOkc9VVYTppBiTo1Nf7SvPcvtMQf8LfKkX/QLVnREoc5PDeoAc+VPSqip
 t1yRa7QTyRmJfFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4769A136D1;
 Wed, 16 Sep 2026 11:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pHThNiSAqmrPKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Sep 2026 11:40:21 +0000
Message-ID: <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
Date: Wed, 16 Sep 2026 13:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
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
In-Reply-To: <20260916094453.1062125-1-zaq14760@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com,ti.com,linux.intel.com,kernel.org,ffwll.ch,linaro.org,ravnborg.org,redhat.com];
 TAGGED_RCPT(0.00)[dt]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[17]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
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

(cc'ing Javier for ssd130x expertise)

Hi

Am 16.09.26 um 11:44 schrieb LiangCheng Wang:
> Hi Thomas,
>
> Thank you for the quick reply.
>
>> Where exactly are these ssd16xx patches. I cannot find them in the DRM
>> trees. I presume they are not upstream yet?
> That is right, they are not upstream. Devarsh posted them on 1 May and
> the series is still at v1 on the list:
>
>    [PATCH 0/6] Add DRM driver for Solomon SSD16xx e-paper display controllers
>    https://lore.kernel.org/all/20260430183311.2978142-1-devarsht@ti.com/
>
> One thing that is easy to miss, and that I should have made clearer in my
> last mail: that v1 series covers the SSD1683 only. The SSD1677, which is
> the controller on the PIXPAPER 4.26m, is not part of it. Devarsh has
> SSD1677 support in a staged branch that he kindly shared with me in July,
> and that is what I tested on the panel:
>
>    https://github.com/devarsht/linux-next/commits/ssd16xx_7_2/
>
> Those SSD1677 patches have not been posted to the list yet, which is why
> the panel support has not had anything to build on so far.
>
>> If there's support for similar ICs, I'd strongly prefer to have the
>> ssd1677 be part of that instead of a stand-alone driver.
>>
>> Once the stand-alone driver is in place, users will rely on it. Then it
>> becomes hard to replace. We had (have?) cases where there are several
>> drivers for the same hardware.
> Understood, and thank you for explaining the reasoning - the point about
> users coming to depend on a driver that is then hard to replace makes
> sense, and I would rather not create that problem. I will drop the
> standalone driver and add the PIXPAPER 4.26m to ssd16xx instead, once the
> shared driver is in.

Oh, I now took a closer look at the ssd16xx driver.  I thought that it 
would use the panel helpers, but that's not the case. It's a 'regular' 
DRM driver.

If the ssd16xx does not make progress, we could also try to merge your 
code as ssd16xx and Devarsh would then add support for additional ICs on 
top.

There's also the ssd130x driver under solomon/ how does it related to 
the ssd16xx? Is that similar as well?

Best regards
Thomas

>
> Devarsh, thank you again for sharing the branch, and for making room for
> the panel in your work in the first place. I am glad to keep testing
> SSD1677 on real hardware whenever that is useful to you.
>
> Regards,
> LiangCheng

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


