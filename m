Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DF60EEC06
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=kuwHeC99
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5698210F01A;
	Mon,  2 Nov 2026 15:37:24 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AF410F01A;
 Mon,  2 Nov 2026 15:37:18 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jJG6M3Gk6zKnFK;
 Mon, 02 Nov 2026 16:37:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793633835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxh/pNlJFx+QNt+QDC+RWZfjDJwK2dniC7Lb6a13yYM=;
 b=kuwHeC99ehmDz1LMDtVKPRWpVxDT6gsFx4Py+fJ72RBFUxVj0O4K/8WvfBeckPwrOL3fkz
 YjZrjQPqC/J4G+heq8+pUeu8xS5ES/3G/fCfTL1ubA7YW1F8DB4gzhBrDg8Zs3FXXTIrUU
 sGC0IEU9qbGBxKvPG5GWJxn+Fjhjm5avOSwBb5bAMLcCMaincSz3JSgkoHHnFC2Ohkycdj
 lFWBDgpYka4p0izzf5fJUamCtlS1mX3AqCXBCVUb4Hv5igb/X63jQeUauDdma9PaSrx0vg
 3pZY3AUbTxFAPrmV1rEGfeBmi/jjWdMz4J4EfcfqU1nU+PmgyctVJ9B2AFbT9g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Mon, 2 Nov 2026 15:37:14 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Mario Limonciello <superm1@kernel.org>, alexander.deucher@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com, harry.wentland@amd.com, alex.hung@amd.com,
 kees@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <1267219663.279946.1793633834409@app.mailbox.org>
In-Reply-To: <991e63e4-4230-40c0-a18f-6c0103bd225f@kernel.org>
References: <20261031153948.127016-1-hugo@hsal.es>
 <991e63e4-4230-40c0-a18f-6c0103bd225f@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Clamp the ATIF backlight curve to its 99
 points
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jJG6M3Gk6zKnFK
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026, Mario Limonciello wrote:
> I would like to know though; did you see this in the wild?  If so I'd
> like to hear more about the system that had it and the system firmware
> on it.

No, I haven't seen firmware do this. I found it by reading the code while
working on a series that does the intermediate calculations for the
ATIF curve at full precision, which I'll send soon

Thanks for the review,
Hugo
