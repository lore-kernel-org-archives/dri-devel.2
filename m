Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0DC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653C910E8F1;
	Tue, 28 Jul 2026 13:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QoKL9wF/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED4910E591
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ggkDTS25iVuQ4Vu8Dt4p0Ph4mLlzKM9jCStFhPHliQQ=; b=QoKL9wF/N842rV3nGI5NsLggYe
 61+oVm2RKiw/chtu3p5xPd7QuSGfxZmaTAp4HxqTFtrij8LtVhjOF41ZAH71zTR7N6hrerHf6d4en
 h+BM3Lkqxhw3SqTjsTHIi/Rt8g91oCWUbgMiB1IGHhxl2Tt4+0xxlcukBWDkX4ppn9WTFp6o+7H3N
 CvxYS64l/fjH4710FCPbIF4b+TVV9h0h2rjmNzbvZJFWEmnSTn/qQn2yXZVwbvYK9a6gL0MTCJ5O4
 2b2s2TjViPclXZznyOoIHxI8TLZpzOndYibFpIXZesVBqrGZMK2Z1qq3B0GV06bVumD37btIA1SFU
 kOZ4KYwA==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wohZL-006zoL-UI; Tue, 28 Jul 2026 15:10:04 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/2] drm/vc4: Fix binner overflow-memory
 corruption and GPU hangs
Date: Tue, 28 Jul 2026 10:09:41 -0300
Message-ID: <178524417787.535318.15309615931071494842.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
References: <20260727-vc4-bin-oom-fixes-v2-0-0d8a5eddc7c9@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 27 Jul 2026 11:32:27 -0300, Maíra Canal wrote:
> This series fixes two long-standing bugs in the VC4 binner's out-of-memory
> (overflow) path. The binner writes each tile's binned command list into a
> per-job binner BO that is carved into fixed slots, and spills into overflow
> memory whenever a tile's list outgrows its initial tile-alloc block. Bugs in
> that path have been reported for years as GPU hangs, userspace heap corruption
> and occasional full system crashes [1][2].
> 
> [...]

Applied, thanks!

[1/2] drm/vc4: Supply the overflow slot size in BPOS, not the whole bin BO size
      commit: 6395789e4739aa5177bbec0fa0f07ccc38d249b0
[2/2] drm/vc4: Zero the tile state data array before each BIN job
      commit: 48a570c964d8e37d353381e4195106277e17f5cb

Best regards,
- Maíra
