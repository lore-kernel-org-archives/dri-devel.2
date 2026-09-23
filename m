Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D07C98308
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F63810EF60;
	Wed, 23 Sep 2026 07:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="G7Rg8/hP";
	dkim-atps=neutral
X-Greylist: delayed 386 seconds by postgrey-1.36 at gabe;
 Wed, 23 Sep 2026 05:38:33 UTC
Received: from mail-proxy25229.mail.163.com (mail-proxy25229.mail.163.com
 [103.129.252.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6597C10EEA9;
 Wed, 23 Sep 2026 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=W2
 h9gMcg8AIBxkjSH5hoPQoSv06aXDLkRFWvXIrAklo=; b=G7Rg8/hPAkOrjnoGki
 6Gguh1r3NR3gaU6yW2TaRV24ZfHv0isx4WgfmoZhfd6awLSG1pg3nzwckpRWZJ5O
 Inb624A+r7WukY5sdfRePr9s2Dt5suqZY0g4FbNF3HPU9oYtkriTAKT9EYxi1TZG
 ZlfHDXwTtqeSu+BwXRKkw6AmI=
Received: from fedora (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCXnEO_Y7NqRsm6Aw--.58379S2;
 Wed, 23 Sep 2026 13:29:36 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Xe/PTL eDP: panel vertically streaked since v7.2 - AS SDP sent with
 VRR disabled
Date: Wed, 23 Sep 2026 13:28:46 +0800
Message-ID: <20260923052846.22781-1-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgCXnEO_Y7NqRsm6Aw--.58379S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4DAw15AFW8uF1rCFy7trb_yoW8KF4kpr
 ZxWF9Y9w1DJr1S9F1xWr40qF1ruws7J3y3Gas5Gr9rZas8Ka4avrnayF4YvFy7X395u3Wj
 qrZ5Jr9Yka18X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2q2NUUUUU=
X-Originating-IP: [2001:250:20f:1:a533:cf01:13a0:45f8]
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6gGQ52qzY8FVFwAA3l
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

Hi,

A Panther Lake eDP panel is streaked with vertical bands from the first modeset
at boot on 7.2.x, and clean on 7.1.13. The only measurable difference I can find
is that the AS SDP is now programmed on a link that is not running VRR, and I
have confirmed that this is exactly the field the new predicate reads:

	drivers/gpu/drm/i915/display/intel_dp.c:3226 (v7.2.6; :3119 on mainline)
	return intel_vrr_possible(crtc_state);   /* was: crtc_state->vrr.enable */

with

	bool intel_vrr_possible(const struct intel_crtc_state *crtc_state)
	{
		return crtc_state->vrr.flipline;
	}

On this panel flipline is programmed for a fixed refresh rate as well, so the
predicate is non-zero with VRR off. All 34 of the fixed-refresh state dumps I
have, across 7.1.13, 7.2.4 and 7.2.6, read

	vrr: no, fixed rr: yes, vmin: 2016, vmax: 2016, flipline: 2016, pipeline full: 0, ...

including the runs where the VRR state itself was not stable.

I rebuilt only xe.ko from the 7.2.6 tree with that one line restored, signed it,
and loaded it in place of the distribution module. The streak is gone at the
first modeset. Same kernel, same firmware, same compositor, same panel - the
module is the only variable - and the loaded module is identified by build-id
rather than assumed, because vermagic matches for any build of the same kernel.

The full report, with the state dumps, log excerpts, the commit list and
everything that is still open, is the work item:

	https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252

The raw drm.debug=0xe logs and the source snapshots are attachments there, so I
am not attaching them here.

Two things I would rather state than leave to be found:

  - This removes the fixed-refresh trigger only. While VRR is actually active,
    crtc_state->vrr.enable is already true, so the change is a no-op on that
    path, and I have not isolated the VRR-active path in testing.

  - The non-determinism on suspend/resume is not explained by this. There is a
    #FIXME inside intel_dp_compute_as_sdp() saying that SDP/infoframe updates
    "aren't truly atomic, and with the new cdclk->tc clock crossing we may
    transiently send a corrupted packet if the update lands mid-transmission".
    That is my candidate, but it is a guess and I have not instrumented the
    window.

The patch follows as a separate mail, since it stands on its own.

Thanks,
Xizhe Tang

