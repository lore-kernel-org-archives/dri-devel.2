Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC94C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8D9310E604;
	Sat, 18 Jul 2026 21:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WsV4EkbX";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4FD10E604
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:57:44 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47640541585so4433783f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784411862; x=1785016662;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wa93jje6EgHUk7Zt2ECfepwMi/iCuz+0PNAnYeWTQUc=;
 b=WsV4EkbXZzIijIsx/WI40dPq6zfJtAQjLfjsdJV+AoU1I1Taqf4jmeLJeGl7xxA4Ey
 0uh5Z8J+KzukaRkpRzkLaIYUXq/pmy0HqjNgQ4YMbykaXT+y4MsfUX0EqzIiTZUXcEqY
 DPzbdW7i2M376vLJ/W4IWU64YDm3sMFh85XaPA29a00/PmD9GeXzbhpaWBUYgEZpWIYp
 8Lh2sh7YpLpVDa5DRnQ1Zccf6TADO5NtABCypLQN5o83MHK2bTxAaeZzeBltDeeSB0Go
 2NCLrcJCAmGU3m8/C5Ri8yc15UzTbG9c4qQ1sDWkhKNDbiOW1V3RVGFlC1XVSs9zF4Mu
 Ivnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411862; x=1785016662;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wa93jje6EgHUk7Zt2ECfepwMi/iCuz+0PNAnYeWTQUc=;
 b=B/iylqpLva4njNebHaomUADEnnHEaiKfNka7XJSQyhVVmc28NsVD4s88xVLwzmbMcT
 b2q6q1E0NJN1NvKLlgz2vBt4RomSJaMLNxQ85zYp+DelJBXFUvx4hZpwZHqlO5nQe63y
 JpRyFWOXS/Vp6AsZrlcLKEyZgXAmzp06/At5iDMrYj1I8R5/QXVQwOdrnz1pbj9qeTiT
 RO9wgyuMjtlyfs08csiBZEZLOqyHHBkZlp43q2Ymuj7kf5E2kBALEnsuThZ7okPOL6hJ
 zhdlHrl081/15T5RhfLJOghUFG5Wylhwoe6ccIeP3s+db2G4uKAo41rq7/CZmxNgdJRN
 RxTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqthCaDvNefRr9e+WSwex4N7ztIYXlh33l7DcnaR0//TTKUngcZ4BvDd8ejq35oMGrEj+SmTdVz/tY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1Ns8uehHtJYzVVKS/sDjy9SGyUKSODO/t5HoQcUSRiI8oS7uq
 L+1xYEwO58qcvkOvunBwDKQTgPjogF/IOoQ0oCZTBBKmLogMHwfcI1wSf2bcoZzV8/n0Aon2S1T
 u5jWK
X-Gm-Gg: AfdE7ckohpNzFbseYUPatOR2RuoroRBzSwXyrj1D/Dea7ta4JrTSnaAYGhA/lcMwdHN
 g0wULPx5eNPhKlzH39FCIl/S0tl6V5EcESicDbeOjFzcuc/zlgM4gQ5sgzSiCE7DrpD29BUdV6e
 HcsH3lWzX3K291Ii3OBaEgXXOPIGsg5oJFPn9Ig3/S4lq2rbFb4Zbdu8ZRcRsw2W22SqM2jG+Vp
 NbldSjjWfOf1oJ68SDtrahHS/AyZwepbotRMXtj8Z6vVQ+r1DW8L6wglP1fGhrjcSKxta5J+hZF
 NE91Wi+zwq+NztTQ3R+bQkm4P8mx1ILTbrk66J7P5z2Zm7jD9KoYQN3XFWFqeOBzQOWJYN1BBSY
 gnN7eMDep07vUze4nsxYjhU1nwsXrkuMz+0jkI/ka/5e5ninnO5WeROnEBL5OCYPwkI35ejDTik
 M+ZIecBRIeQCsyHH6OPw==
X-Received: by 2002:a05:6000:1844:b0:47f:4e42:669 with SMTP id
 ffacd0b85a97d-47f623169eemr9423338f8f.22.1784411862534; 
 Sat, 18 Jul 2026 14:57:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f63edcd13sm15085022f8f.26.2026.07.18.14.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:57:41 -0700 (PDT)
Date: Sat, 18 Jul 2026 23:57:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
Message-ID: <alv10qYL3K8_Tjqv@monoceros>
References: <20260713101638.600333-1-fuchsfl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kf7otoxip247seh3"
Content-Disposition: inline
In-Reply-To: <20260713101638.600333-1-fuchsfl@gmail.com>
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


--kf7otoxip247seh3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] fbdev: pvr2fb: correct user pointer annotation and
 sentinel initializer
MIME-Version: 1.0

On Mon, Jul 13, 2026 at 12:16:38PM +0200, Florian Fuchs wrote:
> Add __user annotation to buf, as it is passed as a user pointer in
> pin_user_pages_fast(). Use an empty initializer for the sentinel
> board-table entry to avoid initializing a function pointer with an
> integer literal.

FTR: Using 0 in an initializer is covered by the C standard. Anyhow, I
agree that { } is nicer.

Having said that, I think the right thing to do here is to drop the
sentinel entry, because board_driver[] is only used in for loops that
iterate between 0 (inclusive) and ARRAY_SIZE(board_driver) (exclusive).

Also I would split this patch in two.

Best regards
Uwe

--kf7otoxip247seh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpb9tIACgkQj4D7WH0S
/k6qngf9HPcjOLFf9ebMiIVzfNiUMnp3nKAf85kikPbocb6uZIoVWVmOOAbdaj/C
Tt7C7ycDzH1+PbhZFJ+1x3bKOQdYwHpeejamFt/nD2ZAeBxz+9n3ffyHgl2A1mtz
NG5iP2KvP12HrLUBl77GyHrNRc8lSNQPDjNoig1hoD/BXQovkL+vHqmarxeGO0b1
8mM+IEnlVfafEVlywlgSPst6xDnp75HoXQeBxEn0URZosnkm5V6qQklbEpIYXc3E
MN5ANqf3R7WzP2B2QTJl/fmW5c3QwxhwBUrNHp4GPC3MQI6o5zYgfQ6Ma9RGsTEv
j32/Xe/K4MPfVPlfaJrPyCX4JjJmtg==
=FAiA
-----END PGP SIGNATURE-----

--kf7otoxip247seh3--
