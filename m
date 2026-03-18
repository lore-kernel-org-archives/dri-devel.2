Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D293A10775E6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F5B10E177;
	Wed, 18 Mar 2026 16:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fdZGBgv5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E5310E13E;
 Wed, 18 Mar 2026 16:23:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 606A260142;
 Wed, 18 Mar 2026 16:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F73AC19421;
 Wed, 18 Mar 2026 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773851031;
 bh=aHDPWpZDMzCjnS+BH41VMj7QJyPcpd/avzDQ23CMQro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fdZGBgv5YWx0TYo+oWteCzNNwypClO+BO/MRtYEk3hcEoaHao1e03dcWncP6jZy0W
 002s5AmEzSijgdE1V9Ai9ewFbTf6yNLRf/TiRTV+77j4pJAh/2bRonLVn5RBf3Rfdw
 XoGkaq5agwYmcCuipK7wtBMfO4qSIT3gHUq5J7Gwif4k6Xft1QGW4o2fiqg20iFfQ/
 Eqimz+vJrdxpF/FqGA7gZJzZbjzpgmtKydXbx7hcfk141g/bVLJksJhT4BpyKPnVUz
 V/pobnZjb+qjWY5bTIejiW4f3yLxj1a85I/75YgnZeue9SncL4hyYurP44bD5a1LFZ
 eAz+fb6k0LxfQ==
Date: Wed, 18 Mar 2026 09:23:50 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Gangliang Xie <ganglxie@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/amd/ras: work around write overflow attribute warning
Message-ID: <202603180923.9208D4C4@keescook>
References: <20260318105050.1947902-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318105050.1947902-1-arnd@kernel.org>
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

On Wed, Mar 18, 2026 at 11:50:36AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-22 warns about possibly copying beyind the end of an array:
> 
> In file included from drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_umc.c:24:
> In file included from drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras.h:27:
> In file included from drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/ras_sys.h:29:
> In file included from include/linux/string.h:386:
> include/linux/fortify-string.h:569:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>   569 |                         __write_overflow_field(p_size_field, size);
>       |                         ^
> 
> As far as I can tell, this is a false-postive warning, but there is
> an easy workaround, by using a direct struct assignment in place of
> the memcpy.
> 
> Fixes: 7a3f9c0992c4 ("drm/amd/ras: Add umc common ras functions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Yeah, direct assignment is much preferred anyway. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
