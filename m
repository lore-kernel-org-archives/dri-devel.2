Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C75C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F6210F16B;
	Thu, 20 Aug 2026 19:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TCGs1pjv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAC210F16D
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787253013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1G6jsQM/GZe4vJI//RXLXg99wtDQmy8dh1+9zIBics=;
 b=TCGs1pjvt6/odq4EpnVzpbtPZXG/mrSALCmTmmZdKCPFc/rqgeFHAMGfnQmkuxqzRe/faF
 YZk3Gv64qMVRVdVX2UhsgPfqi77DJ8QnsmSroMqJlTqsmxKeriY3H92B537RDzRLqYpiz9
 gfOcOzbhBQ6NmuI8fOHftFK5a4WHVsY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-MtXlCQvCN0i9PGjveqCQeg-1; Thu, 20 Aug 2026 15:10:12 -0400
X-MC-Unique: MtXlCQvCN0i9PGjveqCQeg-1
X-Mimecast-MFC-AGG-ID: MtXlCQvCN0i9PGjveqCQeg_1787253012
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so2404861cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253012; x=1787857812;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cnb/0LkhoX6JhBArFplr3WwxDbTfPxUble2GOXa/Bjk=;
 b=D6ABZdgtXM7/oipIANhhn8AjRx7AnlZq+u1hNSAXVmeEuz516vyzuB1U7iVvVVHM9A
 1hrfw8Pks50k901tpMbdGsaeDnHb0RA+0frEHM1Lrv8hII+MPqsLAqGNv3kfQtCTHxql
 pa5iPk9IuAuu3agYkJ4DNbrnxQnshUZRq/OqcRDgNmfyUXUrW1bcK3HoiR88PE7Ezb4J
 VPDbQELf6jd4DxYlToXdmJyL3z+UxSzZJHx706VFnL0ZR8kCNeSWz1byX/aTUvOGB93w
 DF+6J/LnmplW7h8J3mqgjhUqO+44IdbzBhelihWL+dqfou1VEcib8d5nVnXcQGQohJRb
 fSrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM0PHYvkd3aTCIPjPOffSIvQEPIeQWDaW0ly1yzFDhD7wxf8b/++jfOP198Txc3LW1Pp2UpSawWEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+NMVd/UZxi2t6xTmTWJHeGFJ0sGjA6BH6sskkBSD2l3PCX/FN
 wonsMpZCj9UGY0qKVmV0rzpyv+9NH3ce6agVl8ytda5NqTVaRb2AZ2IsObu7okSTbinKkMvI5Kb
 PX0l+LxHYh6qznQ9Y0//FaeJij+o8HjdnfJMG2T748wTySCNOs3gl5hn9vt59U1R8wMb/Gw==
X-Gm-Gg: AR+sD11kcsFvbt2dhYTyeNkBUK2hHv7iRPNrgp3wUBZoT3/4TKAcCLzfOfSOW8nw879
 Sb2iT9pmjv0xM8ObltAOfzIKU1qp82C6Fh0Q5cR3A/r5te2CIx6kE4aVjkK05norGQPkL6A+k2a
 oD9qGcaB/EcAFM/BdfuE+7m0FNJjVdtEx3Pg1eSjSoo1ly8JHK9E+aQ3TspF6PUW60q0idHjGhv
 sjmgT+LGfHyvlyo3FFRTY5hXkKTkM0K8rmbLHvY/ew10n3TIVrnzRzMChPEGr5TRMyExhzhH34J
 vkSZ9vgNJpq+Vrz+uQYO0pEkpnLceLgpPCCNfjWs7DJtv7RGuvrlw6j927pglnxXdSMmIGSV
X-Received: by 2002:a05:622a:1112:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-52df59fb918mr5347541cf.38.1787253011747; 
 Thu, 20 Aug 2026 12:10:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1112:b0:51c:22c5:daf5 with SMTP id
 d75a77b69052e-52df59fb918mr5346851cf.38.1787253011087; 
 Thu, 20 Aug 2026 12:10:11 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb5097sm45137076d6.9.2026.08.20.12.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:10:10 -0700 (PDT)
Message-ID: <4db24c901f8cf3315131e4b23cfe7a86dd26874a.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] drm/nouveau: unsubscribe the channel-kill event
 before the fence context
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@nvidia.com>
Date: Thu, 20 Aug 2026 15:10:09 -0400
In-Reply-To: <20260812231330.705425-2-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-2-mczernohous@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EpbnJoXNsDqj-tlKEF9pTsNMs8scMa_Zp5QKIbT1WQo_1787253012
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-08-13 at 01:13 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nouveau_channel_del() tears the fence context down first and only
> drops
> the channel-kill subscription later, in the middle of the nvif object
> teardown:
>=20
> =09if (chan->fence)
> =09=09nouveau_fence(chan->cli->drm)->context_del(chan);
> =09...
> =09nvif_object_dtor(&chan->vram);
> =09nvif_event_dtor(&chan->kill);
>=20
> The subscribed handler is nouveau_channel_killed(), which calls
> nouveau_channel_kill() and from there nouveau_fence_context_kill() on
> chan->fence. A kill event delivered in that window takes fctx->lock
> and
> walks fctx->pending on a fence context that context_del() has already
> freed.
>=20
> Nothing reaches this below Fermi today, because the subscription is
> gated on FERMI_CHANNEL_GPFIFO and nothing kills a channel there. On
> Fermi and newer the window is real but narrow, since a kill has to
> land
> exactly while the channel is being destroyed. That is reason enough
> on
> its own, which is why this carries a Fixes: tag. The last patch in
> this
> series subscribes Tesla channels as well; nothing kills those today,
> so
> it does not widen the exposure now, but it is the groundwork for a
> recovery path that would, and the ordering is better fixed before
> that
> lands than alongside it.
>=20
> Drop the subscription before anything it depends on is torn down.
>=20
> Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel
> has been killed")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_chan.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c
> b/drivers/gpu/drm/nouveau/nouveau_chan.c
> index 598513f60449..f142f6310596 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -90,6 +90,14 @@ nouveau_channel_del(struct nouveau_channel
> **pchan)
> =C2=A0{
> =C2=A0=09struct nouveau_channel *chan =3D *pchan;
> =C2=A0=09if (chan) {
> +=09=09/*
> +=09=09 * Drop the kill-event subscription first.=C2=A0 Its
> handler
> +=09=09 * dereferences chan->fence, which the fence context
> teardown
> +=09=09 * below frees, so leaving it armed across the
> teardown leaves
> +=09=09 * a window for a use-after-free.
> +=09=09 */
> +=09=09nvif_event_dtor(&chan->kill);
> +
> =C2=A0=09=09if (chan->fence)
> =C2=A0=09=09=09nouveau_fence(chan->cli->drm)-
> >context_del(chan);
> =C2=A0
> @@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel
> **pchan)
> =C2=A0=09=09nvif_object_dtor(&chan->nvsw);
> =C2=A0=09=09nvif_object_dtor(&chan->gart);
> =C2=A0=09=09nvif_object_dtor(&chan->vram);
> -=09=09nvif_event_dtor(&chan->kill);
> =C2=A0=09=09nvif_object_dtor(&chan->user);
> =C2=A0=09=09nvif_mem_dtor(&chan->mem_userd);
> =C2=A0=09=09nouveau_vma_del(&chan->sema.vma);

