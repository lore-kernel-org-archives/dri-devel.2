Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9AC79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328F510FA92;
	Fri,  4 Sep 2026 10:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SP5bfIG8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777E910FA9D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:45:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AAA441AB0;
 Fri,  4 Sep 2026 10:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836DA1F00A3E;
 Fri,  4 Sep 2026 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788518735;
 bh=kC3CPrr3PAY7P/aChmlLF9PhF6B4gfio4q7V2fdfYsc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SP5bfIG8u6MRQNywxnJUOh6EF6Ed7XpEvhzfAE1agnxOQUrgZenSUyYiBRrnUlZbM
 jeabei0jiWAmeF7c3Gn9saxPOUP7pZ5iqkH7ZmyYIEpQJjpbHja2MhP5Dpj/oGo/TQ
 Rb6q1b6xAq4lsrzhFgI/p3pwuefX/K175ft/Eztv+5FOn1sLQD23M1mmOYKhL1J0jj
 wMDfTyZ1rBdn4BFr6lAPrAzM5Blm6BxHxXkx4Hy0m+wanRE30eEj+UBbsUUL/taWGT
 gZBJEclpTDXns6tyVt2TiBet4agLrRtaQneYUTIzCZmGqmQL7OE/IXk0IixV1Pb34i
 Tyhus9nqR5Cww==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:57 +0200
Subject: [PATCH v6 06/12] of: Export of_node_to_nid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=531; i=treding@nvidia.com;
 h=from:subject:message-id; bh=XVM1jxgviVEtDinHenIJ2Kw8sOhFectSaf+1DVtDVAo=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6BHc3U4JQE7eU7NgsnGt5czLULWf+jkgKq
 OsJ4G0rIHSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 oZMoD/9xguhdwCrD8iOdtsVTh6dfItXp4r9Hbp1ZfBZm4OHIQI81YR3MZrSb2bzObPQJoXC4dRy
 ZIYhPvqOvoILsZRMwWhqyyJXQRnmIDPlqWdvNybGETu1FibVSDZxMnudxPMRKtEBRG2es5Vt///
 s7wdiWgHfZzbpnobQGL0B1q6ZLLcxoK2kkAKKKzEbMnrPameUnFH66Yi8tyqRG1XlNz6JEwt8z0
 NXNjwPRMwYMiqVSATbrGIa51QKepW1D0NeQtsAXGk/WDjMaXbdly0QpUt7RANZcBjUtNvA0Ko2N
 pe5d7gaALs7yKIUTgy/AC0WmqCkC6s2jaYTcZ+/cHl7P3+tsvIox+SfFKW5/bGSZOwAZ9hLDu4w
 d68AplnyPNl8NsOCcwDct6dphMpBzWFuOO2z44y6Ee7CJrcOMqaT8eRU3SUhQttDVB/pCVAcU3y
 rHmnZZgQwAnjDHNl+Sk8APIDNYxsv/m+KNLs2gPv2ezugy6xYbkHwnLf2j+fnaP6gTlKewgZA2Z
 4d8idRFEPqFLEYXsKG3rVDE+bywdW/uY33dz1euxG81qYT9tZKrGxRvCtWG/oQ9mWoogNlUTqvt
 OY8mocLptFLj7WMCtzyy7tPXOeq7oT4GS2flTTf+lc2cgg3pX7Rpg1QesoC5/nD7fEZFe3GyOGL
 6CeFVyhYcyTff3g==
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

Drivers buildable as a module may want to use this, so export it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/of_numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 230d5f628c1b..da2e9bd1717c 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -171,6 +171,7 @@ int of_node_to_nid(struct device_node *device)
 
 	return NUMA_NO_NODE;
 }
+EXPORT_SYMBOL(of_node_to_nid);
 
 int __init of_numa_init(void)
 {

-- 
2.55.0

