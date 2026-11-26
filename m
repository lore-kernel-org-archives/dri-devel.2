Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495C606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNkYk/mg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9CD10E190;
	Thu, 26 Nov 2026 15:47:31 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D878510E190
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:47:24 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso18820475e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795708043; x=1796312843; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=osJXjU1rT46qebD6ckyVu2UebnPef7ubsMKDr6bH/bo=;
 b=JNkYk/mg5rozZpsLbyEhuYkoWww0y030ROLDRria3DdPCTfcgv+YVuBJgMCsPqp63M
 /HLvZjaOPcKoaRB55PYsBrecQwYf9n8f0VdOIZbr8eQ+9L++m8+ZTaKLrkcqY7lUT1tt
 PDIuKs/zeYYD1c0/3Xg8+9auRaB3J5tKFEawJg1C5IGjxlJdqDBNdrjmmXuV0Wl/za+D
 kSAQsZyQcF9MuMw7VHH9QlkfvOH4/m5lFoBl9tJOcRj0YyKvBl76gG9SemPeSMjrDfEd
 eXggLvhPlV6Y0goFQu4edyygDI8zMuaCtbkagdZFB+Iz/ZrnY6kzI7aixond4JJBGOOn
 BruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708043; x=1796312843;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=osJXjU1rT46qebD6ckyVu2UebnPef7ubsMKDr6bH/bo=;
 b=TGxLZkBStqTVi+8GbsY7Ev4oh2qZqfl71y4nC3Xy10rH3zaj3XDd30bzkw4XW4+ivG
 61TnWsqFf68OXLZQPHxyAcMVcpV95B8TWlbrrGpfx2mVmatD27UdPAxJfh6AytwhxXDu
 vqXwGXpzsEsxAbDEgkhspBGl365jNEL8s+6fiir2gxKdqvnSAmesl8jhg6sd3SjhYR7A
 s+n/1BaQRRzQCxBSCtRVK3U9ZqfYHsWRuPWU5Ei0WojHnFvTzFba7qfEjylmoriQzGwv
 ZAwdb/BOHP8UFG4Zq+WhNS8SSAsZc2TetjRgqMxL5d7b6MItnnR2pQbO3f3BUOuN+v3k
 62LQ==
X-Gm-Message-State: APuU4Z+/+Vz8Lk+XCSWVC5zA+4vFpFOxLadnp4al8erpZOwwZT5vA9PA
 XxhWQ23vQqGF5eu4xDJGZmAfPkjNFlr2ZIfNNWRaWRZOh+dyXooXLBlo
X-Gm-Gg: AZFdTZe0Nkd1pi0e2hARNXYPdgxfPRCnLrmblqfzinbMFWzg0Fm6fTbfbdwBig4V00j
 0Wq7fogeGGQPwQTXAJ4NMxyl8RMsGSQYhf7yasoB3cJoanuRkaQpFAQuGPghC2gxrlQWD5T9j2x
 gLcyu57BKZ4i3LLLn9o40+viF8tBXO2dN+J0+qzAVUOhUXV130coRxiFc/UYm5ggua3L/8/J8fa
 HxXSOpRa6Ks0IBSSqNgLqG//22pEnjkA5Ukd1EvexHjEu1MID5Cj7bRcqJc0/ajcyjWZzWkumV9
 XUogBRQ/Xz0XU+zqdaY0XbOFGRCTFh91vGrMc34fuljoZKaun0oNwVBQJR04UALXrVKbZU/NWVX
 7A97TURU4A2qee4i7or3UxnjAiQWHCdfSagBxf+0aWuvjSr28c6EoIkcV29wOwmZ88ksmawiGXF
 ZottR65cAdCNU182YtxxiXOlo7+gwcaYIhe0SVjvwagQOIZ2n0+nvfIPYQO7zRd5PZSO30QcYlK
 jtQ8/O4OuiPN3MpK4axMOXRFZbyqRgQbyfpTWR7P8ACabbezqaQkoyhOOIKQDKALcAWoO023PRc
 bcvWjyuBvfFDQn8HkDKyXY+c3XGIOrpqK2WMGf2702y9sw4aeeVXGzsj+cQ=
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id
 5b1f17b1804b1-4bb8880f283mr437100585e9.19.1795708043010; 
 Thu, 26 Nov 2026 07:47:23 -0800 (PST)
Received: from [10.56.169.198] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm683201895e9.3.2026.11.26.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:47:22 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH 0/2] drm/vkms: skip composer work that changes nothing
Date: Thu, 26 Nov 2026 16:47:06 +0100
Message-Id: <20261126-composer-fastpath-v1-0-aa7458d84a7b@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBtIAlXpVUoXMf6pU6gJmSgF8
 e5Gu/wW720kyAyhR7NRxsrCca4wt4b85OY3FI/VZLVtjbFa+fhNsUYqOCnJlUn1aLXvQod7D6p
 dygj8u57P19+yDB/4co5o3w/2D11XdQAAAA==
X-Change-ID: 20261120-composer-fastpath-8e60c7f7e58e
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch 1 reads a full-screen plane straight into the output line instead of
blending it there. Patch 2 writes the frame straight into the writeback
buffer instead of going through the 16-bit line buffer.

---
Oarora Etimis (2):
      drm/vkms: skip a blend that cannot change the frame
      drm/vkms: copy a full-screen frame straight to writeback

 drivers/gpu/drm/vkms/vkms_composer.c | 105 +++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/vkms/vkms_drv.h      |   5 ++
 drivers/gpu/drm/vkms/vkms_formats.c  |  26 +++++++++
 3 files changed, 130 insertions(+), 6 deletions(-)
---
base-commit: 5ce32a0c94a827ff44ee60898c28060714dcff75
change-id: 20261120-composer-fastpath-8e60c7f7e58e

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

