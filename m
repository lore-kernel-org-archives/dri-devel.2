Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4ECC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5604410E038;
	Tue,  4 Aug 2026 20:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ksyECih7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1736D10E038
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:47:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22E35600AA;
 Tue,  4 Aug 2026 20:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68ED1F000E9;
 Tue,  4 Aug 2026 20:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785876457;
 bh=6BREG63RRWAZUSYgCD5PUkqHW9VmWLsqlKlI/0nGvyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ksyECih72rsLOJYubekIx1RRNhX+MEggA1R2fet2DoTNLs88RNWT40uIkFSoGpNAj
 gWd/0r75RnkUQtwUxXoZMs7zWliK+gPUrVJVtUrIgJ68rlFeJmIBy4d0qjWkmlbFBi
 MaWQgN5uBMLwMQAiACVLJfOCR5oUUmvZeRbBGQ6dbsQf3JBZjVps3s5sK5I7XmIF9r
 8nv9Ei6tvAIzpOA5hu+d0a7q4MnZwx+mafg7abJWxRlnk4mEmvUTRHr//jjKXbA9zz
 Q4cjzyU3eWzedhxt5iAmLyuEGyr3H4KlKvn+U/aYas+zZP2ayjGYWiUXVK6me0MAhO
 ONlwHy5wdnrtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] drm/vkms: add script to create optimized LUTs for
 color curves
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804203351.148521-11-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <20260804203351.148521-11-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:47:36 +0000
Message-Id: <20260804204737.A68ED1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional GUI plot generation and matplotlib import block sc=
ript execution and break in headless environments.
--

--- Patch [10]: [PATCH 10/11] drm/vkms: add script to create optimized LUTs=
 for color curves ---
commit eeb1a305fab717b385cfb6fdf6633f43f03c3b5f
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm/vkms: add script to create optimized LUTs for color curves

This commit adds a Python script to generate u16 LUTs for VKMS color transf=
er
functions. The script compares different LUT generation strategies and outp=
uts
the generated LUTs as C arrays formatted for vkms_luts.c.

> diff --git a/drivers/gpu/drm/vkms/scripts/color-curve-lut.py b/drivers/gp=
u/drm/vkms/scripts/color-curve-lut.py
> new file mode 100644
> index 0000000000000..f80e67120f5b3
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/scripts/color-curve-lut.py
> @@ -0,0 +1,561 @@
[ ... ]
> +import sys
> +import os
> +import time
> +import bisect
> +import math
> +import numpy as np
> +import matplotlib.pyplot as plt

[Severity: Medium]
Will this unconditional import of matplotlib crash the script in headless
environments or CI pipelines that lack a configured display backend?

[ ... ]
> +def main(args):
[ ... ]
> +    # Save the greedy subdivision LUT as C arrays for VKMS
> +    greedy_lut =3D luts[2]
> +    emit_c_arrays(greedy_lut, func_str)
> +
> +    # Plot the LUTs... kind of useless when we have a big LUT, but still=
 good to
> +    # visualize with fewer taps.
> +    fig, axes =3D plt.subplots(1, len(luts), figsize=3D(15, 6))
> +    for i, lut in enumerate(luts):
> +        ax =3D axes[i]
> +        ax.set_title(f"{lut.name} - {func_str}, LUT size: {lut.lut_size}=
")
> +        ax.set_xlabel('X')
> +        ax.set_ylabel('Y')
> +        ax.grid(True, linestyle=3D'--')
> +        ax.plot(lut.x, lut.y, 'o', color=3D"blue")
> +        ax.set_aspect('equal')
> +    plt.tight_layout()
> +    plt.show()

[Severity: Medium]
Does this plt.show() call block execution indefinitely until the GUI window=
 is
manually closed?=20

If this script is run as part of an automated workflow, this could cause the
process to hang. Could the plotting functionality be made optional and put
behind a command-line flag?

> +
> +
> +if __name__ =3D=3D "__main__":
> +    main(sys.argv)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203351.1485=
21-1-leandro.ribeiro@collabora.com?part=3D10
