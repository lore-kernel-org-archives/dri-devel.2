Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A6C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC5810E522;
	Thu,  3 Sep 2026 07:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="W1yVGfwF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X2vdBHja";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r+NmorXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mPfgZEWK";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214DA10E0B0
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:46:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85CE61FDDE;
 Thu,  3 Sep 2026 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788421574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jc2J7r34xSDu3DCmuxHGBooyKpDUQA2h1EtnYalQRc8=;
 b=W1yVGfwFtthJEy1IwZyfhPko9DLasU836WZC8R8GVOcsqV0055c3SqNOv70PSgM0hW8qyK
 C8wBTTbPTVC520T+Wtk8NYy3gYjQQwuhIqLVEfARDkOoeHToLFjCLJQ0Qgi47SxedewfjX
 ofz+eZhmvpq0Eyqwt2ORlIKaNRHqxG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788421574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jc2J7r34xSDu3DCmuxHGBooyKpDUQA2h1EtnYalQRc8=;
 b=X2vdBHja3vCo++gUvbFKkcwngVza0JyQGslF9PR2F8TiNdrp+ot23ayo5HDnIourXOczhp
 gZXFpCYhSqmbI3Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r+NmorXc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mPfgZEWK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788421570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jc2J7r34xSDu3DCmuxHGBooyKpDUQA2h1EtnYalQRc8=;
 b=r+NmorXcOjQb4rGpborqtYV2n/WTEpzqQ3IpPU0zcrslBdJd69M5wuqo52xaiAeqAMVGNC
 QUhDhbRpt362RsoOY/0yYxLnB+VkCN2VxzdeNojqoGQeiwKy2egRmcK5ELE6ifCD+iumjg
 HclzXLRLiAkg2e++AT+NHHh+yYms+mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788421570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jc2J7r34xSDu3DCmuxHGBooyKpDUQA2h1EtnYalQRc8=;
 b=mPfgZEWKKOtgHusiW4zz9Zszh5F7NoR081SIndgWLesEjAfcqqynna3czB4gsHinT5TYoi
 hSQWjJNQOgq8T1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3134B136D9;
 Thu,  3 Sep 2026 07:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pb6pCsIlmWpSfAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 07:46:10 +0000
Message-ID: <47df26aa-a160-4306-84f0-510584c3e8e0@suse.de>
Date: Thu, 3 Sep 2026 09:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS, mailmap: use Aditya Garg's linux.dev account
To: Aditya Garg <gargaditya08@proton.me>
Cc: Aditya Garg <aditya.garg@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Aditya Garg <gargaditya08@live.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260723100136.14467-1-aditya.garg@linux.dev>
 <27a31a37-688d-427b-a0ba-c3133db19c97@suse.de>
 <txsiv43u7qv-Pc_dRDdbgiUHVP54rhl5g-xLzQU457o0E29MYkL9FX-zdozYxVySvTed10VduLizWQw3zNDJTGxTIfFLX71G3U_Kj3qnJao=@proton.me>
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
In-Reply-To: <txsiv43u7qv-Pc_dRDdbgiUHVP54rhl5g-xLzQU457o0E29MYkL9FX-zdozYxVySvTed10VduLizWQw3zNDJTGxTIfFLX71G3U_Kj3qnJao=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 85CE61FDDE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[9];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,live.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.dev,linux.intel.com,kernel.org,ffwll.ch,gmail.com,live.com,vger.kernel.org,lists.freedesktop.org];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

Am 03.09.26 um 08:57 schrieb Aditya Garg:
> Hi
>
>> Am 23.07.26 um 12:01 schrieb Aditya Garg:
>>> From: Aditya Garg <gargaditya08@live.com>
>>>
>>> Due to non standard IMAP and SMTP protocols by Proton Mail, the account
>>> was giving trouble. Since my linux.dev account has been approved, all
>>> communication related to Linux development shall now be done there.
>>>
>>> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Can someone please merge this. I am still receiving mails on my old email which I do not use for dev work anymore.

Done now. The update will go out with the next drm-misc-fixes.

Best regards
Thomas

>
>>> ---
>>>    .mailmap    | 3 ++-
>>>    MAINTAINERS | 2 +-
>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.mailmap b/.mailmap
>>> index 501d858cb..baea6ba4d 100644
>>> --- a/.mailmap
>>> +++ b/.mailmap
>>> @@ -19,7 +19,8 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
>>>    Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
>>>    Adam Oldham <oldhamca@gmail.com>
>>>    Adam Radford <aradford@gmail.com>
>>> -Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
>>> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@live.com>
>>> +Aditya Garg <aditya.garg@linux.dev> <gargaditya08@proton.me>
>>>    Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
>>>    Adrian Bunk <bunk@stusta.de>
>>>    Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1ab873685..f32e63428 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7970,7 +7970,7 @@ F:	drivers/gpu/drm/sun4i/sun8i*
>>>
>>>    DRM DRIVER FOR APPLE TOUCH BARS
>>>    M:	Aun-Ali Zaidi <admin@kodeit.net>
>>> -M:	Aditya Garg <gargaditya08@proton.me>
>>> +M:	Aditya Garg <aditya.garg@linux.dev>
>>>    L:	dri-devel@lists.freedesktop.org
>>>    S:	Maintained
>>>    T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


