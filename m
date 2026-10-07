Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DDCCA600B
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E0D10E523;
	Wed,  7 Oct 2026 08:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Ssbjsw4T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v2wavRSp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jmUXs98v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6tIaY+la";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE2D10E508;
 Wed,  7 Oct 2026 08:51:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0274821FAE;
 Wed,  7 Oct 2026 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791363108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zE9QU63Kyd2BQKaCH+tCvre/v3mOuovgWohNizg+yU=;
 b=Ssbjsw4TgygKdjms8a5/tvjkTw7Nu5Nr1J0TuZsmB7oqH02WALlMJk5Ouge3FRqOsKw7bd
 TUDd9SJbNX9UvnsSHK2WifJJ0V8664n7mJzLmQI3qjYLUhlRpRVQpkncO2FFJpoVJrZS9C
 PFy2XfCL/zF2j6o3a/t3vui54uTc8g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791363108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zE9QU63Kyd2BQKaCH+tCvre/v3mOuovgWohNizg+yU=;
 b=v2wavRSpoPDafERuVsh8m9L3IZGzso7lyI/OxTU27hqCJ7/9OJIYOUouCmFmd29nzshO5M
 rOo9IGu4Enpb3/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791363104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zE9QU63Kyd2BQKaCH+tCvre/v3mOuovgWohNizg+yU=;
 b=jmUXs98v6rIN5E03lzJF7C6a1hOyQrxrGZf40c1wklDdzK5PcHP4HSHmi3QOQ0tNQpPh0S
 i8rQJ3AmQCFF7kqi7iR4ireTr0H/VrTlVbdTcAItS4zUms94t3vxZXTmfnXmGpABF2Vwpw
 uL45J8YWmTE0gp6fcyhXqNJlb9bKRWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791363104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6zE9QU63Kyd2BQKaCH+tCvre/v3mOuovgWohNizg+yU=;
 b=6tIaY+lacV31th/x2Ymv0XumjtxeJOcN/1OJlnDMu59kIRNBDi7hq5FvRpLABc1GOLIQLJ
 /7POS14CxLJujEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64EC713354;
 Wed,  7 Oct 2026 08:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jIzVBh8Ixmo5XQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 07 Oct 2026 08:51:43 +0000
Message-ID: <597b27c0-ceec-451e-8f68-ae48031939cb@suse.de>
Date: Wed, 7 Oct 2026 10:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/7] User readable error codes on atomic_ioctl failure
To: Arun R Murthy <arun.r.murthy@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, xaver.hugl@kde.org,
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com,
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
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
In-Reply-To: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[intel.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ursulin.net,kde.org,amd.com,bootlin.com];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email, amd.com:email,
 ursulin.net:email, bootlin.com:email, patchwork.freedesktop.org:url,
 ffwll.ch:email, kde.org:url, kde.org:email, intel.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:email,
 gitlab.freedesktop.org:url, suse.com:url]
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

Am 31.03.26 um 11:03 schrieb Arun R Murthy:
> The series focuses on providing a user readable error value on a failure
> in drm_atomic_ioctl(). Usually -EINVAL is returned in most of the error
> cases and it is difficult for the user to decode the error and get to
> know the real cause for the error. If user gets to know the reason for
> the error then corrective measurements can be taken up.

I'm missing some comments on related work. Other subsystems (filesystems 
IIRC) have explored various ideas for extending errno codes. But nothing 
was deemed acceptable. I'd like to know why this works with DRM, but not 
other subsystems.

Best regards
Thomas

>
> User will have to check for the capability
> DRM_CAP_ATOMIC_ERROR_REPORTING before using this feature so as to ensure
> that the driver supports failure reporting.
>
> TODO: driver specific error codes are to be added and will be done in
> the follow-up patches.
>
> TODO: Once the series is merged the element 'reserved' used for sending
> the failure code in struct drm_mode_atomic is to changed to err_code.
>
> The IGT related changes are pushed for review @
> https://patchwork.freedesktop.org/series/153330/
>
> [RFC] changes for libdrm pushed for review @
> https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/450
>
> [DRAFT] KWin changes are pushed for review @
> https://invent.kde.org/plasma/kwin/-/merge_requests/8991
>
>      To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>      To: suraj.kandpal@intel.com>
>      To: Maxime Ripard <mripard@kernel.org>
>      To: Thomas Zimmermann <tzimmermann@suse.de>
>      To: David Airlie <airlied@gmail.com>
>      To: Simona Vetter <simona@ffwll.ch>
>      To: Jani Nikula <jani.nikula@linux.intel.com>
>      To: Rodrigo Vivi <rodrigo.vivi@intel.com>
>      To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>      To: Tvrtko Ursulin <tursulin@ursulin.net>
>      To: xaver.hugl@kde.org
>      To: harry.wentland@amd.com
>      To: uma.shankar@intel.com
>      To: louis.chauvet@bootlin.com
>      To: naveen1.kumar@intel.com
>      To: ramya.krishna.yella@intel.com
>      Cc: dri-devel@lists.freedesktop.org
>      Cc: intel-gfx@lists.freedesktop.org
>      Cc: intel-xe@lists.freedesktop.org
>      Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
>
> Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
> ---
> Changes in v9:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v8: https://lore.kernel.org/r/20260129-atomic-v8-0-4cb7b0faa051@intel.com
>
> ---
> Arun R Murthy (7):
>        drm: Define user readable error codes for atomic ioctl
>        drm/atomic: Add error_code element in atomic_state
>        drm/atomic: Call complete_signaling only if prepare_signaling is done
>        drm/atomic: Allocate atomic_state at the beginning of atomic_ioctl
>        drm/atomic: Return user readable error in atomic_ioctl
>        drm/i915/display: Error codes for async flip failures
>        drm: Introduce DRM_CAP_ATOMIC_ERROR_REPORTING
>
>   drivers/gpu/drm/drm_atomic.c                 | 31 ++++++++++
>   drivers/gpu/drm/drm_atomic_uapi.c            | 89 ++++++++++++++++++++--------
>   drivers/gpu/drm/drm_ioctl.c                  |  3 +
>   drivers/gpu/drm/i915/display/intel_display.c | 25 ++++----
>   include/drm/drm_atomic.h                     | 10 ++++
>   include/uapi/drm/drm.h                       |  7 +++
>   include/uapi/drm/drm_mode.h                  | 56 +++++++++++++++++
>   7 files changed, 184 insertions(+), 37 deletions(-)
> ---
> base-commit: 65b94118bc585aefc7095c0e9554c3bb12d98a69
> change-id: 20250728-atomic-c9713fd357e4
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


