Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CF5CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD0610E00F;
	Tue, 13 Oct 2026 14:52:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480BB10E00F;
 Tue, 13 Oct 2026 14:52:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 760D460A52;
 Tue, 13 Oct 2026 14:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276071F000FF;
 Tue, 13 Oct 2026 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903133;
 bh=kYokskwFXqmZbxKXA0hYcmteDiHu4dzWazXznQi6jas=;
 h=From:To:Cc:Subject:Date;
 b=maz/NfDLUqWVk46kbQMUYi+byb8hig2awtRci3j40GQMdgpsPuS0sCFthj5FFvq1n
 WBd+9CZfIpchLU1v2GvSoK418B55YxWRRVnYYJVBYdjT5KEAW3+IM0AchnSIuo3yaA
 w0hymCfISUgZUKjEHm1Xc2oh30ec4DIi890rilGsmcqHM9p3/NuNe88UKXFgWlRObE
 Gm8+In9FCU9xPAZlJ6EiJ1gnKqqt3neOvnQsDDduqrMA3v3KWZqcRFdNjyd9dsAqLJ
 WgI1UXnTeXyC6Cq5jiqiQ7F6914ahbIIdPSttuKaJwiGHVjlFGljGu9DaRq5Ne5Q3v
 as4m/OI4y0Slw==
From: Sasha Levin <sashal@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/3] dt-bindings: gpu: nvidia,
 gk20a: Allow a fuse clock after the reference clock
Date: Tue, 13 Oct 2026 10:52:08 -0400
Message-ID: <20261013145210.103565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

GM20B needs both its reference clock and the fuse clock while it is
powered, so allow "fuse" as a fourth clock after "ref".

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
index 4d856a8b674c..ecbc20e6adec 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
@@ -44,6 +44,7 @@ properties:
       - description: GPU clock
       - description: Power clock
       - description: Reference or fuse clock
+      - description: Fuse clock
 
   clock-names:
     minItems: 2
@@ -51,6 +52,7 @@ properties:
       - const: gpu
       - const: pwr
       - enum: [ ref, fuse ]
+      - const: fuse
 
   resets:
     maxItems: 1
-- 
2.43.0

