Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09275C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F1B10E7E4;
	Mon, 21 Sep 2026 21:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FF/MPjZC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9967B10E7E4
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790024690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Vmlz+Bx8SIM2K5VEzNG7AKGyI6HzlsLRJG0uWRTQ28=;
 b=FF/MPjZCNblzeDyXtcH+0UKlQ827cujabc2yd0R7IH2wfZ62Zim6qGW5lLy8WvkXnw4Bjf
 ZkoD0owUqv8jv5OeeFGCMn191H+TXpx9ytXwXgXSjxDw98YjwXHRAH6wqB4e1od/P/GUO+
 kdXpQw2bhs3QITLxXwJ6fhPGqRNb9f8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-XvascF1bPOu9OMSi6jk-sQ-1; Mon, 21 Sep 2026 17:04:49 -0400
X-MC-Unique: XvascF1bPOu9OMSi6jk-sQ-1
X-Mimecast-MFC-AGG-ID: XvascF1bPOu9OMSi6jk-sQ_1790024689
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bd22160bbso256742785a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 14:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790024689; x=1790629489;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6eRtpG9zfNX9jL+rKnG56ZsJJWcIR/MpBBw5x/u4gB4=;
 b=hLkndbXz8zt53kNSygirbJdv/VlozQvl+QQn/z9LV/LkY4O95TJzdJuQkk5mqrr6cQ
 ZnAM8MJCxnCymYzLsjmedNMjXXD2LnBfAqY2w9aFjsqf8mm/T6qqMS3aZjmnxWYexRC/
 NiBT0JaFsAeKLXsp3fk5gJOil2ncM7FQSlkGhcuhLq+RTES8o8GZN9p2oFvDu7iuY3zd
 oCEtfEOjFMsXgmgUzm7+EeF+maxktstTxPSaqiin+u1CRDMAW6v2doVRBvYqYnz8ZjjA
 XRhb90xZzP1ngXzMv2TzxKQ9+214zB5bkBWTLvd308KuKKFr7t14/4cSKu42RFo7soRy
 i0tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEYeq0ea2cf/r4Xpz8DNn2XTaS22jQgJMBC5NxQnzApxIfndFCWYQjXQkcsC+HmFpSFQorX4BgHNw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1AnYYAbSiak3Akca2aGtJMWUxK+tXJvYdXKJjAhU7JeHIgEAM
 1gbQJopOOD899Yause1kpNAxqeDCjKxvhQKrbiUruCj1HgKpEDAEpk2+64tQueqkfp7YHpb4yQ2
 vsQiI8EqZKW8K4JlTax4AdnooJCUU9zWjwI0ViqjHEQrAZbFdKbh1dZEP1Hqfzf4+BP347Q==
X-Gm-Gg: AYBFou1zjiMJ83x2ls9rB9nV76wuOEJzbF9uVXGnrgMlPKRqeXbqNlUogAc6Jzzgms1
 ApdQ0apLzB03DzMW+WpFylqle2bqIw3m2y1RfV7tnuJ3VCG1fnpE9wFp8/NOfXUjoPnmg2DffCJ
 d3mh7VkiheKvD5HHQOI3jsQoog/beEL4zWGpt5B0ZaODGUVfGDVA2WGXYSHE12zSoW28XrhgV9Q
 fArOd2O38XE9923N7rlHx9HSQIwKsU0r5T0X3yOJan0BAMFbT8AFvm2/1HU7xiYebhdrUP0hgnE
 9tDNlujvRD61IhdPHPPRW0IZDwrZvWz0gB39BdmvtVC2W8D1n1oXsa9zdAsZf5t4Bf1R2wM=
X-Received: by 2002:a05:620a:7014:b0:939:6de9:4cfb with SMTP id
 af79cd13be357-93c15e9c931mr241236485a.46.1790024688730; 
 Mon, 21 Sep 2026 14:04:48 -0700 (PDT)
X-Received: by 2002:a05:620a:7014:b0:939:6de9:4cfb with SMTP id
 af79cd13be357-93c15e9c931mr241232685a.46.1790024688184; 
 Mon, 21 Sep 2026 14:04:48 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c19a604dasm16787785a.11.2026.09.21.14.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:04:47 -0700 (PDT)
