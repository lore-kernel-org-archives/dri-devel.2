Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C793C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0FF10F412;
	Fri, 14 Aug 2026 07:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lTQopUKC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C9D10F3EF;
 Fri, 14 Aug 2026 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=J2Ku6xFDDVwUqTCruUuHXw/3u8kRuD7vi67MTK1vYIE=; b=lTQopUKCF36Snl5kDoyZjVoZWR
 gBObpD5ezsvT4I/R9qI6xtK/onnrurAny83bkYabXoRPfzjJWtBiOCSTK1O5Z9sHKt2tUVuFsKdrf
 ZlfQrqCni6vSa2SCumiHe+3krbgkjfmN+M7VAwiJ4KAbW4kxreU+xQHVKSG0EBXwIkL41mZMmvhcP
 sTEzc/SHfPk43bjhv3Y4/U2dVTy6c9a4tHe32jf+Z/ZIaAGINYk7W7pu/fnKKsp+SUKHC2j/ti1FD
 9pGx/bpZg+aDX2O2nh1AAla0aoEqS2NhNe3vhGYOAyYgZ4QTR5jthGrn2HE9xMNeQhhTQcdzDHAnA
 srJVWgNA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wumnV-001drz-Sn; Fri, 14 Aug 2026 09:57:49 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Luke.Wildhardt@proton.me,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 0/2] drm/sched: Fair policy fixups
Date: Fri, 14 Aug 2026 08:57:37 +0100
Message-ID: <20260814075739.32481-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

Two fixes to address the two issues found in:
https://lore.kernel.org/dri-devel/TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me/

Many thanks to Luke for reporting, sharing one AI proposed fix, and the super
quick testing turnaround!

After these two we can hopefully work at promoting the "fair" policy back to
the default in an upcoming kernel release, followed by removing the FIFO and
round-robin, and then re-applying the code base simplifications which we had to
temporarily revert.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

Tvrtko Ursulin (2):
  drm/sched: Do not restore unsaved virtual runtime
  drm/sched: Ensure monotonic min_vruntime

 drivers/gpu/drm/scheduler/sched_entity.c |  8 ++-
 drivers/gpu/drm/scheduler/sched_rq.c     | 85 ++++++++----------------
 include/drm/gpu_scheduler.h              |  2 +
 3 files changed, 37 insertions(+), 58 deletions(-)

-- 
2.54.0

