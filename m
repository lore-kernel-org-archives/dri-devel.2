Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D31C5DF88
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403E910EC79;
	Tue, 18 Aug 2026 23:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Lm9EWlzh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C3810EC79
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787097510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tz/yXH3YIXKsxVZ87/WPseHbbbdSG7a6l6OJ3Eub38g=;
 b=Lm9EWlzhWLaGQupNEV06ogagJxKtrLZ222WtAeLrA1yvo3C5CBK5B7qY7EdxhvpbYdq5L/
 f2hD88uRC/h3TS93d3iW4hvIpboWrgI2cBX1rUT+ks5JmwBCcysTG2ee8KyhFkxfWCMgEF
 5X0KobB06DVWE7iMveG8XSsjdEwDQmI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-6AZftdIZN4aLxbeWb7_rXQ-1; Tue, 18 Aug 2026 19:58:27 -0400
X-MC-Unique: 6AZftdIZN4aLxbeWb7_rXQ-1
X-Mimecast-MFC-AGG-ID: 6AZftdIZN4aLxbeWb7_rXQ_1787097507
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso3152001cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097507; x=1787702307;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tz/yXH3YIXKsxVZ87/WPseHbbbdSG7a6l6OJ3Eub38g=;
 b=nOiEG/pKzY5a1gkDzo4iTQQkhydZhk75X/ZQrTPConLoenfXqYYjjXSOmEjEfL+Q5A
 qyIlzfxS923L35PZQ9AzobMU3saYWyYkct7MSDqDzXSMv8vhx1AHFOUFFgq2KbQ7D3C1
 MV567kc5udaui53W2NrnCAc6JBnbzKqMMu2IEvd/wzIbZBmMJrdiD94rHdwZ2zobkFyd
 Obdkws5utp7wa4WpDZRo8D8sU6wZEPZYGu3oZYER0VpNkjryWbZUt7oZvpETgeVF0FWD
 m6yjCJ8Ve6nfiJV7bGPcHL/aYefoNVNGFDauPHtAQKrXxgIcTyvnQVkKbZ8mod9mAj36
 aNww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgAW4Y8rC5BW0sAriTgQQKdIK08N1wf1EmeKC41LPVYyK7efWAvpadDsSv60drry+81c1hjjkICl0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJknIucWDvstxidP8COmpD2Ch7EslHMtjCgAPGOP3p0flAYy0j
 5QdrUYWorY/SxmbKzqw0Nu2mB3FnZE0850TlQUk+L4rUOFrPiFhXVO36Vz9Dj2FD4eszlQMPhEh
 D3tjzr/BKITfw+krMJBG/s+whVEVHg5r+rY6SmY9qTY0nlyPL9c4xD/AVWXNjGpgRZwHUpA==
X-Gm-Gg: AR+sD12ndv2xyNhnts3OafJyewnPCq1xmwKYBGuUFyDFyWgRg2e90UQCqnUMhSl9sOm
 WJLtxnnEWpauohFCNJMBNf/Hk2nMi2LEcjN6o5ZxhtXMcut9pGJ0EcFTHPdZcUL34t4Id3AAflh
 YBbfcUcegyRhAQm1h8m+ceDv2fgRCww4WY48gEhDaMOVy+41rtoVHC2mV63hMdKPnMoCsfTDWgb
 qiUV5kj+WAVcAJYv6IUsDPD4pCfhpCE574Sk2na5QZGW0BYAjuY72jAs8Jku7dHa4rUpYusu4Jj
 uhQGfppq56hARPgiCwASZsSkDVb7957ZWIYFvfQSzOs+2y2XkBwnVp/5lvn+4DLH4V9VcRO4
X-Received: by 2002:ac8:7fcc:0:b0:51c:1ea:e290 with SMTP id
 d75a77b69052e-52dd4970d83mr7644881cf.17.1787097506669; 
 Tue, 18 Aug 2026 16:58:26 -0700 (PDT)
X-Received: by 2002:ac8:7fcc:0:b0:51c:1ea:e290 with SMTP id
 d75a77b69052e-52dd4970d83mr7644631cf.17.1787097506193; 
 Tue, 18 Aug 2026 16:58:26 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52dd872a9e6sm382701cf.20.2026.08.18.16.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:25 -0700 (PDT)
Message-ID: <3c85782ad840395622a93e9c30f151296dea838b.camel@redhat.com>
Subject: Re: [PATCH 0/3] drm/nouveau: teardown ordering fixes for events and
 work
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Tue, 18 Aug 2026 19:58:24 -0400
In-Reply-To: <178682366001.3748010.7798811159846779765@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tcazJuEZUwzm5DosLJYtLjB95UTmLibN0gf_tOnlWUU_1787097507
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

Thank you for all of the submissions! JFYI - I should be able to get to
reviewing this one tomorrow

On Sat, 2026-08-15 at 21:54 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> Three teardown fixes in nouveau, all the same shape: something that
> can
> still run after the thing it points at has been torn down or freed.
>=20
> Two of them are not my finding. The Sashiko review bot flagged them
> as
> pre-existing issues in its review of my nv04 FIFO series,
>=20
> =C2=A0
> https://lore.kernel.org/nouveau/20260812231330.705425-1-mczernohous@gmail=
.com/
>=20
> naming nouveau_fence_context_del() and nouveau_connector_destroy()
> directly. It was right about both. 1/3 and 2/3 carry a Reported-by
> accordingly. 3/3 is mine, found while following the irq_work of 2/3
> into its handler, which is nouveau_dp_irq().
>=20
> 1/3 nouveau_fence_context_del() cancels the uevent work first and
> drops
> =C2=A0=C2=A0=C2=A0 the event afterwards. In between, the event is still a=
rmed and
> =C2=A0=C2=A0=C2=A0 nouveau_fence_wait_uevent_handler() queues the work
> unconditionally,
> =C2=A0=C2=A0=C2=A0 so a non-stall interrupt in that window re-arms the wo=
rk that was
> =C2=A0=C2=A0=C2=A0 just cancelled. The callers free the context immediate=
ly after,
> =C2=A0=C2=A0=C2=A0 which leaves nouveau_fence_uevent_work() walking freed=
 memory.
