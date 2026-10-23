Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5B606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlJk70kV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AE510E592;
	Fri, 23 Oct 2026 06:40:46 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7EF10E5B3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:25 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so255112f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737624; x=1793342424; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4UoeFHsO2E1Dm3EPGxkpKrzw1COi+rNj0JGJlw6wJw8=;
 b=JlJk70kVaLYzOAtbSGVM90BAu+S1wfHdvT+bVlbTXRX5uh4QfNykWemOp5+aXDh+/k
 9OdVJ8wJ+SGIzHlz/nKbk+/dyx9ZxI9T8Gh+b96AgOMczw6Qc3nxcYLKQ4Aoyxiszaj4
 cHz/DzSy9w5YXmHYgDA8jwcLTbYNUUpdMjjB4NIA8bPMwQMEN+aFdAFhuWXgCYCdTvFw
 LWbiDFN9JfOxnVmhmDSvaA11TKtNwdTOmtzomU3vPwhqeaCuC21iIo9xV/kobf6xcdiC
 gsBWp1wdSlT6CPvOvfkHGWAaob8TQD1slrgE7C/H4b1DDDOFNsf8PQVfDhoTrCgKBPMz
 TJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737624; x=1793342424;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4UoeFHsO2E1Dm3EPGxkpKrzw1COi+rNj0JGJlw6wJw8=;
 b=AQUOnEc1zEpBpurfyGZzZ288U4MIgrFRMtrCn/fnEKB+ryvNvQScTpPZzIFRfsO9RG
 wU62qWTQ3T/ZfLQV1X1JcFjwpCzDha83plvDbGHU+D9zHBJtAZpYhD+SfCr7DZSrfkFj
 zGAzoZ3fgTfE3vIqr+H4HZpuu1N4qKvA7848trSjitpdbNGcEeBPUIn2xm7o1vqvecN2
 iOrlHI5uuVrzp7zOsmdoihFr+3ajYFVPbIj50q9Jz5pYnRQCIn2d3oyP5vdbpLqt0xl5
 CQ/UZnTT9lzBYgxlJdG7yaK/JXA4xnJyWm0f4w8VpZdGg/Lsw4ECv6RM5IUYuP1MsAv5
 co4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByhQqBTqa/kxZWl6s873ePjLelU6xOIyMc6MkO2Jc6GpkngGBhJLlUaEIavZbPIjAwaLptT/I71dto=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxksDyIfSEy8R3wbLk6GjynQlCDWfZcqguNv0IPN30+wOvVyBL
 1pmqDIJ/ICyVCEMke1dQvTZlhw7+9vbVl67TBRsXlWEN2MTSS4z57jph
X-Gm-Gg: AYBFou1KG2nJbAk3Rwne4YO+0+uLDxRerWkzAHNQmA4kHjvKFDJvwParDs/jmxx4HSy
 DxOruzx227wfAAsT1HabuAtpS6jAvDYvjmSmNUwF9a0uxHSEBhLdHrwtdo80iQxhgUQvtV5iBd3
 gVVyU7kaoOjWb551bfo92RHemuMfs/cFL5dFYm5jCNIBBZWwn4VXNhZ3z94UGAA+ftRUI+SP29T
 g3Slhtg76y0kJhQu+sw9tyYTDSF+hhxSOw7yuS8S4A1FdkU0aEo0HdEdT6Tp8qOqkKrSbicgQKp
 jQ+y2gIsbBwlGCYKtbWVKsvndrbdYq363QLTxeL4P3ehVHSEuXJZ/gExAYWF2qbNKRVud+xeyOF
 +lBLlDyZR3vZ1TDmHKDBpm/lEeD7LB0YP5VgANDEZrq+OAl0YVIDAsTTSQoL1UwFwYe5p75Wyj1
 RnRGioEI7aR/tFObE+KjW/KP7csd9DA4hntDZs6kCYWfmH1mlkhdxMOz02WwIhqh7XsGr5WGTkl
 VpPXsPMiMxILSJldK+Fb971hjwV7z5q5UkW4MZ5LbJ8k3APXhwuxEZast0p7CJQuHvOKY+ERTQN
 O/XHNS/+I1eRtpi0FvhyT/7uVpXoHH3yyrfIemJpteCKgyQgOITgqoNki6PwJBxuTkktBPTw7+8
 O1pTm2e7Z3b1TLFTHi7GMqnax
X-Received: by 2002:a05:6000:4910:b0:48e:1c2:55a1 with SMTP id
 ffacd0b85a97d-48e385c0867mr1563144f8f.52.1792737623908; 
 Thu, 22 Oct 2026 23:40:23 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:23 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:40 +0200
Subject: [PATCH v3 15/16] arm64: dts: ti: k3-j722s: Add second submailbox
 to the C7x cores
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-15-3ab40aa17157@tomeuvizoso.net>
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

For firmware that uses something other than RPMsg for communication with
the Linux kernel.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
index a59c3648d805..611220ff2655 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -86,6 +86,11 @@ mbox_c7x_0: mbox-c7x-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
+
+	mbox_c7x_0_client: mbox-c7x-0-client {
+		ti,mbox-rx = <3 0 0>;
+		ti,mbox-tx = <2 0 0>;
+	};
 };
 
 &mailbox0_cluster3 {
@@ -100,6 +105,11 @@ mbox_c7x_1: mbox-c7x-1 {
 		ti,mbox-rx = <2 0 0>;
 		ti,mbox-tx = <3 0 0>;
 	};
+
+	mbox_c7x_1_client: mbox-c7x-1-client {
+		ti,mbox-rx = <5 0 0>;
+		ti,mbox-tx = <4 0 0>;
+	};
 };
 
 /* Timers are used by Remoteproc firmware */
@@ -152,14 +162,16 @@ &main_r5fss0_core0 {
 };
 
 &c7x_0 {
-	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
+	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>,
+		 <&mailbox0_cluster2 &mbox_c7x_0_client>;
 	memory-region = <&c7x_0_dma_memory_region>,
 			<&c7x_0_memory_region>;
 	status = "okay";
 };
 
 &c7x_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
+	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>,
+		 <&mailbox0_cluster3 &mbox_c7x_1_client>;
 	memory-region = <&c7x_1_dma_memory_region>,
 			<&c7x_1_memory_region>;
 	status = "okay";

-- 
2.54.0

