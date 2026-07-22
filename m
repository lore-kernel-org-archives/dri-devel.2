Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6FC44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425AF10E2B8;
	Wed, 22 Jul 2026 07:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="esENstQf";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281A710E2B8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784706741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ve+PAmrMmy3YGE+ZBaGl9LBgIZtxakmaZDmlMaxCHrU=;
 b=esENstQfgZQYIksxU0GJsWPaPq8p+lu1WAwHzm3h842tkK6zeWD6eEbFr2GmCO8dyVwGZq
 s4BGKLa+1kk3JICdLKm4hsMl2fFfFxUHCesPcfog8xX2yJgCgi5DxIXemXq27nSH8f3XN6
 u6xz3yVU1uXTKKEHFryJmbvAV9iB2LY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-nLu00vsoOGCxEuuXHRuX7Q-1; Wed, 22 Jul 2026 03:52:19 -0400
X-MC-Unique: nLu00vsoOGCxEuuXHRuX7Q-1
X-Mimecast-MFC-AGG-ID: nLu00vsoOGCxEuuXHRuX7Q_1784706738
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f84ac1990so340491f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706738; x=1785311538;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ve+PAmrMmy3YGE+ZBaGl9LBgIZtxakmaZDmlMaxCHrU=;
 b=c7WmiSIr3PBeOWzohTqiTkB6RvRHaLmkcDxSiQC/Io7YyehbmO1Jt4TK8UCg1klaUr
 1ul8AaQLtlkssH3bZ+WaN1KlhQeFNhm+L60GqQf811uvEKfEFGgVRNP0GRBhQtrLl72W
 p7ttYy2S3P+CArj2cWZcEPX0khR0v6jsNom9Z5RHBl8nxcPdQ2sIRfMWhw1eQvrxVjUw
 xbldfwiXKai3QhZ8yvnuoT5MS6PIPkuaad1fJKTxlFbqOBjFwU/39EtZSFVGTa0sasCS
 TX0wU63GXK6pE2VR63+PaV6z5XVDyplnCy+Du2bT/uZh5mXaCbfQlcuBtp11ukTcGrs+
 dHPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF/ueecxNdk7yo+0Uxv2qciwuVtZ3G4AWz2Hc/lEn1+PX+kR+LOAR+APUv9XkQPx+0AVz42RgV8co=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxti2mSH4eyZ5HP/2cCwlBwpA4lVhAXGx9myOw2XaQqQsu78Km2
 ec6A0kqQ05OL18DlPEI9yNB4W0CD6reK2c0Q/e7/TodHd3tO/S2GvAuDF61rGkL+hO0ZPR0CUc6
 cqf2eN5UdZ+Axyx2W2v0/dY5AVkbvhVPJfH0ZrujzU9zHprenD/GYMneuPnV4eDTET8XfHg==
X-Gm-Gg: AR+sD12PmXDe4kKRg97/oVJ3FJ2bu4ump8wt/2bzsRrPkOYqffMSyNJNXVvApp5WFj/
 TM/XXCZ6fguzePVb4mzy1efArUFhcNuzGSW8bznqe5CGUgR08+aazZXLh4+wFSSQSBDiG0/gxzY
 Rn9IK1EVTMpsJbdQBZ/j+Kj6yPtstpe+WcRUqUlXpnYMVyLnioKpVgnyN0HkmMrwSzRHnqL21gC
 xL6z4Ld+/1vl91QoRXQcbuvOOU54PEwDUlNBC7EcC+iO14iGkaAQ5UUczozKaScjjXR37UMgVFr
 THfHP6ml0XAbVpWQz4cAWvznjmYJqPrOxf1AY7ulWxj0HMdZQ4ffyi/RZroSUK9+vOxM72QkC0/
 7LVQvUJ31GdvbNd8Eakj87m8jfF/wb2N2RWnwnF5E+zHRJGmXZ7cDiiIKy68=
X-Received: by 2002:a05:6000:41fc:b0:47d:eddd:a90 with SMTP id
 ffacd0b85a97d-47f62343c9amr25508097f8f.61.1784706738327; 
 Wed, 22 Jul 2026 00:52:18 -0700 (PDT)
X-Received: by 2002:a05:6000:41fc:b0:47d:eddd:a90 with SMTP id
 ffacd0b85a97d-47f62343c9amr25508076f8f.61.1784706737752; 
 Wed, 22 Jul 2026 00:52:17 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm3930493f8f.7.2026.07.22.00.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:52:16 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: airlied@gmail.com, andriy.shevchenko@intel.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, robh@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
