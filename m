Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C20FF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C5710E522;
	Sun, 26 Apr 2026 06:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Quw7BbfE";
	dkim-atps=neutral
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com
 [74.125.82.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE3310E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:18 +0000 (UTC)
Received: by mail-dy1-f225.google.com with SMTP id
 5a478bee46e88-2d891442388so14257534eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086618; x=1777691418; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qyy2EUSFHuUvP8vn408rgcFPQdBTOKcJ9K4PyZHCKk0=;
 b=Quw7BbfEhtYqVBK0tmk44KZPWv/o5GXYPiq6Tt92Mi3BwArwlcbEYcYoCM6plLkTa5
 vhpD9MVEDkTxpvjxKmnkVNqSePcOR9vRp0QSgBneiuz80gafjMyjS2RPfBlSI1K0poli
 u9FAADj9MEwF2+tdcw439KlmbRlVwSzCyY1DqcIhtRbWGl/L0tNw2vXidglAvtJH8JyG
 Su1UvCJ+HemEOuySMmG7CW4INSu1Cole5gtlVDRsXPJvuqF9wLqi7npBI7WGeRycVysI
 Ey+oa5UjiELrB+VKcWlD3agacPq1cGAZtYd+ofiWvcfL0jNUYQ+9Gp4GQStWa2VL2ZMy
 x4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086618; x=1777691418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qyy2EUSFHuUvP8vn408rgcFPQdBTOKcJ9K4PyZHCKk0=;
 b=ooVasRYKnLQ6wJm+Y5fuZMWSpiXdfmTPZk5dNTb2UHz2lb5uzY+IZSmlv7jmahoXhM
 QSIRATzQA2mLbjy8InTI9PyVk6O1bCcKmNUxmIedV15lU5+YGqTC6SkWuZE8Svbk6B1E
 RDwxMV9DpW0Jm9GsPxyjiO6v6PW2aYCCyNfsK+g9ukhw1ZlBylqFhyCEFvcZaQur0qXM
 Ll7Y7Ua090DKouekL+427WSrvf8362Ed98NhptLrPogMW4hJffkUZ9bACOr4islNYXCY
 ghrGRUfXoOfSQlNxScJNi6WjSWfn8UEwBmm2UIa4SkM9JpTUO5oLREhVW103s0C2gNnE
 KPTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Jn440lNhDXpEbo3KzLKY8dxdUhK4WlGdk8dy9nRmlIaobH+p3qvJWSgMxPpm0a5cUqS+jz9+sN3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxf9GskCHXFxyK2IILu8OBUP9DbbQbb9fyoB9HQOa7dc7ui7UEP
 Bp6IciC1C5ZBpSXU6aUJeWyGJcDGDMJM+8r81XDrk2o7JCzWd2ciaX916C8i5rk8pVQWhXsQOpK
 RuQ19ERpRQjzao7RcCIP+pLHxklP1dqLG2BDB
X-Gm-Gg: AeBDies+OQrFXJE9n/PczlpQXmt/IZQriL6266rNZdu19kck0kY7W1ILBkn58+lZdwt
 nDycXBVlS6F8kr4zuFlgf9VXQuEBGwC8raiYkRm5EWcuwz64B6lnwZIW9HUgAKTaLS6lttlBxaB
 /yFXoZKESGrsvljzwReqpm187IKXaEXLzrywQRzKPIFVXtl9ZHwaWeuxTxobcirgp/vsra5yIPd
 sOdOfaZtyEErbPkilQdkYxAWXJ7BIpG1f4DF29FglGNQuYrdBdmnMLGHsy0ST2Tcps4JwUZwRD2
 5Nx70dwQmA6OWt5ChFHA7ae33QxPkH4hprOY7wIzGtGzHj7KFOl9ofQXXClZZgg5wkrPLsBFDEk
 WwJkM8qH/WmeTgRVDdPRwo/YoQmKU06LEmjtvCZWb2/CaUDAfvNOrQPk=
X-Received: by 2002:a05:7301:578e:b0:2d9:6373:ad1d with SMTP id
 5a478bee46e88-2e478c1f833mr20475128eec.20.1777086617724; 
 Fri, 24 Apr 2026 20:10:17 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:17 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 1/6] dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
Date: Fri, 24 Apr 2026 22:10:06 -0500
Message-ID: <20260425031011.2529364-2-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

Add compatible string for the Orange Pi 5 Pro.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ae77ded9fe47..3c6b83a84463 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1320,6 +1320,7 @@ properties:
         items:
           - enum:
               - xunlong,orangepi-5
+              - xunlong,orangepi-5-pro
               - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
-- 
2.53.0

