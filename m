Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE940C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B008A10E20F;
	Wed, 29 Jul 2026 13:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RCPEGL1m";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038DC10E20F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:05:26 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490791a3e92so1107945e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785330325; x=1785935125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+zzhIqIVSBoQbM0AVBT+VjFhhPCuzrFXaKl3szG+kqs=;
 b=RCPEGL1mPQF/DGnL9BBMRnJMPLLfjO4rw0jWVOy45pJfXTQ+Vghyp1tpvmZjWF73eh
 iziKyBNBIXbmMjKWc6cZBmXlFo3PUfxvOry325v+LFSrQt7yue61HQHgbMDXZ8X98kYL
 w0QrbNn+d1+mwzVy4kwKNTRa1OrSfVCQp/HH+dgqUP/R60SnJoA/4Evrejw583cfK9Yk
 CRJaAggMmODGCRW3qSPgsNCbQCarDhv4SQ6S5VJ9xvpVP6YO2S9rynxdf35dZ6Os/GAl
 t0bbJ94K4pxj7IbYMM4gXeN/IQkvfz6SMJV7T9Bsf1jL2ybDNzsP3o5kAvvjhm6jt160
 TcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785330325; x=1785935125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+zzhIqIVSBoQbM0AVBT+VjFhhPCuzrFXaKl3szG+kqs=;
 b=fc4dtQfDp3l9vr84wj/u4UwdW8MzcuHkuqdJ/LWUzSCZjv6QeYNGZHP+vPcijAZGrb
 60hpkhiSKOccuftHDKKB61wIITxlIloksmfhxCHEbHsyZiUg9q3wnK+RtbBiN9UNLWvM
 zE+y7RDPIunOmcPIrx1nDpJdU/fhXvwImgcya5BKe30VJDMw75UF1Rf0DmWwt/5p5DXf
 pRUmapGooYZMkSNMGyANcoqagiYiEMW+lxbuYEbJv0vAdKA9uinLmIJ+wicKTt7q0evJ
 lF1Od7f5Nm4olcWByQAcuoXc+nz+Z4Dwv2EDOj4uZSJrk7yMiT0qA+oWgEBqdru/5a1k
 74LA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxwGLw14PLMDjwMMuHRymMe1gg3s+4O7bqiXDv2cZMS0T/0bl9wwqKK6zVPojqZ8q3Hz5wWlkpnP4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbYK1OxRzhct2RdF0WVVr+ElB2BRte3+qs/IpJZbSojqA7x0T+
 oZg5BzFyaT3GpeYnXKRZpF6grC+47oPRxRRO1OT+U0nMKmjQgfqYO95oMoyHzg==
X-Gm-Gg: AR+sD12DvOESY8QIgstSs+yh4cGXTie6bGQqKaK5W0RWnnEasIW+LFlTrQ7pfyzjHAK
 T/NX6vRj4/4QJUfyzvQnrG0PKO7WbD9w/O1K7xtC7RMsKF5Laq9L/xcGf9fA13387WAcQzUvbCO
 0EQTbRA0NvunfzeBKcKzYg3IDAQrCXs16nS5NpS5Zgw20x1PKzANANW/XmRWKVt7Y3RK8ArRUfP
 Qo9yWuMxMj3A3wmYkf6aRt17B0Tt5OJbea0zvIMBI0VgbLJRV8D5up3NpDJ1hkaFBuhggLEzKJm
 PNSaV5gq30RJLR6EfGuiSQ7WPfEl5QOBHZ2/rfamHvXVYDP8rcEbVCUq5lGbQD4PxGVPRupUpxm
 bZTWPCisk4A0HPE82NGO44xxlwo6B3okcY9/RNN/4HsaoxLYhrK03y9IEJ0+G1emkSzxALeBe6r
 8FAkTeeJWPdClenQPeDu9dG8A769JC1jwc54K+RzfdDScIDTtoJz4RtWVs2GvFAmCKhh1qbA1GS
 /4JrEUcgwhPxtqB16tGBPhO/qOpAt8C6j1GowdeElzn+C0K9ZbbRARO5045GKiuvPf87soCllkt
 QMnu
X-Received: by 2002:a05:600c:46ca:b0:493:bea7:6b67 with SMTP id
 5b1f17b1804b1-496c65a60dbmr52320545e9.3.1785330325142; 
 Wed, 29 Jul 2026 06:05:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B886F0027B74C8463513DA4.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:6f00:27b7:4c84:6351:3da4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4975abdca42sm52980835e9.0.2026.07.29.06.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 06:05:24 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH] accel/rocket: request the core clocks by name
Date: Wed, 29 Jul 2026 15:05:02 +0200
Message-ID: <20260729130503.128710-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729105013.1255526-1-gahing@gahingwoo.com>
References: <20260729105013.1255526-1-gahing@gahingwoo.com>
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

Hi Jiaxing,

Thanks a lot for the review - and for the RK3576 data point. Good to
know the same four ids are running on a ROCK 4D; that makes two SoCs
between us indeed.

Good catch on the behaviour change: resolving by name turns a
permissive lookup into a strict one, and that deserves to be findable
in git log when an out-of-tree DT without all four clock-names stops
probing. I have added a paragraph about it to the commit message and
will send a v2 right away with your Reviewed-by collected.

Noted on the v3 timing, and thanks for confirming the iommu patches in
linux-next.

Thanks,
Igor
