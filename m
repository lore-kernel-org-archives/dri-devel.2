Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA6BC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F406810E935;
	Tue, 25 Aug 2026 08:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="GtZ7A56A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2IOcNjl4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mT02T1rm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rMuFyHjb";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13E910E934;
 Tue, 25 Aug 2026 08:04:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2054F1F7B4;
 Tue, 25 Aug 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787644989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6QbiygY5iShhauvkTuo+8pW+HCymPbATkAPpp9mm6Y8=;
 b=GtZ7A56AXk533T7hb0WZlDenwwyYIcxvWDAs0Si4OGZzLL/NIE9PDLF8DUrOoX9Md9ZT2V
 xKJ6cpoAgsEVneICh41847FlpLbIKHOxxG0uQZaAfrppeR8MqUT797j2o5K4lcE+Kf4s4L
 0luN4ESGlQioXnnd+4Oaeh52jryCUUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787644989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6QbiygY5iShhauvkTuo+8pW+HCymPbATkAPpp9mm6Y8=;
 b=2IOcNjl4+1CM/av9PHv7NyYlQiP4vcSZunXERPDaqTmkqOtQFFcW5rh2M3pM7SyJ7/aCUI
 sYqAZnY5iX/VeZBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mT02T1rm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rMuFyHjb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787644985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6QbiygY5iShhauvkTuo+8pW+HCymPbATkAPpp9mm6Y8=;
 b=mT02T1rm6QVnTaCmbaJHQDo/i21HMFLNigdnFOfbbc5UDvKzAFMQPub5OYsbynemTdtjjt
 p36NnQ7kRzh5hwTQtprrmNirDBqAZNYcA8z1Ddkrh8/bQfQGCH9JSUOEw93VlCTRB/gGoz
 fQEpYUmmyHJP7KtjK58Rv/sioXk9fYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787644985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6QbiygY5iShhauvkTuo+8pW+HCymPbATkAPpp9mm6Y8=;
 b=rMuFyHjbvzB2V4bhNUn/pQmlitoeC6NY/WoSQ0YVX93NQHd9bYTX98xWN5xY+Ct0IQHLro
 uCWK2kvlFCVCqaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959A713332;
 Tue, 25 Aug 2026 08:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kQfPHThMjWracwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 25 Aug 2026 08:03:04 +0000
Message-ID: <778c33e1-8391-48d0-bef4-97298e06d43d@suse.de>
Date: Tue, 25 Aug 2026 10:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] vga_switcheroo, drm: Push fbcon handling into DRM
 clients
To: lukas@wunner.de, jfalempe@redhat.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, lyude@redhat.com,
 dakr@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260709092215.168172-1-tzimmermann@suse.de>
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
In-Reply-To: <20260709092215.168172-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[21]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2054F1F7B4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

gentle ping for a review from the DRM side

Am 09.07.26 um 11:15 schrieb Thomas Zimmermann:
> Vga_switcheroo currently invokes fb_switch_outputs() to inform fbcon
> about switching of the physical outputs among framebuffer devices. But
> new DRM clients to not use fbdev/fbcon and might require their own
> vga_switcheroo support. Let's strictly separate them from each other.
>
> Remove fbdev/fbcon from vga_switcheroo. Introduce a pre_switch callback
> for vga_switcheroo clients to do the fbcon update. Allows for removing
> all direct interactions between vga_switcheroo and fbdev/fbcon.
>
> There are only four drivers that support vga_switcheroo: amdgpu,
> radeon, i915 and nouveau. Update each of them with the new callback.
> When vga_switcheroo now invokes pre_switch, each DRM driver forwards
> to aquire_outputs and lets the DRM clients handle the new outputs.
>
> At the same time, push the fbcon update into DRM's client for fbdev
> emulation. Do this with the new DRM client callback acquire_outputs,
> so that other clients can have their own handling of vga_switcheroo.
>
> Also replace the existing reprobe hook with post_switch for symetry.
> For nouveau, this is merely a rename of the helper function. The other
> drivers dor not implement reprobe.
>
> Tested with radeon on a notebook with Radeon HD 4225 and HD 5430.
>
> v2:
> - implement all of pre_switch in a single commit to avoid possible
>    deadlock in intermediate state (Sashiko)
> - fix erroneous docs (Sashiko)
>
> Thomas Zimmermann (7):
>    drm/edid: Include <linux/fb.h>
>    drm/client: Add acquire_outputs callback; implement for fbdev
>      emulation
>    vga_switcheroo: Add pre_switch callback to client ops
>    vga_switcheroo: Add post_switch callback to client ops
>    drm: Implement struct vga_switcheroo_client_ops.pre_switch
>    drm: Implement vga_switcheroo_client_ops.post_switch
>    vga-switcheroo: Remove unused interfaces
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++-
>   drivers/gpu/drm/clients/drm_fbdev_client.c | 23 ++++++++----
>   drivers/gpu/drm/drm_client_event.c         | 18 ++++++++++
>   drivers/gpu/drm/drm_edid.c                 |  1 +
>   drivers/gpu/drm/i915/i915_switcheroo.c     | 11 +++++-
>   drivers/gpu/drm/nouveau/nouveau_vga.c      | 28 +++++++++------
>   drivers/gpu/drm/radeon/radeon_device.c     |  9 ++++-
>   drivers/gpu/vga/vga_switcheroo.c           | 41 +++++-----------------
>   drivers/video/fbdev/core/fbcon.c           |  8 -----
>   include/drm/drm_client.h                   | 14 ++++++++
>   include/drm/drm_client_event.h             |  3 ++
>   include/linux/vga_switcheroo.h             | 29 ++++++++-------
>   12 files changed, 121 insertions(+), 73 deletions(-)
>
>
> base-commit: 88c6be63ac7e9238c7791977d3f496ce6623afe4

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


