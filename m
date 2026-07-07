Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B530CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE32010E344;
	Tue,  7 Jul 2026 21:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="K2Nxrsjc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB4610E344
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BPs/QGqHFvaD1WMt/WlI5vkSTsrB5FtWPbk+4GLS/LI=; b=K2NxrsjckqYSiAENxf54uebLbW
 Su00LH/zx5XP81LVtBC4CsZ1+7c12b5dZgbBMz4Wyi1Q/T0LSycREGNxXXCBVNeC1GxWpXAp/Sp1N
 Umtr93VZq48jbTyHUwA6wjZjgntWPpHZiI+5/PXimv+HGfSqfM1zQ7t63ey9XT1YOdpwP/QkiJ8W8
 Y82cv3tiHxBml+U0Iqbcl7v3nxql6lmxyzwzuRxCF8Nco+rZhhqzEn5+HZ3StDw5QjP/7prCX6rma
 GE6yd0sMtYA8TPgTmmuuj8T/SvHgHkljQdxyddCvVZO98vyyYTC6fwSiXxtHzTvajIIfDvH7Jscb5
 3kKpALoA==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whCvu-00B3dT-Dx; Tue, 07 Jul 2026 23:02:23 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 0/2] drm/v3d: Fix perfmon locking and cross-queue
 isolation
Date: Tue,  7 Jul 2026 18:01:59 -0300
Message-ID: <178345811349.684917.4606525528181403931.b4-ty@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-v3d-perfmon-lifetime-v4-0-d7b312ff2c83@igalia.com>
References: <20260706-v3d-perfmon-lifetime-v4-0-d7b312ff2c83@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 06 Jul 2026 10:29:17 -0300, Maíra Canal wrote:
> A v3d core is able to expose a single set of HW performance counters, so at
> any moment at most one perfmon can be programmed in HW. Currently, the
> driver tracks the active perfmon with v3d_dev->active_perfmon, but three
> long-standing issues makes perfmon handling unreliable:
> 
> 1. The active_perfmon pointer is accessed lock-free from scheduler
>    callbacks, the GPU-reset path and the perfmon ioctls. Note that the
>    v3d_perfmon->lock mutex serialized start/stop of one perfmon object
>    against itself, but the invariant that needs protection is device-wide.
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Refactor perfmon locking
      commit: a57c0d30f8247dcebf3b2395f12bca4191d67664
[2/2] drm/v3d: Serialize jobs across queues when a perfmon is attached
      commit: 9cf5cbd8648102ddee6559217f43b8f5aae48a78

Best regards,
- Maíra
