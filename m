Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F44606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=OE53mCew
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B773E10E5BD;
	Fri, 27 Nov 2026 15:00:33 +0000 (UTC)
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de
 [91.216.248.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B63112B58;
 Fri, 27 Nov 2026 15:00:27 +0000 (UTC)
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: be8926f0-53f7-4e49-afc6-deafbaf5e0c6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1795791625;
 bh=uZFyBbuyMu6Q9xrtJRjlB0ZIJBs2x9cl6bdnwyfzNWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OE53mCewgz9FxqJAMqkL85YVdwIcn6arhiTGcMwuK83w1YUOnHYxayXyylQN9Yxsy
 qwldsDFxnZw67lwTJYTKANzTIvTkcYIZBb1XgJT5LlD2pkvKW+B0/A3R4R6Q9LoXce
 H0ZQ2zX75xNxm1rXUfAtV+jdE/BGklHKa8AQyAiuDzvnx59VfWCsIGvlVnNTDlzb9D
 j0aBRQmLg5vwtW8Td4xohKT9ZfobCXr3fQdPL20cIKxMSmcf9uSJ/xaPFox6JsZliz
 hFSb8soUVfhdBtuuAxemRwoklrQpUvr+bmHgHQ7Z4wbCfJhZokRqxgvmBGKkzREL0n
 NYBtd6/pB3fLQ==
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
Cc: airlied@gmail.com, simona@ffwll.ch, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/backlight: restore the gmux brightness on dual
 GPU T2 MacBook Pros
Date: Fri, 27 Nov 2026 16:00:21 +0100
Message-ID: <20261127150021.285379-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108100926.28950-1-dev@deq.rocks>
References: <20261108100926.28950-1-dev@deq.rocks>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

gentle ping on this patch.

The Intel CI reported VerificationFailed for it, but only because my
address is not on the CI allowlist, so it wasn't tested. Could
someone with Patchwork access click retest on

  https://patchwork.freedesktop.org/series/178109/
  https://patchwork.freedesktop.org/series/178113/

Andre
