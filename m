Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAE4C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE8B10F585;
	Fri, 17 Jul 2026 14:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cvR6fNsu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB0D10F585
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:32:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDC9060A5E;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D511F00A3A;
 Fri, 17 Jul 2026 14:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298742;
 bh=Hvs+gSWZNMPPuyV9xoOKEHmCPYvljPZSyMmo2TUU9wI=;
 h=From:To:Cc:Subject:Date;
 b=cvR6fNsuykGtPvUwc/9XJDzUmWri51iY/N5IHDeIEITY13EI7L49/EK6yqIc3RxjB
 oQ5HEDifNB4Y2fgstJnDYf6J+CJcwx+bayZFmVicY9YLmoDksVNXaikX4n9+E2MmVZ
 yCkQM/GXZySLfoHnwu+s2BIORPiy8qixyRzA9Ngviq8zA3AmO0Snk6F62CiLcu1ci2
 iren6Zi8XkPX76M1JNVAHK/RvPJ/bfqlY1Q8K8Pn122BASxum28w5eLxNcchuKyOfE
 DSvNkGG8cr7tc7NQ2KbqFqlEwJ4VPP4jdb7pUZOxI12fYEu67M0Yv0JaPfCSQnZ7AN
 PXVd0GtScKlkg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkjbw-00000007cDB-0iSo;
 Fri, 17 Jul 2026 16:32:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] drm/panel-edp: take i2c adapter module reference
Date: Fri, 17 Jul 2026 16:31:17 +0200
Message-ID: <20260717143119.1815106-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.
        
Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Johan


Changes in v2:
 - fix a pre-existing leak in a corner case flagged by Sashiko that
   Doug thought was worth fixing
 - rebase module reference patch on top of that fix


Johan Hovold (2):
  drm/panel-edp: fix i2c adapter leak on probe failure
  drm/panel-edp: take i2c adapter module reference

 drivers/gpu/drm/panel/panel-edp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.54.0

