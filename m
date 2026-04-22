Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD69F94CDE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46C410E26B;
	Wed, 22 Apr 2026 07:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HTpadALL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9584C10E22C;
 Wed, 22 Apr 2026 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1zzb+4acGKjTuyK/wOO6EJYre1Th3yxlKirkRg8TfLQ=; b=HTpadALLuXjua4QYfqJf18rD4X
 49ZipAIvHzZIM6ab7KFD3ZeI0RaqYlWL+1eDJog9WecUS+bXnVX+xmhR0Syt6zlDE8xq9r4H24PnM
 CBzwO8A0kOWn6Ty/ILCRxG9PyxwHRGCNSxqiBPsJprngHKEMDs+MrVb1friU9Im7VnnwfQs53FCSA
 Eae2JyOPqnlsyBldzkM1Hx4VFhoWzRuqJFIEIJx6QwTcfmR/xZcuyVix/xlgnRHZX4H1UjHHtKhD3
 vGc+nnOM0U7aHBz9lGVoveDRCqswaZpUC8TjHGKNM0TOpl+09hvmWO0N99VLTrPW2MOzXXfJKy5Yg
 e8do+QTQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wFSOj-000B5t-Vg; Wed, 22 Apr 2026 09:53:25 +0200
Date: Wed, 22 Apr 2026 08:53:24 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-next-fixes
Message-ID: <aeh-dKTow5Fl4Iv4@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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


Hi Dave, Sima,

Just a single fix for the merge window this week. One case of an
uninitialized variable in the PSR code.

Regards,

Tvrtko

drm-intel-next-fixes-2026-04-22:
- Fix uninitialized variable in the alignment loop [psr] (Jouni Högander)
The following changes since commit a97c88a176b6b8d116f4d3f508f3bd02bc77b462:

  drm/i915/wm: Verify the correct plane DDB entry (2026-04-14 08:04:47 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-next-fixes-2026-04-22

for you to fetch changes up to 314f6179e370988ac00dadf373a4f6166eb3db15:

  drm/i915/psr: Init variable to avoid early exit from et alignment loop (2026-04-20 10:58:26 +0100)

----------------------------------------------------------------
- Fix uninitialized variable in the alignment loop [psr] (Jouni Högander)

----------------------------------------------------------------
Jouni Högander (1):
      drm/i915/psr: Init variable to avoid early exit from et alignment loop

 drivers/gpu/drm/i915/display/intel_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
