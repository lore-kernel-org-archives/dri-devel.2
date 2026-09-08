Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D103C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 565FC10E0ED;
	Tue,  8 Sep 2026 12:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LvCSllkj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B7B10E0FC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EB1B42E6C;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56667C2BCFB;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788871504;
 bh=tggSJCl2AdaSwI6K1UKsXMUFn3nfnZ+dlVIx8qMmy08=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=LvCSllkj2sm2J7JLd9pjsN4toGFiIanibYlRwxG8GRLppF9gcb+Q9E/2lfAUlcAMd
 CZ2Tqh3jfpZVXNznujApSMNDS8W9gpLjcB5jp9Ct9Wvyo6ZQC9MdB0CGxFHjG6XTne
 BPyDrS6EnQ9wDYqYk/7jikloDFqQMMvfIE0YVjXhgJEnhaOCoNZSs5/Gjil7A6YpEe
 0rp387o2TmN1ZzqVs7BmQ1jPJwnuBA4xVDYVJm2aacX9r1A3QSs6skSiwegDEdrvai
 CQlQNOswOM533J5YZhr8zVl+TPdfEbAOMSkmPvWN9X41qJhm77/1A6akfI9O/cX1VB
 DAVBVuXNoGOjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8FC79F99;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v2 0/3] Xiaomi Poco F1 (ebbg display variant) fixes
Date: Tue, 08 Sep 2026 14:45:01 +0200
Message-Id: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NsQ6DMAxEfwV5rivHAgqd+I+KgQQDXgAlFNEi/
 r0pXTu+O927HYJ4lQD3ZAcvqwadxgh8ScANzdgLahsZmDgnw4xibY/dUtxMiZ1uzzmgdZKlBWd
 kiSEOZy+xOaWPOvKgYZn86/xYzTf96UrK/+lWg4SpFGmeGXJNayrddLm6N9THcXwAEn4yybIAA
 AA=
X-Change-ID: 20260122-ebbg-ft8719-fixups-bce548250b02
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Casey Connolly <casey.connolly@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=tggSJCl2AdaSwI6K1UKsXMUFn3nfnZ+dlVIx8qMmy08=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoANOFJeLQjNYi0kXTpsGdTO+bBpMS+a5Wl0S6
 Nl0RyjUoaiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqADTgAKCRBgAj/E00kg
 ciBnD/wNSFGRfZVkyBhqNF/AkPwW+A9tFaAfw6x8X3yaefweifSqELEDIH87v+L6N1TSxgj32QD
 RNZ6ocaJEAZge4WV6qcvklwSJcWGlwhWFoBDHnIndBbRudUMIkdZkxvIo1htvE9Wn9Gq7GCsCwY
 mhIRGr05Uba06qS+W0SoZt1jt8U+Y0O9N1AOql3NGNv0qRXD63M8cPh2PYBuOFgcu/nQVOrF3m8
 GNB9GKF5dPRjRfjNB7Yp0pUCX+4OrS1opxeRZ4qZi9pin26icIIoMHBqMV+tz7qY+x5eRNJSL5y
 RmNkl2frVAmm4Apapb120L0gG4Rezu9RS/0hC94pRoRAypz4Ku2ZkhJ/7IlDbgEV8yNu4S0zCyg
 WoRACCzChM1NvHTey88xChBgEzsNleOO1GXjqVvzTNkCnFyNuTqIMDBdmhdM0poX/QGKu5Y4dPX
 F2dXB8APaQPmZssiW72lizk5G84nletKZKvHiPRO/y9M4B4pRzyGmw2cQ86Q+XSADb7Hj7HjZlk
 g3r6G1Dt47ugA8YxFSSvqT+CJH+zhTxcc+DbXHn2+Ein+ejEjocHPVGm1NCIrh6RUmvxULnvBOB
 FkHPEFCE+Z1A61t5ROmhpTKdQwRjALU9ow3HIQD40cy5V2cZLJGGWQbZs0Sfrg4hJxyvbBZljdv
 laqYTedl76R230A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Been broken in mainline for some time.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Ignore the disable() errors, as there were ignored before too. (Neil)
- Update the `Split initialization into enable/disable fn` commit
  message. (Neil)
- Replaced the maintainer old email with new, so Joel gets notified
  about this patchset being sent.
- Link to v1: https://patch.msgid.link/20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz

---
Casey Connolly (1):
      drm/panel: ebbg-ft8719: Set prepare_prev_first

David Heidelberg (2):
      drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
      drm/panel: ebbg-ft8719: Split initialization into enable/disable fn

 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)
---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260122-ebbg-ft8719-fixups-bce548250b02

Best regards,
--  
David Heidelberg <david@ixit.cz>


