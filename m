Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB232CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4377410E5BD;
	Wed, 13 May 2026 07:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JZqhc8zE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yTMQOrRt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="foR6gQjj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qBwo+DuB";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F1C10ECF6
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:28:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4EA75F1A;
 Wed, 13 May 2026 07:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778657297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q3LbR2UJkrKZCrwSOdUef4NhlipoLEOykLGJfelUpdE=;
 b=JZqhc8zEfaBRWOtm7sCZSsQSe6KGq7Est2R5Nwl+C19VmxN4fVgv7wp8/dzNM8oHo37tVR
 NXDV35/9NEQRGDflpmhg4co8Go0dGHxLMQ998NaukSxHh9bOoWtvvqhimVn4LV+D/LmYzv
 zXTIkxIOjnr9D4i2LoPICjs62IuuIOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778657297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q3LbR2UJkrKZCrwSOdUef4NhlipoLEOykLGJfelUpdE=;
 b=yTMQOrRt8jBCvgP8oBmUJJuBcHCxVM413HEEw0U7VjmHtqO3OFtSjQnhrG6i7QqrlMGCdh
 06anOCJjYWnJ1iDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=foR6gQjj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qBwo+DuB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778657295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q3LbR2UJkrKZCrwSOdUef4NhlipoLEOykLGJfelUpdE=;
 b=foR6gQjjVGyftrmhLW3DhYd3mXm9V2yklbYboWA7dVdRJiN4JArCyTyoKLrWhclKCNv1KM
 E304Zr/fXC5DEH2SU3FR7efxU3aK2HsAPf32Ahsqn4HF2amxzlhELXSqbL1VYb72j93GjG
 Uh74IEPAZmN5cFMRjMta1Mu4dFadX5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778657295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q3LbR2UJkrKZCrwSOdUef4NhlipoLEOykLGJfelUpdE=;
 b=qBwo+DuBWDywYlDbUbYZAvr+5DXC77LJXeiajuZIDffNNgWwZmfX3C7fwKK0qKdnM715OL
 jUgbVQWa906cpBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 262B2593A9;
 Wed, 13 May 2026 07:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TbUPCA8oBGoocAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 13 May 2026 07:28:15 +0000
Message-ID: <ad257c82-b390-4fd2-9029-d991cc7c8d9c@suse.de>
Date: Wed, 13 May 2026 09:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v6 0/4] Fix some bugs in the hibmc
 driver
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260509032302.2057227-1-shiyongbang@huawei.com>
 <d45b7e90-9e13-4c04-8f4c-37898aabc2c0@suse.de>
 <d017d6e8-1035-4088-a543-6fc00f2c29c3@huawei.com>
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
In-Reply-To: <d017d6e8-1035-4088-a543-6fc00f2c29c3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[17];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 URIBL_BLOCKED(0.00)[huawei.com:email,checkpatch.pl:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,hisilicon.com:email,suse.com:url];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url, hisilicon.com:email,
 huawei.com:email, suse.de:mid, suse.de:dkim, suse.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E4EA75F1A
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

Am 12.05.26 um 14:12 schrieb Yongbang Shi:
>> Hi,
>>
>> I've gone through the series and reviewed the patches. Let me know when they are ready to get merged.
>>
> Thanks for the review. The series is ready for merging now.

Thanks for sticking with it. The series is now merged into drm-misc-next.

Best regards
Thomas

>
> Thanks,
> Yongbang.
>
>
>> Best regards
>> Thomas
>>
>>
>> Am 09.05.26 um 05:22 schrieb Yongbang Shi:
>>> From: Lin He <helin52@huawei.com>
>>>
>>> There are some bugfix for hibmc-drm driver.
>>>
>>> ---
>>> ChangeLog:
>>> v5 -> v6:
>>>     - Rename 'phys_state' to 'phys_status'
>>>     - Replace `drm_kms_helper_poll_init` with `drmm_kms_helper_poll_init`
>>>       and adjust the timing of the call.
>>>     - Split "return vdac->phys_state = state;" into separate statements.
>>>     - Change `get_mode` to return 0 when no modes are available, allowing DRM to
>>>       install a default resolution.
>>>     - Change the initial phys_status of vdac from
>>>       'connector_status_connected' to 'connector_status_disconnected'
>>>     - Removed invalid bit configurations from `hibmc_display_ctrl`.
>>>     - Modify the return values of `hibmc_get_best_clock_idx` and
>>>       `hibmc_crtc_mode_valid`
>>> v4 -> v5:
>>>     - The 'epoch_counter' of the vdac connector is incremented when the
>>>      physical status changes.
>>>     - The polling mechanism for the KMS helper is enabled.
>>> v3 -> v4:
>>>     - fix incorrect cover-letter subject prefix in v3.
>>> v2 -> v3:
>>>     - remove unused macro CLOCK_TOLERANCE.
>>> v1 -> v2:
>>>     - fix the checkpatch.pl warning "Unknown commit ID 'e6c7c59da494'".
>>>     - fix the checkpatch.pl warning "line length of 83/85 exceeds 80 columns".
>>>     - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>>>       be given in public.
>>>     - add 'drm-misc-fixes' in subject prefix.
>>> ---
>>>
>>> Lin He (4):
>>>     drm/hisilicon/hibmc: add updating link cap in DP detect()
>>>     drm/hisilicon/hibmc: fix no showing when no connectors connected
>>>     drm/hisilicon/hibmc: move display contrl config to hibmc_probe()
>>>     drm/hisilicon/hibmc: use clock to look up the PLL value
>>>
>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  1 +
>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>>>    drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  |  2 +-
>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 80 +++++++++++--------
>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 35 +++++---
>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 ++++
>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
>>>    .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 75 +++++++++--------
>>>    8 files changed, 124 insertions(+), 85 deletions(-)
>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


