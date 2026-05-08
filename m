Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF9CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF60F10E1C0;
	Fri,  8 May 2026 06:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="urWbWVp7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qv4LUEi4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="urWbWVp7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qv4LUEi4";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE6710E1C0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:51:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CC5C5CDAD;
 Fri,  8 May 2026 06:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778223060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YOzFP6FX0Fn5yCbdYbFbam2x90aBZFbE0jAc66fVaog=;
 b=urWbWVp7mJR+dabtP3dpaVHxw6DM6j88bcJEiSdPvHAZzv4y+DLSD3clNraRt+bKW34QNv
 1KXS+FMj2mN8t/s7aPOAfRYm1D7bfJ9uNlIzefIGFYQOMB2HkTmwL33SG9sonhS39wSenF
 peIBj0ii9klbgI7BsiZpvaEWgGr/nB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778223060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YOzFP6FX0Fn5yCbdYbFbam2x90aBZFbE0jAc66fVaog=;
 b=qv4LUEi4fmR5zucq9k8MK4SejRB28Aaz8dxDlQ9KRudMa/FBLImmSwBP1Qzx4QKuJqC1RJ
 lsCp28jsz568xCAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778223060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YOzFP6FX0Fn5yCbdYbFbam2x90aBZFbE0jAc66fVaog=;
 b=urWbWVp7mJR+dabtP3dpaVHxw6DM6j88bcJEiSdPvHAZzv4y+DLSD3clNraRt+bKW34QNv
 1KXS+FMj2mN8t/s7aPOAfRYm1D7bfJ9uNlIzefIGFYQOMB2HkTmwL33SG9sonhS39wSenF
 peIBj0ii9klbgI7BsiZpvaEWgGr/nB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778223060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YOzFP6FX0Fn5yCbdYbFbam2x90aBZFbE0jAc66fVaog=;
 b=qv4LUEi4fmR5zucq9k8MK4SejRB28Aaz8dxDlQ9KRudMa/FBLImmSwBP1Qzx4QKuJqC1RJ
 lsCp28jsz568xCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E69F2593A9;
 Fri,  8 May 2026 06:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E4D7NtOH/WmldAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:50:59 +0000
Message-ID: <1a7403b5-bdbd-4deb-a6de-4d47a4702d97@suse.de>
Date: Fri, 8 May 2026 08:50:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 2/4] drm/hisilicon/hibmc: fix no
 showing when no connectors connected
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-3-shiyongbang@huawei.com>
 <27864583-4211-4553-bdc0-42dadd25d212@suse.de>
 <cc33b5df-4048-423f-97d9-b00ca04b2d99@huawei.com>
 <057ebc30-f103-4d24-b5be-bbc9b79050e8@suse.de>
 <d00dc112-0412-4db8-824a-6e409abe48d4@huawei.com>
 <125fa5ce-e0ad-4596-98ea-f894f6a6c018@suse.de>
 <e31fa859-1f68-4bc5-b723-f214eb3a3930@huawei.com>
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
In-Reply-To: <e31fa859-1f68-4bc5-b723-f214eb3a3930@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[17];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid]
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

