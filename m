Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE2C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3636410E7E0;
	Tue, 28 Jul 2026 07:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="VKs860ID";
	dkim-atps=neutral
X-Greylist: delayed 518 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 01:14:34 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654BA10E308
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1785201264;
 bh=6cap9a2BbfmYlaJIhCTSwao4KweqQOkNFoHm+CXtfQs=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=VKs860IDwmAmnSda7KvlLGZjEPLJiMI9zhfkgOp2ibsEwaz8iNSxBC72pWY1qFB7G
 aimd6EcRZROaXOjJLtujF/sKhtJgFMIqu9IlCpG57TDC6E8QOteErxPhWTCFXbjMDi
 CNqmNKgV3YLxSVfLPGOg8sJ0gIJSgEz8bSSKPDrw=
X-QQ-mid: esmtpsz20t1785200718tda0b9dd6
X-QQ-Originating-IP: WAyoVSiUnM+sYMQp6Xu4ZdivdB7TbtRNuRU9j6RRMMM=
Received: from snode5.. ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 28 Jul 2026 09:05:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5765152889471409520
From: Sterling-Ash <liangbaihui@linux.spacemit.com>
To: Frank Binns <frank.binns@imgtec.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
Subject: [PATCH v3 0/2] drm/imagination: support GPU probe without
 power-domains
Date: Tue, 28 Jul 2026 09:05:11 +0800
Message-Id: <20260728010513.1627950-1-liangbaihui@linux.spacemit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
References: <75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M7wLkObIDn0058inafh+QdCUxERO4c3NprcXTlGSWoejHh42awLhR26L
 zlM97Uk4/pSkrC1Ji0tYYsTij7LuvH3x+QV/8bOaIZ5H+tyuPet2f1ERJRHCOu9l8rR1Tkn
 8CpiI/va9RSBdiUvxaM052mlciMihhufwS3UohcklU/3/NLbd7UaAseWOF89IeYKo80k5eZ
 MKcU1ugdslzxmFWR61GGCuAZ+rch/Ewhgk/ROIAGY26qDbv3FqhX4L9g6e97QR/+vxMD4nB
 diIzGqIc5QsvKk2wRvE3ZeiS/KThyrYoKm7kHniT6YgAeJVp/6y/Pm9VLLQAlEbCRzf9Wg/
 0XTFA9lstFLxVacV26jIGrMQKpmsFSpT+Rooi0nXvuVxyxR/es89YvdzhJ+1CR5BeLoALyC
 BJAvWLNDnrTggZwUnibWd1nTAl+eZa65Vw5nZgEqOIGFaYcdLtcdeSrwtKCNMBjTBnL1Y1T
 UNBpR6NX5cCTV0ChBDcDQAcFixoD/gkJwC4tFTXYuhMJW+au0gNy595Th2O3Fom9bFQDmgZ
 yaKaTX/+4Oh8TYIPA3E9qsmp3DE9CuyI1xy/bhrL81Oy5QIHwT6mMgxCt8UsyDdAUq8ye1m
 /6a6FItEjX7i7nm1Kc8zplZwrXhmxFRfebjczDmU/xA++3RiEuJ18A/cHvd3eHuB9uh3nBM
 dpWiAiPn3P4FbgoUHrDbgoWZVOgy5o7+vWCWGvWi3BKbZRONgTHLHTryN44ym8hHL66jODp
 qtF4OgXfgJiuzq97vGWI1pE2FSuYAMJ5drxEbvsIP/K+69G6kYUnhH30bSxJ+SpGQtyOLwG
 P8p7pNavKXE1jgLBf1bn0RPQrP3O97Cy/a6wpfgjPgw2ZBfHVsRotBrg4sVJffqzhWcIQ9p
 Vweyw5mv9dszguOOD6v69ejQ+Ng7YGgPKk7tui72u2ueihDXCJ+TDRkL+/u7gMBuuYdLZ3Q
 z1sNL6Re709FGLo5JtkxVJoDuJqt0pbOpHNAhWEJiVPQY6QPi+Rh5wg9f
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

This v3 addresses an automated ("Sashiko AI") review comment on v2 [2]:
spacemit,k3-gpu didn't match any "if" block constraining clocks, so it
fell back to this schema's general 1-3 item range, which would have
let an invalid DT with 2 or 3 clocks pass validation even though this
platform only ever has one. Patch 1 now also adds spacemit,k3-gpu to
the existing ti,am62-gpu/ti,am62p-gpu/ti,j721s2-gpu "if" block that
restricts clocks to a single entry, since K3 has the same requirement.
See the v3 note under patch 1 for details.

v2 reordered and extended the earlier standalone pvr_power.c change
per Alessio's review [1].

On the SpacemiT K3 SoC, the GPU power domain is enabled once by the
bootloader before Linux boots and is neither modelled nor switched by
Linux at runtime.

As pointed out in review, img,powervr-rogue.yaml currently has no
compatible entry this platform's GPU can use, so patch 1 adds one
(spacemit,k3-gpu + img,img-bxm-4-64 + img,img-rogue) as its own oneOf
entry, distinct from thead,th1520-gpu since the two differ in clock
requirements. This new compatible doesn't match any "if" block that
constrains power-domains, so that property falls back to the schema's
default (optional) behaviour for it -- no additional required/false
override is needed.

Patch 2 is the previously-sent driver change: pvr_power_domains_init()
treats a missing "power-domains" property as "nothing to attach"
instead of failing probe with -ENOENT.

[1] https://lore.kernel.org/all/75c9382d2bda766aa459b00321153d715254d1a4.camel@imgtec.com/
[2] https://sashiko.dev/#/patchset/20260727012231.1025210-1-baihui.liang@spacemit.com?part=1

Sterling-Ash (2):
  dt-bindings: gpu: img,powervr-rogue: add spacemit,k3-gpu
  drm/imagination: allow probe when no power-domains are described

 .../devicetree/bindings/gpu/img,powervr-rogue.yaml       | 6 ++++++
 drivers/gpu/drm/imagination/pvr_power.c                  | 9 +++++++++
 2 files changed, 15 insertions(+)

-- 
2.34.1

