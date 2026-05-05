Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D88CD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 01:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DA410E070;
	Tue,  5 May 2026 01:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8efvfbW";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0138210E070
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 01:35:46 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so7998389a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 18:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777944945; cv=none;
 d=google.com; s=arc-20240605;
 b=LOwYnWz4iy9Etz7SfgiB0rneVcYYrjvg1PJ2Ula9P8hSWW1nkbz6x+Duofhxz0u26L
 ZWyhDNFoZQ/DAwIB+PUpkmOsSd7zeSjZ3wG5R6LYMmvNagLTOLep2Ma0SWautLgoddcU
 Uo3pvbzWwNpj8MSvFIvvLpyVVNzY3sJm20Mf4n3mz38poHpDC02PoAUNGQU/kDhwD1F9
 Vs6t42GGTs7QwPu8PuOEoYmsEKDOqnzSK6Ruqn8TdAvc85IZgasj4IXv5aU04cAxJnVo
 m2uZ+PdEaotP3//LI+XVEho7Zfnlvkf47lj1uJuGjYfsjaxDxJrEjNgcGhMX9VX2rTIO
 A8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
 fh=/34jYbRzmKxDfqiS1TNG3tAS+7LiO/AfQhX9E0yAoAM=;
 b=j4jQft4BifRieYKJ0chVGwvoI76zkwPBUGY5q/Mur/QqGexDZBwBMo6ZSYNzY6B6dQ
 DYRd3Zd1oUrzP8OeHszRja1rh/6rVMIPJfu75vF3WfHOt5jlvTn0Zmkb5Y2Y36teo2j0
 7yz8hg0YZV8EmRon6CrCQlL2k3EmxNo/+vRF0HijfTjAtXaQSrhNna+6CAY4kgQSumwl
 Fil5Vy+4Ch5y8wCn9Ir4IueodOMyWHFSisuHvlqBh0pRIxfh/23De+27OgyZ5co/bHT8
 zu8W7zaloJYDMLIf4HAk8kvGRDumoWiOC5nC/sc62RnQP9sFqWI43aCTbD6bTOq7tTUJ
 QnHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777944945; x=1778549745; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
 b=g8efvfbWc9Wyr/A/KtUXfSUNWkX53kQv/LuVyFNM1EdQVLoK2eZLd0/8wZY3yv4g1y
 8V/zOsBXEwTvkb0MJKcQVWrzGvAPvLWLY62G9V4gO5W6o2STKX7rb6Esj8DIfmx74r9N
 vCoaAz8oVkCfyReljW62E8ghw2tg2ZqT6JhVbmzN0SHXSHIBw2mJaM3X+iWxEQeBI3l4
 MsfHrt6ageTHVLtvnUWE2mii3BBcwrdXNibgYS8WLHeZDnGaQRZ19Qiykt0+jFCOkxce
 Lmd8Q/rRStbGpAEzK8SAdJ5hbxX6k77KhPIbJCzjFITAt1Br3iJiVuKxzFZiqz6BsHNJ
 Qmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777944945; x=1778549745;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTz2WcNHl3Rtf8x+dHAU63Kq/74gORQVJ1llz5TyeHg=;
 b=hbjUu/MLW13HS35hZblWcZl+3xDt1BOso+4ZGj2zEz3pF/jPKP1r69KqXgwuVxb+vf
 nZW+u8+gz0gLTFxdKUPfxlsmrpaEJX7Ft7B88IwaR5ZklzP1h5RuZnCmJtj6ytxmzeHU
 U+OypFL82HpPJS1TjZ4082tVAn9vYoh+ck3STXe+OMVnV8BQF7ABJiAqzby/2fdAsbjd
 5dVrQkn7vadKySe7GStolczUTAmW2sjJQMBcZbxxA2QWT1hQ4PGOwj9i8HzAUsTqjIlO
 kr5hj9x4JE3klI/9gyfGfoIwbL6Rta0YO0Eu958+SwWMz6eNBfbVKTv1ID1MomXHjDzo
 7yvA==
X-Gm-Message-State: AOJu0YwvBKOtBmGM0/pGsb5PryoZIO22SdRqONhXGmGDx3Y1nBpA/zZP
 q9mYQDTJFw6bJ+tl0qnNUQAT7njz9FiGFwQWFTJPygoLj48dR6z49r3GfHheSgtCeq+3ik58c/R
 XCRezXh0i3Oximc+QE35mcp3V52qCaB0=
X-Gm-Gg: AeBDievTtT63AHezcGyVt7bvTVgFU3RMgmBZVS3Tv6k3yeQvu/f4L3DHLinVIFjHWkq
 MXsTKLX0puaEuZ0axNFVZIEf9LrR6LyCATQ6XCAUkCwJ3ewemlvoN9CvaNuEFk+RNFpG6XtP+0J
 2T89/GvbiJHyp3+cT6gWeuTXN0YWaOB9hgrvRcPyY5SiTgugry4mFyEOxXXyUDz7Y59HZw3MP5Y
 ce8qDcLqSq0SPyou3yUym/GQVdymjnUvl0yidBX+1Un+wIy9ytzl3xrJIzwK/zMF6oE7AE4aLsO
 NgeyQAKzbxzx5Coe
X-Received: by 2002:a17:906:2083:b0:ba9:559:10c8 with SMTP id
 a640c23a62f3a-bbffbf85acdmr444502866b.41.1777944945361; Mon, 04 May 2026
 18:35:45 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:35:44 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:35:44 -0700
MIME-Version: 1.0
In-Reply-To: <20260420051926.28276-1-dbgh9129@gmail.com>
References: <20260420051926.28276-1-dbgh9129@gmail.com>
From: dbgh9129@gmail.com
Date: Mon, 4 May 2026 18:35:44 -0700
X-Gm-Features: AVHnY4JDB9kuFR4i6jpPy5jP1lj-FAqVVNTnvpy9OmPWVwI33zJPMe1vEG0yoX8
Message-ID: <CACrCO_WT9R51pJhddWysJEHEZ8fhaGvZXq2ZB9vfCD2i6So1cg@mail.gmail.com>
Subject: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
To: adaplas@gmail.com, deller@gmx.de, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu, dbgh9129@gmail.com
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

Hi Antonino and Helge,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are needed.

Best regards,
Yuho Choi
