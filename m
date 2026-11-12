Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ItWQFAgQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057C8112170;
	Thu, 12 Nov 2026 14:10:00 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2026 14:09:48 UTC
Received: from sender5-op-o10.zoho.com (sender5-op-o10.zoho.com
 [165.173.182.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C04A112180
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794491678; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gp7SrFjl7MscpoikZVAkuCpxLakHQLoOnGw6RhTrlweEyKD6Z0+JQ/GqVw47a4Aq6rziH9mnT0FppzveY08CM4JcRECh2amf3SeFS8Y2WFvCOPoXHrNFJTNV+vvvn0aWju1ETAYIxG+XBUKANQ/GCrlm3q3haM0xO1Iliu4oOaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794491678;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UKYlfbG6CgzKvDwLNG8b4MFdQP96xPA09AwV3u035cc=; 
 b=V3TSWL/5L7BqCHTnE3NuHKWFTynK3cFAUlTwEcP1jEOJUJsLPWRQpi1F8tw3HJglsiX/Oe34760XDZoZEiUwA07BIuifT0AmOaXehBL/E+zEtCY1HpN34m3tJ5MhcvxivRzMtYU21lYJzIVDfuOn7teknv55+v+vWOQVGqnuy90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=faith.ekstrand@collabora.com;
 dmarc=pass header.from=<faith.ekstrand@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ItWQFAgQ6SgLLowDNd9GelHwh0Evs/C004ImYWViFF9FbYDNH+Afjquudso7UpSoJKbDQlP6YRQdILBCO3R4QlL6Qg8qFMVuabPNgyC95B/K8iAoDOkd7j2BtDtfugRP+M3A3fXkxhhBSN1qqEpVg/5lB3TaMb+S93ZM/10aUwk=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=UKYlfbG6CgzKvDwLNG8b4MFdQP96xPA09AwV3u035cc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1794491670217282.0441901979831;
 Thu, 12 Nov 2026 05:54:30 -0800 (PST)
Date: Thu, 12 Nov 2026 08:54:29 -0500
From: Faith Ekstrand <faith.ekstrand@collabora.com>
To: =?UTF-8?Q?=22Ma=C3=ADra_Canal=22?= <mcanal@igalia.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Boris Brezillon" <boris.brezillon@collabora.com>,
 "Rob Herring" <robh@kernel.org>, "Steven Price" <steven.price@arm.com>,
 =?UTF-8?Q?=22Adri=C3=A1n_Larumbe=22?= <adrian.larumbe@collabora.com>,
 "Liviu Dudau" <liviu.dudau@arm.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?Q?=22Christian_K=C3=B6nig=22?= <ckoenig.leichtzumerken@gmail.com>,
 "Melissa Wen" <mwen@igalia.com>, "Iago Toral" <itoral@igalia.com>,
 "JaeHoon Lee" <dlwognsdc610@gmail.com>,
 "kernel-dev" <kernel-dev@igalia.com>,
 "dri-devel" <dri-devel@lists.freedesktop.org>
Message-ID: <1a1d009dddd.60725d0c103197.2638865837867497355@collabora.com>
In-Reply-To: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
Subject: Re: [PATCH RFC 00/12] drm/v3d: Add support for write-back cacheable
 BOs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ma=C3=ADra Canal <mcanal@igalia.com>
To: "Maarten Lankhorst"<maarten.lankhorst@linux.intel.com>, "Maxime Ripard"=
<mripard@kernel.org>, "Thomas Zimmermann"<tzimmermann@suse.de>, "David Airl=
ie"<airlied@gmail.com>, "Simona Vetter"<simona@ffwll.ch>, "Faith Ekstrand"<=
faith.ekstrand@collabora.com>, "Boris Brezillon"<boris.brezillon@collabora.=
com>, "Rob Herring"<robh@kernel.org>, "Steven Price"<steven.price@arm.com>,=
 "Adri=C3=A1n Larumbe"<adrian.larumbe@collabora.com>, "Liviu Dudau"<liviu.d=
udau@arm.com>, "Alex Deucher"<alexander.deucher@amd.com>, "Christian K=C3=
=B6nig"<ckoenig.leichtzumerken@gmail.com>, "Melissa Wen"<mwen@igalia.com>, =
"Iago Toral"<itoral@igalia.com>, "JaeHoon Lee"<dlwognsdc610@gmail.com>
Cc: <kernel-dev@igalia.com>, <dri-devel@lists.freedesktop.org>, "Ma=C3=ADra=
 Canal"<mcanal@igalia.com>
Date: Fri., 30 Oct. 2026 16:50:18 -0400
Subject: [PATCH RFC 00/12] drm/v3d: Add support for write-back cacheable BO=
s

 > This series aims to implement cached maps and explicit flushing for the=
=20
 > V3D driver, which is mostly motivated by Vulkan's host cached memory.=20
 > =20
 > V3D's implementation of cached maps is quite similar to Panfrost's and=
=20
 > therefore, I decided to revamp Panthor/Panfrost's efforts [1] to impleme=
nt=20
 > common shmem helpers for CPU cache maintenance. The other option would b=
e=20
 > copying the same code in V3D, so I preferred to retake the discussion=20
 > and see if we can reach some consensus.=20
 > =20
 > The most controversial part of this series are the first three patches,=
=20
 > which were extensively discussed in Boris' series.=20
 > =20
 > Patch 1 lets the PRIME helpers work with custom dma_buf_ops, following=
=20
 > Thomas' feedback on [1]: drm_gem_prime_export_with_ops() exports with=20
 > driver-provided ops, and gem_prime_is_exporter() lets a driver recognize=
=20
 > its own DMA-BUFs on import, without adding buffer callbacks to struct=20
 > drm_driver, as requested by Thomas.=20
 >
 > Patches 2-3 are taken from [1], rebased on top of drm-misc-next with som=
e
 > minor kernel-doc fixes.=20

Not entirely included in the mailing list discussion was why we abandon thi=
s approach for panfrost/panthor:  CPU mapping shared dma-bufs is tricky, es=
pecialy with non-coherent caching.  Gone are the days when we dma-buf had a=
n ownership concept and clients properly bookended usage with begin/end.  W=
ith explicit cache management, there are too many ways that one client can =
screw up another if the BO is shared.

The solution was to disallow BO sharing for any BOs that weren't mapped wri=
te-combined or uncached.  A number of DRM drivers already have a concept of=
 non-sharable BOs for locking reasons.  We simply required that for write-b=
ack caching.

This doesn't mean that the common SHMEM helper isn't useful.  I still think=
 that patch is fine.  Just that plugging it all into PRIME is fraught.

This wasn't obvious from the ML discussions because a lot of the back-and-f=
orth happened in chat or in meetings inside Collabora.

~Faith Ekstrand


