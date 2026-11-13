Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1F606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5ZRS2F2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64F210ECAE;
	Fri, 13 Nov 2026 20:25:34 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5516410ECAE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:25:28 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8b305d38bafso12097427b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601527; x=1795206327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IEce9HnCl5Xd8oYfUaShuia+mJ5IeJGW6tvjAC78eNY=;
 b=p5ZRS2F2Ke3mzbhoInMuKKhdvKe/PbFFaOvAAN3OrwQF+vn7vWDCFyB3agpwZPoox0
 qr3RqzHkOWjSwxuXPZKa+iitlQ9tx764Ql4kodwKDhHYnDC/oUvlY6T5ueOdPFpYf93E
 ZsI79p+fH2p6IxB3jj8ISogPUFQt1oTYYU5aHm6Qt7QfDTOIlibYMhRpev5k4J03ljTp
 9PVIRgjdJdE81V2bYv9MnJWcVbpwX7Tf3poLGno5f/1xgU5h8shBcT8nLtn6wgKytGpo
 SwCdG6yLX0IQPg0oBYRUZpyBnCk37Bso9r1t+pQ+jFxftKMJAEKqAVxcSzkDJC29XlDH
 Yuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601527; x=1795206327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IEce9HnCl5Xd8oYfUaShuia+mJ5IeJGW6tvjAC78eNY=;
 b=jYDQKbHsRxtxYyenXkqG50HNC73EjELece+SdZC6a+FglzZS+/m1lz3xKlGqlEP2bV
 g6PpcmjpvpYfPCh7UzctEG7CFhvP5o5JaEiYEmLDXLjXh5pzQhUh8t1Hcc9sxayF57Bl
 mlk43hnXvs7tUymKsLGg2M6PeeoUfByyxBtKbYcsnm2Q4q+BzlKI0CcaHhRdYBMOvKEk
 PubVT/bWkiF5yFTY7f0o6LwcDKX/OC3NYs1eZ4KXkUhp9NFgi99tTcqWcHgzvA8K2W7D
 1veFLScxMaHGsaBq0O/2I+bbE6e/CeKYevqhClKo8wDNzVE52+mRRJZhww3CeeMlh2Cp
 +l5w==
X-Gm-Message-State: APuU4Z8rM0gxviIGdpCiEoamQEDUy6qP5og6LqigTZW+51CbBrQ49ofO
 2KEc75MkZ/2vZXwRwLNngB5MkwVwo1JxPG5XS5Bom8ZrPxQ2nhq6vmv1qv9cZkFNdlk=
X-Gm-Gg: AYBFou2Q1oY3hUHEi8c5aiLvo2k/KQGV5gttGdw34GBwNj3P9vz/aVe+/b8pIRlNevi
 8jYbYrTDMsSuWuuW2NIwLVs/n+JdEQZ+OZb9ctYgXCq6IzgTS6frYW2QlNogHvZWkPB4NRoTL4S
 wEMDs57IKGSfEsUlZIYKB3ZW6Wxq/CYO86I1NCVKUPsWRPWLeadH7gAW6IlKoMhC24ur6jRUoeq
 KSiCHRYElffYi7p4/CQdVw7WPgwoAl70Xu38qwEUInbRS/f79bWCXceioePx71GnMBfkiYxdz2E
 OcBjx6gudj0ebXF3aVR8hun+elXsb3pUJR53fyzJWQCCHGgpA0JtfkYjLTn/eeM8ohuE/RxWNCu
 +m1XdDKwUVYtWpNJSpTurt26QWOz13VVTDS3FY119HWLLnWKIZfc6orwKnQ9O+QDBCSul/XcgVb
 DYcfgwgtN8e3w/XQMGjWcAYOWS2YMe7xKLufBZiSVfy43S9CyizVjFSkdnTAbhPWTenajmUMlFK
 ESxZAzq4PyInow7D9Da57+irzlzbTaxWyejLWKhFemyo6/kH8sIf6MIUGLsG/Ge6bNy0MWk//j9
 0o8bxTOmWtBaSiG8ikw86aLDM9SeZMQHrTSbS16j3XkhgrS+gHyG2VFHcOoy/XPsAYVh
X-Received: by 2002:a05:690c:e1cc:20b0:8b2:edac:7a91 with SMTP id
 00721157ae682-8b4aa28e5d3mr18088107b3.35.1794601527228; 
 Fri, 13 Nov 2026 12:25:27 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa7ee928sm29165547b3.5.2026.11.13.12.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:25:26 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 2/10] drm/gma500: do not underflow an unpinned GEM object
Date: Fri, 13 Nov 2026 17:25:21 -0300
Message-ID: <20261113202522.14802-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
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

An unbalanced unpin decrements in_gart from zero to -1. A subsequent
pin then skips backing-page and mapping setup. Warn with the device
context and leave through out so the reservation lock is still released.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 7250bf660abd204f72e4fc07ff3e95e614252f30..920847cbc4cd7c8c1fbc4f307f29640e2ac10064 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -85,7 +85,8 @@
 	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
 		return;
 
-	WARN_ON(!pobj->in_gart);
+	if (drm_WARN_ON(dev, !pobj->in_gart))
+		goto out;
 
 	--pobj->in_gart;
 
