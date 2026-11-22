Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A936606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b/Wy6KJU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FA210E09C;
	Sun, 22 Nov 2026 14:36:14 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C9810E09C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 14:36:08 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso1360776f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1795358167; x=1795962967;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
 b=b/Wy6KJUM2gaBntoApG9Lkfdw4vomCaxodktDo3g3+d/sAzQ1r1ahi2e+yQ0qPct73
 OwbKfwAC3qC84lxnX3JsXwehDTPn7rsiG0cSACNVMnUTCvX/2cKKJ42wYQyP19fMBG0c
 rkFx2QQVIxjBVACE9w7E1F3Hu+G/v9Hjr0uXRaJxQ3N9MDNMPfrRuQETKRVjsFuENUro
 6mNE4mn4GO3NPEVohE31faFAFXJ7kK783rQxyEBD5ZFbUgYc3PPK6Z4Udrbvmlf9rK6H
 C9iQE097eLFD26fdiqVLxoa7CleB9x2Ixcif36R5nkRM3UQFAy3hu/7msf+V/e+xZuTq
 BuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795358167; x=1795962967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UwlgMhtfF4zQkD33jes8kjf3uie033JQr05RFNboNL4=;
 b=iyFoptDrqpzpfMSM6fcVvTiP/uWN70i7pmmyokFJNKnucboDfudakcxAddoXITDybP
 iscvN5yc24TqzNJ9ax5hmSWfnbFiVppow7BTZ/Y3QoXcIPPk7ZEBsq4vE5u4QUEDsk4/
 zSB6eOzSDv3+OayaMh8Gkbv6TNZW/HiAMIkBjbHPn/JdesPfbI9YmLAwzWbP730bg43G
 z/7Le4DuaOBdBUtHY9losMrrM/BWbGhp6oQ5Gwz8DhOBvCIdVfg4v1CvXDwaKpHM+44S
 fTFMOHEn1v2ukbMYcUkyTiAIZxE3lzNbWkkELhh5OJZBCFHnSy/p6/QhRi8BkyXVI8aZ
 HIKA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFx4H8O9LjwhFsdu7ZP6d2UG7+byunzLy9cO637WO5zSxCGOdH+Vgn4bJxALW5284cPEmxu+oBLNE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+/p8lUWHo9UyQJWQJuPMi9l4BMkIdjyBvxIhk4kcrf8u2JDbVS
 7ZEOD52fUaD22WdCIIRD5o6/UirMQ1GZprYUqWuEiEEwBE6Zr73KrFP7A0TjEBF8jQ==
X-Gm-Gg: AZFdTZdDJnkIySFJpmnZHIZokqiMrzY3O3JW1bW1ih8f5UC1w4xN2Dv9OzrwUzCvU09
 EtLT/OMlDAVLBQmcTqOWFKTD+JzGJ6JhcF4AeD7lLsBunHkL0xf87bBhWbCZOpuhVQpD0H47sD1
 18UQzkHP6Ua0RdkBclV3zh9R1GdV644SzANZxHkGVIHFnAR3Zbh+6bhVWpMrYUPQQfOHeI4U/cy
 gF+Sl/DcCVEgHTKtMua+BYB0fZ7l+d50J9JVLltF02CNf4YaOO1/jySURI9TwxZKBrPFnNBBCYn
 JgQGfzFXXnZpFxuDwn15qaZddkVX4J88bFQ1QjPaz9a4rWZhSEiLpV1czv69wNTpo88GmvTmZPd
 uKsi0VXCKjLusm0oevmRO8diUySHc4V++53NduzkmvocfwCBChYoX7vaAWNHB5x9UVckhoqp0Xz
 R/DFJPwwlULXlbCxJN4PdiorStfk3KQ/juWOYUNJaTnNOKCT9+xlUT+h3M20utxEthHiCi4nDYT
 8hGECMzIxRM0V8wB1EnWmTiH4KW/Ltk69kCL2KeXuHSnC+MGvmy4xd9w3kgSBZ/el8cskbrnIE6
 l7Px3cd4mDnnbIPo5nPvVJ/JIJhoUmSjhxfKo/1rqjX95MaSwyrppbocDjtwy7KDjucEQAurTji
 W
X-Received: by 2002:a05:6000:4616:b0:4a8:cf12:6f34 with SMTP id
 ffacd0b85a97d-4abaab6318fmr18378688f8f.4.1795358166624; 
 Sun, 22 Nov 2026 06:36:06 -0800 (PST)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm18945409f8f.24.2026.11.22.06.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 06:36:04 -0800 (PST)
From: Mike Lothian <mike@fireburn.co.uk>
To: superm1@kernel.org
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Date: Sun, 22 Nov 2026 14:35:57 +0000
Message-ID: <20261122143557.2412982-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mario,

Thanks for the CPM _L05 quirk. I've tested it on the G513QY (BIOS G513QY.335) with the dGPU runtime-resume patch on top. The boot log shows `CPM: \_GPE._L05 notifies missing \_SB.PCI0.GPP0.VGA, using \_SB.PCI0.GPP0.SWUS.SWDS.VGA instead`, and the external displays come up after a dock attach with the dGPU in D3cold

Feel free to add my Tested-by

Mike
