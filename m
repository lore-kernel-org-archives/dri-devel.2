Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73152CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C828510E04A;
	Mon, 25 May 2026 06:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBhAsHlR";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE5610E31C
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 21:09:27 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-83f674f978fso3110861b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779570567; x=1780175367; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NOrc7TUYA1VZjAj3FpFbAmZl2qMxqvGuE8h2aBD3LuU=;
 b=IBhAsHlRwHiIe2/tAdusq517Wt2sBnXilBx2m6V51AxkgGdIRnuVUwNl46vBNWHK0i
 tVtUaZCQrxXcb4z05hp8AAUyJWr41QV60roQvAxtxbwo1vNem1WvQy8A8glOGyLAOEb0
 ECb4GnW0izupXKwfnu0Cc7g3lOCMedVLv1hcsCYW3t0NcAposzDLyUTj2V3CxMu6+Lwz
 FBfLR7cBMEJeC7sE+N2aeL2dWsK55ujpoiEkYbj28lKN3DfQ44YcUcqMe3joZ7SfB8Me
 DTTlmI5HRimM9WAH58nKSEBGgGIpSl67OF4BGb3BlwcxuneiEvZSQ2z1/Y+QFaSfAK7b
 QyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779570567; x=1780175367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOrc7TUYA1VZjAj3FpFbAmZl2qMxqvGuE8h2aBD3LuU=;
 b=KEaBrtE0XeTgdHTG0l+x+SEt6QWjmIRksyyi2SuX9OGR2WQIBFDojfPu8g/K2YpBxi
 GLO1YVOHOt+XtnmuHNRnzUPsDpPfYLg7Ub5ir7uwsmQe6a9Qfu2JKsmZPHn8nXDsNbW8
 QPP9rLtzIz/nNxiFrGffCBV72l8TlkO69rLGTz6SJGCB9OY+sMSp/1OyJxynxDqbDsSI
 HMpXSqspwPzYzrVlz6uqsOQhRrY5RqauQAK4VG79ta7SQHCrw51EKIjN6lW6vtidHgt9
 Rp7kNfJsGQTwYz0v7HQNEVSdt/5QVseEhQ8kKgfqJvwOSn1Y+3mWCFBw6q0o22tEEDVl
 iRSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IobdHOhfPuJl2YOwHbXpMFyDGenb3FwR+ImjOmOIUnG4JAIeGOemkYFdnJZD5a8i7S8vwkipEcQQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWNUfnSIXQjkB+L26y0ZslnpDA/XG8l7nfEai87sbML5/3Q4eP
 qX09wXsqqLE0s2xfovjWFXoM53689ZnvR1KRdHgUVdEEh9rMEjNUEeY9
X-Gm-Gg: Acq92OFsU82pEshg/AGk9XeGi+MKpIimNyDzl8KmAs+uL/S8barFYqZQbLRoNuheXXI
 74j8sq1rXo9/dYpnFVQmlFkM/jo+gbkX39Z3Pxn7f+A2yt1+Usnr1I0EOrMmN1zbBTHF3AWEBol
 Pw7DaYs6/nDBd2ECBpTR2w6m98u9D2fyeW39KXv+qTttsbOn2+kxi4ANZ7GOqx8Gts+WVSE4bVi
 Mw4I737PQbtEUrZGsN5JzOLUYgZrY2IprI7AUj1zmNR4bwzmNWApesoOwDAIn6CA0wPEgcXJhZi
 +8LJGzMq0e9iGs5QkLqfIuOC6dTxzoZorN4ulbed+DcxlPG049CYH+AtD3I1SAHXCKPK/zyZOng
 3LCjGRCHj5Fix/Qnd6yA7VYA4Alzms08qC4S2DIA30anwT+lXk6tNZtaOMulzTs1y7yTz+w+GS0
 FEeqZJ4Cj+hqQ5MbznV1xNu5k4/OOSyD4BbEqOAakfyu2ve9V8kwR22TgdCsIumge+ZjiBVVhDG
 Bref7ACbPSQglO1TLHSaxrMHXuMmpl36OHyUMHZjyDJgwhFE9p1muZkWreE4Ya1W0u5iz3GQXPb
 kCQrg8wmN3bMbBNmCHXvWA==
X-Received: by 2002:a05:6a00:1f11:b0:82f:d34c:ccc6 with SMTP id
 d2e1a72fcca58-8415f1e0b31mr7824111b3a.10.1779570566997; 
 Sat, 23 May 2026 14:09:26 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.195]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 14:09:25 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, tzimmermann@suse.de,
 Frank.Li@nxp.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 0/2] accel/ethosu: fix two command stream parser bugs
Date: Sat, 23 May 2026 21:07:51 +0000
Message-ID: <20260523210840.92039-1-meatuni001@gmail.com>
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

While investigating the IFM region index out-of-bounds fix already sent
[1], two additional bugs were found in the same command stream parser
function ethosu_gem_cmdstream_copy_and_validate():

Patch 1: NPU_OP_RESIZE unconditionally triggers WARN_ON(1), allowing
any unprivileged user with DRM device access to spam the kernel log or
panic the kernel if panic_on_warn is set.

Patch 2: NPU_SET_SCALE1_LENGTH on U85 hardware assigns the user-supplied
length to weight[1] instead of weight[2], mismatching its BASE handler
and corrupting the software bounds-check state for both weight buffers.

Both fixes apply cleanly on top of the IFM patch and target the same
Fixes: tag since all three bugs originate in the same commit.

[1] <20260523195159.55801-1-meatuni001@gmail.com>

Muhammad Bilal (2):
  accel/ethosu: reject NPU_OP_RESIZE commands from userspace
  accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85

 drivers/accel/ethosu/ethosu_gem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.53.0

