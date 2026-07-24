Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE00C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0397910F4A0;
	Fri, 24 Jul 2026 22:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SW1jA5Cn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C344510F49A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:02:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD06640534;
 Fri, 24 Jul 2026 22:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C05D1F00A3A;
 Fri, 24 Jul 2026 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930528;
 bh=butDrgyw+h/lIiHxHmoL8ZxppbWZX3+rlT+nnGvSiMc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SW1jA5CnzzM8AHMJBEWjm28GEHl2IrbVpfyBsLGEPMSvCms1A4cNMTdkSb4ApBGcl
 o3b7VLVdWgVaoXeMbXM3ZCGmukwnwKdTZjZWuW5Le7mGRJLCnS6GBLrRhjwI+i9Poa
 RP/3y5F2cFSW2vDOUxuBq3a7z2LhVgkKo9sw03PDik9mYIWBLFg+vRFnj0NMuZ0SW7
 v9HBmpXwsZgxFX+jvyu0TJePHccKl/d1tw0JSXrt7f7F5Bg34DBXzRCPSx3qjkjP4J
 DrImmoBqJKriKA53LH4dKBv3HdsX4UoEytSLmOg+cnClz+rXiZlYKqN4wLFwrU0ANK
 p7kmv2V7NpNzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] PCI: Fix dyn_id add TOCTOU
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, linux-pci@vger.kernel.org, dlemoal@kernel.org,
 dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org
In-Reply-To: <20260723-pci_id_fix-v4-8-3580726844e1@garyguo.net>
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260723-pci_id_fix-v4-8-3580726844e1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:02:07 +0000
Message-Id: <20260724220208.2C05D1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] `pci_match_device()` returns a pointer to the `id` field of a dyna=
mically allocated `struct pci_dynid` after releasing the `drv->dynids.lock`=
 spinlock, which can result in a Use-After-Free in the probe path if the ID=
 is concurrently removed via sysfs.
--

--- Patch [8]: [PATCH v4 8/9] PCI: Fix dyn_id add TOCTOU ---
commit b2b9cd8b65d097234cb7fc1e84df45480eb112de
Author: Gary Guo <gary@garyguo.net>

PCI: Fix dyn_id add TOCTOU

Currently there is a TOCTOU issue in new_id_store() as the dyn ID insertion
in pci_add_dynid() and the pci_match_device() are in separate critical
sections.

Fix this by moving the existing ID check to inside pci_add_dynid() and only
check against the static ID table outside the critical section.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c9424edb45481..ab3bb756ce89a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -153,7 +190,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>  						    struct pci_dev *dev)
>  {
>  	struct pci_dynid *dynid;
> -	const struct pci_device_id *found_id =3D NULL, *ids;
> +	const struct pci_device_id *found_id =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does pci_match_device() have=
 a
use-after-free risk when returning dynamic IDs?

It looks like it returns a pointer to the id field of a dynamically allocat=
ed
struct pci_dynid after releasing the drv->dynids.lock spinlock:

pci_match_device()
    spin_lock(&drv->dynids.lock);
    list_for_each_entry(dynid, &drv->dynids.list, node) {
        if (pci_match_one_id(&dynid->id, &dev_id)) {
            found_id =3D &dynid->id;
            break;
        }
    }
    spin_unlock(&drv->dynids.lock);

    if (found_id)
        return found_id;

If remove_id_store() is triggered via sysfs concurrently, it can acquire
dynids.lock, remove the dynamic ID, and call kfree() on the structure:

remove_id_store()
    list_del(&dynid->node);
    kfree(dynid);

If this happens while __pci_device_probe() has matched the dynamic ID but
hasn't finished executing the driver's probe() routine, could the driver
dereference a freed struct pci_device_id?

__pci_device_probe()
    id =3D pci_match_device(drv, pci_dev);
    if (id)
        error =3D pci_call_probe(drv, pci_dev, id);

>  	struct pci_device_id dev_id;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-pci_id_fix=
-v4-0-3580726844e1@garyguo.net?part=3D8
