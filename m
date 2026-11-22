Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF19A606A333
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOY466Jp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C3A10E02B;
	Sun, 22 Nov 2026 03:39:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851D410E02B;
 Sun, 22 Nov 2026 03:39:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 014B44582E;
 Sun, 22 Nov 2026 03:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97121F000C4;
 Sun, 22 Nov 2026 03:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795318757;
 bh=xlAJSufIrvZMDmdcW1mgZFjpdvM8gZZPEKiNTVsVOW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SOY466JpByqSZ89hsW8FmPLFpjmHLkPxuVAUy5POd6JQsrO8xFs6fQ/ch5lUR62d2
 UwtOJfNtaxqGWlijs353MytdXjXF4rJrXCZnW79pCSjHCaWQUOPj3YaAUv4ys6qR65
 ysPHWXvI/jcrT9diQsgyehZvf4OrRYPXt36jeSq4dnn7Meie+1UWBFPY+cMTvDLTaU
 JpfnR6rsuSAwsPH4Uthto0c3ewtx4tKcC8J79dFDC0qi+XPGCRniBR0NeZ9D7gUdxd
 eobjj6yxNkl5dBApqCH+6zHeHabqGMCgNMKhk7aZWKuMWyJIXIwgJDUgUwP5yV/KVn
 eAdyDGSVLnXyw==
From: Sasha Levin <sashal@kernel.org>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 regressions@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Ilia Mirkin <imirkin@alum.mit.edu>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "R. V. Lobato" <vieira.lobato@gmail.com>
Subject: Re: [REGRESSION] nouveau: GM108 hangs at boot since
 "drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts"
 (6.18.64)
Date: Sat, 21 Nov 2026 22:38:45 -0500
Message-ID: <2026-11-21-2-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121101350.bab69dff11a2@gmail.com>
References: <20261121101350.bab69dff11a2@gmail.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The 6.18.64 backport 15465d681517 ("drm/nouveau/devinit/gf100-: try
> to avoid double-running vbios scripts", upstream 2139cb633d48, review
> patch 426/686 <20261113153835.372076643@linuxfoundation.org>) breaks
> nouveau on my GM108 laptop GPU. The machine hangs during boot.

[...]

> The guard expects nvkm_devinit_disable() to return a mask of disabled
> engines. In 6.18.64 it calls the void ->disable() hook, which disables
> subdevs with nvkm_subdev_disable(), and then always returns 0. So the
> guard is always true, also on boards without a display engine.

Thanks for the analysis, that matches what I see: nvkm_devinit_disable()
has returned 0 since da2b1a0a40d8 ("drm/nouveau/devinit: Convert function
disable() to be void").

I've reverted it for the next 7.3, 6.18 and 6.12 releases and dropped it
from the 6.6, 6.1, 5.15 and 5.10 queues. Mainline has the same bug and
still needs a fix.

-- 
Thanks,
Sasha
