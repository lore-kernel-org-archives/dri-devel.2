Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7737BC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9692110EC03;
	Tue,  8 Sep 2026 13:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lSJwv7Mb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1245610EBF9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:50:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 417DF601DB;
 Tue,  8 Sep 2026 13:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC82C1F00A3A;
 Tue,  8 Sep 2026 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788875428;
 bh=Ypcd7yY7vmcX83+gZqkee0+O9dXiuC/9T0z33M3cUFk=;
 h=Date:From:To:Cc:Subject;
 b=lSJwv7Mb7mimvTKptRb6W953vcSK3IIZLRxcmOkNbU+und+J8o1WzUuqRCxHEuQoy
 P1B1UPrZX+4g2Lwhk+NWQR8H6ru91mt1Wj487PKX61+hO1/Ebb3MGsDjm9vkcEJpA5
 w2GAyUh1S9BP7VuOuAxpwTVRPhQJpqBTPWkIKgJfOiRyUmqo3FK5qLe5QS0PGh0Zzy
 iQezruoWh0tKakmKSsUVt5Wq/J0nUfTWVthMa1ul3S2ZljKrxBmhEbOksp0vQKTvNb
 0UECf7r24gUqP9wjbP3UcPjk5mvHwdG8QUPX0AMCRl62UQKseL4i/v8DeP0AIatV/v
 MXQEvQZ8QC1cQ==
Date: Tue, 8 Sep 2026 14:50:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <aqASn9YDPLpu_vb0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rlzMlQ66gZljiiQn"
Content-Disposition: inline
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


--rlzMlQ66gZljiiQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
  408 |         ad->card = card;
      |         ~~  ^

Caused by commit

   699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI codec)

which has been generating the exact same build failure in drm-misc since
this time last week (it looks like the promised fix finally appeared
there today, though there's yet another build failure in there behind
it).  Please take a look at your processes here, there is something
messed up if not only does it take a week to get what should be a fairly
trivial build issue addressed but the build issue gets sent upstream
unfixed in that period, comfortably after it was reported.

I have used the tree from next-20260907 instead.

--rlzMlQ66gZljiiQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgEp8ACgkQJNaLcl1U
h9CJLwf8D5Jj48mie3CTsq1qlg6Aua5XtQrNuAT+gsXGwprFZ+T+tpMa7HmwAspk
O5drF2SX62eNilqcleFjsuoavMPONgAhzEBpkULE5lR0icPLlRaJDn+KENhGFV5c
FoMSp6jLw4AxC00kNGPvKhjBOFcbZ0NGrurQrHAkyMSqnJ2plE8vA8HnGwlbogYo
JDb51kpROcjTb0Px2KguzWiPvL5ffEJ51FFvjDeP6MJ+6PlGsz0hfQU4h9ageb7k
wYEDUjw+i3WK7xm1UqXjRMhN0iYIog3BViYkSBesF0amoO/iLbd3LWJQN9UKZ4t2
XlyiWvoYvjLTUugjehzgz9EZ7U1mIw==
=KlRh
-----END PGP SIGNATURE-----

--rlzMlQ66gZljiiQn--
