Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325B606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP5WsOoL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7C010F34C;
	Tue, 20 Oct 2026 08:03:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 878FA10F332
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:03:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D265D60229;
 Tue, 20 Oct 2026 08:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FBF1F000C9;
 Tue, 20 Oct 2026 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483403;
 bh=NejyTJDOq0zoZEPVCyvBE0UoWdBQB8qm+oeJlpyxUgU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=DP5WsOoLoVj/bgTc/izFjAa2oKTZq8sTWstmlEx8j1KGiaHj9rHN4Oi32h8ICIfun
 c0oHx1s++vRkC4EcJ+h918leYaS1sBkDeMSSbeh5yqXWmulMWVpVGuS1YOjgBYyZNd
 fJxoGn11JZPG029FGUEDb+CBidxBhaXoqAHFLFQGl37E771biSFsJ4rgNatu1WWlDy
 BEKuIQ6ArGmymncoxleifdoAw4Mllm7kTAPGBvue2y+KMnV3WhaXgioUeMSKDusmau
 Q7ig9XzFRS3o00thpEb26X6PG1IrOnr1u+YEjSi73LYmrCPKqzVvwg7zsuibhVOtx2
 iBQlQY9ebrRmg==
Message-ID: <sashiko-outbox-178472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: ukrainer8 <kolomiiec@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019144916.108589-1-kolomiiec@gmail.com>
References: <20261019144916.108589-1-kolomiiec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:03:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/radeon: unclocked UVD MMIO in uvd_v1_0_init() when warm-up clo=
cks fail
- [Medium] drm/radeon: excessive busy-wait and redundant unguarded warm-up =
in uvd_v1_0_init()
--

commit 6ca2d05b74a007ba26b71ef0af031a5857a4aa3e
Author: ukrainer8 <kolomiiec@gmail.com>

drm/radeon: retry UVD v1 init on failure after resume

This patch adds an unconditional warm-up cycle and a 3-attempt retry loop to
uvd_v1_0_init(), and increases the polling timeout in uvd_v1_0_ring_test() =
to
2 seconds to recover from UVD initialization failures after system resume.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130

> diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/u=
vd_v1_0.c
> index 5e6607e16244b..79d3b8cd32388 100644
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -158,24 +158,58 @@ int uvd_v1_0_init(struct radeon_device *rdev)
>  {
>  	struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX];
>  	uint32_t tmp;
> -	int r;
> +	int r, retry, clk_err;
> =20
> -	/* raise clocks while booting up the VCPU */
> +	/* warm-up: silently cycle the engine once (like the Windows driver),
> +	 * the first ring instance after resume is dead functionally */
>  	if (rdev->family < CHIP_RV740)
>  		radeon_set_uvd_clocks(rdev, 10000, 10000);
>  	else
>  		radeon_set_uvd_clocks(rdev, 53300, 40000);
> +	uvd_v1_0_start(rdev);
> +	uvd_v1_0_stop(rdev);
> +	mdelay(20);

[Severity: High]
What happens in uvd_v1_0_init() if radeon_set_uvd_clocks() fails during this
warm-up block?

In the retry loop right below, the return value of radeon_set_uvd_clocks() =
is
saved in clk_err, and both uvd_v1_0_start() and uvd_v1_0_stop() are guarded=
 by
!clk_err because MMIO accesses to an unclocked UVD block can cause a PCI bus
master abort and hard-hang the system.

Here in the warm-up block, the return value of radeon_set_uvd_clocks() is
ignored (for example, if radeon_uvd_send_upll_ctlreq(), sumo_set_uvd_clock(=
),
or cik_set_uvd_clock() returns -ETIMEDOUT, or radeon_uvd_calc_upll_dividers=
()
returns -EINVAL), and uvd_v1_0_start() and uvd_v1_0_stop() are called
unconditionally. Won't that immediately perform MMIO reads and writes to the
unclocked UVD registers (such as UVD_CGC_GATE, UVD_MASTINT_EN, UVD_LMI_CTRL=
2,
UVD_RB_ARB_CTRL, UVD_SOFT_RESET, and UVD_STATUS) before the guarded retry l=
oop
is ever reached?

