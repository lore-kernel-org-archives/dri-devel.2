Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B86CA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D6210EB55;
	Fri,  9 Oct 2026 22:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d4A6d+lp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B95610EB55
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791583296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7imtYyWMwIHvOB2ZFxNOfZ9OLtnlcEZ/kjK2JkgTcA=;
 b=d4A6d+lp5Rlhq/tvyxLmOswXfNTsx9HOlaYS+c6uYPZv+nPCACP2/aq47C0D9zTiaJN5MX
 iOGiNGowSGwxXmrFLBtEUw74JCfzagIs+UuBe0P4ZhQQEh2yWNhU94Vtjo2YsQl/VOePaT
 B/CVd0zyQ+sUw8hSZzbv+/QM0hevoYg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-pTMQWfFsOA2Ta_ylHUQmbQ-1; Fri, 9 Oct 2026 22:01:28 +0000
X-MC-Unique: pTMQWfFsOA2Ta_ylHUQmbQ-1
X-Mimecast-MFC-AGG-ID: pTMQWfFsOA2Ta_ylHUQmbQ_1791583288
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5358515b4easo3827641cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 15:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583288; x=1792188088;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7imtYyWMwIHvOB2ZFxNOfZ9OLtnlcEZ/kjK2JkgTcA=;
 b=FEYlPuEgWowl6LaIiaMk9fmdVDKF1YXKoALnI8yXtTiFCq11Mn5iSKwao/djh52xZX
 dZOBmRxYFUxyCG+70Mq9TWTwAe7LEuvG3XROuHqeAR+VWg5YkFpetr+8zp4MzetIeaIW
 PbdsaP/Imgp9povoWnzEVdtOBbD1qlmJJOepCMg2UdxjVqHj5xKF5st15cU9zmN9HfBT
 7965A9qKgIO2+20lLolT2Aq5Xh758srrwDya1bUxqMaGgbnPxb61DrO1qsBO2CgRLnHu
 Gd06k/kUTXpPI/txFSd9ImU3BathVq4dhDeVP2FiL+jrriIiM8ecDFLZHDQldLjfe885
 ipnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxtrv1tma1uL8eHEHEbAtFkCoI6KOB59aHDx53R6pz4cr0sWhFL0gvfzBvQCB/JcNfdxWxDnVe2HE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJQDFjOHatNPeUe/J32xpgwj8celtgvAkKguuTYYEV0BoebvkAW
 +MfIwreQwICgDOpMpkC/EJ0M5QOPgOASnU/Sy8xhCy8/3NJzPczrzhOISOH8WtMqgbp+bUh00MM
 Dqk4fSQNns5mhgubKzEjOXHxHa0kPR452Z/QlA9fTrOsUf6+HuLWgFo2gBIG/xKg7BMdWdTt+Xb
 alQA==
X-Gm-Gg: AYBFou128fptWTk+sxJgjt254fuu13bmkF7BhJgbcbnQzZGvp4w/vcAc8eNz9b3M0Q+
 QBPLcXL92omizrnzFzkdpBBSNtRdwpHurbcGDsZD5yZt5kaxpbuDCJ32sO9Y/ILC4v+2QsUnwcY
 1fT+ZXFmX0DV0rCCYoubMffx88MyC3zbYpDI2ELuGT3HumH64FlvyVU3BYZWUUQ7SUdx/VtVN0P
 N0BKNpPvXotc5x+sv73SpbVe1V4cu96FuDISXYecZgBJKyw1fmVUuKy0vFTqgEbreqogLMstwcI
 CurqdsIjJdI54X6c5koTEjTtMH/tEg97MAydGBrLbxk3frVzqbp+jcn7eAmNy6LfbKVyCBc=
X-Received: by 2002:a05:622a:1a9e:b0:533:972d:ff91 with SMTP id
 d75a77b69052e-5359fae1644mr56984171cf.26.1791583287951; 
 Fri, 09 Oct 2026 15:01:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9e:b0:533:972d:ff91 with SMTP id
 d75a77b69052e-5359fae1644mr56983381cf.26.1791583287345; 
 Fri, 09 Oct 2026 15:01:27 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b5504de42sm29021296d6.24.2026.10.09.15.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:01:25 -0700 (PDT)
