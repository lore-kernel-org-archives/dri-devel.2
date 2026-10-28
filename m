Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46243606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0jzJmEB6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZLbG6QWT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F1yVvb+2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SgB2qKBt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEB110E5A9;
	Wed, 28 Oct 2026 07:32:56 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08CC810E5A9
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 07:32:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAFCA1FB2F;
 Wed, 28 Oct 2026 07:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793172763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OgQ00LMkKOEf/w7KG8UarNJ4BLmuw00CCH60+a7Qn+A=;
 b=0jzJmEB6QvbuGKv1vnM2PFtVpyMbsqG00A96jcewZwkPxhoPbvCK9uWLJ2jUQU25k70Jdm
 bxQjpNf1h9KT05nraMQ+FTW5GAHy6IT358uVW+x19Z1ntTwaBH7tBlmoww6NkB0lJu1Uay
 ZjUqFgCx5V+sVLWkwSn43U9jHtGUaYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793172763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OgQ00LMkKOEf/w7KG8UarNJ4BLmuw00CCH60+a7Qn+A=;
 b=ZLbG6QWToacLlT++K/QaWyARob2NTe0MWJaPplmvY5m6c1ChJh5FMmRUVyY1J/+OaJfxJk
 9Z31vzWHOIT6DJAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F1yVvb+2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SgB2qKBt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793172761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OgQ00LMkKOEf/w7KG8UarNJ4BLmuw00CCH60+a7Qn+A=;
 b=F1yVvb+2xRt8UJKSMny32GR8Ma70Z3fAGsLr2YUNi6wWESJvJv+8tAowRqqqCOrXf2Nlfz
 LKiPluglj5vJPWcvstE8CMxBadKoF5swMFKOYGjRm8Se3LBqmPnRaM5lEiyhQXfWZhGGrv
 Jkw4SzBHwv4HkG7r7g+PZFXRbHplKpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793172761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OgQ00LMkKOEf/w7KG8UarNJ4BLmuw00CCH60+a7Qn+A=;
 b=SgB2qKBtgqD6FIP6h72D3bnS/oY20OEDtm/8cvb4mEO6pSF42SwkNYy+1ih9n+5SaopPSY
 b5obocv/SYtICzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E32B1321C;
 Wed, 28 Oct 2026 07:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S6OLDhml4WqoRAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 28 Oct 2026 07:32:41 +0000
Message-ID: <5bde0cb8-6e5a-4df7-af7d-3e67dd27130e@suse.de>
Date: Wed, 28 Oct 2026 08:32:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/udl: fail fast on stalled URB pool
To: oushixiong1025@163.com
Cc: Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20261028061328.395798-1-oushixiong1025@163.com>
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
In-Reply-To: <20261028061328.395798-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAFCA1FB2F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[163.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,poorly.run,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, kylinos.cn:email]
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 28.10.26 um 07:13 schrieb oushixiong1025@163.com:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> A stalled device never returns its URBs, so every allocation waited
> out the full timeout and stalled the display stack on each operation.
> Flag the stall and fail fast until an URB comes back; give damage a
> short timeout and keep the long one for modeset.

I'm not comfortable with merging this change. It's nigh impossible to 
test.  It could also break a working set up if there's some temporary 
contention on the USB.

Best regards
Thomas


