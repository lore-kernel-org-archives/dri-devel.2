Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=033rYMr1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741A01120E4;
	Thu, 26 Nov 2026 08:09:05 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CC310E166
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:47:25 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-385d8a00598so9632470eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661244; x=1796266044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OXA4ky/fQgmzHbW7Nm+Sd23wuf3OJ0ZTD63YpErJ16E=;
 b=033rYMr1lqOaVos62f12jBEL84g4jVlc2x4dwsoqSa5zfr9/zXnzRjTj143sBIUgkR
 STZySyYO1Gw0tFv55esTBOIKtkwKaBVrSlwsPsquen6+lmA65A8Xi75qjH+/BItCb8nc
 BSm8eNpSZW/ONg2P8yBFavaAoP3BFEBjlf8m5FoBcwuEuG5QajK43TGeP+9tPpmjbRn+
 5Qyreuw0Cl0taqxXtn18aSsL/H68UQ3We2za+jVjIoOBotThHdUHTuIaKO3xzXQSJ40V
 iYJsbsxwutL2thR+EfdMXQdNKtOGEhSPfTWwBWxBtSQ/7VZ06QEq46JICryF1EEf/hDD
 RpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661244; x=1796266044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OXA4ky/fQgmzHbW7Nm+Sd23wuf3OJ0ZTD63YpErJ16E=;
 b=0Oxrou1ZwwOx9W/qbJMXo9YnuIECpBhaCS3o84hOW4iLNwTzzDchVpkXb2StgyPKDX
 9jnEfb20sZSR6vuxgI+LhUomqIuQJ07rzwXxWbq0UNHZthQu3xOJU2jKSvuUEGoMc49N
 Mgol6KBBWKOOUhE1gvoKs0b2Yj3kftdUZKJn2cEGZAMrNOfq79UUzjCod0SOY4znnMnb
 3n1LWHHWGV8Ur+GWEQ+c4rEXAKlI9cxrA1RrscToQq8oR2p6on+9BXAwnMKC7APBObjH
 Ua04mfC/BkoK6Tn+F/q7uLadko/4hod5D0tgyvGcjtjMOvwdGqFIzPCLkPwtRwKpAqo2
 +nrw==
X-Gm-Message-State: APuU4Z/JR8odSjM53FWwxAmYSbUaCV6p19thogLyiu/H5J8MPfsk7ESi
 BBmYVevh5URuZwi2hVS2dkJRhHich9V9Gto9tpsEnlkemXS3/HW9VlExkm4xY0Qx
X-Gm-Gg: AZFdTZep6/Yd3vG8nQ9ZuFpzjALR2cuFMGAZAgO+FcT7d2pbQ3/CQsVcBrg014c/AIl
 VW/UB8yAz3eZ3Ksq3dP2Tq9Mn8xmTyULddrXHHACK8Ns8PsLhCatrMQPH02nryE/iph4E0GuWuI
 cWPhrsGNwU6wtEcxFOSwIwUfR06yrkL612vfjFHF2+MPyoM0s9wYOM8LZEs2aU/7GknKKD26V5F
 61KMbz2oWKIFm7rwBrXPWphvZwCq8+ma5QVb1LeG8aZHshk0Tud6cvm+rMg4388szaz0arcRt5o
 H+scgJlbU1kZjXIRA6aCkzCHjoh08UEGoEO40sB/q0aOcqz+bvXRtU0YiCJT/SGYnCJFutMU08d
 VqpbHSP81MAWvsdJ2wjoaK87C5xIXHgB+kjoNfGYWa9BV6Uel01hWKD5LIMLdov1u8irPkrf4rQ
 9U3dqL2nU2hPwUr/x50YhvWRISmekMvovYCsffYgen1fWFSRR5NGTFnECauFMSKGxKIp1F8R0kh
 KPZr3UnTlFOaR9qQL10epfC1jUYFau/kW+YhYeLD1d1h5/FbVNtGmbI8zOV3m+PI1clW0ATKkE2
 S9qF3DrqaXpHeVy1YyD0asHeUdn/iBJRgnYvmHnMSg==
X-Received: by 2002:a05:693c:62d3:b0:386:de65:9969 with SMTP id
 5a478bee46e88-386de65997cmr724401eec.35.1795661244195; 
 Wed, 25 Nov 2026 18:47:24 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm70815493eec.5.2026.11.25.18.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:47:23 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@collabora.com,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH v2 0/4] drm/sti: move commit work out of .atomic_check()
