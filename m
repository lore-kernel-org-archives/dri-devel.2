Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A79C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C714C10EFA3;
	Wed,  9 Sep 2026 08:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTCV+r5S";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107D910EFA8
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:05:34 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b2ad861b1so785172a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 01:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788941133; cv=none;
 d=google.com; s=arc-20260327;
 b=CI97drB89yJLJ0tPtY1+YftKDM7smzZlPeQvq2WP3locBXGbEoTa0FKxqbVMmCpMb6
 o/ESb7/WdjOdWJfVJKKuUvaYJLSqafm06JkrWS4k4NAkhXJfamXiPocsz3oP0ekZkGsP
 1PHGWLjaMKZlDoRDoluvrTcLuBd45iiJ7FGtR9LIE2EKpNYg7xnGjw1IEF13ZPn+dHRa
 B8sSlCeumCSHsq4LATk/E1Ks6D33/x2yv15l6pfblTGh/wIewqCQWlRySr+Qp9L8VXCn
 V/c4QFXyGJmcmMFHmlmyPdX7ab+C7xMXCTDW4QyyYIiZVYxhB69+mllnwQ/8uu0VCY/l
 i25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 fh=MISysH+7Nzx6tHSx2t3c1b2xeNhsvolKEvy2NTheR0g=;
 b=bRRgJPpRnazjG0EwLZxFJssPN8cuogp/HEhfE2qlmy/XukA9y8UoPyuCVbY7pwZtFZ
 c0/ZpOhgwtNPDAWQTlmlB3mbLACMrHTyPzkkiReguqHcbt5R1TvIb4JaCb7Bm20CxUy7
 h3lde8Hl/3Xs80NjxwzGFXrVM3kr/1I+cudlYnTXwKo6JNV1K3nRXuC6FTC3AkasShNU
 rmcG3Br8wbvMJLu4fuwOzyj0umdYjob+xd1AE/8zKDkhbQbPbDl5xwMreGBo3MgQ3g1s
 CcRnF4xdTo7iQ7JkMGb5mHLZMRQNHZ2Ve9yt++ukdBX44/Yo9sLfdX29TR/PbjlPcvXm
 6Zvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788941133; x=1789545933; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 b=XTCV+r5SFH0XdE4qfFcGVaOgX8sw9wXFdpvdyPYQrl5B+gHuKZicQNIaWdBymA6+3h
 unWi5iOcLCBgMhQxRTTf5krPV5g1X9Bli2SvccoUU/6USMom9t7ZVxGQmtfAJ2h84940
 HiWIKeMRrnam0K9HKO04byRLJJFNZspeCboiigCDrOGpUH8smerfClCymsKUKjrMzr3y
 sV2kYW/GvR6sgIOiizyIAuztmWYJ4SSZI3Q3aR3LG401mB7VkB3Wzs6H+LvjJfLthK4E
 6zGiaE+d19rBwpiKh1yEsev4NNPVzVuHPLZqIN7rFhZG+wZcUuHFe+upTowOPLaGP7Hz
 zjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788941133; x=1789545933;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PFzJhTwC5v2xxJH8grG7O2UX6Uz5UZc0kMv7qk7w9wE=;
 b=g+uRYXVy9FwNId7+4CRAJmlZUMoaHfXggkREfAed+yuHQ2xcxJtS66LvraGbDCiX+2
 8ZkqU9R235BV0fXwh7eRxiIXn3mO6uChO1cYypi5GS8RrbM80bDp3C69h0MCkmMd0SqG
 VH1yuIrZ4JeHUhXjfGjElso4LwWT9JiHSv1vw2uzkGvNgkAp2ywg+ooYRz5ZlkylDtqb
 1KPNrb1DjvhoGkzfqRIbQlqbK7TiPvdF6JiMjRs6sM79XI2M9jUDzesiIxqzrLonLC0o
 WZwRhedwmA+Xg6tihAu3z64W73Ev57msCQYW9eKdesc2yr7yIGEde/hfh2l+c6KlGKhZ
 FaOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByFae+hOUB33FK8puNPmYPXBmIBjKH2Jiznk7/z3NDkvyNHh7mJ9+hsozCVsbAI8OScJ6VQXHTZWU4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mxdalrKVI1SoWHsuWXqgCU/SG1gLkQ4ZWMhDrUoZ/6B9VzhiUv
 vsVJEfeudHZ71OorhgWNdGwunYhc4LtOloeb2/SbSWWcILGOMXtmJUF3n9Mgvdsx/sWSw7YRlVi
 MBDaQa/Dude4cS2lIOBZ6HSno5M5ebzM=
X-Gm-Gg: AYBFou21RV9P9gbeiqGPBwxo72FyEczIDhW1NCrhjmGgVwwp0dBofhpqVF5KHlAllH5
 9egCi2/EE6xnfjpPBv+D6yVrn/wsvWiS74oNUqxD7LAuL2rYWnKJbcvLnZB/Ey5LH9SGST7oyk3
 1OZKHlvi+Mep8OUuWCcK2ZwOlx9X8eDYOFeSsHrbhpugyYfNaQhEzlbrj3XvOgdEhEVTXuQCaFp
 m84IPsmHVb+8s0uBXQbC+X5HupI25EFIJq0xiByjgYcdF4Unk3SseuLerqdsuVHm4eHdDJhkMhw
 QMe2rqeMYaninP10gXLCA1ODOTgSZpe05veyLmYyKbXcLwJiKWkzvUKqpcaqwWaaA4IXM+RLipk
 fOkzDFIzf2IJVbAwQc6da8QgdoKR1X5BB6QweUbfLZviWa+ZoVyFLDPAjH4o9Z8+St8zach/Jsa
 /89cPZJoUDK88CijX3qMQQxoxg18Q5VwHV1sukEjN1v2bD7yV1w8o=
X-Received: by 2002:a17:90b:498c:b0:398:a2e4:c784 with SMTP id
 98e67ed59e1d1-39b3d5c4449mr23521825a91.1.1788941133232; Wed, 09 Sep 2026
 01:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260908175427.47207-1-klarasmodin@gmail.com>
 <2642740a-b894-47bd-b26e-cabdaa14d8b8@suse.de>
In-Reply-To: <2642740a-b894-47bd-b26e-cabdaa14d8b8@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Sep 2026 10:05:20 +0200
X-Gm-Features: AcwNN1VaFSH3EyJDGBY_TKDiMWxaUjeqs441wwiCpqb3pVX1iCtXogyjN7rFa0g
Message-ID: <CANiq72ntt_2n03UReCt6zFD_AvTMvNE6O+v3E3sURTsqW6x4Ng@mail.gmail.com>
Subject: Re: [PATCH] rust/drm/gem: initialize callbacks with
 ..pin_init::zeroed()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Klara Modin <klarasmodin@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Thorsten Leemhuis <linux@leemhuis.info>, Manuel Ebner <manuelebner@mailbox.org>,
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 9, 2026 at 10:01=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Please see my bug report at [1].  This patch fixes half of it. I still ge=
t

I think fixing that is the respin that Klara meant in

  https://lore.kernel.org/rust-for-linux/aqBf1UYNR-Q3T-cs@soda.int.kasm.eu/

Cheers,
Miguel
