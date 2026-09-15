Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91EBC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EECA810EE6A;
	Tue, 15 Sep 2026 17:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Q3x0l8WV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A6910EE6A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789493287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQMV+C6BduxG5SehlC0gEQiE9IETMoxRHpnXV+4ZB0I=;
 b=Q3x0l8WVJ92utK40+WugYlCCc0sPLmwL8Gnz8dSSNjamTCVn0Mgw5myWrAZd07kootGqi+
 hWq7yheZGEA704h7VPJPsxPLHTp7D7TmfUZpULnZGSWBGjneVBAI166L/FcsR+TYkaIjXS
 wrK2wWIhbEkO8uBhLshD2h9lP038Zxk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-6XFERDWbOhGhLu0CspGFcA-1; Tue, 15 Sep 2026 13:28:05 -0400
X-MC-Unique: 6XFERDWbOhGhLu0CspGFcA-1
X-Mimecast-MFC-AGG-ID: 6XFERDWbOhGhLu0CspGFcA_1789493285
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-912195e911aso75761436d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789493285; x=1790098085;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VFBA8/Ye2T49r8xXFW9t78+x+y2UgQcI61D6BtQk4CU=;
 b=cZLfRCPU9lNJWGT8o2mpQ+g1eq2EzJwnwWnTLHZ5NJmvgMf1Mcck3fwqFu69F3iXc1
 cZlBKUYoqQCZMPFqWdzt1cBTrIlL3+at8NpAYArHByNsIEy8O546Cv1bdR+XtT8gSJw9
 P3hevNkwFf0UDq5KrjVK6/z6YfLSz6/hvK1ru0dKkJy1Rh2PYcs1z3dvjHseg8aikMeR
 gxPUUkw2agVhIWuRmmmu5K8bXmLM1dZjzU1zMxNfjOq9jevev3wuNXamttSadEjquN2n
 w7nl1TRPfM4smWRpMPYgV4bOgmU38Kdv5qDsbErsfhCiU2oYunu4PF5rsXmngH1/g/z0
 bkeg==
X-Gm-Message-State: AFuF++ll63nKFRx2bx//H9yMDwgHN2cRozOsnQx3i308yssDFAT3y8Y4
 I+W6AYdwB+SwJx3lKoeHhh/ZcneAlpGCwF0R2PDkyYy8n5HyWIInUU1Mw9ttIFtgqeW010RHVNB
 VfAEAZ8Ucy/yD940pbk91lUAn/Nc3LumGOxCIEMS8r0We7914VsQU8iG+YuDkntSUlnU3+9vPbo
 wurA==
X-Gm-Gg: AYBFou3OM4VF7Idn7quWRx1KaDBzkFNHQR5G/IScOJQg/6e4vd54ZIywzvXmJBJh1RX
 uA08Un29SAZQOKJEijvQ6v2/wYP+VS0Eo8T7koaX03OfNiLaKXDwHNc/SfUTSl4NyhQwV/wudc7
 GY5n75+ZWcf7oUs/fYKvhwpBwy5uKoGbs4G72IOodKSpIKvn1r64CT54fiDHzsGFBFgqXkXKjwO
 WEHLCUd6KOwMHEAPwhdn6KXpifokpW64bETnDXp9tP9un+fYXghTzKmoRkH8yIns/lfmIMjKSYc
 0+dpK0sHpdVfeoCImaDRb5C6oYoS9vav7AsBrSxjVLLZmvFPDZyyK+TLkd8Z4HGGzSV/XyCj
X-Received: by 2002:a05:6214:618a:10b0:912:33a0:5d7d with SMTP id
 6a1803df08f44-91233a05ed0mr65594326d6.18.1789493284574; 
 Tue, 15 Sep 2026 10:28:04 -0700 (PDT)
X-Received: by 2002:a05:6214:618a:10b0:912:33a0:5d7d with SMTP id
 6a1803df08f44-91233a05ed0mr65593816d6.18.1789493283961; 
 Tue, 15 Sep 2026 10:28:03 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bddd5e1sm3872156d6.3.2026.09.15.10.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:28:03 -0700 (PDT)
Message-ID: <0ae3091eaddd1e7fe97f8e3f410ae22cdd59d173.camel@redhat.com>
Subject: Re: [PATCH 3/5] drm/nouveau/gsp/r570: Add comp mode workaround from
 issue #3172217
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Tue, 15 Sep 2026 13:28:02 -0400
In-Reply-To: <20260911223727.1B6D11F000FF@smtp.kernel.org>
References: <20260911222428.752641-1-lyude@redhat.com>
 <20260911222428.752641-4-lyude@redhat.com>
 <20260911223727.1B6D11F000FF@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ovL0ZvslhQl0C4lfl5EIJFdOR3ydxdQjUvE9WXALwnQ_1789493285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 2026-09-11 at 22:37 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> New issues:
