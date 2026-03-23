Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEFAEC01A0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4B810E3F9;
	Mon, 23 Mar 2026 07:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1ZHhc/6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jj9LEzTz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ZHhc/6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jj9LEzTz";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22F310E3F9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:51:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C9474D361;
 Mon, 23 Mar 2026 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774252309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tA7W06Onk/rtKXd/N94Ed9tcGBNSmGtsapWgGQU6lXk=;
 b=1ZHhc/6fBv1Qot2PeIrWSs1vP+h6CzWtprkvBsZ+2Cbk6pUe1E/M2DOC3z3/CnRFzJ42TR
 qoq8SJJP7cZ4CjzE5f0UHpov3JHkxZ7vQWqoOSOA+tzktfjaXb5sltg7/8Sn+QFccZ/iSq
 ny4nimBghtq97+NQT+TxklJhwQ+bpXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774252309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tA7W06Onk/rtKXd/N94Ed9tcGBNSmGtsapWgGQU6lXk=;
 b=jj9LEzTzA2e6UrwMPJsdrDlaqRhKs4M91FUEzyhYBXBLNMsBfCYeUGDbG/1bEt+C23uX1q
 n3LQQxT/8H9Nw4Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774252309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tA7W06Onk/rtKXd/N94Ed9tcGBNSmGtsapWgGQU6lXk=;
 b=1ZHhc/6fBv1Qot2PeIrWSs1vP+h6CzWtprkvBsZ+2Cbk6pUe1E/M2DOC3z3/CnRFzJ42TR
 qoq8SJJP7cZ4CjzE5f0UHpov3JHkxZ7vQWqoOSOA+tzktfjaXb5sltg7/8Sn+QFccZ/iSq
 ny4nimBghtq97+NQT+TxklJhwQ+bpXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774252309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tA7W06Onk/rtKXd/N94Ed9tcGBNSmGtsapWgGQU6lXk=;
 b=jj9LEzTzA2e6UrwMPJsdrDlaqRhKs4M91FUEzyhYBXBLNMsBfCYeUGDbG/1bEt+C23uX1q
 n3LQQxT/8H9Nw4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 499DB4377C;
 Mon, 23 Mar 2026 07:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id COZLEBXxwGmnegAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 07:51:49 +0000
Message-ID: <1c163b1a-a712-4f4c-b3e0-ab0a12d97693@suse.de>
Date: Mon, 23 Mar 2026 08:51:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] drm/mipi-dbi: Replace simple-display helpers
 with regular atomic helpers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
References: <20260319160110.109610-1-tzimmermann@suse.de>
 <ltxdlbnllcelmlakfjks5oo6ys7t3h6lulxaev3jmnumkjcebg@3dwu6chuswrf>
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
In-Reply-To: <ltxdlbnllcelmlakfjks5oo6ys7t3h6lulxaev3jmnumkjcebg@3dwu6chuswrf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch,lists.freedesktop.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
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



Am 23.03.26 um 04:57 schrieb Dmitry Baryshkov:
> On Thu, Mar 19, 2026 at 04:59:36PM +0100, Thomas Zimmermann wrote:
>> We keep getting new drivers based on the obsolete simple-display pipeline,
>> such as the recent driver for st7789v panels. [1] But submitters cannot
>> know, as the simple-display helpers are fully documented and still used
>> in several places.
>>
>> Hence, convert all the mipi-dbi drivers over to regular atomic helpers
>> and remove simple-display support from mipi-dbi in this series. Then
>> undocument the helpers and add TODO items for final their removal.
>>
>> Patch 1 changes the mode-setting logic to get CRTC and panel updates into
>> the correct order. This patch is probably the most fragile change in the
>> series.
>>
>> Patches 2 and 3 prepare mipi-dbi to allow for atomic helpers to be used.
>>
>> Patches 5 to 14 update mipi-dbi drivers one by one. The st7735r driver
>> requires some additional minor preparation. Overall, the refactoring is
>> always the same.
>>
>> Patches 15 and 16 clean up mipi-dbi and the simple-display helpers.
>>
>> These patches need some testing, as I can only compile them. At least
>> one of the drivers should be tried on hardware. Regressions should be
>> easy to fix, as these changes are mostly refactoring jobs.
>>
>> [1] https://lore.kernel.org/dri-devel/20260221071351.22772-1-architanant5@gmail.com/
>>
>> v3:
>> - fix uninitialized variables (David)
>> - improve documentation (David)
>> - clean up
> For the series:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Thanks a lot!

>
>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


