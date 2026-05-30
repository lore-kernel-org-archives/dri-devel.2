Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B34ECD6E53
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 01:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93C0112687;
	Sat, 30 May 2026 01:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RtsC3ZGz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFFE112684
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 01:13:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2058144D4A;
 Sat, 30 May 2026 01:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC977C32782;
 Sat, 30 May 2026 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780103633;
 bh=i6yyE0Dn4THGDheAsQuCbxaViLFW1ARK5q9G8YpPkPo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RtsC3ZGz9u2DK+Zyrk2jsN1VIMkR+g4cATyoF/zIiAjIYMTknDJHNjnSpNnXbM4as
 0Rm6vTKsObq0n1kaRMmhzl1A2SHLnGS9IUTVIdD9x+p9qPKRUs20BXM7HYXfUuvry0
 ITo7TRxXHaRobKnL3Qxl6BGf+Rc1sgp9tfezmEGZAXLA2PQyHfawkDXfjml9n+cRB5
 alvrMKWL0TnsLCXAL3CGQOO0vrBFJ+kzcXobU9+eW63XPIZXJ1lptQSMbtMtZxEHf4
 xGNtBmwh42++H9XI3N7YCwdkyZaf34k0AaryqBBcoSuMkH3JciM35iJgO6Qd31fWuL
 ZzD4bdfpFm1Ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD5CD6E54;
 Sat, 30 May 2026 01:13:53 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sat, 30 May 2026 03:13:53 +0200
Subject: [PATCH v8 5/5] MAINTAINERS: serdev: Add self for serdev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-rust_serdev-v8-5-2a95f1da22a7@posteo.de>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
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
 bh=P+qqzzRwhI8B2ZhOfr+PVqRWtfVtS9KesBahL8YX4uk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqGjnPhljelHIuzdbOLC3zhJwHUwihLpJ+X/2k8
 18CITrGo5+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaho5zxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JNdQ/+IR2iPGEy8sqtRVurCujsY1VhZ/t7tm+
 6bWZdXnedNebKNUT6bpdRAAxnB0/Kf7Iu/bWpGDcSZ/esml58O+dBLKANgmpDEn3Hb/kFG/8LmB
 cmAGhf2LSuYuN3IpSJax6GiRzWxb5NaDMhUHM81xmnNSWYnBnQ26L+kUw8x0A4rIkfF5SSu5FAG
 xfnu+x6oVlgHGj4SBPi9IrW5awYtoRMgLuGd97RaA9PSYUS54Zmih3fKnbnoqwUAolRi2iOM7SP
 6lNBjb7sEhpDMsG7SiwfYC4RKp4bjI77UtZA7cFsNDNoV2FJvZAQePzkthoFFbd1i+kFgDiHdg4
 G24/p9FN9pUJ2PbuwfSXpJIZmkPi3W8Hw0hqgh6J64Jd0AtU9gU6x6FX+DBPgdjrax3/YV8PW7F
 UNrktM48Or5Vao7WkN39D2fD7+38l5CS/eWj5kJzeQQP/hn3E/TKPv+7FSSpFUX+8UMjJSpByik
 xqok0SyWTgVdW0JlXHGxsG5d10++pOpV+qXV+qbGjpeFs2aZ9KLLM0BhN1AZv5uMYA6qTU4BCad
 3qCvEJMtgW1uR+gpWCO/uxlJdVexI7D79yFEu6Rj5eLADedrgkRuna6hkubYrkC7fYkqK3+kpZl
 I4h7OJ7fIeJGnn/h65/wr4XgfwNeMWAikFFjuM89/Lbmb0aBvlo0=
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
index fa3f20f0cc4f..58db6aedf45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24270,7 +24270,7 @@ F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
 SERIAL DEVICE BUS
-M:	Rob Herring <robh@kernel.org>
+M:	Markus Probst <markus.probst@posteo.de>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml

-- 
2.53.0


