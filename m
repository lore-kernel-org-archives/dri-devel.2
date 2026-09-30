Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095C2C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48ABA10F16D;
	Wed, 30 Sep 2026 03:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iuvlszdH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18AD210F16D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:52:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F247C60239;
 Wed, 30 Sep 2026 03:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E53E1F000FF;
 Wed, 30 Sep 2026 03:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740360;
 bh=NDbDsHuFo2NuTtK51XDavLPUb+h9n/WRD9WO7ilkuzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iuvlszdHj9nx9Q/+O1NnOewVHGfz54sgNKGoFpnku6Kcfxpj5zQilnVcZ5y4jJY8V
 jK5/B+NEv7q6bO8tjpWiny691SQs6ocjovjS92qOdNt/4cwnG/I7NJDhs+4/kFryU5
 0ZmkrzqsKD1+0337qdPedrdpYNLzEDvPgKQZPr4L9RJ6f76mGcBVZ0ghIhN8+z9Tgb
 y5XRX0F3xPvZxLCos58N4ZhVfP/SkqlahB1vsgib54rcmQxLYRIuG4djfnME+jPR02
 ds9qIiZosmtHXJez4R+I4nEnVaRkyWsYMFAA7BnJDA0S7GfV+mw0arTuUOHAuzy2Pc
 FyakOPM+dvsFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 09/20] accel/amdxdna: Add context switch hysteresis
 with debugfs control
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-10-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-10-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:52:40 +0000
Message-Id: <20260930035240.7E53E1F000FF@smtp.kernel.org>
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
- [Medium] amdxdna: ignoring timeout in aie4_config_fw() leaves device wedg=
ed
--

commit 22f93820c29f525444ddc497eafd8728678db445
Author: David Zhang <yidong.zhang@amd.com>
accel/amdxdna: Add context switch hysteresis with debugfs control

This commit adds aie4_set_ctx_hysteresis() to configure the AIE4 context
switch hysteresis timeout via the SET_RUNTIME_CONFIG message, and it expose=
s a
debugfs node to change the timeout at runtime.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 95e682a3a4b75..60348ec5bc53b 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
[ ... ]
> @@ -325,6 +327,20 @@ int aie4_restore_power_mode(struct amdxdna_dev_hdl *=
ndev)
>  	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
>  }
> =20
> +static int aie4_config_fw(struct amdxdna_dev_hdl *ndev)
> +{
> +	int ret;
> +
> +	ret =3D aie4_attach_work_buffer(ndev);
> +	if (ret)
> +		return ret;
> +
> +	/* Best-effort tuning knob; failure is warned inside and does not fail =
hw start */
> +	aie4_set_ctx_hysteresis(ndev, ndev->ctx_switch_hysteresis_us);

[Severity: Medium]
Does ignoring the return value of aie4_set_ctx_hysteresis() leave the device
in a wedged state if a timeout occurs?

If the firmware hangs or times out while processing the context hysteresis
configuration message during initialization or resume, aie_send_mgmt_msg_wa=
it()
returns -ETIME and destroys the management channel.

Because aie4_config_fw() explicitly ignores all errors to treat the knob as
"best-effort", initialization will falsely succeed even if the management
channel has been destroyed. This leaves the device silently unusable. Is th=
ere
a way to distinguish between non-fatal errors and fatal timeouts to prevent
the probe from succeeding with a destroyed management channel?

> +
> +	return 0;
> +}
> +
>  static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>  {
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D9
