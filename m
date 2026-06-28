Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8F3C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6BB10E32A;
	Sun, 28 Jun 2026 15:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmKgmktV";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDBC10E32A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:43:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4926bd21aa1so19021515e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782661429; x=1783266229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+OMJP0P0VJX23QejDNAiRcdNcoGaSYxL+867MSgbJA=;
 b=LmKgmktV3VTUN7ry6mYjq8E7CnrIX7VCedDD5WJyTJ73xpGhHn1pEkT4PrRx4Je4Ak
 UOJWJekbezKmTE+SYXiTA3mD8Vizy6qzCLRUFqoqv1RR0hW0oSXcc8JVrrONxFqho5u4
 1ZqLzp2EFZVWMZA+xAo8+OdXUoTAgxJDdFaoXBES1aQHv55mKxghlBCGR497MS08yPN/
 k/HM2hWFM0ZhpN6L5cxOaT4TbKDcm6oJ5OHOGy3Qae/EHLsDUVCiANVySYDVhPbuZiTF
 TNrZ5w4uDbLm6dzYOpZvcXL7BLltZDalnNeGXjjvJi7PgajX2ZDiMcA4mWdDO4llPLLF
 ucWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782661429; x=1783266229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D+OMJP0P0VJX23QejDNAiRcdNcoGaSYxL+867MSgbJA=;
 b=bJQnTC/XijEg2UZnHZtcrhZ8wW6qnyPqqjK84CogiMByhA2eEoITZm/aJ0aNTZHnmM
 sREt5jRRwXfXTcTTEx7Pt1C4NFb2fiyswaPOKmpULT566B3A769UN3R1rwQOeNUJOpNY
 WJQZSL10NnGbn+2OitfPhQg0UsFEGDXYoGKnEMZ1DlTc4wpNtXL5wuOd8BMRHI1s7pxf
 qRrImTlJrEs6h79aq/iJz6Fck8dwQVrt9bPLXmRoo7dN1clMyqXJy5wHs9iciY2kB1OY
 zxuGelvSz2MG34w8e6foWS0v7D2Aa8Yk/lpg1au00+rxOU6mpyvJdHDt1956MFtfHCcj
 wjCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VL82Z+Ut3OA/PPWwbH18f+7d7JVbBrvMHbCKP9vwlxL9VZQNJk6M+5N3dFIn80MrFRGHJaY/y64c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqCJ6yLC/WLM5aPQRNW9hx8bw0n3ZOXfMYWiywiIOc5dkE0/DM
 voErKUeQaTLPaR+1SrPao7mJx2PpVl4I5Wi5SDzqdeucOkBPCsen+QSv6iZUdGEZJbw=
X-Gm-Gg: AfdE7cm4lJMJnjlUT+2jSlToJEUKeP941axF1Wt1V8GEylEchxnJbsTnSoDF70kQjya
 ONJSkFr2KS0RZy7frfh43ExJ0Mx9VA8rw3ibX7fHITiOqrGQkTie0yVosRwqfOHE/2zhXy31otD
 W+claYyIO/I51BfdYBG/nLBN+bJK6+KQqpb4TaO5gIAyiYE/CTsooqokEn1DxbLILbq95xaMBFS
 RGMnVOq8H94aLH7BHA8dap1C5JWhoQHD3LYwE9iGrUkKV55lyS1qzJm63QoEeQcIyRkJcs63V/S
 yxie4yRht2ZINKYXYiVEG9IOx343EcJdqv0OwEN5PoCv/3iMZjjBRagzjnh9zncSanvxGm6IQdX
 +rMiV3fFaYDWvYBqSKQBk325wryyiKXXQ8KSu1wkCQNMdRDz6QFMmdi8hvuAdtU/fb5znmoUNhE
 end7D8vnj+VFxao0X35YZqErbn8eg=
X-Received: by 2002:a05:600c:3e19:b0:492:4c5d:4db3 with SMTP id
 5b1f17b1804b1-492668322camr202514645e9.5.1782661428588; 
 Sun, 28 Jun 2026 08:43:48 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46f8d6f10absm32384608f8f.5.2026.06.28.08.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 08:43:48 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: andriy.shevchenko@intel.com
Cc: airlied@gmail.com, amit.barzilai22@gmail.com, andy@kernel.org,
 azuddinadam@gmail.com, chintanlike@gmail.com, conor+dt@kernel.org,
 deller@gmx.de, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, javierm@redhat.com, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Sun, 28 Jun 2026 18:43:12 +0300
Message-ID: <20260628154312.46185-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ajpLyronl7a-yxh-@ashevche-desk.local>
References: <ajpLyronl7a-yxh-@ashevche-desk.local>
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

Firstly, I'd like to thank you for the review.

On Tue, 23 Jun 2026 12:37:31 +0300, Andy Shevchenko wrote:
> While it's not a problem _in this case_, the rule of thumb is always to have a
> trailing comma for non-terminator entry.

