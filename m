Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFE3CD98F8
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA49A10F4B3;
	Fri, 19 Jun 2026 08:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yAa7SG4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aS3qnGtv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAa7SG4u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aS3qnGtv";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A994810F4B3
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 08:50:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A0C275FCB;
 Fri, 19 Jun 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781859025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1RNwsuFgZ14kn/jzgqyv0gdCOLvVb7eIlc2eU5toI0E=;
 b=yAa7SG4uBA17uB1Xg45aeCe5g0Cl7/JnzENdFbSooIfkAYED1hBQ6XeKxKLQEFBTgzXuCQ
 7J6+Y1KhuMGHOwrxSIqz9zMa6ewjK3q6MWY43DtB0yUYBOZigAnYsGjA9rz3ilYg8+R45P
 RgpU8x2qvpwd7Dalj2dFp26bbk1xDTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781859025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1RNwsuFgZ14kn/jzgqyv0gdCOLvVb7eIlc2eU5toI0E=;
 b=aS3qnGtvZfoa7DSnijgeqyflSOUrOkXCWHxvAdHj2S0w6AZnz2hhWZU7ic9CkjH532p8rG
 iJot/S5WVzbSccDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yAa7SG4u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aS3qnGtv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781859025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1RNwsuFgZ14kn/jzgqyv0gdCOLvVb7eIlc2eU5toI0E=;
 b=yAa7SG4uBA17uB1Xg45aeCe5g0Cl7/JnzENdFbSooIfkAYED1hBQ6XeKxKLQEFBTgzXuCQ
 7J6+Y1KhuMGHOwrxSIqz9zMa6ewjK3q6MWY43DtB0yUYBOZigAnYsGjA9rz3ilYg8+R45P
 RgpU8x2qvpwd7Dalj2dFp26bbk1xDTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781859025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1RNwsuFgZ14kn/jzgqyv0gdCOLvVb7eIlc2eU5toI0E=;
 b=aS3qnGtvZfoa7DSnijgeqyflSOUrOkXCWHxvAdHj2S0w6AZnz2hhWZU7ic9CkjH532p8rG
 iJot/S5WVzbSccDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA1F4779A8;
 Fri, 19 Jun 2026 08:50:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QpcqNNACNWrgSgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 08:50:24 +0000
