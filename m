Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B956AC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1720610E04F;
	Sat,  4 Jul 2026 08:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBidfa3D";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BA310E04F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:46:02 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7eb4d532e65so389598a34.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783154761; cv=none;
 d=google.com; s=arc-20260327;
 b=Hf7JQk/OCucuW5E6LvXfhd9/Prcf92Iji0VTFlqw3jdkSEzzwWxk/qOWT9lCWLJVuM
 cIkJsyFJfQCC1AmAvURX7Rkd9fUjPCwIsTZVeJ0m5Passx4dlx8X9fRJTTO73oW8Yzes
 nKZSwZ8zCsu9C8uSdRss+tNkMtKKFAJHmU7asuZ5mAKnJy/QOM8tjxcHKC1PhP/OigZg
 F5uPYJnPinbRNViLRmEZx984danGDlFhIk65jH7tbvbk5bhaDWBq0G5NtLWRWb4CiHPQ
 WahpGMYlzFs4gP/x62fL4Fq55jAZltmHU7w9aYYPF/fipxkmlgmSCKtf/9e41bdMGJkf
 uZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HdAowFH9jipDKejyM813D662CypK8NeENF8iZZGVI+I=;
 fh=XtwYYOf0ww42BuI7fAkm4CMoTk9JNVx334IrY5rQZ04=;
 b=gDsRjCbrokolfjD4i2Pv3bmRYdfq8RfU/dl5vx8LqgshBt7UybxH8+GMccpybD8ATp
 Bqj3Qz10jA4kfyCgCCnuvFHaoVtaF+6EnHfyPGBPqSfoqKyFkhniSKUJxutZ9zjKE/Vg
 f8/4Boa2x/MBt9kQ9Wpa9ShOahFOXPqdxlVzjyqCAqKtXPNq83q3YRWIZHhdr5lZClGR
 XjQEzzTj9FKaWZrLV63d54aZShHL1+diD5l2m9Cj7deqBLTQRWNZGU5xaecygGIFGJTz
 y2bRdEstQpASgdfc7e2prOFVaXbvOCrGOq/RCyVI0k8cCrVDGfvRNNeRqBN8UTiLkVgf
 RDTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783154761; x=1783759561; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HdAowFH9jipDKejyM813D662CypK8NeENF8iZZGVI+I=;
 b=WBidfa3DQEOtipFpsyD8N2GFBiqTOGTJWAv9uY+0Oec0TwBdhqpgrvnMDEbRZzCReM
 vYwKWs4uUheZm6UDL8zjiAfNG7abUhsEY/lf5zB0zwNanVUPxXvG+52kk0M0amhPGi8B
 Kie6iJyfJa1R0OpXc+w5L8Qct4SSBxlmAhwd0AedjARPDh5Y8YL1XpcVTi1KyLjufBxM
 4SJy8Cfzmq0Lqnm+k1ktXEMiUVaPjfNZsVMA1DSjJQGLs6e21cIDyonxpm8xYDgRaecU
 ASgu5Qbr1Zx7z+xGmJ1LZ8yBYkWRxc5f/GSnvC+mwAwdNqF7/qBKTPNRqtreDvATJqsr
 fMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783154761; x=1783759561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdAowFH9jipDKejyM813D662CypK8NeENF8iZZGVI+I=;
 b=JUIlRc1obtl9zPd7tWbBpNZ/KXzZtMRUrTVvsnRMP7GqSmsqgUpBXiZsSV5SE8mMka
 qXMZ0SZnmmNrpBuesZTruvqysDPMUUPrt12vYx3y0W2zrUcC7Esn4L2TyYItUM6B5ZYS
 +AHaQN1G7CwZTWAXugY6w6zZGSnOGoh8SzxEnKqYCxjYLuW6smna4hAcMCOptcRbnoH0
 1cWabbCW8i97t4vjvY2ENuy158ZomWGl7b4l4vR7SHoaz0nnu1+yn4oAU5+zLAm0Mtg0
 fpFO91FI0wpoxv6NXO+oB63JqKVUCNkFuJaNxT2cnrXEm7gXfKVGHKI3UZvXgdAHsMAk
 4dsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Byv4BU3hDFpUdjaaiNysOpjM05Ido8VQj1v/EqY7azw+PF/yY5RFvAEkrAoL7rVlZ4Yq7H3zBDow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2Px5UjqHFJRh4ZGM0OZy69bGh6K9xtF4SmpVRQxazAXn9jVGA
 ehOIscst2OBt71ZedXTgdWuHH15NnngzIFyegDjDXqiBH5qDWfUtCW4OtgiZdgX0TAq/aaNCB/i
 0JZgOLcwn74txRS6bITkmVWOjlKlwh2E=
X-Gm-Gg: AfdE7cl03B1ZfhaV51lG59GAwA1YfNGmBUmy6X2kADluCvU7y9RnJEKkV5TEL8cn46q
 Lw7aGX+O+PlVr88RX38G5dySAFaaO/rDxx8B5l4KaX4eIsOaJIVqjCA+28A3B8vlmhJa5NmQG+W
 3VjWAJxR3ujp3SyBrslyW0ePIwCl0tCN4MAyMUjPowS2JAyqCn4fx8zjH3mjCT9yKs9ESc15kPW
 cZO5+k69b4poTpS6x+GZiyZrKcoyeOPjp3wKYIs1Y0PPYaQpTiDuvMSqGsTefxAAdJ1uNJwkA==
X-Received: by 2002:a05:6830:67d9:b0:7e9:b4d0:53aa with SMTP id
 46e09a7af769-7eb7fef3ae3mr1509892a34.27.1783154761285; Sat, 04 Jul 2026
 01:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260608124018.480365-2-diogompaissilva@gmail.com>
 <CAJpoHp6DnspnA0rirGb6E=A9wCS3eaDn=eFaqmae98Q+39b1PA@mail.gmail.com>
 <CAJpoHp489qKfkfLOX-XPLpOWo86gibZB=NM_dXPbv0yDGmxysg@mail.gmail.com>
 <2837071.mvXUDI8C0e@phil>
In-Reply-To: <2837071.mvXUDI8C0e@phil>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sat, 4 Jul 2026 10:45:50 +0200
X-Gm-Features: AVVi8CdYOU8UFgiMqZSy_kqF2cXiTqFa8qXPulo_pHpnNo2bmATQgxO9Gfh9jAk
Message-ID: <CAJpoHp4cRALQTDkBevaYu1=v8iOi=4UYZ+9iXHjsLwg+DCb05g@mail.gmail.com>
Subject: Re: [PATCH v4] drm/rockchip: Remove dependency on DRM simple helpers
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 linux-arm-kernel@lists.infradead.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, "javierm@redhat.com" <javierm@redhat.com>
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

Hi Heiko,

> the tool you're using to send patches seems broken.
> In the patch all the places that should be tabs are replaced as spaces.
> This of course does not apply.
>
> Ideally use git send-email or b4 for sending patches.

Sorry, I think it broke due to re-sending with gmail. I will stick to
b4 now. Thanks!

> Also, please don't send new versions as replies to previous ones.
> Tooling can get confused by this, so please start a new thread for
> the next version.

Noted, thanks!

BR,
Diogo
