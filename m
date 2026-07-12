Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6A6C44501
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 16:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2E410E093;
	Sun, 12 Jul 2026 16:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W8mwYIfb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD9C10E093;
 Sun, 12 Jul 2026 16:14:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D67A600AE;
 Sun, 12 Jul 2026 16:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E911F000E9;
 Sun, 12 Jul 2026 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783872876;
 bh=LVt/07JkeRUrRXhGR7j99ZsCFUAQhYPRKJkbnlsLIrs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W8mwYIfbjtGapNHEG8qUgFHP5kTfriyYRZS4922cMWclWw639zwyMtbHigRl/JRO5
 0yJB0WgYukQXCoMI5E2P4e0NNIorrkKG7WYM+VQtVDmVPI2Rp/1/dF+1C1rLdfIaqq
 JNkXeZxHoHhB+dvWpOQ4LGUpUAxy4SlPCc8wVLpaOPtEBns6Y1mzvMGFU2Qq5FOzN7
 GVgL5yOy+sJlVb+aVln3j7pwmLrhJrMy6Y3KH5estk9MaU3kAMaz47R9HQZvtdFDxi
 ZeQE6x2kEtdmZ4u/kZ+bEsXe3jtBNsY/6s1Qb3FIRSOYn5sWJq2oBeBdoDfOiFXiy7
 2HLzTvM7vBWPw==
From: Danilo Krummrich <dakr@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dakr@kernel.org
Subject: Re: [PATCH] nouveau/instmem: use iomapping interface for instmem
 handling (v3)
Date: Sun, 12 Jul 2026 18:14:26 +0200
Message-ID: <20260712161426.6461-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706030520.857104-1-airlied@gmail.com>
References: <20260706030520.857104-1-airlied@gmail.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon,  6 Jul 2026 13:05:20 +1000, Dave Airlie wrote:
> [PATCH] nouveau/instmem: use iomapping interface for instmem handling (v3)

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] nouveau/instmem: use iomapping interface for instmem handling
      commit: 34e27b90552a

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
