Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A288C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE9610EC7E;
	Tue, 22 Sep 2026 12:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="X920EZ83";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZvlFX0Jr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vzXWCjGe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sq9bK5VC";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7016D10EA4E;
 Tue, 22 Sep 2026 12:08:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A396121AA9;
 Tue, 22 Sep 2026 12:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rLRc8zl8aqIxSR1VL/Mye3FkV1bGaBSyopMMs4u2HOE=;
 b=X920EZ83Fd0OKixtr/YnbBwrTBiE+9Im6QA4ji7vnX7qJii1sCf9knSAq1lHbOquttejTs
 BDBvRd2I9j3PF4+hGW0ln9i6IvwuioUCYAcuC7Nhe60frkq54/S9Iwqf2C3tHcRRB44huI
 EW8/wKeNUt3Yrq1By3j7CfkZPXXHd0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rLRc8zl8aqIxSR1VL/Mye3FkV1bGaBSyopMMs4u2HOE=;
 b=ZvlFX0JruSP2fMYR8Nv4PoRXy9BDQbo2JAm9KV8bLpsVOcFkAG87sY5VbeTr7BPmHRzsWE
 aSnosGmvXlb59aCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rLRc8zl8aqIxSR1VL/Mye3FkV1bGaBSyopMMs4u2HOE=;
 b=vzXWCjGegunU2ndkjp+KSguebUpNlXX1IXO2ZdoiyFsCnNmbGPm30TY4UsDvEUVoU7grTQ
 l6T4GrVMjimYdCsCiTWQ21QkHaCd4CRK+4DJbUyzkwh1hImgeKXQNW8tLW0Rt/EehrAouh
 NZzriGK9nUX6xkbk3OfvGqTlmdMj67s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rLRc8zl8aqIxSR1VL/Mye3FkV1bGaBSyopMMs4u2HOE=;
 b=Sq9bK5VCZ719j8QiitEP/6aQ8cfNdnrOkXKBoOSw8Rs2BZoLJ+Nw3STraBJUFx7yS0O885
 hgZBqHLwklzm3/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8F01132D3;
 Tue, 22 Sep 2026 12:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0CYOHM1vsmr5GwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 22 Sep 2026 12:08:45 +0000
Message-ID: <a6efb08e-c88c-4f3b-ab40-2b56eb27bbeb@suse.de>
Date: Tue, 22 Sep 2026 14:08:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/14] drm: add connector backlight (LUMINANCE)
 infrastructure
To: Javier Martinez Canillas <javierm@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-5-mario.limonciello@amd.com>
 <xlv1ecelecm9.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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
In-Reply-To: <xlv1ecelecm9.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[16];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,amd.com,lists.freedesktop.org,ffwll.ch,linux.intel.com,kernel.org,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kernel.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid]
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

Am 22.09.26 um 13:42 schrieb Javier Martinez Canillas:
> Mario Limonciello <mario.limonciello@amd.com> writes:
>
>> Backlight brightness is a property of a display, and thus of a DRM
>> connector, yet it has historically only been controllable through the
>> separate backlight sysfs interface. Add a generic, backend-agnostic
>> per-connector LUMINANCE range property so brightness can be driven
>> through the atomic modeset path like any other connector state.
>>
>> A struct drm_backlight is embedded in every connector and initialized by
>> the core; drivers do not allocate it. A driver links a backend (today a
>> backlight_device, in the future DDC/CI, MIPI-DCS, ...) with
>> drm_backlight_link(), which creates the connector's LUMINANCE property
> The infrastructure is meant to be backend-agnostic but drm_backlight_link()
> which creates the connector's LUMINANCE property is backend specific. Maybe
> would be better to not call drm_backlight to the DRM core helpers since it
> conflates the backlight subsystem specific helpers, and the ones that are
> supposed to be backend-agnostic.
>
> Maybe drm_brightness or drm_luminance would be more suitable? That way would
> be clear what is generic infra to handle the LUMINANCE property and what is
> specific to drivers using a backlight device.
>
> In fact, I think that would be better if you split this patch in the DRM core
> helpers and another patch that adds the backlight specific helpers on top. It
> would also be useful to have an example of a "native" backend, for drivers that
> have a trivial brightness management.
>
> For example, many small I2C or SPI display panels just send a few commands over
> the bus to change the backlight brightness. Those may have their own get/set
> luminance callbacks and register their own struct drm_backlight_funcs.
>
> Because right now seems to me that this drm_backlight infrastructure is mixing
> the two layers and we have a leaky abstraction.
>
>> with the backend's range. The property value is staged into the atomic
>> connector state and only pushed to the hardware from the commit/enable
>> path, via a workqueue so that slow backends never stall a commit. DPMS
>> off drives the backlight to 0 and DPMS on restores the committed value.
>>
>> The property range is per-connector (created from the backend's
>> max_brightness), so multiple panels no longer share and corrupt a single
>> device-wide range. drm_backlight_link() also carries the legacy-sysfs
>> takeover accounting used by the client capability added in a later patch.
>>
>> The whole feature is guarded by CONFIG_DRM_BACKLIGHT (which depends on,
>> rather than selects, BACKLIGHT_CLASS_DEVICE) so DRM does not pull the
>> backlight subsystem into the kernel when it is not wanted.
>>
> If we had a good separation between the drm_backlight core helpers and the
> backlight subsystem then this dependency wouldn't be needed. Drivers would
> use depend on CONFIG_DRM_BACKLIGHT to use the drm_backlight helpers and use
> BACKLIGHT_CLASS_DEVICE dependent helpers, to be used as set/get callbacks.
>
> Since DRM drivers that register a backlight device already depend on this
> Kconfig symbol, no additional dependencies will be needed. And drivers that
> only use the CONFIG_DRM_BACKLIGHT (with a different backend), won't need to
> depend on CONFIG_DRM_BACKLIGHT.
>
> In general, I think is preferable to have good helper functions that could
> be reused by drivers, instead of having mid-layers such as drm_backlight_link().

I want to second what Javier says here. I raise the same points in my 
rant about DRM design.

Best regards
Thomas


>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


