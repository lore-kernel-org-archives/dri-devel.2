Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=qnccTQVP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4841A10FCD7;
	Wed, 18 Nov 2026 13:47:22 +0000 (UTC)
X-Greylist: delayed 36480 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 13:41:49 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FD610E371;
 Wed, 18 Nov 2026 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1795009287;
 bh=Z/ONwmnRxmJlfxOWf1O7ZnguWs7jkhfBNvJhld8u8tA=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=qnccTQVPQYKAjn8Hd8S0Gf94gJZ1CMfzNM9ttEJr/G6YszPSbOia5wXUk/hDa1JMX
 FHWlBBaoZwFUll0rA0YGCxobv8EYChpdriDcqCpXRdciD62Mx55ubtjtxSlBFQZaQA
 LC1FrCntk0+vd187x9BXn4Izw5zEgcsRYWVpkG1I=
X-QQ-mid: zesmtpgz3t1795009286ta8c1c6a0
X-QQ-Originating-IP: aSpVeBmsJBlkEulbQQYGu8bom56cFHjww6RvOE6lsE8=
Received: from exmail.qq.com ( [14.155.219.48])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Nov 2026 21:41:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1006432374697517955
EX-QQ-RecipientCnt: 8
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 hanson.wang@ugreen.com
Subject: Re: [PATCH] drm/i915/bw: sync global BW after non-atomic plane disable
Date: Wed, 18 Nov 2026 21:41:19 +0800
Message-Id: <20261118134119.2648155-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-220061@kernel.org>
References: <sashiko-outbox-220061@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MjKQVE11soRgqUV8BimdQC4gsuhdFGMGqfslMSMZq34QCMHwna+/ZBGh
 vgPddKHdYPwG/4pMtyhOZmo5vtuXuyvzaIpp5buG2iZVAy3/cqt8/iIY+FWjZKZPDqq38k2
 MXqEW0IdQt0EbnSzuKJ5hvrJxIJAsKNT14V6o843iQwKxg77zzFZjaL86dUhAZuN/oxEERQ
 8j8LpMOisbw5gdXPdWd3Wif2kQG+lgDQap2fvtrceEKuWuyEpd9mCqCc5kkCTaUwt7bY2MM
 cbra8ZkU6I/b1S95A8elaVn3y98zwOahtiAMhZrHjpm+fJiKrXAFpObqwopyNGSYKKFs0Bt
 t/EEPUN4IK3tkZtyRwbMbZ+AZ1GB18EdEngkVVHM1kj7l7gwtoDPmc3d1WiZwDn+h0Rv3O5
 lpeWuywfxiX8B9vUPENZZlSeTKc0fIgjc9Ezzg3VPSUPGyKnklwjSCRnfpEtTjHRXQTM084
 t5DG6oN19f6jPsRmZ6BxO0NsGSjokmcD0it88y8t14DgBah8tzxnUnJPPbuNHEtMu66R6Wb
 50r7pZZiYqQO2TFjsyK+AiNOeQ4foU0pP9JuW/dvhKo7PWZmejnWEKLBodlT4KpvWR9PJz5
 gfeXtDP8VnL62ItvVmexDDTzRLFMobPvIHNyBm7msM0P70kxn5Cps74G4L7QjUnrYD6Bms0
 ZdRM/kNDtUTAGMauWvd0YFnumSX6YpCQYmH2kQvNdH7Z6jI2AJFapZSeirLfIu+aLj70lKu
 95+PvlJFsKx4iVC38I26lNU3hItDNChQX8Q2m+2GnckKaV7JbXOzTIaDPGEvxEaVfOJN+N8
 xsaiTrqVbCTUcPV1BP6TTbgP9Ju7C2ZqjHhUH0EilzJkhb8OmH+RHgvG2hNMDWJy0+D3c9R
 +6/ZyBQ90bDgTK7e+PIc18HFkrv6wfzWjlLgSoc+xAX47WlEc9bc3Iq4anWOSZu1Y5mZY3+
 aW+uD4McztGzqO74ALkSwWdkYn89G1eUPiCGOl22HO5DMyKWclbjKQZMBm8ln7hn6Z4Orxp
 +i+obflVlmT5171D87LGjXsPhhqbliw0zVmqDGyA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the review.

I retested the patched mainline kernel on the N5105 with KMS
debug logging enabled. The original DBUF sanitization path was
triggered: pipe B initially accounted for 196000 kB/s and one
plane, and the patch cleared that accounting after plane disable.

The subsequent full modeset enabled pipe A and disabled pipe B.
The KMS log explicitly shows pipe B's minimum CDCLK changing
from 24500 kHz to 0 kHz.

Post-boot inspection also confirmed that the per-CRTC and global
minima agree, and that dbuf_bw_min_cdclk is 9282 kHz, matching
the value recomputed from the current DBUF bandwidth state.

Thus, I did not observe persistent stale CDCLK minima on this
boot path. This does not rule out the plane-only disable case
where the CRTC remains enabled without a subsequent full modeset;
that case remains untested.

Thanks,
Hanson
