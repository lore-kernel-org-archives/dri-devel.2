Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34306CD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FA210E38F;
	Sun, 21 Jun 2026 13:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QgqqEt8f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF9910E38F;
 Sun, 21 Jun 2026 13:00:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C502143957;
 Sun, 21 Jun 2026 13:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11891F000E9;
 Sun, 21 Jun 2026 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782046844;
 bh=8lxJr0Ff/uWo6FpO6JrLPcU60RV27XXd6YBLWVHwVrg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=QgqqEt8fkjzYqED2Zo0KdWJCse6Moh82r2qaEY4rYC7oFNfzMRJ/SL0svtmZmvw4D
 +zmoYEWTRwyTpOH0Off/PkWC7uFvtBAa3FrfH6rfgds3aeMlFop8UTDr/2Zzw1fFgF
 reZeEE5/PtjdRCrpUOCI/ZJdt5j6vbz9/HrmdmXbhlDIZ7Ptc7Ep0hSnhA8cJHptBf
 ylItNv0aMdS0V8rf83DHy0OxA/UHp9OwItGNcorSvl/iC2J/TfRIZwmRoDOoyf2epA
 T88x9r8jN6tPX7hZ0Rg2xZOQXJPIEhaZdvqJ0xulONioJeIsVJvJ4KKwJXzX9qK5N7
 xqXRlV/IlAWBA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 15:00:40 +0200
Message-Id: <DJEQVST8KK4D.1DX65CF227WWC@kernel.org>
Subject: Re: [PATCH v2 0/5] nouveau/gsp: Clean up IS_ERR vs IS_ERR_OR_NULL
 usage
Cc: <lyude@redhat.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <airlied@redhat.com>, <ttabi@nvidia.com>,
 <bskeggs@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <zhongling0719@126.com>
To: "Hongling Zeng" <zenghongling@kylinos.cn>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260601095403.228220-1-zenghongling@kylinos.cn>
In-Reply-To: <20260601095403.228220-1-zenghongling@kylinos.cn>
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

On Mon Jun 1, 2026 at 11:53 AM CEST, Hongling Zeng wrote:
> Hongling Zeng (5):
>   nouveau/gsp/rpc: Document RPC function return value contracts
>   nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c
>   nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
>   nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
>   nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

There are a few more comments from Sashiko, did you check them?

Thanks,
Danilo
