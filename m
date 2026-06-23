Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA3ECDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C225B10EC85;
	Tue, 23 Jun 2026 20:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="SLFaum1t";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5871410EC85
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:12:07 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c897468a244so70623a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782245527; cv=none;
 d=google.com; s=arc-20240605;
 b=kv5IGdnc9PkeHv5ODYKGzmcNio9X78684GvKmGuJ1k2xSnW1ueDTiJFX++tDZ438n2
 MxnuCrNBftJNTbXhbony+Quv+sLAUXQPERf0hT3NAKX7HWIC3vMzdBdhsA8qQRNxqmzi
 mzj5Gh72AKk3hINNNEOA3z98z9TYQOmGhz32fGafQQmIXEnWff9FMnti9XvGEafyoA+I
 tASZZtl3tqUZYtz8k6eEQkzUth8bcivFWsnwT6DEm39VITwkl15ntHuEw3Lo0GLunawa
 +wlwzuHV3dD1Cqd7V4yqRHc+xq9/QsrfAHxEzCLX6HM9IIlItmUhP0DbE9rl8c3KZO6Q
 d6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 fh=xn4kEl55a9UGXWSTNJ92rDiPR9btXc/1sRcrxdhO+zk=;
 b=iJV60oO517X7Sb0EjULtgpNXk/7GFbWOu+hqxxQOx/NeZGhyLsCglfsFve2PsYB74C
 cPXke6SgMJ6GRfihKX6Bl31T8AOz+qIelf+pM/TWh6GjbXNIAdzy/qRNmubIXwfjdctU
 JF4d6LjX7pydnooqIBdTnZX/7xttiZHRpD3HifVIXYQ9u70itb8elmFp361fmjStdsUR
 VYiFKIAhPCWnyXuuHt4Xty6HPCA+gCVT9QVw9JE3Hy+yhRJKh0nwBiLjctPrOBk9buUa
 dJ1HSiKbe8cnbiEXy7BUiovUNIH+pZohZEJaUCB6j6Hu9hLwHbmToAvj9wZTGqEtLoGK
 nEsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1782245527; x=1782850327;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=SLFaum1ttzn3MWPR4xS4yuwbTzIA/ttE0RHHN+QrdNyv7/ycOucPnT9INrq5kl1pWC
 5wsEANx+btjQjse9azVzRKMXzLUOYDuhKlJ02CIDsLUEX3aS7JSveM8yQcmfRJB/O4LK
 x2IdlfPBoifjEhW+bGbhGP3SbZZs3JOX++fNysLsxx8IQK/dDBwyUAutBa+FUBpa0Kbe
 8fpkvh2/7TWO4o77UReBgs8d1ELoWwqkH0MWi12DOZwPzMHLoDntZqpUQbNkdb3Mgo9+
 re8XCPFSnWU1x7C6Vsmg8oJcCZ30NCXE+U1J9AkWYAUp6RegW5VHy9dZ8GdY9P6j6qyQ
 S1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782245527; x=1782850327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9AA00HARo6TTOGKX0Hmf8exd0jNlIDDEh7Vt3olSGA=;
 b=pgI/Q9qbLNFuOQsJVNdi1zjlUCRq6E/H98dRaR8GkpMp6hMRWHXJIkDxLjtGVEsvNQ
 0QRRohfaFJGjMp+HcDkEjpMOBC0WqPi+xuQJs4uckePIwqXU69fidqocAZ4xy0ncoN99
 zGcbeyof32FdRpYl3Q2Y0AhpDt3p4UzRJNsPpky3Sa+oDRcosatM6cUOQvpQQQtM4R8J
 3zgaSioApF7bQAAXiShW83A2yGWX7IQ38cofefpLTPh50NzhwSqkrRimz5cwIVLqyKBo
 Bc4+Qt/ZsvlLnqfTH//7Rexn+7GuiHmnmC6rZEnyANCb9WjoGBvGRhXlcjjIQQvF+G58
 JZLA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTa/xeVV/7+oVbDqr53xi7UpxLUwP2Mzy8aUHn/LnwzJ6C9K4fN/qgzfCN+IYiI1/H9jYIoOtI4iY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTBD/4ZMmdjLAjn0x7foVO2OBH0Yrc+IKKlnDDpKr30ujyJ9O5
 kzDOyygOb6SeK/kj4PXL3Sg9SIHTXfgUqAgPaU4tyrubQ74eAR6HIeZp+PXVStpUolUcCpWO1yY
 Qd2h4tk2S4vAeK/bA+9XP5axrf52zO1aD3/4p
X-Gm-Gg: AfdE7cmZrJdFZ5WRV+VMWgyxIEhlJQ2+hQAwEBs7R469Z4Cs40JNn8XrmkUkOvAVSWc
 6ZICls3KBQyiIPoCVKQcVxUwXH0qDKGeT0o6rlrTNumjGqZm/mLpMnYB6sJJhbA11jQ47ZHw4Vx
 p24cDTrBkeGJ98g5ng1RTS5mWZowZe2KopiVLqtc1NHTDPAZx3CoJ0fjsY4/KfWSrWDd+Z0jcjb
 PqMn+sMH50gKjuyL4pUH4VyY38S598B7gypmuREYFel5A80hUbYMpkk9xETbT9RMduz0JkH99h7
 YxLnFlED1CJNkTZngQMnYlMwJNassphR8DQjNGk8
X-Received: by 2002:a17:903:240b:b0:2b0:608d:d8a8 with SMTP id
 d9443c01a7336-2c7e13bad7amr4514775ad.1.1782245526813; Tue, 23 Jun 2026
 13:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
 <20260619-drm-no-more-bridge-reset-v3-56-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-56-ff399263111b@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 23 Jun 2026 22:11:54 +0200
X-Gm-Features: AVVi8Ce2NYfA8Y-QDZ6Qs0nmK98DH-xBcBFK3tKliqc_-TAchO1N47N6NmPkuP0
Message-ID: <CAFBinCC7S2N0yKj=ayYf6FyzssLmF0z7JsokKQ=w7pucPxfZ8w@mail.gmail.com>
Subject: Re: [PATCH v3 56/78] drm/meson: encoder_hdmi: Switch to
 atomic_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 19, 2026 at 2:27=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The drm_bridge_funcs.atomic_reset callback and its
> drm_atomic_helper_bridge_reset() helper are deprecated.
>
> Switch to the atomic_create_state callback and its
> drm_atomic_helper_bridge_create_state() counterpart.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
