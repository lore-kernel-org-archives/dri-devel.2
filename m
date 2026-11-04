Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D6606A331
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=mtugT7AP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F58D10FB86;
	Wed,  4 Nov 2026 12:34:51 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9D510FB86;
 Wed,  4 Nov 2026 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=rGv1djR7iZsZ31wEs/ooZILYDVKoYunkUqTuHp2SXDg=; t=1793795684; x=2109155684; 
 b=mtugT7AP+jFaRCWYtoQ0KebcwgkXOkXZRNYqhYjMnMFFdEz2RpmqVpqMvGo3hcdQgHQC1olxKg5
 QhZPTP8OrIsdRqi73SsycOK4eTYOYeehjE/9riyuEDdFE9UX7UKLLy2clqjalffcYcj9QWp0fNvjI
 eNWA0Smnf1m7xZcJcZfmTISB6La70aikwdLndeRTvhTwytfjE74YGN91B8TCn+AG/tN399El8K0sv
 NRKjK7JNQ+6yGLimhkMGyk8hUVw3nnVwowB2R6Shi93ktae9pnzQpP6sMJBJHSxTefHwSxYfq+oBw
 6FASsaClKYgI7EYKvjTgvCif4gt3BrYQtbDw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOaCQ-002FeU-Lg; Wed, 04 Nov 2026 13:34:42 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 0/3] Some small drm_sched_init() cleanups
Date: Wed,  4 Nov 2026 12:34:38 +0000
Message-ID: <20261104123441.34842-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Removing some pointless or questionable log messages and disallow double
scheduler initialization. Latter causes at least memory leaks and should not
escape new driver bringup really.

Tvrtko Ursulin (3):
  drm/sched: Reject double scheduler initialization
  drm/sched: Remove log message of questionable use
  drm/sched: Remove useless log message on memory exhaustion

 drivers/gpu/drm/scheduler/sched_main.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

-- 
2.56.0

