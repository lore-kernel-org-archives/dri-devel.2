Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D29C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01BC10E9DA;
	Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2OQkojJ";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FFA10E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:10:33 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so315429a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789200633; x=1789805433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nc9NVd9sNNwRH8ykh0v4EzTVIL5fN9DWH/NmlxUyoiQ=;
 b=k2OQkojJEgP1tvtuLvQ1R7dpMU2sjc+EjquWXv2PlRXCAokGrr3vLIlg0zJCAa67QV
 k4E+5WCgIvjNryJVfWFH/6cY2SFRR+ZYR5j2x+ZLsM8FX2rLtWR/iKarEC7Aw7aZoJMC
 h78JXRIl3r5gwGFvn6qHoDiPnEshgphtfiAPVSUbFZs4fJCQGtJZI2AlMyWk8a7tlT/Q
 yanRipZIkfpmo3tYC1Zjt13z12KdSHCPMtc5oDlcT3lTV/0cfN53pcb5annIGzrRukK6
 wMLQQr4DWkFVvEJCFHeHxfC12/cBKZNxOf00IYpxHmbFqIdClFnNmlF+1KmtA63lgC87
 10XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200633; x=1789805433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nc9NVd9sNNwRH8ykh0v4EzTVIL5fN9DWH/NmlxUyoiQ=;
 b=aECqgEwvZ73dfc2znw9KK4aI8IO31CJBtSg8ciiYBjKmvhanMHtVYEwwwguNoCu2Q/
 Al54+YdC12EOR5y3bvsEeCuL1YU/AHqQvcOBJYlSAYglZOmkAdTJQ41RmFWkvsO4i4JP
 K4Alia1SptlN6c4Q6aN+z5irRUM0CNMomMOtueY1djUI42UMEhSOfwmxQvCD1VzTYGuM
 BYdflpjVtNzFoctEcRb71xuPn3Rn2l0Ky5qI4cyA+fQu5TMKxSGQwbVev3vzo/1OxBlS
 T6+Rx8PXTwzzR5yJGbkuEe4KWaxofbQvY+gZ/Qh0SvcIy/+naJPIbeP/zXciohFGTzf6
 jVBA==
X-Gm-Message-State: AFuF++nvRSpwGZpO9TOzoUX0VgKcyJKH6LlYJGWlD7EiPsGNNUN97Wga
 mBeb0Ruosy9/RxTxxB4sheTKbX4PoQRy4wtUQdCYz8GhUMV8Jw+1y3PPBKO10acnvvo=
X-Gm-Gg: AYBFou3asfHVdzXHKfKAHkArCsZUwt31kpZ5jKLIy97kp+1PA15yd0RNgNDzcT8uq5q
 4SdBxiE+NwNN3FLQB/tsEWvKkV8TopsiQAGkC0o6EDZ8MUA3I4dPOU6m9PVuCUnNa+WMf84gVwC
 fPM6Ij6PaBQYpBzaW+k9iTedkO/C/0MyN1CHbnapoKjLDC1+Z9i+Iobr3ZrH3iOTPlvp4hOoVNq
 XNDQwRqQsqHSUk34hMt/VIKSp9/ihFPc+ATzMtIfapKZZ+Z2QJZyZngs+/2x756z2ShxGModpLd
 ZN17D7ikptxkg8pwLVB8IJPtApu1XC6LwXUbAqXpRlzF2XUTx7/d8shYtwUhPrl1fZTEbgXDMW+
 9shmVG2PPoylRBRsYuerCDR7LM90ZycMU3/DqGkZeXuKrhr76XfCgJIQfVoLDytmx/7p+2ZR5pQ
 yVtweM71C2TivS5Pi8YNY9FNOn+P8vMfOSMH2xEypxgQviF6nNKM617Gq/HzwGGNbWm26ODOJYY
 /HXOEe/984rLlHiyoNg3EjnalaHTMOKac4TTVKlmBJA5DFk0Ted8EUdekmolFv2vjydCKlEkXYf
 woj3nCFh4X03BLZaFx50sUL6C12gaFpHs0Z49mkCPoFw
X-Received: by 2002:a17:90b:582f:b0:396:d28e:bd8 with SMTP id
 98e67ed59e1d1-39dbbea2aa4mr3547100a91.3.1789200632576; 
 Sat, 12 Sep 2026 01:10:32 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db7ae6d25sm982474a91.1.2026.09.12.01.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 01:10:32 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 0/4] accel/amdxdna: harden command BO payload validation
Date: Sat, 12 Sep 2026 20:10:08 +1200
Message-ID: <20260912081012.2274075-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

These came out of a read of the command submission path in
drivers/accel/amdxdna.

Where to spend review attention: patch 3 is a real fix - a leaked GEM
reference on an error path. Patches 1, 2 and 4 are hardening. I could
not reach any of those three, and each commit message says so in as many
words and explains what currently prevents it. I would rather be plain
about that up front than have you read three messages looking for a bug
that is not there.

What the three have in common is that a check on user-controlled data is
either skipped, or holds only because of a property established
somewhere else - an allocator that page-aligns, vmap() refusing a
zero-page mapping, or the integer promotion rules. Those properties hold
today. They are not local to the code that depends on them, and two of
the three sit next to siblings that already carry the explicit check.

  Patch 1 makes amdxdna_cmd_get_payload()'s bounds check unconditional.
          It is currently inside "if (size)", so a caller passing NULL
          gets an unvalidated pointer into the command BO. The single
          NULL caller is safe because command BOs are always
          PAGE_ALIGN()ed.  [hardening]

  Patch 2 gives the error-path memset()/memcpy() in
          amdxdna_cmd_set_error() a floor. The length is
          "abo->mem.size - sizeof(*cmd)" with no check that mem.size is
          at least 4. A zero-sized BO is creatable, but cannot be
          vmap()ed, so it is rejected a few lines earlier.  [hardening]

  Patch 3 is an actual bug fix: the -ENOMEM path in
          amdxdna_cmd_set_error() returns without dropping the reference
          amdxdna_gem_get_obj() took on the chained command BO. Small
          leak on a rare path, but a leak.  [fix]

  Patch 4 adds the explicit short-length and NULL tests to
          aie2_init_exec_dpu_req() and aie2_init_exec_cu_req(). The
          length test is currently performed by subtracting a size_t
          from a u32 and relying on the result being evaluated in
          64-bit, so that a short command underflows to a value larger
          than the destination. The slot-filling siblings in the same
          file (aie2_cmdlist_fill_dpu() and friends) already have the
          explicit "cmd_len < sizeof(*sn)" test; these two do not.
          [hardening]

No behavioural change is intended anywhere except patch 3. Every input
the new tests reject is already rejected today.

Based on v7.1.5. Compile-tested as an out-of-tree build against 7.1.5
headers, no new warnings.

Not runtime-tested, and I want to be explicit about that rather than
leave it implied. I have the hardware - a Strix Point NPU, 1022:17f0,
running npu_7.sbin 1.1.2.64 - and I am happy to run whatever you would
like on it and report back. I did not want to send results I had not
actually produced.

I have deliberately not added Fixes: tags. I worked from release
tarballs rather than a git tree and could not verify the introducing
commits; someone with the history should add them if these are taken.

Eva Crystal (4):
  accel/amdxdna: validate the command payload regardless of the size argument
  accel/amdxdna: bound the command error payload length
  accel/amdxdna: release the chained command BO when vmap fails
  accel/amdxdna: check the command payload before using it in the exec requests

 drivers/accel/amdxdna/aie2_message.c |  5 +++--
 drivers/accel/amdxdna/amdxdna_ctx.c  | 39 ++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.51.0
