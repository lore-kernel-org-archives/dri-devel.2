Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B6606A885
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=fV03y25S;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vgFvATsG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA52A10ED1F;
	Sat, 14 Nov 2026 03:06:26 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F2810ED1F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:06:15 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id D8A421381A4D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:06:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 22:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625574; x=
 1794632774; bh=UFC6larpBIr5DXttZeaLEPmVDbveZ5IJHHjBUBp/w2Y=; b=f
 V03y25SckKlkihfV0NOh1tNU/XC+scPH6w/lKhA4vVZDeaiC/3rDLxuj3G0pH/iI
 ZpAX+fl1XW2PAtqqo4srv1Rf3D/4Ab404PGG/J+VjYN/NrcHcG1XA1L1X6e4bl9V
 Xi/xqeAOy45RM4cIKEZHj2nqVamfw8jTn2NrxCSz5NM5moaLQKwBINr15S/VAT0/
 XCZeU8DqFg1IeqUoL+BsUMyvGaeo8blM/OQ6b2JgKicFEiYr2OGGyiZHyGJ21xFt
 CIiFurWw1gaxoYtDj12CDC1qm3cXxVHTb9/wqC2RqxM2R320oZ0A64842p/sWgK9
 AvJATkACz1oqxibZctB9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625574; x=1794632774; bh=U
 FC6larpBIr5DXttZeaLEPmVDbveZ5IJHHjBUBp/w2Y=; b=vgFvATsGZQTzqNlkh
 RAQB4ddyT9Gg5aURaVxTcnaXGRvIj6AEZk8Y308mvaRJsJSU6uMpTQc6ud3jwNHR
 xXMzHNv8qagarimn5n1pL+c1LVKiBJ7lJe+lZtS8zoHIscCapt5WHwXOmteeszD8
 Z6Iumdok+iL3qQVpJs+FYCgqO4Q+Pse6NVqA0pAfGIrTS19gjb1Gc3MnPdOa7IsT
 GkUMw75NOn5SJJrB1X9Sl+1UjKPDW0Li6u6J/kIPg6C6i4y0DW1gNL5FCSeDG4rt
 FHTFJjlvdl7kOJ2VNAyy7l1WjTGUPRo6zcxnr4LFz3ue+2AWmLhCh7c9SGwR6tEJ
 oOL4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625574; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:ZJh973Si3y0Erqj3Rv+Ue3ew626O2jN9P3NWC81Jl8r8P2s
 ykBsDVvDGAfnAm7OyhUcozFSJvMds73iAL+NRbcdVOCxvzQ4kaYI4cF8wOi0z9kT
 GXtXxcApo7RXyb3k0KQeiH32EM44DctCezYD7egmD6E5LawTriW632Lm0WIB8Q8I
 fUD5wcjvrCP58KeoHISqJqBXmTlYkEPrGbvXREniZJe7D/ydEsuTAUcRM+dJlNQJ
 O5pplaUEn+B4B5kfLsKeIQfyZTdlXZgC1BnOLtv1R4o5w8TCqlJ7EHTPcNOe74Zg
 hDnK2EIFBK2Q9z4ZUH9CKUlDkVNZdfMc7V3HiMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:VVvNifg8tvk+9kHzZaQKKDrfUxMdtruCY5MGVvO5WYM=:Mc750nI15uCf+55BDoKwtBlY/uIcRLqTL9mT947qcwg=;
X-ME-Sender: <xms:JtD3aiseymqN-F8jpzUkSM47m-3Pla0q-pKTgkX3xGGpBlUaPym9RA>
 <xme:JtD3aj77XAwpZLIvfaUmclVjz0d-WgjtDHKC_LvQ3Zl0xk-BdWLp3-wHXktcpi68Y
 ZjA8fn20p5BfUAszTEEKJ_k2T2pFTRhxO0317GEvP-ll0yYbLecsDAFxQ>
