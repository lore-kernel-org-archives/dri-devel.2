Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59590606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kw4AMzmJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE4B11206A;
	Thu, 29 Oct 2026 07:59:20 +0000 (UTC)
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CCC10FC84
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:26:14 +0000 (UTC)
Received: by mail-dy2-f6.google.com with SMTP id
 5a478bee46e88-35adc681e1aso1710768eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793193974; x=1793798774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8lGk7ecJbJY8uCu7oKsWi906u8BzDPDWd5oQV0tOkG0=;
 b=kw4AMzmJMbzcVP8llw98fUCXijcf1y9xygnCvueYCUdTncCuLGPMwoNXZkwLfa0NR6
 U+BioRnirIXB4c4CSvPLRnii+OdnGF6BfmE3GToEo8Xj3EcRU2BFGDkceoqlM+j/C10P
 wtt2vdO02++93XoYVqCF/xAdDu85c8nqkT2XAXDfeHHOnu20TqHtHPa7sl0JuxkikmlH
 K1Wii7lS1UIg8wKIWtzkHxXA7Yb/OJTJIQTNfxAb7YFQWE0JGGh7jaIbyU+QN4zGwsgZ
 c4dNtd5vlRQE/wWKQep4MTPv0YOyQ7x7YfxLnpBd+tx3S7qHqD++Vc/R5/RAHaqWdA27
 1YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193974; x=1793798774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8lGk7ecJbJY8uCu7oKsWi906u8BzDPDWd5oQV0tOkG0=;
 b=YkXB4mJtnkpCYPNsh+Ypmhc3kchzC41MgcUZ+6nolS0NWX807p5Y5T1rPsphftqeaX
 xybm6VtUwXwtuinmGCgv4WA6JS51vxIzbTXaBwSijgfEcUm+pDnR0+5kaIxiZgqItQNT
 AY8Pt7d0dywrWz79Qjo0pvN7dlcjKrzzjjUgT3PdBoeSTh8s/+9+marq+Sg1IQybnw4c
 SRvhHvbxG5g8MhSyPSnS7nuY7yb7bdNerzRRgK76BFqS4Js5IlABpZSX1DQolSPxthsF
 xVhnQ1WJKo6IFx2N2SCrkORtzYSgak6UVMZI+s9VjtngOg+jIDE2G+R2VVL/8ykRHwI/
 P4Og==
X-Gm-Message-State: AFq9FYLagSTEeqbJ2CzPI24GsHHOCsyUpGsr7Q3/nKSDkIS18fAqdLh9
 4bRPo27jiRmrjNJvldy+GdFXc7PTV0jjnEKAOjI9LE2TC5ya3jv5v6/4gRE3mdjmPsLyXA==
X-Gm-Gg: AYBFou1B96x9oZNFnblxpOE17qUEgHJIGVwoWv4ArSVXaHY7Wv1xnbIwfggVeaMJUsF
 e6o+OpPGVYTXglixn6eV2WPzOf5SclBuOAEAZdYy7IN9gHQCeA6ZBV9nbU1iqk/bXYNpTF5mDSm
 XsfXU3dAhunJBayikpKZo0fFJLDPzW+8lDSJYnr2SSnXmkXFHWnMwDl7kHi93OISQgm/y9jlVg5
 sRAdRhe4Pa+FMbDzco9y+5iVHQPBW93zYe8N6IdW27RFdsqHzdwf1eRi5oS3qOA9We4UVIBYGR1
 h4b0AhyGg6Yy8iHeHHlGIGgR+/w5LiZGs8iLaxYTaW/wLGIqxXJo8zRu1JQUDGMhQ9GLhanMBlw
 9l+OqpuKHeml+Dks8ZHBAG5xmwOxK6GGaU5ujtnjFP0Sah3a4VVBWhTSSa939cetHJZZsnF1Xcn
 xFxijqasSKDKaAYcp6Rtlbr1z8CeEbnkkmFpZgV5E0JqV5apfnI1G6v8C/NcwSmVqYuNMhtmoHV
 WJi5U0PI3f5RAv6OLJFsQtlhw+oCGaII/fNPL+jlpCnmGCTzabyNDR0jFVXmcxqtyJOOMHqCKhZ
 bqKeDITS3vlwQ5GQC8EoA5ttd39H05wum2ELQw5q1AcodbtI35KKC9TswFk4cd2Ln+2r
X-Received: by 2002:a05:701b:4546:20b0:190:f24b:9491 with SMTP id
 a92af1059eb24-1a6cbe7ddb9mr3384162c88.12.1793193973628; 
 Wed, 28 Oct 2026 06:26:13 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com.
 [2607:8700:5500:3d9a::3]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:26:13 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ho Jie Feng <hjf3108@gmail.com>, ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 2/3] HID: quirks: Ignore Valkyrie USB LCD devices
Date: Wed, 28 Oct 2026 21:25:35 +0800
Message-ID: <20261028132536.375927-3-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028132536.375927-1-ziaowang2007@gmail.com>
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

Valkyrie USB LCD devices (0x345f:0x9132) expose a HID interface
for vendor-specific display control commands and a separate USB
interface for bulk framebuffer transfers.

The HID interface is not intended for input and should be managed
by the dedicated USB display driver instead of the HID subsystem.

Add the device to the HID quirk table with HID_QUIRK_IGNORE to
prevent the HID driver from binding to it.

Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa651..d135ea8f06 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1704,4 +1704,7 @@
 #define USB_VENDOR_ID_HUAWEI			0x12d1
 #define USB_DEVICE_ID_HUAWEI_CD30KBD		0x109b
 
+#define USB_VENDOR_ID_VALKYRIE			0x345f
+#define USB_PRODUCT_ID_VALKYRIE_LCD		0x9132
+
 #endif
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 793db001a6..70ada7320c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -226,6 +226,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE),
 		HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VALKYRIE, USB_PRODUCT_ID_VALKYRIE_LCD), HID_QUIRK_IGNORE },
 
 	{ 0 }
 };
-- 
2.56.0

