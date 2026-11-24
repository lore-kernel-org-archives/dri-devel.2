Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD35606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WhdYHOwi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B807510F353;
	Tue, 24 Nov 2026 08:39:58 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C450810E51F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:50:10 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso3832184c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795499410; x=1796104210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f28xoIuC4A9DSwr+8l0/yg5+QM7YkhZnvVxeesZhwa4=;
 b=WhdYHOwiYXLxPkM7czklPv1XGGcv6/CRu3nIyaqoagq54fxepnIde9HfvvraU1Op9f
 avshm1xgnk9BlPgdLjHg8Jy5qN0S7nRV6yxTIo8yyrNOEU9FOrnX4mMbH7v7lSEsR7hy
 Ozu5GxepIjGDeAyaoOfPCsmPjko0RLFPpHSmmfZ6XdQXprJmdjSDTOusrlxuT86xE5Rv
 CasMebcDnzjfe4HCdGxNKY2fBhyKChmtlSARV+KZEoKN2a3USzG+NdawOu8jPgwXDyZ1
 Ivw7iYfEgXfYOH+v2/30KmsWQ//As7c3YZR5nSKRWs0Gy+69/w6GfiyMcINOhAyMcCBx
 AvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499410; x=1796104210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f28xoIuC4A9DSwr+8l0/yg5+QM7YkhZnvVxeesZhwa4=;
 b=2zhNWMhkOu0DJg/NStULZSU3z6W1KqtqIV8vgvfx6Wxp+nVKX7xTPkG0E1uVqWabdm
 Z9ViRxaWcYyMlHobeWDq2/0b7IhbCIdjj61MmJfmWB/8tHIVP/4FGRgys/2Ej5nRb08C
 chYWhcu0q8I1DncowErAgjjF6aKhk7QYFNcMEUqb01l2FzoC0XhzN/t6pFd7a8LCE9PM
 pNBsBBNLoYCDtpO1sHO3oAIXI8IIcb3xZZdCjO/Q0LoTbNKVYbFqo5dxQwrADDsF9iyP
 e48+UlJFt2sEYVufjDztAsJayg36N+vYz88IK59Q16qAtrHuy/7xi10XtlMMikmVqSfS
 KB4A==
X-Gm-Message-State: APuU4Z9RIHes7T/kPTVjODR/QiejeXKfL+IgrTITVXsAdsUvhD5DliW2
 yViCcU1Xk0of9kSQy5UZB0l7BLXyCHVN4qQwhmOOg/AydJnv0d7J7cvdUidI4dQu
X-Gm-Gg: AZFdTZcG0hOw2uJqNCVl7cEeMXPptvDJQowsswNuV1+4wfRq4efiyTF8u+eHcqAsUZc
 DSxo8sdF241rQpWepnSqTVX3zMYU04aXqjU6fweS5oIOh/oodEcD3Tm9paWyh0WB+eC3GV7LS7o
 4ULuPTbCxGZva+mX1bqjUhve67ZJ5C0O3j57YBveGjFBE6nG2EcHhCgKe8L9g4gQZgwmss/ZgYV
 LDC4PpuFuAjuTBPLGZh11uB9MbZA4kd4m64od75TpQGOFXOkoRKLthj2y/qGqH+9sg9cA4EpAp5
 ApeC27n9v6HNapBhI/0bVxKPlc6stwre2hLQLqbGDxAyZjtFnChsLxXbGOPXttlvnwJlKf6GxLm
 t5YTIpbFXAEsBlNB05VWU8vLt+HO+CqR/jl3/PT2QPv5Ji33QIo8DWL6x0C9FvIJysef9J7Kwxv
 FYWC+OIOokypGCs3E8hLEbEtlHTmBjngL+r+an6gquZrbvAGAuUWfP9xvKmySgR2owOLuCl7pr8
 firszS0OfMDnz/RDoOxu39RliydmTKtGQ8s8UKibqJIWDmUlzCz5glWx/wabOF/jCANOHQgXj+0
 muSrxaghFbKnNo9KIkkonUk9Oh3pNiWicniR9iBycwOn7ra7ngAfJs5wBiT9U1sfsJwbfLocfs0
 fh/YModlGEIn2K3C7SgEk+a4JWTlRqRRiqPSejNsauWKLVnDIuA==
X-Received: by 2002:a05:701b:2707:b0:1b3:bae1:f5f3 with SMTP id
 a92af1059eb24-1b556865260mr12392281c88.6.1795499409942; 
 Mon, 23 Nov 2026 21:50:09 -0800 (PST)
Received: from localhost ([2405:201:c01e:618d:9f9e:c307:1b71:25b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd40c5sm48731476eec.10.2026.11.23.21.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:50:09 -0800 (PST)
From: Karthik Sarvan <karthiks1mail@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: louis.chauvet@bootlin.com, oaroraetimis@gmail.com, tzimmermann@suse.de,
 melissa.srw@gmail.com, simona@ffwll.ch,
 Karthik Sarvan <karthiks1mail@gmail.com>
Subject: [PATCH] drm/vkms: Add DRM_FORMAT_XBGR8888 support to writeback
Date: Tue, 24 Nov 2026 11:19:53 +0530
Message-ID: <20261124054953.39432-1-karthiks1mail@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS planes already support reading DRM_FORMAT_XBGR8888, but writeback
cannot write it yet. In the 8888 format family, writeback only supports
ARGB8888, XRGB8888, and ABGR8888.

Add a pixel write function for XBGR8888 and include it in the supported
writeback formats list so compositors and tests can capture frames in
this format.

Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c   | 10 ++++++++++
 drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 7f1f29b589e8..a89aef97cede 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -611,6 +611,14 @@ static void argb_u16_to_XRGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_
 	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
 }
 
+static void argb_u16_to_XBGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
+{
+	out_pixel[3] = 0xff;
+	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
+	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
+	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
+}
+
 static void argb_u16_to_ABGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
 {
 	out_pixel[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
@@ -977,6 +985,8 @@ pixel_write_t get_pixel_write_function(u32 format)
 		return &argb_u16_to_ARGB8888;
 	case DRM_FORMAT_XRGB8888:
 		return &argb_u16_to_XRGB8888;
+	case DRM_FORMAT_XBGR8888:
+		return &argb_u16_to_XBGR8888;
 	case DRM_FORMAT_ABGR8888:
 		return &argb_u16_to_ABGR8888;
 	case DRM_FORMAT_ARGB16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 858df1f89f66..3407b5914694 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -18,6 +18,7 @@
 static const u32 vkms_wb_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
-- 
2.56.0

