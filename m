Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EA606AC38
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gS5IizAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B6610FF59;
	Wed,  4 Nov 2026 22:28:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E635010FF59
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:28:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CBA0605D5;
 Wed,  4 Nov 2026 22:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C481E1F00A15;
 Wed,  4 Nov 2026 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793831285;
 bh=ohirIelHqElOa8ggCr7EsFuUn7UCFOqbdDVKJ0Hdu5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gS5IizAtF4Btw06etoNyiD4/OoplUWDUrAy9R2haWQEIZz3gv1K8L86rinaRCbEEW
 mRnnJ5y5ATerJWFwsiha7Jvx7uTdh3hF2FiHQqmwQX+VWWW9riXwOd8ObxrQP4kKgC
 lAlK3Jj92lZysdMj47TrAorWQBkTMsYUVcaj2P1lqWoaLDmKVUc2fZv8KXuZficxLM
 CVUiiDQdLzie1yRiIoDaI5B86HFlui00mOI2qI8x6JcRYlzgkbzOnjj+MNrcJEelCT
 ZSy1Rl5niaMfNDEapjOsdpBb2sIoH5+G4KxT0yyTof0dwiXcZR24vijjnq+EU/CKeg
 Ulxh0wRiCynOg==
Message-ID: <sashiko-outbox-198222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Load the aie4 firmware variant the PSP
 reports
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261104-superm1-lms-npu-v1-1-dbffcc5abc23@amd.com>
References: <20261104-superm1-lms-npu-v1-1-dbffcc5abc23@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:28:04 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] accel/amdxdna: uninitialized read in aie4_psp_fw_variant() on SM=
N failure
--

commit 8b85be20f84a0e02e0435160129ed37c6585968f
Author: Mario Limonciello <mario.limonciello@amd.com>

accel/amdxdna: Load the aie4 firmware variant the PSP reports

This commit reads PSP C2PMSG_63 over SMN to determine whether an AIE4 NPU
requires default, alternative ("_l"), or preproduction ("_p") signed
firmware, and adds MODULE_FIRMWARE() entries for the "_l" images.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 02dcb2f813d45..fa8f99d1be361 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c

[ ... ]

> @@ -558,46 +560,128 @@ static void aie4_classic_hw_stop(struct amdxdna_de=
v_hdl *ndev)
>  	aie4_fw_stop(ndev);
>  }
> =20
> -static int aie4_request_firmware(struct amdxdna_dev_hdl *ndev,
> -				 const struct firmware **npufw,
> -				 const struct firmware **certfw)
> +/*
> + * PSP C2PMSG_63 (SMN) bit 6: 0 =3D default firmware signing, 1 =3D alte=
rnative
> + * PSP C2PMSG_63 (SMN) bit 28: 0 =3D production part, 1 =3D preproductio=
n part
> + */
> +#define AIE4_PSP_C2PMSG_63_SMN_ADDR	0x38109fc
> +#define AIE4_PSP_FW_SIGN_ALT		BIT(6)
> +#define AIE4_PSP_FW_PREPROD		BIT(28)
> +
> +enum aie4_fw_variant {
> +	AIE4_FW_DEFAULT,
> +	AIE4_FW_ALT,		/* "_l" images */
> +	AIE4_FW_PREPROD,	/* "_p" images */
> +};
> +
> +/*
> + * The PSP only trusts firmware signed with the scheme the platform firm=
ware
> + * uses and a preproduction part needs firmware of its own. Reading whic=
h one is
> + * in use is optional and only used as a hint for which images to try fi=
rst:
> + * anything but a clear answer is treated as default.
> + */
> +static enum aie4_fw_variant aie4_psp_fw_variant(struct amdxdna_dev *xdna)
>  {
> -	struct amdxdna_dev *xdna =3D ndev->aie.xdna;
> -	struct pci_dev *pdev =3D to_pci_dev(xdna->ddev.dev);
> -	char fw_name[128];
> +	u32 val;
>  	int ret;
> =20
> -	ret =3D snprintf(fw_name, sizeof(fw_name), "amdnpu/%04x_%02x/%s",
> -		       pdev->device, pdev->revision, ndev->priv->npufw_path);
> -	if (ret >=3D sizeof(fw_name)) {
> -		XDNA_ERR(xdna, "npu firmware path is truncated");
> -		return -EINVAL;
> +	ret =3D amd_smn_read(0, AIE4_PSP_C2PMSG_63_SMN_ADDR, &val);
> +	if (ret) {
> +		XDNA_DBG(xdna, "PSP firmware variant not available, ret %d", ret);
> +		return AIE4_FW_DEFAULT;
>  	}

[ ... ]

> @@ -645,18 +729,40 @@ static int aie4_prepare_firmware(struct amdxdna_dev=
_hdl *ndev,
>  	return 0;
>  }
> =20
> +/*
> + * The firmware can only be started once. It is the PSP that decides whe=
ther it
> + * accepts the images, and it does that when the firmware is started, so=
 there
> + * is no trying a variant and falling back. Pick the variant that the PSP
> + * reported (the default one if it can't be read) and use the others onl=
y if
> + * its images are missing.
> + */
>  static int aie4_load_fw(struct amdxdna_dev_hdl *ndev,
>  			void __iomem *tbl[PCI_NUM_RESOURCES])
>  {
> +	struct amdxdna_dev *xdna =3D ndev->aie.xdna;
> +	enum aie4_fw_variant hint =3D aie4_psp_fw_variant(xdna);
>  	const struct firmware *npufw, *certfw;
> -	int ret;
> +	enum aie4_fw_variant order[3];
> +	int i, n =3D 0, ret =3D -ENOENT;
> =20
>  	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
>  		return 0;

[Severity: Medium]
Can calling aie4_psp_fw_variant() here read uninitialized stack memory when
amd_smn_read() fails early?

In aie4_psp_fw_variant(), val is declared uninitialized on the stack and
passed to amd_smn_read(). In arch/x86/kernel/amd_node.c:amd_smn_read(),
*value is unconditionally inspected even when __amd_smn_rw() returns an
error before pci_read_config_dword() writes to *value:

arch/x86/kernel/amd_node.c:amd_smn_read() {
	int err =3D __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address,=
 value, false);

	if (PCI_POSSIBLE_ERROR(*value)) {
		err =3D -ENODEV;
		*value =3D 0;
	}

	return err;
}

When __amd_smn_rw() returns early with -ENODEV (for example when !amd_roots
in a guest VM, or when pci_request_config_region_exclusive() failed during
amd_smn_init()), PCI_POSSIBLE_ERROR(*value) reads the uninitialized stack
variable val.

Additionally, because aie4_load_fw() calls aie4_psp_fw_variant(xdna) in its
variable declarations before checking:

	if (!ndev->priv->npufw_path && !ndev->priv->certfw_path)
		return 0;

probing a VF device (aie4_vf_init() -> aie4m_pcidev_init() -> aie4_load_fw(=
),
where npu3_dev_vf_priv has both paths set to NULL) will always perform this
SMN read and hit the uninitialized read in a guest VM before immediately
returning 0.

Should val be initialized in aie4_psp_fw_variant() (e.g., u32 val =3D 0;), =
and
should the aie4_psp_fw_variant(xdna) call in aie4_load_fw() be moved after
the npufw_path/certfw_path check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-superm1-lm=
s-npu-v1-1-dbffcc5abc23@amd.com?part=3D1
