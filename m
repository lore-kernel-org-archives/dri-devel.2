Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BDFC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0FB10EDFB;
	Wed, 23 Sep 2026 16:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cmaiDgTE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810DB10EDFB
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790180027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdyoLNqVE+DHNfM+cg4CpjC0enh0kQx0mYfCbYmvo2A=;
 b=cmaiDgTEN16Ali1Ux0WxUKcz+akc+352uZvkG70dpXLmzRREXmBtrO2NyB3UupwkANZUUL
 hXdbJlrbgKqKyxqhdRkHzgUfQQb7khWY6Nz3YAbOZQniCpLwSIwXaI5SBR0ZbgATdSgB1O
 xqSdi4o/WiKr8POuHcKAGpGWmo6YaiE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-4GYKtkisPFG2lciGdsQttA-1; Wed, 23 Sep 2026 12:13:45 -0400
X-MC-Unique: 4GYKtkisPFG2lciGdsQttA-1
X-Mimecast-MFC-AGG-ID: 4GYKtkisPFG2lciGdsQttA_1790180025
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9105cf082f7so20311456d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180025; x=1790784825;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QdyoLNqVE+DHNfM+cg4CpjC0enh0kQx0mYfCbYmvo2A=;
 b=AjHIS4o2vfiVLu65bpPDMznAgLIpLZImJX649mE4TONMktXUnT9ohIiP4xfbzkQENW
 PUK+NtkeiAr4RIKGf3btH5mey9iBAqkMPQR3yHZB1UC3ua/Xaa1irnYMOHdBOMHhFa+Q
 yCMel4ZLlW1LATKy8hatJY5dIsT0FI1OBy9vFCC6NK1WK7hrGVRg2LtZR/cMg7bZ7IAS
 7Z0ZgtqRY8qSaCX62Obzb5RxgJSP/U1NrYdwIkAZaOuScBCcLIluirbaqAAfl4iMMNVT
 JkaNo+h6lZICRFUAddcpl9yj/iRthLyizcdZXDCQ5OFySv4nama6SgFSqfnHJ8JWHYv0
 EkCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg051sRgZt7gnYrehu3mthD+ZkRtY+KSA3HbHbCZdBtUe29KZo1MUS3SmUVv8MzUbLsN/3qMNczU4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMRqeZC83le2UnI19Sr3MryYQwx6N6EZNBqEYbbv3CrQOg5vAo
 mxK2ZEcnTVn1c8iZKy5Crx49fqcE07o4F3Y77Iqi5KBAJmftMtwsRpLndWpNF+V9LOjQ9kYIp7B
 2GRhhxUKehR8rY6BrvqhI1tbBkB9PRrUfNBCdNmt1ixMUkgcb3s4WahWdU2Kvzdn4dqd/gQ==
X-Gm-Gg: AYBFou1P6+jMUD8F2xEBnKv7OiqWAJfq1oVDxbo22yn+Zg+2A1os3s37/6lSjjDagTA
 mLl+JBeHC8zgAihvMcKvPILcazBVGeW0DbAyUghCb9g4oghpNkbnpwii3Fuv4pwrEQdYH0pqmre
 z6XMMbUFqtkg8QO3FEO0PLfM7R087g4ggS1yoJ46uOEvbse7zps1emS+ClJhQ/I+GJ1aQzwLKLl
 S7+WgQp45zmFuXv2/d8m56/0eaogEi+StFy60YFyHkvUKEkhCQStDfTige+1SV4Ktxli3+5FIUt
 /rtnATct+CRjPjO9JX+u0+z3817JLx4gZ+zYkKg3xJeNqu4ifO7goq/jBHhNGuDicx6tC2M=
X-Received: by 2002:a05:6214:e87:b0:90e:9d41:d44e with SMTP id
 6a1803df08f44-9140c373796mr52144126d6.21.1790180024402; 
 Wed, 23 Sep 2026 09:13:44 -0700 (PDT)
X-Received: by 2002:a05:6214:e87:b0:90e:9d41:d44e with SMTP id
 6a1803df08f44-9140c373796mr52143796d6.21.1790180023908; 
 Wed, 23 Sep 2026 09:13:43 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c411188sm23599656d6.19.2026.09.23.09.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:13:43 -0700 (PDT)
