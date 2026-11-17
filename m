Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F2606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BDOqwFEh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C58810FC59;
	Wed, 18 Nov 2026 13:47:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A197410F6A0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so14304595e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919192; x=1795523992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nJ5hpYg4Cc8VUEITkJRPygPQ3lscK1+CbDfUcnWlRxY=;
 b=BDOqwFEhS5D6W9/Rz6eoVNK79WIRh0wo53t/PGuT0mKCUXPE1CTXl9cmfRxAQHarxh
 jAicXBcfKY2arVDObln7RqH3GLtb6wizV+pMh3jcYBDTrZyi7FloD+M3iEB9RJUn0tAX
 mSPiPHAfQa5U7WfSoLpAJjOMrffr/DXBqTB5hzzyUS+3HlPb5EmQLOjUMAndFwcFkPDu
 VvrYXO7O8+ai4jE33dizIQsLYgZWGMt34PxkXmBiYSqFXeMvQhm4f5e14ToTIXxfFIZu
 5HdH0+0g2lEIPSWvph6cetEUkOLIx2Dv4boCio/nxoWAOL35bEVxebJlXMKPtuhUKZdL
 DSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919192; x=1795523992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nJ5hpYg4Cc8VUEITkJRPygPQ3lscK1+CbDfUcnWlRxY=;
 b=Ql6Pb16dbf1DMUH+s3GDTtYGIOzGvp/QJgFntsPr9PWn1UO7wPaN4ZM2EUJr2E6WyT
 nNFt9gZBEmwB2luqQB1QeaAnlFKbEDLn8hPbI6WXQQOQJwfmtZDzuJKWHCK841sPY8BJ
 RNNt0Zcc3GLSj+9ZMeVsfJnSOIIzS8FqXcUgm/Oxk1XhAu6leIzLz+0ztovYj3D9JXl+
 mnbu+UCUCzpyCF82y8/IkBwHn7P7XFXnaoKx8SFR7nCj4Q+eqImuaUkKjRaFCo8Pr6Y5
 deyeSrasjSK5SS1bqlvTl6XGc1g7MxlZ09F+eur33DaFPsOQ9XgPaisNkjo4bjWM/YIz
 gAMA==
X-Forwarded-Encrypted: i=1;
 AL+hErHN7jUTISFRZ5xBZKnrJOJERCzsS8CLVkPly+kknEvmQsd6ACikFdxzqa6/yw1AtGr+BcrQ3B/7QMA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+tKRl+/yQxtBkk92svky0re7D4X45ZPLoSEENFdFMKJo4Mzuc6
 qsnhi6D7UnhSQGqIQJ7P45Hek9S4oBs/q3nIRcIeAq6gdbeIPvgQSDQL2yXYAg3CXXTApg==
X-Gm-Gg: AYBFou35Cg9oxCsDuaVt0+5/FM6pvYpVIg4JMGpI4f3PdERWfzdNJWtR4mV6ma/ScR9
 IIIJdM440ZuwVlNQwB9JfecS/3HWVV51l+OineP+SkfN9Fnvy8Y7O5s5a+3aW9Qyx0I0hKNekEP
 gM/kz1FGnFW8NH0xO3L/4kT//Vt3yhB3MoqjBtXnFniBmVAnCnYBbv6dhNf00NLTOf2wYCX4DiW
 nyZ9BQgB/iqqjaya/SVDbXaAUTF75ISn3ZYMpMhCQhXf3GeIJpkAG1u/QGytQTR1sveT7GKumLS
 9GnMPnUJM+dlwXTZsj9zRkxAfYB9c2gm4EQ+Xg3DbMb+epa0ddUb5ooRt6nwcW6MBgzkxXH0aCa
 mnYf5myCROTyVyQvUPHb+9PQijpr/MTiF50VByL1SfxjD4LzCAiGhS7QUMGGXI+Lzl/6tGPMR3S
 sBR0cTYDnCE03yYFKYtL8fOykBeuRZQWipfGY86z6mSjpKm2KuF6wsIue9zOwHQisvZm7fxIE9q
 RNWmsOkrAl+2LvcU1k4EoJetfiTUwSZsZOGEHixrW8Kiz7RFjGXjdZRbC7pWkIJHoroC6ENM6ux
 SLPIMs6k+D2R/xgG//F4Z6+P2j24v4Jx4HNB6IP6lGoEn/jqKF5QHXzkf1pE7bbM0HsJZA==
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id
 5b1f17b1804b1-4bb5de1f26dmr222829735e9.4.1794919191912; 
 Tue, 17 Nov 2026 04:39:51 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:51 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 03/11] arm64: dts: qcom: sm8250-lge-timelm: add reserved
 memory regions
Date: Tue, 17 Nov 2026 13:39:38 +0100
Message-Id: <20261117123946.668557-4-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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

Reserve the XBL/UEFI log and DFPS data regions used by the firmware.
Keep these regions protected from kernel reuse.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index 74b673ebbeb9d..ecbff27976fc2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -103,6 +103,12 @@ ramoops: ramoops@b0000000 {
 			console-size = <0x40000>;
 			ftrace-size = <0x40000>;
 			pmsg-size = <0x200000>;
+			no-map;
+		};
+
+		res_xbl_uefi_log_region: memory@80880000 {
+			reg = <0x0 0x80880000 0x0 0x14000>;
+			no-map;
 		};
 
 		adsp_mem: memory@8a100000 {
@@ -119,6 +125,16 @@ cdsp_secure_heap: memory@8c700000 {
 			reg = <0x0 0x8c700000 0x0 0x4600000>;
 			no-map;
 		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x1200000>;
+			no-map;
+		};
+
+		dfps_data_mem: memory@9e300000 {
+			reg = <0x0 0x9e300000 0x0 0x100000>;
+			no-map;
+		};
 	};
 
 	vph_pwr: vph-pwr-regulator {
-- 
2.39.5

