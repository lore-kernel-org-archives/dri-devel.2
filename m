Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5190EFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E65E10E649;
	Mon, 27 Apr 2026 09:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yOKP+MKU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ElK7XzX3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOKP+MKU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ElK7XzX3";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226C410E649
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 09:37:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A41556A926;
 Mon, 27 Apr 2026 09:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777282618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/iJrgfKBZ3GzS5GpUiZsLMRcruTYEPCnr3PZD6YVNmY=;
 b=yOKP+MKUL3OrEGhSOUjxQ2q0Pkrsaz/kjJD498qAlmHxJ6NIK1AgWdVIweZzDxHYHqS8Bv
 KMzHTnFcYaqn4SLQaxGPS4877m8rF/u4iKwQUlgOptGoFnhQJEbwKOO5HcbAh158gKmtTC
 6Ye03WENdCNMdo//lbz4KpN1zoSESX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777282618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/iJrgfKBZ3GzS5GpUiZsLMRcruTYEPCnr3PZD6YVNmY=;
 b=ElK7XzX3K+QYDhitqec+oQI/Wq5Kkr6BKhCnJx64f8OHJaHAmlTwnNgnAiDUQXg39Ow4p+
 +coZipNg42kimLDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777282618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/iJrgfKBZ3GzS5GpUiZsLMRcruTYEPCnr3PZD6YVNmY=;
 b=yOKP+MKUL3OrEGhSOUjxQ2q0Pkrsaz/kjJD498qAlmHxJ6NIK1AgWdVIweZzDxHYHqS8Bv
 KMzHTnFcYaqn4SLQaxGPS4877m8rF/u4iKwQUlgOptGoFnhQJEbwKOO5HcbAh158gKmtTC
 6Ye03WENdCNMdo//lbz4KpN1zoSESX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777282618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/iJrgfKBZ3GzS5GpUiZsLMRcruTYEPCnr3PZD6YVNmY=;
 b=ElK7XzX3K+QYDhitqec+oQI/Wq5Kkr6BKhCnJx64f8OHJaHAmlTwnNgnAiDUQXg39Ow4p+
 +coZipNg42kimLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FF5B593B0;
 Mon, 27 Apr 2026 09:36:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c9jbGTou72nSYAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 09:36:58 +0000
Message-ID: <052423a5-c511-4abd-9997-788b7dd57a17@suse.de>
Date: Mon, 27 Apr 2026 11:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS, mailmap: update Aditya Garg's email address
To: Aditya Garg <gargaditya08@proton.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260424175846.15103-1-gargaditya08@proton.me>
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
In-Reply-To: <20260424175846.15103-1-gargaditya08@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[proton.me,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, intel.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.de:url, suse.de:mid, suse.de:email]
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



Am 24.04.26 um 19:59 schrieb Aditya Garg:
> My Outlook email address often sends emails from kernel devs to the junk
> folder. Also, emails from some addresses (eg suse.de) are not received
> at all. Update the email to my alternate Proton Mail address.
>
> Signed-off-by: Aditya Garg <gargaditya08@proton.me>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 28eedfaa2..5c219b40e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -19,6 +19,7 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
>   Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
>   Adam Oldham <oldhamca@gmail.com>
>   Adam Radford <aradford@gmail.com>
> +Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
>   Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
>   Adrian Bunk <bunk@stusta.de>
>   Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 090b52a5c..0ebd747ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7894,7 +7894,7 @@ F:	drivers/gpu/drm/sun4i/sun8i*
>   
>   DRM DRIVER FOR APPLE TOUCH BARS
>   M:	Aun-Ali Zaidi <admin@kodeit.net>
> -M:	Aditya Garg <gargaditya08@live.com>
> +M:	Aditya Garg <gargaditya08@proton.me>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


