Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD0C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C0110F797;
	Thu,  3 Sep 2026 21:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NRf2a97M";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DFF10F795
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788470364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V+ivPl/bBPynzPSC3l90NNDtIXavG6rGZEe1eNaVeWQ=;
 b=NRf2a97MoJIZXZazNjifBp5JGiISCkeIz1XbKfOAQLi7mys3tWrOiRbAyuEPqX2ijYpYV/
 u3PWMLemq6q14i3Gw44qaM72+/YC72fhkIZMNeUf2tc3Ahclk0y2abhclRgX0py53Jm7VE
 k2QTvsJ47uuyoyFwZ8pvNLCMhkUR2uk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-uXVg2v7uMqCraDfVrEM2tQ-1; Thu,
 03 Sep 2026 17:19:20 -0400
X-MC-Unique: uXVg2v7uMqCraDfVrEM2tQ-1
X-Mimecast-MFC-AGG-ID: uXVg2v7uMqCraDfVrEM2tQ_1788470358
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BC301955F75; Thu,  3 Sep 2026 21:19:18 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.64.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C53ED1955F70; Thu,  3 Sep 2026 21:19:15 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@lists.freedesktop.org
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
 "David Airlie" <airlied@redhat.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, "Simona Vetter" <simona@ffwll.ch>,
 "Gerd Hoffmann" <kraxel@redhat.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Christian Hergert" <christian@sourceandstack.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/2] drm/virtio: Damage clip fixes
Date: Thu,  3 Sep 2026 17:15:50 -0400
Message-ID: <20260903211914.1109100-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: RBBZJ6b6MGKrCK4WYe5sgi77o7aRThvdxNGr9j_VFAE_1788470358
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

A previous associate of mine asked if someone would be able to help with
upstreaming some work that they had done recently for virtio, and I was
more then happy to help. These fixes help maintain FB damage clips
between framebuffer changes, which were previously discarded even when
userspace provided accumulated per-buffer damage.

Patches apply on top of drm-misc/drm-misc-next.

Christian Hergert (2):
  drm/virtio: preserve damage clips for rendered resources
  drm/virtio: Recalculate ignore_damage_clips on every update

 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: f9c2f70ee41544717b3c209083073db1e21f919b
-- 
2.55.0

