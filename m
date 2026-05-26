Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF5CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B324010E4D0;
	Tue, 26 May 2026 13:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HUIsbkv0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83CD10E49E
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:38:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 351E260534;
 Tue, 26 May 2026 13:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63201F00A3A;
 Tue, 26 May 2026 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779802708;
 bh=EfEdhpcWaQ+cqO6OvMWvbO+XOKtHBGALpHmzVeivkXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HUIsbkv0Qw9I/pdXvHMGfgWu/u7aOoKd3zlCn9ndERNYqYSY9Z8EMd8Hrs7JEqHBi
 OWCcHDVsEB5hLaYGUlJiKvDyLudXcSEfIPO0/7xusL1gFOdHmaxhLdV1pdxgLrL92f
 pGHuKAX0zPG0ZU3+x3gRi2NqOaqaPUZ6yHrp1vB2uFTANy9rXX5VgXzaGVRNbn2PPc
 kFyNmsOiy1RzCDX/9E8c6foVlnKXfePd0Pa5VgjML2T6G9sZMQP5/m32C+xJZRX6Lg
 UuZhc9YWZK8TZS79PSyN9ETy+2RV1YiNUeowJ+ymnZKm6dhyMGE0YGA21T8D1sNeAy
 LjvTSafsmnqbQ==
From: Sasha Levin <sashal@kernel.org>
To: Alessio Belle <alessio.belle@imgtec.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Binns <frank.binns@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y v2] drm/imagination: Synchronize interrupts before
 suspending the GPU
Date: Tue, 26 May 2026 09:38:18 -0400
Message-ID: <20260526140000.agent5-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-sync-irqs-6-12-v2-1-b4306e95194d@imgtec.com>
References: <20260526-sync-irqs-6-12-v2-1-b4306e95194d@imgtec.com>
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

On Tue, May 26, 2026 at 09:13:07AM +0100, Alessio Belle wrote:
> This version of the patch contains only the part of the upstream commit
> that applies to 6.12; the rest was a revert of code added in 6.16.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
