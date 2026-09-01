Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C08C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1628E10EC2F;
	Tue,  1 Sep 2026 09:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YnrUBwmc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8B510EC2F;
 Tue,  1 Sep 2026 09:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2263414D7;
 Tue,  1 Sep 2026 09:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A711F000E9;
 Tue,  1 Sep 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253755;
 bh=LmKfrcBCf+s8osjs3jVsCHiYNiCClUW4L4OdCzj7khA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YnrUBwmcU16iObto6eZ28OSGICXXqpQwOYQmO0TYOq5CQfa7E/B+PpKfZZWF99luc
 cBm9ouOQR0xvoptqhFsD/RwfI7UWymejWPA3WUz04Ai4UMrwyQ16XLyoQqzZZ/x4qo
 whkGPwTjv59R9Pf5XsoVBrhMPkOO2+I+fC10PtfWMChmXmk0KDzyEx7XoHSpDXfmtH
 2dOMqYqsta3kPueISufHoKrqkvIHJ0+GsUvRynvoFTm4vmQCk9M9xnlq98RzlJ9l9T
 miQDmvMa3HNvUSjukOrA/HLPOIv8x1QT9cj35eZhStyZM5PXgVf55/ORdZg/iEHjBE
 0PSlySt2kQ15Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dakr@kernel.org
Subject: Re: [PATCH] nouveau/instmem: handle iomapping already existing
Date: Tue,  1 Sep 2026 11:09:04 +0200
Message-ID: <20260901090904.9188-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825030615.3464436-1-airlied@gmail.com>
References: <20260825030615.3464436-1-airlied@gmail.com>
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

On Tue, 25 Aug 2026 13:06:15 +1000, Dave Airlie wrote:
> [PATCH] nouveau/instmem: handle iomapping already existing

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] nouveau/instmem: handle iomapping already existing
      commit: deced5fa01c5

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
