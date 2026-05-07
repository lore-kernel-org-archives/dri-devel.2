Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8324CD3446
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 18:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB4B10F23F;
	Thu,  7 May 2026 18:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UPP1rQNi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31A410E574
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778178227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfC5TMU7qe7fFGe92a7DePwBp+CqUtTa+5DFp/GTcN4=;
 b=UPP1rQNifNOIrYWsdVpl6ByR9kl/3rNA74w+mMvydscnzgBfbnhfNkltSo0uMGRviVHZJJ
 R34udb8gN4OxOOVRVCRG+a6RAIzC80SmBjvpltNqiQLZ74EE7GK6jm6+0KsshFNTDpzLkB
 fCVe68WebujdXsQoYqMaQle1fp7jAyM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-l0I6Ym0kPeuNoEiZnkoD-g-1; Thu, 07 May 2026 14:23:46 -0400
X-MC-Unique: l0I6Ym0kPeuNoEiZnkoD-g-1
X-Mimecast-MFC-AGG-ID: l0I6Ym0kPeuNoEiZnkoD-g_1778178226
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da529ff48so23961951cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778178226; x=1778783026;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ftCUpj5ypvcw40llhDtRrKigurBiomW0ZRMdUhWHyXA=;
 b=BYhxUHXp12A64ijBiT7LcHCy2KisoEBYU7SW0iLX8Drn8tvMlgj8Y2i5ZP7UpyZ5iL
 WcB98G71CiZzK7XFSLArFtP/xV1+15mA8VT6xcGMY8K/T7DVYdxIMJPzVHH/1Ww3ORn2
 jQYz5OPp4Lt2iTHUqq4VQ6bnQbm/TsMccj+j3dJpsSlLxcj6fQkjM9o2t/e2fLqSRVuu
 n78oCs0txqEeL12XTj5m4CmV6SmNl1gSyJYKgGVgvyllNdaxyIdb5viG5jj7cnYW5+ZE
 okGq9lkosIs3ZiIz5JBdXSZJq7GVdY+V1kf/AZ2QubstAl9RQv1BHyGf96hFkLoNHUOr
 N+vQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9zWxWe90+oLasZafWIRMTAFKHtnE9mRIeBu4EZn5XKrrTO8lez5ecvrgyCbuRnAjcfelOieiRP6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5DjVAWNzUBCwfbUexxibEBKGUasuoW+vPy+psjE3r60Zz1KQx
 O3zgzCPKn6u2N2RqKIlCTY5AG7OBVVUTK4B1SuJmQBjagr7mk1gVMx9zMREhzKDjrLf5Gz6r+xq
 sdxk3r9fpSjqwlUzBI9GTSSFSdYiYriamLL57h09mWVnqxADpD5zcUtbEBMqhb877yi66ng==
X-Gm-Gg: AeBDievFUKurFh9cJy6w1LqU2VqhzJ5pNVZpqFBWrVmtfWgVzvS1KxD0mOpKzM2DNEh
 pgmPBX0Y7CUcKjNRszNblITO3/+9zLg0EfhFg53d6fc/+6njj02m0vO/VYHMUNhYDt0dljwz8lM
 GQVnld0wQnIrlIcxMagrlmDBrWWHNNfI4w1CktFrdxnMcDKNG5c9PqgLM2TtsU7CUt+FKDI7UYx
 CSBxinqzQMRX7+o7T+8yN45dSpcgwAR3lOwLlRBE90tJYg3BWzwKEDg9hIIDfgM1zkySbwXlJ2g
 5ZucJ92+4lT/KV20K7SuM88B9g36K9tzIEOpbAr7P6wXDyi1i+yj6O4jkJ6CCR+ILuZN332WNr3
 p1UGDVKNpTVEq5521+g==
X-Received: by 2002:a05:622a:5c98:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-514621cf190mr123147851cf.60.1778178225684; 
 Thu, 07 May 2026 11:23:45 -0700 (PDT)
X-Received: by 2002:a05:622a:5c98:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-514621cf190mr123147321cf.60.1778178225080; 
 Thu, 07 May 2026 11:23:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148522a5adsm4018391cf.14.2026.05.07.11.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 11:23:44 -0700 (PDT)
Message-ID: <4de3ead617a9f706d00e8540e6c6d65353799f4f.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()
From: lyude@redhat.com
To: Jonas Emilsson <jonas.emilsson@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org
Date: Thu, 07 May 2026 14:23:44 -0400
In-Reply-To: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
References: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LonN6SbW9teUlVCon0auUAFCWWURrtNhEL-VGQLZkzs_1778178226
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

Will push upstream in just a moment

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
> =C2=A0=09=09goto out_unlock;
> +=09}
>=20
> =C2=A0=09drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);

