Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B03C44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872B710EA24;
	Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="QfRHvfII";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BC510EA0E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:12:44 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so3091392f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784639563; x=1785244363; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
 b=QfRHvfIINNGoTFUFFgtuLgHQ6HpP96VyiUNN+Wodrbmv0OSmgp/R6bcJ3zinRV/SB9
 bMcv+x/93vvr5G3vH8a4bezsi+usBYEszjTdEhc273ZlMBYJm497BH1T/HLY1XKMRaDp
 MDKFl2lhmgVwjz/K1K1zrcxlLjYkfVxu4qCQyd1z4RhCgioObVt5P9Bk7MuarQgyWnxi
 dbDTZ/hk7tvZRAteEUdAHoqqWr4AOsOqVZroPikKumqRL1HXCi2Kfun+pVDuUiYEF9uG
 wz7QsgRjHORTU4mMx3TEasD0y4Aup4DkTbxb75W6pqrPtZKVFu2CfjAXNsBYc8MCQzrz
 ozDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784639563; x=1785244363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
 b=diti/ZqB27fCTBVXOk9PLMMtsIU/pWhKo5l6/D2NV4G2/9wc2g5DIvZ0uaNdLSoZ8Q
 f+o5JsVWo7z6z3CgDjTMeZM1xtdHkDKz1lOPiEaZOMgxCHYI0+EnflifwqNTFWuQ2qwm
 zStbBzfPf8DMaPJ0O0I4Fgppq9/HHRx5G96y/3yZNzvkI2EDQwkrTuj7lIE2Ivq8nAUE
 sBwq26OCwmInYFRvYrfLdLopHDV7RGY/XkxO2PAPAhJUL6RLgIqgwc3S0R4nqSSwNhxq
 yTlVu9eRyXTWEM6hEOo/rCm/FybxxYzEpPa+AEwfyna0V2cw3H4NihAIwLFQ8hKo8bWe
 7YGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxqIay38YqDWWmEmjAZlSEkWlDFFzPanq0xcalzx110o4qy8hKaHCR5G0ma9CIP2Ej1FA+J7TvHCc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWqsegwwooV4QORi07eXp/+YJaj1Pw4IfODQQfUtt6xBGlOEZK
 zdbeNH5qANstPAt7L+AYJvhF2S0EGSZmmv16vIneJ/zViqivskhriDMzME75CU7CE8s=
X-Gm-Gg: AR+sD134zsUV+wrejNZUpJRqg0k/BsQBYVF+lEVg4nPYDwTSWt6Ygg+lyDe2dCCjxdI
 7mfLpNqwTiWU1L4J9wtAHlavRfVWofI9VBBedoYc9n9b/WBHjbKWu2Fyj5xzvwSoFpweA1xQvHX
 TtYImto1m38SsFph0VYIAVahKJpBdnnI2Deoj40b85kbA4HKF1FGylxRzJGs6NkPz1N3RfWpnIu
 vhf89E44hCNwrndst08C74q2eK6WbJ25F6EqS7+rcvCV/75HKG1578Jc3eAcnjLOuQJ5vufLXtD
 5A2CZSby4LpsqwFa18bzVESi7un5eLNswv7mWUQrBijS7yo5s9sJwGIUoYE84qbDrSX5i3CQ7jj
 GX41NM1IHuyCJfUi9m0U+vRyWhXY/DVa7s8HWU322Kk5colMPK/qnEZSmt6XREEDtK5QMo7KZcQ
 ==
X-Received: by 2002:a05:6000:4023:b0:47f:81fe:12fb with SMTP id
 ffacd0b85a97d-47f81fe1712mr2452175f8f.47.1784639562827; 
 Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
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
Subject: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
Date: Tue, 21 Jul 2026 15:11:26 +0200
Message-ID: <20260721131207.803760-3-petr.pavlu@suse.com>
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

The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
currently relies on this header being included indirectly through
linux/module.h -> linux/kmod.h. Add the missing include in preparation for
removing the linux/sysctl.h include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d51428867a33..17cdb5ef8893 100644
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
2.54.0

