Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF9606B6D4
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Q2bis67B;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=B4vCN7n/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524D010ED13;
	Sat, 14 Nov 2026 03:06:15 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F0110ED13
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:06:04 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id BF37C1381A4E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:06:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 22:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625563; x=
 1794632763; bh=jLe41rxtvqSNao2UIdbEczdLg1Uh1yqAQx73nNAS2+o=; b=Q
 2bis67BhJj54JWwFsmK/fPB8oUBjT61R0xXvk39k4dEQ/ED0y7bEKTXQMV8iig//
 3y8LnPHtsV8rnufqemKOGZDs5NaF/dq5j4k+sru2mPc7mjG1ejfcrBDJ6+QUnV2n
 Oy/LARV7p96A6se7uOBgYURdC0I+6kvJnRnGgVOEz74Jn/M2ojUP8tG+joaSuxBP
 2VOakmQ5dgP5C/NtfvjJGLTeaP1nMzS3REmWHQ7K2k19cjvFZgOJgu7wchOYKyQb
 2/UlX/GTY6iWwT1iZVu0IrKpLJc72jej7SH6Sar7pcJkiCUpTO2WRYM5Z8/FH6vC
 sHUqP1TYbpqOP50YarJTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625563; x=1794632763; bh=j
 Le41rxtvqSNao2UIdbEczdLg1Uh1yqAQx73nNAS2+o=; b=B4vCN7n/WzyEO7hNX
 rzQ0pKADmvpvu3gLLsXUGnytSEF658SWm1+tAJkrxi7L7tB8xSRdxbAQrIPTzHme
 klxZEhcJee0Nz3nhGNVkAfzDOJedaWZzoQPjJsXUOi+ZueuTtOc3koCLDtR9yTLc
 G8fqkDixoPC5e9zCW9S43iNMPqpGsfbqvEmsdF5Jrli09Dp9XAZqXeStaQEHmWgC
 zDugmbEa2Aux1cM8S8DNpRXDmgB8TNPF2vc2iseRheCl2phZhhC+vZOu3RWLxJUi
 0hoIoX0gWrHhLabLCd/mWeEGPVUPpWTHZxxNz+m95QuJe/zyN5ktcOLTgk3ilQK9
 32v0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625563; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:PJptde8QmQsxdPHtNLgSON8da8j6fATup2SKYogOqr9LDaf
 ro4114jT2Tn6JOHp2t9kfSWBI33H6mrUkizpdu7p/E3SqdnzeWututgeu/az0BmS
 1lI3xrxAHLkz5f1QsKFii+WTTedkzLsfM5NAvYxsTPkGDZBLwRLbx2+lcyTKxlTJ
 d4haHjlsLOap0mKGbCX88m/Lg6cOWxuWUww3FZqsOJpS/jjtHOENnzzP8EwqXA8M
 ELJy15NoJLfT77zcQKb/hypS59poVzCzhSNqeXnv2VHfabhOXyiAElzXxjO1Gxxx
 jJf+46Ur7l8BgcGmaQvAvumCRU0rY33nz3YMtAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:KkU9OItywWMXa8xCxJXvpsCUuVVYeELHJ3ZywXHw29k=:7oH1PnecAoj3OHP3QYcSMmdKkLdmCJWxLcqrSSziT3Y=;
X-ME-Sender: <xms:G9D3aoSLjEKSjs0QnKzQZxIP6-1_QH3SZvtWjCxW5jZ4lavCL_FpGQ>
 <xme:G9D3aiOAb5Tdj7A3IpUIelKXn8T3Yj0CumWmHOcP1r8afC5npJEsTe7fVryhWgiMG
 lqO47uLsWHuXu4dYYqmRr2YU7AAedGCvblygfz3nKGZ73xMcyiVdP4>
X-ME-Received: <xmr:G9D3atFLu-VezKaxS5G_SCUZwFk9xOuQinha3XV4xVq12sYK-7dFJD7TyF559-jCzI8cRDJT>
X-ME-Proxy-Cause: dmFkZTENh3Cq6bNtRDDqH//naJpK03OGhXB8Cp3eHHX2EpHYf2oBjZ1/43ruyqVDLzR5bI
 q7gV+k53czH7SJj0JMNaMvWBGkaUqaereb01ifHpul1q14DobEKJC2mDvQQE3HzqoOU9gl
 QO0UnCSJOnNpWmY1qWdj/IivEZ+5eJmA8XcRYmqsfPBSZaKqk9zCnQvCGUQuYFJdsYZGP5
 L8zECb373LU+oefpY9jKwOjkFDiU4CWxV3iExHL3zPnpeZwM1wkFJxhm/yJk+2AJ3ju4OO
 RXCknd9xSS299sQU1FiikwzYfEAyF9m0XTBIDoIn2qfRRJDU3uzKkImCFIAQPMS5Q++UYK
 QT1oghQMiLOEEDqc0qJ2Gei+8zpQ5h9f1GYvfROcAztvhWDSYxYdo7YMX5wTM18aoSALCm
 5wmJdp6uvygPFmK2xbqZJXBBZNVNDur6w2x2R+bjTrWRDzbVjqipo8zxlImtnjuEE2Axc7
 ItcGzHZc78kbodAWVyQNpFeV2lkhDDCBF9t//GsvyG9IzF3/sIS52PfJEVWqLlmwMsV53K
 EL/8bvqplcZ8FBIW3bT38f5Tl9LDGu+Jq1EYTJ9OPScIzc3/mocusb9PEy8pvTlTds4dJq
 769cqL/rDifX+Q8SPEOIgG1wgVJEnt2qDoXmVrFsx+prKT7w1Ok45BQYUvJg
X-ME-Proxy: <xmx:G9D3aigq3vbtqueHcg0UsqjvBJRwNtI4s75DY3xgp5q9zKbcCgwSHQ>
 <xmx:G9D3ahxIO5dRfxtiOQbhCQ1vw4P4ZraV2l8EoGdD2osR-4nivWdfuA>
 <xmx:G9D3aurSVr-PJOhlMIHENeO7J5-BcCe-lyq2nJBVoES5EcV0sF6FXw>
 <xmx:G9D3anX-D6pijwhcb6qgMYEHOZwUHOGnlmQWdLjm60KDC4oUovc4dQ>
 <xmx:G9D3ajV36tZGG6rr-HBXMH2F8KK2KwTCPBxXcodFKRJ7ZNBER7416FpB>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:05:54 -0500 (EST)
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
Subject: [PATCH v17 02/12] accel/rocket: take the completion register writes
 under job_lock
Date: Sat, 14 Nov 2026 16:05:19 +1300
Message-ID: <1adbff3238fd312e23daab83ed936ad13d7f223f.1794615323.git.gahing@gahingwoo.com>
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

The IRQ handler writes OPERATION_ENABLE and INTERRUPT_CLEAR before it
takes job_lock, while rocket_job_hw_submit() sets OPERATION_ENABLE to 1
under that lock.

If the two run at the same time, the 0 written by the IRQ handler can
overwrite the 1 written for a new task and stop a task that has just
started.

Move both writes into the existing scoped_guard(), so they are under the
same lock as the submit.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/accel/rocket/rocket_job.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index b2a00992c889..b61bb4d242ce 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -371,10 +371,15 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
 
-	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * Stopping the block belongs under the lock. hw_submit() writes
+		 * OPERATION_ENABLE too, and outside the lock this zero can land
+		 * after that one and stop a task that has only just started.
+		 */
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
 			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
 				rocket_job_hw_submit(core, core->in_flight_job);
@@ -386,6 +391,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
 		}
+	}
 }
 
 static void
-- 
2.43.0

