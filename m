Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E1606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=PcNDxX+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDFC10EDAF;
	Mon,  2 Nov 2026 13:14:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54CE10EDAF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=kTGtskkzFNm/uze28ayZ+fevtF8cgxfFpWUG/kR5BZI=; t=1793625251; x=2108985251; 
 b=PcNDxX+XPs/kOMPyBBnElJus27jATWLGDAyS5PxyY4yNeUWLxhfQMBamghOJMS8oLgBC7Oj93rP
 0LWPjZe6VjRTRHytRUCioFPbBiNsurX/Jr1dpaAueqWH3t+FiGpu/I6z1uSotjXJNC/0hhfLHymK4
 fhRryl0x2VVpqGokFc2K/dZtE9sxcZjKhkqJC/ySl2++p+ScFYBpufqdKsGizaapGSAJOywrEjGHp
 q7jAX8iXkyTMqsPTlZ/RplQx/3kdTPfbQbGguFcSUv+Qc62Mw+ZFRr5W+V/uGzvOgTMCNEb79jFfh
 F1ZQcwDRiarbKjEaVZUcG4ighy9rOOxVTHeg==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xNrrT-0009Eu-VU; Mon, 02 Nov 2026 14:14:08 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL
 sequence
Date: Mon,  2 Nov 2026 10:13:48 -0300
Message-ID: <179362522211.52532.2556381030815772891.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260707200738.659002-2-mcanal@igalia.com>
References: <20260707200738.659002-2-mcanal@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 07 Jul 2026 17:05:48 -0300, Maíra Canal wrote:
> v3d_clean_caches() and v3d_flush_l2t() both write the single L2TCACTL
> register and poll its status bits. The mutex cache_clean_lock exists to
> serialize them, but v3d_clean_caches() only took the lock around its final
> FLM_CLEAN write.
> 
> These functions run concurrently: v3d_flush_l2t() is issued from the
> BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from the
> CACHE_CLEAN queue, and each queue's scheduler uses its own ordered
> workqueue, so their run_job callbacks execute in parallel.
> 
> [...]

Applied, thanks!

[1/1] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence
      commit: 994ba6e5c87d6a3d471ea987fe8622168f092334

Best regards,
- Maíra
