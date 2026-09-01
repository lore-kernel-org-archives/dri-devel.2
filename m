Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7DC624D4
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4150010ED07;
	Tue,  1 Sep 2026 14:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T86kfLFV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AA010ED04;
 Tue,  1 Sep 2026 14:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D313C429F1;
 Tue,  1 Sep 2026 14:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205211F000E9;
 Tue,  1 Sep 2026 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788271553;
 bh=CTknvhEq1CqIlSFU97KLOYi0xL7I+CIZYWA6D4VploE=;
 h=Date:From:To:Cc:Subject;
 b=T86kfLFVzv/LMWWvJyWc1WE530O9FuOpMjrIXl6neg9oGlgX6g0lBXtH6jKHetxL7
 zXvZp7uUE10ERST0HjFvWmXTWxf5EYwpVvjZxAUWHabk3x5GZikzzE6ComuEtTIat+
 QorA2IKJwFl5bcsTQNGU9bwUGevZwJIHgjsSJSlO/bJdMUtWAXMhbOUayTxHqkVvoG
 E7V8HutMlCqbyjfTlskw7cFIS/hTD3RCdbeot7JrZ35mJnP+sIjHFHvNLhLEyuZk/6
 yxS7TjTBic9T46r0ig+77ZrH4w88F9EUzb4NK6ngJAs0NFGY2ALUv5f+wbfxkpoCII
 bNr348SUOvCTA==
Date: Tue, 1 Sep 2026 15:05:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <apbbvQSfUbzYRFaw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HmtZ0rKD4icBIn+t"
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


--HmtZ0rKD4icBIn+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
  408 |         ad->card = card;
      |         ~~  ^

Caused by commit

   699e5975e2a53 (drm/omap: Report HDMI hotplug events to the ASoC HDMI codec)

I have used the tree from next-20260831 instead.

--HmtZ0rKD4icBIn+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqW27wACgkQJNaLcl1U
h9D+Twf+MFViDggeP6uPjB0hQptPtqvvGqn2LU6SMVynJ44NuwmfnkXxly8cPGWc
PzUZjHAp4mtUm/Bab6JdESaYJfmu/ydlauAFJHQykUx+GPHut+wbUpm8ZHLCfetT
m/nhGNCRglNttCg9B211khXpIlsJlmu94pY3c+dmTdIEfLXyQ8akTyPihRb9RCX2
ghWqUzPGGNuP9nFotyOZ2MCpV/MLXe6+piMBh0FEmrP+WUCdm2YnNmNjfY6TDp3Y
xQjU+pPPCtERj7lQcVZjzIDCbBMiW+zI3IRw/0Pn0+G2V/sX/dO5v+HZe6J5vlpq
uYYWqplrMmNzVMj1mVCeoLDZTwLZ9Q==
=2Ld1
-----END PGP SIGNATURE-----

--HmtZ0rKD4icBIn+t--
