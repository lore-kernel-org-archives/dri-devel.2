Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15764CA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7833110EB43;
	Fri,  9 Oct 2026 21:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="frc3MO0o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FC910EB43;
 Fri,  9 Oct 2026 21:48:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4152414E7;
 Fri,  9 Oct 2026 21:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0827A1F000FF;
 Fri,  9 Oct 2026 21:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791582530;
 bh=nhLyzFLbeYwxkREFnGh9PJAu9SCFWSJxG53+Un2C+Xs=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=frc3MO0oLwoW78KYn9WR2TYojNVZyRylZGUJvnECnSjMLbzA9ex6iqrviOc0mk+p7
 RNSblRdShqysDtvAJgj2HjufYQ+5RSpbV0Em1490xs8Bq0rWS125mUAceqGZZx0NN3
 1Q8oCLnt/zw/JFdleVZp7gY/t4fbefTiYa+lgbK7K/q8aUY7NEau5lYgHbWlRwZeKA
 Wmu5/nGXWS0hvoys/dXmStdNptC0Xv4jiTqu5gQVvV2DXbS6Lx3wXqTxnuai+PBf4i
 wbhzHoquWJoqn9dmgIrFGRczQKiBoiRO06CFIt4P6bpmqAXV1zRQ2FsyijEdbqMvMH
 W7CYwke/YM3YA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 23:48:46 +0200
Message-Id: <DM0N02GT1YII.Z30F7OBT9XKX@kernel.org>
Cc: <jim.cromie@gmail.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dave
 Airlie" <airlied@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Campos Ramos" <Capitain_Jack@yahoo.com>
To: "Jim Cromie via B4 Relay" <devnull+jim.cromie.gmail.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/3] nouveau: Fix NULL pointer dereference in
 GET_ZCULL_INFO ioctl
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-2-839e2bbe514d@gmail.com>
In-Reply-To: <20261009-my-fixups-v2-2-839e2bbe514d@gmail.com>
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

On Fri Oct 9, 2026 at 7:44 PM CEST, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>
> When graphics engine firmware fails to load or initialization aborts
> early, nvxx_gr(drm) returns NULL. Calling DRM_IOCTL_NOUVEAU_GET_ZCULL_INF=
O
> causes nouveau_abi16_ioctl_get_zcull_info() to dereference gr at offset
> 0xf0 without checking for NULL, triggering a kernel page fault.
>
> Validate that gr is non-NULL before inspecting gr->has_zcull_info.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Please add a Fixes: tag and CC stable.
