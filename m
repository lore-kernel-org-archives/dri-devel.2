Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F102FC5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C81D10E40B;
	Tue, 18 Aug 2026 00:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbzu3V6p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5775A10E40B
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:11:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0C7143909;
 Tue, 18 Aug 2026 00:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A704E1F000E9;
 Tue, 18 Aug 2026 00:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787011916;
 bh=F9MU1XzeAfO9qXYv/kHS3JAQXN92rH94cpFgtfuk4ZA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hbzu3V6pIEf3DA3y8EVm2fkpY3a9SW3uEMXKH1B5KDTplWFGZWNcKUWKpo3I9Gydr
 oeU8UC4z6BFbH+qTWzhRhA2rS87j2NQSghSQq67PC1YgwR6AUrXakbPNhCeGoMSpKt
 pjQ/kAfriBcl/3gZLplUhwffAqtpVHWekVuKR6Tvo3qM0kcyurCcotKHF2qFj6TcFv
 4gKBK3N9jMvkw+RHqncHLT4KzLDvLfcZJGCFQ6R9wJgNMIvxWNKTmr13ThWeMSMNcm
 Y4tzS5emFm62KjTqIyySIlD/nksC5TFzgr7meJTIX/x4wWODgxLJhT9xlWEqs8rk1l
 OXV2k6hlsjEuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: reject a command chain that carries no
 commands
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818000019.369366-1-taimuraz@kaitmazov.com>
References: <20260818000019.369366-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 00:11:56 +0000
Message-Id: <20260818001156.A704E1F000E9@smtp.kernel.org>
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
- [Critical] Local Denial of Service (DoS) via zero-size buffer in AMDXDNA_=
SYNC_BO ioctl.
- [Critical] Missing NULL pointer check after `amdxdna_cmd_get_payload()` l=
eads to uninitialized variable use and NULL pointer dereference.
--

--- Patch [1]: [PATCH] accel/amdxdna: reject a command chain that carries n=
o commands ---
commit 28fe797436c130cd969581d26479f7eb0ffdc5a9
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: reject a command chain that carries no commands

A chain whose command_count is zero passes the payload length check,
because struct_size(payload, data, 0) is just the header. The fill loop
then does not run, so offset stays zero and the request is submitted with
a zero-length buffer.

[ ... ]

> drm_clflush_virt_range() faulting on an empty range is a core problem, an=
d a
> patch for it is on the list separately. This rejects the request in the d=
river
> regardless, since a chain carrying no commands is not something to submit.

[Severity: Critical]
This isn't a bug introduced by this patch, but since
drm_clflush_virt_range() faulting on a zero-size range is known to cause a
kernel panic, is there another path that might trigger this before the core
fix lands?

Userspace can create a non-DEV BO (e.g., AMDXDNA_BO_SHMEM) and call the
AMDXDNA_SYNC_BO ioctl with size =3D 0. The ioctl handler lacks a zero-size
check and passes the unmodified user input:

amdxdna_drm_sync_bo_ioctl() {
    ...
    ret =3D amdxdna_flush_bo(abo, args->offset, args->size);
    ...
}

amdxdna_flush_bo() {
    ...
    drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
}

Could this allow an unprivileged user to bypass the driver fix here and
trigger the vmap guard page fault anyway?

> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna=
/aie2_message.c
> index dfe0fbdf066d2..b4c49259a1a23 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -994,7 +994,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *=
hwctx,
>  	}
> =20
>  	ccnt =3D payload->command_count;
> -	if (payload_len < struct_size(payload, data, ccnt)) {
> +	if (!ccnt || payload_len < struct_size(payload, data, ccnt)) {

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at payload
validation here, are there missing NULL checks for
amdxdna_cmd_get_payload() in other parsers?

In aie2_cmdlist_multi_execbuf() above this code, there is a check:

aie2_cmdlist_multi_execbuf() {
    ...
    payload =3D amdxdna_cmd_get_payload(cmd_abo, &payload_len);
    if (!payload) {
        ...
}

But other payload parsing functions like aie2_cmdlist_fill_npu_cf() and
aie2_init_exec_cu_req() appear to lack this check:

aie2_cmdlist_fill_npu_cf() {
    ...
    cmd =3D amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
    if (*size < sizeof(*npu_slot) + cmd_len)
        return -EINVAL;
    ...
    memcpy(npu_slot->args, cmd, cmd_len);
}

If amdxdna_gem_vmap() fails under memory pressure and returns NULL,
amdxdna_cmd_get_payload() will return NULL and leave cmd_len uninitialized.
Could this lead to an uninitialized size check and subsequent NULL pointer
dereference in memcpy()?

>  		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818000019.3693=
66-1-taimuraz@kaitmazov.com?part=3D1
