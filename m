Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510FDC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB80A10EC9A;
	Wed, 22 Jul 2026 07:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2xmfL55";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106B410EC98
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:19:46 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so67259326d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784704785; x=1785309585; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utW8YbbssTVsulJvHfz/jBDoROF5Koo4xil5lPJsJM0=;
 b=M2xmfL55Lnm4ozHGxaijqxuVxi1S39AOpdi/JMe9Ixyn/tCWaCo/Fi3eqF8tVSowl8
 uKAv26gnSf2CdOYve5mn7PQGg7wRF6aVG7Lse+Y191bICh7KfT8xsMIM6sjRwtb4chQJ
 qRM+b+eoeTKdBND3qGCOnZ6pg5kH3FGNH1zkcw8cpgsK9KrtFX64PgSVgc3fVP9FQBWU
 Dl7xgtxSmB5IEycHWZDVP98BfMWVfZ73FuH2mX7rXpKbwZPw8fIu4tbL1fGY6LIhHXM8
 2TUBZKDggVBe+vIZ7YEdYFlWpyEndiAWiXxxJCvCc0+zyvMyfYFNUaklwc2zJXRXe+AH
 vpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784704785; x=1785309585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=utW8YbbssTVsulJvHfz/jBDoROF5Koo4xil5lPJsJM0=;
 b=e5L/2/yh/QpIN2ci25i0w9Dt290DCHdB9CxLzqzP5X6MVe1CAOgwVWlCqBuwXl3q/l
 K+csPrNXczHXEzMt42ID2xURRs4DnmEq6gPQ/TbmByt37TVAMiGJ7c4G+R4bhDUwde38
 8V0x6JXoQq9hbvD16LJZZCTI1HT+ees6Fo+w7evzXcdwLuJlFhnv7ZpC3vtA6HlEf4Wc
 o+Q9UGAKpOIvdVJuUwlmCe6z4ymsHNeezG9G61xH7pOH8Rgn8rEQU34ThkScVuiftOcQ
 XZoxqWMlSkhslShUPBksYMVIz8S1IOhs4G/d/KdhGNQgz1u9p3Prakx21mAFRBXG0S8e
 tbNA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/ogQHh8AICUVL11db7xRip660xYPJguq24+JWhbM7yVNb4ULeozcjpO14sXHypgIgdKNUvUYwbo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSf90R/Ajv+Z5dJKCEq+hu4kTqmJY9tXeRpURn0jI6pUJfMaRt
 0e7YXQgp640BtgFkybETIdkMX8ev65HOum3sYmntYv14OHBSYxUlja5/
X-Gm-Gg: AR+sD12QSEGGAe9BR7Pe2p8PFkRWFpt60VjuSJzXbQ5F+tXHzJN/8eEKM49OLooENAq
 k/RDuN2KnkGeS0Z+70p3zab4zN88/zaJSj/9ofScR1XqMZsKIT4p84QynYVChvVCoh/iu6oyKYS
 cu0wRIKAy6xTc/rj5YRSKl9UtUPuRn0Z54zKtsQJAxkRe8auzZ7oLQNoKTVPs50GZIK6Js4PkmE
 CXG5eNtxPTRO6fL6m1YNaP0L0vY5hpfNMwqb8y9gfET0wiLO4nLqPkjgbpoQSQ6bYlCMW+JZn9h
 uANAKLOraTPjY2hv151QAbzLcS3nHV6RkCN1iL+PZP089u/sn2+MZv0OBqg9xy946dXsEaItnvb
 L8SbVvPuX5ffB1OXr7q3xtVlgNSu/OlwSkVz2fVbvg9FHsKw5iOLeXrhi3yGONPwDNy7nmtVrMR
 Ma4XXLIdY/P347GtJClG650Cc11gkOBLX365FyzWDiZ1o=
X-Received: by 2002:a05:6214:4992:b0:8f1:617b:2692 with SMTP id
 6a1803df08f44-907b9b3cf0fmr35036926d6.10.1784704784815; 
 Wed, 22 Jul 2026 00:19:44 -0700 (PDT)
Received: from thinker (syn-072-043-128-189.biz.spectrum.com. [72.43.128.189])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e18besm15269996d6.24.2026.07.22.00.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:19:44 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: airlied@gmail.com, andriy.shevchenko@intel.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Wed, 22 Jul 2026 10:19:11 +0300
Message-ID: <20260722071921.43687-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87y0fbs05w.fsf@ocarina.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> wrote:
>>   */
>> -static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
>> +static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
>>  {
>>  	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
>>  }
>
>>
>
> This change is correct but need to be split in a separate preparatory
> patch. When you do that, feel free to add my Reviewed-by tag.

