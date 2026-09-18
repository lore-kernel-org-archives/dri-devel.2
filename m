Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA2C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0C210F4AF;
	Fri, 18 Sep 2026 18:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hso8a3Dp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C6710F4AF
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789755599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7kqg3g4TDhTgn02AE/5IuK3dJ4rvzOjNHid2KGirNg=;
 b=hso8a3Dp9GkLc3U+iePuW7ZV5/h/S5TrLLlaoJUcqYbb9/MHqLqV2eEkrywHN2dgL1Vvf8
 pvblD9SfEJcA4ZZ9897T7TBDEGl/4tRNzOTvvrUaTK2R4s9KARGe1FtC25JRr8Tyc0IqyY
 FIUXWU8U0Iu0u7kZvhNLwAktTLgqOdI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-tan9XMjGNmS1pMI904nhPw-1; Fri, 18 Sep 2026 14:19:58 -0400
X-MC-Unique: tan9XMjGNmS1pMI904nhPw-1
X-Mimecast-MFC-AGG-ID: tan9XMjGNmS1pMI904nhPw_1789755598
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91213a1aa68so18289936d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755598; x=1790360398;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V7kqg3g4TDhTgn02AE/5IuK3dJ4rvzOjNHid2KGirNg=;
 b=KhCAcHQmYJV9iaU4x1XpIhXPHvs8s3aeh8B9Nd0+d6B7iDq7WBhdXJtVzkbB0wE79A
 LL0aAbdnkq5IVYsL8QF/LfM6WBADEayt359ULb+n497D4ED967mwjpp483a2AVWgan7k
 34EyBux18SooG8IHvDeYkHZPTpA4DITpQBLksOwNhPuIBGw8Lxg241OAbdRvjK86Vkls
 WRTNAuZ6klMoJe0BDIcxFdUX7TK9NxHEL3wqG1n0saknLEbq+2GWot9bsem6djHo8kNk
 zg8m7lMNkf/juabcSUH2+H0OLq+gDOqNWhde+T/9tNgs031J+6+qgN1mSBnXPHPu8xrO
 7XKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO/YUsj1apP5Tn4z9zoU/xDL24J9CsC3eMgBjr4IgW7x35BHtJvnjtkLyzYsmpLeCXHQjxAJgqIHY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNM5fd5cwtiwU4MYGyux3xwKAsUPQ+y/hJ8TMS8KFPFSZtnbHV
 EnkGnTAkv5SqaAvJ/jNsYbCGJcxtA1XFMipgcfouRKrrS9QwybBfESALVvrIDSRNwh5PEUFjkHo
 FhLnaUc8oW8zHasbajQOwJ22BO/3hxaRDS8IcXDfBDDDAKgnssFx+HGkEGNyW9SNmgHdycg==
X-Gm-Gg: AYBFou0ylYUfF1m6W8kMPQDJ0Uw8egvxfll2fm3zhwhAIoCcKrmMhalNoGKDjD2N1aD
 nmWw8nKOF1ejVhpbJ4KC0yXOsfO1Hwo4K/7/LzSr63Y8VX7GrXVvUY7/pNpokiXtH+xShbN9vJT
 4+w9pDyuXpSBb0A5myQ23rQW2SzcboOoKPSC8vXhOilM4gsHkQ5bFsBa+iJM6Z9AMscdiJ0QkvS
 s7z0179jZeDPlPD1WdXSmPiJsVmxck56pcIGNTOKS00282ovef1p1HXTYc358+01pJjre9SBuIz
 2Gs+4AURmdNxAuy2aGuaASME1fKxvnkHHN+h4NNPorF/TixsqaItB+pf2aCE8AHFm1lZTdy0
X-Received: by 2002:a05:6214:468d:b0:910:3622:e036 with SMTP id
 6a1803df08f44-91254cb136dmr59408546d6.34.1789755593335; 
 Fri, 18 Sep 2026 11:19:53 -0700 (PDT)
