Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB54CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62FBF10E731;
	Thu,  8 Oct 2026 04:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RQIhh1v5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E424810E731
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 04:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1C536025A;
 Thu,  8 Oct 2026 04:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2271F000FF;
 Thu,  8 Oct 2026 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791432620;
 bh=/8sbOrUI2hlZ894jRuMSQHYCAO6KJc/UhJ8FilsrHek=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RQIhh1v5tIJ2ro1qyw5Nlv2jYf6iiNLroSeEF2V/0eoZWAYXxThwsP5dsrsF4aaYu
 S8lbIQGDLsZQfxbNE0phGlPXANlj9NMN13ApdQiWQuXX5V0J4JZd8NoH7o+hwKoQW1
 JMK5LvTmOn44dS25YmVpNyDKOxKBiIIZixC20qDMTWkR4SFp8kFptCbKPul8waMWDI
 pbn6yA+BT9qV4T5wKrqh6sODQAwS6TtwCqK000lZEYp9Fr92IwHnpEFt1CAfq70Y9f
 tKeylXPKuyjL5TY384vS9nLkykL9WtCKJqXaw4uJqdVEyUsafdEIXERczeJ5NPqBU+
 J8DCWMRwA6k6A==
Message-ID: <sashiko-outbox-163604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 18/19] accel/amdxdna: Implement AIE4 suspend and resume
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-19-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-19-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 04:10:19 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel/amdxdna: missing job abort on pci_enable_device failure in r=
esume
--

commit dc42481bff99333322ed758d78317abfcf760ec5
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement AIE4 suspend and resume

This commit implements suspend and resume callbacks for AIE4 Physical Funct=
ion
(PF), Virtual Function (VF), and Classic device types. It introduces functi=
ons
to manage hardware contexts and pending jobs across suspend boundaries, and
establishes stateless links between VFs and PFs for SR-IOV coordination.

diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_=
pci.c
--- a/drivers/accel/amdxdna/aie4_pci.c
+++ b/drivers/accel/amdxdna/aie4_pci.c
[ ... ]
@@ -1277,11 +1277,10 @@ static int aie4_vf_resume(struct amdxdna_dev *xdna)
>  static int aie4_vf_resume(struct amdxdna_dev *xdna)
>  {
>  	struct amdxdna_dev_hdl *ndev =3D xdna->dev_handle;
>  	struct pci_dev *pdev =3D to_pci_dev(xdna->ddev.dev);
>  	int ret;
> =20
>  	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> =20
>  	ret =3D pci_enable_device(pdev);
>  	if (ret) {
>  		XDNA_ERR(xdna, "enable pci device failed %d", ret);
>  		return ret;

[Severity: High]
If pci_enable_device fails here, does this return leave pending software jo=
bs
hanging indefinitely?

During suspend, aie4_hwctx_suspend_all is called with clean_jobs set to fal=
se,
which destroys the hardware context but intentionally leaves software jobs
pending. If resume fails early, shouldn't those pending jobs be explicitly
aborted and their fences signaled with an error?

The later failure path for aie4_vf_hw_start calls aie4_hwctx_suspend_all wi=
th
clean_jobs set to true to properly handle this cleanup.

>  	}
>  	pci_set_master(pdev);
> =20
>  	ret =3D aie4_vf_hw_start(ndev);
>  	if (ret) {
>  		XDNA_ERR(xdna, "hw_start failed %d", ret);
>  		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
>  		aie4_hwctx_suspend_all(ndev, true);
>  		goto pci_disable;
>  	}
[ ... ]
@@ -1331,11 +1331,10 @@ static int aie4_classic_resume(struct amdxdna_dev *=
xdna)
>  static int aie4_classic_resume(struct amdxdna_dev *xdna)
>  {
>  	struct amdxdna_dev_hdl *ndev =3D xdna->dev_handle;
>  	struct pci_dev *pdev =3D to_pci_dev(xdna->ddev.dev);
>  	int ret;
> =20
>  	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
> =20
>  	ret =3D pci_enable_device(pdev);
>  	if (ret) {
>  		XDNA_ERR(xdna, "enable pci device failed %d", ret);
>  		return ret;

[Severity: High]
Does this error path share the same issue as aie4_vf_resume where failing to
call aie4_hwctx_suspend_all with clean_jobs set to true might deadlock wait=
ing
userspace tasks?

>  	}
>  	pci_set_master(pdev);
> =20
>  	ret =3D aie4_classic_hw_start(ndev);
>  	if (ret) {
>  		XDNA_ERR(xdna, "hw_start failed %d", ret);
>  		/* Contexts cannot reconnect; fail waiters and abort running jobs. */
>  		aie4_hwctx_suspend_all(ndev, true);
>  		goto pci_disable;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D18
