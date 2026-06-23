Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB1FCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665C610EBA2;
	Tue, 23 Jun 2026 14:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="kcIfk3Gg";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E96110EBA2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782226649; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NbZ+bL6v0Tozx+1QUM4AjoFeGrMnRqCWcbdQf3jYXFxjocZvplNhXU1C0roH9v/cvxTDzsMlSq56gUsUjtFZx5dgP9CZAwnRZf0zsInEwRxFpMqPA4wzzGu73dxmx+ajuTxSsZ8XAfWU7hl6wo+kiih+/hLVCHWHnjMHnplTcpU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782226649;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5b5OI2irkvLYQEv9wMcio1OLUaISh8As/ayLOr6vDk8=; 
 b=eGiWQf68J7EqQfR8ivxEHlp4lG/G64Vqj1rFIBCdUrBpcI26iF+ON1YYxk/9uM5zUZRLmIqrTZR8ZJ4O/iPbnUNTs2GzipW/3pEifdT/37qcUc7kFAqjGfmqvdJLUVmpnIms5RnAitReDL1jzPNKtC19SfmQrHwztu9XrxZcJ9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782226649; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=5b5OI2irkvLYQEv9wMcio1OLUaISh8As/ayLOr6vDk8=;
 b=kcIfk3GgEVqe2JrKeFM4tfM+nYBF01niy7SSCppcPawlhZ7UePhl5jWwUbroSTtc
 2Gujhi/POk31nCoV3AjGu8F28/6QPehq8dQn6Qjq5By7njxmKQIHo5vcC2+X6xiqkAE
 +9Q7rXQv4tV7f0X58LVVwJXlaoIdMCxD9vDWZQb0=
Received: by mx.zohomail.com with SMTPS id 178222664678959.54337212219389;
 Tue, 23 Jun 2026 07:57:26 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drm/panfrost: include panfrost_drv.h for
 panfrost_transparent_hugepage
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
References: <20260623104617.768289-1-ben.dooks@codethink.co.uk>
Date: Tue, 23 Jun 2026 15:57:15 +0100
Message-Id: <178222663552.3577656.14562644511808389347.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=274;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=GKdEVvbn8CXlZSfwDYZ57Ad4BxOA5+4sb0PtHJtWcsA=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqOp7Utc1wIsz7xK5utsRJoxaZFy01QGCbXPdOW
 5KOucGB/imJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajqe1AAKCRAOJn5M7lND
 PfAhDACpeofgtNee9UAZPchuXAAaTL5P519Rb6xdJwje5/xf63ouNzhm1hRXzHdnMOoQabqmyOl
 XPno8Sux7r329irZVPFS4ChoEJWfLiBIF6b0h/E6jGgXr3u9DdooLXmjaQsrgvXQnkTWGm8v8JY
 MS8ankW5uMF8bfUySKDc3m/0eLkXNEb0DQrZbhDGjbcsdtdm+aEP+TTXpqoH7vEIQhKOdC7/QF3
 b1Uta9vxoLnT0mD0Dl6Jmc8mUZL7BANsC7WJHS9sU09YuV0WXlEAAOU8FPccEgsHs9zdw2WoIra
 D2wgcX5eHdcMfkptK4u1aUJvQZFJ79mTpdzBbhHCJ/RMIE1D+Hht6GxVLd7qF6fH8QNH77o9joe
 j6L/IxQgmh0nXpZIknLbMX3uOivUGMdinVHDlXVfIRfGALq0WXQXtW9Tpup31krYRZOauUqaoP2
 8hnrm3QveASOvIofDDb7iQmOEzDPHvihex8RkFCmeQ4+P2a3mpu8q6Kp+0BBphlnCtuxQ=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On Tue, 23 Jun 2026 11:46:17 +0100, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> drm/panfrost: include panfrost_drv.h for panfrost_transparent_hugepage

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

-- 
Adrián Larumbe <adrian.larumbe@collabora.com>