Message-ID: <77926aa23a920ed00c5b1a13d98e768e11d6446e.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] nouveau: Fix NULL dereference in
 nvkm_gsp_gcx_ready()
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, Jim Cromie via B4 Relay
 <devnull+jim.cromie.gmail.com@kernel.org>
Cc: jim.cromie@gmail.com, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, 	nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Campos Ramos	 <Capitain_Jack@yahoo.com>
Date: Fri, 09 Oct 2026 18:01:25 -0400
In-Reply-To: <DM0N3VIIXERD.PZBNSZJPSEL7@kernel.org>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-3-839e2bbe514d@gmail.com>
 <DM0N3VIIXERD.PZBNSZJPSEL7@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: URd6tkClId9f0rAUrmjauvCVac6BzwUB7CQYHuj9ib4_1791583288
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

On Fri, 2026-10-09 at 23:53 +0200, Danilo Krummrich wrote:
> On Fri Oct 9, 2026 at 7:44 PM CEST, Jim Cromie via B4 Relay wrote:
> > From: Jim Cromie <jim.cromie@gmail.com>
> >=20
> > Commit cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
> > INTERNAL_GCX_ENTRY_PREREQUISITE") hooked nvif_device_gcx_ready()
> > into
> > nouveau_pmops_runtime_suspend() to consult GSP before runtime
> > suspend.
> >=20
> > On GPUs running without GSP-RM (e.g. Volta GV100, NvGspRm=3D0, or
> > missing
> > GSP firmware blobs), device->gsp is instantiated but gsp->rm
> > remains
> > NULL. nvkm_udevice_gcx_ready() checked "!gsp" instead of verifying
> > nvkm_gsp_rm(gsp), allowing non-RM instances to invoke
> > nvkm_gsp_gcx_ready(). nvkm_gsp_gcx_ready() then unconditionally
> > dereferenced gsp->rm->api, causing a kernel oops:
> >=20
> > =C2=A0 RIP: 0010:nvkm_gsp_gcx_ready+0x10/0x30 [nouveau]
> > =C2=A0 Code: ... 48 8b 87 70 0e 00 00 <48> 8b 40 18 ...
> > =C2=A0 RAX: 0000000000000000 RDI: ffff8c9555fca000
> > =C2=A0 Call Trace:
> > =C2=A0=C2=A0 nvkm_udevice_mthd+0xa5/0x150 [nouveau]
> > =C2=A0=C2=A0 nvkm_ioctl+0xcc/0x1d0 [nouveau]
> > =C2=A0=C2=A0 nvif_object_mthd+0x110/0x1e0 [nouveau]
> > =C2=A0=C2=A0 nvif_device_gcx_ready+0x36/0x60 [nouveau]
> > =C2=A0=C2=A0 nouveau_pmops_runtime_suspend+0x39/0x140 [nouveau]
> >=20
> > Instruction decode shows `mov rax, [rdi+0xe70]` loads gsp->rm
> > (0x0),
> > and `<48> 8b 40 18` (`mov rax, [rax+0x18]`) faults accessing rm-
> > >api.
> >=20
> > Fix by:
> > 0. Checking !nvkm_gsp_rm(gsp) in nvkm_udevice_gcx_ready() so non-RM
> > =C2=A0=C2=A0 devices report GC6/GcOff ready and bypass the GSP call ent=
irely.
> > 1. Guarding gsp and gsp->rm in nvkm_gsp_gcx_ready() before
> > inspecting
> > =C2=A0=C2=A0 gsp->rm->api->gsp->gcx_ready.
> >=20
> > Fixes: cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
> > INTERNAL_GCX_ENTRY_PREREQUISITE")
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>=20
> Isn't this fixed in commit 4d0e27041185 ("nouveau: check gsp->rm as
> well as gsp
> pointer before gcx ready") already?

(gonna hold off on pushing all 3 of these patches, you're right - I
completely forgot that we had already pushed a commit for this)

