Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB99606D819
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lp4S6666
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDB210F52F;
	Tue,  3 Nov 2026 11:36:16 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF4910F522
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:36:07 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E706B281F;
 Tue,  3 Nov 2026 12:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793705629;
 bh=NHW90e1XZxXPeQPqIgspRtbNPNmWlmAJB7VKt88omRk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lp4S6666HYpSQy+d3Vz5T74IfpYAba9LVjJhU6TdRbEKCtiaoeLFbtm3dMyCu1GH1
 KNkOmRu3gTsZuBZTlLzgW2UtbHWoDFkIScBtIAwa9K/cUpIKsmg9lQQW4GGT7z/Rh9
 4ivkwLn8v52mr1qEIWigLipQTZXnUHoFuDalmh8A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 03 Nov 2026 13:34:29 +0200
Subject: [PATCH v5 09/15] drm/tidss: oldi: Fix serial clock reference leak
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-beagley-ai-display-v5-9-f1c8d0e52bb4@ideasonboard.com>
References: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
In-Reply-To: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NHW90e1XZxXPeQPqIgspRtbNPNmWlmAJB7VKt88omRk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq6ccYw/Via5/P3qd2Fiw8clpJYn0rGM//3MChy
 1GjycnDL0KJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaunHGAAKCRD6PaqMvJYe
 9YXVD/9oRYmPR1gDW0S0gkSi1zAI0RydFfC2xDMPDMf/mQ8JdqHVwN6DDNG8s7Is765VnNbXDhf
 AU0SaPWB8YMCvk7yy/7u41FUMLLVYBZnTUPykLi0KHBRP+NKBFTXt7Q19aCWjLypEdxSvBmomYt
 6+xTrBx+9IZkDtcw62poPAq7zgJ9XfGQuLbX4HXnDN8ZnlHG6RLHiWO1vEJ1SLgwK51Sn/pg+d9
 nckOC4SqDXNXplva1xxpS0tVYb+5CJf1mFodhtfR42q+Jklotj+TEsZCa3aQ+GBoNkcIYSM2CJK
 lt6vF617rt63qN8azSW0A+m+W7rBRKFcbE+NkDxLw86zVD3P8OqqdLhDXXk8atOfhtVnCVB17eL
 OH0gU5OkbhYdgh3rnTYVeYeBEoNWtqUztoIobq1cGjI+6TAe8wpp0R2rja9IhTh1wbaTkQ3CMUz
 yepguRQrrUOtLIWIU972SvRmlvA8MKUjVL8KCNeLAsCvGR4kd/8sm9iMXHHasWmCujejLI/UvGI
 FjXhamCumEgrRhnYW0oYOxSzgVmclGxAR213AhanT6SsayBw2ULh0zUTkjrtwNrPflXVTIXnkjo
 ICOVl289B0HNHbP2OZ1KsPPJdOwEEEh9vo+eJzJ5kgM05xoWVljlsst2aCjjth+ud3oAxwh4L0l
 ge0Exhvev0B9Y2w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tidss_oldi_init() gets the OLDI serial clock with of_clk_get_by_name()
and never puts it. A clock reference leaks each time tidss unbinds, and
each time its probe fails or defers after the OLDI setup.

Get the clock with devm_get_clk_from_child() instead.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index ae27ebc7306e..506507e83112 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -609,7 +609,8 @@ int tidss_oldi_init(struct tidss_device *tidss)
 				goto err_put_node;
 			}
 
-			oldi->serial = of_clk_get_by_name(child, "serial");
+			oldi->serial = devm_get_clk_from_child(tidss->dev, child,
+							       "serial");
 			if (IS_ERR(oldi->serial)) {
 				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
 						    "OLDI%u: Failed to get serial clock.\n",

-- 
2.43.0

