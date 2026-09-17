Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D5AC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9B310EE04;
	Thu, 17 Sep 2026 11:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="BZ8WmCBC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ITv+zBHp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ddWDcZxw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rEgigdPB";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F91610EE04
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:34:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBB5B21BC9;
 Thu, 17 Sep 2026 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789644860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6H3+7HWZmllVud8whTSzg6hp9aJmxAORCWRKfg4F3/M=;
 b=BZ8WmCBC1+RvnBwCfIDoSKqVf0CvxEo0Njg/15U/OLVpq1NDtUabOMtkB1/xfG7NwG86cl
 CB4BWtvOOfcf8ucOtBL1xUY/r1xit7Bwk1p43ujEOqgGS8ZVr0dTrpDnVp4yQCZ/7ST+nt
 7iFiMz8OB0J+R3gwVOsBxv+yhqViOdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789644860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6H3+7HWZmllVud8whTSzg6hp9aJmxAORCWRKfg4F3/M=;
 b=ITv+zBHpjgPwOmvK0LWe+jXKLdp/9dcW4kV9R0rFhhuKmgCtxt3txu9C3dSZ5QVMQFchfV
 u8UzGGMDzri55nCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789644856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6H3+7HWZmllVud8whTSzg6hp9aJmxAORCWRKfg4F3/M=;
 b=ddWDcZxw1hpEhlBJPPJOrvfCBmT7K4v+T0nBvO88X7alda5NYcyb9GzA/gDTNry6bawLmo
 R42+WGadDJXryz625tfXcVgw8abu+5AIN7EJAR9YQvf9y65ysmOQrKbyiM6Y7kkkMLEO3Q
 gKIgLvpHtxCHYclJhlEfyqFnGIt5dgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789644856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6H3+7HWZmllVud8whTSzg6hp9aJmxAORCWRKfg4F3/M=;
 b=rEgigdPBlzLuzdmLXzTeOsJ4r03UbXJmuqdmR9DbsnzEc1OQ9CJEWxqwpVLC7/86DiPkCd
 kBewwcTbW+IRHFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E5D1374A;
 Thu, 17 Sep 2026 11:34:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cjPKMzfQq2rYNwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 11:34:16 +0000
Message-ID: <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
Date: Thu, 17 Sep 2026 13:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: Javier Martinez Canillas <javierm@redhat.com>,
 LiangCheng Wang <zaq14760@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
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
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
 <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
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
In-Reply-To: <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[dt]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[17];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ti.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linaro.org,ravnborg.org,lists.freedesktop.org,vger.kernel.org,ideasonboard.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Hi

Am 17.09.26 um 12:49 schrieb Javier Martinez Canillas:
> Hello LiangCheng,
>
> Thanks Thomas for CC'ing me since I missed this patch series.
>
> On Thu, Sep 17, 2026 at 4:57 AM LiangCheng Wang <zaq14760@gmail.com> wrote:
>> Hi Thomas,
>>
>>> There's also the ssd130x driver under solomon/ how does it related to
>>> the ssd16xx? Is that similar as well?
>> They share the vendor, but not much else as far as I can tell - Javier
>> will know ssd130x far better than I do.
>>
>> It is an OLED driver over regmap, while ssd16xx is e-paper over raw SPI
>> with a BUSY handshake, RAM address windows and waveform LUTs.  The
>> register maps do not overlap, so I doubt there is much the two could
>> share.
>>
> Correct, I don't think there is much overlap between the ssd13xx and
> ssd16xx families.
>
> There are a few bits that I think are similar though and could be
> reused, for example the pixpaper_spi_write() helper logic is basically
> the same than ssd130x_spi_write() AFAICT.
>
> Same for pixpaper_send_cmd() and pixpaper_send_data(), I believe that
> is the same logic that we now have in ssd130x_write_cmds(). Specially
> after the recent commit 3e391b0b516b ("drm/ssd130x: Add SSD135X_FAMILY
> and SSD1351 support") that introduced a cmd_params_are_data flag that
> allows to send the operation as command and the parameters as data.
>
> So the MCU interface seems to be the same, in particular for the
> 4-wire SPI interface which AFAIU is what this new SSD1677 driver
> supports.

I cannot advice anything here, but at least I'd like to get ssd16xx out 
of tiny/. It would be great to have it all under solomon/. It looks like 
sitronix/ does a similar thing.

Best regards
Thomas

>
>> Its shape does look like a good model though - one driver covering three
>> sub-families through a variant table.  And if you would prefer ssd16xx to
>> sit in drivers/gpu/drm/solomon/ next to it, that is fine by me.
>>
> I think that's a good idea, as I mentioned above some of the helpers
> used by ssd130x could be factored out in a solomon-common.{h,c} or
> something and be shared by both driver ssd130x and ssd16xx drivers (in
> insight I should had called ssd13xx to the driver since now it
> supports SSD130X, SSD132X, SSD133X and SSD135X families...).
>
>>> If the ssd16xx does not make progress, we could also try to merge your
>>> code as ssd16xx and Devarsh would then add support for additional ICs on
>>> top.
>> Thank you - I would be glad to help that way if it comes to it.
>>
> Agreed. The ssd16xx driver could do the same than ssd130x and support
> both SSD1677 and SSD1683. They seem to be quite similar by looking at
> the datasheets publicly available.
>
>> Devarsh, it is your series though, so please say if you would rather carry
>> it yourself; I would only pick it up with your agreement.
>>
>> I should also be honest about what I could offer: only what the SSD1677
>> and the PIXPAPER 4.26m need, arranged so that further controllers can be
>> added on top.  This panel is the only SSD16xx hardware I have, so I could
>> not implement or test the others.  If that is too small a starting point,
>> I quite understand.
>>
> That's OK. When I introduced the ssd130x driver, it only supported the
> SSD1306 controller and over time we added suppport for more ICs and
> 13xx families.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


