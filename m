Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA27ECCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309E310E035;
	Fri, 16 Oct 2026 10:21:22 +0000 (UTC)
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B6810E035
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:21:15 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ePQBThGmX/JowWmwIAHFYGbeGr5rO+nqnx/5hznaO+4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792146073; v=1; x=1792750873;
 b=mhS3KDo+NRypHYmSo3Gu1fIinuyijCxyCk8sctgz4o1xzL2MQMR1cEUlXA5tqkQD8pk2hwAr
 KfTf56l2Htd7WhtDJJki1QbJUy/duwjKHIh8yKeBNFCbAvzgHCkP9OpBUvEMO/QvSxmMCoj1XK4
 5tcPa6LtmBS0XQQvLmbR7hwU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id ac7aa4222085074f;
 Fri, 16 Oct 2026 10:21:12 +0000
X-Mizu-Trace-ID: ac7aa4222085074f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/75] drm/adp: Switch to
 drm_atomic_helper_connector_create_state
Date: Fri, 16 Oct 2026 15:50:58 +0530
Message-Id: <C47BD96C-AAF4-4A0C-95B1-6FE0E1715578@linux.dev>
References: <20261014-drm-no-more-connector-reset-v1-2-586c9c026823@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Aun-Ali Zaidi <admin@kodeit.net>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-2-586c9c026823@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
X-Mailer: iPad Mail (24A446)
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



> On 14 Oct 2026, at 10:57=E2=80=AFPM, Maxime Ripard <mripard@kernel.org> wr=
ote:
>=20
> =EF=BB=BFThe adp connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Aditya Garg <gargaditya08@proton.me>
> Cc: Aun-Ali Zaidi <admin@kodeit.net>
> ---

Acked-by: Aditya Garg <aditya.garg@linux.dev>=
