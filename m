Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4798CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120AB10E50F;
	Wed,  6 May 2026 08:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CnLCB6nT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A14A10E50F;
 Wed,  6 May 2026 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778056924;
 bh=hGYWyFzqC/3GRkvl0z9xEYhHVzSFJMs1carF/LBfyWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CnLCB6nTNAZ7m6o0fOB8BIdr/YS42kDJSB2IodeeI46D1ZwsRCs9RyjwdQv2dkh3Z
 /a7BHUh8h0D70cGt/0OuxQGM0W9mweAUdD4hxcM6CRn3scpWTLDRoPhfNouwjVoUYa
 TJXoaS7NVtDSspC+ptCxhRtyhxTiq7QHdW8fE/h7NUBtaD+ObVM097OWUYTQpOAIWq
 GrDcB7j85l7zvvxIomc9isU4r5yYDPUPUAI5QuBJHyZnVG6aCZsxl7R/xCwmKswyOW
 kY9OOpTtuye92vtL8DfartQ4f5TNoJ1+QThCmDEa+oGMxdbHIxriaP7QHZlkAekx17
 buAiXVcI4uqEg==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3B54217E0610;
 Wed,  6 May 2026 10:42:03 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: aliceryhl@google.com
Cc: a.hindborg@kernel.org, airlied@gmail.com, bjorn3_gh@protonmail.com,
 boqun@kernel.org, boris.brezillon@collabora.com, dakr@kernel.org,
 daniel.almeida@collabora.com, dri-devel@lists.freedesktop.org,
 gary@garyguo.net, kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org,
 nouveau@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tmgross@umich.edu
Subject: Re: [PATCH v2 1/1] rust: drm: add RENDER_CAPABILITY flag for render
 node support
Date: Wed,  6 May 2026 10:41:47 +0200
Message-Id: <20260506084147.19907-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <afnMTfVfGq_iLXov@google.com>
References: <afnMTfVfGq_iLXov@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Alice,

On 5/5/26 12:54, Alice Ryhl wrote:
>
> I think it would be nice for this documentation to elaborate more on
> what this feature actually does. After all, it clearly took us a while
> to understand it, so probably others are confused too.
>
> Something along these lines:
>
> /// Sets the `DRIVER_RENDER` feature for this driver.
> /// 
> /// When enabled, the driver exposes `/dev/dri/renderDXX` render nodes to
> /// userspace. The render node is an alternate low-priviledge way to access
> /// the driver, which is enforced on a per-ioctl level. Userspace processes
> /// that open the render node can only invoke ioctls explicitly listed as
> /// usable from the render node, whereas userspace processes using the
> /// master node can invoke any ioctl.
> const RENDER_CAPABILITY: bool = false;
>

Agreed, the extra documentation will definitely help clarify the flag 
purpose. Thanks for the feedback!

> Also, I'd probably call this const `FEAT_RENDER` for consistency / to
> make it show up in grep.
>

Right, using FEAT_RENDER in the Driver trait as well sounds good to me.
I'll submit a new revision with these changes.

Best,

Laura
