Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D7FCC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2EA10F59C;
	Tue, 13 Oct 2026 07:53:12 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAC710E323
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:21:27 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-3514b90bb89so3782309eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791818486; x=1792423286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EkQ2fSP0Uv8z7vsyAAy4/OpXnLsDXMhIw27wTwsr6Bc=;
 b=VBzy7Fae3h6tNPgYm4Dh9CGzKiY37YPaZBRue7ud6egQ0Kiy2VsPsBzvze9/PwHeTT
 GU2qz7cdpOzayhvHQMYORRgTXmNXS2pmX2B1BALcGyZx+WogKSybbm1pqEiGYxlFwtgc
 t9Qcq4jv1pzsE591dg4rSFcKUVM2/7nuY58ontx7+3Z+5xjjXbqocD1hdFq4Cgq3qtr7
 jQIXF97R2A8wxU9AQcPZchtzHRb8BYZ2X48maIuWwjr7dTgXJiCMND3khhqhHJsARs+l
 8BGG/lbX8rO8wqW1vYTD05ljiHf++TIeHc04UtV0BM5lNHWRoD0eNa83vaejWFV04fo/
 gF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791818486; x=1792423286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkQ2fSP0Uv8z7vsyAAy4/OpXnLsDXMhIw27wTwsr6Bc=;
 b=HdjQhf56s+jXnpoySjwZq582so0Xj2zNAAc0vM0YSZj1EYu+EAfhxM3nvvMTrE0Whs
 75dYZdViL80A3Adjn5hTR+Pf0BRDJG+fx0/pzNnHlOjpN/OzaHBNECJzG18xA4XYT0cr
 Vyp0zj+USHxJKDRL9RiV99Pa+Xmv+BzKkLjaGhNcHFqR3zRVsyjg1xXKRbVvytNvZuyu
 SRsgN/g1VgETuNoteJY/uVNqobaOKuDlQB/KHINa1/Kzvs42gftoLVXA+q+MOmQv5M2Z
 /Ebt0n7Hp0BXLjW1b+lea+rMs60Duh0rLGtj/LlVF7364Bz6EE8/Nf4W03pcXu3U+n+R
 BAsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpAiUqBStaEYUxu4NkgDnMucl1naVZgCHsQcwiuTyJMM4WLjTff3k0B4fgQKJjPly2KYKRTgcha8c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLtBw+eD8WoFq3hoiOoR8OZM9qWhEDMjUnvgwZ4PE6fDzWe9RsH
 8W+IbY2OXeXEhcyJ4A21paByaB8k1fGBZab4YtA4R+s8uF3oeF0ISZ2E
X-Gm-Gg: AYBFou0CM1HR4NKaeeTuwINWHSWbODCYOiULcPxCSm5Nras50tTiNs402uJjWGl71cf
 FMr0ErpF4WlbgP00dw6XryFZ19JsGTQ/IXgE+567LQ5/gYSrsgV+Nfk8w6NmyreG9JMX+CEDXcS
 MMgeR+MPUFIu1WwQemoTSjCagJwnNtBYBwnlPg+fR/Q/IdyT2E8FXelIaiWap4BLA1ZlULoSADf
 oyGJnSGuW+P8OoD/IBkEz2j5ZyVlf3fjf0BsNBPGuW8fsMMbdPOqrzJEAKV/mWD36zVrKGieYXR
 RxRlh4RpxYx8McvC15M0+dksavDeIrB2IxodS4ihMpmhZnZtwbQCb48IXRNWw8KSubGter1ST2G
 7kIIQUb3a2SYEeR7ZqCa9o38jafhAuURxUPnGk9D4DAxhXehn7wE1s7D9AX9YGvxzkJznwRck8E
 leinE+X01c8ApsMeBe4p3RHAftpeFd0trCGjd48lUKYid9FruAsYTod3GnkDLKIAdzfEXoIEyzH
 ZdzjHmfO663S9TmRK5SdX33ubu947PVMPEzk7gX7LPAJbkZTFT0GPVPkPKqaH8/5QoJuSWElw==
X-Received: by 2002:a05:7300:de48:b0:353:82b2:205f with SMTP id
 5a478bee46e88-35382b220a7mr12152634eec.16.1791818486220; 
 Mon, 12 Oct 2026 08:21:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:c1bb:8d21:6c07:8107])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35977229a6esm18721660eec.8.2026.10.12.08.21.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Oct 2026 08:21:25 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] accel: ethosu: Fix kernel-doc for
 ethosu_gem_cmdstream_create()
Date: Mon, 12 Oct 2026 20:51:11 +0530
Message-ID: <20261012152118.33548-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

The comment documents an exclusive_vm argument the function never had, and
leaves out data. Swap the two so the list matches the signature.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 9afe2549e..2b89f70f4 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -712,8 +712,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
  * ethosu_gem_cmdstream_create() - Create a GEM object and attach it to a handle.
  * @file: DRM file.
  * @ddev: DRM device.
- * @exclusive_vm: Exclusive VM. Not NULL if the GEM object can't be shared.
  * @size: Size of the GEM object to allocate.
+ * @data: User pointer to the command stream contents.
  * @flags: Combination of drm_ethosu_bo_flags flags.
  * @handle: Pointer holding the handle pointing to the new GEM object.
  *
-- 
2.46.0

