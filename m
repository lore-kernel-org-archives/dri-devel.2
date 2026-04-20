Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BCEF36C20
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2623E10E0DC;
	Mon, 20 Apr 2026 06:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Y2PYRmc+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IUj5ubTK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ONxAVUX2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HIFTOj5e";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD0E10E0DC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:21:46 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D49AF5BD10;
 Mon, 20 Apr 2026 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776666105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z8RVgEi1iJ3CLtcwKvFBM2SlUeMXIgoiPuS4MfIbt70=;
 b=Y2PYRmc++lLqoPcY9GCMJcZLJMQp8C82hvGN2yCtWfNf3dzlIMARTxDBio5eBfUrFaB7lk
 3CPsErSQhJBipUb0xCnNuUvki27pLZSjaHnUOCWqOdU1u8jXrWTgj+qA6bf6IfNL4lsAz1
 i5rDI1g/PCuSF7sKAzLL3fc9OusKb4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776666105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z8RVgEi1iJ3CLtcwKvFBM2SlUeMXIgoiPuS4MfIbt70=;
 b=IUj5ubTKcTfQpcNig5/BPdtrWSyGC1euMIc4aYQ+05Sk1qd9mvYI8UkIqZ1SFTWXwrGmwd
 JojHtFC1Bs/ai2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776666104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z8RVgEi1iJ3CLtcwKvFBM2SlUeMXIgoiPuS4MfIbt70=;
 b=ONxAVUX25vGxQ2tuQJ7Rq2mFE/4If/FVcXceoHXXVk5zSm4xF60S8p/l1GcKLO+52bDSuv
 h8hwEEcvsAcfhleFTUIopFVvvXIusG9nHWcBTkmwOclIdNefT7Ja0twLMhB4RHK1eI3sRp
 CSZ4r/se3aytkA+gZdewOMcrFWfhh6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776666104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z8RVgEi1iJ3CLtcwKvFBM2SlUeMXIgoiPuS4MfIbt70=;
 b=HIFTOj5eQwJivR/kdYufBFAwmGJhIYj36qcm35dsFfOztBxGuXZJHd2HWGrUbOzQcSnbSG
 NoynAQu8r3XItrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BE2B593AE;
 Mon, 20 Apr 2026 06:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dlwDH/jF5WnjFAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 06:21:44 +0000
Message-ID: <17620d92-70ee-4bc4-8944-4075bb50a54e@suse.de>
Date: Mon, 20 Apr 2026 08:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/sysfb: ofdrm: fix PCI device reference leaks
To: Yuho Choi <dbgh9129@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>
References: <20260420002513.216-1-dbgh9129@gmail.com>
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
In-Reply-To: <20260420002513.216-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.80 / 50.00]; SEM_URIBL(3.50)[psu.edu:email];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,lists.freedesktop.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org,psu.edu];
 RCPT_COUNT_SEVEN(0.00)[11]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[psu.edu:email,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.com:url]
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

thanks for the patch.

Am 20.04.26 um 02:25 schrieb Yuho Choi:
> display_get_pci_dev_of() gets a referenced PCI device via
> pci_get_device(). Drop that reference when pci_enable_device() fails and
> release it during the managed teardown path after pci_disable_device().
>
> Without that, ofdrm leaks the pci_dev reference on both the error path
> and the normal cleanup path.

Did you use an AI to find or fix this bug?

https://docs.kernel.org/process/coding-assistants.html

Best regards
Thomas

>
> Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
> Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>   drivers/gpu/drm/sysfb/ofdrm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index d38ba70f4e0d3..247cf13c80a05 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> @@ -350,6 +350,7 @@ static void ofdrm_pci_release(void *data)
>   	struct pci_dev *pcidev = data;
>   
>   	pci_disable_device(pcidev);
> +	pci_dev_put(pcidev);
>   }
>   
>   static int ofdrm_device_init_pci(struct ofdrm_device *odev)
> @@ -375,6 +376,7 @@ static int ofdrm_device_init_pci(struct ofdrm_device *odev)
>   	if (ret) {
>   		drm_err(dev, "pci_enable_device(%s) failed: %d\n",
>   			dev_name(&pcidev->dev), ret);
> +		pci_dev_put(pcidev);
>   		return ret;
>   	}
>   	ret = devm_add_action_or_reset(&pdev->dev, ofdrm_pci_release, pcidev);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


