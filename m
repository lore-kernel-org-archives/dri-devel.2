Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57903CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F98710F48A;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="FxXHvB52";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089BF10E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:30 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-13810b63a1aso487127c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414389; x=1783019189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Bh++27PWYhH7a1Hqb3PFYlIq7kRvjS/VwtSAfZ+kU=;
 b=FxXHvB52Q1TosyraPYfZvpkVHPjoTw28g7vC4gwfIxfhyJYmu7ey4tudHkxOWTbnuy
 QCqtE9uSpYsifwfzrJvRgkDCP7mZjldK0p7hwy7Rb5ArEej+3Z4mFtKkLsmX5MAoZiSK
 KG01cJpqkKxIET/swo72mWk6/Ll7p++ukxzCIirFZH7sgNvMFGAVIEEIexZFYIRSprkW
 AJ9zedKtO8ql6+Nr8gI4LdQV5EFezqLV8KA7eW0EiT4cez58b6l5hYojKcAN9Drr+Hwn
 ndHI76KwyUI9V8YSH5PV87pnNFp79VGpqz9idBa8UtIU4KkVReqxYlLrC+VjzCbR1VdD
 V8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414389; x=1783019189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90Bh++27PWYhH7a1Hqb3PFYlIq7kRvjS/VwtSAfZ+kU=;
 b=EHbGGUhvzg3wUJtgJkYZYsgV+61g90fpD7amauktrdSpt0DadZbyLDi8dlyowf2Huc
 75qRrma7eWrathNlrfXMRbsQwJCHf9/APYk8mzUXVbse1XnLdT4Ct27IVLtNuXV5+L1K
 B+LxVLuKnyLDOQo2XHsGe+gZaxG0H45BF8W8RrtUa7xiXaLAzKmWFJZuEJ3AyS7fszbl
 lpRqL2Zp8iAkmWS4e1l1HdkmhhtA6OsXEkRROYqAaI4ruPZ2scBPhjsLV8wpcEO4F8tK
 OJYDwdBvUSzz1twgYFluQRtxRgxJSeRT69mdFJoqO2X/VGwgkOGkaa0Hw8oPa1DY5zp+
 NLVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LE1jEmJo1CzswfFkBvjM73Njh4Rc8OJPZ8rzPEjysOVBYcAgm8coCdKwmm7MUiNyLRNF2yoJXe1Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG+iUHxirt5Crp9p0QjiiGAtRylFK/qKi71E3LVoRmAI6ctOq8
 RmmHBdjGX1fG9ZjciTG32dSMO3e6pOrGToNgMNHD0DPNxls1c/XKE7eAUG32PiNS8tU=
X-Gm-Gg: AfdE7cneWEpVkm0vH9SDfqCVVF5NUD3yCeDDpW/YiV62xfPScMAFnP0TUvava93FQIC
 gBZg7dRLaOkLNNwrc5nyd7QNv1sogZK32gtMFatQh5/8yc9xkpJv97NVcGrOwNZWm++mLOUfH6v
 7aKc9AQvsZqTva6M7Zl3BduoQXRenjdDB6zud8JSTnrqx1PkCYIdaKCtFCxSoyetVjkpxoik1CG
 KCKTol8snnaHvozLhZg5vRRgyFc1mvf+UBpVZcO1oDH4KHfCniu+KMpWODuv51MJg+sgmWM2qxj
 fQvnKOce/VfCb1hcG/Jcg4Fo6t+g4jjxxtFrWIPbRephwyMfdseZAkIsddHiDr8vO2Os2ma0B1b
 EJieAUFRassEWSiqNAUdll/gjY02GbgASqpgofYlQN4/0GDtn0uCHZn+92VGE/LN+MqFYGrYf96
 vq/yw0+FEejYdcl9U=
X-Received: by 2002:a05:7022:207:b0:137:9ab:2cb8 with SMTP id
 a92af1059eb24-139dbb3ecbbmr3240694c88.21.1782414389053; 
 Thu, 25 Jun 2026 12:06:29 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:28 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 7/7] drm/nova: remove unused trait in commands.rs
Date: Thu, 25 Jun 2026 16:05:53 -0300
Message-Id: <20260625190553.7245-8-niyudi.honda@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625190553.7245-1-niyudi.honda@usp.br>
References: <20260625190553.7245-1-niyudi.honda@usp.br>
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

