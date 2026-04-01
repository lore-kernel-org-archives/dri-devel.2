Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A6E7E34C
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3EC10F41F;
	Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNMVz3yL";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0AA10EC2C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 04:43:26 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43cfa33a983so2042385f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775018605; x=1775623405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l510M+KgohVojrnwIYxRsPDUxKQcFj/6FrvWzPw9d84=;
 b=BNMVz3yL65oPHJgNQakEp2iJDKjVW3E53rTSq1awRYHBGzE+kDCUkaRLH9XQsWdKMG
 KRQWaXkFT2c+QYyFh3DgeiCF5kloxpBRXQgAbqotl0ZRHADtH9c3p250mH6JqOaMMAsD
 haWA0R0lNvm/PmEbjrI+4dpWQ/Fqu/F2WnxqGLwO0MSqFUVGa6UnTNjwNgHLBeP34SBl
 bZRVPc+lwV0LoIQBLfYoTms7Fu/IfjyEKyWrKY2uUuQh7A7wF0pZBSeIFVgRl09hXIxc
 3xMfWiXbQBmwWdJKG3SeUaf5R6yxb5VP4hrgxKt4I8W7tUV8TN653Cky5RIe57SIF6eY
 gKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775018605; x=1775623405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l510M+KgohVojrnwIYxRsPDUxKQcFj/6FrvWzPw9d84=;
 b=XKmQvLb8W0OoS66NZC12y9rZiS4Ap+egSes506NgPj52d7NuxhtMCpeMsHIphPcbga
 l9wdchJQtARc/2VGN1YcCHrtgdxDzjUk2ejEXfeYQT9iLqyLblky1NIGC+233fGgny6S
 Gdj6jUY6zu1iOnfIH9E1ylI5Oxt0He+5AfRmRS1QgJse8QHIVXp2YLF950ISvqUK7nyI
 2QnBMKS2dNZ8UlRacGAlXRgFiANQLs95CpNW+C/viXtJK70lFkHhY99IIXOapvpRNDP4
 FzLSCDT8OPXRRrVg4DG5QbF8SS9WcNB+MH4+LYi72ybqd4eJrXGWUtLGwPUIxhtMefOY
 1uFQ==
X-Gm-Message-State: AOJu0YyzBYtDKebZt/CPOO+X/Gm0caNcamj+lEzf4Ms2qA7lX5BK5ReF
 Eus1PXLs112QTDz10nvTyI+MMAbImwC/6XpikJpkD4ke77LHsEQ1llvw/k0fC2NXnXM=
X-Gm-Gg: ATEYQzwJESy2mSC3Mf00VJ6MdESyRuKdIoFMo+dke1xlk3eRy4OWcul7ALA5l+NDmQo
 tqeq9lF6aVcLb8nnMDVmsFuDSBsVaChib6zzA/6c97zjRmNcdW2Ju2eVbuvw8gfGyyDi7IgElFU
 LSeS2k6qzpY1AR2D+F7/XAnX3aEVT1neJH6bEa1dUZ7j+crZWCdgKcQkx/n/MY4cIP/fFF+KDaa
 K/XSm8Y4AmJFJW9FqD/V8vi01ykERkSLhWWRaiw7/WCeh8nCQ3EZVFm2zI1ca0bi8V1Fjgipes/
 CDw1DAF+cYhjTLyrPrrlb/3aAmeL1pAzwTF4Ybw4uCY/aTGiW1Xt+3GwE8Vm9euNhkobAlfgQYI
 PHsnLAL9XZvuZgmohQhdjXEd4+RufSE8A84jZAnOOzlwonNrNkBx2EO+VkaHmRmmzea3/aoFGyK
 mpgsqE/4ZWhpIVXI1glniuxLAca9F4tM8GjNlrew==
X-Received: by 2002:a05:6000:400f:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-43d150773f8mr3246513f8f.19.1775018604882; 
 Tue, 31 Mar 2026 21:43:24 -0700 (PDT)
Received: from nuovopepe.. ([185.167.98.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e2628sm35644531f8f.6.2026.03.31.21.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 21:43:23 -0700 (PDT)
From: denis <den.demchenko@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Denis Demchenko <den.demchenko@gmail.com>
Subject: [PATCH] drm/edid: Add quirk for YUK monitor 0xaa01
Date: Wed,  1 Apr 2026 06:42:38 +0200
Message-ID: <20260401044238.15201-1-den.demchenko@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

From: Denis Demchenko <den.demchenko@gmail.com>

This monitor results in a black screen with amdgpu unless
EDID_QUIRK_FORCE_8BPC is applied.

Add a quirk to force 8bpc which fixes the issue.

Signed-off-by: Denis Demchenko <den.demchenko@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ff432ac6b..b533eb74e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -253,6 +253,9 @@ static const struct edid_quirk {
 	/* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
 	EDID_QUIRK('S', 'H', 'P', 0x154c, BIT(EDID_QUIRK_FORCE_6BPC)),
 
+	/* YUK */
+	EDID_QUIRK('Y', 'U', 'K', 0xaa01, EDID_QUIRK_FORCE_8BPC),
+
 	/*
 	 * @drm_edid_internal_quirk entries end here, following with the
 	 * @drm_edid_quirk entries.
-- 
2.43.0

