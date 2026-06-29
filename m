Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E147EC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3050189F4F;
	Mon, 29 Jun 2026 00:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BxhvvnVq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA8D10E38B;
 Mon, 29 Jun 2026 00:54:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7233E6001D;
 Mon, 29 Jun 2026 00:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA591F000E9;
 Mon, 29 Jun 2026 00:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782694447;
 bh=gVEBQQ3Ih68cKsVxljEnf7h6tlE5psA3qhQaUm1QrxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BxhvvnVqnme4Rx9S7hySq+PuqWGIAZ52kArdjcKcUAlIsAkhoSNZnCep8tlw0WVMk
 3linyT7Xsazmi0MpVRsd/tHyDM07OMKsMm5yCmDAEyZkdnHUYMe58V/aYtIt+Q50Ar
 MzFQc3eHFoKB116rqHu4G1KAIqMgix569qBqkrmJu50nQDSLTqkKHp35y7kMD0aDSD
 scZGiZ82GPKi0JZmsIBryK3vRys8CqzrJjyZXcAr9reD4bzr8ua4unHHJ1Fq3L59re
 Zardu8b5XCnZKOV/RbS9vO1kQEyakOvvFZDOaeEcrwOALDhjhvlmEksyOMF7y3weVM
 fFwIFuKmx5dGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, ray.wu@amd.com,
 superm1@kernel.org, "Sun peng (Leo) Li" <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] drm/amd/display: Fix ISM dc_lock deadlock during
 suspend
Date: Sun, 28 Jun 2026 20:54:03 -0400
Message-ID: <stable-reply-item001-amd-ism-71-20260628203053@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628140148.59923-1-admin@ptr1337.dev>
References: <20260628140148.59923-1-admin@ptr1337.dev>
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

> From: Ray Wu <ray.wu@amd.com>
>
> [ Upstream commit 3714fe242592e3699ac5e2c19d68b275a210be7d ]
>
> CachyOS users reported a regression in shutdown/reboot behavior on 7.1
> kernels: the display turns off, but the machine does not power down.
> Reverting ISM fixes the regression, and this upstream fix addresses the
> same ISM dc_lock/workqueue deadlock in the suspend/shutdown paths.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
