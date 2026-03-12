Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6333D106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA8210EB19;
	Fri, 13 Mar 2026 08:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9sJUD+D";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD5310EABD
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:42:46 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-466ed3bc95eso581383b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 14:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351764; cv=none;
 d=google.com; s=arc-20240605;
 b=d9sc2LPGeDHOlIfNjtUE3qBoXnRYwqSr1kQRENApViWpXXzNEPzcI001+p2w7O8D2O
 Pf9h9IGam5aJKX1AbFl5l0i6RmIGBDqAe5aqHrLOLXGTGe3sxRyiJ8uSpdIkDoTp4I0y
 fz04wsBEBIcr2LaGejKF9eoYTOV7Vl9pqNpQLMfSkmXMnzYF2lELIB53JDbcRZI6QrXR
 p0AnXUIok1lv5kA6FLuO/wOrG9lpDCCVmQUCIXLhiMWqCAi06YqmcmscjI9qgrz4wG6M
 FnVXcss5Cz/yPKQj1Ht6Igw4TYSRqzZX+0UXDNFDtWeIvuVreUC0kl4NykPQNvsu6ngo
 F4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
 fh=7vxsFeM7Z7MQ3Q/tu67Jt444C/niOcB9vrbE4jUnYgw=;
 b=KW6IBYnKQ6C1X0JuowK3Kx9+vadxj1+HDEOW4AmJ2jMKcoCQrFarljToYrDbaKIBLB
 g8G/TwHIIaj/x0aXWbmnkAIorrPzkZ/0/d2HlNI1y1a1CWG/6JEG9OJx5/7tp8R+4+HW
 VwGnPaWKJui64UYI9CO65s/eVtICjXKg8VLhfvVRpvrPWmcPEqlC4mqRFC71gXudGNLX
 B7KGldCORwdzSILgjXr8OiKc7yc6AzBQNj6j7220QWiS0cpLlcM52neWI22qfsIS6Fej
 p+pCHRGdBpq3uOLg6NosiR27Om1fHX9Btd+1ge7wKRKA9JqCmxgWl8BU+8RDXt1vrC3H
 7Q9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773351764; x=1773956564; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
 b=Q9sJUD+DVw8PFXEjVCOuDD7bJswATm4aLjniXanLXbUfvPHPExQRosIzD8c1762u5B
 A9EArXF37WLgKs6FuWIDtrMND9GUBGqbomepa2yFYzRWGspZyIypd7tk4/doJ7OIMuN+
 iZvH7S3Lg2wa/fHiFI/GxjWm89QAtquKxWJwiwQqY/IdzPXErsEB/hmSmRljh2/TTyQZ
 wXUuSrVSEOwevMJjL6zQ0b7s4OmxREPQgRRcJDB0Qwnl4s2hhw09RVoJlcVjBDRC4ow/
 NNqtoScvbv1Ahoot7HopaNRd8rcfgPqxeeN2PFqVOI9fnTWHJQvcbfZmgU6uOPDA0Soq
 UZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773351764; x=1773956564;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSg4btNtymY/4+hlVrtazwIHWia5HvYB5yobNV/mmak=;
 b=hL6X7UNIqeP9irVJ9oVAP2S2r+4khGQ2R5AirTwBzBRcPgGyDSVJ9vH/uaz/F9OFdI
 S2T5fAQWmy75GDsjFypGdjdf2laxx9g5xIZB2t8ea0EyRJYUIYWs9MpCHuVQ9gLlPCwA
 MggLX7tvkdVbK8QAn8u6mGpnz+gSQJ+N7/jVkOhVjxsN90O5MiLNYTE66sYAWtlw3z8Z
 JDO3JgH2Vm0abAvngEzFRVCEN8V/6+3CeWid848dRBsbMev1wLSc8xxQGvBGuDllReE3
 VK82O9Ku2Zuutmie/i6FbC7sT/ry4aDBUaOEjUduTk0dq7KYx1C7Ione3OPI/xSTp/Jf
 7+jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqFzVBAJy7kZrF8KKEs//tVGCPUBmtx+SFdR78uq7H7jv0qXa5dVnCJaD5+fq1p3Wpod0i5uMsgoY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAZlkS8Ezp9kVfQumdkLgpQ/76mqRbG6TVtS7BPe2f7U5uRKjd
 mswAVg4OW+2EDisc88PopFEuXFzEo9y1lVfZim08UAPx2LghCRrWNvVRudJ6lGArC+woFZ189+H
 6ladTn+jTcXHQvWgq7M4ROCV2k4TPUF4=
X-Gm-Gg: ATEYQzzvpDFIJTRXbHZWTtFiRnGQtG1z6chTcU04PhGLQl00VsVewQSa9IfiOxD65B5
 twnanuO2v4RkFBGl+AgLor25mdedSUwdq7Ydc555fS7K5IWs6k72JRFtj7v7oChmKxEF8rbfMKB
 z6Z1FbWaPnh9V8nIeDgRudB/cPYB/PbKVGU0+J8Nu49ptDxVxZfeH9r8P9MBy6r/haCfDR/Zg2Y
 Aq4JefE/QG39/HHxeUpy8POjmOQnoqo49KE5f3hCmZKPvSNAnTgdjprs3S2/Z9DsF3ZLCv6t2uB
 hlOL6is+6/2RWtgQTaP/PDPCBIoanljqXi3lefl/JeMk+OmLDEgyK/boWb2R14UxmP1brHhc8i+
 QBian
X-Received: by 2002:a05:6808:1302:b0:467:272e:896 with SMTP id
 5614622812f47-467575b0937mr476360b6e.62.1773351764539; Thu, 12 Mar 2026
 14:42:44 -0700 (PDT)
MIME-Version: 1.0
From: John S <xaum.io@gmail.com>
Date: Thu, 12 Mar 2026 22:42:31 +0100
X-Gm-Features: AaiRm538N0gSaDCFHGWanXhFr7aTxlxi-ifUVs118JNj6Hrmu2fLSBitJItsXMA
Message-ID: <CAAZVx9_Ki2h-FGemFOhykKvWxayJ26z8ji645Vsj-fdJuH4fZg@mail.gmail.com>
Subject: [PATCH] backlight: cgbc_bl: fix kernel-doc comment for struct
 cgbc_bl_data
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

Add the required 'struct cgbc_bl_data -' prefix to the kernel-doc
comment so it is properly recognized as struct documentation.

This fixes the following warning:

  drivers/video/backlight/cgbc_bl.c:29: This comment starts with
'/**', but isn't a kernel-doc comment

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 drivers/video/backlight/cgbc_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/cgbc_bl.c
b/drivers/video/backlight/cgbc_bl.c
index 9212c498e6e3..0964205ef1ab 100644
--- a/drivers/video/backlight/cgbc_bl.c
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -26,7 +26,7 @@
 #define CGBC_BL_MAX_BRIGHTNESS     100

 /**
- * CGBC backlight driver data
+ * struct cgbc_bl_data - CGBC backlight driver data
  * @dev: Pointer to the platform device
  * @cgbc: Pointer to the parent CGBC device data
  * @current_brightness: Current brightness level (0-100)
--
2.53.0
