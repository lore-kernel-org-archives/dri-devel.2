Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB85F99C7E
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 17:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B6410E360;
	Sat, 18 Apr 2026 17:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GPkTURJL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3185810E376;
 Sat, 18 Apr 2026 17:35:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C40D1444CA;
 Sat, 18 Apr 2026 17:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D707BC19424;
 Sat, 18 Apr 2026 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776533720;
 bh=6zlWUhd+ODi0eJZfqAbsxg62XBlwsUK0bjyq54H5TEc=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=GPkTURJLGcthqXyT8SfCkzCkb0wGxSy6cXAnSiRlC4XR05KqRU23oH1AxSr3ldcVR
 HOf70d7SynZE8JREm/vEwcl22eqqQK/V4uPfNl1DkYmxgCcG/Cd/Nqq+aovIhioaXD
 uafFjrbWaTYVUj2/cq7vLhpbOfAln9dL5tqW6zqo9McgqZfktzHvZjXqMd/lHuE/vN
 4tchy7YwBMp1SB2MQ2pNrQJYDl3n27Tto6FTImGBLRZavoD+C4my5RAJvEX/duRW4S
 /OCTmHstyN5IAveDaL2Q0p+lm/8Tgek00TPCWt+IP/JCBdQYK/xVBTwfazHRnCS1Ii
 9UoL17f24DY0w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 19:35:17 +0200
Message-Id: <DHWGN6Y2J9X6.3FMWWDU2NQ2LV@kernel.org>
To: "Timur Tabi" <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/nouveau/gsp:  Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
Cc: "sunliming@linux.dev" <sunliming@linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "sunliming@kylinos.cn" <sunliming@kylinos.cn>
References: <20260418071412.86022-1-sunliming@linux.dev>
 <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
 <abb12ec2c8d72d6a369ef7b29d0453736a07f90c.camel@nvidia.com>
In-Reply-To: <abb12ec2c8d72d6a369ef7b29d0453736a07f90c.camel@nvidia.com>
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

On Sat Apr 18, 2026 at 7:24 PM CEST, Timur Tabi wrote:
> On Sat, 2026-04-18 at 14:12 +0200, Danilo Krummrich wrote:
>> Are we sure that this can ever return NULL in the first place? I know th=
at
>> nvkm_gsp_rm_alloc_get() internally checks for IS_ERR_OR_NULL(), but I co=
uldn't
>> find anything within the callchain that would actually return NULL.
>>=20
>> That said, I think IS_ERR_OR_NULL() checks are misleading.
>
> I posted a patch a couple months ago that cleans up an IS_ERR check, but =
it was never picked up:

Thanks! Can you please make sure to send patches to all maintainers? If the=
y
don't land in my inbox, I can't pick them up. :(

> https://lore.freedesktop.org/nouveau/20260103000756.1002890-1-ttabi@nvidi=
a.com/T/#u
>
> I'm quite certain that there are other similar issues in Nouveau w.r.t. I=
S_ERR_OR_NULL.

Yeah, that sounds likely.

> I think an audit of the Nouveau error paths is in order.  I suspect that =
Ben's big refactors
> over the past year have resulted in some invalid error paths.

Are you planning to look into this?

Thanks,
Danilo
