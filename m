Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05510CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C24110F341;
	Fri, 12 Jun 2026 08:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dl+syETQ";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D66410E995
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:00:03 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gcBkm0pDKz9t55;
 Fri, 12 Jun 2026 10:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781251200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tu0ZjW9Xgx1LubrO1TLWRXIk3JFRGek7dSMkI2UdP/E=;
 b=dl+syETQB6uKt6NRFVD2IMyAdQBp3MEKU3tyJ/kfOzORU9amlGdsDEREQyoxxRnZ1m7pEh
 EB8Wx/07Zb6L1OkLb3oBnfshZWXo/2a/h9FqLqaiXDozpbrPBfbQLK3SRvNF1t7EYhB0Yb
 BNxXq/DLdfNFkBlWJ7YT53FTJrQVTUuqGKNbbHIwRX7E5+SqfYCnxOrmyv5gPEVMtNseJX
 TruIpPNTuBBNcYjV1rJxTqEK51iYMmtna4TCc5vxQou1AB2Yz3lKzVCRYMIP3E5KbPVWzr
 uvSC1Bhe7OKtvVa/Kf/+GPD4wG3BxICVf8W/HDnGhAV5Ift9P+a4+yXvABJLsg==
Message-ID: <60339c2c-2627-4a98-92b7-2a6cc9a46a26@mailbox.org>
Date: Fri, 12 Jun 2026 09:59:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/todo: clarify drm_syncobj error TODOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: tvrtko.ursulin@igalia.com, dri-devel@lists.freedesktop.org
References: <20260601085132.683087-1-christian.koenig@amd.com>
 <5968fd48-f481-41d3-a9aa-1c6cccd2dbb6@amd.com>
Content-Language: de-CH-frami
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <5968fd48-f481-41d3-a9aa-1c6cccd2dbb6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tyypuf1rg894cmxawc5r68fu8j8q6sp7
X-MBO-RS-ID: a423f762f9d603726d6
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

On 6/12/26 09:54, Christian König wrote:
> Hi Michel,
> 
> any objection to adding your name here?

No,

Acked-by: Michel Dänzer <michel@daenzer.net>


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
