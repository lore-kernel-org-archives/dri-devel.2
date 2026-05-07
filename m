Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD5ECD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 18:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DA610E2AB;
	Thu,  7 May 2026 18:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MQKigppL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FA310E29D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778179558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqy2FCaWABbSZ5XwoLHNJ+cZVmf74lpr+4emSNEVXgA=;
 b=MQKigppLAqYUoLka4ABEOOHx3qi89llrNs9wXes2ll1JQHvgsQqPwOOE5O+IztcPj8X6mb
 678bTAbsUFAM0RixaRCn9uuB38KXsTN5pqU964Bj/Lg2hj7lASA8iStui9Q/vHjJUnkuER
 Aztm3tDenf/l/oqRZCn+httPFsJK2mY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-EoTYqwcCOiGIy3DciZLVFg-1; Thu, 07 May 2026 14:45:56 -0400
X-MC-Unique: EoTYqwcCOiGIy3DciZLVFg-1
X-Mimecast-MFC-AGG-ID: EoTYqwcCOiGIy3DciZLVFg_1778179556
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b459fa5f76so15298606d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778179556; x=1778784356;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WgXIkCgB3aSRfVz0FcSmSasyEWuA9kchSMzu8PPJBaA=;
 b=SSgquD2eekSC75u4MzR5UEbzRCJ8/IoD5ej2iaDYMX1lWL2Ltx5hr4ZqMbA47Y/Nwx
 WsxM4aG+q7Qm5axUAB2Rk2C1BFH+XW/xLnI7nE1gTttHF0MKzcy1ZcZRHCZsebO8FIZY
 g9ERh4DyL/CyYgF1DnYCpHPseiqCOOlHECvMaphuAwlgyZTDcc/+tGy7iM7pnIyDNoNP
 CSDT/c/BPRce0de8EadFh6Qxjf58K70ySuhxlcC60qZhbqXuf1Ek1Zu0CzWEYA0UuRar
 sYl5o+bLQSImfpyMy9KSZrMwVbQhGw40AjLksqbxE4K6eEITVRSc9HYBUab3Z0VgSZOZ
 Mp2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CY7oW19DbRN7WSJWesCuyIOiXylxlx9KqXJQSm0UV+KqBbRVn09NDAXD6Jb7iVpVowpyrYSR5OK0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBa0xtEPQrRx4OTTp8HQXiCG4rvKVqeSAfVyG0uBEO6dI3RpHr
 O0qsEt1tx7x94t/uPHpVB0vFGHrpqDWBj8g0Vb3tkx3wVGcfY5pzT+r2lkYHDmm17M8NTkgvLZ2
 uZvJKRtcWUt1sYd7eS/xUo+5fY2/p/Q/ajBD6hnP19sOmTRrDiMdvdAxAiRIsZ5fCIwNc8g==
X-Gm-Gg: AeBDieu/CXBkqY2TOfzDfNS6W5QGuPPk/AFZCQhoS7oYZuo8q+ddIoqQ0vvTmXF4JT5
 RHpN8V12JXDBDoj5rjeo1hTKmUUFD0USBOf5xKxEvkAl6gfYWCJ0I8cMcpD42k1WXE+Blo69/lO
 7k6w0ntUikPw18eEDC57X0J/Eo8q3PvXGPCgZHYUhZxXD8TNYk9LXMNx8zXkhQ1W2JTygYn7rPG
 HPurkcgLWKr1rId8mIMGgE4rle0gDEBgEaDeXmFb7kgQ8BPnP0UJSXUQdRGxub/xXtTadr/VhZ4
 5fyFfejx7Q/VZJiqzkCkKIVppJRHNOa75PzKjvtxNPv1GMRz9VCAz0ct45IJ6ebwTA7UgfmSbbS
 ciS0T5zqkvaLQC1tKUg==
X-Received: by 2002:ad4:5ecb:0:b0:89c:4812:cc2 with SMTP id
 6a1803df08f44-8bc42c63a8amr140677916d6.15.1778179555929; 
 Thu, 07 May 2026 11:45:55 -0700 (PDT)
X-Received: by 2002:ad4:5ecb:0:b0:89c:4812:cc2 with SMTP id
 6a1803df08f44-8bc42c63a8amr140677476d6.15.1778179555448; 
 Thu, 07 May 2026 11:45:55 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538a293dbsm249581016d6.2.2026.05.07.11.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 11:45:54 -0700 (PDT)
Message-ID: <6b3516fe9db22f223f6e558b5a6ff31fbe6aa64d.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()
From: lyude@redhat.com
To: Jonas Emilsson <jonas.emilsson@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org
Date: Thu, 07 May 2026 14:45:54 -0400
In-Reply-To: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
References: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aQyMswRSsL6DjJzR9DXCi2lM6X74fVcPVa1TQC_x82s_1778179556
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

Actually sorry - I need to take back the r-b, there's a couple of
issues in this patch that I didn't immediately notice because it had
trouble applying (though I don't have a clue why)

On Sun, 2026-05-03 at 05:45 +0200, Jonas Emilsson wrote:
> A hotplug or link-loss event can tear down the MST topology
> (setting mgr->mst_state =3D false and mgr->mst_primary =3D NULL)
> concurrently
> with a caller invoking drm_dp_mst_topology_queue_probe(). Since the
> check
> is already performed under mgr->lock, the condition is not a
> programming
> error but a valid race -- the topology was valid when the caller
> decided
> to call this function, but was torn down before the lock was
> acquired.
>=20
> Replace the drm_WARN_ON() with a graceful early return. This
> eliminates
> spurious kernel warnings and the resulting compositor crashes
> observed
> when connecting/disconnecting DP MST monitors, while keeping the
> correct
> behavior of doing nothing when MST is not active. A drm_dbg_mst()
> trace
> is added so the skipped probe remains observable under MST debug
> logging.
>=20
> The existing WARN_ON(mgr->mst_primary) in
> drm_dp_mst_topology_mgr_set_mst()
> already catches the case where the topology is initialized twice, so
> no
> diagnostic coverage is lost.
>=20
> Fixes: dbaeef363ea5 ("drm/dp_mst: Add a helper to queue a topology
> probe")
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jonas Emilsson <jonas.emilsson@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8..0cb341ce1 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3738,8 +3738,10 @@ void drm_dp_mst_topology_queue_probe(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0{
> =C2=A0=09mutex_lock(&mgr->lock);
>=20
> -=09if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr-
> >mst_primary))
> +=09if (!mgr->mst_state || !mgr->mst_primary) {
> +=09=09drm_dbg_mst(mgr->dev, "queue_probe skipped: topology
> torn down\n");

There is no such function named drm_dbg_mst, can you switch this to
drm_dbg_kms() like the rest of the file and make sure it builds before
sending another version?

> =C2=A0=09=09goto out_unlock;
> +=09}
>=20
> =C2=A0=09drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);