X-ME-Received: <xmr:JtD3alD4VjmnmuHcudkkfTzOGSAWzdZMSHcJenONg1hgdgDzMIUn_loSVqHSfmfox3jNM78U>
X-ME-Proxy-Cause: dmFkZTEGMxOoH3y/fMppx2r36gm4cx9GYI3ohK01ZShvs6zT+8h1mVWufLahBuei4Ed1/3
 xRbUYha+QR045BDD8FCRFVIM91rSGwUQ7zMnQH1Bkat2KqUfUo8S4YHSEorvk8zLj3SaDW
 2cnjQVg1N4cjgYIFaRpoqGeOaFHkoldyad78tsE+DecFb61BS2EtavEyFF5qPgk+LGIze3
 1pj9uE4MqQ3E6Y1sY03sy7yic0nfNy3N91ax17Z8mzLg+z2lmCVcb4QExTOBMVx/MohP3G
 wnkdi+msWCJW4WkcwQvXo9jRKjLop8wk5fKsg/aLeHj4SFgb7u29HtVGx3Iv5RN6/FH7V2
 U8QJp888Vj+hKejjbSBmSr6bPwUqoIXrYowoOM9d8dbgG1Ywcpu1B2BItE0Dm6/G9VjiSt
 d5nCbVxOQ+8Pnxb6kAIvQ7TzhVVdFJ5ZuVm8c+7VjkV4OQgzM/Isc5iRlNNtl2TJdQct8g
 nPw3yt+LSQeYzHYfHKUferR8SRzjm0dBD8aqRG9BIXwv1xwPVg6GKUpTFjt5nDDDOlaJdl
 OXsVdkLauOcmIhmVSbudRfakJIstUYJcGDt797RBw+ARRChplyIZQQsn34Tdc4JK8OSpwj
 ANBphE7bq+/dnRU/VeE6UbZcxFfyXrp6rZfPz0BPwLvQp2H1fMbyyrKenxlQ
X-ME-Proxy: <xmx:JtD3aju2NJTHdcQV6VaxzjmmKLl1FOGSDFaX-GqfefK7IriluOWuZg>
 <xmx:JtD3ajP-cfKeYgTc_8X3sat5qQnqhLCWeyO5FWRg_agHjOuHQu6JSw>
 <xmx:JtD3arUEb4wHRoo-KJxpmKzpWwv1fZgP7Bys3fu9YKxj2exrMnNvog>
 <xmx:JtD3auSTPauWPhhH3sjzyeFJSnw8jU1UWo48AOnekTu6JmDlnfrF2A>
 <xmx:JtD3arSWJrwX_wsoLpwrne2YZJ5cLGMnr-8hthrWixG6GCx6kylkUF6w>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:06:05 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 03/12] accel/rocket: wait for a running IRQ handler before
 resetting a core
Date: Sat, 14 Nov 2026 16:05:20 +1300
Message-ID: <18667b2afdcaae217fa1038f5348ab23ed756bdc.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_stop() does not wait for a threaded IRQ handler that is already
running, so call synchronize_irq() after it to make sure the handler has
finished before the reset.

Before synchronize_irq(), mask the interrupt and clear the raw status, so
that the NPU core cannot report a completion afterwards.

Do this under job_lock, because the submit path sets the interrupt mask
under the same lock.

Only touch these registers when the device is powered: check with
pm_runtime_get_if_active(), so that a register access with the power
domain off cannot raise an SError.

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index b61bb4d242ce..8b4ad028bc9b 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -402,6 +402,16 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	drm_sched_stop(&core->sched, bad);
 
+	scoped_guard(mutex, &core->job_lock) {
+		if (pm_runtime_get_if_active(core->dev) > 0) {
+			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+			pm_runtime_put_autosuspend(core->dev);
+		}
+	}
+
+	synchronize_irq(core->irq);
+
 	/*
 	 * Remaining interrupts have been handled, but we might still have
 	 * stuck jobs. Let's make sure the PM counters stay balanced by
-- 
2.43.0

