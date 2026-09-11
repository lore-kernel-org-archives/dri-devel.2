Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6FDC88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8E510F65E;
	Fri, 11 Sep 2026 14:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="TuQyyCWl";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B3C10F667
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:47:04 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so670380f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789138023; x=1789742823; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
 b=TuQyyCWl8mkIiTAKa9wOH9iJpiDm2lF4QUe/tCyY4UboGkCPbM0lQ+8mGFCQsfjh1e
 CaAqQcCKuPKaEAeL7z/wOlJL7emtxzHb3r7H9womPfopL/QhhF9MQQRHlwwD0ngwJTYd
 rdbVq8ym2qqDVR9yb8q9R87hmSNRsaTlG3WuTWnzk95lYFHnIVM2YhX7rfgBH/jDNVlx
 Av4NkImmbywZuPil0L9fLqhzLjgoKScnrZLwwfRm/Gtla1uMsMDmJPIylvejnZnEGhHb
 pCvCYXsc64cIy4sfqNDxKFxXGUZEznlGgm+u3xCBcdMxFHYflJmYmiDC14OQ4zX1x1nT
 L89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138023; x=1789742823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
 b=RyRZjtAEp/qVwTna5rFDJvZrIyrhOqtFFzbhQL2xNV1ahU7QZJaUyMoXugPtrlNf7U
 Haqszma7CPfOzSbIRS9g47zW1cE7wgDkm7OqmxTSAxhZ4TBQJDYmr1mkVkoSQEIn2uDX
 vaVacO827aifQ68YeWP8JF/M+8LbM4ttbPmBdMnyTK+v4sBzeLPShUmcPuV5zkfL+QVY
 7kHaoXNe+7mtBPWaI0aw5I9e+FJrwoKgDJCIfOiy07lQYRGJBSMqpPzITVx3A8E2a1O3
 InFptVm9hOriObRU8vhVlzP6gXGsuz4NtwtR+IkBK+nmPevuqL6wCaNO5nI58nzkLEU7
 FGLA==
X-Forwarded-Encrypted: i=1;
 AKwUvByMDvHuFyC7zjs4d9fN605Y4dNrJ+1BLznAqNc1Zyk8kURPcvjV6MMduG5aU+KtUcCiPtSdVtkfVHU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9cWahCA1yCp2yo9zu0n5OHPd/6ruYbUvHpCmiRZ1qj+ZoQGzY
 y0H2yvteSyeKcgP+VsH25B8QbyR+nc7lOQP07Vwg9s6bkTFysVk/vyA0chW4ZWOh6iY=
X-Gm-Gg: AYBFou1PP4I3W2TFLfxzXtSdVs9lYpjC9nfHeUBucZ88TjpQcL2JANm7/4hl7OGqn5M
 bkeTn6/m+t0fM9ByyYADcMU6RTmlqpfC9bW/Q/fThYOFLFcvX8uy30ZgBqWwE7gUK4IJOvfLsMX
 IyYdMpJWiffSAoMJ2dY5ur3EJGH5HgBxdVupRWpLkc9Agc3xU7jtLnB7xt5hFsT/4+JHlEueBHW
 tyBgffESx5byY9NDU7FhxpCVEe3WeInBvIHteyjCccmvVuFtoh93Hwqdb2dJCzUwyT5nTUj3Dvh
 dfDBV30t4NT2z6SU6zJpf/gvay1m4SK7ydRusybBov3b4YSoradTcYI/lnjWXyDr86fpjcGDAeb
 F587zXEmj9Avt9orVEPeXnsAgxdS37efswP7oNIexIm5Ohn1Ak9Mo7fz2TxH59JG3mS4eMnr3F4
 wlT2zK2DlyNWKa6Imh8w6MIhvZcb6fSBYTYbGr5NuHh1Fxc8tDbvLh5d9fuLHBrQ64hfpZq950x
 eInvw==
X-Received: by 2002:a5d:5e08:0:b0:486:e81b:842a with SMTP id
 ffacd0b85a97d-486eb358ab6mr5259626f8f.48.1789138022582; 
 Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
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
Subject: [PATCH v3 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
Date: Fri, 11 Sep 2026 14:46:15 +0000
Message-ID: <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
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

jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
which are declared in linux/sysctl.h. It currently gets that header
indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
needs to include linux/sysctl.h.

Include linux/sysctl.h directly in jiffies.c ahead of removing the
unnecessary include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Thomas Gleixner <tglx@kernel.org>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 213ae1d6a014..9231fea557ce 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sysctl.h>
 
 #include "timekeeping.h"
 #include "tick-internal.h"

-- 
2.55.0