X-Received: by 2002:a05:6214:468d:b0:910:3622:e036 with SMTP id
 6a1803df08f44-91254cb136dmr59408116d6.34.1789755592906; 
 Fri, 18 Sep 2026 11:19:52 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260a60b81sm1887856d6.18.2026.09.18.11.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:19:50 -0700 (PDT)
Message-ID: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: skip connector creation for unplugged
 downstream ports
From: lyude@redhat.com
To: Xiao Lu <xiaolu.xie@intel.com>, dri-devel@lists.freedesktop.org
Cc: David.Francis@amd.com, jani.nikula@linux.intel.com
Date: Fri, 18 Sep 2026 14:19:49 -0400
In-Reply-To: <xiaolu-reply-ddps-20260918@intel.com>
References: <c992e5468e2118440ab1b9c37fc64c7ab79aaaea.camel@redhat.com>
 <xiaolu-reply-ddps-20260918@intel.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XU-bG6PqHnl82yJpXQDhrdm6Qv6SNbWYaM2EE2IDtpI_1789755598
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

On Fri, 2026-09-18 at 09:29 +0800, Xiao Lu wrote:
> On Thu, 2026-09-17 at 12:49 -0400, Lyude Paul wrote:
> > Are we sure this is a good idea? This seems like it could be a
> > problem
> > for compositors and just make things more complicated in general
> > for
> > userspace because now instead of a connector that can be plugged or
> > unplugged, we now only have connectors on MST that appear and
> > disappear.
> >=20
> > Is there an actual bug being caused by the NAK transactions here?
>=20
> Thanks for the review. Two points to address your concerns:
>=20
> 1. We tested hot-plug/unplug on MST DFP ports with this patch
> applied,
> =C2=A0=C2=A0 and the connectors appear and disappear correctly without an=
y
> issues
> =C2=A0=C2=A0 observed on the compositor side. When a device is plugged in=
, the
> =C2=A0=C2=A0 hub sends a CSN which triggers a pdt change, causing mgr->wo=
rk to
> =C2=A0=C2=A0 resend LINK_ADDRESS. drm_dp_mst_handle_link_address_port() t=
hen
> =C2=A0=C2=A0 creates the connector with ddps=3D1 at that point. The hot-p=
lug
> =C2=A0=C2=A0 lifecycle works correctly in practice. That said, if you are=
 aware
> =C2=A0=C2=A0 of a specific compositor path that relies on connectors bein=
g
> =C2=A0=C2=A0 pre-created for all ports regardless of ddps, we are happy t=
o
> =C2=A0=C2=A0 investigate further.
>=20
> 2. The REMOTE_DPCD_READ to ports with ddps=3D0 is not just log noise.
> =C2=A0=C2=A0 It causes a measurable lighting delay at link training time,=
 as
> the
> =C2=A0=C2=A0 transaction must time out or be NAK'd before the stack can
> proceed.
> =C2=A0=C2=A0 More importantly, not all MST hubs respond gracefully to
> REMOTE_DPCD
> =C2=A0=C2=A0 transactions on unoccupied ports. This behavior is also
> =C2=A0=C2=A0 non-compliant with DP v2.1b spec, which states that
> REMOTE_DPCD_READ
> =C2=A0=C2=A0 should only be issued to ports where ddps=3D1. Issuing reads=
 to
> =C2=A0=C2=A0 ddps=3D0 ports is the driver-side bug here.

OK - yeah, I definitely agree then that we've gotta enforce that.

This being said though - I do still think we want to keep the
connectors around, in part because it does give userspace a more
accurate idea of what ports are actually available on a hub - and it
would be a bit of a departure from how we've exposed this to userspace
for a while now. Dynamic connectors are already confusing enough to
deal with in userspace as it is.

Have you considered just keeping the connectors with ddps=3D0, and then
just making it so that our code for performing remote DPCD reads/writes
simply returns -EIO on ports where ddps=3D0? That way we still keep
connectors around without delaying or breaking anything.

>=20
> Best regards,
> Xiao Lu

