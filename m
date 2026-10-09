Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B80CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D6210E08C;
	Fri,  9 Oct 2026 23:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TQvGkaBO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8870F10E08C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5522040E81;
 Fri,  9 Oct 2026 23:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97921F000FF;
 Fri,  9 Oct 2026 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587828;
 bh=uTyq+gG3BmiJuifTGHZT7h/852nDGs9lABXPN5fqywE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TQvGkaBOk30lSP4PESwhkm5oRBQSss8uhsTY/SySaWxmrdCUbiR7rDEU2z67Ptl1Q
 vVYlzt5kLQBiIO2kWQPQuz5q+9/JYWiyq6D+VRDNpp5L/QsZ7BGMMBTwYVu/ebZYPK
 8VC5m8qYSvEeSbTHrOIsJpC1R+UqHufIj0Dx+gIfh22nrtHd8TbTjO8T2bmmMnCPTI
 WXBiWZYnV2SEWMO1zzN0d8yIfeiLJAw4X53rJtz3Cj2VfRcE5SmythD68KVp7yE+Zi
 OAJ6JqZ69MDIzzdN33lCq1RSURJGPIQ8mPMlkRenJJb6F2PsWOfiWF+INZGVCtKcVi
 VrWIIiReSRMTw==
Message-ID: <sashiko-outbox-166180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 19/19] accel/amdxdna: Implement runtime suspend and
 resume support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-20-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-20-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:17:07 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] amdxdna: Missing runtime PM reference during hardware context dest=
ruction
- [Low] amdxdna: Dead code due to unconditional assignment of PM callbacks =
in aie2_ops
--

commit e84dc9f8e09a4669bbdb0e93c4368ea773cd8d73
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement runtime suspend and resume support

Add runtime suspend/resume for the AIE4 classic device by using its
system suspend/resume handlers.

> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie=
2_pci.c
> index 690ad035463c5..a3866e8933e61 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -1221,6 +1221,8 @@ const struct amdxdna_dev_ops aie2_ops =3D {
>  	.fini =3D aie2_fini,
>  	.resume =3D aie2_hw_resume,
>  	.suspend =3D aie2_hw_suspend,
> +	.runtime_resume =3D aie2_hw_resume,
> +	.runtime_suspend =3D aie2_hw_suspend,

[Severity: Low]
Are pm_ptr() wrappers missing here?

Unlike aie4_classic_ops, which correctly wraps these assignments in
pm_ptr(), aie2_ops omits the wrappers. When the power management
configuration is disabled, the compiler cannot automatically discard
these functions, resulting in dead code being linked into the kernel.

>  	.get_aie_info =3D aie2_get_info,
>  	.set_aie_state =3D aie2_set_state,
>  	.hwctx_init =3D aie2_hwctx_init,

[ ... ]

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 70a052ab5f775..60140c3927a2e 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1041,6 +1041,7 @@ static int aie4_classic_init(struct amdxdna_dev *xd=
na)
>  	if (ret)
>  		goto free_work_buf;
> =20
> +	amdxdna_pm_init(xdna);

[Severity: High]
Could this introduce a bug when destroying hardware contexts while the devi=
ce
is suspended?

The driver enables runtime autosuspend here, allowing the device to enter
a suspended state when idle. When a user destroys a hardware context,
the destruction path runs without ensuring the device is active:

amdxdna_drm_destroy_hwctx_ioctl()
  amdxdna_hwctx_destroy_rcu()
    aie4_hwctx_stop()
      aie4_hwctx_destroy()
        aie4_msg_destroy_context()

None of these destruction paths call amdxdna_pm_resume_get() to wake up the
device.

If the device has autosuspended, the firmware is stopped and the mailbox
is finalized (via aie4_mailbox_fini()). Accessing the mailbox registers
in this state will cause a bus error, system hang, or kernel crash.

>  	return 0;
> =20
>  free_work_buf:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D19
