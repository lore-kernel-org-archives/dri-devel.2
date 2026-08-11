Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA9BC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D37A10E30E;
	Tue, 11 Aug 2026 12:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iaPayVHL";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3353E10E30E
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:27:00 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1542941f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786451218; x=1787056018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z1YNUY4CnOFIxxcbK/ti3nxx9tWKw9gvD9EHL9TaGXo=;
 b=iaPayVHLbxlKpivgI8HmYyDFr4fn20ex00NUjGhBOiSN9qQi7y4rPbnrGd+89BFPoM
 n/18aB+4/hO0q9sYyImIOpnBXNsi0WnP/pAjvPpA6NHfFhdO0pDEFGrDJdETij6iEuQW
 zCfcB7v29MY5g/5JoX+k9twpHWlQARDmltK3bbnO/aw3UrWSrpUUD6BpHaSrRAxQul4T
 8ptNUzLay7TWVbsd7Y2uvZn3HUAe5DeQiUOgkh5Cae103Y2MtDe1KlshGhQpwC3XXCiK
 LuE4GwK6sREVuwpL5rEnQZO21V8MdoyFsqKYBGhMs6jDFyDIRkI6xHB5/bTQU/hqUT5E
 Cq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451218; x=1787056018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z1YNUY4CnOFIxxcbK/ti3nxx9tWKw9gvD9EHL9TaGXo=;
 b=LzBAQXWeCGXWOmABwC0dfFp0I4iZ6IuxY137kARO2wAxhllx7AcNIqqSb3QTxTjToM
 7KH0dW7Os564jHaSp6XKpTXPolqTiL9V+o85zZAaoJMDMhBCOLydLbCJIhhwGqRHW7bn
 /mtBHde+akYrPnuBpiYUeQvXmGOiVSBviP3t23LmerG7tIHlEvpMvjCk5zqT1LNvFIPB
 yJ73Dgs/X8PT5qJPxD82XzxotYrSEGvoll38nDUcJLXLsRbPqxT3oVoomQSLNX4HlZyW
 OSvUd93R9f+AjOM0VIl9dpTwKMQEeFiUNnDlJE6S4e58yY5xm2QkIHxBpUGDsP++un6Z
 u5dw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk0kNddxJ2Tj502t5U6jRoRlDe/1q4NMv6ffr0lzcghRC4MpnhkBdTySzCUPUcpfrjiIIn7G4Dyx0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOFFb+4+hNwQiCEZJbbf4mN6oC7KjsWC05Bt6NhC39JJ/aCN2Q
 wweCkUjktaq5OBOoqv0t7CA6iMWTm7FiRKA23M3ndx4lv2gZZgcez7OpLeTIZdpV
X-Gm-Gg: AR+sD13Av7lMf4rYYiKoDVrPSglgVS6zcQRydhMM8tEr//nORHgplfkARYKNWSmwKk+
 IvGMw4Y9FUavq2kO/zXAe3Dpk5LEAAa5SXYGHt9oXmNGKivUiAxWHu0vC1l8zM2hmoF8mJJMvwt
 q7I2ZrBK/q6DCkT+WlNqKH5PVu6YPRAdfL54mHw3X9NzEdJMDefRkAA3ziI9kwB/E4I+7xGK1pl
 IzdDZB+1hGU5goo5xGyu58ydLhO+v/TtguSTmPTlKY4xIhJXIOb9mez5SfWXA5LqcJREEkHgYAG
 plG05Ua2+t00JhJfmFbj/jlSe3MIpsZ5lkMSxTorA28I56v+ciYcZHaciPv2Mt8S6+sd0DsParh
 uYrW/KgrgcjSpJ/CePypLCPeiUBjFUtmjtu0MkGyty9FEmKCcCmtLhs7BN5Nzxf5aAExKWGz8OB
 CUI+Ryl6wYOGMno3+3bS5N096tUn2RWYNDkRDZ7PvZ21qR17RZygSMVWkEVbEd+JEd6SEFlfBnG
 A==
X-Received: by 2002:a05:6000:298d:10b0:47f:ecbb:59a2 with SMTP id
 ffacd0b85a97d-4814add98efmr4048625f8f.29.1786451218303; 
 Tue, 11 Aug 2026 05:26:58 -0700 (PDT)
