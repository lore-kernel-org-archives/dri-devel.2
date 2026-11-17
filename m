Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE407606A339
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jkBkxlwH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XNlZ+Q+h;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jkBkxlwH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XNlZ+Q+h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E315E10E602;
	Tue, 17 Nov 2026 14:16:55 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4357F10E602
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:16:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CFDC1F388;
 Tue, 17 Nov 2026 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dIMrI5DwpklHuh/HFLVIhoJ8k7MY1j4G5/OHe0yQI9I=;
 b=jkBkxlwHR9jTNMpUAXTmqinke4nK/nefQLQ/GvajkyEkOiQ7VvITdXxhnlajGcqh/CugtL
 OZvbDPDKTbIBusTOPYuBp1jIYOqJlHbwQNOUrhgEucGcDQNOueptET0QKvWxOXQxlB/jFW
 1JGBzaXh57xDMJ8JqAGLCal/4eMo9cA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dIMrI5DwpklHuh/HFLVIhoJ8k7MY1j4G5/OHe0yQI9I=;
 b=XNlZ+Q+h4r6KcP7Ej7GSUvF571SwACf1CpRtSFl+3hi1f4HV7EUHMEg4uPnG7dAmhp64ot
 fNC/WbZ/aD36VGBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794925002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dIMrI5DwpklHuh/HFLVIhoJ8k7MY1j4G5/OHe0yQI9I=;
 b=jkBkxlwHR9jTNMpUAXTmqinke4nK/nefQLQ/GvajkyEkOiQ7VvITdXxhnlajGcqh/CugtL
 OZvbDPDKTbIBusTOPYuBp1jIYOqJlHbwQNOUrhgEucGcDQNOueptET0QKvWxOXQxlB/jFW
 1JGBzaXh57xDMJ8JqAGLCal/4eMo9cA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794925002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dIMrI5DwpklHuh/HFLVIhoJ8k7MY1j4G5/OHe0yQI9I=;
 b=XNlZ+Q+h4r6KcP7Ej7GSUvF571SwACf1CpRtSFl+3hi1f4HV7EUHMEg4uPnG7dAmhp64ot
 fNC/WbZ/aD36VGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 014D513302;
 Tue, 17 Nov 2026 14:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ikb4Mslh/GpBLwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 14:16:41 +0000
Message-ID: <5418426d-2dfc-4dbe-a74c-47275c1fbbc0@suse.de>
Date: Tue, 17 Nov 2026 15:16:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 0/2] Fix some bugs in the hibmc DP
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
 kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, shuliubin@huawei.com, chenjianmin@huawei.com,
 fengsheng5@huawei.com, helin52@h-partners.com, shenjian15@huawei.com,
 shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261117130056.272609-1-shiyongbang@huawei.com>
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
In-Reply-To: <20261117130056.272609-1-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.de:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, huawei.com:email, suse.com:url,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 17.11.26 um 14:00 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> Fix some bugs in the hibmc DP driver.

I can't really comment on the hardware details, so

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

for the patch set. Please see my comments on using lock guards before 
merging the series.

Best regards
Thomas

>
> ---
> ChangeLog:
> v4 -> v5:
>    - Invalidate the link in the hardirq when an unplug is sampled, and
>      stop clearing the latched HPD status in hibmc_dp_hpd_cfg().
>      (sashiko-bot)
>    - Serialize a whole AUX transfer with hibmc_dp_hpd_cfg().
>      (sashiko-bot)
>    - Append HIBMC_HPD_UNKNOWN to the enum instead of prepending it, so
>      the existing HIBMC_HPD_OUT/HIBMC_HPD_IN values do not change.
>    - Only set the enable flag when DP was initialized, clear it only when
>      it was set, and do not request the DP interrupt if DP initialization
>      failed. (sashiko-bot)
> v3 -> v4:
>    - Fix the data race on hpd_status between hardirq and process
>      contexts with WRITE_ONCE()/READ_ONCE(). (sashiko-bot)
>    - Delete the HPD_IN early return in encoder_enable that breaks KMS
>      forced modesets. (sashiko-bot)
> v2 -> v3:
>    - Delete irq_status and use hpd_status directly for hotplug
>      detection. (sashiko-bot)
>    - Add debug logs when hpd_status is not HPD_IN in detect and
>      encoder_enable.
>    - Move hibmc_set_enable_flag() before drm_dev_register() and
>      hibmc_set_disable_flag() after drm_dev_unregister() to narrow the
>      race window. (sashiko-bot)
>    - Add spinlock_t gpio_lock to hibmc_drm_private to protect all
>      operations on 0x0802A4. (sashiko-bot)
> v1 -> v2:
>    - More states in HIBMC_DP_HPD_STATUS are added to the
>      'hibmc_dp_get_hpd_status'.
>    - The call to `hibmc_set_enable_flag()` has been moved before
>      `drm_client_setup()`, specifically before the connector detection
>      triggers the I2C bit operation. (sashiko-bot)
>    - A read-modify-write operation has been implemented instead of directly
>      writing to prevent clearing the I2C mask bits. (sashiko-bot)
> ---
>
> Lin He (2):
>    drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status
>    drm/hisilicon/hibmc: Add a flag to indicate whether the OS-side driver
>      has been loaded
>
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   | 11 +++-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  2 +-
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 40 +++++++++-----
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 ++-
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 32 +++++------
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 54 +++++++++++++++++--
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 19 +++++--
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  |  3 ++
>   9 files changed, 129 insertions(+), 40 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


