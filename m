Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19609606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mSLHjUL2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF7D10E038;
	Thu, 29 Oct 2026 15:14:38 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B142010E038
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:14:31 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so4866015e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286870; x=1793891670;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
 b=mSLHjUL2Cw73rfedlrml4mKRoFb1FGG/jlM8YERNY/kT+al2yz7gYZ4X+vK4wuDoxo
 CrDSGOz66GYw3xMu80rjHHh8yF29R6yrL89OVLS/cQRgBqTaajL5LkMMrjuadXvvXoTf
 EXelm+Mpe4XMDhxXuHL8pimbsfSNDVv893mVVF2J+7afdFVwE1usigjstYPlDB/6CGX/
 dUvtLuLNctP4CPRKqM8Ti7YQ7y0A+4QDpRgZs+4RWfYc2gcD4yW37g26pURA7bdQPdGK
 GZ5rCIeYR49O6RdB6zKFbntCRIGyGo8RfU2aDmH7az7kfxt/6NNRL+PKiNWrmsBkwwdI
 4KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286870; x=1793891670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
 b=PX43gnCjJ50LNT6ht6BHwTw0MoNS1SVCKc9XxFuraWo7nS4TrGYi9RGYXXI2BzzkzN
 k6ww7qeHnG0rmhnKix9bHI6Ux3U8sso1gEIjrNsWiCFDWyR8SKmrybhj8G27Ly7WAJtA
 cZ1Wq1rix70Wsxc/1san2BzkSaOkXPHiPU/WI0GqPlF71xxCjcOa9WBVpAxf14Kh3lHC
 nQTtXwI8XO6ET3aR5TqbDfVBnX3xMDLXHs8KGJwJJ5qFdpl4PCBjFM+IY27qHkOtdslR
 zMK5km678U+NMSRPraZVd+TsTBtYsG3qE/R/9cyYbR5u5XT21QybYYvmkLnxiSOUEPKJ
 TeMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7YVT6jfT/wb7ay0/M0YnrW9AgTveOdaS7aS2eJCqZO1GNBGLdXN70TDp2/WMSfsUwpS6iX67wFMY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQVdb4O5iCOcsmWdEjl3znakCsoUcDOBEemw7srmLftlBwJ6Lx
 B3mxRDIORXdq8mQGpgIE4n2NuhSCzkWCu1gxVsJf9D7x6gt3XkhpjF49LrdBE9dNXtc2TyJYCM4
 LDS1dszjA
X-Gm-Gg: AYBFou1s+aXchgSI/MmiC9x32qj2Ll/2JODv6xS5R6LJiRc9ETXNk8BNRSOujaE8ifc
 5nn24xe7l2p/8cYkpNhyDpqPgyOki5Umw67PdmLiTlcb90IKo2WFCXiVQTYBkffIGPFSWZb7xDs
 stcCvGVDB1CtnHgKtTMNXv84/Sw+pavztvN8rrzDkgsEBF/Pi9kxXrIbjNYzZnjq8NWYPW4XR3Z
 UOmaqYZ9y9Krn4tvfMxJiRdiHfwBlqzJnJUJMuGMjf5PcxxAqJCXxACmtS0jXG9heAb33nIpsIc
 4Xoha28OM7tK7s1q8BIFcD+f3FtfxTOfFGQOVWM50a7TVe65ppxdT0fjNww5AR8KyjyTPFVdYeP
 RXLuIdmZ27WEJpSPYujVxf7oROKVmyqwto34Hy6uTFoAGCq6SEaY9CgJqVzc37wm6zvGHxACuB0
 yT5nXHOPbB9K1HFKuIRG8B9xBcRwKhS5X4XNqRwzELuQlggwukQ14M5BtEinwOnhcfr+D0Xavoy
 Sc0kMd4Mn4kXQpE+XShh0FGGSXgteBGDwMhAQ8EZ6M0q3eHjWKrTOqRfmlcEdUZN5t7sPUkuTKu
 8OdAUtp/cQntGjyZmEnkqtl01GIg7SYRv73OG0bxbKXvJgZs0Nmec/4Rpp+TWR3XEsb+kCKzJKc
 KT2xpHotIsLsjKVPHsJiWcQ==
X-Received: by 2002:a05:6000:2805:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48e649658c1mr5331076f8f.10.1793286869865; 
 Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: superm1@kernel.org, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amdgpu: wake a powered-off dGPU on a dock hotplug
 notify
Date: Thu, 29 Oct 2026 15:14:20 +0000
Message-ID: <20261029151422.56791-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an ASUS ROG Strix G513QY the USB-C DP alt mode lanes are driven by the Navi 22, and the firmware signals a dock being attached with Notify(<dGPU node>, 0x81) from a level triggered GPE. Nothing in the kernel listens on the dGPU's own ACPI node, so with the dGPU in D3cold the notify is lost, no hotplug reaches userspace and the external displays stay dark

1/2 adds a notify handler on the dGPU's ACPI companion for BOCO devices that requests a runtime resume. Runtime resume already re-detects every link and sends the hotplug event

2/2 handles a board where the firmware method cannot deliver the notify at all. The G513QY's CPM table notifies \_SB.PCI0.GPP0.VGA, which does not exist because the dGPU sits behind an on-package PCIe switch, so _L05 aborts with AE_NOT_FOUND. On a DMI match, and only if that path does not resolve, amdgpu takes over the GPE and does what the notify would have done

Tested on a G513QY with a USB-C dock: with both patches and no table override the displays come up after the dGPU has been left in D3cold, and the _L05 errors are gone. 2/2 is only a DMI entry and a handler, so other boards sharing the CPM table can be added to the list

The patches were written with Claude Code assistance, as the Assisted-by tags say

Mike Lothian (2):
  drm/amdgpu: runtime resume dGPU on ACPI notify from its own node
  drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 132 +++++++++++++++++++++++
 2 files changed, 136 insertions(+)

-- 
2.56.0

