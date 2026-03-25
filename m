Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC701106B53F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B42110E83C;
	Wed, 25 Mar 2026 14:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="QzdjOiqL";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A829C10E7F8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1774447553; x=1775052353; i=markus.elfring@web.de;
 bh=u23klA8/tUFH4NA33VZFcitcYgHXv0lrbMT5xAzySEc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QzdjOiqLE/TiUEBemDhtFb5OqKzTgVn2DSBC3vDGQU+4Cg/nB6Kx/j6eApAH2RcA
 yRAaf9sbh3l2w+MGmzA3VIR7uLyIEf3C+1xKCkemJHX+BE8SbQb2nder9GVGESTlc
 HUelhIf+qNANxoSa+A9kCE6l/LseHiSv163O0TvaQg/+90bOkd33NA35ulUHGJN+x
 h3v626N8DhQdP1GV30wc/NJCZeHtXQLn1+rqakkr++946lc+V1GQfvUwfXs0MQKWZ
 wPuS89egg+rRxoNWfsBkoiuiz8acfUqfYKkjHAdUWk7ItzgeY0Wq6WgetbqXC1672
 fyLGdVWSMhHoERzOGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1w8hBs3Qui-007TS5; Wed, 25
 Mar 2026 15:05:52 +0100
Message-ID: <e3631a8e-b4a4-4e14-822d-2199f1576cc9@web.de>
Date: Wed, 25 Mar 2026 15:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/nouveau: Omit a redundant pm_runtime_mark_last_busy()
 call in nouveau_pmops_runtime_idle()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d5UJvMslD2Hr4TKib2ej8EpiK17V/AqdMAvX/HeRHdEV4eQZ+0h
 qT5l+WbwB7AvX67crgHdTNM3gRM17iMrmiAjFtlZ/krFcXVfCABMQn4mMUqSDdOZtMxuwjt
 q23TeT6t8zYceYPnj7SQthCMhQswWUFa9NHiBd/BvUmWGlwkEf35IH2d4hXkNYul867tW4L
 fdRhPHXFR/EvzVDftpzaA==
UI-OutboundReport: notjunk:1;M01:P0:Fzpy3f+nNR0=;K/7aauDN3bLCn8p13OuAjpBSJvQ
 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
 Py
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Mar 2026 14:55:01 +0100

The device's last busy timestamp was set in a wrapper function since
the commit 08071e64cb642ae19ebd6ffeb13b4f3d130b5860 ("PM: runtime:
Mark last busy stamp in pm_runtime_autosuspend()").
Thus delete a pm_runtime_mark_last_busy() call before
a pm_runtime_autosuspend() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouve=
au/nouveau_drm.c
index 5d8475e4895e..62ac9593230f 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1209,7 +1209,6 @@ nouveau_pmops_runtime_idle(struct device *dev)
 		return -EBUSY;
 	}
=20
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
 	/* we don't want the main rpm_idle to call suspend - we want to autosusp=
end */
 	return 1;
=2D-=20
2.53.0

