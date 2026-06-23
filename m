Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F52CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B8B10E239;
	Tue, 23 Jun 2026 21:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pk02RkDP";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE6F10E239
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:35:16 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso3549995e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782250515; x=1782855315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npX1zE3oC8B9i4AqwB/UnRyXW+2tBx9spPlY9cjsius=;
 b=Pk02RkDPoZ223ZOh3E1NHm9lNaLpWwT7/mLh82MZcenyiVjFxNSuV2LieQjzceqkYv
 NaGyAL3XOG+GcEg/lzltY1gISJSMNcgEEplBO38E0p6KArSsR4+4Ekp24F4u/HCBVJ3f
 LmzY498ev00BoU5j068oE6YgcXapQITMwO/H8Br2tKaYop/ku78aW/c7A2orIvOOj0Rf
 MhS3pmuwL/66eWX+4gBFp1alFJkjuklgBTTgUBndcd8SeFUNLMpZuo1toKaCCmzUf+R9
 RZ2nNp/O8PCsxzytQ2AuKFEK93onpivkw5fFffslAR38yueEur7mQL07TtQ2oKSqTwgk
 5FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782250515; x=1782855315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=npX1zE3oC8B9i4AqwB/UnRyXW+2tBx9spPlY9cjsius=;
 b=bgp0cLgn2whdKzLVjgtCjZ3LybUQnoCBWTxlLoVHoKOf/vUB6WWQTWmokCUAyxCaAw
 QMLVmkCrBzSoimLX1SHL6HTgl0w8Zhqpfl/hoIqDulvxer4O4bc7EllRSy57HkStilMz
 iT+QYABGsVHILw5urgAsb0WcvOu8jMgNrklx9rrQeqbdYGRHHE8TtsDiLMuF0V+s82Oo
 d5rF67481ZtLlINep+s9eASemVyJS4Qvg72atty91BMjXYg7qDcAYTnGDV9gXpUEcYsT
 QvCABeU8y2H7mz/0CmIoyvrv6JhdwbJJREGQ7V+LhY7z1oU2JF0l3u8Waq4vfflBPtQg
 3ijA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bgWrqQNc+K3GU4o3L0WEgYOkzT1S3n1eaIZBsAwW6OpsbrzxczdMZk2LXEFY8b/apVTvUA6M3Gx4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0VjedYv69Vkwvp8FJ0bR4SoiPFTyEFH2dZKp1C4MEDi8MrNfH
 zmHGXkCqlFsmA6p4Dg8rO71HCY01nhoIo6POfg6Y9SFk+jcthqDNFUTK
X-Gm-Gg: AfdE7clQ5QCSqtPWSyCYfqcNYsytKomU2h1sPz28kiJVlgl7lXgenC4FG1CB/W1UeYC
 PnGlI719jb7NaWbwI86uzRHUVq23vfLa7x2GQfGWF5rLx/9q9CGn7GtcEuYaPFtFuSMqCciiJAb
 iaJseWLUToR9d2E9tnnS+wMrYZO/ahENGjXQfXj8NmIh1I84/JJ5yzhOU7REx1FY8zo14a30aCm
 qEu2l3ldNDAzG0HAj6GuAZtIsEfJ8mhvHE4frSu3BWc11poSMHJi5KR/+3RD/ZEUXx9rCGcSkuI
 IfD0ukSFjyzbqsfw4rlhqBD4/lycNXewEus20vv993lzmfINYDwpE6HKzQogWbxOG/xPMGi3PAy
 LH9Y+wrIsEbblKrav1SBVqGl+xFXWwUi4m0+njYUnCtsQCoI5HEStEWyOd8XBaGgWNEaua4pgO6
 4pv1l6NIVhN8YOj8ftZAQHiLGrs7xFrht8MQhvdA==
X-Received: by 2002:a05:600d:10b:b0:490:b642:ce31 with SMTP id
 5b1f17b1804b1-49260840c5amr3352535e9.2.1782250514831; 
 Tue, 23 Jun 2026 14:35:14 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93d8sm1059435f8f.23.2026.06.23.14.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 14:35:13 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: markus.elfring@web.de
Cc: airlied@gmail.com, amit.barzilai22@gmail.com, andy@kernel.org,
 azuddinadam@gmail.com, chintanlike@gmail.com, conor+dt@kernel.org,
 deller@gmx.de, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, javierm@redhat.com, krzk+dt@kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Date: Wed, 24 Jun 2026 00:34:47 +0300
Message-ID: <20260623213447.30196-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
References: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
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

Markus Elfring <Markus.Elfring@web.de> writes:

>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -146,6 +146,33 @@
>>  #define SSD133X_COLOR_DEPTH_256			0x0
>>  #define SSD133X_COLOR_DEPTH_65K			0x1
>>  
>> +/* ssd135x commands */
>> +#define SSD135X_SET_COL_RANGE			0x15
>> +#define SSD135X_WRITE_RAM			0x5c
>> +#define SSD135X_SET_ROW_RANGE			0x75
> [...]
>
> How do you think about to use an enumeration for such data?
> https://en.wikipedia.org/wiki/Enumerated_type#C_and_syntactically_similar_languages

Thank you for the suggestion.

I used #define to stay consistent with the rest of ssd130x.c, where the
command constants for the other families are all defined the same way.
In my opinion an enum could be a readable solution for these values, but I
don't think the switch should be included in this series.

-- 
Thanks,

Amit

