Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDEFC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F51710ED22;
	Wed,  5 Aug 2026 07:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sj8QczaZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFEBA10ED22
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:24:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26A0A600AE;
 Wed,  5 Aug 2026 07:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D061F000E9;
 Wed,  5 Aug 2026 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785914653;
 bh=2NXxaqm7n3Eho+pBOAhT7txOQ/YAkq2VedxOO6Djm60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sj8QczaZajc2QQpTsqslDU2P8zS3+/djNLamMT3pqENDpukeMBQEoE5jPn3lVZjB7
 EX9+/wQoHFTsiJTShTUL9Ikl+g379FiQQEJLwzBufJ2twrzJF+ZNf2kEbF/V57A7RP
 ITUkSiQ7kREQ2pz+Rhs7gM/FztCXkHliTFvx+mZVzxgXhUxnAyHb1hkXgTbiQRjNdf
 qNz18oIvQaxRPhFWA2oqBdCUVhctnoP/Br6lcIR0kp+GrUw25R7leVlVpXZAeQCp2N
 kGzulYfWP3DQBo2ZOWEWNtPnjgEyul+naEIyUjPpacS5LK2Mlb/uP0Cy2Zon8CV2ww
 Utl5IxKyQjndw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/4] drm/xe/ras: Use fault-inject to trigger
 cold-reset wedge
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:24:12 +0000
Message-Id: <20260805072413.96D061F000E9@smtp.kernel.org>
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
- [Medium] The fault attribute `wedge_cold_reset` is declared as a global v=
ariable, causing a debugfs dentry memory leak and unintended shared state a=
cross devices.
--

--- Patch [4]: [PATCH v13 4/4] drm/xe/ras: Use fault-inject to trigger cold=
-reset wedge ---
commit c174fc4eba36eef0c9a2a3c15d3daee0c0dbc948
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe/ras: Use fault-inject to trigger cold-reset wedge

Use the fault-inject framework to trigger the cold-reset
wedge path (punit_error_handler()) for testing the
wedge/recovery flow.

> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debu=
gfs.c
> index 8de78cd0aa03b..acd34cc5dcbdb 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -42,6 +42,7 @@
> =20
>  DECLARE_FAULT_ATTR(gt_reset_failure);
>  DECLARE_FAULT_ATTR(inject_csc_hw_error);
> +DECLARE_FAULT_ATTR(wedge_cold_reset);

[Severity: Medium]
Since DECLARE_FAULT_ATTR() expands to a struct without the static keyword,
will this lead to kernel namespace pollution?

Also, because xe_fault_inject_debugfs_register() executes per-device,
will this globally shared attribute cause a debugfs dentry memory leak?

When fault_create_debugfs_attr() is called in the loop for each device:

drivers/gpu/drm/xe/xe_debugfs.c:xe_fault_inject_debugfs_register() {
	...
		fault_create_debugfs_attr(xe_fault_inject_entry[i].name, root,
					  xe_fault_inject_entry[i].attr);
	...
}

Successive calls for multiple GPUs or during driver unbind/bind will overwr=
ite
attr->dname with a newly referenced dentry without dropping the previous
reference.

This also means fault configurations will be shared across all devices rath=
er
than being per-device. While this patch adds a new instance of an anti-patt=
ern
already present in this file for the other attributes, is it possible to av=
oid
propagating it further?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805071152.1225=
416-6-mallesh.koujalagi@intel.com?part=3D4
