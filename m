Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B66FF60FB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6613C10E9EF;
	Tue, 31 Mar 2026 10:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qNeGW2RE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A7410E9EF;
 Tue, 31 Mar 2026 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774952915;
 bh=aOnw8uG1bF/umdq2HHno0LlsuApV4JZmSR7Oe9w5svA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qNeGW2RErsqXeMjsQ3E8PrMQRzMa+Yp76N5P1LLboHDi6Zpd2W/+DGRsCZ3OtmOPK
 LToNk635P9lUBJOMTXVUfvgm0+e9jqIlgwrw9h+j2b74h+YPpH1ClalH5yxB04yPEc
 HBMzebO1ft3z1BphfVDTvctmXwwUaTWmGq1HKEZanMzt1ss9MEZXGpfe07oLeAbEpa
 3ml7WQRAHjX6lS71doegTKYUTLsgSGFxgl9N/wNYdAQA+Ngcygg+wFQkH4hJYmWP1z
 yMG+tEoV1OUFFDSuvihVCVeoUhJuEj5JLLW7+9OeiBaFSIaAEKLfM7XRgOx17Mdc0i
 Tv0PTBZRI6g7A==
Received: from fluorite (unknown [194.136.85.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E1C117E5F0E;
 Tue, 31 Mar 2026 12:28:34 +0200 (CEST)
Date: Tue, 31 Mar 2026 13:28:22 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>, Nicolas
 Frattaroli <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Leo Li <sunpeng.li@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Ville
 =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Stone
 <daniels@collabora.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, Marius
 Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <20260331132822.5ac57253@fluorite>
In-Reply-To: <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8676926.T7Z3S40VBb@workhorse>
 <eff61423-a854-44c1-8634-30e2bd61e005@mailbox.org>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <20260326155305.736b4e64@fluorite>
 <7461820c-e3ab-40f5-98d2-9878e60ba2ad@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MQ0.wLD4iLWOheFBMvZLWA3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/MQ0.wLD4iLWOheFBMvZLWA3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2026 15:01:33 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> On 2026-03-26 09:53, Pekka Paalanen wrote:
> > Hi Michel,
> >=20
> > I have some opinions as well.
> >=20
> > On Tue, 24 Mar 2026 17:44:21 +0100
> > Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:
> >  =20
> >> Per my previous posts, my concerns are:
> >>
> >> * The meaning of the "link bpc" property value isn't defined well
> >> enough vs things like dithering or DSC, which will likely result in
> >> compositors / users overestimating what value they need / want,
> >> resulting in compositors spuriously rejecting configurations which
> >> would work perfectly fine, and/or spurious issue reports. =20
> >=20
> > That is ok. Compositors need to understand what the numbers mean, how
> > reliable they are, and act accordingly. Knowing the lower bound for
> > link precision is already useful as it guarantees a minimum precision.
> > It is up to the compositors to decide how they communicate this.
> >=20
> > Or course, assuming lossy compression is not too lossy. Maybe
> > lossy compression should be forbidden by default unless explicitly
> > enabled by userspace?
> >  =20
>=20
> I disagree. While technically lossy, DSC is perceptually lossless, at
> least according to the designers of DSC. If I'm not mistaken this is
> all based on extensive studies.
>=20
> The decision to enable DSC or not has an impact on the power consumption
> of the HW, in ways that are often nuanced. Userspace has no way to know
> or understand these nuances. This should be in control of the driver.

I guess time will tell.

Are you saying that enabling DSC might have disadvantages aside from
image quality?

> At most I could see a "never do DSC or dither" toggle, if one is really
> concerned about this, but I don't realistically see use-cases where this
> would improve user experience, even for users that care about color work
> and correctness.

I'm not familiar with DSC, so I cannot criticise it. Dithering OTOH
seems to be obviously suspect though.

Temporal dithering - what if your refresh rate is 30 Hz for some movie
playback?

Spatial dithering - what if you have a low-resolution screen?

I would not assume that dithering is always ok, and always achieves its
theoretical results.

> The YCbCr420 case is different. We probably want a way for userspace to
> understand that half 3/4 of chroma values are being tossed out. This
> would be significant for RGB content but insignificant for YCbCr420
> content.

Do you mean full resolution vs. chroma sub-sampled to 2x2 blocks? I
would again not assume "insignificant", because it depends on the
picture content and angular pixel density (can you see individual
pixels at your viewing distance). Gray-scale text will be fine, but
colored text is another question.

I'm fine with proceeding with these assumptions, as long as it is
acknowledged that these assumptions might turn out false later and have
a contingency plan.


Thanks,
pq

--Sig_/MQ0.wLD4iLWOheFBMvZLWA3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmnLocYACgkQI1/ltBGq
qqfF3A//fu8zKlepmLlixQNDwd9W3lIa3DZF6Upro7OFw4TcpYJLyh/3g6aDXwo4
TftqKM0s6MHZXjqSE6+2YCoMD6a/QGi0TFL0nRRwk3RbZHENIbHjmxyBhAXewRIJ
he55NjcSzxq8C+FXB7yllHu/G6rUX0arA+QVC9nkv4aztAe2A3DyzpRGtnVluIWQ
P//C7WT8aiTmSuMjjs6ptSyX/cC7jIkHBKy8F0TZgSyYfvMMbWdDT/N95ZcyaaNc
z2lmCNmBW1+Z6UtfhfN11vsbBNadGMJREeqVoYDuU5rloF2+XONS6jOiNZR8+jse
ooCvIZbjV9sjd+uvCUkogdK379m6nmuA0ggxfvrbPsckTwxf0hffo0OCSGKpsbe+
pXzJlldGQqk+66Q44XMWEogPcfiDSo7r5Cy081+o35ncViC58J2Jox4rWcl2OZFa
xKK/fBJB4pFc4aY5HxDq5hsFHjtHnsvwCB10APWHch/TGATjAWaK7r0vZRUPq9X6
p9wul7w6Fmge5eWga+tKi2HYQK83FsUNqhw9s432V67F17HMnFNqxxi4ZjOoyY1d
yeTr22/UH6vqHiDOH8Q+WElU2aRdxX7tGg+H841l+N0dwh9PeoXsXx8N0fD+ufax
PPfSqvXlkNrqc/0r2wS4k1SQzhdStg1kctT2p/35z4LwJsAdBPw=
=qMax
-----END PGP SIGNATURE-----

--Sig_/MQ0.wLD4iLWOheFBMvZLWA3--
