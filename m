Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDBAC53200
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D57910E025;
	Fri, 24 Jul 2026 15:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LRRET6v3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CFF10E025;
 Fri, 24 Jul 2026 15:24:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70E4C600AA;
 Fri, 24 Jul 2026 15:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5211F00A3A;
 Fri, 24 Jul 2026 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784906660;
 bh=0HJFIzsPuXIH5mck9EgiponQHctrqk7723RZ7BhxfNg=;
 h=Date:To:Cc:From:Subject;
 b=LRRET6v3IpYfqiZBdiTQXW6kiAJRuvmv+oekEjJea34NgcUXsi5Goa0ZqunISnvfX
 i2HamUNApJ/bbTSmeZhGX7WLEvgwPxvu2Yq1gKBe1fdAx/LycZnedeEHK9Oi5F37JF
 RHkTrlskNS9Y2+mJF+icuO8oQJrvpUZ+THvERQt/1RRSFUVvo/qOtyRA+N4oF+R38c
 8UyM6/P8DLJRL21WUswZrrKrTfRzmjgN6W4+GXGeZ0n///ZMd1Wdquc0iXnO+u7T1+
 Ppij7tB4pBBJl+cGRGx6mzDS6a9+Ry4mKc5frxIY4+E069aJUyGLQJZZqa4hKDsLvk
 yhxM4Q1QoP/xA==
Message-ID: <5d5964a3-fb85-4a3c-9252-a43c93fe935d@kernel.org>
Date: Fri, 24 Jul 2026 10:24:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Airlie <airlied@gmail.com>, simona.vetter@ffwll.ch
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Dave, Simona,

Alex is out this week, but we have two pretty important fixes for 7.2, 
so I thought I would send them out to get picked up.

Thanks!

The following changes since commit e24b02df4e9a1a78b2dbbf6ab21ebf24918f5c6a:

   Merge tag 'drm-misc-fixes-2026-07-24' of 
https://gitlab.freedesktop.org/drm/misc/kernel into drm-fixes 
(2026-07-24 18:30:29 +1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-drm-fixes-v7.2-2026-07-24

for you to fetch changes up to fbbaca9e208733652828ea98d00f09f260a7770e:

   drm/amd/display: Fix missing DCE check in 
dm_gpureset_toggle_interrupts() (2026-07-24 09:30:17 -0500)

----------------------------------------------------------------
amd-drm-fixes-v7.2-2026-07-04:

- Fix a backport mistake for dm_gpureset_toggle_interrupts()
- Fix a failure on flip-done timeouts for mode1 reset

----------------------------------------------------------------
Leo Li (2):
       drm/amd/display: Fix flip-done timeouts on mode1 reset
       drm/amd/display: Fix missing DCE check in 
dm_gpureset_toggle_interrupts()

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  3 ++-
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 13 +++++++++++--
  2 files changed, 13 insertions(+), 3 deletions(-)
