Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D1ACA5FB3
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A38C10ED8B;
	Tue, 29 Sep 2026 08:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLAgRZXV";
	dkim-atps=neutral
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com
 [74.125.231.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511BB10EA2E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:46:49 +0000 (UTC)
Received: by mail-oi2-f11.google.com with SMTP id
 5614622812f47-4c112aaaee4so199668b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596008; cv=none;
 d=google.com; s=arc-20260327;
 b=h/8TUTS6H9FQGKnG/5FCVcFfU2pwD+E8hXOn7dhUfrbDRRPBc6cIFpO6XvhY/miOdj
 uXItljElkt+KO5ss4XkeH9zdy3/S6ebDZPkgnNxI5YIithseem2lMccOgVcLNM1mhNe8
 MCgkpj2Vr2ZXO1WEj/URjS527JliJ4GxSkd0z4EfPiDlXckkn2JDfYfg206FkgX+7oM0
 QbO0P1qcFCweCAEijcgsBRVwe9Tw5cQ9rUtN9iWP8eHRm+pVU+9MVMb+tMNN6Q4UXSrj
 6rIjbaJCvnfL4W53BZwie9wjGDXtteg60i9NA75QIT44dBRVrByUoGhE+dJVgrCV6ZmV
 zwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
 fh=lCGPIwztGU3T44xy9/76ntEqutSXiWLUZEPw+O3qGcQ=;
 b=bkelpLACtDN3zjUZt0aiZYJ5QJ4+OgoLfKEVlsUDVyYcbZChfbCkvFUtb5CTLTmF/U
 sIUyxJ1HJVdFxFBDWZvh3F9bmYtVwQ+K1/1wiPcRdYUtUhCW/WlXMvJ4QvXvFt+ferwJ
 C1pV60dEG0mh5hWFYmvxke1F1Uzl59iz8q3IfIYXH92GT1swN25AdoUo8+VMoN9x8LgE
 EsxTA7ATHU6tPizqJvmlRP5gocZMwW9FwfjbICdb3p+IGcdPSeyPDhePahfO+RxOW7X2
 9NCUJ8w5StGrValKMWLG67jBZBYyzFrN/G7ouFogDPaHHGFhG5/rYxiz42B7JCeqZ2l1
 7xpw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790596008; x=1791200808; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
 b=PLAgRZXVZ3TBgpfFdWL84t5iHAWs+2ykJpBf/qH/1ueYhOjunkVQ3CMuOX/c/L9Kna
 cOwKDTFVJyus8uzaQSvDwnI5RBhncBlkitd56UlgOpPuPHI7N8vXYnv7siGQUFM9AOBj
 Z7AbKHl7mroeWG2FOj2BvvqATvmLY7TlUsofN2nbjb/7yRr+3jpyp/38ZgNBzHfYa4dU
 uKm0nFggBkSYdJxircwtlChzrChQKdh1sxSOW9mlI0QF/TW495RM7O2DARsPYINgjqVR
 V3zhtEMN2OT8Ru2VLOOTJxqai/KAoIbQA8tk6fEx/c2KV20oGrU0p6E84RzHaJMzMSHQ
 4RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596008; x=1791200808;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8y/14vF+O1HeqA5emJg88NL5DefW60ELONqq7Ew71Mg=;
 b=AcVTOQnYs2iSaH8iCYKX3mDBEx038qOQgAQAvw9noTS0mPsCUntls0s/1rihqOeXfC
 L8BqW/YQ53gyqG7qmMa9O3bpDs5IY1g+ciPfRhq3MZu37O5w2Atc7VyO+/3Is7qMgSdN
 RjJFJ18fjx/jP8V9uZ0xoc5qIDTwZ2r1l99zzApt1cWPuSuxFgavEDK0+tJqpCnV5OcS
 lRiUOI/9Mkho/OlcFw0wQ9CdWYl+a1rHor6JR4NFtSnAa2IaB4ZPSitX5ZZz/se8+i0x
 pGgc8TtXHhUkS7DQhzbFMrO/M81PpAEQyQJCT0FVib+OEZt54UihVhA19kchV+Cl09sl
 jOZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBya2G1sCD9/f1Ff2RZj+ENobybCR4NCd+JZT9nxXbQieMJalZeO3A5K1HdUMwvgmdWFxzzJStxTa1E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kuW70tVbWrUU0M3s5KaRsNX9ACBhrla2iMII+g39aAPSUjxZ8M
 OmGIcaOrELQRP6J+Z9qFrr8rR6u3dPYXbuy20XHxsQSZR/zoj7lhpk+oCKWLD6aCMbue2Dn5Sk+
 vPzpABbg0Oc1ljcQSlcp6L8cbVHLWhqs=
X-Gm-Gg: AYBFou3v0NOPbGvpetaRGiKb6w5zhL2WhthBzyp25MW8nSQSQOt+siTCPTECAWdhC9j
 d4RvFrG5jL2zIHE70mzSgr7zv97n8iB6yP+sdPkcZAIi6cEGAV6GuLHGOj1EMPuF76ak3kPA3gJ
 Nqy74h/hWP1wDzppdxUOt8Ok4Hqi8qgZbZNgH+PwKTjmVUMNQ//qSOEpQWpukUnXdNaTfTUcxM1
 La3iUb9r+zkQISurwJ8VwxThIXj3CNhbMUwkBj+jreGsare/4bJ5r1eoW97Qt7huXTO8R0IhKB/
 rOqCXstFsCRzEQiVVQUA19Qn8PTse9bIEKaZlwas47RNPZ4bHRC2L8h2MfZD5qxW4CbXIShxOvB
 PXTgnCyAKzQ==
X-Received: by 2002:a05:6808:bcc:b0:4b3:7da2:f393 with SMTP id
 5614622812f47-4d72c636b6cmr12794285b6e.15.1790596008135; Mon, 28 Sep 2026
 04:46:48 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:47 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:47 +0200
X-Gm-Features: AclHuK8vvWWUjI-1FK5rP_VlhGDEQ4c_Oaxo0Aq7l7qcc2S08USGBF3bm-pvFn0
Message-ID: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
Subject: [PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
 linux-rt-devel@lists.linux.dev, deller@gmx.de, simona@ffwll.ch, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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
-- 
2.55.0
