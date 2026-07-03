Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E3C43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9609C10F5FE;
	Fri,  3 Jul 2026 03:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="jNF7mEG+";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B5C10F5FE
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:51 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4745492ed3aso49077f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047710; x=1783652510;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5X0KENn743fRuXDK4+pZpz5mtbV1fUQ2ZuaqUrbUZWQ=;
 b=jNF7mEG+ySuPnk1P9lVMZadLcylzo8hwASiGyr8auox4KDG3YMKFYQV+RwfAlZF5Cw
 Or2z/PCexDYjKZ3UJurJfF7MbNHqFkUK9CAIsMOosAEMB9bQNOVJAPMPrLt7ilS1zUqE
 NynIZe78+fPaSPXOXcP4180kC9cmrDM9Gj4/N6Co5mPZd9ocAktezc27CsEmtQtMsJnB
 8l9slWOVIKErSDIyigqRA4Va2PZu5W8vzHsyvRnKuAAZvTUOf4GWT/m+K1NlKbaUkY6+
 7oLDhGDGnL/Ect6IdGzZ6jMxI9uRT9EjgBSxNjLjPMhk2B8PHHiA07XM27qf6cdCUlYl
 Z8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047710; x=1783652510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5X0KENn743fRuXDK4+pZpz5mtbV1fUQ2ZuaqUrbUZWQ=;
 b=BSt9KVLAQ5FATvyI+J2ZfxUIGCZd2fFLk9+1fnhV1mgStvBCWhyaS2Bp15115UWLTs
 FHPxmOoUsczeKh5dfAC8/kdjxMq96AnnnRvjU4SlIJy78dJQWqFOh70tIQErfQ5dE9qU
 x1iEqcOarevBUXRav15NRRutxP7QVBpOes3k0qf8HcVpkbkPkXjtWEYrPLiMs4Grjacn
 WpmDUYZv2hdj4fDTO9qoI6GvEBgC2FO5SqLmMUvZnfLNQ/mk8yIQJJGRSCbi6dDy+517
 ZLYLEzbyLlLKFRuV3YI2GjYohYg4k3lQBsbJz9b+ivYmsnPlmh4R4nE7rD64+KxaDg4a
 xBtw==
X-Gm-Message-State: AOJu0YzsBVf2lPsXynzE4aFbIrv2r3OzswQuRom1jvBgyOa4QHaYGU9x
 ojHcHHldHo0BA+Yt3eoTASJrxh8knGl07CiO0fkkgqCxx36/+yCTrtBcooD/QqLTiQ==
X-Gm-Gg: AfdE7ck87WjwOuG53ypiBBkkCs/IWQDpTWYzx6ZeVM07UgZzgmrKyYbXLASPGULm+vu
 DALd4G36Xk+z0y002SlLv0LaRpjYooSskXiDPaDi9lfA4gx6j+XhasxTom5PAeDMFwVsd9mCeLO
 Pd4q/HDzD48Ie5yuPs/wtG7YpMmB/ujpCDcXxxOHj42uf69bgYGsSqpAez5pzn3w0cdYqB4AcpV
 K1Zf+w22gcprxl6amXWfIYxCGZqU+Hd6KxLFWGuBK4uAcNJkdheyWTo5pdH8mBrkw02542xt3vb
 HQIwbPhz6m9Z9+zSw0JNNuu9vUK3OEMKM3lGhGmW8DldAjqllN079SriQjs7Lr7aSVTsdBsxNXO
 CL93aDXeDZBa9WjSDfk0DJ2jPoT6755oP9xPYqVAJkO080/zvM1ou4xo2cWeT/sQ1ZDT6gb7L2x
 DyXOC25yUDXesHlijqZ8kGNdQBK8NCJsiaqyBYRbUi5fzMlcrTHNq7kSrk
X-Received: by 2002:a05:6000:4816:b0:473:f495:4a44 with SMTP id
 ffacd0b85a97d-47759754b7fmr12833251f8f.41.1783047709918; 
 Thu, 02 Jul 2026 20:01:49 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:49 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 08/18] rust: drm: tyr: add the Kms associated type
Date: Fri,  3 Jul 2026 04:00:55 +0100
Message-ID: <20260703030123.2814-9-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

drm::Driver::Kms became a required associated type when the safe KMS
mode-object layer landed; tyr doesn't do KMS, so PhantomData<Self> is
the correct value (same as nova's). Base drift: this tree's tyr driver
predates that requirement.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 drivers/gpu/drm/tyr/driver.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 360f57cb0bd7..a598c61162cf 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -186,6 +186,7 @@ impl drm::Driver for TyrDrmDriver {
     type File = TyrDrmFileData;
     type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
+    type Kms = core::marker::PhantomData<Self>;
 
     const INFO: drm::DriverInfo = INFO;
     const FEAT_RENDER: bool = true;
-- 
2.55.0

