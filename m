Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01F5FB44C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7149F10F38D;
	Fri, 24 Apr 2026 07:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SaGIxm5X";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8007710E118
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:48:41 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so58896415ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777009721; x=1777614521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uUmefGJqV+IRkFPz6sSuv3GYeINth0c7dueYg2gp07o=;
 b=SaGIxm5XB3cmGycQS9d5PzLnYHXLEtHIQXLppzHq8wWZAUguSjf0Nw83Bf8dIqvqoi
 wMCF7tDkbrghAj1sV88V8XqzSeGpyewvsKSYcbAS1LXCZcNAbCBuPCaqFz1h9WA66CGK
 b4ht8DXE/kMB9Quh/6kzP9ZTJtslzSG2aCRI89BTBKC+Nb3yLuv/FGa4+6ZFGrlcR/Z1
 50F63MCK115gVIAIHx/sAQwciRW8ybEWB03A/L86rmOveXqTnF1IChlmPxowdk3r1MIw
 G/smjbVOk6sdzDwC2p/52Cdv9AOZ7Li5Fvbu+v2Fw0P8OfXiFxJfBUuRK00HYgK5qzZa
 f9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777009721; x=1777614521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uUmefGJqV+IRkFPz6sSuv3GYeINth0c7dueYg2gp07o=;
 b=iBULg9FSp1rSZdQJvrvZ7EFEXiy/5j35VGcLS4aviqRgpJy4AuJfxzlcPzGzJA3gHa
 pbI738l3C1ZWcoo3EWmPf2dhB5vZgzJpgaUnFraSD9eGyEEqkakMR8A6BTQJXC9Kw2CI
 fO7+Uq75STNefLMZLHcDxRtx8DJ1qaimYyELeT2ggcFVK6fNOejZx46DDvPMV5CcbG/L
 2x0eA6q0aLlFKCa1AF4RVkR8al4NwtbGD9dC7XNO+eCjllUh+D0XueknIhy2F5FaBZYz
 z43nLI0beRiLq3bolf4SBTwTRRrHDCWyK9cjGgQMuO2Euf6+grPaald8OmsPAHbLGdmW
 o7Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8igUcE/qrmRfhkwobYl8MPJu1aeJrwijQgvphugR76MRY1/mHmPjUFvL+PZN7sGa9n/Xn1ggZIC7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC4BpvxOt4hm22PG32tyUIVVVzn/2359+yPZDQAMUlInpJzghr
 cj8fJTeYL5hlONbEzI6DZ+dbxY+gE7CVQJfPaY3fm3FrlpxJL+1WKp/U
X-Gm-Gg: AeBDietX0kstjq86SWSvCpac+52gZmtEws+nslQoXMYBz6u9NwwG3vw+0m17QPsDNCF
 W3BhvuUedn65QEHi2yodMZpQJmotRtP0Jnhe3pBaSoUs0zAzVmiSixoweEiqBMVuhvq3c9H1P9o
 gRo7xDpYTeZZQSDr6f91r60NVuzfP1K7sfExjUflXn4bDYQRFY6BizPBlNkEndzNSqqMjgGZIOD
 Yd722Va39v2LDodNhGtgANezYl3SVpaVZtnILz61jMrvWUudOwqDtsuCS/mSaEI5mRBnIVnT+IP
 xunNDXYKbW1003DHoB60oBy8PQP+3xiu0KNdiBhCgOPVmjdi22XQaCATavnDaILUkUN12rS0ysU
 nW5BDbd6wov2spaPoftBPKg8v01YEdCTRZvitImGhMtVFpjiRykiT0cbrBHcPTqwK4L/W5OfpJr
 4mQW4yrCIijN5sc//MbyKWmrb6l7x56Fk2ftjreXZQhBEX7lhWfQVNSIchIfSBFRaTxMY2iTKRR
 pvu5kC/UdqTbmU=
X-Received: by 2002:a17:902:b195:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2b5f9eb272fmr183181305ad.20.1777009720961; 
 Thu, 23 Apr 2026 22:48:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com
 ([129.41.58.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:48:40 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, mkchauras@gmail.com,
 simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH V13 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Fri, 24 Apr 2026 11:17:39 +0530
Message-ID: <20260424054742.45832-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 07:44:43 +0000
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

Minimum `rustc` version required for powerpc is 1.95 as some critical
features required for compiling rust code for kernel is not there.

For e.g. Stable inline asm support which got merged in 1.95.

Link: https://github.com/rust-lang/rust/pull/147996
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 scripts/min-tool-version.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b96ec2d379b6..406895621511 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$ARCH" = powerpc ]; then
+		echo 1.95.0
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.53.0

