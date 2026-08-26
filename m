Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA657C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE1C10E2D7;
	Wed, 26 Aug 2026 15:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="WKpYPsQQ";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE22110E2D7
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:31:41 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=rFNKCIhQ4VcG9T6ci0naAu1pR7jl0/N6DN+C1dnaMsU=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787758299; v=1; x=1788363099;
 b=WKpYPsQQIXEvSVp0pVIXWsVx4iPiAho3ujUE9RUCIbya6l+M6wqD50XI9plDVuc5Z0tbLuBS
 fLy2alDk368QKjqzAORezxzoB/92LZ3T8ZfOwFctTiIxxBTfoGduGcV8ZjHcLBInOgFbg/0PP2e
 SWnujc4upEHxhVXf7jrkdLmWGwHDX3N+RPlzIPwXBEpdRSGDMGlZc0G8bwiOgLmNOg6pM+blSCt
 5E+K0ENLL9y0khOSdQc4+2dvpTDvsI9lAYdkzBVelnr4Xi2KxX0RpElfuB5QT+xzGzIXH5G15q4
 UqpaXXGbSGomTDYfnzRagIndoqZDe+Vi36I7zQSe4R1mQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id b98e648421838884;
 Wed, 26 Aug 2026 15:31:29 +0000
X-Mizu-Trace-ID: b98e648421838884
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] accel/amdxdna: make the shared command header safe to
 read
Date: Wed, 26 Aug 2026 18:31:19 +0300
Message-ID: <20260826153121.133507-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143036.100089-1-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The command header lives in a BO user space keeps mapped, and the driver both
re-reads it on every accessor call and read-modify-writes it in place.

Sent as a series rather than two standalone patches: they touch the same
function and do not apply independently.

v2: READ_ONCE() on cc->command_count in amdxdna_cmd_get_chain().

Taimuraz Kaitmazov (2):
  accel/amdxdna: check the command chain payload before using it
  accel/amdxdna: use READ_ONCE/WRITE_ONCE on the command header

 drivers/accel/amdxdna/amdxdna_ctx.c | 65 +++++++++++++++++++++--------
 drivers/accel/amdxdna/amdxdna_ctx.h | 13 ++++--
 2 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.55.0

