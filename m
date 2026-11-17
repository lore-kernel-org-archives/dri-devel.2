Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D2606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oCDHY0uZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E24510F853;
	Tue, 17 Nov 2026 17:33:29 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBF010F853
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 17:33:24 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so15943245e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794936802; x=1795541602; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=awuFfcelAs0Wjf6OuNr2RgHXNyYZSy8TMqbcVt380gI=;
 b=oCDHY0uZ+uVtpmVERxTbfl/7wUxSHpKVZTEji5bI6miKbpZyESXIbXJUS5bkLPkj5k
 qjLhPJVW7EvCVBJNDgDLj4Fez0ErUlkSOcz+Elmdibhsi5Am5TzVKWlh2XRzvw7tk3Kc
 J/WVrC620i6zzuFz+1y8Z5SgGvh7hzAq/qxzVHP9A0zYhJkwjeV4dodvQwKaNixm/E+P
 MwQHV0SmY5o6WKKxkZaygIKPreHpxdzzzrNQ6eyGCw+K/5kCpsOZXrTLDBsejFB7vuIa
 Yi3qZ4YZmAAyeRUsQXHRsswb2FdXPSJLLKhibuLODz5ImExbCNnjRXg6cQgZb8owLc9L
 t2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936802; x=1795541602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=awuFfcelAs0Wjf6OuNr2RgHXNyYZSy8TMqbcVt380gI=;
 b=1/VmQ2xAQnYEJ9RLWRv2PwuJfcgIIjYltFONn/JKXn1H+qKsGYHHS1N/dJ/hV7jfyN
 emWFeyQOyn4YaFTZS5LPlMA3qCaqhxSAroBSo5yM5njeZbUXYNAnvVSUmXowjNNbRvpp
 4MxFltoItUnxfakrNVAG3tcJYqvO9f0iqgtqmikzKFa2s4b9NVYThUg36n6JNKHbExNm
 IvFcS//NQjQfMKs7eEfYjkTvWEvdB6XOvH2IADasXJagaLEsiSCTqadSAlGq3pxwDxSz
 6B7wa6N4VhnbeTptYnGNngl0RQOzeJtyTF4PVHJQQhDtXRRifIRPsanS4/RiLdOk/JEm
 0vCw==
X-Forwarded-Encrypted: i=1;
 AL+hErGNJqcKy82Ly2zf+AgbjVdk2U1xYEbolXzlwnwD4vTiiUv72arLqZrr4T2Yeb+q8PTdFTKqpc9fwQk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8aUvSb9Y7aEwpBEimUYNrHc4m9kPJkgZe9INO+6H6Y1MZ3unK
 +gmDU28Stz06EH4h5y9oPXjZsqcfgcvJTye/YgnO+uRBI2RZZYrT8qVe
X-Gm-Gg: AYBFou0uhYCClVPJmnfATdkjqAWqCQz0v0HmVEAYRyH4JrFzj5hUc0ZQ/CtEsbMGCv2
 5drCpbJUF33MxRDgPtrbrEZehvmO11DIwJICUGbu7EH0QhxpIXryQp4Bkk9dmO7TyluTav0xaIv
 112x6Sjbl2KmNAobZNX1Cjgev8k4z6XKnCAjEJn1O+lGSnTmDNcoWdysx1mOoYH54zZPrsE9bgj
 v04nUU2hyqDDNhiP73iszIDfHa8uJhw6x52QQS7eXDGuzPLbKDqnx2xocfULR47HuECW0w8cZry
 bHnMknNj3+cOzxX1w+yN/xNEpX+3T5t+EjSthNQFtu1hgLb7boGMnrnAHyurtvpNGrI/QhF11aZ
 FVcUUyC0bVFL67ynA+4hKQTYRmVoYIV+0YQU7C+YnCe04UB6lvFEMsNhMXYU/ZGFNvCXfY7VM+0
 MiMGKpobDIQA9FOcTOl+few9LSf9k65t0UYs40YupNRKRXqoO5VajZqiIrWqau2bAmtO+ynJ0AG
 ZUZ5UW/fGp+fK5jqDGGwg3pR96kr+NUuEu89P+Vr5x6ti8vui29UcxgFY2eUaBW5J9L4B+krz5E
 v5dgudgFyQ==
X-Received: by 2002:a05:600c:6746:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4bb78332fbfmr83538165e9.0.1794936802335; 
 Tue, 17 Nov 2026 09:33:22 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8220sm79269585e9.5.2026.11.17.09.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:33:21 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v3 0/2] drm/panel: add Novatek NT36525 (Samsung Galaxy XCover5)
Date: Tue, 17 Nov 2026 20:33:17 +0300
Message-ID: <20261117173319.1852638-1-tadilhusrev@gmail.com>
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

  Patch 1  dt-bindings (compatible: "novatek,nt36525-xcover5",
           "novatek,nt36525")
  Patch 2  the panel driver

Apologies to Krzysztof for v2: I sent it as a diff on top of v1's own
(unmerged) patch instead of a complete, standalone patch against
mainline, which is exactly the git-management mistake you flagged. v3
resends both patches as full, self-contained patches that apply
directly to v7.4-rc1, with the v1 -> v2 -> v3 changelog moved below
each patch's "---" line instead of the commit message body (also
flagged by Andy Shevchenko on the related grip-sensor series, and
just as applicable here). No behavioural change from v2.

Tested on a Samsung Galaxy XCover5 running 7.4-rc1 plus this series
(re-confirmed 2026-11-17, kernel 7.4.0-rc1-00023-gdcb8b91fb779+ #30):
the DSI panel connector probes and reports "connected", debugfs
reports the reset gpio as ACTIVE LOW, and /sys/class/backlight/ is
present. checkpatch.pl and dt_binding_check are clean (bar the usual
new-file MAINTAINERS note; the files are covered by the DRM PANEL
DRIVERS wildcards).

Based on v7.4-rc1.

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
 drivers/gpu/drm/panel/panel-novatek-nt36525.c | 491 ++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36525.c

--
2.53.0
