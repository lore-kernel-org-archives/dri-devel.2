Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=abaygg6onarqet2uti4t4yyiczbpngnf header.b=xeeF+tBH;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=HstFvLnb;
	dkim=temperror header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=dkim header.b=VyWiak+B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EDE1120E2;
	Thu, 26 Nov 2026 08:09:03 +0000 (UTC)
X-Greylist: delayed 432 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 08:33:53 UTC
Received: from a27-123.smtp-out.us-west-2.amazonses.com
 (a27-123.smtp-out.us-west-2.amazonses.com [54.240.27.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB69B10E169
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=abaygg6onarqet2uti4t4yyiczbpngnf; d=retsim.com; t=1795595201;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=qsGFfntf6lM+OdsemqqtNR29nCSCQOpdhIf05lfqyx8=;
 b=xeeF+tBHkWeemMKTB52fB5ff0xA+fZ0NYKxrailWdbXgsFeI3eLYAULXElkToIHG
 xITc5RRc9BhSB9KF+xy0pWUKI6yr2sPzsCI3HHwVwRz4mA2ztHCiCuqk7RSG3abbvbu
 GZhMaNuoQYYj8D79j4qljnt64AwzkFe1aODF38sk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1795595201;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=qsGFfntf6lM+OdsemqqtNR29nCSCQOpdhIf05lfqyx8=;
 b=HstFvLnbNX72zJSBuJMctYXzvysruKXtQQPsBLQ1BoY3C5E9YECuwYq2hCaufYKl
 Nis5CaDaXeUa09jLuUyLlspfi4Iu2Yfm7U+1EDvZH1j7hnHFeI40423p0QxJfr8/j0l
 khPezcB/E+n9M/okRHI6sFyL8aQZncY+QeamCLXM=
Authentication-Results: mailserver.retsim.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=retsim.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retsim.com; h=
 content-transfer-encoding:content-type:mime-version:x-mailer
 :message-id:date:subject:to:from; s=dkim; t=1795595197; x=
 1798187198; bh=qsGFfntf6lM+OdsemqqtNR29nCSCQOpdhIf05lfqyx8=; b=V
 yWiak+BtiyYaFf55DS0Q/YozqJhel0pipO673sj1sQ3lFphWoGjDoro+9osFbxei
 Vp/hIMzs+0kbjlBxaGlM4pmLWTI4Lm9sesGBkVfuSXHszZUcmRyjEqjSzZe2Px16
 92IaM/yCkqK+DUpWZTQ2OTbvFj6z8hXZs7CvWM3Hwn7FwGRVUe+eoPrJKnGXj66M
 /ppYegYoj0iEX+9TymACbdTlWLAmzYszwknqw/ZCealMKvv7dYs7+evpXsbGNKti
 axUZgj03hpK5whFKZpztmWkCaZ5Sl/HRXsLfkUmUb/QRDi6LpSBVX/TRPY1acCp7
 ouKjoHhNgDOyL3mb1U6kg==
X-Virus-Scanned: Debian amavis at 
From: Lewis Lakerink <lewis@retsim.com>
To: imagination@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Lewis Lakerink <lewis@retsim.com>
Subject: [PATCH 0/2] drm/imagination: fix teardown use-after-free after removal
Date: Wed, 25 Nov 2026 08:26:41 +0000
Message-ID: <010101a211d069dd-d7d74cfe-9be6-48c0-a9ac-df04d73fa3ed-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: ::1.us-west-2.jZ+gdeR9TqNTaB6Dq50UPG8S0IjuYZETsFsi7SlhF6Q=:AmazonSES
X-SES-Outgoing: 2026.11.25-54.240.27.123
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

These two patches fix use-after-free crashes when DRM files, syncobj
fences, or in-flight jobs outlive the PowerVR platform device:

  1. drm/imagination: guard fence release against device removal (13+/1-)
  2. drm/imagination: quiesce queues before device teardown (135+/6-)

pvr_remove() currently calls pvr_device_fini() and
pvr_queue_device_fini() before drm_dev_unplug(), and leaves scheduler
workers and timers running.  Unbinding the device while a client holds
an open DRM file or syncobj crashes on fd close in __queue_work() on
the destroyed sched_wq (from both drm_syncobj_release() and
pvr_queue_kill()) and in pvr_meta_vm_unmap() on the freed
kernel_vm_ctx.

Patch 1 guards pvr_queue_fence_release() with drm_dev_enter().  Patch 2
depends on patch 1 for <drm/drm_drv.h> in pvr_queue.c (the series
applies cleanly with plain git am), stops the watchdog and calls
drm_dev_unplug() first when !READ_ONCE(pvr_dev->lost), quiesces active
and idle queues via drm_sched_entity_fini() + drm_sched_fini(), guards
postclose/destroy_context/timedout_job, and flushes sched_wq before
device teardown.  Device objects on files or fences that outlive
removal are deliberately leaked (reported by the existing WARN_ON()
checks) rather than reworked around drmm_/refcounted device lifetime
here so the fixes remain backportable.

Overlap with pending work:
Ryan Brue's unmerged system-suspend series ("[PATCH v3 0/4]
drm/imagination: fix system suspend, and the callback design underneath
it") also moves pvr_watchdog_fini() and drm_dev_unplug() (guarded by
!pvr_dev->lost) earlier in pvr_remove() (patches 2/4 and 3/4).  This
series leaves pvr_power.c untouched so it applies cleanly on
drm-misc-next independently of the system-sleep rework; happy to rebase
onto v4 of that series if maintainers prefer to land it first.

Tested on MediaTek MT8173 (PowerVR Rogue GX6250, arm64) on v7.3.6 with
a Vulkan client and sysfs unbind across close-only, idle unbind, 6
in-flight unbind/rebind cycles (3 runs across explicit close and
SIGKILL), and module unload (rmmod): 0 oopses/faults, with the expected
leaked-object WARN_ONs.  (An earlier revision without the !lost guard
also passed a 75 s post-unbind hold past SCHED_TIMEOUT_PERIOD.)

Known limits:
- Compiled (arm64 defconfig, powervr.ko) on drm-misc-next (a2853fd);
  runtime-tested on v7.3.6 (arm64, MT8173) only.
- Runtime PM on remove is left untouched (see patch 2): a
  runtime-active GPU remains powered after removal.
- Foreign fences outliving both removal and the last drm_file close, and
  unpopped entity jobs blocked on external fences (deferred to system_wq
  by drm_sched_entity_kill()), still require a full device-lifetime
  rework.

Stable notes:
- Patch 1 (Cc: stable # 6.14+) also affects 6.12.y, which carries
  df1a1ed5e1bd by backport.
- Patch 2 (Cc: stable # 6.8+) tracks bug provenance; pre-7.x branches
  need backport adjustments in pvr_queue_timedout_job() and pre-6.12
  postclose.

Disclosure: analysis and patches were drafted with an LLM coding
assistant (Assisted-by: LLM on both patches; no sparse, smatch, or
coccinelle pass was run).  I reviewed the changes and ran the hardware
builds and tests.

Signed-off-by: Lewis Lakerink <lewis@retsim.com>

Lewis Lakerink (2):
  drm/imagination: guard fence release against device removal
  drm/imagination: quiesce queues before device teardown

 drivers/gpu/drm/imagination/pvr_drv.c   | 73 ++++++++++++++++++++--
 drivers/gpu/drm/imagination/pvr_queue.c | 80 ++++++++++++++++++++++++-
 drivers/gpu/drm/imagination/pvr_queue.h |  2 +
 3 files changed, 148 insertions(+), 7 deletions(-)

--=20
2.43.0
