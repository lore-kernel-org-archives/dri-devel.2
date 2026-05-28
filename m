Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66A3CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 21:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AD110E7B0;
	Thu, 28 May 2026 21:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZSu0fT0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8119410E7B0;
 Thu, 28 May 2026 21:07:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C9FC40837;
 Thu, 28 May 2026 21:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F5A1F000E9;
 Thu, 28 May 2026 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780002450;
 bh=fowJXGyder4bQsc7MfVmAwFTMAFL1nJkdD2VVv22884=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FZSu0fT0FGaAH4AxLkt3DS93Ph42wwlCCSS/HHZyqQN80np3ElAgAtffQg/CawLcs
 ukFTIJ2TjDGKRPUPrskQbq+qMejlyWhIYS5GGSlUR9wZ1KAGICMchAWgy8FHfNhTNL
 XmcjmniR90FZvsTd3k2gVHNZKocRdFUjGov4TfUkAEQ1v2jfvKLvrElXFSUgCWvXA3
 3sDtu8Rv1FtPa8UsmhdgaFVkY8DTsvqN0NrdpfpMmfAIzP8g8i6ZBu7fvlTZHH7HOa
 dM/qShlMIKyGc28aE+nIwTTDZ8Xbs3qgSDwyj/2g3NG7URZGbXdTukv/siE4/HLsmR
 yrL0yPgIJkGSQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, Timur Tabi <ttabi@nvidia.com>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Airlie <airlied@redhat.com>, Qianfeng Rong <rongqianfeng@vivo.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Hongling Zeng <zenghongling@kylinos.cn>,
 Danilo Krummrich <dakr@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Date: Thu, 28 May 2026 23:07:17 +0200
Message-ID: <20260528210717.7078-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528192847.4077458-1-lyude@redhat.com>
References: <20260528192847.4077458-1-lyude@redhat.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 28 May 2026 15:27:14 -0400, Lyude Paul wrote:
> [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage

Applied, thanks!

  Branch: drm-misc-next-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/5] Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage"
      commit: ebddb00faa82
[2/5] Revert "nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation"
      commit: 1a8117455d0d
[3/5] Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
      commit: dd516da348f1
[4/5] Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd"
      commit: 80fa10569b90
[5/5] Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions"
      commit: 18178f2ac176

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
