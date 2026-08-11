Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA53BC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E337710E2F4;
	Tue, 11 Aug 2026 21:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bY+Vxfey";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 620FB10E2F4
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:28:39 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4957952e0f8so353405e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786483718; x=1787088518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gp0euUyLe4l7U+iJjP259imx6iGI99L5pT79qh+F49U=;
 b=bY+VxfeyL167qihqLyvdvcs3cF7TIPDcv3lxxF4vm1UDn7+E0kD971esyhiuLDHl4K
 KhMzrr4upe3NQO10bZDBtsVYYGUBTBILvIB3GcfBrzE8HBiNz+kO2YXlWkdohfVD6k/k
 B0nvbmeQ97MHgFPenh0zyfhpo2q/GfrexJEHpoBTtqYm4f6maTuKstYnTWepZQjEKGXb
 QecAAFvyqKRR7ymlD1+/6IiCMIn3/AiMRVT4zx3QQOPwBNm8AkBAVfV6k0HCWz27xaIp
 pSS9yenSeKJLLOW6ac1pWFH+fS0ROakvgAHMDvhcHer7yyuZ67IzK4Ucv4dMPJIwv2xL
 jnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786483718; x=1787088518;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gp0euUyLe4l7U+iJjP259imx6iGI99L5pT79qh+F49U=;
 b=U1CAGRMg5RmS0QAB6nFi/Ws/J7ccJ55xv02xYonbSuRLoMNfiKoCvWipsjRnVhW2Sn
 owC8gbrC4aZ3nq2FZEBQO30vFNCJN7yljD19Qk+nC2dzTgwvZrSMpiLXMpNhcaDfvBpU
 +nSjumaRh7Z4BuM+57AFZUrPUR0K0rOrukVhEIH03uoqFJWd+ynF+38muXgu+5s5yg/O
 bU1AemMtbh2Qiyq/ktRXUb46ZA4UoRLub/2v1/X0FXaMgUR/1qs5jcBLgFNC3PDDOiI+
 S4ne/0EqiTitQAJrU1SeJmnD/zwnr2AQq2y9GncACrdxgXXFNcRTx1cYLe2BXq32xkf4
 8Kug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr626TEFYtpEu1duufdx/r2c6aTkA7xImF0M3aG2POpChK1DxzT51BIqCqRY/egdLg7IJD666TovBc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+P841+JFgMXcmkOT1FV/g3xa1GVVPuccH9Pc2KQNl9/sQOzBe
 GDJPtoRQgv/auVOh2wKafZ/W3s/LcWkMPbS11X+jcjYO0aQNsrXeHn3E
X-Gm-Gg: AR+sD12Qrq58XaVcPJOILC1x3yr9rGUfy+UqPEtb8hXRLkyYHKZ4ShiszsQaJKQYK8/
 EPGQVr822PAPPIjezLFEavn6ikApKRD0Sm1j4gfznZJEWzZQSlK+i5JKztu0EwtHQyDkZudUijg
 RE+6vsfLa+tBi27MoofTfqVZ1lt49VDO+hrl6IWgZZs1bM2q1CbSdzdj76e9ISknyrR5zVFOHoA
 7b9C2ssTAxkAGEOb1CthG3ykJW+LDUkV8Y+g75hp8hjtmwfvOI5AG0OU3hwVhlkfNZuzxzqcR6w
 SO8ZimdIKjBRKBhejgtkj/6QhYtpzEhy1dHJA1sdwb0fsMaaRoXPGA0Pf60OqFZC01w/SGadXIg
 g7csPQicJlj5cNiiiYYfZtF78S6rJH7MQcNaKkriEfiIQWdCKWMVsoRLL4B5y/odm3q1r4EAYFF
 HnKJ2XN0CpcHdk9tb1YIrQOf2Vn+3lcgB7Y2Mdid+DUhBtj1KHVasr5uROweFb16aYGz0YkFgOJ
 oSgzPy+eXrSL/MgVAEoof0LUxi4oXe0b6FUwls+4723+ciHtTUDKS9hbmfM4Gv6tqN3Tg==
X-Received: by 2002:a05:600c:a48:b0:499:73ca:c419 with SMTP id
 5b1f17b1804b1-4997c12c6c7mr1024745e9.4.1786483717603; 
 Tue, 11 Aug 2026 14:28:37 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B94ED005B06BF1B5A09FFE4.dsl.pool.telekom.hu.
 [2001:4c4e:1b94:ed00:5b06:bf1b:5a09:ffe4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c057f0sm1359078f8f.9.2026.08.11.14.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:28:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jiaxing Hu <gahing@gahingwoo.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Date: Tue, 11 Aug 2026 23:28:14 +0200
Message-ID: <20260811212818.10487-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Tomeu,

A gentle ping on this one. It has been on the list since 29 July and has
picked up review and test coverage in the meantime:

  Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
  Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
  Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
  Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus

so it now carries two reviews and two independent test reports, covering
the two NanoPC-T6 variants besides my own board.

The reason I am pinging rather than simply waiting: Jiaxing's RK3576
enablement series is based on this patch as of v6,

  https://lore.kernel.org/linux-rockchip/20260806063413.350184-1-gahing@gahingwoo.com/

and he has a v7 in preparation. Up to v5 that series carried a duplicate
of the same hunk, which would have conflicted whichever of the two landed
first. Basing on this patch is the right fix, but it does mean his series
is now waiting behind it.

Nothing has changed in the patch itself since v2 and there is no open
comment on it, so it should apply as is. Happy to resend it with the tags
collected if that is easier for you.

Thanks,
Igor
