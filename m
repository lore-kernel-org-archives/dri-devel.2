Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993ABCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04BF10F5B6;
	Fri, 26 Jun 2026 12:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YasClcFx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE74110F5B6
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:33:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0C0A60098;
 Fri, 26 Jun 2026 12:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365511F000E9;
 Fri, 26 Jun 2026 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782477202;
 bh=NUnRORpUbpb7UqJA0XrJa48xsJE9cicgXLWmh89S6Bk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YasClcFxVa88j0WC7btAB+kb/X6pQHhbCW+BOIyH6u5RVtPwKvWG2hCA9ow6LN/7V
 /WZ1D1JqHXHkTP3GsbqukJZT0bKtE1T0NZOGgGRbWhtb1ynhMRaC/zNatGeYYYKfAz
 gaU0IrDJh8kiySfji4RuhB3C5x9VhI7/SGm70GyoznRq4QzTTs3unOjM+7JsSejOdE
 d6VR/2ZewlAhem5jzDW8mRJfaFEeQiZNnLmrNFvbVv21ZO+K4Dtj2BpIG04eHndWRn
 43EriQqZ71BfMUQsMAzlnnWoBTborGUsI9xpuic/Evarlc/6sl621j4Q6Ww+PTbWcb
 hiyw2SJXK/8Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: dma-buf: unwrap_merge_order: success path leaks
 chain and array   fence references
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626122145.35549-1-vulab@iscas.ac.cn>
References: <20260626122145.35549-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:33:21 +0000
Message-Id: <20260626123322.365511F000E9@smtp.kernel.org>
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
- [Medium] The commit message is factually incorrect regarding the referenc=
e counting behavior of `mock_chain()`. It claims that `mock_chain()` acquir=
es its own references, making the `dma_fence_get()` calls on lines 440 and =
445 surplus and permanently leaked. In reality, `mock_chain()` (and underly=
ing `dma_fence_chain_init()`) takes ownership of the references passed to i=
t without acquiring new ones. Since the original references to `f1` and `f2=
` were already consumed by `mock_array()`, the `dma_fence_get()` calls are =
strictly necessary to pass new references to `mock_chain()` and avoid a dou=
ble-free. Furthermore, the commit message implies `c1` is leaked, but the p=
atch correctly omits `dma_fence_put(c1)` because ownership of `c1` is trans=
ferred to `c2`.
--

commit 96e1c6f7abe617d57c291e7a9fc66a1436a69266
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: dma-buf: unwrap_merge_order: success path leaks chain and array fence =
references

This commit adds missing dma_fence_put() calls to fix resource leaks in the
unwrap_merge_order() success path.

> The success path only releases a2 via dma_fence_put but does not release
>   a1, c1, or c2. The dma_fence_get calls at lines 440 and 445 were intend=
ed
>   to pass references to mock_chain, but mock_chain already acquires its o=
wn
>   references internally, making these extra gets surplus and permanently
>   leaked.

[Severity: Medium]
Is this description accurate regarding how mock_chain() handles reference
counting?

The commit message states that mock_chain() "already acquires its own refer=
ences
internally". However, mock_chain() and the underlying dma_fence_chain_init()
actually take ownership of the reference passed to them without acquiring n=
ew
ones.

Because the original references to f1 and f2 are consumed by mock_array(), =
the
dma_fence_get() calls seem to be necessary to pass new references to
mock_chain() and avoid a double-free, rather than being surplus.

Additionally, the commit message claims that c1 is leaked, but the patch
correctly omits a dma_fence_put(c1) because ownership of c1 is transferred
to c2.

Could the commit message be updated to avoid implying c1 needs to be releas=
ed
or that the get calls are surplus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626122145.3554=
9-1-vulab@iscas.ac.cn?part=3D1
