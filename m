Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6F606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FdInWYv0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VrqsXOaL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FdInWYv0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VrqsXOaL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C868810E35E;
	Wed, 11 Nov 2026 12:52:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05AE910E35E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:52:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D01222225;
 Wed, 11 Nov 2026 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794401520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfxHDzbzqAoL0hqPmgTOInr9iTiyWj+kQ+NlGLNlPTQ=;
 b=FdInWYv0CVHeteLWwxFzTVNvkdwQ01EWtAwQDOZb7kJtUSil6DX++fHTgPg94opugz6ZQo
 m68Zevo0LAxx5yW/PIKKn6hVDe4eral2vFbkHPfRtY3hCEqZ1aR7PcqqIt9mIGilOqk7j4
 3oBHuJVjF6lGGIlTCGuNpKm3zv8015A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794401520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfxHDzbzqAoL0hqPmgTOInr9iTiyWj+kQ+NlGLNlPTQ=;
 b=VrqsXOaLB3yk0Jf4HnO98nuVwBoZOnYPSv2LNc5G8UXYocN9sKbF/DDpq3amKHc93/FhPN
 oK9K9HL8YmZEvQAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794401520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfxHDzbzqAoL0hqPmgTOInr9iTiyWj+kQ+NlGLNlPTQ=;
 b=FdInWYv0CVHeteLWwxFzTVNvkdwQ01EWtAwQDOZb7kJtUSil6DX++fHTgPg94opugz6ZQo
 m68Zevo0LAxx5yW/PIKKn6hVDe4eral2vFbkHPfRtY3hCEqZ1aR7PcqqIt9mIGilOqk7j4
 3oBHuJVjF6lGGIlTCGuNpKm3zv8015A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794401520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfxHDzbzqAoL0hqPmgTOInr9iTiyWj+kQ+NlGLNlPTQ=;
 b=VrqsXOaLB3yk0Jf4HnO98nuVwBoZOnYPSv2LNc5G8UXYocN9sKbF/DDpq3amKHc93/FhPN
 oK9K9HL8YmZEvQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 096A9134E5;
 Wed, 11 Nov 2026 12:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qP/CKO9k9GriKwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 11 Nov 2026 12:51:59 +0000
Message-ID: <441404fa-5287-4748-b53d-51d1bf02ba73@suse.de>
Date: Wed, 11 Nov 2026 13:51:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm: Drop #include <linux/mod_devicetable.h> from
 <drm/display/drm_dp_aux_bus.h>
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <21c9390024479ec625ca7a2e7a5b959f04d85878.1786032838.git.u.kleine-koenig@baylibre.com>
 <avQk9v83d-jEGTiX@monoceros> <3d67a8ac-58b4-41c3-8359-06ff0a4e2b08@suse.de>
Content-Language: en-US
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
In-Reply-To: <3d67a8ac-58b4-41c3-8359-06ff0a4e2b08@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 baylibre.com:email, suse.com:url]
X-Spam-Score: -13.29
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 11.11.26 um 09:40 schrieb Thomas Zimmermann:
> Hi
>
> Am 11.11.26 um 09:21 schrieb Uwe Kleine-König (The Capable Hub):
>> Hello,
>>
>> On Thu, Aug 06, 2026 at 06:16:06PM +0200, Uwe Kleine-König (The 
>> Capable Hub) wrote:
>>> Only .c files include <drm/display/drm_dp_aux_bus.h> (see
>>>
>>>     git grep -l drm_dp_aux_bus\\.h
>>>
>>> ). From the device-id structures that <linux/mod_devicetable.h> 
>>> provides
>>> there are:
>>>
>>>   - 8 files using struct auxiliary_device_id;
>>>   - 2 files using struct i2c_device_id; and
>>>   - 10 files using struct of_device_id
>>>
>>> (and no other usages; see
>>>
>>>     git grep -l drm_dp_aux_bus\\.h | xargs grep -oh -E 
>>> "\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|vio_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>" 
>>> | sort | uniq -c
>>>
>>> ).
>>>
>>> The 8 files using struct auxiliary_device_id already include
>>> <linux/auxiliary_bus.h>, the 2 files using struct i2c_device_id include
>>> <linux/i2c.h> and drm_dp_aux_bus.h itself includes <linux/device.h>
>>> which provide struct auxiliary_device_id, struct i2c_device_id and
>>> struct of_device_id respectively.
>>>
>>> So the include of <linux/mod_devicetable.h> can just be dropped. This
>>> gets one step closer to being able to remove that header.
>>>
>>> Signed-off-by: Uwe Kleine-König (The Capable Hub) 
>>> <u.kleine-koenig@baylibre.com>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>> This is still all true, including the statistics (as of next-20261110)
>> and the patch still applies fine.
>>
>> Can someone get convinced to apply it?
>
> Of course, will be merged soon.

Merged now into drm-misc-next

>
> Best regards
> Thomas
>
>
>>
>> Thanks
>> Uwe Kleine-König
>>
>>> ---
>>>   include/drm/display/drm_dp_aux_bus.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/include/drm/display/drm_dp_aux_bus.h 
>>> b/include/drm/display/drm_dp_aux_bus.h
>>> index 8a0a486383c5..ca8db8ccc1f9 100644
>>> --- a/include/drm/display/drm_dp_aux_bus.h
>>> +++ b/include/drm/display/drm_dp_aux_bus.h
>>> @@ -11,7 +11,6 @@
>>>   #define _DP_AUX_BUS_H_
>>>     #include <linux/device.h>
>>> -#include <linux/mod_devicetable.h>
>>>     /**
>>>    * struct dp_aux_ep_device - Main dev structure for DP AUX endpoints
>>>
>>> base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
>>> -- 
>>> 2.55.0.11.g153666a7d9bb
>>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


