Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37976CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CD910E951;
	Wed, 27 May 2026 19:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LxNi8mWK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C675710E951
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:49:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AC1C605A5;
 Wed, 27 May 2026 19:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2811F00A3F;
 Wed, 27 May 2026 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779911374;
 bh=uPdnk+9Xag3ocKyOILnUoy4oYUYH63qCVU1qhqO2mXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LxNi8mWKaZIOw4w4TOuFUyC9k3m503pW2G5k1ViImeJ45N5fs55frZpRcWxPAdrI/
 U+HaYVL3dUHRvj1uHDu0DQdOVudyjWfzN6n/0EOflcWucvH1LVxK7mlaLC2sDX0S2n
 SUK7gzrBErlwzPwZYaipPmWmTB5XYtkhl7RQ/P2oJsyu//v7r2PkKjETZKSLqMwxYj
 MJ3eo5gIlPAxMtdkzWpOJmXR+oX/2H1a0n8wQhlhyq/oUvsd5ubIQdVw0j5BX3bpKH
 qOriPubDI9odZXYZU4WxVKLRCJ3rAiWd6fsCe2GzIGxnFnm+gWSPPBx2erMKRR3BGF
 mLnBY33gmyB2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, w15303746062@163.com
Cc: Sasha Levin <sashal@kernel.org>, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2 6.18.y 0/5] drm/vkms: Backport generic vblank timer to
 fix ABBA deadlock
Date: Wed, 27 May 2026 15:49:08 -0400
Message-ID: <20260527-agent5-item016-vkms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
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

> This series backports the generic vblank timer infrastructure and
> converts the vkms driver to use it, fixing an ABBA deadlock.

All five patches queued for 6.18.y per Maarten's ack. Thanks for the
v2 with the proper Signed-off-by chain.

--
Thanks,
Sasha
