Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C232606A337
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARjkArxl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CED89089;
	Fri,  6 Nov 2026 09:28:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5A489089
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:28:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73B34605F7;
 Fri,  6 Nov 2026 09:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C8D1F008A3;
 Fri,  6 Nov 2026 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793957322;
 bh=MHWLEU9IIW6QCMwemLXFtR4JzSabIthBx8TiRKO8TMU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ARjkArxlPVWQclXbgvImZ9YOOr/252JNvy3JjT+MIi45Vwhh4VwG1EJG6MIwXx5d2
 2JsSc+H42PfUvpSbRfR3UvHqYU0JvDz42Z9jdmAVuTgnCc7jeFxjbsyDWVCMSlWitV
 g7mpx5SWABP1FRC72RC6AVxpUhBtEDQpYQ+3hWsqAz4h1INY/1BcMlD8RrevHCF+R8
 6FE2urxOfLGZdmNx4TJJH7oTYRQiL1M6//Nz4sMqsfWHjutzIMD7uivrW4VgL9vHdZ
 7cKsj/I1HBt0ddXOF1ea/NOAPF4a3CRyUhssVAuyI4+E8KgWUga6ob/qdmS0H7nb3M
 Vre1RFPRn769g==
Message-ID: <sashiko-outbox-201108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
To: "Chengyu Liu" <lui2012qwq@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104095159.6487-1-lui2012qwq@gmail.com>
References: <20261103163354.1599176-1-lui2012qwq@gmail.com>
 <20261104095159.6487-1-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:28:41 +0000
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
- [Low] accel/habanalabs: missing Fixes trailer for hl_device_fini()
  reset work fix
--

commit e560ec133709db78ecf2c5f01a23a035c9ef7ca3
Author: Chengyu Liu <lui2012qwq@gmail.com>

> accel/habanalabs: disable pending-reset work in hl_device_fini()
>
> hl_device_fini() uses flush_delayed_work() to drain
> device_reset_work.reset_work, but a flush cannot stop the work from
> being armed again afterwards, so the reset work can still fire while -
> or after - the device is torn down.
>
> Simply switching the flush to disable_delayed_work_sync() is not
> enough: a reset retry sitting on its timer holds reset_info.in_reset,
> and only the work itself clears it (via out_err once
> device_fini_pending is set).  Killing the work without running it
> strands in_reset, and hl_device_fini() then waits for the full
> HL_HARD_RESET_MAX_TIMEOUT and returns without tearing the device
> down.
>
> So keep the flush first: with device_fini_pending set, a pending
> retry runs immediately and clears in_reset via out_err.  Then, after
> in_reset has been claimed for fini - so no new reset can be queued
> and the reset thread does not re-arm - disable the work to guarantee
> nothing is pending or running during the teardown.
>
> Found by static analysis.
>
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>

[Severity: Low]
This fixes the incomplete draining of device_reset_work.reset_work in
hl_device_fini().  Should this include:

  Fixes: adb51298fdc4 ("habanalabs: improve hard reset procedure")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104095159.6487=
-1-lui2012qwq@gmail.com?part=3D1
