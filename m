Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26471C44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2691410E308;
	Thu, 23 Jul 2026 00:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hKQl9qHs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB9B10E308
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:53:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 281CD600AB;
 Thu, 23 Jul 2026 00:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27B61F00A3A;
 Thu, 23 Jul 2026 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784767983;
 bh=REMJtHFmUWXTNq5fP+3bUHQERsAa0AcZzLarn0vFGzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hKQl9qHsku5/ua1IJ4iOeSQzDK69rKE6G+TfDyv8d3eBMCoFytVItFjgj8MOlxECA
 cG7q4iUB6az6GJ/XXgNR+TyqYzUGAzgsvXIO/TX0RisD+lxrETEkVNMAgpNlFWIZom
 oHAxvCC5WQL+4fiz5he43aEwidttrWYi+3ZFsp1opZ+4nIch2aJidUxzvZdPrI8e5F
 esg/PpF3Nlp4Kw/hNVe/tBSZSQfjO0wVWYJPQZHfAokFYl1j1S/17Ko51pX6xMQcwL
 I63F64FHxjAm6GOwriA/UrL/7saEI4rjPjNsK/LyGyKIjafMt4vpQd9WbFUop3WSMN
 bFuKfyr3zSQOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] drm/vc4: use drmm_writeback_connector_init()
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723003205.330362-8-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-8-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:53:03 +0000
Message-Id: <20260723005303.B27B61F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `vc4_txp_int=
errupt` handler can trigger a use-after-free on the `txp` structure if the =
component is unbound.
--

--- Patch [7]: [PATCH v8 7/8] drm/vc4: use drmm_writeback_connector_init() =
---
Note: The format of this review has been altered to provide a free-form
summary of the findings due to recitation restrictions. The original patch
code is not directly quoted.

commit d2ba7084f0c0f5d055693e1cdaf9ce77bc6aa242
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/vc4: use drmm_writeback_connector_init()

This commit changes the VC4 driver to use drmm_writeback_connector_init()
instead of drm_writeback_connector_init() to ensure proper cleanup of the
job queue. It also removes the vc4_txp_unbind function.

[Severity: High]
This isn't a bug introduced by this patch, but does the component unbind fl=
ow
leave a dangling interrupt handler that can cause a use-after-free?

In vc4_txp_bind(), the txp structure is allocated using drmm_kzalloc(), tyi=
ng
its lifecycle to the DRM master aggregate device.

However, the interrupt handler vc4_txp_interrupt() is registered using
devm_request_irq() on the component platform device.

If the DRM master is unbound via sysfs, the drmm-managed txp structure is
freed. Because the component platform device driver is not necessarily unbo=
und,
the devm-managed IRQ handler remains active.

If an interrupt fires after the DRM device teardown, won't vc4_txp_interrup=
t()
dereference the freed txp structure?

Should the IRQ registration be tied to the DRM lifecycle, or should the IRQ
be explicitly disabled when the component unbinds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723003205.3303=
62-1-John.Harrison@Igalia.com?part=3D7
