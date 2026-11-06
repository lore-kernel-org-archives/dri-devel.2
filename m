Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8E606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQHUzMY8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C9E112C68;
	Fri,  6 Nov 2026 09:19:00 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAB210E385
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:11:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so2347925e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 00:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793952686; x=1794557486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqbATXvReNereFHnvS7/ZU2g593rz5WIP7NZDNLFGrY=;
 b=fQHUzMY88WpuX17bwVL+9nCOPkUtsp7JFedRwbTx8c8yH1SZWKBcZUmJ2Gov9VpFZw
 7a6o99ansnqbEEDh1UUqDEVGDUA/PEsFu8X12WmX93M80zyWADMtuGdZet+gsPKxqiT1
 j9kqKlxAxv4//7RI7odsAn2+rQiYhMffupSfHevVCjHIdJz8mXHMRkGqy4ge4yoFr3xC
 mXvCe2XjrUKqDccZqQgovXsuvO7+ApDAK1BZuq8/Gwm2arehgA+eUtSpGCarvhwfM45T
 4NBxFaId8ttuoHQgntIkVd4iHBq0VD6yatQYzMoZZST898jU/3MWHUTJcmTksqKSBEIo
 oINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793952686; x=1794557486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bqbATXvReNereFHnvS7/ZU2g593rz5WIP7NZDNLFGrY=;
 b=taFZAgX3rWcU6V5Sm0TedGcEmStPZaDQ4BI7Y4OAULv5mTGSPeNp5QprbT5PRUTNBu
 PaH8czV5jZAChR/nOXStBRwNkmEofv60F2VABVQtXVnsbq9fDMkbykdNp/q4h8Gtefgh
 xDkf7wPf/s3BX9DOPpnSmwOSqsAyvI0rUYQjsX2LaOXvz84gXUso8Zywewm4UgLQOtZX
 9TBuwk1SL8DtG3UO8+Ewymp4zjtnj/0RsrYR5RShJExWp4Igd9Fwvq4xS3v+KiyiFfOJ
 BLi/z2EG9E2SQ5ykv3rY9pjh9nQTLtPiksbRbTSt7FUkSylnxORrhlsgSAhSlKFON+Lo
 15iA==
X-Gm-Message-State: APuU4Z/eOcNZG9htkJe1VA6mGys6RJ+oKfUeeaLs5SYANl4OXJZelHAi
 RXD/tXq5Ki6j1Gtm7eJJ3mgQ5D4xuzDmQ6RmdgKSDtWSkmuTaWN/QWOF1BYe4Q==
X-Gm-Gg: AYBFou168klMBUw7dH6l+BZfcwxJUXUb++uyUz9W98UGDMjBxuuuckbqc6BBxW55dS8
 TZSX/glLbp6HGp58+JOFDHKNn6vhXP3DidM03/bz8yliV49fpIsgIm4N/gZudYMdTTg8UeocBsT
 QPWuY9U9GeIx3Aoo5s8Q6HcygUu02RS/CDG8JdpeuzkSK2t4qE6bZj7nPrBNGhrbhcpyVTOVT52
 qnOqeeB1CWFgpFHEmf7oFXqzJUMP2p84qOlMWVBfykJcttymRBUVHpIzo0LYovdqbR4XZ7iJsB/
 m+KJm5pgFxUlhNRUBxSCq2G6rPLFXUkZEeNrhIyamwpOg2CRJbzlXlCoS80cBHr2mJSNxO0/kYJ
 JBxMM25wii7NzMDmOivPuY3ueboP6aBM+6dyKmnZ1KRNwoS8+F+k8h/b3LGF20Hoyh9TvZa34dy
 FSak2LRuSm7sfVrQy130nmIhPIDbAIGlt0dkiUTL7wMh/hPccMQVtjRU71W6dvu0+hWUF14Os58
 U1ogOu6W4W+4VYE6Fep0S1It8B0PgpNA8w8SRU/gocvxyj32knNMYcJt0l0Q5kHHRTWmWYd0Zf+
 kMsUEq5FoTxr3ZKHUQNLEUxR+4xm
X-Received: by 2002:a05:600c:3e08:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4b6db4a9ea1mr21926465e9.3.1793952685705; 
 Fri, 06 Nov 2026 00:11:25 -0800 (PST)
Received: from infinity.. ([102.45.26.9])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-492d7bcfcbfsm2217734f8f.43.2026.11.06.00.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 00:11:25 -0800 (PST)
From: Reda Maher <eng.redamaher@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Reda Maher <eng.redamaher@gmail.com>,
 Copilot <223556219+Copilot@users.noreply.github.com>
Subject: [PATCH libdrm] man: Fix dumb buffer size calculation
Date: Fri,  6 Nov 2026 10:11:19 +0200
Message-ID: <20261106081119.6462-1-eng.redamaher@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The documented size formula mixes a byte stride with a pixel width and
applies an incorrect bits-to-bytes conversion to a value that already
includes the pixel storage size.

Clarify that pitch is measured in bytes and includes row padding, so the
rows occupy height * pitch bytes. Explain that allocation alignment may
increase the returned size and that callers should use that size when
mapping the buffer.

This is a documentation-only change with no runtime behavior changes.

Signed-off-by: Reda Maher <eng.redamaher@gmail.com>
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 man/drm-memory.7.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
diff --git a/man/drm-memory.7.rst b/man/drm-memory.7.rst
index 9aa75e01..80aeda41 100644
--- a/man/drm-memory.7.rst
+++ b/man/drm-memory.7.rst
@@ -72,10 +72,12 @@ must be zeroed. Different flags to modify the behavior may be added in the
 future. After calling the ioctl, the handle, pitch and size fields are filled
 by the kernel. *handle* is a 32-bit gem handle that identifies the buffer. This
 is used by several other calls that take a gem-handle or memory-buffer as
-argument. The *pitch* field is the pitch (or stride) of the new buffer. Most
-drivers use 32-bit or 64-bit aligned stride-values. The size field contains the
-absolute size in bytes of the buffer. This can normally also be computed with
-``(height * pitch + width) * bpp / 4``.
+argument. The *pitch* field is the pitch (or stride) of the new buffer in bytes,
+including any padding between rows. Most drivers use 32-bit or 64-bit aligned
+stride-values. The rows occupy ``height * pitch`` bytes. The *size* field
+contains the total allocation size in bytes, which may be larger due to
+alignment requirements. Use the returned *size* when mapping the buffer rather
+than computing it from the dimensions.
 
 To prepare the buffer for **mmap**\ (2) you need to use the
 ``DRM_IOCTL_MODE_MAP_DUMB`` ioctl. It takes as argument a structure of type
