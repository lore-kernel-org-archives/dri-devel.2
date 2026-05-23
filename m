Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA8CD5BC7
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D8F10E3F3;
	Mon, 25 May 2026 06:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="juYNsvJ2";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0BF10E0C4
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 19:10:51 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so5037474a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779563451; x=1780168251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2pdcMudAXsnsf14xcsIygiiXlNDoLkCiV99tMYt+d3Q=;
 b=juYNsvJ2q4h6VWG2Q2qtDW25/WNo5s4cbBnv6pXRf9DjS18A8QByAwb+tqnbL0lOyI
 K7A3LWDQXkASy3f1UUVPU1e1srwMOADJ7Kw3jACbM+tk9Vp9V298SZ8wJSvnnIf9eLPG
 rvjKwewb0pKsTWnFmIH4kCx4AlLxX+wMlN252NxmfE0KoDz9XHlWNMTKjevEmg86kIfL
 GzRQ64q0o+PlmPx5LE/mZ4sv7SG+Y3pneaboMfBrhvwh1PBFt+qYjjWpfF+3ZDSbARbs
 /9T0/b2i3OhJo4iTFmykoaAkaGC19VDXStyyZnIhXbfTqPm4UFg661f1JLwKOdriDZuH
 /jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779563451; x=1780168251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pdcMudAXsnsf14xcsIygiiXlNDoLkCiV99tMYt+d3Q=;
 b=oPo8pzpPGQLZ+fUK8T9pZLDkV88gVM/+KgmEWHSpA6tZQJw9wy/5gG2Updf3YxwEzt
 v4N1toMaGBKqHKgw73bMUanuYwb/SYZZudD3O9womI1yZ1bIAOSSa2eYqEU6S/LnRsio
 XjxR9gDvCNegtLJXR73b0BWpXqT/RCxZvtbtrnwWyQ+grADSRN+KagDmAOXTUVQ5zZy1
 +Af6C50L1GpGWGiIvTYURkR5HHKO9661L734M78Kw/VKzEYsmyKTImmmnR7owSWSb3Xb
 BsXjidQqCdYGjufnVUbsigx9I2uPGh7Byz+NcVp1x3Qw+J9TCeXmTkZLYGN8SvTFABuZ
 xZFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8S2h2GYnkxjd7mbEPmo+m5MdVpuRd4Lt/zar86TXr9wR54yUbBKua3uvddGPSLScpb50SjHr3V3po=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkNcfX8C7ozGX2GHPHmLyxFZyAjEZsaKreKXpu9y0zGnx0D93N
 E7emeN0Yzu4Ntm8+XGuZuL80fOYW7edoTpMKiQ4UCbeOozm1b1DXpw6F
X-Gm-Gg: Acq92OGE6OLmpfx+Ty9N+8vn0DAdVVwA6RLrIR/GzikNrSyPDnOr+kMVLiCPDliqMEr
 PTvu4EE7yYEK6RZwBeP5/P1uYt491xFKuE5TzSyFtN9n1OkgqT+fk/r9m9LWPWOMmd73w05s3VS
 BHW6fv18q+9q5fEWnqfRXNjkj30QpHwz3nUIIQznwksaasVUfQb5r8uMw9bKuCbuYlOH0SR9rqj
 ghTVyWcxVm8NUX1nNQeNDX98l0zz2Hx0yfE1okMXJJmFb4ARWLJvUAfUV/JdYK47xOsfrNyL3iI
 AQUhel9uO0VqX7+vMc6L5Qyq1ms1KldX74K0RupPClzRGBNdaMzqxfPTSj0nO9vRN/vXx7RC6A8
 OscMUwwaXSglQswnCkZwSGu0DhLwUknzI/C+5M+6w14E5RhqNE2GzGPRI2g9r8bqOd7Hx2OZt5E
 yimG1Q2DUfI3IBHcZbCFKacdAhzeWaSSSzoifLqc4AV+/AmgGJ0D67g+ntsR1s5xe6B1vGGdirC
 5ev0I5L26bMjzckLkMF4wCWj7GlT7wWFC29ycdxjMsCAePbViDfGvuBHcCta2rY24fKEhqXMAvB
 u2TZiDm6tk0=
X-Received: by 2002:a17:90b:3dcd:b0:35f:bfdd:f5a1 with SMTP id
 98e67ed59e1d1-36a677fd1ebmr7791851a91.13.1779563450705; 
 Sat, 23 May 2026 12:10:50 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6f0baca7sm3151877a91.2.2026.05.23.12.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:10:50 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix OOB write in
 ethosu_gem_cmdstream_copy_and_validate()
Date: Sat, 23 May 2026 19:08:43 +0000
Message-ID: <20260523190843.33977-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

The command stream parsing loop increments the index variable a second
time when a 64-bit command word is encountered (bit 14 set), but does
not re-check the loop bound before writing the second word:

    for (i = 0; i < size / 4; i++) {
        bocmds[i] = cmds[0];
        if (cmd & 0x4000) {
            i++;
            bocmds[i] = cmds[1];   /* unchecked */
        }
    }

The buffer bocmds is backed by a DMA allocation of exactly size bytes
from drm_gem_dma_create(ddev, size), giving valid indices [0, size/4-1].

When i == size/4 - 1 on entry to an iteration and bit 14 of cmds[0] is
set, bocmds[size/4-1] is written in bounds, i is then incremented to
size/4, and bocmds[size/4] writes four bytes past the end of the
allocation.

Userspace controls both the buffer contents and the size argument via
the ioctl, making this a userspace-triggerable heap out-of-bounds write.

Fix by checking the incremented index against the buffer bound before
the second write and returning -EINVAL if the buffer is too small to
contain the extended command.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 7994e7073903..f526f4aedffd 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -387,6 +387,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return -EFAULT;
 
 			i++;
+			if (i >= size / 4)
+				return -EINVAL;
 			bocmds[i] = cmds[1];
 			addr = cmd_to_addr(cmds);
 		}
-- 
2.53.0

