Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D00C4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB1610E5B5;
	Sat, 18 Jul 2026 14:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QAUNZ4+L";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A574A10E5B5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=kI671y0iV0R8qextd7vEcyTOKp+Ug9QKlovCJmECPCU=; b=QAUNZ4+LqgfPamoPxMVsedI7Mn
 T+/VDJw3xlGv1F5UtV0wWmyRi1TnUcnUyyg/TzHVyRx0SwluU45IHDv/B48McK85IjHDCt/CyJwwx
 ERXuEjEX1s+rZuuFtP5orPFTsiXNiixj4fs2+e38B4RtOWn9Pv/AmNFTOLLGVQ8p4NMC5exJqdZLT
 Cvm7D1d2y3v6tHV0gL6S/GhzwS3Oz/BJ/dfXgi57K8FLOaFn8FVuugvEWnMSuzxKNexay8KNOx0ZR
 /NV/6bzGR8kImXZ0ZG41JmY3LbujPT2EZEoeqLmfHceiveBTq3qFocpfCm18KbuacR57IgarYM59+
 I+m+BDnQ==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wl6Op-00HTNQ-4M; Sat, 18 Jul 2026 16:52:19 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v4] drm/v3d: Associate BOs with every job that accesses
 them
Date: Sat, 18 Jul 2026 11:52:05 -0300
Message-ID: <178438632259.3078338.5551896457904304245.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710114734.2731000-1-mcanal@igalia.com>
References: <20260710114734.2731000-1-mcanal@igalia.com>
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


On Fri, 10 Jul 2026 08:43:27 -0300, Maíra Canal wrote:
> A submission can expand into a chain of jobs (e.g. bin + render + cache
> clean). Implicit synchronization in v3d_submit_lock_reservations() is gated
> on each job's bo[], but the BO list was only ever attached to the last job
> of the chain. When that last job is a trailing CACHE_CLEAN job, the job
> that actually consumes the BOs (that is, a RENDER or CSD job) was left with
> bo_count == 0 and picked up no implicit dependencies. It could therefore
> be dispatched to the hardware and read a BO while another context was still
> writing it, leading to data corruption.
> 
> [...]

Applied, thanks!

[1/1] drm/v3d: Associate BOs with every job that accesses them
      commit: fa98563ab00dbe62fcedfef6bdd34ded7a860d9f

Best regards,
- Maíra
