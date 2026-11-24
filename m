Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mmUD+xsu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=97c8Gm65;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=no7xFE9k;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XvYNRNNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D76010E864;
	Tue, 24 Nov 2026 13:09:12 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC8210E864
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:09:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C79711F7CD;
 Tue, 24 Nov 2026 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795525740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WcJSkaqY9Qq8Hd92McHt9i07oPBgHaZhYiQd4F7xNFM=;
 b=mmUD+xsuUa7B/iXxIoqUvGyM9xNrE4ua0l7iAxS2Y2M4GtqqEM1XZb2WmCf3R/1AQcQUns
 R8p59avmbySAHfYg12Ab/nfBoP+gF9UK5o+ZmznsSD3TG41YbJKyeD7j8DkDDROSQ3xPK3
 QrSlmxbpTqkIOujibWP/aRmmB9859bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795525740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WcJSkaqY9Qq8Hd92McHt9i07oPBgHaZhYiQd4F7xNFM=;
 b=97c8Gm65I5xaQNqWkHPOaWRh+xRBvHI5FL66vC6xwgctIrr1cl2kCnl16LzS/ZoPm5Dhla
 SdHo7QUcZiqvO6Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=no7xFE9k;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XvYNRNNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795525739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WcJSkaqY9Qq8Hd92McHt9i07oPBgHaZhYiQd4F7xNFM=;
 b=no7xFE9kf7JGQKe28BZel4ShYaE4zzTL5BIak1zW8v/xo5GPsr/s6sydUbEGQhfrHAYadS
 QaPpvH2QACCd1dCbW6K34s1EGrihvQBlJkq78AYmE3Dc3zNRA2WinzgizDD2RhMFr5tkBJ
 HTESxp7jut2xaGEIOPCp5knzhztoMt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795525739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WcJSkaqY9Qq8Hd92McHt9i07oPBgHaZhYiQd4F7xNFM=;
 b=XvYNRNNJXqCs9b455USCCnF4QILvmlgIMu6KafQN/mRztUDTVN1o3Xzh/fd/1U8vj1NUT1
 O8nXZ7CNrzNImrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D1B813505;
 Tue, 24 Nov 2026 13:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zsLdNWqMBWt+MQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Nov 2026 13:08:59 +0000
