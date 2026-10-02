Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0145ACA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B9510EB09;
	Sun,  4 Oct 2026 17:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="j43R8RGX";
	dkim-atps=neutral
Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com
 [74.125.229.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2814310F9FB
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:40:36 +0000 (UTC)
Received: by mail-dl2-f43.google.com with SMTP id
 a92af1059eb24-1460bcc512eso4951862c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790970035; x=1791574835;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6OS7kHnRAUFDH89g48qhMuuszS5BgPSQDnnJTJS0d4=;
 b=j43R8RGXPCtuTLg6uZoXrx4LmV5X6J07MtjEEy1sGQOz+lVd98U8GzXzKXrQhSgE2N
 5zbGJSPZOj8TGyhrtxJ6lb0bkRorXxOI1W6P2FKO8jBGFy3dDKu3qJtWoIAAwl7Qtdb5
 bJGYsZfNXOVrc8rdt9gx61Jgum04mBdQdlwYT7HYhJLKR3XUwUp8gidBTXLEwAQJjaFU
 sLnp8vKtyariFTaNrPF+1O6BxN3tt0Y5BtuS134wJbAgx+DeGk7vAqCdDvBDwu41eb8L
 zXA/W70FaLKP0+E56PgWEhJSsfNMqgbk+LGsDw2E1Nr/s/PADQov4KOsT6HapvQKN645
 uycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790970035; x=1791574835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6OS7kHnRAUFDH89g48qhMuuszS5BgPSQDnnJTJS0d4=;
 b=q1EhlEevakuwT1mks6ZWx5sB2vwnADg7De3GAKGywjcSQfH7vcSEl/RTuxtBP07bjn
 LKbZOyxltker9qvxVNibPW+6e3sKRNY/kpItGeWmHM5aQwdPL366M2BxYQvK/QKpJ1vL
 4AfyuiJ3xomM98kvr35VAglj1XW3NmWKBORxvmiCwq3gQ4ShfnarYela5ahSiZCuDTzk
 hFuFV/DMJMNFIAfLIXkrIiZj+yPrCtv+krTwO1gMGwiYSt2UwpA6x6LDcbDCvdTjTO9S
 RkKJutcFV1vR4kxFtDQhJWk4PFg9RAAlzRZXbsHhqeU7Id1pK7XMA/a76uxMkqZjsXAP
 iQYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+6wC2/wqQ2HPBuT4nbuVVycv3VJrCqDNojFT5RRbwyWzs3Fh+psTLycQ2rBsGM1JSuD24Cmxjgnw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMzEG+63bNDHeLdm2D2oP0ZTRUnqfe7rrX22/yTrOzcFtekleO
 PLCAj9SuMxI4zShHdrEcW5ktLv+++FcSl8tOuSXcdEt7JWLglPROM7RW07u+t53e1ds=
X-Gm-Gg: AYBFou1IiBjMi0YYfSIoYp876o01HgnbLYPY8QWeT36iCTs9+f8dY7s2MYsFArLCnaL
 6zxVcl1ojZY0XXFu87XW3NhHjPQgLVuXlzVMF/b2C/waxiG0gPRtSbtjj2eZWZ/R/XFXOgkRIOV
 R2lJ5ZLv54f1heejN4gPYM8VdDksu+DDUabRtmpuzTJYtw4xA7XGG4Yek1zsvZ3pcXlKAcjsmZu
 Dfhl+nYkBvhGa03n1tqQl1AwQ4b68LbE9gj853r91dKtlksX5Q0ZZr7JJWYU3J96AIL4R/2XwD8
 xegLIeCHJZ+O2bbsGwDaK6ZTmxil4VxFf44L4d025HDp3T0J8IG29NEQ+XI1bEXPL+l7nh7dBuM
 24TdVqGAYJ4gvnDAcVj4ehQs7LAQrlAyBPlu9t/xVVn0elmfGFbNxv+jJiHLGem0/LxanP+CF/0
 wLWibWUgewrY2OO3I0BOFHQY75qYtbamKjkmJLYRdUZgdnrYPhSjM37IdFZukclmPwDiruiQDAb
 XT+AYF1nMWs4IrzHlqFbQfYOkjyiTm3d08AEFqNcAozDamdrHyBi6YUIgeDPneL3Wf93modOcPB
 gPl3dw==
X-Received: by 2002:a05:701b:2610:b0:147:a685:9125 with SMTP id
 a92af1059eb24-14f58fd2a97mr3391373c88.2.1790970035055; 
 Fri, 02 Oct 2026 12:40:35 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f47a57592sm7450113c88.17.2026.10.02.12.40.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Oct 2026 12:40:34 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Suraj Kandpal <suraj.kandpal@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org
Subject: [PATCH 6.1.y 0/2] drm/i915/hdcp: guard both capability checks
Date: Fri,  2 Oct 2026 15:40:25 -0400
Message-ID: <20261002194030.20489-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

Hi Greg, Sasha, and i915 maintainers,

Patch 1 alone is not enough on 6.1.y: intel_hdcp_info() calls
intel_hdcp_capable() and then intel_hdcp2_capable(), so the debugfs NULL
dereference moves to the second call. Patch 2 is the companion fix that
path needs, a backport of upstream commit d34f4f058edf ("drm/i915/hdcp:
Add encoder check in hdcp2_get_capability") with the guard in the common
intel_hdcp2_capable() helper, where 6.1.y still does the lookup. This
mirrors the 2-patch series picked up for 6.6.y, and both fixes are
already present in 6.12.y, 6.18.y, and 7.2.y. Could you please queue both
patches for 6.1.y?

AI assistance: An LLM helped adapt and validate both patches; I reviewed
the resulting code and validation evidence.

Thanks,
Artem Dinaburg

Series:
  1. drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
  2. drm/i915/hdcp: Add encoder check in hdcp2_get_capability
