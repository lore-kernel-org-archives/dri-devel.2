Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5E3CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9719410F692;
	Thu,  1 Oct 2026 13:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aNcNF9dv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2597A10E400
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Jk7kPFnkcB7Y2YjTOf62F+TNdZP4VRuj5z17XO/XGr4=; b=aNcNF9dvUFNyXc7XpNt3rTxj6h
 oKV1g3Kj2RPrhfGOXJ2/dGK2rRtOPJGzxob0b94NJtHGV2tVhCxFANjQiHpzbiPJ7BmkgJ6C04EC3
 TAzeSTPBouvn72lCfQJMEOBbb+2nPsYGk1BpTtF04bpfoz0owxFfcfoPYJ62Rtkj0Uhfba7QvaZvs
 RC++U6T9ASqWEf+Nseb+2Q+EWMHWmqImNa3ezKMju15mdA5JvE1pkpzrNFZhV5zcBd2bBU5ao5/CJ
 X3cVs0xkzWcuyndFVrOlHEMHotN7ow9rJw/XqiF117Pbf2yZmLoxwxlo+bA6QlztcalM8mYSgkwB2
 9/0Jnv4Q==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCHAj-00A8Yn-Er; Thu, 01 Oct 2026 15:50:06 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 1/2] drm/vc4: Free the BO cache size list on teardown
Date: Thu,  1 Oct 2026 10:49:43 -0300
Message-ID: <179086258077.2787352.2984425234415415508.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930190721.1897264-1-mcanal@igalia.com>
References: <20260930190721.1897264-1-mcanal@igalia.com>
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


On Wed, 30 Sep 2026 16:06:50 -0300, Maíra Canal wrote:
> vc4_bo_cache_destroy() purges the cached BOs but never frees the size
> list, leaking it on every unbind.
> 
> 

Applied, thanks!

[1/2] drm/vc4: Free the BO cache size list on teardown
      commit: b41ff8b529278216cba22a5dcdc93fea2a3a9619
[2/2] drm/vc4: Use kvmalloc_objs() for the BO cache size list
      commit: bca45af5998a05f34b13a2ef11e639bac9c62643

Best regards,
- Maíra
