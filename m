Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB96606A334
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omUzO/uM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DF210E572;
	Fri, 27 Nov 2026 10:22:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8458F10E572
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:22:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFB0562784
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197651F00897;
 Fri, 27 Nov 2026 10:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774921;
 bh=atXFV7W5fSwFX+/NG6EcW2OUCG4YVT6oYWVELQgR7/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=omUzO/uMpgCiJy0zhejU3m84K9vvjKYKSMUR5TOq83+DLjbkSPTE/IhCBQLsnm4J1
 +QtOtfkqbCVNyqUctbWJm0UKV8Osow8/8HbUkGdBclMaQ8s6ptP8RF2S9guMgON2Nk
 att7TossuEmeaJ2u/NkLdMXkhIpFt2JNzwBqVZKkzjf+vJMxMuzgnde/AW/q9L1hS9
 55HS57cbG4f+/iW5lz1sen/aJrrOeLPUhwkqShMwrpjGeTtIJmIo2rmb7rMfspIBKD
 unx85mJuVvl+IrwV3bq3KourjRk6x6DSz4bzP4hDjYdhd2G11jh+X6SRStMfItrbhU
 TcKU+bu4Ehjcw==
Message-ID: <sashiko-outbox-237104@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH DO NOT MERGE v10 35/36] drm/tidss: oldi: Implement
 hardware state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-35-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-35-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:22:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tidss: unchecked tidss_runtime_get() in
  tidss_oldi_read_config()
--

commit 2762eab17658c967fdc58a9d8bbcd85c2c59c6e6
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: oldi: Implement hardware state readout

This commit adds hardware state readout callbacks for the OLDI bridge to
reconstruct the bridge and connector state left enabled by firmware.

> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/t=
idss_oldi.c
> index f767b0c115ac3..0ad4ef34ba640 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c

[ ... ]

> @@ -350,6 +355,154 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
> =20
> +static u32 tidss_oldi_read_config(struct tidss_oldi *oldi)
> +{
> +	u32 cfg;
> +
> +	tidss_runtime_get(oldi->tidss);
> +	cfg =3D tidss_get_oldi_config(oldi->tidss, oldi->parent_vp);
> +	tidss_runtime_put(oldi->tidss);
> +
> +	return cfg;
> +}

[Severity: Medium]
Should tidss_oldi_read_config() check the return value of
tidss_runtime_get()?

tidss_runtime_get() wraps pm_runtime_resume_and_get(), which drops the
runtime PM usage reference and leaves the device suspended when it returns
a negative error code.  Proceeding on error reads DISPC_VP_DSS_OLDI_CFG
while the DSS is suspended and calls tidss_runtime_put() without a
matching reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D35
