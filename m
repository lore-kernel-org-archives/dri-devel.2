Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FA2CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 17:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724B710E208;
	Sat, 10 Oct 2026 17:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFoFrByz";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0961210E208
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:22:34 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc1cf287ef8so322125a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791652954; x=1792257754; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OnHwutE7ITegaeoZburj81GeIxbecNg4buPuoGhuOZs=;
 b=YFoFrByzPcDmRge2GF8V5dWQGfmCnrLTNh8M8Aa5JGYoctssR4MEt6AOPNJc3uF+Mn
 7Am9CgJuGcYePi6aY+elpioqy01H1hUEweEN+c40GALfa/nVM66ZTe9A2LN4DoUctkFg
 qVBTm6TutYGS4tX5o9EVYpmMpj1IHb8iE9c9o5P3dhwk7FPfpR1yQoF+L3NoSKI5vT/2
 J5Jyegx3OpOnwf+w+O7y9mOAbvcGrBgUtsiP/KTFvQaC4Fcqby3g5xJ6r4+NiVKYDZHc
 eKSaH0iI5GoAi9Unr2eXyDuYjgvypbsuEr0ZR1Q3ZJmz0YbhZYG4Okh1+0uCx57xCP9r
 33ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791652954; x=1792257754;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OnHwutE7ITegaeoZburj81GeIxbecNg4buPuoGhuOZs=;
 b=inSeN55EX599vQTXseuJuWbzYHwbwHsJ+he/cv0SmmmRVkD6oFFaZEbncVYsNVc2em
 gl4S2GMwr0E5igvihzds8Z53LioZ/XyxfOxfs0VtaXH1aIPZj511HiP4fdjCuzPLMAt2
 WGDlKYCf5rnp7QVgqfge3TInj1PssgZ9JuUT9J9QX/ysXFDt1K0AHXDA/LxarGr1cUNJ
 Ip21FeT7yWBsI4xGH4RnlzMjMEprg2U81x/d+07fFnMA07PVbS9rUgYSCspfhPapLHkB
 7W7GV/99zhJ5oY2YjdNQAR8w45IBF+VerOh+8meVu/lZkcFZzvjVPRGBThZASc84zT5S
 YDLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx02vA5fkndxA31p0TDpMeIWZhq5ZJORydA8mZXqUEzoZn7DWAn+Okr+Jfo47wn2VuFnPFZLp4rbeE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLoJYM4r75RBnZj5e3D/ETYzWknyUrrCB3csMFzjR3NLLnkwHfL
 2vfsDZaQCF53S/pwSSGsJd6N2o7ndCGrxqyLnFQ2JNM9rkOWqgmsnwWN
X-Gm-Gg: AYBFou18Ap9XUiu5lpdWOcdZelKW0r0SqAMaeFaPMXZyAF1N/j1U+t3kWbW8GX8pNWq
 G8FENJDlk581eKuyQCC6ChJtGi/m885NtgfCUAXuyXo709XveHm9mY5epVssIgVampBzLdB43vA
 OYDbE0sW9lfJVCDgHXTRhXxjcxsK7K245hT4xJCVoBUNGwkbn4HNj7D9MegjNl9BesRcWSqeF2P
 m0qjyflyVPLOd9fNTSHsH92e59DWp89+k03s2fRbzy8Xq2yiEW1rZ5VualheedogSYHhUdV5Qk1
 GUQusTH9uujFW1s0fc3hLBbkZboNvexpZ0x7kyhCWNhba9eIa2JS9+sqB7JKGUXsZb6fPEpGwbL
 ya2yT4KHVp4kU/CgzTk/q4Fi6o9CUzGeOH9eE0sfj8oSsLyYWbbj+xLMDOKzsWOZEenSuFb0lOU
 f6xFWMoMvoB8F3/FpmGgMtsHKmdwLZ0j9rz+ApNlAsOTWeJnTZyIpGkujn7OvDqQ/Tz3A=
X-Received: by 2002:a05:6a20:c793:b0:3de:247d:73dd with SMTP id
 adf61e73a8af0-3e16bf4e584mr4266698637.73.1791652954365; 
 Sat, 10 Oct 2026 10:22:34 -0700 (PDT)
Received: from [127.0.1.1] ([121.125.115.175])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-898802de7d6sm1510213b3a.23.2026.10.10.10.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 10:22:33 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH 0/2] drm/imagination: Switch the GPUVM to immediate mode
Date: Sun, 11 Oct 2026 02:22:19 +0900
Message-Id: <20261011-pvr-gpuvm-immediate-v1-0-5b298dfce4f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEt0ymoC/zWMzQqDMBCEX0Vy7lKTQy19ldJDflbdQtKwq0EQ3
 71Jpbf5hvlmV4JMKOrR7YqxkNAnVdCXTvnZpgmBQmVlenPTvdaQC8OU1xKBYsRAdkEYB7R3DN7
 gMKpqZsaRtt/r83WyrO6NfmlXbeGsIDi2yc+tChwhkvjrP8DpH8cXmOnsQKEAAAA=
X-Change-ID: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>, 
 Frank Binns <frank.binns@imgtec.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

Switch the GPUVM to immediate mode, as a prerequisite for asynchronous
VM_BIND. A revised VM_BIND series will follow separately; v1 [1] is
linked only for context.

The switch also fixes an issue Sashiko reported on [1]: the GPUVA lists
of other objects are updated without holding their reservations [2].

Based on drm-misc-fixes (depends on 196d4d10c1b3).

Tested on BeagleY-AI with lockdep, KASAN and failslab enabled:
- All IGT imagination tests pass, including pvr_vm_map [3].
- The fail-nth reproducer in patch 1 no longer warns.

[1] https://lore.kernel.org/r/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com
[2] https://sashiko.dev/#/patchset/20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com?part=1
[3] https://lore.kernel.org/igt-dev/20260930125057.1837788-1-gye976@gmail.com/

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Gyeyoung Baek (2):
      drm/imagination: Switch the GPUVM to immediate mode
      drm/imagination: Stop locking reservations around map and unmap

 drivers/gpu/drm/imagination/pvr_vm.c | 80 +++++++++++++-----------------------
 1 file changed, 28 insertions(+), 52 deletions(-)
---
base-commit: 6ccf996a0dec1852dab94ad865f27b4904750e12
change-id: 20261011-pvr-gpuvm-immediate-f7ea8edc2e7f

Best regards,
--  
Gyeyoung Baek <gye976@gmail.com>

