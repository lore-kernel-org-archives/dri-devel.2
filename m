Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E49C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E51B10E35C;
	Tue, 21 Jul 2026 17:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3Ehe/jr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F24110E35C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D867C41069;
 Tue, 21 Jul 2026 17:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7511F00A3A;
 Tue, 21 Jul 2026 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784654783;
 bh=uMCkyxUD7fC802ZhNEo4EcyXWZfZYO4sDV6g+t3KpUE=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=A3Ehe/jrBithDcdtU8AAsJ7cFI7ba4ho+qx7PWvaIuweL8HXhChRxKMUGsFs/cFx7
 uElLUbfwJ2ivHH+9U87m9UefxXUG3xDrJam8IGGQck2SKHH891bH6BOzqJg/C3lHck
 81W6PBn3/kFhFJZ3ko6hIETEiWrabEyVfSLop9+fB2aVuZ9xYeN+5XlN8g7JLG9r8i
 CrQkOweUpVdGQl9TejcidwdeM7AJwDv/4+Twyo+funjD80JnNLCOgZM4JJFjGppb2T
 vWH3KcfN6dEfRcd1xnRxrsHJagZ/UOZ+rH/eshqU+SxkGvvY3TFDSzkpM/4aK5e7Yd
 1LeLrUTNyTc4A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 19:26:18 +0200
Message-Id: <DK4FBIWI47PQ.1J3WZDTDGL42X@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <boris.brezillon@collabora.com>, <samitolvanen@google.com>,
 <work@onurozkan.dev>, <acourbot@nvidia.com>, <lyude@redhat.com>,
 <laura.nao@collabora.com>, <beata.michalska@arm.com>,
 <alvin.sun@linux.dev>, <steven.price@arm.com>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 4/7] drm/tyr: add GPU virtual memory (VM) support
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
In-Reply-To: <20260713-fw-boot-b4-v7-4-afd8dc1494dd@collabora.com>
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

On Tue Jul 14, 2026 at 5:18 AM CEST, Deborah Brouwer wrote:
> +        // dummy_obj is used to initialize the GPUVM tree.
> +        let dummy_obj =3D gem::new_dummy_object(ddev).inspect_err(|e| {
> +            pr_err!("Failed to create dummy GEM object: {:?}\n", e);
> +        })?;

In quite a lot of places in this patch and the other patches, please don't =
use
pr_* primitives in drivers, please use dev_* instead.
