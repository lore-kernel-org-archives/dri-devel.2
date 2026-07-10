Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BB7C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19FC10F75E;
	Fri, 10 Jul 2026 05:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="PvECbFcK";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BEB10F75E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:31:54 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so944399b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 22:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiscrypt.com; s=google; t=1783661513; x=1784266313;
 darn=lists.freedesktop.org; 
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q+V61I7YIlxzkSvRrZQFMqDwZWLPPzgga2mCJXiDoY8=;
 b=PvECbFcKAAi8eN/cRsabEm0jwzgtcRG5P50FUPqF2LDEGWeegKb86Qe0DgxJI6NAIe
 UcV4Hi2gbF+WMGb3MPdjWUK2N2mWf3m/SqrKgFUf7UGwQ2awdjGa/gyav66CQTZ6GH5X
 yfZNsGZviONELAcRJ+TN5UnryFPDQAGoPrUeexuLBYhiYFnRRLSpgLPe74SErAiOmgYz
 q3XN5t1KzEn8IS3IQWsR++bv1vufQMX+SW4q/nD8cqrsO72lvfrLT+6HgkV9u7nwd3HL
 c3F66gkB9VULzmU0EdZIqz6kyikqOPC2kRZHvgWZk2p5woXx5WadoIc+QsKdCiAvKU5F
 YLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661513; x=1784266313;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q+V61I7YIlxzkSvRrZQFMqDwZWLPPzgga2mCJXiDoY8=;
 b=blku4zQFSkmUVDNRiFmiuf3X1FWJEBJAOFzeMRBtK3g5ewYSZn4eOi7hATat8n8tGu
 afMJPjesYaMuWnpNKgtC4R3BKw2VEOt4K0BA1904HjGG+LDKDfURHskfKAvqszI4q4Ph
 z294xGhl/WBpabAX11Uy1IuDbAfYcrDIu4PWxRbHNDPT5rWqMfR3h1zWekrW2//vcoPw
 4jLDbb2bsTfv5Oa2BpvHVl7Ek01ULx23GT9Qj2gEg9EWZQfUC8YTAP8/Acc5Dnhum48X
 9MR90o6QhTPlRMS7lYY33XDBMQB9rwgMsfvKy3KgBTs7d2VjTK6I7mVREqwMDw+/1c3h
 kezA==
X-Gm-Message-State: AOJu0YwjaMuNV3UFqeHhlmyPcUrWoMKT84c/zZtqzWdsgS5ZrWByG4rZ
 NWnsD+Ybm1yR+Mx8IU1+L/COk5T4ldJ0ZA+sWVtRWBqB3jcl2sCH/bSzr1ddw23en7seyTH0IPE
 heJXlWMbroUI=
X-Gm-Gg: AfdE7cl0owhixg9DDdWB39E4EiOdhM663mFeB4fOyuyTgsS1DpFNLk4xiaM27CoBPCI
 Qsz7KiCMhea6gAwxm0yD5dzsW6NGauA+6EQ+qIGu+vX23nMhUhBBHcc6mxIfGz4sHMB7it/idxi
 WqwyTTRVTjfq9ye+MI44DifQAPljqAdv+iiailcgvIQBUNvfKlltdYSs7Tmh7lwCA0IIklQ+ChT
 LdaAvofy7fDos5gOS5JIiPzEF50bKKP5yVXmI+PEn2+ym9mg8fszXTF14/xPq0vWJ8a1Rmq8zO+
 jh5qKGKtgkdBp+L8gw99PA6+vSdGNKeXcxu3wflydGZ1l0oFSwTuNB9iJgeP5iTLXHS/cqIsLHg
 HHBwE0Yrk9V7fAF//Epey3+l6PiLdQVMpihs2NMe9DmLrq4VodOf8Dg0aAX736QT4jehs5Fa5TS
 aMDPDUbpiiuc/eYR8+xynWn0nmlp6eIWx8l5xNxutgzrrexgZP7nZ4qKAWP+8IZkuaQhkNqyGdM
 9kpUJgHifTHKivEeTp3sGPG2K/Ka9W/K4yhC3Dn9wNKK+qVpHKoMx+wYFjzyw2pN7ODa0X+7AHc
 pmS/bhGTvtaBemEPTARRdtkPe4W8lSM=
X-Received: by 2002:a05:6a20:2587:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c0f0bf478dmr2698105637.35.1783661513230; 
 Thu, 09 Jul 2026 22:31:53 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([2401:4900:1c06:5ddd:7136:4c99:1a8c:2a09])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b658a99afsm35798130c88.0.2026.07.09.22.31.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:31:52 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] video/hdmi: cap SPD vendor/product string reads with strnlen()
Date: Fri, 10 Jul 2026 11:01:49 +0530
Message-ID: <178366150933.60795.1763150014043217203@digiscrypt.com>
X-CodeOps-Marker: bb22de9e8df44ac38c64e690c4a9d0a4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

hdmi_spd_infoframe_unpack() hands the raw InfoFrame payload to
hdmi_spd_infoframe_init() as its "vendor" and "product" arguments:

	ptr += HDMI_INFOFRAME_HEADER_SIZE;
	ret = hdmi_spd_infoframe_init(frame, ptr, ptr + 8);

hdmi_spd_infoframe_init() then runs strlen() on both pointers. The SPD
vendor (8 bytes) and product (16 bytes) fields are fixed-length and are
not required to be NUL terminated, so strlen() can read past the end of
the source buffer.

Those bytes originate from an external HDMI source. HDMI receiver
drivers copy the received InfoFrame registers into a local buffer and
pass it to hdmi_infoframe_unpack(); tda1997x_parse_infoframe(), for
instance, reads into an on-stack u8 buffer[40] via io_readn() with no
trailing NUL. A source that leaves the vendor/product bytes
unterminated makes strlen() walk off the end of that buffer.

Bound the scan with strnlen() using the destination field sizes. The
copies were already clamped to sizeof(frame->vendor) and
sizeof(frame->product), so behaviour is unchanged for valid,
NUL-terminated callers; only the over-read on unterminated input is
removed.

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index 45b42f14a7..32163576a7 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -230,10 +230,10 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
 	frame->version = 1;
 	frame->length = HDMI_SPD_INFOFRAME_SIZE;
 
-	len = strlen(vendor);
-	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
-	len = strlen(product);
-	memcpy(frame->product, product, min(len, sizeof(frame->product)));
+	len = strnlen(vendor, sizeof(frame->vendor));
+	memcpy(frame->vendor, vendor, len);
+	len = strnlen(product, sizeof(frame->product));
+	memcpy(frame->product, product, len);
 
 	return 0;
 }
-- 
2.52.0
