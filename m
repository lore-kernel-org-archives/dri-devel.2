Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0DBCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B3110E8E7;
	Mon, 28 Sep 2026 14:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDLG4goQ";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8485010E8E7
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:52:48 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4e1dso2306799e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790607166; cv=none;
 d=google.com; s=arc-20260327;
 b=NvC18pxHYvbCxI/edCjl6GYFCs0n/9wnBbA9Vq/Dx5wF+xYZ07F1Ql8JbDbSRkSAPx
 CMWA5ImWBLMjVDjVVIDhmajZ9DJgi46XE96HqZGzYvSgtdYgM1gtVH3mWYq/OTA0Ray5
 W2pYcoEzhuW4ip6T4GXQQsDnguSTZmrk3gj9yEOfx576vk2NF/UQ0rfS9ADHkvGgLbEj
 dPjCMop1UV4881pvgvOeAdIoxGlkh3yKqIVKga1Mr/Dy3xY4T03/WnebMrfd4ZtZ534S
 y2W6TOjdDyoFwRIUrwFvxS/Clw3N/bZ/oUmuOdm3AdxWEYF2rgem+U8CuPUec4lPoXlv
 evvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LayCXAFHVmoDJ7OzuMd5bfhOgMn0WjtS+zr0t0p63QA=;
 fh=mKr05x0NXR9Ll693umCutw8ktlNvIk/f9RRdj2EP4BE=;
 b=hZzvhEPWJsTAoIOHm9yBbModF3fH6wLDU/89IvHnDzeLv2ewYTDgeP5XykxOc2zZls
 EPS8t+/fDhq1t58+brbMQ1/nbpfkqH4tYj27UCncVoTrxYk+7XmYo+zZSWJGGvFaf6Lh
 EqT8Ty/FFh1NXo/4f1CjDmqT8eJKKBTbqgleMAZmfEu+HQQgh8zZdCf8nYrLyP1W7ZZz
 NFXVzHP5Rd0TCSHtF2N3uQVbD9Aq/hkJIpyINYdX5aqZmzEmh8lV7a+KdCxlIfvbcJhG
 siAB4VAB7/oDhpfpqdL3+26FLePS1o40Qi0Qimt+uXiHZnu7uxoAthx8fRo0p4bRV99y
 Ok5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790607166; x=1791211966; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LayCXAFHVmoDJ7OzuMd5bfhOgMn0WjtS+zr0t0p63QA=;
 b=KDLG4goQuG+7Dhq5S/jt7I5AeGn2UpFqjksEkh9n2qP+REG6iAbiX7ivFIS83OkND5
 UYWjF5ufZHNSoashRJSZSvRJCGFoe8tqiPrdLNOSZGcYkrmdGXvbBE4FPQNAJcAmOLRB
 Hg9OaEMcl+QQo6VU07B0P8YC/H3qcnPIeysWqyQwRI3/G/rhACQsKaStNAeNkpnfjfnV
 UAXgu6sR8HBKvXKf3+067isMcKAAE7aCslpXzxFj99vdbzCF6gN6/Plq8jWL0fLOmtKT
 F4LrRslC5W1if4AeXg39G0Usic/CInrt2Em7oqx+S6nzDsqJLVXe5cGCrsCE6j6yAP+3
 lg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607166; x=1791211966;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LayCXAFHVmoDJ7OzuMd5bfhOgMn0WjtS+zr0t0p63QA=;
 b=vjjOVHyITOeBRHDkCRNr0yORZA4pUzbj9y0b+3+ydaZBIdIJqQqAMFt7sIAxyj2YPF
 l7akMHSYcHsV8g5wX6zQRvot017bguweTkPA58PBmdS3rySpDfCTNsdVrx2uTVh8QIkl
 0lsB1yuzgx+jM+IGbZLZPDosRZKCoiRadaTcuCEOmM/AXUI/86vPhBUjnz98W0OCm7eQ
 voqd9ybAmNxBMdeq4Frx7+5u5CNbzsYmgtP3FVaruSeGckxtdd/xwv+QeAeNJ/CaTiOG
 WbKzcB79gIUoom9+SValOPZtKR0bMyNHifkT19BuaGvpZfzwYjAx1ZxkWy38xBrf01uB
 U1Cg==
X-Gm-Message-State: AFq9FYKZTbFSiz77VTt+scNK5GI3P2mvw6cenITwRf9LCat9tbuGrGVc
 H3KL4INXKn/J2rUgzYKxpTvdWF49MH7MlEXwkx158i0cgqR+qGcKo+USTTarYB9YPf3lC5WtwkJ
 ufa6xUHCi7/3UhD0zsla+7+XZTE04498=
X-Gm-Gg: AYBFou1HTgTHt+k3cXre0NJc7c8LB10sf5rPKjMJDIJLcGHjmYUlAImqNA7Bm49agiO
 IV+t83JFXT/yUPIWxz6m2cdvi4j3sVkYZW0EwehTMp9qedGI7blz1qmH3HKCEwCAAWkwTAnYK7V
 YBz4zxvBTYLN27x55jCNZc96Hm+RXY7azWh24sJfrWat1LUgQYpAwpVtZa/BzYT+8+8nv5HGgWC
 MFSj2vmPxzTa3pdzL/XoVAbiAgcUuMXpIei/SqnsaG7bbHWYu/XJwELA/edcLq084lYs7qfCGS7
 C38tRb/Y7PvrWBM/8j9lWWfJkonKU+2QXeoL0kxQ4yy7zjCXvl8KbvYUhFofaH7LBotUxeQ46vZ
 bF1wivf2WHlQ+b506i5k61Fi34PTsFZ0A5DaMQBd/spUOt6GxngOCxkM9Lgw2Hub/lbEpQd2bHR
 i+fZgn26dW/A==
X-Received: by 2002:a05:6512:2396:b0:5b8:f417:dbf2 with SMTP id
 2adb3069b0e04-5b8f417dcfamr2127641e87.45.1790607166317; Mon, 28 Sep 2026
 07:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
 <20260920193944.110983-3-kieweg.leander@gmail.com>
 <349a5c40-5cc4-4e24-8e24-4e05fc8a7bca@suse.de>
In-Reply-To: <349a5c40-5cc4-4e24-8e24-4e05fc8a7bca@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Mon, 28 Sep 2026 16:52:34 +0200
X-Gm-Features: AclHuK9TPVsBjaiGZv0TSHgVz7QThaWnF_VETNU5oTwrNIVOU7PP1d6BRDXXjHo
Message-ID: <CAMwcS0jd91B+9PvYeZTC+yuOxMc7hO8-Q0YMbXE51WiFHnvpWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 u.kleine-koenig@baylibre.com
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

Hi Thomas,

> One remark on future updates: I assume that you want to further update
> or extend the HW design. One thing you should certainly add is a
> version/feature identifier, so that the driver can distinguish among
> different hardware generations. We also cannot merge support for
> everyone's hobbyist hardware and you got the benefit of being the
> first.  So for future submitters of similar drivers, it might be better
> for them to build upon your work instead of coming up within something
> entirely new. A distinct identifier will be helpful with that.

I'm planning to add a hardware register in a future revision
that exposes a version number that the driver can read.

> Is there a reason to no use drm_crtc_vblank_atomic_flush() ? It's the
> same code.

I will use drm_crtc_vblank_atomic_flush() in v6.

On the QEMU device ID: it's currently a placeholder from the
experimental range, since I haven't submitted the QEMU patch to get
an official one yet. Is that fine to merge as is, with a follow-up
kernel patch once the official ID is assigned?

Best regards,
Leander
