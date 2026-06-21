Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBA2CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 12:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C25D10E389;
	Sun, 21 Jun 2026 12:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ej4GDNKp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCCE10E389;
 Sun, 21 Jun 2026 12:58:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A93356008A;
 Sun, 21 Jun 2026 12:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201171F000E9;
 Sun, 21 Jun 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782046680;
 bh=dwyyFF+yPpoJif6/OWI2GLmuQ0czkd3E3lwUANbsdlU=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=ej4GDNKp63e4A8UkddmF6kyff7rAp64pM6UmytdApC9Z2U8CNc8xpnXLbGVRgaq6O
 z5VxJDYF3OJ+YtwKWSZjESGuCTKgCawhuCUi63t8WvgJta4H/ouC1WoJI2Nw3cXQ0o
 2V6H5INF+O3H2STyL7aUVK1/0NVGv3du7lkPSRrv+hb2i7idUkEhwaScyskTQCT1+F
 KC7+3TjE1aLVF8G/n1bLLW8hbjeaySn4/MwuenoOo58WNYQVSwuhll7muW+aBYDUS2
 OiEhsWBaiYbOcAOZvJU4UM8Sfzh+zdgGaVMJgya2WANSu9cYK5Jjej2+DGVuCR2WW0
 ZCxodLUPOamHg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 14:57:56 +0200
Message-Id: <DJEQTPJAR8DW.18CJ2FC7YZPA3@kernel.org>
To: "Dawei Feng" <dawei.feng@seu.edu.cn>, "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] nouveau/firmware: fix memory leak on BL load failure
Cc: <lyude@redhat.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>, <stable@vger.kernel.org>, "Zilin Guan"
 <zilin@seu.edu.cn>
References: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260610025037.4115412-1-dawei.feng@seu.edu.cn>
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

(Cc: Timur)

On Wed Jun 10, 2026 at 4:50 AM CEST, Dawei Feng wrote:
> If loading the HS bootloader blob fails, nvkm_falcon_fw_ctor_hs() returns
> immediately. This skips the common cleanup path and leaks the firmware
> state allocated by nvkm_falcon_fw_ctor() and nvkm_falcon_fw_sign().
>
> Fix this by routing the load failure to the 'done' label so
> nvkm_falcon_fw_dtor() can properly clean up the partially initialized
> state. Keep the original image firmware in 'blob' until the common
> cleanup path, and use a separate 'blob_bl' pointer for the bootloader
> firmware so it can be released immediately after the bootloader data has
> been copied.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc6.
>
> An x86_64 allyesconfig build showed no new warnings. As we do not have a
> supported NVIDIA GPU with the required firmware to test this path, no
> runtime testing was able to be performed.
>
> Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for A=
CR FWs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Is Zilin a co-author of the patch?

> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
> Changes in v2:
> - Use a separate bootloader firmware pointer instead of reusing 'blob'.
> - Keep the original image firmware release in the common cleanup path.

@Timur: Any further comments following up v1?
