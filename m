Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BEEC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D3D10E805;
	Mon, 28 Sep 2026 08:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="R3Wpr+cU";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BB410E829
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:35:50 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=VUwixvVe2ZNKQ0Cvr2pfIQfr/RuEy7shwKZwOabTpBY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790584549; v=1; x=1791189349;
 b=R3Wpr+cUKEiBanhpOCRBe91WD8B/rfJ78q4MLjslgzq5TYGGz1hRzdm5Fy/4jvJ3Ck5d9uNj
 XNR/GYzpMiXEDc7RAhYR3wkSwyONb0eOcTDWMTVkv7IyRCzbe6DqcrsKz8Z6IHzslWCEsf8VtaB
 4I8MjTjoo9cbXeSfrxUphdrs=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id 40995b2d68ea4a14;
 Mon, 28 Sep 2026 08:34:46 +0000
X-Mizu-Trace-ID: 40995b2d68ea4a14
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drm/appletbdrm: Fix incorrect error message on encoder
 attach failure
Date: Mon, 28 Sep 2026 14:04:33 +0530
Message-Id: <F9EEFFBD-A749-4374-9FF4-75917ED2D204@linux.dev>
References: <20260926-fix-err-msg-appletbdrm-v1-1-bb578a7dbdda@gmail.com>
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Atharva Tiwari <evepolonium@gmail.com>,
 Kerem Karabay <kekrby@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>
In-Reply-To: <20260926-fix-err-msg-appletbdrm-v1-1-bb578a7dbdda@gmail.com>
To: azuddinadam@gmail.com
X-Mailer: iPad Mail (24A437)
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



> On 26 Sep 2026, at 6:49=E2=80=AFPM, Adam Azuddin via B4 Relay <devnull+azu=
ddinadam.gmail.com@kernel.org> wrote:
>=20
> =EF=BB=BFFrom: Adam Azuddin <azuddinadam@gmail.com>
>=20
> drm_connector_attach_encoder() replaced an earlier call to
> drm_simple_display_pipe_init() during review, but the error message
> logged on failure was not updated to match and still refers to the
> old call.
>=20
> Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Mac=
s")
> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>

Reviewed-by: Aditya Garg <aditya.garg@linux.dev>=
