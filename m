Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E95CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D0110F495;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RF5CCTup";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02C110E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:04 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-139a71baa35so657433c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414364; x=1783019164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nwvsRk5K8KQIV+dAnZZRDBwFar88HbSp2Pk4XHAfdBs=;
 b=RF5CCTup4kA0ylRVpbEHlZwuhvYrpvJeAlNBMASdnd7Rwu5YJhU9TpdwvFf8Ho9o1q
 KnssCH+XTYs25OuOSVjWQqaGCgrh4e2m/R2DdNAOjisX9pb3DsmAWKlC+BGA9JVdxYwF
 R9swGmDtDJWfC5mCojiNSW18XqAr5Y27bebDhCtbOc88v3RKP9hemq0z1Lq43TN4Zt4L
 mpNyc4eU5PJ5NlaV1q5vKj2ClnNplDtnoS51wyG+1e209myIQO67ESdYLC8ZtGn4vSId
 vWnzj77BC68xPcM8srKlJXvYH4plVZc7xegT4GtEFYfqQBPegQP5HdBkUqvGAXn/PIna
 PlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414364; x=1783019164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwvsRk5K8KQIV+dAnZZRDBwFar88HbSp2Pk4XHAfdBs=;
 b=Jek5m5BWntCmCw1XBT7qWYUzJJJIo9nGiAbpz7cG6ibf+e/I7ptSD922iDkYM156Sm
 OTl+sUetlB8Obxtq8Fbm0VrVYxRYiK1tf6hlNquNS4PmhYPt9pSK5bEv6bvJ9Av7iicv
 L42qHjxyb5qzsQAqtvQlei38IolUWResX3HrspcExyISpnjoD7h77yrDr0f+QRsLAfta
 5+cV3PhIaiQO51WRrZfg3RIvKx/DAq+rsq4mpV1t/U2zNsO+FspmUv6UODCua7UpqTYf
 EaX+armgGlcjA1f0MfcLo99ocuWfzKFICkh169goKoMldmtOWw9uIbqvyOCT/ygwd4X2
 Traw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jzIc+MDp+FHBzKuhkX0q2Cwg46zTiomJ6e5gB56D6+sg7M7t/8aMDxrUcCFBxQT9airulz4TwpJE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywka4m6G/ngIYh0Q/2GvXkRHt6XLPhq5HUI8ZdR2M3PFs0bYBAn
 g1VdzZl8VnaLGQefhP0hgYACg6dB0hJAhm17oIYu+ghsf/Q7ArT0599rTjIZENbWg1X0Ztc8ZYt
 S7r0/E5ScUw==
X-Gm-Gg: AfdE7clU1rx2rFGTgjMfohYcXVXb9plR3s4s2CgOcmqB+he+Z9QANHQTBLWdEyOjacQ
 aKzmbFQ5+X5lGC2QX8xF05jfKrEu+ABF/i8SIgP6CrnfgZYKjb1nPhb0y3qfTk6SZAsS98pN/8g
 t+nmaUMwatuUSwm8V2xTOSSGk+lv8JO797CuG8gdW8u71HiZ2Tjc2XQw/+dVeJXgwhelUkAQ3zb
 ztj2vSwUv7UtWTFnyEA/7it13AjU/FoTbiUDzlI5IKuow8zufY+BseUT6xTxsQIt4zrRRH50Upg
 3CMZwc00nr1EBx0gV3QBYSnHsh/WugJZMaIWCBEDo7+pOvlrDHTERd8jVFs8+ng8k7CAFmSxJEl
 sHWjru0xpJYQWyhv3wntaUsqMPrZ64eJOBpPnnWEwyuZwT0O3OrZmRfyE6U7JtsCX4cQVJ+Wxj8
 nmhdRiu0SiwhSPmJ7IBD9PzhQzwQ==
X-Received: by 2002:a05:7022:459a:b0:137:6bdb:5842 with SMTP id
 a92af1059eb24-139db93fademr3208663c88.0.1782414363978; 
 Thu, 25 Jun 2026 12:06:03 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:03 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 0/7] drm/nova: replace `transmute` with `zerocopy`
Date: Thu, 25 Jun 2026 16:05:46 -0300
Message-Id: <20260625190553.7245-1-niyudi.honda@usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

From: Pedro Yudi Honda <niyudi.honda@usp.br>

This series follows the introduction of `zerocopy` to rust-next and
replaces `transmute` traits with `zerocopy` traits. These changes are
mechanical and don't alter functionality.

Specifically, the trait `transmute::FromBytes` is replaced by
`zerocopy::FromBytes` and the trait `transmute::AsBytes` is replaced
by `zerocopy::IntoBytes`. Additional traits such as
`zerocopy::Immutable` and `zerocopy::KnownLayout` are implemented as
necessary.

This does not replace the trait implemented in newtypes over
bindings. Currently, the only solution I can think of is mirroring
the bindings into another type and transmuting when necessary, but
that does not seem practical. Another issue is a type like
`gsp::cmdq::GspMem` that explicitly does not meet the requirements
for `FromBytes`, but unsafely implements the trait anyway because it
knows all of its uses. Unsafely implementing `zerocopy::FromBytes` is
not allowed, and implementing `zerocopy::TryFromBytes` would add
unnecessary overhead.

Feedback from the maintainers on the direction in these cases would
be appreciated.

Pedro Yudi Honda (7):
  drm/nova: use `zerocopy` in firmware.rs
  drm/nova: use `zerocopy` in vbios.rs
  drm/nova: use `zerocopy` in booter.rs
  drm/nova: use `zerocopy` in fwsec.rs
  drm/nova: use `zerocopy` in bootloader.rs
  drm/nova: use `zerocopy` in riscv.rs
  drm/nova: remove unused trait in commands.rs

 drivers/gpu/nova-core/firmware.rs             | 16 ++---
 drivers/gpu/nova-core/firmware/booter.rs      | 26 +++-----
 drivers/gpu/nova-core/firmware/fwsec.rs       | 47 ++++-----------
 .../nova-core/firmware/fwsec/bootloader.rs    | 16 ++---
 drivers/gpu/nova-core/firmware/riscv.rs       | 10 +---
 drivers/gpu/nova-core/gsp/commands.rs         |  9 +--
 drivers/gpu/nova-core/vbios.rs                | 60 ++++++-------------
 7 files changed, 49 insertions(+), 135 deletions(-)

-- 
2.34.1

