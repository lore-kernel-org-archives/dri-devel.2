Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFAA606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eOvBRRYQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L4XT2nUn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TXzzxD3Z;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lNZndVHM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7963F10E61F;
	Fri, 23 Oct 2026 10:53:25 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A769A10E625
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:53:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EED2621F81;
 Fri, 23 Oct 2026 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792752792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ck5538vplGRYzOsXA+G4AVyxQSUzsoSCXDYUVK14jME=;
 b=eOvBRRYQTqg5EuKrtxgapxGZcDC17kg2J4nCBhEsLhEH5NLGi0A7h/FbAiYKA6haYiHrxV
 o6//rg7i0cSMHxNugnVS+cyez8/3MGPNLu78nxj3QSK+DpYZb75qmdxifiuWxcn5bf+x9G
 m9p5IrUonWJIGFaCoA7qcAjA2FyZCZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792752792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ck5538vplGRYzOsXA+G4AVyxQSUzsoSCXDYUVK14jME=;
 b=L4XT2nUnSPUfJ8Loybl573SFzF3mmzLUDJ9alg9QAlnBrCxuKgmhn/8tVb670aK1hb8EAC
 MM8x7NitS1Kxn2AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TXzzxD3Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lNZndVHM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792752791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ck5538vplGRYzOsXA+G4AVyxQSUzsoSCXDYUVK14jME=;
 b=TXzzxD3ZWA5m80AdBe1KVKPkfo6s0mpc4Jfzhnlrme+iDMxc5zjyVpFSCspTIMFBide7O/
 JXA5Et+SN7/hzb61V5yel+ujGXV/8wH3w+Lh+ouWP3K6iPIvQZYchv6D2jmi5rx6qXDUrU
 ZzQf3Q4i8AsQhRGoxBbjCXfe+cdgh+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792752791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ck5538vplGRYzOsXA+G4AVyxQSUzsoSCXDYUVK14jME=;
 b=lNZndVHM/iB8O2V09NPM4If9ftbMhR9jT4X53JSmomlvBQpcS58qAuP+Rb8tMN4s6douX/
 4z+bQ0dZxi8VdvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CF8A133F3;
 Fri, 23 Oct 2026 10:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qZptD5c822oCIwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 10:53:11 +0000
Message-ID: <baaf7d18-ade1-48ad-a7f6-03769a3178d4@suse.de>
Date: Fri, 23 Oct 2026 12:53:10 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: Don't print a NULL firmware config mode
To: Hugo Sales <hugo@hsal.es>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20261022114356.669988-1-hugo@hsal.es>
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
In-Reply-To: <20261022114356.669988-1-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: EED2621F81
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



Am 22.10.26 um 13:43 schrieb Hugo Sales:
> When some tiles of a tiled display are missing,
> drm_client_firmware_config() replaces the connector's mode with
> drm_connector_fallback_non_tiled_mode(). That returns NULL when
> connector->modes has no mode other than the tile size, but the debug
> message after it still reads modes[i]->name. Accessing a member through
> a NULL pointer is undefined behaviour. Today printk happens to get an
> address below PAGE_SIZE and prints "(efault)"
>
> Print which step found no mode instead, "no non tiled mode found" in
> this case, from the mode_type the function already tracks. A connector
> whose mode is NULL is skipped by drm_client_modeset_probe(), so it is
> left off, as before
>
> Sashiko found this while reviewing a series that makes the fallback
> return NULL more often, by also skipping modes larger than the client
>
> Fixes: cf1d0180f571 ("drm/fbdev: Fallback to non tiled mode if all tiles not present")
> Link: https://lore.kernel.org/all/sashiko-outbox-173425@kernel.org/
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> Sashiko found this while reviewing my fbdev probe series:
> https://lore.kernel.org/all/20261015212545.1989962-1-hugo@hsal.es/
> That series makes the fallback return NULL more often
>
> I ran checkpatch and built drm_client_modeset.o with W=1
>
>   drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 0080a8e9556a..a8cbe4c0e166 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -754,10 +754,15 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
>   		}
>   		crtcs[i] = crtc;
>   
> -		drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
> -			    connector->base.id, connector->name,
> -			    crtc->base.id, crtc->name,
> -			    mode_type, modes[i]->name);
> +		if (modes[i])
> +			drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
> +				    connector->base.id, connector->name,
> +				    crtc->base.id, crtc->name,
> +				    mode_type, modes[i]->name);
> +		else
> +			drm_dbg_kms(dev, "[CONNECTOR:%d:%s] on [CRTC:%d:%s] no %s mode found\n",
> +				    connector->base.id, connector->name,
> +				    crtc->base.id, crtc->name, mode_type);

That seems excessive. Can you use   modes[i] ? modes[i]->name : 
"(none)"  for the final argument?

Best regards
Thomas

>   
>   		fallback = false;
>   		conn_configured |= BIT(i);
>
> base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


