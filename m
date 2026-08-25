Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED3C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6598E10E957;
	Tue, 25 Aug 2026 08:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z++TJrDS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED63710E957
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6F89404E6
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610F21F000E9;
 Tue, 25 Aug 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645434;
 bh=b8Q7ZJha4XLYsv2SeAcw5PygZ0sDFh40uoJUqflh0NU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z++TJrDSgfIYV40foip+sgCeeGhyn67cekYIYnD/IUFYs6qh+seWUoJH/WdCF9V8s
 6lsIXvekTVCc8sjD9p0pfo8EFgd8bnGXS1sqbDl8w5OYLq7w3g8/hzVm5/ozU9IWYw
 Ff4Q/gxX0/Wu9U7h67mZLZ84scUJCLr3hpfuxUWXO2viL974RorTlWTremqFYwq7DB
 H+qF8iCFsbFhRIp/YX2p5q7uGoTDejN0NZ8VIC4y1Jy1KB57r5c804ZXo7w04RZbNy
 c5euESHph+ThKs4/mnjRmjes5EHZP+kQVWCivkIGIQdH6+WCzXoOKETn1cLcbrkyVn
 SXcB3zA6YkLmA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/12] drm/fabric: add YNL query and policy selftests
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <19b16439fe5f81ad983082e84f88405506f73558.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <19b16439fe5f81ad983082e84f88405506f73558.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:33 +0000
Message-Id: <20260825081034.610F21F000E9@smtp.kernel.org>
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
- [Medium] harness_reset_abi.py races with its child process when resolving=
 the Generic Netlink family, leading to test failure on a fresh system.
--

--- Patch [6]: [RFC PATCH 06/12] drm/fabric: add YNL query and policy selft=
ests ---
commit 095db697e4004f927fd42e79eb88a4bd06030771
Author: Konstantin Sinyuk <ksinyuk@kernel.org>
Subject: drm/fabric: add YNL query and policy selftests

This commit adds eleven kselftest programs for the drm-fabric Generic Netli=
nk
ABI. These tests use the in-tree YNL client against fabricsim to cover paths
like policy validation, multipart dumps, and family introspection.

> diff --git a/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset=
_abi.py b/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.=
py
> new file mode 100755
> index 0000000000000..211613185a39b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/gpu/drm_fabric/harness_reset_abi.py

[ ... ]

> +def test_sigkill_topology_recovery(ksft, cfg):
> +    """A SIGKILL-leaked switch shape must not survive the next entry res=
et."""
> +    # 1. Bring up the switch shape in a helper and confirm it is observa=
ble.
> +    child =3D subprocess.Popen([sys.executable, "-c", _CHILD])
> +    try:
> +        fab =3D L.DrmFabric()
[Severity: Medium]
Is there a race condition here on a fresh system where the drm_fabric module
is not yet loaded?

The child process executes a script that calls insmod('drm-fabric.ko').
However, immediately after spawning the child, the parent process calls
L.DrmFabric().

Since L.DrmFabric() synchronously resolves the generic netlink family,
wouldn't this fail with an NlError exception if the child process hasn't
finished loading the module yet?

> +        loaded =3D L.wait_until(
> +            lambda: L.module_loaded("drm_fabric_sim") and _has_switch_pe=
er(fab),
> +            timeout=3D10.0)
> +        if not loaded:
> +            child.send_signal(signal.SIGKILL)
> +            ksft.skip("harness-reset-sigkill-recovery",
> +                      "helper could not establish switch shape")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D6
