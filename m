Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F26CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BADA10E055;
	Mon, 12 Oct 2026 16:06:43 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697CF10E055
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791821196; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TnTzHKL6in7wiqhrDLUMWWDHjHrPlHE8ZmymRpr4mNr2C1YzpFqXb+IX56VyIJ3uk/F2HvHpLYrHlMs1FYzpsAV/g0DPFweZRbm7IvGzIhu4TlK02jc23ssfedDGSsWcxNVqj4T6XiPSTUY4xSGaWFqmZSH7dR+l+XWHYH8n/6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791821196;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kpl7bgQq54ugqONoh1i3qk1kF/nXr2JA7OnourSb7I4=; 
 b=FTSVgT2utbFHnxaYt6a9SNVnHeYl11kZECO74fpCgPG9ryBlpYg2sLGsi+sIUilo/PttkkkeSUpC4BSDoJw7lAfQxk1kJzBJZ/ILrRAOcC0iak1BqxdBiZnzXQQ082CKcmPS/803LmYy2YH2WTi8ZsdPEtCHreHLcMaJw40sGQU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791821196; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=kpl7bgQq54ugqONoh1i3qk1kF/nXr2JA7OnourSb7I4=;
 b=jS4AGKSbFD/PUfeheC1u/TG9n1rxRB9yGNaYOyP+hIVHe0JTwiJJa4tcfqgcDqhH
 9gwBCKsQDnHJLNVrDzOHtvKo+jrNlxWfjyJId8tulfZ93WvdjAG3x8c5v7mSLAOWOwe
 /5UDHzhoHf81zq6wljzwoDeELPVY5JyVgCOTebeQ=
Received: by smtp.zohomail.com with SMTPS id 1791821195310505.8212225900496;
 Mon, 12 Oct 2026 09:06:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DM22LS0S86HB.2G9NWE78JHV0@kernel.org>
Date: Mon, 12 Oct 2026 13:06:20 -0300
Cc: sashiko-reviews@lists.linux.dev, Alexandre Courbot <acourbot@nvidia.com>,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0CA5ABE5-C198-45D5-B393-50AA219D6F14@collabora.com>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
 <20260814232106.01AA71F000E9@smtp.kernel.org>
 <E989BBD7-DF97-4384-AFC1-3D7448A1C747@collabora.com>
 <DM22LS0S86HB.2G9NWE78JHV0@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External
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


>=20
> close() is a pure optimization callback, e.g. to unmap memory that =
userspace
> can't reference anymore anyway.  For the reasons mentioned above, =
providing it
> to the driver after the DRM device is unregistered is pointless, and =
calling it
> when unregistering the DRM device would be pointless too, as any data =
it could
> ever access is dropped at this point anyway.


So you=E2=80=99re saying that close() can be removed entirely? Or did I =
misunderstand?

=E2=80=94 Daniel=
