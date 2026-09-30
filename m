Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2BCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A37210F341;
	Wed, 30 Sep 2026 11:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hsNLh2R0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A62410F341
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78FF443E8E;
 Wed, 30 Sep 2026 11:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2731F000FF;
 Wed, 30 Sep 2026 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769339;
 bh=p4u5VH+Ao5EgWA0EYmnPkPH95U+2DNMB/xIQNS53jKU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hsNLh2R0j5hLWx3tJNJ5ZH8rh5IkVgE/esf0wpyu5lbGL0hnk3D3mEGEpvdgJDIXW
 AueSm7cDblkQS8V+XhaNfzE6EZmLG1oxuj47AqppYDwrsZWSrHBJlitEDs0cX9jRZb
 xqjmclSZxe5HOc//Uy9glXqzsuw5Rk9Ko2jCcg0S17i1y7HvQThb6VTqpynLoFs6MB
 fpv1phYxYSdP5K3r/Qb0fdnx/BU1cLi7qqQ3pCYq2CPIsw6KnT3wi8azxCukFFlrcZ
 sGD9pEa3FZiBNrPg6b6zY3X2TSuIgIz2jJBXP8lVlbTyVleeTWhh0G+b75nZLS5U4Y
 RB4jME91Saozw==
Date: Wed, 30 Sep 2026 12:56:10 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 6/8] misc/arm-cla: Set up memory translation context
Message-ID: <20260930115610.GF480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-7-ryan.roberts@arm.com>
 <20260717110214.64D881F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717110214.64D881F000E9@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 11:02:14AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Will this result in a build failure due to strict type checking in the min()
> macro?
> 
> Further down in cla_op_access_reg(), the code calculates the max register
> using min():
> 
>     while (nregs > 0) {
>         unsigned int reg_group = ALIGN_DOWN(regidx, 8);
>         unsigned int max_reg = min(regidx + nregs, reg_group + 8);
> 
> Since nregs is a size_t (64-bit on ARM64) and reg_group is an unsigned int
> (32-bit)

reg_group is now 64-bit