Message-ID: <c78df20bd86437dd3987053765a550b3bac0cc65.camel@redhat.com>
Subject: Re: [PATCH 0/6] drm/nouveau: HDMI output colour format and
 quantization range
From: lyude@redhat.com
To: Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, dakr@kernel.org
Date: Wed, 23 Sep 2026 12:13:42 -0400
In-Reply-To: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack.ref@yahoo.com>
 <20260922215336.612239-1-Capitain_Jack@yahoo.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sTaoKkEs4UpUoQK6umtOLweE33PyIEgeUQhNZIAUDeM_1790180025
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

On Tue, 2026-09-22 at 18:53 -0300, Daniel Campos Ramos wrote:
> Nouveau only ever outputs full-range RGB on HDMI.=C2=A0 This series adds
> the
> standard "Broadcast RGB" and "color format" connector properties on
> Turing to Ada heads and selects the pixel encoding together with the
> link depth: limited or full range RGB, and YCbCr 4:4:4, 4:2:2 and
> 4:2:0.
> It applies on top of the HDMI Deep Color series v2 (base and
> prerequisite ids below).
>=20
> The hardware stage was already there.=C2=A0 On NVC57D-class heads the
> final
> colour conversion is HEAD_SET_PROCAMP plus the OCSC1 matrix and the
> output clamp ranges; nouveau only wrote PROCAMP, hardcoded to
> RGB/VESA
> under a TODO.=C2=A0 The programming follows NVIDIA's open NVKMS on the
> same
> classes (EvoSetProcAmpC5, EvoSetOCsc1C5, the YUV420PACKER head
> control).
> The OCSC1 matrices are the ITU-R BT.601, BT.709 and BT.2020
> coefficients
> at limited-range scale; re-derived independently, they match NVIDIA's
> register values to within 4 in the last place, and the patch uses
> NVIDIA's values so the output is bit-identical to the proprietary
> driver
> on the same hardware.
>=20
> Selection policy follows drm_hdmi_state_helper.c, with amdgpu as the
> reference consumer of the "color format" property: sink rules per
> format (RGB/4:4:4 Deep Color bits, 4:2:2 up to 12 bpc in the 24-bit
> container, 4:2:0 through its own bits), TMDS character rates from
> drm_hdmi_compute_mode_clock(), "Automatic" picking RGB and falling
> back
> to 4:2:0, explicit requests honoured or refused.=C2=A0 YCbCr is limited
> range
> with the CTA-861 default colorimetry (BT.709 above 576 lines, BT.601
> below), declared in the AVI InfoFrame together with the pixel
> encoding.
>=20
> One default changes: "Broadcast RGB" Automatic selects limited range
> for
> CE video formats, as i915 and the HDMI helpers do.=C2=A0 Today nouveau
> sends
> full-range pixels there and can only declare that to sinks with a
> Video
> Capability Data Block, so sinks without one apply their default
> limited
> range to full-range data.=C2=A0 "Full" restores the previous output.
>=20
> =C2=A0 1: NVC57D output CSC and clamp methods (class header)
> =C2=A0 2: program PROCAMP/OCSC1/clamps from head state (no functional
> change)
> =C2=A0 3: Broadcast RGB
> =C2=A0 4: color format with YCbCr 4:4:4 and 4:2:2
> =C2=A0 5: YCbCr 4:2:0 on GA102+, gated per head on the capability notifie=
r
> =C2=A0 6: the same properties on DVI connectors, which carry HDMI to HDMI
> =C2=A0=C2=A0=C2=A0=C2=A0 sinks through passive adapters (reported by the =
automated review
> =C2=A0=C2=A0=C2=A0=C2=A0 of the Deep Color series v1)
>=20
> Tested on a GA106 (RTX 3060) driving a Sony KDL-46HX855 (HDMI 1.4,
> YCbCr 4:4:4 and 4:2:2, DC_30/DC_36/DC_Y444, 225 MHz, no VCDB), 25
> configurations in two runs: RGB full, limited and automatic at
> 8/10/12
> bpc; YCbCr 4:4:4 and 4:2:2 at 8/10/12 bpc; BT.601 at 576p/480p and
> BT.709 from 720p; 640x480 held at 8 bpc; and side-by-side, top-and-
> bottom and frame-packed 3D at 12 bpc with YCbCr 4:4:4, limited RGB
> and
> YCbCr 4:2:2.=C2=A0 Every frame carried colour bars over near-black and
> near-white steps; the sink accepted each signal and displayed correct
> colours and levels, and the driver's selection was logged per step.
>=20
> Not tested here: 4:2:0 (the sink declares none) and DVI (the board
> has
> no DVI port); both reuse the paths exercised above.=C2=A0 Volta keeps its
> current behaviour (NVKMS has no Volta display code to compare
> against)
> and Blackwell (NVCA7D, same methods at a different stride) is left
> for
> a follow-up.=C2=A0 The class header additions are verbatim subsets of
> NVIDIA's headers and carry their usual checkpatch style findings.
>=20
> Normative chain: HDMI 1.4b section 6.5 (pixel encodings, General
> Control
> Packet), HDMI 2.0 section 7.1 (YCbCr 4:2:0), CTA-861 (AVI InfoFrame
> Y/C/Q/YQ fields, default colorimetry, the QS rule), ITU-R BT.601,
> BT.709 and BT.2020.=C2=A0 Bench harness and logs:
> https://github.com/danielcamposramos/sony-bravia-linux=C2=A0(tools/stereo=
-
> modeset,
> run27 and run28); curated public indexes:
> https://github.com/danielcamposramos/awesome-linux-hdr=C2=A0and
> https://github.com/danielcamposramos/awesome-stereoscopy.
>=20
> AI partners were leveraged in the production of this work.

