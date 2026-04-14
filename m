Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39974F9D0E2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F64910E624;
	Tue, 14 Apr 2026 16:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RtwTsJZm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E3410E624
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:24:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9036D60018;
 Tue, 14 Apr 2026 16:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FA6C19425;
 Tue, 14 Apr 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776183855;
 bh=BhJVhuq1ERNvkwltfV/6VfoiFUTjHYKa2RPCsP6TyKY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RtwTsJZmECnOMmXzz1pu14fmjGS7jo/i0TcGo7BN1SS+z8O+wmio03nMm6Vfhe5xN
 hw9wHMkHEL05J/TsCN1M2o0XZ+aQaFLge/BQDIuK9u+/9QChD91xd3mC3q9nnUsZgs
 PWQtG7S7c5w26Ub+z30E0QFHohH+d/Fcy1GbwYcrAOHBi53SxaFG7wlm9BGvhlqjC8
 0s5Exvwz38hkvIaaR6MY144CXFfyCX6Jtb2Y9XjOpBLfHO6/iFc5Q+DayfRgqKvGap
 3etuWiIhhKbff5hdSv6RbwTG3FDlBCN1yWQijJnQ+CYe1ZDnafydhCbXWqPzJBZ0zE
 6L3YMmCVYqRUQ==
Date: Tue, 14 Apr 2026 17:24:09 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 stable@vger.kernel.org
Subject: Re: [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Message-ID: <ad5qKZjhfAnnpmNV@aspen.lan>
References: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
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

On Sat, Mar 28, 2026 at 09:42:16PM +0100, Duje Mihanović wrote:
> From: Duje Mihanović <duje@dujemihanovic.xyz>
>
> Boards using this backlight chip do not power the backlight off on
> suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
> the backlight core on suspend.
>
> Tested on samsung,coreprimevelte.
>
> Cc: stable@vger.kernel.org # v6.19
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
