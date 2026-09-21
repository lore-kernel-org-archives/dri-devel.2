Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E04AC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3249D10E084;
	Mon, 21 Sep 2026 20:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZIlEf1vB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E9510E084
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=CSPJIsvNlMvdmn6uXKZViopTtoSgZJPrxMs/p+WHsnw=; b=ZIlEf1vBhG/BIYcOIMpcp2PaFV
 asP5GSsBbPrEGg5NVDwX42rXhiMB7bl3PVGpvtbp9SZtn1ocAv/jvAHVS542rj99/zsrldWoIAGDe
 9Vjjz0GLDNOaqKh90G/wVUMG/YWRKI/s2DCdIKu2xijEMwoPgvZPNRN7nt5IW1k6/Nn+sNpkpCWb8
 wC02JTIDNyDXN6n4yqJgLSy6nXzu+Rlz7tl2kicFPeldrNYyB/8aY+ifvqeMRcCjlO9dO/kS5DOrF
 pQ1L4sOZn94QybfY7K1dZsdMPQPEk/TKjfLxu2ywsHtNCPRwPvYG2G982xFr8r1JkL+/GmgVqFpcB
 4JJNDuAw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8kCs-005H41-T0; Mon, 21 Sep 2026 22:01:43 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mwen@igalia.com,
	Erick Karanja <karanja99erick@gmail.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Restrict v3d_perfmon_stop_locked() to
 v3d_perfmon.c
Date: Mon, 21 Sep 2026 17:00:15 -0300
Message-ID: <179002073423.3089763.10777877946256735963.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921190014.38231-1-karanja99erick@gmail.com>
References: <20260921190014.38231-1-karanja99erick@gmail.com>
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


On Mon, 21 Sep 2026 22:00:14 +0300, Erick Karanja wrote:
> v3d_perfmon_stop_locked() is only used within v3d_perfmon.c.
> Make the function file-local and remove its declaration from v3d_drv.h.
> 
> 

Applied with checkpatch fixes, thanks! Please, always verify for checkpatch
issues before submitting patches.

[1/1] drm/v3d: Restrict v3d_perfmon_stop_locked() to v3d_perfmon.c
      commit: 8ef59ee794076e2b58cff357b12de2ba5d441271

Best regards,
- Maíra
