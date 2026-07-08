Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECA3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED1E10E628;
	Wed,  8 Jul 2026 15:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Om29Sl+6";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9193D10E628
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:46:07 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-474560436c3so804051f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783525566; x=1784130366; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
 b=Om29Sl+6Lo/o6zIpChI5qpTTe+zVQtgD5lsEYFhEQklnYm5KDd4lQkweLZfWf1lXH6
 XYC/AcpCnEzJFCtJkvsRMEpDbg0WMFZ9kCnESqq4/XY55yQ6nKUGB0CpzcPg5nqAWT0I
 WTQtYFe/Nx4ETCWY5nL7XZxvtgsVAURYbhzyZ+WEsQfGF/qomQi8r6ibiuN8Am7bsIC2
 5YvOfyJEg3+7X6O93bfMqfHUVZmNEjnTB6AGSvVmDZ7aqGgQO4FPMBBQryT2M58opGOK
 hE3Pi/4Kt7jdki2n5FHkNOt1hCAkFDuknehlx6B8kvW4XA66EkiZ88wbYo61RY0HYoft
 PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525566; x=1784130366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
 b=fSmVgvX9lcrPt1kohhPwTe0rHHwKopkRflRcu2n0WohtTeO2pplvq/wumpG+lT4mSJ
 VQiiG7tJUB2WIzCq2bMCCp8iKMFJl6rYo8NQefIxA68SfEmaicSlfiTkAXEuy+O/I6kN
 iX3iRJgylHvp/8WD3wVfLGVwWlnlgva2GLUKA3do67xtXpoh2cQC+EITkJ6pWLBR6J56
 DoviRcl6VEgB2/PGBxZGif6LttsPEyRUOwrAP3LA0OnCANjurunGslaKOQg4A+xT4WQP
 nRtr4WMb+5383mw2Ralte9vyqt/EfYJjsXV2D8aqFfjh8k+H4wXbeO7mrKwgKnFHnRyd
 of4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP7OMYNg721pkd+gnsZaxopg7rh9CAClxIVoCCHJV+CN8oty3x6uCwVaT54GhknI+dKYITMPk9K18=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHwYwSCKmIE27/MR6tkvocw6SWTfgG4bLYIARuLgc/5yvz2J1e
 cN0xBuHIFBpTpKA4mVxXt7/BYPQKDRysiSAuzHWnd07w6L2BR5stKbrJvNMTg83QulA=
X-Gm-Gg: AfdE7cmrntmpzvjmLshrUbOTK1a2BnvUC9zBvEumw7PdW43sAsxcJEa9gwr75HdYRYE
 oD3qqYrL5n4py8+rmWeeknJQZVz0wnVHuQscX6GLL1b+S9Va6ItrBS8cEcTVZ0syF5VgIFZmbj3
 Mhh5XqH06W2z/aScCR5s7Nc9CzgXSY4oekZNNaAMOaSUkqXFIZRqnylFFSUHqZLB26LZ1mkjJUG
 ONn+iMzAO/GrKV3JeUoW9TCrrFbqxyWQ4R2pSu2T9bZS26O7h9jWdNdXL+fBFMDoZUPbcTC0OOE
 1xKZQkwRWP/AhQYtqYqsFjU/Sq8QwMl0p+NPpf62fCWXITNcJAV4dgG9L2JyQM03lW8d9eLa5h3
 sbbquH0+7GVG+pcbakruMn1Elhnq947i9L1znKMJ1gqMTLp+y9BmkiQ2yAgRwvhwea8GUKe82yc
 b/ebc6IjArSYF+Oxazu1IBLDvhUHHM1Q==
X-Received: by 2002:a05:6000:26d0:b0:473:673e:3836 with SMTP id
 ffacd0b85a97d-47df078bb73mr3861713f8f.28.1783525565920; 
 Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
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
Subject: [PATCH 2/2] module: Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:30 +0200
Message-ID: <20260708154510.6794-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
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