Message-ID: <93890802-060e-4369-842e-2a02bbd2042c@suse.de>
Date: Tue, 24 Nov 2026 14:08:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 2/5] drm/fb-dma-helper: Add
 drm_fb_dma_get_gem_clipped_addr()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261124074041.115251-1-wenst@chromium.org>
 <20261124074041.115251-3-wenst@chromium.org>
 <19cd5949-05dc-4107-bd2b-d8ad1e2332eb@suse.de>
 <CAGXv+5HSV7MJ96qTcOp+JaKWtmmYYWAmDROrT18pZ9PztNCJ-g@mail.gmail.com>
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
In-Reply-To: <CAGXv+5HSV7MJ96qTcOp+JaKWtmmYYWAmDROrT18pZ9PztNCJ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[17]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nxp.com,oss.nxp.com,pengutronix.de,kernel.org,sholland.org,linux.intel.com,gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: C79711F7CD
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 24.11.26 um 11:22 schrieb Chen-Yu Tsai:
> On Tue, Nov 24, 2026 at 3:57 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 24.11.26 um 08:39 schrieb Chen-Yu Tsai:
>>> drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
>>> framebuffer. However some display drivers want the "clipped" framebuffer
>>> instead, as they are also using the clipped coordinates to program the
>>> hardware.
>>>
>>> Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
>>> the source coordinates replaced, while others have been incorrectly
>>> converted to using drm_fb_dma_get_gem_addr(), which would end up
>>> causing incorrect parts of the framebuffer to be displayed if it were
>>> somehow clipped.
>>>
>>> Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
>>> drm_fb_dma_get_gem_addr() for these drivers to use.
>>>
>>> Cc: <stable@vger.kernel.org> # dependency for next patch
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since v1:
>>> - Use new drm_framebuffer_get_block_offset() helper
>>> ---
>>>    drivers/gpu/drm/drm_fb_dma_helper.c | 37 +++++++++++++++++++++++++----
>>>    include/drm/drm_fb_dma_helper.h     |  4 ++++
>>>    2 files changed, 37 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
>>> index ab0f37d8a5ff..0aaf4926db4e 100644
>>> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
>>> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
>>> @@ -60,15 +60,16 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(struct drm_framebuffer *fb,
>>>    EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
>>>
>>>    /**
>>> - * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, for pixel
>>> - * formats where values are grouped in blocks this will get you the beginning of
>>> - * the block
>>> + * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped framebuffer,
>>> + * for pixel formats where values are grouped in blocks this will get you the
>>> + * beginning of the block
>>>     * @fb: The framebuffer
>>>     * @state: Which state of drm plane
>>>     * @plane: Which plane
>>> - * Return the DMA GEM address for given framebuffer.
>>>     *
>>>     * This function will usually be called from the PLANE callback functions.
>>> + *
>>> + * Return: GEM DMA address for given framebuffer, unclipped.
>>>     */
>>>    dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>>>                                   struct drm_plane_state *state,
>>> @@ -86,6 +87,34 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>>>    }
>>>    EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
>>>
>>> +/**
>>> + * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipped
>>> + * framebuffer, for pixel formats where values are grouped in blocks this
>>> + * will get you the beginning of the block
>>> + * @fb: The framebuffer
>>> + * @state: Which state of drm plane
>>> + * @plane: Which plane
>>> + *
>>> + * This function will usually be called from the PLANE callback functions.
>> You should mention what clipping means in this context. It's not obvious
>> what it's clipping against. Or maybe point to other docs that explain it.
> What about:
>
> /**
>   * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for the start
>   * of the visible (CRTC-clipped) part of the framebuffer
>   * @fb: The framebuffer
>   * @state: Which state of drm plane
>   * @plane: Which plane
>   *
>   * A plane may be positioned partially off-screen, in which case it gets
>   * clipped to the visible CRTC area by drm_atomic_helper_check_plane_state()
>   * (populating the clipped coordinates in &drm_plane_state.src and
>   * &drm_plane_state.dst). For example, if a plane extends past the left or
>   * top edge of the screen, only its right and/or bottom portion is visible.
>   * Drivers whose hardware cannot clip by itself (i.e. accept negative
>   * destination coordinates) should use this helper instead of
>   * drm_fb_dma_get_gem_addr() so scanout starts from the visible portion of
>   * the framebuffer.
>   *
>   * For pixel formats where values are grouped in blocks, this returns the
>   * beginning of the block.
>   *
>   * This function will usually be called from the PLANE callback functions.
>   *
>   * Return: GEM DMA address for the visible part of the framebuffer.
>   */

Looks good.

>
>>> + *
>>> + * Return: GEM DMA address for given framebuffer, clipped.
>>> + */
>>> +dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
>>> +                                        struct drm_plane_state *state,
>>> +                                        unsigned int plane)
>>> +{
>>> +     struct drm_gem_dma_object *obj;
>>> +
>>> +     obj = drm_fb_dma_get_gem_obj(fb, plane);
>>> +     if (!obj)
>>> +             return 0;
>>> +
>>> +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
>>> +                                                             state->src.x1 >> 16,
>>> +                                                             state->src.y1 >> 16);
>> I had to look several times to spot the difference to the regular
> I suppose I should add a comment to make the difference more visible:
>
>      /* Use clipped source coordinates state->src.[xy]1 instead ->src_[xy] */

Your choice.

>
>> helper. In any case
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> If the changes above are acceptable to you I'll send out a new version
> with your tag kept.

Sure, go ahead.

Best regards
Thomas

>
>
> Thanks
> ChenYu

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


