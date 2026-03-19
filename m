Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EA9108E1E6
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF0C10E97E;
	Thu, 19 Mar 2026 10:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="A3nIf4FY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7980510E97C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773917261;
 bh=Q2V+J6EwuA5u40zekUlt1HFuApT5hDOouTQDHv3fRCo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=A3nIf4FYzYbvHsinBL7MZ+eBFmllnso8oTkkFcCbSc0y8b2chhJUtJUwqklJFwdM6
 PLS0KzFmZhdFSxvLbNhicm7G6lL910/lyq7Ta/hrSyXF++qoiJpviE+j2RKvFlHFpO
 kx2Fe4FDxUBDMvBJvT2C/SEwwtQCvHHKEI8cl1UWssYsRMnNNgXBMJd/V8Z61tVh0X
 2OuFfT1aOw+H1+ayogpjfgWWY6WV+kkyDy/eHooYd8LtwHXnAYDrPfHtbNg64c53UD
 p8EE6lCyDP0ycLDvDad60Dud4MnA1vm6AVrX8Iu3XuZqBWcTCzZ2xpM3dc3u0lE1FB
 e/VapRIlh6sJA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8EC0717E0610;
 Thu, 19 Mar 2026 11:47:40 +0100 (CET)
Date: Thu, 19 Mar 2026 11:47:36 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Deborah
 Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v1 RESEND 1/4] drm/tyr: clear reset IRQ before soft reset
Message-ID: <20260319114736.64c3b4fa@fedora>
In-Reply-To: <20260313091646.16938-2-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-2-work@onurozkan.dev>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 13 Mar 2026 12:16:41 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> Clear RESET_COMPLETED before writing GPU_CMD_SOFT_RESET.
>=20
> This is also used in
> drivers/gpu/drm/panfrost/panfrost_gpu.c::panfrost_gpu_soft_reset
> and avoids seeing old reset-complete status from a previous reset.
>=20
> Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/driver.rs | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 69eff2a9e116..f7951804e4e0 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -91,6 +91,8 @@ unsafe impl Send for TyrDrmDeviceData {}
>  unsafe impl Sync for TyrDrmDeviceData {}
> =20
>  fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Resul=
t {
> +    // Clear any stale reset-complete IRQ state before issuing a new sof=
t reset.
> +    regs::GPU_IRQ_CLEAR.write(dev, iomem, regs::GPU_IRQ_RAWSTAT_RESET_CO=
MPLETED)?;
>      regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> =20
>      poll::read_poll_timeout(

