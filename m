Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ADAC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 16:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2843A10E19E;
	Sun, 28 Jun 2026 16:30:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFsBAPgL";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859EB10E19E
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 16:30:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4926ee9e8d9so10156835e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782664229; x=1783269029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMnBtmnHmhK3jg0PxdbXqkHYJjM0gMd6xqD4YPFeDWU=;
 b=XFsBAPgLCACdM0rjj18pDWp7GrE1gVRkafKMl+G5Td8MV+AkYBR+gWJe9HucEUHUxB
 oeuaQ50iynpbkHgDKtjeLU43lEXoAzntRC5Ph3BOoz0ppzC9zazTGyDoXIUH8YDocDlH
 R4Prrt1KXloNueMxQGAqP2j4NrYwBtwEFjvebNejA/oyWmX5F10Lp+NSCG3vySltBCd5
 GoX1O2+mv1eSm2BjUKMdEUyn93yQNsS3FFlTIo7Dkl71H+Z8d2vh8tdv1oWJU3NVW72R
 P4TfjFfqU/uiRA6J9Ol73ytgYm3vMCGyT1j+ZWhGpfRe6M+iTeE+fyqdEHLc4I5Q3j9G
 CJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782664229; x=1783269029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fMnBtmnHmhK3jg0PxdbXqkHYJjM0gMd6xqD4YPFeDWU=;
 b=P+bzcYvVZ1BK/38b1Hmr60Z1ugoVzNlCm9ujlQmfGZh/ur/goXG/kDw/YOq+37yQM1
 Rc9MKC61+Eaa52DkTH5sbsJEj286ZEbKlQASiJYIazC++GcyiN+x/8n3rrNW5DZdNRkX
 +tsvpitsobpkxtluOpebPCCJ4LT1lmrJtxHWi1PmXrs+NkbdU1PTm52tfejRa5jfM6kn
 FiVybGiFw2pAle98Jl67IOtQEZ+lSThnGKjwBD41Qph9V1lY1sh60dRWBKHW06040f+J
 UzTTMOjJZ+9eT+r3GUIqeu2Jctk9LuW5A1FSuozQtfXL8Jo6Q/r1B9wlIOQ/8BwWOU3a
 F5fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e6gjocjcrjMCTCNZvvdwtkskj5JLvHDZ6pr7SbPqqGu5DhhAUYLqSIc+/sXnR9WUCII3dHborSDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx70qgfy8NGG/5mMRl+1jGmAQ2KP8wyMz4ZMopFgVNCm7JctN9K
 2bdiVuCXfFFKihFnNWUIi+Xff5jXHty5mifVOvHGEzyaNGRrEVel09R0
X-Gm-Gg: AfdE7cmR/bvdS+8E9SlnnZ3Lw8CFr4utrAAszoumasvCEMdSMWOxQUSododShlozxi5
 ZMbFrSDhQGbm1jg2QSBx2r43DOtwajhT1FfJDEdojdVcaGfcmWTF+QatE4uFEmnZOiYEIaqD6JL
 tjkAjSC2w55GZZFL14yUC2+DIvLTt7cICUKMxYUHMcP/G53XnBs8+GKbwET1nSu9r/vD8QR9phi
 lYDl31CiMbZhx0/IWhG4X5FynauYqWRfk3Fww3ZnQ7ge86JeLjNgeauDO+9Z0/HeQdRmyxwmIS5
 CAhiVYUJ7hkkf8QvZ2s5nXiZ2ZssqLo8Tf9OeuMNTLMw7G7igIyuAk7MQ6G+yfQQPAGr9WI4T5z
 2/iCCgDH8uwoBhxj2hYMPml42yqvkwLSVCaGxn7f+/UCy/196LMOvKbkk2MbHctk7OT2va6UOR5
 S+RwwSeRVegiD1BuqgT4JF3MvmLDw=
X-Received: by 2002:a05:600c:e54a:20b0:492:3fb5:3a17 with SMTP id
 5b1f17b1804b1-492663f5bc7mr127559565e9.2.1782664228533; 
 Sun, 28 Jun 2026 09:30:28 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fde98csm261474625e9.6.2026.06.28.09.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 09:30:26 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: andriy.shevchenko@intel.com
Cc: airlied@gmail.com, andy@kernel.org, azuddinadam@gmail.com,
 chintanlike@gmail.com, conor+dt@kernel.org, deller@gmx.de,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, javierm@redhat.com, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
Date: Sun, 28 Jun 2026 19:30:02 +0300
Message-ID: <20260628163002.56829-1-amit.barzilai22@gmail.com>
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

Thanks for the review.

On Tue, 23 Jun 2026 12:03:06 +0300, Andy Shevchenko wrote:
>> + * Each Segment holds one pixel and each Common output has a row
>> + * of pixels. A pixel is 8 bits (one byte) in the 256 color
>> + * (RGB332) format or 16 bits (two bytes) in the 65k color
>> + * (RGB565) format. When using the (default) horizontal address
>> + * increment mode, the pixel data is sent Segment by Segment
>> + * (e.g: SEG0 first).
>>   *
>>   * When using the 256 color depth format, each pixel contains 3
>>   * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
>>   * 2 bits respectively.
>
> Something wrong with the plural. There is a difference between "3-bit" and
> "3 bits", but "3 bit" is odd.

You're right. This is pre-existing context, but since I'm reworking the block
I'll fix it. In v3 it will read:

	 * These have 3, 3 and 2 bits respectively.

>> + *
>> + * When using the 65k color depth format, each pixel contains 3
>> + * sub-pixels for color A, B and C. These have 5 bit, 6 bit and
>> + * 5 bits respectively.
>
> Same mistake is repeated here.

Fixing it the same way in v3:

	 * These have 5, 6 and 5 bits respectively.

>> +/*
>> + * Per-variant output format selector for the SSD133X data path. The
>> + * hardware can drive the panel in RGB332 (1 byte/pixel) or RGB565
>> + * (2 bytes/pixel); this is a policy choice per variant, not a
>
> In other comments it was spelled fully, be consistent "1 byte per pixel",
> "2 bytes per pixel".

Good catch. Rather than spell it out, I'll switch to "bpp" (bits per pixel),
which is more concise and matches the wording already used in the commit
message. For consistency I'll update both this comment and the
ssd133x_format_info() one in ssd130x.c. In v3:

	 * hardware can drive the panel in RGB332 (8bpp) or RGB565 (16bpp);
	 * this is a policy choice per variant, not a



--
Thanks,
Amit
