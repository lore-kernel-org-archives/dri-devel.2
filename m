Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B60C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2771310E104;
	Tue,  4 Aug 2026 04:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="HdNkN3zf";
	dkim-atps=neutral
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B3F10E104
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:11:00 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785766400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mqR5JAZWbOvYHiaMBBemW1T1cBzfdsuj4QUZOW2/5Ew=;
 b=HdNkN3zfLY2/9piCOyhCP1sA+0oU+/i+Iuq4O0lrnfNlojBq2f1KUgZttW+5Unj+tNRpta
 v0AOuxHTgzLdvNwtaPjiY7Mn2e/PtgSiXmoIuUGgOWqzIn9ByZzzdWlWWvyqU1XANT3Q64
 h33V6cQR0m022Wfhkkyec/e/Ls/bEcE=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v2 0/3] backlight: aw99706: DT parsing and blank state fixes
Date: Mon,  3 Aug 2026 07:13:07 -0700
Message-ID: <20260803141310.1379194-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

The driver reads its tuning properties under names the binding does not
define (patch 1), the NULL-table lookup path accepts any value without
range checking (patch 2), and update_status() ignores the blank state,
leaving bl_power inoperative (patch 3).

v2:
- add patch 3
- add stable tag to patch 1
v1: https://lore.kernel.org/all/20260701133918.33487-1-junjie.cao@linux.dev/

Junjie Cao (3):
  backlight: aw99706: Fix DT property names to match binding
  backlight: aw99706: Validate all DT property values consistently
  backlight: aw99706: Honor the core blank state in update_status()

 drivers/video/backlight/aw99706.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.43.0

