Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBF606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5DtLr3p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6310EA4A;
	Wed, 18 Nov 2026 08:23:06 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD8110F645
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:40:01 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso52102445e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919199; x=1795523999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjrAJfQ30bNb0haiNW552/JsaDvfxHWTHWoJPW/T5QY=;
 b=o5DtLr3pQK8MKN+qW5bLKiwaQVqayHruNYNR2MvGJOvh9i4Aq5nDNlp5etq4ic6D/6
 rljkk1uZObENM0ZBb79EUa3GMe/zrPIgsS9uwEC0Ic19jJvaZcjNoVVk9pHVvZBnYvah
 Acic3R47F8c6rhAiv4s+5N1QU8hH7dIq9QHyIpzQkEGm3tWxA0cdyayNOMJTKSmSURhP
 2jHoGJ0fgaK1JjmTmWhskuksqkSZH0XarvXywpzGJj4amT1TCEjCqrbVN9ks2aUTGGvs
 I5k9pRvkujlJ/y/wgmXXSsUV53jAtLOH54lwhVQcgAIxBCOByTRHI4JiPWVcvedeO1qo
 Qoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919199; x=1795523999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjrAJfQ30bNb0haiNW552/JsaDvfxHWTHWoJPW/T5QY=;
 b=UTRu5/QTsLqcY1RSZm1mtLb8HBnY9azW1RMVBGTYKr/hz+F294usH4satM2ERAJ5qF
 /5k60TqZIOfgXxmex36IcEEoJ0IgRJVo2oOAgqCw/dtvqQ90KnlERlpjma9FH/8S3CVN
 8qvebBrcxs/++IHl4x/ncshe46K8CaBK22cV6FnE87bz/gcU1F3NEvZ5JwtVDQlT0/LB
 CwYKG0lPlFN+nWEKxGthdBmsqxxsRyrLbj7+nHsy2tHym2VwMSSZYbqIryu3Gpq8fLKG
 qEXMIZEy1QDlwWWqyAIHizPlv2FXMCg0hHb0elQsDdDIyg/PjzWT6IEJ/7IKbtwlWYum
 YC9A==
X-Forwarded-Encrypted: i=1;
 AL+hErGCW2Z1EHXhcCQfttsXg6rREKFN2ytaqcGKGyzNGxMuPwM54Ri8edvk3lUvfpvVLYnmzaly8moyZW0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+luSVEgW3IywpPBa60fvafuG2zpMyKSJJT5uxDb65DhNtRxaE3
 Oxuh4uMgWWZBagfQxU6K6JUgHpgSUBm50kDLF/BotR/+XnUlJ/LO07SN
X-Gm-Gg: AYBFou3GOHdd0xvQ/jDqlQwGGFd7oNYJDtNOHHrODQB0yqWpMhRkWt6kND5imhQC5Op
 lCp7AqQM2qJEMoDv/LQ6PSSK8WS9uES0azXZ/hm+f4CI1alis21KAR9PhVC8yKpInQNmSNVyc5s
 6D86oomw2WZ3ZiGIXd0ORa3MQE7IJvKeg14sTLz43boBmh5bNtPKbBOQF8+p1SAjnmIP0rDa73M
 ft6o2D3AQH/hml5JfL/P1tNDgdZsCGBqUpeDDlFLNH/CqGzg7UBBy2LkhXuc4v8eYL7leC2Vwme
 U52cU0LBqVv6u9L02JioaNr+rBJpty3Z25rMmIfiwe3P7zFtqfrWyFRDw2nV7er5qBz08/geh+k
 j68vbqWov8TyYQSdjArz+pSdCMp+A8eIPDYMfSwCubDiE+E97XRCwT7TDfA5zd78ScdXNCeryAr
 MdawAWnskTJ1ZzlAFX1tS4TheY/EKJ8+PAe9yqFtrkRid/Pp6sWkIaMc14Fp0QgAtLVNKpnuXPF
 6cBu/h9m+h/wZ4LnGMnBTm/3sMfcs/QrB46GGu6vAXlM2N8Ac3rMKgpuIX7jhRUykzf5XbL9zFf
 /GlHQ7QO9AjGRn6cgQ0UCViVxyBwvxCmrSqCW1g37RebTQDWEDh9R6s/nD5riBA1Ebblhw==
X-Received: by 2002:a05:600c:4e45:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb56bb49f3mr279082685e9.23.1794919199526; 
 Tue, 17 Nov 2026 04:39:59 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:59 -0800 (PST)
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
Subject: [PATCH v1 10/11] arm64: dts: qcom: sm8250-lge-timelm: enable USB
 Type-C
Date: Tue, 17 Nov 2026 13:39:45 +0100
Message-Id: <20261117123946.668557-11-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Enable the PM8150B Type-C controller as a sink-only port. Keep the
primary DWC3 controller in peripheral mode for now; host mode and VBUS
sourcing can be enabled after OTG power delivery is validated.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index a094aa81ad225..6b57c658cf918 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -535,6 +535,24 @@ &sdhc_2 {
 	no-mmc;
 };
 
+&pm8150b_typec {
+	status = "okay";
+
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "sink";
+		data-role = "device";
+		self-powered;
+
+		op-sink-microwatt = <15000000>;
+		sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			     PDO_BATT(5000, 9000, 15000)>;
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.39.5