>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/udl/udl_drv.h      | 14 +++++++++++++-
>   drivers/gpu/drm/udl/udl_main.c     | 30 +++++++++++++++++++++++++-----
>   drivers/gpu/drm/udl/udl_modeset.c  |  6 +++---
>   drivers/gpu/drm/udl/udl_transfer.c |  2 +-
>   4 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> index 145bb95ccc48..43cff97e12f7 100644
> --- a/drivers/gpu/drm/udl/udl_drv.h
> +++ b/drivers/gpu/drm/udl/udl_drv.h
> @@ -11,6 +11,7 @@
>   #ifndef UDL_DRV_H
>   #define UDL_DRV_H
>   
> +#include <linux/jiffies.h>
>   #include <linux/mm_types.h>
>   #include <linux/usb.h>
>   
> @@ -46,6 +47,7 @@ struct urb_list {
>   	int available;
>   	int count;
>   	size_t size;
> +	bool wedged;
>   };
>   
>   struct udl_device {
> @@ -72,7 +74,17 @@ static inline struct usb_device *udl_to_usb_device(struct udl_device *udl)
>   int udl_modeset_init(struct udl_device *udl);
>   struct drm_connector *udl_connector_init(struct drm_device *dev);
>   
> -struct urb *udl_get_urb(struct udl_device *udl);
> +/*
> + * How long to wait for a free URB before giving up.  The damage path runs
> + * on every atomic update, so keep its timeout short: a stalled device never
> + * returns its URBs and the wait would otherwise stall the whole display
> + * stack on every operation.  Modeset is low-frequency and worth waiting
> + * longer for.  Once the pool is flagged wedged, neither path blocks at all.
> + */
> +#define UDL_GET_URB_TIMEOUT_DAMAGE	msecs_to_jiffies(100)
> +#define UDL_GET_URB_TIMEOUT_MODESET	msecs_to_jiffies(2000)
> +
> +struct urb *udl_get_urb(struct udl_device *udl, long timeout);
>   
>   int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len);
>   void udl_sync_pending_urbs(struct udl_device *udl);
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index 17950fe3a0ec..b92cd5300030 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -169,6 +169,7 @@ void udl_urb_completion(struct urb *urb)
>   	spin_lock_irqsave(&udl->urbs.lock, flags);
>   	list_add_tail(&unode->entry, &udl->urbs.list);
>   	udl->urbs.available++;
> +	udl->urbs.wedged = false;
>   	spin_unlock_irqrestore(&udl->urbs.lock, flags);
>   
>   	wake_up(&udl->urbs.sleep);
> @@ -213,6 +214,7 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>   	init_waitqueue_head(&udl->urbs.sleep);
>   	udl->urbs.count = 0;
>   	udl->urbs.available = 0;
> +	udl->urbs.wedged = false;
>   
>   retry:
>   	udl->urbs.size = size;
> @@ -265,16 +267,34 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
>   
>   	assert_spin_locked(&udl->urbs.lock);
>   
> +	/* A device that stopped completing transfers will never wake us up:
> +	 * fail fast instead of stalling callers for the full timeout on every
> +	 * call.  Allocations for teardown (MAX_SCHEDULE_TIMEOUT) still wait,
> +	 * since the USB core returns all URBs on disconnect.
> +	 */
> +	if (udl->urbs.wedged && timeout != MAX_SCHEDULE_TIMEOUT) {
> +		if (list_empty(&udl->urbs.list))
> +			return NULL;
> +		goto take;
> +	}
> +
>   	/* Wait for an in-flight buffer to complete and get re-queued */
>   	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
>   					 !udl->urbs.count ||
>   					 !list_empty(&udl->urbs.list),
>   					 udl->urbs.lock, timeout)) {
> -		DRM_INFO("wait for urb interrupted: available: %d\n",
> -			 udl->urbs.available);
> +		if (timeout == MAX_SCHEDULE_TIMEOUT) {
> +			DRM_INFO("wait for urb interrupted: available: %d\n",
> +				 udl->urbs.available);
> +		} else {
> +			udl->urbs.wedged = true;
> +			drm_warn_ratelimited(&udl->drm,
> +				"no URB returned within %u ms (available %d); device stalled, dropping frames\n",
> +				jiffies_to_msecs(timeout), udl->urbs.available);
> +		}
>   		return NULL;
>   	}
> -
> +take:
>   	if (!udl->urbs.count)
>   		return NULL;
>   
> @@ -285,12 +305,12 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
>   	return unode->urb;
>   }
>   
> -struct urb *udl_get_urb(struct udl_device *udl)
> +struct urb *udl_get_urb(struct udl_device *udl, long timeout)
>   {
>   	struct urb *urb;
>   
>   	spin_lock_irq(&udl->urbs.lock);
> -	urb = udl_get_urb_locked(udl, HZ * 2);
> +	urb = udl_get_urb_locked(udl, timeout);
>   	spin_unlock_irq(&udl->urbs.lock);
>   	return urb;
>   }
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 289711035b67..c907846048f8 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -218,7 +218,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
>   		return ret;
>   	log_bpp = ret;
>   
> -	urb = udl_get_urb(udl);
> +	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_DAMAGE);
>   	if (!urb)
>   		return -ENOMEM;
>   	cmd = urb->transfer_buffer;
> @@ -342,7 +342,7 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
>   	if (!drm_dev_enter(dev, &idx))
>   		return;
>   
> -	urb = udl_get_urb(udl);
> +	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_MODESET);
>   	if (!urb) {
>   		drm_err_ratelimited(dev, "get urb failed when enabling crtc\n");
>   		goto out;
> @@ -377,7 +377,7 @@ static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_ato
>   	if (!drm_dev_enter(dev, &idx))
>   		return;
>   
> -	urb = udl_get_urb(udl);
> +	urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_MODESET);
>   	if (!urb)
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/udl/udl_transfer.c b/drivers/gpu/drm/udl/udl_transfer.c
> index 7d670b3a5293..bfff17bba58d 100644
> --- a/drivers/gpu/drm/udl/udl_transfer.c
> +++ b/drivers/gpu/drm/udl/udl_transfer.c
> @@ -202,7 +202,7 @@ int udl_render_hline(struct udl_device *udl, int log_bpp, struct urb **urb_ptr,
>   			int ret = udl_submit_urb(udl, urb, len);
>   			if (ret)
>   				return ret;
> -			urb = udl_get_urb(udl);
> +			urb = udl_get_urb(udl, UDL_GET_URB_TIMEOUT_DAMAGE);
>   			if (!urb)
>   				return -EAGAIN;
>   			*urb_ptr = urb;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


