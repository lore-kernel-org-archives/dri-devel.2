Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E066606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlK5P2Sv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE6C10FB97;
	Wed, 25 Nov 2026 11:26:55 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD16610FB92
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:32 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6ba1e22ff4dso6653846a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605990; x=1796210790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g6WheGrEKozXa+Lv+Pc9T/hQQN8VmqyBg/NVOB1TtcE=;
 b=nlK5P2Sv0PYfPVTQLzdIyBYNRT1dh4OI8ZOpf4iPvfn6FWXIKQbOYXqL6CdycZyOLS
 Azp/rbIqi3P6atQcMvzJru7lUlnY988w+CEDFeVD9cvZ0YcvQfTtjwu3hsH4fsb/cjvv
 AbgHlD9fQTLvrZPykG/ClWCC4widFpS16Pj4LVBw516c5PCc1lZd1fkSdSXMHCZPcyNf
 DEgvKPKM9UiFrwUhnAqZlcbL0d0WuoZDc24qR8+DpUhHD/lg+g2gg9FQAsbveqPFHPNm
 DivhJm4Onz8CefDKU6JcY4istwEl9OW+RYUu0dIS1TjGAp76HgkATCp0dndZJitB4UGF
 Mi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605990; x=1796210790;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g6WheGrEKozXa+Lv+Pc9T/hQQN8VmqyBg/NVOB1TtcE=;
 b=AAmG7RlaB9L6pOhjWwkOPbvj8To5cuJSI9OJ7AdMxqyRNOBukaZd8aR0oAg/imDgAd
 g4qbI/c3/omqnpG16n1wyvOVrHGpl1GygC0kDkCvtZL+AlCUuM5SsFZGY4Yq4z+yP56i
 8k26UjvcGPRaeOHzXiJDRedX+DMxYik9lraFaWjHbeXAJXHi9tO12LbZDRJ3yvHNmu7F
 oFAh8dKynBWru9aKbC7GeMmYi9AyIcG8TNPAHAB8986c5EAXmVnH/qdRNn44daE2rR6P
 s3UkRMVrzTOpFBZLMAXUy8fkr51/BbiVrjOHfUIHOWRfdpEC4NnZPGa5xSoK9ovjYh3J
 Ml6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGgBW0y+YhTNI8Ekav59J8ojdcDs92QiXyoZ67zTK1YlX9kpsfYB3K5x3nG2IN6Xq3dfiEWPyrBC68=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+adsmb3PGOgKNth1N3s0JVmdEG4FKGdqBZkGTynxaw/wNsrex
 b2mGM8TQkZrib/kzA1B/0sosaq5kSx25gaMVBPjXugUjufMVZ4WKsff1
X-Gm-Gg: AZFdTZeDWLeKAJr6WUfiPz2GNdHDSP5CoYBBagJ0xvORlMOp3U+pdgZMbwJ/WYDuim2
 efR92951KQnYQS5hGppXe3FMjnvmzembDwBIdijrItAWEpwQBr3PRYyjTzoBUF7Mv0WehnUCG6H
 hH+FvYWkazJ/+cUqi3Ijngja8PWWnJoNRCe6p4l/6JDVFC98nx/s6uWR3hD30VE7iKbkGBBRgPu
 28AWUHrt33HVNlRqQCPD6t+FZ5j3DJ44awAHiPP7BMr/zt/IWyCaE5QFquVnV2c/GppDem+H+Z9
 +ywkv73nOBPyZ7o+kRVkcxG7EM1tkMZlypjQ9j1NuSL8nLOHLmdYuxDUK1WDRUBhQQ4+O2S/klX
 C2ZZpMxnFPqCUkOcA1FgCKA8HKdYj1g94tiU4dRr3OfyGsywKu5YG9PwcYTtBfykLW66lfxkGRE
 USglFNDSS9PabDldcL8qJsLKU9pcuiFAF689oqUwO0fUx6MRmmunwfH70FQkux8aVrr/UXjHKz2
 dqrr3GBLblpRcSVe0W1yPz0owSaO5apYB9bd/b9msZIqvNAbpI6Rdzm4rj/0eO7avYq30DEpugX
 IFIs9PQRZypuqwo87PHr+io1yTOx02JyxucIk9+d+T9XnFF46FflBW+BHCRorT0NsotfQxe1vXB
 Jsrs9oQpXBg==
X-Received: by 2002:a05:6402:4028:b0:6bb:2a86:1a58 with SMTP id
 4fb4d7f45d1cf-6bb2a86201emr1407592a12.43.1795605990172; 
 Wed, 25 Nov 2026 03:26:30 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 1/7] dt-bindings: display: tegra: Remove Tegra30 fallback
Date: Wed, 25 Nov 2026 13:26:07 +0200
Message-ID: <20261125112613.237333-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125112613.237333-1-clamor95@gmail.com>
References: <20261125112613.237333-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After further investigation, I have found that Tegra30 requires a slightly
different programming model than Tegra20—principally, the maximum VI clock
differs by nearly a factor of two. Additionally, Tegra30 does not require
the APB_MISC workaround.

Therefore, remove the fallback compatible and add a dedicated compatible
for Tegra30 VI.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
index bb138277d5e8c..2d5538a1804f9 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
@@ -18,16 +18,13 @@ properties:
     oneOf:
       - enum:
           - nvidia,tegra20-vi
+          - nvidia,tegra30-vi
           - nvidia,tegra114-vi
           - nvidia,tegra124-vi
           - nvidia,tegra210-vi
           - nvidia,tegra186-vi
           - nvidia,tegra194-vi
 
-      - items:
-          - const: nvidia,tegra30-vi
-          - const: nvidia,tegra20-vi
-
       - items:
           - const: nvidia,tegra132-vi
           - const: nvidia,tegra124-vi
-- 
2.53.0

