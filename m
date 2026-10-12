Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A334CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC88C10F2B6;
	Mon, 12 Oct 2026 18:11:22 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39B910F2D1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:11:14 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2851652a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791828673; x=1792433473; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxZgZ36Wo50LsnIKnkOJrinMNq3Hzc2rg+tfq9dowts=;
 b=5sp3VfrQm8pOOEvUrAl6reFeKUxG6TUUsgm4bE+du/WRpJnjgz3/ihrdojGk44IXNy
 FcEYNj2NY7VTueCFFd0VFMS60SUr2t7nlsWSkktG9toDtDQMphAosczNQLXPLi/agtHa
 HMY3LbQiqQrtCNenrXp8gzdaca3Ye/cyg4mTmABh7/fOZkvG9hd3cdFDEKIta7K35E+O
 U+iIxLYF5A4ZpT50+tXlI510DU535u9oftOo6OgxsM1cJLonaMY9Z4ZmS3b+UecTr7he
 ZB/H+usFF6Xxb5mSbcLHABkwaY8rRuLgiOWpOg3BOe2CP/yNyk+U0BYf3RW6WxpdYEFY
 2mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828673; x=1792433473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rxZgZ36Wo50LsnIKnkOJrinMNq3Hzc2rg+tfq9dowts=;
 b=ZUBAMpV4eq3BbjsXAcz4HSYc9HYq440pJmizwGAmrs7lDHsKkhz/iVMcpLG660aFzP
 IRmwqW7nicHwJbSeP2nwzwBHHGrsi3vLH2HR+uQ2GcHuLPbrabJ9ZNLNY2fglXEwPHiw
 LwpnAR4OvIjAJAnIHviIBfdwOUvSXee73z3mpqsZkDbpe1usjmyjM94jBwLsDDMtu9IT
 K7vS7Swo1i6jvix0sfeIpFFac/39zlRybKLVidnwr5WdcEQZb+oAXQhL3ajSLz3jyvau
 3BNQiHWRhT664GRZVa/QTa+rGj0wiIfZ0C4L033/AbJQKfk7Wn9ejQTyeZjb3/Iwra0W
 mOmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpNZSJQwpHSpbpWqZSAAqi13mlpTjSh8KgP4wNws/C6uQ22c2JKqCEh3mXj7pD6kEYKhrcB7Rgi1o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5g/UfFrnnaVr3AVh50UFZgxJV8/uiShz0mldsi2fHH2vpBOjl
 a5pC9f7MZ5+cR18JfFGaYHYv6dEUKtSbYPLcbg9ul0EnbEyNOx5dJpUu4QIytHQdwkI=
X-Gm-Gg: AYBFou2c/BnTSPEhMzeA1aUDaLxKVFS+Rs3/6XCT0WLwYcWBCj1SD59Pi4weLB8sbgn
 CvPAyarVPqko0H7yGMH0+oZ1jMQa8lbpU4GDsmu8+O8LvRYmruWX7FuThKfoyXbKtAWwtm6ALHx
 y35GjyuntPOeSO0WLRnua6VRPvtMywTENHYwuLIxEEYsR6bLfJQhCa9unCEY5nNdFMAi9gHy/WX
 +Sc+LwK1AiebL/BEKTdJv2xlK92FzhI164oueCTa+IgXbRLUeFY9DLiY12um8KOKDIx65pRCqyI
 +ndt1boeKbwhOkWG36PjmTGjAdW3AwA0bJQRZRAl3J0asX39zpEjgot9Jn7ENFulnxtc8He4jml
 ZosZwhQ3Oxhj4+jpR6LbYgcoc3ExUxZ8XcFQ5Qiw1KxbDcfa1ucQOq6WBfIgAwXNYstR05XXmwa
 yDU2WCanTqekh7MI7zFGEouO05569bxdnRlobZBQt0DayIV48dKNM/ckcMetx3MjBCqLbTthIEq
 V9Ejk7OqKuXUewfVhoK2cpnPY01tFxmD7Ff55XAxiJMZkDrdzMxWecEKr6UmmhKSbZE8CxnM68H
 vxdqnpQR07jpORvOZoo=
X-Received: by 2002:a17:907:1997:b0:c29:f5d8:9c6c with SMTP id
 a640c23a62f3a-c31aa056fedmr1008415266b.27.1791828673444; 
 Mon, 12 Oct 2026 11:11:13 -0700 (PDT)
Received: from [192.168.101.179]
 (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl.
 [2001:1c04:504:7401:4b2e:1820:6d24:b264])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac924dsm498415466b.70.2026.10.12.11.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:11:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 12 Oct 2026 20:11:03 +0200
Subject: [PATCH 1/3] drm/panel-edp: Add AUO B140HAN04.0 panel entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-book2go-v1-1-7188e7ea7a15@fairphone.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
In-Reply-To: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, Jasper Korten <jja2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791828669; l=1566;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=sMlOHXWIQUaAlGkuR7ZEpwEAbe+Afp5+xO5cvE91lII=;
 b=5ESqndbcoHCWmYQ1IFMtTt9lOImdBH4J2Ge/7LsrgcAiob3q5Ug0lELJHEh6SUsH8K5XyfvN3
 QeGNqjyQhkcBP7aV6EPAieM/u/rshdDDc0LzpFqGrvF47BlU1FtdRDB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

From: Jasper Korten <jja2000@gmail.com>

Add an entry for the B140HAN04.0 eDP panel. It is found on the Samsung
Galaxy Book2 Go.

$ edid-decode /sys/class/drm/card0-eDP-1/edid

00 ff ff ff ff ff ff 00 06 af a9 65 00 00 00 00
28 20 01 04 a5 1f 11 78 02 9b 85 92 56 59 90 29
20 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 14 37 80 b8 70 38 24 40 10 10
3e 00 35 ae 10 00 00 18 00 00 00 0f 00 00 00 00
00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
00 42 31 34 30 48 41 4e 30 34 2e 30 20 0a 00 ed

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2b455369ed70..73cdc2d37ab7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1986,6 +1986,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116XAN06.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140HAK02.7"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x643d, &delay_200_500_e50, "B140HAN06.4"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x65a9, &delay_200_500_e50, "B140HAN04.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x67a8, &delay_200_500_e200, "B140XTK02.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140XTN07.2"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116XTN02.3"),

-- 
2.56.0

