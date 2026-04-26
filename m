Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56777FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E2310E194;
	Sun, 26 Apr 2026 08:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="WMXgWCqC";
	dkim-atps=neutral
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AC710E194
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777190719; x=1777449919;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=WMXgWCqCJ/7Xb48ijUqafvDUBgCd0z86K+APwniTvg1Cg0LrUx9+PScwMBpeP4uxa
 jWzwDXkpX3JyrZaCoJj9G7wWJPRZ2gLOSRCogXqgzc7GYa3sBVlDTKAlynJF38vwnf
 gekbodsxtch7KKoUGL51nQiSGwgYL0GBvFlK/ihctE3HLuLrtb7NHp+9hXnKn6zBZn
 Vl6MQCA0suTId3Wh0lx0n92lLIUN77fS/g9KXTdkMy8K4xtOHfjZHhYI4NvoDpBMPn
 TQoVprL3rNjA8YG+P6gn5EZYKxJrUhFlqQ2rMfQs4VhoAXIq2jmPf7mzX0wE4ztCUf
 JETR39HCq9rVw==
Date: Sun, 26 Apr 2026 08:05:15 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v10 05/11] drm/fourcc: Add DRM_FORMAT_T430
Message-ID: <VA0NYRaJ0iQ1QCxWnRFLMh9x3Jf757mXB8N44Yi4hohJxGjMe34UHsDdxUpMSkLyKhzBlXY7uj4fIkd9FE1VBd3ZC0DKdkJpPaN7A_-2z4w=@emersion.fr>
In-Reply-To: <20260423-xilinx-formats-v10-5-c690c2b8ea89@ideasonboard.com>
References: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
 <20260423-xilinx-formats-v10-5-c690c2b8ea89@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d0e099f4c50983dac4eec8186294db13ed8244c6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Simon Ser <contact@emersion.fr>
