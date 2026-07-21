Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97453C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0E110E357;
	Tue, 21 Jul 2026 12:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ASoppT39";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B1010E357
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=yh3N54zLlz8BH1XRK2/9xSCC5x98Z1QaeABlZ/LsjWw=; b=ASoppT39WOgGBGgHWdkkvYQe4S
 cJgyLlbSl6I3xacjY5qv6/YFG/MZ3TDEDXQh1jv/Bv1hjP+/9pdzequpKIBhwr+3pCw6Ux55C62Dx
 oN+Qwdtz6Rl0xsqu+8drdNChRqE0jNiLDG4IpMdXAs6SpZg26+k/VoZ6MLvJKC5EjoXUVc5N6z1qy
 JFMnl4H2ALF/pa3y0BlkWPr2gds27JlpVHf/rE03+i4LP/cKGqg4XoDypipWPT/JnYZGA1LNZmLXU
 GEjBj71FkAFQqEp7wtvzl6E3VhFVX599EfedQ1Y/B3HOY0bsEFP2ZC33ZbhZJk8dqvr5Y0u3OiBIh
 3kCAipkA==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmA2w-001bms-DV; Tue, 21 Jul 2026 14:58:06 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Linmao Li <lilinmao@kylinos.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: Prevent shader BO mappings from becoming writable
Date: Tue, 21 Jul 2026 09:57:32 -0300
Message-ID: <178463864902.189636.14796217669170863767.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721011558.1672477-1-lilinmao@kylinos.cn>
References: <20260721011558.1672477-1-lilinmao@kylinos.cn>
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


On Tue, 21 Jul 2026 09:15:58 +0800, Linmao Li wrote:
> vc4_gem_object_mmap() rejects a writable mapping of a validated shader
> BO, but leaves VM_MAYWRITE set.  Userspace can map the BO read-only and
> then turn it writable with mprotect().
> 
> Validated shader BOs must stay read-only: the validator checks the
> instructions once and the GPU trusts them afterwards.  A writable
> mapping lets userspace rewrite the code after validation, bypassing the
> validator.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Prevent shader BO mappings from becoming writable
      commit: 0c9e6367639548307d3f578f6943ce72c9d39087

Best regards,
- Maíra
