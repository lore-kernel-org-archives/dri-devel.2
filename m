Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5fNXjRu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADF0112D58;
	Fri, 27 Nov 2026 19:53:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06719112D58
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:53:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FBE560092;
 Fri, 27 Nov 2026 19:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5B1F000C1;
 Fri, 27 Nov 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795809198;
 bh=q1Czqzlq/FYipl3XaL9TsDPcEWs7nvEe5k1aymso+dc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T5fNXjRuYcxJaY7nD07Ek9iTvJaG4p2NVED2DD0PFhXJvmu1rz9v1+AE4TPDGFPuF
 3Cgfz55Iw75VVpmdgcPJFvEXkJYXA/Psrwi78y1xMVisnL1dNox/2TzQW9O3Kjt4a1
 GmXIGQEO3wyODKi6CTnTaW7R7qMLZbaF93mkrfGupL3Q/vwHvycm+S7Xr0JwwLJ2sM
 otvK2XOzDvOmq3m/fXvPqq0hNT7Ae/4OXhZg2JZajm4MNeeRd43I8RIwGXx543Ow7h
 S19boGqpmDdLLMwM9gwRnGq+AEHpDWnpkX+NTibKAJvt5fAQXhyHPvvHzGInXusuJj
 9xV/KbU5Hz/kg==
Message-ID: <sashiko-outbox-238185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] drm/msm/mdp5: unwind a failed mdp5_kms_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-7-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
 <20261127-msm-kms-destroy-fixes-v4-7-242b0a3f8e47@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 19:53:18 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/mdp5: inaccurate Fixes trailer in mdp5_kms_init() unwind
  commit
--

commit 9e7e45efa8a5a51745ca779b3100de8c25d89be0
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> drm/msm/mdp5: unwind a failed mdp5_kms_init()
>
> mdp5_kms_init() returns straight away when one of its later steps fails,
> leaving behind the kms, the runtime PM reference taken around the address
> space setup and the address space itself, and lets the ->destroy()
> callback, which the caller runs afterwards, clean up. When mdp5_init()
> fails, however, it has already run mdp5_destroy() itself, and ->destroy()
> runs it a second time: the global state object is finalised twice.
>
> Undo the steps which have completed, in the reverse order, drop the
> runtime PM reference on the error path as well, and tell the caller not
> to run ->destroy() after a failed init. Fold the hardware setup, which
> can't fail, into mdp5_kms_init().
>
> Fixes: 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic =
object")
> Assisted-by: LLM
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[Severity: Low]
Is the Fixes tag pointing at the right commit?

At 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic
object"), mdp5_init() was called from mdp5_bind() rather than
mdp5_kms_init(), mdp5_destroy() was called from mdp5_unbind() rather than
mdp5_kms_destroy(), and mdp5_kms_init() unwound on failure via its own
fail label instead of returning early.

Calling mdp5_init() from mdp5_kms_init() and mdp5_destroy() from
mdp5_kms_destroy() was introduced in 6874f48bb8b0 ("drm/msm: make mdp5/dpu
devices master components"), while returning early from mdp5_kms_init() to
rely on the caller's ->destroy() callback was introduced in 93c125e4ea98
("drm/msm: don't tear down KMS twice when KMS init fails").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-msm-kms-de=
stroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com?part=3D7
