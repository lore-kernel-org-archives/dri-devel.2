Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CA4C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630E910E1BC;
	Wed, 26 Aug 2026 16:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="mDt3knxV";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-248.mta1.migadu.com [95.215.58.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E0710E1BC
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:12:59 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=aaIy/JWf4/bmbw7l7z8p4NRNESraN0yL7jiyczaqgtY=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787760778; v=1; x=1788365578;
 b=mDt3knxVdU00zRRGc00ApbPQGWzsMZryTgAJbTuY4f41gOsl4qk4j70oNYEHRWDHPBVl/Anv
 OJDU3EnRoPsx3l93OvxwbhzeKVZX5lHg6InlFIRLFrwyAtk0QWOOWh57cRdLQ/Ik0nqr9ow1peY
 RrzmNFNkwzRozYhRZKYG5oaPK86Yg4jK/B0oI94CkCiy7iJPaZBp5svu6asKLUfjOZP7Vg2m8GI
 S8OqeME3wd/0LtIFTPySWGmeuE+pAJdZRoWhAqnb81YLIHtw9s5STvr6hU5z8wtsVPWXjdEdy0S
 f1NsaTUYD/0n5BEnzqQ1KTH3X77UvXJC6ZFQUcipwip1A==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 58f6b6f4dd8994c7;
 Wed, 26 Aug 2026 16:12:48 +0000
X-Mizu-Trace-ID: 58f6b6f4dd8994c7
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/amdxdna: make the debug BO command wait
 interruptible
Date: Wed, 26 Aug 2026 19:12:36 +0300
Message-ID: <20260826161236.172161-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826152126.CDEA11F000E9@smtp.kernel.org>
References: <20260826152126.CDEA11F000E9@smtp.kernel.org>
MIME-Version: 1.0
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

The desync is real. The early return skipped abo->assigned_hwctx, so a
command that firmware went on to complete could leave the BO attached in
firmware while the driver believed it unassigned, and DETACH is refused in
that state. v2 records the BO as attached when the wait is interrupted.

The premature-free path is not there. assigned_hwctx has three consumers --
the ATTACH guard, the DETACH guard, and the hwctx lookup in
amdxdna_hwctx_sync_debug_bo() -- and appears in no free or close path. The
debug BO is submitted as an argument BO, so the job holds a drm_gem_object
reference on it until the job is freed; its lifetime does not depend on
assigned_hwctx.

Taimuraz
