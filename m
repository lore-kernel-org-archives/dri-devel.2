Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D27C43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBC910F5FB;
	Fri,  3 Jul 2026 03:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="MVFv2FoK";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF92710F5FC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:45 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-475881b9a4bso79014f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047704; x=1783652504;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CRHhS8HiexEZn0tYM2xQs+F4mqPS5akyoK5HQQpQ99s=;
 b=MVFv2FoKiyyvlb63IhO93aXT+tGffk1EX0K+2h5tmkfFIoHMOCrVznOZH8a7F1PWMk
 EpmBFLWPNdD1sPKcENSeuY1TCCWR9dBc/lENltuUWGouF5gNTMrXm5RjH6eiRtJGt/Du
 QdDV3DBAg+jaNpbCMWQSIvttgkcKpdR9YAW7knAm5X/6UiPdiGfNPVUjPkc/jvEOmjhw
 sYrpMcMUXzmQyCzDNw+fl9f2Q/UV3foTjze6iSJetY3BXbi6AD0rCvYCQiM9kXEEOWXY
 3tWdsMFSlsGgdiFrok6LuVCjjiz2V2CBTlUvz1Z6WQv5QSPON3/pdcAxVZXUnQ4Yh7ZK
 iHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047704; x=1783652504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CRHhS8HiexEZn0tYM2xQs+F4mqPS5akyoK5HQQpQ99s=;
 b=lypcwjZEVxjQ/jA22dSwJDjzOeqhu30tCvMLjSxUVg0yVQYfWbka0EWrA7ZknRQUwJ
 H+qSKIWGNQSCYY3QD+vAK60SnpkxnfShWato2xt6VGT68eSAzJDOeREaxacRZWnIof2B
 TCNxaDYjkK3G5YUCkq3B0hOSm+GqUYQ199kKquzgF3EqpVIzKjvtfXk23D7jgtue4ixt
 IDKKnjYanaMdrsPewGFzS25wn5/2Fs7rbSFWGf28kJF8C2sSUqoNwO9DRzCW/CBv1ITa
 3E0DdOMIpuVK1LbYgAwfjCWQgGCmxd7PwjNgTnrW4KBjgv7v4u8IC881DOqBiAFWTmJ6
 2akQ==
X-Gm-Message-State: AOJu0YzsRTcYYJHrcfiq3aztCypbPoFWIJKVU9GkH+F7/Sll3Fb7GPVD
 nchaSRrnLQdraT1YxetHVZb7eRNZwtM3JXg6XYlYPhle+CEROaggiHgZY5z5vh4rdA==
X-Gm-Gg: AfdE7ck2xbyfOzt0jbZ9gEQM6NZN2MVOiZabjQl0tx94NB/5jL9OwNkLSi+Uu0TsBsU
 5jTXi71BfUvqUdvMVfLn5YEU7QZymQAHOYJGE4YCJ6JKqU7jUXlaHgTfGPYrdfb0Ldzu8u8P+B0
 l8YCZGeq7+a8WGDSpLew+fVtzkqXpWnbKnimUN8GZEaXxRqkbBj4JSGfe+GEWyij9YP7GMTnCXE
 LsCHSnLDEmvO762ZFhOsWe4lziAHpepDsmApYCKgkWnY+H5W78DHiVihhabQN4822MrQtlg88Lp
 6Rm8R4M1f7kAuxbFEC9olhUzeB1pEEFCCNwzc6LYw3zcHpnt2JTMrrTk+9JHOTGr/7qlRcTqhYn
 YGtY74ItPXdxphSemE5OCflY74T2QRnXBlxIaCCbpgfUH/+YCq8SOddWYKotgRlNTFRnDjFsz0Z
 zvZAbDDKCnkAOR219Bmy3sAsWojX08ms011jB85b1xUhHvfGueTXOtLfea
X-Received: by 2002:a5d:5f56:0:b0:470:390c:1e73 with SMTP id
 ffacd0b85a97d-477b39839cbmr12242543f8f.18.1783047704135; 
 Thu, 02 Jul 2026 20:01:44 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:41 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/18] rust: drm: expose <drm/display/drm_hdcp.h> HDCP
 2.2 message definitions
Date: Fri,  3 Jul 2026 04:00:52 +0100
Message-ID: <20260703030123.2814-6-mike@fireburn.co.uk>
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

Add <drm/display/drm_hdcp.h> to the bindings so Rust DRM drivers can use
the canonical HDCP 2.2 message IDs (HDCP_2_2_AKE_INIT ..
HDCP_2_2_REP_STREAM_READY), length constants and hdcp2_* message structs
instead of redefining them. The header only pulls in <linux/types.h>, so
it adds no new heavy dependencies.

The Vino DisplayLink DL3 driver uses these for its HDCP 2.2 AKE/LC/SKE
handshake (carried over a vendor USB transport rather than the DP/HDMI
HDCP transport, so only the message definitions are reused, not the
drm_hdcp_helper state machine).

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/bindings/bindings_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e41d2716fb2e..e5cfda610781 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -34,6 +34,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <drm/display/drm_hdcp.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
-- 
2.55.0

