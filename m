Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278DCC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A47210EA97;
	Tue, 25 Aug 2026 14:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="FjVlePJB";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B343A10E74F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787571184; x=1787830384;
 bh=l1mccToKf0ZcEvXHlVvQTTvogU2Z18sWQRw6gTi8wbM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FjVlePJB/V6p1QDeQHh7CzO6TFLXOP8bAnzLonhCdiJATTa02Tz1nSnlB1lEw7mWS
 yHM0Mhu4lU739zS/u2DiGHIsg4vLVlbfitoSbgg4sUdxscII69uffHivwkhtqhKsxO
 SK+6YWOi5dziJ6E5K1aTeyDZP1Be76R/azhC/5B/YiMhLZkt19CfY1BH+/9/uYmcrt
 7tNTaDKWv2Mzid3UkSlEnqveiFGoUYBFDdpinMkQUJ1PE0w9DP77DeAK3060qpHFkK
 8DmsxW44ZAZLMzGTc6QmjFP8KXu6VrlWEL/cFGnYCSBeKhqaR+vfsLUl8fsBP4ZPh6
 pKxUetl05g+HA==
Date: Mon, 24 Aug 2026 11:32:58 +0000
To: Maxime Ripard <mripard@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [PATCH 31/70] drm/tiny: appletbdrm: Switch to
 drm_atomic_helper_crtc_create_state
Message-ID: <DTRHMWQ3XspmkGczwZhAQOeOEDX7UrR3mIJFxQPPsCKvwlzw8cxkhYUZnPxEWMELBWhxch4jYT5PbFrLx3gGlbmmeEl7w-R6TNG3liLhMVA=@proton.me>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-31-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-31-fb793475c05a@kernel.org>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 44bd58c9f75a8966d88eb6836e3d9efe32e59f29
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 25 Aug 2026 14:35:48 +0000
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

Please use my linux.dev email

Acked-by: Aditya Garg <aditya.garg@linux.dev>

-------- Original Message --------
On Friday, 08/21/26 at 20:10 Maxime Ripard <mripard@kernel.org> wrote:
The appletbdrm crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Aditya Garg <gargaditya08@proton.me>
Cc: Aun-Ali Zaidi <admin@kodeit.net>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/apple=
tbdrm.c
index cdd35af49892..94bad6dc720e 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -596,11 +596,11 @@ static const struct drm_connector_helper_funcs applet=
bdrm_connector_helper_funcs
 static const struct drm_crtc_helper_funcs appletbdrm_crtc_helper_funcs =3D=
 {
 =09.mode_valid =3D appletbdrm_crtc_helper_mode_valid,
 };

 static const struct drm_crtc_funcs appletbdrm_crtc_funcs =3D {
-=09.reset =3D drm_atomic_helper_crtc_reset,
+=09.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
 =09.destroy =3D drm_crtc_cleanup,
 =09.set_config =3D drm_atomic_helper_set_config,
 =09.page_flip =3D drm_atomic_helper_page_flip,
 =09.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
 =09.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,

--
2.55.0


