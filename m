Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757C8FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE87A10E70E;
	Mon, 27 Apr 2026 12:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="y0xLLgnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOSevaXi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y0xLLgnU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rOSevaXi";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF6310E70E
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:14:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 371855BD1F;
 Mon, 27 Apr 2026 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777292089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=njxCauCZxlzSWAss63Wl7LXH7/t0kKSMJ7qgvNUNE0o=;
 b=y0xLLgnUYw9fGSmS/faXWuffbBuEBRwUHJM4sLd4kMEVmHCcmB8hKialzJ0RZzEdhy+Ds4
 hSVjjUoEucPrWsmJZGIe3iwQJUYHn+74mTBc1jg5nyg4RI9MeGlM2zRiEIYvSLZQbP29AJ
 Mgq9YGqmvF7HcT6KmOl5ZiH8vsEQzWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777292089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=njxCauCZxlzSWAss63Wl7LXH7/t0kKSMJ7qgvNUNE0o=;
 b=rOSevaXip9mX9JIUj1XkDMZ49qz1BinHpHTiLVOZdjvq03et8aBzrcbaWWqeJFo7hY9J+R
 Lh09oc7v7fZROZAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y0xLLgnU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rOSevaXi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777292089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=njxCauCZxlzSWAss63Wl7LXH7/t0kKSMJ7qgvNUNE0o=;
 b=y0xLLgnUYw9fGSmS/faXWuffbBuEBRwUHJM4sLd4kMEVmHCcmB8hKialzJ0RZzEdhy+Ds4
 hSVjjUoEucPrWsmJZGIe3iwQJUYHn+74mTBc1jg5nyg4RI9MeGlM2zRiEIYvSLZQbP29AJ
 Mgq9YGqmvF7HcT6KmOl5ZiH8vsEQzWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777292089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=njxCauCZxlzSWAss63Wl7LXH7/t0kKSMJ7qgvNUNE0o=;
 b=rOSevaXip9mX9JIUj1XkDMZ49qz1BinHpHTiLVOZdjvq03et8aBzrcbaWWqeJFo7hY9J+R
 Lh09oc7v7fZROZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF347593B0;
 Mon, 27 Apr 2026 12:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Yt7ODhT72lACwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 12:14:48 +0000
