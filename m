Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CB606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VOljatYj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C45410E201;
	Wed, 21 Oct 2026 09:42:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA47310E1E0;
 Wed, 21 Oct 2026 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=M/Q/Qc3Mllv2pxDqtZZLK4KCMK1IjDz0yKlGrKo+iNY=; b=VOljatYj1MztR7O+je84tpuG02
 DDh4QFOR6JFawyDW6IbSpNviTQRKDXcoPjLzRLu0j8AuUJKPEUsug1ItKALH27WKincHf82YxhX1g
 R/OxnEYB8EeeCpHOpbZqlPbTHd3fPXhoFm2at39ZmDPYPWbUoG2tN88RWmytGAB4HQC4SLd2D0WOc
 e3jt91AVDCdEjN9/h4OWagRL/4g563ILFxM/x/mNbcxi0T/g3wt1mVAupqgfipMHVnaYl6oiLui3t
 br2cBwopnz/XMD5rxxOpTa3j+GULv/GmdSNC0EvQL1AKmzHSiXPbOXAs3PojgDfqmuKkSHY90Moga
 xtcTCAvQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJSq5-005Ues-3H; Wed, 21 Oct 2026 11:42:29 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 0/2] DRM scheduler fair policy fixups
Date: Wed, 21 Oct 2026 10:42:25 +0100
Message-ID: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
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

Two fixups with first being a theoretical bug and second I think no practical
impact.

Both were caused by the revert of
77a6809f1dc3 ("drm/sched: Remove FIFO and RR and simplify to a single run queue")
, meaning those issues were present in the middle of the original fair scheduler
series.

v2:
 * Added second patch so it is a series now.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (2):
  drm/sched: Fix out of bounds entity priority check
  drm/sched: Adjust run-queue when changing priority at runtime

 drivers/gpu/drm/scheduler/sched_entity.c | 29 ++++++++++++------------
 1 file changed, 14 insertions(+), 15 deletions(-)

-- 
2.56.0

