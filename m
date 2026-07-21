Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57A8C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8109C10EA1F;
	Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="eG9ajiBV";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D42010E34D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:12:46 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so5952098f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784639565; x=1785244365; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
 b=eG9ajiBVw5+8ocHLt/dpFqv+SW7VAlNP55dTVZIsKurCDgRjX9Dv78HMaGpRp0HSwg
 ccTszVNjaYtt+btk1odldkKbg49/ldmfLGRZyMCqUk6/HWz2DvC0Kw7Gc/4YAE7waHjJ
 jfC4Yfmpjnt6VdYomlmSbY3k4WsEK73g7ZK/8zhDG++S1JWTYSpPLK1JbDKzITPne3b7
 gyaaIeSmEWseJeF2DjzMO9DoXA/0MsOUQQA+BwlflWovZLct7l13taQttyrQg+J/qPC5
 IqVh1FVgfY3qgN7s6kKzO7rCwvzzynFCe4o8dGj6gQzGZl5BMWvt522rNNunuZTLJwVd
 9Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784639565; x=1785244365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
 b=pjYFd+caehpf4Wtpfj3pqAXkTv+NQi4RCTcFedTy3RLiT7FmaFJDEnByI3Vp/EFca5
 Cht5vs0vhWhWmpFX6aXM8gLctv5gmVz5eysGlcAck+qwMi0OK3sOoCOo17u+HkmMW0dt
 JpIPaHjioLThyNlsikue95CTZrd+/OtBDfu2UGH9jLdwANTcj/M6DUxBNzcj32PJULNe
 pF0I41e3fODCNeI4CUEyD4yIOoeZBMGftJfb8vJKYp4XGJ07ns0dux0tC09TRe/ZsNiE
 jKckPk/oD9z6wqgWKEFgO6puBssxAQRGtp6Quh7+cDmh8d7EyJBQLcS7k87K7htpFuZD
 TBDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw1GtnTybMbYfKjsG5WNgO6D3lK7IPrkZ0fGQvPZPRXPGQSCxT8dqStPqdZtW/54SrsvpEthvmGP4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyF14QGSOSyobuTVb1oJCgLPRhx7DZpfUnVpjye9xMGIXEIwXsP
 5R6FH1e8EqoeP9LRr0FeSuQfj4YaCHkaD3mVmWsiKZW0O5Hq1uq+m3rRGwzzgDEDqzo=
X-Gm-Gg: AR+sD12P1kaFdc0yd+TOfUFbkksPzluyqp79pdCQQTR3KItGDPpoGn6rEtWtRe6mFiH
 2KKOx2/NEUh8Lb9MQz+2EK6x72XtJ/HfLPSS1wETgvhAROADUYL8fsBDiDePm0naMHJOxgIs6lU
 DYkMm88sB4UQOPdl8jpbT3nDEd/QiATC0dKGhc7h2QLp7p6/JRjoKyiNZ7oI6EcSK8+qAZICPwK
 5tOmOmALD29KAa731swX2hggXp6cQk6fItO6u1xkO7B0uoDWyHSHiYIfwvDlbctOCwjnSKNtTUT
 2VE0iyJ0npdzQBllWbKykEu2l2bt0bTtj9J1xvcQkGeXSkK1kGARbj19qlztIRojZsDGwz6P8iS
 crapzIOYp0q9owZIVyZkpKBNjZaIbBTv/fQNGWSIlM3IPUylrNUqX1Kc7g23mkgrIJMJXVySGPw
 ==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id
 ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680; 
 Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
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

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0

