Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C5606C8B4
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCZszD2u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB27112AE9;
	Fri, 20 Nov 2026 15:55:06 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1410E910
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:54:54 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so761878f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190093; x=1795794893; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=yCZszD2uJk7f9vdimboLRacAeXGuDRARWMiYdU3KXfn6XB7GGKPr46vUlfLaSFV0/g
 +BTwyemhtGn9YD8dAWNneQmdGr4GfWKUl0ZIIHnkHSwFvQ2v2xUH/nM7l6ImPFBV2NWr
 QMz7QJOwu+BDBmdX5F6ocFyI+6kLxhJGnHMdN//HCuDa0yGg1FdWFz4S4yBktqLYLUXP
 PpE+8T66uj6e59uB0YTff8Q2L9nbTFjSSMeNTustMl3/qafY+ypBpktVA0coZgWNrye0
 IsDnJ0x9peuQ7BXdNqDuZEibn49OOy5ewYbCKeqiSMccgIG1lyfzfSVxtCJWWgv5QTZu
 Z5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190093; x=1795794893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
 b=PWHUfylRUwy686qBkVKmYT5vGpWKFVJ/N9Z+PiMftr8K2y0s58UUend+chc8Y/noA1
 56yf7GkYnoabPtw5W1JzL3Qw6sTe9XTBNVCM+kkB91aahagzK+n3KpHEyJdaBvygXHPw
 znchzpXWAuGfHYTIc+X6YRYqS1D4e1c/QOE+eeZDT1kyAVcwGR4OL3asFPYvwM4/3mJu
 iPk25XMzGeDnGOz16QsBf1U8oxyaY+dE9HrsnTyPNDp8ksZP2XLtak3YPT6kWQT45tfv
 EQh5vi1B2kGH+Su94T6spnNlj19ieKGIyaxVsNc7suro0KNVB9q7D6fnQwOWaK0kTM/W
 cbiA==
X-Forwarded-Encrypted: i=1;
 AL+hErHrYyFETCu6C2W46UjzW5Seu43A29fms1IRR3cYm6IMkRZBfcvPLazELiRxAbPBh95eYTXWXAcLTXI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Duxo9hfeYZcTUERjtyZQdXVoOZy4DEos3W9272scMwKvT50jd
 JdlvCdWWm1F7DRfs/qVWVeO7Cy/KwT3Sswk4yiW/628jlDJFu1/qo2m2
X-Gm-Gg: AYBFou1HsycI/S1kZoBIB2YNyX8F7HQN2nVPMwtyETHs20HOX988N3L40OLGS0RzsDo
 eK0Q4Z+WFwMP2FoS+NB2lSfR/D2zTDZ/PH5+gamv2blYmpE+vCTJm90r6e6kJ5nFupMif47Twh5
 pXsjggLc/cVlz2LnQy3kXssiaLtyRunY1viXO59cXWMmGEjs9hqzF8ScJddpoMrl9v4S2eNyPV/
 pUYSZ4Eam1DV8sVEGIL61hMLvNSJH/LykQP7rWPZMSFa41DMHPh6cSjwTG5AdE7xSClaJneqyij
 LIhjIX/OvJGpXpotZVZwqmYlLEU6PqrLdIbh0FCcxwwCboxkjMUNpEWol2Qso4IcasAUoxen1JA
 3vypTg9hymhkR0IGVY1xM13de/Z/wnFqVjM3+dI+0xRLsL26ifv2r/8PUQVOnn5145SaKE8cV+8
 eyUe2JsrErJ15cS1kSHT7BoD3SGFqw4m8buIXfRl81hsMxk6/Jq8rqD0sVE+K7llB4DNDibSmQK
 cTPyyu4AMG6Xz7hfmDmy4K/sWnrvpw5Pg3J25nhnFBHhNKrJ7EfLvoKeJqzHnLXHCLJ0Dhyanoe
 k7x9uFmoiJm2XBCJDXB+bw0oL0iPsRSOzctkknHgLYjMTWMFUrkrpcypI1JjsmomvIHilihf2/E
 =
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb88809795mr76390745e9.16.1795190093061; 
 Fri, 20 Nov 2026 07:54:53 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:52 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Fri, 20 Nov 2026 16:54:40 +0100
Message-Id: <20261120155450.7719-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
the Qualcomm SM8250 platform.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..85635a871e7f3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lg,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.39.5