In addition, is this unconditional warm-up cycle necessary given that the
3-attempt retry loop below already stops UVD, delays 20 ms, and retries from
scratch when a failure occurs? Running the warm-up unconditionally on every
cold boot and healthy resume across all R600 through CIK GPUs adds ~200 ms =
of
busy-wait mdelay() overhead (programming UPLL, starting and stopping the VC=
PU,
waiting 20 ms, and then immediately reprogramming UPLL a second time on the
first retry iteration while clocks are already raised), and if the VCPU is
unresponsive, uvd_v1_0_start() busy-waits for ~10.2 seconds of mdelay() in
the warm-up before repeating it 3 more times in the retry loop (~40.8 secon=
ds
total).

> +
> +	/* after resume the first ring test can race with the hardware; retry */
> +	for (retry =3D 0; retry < 3; retry++) {
> +		/* raise clocks while booting up the VCPU */
> +		if (rdev->family < CHIP_RV740)
> +			clk_err =3D radeon_set_uvd_clocks(rdev, 10000, 10000);
> +		else
> +			clk_err =3D radeon_set_uvd_clocks(rdev, 53300, 40000);
> +		r =3D clk_err;
> +		if (r)
> +			drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attemp=
t %d\n",
> +				 r, retry + 1);
> +
> +		if (!r) {
> +			r =3D uvd_v1_0_start(rdev);
> +			if (r)
> +				drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\=
n",
> +					 r, retry + 1);
> +		}
> =20
> -	r =3D uvd_v1_0_start(rdev);
> -	if (r)
> -		goto done;
> +		if (!r) {
> +			ring->ready =3D true;
> +			r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> +			if (r) {
> +				ring->ready =3D false;
> +				drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d=
\n",
> +					 r, retry + 1);
> +			}
> +		}
> =20
> -	ring->ready =3D true;
> -	r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> -	if (r) {
> -		ring->ready =3D false;
> -		goto done;
> +		if (!r)
> +			break;
> +
> +		/* MMIO is only safe when the block is actually clocked */
> +		if (!clk_err)
> +			uvd_v1_0_stop(rdev);
> +		if (retry < 2)
> +			mdelay(20);
>  	}
> +	if (r)
> +		goto done;
> =20
>  	r =3D radeon_ring_lock(rdev, ring, 10);
>  	if (r) {
> @@ -421,7 +455,8 @@ void uvd_v1_0_stop(struct radeon_device *rdev)
>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *r=
ing)
>  {
>  	uint32_t tmp =3D 0;
> -	unsigned i;
> +	/* after resume the ring buffer controller needs ~1.5-2s to settle */
> +	unsigned i, timeout =3D 2000000;
>  	int r;
> =20
>  	WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
> @@ -434,14 +469,14 @@ int uvd_v1_0_ring_test(struct radeon_device *rdev, =
struct radeon_ring *ring)
>  	radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
>  	radeon_ring_write(ring, 0xDEADBEEF);
>  	radeon_ring_unlock_commit(rdev, ring, false);
> -	for (i =3D 0; i < rdev->usec_timeout; i++) {
> +	for (i =3D 0; i < timeout; i++) {
>  		tmp =3D RREG32(UVD_CONTEXT_ID);
>  		if (tmp =3D=3D 0xDEADBEEF)
>  			break;
>  		udelay(1);
>  	}

[Severity: Medium]
Could replacing rdev->usec_timeout (100,000 usec) with a hardcoded timeout =
of
2,000,000 iterations in uvd_v1_0_ring_test() stall a CPU core for several
seconds per failed attempt?

Because uvd_v1_0_ring_test() has no early-exit condition on failure and only
fails after exhausting all loop iterations, any failed ring test attempt wi=
ll
execute 2,000,000 iterations of synchronous PCIe MMIO RREG32(UVD_CONTEXT_ID)
plus udelay(1) in a non-sleeping busy-wait loop. Across 3 failed attempts in
uvd_v1_0_init(), this will busy-wait for 6 to 15+ seconds during boot, syst=
em
resume, or GPU reset.

Also, the comment here states that the ring buffer controller needs ~1.5-2s=
 to
settle after resume, whereas the commit message states that the first ring
instance after resume is dead functionally, not by timeout, and only a full
stop+init cycle revives the engine. If a stop+init cycle is what revives the
engine, is widening the busy-wait poll window from 100 ms to 2000 ms needed?

> =20
> -	if (i < rdev->usec_timeout) {
> +	if (i < timeout) {
>  		drm_info(&rdev->ddev, "ring test on %d succeeded in %d usecs\n",
>  			 ring->idx, i);
>  	} else {

=E1=80=B7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019144916.1085=
89-1-kolomiiec@gmail.com?part=3D1
