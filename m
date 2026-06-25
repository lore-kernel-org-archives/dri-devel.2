Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486BCCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023010F4AB;
	Fri, 26 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="XyF7Do8M";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B618010F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:52 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30b6dad2382so697711eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420772; x=1783025572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Bh++27PWYhH7a1Hqb3PFYlIq7kRvjS/VwtSAfZ+kU=;
 b=XyF7Do8MW4PoiO7VgCBJGP0rYMJSR6hpUKWwh0G2tQrfFtJNZMXLFaSB30R2aciP8m
 zETs4NKuT/cIHwk8ZIqRo/A4dBEXhA73swNipDMIN6JpuiXvBl+z3nH/OT1m+B6lmY+D
 2m7raRCb5J7eE6W8ecBAwZlRsdPV7RmilDt3PFi8jeP9KzshyVO2+4XXoj2Ni2Zomj6M
 fUBXo9V0pjWEENimMtC8D2yn0qkWs5s2V0r9InV6KUvMtFAiXBEnWddXLu7q3LQi6IuT
 MXWmW6XHakVXfxeZ6riwnMAsN2IHGNzr7ReLTF9S3aQV36RaEPOxGcwX3IRLD9rSZTiN
 ZMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420772; x=1783025572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90Bh++27PWYhH7a1Hqb3PFYlIq7kRvjS/VwtSAfZ+kU=;
 b=hlBxwN2sZACOvV9v2t+Pt/RwEi7z1vNyiWTlzBm+q5z8yuZ2eqoTVDtFPs6iZ5Q8MX
 0ADM6J8l/gh76oWaS+fa2mLHiqRzj44K6Di8FkPkuBjfwlAyGx39fBm7qKZD839lz5m6
 /Xk0HNj7zhQoTi7KxWPiPLpgQ5KjTRzcI1b0MRgVNWTQppADBqQf1UVkKXnGR2+05tPI
 xvAKk/iV1YyA5tVjDLmIayESK8XkNbYTICOJLJHRWse8OlJ6WO1TXu1O44CewER1zEZt
 bp5d+LQfsF5lu1xB+6gltPr9yDie1Wby1OG+BjJF+hiUWfzvnrAeMVfE50qJqHJoMumn
 P55Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwjJJEx5P9CjjEuXmECavhRama++99MUBQ3biKeFOL9dzpGTW2KqysSe6rNll929gzk7XJy+yAMAQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE5vq5hftWYVgPO8Kou3YZzzxu7/V68g3LWH/EeP2JyUIgnEjg
 QMqFQojl8xcfz4ZC2hFumRE1a1ZbI5nkRjtN008CynePYxOqMhn5BdllmqFkNr+bqi0=
X-Gm-Gg: AfdE7ckAMc1uWE/3NSx2upr+b6lriaLu5bfQxJeC+vxU1oayyJIf4cXC4LQC2LLp64Z
 avuKw/Bbykr2i3VTwgbOB7amQajCEFmu0KXtZc/NWFBcQt3gMzfCtdmfrKTVy1xEtU220NB3MRV
 yErxL7zBrQFniNQPLV91w6qpQ3nOm3MlYgA+Yq9Tjcx3h1bzH1GoexFV4BA1CXOItWiISRWeKCA
 zXwgXH19u5CcgqY+52J7r8FJ74Xej/LCx71PAmo6SNd4yYEU3F3N5dxSafLBv4djGjjuTCUXdDp
 u4ZWQ7NIJIxNL2b9GETB6qIYhYq3/bnly7XYTPkmYOJKP35Kjl7ub7eyAWp/E4DTmwKBZlp9roF
 5vzSuANN0W/Ol97sKTDqz6ohONuLTy1m5NS3wUcN/gKly/9aLObvRqPbzXeR1Ln8fC21Lpzrb0o
 eDZH46R0vvDEB2tYrd/cB/onLIaA==
X-Received: by 2002:a05:7301:9c95:b0:304:e587:5063 with SMTP id
 5a478bee46e88-30c84b6f548mr4769384eec.12.1782420771923; 
 Thu, 25 Jun 2026 13:52:51 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:51 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 7/7] drm/nova: remove unused trait in commands.rs
Date: Thu, 25 Jun 2026 17:51:46 -0300
Message-Id: <20260625205146.5047-8-niyudi.honda@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625205146.5047-1-niyudi.honda@usp.br>
References: <20260625205146.5047-1-niyudi.honda@usp.br>
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

In gsp/commands.rs, remove unused `transmute::FromBytes` implementation.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/gsp/commands.rs | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f84de9f4f045..a3c0b7fa3b9e 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -12,10 +12,7 @@
     device,
     pci,
     prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    transmute::AsBytes//
 };
 
 use crate::{
@@ -149,10 +146,6 @@ fn init_variable_payload(
 /// Message type for GSP initialization done notification.
 struct GspInitDone;
 
-// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
-// trivially has no uninitialized bytes.
-unsafe impl FromBytes for GspInitDone {}
-
 impl MessageFromGsp for GspInitDone {
     const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
     type InitError = Infallible;
-- 
2.34.1

