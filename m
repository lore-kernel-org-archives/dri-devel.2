Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321D606D820
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kiawiyfz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D6C112C7F;
	Fri,  6 Nov 2026 09:19:35 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2F71127C4
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 08:29:52 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so2836745e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 00:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793953791; x=1794558591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FV6+YGdIETQDXmaKkzArgryzPlYSSZdr4Z4q7PvMtBE=;
 b=KiawiyfzGHHb/Eh4YxN9Ts6DjKFrAk+a+gIsQ+kgjz+FwGIUMLJapFZX4Eqy2hikRp
 Af5sibIqu9vt/hT3efJjp36SixFmX8tlvWZW+5u3CmQoPSbg9keMsywz15BxeArKBbPg
 pZS4vG/JmwIzmwIS7mO88DFEluQsnfDycK3hSijmjuKgFJq3hskV42SS11wVHvSPL9Pi
 xiv4GkSnUoaVAn78x5F//1As359MXk2l+CJWKq6rmJSS9npya/QalRsa0896F2m1VLLP
 z6UeD4mQkL3XSeHpBiNUn4c6e+f246ctcoy7Jpjtm7jMoeeX4USdW6VXPERceS1Mco12
 Q4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793953791; x=1794558591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FV6+YGdIETQDXmaKkzArgryzPlYSSZdr4Z4q7PvMtBE=;
 b=TtmWx52u4sbcVJejvQ4RdBPekzT73ylUYFmGuIUWzUBu80Og6p8WRbs93eRvaoJXbK
 q1dOSBETArH0MjCYXlGTOGmdiIjIgTwbKfv48LNGu7JvODLbG9ZrCQgbHTDAMEfNti3x
 grxFSH7hX8pl+EniMOf16mqQgTCBJXle8pDsLqSNVlnpWnUFGs5GXBFSqtVALzCqNuyV
 FguMfDNgjCzz+Tjnl28pmevhHr/flTSXY7BLN6fuZ8p2xT+huFOJp5CUJbI+/87izFuA
 JAIf8aTU5GBWsKK7Pld5fff3/CFeCgMnmdzzOKs81P0k5jrVJPl6DZi/quVMPXCZHdAB
 g/+g==
X-Gm-Message-State: APuU4Z/yFNECIJZwwKn7C7mJe7V5okuSSinXXLMzqmOLGW12dUzppOsN
 ZydzR36p/DGm8SQwQkK6/s30g0xNKQtQQNzFBkvU/OdBIz5Sl//u3a08ITs+nA==
X-Gm-Gg: AYBFou2t3Qvo3toUVdnn0Dtj+nracQUtU4HL4vNsFwTA18hnA7ZxveqwQUso+vtPQKZ
 I26m81I1VtNbdLl4eDHsZPDzebB32BKXC+JF7dd3ye+PIfTIjpRwVmmUQK8HuFH7bisddx9cl0W
 DlAHg5zd7WrZBn9v46DASB1+cB1AIK2nyoZ2jdxBY2S05G6KLwTw6df6aZGBWU7V9e9LBsRmnG/
 vUqFe4GUZ/vtIcrw5pr8MJ+YK+yPjMD5XzYTpgb19Qdk52Q8JdcglH8d4265vYE886sH8Ru/ASM
 Wc03poLokqHfAbcPNku4Mbfyb4oJWcKJwY03JUKMre1jkOt+XRNxiwhPhpP/hdxN3Pmyu8AMREr
 vcmFA9e4p2KvwNOeO369pFQXosHevDKDwFpc9pk1i1cTguo07qhIbgxbyBK4PjfdQ1iP84Ps3wu
 N/E+sRG55x3LEzxe4OFf4eRIeY2misTqR5hN3WWW0CFAH0tTgxjtaVuOYs9hurrWEJHBsTo4OWl
 gS+tshXGZ1mqODZkYZrxHZCf1teS/L8bcqgmLnb/Mohz02k9GefFZdSroY+IXmSV6eLzdRs9oaB
 nmb12IAfEomPDi2kutnGFuZhqD4yY0QfBLgoOPyLeBwLiGDbeg==
X-Received: by 2002:a05:600c:8718:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4b6ddcf599fmr27075105e9.15.1793953790929; 
 Fri, 06 Nov 2026 00:29:50 -0800 (PST)
Received: from infinity.. ([102.45.26.9])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4b741cdd8d7sm18559645e9.1.2026.11.06.00.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 00:29:50 -0800 (PST)
From: Reda Maher <eng.redamaher@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Reda Maher <eng.redamaher@gmail.com>
Subject: [PATCH libdrm] man: Fix dumb buffer size calculation
Date: Fri,  6 Nov 2026 10:29:47 +0200
Message-ID: <20261106082947.7097-1-eng.redamaher@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
