Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA873606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Km6TY7Fs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E2C8933E;
	Mon,  9 Nov 2026 15:51:59 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98B08933E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so647611f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794239511; x=1794844311; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:to
 :content-language:references:cc:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
 b=Km6TY7Fsfevp4v/ORJgTAua9B9UD/esFOy6yoeKAv6SgF9lKP1OQzCIV8dEEQoIsFR
 OYjPk49QX8D54CejOd0lvkjQAQnUuy0T4JCPA3+YFWsxQbvpCw/6csaPaHIBI66Uz6lo
 rfc4Tn2vUeVQ2yIqLNGxNmoaHfbJrjDQqHJZkL/ZtSRUL4cf5F92eYDqpr5XfQ611tWH
 7M6+OoJXeDoz1HGvS/ayuin2MJ5WD7LZF1OE+4KUXzsG+ZVPSbvB58RGoorEcaILPG/m
 CRfhIlJnY32cMdWriUhlJkSxOLJJVPqK8Sdr+WNHRaDZa9UIuaD8fWkxKJCfMbxk9dUy
 RyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239511; x=1794844311;
 h=content-transfer-encoding:content-type:in-reply-to:from:to
 :content-language:references:cc:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
 b=BE1UW5B04cMAIOLOwK8bK5K810hKYsOtj60b8jkYuIeTiM9gFLeZDLDCJKLfYKHbeC
 Hk+Snr2up+/mLbkPnvDWISFe1v+3/QBuaSgZSizilK4xOEafH00B9XbhTzsHN53OAT/8
 pI5ScGkJ3xkC5503Jm9M0+cRBA8vEadZmTfiTu+JvIH52b3spVjrVD/bj4ShrS+5o8BK
 T9wjvX3G4KjRF7kIP/4qohRfCUuU4Baw7Ka9p5r7SOJ9T4qCWkKGrm/bdys375XUyhs6
 k2ArcOpYzzogMHHLlk7s+PgYVgKzYYCwykwb//KOJcJVkZ+HBM1yT35vilBjwjZoTJxg
 RC4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFouVgE49MWvbxX0xThYjQmKU6jft4KerFIlkT7YlS7k2EMMdWq58PSo31sOIb+F1VkiyH0QvMOIV8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+akjn7y6RBh7xsw4rvNKixqAi3UVT2aat4aWljaMpDx5aymZNC
 Nu1w6cfNH7SrG6uZ/wd/LqGpy1SEN8Wj/1Uum3lJeY+T0RXVY5KL9v0PrhCEnJDUg9M=
X-Gm-Gg: AYBFou23kJ/c5gyl7Acpo1Z/+ApuFthhaD2abDtQQ+YikZeRKBIQZXLET1xVh9sL430
 Kk6DqiAKoS3ssmIpebD1HqSpSVB/xXA1VpX/70Ql9ykA/tVf8YCrrC4fAbNEwCK96mGRvtn40Lh
 D5dgk44eaSURTGfD8xuDVWV699ZBJm8mQrA9StJJsp1MJw0NbjS3Jh8WL13JYEbpKOoS5W8FqMp
 7ZJ0EdjtI/Md5qHnYXqBL9uDSgDJkuGaSNx/U6Eh8gfn+LXGLlNMQaJ8V5Ltbp3QdlI9MIKSaoD
 20Qznlomgy+TiYvXrb8Jdd6gcg54PGRpvWwVpBaYrDa0rD2CEG+/Wj+GuOnc/jkFXMqjyHeNhgp
 v21NtjA4Y7GSprCbzkWwmZn5oB13shAqH2AUeIjw9YfqJBAycQyrgkN4j2ulltl8f3khLzHazUE
 VlckZB3eZaw9kVeTTnKWvBoN33PSl3kYhTExiczDdtWdFpUfawI6uY9nlsi2HFZ3Fnay7F0v7b0
 66uOq9ffR8BCNzyPlefpG9H30eZnXV0Gwj9hU8J/4NLDtzO046FcqMg5vuS9E6OYo7Er22eed7r
 8kiAozHBhoUTmwyIK8qiFE1sYsZ0DbGTzvjCDwp5CYqIndti7nwiqWzVVx97+uAi
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id
 ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204; 
 Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53?
 ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
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
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
