Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D997CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E7010E282;
	Tue, 23 Jun 2026 21:04:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gpALaymn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE50210E282
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:04:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98E0743B98;
 Tue, 23 Jun 2026 21:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C771F000E9;
 Tue, 23 Jun 2026 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248688;
 bh=nqJ949OhTY0Jp5tKzdS4U6Mkk8mByEbKIopYyxSm0jY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gpALaymnkp5bcYEc3t2QNaqxwIkeGWRnsS1/HT6dTfZ0Ndaw++c2/lK6NvMHYbkwi
 c6wArOl60yxiQwpvrowv4+4HdCLqliQLRtfNQqvb8D0AYT8HfGoYe6rawHoRciFVPo
 CRCw/kMBYiVaqLt5ouC+QLCGsMlzgW/rBk/woT38t4mjeSyTGHz4yeHrJ6bsNPQKMr
 LinAHLyor1+Gk4AVsco++HjGqe3Xm9V+BPAI80XRzwJm4PAdteBhbhS8DBh1TNAdcu
 6gTJyNzFhCQe1FBJw6QoE23VhgxPAhWitc6dpNuMkzHCge7NKGwdaplVT28/ULsdus
 oE7RlIdQ6uuag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622131458.144873-10-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
 <20260622131458.144873-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:04:47 +0000
Message-Id: <20260623210448.60C771F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Directly invoking driver `remove()` and `probe()` callbacks from t=
he PCI error handler bypasses the Linux device model, leading to driver cor=
e state corruption and subsequent crashes.
- [High] WEDGE_STR_LEN buffer size is too small to hold all recovery method=
s, leading to silently truncated uevent strings that userspace cannot parse.
--

commit e0ad0ce6dec9b17be989295e8a1391f07c6154a5
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
scenarios requiring device power cycle. This method addresses cases where o=
ther
recovery mechanisms are insufficient to restore device functionality.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 675675480da49..19c25366635e9 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -535,6 +535,8 @@ static const char *drm_get_wedge_recovery(unsigned in=
t opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";

[Severity: High]
This is a pre-existing issue, but does adding the cold-reset method make the
WEDGE_STR_LEN buffer too small to hold all recovery methods?

Could this lead to silently truncated uevent strings that userspace cannot
parse?

In drm_dev_wedged_event(), the event_string buffer is hardcoded to 32 bytes:

drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event() {
	char event_string[WEDGE_STR_LEN];
	...
	len =3D scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=3D");

	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
		...
		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s,",=
 recovery);
	}

	if (recovery)
		/* Get rid of trailing comma */
		event_string[len - 1] =3D '\0';
	...
}

When formatting multiple methods (e.g. "WEDGED=3Drebind,bus-reset,cold-rese=
t"),
the string length easily exceeds 32 bytes. If scnprintf() hits the buffer l=
imit,
it returns 0 on the last iteration. Decrementing len then chops off the last
valid character of the truncated string, resulting in a corrupted uevent th=
at
breaks userspace parsing.

>  	default:
>  		return NULL;
>  	}

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pc=
i_error.c
> new file mode 100644
> index 0000000000000..b08601f470d63
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
> @@ -0,0 +1,135 @@

[ ... ]

> +static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
> +{
> +	const struct pci_device_id *ent =3D pci_match_id(pdev->driver->id_table=
, pdev);
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);

[ ... ]

> +	xe_device_clear_in_reset(xe);
> +	pdev->driver->remove(pdev);
> +	devres_release_group(&pdev->dev, xe->devres_group_id);
> +
> +	if (pdev->driver->probe(pdev, ent))

[Severity: High]
This isn't a bug introduced by this patch, but does directly invoking the d=
river
remove() and probe() callbacks bypass the Linux device model?

The driver core still considers the device 'bound'. If the manual probe()
fails, it returns PCI_ERS_RESULT_DISCONNECT, causing the PCI core to formal=
ly
unbind the device later.

This invokes xe_pci_remove() on a partially initialized or already
manually-removed state, which could lead to resource double-frees and NULL
pointer dereferences.

> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	xe =3D pdev_to_xe_device(pdev);
> +
> +	/* Wedge the device to prevent I/O operations till the resume callback =
*/
> +	xe_device_wedged_get(xe);
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622131458.1448=
73-8-mallesh.koujalagi@intel.com?part=3D2
