Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A6606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSrD+QV8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B57910EE94;
	Mon, 16 Nov 2026 12:57:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E453710F076;
 Mon, 16 Nov 2026 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794833815; x=1826369815;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4OAGayESIziXLisRKeSx6FVwZVvJDBSiokho3moF1MU=;
 b=RSrD+QV8PwjBv0ql6x9fqtWp4WCKFdpOj9f7jbsSAJ1DaUI7xuIgVzWL
 OZxhKgqRQFINfyL6OA/e5RTrm0W9x19Sox7zLtiBOyjywFo5Fuhov/QT9
 mG6hPwa/Thjz43kG0wrr4j06rPba6VdKU9KJzMsneooMNKTiAurklwSkF
 GZa42V8rc/o7UEhRxzo7yDB5Kq6SN0te3bVqyPzXr42l6q58r6QUN/uHF
 BYTh0Sa/Zd2dgk7gQ691KJDJeTjR5rN1gDkrgqXLPuGUzQfWCkob5KbBt
 pMPNIy850zQsMqo34ggJdEu7nmuralY+ISAm9PnqFWrWNoCcB8vhLBBfu w==;
X-CSE-ConnectionGUID: ALgNNTjfT2W1YO0dXQdodQ==
X-CSE-MsgGUID: F96/F83HTt6X8tUHltzrKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3583024"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3583024"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:56:54 -0800
X-CSE-ConnectionGUID: lJB5dGT3Ta+sb4Xki5QwgA==
X-CSE-MsgGUID: x9vGu3IBQn6zv/bab2kYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9344321"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 04:56:53 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH 0/4] drm/atomic: Simplify vblank event lifetime/ownership
Date: Mon, 16 Nov 2026 14:56:45 +0200
Message-ID: <20261116125649.15742-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The vblank event lifetime/ownership is a mess. Various bits of code
examine the event's internals to determine whether they think they
own the event (and thus should free it) or not. Mistakes are very
likely to happen here.

Simplify this down to a simple rule:
"Unconsumed crtc_state->event is owned by the crtc_state,
 and freed from its destructor".

The one slight exception is drm_atomic_helper_page_flip()
because the event is allocated and owned by the caller.
Thus the crtc_state must relinquish ownership of the event
before returning with an error or we get a double free.

Quickly smoke tested with kms_flip and kms_atomic* on a TGL,
and ran the new kunits of course.

Assisted by Claude Sonnet 5.5.

Ville Syrjälä (4):
  drm: Add drm_event_release_completion()
  drm/atomic-helper: Detach the caller's event on page flip failure
  drm/atomic: Free unconsumed events in the CRTC state destructor
  drm/tests: Test event ownership in atomic states

 drivers/gpu/drm/drm_atomic_helper.c           |  41 +++-
 drivers/gpu/drm/drm_atomic_state_helper.c     |  29 ++-
 drivers/gpu/drm/drm_atomic_uapi.c             |  24 +--
 drivers/gpu/drm/drm_file.c                    |  28 ++-
 .../gpu/drm/tests/drm_atomic_commit_test.c    | 201 +++++++++++++++++-
 include/drm/drm_atomic.h                      |  15 --
 include/drm/drm_file.h                        |   1 +
 7 files changed, 277 insertions(+), 62 deletions(-)

-- 
2.56.0

