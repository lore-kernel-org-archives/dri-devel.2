Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907DDC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1DC10E066;
	Fri, 25 Sep 2026 08:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aZppMBZS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC34E10E066
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D888860239;
 Fri, 25 Sep 2026 08:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1291F000FF;
 Fri, 25 Sep 2026 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790325154;
 bh=RhmiPGkssS6EYmBpfoqLRYW3Li8b5XhBuBzvKuhjmdU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aZppMBZSsob3WakNuVLYigxy00Bi63z20LI0JOfXxSKxvZy0yScb5R1AZ72yz5pVw
 BPJQoTc/2XyW5aXoT1w5mKqkJRrs12RUvH8NzYE9AbQvYjZrTi9EIoD3xL6Q+sosSy
 de4U/UP8zouL9plXtDciB9kKYc6h46Ca/xmTdPJ48YhL7+B564YoMHg7OKeuLh603H
 XaneFMrncfRCoGorvmeC3mGROCT+Lsuh6LX7g/kppZyMaptllSjkjiznKwx4i+t+2y
 e9YBp1QRTMMhZYi4CBfLsHVTM/zVGwhAsg0m3ooBIHWPF137+fc6Tw489t0Rcuoyzn
 U9QGngJHdYtgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org
In-Reply-To: <20260925081958.3048112-2-phasta@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 08:32:33 +0000
Message-Id: <20260925083234.4E1291F000FF@smtp.kernel.org>
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
- [Medium] dma_fence: commit message incorrectly claims change is in FenceC=
ontext::drop()
--

commit 4a645fda82950d47b5bed116917aa2253db17d1f
Author: Philipp Stanner <phasta@kernel.org>

rust: DmaFence: Add better warning through Device reference

This commit replaces a pr_err warning about forgotten fences with a more
informative dev_warn. It also adds a Device reference to FenceContext to
support the dev_warn output.

> FenceContext::drop() contains a warning print that warns about possible
> memory corruptions if there are forgotten fences. However, precisely
> speaking, a forgotten fence is undefined behavior.

[Severity: Medium]
Is this commit message accurate? The text states the warning print being
replaced is located in FenceContext::drop(), but the diff shows the
modification actually takes place in the Drop implementation for DriverFenc=
e:

rust/kernel/dma_buf/dma_fence.rs:drop() {
    ...
    let signaled: bool =3D unsafe { bindings::dma_fence_test_signaled_flag(=
guard.as_raw()) };
    if !signaled {
        // SAFETY: data is valid because self is valid.
        let dev =3D unsafe { self.data.as_ref().fctx.dev };
        dev_warn!(dev, "DriverFence drops unsignaled.\n");
    ...
}

FenceContext::drop() does not contain this warning print. Could the commit
message be updated to correctly state that the warning is in DriverFence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925081958.3048=
112-2-phasta@kernel.org?part=3D1
