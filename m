Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E683109023F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C535D10E8D8;
	Thu, 19 Mar 2026 15:21:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="lpLs5MoW";
	dkim-atps=neutral
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 017FB10E8DB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1773933707; x=1774192907;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=lpLs5MoWSLMPshfY8mDWAAtuWnhNjAJLnbOUvpaCs+fa4brd+62ef5oQPbCofQ+P8
 JDztgoo1HuT+ZUAgQN8yDEBpw9aL68mIeonYtUb2P7hQH9zivCmtUDiYrT0Fa/WprX
 3hQBisrnoO7gx3I8R+kjNK7+YBOO641WYa2DklXTvAe5URhWzaE6gW2W9i7eCIOOHr
 XLm+yALzmVm9JgpEQhGX8qdFaYgM0Jpkt/pLv7JQN+vWlUnMzZL2ah0Qf1ugdVO+yi
 U3IuSWbLytJkDbuBnrcgjUUXdJSaymh5wnokULcMs+2iiC2WfgX+aOEk27tP2e5bGz
 lrVkcNE38rhtA==
Date: Thu, 19 Mar 2026 15:21:43 +0000
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
Subject: Re: [PATCH v8 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Message-ID: <ylgbwImdBAhbbTKiTvS6-hmqPs0kxSFTB5bvlM1TzeTCgaJK7AJfdEPJJwaIR7fHdgyOJBmxO_p4cNTfrLXe16Cwj5m2El5e4uog20Qxw8c=@emersion.fr>
In-Reply-To: <20260128-xilinx-formats-v8-6-9ea8adb70269@ideasonboard.com>
References: <20260128-xilinx-formats-v8-0-9ea8adb70269@ideasonboard.com>
 <20260128-xilinx-formats-v8-6-9ea8adb70269@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 45e84e170336b2f5386496980d02a320d185e866
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
