Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE36E1090239
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132CE10E894;
	Thu, 19 Mar 2026 15:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="nQmikT5x";
	dkim-atps=neutral
X-Greylist: delayed 992 seconds by postgrey-1.36 at gabe;
 Thu, 19 Mar 2026 15:15:47 UTC
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E48410E894
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1773933331; x=1774192531;
 bh=kFgqb5rsN304hn1yidJ0nOfikkdeXDRLu7+cGvuE37A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nQmikT5x3kyd5Oxybtr4gMfEdbAbzl1gxcS7x28m0QtxshPqbo+1RVwYUe5OiDN1d
 8cXgoVIoTZ2RxMLhOyahWn/+DsuRkQnHgyo1W0a5Lau2p2Cg3dFwSyFBRXAm0SmfZc
 mCyJRkUnrDcoeWvmp52ATX/m8bY+DOrVYsv2g4Nkb3l0wRpnWrgeg2HXz3ES/XjCr4
 Abh3J4rUsuDENL23pq5abzrexuoLhSJqxVKpoP/MxzU39w4F6Ir5Rc+bJOpZrclV4b
 ceZzM3SoFs+Bhq02z2oV0mfICymjmAWLMWfBb66OjEQYjZlwySMFYajRTzrWWkmGQt
 Ut9qevb4B5MTw==
Date: Thu, 19 Mar 2026 15:15:28 +0000
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
 Pekka Paalanen <ppaalanen@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v8 02/11] drm/fourcc: Add DRM_FORMAT_XV15/XV20
Message-ID: <K_oXHqtPM_1bdhpMkkQMreIZ9OFfJVpHO3GV_wzmK_PvjQEw4Qz3IMBhGDNVQllkLg_GQeMGyOi6wpIFaRjrNkHubTwWQm-wqvKYTi6zEA0=@emersion.fr>
In-Reply-To: <20260128-xilinx-formats-v8-2-9ea8adb70269@ideasonboard.com>
References: <20260128-xilinx-formats-v8-0-9ea8adb70269@ideasonboard.com>
 <20260128-xilinx-formats-v8-2-9ea8adb70269@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 7e4f2e126e572c1a68030735b1f4e911c7446907
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

What is the difference between DRM_FORMAT_XV15 and DRM_FORMAT_P030?
