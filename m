Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wPsZvtKZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7D610EB70;
	Thu,  5 Nov 2026 17:43:12 +0000 (UTC)
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BE210E5C2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:43:05 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=7JNvjn+jeD3c3VP/nZVaHjGT2t4QelKE970Stc6lRuc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793900583; v=1; x=1794505383;
 b=wPsZvtKZhEPuvBDN/B8n0Vl8V8Qg1MouH/tQbx/QbBowoNoBmkZG2BT1YsB6M1j/MhThZY3M
 n9NOTs4FhqGwZ1r6SM1gP3VVyhSyrlJjaV6yIOa4/F9ccoDDANR6fVq0iVmdruUAOhDnJ5nL5MY
 pmVwFCAmUKgBR679GLF3zZ/c=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id 2e8a26deb936811c;
 Thu, 05 Nov 2026 17:42:00 +0000
X-Mizu-Trace-ID: 2e8a26deb936811c
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RESEND 03/83] drm/appletbdrm: Switch to
 drm_mode_config_create_initial_state
Date: Thu, 5 Nov 2026 23:11:44 +0530
Message-Id: <10872E5C-9300-4043-9EAA-7B44B431ED70@linux.dev>
References: <20261105-drm-no-more-config-reset-v1-3-1f58d1e33380@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Aun-Ali Zaidi <admin@kodeit.net>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-3-1f58d1e33380@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
X-Mailer: iPad Mail (24B119)
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 5 Nov 2026, at 9:00=E2=80=AFPM, Maxime Ripard <mripard@kernel.org> wrot=
e:
>=20
> =EF=BB=BFdrm_mode_config_reset() has a dual role: it creates the initial K=
MS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Aditya Garg <aditya.garg@linux.dev>
> ---
> Cc: Aditya Garg <gargaditya08@proton.me>
Pls use my correct email address ;)
> Cc: Aun-Ali Zaidi <admin@kodeit.net>
> ---
> drivers/gpu/drm/tiny/appletbdrm.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appl=
etbdrm.c
> index ebfe37557bfe..73315d538fbb 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -730,7 +730,5 @@ static int appletbdrm_setup_mode_config(struct appletb=
drm_device *adev)
>    }
>=20
> -    drm_mode_config_reset(drm);
> -
> -    return 0;
> +    return drm_mode_config_create_initial_state(drm);
> }
>=20
>=20
> --
> 2.55.0
>=20
