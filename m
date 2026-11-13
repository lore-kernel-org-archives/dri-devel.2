Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA0606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=K86REYZd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE7010ECA0;
	Fri, 13 Nov 2026 21:59:25 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 26F7B10ECCB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 21:59:19 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 6039C20B7166; Fri, 13 Nov 2026 13:59:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6039C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794607154;
 bh=9q36xcqcPHv79osOmUzmklHxC1KdUdQyrZQoKuIzqPA=;
 h=From:To:Cc:Subject:Date:From;
 b=K86REYZdGEcMQ9Wu/gsmiej5UcvfsjLHYNPn5tkQMZa1CFLWKuo4yU7x1W64msWxs
 lAj5Po9k6Pu1DDe+TmIveFD8Aa2rq37ue8JW2OHlIX89PAg2nS6rysH9bipz/IRHLo
 fn9y8Hou3ESUkUDc/Evgc4/2kC1X3/MaZprWRynY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 0/2] drm/hyperv: address worthwhile gaps
Date: Fri, 13 Nov 2026 16:58:41 -0500
Message-ID: <20261113215843.1939889-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I was doing a deep dive into the host spec and noticed some gaps. So,
I went ahead and hacked together the patches in this series for items
that seemed worthwhile to address.

Hamza Mahfooz (2):
  drm/hyperv: add modes for all resolutions offered by the host
  drm/hyperv: batch dirty rectangles

 drivers/gpu/drm/hyperv/hyperv_drm.h         | 15 ++++
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 32 ++++++++-
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   | 79 ++++++++++++++++-----
 4 files changed, 110 insertions(+), 20 deletions(-)

-- 
2.56.0

