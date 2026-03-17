Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460BFED9E0
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0657910E4BB;
	Tue, 17 Mar 2026 14:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNYIFV5Y";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4BD10E648
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 14:55:43 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c0cf039a45so2929332eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773759343; x=1774364143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=0yNjjVCdiNMRDtTfhlm/yv6eYoMsY3Pqr7cf9Cuz7UA=;
 b=NNYIFV5YBraXvAmxtm/oJaGW9rdbGnueJKye+xNXZiu/RH02JQ2eiFlDcQ+tZE1J7J
 AWVrdSkw6x4vqbORoeKvesYExOYBZxzEXfWjrTBrOizHc0j0w7+DqixcJAJPvCvthUiT
 7YAKjZOMdNA3lK7O7FJBAG9gSHGfj1fyFVMjZvlsdm0BZBzWQQ++0u6aSM6a/cockHf4
 Gm8bIvJ/0eLZUP8miv7zSNr93Xc18oMcnxE6bLoIgc138Ovn5N+QUKFj6sOoaSI5IZp7
 1+wxx6Uq8vqB7MQepuD/PqrOoUg4jRcIfDphaNoCXFzeqWOe8Q70d+mkphnMFJo/mhig
 s2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759343; x=1774364143;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yNjjVCdiNMRDtTfhlm/yv6eYoMsY3Pqr7cf9Cuz7UA=;
 b=EGjXmsjOOnNQGJ3XJhKTmH9NnaKGmXu/uIg2AAQfz+BYt6DWDDm80ziR07GRTv/4mM
 QE4fxl4MQvz6tPhh6oFXkmvlEdo/k//Izsvjds6GUZFPxOP7LdRRCDMU6eKfj3EbY3L1
 Joy52sDKRlMARRZ6LS6+iUNlvON3LQYWgi32tNmQBq2tRvxRFqgI0+OID5YH1Nh9+Nf7
 fQdjE40+Zv7aU0x9LJHuqvKxfK+4nxqMcfSQzwUHkdOIYzYqUvFp/gs27qkkmSiUNUki
 fE6aIEehiC7REhSbu9lJN59y+GG/EMcvyb1nrcHmub9hgLfVFlyFjfxOzKTLeiXa0/+w
 q+NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKXy6vzOrxCjnlfV3lkH5rqRksNlmobujU7e4JX7CusLDFWKnLIhUIuuTUjwgnwop8NSucOczPeLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSj5tSFR6puHLKcZ6rkF2BCZMA0g+yNIlubXMk2d3hDT1i+JR0
 E4QIZIJCuc8ycJv+Xo0Hny5ucPIL3iAKCpPrl12OxXwLvUFHOr8IWMipJV17EQ==
X-Gm-Gg: ATEYQzyyzkHi/l0uUHNcZJyNH2t8P5K9Hg8rQnTQQHAO6jBaaKKfKwsxs1qO0iWC2yj
 cHOdNB3zaA0vHeEdKOtE8UFWD6Q3SfhIPP1yamjYkKQeQWJxvKmtSYAjfZ6ALgxqxtWrTGO8J4V
 Q+PHsEBc1l0EAzdvt5VE8QoM98HkBb5GEA65IZXtOI6QTPKgXzYB56zNhe+KUCTigoWazKM+a08
 0py22oTskcgvXrQRtfm92qlqLjt7OUA7sqAp+d11HSLDhXdsb6+lWA3k/fJtrUZmRw03lJHD2uW
 zmV/YGRmi9rRv76A21/fbXXuaZEPX8hJtxj9BMJAqVSA3nbXwjwgjQ1hbzBjUzgS7Ae8s0DKktD
 85AM+ZHGjZEy/M/cCZKjhXmwXLgaUR73qWo4izZy8Wz29ZokredEZ74a3hcsLdpKjF4wfrhai5L
 2sAF+8GOPr81Uc7A5PR9flP+HtK4FEC7gnSZWFXjc52VdFm7ExI7pceos+ALDgm8qQwe93X+g1
X-Received: by 2002:a05:693c:809a:b0:2be:b00c:d083 with SMTP id
 5a478bee46e88-2beb00cd876mr5757968eec.35.1773759343057; 
 Tue, 17 Mar 2026 07:55:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3cd473sm18819411eec.8.2026.03.17.07.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:55:42 -0700 (PDT)
Message-ID: <beec0d34-74e8-49f5-b1eb-071a1f25e44a@roeck-us.net>
Date: Tue, 17 Mar 2026 07:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>,
 Kees Cook <kees@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <abkm46TIIBBbuuC_@stanley.mountain>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <abkm46TIIBBbuuC_@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/17/26 03:03, Dan Carpenter wrote:
> I think this is great to suppress some warnings, and I already ACKed
> this patchset.  But we're still going to have some warnings where the
> warning is the whole point of the test.
> 

Maybe my memory defeats me, but if I recall correctly the original patch
set counted the skipped warnings. I don't see why a to-be-parsed message
would be necessary or add value over that.

Guenter

> It would be great if marked these somehow:
> 1) At minimum we should mark them so people seeing the warning know it's
> intentional.  "Intentional Stack Trace".  I've sent at least one patch
> to add that printk before the stack trace but it was ignored.  We could
> do this piecemeal.
> 
> 2) It would be nice if the print was standardized enough so CI systems
> could automatically filter it out.
> 
> regards,
> dan carpenter
> 

