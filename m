Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D749CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABA810E2CD;
	Tue, 12 May 2026 21:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="RieNWjIM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8AD10E2CC;
 Tue, 12 May 2026 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j+KAtvjE0Cz+K2olegG2ecRni3stqWYM/JxxVSGFf1g=; b=RieNWjIMVgSHJlmZ05afrK+vW0
 pYFFilkaXI/BFQac3F9fcQwhPBuz9Dp9Bjs8v4DoQqew4LpC87GXOBnDo5eF1A5/LTZyQdKdXhDWq
 2OB9Dm6tvLeltmuhqE9m6YK7rZx95xylM0rOfMiD9FfglDHYeoFw++Yw5Z2CdXpzywlF0aBRxgCnK
 Bt5TWk2hKY5jO+uBU2/2MPjgISUkYWKn2v0jB92kOhm3FJR6+PGtVPIZpI2ww1TSvqpVlqCtiuWY9
 qUl5bfKufKTqon9fsXsMbwl5SbAAk8OXKrlmAlJRmHJb8DT/G+qt4TN/yzhEh3hYKX0l50a4BlSJk
 ewjeyzHg==;
Received: from 179-242-241-236.3g.claro.net.br ([179.242.241.236]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMv1S-009frh-0M; Tue, 12 May 2026 23:52:13 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH i-g-t 0/8] dmem: add amdgpu support and one more test
Date: Tue, 12 May 2026 18:51:47 -0300
Message-ID: <20260512215156.4083082-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This work builds on top of Thomas Hellström's patches at [1].

Besides the case of eviction when setting dmem.max, which still needs
support from [2], there are other cases for testing dmem behavior and
potential regressions. Thomas' patches lay over the groundwork for this,
while this patchset addes one basic test of checking current usage and that
drivers respect max setting when no eviction is taking place yet.

This patchset also introduces a driver layer such that the same tests can
work with different drivers. amdgpu support is here added too.

[1] https://patchwork.freedesktop.org/series/163935/

Thadeu Lima de Souza Cascardo (8):
  Introduce dmem driver and implement Xe support
  Adjust xe_cgroups test to use igt_dmem_driver
  Make xe_cgroup test a generic test
  amdgpu: add amdgpu_cgroup_region_name
  igt_dmem_driver: add amdgpu support
  dmem: add test for current/max
  dmem: only check for dmem availability once
  dmem: get region once per driver

 lib/amdgpu/amd_dmem.c    |  94 ++++++++++
 lib/amdgpu/amd_memory.c  |  25 +++
 lib/amdgpu/amd_memory.h  |   2 +
 lib/igt_dmem_driver.h    |  25 +++
 lib/meson.build          |   2 +
 lib/xe/xe_dmem.c         | 145 +++++++++++++++
 tests/drv_dmem_cgroups.c | 390 +++++++++++++++++++++++++++++++++++++++
 tests/intel/xe_cgroups.c | 296 -----------------------------
 tests/meson.build        |   2 +-
 9 files changed, 684 insertions(+), 297 deletions(-)
 create mode 100644 lib/amdgpu/amd_dmem.c
 create mode 100644 lib/igt_dmem_driver.h
 create mode 100644 lib/xe/xe_dmem.c
 create mode 100644 tests/drv_dmem_cgroups.c
 delete mode 100644 tests/intel/xe_cgroups.c

-- 
2.47.3

