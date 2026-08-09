Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE836C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB9F10E539;
	Sun,  9 Aug 2026 09:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wpvn6dAR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C6810E465
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:12:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A67C42D93;
 Sun,  9 Aug 2026 09:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425D51F000E9;
 Sun,  9 Aug 2026 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786266763;
 bh=PGcfORBvBZl+mlGG48OK0G2O18r3fXCId2BM10JIREE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wpvn6dARn+itVSqdVnvm1/Wbik28SrGfVfgCTeSSXYcrDv7d/9lj9cufQecJB6i50
 cXZBIlSryx3qVH+kWYGl85tsuQI/q3TbTE1wiiQWEzt4a5PxdU2Ey6lH96QIbbY98O
 K///O6vj82jqfQQFCgvQIJa8T4N+MApGQBMMs5Joo3jw9VcCD18+REJzMVHUuPUrVg
 P9I64wzjmIgW07fLML5zqLJZHoNpalX4nCR3mC5B0qA0Fmqm9cF/9HNZh+knqStfdN
 5wUC4OfSiU/TToYIaBgP1plkIp5QCQUB75Wn0FYgOiuLoZv9eJacDQbLJQHE6jZ8Mf
 t0H6k3A9dyHWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809090430.20577-1-kartikey406@gmail.com>
References: <20260809090430.20577-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:12:42 +0000
Message-Id: <20260809091243.425D51F000E9@smtp.kernel.org>
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
- [High] The exact same NULL-pointer dereference vulnerability fixed in `dr=
m/i915` also exists in the sibling driver `drm/xe`.
--

--- Patch [1]: [PATCH] drm/i915: Guard against NULL driver_data in i915_pci=
_probe() ---
commit 88147f0f2fd48d4b9d650095dee423ce2e3c8939
Author: Deepanshu Kartikey <kartikey406@gmail.com>

drm/i915: Guard against NULL driver_data in i915_pci_probe()

This commit fixes a NULL pointer dereference in i915_pci_probe() when a
device is force-bound via sysfs driver_override, which results in a NULL
driver_data being returned by pci_match_device().

Link: https://syzkaller.appspot.com/bug?extid=3Ddb96c5ff032f4292a8dc

> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_=
pci.c
> index 82415af47d540..2f03f95945f1b 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  		(struct intel_device_info *) ent->driver_data;
>  	int err;
> =20
> +	if (!intel_info)
> +		return -ENODEV;

[Severity: High]
This is a pre-existing issue, but does the exact same vulnerability exist in
the sibling drm/xe driver?

When a device is force-bound via the sysfs driver_override interface,
xe_pci_probe() in drivers/gpu/drm/xe/xe_pci.c will also receive a dummy
entry where ent->driver_data is NULL. This is cast to desc and passed
directly to find_subplatform():

drivers/gpu/drm/xe/xe_pci.c:xe_pci_probe() {
    ...
    const struct xe_device_desc *desc =3D (const void *)ent->driver_data;
    ...
    subplatform_desc =3D find_subplatform(desc, pdev->device);
    ...
}

Inside find_subplatform(), this pointer is unconditionally dereferenced:

drivers/gpu/drm/xe/xe_pci.c:find_subplatform() {
    ...
    for (sp =3D desc->subplatforms; sp && sp->subplatform; sp++)
    ...
}

Should a similar guard be added to xe_pci_probe() to prevent a kernel
panic there as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809090430.2057=
7-1-kartikey406@gmail.com?part=3D1
