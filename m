Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16395606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BhSsgMOI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4019410FD69;
	Wed, 25 Nov 2026 16:01:05 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD56A10FD90
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:00:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 258864E41781;
 Wed, 25 Nov 2026 16:00:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E6ECA60480;
 Wed, 25 Nov 2026 16:00:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF85C11E6A266; Wed, 25 Nov 2026 17:00:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795622455; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=O2FhQ28BkwHMz0BlMN0lhmQRX/4NW+TVcvstggEiWjo=;
 b=BhSsgMOId9ds5R/JtaFW1SS+E0dKG0E6FYPhlLPf50JYFu4iZ2Z5cYMU3ZZHDd+dOJ+bFY
 A9ycPnjGWiHkUg5AiUc7/tKeUZLyOK05PQX7MSlYUqUeVp2gRnCZe/co1LZvSscga2XRab
 /6AV8PD/32kEIlWCXV/PLNQANhQvEo/f0yXzOOk0VRZdHMD27KSrkDjVAOzuhBwuGzSex/
 WiEIvNixDYuzwERPq0PsrVPOGChFrVEBaWs9NrYRaa1CDpbomEebFVB3klxnd8P055fe/Q
 kc+pzQVOVgp2TjMmflMbA6f1FU0vVhnxAobtGJJN00LpaS8efa1D9gJzMErB/g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org, 
 hamohammed.sa@gmail.com, harry.wentland@amd.com, 
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com, 
 mripard@kernel.org, pekka.paalanen@collabora.com, 
 robert.mader@collabora.com, simona@ffwll.ch, tzimmermann@suse.de, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
References: <20261106201813.129911-1-leandro.ribeiro@collabora.com>
Subject: Re: [PATCH v2 00/12] drm/vkms: improve color curve LUTs precision
Message-Id: <179562245064.2664231.526335218759807383.b4-ty@b4>
Date: Wed, 25 Nov 2026 17:00:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 06 Nov 2026 17:18:01 -0300, Leandro Ribeiro wrote:
> Currently VKMS only supports uniform LUTs. Besides the userspace
> provided LUTs, it also represents color curves with LUTs, as it can't
> simply implement the continuous curve formulas (floating-point would be
> required).
> 
> This adds support to represent color curves with non-uniform LUTs,
> improving the precision significantly. It also provides a script
> that can be used to create these LUTs.
> 
> [...]

Applied, thanks!

[01/12] drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
        commit: 41b1a8294e3696a219e74cf47cb6e135f0b83fbf
[02/12] vkms: properly compute gamma LUT size in vkms_atomic_check()
        commit: 812c119f486c91f5bcf2944cd4228f468e292fac
[03/12] drm/vkms: allow color curve LUTs to have different sizes
        commit: df3941f15e96a0f5f34d3b7ef8516f51be256e4d
[04/12] drm/vkms: remove TEST_LUT_SIZE
        commit: 16a9f629d75545541ba37f1f86b8c006e950f28a
[05/12] drm/vkms: remove linear_eotf
        commit: 3d4ec3afd6e1ecb494d886ac4aecf4ce7f6d17fa
[06/12] drm/vkms: improve the way in which we access LUT member
        commit: 801fe02d8d2a29c624804f6dec0bd880567af4f1
[07/12] drm/vkms: rename struct vkms_color_lut::base to y
        commit: 094024f659091ca8a3c5958b68533f179498b2ee
[08/12] drm/vkms: rename get_lut_index() to get_uniform_lut_index()
        commit: 27174eb6b985694913d188792d5f6f315f2c4b03
[09/12] drm/vkms: add support to non-uniform LUT for internal color curves
        commit: 978864c62a34b7057912b27221bdf1e2fedf4f56
[10/12] drm/vkms: test sRGB and inverse sRGB LUTs using more samples
        commit: 8564a537fc0391825c4827adb5be8618662c0778
[11/12] drm/vkms: add script to create optimized LUTs for color curves
        commit: e64f6256cd12388ce0ecc72ce78686fe2cc01191
[12/12] drm/vkms: replace uniform sRGB LUT and its inverse with optimal ones
        commit: 3c7c3c12dfc7704ca614abbfa266ca00a2b5a994

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>

