Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D358CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD3210E748;
	Thu, 17 Sep 2026 16:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="G/HJtmEJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6552510E748
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789663747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omlC18wY1ukN2je24GweXzcSe9j4lJs4DZLDDcUNn7U=;
 b=G/HJtmEJdXpFPPFOBRX9sE7HSSUYlSc6S6pgz1R7w0ditXrAbf7CzYZjt8zqx0vjnX8/B+
 GTR0Az5884oJDNISAwsSYSQ7VMk3ZaqzJlFxPsuYckMRA7VlOv00Rjp83wF5/LjgKcHMA4
 i+ZKS3RSKADAKyROdM0jth9sfTN3Pcw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-SzOeINyiPny7vG68tn86xQ-1; Thu, 17 Sep 2026 12:49:06 -0400
X-MC-Unique: SzOeINyiPny7vG68tn86xQ-1
X-Mimecast-MFC-AGG-ID: SzOeINyiPny7vG68tn86xQ_1789663745
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e8341cfb4so26476866d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789663745; x=1790268545;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fk335ZHS3Kkki0OwvXJmkCNz4An1pumlbtqIfefCkO0=;
 b=RZZlUvmDUqAmur/3yZin19s/pV9y9ER4IJHYPBeTaJZQgLSc5sDnjBEeRt5Di3BKM8
 13ySDbyPTuiols++T9Zjx1C9FvjdBU8BzxUwP7MFzmFkVHHk7vSCyVtgmRh+iEp6OQPG
 zwxdkUt0z7Oj3er+CgChFIz17XAlUX4slQs7H22ZaZHcLZAkexpwkOEMMGNWpsamoerA
 XfGAJ4j8jyerpPQyWlCjn0c+kgHbKTCgc3Y47O4vj7gjML0WMZxMnKT8KYrXw/Rkwasc
 ZgSgwwMUukVfBG23LcO/vLB8KUWDRlrDWVCA378eJkfB0GF8mXT+guSSypD/gOixp/Pk
 tqEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmWl5+JH4WtrDFXLxMZMGgHLQh47PCey5ceGB97ukikGvF3t3NWZ/OmZl2ydyxxNSWLfYtOqQe3ok=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+77appS6umg5+TxWLl3RzNPnBwwumrtG2+JF+4VjbzlNmuk2m
 8oZrbDQRD0+miXcnvSQNL8Ka/EINR5OBRwQjdtNLqFC9EC4T92K7wQULB10UaMA3sT2I2WxFM5b
 W4T+WBwamMYhNXuRJaouFFfnH2k3Ls+NVRV4dxXCGtRu/RIAGWZhcJdSefagHH1kwlawL7Q==
X-Gm-Gg: AYBFou2o8i3dIq9fRwnGexJEaUY90HSprY/2/Bt4QIqc4MI0igg3wdhb2S/jcaYwzSw
 tfqFyD8PEJ+fWBPFzgbMKZFw+0qSe+LDaWYrfduMY3WV3aqztnsY0CFu7PITp09GBEMHQhbB30L
 VSkVlt0QMv3WW0YSGwwfG5B3RtTWHqM9Zu4lSN8zD+umWKbG+ubP6uauhpPrQLujhxH81muAseG
 YsYqx5d0iJdNMagh0kBCvAms2zgychF1oKK1u2Zg8yxyZT6+G/n1ZY8Rt1WrR60wl/YJzdiuDHi
 bSZUOsyKE7Djx4Tj9eqPOMDUtUbr8QuLLmvAbJSzLkj5V4AH69E5PcJ4hfrpfUiVmSv8XyQR
X-Received: by 2002:a05:6214:8613:b0:912:33a0:5d78 with SMTP id
 6a1803df08f44-9123d7ad38fmr136008826d6.19.1789663745333; 
 Thu, 17 Sep 2026 09:49:05 -0700 (PDT)
X-Received: by 2002:a05:6214:8613:b0:912:33a0:5d78 with SMTP id
 6a1803df08f44-9123d7ad38fmr136008226d6.19.1789663744886; 
 Thu, 17 Sep 2026 09:49:04 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252cb5b5asm1855826d6.29.2026.09.17.09.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:49:04 -0700 (PDT)
Message-ID: <c992e5468e2118440ab1b9c37fc64c7ab79aaaea.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
From: lyude@redhat.com
To: Xiao Lu <xiaolu.xie@intel.com>, dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com
Date: Thu, 17 Sep 2026 12:49:02 -0400
In-Reply-To: <20260917080126.1729898-1-xiaolu.xie@intel.com>
References: <20260917080126.1729898-1-xiaolu.xie@intel.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wpCQYLUqNzc-mlfwekPDqJMdcLX1Btf-jUy2ybGnKeQ_1789663745
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

Are we sure this is a good idea? This seems like it could be a problem
for compositors and just make things more complicated in general for
userspace because now instead of a connector that can be plugged or
unplugged, we now only have connectors on MST that appear and
disappear.

Is there an actual bug being caused by the NAK transactions here?

On Thu, 2026-09-17 at 16:01 +0800, Xiao Lu wrote:
> When an MST branch device is enumerated,
> drm_dp_mst_port_add_connector()
> is called for every output port regardless of whether a device is
> actually
> connected (ddps=3D0). This causes the driver's add_connector callback
> to
> probe DSC capabilities via REMOTE_DPCD_READ transactions on empty
> ports,
> which the hub NAKs with DPCD_FAIL.
>=20
> These spurious sideband messages are wasteful and generate
> unnecessary
> error log noise. More importantly, they occur repeatedly on every
> topology
> re-enumeration triggered by CSN handling.
>=20
> Skip connector creation for output ports that have no device plugged
> in
> (ddps=3D0). When a device is later connected, the hub sends a
> Connection
> Status Notification (CSN) which updates ddps=3D1 and triggers connector
> creation through the normal hot-plug path, ensuring correct behavior
> for runtime plug events.
>=20
> Tested with a Parade PS8650 MST hub having unplugged downstream
> ports:
> REMOTE_DPCD_READ NAK messages are eliminated while hot-plug and
> display functionality on active ports remain unaffected.
>=20
> Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 7ce9e2127..14a84a838 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2448,7 +2448,7 @@ drm_dp_mst_handle_link_address_port(struct
> drm_dp_mst_branch *mstb,
> =C2=A0
> =C2=A0=09if (port->connector)
> =C2=A0=09=09drm_modeset_unlock(&mgr->base.lock);
> -=09else if (!port->input)
> +=09else if (!port->input && port->ddps)
> =C2=A0=09=09drm_dp_mst_port_add_connector(mstb, port);
> =C2=A0
> =C2=A0=09if (send_link_addr && port->mstb) {

