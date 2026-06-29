Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED7810E70B;
	Mon, 29 Jun 2026 07:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gurudas.dev header.i=@gurudas.dev header.b="g8g5D1EN";
	dkim-atps=neutral
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com
 [63.250.43.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEDC10E002
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:45:04 +0000 (UTC)
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net
 [107.194.158.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4gpX745lPmz8sb8;
 Mon, 29 Jun 2026 03:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
 s=spacemail; t=1782704306;
 bh=9yoPMHqZhzE3iqqcnolBlcsUAlSSjRhy9gREnWpZKGs=;
 h=From:Subject:Date:To:Cc:From;
 b=g8g5D1ENhx0FQXYOE+JOzorI+irSq/d4W2LRj/WFMzmT6KCIBS7JXZnh9ShOgGvNZ
 aszSMWYS/ub/pIKYTwqrIon+1uEFqma6r0HBSn5ixt8jZHDbtLJAJAgazxD7fgzEvp
 kSXsX2UHXYI+HFz5zqXxa2EzMqpV4UuVs3AI/aGF93KLqj93boQneIElJUHAHncIVI
 3vVp7mGhu/nm8AfBxKI50mwA+0/XUsg2ZFMlSZvNy7WixAEk1oNp1h4/QwPHWDPPca
 V5Gwm64Bne8LdzuTHGjEOhJy+S3uOPsnvXG4IyE1GsodIRiBDNDOlIa24h9pYwadjK
 CKuYevZSxFVRQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Subject: [PATCH 0/7] rust: Use kernel style vertical imports in various drivers
Date: Sun, 28 Jun 2026 20:38:14 -0700
Message-Id: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW7AFtmsV4kudD3mRKnMrCKI7
 +6alx+H869kUIHRI1tJMYvJ0CdcLxmFrurfYGmSyeXO596VXBesk0WeoVFC9WX5jYNGS4MHfHD
 F7d5Suo+KVpZ/+vk6bVP9QYhHj7ZtB0PCpC58AAAA
X-Change-ID: 20260628-b4-rust-vertical-imports-b46ee6c2479f
To: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-block@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
vertical import style") and found a few more locations that could
benefit from this cleanup. No functional changes.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Guru Das Srinagesh (7):
      samples: rust_dma: use vertical import style
      pwm: th1520: use vertical import style
      cpufreq: rcpufreq_dt: use vertical import style
      block: rnull: use vertical import style
      net: phy: ax88796b: use vertical import style
      net: phy: qt2025: use vertical import style
      drm/nova: use vertical import style

 drivers/block/rnull/configfs.rs  | 20 ++++++++++++++++----
 drivers/block/rnull/rnull.rs     | 13 ++++++++++---
 drivers/cpufreq/rcpufreq_dt.rs   |  5 ++++-
 drivers/gpu/drm/nova/file.rs     |  5 ++++-
 drivers/gpu/drm/nova/gem.rs      |  6 +++++-
 drivers/net/phy/ax88796b_rust.rs |  7 ++++++-
 drivers/net/phy/qt2025.rs        | 10 ++++++++--
 drivers/pwm/pwm_th1520.rs        |  6 +++++-
 samples/rust/rust_dma.rs         |  5 ++++-
 9 files changed, 62 insertions(+), 15 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260628-b4-rust-vertical-imports-b46ee6c2479f

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

