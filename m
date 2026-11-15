Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97370606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=1wLh0V/J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D7510E07A;
	Sun, 15 Nov 2026 15:32:13 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C3110E16C;
 Sun, 15 Nov 2026 15:32:07 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSFNN4BnMzKp2T;
 Sun, 15 Nov 2026 16:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1794756724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CQ75Fayc3WJJFoGR/c1sesoFpc6Olc8yaz6TvmvWC0=;
 b=1wLh0V/Ja/vn+KnKKRfSAVy06HI62NVm/4TImiNKPw1OxGG3CLLrkIZO8OdprPUkv6k5F/
 UOyhD65dsFcZlKzlFf+iaha6rF17hHDLfZZaNGAiFx+VhGSVUAtyNFlIX6KENbkWkIz8YZ
 udEqvSIB5PtJGsWUX+k9J9LrMDZTG8pqMFfAczUowODli+UUcVP7G5qxKU6XXKGGNYzNev
 Sp77T2Yn97heAYR42i+P8BSpnU25OwAQfD31bpl81vfCoDu2bMZAcNLn5cgjSasqgurMaz
 Ht/t+VWWMtaPSBBupRFABWUOGM0PuS8lMMVTTOW/O8Xdkb63qbHwsLKXeVy2BQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Sun, 15 Nov 2026 15:32:04 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Message-ID: <754837949.13288.1794756724156@app.mailbox.org>
In-Reply-To: <sashiko-outbox-213714@kernel.org>
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-4-5808d17a7e89@hsal.es>
 <sashiko-outbox-213714@kernel.org>
Subject: Re: [PATCH v2 4/5] drm/amd/display: Commit panel_power_savings
 writes from the kernel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jSFNN4BnMzKp2T
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

> On 11/13/2026 9:28 PM WET sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can this commit drop active overlay planes from DC when VRR is enabled on
> the CRTC?

This is the same bug as the one reported on 2/5. The fix there covers
this store too, because the store changes abm_level in the new
connector state, and v3 adds the CRTC's planes in atomic check for any
commit that does that

Hugo
