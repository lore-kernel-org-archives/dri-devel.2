Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B2606A597
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7UT/yA5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D8910F101;
	Mon,  2 Nov 2026 18:06:05 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8756910F101
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:05:58 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a6ee9c59aso180593eec.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793642758; cv=none;
 d=google.com; s=arc-20260327;
 b=iPrzCVS0HIkCXtFBuLRG7rg/GTJd3g8Hc1WESbMY/Cx+fYG4DPknb8LSnXMOiSbxT/
 5iWeUJu9yFPp/Wh6cdB6mxt6jtTdV4sxLDcPr/hzZoR1EBWw7Ru2F2EnmmDbRiZG1RXA
 5vX9dhy25lzEU33M5fJCtgeOLlMbi1703l82zx4d+TWBafBWakiYqmCVgURScUpBxREP
 n9QPn8iDHfZrE2XWAwLQFqPhDrlN7n36g/wmpfU+8KdOx9AVnDVpFRKkNdddrwGs3R5M
 dlrgmuSrFv4ey7YRkFyL0rFIOB7ZS6JRfZFpF7RyCc2POXzYig2s1HGcBH7I7dXm79zt
 xxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3huEh/v4N9UWOL/geowqTMuvh7DybQhVgyCs7ZZTjo4=;
 fh=EvqBAMleAw6l6bno/Mi/7VghMJo7OsvCSLO0m3jKxvw=;
 b=Q6nRMFzliUT76F56mQlgtNc5lAOghE+PZGfeTvgwR+NHoUyNcON6/dnQnwvoeNWrqv
 1YpdEMy5h/a+Qd/V52evQw9FQK3/5F2yLsWGrVKCPpmSjD2xXn0PuIaeAoNJPrDG7diB
 K3XY2PNGbFY9qtLD4JWYl4MLTCCjFBSvL2c0zK9PA15JJzM7WbRnbsiqOttMGfDtktqA
 mgX1lgT+cfvh/oABfu2IrFZRHpizz7uF6uNSK2S4M2OPudwiR/iyT2w9p3lprQFOlE81
 A0mvjs462APnCUOtoRLGd9uudJ2kI8nOADe8KN3T0RSV2OnoL/zmYxfTDIIqdSAZ1QJu
 GqBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793642758; x=1794247558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3huEh/v4N9UWOL/geowqTMuvh7DybQhVgyCs7ZZTjo4=;
 b=m7UT/yA5AXuzrkPc2lJ1i4QtLZ29xZGJ+6K+AnKlnMfbDhFiXy93eigv6M8oPBFSK6
 OoZCpr9L+R4VTQ3JJQ5G0QVWy2kEKYe+XFvEuUGrw5pZygMawEZet8raPVapRxcKbsDb
 s/6mhyWPZCAJzmbiIcTVLpJFNH90sgfueFk9wq8ybCYz/hppHgIjFfh8IB7H5Y8wIk4M
 dAiiJgovYrG2T1Rn+xn+Pf4iN400xJFs3rqX8Jlu6ci+P826DmSzFiIw3ZUfbPUpAoCm
 nmrm2IULLlIu7LofmrWTijcjqXSk0RbKqR52QlHK9O3ugfLFY/5izT4Lt9+C7yUivO17
 idVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793642758; x=1794247558;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3huEh/v4N9UWOL/geowqTMuvh7DybQhVgyCs7ZZTjo4=;
 b=xfLSoulzNB2vjniNZSt422RQtotNKvRLAvxboURWaftu+STJxYNxB4JMCu9js3I8+d
 yr61E5UPgbii05Rk6Fy2/nQnjT/5qbGys4a3KLMjzSqGb1Hm7Vs+H0woUv+Rw684job0
 lX02SMyzDsxlPm5q8a2zUxUz7jdU0IOnSvq6pqKYRG1KyKMOVY5gRcHC7UoMAnNfs8J8
 YcXwNuR6BSSn+OILZ5nkkGqjv2NWLz1CSqQVNIw4BqZSVn7DMOBIPHeS11aFMksxaVMz
 Px7iqiNycLVaM0cLSw372mXgMy3X07FTvtd0GyERW3JCKfuyhwKEJjUQoIcUlqg+YNBJ
 y10g==
X-Forwarded-Encrypted: i=1;
 AKwUvByL+YtX4aqpCweG4EhS1IKSUfhDwQT/iHg49+huArrl9JFlvr3IUqiqJIMbQRuvWogU9pEt93XPkXs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdOLZ4t0iqkTdGOKGcH+Et2YPlNj4VnY5LAfthvCyHqT5z8VWC
 PosqIVtaH2KeghfQ7azfFe+CFEQqVAcyDN7RRJyU2tCYC9EnjUJOi69AsWk/zQ60l56AUwa5Zi/
 DAJGZ1pZQbrV6va5LNszt7ORQENSeM2E=
