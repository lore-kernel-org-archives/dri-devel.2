Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2359CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1926410EA28;
	Tue, 23 Jun 2026 09:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cHrytJOO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErFW24e8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cHrytJOO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ErFW24e8";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E10C10EA28
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:04:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04D6670696;
 Tue, 23 Jun 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782205463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h1kifrZeZK96pomCNrUCon+Yyo2hdBxXRm9KC8tFn5w=;
 b=cHrytJOO9Zw/xqeidzcTvOisvcRQBEJscVwmAqZSoF3B0k1gj6V0zeCU1e6VKfTZOS3g7G
 X8Qo8z/NEbh1txWpl2AvAwhJiQlsfKRw7c5/gt7aMioztLPI7AJ+KU10jH0JLVbcXs95NL
 ITFJJhkD08qOC79qW7fl8Olzim4y2a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782205463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h1kifrZeZK96pomCNrUCon+Yyo2hdBxXRm9KC8tFn5w=;
 b=ErFW24e8Cxe2fInJkUJLhQh53c6MS9lywb0VAY2X+4Gvg+Frnti8jIH9iRwx+R/G5pCMfN
 QEgoulzbOl0ycZCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cHrytJOO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ErFW24e8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782205463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h1kifrZeZK96pomCNrUCon+Yyo2hdBxXRm9KC8tFn5w=;
 b=cHrytJOO9Zw/xqeidzcTvOisvcRQBEJscVwmAqZSoF3B0k1gj6V0zeCU1e6VKfTZOS3g7G
 X8Qo8z/NEbh1txWpl2AvAwhJiQlsfKRw7c5/gt7aMioztLPI7AJ+KU10jH0JLVbcXs95NL
 ITFJJhkD08qOC79qW7fl8Olzim4y2a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782205463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h1kifrZeZK96pomCNrUCon+Yyo2hdBxXRm9KC8tFn5w=;
 b=ErFW24e8Cxe2fInJkUJLhQh53c6MS9lywb0VAY2X+4Gvg+Frnti8jIH9iRwx+R/G5pCMfN
 QEgoulzbOl0ycZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1AF0779A8;
 Tue, 23 Jun 2026 09:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JZAtLhZMOmrfbQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 09:04:22 +0000
Message-ID: <808d917d-28c4-4a84-a647-d5dc9123bd32@suse.de>
Date: Tue, 23 Jun 2026 11:04:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation from
 DT node
To: Thierry Reding <treding@nvidia.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-7-tzimmermann@suse.de> <ajlfgXEO4NR-TZ4s@orome>
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
In-Reply-To: <ajlfgXEO4NR-TZ4s@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 04D6670696
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh,lists.freedesktop.org,lists.linux.dev];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:dkim, suse.de:email,
 suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 22.06.26 um 18:17 schrieb Thierry Reding:
> On Mon, Jun 22, 2026 at 03:19:40PM +0200, Thomas Zimmermann wrote:
>> A DeviceTree panel node can specify the panel's rotation in steps
>> of 90 degrees. Set the DRM connector orientation from the field.
>> Do nothing if the field is missing or invalid.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/sysfb/simpledrm.c | 32 +++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
>> index a04f0c852ea4..b585d17ca817 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
>> @@ -221,6 +221,33 @@ simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_node *of_p
>>   	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
>>   }
>>   
>> +static enum drm_panel_orientation
>> +simplefb_get_panel_orientation_of(struct drm_device *dev, struct device_node *of_panel_node)
>> +{
>> +	int ret;
>> +	u32 rotation;
>> +
>> +	ret = of_property_read_u32(of_panel_node, "rotation", &rotation);
>> +	if (ret) {
>> +		drm_dbg(dev, "simplefb: cannot parse panel rotation: error %d\n", ret);
> Why is this debug level? Maybe we don't want an error if the property is
> absent, but if it really can't be parsed, why not print out a proper
> error?
>
>> +		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
>> +	}
>> +
>> +	switch (rotation) {
>> +	case 0:
>> +		return DRM_MODE_PANEL_ORIENTATION_NORMAL;
>> +	case 90:
>> +		return DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
>> +	case 180:
>> +		return DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
>> +	case 270:
>> +		return DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
>> +	default:
>> +		drm_dbg(dev, "simplefb: cannot parse panel rotation: value %u\n", rotation);
> Same here. Seems like we should be verbose when this contains an invalid
> value. DT checkers should catch these already, so if the invalid value
> makes it here, maybe we should sound the alarm.

Ok. The review bot told me about of_drm_get_panel_orientation(). I 
intent to reimplement this patch on top of that helper.

Best regards
Thomas

>
> Thierry

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