Message-ID: <a854ea37b4329d767d04eb0ef7975492aeac0038.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
From: lyude@redhat.com
To: Xiao Lu <xiaolu.xie@intel.com>, dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com
Date: Mon, 21 Sep 2026 17:04:46 -0400
In-Reply-To: <20260920022144.2209244-1-xiaolu.xie@intel.com>
References: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
 <20260920022144.2209244-1-xiaolu.xie@intel.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9WzgZYvN4SkJaUXDIkAM5hgPffsJ9iJOx3bQFL0IO4o_1790024689
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

Awesome! Happy with this being the new behavior for DPCD transactions,
but there's one thing I realized we should probably verify though
before I give an R-b: Is it possible that this can race with CSN
updates, and do we handle the race/do we need to?

For context: port->ddps is protected under drm_dp_mst_topology_mgr-
>base.lock, and we're reading out of lock here. So the situation I'm
thinking of is like this:

- Thread #1 starts a remote DPCD transaction on a port with ddps=3D1
  It performs the ddps check, and begins doing the actual transaction
- Thread #1 gets preempted, execution stops
- In the real world, the port is unplugged and we get a CSN
- We handle the CSN on another thread, and ack it to the MST hub
- Thread #1 starts executing again, and continues the remote DPCD
transaction without knowing the port is gone

To be clear, I don't think we can solve this by just grabbing the lock
during the `if` check. This brings the question of "are we able to
handle violating this portion of the spec if the chances of that
happening in the real world are very slim?" E.g. is a race like this
with a hub still recoverable, or is it definitely possibly fatal on
some hubs? If it is recoverable, this is probably an issue we can
ignore and I can just give an R-B since 99.9% of the time we'll prevent
DPCD transactions on unplugged ports.

If we can't, then I wonder if it's possible to introduce some sort of
ddps check within drm_dp_send_dpcd_read/drm_dp_send_dpcd_write() that
happens under a lock which we also acquire during CSN handling, and
drop the lock for it after we queue the TX (and before we try to wait
for the response from the hub). That way we could make sure that
whatever ddps value we use for possibly preventing the read/write is
always up to date with the last value ddps value that that we ack'd
from the hub is and block acknowledging any CSN updates while a DPCD
transaction is ongoing. This means a port could still be unplugged
while we're sending DPCD traffic to it of course, but that's to be
expected - as long as we haven't ACK'd the CSN yet it should be the
hub's responsibility to recover from the sudden disconnect mid-DPCD
transaction.

Does that make sense?

On Sun, 2026-09-20 at 10:21 +0800, Xiao Lu wrote:
> DP v2.1b specifies that REMOTE_DPCD_READ and REMOTE_DPCD_WRITE
> transactions should only be issued to downstream ports where ddps=3D1
> (device plug status indicates a device is connected). Issuing these
> transactions to empty ports (ddps=3D0) is non-compliant and causes
> problems in practice: some MST hubs NAK the request, and all hubs
> introduce a delay waiting for the transaction to complete or fail
> before the driver can proceed, increasing link training latency.
>=20
> Guard drm_dp_mst_dpcd_read() and drm_dp_mst_dpcd_write() with a
> ddps check and return -EIO immediately for unoccupied ports. This
> avoids the spurious sideband transactions without changing connector
> lifetime semantics =E2=80=94 connectors for all output ports are still
> created at enumeration time, regardless of ddps.
>=20
> Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
>=20
> Changes in v2:
> - Instead of skipping connector creation for ddps=3D0 ports (v1),
> =C2=A0 keep connectors around and guard DPCD transactions at the
> =C2=A0 drm_dp_mst_dpcd_read/write level. This avoids changing connector
> =C2=A0 lifetime semantics visible to userspace, per Lyude's review.
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 7ce9e2127..b7fce0bf8 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2161,6 +2161,9 @@ ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux
> *aux,
> =C2=A0=09struct drm_dp_mst_port *port =3D container_of(aux, struct
> drm_dp_mst_port,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0 aux);
> =C2=A0
> +=09if (!port->ddps)
> +=09=09return -EIO;
> +
> =C2=A0=09return drm_dp_send_dpcd_read(port->mgr, port,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 offset, size, buffer);
> =C2=A0}
> @@ -2184,6 +2187,9 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux
> *aux,
> =C2=A0=09struct drm_dp_mst_port *port =3D container_of(aux, struct
> drm_dp_mst_port,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0 aux);
> =C2=A0
> +=09if (!port->ddps)
> +=09=09return -EIO;
> +
> =C2=A0=09return drm_dp_send_dpcd_write(port->mgr, port,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset, size, buffer);
> =C2=A0}

