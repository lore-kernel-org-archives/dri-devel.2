Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855A2C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE08310EA34;
	Thu,  3 Sep 2026 23:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jDGDjW96";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEB510E184;
 Thu,  3 Sep 2026 23:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F299560546;
 Thu,  3 Sep 2026 23:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7B71F000E9;
 Thu,  3 Sep 2026 23:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788477745;
 bh=jzhSCXs57A5KBxTPgP1Vyj0TYw5hE+2XzPeTiDEym68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jDGDjW96a11WXDx/Gl8xrH6d5YPuUZqshZiwXVHWm8PGz/voVFY02GLQtEr1bJuxN
 +3j/vejlfUXZJLXU/h21o484yRCZqkkA8w3j65yPqUXp86wfsrT0xPhAPlAJpl7YIm
 iODpIrb9q/jsJnWv1J1UjOqrGaDjy0/iehcEqa13v9LGYsExa7XETfrWhZorUeGzaS
 a0edWQs7Qw5pvtoodzfaY3yzm++imcKuzvjf0s17J+BtcHuA9Clz3h80a1ofJw+R13
 oFNjNg2IWgP/1I6owrPcS9DJ9FDUhI8W0HfdsNODU1KF8hiK//QYDoeVEOR4HpbBFB
 i3MHuBOPMN1XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: Rename xe_vm_fault to drm_xe_vm_fault
To: "Jonathan Cavitt" <jonathan.cavitt@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260903231632.399765-1-jonathan.cavitt@intel.com>
References: <20260903231632.399765-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 23:22:25 +0000
Message-Id: <20260903232225.8E7B71F000E9@smtp.kernel.org>
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
- [High] Renaming the exported UAPI structure `xe_vm_fault` breaks userspac=
e source compatibility.
--

commit 718d9f0d7813c0d7b1b78dab4ab5c1afd1f3f75a
Author: Jonathan Cavitt <jonathan.cavitt@intel.com>

drm/xe: Rename xe_vm_fault to drm_xe_vm_fault

This commit renames xe_vm_fault to drm_xe_vm_fault to better align with
uAPI struct naming conventions.

[ ... ]

> diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> index 8c852abcacf0d..89c0dbe227dd7 100644
> --- a/include/uapi/drm/xe_drm.h
> +++ b/include/uapi/drm/xe_drm.h
> @@ -1271,8 +1271,8 @@ struct drm_xe_vm_bind {
>  	__u64 reserved[2];
>  };
> =20
> -/** struct xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERTY_FA=
ULTS */
> -struct xe_vm_fault {
> +/** struct drm_xe_vm_fault - Describes faults for %DRM_XE_VM_GET_PROPERT=
Y_FAULTS */
> +struct drm_xe_vm_fault {

[Severity: High]
Does renaming this exported UAPI structure break userspace source
compatibility?=20

Userspace applications that rely on struct xe_vm_fault will fail to compile
when updating their kernel headers and attempting to use the old struct
xe_vm_fault name.

Should a backward-compatible alias be provided for the old name?

>  	/** @address: Canonical address of the fault */
>  	__u64 address;
>  	/** @address_precision: Precision of faulted address */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903231632.3997=
65-1-jonathan.cavitt@intel.com?part=3D1
