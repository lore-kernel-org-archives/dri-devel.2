Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D1606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nwVkBCc2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B773112993;
	Fri, 23 Oct 2026 06:40:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F52112993
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so1252195e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737626; x=1793342426; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qBC94N5Vlr3FlLO5bq8d1hj8zBP4JCR0k1VspHMjzxs=;
 b=nwVkBCc27/uuLjpMaDAt1WmtvfynFEAiEOsvldUN4wvwgt+FRWg4QedwQ8S0p/KYPf
 F7/ZQvFaZ61AYUtCNt+HEB+0sii9repRQu/LO3NqXt56p+ahKhDRJrlxPXbplYqvrjcK
 oV6cZXxEV0hhSVJKFsVEOfOcRtNCJjR1NlA43mgjYxoYxh4nHXC2ozKRF3x1cQSjTvLA
 VOYN3gBFccyP6Lsw/I9DzGoJY+kqkT0fYGozfZ66lTmDuF7m2s1rC7y7xwcL3DnNOYgV
 eFXhOYzAd5n0sscdaKjOAZT2rQKyG1hehvIr7yTXLvntckOH15fTwGoNwRuc3yj2rAQM
 w3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737626; x=1793342426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qBC94N5Vlr3FlLO5bq8d1hj8zBP4JCR0k1VspHMjzxs=;
 b=2CRDV6WEKy6Q44rZA2CpIMUErlRRFhIqgW9axuLO1aUnb+VBSTCuSk2z9yzQNCOWWE
 omxDUVuZhZ7lyxdrFQ7+pddmCgsynFkGPoG8iz37qyS6hj6wVe8Aiq790ykOjk9JChHO
 JMpB+U8/ok3j41BWvNcw6Ie1PEScvKxNYuz16pWxeK6pCDbLN2/TpHhm8lrCEk3NvcTH
 LK7qFl9TDf/l08AavXxU25JepFDTjThPVu21JsR+cBVOg/tELFoLGJLnQbqiPjdEIO8c
 AW1HvA2qvmoh1eAH6phsOKbSrmWbo9yiji5AkCb/LYIvFkhKUspnXaYcREmXJjbLSCOz
 fFiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztPOxoB29ErDls+h6RZOMPXQhFrkCVkvlqNBuLJh9HXY+RTcuL3mrE83BMdOri5qLc79XgerQQ4fo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJCqurTvegz60vH6xUwSnAAWac+lWurNiWAOY3mnlP5jhQXrtFo
 R6wMYP+ebViPYf81lZePrDxRnMMzWwzkI6Xurdw5YKggfCVAnjuFGxgB
X-Gm-Gg: AYBFou2fQBdsmzGD66AygXxhbBCjvqKGsnhJtrcGo8w1BA7YhxwScgoRFWlbqqFpC+2
 C8Cq+ESZ6RdQmBk5b6WuLZhwR59YqUK9SJqWlZ1i+rOUxvJgyFHoleKTK6Mnh5ySTlQ6iWnwDQQ
 cpTRDucKrsyDo4DGxkPxKL7qcxYZZS4I8KuuJ1DqL4t6IcwShaYpzlDe5v9Z3eFIwyV/tzgwJQZ
 fu4XNt1W4MCTYjLAgb7xuJc4CbJNxVx5e/XEXDyiinYDbCKyOZSLyh+gB5oWLmywE7lxn1tchCc
 Xt6D2ttdTNRGMgF34Q9r2vUU6gSQ2BeVpLKD5d6WdK9y7Fa8f/sH7Y6dX4XrvLYQJ8xDQ5thYTn
 4+KHMXTbo7ccMH/NH9ZQvuS2FuhUxvYjSv92EZfpVU+7Q0wtwhmpH3pjm1IJmORxGKF0B8ajCXL
 IS2MP0tLW7qFL+sz4h+6XDMrBi5M14QdNHKbLTMjNs1Dv+pN7/VfZ4F8Iu5yc8iPSuKg0pU6Zkj
 ykRTdhME942c6JgmhnnD4eB4qvmBsrFjJ2Ut0kRWeyAkoekm1FFBqGthBoe4uh0rU9tuzFZxu+l
 AgQLSFSXX2SxfRJFGfqHKrp8N2Ll9zg9bgmcD9VyUwY6iOFyoOX3Yc4wqILKx+KrmnkS8c5SiJ+
 VVd8=
X-Received: by 2002:a05:600c:3486:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a211eec13amr18677595e9.23.1792737626234; 
 Thu, 22 Oct 2026 23:40:26 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:25 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:41 +0200
Subject: [PATCH v3 16/16] arm64: dts: ti: k3-j722s: Reference the power
 domains of the C7x timers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-16-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make sure that the timers are powered up so the firmware can use them.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
index 611220ff2655..7639081dc913 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -166,6 +166,14 @@ &c7x_0 {
 		 <&mailbox0_cluster2 &mbox_c7x_0_client>;
 	memory-region = <&c7x_0_dma_memory_region>,
 			<&c7x_0_memory_region>;
+	/*
+	 * Both timers on each core: core 0's firmware drives TIMER1 and core
+	 * 1's TIMER2; two entries also keep the platform bus from attaching the
+	 * domain to the K3 driver's device.
+	 */
+	power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+	power-domain-names = "timer1", "timer2";
 	status = "okay";
 };
 
@@ -174,5 +182,8 @@ &c7x_1 {
 		 <&mailbox0_cluster3 &mbox_c7x_1_client>;
 	memory-region = <&c7x_1_dma_memory_region>,
 			<&c7x_1_memory_region>;
+	power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+	power-domain-names = "timer1", "timer2";
 	status = "okay";
 };

-- 
2.54.0

