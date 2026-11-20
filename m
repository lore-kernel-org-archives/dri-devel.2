Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F1606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWbUDaAP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3FE10E069;
	Fri, 20 Nov 2026 11:41:12 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D9710E069
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:41:06 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so8925455e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795174864; x=1795779664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D3sYdKhtwMz2Ymepp70k+wJP1lW04BDHKmEdKLXQ/0g=;
 b=IWbUDaAPSm4WVb5bpJ5w6M28RPeTGOT4t8tHXstRMjaq6fBvCDkloHC1vyfkW99b0B
 DbYVSxZ8nzLkJMavEqInB+2NjXu8FZk84GhJ0y69lLTiqnfh0n461NAf3uDO5izEsj4J
 GKHZ5qM5uF0jugitl5L9t+xkcRsZG9b/wIt5w9iehhATthbFdZASkZ3ZOw6wmCx2VZG9
 DWx4RyiJGdUvTcLSDTSUUZu9ZrptgYCNvcTZu9k10zNvPqQ2GkpQmzBjF+jPrIl8EtvK
 PIfjYeMb4rb6pIjjORLPoAV+0/rqXTCWaHaEH/vbYQEPFX9MqRFFNSLP/WrIO41q8ssQ
 51hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795174864; x=1795779664;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D3sYdKhtwMz2Ymepp70k+wJP1lW04BDHKmEdKLXQ/0g=;
 b=S3J43C/ZuDS5v/FIJIj6ZTWltWCDhjTDl9/DnDb4yoqbhjJJlD3CQbwJOmLRQn1kGd
 7zYFsKo51QcGKY7w4zbEU1LJqCM43deGxg+8XFmemYwJH1pTIs3phUOUaqm0IwMSGNSf
 VrBzBIwbUBmqzZ+FVcrNQ/rsUJqWgOckGPqOr8irOssbD7sscjMX+I1fIRhvK8YaSWn5
 8XuL2uEBpuLyKblPmotJ1gO+9uiQWC834kdtWD498hxgpbEZpaN6kRBRtEG15D0LjqmM
 6HTwFsHsHsOjxCW1KEjUWHbwN4BvGa2otULGtKA3s2osJcOdwDDmueF93vbhlDJD6x3l
 5p+w==
X-Forwarded-Encrypted: i=1;
 AL+hErGVm1JdFOUqND5dFcho2wde/3P3U6HvR8EYeHfN1dE8fa438yjULXwg5hxvXFku9IbBwkz+cYfQF2g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Up2L2qe3b9da/cQpj+RYnkUy8OrQCGmd9TvT9fRwKnvG9Fn29
 Hz/g/859G42AUSwQ7a0jx9QVfjjdgTBzf6aPEQcx2PeDLJPZshZ43ZTm
X-Gm-Gg: AYBFou2g0E/Pv8/Wovadbfi1bI+XtPomduRW/5PbBDV6BX0YpeFDo707XZre3J5e5wq
 ByGb/h1fBzesiDc/o6LP2GVgLg1en6zJygEAPuoWtiWOGJUoQl6oEPq0DeomDmwLSvoPqHfTagN
 Thcuo7dcx6gYdDWJnITuiTGsnv1pw2q4rDOU2YrFqbMCdhuUNQYDLjvyIcbGbr53oaRFcM/y+9h
 qH+yQt2YexwlX39j4pcdHyu/gUUw+ztBjNxqnpJFWPOa8QoAubhHm74vSBoxgnWyLuuJ4K8BypD
 7aIWClw3znFXQXZJq4PFPjDcd3EiLToSfczKip6adDAymuwGJocp/ls7ogtQrmxZUYjugWV2u5o
 fL/ZOsxi/OJhwAjKvRcZJ96I+jZkjj1a/1Z8jduvM/9i19HT/OSX8ogzH4rdVYRVPKfmvxrcE74
 /jMfncl09TmA/jafkvEujXQN1El5f0yXCncoIErYov0ObLUberc7avVjPGLUjsPr/HwFxNF6Aiw
 i3ANJdXUPwdRh7Z+JBg93Mcichvaa2zfjmxyJLh34wzPjVAv10yrtpPxo8GmwuuXCsDVsmWNYl/
 raTBBodtkPIegB/F8ypATbu7JA==
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id
 5b1f17b1804b1-4bb887c3428mr62096785e9.1.1795174864114; 
 Fri, 20 Nov 2026 03:41:04 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8d4f9aa8sm27419345e9.4.2026.11.20.03.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:41:03 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, u.kleine-koenig@baylibre.com,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v4 0/2] drm/panel: add Novatek NT36525 (Samsung Galaxy XCover5)
Date: Fri, 20 Nov 2026 14:40:58 +0300
Message-ID: <20261120114100.978148-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116070212.314228-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a DRM panel driver and its DT binding for MIPI-DSI
video-mode panels based on the Novatek NT36525 controller, as fitted on
the Samsung Galaxy XCover5 (SM-G525F, Exynos850). The panel is 720x1480,
uses an active-low reset (RESX), and a DCS init sequence that mirrors
the stock Samsung bring-up. Backlight goes through drm_panel_of_backlight().

  Patch 1  dt-bindings (no change since v3)
  Patch 2  the panel driver

v4 addresses Uwe Kleine-König's v3 review comment: drop the unneeded
<linux/mod_devicetable.h> include (it is pulled in transitively; this
driver's of_device_id/MODULE_DEVICE_TABLE(of, ...) still build clean
without it).

Adding phone-devel@vger.kernel.org to Cc per Ivon Argel's suggestion
on the v3 thread, so the relevant ecosystem developers see it (not
adding Ivon's own address; he asked not to be personally Cc'd).

On Michael McAllister's offer to add Moto G10 (DJN NT36525B) support
on top of this series: happy to see a follow-up patch once this base
driver lands; I'll reply on-list separately rather than hold this
series on it.

Tested on a Samsung Galaxy XCover5 running 7.4-rc3 plus this series
(re-confirmed 2026-11-20, kernel 7.4.0-rc3-00023-gdcb8b91fb779+ #32,
after rebasing our local tree from 7.4.0-rc1 to the real 7.4-rc3 tag):
the DSI panel connector probes and reports "connected", debugfs
reports the reset gpio as ACTIVE LOW, and /sys/class/backlight/ is
present and readable. checkpatch.pl and dt_binding_check are clean
(bar the usual new-file MAINTAINERS note; the files are covered by
the DRM PANEL DRIVERS wildcards).

Based on v7.4-rc3.

Tool usage
----------
This series was developed during XCover5 mainline bring-up with the help
of an AI coding assistant (Claude Code, Anthropic). The assistant converted
the vendor init stream to mipi_dsi_dcs_write_seq_multi(), drafted the driver
skeleton and the DT binding, and drafted these changelogs. I reviewed every
line, validated the binding (dt_binding_check, yamllint), tested the driver
on hardware, and take full responsibility for the contribution.
Prompt summary: "convert the XCover5 NT36525 vendor panel init into a
mainline drm_panel driver plus DT binding; keep it checkpatch- and
dt_binding_check-clean; test on the device." Review comments are welcome
and I will answer them myself.

Adil Hüsrev Tepe (2):
  dt-bindings: display: panel: add Novatek NT36525
  drm/panel: add Novatek NT36525 panel driver

 .../display/panel/novatek,nt36525.yaml        |  83 +++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36525.c | 490 ++++++++++++++++++
 4 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36525.c

--
2.53.0