In-Reply-To: <20260722071921.43687-1-amit.barzilai22@gmail.com>
References: <20260722071921.43687-1-amit.barzilai22@gmail.com>
Date: Wed, 22 Jul 2026 09:52:15 +0200
Message-ID: <87pl0fsbps.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8B-46tMWUQuQDf0C1VqNfy2z5IinupmjI_mr-sodfVY_1784706738
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

[...]

>>
>> Can we move this to the ssd130x-spi driver? For example, something like the
>> following might work:
>>
>> 1. Make ssd130x_write_cmds() to just be a static inline wrapper that calls
>>    to regmap_raw_write(ssd130x->regmap, SSD13XX_COMMAND, cmd, len).
>>
>> 2. Make ssd130x_write_cmd() be a variadic wrapper around ssd130x_write_cmds().
>>
>> 3. Add your logic to ssd130x_spi_write() instead of ssd130x_write_cmds(), that
>>    way it stays in the correct layer rather than having a leaking abstraction.
>
> I agree, in hindsight this code goes against the transport abstraction.
> I'd propose keeping 1 and 2 in a single patch, though. Making ssd130x_write_cmds()
> a wrapper around regmap_raw_write() and making ssd130x_write_cmd() a variadic wrapper
> around ssd130x_write_cmds() are two halves of the same change: routing command buffers
> through regmap_raw_write(). Splitting them would leave an intermediate state that isn't
> independently meaningful. Happy to split if you'd still prefer it.
>

Yeah, as one patch is OK I think.

>> Also, instead of checking for info->family_id == SSD135X_FAMILY, we could add
>> a dc_high_params member (or whatever name is more suitable) to the struct
>> ssd130x_spi_transport Then other families that might use the same can just
>> reuse this option instead of checking for specific families.
>
> I agree that hard-coding a check for the family isn't open for extension and should be changed.
> Adding a member for this in ssd130x_spi_transport is a fitting solution, I'll populate it in
> ssd130x_spi_probe() using a static array that will describe which families need dc_high_params.
> I'd keep that table in ssd130x-spi.c rather than adding a flag to ssd130x_deviceinfo, so the
> D/C# concern stays in the SPI layer instead of leaking into the transport-agnostic device info.
>

That works too. I don't have a strong preference on how should be
handled. As long as the logic remains in the SPI part of the driver.

>
>>> +	/*
>>> +	 * No long post-reset delay: the controller datasheets only specify
>>> +	 * microsecond-scale reset timing. The lengthy delay seen in some other
>>> +	 * drivers comes from fbtft's generic reset helper and targets slow
>>> +	 * parallel-bus GPIOs, which do not apply here.
>>> +	 */
>>>  }
>>>
>>
>> I don't understand the point of this comment. You are not changing the logic
>> of this function nor I see how this comment is useful.
>
> I originally added a redundant delay that I saw in fb_ssd1351.c, when Andy
> noticed it he told me to add a comment so others could understand the difference
> between this driver and the fb counterpart.
> I agree that it shouldn't be included in v4, it was a specific mistake and I
> highly doubt others will see similar situations and if so they can easily research
> the subject.
>

Ok, great.

>> Instead of ssd133x_write_pixels() and having per family logic in the primary
>> place update path, I prefer to have a little bit more of code duplication
>> and add an .atomic_update, .atomic_disable, etc for the SSD1351.
>>
>> Yes, I know that your current approach reduces code duplication but also
>> makes it harder to change the primary plane update path for a family without
>> affecting another one. This is particularly important in my opinion, given
>> that contributors usually just test on their display family when posting
>> the patches. So I prefer to have per family callbacks if possible.
>
> Agreed, I'll add per-family .atomic_update/.atomic_disable for SSD135X in v4 and drop
> the shared ssd133x_write_pixels() path.
>
> The one thing I'd keep shared is the atomic_check callbacks
> (ssd133x_primary_plane_atomic_check and ssd133x_crtc_atomic_check): they have no
> family-specific branching - the plane check is generic and the CRTC check only
> allocates the RGB565 data_array, which SSD135X needs identically. So I'd reuse them
> via the table rather than duplicate. Let me know if you'd rather those were split too.
>

Yeah, I agree with you here.

>> Again I wonder if is better to have a device_info member to decide whether to
>> register the backlight, instead of harcoding the check for a specific family.
>
> I already have a draft for splitting ssd130x_update_bl() to be per family, removing
> the need for this code. I prefer to first submit that patch, and then mention it as
> a dependency for v4 of this series.
> Feel free to suggest a different solution.
>

That works for me. Or we could keep the family check for now, knowing that
a follow-up series from you are going to remove it and properly handle it.

> -- 
> Thanks,
> Amit
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

