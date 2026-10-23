Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB845606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FhB8r1IP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD5410E63F;
	Fri, 23 Oct 2026 12:53:38 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1EBF10E63F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792760002;
 bh=6BMm0+L9ugK8ae7NoxjQW6OB9USnAUn9c/SRYGNMeB0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FhB8r1IP0ESIcW4QzaKANIt8gxPRl4NcOInkIvYEEYYwmhmHvnnhpD9QyaPTesf8q
 Blga0aGjCZnpvtTORy0gQqSk9fnz6WCwrlOZzXwETSyFCq6pvEE6oQBQbjSPQwXIwf
 P8lv46Vvcv5oYfoaZtW1D3LCrjkFaN31ayaw6+hmoI1bDZy6bqZujS4FCfJR6JWhR1
 YQyl0fDdDL47VA8NngRJnJ/txP3ClewQWNHLFFzshdCYyPVqpAsCPjcI/a71P+Lxh+
 RpPg5Gqo9djnEFDOd+bNmuID6yReMybMVPgpAFhvBKqkTq2hJeYQR8frQ1104WBc0p
 ZbrBWyfJvVvMA==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C26517E05F3;
 Fri, 23 Oct 2026 14:53:22 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH v3 2/2] drm/panthor: Delegate neural power domain to CSF when
 present
Date: Fri, 23 Oct 2026 13:53:12 +0100
Message-ID: <20261023125319.35905-3-daniels@collabora.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023125319.35905-1-daniels@collabora.com>
References: <20261023125319.35905-1-daniels@collabora.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As the neural power domain is a child of the L2 power domain, control
over the L2 domain cannot be delegated to CSF unless the neural domain
has first been delegated. Given that we delegate all power control on
v14+, this eventually causes a hard lock-up and/or firmware OOPS when we
try to power on anything due to the inconsistent delegation state.

Fixes: ee4f9af07933 ("drm/panthor: Implement L2 power on/off via PWR_CONTROL")
Signed-off-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---

v3:
  - Fix ordering of domain retraction on delegation error

v2: 
  - Send the correct patchset, fixing compilation errors

 drivers/gpu/drm/panthor/panthor_pwr.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index dd7b6ef8ea209..b1000001325ea 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -146,6 +146,8 @@ static const char *get_domain_name(u8 domain)
 		return "Base";
 	case PWR_COMMAND_DOMAIN_STACK:
 		return "Stack";
+	case PWR_COMMAND_DOMAIN_NEURAL:
+		return "Neural";
 	}
 	return "Unknown";
 }
@@ -163,6 +165,8 @@ static u32 get_domain_base(u8 domain)
 		return PWR_BASE_PRESENT;
 	case PWR_COMMAND_DOMAIN_STACK:
 		return PWR_STACK_PRESENT;
+	case PWR_COMMAND_DOMAIN_NEURAL:
+		return PWR_NEURAL_PRESENT;
 	}
 	return 0;
 }
@@ -229,6 +233,15 @@ static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
 	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
 	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
+
+	if (panthor_hw_has_neural(ptdev)) {
+		drm_info(&ptdev->base, "NEURAL_PRESENT:  0x%016llx",
+			 gpu_read64(pwr->iomem, PWR_NEURAL_PRESENT));
+		drm_info(&ptdev->base, "NEURAL_PWRTRANS: 0x%016llx",
+			 gpu_read64(pwr->iomem, PWR_NEURAL_PWRTRANS));
+		drm_info(&ptdev->base, "NEURAL_READY:    0x%016llx",
+			 gpu_read64(pwr->iomem, PWR_NEURAL_READY));
+	}
 }
 
 static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
@@ -405,9 +418,15 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
 	if (!ptdev->pwr)
 		return 0;
 
+	if (panthor_hw_has_neural(ptdev)) {
+		ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
+		if (ret)
+			return ret;
+	}
+
 	ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);
 	if (ret)
-		return ret;
+		goto err_retract_neural;
 
 	ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_TILER);
 	if (ret)
@@ -417,6 +436,9 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
 
 err_retract_shader:
 	retract_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);
+err_retract_neural:
+	if (panthor_hw_has_neural(ptdev))
+		retract_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
 
 	return ret;
 }
@@ -517,6 +539,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 	struct panthor_pwr *pwr = ptdev->pwr;
 	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
 	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
+	const bool has_neural = panthor_hw_has_neural(ptdev);
 
 	/* Abort if L2 power off constraints are not satisfied */
 	if (!(pwr_status & l2_allow_mask)) {
@@ -530,6 +553,10 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 	 * host control to be powered down in the right order before powering
 	 * down the L2.
 	 */
+	if (has_neural &&
+	    panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_NEURAL))
+		return;
+
 	if (panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER))
 		return;
 
-- 
2.47.3

