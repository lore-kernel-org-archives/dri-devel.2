Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4440FCD98D5
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C420110EE41;
	Thu, 11 Jun 2026 10:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VHmAMtbp";
	dkim-atps=neutral
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE38810E4C8
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:53:00 +0000 (UTC)
Received: by mail-dl1-f65.google.com with SMTP id
 a92af1059eb24-13810b63a1aso7523155c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781121180; x=1781725980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AcFqLrIVFLvfFsw1lEXyB50NFxvg39bpvFE98GCsh/M=;
 b=VHmAMtbpszZ8n4eBfIwKIS2QG/JqQvW/sVHmGFmrYIJ350s2oZ/Ap9iT77iZC9PYTl
 Y6y/bvbRLzgRuJ/c871D1pnx8NLdpbA2a7awnEpYIK0qafkX04lRmnCb7B5lYLA+fDyZ
 6OcDM1/msOO3ZEIRnDIeazOJD1eeehHBivpVMo5wgrdrBikDPJJvCQwuWIi9DlrGP83Y
 NqRZClsmeaTIFUspAv03Oo5pgchj6XUAcfvY9z/Dkmj73norgwAI+UnA1j8JXKhCnkqw
 G57/0WJZQlSmPzvdkkIiW+TM7OZ/5F6Z7W0oqgzVrioN5dRMbjFuBedfkuOvMQi5A04l
 p9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781121180; x=1781725980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcFqLrIVFLvfFsw1lEXyB50NFxvg39bpvFE98GCsh/M=;
 b=Mw5PjGBXK1ULj5lOeoYXoIHwmMM2K4dL3+noUpZTfLNpBnn3N8Rb96NYs7Eh2WWsLV
 pvYW0NdXosuvwvXy4bG/tm1RxSK7QoR8BjZc2Hyq3FgxEq8PPc6gxzfOvdWCofvZ+eEh
 vHuKKm3n9uUP+rL5q1KPPtSSq8kxmxOipUki+pEkvp9dWv/mFVWan8vshh4QyU/8cMBM
 LmUkdfPvTzbj2ZcULJQ3+fFuKp9tx1ii5Pss/btDqR9fW0lmxnvCOwrxHsCtQ+8qJtf4
 XcAsNERb954UIsjV02gf8/FMArG1tKoZ6R1eNpS9UBKvrALJdWLnP1r95TmsA9J/myxl
 71mA==
X-Gm-Message-State: AOJu0YzZ+jp+lAwIxrPaobvZEug8EvOqkqr4FwRpOk8vuH9QsD6y/2kS
 GxGBEtstBV3EfnspHykRvLyHLFoaMmwThyNyn0TI49GaUolkh1QVHqug9UI5ZBVG
X-Gm-Gg: Acq92OHdarx/a039gdN5H6D0MdhYYfH8JgwTM289WUiXYjkdjxatqwUABKuwbp8Wkou
 tlvKSVFlmu86TVhAv1C+xCdqF/UbtXnC5HFIOc8pS2e4/kejzsctihynCp75S+3aIGNW04ZilMu
 mYUL8wjQnW4hdMKJ/9VmSd9WlGtsJueTQvBGJSSo/gP83xbi4wwW9uP2hsp5j4cvCzM6ZRXhNAa
 8QcH9KprkSLG/USjye+Eomzl+T0eM669MMGXF9LS1VQRW6ZxlICrbE9EeZE7coGsFVRIoYOe3Jl
 SB2/eOcwfMXJWUUEGGOcdwdhlo2X9Z+RFDozBsu5TrFFIeabRiHCpfa1jE812BUBSLuTSntwkSU
 jtrk6Qag/HovMW8FnV7brLeKKEatymWCfSb4XHlhnlrDTYyq7w4bKtELIgv1x3K3h9aci4ZQY+p
 HHX3YVyIm7TmBrBMv0F8dbOrBTOb0CyPvmOB1d0BySKIeySu40YScjR5IJ3jaZbTBT2e5xVx7ul
 QaMoIonYvUnDMVwmvBYy5FZLR4HtBdL77f3lxYRO6Lxfcaned/AU2BIlIpd3yyGkFvAK+VOwe/S
 VnbeDHZD+KWdn0lxsFuA1De1bRe5
X-Received: by 2002:a05:7022:11c:b0:130:68a1:a237 with SMTP id
 a92af1059eb24-13831bd7475mr6063871c88.35.1781121179843; 
 Wed, 10 Jun 2026 12:52:59 -0700 (PDT)
Received: from ethan-latitude5420..
 (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f554f732sm18665956c88.12.2026.06.10.12.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:52:59 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] sysfb: correct CONFIG_SYSFB_SIMPLEFB macro name in #endif
 comment
Date: Wed, 10 Jun 2026 12:52:48 -0700
Message-ID: <20260610195248.19442-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

A comment in <linux/sysfb.h> incorrectly refers to CONFIG_SYSFB_SIMPLE
instead of CONFIG_SYSFB_SIMPLEFB. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/linux/sysfb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 5226efde9ad4..ed23d6516223 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -118,7 +118,7 @@ struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
 					      const struct simplefb_platform_data *mode,
 					      struct device *parent);
 
-#else /* CONFIG_SYSFB_SIMPLE */
+#else /* CONFIG_SYSFB_SIMPLEFB */
 
 static inline bool sysfb_parse_mode(const struct screen_info *si,
 				    struct simplefb_platform_data *mode)
@@ -133,6 +133,6 @@ static inline struct platform_device *sysfb_create_simplefb(const struct screen_
 	return ERR_PTR(-EINVAL);
 }
 
-#endif /* CONFIG_SYSFB_SIMPLE */
+#endif /* CONFIG_SYSFB_SIMPLEFB */
 
 #endif /* _LINUX_SYSFB_H */
-- 
2.43.0

