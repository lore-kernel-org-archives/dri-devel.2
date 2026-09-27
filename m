Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3A8C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6567810E59B;
	Sun, 27 Sep 2026 12:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mg+P2rBt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9073B10E59B
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:16:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3DC960AAE;
 Sun, 27 Sep 2026 12:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B61F000FF;
 Sun, 27 Sep 2026 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790511363;
 bh=Egx/r2gOYtChgcJUWi8op+GbxM8/87DDt7EOAO4/m3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mg+P2rBt/lg5K6tdnb3vhDLw4RKPjDO9Y/atPRaQAS9/o+tNqC7T+3Z3Gje3Jet4p
 TEvhMU7nNMMVyC0wlvcucQ0UsOAakRnEi9OFXufld3o6Yv2LKHETjT2O2oXQTvMleC
 c5UjVwp1xZEDbxUV3PRCcUCGyHJIV+QG940J0jH56wiIrcjBmjpK201XVLdPjsD8cT
 NSlYTs2mRH4E8sU8KeuBmEujkeTVgYBZuZSoX0m+ATnCkfXr3Fdke7agPW/Kif1Jrp
 ihsz/IT/J/V1et9xL5si7YUMtZeqDBirT6Oku2AHgvNMLwPEMoFYQhKbACW6vi9p/F
 aFTAMt97KV32A==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] nova-core: align Bar0/Bar1 and remvove unnecessary Arc
Date: Sun, 27 Sep 2026 14:15:59 +0200
Message-ID: <20260927121559.1184691-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926124405.604707-1-dakr@kernel.org>
References: <20260926124405.604707-1-dakr@kernel.org>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 26 Sep 2026 14:43:23 +0200, Danilo Krummrich wrote:
> [PATCH 0/4] nova-core: align Bar0/Bar1 and remvove unnecessary Arc

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/4] gpu: nova-core: align Bar1 alias with Bar0
      commit: c0c5d21b466c
[2/4] gpu: nova-core: remove unnecessary Arc around BarUser
      commit: 224618807575
[3/4] gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess
      commit: 05e647ea4069

      [ Update stale comment in run_self_test(). - Danilo ]

[4/4] gpu: nova-core: mm: fix lifetime name in BarUser
      commit: bf91bd56fc46

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
