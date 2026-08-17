Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC3C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B5610E09A;
	Mon, 17 Aug 2026 03:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="bj0WzZYj";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A862D10E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 03:04:58 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=VhQOgPnrvA2NCGRYj9xaU6hiFrMsO2rrZ8w8XHOrgSA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786935896; v=1; x=1787540696;
 b=bj0WzZYjk64NsnUsaceqjcAVLvvsIT12qfp32IcZMD0bxhv/Vk4yJzDKrred5wqq83w4xf49
 Rq0lBUeuRKzMUsiwSzDqFbKGtXxaLVutnz37SszrWXySgIjw7C7E9JXB/jCK/RuQ5KAcj7LwZVO
 EPLJ3bxPviwB7LrIzfvC2rHE=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from localhost (2408:84e1:426:d677:802:e2c9:7497:438a)
 by smtp.migadu.com with ESMTPS id 7923081ed4ac32bb;
 Mon, 17 Aug 2026 03:04:56 +0000
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: Add support for Novatek NT36532 panel
Date: Mon, 17 Aug 2026 00:03:47 -0500
Message-ID: <20260817050347.300538-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804073419.84727-1-junjie.cao@linux.dev>
References: <20260804073419.84727-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Gentle ping on this series.

Sorry, the "requires DPU support" wording in the cover is a leftover:
that support is already merged (ffa88de8ddb6, ce73a5db44e3) and part
of next-20260727, the base of this series.
