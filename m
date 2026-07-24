Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB27C53209
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEA910F4A7;
	Fri, 24 Jul 2026 22:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PrfSQoQZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA8710F49D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97F4845124;
 Fri, 24 Jul 2026 22:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0CF1F000E9;
 Fri, 24 Jul 2026 22:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784930529;
 bh=ns2qRIrk7E9QKu5RFrWUtrc58Tz+FAj0Sm00vns3q4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PrfSQoQZKbgMeCMJN8jpbGm3NqX5juMQQWlOicAfK88glNzrCTJ7pU2pzCAIJySQ/
 bCEV8bEL1SEtuzlwybuOqB8PT/O+7f1TLSLByY/748deODtRpbT5FFXg81KC04RZzb
 nJP9FB4JjClS7/ICtpm3vddv3/QA2UIoW5QwEHGclL4ysdNOGhpC9kOLduO8AYX+7Z
 0mM6m9ZO53YIMwJZlmsmU0fUm/1rIdyq62gCFHaExKeYjt9Yld7obfdh2NrFA71lrM
 7nQgLqUpYTrMoPou23u8XJzK2crkCND4as0BIi/NYWcB8HwYC6OiHa6pO5CcKb/KJY
 yjpCbXpXo2OIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] PCI: Make pci_match_one_device() match on ID
 instead of device
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-scsi@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260723-pci_id_fix-v4-7-3580726844e1@garyguo.net>
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260723-pci_id_fix-v4-7-3580726844e1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:02:08 +0000
Message-Id: <20260724220209.1A0CF1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free in PCI device probe due to unprotected dynamic ID p=
ointer.
--

--- Patch [7]: [PATCH v4 7/9] PCI: Make pci_match_one_device() match on ID =
instead of device ---
commit 6e87a7c82585926a2bb69878be8d34b27c58a215
Author: Gary Guo <gary@garyguo.net>

PCI: Make pci_match_one_device() match on ID instead of device

PCI dynamic ID needs to match IDs against a new ID to see if it already
exists. Existing APIs can only match IDs against devices, causing the
dynamic ID insertion code to create a temporary device only for matching
purpose. Rename pci_match_one_device() to pci_match_one_id() so it can be
used for this purpose instead; add a pci_id_from_device() helper to make it
easy to convert users.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1a..c9424edb45481 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -145,10 +162,11 @@ static const struct pci_device_id *pci_match_device=
(struct pci_driver *drv,
>  	if (ret =3D=3D 0)
>  		return NULL;
> =20
> +	dev_id =3D pci_id_from_device(dev);
>  	/* Look at the dynamic ids first, before the static ones */
>  	spin_lock(&drv->dynids.lock);
>  	list_for_each_entry(dynid, &drv->dynids.list, node) {
> -		if (pci_match_one_device(&dynid->id, dev)) {
> +		if (pci_match_one_id(&dynid->id, &dev_id)) {
>  			found_id =3D &dynid->id;
>  			break;
>  		}

[ ... ]

> @@ -158,7 +176,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>  	if (found_id)
>  		return found_id;

[Severity: High]
This isn't a bug introduced by this patch, but could this returned found_id
pointer lead to a use-after-free?

Looking at pci_match_device(), if it matches a dynamic ID, it sets found_id
to &dynid->id and then drops drv->dynids.lock before returning the pointer.

If a concurrent write to the driver's remove_id sysfs attribute occurs,
remove_id_store() will acquire the same lock, remove the dynamic ID from the
list, and free it:

drivers/pci/pci-driver.c:remove_id_store() {
	...
			list_del(&dynid->node);
			kfree(dynid);
			retval =3D count;
			break;
	...
}

Wouldn't the probe path then pass this dangling pointer to the driver's pro=
be
function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-pci_id_fix=
-v4-0-3580726844e1@garyguo.net?part=3D7
