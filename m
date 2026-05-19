Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C5CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 20:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE0E10EE66;
	Tue, 19 May 2026 20:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="VZmFfgCe";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="Bbm8HnIA";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B2910E3E8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Cc:To:Subject:Date:From:References:In-Reply-To:Message-ID:Sender:
 Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DgZVpf0/mLQMLhxPoO/PM6ZgBWGJ3fgV45Hs7h77mu0=; b=VZmFfgCeS6fpiu9cXWU3mT0v32
 Arum1BSD3AJ+OSvJ+puA1RpSIh5vezr2fTSZnrlCgd80OQrE8OKUjLYPxClSOIsKJlwlKyGCsK4kD
 akSMJbVAhhcsj+96Q13LHBWrIDgu5HwQMZUqDrM/CpxvTz1WvXR+2l7DDwCo05Z9irIFHXguL8WEN
 EStaarfkEzjuMbH91r4Sq3g3iKy+V1ITOfXDk0HvWjIIWHgH2OavQoOSdr77rJmJSiYoNEEAbP5RS
 ARrG5uzWxgfYErGHMcXfFLgFYbkcWgSa/iQyjHDpcS/pzYRWpH/twOxYmYTjmiKNlYuVUAAQb7Fj8
 wrnrBL7w==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wPQyP-007hMj-0o;
 Tue, 19 May 2026 20:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779222197; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=DgZVpf0/mLQMLhxPoO/PM6ZgBWGJ3fgV45Hs7h77mu0=;
 b=Bbm8HnIApgDONfegBCe/GRcoLpjiA9sJEg2SF5oj+WA1Z0rwN9Xu0pwYsgiYfdF9euNuj
 hrZkvl0eMdLhwmx8E2fzVNQBegVS2JYsiMYy1+ZouJsFFqzGVseHvbXo/CWrLKSkQjVfKUv
 eHH3z33fDBgyW2w9YzHLVjLLNyngPr3L5ADbqyMmoCDNCAEuS5bnpnhfpLqvNzpoH2uVAYB
 DQGpPZZLcVyJnmvUf/3kvhRLagxhJajHLdbrYv+dw3IlUqvN+cxTk6XSsm1f8oERLjVdZoB
 qcyCskbNiYZQ84OWUAuBt78YrLwgUIBXWr2YTewOqikaxGkmKdaiTxelLOTA==
Message-ID: <cover.1779221339.git.me@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover-v2@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
From: Berkant Koc <me@berkoc.com>
Date: Tue, 19 May 2026 22:08:59 +0200
Subject: [PATCH v3 0/2] drm/hyperv: harden host message parsing
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

Two independent issues in the synthetic video driver that both stem
from trusting unvalidated host data.

1/2 bounds resolution_count from SYNTHVID_RESOLUTION_RESPONSE against
the supported_resolution[] array, and populates WIN8 defaults for
hv->screen_*_max / hv->preferred_* in both the WIN10-probe-failure
path and the pre-WIN10 path, so a failed or pre-WIN10 probe yields
a usable display instead of having drm_internal_framebuffer_create()
reject every userspace framebuffer with -EINVAL.

2/2 forwards bytes_recvd from vmbus_recvpacket() into the sub-handler,
rejects packets that do not cover the synthvid header, and additionally
requires the type-specific payload size before memcpy/complete or
before reading the feature-change byte. Rejected packets are logged
via drm_err_ratelimited() instead of being silently dropped, matching
the CoCo-hardened pattern in hv_kvp_onchannelcallback().

Changes since v2 (per review by Michael Kelley):

  1/2: dropped the reinit_completion() change. Kelley pointed out that
       the negotiate-version and update-vram-location timeouts cause
       hyperv_vmbus_probe() to fail and free the device, so the stale
       completion can only outlive its request in hyperv_vmbus_resume()
       after a get_supported_resolution() timeout. That is a narrower
       fix and belongs in a separate patch against the resume path.
       Subject and commit message rewritten to reflect that this patch
       is now bounds-check + WIN8 fallback only. Pre-WIN10 branch now
       also populates hv->preferred_* (Kelley spotted the gap).
       Followed the post-probe-test refactor Kelley suggested: the else
       branch is gone, a single screen_width_max == 0 check covers
       both the pre-WIN10 case and a failed WIN10 probe.

  2/2: dropped the redundant upper bound on bytes_recvd. Added a
       per-type switch for the three completion-driving message types
       (SYNTHVID_VERSION_RESPONSE, SYNTHVID_RESOLUTION_RESPONSE,
       SYNTHVID_VRAM_LOCATION_ACK) so the wait-completion path
       validates payload size before memcpy/complete. Every reject
       path now emits drm_err_ratelimited() rather than returning
       silently. Commit message rewritten to lead with the residue
       read, with "wasteful copy" reframed as the secondary observation.

Changes since v1:
  1/2: bound resolution_count check folded into the existing zero
       check; populate WIN8 defaults when hyperv_get_supported_resolution()
       fails.
  2/2: forward bytes_recvd into hyperv_receive_sub(); enforce the
       pipe + synthvid header minimum; check synthvid_feature_change
       payload size before reading is_dirt_needed.

Both patches carry an Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
trailer per the kernel coding-assistants policy. Code, analysis and
review responses are mine; the model is used as a structured reviewer
under human verification.

base-commit: 4bf5d3da79c48e1df4bab82c9680c53adeff7820

Berkant Koc (2):
  drm/hyperv: validate resolution_count and fix WIN8 fallback
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 58 ++++++++++++++++++++---
 1 file changed, 52 insertions(+), 6 deletions(-)

--
2.47.3
