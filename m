Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78260A6F61
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUgKrXdB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3F810EC47;
	Fri, 13 Nov 2026 16:18:54 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C8410EC5F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:46 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so273628566b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586724; x=1795191524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y+KHlKsszZZuhdaqagwVxvQeZSNU/AaISBE1dxzUs48=;
 b=IUgKrXdBQ0Dlfgej5n3Gec29AcDAWt/o27DEo+GMF3K5mCJH58VZgjUl6SP65Ti/0f
 Z89X3e3HAGJFWZ7CzG8KDkAB3O5dae88OwYKsWAazke1I2oA63nfKpHEiiWnJtBz4pS0
 f/6uril/VJraR7ajD3GdvcfN/UFhyj4bqpFdA2uQOBRVoKQ1i4tjyndEpZbQ6R704g8j
 /Z29Pe6RfADjEhyX3KFO1BKABiB+iJixZbrH2+90RyvRoI2Q5i2kDNL6JEsQbz4W1RSo
 0sGv7Nwp3rh5sZBczmrlAu/2RhvNHuoFYLxHguNIuxbv953TqcayMvLpbdyAtmUfDdID
 +9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586724; x=1795191524;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y+KHlKsszZZuhdaqagwVxvQeZSNU/AaISBE1dxzUs48=;
 b=N2UeDTmjTqWLCEix/AoApgXMia/jYmPKtZmKnGmx/FMD0wl+3F3ENNW0+k4onVXAtZ
 VqFUjsXHbk+olVraYx2bCaSTQjcRimwov+P0cxT5+n6EOqyf+wGVup8c0Aa8HwwnpxwJ
 b3uDQLFQPozMTuyohycEMqe8eFSzcV9n8tDmffXlHUhTitjL65wG1b+QrequvUzZ9W8K
 dHQU4F1hHNjA5EiqTRecmeqD4QOizSqdoSIqWkNSWpj3fxwq/BD91h7LRsaoBIW7ahe2
 odVg04REj5bzH3YrUXr/IEN+EUSzWoijOyvuZ+3bDsfKrSP0xzKvq/ZEsNUfpYNJjdM8
 stDA==
X-Forwarded-Encrypted: i=1;
 AL+hErFV0sRKAv/bDm6KTUgUoSx6LwgDYlOp/W4YbiisKQ/7e5asJrUq9DY0cTsyTHOpj+qVSA6BVnbCXzE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Vm9WjqLXsGbCFNO/N4VoWkW/PWr/uIpL4BiwEHGctOrOlPnmZ
 nzLeGu9r2/+7EQOGYyCRKDWidSxw2YFQfLBlBf8ZQolJB/Ol9IIUfdfj
X-Gm-Gg: AYBFou3GVwEZ/YA391BN1kBTuFredAagEwpLfhulL+/maLLLyLDrExX32ahPn8TuesO
 K427JU0dSwRJfa4RKBY1ujMtBCEQwuVqNBCJnBW9Pr+fGEnKT2g3jdT4UlgKYsA0D9hJeW3xfpX
 PD7YDZi6og9gOO9BSXp8PBQSUFgRHk9aOkks4WdMdEdp03aAkA0lyFCD1XVMW5N1D1LgZC5aioV
 waFAOgBuwI4lM+UBqK3orO3dItnFNUp0NXotIaxTsQsnzR2zBUVa1UlVrP6NRZMgu91rC/MjuC7
 tTtufpruGNF3GRPvFPmclgLx5dpKP+WTvUza5OxzWqUWxocPKw/qgzfn4Tr3tG3jH6A2x8NBECZ
 4az8C3HtO2yo0GNN6rEYRFAPYmOqvh2DgYoGFl3LTY/nmCqQf2u3vIBpaXR6Hd9OPsDo67lgQi0
 eS/iTqyJiXVC9TN5nAX6RZWHOC1GZY0SRpKM+HulmivwUjpyuXqyBKJ05VrsluUs11s5DmKC0uY
 /IS1ugM+ZWJtT3WRuofnKO9w0AMTA0FLtScCpQzccMXNaBLMGQdUDMj/sVVYSkhhELRnRm1fNPa
 dTqb6ExtAuQKqh8T9UCnuqM74OaWdgcSKY9xKZo2i1qYlpa5ff+YX9/tEPF8O3oERt+MZY4vIbU
 /MbY4ZMAKazU=
X-Received: by 2002:a17:907:3f20:b0:c46:c3ad:e1ca with SMTP id
 a640c23a62f3a-c5096396effmr277084266b.9.1794586724367; 
 Fri, 13 Nov 2026 08:18:44 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:43 -0800 (PST)
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
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 02/10] dt-bindings: display: tegra: Remove Tegra30 fallback
Date: Fri, 13 Nov 2026 18:18:11 +0200
Message-ID: <20261113161819.36847-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
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
different programming model than Tegra20, the maximum VI clock differs by
nearly a factor of two. Additionally, Tegra30 does not require the
APB_MISC workaround.

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

