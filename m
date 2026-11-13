Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE1606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfliSgpC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B472410E68E;
	Fri, 13 Nov 2026 00:05:25 +0000 (UTC)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A8E10E68E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:05:19 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-7cc1cf48a39so92348137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794528318; x=1795133118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
 b=tfliSgpCIVbv/N+agekNVawVFXXehEf+/Sm1+Xq1AJksg6mW6aiU5MG4/QBT8R7OK6
 7D65Lt5wuoUMsZA0O+DQmIwHa1oopW+tI5CDto2NjpI5tm+NCQyRG81gzAZq4uHHJdau
 libnLlgFTLAzp9HCTCHcOmyA1kB9H/v/+tog4U/43EeM7iQsodeibnHGzksB2Krz7ADL
 mURvEaeU05lIouvoatUQ6dkw9W20MsADksBIF7ngSZeI5hx76NMzehpm/0mGFavRyVlf
 8Z2R5tMWP34sAdJh4ztH/re6x9UIjLHM9ljJhnOkZavcXcyqTAA67n0ArZlocDiMX8FK
 hfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794528318; x=1795133118;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
 b=034o7RaEVPIhBXERhNeLlOaL8QGPAGxTENXYEqZ4TIzcZqKWQGfSvxZRdNDu4+ZPoU
 +brfqnKx6ShXOrEAMog4iiF3uGh9nkWeEDW2O8hTVZbn17xrxioFzGnWdrhtBpABZGC7
 dRjZSVui5mFD5ocQ2PXLzihlg32jNruS1WLmsi4+YG9I/OQ/5b0WsRH1Zdw93pux0T8F
 L+AsvlxrVj/k4GwOBz7hgDoThzdGtExHncdja1mhVCBSsWVYdrHBY7ILs5nEBgPIql9u
 ne3cij8IsNY+j38uXCfVD4yKhBAWs54TfI8dCpwoxVy/fbaUhxgXOJ0aK0k9itE9nHv+
 1zzA==
X-Forwarded-Encrypted: i=1;
 AL+hErFxuaMUCHWRLBFv5oZDFWDAN0qT+OOnBNFD7PdTJAa6C5NkUupbxzyVDzQqO+AiFlqIv6KZnKPdqP4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z97UU7FO02UE27D2D4sf6C1MeoPzfppcHiXVbVArrQZBz8hT+S/
 NBZQ8jWE7rVEDO9Fnl6+0ESC0LApW8J9uCEoB4mHjSngUQ2jDaHzEFXy
X-Gm-Gg: AYBFou2yf+uMrBO8JoltvpC6l5mZrNZ0i12WSSKvEPK+K6x5C0gA+CV3BQwZOfMd2+v
 tvtYh0jtsx7WRHVvnDyHSV1FNX3/qEo+BFuSrTLDPdcTnuF/aY0E1pHhXOvEbD2dSMIYrSvTURh
 3pJbuZgm4BxOTM4L0pN4+EuO+wAQRlsLvzNYgTQRppyxw0e53nycw84lkmWs0Yuof19GlsczhoN
 RM0VvUtDZwVnGgrlQxzA4trLFJdLw0PA4bJzMkTjuzEeguSw96dJqtQT4yLPpFs/wrCW+bT4WRg
 ynAzyEx5UE4732oqGl9Qr4RkP7uutoSuH+Xulg6EqM72HCXPPxzZtFi6PzonjZWHlnSXUBg/N8g
 s1pz5dsR0yaYJAzMAaTN32mCGpU+L64wFBkZmpVTfZswXYG25R73cfjPd8n/AlFvEvdHsAI4tTf
 eaH9LC9RVnfV7I/zi/N3FCCRkbMz5AW3Ib3rAY/4LCJVguNKqC4XbGIxqvVpuJOlUOtOgFzUE+w
 /qeZVeev2eF0PfO2u0IDv8iKEFlG3zHDeXglR9Bw4jNhQhtXwAP98dEFw4T+KSmVxBmmNne+uH9
 TmnTuHi9ActDZO2K8BDalKBR1JK97nAbpSv6hutk3F5R6Mhk3LSJdPGPS7OuDySeApuNaMb6gpv
 L3m3tj8ih/Iaq6xG4KuLYlQ0e0gi9WVPByzH2wYw+W/zBejYhfwaWSy5Hen90rClrlBLhdO3T+/
 gPVC61Mweo
X-Received: by 2002:a05:6102:32d1:b0:7c3:a6f0:99cb with SMTP id
 ada2fe7eead31-7d64db100cbmr246150137.33.1794528316894; 
 Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99c8424fb8fsm546119241.3.2026.11.12.16.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Date: Thu, 12 Nov 2026 19:05:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jan Koester <jan.koester@tuxist.de>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, op-tee@lists.trustedfirmware.org, 
 linux-fsdevel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31eb7df44411@gmail.com>
In-Reply-To: <20261112153841.1661720-1-jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
 <20261112153841.1661720-1-jan.koester@tuxist.de>
Subject: Re: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jan Koester wrote:
> Hi,
> 
> Building the UUID/GUID id RFC (uid_r v2,
> <cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
> config instead of the one I had tested with turned up three users of
> kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
> has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().
> 
> 1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
>     tun_fill_info() may read them without it. Mark that read as
>     data_race() instead of READ_ONCE(). Only classic ids from
>     make_kuid()/make_kgid() are ever stored there.
> 
> 2/3 accel/ivpu: the per-user context limits are keyed by
>     __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
>     only makes the limit stricter for them.
> 
> 3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
>     classic uid. With __kuid_val() alone every UUID or GUID user would
>     get the same one and could act as any other such user towards the
>     TEE, so those logins are refused with -EPERM, like ublk refuses
>     unprivileged devices to them in the series.
> 
> These belong into the series before the patch that lets kuid_t and
> kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
> them now so that the reviewers of these drivers see what uid_r means
> for them.
> 
> Jan Koester (3):
>   tun: read the owner and group without READ_ONCE()
>   accel/ivpu: key user limits by __kuid_val()
>   tee: refuse user logins of UUID and GUID users
> 
>  drivers/accel/ivpu/ivpu_drv.c |  2 +-
>  drivers/net/tun.c             |  8 ++++----
>  drivers/tee/tee_core.c        | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)

I only received this cover letter. Also do not see the patches on
https://lore.kernel.org/all
