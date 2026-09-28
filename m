Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80446CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C2F10E5DA;
	Mon, 28 Sep 2026 16:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lEnwEpkb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AED10E5DA
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:31:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BD9560052
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFACC1F000FF;
 Mon, 28 Sep 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790613076;
 bh=b9+3FkzlI/wIWQJcNTEFtgC0MrVxpEcwVbCYCmj7aIE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lEnwEpkbgMvdLF3/EK74V3v15X6gXZIi+Zf856Yrs47RwjjuSgxlT+E79RS2BbbK3
 OILcuPuOCbulZMrVj6umC8YLlyUl2IrsnC01NNU/BSNT+MupLcZLKylkPysghNsTh7
 J4Xp8qB6s2yB0mfvUYvy+sVN+ZFIy7+V8j34TgLy1CsYDPmoxhxMfKfYcvgPAhNG1U
 wBQGm+mULAgCgqdwVhNez4ImjCTdXPqUlnuTrQ6XPza2V2XHXwnWj+T10eivUr3tBo
 P9pNc3qJ5mbwE7QSZSsjt29Znf+xcrGvUYGCtCuHVXRDaukhBGMVeKEw8NAkCpHGcM
 zFM9DN4O7IjLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/panel: dsi-bpf: Add BPF program build
 infrastructure and helper header
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, bpf@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:15 +0000
Message-Id: <20260928163115.AFACC1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/panel: dsi-bpf: panel_bpf_mipi_dsi_dcs_write_byte macro prev=
ents error handling
- [Low] build: Makefile misses vmlinux.h in clean target and uses undefined=
 variable
--

commit 94b9d5177a6ef3a698ad45fa764e652b0d0dbae4
Author: Maxime Ripard <mripard@kernel.org>

drm/panel: dsi-bpf: Add BPF program build infrastructure and helper header

Add the BPF-side header panel-bpf-mipi-dsi.h and a standalone
Makefile for building panel BPF programs. The header provides
section name macros (PANEL_BPF_MIPI_DSI_PREPARE, etc.), the
PANEL_BPF_MIPI_DSI_OPS() struct_ops declaration macro, extern
declarations for all the kfuncs, and some convenience macros.

> diff --git a/drivers/gpu/drm/panel/bpf/progs/Makefile b/drivers/gpu/drm/p=
anel/bpf/progs/Makefile
> new file mode 100644
> index 0000000000000..74190ee618abd
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/Makefile
[ ... ]
> +clean:
> +	$(call msg,CLEAN)
> +	$(Q)rm -rf $(OUTPUT) $(TARGETS)

[Severity: Low]
Will this clean target leave a dirty working tree? The generated vmlinux.h
artifact is not removed when executing make clean.

> +
> +%.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
> +	$(call msg,BPF,$@)
> +	$(Q)$(CLANG) -g -O2 --target=3Dbpf -Wall -Werror $(INCLUDES)		\
> +		     -Wno-microsoft-anon-tag					\
> +		     -fms-extensions						\
> +		     -c $(filter %.c,$^) -o $@ &&				\
> +	$(LLVM_STRIP) -g $@
> +
> +vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)

[Severity: Low]
Is the INCLUDE_DIR order-only dependency defined? It appears to resolve to
an empty string since it is not defined in this Makefile.

[ ... ]
> diff --git a/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h b/drive=
rs/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
> new file mode 100644
> index 0000000000000..e2b03afef2c8c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
[ ... ]
> +/* Send a DCS command with a single byte payload. */
> +#define panel_bpf_mipi_dsi_dcs_write_byte(ctx, cmd, val)		\
> +	do {								\
> +		const __u8 _v =3D (val);					\
> +		panel_bpf_mipi_dsi_dcs_write((ctx), (cmd), &_v, 1);	\
> +	} while (0)

[Severity: Medium]
Could the panel_bpf_mipi_dsi_dcs_write_byte macro prevent callers from
checking for and handling DSI transmission errors?

By wrapping panel_bpf_mipi_dsi_dcs_write in a do-while loop, the integer
return value is dropped. This causes initialization routines to blindly pro=
ceed
even if the panel is detached or unresponsive, as BPF programs invoking this
macro cannot assign or evaluate its result.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D3