Agreed, adding to v4.


> Please split these ssd130x_write_cmds() and ssd1330x_write_cmd() refactoring
> as separate preparatory patches. This patch is changing too many things at
> once, it is better to have each logical changes as a separate patch. This
> makes reviewer much easier.

Ditto.

> I don't like that this logic is in the ssd130x core part of the driver. This
> is supposed to be transport agonistic and should not be aware of the D/C#
> behaviour that is specific to the SPI transport.
>
> Can we move this to the ssd130x-spi driver? For example, something like the
> following might work:
>
> 1. Make ssd130x_write_cmds() to just be a static inline wrapper that calls
>    to regmap_raw_write(ssd130x->regmap, SSD13XX_COMMAND, cmd, len).
>
> 2. Make ssd130x_write_cmd() be a variadic wrapper around ssd130x_write_cmds().
>
> 3. Add your logic to ssd130x_spi_write() instead of ssd130x_write_cmds(), that
>    way it stays in the correct layer rather than having a leaking abstraction.

I agree, in hindsight this code goes against the transport abstraction.
I'd propose keeping 1 and 2 in a single patch, though. Making ssd130x_write_cmds()
a wrapper around regmap_raw_write() and making ssd130x_write_cmd() a variadic wrapper
around ssd130x_write_cmds() are two halves of the same change: routing command buffers
through regmap_raw_write(). Splitting them would leave an intermediate state that isn't
independently meaningful. Happy to split if you'd still prefer it.

> Also, instead of checking for info->family_id == SSD135X_FAMILY, we could add
> a dc_high_params member (or whatever name is more suitable) to the struct
> ssd130x_spi_transport Then other families that might use the same can just
> reuse this option instead of checking for specific families.

I agree that hard-coding a check for the family isn't open for extension and should be changed.
Adding a member for this in ssd130x_spi_transport is a fitting solution, I'll populate it in
ssd130x_spi_probe() using a static array that will describe which families need dc_high_params.
I'd keep that table in ssd130x-spi.c rather than adding a flag to ssd130x_deviceinfo, so the
D/C# concern stays in the SPI layer instead of leaking into the transport-agnostic device info.


>> +	/*
>> +	 * No long post-reset delay: the controller datasheets only specify
>> +	 * microsecond-scale reset timing. The lengthy delay seen in some other
>> +	 * drivers comes from fbtft's generic reset helper and targets slow
>> +	 * parallel-bus GPIOs, which do not apply here.
>> +	 */
>>  }
>>
>
> I don't understand the point of this comment. You are not changing the logic
> of this function nor I see how this comment is useful.

I originally added a redundant delay that I saw in fb_ssd1351.c, when Andy
noticed it he told me to add a comment so others could understand the difference
between this driver and the fb counterpart.
I agree that it shouldn't be included in v4, it was a specific mistake and I
highly doubt others will see similar situations and if so they can easily research
the subject.

> Instead of ssd133x_write_pixels() and having per family logic in the primary
> place update path, I prefer to have a little bit more of code duplication
> and add an .atomic_update, .atomic_disable, etc for the SSD1351.
>
> Yes, I know that your current approach reduces code duplication but also
> makes it harder to change the primary plane update path for a family without
> affecting another one. This is particularly important in my opinion, given
> that contributors usually just test on their display family when posting
> the patches. So I prefer to have per family callbacks if possible.

Agreed, I'll add per-family .atomic_update/.atomic_disable for SSD135X in v4 and drop
the shared ssd133x_write_pixels() path.

The one thing I'd keep shared is the atomic_check callbacks
(ssd133x_primary_plane_atomic_check and ssd133x_crtc_atomic_check): they have no
family-specific branching - the plane check is generic and the CRTC check only
allocates the RGB565 data_array, which SSD135X needs identically. So I'd reuse them
via the table rather than duplicate. Let me know if you'd rather those were split too.

> Again I wonder if is better to have a device_info member to decide whether to
> register the backlight, instead of harcoding the check for a specific family.

I already have a draft for splitting ssd130x_update_bl() to be per family, removing
the need for this code. I prefer to first submit that patch, and then mention it as
a dependency for v4 of this series.
Feel free to suggest a different solution.

-- 
Thanks,
Amit