Received: from thinker.local ([2a06:c701:91c4:df00:228:f8ff:fe2f:dc6c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a72cea1sm4634973f8f.37.2026.08.11.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 05:26:57 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: airlied@gmail.com, andriy.shevchenko@intel.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Tue, 11 Aug 2026 15:26:02 +0300
Message-ID: <20260811122603.30773-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87pl0fsbps.fsf@ocarina.mail-host-address-is-not-set>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey Javier,

I recently returned from a trip abroad and resumed work on v4.
I am making good progress, but I would like to propose a change to the
agreed-upon plan.

Javier Martinez Canillas <javierm@redhat.com> wrote:
>>> Can we move this to the ssd130x-spi driver? For example, something like the
>>> following might work:
>>>
>>> 1. Make ssd130x_write_cmds() to just be a static inline wrapper that calls
>>>    to regmap_raw_write(ssd130x->regmap, SSD13XX_COMMAND, cmd, len).
>>>
>>> 2. Make ssd130x_write_cmd() be a variadic wrapper around ssd130x_write_cmds().
>>>
>>> 3. Add your logic to ssd130x_spi_write() instead of ssd130x_write_cmds(), that
>>>    way it stays in the correct layer rather than having a leaking abstraction.
>>
>> I agree, in hindsight this code goes against the transport abstraction.
>> I'd propose keeping 1 and 2 in a single patch, though. Making ssd130x_write_cmds()
>> a wrapper around regmap_raw_write() and making ssd130x_write_cmd() a variadic wrapper
>> around ssd130x_write_cmds() are two halves of the same change: routing command buffers
>> through regmap_raw_write(). Splitting them would leave an intermediate state that isn't
>> independently meaningful. Happy to split if you'd still prefer it.
>>
>
> Yeah, as one patch is OK I think.
>
>>> Also, instead of checking for info->family_id == SSD135X_FAMILY, we could add
>>> a dc_high_params member (or whatever name is more suitable) to the struct
>>> ssd130x_spi_transport Then other families that might use the same can just
>>> reuse this option instead of checking for specific families.
>>
>> I agree that hard-coding a check for the family isn't open for extension and should be changed.
>> Adding a member for this in ssd130x_spi_transport is a fitting solution, I'll populate it in
>> ssd130x_spi_probe() using a static array that will describe which families need dc_high_params.
>> I'd keep that table in ssd130x-spi.c rather than adding a flag to ssd130x_deviceinfo, so the
>> D/C# concern stays in the SPI layer instead of leaking into the transport-agnostic device info.
>>
>
> That works too. I don't have a strong preference on how should be
> handled. As long as the logic remains in the SPI part of the driver.

While implementing v4 I noticed a problem with step 1 above, and it made
me reconsider the layering argument as well.

First, the concrete issue. SSD13XX_COMMAND is 0x80, which as an I2C
control byte is Co=1, D/C#=0. Per section 8.1.5.2 of the SSD1306
datasheet, Co=1 means exactly one payload byte follows and then another
control byte - control and payload strictly alternate. So

    regmap_raw_write(ssd130x->regmap, SSD13XX_COMMAND, cmd, len)

puts len bytes behind a control byte that promises one, and the
controller parses cmd[1] as a control byte instead of passing it to the
command decoder.

This would break the code paths already using the I2C transport: most of
ssd132x_init(), and also the per-frame path via ssd130x_set_col_range(),
ssd130x_set_page_range() and ssd132x_update_rect(), so it is a runtime
regression rather than only an init-time one.

It is fixable: 0x00 is Co=0, D/C#=0, i.e. "the rest of this transaction
is command bytes", which is exactly the semantics a burst needs. That is
also why ssd130x_write_data() can already burst today - 0x40 is Co=0.
But it changes I2C command framing for every existing chip, from one
transfer per byte to one transfer per command, and I'd rather not do
that as a side effect of adding a new controller.

Second, the layering. Looking at it again, I think the comment I wrote
was the misleading part: it described the behaviour as "D/C# HIGH" and
"D/C# LOW", which makes it read as an SPI concern. The code under it
only chose between SSD13XX_COMMAND and SSD13XX_DATA - the core's
existing transport-neutral naming for the two paths - and left it to the
transport to turn that into a pin level or a control byte. I should have
described it in those terms to begin with.

Furthermore, moving this logic to the transport layer could lead to code
duplication. If a new controller that supports I2C is released with the
same "parameters are considered data" requirement, the logic in
ssd130x-spi.c would have to be duplicated in ssd130x-i2c.c - which today
has no .write handler at all, since it uses the stock regmap_i2c bus.

So for v4 I propose:

- Keep ssd130x_write_cmds() writing SSD13XX_COMMAND per byte as it does
  today, so there is no change to I2C or SPI wire behaviour anywhere in
  the series.

- Still do the ssd130x_write_cmd()/ssd130x_write_cmds() unification as
  its own prep patch, as you asked. It removes the duplicated variadic
  loop and gives a single place for the check below.

- Add a bool cmd_params_are_data to ssd130x_deviceinfo, checked after
  the first byte is sent to decide how to send the parameters. If it is
  set, the parameters go through ssd130x_write_data(); otherwise the
  existing byte-by-byte loop is used.

- Drop the separate SPI transport patch entirely.

The comment in the core will be phrased in the core's own terms this
time: parameters go on the data path rather than as further command
bytes, without mentioning D/C or any other transport-specific
information.

Apologies for going back on something I already agreed to. If you still
prefer it in the SPI layer I will do it that way and fold in the 0x00
control byte change, with the I2C framing change called out in the
commit message, but I wanted to flag the breakage before building on it.

I have already implemented the fixes for most of the other comments
locally. Once we settle this, I will submit the finished v4.

-- 
Thanks,
Amit
