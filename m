Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB3606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBenVds8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4896D10ED7B;
	Mon, 16 Nov 2026 09:10:36 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9686B10ED7B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:10:29 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so32074685e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794820228; x=1795425028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C9RIckka3QEoQYXdkRYQVL+mSscpZNtPD7jQV6cx3Zo=;
 b=zBenVds84/WIAB9uwWJoKVd6LU/fmzbaoEEd8mJvOn2cxEqLKv089pt//NH/tJ4PDs
 gkK7f1bRZOvaK872yEH1kGHIg0hdCbBXktOzmUkKAS0j9c3i7w7awZvJh9cM4eais030
 2lFPouI+3T2ZoFTTfzMrc3cgbvxrp0V5+isD7pHR/SdhVLwhIHM6dySyH8l6LvSO4efq
 6r9WLJ7AcqCzt9idiYxWl+pEWgdqi0CGFQanIYvkNMm3u9T8el+BWoRk/5r69jXWHJ6E
 fCgsvuwx1TUAoX/gTU0JPaWMooaQCA1Ki/XLVQMgzuie2ZAgsuHcXPqWmvM6x+Xn5zl7
 YULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794820228; x=1795425028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C9RIckka3QEoQYXdkRYQVL+mSscpZNtPD7jQV6cx3Zo=;
 b=Uotzpji1wiUTQ2L+//i6MVXqv3gI8oiHGx8zFjLM8ieYkhGPsIMMDrazDgZbG//Rge
 alnU05ZT72mk80KFO/B8ReC8NTiTxbb1Yqulq3afuxtnep5bbqrCnji7F2aN8rRNg5fC
 FMNroB85UZPOlPkyYifZ9gEwkT7DM223VkSGrhfL/AqdP3MGF9TR91LRUgCUqrUDS8lv
 XIAK7DV5OIorZ2jPtHL4UIgnIhrbtpdWvelhcAwloBwfTlvpa8boCWn8HoFyfSPWbNWB
 HP286Phhy2z8jdK0IuFLVnFT0kCZF1vNtc6ZEFD9S+9Boxtv+4sTPbGkiju3BHDFrvgn
 UdFg==
X-Forwarded-Encrypted: i=1;
 AL+hErHnVYIh2fPXv/Mj/6pX/3f2SyGimc0PxgWcnf14PaCFczQaviFicXQ+3dhMK8IWV1L1V2wGDnWOXho=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yqbSlCBDiPPi3Nb9Rz/lcwDmhPPtk7wqb/rkunkDhSu3eLsrO
 4c+Iri3s/5IvVWJQX5s7VWBoeNy6Nkm6m7hslGaQhSG4YpIFJQ622XCq
X-Gm-Gg: AYBFou1oVX3dERQR/NmJmJYYXOo4yXicD/WRgqnn4ktYSK6ylLVlyulYVXQGfWQH0GZ
 O8ySEXbARZ85bOxWDD6FNEvVW5NPHz/5jlWVQONO954rWN8RcLNJSBhbD9VHkzA7OGSjXjqQ5tO
 3V2Z+AjaCkE0TVZSb9oNV/xJR9ZZXsKrxTqMiVr+/uEAl5Eb2LUn3l4NXvaJexx9rz/edXblhR9
 gNhDK7TzCJ56/oKbAuJCS1KG3NHcvvs1k8CeMhv3y7gy1Ge+t5G6k/Wo8+qkm5Lr1jqAAQ44oIq
 q/56H/h7pJFOc6elhV+FquoL/0AtQB6XqVyf67+nC7F9E/wlsEYsy93wCLGTEUBgHFxWYyX+xTR
 vZu5R0bN0LGa+69K6UZ0VC/CjqrkUpWImgoMmQafM9rv08KShj7jxV9X7UjMqv19reCfs0Wuk0s
 Depgr4r/Q9L0B794BIj4Sx5aRyuXhhQonUsrE8aHbj02YEaaNM+8/olmii+lwk005En5aRlvhv1
 /9KWgOVjFzO1SHrMyeD/RA9u7VCQguq2lWYYb/1I/9x1o1pynsDGdTUl4b+XYXRcxKFtigHvFFN
 wHmEm1A3/7WT5jRiM4CKSuBoTdeBZRJZxQ==
X-Received: by 2002:a05:600c:8010:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4bb55a6a5f0mr201848365e9.19.1794820227726; 
 Mon, 16 Nov 2026 01:10:27 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571d7e87sm188337865e9.3.2026.11.16.01.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:10:26 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: Add myself as a VKMS reviewer
Date: Mon, 16 Nov 2026 10:10:20 +0100
Message-ID: <20261116091020.88281-1-oaroraetimis@gmail.com>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS has been kinda quiet lately: the last VKMS-specific change is from
14 August, and the commits after that are tree-wide API conversions.
There is little review activity on the VKMS patches too.

I would like to try reviewing VKMS patches and help move things along.

Add myself as a reviewer so I get copied on VKMS submissions.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e48774d0..44397af566da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8842,6 +8842,7 @@ M:	Louis Chauvet <louis.chauvet@bootlin.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
 R:	Simona Vetter <simona@ffwll.ch>
 R:	Melissa Wen <melissa.srw@gmail.com>
+R:	Oarora Etimis <oaroraetimis@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
