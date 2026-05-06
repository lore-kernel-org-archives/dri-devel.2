Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8737CCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD4C10E1D4;
	Wed,  6 May 2026 15:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOni3hEb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C5410E1D4;
 Wed,  6 May 2026 15:21:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 71C4960139;
 Wed,  6 May 2026 15:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD9DC2BCB0;
 Wed,  6 May 2026 15:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778080862;
 bh=643xwBVUGXkz/qC0nQ1s7Ydr9zrHrrjhp3ZH25VeBmM=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=OOni3hEbpimcy0hJPFpQv6/ZV5x9OpeWVRi/L7BKSYuhElzhs8D+0n8rhKCpYLNtw
 BVT62Z53S7yabx96NlkgHwNbi9D1hS7DTzYyikX9SpxdX0kd/4GCas1w/e6rIExW8b
 JAWDCvkp6zDDSTkK5YtkVXBQUnhqN2mcuu29W2hV9HfEwvgzW9YIqBxz2ZW1rA3VT6
 Orgm7PFnd9BgnPw4VjxH0doFomwvZUiN8CPVDvTyNEbxCJS74HUS1YBUIDZJkvtdkc
 I2jwCes3lIvXYW8XZXEbTggTCQXNi7yIBCDo457FmCSol+gY73/aWj8q8Ltoy7S+Of
 1cgCOykjteiOQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 17:20:58 +0200
Message-Id: <DIBP25O5HJ09.2SRQU8QS7VUDN@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Ching-Chun Huang" <jserv@ccns.ncku.edu.tw>, "Chia-Ping Tsai"
 <chia7712@gmail.com>, "Timur Tabi" <ttabi@nvidia.com>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
 <DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org>
In-Reply-To: <DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org>
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

On Tue Mar 17, 2026 at 5:06 PM CET, Danilo Krummrich wrote:
> Can you please move this into the second patch. Additionally, in the seco=
nd
> patch, please only keep the Kconfig change and use the following in the
> Makefile.
>
> 	obj-$(CONFIG_DRM_NOVA) +=3D nova-drm.o
> 	nova-drm-y :=3D nova.o
>
> I.e. keep the directory and filenames as they are.
>
> We can use the same trick for nova-core, so we get nova-core.ko and nova-=
drm.ko.

Do you plan to follow up on this one?

Thanks,
Danilo