Content-Type: multipart/mixed; boundary="------------A02MuYS0LUjC7ZHA3gGhySn0"
Message-ID: <1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de>
Date: Fri, 19 Jun 2026 10:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 sashiko-reviews@lists.linux.dev, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, Andreas Kemnade <akemnade@kernel.org>
References: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
 <20260618174310.70DB11F000E9@smtp.kernel.org>
 <50FDBC3B-BFC2-4BC6-B216-78C2C24D9E30@goldelico.com>
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
In-Reply-To: <50FDBC3B-BFC2-4BC6-B216-78C2C24D9E30@goldelico.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0A0C275FCB
X-Spamd-Result: default: False [-3.41 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_BASE64_TEXT_BOGUS(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
 MIME_BASE64_TEXT(0.10)[]; MX_GOOD(-0.01)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:+];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,goldelico.com:email,sashiko.dev:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 HAS_ATTACHMENT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 sashiko.dev:url, suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
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

This is a multi-part message in MIME format.
--------------A02MuYS0LUjC7ZHA3gGhySn0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(cc Icenowy)

Hi,

there are a number of similar reports. Does the attached patch fix the 
problem. It picks up what you do, but in a more correct way.

Best regards
Thomas

Am 18.06.26 um 19:56 schrieb H. Nikolaus Schaller:
>
>> Am 18.06.2026 um 19:43 schrieb sashiko-bot@kernel.org:
>>
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [High] Lockless access to `crtc->state` and `crtc->primary->state` can lead to a Use-After-Free due to concurrent atomic commits.
>> - [High] The patch breaks vblank synchronization for legacy (non-atomic) DRM drivers.
>> - [Medium] The logic selects the first matching CRTC instead of the last active one, contradicting the commit message.
>> --
>>
>> commit 0337b26b606b4d905d72ea2be31bcb984fe62c6e
>> Author: H. Nikolaus Schaller <hns@goldelico.com>
>>
>> drm/fb_helper: Determine proper crtc_index within drm_fb_helper_fb_dirty
>>
>> This commit updates the dirty framebuffer worker to search for a matching
>> active CRTC instead of hardcoding the wait for vblank to CRTC index 0. It
>> aims to avoid vblank timeouts when CRTC 0 is inactive.
>>
>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> [ ... ]
>>> @@ -232,9 +232,23 @@ static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
>>> struct drm_clip_rect clip_copy;
>>> unsigned long flags;
>>> int ret;
>>> + unsigned int crtc_index = 0;
>>> + struct drm_crtc *crtc;
>>>
>>> mutex_lock(&helper->lock);
>>> - drm_client_modeset_wait_for_vblank(&helper->client, 0);
>>> +
>>> + drm_for_each_crtc(crtc, dev) {
>>> + if (crtc->primary && crtc->primary->state &&
>>> +    crtc->primary->state->fb == helper->fb &&
>>> +    crtc->state && crtc->state->active) {
>> [Severity: High]
>> Can this lockless access to crtc->state and crtc->primary->state result in a
>> use-after-free?
> No idea...
>
>> The drm_fb_helper_fb_dirty() function holds helper->lock, but does not hold
>> the DRM modeset locks required to protect these state pointers. During a
> Which locks are exactly recommended to add? What is their name/pointer?
>
>> concurrent atomic modeset commit, the DRM core allocates new state objects,
>> swaps them into place, and frees the old objects via kfree().
>>
>> If this code reads an old state pointer and gets preempted, could it then
>> dereference the pointer after it has been freed by the concurrent commit?
>>
>> [Severity: High]
>> Does this break vblank synchronization for legacy non-atomic DRM drivers?
>> Legacy drivers do not use the atomic modesetting infrastructure, so their
>> crtc->state and crtc->primary->state pointers remain NULL. Since the condition
>> above requires these pointers to be non-NULL, the loop will skip the vblank
>> wait entirely for legacy drivers. This skips the intended rate-limiting
>> behavior and could lead to unbounded damage worker execution.
> What is the solution? And is this important.
>
> Before d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
>
> there was also no rate-limiting behavior.
>
>>> + crtc_index = drm_crtc_index(crtc) + 1;
>>> + break;
>> [Severity: Medium]
>> The commit message states "If multiple CRTCs match, the last active one is
>> selected." Does the break statement here cause the first active CRTC to be
>> selected instead, bypassing the remaining matches in the list?
> Yes, that is correct. The description is indeed wrong.
>
>>> + }
>>> + }
>>> +
>>> + if (crtc_index > 0)
>>> + drm_client_modeset_wait_for_vblank(&helper->client, crtc_index - 1);
>>> +
>>> mutex_unlock(&helper->lock);
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com?part=1

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------A02MuYS0LUjC7ZHA3gGhySn0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-fb-helper-Only-consider-active-CRTCs-for-vblank-.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-fb-helper-Only-consider-active-CRTCs-for-vblank-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5Zjk0ZTE5ZDg4N2VkNGU0NTZkZWQ4MWQwNzVlOTMwMDViZDYwZDFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogRnJpLCAxOSBKdW4gMjAyNiAxMDozMTozOCArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGRybS9mYi1oZWxwZXI6IE9ubHkgY29uc2lkZXIgYWN0aXZlIENSVENzIGZv
ciB2Ymxhbmsgc3luYwoKT25seSBzeW5jaHJvbml6ZSBmYmRldiBvdXRwdXQgdG8gdGhlIHZi
bGFuayBvZiBhY3RpdmUgQ1JUQ3MuIEdvIG92ZXIKdGhlIGxpc3Qgb2YgQ1JUQ3MgYW5kIHBp
Y2sgdGhlIGZpcnN0IHRoYXQgbWF0Y2hlcy4gRml4ZXMgd2FybmluZ3MgYXMKdGhlIG9uZSBz
aG93biBiZWxvdwoKWyAgIDc3LjIwMTM1NF0gV0FSTklORzogZHJpdmVycy9ncHUvZHJtL2Ry
bV92YmxhbmsuYzoxMzIwIGF0IGRybV9jcnRjX3dhaXRfb25lX3ZibGFuaysweDE5NC8weDFj
YyBbZHJtXSwgQ1BVIzE6IGt3b3JrZXIvMTo3LzE4NjcKWyAgIDc3LjIwMTM1NF0gb21hcGRy
bSBvbWFwZHJtLjA6IFtkcm1dIHZibGFuayB3YWl0IHRpbWVkIG91dCBvbiBjcnRjIDAKClRo
aXMgY3VycmVudGx5IGhhcHBlbnMgaWYgdGhlIGZiZGV2IG91dHB1dCBpcyBub3Qgb24gQ1JU
QyAwLgoKVGhlIHBhdGNoIGRpc2FibGVzIHZibGFuayBzeW5jIG9uIHRoZSBmZXcgZHJpdmVy
cyB0aGF0IHN0aWxsIGRvIG5vdAppbXBsZW1lbnQgYXRvbWljIG1vZGVzZXR0aW5nLiBJdCdz
IG5vdCBhdCBhbGwgYSBjcml0aWNhbCBmZWF0dXJlIHRob3VnaC4KClNpZ25lZC1vZmYtYnk6
IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgpGaXhlczogZDhjNGJk
ZGNkOGJjYiAoImRybS9mYi1oZWxwZXI6IFN5bmNocm9uaXplIGRpcnR5IHdvcmtlciB3aXRo
IHZibGFuayIpCi0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYyB8IDMyICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2ZiX2hlbHBlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYwpp
bmRleCA3YjExYTU4MmY4ZWMuLjM3ZTRkMzNhNmQ0OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2RybV9mYl9oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hl
bHBlci5jCkBAIC0yMzAsMTIgKzIzMCwzOCBAQCBzdGF0aWMgdm9pZCBkcm1fZmJfaGVscGVy
X2ZiX2RpcnR5KHN0cnVjdCBkcm1fZmJfaGVscGVyICpoZWxwZXIpCiAJc3RydWN0IGRybV9k
ZXZpY2UgKmRldiA9IGhlbHBlci0+ZGV2OwogCXN0cnVjdCBkcm1fY2xpcF9yZWN0ICpjbGlw
ID0gJmhlbHBlci0+ZGFtYWdlX2NsaXA7CiAJc3RydWN0IGRybV9jbGlwX3JlY3QgY2xpcF9j
b3B5OworCXN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lOworCWludCBjcnRjX2luZGV4ID0gLTE7
CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlpbnQgcmV0OwogCi0JbXV0ZXhfbG9jaygmaGVs
cGVyLT5sb2NrKTsKLQlkcm1fY2xpZW50X21vZGVzZXRfd2FpdF9mb3JfdmJsYW5rKCZoZWxw
ZXItPmNsaWVudCwgMCk7Ci0JbXV0ZXhfdW5sb2NrKCZoZWxwZXItPmxvY2spOworCWlmIChk
cm1fZHJ2X3VzZXNfYXRvbWljX21vZGVzZXQoZGV2KSkgeworCQltdXRleF9sb2NrKCZoZWxw
ZXItPmxvY2spOworCQltdXRleF9sb2NrKCZkZXYtPm1vZGVfY29uZmlnLm11dGV4KTsKKwor
CQlkcm1fZm9yX2VhY2hfcGxhbmUocGxhbmUsIGRldikgeworCQkJY29uc3Qgc3RydWN0IGRy
bV9wbGFuZV9zdGF0ZSAqcGxhbmVfc3RhdGU7CisJCQljb25zdCBzdHJ1Y3QgZHJtX2NydGMg
KmNydGM7CisKKwkJCWlmIChwbGFuZS0+dHlwZSAhPSBEUk1fUExBTkVfVFlQRV9QUklNQVJZ
KQorCQkJCWNvbnRpbnVlOyAvKiBub3QgYSBwcmltYXJ5IHBsYW5lICovCisKKwkJCXBsYW5l
X3N0YXRlID0gcGxhbmUtPnN0YXRlOworCQkJaWYgKHBsYW5lX3N0YXRlLT5mYiAhPSBoZWxw
ZXItPmZiIHx8ICFwbGFuZV9zdGF0ZS0+Y3J0YykKKwkJCQljb250aW51ZTsgLyogcGxhbmUg
ZG9lc24ndCBkaXNwbGF5IGZiZGV2IGVtdWxhdGlvbiAqLworCisJCQljcnRjID0gcGxhbmVf
c3RhdGUtPmNydGM7CisJCQlpZiAoY3J0Yy0+c3RhdGUtPmFjdGl2ZSkgeworCQkJCWNydGNf
aW5kZXggPSBjcnRjLT5pbmRleDsKKwkJCQlicmVhazsKKwkJCX0KKwkJfQorCQltdXRleF91
bmxvY2soJmRldi0+bW9kZV9jb25maWcubXV0ZXgpOworCisJCWlmIChjcnRjX2luZGV4ID49
IDApCisJCQlkcm1fY2xpZW50X21vZGVzZXRfd2FpdF9mb3JfdmJsYW5rKCZoZWxwZXItPmNs
aWVudCwgY3J0Y19pbmRleCk7CisJCW11dGV4X3VubG9jaygmaGVscGVyLT5sb2NrKTsKKwl9
CiAKIAlpZiAoZHJtX1dBUk5fT05fT05DRShkZXYsICFoZWxwZXItPmZ1bmNzLT5mYl9kaXJ0
eSkpCiAJCXJldHVybjsKLS0gCjIuNTQuMAoK

--------------A02MuYS0LUjC7ZHA3gGhySn0--
