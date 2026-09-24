Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B181C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04AA10E543;
	Thu, 24 Sep 2026 12:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="acmLMBZp";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621F510E543
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:41:07 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so11461855e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790253666; x=1790858466; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
 b=acmLMBZpnRFnNjOdCZrCpesPONs+oxwxCcNpMYdoUr8MSjjCO95DuwZk13CGpFGxiO
 FartCLESOXpoovVcXFjNqAIp5ZgmG5E/yCHT7HLYmkXJSa9z9krw+OlRVQHwLPLDKt16
 LJ/bIlFUfxf0pJwQiWr2XFEQPxUF5KDdaVxmR6CZ3TERBsP8lEcEWRjlbKBJUf39wR9A
 Owix8PwUEu3zKMKkgjvSUOLH+0wp2ojHPxYDzBYnOjCrx0yFZ3pehE17Tq5valmmi7bt
 mvPeP8+8oLIfCANDtIXUS0+JnI40xyz2UUyK/U4g7xTMJ6lI5FfPxgjBJdcdEYZ9w25L
 ciFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253666; x=1790858466;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m+K9xI1+b45+Hx50rEe06X/tskVciHAk+ndafWRnnYs=;
 b=zkLmvYh4cyX56Ok97y6kNuirgEe2/f74fhIqlqU3sXwRTk54/WE+imdN2f4ydowPvI
 yzNafCL2sWdN7m6WCmMiEyIsQo8VyMEfIdOhobf0e6ovlHVBD2lrJwYjO28O9gQODrKI
 ydVeWk5Q3+kPAeHBO/y/fgLjKeHp7l5x7Df7ZEgJJWhcbjlIvhpy3uPp/3P5l6M3nU73
 JtmehPQF71Qdj0zMjJ1VdnAe3ySL+PRVdP7aai1iA24z+lRsp2cYPAp+LoNSxcjKifrD
 qS+plTANjceld+5yiuCU9ky4f+dRWoaIC81iDPuIymGy4JYX6YG2NhE+ynwWQ394Fpun
 rkEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ9gvCSW3Hq5w6z1cQrOWKNkzo1k7LtxNBgeYavj8CbfZtkzALuAJHHwc8zgpyUFAlF2U3cqisxvU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mD1wyIrK6Gh1aTjhUCdIzw566QaPfgOkXsODZQw3DrQidjU4sh
 qRMraYidhsO0xsH94mDlh+y0+vKuL/qIUIojKANRrvqo7IMNOS1KKMc9DfNYlDf1zpQ=
X-Gm-Gg: AYBFou3K9IB3HUBiQ533OYXEorud9nBwubvkQTjk+s8okzGW+PQFjdh2xQb4A5v2E+O
 vcebuMFDhMVE5KU3a8SmMPeNQUagS2G+bsrI3wRkxokOwHcBHU4rL69LPYk8cHz7Gv+u5wjE7dE
 9mweTYXtN3zeOSnXBcKOxLyHuvmHUjmtAxJ8Px52OeEIwu3QBB6+CRPibUL8qGAl+foirrMvO89
 m1b6l+QqTbsGIukODebJhQ1nBBIKneQKfAh4DxrI2FRlSotClPj561HOt4bQ4+JzOXZuWipo91E
 GAcnm4BaIpW2DD2sXdTvxPepTvWw7tDEtKpWy1WeQT5tGrnb/VWMWgAMSpM3utRKx4FP5AuCGeR
 rwaQoQFNjKj4KN2PFBZgu650XuK1+ZegNXbzk0og9WZ4wxOxMPnhqFb7arfpgTm5Qh1dNJaUotT
 kkMIrlQaNXWW/EX7xa1INWTqHmDrBxPlT1L7BXlQJro0yyXup90/4NPFf2CkVnk6mjge2xMYUNp
 6piOe97vJ7Dx0FPizAE1QA4mHjOlgbyRZU=
X-Received: by 2002:a05:600d:8642:20b0:49f:e8bf:c38 with SMTP id
 5b1f17b1804b1-49fe8bf0d97mr19384015e9.34.1790253665749; 
 Thu, 24 Sep 2026 05:41:05 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd77bsm78152645e9.8.2026.09.24.05.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 05:41:05 -0700 (PDT)
Message-ID: <f3b91a89-2733-4159-98b4-129e3127e7e4@suse.com>
Date: Thu, 24 Sep 2026 14:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Ian Abbott
 <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
 <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cc03390d-8fc7-422a-bbcf-93bfbb82276f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/22/26 7:21 PM, Guenter Roeck wrote:
> On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() in
>> preparation for its removal.
>>
>> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  drivers/comedi/comedi_fops.c                          |  5 +++--
>>  drivers/gpu/drm/drm_fb_helper.c                       |  3 ++-
>>  drivers/hwmon/fschmd.c                                |  3 ++-
>>  drivers/hwmon/nct7904.c                               |  5 +++--
>>  drivers/hwmon/sch56xx-common.c                        |  3 ++-
>>  drivers/hwmon/w83793.c                                |  5 +++--
> 
> I don't know how other subsystem maintainers want to handle it,
> but please send the hwmon patches separately; I'll want to apply
> it through the hwmon tree to avoid the potential of merge conflicts.

Sure, I'll do it in v2.

If other maintainers would also like changes affecting their drivers to
be split into separate patches, please let me know.

-- 
Thanks,
Petr
