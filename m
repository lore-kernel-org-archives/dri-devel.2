Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946360AE2FF
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wo7mk//0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D99710E395;
	Mon, 19 Oct 2026 15:24:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42BB10E395
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 935A641456
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E098B1F000C4;
 Mon, 19 Oct 2026 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792423458;
 bh=VgbToEtOYeO/sr49EhpueSYJlgPoGcw2HjT5lRp6gro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wo7mk//0s+5o68hnPjjpx89h95/hqpMLzPvxHqNMYLMDkxruOqpPZ/OVKBAmJUxDZ
 6kJs37GlkcfF1b4o7N5087cOxxfLR3VCkbN5pYz1zxc3V9sAQdx7pyNxtb9ooSmw/X
 vC798sv3x5QVaSBwwZSig6V0eJHo1YQdBEBYt6DN2EaxLxExdj/2FaPpcT0OheuhgH
 +bGpnFQZFZ/t3t/CDWQn2g2eAagYEIGk5TxR5gv+TJ+ZHAqFVwIhIyc5DHN0PcG/o+
 JxBHBytSaEcBzAOK9bHqunzQ1LoapwEtmJMl07bX+Hbr5t3ouktj1egHMeIa3ep6Vq
 NA2Lc3ozd08BQ==
Message-ID: <sashiko-outbox-177707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] drm/amdgpu: Guard reads in pcie state
 readout
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-466-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-466-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:24:17 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdgpu: uninitialized pcie_regs fields in aqua_vanjaram_read_p=
cie_state()
--

commit c0c47257f13eed1e55050aec0ca9d8906dd7cf73
Author: Lijo Lazar <lijo.lazar@amd.com>

drm/amdgpu: Guard reads in pcie state readout

This commit introduces a helper to verify and retrieve the GPU's internal
upstream switch port and guards the upstream port PCIe configuration reads =
in
aqua_vanjaram_read_pcie_state() to avoid a NULL pointer dereference in
passthrough environments.

> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm=
/amd/amdgpu/aqua_vanjaram.c
> index f9e2edf5260bc..4529627d13c5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c

[ ... ]

> @@ -650,25 +673,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct=
 amdgpu_device *adev,
>  		}
>  	}
> =20
> -	ds_pdev =3D pci_upstream_bridge(adev->pdev);
> -	us_pdev =3D pci_upstream_bridge(ds_pdev);
> +	us_pdev =3D aqua_vanjaram_get_us_pdev(adev);
> +	if (us_pdev) {
> +		pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> +					  &pcie_regs->device_status);
> +		pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> +					  &pcie_regs->link_status);
> +
> +		aer_cap =3D pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> +		if (aer_cap) {
> +			pci_read_config_dword(us_pdev,
> +					      aer_cap + PCI_ERR_COR_STATUS,
> +					      &pcie_regs->pcie_corr_err_status);
> +			pci_read_config_dword(us_pdev,
> +					      aer_cap + PCI_ERR_UNCOR_STATUS,
> +					      &pcie_regs->pcie_uncorr_err_status);
> +		}
> =20
> -	pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> -				  &pcie_regs->device_status);
> -	pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> -				  &pcie_regs->link_status);
> -
> -	aer_cap =3D pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> -	if (aer_cap) {
> -		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_COR_STATUS,
> -				      &pcie_regs->pcie_corr_err_status);
> -		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
> -				      &pcie_regs->pcie_uncorr_err_status);
> +		pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> +				      &pcie_regs->sub_bus_number_latency);
>  	}

[Severity: High]
When aqua_vanjaram_get_us_pdev(adev) returns NULL (or when aer_cap is 0), do
these skipped fields in pcie_regs leak uninitialized kernel heap memory to
userspace?

When userspace reads the world-readable (0444) reg_state sysfs binary
attribute at offset AMDGPU_SYS_REG_STATE_PCIE, the buffer is allocated with
kmalloc() without __GFP_ZERO and passed down without being zeroed:

kernfs_file_read_iter()
  buf =3D kmalloc(len, GFP_KERNEL);
  sysfs_kf_bin_read()
    amdgpu_sysfs_reg_state_get()
      amdgpu_asic_get_reg_state()
        aqua_vanjaram_get_reg_state()
          aqua_vanjaram_read_pcie_state()

Previously, pcie_regs->device_status, pcie_regs->link_status, and
pcie_regs->sub_bus_number_latency were unconditionally written. With this
change, when us_pdev is NULL, those fields along with
pcie_regs->pcie_corr_err_status and pcie_regs->pcie_uncorr_err_status are
left completely uninitialized in buf while pcie_regs->inst_header.state is
set to AMDGPU_INST_S_OK, and kernfs_file_read_iter() copies szbuf bytes back
to userspace via copy_to_iter().

Should these fields (or pcie_regs) be zero-initialized before populating the
state?

> =20
> -	pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> -			      &pcie_regs->sub_bus_number_latency);
> -
>  	pcie_reg_state->common_header.structure_size =3D szbuf;
>  	pcie_reg_state->common_header.format_revision =3D 1;
>  	pcie_reg_state->common_header.content_revision =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-466-sashal@kernel.org?part=3D1
