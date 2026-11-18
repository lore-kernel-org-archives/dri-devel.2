Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13DE60A2624
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IUCZXs2J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8D510E7FF;
	Wed, 18 Nov 2026 14:16:33 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C5410E7FF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:16:26 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so8360725e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1795011385;
 x=1795616185; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PKEsbvmI/h2yNfkKYeLdhdyKF8D1G+AbgQ3dQC6oEvo=;
 b=IUCZXs2JE7QgTpCobYM+nHc/vW755FdPWEkebhQvVaqfMl4OGSintYe81SbjhfnwOS
 ZucGGoaoqh/iTbucKsfkO5MDyOKULkdKTSMTzWpUMNjx5mI+yQo/PVivS0H9dU2KN6YF
 RA0SYQMApaSFVE7vLXPMLhkeysTrmiCijIwMP+iNuEDA4y9I1XRHeDwI/xfPaXmF/rwQ
 2dEu6ac6ByNIHrcRiVdqtldclWeSdG1qBb2u08veJYsKzjtbwaLVSG5LuOMvYDZuBFEF
 CcaDjeIwcaYIvhbrwrCBQQgUIh3yeKaUYW0MUlMJ9YtjCOYXjItQTyoM4CSrXtqzgUWZ
 y+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011385; x=1795616185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PKEsbvmI/h2yNfkKYeLdhdyKF8D1G+AbgQ3dQC6oEvo=;
 b=iGE74ROUds03ISSHO7/SJ92vPzplB8CIHOd24jkXt9Q14hAJVgVSr3pO6J71SY4ht3
 lD8YfLZgLmq2vSr11St3x1uTiQgtoW4mEsOam8dTSJUpoDmVJxkXyp9htyQxyYGaGkYn
 pDFOWKUArycZeqhERX8wxIRC3lMIaz5GnJfhZ743ZksVKOE7nRC4qWAEt+P+Fg1OyKfB
 jCztxFRPGuv5P09fOiq53AAaYHO10LTVAbdUVURt4/n77zGHFMafQQMVymr1xz8QjEtz
 KFjgyDjPuUg+dbg0bdh2gDGWnpCY3As86LrIgDcMmaQ1CW31Z7WfpwwKkC8LzgLg27xJ
 myxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE6UetKOW/FqAK+PxtHS00piFRc5riZoXjRxER9hVH3wbmXIYqymv5WlUzT/glaKnCfq7ZguX/YSq0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4eXHjXPMx6I3y5sS/ELtrS2u8W00zWZdmluINPo/s4c+H32ix
 mAmV0j8EhQ5biJfW6ILxyHTZ7rm8qdwP3KfVV0XTZ1H7o2ZU3y1cxz7bZXbLG9ZlW9dR4Jtu+BS
 fL0ywdjZumA==
X-Gm-Gg: AYBFou1VYcj9wXvJwPN4qb93qOakcbZn6mK+sr2matNJoyv4ZFD/TGaVItLP1vYc/NO
 H7KFe4xFIjyrgKqETYaicanPEScHWIcpKoTPwgXbMGfcrgn83zg6T5W5/5vTqTY5p4PVz+m2yFD
 sdh/MpsXBgNY8P2i6Goz/1LwnE5xymkKCpGCNADLVrX3N4Tjt7rop+kZogcrMGyfVmx/fshfVqc
 1iZse/lJK7zO4UtgoY+lobVh/jNWQA8dsTVsP8uD6IQ7FM5tHeeYktZunCVlDH4rMAw0o7pDWIZ
 XlnintHq44clm1sV/oirpx2ciwmI8xm4igIUXSueIw4wLBiVaTqnJKnEcDPYMU/dFJ3fZlW9S1I
 aiP3/q2+E1Rby0QPBAdJcNdaSSLOEDVsgsCn3id9DQDIdjt2yIsXnRokqvqDBGWkI1RPcNkr7zk
 9EfE64B0z1VOUBPKRX4tcVFtlOyq/FNHteRb39wU2bvuF3baNdGnr8G6b/H3Ab/6E0ck3sYWEPI
 5GpLondoaF89VSXrLf859dRQQvs73PB8O7tw8bQUPsIZ0l0HFizsNRZ5IeFTyd/L1OUE0fvSb7b
 6IwHgUl7xRuySjWTBRROCsDXRXEYT4+MVXfRKTbK98y979W81kpVhal22dCEwb++Yq1gI+M5v3o
 ZgoCcBezDdxI8E2AHAHr+1F+DEDuzzBgz8X9j4Y51dMtDfGd+QcyybAxdWIS0mtwVIxRnk9U=
X-Received: by 2002:a05:600c:19d0:b0:4bb:5de1:e923 with SMTP id
 5b1f17b1804b1-4bb7d6d1de3mr52112595e9.4.1795011385062; 
 Wed, 18 Nov 2026 06:16:25 -0800 (PST)
Received: from alcachofa.home (cst-prg-52-235.cust.vodafone.cz.
 [46.135.52.235]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7843bd79sm146337145e9.14.2026.11.18.06.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:16:24 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Chaoyi Chen <kernel@airkyi.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: (subset) [PATCH 4/4] MAINTAINERS: accel/rocket: Add rockchip mail
 list for rocket
Date: Wed, 18 Nov 2026 15:15:23 +0100
Message-ID: <179501127061.337132.729815382590515286.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814022453.437-5-kernel@airkyi.com>
References: <20260814022453.437-5-kernel@airkyi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 14 Aug 2026 10:24:53 +0800, Chaoyi Chen wrote:
> The rocket is a DRM accel driver for the Rockchip NPU. Add the Rockchip
> mailing listso that changes can be tracked.

Applied, thanks!

[4/4] MAINTAINERS: accel/rocket: Add rockchip mail list for rocket
      commit: 20f0d3fdc8f51ff89d23f107bdb66db03e2dbdb5

Best regards,
-- 
Tomeu Vizoso <tomeu@tomeuvizoso.net>
