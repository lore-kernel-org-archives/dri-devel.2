Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E7BF54ACF
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3DB10E671;
	Tue, 24 Mar 2026 15:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="W7b9Dzg8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AE310E67A;
 Tue, 24 Mar 2026 15:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774365913; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FHAKaU6BZH80IYFqEa3eAOZmceU7Hw+oHbexTK3eflxpH++56aFzspdGD7Fc12ynCOXfZQVJd9bcZWjwCFjsDJdXd/qtZatHC1Rud+V5OMP1eY3nO8BK1jkBLSVt4romPtgiJT6VcoNkg3hN76JhnHASYpkhGEYe0kg182x0twQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774365913;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MWYjgfX6VpVyfxxQYgJCWmWSXFOd4Jy+zVQGptpNyRU=; 
 b=cuBVRg8nYCe9MzDT4bLrQ7fGmsLUudcZXpvvDk38PwW+lH4miAfyy83W0sHiPNHhxgO6MQ+El0w0S3e1iv3+uAqkxGZkh0lz2yrPy8qgzrzBWE6jsNiWUKTyRTfmRyXx+wcA4jAnFLGmgXbVYXgVQo4iLMD91DRQUOLchrS28rI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774365913; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=MWYjgfX6VpVyfxxQYgJCWmWSXFOd4Jy+zVQGptpNyRU=;
 b=W7b9Dzg87cNtQZjUxQcIWP5d1fUlh74bGCuiDBpP7e1E7x+QckPPaaRL/YfpIHEY
 fr0OC1PYoNrmYBhJYsupkxZMdNtmuVq4nvkaiubS40pMBY1AIpRiXLCJinL7o4CivQT
 kYMBx9OBcg7SfRKOcdYRLXUEPo2cn2bjEgZMd/kk=
Received: by mx.zohomail.com with SMTPS id 1774365912399120.92841279798449;
 Tue, 24 Mar 2026 08:25:12 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Date: Tue, 24 Mar 2026 16:25:05 +0100
Message-ID: <4265353.aeNJFYEL58@workhorse>
In-Reply-To: <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
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

On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel D=
=C3=A4nzer wrote:
> On 3/23/26 17:55, Nicolas Frattaroli wrote:
> >
> > "Someone might not understand its purpose" is, in my eyes, not a valid =
reason to
> > not have this property, [...]
> Per my previous posts, that's not my concern.
>=20
>=20
>=20

Then what is your concern? That the link-bpc property does not
consider DSC and dithering? Two things which the max-bpc property
also does not consider?

Please clearly state where your problem with this property is (and
not with how your understanding of the Weston MR uses it) so that
I can make forward progress here. If all you want is a clearer
description of the property in the comment that accompanies it,
then I can do that, and I said I agree with this point. But you
seem to be arguing from a position of not wanting the property to
exist at all, which is not something I can address. Userspace needs
a way to close the feedback loop here, or it won't be able to make
the right content-specific trade-offs.

Kind regards,
Nicolas Frattaroli