> - [High] API Misuse causing command rejection:
> `r570_memsys_enable_raw_comp_mode()` allocates the RPC with the
> device object instead of the subdevice object.

Wrong piece of feedback, but there was an issue here.

>=20
> Pre-existing issues:
> - [High] Missing state cleanup on error paths in the suspend callback
> causes the GPU to hang permanently after a failed suspend.

> --
>=20
> commit 9926d57d576468c9d718471d17ce97302fb87674
> Author: Lyude Paul <lyude@redhat.com>
>=20
> drm/nouveau/gsp/r570: Add comp mode workaround from issue #3172217
>=20
> This commit temporarily disables raw compression mode on the GPU
> right
> before initiating fbsr during suspend, and re-enables it upon resume.
> This workaround resolves an issue on Ampere and Ada GPUs.
>=20
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> [ ... ]
> > +static int
> > +r570_memsys_enable_raw_comp_mode(struct nvkm_gsp *gsp, bool
> > enable)
> > +{
> > +=09NV2080_CTRL_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE_P
> > ARAMS *ctrl;
> > +=09int ret;
> > +
> > +=09ctrl =3D nvkm_gsp_rm_ctrl_get(&gsp->internal.device.object,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0
> > NV2080_CTRL_CMD_INTERNAL_MEMSYS_PROGRAM_RAW_COMPRESSION_MODE,
> > +=09=09=09=09=C2=A0=C2=A0=C2=A0 sizeof(*ctrl));
>=20
> [Severity: High]
> Does this code allocate the RPC with the device object instead of the
> subdevice object?
>=20
> By passing &gsp->internal.device.object, the header receives the
> NV0080
> device handle, but the command (NV2080_CTRL_CMD_INTERNAL_MEMSYS_...)
> is an
> NV2080 subdevice command. This mismatch between the command class and
> the
> target object typically causes the GSP firmware to reject the
> command,
> causing the workaround to fail and suspend to abort.
>=20
> > +=09if (IS_ERR(ctrl))
> > +=09=09return PTR_ERR(ctrl);
> > +
> > +=09ctrl->bRawMode =3D enable;
> > +
> > +=09ret =3D nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice,
> > ctrl);
>=20
> The write operation here correctly uses &gsp-
> >internal.device.subdevice,
> which seems to confirm the intended target object is the subdevice.
> Should
> the nvkm_gsp_rm_ctrl_get() call above also use the subdevice?
>=20
> [ ... ]
> > @@ -104,6 +140,17 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
> > =C2=A0=09/* Stop channel scheduling. */
> > =C2=A0=09r570_fbsr_suspend_channels(gsp, true);
> > =C2=A0
> > +=09/* Temporarily disable raw mode to prevent FBSR restore
> > operations from corrupting
> > +=09 * compressed surfaces. Required for ampere and ada.
> > +=09 *
> > +=09 * Nvidia bug #3172217
> > +=09 */
> > +=09if (r570_need_raw_comp_war(gsp, device)) {
> > +=09=09ret =3D r570_memsys_enable_raw_comp_mode(gsp,
> > false);
> > +=09=09if (ret)
> > +=09=09=09return ret;
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error path
> leave
> the GPU channels permanently disabled?
>=20
> If this function returns an error, the Linux PM framework does not
> invoke
> the device's resume callback. This means
> r570_fbsr_suspend_channels(gsp,
> false) is never called, potentially causing a hard hang of the GPU
> session.
>=20
> While not introduced by this patch, adding a new command that might
> fail
> (especially given the object mismatch noted above) heavily
> exacerbates the
> missing cleanup on this error path.
>=20
> > +=09}
> > +
> > =C2=A0=09/* Save BAR2 allocations to system memory. */
> > =C2=A0=09list_for_each_entry(iobj, &imem->list, head) {
> > =C2=A0=09=09if (iobj->preserve) {
> > =C2=A0=09=09=09ret =3D nvkm_instobj_save(iobj);
> > =C2=A0=09=09=09if (ret)
> > =C2=A0=09=09=09=09return ret;
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but this error path now
> also skips
> re-enabling raw compression mode in addition to leaving channels
> disabled.
> Could we use a goto label to ensure proper state cleanup before
> returning
> suspend errors?

