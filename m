Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4ADC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 00:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1521C10E1D4;
	Thu,  6 Aug 2026 00:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gqDpxPtP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F63B10E1D4
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 00:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785974811; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F8szQjloI2HGbswnB6GC8fbCZwhihcCrn+BQ6UcWK/tSHtq+iBPuHO9TWxjDYJvUodIFhO7jGrP/kufDjIm1DxqDFnlz7YyTzqgaml1mQoIAVQFOYRYDatjwiu3USAa9USamYyIBSSy3CbeYEBbQK2CHBWKXmt0LsguhUbKTHOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785974811;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=i0OYm55VnGqgGb0VFbxOmWFfxkHnHHoaKYh8LfQZVtM=; 
 b=SIeoYuWM+gvgFPcATFE6+tUlzSEJzyAwnzL+G3Kq68DtBMM1h3S1Y3QI4KAnJKOF8q/hL7QxtIrqqzG+2AgkRloaBuWsK3DKHjXDKpKGijG83U1qh7166zDWrxw3a4BC88D/f+hKc86KtwtEphbGh2I6tEgzYix/n7b2uMsEoMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785974811; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=i0OYm55VnGqgGb0VFbxOmWFfxkHnHHoaKYh8LfQZVtM=;
 b=gqDpxPtPAhkDzKfENdNEwBY1Ra4gzCP6UqsC/9mOqbkb9ujjqqe/dbj1SBK3j1O1
 Y3qNSWJQI/EwpnzQUVVuXVVGXFgaZs/YpDzqopvhYjktOPrVwgv0y64Z7XoBV1u/Si4
 Ry0+WFzY6E2elWwC7voNP1ZNRNnx+5QryZoW0r3w=
Received: by mx.zohomail.com with SMTPS id 1785974809483389.16040687769885;
 Wed, 5 Aug 2026 17:06:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 0/3] implement GPU reset API
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260708114358.957305-1-work@onurozkan.dev>
Date: Wed, 5 Aug 2026 21:06:31 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED267FF1-08A7-4C77-B0ED-F74D250DA93F@collabora.com>
References: <20260708114358.957305-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
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

Hi Onur,

I went through this and Sami's downstream implementation as asked. I =
think we
can strike a middle ground here, because it looks like the two trees =
need
different things at the moment.

Upstream tyr today has no scheduler and no jobs. It seems like =
everywhere we
might want to issue resets can get a hold of &Device<Bound>: probe,
ScopedQueue, IRQ handlers and etc. For this, I think your 'bound design =
fits,
and I'd like v4 to keep it.

I think the problem starts when the job queue lands, because now we =
might find
ourselves in places that only have access to the DRM device data which =
has a
'static bound and thus a hard requirement on Devres, AFAIU. I think we =
can keep
that in tyr-dev for now and land on top of your code later, if we shape =
a few
things accordingly. I will leave comments on 3/3.

In any case, there are changes in !74 which I think are improvements =
regardless
of the 'bound vs devres question, and I also think v4 should come with a =
user.
How about adding the GLB_PING watchdog? It would exercise schedule(), =
give
ScopedQueue its first user and lets us test this on the board.

Lastly, can you use b4 to manage the dependencies for this series, if =
you
haven't yet? It would make it easier to apply.


-- Daniel

