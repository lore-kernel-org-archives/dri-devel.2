Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27588606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=MywEkYSE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A67910E14C;
	Tue, 10 Nov 2026 11:53:13 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F071710E14C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794311573; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b5w7FJLnFk6mZ2P/Ygrw8rxJF7UhI9RAgv63hNtKPchYQLOfUfddhKrYvB2ylV6OFMydSvTIkstXJg8oBz1ilbavm7g3t7t3JWMnhGIDANlWTGISYueeh7isOl7S96dpMo+1n2cHuc3CQDkjspKnXp+ChOTFSswqKaDhpzA0A0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794311573;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DhEhwirpyKyrEjOgU/ZOhzRcKsoWGGzpaPLq4MoFNxs=; 
 b=icnwmDwzHav5tg5vsqRb7OKCMmCa4dmykHehZlxE+Swa5SVhxK8DSRgyp1jrmZOAD5WAuQJ7JKkCV6HeRm000cKty5iPki+OA7ctZsWtRSeWjWQ5CMporhWGTuXmcCP5pYWolZLQ/xa24ouLY930Mszm+YAxbtqora6cU+qf2ag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=MywEkYSEXY5PuxQKJsEtRbYQMQpUxu84l5jDZMMhXzPGM3HzEnrA1XpU3WTEgBilnaYr/+upQcIIcc480wzxhQgXwbmqniWhyEbW+k03PNPQ09Lb8NrZ9L/Tqs3RFlVvOGOZMXgYJe4m85YuP1E1VN1xaR6rDHSKSBZEcQhV6PA=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=DhEhwirpyKyrEjOgU/ZOhzRcKsoWGGzpaPLq4MoFNxs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1794311571955322.33854090543514;
 Tue, 10 Nov 2026 03:52:51 -0800 (PST)
Date: Tue, 10 Nov 2026 08:52:51 -0300
From: Igor Torrente <igor.torrente@collabora.com>
To: "Daniel Stone" <daniel@fooishbar.org>
Cc: "boris.brezillon" <boris.brezillon@collabora.com>,
 "steven.price" <steven.price@arm.com>, "liviu.dudau" <liviu.dudau@arm.com>,
 "maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
 "mripard" <mripard@kernel.org>, "tzimmermann" <tzimmermann@suse.de>,
 "airlied" <airlied@gmail.com>, "simona" <simona@ffwll.ch>,
 "dri-devel" <dri-devel@lists.freedesktop.org>
Message-ID: <1a1c54dc9d7.326328084617249.176092468769907716@collabora.com>
In-Reply-To: <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
References: <20261109105652.7114-1-igor.torrente@collabora.com>
 <CAPj87rM3_MCFMGSAL1P6hBzLsLNP0hNL58whe1AeegtxMvgBhA@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM
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

Hi Daniel,

De: Daniel Stone <daniel@fooishbar.org>
Para: "Igor Torrente"<igor.torrente@collabora.com>
Cc: <boris.brezillon@collabora.com>, <steven.price@arm.com>, <liviu.dudau@a=
rm.com>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimme=
rmann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dri-devel@lists.fr=
eedesktop.org>
Fecha: lun, 09 nov. 2026 14:38:57 -0300
Asunto: Re: [PATCH] drm/panthor: Allow exporting BOs with an exclusive VM

 > Hi Igor,
 >=20
 > On Mon, 9 Nov 2026 at 10:57, Igor Torrente <igor.torrente@collabora.com>=
 wrote:
 > > Panthor currently does not allow exporting BOs with an exclusive VM.
 > > However, VDRM (native context) drivers export BOs for import by the gu=
est
 > > VM, which does not attempt to bind them to any GPU VM.
 > >
 > > Allow these BOs to be exported and rely on
 > > panthor_vm_prepare_map_op_ctx() to reject attempts to bind them to a
 > > different GPU VM.
 >=20
 > I'm having a little trouble parsing this.
 >=20
 > Is the problem that:
 > - the guest requests allocation of a BO with exclusive_vm_root_gem =3D g=
uest_vm
 > - the host passes that allocation through
 > - the host exports a dmabuf from the allocation (which fails)
 > - the host imports a dmabuf from the allocation (?)
 > - the guest requests the BO be attached to guest_vm
 >=20
 > i.e. is the problem that some host implementations (virglrenderer)
 > handle BO allocation exclusively via an export/import interface?

I was testing and checking a few things. This patch needs at least a=20
rewording, but maybe we can drop it entirely.

The virtio_gpu part of Virglrenderer used to create a transitory export
to mmap the BO and attach it to the guest VM (not import, as I previously w=
rote).
With resource_map, this transitory mapping is now obsolete.

Vpipe still shares buffers with the client through FDs (even non-shareable =
BOs).
It seems that this is an expectation of the protocol. I will check to see i=
f we
can avoid this for non-shareable (exclusive-VM) cases.

Lastly, if I=E2=80=99m not mistaken, CrosVM=E2=80=99s sandbox separates the=
 GPU device into another
process, making the export necessary (possibly even for non-shareable BOs).=
 This may
or may not be an issue.

BR,
Igor

 >=20
 > If that is the problem, it seems like it would be cleaner to have the
 > host implementation strip the exclusive VM ID from the request, until
 > they can be fixed to not require the export/import dance.
 >=20
 > Cheers,
 > Daniel
 >=20


