Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23140606A766
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWnHnCx3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CA010E1B8;
	Tue, 10 Nov 2026 13:24:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB89410E1B8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:24:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B1C36381E;
 Tue, 10 Nov 2026 13:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE031F0089F;
 Tue, 10 Nov 2026 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794317045;
 bh=Qd+x0eVo+cyF4CBCmbLcOFOdzScPFfljM2ND0bbWF+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JWnHnCx3RNzTA0semJgFPinMTnle/wqsnx1K1PY5gs7axQ3XJyxxEQBZ8iirat9JX
 IJ780kS4E9bT24AjQQCpA0i77qdCN5mzn5CVBiyn0yQi2ZLphN/9E8iq4/Kffc93mh
 FtJIIlX6Ap6qJZvikvOfvg2FoqBNptvzqFISlz+RWprxmVBP1cqtcvUOlibGZJvYec
 bsaKUXWaszMkVm0MQMZhnn+8G2MBPRTjnRY7G6kdgIP8IdH0mFFVc7GPuC3h5ZIk+I
 VCAWY970wx/sOQRKIvURbpeKuzFhuJHPEtYxL1E50onZ4nWrRPszX3I8Ed4l0hug2y
 NZ90w0RNf3OeQ==
Message-ID: <sashiko-outbox-207117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amd/display: Apply requested TxFFE level right
 away in FRL training
To: =?utf-8?b?QW5kcnplaiBQacSFdHlzemVr?= <andrzej.piatyszek@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110130956.160024-2-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
 <20261110130956.160024-2-andrzej.piatyszek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:24:05 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/amd/display: busy loop CPU stall in
  hdmi_frl_perform_link_training() [1]
--

commit 91fe51195d67c76e4e3cbba1f95c962c1ab46a75
Author: Andrzej Pi=C4=85tyszek <andrzej.piatyszek@gmail.com>

drm/amd/display: Apply requested TxFFE level right away in FRL training

This commit programs the requested TxFFE level immediately during HDMI FRL
link training when the sink requests the next FFE level, rather than
deferring it to the next poll iteration.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.=
c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> index 960f18fe275b2..78e62bfec49c7 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> @@ -640,26 +640,6 @@ static enum link_result hdmi_frl_perform_link_traini=
ng(struct ddc_service *ddc_s
>  				prev_flt_update =3D scdc_update.fields.FLT_UPDATE;
>  			}
> =20
> -			/*Set TxFFE =3D TxFFE0*/
> -			/*Program FFE_Levels - scdc_config has this field at 0 */
> -			if (override_FFE) {
> -				if (current_FFE =3D=3D 0)
> -					dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
> -							test_req.fields.TXFFE_DEEMPHASIS,
> -							test_req.fields.TXFFE_PRESHOOT,
> -							test_req.fields.TXFFE_NOFFE,
> -							link_settings);
> -				else {
> -					if (scdc_update.fields.FLT_UPDATE)
> -						dio_link_enc->funcs->prog_eq_setting(dio_link_enc, current_FFE,
> -								test_req.fields.TXFFE_DEEMPHASIS,
> -								test_req.fields.TXFFE_PRESHOOT,
> -								test_req.fields.TXFFE_NOFFE,
> -								link_settings);
> -				}
> -				FRL_INFO("FRL LINK TRAINING:  TxFFE =3D %d.\n", current_FFE);
> -				override_FFE =3D false;
> -			}
>  			if (scdc_update.fields.FLT_UPDATE) {

[Severity: Medium]
This problem wasn't introduced by this patch, but can the SCDC status
polling loops in hdmi_frl_perform_link_training() [1] stall the CPU
core by busy-spinning between polls?

drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c:hdmi_frl_perf=
orm_link_training() {
    ...
		do {
			flt_poll_curr =3D dm_get_timestamp(ddc_service->ctx);
					elapsed =3D dm_get_elapse_time_in_ns(ddc_service->ctx,
						flt_poll_curr, flt_poll_start);
			if (elapsed < (num_polls * wait_time_ns))
				continue;
			num_polls++;
    ...
}

When FRL link training runs on an HDMI 2.1 display, both the FLT_READY and
FLT_UPDATE loops spin on dm_get_timestamp() and dm_get_elapse_time_in_ns()
while waiting for each 2 ms wait_time_ns interval without sleeping or
yielding the CPU, which monopolizes the core for up to 1 second and can
trigger soft lockup warnings.

[1] https://sashiko.dev/#/bug/linux-4798172c-1032-4f55-aa52-1cbebc19449f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110130956.1600=
24-1-andrzej.piatyszek@gmail.com?part=3D1
