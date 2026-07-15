Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3024BC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5775310E19C;
	Wed, 15 Jul 2026 10:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgD30gPY";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463F710E19C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:09:15 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-668000f86d5so2535598d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784110154; cv=none;
 d=google.com; s=arc-20260327;
 b=KR4nuADrePTsaDFKoig1pm/zkllVwdQC4iuKNHUEfX+qsiDRvmWcitLPVavfc936Tb
 yVVTfh3z7WJV7ZUKZWArEqp0WVdxFsx/XAsz6owbdw3DelPBcB4/umGIZhwcSQPOYNsf
 UEAmCyTr1jph6JtK65yZoxWN0q4TR8VdGTBoVxAZIoh5SQRBY0n5+Gr5XrYaBnjV8KJF
 5NA+WuU0tEut8RWNpB2Tien7CFyNZkGK8VSsiqFhymgqQFLRdkjxi1KidTR3peGxLMzP
 E9u/V+xHBFQsvwGaMg7E8W0+7CJJBofr624ljbsTsWo44aNyM5Bm0LY+lljjw9e1Wl8r
 imTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XGYpZsgieVFFhOL3ph/3XYmQbfybsrWcalMLoSP0uuA=;
 fh=g59ib/FQZzd3llt3k+6ABaSNKoBK6OLVbeYcuqJWID4=;
 b=k4AQhWjFyky6Hm2O0Gid9pmdIbbEr9XL/BJrWRtjQUezRFzaVFZo0fZZpMMZfbt7nf
 KxJTDhfqqlazOOF52Q7EjqQORX3G24kgeOphcYfAygjvSdYrSGq3vXk7auJhh17y7sOJ
 79ZH5WQ91UmhbJTNiv9NBPGvT6U8x5voUaXr48C2WePcxKTrjBQV47vvFbRiq8QAN7PI
 GXlEp7NqK3K0++GxqxwhLJ5lk81qX68frD09VF3TqyHRxqtbEwgkngzN1np+0EXCVNBf
 4Y9K9KpTLGaaDLQCCHTJTAb0wqqz5x8ZR9uRyHS1wMplfwipnMLfy0uDeWPrXaLYLgR4
 /frA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784110154; x=1784714954; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XGYpZsgieVFFhOL3ph/3XYmQbfybsrWcalMLoSP0uuA=;
 b=SgD30gPYw+ou6Q+daOiNuFrIpu/4gym9xlwLAeqOh1rm6VE1Qg3V3IwAmDmh4kWn+K
 B9Lk12E26rdWIV0CDqdhqT3tKP01JzxMlf9y87ZPX0+LLD150jVpr4Vvr7hYQJdugWG/
 aUVtze/UT6ubcT2z0QHCjxmD3zE6pD2WpyoIWMO+8oEeuHA9etK8KBTtaz9Dm8ldNlBZ
 WAOfMB7Dfq58ZkFuqvShiozQWg9JjypXowklU3F42k6hhwnye2f3SbT9PjSWhvL62vl/
 Nt/meCqzIMzoPs50+RRH7CRRk9INzZ20Qa7AEPhO/2uS7YUfewm4WzjUVOp18mxsacm0
 4PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784110154; x=1784714954;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XGYpZsgieVFFhOL3ph/3XYmQbfybsrWcalMLoSP0uuA=;
 b=Spf0XqxnB4l7L2QWVirbK6I/7E0pQCwZl/gN7B8KWBUMEohaPvq7cV8Fx1uGVunxIW
 INcyRExJtGy8vUiPG8MaEoI+wdSMbnmPfSS6Q6Ri6mGyMjSrWzoPxf62Zz1JOZPKvZs0
 U29LrOLeZ7P9o4+F/2fPcFCsHIGu3V79Qe4xiTMjRNBYhmfEjbg7vmYN54r2anm/GLqG
 k/yf508qlPjOFJyou43BSGKvIi7DNyRWdQxKPqkdvdjodWdTXY0vvqaA8TtmVmOScve4
 uVmQ34G127gOTYNgKgMG2eswTgizpwjHs7LexZnrQcp+rXSFOB7iQQn+HF5jV23tWD8n
 tZWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox6b5mnNHoX7X0gw50P+oKsJZMn6ByA5vUlay84Su9mQ1e8iNQvVhgjrq77/qzHc613LY/kenXbN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNGqkhyLAXNPOEpVhLlh/HHnFOmy3s/FZ5qQRNPq4BfTG9r7tX
 usthxplTgW5n2oLu/160wMLWdNf5/Aa7X0sFkR4A/AFONdBnLMKgVs4/eG/au68uhy5cT7db6do
 RsDfVhRVBdQMXKsvayca3ntNiG/Qc6Tw=
X-Gm-Gg: AfdE7clda5uQE+UM4cC1eWS10M0gROzfuLt0hsCsyf4LgSsw77Ffl9J2+d1S3JLR26a
 qrDzixsgEA9QsICSHtyf9Naz9uycl/lMm+y8/ZEnz7SC9x3SZn9NkJyHLdllE80WXc1EkMMsnbA
 i5jVLC7IRIMjhTd4JENO4IbtITrjkLybBb5N5kIYtW+0QPdmQjAVYurcnmYYuE+lxHsATqcsR4E
 ofFCnqzzqthW9pbtaDIsFiCAeynQBy6aRuphrvhW53JwhbPSVyAtvE55lO8U0sCWq97WjXyXgTp
 Bkuftcwz
X-Received: by 2002:a05:690e:439b:b0:667:e04a:8a3f with SMTP id
 956f58d0204a3-668076ce418mr2545637d50.5.1784110154097; Wed, 15 Jul 2026
 03:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-9-302d986fe5f0@kernel.org>
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-9-302d986fe5f0@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 15 Jul 2026 12:09:03 +0200
X-Gm-Features: AUfX_mwvKOV546jjTbsz7nr7N7_PEsARUuD-YV7hD2kcTUJXTZqaK1POxCIPN0A
Message-ID: <CABdCQ=OiPEEL791BxO+T2FoO0NYvJtL+9Zt7-GPMFvCDKGFQNA@mail.gmail.com>
Subject: Re: [PATCH 09/60] drm/st7920: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Maxime,

The ST7920 driver changes look correct to me.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
