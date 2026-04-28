Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BAFFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E991510ECE3;
	Tue, 28 Apr 2026 12:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z6C2+WBL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9B310ECE6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:56:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA81D418E3;
 Tue, 28 Apr 2026 12:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661D0C2BCB8;
 Tue, 28 Apr 2026 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777381016;
 bh=OrvsqaGtjkL2gF+C2dCC6NoGcmTOjZDqyYdAJHoSUp4=;
 h=From:To:Cc:Subject:Date:From;
 b=Z6C2+WBL1fjLATetlMZNsJKzgDcDmVNU6HsnhyCZM9TdJtbzg1zWdeIbS5jf8XpXw
 kcrqrk2SXg350zwKS6M7764M2PKOSH2UJqHeYXqMpcBAE5PDXCTjQHsbJp7AcWM1Gf
 zWa39sd13XIYYFMVm0isKCbsGQlBKnFxDON33s/HpefHIgGVVmo8mCDFBmZcH/WVpg
 ticc/PvwFsUmS1YTdod4P1E3po1XSQuWv2mOgpAUzhCnlCuMRhp2eGmo/mWTj2D+a4
 hMyJqkcUgT1FXwFj6zHr0WvherVaCiIX/r1DfCBAXNkS70v89klYGsdPjFLjrUKLEb
 Avf9Y+TD4WfvQ==
From: Thierry Reding <thierry.reding@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kthread tree
Date: Tue, 28 Apr 2026 14:56:53 +0200
Message-ID: <20260428125654.3911280-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
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

Hi all,

After merging the amdgpu tree, today's linux-next build (arm64 allyesconfig)
failed like this:

    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c: In function 'dml21_ModeSupportAndSystemConfigurationFull':
    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:5244:1: error: the frame size of 3232 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
     5244 | }
          | ^
    cc1: all warnings being treated as errors
    make[7]: *** [/srv/kbuild/next/linux.git/scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.o] Error 1
    make[7]: *** Waiting for unfinished jobs....
    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'dml30_ModeSupportAndSystemConfigurationFull':
    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:4961:1: error: the frame size of 3360 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
     4961 | }
          | ^
    cc1: all warnings being treated as errors
    make[7]: *** [/srv/kbuild/next/linux.git/scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.o] Error 1
    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
    /srv/kbuild/next/linux.git/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3762:1: error: the frame size of 3968 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
     3762 | } // ModeSupportAndSystemConfigurationFull
          | ^
    cc1: all warnings being treated as errors

It's not clear to me what commit caused this, and looking at the mailing
lists it seems like this may have existed for a while and for different
configurations. I don't know if there any plans to try and fix this.

Thierry
