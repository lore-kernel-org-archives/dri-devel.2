Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76916606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kya7srvA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0D010F0E6;
	Wed,  4 Nov 2026 08:58:41 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8330E10E858
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:33:21 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-35159e0092aso40231eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793777601; x=1794382401; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6RXhW7yttS8+T6Ujo6Pp8C/77aQWUYKl7npzE/fKr5c=;
 b=Kya7srvASO5sxRWf2fLswEYCdTiDJR79FjhDXMobgSJgMys+Ty0t05mak46S+cyj2u
 qavV3lMry86Ih9UArIyGuqXlq7r+z5tmysJSayCodSsut1qXuahyXLVId0Qp17sbbgDI
 61aWaR8BE/v+gTn87X8Xoy2qZUW5mfF0Fs1SH8I9JSF2nZqnCWKj6LhZRE16v3zf/AKW
 xrcInQ4P4CHuAIZZ17V1QRTWKLyq6t2Zg/Gq7UJIVW3mAgkZIVzoptzbCAbesPNMpv1G
 TnKmWk5pwGjLl68V0GagVz9CP5s95+eNY6YNFkZ8ox09fpvorpCfxmSKmnvMxpNpaEDu
 7ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777601; x=1794382401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6RXhW7yttS8+T6Ujo6Pp8C/77aQWUYKl7npzE/fKr5c=;
 b=rx97gBMtuFMVIRU0a7kJMTbYgm2YpQH8jH82Ot00YlBLtgdz744w5wY1sDsWX4AQJv
 C2VR+zTDtwV89kXcV3uYZe42fizTFjH806VjWP40fSGxJBT63rofC4bSiUcTT457bUE+
 h4kd6XLUYZPNn25+3qn4S96UIevj1foWWUuuYnBn6ToKlK4h1P87/ZAdBsn0CVcLaRio
 p6pkEPOttmdtiFGtvE92dD1KiGQKeDp/PdWMpJyVwj/7ZDPunharLw8TPBWcmQTo9Die
 7b1khYFggcJe6nfXXUJYMDUNw1TWR+G4omOWJe7N0kb4W6hBdLhDtGD4twCwyC3rue23
 trmQ==
X-Gm-Message-State: APuU4Z9nEZCjkJOkzw+jZlG7iUXsYqVnrmmuvmvzl2sfv0owl0GwYyrm
 M7w3VLaWGjGPDg1yoQL2GFlzyHUlB1419EGhBbTXsIC5oR4ccR4Yd5Mt
X-Gm-Gg: AYBFou1m9mCRZ+6NawaAXpSj/d6MaJNSHpm/zUis/mlGWH8IpHZSfGUeOmxhsFQFBd7
 fFLT7vEfh5jDwpouOjJXu0TI7DiZnJKlorU8Oym6+meM3X+lQRZ6ViZ6PnHRcAmnbntYSVerMQG
 k0/a6m8+V8pivk5wKTVc6n8+dd1IbZi34vXJXKvhQKvKM0IwCprGcWi3gDC9sp0gaf8h/MqrdPo
 Qvk3ZSzlO7BpNZedFfSN4Hcu8hSDl0qSa8dsz1k/mmfCbMJusBsJUriEaUaYFRev1vNvpvD2h5B
 DrGn0AYn4U+eVOAEIyaRh9Q1toHCx0REhIX47KEaiyut1aRHagoewjqFsuw6qcN8sCst+iUR3iz
 L2oaYNQaKthtlFMoz9SaVq+C5+8vUFE4MwsssOs4US4rl8/QL849k7IyDx1DYR3IUPRnUAIk5aI
 aIVcH5h5a01ruuntqFm40ddMNRZ93nUpmbjWL5E6fRfTBKITDjYXbQe2hQNAjQB6G8+ElkYh6SR
 IcqMxReczOrBESg0xhYEmc/W7wh2hkT0ybTkX2UdotAv6r6OwdP0u21ttokaVGpiBUpHNEeW5t7
 uhfc17uXYb48nFy34Yoej2ovQeDRG33/LpUiJ6E48A==
X-Received: by 2002:a05:7300:e9d7:10b0:36a:1452:8da9 with SMTP id
 5a478bee46e88-36a4231f759mr39423242eec.1.1793777600535; 
 Tue, 03 Nov 2026 23:33:20 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d3754sm6295359eec.14.2026.11.03.23.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:33:20 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH 0/2] i915: two teardown fixes (gen6 ppgtt ERR_PTR,
 OA config sysfs leak)
Date: Wed,  4 Nov 2026 15:33:09 +0800
Message-Id: <20261104073311.1617823-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

Two independent small fixes found by static analysis:

1/2: gen6_ppgtt_create() stores an ERR_PTR in ppgtt->base.pd when
     gen6_alloc_top_pd() fails; the teardown path
     (gen6_ppgtt_cleanup -> gen6_ppgtt_free_pd) dereferences it and
     crashes in the async release worker.  Guard both teardown sites
     with IS_ERR_OR_NULL() so an allocation failure under memory
     pressure stays a plain -ENOMEM.

2/2: i915_perf_add_config_ioctl() creates the dynamic sysfs entry
     before idr_alloc(); if idr_alloc() fails the error path frees the
     config without removing the sysfs entry, leaving attributes that
     point into freed memory (UAF read via the embedded show()
     callback).  Remove the group on that path, mirroring the remove
     ioctl's ordering.

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Chengyu Liu (2):
  i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
  i915/perf: remove sysfs entry if idr_alloc() fails in add_config

 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
 drivers/gpu/drm/i915/i915_perf.c     | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1
