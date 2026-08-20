Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC834C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3927710EE01;
	Thu, 20 Aug 2026 18:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JqY1ZlMA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D429710EE01
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787250482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ioDl19YMAvkax5adWxSHFRx0OcBttsxIoujuyuuFzRs=;
 b=JqY1ZlMAWYgPYmoY6YduXsxM71df5LspkO3rHVioPXcEnPigRVKkA2bJhd+2EX7UzFO/SO
 eQoX38vAbOBf1QoCSeBwTNeGa5kksHuY/MXkaVPfmUjHq4fmVygpNaoUMTkdjxqRP/HIKv
 mbGM7wIstGXtOKVSK8ygCWomWWc4eoI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-sVBGFXUwOeKBLsp_klheBg-1; Thu, 20 Aug 2026 14:27:59 -0400
X-MC-Unique: sVBGFXUwOeKBLsp_klheBg-1
X-Mimecast-MFC-AGG-ID: sVBGFXUwOeKBLsp_klheBg_1787250479
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e63df032bso143358185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787250479; x=1787855279;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rl/GCSC9mrxRzZFL9EE5o5Bx5mzQPkItraIxAO9n+xk=;
 b=gWMf/vkCycNWCkZeg0Td+Kdk94IODLfaLsC00QSfifShH94lljuy64PQTX+pdg71jP
 /RzE8H2ubDcbPWotmGenwLjSBYS4yxj+f5oeRqCiao6ouJkm0qkXmTlVhWgmP6aztdgL
 OPzNUww+f7wyHYKgkKy2qogpZbhnUAEqRgsDay9dRD040qTHob5LE1j9wPWz1MwSSLr8
 N3RE6U4TUoKk/497oKlyfCP0vDeDgCaaGep/oyMapiIT//LTuf3IPBhQQDCGmG12u1JN
 M0ff4OmUzJCs9TuiEDyd2QiWszlgoBHeUXFSrNApx7bOKaQVtXQDbn3Ds8mTRjYjERgh
 OlBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3/VJRAYINW8NtIwCe8DyMtJN5+Fs6ESliVtJ0/OUAP0WBiSqOgjsTLhhcRB4jTUSqkAr9LdCBoeI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysQP5xIoyNv/5Q0URLSOl4991kEjBEygc9xNkNqzpCePzaWs+n
 tr/tPdwANDugRO++e282CWa33zK4AZmw8+hm8rIO16oFaTdgxcE938P6S18dILmI/vLqc25jSSr
 /tQf7HnuMZ7eIFznaxhB2pf7KpHqSluSlNV07TO9gYjGpmBDaAP3u5s8cr2drVCotMnLF5A==
X-Gm-Gg: AR+sD11/7BgrCNOq9x38m5XgsTCdc9EiQo0J2euEGAyOEki6UeYNGTWr+NCiOY8J2Wt
 2E7t7bTAUIrK8bcjFJK4RN75tHG7zIZ/Os5aw+jR1U8zQSFfHH6HTM5S8lA9wSSGorSWIsthw7z
 06DOsDX43vJPiVnRA+pyoevNwG9sqE88zj4i8ZO9ds61Phnrba1uODnmtQY2YfBEzlCEtE8UQGO
 AkcwEmfqMjVv3YrRVRcYBU2ny3LfMv1tOvDDXiv+F3tyM5yWOphzA0cfBOONPqwCXX48qsOgXN4
 7XdC5D0q3qXglsULRaC+3bsKFmo5VcgNc+YFyYhomTOESGAP+w0n9bH+EAY3Vm6GOAH3tM4H
X-Received: by 2002:a05:620a:28d4:b0:929:f78f:6bf9 with SMTP id
 af79cd13be357-93728497619mr773547085a.16.1787250479099; 
 Thu, 20 Aug 2026 11:27:59 -0700 (PDT)
X-Received: by 2002:a05:620a:28d4:b0:929:f78f:6bf9 with SMTP id
 af79cd13be357-93728497619mr773478485a.16.1787250468774; 
 Thu, 20 Aug 2026 11:27:48 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9372056b78esm422216885a.30.2026.08.20.11.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:27:48 -0700 (PDT)
Message-ID: <5a22c376eb0ded8e1cefcc042176f8c77f68658b.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing
 the connector
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Thu, 20 Aug 2026 14:27:47 -0400
In-Reply-To: <178682366002.3748010.4096452389040554615@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.4096452389040554615@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r1J1kpbmZFktOROyohxY7pKUOSY5i_pf5KW6r1GBSMs_1787250479
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

