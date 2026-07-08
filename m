Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A949C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC11710E620;
	Wed,  8 Jul 2026 15:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CKfT9E3X";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63DCA10E620
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:46:03 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47dedd17e12so75414f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783525562; x=1784130362; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
 b=CKfT9E3Xy7Xchn8dVrncFhLQpOxEEglbz3suPsjcL3BFG6SIAiBBA3gfd6e4Fp01QE
 3KchAA9125kYoiVMtjqCfCiIa6G9V0nxKRNqRcHdYGt8tQIE07fImuDAMMQlMHjLwIQP
 uw+LC7D3gKTZfnWlKwDqZfKapdJ7d0qGZH6iyNRSmePaxhXoRK8ZbOMUiYR8M3+1p+Xx
 cXbkfWhwl6kHvz3anCMR8gkfbI1/sZxSVegFBFJjocz02ZxdDOnIe603L/fet7S1kTyL
 0BKJ2YiUT9+2IXCLIW5SAuxvNMo+uA0ysFmyVmdlRRjaSEKn5rGsjDX2YozahQyuBmX4
 2Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525562; x=1784130362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
 b=eL0T8I8APqhYCPVURdAuZ328pY2kkpAB5cgNZdH7L6oIfCqYfHtbxAusZRNDpF5s7d
 p/Q29BmxjUTEZ8x8gTjwqK04OCqVQr21PCIBkM+WBG4ioWq1E4N6BaQJfjoN6LqhxN5o
 lb0dacfiBNLSIjkBG8IE7cSgFpExc5qjkM41B0hJvABIlvkI8wZQ+lx/ybP1zaA/yGgX
 EShnrDBHP0EuHHPDCS4S6mOVSRNmW6jEAHE4721GCWLkK3yxfSKLWuKykO+27LPgQ8aF
 5aE2Ir1AEfdOUKx3QyG75R1TB2ilExf86VcZ0cDnm4zIixjSKnVaPAzPcpoaoxtT5tFW
 WawA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9W8gjw9dN9Ab4Mu3Jfca8NsNkZuRGvCzf2OMA4vfrHQiZsllAN+j8Er6b17dekEq42ypZXKrIGcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaF5ZWPLj3G71DDD8MeBMswZS8CzbWsUTG5/jFmD6b2ndJKRJV
 7iO/EQbIXtsPsk3mOk1QZ2MKOHiVljt3erAEJ8TjpnpvAvyFlKJ/krXcuvrUYnbinHI=
X-Gm-Gg: AfdE7cn2jfaUCwV5dCQljnzM91BEwqfIlCEr5Y4rLf5dO9hCm3s+Je/tCluxvYlmokI
 DpYiP7APlh2maalxwuAmbVZsy0Gzoq3OTjvPsG3ua2pDl7Hg3a430pafVaSaL2APYELYXL6GVxV
 Mi5Kw5q6HkCC8k48tE1iCBGYtjz1VKUYXIAUj2gHVmpRNBuGdiRgt1NRnEn4BQG/PEMbCHwdNi8
 mY5EJFG8kvH3CbK1n73jPuQSAc4scoqzPluYlbMv9xspR7eVBJcV/cEYxHtOfObY2UbL84oXPmk
 f6AV2nZFzvL4S2GOpvohTbdTqtm38jvNTI7pGTssMoTKgxviRzyGi9UJzUAaH7x3zH0e8tK6HaU
 AqSv6opcrTE6vr12m4AWShFhUhh0bsWYIl1cZ6Azjz/XyMsZlgudXgQdQBxlOyOWRCBukp/tTJ6
 4mNvvigAZkeyeYxwwVZHp/WjtrY7k97E+dFXoNlhVM
X-Received: by 2002:a05:6000:4304:b0:46d:55a5:8ec5 with SMTP id
 ffacd0b85a97d-47df078bbffmr3378920f8f.33.1783525561596; 
 Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
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
Subject: [PATCH 0/2] Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:28 +0200
Message-ID: <20260708154510.6794-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
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

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Then clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

Apologies for the wide distribution.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Petr Pavlu (2):
  umh, treewide: Explicitly include linux/umh.h where needed
  module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  1 +
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 21 files changed, 22 insertions(+), 22 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

