Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15EEC61DD4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E672410F29E;
	Fri, 28 Aug 2026 07:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=berkeley.edu header.i=@berkeley.edu header.b="m2rWaqw+";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E0210F242
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:35:44 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d7195706f1so7189145ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895344; cv=none;
 d=google.com; s=arc-20260327;
 b=A/Zk001JPdNLDcsKJxNPAajyU5KPncNNEjSdU/Yn8KlKmzr8UvyaX/wXbyW50RRxme
 M/KlUKA24TghuKIMZouuotHccffJSpDGqSC7tC96Xhew/4H7Ssotf0zUN10ye7amV9MC
 EqqAWl/oDm/1uDZ1E4i4TAxrc8D4Zl6KE70kC8zUKFjCiIRDtvGPGurSVFbsUVVFGAoE
 tcTYGfdJFEOtQdEZTM9Xb0t/ymG1vGV9Xnp86+fje4O7OEbgLm8MQYW3SNB6UpR5Ag+5
 M056LCDnxapTRU5V8bl7XWvefF/ptX/MequaxzqVTdaP9uNpjRQLpVo4r69BEK57k+P8
 zpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
 fh=Kui+cjWtKAxKuayRksXnrDZ/69VL1T/kRdYqbkSTs6M=;
 b=c3Rhmo7F/+sD4KveClgA0obaP2k6XqOOErDLFNZggzHStejm9u3fwfMQn3203FLajY
 yJetaDbB9QNbPghPbAq4LLsjG/1CbxNhMs6G1tivM0JroNMU+2cVfto/gt/bB9V4kQ2Z
 0A3ZMq69NXOTLeO7HaYKYCP/aEbCWcVElD6BacYvfhg0llKS8sZVXfkEMtYkvoMSKL7b
 lHc2rldbIS+09c5WcIEwoe6cYlME2YQnNNQSWuyh3xiXkU8NZE/SyFxpgLZeBbELFwQS
 2lR2ZQVr3AbZaJNkzDU5xjgC4Mx9rYxLq364Ehb2NC2OfdefoIfuhl3h/oLRzh6gIIwR
 dTpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley.edu; s=google; t=1787895344; x=1788500144;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
 b=m2rWaqw+29Xn+KuW94xajusTKzLZ+wTLjs5tNPKgvyQXIsGz00nPriZQhCq/EkU++z
 TSAnIjexCkZfHzqgOwB2td2eZHeAiYIWqjmUiah599s1+mYA1ZagchF+0fcL4NDjjufe
 D7cdxWoUUbwhtLPI3MGkkeN/INn48NXgstHus7K+YytrOQHCOGMMKJpLwq1+YqS0TEYT
 NBefX7hm9TAY7i/moAWa8AzWK9fVZBsDSVreWI/bSFcNTAsWNzMnFkJKMl0FxCzLDv6T
 RqbT4NEtIC6DwslhLadNQLuqXtBWSGizPRs0Ld8b6UtUrqelenZ3Gl6ePunAZgPvSi2C
 BBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787895344; x=1788500144;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LT4To0OsjX1/jK+rL4EorTsovtuZzKeOb1eHUmWtFGk=;
 b=YDQ1k5QpTHAWpBc8E8A1hbjqnNCo8pvNwpik1icqQLMx9E4X9Z7d2X1hjD92MHxkTe
 geLNMsYpiioJbLdJImMYMG62mXVFtCTPipFXIJwuZnO3OQD7kAxxZ8eZW+bqz3jGk4hg
 /j3uHnlJ6o0/1RyI2WD4mTR91Zq3uARxWo67ZYPmohBfomkgTJ/2nZUm+DQAtpiM4aBS
 7kJXoO4iBKA0Rw7ki42FfsCkVLoXxqjDr2JZO6TYMFL1NM5dpVQCgCy4HKYLZKBqVD9R
 ZPXUi8gh7f9FIDpde2XaiqX+PC93zS2P2Ps84PiK9mIUWnH0DuNKebGcFnExBnCCXybC
 4Q7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD+Xeq+7ifjQylD+jn0aHo1S6oOmEosMCgJQuB5XnxeKIFbjOiZgqQIlxdLzcoKCZc/m4vKc6ebj8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l01ZbltScyYEp5WyVKSJSzmEZFcmfy69NB40IuMdsrRBpODHlt
 Skjo+7naGzHipwtR0qUgvo7fnBxmWp3zbP063IeYiDL/UitLtdVrdzrAp+JoyI7IGYO2L74uSWE
 EsRYhPlm5jueBilUsT620zswu6HHZcVA3z2zHiqOG
X-Gm-Gg: AR+sD13ahlHprw2iuv5+L6PyFE4caOZc2M7TS8hJearbNTTJnLNtmquXIpaGqTUSgvw
 mcjH0fCuX0emIX2USGNkT7RnttMHpZI3KwpdV8cjmmzUzQu5Z03TvCVHfQ9p3KtvG8A8y2tpNCz
 U9j2TLaTc8DhI9t9s3iPToA7r3ZtmBhilmqKlMVbdihE3usZ8bR1mxqMdONUt4nM7b9WMeP+AR8
 +1IXMvwruuL9ICskZdmEsvE36Is1jkhretGiReiBwh71MQmWNB5XBfMl65clFEEooLLFA3COCtC
 a0gc81iEt7yDVyT5X0M+ZmrNRqs6cEX/e7T4PjAFZ+wvc3aD5kXYdmJN24WGpfu4prEmEBx1ypT
 52G5/JdnskfkF+pmb8wMUgAnu7guhZu2b
X-Received: by 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id
 d9443c01a7336-2d74dc111bcmr73203035ad.3.1787895343268; Thu, 27 Aug 2026
 22:35:43 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:35:42 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:35:41 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:35:41 -0700
X-Gm-Features: AcwNN1VyngbgcKs50N3MJkg3MeaR66VvRj9F8NMxHZOvLMicNByVpJwrJCJE87E
Message-ID: <CA+0ovCgxQ3_H-5BWXLR_o=AG8EJ_bofmx_E07VazDm44KiZKgA@mail.gmail.com>
Subject: [BUG] vga16fb_probe -- KASAN slab-out-of-bounds reading platform_data
To: Helge Deller <deller@gmx.de>
Cc: falemi@asu.edu, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/151-fbdev-vga16fb-vesafb-efifb-platdata-size-check/

  BUG: KASAN: slab-out-of-bounds in vga16fb_probe+0x828/0x9e0
  Read of size 1 at addr ffff888105ba2dcf by task repro/9494
  Call Trace:
   vga16fb_probe+0x828/0x9e0
   platform_probe+0xf9/0x190
   really_probe+0x267/0xaf0
   __driver_probe_device+0x1e2/0x350
   device_driver_attach+0xe0/0x1d0
   bind_store+0x1d0/0x220
   kernfs_fop_write_iter+0x3af/0x540
   vfs_write+0x61d/0xb90
   ksys_write+0x150/0x270

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
