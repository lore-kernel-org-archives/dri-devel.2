Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2384CCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04D10ECD6;
	Tue, 16 Jun 2026 16:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="F7RuiFC3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61A910ECD6
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 16:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781627256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ONTRu09Dr+Ry3nIH2CFE3AeVpsjq5ZCjzHdim5kHqGk=;
 b=F7RuiFC3wpqb3RzYXXRvkxu2zymOSFZj89P1MFsiqa+f8UQ7ev35Xu3PDhF/QD2XmoR+4M
 SdI+wgDiqjzETK4eD700OD869IoRn4i4J+2LO5z5nUb2O9QIw4cxIAWf8ByA6gcmMCF569
 1T6OHdONoXwGCP0PptUxx2Avwu3MiiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-_a_W9qqfMD2UsMgDpm4SDw-1; Tue, 16 Jun 2026 12:27:35 -0400
X-MC-Unique: _a_W9qqfMD2UsMgDpm4SDw-1
X-Mimecast-MFC-AGG-ID: _a_W9qqfMD2UsMgDpm4SDw_1781627254
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490ace40f13so20767175e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781627254; x=1782232054;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONTRu09Dr+Ry3nIH2CFE3AeVpsjq5ZCjzHdim5kHqGk=;
 b=bM29+tY8hVqsbKIX5R/KOTq1e/NTw+HttMyjKFEJfMSfEDm0Md8qFEuBnQSFYt9gGO
 IndzBJEUR7ziCaEyUPcq5J5b7iodYpHnL27JoF/6U4AfNqPui5wSqAkWt3eeZIjXMuUV
 4DRZvkeGaArn6zu8ND7yanYtzsJQcrE3Kwmfhr8aiFUTyRQRaUKROTZx7te2+z3gBcj3
 UZtI7VNeDupSN4dkLAcyryuTOzb6ghD5BuAlt3M0ERsxKXzruLc/6L6Gw2l0vM2cNnmb
 5jJDgUpcfjdjKcASUGZ/u/KFXegoE0vNEG6qsm64DLSzFwuk9GBorhuLWnhDDvGVuG9H
 H6Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bLeMeCClkZZtqIBgmMf7x7U8i++6/gvHfdLn5wC4ByLWi32RYerixHFTFsUbrC9VLEAjXd8cthT8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzrz5GyiWmr3w2qvBbiuO0UW+yBc3alaWZUpRObGeXoytY8l+17
 2fdxSWz2+f0Rwe8IDIYKJHXFcC2IKS0QVwjkOY1CFfX7Jo0wyjG4qbsYIrOiuzkycV4mKI9NCSS
 qqWdczoTEoqOzJtx2lYzqq1XYUTqC5XB6oO/7bNj3Xy5QCc6Ix84v3eVzMX58gEPG5o1A1g==
X-Gm-Gg: Acq92OFmfmZh/+G50yCGbiqSHWQ/85fajFEjmwswmu+COR5Eo8HhqAfrSSPsctAVDiU
 lt/7oFfikUFGbLKHcbEpsYPtAD7gVqk5HY7ePt/AD8pKDI9T0OR+9YrwThn17S/dvaGSF+9rQWP
 lwpZDairhKvxjkU/gle409gsFoIRyQNzAa6tigya78eTpGIIGpms75+oMTwV0LLC8WcPpLCKsRm
 3G5uZPO5rFYud9U+obOGFCI7Br++2a9JfSLgZxHH27ltjeYgWWuX6R2pr44LYneEddeZZ4dRSsJ
 ufty8Szq+B4bIjN61zANsKKxmDw/Dyqngk76REQnVmDOTcqKyq/Lbqpep7WVwrmHHsPD5/r03lQ
 p+zRYInrbdg76+20qRzgAM0xOYrIAjPeXHNWQxKrt5EpJXnm+QCZvbr+/+rdS983dlPjoNW/6/Y
 J/KK2l
X-Received: by 2002:a05:600d:848a:b0:492:1e36:bb04 with SMTP id
 5b1f17b1804b1-492333f84acmr2657355e9.37.1781627254325; 
 Tue, 16 Jun 2026 09:27:34 -0700 (PDT)
X-Received: by 2002:a05:600d:848a:b0:492:1e36:bb04 with SMTP id
 5b1f17b1804b1-492333f84acmr2656865e9.37.1781627253899; 
 Tue, 16 Jun 2026 09:27:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm2513344f8f.2.2026.06.16.09.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 09:27:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Conor Dooley <conor@kernel.org>, Amit Barzilai <amit.barzilai22@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de
Subject: Re: [PATCH v2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
In-Reply-To: <20260616-nautical-obstinate-a92fd80ef483@spud>
References: <20260615175620.88828-1-amit.barzilai22@gmail.com>
 <20260616-nautical-obstinate-a92fd80ef483@spud>
Date: Tue, 16 Jun 2026 18:27:31 +0200
Message-ID: <87a4suzc0c.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BvdjYiX5hVnlfyjNj9kk0weQvHlM4I2DJRJN3bYmuYQ_1781627254
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

Conor Dooley <conor@kernel.org> writes:

Hello Conor,

> On Mon, Jun 15, 2026 at 08:56:20PM +0300, Amit Barzilai wrote:
>> Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
>> RGB OLED display controller driven over a 4-wire SPI bus. The binding
>> builds on the shared solomon,ssd-common.yaml properties already used by
>> the other Solomon display controllers.
>> 
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
>> ---
>> Changes since v1:
>> - Drop solomon,width / solomon,height: both are deducible from the
>>   compatible and are already declared (as optional) by the referenced
>>   solomon,ssd-common.yaml, so a local override is unnecessary.
>> - Drop the rotation property: it has no consumer (rotation is being removed from the driver).
>> - Use dt-bindings/gpio/gpio.h flag defines in the example
>>   (reset-gpios active-low, dc-gpios active-high).
>
> The user for this appears to be in staging. As far as I understand, the
> policy is that we only add bindings for staging things when they move
> out of staging.
> Sure, this is straightforward but why should an exception be made here?
> Are you working on moving this out of staging?
>


This DT binding was part of a series to add support for "solomon,ssd1351"
to drivers/gpu/drm/solomon/ DRM driver. Amit only sent a v2 of the binding
schema because he had some questions about the driver:

https://lore.kernel.org/dri-devel/87cxxqzwxn.fsf@ocarina.mail-host-address-is-not-set/

But yes, I agree that it would had been better for him to post this as a
part of v2 (and I still expect him to do it), otherwise it is confusing.

Specially since as you pointed out, there is an existing fbdev driver for
the same device in staging.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

