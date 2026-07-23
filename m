Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3792AC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC3010F08E;
	Thu, 23 Jul 2026 11:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="iLVRhekq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+yG+jadu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lyyUUI58";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tm3gMrQg";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F25210F096
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:05:57 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CDFA7B091;
 Thu, 23 Jul 2026 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784804755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uXXeEE2fjQsHB7RiDCpFb/XmpDL7/1sOjeGV1b2waKg=;
 b=iLVRhekqeHte0M2WBd50kn/OePQTX7JyebEboBUWeVD0Z3wyjORjzyZn58sqtYUakShwSh
 Ln7huK8gMBuIVKpV/DB2+mvNEpP6FZkOjWmAcM6OeX8JMnL6GeLyranvTILNVpCm1Itch1
 5bcKIKFMPQwG/Z5t6hpbjLNOa7QCuzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784804755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uXXeEE2fjQsHB7RiDCpFb/XmpDL7/1sOjeGV1b2waKg=;
 b=+yG+jadu8d3384cx7FQIt+pfJc5lhqs8tEpc5iTF84WomgP+lriJIERjf2624vEfSAaTdd
 m4Wh+sMkEL5qYpDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784804754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uXXeEE2fjQsHB7RiDCpFb/XmpDL7/1sOjeGV1b2waKg=;
 b=lyyUUI58uLVotSl1fkhjNEt5/bxVAyKuVnYHy/Sp8WgDRjs/lmFlTWavEincAnl7xxQOjf
 sAENt1sfEVgPVmkflBtgAW64PvrFMVk7KvVQMCmHw8JpR6NgdJa1lxDim1bnCcaOImY7JD
 JWqki0jIp7/lq1eDCeH8+SWvQJY9iC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784804754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uXXeEE2fjQsHB7RiDCpFb/XmpDL7/1sOjeGV1b2waKg=;
 b=tm3gMrQgA2pZu8Se4nL4woIVYSf16L5DrkREsKKHa8Ezwd3XB2U462NkaoNHEthlEeEjCa
 zwuTB7Vz/VA6kLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D664779B5;
 Thu, 23 Jul 2026 11:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NbzyAZL1YWoSIQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Jul 2026 11:05:54 +0000
Message-ID: <27a31a37-688d-427b-a0ba-c3133db19c97@suse.de>
Date: Thu, 23 Jul 2026 13:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS, mailmap: use Aditya Garg's linux.dev account
To: Aditya Garg <aditya.garg@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>, Aditya Garg
 <gargaditya08@proton.me>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260723100136.14467-1-aditya.garg@linux.dev>
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
In-Reply-To: <20260723100136.14467-1-aditya.garg@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[linux.dev,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[live.com,proton.me,vger.kernel.org,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email, gitlab.freedesktop.org:url,
 kodeit.net:email, quicinc.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:url, linux.dev:email, linux.dev:url, codeaurora.org:email,
 lists.freedesktop.org:email, stusta.de:email, vmware.com:email, suse.de:email,
 suse.de:mid, broadcom.com:email, intel.com:email, live.com:email]
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


Am 23.07.26 um 12:01 schrieb Aditya Garg:
> From: Aditya Garg <gargaditya08@live.com>
>
> Due to non standard IMAP and SMTP protocols by Proton Mail, the account
> was giving trouble. Since my linux.dev account has been approved, all
> communication related to Linux development shall now be done there.
>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   .mailmap    | 3 ++-
>   MAINTAINERS | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 501d858cb..baea6ba4d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -19,7 +19,8 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
>   Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
>   Adam Oldham <oldhamca@gmail.com>
>   Adam Radford <aradford@gmail.com>
> -Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@live.com>
> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@proton.me>
>   Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
>   Adrian Bunk <bunk@stusta.de>
>   Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ab873685..f32e63428 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7970,7 +7970,7 @@ F:	drivers/gpu/drm/sun4i/sun8i*
>   
>   DRM DRIVER FOR APPLE TOUCH BARS
>   M:	Aun-Ali Zaidi <admin@kodeit.net>
> -M:	Aditya Garg <gargaditya08@proton.me>
> +M:	Aditya Garg <aditya.garg@linux.dev>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


