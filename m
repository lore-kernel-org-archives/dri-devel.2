Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA829CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E3610E144;
	Wed, 10 Jun 2026 07:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yX65371M";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FE310E144
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:46:07 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gZyWb2s7jz9vDG;
 Wed, 10 Jun 2026 09:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781077563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVSGFjS6rCtlRmsAFb7HqeiaT5Fx+/RP29GF/T5/5sY=;
 b=yX65371Mu5JXV+S5LBBQpDuemnSTuuAfYaKvNh8vg+mOrwgvJZHckCkz2SI/0Rr5Z+zlvx
 XWsLNw/Z6xpPqo27OCtuNQDAIdi0w4iLQs0FxSutS3PI/VHcBJDI2ghC9lzDUDumDm4BD/
 qnZInxl5Q7fbDCGKPfsCbVorT8y77kwkHxcmVsJOC8b78oxNfQv1yhP7T6eP8rL0aTgR5v
 bn5N5kjk3UKqzTWvWmx0C03YvPWxDlPEIP6/fxUvu8cZBli6UQHEh/CKTkDjGKo3UHKe7W
 /8oOOpytjNazUn1TnI+MiRnMzmREtuK26PDY19d/mLxzHtlYyVrRdbLUv/73mw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of michel.daenzer@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=michel.daenzer@mailbox.org
Message-ID: <14be0bdb-982d-4cad-8624-944c69937de4@mailbox.org>
Date: Wed, 10 Jun 2026 09:45:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
To: Maxime Ripard <mripard@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260609-orthodox-cocky-bull-5ddef8@houat>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260609-orthodox-cocky-bull-5ddef8@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fa422c70b70e16a4572
X-MBO-RS-META: nnk6ehztgo6ksnne7e4fp9wmostf937q
X-Rspamd-Queue-Id: 4gZyWb2s7jz9vDG
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

On 6/9/26 14:51, Maxime Ripard wrote:
> On Mon, Jun 08, 2026 at 01:19:06PM +0200, Nicolas Frattaroli wrote:
>> With the "max bpc" KMS connector property, userspace can arbitrarily
>> restrict the upper end of the bits-per-component range. This is fine and
>> good, except the HDMI state helpers never considered that max_bpc could
>> be influenced by a userspace setting, so assumed it'll always be an even
>> value from the HDMI standards.
>>
>> This, unfortunately, is not the world we live in anymore. Patch 1
>> corrects sink_supports_format_bpc to return false on BPCs outside of
>> what HDMI allows. Patch 2 then corrects handling of odd-numbered max
>> bpcs by rounding the loop start value down to an even number instead. It
>> also adds a KUnit test to make sure nobody breaks this again in the
>> future.
>>
>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Do you have a bit more details on the world you live in? :)
> 
> In particular, why would erroring out on setting an odd value in
> atomic_set_property not work?

That doesn't make sense, since the "max bpc" property purely defines an upper limit. Setting an odd value for it doesn't mean the kernel has to use an odd effective bpc value, it can use any valid bpc <= the "max bpc" property value.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