This was a repeating comment in the review of this patch.
I will be sending a v3 for this series, I will fix this point in
each location you mentioned in your reviews. This also covers the plane-helper
and encoder-helper arrays and the SSD133X_FAMILY enum entry. The terminator
entries (NR_SSD130X_VARIANTS and the trailing 0 in the command arrays) will be
left without a trailing comma.

>>  /*
>>   * Helper to write data (SSD13XX_DATA) to the device.
>>   */
>> -static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
>> +static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
>>  {
>>  	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
>>  }
>
> Stray change. If needed, either explain in the commit message or create
> a separate patch (depending on the dependencies).

The SSD135X branch I add in ssd130x_write_cmds() passes its const u8 *cmd buffer
to ssd130x_write_data(), which took a non-const u8 *. Rather than cast away const
at the call site, I propagated it into ssd130x_write_data(). I will explain this
in the commit message in v3.

>>  	unsigned int i;
>>  	int ret;
>>  
>> +	/*
>> +	 * The SSD135X family latches command parameters with D/C# HIGH (i.e.
>> +	 * clocked in as data), unlike the other families where the opcode and
>> +	 * all of its parameters are sent as commands (D/C# LOW). Send the
>> +	 * opcode as a command and any following parameter bytes as data.
>> +	 */
>> +	if (ssd130x->device_info->family_id == SSD135X_FAMILY) {
>> +		if (len == 0)
>> +			return 0;
>> +		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
>> +		if (ret || len == 1)
>> +			return ret;
>> +
>> +		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
>> +	}
>
>>  	for (i = 0; i < len; i++) {
>
> This loop seems for the len, so it will be the same for both devices as far as
> I can see the context. I can't find this piece in the original driver, perhaps
> it's some dependency?

Correct, it's a dependency. The for loop is unchanged context, not added by this
patch. ssd130x_write_cmds() was introduced in commit 208211646fb3 ("drm/solomon: add
ssd130x_run_cmd_seq() for batch command execution"). It is in drm-misc-next,
but not yet in the mainline.
That loop is the existing command path used by every family except SSD135X:
it clocks each byte out as a command (D/C# LOW). This patch only adds the SSD135X
branch above it, which returns early, so for SSD135X the loop is never reached.

The v3 cover letter will explicitly state that this series is based on drm-misc-next,
hopefully avoiding any future confusion.

>> +/*
>> + * Variadic wrapper around ssd130x_write_cmds(). The first variadic argument is
>> + * the command opcode and the following ones are its options/parameters.
>> + */
>> +static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
>> +			     /* u8 cmd, u8 option, ... */...)
>> +{
>> +	u8 buf[8];
>> +	va_list ap;
>> +	int i;
>> +
>> +	if (count > ARRAY_SIZE(buf))
>> +		return -EINVAL;
>> +
>> +	va_start(ap, count);
>
>> +	for (i = 0; i < count; i++)
>
> Can be
> 
> 	for (int i = 0; i < count; i++)

Fixed in v3.


>> +	const u8 cmds[] = {
>
> Why not static?

This array can't be made static. It is initialised with runtime values
(ssd130x->width - 1 and ssd130x->height - 1), so it is not a compile-time
constant and a static/file-scope definition wouldn't compile.
The other ssd13xx_init() functions are non-static for exactly the same
reason.

>> +		4, SSD135X_SET_CONTRAST, 0xc8, 0x80, 0xc8,
>> +		2, SSD135X_SET_CONTRAST_MASTER, 0x0f,
>> +		2, SSD135X_SET_PRECHARGE2, 0x01,
>> +		1, SSD135X_SET_DISPLAY_NORMAL,
>> +		2, SSD13XX_SET_SEG_REMAP, remap,
>
>> +		0,
>
> No trailing comma for the terminator entry.

Removing it in v3. The other init arrays in drm-misc-next still carry the
terminator comma, but that's pre-existing code outside this series -- I've left
it alone to avoid unrelated churn. Happy to send a separate cleanup if you'd
prefer.

>> +	};
>> +
>> +	/*
>> +	 * ssd130x_power_on() issues a short reset pulse, but the SSD1351 is not
>> +	 * ready to accept commands immediately afterwards. Give the controller
>> +	 * time to settle before sending the init sequence.
>> +	 */
>
> Any reference to the datasheet?

It's not a datasheet figure. fb_ssd1351 doesn't do it in init_display() either;
it inherits it from the shared fbtft_reset() helper, which deasserts reset and
then does msleep(120) before any command is sent. The 120 ms is a generic fbtft
blanket value, not an SSD1351 number -- the SSD1351 datasheet's reset timing is
microsecond-scale.

I removed the msleep() and retested this on the hardware. The panel still 
initialises reliably.
I'll drop the msleep() in v3.

>> +		int ret = ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
>> +
>> +		if (ret < 0)
>> +			return ret;
>
> This style is discouraged as it's harder to maintain. Better to split
> assignment and definition
> 
> 		int ret;
> 
> 		ret = ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
> 		if (ret < 0)
> 			return ret;

Noted. Will fix for v3.



-- 
Thanks,
Amit
