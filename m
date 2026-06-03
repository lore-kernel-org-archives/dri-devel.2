Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B2CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD367113CC8;
	Wed,  3 Jun 2026 15:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u4FkIudM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AAA11212A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7147C446DA;
 Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3490BC2BCC6;
 Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780502205;
 bh=nWtiWxbs9tvtWNadYoIPsgP9JmcACOg4egKziZJamEE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=u4FkIudM/1I8vM4HV9SGoa/cVsQ1Xzy1dGpc/otUANR5iPjR2UmjzU+ts8kiP8214
 bXgfX4uHqRz0RLVqU1Z4LQimtlgo+/Pv7gRd6dWAVIGpspKiasQ07KGlrhzwG+rFY4
 5nbQ+TeGaakifCUV4DkUBh5F7cCLQvXV91sPte6DR0az/6sLEpMsKQeUDSh3obUTvH
 N+qSa95ub9UNuA84n9yxnt8TZxGPUvQvZoKeMiNzyzWe6EqO8JMChAOVGl6ozRfRxY
 8W9Z0J1VZQEfFKMUZEJ+TskPZO0kH5QbDMnDTH9oTsqSNypjFvTCa+VFA34lS0WHwx
 lgUv1DCp5euWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1B01BCD6E55;
 Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Wed, 03 Jun 2026 17:56:41 +0200
Subject: [PATCH v12 3/3] MAINTAINERS: serdev: Add self for serdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-rust_serdev-v12-3-3400ffb88b12@posteo.de>
References: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
In-Reply-To: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=qsfz+Nm+cALqBgF4yy3YFD9abHHV2IjzdqJIYuW/9vo=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqIE67A50dgZMxw9e71+OBgdsu3wwfdXOKEPw/o
 zt1R2EG1RKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaiBOuxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IfpRAAnxApU7aU7REpSwd0w7WygzKbhWtSr+o
 IdmKAt/c1HMNLiI2UtH5Uy7M2sCiW5mIUJaEER+vlY92KwVTfNiUQs4dSjPKpQl3FFRN9yQKz28
 BMR300Rrfy+1ql2GM/VhO7fZ+KHtfel4Wt9W6zIVOcOnz0QWmiaChS/iblAEqqSMIfIa2zEOe/s
 fXPzslcN0b7HycbQCm9nFOTFMT+Z7sOR93MWKFbfGbgu3VCh5CCVk37zVDh/m5Km6wGyDMg5MNd
 NmgpGuxqSv9JFXs5hknbLOYd1Tc/mRNRukt++7SskXEKzG1kL87FpNdU7Q6YO4niX4z3PIY3+Wk
 UbhDQQOm60yqnt+CUHm3YiWOhPPz2QhXz+TA3Zchb2DQy+r0QIc8Q4UEZFiibDg0ptsCEcBh8W1
 TSIHKld4sP9k27r+LRgNBXFT8WLlRnkpa9XEEyOarU0vsiCvlw2jfAAo+NgrxfREeiKkHsQPG7y
 //VpWyqLz2tacEsdAwiv1Z9AejIpzZ269EHso2dfdrQOLjFBQwSH9H7RdU+OesKXVlFryeLF/Wp
 L9EjF3KSoA4F2UjIcAYmYwbaHCch/aqEpV7bqlB2IrvdGhKEVX9JMco+Cqj67Txm/4yjAAx/L4v
 yfst5hVLD3IJSx6R3UuTgkRH7tRRupzC1J9+6Wq2f7fNtpfKFLDg=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
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
Reply-To: markus.probst@posteo.de
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Markus Probst <markus.probst@posteo.de>

Rob mentioned he needs to find someone else to maintain serdev.

Link: https://lore.kernel.org/rust-for-linux/20260430195858.GA1650658-robh@kernel.org/
Link: https://lore.kernel.org/rust-for-linux/da85ceb81f51079d4a8248a1ffde6a27d2ef24ad.camel@posteo.de/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b995cb6e902..200f0ab09f9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24271,7 +24271,7 @@ F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
 SERIAL DEVICE BUS
-M:	Rob Herring <robh@kernel.org>
+M:	Markus Probst <markus.probst@posteo.de>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml

-- 
2.53.0


