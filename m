Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FF0CD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D620710E16D;
	Tue, 12 May 2026 06:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="bMI1na/+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hif2veEs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AxQcbV3G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AbmOTUUj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF42F10E02C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:26:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B65806BF76;
 Tue, 12 May 2026 06:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778567204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
 b=bMI1na/+MwgF73Y2ASNGKrvdDI/K0uQLRmUvEhgq/0Peo5PPcSjbeaCQvZWbA1WeXpQ7yy
 4aaywo3/figlXf4rWVk/cCxc4r0xs5jElnVHL1Iey5mG8hwudxJ45+ljFTdtbxTfD3CQ7L
 /EHsTGyzjc1gGWyoKa0AD6cwnL3/e4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778567204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
 b=hif2veEshB0axeHWNyB7e8p1RW10HMLQ8g7FS5y+gIVqPebE3mIeAXtr/mQEJNvr4NCBvO
 kedSyLIOvNYnFrCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AxQcbV3G;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AbmOTUUj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778567203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
 b=AxQcbV3GlqLmFFAz3Ni3tIVK4mpYq0+fvg8k6zOkX6TM7DpOMKBUFtIcTYuE4XGA7eemuY
 OFmk3T1ZuFHhyMeoZQ8kEx9/wxFLEZrLlY9XXLNpeZN+YG57EsVRBDK0+cEINJxBg8iWiB
 SmF7BRNzi/K1Gsmhvi0gNaqQpllRVMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778567203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gGdWoPQ+bTNVcVEUOfkou5v7qcXtSEQgxjBxBCUyGCE=;
 b=AbmOTUUjK09ClLzW0nEHrosDDhRW9jG/PFYPUs+v8j8pGVWNCOh+lhIWNftofeg6fDoKHJ
 276r+bzYuDSVm5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06DC3593A9;
 Tue, 12 May 2026 06:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Eol4OyHIAmqbAgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 12 May 2026 06:26:41 +0000
Message-ID: <eb236f5d-e185-418c-9ea1-780e8b1f985b@suse.de>
Date: Tue, 12 May 2026 08:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/loongson: clean up KMS polling on probe failure
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Myeonghun Pak
 <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv
 <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260511170152.16957-1-mhun512@gmail.com>
 <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
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
In-Reply-To: <3ee00ebc4ff5bcf2a8754466f8d9d04b24f81858.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,lists.freedesktop.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B65806BF76
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

Am 11.05.26 um 19:22 schrieb Icenowy Zheng:
> 在 2026-05-12二的 02:01 +0900，Myeonghun Pak写道：
>> lsdc_pci_probe() initializes KMS polling before setting up vblank
>> support,
>> requesting the IRQ and registering the DRM device. If any of those
>> later
>> steps fails, probe returns without finalizing polling. The remove
>> path has
>> the same lifetime gap when tearing down a successfully registered
>> device.
>>
>> Route those probe failures through a poll cleanup label. Also
>> finalize
>> polling from remove before unregistering the DRM device.
> Interesting, but it looks like a `drmm_kms_helper_poll_init` function
> exists (while rarely used).
>
> Maybe it's better to switch to this? Or maybe there's some reason not
> to use this?

Agreed. DRM drivers are advised to use managed cleanup for their data 
structures. So rather switch to drmm_kms_helper_poll_init(). That also 
resolves the problem that loongson never calls poll_fini on regular 
removals.

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>> This issue was identified during our ongoing static-analysis research
>> while
>> reviewing kernel code.
>>
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>> ---
>>   drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c
>> b/drivers/gpu/drm/loongson/lsdc_drv.c
>> index abf5bf68ee..3db1f8690a 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
>> @@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   	if (loongson_vblank) {
>>   		ret = drm_vblank_init(ddev, descp->num_of_crtc);
>>   		if (ret)
>> -			return ret;
>> +			goto err_poll_fini;
>>   
>>   		ret = devm_request_irq(&pdev->dev, pdev->irq,
>>   				       descp->funcs->irq_handler,
>> @@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   				       dev_name(&pdev->dev), ddev);
>>   		if (ret) {
>>   			drm_err(ddev, "Failed to register interrupt:
>> %d\n", ret);
>> -			return ret;
>> +			goto err_poll_fini;
>>   		}
>>   
>>   		drm_info(ddev, "registered irq: %u\n", pdev->irq);
>> @@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>   
>>   	ret = drm_dev_register(ddev, 0);
>>   	if (ret)
>> -		return ret;
>> +		goto err_poll_fini;
>>   
>>   	drm_client_setup(ddev, NULL);
>>   
>>   	return 0;
>> +
>> +err_poll_fini:
>> +	drm_kms_helper_poll_fini(ddev);
>> +	return ret;
>>   }
>>   
>>   static void lsdc_pci_remove(struct pci_dev *pdev)
>>   {
>>   	struct drm_device *ddev = pci_get_drvdata(pdev);
>>   
>> +	drm_kms_helper_poll_fini(ddev);
>>   	drm_dev_unregister(ddev);
>>   	drm_atomic_helper_shutdown(ddev);
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


