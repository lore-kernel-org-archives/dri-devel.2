Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BCCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8617C10F02C;
	Tue,  6 Oct 2026 04:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jbr7OBMb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7573510F029
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:35:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DF5C406A6;
 Tue,  6 Oct 2026 04:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1713C1F000FF;
 Tue,  6 Oct 2026 04:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791261319;
 bh=g/xVIyVXm0qR4IAjs4bF8UOgEzlR5EgYDSJHbs0hlpg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jbr7OBMbWqvaLxkQlv4UfBEOC+6uDYXvAB3esyrwK5aLP4Qt+e278HwthnZPJtZC6
 lC0/HIfOUtdZhk0gUewlirUuIvxff+Tvz+Rmky5Q8p7e8/bs+gnfhQuR0/1D3zKqwJ
 Qxn2ZW1S3HJ2SQGrgAQr96JrcKg7LHrA5HxsBvkIbuQTexrDKnhOq8M6G6EqHvuo42
 QO7SoOrvIS689cjNy1tHvQE4/Z8x7P5Ru3OV50IkwrFxxsTDpnmZYKkoydLaQGUF9p
 6Thy+OGAtbi574eYc271fDiEjAq4ntETLHXaZJY/32HKMbre3+DsPdw1QLZwQB3qsD
 +uttBmZCsxuFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 18/20] accel/amdxdna: Link SR-IOV VFs for power
 management sequencing
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006042230.547807-19-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
 <20261006042230.547807-19-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 04:35:18 +0000
Message-Id: <20261006043519.1713C1F000FF@smtp.kernel.org>
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
- [High] PM device link between PF and VF is lost on VF driver unbind
--

commit e5da3c2c28df6a2bd8639c6fb55cd8abc88ea7e5
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Link SR-IOV VFs for power management sequencing

This commit adds PM device links between Physical Function (PF) supplier
and Virtual Function (VF) consumers via device_link_add() upon SR-IOV
enablement. The intent is to ensure the PM core enforces proper sequencing
between the PF and VFs.

> diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/a=
ie4_sriov.c
> index 0eea28f626763..3cad0526087db 100644
> --- a/drivers/accel/amdxdna/aie4_sriov.c
> +++ b/drivers/accel/amdxdna/aie4_sriov.c

[ ... ]

> @@ -56,9 +56,74 @@ int aie4_sriov_stop(struct amdxdna_dev_hdl *ndev)

[ ... ]

> +static int aie4_link_vf(struct amdxdna_dev *xdna, struct pci_dev *pdev_v=
f)
> +{
> +	struct pci_dev *pdev_pf =3D to_pci_dev(xdna->ddev.dev);
> +	struct device_link *link;
> +
> +	/*
> +	 * The link is removed when the VF driver unbinds. To rebind VF
> +	 * drivers, re-enable SR-IOV via sriov_numvfs (0, then N).
> +	 */
> +	link =3D device_link_add(&pdev_vf->dev,   /* consumer =3D VF */
> +			       &pdev_pf->dev,   /* supplier =3D PF */
> +			       DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: High]
Does this flag choice break subsequent binds like vfio-pci passthrough?

Using DL_FLAG_AUTOREMOVE_CONSUMER causes the PM device link between the PF
and VF to be permanently deleted when the VF driver is unbound via sysfs.
If the PF is then allowed to enter runtime suspend and the VF is later
rebound to a driver like vfio-pci for virtualization passthrough, the PM
core will not automatically resume the PF. The VF driver will then probe
while the PF hardware is suspended, which can lead to a system crash or
hang.

While the comment notes that rebinding is not supported, any root user
or virtualization management daemon (like libvirt) can still trigger
this standard SR-IOV passthrough use-case because the driver does not set
suppress_bind_attrs =3D true to block sysfs unbind/bind operations.

> +	if (!link) {
> +		XDNA_ERR(xdna, "Failed to link VF %s", pci_name(pdev_vf));
> +		return -EINVAL;
> +	}
> +
> +	XDNA_DBG(xdna, "Linked VF %s", pci_name(pdev_vf));
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006042230.5478=
07-1-yidong.zhang@amd.com?part=3D18
