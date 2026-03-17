Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2E1FED9E1
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5DB10E4AF;
	Tue, 17 Mar 2026 15:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B0kRhNGP";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3727710E4AF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:02:41 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-829b2019b39so3085586b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773759761; x=1774364561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=8j8MmhnWMM0yJqxgTZztIrkl7u2FL2UIzyJZ82awCT4=;
 b=B0kRhNGPAAORUFR/9FgfN73H5iNphODVznzPTnurtgig+dwvsGre/sh94eF/2/G2t1
 WIUbc6ogYEzb8H85NsJzC6AH1BNtHDSe52E2c2Kf9m0XHgY9NsD930iTe5L/CWiDYzJG
 tPeU/Re0pqG3rwrV1b2KNKc0yA2VqOtgzYIWRJvEC+vsNdGX7tLdS1Ex9VrRzqlxtcQS
 rXwByewnpanzqK1DjTt2N/wNyFVujLbzGQvpbcGxSL26h13P9sm9g3KknhtT82KjxtGv
 NyMGDdqxrk2EvzytcfTx/eVvor87EljYy0xvzEq0Eyq7AxC0CdY1FqVkiZ+UT6zYOTZ+
 pGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773759761; x=1774364561;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8j8MmhnWMM0yJqxgTZztIrkl7u2FL2UIzyJZ82awCT4=;
 b=dS+sB0fLBGywRlO0kGfdV7GMCZa4Fq0+pn3sETb7qgesPx+o1rqfZ5RfHVwyokbgCb
 nr47QNot9DcRQkHJQWcI+TQBXALec44ullJwzx+31wyJLNfEvhT3YmG0MtNmG1A0nvbN
 rlQXHTrON40UsAeu2Gs2cHl2mEA8cWUDCMuvPhL+FIRXDJWU2Jpr97K999P3IAgxjXK/
 4UpoePXTpRn3YB2g4OZVjSt96GiQmHWHF0V87VpMEF/TIORifL6XSj+mbvAwQFrOz1PF
 wJtYaDzWIy7o3DS/IR2WyvqzWlMqrE1F2TUyNQ6QNcDhF+yQzJ1CUdFsmfxV3FGdTv42
 hFJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcyOX8bjghhy1dQPimIHW5/G2JPNDGunJjgvo7rDWUr4Kd/9fKu6V7S/uzqEbJxmxcKXIVM+xatdk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbY6xjtwb/Hb/P1a3HM+67w8NMyHy2Q4cYusNXcxlT13AfTgkw
 wB81BW/hastE3SmDtot7zLaotRF2jwVN15U+9IKZLR0pk0iE34oHpqMW
X-Gm-Gg: ATEYQzxLpNfXhgorGLVRN56TmgERoNmVNHbqaHCpQTSiIU5b4tADroufENZhDODlAd7
 0Eb3sgifVa1m1psKFn1t16rbN+vaOrubcSsQujHmAnFsMVy7m7c5tM9MqhyCS2LVNevO7sAmDzE
 rQZegRmaeGVM6ULSHfzvdP3uXLdGYyMLpsLschnOfBTkacU8dVHu7eIkAssH7+/LIkJlk1EsHFR
 bgagIkataXhzc5xcl7hB6FAYUf/shua85ETQ0t5NfEh2ItTu29iqOtwFSB1vb4gtptPH0RGvhal
 c05Paxguji1/iyxV3g2GgRU2V1gk6b0rQwxYLn7rd8umB1ypaxhkBs9QUSRQ/dwiAutJxHFPCsx
 ftFrr2s22vr5/qQS86ulGt8QO6N37WESHoa0z9YLGV2NZknHummqZ5ORtUz7foq0Oi7OE4u+m9S
 cf3Q2Oi1HncCU6WtkPnWGWyAeEJPIVqRWp7KV3eEwRSa5g/j8LoR1yfrQkedOIpWKoGzSRdm2G
X-Received: by 2002:a05:6a00:1988:b0:81e:d18a:489d with SMTP id
 d2e1a72fcca58-82a198b9f64mr13669770b3a.42.1773759760467; 
 Tue, 17 Mar 2026 08:02:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0734039asm20098450b3a.41.2026.03.17.08.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:02:39 -0700 (PDT)
Message-ID: <9cdb6e1b-3f9e-4a5f-b1ce-a88f7c6742b3@roeck-us.net>
Date: Tue, 17 Mar 2026 08:02:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
To: Peter Zijlstra <peterz@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
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
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Simona Vetter <simona.vetter@ffwll.ch>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
 <20260317113025.GG2872@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260317113025.GG2872@noisy.programming.kicks-ass.net>
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

On 3/17/26 04:30, Peter Zijlstra wrote:
> On Tue, Mar 17, 2026 at 12:20:26PM +0100, Vlastimil Babka (SUSE) wrote:
>>> For this iteration, the `__report_bug()` centralized approach was
>>> revisited after the discussion in the previous version [1].
>>
>> Discussion with PeterZ, who is not CC'd here? (did it now for my reply).
>>
>>> However, again this approach did not work because:
>>> - Some warning output is generated directly in the macros before calling
>>>    the centralized functions (e.g., `__warn_printk()` in `__WARN_printf()`)
>>> - Functions in the warning path like `warn_slowpath_fmt()` are marked
>>>    `__always_inline`, making it difficult to intercept early enough
>>> - So, by the time `__report_bug()` is called, output has already been written
>>>    to the console, making suppression ineffective
>>>
>>> Current Proposal: Check Directly in the `WARN()` Macros.
>>> This avoids the need for function symbol resolution or ELF section
>>> modification.
>>> Suppression is implemented directly in the `WARN*()` macros.
>>
>> So does that bloat every warn/bug site (as Peter objected to) or not?
>> And is it compatible with x86? I see you modify include/asm-generic/bug.h
>> but x86 has its own version of e.g. __WARN_printf ?
> 
> Yeah, they done it all wrong again :-(
> 
> This should be pushed inside __report_bug() through __WARN_printf with a
> new BUGFLAG thing.
> 

That would require another set of WARN macros, and after (or if) accepted
negotiations with each of the owners of the WARNing code to use the new
macros. Trying to do this would just trigger another set of objections.

Given that, but for other reasons,

> So NAK from me on this -- again!

I agree.

Guenter

