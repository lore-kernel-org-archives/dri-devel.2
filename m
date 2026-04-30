Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A74CCCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CEE10F492;
	Thu, 30 Apr 2026 21:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="CxYrOXHe";
	dkim-atps=neutral
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF60A10F48D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 21:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777583516; x=1777842716;
 bh=q8TMlCVl6DeBHQVUxTxFZiomcd/Yq6C+phmEEmaq7VE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CxYrOXHeeSCnfq36+j8e0UXWAwkHks4IZGJy4oB7h2XmPL0PnLycaNatsgFBr7BWV
 oEoCQ8oYP12IrjsLT4lOffCam9xpyoUWsrjg8Hxbof7aFu+cO0Hj9SJge6tZAI7myj
 4rNBuMGwTe7/hkmguDUuFliL/j/hn7V0BBUwGt/FXEhANmjc/bf77aoRASb7ox4Iv1
 /ovjXHmqF2ECF++s+Mv48yg0YCTjQO3P9KJZs1k6M6xX096jOrm71OfYBeoohUUkOK
 Botu2yx1XYVlRmlYL7CSsTxTesWyeoACtuzbd7YhWfRONhQaw2ovd6+60H0LJmpwI/
 iqQvSzHp/Jg9A==
Date: Thu, 30 Apr 2026 21:11:51 +0000
To: =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vidith Madhu <vmadhu@nvidia.com>, dri-devel@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, xorg-devel@lists.x.org
Subject: Re: Native DisplayID support in core DRM
Message-ID: <nNHAgq_075xcIstZgSRJ0LASnvNd7FP6D2XfBPVa3SyjPX1nErxrrRqEIcd4nO7a0WY-pvrTS9NOR_ESqsHGsbpuLNRBGdzyn6-Vi-QSyPQ=@emersion.fr>
In-Reply-To: <aeaJlED2e1ZXsLlt@intel.com>
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
 <aeaJlED2e1ZXsLlt@intel.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: bf611e5b9adcf467ec9744117e411acd284b63bc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Monday, April 20th, 2026 at 22:16, Ville Syrj=C3=A4l=C3=A4 <ville.syrjal=
a@linux.intel.com> wrote:

> I think if people want to implement this before actual displays are
> available then what would be needed are some reasonable sample
> DisplayIDs so that the code can actually be tested.

Yeah. The spec has a few examples, but some real-world blobs would be very
useful. I'd be interested in writing/reviewing DisplayID patches for
libdisplay-info and wlroots.

We have some DisplayID parsing in libdisplay-info, but we don't provide yet
a way to parse raw DisplayID blobs, short of a real use-case. We've designe=
d
the API in such a way that DisplayID support can be easily added, though.

> > While no consumer displays currently utilize native DisplayID, beginnin=
g
> > this year VESA has mandated it be supported for new DP2.1 source device
> > certification submissions. Therefore, display certification
> > on Linux is the most pressing motivation for native DisplayID support.
> > Beyond that, ensuring this support is present by the time consumer
> > displays start adopting it will provide a seamless consumer experience =
for all Linux
> > display driver vendors, including NVIDIA.

That's good to hear.

> >     4. There is also the question of how the user interfaces for overri=
ding and reading
> >        EDID will need to change (/sys/class/drm/cardX/edid and /lib/fir=
mware). Should there
> >        be separate nodes for native DisplayID, or should they just deal=
 with an opaque blob
> >        of bytes, and leave it up to the user/DRM to interpret whether i=
t is EDID or native
> >        DisplayID?

The big one here is the "EDID" blob property exposed by KMS. We can't just =
put
a DisplayID blob in there, that would break user-space. We'll need a new
property.

Simon
