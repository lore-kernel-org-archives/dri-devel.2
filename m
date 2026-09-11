Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E13C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C34610F672;
	Fri, 11 Sep 2026 15:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="KYNLcoI2";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F53D10F667
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:05:12 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-486f282cad5so365775f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789139111; x=1789743911; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=glNc1H2atyKhB4WSC099onb1QIuZPymRMjgiGWekzpE=;
 b=KYNLcoI2F/XfkIIkD3pEwNeHdMpDRESxYbOS4PKHPihoEEiZFaqxzXfp1Y13fiOiqB
 8xKuoEaCGLtC3PtFy4wXaLB/1gazsSw+6duh6a0wOOsgB9PL/jPQdtOvrRAY15DDecL2
 ZtvxL/14OjXonhFuEWOnFybLcQhLd4rbJv5RKzBzpXhFUZIOwbzPWnOdS1HPcO56WYEC
 /eBCoUcGDRL/sOBTka4MbI+gdQASsmg7c3gorizoFLpqJJ3IU5oeJRA8RrxX2u34bUiq
 Rmsg0JGhYIdbem8ultL+9l0cSh3/5/+FTqoMuM2mEni1o8JNUlX46wRuf12gxWbxP3bH
 mVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139111; x=1789743911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=glNc1H2atyKhB4WSC099onb1QIuZPymRMjgiGWekzpE=;
 b=fTooCQQASK77DQznVg5abqZmCAhqqBUtup0eTiFYNp1H7aL3ydHiKdalMHt/ZrY+lA
 QzNWvO80XQQCEwm8DBP13ybss+A9O4UUdaGvBtILtmi2aP4ae3oi79DCyu/p2FyRG91w
 kpqGPw47jeUrOfXmFiroGZiXaF1W+WlIJrqUS8aGIRGljg5Y/pwBQ0XT4Z6IY1mAex2D
 rblOD+T7kquLfLrvP58GgLjlvcmNgiFIGnE90K0/kqcQbkpufH9m/MGZxhYtDKtinp/u
 p15RZJLE2V5IAdAHK0MlbenfteceBwxeYm/qi0xU9g5D3v8jonuLSvR7b8RoPBcyBAhF
 HjFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGEsF2U9RoEtIEl9bnTzh7hXdHXC/qdRbcEZbGH/nqqK6Omv+mtowSg/7mj0cUK3Ac9XxvksKffoc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mSMx35OYwv3F9Wu3y0UyfrpXvkL1AyAegwsxnYKCNK4F5YH8RR
 0JaIxBItvSTchaFDWamj3JHWOkdxDUqe6ZyWeBRLEhwadwowWbr7OgmDsQ7TfnoroaQ=
X-Gm-Gg: AYBFou34Y+Pbc7hFTt4zjczt9HWrCrOLA6eXxtcMHPwqXBbe2hGaceaGfrO7nNFSw2z
 jRGhcimxpX2ChJVFN5JOCrLSjKKStoFE7S+CwtB88HFkiYuVBmOLrzOzcOFj1xl7cZ/dS7ONT2S
 nRCjG7pYqMmjl16Tqt4moZe6/YIIRv5yRzfMlIHGYoiPnB6Hz4DG9SQOiGUmiKg1jiYrBoGrpe5
 FxMHlMep0FExkLB0qMdcIHYP3vIx6+A8MFq3p2iPRYKoLSkFSiKWEMh2QgYb6cLhJ4YLnxFGVV5
 KELYCgfoRO5aGfIIOc67tvNsFALG1vEJ/tGv/Shz/AFBBtLptvrLRzmz7PvKWyxKpvucgW2q6g8
 u5DNdw2NLVeXanM8IYGz9DOfV00lXI1wQvO3e8SFMo8tJs6FvajgGX+QTii98Zj2NhAzkI7kfgY
 QmQ+awgX7lmtQkuyScQ1ICICkFtzH1F7pwKmBaX+KnVuDTTjblcPBAwp7YRz12U5iaQkWzPwqIH
 a6w/CO+l3Z4tLjw
X-Received: by 2002:a05:6000:1acf:b0:485:8a46:b3b8 with SMTP id
 ffacd0b85a97d-486eb32253bmr5503727f8f.32.1789139110499; 
 Fri, 11 Sep 2026 08:05:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm6853579f8f.27.2026.09.11.08.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:05:10 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Francois Dugast <francois.dugast@intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] net: Include error-injection.h for ALLOW_ERROR_INJECTION()
Date: Fri, 11 Sep 2026 17:04:02 +0200
Message-ID: <20260911-module-include-error_injection-v1-2-5da895d8c84d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

drivers/net/netdevsim/tc.c and net/core/skb_fault_injection.c use
ALLOW_ERROR_INJECTION(), which is defined in asm-generic/error-injection.h.
They currently rely on this header being included indirectly through
linux/module.h -> linux/error-injection.h.

Add the missing include in preparation for removing the
linux/error-injection.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/net/netdevsim/tc.c     | 1 +
 net/core/skb_fault_injection.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index a415e02a6df1..e2d7d3aba193 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/error-injection.h>
 #include <linux/netdevice.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
diff --git a/net/core/skb_fault_injection.c b/net/core/skb_fault_injection.c
index 4235db6bdfad..2c7f519bef80 100644
--- a/net/core/skb_fault_injection.c
+++ b/net/core/skb_fault_injection.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/debugfs.h>
+#include <linux/error-injection.h>
 #include <linux/fault-inject.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>

-- 
2.55.0
