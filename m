Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7905EC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E00710F1CB;
	Thu,  2 Jul 2026 07:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dv/o6iai";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E1110E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:07 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso741099b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927667; x=1783532467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NGLo90uqHHqpamVY8idPGcyCygevI0iwqE7yaGUNoQs=;
 b=dv/o6iaiE6AoQB4BPMhlXOB9RTnTgEbui2s3xkFKMF5y8kvA8Fra9fixnc53N0N6ty
 kk7DncnFriS4WHn2BI7J9oDIhexaCNXItYOtDeEPEvFaxbAPJtbgy+acNVCN0NnVMqd/
 Ie2B/XOwx7QELA1BesKbHX1oy2fOzUBZUV+XMjwo65Om1Gs7tBk1Ybp3etPx6QBm0lPM
 MO/3sYbO/nIbH9zXnivq0SRFoQaE2oLVNkJq80DAGStXaa+keA+p6U6A9a7nCLu6mdXC
 J0Xv3nGwKHAvkbduiYF8IN4pmBR1KYWndHjG4acYncPpIichbkOkLyNQVfRHyXOnK9bv
 aMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927667; x=1783532467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGLo90uqHHqpamVY8idPGcyCygevI0iwqE7yaGUNoQs=;
 b=hFcVNiYWQ/LeQgYGc/zt0txNWoiGvEynj+FD3KbOmb4i/Qn4QhBdX4Ip1tmzDI+y31
 Eq5imxDOv1pAfiGZSpGlJWfdI3+CObUv9zrqXDGuB1pp8+Vp6HmccobWjgyk7IdIOZPK
 v1NyR6X89lD4VaKGQkks5/mTw5QQXtq0J8WfadyzjMGnw9I4v3WDQhHG+NPEONDX+0Vd
 Wt82PabedblOmHnyzZ4Tvb0Lv+FceBdr4E+4sLKOJhSeGFzk5YSg0ABFSUI4agGyKptj
 zPQNVqh2nybCAlLSHmH+iFCQGW+qhQLb6DfXADulF8FKaLttuq/g4vD/dVHBLR/0lmyL
 oPzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEe4z2MJDpwAbphTM7tS8gOw/wqNweGby8ehRs7xmiH4JWMSHyyOfxr4WsMQFnPjQxFKwmaQrBJyk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw82rt1moARTq3b3YnMcTlc1lddLH6po0Lp7cmbNAephnsC4dak
 2aCUFK+ijvoW6UeEDANm5C6hEA0eo6TLNqTM5CGnSjVJp8pKEElGGTCq6JGaXkDyeps=
X-Gm-Gg: AfdE7ckRRYu2wEgasIQJRhBtFuB7K3XJEaPmK9/xFbCnhz0wnbgS0jRVxg8DukbnHOJ
 lV78t2YrSGXBQTMNR907JCHhpAwLxe29va5r1v3qACOrVx72t0bhBiwnI+qqCfV+OyTqZG40gKB
 yamBNpiRCOTd/7WV8qvOnE05ObC1TtAQXl2kvAvUh36U1URGVuARmrRTnQy42H7OcR+DrPZKh8u
 1BhsEE8WvnNSVltpjwW0Y//rHK7FkcXmU3xyXDzpNDsSFVEg7ZLOlPWMF0UtIUX5qMBY1Lvch/k
 gYE7U/EP02UXLCjDjCgutnGAjVsSl6iklNFPJGhGr111X0QuPVBc3gq2PuAJ1xzDZMOPPgbKRfT
 BHEC6QKGoh+T2bAA1W57ZMfrn/hr+zcQ/TIurjpY/Wta5FRU8VZe8A76BCooUl0WjlUJKJicSH5
 9JFGUK5B8x43/f4gY=
X-Received: by 2002:a05:6a00:2288:b0:845:eb73:411c with SMTP id
 d2e1a72fcca58-847c0a3b383mr2403969b3a.45.1782927666153; 
 Wed, 01 Jul 2026 10:41:06 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:05 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@gmail.com>
Subject: [PATCH v2 0/5] drm/nova: replace `transmute` with `zerocopy`
Date: Wed,  1 Jul 2026 14:40:51 -0300
Message-Id: <20260701174056.12604-1-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

From: Pedro Yudi Honda <niyudi.honda@gmail.com>

This series follows the introduction of `zerocopy` to rust-next and
replaces `transmute` traits with `zerocopy` traits. These changes are
mechanical and don't alter functionality.

This series is built upon Nicolás' recent patch, and does not touch
gsp bindings.

Specifically, the trait `transmute::FromBytes` is replaced by
`zerocopy::FromBytes` and the trait `transmute::AsBytes` is replaced
by `zerocopy::IntoBytes`. Additional traits such as
`zerocopy::Immutable` and `zerocopy::KnownLayout` are implemented as
necessary.

Pedro Yudi Honda (5):
  drm/nova: use `zerocopy` in firmware.rs
  drm/nova: use `zerocopy` in booter.rs
  drm/nova: use `zerocopy` in fwsec.rs
  drm/nova: use `zerocopy` in bootloader.rs
  drm/nova: use `zerocopy` in riscv.rs

 drivers/gpu/nova-core/firmware.rs             | 10 ++--
 drivers/gpu/nova-core/firmware/booter.rs      | 26 +++-------
 drivers/gpu/nova-core/firmware/fwsec.rs       | 49 +++++--------------
 .../nova-core/firmware/fwsec/bootloader.rs    | 18 ++-----
 drivers/gpu/nova-core/firmware/riscv.rs       | 10 ++--
 5 files changed, 30 insertions(+), 83 deletions(-)

-- 
2.34.1