Date: Thu, 26 Nov 2026 11:47:06 +0900
Message-ID: <20261126024710.33401-1-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The three plane .atomic_check() implementations in drivers/gpu/drm/sti
do work that belongs in the commit phase.  The cursor frees and
reallocates its pixmap, the GDP reparents and reclocks the pixel clock,
and the HQVDP boots its coprocessor and registers a VTG notifier.

DRM_MODE_ATOMIC_TEST_ONLY runs drm_atomic_check_only(), which calls the
plane .atomic_check() hooks and returns without ever calling
.atomic_update(), and a commit that fails a check on any other object is
dropped the same way.  Either path leaves the hardware changed by a
configuration that was never applied.

The cursor is the worst of the three.  The buffer it frees is the one
CUR_PML points at, so the display engine keeps reading it after it has
gone back to the DMA pool.

I do not have STiH4xx hardware, so this comes from reading the code
rather than from an observed failure.  The series builds warning free
with W=1 and COMPILE_TEST on x86_64.  Testing on a real board would be
appreciated.

Tool disclosure, per Documentation/process/generated-content.rst:

This series was produced with the help of Claude (Anthropic), used
interactively over a long session rather than from one prompt.  The
assistant did the code reading that located these three hooks, wrote the
patches and wrote the changelogs.  I reviewed every hunk and checked
every claim in the changelogs against the source before sending, and
mine is the only Signed-off-by.

The starting point was a request to look for work done in
.atomic_check() that a DRM_MODE_ATOMIC_TEST_ONLY commit would leave
behind, after the same question had been put to V4L2, ALSA, DVB and
fbdev.  Candidates came from a script that flagged .atomic_check()
implementations containing register writes, clock calls or allocations;
it was calibrated against these three hooks and its output was then read
by hand.  Of 17 implementations it flagged in the tree, 8 were a pattern
match inside the identifier writeback_job, 6 were the normal per-commit
allocation idiom, and these three were the only real ones.

Testing is as described above: git am onto the base commit below, W=1
with COMPILE_TEST on x86_64, and checkpatch.pl --strict.  No runtime
testing and no reproducer.

Changes in v2, all from Thomas Zimmermann's review of v1:
 - cursor: the new error message uses drm_err() rather than DRM_ERROR().
 - gdp: .atomic_check() now validates the GDP pixel clock with
   clk_round_rate(), and the clk_set_rate() failure in .atomic_update()
   is logged with drm_err_once().
 - hqvdp: split in two.  The XP70 boot moves to device init, as
   suggested.  The clock enable and the VTG registration move to
   .atomic_update() instead, for the reason below.

On the clk question in v1 2/3: clk_round_rate() is the interface for
testing a rate without applying it -- its kerneldoc says it does not
"modify the clock hardware in any way" -- and this driver already uses
it that way in sti_dvo_connector_mode_valid(),
sti_hdmi_connector_mode_valid() and sti_hda_connector_mode_valid(), each
against a 50 Hz tolerance window.  Those validate the encoder clocks and
not the per-GDP clk_pix, so 2/4 does the same check on the GDP clock.
The limit is that clk_round_rate() rounds against the parent selected at
the time of the call, so the check is skipped when the commit would
reparent the clock; only .atomic_update() can catch that case.

On v1 3/3: the XP70 boot indeed belongs in device init and 3/4 moves it
there.  The other two steps cannot follow it.  sti_vtg_register_client()
stores the CRTC the plane is attached to, which only a commit knows, and
the clock enable is undone by the clk_disable_unprepare() in
sti_hqvdp_disable(), so it tracks the streaming lifetime.  4/4 moves
both to .atomic_update(), where sti_gdp already registers its own VTG
client the same way.

3/4 turns the firmware request into a one-shot at device init.  If the
deferral matters for a built-in driver whose firmware lives in the root
filesystem, request_firmware_nowait() would keep it without putting the
load in a commit hook -- happy to respin that way.

Minseo Park (4):
  drm/sti: cursor: do not resize the pixmap from .atomic_check()
  drm/sti: gdp: set the pixel clock from .atomic_update()
  drm/sti: hqvdp: start the XP70 from device init
  drm/sti: hqvdp: register the VTG client from .atomic_update()

 drivers/gpu/drm/sti/sti_cursor.c | 65 ++++++++++++----------------
 drivers/gpu/drm/sti/sti_gdp.c    | 73 ++++++++++++++++++++++----------
 drivers/gpu/drm/sti/sti_hqvdp.c  | 44 +++++++++----------
 3 files changed, 101 insertions(+), 81 deletions(-)


base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

