Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B98CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3CB10F4FC;
	Tue, 13 Oct 2026 07:17:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085FA10E06A;
 Tue, 13 Oct 2026 07:17:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F7AE21FB2;
 Tue, 13 Oct 2026 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9GRXjGXRt/q/HxuWkxPseQ4KtI+fT1Tq5zTQgNNZ9vY=;
 b=TGj7CUKDtlQdLASI640ZVyLewoboYsEUv4xinlalReMj5YNfCxFvRY/8DkPK6jaE/sn+KR
 7cmv2I6EV0nA1M3rmxT0hu0pRoJjWG6q2DCspDfD2pFhAsxLayzgAzj4TDFsBBArA1ABYT
 KG30NEK2P5+iAWemrKXYoLSlzx5FT38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9GRXjGXRt/q/HxuWkxPseQ4KtI+fT1Tq5zTQgNNZ9vY=;
 b=N37FWVUBgsNarlEEBLOGT796YUCZ2FenpYnVP8TcsDdhaH5ECafa1HVKltRmugPJIOmd6y
 AwlCX7PAhGVRN3BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9GRXjGXRt/q/HxuWkxPseQ4KtI+fT1Tq5zTQgNNZ9vY=;
 b=TGj7CUKDtlQdLASI640ZVyLewoboYsEUv4xinlalReMj5YNfCxFvRY/8DkPK6jaE/sn+KR
 7cmv2I6EV0nA1M3rmxT0hu0pRoJjWG6q2DCspDfD2pFhAsxLayzgAzj4TDFsBBArA1ABYT
 KG30NEK2P5+iAWemrKXYoLSlzx5FT38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9GRXjGXRt/q/HxuWkxPseQ4KtI+fT1Tq5zTQgNNZ9vY=;
 b=N37FWVUBgsNarlEEBLOGT796YUCZ2FenpYnVP8TcsDdhaH5ECafa1HVKltRmugPJIOmd6y
 AwlCX7PAhGVRN3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637001349D;
 Tue, 13 Oct 2026 07:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VjHzA/7azWqSVAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 13 Oct 2026 07:17:18 +0000
Message-ID: <d93fe93e-628c-4551-9907-9872c150e530@suse.de>
Date: Tue, 13 Oct 2026 09:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] drm: consolidate self-imported PRIME dma-buf
 detection
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
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
In-Reply-To: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.997];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
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

I don't think we should merge this series.

Testing for the functions struct is a hack, which we do because it works 
in practice. We don't any other good identifier for the source of the 
imported dma_buf. We want to hide this from the outside world as much as 
possible. Putting it into an exported interface goes in the wrong direction.

Best regards
Thomas


Am 13.10.26 um 03:06 schrieb Niranjana Vishwanathapura:
> Detecting that a PRIME dma-buf being imported was exported by the same
> DRM device is a pattern currently open-coded in many drivers (compare
> dma_buf->ops against the driver's own ops, check obj->dev == dev, then
> return the GEM object with an extra reference). This series adds generic
> helpers for it and converts several drivers to use them.
>
> Patch 1 adds drm_gem_prime_self_import(dev, dma_buf, ops): for a dma-buf
> self-exported via the given ops, it returns the backing GEM object with
> a reference, letting a driver short-circuit the generic PRIME import and
> skip the extra dma-buf file reference. Patch 2 converts Xe to it.
>
> Patch 3 adds drm_gem_prime_dma_buf_to_gem(), a thin wrapper that uses the
> core PRIME ops, and replaces the drm_gem_is_prime_exported_dma_buf() bool
> predicate with it so the shmem importer resolves the object directly
> (the sole caller already wanted the referenced object).
>
> Patches 4-6 convert panthor, panfrost and amdgpu to
> drm_gem_prime_self_import(), removing the duplicated open-coded checks.
>
> No intended functional change.
>
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>
> Farah Kassabri (2):
>    drm/gem: add helper to detect self-imported PRIME dma-bufs
>    drm/xe/dma-buf: Use drm helper to detect dma-buf self-import
>
> Niranjana Vishwanathapura (4):
>    drm/gem: add drm_gem_prime_dma_buf_to_gem() self-import helper
>    drm/panthor: use drm_gem_prime_self_import() helper
>    drm/panfrost: use drm_gem_prime_self_import() helper
>    drm/amdgpu: use drm_gem_prime_self_import() helper
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +---
>   drivers/gpu/drm/drm_gem_shmem_helper.c      | 14 ++--
>   drivers/gpu/drm/drm_prime.c                 | 74 +++++++++++++++------
>   drivers/gpu/drm/panfrost/panfrost_gem.c     | 10 +--
>   drivers/gpu/drm/panthor/panthor_gem.c       | 10 +--
>   drivers/gpu/drm/xe/xe_dma_buf.c             | 23 ++++---
>   drivers/gpu/drm/xe/xe_dma_buf.h             |  2 +
>   include/drm/drm_prime.h                     |  8 ++-
>   8 files changed, 91 insertions(+), 64 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


