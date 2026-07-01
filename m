Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A71C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0692E10E40A;
	Wed,  1 Jul 2026 21:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VOQerWQO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E3C10E40A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D1736001D;
 Wed,  1 Jul 2026 21:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3171F1F000E9;
 Wed,  1 Jul 2026 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782940053;
 bh=cHw32tRK3AgkBd4BhJ4E2eTb3oeKdtreyLog08NiLw0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=VOQerWQO/pRBRiZJukB8yjpLQAtaUtF2v7SFJSjcZhJYuCROjyMAn76g/IxW0dnS9
 MDFK+K/nvksLyGUEwnuSOMPenKs3zNzEN07WcouGoqMo77FllAthOMP7HCWso5/hkv
 7cNSceWycX3EaWFSTPI9rP7blbgbLpl028p/tK/v1K0TJYTex04F5JV1cbHRBUX3/C
 3+N+hbGCcck/sdHUqLI7+ShClMH7Qu/5+0Wl6qzfp5SdTm9qHaw5+eMyk6t+oExg9T
 edMWyQ5GfPmSKhZfpsov3phP+UyJ2WlAB823obbaTT/TKe4rM/oFsQLlukishckqn9
 BpsMzKo8t+/Bw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, Junrui Luo <moonafterrain@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] misc: fastrpc: take fl->lock when moving mmaps on
 interrupted invoke
Message-Id: <178294005196.13032.14515168616227927407.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 22:07:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Tue, 02 Jun 2026 13:29:58 +0800, Junrui Luo wrote:
> When an invoke is interrupted by a signal,
> wait_for_completion_interruptible() returns -ERESTARTSYS and
> fastrpc_internal_invoke() moves every buffer from fl->mmaps onto
> cctx->invoke_interrupted_mmaps. This list_del()/list_add_tail() walk
> runs without holding fl->lock, the lock that serialises fl->mmaps in
> fastrpc_req_mmap() and fastrpc_req_munmap() everywhere else.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: take fl->lock when moving mmaps on interrupted invoke
      commit: fbb084ef5f984af90aa56fa063d278a54e677cf9

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

