Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF3606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JmB6Smbf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CE310E593;
	Mon,  2 Nov 2026 08:03:43 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F4A10E593
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:03:36 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so17828425ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606616; x=1794211416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ULB0fdcScE3pyVzoGp78pW1Fsjx9L22KYr7UY+zqZWE=;
 b=JmB6Smbfkmv20y97j6dZ8SOcx8a1PwUn4xaUhSdlwZWKP3PP9I8//Zu0SYYfex8EAc
 rmc/+DSkpiycIWqLzfUYLGy2HP8uZO6oE8ylth86/bKxpipvOOnA5YLFAuH9bxR7mtwC
 iFaQRuT/JwjXCr+WUIgbNuSHyfWAGXaIkoZt8urcYwpnqilj/3lez12hAOTsvgf0c0W6
 u8H/W1ZVbgLEKggyPcNAq3nCHb/UxqsnvFifA2QKHTONi8eMiO5gtArl8ON/d9IqsktS
 yLwBmBb6s20LSa5uoYJVmuAoR4ChZlJh4cRy+1fDB/v88QNWoxH2jaP7tAqLIdY84qOp
 1WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606616; x=1794211416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULB0fdcScE3pyVzoGp78pW1Fsjx9L22KYr7UY+zqZWE=;
 b=cbrgGiEnjwfTkCkyVEA5CfKhvDqf+nD8kkYukgzvnJhudtbamlLqOuFIWWwkyIU/h0
 cA+9eMaOZYB2SiLLCUTN79uLy2JDWYs5K1EkuJYMBymzJcLj4+Hpxw8ZeBtAclw3upPx
 pfUWda4PZyhgjROJAluCWKnDrFJpYm8hLlGzlHq6O3AEzb9KW7jLXKIb5HjHGMpNF9cu
 UXGPTxIHKKs69AWUiP12Ggwqy8VFZ04XA8B85Z+W7wf2wM2KydFquK91IGBESNR7AoDs
 j/rEqRsSWLadv3l0hcPe7msNh/F2BODh9LtnZ9HACDQ3wMMtfusDWw1m7N5cJOyp5oPI
 YbKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd6FbMkoYB+ps/R4mGyo3GlfSMqVLtEfF1+vYf24qMRTfUCQoT3ZDbOc/F1tPiFYObjLFaU/FdBkM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BOkifWsn7dbemzxhyLYjTxKV49gXyGAWfYj2YcfGU6mi5i96p
 ra+neh1FSry4XODe8J4T1RWbrRKly/3PZ6uwqjx2EQ7zXepgjXzdjf+v
X-Gm-Gg: AYBFou3o6WidfQJq638t0YZKg4Zge6esWFQ03CZY8zvXlrjnwOHQQfFqezxreStUj4g
 r1Hfb8jBlOUZZTkLh/g+9KMM2vfnkBZMtuMwtGOZkF9X1UXoGGx6QjWdctdyWv7Fofzp1+GMcpW
 //XoF+h2tT9Uo2W2GBhO5fD7dq4Ld5XXIPMH1nnzrLHIKwFAYRn0JOjfoU24+QcRjJhfreGvw+g
 F7aWn3T6RYNc6M6cqSc7ahjlKnY127iECa+sdO5xUR/e5USeuo4ZcgMf/1rqOdr2SYSEuGdcb9x
 2hU5cvNfTp/Xuv14WSnTp00c+JYNYMUUmV9LJJKWb7fwCyvK/NFOSuUEAhL/ll6pAMS5f0mlgmy
 gFat6XNqVFpek7u/kBvWQobqKt/DZMjqMi07oJv2dpNVGZORBtddQfpU5RGMvhKtqwg0wVn0UGk
 6pkh3UFrGEIKZ5gXPHMPgHVQwYPXN1NkrpXO0trvsoMJj2jeb0o6jZwsHCDOAYixmJHmhI+c6u5
 vdoJQiQow+VYuzZMXVbV4o3n+NSG4wxhCWcyrRiQTTHxca6NyJcemb0/sDauMH0zhn6dN23WWhq
 nrJRdpn+1evt9HN8gileOYLN/hpT8Wg92BlZSY2cTRRXC4DVEUWMVf9Zbb7LgWmX8Y/ZylCO9vf
 t1LCc1OCxiuhV+zQoIXEvJUxvQ0xZhphY1XM5ZeOYXcCYCKDfa6D38AfZfsDup9wNKzmclDOl1J
 7sb1k3W9nwNHfB1g==
X-Received: by 2002:a17:903:984:b0:2e5:cd0f:518f with SMTP id
 d9443c01a7336-2eb1a57e22bmr78324565ad.0.1793606616223; 
 Mon, 02 Nov 2026 00:03:36 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:03:35 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fbdev: pxafb: fix teardown and early-interrupt
 lifetimes
Date: Mon,  2 Nov 2026 16:03:29 +0800
Message-ID: <20261102080332.1466689-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three lifetime fixes for problems Sashiko, the AI review bot, pointed
out while reviewing a pxafb cleanup [1].  Removal leaves the cpufreq
notifier registered on freed memory and the smart-panel thread running,
and the interrupt handler can signal completions before probe has
initialised them.

v2: v1 went out before it was ready, as separate patches without my
Signed-off-by or Fixes tags, and the completion patch depended on the
others without saying so; sorry about that.  This version adds the tags,
sends the patches as a series, and says in each commit message what goes
wrong and how it is reached.  The notifier fix is now a patch of its
own, and the smart-panel patch stops the thread after the controller is
disabled and no longer changes the thread's freezer loop.  Patch 3 is
unchanged.

I have dropped "fbdev: pxafb: preserve IRQ probe errors".  On the
in-tree PXA platforms the interrupt controller is registered from
init_IRQ(), before any driver probes, so I could not find a way for
platform_get_irq() to return -EPROBE_DEFER here, and the patch changed
nothing users would see.

[1] https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/

v1 of patches 1 and 2 ("stop smart-panel thread and notifier"):
https://lore.kernel.org/all/20261031033248.2491098-1-matthias.goergens@gmail.com/
v1 of patch 3:
https://lore.kernel.org/all/20261031003424.1796478-1-matthias.goergens@gmail.com/
v1 of the dropped patch:
https://lore.kernel.org/all/20261031033236.2490968-1-matthias.goergens@gmail.com/

Thanks,
Matthias

Matthias Goergens (3):
  fbdev: pxafb: unregister cpufreq notifier on removal
  fbdev: pxafb: stop the smart-panel thread
  fbdev: pxafb: initialize IRQ completions before requesting IRQ

 drivers/video/fbdev/pxafb.c | 46 +++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0