> =C2=A0=C2=A0=C2=A0 Destroy the event first, then drain.
>=20
> 2/3 nouveau_connector_destroy() drops the connector's two events but
> =C2=A0=C2=A0=C2=A0 never drains nv_connector->irq_work, which is what the=
 DP IRQ
> event
> =C2=A0=C2=A0=C2=A0 schedules. The work can then run against a connector t=
hat is
> about
> =C2=A0=C2=A0=C2=A0 to be, or has already been, freed.
>=20
> 3/3 nouveau_dp_irq() looks the encoder up and dereferences it in the
> =C2=A0=C2=A0=C2=A0 declaration block, five lines above the NULL test that=
 the same
> =C2=A0=C2=A0=C2=A0 function already carries.
>=20
> 2/3 and 3/3 both point at the same commit. Commit 773eb04d14a1
> ("drm/nouveau/disp: expose conn event class") turned nouveau_dp_irq()
> into a work callback, and that single change introduced both the
> undrained work and the early dereference: the drm pointer used to be
> an
> argument, and recovering it from the encoder put a dereference above
> the
> existing test.
>=20
> All three carry Fixes: and Cc: stable. 1/3 and 2/3 are use-after-free
> windows, and each commit message names the trigger, the window, and
> the
> freed object the work then touches. 3/3 is a NULL dereference sitting
> above the function's own NULL test.
>=20
> I also looked one level up, since it would have been the obvious next
> instance. drm->hpd_work is drained in nouveau_display_fini(), right
> after the hotplug events are blocked, under
> "if (!runtime && !drm->headless)". That guard does not exempt the
> teardown path: nouveau_drm.c:597 calls nouveau_display_fini(dev,
> false,
> false) immediately before nouveau_display_destroy(), so runtime is
> false there. The runtime exemption belongs to the suspend path
> (nouveau_display.c:781), which frees nothing. So there is no fourth
> patch here.
>=20
> Testing
>=20
> =C2=A0 Reference hardware: Apple Macmini3,1, MCP79 / GeForce 9400M (NVAC)=
,
> =C2=A0 Core 2 Duo, Wayland (labwc). Note for 1/3 that this chip takes the
> =C2=A0 nv84_fence path, which is the one where the event exists at all.
>=20
> =C2=A0 Build. The series is built against the stated base commit, as a
> full
> =C2=A0 kernel build rather than a module-only one, so modpost actually
> =C2=A0 resolved the module's symbols instead of being skipped for want of
> =C2=A0 Module.symvers: zero compiler warnings, zero compiler errors,
> =C2=A0 nouveau.ko produced. checkpatch.pl --strict is clean on all three
> =C2=A0 patches and on this cover.
>=20
> =C2=A0 What the testing does not show, stated plainly: I have not managed
> to
> =C2=A0 hit any of these three windows deliberately on this hardware. They
> are
> =C2=A0 ordering bugs reasoned out from the source rather than from a
> =C2=A0 reproduction, and I would rather say that than dress up a crash I
> do
> =C2=A0 not have. Each patch names the file and the function it argues fro=
m
> so
> =C2=A0 the reasoning can be checked directly.
>=20
> AI assistance
>=20
> =C2=A0 Lyude asked on an earlier thread whether these patches were writte=
n
> by
> =C2=A0 a human and pointed at Documentation/process/coding-assistants.rst=
.
> =C2=A0 The answer, repeated here for the archive: this work is AI
> assisted. I
> =C2=A0 use Claude (claude-opus-5) as a coding and analysis assistant.
> Every
> =C2=A0 patch carries an Assisted-by trailer accordingly, and no Signed-
> off-by
> =C2=A0 is added by the tool.
>=20
> =C2=A0 Nature of the assistance, so you can calibrate your review: the
> =C2=A0 assistant did most of the code archaeology and drafting. I
> described
> =C2=A0 symptoms, asked for the mechanism to be traced in the source rathe=
r
> =C2=A0 than guessed, and asked for each claim to be backed by a file and =
a
> =C2=A0 line. The assistant also reviewed its own drafts adversarially,
> which
> =C2=A0 is how two errors in 1/3 were caught before this posting: an
> earlier
> =C2=A0 draft claimed nouveau_fence_context_kill() does not touch the
> event,
> =C2=A0 which the source contradicts, and it illustrated the freeing calle=
r
> =C2=A0 with nv04_fence_context_del(), which is precisely the case that
> cannot
> =C2=A0 reach the bug, since nouveau_fence_context_new() returns before
> =C2=A0 nvif_event_ctor() unless nv84_fence_create() set priv->uevent. Bot=
h
> =C2=A0 are corrected. I reviewed the result, I understand the code, and I
> =C2=A0 take responsibility for it.
>=20
> Marek Czernohous (3):
> =C2=A0 drm/nouveau: destroy the fence event before cancelling its work
> =C2=A0 drm/nouveau: cancel the DP IRQ work before freeing the connector
> =C2=A0 drm/nouveau: don't dereference outp before checking it in
> =C2=A0=C2=A0=C2=A0 nouveau_dp_irq
>=20
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 +++-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_fence.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
 +-
> =C2=A03 files changed, 5 insertions(+), 2 deletions(-)
>=20
>=20
> base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86

