Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C4C98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 14:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F023410E047;
	Sat, 26 Sep 2026 14:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LXOCmzQS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC18410E047
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=JW51wsFy1A0rbfcAOKBAwrs5VuLl6snxykqG+tyAoyk=; b=LXOCmzQStatVVm7/KmsiT+oSUC
 ZkQaGdkNnVK+QMYNg4aN3cqoOgW7A7u48GYntMuatc0weYNYMwLwd1LBxGYC3ygjh1uUlJYnbkoHx
 SgkWl6zts2zt8bWhFqLexn75cDCmbV3v8hLOiZXGFvOD8ZdW7hIkJeDDzDjEVRjwC61UNnYoy/IJc
 +4gNR8mYa2C9CGG1YQqitkG/v8eWcTeeRYVA0Xs81AO0jxGOvCaAFj4vEvD1aOKYxBjEOzInWf0fj
 NcF0l1pJ/CkThyU4Gi654c99Fylq8b848BjP0a+JSSxrj6AeReKpdYK7KWmsH1ZsgpoBXspqzsUrd
 jeFz7yZw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xATKB-007dEi-2p; Sat, 26 Sep 2026 16:24:23 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: airlied@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 javierm@redhat.com, kernel-list@raspberrypi.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Sat, 26 Sep 2026 11:23:40 -0300
Message-ID: <179043261253.642825.11543928631039908274.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916154015.2056797-1-vulab@iscas.ac.cn>
References: <20260916154015.2056797-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Wed, 16 Sep 2026 15:40:15 +0000, Wentao Liang wrote:
> The firmware reference obtained via rpi_firmware_get() is leaked when
> aperture_remove_all_conflicting_devices() fails, as the error label
> returns without putting it. This happens before the firmware is
> consumed and put further down in the function.
> 
> Put the firmware reference before jumping to err.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
      commit: b816da5d5df1461446a0a5f3fe2b4948a659a790

Best regards,
- Maíra
