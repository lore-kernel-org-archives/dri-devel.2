Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCF606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Lw4UgPrd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FBA710EDF7;
	Mon,  2 Nov 2026 13:18:12 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD3710EDF7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=nCdlxFyOUKjMKgyfhhxeQD336etZ7vz26BUvkTR4bp4=; t=1793625486; x=2108985486; 
 b=Lw4UgPrdoJkPQcEdvh28EY9nHD0KNPbnN3/9+gBxn3FknnWWGY9qGNNk8nwChLYt20HDD006GGO
 0JC4UE+S90yae1deMOCL4pNqV9SqQIiH18KGuuKr7gcnqYPR91sZafe8qQMhg/IWd9IZ9IHReQr3H
 v7zrEdiHBlEXhzTPZE2r712ILCL+V0i3sXMMvmmgWwrJ4GODCQhG2lBiD+PdVzRhgP5Tc8l+yBhnp
 zQe/3bNcStzDZH/yDusHV9JSdhSF3tNSSQyuUbcmCAykVul9DQNvttqPngOBzb+drzPmbkzlsJsi+
 PBAyGrZcFyF7k45vuwXHZGKhdaURNTRMPUqA==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xNrvH-0009Ul-UN; Mon, 02 Nov 2026 14:18:04 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/v3d: Initialize timedout_batches when running a
 CSD job
Date: Mon,  2 Nov 2026 10:16:56 -0300
Message-ID: <179362541395.53188.8652440988836179813.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101125619.2465064-1-mcanal@igalia.com>
References: <20261101125619.2465064-1-mcanal@igalia.com>
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


On Sun, 01 Nov 2026 09:53:57 -0300, Maíra Canal wrote:
> v3d_csd_job_timedout() decides whether a compute job made progress by
> comparing CSD_CURRENT_CFG4, the number of batches the dispatcher still
> has to start, against the value saved at the previous timeout. That
> saved value is never initialized, so it is zero on the first timeout.
> 
> On V3D 7.1.6 and later, CFG4 counts down to zero once the dispatcher has
> started the last batch, but the dispatch keeps running until the batches
> in flight complete. If the first timeout fires in that window, the
> handler sees no change and resets the GPU while the job is about to
> complete. For example, this happens with long dispatches that only keep a
> single supergroup in flight.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/2] drm/v3d: Initialize timedout_batches when running a CSD job
      commit: 0afdbdd5b1af729108de8f893d179c3b99eac29d

I'll apply the second patch to drm-misc-next after the back merge.

Best regards,
- Maíra
