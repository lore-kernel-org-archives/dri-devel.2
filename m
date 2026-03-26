Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE6910A88D9
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D0410EA86;
	Thu, 26 Mar 2026 15:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RJcMF+pR";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51ED910EA86
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:25:56 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-486fb29a8b8so8509155e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774538755; x=1775143555;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=om+QlX/arFDy0e2W8eDPmTq2CH+SEUH/vE4G0xRQ2Bc=;
 b=RJcMF+pRyYEQnHK6px/x2WnSAQhEElod3RFEc8g6NRks79RfKzcLuqPZ7duwgHZ8q6
 Qtc6DqlJ54btdDKvSChkakPecGEUAW30IhHDUH+6DugAF5j8Ld/9ROz0BOdPYwEHMq4V
 uHUKzqFRtEfQxWIT++UPgZLyWIb91l0ZjTvQjSRfo3lBpSBCJFGFwd//ySQaq47hpR8a
 DOBwsp9SI0+AZvTK5NhDCddoJuOfBx6vi3e/OalDHUv8BO5efU67jJeDtMuAMU0XXSEx
 Z544m1b93WpWVn02P/UCXUqx/PBLGNd/AcyteNwsdjH0z6YLMRGLkWSCYNhD79zJ2HEK
 9EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774538755; x=1775143555;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=om+QlX/arFDy0e2W8eDPmTq2CH+SEUH/vE4G0xRQ2Bc=;
 b=YVKeIcaxYkZpa3Kx1VLslXGtiZtQmEUNPfb1o5xgJBI0FnBOcKdVF7y20FEycL3oZ9
 hZOxEulWxVxdooP0SgKKNQUNZcBtQ625jufKq0JbKhcPqnerNFcF2qVhXoKWU4ols4hA
 jtkRXOkD2+plGX2hMnyjuxcUbf8V0OIpO9gBP9Y5LkkS7UflJ9MSO9byZgB2pZB3KWKz
 +B53bl+IdCAyYEioOIn2OtenZq265JH86VUymteqe1JnFvDW+8MQOLzlPlmrR1TQFHCZ
 5RMM88hWNLLj+b/82zxv271X59sDDA+4+HdhNtIcmMZwpuyv6azMeDHaFngExWTIw0mP
 p31g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnfLKZjtEZXhDx5lqJRWM5o//tdU01HgQiujPa7J61bmLB1/6kPNkQCOuyoNwalTtJIZs0AmZJeWI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxiwJMyT0/RZhqJQxgEIWIx2uRXFUupFOm++rdQnHgX7nZiv/T
 3BBQuHypFHGjpTfHwhsE1Tv+2wZizO5QRhFUgMoEMZLK3mqWRZ3zNz0gwlIKyGpKxLL6e1/ttiQ
 V47RYl+Uo5wb8e+H9XA==
X-Received: from wmlv9.prod.google.com ([2002:a05:600c:2149:b0:485:38ca:51c9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b88:b0:485:3ff1:d5c5 with SMTP id
 5b1f17b1804b1-48715fc321fmr120406325e9.7.1774538754679; 
 Thu, 26 Mar 2026 08:25:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:25:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO9PxWkC/x2M0QpAQBBFf0XzbGqtEL8iD8sO5sHSLNqSfzd5O
 XVO3ftAJGGK0GUPCN0ceQ8qRZ7BtLqwELJXB2tsbUpbo5cN5YonBkonzpzQCc1YtRU1o1eYCXR
 8aOT0H/fD+36UYnQ4aAAAAA==
X-Change-Id: 20260326-drm-rust-next-fix-aref-595e7bd5e70c
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=634; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RZsjeUqn25AVS1/YOuDCPaoEUOHvybw/va1386aHCnc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpxU/7DkSrgNEEzysIB26qjOah54fqgX0T1BPNJ
 IT2v1Q1JKWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCacVP+wAKCRAEWL7uWMY5
 Rkt/D/4on0M56vdD32mLqcWxL2DQL4BtYqtPqQGL7iWmhKvJZi2M8bsCdzb1lc/OZcdYeYNAEBy
 IWXZ7OgQDxIBRdEB2Zg/ihrAtrhb/U803bZMXF8QWusZyMJ1ELw0XI0m8olmsUSYJfvZwzcC8rr
 JczP8GTXxKdp2XgffX7mranpLJ1+sCBIvvQK1i/vwE+Xc2MzxTlUxKZr1ViJQYRMstdNM1o6XDe
 QbLcQEYCpMzAhKyAsbt9Xmw7cstJJjLBbEpazR6MyYrOiIZThtwY5lUv16fCwJvJCpql7ngVAjz
 oM1f0VrOFEbVPEhl1KIoZogd/F307eLEXBr491le3eFouS0U9Cii2uyQ0c/1ULtuK2/C19sd8ki
 bKaiLUt68B3RfGd/07/14Wv+kjIQl+BV83Hek6AgcGMRW5Qmir4wjubX4BZSSifKsBQwV5Qr5tK
 RMuExTq6Cts3+k4Hxags6GFuPwmGe4cGa84EnuyEwBm62AQeg7mrBqhJMpSMZHq/2FOU78539DA
 9xU+gAJInp492s5MaaCPBIkrVcgaHMr096usAzqh7xKB9ojyNTIrmu+1Z8yvxOsJIWQsFk5aXib
 ssKH9xFgOgMhMcOl7y/vlGfzfg2TbwZYmrpPsmn2TKztquQ+rePSzDLsDi5MuM5BDxDpfsvOEJB
 AiBNAiLISinrT8g==
X-Mailer: b4 0.14.3
Message-ID: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
Subject: [drm-rust-next PATCH 0/2] Fix sync::aref imports
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

A few imports of types::ARef were merged into drm-rust-next, but this
old path is being removed in rust-next this cycle. Thus update them.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: workqueue: use new sync::aref path for imports
      rust: drm: use new sync::aref path for imports

 rust/kernel/drm/gem/mod.rs | 2 +-
 rust/kernel/workqueue.rs   | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)
---
base-commit: 206bada308d0d715d62ac841784af34a2ca22ff6
change-id: 20260326-drm-rust-next-fix-aref-595e7bd5e70c

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

