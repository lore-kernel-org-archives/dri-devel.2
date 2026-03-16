Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DA7F013C5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2385A10E269;
	Mon, 16 Mar 2026 08:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="nfSi1b2H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UD++Nzzw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BW99Mee8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5MDH1G7T";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD33A10E269
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:02:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 63CC15BCC8;
 Mon, 16 Mar 2026 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773648123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9eZUGESBd77QL69gi3hXEIqZeUdORtEc85lC8YEmvc=;
 b=nfSi1b2HG2nrP7FEPu9K/MSPk+fn71yqqFXANC1fTJxFRfPEdbJSmOI3JTZeoYqPvEp3Cc
 /7gh9K8S9kJAqyUNc3Db2d9EXHsMwRC7V4IU91isETK7E2stIoS6pQDvjks+AjZTk6fmco
 hCIZl6Fv+0VDcAOo7+Kn9MAaYqq36IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773648123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9eZUGESBd77QL69gi3hXEIqZeUdORtEc85lC8YEmvc=;
 b=UD++NzzwnGm6YzoyBxcihucq20l1IVnVfAfFYF9X+c90/mpyheD5tR2IlrOikP7eow/JCW
 13DjPb0HWWE0htBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BW99Mee8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5MDH1G7T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773648122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9eZUGESBd77QL69gi3hXEIqZeUdORtEc85lC8YEmvc=;
 b=BW99Mee8ujFTqLX3NN9v3t4T0eKsPtmG8RXqllYsLziSIWVFXBn/KiB9WmB9KfS+/roERM
 WLl//Ru8owVy+c3nU11UdsxYb20WVXc9iVXGWmTNk/6z9ILHD50YPqXBt+775zRFqsxPs4
 htK2oL+gmxteEEYstcsmnHc6a2JLEBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773648122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9eZUGESBd77QL69gi3hXEIqZeUdORtEc85lC8YEmvc=;
 b=5MDH1G7TF6FUlDKDIonJyYHQUU2qJ6Y9OgCGQRjkUKh1FObVxY2gxTvF+r3djsg3eU7A17
 vwVcpJgLEN2Yu7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C5934273B;
 Mon, 16 Mar 2026 08:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VkupAPq4t2kTQAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 08:02:02 +0000
Message-ID: <3312781e-6d81-47d7-a1fd-c0ff6da3db10@suse.de>
Date: Mon, 16 Mar 2026 09:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] drm/st7586: Use regular atomic helpers; drop
 simple-display helpers
To: David Lechner <david@lechnology.com>, javierm@redhat.com,
 lanzano.alex@gmail.com, kamlesh.gurudasani@gmail.com,
 architanant5@gmail.com, wens@kernel.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260311101438.365997-1-tzimmermann@suse.de>
 <20260311101438.365997-12-tzimmermann@suse.de>
 <1daa2dcd-bc77-476d-80ad-bb517cd1d575@lechnology.com>
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
In-Reply-To: <1daa2dcd-bc77-476d-80ad-bb517cd1d575@lechnology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 63CC15BCC8
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

Am 16.03.26 um 00:49 schrieb David Lechner:
> On 3/11/26 5:10 AM, Thomas Zimmermann wrote:
>> Replace simple-display helpers with regular atomic helpers. Store the
>> pipeline elements in struct st7586_device and initialize them as part
>> of probing the device. Use mipi-dbi's existing helpers and initializer
>> macros where possible.
>>
>> Effectively open-codes the modesetting code in the initializer helpers
>> of mipi-dbi and simple-display. St7586 requires custom helpers for
>> various pipeline elements, and non-freeing cleanup of the pipeline.
>>
>
> ...
>
>> +static void st7586_plane_helper_atomic_update(struct drm_plane *plane,
>> +					      struct drm_atomic_state *state)
>>   {
>> -	struct drm_plane_state *state = pipe->plane.state;
>> -	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>> -	struct drm_framebuffer *fb = state->fb;
>> +	struct drm_plane_state *plane_state = plane->state;
>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>> +	struct drm_framebuffer *fb = plane_state->fb;
>> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>   	struct drm_rect rect;
>>   	int idx;
>>   
>> -	if (!pipe->crtc.state->active)
>> +	if (!fb)
>>   		return;
>>   
>> -	if (!drm_dev_enter(fb->dev, &idx))
>> -		return;
> What was wrong with returning early here?

Nothing. Putting the affected code into a single block just seems to 
make the code better structured. But we can go back to the old style, if 
preferred.

Best regards
Thomas

>
>> +	if (drm_dev_enter(plane->dev, &idx)) {
>> +		if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
>> +			st7586_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
>> +					&shadow_plane_state->fmtcnv_state);
>> +		drm_dev_exit(idx);
>> +	}
>> +}
>>   
>> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>> -		st7586_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
>> -				&shadow_plane_state->fmtcnv_state);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


