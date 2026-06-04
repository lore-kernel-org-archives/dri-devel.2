Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E9CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74064113EB5;
	Thu,  4 Jun 2026 10:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFqB4s/L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855E7113EB5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 10:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCD5A601F5;
 Thu,  4 Jun 2026 10:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AE91F00893;
 Thu,  4 Jun 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780567553;
 bh=VdvpBuGEJ9lv4Qyy+SJYDdSX9huYiBnrQuQ6Ugo8xOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JFqB4s/Lwp3ctKDRFen+sbipj/jvSK0qe1CYUl4be7DWj8zpa3Tl1TI6dp05npVeL
 5pU7jDy1lwTPYEiS9qbNf4kNEzAkRN4Wlc9mvKnB3JszfrOHPvAVC+fIQABhgvLsN4
 1GsJQ+doyqaQ6WqoHyrEdfK90UqPf2dUDPKu1aPqtuhItvPqNF9L6YRly8pkvayPjo
 xyTxOkf2oRaLw8SzODiDLNO7X8diSjGTfsXMlw4MnGIBdJMZltgTZVAMTpTmbNb9N2
 QGHQb4UHBnahrJsCnlCgfE8+Q42bA6y846LO2bXKW+AJgI+Y1rObymBVOtIIdfEBb6
 jDgSntTkAhx4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 6/7] drm/xe/vm: Wire MADVISE_AUTORESET notifiers into
 VM lifecycle
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604095012.367231-7-arvind.yadav@intel.com>
References: <20260604095012.367231-7-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:05:53 +0000
Message-Id: <20260604100553.70AE91F00893@smtp.kernel.org>
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
- [High] Unbounded kernel memory leak of `xe_madvise_notifier` structures d=
ue to missing cleanup on VMA unbind.
--

commit 842ee67ad0fcd26bd2723ff015ee6cb68da543ef
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe/vm: Wire MADVISE_AUTORESET notifiers into VM lifecycle

This commit initializes the MADVISE_AUTORESET notifier infrastructure for
fault-mode VMs and handles tear down during VM close. It also collects CPU
mirror VMA ranges to register interval notifiers after dropping the VM lock.

> diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_v=
m_madvise.c
> --- a/drivers/gpu/drm/xe/xe_vm_madvise.c
> +++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
[ ... ]
> @@ -731,6 +806,30 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *fil
>  unlock_vm:
>  	up_write(&vm->lock);
> =20
> +	if (!err) {
> +		for (int i =3D 0; i < num_notifier_ranges; i++) {
> +			int ret =3D xe_vm_madvise_register_notifier_range(vm,
> +							notifier_ranges[i].start,
> +							notifier_ranges[i].end);

[Severity: High]
Does this code leak xe_madvise_notifier structures if the VMA is
subsequently unbound?

When userspace calls the MADVISE ioctl on a CPU mirror VMA,
xe_vm_madvise_register_notifier_range() allocates a new notifier and
adds it to the VM madvise_notifier_list.

However, there does not appear to be a hook in the VMA teardown path,
such as xe_vma_destroy(), to remove notifiers associated with a
destroyed GPU VMA. The notifiers are only freed when the entire VM is
destroyed in xe_vm_madvise_fini(), or if they are fully covered by a
newly registered notifier.

Could a userspace application repeatedly bind a VMA, call the MADVISE
ioctl, and unbind the VMA, shifting the address range slightly each
time, to indefinitely accumulate xe_madvise_notifier objects and mmu
interval notifiers until it triggers an out of memory condition?

> +			if (ret) {
> +				drm_warn(&vm->xe->drm,
> +					 "Failed to register madvise notifier [%#llx-%#llx]: %d\n",
> +					 notifier_ranges[i].start,
> +					 notifier_ranges[i].end, ret);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604095012.3672=
31-1-arvind.yadav@intel.com?part=3D6
