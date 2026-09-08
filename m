Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA6C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D15B10ECB4;
	Tue,  8 Sep 2026 15:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i5c65ouB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70EB10ECAF;
 Tue,  8 Sep 2026 15:27:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8A88601FB;
 Tue,  8 Sep 2026 15:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F591F00A3A;
 Tue,  8 Sep 2026 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788881245;
 bh=9Y0RYiQlqdq8T8rHGKcY5WJFbZOHMj5XD8BYUCfkmiM=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=i5c65ouBuEyZ6oB7J0Er0dVut/Yg1ePEEy4oGAe64mY5uM6ZfpbkeT5m9W1IA29ab
 JpZ8/TAPB6a+2NvkxIL3f43y3pKy3+R0TC/cYTdy6ySa2sA4ar26sqHKau57vlmrUD
 jUqXiw954XFwqTofPlkk19Rd+03vy+ibx0rr6Jd6qWdhOzm+xsuUUy33Uj1Yq52ZJW
 ijmyGte57XMTYBeOmQngxbymMaE/F8EJ6TAWS+WzjcxZj+Lz3mcDTkMdZK7PZzdBmi
 IYXFACNOY2LwM8qmgJLPf4tQ/RvntUz7HPGkC10AaLkELj5a6/IQ76M/xV1tJVqxDk
 w55vjeDNey8AA==
Message-ID: <315455b0aa801c7dbd1b1e2ecf7282c3@kernel.org>
Date: Tue, 08 Sep 2026 15:27:22 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 4/7] vga_switcheroo: Add post_switch callback to
 client ops
In-Reply-To: <20260709092215.168172-5-tzimmermann@suse.de>
References: <20260709092215.168172-5-tzimmermann@suse.de>
Cc: airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dakr@kernel.org, deller@gmx.de,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 jani.nikula@linux.intel.com, jfalempe@redhat.com,
 joonas.lahtinen@linux.intel.com, linux-fbdev@vger.kernel.org, lukas@wunner.de,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tursulin@ursulin.net,
 "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
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

On Thu, 9 Jul 2026 11:16:00 +0200, Thomas Zimmermann wrote:
> Add post_switch to struct vga_switcheroo_client_ops to inform the
> switcheroo client about a completed switch of the output.
> 
> This callback is intended to replace the reprobe client op. It is a
> rename of reprobe for consistency with pre_switch.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