Am 06.05.26 um 10:56 schrieb Yongbang Shi:
>> Hi,
>>
>> sorry for the late reply. I'm fairly busy.
>>
> Thank you so much for taking the time to review our code. No worries at all—we'd really appreciate it if you could take
> a look whenever you have time.
>
>> Am 28.04.26 um 14:53 schrieb Yongbang Shi:
>>>> Hi
>>>>
>>>> Am 28.04.26 um 05:58 schrieb Yongbang Shi:
>>>> [...]
>>>>>> There's a problem with the overall logic here: if the physical status is 'connected' and the helper could not retrieve
>>>>>> any modes, the helper should return 0 here. Then the DRM helpers do the right thing with setting up a few modes or an
>>>>>> EDID override as a fallback. See [2]. For example, on my broken test system, I'd be able to provide my display's EDID
>>>>>> and get the correct output.
>>>>>>
>>>>>> [2] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L436
>>>>>>
>>>>>> Any code below is BMC setup and should run in an else branch, just like in ast.
>>>>>>
>>>>> The `drm_edid_override_connector_update` interface is used to retrieve an overridden EDID from debugfs or from
>>>>> firmware:
>>>>>      * Debugfs: Requires the user to manually perform file operations to configure it;
>>>>>      * Firmware: Requires the distribution’s operating system or the user to place the EDID binary file in the
>>>>>                  `/lib/firmware/` directory, and the `drm.edid_firmware` parameter must be specified in the GRUB boot
>>>>>                  parameters;
>>>>>
>>>>> The modification method you provided allows for display even when the EDID cannot be retrieved. But both of these
>>>>> methods require cooperation from the user or the distribution's operating system, making implementation relatively
>>>>> difficult.
>>>> Yes, it's the established way for users to override the EDID.
>>>>
>>>>> Our use case requires that the KVM's display functionality remain intact even when no VGA or DisplayPort monitor is
>>>>> connected. I believe setting `drm_set_preferred_mode` (1024x768) as the default resolution when no monitor is present
>>>>> would be a more universal solution. Similarly, on your test system, this approach would ensure basic display
>>>>> functionality.
>>>> If no modes could be detected on the VGA and no EDID has been provided by the user, DRM helpers will install a set of
>>>> default modes that are suitable for graphics cards. See [1]. The modes installed for the KVM are not all compatible with
>>>> VGA.  If you rely on DRM helpers, you'll always get correct modes for VGA and KVM.
>>>>
>>>> Generally speaking, the decision of VGA-vs-KVM should be in ->detect. Having phys_state/phys_status does this very well.
>>>> The ->get_modes function should then use whatever has been detected.
>>>>
>>>> [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L653
>>>>
>>> Yes, I understand what you mean. But there's another issue here; we've also tested the scenario where we directly return
>>> 0. However, we found that only three resolutions remain supported: 1024*768, 800*600 and 640*480. This is because the
>>> resolution added via `drm_add_modes_noedid` in the helper has a maximum of 1024*768. This doesn't look good—there are
>>> too few resolutions available for users to choose from in KVM.
>>>
>>> With the current implementation, when `count == 0`, we set the resolution to the highest resolution supported by our
>>> CRTC, allowing users more options.
>> But why do you second-guess the results from ->detect?  Th call to ->detect already established that there's a display
>> connected.  If ->get_modes cannot find useful modes, then don't treat it as a BMC now. Return 0 and let DRM choose some
>> same defaults.  These 3 low-res modes act as a safe base line. Reporting high-res BMC modes might accidentally fry
>> someone's monitor.
>>
> Sorry, my mistake. My previous reply was not quite right. I'm a little confused about this situation. I focused on
> optimizing the KVM display when no monitor is connected, but when no monitor is connected, `vdac->phys_status` is set to
> `disconnected`. Following the AST implementation you recommended[1], it takes the `else` branch and sets a custom list.
>
> `vdac->phys_state == connected` and `drm_connector_helper_get_modes` returns 0, in this case, either the returned EDID
> does not match any available options, or there is an issue with the display. In such situations, it's good to let DRM
> choose some defaults.
>
> I will follow the AST implementation[1] to make the modification in v6.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/ast/ast_vga.c?h=v7.1-rc2#L31
>
>>> Of course, this implementation has its drawbacks; it doesn't allow users to provide a custom resolution list via debugfs
>>> using the override method when `count == 0`. But this method isn't very important for how our product is used.
>> The upstream Linux kernel is not a product, but a shared commodity. It needs to work in everyone's best interest.
>>
> Yes, we'll keep that in mind; when developing community code, we should consider the overall architecture.
>
> Thanks,
> Yongbang.

Sounds good. Looking forward to the next revision.

Best regards
Thomas

>
>> Best regards
>> Thomas
>>
>>> Thanks,
>>> Yongbang.
>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>>>>>      +    drm_edid_connector_update(connector, NULL);
>>>>>>>          count = drm_add_modes_noedid(connector,
>>>>>>>                           connector->dev->mode_config.max_width,
>>>>>>>                           connector->dev->mode_config.max_height);
>>>>>>>          drm_set_preferred_mode(connector, 1024, 768);
>>>>>>>      -out:
>>>>>>> -    drm_edid_free(drm_edid);
>>>>>>> -
>>>>>>>          return count;
>>>>>>>      }
>>>>>>>      @@ -57,10 +50,32 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>>>>>>>          drm_connector_cleanup(connector);
>>>>>>>      }
>>>>>>>      +static int hibmc_vdac_detect(struct drm_connector *connector,
>>>>>>> +                 struct drm_modeset_acquire_ctx *ctx,
>>>>>>> +                 bool force)
>>>>>>> +{
>>>>>>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>>>>>>> +    int state = drm_connector_helper_detect_from_ddc(connector, ctx,
>>>>>>> +                             force);
>>>>>> 'state' -> 'status'
>>>>>>
>>>>> Okay.
>>>>>
>>>>>>> +    struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>>>>>>> +
>>>>>>> +    if (priv->dp.phys_state == connector_status_connected)
>>>>>>> +        return vdac->phys_state = state;
>>>>>> Please only one statement per line. First assign, then return.
>>>>>>
>>>>> Yes, Sorry about that. According to the Linux kernel coding guidelines, this line of code should be split.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Yongbang.
>>>>>
>>>>>>> +
>>>>>>> +    if (state != vdac->phys_state)
>>>>>>> +        ++connector->epoch_counter;
>>>>>>> +    vdac->phys_state = state;
>>>>>>> +
>>>>>>> +    /* If both the DP and VDAC physical states are disconnected,
>>>>>>> +     * the "connected" status is returned to support KVM display.
>>>>>>> +     */
>>>>>>> +    return connector_status_connected;
>>>>>> I haven't tried, but I think this should also resolve the problems on my test systems. Great, thanks a lot! I might
>>>>>> just
>>>>>> get default resolutions for now, but that's OK.
>>>>>>
>>>>>> Best regards
>>>>>> Thomas
>>>>>>
>>>>>>> +}
>>>>>>> +
>>>>>>>      static const struct drm_connector_helper_funcs
>>>>>>>          hibmc_connector_helper_funcs = {
>>>>>>>          .get_modes = hibmc_connector_get_modes,
>>>>>>> -    .detect_ctx = drm_connector_helper_detect_from_ddc,
>>>>>>> +    .detect_ctx = hibmc_vdac_detect,
>>>>>>>      };
>>>>>>>        static const struct drm_connector_funcs hibmc_connector_funcs = {
>>>>>>> @@ -130,6 +145,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>>>>>>            connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
>>>>>>>      +    vdac->phys_state = connector_status_connected;
>>>>>>> +
>>>>>>>          return 0;
>>>>>>>        err:

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


