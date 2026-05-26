Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C31CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FAA10E146;
	Tue, 26 May 2026 13:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cG214dNa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF1310E146;
 Tue, 26 May 2026 13:16:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEFFB416A7;
 Tue, 26 May 2026 13:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B471F000E9;
 Tue, 26 May 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779801418;
 bh=JE0l0J/Q4cmSCbkBtHlHYstq0L2VtzMwueKDyLmSf5U=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=cG214dNa11lOiy46AORsXkv4bUe7G6t792Zz1McUEExu49YQuzsGWtnjMFhpT/q5B
 MrWm4yWs+7MGpCUCObANSrsl8H/A53DJXfmh/222L8XI5XR3vgOsg9FTL9a5N4RvVF
 /IQgh/8GaVvCxaAdLesrjnrwjwBy5AMiFXGJQityPEoWKRCSgP5efR4ZjeTTgOJezo
 PwBvoko/tjwmeO2XhNDL2BKxA1yJcrPddVH1UdV4FzAY7pxcLcCPIn4RxUalJYhNwW
 azzU0WcX+XhCrOXM7HeDL8YEIyMvt8RdnFSmqajqRMyEIyISiN7yQG8bwpdY8bRSrW
 +HGWRV9/6y6MA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 15:16:54 +0200
Message-Id: <DISMY2BS8E1D.Q85V8DKCPM1C@kernel.org>
Subject: Re: [PATCH] nouveau/gsp: fix NULL pointer dereference in r535
 nvenc/ofs alloc
Cc: <lyude@redhat.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <airlied@redhat.com>, <ttabi@nvidia.com>,
 <bskeggs@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <zhongling0719@126.com>
To: "Hongling Zeng" <zenghongling@kylinos.cn>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260526014721.13299-1-zenghongling@kylinos.cn>
In-Reply-To: <20260526014721.13299-1-zenghongling@kylinos.cn>
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

On Tue May 26, 2026 at 3:47 AM CEST, Hongling Zeng wrote:
> nvkm_gsp_rm_alloc_get() can return NULL as well as error pointers.
> The current code only checks for error pointers with IS_ERR(), which
> would lead to a NULL pointer dereference if NULL is returned.
>
> Fix by using IS_ERR_OR_NULL() instead of IS_ERR(), matching the
> pattern used in nvkm_gsp_rm_alloc().

There was a similar patch [1] a while ago for another callsite. I replied:

	Are we sure that this can ever return NULL in the first place? I know
	that nvkm_gsp_rm_alloc_get() internally checks for IS_ERR_OR_NULL(), but
	I couldn't find anything within the callchain that would actually return
	NULL.
=09
	That said, I think IS_ERR_OR_NULL() checks are misleading.

Is there a real case where NULL can be returned? If not, let's remove the
IS_ERR_OR_NULL() throughout the whole chain instead.

[1] https://lore.kernel.org/lkml/20260418071412.86022-1-sunliming@linux.dev=
/
