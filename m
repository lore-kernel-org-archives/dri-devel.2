Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2938ECDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CD310E0E4;
	Wed, 24 Jun 2026 18:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mYZnXoy9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C00B110E0E4
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:52:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C87CD60018;
 Wed, 24 Jun 2026 18:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B881F000E9;
 Wed, 24 Jun 2026 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782327168;
 bh=D7hkJteoSNs8rS8VBpeystfizFe6bdWuHjQ285p+IEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mYZnXoy9/kEr1Csqc8vSItQjEXA/Xa2JMYS1/w+q+osQ2ycPTCHhBmPA151h3Ml/T
 nPRri5JwXErUOM5mbDide4yewYAtZ+X8mU1tEXedjiueoeOR24VdRc9c8pki8+zZa3
 EXa9J82JFFSQXFUupv4jWk/+Oqo1BVTSMNNVeEE2NklQLsBKMTScQ5qqy6nvYdTLjR
 qfT2QlMRvWLeYH3bpdbWxV8L0G/Y5wOukgExuH6X7VoiWeFzRN0XTEjfsvTPzVSxD8
 IMeX9nSca1ZKfW+/IvNjIJc+9c7Ri9tdld1PTJgvqiwmPjWWGDbUuQrxKqWNektPRL
 MfD3vQNXC7uNw==
Date: Wed, 24 Jun 2026 08:52:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
 skhan@linuxfoundation.org, dev@lankhorst.se, mripard@kernel.org,
 natalie.vock@gmx.de, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
Message-ID: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
References: <20260624031107.667253-1-lihongfu@kylinos.cn>
 <20260624031107.667253-2-lihongfu@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624031107.667253-2-lihongfu@kylinos.cn>
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

On Wed, Jun 24, 2026 at 11:11:06AM +0800, Hongfu Li wrote:
> Add dmem.events to report hierarchical low/max event counts per DMEM
> region.  Increment counters on dmem.max allocation failures and
> dmem.low protection events.  The file is available for non-root cgroups
> only.

Please don't double space in descs or comments. Also, maybe it's obvious but
it'd help if you list why and how this is useful. Why do we want to add
this?

> +  dmem.events
> +	A read-only file that reports the number of times each cgroup
> +	has hit its configured memory limits.  The format lists each
> +	region on a single line, followed by the event counters::
> +
> +	  drm/0000:03:00.0/vram0 low 0 max 3
> +	  drm/0000:03:00.0/stolen low 0 max 0

This isn't a supported file format. Please read the documentation on allowed
formats.

Thanks.

-- 
tejun
