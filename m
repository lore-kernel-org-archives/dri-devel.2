Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96F606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gbwot0VT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB6D10E674;
	Sun, 25 Oct 2026 04:03:21 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C54E10E674
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:03:15 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-33fb4680717so3301633eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900995; x=1793505795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8otCCaRP0Tpt6gI7v9Cl/9PTuNgaCX14b6WSefLzu7E=;
 b=Gbwot0VTu0XQstVziL6CE2n4hgUz5m/cgD2zPhHswIhWpWhaMf+DSk5XrPh1VInHVe
 xzX6jlZgeydXIiYlwTfBP0Mdku+TqXvO6nvHDJZDhP20tcDgPrCz5YtpUdQwNEoQxPtc
 ZIa0rTJ+fxqopcJyeuJWQ3oAr69pDsyffx9x55TUI/rlBbs5TOpSBXmDFP6+5vI4+7X1
 VaUH12tHW+d5OJ+y9T9JQ+xs/LW77sVsJlJtwXSvq6OpELs8LooKhwcMidf4mhAzehX/
 Y10UG+XzMpdkKQvz+EPQFsBi9DIewZFeg42iRJ5K7jUi73bnIyyP/WxsAfFnbaRlGmLk
 Clew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900995; x=1793505795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8otCCaRP0Tpt6gI7v9Cl/9PTuNgaCX14b6WSefLzu7E=;
 b=wBPRwVxFaDX7Ll8MLMtOgRocXUZHO5G+qYeIFpFpK5ZqFRx0L95G/uZ+iCWj5+YNY2
 XxXapOI0ZOhdJ7E/69R79RjHhFvLUldzBgRAUaL5iCQ52pklo6VbIHw0Qj09QF0LAEC6
 4r68CLJYmSHBFJkGy7/ewqGgJW30bQ1XehX0TK9eeaWR4MPhRRoMxW+526H9M5NLf0Bc
 /Y1pKJ3wsw1Us5iptTbWF050Y4XSry/eO/xJeLYO3T1YixqFhuZQHgaPaQ6b9ZQL76y2
 AvDR5JFocg3VdjFrTru/izzFN8w+ZCbOKRgapriQld3hqNrTuLtH079ZjLjQ5WPkQgn/
 atCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrFD+lsSiIYYYZAa7ZwGVvKPiytwPpxZHkGrQrhy2ktVjGOqUyqXBO8GMPsykSHRgtT/DlwPEWOQo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHZXRqiSGgCzE4vraJQL+cyjQ9GpLVvUehfJry5oQjboKB3wxb
 J4G34yCzR3axoDzeWF3ajCRZPQLRP7GWlbD1dUsqAYx0OupA4wSB7dM=
X-Gm-Gg: AYBFou18G1xTpnjyIWyNiIrbi7gu8gmKpw/3lvYi36+k3wlg2/1Egt0OAORtcOd8w7E
 quP2W3mh0TJkEFaFtoKDxvcOPXWiGzIMQj/eYRIVu7RdD7R9flMwt4iD7GSI7DV9547LcuWPItD
 wf3FpNh5THRgcmcxj1EZq2yJz+iOznjOUji77+x9m77djNh2fPsrkFepemVWv46L3lcc2QBiyST
 1xMt6IVY/Ex9WO45ASYhyupoM71KDMly5xlrppW/gyT3RdaACR11jWgcgOItxxaUZS37ok+Gse7
 ckjvH3E5dcCaRK5q66JufgnuYz7xVqLk5ZVnTXvjNpTJfegnowOIAlaB1/BQHL0xyxJ6MaHEoCf
 d4+xvxzPqE8MLMgnApUosRM1zX+QR8vjh9aRtm5/W9abEJmD5tUen3E7X6nV+FY4GOOQ77bYV80
 1aqIYQ1jfgIbrlhQd18x0R+VdvMVNL36uwmIs0q/vy+SXAZjgjseKqCXYuIrgOAphjt0CYQYu1S
 fupxmKHok5BOmt/lZSrYBgLAgs1fyQahdLZ8CJwi99E2QZKmYqcl7ET//MnI9MYAHyWDHs1r8VB
 IB28A1R5LFGoe+8=
X-Received: by 2002:a05:7022:297:20b0:196:82a:b80f with SMTP id
 a92af1059eb24-199374f3409mr4222106c88.45.1792900994550; 
 Sat, 24 Oct 2026 21:03:14 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:03:14 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andre Eikmeyer <dev@deq.rocks>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 08/13] platform/apple-gmux: Add documentation about iMacs
Date: Sat, 24 Oct 2026 23:59:44 -0400
Message-ID: <20261025040046.1602-9-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add documentation about iMacs

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index dda281f2f..9f0e9ecbf 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -453,6 +453,11 @@ static const struct backlight_ops gmux_bl_ops = {
  * switch the panel and the external DP connector and allocates a framebuffer
  * for the selected GPU.
  *
+ * There is iGPU present on iMac's aswell, and we can enable it using apple-set-os.
+ * But there arent any display lines going from the iGPU to the display. iGPU is only
+ * used for offloading then, it makes sense as iMac's display are massive (4K or 5K).
+ * A integrated GPU won't be able to handle that.
+ *
  * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
  * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
  * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
-- 
2.55.0

