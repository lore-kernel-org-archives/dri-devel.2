Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDD9CD98F6
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CFF10EFFF;
	Wed, 17 Jun 2026 15:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="swizW9oy";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4A710EFFF
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:02:42 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so40677365e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708561; x=1782313361;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3aI77IsFSOhcLG8puWNqVG+Et3rUWgqrQkokd+XyWI=;
 b=swizW9oy6JFDHNkd+cofvwlcHSp2FRF8b1jXOroez/mH3vm+qKCaNg6zTjMaRtirv0
 BOFOYO4QR+fbJv+JAf0lgJSTl15MGuIrOVe7FU3p4cHpIJUlITu4x/8SdkXpBAyuOBPR
 PW2wFKDeso5KRU2nkDo2CUS2lCqAo4WdHU0XV/dOnpAe41vHWgAnBYNZSnyeXfk6/v+Z
 uIBEJVARKjmGoqdOb5lPrQylRJiSye0QzBlR17N5jTLfLZupf10IFct8RIA0Inf56ocM
 V7TorVtpqT5KyODwHq0+c0MElxt8WDhzcPLB2Q9XbzbLOHCkshPcAp/6GjMkgIaKGsaF
 fGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708561; x=1782313361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+3aI77IsFSOhcLG8puWNqVG+Et3rUWgqrQkokd+XyWI=;
 b=ikF4OefPDutmMs0ex2NtLuEXmqX4u9BRs7ScwoXxTuvJXSqyAptij/uBcewuTUB80Z
 WDYsl+D1Z/otVDY6heryOGvZxnmpY2C/E8EI7BeZ/EwkXlAAz/oNV9u1LAtlbgaRputv
 BWdzywAhdyvw10YwDKS2jX2GPAOj0ccwxOFQ8bdZb5/u3buyP4v8undz16bzCGLG6zVr
 QBrIo8LQtyLZxjY4abVHNrYfn9uaQhSYZKNMAjrEUsUEfdgudm4Fx+R9ePptXAe/ysZY
 wnebpO8iWGY/crtqY7nJyFYtze+vaZE/MKGsKcbxfa7PLhf2mOxBgVINW9t7LC7+47cs
 9JAQ==
X-Gm-Message-State: AOJu0YwdNYEpgh3wCTCnlaBnwvzoVvgMs7OzWl7t4JkOwzC44qEQa2lZ
 m6KLmPpn44CJEW3XeD7VOSZKHIfv63rbxjo957FqkrKkpChS6TfkjO0EtGWe9xVT1VOE+gMVlBl
 xRSul858M
X-Gm-Gg: Acq92OE/OVC4BAti70T4VoSZZeWVucbgXqUdigUQ3msbfq51rHguiBrE1j1Fn3D6iFP
 wNMn8eNog1Zb+89r9S+DhSgx0wt/dVBPSdF57CZxxBhXXCl7qURvxGGReGwSfAfuv0evHeP182Y
 2pS2y0xxouUo6vbYtk1kztJlAB6+453J5h+arJs1W65DrbU+ILrPlEdYknHKlierao3Mf6jjCT8
 2jDzP4leC2oi3b58R+39N6rAZXCSam2iL1vjKeBIQVb+OtromD5q58B6F8EbTJb3eno4pR4yNMh
 Qde70dIVD+tbRabeQhRcUAWs3AxWbc4M+yQo+PTqMCvWOTAWLYjORHuDrUAxP/OqYKpzz3fur9b
 xHWIIFVOHoz1IArP6knCP3DC3vkmfKyXFRbr5S4vrHFl0IrmLzfvx7Q5q5p6lBIvQeZH3pWEWsj
 Xyn5ID6jRCBGF1RJW1LX/8+tyAE9WaKN5nYxwiqjgvMcVoc70JctLGczhd
X-Received: by 2002:a05:600c:55d7:b0:490:d079:2919 with SMTP id
 5b1f17b1804b1-49234108832mr46116185e9.14.1781708561083; 
 Wed, 17 Jun 2026 08:02:41 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57264311f8f.11.2026.06.17.08.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:40 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] rust: drm: expose drm_edid.h for reading connector
 EDID
Date: Wed, 17 Jun 2026 16:02:24 +0100
Message-ID: <20260617150232.2210-3-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
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

Pull <drm/drm_edid.h> into bindings_helper.h so bindgen emits
drm_edid_alloc(), drm_edid_free(), drm_edid_connector_update(),
drm_edid_connector_add_modes() and drm_add_modes_noedid().

This lets a Rust driver read the real downstream EDID over its own
transport and install it through the DRM core (parse / validate / derive
the mode list) instead of synthesising a fixed mode — the same flow
gud and udl use. Raw bindings only; no abstraction.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 877f82b927a0..8d45195df6e6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_atomic_helper.h>
-- 
2.54.0

