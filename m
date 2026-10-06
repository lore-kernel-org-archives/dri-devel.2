Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B07CCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991D610F039;
	Tue,  6 Oct 2026 04:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="euGI0ySc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADC510F038
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:35:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14DA5406A6;
 Tue,  6 Oct 2026 04:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EE91F000FF;
 Tue,  6 Oct 2026 04:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791261325;
 bh=0yj6jEEjeTdozq2tPWLTyYlfzzb4v+wI4teanG5rvK4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=euGI0yScRh5UsoXIf9sisPvudrthqqqD/EiWn2PeinLBEMSTXWIoEeiFnQtkliZUa
 gneGJwJzBy95zNQ+030Pm1gs7dTAGnAFfXRPM+vnUnQnPtAmh3mSRv4b2JjdNjZtQd
 ljvxCJ04V/sbEqwdh/4/jSypBeRCrRUtsyexejYAvHACXXR/9EMez+D7/1dde9d1Tz
 exc6Z8lQDnMnbV3uGcdCS8AqotUOHbBy0RkKNLvcQnbPUjb3ZwkGJT7rCrSEARcd+P
 1G6G21Eyi06E2rFO2/W523Cj6XkmIY8r7SsAkDtIgeVlYPGJgr6+18G+KMDhGg2zD1
 dZayNWVueNhiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 09/20] accel/amdxdna: Add context switch hysteresis
 with debugfs control
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006042230.547807-10-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
 <20261006042230.547807-10-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 04:35:24 +0000
Message-Id: <20261006043524.C1EE91F000FF@smtp.kernel.org>
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
- [Medium] amdxdna: unaligned memory access in aie4_set_runtime_cfg()
--

commit 1c7fe2fcd8c5df7169f8d7c14de7898318de0123
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add context switch hysteresis with debugfs control

This commit adds aie4_set_ctx_hysteresis() to configure the AIE4 context
switch hysteresis timeout. It also exposes a debugfs node to change the
timeout at runtime.

> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna=
/aie4_message.c
> index 7112b0bc3725a..5720aa88e6d6d 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
[ ... ]
> @@ -262,3 +262,46 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *=
ndev, u8 power_mode)
> =20
>  	return ret;
>  }
> +
> +int aie4_set_runtime_cfg(struct amdxdna_dev_hdl *ndev, u32 type,
> +			 const void *data, size_t size)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_set_runtime_cfg, AIE4_MSG_OP_SET_RUNTIME_CONFI=
G);
> +	u8 buf[sizeof(req.type) + AIE4_RUNTIME_CFG_MAX_DATA_SIZE] =3D { 0 };

[Severity: Medium]
Could this lead to unaligned memory access? The payload buffer is declared =
as
a byte array with no alignment guarantees, meaning its start address on the
stack might not be 4-byte aligned.

Later in this function, buf is assigned to msg.send_data and passed to
aie_send_mgmt_msg_wait(). When the mailbox code processes this message, it
does:

drivers/accel/amdxdna/amdxdna_mailbox.c:xdna_mailbox_send_msg() {
    ...
    if (unlikely(((u32 *)msg->send_data)[0] =3D=3D TOMBSTONE)) {
    ...
}

Dereferencing a potentially unaligned pointer via a u32 pointer cast is
undefined behavior. While x86_64 hardware typically handles unaligned reads
gracefully, the compiler is permitted to optimize assuming the pointer is
strictly 4-byte aligned, which can lead to miscompilation. Furthermore, this
will trigger Undefined Behavior Sanitizer (UBSAN) warnings during runtime
testing.

Could the buffer be aligned, perhaps by using __aligned(4) or an appropriat=
ely
typed struct?

> +	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006042230.5478=
07-1-yidong.zhang@amd.com?part=3D9
