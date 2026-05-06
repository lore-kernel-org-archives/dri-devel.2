Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE18CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F3010E535;
	Wed,  6 May 2026 12:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sLy1RwEV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B39010E535
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MAx5G3WSi0kn9ozTKXHHjJK+xQtPpNgVE01pyUEzytU=; b=sLy1RwEVyh+Up45cOede75X0BY
 Vg/Hck2X1D5mnV3o4sM7dwPt0DX+j48Jhgbhth2lR3Il/K6IKrrqlsYzsYDIbqWnn6QSdVo/sDyMJ
 KaLFEfuhgC1kead3PAhLt9BZAo31HyJtSFh4qk9x0UG3f7lPFeYz+9yRcHU2YA9xgHuQK8onDQiF6
 1BCDWpXlh1BNcGm5HzBB9em2GVlXOuMbIBzgYbtDHFAo2BHfC+dMPPOlHKN3dG6QFstqZdzJuLNxK
 sWn+Ti2u8XjwTYFi7jaLxRZiaNJfWIOpJaooY+KDmi3n/ZbN8IqlihtXJn5UEYFNPSfk0CDIBCcmM
 bBkYCi3Q==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKaux-006sxt-VE; Wed, 06 May 2026 13:59:55 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/2] cgroup/dmem: introduce a peak file
Date: Wed, 06 May 2026 08:58:23 -0300
Message-Id: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAs+2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3ZTc1Nz4gtTEbF3jxKRkw6RUS1MDcyMloPqCotS0zAqwWdGxtbU
 AI5qMh1sAAAA=
X-Change-ID: 20260409-dmem_peak-3abc1be95072
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
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

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

It can be written to in order to reset the peak, but different from
memory.peak, which expects any write, dmem.peak expects the region name to
be written to it. That region peak is the one that is reset.

That requires ofp_peak to carry a pointer to the pool that was reset.

Writing a different region name will reset the different region and make
the original region peak get back to its non-reset value.

While at it, we reuse a helper from memcontrol, which we moved to
kernel/cgroup/cgroup.c.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Thadeu Lima de Souza Cascardo (2):
      mm/page_counter: decouple peak_reset from peak_write
      cgroup/dmem: introduce a peak file

 Documentation/admin-guide/cgroup-v2.rst |  10 +++
 include/linux/cgroup-defs.h             |   7 ++
 kernel/cgroup/cgroup.c                  |  32 ++++++++
 kernel/cgroup/dmem.c                    | 132 ++++++++++++++++++++++++++++++--
 mm/memcontrol.c                         |  42 ++--------
 5 files changed, 183 insertions(+), 40 deletions(-)
---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260409-dmem_peak-3abc1be95072

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