Content-Type: multipart/mixed; boundary="------------v0w3YAjrqmYxNRyLtTsTIhau"
Message-ID: <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
Date: Mon, 27 Apr 2026 14:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: Jacob Keller <jacob.e.keller@intel.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
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
In-Reply-To: <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
X-Spamd-Result: default: False [-3.41 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_BASE64_TEXT_BOGUS(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
 MIME_BASE64_TEXT(0.10)[]; MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+,1:+,2:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; HAS_ATTACHMENT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 371855BD1F
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
--------------v0w3YAjrqmYxNRyLtTsTIhau
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 25.04.26 um 01:29 schrieb Jacob Keller:
[...]
>>
>> So I suggest to pick Manufacturer, Product, Version as key. I'd be
>> surprised if we find more than a hand full of systems with the issue. If
>> we see a trend or common pattern, we can generalize later on.
>>
> I think this is the best solution. Keep it focused for now. I believe
> Intel has two major platforms that we care about with respect to this
> issue. I'll see if I can dig up the data. The systems install the MGA
> G200 for BMC use but don't seem to expose the VGA connection.
>
> For the specific system I have that was faulty, we have the following:
>
> $ for t in system-manufacturer system-product-name system-version ; \
>      do dmidecode -s ${t}; \
> done
> Dell Inc.
> PowerEdge XR8720t
> Not Specified
>
>
>
> I believe there was also some concern about HP systems which similarly
> use this chipset, but I don't have the DMI data for that one off hand.
> I've asked some colleagues to confirm the situation and obtain that
> data. I'll get back early next week if we think there are any other
> systems possibly affected.
>
> In the mean time, I'm happy to have our team test any patch to confirm
> that it behaves as expected and resolves the service interruptions.

For now, I've modified the two places that have BMC support in the 
driver. Could you please also tell me your system's exact Matrox chipset 
or its PCI id?

The patch is attached for your testing. It would work against drm-tip or 
v7.1-rc1.

I've also found the page at [1], which claims that there's a Mini-DP 
port at the front. If so, I'd assume that there's also an extra encoder 
chip to replace the VGA. If we ever get specs for that, we could 
implement real support in the driver.

In the meantime, the current fix should work. In the worst case, that 
Mini-DP port would give a lower default resolution.

[1] 
https://www.dell.com/en-us/shop/ipovw/poweredge-xr8720t?hve=shop+now#techspecs_section

Best regards
Thomas




>
> Appreciate all the feedback on this thread.
>
> Thanks,
> Jake

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------v0w3YAjrqmYxNRyLtTsTIhau
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-mgag200-Add-BMC-only-connector.patch"
Content-Disposition: attachment;
 filename="0001-drm-mgag200-Add-BMC-only-connector.patch"
Content-Transfer-Encoding: base64

RnJvbSA5NWQ3MmMyZTRhYmVmOWZjNDU0MzMwNzZkM2IxMzAzMzZjNzM0ZTc1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogRnJpLCAyNCBBcHIgMjAyNiAwOTowNToxNCArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGRybS9tZ2FnMjAwOiBBZGQgQk1DLW9ubHkgY29ubmVjdG9yCgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfYm1jLmMgICAgIHwgMTA5ICsrKysrKysr
KysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZHJ2Lmgg
ICAgIHwgICA3ICstCiBkcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2cyMDBldzMu
YyB8ICAxNyArKystCiBkcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2cyMDB3Yi5j
ICB8ICAxNyArKystCiA0IGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcy
MDBfYm1jLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2JtYy5jCmluZGV4
IGJiZGViNzkxYzViMy4uOGQ5NzRlMmMxODEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWdhZzIwMC9tZ2FnMjAwX2JtYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAw
L21nYWcyMDBfYm1jLmMKQEAgLTYsNiArNiw4IEBACiAjaW5jbHVkZSA8ZHJtL2RybV9hdG9t
aWNfaGVscGVyLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9lZGlkLmg+CiAjaW5jbHVkZSA8ZHJt
L2RybV9tYW5hZ2VkLmg+CisjaW5jbHVkZSA8ZHJtL2RybV9tb2Rlc2V0X2hlbHBlcl92dGFi
bGVzLmg+CisjaW5jbHVkZSA8ZHJtL2RybV9wcmludC5oPgogI2luY2x1ZGUgPGRybS9kcm1f
cHJvYmVfaGVscGVyLmg+CiAKICNpbmNsdWRlICJtZ2FnMjAwX2Rydi5oIgpAQCAtOTAsMyAr
OTIsMTEwIEBAIHZvaWQgbWdhZzIwMF9ibWNfc3RhcnRfc2Nhbm91dChzdHJ1Y3QgbWdhX2Rl
dmljZSAqbWRldikKIAl0bXAgJj0gfjB4MTA7CiAJV1JFR19EQUMoTUdBMTA2NF9HRU5fSU9f
REFUQSwgdG1wKTsKIH0KKworc3RhdGljIHZvaWQgbWdhZzIwMF9ibWNfZW5jb2Rlcl9hdG9t
aWNfZGlzYWJsZShzdHJ1Y3QgZHJtX2VuY29kZXIgKmVuY29kZXIsCisJCQkJCSAgICAgICBz
dHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpCit7CisJc3RydWN0IG1nYV9kZXZpY2Ug
Km1kZXYgPSB0b19tZ2FfZGV2aWNlKGVuY29kZXItPmRldik7CisKKwlpZiAobWRldi0+aW5m
by0+c3luY19ibWMpCisJCW1nYWcyMDBfYm1jX3N0b3Bfc2Nhbm91dChtZGV2KTsKK30KKwor
c3RhdGljIHZvaWQgbWdhZzIwMF9ibWNfZW5jb2Rlcl9hdG9taWNfZW5hYmxlKHN0cnVjdCBk
cm1fZW5jb2RlciAqZW5jb2RlciwKKwkJCQkJICAgICAgc3RydWN0IGRybV9hdG9taWNfc3Rh
dGUgKnN0YXRlKQoreworCXN0cnVjdCBtZ2FfZGV2aWNlICptZGV2ID0gdG9fbWdhX2Rldmlj
ZShlbmNvZGVyLT5kZXYpOworCisJaWYgKG1kZXYtPmluZm8tPnN5bmNfYm1jKQorCQltZ2Fn
MjAwX2JtY19zdGFydF9zY2Fub3V0KG1kZXYpOworfQorCitzdGF0aWMgaW50IG1nYWcyMDBf
Ym1jX2VuY29kZXJfYXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwK
KwkJCQkJICAgIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqbmV3X2NydGNfc3RhdGUsCisJCQkJ
CSAgICBzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAqbmV3X2Nvbm5lY3Rvcl9zdGF0ZSkK
K3sKKwlzdHJ1Y3QgbWdhX2RldmljZSAqbWRldiA9IHRvX21nYV9kZXZpY2UoZW5jb2Rlci0+
ZGV2KTsKKwlzdHJ1Y3QgbWdhZzIwMF9jcnRjX3N0YXRlICpuZXdfbWdhZzIwMF9jcnRjX3N0
YXRlID0gdG9fbWdhZzIwMF9jcnRjX3N0YXRlKG5ld19jcnRjX3N0YXRlKTsKKworCW5ld19t
Z2FnMjAwX2NydGNfc3RhdGUtPnNldF92aWRyc3QgPSBtZGV2LT5pbmZvLT5zeW5jX2JtYzsK
KworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9lbmNvZGVyX2hl
bHBlcl9mdW5jcyBtZ2FnMjAwX2JtY19lbmNvZGVyX2hlbHBlcl9mdW5jcyA9IHsKKwkuYXRv
bWljX2Rpc2FibGUgPSBtZ2FnMjAwX2JtY19lbmNvZGVyX2F0b21pY19kaXNhYmxlLAorCS5h
dG9taWNfZW5hYmxlID0gbWdhZzIwMF9ibWNfZW5jb2Rlcl9hdG9taWNfZW5hYmxlLAorCS5h
dG9taWNfY2hlY2sgPSBtZ2FnMjAwX2JtY19lbmNvZGVyX2F0b21pY19jaGVjaywKK307CisK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2VuY29kZXJfZnVuY3MgbWdhZzIwMF9ibWNfZW5j
b2Rlcl9mdW5jcyA9IHsKKwkuZGVzdHJveSA9IGRybV9lbmNvZGVyX2NsZWFudXAKK307CisK
K3N0YXRpYyBpbnQgbWdhZzIwMF9ibWNfY29ubmVjdG9yX2hlbHBlcl9nZXRfbW9kZXMoc3Ry
dWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcikKK3sKKwlzdHJ1Y3QgbWdhX2RldmljZSAq
bWRldiA9IHRvX21nYV9kZXZpY2UoY29ubmVjdG9yLT5kZXYpOworCWNvbnN0IHN0cnVjdCBt
Z2FnMjAwX2RldmljZV9pbmZvICptaW5mbyA9IG1kZXYtPmluZm87CisJaW50IGNvdW50Owor
CisJLyoKKwkgKiBUaGVyZSdzIG5vIEVESUQgZGF0YSB3aXRob3V0IGEgY29ubmVjdGVkIG1v
bml0b3IuIFNldCBCTUMtCisJICogY29tcGF0aWJsZSBtb2RlcyBpbiB0aGlzIGNhc2UuIFRo
ZSBYR0EgZGVmYXVsdCByZXNvbHV0aW9uCisJICogc2hvdWxkIHdvcmsgd2VsbCBmb3IgYWxs
IEJNQ3MuCisJICovCisJY291bnQgPSBkcm1fYWRkX21vZGVzX25vZWRpZChjb25uZWN0b3Is
IG1pbmZvLT5tYXhfaGRpc3BsYXksIG1pbmZvLT5tYXhfdmRpc3BsYXkpOworCWlmIChjb3Vu
dCkKKwkJZHJtX3NldF9wcmVmZXJyZWRfbW9kZShjb25uZWN0b3IsIDEwMjQsIDc2OCk7CisK
KwlyZXR1cm4gY291bnQ7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2Nvbm5lY3Rv
cl9oZWxwZXJfZnVuY3MgbWdhZzIwMF9ibWNfY29ubmVjdG9yX2hlbHBlcl9mdW5jcyA9IHsK
KwkuZ2V0X21vZGVzID0gbWdhZzIwMF9ibWNfY29ubmVjdG9yX2hlbHBlcl9nZXRfbW9kZXMs
Cit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9jb25uZWN0b3JfZnVuY3MgbWdhZzIw
MF9ibWNfY29ubmVjdG9yX2Z1bmNzID0geworCS5yZXNldCAgICAgICAgICAgICAgICAgID0g
ZHJtX2F0b21pY19oZWxwZXJfY29ubmVjdG9yX3Jlc2V0LAorCS5maWxsX21vZGVzICAgICAg
ICAgICAgID0gZHJtX2hlbHBlcl9wcm9iZV9zaW5nbGVfY29ubmVjdG9yX21vZGVzLAorCS5k
ZXN0cm95ICAgICAgICAgICAgICAgID0gZHJtX2Nvbm5lY3Rvcl9jbGVhbnVwLAorCS5hdG9t
aWNfZHVwbGljYXRlX3N0YXRlID0gZHJtX2F0b21pY19oZWxwZXJfY29ubmVjdG9yX2R1cGxp
Y2F0ZV9zdGF0ZSwKKwkuYXRvbWljX2Rlc3Ryb3lfc3RhdGUgICA9IGRybV9hdG9taWNfaGVs
cGVyX2Nvbm5lY3Rvcl9kZXN0cm95X3N0YXRlCit9OworCitpbnQgbWdhZzIwMF9ibWNfb3V0
cHV0X2luaXQoc3RydWN0IG1nYV9kZXZpY2UgKm1kZXYpCit7CisJc3RydWN0IGRybV9kZXZp
Y2UgKmRldiA9ICZtZGV2LT5iYXNlOworCXN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9ICZtZGV2
LT5jcnRjOworCXN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlcjsKKwlzdHJ1Y3QgZHJtX2Nv
bm5lY3RvciAqY29ubmVjdG9yOworCWludCByZXQ7CisKKwllbmNvZGVyID0gJm1kZXYtPm91
dHB1dC5ibWMuZW5jb2RlcjsKKwlyZXQgPSBkcm1fZW5jb2Rlcl9pbml0KGRldiwgZW5jb2Rl
ciwgJm1nYWcyMDBfYm1jX2VuY29kZXJfZnVuY3MsCisJCQkgICAgICAgRFJNX01PREVfRU5D
T0RFUl9WSVJUVUFMLCBOVUxMKTsKKwlpZiAocmV0KSB7CisJCWRybV9lcnIoZGV2LCAiZHJt
X2VuY29kZXJfaW5pdCgpIGZhaWxlZDogJWRcbiIsIHJldCk7CisJCXJldHVybiByZXQ7CisJ
fQorCWRybV9lbmNvZGVyX2hlbHBlcl9hZGQoZW5jb2RlciwgJm1nYWcyMDBfYm1jX2VuY29k
ZXJfaGVscGVyX2Z1bmNzKTsKKworCWVuY29kZXItPnBvc3NpYmxlX2NydGNzID0gZHJtX2Ny
dGNfbWFzayhjcnRjKTsKKworCWNvbm5lY3RvciA9ICZtZGV2LT5vdXRwdXQuYm1jLmNvbm5l
Y3RvcjsKKwlyZXQgPSBkcm1fY29ubmVjdG9yX2luaXQoZGV2LCBjb25uZWN0b3IsICZtZ2Fn
MjAwX2JtY19jb25uZWN0b3JfZnVuY3MsCisJCQkJIERSTV9NT0RFX0NPTk5FQ1RPUl9WR0Ep
OworCWlmIChyZXQpIHsKKwkJZHJtX2VycihkZXYsICJkcm1fY29ubmVjdG9yX2luaXQoKSBm
YWlsZWQ6ICVkXG4iLCByZXQpOworCQlyZXR1cm4gcmV0OworCX0KKwlkcm1fY29ubmVjdG9y
X2hlbHBlcl9hZGQoY29ubmVjdG9yLCAmbWdhZzIwMF9ibWNfY29ubmVjdG9yX2hlbHBlcl9m
dW5jcyk7CisKKwlyZXQgPSBkcm1fY29ubmVjdG9yX2F0dGFjaF9lbmNvZGVyKGNvbm5lY3Rv
ciwgZW5jb2Rlcik7CisJaWYgKHJldCkgeworCQlkcm1fZXJyKGRldiwgImRybV9jb25uZWN0
b3JfYXR0YWNoX2VuY29kZXIoKSBmYWlsZWQ6ICVkXG4iLCByZXQpOworCQlyZXR1cm4gcmV0
OworCX0KKworCXJldHVybiAwOworfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21n
YWcyMDAvbWdhZzIwMF9kcnYuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBf
ZHJ2LmgKaW5kZXggYTg3NWM0YmY4Y2JlLi5mMTI2ZjZkNjFlZDAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZHJ2LmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21nYWcyMDAvbWdhZzIwMF9kcnYuaApAQCAtMjc5LDcgKzI3OSwxMSBAQCBzdHJ1Y3Qg
bWdhX2RldmljZSB7CiAKIAlzdHJ1Y3QgZHJtX3BsYW5lIHByaW1hcnlfcGxhbmU7CiAJc3Ry
dWN0IGRybV9jcnRjIGNydGM7Ci0Jc3RydWN0IHsKKwl1bmlvbiB7CisJCXN0cnVjdCB7CisJ
CQlzdHJ1Y3QgZHJtX2VuY29kZXIgZW5jb2RlcjsKKwkJCXN0cnVjdCBkcm1fY29ubmVjdG9y
IGNvbm5lY3RvcjsKKwkJfSBibWM7CiAJCXN0cnVjdCB7CiAJCQlzdHJ1Y3QgZHJtX2VuY29k
ZXIgZW5jb2RlcjsKIAkJCXN0cnVjdCBkcm1fY29ubmVjdG9yIGNvbm5lY3RvcjsKQEAgLTQz
NSw1ICs0MzksNiBAQCBpbnQgbWdhZzIwMF92Z2Ffb3V0cHV0X2luaXQoc3RydWN0IG1nYV9k
ZXZpY2UgKm1kZXYpOwogLyogbWdhZzIwMF9ibWMuYyAqLwogdm9pZCBtZ2FnMjAwX2JtY19z
dG9wX3NjYW5vdXQoc3RydWN0IG1nYV9kZXZpY2UgKm1kZXYpOwogdm9pZCBtZ2FnMjAwX2Jt
Y19zdGFydF9zY2Fub3V0KHN0cnVjdCBtZ2FfZGV2aWNlICptZGV2KTsKK2ludCBtZ2FnMjAw
X2JtY19vdXRwdXRfaW5pdChzdHJ1Y3QgbWdhX2RldmljZSAqbWRldik7CiAKICNlbmRpZgkJ
CQkvKiBfX01HQUcyMDBfRFJWX0hfXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21nYWcyMDAvbWdhZzIwMF9nMjAwZXczLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9t
Z2FnMjAwX2cyMDBldzMuYwppbmRleCBlMzg3YTQ1NWVhZTUuLjEyMDQ3MDY2YjYxNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9nMjAwZXczLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9nMjAwZXczLmMKQEAgLTEsNSAr
MSw2IEBACiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CiAKKyNp
bmNsdWRlIDxsaW51eC9kbWkuaD4KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KIAogI2luY2x1
ZGUgPGRybS9kcm1fYXRvbWljLmg+CkBAIC0xMSw2ICsxMiwxNyBAQAogCiAjaW5jbHVkZSAi
bWdhZzIwMF9kcnYuaCIKIAorc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIG1n
YWcyMDBfZzIwMGV3M19ub3ZnYVtdID0geworCXsKKwkJLmlkZW50ID0gIlBvd2VyRWRnZSBY
Ujg3MjB0IiwKKwkJLm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1Is
ICJEZWxsIEluYy4iKSwKKwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiUG93ZXJF
ZGdlIFhSODcyMHQiKSwKKwkJfSwKKwl9LAorCXt9LAorfTsKKwogc3RhdGljIHZvaWQgbWdh
ZzIwMF9nMjAwZXczX2luaXRfcmVnaXN0ZXJzKHN0cnVjdCBtZ2FfZGV2aWNlICptZGV2KQog
ewogCW1nYWcyMDBfZzIwMHdiX2luaXRfcmVnaXN0ZXJzKG1kZXYpOyAvLyBzYW1lIGFzIEcy
MDBXQgpAQCAtMTI4LDcgKzE0MCwxMCBAQCBzdGF0aWMgaW50IG1nYWcyMDBfZzIwMGV3M19w
aXBlbGluZV9pbml0KHN0cnVjdCBtZ2FfZGV2aWNlICptZGV2KQogCWRybV9tb2RlX2NydGNf
c2V0X2dhbW1hX3NpemUoY3J0YywgTUdBRzIwMF9MVVRfU0laRSk7CiAJZHJtX2NydGNfZW5h
YmxlX2NvbG9yX21nbXQoY3J0YywgMCwgZmFsc2UsIE1HQUcyMDBfTFVUX1NJWkUpOwogCi0J
cmV0ID0gbWdhZzIwMF92Z2FfYm1jX291dHB1dF9pbml0KG1kZXYpOworCWlmIChkbWlfY2hl
Y2tfc3lzdGVtKG1nYWcyMDBfZzIwMGV3M19ub3ZnYSkpCisJCXJldCA9IG1nYWcyMDBfYm1j
X291dHB1dF9pbml0KG1kZXYpOworCWVsc2UKKwkJcmV0ID0gbWdhZzIwMF92Z2FfYm1jX291
dHB1dF9pbml0KG1kZXYpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZzIwMHdiLmMgYi9kcml2ZXJz
L2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2cyMDB3Yi5jCmluZGV4IGQ4NDdmYThkZWQ4Yy4u
ZTZjZTExMzBkNWViIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2Fn
MjAwX2cyMDB3Yi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfZzIw
MHdiLmMKQEAgLTEsNiArMSw3IEBACiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vbmx5CiAKICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4
L2RtaS5oPgogI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgogCiAjaW5jbHVkZSA8ZHJtL2RybV9h
dG9taWMuaD4KQEAgLTEyLDYgKzEzLDE3IEBACiAKICNpbmNsdWRlICJtZ2FnMjAwX2Rydi5o
IgogCitzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgbWdhZzIwMF9nMjAwd2Jf
bm92Z2FbXSA9IHsKKwl7CisJCS5pZGVudCA9ICJQb3dlckVkZ2UgWFI4NzIwdCIsCisJCS5t
YXRjaGVzID0geworCQkJRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiRGVsbCBJbmMuIiks
CisJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIlBvd2VyRWRnZSBYUjg3MjB0Iiks
CisJCX0sCisJfSwKKwl7fSwKK307CisKIHZvaWQgbWdhZzIwMF9nMjAwd2JfaW5pdF9yZWdp
c3RlcnMoc3RydWN0IG1nYV9kZXZpY2UgKm1kZXYpCiB7CiAJc3RhdGljIGNvbnN0IHU4IGRh
Y3ZhbHVlW10gPSB7CkBAIC0yNjIsNyArMjc0LDEwIEBAIHN0YXRpYyBpbnQgbWdhZzIwMF9n
MjAwd2JfcGlwZWxpbmVfaW5pdChzdHJ1Y3QgbWdhX2RldmljZSAqbWRldikKIAlkcm1fbW9k
ZV9jcnRjX3NldF9nYW1tYV9zaXplKGNydGMsIE1HQUcyMDBfTFVUX1NJWkUpOwogCWRybV9j
cnRjX2VuYWJsZV9jb2xvcl9tZ210KGNydGMsIDAsIGZhbHNlLCBNR0FHMjAwX0xVVF9TSVpF
KTsKIAotCXJldCA9IG1nYWcyMDBfdmdhX2JtY19vdXRwdXRfaW5pdChtZGV2KTsKKwlpZiAo
ZG1pX2NoZWNrX3N5c3RlbShtZ2FnMjAwX2cyMDB3Yl9ub3ZnYSkpCisJCXJldCA9IG1nYWcy
MDBfYm1jX291dHB1dF9pbml0KG1kZXYpOworCWVsc2UKKwkJcmV0ID0gbWdhZzIwMF92Z2Ff
Ym1jX291dHB1dF9pbml0KG1kZXYpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLS0g
CjIuNTQuMAoK

--------------v0w3YAjrqmYxNRyLtTsTIhau--
