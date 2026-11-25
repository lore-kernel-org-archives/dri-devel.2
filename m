Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B7606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2F910F999;
	Wed, 25 Nov 2026 02:19:37 +0000 (UTC)
Received: from yocto-server-2.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C6A610F996
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:19:29 +0000 (UTC)
Received: by yocto-server-2.amd.com (Postfix, from userid 1009)
 id 64DB3A0D12; Wed, 25 Nov 2026 02:10:17 +0000 (UTC)
From: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
Subject: [PATCH v2 0/2] drm/amd: skip unchanged hotplug uevent on DC resume
Date: Wed, 25 Nov 2026 02:10:15 +0000
Message-ID: <20261125021017.603857-1-Jyotiranjan.Bhuyan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022094835.591175-1-jyotiranjan.bhuyan@amd.com>
References: <20261022094835.591175-1-jyotiranjan.bhuyan@amd.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v1 was a single patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-October/155562.html

v2 splits that change. dm_resume() sends one hotplug only when a root
connector's type or local sink changes. amdgpu_device_resume() no
longer sends a second hotplug on every DC resume.

Changes in v2:
- Split the amdgpu_device_resume() change into patch 2.
- Treat two NULL sinks as unchanged.
- Log the both-NULL case with drm_dbg_kms.

Jyotiranjan Bhuyan (2):
  drm/amd/display: skip hotplug uevent when sink is unchanged
  drm/amdgpu: drop duplicate hotplug uevent on DC resume

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 ++++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  2 +-
 4 files changed, 69 insertions(+), 8 deletions(-)


base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.43.0

