Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FB8F8D777
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2AD710E21A;
	Thu, 16 Apr 2026 20:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="debfNVvt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71D510E22A;
 Thu, 16 Apr 2026 20:12:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EDC8360127;
 Thu, 16 Apr 2026 20:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE3C2BCAF;
 Thu, 16 Apr 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776370369;
 bh=S7Lyz29vNQw7ueK8+j0MzNstO84GRnc9HJjuJmASNnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=debfNVvtb4NPryVMBdw8mklrNaILbPdWvd1TDjfPXVylWd6nkovkSm2x1+mqzaDlh
 v1BHnjC8nGAhQNyOtjg+tax1WpWCrqmveTx8KtT9lsoIP2DfVvKox67loGjBJWdr58
 z4wFCy1ot1jpHpi/BZttBHTiblowgTVKsgGsXb2W//75rrrlEhgNX2KgXITeM1DBya
 agZosVrT5S4Ru1q4iIKCG206JksVTtsezjM/o5FWmmFdVV1NvSD9QyPC4g/FYfEPPM
 ivYBxeCndOCK9OrWCChgKTsHU0w3Nv7kvmScQlP/QfkwamaOanOG8ex2ZncITEyqJs
 OMUZiwjzzWJJg==
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/sched: Make drm_sched_entity_kill() a public
 function
Date: Thu, 16 Apr 2026 22:12:36 +0200
Message-ID: <20260416201236.13856-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144956.272506-2-phasta@kernel.org>
References: <20260415144956.272506-2-phasta@kernel.org>
X-Patch-Reply: applied
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

On Wed, 15 Apr 2026 16:49:56 +0200, Philipp Stanner wrote:
> [PATCH v2 1/2] drm/sched: Make drm_sched_entity_kill() a public function

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/2] drm/sched: Make drm_sched_entity_kill() a public function
      commit: 2f5f05633e22
[2/2] drm/nouveau: Fix double call to drm_sched_entity_fini()
      commit: cac96c8d93fa

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays.)

The patches is queued up for the upcoming merge window for the next major kernel
release.
