Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5787AC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A4C10EFB0;
	Wed,  9 Sep 2026 08:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1Vei0Zc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269C210EFAB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0593D41AA3;
 Wed,  9 Sep 2026 08:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA5AAC2BCFC;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788941524;
 bh=GaY6f8fhEOXebtecp+sLG5gXB/EVaGxFcy+c3bl2LB0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=T1Vei0ZcZr0GRHMAX8SpopiHwa7ViqI1F+bu3D1v5Ocnd6lh40XZsM9rS+fzHvLb5
 D5fcf/IqUh2babwqiukvvnCHtzkuY2l2mdE88Jn0mbmnm7uGPjE9OJE/u2jP/pFZis
 seR91NwFEFJFB+OXWowkfqysmpVpvbadMhkzb1qIXRVJEZQGA4tgS+jO7cq8RTKK0v
 vcWW9IvPwC0lxEAKyOEGm0mDjI9plFe75oJNa55gesomDKT9GqshITwq44XQ+J3w/7
 qrCsRT6IKz/K2nLVpXkOU+p3rxOJiLplSVmdnkVwtc+rDv03RSkiG5Ei11Umb5Oh7h
 sikBk8SaSBYFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A9BF5C79FB8;
 Wed,  9 Sep 2026 08:12:04 +0000 (UTC)
From: Joel Selvaraj via B4 Relay <devnull+foss.joelselvaraj.com@kernel.org>
Date: Wed, 09 Sep 2026 01:11:59 -0700
Subject: [PATCH 1/4] mailmap: update Joel Selvaraj's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-update-email-address-v1-1-94a240f9469e@joelselvaraj.com>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
In-Reply-To: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788941524; l=809;
 i=foss@joelselvaraj.com; s=20260909; h=from:subject:message-id;
 bh=KfWlaqHF//2UprpPY6mCM27F9EEMcI/pUqHOiV1Fdas=;
 b=p/SvXrdgooOYa5zsVaumVxUoo5aRmok8IdVXXUmW4AzD8RpeKo+2oYqKgOXpGua/UBK/qz/3D
 8pnvjlJv3DpDaNRL4axKfjXKDt9atpvpWgoETCUh9H8hODxlzsCZZPy
X-Developer-Key: i=foss@joelselvaraj.com; a=ed25519;
 pk=UUJ1v4UQJ/nljqj3NjsWt5H4mphWQ7etpQ4Z7JiR2yo=
X-Endpoint-Received: by B4 Relay for foss@joelselvaraj.com/20260909 with
 auth_id=1018
X-Original-From: Joel Selvaraj <foss@joelselvaraj.com>
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
Reply-To: foss@joelselvaraj.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Joel Selvaraj <foss@joelselvaraj.com>

Map my old, no longer active, jsfamily.in address to my current one.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 742244a422c32..516c877ef9cf3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -458,6 +458,7 @@ Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
 Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
 Joe Damato <joe@dama.to> <jdamato@fastly.com>
 Joel Granados <joel.granados@kernel.org> <j.granados@samsung.com>
+Joel Selvaraj <foss@joelselvaraj.com> <jo@jsfamily.in>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>

-- 
2.55.0


