Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029DED35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F5D10F0D8;
	Wed,  1 Apr 2026 12:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DmCgzbl8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A74E10F0CE;
 Wed,  1 Apr 2026 12:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775045689; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KaAXEGGMiKIIaIoGgo79W+We9AmkrITz7h8K2gQHnYE5PSRD8SkbD32hovXZqEosucv41LEvyuFdWIONCB8GuFNqs8N/eU8wUYQ1Vf0GbM2cEolVUfe4LHhYVcS5oywOPey+PURdt1c/W/lJOO6ef9aGvmeKU91j4E3GOTuonX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775045689;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XiDS3s5yYlqvswVEQyjuSwI4C0tCZYmt0PdRdLxftNM=; 
 b=nPFKV49BNf5LI78APcB/aVM/iKiUbTWTrwOIfbJfmZhLUgvC5l4wPSgQ8Rt8VUlcl7TuDeYsHT4kKOj8KfgILYPfwz3Nhm3IpUVLqQALIjDCUIn2X20uH7ZWEA4sGNozGImXIjI+rBK+lNS/8Xnbp/wHLFFpnnarkqyiwSS6qcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775045689; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=XiDS3s5yYlqvswVEQyjuSwI4C0tCZYmt0PdRdLxftNM=;
 b=DmCgzbl85uJWWVum+9TY6Tiv0DFvjwetvPyuGR2b8cs+2nIGw/Oc6KgF+TFd7dyY
 h8iPOp1UOFjl0BpG/ytlRy55cZHYDXns+qa5NL3uAMOX33AOe1XtqgjI+qCiVmaACmV
 jF4DTekNocBKVbFcHLsdCYEJh5Nx7yEzxuTSQJyU=
Received: by mx.zohomail.com with SMTPS id 1775045687069364.77452819437485;
 Wed, 1 Apr 2026 05:14:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Date: Wed, 01 Apr 2026 14:14:40 +0200
Message-ID: <4970515.ElGaqSPkdT@workhorse>
In-Reply-To: <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <CAFZQkGzxfGP4E18owJf5d6L4n25-nvYn0TG=rTLCzjpj1Hk23w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, 1 April 2026 13:57:08 Central European Summer Time Xaver Hugl=
 wrote:
> Am Do., 19. M=C3=A4rz 2026 um 13:28 Uhr schrieb Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com>:
> >
> > This series adds a new "link bpc" DRM property. It reflects the display
> > link's actual achieved output bits per component, considering any
> > degradation of the bit depth done by drivers for bandwidth or other
> > reasons. The property's value is updated during an atomic commit, which
> > is also when it fires an uevent if it changed to let userspace know.
>=20
> Hi,
> I think it's a really good idea to have a property for knowing the
> actual bpc of the link... however, I do have one big concern with this
> API specifically: It only gives me this information after a modeset.
>=20
> With this limitation, I can at most show the user which bpc was chosen
> after the apply display settings and have the end user manually test
> and figure things out, but I cannot show in the UI which bpc will be
> chosen with some configuration before they apply it, and I cannot do
> atomic tests to find a desired tradeoff automatically on the
> compositor side.

To do this I'd need to see if there's some feedback mechanism for
the output configuration chosen by the atomic check phase, so that
userspace can then run a DRM_MODE_ATOMIC_TEST_ONLY and get the value
back somehow.

The current implementation wouldn't be able to do this since it
updates the property on commit_tail. I'll need to look into whether
drivers already have everything figured out with regards to link bpc
in the check phase, and how that would best be communicated to
userspace.

> As a side note, for future patches relevant for compositors, please cc
> wayland-devel. It really shouldn't be up to chance whether or not
> compositor developers that would later use the API find out about it
> before it's merged, and keeping track of all of dri-devel is way too
> much to ask from userspace developers.

I'll do that, but consider using lei[1] to have saved searches on lore
delivered to a local Mailbox, a suitable query here may be

    dfb:drm_property

which will return all e-mails with diffs matching added lines with
"drm_property" in them, from which lei can then fetch the full
threads.

>=20
> - Xaver
>=20

Kind regards,
Nicolas Frattaroli

https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started [1]



