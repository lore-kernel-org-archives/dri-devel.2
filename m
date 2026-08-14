Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88725C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0D510E04C;
	Fri, 14 Aug 2026 01:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvGd49S2";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B22E10E04C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:55:01 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so7754605ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786672501; x=1787277301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bPbhXj68DFow4KobHedvhSuUYttTMn8QptH13rBUSKk=;
 b=cvGd49S2+Iuwu8dpVDLmvnKR0pq7SMnhTlrLCC8M+OHMasaaqBvW7gqgLzvD4Z7+4E
 g7+8bez9yJzGOQXwZt6pYsJPziV1q31JqQ20PfXFD/w4kxyhCXNEaW47owssb3LkzYJ+
 F1B6eRH281py8VPS87ZaJzQ8NoWU6q8Vnzd8MF6VP4vDzinhh23YU+bBdZJUpsKDCrEa
 GRwaIw1hZB336FHq7bFH+9h7N/2AGcK3ZUwgzAB9MvdYicaJdDwbcJYKytVzHGgfCvGP
 YioQI0rXeesO8MEgbIJNkfqIh/0XippDqdiT/RdEHNsETovM8tv6+EBQPb2AgCZul+vU
 Ur2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786672501; x=1787277301;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bPbhXj68DFow4KobHedvhSuUYttTMn8QptH13rBUSKk=;
 b=h5kcUlLbTzKliiofXuNQ9J/n4RlWMMwosH4HxcQBjcbuZpFYjZKDpfrh8aDjm9ZdGE
 ISs3z5HAe7LR5RzUAP2Q4uCNp+dlkbFHA1IxdD5OxU1ucSKYUTqNuG6L8+LJ5DIcaPIt
 hqde49e4KLoH5lom/KxlOBqFJYtQC6Du8yZ3bzkPLMRwsvz9FfAue0eWWE0/JHBh3ZZx
 zLt/aidxHBfWeTsk3OiCq2uHbT/pVQoSjmHZpSkSLREkVpjMd9FvC7Od2B74SpRoZc81
 5LPD109lmC0nXOeEC5909VNcxXvnpzqMBprE2yFtiMuPzNgTjsmEb2vO1mu1vvMDtDuA
 0Hew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rodf7dSLP8HSGjrgPJrRTc1MqeqhXsybc/Sln1vEPXuT96fM6GruuKdvWSjkskz3MSnKe3pyU1SYHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8ha34U3yfsWveLvCGqZxgo73EV/gctrYFwWplBYdotMamMdrc
 4XMegZgYwgjSQSjFm/DqR7gIGOSbhm8DBkL4bpbpCcvlAdMmTx0w2KEH
X-Gm-Gg: AR+sD13USqxhKWSFmpbTYtzXG113JR2ghB7WgIwI5cCDUhEbQrsheqSEJr4kXGJ61k9
 76bavIHzEJY0XK+Rrk5/6Sr8CFBOHZR2MoUuuBxU/Uj2UCdUkIFTsNkOULeB5lq1n/sQzr14CRb
 70AVAiycyf5ARmWWicsOIBdqGugtR2gTYx7WxXicUHmJiPonGeN2EhUMSq6ruoIsV9L/4gS4q9O
 8fgMvQsL/wz+SohLmoLmVB25y2E1FnczqWGerqYsbnfoNtStVPU4cavhWpLL5jG/28hGkg8qE42
 L6b5FavIz09BRrDUowNhScQZCxxW75ooOEwdHZZ1FJMzRox3CpPlsjetOR+6I9eNbDYdqBE0UJ7
 SBJLyE4qiXNo2Y4AwYvOHyLeAyunAMR5Nrr5OKTJkKoH6tB66OTggjDBFy9fOgzax6THNe71DEn
 saeBp6ydGFGmnV9vOXZnq2BINUtvJ5GnRAjmabPM//fKNQi64xkZKUhyL3julkiAhF3nP4Zw2Qd
 z6H402Zb0NKJP+vUEck35t/kjMNMzjFBfmsCQ==
X-Received: by 2002:a17:903:2384:b0:2cf:c543:2c7e with SMTP id
 d9443c01a7336-2d3b088651dmr29467465ad.10.1786672501014; 
 Thu, 13 Aug 2026 18:55:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc75d8casm14375368eec.3.2026.08.13.18.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 18:55:00 -0700 (PDT)
Message-ID: <e76206e7-5c8c-47e8-b630-97343570d4ae@roeck-us.net>
Date: Thu, 13 Aug 2026 18:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add support for currX_emergency and
 inX_[l]emergency attributes
To: sashiko-reviews@lists.linux.dev
Cc: linux-hwmon@vger.kernel.org, Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 DRI mailing list <dri-devel@lists.freedesktop.org>
References: <20260813211433.879638-1-linux@roeck-us.net>
 <20260814012059.CFC2F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260814012059.CFC2F1F000E9@smtp.kernel.org>
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

On 8/13/26 18:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Internal ABI breakage in the habanalabs driver caused by inserting values into hwmon enums.
> --
> 
> --- Patch [1]: [PATCH v2] hwmon: Add support for currX_emergency and inX_[l]emergency attributes ---
> commit 618b70e656b029d918a4d90557dfadbd253324dd
> Author: Guenter Roeck <linux@roeck-us.net>
> 
> hwmon: Add support for currX_emergency and inX_[l]emergency attributes
> 
> This commit adds new emergency limit attributes for current and voltage to
> the hardware monitoring subsystem. It updates the hwmon core code, the
> enumerations, and the sysfs ABI documentation to support the new alarms.
> 
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index dd713e193d0c3..a3a7d27f3b5ff 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -134,6 +134,8 @@ enum hwmon_in_attributes {
>>   	hwmon_in_max,
>>   	hwmon_in_lcrit,
>>   	hwmon_in_crit,
>> +	hwmon_in_lemergency,
>> +	hwmon_in_emergency,
> 
> [Severity: High]
> Does inserting these elements here break downstream drivers that rely on the
> historical integer mapping?
> 
> For example, in drivers/accel/habanalabs/common/hwmon.c:adjust_hwmon_flags(),
> the driver performs a hardcoded bitwise shift assuming the Linux hwmon enum
> values perfectly match the firmware API shifted by 1:
> 
>      flags = (cpucp_flags << 1) | HWMON_I_ENABLE;
> 
> By inserting elements into the middle of this enum, all subsequent values
> (like hwmon_in_average) shift by 2. This causes the habanalabs driver to
> incorrectly map firmware sensors to Linux hwmon attributes. For instance,
> inX_highest will map to inX_average, and reading from these incorrectly
> mapped attributes via sysfs will fail with -EINVAL.
> 
> Can these new enum values be added to the end of the enum instead, or does
> habanalabs need to be updated to decouple it from the hwmon enum ordering?
> 

There is no guarantee of a specific ordering of those flags. They can and will change
position and/or ordering as new flags are added. The hwmon subsystem must not be held
hostage by some driver making up their own rules. FWIW, I don't even understand
what the habanalabs driver is doing and what assumptions it is making about the position
and ordering of the flags.

Guenter

