Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DF606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NVlOz7ZM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96578112445;
	Thu, 26 Nov 2026 14:13:49 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EEC112445
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:13:42 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a56e05568aso15966335e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795702420; x=1796307220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UqL3Wpz/mpEA5/gi5iaPzqW5ysijFqXD7W3q78hLBpM=;
 b=NVlOz7ZMq/K69hCGyxP8hvV5IOTlmPw2mIBhgHu2wtkoBwykcQqbOpdwRQUBAJxokQ
 8TlTFDBFJb4SfYv7oMQRQ3aPAX5+f9oBPie4ejIHKaURgHLNuaTWxxX+HUY6yyWKHj6w
 shD7HIB8laUSzABqvG0jWpq+M56mfkGVlRJrte5Owxy00dZwmD5BLWbLWZFMxcvXW3Qf
 zPaPrl7jUPIa+qThxOx35RHh/rB9FS/zozswRkhIWbsWfjDk7JhgbyEGPyIgifuzq/67
 fkJOSJuN3PswSw/itSLpWp2abHOk6NtHO0yM7tw37KT4Lk4/IO+GuzH1LthCTuFRcMGH
 snbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702420; x=1796307220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UqL3Wpz/mpEA5/gi5iaPzqW5ysijFqXD7W3q78hLBpM=;
 b=L6pMyrQkEWfoTSnJ9BCJbcvcb1G3RaczAXqK2TEgp8ieODt/Gt5+nCfn8o0uTxjhOa
 I3FXefJARYH/K+JEQHKHDn35gNCGU4TQb/kaZShUE3bnz7ZYAdqMxhzfvtwk24nTq/mu
 YGLTvH7Ezu+kJ+zmhO3RSIrd8uxQFcAJfYSI0rgoD0cymTDxVMkWxZGdcIYvbCtLY8Kg
 SgFg4xX2BpO0X+Gv0KgXxSDH7Gpp90LbwCWpuSTXPxiaGHx3Fvt21WRk7M1ebgR0WSIe
 E9RyUqvGWsbZLBd6p7904C0AwgjdyiI+4AHvAWtKfAdpcDvTDnK+niPA+mgc0au/1GvV
 o5Ww==
X-Forwarded-Encrypted: i=1;
 AL+hErGj+xlH1KnWnyYFv5fE4SorgBCylAyubNz7rzeTXZk/JYznIxFlwyKyJd5atxHri7fUJudzta8BS+Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8vL8G6EAZcvn4DoXRvFm9c4aSFHi2WMRrR/bP5xjN7dfl4/rUs
 cJ6B1XHBOJSduK6frF1vMC2j8aFVZJ7U9JaB5QERtDcEckwkssbrtrgZ
X-Gm-Gg: AZFdTZdt3KvPXrcaXgkODFnEK3nlb6P+3jpV1SsN3UnN/iUS9ZsY3WWbFt9IDdJLDkm
 /btEQAB/4BAskk5uauSuyVHyOnyh/T6+mD3uKZRSH4C9ZRl0I+IpJGqKlGICJg0lw5oWVFzh5me
 UJ3y1cOdc9Lt+4YbS+v2RPY9h8sqlR87/4PFN84eR6WQ/2RXmkS+4CQTkdVZ12TAfyGcmWTmtqw
 PZIzJ3rLVQ0SO3YSWPyJpsxYssoOr3FDjJc3PKkPxoAZRYxSdY2OScrEEwWSZowOJvvRNY3sx4q
 pxnAU+dh6+V6GMXsVfTqvuw0XYRfmi1ve8d3OSXHsRcl0k2qibJSffn22esEhKWwGapz4r4rIWe
 nIIid/FqgZQ11BfLT4bvyQsp2DqvWV7h7raIFok2sMn0ajB/qgop73XGkwtNEpPSxAHPd7aYlwe
 02mPm1sj5oisci/GVdmXKoJ82POxKP4OGR23PXqao6O+bKsMun2M6z1HGNo9zKrZZD/xfax+KUw
 vqp/9JAGY6Xzqn18aLOhtXtHcXjo1xP6qpUmV/cpV45a5JNULFfgto7R50hxmksuKj2CPlUvubZ
 DLPV55N82Ea7PrIgnfCK28KdFizPTOuGkKwslH0yP5o4EJrdroDUNxv/O4CA8ZlmkWu6Dtrm2Zi
 NHwrvL+E9NuIf1QBckDMQRiZ9HBCFsvr5Tl74UtpW
X-Received: by 2002:a5d:5e01:0:b0:4a8:eed3:770 with SMTP id
 ffacd0b85a97d-4abb47b25eemr44322800f8f.4.1795702420197; 
 Thu, 26 Nov 2026 06:13:40 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr
 (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f281sm38519262f8f.22.2026.11.26.06.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:13:39 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:HABANALABS PCI DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] accel/habanalabs/gaudi2: free the event queue IRQ with the
 right dev_id
Date: Thu, 26 Nov 2026 15:10:53 +0100
Message-ID: <20261126141100.44391-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

gaudi2_enable_msix() requests the event queue vector with
&hdev->event_queue as dev_id, but its error path frees it with the
completion queue pointer. free_irq() does not find the action, so the
event queue IRQ stays registered while pci_free_irq_vectors() tears the
vectors down.

Use the same dev_id as the request.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Fixes: c833ac1a5f34 ("habanalabs/gaudi2: free event irq if init fails")
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 5d9c6f0698b7..b082d7eb6c45 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -4761,7 +4761,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 	gaudi2_dec_disable_msix(hdev, GAUDI2_IRQ_NUM_DEC_LAST + 1);
 free_event_irq:
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_EVENT_QUEUE);
-	free_irq(irq, cq);
+	free_irq(irq, &hdev->event_queue);
 
 free_completion_irq:
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
-- 
2.53.0

