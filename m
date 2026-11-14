Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A2606A331
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhm2PQ+g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2495C10EA56;
	Sat, 14 Nov 2026 16:09:47 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F13610EB27
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:09:40 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36f8cdd30beso2135196eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672580; x=1795277380; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
 b=xhm2PQ+gT7RYFU34q2hgnLG141gGvb8vIR3Jfo10yXHMyuFMpMQL0LmMSaYz0ZI5xZ
 OkQK5yFZVcpGom9fuJ0JpbUD2HTs1riDj8Dyx3Qy4ZDaI64yh8rM4hmtlOjuIgqE9Ngu
 vnr4ayLIPfa8Vyhuxuxp56cPO/AGWVT/6UJdNnpU3LvQ3FGKv9EzpdhMYL8THZM7XUzm
 hQB+bjODeQPiyJbRjK3IpETZh65cEwMdR6kx9FnBUXmIBtZ+4cj3Pi6MBTROMOOfLymG
 yvRsJZgvjNMo0d73HEtxRasn/5id4/lpkI5CdpYsKM3DeaVi7nuwhCFVsYiZu5/zEqzh
 5ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672580; x=1795277380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ir5z9ASuMHPvYC0aOx9GZ500HHk9wmpAKRwADGNQH8=;
 b=eV8TNnpug0z6YsYXWurCgSX7HQ5NlUrB6EwrN94gQKgoCxmEVFFYoS6pkPcgOT05HF
 NO9FI1Njz5YfCJ+J6NsithswhSbybc30MTlDs9ujhprCC3BTvhlbS/omeuP75yZtTLqK
 MS05v0xTUpxS6X23EXG/OopsdCBdhbkyks/RjokO1zfKW4onb/F4WWGJam/z/+NzeZoy
 fzP7Jqg3folY+/kX2iG2ewzWuAFXpPCvxTgiQ7ZHMOFGQhgpCy0q/wLt4KaP1hwQkOib
 8t/rnfwcWlOWQEY0TNCZbIKAixA2eyZDLkPoGUnDOd/cGGdy6jd8FjKAEtbX/x93hIZT
 VftQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFk3K8W2qBNzrfxlwkZlq2E8r5EeeVHJ0eRK39ihxZUtaUnp3n4X4OpEa/f7wnMW424clI64t4SAgs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1HyE/k3vs5+2zmG7/6+3px+Fi/iGuf/5Krv7AHCcwXj2+bJY9
 c5Cts7W+5FKNMyTOFD8yN5MF4BNHOf+/yGI+5Fr2GIemKUTNcsykjf8=
X-Gm-Gg: AYBFou1A4XGghZE5my8iI2B5W7U6L55KT0v4LhfqKGConSXmISPgYaUkCFCFFOcTo13
 hxT2DUhOlHgLeOa6h+s4qLL0C72678n9EbdNTc1lTqXsM3N06HC+vnA4qq7sEd2UIFvMs7JVp/N
 Rk6uwM4E7RZZYJ8UdOyJ8BDh3/Xat3BFr1c83tqK2i1S0dgLwTbEmnmUun7lWzfX3FIFbpIdrQu
 jMQ7ZZuRN7o2JHO03O7KLOmD/j7oRwBCCwgBhQ69UfivQZGw5ooTjyX2eJdXfuKpSjN2qvH1jNi
 nV3NqEmSxQgasrv5F3vhVk49K3e3sDJqmEk0Tw2kSoakt98kJOvtPYrtczUyB4AO5V/WH0o+yo7
 qJI6PtKS8EHs6cQJXGSK52J48FZrH3Y8GbDLQ1pauj36SnHeS4AAeJvAyKYn5B5u3Hbl3izV14c
 XnlZHa5TlIUEiaBIAtGezjzkvXZi0Orrxu7mcAAg1HebW0feq1yPXKn6JKtiJCSHsvtUAVSQ7e7
 cAkrhVReexK6JQwoiTTjJ22QCjtPkA/T0xK96Ax9ZMNNFUTCAqONwqJDwH6mktNkQbMrj0KCwZ7
 d9HP26/hAUdKdwf9h+I0aBwDuoeVgMqFbIaBdjHkVqOGNVvBvU4sTlD+PF/5wkuBGsc=
X-Received: by 2002:a05:701b:4648:b0:19b:1202:77f8 with SMTP id
 a92af1059eb24-1b503192303mr5750642c88.32.1794672579670; 
 Sat, 14 Nov 2026 08:09:39 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:09:39 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: [PATCH v2 06/12] platform/apple-gmux: Add check to detect FSS
Date: Sat, 14 Nov 2026 11:06:30 -0500
Message-ID: <20261114160731.3756-7-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On MMIO macs, there is feature called FSS, we assume its
a display syncing technology between internal links
(for example 5K iMacs).

We detect it and then warn the user about it, if its broken/unavailable.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 2 ++
 include/linux/apple-gmux.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c4a953b5b..a1b7a4709 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -1196,6 +1196,8 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	gmux_enable_interrupts(gmux_data, 1);
 	gmux_read_switch_state(gmux_data);
 
+	if (type == APPLE_GMUX_TYPE_MMIO && gmux_read8(gmux_data, GMUX_PORT_FSS) & 1)
+		pr_warn("FSS Failure, display tearing expected\n");
 	/*
 	 * Retina MacBook Pros cannot switch the panel's AUX separately
 	 * and need eDP pre-calibration. They are distinguishable from
diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 206d97ffd..a4fa84500 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -22,6 +22,7 @@
 #define GMUX_PORT_VERSION_RELEASE	0x06
 #define GMUX_PORT_SWITCH_DISPLAY	0x10
 #define GMUX_PORT_SWITCH_GET_DISPLAY	0x11
+#define GMUX_PORT_FSS			0x12
 #define GMUX_PORT_INTERRUPT_ENABLE	0x14
 #define GMUX_PORT_INTERRUPT_STATUS	0x16
 #define GMUX_PORT_SWITCH_DDC		0x28
-- 
2.55.0