X-Gm-Gg: AYBFou0uOOwRAk8Dx8PqsDX6uyMi/We864Ro1Uip70/F/tZJiJQUwybO0v+WKni+rfP
 Hb0ajNqjBmSCPEOpiAf3976Yb+7EFgNY2kos14Yybmm/Mj7kh0mYwFXhcrvkGiVocgw3valJvXL
 Lr45Bj85atWgljhjA8SpeNb90K2CCesAMe0wK6XxmCJCmbyShn17GezzIG3/+HqVP8Z3Id3+vh8
 I4QubtRbE4jbkFCgwHDbDRmbJX1x8w7lE1TILEjKozvUOqZJAAkazZNCD2Gs+q514+E1Rp/+hu2
 frTZk0+eGWbxa2rbugZ3IxLKeu9PXfqhCiPHijrk2wDRFVzLAME9pmZFu3xp34R3jqtKQdtvJ8Z
 iw9XL9yaTnG8DR/vgqp7XpVDAILCX2ew1+Se2FgOizb7bf4b/LDDRd4hB/KtvYL7aHnzOyWv9KO
 rBNm6kFhd8acgYzwvrsKqLZIw=
X-Received: by 2002:a05:701b:418d:10b0:190:e602:c769 with SMTP id
 a92af1059eb24-1ac59143aeamr26509061c88.1.1793642757449; Mon, 02 Nov 2026
 10:05:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com>
In-Reply-To: <20261102-superm1-amdgpu-ddc-v1-1-9c5cb4a4f62d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 13:05:45 -0500
X-Gm-Features: AclHuK8DTOuryiTNmHA6HgkG1KsktifDQx-Lx9pK6z_9hvE_l9gU-vyiaBF97Oo
Message-ID: <CADnq5_NomTyHwfX1AoHJwOB5Z9pC+5Tqq35kRdszCAzmUqkpuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Point the DP/eDP connector ddc link at
 the AUX i2c adapter
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Richard Hughes <richard@hughsie.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 simonit.orig@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 12:55=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On DisplayPort and eDP connectors DDC is tunneled over the AUX channel,
> but amdgpu_dm registers the physical i2c bus ("AMDGPU DM i2c hw bus N")
> as the connector's ddc adapter.  The "ddc" sysfs symlink therefore points
> at a bus that does not reach the sink, while the AUX backed adapter
> ("AMDGPU DM aux hw bus N"), which is registered as a child of the
> connector, does.  Userspace such as fwupd, which uses the "ddc" link for
> DDC/CI, has to work around this.
>
> Pass the AUX ddc adapter to drm_connector_init_with_ddc() for DP and eDP
> connectors.  The adapter is registered in late_register, before the core
> creates the "ddc" link, so the link resolves correctly.  Other connector
> types keep using the physical i2c bus.

Would this potentially break systems with passive DP to DVI or HDMI
adapters?  I think ideally it would be better to expose a single i2c
bus per connector and then use either aux or i2c depending on what is
connected.  I think there is a way to determine the sink type
connected.

Alex

>
> Reported-by: simonit.orig@gmail.com
> Closes: https://github.com/fwupd/fwupd/pull/11308
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c   | 15 +++++++++=
+++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..656249dc3f69b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3483,6 +3483,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_=
manager *dm,
>         struct dc *dc =3D dm->dc;
>         struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
>         struct amdgpu_i2c_adapter *i2c;
> +       struct i2c_adapter *ddc;
>
>         /* Not needed for writeback connector */
>         link->priv =3D aconnector;
> @@ -3504,12 +3505,24 @@ int amdgpu_dm_connector_init(struct amdgpu_displa=
y_manager *dm,
>
>         connector_type =3D to_drm_connector_type(link->connector_signal, =
link->link_id.id);
>
> +       /*
> +        * On DisplayPort DDC is tunneled over the AUX channel, so expose=
 the
> +        * AUX backed i2c adapter (registered in late_register) as the
> +        * connector's "ddc" sysfs link.  The physical i2c bus doesn't re=
ach
> +        * the sink.
> +        */
> +       if (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
> +           connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)
> +               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> +       else
> +               ddc =3D &i2c->base;
> +
>         res =3D drm_connector_init_with_ddc(
>                         dm->ddev,
>                         &aconnector->base,
>                         &amdgpu_dm_connector_funcs,
>                         connector_type,
> -                       &i2c->base);
> +                       ddc);
>
>         if (res) {
>                 drm_err(adev_to_drm(dm->adev), "connector_init failed\n")=
;
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-superm1-amdgpu-ddc-63f0eb10c022
>
> Best regards,
> --
> Mario Limonciello <mario.limonciello@amd.com>
>
