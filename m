Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A1606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0hRLKqR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BF910E3B9;
	Sun,  1 Nov 2026 18:02:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4332010E3B9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F253040788;
 Sun,  1 Nov 2026 18:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED091F000C1;
 Sun,  1 Nov 2026 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793556143;
 bh=I8u/iWJgJctxCUlZMvx8GZD/3SHMvgPnlr62svIrlZY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=g0hRLKqR4q8/ZkUwhtZptigVI/9KM4fBzxvt5OyBnEGEbA/cpq5SAEH0QNZ28iqUL
 xjPoyaOEsNUEh/+XeG1DB2NBqtpus+IKlVKtHuhiNU1GsAFc4mRMD+CqhZtE6v1VHi
 krO/StYCdY6W4WmJb63RIk8IuPm8kkh496G5o5sguyO5PlQJ6QzrMtlxC5xMcKp/Qr
 1ux4b+YmtG7ORNjbylSbihiVLrq++KGi0J3PZojZTGqO2AH3q/YnYnw0+foar6hSWw
 swJmwW+G9GQHCsl2zRFqMZdjCodTfOJJyBD5sEWU6OtG2JNbVHEsHXazJRheGMCz31
 gg+0xg+Jv9mNg==
Message-ID: <sashiko-outbox-192555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 18:02:23 +0000
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
- [Medium] drm/msm: 64-to-32-bit truncation in size_add() in vm_bind_job_lo=
okup_ops()
--

commit 0bb1fc19abe2c004d338802c56cd54e0621aa9a6
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Fix VM_BIND range check

This commit replaces the addition of op->range and op->obj_offset with
size_add() in vm_bind_job_lookup_ops() to guard against integer overflow wh=
en
validating the range against obj->size.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index f687a629629d3..16b3870d5e90e 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job,=
 struct drm_msm_vm_bind *args
>  		op->obj =3D obj;
>  		cnt++;
> =20
> -		if ((op->range + op->obj_offset) > obj->size) {
> +		if (size_add(op->range, op->obj_offset) > obj->size) {

[Severity: Medium]
On 32-bit builds, does passing op->range and op->obj_offset to size_add()
truncate the upper 32 bits of both 64-bit operands before checking for
overflow?

In struct msm_vm_bind_op, obj_offset and range are 64-bit values:

drivers/gpu/drm/msm/msm_gem_vma.c:
struct msm_vm_bind_op {
	...
	uint64_t obj_offset;
	uint64_t iova;
	uint64_t range;
	...
};

However, size_add() in include/linux/overflow.h takes size_t arguments:

static __always_inline size_t __must_check size_add(size_t addend1, size_t =
addend2)

Earlier in lookup_op(), op->obj_offset is only checked with
invalid_alignment(op->obj_offset), which does not reject non-zero upper 32
bits. On 32-bit architectures where size_t is 32 bits wide, an offset such =
as
0x100000000ULL is truncated to 0 when passed to size_add(), allowing an
out-of-bounds 64-bit op->obj_offset or op->range to bypass the obj->size
check in vm_bind_job_lookup_ops() and be stored into vma->gem.offset.

Would check_add_overflow() with a uint64_t sum (or range_overflows_t(u64,
op->obj_offset, op->range, obj->size)) avoid narrowing the operands on 32-b=
it
targets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101174911.2518=
4-1-robin.clark@oss.qualcomm.com?part=3D1
