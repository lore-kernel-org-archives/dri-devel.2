Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D12CDE013
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B575410F47B;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="QcbBP+va";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F103A10F38C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:20 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30c965eab27so863150eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420740; x=1783025540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OruPioe6tbdNpycRDGam1892gPF8sbvYnG0WqG8AtiQ=;
 b=QcbBP+vaBKuwnJOAODApAFlIqyJ43tjPOiqnjIkOtibmOtharHOmB9dh5UBWcJVuBW
 4iErbnIazursIhs4KORKo/yc5L85itJbUedT0jQ0VwfOskX6AHYDuCsrkQxQqXBsJsld
 zjW62VrY9gTvSmnl+ygMh5+/u+jSkFxJNO6WZU70BeNvkBt8f8DQHtA3W7Vh84mWoIeD
 AdDKfAC5bN0om7u2gNNiFMrvSpqG1BpF2wEWQH183FgJh2bO2vhGXb6/fdzwww0OtLOp
 AllzhSrXSV2UPkc1JdJAJ/a7WfXg0psX4r9Peh3Y3rttmISzqu8OMXVCLnFgZeFr46QZ
 7oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420740; x=1783025540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OruPioe6tbdNpycRDGam1892gPF8sbvYnG0WqG8AtiQ=;
 b=YfTPPDNT/MeLCIHYEogFzWrwUKok4ivpXlVGKyjG4HhW2HBN3J8nWLUfbaqksJE/c6
 vcVNCjjNwim/DCCOwut2ouwXAyXhHrBJa27FFBk3g67O0yZn/Jfsx8DZNbSVl6zViOhW
 wLgHq06Ce09rQ3fhK2vJYsnazk5dFHVEgnBceQewPtKQQqRTI+v4ZKng76H1bKAjXIt1
 cJLr9B0cw2PXqWvjeB6R+rqO71E8QVkRJUklbeXb9LCsPdwVof783BYtMNNDn06xXUDZ
 R/Habw5a6o0KzTjWYNWWhDhyRHYLpA4J8vPiX72suOKHMIza/xVIVojZeEEbd2daQWcK
 qyBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIR8GfGjvEU/3nuI0ppizm86Es0qA1R1BoBY+XQ6lYvnkULVGDCJ4OtDMj0K3SbFsqHh1o9MSbNKc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw86koGXN3xeO7sLv7GQ3GVCAQFwRaXRpLxBOyU/J+M4t7NfhhB
 u8j70njKIsCnyY7juF+aOrgZwbnkDxpI8RtS0Th1eo4KYufIjsege5xJ4CrGpfHWr2c=
X-Gm-Gg: AfdE7cmrwS84lcuxKztramaDjOBi3xihur+1L6RYMrb5IMcD+kFyX8hkQgSCpfg8lY9
 8IqUIBLNh9w4Q/0yy54mN41/HZhhGXHtjULdt5e3jNMjXVeImiSgOhbRq6zKGTN0HWyJD0e2r3Q
 QLCZX/mZXSwyGjHifPwE5r0pGF3gcWUHq0yeQ2XpeDwhFjGFKRGJByFoSU6BjHYnaDXBN+3Isb6
 l0LM4hwl1uIlfKWCEmlGa2Ki+3SjEUSCXhubhjEUGyR6l5nwqtUMTcLvAcSG1hZI7wjZjpJLbMB
 VFFrN+NVlPmxEpDT6F38GIgx2OPDRPN3Le2KD8fplFoYHWFp6aORVszSv7H4TRxYlYE2h6PH6ym
 Z9jYhSBhxM+ZKrkM+aORGVLQeTGEWPGz6xEiWY5HMjB9NIYHCm90Cy4nXr2wIVYRHOJI1OQX1ml
 qoScVjr+n2uXGdSQaYibW5GqSXqQ==
X-Received: by 2002:a05:7300:cb83:b0:30c:d60:a879 with SMTP id
 5a478bee46e88-30c84eea4a0mr4233861eec.35.1782420740087; 
 Thu, 25 Jun 2026 13:52:20 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:19 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [RESEND PATCH 0/7] drm/nova: replace `transmute` with `zerocopy`
Date: Thu, 25 Jun 2026 17:51:39 -0300
Message-Id: <20260625205146.5047-1-niyudi.honda@usp.br>
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

Resent due to incorrect maintainer email address in previous submission.

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

