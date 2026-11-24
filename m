Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC4606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8THQlmr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB1B10ED37;
	Tue, 24 Nov 2026 13:18:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340F810E5AC;
 Tue, 24 Nov 2026 13:18:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAA254562C;
 Tue, 24 Nov 2026 13:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280141F000C4;
 Tue, 24 Nov 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795526317;
 bh=tFG8Nk0NTffwnTNLr8hgHYCWBs9jogoU0blVfS/1JFs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U8THQlmr0gAvrIqcmfGkqfV997zQGo9v1557gF8hoT8m75fAjH+8vHvm15Y9MP58S
 0wRwgJnmqdWZ13xSfMnthDtq0gIpmr3uz8uqoMDodcBKhDbkTdLKGQ/sKPPshzVLY6
 nkahPMBqs9o+/TskPufUBJ/oG+Cmctw2EMVqaWnq1uTzI3tZX+3PGf632l4QmplRyK
 ce8IK8HR9pcYafQA/yzN6+MeztX6JIoP7vT28Ot32YnjEcy0fUiOTkpr5zqu+X0ka3
 lyckrtW+dLk3ZiW89jOMGW4ADwElQ/2xwhq5JygNSer5VEqjx+UMiTelZ/yOb03Bh8
 ep/QM1pbFBiHQ==
Date: Tue, 24 Nov 2026 14:18:34 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 "Syrjala, Ville" <ville.syrjala@intel.com>
Subject: Re: [PATCH 2/6] drm/i915: Use the STATE_CHECK_* macros in the pipe
 config comparison
Message-ID: <awWEUcxy-DwDxu2H@houat>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
 <20261124-drm-i915-conversion-state-readout-v1-2-b7132f72644d@kernel.org>
 <60d2980ef8dfe909b30186396b90b6eac01df3ed@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="fnvcmnx4hrdq27iv"
Content-Disposition: inline
In-Reply-To: <60d2980ef8dfe909b30186396b90b6eac01df3ed@intel.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--fnvcmnx4hrdq27iv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/6] drm/i915: Use the STATE_CHECK_* macros in the pipe
 config comparison
MIME-Version: 1.0

Hi Jani,

On Tue, Nov 24, 2026 at 01:23:51PM +0200, Jani Nikula wrote:
> On Tue, 24 Nov 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > The state readout framework provides the STATE_CHECK_* macros and
> > drm_atomic_helper_print_state_mismatch() to compare two state
> > instances field by field and report the mismatches through a drm
> > printer.
> >
> > intel_pipe_config_compare() implements the very same thing with its
> > own set of PIPE_CONF_CHECK_* macros printing through the
> > pipe_config_mismatch() helper, duplicating the framework.
> >
> > Rework the plain field checks on top of the STATE_CHECK_* macros,
> > sorting every PIPE_CONF_CHECK_I() and PIPE_CONF_CHECK_X() call site
> > onto the variant matching its field type: STATE_CHECK_BOOL(), _S32(),
> > _ENUM(), _U8(), _U16(), _U32(), _U64() and _PTR(), along with the
> > _U8_X(), _U16_X() and _U32_X() hexadecimal counterparts. The
> > static_assert() of each macro then checks the field type at compile
> > time, which the untyped PIPE_CONF_CHECK_I() and _X() macros couldn't
> > do, and PIPE_CONF_CHECK_LLI() becomes a STATE_CHECK_U64() based check
> > that also prints its u64 fields properly.
> >
> > The checks without a framework counterpart, namely the masked, flags,
> > M/N, DPLL, timings, rectangle, infoframe, DP SDP, ELD buffer, color
> > LUT and CSC ones, along with the infoframe, SDP, buffer and PLL
> > mismatch reporters, print their header through
> > drm_atomic_helper_print_state_mismatch() instead.
> > pipe_config_mismatch() isn't needed anymore and gets removed.
> >
> > The mismatch messages change format in the process, from
> >
> >   [CRTC:31:pipe A] fastset requirement not met in hw.enable (expected y=
es, found no)
> >
> > to
> >
> >   pipe A configuration mismatch in hw.enable (expected yes, got no)
>=20
> I think the "fastset requirement not met" vs. "mismatch" distinction has
> been a useful one. People tend to think a "mismatch" is always an error,
> regardless of the loglevel. We know, because we deliberately added the
> distinction about three years ago to unconfuse people...
>=20
> We've also put in a lot of effort to have a fairly uniform drm object
> logging prefix all over the place. It would be a shame to lose it,
> because over time you get used to searching the dmesg with that format.

So I guess your preference would be for the new framework code to follow
the same convention?

And it looks like the "fastset" path doesn't really translate to
anything (yet?) in the helpers, so maybe we could only convert the
pipe_config_mismatch() path for now?

How does that sound?

Maxime

--fnvcmnx4hrdq27iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawWOowAKCRAnX84Zoj2+
dmm3AX9QmAGHpsMCBLn6jRdhO0UzL6zpQ1M3Mg9TXri9MM4JphYljgifsb82DPLO
RHv3rnABf0JXD89V7zXM9LzCtQwEQbb5RWpuBmOZ0hW+bW372vh1zTaRNsUSCVD0
BIpg2Dy/OA==
=CCfd
-----END PGP SIGNATURE-----

--fnvcmnx4hrdq27iv--
