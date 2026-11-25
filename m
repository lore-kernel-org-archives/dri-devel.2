Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AD606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=EYKmg920
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4768B10E92E;
	Wed, 25 Nov 2026 15:50:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42CE10FD09
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Md1mn1cIcgLEFlOztbYbIzniAp4k7PMSGrOvyrhLyw0=; t=1795621806; x=2110981806; 
 b=EYKmg920MwlDDfFviVcF/Gun8wRP7TRKqC08Vd2FxMxzMMoO/ilYRBOlC+Wdev99fBREEQjOrGU
 DRyLG826eknqHTkTYZzsq2gXtepmasm2r9Frr/k5wBEXnTY+mSdy+PgdjQQac9Fc111N3RDRgcZ84
 j/OiyWy/hdP4pYcajBwN6Gixozhr0NMIBXj3zghu78nykZb2scavscMC0Jplbp/BE9Kko3IYugbJ1
 yl7RmMcPJQtzOV+w9zLbR6MuTqfM6zZ39/oJKREVf1U/krL1YSch0fUV950YPoum5u++NeG2Z55e4
 +Admg6i7MyrJL7NMCj0K9oOT6dW7vUKZb3yA==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWFFv-000000041TL-1gi4; Wed, 25 Nov 2026 16:49:59 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mwen@igalia.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 tvrtko.ursulin@igalia.com, Xiaolei Wang <wangxiaolei01@kaihong.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, itoral@igalia.com
Subject: Re: [PATCH v3] drm/v3d: Fix double free of query arrays on parse
 failure
Date: Wed, 25 Nov 2026 12:49:21 -0300
Message-ID: <179562174767.111946.7948063471631555838.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124113723.3055530-1-wangxiaolei01@kaihong.com>
References: <20261124113723.3055530-1-wangxiaolei01@kaihong.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Tue, 24 Nov 2026 11:37:23 +0000, Xiaolei Wang wrote:
> On a parse error the timestamp and performance parsers free the query
> array, and the job release path then frees it again: query_info->count
> had not been set yet, so no syncobj was put twice, but the stale array
> was handed to kvfree() a second time.
> 
> Make the job the only owner: the parsers just fill the array and record
> how far they got. count is set before the parse loop, the arrays are
> zero allocated, and the free helpers stop at the first entry that was
> never set up, which keeps put-count equal to find-count. That also
> removes the inline kvfree() of kperfmon_ids and the count arguments of
> the free helpers.
> 
> [...]

Applied to drm-misc-fixes with correct Fixes tags, thanks!

[1/1] drm/v3d: Fix double free of query arrays on parse failure
      commit: 1c986bc5918cbbb438eb57211c9d0b3de2878cd0

Best regards,
- Maíra
