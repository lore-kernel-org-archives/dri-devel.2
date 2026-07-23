Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADFC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446E910F2F2;
	Fri, 24 Jul 2026 07:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=undefine.pl header.i=@undefine.pl header.b="DXG4+uT6";
	dkim-atps=neutral
X-Greylist: delayed 1799 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 22:43:52 UTC
Received: from 18.mo581.mail-out.ovh.net (18.mo581.mail-out.ovh.net
 [188.165.56.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A2E10F249
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:43:52 +0000 (UTC)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.43.232])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4h5lWx0VfQz5vbt
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:04:12 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-gjk7l (unknown [10.108.42.33])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 084A0100111;
 Thu, 23 Jul 2026 22:04:11 +0000 (UTC)
Received: from undefine.pl ([37.59.142.109])
 by ghost-submission-7d8d68f679-gjk7l with ESMTPSA
 id xXZNJtuPYmpDCxMApf6feA
 (envelope-from <undefine@undefine.pl>); Thu, 23 Jul 2026 22:04:11 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003a285cbfd-0765-4e3b-892e-86827d479a6b,
 87426F91C55002030CE6BF1685E8511121647196) smtp.auth=undefine@undefine.pl
X-OVh-ClientIp: 185.175.106.73
From: =?UTF-8?q?Micha=C5=82=20Szolc?= <undefine@undefine.pl>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix 144hz display mode missing on MSI MAG273R
Date: Fri, 24 Jul 2026 00:03:58 +0200
Message-ID: <20260723220400.17190-1-undefine@undefine.pl>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10366160444970756412
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGXPAn5EWYGaulopc9LtjYhANloL+fYl56CS7FTy1bcj/1Uq25iw04eMLzM5wPVTElQh/UTMOG7LC6s3mHS4IHjIZhjnV/ayWMEVC0vKMXR755ZT7S0vOm+FNszmnKg9lJ+f9BLx13UEUyo9UkGv1M+DmTlplsNVO97pNxzmsZxKZJg9qhUJgBVc3F17IN8qLxEfPVajZRZrJxhcjCSOK1DPbKuvoZjYimOKBm8t43WnsmpAwq0Xrb9lkqwA9ET2qIjdYbJW8trrLeKqZzuD7echnEUzG/YY4DOmrO3EpZGX9zlHHaojMRrSuY5gnmH1trMoT8SjLwHZw4diZQN0PgLeA5nmdsvQJ/yNYdIIwg482bGQbMu/dIxxnFsc4yEJ+Eo8TTO1Z6kWC/BTxfSRJhuZZWHp+dfuuDJcf6XtTDgQYf5I9nuaMdsa+mwmtXrrlymSP8NeB8bg/fS80Pm8x2YCaVE1Y7M0ublxoslVPar6xSUSMj+9Y7P/afLz1q1qHfx1j/iBfpNwGPybRoR9qJUiRviwxugb7lCR6DzLqZGHR8UgZ+8zm4+XgmGI6bRHyXRUaGa73paQo3cbVs7qidpERg2muPlkxU+Ji7KkczOHUkt/oybEO+NfSTtKYJjWWMlnhHCXhWyYGkQOnK2HmSFv4gCsjQVK3cVdSdQiWZAgw
DKIM-Signature: a=rsa-sha256; bh=eyrFJwW89pSLCySXMMLjjvFtCQH36wGqj2HOxKIAeiY=; 
 c=relaxed/relaxed; d=undefine.pl; h=From;
 s=ovhmo4647562-selector1; t=1784844253; v=1;
 b=DXG4+uT6pGfc3UFpfckJMOwQpap0RdwhAYfnZxCu/ke5tfb8sykoZTuRMlBC0US2miO2wf7z
 6NQ4wWCH0jSzfFHVuqhPmtlhwWi1B6qVSuutSRYKtu01CEzu3nuh7UPd3hRg6OXpTit8gpajbrS
 xN4ZHhFxXt/iWXgXBDqmqLs+lUS7w57YfeTUlH6M32YoLTbWh4GvQ5Ps8VHAmP4IkoPI30bsE67
 LP9eDPI/FbIE0awB93gDqRgj8EMpogl9rtyRUwvzPvSdup0dlBmquOkpLdMQz+g+k7PyP0KXhwm
 EfH2iHWxpFHGdOFU3wUMsRGfrNufeLagC28xQ5sja0VWg==
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

Hi,

This set of two patches works around a incorrect EDID table presnet on
my MSI MAG273R display. Because of how the table marks the mode as stereo,
even though it's definetly not, a otherwise completely valid 1920x1080 144hz
mode gets rejected as unsupported. This adds a new EDID quirk flag and marks
this display with it, which resolves the issue and makes the mode available
which matches other operating systems.

Best regards,
Michał Szolc

Michał Szolc (2):
  drm: add a EDID_QUIRK_IGNORE_STEREO_FLAG quirk
  drm: mark MSI MAG273R with the EDID_QUIRK_IGNORE_STEREO_FLAG quirk

 drivers/gpu/drm/drm_edid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.55.0

