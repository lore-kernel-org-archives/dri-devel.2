Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED5EC79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA6E10FA77;
	Fri,  4 Sep 2026 10:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ge/Wyc+a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E989810FA73
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:45:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C379742DE2;
 Fri,  4 Sep 2026 10:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0FA1F00ADF;
 Fri,  4 Sep 2026 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788518729;
 bh=ywgp/pHfl+lA6AvsB1zv7ftqiWMvHJVARqEHp5d3uMA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ge/Wyc+aaEqvFnsoCBLmmHxDP2ZrFsI76uOFZedKIyr3ObjIeJehqTg/E/e4qyHqz
 RS2fdjU20oGmEzZbwFbjGznSL0/Jc0/BbBAKwE+1TGN77/9r/ctsXXwNjpFK3h5N8E
 9//1N6WjKRUGuCSZLU2UPtMWn5MH8udTFO77aWBnc9Blk8heAf2sjncGA4/OUqaWiw
 hviqgWQK+x/0ZyeqTGloK7D8LR+vbsJzC5suRNfxpI/nrfbY2i2LJ8mxekylPof/SP
 QllQE4G4a05osclFK3ydp7vEZeEjmnTYfutnB68stAiHS9QQrGqYmvRiVEUGEauaI/
 YP2HaE6K0j+mQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:55 +0200
Subject: [PATCH v6 04/12] arm64/mm: Export set_direct_map_*_noflush() APIs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
In-Reply-To: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=treding@nvidia.com;
 h=from:subject:message-id; bh=aIM9S+b4eUaYPFPTqciGrMGQP2g0bdZA73J57AFYD/0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6y9LZb0fTu1fD2MuKJlskXvqXRscG5DRpw
 2HGzz+KC/WJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 oZ+tEACbMm5y/9flV4B7lKc8c7sppUYfz2sbPsDFHHFGgAEXu0hrxqgbkreSsnbS8Y9VM3SHYU6
 BIhWV65aiGSz9zanzQqW0gUp6Ik+a9ZDiQ42QrejAoXtHqLtiJIBCvBGPElSqa4nFWQKrt54t2u
 VoIWmYskkNKk4ySyAoyMQdiLxvfqDiqPcuDYOKjmHq9u3hZL5FYTCfWMsH86RPe3xq3cWhIAdgp
 CSJTdwjOtQkEk3XCT5nyw5+bW4h7LEBJ4UzuNfeT8TYCoHw1bt8gO33t8GR5XgTajrdjVC6OhrD
 ruXH+RxCak8NyrklGIImjHCjsflgXqYRWVoOG8MejJ7Kbck+ql3IpUlTuFBn8DBYhYmr7h5aEXG
 dIyUpdgttoGOllBhebafHIEs1QTAPwh39wkOefhQCLmY4NrgJhp6iORWs93GZqDVMwr2wp/37mH
 nV6fa/DQn7PtV82lupwtW7dizZAARJAj38jqpSk2fNBy8n0V9JOQl+4O9Lodc0vIJSE1GPEmuLG
 ktMY7hPZQs7PBDvedNWcLwkxqHaLWxIRj1QXn8BqTft/3FZA05MqDViAtIWTTa5df/rTUg1UW51
 MkEw02uH/BB7iJWaabxssoUEhygxoSsbRbPaCkAyHPyd6ADUyywmWGqqCq9xvJiGo1Y8sPiLj9P
 TCgI7/FYwlN/EDA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1
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

From: Thierry Reding <treding@nvidia.com>

Drivers that use this may want to be built as a module, so export them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/mm/pageattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 132938b32eb1..9253c529f8aa 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -262,6 +262,7 @@ int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages)
 	return update_range_prot((unsigned long)page_address(page),
 				 PAGE_SIZE * numpages, set_mask, clear_mask);
 }
+EXPORT_SYMBOL(set_direct_map_invalid_noflush);
 
 int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
 {
@@ -274,6 +275,7 @@ int set_direct_map_default_noflush(struct page *page, unsigned int numpages)
 	return update_range_prot((unsigned long)page_address(page),
 				 PAGE_SIZE * numpages, set_mask, clear_mask);
 }
+EXPORT_SYMBOL(set_direct_map_default_noflush);
 
 static int __set_memory_enc_dec(unsigned long addr,
 				int numpages,

-- 
2.55.0

