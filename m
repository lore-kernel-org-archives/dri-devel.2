Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D2CD6E6B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F5211A569;
	Fri,  5 Jun 2026 08:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Z9tNDk3B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDfkZB+K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z9tNDk3B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDfkZB+K";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900C311A569
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:02:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 055E7759F2;
 Fri,  5 Jun 2026 08:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780646554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dL21IXZ33aV0sI0+peOO6W68IZUEF6BiuYfQgAZXuqw=;
 b=Z9tNDk3BR/JVyMKcEMIJQ4fRj725nrtY2NZm4MOMRCy36Vy3nwOO9g79zgKPYzmrjh44xd
 b1CG5ToS0+NwjXxc1IEUvQOvMuccG6Blo94vs9OXuK36LtqhS/Glt5PzCIOcqCcGoF/XVe
 KCC/eXiOr6nKeIOm/lgNLW81GDzH66E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780646554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dL21IXZ33aV0sI0+peOO6W68IZUEF6BiuYfQgAZXuqw=;
 b=qDfkZB+KTSfoVkfHnITAjUEJ0m0Uc6tePICNMQKI8aIp7wfrBIRCm2W/vlJ6xd6Ibx82+a
 KdXi8Swkg64sm8Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z9tNDk3B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qDfkZB+K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780646554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dL21IXZ33aV0sI0+peOO6W68IZUEF6BiuYfQgAZXuqw=;
 b=Z9tNDk3BR/JVyMKcEMIJQ4fRj725nrtY2NZm4MOMRCy36Vy3nwOO9g79zgKPYzmrjh44xd
 b1CG5ToS0+NwjXxc1IEUvQOvMuccG6Blo94vs9OXuK36LtqhS/Glt5PzCIOcqCcGoF/XVe
 KCC/eXiOr6nKeIOm/lgNLW81GDzH66E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780646554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dL21IXZ33aV0sI0+peOO6W68IZUEF6BiuYfQgAZXuqw=;
 b=qDfkZB+KTSfoVkfHnITAjUEJ0m0Uc6tePICNMQKI8aIp7wfrBIRCm2W/vlJ6xd6Ibx82+a
 KdXi8Swkg64sm8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF45A779A8;
 Fri,  5 Jun 2026 08:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qRgNLJmCImovUwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 05 Jun 2026 08:02:33 +0000
Message-ID: <bfdf1fbe-d61c-4bf7-b6f0-d5c676224af4@suse.de>
Date: Fri, 5 Jun 2026 10:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gem: fix warning in idr_alloc due to unvalidated user
 handle
To: =?UTF-8?B?546L5piO54Wc?= <25181214217@stu.xidian.edu.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260422114247.486581-1-25181214217@stu.xidian.edu.cn>
 <388db131.142.19e95bef999.Coremail.25181214217@stu.xidian.edu.cn>
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
In-Reply-To: <388db131.142.19e95bef999.Coremail.25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 055E7759F2
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[stu.xidian.edu.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email, lists.freedesktop.org:email,
 ffwll.ch:email, suse.com:url, bootlin.com:url, xidian.edu.cn:email,
 suse.de:dkim, suse.de:email, suse.de:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 05.06.26 um 05:06 schrieb 王明煜:
> Hi maintainers,
>
> Just a gentle ping on this patch. It fixes a WARN triggered during fuzzing when negative user handles are passed.
>
> Please let me know if it needs any revisions or if there is anything else I can do to help move it forward.
>
> Thanks,
> Mingyu
>
>
>> -----原始邮件-----
>> 发件人: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
>> 发送时间:2026-04-22 19:42:47 (星期三)
>> 收件人: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
>> 抄送: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidian.edu.cn>
>> 主题: [PATCH] drm/gem: fix warning in idr_alloc due to unvalidated user handle
>>
>> During fuzzing, a warning was triggered in idr_alloc() when handling
>> the DRM_IOCTL_GEM_CHANGE_HANDLE (or similar) ioctl.
>>
>> The function drm_gem_change_handle_ioctl() currently only checks if
>> args->new_handle is strictly greater than INT_MAX. However, it fails
>> to check for negative values. If a userpace application passes a
>> negative handle, it bypasses the upper-bound check and is passed
>> directly to idr_alloc() as the 'start' parameter, triggering the
>> WARN_ON_ONCE(start < 0) inside idr_alloc().

args->new_handle is unsigned.  IIRC, for the test, INT_MAX should be 
interpreted as unsigned as well. So how can it get across the INT_MAX 
test? There's an explicit cast to int at [1], which might have an effect 
here.

Does it work of you explicitly cast INT_MAX to u32 in that test?

I'm also worried about interpreting the handle as signed and then adding 
+1 to it. [2]  idr_alloc() appears to handle it gracefully, [3] but it 
still looks fishy.

[1] https://elixir.bootlin.com/linux/v7.0.11/source/include/vdso/limits.h#L8
[2] 
https://elixir.bootlin.com/linux/v7.0.11/source/drivers/gpu/drm/drm_gem.c#L1033
[3] https://elixir.bootlin.com/linux/v7.0.11/source/lib/idr.c#L89

Best regards
Thomas

>>
>> Fix this by explicitly validating that the user-provided handle is
>> strictly positive and within the valid IDR range.
>>
>> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>> ---
>>   drivers/gpu/drm/drm_gem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index d6424267260b..3d84d4f1c3e0 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1026,7 +1026,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>>   		return -EOPNOTSUPP;
>>   
>>   	/* idr_alloc() limitation. */
>> -	if (args->new_handle > INT_MAX)
>> +	if (args->new_handle <= 0 || args->new_handle > INT_MAX)
>>   		return -EINVAL;
>>   	handle = args->new_handle;
>>   
>> -- 
>> 2.34.1

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


