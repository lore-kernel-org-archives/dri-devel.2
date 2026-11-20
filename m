Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B543606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7KTv0YW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE19410E0E8;
	Fri, 20 Nov 2026 01:11:57 +0000 (UTC)
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5633510E0E8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:11:51 +0000 (UTC)
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3b40283c001so86564a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795137111; x=1795741911; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
 b=r7KTv0YWkvBJByEo0k85K1UGnxUCSPTUFSUxGff7czLCXH7M0LahMjJJuWN8jXHemc
 R3D0H17yk39+9h/jcA0tMvz2uQWVSX4Vn4ShAkXW7Rh2nH4YcUH8f+4hHum361f5u2sm
 AK4c94YRCt1+7tGlHTSN6xqkdgy41+nUb+ggjBWh/ofSLcBeQk/5BVKCeXSiDO7R80Et
 g1CN2dfAhln86X+x7RSlFFj6LnVyeuUCqn3ku10YVzXHBFqDigM+zh+RYSJQGMiAEW9K
 L6PXNqO5Z5AYKYhUGwIimcBNivira4kJMmH9awxHZPjYMQhzzSzBHOUa2knI266ehXie
 R3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795137111; x=1795741911;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+WauXmzgjTADvjBBTuDw9ddxWh3mS9R+yZFc6+jn+U4=;
 b=nXaQQSVjdUEcTPhtmLXtw9w6BsAuLo2Doh4eLCsuQsKX8w5wAf1PUwYh6vmXnkH7qb
 irNYnBqEQL5NQx7yUewk0y11kG0dP3oVbx/Lq0NKFzExaQEBJbhoSA0RCT/pDan0GlNX
 mNSjodsmWBZ/VBYo68Ce8jDTpxioHAL2bJ+n6yO9Evl9JAyKPx8cij+uqUirbAJWAoc9
 ORvCbpNmgldt78hvXc0rBC41pzHCN7JebUYWKBfQc/s3P9lHWvQA5Ft686OkRy+ih29F
 XxOWBwgCH3qbaGAdZ3kcrllK2Vt4F50NyjxbGMqz6hJHfdgtxHGJAPdcLEI6h6RvhEzf
 H8SA==
X-Forwarded-Encrypted: i=1;
 AL+hErGZ2UhosVG+NfzNyya1DhMgxz+SbEbWi5vA0zjs8gxAU+QC/tKK71TNPL5hgdHGxVOkwiLMEehYwGE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZSDdMloWvb9MkXGnV9Bgdhwfb4mVnEOI/hfYr0PXkKXvyJqeo
 s/3hNp9AwTMF3RpGGYdse8I0yl1NQONtwapTDOZnNVDgnjx+6xEhc6ly
X-Gm-Gg: AZFdTZdhWKjRRNiZlweDGqors6qnnvdyC40zYhAhs0uY/GusT27r4qiDkHSlZldHi1l
 LI6edSug/pzWzMEA5OMPNBjaqHm97JyMvY7apPQc1BUGJdsv/k5AogJoaQPan8HwMFmVbHfW9qY
 EXlIILRqHgTyZs7U/ZZPgOmUyUlLgykQlUkZ5WwQzrAXuzMViuVuHqdBLY5WX29IPXiIPJ2RdjJ
 GD8pxv4OL5PBhzdGFGthNME0Yaxd0N2XKFTUAoMUaiNYOKrG2nOwigjYaOihd4C6VozbY4yy7PN
 MwFpq4Ot2aGHNcy9anmPoVryMgzXkDinUr1RCGhhoA9BB1jDRHBWLftVCBGFhc6GlM//Ri/Bf9/
 0ZQzAzEs4SLU+L1SRTcP2QS06nhupqZdlFlVZ+s+G3kOCt/YOqpLWcZ7OT1MSOHZS6fMFcU6mms
 sMok67S5lU0l4/iqShUUeW0vOMnolnDNSMAB2ZWrrnCxfZS3BZC52MuzIKf2wmZSmFdDYaW4nYh
 nYRlmuQQrp4EmkybP0yOtq/xXADrPjgHk+9tVuHjR1L7tRIIzD7zmEBVwXYEPfXa7Bz4mgxIiPM
 PJwbOLhBYvv/cR2itCgTgrSQXUX9IOEumMK4+QYV9CKYRJaKqxhwjUfRQ5vMUGhdRZIJKhWm40Y
 A5ureKiADfdYK
X-Received: by 2002:a17:90b:2f8f:b0:3b3:b0f4:1bf7 with SMTP id
 98e67ed59e1d1-3b41c8d460emr1098385a91.23.1795137110648; 
 Thu, 19 Nov 2026 17:11:50 -0800 (PST)
Received: from localhost ([50.7.253.42]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 17:11:50 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH RESEND v2 0/2] HID: picolcd: Fix output-request and
 framebuffer locking
Date: Fri, 20 Nov 2026 12:05:46 +1100
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNTQvCMBBE/0rZs4tJxCCe7dWDHsVDPla7UtOSa
 BFK/7tJRS8eZ+Yxb4REkSnBthoh0sCJu5CDWlTgGhOuhOxzBiWUllIJvBtusWfXtc7joDBSouD
 xtzvya7PReuWlgPzSR7rwazac4FAf6/0Ozp8+Pe2N3KPcF9KaRGijCa4pVREt/0Uz9bXBNL0Bd
 +SW7MIAAAA=
X-Change-ID: 20261120-mail-picolcd-v2-resend-20261120-ced5a8663d10
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jiri,

Thanks for catching that. Both patch emails were line-wrapped in
transit, so I'm resending the full v2 series. The commit messages and
diffs are unchanged. I checked that a copy of patch 1/2 sent to myself
applies cleanly with git am.

This series fixes two PicoLCD locking problems. The first moves output
requests into sleepable context and serializes LED state updates. The
second breaks the last-close/deferred-worker lock dependency using a
private framebuffer update mutex.

The first patch was tested separately with the original syzkaller C
reproducer and bounded concurrent sysfs/UHID-destroy workloads on
PREEMPT_RT. The complete series additionally passed repeated framebuffer
open/write/close and persistent-open framebuffer tests. Pre-fix modules
reproduced the respective failures. Physical hardware, prolonged stress
and suspend/resume have not been tested.

Patch 2's Fixes tag identifies the fbdev change that began draining
deferred work from fb_release() while holding info->lock. Patch 1's Fixes
tag was checked against the upstream transport-conversion diff.

Changes in v2:
- Address Sebastian Andrzej Siewior's feedback: clarify that the issue
  is not specific to PREEMPT_RT and identify picolcd_data::lock as a
  spinlock_t in patch 1. The code changes are identical to v1.

Helge acked patch 2/2 in the original thread.
https://lore.kernel.org/linux-input/CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=
=3DxkA9acsL9TSQ@mail.gmail.com/

Thanks,
Aveline Noir

Aveline Noir (2):
  HID: picolcd: Move output requests out of spinlocked sections
  HID: picolcd: Avoid framebuffer last-close deadlock

 drivers/hid/hid-picolcd.h           |  4 +++
 drivers/hid/hid-picolcd_backlight.c |  7 ++--
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++---------
 drivers/hid/hid-picolcd_fb.c        | 56 ++++++++++++++++++-----------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++--
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++-------
 6 files changed, 93 insertions(+), 58 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
--=20
2.55.0
