Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6408C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F8E10E42F;
	Thu, 20 Aug 2026 18:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KGGVFHpl";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A5E10E42F
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787249627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioDl19YMAvkax5adWxSHFRx0OcBttsxIoujuyuuFzRs=;
 b=KGGVFHplWpqmJ9piBwLBUjDUA6CsBCBGBzIytlI/tek1UzgafR/7QSc0Qpd/KPZlaZwebp
 Kszd2Y2+nXYiTBwXkma25Nrg04RDa7WlwMrzU2yZDz8MpL2VVQp5CH2oL/A5gNHgb0eboT
 BagSe/Qcxgx1HmgrEJ5xFO6BRxPd/lc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-GZi-GMjaMmi5BKDETR0dUQ-1; Thu, 20 Aug 2026 14:13:44 -0400
X-MC-Unique: GZi-GMjaMmi5BKDETR0dUQ-1
X-Mimecast-MFC-AGG-ID: GZi-GMjaMmi5BKDETR0dUQ_1787249624
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso16803991cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249624; x=1787854424;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rl/GCSC9mrxRzZFL9EE5o5Bx5mzQPkItraIxAO9n+xk=;
 b=Dn0EUbFnXLRStPCySdfdfv6c+rwfo96L0f7nKtSCp6lF4c0nAgtkDp265fxVs4pt1q
 vWDzuM+sSqi8a8rvUPH/kMjrbo/Q2zvLQghuPFU50Of4q6r+U8zgCMR0fHVzE4haRgP4
 ZURTwwAaVnDXEXaB2a8uEXw8L2oLeuxDorzuX3F/SoFC52zgPHghNn+hXsYUucHO6vz2
 Id8WZVk2DW7HutwKPBEccEm9jJqLWb4nEcwFkYXgju3kY+1fI/XQER2Hq1PpGtErb98U
 NWk6vY7fAquSuJ7niJBgoYwQ53R1CXJS17sPf/3zknKt+vICPG0PPAo2MDs8Om30KDrp
 4DGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2GSS4gBIKeqX8wLtTN9y7RLAx5tyHI+XDRCbV4a33kyZ5iM33H9PB1E6ZaSNxf2+EFKsk1VV0SzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOYaqNL85reCbotIuJJi72BI5SrsnbBkyCF6gIgSQU5z6eB6CZ
 DZCIOX6rP0LLO4pLJLGF8zWLhhkYxwc45CqhB6Ja2n4aNtRzxTjdmJEnJh2PJktMd0Cu/lUG+FC
 nLZ62KXYi7ryX/8N+haITdJywExMJyW9VkbEh8QBwKg1fsSCcbZEX3zjA8GLLOMuHHQKp8g==
X-Gm-Gg: AR+sD13RIEmmyDjzBDxTShT8I3wXjj7FrAjJpN9gX27weoYjyF0RnitiLs0PTjn7ZeH
 ZVR0tUnoIF4omDY1SN9frm4RBMh+Rbwsmmuv4PRNXdJcjFIDR5RaTiMxU2CtqtHDnfhBPl/08fp
 S7Kn/k4qWrk9QLc7nQi2nAKdpYOsdkF3OkZ5z5Vk4XhHJaH3VBav3D8f2umOs2S2K5qXKlmanr2
 RFs4u9wHoI2Q9dYZEQTMvvGN42VFkVd/dM/AKFordWw7TzCpVy7Kp7+M7hwDT1qqrUD/Zfhwidh
 m8KRwTLV+UyJ5QqDSmZuMif9w3tJzW000jsaLgnWmnRcPrRIUkgpPeG9JWoPrUnk3A/MCXab
X-Received: by 2002:a05:622a:4086:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52de2eff50cmr85001981cf.2.1787249624007; 
 Thu, 20 Aug 2026 11:13:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4086:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52de2eff50cmr85000801cf.2.1787249622905; 
 Thu, 20 Aug 2026 11:13:42 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb44easm45361866d6.6.2026.08.20.11.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:13:40 -0700 (PDT)
Message-ID: <40b59b1a40755347533320b65ff1a4342b8e3c8e.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 14:13:40 -0400
In-Reply-To: <178682366002.3748010.4096452389040554615@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b64TNMm-oewbcl6pr5Cr9XJJTbYfCUtXoeWQarC7s5c_1787249624
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

On Sat, 2026-08-15 at 21:54 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nouveau_connector_destroy() tears the two nvif events down and then
> frees the connector, but never cancels the work the IRQ event queues:
>=20
> =09nvif_event_dtor(&nv_connector->irq);
> =09nvif_event_dtor(&nv_connector->hpd);
> =09kfree(nv_connector->edid);
> =09...
> =09kfree(connector);
>=20
> nouveau_connector_irq() queues that work unconditionally:
>=20
> =09schedule_work(&nv_connector->irq_work);
> =09return NVIF_EVENT_KEEP;
>=20
> A DP IRQ arriving just before nvif_event_dtor() therefore leaves
> nv_connector->irq_work on the system queue past the kfree(). When it
> runs, nouveau_dp_irq() derives both nv_connector and connector from
> the
> work_struct and dereferences them, and goes on to take
> outp->dp.hpd_irq_lock.
>=20
> There is no cancel_work_sync() for irq_work anywhere in the driver,
> so
> nothing else covers this. Add it after the event teardown, where no
> further work can be queued, and before anything is freed.
>=20
> Reported by the Sashiko review bot as a pre-existing issue, in its
> review
> of an earlier nv04 FIFO series of mine, and confirmed against the
> source.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link:
> https://sashiko.dev/#/patchset/20260812231330.705425-1-mczernohous@gmail.=
com?part=3D1
> Fixes: 773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index b0b0ad9a0c24..e49dcaa6d210 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -397,6 +397,7 @@ nouveau_connector_destroy(struct drm_connector
> *connector)
> =C2=A0=09struct nouveau_connector *nv_connector =3D
> nouveau_connector(connector);
> =C2=A0=09nvif_event_dtor(&nv_connector->irq);
> =C2=A0=09nvif_event_dtor(&nv_connector->hpd);
> +=09cancel_work_sync(&nv_connector->irq_work);
> =C2=A0=09kfree(nv_connector->edid);
> =C2=A0=09drm_connector_unregister(connector);
> =C2=A0=09drm_connector_cleanup(connector);

