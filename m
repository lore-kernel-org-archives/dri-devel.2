Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009DF1088E52
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 22:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC3910E031;
	Wed, 18 Mar 2026 22:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f2yStBZe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A7710E031
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 560E040AC1;
 Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1719EC19421;
 Wed, 18 Mar 2026 22:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773874619;
 bh=ObfiedzrwsT34Y8biasL83aWxVvgU9ByOpIkysicBaI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f2yStBZe2+vQHXAU97dz9MtvegAKXsuZUAxqH+mDtFLlNP/8TYDcD1AHgZoXTTTvO
 KnQ2ioQ574gvQnL4AzSUmQhhRj5g/UWA091Reybt+i7aRaFe5j3oS9jLeCMw2fh0fS
 D/GN3wge8/ByiLaBT2OvkQeDuUqvzIlTACOvbzQfUn6c5C50JNAVEedQG9PsAGgAvX
 IjsV5pg2NusfKkR52Mq0p5i/amUZep0A34rn+r+RkTCw/I1/yS9sfyJ1mjkAHntq1Q
 1H+AqekIERYMikOLJYCMGx50jNayfuXvZMupL3/C1S5hhH6CSBQCM3P3n3w/ar/wz2
 dkBgIf9sBO4jg==
Date: Wed, 18 Mar 2026 12:56:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
Message-ID: <abstuhuD4FJ-RMcc@slm.duckdns.org>
References: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
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

On Wed, Mar 18, 2026 at 04:34:17PM -0300, Thadeu Lima de Souza Cascardo wrote:
> page_counter_set_max may return -EBUSY in case the current usage is above
> the new max. When writing to dmem.max, this error is ignored and the new
> max is not set.
> 
> Return as soon as setting one of the regions max limit fails. This keeps
> with the current behavior of returning when one of the region names is not
> valid.

Ugh, I don't know why dmemcg_limit_write() is trying to handle multi-line
inputs. After this, there's no atomicity w.r.t. failures either, so this
seems entirely pointless. I'd much prefer to strip out the multiline
handling.

Thanks.

-- 
tejun
