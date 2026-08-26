Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA070C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2733710E195;
	Wed, 26 Aug 2026 10:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hih6D1TT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E53610E195;
 Wed, 26 Aug 2026 10:21:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEC3260A78;
 Wed, 26 Aug 2026 10:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A011F000E9;
 Wed, 26 Aug 2026 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787739692;
 bh=yAPzUE3JSIM9yIx60zZbNALaBJLJvtIP9rqlwFDQccM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hih6D1TT4/hrsTpVuruA2ijM81MMWb3yKw/ykimGybkKFYfEfGMSU/VQ/6DFI6aNv
 38XqAQm39EbEZWkcY5ck9Vgz+q0MwD3EtwDrBXgkKyDZ2a2E3ozST6/T5J7T5qUavk
 eOjsFYO1D79xJdFWOJ3hMlE4koR7Rp+sqGAqS5+c=
Date: Wed, 26 Aug 2026 11:24:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux@treblig.org, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com,
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/amdgpu: Remove is_idle method
Message-ID: <2026082644-monetize-tingling-0abd@gregkh>
References: <20260815180033.8958-1-linux@treblig.org>
 <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PgZx7aDGFD5pPQ=1MvF9_N_omVojNiDQFHjs0Tqasv+A@mail.gmail.com>
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

On Mon, Aug 17, 2026 at 11:27:41AM -0400, Alex Deucher wrote:
> Applied.  Thanks.

Any hints on where this was applied and if it will get to Linus "soon"?

thanks,

greg k-h
