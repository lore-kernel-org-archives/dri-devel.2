Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38FECD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1801610E07D;
	Sun, 17 May 2026 13:10:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="pfpT511i";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDA510E07D
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
 :Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eAHnVX5ofCROL6dD/lUWJLdN6yFCfghtocjMNvR+AIY=; b=pfpT511iiLMpDH2n2tGpOrAA/z
 mcvV4hoVjiHCy+WT0ZjSDbuqywwAIZP9nBwoNtbtCVuqWNaDreWSeZUGz8T5j4T7xnYj6U2my5FiM
 RHo0+LBwPgUVtOH87IddThLvXWFGt5+XnZE3DKJDcGIgFNHGHVhWFR0J7Wh8FFupI8zQXPR0FEf6o
 JBZmP4Hhn/1IDJsV3AzHYPBp3nLnVT8lci/EBT+Frnpnjg9C4eNFmvFVKXHDIvhgXaqOTgWCMJoMb
 0LS+6D8qT0WyQ/e4X3EKvBr3lBIMbu9Pu4awb6J5uL/2JNEIZAq/HoPsWzk3SNYKoqBf+nSSRghBa
 e+eurULg==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wObFn-00G0yq-2c;
 Sun, 17 May 2026 13:10:00 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 0/2] drm/hyperv: harden VMBus message parser input validation
Date: Sun, 17 May 2026 14:55:00 +0200
Message-ID: <20260517-drm-hyperv-cover@berkoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The hyperv synthetic video driver parses VMBus messages from the host
without bounding two host-controlled values that feed into fixed-size
buffers. Both items are input validation, not security bugs: the
Hyper-V host sits inside the trusted compute base under the default
Hyper-V threat-model. The patches still trim the inputs the driver
accepts at face value, matching the trajectory drivers/hv/ has
followed for Confidential-VMBus work where the host is no longer
fully trusted.

Patch 1 bounds resolution_count against
supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT]; the existing
default_resolution_index check is bypassable when both values
exceed 64.

Patch 2 forwards bytes_recvd from vmbus_recvpacket() into the
sub-handler so that vid_hdr.type and feature_chg.is_dirt_needed
are only read once the host actually delivered enough bytes, and
so that the init_buf memcpy uses the received length.

Sending as a plain patch series, not a security disclosure.
Compile-tested against drm-fixes (6916d5703ddf), static-only.

Berkant Koc (2):
  drm/hyperv: validate resolution_count from host VMBus message
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3
