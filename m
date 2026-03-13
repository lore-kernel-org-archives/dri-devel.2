Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C600F107BCE2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 21:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC9310E478;
	Fri, 13 Mar 2026 21:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aJ45Z+p8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF02610E478
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ymBER8HSIKOy4GYGvCU8wc7GldMz6w6szaUs4uyzDmU=; b=aJ45Z+p8YILoXbdyF4TYKBZUfk
 EUmoX+F1fnRKw1fhEvldNfZ8pkY4N8kFwT9ZKcOe6dMwXL+mhEHRjRl4ud0lNbMRkbqhL4Ns3FXEr
 FC3W5080OmMSw8pdRS8arv8ljvy9DxiZpUmkbgzw+3aPfHkeUFkzrRbKk6EeN+FiSRCjVED3K8r8d
 Kjp+TpN77euosQupWcq2P8Wn2H59X6o5c1geQfPXsKyhfWp2t4Uk5mRvrSZZEV37XHbMEFnPe3W9x
 sNVbONewr/jt2I6RHq34Y92Kor+axQOCVe40Xsir0h3JCzNewgqAKUq13ZLvV4hkbnSvrec4SPQbf
 GcruG/9g==;
Received: from [189.7.87.203] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w19jK-00FRLG-4w; Fri, 13 Mar 2026 22:07:34 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 Iago Toral Quiroga <itoral@igalia.com>
Subject: Re: [PATCH v3 0/6] drm/v3d: Improve v3d_stats lifetime and locking
Date: Fri, 13 Mar 2026 18:07:11 -0300
Message-ID: <177343602669.283526.9116852968973430872.b4-ty@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-v3d-reset-locking-improv-v3-0-49864fe00692@igalia.com>
References: <20260306-v3d-reset-locking-improv-v3-0-49864fe00692@igalia.com>
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


On Fri, 06 Mar 2026 08:30:32 -0300, Maíra Canal wrote:
> This series aims to improve the `struct v3d_stats` lifetime management.
> The commit fa6a20c87470 ("drm/v3d: Address race-condition between per-fd
> GPU stats and fd release") addressed a race-condition between the per-fd
> GPU stats and the fd release by clearing `job->file_priv` before the V3D
> per-fd structure is freed and assuring that `job->file_priv` exists
> during the per-fd GPU stats updates.
> 
> [...]

Applied, thanks!

[1/6] drm/v3d: Handle error from drm_sched_entity_init()
      commit: 8cf1bec37b27846ad3169744c9f1a89a06dcb3fa
[2/6] drm/v3d: Use raw seqcount helpers instead of fighting with lockdep
      commit: 0b2a4569cd9fe56683be1aab9864032a8d267caa
[3/6] drm/v3d: Refcount v3d_stats
      commit: 266d4ba30d6a70c2574a302d49d54a1e4f595035
[4/6] drm/v3d: Hold v3d_stats references in each job
      commit: 745cc3f92a4b43606119b81d1f8bb1d1f5116049
[5/6] drm/v3d: Attach per-fd reset counters to v3d_stats
      commit: 2f0e110735a4e59e71e44d04b4f70e58f06c61c9
[6/6] drm/v3d: Remove dedicated fence_lock
      commit: 7315728ab5388bf4956835b20497332b1d45fe98

Best regards,
- Maíra
