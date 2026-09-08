Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E483C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D42210E068;
	Tue,  8 Sep 2026 00:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XG2VLCdb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5752510E068
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 00:54:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F3E260A5E;
 Tue,  8 Sep 2026 00:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867451F00A3A;
 Tue,  8 Sep 2026 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788828854;
 bh=lezepxTgS7POllyZ/XNViL/Q/E+HXFBOpB5tNFaAYXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XG2VLCdbC/cs4vpUI61dxsgJz2S/Qxz+ftWxjXt03XC5dgTmbK6SYlPXo2Pr6GjKD
 JBe4zBlXPEy4lCkJY+F0HW/PWlAZDTopm9gBPUqOjgXIUdqkvkW2gcCmIFW7mh0UaB
 +XFwjRV7m+VMwzN56SqgbFp8S+8fI6mHwo3NIyj2P74lFAx/CR7Tio5LuD41oxQYY7
 gqkU959hqDw44wSFELdsnV/aHZeLESXkcFmRz2QNeZaC4Kld1NMnkwAYUCJPEe2MWd
 6Q3CWetD40RRg8ose32fVltd20GmLkMkSQwgSaFSNGDDcGglD59BpJco64NLo4xPCA
 xjnb1fPgNYHHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Alexander Martyniuk <alexevgmart@gmail.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Roland Scheidegger <sroland@vmware.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Thomas Hellstrom <thellstrom@vmware.com>,
 Jakob Bornecrantz <jakob@vmware.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Zack Rusin <zack.rusin@broadcom.com>, Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH 5.10/5.15] drm/vmwgfx: drop dma_buf reference on
 foreign-fd prime import
Date: Mon,  7 Sep 2026 20:53:49 -0400
Message-ID: <2026-09-07-daily-reply-0010-vmwgfx-dma-buf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907121751.126950-1-alexevgmart@gmail.com>
References: <20260907121751.126950-1-alexevgmart@gmail.com>
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

> ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
> dma_buf->ops do not match the ttm_object_device's ops, but does so
> without releasing the reference acquired by dma_buf_get().

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
