Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A8FC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDA210F638;
	Fri, 11 Sep 2026 14:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="RqKxyASw";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32E110F638
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:46:59 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso9238845e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789138018; x=1789742818; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
 b=RqKxyASwQUNVEYk7hx/5M1x0emFBJYVVdympzZ+o3PjSgJrvB0ZetB+wNCAs7H3kg8
 jUgRTiSE/7gEP7wrHcsXL2DoAdECpFibjXYfef/716MBEDQqnuPE9xmpO3KDBoySE0vj
 YNQU8zkutuVCtIo034HvBfns+9aL/wtvl+7SsesqpmTzF3bqTnkPi6py6Bvu53EC+wnd
 gwYssywMchE0ekTv/fLPut3ib5SND8woNvk3tbjZGbjbKMNdN1pLQMfPtRzsEw3LRDRN
 MpWD27V8YYO3FA5gLa80SwaPXcubFogAxk4PyCiF2FBItiPpmxqJP8pNgKZonShNXhr5
 pdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138018; x=1789742818;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
 b=K9Np1TS7EE+cWTEMjFxxgqBxJhl/JTJTKB1c8gTgqGIb+s3Bis+8DshidMIjZsyuZ1
 M1aWsF38ql4ZRmiX6nMdp5/tKwxRCzYYEwbSffKvg//ewq82aJt3FlTi7WKPuChhgWd9
 kei2+UoFj3Ox7D4eKGjlW5oRwLzzrfz8d50gt+LJFQGWgn83vNWV6+VNHBm1dvngRD56
 2VlC/YZvnd3LyMzSTPVk4JcJDz8Drh+Vc1mqDCdVbZ8pSLBE/o8YK2ruoqhpu+0nDlWr
 gGilLmhHNl8+hSCsN+lxTnfpaQgtcdrWcSt+ojqXcKr4XwxBSVFckpxoUPS6RyH2vAVz
 4MFA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYbKIEOtmuem7fRQpnznGzQi2fHfql02bPvQ0+tfg2rg23s4inNXmmVcbyFB4BVieIYotu6iaVEXw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8uMS7ZXl8AbO8smB2rgZhgXW2eKGB++zlODdRdqWsRMqWtQdO
 EMfkMd5KpgFA2bp8xtdTZAJ9G7eRNrEEEwPJJ0Ny6eCxzzv6i8/Xe9LIAglRzoks9wM=
X-Gm-Gg: AYBFou13hP1GuqxXSxEg+cZDpRp7/qyrpC95PJd58ESdaIjQOOg2w6m7YTSt5A/okM1
 aK4YVwvMPQBkds0EpRLC7r7ZLb6gtRNfq8W/NGd+o7/2dpwxeloWotUOz68bmB4lT45LQ/MzDJM
 HPnyt61tz+Rmbtoa4NOhP6pYdsv53mN1/hcejoaeWbQ7dk0Y8uL2i7sAaLZ0j1GYkKmHe1GpTWc
 V33DVH9HaApXycl9nwguM3NiZBu/EUo9a1u1+KRwtBD05w1OnT1bkEYK5tex5ULfxUfTmYQ5RGT
 UmG/rl7ikt/0qO449tM7KJ6/R8huYLPXak/Fq1iwiniNvKilL+Y1dNOXCviWr4Gt/ZMNDfLo9Yw
 4tRD3MsuSIBTCtG52bPKBmNrr1MG+RxfoXyCxq3ekO/4NK4XBLmUtX9EdcQihWa8MRLYulNcNq4
 lWeDyqSGOVZYmQzrKmlYvbFoy6gXWXTaOFvm70YeS0KV2Cb4e/2KAx/JRuhPQkQFQbBGm3nEYjN
 tqu0w==
X-Received: by 2002:a05:600d:8444:20b0:49d:27ee:79c9 with SMTP id
 5b1f17b1804b1-49d27ee7af0mr93376655e9.8.1789138017731; 
 Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
Date: Fri, 11 Sep 2026 14:46:13 +0000
Message-ID: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260816-module-include-kmod-14d1a0e19462
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

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. linux/module.h appears in
roughly 15k #include directives across the kernel. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions. Note that
this series doesn't immediately improve the situation, since most of the
files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

---
Changes in v3:
- Rebase on top of v7.3-rc2.
- Clean up commit descriptions.
- Link to v2: https://patch.msgid.link/20260721131207.803760-1-petr.pavlu@suse.com

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://patch.msgid.link/20260708154510.6794-1-petr.pavlu@suse.com

---
Petr Pavlu (3):
      umh, treewide: Explicitly include linux/umh.h where needed
      time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
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
 kernel/cgroup/cgroup-v1.c            |  2 +-
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/time/jiffies.c                |  1 +
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260816-module-include-kmod-14d1a0e19462
