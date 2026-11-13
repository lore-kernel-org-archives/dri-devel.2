Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DD606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DbsQb1ZZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56EA1126DC;
	Fri, 13 Nov 2026 16:59:05 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6801710E6DB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:58:59 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 880032000E3;
 Fri, 13 Nov 2026 17:58:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MVb5iT744tTyx+u4e9UrULc8qZkgleIykKXyvixHqbk=;
 b=DbsQb1ZZMcZohZghIEo83MUlDZT9gSSsi/r9Hg3LR6ddCBoBwX6lXKxulLCc+oaZl/J+is
 bcrc4pz5YZySzmFJiVnzQxnoGYVePd9zwJhgKUq801TOBuXt7zrGAoRa65ah+pz2yS6t+y
 PrBT0MZQRF6k5fXNQGxJMezSeuw30o69Q2tP+POUYMPzTyab0D7jiyiDgjls5lznCXPBDo
 KpGtlYc05zMzJotGHWL7NHm6qiaYE4d9Oex5alRoJu8LvK4BjW/nj4UKKXuwNFKYH3yXI0
 f/8dWkMqlc+VxII0P1h0bssTg9EOAcYa/MqkpBviOTB1N7PrD8YesHMKbQCQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1794589133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MVb5iT744tTyx+u4e9UrULc8qZkgleIykKXyvixHqbk=;
 b=NXfu/agVijYtFB9Mg+fJPOOZ70mT6ScK0MEATod0pno9XOcAEYRrrFcwnIurmvgDLmB6Vm
 f7SYniphHwe0T/FcByOj/0m892mZ5upnmawmAtlhz17IkEy3Jh0YJirozJTiWK3Asr9bZJ
 j2b3soCg4AVtaaiJx4tlF7REWgf/Sfontmw3gLlexnQbseldcBHg27jklwtUXaDnFiZkN2
 9HDoWRUE1jc1USKP3UuDzQbacVk4mJpiRbIKYp6tE5V1rlZG7odmUG5jF/9OFkDuzoOaTX
 uq6JOxNkNIv2vCiYbyBY+wFy6byqBYfIZQwrzsCLlWlFGxfyjmVumUB3y4WpLQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794589133; a=rsa-sha256;
 cv=none;
 b=R6OPrkEVJrFpySZXnv4NcUsLi6Gbr+JfUsLa89AUKOMj3ELDAZOhqeHyRKl3jTO3wfx6z3
 2TMez/WfjXn44AmjCxufIrqW7fmWH8Btac8frthRRdEPkqx44rTB26dQvnYTmEWOyW0sGF
 jqui/XMuvV3NwOFM5IUvs5dK8zenSFBRxwuURH3ri92/79K85Hz5XotJ6UX2Icz6gq4nnX
 hm9y9m+aTXK039Cl178aJ4HEX5ZINDmX+dsuRlFPQhH+pdMJ8Y91s2RVsTnWGkRNMeAlkM
 9+OnvNliCy3kBhmnYkRs6wBOg8wCkBJ0m7k7U1CARDtIh+KklDMEGxnJFhsY7A==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de
 smtp.mailfrom=p.zabel@pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1xRuc1-0041Ib-1X;
 Fri, 13 Nov 2026 17:58:53 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/3] drm/panel: ilitek-ili9881c: Fix Ampire, Startek, and
 TDO panels
Date: Fri, 13 Nov 2026 17:58:52 +0100
Message-Id: <20261113-panel-ilitek9881c-lanes-v1-0-9d9320cc1387@pengutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxB92oC/yXMQQrCMBCF4auEWTvgNBCjVxEXbTLV0RBDpkqh9
 O5Ndfk9eP8CylVY4WIWqPwVlXduoIOB8OjznVFiM3THzhGRxdJnTihJJn6dvaeAqS2Kg/PkTtF
 HayO0d6k8yvwrX29/62d4cpj2HKzrBqrWUrt7AAAA
X-Change-ID: 20261113-panel-ilitek9881c-lanes-b68167d8d33d
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.16.1-dev-53874
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Those three panels got their number of lanes set to zero. Set the
number of lanes back to 4, to make them light up again. Tested with
the Ampire AM8001280G panel.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Philipp Zabel (3):
      drm/panel: ilitek-ili9881c: Fix Ampire AM8001280G support
      drm/panel: ilitek-ili9881c: Fix Startek KD050HDFIA020-C020A support
      drm/panel: ilitek-ili9881c: Fix TDO TL050HDV35 support

 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261113-panel-ilitek9881c-lanes-b68167d8d33d

Best regards,
--  
Philipp Zabel <p.zabel@pengutronix.de>

