Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C5F3380D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2F810E50A;
	Tue, 17 Mar 2026 07:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="XeZvAsUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7tdgEEQp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="htgkywmr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MWPMyPZr";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A310610E50A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:41:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E20AA5BD6C;
 Tue, 17 Mar 2026 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773733297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOpM9G5XX/FMKB0wxhH8bIY/0XRzuMg5WCnKfroc8lY=;
 b=XeZvAsUaaDbmkRWkHoXelO0Qsy1lBmf1fkQrYAIpG45XLEeKVVa4XQrZU8MicS2BhWUM+/
 Rp9ZzcpvNTz3pRMtyDv0Fjk7XB+SRd3pYZKS0kezajY2/KnEI2k0Ur6FP2lSMZu5tIbBOe
 gy654NI7thD5sDEM0xjh6L/lM/4qXlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773733297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOpM9G5XX/FMKB0wxhH8bIY/0XRzuMg5WCnKfroc8lY=;
 b=7tdgEEQpeSeGoU+8iHt4wDenweOERqXBcDY6n1ZFr8pZ13MhI3refQyu3RCpwDJojutFbW
 6EsEqoczaAtlZuCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=htgkywmr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MWPMyPZr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773733295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOpM9G5XX/FMKB0wxhH8bIY/0XRzuMg5WCnKfroc8lY=;
 b=htgkywmrEfSaJJQvd1PGuz00EeOHlq9CoE9W5ZLT6UnWuI0EPbNJ23d11HZxIlvKpsY1Kk
 VP2qYcDt7a6vcY0Ozx8HgFs//vohZ1hksHOOXzQ6tfBLy9uo6At1KRcbTPexv2DFNwnSrl
 gugdjfzbSsxdMzjzyQxzXzuj0iiTy9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773733295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOpM9G5XX/FMKB0wxhH8bIY/0XRzuMg5WCnKfroc8lY=;
 b=MWPMyPZr/xpQlIX2Vi6SNAw781wEW2e2GRX0xHExBg/JZItsJcmt0zbIrmafepiMdmS8TJ
 zYGGt8oSi3KaBAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E74A4273B;
 Tue, 17 Mar 2026 07:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F/paIa8FuWn9NgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Mar 2026 07:41:35 +0000
Message-ID: <7b91451a-7764-4822-b15b-47437592691f@suse.de>
Date: Tue, 17 Mar 2026 08:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie
 <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
 <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
 <abj-J1yYsFymXmn5@intel.com>
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
In-Reply-To: <abj-J1yYsFymXmn5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[aspeedtech.com,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, aspeedtech.com:email, suse.com:url, suse.de:dkim,
 suse.de:mid, suse.de:email]
X-Rspamd-Queue-Id: E20AA5BD6C
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

Am 17.03.26 um 08:09 schrieb Ville Syrjälä:
> On Mon, Mar 16, 2026 at 01:38:22PM +0200, Jani Nikula wrote:
>> On Mon, 16 Mar 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>> Hi Jammy
>>>
>>> Am 13.03.26 um 11:04 schrieb Jammy Huang:
>>>> DisplayPort supports edid at most 256 bytes. Thus, allow it to fetch
>>>> edid block 0 and 1.
>>>>
>>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>>> ---
>>>> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
>>>> blocks fetched can be 0 and 1.
>>>> ---
>>>>    drivers/gpu/drm/ast/ast_dp.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
>>>> index 9d07dad358c..c938e1d6b1d 100644
>>>> --- a/drivers/gpu/drm/ast/ast_dp.c
>>>> +++ b/drivers/gpu/drm/ast/ast_dp.c
>>>> @@ -88,7 +88,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
>>>>    	int ret = 0;
>>>>    	unsigned int i;
>>>>    
>>>> -	if (block > 0)
>>>> +	if (block > 1)
>>>>    		return -EIO; /* extension headers not supported */
>>> But see the code at [1]. It clears the number of extensions to zero and
>>> updates the checksum accordingly. This is required to make the shortened
>>> EDID work with DRM. If you leave this as-is, it will still clear support
>>> for any extension in block 1.
>>>
>>> See the table 2.4 in the VESA EDID 1.4 standard for the semantics. For
>>> 1.3, if the number of blocks is >2, the first extensions is a 'block map
>>> of the extensions'. This is useless, as it's not a data extension in
>>> itself.  In 1.4, the block map is optional. That code should clear the
>>> EDID's number of extensions to 0 or 1, depending on whether there is a
>>> block map to be expected.
>> I think long-term the goal should be for the kernel to not modify the
>> EDID, at all.
> I think as a short term goal it would be much better if all EDID
> mangling would be done by drm_edid.c rather than individual drivers.

We don't fix the EDID here, but work around a hardware limitation. I 
guess we could fix this automatically near edid_block_read() [1] if the 
driver clearly communicates this issue.  The read loop could then fix 
the header's checksum by itself.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.c#L2424

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


