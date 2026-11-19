Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F405606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMOt9Gjl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F3A112251;
	Thu, 19 Nov 2026 10:06:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36414112250
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:06:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED20547322;
 Thu, 19 Nov 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795082760;
 b=3i+wF8cCvvEFpiACK0yU15WU+oUA6IEKg3MrOocLmtVnf9uHkNO+gIbc9ktlYv5S52Bf
 gVwNghaySLBEk0148uA0VjCW3vfNSxBF21pAbsBPb1w3H566aW/aVzHPPkRXvZ2DR9Tyo
 Qxae+MoKgpTYXldm6OdDonDn6mumgxUDpsPgIyIT0Zizbm74OU74pFAWhxYzPZ6hdz5Vl
 qGvo1pWW3vTFDA43zVZipALcF+Bg+SOlGi37Cag+pz6WNCcQBIkWuBuJvbJpxt2v3+qb1
 NHGQ5ei2fgjfGjkx3DyEnQcZvtYVQIw8AlIwIgaSfLA58X2xh7N2/9hQhVzuDlgKuDw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795082760;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=y+h4fRI4yRVpiPesILTBbabP6MDYvi3n/RVdn2AnFOs=;
 b=acV+2uZq5ffRWcfh8RN2NNsgm/GaNYm/tEg7JM70y8YhanrD6h6zz/LlPGpvoHivZSD7
 P8//xkZ/Ffqndh4Pj+d+UhiCI7bhqMjledKvwl2uQoCUzyY6gf6hSzWPqu5vQu1PQ9bcv
 SzAD9zYWOsClMGexUTdf+I7llugYeA8cGQ/UaBWsuesv8aPWG6EW5cq11TiUs/jX6j13J
 VOwxuApVJ07Pt7md5glpT/h/0wmXTiJ+YsxwHXkwIhDYCzB1COU67w7g+SL3desJaS3YP
 AKWiC/hD6+a0yjziElAGi3kiQDAZLLmC42IevlRkVKrvf7ccOTECCnU+dgMP1kyYFmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4C9B01F000C8;
 Thu, 19 Nov 2026 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795082760;
 bh=y+h4fRI4yRVpiPesILTBbabP6MDYvi3n/RVdn2AnFOs=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=NMOt9GjlqONaxyR2U01FyLL5gDDNTgMeNc77AhcZQN9B2UNPRul1I8iUqMcHgvzJA
 980y7jA3eZ2yeRd51/JHDk1mWCZlW5PBGnkrapbJi2zFOF8YVBL4qpc2yGlwRgf/Wc
 EqscP4TSoGpwiYKmW3oje8XJZ8/5lMZuTsPokrlPUrscpFHxMXfmbp312Qpe27aiA+
 GdDugRGUPafIZsfuU8WptbSu4E8B+U5cfg85MAx+2HVDt7Oup+Hvf4jft+k3M7hej4
 zA14hQznbFdvIg8Plz0hJzPhww+iXsdjBSJbk+oFIi+02v2F9wP41oekJQfcmf5g3J
 bRqS1daJpJuAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id BB5394B1FE;
 Thu, 19 Nov 2026 10:05:59 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] drm/rockchip: RK3588 HDMI interlaced modes
Date: Thu, 19 Nov 2026 10:05:59 +0000
Message-Id: <20261119-rk3588-interlace-v1-0-993212e389cd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWdOEaZUUr0JYlHYqg6aQKRoSw
 t2tunyL/w/IJEwZbtUBQm/OvKQCrCvwk0t3UhyKQTe6RcROycNcrVWcNpKn86R8i11jo72YGKB
 kq1Dk/bfsh7/za5zJb98PnOcHiCJyo3QAAAA=
X-Change-ID: 20261119-rk3588-interlace-c61908f843fd
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795082759; l=1081;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=R9RXsFkub066PZWp+rp0tXeW89o/uXELOYPZveB+DEc=;
 b=jMxdtnlAV5oAn1dA1lIoCpHGxLQHES3il63J5mA6kBBuRjlxCuCM0pBo5ZPk+7fIIJZ528iEi
 4q+fsLrFqE8DWA7cka6E9VwR/QzXnr3EddCMClhWMIWOnnwv0vWheZN
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 rejects the pixel repeated modes (480i, 576i, 240p, 288p) that
RK3588 cannot send. Patch 2 lets dw-hdmi-qp keep the interlaced modes of
the sink; VOP2 already generates the fields.

Tested on an Orange Pi 5 (RK3588S, 7.3-based kernel): 1080i60, 1080i59.94
and 1080i50 on an HDMI TV show a correct picture with the right field rate
and AVI VIC; 1080p60 unchanged. With an EDID override listing 480i and
576i, both modes are pruned. RK3576 uses the same bridge and was not
tested.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

---
Arun Iyengar (2):
      drm/rockchip: vop2: Reject double clocked modes on RK3588
      drm/bridge: synopsys: dw-hdmi-qp: Allow interlaced modes

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++++
 2 files changed, 6 insertions(+)
---
base-commit: fac7a5f16230779cfb0d50ca49e9467cc94a2ea9
change-id: 20261119-rk3588-interlace-c61908f843fd

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


