Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA74C44501
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0A010E5DA;
	Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W+FCDf/j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DC310E5D2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C0C340A2E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B31F00A3A;
 Fri,  3 Jul 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080166;
 bh=Ga8fxkmhVtRysrwAHQuEqU/NB1rFvG105KjQ/9gD+Z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W+FCDf/jePnfMYIOOTMKRWiu4B+w5aVNEXS94fdEfgkrnFz6WBG4lOEsPrQ5dCQQs
 pFfCmSZKvUPCaRMQo2m1m7JdVJj54biOt9LhfxmntKml5ysLswa6mNdNnpDPi75nY7
 ByPmQOEsKT2/b/Ed/AoECsPIES9etKt3iEqaCIFooG+YDf/9KcrYwsO/gaH/2ll/au
 BEIfVwFOg5J4EFW6RUN/nAh98joPErDRMKNPEGN23KVR7sNfUCQ63RyFWOqY1Ge08c
 i2nIXLDFdwzg71p4e0LTaDGB9i5Z3jX7mr/iINxnu5nvTla/fZFt6tHMUOTX4Pdfo9
 qiJlLFZct7W3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/14] firmware: qcom: Add a generic PAS service
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260702115835.167602-2-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:45 +0000
Message-Id: <20260703120245.EF0B31F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] TOCTOU data race and missing memory barriers in PAS wrapper functi=
ons.
- [High] Check-then-set race condition in qcom_pas_ops_register() allows co=
ncurrent overwrites and unsafe reads.
- [High] Missing module lifecycle management and reference counting for the=
 PAS backend provider.
- [Medium] Resource leak when calling qcom_pas_metadata_release after provi=
der unregistration.
- [Medium] Missing NULL pointer validation for mandatory ops callbacks befo=
re execution.
--

Note: This review is provided in a free-form summary format without direct
patch quotes due to system recitation restrictions.

[Severity: High]
In wrapper functions like qcom_pas_init_image() and qcom_pas_get_rsc_table(=
),
the code checks if ops_ptr is NULL using a plain load, and then subsequently
dereferences ops_ptr to call the provider.

Since these loads are not protected by a mechanism to fetch into a local
variable, could the compiler fetch the pointer multiple times from memory?
If the provider module is unloaded concurrently, might ops_ptr become NULL
between the check and the dereference, leading to a crash?

[Severity: High]
Looking at qcom_pas_ops_register(), there appears to be a check-then-set ra=
ce
condition. If two threads call this simultaneously, both might check the
availability, see NULL, and both perform the store release, allowing
concurrent registrations to overwrite each other.

Additionally, in the error path for this function, it directly reads the
driver name from ops_ptr. If qcom_pas_ops_unregister() is called concurrent=
ly,
could this pointer become NULL and cause a crash when printing the error?

[Severity: High]
The qcom_pas_ops structure lacks a module owner field for lifecycle
management.

When wrapper functions like qcom_pas_auth_and_reset() invoke these callback=
s,
they do not appear to pin the provider module in memory using a reference
count. If the backend provider module is unloaded while its callbacks are
actively executing, will the kernel jump to unmapped memory?

[Severity: Medium]
In qcom_pas_metadata_release(), there is an early return if the operations
pointer is NULL.

If the backend provider is unregistered before the client releases its cont=
ext,
this bypasses the metadata release callback entirely. Does this early return
permanently leak resources, such as DMA mappings or shared memory, that were
allocated by the client during initialization?

[Severity: Medium]
Wrapper functions like qcom_pas_shutdown() directly execute callbacks from =
the
operations pointer without verifying if the specific function pointer is
populated.

If a registered backend provider fails to populate all mandatory callback
function pointers during registration, could this lead to a NULL pointer
dereference when the wrapper attempts to execute them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D1