You need to either tag your work with Assisted-by: if it is generated
by an LLM. If you did the right thing and wrote it by hand and just
used these tools for analysis, that's fine.

FWIW, If this was entirely generated by an LLM, then this is quite a
lot of work and I'm very hesitant to review this. Going off:

https://github.com/danielcamposramos/awesome-linux-hdr

I am very concerned just about all of the results here came out of an
LLM, according to the LLM generated provenance file, which means an
actual real person with experience working on this needs to go back and
verify that all of this is correct. That is a lot of work, and the idea
that my review comments are just going to get fed back into an LLM are
not remotely encouraging to the effort of having to go through and have
a real person look this over.

>=20
> Daniel Campos Ramos (6):
> =C2=A0 drm/nouveau: add NVC57D output CSC and clamp range methods
> =C2=A0 drm/nouveau: program head output conversion for limited range and
> =C2=A0=C2=A0=C2=A0 YCbCr
> =C2=A0 drm/nouveau: add the Broadcast RGB property for HDMI
> =C2=A0 drm/nouveau: add HDMI YCbCr 4:4:4 and 4:2:2 output
> =C2=A0 drm/nouveau: add HDMI YCbCr 4:2:0 output on GA102 and later
> =C2=A0 drm/nouveau: expose HDMI output properties on DVI connectors
>=20
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/atom.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 305 +++++++++++++++-
> --
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/head.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 19 ++
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/head.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headc57d.c=C2=A0=C2=A0 | 112 +++++=
--
> =C2=A0.../drm/nouveau/include/nvhw/class/clc57d.h=C2=A0=C2=A0 |=C2=A0 34 =
++
> =C2=A0.../drm/nouveau/include/nvhw/class/clc673.h=C2=A0=C2=A0 |=C2=A0 17 =
+
> =C2=A0.../drm/nouveau/include/nvhw/class/clc67d.h=C2=A0=C2=A0 |=C2=A0 16 =
+
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c=C2=A0=C2=A0 |=C2=A0 48 =
++-
> =C2=A09 files changed, 488 insertions(+), 77 deletions(-)
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h
>=20
>=20
> base-commit: 73ef663c75688168e31dbe9c585b939be410a945
> prerequisite-patch-id: 6bd193908862475dd809b40037984747467236d6
> prerequisite-patch-id: bf3b51b5393ef1c612930f4c474e6852372ca7db
> prerequisite-patch-id: 22c3f84b6576853e9d3053d4e5a15a4bd37e6dcd

