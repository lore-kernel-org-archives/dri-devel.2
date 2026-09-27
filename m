Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1267C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164CE10E588;
	Sun, 27 Sep 2026 11:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xk6O1euU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C7E610E588
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:23:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5554040A18;
 Sun, 27 Sep 2026 11:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8861F000FF;
 Sun, 27 Sep 2026 11:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790508222;
 bh=uJoq1bZjs3XTfx2eRqVanK7kcpcxw8vMZNzFX121URE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xk6O1euUcHmBT50vQ9VeL6DBbvn55TbS/3ZnwCtjetb844L44CgHcyDYAXEp5MQVe
 1b5TS6Zl1moW5OINAsr4tbzVlKnS5EBHSz5FbKQTMKnEkARcCuqi2LpwyVyhbG+jnm
 1ZEEpcwt4N0VXeD6A0ZFPcXkHm+Sr/qaHoWYJFcr6CaobFcsxJn6Ae2bkAwz+miY04
 eIMtYoT9Zmol6F3EMaCztrJ9ObfgMqUoV3RkyAnpdkU0uhIjT/NPYlrrzIT/nIaYm8
 4JwaZbfiUNKQdB0e1icDz8YX721JrFMRLdJPVwcrioKyap4WVh0cbbb8yZ0rfTFLHE
 zFk0fk3vDUo3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] gpu: nova-core: gsp: cmdq: use element_count to
 advance queue pointer
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, gary@garyguo.net,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260927-cmdq-rpc-v1-1-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
 <20260927-cmdq-rpc-v1-1-822db5af910e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 11:23:41 +0000
Message-Id: <20260927112341.ED8861F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gpu: nova-core: missing validation of GSP element_count causes DoS=
 or queue corruption
--

commit 4735296acba7b78deac091e3d6a7e814d360afff
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: gsp: cmdq: use element_count to advance queue pointer

This commit changes the command queue message receiving logic to use the
element_count from the transport-level header instead of recalculating
the slot count from the message length.

> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index a5595da23407b..9285fd796f9d3 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -863,9 +863,8 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout:=
 Delta) -> Result<M>
>          };
> =20
>          // Advance the read pointer past this message.
> -        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
> -            message.header.length().div_ceil(GSP_PAGE_SIZE),
> -        )?);
> +        self.gsp_mem
> +            .advance_cpu_read_ptr(message.header.element_count());

[Severity: High]
Does this leave the driver vulnerable to a compromised or buggy GSP firmwar=
e?

By directly using the untrusted, DMA-mapped message.header.element_count() =
to
advance the ring buffer read pointer without validation, this could
potentially allow the hardware to trigger a denial of service or memory
corruption.

If the hardware provides an element_count of 0, could it fail to advance the
pointer and lead to an infinite retry loop when send_command() is called,
causing a host lockup?

Conversely, if a maliciously large value is provided, could the read pointer
advance past the write pointer, causing the driver to process uninitialized
memory as legitimate messages? Should this value be validated against the
available read area bounds before being passed to advance_cpu_read_ptr()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-cmdq-rpc-v=
1-0-822db5af910e@nvidia.com?part=3D1
