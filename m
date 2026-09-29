Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14570CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FA510E213;
	Tue, 29 Sep 2026 23:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QwyawEuO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07FF10E213
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:44:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B8D860234;
 Tue, 29 Sep 2026 23:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786CC1F00893;
 Tue, 29 Sep 2026 23:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790725490;
 bh=YNLY9h/lESi+DJlGbg7hdoABGxfqloa2+qriVaM34lg=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=QwyawEuOSXJhWe1rKmIBygCQtqJ84CZXc7XkiZ/r9UiCWX8ZbRwxK/XF94ZRJG3g3
 XykA1gCrLKF0r46vluzPiXkYdXh7M0p6Enuvx8TIMiAyEdvxTSYQ7C1GGsDl74tcAc
 MIVZaaP6MtBfjsh1vIQ0damlciywgP2IOu1QThcx8N3TQLEk4JN8lN6wPiQ828R22o
 1zNKK0gRaJSKrL9izB8ljUNnKoOw26VqWmuEI8vVtdkcSheZmY0Ibxeacok7R1yiKq
 AU2oD+k+UfWXUnbkMSrWbgWP1CRa1RbeC5wPXxqlbrsMsMmyK6HPtpw7NKQBobqPi5
 GCn7abJjXVIHw==
Content-Type: multipart/mixed; boundary="===============3190992738228849883=="
MIME-Version: 1.0
Message-Id: <052fc5fccb1cfb3a9bb4751e68080c92bc0e1759be9d1dc42972f2fe6f822976@mail.kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-3-5244926aace4@kernel.org>
Subject: Re: [PATCH 3/6] drm/panel: dsi-bpf: Add BPF program build
 infrastructure and helper header
From: bot+bpf-ci@kernel.org
To: mripard@kernel.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 luca.ceresoli@bootlin.com, aesteve@redhat.com, dave.stevenson@raspberrypi.com,
 javierm@redhat.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, mripard@kernel.org, bentiss@kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 23:44:48 +0000 (UTC)
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

--===============3190992738228849883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/gpu/drm/panel/bpf/progs/Makefile b/drivers/gpu/drm/panel/bpf/progs/Makefile
> new file mode 100644
> index 000000000000..74190ee618ab
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/Makefile

[ ... ]

> @@ -0,0 +1,93 @@
> +VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
> +		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
> +		     ../../../../../../vmlinux				\
> +		     /sys/kernel/btf/vmlinux				\
> +		     /boot/vmlinux-$(shell uname -r)
> +VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))

[ ... ]

> +vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
> +ifeq ($(VMLINUX_H),)
> +	$(call msg,GEN,,$@)
> +	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
> +else
> +	$(call msg,CP,,$@)
> +	$(Q)cp "$(VMLINUX_H)" $@
> +endif

Does this build work when CONFIG_DRM_PANEL_BPF_MIPI_DSI=m?

The Makefile generates vmlinux.h from vmlinux BTF only. The BPF programs
need types defined in the panel driver: struct drm_panel_dsi_bpf_ops,
struct panel_bpf_mipi_dsi_ctx, and the panel_bpf_mipi_dsi_supply and
panel_bpf_mipi_dsi_gpio enums.

DRM_PANEL_BPF_MIPI_DSI is tristate and becomes =m when CONFIG_DRM=m
(the case in arch/arm64/configs/defconfig, the Raspberry Pi target).
With =m, these types exist only in the module's split BTF at
/sys/kernel/btf/panel_bpf_mipi_dsi, not in vmlinux BTF.

panel-bpf-mipi-dsi.h declares PANEL_BPF_MIPI_DSI_OPS(x) which expands
to "struct drm_panel_dsi_bpf_ops x", and uses PANEL_BPF_MIPI_DSI_SUPPLY_*
and PANEL_BPF_MIPI_DSI_GPIO_* enum values. Without the module BTF dump,
the struct is incomplete and the enums are undeclared. The panel programs
added later in the series would fail to compile.

The commit message says the Makefile follows drivers/hid/bpf/progs/, but
that works because HID_BPF is bool and its types always land in vmlinux
BTF.

You could either dump the module BTF:

  bpftool btf dump file /sys/kernel/btf/panel_bpf_mipi_dsi \
    -B $(VMLINUX_BTF) format c >> vmlinux.h

or define the ABI types directly in panel-bpf-mipi-dsi.h, as the bpf_testmod
selftests do.

> diff --git a/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h
> new file mode 100644
> index 000000000000..e2b03afef2c8
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h

[ ... ]

> diff --git a/include/drm/drm_panel_dsi_bpf.h b/include/drm/drm_panel_dsi_bpf.h
> deleted file mode 100644
> index 02d4707fd0a0..000000000000
> --- a/include/drm/drm_panel_dsi_bpf.h
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __DRM_PANEL_DSI_BPF_H__
> -#define __DRM_PANEL_DSI_BPF_H__
> -
> -#include <linux/bpf.h>
> -
> -struct mipi_dsi_device;
> -struct drm_panel;
> -
> -#define DSI_BPF_PANEL_ID_LEN	64
> -
> -/**
> - * struct dsi_bpf_ctx - Context passed to BPF panel programs
> - * @panel: The drm_panel this callback operates on (private)
> - */
> -struct dsi_bpf_ctx {
> -	struct drm_panel *panel;
> -};
> -
> -/**
> - * struct drm_panel_dsi_bpf_ops - BPF struct_ops for MIPI-DSI panels
> - * @panel_id: Device identifier for matching. On DT systems this holds
> - *	the panel's compatible string. Firmware-agnostic to allow future
> - *	ACPI support. Written before load, immutable after.
> - * @panel_prepare: Called to power on the panel and send init commands.
> - *	Must enable regulators, toggle GPIOs, and send the DSI init
> - *	sequence. Sleepable.
> - * @panel_unprepare: Called to power off the panel. Must send shutdown
> - *	commands, assert reset, and disable regulators. Sleepable.
> - * @panel_enable: Optional. Called after video stream starts, for panels
> - *	that need post-video-start DSI commands. Sleepable.
> - * @panel_disable: Optional. Called before video stream stops. Sleepable.
> - * @set_brightness: Optional. Called to set backlight brightness via DSI
> - *	commands. Sleepable.
> - */
> -struct drm_panel_dsi_bpf_ops {
> -	char			panel_id[DSI_BPF_PANEL_ID_LEN];
> -
> -	/* private: internal bookkeeping */
> -	struct drm_panel	*panel;
> -
> -	/* public: */
> -	int (*panel_prepare)(struct dsi_bpf_ctx *ctx);
> -	int (*panel_unprepare)(struct dsi_bpf_ctx *ctx);
> -	int (*panel_enable)(struct dsi_bpf_ctx *ctx);
> -	int (*panel_disable)(struct dsi_bpf_ctx *ctx);
> -	int (*set_brightness)(struct dsi_bpf_ctx *ctx, u32 brightness);
> -};
> -
> -#endif /* __DRM_PANEL_DSI_BPF_H__ */

The commit message describes adding the BPF-side header and Makefile, but
doesn't mention removing include/drm/drm_panel_dsi_bpf.h. The header was
added one patch earlier by 095e3b42d5ca and contains a stale ABI definition
(struct drm_panel_dsi_bpf_ops with dsi_bpf_ctx) that conflicts with the
real definition in drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h.

Why is the file being removed as a side effect here rather than being
excluded from the earlier patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36644629998
--===============3190992738228849883==--
